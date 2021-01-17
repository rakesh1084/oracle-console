--DO NOT CHANGE THIS FILE - IT IS GENERATED WITH THE BUILD SCRIPT src/build.js
set define on
set serveroutput on
set verify off
set feedback off
set linesize 120
set trimout on
set trimspool on
whenever sqlerror exit sql.sqlcode rollback

prompt ORACLE INSTRUMENTATION CONSOLE: CREATE DATABASE OBJECTS
prompt - Set compiler flags
DECLARE
  v_apex_installed VARCHAR2(5) := 'FALSE'; -- Do not change (is set dynamically).
  v_utils_public   VARCHAR2(5) := 'TRUE'; -- Make utilities public available (for testing or other usages).
BEGIN
  FOR i IN (SELECT 1
              FROM all_objects
             WHERE object_type = 'SYNONYM'
               AND object_name = 'APEX_EXPORT')
  LOOP
    v_apex_installed := 'TRUE';
  END LOOP;

  -- Show unset compiler flags as errors (results for example in errors like "PLW-06003: unknown inquiry directive '$$UTILS_PUBLIC'")
  EXECUTE IMMEDIATE 'alter session set plsql_warnings = ''ENABLE:6003''';
  -- Finally set compiler flags
  EXECUTE IMMEDIATE 'alter session set plsql_ccflags = '''
    || 'APEX_INSTALLED:' || v_apex_installed || ','
    || 'UTILS_PUBLIC:'   || v_utils_public   || '''';
END;
/

--FOR DEVELOPMENT ONLY - UNCOMMENT THE NEXT TWO LINES TEMPORARELY WHEN YOU NEED IT
--begin for i in (select 1 from user_tables where table_name = 'CONSOLE_LOGS') loop execute immediate 'drop table console_logs purge'; end loop; end;
--/

declare
  v_table_name        varchar2(  30 char) := 'CONSOLE_LOGS';
  v_index_column_list varchar2(1000 char) := 'LOG_TIME, LOG_LEVEL';
  v_count             pls_integer;
begin

  --create table
  select count(*) into v_count from user_tables where table_name = v_table_name;
  if v_count = 0 then
    dbms_output.put_line('- Table ' || v_table_name || ' not found, run creation command');
    execute immediate replace(q'{
      create table #TABLE_NAME# (
        log_id             integer                                               generated by default on null as identity,
        log_time           timestamp with local time zone  default systimestamp  not null  ,
        log_level          integer                                                         ,
        message            clob                                                            ,
        call_stack         varchar2(2000 char)                                             ,
        module             varchar2(  64 char)                                             ,
        action             varchar2(  64 char)                                             ,
        client_info        varchar2(  64 char)                                             ,
        session_user       varchar2(  32 char)                                             ,
        unique_session_id  varchar2(  16 char)                                             ,
        client_identifier  varchar2(  64 char)                                             ,
        ip_address         varchar2(  32 char)                                             ,
        host               varchar2(  64 char)                                             ,
        os_user            varchar2(  64 char)                                             ,
        os_user_agent      varchar2( 200 char)                                             ,
        instance           integer                                                         ,
        instance_name      varchar2(  32 char)                                             ,
        service_name       varchar2(  64 char)                                             ,
        sid                integer                                                         ,
        sessionid          varchar2(  64 char)                                             ,
        --
        constraint #TABLE_NAME#_check_level check (log_level in (0,1,2,3,4))
      )
    }','#TABLE_NAME#', v_table_name);
  else
    dbms_output.put_line('- Table ' || v_table_name || ' found, no action required');
  end if;

  --create index
  with t as (
    select listagg(column_name, ', ') within group(order by column_position) as index_column_list
      from user_ind_columns
     where table_name = v_table_name
  )
  select count(*)
    into v_count
    from t
   where index_column_list = v_index_column_list;
  if v_count = 0 then
    dbms_output.put_line('- Index for column list ' || v_index_column_list || ' not found, run creation command');
    execute immediate replace(replace('
      create index #TABLE_NAME#_ix on #TABLE_NAME# (#INDEX_COLUMN_LIST#)
    ',
    '#TABLE_NAME#',        v_table_name),
    '#INDEX_COLUMN_LIST#', v_index_column_list);
  else
    dbms_output.put_line('- Index for column list ' || v_index_column_list || ' found, no action required');
  end if;

end;
/

comment on table console_logs                    is 'Table for log entries of the package CONSOLE. Column names are mostly driven by the attribute names of SYS_CONTEXT(''USERENV'') and DBMS_SESSION for easier mapping and clearer context.';
comment on column console_logs.log_id            is 'Primary key based on a sequence.';
comment on column console_logs.log_time          is 'Log entry timestamp.';
comment on column console_logs.log_level         is 'Log entry level. Can be 0 (permanent), 1 (error), 2 (warning), 3 (info) or 4 (verbose).';
comment on column console_logs.action            is 'The action/position in the module (application name). Can be set through the DBMS_APPLICATION_INFO package or OCI.';
comment on column console_logs.message           is 'The log message.';
comment on column console_logs.call_stack        is 'The call_stack. Will only be provided on log level 1 (call of console.error) or on demand by providing p_trace => true to the other logging methods.';
comment on column console_logs.module            is 'The application name (module). Can be set by an application using the DBMS_APPLICATION_INFO package or OCI.';
comment on column console_logs.client_info       is 'The client information. Can be set by an application using the DBMS_APPLICATION_INFO package or OCI.';
comment on column console_logs.session_user      is 'The name of the session user (the user who logged on). This may change during the duration of a database session as Real Application Security sessions are attached or detached. For enterprise users, returns the schema. For other users, returns the database user name. If a Real Application Security session is currently attached to the database session, returns user XS$NULL.';
comment on column console_logs.unique_session_id is 'An identifier that is unique for all sessions currently connected to the database. Provided by DBMS_SESSION.UNIQUE_SESSION_ID. Is constructed by sid, serial# and inst_id from (g)v$session (undocumented, there is no official way to construct this ID by yourself, but we need to do this to identify a session).';
comment on column console_logs.client_identifier is 'The client identifier. Can be set by an application using the DBMS_SESSION.SET_IDENTIFIER procedure, the OCI attribute OCI_ATTR_CLIENT_IDENTIFIER, or Oracle Dynamic Monitoring Service (DMS). This attribute is used by various database components to identify lightweight application users who authenticate as the same database user.';
comment on column console_logs.ip_address        is 'IP address of the machine from which the client is connected. If the client and server are on the same machine and the connection uses IPv6 addressing, then it is set to ::1.';
comment on column console_logs.host              is 'Name of the host machine from which the client is connected.';
comment on column console_logs.os_user           is 'Operating system user name of the client process that initiated the database session.';
comment on column console_logs.os_user_agent     is 'Operating system user agent (web browser engine). This information will only be available, if we overwrite the console.error method of the client browser and bring these errors back to the server. For APEX we will have a plug-in in the future to do this.';
comment on column console_logs.instance          is 'The instance identification number of the current instance.';
comment on column console_logs.instance_name     is 'The name of the instance.';
comment on column console_logs.service_name      is 'The name of the service to which a given session is connected.';
comment on column console_logs.sid               is 'The session ID. Is not unique, the same id can be shown on different instances, which are different sessions.';
comment on column console_logs.sessionid         is 'The auditing session identifier. You cannot use this attribute in distributed SQL statements.';




prompt - Package CONSOLE (spec)
create or replace package console authid definer is

c_name    constant varchar2(30 char) := 'Oracle Instrumentation Console';
c_version constant varchar2(10 char) := '0.2.0';
c_url     constant varchar2(40 char) := 'https://github.com/ogobrecht/console';
c_license constant varchar2(10 char) := 'MIT';
c_author  constant varchar2(20 char) := 'Ottmar Gobrecht';

c_level_permanent constant integer := 0;
c_level_error     constant integer := 1;
c_level_warning   constant integer := 2;
c_level_info      constant integer := 3;
c_level_verbose   constant integer := 4;


/**

Oracle Instrumentation Console
==============================

An instrumentation tool for Oracle developers. Save to install on production and
mostly API compatible with the [JavaScript
console](https://developers.google.com/web/tools/chrome-devtools/console/api).

DEPENDENCIES

Oracle DB >= 18.x??? will mainly depend on the call stack facilities of the
release, we will see...

INSTALLATION

- Download the [latest
  version](https://github.com/ogobrecht/oracle-instrumentation-console/releases/latest)
  and unzip it or clone the repository
- Go into the project subdirectory named install and use SQL*Plus (or another
  tool which can run SQL scripts)

The installation itself is splitted into two mandatory and two optional steps:

1. Create a context with a privileged user
    - `create_context.sql`
    - Maybe your DBA needs to do that for you once
2. Install the tool itself in your desired target schema
    - `create_console_objects.sql`
    - User needs the rights to create a package, a table and views
    - Do this step on every new release of the tool
3. Optional: When installed in a central tools schema you may want to grant
   execute rights on the package and select rights on the views to public or
   other schemas
    - `grant_rights_to_client_schema.sql`
4. Optional: When you want to use it in another schema you may want to create
   synonyms there for easier access
    - `create_synonyms_in_client_schema.sql`

UNINSTALLATION

Hopefully you will never need this...

FIXME: Create uninstall scripts

**/


--------------------------------------------------------------------------------
-- CONSTANTS, TYPES
--------------------------------------------------------------------------------


--------------------------------------------------------------------------------
-- PUBLIC CONSOLE METHODS
--------------------------------------------------------------------------------
procedure permanent (
  p_message    clob,
  p_trace      boolean  default false,
  p_user_agent varchar2 default null
);
/**

Log a message with the level 0 (permanent). These messages will not be deleted
on cleanup.

**/

procedure error (
  p_message    clob     default null,
  p_trace      boolean  default true,
  p_user_agent varchar2 default null
);
/**

Log a message with the level 1 (error) and call also `console.clear` to reset
the session action attribute.

**/

procedure warn (
  p_message    clob,
  p_trace      boolean  default false,
  p_user_agent varchar2 default null
);
/**

Log a message with the level 2 (warning).

**/

procedure info(
  p_message    clob,
  p_trace      boolean  default false,
  p_user_agent varchar2 default null
);
/**

Log a message with the level 3 (info).

**/

procedure log(
  p_message    clob,
  p_trace      boolean  default false,
  p_user_agent varchar2 default null
);
/**

Log a message with the level 3 (info).

**/

procedure debug (
  p_message    clob,
  p_trace      boolean  default false,
  p_user_agent varchar2 default null
);
/**

Log a message with the level 4 (verbose).

**/

procedure trace(
  p_message    clob     default null,
  p_user_agent varchar2 default null
);
/**

Logs a call stack with the level 3 (info).

**/

procedure assert(
  p_expression in boolean,
  p_message    in varchar2
);
/**

If the given expression evaluates to false an error is raised with the given message.

EXAMPLE

```sql
begin
  console.assert(5 < 3, 'test assertion');
exception
  when others then
    console.error('something went wrong');
    raise;
end;
{{/}}
```

**/

--------------------------------------------------------------------------------

procedure action(
  p_action varchar2
);
/**

An alias for dbms_application_info.set_action.

Use the given action to set the session action attribute (in memory operation,
does not log anything). This attribute is then visible in the system session
views, the user environment and will be logged within all console logging
methods.

When you set the action attribute with `console.action` you should also reset it
when you have finished your work to prevent wrong info in the system and your
logging for subsequent method calls.

The action is automatically cleared in the method `console.error`.

EXAMPLE

```sql
begin
  console.action('My process/task');
  -- do your stuff here...
  console.action(null);
exception
  when others then
    console.error('something went wrong'); --also clears action
    raise;
end;
{{/}}
```

**/


--------------------------------------------------------------------------------

procedure init(
  p_session  varchar2 default dbms_session.unique_session_id, -- client_identifier or unique_session_id
  p_level    integer  default c_level_info,                   -- 2 (warning), 3 (info) or 4 (verbose)
  p_duration integer  default 60                               -- duration in minutes
);
/**

Starts the logging for a specific session.

To avoid spoiling the context with very long input the p_session parameter is
truncated after 64 characters before using it.

EXAMPLES

```sql
-- dive into your own session
exec console.init(dbms_session.unique_session_id);

-- debug an APEX session
exec console.init('APEX:8805903776765', console.c_level_verbose, 90);

-- debug another session identified by sid and serial
begin
  console.init(
    p_session  => console.get_unique_session_id(
                    p_sid     => 33312,
                    p_serial  => 4920
                  ),
    p_level    => console.c_level_verbose,
    p_duration => 15
  );
end;
{{/}}
```

**/

--------------------------------------------------------------------------------

procedure clear(
  p_session  varchar2 default dbms_session.unique_session_id -- client_identifier or unique_session_id
);
/**

Stops the logging for a specific session and clears the info in the global
context for it.

Please note that we always log the levels errors and permanent to keep a record
of things that are going wrong.

EXAMPLE

```sql
begin
  console.('My process/task');

  -- your stuff here...

  console.clear;
exception
  when others then
    console.error('something went wrong'); -- calls also console.clear
    raise;
end;
{{/}}
```

**/

--------------------------------------------------------------------------------
-- PUBLIC HELPER METHODS
--------------------------------------------------------------------------------

function get_unique_session_id
  return varchar2;
/**

Get the unique session id for debugging of the own session.

Returns the ID provided by DBMS_SESSION.UNIQUE_SESSION_ID.

**/

--------------------------------------------------------------------------------

function get_unique_session_id (
  p_sid     integer,
  p_serial  integer,
  p_inst_id integer default 1
) return varchar2;
/**

Get the unique session id for debugging of another session.

Calculates the ID out of three parameters:

```sql
v_session_id := ltrim(to_char(p_sid,     '000x'))
             || ltrim(to_char(p_serial,  '000x'))
             || ltrim(to_char(p_inst_id, '0000'));
```

This method to calculate the unique session ID is not documented by Oracle. It
seems to work, but we have no guarantee, that it is working forever or under all
circumstances.

The first two parts seems to work, the part three for the inst_id is only a
guess and should work fine from zero to nine. But above I have no experience.
Does anybody have a RAC running with more then nine instances? Please let me
know - maybe I need to calculate here also with a hex format mask...

Hint: When checking in a session, if the logging is enabled or when we create a
log entry, we always use DBMS_SESSION.UNIQUE_SESSION_ID. All the helper methods
here to calculate the unique session id are only existing for the purpose to
start the logging of another session and to set the global context in a way the
targeted session can compare against with with DBMS_SESSION.UNIQUE_SESSION_ID or
SYS_CONTEXT('USERENV','CLIENT_IDENTIFIER'). Unfortunately the unique session id
is not provided in the (g)v$session views (the client_identifier is) - so we
need to calculate it by ourselfes. It is worth to note that the schema were the
console package is installed does not need any higher privileges and does
therefore not read from the (g)v$session view. In other words: When you want to
debug another session you need to have a way to find the target session - for
APEX this is easy - the client identifier is set by APEX and can be calculated
by looking at your session id in the browser URL. For a specific, non shared
session you can use the (g)v$session view to calculate the unique session ID by
providing at least sid and serial.

**/

--------------------------------------------------------------------------------

function get_sid_serial_inst_id (
  p_unique_session_id varchar2
) return varchar2;
/**

Calculates the sid, serial and inst_id out of a unique session ID as it is
provided by DBMS_SESSION.UNIQUE_SESSION_ID.

Is for informational purposes and to map a recent log entry back to a maybe
running session.

The same as with `get_unique_session_id`: I have no idea if the calculation is
correct. It works currently and is implementes in this way:

```sql
v_sid_serial_inst_id :=
     to_char(to_number(substr(p_unique_session_id, 1, 4), '000x')) || ', '
  || to_char(to_number(substr(p_unique_session_id, 5, 4), '000x')) || ', '
  || to_char(to_number(substr(p_unique_session_id, 9, 4), '0000'));
```

**/

--------------------------------------------------------------------------------

function get_call_stack return varchar2;
/**

Gets the current call stack and if an error was raised also the error stack and
the error backtrace. Is used internally by the console methods error and trace
and also, if you set on other console methods the parameter p_trace to true.

The console package itself is excluded from the trace as you normally would
trace you business logic and not your instrumentation code.

```sql
set serveroutput on
begin
  dbms_output.put_line(console.get_call_stack);
end;
{{/}}
```

The code above will output `- Call Stack: __anonymous_block (2)`

**/

--------------------------------------------------------------------------------
-- INTERNAL UTILITIES (only visible when ccflag `utils_public` is set to true)
--------------------------------------------------------------------------------

$if $$utils_public $then

procedure create_entry (
  p_level      integer,
  p_message    clob,
  p_trace      boolean,
  p_user_agent varchar2
);

function logging_enabled(
  p_session varchar2,
  p_level   integer
) return boolean;

function get_context return varchar2;

procedure set_context(p_value varchar2);

procedure clear_context;


$end

end console;
/

prompt - Package CONSOLE (body)
create or replace package body console is

--------------------------------------------------------------------------------
-- CONSTANTS, TYPES, GLOBALS
--------------------------------------------------------------------------------

c_tab               constant varchar2 ( 1 byte) := chr(9);
c_cr                constant varchar2 ( 1 byte) := chr(13);
c_lf                constant varchar2 ( 1 byte) := chr(10);
c_crlf              constant varchar2 ( 2 byte) := chr(13) || chr(10);
c_sep               constant varchar2 ( 1 byte) := ',';
c_at                constant varchar2 ( 1 byte) := '@';
c_hash              constant varchar2 ( 1 byte) := '#';
c_slash             constant varchar2 ( 1 byte) := '/';
c_anon_block_ora    constant varchar2 (20 byte) := '__anonymous_block';
c_anonymous_block   constant varchar2 (20 byte) := 'anonymous_block';
c_context_namespace constant varchar2(30 byte) := $$plsql_unit || '_' || substr(user, 1, 30 - length($$plsql_unit));
c_context_attribute constant varchar2(30 byte) := 'CONSOLE_CONFIGURATION';
c_date_format       constant varchar2(16 byte) := 'yyyymmddhh24miss';
c_vc_max_size       constant pls_integer        := 32767;

subtype vc16    is varchar2 (   16 char);
subtype vc32    is varchar2 (   32 char);
subtype vc64    is varchar2 (   64 char);
subtype vc128   is varchar2 (  128 char);
subtype vc255   is varchar2 (  255 char);
subtype vc500   is varchar2 (  500 char);
subtype vc1000  is varchar2 ( 1000 char);
subtype vc2000  is varchar2 ( 2000 char);
subtype vc4000  is varchar2 ( 4000 char);
subtype vc_max  is varchar2 (32767 char);

--------------------------------------------------------------------------------
-- PRIVATE METHODS (forward declarations)
--------------------------------------------------------------------------------

$if not $$utils_public $then

procedure create_entry (
  p_level      integer,
  p_message    clob,
  p_trace      boolean,
  p_user_agent varchar2
);

function logging_enabled(
  p_session varchar2,
  p_level   integer
) return boolean;

function get_context return varchar2;

procedure set_context(p_value varchar2);

procedure clear_context;

$end

--------------------------------------------------------------------------------
-- PUBLIC CONSOLE METHODS
--------------------------------------------------------------------------------

procedure permanent (
  p_message    clob,
  p_trace      boolean  default false,
  p_user_agent varchar2 default null
) is
begin
  create_entry (
    p_level      => c_level_permanent,
    p_message    => p_message,
    p_trace      => p_trace,
    p_user_agent => p_user_agent);
end permanent;

--------------------------------------------------------------------------------

procedure error (
  p_message    clob     default null,
  p_trace      boolean  default true,
  p_user_agent varchar2 default null
) is
begin
  create_entry (
    p_level      => c_level_error,
    p_message    => p_message,
    p_trace      => p_trace,
    p_user_agent => p_user_agent);
  dbms_application_info.set_action(null);
end error;

--------------------------------------------------------------------------------

procedure warn (
  p_message    clob,
  p_trace      boolean  default false,
  p_user_agent varchar2 default null
) is
begin
  create_entry (
    p_level      => c_level_warning,
    p_message    => p_message,
    p_trace      => p_trace,
    p_user_agent => p_user_agent);
end warn;

--------------------------------------------------------------------------------

procedure info (
  p_message    clob,
  p_trace      boolean  default false,
  p_user_agent varchar2 default null
) is
begin
  create_entry (
    p_level      => c_level_info,
    p_message    => p_message,
    p_trace      => p_trace,
    p_user_agent => p_user_agent);
end info;

--------------------------------------------------------------------------------

procedure log (
  p_message    clob,
  p_trace      boolean  default false,
  p_user_agent varchar2 default null
) is
begin
  create_entry (
    p_level      => c_level_info,
    p_message    => p_message,
    p_trace      => p_trace,
    p_user_agent => p_user_agent);
end log;

--------------------------------------------------------------------------------

procedure debug (
  p_message    clob,
  p_trace      boolean  default false,
  p_user_agent varchar2 default null
) is
begin
  create_entry (
    p_level      => c_level_verbose,
    p_message    => p_message,
    p_trace      => p_trace,
    p_user_agent => p_user_agent);
end debug;

--------------------------------------------------------------------------------

procedure trace(
  p_message    clob     default null,
  p_user_agent varchar2 default null
) is
begin
  create_entry (
    p_level      => c_level_info,
    p_message    => nvl(p_message, 'console.trace()'),
    p_trace      => true,
    p_user_agent => p_user_agent);
end trace;

--------------------------------------------------------------------------------

procedure assert(
  p_expression in boolean,
  p_message    in varchar2
) is
begin
  if not p_expression then
    raise_application_error(-20000, p_message);
  end if;
end assert;

--------------------------------------------------------------------------------

procedure action(
  p_action varchar2
) is
begin
  dbms_application_info.set_action(p_action);
end action;

--------------------------------------------------------------------------------

procedure init(
  p_session  varchar2 default dbms_session.unique_session_id,
  p_level    integer  default c_level_info,
  p_duration integer  default 60
) is
  v_session vc64 := substr(p_session, 1, 64);
  v_context vc4000;
begin
  if p_level not in (2, 3, 4) then
    raise_application_error(-20000,
      'Level needs to be 2 (warning), 3 (info) or 4 (verbose). Level 1 (error) and 0 (permanent) are always logged without a call to the init method.');
  elsif p_duration < 1 then
    raise_application_error(-20000,
      'Duration needs to be greater or equal 1 (minute).');
  else
    v_context := sys_context(c_context_namespace, c_context_attribute);
    if instr(v_context, p_session) > 0 then
      null; -- FIXME implement edit of session
    else
      set_context (v_context
        || v_session || c_sep || to_char(p_level) || c_sep
        || to_char(sysdate + 1/24/60 * p_duration, c_date_format) || c_lf
      );
    end if;
  end if;
end init;

--------------------------------------------------------------------------------

procedure clear(
  p_session  varchar2 default dbms_session.unique_session_id -- client_identifier or unique_session_id
) is
begin
  null;
end;

--------------------------------------------------------------------------------
-- PUBLIC HELPER METHODS
--------------------------------------------------------------------------------

/*

Some Useful Links
-----------------

- [DBMS_SESSION: Managing Sessions From a Connection Pool in Oracle
  Databases](https://oracle-base.com/articles/misc/dbms_session)


*/

function get_unique_session_id return varchar2 is
begin
  return dbms_session.unique_session_id;
end get_unique_session_id;

--------------------------------------------------------------------------------

function get_unique_session_id (
  p_sid     integer,
  p_serial  integer,
  p_inst_id integer default 1) return varchar2
is
  v_inst_id integer;
  v_return  vc16;
begin
  v_inst_id := coalesce(p_inst_id, 1); -- param default 1 does not mean the user cannot provide null ;-)
  if p_sid is null or p_serial is null then
    raise_application_error (
      -20000,
      'You need to specify at least p_sid and p_serial to calculate a unique session ID.');
  else
    v_return := ltrim(to_char(p_sid,     '000x'))
             || ltrim(to_char(p_serial,  '000x'))
             || ltrim(to_char(v_inst_id, '0000'));
  end if;
  return v_return;
end get_unique_session_id;

--------------------------------------------------------------------------------

function get_sid_serial_inst_id (p_unique_session_id varchar2) return varchar2 is
  v_return vc32;
begin
  if p_unique_session_id is null then
    raise_application_error (
      -20000,
      'You need to specify p_unique_session_id to calculate the sid, serial and host_id.');
  elsif length(p_unique_session_id) != 12 then
    raise_application_error (
      -20000,
      'We use here typically a 12 character long unique session identifier like it is provided by DBMS_SESSION.UNIQUE_SESSION_ID.');
  else
    v_return := to_char(to_number(substr(p_unique_session_id, 1, 4), '000x')) || ', '
             || to_char(to_number(substr(p_unique_session_id, 5, 4), '000x')) || ', '
             || to_char(to_number(substr(p_unique_session_id, 9, 4), '0000'));
  end if;
  return v_return;
end get_sid_serial_inst_id;

--------------------------------------------------------------------------------

function get_call_stack return varchar2 is
  v_return     vc_max;
  v_subprogram vc_max;
begin

  if utl_call_stack.error_depth > 0 then
    v_return := v_return || '- ERROR STACK' || chr (10);
    for i in 1 .. utl_call_stack.error_depth
    loop
      v_return := v_return
        || '  - ORA-'
        || trim(to_char(utl_call_stack.error_number(i), '00009')) || ' '
        || utl_call_stack.error_msg(i)
        || chr (10);
    end loop;
  end if;

  if utl_call_stack.backtrace_depth > 0 then
    v_return := v_return || '- ERROR BACKTRACE' || chr (10);
    for i in 1 .. utl_call_stack.backtrace_depth
    loop
      v_return := v_return
        || '  - '
        || coalesce(utl_call_stack.backtrace_unit(i), c_anonymous_block)
        || ', line ' || utl_call_stack.backtrace_line(i)
        || chr (10);
    end loop;
  end if;

  if utl_call_stack.dynamic_depth > 0 then
    v_return := v_return || '- CALL STACK' || chr (10);
    --ignore 1, is always this function (get_call_stack) itself
    for i in 2 .. utl_call_stack.dynamic_depth
    loop
      --the replace changes `__anonymous_block` to `anonymous_block`
      v_subprogram := replace(
        utl_call_stack.concatenate_subprogram(utl_call_stack.subprogram(i)),
        c_anon_block_ora,
        c_anonymous_block
      );
      --exclude console package from the call stack
      if instr(upper(v_subprogram), upper($$plsql_unit)||'.') = 0 then
        v_return := v_return
          || '  - '
          || case when utl_call_stack.owner(i) is not null then utl_call_stack.owner(i) || '.' end
          || v_subprogram || ', line ' || utl_call_stack.unit_line (i)
          || chr (10);
      end if;
    end loop;
  end if;

  return v_return;
end;

--------------------------------------------------------------------------------
-- PRIVATE METHODS
--------------------------------------------------------------------------------

procedure create_entry (
  p_level      integer,
  p_message    clob,
  p_trace      boolean,
  p_user_agent varchar2
) is
  pragma autonomous_transaction;
  v_call_stack console_logs.call_stack%type;
begin
  if p_level <= c_level_error
    or logging_enabled(sys_context('USERENV', 'CLIENT_IDENTIFIER'), p_level)
    or logging_enabled(dbms_session.unique_session_id, p_level)
  then
    if p_trace then
      v_call_stack := substr(get_call_stack, 1, 2000);
    end if;
    insert into console_logs (
      log_level,
      message,
      call_stack,
      module,
      action,
      client_info,
      session_user,
      unique_session_id,
      client_identifier,
      ip_address,
      host,
      os_user,
      os_user_agent,
      instance,
      instance_name,
      service_name,
      sid,
      sessionid)
    values (
      p_level,
      p_message,
      v_call_stack,
      sys_context('USERENV', 'MODULE'),
      sys_context('USERENV', 'ACTION'),
      sys_context('USERENV', 'CLIENT_INFO'),
      sys_context('USERENV', 'SESSION_USER'),
      dbms_session.unique_session_id,
      sys_context('USERENV', 'CLIENT_IDENTIFIER'),
      sys_context('USERENV', 'IP_ADDRESS'),
      sys_context('USERENV', 'HOST'),
      sys_context('USERENV', 'OS_USER'),
      substr(p_user_agent, 1, 200),
      sys_context('USERENV', 'INSTANCE'),
      sys_context('USERENV', 'INSTANCE_NAME'),
      sys_context('USERENV', 'SERVICE_NAME'),
      sys_context('USERENV', 'SID'),
      sys_context('USERENV', 'SESSIONID'));
    commit;
  end if;
end create_entry;

--------------------------------------------------------------------------------

function logging_enabled(
  p_session varchar2,
  p_level   integer
) return boolean is
  v_context       vc4000;
  v_session_start pls_integer;
  v_level_start   pls_integer;
  v_level         pls_integer;
  v_date          date;
begin
  v_context := get_context;
  v_session_start := instr(v_context, p_session);
  if v_session_start > 0 then
    v_level_start := instr(v_context, c_sep, v_session_start) + 1;
    --example entry: APEX:8805903776765,4,20210117202241
    begin
      v_level := to_number(substr(v_context, v_level_start, 1));
      v_date  := to_date(substr(v_context, v_level_start + 2, 14), c_date_format);
    exception
      when others then
        null; -- I know, I know - never do this - but here it is ok if we cant convert
    end;
  end if;
  return v_level >= p_level and v_date > sysdate;
end logging_enabled;

function get_context return varchar2 is
begin
  return sys_context(
    namespace => c_context_namespace,
    attribute => c_context_attribute
  );
end;

procedure set_context(p_value varchar2) is
begin
  sys.dbms_session.set_context(
    namespace => c_context_namespace,
    attribute => c_context_attribute,
    value     => p_value
  );
end;

procedure clear_context is
begin
  sys.dbms_session.clear_context(
    namespace => c_context_namespace,
    attribute => c_context_attribute
  );
end;

end console;
/

column "Name"      format a15
column "Line,Col"  format a10
column "Type"      format a10
column "Message"   format a80

declare
  v_count pls_integer;
begin
  select count(*)
    into v_count
    from user_errors
   where name = 'CONSOLE';
  if v_count > 0 then
    dbms_output.put_line('- Package CONSOLE has errors :-(');
  end if;
end;
/

select name || case when type like '%BODY' then ' body' end as "Name",
       line || ',' || position as "Line,Col",
       attribute               as "Type",
       text                    as "Message"
  from user_errors
 where name = 'CONSOLE'
 order by name, line, position;

prompt - log installed version
declare
  v_count pls_integer;
begin
  select count(*)
    into v_count
    from user_errors
   where name = 'CONSOLE';
  if v_count = 0 then
    console.permanent('CONSOLE v' || console.c_version || ' installed');
  end if;
end;
/

prompt - FINISHED


--DO NOT CHANGE THIS FILE - IT IS GENERATED WITH THE BUILD SCRIPT src/build.js
set define off feedback off
whenever sqlerror exit sql.sqlcode rollback

prompt
prompt Installing Oracle Instrumentation Console
prompt ==================================================

prompt Set compiler flags
DECLARE
  v_apex_installed VARCHAR2(5) := 'FALSE'; -- Do not change (is set dynamically).
  v_utils_public   VARCHAR2(5) := 'FALSE'; -- Make utilities public available (for testing or other usages).
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
    || 'apex_installed:' || v_apex_installed || ','
    || 'utils_public:'   || v_utils_public   || '''';
END;
/

prompt Create or alter table console_logs
--For development only - uncomment temporarely when you need it:
begin for i in (select 1 from user_tables where table_name = 'CONSOLE_LOGS') loop execute immediate 'drop table console_logs purge'; end loop; end;
/

declare
  v_name varchar2(30 char) := 'CONSOLE_LOGS';
begin
  for i in (
    select v_name from dual
    minus
    select table_name from user_tables where table_name = v_name
  )
  loop
    execute immediate q'{
      create table console_logs (
        log_id             integer                                               generated by default on null as identity,
        log_time           timestamp with local time zone  default systimestamp  not null  ,
        log_level          integer                                                         ,
        message            clob                                                            ,
        call_stack         varchar2(1000)                                                  ,
        module             varchar2(64)                                                    ,
        action             varchar2(64)                                                    ,
        unique_session_id  varchar2(12)                                                    ,
        client_identifier  varchar2(64)                                                    ,
        ip_address         varchar2(32)                                                    ,
        host               varchar2(64)                                                    ,
        os_user            varchar2(64)                                                    ,
        os_user_agent      varchar2(200)                                                   ,
        instance           integer                                                         ,
        instance_name      varchar2(32)                                                    ,
        service_name       varchar2(64)                                                    ,
        sid                integer                                                         ,
        sessionid          varchar2(64)                                                    ,
        --
        constraint console_logs_check_level check (log_level in (0,1,2,3))
      )
    }';
  end loop;
end;
/

comment on table console_logs is 'Table for log entries of the package CONSOLE.';
comment on column console_logs.log_id is 'Primary key.';
comment on column console_logs.log_time is 'Log entry timestamp. Required for the CONSOLE.PURGE method.';
comment on column console_logs.log_level is 'Log entry level. Can be 0 (permanent), 1 (error), 2 (warn) or 3 (debug).';
comment on column console_logs.message is 'The log message.';
comment on column console_logs.call_stack is 'The call_stack will only be provided on log level 1 (call of console.error).';
comment on column console_logs.module is 'The application name (module) set through the DBMS_APPLICATION_INFO package or OCI.';
comment on column console_logs.action is 'Identifies the position in the module (application name) and is set through the DBMS_APPLICATION_INFO package or OCI.';
comment on column console_logs.unique_session_id is 'An identifier that is unique for all sessions currently connected to the database. Provided by DBMS_SESSION.UNIQUE_SESSION_ID. Is constructed by sid, serial# and inst_id from (g)v$session (undocumented, there is no official way to construct this ID by yourself, but we need to do this to identify a session).';
comment on column console_logs.client_identifier is 'Returns an identifier that is set by the application through the DBMS_SESSION.SET_IDENTIFIER procedure, the OCI attribute OCI_ATTR_CLIENT_IDENTIFIER, or Oracle Dynamic Monitoring Service (DMS). This attribute is used by various database components to identify lightweight application users who authenticate as the same database user.';
comment on column console_logs.ip_address is 'IP address of the machine from which the client is connected. If the client and server are on the same machine and the connection uses IPv6 addressing, then ::1 is returned.';
comment on column console_logs.host is 'Name of the host machine from which the client is connected.';
comment on column console_logs.os_user is 'Operating system user name of the client process that initiated the database session.';
comment on column console_logs.os_user_agent is 'Operating system user agent (web browser engine). This information will only be available, if we overwrite the console.error method of the client browser and bring these errors back to the server. For APEX we will have a plug-in in the future to do this.';
comment on column console_logs.instance is 'The instance identification number of the current instance.';
comment on column console_logs.instance_name is 'The name of the instance.';
comment on column console_logs.service_name is 'The name of the service to which a given session is connected.';
comment on column console_logs.sid is 'The session ID (can be the same on different instances).';
comment on column console_logs.sessionid is 'The auditing session identifier. You cannot use this attribute in distributed SQL statements.';


/*
call_stack varchar2(1000),
client_identifier varchar2(64),
sessionid varchar2(64),
instance_name varchar2(32),
msg varchar2(4000),

*/

prompt Compile package console (spec)
create or replace package console authid current_user is

c_name        constant varchar2(30 char) := 'Oracle Instrumentation Console';
c_version     constant varchar2(10 char) := '0.1.0';
c_url         constant varchar2(40 char) := 'https://github.com/ogobrecht/console';
c_license     constant varchar2(10 char) := 'MIT';
c_license_url constant varchar2(60 char) := 'https://github.com/ogobrecht/console/blob/main/LICENSE';
c_author      constant varchar2(20 char) := 'Ottmar Gobrecht';

c_level_permanent constant integer := 0;
c_level_error     constant integer := 1;
c_level_warning   constant integer := 2;
c_level_info      constant integer := 3;
c_level_verbose   constant integer := 4;

/**
Oracle Instrumentation Console
==============================

An instrumentation tool for Oracle developers. Save to install on production and mostly API compatible with the [JavaScript console](https://developers.google.com/web/tools/chrome-devtools/console/api).

DEPENDENCIES

Oracle DB >= 18.x???

INSTALLATION

- Download the [latest version](https://github.com/ogobrecht/oracle-instrumentation-console/releases/latest) and unzip it or clone the repository
- Go into the project root directory and use SQL*Plus (or another tool which can run SQL scripts)

The installation itself is splitted into two mandatory and two optional steps:

1. Create a context with a privileged user
    - `1_create_context.sql`
    - Maybe your DBA needs to do that for you once
2. Install the tool itself in your desired target schema
    - `2_install_console.sql`
    - User needs the rights to create a package, a table and views
    - Do this step on every new release of the tool
3. Optional: When installed in a central tools schema you may want to grant execute rights on the package and select rights on the views to public or other schemas
    - `3_grant_rights.sql`
4. Optional: When you want to use it in another schema you may want to create synonyms there for easier access
    - `4_create_synonyms.sql`

UNINSTALLATION

Hopefully you will never need this...

FIXME: Create uninstall scripts

**/


------------------------------------------------------------------------------------------------------------------------
-- CONSTANTS, TYPES
------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------------
-- MAIN METHODS
------------------------------------------------------------------------------------------------------------------------
procedure permanent (
  p_message    clob,
  p_user_agent varchar2 default null);
/** Log a message with the level 0 (permanent). These messages will not be deleted on cleanup. **/

procedure error (
  p_message    clob,
  p_user_agent varchar2 default null);
/** Log a message with the level 1 (error). **/

procedure warn (
  p_message    clob,
  p_user_agent varchar2 default null);
/** Log a message with the level 2 (warning). **/

procedure info(
  p_message    clob,
  p_user_agent varchar2 default null);
/** Log a message with the level 3 (info). This is an alias for the debug method. **/

procedure log(
  p_message    clob,
  p_user_agent varchar2 default null);
/** Log a message with the level 3 (info). This is an alias for the debug method. **/

procedure debug (
  p_message    clob,
  p_user_agent varchar2 default null);
/** Log a message with the level 4 (verbose). **/

------------------------------------------------------------------------------------------------------------------------
-- UTILITIES (only compiled when public)
------------------------------------------------------------------------------------------------------------------------

$if $$utils_public $then



$end

end console;
/

show errors

prompt Compile package console (body)
create or replace package body console is

------------------------------------------------------------------------------------------------------------------------
-- CONSTANTS, TYPES, GLOBALS
------------------------------------------------------------------------------------------------------------------------

c_tab          constant varchar2(1) := chr(9);
c_cr           constant varchar2(1) := chr(13);
c_lf           constant varchar2(1) := chr(10);
c_crlf         constant varchar2(2) := chr(13) || chr(10);
c_at           constant varchar2(1) := '@';
c_hash         constant varchar2(1) := '#';
c_slash        constant varchar2(1) := '/';
c_vc2_max_size constant pls_integer := 32767;

------------------------------------------------------------------------------------------------------------------------
-- UTILITIES (forward declarations, only compiled when not public)
------------------------------------------------------------------------------------------------------------------------

$if not $$utils_public $then



$end


------------------------------------------------------------------------------------------------------------------------
-- UTILITIES
------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------------
-- MAIN CODE
------------------------------------------------------------------------------------------------------------------------

procedure log_internal (p_level integer, p_message clob, p_user_agent varchar2 default null) is
  pragma autonomous_transaction;
begin
  dbms_output.put_line(p_message);
  insert into console_logs (
    log_level,
    message,
    call_stack,
    module,
    action,
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
    sessionid
  ) values (
    p_level,
    p_message,
    null, --FIXME: call_stack,
    sys_context('USERENV', 'MODULE'),
    sys_context('USERENV', 'ACTION'),
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
    sys_context('USERENV', 'SESSIONID')
  );
  commit;
end;

function logging_enabled return boolean
is
begin
  return false; --FIXME: implement
end;

procedure permanent (
  p_message clob,
  p_user_agent varchar2 default null) is
begin
  -- level permanent will always be logged
  log_internal (c_level_permanent, p_message, p_user_agent);
end;

procedure error (
  p_message clob,
  p_user_agent varchar2 default null) is
begin
  -- level error will always be logged
  log_internal (c_level_error, p_message, p_user_agent);
end;

procedure warn (
  p_message clob,
  p_user_agent varchar2 default null) is
begin
  if logging_enabled then
    log_internal (c_level_warning  , p_message, p_user_agent);
  end if;
end;

procedure info (
  p_message clob,
  p_user_agent varchar2 default null) is
begin
  if logging_enabled then
    log_internal (c_level_info, p_message, p_user_agent);
  end if;
end;

procedure log (
  p_message clob,
  p_user_agent varchar2 default null) is
begin
  if logging_enabled then
    log_internal (c_level_info, p_message, p_user_agent);
  end if;
end;

procedure debug (
  p_message clob,
  p_user_agent varchar2 default null) is
begin
  if logging_enabled then
    log_internal (c_level_verbose, p_message, p_user_agent);
  end if;
end;

end console;
/

show errors

prompt ==================================================
prompt Installation Done
prompt

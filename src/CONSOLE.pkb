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

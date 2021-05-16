--DO NOT CHANGE THIS FILE - IT IS GENERATED WITH THE BUILD SCRIPT sources/build.js

prompt ORACLE INSTRUMENTATION CONSOLE: INSTALL APEX PLUG-IN
prompt - application/set_environment
set define off verify off feedback off
whenever sqlerror exit sql.sqlcode rollback

--------------------------------------------------------------------------------
--
-- ORACLE Application Express (APEX) export file
--
-- You should run the script connected to SQL*Plus as the Oracle user
-- APEX_050100 or as the owner (parsing schema) of the application.
--
-- NOTE: Calls to apex_application_install override the defaults below.
--
--------------------------------------------------------------------------------
begin
  wwv_flow_api.import_begin (
    p_version_yyyy_mm_dd     => '2016.08.24'      ,
    p_release                => '5.1.4.00.08'     ,
    p_default_workspace_id   => 100000            ,
    p_default_application_id => 100               ,
    p_default_id_offset      => 34698863762663877 , --FIXME: was this available in APEX 5.1.4?
    p_default_owner          => 'PLAYGROUND_DATA' );
end;
/

begin
  -- replace components
  wwv_flow_api.g_mode := 'REPLACE'; --FIXME: was this available in APEX 5.1.4?
end;
/

prompt - application/shared_components/plugins/dynamic_action/com_ogobrecht_console
begin
  wwv_flow_api.create_plugin (
    p_id                        => wwv_flow_api.id(36295154520053378)     ,
    p_plugin_type               => 'DYNAMIC ACTION'                       ,
    p_name                      => 'COM.OGOBRECHT.CONSOLE'                ,
    p_display_name              => 'Oracle Instrumentation Console'       ,
    p_category                  => 'COMPONENT'                            , --FIXME: was this available in APEX 5.1.4?
    p_supported_ui_types        => 'DESKTOP:JQM_SMARTPHONE'               ,
    p_api_version               => 2                                      ,
    p_render_function           => 'console.apex_plugin_render'           ,
    p_ajax_function             => 'console.apex_plugin_ajax'             ,
    p_substitute_attributes     => true                                   ,
    p_subscribe_plugin_settings => true                                   ,
    p_version_identifier        => '1.0-beta6'                    ,
    p_about_url                 => 'https://github.com/ogobrecht/console' ,
    p_files_version             => 113                         );
end;
/


begin
  wwv_flow_api.g_varchar2_table := wwv_flow_api.empty_varchar2_table;
  wwv_flow_api.g_varchar2_table(1) := '2f2a20676c6f62616c20617065783a66616c7365202a2f0d0a766172206f6963203d207b7d3b202f2f204e616d65737061636520666f7220224f7261636c6520496e737472756d656e746174696f6e20436f6e736f6c65222e0d0a6f69632e6f6320203d';
  wwv_flow_api.g_varchar2_table(2) := '207b7d3b202f2f204e616d65737061636520666f7220224f726967696e616c20436f6e736f6c6522206d6574686f64732e0d0a6f69632e6f6120203d207b7d3b202f2f204e616d65737061636520666f7220224f726967696e616c20417065782e646562';
  wwv_flow_api.g_varchar2_table(3) := '756722206d6574686f64732e0d0a6f69632e6c6e20203d207b7d3b202f2f204e616d65737061636520666f7220224c6576656c204e616d6573222e0d0a6f69632e6c6e2e6572726f72203d20313b0d0a6f69632e6c6e2e7761726e696e67203d20323b0d';
  wwv_flow_api.g_varchar2_table(4) := '0a6f69632e6c6e2e696e666f203d20333b0d0a6f69632e6c6e2e6465627567203d20343b0d0a6f69632e6c6e2e7472616365203d20353b0d0a6f69632e746f537472696e67203d2066756e6374696f6e2028617267756d656e7473417272617929207b0d';
  wwv_flow_api.g_varchar2_table(5) := '0a2020202076617220726573756c74203d2022223b0d0a20202020666f7220287661722069203d20303b2069203c20617267756d656e747341727261792e6c656e6774683b20692b2b29207b0d0a2020202020202020726573756c74202b3d2028692021';
  wwv_flow_api.g_varchar2_table(6) := '3d3d2030203f20272027203a202727293b0d0a202020202020202069662028747970656f6620617267756d656e747341727261795b695d203d3d3d20276f626a6563742729207b0d0a202020202020202020202020726573756c74202b3d20275c6e2720';
  wwv_flow_api.g_varchar2_table(7) := '2b204a534f4e2e737472696e6769667928617267756d656e747341727261795b695d2c206e756c6c2c2032293b0d0a20202020202020207d0d0a2020202020202020656c7365207b0d0a202020202020202020202020726573756c74202b3d2061726775';
  wwv_flow_api.g_varchar2_table(8) := '6d656e747341727261795b695d3b0d0a20202020202020207d0d0a202020207d0d0a2020202072657475726e20726573756c743b0d0a7d0d0a6f69632e696e6974203d2066756e6374696f6e202829207b0d0a202020202f2f20446566696e652067656e';
  wwv_flow_api.g_varchar2_table(9) := '65726963206c6f672066756e6374696f6e2077697468206c6576656c20706172616d6574657220666f72206c61746572207573650d0a202020206f69632e6d657373616765203d2066756e6374696f6e20286c6576656c2c206d6573736167652c207363';
  wwv_flow_api.g_varchar2_table(10) := '6f70652c20737461636b29207b0d0a2020202020202020617065782e7365727665722e706c7567696e280d0a2020202020202020202020206f69632e706c7567696e49642c0d0a2020202020202020202020207b0d0a2020202020202020202020202020';
  wwv_flow_api.g_varchar2_table(11) := '20207830313a206c6576656c2c0d0a202020202020202020202020202020207830323a206d6573736167652c0d0a202020202020202020202020202020207830333a2027415045582046524f4e54454e44204a4156415343524950543a2027202b207363';
  wwv_flow_api.g_varchar2_table(12) := '6f70652c0d0a202020202020202020202020202020207830343a20737461636b2c0d0a202020202020202020202020202020207830353a206e6176696761746f722e757365724167656e742c0d0a20202020202020202020202020202020705f64656275';
  wwv_flow_api.g_varchar2_table(13) := '673a2066616c73650d0a2020202020202020202020207d2c0d0a2020202020202020202020207b0d0a20202020202020202020202020202020737563636573733a2066756e6374696f6e202864617461537472696e6729207b0d0a202020202020202020';
  wwv_flow_api.g_varchar2_table(14) := '20202020202020202020206966202864617461537472696e6720213d2027535543434553532729207b0d0a2020202020202020202020202020202020202020202020206f69632e6572726f7228274f7261636c6520496e737472756d656e746174696f6e';
  wwv_flow_api.g_varchar2_table(15) := '20436f6e736f6c653a20414a41582063616c6c2068616420736572766572207369646520504c2f53514c206572726f723a2027202b2064617461537472696e67202b20272e27293b0d0a20202020202020202020202020202020202020207d0d0a202020';
  wwv_flow_api.g_varchar2_table(16) := '202020202020202020202020207d2c0d0a202020202020202020202020202020206572726f723a2066756e6374696f6e20287868722c207374617475732c206572726f725468726f776e29207b0d0a20202020202020202020202020202020202020206f';
  wwv_flow_api.g_varchar2_table(17) := '69632e6572726f7228274f7261636c6520496e737472756d656e746174696f6e20436f6e736f6c653a20414a41582063616c6c207465726d696e617465642077697468206572726f72733a2027202b206572726f725468726f776e202b20272e27293b0d';
  wwv_flow_api.g_varchar2_table(18) := '0a202020202020202020202020202020207d2c0d0a2020202020202020202020202020202064617461547970653a202774657874270d0a2020202020202020202020207d0d0a2020202020202020293b0d0a202020207d3b0d0a0d0a202020202f2f2052';
  wwv_flow_api.g_varchar2_table(19) := '65646566696e6520636f6e736f6c652e6572726f7220616e6420617065782e64656275672e6572726f72206d6574686f64732077697468206120637573746f6d2066756e6374696f6e0d0a202020206f69632e6f632e6572726f72203d20636f6e736f6c';
  wwv_flow_api.g_varchar2_table(20) := '652e6572726f723b0d0a20202020636f6e736f6c652e6572726f72203d2066756e6374696f6e202829207b0d0a20202020202020206f69632e6d657373616765286f69632e6c6e2e6572726f722c206f69632e746f537472696e6728617267756d656e74';
  wwv_flow_api.g_varchar2_table(21) := '73292c2027636f6e736f6c652e6572726f7227293b0d0a20202020202020206f69632e6f632e6572726f722e6170706c7928636f6e736f6c652c20617267756d656e7473293b0d0a202020207d3b0d0a202020206f69632e6f612e6572726f72203d2061';
  wwv_flow_api.g_varchar2_table(22) := '7065782e64656275672e6572726f723b0d0a20202020617065782e64656275672e6572726f72203d2066756e6374696f6e202829207b0d0a20202020202020206f69632e6d657373616765286f69632e6c6e2e6572726f722c206f69632e746f53747269';
  wwv_flow_api.g_varchar2_table(23) := '6e6728617267756d656e7473292c2027617065782e64656275672e6572726f7227293b0d0a20202020202020202f2f204265636175736520617065782e64656275672e6572726f7220646f6573206d6f7265207468616e2073696d706c79206c6f672074';
  wwv_flow_api.g_varchar2_table(24) := '6f2074686520636f6e736f6c652077650d0a20202020202020202f2f20757365206865726520746865206f726967696e616c206f6e652e20496e20616c6c206f746865722063617365732077652073696d706c7920726564697265637420746f0d0a2020';
  wwv_flow_api.g_varchar2_table(25) := '2020202020202f2f2074686520617070726f70726961746520636f6e736f6c65206d6574686f647320746f2073617665206f76657268656164206f66206164646974696f6e616c0d0a20202020202020202f2f2066756e6374696f6e20696e766f636174';
  wwv_flow_api.g_varchar2_table(26) := '696f6e732e0d0a20202020202020206f69632e6f612e6572726f722e6170706c7928617065782e64656275672c20617267756d656e7473293b0d0a202020207d3b0d0a0d0a202020202f2a2043757272656e746c792077652063617074757265206f6e6c';
  wwv_flow_api.g_varchar2_table(27) := '79206572726f72732062656361757365206f6620746865206865617679206f76657268656164207768656e20646f20616e20414a41582063616c6c20666f72206576657279206c6f67206576656e740d0a202020202f2f20446f207468652073616d6520';
  wwv_flow_api.g_varchar2_table(28) := '77697468206f7468657220636f6e736f6c65206d6574686f647320646570656e64696e67206f6e206f75722063757272656e74206465627567206c6576656c0d0a20202020696620286f69632e6c6576656c203e3d206f69632e6c6e2e7761726e696e67';
  wwv_flow_api.g_varchar2_table(29) := '29207b0d0a20202020202020206f69632e6f632e7761726e203d20636f6e736f6c652e7761726e3b0d0a2020202020202020636f6e736f6c652e7761726e203d2066756e6374696f6e202829207b0d0a2020202020202020202020206f69632e6d657373';
  wwv_flow_api.g_varchar2_table(30) := '616765286f69632e6c6e2e7761726e2c206f69632e746f537472696e6728617267756d656e7473292c2027636f6e736f6c652e7761726e27293b0d0a2020202020202020202020206f69632e6f632e7761726e2e6170706c7928636f6e736f6c652c2061';
  wwv_flow_api.g_varchar2_table(31) := '7267756d656e7473293b0d0a20202020202020207d3b0d0a202020207d0d0a20202020696620286f69632e6c6576656c203e3d206f69632e6c6e2e696e666f29207b0d0a20202020202020206f69632e6f632e696e666f203d20636f6e736f6c652e696e';
  wwv_flow_api.g_varchar2_table(32) := '666f3b0d0a2020202020202020636f6e736f6c652e696e666f203d2066756e6374696f6e202829207b0d0a2020202020202020202020206f69632e6d657373616765286f69632e6c6e2e696e666f2c206f69632e746f537472696e6728617267756d656e';
  wwv_flow_api.g_varchar2_table(33) := '7473292c2027636f6e736f6c652e696e666f27293b0d0a2020202020202020202020206f69632e6f632e696e666f2e6170706c7928636f6e736f6c652c20617267756d656e7473293b0d0a20202020202020207d3b0d0a20202020202020206f69632e6f';
  wwv_flow_api.g_varchar2_table(34) := '632e6c6f67203d20636f6e736f6c652e6c6f673b0d0a2020202020202020636f6e736f6c652e6c6f67203d2066756e6374696f6e202829207b0d0a2020202020202020202020206f69632e6d657373616765286f69632e6c6e2e696e666f2c206f69632e';
  wwv_flow_api.g_varchar2_table(35) := '746f537472696e6728617267756d656e7473292c2027636f6e736f6c652e6c6f6727293b0d0a2020202020202020202020206f69632e6f632e6c6f672e6170706c7928636f6e736f6c652c20617267756d656e7473293b0d0a20202020202020207d3b0d';
  wwv_flow_api.g_varchar2_table(36) := '0a20202020202020206f69632e6f632e7472616365203d20636f6e736f6c652e74726163653b0d0a2020202020202020636f6e736f6c652e7472616365203d2066756e6374696f6e202829207b0d0a2020202020202020202020206f69632e6d65737361';
  wwv_flow_api.g_varchar2_table(37) := '6765286f69632e6c6e2e696e666f2c206f69632e746f537472696e6728617267756d656e7473292c2027636f6e736f6c652e747261636527293b0d0a2020202020202020202020206f69632e6f632e74726163652e6170706c7928636f6e736f6c652c20';
  wwv_flow_api.g_varchar2_table(38) := '617267756d656e7473293b0d0a20202020202020207d3b0d0a202020207d0d0a20202020696620286f69632e6c6576656c203e3d206f69632e6c6e2e646562756729207b0d0a20202020202020206f69632e6f632e6465627567203d20636f6e736f6c65';
  wwv_flow_api.g_varchar2_table(39) := '2e64656275673b0d0a2020202020202020636f6e736f6c652e6465627567203d2066756e6374696f6e202829207b0d0a2020202020202020202020206f69632e6d657373616765286f69632e6c6e2e64656275672c206f69632e746f537472696e672861';
  wwv_flow_api.g_varchar2_table(40) := '7267756d656e7473292c2027636f6e736f6c652e646562756727293b0d0a2020202020202020202020206f69632e6f632e64656275672e6170706c7928636f6e736f6c652c20617267756d656e7473293b0d0a20202020202020207d3b0d0a202020207d';
  wwv_flow_api.g_varchar2_table(41) := '0d0a202020202a2f0d0a0d0a202020202f2a2043757272656e746c792077652063617074757265206f6e6c79206572726f72732062656361757365206f6620746865206865617679206f76657268656164207768656e20646f20616e20414a4158206361';
  wwv_flow_api.g_varchar2_table(42) := '6c6c20666f72206576657279206c6f67206576656e740d0a202020202f2f20446f207468652073616d652077697468206f746865722061706578206d6574686f647320646570656e64696e67206f6e206f75722063757272656e74206465627567206c65';
  wwv_flow_api.g_varchar2_table(43) := '76656c0d0a20202020696620286f69632e6c6576656c203e3d206f69632e6c6e2e7761726e696e6720262620617065782e64656275672e6765744c6576656c2829203e3d20617065782e64656275672e4c4f475f4c4556454c2e5741524e29207b0d0a20';
  wwv_flow_api.g_varchar2_table(44) := '202020202020206f69632e6f612e7761726e203d20617065782e64656275672e7761726e3b0d0a2020202020202020617065782e64656275672e7761726e203d2066756e6374696f6e202829207b0d0a2020202020202020202020206f69632e6d657373';
  wwv_flow_api.g_varchar2_table(45) := '616765286f69632e6c6e2e7761726e2c206f69632e746f537472696e6728617267756d656e7473292c2027617065782e64656275672e7761726e27293b0d0a2020202020202020202020206f69632e6f632e7761726e2e6170706c7928636f6e736f6c65';
  wwv_flow_api.g_varchar2_table(46) := '2c20617267756d656e7473293b202f2f205573696e67206f69632e6f6320697320627920696e74656e74696f6e2e0d0a20202020202020207d3b0d0a202020207d0d0a20202020696620286f69632e6c6576656c203e3d206f69632e6c6e2e696e666f20';
  wwv_flow_api.g_varchar2_table(47) := '262620617065782e64656275672e6765744c6576656c2829203e3d20617065782e64656275672e4c4f475f4c4556454c2e494e464f29207b0d0a20202020202020206f69632e6f612e696e666f203d20617065782e64656275672e696e666f3b0d0a2020';
  wwv_flow_api.g_varchar2_table(48) := '202020202020617065782e64656275672e696e666f203d2066756e6374696f6e202829207b0d0a2020202020202020202020206f69632e6d657373616765286f69632e6c6e2e696e666f2c206f69632e746f537472696e6728617267756d656e7473292c';
  wwv_flow_api.g_varchar2_table(49) := '2027617065782e64656275672e696e666f27293b0d0a2020202020202020202020206f69632e6f632e696e666f2e6170706c7928636f6e736f6c652c20617267756d656e7473293b202f2f205573696e67206f69632e6f6320697320627920696e74656e';
  wwv_flow_api.g_varchar2_table(50) := '74696f6e2e0d0a20202020202020207d3b0d0a20202020202020202f2f204966207765206f76657277726974652074686520617065782e64656275672e6c6f67206d6574686f642c2077652072756e20696e746f20616e20656e646c6573730d0a202020';
  wwv_flow_api.g_varchar2_table(51) := '20202020202f2f206c6f6f70207768656e2041504558206465627567206d6f6465206973207377697463686564206f6e2e20526561736f6e3a2041504558206973206c6f6767696e670d0a20202020202020202f2f20657665727920414a41582063616c';
  wwv_flow_api.g_varchar2_table(52) := '6c207769746820617065782e64656275672e6c6f672e204649584d453a2066696e64206120776f726b61726f756e6420666f720d0a20202020202020202f2f20746869732e0d0a20202020202020202f2f6f69632e6f612e6c6f67203d20617065782e64';
  wwv_flow_api.g_varchar2_table(53) := '656275672e6c6f673b0d0a20202020202020202f2f617065782e64656275672e6c6f67203d2066756e6374696f6e202829207b0d0a20202020202020202f2f202020206f69632e6d657373616765286f69632e6c6e2e696e666f2c206f69632e746f5374';
  wwv_flow_api.g_varchar2_table(54) := '72696e6728617267756d656e7473292c2027617065782e64656275672e6c6f6727293b0d0a20202020202020202f2f202020206f69632e6f632e6c6f672e6170706c7928636f6e736f6c652c20617267756d656e7473293b202f2f205573696e67206f69';
  wwv_flow_api.g_varchar2_table(55) := '632e6f6320697320627920696e74656e74696f6e2e0d0a20202020202020202f2f7d3b0d0a202020207d0d0a20202020696620286f69632e6c6576656c203e3d206f69632e6c6e2e646562756720262620617065782e64656275672e6765744c6576656c';
  wwv_flow_api.g_varchar2_table(56) := '2829203e3d20617065782e64656275672e4c4f475f4c4556454c2e4150505f545241434529207b0d0a20202020202020206f69632e6f612e7472616365203d20617065782e64656275672e74726163653b0d0a2020202020202020617065782e64656275';
  wwv_flow_api.g_varchar2_table(57) := '672e7472616365203d2066756e6374696f6e202829207b0d0a2020202020202020202020206f69632e6d657373616765286f69632e6c6e2e64656275672c206f69632e746f537472696e6728617267756d656e7473292c2027617065782e64656275672e';
  wwv_flow_api.g_varchar2_table(58) := '747261636527293b0d0a2020202020202020202020206f69632e6f632e64656275672e6170706c7928636f6e736f6c652c20617267756d656e7473293b202f2f205573696e67206f69632e6f6320697320627920696e74656e74696f6e2e0d0a20202020';
  wwv_flow_api.g_varchar2_table(59) := '202020207d3b0d0a202020207d0d0a202020202a2f0d0a0d0a202020202f2f204649584d453a2053686f756c64207765206861766520616e20657874656e646564206572726f722068616e646c696e67207768656e206c6f67206c6576656c2069732068';
  wwv_flow_api.g_varchar2_table(60) := '69676865720d0a202020202f2f207468616e2031286572726f72292061732064657363726962656420616e642074686520656e64206f66205b746869730d0a202020202f2f2061727469636c655d2868747470733a2f2f70726f6772616d6d696e672e76';
  wwv_flow_api.g_varchar2_table(61) := '69702f646f63732f6a6176617363726970742d676c6f62616c2d6572726f722d68616e646c696e672e68746d6c293f0d0a202020202f2f0d0a202020202f2f202d2068747470733a2f2f646576656c6f7065722e6d6f7a696c6c612e6f72672f656e2d55';
  wwv_flow_api.g_varchar2_table(62) := '532f646f63732f5765622f4150492f476c6f62616c4576656e7448616e646c6572732f6f6e6572726f720d0a202020202f2f202d2068747470733a2f2f647a6f6e652e636f6d2f61727469636c65732f636170747572652d616e642d7265706f72742d6a';
  wwv_flow_api.g_varchar2_table(63) := '6176617363726970742d6572726f72732d776974682d77696e646f776f6e0d0a202020202f2f202d2068747470733a2f2f70726f6772616d6d696e672e7669702f646f63732f6a6176617363726970742d676c6f62616c2d6572726f722d68616e646c69';
  wwv_flow_api.g_varchar2_table(64) := '6e672e68746d6c0d0a2020202077696e646f772e6f6e6572726f72203d2066756e6374696f6e20286d73672c2075726c2c206c696e654e6f2c20636f6c756d6e4e6f2c206572726f7229207b0d0a20202020202020202f2f20557365206f6e6c79207468';
  wwv_flow_api.g_varchar2_table(65) := '652072656c61746976652075726c207061746820746f2073686f7274656e207468652073636f70653a0d0a20202020202020207661722073636f7065203d202777696e646f772e6f6e6572726f722c2075726c2027202b2075726c2e6d61746368282f5c';
  wwv_flow_api.g_varchar2_table(66) := '2f5c2f2e2a3f285c2f2e2a292f295b315d202b20272c206c696e652027202b206c696e654e6f202b20272c20636f6c756d6e2027202b20636f6c756d6e4e6f3b0d0a2020202020202020696620286d73672e746f4c6f7765724361736528292e696e6465';
  wwv_flow_api.g_varchar2_table(67) := '784f662827736372697074206572726f722729203e202d3129207b0d0a2020202020202020202020206f69632e6d657373616765280d0a202020202020202020202020202020206f69632e6c6e2e6572726f722c0d0a2020202020202020202020202020';
  wwv_flow_api.g_varchar2_table(68) := '202027536372697074206572726f7220696e20616e2065787465726e616c2066696c652028646966666572656e74206f726967696e293a205365652062726f7773657220636f6e736f6c6520666f722064657461696c73272c0d0a202020202020202020';
  wwv_flow_api.g_varchar2_table(69) := '2020202020202073636f70650d0a202020202020202020202020293b0d0a20202020202020207d20656c7365207b0d0a2020202020202020202020206f69632e6d657373616765280d0a202020202020202020202020202020206f69632e6c6e2e657272';
  wwv_flow_api.g_varchar2_table(70) := '6f722c0d0a202020202020202020202020202020206d73672c0d0a2020202020202020202020202020202073636f70652c0d0a202020202020202020202020202020206572726f722e737461636b0d0a202020202020202020202020293b0d0a20202020';
  wwv_flow_api.g_varchar2_table(71) := '202020207d0d0a202020202020202072657475726e2066616c73653b0d0a202020207d3b0d0a7d3b0d0a0d0a';
end;
/

begin
  wwv_flow_api.create_plugin_file(
    p_id           => wwv_flow_api.id(36299187405943315)                           ,
    p_plugin_id    => wwv_flow_api.id(36295154520053378)                           ,
    p_file_name    => 'console.js'                                                 ,
    p_mime_type    => 'application/javascript'                                     ,
    p_file_charset => 'utf-8'                                                      ,
    p_file_content => wwv_flow_api.varchar2_to_blob(wwv_flow_api.g_varchar2_table) );
end;
/


begin
  wwv_flow_api.g_varchar2_table := wwv_flow_api.empty_varchar2_table;
  wwv_flow_api.g_varchar2_table(1) := '766172206f69633d7b6f633a7b7d2c6f613a7b7d2c6c6e3a7b7d7d3b6f69632e6c6e2e6572726f723d312c6f69632e6c6e2e7761726e696e673d322c6f69632e6c6e2e696e666f3d332c6f69632e6c6e2e64656275673d342c6f69632e6c6e2e74726163';
  wwv_flow_api.g_varchar2_table(2) := '653d352c6f69632e746f537472696e673d66756e6374696f6e2872297b666f7228766172206f3d22222c653d303b653c722e6c656e6774683b652b2b296f2b3d30213d3d653f2220223a22222c226f626a656374223d3d747970656f6620725b655d3f6f';
  wwv_flow_api.g_varchar2_table(3) := '2b3d225c6e222b4a534f4e2e737472696e6769667928725b655d2c6e756c6c2c32293a6f2b3d725b655d3b72657475726e206f7d2c6f69632e696e69743d66756e6374696f6e28297b6f69632e6d6573736167653d66756e6374696f6e28722c6f2c652c';
  wwv_flow_api.g_varchar2_table(4) := '6e297b617065782e7365727665722e706c7567696e286f69632e706c7567696e49642c7b7830313a722c7830323a6f2c7830333a22415045582046524f4e54454e44204a4156415343524950543a20222b652c7830343a6e2c7830353a6e617669676174';
  wwv_flow_api.g_varchar2_table(5) := '6f722e757365724167656e742c705f64656275673a21317d2c7b737563636573733a66756e6374696f6e2872297b225355434345535322213d7226266f69632e6572726f7228224f7261636c6520496e737472756d656e746174696f6e20436f6e736f6c';
  wwv_flow_api.g_varchar2_table(6) := '653a20414a41582063616c6c2068616420736572766572207369646520504c2f53514c206572726f723a20222b722b222e22297d2c6572726f723a66756e6374696f6e28722c6f2c65297b6f69632e6572726f7228224f7261636c6520496e737472756d';
  wwv_flow_api.g_varchar2_table(7) := '656e746174696f6e20436f6e736f6c653a20414a41582063616c6c207465726d696e617465642077697468206572726f72733a20222b652b222e22297d2c64617461547970653a2274657874227d297d2c6f69632e6f632e6572726f723d636f6e736f6c';
  wwv_flow_api.g_varchar2_table(8) := '652e6572726f722c636f6e736f6c652e6572726f723d66756e6374696f6e28297b6f69632e6d657373616765286f69632e6c6e2e6572726f722c6f69632e746f537472696e6728617267756d656e7473292c22636f6e736f6c652e6572726f7222292c6f';
  wwv_flow_api.g_varchar2_table(9) := '69632e6f632e6572726f722e6170706c7928636f6e736f6c652c617267756d656e7473297d2c6f69632e6f612e6572726f723d617065782e64656275672e6572726f722c617065782e64656275672e6572726f723d66756e6374696f6e28297b6f69632e';
  wwv_flow_api.g_varchar2_table(10) := '6d657373616765286f69632e6c6e2e6572726f722c6f69632e746f537472696e6728617267756d656e7473292c22617065782e64656275672e6572726f7222292c6f69632e6f612e6572726f722e6170706c7928617065782e64656275672c617267756d';
  wwv_flow_api.g_varchar2_table(11) := '656e7473297d2c77696e646f772e6f6e6572726f723d66756e6374696f6e28722c6f2c652c6e2c69297b6e3d2277696e646f772e6f6e6572726f722c2075726c20222b6f2e6d61746368282f5c2f5c2f2e2a3f285c2f2e2a292f295b315d2b222c206c69';
  wwv_flow_api.g_varchar2_table(12) := '6e6520222b652b222c20636f6c756d6e20222b6e3b72657475726e2d313c722e746f4c6f7765724361736528292e696e6465784f662822736372697074206572726f7222293f6f69632e6d657373616765286f69632e6c6e2e6572726f722c2253637269';
  wwv_flow_api.g_varchar2_table(13) := '7074206572726f7220696e20616e2065787465726e616c2066696c652028646966666572656e74206f726967696e293a205365652062726f7773657220636f6e736f6c6520666f722064657461696c73222c6e293a6f69632e6d657373616765286f6963';
  wwv_flow_api.g_varchar2_table(14) := '2e6c6e2e6572726f722c722c6e2c692e737461636b292c21317d7d3b';
end;
/

begin
  wwv_flow_api.create_plugin_file(
    p_id           => wwv_flow_api.id(37195131994077352)                           ,
    p_plugin_id    => wwv_flow_api.id(36295154520053378)                           ,
    p_file_name    => 'console.min.js'                                             ,
    p_mime_type    => 'application/javascript'                                     ,
    p_file_charset => 'utf-8'                                                      ,
    p_file_content => wwv_flow_api.varchar2_to_blob(wwv_flow_api.g_varchar2_table) );
end;
/


begin
  wwv_flow_api.g_varchar2_table := wwv_flow_api.empty_varchar2_table;
  wwv_flow_api.g_varchar2_table(1) := '7b2276657273696f6e223a332c22736f7572636573223a5b22636f6e736f6c652e6a73225d2c226e616d6573223a5b226f6963222c226f63222c226f61222c226c6e222c226572726f72222c227761726e696e67222c22696e666f222c22646562756722';
  wwv_flow_api.g_varchar2_table(2) := '2c227472616365222c22746f537472696e67222c22617267756d656e74734172726179222c22726573756c74222c2269222c226c656e677468222c224a534f4e222c22737472696e67696679222c22696e6974222c226d657373616765222c226c657665';
  wwv_flow_api.g_varchar2_table(3) := '6c222c2273636f7065222c22737461636b222c2261706578222c22736572766572222c22706c7567696e222c22706c7567696e4964222c22783031222c22783032222c22783033222c22783034222c22783035222c226e6176696761746f72222c227573';
  wwv_flow_api.g_varchar2_table(4) := '65724167656e74222c22705f6465627567222c2273756363657373222c2264617461537472696e67222c22786872222c22737461747573222c226572726f725468726f776e222c226461746154797065222c22636f6e736f6c65222c22617267756d656e';
  wwv_flow_api.g_varchar2_table(5) := '7473222c226170706c79222c2277696e646f77222c226f6e6572726f72222c226d7367222c2275726c222c226c696e654e6f222c22636f6c756d6e4e6f222c226d61746368222c22746f4c6f77657243617365222c22696e6465784f66225d2c226d6170';
  wwv_flow_api.g_varchar2_table(6) := '70696e6773223a22414143412c49414149412c4941414d2c43414356432c474141552c47414356432c474141552c47414356432c474141552c49414356482c49414149472c47414147432c4d4141512c454143664a2c49414149472c47414147452c5141';
  wwv_flow_api.g_varchar2_table(7) := '41552c4541436a424c2c49414149472c47414147472c4b41414f2c454143644e2c49414149472c47414147492c4d4141512c45414366502c49414149472c474141474b2c4d4141512c45414366522c49414149532c534141572c53414155432c47414572';
  wwv_flow_api.g_varchar2_table(8) := '422c494144412c49414149432c454141532c4741434a432c454141492c45414147412c45414149462c45414165472c4f414151442c4941437643442c47414169422c4941414e432c454141552c4941414d2c4741434d2c694241417442462c4541416545';
  wwv_flow_api.g_varchar2_table(9) := '2c4741437442442c474141552c4b41414f472c4b41414b432c554141554c2c45414165452c474141492c4b41414d2c4741477a44442c47414155442c45414165452c4741476a432c4f41414f442c47414558582c4941414967422c4b41414f2c57414550';
  wwv_flow_api.g_varchar2_table(10) := '68422c4941414969422c514141552c53414155432c4541414f442c45414153452c4541414f432c4741433343432c4b41414b432c4f41414f432c4f41435276422c4941414977422c5341434a2c43414349432c4941414b502c4541434c512c4941414b54';
  wwv_flow_api.g_varchar2_table(11) := '2c4541434c552c4941414b2c364241412b42522c4541437043532c4941414b522c4541434c532c4941414b432c55414155432c55414366432c534141532c474145622c43414349432c514141532c53414155432c474143472c57414164412c474143416c';
  wwv_flow_api.g_varchar2_table(12) := '432c49414149492c4d41414d2c32454141364538422c454141612c4d4147354739422c4d41414f2c534141552b422c4541414b432c45414151432c474143314272432c49414149492c4d41414d2c71454141754569432c454141632c4d41456e47432c53';
  wwv_flow_api.g_varchar2_table(13) := '4141552c55414d744274432c49414149432c47414147472c4d4141516d432c514141516e432c4d414376426d432c514141516e432c4d4141512c5741435a4a2c4941414969422c514141516a422c49414149472c47414147432c4d41414f4a2c49414149';
  wwv_flow_api.g_varchar2_table(14) := '532c534141532b422c574141592c694241436e4478432c49414149432c47414147472c4d41414d71432c4d41414d462c51414153432c594145684378432c49414149452c47414147452c4d41415169422c4b41414b642c4d41414d482c4d414331426942';
  wwv_flow_api.g_varchar2_table(15) := '2c4b41414b642c4d41414d482c4d4141512c574143664a2c4941414969422c514141516a422c49414149472c47414147432c4d41414f4a2c49414149532c534141532b422c574141592c6f42414b6e4478432c49414149452c47414147452c4d41414d71';
  wwv_flow_api.g_varchar2_table(16) := '432c4d41414d70422c4b41414b642c4d41414f69432c59412b456e43452c4f41414f432c514141552c53414155432c4541414b432c4541414b432c45414151432c4541415533432c4741452f43652c454141512c75424141794230422c45414149472c4d';
  wwv_flow_api.g_varchar2_table(17) := '41414d2c6942414169422c4741414b2c55414159462c454141532c59414163432c45416578472c4f416469442c4541413743482c454141494b2c63414163432c514141512c6742414331426c442c4941414969422c514143416a422c49414149472c4741';
  wwv_flow_api.g_varchar2_table(18) := '4147432c4d4143502c7546414341652c4741474a6e422c4941414969422c514143416a422c49414149472c47414147432c4d41435077432c454143417a422c45414341662c4541414d67422c51414750227d';
end;
/

begin
  wwv_flow_api.create_plugin_file(
    p_id           => wwv_flow_api.id(37195419621077377)                           ,
    p_plugin_id    => wwv_flow_api.id(36295154520053378)                           ,
    p_file_name    => 'console.min.js.map'                                         ,
    p_mime_type    => 'application/octet-stream'                                   ,
    p_file_charset => 'utf-8'                                                      ,
    p_file_content => wwv_flow_api.varchar2_to_blob(wwv_flow_api.g_varchar2_table) );
end;
/


prompt - application/end_environment
begin
  wwv_flow_api.import_end(
    p_auto_install_sup_obj => nvl(wwv_flow_application_install.get_auto_install_sup_obj, false) ,
    p_is_component_import  => true                                                              ); -- do we need this for APEX 5.1.4, or was it the default? Works without in 20.2
commit;
end;
/

set verify on feedback on define on
prompt - FINISHED

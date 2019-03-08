program UltiboMain;
{$mode objfpc}{$H+}

uses
 {$ifdef BUILD_RPI } RaspberryPi,  {$endif}
 {$ifdef BUILD_RPI2} RaspberryPi2, {$endif}
 {$ifdef BUILD_RPI3} RaspberryPi3, {$endif}
 GlobalConst,GlobalTypes,Platform,Threads,Syscalls,
 API in '.\subtree\ultibohub\API\interface\api.pas',
 UltiboUtils,Logging,GlobalConfig,SysUtils,Console,VC4;
 
{$link zigmain.o}
function zigmain(argc: int; argv: PPChar): int; cdecl; external name 'zigmain';

procedure StartLogging;
begin
 LOGGING_INCLUDE_COUNTER:=False;
 LOGGING_INCLUDE_TICKCOUNT:=True;
 CONSOLE_REGISTER_LOGGING:=True;
 CONSOLE_LOGGING_POSITION:=CONSOLE_POSITION_FULL;
 LoggingConsoleDeviceAdd(ConsoleDeviceGetDefault);
 LoggingDeviceSetDefault(LoggingDeviceFindByType(LOGGING_TYPE_CONSOLE));
end;

var
 argc:int;      
 argv:PPChar;
 ExitCode:Integer;

begin
 StartLogging;
 argv:=AllocateCommandLine(SystemGetCommandLine,argc);
 ExitCode := zigmain(argc,argv);
 LoggingOutput(Format('zigmain stopped with exit code %d',[ExitCode]));
 ReleaseCommandLine(argv);
 ThreadHalt(0);
end.

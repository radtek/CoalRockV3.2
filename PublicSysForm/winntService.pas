unit winntService;

interface


uses

    Windows,WinSvc,WinSvcEx;

    function InstallService(const strServiceName,strDisplayName,
                      strDescription,strFilename: string):Boolean;
    procedure UninstallService(strServiceName:string);
    function ChangeServiceConfig(ServiceName: string; StartType: Integer): Boolean;//���÷���
    function RunServies(svr:String):Boolean;//����ĳ������
    function StopServies(svr:String):Boolean;//ֹͣĳ������
    function ServiceIsRunning(ServiceName: string): Boolean;//�жϷ����Ƿ�����
    function ServiceIsInstalled(ServiceName: string): Boolean;//��װ����

implementation

function ServiceIsInstalled(ServiceName: string): Boolean;//�Ƿ�װ�˷���
var
  Mgr, Svc: Integer;
begin
  Result := False;
  if (ServiceName='') then Exit;

  Mgr := OpenSCManager(nil, nil, SC_MANAGER_ALL_ACCESS);
  if Mgr <> 0 then
  begin
    Svc := OpenService(Mgr, PChar(ServiceName), SERVICE_ALL_ACCESS);
    Result := Svc <> 0;
    if Result then
      CloseServiceHandle(Svc);
    CloseServiceHandle(Mgr);
  end;
end;

function StrLCopy(Dest: PChar; const Source: PChar; MaxLen: Cardinal): PChar; assembler;
asm 
          PUSH EDI
          PUSH ESI
          PUSH EBX
          MOV ESI,EAX
          MOV EDI,EDX
          MOV EBX,ECX
          XOR AL,AL
          TEST ECX,ECX
          JZ @@1
          REPNE SCASB
          JNE @@1
          INC ECX
          @@1: SUB EBX,ECX
          MOV EDI,ESI
          MOV ESI,EDX
          MOV EDX,EDI
          MOV ECX,EBX
          SHR ECX,2
          REP MOVSD
          MOV ECX,EBX
          AND ECX,3
          REP MOVSB
          STOSB
          MOV EAX,EDX
          POP EBX
          POP ESI
          POP EDI

end; 

 

function StrPCopy(Dest: PChar; const Source: string): PChar; 

begin
     Result := StrLCopy(Dest, PChar(Source), Length(Source));
end; 

 

function InstallService(const strServiceName,strDisplayName,strDescription,strFilename: string):Boolean;

var 
        //ss : TServiceStatus; //psTemp : PChar;
        hSCM,hSCS:THandle;
        srvdesc : PServiceDescription;
        desc : string;
        //SrvType : DWord;
        lpServiceArgVectors:Pwidechar;

begin

    Result:=False;

      hSCM:=OpenSCManager(nil,nil,SC_MANAGER_ALL_ACCESS);//���ӷ������ݿ�
      if hSCM=0 then Exit;
          hSCS:=CreateService( //����������
              hSCM, // ������ƹ������
              Pchar(strServiceName), // ��������
              Pchar(strDisplayName), // ��ʾ�ķ�������
              SERVICE_ALL_ACCESS, // ��ȡȨ��
              SERVICE_WIN32_OWN_PROCESS or SERVICE_INTERACTIVE_PROCESS,// ��������
              SERVICE_AUTO_START, // ��������
              SERVICE_ERROR_IGNORE, // �����������
              Pchar(strFilename), // �������
              nil, // ���������
              nil, // ���ʶ
              nil, // �����ķ���
              nil, // ���������ʺ�
              nil); // �����������

        if hSCS=0 then    Exit;
        if Assigned(ChangeServiceConfig2) then         begin

              desc := Copy(PwideChar(strDescription),1,1024);
              GetMem(srvdesc,SizeOf(TServiceDescription));
              GetMem(srvdesc^.lpDescription,Length(desc) + 1);
              try
                    StrPCopy(PwideChar(srvdesc^.lpDescription),PwideChar(desc));
                    ChangeServiceConfig2(hSCS,SERVICE_CONFIG_DESCRIPTION,srvdesc);

              finally
                    FreeMem(srvdesc^.lpDescription);
                    FreeMem(srvdesc);
              end;

        end;
            lpServiceArgVectors := nil;

          CloseServiceHandle(hSCS); //�رվ��
        Result:=True;

end; 

 

procedure UninstallService(strServiceName:string); 

var
        SCManager: SC_HANDLE;
        Service: SC_HANDLE;
        Status: TServiceStatus;

begin 

        SCManager := OpenSCManager(nil, nil, SC_MANAGER_ALL_ACCESS);
        if SCManager = 0 then Exit;

        try
              Service := OpenService(SCManager, Pchar(strServiceName), SERVICE_ALL_ACCESS);
              ControlService(Service, SERVICE_CONTROL_STOP, Status);
              DeleteService(Service);
              CloseServiceHandle(Service);
        finally
              CloseServiceHandle(SCManager);
        end;

end;

function RunServies(svr:String):Boolean;//����ĳ������
var
        schService:SC_HANDLE;
        schSCManager:SC_HANDLE;
        ssStatus:TServiceStatus;
        Argv:PChar;
begin
        schSCManager:=OpenSCManager(nil,nil,SC_MANAGER_ALL_ACCESS);
        schService:=OpenService(schSCManager,Pchar(svr),SERVICE_ALL_ACCESS);
        result := True;
    try
      if StartService(schService,0,Argv) then
      begin
            while (QueryServiceStatus(schService,ssStatus)) do    begin
                 Sleep(500);
                 if ssStatus.dwCurrentState=SERVICE_START_PENDING then  Sleep(500) else Break;
            end;//while
            if ssStatus.dwCurrentState=SERVICE_RUNNING then  result := True  else  result := False;
      end  else
            result := False;
      finally
            CloseServiceHandle(schService);
            CloseServiceHandle(schSCManager);
      end;

end;


function StopServies(svr:String):Boolean;//ֹͣĳ������
var
      schService:SC_HANDLE;
      schSCManager:SC_HANDLE;
      ssStatus:TServiceStatus;
begin
    schSCManager:=OpenSCManager(nil,nil,SC_MANAGER_ALL_ACCESS);
    schService:=OpenService(schSCManager,Pchar(svr),SERVICE_ALL_ACCESS);
    try
        if ControlService(schService,SERVICE_CONTROL_STOP,ssStatus) then  begin

               Sleep(1000);
               while (QueryServiceStatus(schService,ssStatus)) do     begin
                     if ssStatus.dwCurrentState=SERVICE_STOP_PENDING then
                      Sleep(1000)  else  break;
               end; //while

                if ssStatus.dwCurrentState=SERVICE_STOPPED then
                   result := True   else    result := False;
        end  else
            result := False;
    finally
        CloseServiceHandle(schService);
        CloseServiceHandle(schSCManager);
    end;
end;



function ServiceIsRunning(ServiceName: string): Boolean;//�жϷ����Ƿ�����
var
   SCManager: THandle;
   HService: THandle;
   ServiceStatus: TServiceStatus;
begin
   Result := false;
 { if HInst = 0 then
     Exit;
  }
   SCManager := OpenSCManager(nil, nil, SC_MANAGER_ALL_ACCESS);
  if SCManager <> 0 then
   begin
     HService := OpenService(SCManager, PChar(ServiceName), GENERIC_READ);
    if HService <> 0 then
     begin
      if ControlService(HService, SERVICE_CONTROL_INTERROGATE, ServiceStatus) then
       begin
        //      If QueryServiceStatus(hService, ServiceStatus) Then Begin
        if ServiceStatus.dwCurrentState = SERVICE_RUNNING then
         begin
           Result := true;
        end;
      end;
       CloseServiceHandle(HService);
    end;
     CloseServiceHandle(SCManager);
  end;
end;

function ChangeServiceConfig(ServiceName: string; StartType: Integer): Boolean;//���÷���
var
   SCManager, HService: THandle;
   PConfig: PQueryServiceConfigA;
   Buf: DWORD;
begin
   Result := False;
 // if HInst = 0 then Exit;

   SCManager := OpenSCManager(nil, nil, SC_MANAGER_ALL_ACCESS);
  if SCManager <> 0 then
   begin
     HService := OpenService(SCManager, PChar(ServiceName), SERVICE_ALL_ACCESS);
    if HService <> 0 then
     begin
      New(PConfig);
       QueryServiceConfigA(HService, PConfig, SizeOf(_QUERY_SERVICE_CONFIGA), Buf);
       ChangeServiceConfigA(HService, PConfig.dwServiceType,
         StartType, PConfig.dwErrorControl, PConfig.lpBinaryPathName,
         PConfig.lpLoadOrderGroup, 0, PConfig.lpDependencies,
         PConfig.lpServiceStartName, '', PConfig.lpDisplayName);

       CloseServiceHandle(HService);
       DisPose(PConfig);
       Result := True;
    end
    else
       Result := False;
     CloseServiceHandle(SCManager);
  end
  else
     Result := False;
end;


 

end. 

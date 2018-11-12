unit PublicUnit;

interface
uses
  Windows, SysUtils, Classes, Messages, Forms, StdCtrls, ExtCtrls,
  ComCtrls ,math,UMainDataModule,COMobj,ActiveX,Dialogs,StrUtils,
   IniFiles;

type

  TIni = class(TObject)
    fIniReader: TiniFile;
    fpath: string;
    fIsOpen: boolean;
  public
    //得到Config.ini文件中的配置信息
    constructor Create(MinPath,FileName: string );
    procedure iniClose(FileName: string  );
    function iniIsOpen(FileName: string ): boolean;               //是否Ini 文件被打开
    function iniGetStr(ID: string; secName: string ): string;
    function iniGetInt(ID: string; secName: string ): integer;
    function iniGetFloat(ID: string; secName: string ): Double;
    function iniSetStr(newValue: string; ID: string; secName: string): boolean;
  end;


  TPublicUnit=class(Tobject)
   private
      FReadIni:TIni;

   public
      procedure ReadServerinfo(var S1, S2, S3,S4,S5,S6: string);  //读 数据库配置
      function GetPath:string;
  end;

implementation

{ TPublicUnit }

function TPublicUnit.GetPath: string;
var
   ModuleName,dllpath:WideString;
   i:integer;
begin
          SetLength(ModuleName, 255);
          GetModuleFileName(HInstance, PwideChar(ModuleName), Length(ModuleName));
          dllPath:=Trim(PwideChar(ModuleName)) ;
          i:=Pos('\',ReverseString(dllPath));

          dllPath:=Copy(dllPath,1,Length(dllPath)-i+1);
          Result:=dllPath;

end;

procedure TPublicUnit.ReadServerinfo(var S1, S2, S3, S4, S5, S6: string);
begin
     if  not assigned(fReadini) then
             fReadini.Create(GetPath,'ServerInfo.dll') ;
     s1:=Trim(fReadini.iniGetStr('DataType','Setting'));
     s2:=Trim(fReadini.iniGetStr('SrvIP','Setting'));
     s3:=Trim(fReadini.iniGetStr('UserName','Setting'));
     s4:=Trim(fReadini.iniGetStr('PassWord','Setting'));
     s5:=Trim(fReadini.iniGetStr('FilePath','Setting'));
     s6:=Trim(fReadini.iniGetStr('Port','Setting'));
end;

{ TIni }

constructor TIni.Create(MinPath, FileName: string);
begin
  try
    fpath := MinPath;
    fIniReader := TiniFile.Create(fpath + FileName);
    fIsOpen := true;
  except
    fIsOpen := false;
  end;
end;

procedure TIni.iniClose(FileName: string);
begin

end;

function TIni.iniGetFloat(ID, secName: string): Double;
begin

end;

function TIni.iniGetInt(ID, secName: string): integer;
begin

end;

function TIni.iniGetStr(ID, secName: string): string;
begin

end;

function TIni.iniIsOpen(FileName: string): boolean;
begin

end;

function TIni.iniSetStr(newValue, ID, secName: string): boolean;
begin

end;

end.

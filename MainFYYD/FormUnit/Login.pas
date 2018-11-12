unit Login;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, DB, ADODB, ImgList, Vcl.Buttons,Lu_Public_BasicModual;

type
  TloginForm = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    Edit_Password: TEdit;
    Label2: TLabel;
    Button1: TButton;
    Button2: TButton;
    ComboUserType: TComboBox;
    Lab_UsedDataType: TLabel;
    Button3: TButton;
    Label8: TLabel;
    ComboUserName: TComboBox;
    BitBtn1: TBitBtn;
    Timer1: TTimer;
    Label_Version: TLabel;
    Monotor_RG: TRadioGroup;
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure But_TestisExsitDataBaseClick(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure ComboUserTypeChange(Sender: TObject);
    procedure ComboUserNameChange(Sender: TObject);
    procedure ComboUserTypeClick(Sender: TObject);
    procedure Edit_PasswordClick(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormActivate(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Edit_PasswordKeyPress(Sender: TObject; var Key: Char);
    procedure Monotor_RGClick(Sender: TObject);

  private
    { Private declarations }
    CallWinFormString:String;
    WholeScreen:integer;//�Ƿ���ʾ��ؽ���    0 ����ʾ 1 ȫ�� 2 �����

    procedure  InitLogiFrom;
    procedure  SelectCombox2Index;
    procedure  ReadInfoFromFile; // ��ȡ���ݿ������ļ�
    procedure  SetButtonEnabled(Value:Boolean);
    procedure  RefreshUsedDataType(Value:string);
    procedure  UserCombox(Combo: TComboBox;DataType:integer );
    function   UserPasswordVifty(User_Id,Password:string):Boolean;
     // ����DPI��ʾ
    procedure WMDpiChanged(var Message: TMessage); message WM_DPICHANGED;
  public
    { Public declarations }

  end;

var
   loginForm: TloginForm;
function Createlogin(AHandle:THandle;ACaption:string):integer;stdcall;
implementation

uses   MainForm;

{$R *.dfm}
//�ڲ���ʼ�������溯��
function Createlogin(AHandle:THandle;ACaption:string):integer;stdcall;
begin
        Result:=0;//����ֵ
        if Assigned(loginForm) then FreeAndNil(loginForm);

        loginForm:=TloginForm.Create(nil);
        try
            loginForm.Caption:=ACaption;
            loginForm.WindowState:= wsNormal;
            loginForm.ParentWindow:=Ahandle;
            loginForm.Top:=0;
            loginForm.Left:=0;

            loginForm.Show;

            Result:=1;//����ֵ
        except
            FreeAndNil(loginForm);
        end;
end;
procedure TloginForm.BitBtn1Click(Sender: TObject);
begin
   MainCForm.OpenUserInfoWin('ConfigDateBase',Panel1.Handle);
   CallWinFormString:='configDataBase';
   self.Timer1.Enabled :=true;
end;

procedure TloginForm.Button1Click(Sender: TObject);
var
  s_temp:Str_DT_array;
  C1:integer;
  User_ID,User_Name :string;
begin
    s_temp:=Public_Basic.split(self.ComBoUserName.Text,'_',C1);
    if s_temp[0]='' then exit;
    User_ID:=s_temp[0];
    User_Name:=s_temp[1];
    if not MainCform.UserPasswordVifty(User_ID,Trim(Edit_Password.Text)) then   begin
      messagebox(self.Handle,'����¼����������ϸ¼�룡','ϵͳ��ʾ',mb_iconerror+mb_ok);
      Edit_Password.Text:='';
      exit;
    end;

     if ComboUserType.ItemIndex=0 then begin
        Public_Basic.WriteLoginInfo('UserInFormation',User_Name,User_ID,'1');
        MainCForm.SetUserInfo(User_ID,User_Name,true);
     end else begin
        Public_Basic.WriteLoginInfo('UserInFormation',User_Name,User_ID,'2') ;
        MainCForm.SetUserInfo(User_ID,User_Name,False);
     end;

     MainCForm.Longin_i:=1;

     loginForm.Close;
end;

procedure TloginForm.Button2Click(Sender: TObject);
begin
     loginForm.Close;
end;

procedure TloginForm.Button3Click(Sender: TObject);
begin
    MainCForm.OpenUserInfoWin('NewUser',Panel1.Handle);
    CallWinFormString:='UserInfo';
    self.Timer1.Enabled :=true;
end;

procedure TloginForm.But_TestisExsitDataBaseClick(Sender: TObject);
var
  WStr:WideString;
  port:string;
begin

end;

procedure TloginForm.ComboUserNameChange(Sender: TObject);
begin
    ComboUserName.SetFocus;
    Edit_Password.Text :='';
end;

procedure TloginForm.ComboUserTypeChange(Sender: TObject);
begin
     Self.UserCombox(ComboUserName,ComboUserType.ItemIndex+1);
end;

procedure TloginForm.ComboUserTypeClick(Sender: TObject);
begin
   ComboUserType.SetFocus;
end;

procedure TloginForm.Edit_PasswordClick(Sender: TObject);
begin
   Edit_Password.SetFocus;
end;

procedure TloginForm.Edit_PasswordKeyPress(Sender: TObject; var Key: Char);
begin
     if  (key in [#13,#10]) then
        Button1.SetFocus ;
end;

procedure TloginForm.FormActivate(Sender: TObject);
begin
       ReadInfoFromFile;
       self.Edit_Password.SetFocus ;
end;

procedure TloginForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
    Action:=CaFree;
end;

procedure TloginForm.FormCreate(Sender: TObject);
begin
    self.SelectCombox2Index ;
    CallWinFormString:='';
    InitLogiFrom;
end;

Procedure TloginForm.InitLogiFrom;

begin
   WholeScreen:=public_Basic.ReadDisplayWholeScreen;
   if WholeScreen>2 then  WholeScreen:=0;
   Monotor_RG.ItemIndex := WholeScreen;
end;

procedure TloginForm.Monotor_RGClick(Sender: TObject);
begin
   public_Basic.WriteDisplayWholeScreen(Monotor_RG.ItemIndex);
end;

procedure TloginForm.ReadInfoFromFile;
var
  sDAtaType:string;
  sOut:String;
begin
  if  not Public_Basic.ReadDataBaseType(sOut) then   exit;
   sDAtaType:=UpperCase(sOut);
   if (sDAtaType='SQLSERVER') or (sDAtaType='MYSQL')  or (sDAtaType='ACCESS')then   begin

       if MainCForm.ConnectDataBase then begin
          RefreshUsedDataType(sDAtaType);
            //��������ʹ��
          Self.UserCombox(ComboUserName,1);
          ComboUserName.ItemIndex:=0;
       end;

   end else begin
       BitBtn1.Click;
   end;
end;

procedure TloginForm.RefreshUsedDataType(Value: string);
var
   snapip,sPort:string;
begin
   if public_Basic.ReadSnapData(snapip,sPort) then  begin
      Lab_UsedDataType.Caption :='�������ݿ⡾'+Value+'��Ϊ��ǰʹ�õ����ݿ�' ;
   end else begin
      Lab_UsedDataType.Caption :='��'+Value+'��Ϊ��ǰʹ�õ����ݿ�' ;
   end;

end;

procedure TloginForm.SelectCombox2Index;
var
  sDAtaType:string;
begin
 
end;

procedure TloginForm.SetButtonEnabled(Value: Boolean);
begin

end;

procedure TloginForm.Timer1Timer(Sender: TObject);
begin
  if CallWinFormString<>'' then
     if not MainCForm.GetWinFormIsExsit(CallWinFormString)  then   begin
         ReadInfoFromFile;
         Timer1.Enabled :=False;
         CallWinFormString:='';
     end;

end;

procedure TloginForm.UserCombox(Combo: TComboBox;DataType:integer);
Var
  SOut:String;
  s_temp:Str_DT_array;
  i,C1:integer;
begin
  Sout:=MainCForm.ReturnUserList(DataType);
  Combo.Clear ;
  s_temp:=Public_Basic.split(Sout,',',C1);
  for I := 0 to C1-1 do
    if Trim(s_temp[i])<>'' then
       Combo.Items.Add(s_temp[i]);
end;

function TloginForm.UserPasswordVifty(User_Id, Password: string): Boolean;
begin

end;

procedure TloginForm.WMDpiChanged(var Message: TMessage);
  {$IFDEF DELPHI_STYLE_SCALING}
  function FontHeightAtDpi(aDPI, aFontSize: integer): integer;
  var
    tmpCanvas: TCanvas;
  begin
    tmpCanvas := TCanvas.Create;
    try
      tmpCanvas.Handle := GetDC(0);
      tmpCanvas.Font.Assign(self.Font);
      tmpCanvas.Font.PixelsPerInch := aDPI; //must be set BEFORE size
      tmpCanvas.Font.size := aFontSize;
      result := tmpCanvas.TextHeight('0');
    finally
      tmpCanvas.free;
    end;
  end;
  {$ENDIF}

begin
  inherited;
  {$IFDEF DELPHI_STYLE_SCALING}
  ChangeScale(FontHeightAtDpi(LOWORD(Message.wParam), self.Font.Size), FontHeightAtDpi(self.PixelsPerInch, self.Font.Size));
  {$ELSE}
  ChangeScale(LOWORD(Message.wParam), self.PixelsPerInch);
  {$ENDIF}
  self.PixelsPerInch := LOWORD(Message.wParam);


end;

end.
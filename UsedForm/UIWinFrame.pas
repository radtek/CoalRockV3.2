unit UIWinFrame;

//<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
//<<      �ļ�����UIWinFrame.pas                          <<
//<<      luleiʹ�õĸ���Delphi�ļ�                            <<
//<<      ���ļ���WinFrame.dll delphi  �����ļ�           <<
//<<      ���ļ��� dll�ļ�һͬ������dll����Ҫע��ʹ��          <<
//<<      �������ڣ�2016.5.12                                   <<
//<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

interface

uses  Classes;

type

   TDefine_WinFrame = class (TObject)
     protected

     public
          //����¼�������Ϣ
          function CreateZkBasic(AHandle:THandle;Caption:Pansichar;Width,Heigth:integer):THandle; virtual;abstract;
          function CreateZkDetail(AHandle:THandle;Caption:Pansichar;Width,Heigth:integer):THandle; virtual;abstract;
          function CreateGzmLinkZk(AHandle:THandle;Caption:Pansichar;Width,Heigth:integer):THandle; virtual;abstract;
          function CreateSupport(AHandle:THandle;Caption:Pansichar;Width,Heigth:integer):THandle; virtual;abstract;
          function CreateCoalName(AHandle:THandle;Caption:Pansichar;Width,Heigth:integer):THandle; virtual;abstract;
          function CreateWorkFace(AHandle:THandle;Caption:Pansichar;Width,Heigth:integer):THandle;virtual;abstract;
          function CreateGZmFileName(AHandle:THandle;Caption:Pansichar;Width,Heigth:integer):THandle; virtual;abstract;
          function CreatePressBmp(AHandle:THandle;Caption:Pansichar;Width,Heigth,Flag:integer):THandle; virtual;abstract;

          function CreateCADImage(AHandle:THandle;Caption:Pansichar;Width,Heigth:integer):THandle; virtual;abstract;
          function CreateUserINFO(AHandle:THandle;Caption,Name:Pansichar;Width,Heigth:integer):THandle;  virtual;abstract;
          procedure CreateUserAdmin(AHandle:THandle;Caption:Pansichar;Width,Heigth:integer); virtual;abstract;
          function CreateConfiDataBase(AHandle:THandle;Caption:Pansichar;Width,Heigth,config:integer):THandle; virtual;abstract;
          procedure CreateSelectedWorkFaceINFo(AHandle:THandle;Caption:Pansichar;Width,Heigth,Flag:integer); virtual;abstract;
          procedure CreateBmpToSqlite(AHandle:THandle;Caption:Pansichar;Width,Heigth:integer); virtual;abstract;
          function CreatYklh_Form(AHandle:THandle;Caption:Pansichar;Width,Heigth:integer):THandle; virtual;abstract;
          function ShowMapForm(AHandle:THandle;Caption:Pansichar;Width,Heigth,single:integer):THandle; virtual;abstract;
          function CreateOpenWordFrom(AHandle:THandle;Caption:Pansichar;Width,Heigth,single:integer):THandle; virtual;abstract;

          procedure SetMapAllMarker;virtual;abstract;
          procedure SetMapDispScal(Value:integer);virtual;abstract;

          procedure SetUsetInformation(UserID,UserName:Pansichar;Admin:Boolean);  virtual;abstract;
          // ������Ϣ
          {����ǳ�������������,��Ҫ��ConnectDataBase ����
           ����������óɹ���������Ϣ�Ѿ�д��������ļ�������ֱ�ӵ��� RecallConnectDataBase ������ģ�����ݿ�
          }
          function ConnectDataBase(DataType,DataBaseName,MySQLAddress : Pansichar; MySQLPort : Integer;
                          UserName : Pansichar; Password : Pansichar) : WordBool;virtual;abstract;

          function  RecallConnectDataBase:Boolean; virtual;abstract;
          //���ݷ���
          function ReturnUserList(DataType:integer):Pansichar;virtual;abstract;
          function UserPasswordVifty(User_Id, Password: Pansichar): Boolean;virtual;abstract;
          function GetWinFormIsExsit(WinName:Pansichar):Boolean;virtual;abstract;
          procedure CloseActiveForm(FormStr:Pansichar); virtual;abstract;
          function GetMainFormVersion(const Version:integer;var BmpFile:Pansichar):Pansichar; virtual;abstract;
          function GetImageFromDataBase(tableName,Imagefield,FileField,idName:Pansichar;idValue:integer):Pansichar; virtual;abstract;
          function GetMeiKuangInFormation:Pansichar; virtual;abstract;
          function GetWorkFaceDataType(workFaceid:integer):integer; virtual;abstract;
          function GEtWorkFaceBhList(Mkid:integer):Pansichar;virtual;abstract;
          function verificationGzmLinkZk(Gzmid,Zkid:integer):Boolean; virtual;abstract;
          procedure GetMinAndMaxJinDao(MinD,MaxD:integer); virtual;abstract;

          function FreeWindows(Str: Pansichar):Boolean; virtual;abstract;
          procedure SetStatuesCaption(Value:PansiChar); virtual;abstract;
         //ϵͳ����
          constructor Create; virtual;abstract;
   end;

   TClassStateMent_WinFrame = class of TDefine_WinFrame;

implementation
    //no context
{ TIRockPress }


end.
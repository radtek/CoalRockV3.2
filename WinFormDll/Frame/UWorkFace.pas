unit UWorkFace;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, System.ImageList,
  Vcl.ImgList, Vcl.ComCtrls, Vcl.ToolWin, Vcl.Grids, Vcl.StdCtrls, Vcl.ExtCtrls,

  MySQLDataSet;

type
  TWorkFaceFrame = class(TFrame)
    Splitter1: TSplitter;
    Label10: TLabel;
    Panel1: TPanel;
    Label1: TLabel;
    Label3: TLabel;
    Label2: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label15: TLabel;
    Label14: TLabel;
    Label13: TLabel;
    Label16: TLabel;
    Label12: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    LablMK: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    Label28: TLabel;
    Label29: TLabel;
    Label30: TLabel;
    Label31: TLabel;
    Label36: TLabel;
    Label25: TLabel;
    Label32: TLabel;
    Label35: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label11: TLabel;
    Label19: TLabel;
    Label39: TLabel;
    Label40: TLabel;
    Label41: TLabel;
    Label42: TLabel;
    Label43: TLabel;
    Label44: TLabel;
    Shape1: TShape;
    Shape2: TShape;
    Shape3: TShape;
    Shape4: TShape;
    Label46: TLabel;
    Label47: TLabel;
    Label48: TLabel;
    Label4: TLabel;
    Label51: TLabel;
    Label52: TLabel;
    Label53: TLabel;
    ComboKName: TComboBox;
    EditCqName: TEdit;
    ComboMcId: TComboBox;
    EditMcHd: TEdit;
    EditzKcgd: TEdit;
    ComboCmFa: TComboBox;
    EditGc: TEdit;
    EditZxc: TEdit;
    Editqj2: TEdit;
    Editqj1: TEdit;
    EditQxc: TEdit;
    ComboMKy: TComboBox;
    Combozhqk: TComboBox;
    ComboZJType: TComboBox;
    ComboYxFx: TComboBox;
    ComboJYhd: TComboBox;
    EditSpeed: TEdit;
    Panel3: TPanel;
    Label33: TLabel;
    Label34: TLabel;
    UPYes: TRadioButton;
    UPNO: TRadioButton;
    EditUPMz: TEdit;
    Panel4: TPanel;
    Label37: TLabel;
    Label38: TLabel;
    DownYes: TRadioButton;
    DownNo: TRadioButton;
    EditDownMz: TEdit;
    ComboDzgz: TComboBox;
    EditSh1: TEdit;
    Editsh2: TEdit;
    ComboBottomWater: TComboBox;
    ComboTopWater: TComboBox;
    ComboWs: TComboBox;
    ComboHdzh: TComboBox;
    ComboKsyl: TComboBox;
    ComboStress: TComboBox;
    FcRadioButton: TRadioGroup;
    EditJueJin: TEdit;
    Button1: TButton;
    GroupBox1: TGroupBox;
    Label49: TLabel;
    Label50: TLabel;
    DateTimePicker1: TDateTimePicker;
    DateTimePicker2: TDateTimePicker;
    ComboSupNumberDirection: TComboBox;
    SupStartNumber: TEdit;
    SupEndNumber: TEdit;
    cboQyzt: TComboBox;
    CkCkq: TButton;
    CkDc: TButton;
    CkMz: TButton;
    CreatTable: TButton;
    btnBf: TButton;
    btnHf: TButton;
    CoolBar1: TCoolBar;
    ToolBar1: TToolBar;
    AddButton: TToolButton;
    EditButton: TToolButton;
    SaveButton: TToolButton;
    DeleteButton: TToolButton;
    ExitButton: TToolButton;
    ImageList1: TImageList;
    OpenDialog1: TOpenDialog;
    Panel2: TPanel;
    StringGrid1: TStringGrid;
    procedure ExitButtonClick(Sender: TObject);
  private
    { Private declarations }
   // FinGzm:TGzm;
    MySqlDataSet1:TMyDataSet;
    MySqlDataSet2:TMyDataSet;
    MyCommand1:TMyCommand;
    i_Kid:Integer;   //��ID������ ID
    Save_Lx:string; // 13-3-22-zry ����ʱ���������ͣ��������޸�    ʹ��ԭ  i_Zid �������ڴ���
   // Ext_ParentWindow:THandle;
    gzmqyzt:Integer ;//2016-7-2 ��������Ϣ�޸�֮ǰ������״̬
    procedure SetCellHead; //����Cell��ͷ
    procedure FillCell(kuangjingbianhao:Integer); //������
    procedure IninComboBox;  //��ʼ��ComboBox
    procedure ClearEdit;   //��ձ༭��
    function checkInputEdit:wordbool; //���¼���ʽ�Ƿ�ϸ�
    procedure SetEnable(ISCanEnable:bool);
    procedure CboCsh(ISCom:bool); //combox��ʼ����ʱ��ѡ���һ�true��ʼ������Ϊ�գ�falseΪ���ӻ��޸�ʹ�ã�����һ��

  public
    { Public declarations }
    procedure InitFrame;
  end;
var
  WorkFaceFrame: TWorkFaceFrame;
procedure inn_WorkFace(AHandle:THandle);

implementation

{$R *.dfm}

uses uWinFrameClass, Lu_base_function;

procedure inn_WorkFace(AHandle:THandle);
//Var
//    WorkFaceFrame: TWorkFaceFrame;
begin
     Application.Handle:=Ahandle;
     if Assigned(WorkFaceFrame) then FreeAndNil(WorkFaceFrame) ;

     try
        WorkFaceFrame:=TWorkFaceFrame.Create(Application);

        WorkFaceFrame.ParentWindow:=Ahandle;

        WorkFaceFrame.Show;
        WorkFaceFrame.InitFrame;
     except
        FreeAndNil(WorkFaceFrame) ;
     end;
end;


{ TFrame1 }

{ TWorkFaceFrame }

procedure TWorkFaceFrame.CboCsh(ISCom: bool);
begin

end;

function TWorkFaceFrame.checkInputEdit: wordbool;
begin

end;

procedure TWorkFaceFrame.ClearEdit;
begin

end;



procedure TWorkFaceFrame.ExitButtonClick(Sender: TObject);
begin
   FreeAndNil(WorkFaceFrame);
end;

procedure TWorkFaceFrame.FillCell(kuangjingbianhao: Integer);
begin

end;

procedure TWorkFaceFrame.IninComboBox;
var
   t:TDateTime;
begin
 //  MySQlFillComBox(MySqlDataSet1,ComboCmFa,'select zdid,Text from zdname  where zdname=''cmfa'' order by zdid','zdid','Text',''); //��ú����
      uMyDataModule.ComboList(ComboCmFa,'select zdid,Text from zdname  where zdname=''cmfa'' order by zdid','zdid','Text',''); //��ú����
      uMyDataModule.ComboList(self.ComboMKy,'select zdid,Text from zdname  where zdname=''mtyd'' order by zdid','zdid','Text',''); //ú��Ӳ��
      uMyDataModule.ComboList(self.Combozhqk ,'select zdid,Text from zdname  where zdname=''zhqk'' order by zdid','zdid','Text',''); //֧�����
      uMyDataModule.ComboList(self.ComboYxFx ,'select zdid,Text from zdname  where zdname=''YxFX'' order by zdid','zdid','Text',''); //  ��б��б

      uMyDataModule.ComboList(self.ComboJYhd  ,'select zdid,Text from zdname  where zdname=''JYHD'' order by zdid','zdid','Text',''); // ���Һ��
      uMyDataModule.ComboList(self.ComboDzgz  ,'select zdid,Text from zdname  where zdname=''DCGZ'' order by zdid','zdid','Text',''); // ���ʹ���
      uMyDataModule.ComboList(self.ComboWs  ,'select zdid,Text from zdname  where zdname=''WSFC'' order by zdid','zdid','Text',''); //  ��˹
      uMyDataModule.ComboList(self.ComboTopWater  ,'select zdid,Text from zdname  where zdname=''TopWater'' order by zdid','zdid','Text',''); //  ����ˮ
      uMyDataModule.ComboList(self.ComboBottomWater  ,'select zdid,Text from zdname  where zdname=''BottomWater'' order by zdid','zdid','Text',''); //  �װ�ˮ
      uMyDataModule.ComboList(self.ComboStress  ,'select zdid,Text from zdname  where zdname=''HeoStress'' order by zdid','zdid','Text',''); //  �װ�ˮ
      uMyDataModule.ComboList(self.ComboKsyl  ,'select zdid,Text from zdname  where zdname=''Kyxx'' order by zdid','zdid','Text',''); //  �װ�ˮ

      uMyDataModule.ComboList(self.ComboHdzh   ,'select zdid,Text from zdname  where zdname=''HangDaoSup'' order by zdid','zdid','Text',''); // ���֧��
     // uMyDataModule.cbolist(self.ComboZJType  ,'select xh,id from zjxhb  order by id','xh','',''); //  ֧���ͺ�

      self.DateTimePicker1.Date:=Now;
//      t:= IncMonth(now,-1);
      DateTimePicker1.DateTime := Now-60;
      DateTimePicker2.DateTime := Now;
////    self.DateTimePicker2.Date:=strtodate(FormatDateTime('yyyy',t)+ '-' + FormatDateTime('mm',t)+'-' + FormatDateTime('dd',t));

end;

procedure TWorkFaceFrame.InitFrame;
begin
    MySqlDataSet1:=TMyDataSet.Create(nil);
    MySqlDataSet1.MySqlConnection :=uMyDataModule.ExConn;
    MySqlDataSet2:=TMyDataSet.Create(nil);
    MySqlDataSet2.MySqlConnection :=uMyDataModule.ExConn;
    MyCommand1:=TMyCommand.Create (nil);
    MyCommand1.MySqlConnection :=uMyDataModule.ExConn;
    StringGrid1:=TStringGrid.Create(Application);
    StringGrid1.ParentWindow:=Application.Handle;
    //
    IninComboBox;
end;

procedure TWorkFaceFrame.SetCellHead;
begin

end;

procedure TWorkFaceFrame.SetEnable(ISCanEnable: bool);
begin

end;

end.
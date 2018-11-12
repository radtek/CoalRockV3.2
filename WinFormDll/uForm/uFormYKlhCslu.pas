unit uFormYKlhCslu;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, ComCtrls, ToolWin, ImgList, System.ImageList;

type
  TFormYKLH_jingji = class(TForm)
    Panel1: TPanel;
    GroupBox2: TGroupBox;
    Label20: TLabel;
    TCoalPrice: TEdit;
    Label21: TLabel;
    Label1: TLabel;
    CtWallPrice: TEdit;
    ZongHePrice: TEdit;
    Label5: TLabel;
    Label7: TLabel;
    Label2: TLabel;
    Label22: TLabel;
    CoalHangJueJinPrice: TEdit;
    Label23: TLabel;
    Label24: TLabel;
    HangDaoWeiHuprice: TEdit;
    Label25: TLabel;
    GroupBox3: TGroupBox;
    Label12: TLabel;
    ctWallH: TEdit;
    Label13: TLabel;
    Label8: TLabel;
    HangDaoCtWid: TEdit;
    Label6: TLabel;
    Label10: TLabel;
    YLHangDaoWid: TEdit;
    Label11: TLabel;
    Label26: TLabel;
    CTWallBehindJuli: TEdit;
    Label27: TLabel;
    ToolBar1: TToolBar;
    EditButton: TToolButton;
    SaveButton: TToolButton;
    DeleteButton: TToolButton;
    ExitButton: TToolButton;
    ImageList1: TImageList;
    Panel2: TPanel;
    Label15: TLabel;
    Label19: TLabel;
    gzmName: TEdit;
    NormalMzwid: TEdit;
    Label18: TLabel;
    Label16: TLabel;
    Label14: TLabel;
    NormalSpeed: TEdit;
    YklhSpeed: TEdit;
    Label17: TLabel;
    Label9: TLabel;
    StatusBar1: TStatusBar;
    procedure FormShow(Sender: TObject);

    procedure ExitButtonClick(Sender: TObject);
    procedure EditButtonClick(Sender: TObject);
    procedure SaveButtonClick(Sender: TObject);
    procedure YklhSpeedClick(Sender: TObject);
    procedure NormalMzwidClick(Sender: TObject);
    procedure NormalSpeedClick(Sender: TObject);
    procedure TCoalPriceClick(Sender: TObject);
    procedure CtWallPriceClick(Sender: TObject);
    procedure ctWallHClick(Sender: TObject);
    procedure ZongHePriceClick(Sender: TObject);
    procedure HangDaoCtWidClick(Sender: TObject);
    procedure CoalHangJueJinPriceClick(Sender: TObject);
    procedure YLHangDaoWidClick(Sender: TObject);
    procedure HangDaoWeiHupriceClick(Sender: TObject);
    procedure CTWallBehindJuliClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure DeleteButtonClick(Sender: TObject);
  private
    { Private declarations }
     procedure OptionTip(Str:String);
     procedure FillEditValue(WorkFaceid:string);
     procedure SetEditnabled(Value:Boolean);
     procedure Clearedit;
     function CheckEditInput:Boolean;
  public
    { Public declarations }
  end;

var
  FormYKLH_jingji: TFormYKLH_jingji;
  function CreateYklhForm(AHandle:THandle;ACaption:string;Wid,Hi:integer):THandle;stdcall;
implementation

{$R *.dfm}

uses Lu_Public_BasicModual, UMainDataModule;

//�ڲ���ʼ�������溯��
function CreateYklhForm(AHandle:THandle;ACaption:string;Wid,Hi:integer):THandle;stdcall;

begin
       if Assigned(FormYKLH_jingji) then  FreeAndNil(FormYKLH_jingji);

       FormYKLH_jingji:=TFormYKLH_jingji.Create(nil);
        try
           with FormYKLH_jingji do begin
               Caption:=ACaption;
               WindowState:= wsNormal;
               ParentWindow:=Ahandle;

               if Hi >Height then
                   Top :=Round((Hi-Height)/3)  else   Top :=0;
               if Wid> Width then
                   Left:=Round((Wid-Width)/2)  else   Left:=0;

                Show;
                SetFocus;
                Result:=FormYKLH_jingji.Handle ;//����ֵ
          end ;
        except
           FreeAndNil(FormYKLH_jingji);
        end;
end;

function TFormYKLH_jingji.CheckEditInput: Boolean;
begin
   Result:=False ;
   {       tCoalprice.Enabled :=value;  //   ��ú����
           YLmzwid.Enabled :=value;       //  Ԥ��ú������
           CtWallPrice.Enabled :=value;// ǽ��ɱ�
           CtwallH.Enabled :=value;     // ����ǽ��߶�
           YLHangDaoWid.Enabled :=value;// Ԥ���������
           HangDaoCtWid.Enabled :=value;//������Ԥ�����

           NormalSpeed.Enabled :=value; // ���ؿ������ƽ��ٶ�
           NormalMzwid.Enabled :=value;  // ���ؿ�����ú������
           YklhSpeed.Enabled :=value;  // �ؿ�������ƽ��ٶ�
           HangDaoWeiHuprice.Enabled :=value;   // ���ά���۸�
           CoalHangJueJinPrice.Enabled :=value; // ú�����۸�
           ZongHePrice.Text:=Enabled :=value;     // ��ú�ۺϳɱ�
           CTWallBehindJuli.Enabled :=value;    //�������ͺ����
    }
    if MainDataModule.WorkFace_id='' then  exit;

    if Trim(tCoalprice.Text)='' then     begin
      showmessage('�������ú�ۼۣ�');
       exit;
    end ;

    if self.NormalMzwid.Text='' then     begin
      showmessage('������Ԥ��ú�����ȣ�');
      exit;
    end ;

    if self.CtWallPrice.Text='' then   begin
      showmessage('������ǽ��ɱ���');
      exit;
    end ;

    if self.HangDaoCtWid.Text='' then     begin
      showmessage('���������Գ�����Ԥ����ȣ�');
      exit;
    end ;
    Result:=true;
end;

procedure TFormYKLH_jingji.Clearedit;
begin
    TCoalprice.Text:='';  //   ��ú����
   CtWallPrice.Text:=''; // ǽ��ɱ�
   CtwallH.Text:='';        // ����ǽ��߶�
   YLHangDaoWid.Text:='';// Ԥ���������
   HangDaoCtWid.text :='';//������Ԥ�����

   NormalSpeed.Text:=''; // ���ؿ������ƽ��ٶ�
   NormalMzwid.Text:='';  // ���ؿ�����ú������
   YklhSpeed.Text:='';  // �ؿ�������ƽ��ٶ�
   HangDaoWeiHuprice.Text:='';  // ���ά���۸�
   CoalHangJueJinPrice.Text:='';  // ú�����۸�
   ZongHePrice.Text:='';     // ��ú�ۺϳɱ�
   CTWallBehindJuli.Text:='';   //�������ͺ����
end;

procedure TFormYKLH_jingji.CoalHangJueJinPriceClick(Sender: TObject);
begin
   CoalHangJueJinPrice.SetFocus;
end;

procedure TFormYKLH_jingji.CTWallBehindJuliClick(Sender: TObject);
begin
   CTWallBehindJuli.SetFocus ;
end;

procedure TFormYKLH_jingji.ctWallHClick(Sender: TObject);
begin
   ctWallH.SetFocus;
end;

procedure TFormYKLH_jingji.CtWallPriceClick(Sender: TObject);
begin
   CtWallPrice.SetFocus;
end;

procedure TFormYKLH_jingji.DeleteButtonClick(Sender: TObject);
var
cSSQL:String;
begin
     if Trim(MainDataModule.WorkFace_id) =''  then exit;
    try
        CSsql:='delete from  YKLH_benefits where gzmid = '+ MainDataModule.WorkFace_id ;
        MainDataModule.MyCommand.CommandText :=CSsql;
        MainDataModule.MyCommand.Execute;
    finally
      OptionTip('����ɾ���ɹ���');
      Clearedit;
    end;
//
end;

procedure TFormYKLH_jingji.EditButtonClick(Sender: TObject);
begin
   SetEditnabled(true);
end;

procedure TFormYKLH_jingji.ExitButtonClick(Sender: TObject);
begin
  close;
end;


procedure TFormYKLH_jingji.FillEditValue(WorkFaceid: string);
begin
        MainDataModule.MyDataSet.Close();
        MainDataModule.MyDataSet.CommandText:='select * from YKLH_benefits where gzmid='+WorkFaceid;
       try
        if (MainDataModule.MyDataSet.Open) and (MainDataModule.MyDataSet.RecordCount>0 )  then begin
           SetEditnabled(false);
           TCoalprice.Text:=FormatFloat('0.00',
                         MainDataModule.MyDataSet.FieldByName('TCoalprice').AsFloat);  //   ��ú����
           CtWallPrice.Text:=FormatFloat('0.00',
                            MainDataModule.MyDataSet.FieldByName('CtWallPrice').AsFloat); // ǽ��ɱ�
           CtwallH.Text:= FormatFloat('0.00',
                           MainDataModule.MyDataSet.FieldByName('CtwallH').AsFloat);         // ����ǽ��߶�
           YLHangDaoWid.Text:=FormatFloat('0.00',
                           MainDataModule.MyDataSet.FieldByName('YLHangDaoWid').AsFloat);// Ԥ���������
           HangDaoCtWid.text := FormatFloat('0.00',
                           MainDataModule.MyDataSet.FieldByName('HangDaoCtWid').AsFloat);//������Ԥ�����

           NormalSpeed.Text:=FormatFloat('0.00',
                        MainDataModule.MyDataSet.FieldByName('NormalSpeed').AsFloat); // ���ؿ������ƽ��ٶ�
           NormalMzwid.Text:=FormatFloat('0.00',
                        MainDataModule.MyDataSet.FieldByName('NormalMzwid').AsFloat);  // ���ؿ�����ú������
           YklhSpeed.Text:=FormatFloat('0.00',
                        MainDataModule.MyDataSet.FieldByName('YklhSpeed').AsFloat);   // �ؿ�������ƽ��ٶ�
           HangDaoWeiHuprice.Text:=FormatFloat('0.00',
                        MainDataModule.MyDataSet.FieldByName('HangDaoWeiHuprice').AsFloat);   // ���ά���۸�
           CoalHangJueJinPrice.Text:=FormatFloat('0.00',
                        MainDataModule.MyDataSet.FieldByName('CoalHangJueJinPrice').AsFloat);  // ú�����۸�
           ZongHePrice.Text:=FormatFloat('0.00',
                        MainDataModule.MyDataSet.FieldByName('ZongHePrice').AsFloat);      // ��ú�ۺϳɱ�
           CTWallBehindJuli.Text:=FormatFloat('0.00',
                        MainDataModule.MyDataSet.FieldByName('CTWallBehindJuli').AsFloat);    //�������ͺ����

        end else begin
           Clearedit;
           SetEditnabled(false);
        end;
       finally
           MainDataModule.MyDataSet.Close();
       end;

end;

procedure TFormYKLH_jingji.FormCreate(Sender: TObject);
begin
    MainDataModule.ReadPublicUsedMkInfoFromFile;
    Clearedit;
end;

procedure TFormYKLH_jingji.FormShow(Sender: TObject);
var
  bsstjjl,bssylmz,sstjjl,dmsj,hdwhcb,mhjjcb,qtcb,zhcb,ctqt,hpct,tctzh,ylhd,ylmz:single;
begin
   PubLic_Basic.InitStatusBar (self.StatusBar1);
   FillEditValue(MainDataModule.WorkFace_id);
   gzmName.Text :=MainDataModule.WorkFace_Name;
end;

procedure TFormYKLH_jingji.HangDaoCtWidClick(Sender: TObject);
begin
   HangDaoCtWid.SetFocus;
end;

procedure TFormYKLH_jingji.HangDaoWeiHupriceClick(Sender: TObject);
begin
   HangDaoWeiHuprice.SetFocus;
end;

procedure TFormYKLH_jingji.NormalMzwidClick(Sender: TObject);
begin
    NormalMzwid.SetFocus;
end;

procedure TFormYKLH_jingji.NormalSpeedClick(Sender: TObject);
begin
    NormalSpeed.SetFocus;
end;

procedure TFormYKLH_jingji.OptionTip(Str: String);
begin
   self.StatusBar1.Panels[0].Text :=str;
end;


procedure TFormYKLH_jingji.SaveButtonClick(Sender: TObject);
var
 CSsql:string;
begin
    {

      tCoalprice.Enabled :=value;  //   ��ú����
           YLmzwid.Enabled :=value;       //  Ԥ��ú������
           CtWallPrice.Enabled :=value;// ǽ��ɱ�
           CtwallH.Enabled :=value;     // ����ǽ��߶�
           YLHangDaoWid.Enabled :=value;// Ԥ���������
           HangDaoCtWid.Enabled :=value;//������Ԥ�����

           NormalSpeed.Enabled :=value; // ���ؿ������ƽ��ٶ�
           NormalMzwid.Enabled :=value;  // ���ؿ�����ú������
           YklhSpeed.Enabled :=value;  // �ؿ�������ƽ��ٶ�
           HangDaoWeiHuprice.Enabled :=value;   // ���ά���۸�
           CoalHangJueJinPrice.Enabled :=value; // ú�����۸�
           ZongHePrice.Text:=Enabled :=value;     // ��ú�ۺϳɱ�
           CTWallBehindJuli.Enabled :=value;    //�������ͺ����
    }
   if not self.CheckEditInput  then exit;
    try
        CSsql:='insert into YKLH_benefits(gzmid,gzmName,tCoalprice,CtWallPrice,CtwallH,YLHangDaoWid,HangDaoCtWid, NormalSpeed,'+
                     '  NormalMzwid,YklhSpeed,HangDaoWeiHuprice,CoalHangJueJinPrice,ZongHePrice,CTWallBehindJuli) values('+
                      MainDataModule.WorkFace_id +','''+MainDataModule.WorkFace_Name +''',' +
                      tCoalprice.Text+','+ CtWallPrice.Text +','+
                      CtwallH.Text+','+YLHangDaoWid.Text+','+ HangDaoCtWid.Text +','+
                      NormalSpeed.Text+','+NormalMzwid.Text+','+ YklhSpeed.Text +','+
                      HangDaoWeiHuprice.Text+','+CoalHangJueJinPrice.Text+','+ ZongHePrice.Text +','+
                      CTWallBehindJuli.Text+    ')';
        MainDataModule.MyCommand.CommandText :=CSsql;
        MainDataModule.MyCommand.Execute;
    finally
      OptionTip('���ݴ洢�ɹ���');
    end;
//

end;

procedure TFormYKLH_jingji.SetEditnabled(Value: Boolean);
begin
           tCoalprice.Enabled :=value;  //   ��ú����
           CtWallPrice.Enabled :=value;// ǽ��ɱ�
           CtwallH.Enabled :=value;     // ����ǽ��߶�
           YLHangDaoWid.Enabled :=value;// Ԥ���������
           HangDaoCtWid.Enabled :=value;//������Ԥ�����

           NormalSpeed.Enabled :=value; // ���ؿ������ƽ��ٶ�
           NormalMzwid.Enabled :=value;  // ���ؿ�����ú������
           YklhSpeed.Enabled :=value;  // �ؿ�������ƽ��ٶ�
           HangDaoWeiHuprice.Enabled :=value;   // ���ά���۸�
           CoalHangJueJinPrice.Enabled :=value; // ú�����۸�
           ZongHePrice.Enabled :=value;     // ��ú�ۺϳɱ�
           CTWallBehindJuli.Enabled :=value;    //�������ͺ����

end;



procedure TFormYKLH_jingji.TCoalPriceClick(Sender: TObject);
begin
   TCoalPrice.SetFocus ;
end;

procedure TFormYKLH_jingji.YklhSpeedClick(Sender: TObject);
begin
    YklhSpeed.SetFocus;
end;

procedure TFormYKLH_jingji.YLHangDaoWidClick(Sender: TObject);
begin
   YLHangDaoWid.SetFocus;
end;

procedure TFormYKLH_jingji.ZongHePriceClick(Sender: TObject);
begin
   ZongHePrice.SetFocus;
end;

end.

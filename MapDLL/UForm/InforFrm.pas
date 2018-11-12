unit InforFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, ValEdit, Buttons, StdCtrls, ExtCtrls;

type
  TfrmInfor = class(TForm)
    Panel1: TPanel;
    SG_DX: TStringGrid;
    Panel2: TPanel;
    Label1: TLabel;
    Splitter1: TSplitter;
    Panel3: TPanel;
    SG_Field: TStringGrid;
    Panel4: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure SG_DXSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    Excel_field,Field_name : Array [0..80] of string;

  public
    { Public declarations }
    Mapx_Out_in:Boolean;
    procedure  init_SG_Dx();
    procedure fillSG_DXStringGrid(Sql:String);
  end;


 var
    FfrmInfor: TfrmInfor;
    function OpenSelectResult(AHandle:THandle;ACaption,sql:string;Wid,Hi:integer):integer;stdcall;
implementation

uses Lu_Public_BasicModual, UMainDataModule;


{$R *.dfm}

function OpenSelectResult(AHandle:THandle;ACaption,sql:string;Wid,Hi:integer):integer;stdcall;
 begin
       if Assigned(FfrmInfor) then  FreeANdNil(FfrmInfor);
        FfrmInfor:=TfrmInfor.Create(nil);
        try
           with FfrmInfor do begin
               Caption:=ACaption;
               WindowState:= wsNormal;
               ParentWindow:=Ahandle;

               if Hi >Height then
                   Top :=Round((Hi-Height)/3)  else  Top :=0;

               if Wid> Width then
                   Left:=Round((Wid-Width)/2)  else   Left:=0;
                FillSG_DXStringGrid(sql);
                Show;
                SetFocus;
                Result:=1;//����ֵ
          end ;
        except
           FreeAndNil(FfrmInfor);
        end;
 end;
   

procedure TfrmInfor.BitBtn1Click(Sender: TObject);
begin
   Public_Basic.StringGridtoExcel(self.Label1.Caption ,self.SG_DX,10);
end;

procedure TfrmInfor.BitBtn2Click(Sender: TObject);
begin
   Public_Basic.Stringgridtoexcel('' ,self.SG_Field,10);
end;

procedure TfrmInfor.fillSG_DXStringGrid(Sql: String);
var
 i:integer;
begin
      self.init_SG_Dx ;

      MainDataModule.MyDataSet.Close();
      MainDataModule.MyDataSet.CommandText:='select bh,zj_type,Mt_address,zj_name from Mapbh  ' + Sql ;
      MainDataModule.MyDataSet.Open();
      i:=1;
      while not MainDataModule.MyDataSet.Eof  do begin
            SG_DX.Cells[0,i]:=MainDataModule.MyDataSet.FieldByName('bh').AsString;
            SG_DX.Cells[1,i]:=MainDataModule.MyDataSet.FieldByName('Mt_address').AsString;
            SG_DX.Cells[2,i]:=MainDataModule.MyDataSet.FieldByName('Zj_type').AsString;
            SG_DX.Cells[3,i]:=MainDataModule.MyDataSet.FieldByName('zj_name').AsString;
            MainDataModule.MyDataSet.Next;
            if SG_DX.RowCount-2 <i then  SG_DX.RowCount:=i+2;
            i:=i+1;
          end;
      MainDataModule.MyDataSet.Close();
end;

procedure TfrmInfor.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
   if Assigned(FfrmInfor) then  FreeANdNil(FfrmInfor);
end;

procedure TfrmInfor.FormCreate(Sender: TObject);
var
   I:integer;
begin
          Excel_field[1]:='bh';              Field_name[1]:='���';
          Excel_field[2]:='Tu_bh';        Field_name[2]:='ͼ���';
          Excel_field[3]:='ZJ_Type';      Field_name[3]:='֧���ͺ�';
          Excel_field[4]:='ZJ_name';      Field_name[4]:='֧������';
          Excel_field[5]:='ZJ_D_name';    Field_name[5]:='֧�����������';
          Excel_field[6]:='Mt_address';   Field_name[6]:='ú������';
          Excel_field[7]:='Mc_ZJ_name';   Field_name[7]:='ú����';
          Excel_field[8]:='Gzm_l';        Field_name[8]:='������б��';
          Excel_field[9]:='Gzm_h';        Field_name[9]:='�ɸ�';
          Excel_field[10]:='Mc_name';     Field_name[10]:='ú������';
          Excel_field[11]:='Mc_h';        Field_name[11]:='ú��߶�';
          Excel_field[12]:='Mc_f';        Field_name[12]:='ú��Ӳ��';
          Excel_field[13]:='Mc_qj';       Field_name[13]:='ú�����';
          Excel_field[14]:='Top_attr';    Field_name[14]:='����״̬';
          Excel_field[15]:='Bottom_attr'; Field_name[15]:='�װ�״̬';
          Excel_field[16]:='Ws_attr';     Field_name[16]:='��˹״̬';
          Excel_field[17]:='Ky_attr';     Field_name[17]:='��ѹ���';
          Excel_field[18]:='Useed_attr';  Field_name[18]:='ʹ�����';
          Excel_field[19]:='chanliang';   Field_name[19]:='����';
          Excel_field[20]:='Memo_bz';     Field_name[20]:='��ע';
          Excel_field[21]:='Zj_D_zhong';  Field_name[21]:='֧���������';
          Excel_field[22]:='Zj_s_zhong';  Field_name[22]:='֧�ܳ���';
          Excel_field[23]:='Zj_p';        Field_name[23]:='֧������';
          Excel_field[24]:='Zj_h_min';    Field_name[24]:='��͸߶�';
          Excel_field[25]:='Zj_h_max';    Field_name[25]:='���߶�';
          Excel_field[26]:='Zj_zxj';      Field_name[26]:='���ľ�';
          Excel_field[27]:='Zj_qlz';      Field_name[27]:='ǰ����';
          Excel_field[28]:='zj_hlz';      Field_name[28]:='������';
          Excel_field[29]:='Zj_kzfs';     Field_name[29]:='���Ʒ�ʽ';
          Excel_field[30]:='Mj_type';     Field_name[30]:='ú���ͺ�';
          Excel_field[31]:='mj_Gt_d';     Field_name[31]:='��Ͳֱ��';
          Excel_field[32]:='mj_js';       Field_name[32]:='����';
          Excel_field[33]:='Front_GB_type';  Field_name[33]:='ǰ���ΰ���ͺ�';
          Excel_field[34]:='Front_lc_w';     Field_name[34]:='ǰ����ۿ���';
          Excel_field[35]:='behind_gb_type'; Field_name[35]:='�󲿹ΰ���ͺ�';
          Excel_field[36]:='behind_lc_w';    Field_name[36]:='����ۿ��';
          Excel_field[37]:='liang_duanju';   Field_name[37]:='���˾�';
          Excel_field[38]:='Tuiyidian_juli';          Field_name[38]:='���Ƶ����ú�ھ���';
          Excel_field[39]:='Front_behind_lc_zxj';     Field_name[39]:='ǰ��������ľ�';
          Excel_field[40]:='pt_guomei_h';             Field_name[40]:='��ú�߶�';
          Excel_field[41]:='zj_js_h';     Field_name[41]:='������';
          Excel_field[42]:='Zj_Dl';       Field_name[42]:='����ǰ���ṹ';
          Excel_field[43]:='Zj_Ql';       Field_name[43]:='ǰ���ṹ';
          Excel_field[44]:='Zj_Dl_Yhl';   Field_name[44]:='�������ڻ�����ϵ';
          Excel_field[45]:='Zj_chb';      Field_name[45]:='�໤��ṹ';
          Excel_field[46]:='Zj_slg';      Field_name[46]:='�����˽ṹ';
          Excel_field[47]:='Zj_ty';       Field_name[47]:='���ƽṹ';
          Excel_field[48]:='Zj_td';       Field_name[48]:='̧�׽ṹ';
          Excel_field[49]:='Zj_ty_d';     Field_name[49]:='���Ƹ׾�';
          Excel_field[50]:='Zj_yl_d';     Field_name[50]:='ǰ���׾�';
          Excel_field[51]:='zj_wl_d';     Field_name[51]:='β���׾�';
          Excel_field[52]:='zj_cb_d';     Field_name[52]:='���׾�';
          Excel_field[53]:='Zj_ct_d';     Field_name[53]:='���Ƹ׾�';
          Excel_field[54]:='Zj_td_d';     Field_name[54]:='̧�׸׾�';
          Excel_field[55]:='Zj_yihg_d';   Field_name[55]:='һ������׾�';
          Excel_field[56]:='Zj_ss_d';     Field_name[56]:='�����׾�';
          Excel_field[57]:='zj_dt_d';     Field_name[57]:='�����׾�';
          Excel_field[58]:='zj_lhl_d';    Field_name[58]:='������׾�';


            //2014�� ����

          Excel_field[59]:='B_SF';       Field_name[59]:='ʡ��';
          Excel_field[60]:='B_DJS';   Field_name[60]:='�ؼ���';
          Excel_field[61]:='B_XJS';      Field_name[61]:='�ؼ���';
          Excel_field[62]:='B_ZHQD';      Field_name[62]:='֧��ǿ��';
          Excel_field[63]:='B_DBBY';       Field_name[63]:='�װ��ѹ';
          Excel_field[64]:='B_H';       Field_name[64]:='����';
          Excel_field[65]:='B_YSL';     Field_name[65]:='ӿˮ��';
          Excel_field[66]:='B_JHDM';     Field_name[66]:='�������';
          Excel_field[67]:='B_FHDM';     Field_name[67]:='�������';
          Excel_field[68]:='B_CMJCJ';     Field_name[68]:='��ú������';
          Excel_field[69]:='B_GBJCJ';     Field_name[69]:='�ΰ������';
          Excel_field[70]:='B_PSJXH';     Field_name[70]:='������ͺ�';
          Excel_field[71]:='B_PSJCJ';   Field_name[71]:='���������';
          Excel_field[72]:='B_RHYB';     Field_name[72]:='�黯Һ��';
          Excel_field[73]:='B_RHYCJ';     Field_name[73]:='�黯Һ����';

          Excel_field[74]:='MapxBz';   Field_name[74]:='�Ƿ��ע';

          Excel_field[75]:='jingdu';      Field_name[75]:='����';
          Excel_field[76]:='weidu';      Field_name[76]:='γ��';


end;
procedure TfrmInfor.FormShow(Sender: TObject);
begin
     Mapx_Out_in:=MainDataModule.ExAdminBool ;
end;

procedure  TfrmInfor.init_SG_Dx();
var
  I,j:integer;
begin
       for I := 1 to SG_DX.RowCount - 1 do
         for j := 0 to SG_DX.ColCount - 1 do
                SG_DX.Cells[j,i]:='';

      SG_DX.ColCount :=4;
      SG_DX.FixedCols:=0;
      SG_DX.FixedRows:=1;
      SG_DX.DefaultRowHeight:=18;
      SG_DX.ColWidths[0]:=30;    SG_DX.Cells[0,0]:='���';
      SG_DX.ColWidths[1]:=30;    SG_DX.Cells[1,0]:='���';
      SG_DX.ColWidths[2]:=80;    SG_DX.Cells[2,0]:='ú������';
      SG_DX.ColWidths[3]:=80;    SG_DX.Cells[3,0]:='֧���ͺ�';



      SG_Field.ColCount :=2;
      SG_Field.FixedCols:=0;
      SG_Field.FixedRows:=1;
      SG_Field.DefaultRowHeight:=18;
      SG_Field.ColWidths[0]:=120;     SG_Field.Cells[0,0]:=' �ֶ���';
      SG_Field.ColWidths[1]:=200;    SG_Field.Cells[1,0]:='ֵ';
      //
       SG_Field.RowCount :=77;
       for I := 1 to 76 do
          SG_Field.Cells[0,i]:= Field_name[i];
end;

procedure TfrmInfor.SG_DXSelectCell(Sender: TObject; ACol, ARow: Integer;
  var CanSelect: Boolean);
var
  Bh :widestring;
  i:integer;
begin
      Bh :=Trim(SG_Dx.Cells[0,ARow]);
       MainDataModule.MyDataSet.Close;
       MainDataModule.MyDataSet.CommandText:='select * from mapbh where bh='''+bh+'''';
       MainDataModule.MyDataSet.Open;
       if MainDataModule.MyDataSet.RecordCount >0 then
       begin
          for I := 1 to MainDataModule.MyDataSet.FieldsCount-1  do
                SG_Field.Cells[1,i+1] :=MainDataModule.MyDataSet.FieldByName(Excel_field[i]).AsString;
          if Mapx_Out_in  then
             self.BitBtn2.Enabled:=true;
       end;
       MainDataModule.MyDataSet.Close ;


end;

end.
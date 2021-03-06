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
                Result:=1;//函数值
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
          Excel_field[1]:='bh';              Field_name[1]:='编号';
          Excel_field[2]:='Tu_bh';        Field_name[2]:='图编号';
          Excel_field[3]:='ZJ_Type';      Field_name[3]:='支架型号';
          Excel_field[4]:='ZJ_name';      Field_name[4]:='支架名称';
          Excel_field[5]:='ZJ_D_name';    Field_name[5]:='支架设计者名称';
          Excel_field[6]:='Mt_address';   Field_name[6]:='煤田区域';
          Excel_field[7]:='Mc_ZJ_name';   Field_name[7]:='煤层编号';
          Excel_field[8]:='Gzm_l';        Field_name[8]:='工作面斜长';
          Excel_field[9]:='Gzm_h';        Field_name[9]:='采高';
          Excel_field[10]:='Mc_name';     Field_name[10]:='煤层名称';
          Excel_field[11]:='Mc_h';        Field_name[11]:='煤层高度';
          Excel_field[12]:='Mc_f';        Field_name[12]:='煤体硬度';
          Excel_field[13]:='Mc_qj';       Field_name[13]:='煤层倾角';
          Excel_field[14]:='Top_attr';    Field_name[14]:='顶板状态';
          Excel_field[15]:='Bottom_attr'; Field_name[15]:='底板状态';
          Excel_field[16]:='Ws_attr';     Field_name[16]:='瓦斯状态';
          Excel_field[17]:='Ky_attr';     Field_name[17]:='来压情况';
          Excel_field[18]:='Useed_attr';  Field_name[18]:='使用情况';
          Excel_field[19]:='chanliang';   Field_name[19]:='产量';
          Excel_field[20]:='Memo_bz';     Field_name[20]:='备注';
          Excel_field[21]:='Zj_D_zhong';  Field_name[21]:='支架设计重量';
          Excel_field[22]:='Zj_s_zhong';  Field_name[22]:='支架称重';
          Excel_field[23]:='Zj_p';        Field_name[23]:='支架阻力';
          Excel_field[24]:='Zj_h_min';    Field_name[24]:='最低高度';
          Excel_field[25]:='Zj_h_max';    Field_name[25]:='最大高度';
          Excel_field[26]:='Zj_zxj';      Field_name[26]:='中心距';
          Excel_field[27]:='Zj_qlz';      Field_name[27]:='前立柱';
          Excel_field[28]:='zj_hlz';      Field_name[28]:='后立柱';
          Excel_field[29]:='Zj_kzfs';     Field_name[29]:='控制方式';
          Excel_field[30]:='Mj_type';     Field_name[30]:='煤机型号';
          Excel_field[31]:='mj_Gt_d';     Field_name[31]:='滚筒直径';
          Excel_field[32]:='mj_js';       Field_name[32]:='截深';
          Excel_field[33]:='Front_GB_type';  Field_name[33]:='前部刮板机型号';
          Excel_field[34]:='Front_lc_w';     Field_name[34]:='前部溜槽宽度';
          Excel_field[35]:='behind_gb_type'; Field_name[35]:='后部刮板机型号';
          Excel_field[36]:='behind_lc_w';    Field_name[36]:='后部溜槽快读';
          Excel_field[37]:='liang_duanju';   Field_name[37]:='梁端距';
          Excel_field[38]:='Tuiyidian_juli';          Field_name[38]:='推移点距离煤壁距离';
          Excel_field[39]:='Front_behind_lc_zxj';     Field_name[39]:='前后溜槽中心距';
          Excel_field[40]:='pt_guomei_h';             Field_name[40]:='过煤高度';
          Excel_field[41]:='zj_js_h';     Field_name[41]:='机身高';
          Excel_field[42]:='Zj_Dl';       Field_name[42]:='顶梁前部结构';
          Excel_field[43]:='Zj_Ql';       Field_name[43]:='前梁结构';
          Excel_field[44]:='Zj_Dl_Yhl';   Field_name[44]:='顶梁与掩护梁关系';
          Excel_field[45]:='Zj_chb';      Field_name[45]:='侧护板结构';
          Excel_field[46]:='Zj_slg';      Field_name[46]:='四连杆结构';
          Excel_field[47]:='Zj_ty';       Field_name[47]:='推移结构';
          Excel_field[48]:='Zj_td';       Field_name[48]:='抬底结构';
          Excel_field[49]:='Zj_ty_d';     Field_name[49]:='推移缸径';
          Excel_field[50]:='Zj_yl_d';     Field_name[50]:='前梁缸径';
          Excel_field[51]:='zj_wl_d';     Field_name[51]:='尾梁缸径';
          Excel_field[52]:='zj_cb_d';     Field_name[52]:='插板缸径';
          Excel_field[53]:='Zj_ct_d';     Field_name[53]:='侧推缸径';
          Excel_field[54]:='Zj_td_d';     Field_name[54]:='抬底缸径';
          Excel_field[55]:='Zj_yihg_d';   Field_name[55]:='一级护帮缸径';
          Excel_field[56]:='Zj_ss_d';     Field_name[56]:='伸缩缸径';
          Excel_field[57]:='zj_dt_d';     Field_name[57]:='底座缸径';
          Excel_field[58]:='zj_lhl_d';    Field_name[58]:='拉后溜缸径';


            //2014年 补充

          Excel_field[59]:='B_SF';       Field_name[59]:='省份';
          Excel_field[60]:='B_DJS';   Field_name[60]:='地级市';
          Excel_field[61]:='B_XJS';      Field_name[61]:='县级市';
          Excel_field[62]:='B_ZHQD';      Field_name[62]:='支护强度';
          Excel_field[63]:='B_DBBY';       Field_name[63]:='底板比压';
          Excel_field[64]:='B_H';       Field_name[64]:='埋深';
          Excel_field[65]:='B_YSL';     Field_name[65]:='涌水量';
          Excel_field[66]:='B_JHDM';     Field_name[66]:='机巷断面';
          Excel_field[67]:='B_FHDM';     Field_name[67]:='风巷断面';
          Excel_field[68]:='B_CMJCJ';     Field_name[68]:='采煤机厂家';
          Excel_field[69]:='B_GBJCJ';     Field_name[69]:='刮板机厂家';
          Excel_field[70]:='B_PSJXH';     Field_name[70]:='破碎机型号';
          Excel_field[71]:='B_PSJCJ';   Field_name[71]:='破碎机厂家';
          Excel_field[72]:='B_RHYB';     Field_name[72]:='乳化液泵';
          Excel_field[73]:='B_RHYCJ';     Field_name[73]:='乳化液厂家';

          Excel_field[74]:='MapxBz';   Field_name[74]:='是否标注';

          Excel_field[75]:='jingdu';      Field_name[75]:='经度';
          Excel_field[76]:='weidu';      Field_name[76]:='纬度';


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
      SG_DX.ColWidths[0]:=30;    SG_DX.Cells[0,0]:='序号';
      SG_DX.ColWidths[1]:=30;    SG_DX.Cells[1,0]:='编号';
      SG_DX.ColWidths[2]:=80;    SG_DX.Cells[2,0]:='煤田区域';
      SG_DX.ColWidths[3]:=80;    SG_DX.Cells[3,0]:='支架型号';



      SG_Field.ColCount :=2;
      SG_Field.FixedCols:=0;
      SG_Field.FixedRows:=1;
      SG_Field.DefaultRowHeight:=18;
      SG_Field.ColWidths[0]:=120;     SG_Field.Cells[0,0]:=' 字段名';
      SG_Field.ColWidths[1]:=200;    SG_Field.Cells[1,0]:='值';
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

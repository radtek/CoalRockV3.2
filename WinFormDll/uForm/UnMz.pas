unit UnMz;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ImgList, StdCtrls, Grids, ExtCtrls, ComCtrls, ToolWin,StrUtils,
  System.ImageList,
  UMainDataModule;

type
  TMz = class(TForm)
    Splitter1: TSplitter;
    CoolBar1: TCoolBar;
    ToolBar1: TToolBar;
    AddButton: TToolButton;
    EditButton: TToolButton;
    SaveButton: TToolButton;
    DeleteButton: TToolButton;
    ExitButton: TToolButton;
    Panel2: TPanel;
    StringGrid1: TStringGrid;
    Panel1: TPanel;
    Label1: TLabel;
    Label3: TLabel;
    Label2: TLabel;
    Label5: TLabel;
    Label11: TLabel;
    Label15: TLabel;
    Label22: TLabel;
    EditMzcd: TEdit;
    EditYjaqjl: TEdit;
    EditMzName: TEdit;
    CboWzfs: TComboBox;
    ImageList1: TImageList;
    EditMzkd: TEdit;
    Label4: TLabel;
    EditMzkcgd: TEdit;
    Label8: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label10: TLabel;
    Label12: TLabel;
    Label9: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    EditDis_left: TEdit;
    EditDis_right: TEdit;
    EditDis_front: TEdit;
    EditDis_behind: TEdit;
    EditDis_top: TEdit;
    EditDis_bottom: TEdit;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label23: TLabel;
    StatusBar1: TStatusBar;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure EditMzkdKeyPress(Sender: TObject; var Key: Char);
    procedure AddButtonClick(Sender: TObject);
    procedure EditButtonClick(Sender: TObject);
    procedure SaveButtonClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ExitButtonClick(Sender: TObject);
    procedure StringGrid1SelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure DeleteButtonClick(Sender: TObject);
    procedure CboWzfsChange(Sender: TObject);
    procedure EditMzNameClick(Sender: TObject);
    procedure EditMzkdClick(Sender: TObject);
    procedure EditMzcdClick(Sender: TObject);
    procedure EditMzkcgdClick(Sender: TObject);
    procedure EditYjaqjlClick(Sender: TObject);
    procedure CboWzfsClick(Sender: TObject);
    procedure EditDis_leftClick(Sender: TObject);
    procedure EditDis_rightClick(Sender: TObject);
    procedure EditDis_frontClick(Sender: TObject);
    procedure EditDis_behindClick(Sender: TObject);
    procedure EditDis_topClick(Sender: TObject);
    procedure EditDis_bottomClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    i_Zid:integer; // ѡ�е�NO
     KARow:integer;
     MySqlDataSet1:TMyDataSet;
     MyCommand1:TMyCommand;

    function checkInputEdit:wordbool; //���¼���ʽ�Ƿ�ϸ�
    procedure ClearEdit;   //��ձ༭��
    procedure FillCell; //������
    procedure SetCellHead; //����Cell��ͷ
    procedure SetEnable(ISCanEnable:bool);
    procedure LeftOrRightEnanle(ISCanEnable:bool);
    procedure OptionTip(Str:String);
  public
    { Public declarations }

  end;

  function CreateUnMz_inn(AHandle:THandle;ACaption:string;Exid:integer):integer;stdcall;

var
  ExUsedMz: TMz;
  Save_Lx:string;
  cqid:integer;

implementation
uses math, uWinFrameClass,  Lu_Public_BasicModual;
{$R *.dfm}
//�ڲ���ʼ�������溯��
function CreateUnMz_inn(AHandle:THandle;ACaption:string;Exid:integer):integer;stdcall;
begin
        Result:=0;//����ֵ
        ExUsedMz:=TMZ.Create(nil);
        try
            ExUsedMz.Caption:=ACaption;
            ExUsedMz.WindowState:= wsNormal;
            ExUsedMz.ParentWindow:=Ahandle;
            ExUsedMz.Top:=60;
            ExUsedMz.Left :=120;
            Cqid:=Exid;
            ExUsedMz.Show;

            Result:=1;//����ֵ
        except
            FreeAndNil(ExUsedMz);
        end;
end;

procedure TMz.AddButtonClick(Sender: TObject);
begin
  i_zid:=0;
  //���ư�ť
  self.SaveButton.Enabled :=true;
  self.EditButton.Enabled :=false;

  i_zid :=0;
  Save_Lx:='add'; //����ʱ���������ͣ��������޸�    ����
  OptionTip('���ڽ��С����ӡ�����!');
  SetEnable(true);
  ClearEdit;


  //2016-6-14
  self.EditMzkd.Text := '0';
  self.EditMzcd.Text := '0';
  self.EditMzkcgd.Text := '0';
  self.EditYjaqjl.Text :='0';
  self.CboWzfs.ItemIndex :=-1;

  self.EditDis_left.Text :='0';
  self.EditDis_right.Text:='0';
  self.EditDis_front.Text:='0';
  self.EditDis_behind.Text:='0';
  self.EditDis_top.Text:='0';
  self.EditDis_bottom.Text:='0';
  
end;

procedure TMz.CboWzfsChange(Sender: TObject);
begin
    LeftOrRightEnanle(false);
    if CboWzfs.ItemIndex =0 then   begin
       EditDis_left.Enabled :=true;
    end else if CboWzfs.ItemIndex =1 then   begin
       EditDis_right.Enabled :=true;
    end else if CboWzfs.ItemIndex =2 then   begin
       EditDis_front.Enabled :=true;
    end else if CboWzfs.ItemIndex =3 then   begin
       EditDis_behind.Enabled :=true;
    end else if CboWzfs.ItemIndex =4 then   begin
       EditDis_top.Enabled :=true;
    end else if CboWzfs.ItemIndex =5 then   begin
       EditDis_bottom.Enabled :=true;
    end;
end;

procedure TMz.CboWzfsClick(Sender: TObject);
begin
    CboWzfs.SetFocus ;
end;

function TMz.checkInputEdit: wordbool;
begin
   result:=false;
    if self.EditMzName.Text = ''  then begin
       messagebox(self.Handle,'����дú�����ƣ�','ϵͳ��ʾ',mb_iconerror+mb_ok);
       exit;
    end;

    if self.EditMzkd.Text = '' then begin
        messagebox(self.Handle,'����дú�����ȣ�','ϵͳ��ʾ',mb_iconerror+mb_ok);
        exit;
    end;

    if self.EditMzcd.Text = '' then begin
        messagebox(self.Handle,'����дú�����ȣ�','ϵͳ��ʾ',mb_iconerror+mb_ok);
        exit;
    end;

    if self.EditMzkcgd.Text = '' then begin
        messagebox(self.Handle,'����дú�����ɸ߶ȣ�','ϵͳ��ʾ',mb_iconerror+mb_ok);
        exit;
    end;

    if self.EditYjaqjl.Text = '' then begin
        messagebox(self.Handle,'����дú��Ԥ����ȫ���룡','ϵͳ��ʾ',mb_iconerror+mb_ok);
        exit;
    end;

    if self.CboWzfs.Text = '' then begin
        messagebox(self.Handle,'��ѡ��ú���뿪���۵�λ�÷�ʽ��','ϵͳ��ʾ',mb_iconerror+mb_ok);
        exit;
    end;

   result:=true;
   
end;

procedure TMz.ClearEdit;
begin
   self.EditMzName.Text := '';
   self.EditMzkd.Text := '';
   self.EditMzcd.Text := '';
   self.EditMzkcgd.Text := '';
   self.EditYjaqjl.Text :='';
   self.CboWzfs.ItemIndex :=-1;

   self.EditDis_left.Text :='';
   self.EditDis_right.Text:='';
   self.EditDis_front.Text:='';
   self.EditDis_behind.Text:='';
   self.EditDis_top.Text:='';
   self.EditDis_bottom.Text:='';
   

end;

procedure TMz.DeleteButtonClick(Sender: TObject);
var
   t_s:String;
   t_sql:String;
begin
   t_s:='��ȷ��Ҫɾ����'+self.EditMzName.Text+'��������ô?';
    if Application.MessageBox(Pwidechar(t_s),'��ʾ',MB_OKCANCEL+MB_ICONQUESTION) =2 then  exit;

      t_sql:='delete from  Mz_CoalPillar  where gzmid = '+inttostr(cqid)+' and id='+self.StringGrid1.Cells [1,i_Zid];

      MyCommand1.CommandText :=t_sql;
      MyCommand1.Execute(MainDataModule.ExUserName)  ;

    //���Cell
    self.FillCell ;

    //���ư�ť
    self.DeleteButton.Enabled :=false;
    self.AddButton.Enabled :=true;
    self.EditButton.Enabled:=false; //2016-6-12

    //��ʾ��Ϣ
     OptionTip('����ɾ���ɹ�!');
  // i_Kid :=0;
   i_zid:=0;
   ClearEdit;

end;

procedure TMz.EditButtonClick(Sender: TObject);
begin
   self.EditButton.Enabled :=false;
   self.SaveButton.Enabled :=true;
   self.DeleteButton.Enabled :=false;//2016-6-12
   Save_Lx:='up';
   OptionTip('���ڽ��С��༭������!');
   SetEnable(true);
end;

procedure TMz.EditDis_behindClick(Sender: TObject);
begin
   EditDis_behind.SetFocus ;
end;

procedure TMz.EditDis_bottomClick(Sender: TObject);
begin
   EditDis_bottom.SetFocus ;
end;

procedure TMz.EditDis_frontClick(Sender: TObject);
begin
   EditDis_front.SetFocus ;
end;

procedure TMz.EditDis_leftClick(Sender: TObject);
begin
    EditDis_left.SetFocus ;
end;

procedure TMz.EditDis_rightClick(Sender: TObject);
begin
   EditDis_right.SetFocus;
end;

procedure TMz.EditDis_topClick(Sender: TObject);
begin
    EditDis_top.SetFocus ;
end;

procedure TMz.EditMzcdClick(Sender: TObject);
begin
   EditMzcd.SetFocus ;
end;

procedure TMz.EditMzkcgdClick(Sender: TObject);
begin
   EditMzkcgd.SetFocus;
end;

procedure TMz.EditMzkdClick(Sender: TObject);
begin
   EditMzkd.SetFocus ;
end;

procedure TMz.EditMzkdKeyPress(Sender: TObject; var Key: Char);
begin
if not (key in ['0'..'9','.',#8]) then key:=#0
end;

procedure TMz.EditMzNameClick(Sender: TObject);
begin
   EditMzName.SetFocus ;
end;

procedure TMz.EditYjaqjlClick(Sender: TObject);
begin
   EditYjaqjl.SetFocus ;
end;

procedure TMz.ExitButtonClick(Sender: TObject);
begin
  self.Close ;
end;

procedure TMz.FillCell;
var
    t_col,t_row:integer;
    kname,jname,cqname:Ansistring;
    i:integer;
    J:integer;
begin
       SetCellHead;
       MySqlDataSet1.Close();
       MySqlDataSet1.CommandText:='select * from Mz_CoalPillar where gzmid = '+inttostr(cqid)+'';
       MySqlDataSet1.Open;
       t_col:=1;t_row:=1;

       J:=1;
       while not  MySqlDataSet1.Eof  do
         begin
               //self.StringGrid1.Cells [0,t_row]:=inttostr(J);
               self.StringGrid1.Cells [1,t_row]:= MySqlDataSet1.FieldByName('id').AsString ;   // 1 id
               self.StringGrid1.Cells [2,t_row]:= MySqlDataSet1.FieldByName('mzName').AsString ;   // 2 ����
               self.StringGrid1.Cells [3,t_row]:= MySqlDataSet1.FieldByName('location').AsString; // 3 ú���뿪���۵�λ�÷�ʽ
               self.StringGrid1.Cells [4,t_row]:=FormatFloat('.##',MySqlDataSet1.FieldByName('width').AsFloat); //4 ú���Ŀ���
               self.StringGrid1.Cells [5,t_row]:=FormatFloat('.##',MySqlDataSet1.FieldByName('length').AsFloat); // 5  ú������
               self.StringGrid1.Cells [6,t_row]:=FormatFloat('.##',MySqlDataSet1.FieldByName('heigth').AsFloat);// 6 ú�����ɸ߶�
               self.StringGrid1.Cells [7,t_row]:=FormatFloat('.##',MySqlDataSet1.FieldByName('safedistance').AsFloat);// 7 Ԥ���İ�ȫ����
               self.StringGrid1.Cells [8,t_row]:=FormatFloat('.##',MySqlDataSet1.FieldByName('dis_left').AsFloat);// 8 ���
               self.StringGrid1.Cells [9,t_row]:=FormatFloat('.##',MySqlDataSet1.FieldByName('dis_right').AsFloat);// 9 �Ҳ�
               self.StringGrid1.Cells [10,t_row]:=FormatFloat('.##',MySqlDataSet1.FieldByName('dis_front').AsFloat);// 10 ǰ��
               self.StringGrid1.Cells [11,t_row]:=FormatFloat('.##',MySqlDataSet1.FieldByName('dis_behind').AsFloat);// 11 ����
               self.StringGrid1.Cells [12,t_row]:=FormatFloat('.##',MySqlDataSet1.FieldByName('dis_top').AsFloat);// 12 ����
               self.StringGrid1.Cells [13,t_row]:=FormatFloat('.##',MySqlDataSet1.FieldByName('dis_bottom').AsFloat);// 13 �ײ�

               t_row:=t_row+1;
              if t_row>self.StringGrid1.RowCount  then
                       self.StringGrid1.RowCount :=t_row;
              MySqlDataSet1.Next ;
             J:=J+1;
         end;
    MySqlDataSet1.Close ;
end;

procedure TMz.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 // Action := caFree;
end;

procedure TMz.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
     if Assigned(ExUsedMz) then  FreeAndNil(ExUsedMz);
end;

procedure TMz.FormCreate(Sender: TObject);
begin
 //
    MySqlDataSet1:=TMyDataSet.Create(nil);
    MySqlDataSet1.MySqlConnection :=MainDataModule.ExConn;

    MyCommand1:=TMyCommand.Create (nil);
    MyCommand1.MySqlConnection :=MainDataModule.ExConn;
   //

 SetEnable(false);

 self.DeleteButton.Enabled :=false;//2016-6-12
 self.EditButton.Enabled :=false;//2016-6-12
 self.SaveButton.Enabled :=false;//2016-6-12

 self.ClearEdit; //2016-6-13
end;

procedure TMz.FormDestroy(Sender: TObject);
begin
    FreeAndNil(MySqlDataSet1);
    FreeAndNil(MyCommand1);
end;

procedure TMz.FormShow(Sender: TObject);
begin
   PubLic_Basic.InitStatusBar(self.StatusBar1);
   self.FillCell ;
end;

procedure TMz.LeftOrRightEnanle(ISCanEnable: bool);
begin
   self.EditDis_left.Enabled :=ISCanEnable;
   self.EditDis_right.Enabled:=ISCanEnable;
   self.EditDis_front.Enabled:=ISCanEnable;
   self.EditDis_behind.Enabled:=ISCanEnable;
   self.EditDis_top.Enabled:=ISCanEnable;
   self.EditDis_bottom.Enabled:=ISCanEnable;
end;

procedure TMz.OptionTip(Str: String);
begin
  StatusBar1.Panels[0].Text :=str;
end;

procedure TMz.SaveButtonClick(Sender: TObject);
var
  t_sql:String;
  C1:integer;
begin
  if self.checkInputEdit =false then exit;
  begin
    if Save_Lx ='add' then   begin   //�����Ӳ���
      t_sql:='insert into Mz_CoalPillar (mzName,location,width,length,heigth,dis_left,dis_right,dis_front,dis_behind,dis_top,dis_bottom,safedistance,gzmid) values('+
              ''''+self.EditMzName.Text+ ''','''+self.CboWzfs.Text+''','+
              self.EditMzkd.Text+','+self.EditMzcd.Text+','+
              self.EditMzkcgd.Text+','+self.EditDis_left.Text+','+
              self.EditDis_right.Text+','+self.EditDis_front.Text+','+
              self.EditDis_behind.Text+','+self.EditDis_top.Text+','+
              self.EditDis_bottom.Text+','+self.EditYjaqjl.Text+','+inttostr(cqid)+')';
    end else if Save_Lx='up' then   //���޸Ĳ���
    begin
      t_sql:='update Mz_CoalPillar set'+
              ' mzName='''+self.EditMzName.Text+''',location='''+self.CboWzfs.Text+''',width='+self.EditMzkd.Text+
              ',length='+self.EditMzcd.Text+
              ',heigth='+self.EditMzkcgd.Text+',dis_left='+self.EditDis_left.Text+
              ',dis_right='+self.EditDis_right.Text+',dis_front='+self.EditDis_front.Text+
              ',dis_behind='+self.EditDis_behind.Text+',dis_top='+self.EditDis_top.Text+',dis_bottom='+self.EditDis_bottom.Text+
              ',safedistance='+self.EditYjaqjl.Text+' where gzmid = '+inttostr(cqid)+' and id='+self.StringGrid1.Cells [1,i_Zid];
    end;
  end;
      MyCommand1.CommandText :=t_sql;
      MyCommand1.Execute(MainDataModule.ExUserName)  ;
     //  memo1.Text :=t_sql;
    //���Cell
    self.FillCell ;

    //���ư�ť
    self.SaveButton.Enabled :=false;
    self.AddButton.Enabled :=true;
    self.DeleteButton.Enabled :=false;//2016-6-12
    self.EditButton.Enabled:=false;//2016-6-13
    //��ʾ��Ϣ
     OptionTip('���ݴ洢�ɹ�!');
     SetEnable(false);

     i_zid :=0;
     Save_Lx:=''; // ����ʱ���������ͣ��������޸� ��λ
     ClearEdit;
end;

procedure TMz.SetCellHead;
var
   i:integer;
begin
      // ��յ�Ԫ��
     for i := 1 to  StringGrid1.RowCount - 1 do
          StringGrid1.Rows[i].Clear ;
     self.StringGrid1.ColCount:=14;
     self.StringGrid1.RowCount :=4;
     self.StringGrid1.Cells [1,0]:='���';
     self.StringGrid1.Cells [2,0]:='ú������';
     self.StringGrid1.Cells [3,0]:='ú���뿪����λ�÷�ʽ';
     self.StringGrid1.Cells [4,0]:='ú������';
     self.StringGrid1.Cells [5,0]:='ú������';
     self.StringGrid1.Cells [6,0]:='ú�����ɸ߶�';
     self.StringGrid1.Cells [7,0]:='Ԥ���İ�ȫ����';
     self.StringGrid1.Cells [8,0]:='���빤�������';
     self.StringGrid1.Cells [9,0]:='���빤�����Ҳ�';
     self.StringGrid1.Cells [10,0]:='���빤����ǰ��';
     self.StringGrid1.Cells [11,0]:='���빤�������';
     self.StringGrid1.Cells [12,0]:='���빤���涥��';
     self.StringGrid1.Cells [13,0]:='���빤����ײ�';

     
     self.StringGrid1.ColWidths[0]:=00;
     self.StringGrid1.ColWidths[1]:=30;
     self.StringGrid1.ColWidths[2]:=80;
     self.StringGrid1.ColWidths[3]:=50;
     self.StringGrid1.ColWidths[4]:=80;
     self.StringGrid1.ColWidths[5]:=80;
     self.StringGrid1.ColWidths[6]:=90;
     self.StringGrid1.ColWidths[7]:=80;
     self.StringGrid1.ColWidths[8]:=80;
     self.StringGrid1.ColWidths[9]:=80;
     self.StringGrid1.ColWidths[10]:=80;
     self.StringGrid1.ColWidths[11]:=80;
     self.StringGrid1.ColWidths[12]:=80;
     self.StringGrid1.ColWidths[13]:=80;
end;

procedure TMz.SetEnable(ISCanEnable: bool);
begin
   self.EditMzName.Enabled:= ISCanEnable;
   self.EditMzcd.Enabled:= ISCanEnable;
   self.EditMzkd.Enabled:= ISCanEnable;
   self.EditMzkcgd.Enabled:= ISCanEnable;
   self.EditYjaqjl.Enabled:= ISCanEnable;
   self.CboWzfs.Enabled:= ISCanEnable;

   self.EditDis_left.Enabled :=ISCanEnable;
   self.EditDis_right.Enabled:=ISCanEnable;
   self.EditDis_front.Enabled:=ISCanEnable;
   self.EditDis_behind.Enabled:=ISCanEnable;
   self.EditDis_top.Enabled:=ISCanEnable;
   self.EditDis_bottom.Enabled:=ISCanEnable;
end;

procedure TMz.StringGrid1SelectCell(Sender: TObject; ACol, ARow: Integer;
  var CanSelect: Boolean);
var
  s_temp:Str_DT_array;
  C1,i:integer;
  lsz:string;
begin
//  if (ARow=0) or (kArow=ARow) then   exit;
//         KARow:=AROW;
  i_Zid:=ARow;
  //self.EditDcName.Text:= StringGrid1.Cells[1,i_Zid];   // 1 id
   //2016-7-1 �ж��Ƿ�Ϊ�գ�float���������Զ��ɿղ���0
  self.EditMzName.Text:= StringGrid1.Cells[2,i_Zid];   // 2 ú������
  if EditMzName.Text = '' then begin
     EditMzName.Text:='0';
  end;

  self.CboWzfs.ItemIndex:=CboWzfs.Items.IndexOf(trim(self.StringGrid1.Cells [3,i_Zid]));  // 3 ú���뿪���۵�λ�÷�ʽ

  self.EditMzkd.Text:=self.StringGrid1.Cells [4,i_Zid]; // 4 ú������
  if EditMzkd.Text = '' then begin
     EditMzkd.Text:='0';
  end;

  self.EditMzcd.Text:=self.StringGrid1.Cells [5,i_Zid]; // 5 ú������
  if EditMzcd.Text = '' then begin
     EditMzcd.Text:='0';
  end;

  self.EditMzkcgd.Text:=self.StringGrid1.Cells [6,i_Zid]; // 6 ú�����ɸ߶�
  if EditMzkcgd.Text = '' then begin
     EditMzkcgd.Text :='0';
  end;

  self.EditYjaqjl.Text:=self.StringGrid1.Cells [7,i_Zid]; // 7 Ԥ���İ�ȫ����
  if EditYjaqjl.Text = '' then begin
     EditYjaqjl.Text:= '0';
  end;

  self.EditDis_left.Text:=self.StringGrid1.Cells [8,i_Zid]; // 8 ���
  if EditDis_left.Text = '' then begin
     EditDis_left.Text :='0';
  end;

  self.EditDis_right.Text:=self.StringGrid1.Cells [9,i_Zid]; // 9 �Ҳ�
  if EditDis_right.Text ='' then begin
     EditDis_right.Text:='0';
  end;

  self.EditDis_front.Text:=self.StringGrid1.Cells [10,i_Zid]; // 10 ǰ��
  if EditDis_front.Text = '' then begin
     EditDis_front.Text:='0';
  end;

  self.EditDis_behind.Text:=self.StringGrid1.Cells [11,i_Zid];  // 11 ����
  if EditDis_behind.Text = '' then begin
     EditDis_behind.Text:='0';
  end;

  self.EditDis_top.Text:=self.StringGrid1.Cells [12,i_Zid];  // 12 ����
  if EditDis_top.Text = '' then begin
     EditDis_top.Text := '0';
  end;

  self.EditDis_bottom.Text:=self.StringGrid1.Cells [13,i_Zid];  // 13 �ײ�
  if EditDis_bottom.Text = '' then begin
     EditDis_bottom.Text:= '0';
  end;


  //���ư�ť
  self.EditButton.Enabled :=true;
  self.DeleteButton.Enabled :=true;
end;

end.
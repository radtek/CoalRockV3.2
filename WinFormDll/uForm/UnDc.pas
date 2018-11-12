unit UnDc;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, DB, ADODB, ExtCtrls,SQLite3,SQLiteTable3, ImgList,
  ComCtrls, ToolWin, Grids,StrUtils, System.ImageList,
  UMainDataModule;

type
  TDc = class(TForm)
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
    Label6: TLabel;
    Label7: TLabel;
    Label5: TLabel;
    Label11: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label16: TLabel;
    Label22: TLabel;
    EditDclc: TEdit;
    EditZjjl: TEdit;
    EditZdjl: TEdit;
    EditYjaqjl: TEdit;
    CboDclx: TComboBox;
    EditDcName: TEdit;
    CboWzfs: TComboBox;
    ImageList1: TImageList;
    StatusBar1: TStatusBar;
    procedure EditDclcKeyPress(Sender: TObject; var Key: Char);
    procedure AddButtonClick(Sender: TObject);
    procedure EditButtonClick(Sender: TObject);
    procedure DeleteButtonClick(Sender: TObject);
    procedure StringGrid1SelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure SaveButtonClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ExitButtonClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure StringGrid1DrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure EditDcNameClick(Sender: TObject);
    procedure CboDclxClick(Sender: TObject);
    procedure EditDclcClick(Sender: TObject);
    procedure EditYjaqjlClick(Sender: TObject);
    procedure EditZjjlClick(Sender: TObject);
    procedure EditZdjlClick(Sender: TObject);
    procedure CboWzfsClick(Sender: TObject);
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
    procedure OptionTip(Str:String);
  public
    { Public declarations }


  end;

  function CreateUnDc_inn(AHandle:THandle;ACaption:string;Exid:integer):integer;stdcall;

var
  ExUsedDc: TDc;
  Save_Lx:string;
  cqid:integer;

implementation
uses math, uWinFrameClass,  Lu_Public_BasicModual;
{$R *.dfm}
//�ڲ���ʼ�������溯��
function CreateUnDc_inn(AHandle:THandle;ACaption:string;Exid:integer):integer;stdcall;
begin
        Result:=0;//����ֵ
    
        ExUsedDc:=TDc.Create(nil);
        try
            ExUsedDc.Caption:=ACaption;
            ExUsedDc.WindowState:= wsNormal;
            ExUsedDc.ParentWindow:=Ahandle;
            ExUsedDc.Top:=70;
            ExUsedDc.Left :=120;
            Cqid:=Exid;
            ExUsedDc.Show;

            Result:=1;//����ֵ
        except
            FreeAndNil(ExUsedDc);
        end;
end;


procedure TDc.AddButtonClick(Sender: TObject);
begin
  i_zid:=0;
  //���ư�ť
  self.SaveButton.Enabled :=true;
  self.EditButton.Enabled :=false;
  self.DeleteButton.Enabled :=false;//2016-6-12

  i_zid :=0;
  Save_Lx:='add'; //����ʱ���������ͣ��������޸�    ����
  OptionTip('���ڽ��С����ӡ�����!');
  SetEnable(true);

  ClearEdit;
  //2016-6-14

  self.CboDclx.ItemIndex:=-1;
  self.EditDclc.Text := '0';
  self.EditZjjl.Text := '0';
  self.EditZdjl.Text := '0';
  self.CboWzfs.ItemIndex:=-1;
  self.EditYjaqjl.Text := '0';
end;

procedure TDc.CboDclxClick(Sender: TObject);
begin
   CboDclx.SetFocus;
end;

procedure TDc.CboWzfsClick(Sender: TObject);
begin
     CboWzfs.SetFocus;
end;

function TDc.checkInputEdit: wordbool;
begin
    result:=false;
    if self.EditDcName.Text = ''  then begin
       messagebox(self.Handle,'����д�ϲ����ƣ�','ϵͳ��ʾ',mb_iconerror+mb_ok);
       exit;
    end;

    if self.CboDclx.Text = '' then begin
        messagebox(self.Handle,'��ѡ��ϲ����ͣ�','ϵͳ��ʾ',mb_iconerror+mb_ok);
        exit;
    end;

    if self.EditDclc.Text = '' then begin
        messagebox(self.Handle,'����д�ϲ���','ϵͳ��ʾ',mb_iconerror+mb_ok);
        exit;
    end;

    if self.EditZjjl.Text = '' then begin
        messagebox(self.Handle,'����д�ϲ���뿪����������룡','ϵͳ��ʾ',mb_iconerror+mb_ok);
        exit;
    end;

    if self.EditZdjl.Text = '' then begin
        messagebox(self.Handle,'����д�ϲ���뿪���������룡','ϵͳ��ʾ',mb_iconerror+mb_ok);
        exit;
    end;

    if self.CboWzfs.Text = '' then begin
        messagebox(self.Handle,'��ѡ��ϲ��뿪���۵�λ�÷�ʽ��','ϵͳ��ʾ',mb_iconerror+mb_ok);
        exit;
    end;

    if self.EditYjaqjl.Text = '' then begin
        messagebox(self.Handle,'����дԤ���İ�ȫ���룡','ϵͳ��ʾ',mb_iconerror+mb_ok);
        exit;
    end;

   result:=true;
end;

procedure TDc.ClearEdit;
begin
    self.EditDcName.Text := '';
    self.CboDclx.ItemIndex:=-1;
    self.EditDclc.Text := '';
    self.EditZjjl.Text := '';
    self.EditZdjl.Text := '';
    self.CboWzfs.ItemIndex:=-1;
    self.EditYjaqjl.Text := '';

end;

procedure TDc.DeleteButtonClick(Sender: TObject);
var
   t_s:String;
   t_sql:String;
begin
   t_s:='��ȷ��Ҫɾ����'+self.EditDcName.Text+'��������ô?';
    if Application.MessageBox(Pwidechar(t_s),'��ʾ',MB_OKCANCEL+MB_ICONQUESTION) =2 then  exit;

      t_sql:='delete from  Dc_Fault  where gzmid = '+inttostr(cqid)+' and  id='+self.StringGrid1.Cells [1,i_Zid];

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

procedure TDc.EditButtonClick(Sender: TObject);
begin
   self.EditButton.Enabled :=false;
   self.SaveButton.Enabled :=true;
   self.DeleteButton.Enabled :=false;//2016-6-12
   
   Save_Lx:='up';
   OptionTip('���ڽ��С��༭������!');
   SetEnable(true);
end;

procedure TDc.EditDclcClick(Sender: TObject);
begin
   EditDclc.SetFocus;
end;

procedure TDc.EditDclcKeyPress(Sender: TObject; var Key: Char);
begin
if not (key in ['0'..'9','.',#8]) then key:=#0
end;

procedure TDc.EditDcNameClick(Sender: TObject);
begin
    EditDcName.SetFocus ;
end;

procedure TDc.EditYjaqjlClick(Sender: TObject);
begin
   EditYjaqjl.SetFocus;
end;

procedure TDc.EditZdjlClick(Sender: TObject);
begin
   EditZdjl.SetFocus;
end;

procedure TDc.EditZjjlClick(Sender: TObject);
begin
   EditZjjl.SetFocus ;
end;

procedure TDc.ExitButtonClick(Sender: TObject);
begin
  self.Close ;
end;

procedure TDc.FillCell;
var
    t_col,t_row:integer;
    kname,jname,cqname:Ansistring;
    i:integer;
    J:integer;
begin
       SetCellHead;
       MySqlDataSet1.Close();
       MySqlDataSet1.CommandText:='select * from Dc_Fault where  gzmid = '+inttostr(cqid)+'';
       MySqlDataSet1.Open;
       t_col:=1;t_row:=1;

       J:=1;
       while not  MySqlDataSet1.Eof  do
         begin
               //self.StringGrid1.Cells [0,t_row]:=inttostr(J);
               self.StringGrid1.Cells [1,t_row]:= MySqlDataSet1.FieldByName('id').AsString ;   // 1 id
               self.StringGrid1.Cells [2,t_row]:= MySqlDataSet1.FieldByName('dcname').AsString ;   // 2 ����
               self.StringGrid1.Cells [3,t_row]:= MySqlDataSet1.FieldByName('faulttype').AsString; // 3 ֧�ϲ������  1 ���ϲ� 2 ��ϲ�
               self.StringGrid1.Cells [4,t_row]:=FormatFloat('.##',MySqlDataSet1.FieldByName('divide').AsFloat); //4 �ϲ�����
               self.StringGrid1.Cells [5,t_row]:=FormatFloat('.##',MySqlDataSet1.FieldByName('MinToOffCut').AsFloat); // 5  �ϲ���뿪�����������
               self.StringGrid1.Cells [6,t_row]:=FormatFloat('.##',MySqlDataSet1.FieldByName('MaxToOffCut').AsFloat);// 6 �ϲ���뿪����������
               self.StringGrid1.Cells [7,t_row]:=MySqlDataSet1.FieldByName('location').AsString;// 7 �ϲ��뿪���۵�λ�÷�ʽ
               self.StringGrid1.Cells [8,t_row]:=MySqlDataSet1.FieldByName('safedistance').AsString;// 7 Ԥ���İ�ȫ����
               t_row:=t_row+1;
              if t_row>self.StringGrid1.RowCount  then
                       self.StringGrid1.RowCount :=t_row;
              MySqlDataSet1.Next ;
             J:=J+1;
         end;
     MySqlDataSet1.Close ;
end;

procedure TDc.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  // Action := caFree;
end;

procedure TDc.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
   
   if Assigned(ExUsedDc) then  FreeAndNil(ExUsedDc);
end;

procedure TDc.FormCreate(Sender: TObject);
var c_count:integer;
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



procedure TDc.FormDestroy(Sender: TObject);
begin
    FreeAndNil(MySqlDataSet1);
    FreeAndNil(MyCommand1);
end;

procedure TDc.FormShow(Sender: TObject);
begin
    PubLic_Basic.InitStatusBar(self.StatusBar1);
    self.FillCell ;
end;

procedure TDc.OptionTip(Str: String);
begin
   StatusBar1.Panels[0].Text :=str;
end;

Procedure TDc.SaveButtonClick(Sender: TObject);
 var
  t_sql:String;
  C1:integer;
begin
   if self.checkInputEdit =false then exit;
  begin
    if Save_Lx ='add' then   begin   //�����Ӳ���
      t_sql:='insert into Dc_Fault (dcName,faulttype,divide,MinToOffCut,MaxToOffCut,location,safedistance,gzmid) values('+
              ''''+self.EditDcName.Text+ ''','+LeftStr(Trim(self.CboDclx.text),1)+','+
              self.EditDclc.Text+','+self.EditZjjl.Text+','+
              self.EditZdjl.Text+','''+self.CboWzfs.Text+''','+
              self.EditYjaqjl.Text+','+inttostr(cqid)+')';
    end else if Save_Lx='up' then   //���޸Ĳ���
    begin
      t_sql:='update Dc_Fault set'+
              ' dcName='''+self.EditDcName.Text+''',faulttype='+LeftStr(Trim(self.CboDclx.Text),1)+
              ',divide='+self.EditDclc.Text+',MinToOffCut='+self.EditZjjl.Text+
              ',MaxToOffCut='+self.EditZdjl.Text+',location='''+self.CboWzfs.Text+''''+
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

procedure TDc.SetCellHead;
var
   i:integer;
begin
      // ��յ�Ԫ��
      for i := 1 to  StringGrid1.RowCount - 1 do
          StringGrid1.Rows[i].Clear ;

     self.StringGrid1.ColCount:=9;
     self.StringGrid1.RowCount :=4;
     self.StringGrid1.Cells [1,0]:='���';
     self.StringGrid1.Cells [2,0]:='�ϲ�����';
     self.StringGrid1.Cells [3,0]:='�ϲ�����';
     self.StringGrid1.Cells [4,0]:='�ϲ����';
     self.StringGrid1.Cells [5,0]:='�ϲ���뿪������С����';
     self.StringGrid1.Cells [6,0]:='�ϲ���뿪����������';
     self.StringGrid1.Cells [7,0]:='�ϲ��뿪���۵�λ�÷�ʽ';
     self.StringGrid1.Cells [8,0]:='Ԥ����ȫ����';

     self.StringGrid1.ColWidths[0]:=10;
     self.StringGrid1.ColWidths[1]:=50;
     self.StringGrid1.ColWidths[2]:=50;
     self.StringGrid1.ColWidths[3]:=50;
     self.StringGrid1.ColWidths[4]:=50;
     self.StringGrid1.ColWidths[5]:=105;
     self.StringGrid1.ColWidths[6]:=105;
     self.StringGrid1.ColWidths[7]:=105;
     self.StringGrid1.ColWidths[8]:=50;

end;

procedure TDc.SetEnable(ISCanEnable: bool);
begin
 self.EditDcName.Enabled:= ISCanEnable;
      self.CboDclx.Enabled:= ISCanEnable;
       self.EditDclc.Enabled:= ISCanEnable;
        self.EditZjjl.Enabled:= ISCanEnable;
         self.EditZdjl.Enabled:= ISCanEnable;
          self.CboWzfs.Enabled:= ISCanEnable;
           self.EditYjaqjl.Enabled:= ISCanEnable;
end;

procedure TDc.StringGrid1DrawCell(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
begin
 //�ı����
  
end;

procedure TDc.StringGrid1SelectCell(Sender: TObject; ACol, ARow: Integer; var CanSelect: Boolean);
var
  s_temp:Str_DT_array;
  C1,i:integer;
  lsz:string;
begin
//  if (ARow=0) or (kArow=ARow) then   exit;
//         KARow:=AROW;

  i_Zid:=ARow;
  //self.EditDcName.Text:= StringGrid1.Cells[1,i_Zid];   // 1 id
  self.EditDcName.Text:= StringGrid1.Cells[2,i_Zid];   // 2 �ϲ�����
  if EditDcName.Text ='' then begin
     EditDcName.Text:='0';
  end;

  lsz:=StringGrid1.Cells[3,ARow];  //3 �ϲ�����
  if lsz  <> '' then begin

       self.CboDclx.ItemIndex:=strtoint(lsz) - 1;
  end;

  //memo1.Text :=lsz;
  //2016-7-1 �޸�0��ɿ�''������
  self.EditDclc.Text:=self.StringGrid1.Cells [4,i_Zid]; // 4 �ϲ����
  if EditDclc.Text = '' then begin
     EditDclc.Text:='0';
  end;

  self.EditZjjl.Text:=self.StringGrid1.Cells [5,i_Zid]; // 5 �ϲ���뿪�����������
  if EditZjjl.Text= '' then begin
     EditZjjl.Text:='0';
  end;

  self.EditZdjl.Text:=self.StringGrid1.Cells [6,i_Zid]; // 6 �ϲ���뿪����������
  if EditZdjl.Text = '' then begin
     EditZdjl.Text:='0';
  end;

  self.CboWzfs.ItemIndex:=CboWzfs.Items.IndexOf(trim(self.StringGrid1.Cells [7,i_Zid]));  // 7 �ϲ��뿪���۵�λ�÷�ʽ

  self.EditYjaqjl.Text:=self.StringGrid1.Cells [8,i_Zid];  // 8 Ԥ���İ�ȫ����
  if EditYjaqjl.Text='' then begin
     EditYjaqjl.Text:='0';
  end;



  //���ư�ť
  self.EditButton.Enabled :=true;
  self.DeleteButton.Enabled :=true;



end;

end.
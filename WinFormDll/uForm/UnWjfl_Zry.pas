unit UnWjfl_Zry;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, DB, ADODB;

type
  TWjfl = class(TForm)
    Kwcf: TGroupBox;
    Kwcf1: TRadioButton;
    Kwcf2: TRadioButton;
    Kwcf3: TRadioButton;
    Kwcf4: TRadioButton;
    Kwcf5: TRadioButton;
    Jhwhl: TGroupBox;
    Jhwhl_1: TRadioButton;
    Jhwhl_2: TRadioButton;
    Jhwhl_3: TRadioButton;
    Jhwhl_4: TRadioButton;
    Jhwhl_5: TRadioButton;
    Lxfycd: TGroupBox;
    Lxfycd_1: TRadioButton;
    Lxfycd_2: TRadioButton;
    Lxfycd_3: TRadioButton;
    Lxfycd_4: TRadioButton;
    Lxfycd_5: TRadioButton;
    Swfycd: TGroupBox;
    S1wfycd_1: TRadioButton;
    S1wfycd_2: TRadioButton;
    S1wfycd_3: TRadioButton;
    S1wfycd_4: TRadioButton;
    S1wfycd_5: TRadioButton;
    OK: TButton;
    Button1: TButton;
    Memo1: TMemo;
    Memo2: TMemo;
    Memo3: TMemo;
    Memo4: TMemo;
    procedure Kwcf1Click(Sender: TObject);
    procedure OKClick(Sender: TObject);
    procedure Kwcf2Click(Sender: TObject);
    procedure Kwcf3Click(Sender: TObject);
    procedure Kwcf4Click(Sender: TObject);
    procedure Kwcf5Click(Sender: TObject);
    procedure Jhwhl_1Click(Sender: TObject);
    procedure Jhwhl_2Click(Sender: TObject);
    procedure Jhwhl_3Click(Sender: TObject);
    procedure Jhwhl_4Click(Sender: TObject);
    procedure Jhwhl_5Click(Sender: TObject);
    procedure Lxfycd_1Click(Sender: TObject);
    procedure Lxfycd_2Click(Sender: TObject);
    procedure Lxfycd_3Click(Sender: TObject);
    procedure Lxfycd_4Click(Sender: TObject);
    procedure Lxfycd_5Click(Sender: TObject);
    procedure S1wfycd_1Click(Sender: TObject);
    procedure S1wfycd_2Click(Sender: TObject);
    procedure S1wfycd_3Click(Sender: TObject);
    procedure S1wfycd_4Click(Sender: TObject);
    procedure S1wfycd_5Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

function CreateRock_WjFL(AHandle:THandle;ACaption:string):integer;stdcall;

var
  UWjFL: TWjfl;
  Kwcf_No,Jjwhl_No,Lxfycd_No,Swfycd_No:integer;

implementation

uses UnDetail,UnEditGzk;

{$R *.dfm}
function CreateRock_WjFL(AHandle:THandle;ACaption:string):integer;stdcall;
begin
        UWjFL:=TWjfl.Create(nil);
        try
            UWjFL.Caption:=ACaption;
            UWjFL.WindowState:= wsNormal;
            UWjFL.ParentWindow:=Ahandle;

            UWjFL.Top:=70;
            UWjFL.Left:=120;
            UWjFL.Show;
            Result:=1;//函数值
        except
           FreeAndNil(UWjFL);
        end;
end;


//确定按钮
procedure TWjfl.OKClick(Sender: TObject);
begin
  ZkDetail_inn.Edit_Kyjs(ZkDetail_inn.EditYockKy,ZkDetail_inn.EditYockKL,ZkDetail_inn.EditYockKJ,'sql','value',
               Kwcf_No,Jjwhl_No,Lxfycd_No,Swfycd_No);    //传递计算参数，进行抗拉、抗压、抗剪计算
  self.Close;

end;

procedure TWjfl.Button1Click(Sender: TObject);
begin
  self.Close;
end;

procedure TWjfl.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
    if Assigned(UWjFL)  then  FreeAndNil(UWjFL);

end;

procedure TWjfl.FormCreate(Sender: TObject);
begin

  Kwcf3.Checked:=true;
  Jhwhl_3.Checked:=true;
  Lxfycd_3.Checked:=true;
  S1wfycd_3.Checked:=true;

  ZkDetail_inn.Edit_Text(Memo1,'select * from sedqenename where grad=''3'' and name=''11''','describe','','');
  Kwcf_No:=3;
  ZkDetail_inn.Edit_Text(Memo2,'select * from sedqenename where grad=''3''  and name=''12''','describe','','');
  Jjwhl_No:=3;
  ZkDetail_inn.Edit_Text(Memo3,'select * from sedqenename where grad=''3''  and name=''13''','describe','','');
  Lxfycd_No:=3;
  ZkDetail_inn.Edit_Text(Memo4,'select * from sedqenename where grad=''3''  and name=''14''','describe','','');
  Swfycd_No:=3;
end;

procedure TWjfl.Jhwhl_1Click(Sender: TObject);
begin
  ZkDetail_inn.Edit_Text(Memo2,'select * from sedqenename where grad=''1''  and name=''12''','describe','','');
  Jjwhl_No:=1;
end;

procedure TWjfl.Jhwhl_2Click(Sender: TObject);
begin
  ZkDetail_inn.Edit_Text(Memo2,'select * from sedqenename where grad=''2''  and name=''12''','describe','','');
  Jjwhl_No:=2;
end;

procedure TWjfl.Jhwhl_3Click(Sender: TObject);
begin
  ZkDetail_inn.Edit_Text(Memo2,'select * from sedqenename where grad=''3''  and name=''12''','describe','','');
  Jjwhl_No:=3;
end;

procedure TWjfl.Jhwhl_4Click(Sender: TObject);
begin
  ZkDetail_inn.Edit_Text(Memo2,'select * from sedqenename where grad=''4''  and name=''12''','describe','','');
  Jjwhl_No:=4;
end;

procedure TWjfl.Jhwhl_5Click(Sender: TObject);
begin
  ZkDetail_inn.Edit_Text(Memo2,'select * from sedqenename where grad=''5''  and name=''12''','describe','','');
  Jjwhl_No:=5;
end;

procedure TWjfl.Kwcf1Click(Sender: TObject);
begin
  ZkDetail_inn.Edit_Text(Memo1,'select * from sedqenename where grad=''1''  and name=''11''','describe','','');
  Kwcf_No:=1;
end;

procedure TWjfl.Kwcf2Click(Sender: TObject);
begin
  ZkDetail_inn.Edit_Text(Memo1,'select * from sedqenename where grad=''2''  and name=''11''','describe','','');
  Kwcf_No:=2;
end;

procedure TWjfl.Kwcf3Click(Sender: TObject);
begin
  ZkDetail_inn.Edit_Text(Memo1,' select * from sedqenename where grad=''3''  and name=''11''','describe','','');
   Kwcf_No:=3;
end;

procedure TWjfl.Kwcf4Click(Sender: TObject);
begin
  ZkDetail_inn.Edit_Text(Memo1,'select * from sedqenename where grad=''4''  and name=''11''','describe','','');
  Kwcf_No:=4;
end;

procedure TWjfl.Kwcf5Click(Sender: TObject);
begin
  ZkDetail_inn.Edit_Text(Memo1,'select * from sedqenename where grad=''5''  and name=''11''','describe','','');
  Kwcf_No:=5;
end;

procedure TWjfl.Lxfycd_1Click(Sender: TObject);
begin
  ZkDetail_inn.Edit_Text(Memo3,'select * from sedqenename where grad=''1''  and name=''13''','describe','','');
  Lxfycd_No:=1;
end;

procedure TWjfl.Lxfycd_2Click(Sender: TObject);
begin
  ZkDetail_inn.Edit_Text(Memo3,'select * from sedqenename where grad=''2''  and name=''13''','describe','','');
  Lxfycd_No:=2;
end;

procedure TWjfl.Lxfycd_3Click(Sender: TObject);
begin
  ZkDetail_inn.Edit_Text(Memo3,'select * from sedqenename where grad=''3''  and name=''13''','describe','','');
  Lxfycd_No:=3;
end;

procedure TWjfl.Lxfycd_4Click(Sender: TObject);
begin
  ZkDetail_inn.Edit_Text(Memo3,'select * from sedqenename where grad=''4''  and name=''13''','describe','','');
  Lxfycd_No:=4;
end;

procedure TWjfl.Lxfycd_5Click(Sender: TObject);
begin
  ZkDetail_inn.Edit_Text(Memo3,'select * from sedqenename where grad=''5''  and name=''13''','describe','','');
  Lxfycd_No:=5;
end;

procedure TWjfl.S1wfycd_1Click(Sender: TObject);
begin
  ZkDetail_inn.Edit_Text(Memo4,'select * from sedqenename where grad=''1''  and name=''14''','describe','','');
  Swfycd_No:=1;
end;

procedure TWjfl.S1wfycd_2Click(Sender: TObject);
begin
  ZkDetail_inn.Edit_Text(Memo4,'select * from sedqenename where grad=''2''  and name=''14''','describe','','');
  Swfycd_No:=2;
end;

procedure TWjfl.S1wfycd_3Click(Sender: TObject);
begin
  ZkDetail_inn.Edit_Text(Memo4,'select * from sedqenename where grad=''3''  and name=''14''','describe','','');
  Swfycd_No:=3;
end;

procedure TWjfl.S1wfycd_4Click(Sender: TObject);
begin
  ZkDetail_inn.Edit_Text(Memo4,'select * from sedqenename where grad=''4''  and name=''14''','describe','','');
  Swfycd_No:=4;
end;

procedure TWjfl.S1wfycd_5Click(Sender: TObject);
begin
  ZkDetail_inn.Edit_Text(Memo4,'select * from sedqenename where grad=''5''  and name=''14''','describe','','');
  Swfycd_No:=5;
end;

end.

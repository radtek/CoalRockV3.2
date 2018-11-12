unit UnselectGZM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls,DBCtrls, OleServer,adodb, ComCtrls, ImgList,Menus,
  ExtCtrls, System.ImageList, UMainDataModule;

type
  TselectGZM = class(TForm)
    But_OK: TButton;
    But_Close: TButton;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    GroupBox3: TGroupBox;
    TVMk: TTreeView;
    TVGzm: TTreeView;
    TVZk: TTreeView;
    PanelMk: TPanel;
    PanelGzM: TPanel;
    PanelZK: TPanel;
    Panel1: TPanel;
    Label1: TLabel;
    ImageList1: TImageList;
    Button1: TButton;
    procedure FormCreate(Sender: TObject);
    procedure But_OKClick(Sender: TObject);
    procedure But_CloseClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure TVMkClick(Sender: TObject);
    procedure TVGzmClick(Sender: TObject);
    procedure TVZkClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormDestroy(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
     MySqlDataSet1:TMyDataSet;
     MySqlDataSet2:TMyDataSet;
     MYSQLCommand:TMyCommand;
     Captionid:integer;// 找到系统设置的 打开方式
     ShowScreen:integer;
    procedure MainTreeView(TreeView: TTreeView);
    procedure ChildTreeView(TreeView: TTreeView;XNode: TTreeNode;sId:String);
    procedure FillWorkFaceTreeView(TV: TTreeView;mkid:string);
    procedure FillDrillTreeView(TV: TTreeView;mkid,GZmid:string);
    procedure  SelectedTreeNode(TreeView: TTreeView;sid:string);
    procedure SetFromWidthAndHeigth(flag:integer;iWidth,iHeigth:integer);

  public
    { Public declarations }

     procedure SelectLine(Memo1: TMemo; ln: Integer);
     procedure ScrollToLine(Memo1: TMemo; ln: Integer);
     procedure fillGzmZk(mkid:string);
     procedure DisPlayLabel;

  end;

var
  selectGZM: TselectGZM;
  function CreateSelectGzmZkzinfo(AHandle:THandle;ACaption:string;Wid,Hi,Flag:integer):integer;stdcall;

implementation

uses uWinFrameClass, Lu_Public_BasicModual, UnZkGzmLink;
{$R *.dfm}

//内部初始化工作面函数
function CreateSelectGzmZkzinfo(AHandle:THandle;ACaption:string;Wid,Hi,Flag:integer):integer;stdcall;

begin
       if Assigned(selectGZM) then  FreeAndNil(selectGZM);

       selectGZM:=TselectGZM.Create(nil);
        try
          with selectGZM do begin
               Caption:=ACaption;
               WindowState:= wsNormal;
               ParentWindow:=Ahandle;

               if Hi >Height then
                   Top :=Round((Hi-Height)/3)  else   Top :=0;
               if Wid> Width then
                   Left:=Round((Wid-Width)/2)  else   Left:=0;

                Show;
                SetFromWidthAndHeigth(Flag,Wid,Hi);
                SetFocus;
                Result:=1;//函数值
          end ;
        except
           FreeAndNil(selectGZM);
        end;
end;

procedure TselectGZM.But_OKClick(Sender: TObject);
begin
    MainDataModule.SavePublicUsedMkInfoIntoFile;
    Close;
end;

procedure TselectGZM.Button1Click(Sender: TObject);
begin
    CreateBgz_inn(selectGZM.ParentWindow,
                  '工作面与钻孔绑定补录界面',selectGZM.Width,selectGZM.Height);
end;

procedure TselectGZM.But_CloseClick(Sender: TObject);
begin
     self.Close;

end;

procedure TselectGZM.ChildTreeView(TreeView: TTreeView; XNode: TTreeNode;
  sId: String);
var
    RecData: PMyRec;
    MyNode: TTreeNode;
begin
      MySqlDataSet2.Close;
      MySqlDataSet2.CommandText:= 'SELECT id,MeiKuangMing from KuangJingXinXiBiao' +
                ' where Jituanid='+sId +' order by id';
      MySqlDataSet2.Open;
      while not MySqlDataSet2.Eof do begin

           New(RecData);
           RecData^.BName:=Trim(MySqlDataSet2.FieldByName('MeiKuangMing').AsString);
           RecData^.DName:='R';
           RecData^.XHeight:= Trim(MySqlDataSet2.FieldByName('id').AsString);
           MyNode:=TreeView.Items.AddChildObject(XNode,Trim(MySqlDataSet2.FieldByName('MeiKuangMing').AsString),RecData);
           MyNode.ImageIndex:=1;
           MySqlDataSet2.Next;
      end;
      MySqlDataSet2.Close;
end;

procedure TselectGZM.DisPlayLabel;
var
  mkid,gzmid,zkid:integer;
  DisPlay:String;
begin
    mkid:=Public_Basic.StrToInt_Lu(MainDataModule.Coal_id);
    gzmid:=Public_Basic.StrToInt_Lu(MainDataModule.WorkFace_id);
    zkid:=Public_Basic.StrToInt_Lu(MainDataModule.Drill_id);

    if (mkid>0) and (gzmid>0) and (zkid>0) then  begin
        PanelMk.Caption := MainDataModule.Coal_Name;
        Panelgzm.Caption := MainDataModule.WorkFace_Name;
        Panelzk.Caption := MainDataModule.Drill_Name;

        DisPlay :='    现在是对【'+PanelMk.Caption+'】矿【'+ Panelgzm.Caption+'】工作面【 '+
                      Panelzk.Caption+'】钻孔数据进行组合计算，请验证数据的一致性！';
        But_Ok.Enabled:=true;
    end else begin
        if mkid >0 then    PanelMk.Caption := MainDataModule.Coal_Name
           else  PanelMk.Caption :='';
        if gzmid>0 then   Panelgzm.Caption := MainDataModule.WorkFace_Name
           else     Panelgzm.Caption := '';

        if (gzmid>0) and (zkid>0) then   Panelzk.Caption := MainDataModule.Drill_Name
           else  Panelzk.Caption := '';

        if (Captionid=5) and (gzmid>0) and (Mkid>0) then begin
           But_Ok.Enabled:=true;
        end else begin
            DisPlay :='    数据不完整，无法进行数据验证，请另选工作面或者补录完整数据再来！';
            But_Ok.Enabled:=False;
        end;


       
    end;

     Label1.Caption :=DisPlay;

end;

procedure TselectGZM.FillDrillTreeView(TV: TTreeView; mkid,Gzmid: string);
var
    RecData: PMyRec;
    i:integer;
    MYNode: TTreeNode;
    sql:string;
begin
//     查找绑定钻孔
     TV.Items.Clear ;
     if gzmid='' then exit;

     MySqlDataSet2.close;
//     Sql:='select W.zkid,Z.zkname from WorkFaceBuillDrill as W,zkb  as Z ' +
//            ' where W.gzmid='+gzmid+' and W.zkid=Z.zkid  Group by W.zkid order by W.id';
     sql:= ' select zkid,zkname from zkb where zkid in( select zkid from WorkFaceBuillDrill where gzmid='+gzmid +')'  ;
     MySqlDataSet2.CommandText:=sql;

    IF  (MySqlDataSet2.Open) and(MySqlDataSet2.RecordCount>0 ) then  begin
        MySqlDataSet2.First ;
        MainDataModule.Drill_id:= MySqlDataSet2.FieldByName('zkid').AsString;
        MainDataModule.Drill_Name:= MySqlDataSet2.FieldByName('ZkName').AsString;
        while not MySqlDataSet2.eof do      begin
           New(RecData);
           RecData^.BName:=MySqlDataSet2.FieldByName('zkid').AsString;
           RecData^.DName:=MySqlDataSet2.FieldByName('ZkName').AsString;
           RecData^.XHeight:='';
           MYNode:=TV.Items.AddObject(nil,Trim(MySqlDataSet2.FieldByName('zkname').AsString),RecData);
           MYNode.ImageIndex :=3;
           MySqlDataSet2.Next ;
        end;
        MySqlDataSet2.Close ;
    end;


    if TV.Items.Count=0 then  exit;

    if MainDataModule.Drill_id <>'' then  begin
       for I := 0 to TV.Items.Count  - 1 do
          if PMyRec(TV.Items[i].Data)^.BName =MainDataModule.Drill_id   then  begin
               TV.Items[i].Selected :=true; break;
          end;
    end else begin
          TV.Items[0].Selected :=true;
          MainDataModule.Drill_id:= PMyRec(TV.Items[0].Data)^.BName;
          MainDataModule.Drill_Name:= PMyRec(TV.Items[0].Data)^.dName;
    end;

end;

procedure TselectGZM.fillGzmZk(Mkid: string);
begin

      self.FillWorkFaceTreeView(TVGzm,Mkid);
      self.FillDrillTreeView(TVZK,mkid,MainDataModule.WorkFace_id);
      DisPlayLabel;

end;

procedure TselectGZM.FillWorkFaceTreeView(TV: TTreeView; mkid: string);
var
    RecData: PMyRec;
    i,j:integer;
    MyNode: TTreeNode;
begin
     //     查找绑定工作面
     TV.Items.Clear ;
     MySqlDataSet2.close;
     MySqlDataSet2.CommandText:='select* from cqcsb  where kid='+Mkid+' order by cqid';
     MySqlDataSet2.Open ;

     while not MySqlDataSet2.eof do
       begin
           New(RecData);
           RecData^.BName:=MySqlDataSet2.FieldByName('cqid').AsString;
           RecData^.DName:=MySqlDataSet2.FieldByName('cqName').AsString;
           RecData^.XHeight:='';
           MyNode:=TV.Items.AddObject(nil,Trim(MySqlDataSet2.FieldByName('cqname').AsString),RecData);
           MyNode.ImageIndex :=2;
           MySqlDataSet2.Next ;
       end;
    MySqlDataSet2.Close ;
    //
    if TV.Items.Count=0  then  exit;

    if MainDataModule.WorkFace_id <>'' then  begin
       for I := 0 to TV.Items.Count  - 1 do
          if PMyRec(TV.Items[i].Data)^.BName = MainDataModule.WorkFace_id   then  begin
               TV.Items[i].Selected :=true; break;
          end;
    end else begin
          TV.Items[0].Selected :=true;
          MainDataModule.WorkFace_id:= PMyRec(TV.Items[0].Data)^.BName;
          MainDataModule.WorkFace_Name:= PMyRec(TV.Items[0].Data)^.DName;
    end;
end;

procedure TselectGZM.FormClose(Sender: TObject; var Action: TCloseAction);
begin
//      Action := caFree;
//     MainCForm.OpenWinCount:=MainCForm.OpenWinCount-1;
//     MainCForm.Caption :=  MainCForm.MainCaption;
//     selectGZM :=nil;
end;

procedure TselectGZM.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
var
   pic_Path:string;
   pt1,pt2:TPoint;
begin
   Pic_Path  :=Public_Basic.Get_MyModulePath+'saveBmp\CoalBMP\OneCoal'+'_0_1.BMP';
   if ShowScreen=1 then begin
      pt1:=ClientToScreen(self.BoundsRect.TopLeft) ;
      pt2:=ClientToScreen(self.BoundsRect.BottomRight) ;
      Public_Basic.ScreenSnap(pt1,pt2,Pic_Path);
   end;

   if Assigned(selectGZM) then  FreeAndNil(selectGZM);
end;

procedure TselectGZM.FormCreate(Sender: TObject);
begin
     MySqlDataSet1:=TMyDataSet.Create(nil);
     MySqlDataSet2:=TMyDataSet.Create(nil);
     MYSQLCommand:=TMyCommand.Create(nil);
     MySqlDataSet1.MySqlConnection:=MainDataModule.ExConn;
     MySqlDataSet2.MySqlConnection:=MainDataModule.ExConn;

     MYSQLCommand.MySqlConnection:=MainDataModule.ExConn;
     //
     MainDataModule.ReadPublicUsedMkInfoFromFile;
end;

procedure TselectGZM.FormDestroy(Sender: TObject);
begin
   FreeAndNil(MySqlDataSet1);
   FreeAndNil(MySqlDataSet2);
   FreeAndNil(MYSQLCommand);
end;

procedure TselectGZM.FormShow(Sender: TObject);
var
   Version:String;
begin
    Captionid:=Public_basic.ReadMainFormVersion(Captionid,Version);
    if Captionid=5 then  begin
       Caption:='更换模拟采煤工作面';
       But_ok.Caption :='确定模拟工作面';
    end;

    MainTreeView(TVMK);
end;

procedure TselectGZM.SelectedTreeNode(TreeView: TTreeView;  sid: string);
var
  i,J:integer;
  SOut:String;
  SelectedNode: TTreeNode;
begin
    if (sid ='0')  or (sid ='') then  begin
         MainDataModule.ClearPublicUsedMkInfo ;
         if TreeView.Items[0].Count>0 then  begin
             TreeView.Items[0].Item[0].Selected :=true;
             MainDataModule.Coal_id:= PMyRec(TreeView.Items[0].Item[0].Data)^.XHeight;
             MainDataModule.Coal_Name:= PMyRec(TreeView.Items[0].Item[0].Data)^.BName;
         end;
    end else begin
       for I := 0 to TreeView.Items.Count  - 1 do
          for j := 0 to TreeView.Items[i].Count - 1 do
              if PMyRec(TreeView.Items[i].Item[j].Data)^.XHeight = sid   then  begin
                  TreeView.Items[i].Item[j].Selected:=true ;
                  MainDataModule.Coal_id := sid;
                  MainDataModule.Coal_Name:=PMyRec(TreeView.Items[i].Item[j].Data)^.BName;
              end;
    end;

    //选取节点
    if TreeView.Selected <> nil then begin
       SelectedNode:=TreeView.Selected;
       MainDataModule.Coal_id:= PMyRec(TreeView.Selected.Data)^.XHeight;
    end;
    //填充
   // if StrToInt_Lu(MainDataModule.Coal_id) >0 then
       fillGzmZk(MainDataModule.Coal_id);
end;
 //转到指定行并选中这行的文本
procedure TselectGZM.SelectLine(Memo1: TMemo; ln: Integer);
begin
   Memo1.SelStart := SendMessage(Memo1.Handle, EM_LINEINDEX, ln - 1, 0);
   Memo1.SelLength := Length(Memo1.Lines[ln - 1]);
end;



procedure TselectGZM.SetFromWidthAndHeigth(flag,iWidth, iHeigth: integer);
var
  iw,ih:integer;
begin
   ShowScreen:=0;
   if Flag=1 then  begin
      self.Width :=iWidth;
      self.Height:=iHeigth-30;
      iw:= (iWidth-60) div  2;
      iH:= iHeigth-80;

      GroupBox1.Visible :=False;
      self.Label1.Visible :=False;
      self.Button1.Visible :=False;
      self.But_Close.Visible :=False;

      GroupBox2.Width := iw;
      GroupBox2.Top :=15;
      GroupBox2.Left :=20;
      GroupBox2.Height :=iH+30;
      GroupBox2.Visible :=true;

      GroupBox3.Top :=15;
      GroupBox3.Left :=iw+35;
      GroupBox3.Height :=iH;
      GroupBox3.Width := iw;
      GroupBox3.Visible :=True;

      But_OK.Caption :='应  用';
      But_OK.Top :=15+iH+10;
      But_OK.Left:=iw+35;
      But_OK.Width:= iw;
      But_OK.Visible :=true;
      But_OK.Height:=20;

      BorderStyle:= bsNone;
      //WindowState:=wsMaximized;
      ShowScreen:=1;
   end;
end;

procedure TselectGZM.TVGzmClick(Sender: TObject);
var
  ParentNode: TTreeNode;
begin
      ParentNode:=self.TVGzm.Selected;
       if ParentNode <> nil then  begin
          MainDataModule.WorkFace_id:= PMyRec(ParentNode.Data)^.BName;
          MainDataModule.WorkFace_Name:= PMyRec(ParentNode.Data)^.DName;

          MainDataModule.Drill_id:='';
          fillGzmZk(MainDataModule.Coal_id);
       end;

end;

procedure TselectGZM.TVMkClick(Sender: TObject);
var
  ParentNode: TTreeNode;
begin
    if (TVMk.Selected = nil) or (PMyRec(TVMk.Selected.Data)^.DName = 'ROOT') then
        exit;
      ParentNode:=TVMk.Selected;
      MainDataModule.Coal_id:= PMyRec(ParentNode.Data)^.XHeight;
      MainDataModule.Coal_Name:= PMyRec(ParentNode.Data)^.BName;

      MainDataModule.WorkFace_id:='';
      MainDataModule.WorkFace_Name:='';

      fillGzmZk(MainDataModule.Coal_id);

end;

procedure TselectGZM.TVZkClick(Sender: TObject);
var
  ParentNode: TTreeNode;
begin
    ParentNode:=self.TVZk.Selected;
    if ParentNode <> nil then  begin
        MainDataModule.Drill_id:= PMyRec(ParentNode.Data)^.BName;
        MainDataModule.Drill_Name:= PMyRec(ParentNode.Data)^.DName;
        DisPlayLabel;

    end;



end;

//将滚动条定位到指定行
procedure TselectGZM.ScrollToLine(Memo1: TMemo; ln: Integer);
begin
    SendMessage(Memo1.Handle, EM_LINESCROLL, 0, -Memo1.Lines.Count);
    SendMessage(Memo1.Handle, EM_LINESCROLL, 0, ln - 1);
end;




procedure TselectGZM.MainTreeView(TreeView: TTreeView);
var
    RecData: PMyRec;
    i,j:integer;
    ParentNode,MyNode: TTreeNode;
begin
   TreeView.Items.Clear;
   MySqlDataSet1.Close ;
   MySqlDataSet1.CommandText:= 'SELECT id,DwName from JituanName order by id';
   MySqlDataSet1.Open;
   MySqlDataSet1.First;

   while not MySqlDataSet1.Eof do begin
       New(RecData);
       RecData^.BName:=Trim(MySqlDataSet1.FieldByName('DwName').AsString);
       RecData^.DName:='ROOT';
       RecData^.XHeight:=Trim(MySqlDataSet1.FieldByName('id').AsString);
       ParentNode:=TreeView.Items.AddObject(nil,Trim(MySqlDataSet1.FieldByName('DwName').AsString),RecData);
       ParentNode.ImageIndex:=4;
       ChildTreeView(TreeView,ParentNode,RecData^.XHeight);

       MySqlDataSet1.next;

   end;
   MySqlDataSet1.Close ;
   //默认选取节点

   SelectedTreeNode(TVMK,MainDataModule.Coal_id);

end;

end.

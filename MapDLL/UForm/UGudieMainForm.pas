unit UGudieMainForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, System.ImageList, Vcl.ImgList,ComObj,System.StrUtils,
  Vcl.ComCtrls, Vcl.ToolWin, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Buttons, Vcl.Grids,
  Vcl.OleCtrls, SHDocVw,mshtml,ActiveX;

type
  TForm_MapMain = class(TForm)
    CoolBar1: TCoolBar;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton4: TToolButton;
    ToolButton3: TToolButton;
    ToolButton11: TToolButton;
    ToolButton12: TToolButton;
    ToolButton13: TToolButton;
    ImageList1: TImageList;
    PanelLeft: TPanel;
    PageControl1: TPageControl;
    TabSheetDz: TTabSheet;
    SG_WBZ: TStringGrid;
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    TabSheetZj: TTabSheet;
    SG_YBZ: TStringGrid;
    Panel2: TPanel;
    BitBtn2: TBitBtn;
    PanelExcel: TPanel;
    StringGrid1: TStringGrid;
    PanelMap: TPanel;
    Splitter1: TSplitter;
    StatusBar1: TStatusBar;
    OpenDialog1: TOpenDialog;
    Panel_ProgressBar: TPanel;
    ProgFirst: TProgressBar;
    ProgSecond: TProgressBar;
    WebBrowser: TWebBrowser;
    Timer1: TTimer;
    ToolButton14: TToolButton;
    Panel_Text: TPanel;
    ToolButton5: TToolButton;
    ToolButton6: TToolButton;
    ToolButton7: TToolButton;
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure ToolButton1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ToolButton2Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ToolButton13Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure ToolButton4Click(Sender: TObject);
    procedure ToolButton14Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure SG_WBZSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure ToolButton11Click(Sender: TObject);
    procedure ToolButton5Click(Sender: TObject);
    procedure ToolButton7Click(Sender: TObject);
    procedure ToolButton6Click(Sender: TObject);
    procedure ToolButton12Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure SG_YBZSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
  private
    { Private declarations }
    Mapx_Out_in,MarkOrSelect:Boolean;
    SelectRad:string;
    MyJingdu,Myweidu: string;
    Click_Jd,Click_Wd:string;
    SelectbZj_bh, Select_T,Select_N,Select_A:string;
    Excel_field,Field_name : Array [0..80] of string;
    procedure InitFiledName;
    procedure ReadExcelFile;
    procedure loadexcel(rowCount,colCount:integer; fileName:String; var grid:TStringGrid);
    procedure initPanelStringGrid;
    procedure initPanelLeft;
    procedure InitSG_StringGrid;
    procedure InitPanleMap;

    function  CreateClass:Boolean;
    procedure SaveIntoDataBase;
    procedure OptionTip(Str:String);
    function  MarkerSupportMap(jd,wd,Name,ZFtype,Address:string):Boolean;
    procedure MapVisual(Value:Boolean);
    //baidu Map
     procedure AppMsg(var Msg: TagMsg; var Handled: Boolean);
     procedure GetWebContent();
     procedure loadweb();
     procedure ClearMapMarker;
     procedure AddAllMarker;
     procedure SetLocalMarker;


  public
    { Public declarations }
  end;

var
  Form_MapMain: TForm_MapMain;
  function CreateMapMianFrom(AHandle:THandle;ACaption:string;Wid,Hi:integer):integer;stdcall;

  //========
   const
  Doc1: string = '<html>'
  + '<head>'
  + '<meta name="viewport" content="initial-scale=1.0, user-scalable=no" />'
  + '<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />'
  + '<title>BAIDU MAP</title>'
  + '<style type="text/css">'
  + 'html{height:100%}' + 'body{height:100%;margin:0px;padding:0px}'
  + '#container{height:100%}'
  + '</style>'
  + '<script type="text/javascript"src="http://api.map.baidu.com/api?v=2.0 & '
  + ' ak=e6DTW515NZFjXnFxhrGiUGhfm83DewTN"></script>'
  + '</head>'
  + '<body>'
  + '<div id="container"></div>'
  //style="visibility:hidden; display:none">
  +'<div id="centerweidu" style="visibility:hidden; display:none"></div>'
  +'<div id="centerjingdu" style="visibility:hidden; display:none"></div>'
  +'<div id="weidutemp" style="visibility:hidden;display:none"></div>'
  +'<div id="jingdutemp" style="visibility:hidden;display:none"></div>'
  +'<div id="weidu" style="visibility:hidden;display:none"></div>'
  +'<div id="jingdu" style="visibility:hidden;display:none"></div>'
  +'<div id="Distance" style="visibility:hidden;display:none"></div>'
  + '<script language="JavaScript" type="text/javascript">'
  + 'var map = new BMap.Map("container");'  // 创建地图实例
  + 'map.addControl(new BMap.NavigationControl());'
  + 'map.addControl(new BMap.ScaleControl());'
  + 'map.addControl(new BMap.OverviewMapControl());'
  + 'map.addControl(new BMap.MapTypeControl(BMAP_ANCHOR_BOTTOM_RIGHT));'   // 将标注添加到地图中
  + 'map.enableScrollWheelZoom();'                  // 启用滚轮放大缩小。
  + 'map.enableKeyboard();'                         // 启用键盘操作。
  + 'var centerpoint = new BMap.Point(113.774579,34.712104);' // 创建点坐标  126.666431, 45.764502
  + 'var marker = new BMap.Marker(centerpoint);'        // 创建标注
  + 'map.addOverlay(marker);'
  + 'var label = new BMap.Label("郑州煤机集团",{offset:new BMap.Size(20,-10)});'
  + 'marker.setLabel(label);'
  +' map.centerAndZoom(centerpoint, 15);' // 初始化地图，设置中心点坐标和地图级别'

  +' map.addEventListener("mousemove", function(e){'
  +' document.getElementById("weidutemp").innerHTML = e.point.lng;'
  +' document.getElementById("jingdutemp").innerHTML =  e.point.lat;});'
  +' map.addEventListener("click", function(f){'
  +' document.getElementById("weidu").innerHTML = f.point.lng;'
  +' document.getElementById("jingdu").innerHTML =  f.point.lat;});'

  +'function SetLocalPoint(){'    //标注厂址坐标
  + ' centerpoint=new BMap.Point(113.774579,34.712104);'
  + 'var marker = new BMap.Marker(centerpoint);'
  + 'map.addOverlay(marker);'
  +  'var label = new BMap.Label("郑州煤机集团",{offset:new BMap.Size(20,-10)});'
  + 'marker.setLabel(label);'
  +' map.centerAndZoom(centerpoint, 15);' // 初始化地图，设置中心点坐标和地图级别'
  +'}'

  +'function SetCenterView(newlng,newlat){'    //设置视图中心坐标
  + ' centerpoint=new BMap.Point(newlng,newlat);'
  +' map.centerAndZoom(centerpoint, 15);' // 初始化地图，设置中心点坐标和地图级别'
  +'}'

//  +'function SetSupportPoint(newlng,newlat,labeltext,titletext,clicktext){'
  +'function SetSupportPoint(newlng,newlat,labeltext,titletext,AddressText){'
  +'centerpoint=new BMap.Point(newlng,newlat);'
  + 'var marker = new BMap.Marker(centerpoint);'
  + 'map.addOverlay(marker);'
  + 'var label = new BMap.Label(labeltext,{offset:new BMap.Size(20,-10)});'
  + 'marker.setLabel(label);'
  + 'marker.setTitle(titletext);'
  + ' marker.addEventListener("click",getAttr);  '
//  + ' "当前支架型号" + titletext+ ",使用者"+labeltext+ ",位于"+AddressText)); '
  + '	function getAttr(){   '
	+ '  var p = marker.getPosition();     '  //获取marker的位置
	+ '   alert("当前支架型号" + titletext+ ",使用者"+labeltext+ ",位于"+AddressText);'
  + ' }'
  + 'map.panTo(centerpoint);'
  +'}'

  +  ' function  clearOverlays() {'   //清理地标
  +  ' map.clearOverlays(); }'


  +' function SearchSupport(newlng,newlat,RedLen) {'      // 指定半径画圆
  + ' var centerpoint=new BMap.Point(newlng,newlat);'
  + ' map.enableScrollWheelZoom(); '
	+ ' map.centerAndZoom(centerpoint,15);  '
  + ' var circle = new BMap.Circle(centerpoint,RedLen,{fillColor:"blue", '
  + '              strokeWeight: 1 ,fillOpacity: 0.3, strokeOpacity: 0.3});  '
  + '   map.addOverlay(circle); '
  + '  var local =  new BMap.LocalSearch(map, {renderOptions: {map: map, autoViewport: false}}); '
  + '   local.searchNearby("",centerpoint,RedLen);  '
  + '}'


  +'function PrintLine(newlng,newlat,oldlng,oldlat,biaoji){'
  +'var point = new BMap.Point(newlng,newlat);' // 创建点坐标
  + 'map.panTo(point);'
//  + 'if (biaoji=''0'')'
//  +'{'
//  + 'var marker = new BMap.Marker(point);'
//  + 'map.addOverlay(marker);'
//  +'}'
  + 'var polyline = new BMap.Polyline(['
  + 'new BMap.Point(oldlng,oldlat),'
  + 'new BMap.Point(point.lng, point.lat)'
  + '], {strokeColor:"blue", strokeWeight:4, strokeOpacity:0.5});'
  + 'map.addOverlay(polyline);'
  +'}'

  +'function GetCenter(){'
  +' var center = map.getCenter();'
  +' document.getElementById("centerweidu").innerHTML = center.lng;'
  +' document.getElementById("centerjingdu").innerHTML = center.lat;'
  +'}'
  +'function Distance(newlng,newlat){'
  +'var pointA=centerpoint;'
  +'var pointB=new BMap.Point(newlng,newlat);'
  +'document.getElementById("Distance").innerHTML = map.getDistance(pointA,pointB);'
  +'alert(''距离是：''+map.getDistance(pointA,pointB)+'' 米。'');'
 // +'return map.getDistance(pointA,pointB);'
  +'}'
  + '</script>'
  + '</body>'
  + '</html>';
  //==================
implementation

{$R *.dfm}

uses Lu_Public_BasicModual, UMainDataModule, SelectCheck;

{ TForm2 }

function CreateMapMianFrom(AHandle:THandle;ACaption:string;Wid,Hi:integer):integer;stdcall;
 begin
       if Assigned(Form_MapMain) then  FreeANdNil(Form_MapMain);

        Form_MapMain:=TForm_MapMain.Create(nil);
        try
           with Form_MapMain do begin
               Caption:=ACaption;
               WindowState:= wsNormal;
               ParentWindow:=Ahandle;

               if Hi >Height then
                   Top :=Round((Hi-Height)/3)  else   Top :=0;
               if Wid> Width then
                   Left:=Round((Wid-Width)/2)  else   Left:=0;

                Show;
                SetFocus;
                Result:=1;//函数值
          end ;
        except
           FreeAndNil(Form_MapMain);
        end;
 end;

procedure TForm_MapMain.AddAllMarker;
var
  i:integer;
  bh,Add,Typ,Nam,Jd,wd:string;
begin

    for I := 1 to SG_YBZ.RowCount-1 do  begin
      bh :=Trim(SG_YBZ.Cells[0,i]);
      Add:=Trim(SG_YBZ.Cells[1,i]);
      Typ:=Trim(SG_YBZ.Cells[2,i]);
      Nam:=Trim(SG_YBZ.Cells[3,i]);
      jd:=Trim(SG_YBZ.Cells[4,i]);
      wd:=Trim(SG_YBZ.Cells[5,i]);
      if public_Basic.StrToInt_lu(bh) >0 then   begin
         MarkerSupportMap(jd,wd,Nam,Typ,Add);
      end;
    end;

end;

procedure TForm_MapMain.AppMsg(var Msg: TagMsg; var Handled: Boolean);
var
  mPoint: TPoint;
begin
  if IsChild(WebBrowser.Handle, Msg.Hwnd) and (Msg.Message = WM_MOUSEMOVE) then
  begin
    GetCursorPos(mPoint);
    GetWebContent;
    Handled := True;
  end;
end;

procedure TForm_MapMain.BitBtn1Click(Sender: TObject);
var
  sql:string;
begin
  if (Click_Jd <> '') and (Click_wd <> '') then   begin
     if MarkerSupportMap(Click_Jd,Click_wd,Select_N,Select_T,Select_A) then begin
         Panel_Text.Caption  :='';
         Select_N:='';
         sql:='update mapbh set mapxbz=''1'',Jingdu='''+Click_Jd+''',weidu='''+Click_wd;
         sql:=sql +''' where bh='''+SelectbZj_bh+'''';
         MainDataModule.MyCommand.CommandText:=sql;
         MainDataModule.MyCommand.Execute(MainDataModule.ExUser);
         BitBtn1.Enabled :=false;
         InitSG_StringGrid;
     end;
  end;
end;

procedure TForm_MapMain.BitBtn2Click(Sender: TObject);
var
 s_sql:widestring;
begin
   if  Application.MessageBox('你确定要删除地图标注么？','操作提示',MB_ICONQUESTION+MB_OkCancel+MB_DEFBUTTON2)=idCancel then
        exit;
   s_sql:='update mapbh set mapxbz=''0'' where bh='''+SelectbZj_bh+'''';
   MainDataModule.MyCommand.CommandText:=s_sql;
   MainDataModule.MyCommand.Execute(MainDataModule.ExUser);
   InitSG_StringGrid;
   ClearMapMarker ;
   SetLocalMarker;
   AddAllMarker;
   BitBtn2.Enabled :=false;
end;

procedure TForm_MapMain.ClearMapMarker;
begin
   WebBrowser.OleObject.Document.parentWindow.execScript ('clearOverlays()', 'JavaScript');
end;

function TForm_MapMain.CreateClass: Boolean;
begin

end;

procedure TForm_MapMain.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
    if Assigned(Form_MapMain) then  FreeANdNil(Form_MapMain);

end;

procedure TForm_MapMain.FormCreate(Sender: TObject);
begin
  self.InitFiledName ;
  SelectRad:='1000';

end;

procedure TForm_MapMain.FormShow(Sender: TObject);
begin
   PubLic_Basic.InitStatusBar(self.StatusBar1);
   Mapx_Out_in:= MainDataModule.ExAdminBool;
   MarkOrSelect:=false;
   initPanelStringGrid ;
   initPanelLeft;
   InitSG_StringGrid;
   InitPanleMap;
   MapVisual(true);
//    ClearMapMarker ;
//    SetLocalMarker;
//    AddAllMarker;
end;

procedure TForm_MapMain.GetWebContent;
var
  html: IHTMLDocument2; // 定义网页元素
  submitbutton: OleVariant; // 定义按钮
  centerweidu, centerjingdu, weidu, jingdu, weidutemp,
  jingdutemp: IHTMLElement; // 定义网页输入元素
begin
  try
    html := self.WebBrowser.Document as IHTMLDocument2;
    centerweidu := html.all.item('centerweidu', 0) as IHTMLElement;
    centerjingdu := html.all.item('centerjingdu', 0) as IHTMLElement;
    weidu := html.all.item('weidu', 0) as IHTMLElement;
    jingdu := html.all.item('jingdu', 0) as IHTMLElement;
    weidutemp := html.all.item('weidutemp', 0) as IHTMLElement;
    jingdutemp := html.all.item('jingdutemp', 0) as IHTMLElement;

    if weidutemp <>nil  then
       Myjingdu:= weidutemp.innerText;
    if jingdutemp<>nil then
       Myweidu:= jingdutemp.innerText;
    if weidu<> nil then
       Click_Jd:=weidu.innerText;
    if jingdu <> nil then
       Click_Wd:= jingdu.innerText;
    if (Click_Jd<>'') and (Select_N <>'') and (MarkOrSelect) then
        Panel_Text.Caption  :='当前定位支架为：' +Select_N+ '  ' + Select_T+ ';   ' +
             ' 当前安放位置为经度'+Click_Jd +',  维度'+Click_Wd;
    if (Click_Jd<>'') and (Select_N <>'') and (not MarkOrSelect) then
        Panel_Text.Caption  :='当前标志中心点经度：'+Click_Jd +',  维度'+Click_Wd +
                    '标注半径为：'+self.SelectRad +' 米';

    StatusBar1.Panels[1].Text:='经度:'+MyJingdu +'   维度:' +MyWeidu;
  except
  end;
end;

procedure TForm_MapMain.InitFiledName;
begin
          Excel_field[1]:='bh';           Field_name[1]:='编号';
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

          //
          Excel_field[74]:='MapxBz';      Field_name[74]:='是否修改';
          Excel_field[75]:='jingdu';       Field_name[75]:='经度';
          Excel_field[76]:='weidu';       Field_name[76]:='纬度';
end;

procedure TForm_MapMain.initPanelLeft;
begin
      self.PanelLeft.Visible:=true;
      SG_WBZ.ColCount :=4;
      SG_WBZ.FixedCols:=1;
      SG_WBZ.FixedRows:=1;
      SG_WBZ.DefaultRowHeight:=18;
      SG_WBZ.ColWidths[0]:=30;    SG_WBZ.Cells[0,0]:='序号';
      SG_WBZ.ColWidths[1]:=80;    SG_WBZ.Cells[1,0]:='煤田区域';
      SG_WBZ.ColWidths[2]:=80;    SG_WBZ.Cells[2,0]:='支架型号';
      SG_WBZ.ColWidths[3]:=80;    SG_WBZ.Cells[3,0]:='支架名称';

      SG_YBZ.ColCount :=6;
      SG_YBZ.FixedCols:=1;
      SG_YBZ.FixedRows:=1;
      SG_YBZ.DefaultRowHeight:=18;
      SG_YBZ.ColWidths[0]:=30;    SG_YBZ.Cells[0,0]:='序号';
      SG_YBZ.ColWidths[1]:=80;    SG_YBZ.Cells[1,0]:='煤田区域';
      SG_YBZ.ColWidths[2]:=80;    SG_YBZ.Cells[2,0]:='支架型号';
      SG_YBZ.ColWidths[3]:=80;    SG_YBZ.Cells[3,0]:='支架名称';
      SG_YBZ.ColWidths[4]:=80;    SG_YBZ.Cells[3,0]:='经度';
      SG_YBZ.ColWidths[5]:=80;    SG_YBZ.Cells[3,0]:='维度';
end;

procedure TForm_MapMain.initPanelStringGrid;
var
 i:integer;
begin
        PanelExcel.Align:=alClient;
        StringGrid1.FixedCols:=1;
        StringGrid1.FixedRows:=1;
        StringGrid1.Font.Size :=8;
        StringGrid1.ColCount:=76;
        StringGrid1.DefaultRowHeight:=18;
        StringGrid1.Align:=alClient;
        StringGrid1.Visible:=true;
          for I := 1 to 74 do  begin
           self.StringGrid1.ColWidths[i-1]:=length(self.Field_name[i])*20;
           self.StringGrid1.Cells[i-1,0]:=self.Field_name[i];
        end;

end;

procedure TForm_MapMain.InitPanleMap;
begin
  PanelMap.Align:=alClient;
  loadweb;
  Click_Jd := '';
  Click_wd := '';
  timer1.Enabled := True;
end;

procedure TForm_MapMain.InitSG_StringGrid;
var
    I,J:integer;
    bh,Str:widestring;

begin
     for I := 1 to SG_WBZ.RowCount - 1 do
         for j := 0 to SG_WBZ.ColCount - 1 do
                SG_WBZ.Cells[j,i]:='';
       for I := 1 to SG_YBZ.RowCount - 1 do
         for j := 0 to SG_YBZ.ColCount - 1 do
                SG_YBZ.Cells[j,i]:='';

      MainDataModule.MyDataSet.Close();
      MainDataModule.MyDataSet.CommandText:='select bh,zj_type,Mt_address,zj_name from Mapbh where mapXbz=''0''';
      MainDataModule.MyDataSet.Open();
      i:=1;
      while not MainDataModule.MyDataSet.Eof  do begin
            self.SG_WBZ.Cells[0,i]:=MainDataModule.MyDataSet.FieldByName('bh').AsString;
            self.SG_WBZ.Cells[1,i]:=MainDataModule.MyDataSet.FieldByName('Mt_address').AsString;
            self.SG_WBZ.Cells[2,i]:=MainDataModule.MyDataSet.FieldByName('Zj_type').AsString;
            self.SG_WBZ.Cells[3,i]:=MainDataModule.MyDataSet.FieldByName('zj_name').AsString;
            MainDataModule.MyDataSet.Next;
            if Sg_WBZ.RowCount-2 <i then  Sg_WBZ.RowCount:=i+2;
            i:=i+1;
          end;
      MainDataModule.MyDataSet.Close();
      MainDataModule.MyDataSet.CommandText:='select bh,zj_type,Mt_address,zj_name,Jingdu,Weidu from Mapbh where mapXbz=''1''';
      MainDataModule.MyDataSet.Open();
      i:=1;
      while not MainDataModule.MyDataSet.Eof  do    begin
            self.SG_YBZ.Cells[0,i]:=MainDataModule.MyDataSet.FieldByName('bh').AsString;
            bh:= MainDataModule.MyDataSet.FieldByName('bh').AsString;;
            self.SG_YBZ.Cells[1,i]:=MainDataModule.MyDataSet.FieldByName('Mt_address').AsString;
            self.SG_YBZ.Cells[2,i]:=MainDataModule.MyDataSet.FieldByName('Zj_type').AsString;
            str:= bh+'|'+MainDataModule.MyDataSet.FieldByName('Mt_address').AsString+'|'+MainDataModule.MyDataSet.FieldByName('Zj_type').AsString;
            self.SG_YBZ.Cells[3,i]:=MainDataModule.MyDataSet.FieldByName('zj_name').AsString;
            SG_YBZ.Cells[4,i]:=MainDataModule.MyDataSet.FieldByName('Jingdu').AsString;
            SG_YBZ.Cells[5,i]:=MainDataModule.MyDataSet.FieldByName('weidu').AsString;

            if Sg_YBZ.RowCount-2 <i then  Sg_YBZ.RowCount:=i+2;
             i:=i+1;
            MainDataModule.MyDataSet.Next;

          end;
          StatusBar1.Panels.Items[1].Text :='' ;
       MainDataModule.MyDataSet.Close();


end;

procedure TForm_MapMain.loadexcel(rowCount, colCount: integer; fileName: String;
  var grid: TStringGrid);
var
   v:variant;
   i,j:integer;
begin
   grid.RowCount:=rowCount;
   grid.ColCount:=colCount;
   v:=createoleobject('Excel.Application');//创建OLE对象
   try
      Panel_ProgressBar.Visible :=true;
      ProgFirst.Position := 0;
      ProgFirst.Max :=  rowCount;
      ProgSecond.Position := 4;
      ProgSecond.Max := 85;
      V.workBooks.Open(fileName);

     for j:=2 to rowCount do  begin
       ProgFirst.Position:=j;
       ProgSecond.Position := 4;
       grid.Cells[0,j-1]:=v.workbooks[1].sheets[1].cells[j,1];

       if Trim(grid.Cells[0,j-1])<>'' then begin
           for i:=1 to 76 do   begin
               ProgSecond.Position := i+4;
               grid.Cells[i-1,j-1]:=v.workbooks[1].sheets[1].cells[j,i];
           end;
       end else begin
            break;
       end;

     end;
        v.workbooks[1].close;
   finally
      v.quit;
      Panel_ProgressBar.Visible :=false;
      OptionTip('数据读成功！');
   end

end;

procedure TForm_MapMain.loadweb;
var
  sl: TStringList;
  ms: TMemoryStream;
begin
  self.WebBrowser.Silent := True;
  WebBrowser.Navigate('about:blank'); (WebBrowser.Document as IHTMLDocument2)
  .URL := 'http://127.0.0.1/';
  while WebBrowser.ReadyState < READYSTATE_INTERACTIVE do
    Application.ProcessMessages;
  if Assigned(WebBrowser.Document) then
  begin
    sl := TStringList.Create;
    try
      ms := TMemoryStream.Create;
      try
        sl.Text := Doc1;
        sl.SaveToStream(ms);
        ms.Seek(0, 0); (WebBrowser.Document as IPersistStreamInit)
        .Load(TStreamAdapter.Create(ms));
      finally
        ms.Free;
      end;
    finally
      sl.Free;
    end;
  end;


end;

procedure TForm_MapMain.MapVisual(Value: Boolean);
begin

       self.PanelMap.Visible :=Value;
       self.PanelLeft.Visible :=Value;
       self.PanelExcel.Visible:=not value;


end;

function TForm_MapMain.MarkerSupportMap(jd,wd,Name,ZFtype,Address:string):Boolean;
begin
  Result:=true;
   try
      WebBrowser.OleObject.Document.parentWindow.execScript
      ('SetSupportPoint(' + jd + ',' + wd + ','''+Name+''','''+ZFtype+''','''+Address+''')', 'JavaScript');

   except
      Result:=False;
   end;
end;

procedure TForm_MapMain.OptionTip(Str: String);
begin
  self.StatusBar1.Panels[0].Text :=str;
end;

procedure TForm_MapMain.ReadExcelFile;
var
   Row_c,Col_c:integer;
   I: Integer;
begin
   if Application.MessageBox('你确定要打开Excel文件读入数据么？','操作提示',MB_ICONQUESTION+MB_OkCancel+MB_DEFBUTTON2)=idCancel then
        exit;
    OpenDialog1.Execute() ;

    if length(Trim(self.OpenDialog1.FileName))>0 then
     if  UpperCase(Rightstr(Trim(self.OpenDialog1.FileName),3))='XLS' then begin
         // ReadExcel(sender,self.OpenDialog1.FileName);
         loadexcel(3000,75,OpenDialog1.FileName,stringGrid1);
     end else  begin
          ShowMessage('请仔细查看文件的格式');
     end;


end;

procedure TForm_MapMain.SaveIntoDataBase;
 var
   i,j,k:Integer;
   S_Sql,Filed_Name,Field_s:Ansistring;
   st_xh:Ansistring;
   CellS,xh_C:string;
begin
   try
    for j := 1 to self.StringGrid1.RowCount-1 do  begin
          try
             if Trim(self.StringGrid1.Cells[0,j])='' then break;
             xh_C:=self.StringGrid1.Cells[0,j] ;
             MainDataModule.MyDataSet.Close;
             MainDataModule.MyDataSet.CommandText:='select bh from Mapbh where bh='''+xh_C+'''';
             if MainDataModule.MyDataSet.Open then begin
                 if MainDataModule.MyDataSet.RecordCount >1 then  begin
                    S_Sql:='delete from  Mapbh  where  bh ='''+xh_C+'''' ;
                    MainDataModule.MyCommand.CommandText:=s_Sql;
                    MainDataModule.MyCommand.Execute();
                 end;
             end;
             MainDataModule.MyDataSet.Close;

            Filed_Name:=''; Field_s:='';
            for I := 1 to 73 do  begin
                   Filed_Name:=Filed_Name+self.Excel_field[i]+',' ;
                   CellS:=StringGrid1.Cells[i-1,j] ;
                   if length(StringGrid1.Cells[i-1,j] ) >190 then
                      CellS:=leftstr(CellS,190) ;
                   Field_s:=Field_s+''''+CellS+'''' + ',';
            end; //end i
            S_Sql:='insert into Mapbh ('+Filed_Name+'MapxBz'+') values ('+Field_s+'0)';
            MainDataModule.MyCommand.CommandText:=s_Sql;
            MainDataModule.MyCommand.Execute();

          except
              continue;
          end;


    end;

   finally
      OptionTip('数据存储成功!');
      InitSG_StringGrid
   end;

end;

procedure TForm_MapMain.SetLocalMarker;
begin
   //加注厂址坐标
    WebBrowser.OleObject.Document.parentWindow.execScript ('SetLocalPoint()', 'JavaScript');
end;

procedure TForm_MapMain.SG_WBZSelectCell(Sender: TObject; ACol, ARow: Integer;
  var CanSelect: Boolean);
begin
      MarkOrSelect:=true;
      SelectbZj_bh :=Trim(SG_WBZ.Cells[0,ARow]);
      Select_A:=Trim(SG_WBZ.Cells[1,ARow]);
      Select_T:=Trim(SG_WBZ.Cells[2,ARow]);
      Select_N:=Trim(SG_WBZ.Cells[3,ARow]);
     if  length(trim(SelectbZj_bh))>0 then begin
         BitBtn1.Enabled :=Mapx_Out_in;
         Click_jd:='';Click_wd:='';
     end;
end;

procedure TForm_MapMain.SG_YBZSelectCell(Sender: TObject; ACol, ARow: Integer;
  var CanSelect: Boolean);
var
  jd,wd:string;
begin
     jd:='';wd:='';
     SelectbZj_bh :=Trim(SG_YBZ.Cells[0,ARow]);
     if  length(trim(SelectbZj_bh))>0 then begin
         BitBtn2.Enabled :=Mapx_Out_in;
         jd :=Trim(SG_YBZ.Cells[4,ARow]);
         wd :=Trim(SG_YBZ.Cells[5,ARow]);
         if (jd<> '') and (wd<>'') then
         WebBrowser.OleObject.Document.parentWindow.execScript
           ('SetCenterView(' + jd + ',' + wd + ')', 'JavaScript');

     end;
end;

procedure TForm_MapMain.Timer1Timer(Sender: TObject);
begin
     GetWebContent;
end;

procedure TForm_MapMain.ToolButton11Click(Sender: TObject);
begin
  if not self.PanelMap.Visible  then
     MapVisual(true);
  MarkOrSelect:=false;
  if (Click_Jd <> '') and (Click_wd <> '') then     begin
      self.WebBrowser.OleObject.Document.parentWindow.execScript
      ('SearchSupport(' + Click_Jd + ',' + Click_wd + ', '+ SelectRad+')', 'JavaScript');
  end;
end;

procedure TForm_MapMain.ToolButton12Click(Sender: TObject);
begin
   self.ClearMapMarker;
end;

procedure TForm_MapMain.ToolButton13Click(Sender: TObject);
begin
  CreateSelectForm(handle,'符合查询页面',self.Width ,self.Height );
end;

procedure TForm_MapMain.ToolButton14Click(Sender: TObject);
begin
  Close;
end;

procedure TForm_MapMain.ToolButton1Click(Sender: TObject);
begin
   initPanelStringGrid;
   self.MapVisual(false);
   ReadExcelFile;
end;

procedure TForm_MapMain.ToolButton2Click(Sender: TObject);
begin
   self.SaveIntoDataBase;
end;

procedure TForm_MapMain.ToolButton4Click(Sender: TObject);
begin
   InitPanleMap;
   MapVisual(true);
end;

procedure TForm_MapMain.ToolButton5Click(Sender: TObject);
begin
    SelectRad:=InputBox('查询半径录入', '请录入查询半径（米）', '1000') ;
    if Public_basic.StrToDouble_Lu(SelectRad)  <100 then
      SelectRad:='1000';

end;

procedure TForm_MapMain.ToolButton6Click(Sender: TObject);
begin
   AddAllMarker;
end;

procedure TForm_MapMain.ToolButton7Click(Sender: TObject);
begin
    SetLocalMarker;
end;

end.




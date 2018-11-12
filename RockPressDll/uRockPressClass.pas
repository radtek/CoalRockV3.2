//  SetDatabaseType 主要设置数据库的类型， 不同数据库的结构保存在 sqlite 数据库中
//  CreateDatabase 创建数据库， 创建数据库的内容保存在 sqlite 数据库中 //
//
//
//
//
//

unit uRockPressClass;

interface

uses   ActiveX, Mtsobj, Mtx, ComObj, StdVcl,SysUtils, StrUtils,
       Windows,Messages,math,Classes,uIRockPress,Dialogs;

type
   TBodyClass_RockPress = class (TDefine_RockPress)
        private
            function IsValidObject(const Obj: TObject): Boolean;
        protected

          //20180411
           procedure SetStatuesCaption(Value:PansiChar); override;
           function  CreateBatInputD(AHandle:THandle;Caption:Pansichar;Width,Heigth,Flag:integer):THandle; override;
           function  CreateEditFootage_Data(AHandle:THandle;Caption:Pansichar;Width,Heigth,Flag:integer):THandle;  override;
           function  CreateRockPressGraph(AHandle:THandle;Caption:Pansichar;Width,Heigth,Flag:integer):THandle;  override;
           function  CreateEditJinDao(AHandle:THandle;Caption:Pansichar;Width,Heigth,Flag:integer):THandle;  override;
           function  CreateRockLineGraph(AHandle:THandle;Caption:Pansichar;Width,Heigth,Flag:integer):THandle;  override;
           procedure SetPublic_BasicLicending(Value:Boolean;UName:Pansichar); override;
           procedure CloseRockPressTool;override;

           //---------------
           function GetWinFormIsExsit(WinName:Pansichar):Boolean;override;
           function CloseActiveForm(FormStr:Pansichar):Boolean; override;
           function SetOpenFormChangeParentPanel(WinName:Pansichar;AHandle:THandle):Boolean; override;
           function OpenConTourChildForm(WinName:Pansichar;AHandle:THandle;Width,Heigth:integer):Boolean; override;
           procedure GetMinAndMaxJinDao(var MinD,MaxD:integer); override;
          //系统函数
           constructor Create; override;
           destructor  Destroy; override;
   end; // end TRockPressure



implementation

uses uMainFun, uBatInputRockData, UFormEditPressData,
  UFormModifyJinDao, UForm_ContourGraph, UForm_LineGraph, RockPresstool,
  UForm_Brand_Bar, UForm_MoveSupportGraph, UForm_phaseGraph_Tongji,
  UForm_ThreeDimGraph;


//=======================================================================================


//===================================================================================================================================
 { TRockPressure }


{ TRockPressure }








function TBodyClass_RockPress.CloseActiveForm(FormStr: Pansichar):Boolean;
Var
  WinStr:String;
begin
  inherited;
   Result:=true;
   WinStr:=UpperCase(StrPas(FormStr));
   try
       if WinStr='CONTOUR' then  BEGIN
          if Assigned(Form_ContourGraph) then  begin
             Form_ContourGraph.CloseScreenFlag:=0;
             Form_ContourGraph.Close ;
          end;
       end else  if WinStr='LINEGRAHP' then begin
          if Assigned(Form_LineGraph) then  Form_LineGraph.Close ;
       end else  if WinStr='BANDBAR' then  begin//'BANDBAR'
          if Assigned(Form_Band_Bar) then  Form_Band_Bar.Close ;
       end else  if WinStr='MOVEPOINT' then begin //'MOVESUPPORT'
          if Assigned(UForm_MoveSupport) then  UForm_MoveSupport.Close ;
       end else  if WinStr='TONGJI' then begin //'TONGJI'
          if Assigned(Form_TongJIGraph) then  Form_TongJIGraph.Close ;
       end else  if WinStr='EDITJINCHI' then  begin//'EDITJINCHI'
          if Assigned(ModifyJinDao_From) then  ModifyJinDao_From.Close ;
       end else  if WinStr='EDITDATA' then  begin//'EDITDATA'
          if Assigned(Edit_PressDataForm) then  Edit_PressDataForm.Close ;
       end else if WinStr='PRESSTOOL' then begin //'PRESSTOOL'
          if Assigned(FormPressTool) then  FormPressTool.Close;
       end else if WinStr='THREERESULT' then begin //'THREERESULT'
          if Assigned(Form_ThreeGraph) then  Form_ThreeGraph.Close ;
       end else if WinStr='BATINPUT' then begin //'BATINPUT'
          if Assigned(Form_BatInPutData) then  Form_BatInPutData.Close;

       end else if WinStr='ALL' then begin
           if Assigned(FormPressTool) then  FormPressTool.Close;
           if Assigned(Form_ContourGraph) then begin
                Form_ContourGraph.CloseScreenFlag:=0;
                Form_ContourGraph.Close ;
           end;
           if Assigned(Form_LineGraph) then  Form_LineGraph.Close ;
           if Assigned(Form_Band_Bar) then  Form_Band_Bar.Close ;
           if Assigned(UForm_MoveSupport) then  UForm_MoveSupport.Close ;
           if Assigned(Form_TongJIGraph) then  Form_TongJIGraph.Close ;
           if Assigned(ModifyJinDao_From) then  ModifyJinDao_From.Close ;
           if Assigned(Edit_PressDataForm) then  Edit_PressDataForm.Close ;
           if Assigned(Form_BatInPutData) then  Form_BatInPutData.Close;
       end;
   finally

   end;

end;


procedure TBodyClass_RockPress.CloseRockPressTool;
begin
  inherited;
  if Assigned(FormPressTool) then FormPressTool.Close ;

end;

constructor TBodyClass_RockPress.Create;
begin
  inherited;
     CoInitialize(nil);
     MyMainFun:=TMainForm.Create;
end;

function TBodyClass_RockPress.CreateBatInputD(AHandle: THandle;
  Caption: Pansichar; Width, Heigth,Flag: integer): THandle;
var
  SOut:String;
begin
  inherited;
   SOut:=strPas(Caption);
   Result:=CreateBatInputData_inn(AHandle,Sout,Width,Heigth,Flag) ;

end;

function TBodyClass_RockPress.CreateEditFootage_Data(AHandle: THandle;
  Caption: Pansichar; Width, Heigth, Flag: integer): THandle;
var
  SOut:String;
begin
  inherited;
   SOut:=strPas(Caption);

   Result:=CreateFootage_Data(AHandle,Sout,Width,Heigth,Flag);

end;

function TBodyClass_RockPress.CreateEditJinDao(AHandle: THandle;
  Caption: Pansichar; Width, Heigth, Flag: integer): THandle;
var
  SOut:String;
begin
  inherited;
   SOut:=strPas(Caption);

   Result:=CreateModify_JinDao(AHandle,Sout,Width,Heigth,Flag);

end;

function TBodyClass_RockPress.CreateRockLineGraph(AHandle: THandle;
  Caption: Pansichar; Width, Heigth, Flag: integer): THandle;
var
  SOut:String;
begin
  inherited;
   SOut:=strPas(Caption);
   Result:=CreateLineGraph(AHandle,Sout,Width,Heigth,Flag);
end;

function TBodyClass_RockPress.CreateRockPressGraph(AHandle: THandle;
  Caption: Pansichar; Width, Heigth, Flag: integer): THandle;
var
  SOut:String;
begin
  inherited;
   SOut:=strPas(Caption);

   Result:=Create_ConTourGrap(AHandle,Sout,Width,Heigth,Flag);

end;



destructor TBodyClass_RockPress.Destroy;
begin

  if IsValidObject(MyMainFun) then
        Freeandnil(MyMainFun);
  CoUninitialize;
end;






procedure TBodyClass_RockPress.GetMinAndMaxJinDao(var MinD, MaxD: integer);
begin
  inherited;
     if Assigned(Form_ContourGraph) then  begin
        MinD:=Form_ContourGraph.DrawGzm.DataTimeAndFootAge.Graph_MinDao;
        MaxD:=Form_ContourGraph.DrawGzm.DataTimeAndFootAge.Graph_MaxDao;
     end else begin
        MinD:=0;
        MaxD:=0;
     end;
end;

function TBodyClass_RockPress.GetWinFormIsExsit(WinName: Pansichar): Boolean;
Var
  WinStr:String;
begin
   Result:=False;
   WinStr:=UpperCase(StrPas(WinName));
   if WinStr='CONTOUR' then
      if Assigned(Form_ContourGraph) then  Result:=true;
   if WinStr='LINEGRAHP' then
      if Assigned(Form_LineGraph) then  Result:=true;
   if WinStr='BRANDBAR' then  //'BANDBAR'
      if Assigned(Form_Band_Bar) then  Result:=true;
   if WinStr='MOVEPOINT' then  //'MOVESUPPORT'
      if Assigned(UForm_MoveSupport) then  Result:=true;
   if WinStr='TONGJI' then  //'TONGJI'
      if Assigned(Form_TongJIGraph) then  Result:=true;
   if WinStr='EDITJINCHI' then  //'EDITJINCHI'
      if Assigned(ModifyJinDao_From) then  Result:=true;
   if WinStr='EDITDATA' then  //'EDITDATA'
      if Assigned(Edit_PressDataForm) then  Result:=true;
   if WinStr='PRESSTOOL' then  //'EDITDATA'
      if Assigned(FormPressTool) then  Result:=true;
   if WinStr='THREERESULT' then  //'THREERESULT'
      if Assigned(Form_ThreeGraph) then  Result:=true;
   if WinStr='BATINPUT' then  //'BATINPUT'
      if Assigned(Form_BatInPutData) then  Result:=true;

end;

function TBodyClass_RockPress.IsValidObject(const Obj: TObject): Boolean;
begin
   try
    Result := PInteger(Integer(Obj.ClassType)+vmtSelfPtr)^ = Integer(Obj.ClassType);
  except
    Result := False;
  end;

end;

function TBodyClass_RockPress.OpenConTourChildForm(WinName: Pansichar;
  AHandle: THandle;Width,Heigth:integer): Boolean;
Var
  WinStr:String;
begin
   Result:=False;
   WinStr:=UpperCase(StrPas(WinName));
   if not Assigned(Form_ContourGraph) then exit;
   if not Form_ContourGraph.DrawGzm.CloudClass. RockPressAnslysis then
      Form_ContourGraph.But_Start_KYFX.Click ;

   if Form_ContourGraph.Visible  then  Form_ContourGraph.Visible :=False;

   if WinStr='LINEGRAHP' then  begin
      Form_ContourGraph.OpenLinGraph(AHandle,Width,Heigth);
   end else if  WinStr='PRESSANSLY' then  begin
      Form_ContourGraph.But_Start_KYFX.Click ;
   end else if  WinStr='THREERESULT' then begin
      Form_ContourGraph.OpenThreeResult(AHandle,Width,Heigth);
   end else if WinStr='BRANDBAR' then begin
      Form_ContourGraph.OpenBndBar(AHandle,Width,Heigth);
   end else if WinStr='TONGJI' then begin
      Form_ContourGraph.OpenTongJi(AHandle,Width,Heigth);
   end else if WinStr='MOVEPOINT' then begin
      Form_ContourGraph.MovePointState(AHandle,Width,Heigth);
   end else if WinStr='REPORTWORD' then begin
      Form_ContourGraph.OpenReportWord(AHandle,Width,Heigth);
   end;



end;

function TBodyClass_RockPress.SetOpenFormChangeParentPanel(WinName: Pansichar;
  AHandle: THandle): Boolean;
Var
  WinStr:String;
begin
   Result:=False;
   WinStr:=UpperCase(StrPas(WinName));
   if WinStr='CONTOUR' then
      if Assigned(Form_ContourGraph) then begin
         Form_ContourGraph.ParentWindow:= AHandle;
         Form_ContourGraph.Visible:=true;
         Form_ContourGraph.Refresh ;
      end;
   if WinStr='LINEGRAHP' then
      if Assigned(Form_LineGraph) then  Form_LineGraph.ParentWindow:= AHandle;
   if WinStr='BANDBAR' then  //'BANDBAR'
      if Assigned(Form_Band_Bar) then  Form_Band_Bar.ParentWindow:= AHandle;
   if WinStr='MOVESUPPORT' then  //'MOVESUPPORT'
      if Assigned(UForm_MoveSupport) then  UForm_MoveSupport.ParentWindow:= AHandle;
   if WinStr='TONGJI' then  //'TONGJI'
      if Assigned(Form_TongJIGraph) then  Form_TongJIGraph.ParentWindow:= AHandle;
   if WinStr='EDITJINCHI' then  //'EDITJINCHI'
      if Assigned(ModifyJinDao_From) then  ModifyJinDao_From.ParentWindow:= AHandle;
   if WinStr='EDITDATA' then  //'EDITDATA'
      if Assigned(Edit_PressDataForm) then  Edit_PressDataForm.ParentWindow:= AHandle;
   if WinStr='PRESSTOOL' then  //'EDITDATA'
      if Assigned(FormPressTool) then  FormPressTool.ParentWindow:= AHandle;

    Result:=true;
end;

procedure TBodyClass_RockPress.SetPublic_BasicLicending(Value: Boolean;UName:Pansichar);
begin
  inherited;
   MyMainFun.SetLicenseing(Value,StrPas(UName));
end;

procedure TBodyClass_RockPress.SetStatuesCaption(Value: PansiChar);
begin
  inherited;
  MyMainFun.SetStatusCaption(strPas(Value));
end;







end. // end unit

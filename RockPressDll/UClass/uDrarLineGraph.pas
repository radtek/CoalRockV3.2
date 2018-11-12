unit uDrarLineGraph;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.ComCtrls, Vcl.StdCtrls, Vcl.Grids,
  VclTee.TeeGDIPlus, VCLTee.TeEngine, VCLTee.TeeProcs, VCLTee.Chart,VCLTee.TeeSurfa,
  UMainDataModule,PStope_GzmGuidClass,Lu_Public_BasicModual,VCLTee.TeCanvas,VCLTee.Series,
  uDrawGraphClass,UMakeRuleClass ,VCLTee.TeeTools

  ;

type
  TDrawLineGraph =Class(TPersistent )

  private
     FDataTimeAndFootAge:TDataTimeAndFootAge;
     FCloudClass : TCloudClass;//云图数据记录
     FLineClass:TGraphDataClass ;
     FinGzm:TGzm;
     FVertAxis:integer; // 数轴数量
     FSupportNumber:integer;
     FSupportArray:Array of  TSupportRecord;
     FChart:TChart;
     FScrollBar:TScrollBar;
     FUnitType:TColorValue;
     FNextDataDisp:integer; // 下一批数据 每组数字 FVertAxis 个
     FSupportMaxNumber:integer;// 液压支架最大值
     FArrayDataCount:Integer;
     FDataItems :Array of TFirstData;
     FirStPB,SecondPB:TProgressBar;
     FUseDrawClass:TDrawGrap;
     FMakerStep:Boolean;//是否标注来压信息

     procedure SetClourClass(Value:TCloudClass);
     function GetClourClass:TCloudClass;
     procedure SetDTF(Value:TDataTimeAndFootAge);
     function GetDTF:TDataTimeAndFootAge;
     procedure SetLineClass(Value: TGraphDataClass);
     function GetLineClass:TGraphDataClass ;
     procedure SetGZM(Value:TGzm);
     function GetGzm:TGzm;
     procedure SetChart(Value:Tchart);
     function  GetChart:Tchart;
     procedure  SetUnitType(Value:TColorValue);
     function GetUnitType:TColorValue;
     procedure SetNextDataDisp(Value:integer);
     function GetNextDateDisp:integer;
     function GetSupportMAXNumber:integer;
     procedure SetSupportMAXNumber(Value:integer);
     function GetDrawClass: TDrawGrap;
     procedure setDRawClass(Value:TDrawGrap);
     procedure SetMarkerStep(Value:Boolean);
     function GetMarkerStep:Boolean;
      //chart
     procedure MakeLineGraphChartTitle(Chart: Tchart);
     procedure SetChartAxisMaxAndMinValue(BottomAxis: TChartAxis;MaxV,MinV:double);
     procedure MakeVertAxis(Number:integer);
     procedure AddSupportMarkLabel(Postion,id,xh:integer;Value:String);
     procedure AddShupingLine(Chart:TChart; Asix:TChartAxis;Flag:integer);
      //FSupportArray
     procedure ClearChartSeries;
     procedure ClearSupportArray;
     procedure AddNextSupport(Rec:TSupportRecord);
     procedure SplitSupportList(Value:string);
     function SplitSupportList_Child(Value:string):Boolean;
     function CreatLineSeries(Support:Integer):TLineSeries;
     function FillSupportRockPress(LineSeries:TLineSeries;SupportBh:Integer):Boolean;
     // FillCycleAndStep
     function FillCycleAndStepInfo(Chart:TChart; Asix:TChartAxis;Rec:TSupportRecord):String;
     function FillCycleAndStep_Chart(Chart:TChart; Asix:TChartAxis;Color1:TColor;
                          DataType:string;SupportBh,Linestyle:integer):Boolean;
     function FillCycleWholeAGVLine(Chart:TChart; Asix:TChartAxis;Color1:TColor;
                          SupportBh:integer):Boolean;
     function MakerStepInfo(Chart:TChart; Asix:TChartAxis; var REC:TSupportRecord):integer;
     function isExsitRockPressFile(SupportBh:Integer):Boolean;
     //
     function ReturnColorName(Value:integer):String;
     function ReturnLineTypeName(Value:integer):String;
  public
       property DrawClass:TDrawGrap  read GetDrawClass write setDRawClass;
       property DataTimeAndFootAge:TDataTimeAndFootAge  read GetDTF write SetDTF;
       property CloudClass:TCloudClass  read GetClourClass write SetClourClass;
       property LineGraph:TGraphDataClass  read GetLineClass write SetLineClass;
       property UseGzm:TGzm  read GetGzm write SetGZM;
       property MainChart:TChart  read GetChart write SetChart;
       Property UnitType:TColorValue  read GetUnitType write SetUnitType;
       Property SupportMaxCount:integer   read GetSupportMAXNumber write SetSupportMAXNumber;
       Property NextDataDisp:integer read GetNextDateDisp write SetNextDataDisp;
       property MarkerStep:Boolean read GetMarkerStep write SetMarkerStep;



       procedure InitClass(iChart:TChart;
                           iSB:TScrollBar;
                           iDrawClass:TDrawGrap;
                           iFPB,iSPB:TProgressBar
                           );
       //
       procedure DataArrayClear;
       procedure DataArrayAdd(tm:TFirstData);
       function  ReturnMarkLabel(Mem1:TMemo;Supportbh,id,qd:integer):Boolean;
       //
       constructor Create;
       destructor  Destroy;


end;
implementation

{ TDrawLineGraph }

procedure TDrawLineGraph.AddNextSupport(Rec: TSupportRecord);
begin
    inc(FSupportNumber);
    setlength(FSupportArray,FSupportNumber);
    FSupportArray[FSupportNumber-1]:=Rec;
end;

procedure TDrawLineGraph.AddShupingLine(Chart: TChart; Asix: TChartAxis;
  Flag: integer);
var
  Data:Double;
begin


    Chart.AddSeries(TLineSeries);

    if Flag=1 then  begin   // 初撑力
       Data:=UseGzm.Usedsupport.initLoad *UnitType.UnitValue;
       Chart[Chart.SeriesCount-1].Color :=ClGreen;
      // Chart[Chart.SeriesCount-1].Add('初撑力线');
    end else if  Flag=2  then begin      //液压阀开启
       Data:=UseGzm.Usedsupport.EndOpenLoad*UnitType.UnitValue;
       Chart[Chart.SeriesCount-1].Color :=ClRed;

    end;
    Chart[Chart.SeriesCount-1].Pen.width:=LineGraph.Line_Width+2;

    Chart[Chart.SeriesCount-1].AddXY(self.DataTimeAndFootAge.StartTime,Data);
    Chart[Chart.SeriesCount-1].AddXY(self.DataTimeAndFootAge.EndTime,Data);
    Chart[Chart.SeriesCount-1].CustomVertAxis:=Asix;
    Chart[Chart.SeriesCount-1].Legend.Visible:=False;
end;

procedure TDrawLineGraph.AddSupportMarkLabel(Postion,id,xh:integer;Value: String);
{
   xh 是代表几个的意思

}
var
  TB:TPointSeries;
begin
   if Xh>0  then  begin
        MainChart.CustomAxes.Add;
        MainChart.CustomAxes.Items[MainChart.CustomAxes.Count-1].StartPosition := Trunc((5*id+4)/4 * Postion);
        MainChart.CustomAxes.Items[MainChart.CustomAxes.Count-1].EndPosition :=Trunc((5*id+5)/4 * Postion);
        MainChart.CustomAxes.Items[MainChart.CustomAxes.Count-1].Labels:=False;
        MainChart.CustomAxes.Items[MainChart.CustomAxes.Count-1].Axis.width:=LineGraph.Line_Width;
        MainChart.CustomAxes.Items[MainChart.CustomAxes.Count-1].Minimum :=0;
        MainChart.CustomAxes.Items[MainChart.CustomAxes.Count-1].Maximum :=100;
   end;

    TB:=MainChart.AddSeries(TPointSeries) as TPointSeries;
    with TB do begin
        Marks.Visible:=true;
       // Marks.Transparent:=true;
        Marks.Font.Size:=8;
        legend.Visible :=False;
        Pointer.Style:=psNothing;
        if xh>0 then  begin
           AddXY((DataTimeAndFootAge.EndTime+DataTimeAndFootAge.StartTime)/2,1,Value);
        end else begin
           if UnitType.UnitType=1 then   begin
             AddXY((DataTimeAndFootAge.EndTime+DataTimeAndFootAge.StartTime)/2,5,Value);
           end else begin
             AddXY((DataTimeAndFootAge.EndTime+DataTimeAndFootAge.StartTime)/2,100,Value);
           end;


        end;
        CustomVertAxis:= MainChart.CustomAxes.Items[MainChart.CustomAxes.Count-1];
    end;
end;

procedure TDrawLineGraph.ClearChartSeries;
begin
     while MainChart.SeriesCount>0 do MainChart[0].Free;
     while MainChart.CustomAxes.Count>0  do
           MainChart.CustomAxes.Items[0].Free ;


end;

procedure TDrawLineGraph.ClearSupportArray;
var
  i:integer;
begin
//    for I := 0 to FSupportNumber-1 do
//      if Assigned(FSupportArray[i].LineSeries) then
//         FreeAndNil(FSupportArray[i].LineSeries);
    FSupportNumber:=0;
    setlength(FSupportArray,0);
end;

constructor TDrawLineGraph.Create;
begin
     NextDataDisp:=0;
end;

function TDrawLineGraph.CreatLineSeries(Support:Integer):TLineSeries;
var
  LineSeries:TLineSeries ;
begin
   Result:=nil;
   try
       LineSeries:=TLineSeries.Create(MainChart) ;
       LineSeries.ParentChart:= MainChart;
       LineSeries.XValues.DateTime :=true;
       LineSeries.ValueFormat:='YYYY-MM-DD HH:NN:SS' ;
       LineSeries.Pen.Width :=LineGraph.Line_Width;
     //  LineSeries.HorizAxis :=aBothHorizAxis;
       LineSeries.Title :='第['+IntToStr(Support)+']号';
      // LineSeries.Add('第['+IntToStr(Support)+']号支架曲线图')  ;
       //加载本次液压支架的数据
       FillSupportRockPress(LineSeries,Support) ;
//
       // 测试数据
//        LineSeries.FillSampleValues(100);
        Result:=LineSeries;
   finally

   end;
end;

procedure TDrawLineGraph.DataArrayAdd(tm: TFirstData);
begin
   inc(FArrayDataCount);
   Setlength(FDataItems,FArrayDataCount);
   FDataItems[FArrayDataCount-1]:= tm;
end;

procedure TDrawLineGraph.DataArrayClear;
begin
    FArrayDataCount:=0;;
    Setlength(FDataItems,FArrayDataCount);
end;

destructor TDrawLineGraph.Destroy;
begin
   ClearChartSeries;
   ClearSupportArray ;
end;

function TDrawLineGraph.FillCycleAndStepInfo(Chart:TChart; Asix:TChartAxis;
                   Rec: TSupportRecord): String;
var
  i,SupporBh,Sup_ivN:Integer;
  Data:Double;
  S_Out:String;
begin
    S_Out:='';
    Result:='';
    if not DrawClass.GraphClass.CycleDataEfficient then exit;
    Sup_ivN:=DrawClass.FGzm.RockPressAnalysis.ManulInput_Interval_support;
    SupporBh:=Rec.SupportBh div Sup_ivN   * Sup_ivN;


    if DrawClass.GraphClass.Disp_DataType[0] then begin
       FillCycleAndStep_Chart(Chart,Asix,ClBlue, 'CycleAGV',SupporBh,2 );
       S_Out:=S_Out+'循环均值线[蓝色 点线....],'
    end;

    if DrawClass.GraphClass.Disp_DataType[2] then  begin
       FillCycleAndStep_Chart(Chart,Asix,clAqua, 'CCL',SupporBh,4 );
       S_Out:=S_Out+'循环初撑力线[浅绿 虚点--.-],'
    end;

    if DrawClass.GraphClass.Disp_DataType[2] then  begin
       FillCycleAndStep_Chart(Chart,Asix,ClGreen, 'MZL',SupporBh,1 );
       S_Out:=S_Out+'循环末阻力线[绿色 虚线——.——],'
    end;
    Result:=S_Out;

end;

function TDrawLineGraph.FillCycleAndStep_Chart(Chart: TChart; Asix: TChartAxis;
  Color1: TColor; DataType:string;SupportBh,Linestyle:integer): Boolean;

var
  i:integer;
  Data:Double;

begin
    Result:=False;

    if DrawClass.DataTimeAndFootAge.Graph_MaxDao >  DrawClass.FilledContourDataNumber then  exit;

    Chart.AddSeries(TLineSeries);
    Chart[Chart.SeriesCount-1].Color :=Color1;
    Chart[Chart.SeriesCount-1].Pen.width:=LineGraph.Line_Width;
    Chart[Chart.SeriesCount-1].Pen.Style :=TPenStyle(Linestyle);

    for I := DrawClass.DataTimeAndFootAge.Graph_MinDao  to DrawClass.DataTimeAndFootAge.Graph_MaxDao do  begin
       if DataType='CycleAGV' then  begin
          DAta:=DrawClass.MyContourDoubleGrid[i][Supportbh].AGV_Value;
       end else if DataType='CCL' then  begin
          DAta:=DrawClass.MyContourDoubleGrid[i][Supportbh].CCL_Value;
       end else if DataType='MZL' then  begin
          DAta:=DrawClass.MyContourDoubleGrid[i][Supportbh].MZL_Value;
       end;

       if DAta < UseGzm.Usedsupport.initLoad then  continue;
       if (DrawClass.MyContourDoubleGrid[i][Supportbh].generatetime  > 40000) and (DAta >0 ) then
           Chart[Chart.SeriesCount-1].AddXY(DrawClass.MyContourDoubleGrid[i][Supportbh].generatetime,
                                     Data *UnitType.UnitValue);

    end;
    Chart[Chart.SeriesCount-1].CustomVertAxis:=Asix;
    Chart[Chart.SeriesCount-1].Legend.Visible:=False;
     Result:=true;
end;

function TDrawLineGraph.FillCycleWholeAGVLine(Chart: TChart; Asix: TChartAxis;
  Color1: TColor; SupportBh: integer): Boolean;
var
  i,AGVCount:integer;
  AGV_Data:Double;

begin
   Result:=False;


    if DrawClass.DataTimeAndFootAge.Graph_MaxDao >  DrawClass.FilledContourDataNumber then  exit;

    Chart.AddSeries(TLineSeries);
    Chart[Chart.SeriesCount-1].Color :=Color1;
    Chart[Chart.SeriesCount-1].Pen.width:=LineGraph.Line_Width;
    Chart[Chart.SeriesCount-1].Pen.Style :=TPenStyle(1);

    AGVCount:=0;AGV_Data:=0;
    for I := DrawClass.DataTimeAndFootAge.Graph_MinDao  to DrawClass.DataTimeAndFootAge.Graph_MaxDao do  begin
         if AGV_Data+DrawClass.MyContourDoubleGrid[i][Supportbh].AGV_Value < UseGzm.Usedsupport.initLoad then
                   continue;
         inc(AGVCount);
         AGV_Data:=AGV_Data+DrawClass.MyContourDoubleGrid[i][Supportbh].AGV_Value;

    end;

    if (AGVCount >0) and ( AGV_Data>0 ) then  begin
       AGV_Data:=AGV_Data/ AGVCount*UnitType.UnitValue;
       Chart[Chart.SeriesCount-1].AddXY(DrawClass.DataTimeAndFootAge.StartTime,
                                     AGV_Data);
       Chart[Chart.SeriesCount-1].AddXY(DrawClass.DataTimeAndFootAge.EndTime,
                                     AGV_Data);
    end;

    Chart[Chart.SeriesCount-1].CustomVertAxis:=Asix;
    Chart[Chart.SeriesCount-1].Legend.Visible:=False;
    Result:=True;
end;

function TDrawLineGraph.FillSupportRockPress(LineSeries: TLineSeries;
  SupportBh: Integer): Boolean;
var
  Lins:TStringList;
  arquivo: TextFile;
  I,C1:integer;
  s_Ln:String;

  Lin_s:Str_DT_array;
  fileName,textString:Ansistring;
  DirName:Ansistring;
  Dll_Path:AnsiString;
  tmp_Data:TdateTime;
begin


   if UseGzm.Gzmbh  <0 then exit;
   if SupportBh<0 then   exit;

   Dll_Path:=Public_Basic.Get_MyModulePath;
   DirName:=DLL_path+'\InputData\WorkDace_'+IntTostr(UseGzm.Gzmbh)+'\';

   fileName:=IntToStr(SupportBh) +'.Out';
   fileName:=DirName+fileName;
   if not(FileExists(fileName)) then exit;

   Lins:=TStringList.Create ;
   AssignFile(arquivo,FileName);//frmAnalise.dialogAbrir.FileName);
   Reset(arquivo);
     while not Eof(arquivo) do  begin
      Readln(arquivo,s_Ln);
      Lins.Add(s_Ln);
    end;

    CloseFile(arquivo);

    for I := 0 to Lins.Count -1 do  begin
        if i mod 100 =0 then
          DrawClass.StepProcegressBar(FirstPB,SecondPB,0,10);

        Lin_s:=Public_Basic.split(Lins[i],',',C1);
        if C1>1 then  begin
          tmp_Data:= StrToDateTime( Lin_s[0],Public_Basic.FSetting );
          if tmp_Data < self.DataTimeAndFootAge.StartTime then  continue;
          if tmp_Data > self.DataTimeAndFootAge.EndTime then  continue;

          if Public_Basic.StrToDouble_Lu(Lin_s[2])< 0 then   begin
             LineSeries.AddXY( tmp_Data,-1);
          end else begin
             LineSeries.AddXY( tmp_Data,Public_Basic.StrToDouble_Lu(Lin_s[1])*UnitType.UnitValue );
          end;
        end;
    end;


end;

function TDrawLineGraph.GetChart: Tchart;
begin
   Result:=FChart;
end;

function TDrawLineGraph.GetClourClass: TCloudClass;
begin
   Result:=FCloudClass;
end;

function TDrawLineGraph.GetDrawClass: TDrawGrap;
begin
    Result:=FUseDrawClass ;
end;

function TDrawLineGraph.GetDTF: TDataTimeAndFootAge;
begin
   Result:=FDataTimeAndFootAge;
end;


function TDrawLineGraph.GetGzm: TGzm;
begin
   Result:=FinGzm;
end;



function TDrawLineGraph.GetLineClass: TGraphDataClass;
begin
  Result:=FLineClass;
end;





function TDrawLineGraph.GetMarkerStep: Boolean;
begin
     Result:=FMakerStep;
end;

function TDrawLineGraph.GetNextDateDisp: integer;
begin
     Result:=FNextDataDisp;
end;

function TDrawLineGraph.GetSupportMAXNumber: integer;
begin
    Result:=FSupportMaxNumber;
end;


function TDrawLineGraph.GetUnitType: TColorValue;
begin
    Result:=FUnitType;
end;

procedure TDrawLineGraph.InitClass(iChart:TChart;
                           iSB:TScrollBar;
                           iDrawClass:TDrawGrap;
                           iFPB,iSPB:TProgressBar
                           );
begin
     MainChart:=iChart;
     DrawClass:=iDrawClass;
     FScrollBar:=iSB;
     DataTimeAndFootAge:=iDrawClass.DataTimeAndFootAge;
     CloudClass:=iDrawClass.CloudClass;
     UseGzm:=iDrawClass.FGzm;
     LineGraph:=iDrawClass.GraphClass;
     FirStPB:=iFPB;
     SecondPB:=iSPB;
     //剖切字符串
     DrawClass.StepProcegressBar(FirStPB,SecondPB,10,0);
     SplitSupportList(LineGraph.SupportList);
     // 定制纵轴数量
     if LineGraph.YAxisType=0 then begin
        FVertAxis:=1;
     end else if LineGraph.YAxisType=1 then begin
        FVertAxis:=4;
     end else if LineGraph.YAxisType=2 then begin
        FVertAxis:=2;
     end else if LineGraph.YAxisType=3 then begin
        FVertAxis:=3;
     end else if LineGraph.YAxisType=4 then begin
        FVertAxis:=4;
     end else if LineGraph.YAxisType=5 then begin
        FVertAxis:=6;
     end;

     if (FSupportNumber<2 ) then begin
         FVertAxis:=1;
     end else  if (FSupportNumber<3 ) then begin
         FVertAxis:=2;
     end else  if (FSupportNumber<4 ) then begin
         FVertAxis:=3;
     end else  if (FSupportNumber<6 ) then begin
         FVertAxis:=4;
     end;


     DrawClass.StepProcegressBar(FirStPB,SecondPB,10,0);
     //定义chart标题
     MakeLineGraphChartTitle(MainChart);
     DrawClass.StepProcegressBar(FirStPB,SecondPB,10,0);
     MakeVertAxis(FVertAxis);


end;

function TDrawLineGraph.isExsitRockPressFile(SupportBh: Integer): Boolean;
var
  fileName,textString:Ansistring;
  DirName:Ansistring;
  Dll_Path:AnsiString;
  tmp_Data:TdateTime;
begin
   Result:=False;
     if UseGzm.Gzmbh  <0 then exit;
     if SupportBh<0 then   exit;

     Dll_Path:=Public_Basic.Get_MyModulePath;
     DirName:=DLL_path+'\InputData\WorkDace_'+IntTostr(UseGzm.Gzmbh)+'\';

     fileName:=IntToStr(SupportBh) +'.Out';
     fileName:=DirName+fileName;
     if not(FileExists(fileName)) then exit;
   Result:=True;
end;

procedure TDrawLineGraph.MakeLineGraphChartTitle(Chart: Tchart);
var
 Caption:String;
 lowTime,highTime,InterValTime:integer;
 i:integer;
begin

    Chart.Title.Font.Color :=ClBlack;
    Caption:= MainDataModule.Coal_Name+'煤矿【'+MainDataModule.WorkFace_Name +'工作面】实时矿压曲线图' ;

    Chart.MarginLeft :=80;
    Chart.Title.TextAlignment:=taCenter;
    Chart.Title.Font.Name :='黑体';
    Chart.Title.Font.Size :=14;
    Chart.Title.Caption := Caption;

    Chart.SubTitle.Font.Color :=ClBlack;
    Chart.SubTitle.TextAlignment:=taCenter;
    Chart.SubTitle.Font.Name :='宋体';
    Chart.SubTitle.Font.Size :=9;

    Caption:='起止日期:'+FormatDateTime('yyyy-mm-dd hh:nn ',DataTimeAndFootAge.StartTime)
                            +'('+FormatFloat('0.00',DataTimeAndFootAge.Minfootage)+  '米)--' +
                             FormatDateTime('yyyy-mm-dd hh:nn ',DataTimeAndFootAge.EndTime) +
                             '('+FormatFloat('0.00',DataTimeAndFootAge.MAXfootage)+  '米)';

    Chart.SubTitle.Caption := Caption;
    Chart.SubTitle.Font.Color :=ClBlack;

    Chart.BottomAxis.Visible :=true;
    Chart.BottomAxis.DateTimeFormat:='YYYY-MM-DD HH:NN:SS' ;
    Chart.TopAxis.Visible :=true;
    Chart.TopAxis.DateTimeFormat:='YYYY-MM-DD HH:NN:SS' ;
    Chart.BottomAxis.SubAxes.Items[0].Visible :=true;
    Chart.BottomAxis.SubAxes.Items[0].DateTimeFormat:='YYYY-MM-DD HH:NN:SS' ;
  
    //控制坐标横轴的显示方式
    if CloudClass.X_Axis_Disp_Type =0 then  begin
       Chart.BottomAxis.Automatic :=true;
       Chart.BottomAxis.SubAxes.Items[0].Automatic :=true;
       Chart.TopAxis.Automatic:=true;
       Chart.Zoom.MouseButton:=mbLeft;
       Chart.AllowPanning:=pmNone;
    end else begin
       SetChartAxisMaxAndMinValue(Chart.BottomAxis,
                                 UseGzm.ReturnDataTimeFromDao(DataTimeAndFootAge.Graph_MinDao+CloudClass.X_Axis_Disp_Dao),
                                 UseGzm.ReturnDataTimeFromDao(DataTimeAndFootAge.Graph_MinDao)
                                  );


       SetChartAxisMaxAndMinValue( Chart.TopAxis,
                                 UseGzm.ReturnDataTimeFromDao(DataTimeAndFootAge.Graph_MinDao+CloudClass.X_Axis_Disp_Dao),
                                 UseGzm.ReturnDataTimeFromDao(DataTimeAndFootAge.Graph_MinDao)
                                  );


       SetChartAxisMaxAndMinValue(Chart.BottomAxis.SubAxes.Items[0],
                                 UseGzm.ReturnDataTimeFromDao(DataTimeAndFootAge.Graph_MinDao+CloudClass.X_Axis_Disp_Dao),
                                 UseGzm.ReturnDataTimeFromDao(DataTimeAndFootAge.Graph_MinDao)
                                  );
        Chart.BottomAxis  .Automatic :=false;

        Chart.ScrollMouseButton:=mbleft;
        Chart.AllowPanning:=pmHorizontal;

    end;

    Chart.BottomAxis.Title.Caption :='累计进刀';
    Chart.BottomAxis.Title.Position  :=tpStart ;

    if  DrawClass.ConTourSeriesPar.Display_DownFootage=1 then  begin
      Chart.BottomAxis.SubAxes.Items[0].Title.Caption:='累计进尺';
    end else begin
      Chart.BottomAxis.SubAxes.Items[0].Title.Caption:='开采时间';
    end;

    Chart.BottomAxis.SubAxes.Items[0].Title.Position:=tpEnd;


    Chart.TopAxis.Visible :=true;
    if DrawClass.ConTourSeriesPar.Display_UpperFootage=1 then  begin
      Chart.TopAxis.Title.Caption:='累计进尺';
    end else begin
      Chart.TopAxis.Title.Caption:='开采时间';
    end;

    if UnitType.UnitType=1 then begin
        Chart.LeftAxis.Title.Caption :='立柱压强MPa' ;
    end  else  if UnitType.UnitType =2 then begin
        Chart.LeftAxis.Title.Caption :='立柱压强Bar';
    end  else  if UnitType.UnitType =3 then begin
        Chart.LeftAxis.Title.Caption :='整架阻力KN';
    end;

    Chart.LeftAxis.Title.Position  :=tpCenter ;
   


end;

function TDrawLineGraph.MakerStepInfo(Chart: TChart; Asix: TChartAxis;
  var REC:TSupportRecord): integer;
var
   i:integer;
begin
   REC.PointSeries:=MainChart.AddSeries(TPointSeries) as TPointSeries;
    with REC.PointSeries do begin
        Marks.Visible:=true;
        Marks.Font.Size:=8;
        Marks.Color :=ClYellow;
        legend.Visible :=False;
        Pointer.Style:=psArrow;
        Pointer.Size:=15;
        CustomVertAxis:= Rec.LineSeries.CustomVertAxis;
        DrawClass.Auto_Judge_OldStep.ReturnOldStepForLineGrap(Rec,
                          DrawClass.FGzm,
                          DrawClass.CloudClass.RecallMidDaoSaveStep,
                          DrawClass.CloudClass.PrintOutDaoStepInto,
                          DrawClass.DataTimeAndFootAge.Graph_MinDao,
                          DrawClass.DataTimeAndFootAge.Graph_MaxDao,
                          round(UnitType.UnitValue)
                           ) ;
    end;
end;

procedure TDrawLineGraph.MakeVertAxis(Number: integer);
var
  t,i,j,st,iNum:integer;
  Postio:double;
  iColor:Array [0..5] of TColor;
  iLineType:Array [0..5 ] of integer;
  LabelMark:String;
begin
    //
   iColor[0]:=ClBlack;
   iColor[1]:=ClBlue;
   iColor[2]:=clTeal;
   iColor[3]:=clPurple;
   iColor[4]:=clAqua;
   iColor[5]:=clLime;

   //
   iLineType[0]:=0;   iLineType[1]:=3;  iLineType[2]:=4;
   iLineType[3]:=1;   iLineType[4]:=2;  iLineType[5]:=4;

    //
    Postio:=100 / (Number+(Number)/4);
    iNum:=FSupportNumber div Number;
    if FSupportNumber mod Number >0 then  inc(iNum);
    MainChart.CustomAxes.Clear ;
    st:=0; t:=0;
    for i := Number-1 downto 0 do begin
        DrawClass.StepProcegressBar(FirStPB,SecondPB,0,10);
        MainChart.CustomAxes.Add;
        MainChart.CustomAxes.Items[MainChart.CustomAxes.Count-1].StartPosition := Trunc((5*i)/4 * Postio);
        MainChart.CustomAxes.Items[MainChart.CustomAxes.Count-1].EndPosition :=Trunc((5*i+4)/4 * Postio);
        MainChart.CustomAxes.Items[MainChart.CustomAxes.Count-1].Axis.Color:=iColor[5-i] ;
        MainChart.CustomAxes.Items[MainChart.CustomAxes.Count-1].LabelsFont.Color:=iColor[0]  ;
        MainChart.CustomAxes.Items[MainChart.CustomAxes.Count-1].Axis.width:=LineGraph.Line_Width+2;
        MainChart.CustomAxes.Items[MainChart.CustomAxes.Count-1].Title.Caption:=
                                 MainChart.LeftAxis.Title.Caption;
        MainChart.CustomAxes.Items[MainChart.CustomAxes.Count-1].Title.Position  :=tpCenter ;
        st:= iNum*t;
        LabelMark:='';
        for j := 0 to iNum-1 do   begin
            if j+st >=FSupportNumber then  break;
            FSupportArray[j+st].LineSeries.CustomVertAxis:= MainChart.CustomAxes.Items[MainChart.CustomAxes.Count-1];

            LabelMark:= LabelMark+ FSupportArray[j+st].legendName+'[';
            //线条颜色
            if (LineGraph.Line_Color =1) and (iNum>1) then  begin
                if iNum<=6 then begin
                  FSupportArray[j+st].LineSeries.Color :=iColor[j];
                  LabelMark:= LabelMark+ReturnColorName(j);
                end;
            end else begin
                FSupportArray[j+st].LineSeries.Color:=ClBlack;
                LabelMark:= LabelMark+ReturnColorName(0);
            end;
            //线条线型
            LabelMark:= LabelMark+'  ';
            if (LineGraph.Line_Tpye =1) and (iNum>1) then  begin
               FSupportArray[j+st].LineSeries.Pen.Style :=TPenStyle(iLineType[j] mod 6);
               LabelMark:= LabelMark+ ReturnLineTypeName(iLineType[j] mod 6);
            end else begin
               FSupportArray[j+st].LineSeries.Pen.Style :=TPenStyle(0);
               LabelMark:= LabelMark+ ReturnLineTypeName(0);
            end;
            LabelMark:= LabelMark+  '],';
            // 标注 来压标记
             if (DrawClass.CloudClass.RockPressAnslysis) and (MarkerStep) and (Number >=4)  then   begin
                MakerStepInfo(MainChart,
                              MainChart.CustomAxes.Items[MainChart.CustomAxes.Count-1],
                              FSupportArray[j+st]
                              );
             end else if MarkerStep then begin
                 MarkerStep:=False;
             end;

        end;
        DrawClass.StepProcegressBar(FirStPB,SecondPB,0,10);
        // 添加 初撑力与 液压阀开启资格线
        AddShupingLine(MainChart,MainChart.CustomAxes.Items[MainChart.CustomAxes.Count-1],1);
        AddShupingLine(MainChart,MainChart.CustomAxes.Items[MainChart.CustomAxes.Count-1],2);
       // 添加曲线均值曲线
       if DrawClass.GraphClass.YAxisType=1 then begin  //表示 是每个支架一条曲线，可以追加其他曲线数据
          LabelMark:= LabelMark+ FillCycleAndStepInfo(MainChart,
                      MainChart.CustomAxes.Items[MainChart.CustomAxes.Count-1], FSupportArray[st]);
       end;

       if length(LabelMark)>1 then begin
            LabelMark:=copy(LabelMark,0,length(LabelMark)-1);
             //添加标注
            AddSupportMarkLabel(trunc(Postio),i,0,LabelMark);
       end;
       //添加标注
       if i = Number-1 then  begin
          LabelMark:='[绿色 实线 加黑 初撑力水平线], [红色 实线 加黑 液压阀开启线]';
          AddSupportMarkLabel(trunc(Postio),i,1,LabelMark);
       end;


        inc(t);
    end;

      MainChart.Axes.Bottom.LabelStyle:=talValue;
      MainChart.Axes.Top.LabelStyle:= talValue;
      MainChart.Axes.Bottom.SubAxes.Items[0].LabelStyle:= talValue;
      
end;

function TDrawLineGraph.ReturnColorName(Value:integer): String;
var
 str:string;
begin
    {
      iColor[0]:=ClBlack;
     iColor[1]:=ClBlue;
     iColor[2]:=clTeal;
     iColor[3]:=clPurple;
     iColor[4]:=clAqua;
     iColor[5]:=clLime;
    }
    if Value=0 then  begin
       str:='黑色';
    end else if Value=1 then  begin
       str:='蓝色';
    end else if Value=2 then  begin
       str:='青色';
    end else if Value=3 then  begin
       str:='蓝绿';
    end else if Value=4 then  begin
       str:='浅绿';
    end;
    Result:=Str;
end;

function TDrawLineGraph.ReturnLineTypeName(Value:integer): String;
var
 str:string;
begin
    {
     iLineType[0]:=0;   iLineType[1]:=3;  iLineType[2]:=4;
     iLineType[3]:=1;   iLineType[4]:=2;  iLineType[5]:=4;
    }
    if Value=0 then  begin
       str:='实线————';
    end else if Value=1 then  begin
       str:='虚线——.——';
    end else if Value=2 then  begin
       str:='点线....';
    end else if Value=3 then  begin
       str:='虚点--.-';
    end else if Value=4 then  begin
       str:='虚点--.--';
    end;
    Result:=Str;
end;

function TDrawLineGraph.ReturnMarkLabel(Mem1: TMemo; Supportbh,
  id,qd: integer): Boolean;
  {

    QD := 10 9  8 代表 modifydata = 10 9 8
         分别代表 QL_oldsteps,YB_oldsteps,JB_oldsteps 三个数组

    id 代表这个 数组中的位置
  }
var
  i:integer;
  tmpStep:TArrayOLdOneStep;
  Disp:Boolean;
  UN:String;
begin
    Result:=False;
    Disp:=False;
    Mem1.Clear ;
    if UnitType.UnitType=1 then begin
        UN:='MPa' ;
    end  else   if UnitType.UnitType=2 then begin
        UN:='Bar' ;
    end else begin
        UN:='KN';
    end;

    for I := 0 to High(FSupportArray) do begin
       if  (FSupportArray[i].SupportBh= Supportbh  ) and (Qd=10 ) then begin
          if  ( FSupportArray[i].QL_oldStepCount < id) then exit;
            tmpStep:= FSupportArray[i].QL_oldsteps;
            Disp:=true;
            break;
       end;

       if  (FSupportArray[i].SupportBh= Supportbh  ) and (Qd=9 ) then begin
          if  ( FSupportArray[i].YB_oldStepCount < id) then exit;
            tmpStep:= FSupportArray[i].YB_oldsteps;
            Disp:=true;
            break;
       end;

        if  (FSupportArray[i].SupportBh= Supportbh  ) and (Qd=8 ) then begin
          if  ( FSupportArray[i].JB_oldStepCount < id) then exit;
            tmpStep:= FSupportArray[i].JB_oldsteps;
            Disp:=true;
            break;
       end;
    end;

    if Disp then begin
         Mem1.Lines.Add('本次来压信息如下：');
         if tmpStep[id-1].OneStepInfo.ModifyData =10 then  begin
           Mem1.Lines.Add('来压性质：矿压显现显著区域');
         end else if   tmpStep[id-1].OneStepInfo.ModifyData =9 then  begin
           Mem1.Lines.Add('来压性质：矿压显现明显区域');
         end else if  tmpStep[id-1].OneStepInfo.ModifyData =8 then  begin
           Mem1.Lines.Add('来压性质：局部矿压异常区域');
         end;
         Mem1.Lines.Add('液压支架编号【'+IntTostr(Supportbh)+'】号支架');
         Mem1.Lines.Add('进刀 开始 于【'+IntTostr(tmpStep[id-1].OneStepInfo.Start_MinDao   )+'】刀');
         Mem1.Lines.Add('进刀 结束 于【'+IntTostr(tmpStep[id-1].OneStepInfo.Step_end_MAXDao   )+'】刀');

         Mem1.Lines.Add('来压最大压力【'+FormatFloat('0.00',tmpStep[id-1].OneStepInfo.MaxData *UnitType.UnitValue  )+'】'+UN);
         Mem1.Lines.Add('期间  平均值【'+FormatFloat('0.00',tmpStep[id-1].OneStepInfo.AGVDAta *UnitType.UnitValue   )+'】'+UN);
         Mem1.Lines.Add('压力强度系数【'+FormatFloat('0.00',tmpStep[id-1].OneStepInfo.AGVDataQD   )+'】均值为1');
         Mem1.Lines.Add('面积强度系数【'+FormatFloat('0.00',tmpStep[id-1].OneStepInfo.AreaQD   )+'】均值为1');
         Mem1.Lines.Add('//======================');
         Mem1.Lines.Add('本次来压判断压力线【'+FormatFloat('0.00',tmpStep[id-1].OneStepInfo.JudgeLevelLineData *UnitType.UnitValue )+'】'+UN);

           if tmpStep[id-1].OneStepInfo.Step_move_MinFootage >0 then begin
               Mem1.Lines.Add('来压步距下限【'+FormatFloat('0.0',tmpStep[id-1].OneStepInfo.Step_move_MinFootage)+ '】米');
               Mem1.Lines.Add('来压步距上限【'+FormatFloat('0.0',tmpStep[id-1].OneStepInfo.Step_move_MaxFootage)+ '】米');

           end;
           if  tmpStep[id-1].OneStepInfo.Step_Obvious_Footage[1] >0 then begin
               Mem1.Lines.Add('显著步距下限【'+FormatFloat('0.0',tmpStep[id-1].OneStepInfo.Step_Obvious_Footage[1])+ '】米');
               Mem1.Lines.Add('显著步距上限【'+FormatFloat('0.0',tmpStep[id-1].OneStepInfo.Step_Obvious_Footage[0])+ '】米');

           end;

          if tmpStep[id-1].OneStepInfo.Step_Continue_Footage >0  then  begin
              Mem1.Lines.Add('平稳推进距离【'+FormatFloat('0.0',tmpStep[id-1].OneStepInfo.Step_Continue_Footage)+ '】米');
          end;
              Mem1.Lines.Add('压力较大支架【'+tmpStep[id-1].OneStepInfo.SupportString+ '】') ;



    end;
    Result:=true;
end;

procedure TDrawLineGraph.SetChart(Value: Tchart);
begin
    FChart:=Value;
end;

procedure TDrawLineGraph.SetChartAxisMaxAndMinValue(BottomAxis: TChartAxis;
  MaxV, MinV: double);
begin
    BottomAxis.Automatic :=False;
    BottomAxis.Minimum :=0;
    if MaxV <10 then    BottomAxis.Maximum:=10
         else   BottomAxis.Maximum := MaxV;
    if MinV< MaxV then  begin
       BottomAxis.Minimum :=MinV;
    end;
end;

procedure TDrawLineGraph.SetClourClass(Value: TCloudClass);
begin
    FCloudClass:=VAlue;
end;

procedure TDrawLineGraph.setDRawClass(Value: TDrawGrap);
begin
   FUseDrawClass:=Value;
end;

procedure TDrawLineGraph.SetDTF(Value: TDataTimeAndFootAge);
begin
   FDataTimeAndFootAge:=Value;
end;


procedure TDrawLineGraph.SetGZM(Value: TGzm);
begin
   FinGzm:=Value;
end;



procedure TDrawLineGraph.SetLineClass(Value: TGraphDataClass);
begin
    FLineClass:=Value
end;




procedure TDrawLineGraph.SetMarkerStep(Value: Boolean);
begin
    FMakerStep:=Value;
end;

procedure TDrawLineGraph.SetNextDataDisp(Value: integer);
begin
    FNextDataDisp:=Value;
end;

procedure TDrawLineGraph.SetSupportMAXNumber(Value: integer);
begin
    FSupportMaxNumber:=Value;
end;

procedure TDrawLineGraph.SetUnitType(Value: TColorValue);
begin
   FUnitType:=Value;
end;

procedure TDrawLineGraph.SplitSupportList(Value: string);
var
   Rec: TSupportRecord;
   s1,s2:Str_DT_array;
   C1,ContuN,i:integer;
   PiC,st,ed:integer;
begin
  ClearChartSeries;
  ClearSupportArray ;

   DrawClass.StepProcegressBar(FirstPB,SecondPB,10,0);
   if Length(Value)>0 then  begin
       S1:=public_Basic.split(Value,';',C1);
       SupportMaxCount:=C1;
       ContuN:=0;
       if self.LineGraph.YAxisType=1 then  begin  // 每一个数据坐标轴
             FVertAxis:=4;
             Pic:=SupportMaxCount div FVertAxis;
             if SupportMaxCount mod FVertAxis >0 then  inc(Pic);
             if NextDataDisp>=Pic then  NextDataDisp:=0;

             ed:=(NextDataDisp+1) *FVertAxis;
             if ed>High(S1) then  begin
                st:=High(S1)-FVertAxis;
             end else begin
                st:=NextDataDisp *FVertAxis;
             end;

             if st<0 then  st:=0;

            for I := st to ed do  begin
               DrawClass.StepProcegressBar(FirstPB,SecondPB,0,10);

               if SplitSupportList_Child(S1[i]) then begin
                  inc(ContuN);
               end else begin
                  SupportMaxCount:=SupportMaxCount-1;
               end;

               if ContuN>=FVertAxis then  break;

            end;
             MainChart.Legend.Inverted :=true;
//          end;
       end else begin
           for I := 0 to High(S1) do  begin
             DrawClass.StepProcegressBar(FirstPB,SecondPB,0,10);
             if SplitSupportList_Child(S1[i]) then begin
                inc(ContuN);
             end else begin
                SupportMaxCount:=SupportMaxCount-1;
             end;
           end;
           MainChart.Legend.Inverted :=true;
       end;
   end;

end;

function TDrawLineGraph.SplitSupportList_Child(Value: string):Boolean;
var
   Rec: TSupportRecord;
   s2:Str_DT_array;
   C2,i:integer;
begin
  Result:=False;
  S2:=public_Basic.split(Value,',',C2);
  if C2>1 then
     if (Public_Basic.StrToInt_lu(S2[1])>=0 )  then begin
         Rec.SupportBh:= Public_Basic.StrToInt_lu(S2[1]);
         Rec.legendName:='第['+S2[1]+']号';
         // 查看数据文件是否存在
         if not isExsitRockPressFile(Rec.SupportBh) then begin
            SupportMaxCount:=SupportMaxCount-1;
            exit;
         end;

         // 创建数据文件
         Rec.LineSeries:=CreatLineSeries(Rec.SupportBh) ;
         Rec.MaxTime:= DrawClass.DataTimeAndFootAge.EndTime;
         Rec.MinTime:= DrawClass.DataTimeAndFootAge.StartTime;
         AddNextSupport(Rec);
         Result:=True;
     end;



end;

end.

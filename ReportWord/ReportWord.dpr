program ReportWord;

uses
  Vcl.Forms,
  Winapi.Windows,
  MainReport in 'MainReport.pas' {MainFrom},
  UICallPstope in '..\UsedForm\UICallPstope.pas',
  UIGuideMapDll in '..\UsedForm\UIGuideMapDll.pas',
  UIPStopeGuidUnit in '..\UsedForm\UIPStopeGuidUnit.pas',
  uIRockPress in '..\UsedForm\uIRockPress.pas',
  UIWinFrame in '..\UsedForm\UIWinFrame.pas',
  Lu_Public_BasicModual in '..\PublicSysForm\Lu_Public_BasicModual.pas',
  unWord_Lu in '..\PublicSysForm\unWord_Lu.pas',
  PStope_GzmGuidClass in '..\PublicSysForm\PStope_GzmGuidClass.pas',
  uDrawGraphClass in '..\PublicSysForm\uDrawGraphClass.pas',
  UMakeRuleClass in 'uForm\UMakeRuleClass.pas',
  RockPressBasicClass in '..\PublicSysForm\RockPressBasicClass.pas',
  mysql in '..\PublicSysForm\mysql.pas',
  SQLite3 in '..\PublicSysForm\SQLite3.pas',
  sqlite3udf in '..\PublicSysForm\sqlite3udf.pas',
  SQLiteTable3 in '..\PublicSysForm\SQLiteTable3.pas',
  StopWatch in '..\PublicSysForm\StopWatch.pas',
  uLuDataAdo in '..\PublicSysForm\uLuDataAdo.pas',
  uLuSqliteDealWith in '..\PublicSysForm\uLuSqliteDealWith.pas',
  UMainDataModule in '..\PublicSysForm\UMainDataModule.pas' {DataModule1},
  UFormWait in '..\PublicSysForm\UFormWait.pas' {FormWait},
  RockPresstool in '..\RockPressDll\UForm\RockPresstool.pas' {FormPressTool},
  UForm_Brand_Bar in '..\RockPressDll\UForm\UForm_Brand_Bar.pas' {Form_Band_Bar},
  UForm_ContourGraph in '..\RockPressDll\UForm\UForm_ContourGraph.pas' {Form_ContourGraph},
  UForm_LineGraph in '..\RockPressDll\UForm\UForm_LineGraph.pas' {Form_LineGraph},
  MakeDataRule in '..\RockPressDll\UForm\MakeDataRule.pas' {Form_MakeRule},
  UForm_MoveSupportGraph in '..\RockPressDll\UForm\UForm_MoveSupportGraph.pas' {UForm_MoveSupport},
  UForm_phaseGraph_Tongji in '..\RockPressDll\UForm\UForm_phaseGraph_Tongji.pas' {Form_TongJIGraph},
  UForm_ThreeDimGraph in '..\RockPressDll\UForm\UForm_ThreeDimGraph.pas' {Form_ThreeGraph},
  UForm_StepResult in '..\RockPressDll\UForm\UForm_StepResult.pas' {Form_StepResult},
  uMainFun in '..\RockPressDll\UClass\uMainFun.pas',
  uDisPoseData in '..\RockPressDll\UClass\uDisPoseData.pas',
  uDrarLineGraph in '..\RockPressDll\UClass\uDrarLineGraph.pas',
  UGraphLineClass in '..\RockPressDll\UClass\UGraphLineClass.pas',
  RockPressReport in '..\PublicSysForm\RockPressReport.pas';

{$R *.res}
   const mypro='TMainFrom';//主窗体类
   var handle:integer;
begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;

  handle:=findwindow(mypro,nil);
  if handle<>0 then
   begin
      messagebox(0,'程序正在运行,请退出!','警告!',0);
      halt;
   end;

  Application.CreateForm(TMainFrom, MainFrom);
  MainFrom.ExMinJinDao:=ParamStr(1);

  Application.Run;
end.

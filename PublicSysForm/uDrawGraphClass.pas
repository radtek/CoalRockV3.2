unit uDrawGraphClass;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.ComCtrls, Vcl.StdCtrls, Vcl.Grids,
  VclTee.TeeGDIPlus, VCLTee.TeEngine, VCLTee.TeeProcs, VCLTee.Chart,VCLTee.TeeSurfa,
  UMainDataModule,PStope_GzmGuidClass,Lu_Public_BasicModual,VCLTee.TeCanvas,VCLTee.Series,
  UMakeRuleClass
  ;

const PI=3.14159;

type
   TYuntuDataType =(RealTime,Cycle,DisPoseData,ManualInput);    // 云图实时数据与循环数据
   TRealTimeData  =(Max_RData,AVG_RData,Min_RData);    // 实时数据的类型
   TCycleData =(MAX_CData,AVG_CData,CCL_CData,MzL_CData,SameTime_CData,Manual_CData); // 循环数据的类型
   TDisPoseData =(ThirdDpAGV,ThirdDpMax,ThirdDpMzl);//处理后的数据
  // TDataType =(NullPressData,FrontPressData,BehindPressData,LeftPressData,RightPressData);
   TGraphDataType =(Phase,single); //曲线图的数据类型
   //

   type MYLine=^MYrecordLine;
     MYrecordLine=record
     originP,finalP:TPoint;
     lineColor:TColor;
     next:MYLine;
     end;
   TBarDispMark =record
      Disp_0:integer; //  是否显示无效数据  0不显示  不显示
      Disp_B_D:integer; // 显示比率还是数字 0 比率 1 数字
      Disp_Mark:Integer;//  是否显示 标注  0 不显示 1 显示
      Fromcontour:Boolean;// 是否从云图传过来数据
   end;
   // 下面是 云图
   TKrigePoint=record
      pt:TPoint;
      DataV:Double;
   end;
   TColorValue =record
     MinValue:double;
     AGVValue:double;
     MaxValue:double;
     UnitType:integer; // 1 是指 MPa, 2 代表 Bar 3 代表 是液压支架的整架 KN
     UnitValue:double;// 单位计算数值 1 或者 10
     MPaChangeKN_Xs:Double;//兆帕转换千牛的系数
     UntiName:String;// Bar 或者 MPa
     ColorDisply:Boolean;
   end;
   TSelectImageGrid=record
     StartSupbh,EndSupbh:integer;
     StartTime,EndTime:TdateTime;
   end;
   TContourColor =Record
     ContourColor:TColor;
     UpToValue:integer;
     xh:integer;
   End;
   TContourFootageData=record
     Daoshu:integer;
     Down_footage:double;
     Upper_Footage:double;
     DT:TdateTime;
   end;
   TContourRecord= record
     daoshu:integer;
     supportbh:integer;
     footage:double;
     generatetime:TDatetime;
     Max_Value:Double;
     AGV_Value:double;
     CCL_Value:Double;
     MZL_Value:Double;
     Same_Value:Double;
     Manual_Value:Double;

     UseData:double;
     ContoursideData:Double;// 区域划分后的数据
     SmoothData:Double;// 三维平衡后是的数据
     Krigvalue:Double;// 改进的 克里金插值
     DataType:Integer; // 1 代表是真实数据，0 代表插入的数值
     UnitName:integer;// 1 是MPA 2 是BAr

   end;
   TDoubleContourRecord =Array of array of TContourRecord;
   TArrayDouble =Array of Double;

   TDisposeGrid =record
     x:double;
     y:double;
     STime:TdateTime;
     MaxData,MzlData,AGVData,SameTimeData,ManualData:double;
     TwoDimPt:Array [0..3] of TPoint;
   end;

   TThirdDPThreePoint =record
     phaseNumber,MaxValueSupNumber:integer;
     StartTime,endTime:TdateTime;
     MaxData,MzlData,AGVData:double;
     StartFootage,EndFootage:double;
     startSup,endSup:integer;
     SupNumber:integer;
     Midsup:integer;
     SupportBh_list:String;
   end;
   TCyclePressData= record
     StartTime :TdateTime;
     EndTime:TdateTime;
     SupportBH:integer;
     Daoshu:integer;
     footage:double;
     UseValue:double;
     MaxValue,MinValue,AVGValue,StartValue,LastValue :double;
     MzlValue,SameTimeValue,ManualValue:double;
     ShowDateTime:TdateTime;
     TwoDimPt:Array [0..3] of TPoint;
     GridXy:TPoint;
   end;
   TDataTimeAndFootAge =record
        StartTime,EndTime:Tdatetime; //模拟开始时间 与结束时间
        UpperStartfootage,UpperEndFootage:double; //上顺槽开始 进尺与结束进尺
        DownStartFootage,DownEndFootage:double; // 下顺槽开始进尺与结束进尺
        MinFootage,MaxFootage:double;//最小进尺与最大进尺
        TimeInterval:double; // 画图时间间隔
        FootAgeInterVal:double;// 画图距离间隔
        StartSupportbh,EndSupportbh:integer;// 支架开始编号与结束编号
        TimeLength:double;//画图时间长度
        ForCaseDay:integer; // 预测预报未来的天数
        Graph_MinDao,Graph_MaxDao:integer;

   end;
   TCloudClass =record      //压力云图
       YunTu_DataClass:TYuntuDataType;   // 云图 的数据类型  实时数据与 循环数据
       Yuntu_RealData:TRealTimeData; // 云图实时数据的 最大值 平均值 最小值
       Yuntu_disposeData:TDisPoseData;// 第三次处理数据 最大值 平均值 末阻力
       Yuntu_CycleData:TCycleData;   //云图 循环数据  初撑力  末阻力 最大值 平均值
       Yuntu_DataType:TSupportDataType; // 抽取数据的名称 前柱压力 后柱压力 左柱压力  右柱压力  GzmClass
       YunTu_DataType_Name:string;  // 数据类型  主要是哪个柱的压力
       Yuntu_Data_Name:string;      // 保存数据的名称 什么值的问题
       X_Axis_Disp_Type:integer; // 0 为 自适应 显示  1 为 指定 显示进尺
       X_Axis_Disp_Dao:Integer; //横坐标显示刀数
       OldStepDisplay:Boolean; //云图中是否显示来压步距
       RockPressAnslysis:Boolean;// 是否进行了矿压深度分析
       DisPlayForcase:Boolean;//是否显示预测数据
       //-------
       DisPlayProMinDaoSaveStep:Boolean; //是否显示保存了的当前进刀之前的来压步距
       RecallMidDaoSaveStep:Boolean; // 对进刀选择之内的已经保存的数据是否重新进行分析
       SaveDataMaxDao,SaveDataMinDao:integer;//数据库中保存的最大,最小进刀有效进刀数
       SaveDate_Edit:Boolean;//对已存储的来压步距是否能编辑 1 编辑 0 不可编辑
       PrintOutDaoStepInto:Boolean;// 是否输出进刀范围之外的来压信息
       PrintDispPhaseVisual:Boolean;// 矿压数据分段显示方式
   end;
   TGraphDataClass =record
     Out_input_Data:Boolean;
     Graph_DataCalss:TGraphDataType  ;// 曲线图的数据类型  区间 与 单个支架
     DataName:String;  // 数据类型
     StartBh:integer;
     EndBh:integer;
     SupportList,Support_Select_List:String;
     YAxisType:Integer; // 0 一个坐标轴 1 多个坐标轴  2 两个坐标轴  3 三个坐标轴  4 四个个坐标轴    5 六个坐标轴
     Line_Tpye:integer;// 多条曲线是否 用不同线型表示  0 统一线型 1 不同线型
     Line_Color:integer; //多条曲线 是否 统一颜色显示  0 黑色  1 彩色 黑 蓝  黄  紫
     Line_Width:integer;// 曲线默认线宽
     Disp_DataType:Array [0..2] of Boolean;// 数据显示类型
     FisrtPageId,SecondPageid:integer;    // 显示页数
     ScrollPageSize:integer;// 滚动显示的天数
     CycleDataEfficient:Boolean;// 步距信息的有效性 ，临时记录
     // report
     ReportFirst:Boolean; // 第一章是否显示
     ReportSecond:Boolean;  // 第二章是否显示
   end;
  TTwoDimCloud=record
    ForCaseDay:integer; // 预测预报未来的天数
    BmpWidth,BmpHeigth:integer; //整个图片的宽与高
    LeftBlank,RightBlank,TopBlank,BottomBlank :integer; // 图片四周空白
    pic_width,pic_heigth:integer; //画图板的宽与高
    X_pix_start,X_pix_end,Y_pix_start,Y_pix_end: integer; //X Y方向画布的 开始与结束 数值
    Y_Bl,X_Bl:double;//Y 方向的比例        X 方向的比例
    X_interVal,Y_InterVal:integer; //X Y 方向 标注数据间隔
    titleSize,TextSize:integer;// 标题与正文的字号
  end;
  TThreeDimCloud =record
    ForCaseDay:integer; // 预测预报未来的天数
    BmpWidth,BmpHeigth:integer; //整个图片的宽与高
    LeftBlank,RightBlank,TopBlank,BottomBlank :integer; // 图片四周空白
    pic_width,pic_heigth:integer; //画图板的宽与高
    X_pix_start,X_pix_end,Y_pix_start,Y_pix_end: integer; //X Y方向画布的 开始与结束 数值
    Y_Bl,X_Bl:double;//Y 方向的比例        X 方向的比例
    X_interVal,Y_InterVal:integer; //X Y 方向 标注数据间隔
    titleSize,TextSize:integer;// 标题与正文的字号
    //===
    Three_O_x,three_O_y:Integer;// 三维原点位置
    three_x_len,Three_Y_len,Three_Z_len:integer; //三维 坐标轴使用长度
    T_X_bl,T_Y_bl,T_z_bl:double; //三维 坐标使用比例
    Angle:double;
    sin_a,cos_a:double;// 角度的正弦值与 余弦值
    Support_interval:integer;// 支架遍历间隔
    Time_InterVal:double;// 时间遍历间隔
  end;
   TStayRec = record
      Stay : boolean;
      Val  : integer;
   end;
   TContourDispParam= Record
     Display_UpperFootage:integer;  // 0 为时间 1为 进尺
     Display_DownFootage:Integer; // 0 为时间 1为 进尺
   End;
   TDoublePoint=record
     x:double;
     Y:double;
     PrvId:Integer;
     Nextid:integer;
     PointId:integer;
   end;
   TOutPoint =record
     Point:TPoint;
     PointId:integer;
   end;

   TEditMapSeriesRe =record     // 云图上能够编辑的点
      Apol:integer; //多边形序号
      Pointid:integer;//点的序号
      Point:TPoint;// 编辑点的信息
      tmpPoints:Array [0..7] of Tpoint;
      StepClassid:integer;// OldoneStep 数组编号
      DragPointid:integer;// 能够移动的点
   end;
   TOneSupportStep=record
     Supportbh:integer;   //
     Count:integer;   //
     startDao:integer;   //
     endDao:integer;    //
     AGVData:double;   //
     MinData:double;   //
     MaxData:Double;   //
     StepQd:Double;   //   来压强度
     MaxDataDao:integer;// 最大值的进刀数
     MinDataDao:integer;// 最小值的进刀数
     MaxDataTime:TdateTime;//最大值的时间
     
   
   end;
   TcomprehensiveOldStep =Record
     JudgeLevelLineData:Double;// 本次来压判断压力分界线
     ModifyData:integer; //数据性质 1 为实际推断数据未保存数据  2 保存数据 3 为预测数据
     StartSup,StartSup_id:integer; // 最大支架的编号及 对于的数组坐标
     EndSup,EndSup_id:integer;     // 最小支架的编号 及对应的坐标
     StartDao,StartDao_id:integer; // 最小进刀的编号及对应的坐标
     EndDao,EndDao_id:integer; //    最大进刀的编号及对应的坐标
     MaxData:Double;      //      最大值的压力值
     MaxData_id:integer; //       最大压力值对应的坐标
     MaxData_Sup,MaxData_Dao:integer;// 出现最大值的支架号与进刀数
     MinData:Double;     //  最小的压力值
     MinData_id:Double; //  最小压力值对应的坐标
     MinData_Sup,MinData_Dao:integer;// 出现最小值的支架号与进刀数
     AGVDAta:double;  //   压力数据的平均值
     AreaQD:Double; //   来压强度  其实是面积强度
     AGVDataQD:Double;// 数据均值强度
     WholeQD:Double;// 来压的整体强度  其实就是 wholeDQ= AreaQD * AGVDataQd
     NormalQd:double;// 常规的来压强度

     Count:integer; // 数据综合（所有支架所有刀数的和，相当于面积）
     Start_maxDao,Start_MinDao:integer;// 本次循环开始的最大刀数与最小刀数
     Start_AGVDao:integer; //本次循环开始的平均进刀
     End_MaxDao,End_MinDao:integer;//本次循环的结束的 最大进刀与最小进刀
     End_AGVDao:integer;//本次循环结束的平均进刀
     Start_MaxDao_id,Start_MinDao_id:integer;// 编号
     start_maxFootage:double;// 本次循环开始最大进尺 对应 最大进刀的进尺
     start_minFootage:Double;// 本次循环开始的中小进尺 对应 最小进刀的进尺
     Start_AGVFootage:double;//本次循环开始的平均进尺
     End_MinFootage,End_maxFootabe:double;//本次循环结束的 最大进尺与最小进尺
     End_AGVFootage:double;//本次循环结束的平均进尺
     SupportString:String;// 来压强度较大的支架编号

     Step_end_MAXDao:Integer;// 本次步距最大进刀 也就是下一次步距的开始进刀
     Step_end_MaxDao_id:integer;// 本次步距 最后开始来压支架号
     Step_end_MinDao:integer; //本次步距最小进刀 也就是下一次步距的开始进刀
     Step_end_MinDao_id:integer;// 本次步距 最先开始来压支架号
     Step_end_MaxFootage:double;// 最大进刀数对应的最大进尺数
     Step_end_MinFootage:double;  // 最小进刀数对应的 最小进尺数
     Step_end_AGVFootage:Double;//本次行走的平均距离
     Step_move_AGVDao:integer;//本次循环的进刀数
     Step_Move_MaxFootage:Double;//  本次来压的最大步距
     step_Move_MinFootage:Double;//  本次来压的最小步距
     Step_Move_AGV_Footage:Double;//  本次顶板运动的平均步距
     Step_Obvious_Footage:array [0..2] of Double; //  本次顶板运动的显著步距  max min AGV
     Step_Continue_Footage:Double;  //  步距持续进尺
     Step_Move_trend:double;//本次运动趋势  大于 1 增大 下一次的 强度与本次强度比
     NextStepCount:integer;//本次步距一下个步距的 数量
     NextStepClassID: array [0..9] of integer;     //  本次步距的一下次步距的内码序列
     ProStepCount:integer; //本次步距的谦虚步距 数量
     ProStepClassID: array [0..9] of Integer; // 本次 步距的前需步距的内码序列
     Step_NO:integer; //本次步距在 整个 步距序列中的 位置
     Step_MaxWide_Dao,Step_MaxWide_Dao_id:integer;  // 区域最宽处 刀数与编号
     Step_MinWide_Dao,Step_MinWide_Dao_id:integer;  // 区域最窄处 刀数与编号
     ExStepClassid:integer;// 外部类的编号
     FindNextStep:Boolean;// 是否发现后一步的来压步距
     PrintBool:Boolean;// 是否 打印了
   End;


   {每一个来压步距的数据类}
   TOldOneStep=class(TPersistent)
    private
//       phaseNumber:integer;
       startsup:double;
       endsup:double;
       startDao:double;
       endDao:double;
       StartFootage:double;
       endFootage:Double;
       FronStepid:integer;
       ContinueSupport,ContinueJinDao:integer;

    function ReturnPt(pt: TDoublePoint): TPoint;
    function ReturnPtFromOutPoint(pt: TOutPoint): TPoint;
    public
        MyOutLinePoint: array [0..8] of TOutPoint;
        Pointcount:integer;
        MapSeriesIndex:Integer;
         {  Used  1 正常 0 被系统自动删除  2 手动删除
             3 数据经过分析，但是在数据库保存的范围内，表示不可用}
         Used:Integer;

         {//ModifyData 1 代表是 系统自动计算值  2 原来代表 保存的 原始云图，现在放弃没有意义
                       3 代表对后面的数据 预测计算值  4 是保存的已经修订好的 来压步距
                       5 表示局部区域出现 压力的集中，对于整体来压判断，用处不大
                       6 表示局部区域的数据可能出现异常 不是压力造成而是设备或者人为
                       7 表示是数据库保存的数据，但是是可以编辑的状态
                       8 表示 本次来用  整体来压强度在 0.5 之下的 零星 来压
                       9 表示 本次来压  整体来压强度在 0.5 -1 之间的来压 老顶 下位岩梁  估计是直接顶 来压
                       10 代表 本次来压时 整体来压强度 大于 1 的 来压  老顶 上位岩梁 来压
                        }
         ModifyData:integer;
         {
           ForcaseId：=1  1 代表剧烈来压预测
                          2 代表一般来压预测
         }
         ForcaseId:integer;// 预测的编号
         DataBaseid:integer; // 记录数据库中 记录编号
         Points:array of TDoublePoint;
         Point_Int:array of TPoint;
         SupStep: Array of TOneSupportStep;
         OneStepInfo: TcomprehensiveOldStep;
         inn_InStep_id:integer;// 内码ID，不会改变
         procedure AddPoint(pt:TDoublePoint);
         procedure InsertPoint(ProPt,NextPt,InPt:TDoublePoint);
         procedure SelectIntPoint;
         procedure setOutlinePoint;
         function  ReturnMiddlePoint(P1,P3:TOutPoint):TOutPoint;
         function  OutPoint(p1,p2,P3:TOutPoint):Boolean;
         function  Return_OutLine_Area(p1,p2,P3:TOutPoint):Double;
         function  Return_Whole_Area:Double;
         function  ReturnMax(x,y:double):double;
         function  ReturnMin(x,y:Double):Double;
         function  IsPtIn_PointPoly(Pt1:TPoint):Boolean;
         function  IsPtInOutLine(pt:TPoint):Boolean; // 是否在 8点圈定的区域
         function  ReturnPtFromDoublePoint(pt:TDoublePoint):TPoint;
         function  ReturnOutPtDoublePoint(pt:TDoublePoint):TOutPoint;
         function  GetMinDao:double;
         function  GetMaxDao:Double;
         procedure SetMinAndMaxSup(Min_V,Max_V:double);
         procedure SetMinAndMaxDao(Min_V,Max_V:double);
         procedure SetMyOutLinePoint(id:integer;pt:TPoint);
         function  FillSupportStepInfo(TDC: TDoubleContourRecord):Boolean ;
         function  JudgeThisStepIsEfficient(Var S_Sup,E_Sup,S_Dao,E_Dao:integer;
                     Con_Sup,Con_Dao:integer):Boolean;
         function  FillOneStepInfo(OneStep:TcomprehensiveOldStep;ASup:Array of TOneSupportStep;
                   FirstArryid,St_Sup,End_Sup:integer ):TcomprehensiveOldStep;// 填充本次来压的基本信息
         function  ReturnSupData(TDC:TDoubleContourRecord;pt:TPoint;Var DT:TDateTime):Double;
         procedure setContinueSupport_Dao(Sup,Dao:integer);
         procedure Refresh;
         procedure  CalculateStep(TDC: TDoubleContourRecord);// 计算每个循环的支架信息
         function  GetDispTitle:String;
         procedure ClearPoints;
         procedure CopyThisClass(Source:TOldOneStep);
         procedure SetJudgeLevelLineDat(Value:Double);// 来压区域判断的用力下限
         function  ReturnMarkLabel:string;
         // forcase use
         procedure FromOneStepInfoExactDataIntoOutLine;
         constructor Create;
         destructor Destroy;
   End;

   TPhaseRecord= Class
     private
        StartDao,EndDao:integer; // 区间开始进刀 区间结束进刀
        StartFootage,EndFootage:Double;// 区间开始进尺  结束进尺
        Startid,Endid:integer;  // 开始内码编号 结束内码编号
        MaxValueDao,MinValueDao:integer;  // 最大值进刀 最小值进刀
        Count:integer;
        Datas:Array of Double;
        AGV_Data:double;  // 平均数
        Standard_erro:double;//  标准误差
        Median:double;//  中位数
        Model:double;//   众数
        Standard_Deviation:double;// 标准差
        Variance:double;// 方差
        peakedness:double;// 峰度
        bs:double;// 偏度
        Quyu:Double;// 区域
        MinData:Double;// 最小值
        MaxData:Double;//  最大值
        ZXQD95:integer;// 置信区间 95
         //
        UpperLineData,DownLineData:Double;  // 大于均值的平均值  小于 均值的平均指
        ULSt,ULEn:integer; // 超过均值的开始编号 与结束编号
        UL_St_Dao,UL_En_Dao:integer; //超过均值的开始编号 与结束编号 对应的进刀数
        UL_St_Footage,UL_En_Footage:double; //超过均值的开始编号 与结束编号 对应的进尺数

        //动载系数
        phase_DZXS:double;
        Whole_DZXS:Double;

        procedure RemoveDataFromID(Id:Integer);


      public
        procedure  Clear;
        procedure  insertData(Value:double);
        procedure  Caluate;
        function   Get_AGV:Double;  // 平均数
        function   Get_Standard_erro:double; // 标准误差
        function   Get_Median:Double;// 中位数
        function   Get_Model:double;// 众数
        function   Get_Standard_Deviation:Double;//标准差
        function   Get_Variance:Double;//方差
        function   Get_peakedness:double;//峰度
        function   Get_bs:double;//偏度
        function   Get_Min_Data:Double;//最小值
        function   Get_Max_Data:Double;//最大值
        function   Get_max_Min:double;// 区域 也叫极差
        function   Get_ZXQD95:integer;// 置信区间 95
        function   Get_Count:integer;
        function   Get_ToTal:double;
        function   Get_StartULid:integer;
        function   Get_EndULid:integer;
        function   Get_UpperLineData:Double;
        function   Get_DownLineData:double;
        function   Get_Endid: integer;
        function   Get_Startid: integer;
        function   Get_MaxValueid:integer;
        function   Get_Start_JinD:integer;
        function   Get_End_JinD:integer;
        function   Get_U_st_JinD:integer;
        function   Get_U_Ed_JinD:integer;
        function   Get_Start_FG:Double;
        function   Get_End_FG:Double;
        function   Get_U_st_FG:Double;
        function   Get_U_Ed_FG:Double;

        procedure  SetAGVData(phaseAGV,WholeAGV:Double);
        function   Return(Memo1:TMemo):Boolean;

        constructor Create;
        destructor Destroy;
   End;

   TPhaseJinDaoAGVRec=record
     JinDao:integer;
     AGVData:double;
     MAXData:double;
     MzlData:double;
     Footage:double;
     gent:TdateTime;
   end;
      {分阶段来压的数据类}
   TOldStepPhase= class(TPersistent)
    private
       Ex_Sup_inv:integer;// 外部使用的 支架使用间隔
       function ReturnK(Number:integer):TArrayDouble;
        //
       procedure addPhaseAGV_Dao(Va:TPhaseJinDaoAGVRec);
       Procedure Clear_AddPhaseGAv;
       procedure ADD_Step_Array(st_id,Ed_id,St_dao,Ed_dao,Max_v,Min_V:integer;
                 UpperLD,DownLD:double;ULSt,ULEd:integer);
       procedure Clear_Step_Array;

    public
        PhaseNumber:integer;//阶段编号
        StartsupBh:integer; //开始支架编号
        EndSupBh:integer; //   结束支架编号
        Used:Boolean; // 是否有效使用
        StepCount:integer; //  来压序号
        Steps :Array of   TcomprehensiveOldStep;
        StartDao,EndDao:Integer;
        EndJinChi:Double;
        Statistical_data: TPhaseRecord;
        ComeStepLine:double;// 区间来压资格线
        AGv_AGV_Data:Double;// 本区域平均值的平均值

        PhaseAGV_Count:integer;
        PhaseAGV_EvenDao:array of TPhaseJinDaoAGVRec;
        Step_Array_Count:integer;
        Step_Array:array of  TPhaseRecord;
        procedure Clear;
        procedure AddOneStep(Step:TcomprehensiveOldStep);
        procedure CalculateComeStepInfo(st,Ed:TcomprehensiveOldStep) ;
        function  CleanData(Step:TOldOneStep; TCoSt:TcomprehensiveOldStep) :TcomprehensiveOldStep;
        procedure  WithTwoStepFillPrevStepInfo(Currid:integer);
        procedure  WithTwoStepFillPrevStepInfo_Copy(var Prv_step,Next_Step:TcomprehensiveOldStep);
        function   ForcaseStep(Number,ModifyData:integer):integer;
        function   GetEfficientSteps(ModifyData:integer;Var Stp_Con:integer):string;
        function  GetComeStepCount(ModifyData:Integer):Integer;
        function  GetComeStepsInfo(ModifyData:Integer;Var AGVDao,AGVChi:double):Boolean;
        function  returnSupportList:String;
        procedure SetSupportInval_ExUsed(Value:Integer);
        //-----
        procedure CalPhaseAGVDAta(DC:TDoubleContourRecord;FD:Array of TContourFootageData);  // 计算格阶段的均值
        procedure Cut_contour_AGVData ;  // 把均值进行切分
        procedure InsertDataIntoPhaseRecord;//把数据插入近 计算统计信息的类中
        //
        procedure SetEndDao(Value:integer);
        procedure SetStartDAo(Value:integer);
        procedure SetEndJinChi(Value:double);
        constructor Create;
        destructor Destroy;

   end;
   // LineGraph
  TArrayOLdOneStep =Array of TOldOneStep;
  TSupportRecord=record
      legendName:string;
      SupportBh:integer;
      LineSeries:TLineSeries;
      PointSeries:TPointSeries;
      QL_oldStepCount,YB_oldStepCount,JB_oldStepCount:integer;
      MaxTime,MinTime:TdateTime;
      QL_oldsteps,YB_oldsteps,JB_oldsteps:TArrayOLdOneStep; // 强烈 一般 局部
  end;

   //
   TOldSteps=Class(TPersistent)
    private
       // LPC:integer;
        ContinueSupport,ContinueJinDao:integer;// 持续的支架数与 进刀数
        Dispose_LMd:integer;// 数据处理灵敏度
        LeftPoints:array of TDoublePoint;
        tempOneStep:TOldOneStep;
        inSteps:array of TOldOneStep;
        StepNumber:integer;
        MaxFootage:Double;
        Grap_MinDao,Grap_MaxDao:integer;
        MaxSupportNumber:integer;
        JudgeLevelLineData:Double;// 来压区域判断的用力下限

        procedure AddLeftPoints(pt:TDoublePoint);
        function  CalDis(pt1,pt2:TDoublePoint):double;
        function  ReturnEXStepSortid(ps:TOldOneStep):integer;
        function  SplitSupString(Str:String;MinSup,MaxSup:Integer):String;
    public
        LPC:integer;
        isCalComeStep:Boolean;// 是否计算了来压步距
        ExSteps:array of TOldOneStep;
        PhaseNumber:Integer;
        PhaseSteps:Array [0..6] of TOldStepPhase;
        Whole_AGV_Data:Double;
        UsedJudgeStep_Ratio:Double;// 使用的判断面积比值
        UsedLevelLineValue:double;// 使用的用力判断线
        AGV_AGV_Whole_Data:double;// 平均值的平均值

        procedure AddPoints(pt:TDoublePoint);
        procedure ClearPoint;
        function ReturnMax(x,y:double):double;
        function ReturnMin(x,y:double):double;
        function ReturnIntMax(X,Y:integer):integer;
        function ReturnIntMin(X,Y:integer):integer;
               //----------
        function JudgeOldstep:Boolean;
        function CalPolygonArea_LeftPoints(Quan_start,Quan_End:integer):Double;
        function CalArea(p1,p2,p3:TDoublePoint):Double;
        function JudgeOldStep_2(Var quan_start :integer;Quan_End:integer):Boolean;
        //--
        function SplitCycle(Startid,Endid:integer):Boolean;
        function JudgeChildCycle(Startid,Endid:integer):Boolean;
        function DispostCycleData(Startid,Endid:integer):Boolean;
        function JudgeCycleDataToStep(Startid,Endid:integer):Boolean;
        function ReturnEffiectArea:Double;//返回 有效区域的整体面积
        function ReturnStepArea_Ratio:Double;
        //----------------
        function  AddSteps:TOldOneStep;
        procedure DeleteStep(id:integer);
        procedure ClearSteps;
        procedure Sort;
        procedure SetJudgeBasicParameters(Sup,Dao:Double;lmd:integer);
        function  ReturnStepid(MPIndex:integer;var Edited:Boolean):Integer;
        procedure Refresh;  {合并区域}
        function  mergeTwoOldSteps(First,Second:TOldOneStep):Boolean;
        procedure CalculateComeStep(TDC:TDoubleContourRecord;FcD:Array of TContourFootageData;
                     Gzm:TGzm;SaveRecall:Boolean;MinDao,MaxDao:integer);
        //
        function SelectNextStepId(PrvStep:TOldOneStep;FcD:Array of TContourFootageData;Currid:integer):Boolean;
        function JudgeNestStepisEfficent(PrvStep:ToldOneStep;Nextid:integer):Boolean;
        // 2018-7-18
        procedure FindNextStepToFillOneInfo(CurrStep:TOldOneStep;FcD:Array of TContourFootageData;
                    finded:Boolean;Gzm:TGzm);
        function FillStepsInfoFromPrv_NextStep(Currstep :TOldOneStep;NextInFo:TcomprehensiveOldStep;
                        FcD:Array of TContourFootageData; finded:Boolean; Gzm:TGzm       ):TcomprehensiveOldStep;
        procedure ContinueFillStepInfo(CurrStep:TOldOneStep;FcD:Array of TContourFootageData;
                    finded:Boolean;Gzm:TGzm);
        function PrintOldStepResult(Memo:TMemo;Gzm:TGzm;SaveRecall,OutDao:Boolean;
                        MinDao,MaxDao:integer):Boolean;
        function ReturnOldStepForLineGrap(var Rec:TSupportRecord;Gzm:TGzm;SaveRecall,OutDao:Boolean;
                              MinDao,MaxDao,Unit_KK:integer):Boolean;
        function ReturnStepMaxData(Gzm:TGzm;Supbh:integer;TdTime:TdateTime;
                             Var MaxTime:TDateTime;Var DataValue:Double):Boolean;
        function ReturnExStepidFromInn_Stepid(In_id:integer):Integer;
        //PhaseNumbeer
        function InitPhaseSteps(Number:integer;Gzm:TGzm):Boolean; {初始化Phasestep 的类}
        function SplitPhaseString(StrV:String):Boolean;
        procedure CalculatePhaseStep(Gzm:TGzm;SaveRecall:Boolean;MinDao,MaxDao:integer);    //计算阶段来压步距
        procedure CalCulatePhaseStep_Copy(Gzm:TGzm;SaveRecall:Boolean;MinDao,MaxDao:integer);    //计算阶段来压步距 2018 8 月修改
        function  CalCulatePhaseStatistical_Data(FcD:TDoubleContourRecord;
                      FDao:Array of TContourFootageData;Unit_KK:integer):Boolean; // 对 分区内的数据进行统计分析
        function  ForCaseOlsStep(Number:integer):Boolean; //预测来压步距
        {寻找那个来压 区域是本阶段的 下一个来压步距}
        function SelectWhichStepInThisPhaseNumber(startid:integer;StartSup,EndSup:integer;
                             StartDao,EndDao:integer;MaxQd:double):Integer;
        function PrintPhaseSteps(Memo:TMemo;Gzm:TGzm;SaveRecall,OutDao:Boolean;
                            MinDao,MaxDao:integer):Boolean;
        function ReturnTwoStephaveSamePrvStep(First,Second:TcomprehensiveOldStep):Boolean;
         //
        function PrintStepsIntoStringGrid(StrGrid:TStringGrid;Gzm:TGzm):string;
        procedure SplitStringToStringCell(StrGrid:TStringGrid;Col,Row:integer;Str:String);
        function FillStringWholeGZmData_Main(StrGrid:TStringGrid;Gzm:TGzm;
                                     iEx_stepid,iModiftyData:integer;
                                     var Row,Stepcount:integer ):string;
        function FillStringPhaseGzmData_Main(StrGrid:TStringGrid;
                                     startsup,EndSup:integer;
                                     PhaseStep:TcomprehensiveOldStep;
                                     var Row,Stepcount:integer;
                                     Col1Str,Col2Str:string ):string;
        function FillStringData(StrGrid:TStringGrid;Row,Stepcount:integer;
                               StartSup,EndSup:integer;
                               OneStepInfo:TcomprehensiveOldStep;
                               Col1Str,Col2Str:string):String;
        procedure SetMaxFootage(Value:Double);
        procedure SetMax_Min_Jindao(Min_D,MAx_D:Integer);
        procedure SetMax_Supportbh(Value:integer);
        function  EffectJinDao(tempDao:integer):Boolean;
        procedure CopyThisClass(Source:TOldSteps);
        procedure SetJudgeLevelLineDat(Value:Double);// 来压区域判断的用力下限
        // 为word报告使用的数据
        function  GetComeStepCount(ModifyData:Integer):Integer;
        function  GetComeStepInfo(ModifyData:Integer;var AGVDao,AGVchi:Double):Boolean;

       constructor Create;
       destructor Destroy;
   end;





type
  TDrawGrap=class
     Jituan_id :integer;  //集团公司编号
     Mk_id:integer;     // 矿区编号
     Jituan_name,Mk_Name:string; //集团公司与煤矿名称
     FGzm:TGzm;
     DataTimeAndFootAge:TDataTimeAndFootAge;
     CloudClass : TCloudClass;//云图数据记录
     GraphClass : TGraphDataClass; // 曲线图数据记录
     TwoDimCloud : TTwoDimCloud;   //二维云图画图的数据类
     ThreeDimCloud :TThreeDimCloud;// 三维云图数据类
     ColorValue:TColorValue;   //颜色云图数值类
     BarMarks:TBarDispMark;  // 压力频谱显示

   private
      MySqlDataSet1:TMyDataSet;
      MySqlDataSet2:TMyDataSet;
      MyCommand1:TMyCommand;
      // MyLine
      itsLine,firstLine,lastLine,dLine:MYLine;
      origin,movePt:TPoint;
      UsedYunTuColorTypeId:integer; //云图颜色 使用类型 0 等间距 1 优化间距
      inn_Judge_Step:array [0..5] of TOldSteps;// 0 最大值 1 平均值   2 初撑力  3  末阻力 4 瞬间值  5 手动录入

      procedure MakeCloudCaption(image:Timage); //做标题
      function  InitCloud_TwoDim_Image(image:Timage):Boolean; // 初始化二维画图基本数据
      procedure Make_Two_Dim_axis(image:Timage);// 二维 做X Y坐标轴
      function  Make_Two_Dim_Image(image:Timage;CloudType:TYuntuDataType):Boolean;// 二维 图片
      function  Make_Two_Dim_Grid(image:TImage):Boolean;//二维图片绘制网格
      function  ComputerTwoDimCloudCyclePoint:Boolean;//计算循环数据二维云图的图像坐标
      function  ComputerTwoDimCloudDisposePoint:Boolean;//计算循环数据二维云图的图像坐标

      procedure InitThreeDimChart(Chart:TChart;series:TSurfaceSeries);
      procedure Make_ThreeDim_axis_Chart(Chart:TChart);// 三维 做X Y坐标轴
      function  Make_Three_Dim_Cycle_CloudChart(series:TSurfaceSeries;PB:TProgressBar):Boolean;// 循环数据三维 图片
      function  Make_Three_Dim_Dispose_CloudChart(series:TSurfaceSeries;PB:TProgressBar):Boolean;// 处理数据三维 图片
      function  FillDisPoseGrid:Boolean;// 填充第三次处理的数据(需要平滑补充数据点)
      function  Inverse_Distance_Powe(p0,p1,p2,p3,p4:TDisposeGrid) :TDisposeGrid;// 反距离插值算法
      function  Kriging(px:TKrigePoint;Arrypt:Array of TKrigePoint;S_Count:integer):TKrigePoint;
      function  Liner_Distance_Powe(p0,p1,p2:TDisposeGrid): TDisposeGrid;//线性差值算法
      function  ReturnMinPoint(StartPoint,EndPoint:integer):integer;  //返回三维平滑最近的点
      function  SetMyDisPoseGrid(pt:TDisposeGrid):integer;  //扩容 TDisposeGrid 数组

      function  SelectMyGridColorValue(Value:TCycleData):Boolean; //重新定义循环数据颜色类
      function  SelectMyDisPoseGridColorValue(Value:TDisPoseData):Boolean; //重新定义处理数据颜色类
      function  MakeImageLegend(image:Timage):Boolean; //制作二维图片的图例

      function   ClearMyGrid:Boolean;

      procedure  InitDoubleMyline; //初始化两条线


      function  Inverse_Distance_Contour(p0,p1,p2,p3,p4:TContourRecord) :TContourRecord;// 反距离插值算法
      function  Liner_Distance_Contour(p0,p1,p2:TContourRecord): TContourRecord;//线性差值算法
      // 控制坐标轴的数值
      procedure  SetChartAxisMaxAndMinValue(BottomAxis:TChartAxis;MaxV,MinV:double);
      {SaveContourSeirsIntoDataBase}
      function ReturnMaxContourStepTableId:integer;
      function DeleteContourStepTable(MinDao,MaxDao,MinSup,MaxSup,DataType:Integer):Boolean;
      function FillOldOneStepPoint(tmp:TOldOneStep;id:integer):Boolean;

      procedure  drawLine(image:TImage;topLeft: TPoint; bottomRight: TPoint);
      // 云图颜色分类
      Function   GetContourColor_Equal(NumLevel,Xh:integer;
                 var UpToValue:integer):TColor;  // 获得云图颜色区分
      Function   GetContourColor_optimization(NumLevel,Xh:integer;
                 var UpToValue:integer):TColor;  // 获得云图颜色区分
      //
      procedure SetYunColorType(Value:integer);
      function  GetYunColorType:integer;
   
   public
      SecondDPDataNumber,ThirdDPDataNumber   :Integer;
      MyDisPoseGridNumber:integer;
      SelectDataBasic_DaoOrFootage:integer;

      MyContourColor_NumLevel:integer;
      MyColors     : array[0..200] of TColor;
      MyGrid       : array of TCyclePressData;
      MyThirdGrid  : array of TThirdDPThreePoint;
      MyDisPoseGrid: array of TDisposeGrid;
      //-----
      MyContourColor:array [0..12] of TContourColor;
      MyContourDoubleGrid: TDoubleContourRecord;
       //
      BasicJinDao:TBasicJinDao;
      FilledContourDataNumber:integer;
      FilledContourData :Array of TContourFootageData;
       //
      ConTourSeriesPar:TContourDispParam;
      { 系统外部使用的 步距不需要创建  是一个指针 指向内部的 那一个变量 }
      Auto_Judge_OldStep:TOldSteps;

       {
         MapSeriesEditState 地图云图的编辑状态
            -1 没有加载数据
             1 加载数据成功     当前状态 查看状态
             2 通过选择图片区域， 当前为 点的编辑状态

       }
       MapSeriesEditState:integer;
       EditMapPoint:TEditMapSeriesRe ;//地图编辑点的信息

      function  SelectMineAndWorkFaceBh(Mk,Gzm:string):Boolean;
      function  updateChartImage(TwoDimImage:Timage;Chart:TChart;ThirdSeries:TSurfaceSeries;
                FirPB,SecPB:TProgressBar):Boolean; //更新图片信息
      function  DatetimeToFootage(Dt:TdateTime;Str:String):double; // 时间转换为进尺
      function  FootageToDatetime(FG:double;Str:string):TDateTime; // 进尺转换为时间
      function  initMYColors(CValue:TColorValue):Boolean;
      //-------  201803
      function  ReturnMyColors(Value:integer):TColor;
      function  RetrunManualDimColord(CValue:TColorValue;DValue:Double):TColor;
      function  FillThreeContourSeriesData(Series:TCustom3DSeries;Flag:integer):Boolean;

      procedure ContourSeries1_Basic_GroupLevle(CValue:TColorValue;Series:TContourSeries);
      procedure ContourSeries1_Extract_GroupLevel(LineValue:Double;CValue:TColorValue;Series:TContourSeries);

      function  RefreshChart_ConTourSeries(Chart:Tchart;Series1:TContourSeries;
                                 FirPB,SecPB: TProgressBar;Flag:integer):Boolean;
      procedure MakeContourChartCaption(Chart:Tchart;Series:TContourSeries);
      //-------
      function  RefreshChart_ThreeConTourSeries(Chart:Tchart;Series1:TCustom3DSeries;
                                 FirPB,SecPB: TProgressBar):Boolean;
      procedure MakeThreeContourChartCaption(Chart:Tchart;Series:TCustom3DSeries);
      //----------------
      function  RefreshChart_GraphLineSeries(Chart:Tchart;Series1:TLineSeries;
                                 FirPB,SecPB: TProgressBar):Boolean;

      procedure MakeGraphChartCaption(Chart:Tchart;Series:TLineSeries);
      //------------------------

      function   ClearFilledContourData:Boolean;
      Function   GetContourColor(Typeid,NumLevel,Xh:integer;
                 var UpToValue:integer):TColor;  // 获得云图颜色区分
      //------
      function  GetCycleData(GzmBh,Datatype:string;StDate,EndDate:TdateTime;PB:TProgressBar):Boolean;  //查找循环内的压力数据
      function  GetManualInputPressData(GzmBh:string;StDate,EndDate:TdateTime;PB:TProgressBar):Boolean; overload; //查找人工录入数据
      function  GetManualInputPressData(GzmBh:string;MinDao,MaxDao:integer;PB:TProgressBar):Boolean; overload; //查找人工录入数据
      function  GetThirdDPThreeDimData(GzmBh,Datatype:string;StDate,EndDate:TdateTime;PB:TProgressBar):Boolean;//获得第三次处理后的数据,用于三维显示
      //执行克里金插值算法
      function selectTenPointFromFourFangxiang(var TD: TDoubleContourRecord;pt: TPoint;
                   min_Dao,Max_Dao,Min_Sup,Max_Sup,inv_Sup:integer):Boolean;

      //
      function  GetImagePointData(x1,y1,x2,y2:integer):TSelectImageGrid;
      procedure  MoveDoubleMYLine(image:TImage;MYPoint:TPoint);//移动两条线
      function   IsPtInPoly(ALon, ALat: double; APoints: array of TPoint): Boolean; //判断一个点是否在多边形区域内
      {自动加载分析云图}
      function  ExtractDataFormSeries(tChart1:TChart;
                           Series:TContourSeries;First,Second:TProgressBar;LeverLineValue:Double):Boolean;
      function  ExtractDataFormSeries_ManualRun(Series:TContourSeries;First,Second:TProgressBar;LeverLineValue:Double):Boolean;
      // 把划分后的区域边界固定下来
      function SaveExtractDataFormSeries_SideData(tChart1:TChart;
                           Series:TContourSeries;First,Second:TProgressBar;LeverLineValue:Double):Boolean;

      function  CalCulateOldStep(OldStep:TOldSteps;TDC: TDoubleContourRecord):Boolean;
      function  GetMyCoutOurColorUpToValue(Number:integer;UPToValue:Double;
                   var D_Value:Double):Integer;//查找给定的UPToValue 是否有数值
      function CaluateStepToPrint:Boolean;
      function CalComeStepAndPrintToMemo(Memo1:TMemo;StrGrid:TStringGrid):Boolean;
      {SaveContourSeirsIntoDataBase}
      function SaveContourSeriesIntoDataBase(Steps:TOldSteps;DataType:integer):Boolean;
      function DeleteContourSeriesFromDataBase(Value:integer):Boolean;
      function ReadContoueSeriesToClass(Steps:TOldSteps;DataType:integer):Boolean;
      function ReturnDataBaseMin_MaxDao(Var MinDao,MaxDao:integer):Boolean;
      {//ProgressBar}
      procedure StepProcegressBar(First,Second:TProgressBar;step1, step2: integer);
      procedure SetProcegressBarVisual(palen:TPanel;First,Second:TProgressBar;Value:Boolean;Max1,Max2:Integer);
      //
      property YunColorType:integer  read GetYunColorType write SetYunColorType;
      //
      // ReadDataTothread
      procedure LoadRockPressDataForConTour(Falg:integer);
       // 初始化 工作面的类
      function UseFGzmInitPStope():Boolean;
      // 改变数据类型
      function  ChangeThreeArrayContourGrid(UnitType,DataType:integer):Boolean;
      // 更换步距函数
      function  ChangeJudgeStepClass(Valu:TCycleData): TOldSteps;
      // 获取不同数据类型的 压力判断线与面积比值
      function GetStepJudgeLevel(CycleType:integer):Double;// 获取压力判断现
      function GetStepJudgeRatio(CycleType:integer):Double;// 获取压力判断后的面积比值
      // 关于填充进刀数据时间
       Procedure FillBasicJinDao(B_JinDao:TBasicJinDao;StartDao,EndDao:integer);
       procedure SelectPressDataFromSupportMoveInfo( First,Second: TProgressBar;Flag:integer);
       procedure CalAGV_AGV_WholeData;
       // 填充计算压力与压强的转换参数
       function  Cal_MPaChangeKN_xs:Boolean;
      //------------------------------------------
      constructor Create(ExConn:TMySqlConnection);
      destructor Destroy;override;
  end;

implementation

{ TDrawGrap }

uses System.TypInfo, StopWatch, UFormWait,math;

procedure TDrawGrap.CalAGV_AGV_WholeData;
var
  D,S:integer;
  C_Count:integer;
  Sum_D:Double;
begin
    C_Count:=0;  Sum_D:=0;
    for D := 0 to High(MyContourDoubleGrid) do
       for S := 0 to High(MyContourDoubleGrid[D]) do
        if (MyContourDoubleGrid[D][S].DataType>0) and (MyContourDoubleGrid[D][S].AGV_Value >0) then begin
           inc(C_Count);
           Sum_D:=Sum_D+ MyContourDoubleGrid[D][S].AGV_Value;
        end else   if (MyContourDoubleGrid[D][S].DataType>0) and (MyContourDoubleGrid[D][S].Manual_Value >0) then begin
           inc(C_Count);
           Sum_D:=Sum_D+ MyContourDoubleGrid[D][S].Manual_Value;
        end;

    if C_Count>0 then begin
       Auto_Judge_OldStep.AGV_AGV_Whole_Data :=Sum_D/C_Count;
    end else begin
       Auto_Judge_OldStep.AGV_AGV_Whole_Data:=1;
    end;


end;

function TDrawGrap.CalComeStepAndPrintToMemo(Memo1:TMemo;StrGrid:TStringGrid): Boolean;
begin
   // 把所以区域进行遍历检索
  CalCulateOldStep(Auto_Judge_OldStep,MyContourDoubleGrid);
  //把最大进尺送进去
  Auto_Judge_OldStep.SetMaxFootage(DataTimeAndFootAge.MaxFootage);
  // 对分区域的来压进行检索
  Auto_Judge_OldStep.CalculatePhaseStep(FGzm ,
                     CloudClass.RecallMidDaoSaveStep,
                     DataTimeAndFootAge.Graph_MinDao,DataTimeAndFootAge.Graph_MaxDao
                     );
  //对不进行分区 进行来压步距的分析
   if CloudClass.PrintDispPhaseVisual then  begin

       Auto_Judge_OldStep.PrintOldStepResult(Memo1, FGzm,
                         CloudClass.RecallMidDaoSaveStep,CloudClass.PrintOutDaoStepInto,
                         DataTimeAndFootAge.Graph_MinDao,DataTimeAndFootAge.Graph_MaxDao
                         );
   end else begin

      // 对分区进行即将到来的来压步距进行预测
      Auto_Judge_OldStep.ForCaseOlsStep(3);
      Auto_Judge_OldStep.PrintPhaseSteps(Memo1, FGzm ,
                         CloudClass.RecallMidDaoSaveStep,CloudClass.PrintOutDaoStepInto,
                         DataTimeAndFootAge.Graph_MinDao,DataTimeAndFootAge.Graph_MaxDao
                         );
   end;
   // 打印数据进StringGrid
   Auto_Judge_OldStep.PrintStepsIntoStringGrid(StrGRid,FGzm ) ;
end;

function TDrawGrap.CalCulateOldStep(OldStep: TOldSteps;
  TDC: TDoubleContourRecord): Boolean;
begin
   OldStep.CalculateComeStep(TDC,FilledContourData,FGZm,
                            CloudClass.RecallMidDaoSaveStep,
                            DataTimeAndFootAge.Graph_MinDao,DataTimeAndFootAge.Graph_MaxDao
                            );
   Result:=true;
end;

function TDrawGrap.CaluateStepToPrint: Boolean;
{
  对所有的来压步距进行阶段性区域遍历

}
begin
     // 把所以区域进行遍历检索
  Result:=CalCulateOldStep(Auto_Judge_OldStep,MyContourDoubleGrid);
  //把最大进尺送进去
  Auto_Judge_OldStep.SetMaxFootage(DataTimeAndFootAge.MaxFootage);
  // 对分区域的来压进行检索
  Auto_Judge_OldStep.CalCulatePhaseStep_Copy(FGzm ,
                     CloudClass.RecallMidDaoSaveStep,
                     DataTimeAndFootAge.Graph_MinDao,DataTimeAndFootAge.Graph_MaxDao
                     );
  // 对分区进行即将到来的来压步距进行预测
  Auto_Judge_OldStep.ForCaseOlsStep(3);
  // 对各个分区内的数据进行统计分析
  Auto_Judge_OldStep.CalCulatePhaseStatistical_Data(MyContourDoubleGrid,FilledContourData,
                                round(ColorValue.UnitValue)) ;
end;

function TDrawGrap.Cal_MPaChangeKN_xs:Boolean;
begin
    Result:=False; ColorValue.MPaChangeKN_Xs:=1;
    if FGzm.Usedsupport.Lz_Diameter <=1 then exit;
    ColorValue.MPaChangeKN_Xs:=0.25*3.1415926*sqr(FGzm.Usedsupport.Lz_Diameter/1000)*1000 ;
    if FGzm.Usedsupport.Zj_Lizhu_count >0  then
       ColorValue.MPaChangeKN_Xs:=ColorValue.MPaChangeKN_Xs*FGzm.Usedsupport.Zj_Lizhu_count;

    Result:=true;

end;

function TDrawGrap.ChangeJudgeStepClass(Valu: TCycleData): TOldSteps;
begin
   { MAX_CData,AVG_CData,CCL_CData,MzL_CData,SameTime_CData,Manual_CData  }
     Result:=inn_Judge_Step[Ord(Valu)];
end;

function TDrawGrap.ChangeThreeArrayContourGrid(UnitType,DataType: integer): Boolean;
var
  i,j:integer;
  StSup,invSup:integer;
  pt:Tpoint;
begin
   for I := 0 to high(MyContourDoubleGrid) do
    for j := 0 to high(MyContourDoubleGrid[i]) do  begin
      if DataType=0 then   begin
          MyContourDoubleGrid[i][j].UseData :=MyContourDoubleGrid[i][j].Max_Value*ColorValue.UnitValue;
      end else  if DataType=1 then   begin
          MyContourDoubleGrid[i][j].UseData :=MyContourDoubleGrid[i][j].AGV_Value*ColorValue.UnitValue;
      end else  if DataType=2 then   begin
          MyContourDoubleGrid[i][j].UseData :=MyContourDoubleGrid[i][j].CCL_Value*ColorValue.UnitValue;
      end else  if DataType=3 then   begin
          MyContourDoubleGrid[i][j].UseData :=MyContourDoubleGrid[i][j].MZL_Value*ColorValue.UnitValue;
      end else  if DataType=4 then   begin
          MyContourDoubleGrid[i][j].UseData :=MyContourDoubleGrid[i][j].Same_Value*ColorValue.UnitValue;
      end else  if DataType=5 then   begin
          MyContourDoubleGrid[i][j].UseData :=MyContourDoubleGrid[i][j].Manual_Value*ColorValue.UnitValue;
      end;
      MyContourDoubleGrid[i][j].UnitName := Round(ColorValue.UnitValue);
    end;
    //    // 清理数据
   for I := 0 to high(MyContourDoubleGrid) do
    for j := 0 to high(MyContourDoubleGrid[i]) do
       if MyContourDoubleGrid[i][j].UseData >0  then
          MyContourDoubleGrid[i][j].Krigvalue :=MyContourDoubleGrid[i][j].UseData
       else MyContourDoubleGrid[i][j].Krigvalue :=-1;

   // 对 查询内的数据进行克里金插值
   for I := DataTimeAndFootAge.Graph_MinDao to DataTimeAndFootAge.Graph_MaxDao do  begin
       StSup:=FGzm.RockPressAnalysis.ManulInput_Interval_support;
       while StSup <= FGzm.SupEndNumber  do  begin
           pt.X :=i;
           pt.Y:= StSup;
           selectTenPointFromFourFangxiang(MyContourDoubleGrid,pt,
                      DataTimeAndFootAge.Graph_MinDao,
                      DataTimeAndFootAge.Graph_MaxDao,
                      FGzm.RockPressAnalysis.ManulInput_Interval_support,
                      FGzm.SupEndNumber ,
                      FGzm.RockPressAnalysis.ManulInput_Interval_support
                      );
           StSup:=StSup+FGzm.RockPressAnalysis.ManulInput_Interval_support;
       end;
   end;

end;

function TDrawGrap.ClearFilledContourData: Boolean;
begin
    SetLength(FilledContourData,1);
    FilledContourDataNumber:=0;
end;

function TDrawGrap.ClearMyGrid: Boolean;
 var
  i:integer;
begin
//    for I := 0 to UseDataNumber do  begin
//        Dispose(MyGrid[i]);
//    end;
    SetLength(MyGrid,1);
    SecondDPDataNumber:=0;
end;


function TDrawGrap.ComputerTwoDimCloudCyclePoint: Boolean;
var
  i,SupBh,xh:integer;
  BhStart:Boolean;
  P0:TPoint;
begin
   Result:=False;
   SupBh:=0; BhStart:=False;
    for I := 0 to SecondDPDataNumber-1 do  begin
        if MyGrid[i].SupportBH< 1 then break;
        if SupBh<> MyGrid[i].SupportBH then  begin
           SupBh:= MyGrid[i].SupportBH;
           BhStart:=true;
        end;
   
        if BhStart  then  begin
           MyGrid[i].TwoDimPt[0].X :=TwoDimCloud.X_pix_start;
           MyGrid[i].TwoDimPt[0].Y :=TwoDimCloud.Y_pix_end-Round((MyGrid[i].SupportBH-5)*TwoDimCloud.Y_Bl);
           MyGrid[i].TwoDimPt[1].X :=TwoDimCloud.X_pix_start+Round((MyGrid[i].EndTime-MyGrid[i].StartTime)*TwoDimCloud.X_Bl) ;;
           MyGrid[i].TwoDimPt[1].Y :=MyGrid[i].TwoDimPt[0].Y;
           MyGrid[i].TwoDimPt[2].X :=MyGrid[i].TwoDimPt[1].X;
           MyGrid[i].TwoDimPt[2].Y :=TwoDimCloud.Y_pix_end-Round(MyGrid[i].SupportBH*TwoDimCloud.Y_Bl);
           MyGrid[i].TwoDimPt[3].X :=MyGrid[i].TwoDimPt[0].X;
           MyGrid[i].TwoDimPt[3].Y :=MyGrid[i].TwoDimPt[2].Y;
//           //前一个支架坐标点补齐
           if i>2 then  begin
             MyGrid[i-1].TwoDimPt[1].X :=TwoDimCloud.X_pix_start+
                  Round((DataTimeAndFootAge.EndTime -DataTimeAndFootAge.StartTime)*TwoDimCloud.X_Bl) ;
             MyGrid[i-1].TwoDimPt[2].X :=MyGrid[i-1].TwoDimPt[1].X;
           end;
           BhStart:=False;
        end else begin
           MyGrid[i].TwoDimPt[0].x:=MyGrid[i-1].TwoDimPt[1].X ;  MyGrid[i].TwoDimPt[0].y:=MyGrid[i-1].TwoDimPt[1].y ;
           MyGrid[i].TwoDimPt[3].x:=MyGrid[i-1].TwoDimPt[2].x;   MyGrid[i].TwoDimPt[3].Y:=MyGrid[i-1].TwoDimPt[2].Y;

           MyGrid[i].TwoDimPt[1].X :=TwoDimCloud.X_pix_start+
                                    Round((MyGrid[i].EndTime-DataTimeAndFootAge.StartTime)*TwoDimCloud.X_Bl) ;
           MyGrid[i].TwoDimPt[1].Y :=MyGrid[i].TwoDimPt[0].Y;
           MyGrid[i].TwoDimPt[2].X :=MyGrid[i].TwoDimPt[1].X;
           MyGrid[i].TwoDimPt[2].Y :=MyGrid[i].TwoDimPt[3].Y ;
        end;

    end;
    Result:=true;
end;

function TDrawGrap.ComputerTwoDimCloudDisposePoint: Boolean;
var
  i,SupBh,xh:integer;
  BhStart:Boolean;
  P0:TPoint;
begin
   Result:=False;
   SupBh:=0; BhStart:=False;
    for I := 0 to high(MyDisPoseGrid) do  begin
        if MyDisPoseGrid[i].y< 1 then break;
        if SupBh<> MyDisPoseGrid[i].y then  begin
           SupBh:= Round(MyDisPoseGrid[i].y);
           BhStart:=true;
        end;

        if BhStart  then  begin
           if MyDisPoseGrid[i].x-ThreeDimCloud.Time_InterVal <=DataTimeAndFootAge.StartTime then   begin
              MyDisPoseGrid[i].TwoDimPt[0].X :=TwoDimCloud.X_pix_start;
           end else begin
              MyDisPoseGrid[i].TwoDimPt[0].X :=MyDisPoseGrid[i-1].TwoDimPt[1].X
           end;

           if MyDisPoseGrid[i].y-ThreeDimCloud.Support_interval >0 then  begin
                  MyDisPoseGrid[i].TwoDimPt[0].Y :=TwoDimCloud.Y_pix_end-
                       Round((MyDisPoseGrid[i].y-ThreeDimCloud.Support_interval)*TwoDimCloud.Y_Bl);
           end else begin
                  MyDisPoseGrid[i].TwoDimPt[0].Y :=TwoDimCloud.Y_pix_end;
           end;
           MyDisPoseGrid[i].TwoDimPt[1].X :=TwoDimCloud.X_pix_start+
                           Round((MyDisPoseGrid[i].x-DataTimeAndFootAge.StartTime)*TwoDimCloud.X_Bl) ;;
           MyDisPoseGrid[i].TwoDimPt[1].Y :=MyDisPoseGrid[i].TwoDimPt[0].Y;
           MyDisPoseGrid[i].TwoDimPt[2].X :=MyDisPoseGrid[i].TwoDimPt[1].X;
           MyDisPoseGrid[i].TwoDimPt[2].Y :=TwoDimCloud.Y_pix_end- Round(MyDisPoseGrid[i].y*TwoDimCloud.Y_Bl);
           MyDisPoseGrid[i].TwoDimPt[3].X :=MyDisPoseGrid[i].TwoDimPt[0].X;
           MyDisPoseGrid[i].TwoDimPt[3].Y :=MyDisPoseGrid[i].TwoDimPt[2].Y;
           //前一个支架坐标点补齐
           if i>2 then  begin
             MyDisPoseGrid[i-1].TwoDimPt[1].X :=TwoDimCloud.X_pix_start+
                  Round((DataTimeAndFootAge.EndTime -DataTimeAndFootAge.StartTime)*TwoDimCloud.X_Bl) ;
             MyDisPoseGrid[i-1].TwoDimPt[2].X :=MyDisPoseGrid[i-1].TwoDimPt[1].X;
           end;
           BhStart:=False;
        end else begin
           MyDisPoseGrid[i].TwoDimPt[0].x:=MyDisPoseGrid[i-1].TwoDimPt[1].X ;
           MyDisPoseGrid[i].TwoDimPt[0].y:=MyDisPoseGrid[i-1].TwoDimPt[1].y ;
           MyDisPoseGrid[i].TwoDimPt[3].x:=MyDisPoseGrid[i-1].TwoDimPt[2].x;
           MyDisPoseGrid[i].TwoDimPt[3].Y:=MyDisPoseGrid[i-1].TwoDimPt[2].Y;

           MyDisPoseGrid[i].TwoDimPt[1].X :=TwoDimCloud.X_pix_start+
                            Round((MyDisPoseGrid[i].x-DataTimeAndFootAge.StartTime)*TwoDimCloud.X_Bl) ;
           MyDisPoseGrid[i].TwoDimPt[1].Y :=MyDisPoseGrid[i].TwoDimPt[0].Y;
           MyDisPoseGrid[i].TwoDimPt[2].X :=MyDisPoseGrid[i].TwoDimPt[1].X;
           MyDisPoseGrid[i].TwoDimPt[2].Y :=MyDisPoseGrid[i].TwoDimPt[3].Y ;
        end;

    end;
    Result:=true;

end;

procedure TDrawGrap.ContourSeries1_Basic_GroupLevle(CValue: TColorValue;
  Series: TContourSeries);
var
  i:integer;
begin
    Series.AutomaticLevels :=False;
    Series.Levels.Clear;
    Series.NumLevels :=MyContourColor_NumLevel ;
    Series.CreateAutoLevels;
    for i := 0 to Series.NumLevels -1 do begin
      if CValue.UnitType=1 then  begin
          Series.Levels.Items[i].UpToValue :=MyContourColor[i].UpToValue;
      end else begin
          Series.Levels.Items[i].UpToValue :=MyContourColor[i].UpToValue*10;
      end;
      Series.Levels.Items[i].Color :=MyContourColor[i].ContourColor;
    end;

    Series.RefreshSeries;

end;

procedure TDrawGrap.ContourSeries1_Extract_GroupLevel(LineValue:Double;CValue: TColorValue;
  Series: TContourSeries);
  {
    为了抽取数据 而重新定义GroupLevel
  }
var
  i:integer;
  tmpCol:array [0..2] of TContourColor ;
begin
     //
     tmpCol[0].UpToValue :=Trunc(LineValue*CValue.UnitValue);
     tmpCol[0].ContourColor:=clwhite;
     tmpCol[1].UpToValue :=Trunc(60*CValue.UnitValue);
     tmpCol[1].ContourColor:=clGreen;

    //

    Series.AutomaticLevels :=False;
    Series.Levels.Clear;
    Series.NumLevels :=2 ;
    Series.CreateAutoLevels;
    for i := 0 to Series.NumLevels -1 do begin
       Series.Levels.Items[i].UpToValue :=tmpCol[i].UpToValue;
       Series.Levels.Items[i].Color :=tmpCol[i].ContourColor;
    end;

    Series.RefreshSeries;

end;

constructor TDrawGrap.Create(ExConn: TMySqlConnection);
var
   i:integer;
begin
    MySqlDataSet1:=TMyDataSet.Create(nil);
    MySqlDataSet1.MySqlConnection :=ExConn;
    MySqlDataSet2:=TMyDataSet.Create(nil);
    MySqlDataSet2.MySqlConnection :=ExConn;
    MyCommand1:=TMyCommand.Create (nil);
    MyCommand1.MySqlConnection :=ExConn;

    FGzm:=TGzm.Create(ExConn) ;
    for i := 0 to 5 do  begin
       inn_Judge_Step[i]:=TOldSteps.Create;
    end;

    Auto_Judge_OldStep:=inn_Judge_Step[3];// 让其默认等于末阻力

    //
     BasicJinDao:=TBasicJinDao.Create ;

   // 定义两条线
    InitDoubleMyline;
end;

function TDrawGrap.DatetimeToFootage(Dt: TdateTime;Str:String): double;
var
  sql,Strdt:string;
  Df,UF,MF:double;

begin
   Result:=0;
   if FGzm.Gzmbh <1  then exit;
   Strdt:=Public_Basic.ReturnDateTimeString(MainDataModule.DataType ,Dt);
   Sql:='select sumDownFootage,SumUpperFootage from d_'+IntToStr(FGzm.Gzmbh)+'_Footage ' +
        ' where FootDay <= '+Strdt+' order by Footday desc';

   MySqlDataSet1.Close ;
   MySqlDataSet1.CommandText :=sql;
   MySqlDataSet1.Open ;
   if MySqlDataSet1.RecordCount >0 then  begin
      Df:=MySqlDataSet1.FieldByName('sumDownFootage').AsFloat;
      Uf:=MySqlDataSet1.FieldByName('SumUpperFootage').AsFloat ;
      if Str='Upper' then  begin
         Result:=UF;
      end else if Str='Down' then  begin
         Result:=DF;
      end else begin
         if DF> Uf then  Result:=DF  else Result:=UF;
      end;
      exit;
   end;

   //如果这个时间内没有记录,找最小的一条记录
   Sql:='select sumDownFootage,SumUpperFootage from d_'+IntToStr(FGzm.Gzmbh)+'_Footage ' +
        ' order by Footday ';
   MySqlDataSet1.Close ;
   MySqlDataSet1.CommandText :=sql;
   MySqlDataSet1.Open ;
   if MySqlDataSet1.RecordCount >0 then  begin
      Df:=MySqlDataSet1.FieldByName('sumDownFootage').AsFloat;
      Uf:=MySqlDataSet1.FieldByName('SumUpperFootage').AsFloat ;
      if Str='Upper' then  begin
         Result:=UF;
      end else if Str='Down' then  begin
         Result:=DF;
      end else begin
         if DF> Uf then  Result:=DF  else Result:=UF;
      end;
      exit;
   end;
   MySqlDataSet1.Close ;
end;

function TDrawGrap.DeleteContourSeriesFromDataBase(Value: integer): Boolean;
{
  Value 0 代表全部删除
        1 代表仅删除 当前 处理区域的数据
}
var
  Sql,sql2:string;

begin
   Result:=true;
    try
        if Value=0 then   begin

          sql2:='delete from  D_'+IntTostr(FGzm.Gzmbh)+'_ContourSteps_points ';
          MyCommand1.CommandText :=sql2;
          MyCommand1.Execute ;


          Sql:='delete from  D_'+IntTostr(FGzm.Gzmbh)+'_ContourSteps  ';
          MyCommand1.CommandText :=sql;
          MyCommand1.Execute ;
        end;
    except
       Result:=False;
    end;
end;

function TDrawGrap.DeleteContourStepTable(MinDao, MaxDao, MinSup, MaxSup,
  DataType: Integer): Boolean;
var
  Sql,sql2:string;
  id:integer;
begin
   Result:=true;
    try
       Sql:='Select id from  D_'+IntTostr(FGzm.Gzmbh)+'_ContourSteps  where MinSup >= ' +IntTostr(MinSup) +
             ' and MaxSup <= '+ IntTostr(MaxSup) + ' and MinDao >= '+ IntTostr(MinDao) + ' and MaxDao <= ' +IntTostr(MaxDao) +
             ' and DataType =' +IntTostr(DataType) ;
       MySqlDataSet2.Close ;
       MySqlDataSet2.CommandText :=Sql;
       MySqlDataSet2.Open ;
       while not MySqlDataSet2.Eof  do  begin
          sql2:='delete from  D_'+IntTostr(FGzm.Gzmbh)+'_ContourSteps_points  where  CoutourStepid =' +
                intTostr(MySqlDataSet2.FieldByName('id').AsInteger);
          MyCommand1.CommandText :=sql2;
          MyCommand1.Execute ;
          MySqlDataSet2.Next ;
       end;
      MySqlDataSet2.Close ;

        Sql:='delete from  D_'+IntTostr(FGzm.Gzmbh)+'_ContourSteps  where MinSup >= ' +IntTostr(MinSup) +
             ' and MaxSup <= '+ IntTostr(MaxSup) + ' and MinDao >= '+ IntTostr(MinDao) + ' and MaxDao <= ' +IntTostr(MaxDao) +
             ' and DataType =' +IntTostr(DataType) ;
        MyCommand1.CommandText :=sql;
        MyCommand1.Execute ;
    except
       Result:=False;
    end;

end;

destructor TDrawGrap.Destroy;
var
  i:integer;
begin
    for i := 0 to 5 do
       if assigned(inn_Judge_Step[i]) then
         FreeAndNil(inn_Judge_Step[i]);
  FreeAndNil(FGzm);
  FreeAndNil(MySqlDataSet1);
  FreeAndNil(MyCommand1);
  FreeAndNil(MySqlDataSet2);
  FreeAndNil(BasicJinDao);

  inherited;
end;


procedure TDrawGrap.drawLine(image: TImage; topLeft, bottomRight: TPoint);
begin
   with image.canvas do  begin
      MoveTo(topLeft.x,topLeft.y);
      lineto(bottomRight.x,bottomRight.y);
   end;
end;


function TDrawGrap.ExtractDataFormSeries(tChart1:TChart;Series: TContourSeries;
                 First,Second:TProgressBar;LeverLineValue:Double): Boolean;

begin
   // 把持续进刀与支架的数据送进去
    Auto_Judge_OldStep.SetJudgeBasicParameters(FGzm.RockPressAnalysis.Continue_SupNumber,
                         FGzm.RockPressAnalysis.conTinue_DaoNumber,
                         FGzm.RockPressAnalysis.AnalysisSenstive
                         ) ;

    {让系统手动选择相关参数}
    // 把区域显示类给更改了
    ContourSeries1_Extract_GroupLevel(LeverLineValue,ColorValue ,Series);
    StepProcegressBar(First,Second,0,10) ;
    Series.Repaint;
    tChart1.Refresh ;
    StepProcegressBar(First,Second,0,10) ;
    ExtractDataFormSeries_ManualRun(Series,First,Second,LeverLineValue);





end;



function TDrawGrap.ExtractDataFormSeries_ManualRun(Series: TContourSeries;
         First, Second: TProgressBar;LeverLineValue:Double): Boolean;

var
  i, j, m: Integer;
  lvl: TContourLevel;
  seg: TLevelSegment;
  temp_pt:TDoublePoint;
begin
      for I := Series.Levels.Count-1 downto 0 do  begin
          lvl:=series.Levels.Items[i];
          m:=length(lvl.Segments);
         // ShowMessage('Level: ' + IntToStr(length(lvl.Segments) ) + ', UpToValue: ' + FormatFloat('#,##0.###', lvl.UpToValue));
          if (length(lvl.Segments)>0) and (lvl.UpToValue >= (LeverLineValue - FGzm.RockPressAnalysis.NearColorLineUp_DownValue)* ColorValue.UnitValue )
              and (lvl.UpToValue <= (LeverLineValue +FGzm.RockPressAnalysis.NearColorLineUp_DownValue)* ColorValue.UnitValue)then   begin
              StepProcegressBar(First,Second,10,0);
              for j:=0 to length(lvl.Segments)-1 do    begin
                StepProcegressBar(First,Second,0,10) ;
                 {清理一个区域的节点}
                 Auto_Judge_OldStep.ClearPoint;
                 seg:=lvl.Segments[j];
                   for m := 0 to length(seg.Points)-1  do   begin
                        temp_pt.x:= seg.Points[m].x;
                        temp_pt.y:= seg.Points[m].Y;
                        Auto_Judge_OldStep.AddPoints(temp_pt);
                   end;
                   {区域点总体判断}
                 if Auto_Judge_OldStep.LPC >7 then
                    Auto_Judge_OldStep.SplitCycle(0,Auto_Judge_OldStep.LPC-1);
              end;
         end;
      end;


end;

procedure TDrawGrap.FillBasicJinDao(B_JinDao: TBasicJinDao; StartDao,
  EndDao: integer);
var
  sql:string;
  Rd:TJinDaoRecord;
begin
   MySqlDataSet2.Close;
   Sql:=' select * from  D_'+IntToStr(FGzm.Gzmbh)+'_footage ' +
        ' where  Daoshu >= ' + IntTostr(StartDao) +  ' and Daoshu <=' +IntTostr(StartDao)  +
        ' order by Daoshu  ' ;
   B_JinDao.ClearArray;
   MySqlDataSet2.CommandText :=sql;
   try
      if MySqlDataSet2.Open then
       while not MySqlDataSet2.Eof  do  begin
          Rd.ShotTime :=MySqlDataSet2.FieldByName('FootDay').AsDateTime;
          Rd.Daoshu:=MySqlDataSet2.FieldByName('DaoShu').AsInteger;
          B_JinDao.Add(RD);
          MySqlDataSet2.Next;
       end;
   finally
      MySqlDataSet2.Close ;
   end;
end;

function TDrawGrap.FillDisPoseGrid: Boolean;
var
   i,supbh,PhaseN:integer;
   TempNumber,NextStartNumber:integer;
   p0,p1,p2,p3,p4:TDisposeGrid;
   StartTime:TdateTime;
   LastPhase:Boolean;
begin
    PhaseN:=-1; NextStartNumber:=-1;
    LastPhase:=False;
    //正常数据
    for I := 0 to High(MyThirdGrid) do begin
        if PhaseN <> MyThirdGrid[i].phaseNumber  then   begin
           PhaseN:=MyThirdGrid[i].phaseNumber ;
           StartTime:= DataTimeAndFootAge.StartTime;
           p3.x:=StartTime;
           p3.y:=MyThirdGrid[i].Midsup;
           p3.MaxData:=MyThirdGrid[i].MaxData*0.9;
           p3.MzlData:=MyThirdGrid[i].MzlData*0.9;
           p3.AGVData:=MyThirdGrid[i].AGVData*0.9;
           if PhaseN >1 then NextStartNumber:=  TempNumber;
           if PhaseN=FGzm.RecArryNumber then LastPhase:=True
              else LastPhase:=False;// 这是最后一个区域
           TempNumber:=i;
        end else  begin
           p3:=p4;
        end ;
        //
         p4.x:=MyThirdGrid[i].endTime;
         p4.y:=MyThirdGrid[i].Midsup;
         p4.MaxData:=MyThirdGrid[i].MaxData;
         p4.MzlData:=MyThirdGrid[i].MzlData;
         p4.AGVData:=MyThirdGrid[i].AGVData;
         //
        if NextStartNumber=-1 then begin
           p1.x :=p3.x;p1.y:=1;
           p1.MaxData :=p3.MaxData ;
           p1.MzlData :=p3.MzlData ;
           p1.AGVData :=p3.AGVData ;
           //
           p2.x :=p4.x ;p2.y:=1;
           p2.MaxData :=p3.MaxData ;
           p2.MzlData :=p3.MzlData ;
           p2.AGVData :=p3.AGVData ;
        end else begin
           NextStartNumber:=ReturnMinPoint(NextStartNumber,i);// 返回最近点编号
           if p3.x =DataTimeAndFootAge.StartTime  then    p1.x :=DataTimeAndFootAge.StartTime
              else     p1.x:=MyThirdGrid[NextStartNumber].endTime;
           p1.y:=MyThirdGrid[NextStartNumber].Midsup;
           p1.MaxData:=MyThirdGrid[NextStartNumber].MaxData;
           p1.MzlData:=MyThirdGrid[NextStartNumber].MzlData;
           p1.AGVData:=MyThirdGrid[NextStartNumber].AGVData;
           //
           p2.x:=MyThirdGrid[NextStartNumber+1].endTime;
           p2.y:=MyThirdGrid[NextStartNumber+1].Midsup;
           p2.MaxData:=MyThirdGrid[NextStartNumber+1].MaxData;
           p2.MzlData:=MyThirdGrid[NextStartNumber+1].MzlData;
           p2.AGVData:=MyThirdGrid[NextStartNumber+1].AGVData;
        end;

       while StartTime<= MyThirdGrid[i].endTime do  begin
           if NextStartNumber=-1 then       supbh:=MyThirdGrid[i].startSup
              else   supbh:=MyThirdGrid[NextStartNumber].Midsup;
            while supbh<=MyThirdGrid[i].Midsup do begin
                p0.x :=StartTime;
                P0.y :=supbh;
                p0:=Inverse_Distance_Powe(p0,p1,p2,p3,p4);
                SetMyDisPoseGrid(p0);
                supbh:=supbh+ThreeDimCloud.Support_interval;
             end ;//end while supbh
            // end supbh  最后一个支架编号
            supbh:= MyThirdGrid[i].Midsup;
            p0.x :=StartTime;
            P0.y :=supbh;
            p0:=Inverse_Distance_Powe(p0,p1,p2,p3,p4);
            SetMyDisPoseGrid(p0);

           if  LastPhase then  begin  //如果是最后一个区域
               supbh:=MyThirdGrid[i].Midsup+ThreeDimCloud.Support_interval;
               p1:=p3; p2:=p4;
               p3.y:=FGzm.SupEndUsedNumber;  p3.MaxData :=p3.MaxData *0.9;  p3.MzlData :=p3.MzlData*0.9; p3.AGVData:=p3.AGVData*0.9;
               p4.y:=FGzm.SupEndUsedNumber;  p4.MaxData :=p4.MaxData *0.9;  p4.MzlData :=p4.MzlData*0.9; p4.AGVData:=p4.AGVData*0.9;

               while supbh<FGzm.SupEndUsedNumber do begin
                  p0.x :=StartTime;
                  P0.y :=supbh;
                  p0:=Inverse_Distance_Powe(p0,p1,p2,p3,p4);
                  SetMyDisPoseGrid(p0);
                  supbh:=supbh+ThreeDimCloud.Support_interval;
               end ;//end while supbh
              // end supbh  最后一个支架编号
                supbh:= FGzm.SupEndUsedNumber;
                p0.x :=StartTime;
                P0.y :=supbh;
                p0:=Inverse_Distance_Powe(p0,p1,p2,p3,p4);
                SetMyDisPoseGrid(p0);
           end;

          StartTime:= StartTime+ ThreeDimCloud.Time_InterVal;
       end ;// end while StartTime
    end; //end for

end;

function TDrawGrap.FillOldOneStepPoint(tmp: TOldOneStep; id: integer): Boolean;
var
  sql:string;
  i:integer;
begin
      Sql:='select * from D_'+IntTostr(FGzm.Gzmbh)+'_ContourSteps_points  where '  +
           ' CoutourStepid = ' +IntToStr(id) + ' order by Pointxh ';
      MySqlDataSet2.Close ;
      MySqlDataSet2.CommandText :=sql;
      i:=0;
      if MySqlDataSet2.Open  then  begin
         while not MySqlDataSet2.Eof  do  begin
            if i>7 then  break;
            tmp.MyOutLinePoint[i].Point.x := MySqlDataSet2.FieldByName('AXis_x').AsInteger ;
            tmp.MyOutLinePoint[i].Point.y := MySqlDataSet2.FieldByName('AxiX_y').AsInteger ;
            MySqlDataSet2.Next;
            inc(i);
         end;
      end;
    MySqlDataSet2.Close ;
    Result:=true;
end;

function TDrawGrap.FillThreeContourSeriesData(
  Series: TCustom3DSeries;Flag:integer): Boolean;
  {Flag =0  原始数据  Flag =1 优化数据}
var
  i,j,K,AGVCount:integer;
  AGVData:double;
begin
   Result:=False;
   AGVDAta:=0;
   AGVCount:=0;
   Series.Clear ;
   for I := 0 to High(MyContourDoubleGrid)-1 do   begin  // 刀数
       for j := 0 to High(MyContourDoubleGrid[i]) do     //  支架数
        if MyContourDoubleGrid[i][j].DataType=1 then  begin
            if Flag=0 then begin
                 Series.AddXYZ(MyContourDoubleGrid[i][j].daoshu ,
                            MyContourDoubleGrid[i][j].UseData,
                            MyContourDoubleGrid[i][j].supportbh );
                 inc(AGVCount);
                 AGVDAta:=AGVDAta+ MyContourDoubleGrid[i][j].UseData/ColorValue.UnitValue;
             end else if Flag=1 then begin
                 Series.AddXYZ(MyContourDoubleGrid[i][j].daoshu ,
                            MyContourDoubleGrid[i][j].Krigvalue,
                            MyContourDoubleGrid[i][j].supportbh );
//                 inc(AGVCount);
//                 AGVDAta:=AGVDAta+ MyContourDoubleGrid[i][j].Krigvalue/ColorValue.UnitValue;
             end;
        end;

   end;

   if AGVCount>0 then    begin
       Auto_Judge_OldStep.Whole_AGV_Data :=AGVDAta/AGVCount;
   end else if Flag=0 then begin
       Auto_Judge_OldStep.Whole_AGV_Data:=1;
   end;
   Result:=true;
end;

function TDrawGrap.FootageToDatetime(FG: double;Str:string): TDateTime;
var
  sql:string;
  DD,UD:TdateTime;
begin
   Result:=0;
   DD:=-1;UD:=-1;
   if FGzm.Gzmbh <1  then exit;

   Sql:='select Footday from d_'+IntToStr(FGzm.Gzmbh)+'_Footage ' +
        ' where sumDownFootage <= '+FormatFloat('0.00',FG)+' order by FootDay desc';
   MySqlDataSet1.Close ;
   MySqlDataSet1.CommandText :=sql;
   MySqlDataSet1.Open ;
   if MySqlDataSet1.RecordCount >0 then begin
      DD:=MySqlDataSet1.FieldByName('Footday').AsDateTime;
   end;

   Sql:='select Footday from d_'+IntToStr(FGzm.Gzmbh)+'_Footage ' +
        ' where sumUpperFootage <= '+FormatFloat('0.00',FG)+' order by FootDay desc';
   MySqlDataSet1.Close ;
   MySqlDataSet1.CommandText :=sql;
   MySqlDataSet1.Open ;
   if MySqlDataSet1.RecordCount >0 then begin
      UD:=MySqlDataSet1.FieldByName('Footday').AsDateTime;
   end;
   MySqlDataSet1.Close ;
   if (UD > 40000 )or ( DD > 40000)  then  begin
       if str='Upper' then begin
          Result:=UD;
       end else if str='Down' then begin
          Result:=DD;
       end else begin
          if (UD < DD ) then  Result:=UD  else Result:=DD;
       end;
       exit;
   end;
   //如果没有查到记录   就找第一条记录
   Sql:='select Footday from d_'+IntToStr(FGzm.Gzmbh)+'_Footage ' +
        ' order by FootDay ';
   MySqlDataSet1.Close ;
   MySqlDataSet1.CommandText :=sql;
   MySqlDataSet1.Open ;
   if MySqlDataSet1.RecordCount >0 then begin
      Result:=MySqlDataSet1.FieldByName('Footday').AsDateTime;
   end;
   MySqlDataSet1.Close ;

end;

function TDrawGrap.GetContourColor(Typeid,NumLevel, Xh: integer; var UpToValue:integer): TColor;
{
    Typeid:=0  是代表 等间距数据
    Typeid:=1  是代表 等优化数据

}
begin
    if Typeid=0  then  begin
       Result:=GetContourColor_Equal(NumLevel,Xh,UpToValue);
    end else begin
       Result:=GetContourColor_optimization(NumLevel,Xh,UpToValue);
    end;
end;

function TDrawGrap.GetContourColor_Equal(NumLevel, Xh: integer;
  var UpToValue: integer): TColor;
   {
    等间距云图颜色配比
  }
var
   ContourColor : array [0..15] of TColor;
begin
    ContourColor[0]:=clwhite;    ContourColor[1]:=clInfoBk;   {白  淡黄}
    ContourColor[2]:=ClYellow;    ContourColor[3]:=$00E500;   {黄  浅绿}
    ContourColor[4]:=$0C8918;    ContourColor[5]:=clBlue;   {深绿  深蓝}
    ContourColor[6]:=$0080FF;    ContourColor[7]:=ClFuchsia;   {橙红 绯红 }
    ContourColor[8]:=$0000FF;    ContourColor[9]:=$000080;   { 红 深红}

   if NumLevel<=3 then  begin
       if Xh=0 then  begin
          Result:= ContourColor[0];  {白}
          UpToValue:=30;
       end else if Xh=1 then  begin
          Result:= ContourColor[4];
          UpToValue:=45;
       end else   begin
          Result:= ContourColor[8];
          UpToValue:=60;
       end ;

   end else if NumLevel<=4  then  begin
       if Xh=0 then  begin
          Result:= ContourColor[0];
          UpToValue:=30;
       end else if Xh=1 then  begin
          Result:= ContourColor[4];
          UpToValue:=40;
       end else if Xh=2 then  begin
          Result:= ContourColor[8];
          UpToValue:=50;
       end else begin
          Result:= ContourColor[2];
          UpToValue:=60;
       end
   end else if NumLevel<=5  then  begin
       if Xh=0 then  begin
          Result:= ContourColor[0];
          UpToValue:=30;
       end else if Xh=1 then  begin
          Result:= ContourColor[3];
          UpToValue:=37;
       end else if Xh=2 then  begin
          Result:= ContourColor[4];
          UpToValue:=44;
       end else if Xh=3 then  begin
          Result:= ContourColor[8];
          UpToValue:=51;
       end else begin
          Result:= ContourColor[2];
          UpToValue:=60;
       end ;

   end else if NumLevel<=6  then  begin
       if Xh=0 then  begin
          Result:= ContourColor[0];
          UpToValue:=30;
       end else if Xh=1 then  begin
          Result:= ContourColor[3];
          UpToValue:=36;
       end else if Xh=2 then  begin
          Result:= ContourColor[4];
          UpToValue:=42;
       end else if Xh=3 then  begin
          Result:= ContourColor[6];
          UpToValue:=48;
       end else if Xh=4 then  begin
          Result:= ContourColor[8];
          UpToValue:=54;
       end else  begin
          Result:= ContourColor[2];
          UpToValue:=60;
       end ;

   end else if NumLevel<=7  then  begin
       if Xh=0 then  begin
          Result:= ContourColor[0];
          UpToValue:=30;
       end else if Xh=1 then  begin
          Result:= ContourColor[4];
          UpToValue:=35;
       end else if Xh=2 then  begin
          Result:= ContourColor[5];
          UpToValue:=40;
       end else if Xh=3 then  begin
          Result:= ContourColor[6];
          UpToValue:=45;
       end else if Xh=4 then  begin
          Result:= ContourColor[7];
          UpToValue:=50;
       end else if Xh=5 then  begin
          Result:= ContourColor[8];
          UpToValue:=55;
       end else  begin
          Result:= ContourColor[2];
          UpToValue:=60;
       end ;

   end else if NumLevel<=8  then  begin
       if Xh=0 then  begin
          Result:= ContourColor[0];
          UpToValue:=30;
       end else if Xh=1 then  begin
          Result:= ContourColor[3];
          UpToValue:=34;
       end else if Xh=2 then  begin
          Result:= ContourColor[4];
          UpToValue:=38;
       end else if Xh=3 then  begin
          Result:= ContourColor[5];
          UpToValue:=42;
       end else if Xh=4 then  begin
          Result:= ContourColor[6];
          UpToValue:=46;
       end else if Xh=5 then  begin
          Result:= ContourColor[7];
          UpToValue:=50;
       end else if Xh=6 then  begin
          Result:= ContourColor[8];
          UpToValue:=54;
       end else  begin
          Result:= ContourColor[2];
          UpToValue:=60;
       end ;
   end else if NumLevel<=9  then  begin
       if Xh=0 then  begin
          Result:= ContourColor[0];
          UpToValue:=28;
       end else if Xh=1 then  begin
          Result:= ContourColor[2];
          UpToValue:=32;
       end else if Xh=2 then  begin
          Result:= ContourColor[3];
          UpToValue:=36;
       end else if Xh=3 then  begin
          Result:= ContourColor[4];
          UpToValue:=40;
       end else if Xh=4 then  begin
          Result:= ContourColor[5];
          UpToValue:=44;
       end else if Xh=5 then  begin
          Result:= ContourColor[6];
          UpToValue:=48;
       end else if Xh=6 then  begin
          Result:= ContourColor[7];
          UpToValue:=52;
       end else if Xh=7 then  begin
          Result:= ContourColor[8];
          UpToValue:=56;
       end else  begin
          Result:= ContourColor[9];
          UpToValue:=60;
       end ;
   end else begin
       if Xh=0 then  begin
          Result:= ContourColor[0];
          UpToValue:=28;
       end else if Xh=1 then  begin
          Result:= ContourColor[1];
          UpToValue:=31;
       end else if Xh=2 then  begin
          Result:= ContourColor[2];
          UpToValue:=34;
       end else if Xh=3 then  begin
          Result:= ContourColor[3];
          UpToValue:=37;
       end else if Xh=4 then  begin
          Result:= ContourColor[4];
          UpToValue:=40;
       end else if Xh=5 then  begin
          Result:= ContourColor[5];
          UpToValue:=43;
       end else if Xh=6 then  begin
          Result:= ContourColor[6];
          UpToValue:=47;
       end else if Xh=7 then  begin
          Result:= ContourColor[7];
          UpToValue:=50;
       end else if Xh=8 then  begin
          Result:= ContourColor[8];
          UpToValue:=53;
       end else  begin
          Result:= ContourColor[9];
          UpToValue:=60;
       end ;
   end;


end;

function TDrawGrap.GetContourColor_optimization(NumLevel, Xh: integer;
  var UpToValue: integer): TColor;
  {
    优化的云图颜色配比
  }
var
   ContourColor : array [0..15] of TColor;
begin
    ContourColor[0]:=clwhite;    ContourColor[1]:=clInfoBk;   {白  淡黄}
    ContourColor[2]:=ClYellow;    ContourColor[3]:=$00E500;   {黄  浅绿}
    ContourColor[4]:=$0C8918;    ContourColor[5]:=clBlue;   {深绿  深蓝}
    ContourColor[6]:=$0080FF;    ContourColor[7]:=ClFuchsia;   {橙红 绯红 }
    ContourColor[8]:=$0000FF;    ContourColor[9]:=$000080;   { 红 深红}

   if NumLevel<=3 then  begin
       if Xh=0 then  begin
          Result:= ContourColor[0];  {白}
          UpToValue:=30;
       end else if Xh=1 then  begin
          Result:= ContourColor[4];
          UpToValue:=40;
       end else   begin
          Result:= ContourColor[8];
          UpToValue:=60;
       end ;

   end else if NumLevel<=4  then  begin
       if Xh=0 then  begin
          Result:= ContourColor[0];
          UpToValue:=30;
       end else if Xh=1 then  begin
          Result:= ContourColor[4];
          UpToValue:=40;
       end else if Xh=2 then  begin
          Result:= ContourColor[8];
          UpToValue:=50;
       end else begin
          Result:= ContourColor[2];
          UpToValue:=60;
       end
   end else if NumLevel<=5  then  begin
       if Xh=0 then  begin
          Result:= ContourColor[0];
          UpToValue:=30;
       end else if Xh=1 then  begin
          Result:= ContourColor[3];
          UpToValue:=35;
       end else if Xh=2 then  begin
          Result:= ContourColor[4];
          UpToValue:=40;
       end else if Xh=3 then  begin
          Result:= ContourColor[8];
          UpToValue:=50;
       end else begin
          Result:= ContourColor[2];
          UpToValue:=60;
       end ;

   end else if NumLevel<=6  then  begin
       if Xh=0 then  begin
          Result:= ContourColor[0];
          UpToValue:=30;
       end else if Xh=1 then  begin
          Result:= ContourColor[3];
          UpToValue:=35;
       end else if Xh=2 then  begin
          Result:= ContourColor[4];
          UpToValue:=38;
       end else if Xh=3 then  begin
          Result:= ContourColor[6];
          UpToValue:=40;
       end else if Xh=4 then  begin
          Result:= ContourColor[8];
          UpToValue:=50;
       end else  begin
          Result:= ContourColor[2];
          UpToValue:=60;
       end ;

   end else if NumLevel<=7  then  begin
       if Xh=0 then  begin
          Result:= ContourColor[0];
          UpToValue:=30;
       end else if Xh=1 then  begin
          Result:= ContourColor[4];
          UpToValue:=35;
       end else if Xh=2 then  begin
          Result:= ContourColor[5];
          UpToValue:=37;
       end else if Xh=3 then  begin
          Result:= ContourColor[6];
          UpToValue:=39;
       end else if Xh=4 then  begin
          Result:= ContourColor[7];
          UpToValue:=41;
       end else if Xh=5 then  begin
          Result:= ContourColor[8];
          UpToValue:=50;
       end else  begin
          Result:= ContourColor[2];
          UpToValue:=60;
       end ;

   end else if NumLevel<=8  then  begin
       if Xh=0 then  begin
          Result:= ContourColor[0];
          UpToValue:=30;
       end else if Xh=1 then  begin
          Result:= ContourColor[3];
          UpToValue:=34;
       end else if Xh=2 then  begin
          Result:= ContourColor[4];
          UpToValue:=36;
       end else if Xh=3 then  begin
          Result:= ContourColor[5];
          UpToValue:=38;
       end else if Xh=4 then  begin
          Result:= ContourColor[6];
          UpToValue:=40;
       end else if Xh=5 then  begin
          Result:= ContourColor[7];
          UpToValue:=42;
       end else if Xh=6 then  begin
          Result:= ContourColor[8];
          UpToValue:=50;
       end else  begin
          Result:= ContourColor[2];
          UpToValue:=60;
       end ;
   end else if NumLevel<=9  then  begin
       if Xh=0 then  begin
          Result:= ContourColor[0];
          UpToValue:=30;
       end else if Xh=1 then  begin
          Result:= ContourColor[2];
          UpToValue:=33;
       end else if Xh=2 then  begin
          Result:= ContourColor[3];
          UpToValue:=35;
       end else if Xh=3 then  begin
          Result:= ContourColor[4];
          UpToValue:=37;
       end else if Xh=4 then  begin
          Result:= ContourColor[5];
          UpToValue:=39;
       end else if Xh=5 then  begin
          Result:= ContourColor[6];
          UpToValue:=41;
       end else if Xh=6 then  begin
          Result:= ContourColor[7];
          UpToValue:=43;
       end else if Xh=7 then  begin
          Result:= ContourColor[8];
          UpToValue:=50;
       end else  begin
          Result:= ContourColor[9];
          UpToValue:=60;
       end ;
   end else begin
       if Xh=0 then  begin
          Result:= ContourColor[0];
          UpToValue:=30;
       end else if Xh=1 then  begin
          Result:= ContourColor[1];
          UpToValue:=33;
       end else if Xh=2 then  begin
          Result:= ContourColor[2];
          UpToValue:=35;
       end else if Xh=3 then  begin
          Result:= ContourColor[3];
          UpToValue:=37;
       end else if Xh=4 then  begin
          Result:= ContourColor[4];
          UpToValue:=38;
       end else if Xh=5 then  begin
          Result:= ContourColor[5];
          UpToValue:=39;
       end else if Xh=6 then  begin
          Result:= ContourColor[6];
          UpToValue:=40;
       end else if Xh=7 then  begin
          Result:= ContourColor[7];
          UpToValue:=42;
       end else if Xh=8 then  begin
          Result:= ContourColor[8];
          UpToValue:=50;
       end else  begin
          Result:= ContourColor[9];
          UpToValue:=60;
       end ;
   end;


end;

function TDrawGrap.GetCycleData(GzmBh, Datatype: string; StDate,
  EndDate: TdateTime;PB:TProgressBar): Boolean;
var
  Sql:String;
  sw1:TStopWatch;
  elapsedMilliseconds : cardinal;
  CNum:integer;
begin
    Result:=false;
    ClearMyGrid;
    sw1:=TStopWatch.Create;
try
    PB.Min :=0;

    Sql:= 'select Supportbh,startTime,Endtime,footage,Max_Value,AGV_Cycle_Value,SupportBeforeMovePress,SupportStartPress from  ' +
       'D_'+ GzmBh+'_SecondDp where TypeData= '''+ Datatype +''' and startTime >= ''' +FormatDateTime( 'yyyy-mm-dd hh:nn:ss',StDate )  +
       ''' and EndTime <= ''' +FormatDateTime( 'yyyy-mm-dd hh:nn:ss',EndDate )  + ''' '+
       ' order by SupportBh ,StartTime ' ;
    MySqlDataSet1.Close;
    MySqlDataSet1.CommandText :=sql;
    MySqlDataSet1.Open ;
    if MySqlDataSet1.RecordCount < (FGzm.SupEndUsedNumber -  FGzm.SupStartNumber +1)  then  begin
       MySqlDataSet1.Close ;exit;
    end else begin
       SecondDPDataNumber:= MySqlDataSet1.RecordCount;
    end;
    Setlength(MyGrid,SecondDPDataNumber);
    PB.Max:=SecondDPDataNumber;
    PB.Position:=0;
    PB.Step :=1;
    CNum:=0;
    while not MySqlDataSet1.Eof  do  begin
      // sw1.Start ;
       if(MySqlDataSet1.FieldByName('SupportBh').AsInteger > 0) then begin
             MyGrid[CNum].SupportBH :=MySqlDataSet1.FieldByName('SupportBh').AsInteger ;
             MyGrid[CNum].StartTime :=MySqlDataSet1.FieldByName('StartTime').AsDateTime ;
             MyGrid[CNum].EndTime :=MySqlDataSet1.FieldByName('endTime').AsDateTime ;
             MyGrid[CNum].footage  :=MySqlDataSet1.FieldByName('footage').AsFloat  ;
             MyGrid[CNum].MaxValue  :=MySqlDataSet1.FieldByName('Max_Value').AsFloat  ;
             MyGrid[CNum].AVGValue  :=MySqlDataSet1.FieldByName('AGV_Cycle_Value').AsFloat  ;
             MyGrid[CNum].StartValue   :=MySqlDataSet1.FieldByName('SupportStartPress').AsFloat  ;
             MyGrid[CNum].LastValue   :=MySqlDataSet1.FieldByName('SupportBeforeMovePress').AsFloat  ;

             CNum:=CNum+1;
       end;
       MySqlDataSet1.Next ;
       PB.StepIt ;
      // sw1.Stop ;
      // elapsedMilliseconds:=sw1.ElapsedMilliseconds;
    end;
   MySqlDataSet1.Close;
   PB.Position :=pb.Max ;
   Result:=True;

except
   exit;
end;
end;


function TDrawGrap.GetImagePointData(x1, y1, x2, y2: integer): TSelectImageGrid;
var
  ResultPoint:TSelectImageGrid;
begin
   ResultPoint.StartSupbh :=-1;
   if  (x1 < TwoDimCloud.X_pix_start ) or (x1 > TwoDimCloud.X_pix_end)   or
       (y1 < TwoDimCloud.Y_pix_start ) or (y1 > TwoDimCloud.Y_pix_end ) then  exit;

   ResultPoint.StartTime :=(x1-TwoDimCloud.X_pix_start)/TwoDimCloud.X_Bl+self.DataTimeAndFootAge.StartTime;
   ResultPoint.StartSupbh:=Round((TwoDimCloud.Y_pix_end-Y1)/TwoDimCloud.Y_Bl);
   Result:= ResultPoint;
end;

function TDrawGrap.GetManualInputPressData(GzmBh: string; MinDao,MaxDao: integer; PB: TProgressBar): Boolean;
var
  Sql:String;
  elapsedMilliseconds : cardinal;
  Daoshu,sup,i,j:integer;
  MyTmp:TContourRecord;
  Upper_Footage:double;
  FieldString:String;
begin
    Result:=false;
    Daoshu:=0;sup:=0;
    {
       SetLength(MyContourGrid,1);
      ContourRecordNumber:=0; Graph_MinDao,Graph_MaxDao
    }
    try
        PB.Min :=0;
        // 给进尺的数组赋值
        ClearFilledContourData;
        FilledContourDataNumber := Round( MaxDao+
                                   DataTimeAndFootAge.ForCaseDay*FGzm.RockPressAnalysis.OneDao_step)+20;
        //控制列数
        setlength(FilledContourData,FilledContourDataNumber) ;
        setlength(MyContourDoubleGrid,FilledContourDataNumber);
        for I := 0 to FilledContourDataNumber-1 do  begin
            setlength(MyContourDoubleGrid[i],FGzm.SupEndNumber+10);
            for j := 0 to FGzm.SupEndNumber+9 do  begin
             { 1 是代表 实际数据 0 是代表插值数据}
                 MyContourDoubleGrid[i][j].DataType:=0;   //
                 MyContourDoubleGrid[i][j].SmoothData:=-1;
             end
         end;

        FieldString:=Fgzm.ReturnManualInputPressDataField(Ord(CloudClass.Yuntu_CycleData));
        //------
        Result:=true;

        Sql:= 'select * from  D_'+ GzmBh+'_ManualInputPressData where Daoshu >= ' +IntToStr(MinDao) +
           ' and DaoShu <= ' +IntTostr(MaxDao ) +
           ' order by Daoshu,Supportbh' ;
        MySqlDataSet1.Close;
        MySqlDataSet1.CommandText :=sql;
        MySqlDataSet1.Open ;
        if MySqlDataSet1.RecordCount < (FGzm.SupEndUsedNumber -  FGzm.SupStartNumber +1)  then  begin
           MySqlDataSet1.Close ;exit;

        end;
        PB.Max:=MySqlDataSet1.RecordCount;
        PB.Position:=0;
        PB.Step :=1;

        while not MySqlDataSet1.Eof  do  begin
          // sw1.Start ;
           if(MySqlDataSet1.FieldByName('SupportBh').AsInteger > 0) then begin
                 MyTmp.SupportBH :=MySqlDataSet1.FieldByName('SupportBh').AsInteger ;
                 MyTmp.Daoshu  :=MySqlDataSet1.FieldByName('Daoshu').AsInteger ;
                 MyTmp.generatetime  :=MySqlDataSet1.FieldByName('generatetime').AsDateTime ;
                 MyTmp.footage  :=Fgzm.ReturnBalanceFootage(MyTmp.Daoshu,MyTmp.SupportBH) ;
                 MyTmp.Max_Value  :=MySqlDataSet1.FieldByName('Max_Value').AsFloat  ;
                 MyTmp.AGV_Value  :=MySqlDataSet1.FieldByName('AGV_Value').AsFloat  ;
                 MyTmp.CCL_Value  :=MySqlDataSet1.FieldByName('CCL_Value').AsFloat  ;
                 MyTmp.MZL_Value  :=MySqlDataSet1.FieldByName('MzL_Value').AsFloat  ;
                 MyTmp.Same_Value  :=MySqlDataSet1.FieldByName('Same_Value').AsFloat  ;
                 MyTmp.Manual_Value  :=MySqlDataSet1.FieldByName('PressData').AsFloat  ;

                 MyTmp.DataType :=1;
                 if Daoshu<>MyTmp.Daoshu then  begin
                    Daoshu:=MyTmp.Daoshu ;
                    Sup:=MyTmp.supportbh;
                    MyContourDoubleGrid[Daoshu][Sup]:= MyTmp;
                    if not Fgzm.ReturnUpperAndDownFootage(Daoshu,FilledContourData[Daoshu].Down_footage,
                                FilledContourData[Daoshu].Upper_Footage)  then begin
                       FilledContourData[Daoshu].Upper_Footage:= MyTmp.footage ;
                       FilledContourData[Daoshu].Down_footage:= MyTmp.footage ;
                    end;
                    FilledContourData[Daoshu].DT:= MyTmp.generatetime ;
                    FilledContourData[Daoshu].Daoshu:= Daoshu;
                 end else begin
                    Sup:=MyTmp.supportbh;
                    MyContourDoubleGrid[Daoshu][Sup]:= MyTmp;

                 end;
           end;
           MySqlDataSet1.Next ;
           PB.StepIt ;

        end;
       MySqlDataSet1.Close;
       PB.Position :=pb.Max ;
       Result:=True;

    except
       exit;
    end;


end;

function TDrawGrap.GetMyCoutOurColorUpToValue(Number: integer;
  UPToValue: Double;var D_Value:Double): Integer;
var
  i:integer;
  tmp,tmp2:double;
begin
   Result:=-1;
   if Number>10   then exit;
   tmp:=0;
   for I := 0 to Number-1 do
        if UpToValue >=MyContourColor[i].UpToValue  then begin
           tmp:=UpToValue-MyContourColor[i].UpToValue;
        end else begin
             tmp2:= MyContourColor[i].UpToValue-UpToValue ;
             if tmp2 > tmp then   D_Value:=tmp
                else  D_Value:=tmp2;
             Result:=1;
             break;

        end;

end;

function TDrawGrap.GetStepJudgeLevel(CycleType: integer): Double;
begin
    Result:=inn_Judge_Step[CycleType].UsedLevelLineValue;
end;

function TDrawGrap.GetStepJudgeRatio(CycleType: integer): Double;
begin
   Result:=inn_Judge_Step[CycleType].UsedJudgeStep_Ratio;
end;

function TDrawGrap.GetManualInputPressData(GzmBh:string;StDate,EndDate:TdateTime;PB:TProgressBar): Boolean;
begin
    Result:=false;

    try
        PB.Min :=0;
        DataTimeAndFootAge.Graph_MaxDao:=FGzm.ReturnDaoShuBasicTime(EndDate);
        DataTimeAndFootAge.Graph_MinDao:=FGzm.ReturnDaoShuBasicTime(StDate);
        Result:=GetManualInputPressData(GzmBh,DataTimeAndFootAge.Graph_MinDao,
                               DataTimeAndFootAge.Graph_MaxDao,
                               PB);
     except
       exit;
    end;

end;

function TDrawGrap.GetThirdDPThreeDimData(GzmBh, Datatype: string; StDate,
  EndDate: TdateTime; PB: TProgressBar): Boolean;
var
  Sql:String;
  sw1:TStopWatch;
  elapsedMilliseconds : cardinal;
  CNum:integer;
begin
    Result:=false;
    //clear  MyThirdGrid
    setlength(MyThirdGrid,1);
    ThirdDPDataNumber:=1;
    sw1:=TStopWatch.Create;
try
    PB.Min :=0;

    Sql:= 'select phaseNumber,startbh,endbh,supNumber,Maxdata,AGVData,MaxWeightSup,supstring, ' +
          ' Phase_startTime,phase_Endtime,Start_footage,End_Footage,AGVMovePress from  ' +
          'D_'+ GzmBh+'_thirdDp where TypeData= '''+ Datatype +''' and Phase_startTime >= ''' +FormatDateTime( 'yyyy-mm-dd hh:nn:ss',StDate )  +
          ''' and phase_Endtime <= ''' +FormatDateTime( 'yyyy-mm-dd hh:nn:ss',EndDate )  + ''' '+
          ' order by phaseNumber ,GenerateTime ' ;
    MySqlDataSet1.Close;
    MySqlDataSet1.CommandText :=sql;
    MySqlDataSet1.Open ;
    if MySqlDataSet1.RecordCount < 9 then  begin
       MySqlDataSet1.Close ;exit;
    end else begin
       ThirdDPDataNumber:= MySqlDataSet1.RecordCount;
    end;
    Setlength(MyThirdGrid,ThirdDPDataNumber);
    PB.Max:=ThirdDPDataNumber;
    PB.Position:=0;
    PB.Step :=1;
    CNum:=0;
    while not MySqlDataSet1.Eof  do  begin
      // sw1.Start ;
       if(MySqlDataSet1.FieldByName('phaseNumber').AsInteger > 0) then begin
          MyThirdGrid[CNum].phaseNumber :=MySqlDataSet1.FieldByName('phaseNumber').AsInteger;
          MyThirdGrid[CNum].MaxValueSupNumber :=MySqlDataSet1.FieldByName('MaxWeightSup').AsInteger;
          MyThirdGrid[CNum].startSup :=MySqlDataSet1.FieldByName('startbh').AsInteger;
          MyThirdGrid[CNum].endSup:=MySqlDataSet1.FieldByName('endbh').AsInteger;
          MyThirdGrid[CNum].SupNumber :=MySqlDataSet1.FieldByName('supNumber').AsInteger;
          MyThirdGrid[CNum].StartFootage :=MySqlDataSet1.FieldByName('Start_footage').AsFloat;
          MyThirdGrid[CNum].EndFootage :=MySqlDataSet1.FieldByName('End_Footage').AsFloat;
          MyThirdGrid[CNum].MaxData :=MySqlDataSet1.FieldByName('Maxdata').AsFloat;
          MyThirdGrid[CNum].AGVData :=MySqlDataSet1.FieldByName('AGVData').AsFloat;
          MyThirdGrid[CNum].MzlData :=MySqlDataSet1.FieldByName('AGVMovePress').AsFloat;
          MyThirdGrid[CNum].StartTime :=MySqlDataSet1.FieldByName('Phase_startTime').AsDateTime;
          MyThirdGrid[CNum].endTime :=MySqlDataSet1.FieldByName('phase_Endtime').AsDateTime;
          MyThirdGrid[CNum].SupportBh_list:=MySqlDataSet1.FieldByName('supstring').AsString;
          MyThirdGrid[CNum].Midsup:=MyThirdGrid[CNum].startSup+ MyThirdGrid[CNum].SupNumber div 2;

          CNum:=CNum+1;
       end;
       MySqlDataSet1.Next ;
       PB.StepIt ;
      // sw1.Stop ;
      // elapsedMilliseconds:=sw1.ElapsedMilliseconds;
    end;
   MySqlDataSet1.Close;
   PB.Position :=pb.Max ;
   Result:=True;

except
   exit;
end;

end;

function TDrawGrap.GetYunColorType: integer;
begin
    Result:=UsedYunTuColorTypeId;
end;

function TDrawGrap.InitCloud_TwoDim_Image(image: Timage) :Boolean;
begin
    //clear Image
   // image.Picture.Graphic.assign(nil);
    Result:=False;
    TwoDimCloud.ForCaseDay:=2;
    image.Picture.Graphic:=nil;
    image.Canvas.Refresh;
    image.Canvas.FillRect(image.ClientRect);

    TwoDimCloud.BmpWidth :=image.Width ;
    TwoDimCloud.BmpHeigth:=image.Height ;
    TwoDimCloud.LeftBlank:=Round(TwoDimCloud.BmpWidth/40*3);
    TwoDimCloud.RightBlank:=round(TwoDimCloud.BmpWidth/40*4);
    TwoDimCloud.TopBlank :=Round(TwoDimCloud.BmpHeigth /18*6);
    TwoDimCloud.BottomBlank :=round(TwoDimCloud.BmpHeigth /18*6);
    TwoDimCloud.X_pix_start :=TwoDimCloud.LeftBlank ;
    TwoDimCloud.X_pix_end :=TwoDimCloud.BmpWidth -TwoDimCloud.RightBlank ;
    TwoDimCloud.pic_width := TwoDimCloud.X_pix_end -TwoDimCloud.X_pix_start ;
    TwoDimCloud.Y_pix_start :=TwoDimCloud.TopBlank ;
    TwoDimCloud.Y_pix_end :=TwoDimCloud.BmpHeigth -TwoDimCloud.BottomBlank ;
    TwoDimCloud.pic_heigth :=TwoDimCloud.Y_pix_end -TwoDimCloud.Y_pix_start ;
    //字号
    TwoDimCloud.titleSize:=14;
    TwoDimCloud.TextSize:=9;
    if TwoDimCloud.TopBlank >80 then   begin
       TwoDimCloud.titleSize:=TwoDimCloud.titleSize+Trunc((TwoDimCloud.TopBlank-80)/20);
       TwoDimCloud.TextSize:=TwoDimCloud.TextSize+Trunc((TwoDimCloud.TopBlank-80)/30);
    end;
      //计算二维比例   X 方向做出2天的预留量

    TwoDimCloud.X_Bl :=TwoDimCloud.pic_width/(self.DataTimeAndFootAge.TimeLength+TwoDimCloud.ForCaseDay);
    TwoDimCloud.Y_Bl :=TwoDimCloud.pic_heigth /(Fgzm.SupEndUsedNumber-Fgzm.SupStartNumber+1 );

    // 画外框
    image.Canvas.Pen.Color :=clBlack;
    image.Canvas.Pen.Style :=psSolid;
    image.Canvas.Rectangle(TwoDimCloud.X_pix_start,TwoDimCloud.Y_pix_start ,
                           TwoDimCloud.X_pix_end ,TwoDimCloud.Y_pix_end );

   Result:=true;
end;
procedure TDrawGrap.InitDoubleMyline;
begin
     new(itsLine);
     firstLine:=itsLine ;
     new(firstLine^.next);
     lastLine:=firstLine^.next;
     lastLine^.next:=nil;

end;

// ==========================
type
   TMark = record
      loc, r,g,b : integer;
   end;

function TDrawGrap.initMYColors(CValue:TColorValue):Boolean;
const
   NUM_MARK = 3;
var
   Marks: array [1..NUM_MARK] of TMark;
   i,j,d:integer;
   r,g,b:integer;
   Min_V,AGV_V,Max_V:integer;
begin
   Result:=false;
   Min_V:=Round(CValue.MinValue);
   Max_V:=Round(CValue.MaxValue)*2;
   AGV_V:=Round((Max_V+ Min_V)/2);
   if Min_V >8 then  Min_V:=8;

   if Max_V > 200 then  exit;
   Marks[1].loc := Min_V;
         Marks[1].r :=0;Marks[1].g :=0;Marks[1].b :=255;
   Marks[2].loc := AGV_V;
         Marks[2].r :=0;Marks[2].g :=255;Marks[2].b :=0;
   Marks[3].loc := Max_V;
         Marks[3].r :=255;Marks[3].g :=0;Marks[3].b :=0;

     for i := 1 to NUM_MARK-1 do begin
        d := Marks[i+1].loc - Marks[i].loc;
      for j := 0 to d-1 do begin
         r := Marks[i].r + (Marks[i+1].r - Marks[i].r) * j div d;
         g := Marks[i].g + (Marks[i+1].g - Marks[i].g) * j div d;
         b := Marks[i].b + (Marks[i+1].b - Marks[i].b) * j div d;
         MYColors[Marks[i].loc + j] := RGB(r,g,b);
      end;
   end;
   MYColors[199]:=RGB(255,0,0);
   Result:=true;
end;

procedure TDrawGrap.InitThreeDimChart(Chart: TChart;series:TSurfaceSeries);
var
 Caption:String;
begin

    //Chart.ClearChart ;
    series.Clear;
    Chart.Chart3DPercent:=80;
    Chart.Aspect.Orthogonal:=False;
    Chart.Aspect.Zoom:=80;

    //  Chart.Legend.Visible:=False;

    Chart.LeftWall.Visible :=false;
    Chart.BackWall.Visible :=false;

    // 初始化字体
    ThreeDimCloud.titleSize:=14;
    ThreeDimCloud.TextSize:=9;

    Chart.SubTitle.Font.Color :=ClBlack;
    Caption:=jituan_name+'/'+Mk_Name + '/' + FGzm.S_Name +'工作面三维压力云图' ;
    Chart.Title.TextAlignment:=taCenter;
    Chart.Title.Font.Name :='黑体';
    Chart.Title.Font.Size :=ThreeDimCloud.titleSize;
    Chart.Title.Caption := Caption;

    Chart.SubTitle.Font.Color :=ClBlue;
    Chart.SubTitle.TextAlignment:=taCenter;
    Chart.SubTitle.Font.Name :='宋体';
    Chart.SubTitle.Font.Size :=ThreeDimCloud.TextSize;

    Caption:='起止日期:'+FormatDateTime('yyyy-mm-dd hh:nn ',self.DataTimeAndFootAge.StartTime)
                            +'('+FormatFloat('0.00',DataTimeAndFootAge.Minfootage)+  '米)--' +
                             FormatDateTime('yyyy-mm-dd hh:nn ',self.DataTimeAndFootAge.EndTime) +
                             '('+FormatFloat('0.00',DataTimeAndFootAge.MAXfootage)+  '米)';
    Caption:='【'+CloudClass.YunTu_DataType_Name+':'+CloudClass.Yuntu_Data_Name +'】'+Caption;
    Chart.SubTitle.Caption := Caption;
    Chart.SubTitle.Font.Color :=ClBlack;
end;

function TDrawGrap.Inverse_Distance_Contour(p0, p1, p2, p3,
  p4: TContourRecord): TContourRecord;
var
  D_i,W_i :Array [0..3] of double;
  D_s:double;
  i:integer;
begin
     d_i[0]:=sqrt(sqr(p1.footage-p0.footage)+sqr(p1.supportbh -p0.supportbh));
     d_i[1]:=sqrt(sqr(p2.footage-p0.footage)+sqr(p2.supportbh -p0.supportbh));
     d_i[2]:=sqrt(sqr(p3.footage-p0.footage)+sqr(p3.supportbh -p0.supportbh));
     d_i[3]:=sqrt(sqr(p4.footage-p0.footage)+sqr(p4.supportbh -p0.supportbh));
     D_s:=0;
     for I := 0 to 3 do
       if d_i[i]>0 then  D_s:=D_s+1/d_i[i];

     if D_s=0 then D_s:=1;
     for I := 0 to 3 do begin
         if d_i[i]>0 then  begin
            W_i[i]:=1/d_i[i]/D_s;
         end  else  begin
            W_i[i]:=0;
         end;
     end;

    P0.UseData:=p1.UseData * w_i[0]+  p2.UseData * w_i[1]  + p3.UseData * w_i[2] +  p4.UseData * w_i[3];


    Result:=P0;

end;

function TDrawGrap.Inverse_Distance_Powe(p0,p1,p2,p3,p4:TDisposeGrid): TDisposeGrid;
var
  D_i,W_i :Array [0..3] of double;
  D_s:double;
  i:integer;
begin
     d_i[0]:=sqrt(sqr(p1.x-p0.x)+sqr(p1.Y -p0.Y));
     d_i[1]:=sqrt(sqr(p2.X-p0.x)+sqr(p2.Y -p0.Y));
     d_i[2]:=sqrt(sqr(p3.X-p0.x)+sqr(p3.Y -p0.Y));
     d_i[3]:=sqrt(sqr(p4.X-p0.x)+sqr(p4.Y -p0.Y));
     D_s:=0;
     for I := 0 to 3 do
       if d_i[i]>0 then  D_s:=D_s+1/d_i[i];

     if D_s=0 then D_s:=1;
     for I := 0 to 3 do begin
         if d_i[i]>0 then  begin
            W_i[i]:=1/d_i[i]/D_s;
         end  else  begin
            W_i[i]:=0;
         end;
     end;

    P0.MaxData:=p1.MaxData * w_i[0]+  p2.MaxData * w_i[1]  + p3.MaxData * w_i[2] +  p4.MaxData * w_i[3];
    P0.MzlData:=p1.MzlData * w_i[0]+  p2.MzlData * w_i[1]  + p3.MzlData * w_i[2] +  p4.MzlData * w_i[3];
    P0.AGVData:=p1.AGVData * w_i[0]+  p2.AGVData * w_i[1]  + p3.AGVData * w_i[2] +  p4.AGVData * w_i[3];

    Result:=P0;
end;

function TDrawGrap.IsPtInPoly(ALon, ALat: double;
  APoints: array of TPoint): Boolean;
  {*------------------------------------------------------------------------------
  判断指定的经纬度坐标点是否落在指定的多边形区域内
  @param ALon   指定点的经度
  @param ALat   指定点的纬度
  @param APoints   指定多边形区域各个节点坐标
  @return True 落在范围内 False 不在范围内
------------------------------------------------------------------------------*}
var
  iSum, iCount, iIndex: Integer;
  dLon1, dLon2, dLat1, dLat2, dLon: double;
begin
    Result := False;
    if (Length(APoints) < 3) then    begin
        Result := False;
        Exit;
    end;
    iSum := 0;
    iCount := Length(APoints);
    for iIndex :=0 to iCount - 1 do    begin
      if (iIndex = iCount - 1) then   begin
        dLon1 := APoints[iIndex].X;
        dLat1 := APoints[iIndex].Y;
        dLon2 := APoints[0].X;
        dLat2 := APoints[0].Y;
      end   else    begin
        dLon1 := APoints[iIndex].X;
        dLat1 := APoints[iIndex].Y;
        dLon2 := APoints[iIndex + 1].X;
        dLat2 := APoints[iIndex + 1].Y;
      end;

      if ((ALat >= dLat1) and (ALat < dLat2)) or ((ALat>=dLat2) and (ALat < dLat1)) then     begin
        if (abs(dLat1 - dLat2) > 0) then     begin
          dLon := dLon1 - ((dLon1 -dLon2) * (dLat1 -ALat)) / (dLat1 - dLat2);
          if (dLon < ALon) then    Inc(iSum);
        end;
      end;

    end;

    if (iSum mod 2 <> 0) then
      Result := True;

end;

function TDrawGrap.Kriging(px: TKrigePoint;
         Arrypt: array of TKrigePoint;S_Count:integer): TKrigePoint;
var
  D_i,W_i :Array [0..20] of double;
  D_s:double;
  i:integer;
begin
     for I := 0 to S_Count-2 do
      d_i[i]:=sqrt(Arrypt[i+1].pt.x- Arrypt[i].pt.x) +sqr(sqrt(Arrypt[i+1].pt.y- Arrypt[i].pt.y));

     D_s:=0;
     for I := 0 to S_Count-2 do
       if d_i[i]>0 then  D_s:=D_s+1/d_i[i];

     if D_s=0 then D_s:=1;
     for I := 0 to S_Count-2 do begin
         if d_i[i]>0 then  begin
            W_i[i]:=1/d_i[i]/D_s;
         end  else  begin
            W_i[i]:=0;
         end;
     end;
    px.DataV :=0;
    for I := 0 to S_Count-2 do
        px.DataV :=px.DataV  + Arrypt[i].DataV *w_i[i];
    Result:=px;

end;

function TDrawGrap.Liner_Distance_Contour(p0, p1,
  p2: TContourRecord): TContourRecord;
var
  d01,d12:double;
begin
     d01:=sqrt(sqr(p1.footage-p0.footage)+sqr(p1.supportbh -p0.supportbh));
     d12:=sqrt(sqr(p1.footage-p2.footage)+sqr(p1.supportbh -p2.supportbh));
     p0.UseData:=P1.UseData +(p2.UseData -P1.UseData )*d01/d12;

     Result:=P0;
end;

function TDrawGrap.Liner_Distance_Powe(p0, p1, p2: TDisposeGrid): TDisposeGrid;
var
  d01,d12:double;
begin
     d01:=sqrt(sqr(p1.x-p0.x)+sqr(p1.Y -p0.Y));
     d12:=sqrt(sqr(p1.x-p2.x)+sqr(p1.Y -p2.Y));
     p0.MaxData:=P1.MaxData +(p2.MaxData -P1.MaxData )*d01/d12;
     p0.MzlData:=P1.MzlData +(p2.MzlData -P1.MzlData )*d01/d12;
     p0.AGVData:=P1.AGVData +(p2.AGVData -P1.AGVData )*d01/d12;
     Result:=P0;
end;

procedure TDrawGrap.LoadRockPressDataForConTour(Falg: integer);
var
   SecondPGBar: TProgressBar;
begin
    //读取手工录入数据
   SecondPGBar:=TProgressBar.Create(nil);;
   if SelectDataBasic_DaoOrFootage  =0 then  begin //以进刀为主进行查询
      if not GetManualInputPressData(intToStr(FGzm.Gzmbh),
                   DataTimeAndFootAge.Graph_MinDao, DataTimeAndFootAge.Graph_MaxDao,SecondPGBar) then
           exit;
   end else begin
      if not GetManualInputPressData(intToStr(FGzm.Gzmbh),
                   DataTimeAndFootAge.StartTime, DataTimeAndFootAge.EndTime,SecondPGBar) then
           exit;
   end;

   FreeAndNil(SecondPGBar);
end;

procedure TDrawGrap.MakeCloudCaption(image: Timage);
var
  Caption:String;
  TextH,TextW,Text_x,Text_y:integer;

begin
    image.Canvas.Font.Name :='楷体';
    image.Canvas.Font.Size :=TwoDimCloud.titleSize;
    Caption:=jituan_name+'【'+Mk_Name + '】' +FGzm.S_Name +'工作面二维压力云图' ;

     TextW:=image.Canvas.TextWidth(Caption);
     TextH:=image.Canvas.TextHeight(Caption) ;
     Text_x:=Round(TwoDimCloud.BmpWidth/2-TextW/2);
     Text_y:=Round(TwoDimCloud.TopBlank*3 /8);
     image.Canvas.TextOut(Text_x,Text_y ,Caption);
      //
      image.Canvas.Font.Name :='宋体';
      image.Canvas.Font.Size :=TwoDimCloud.TextSize;
      image.Canvas.Font.Color :=ClBlack;
      Caption:=CloudClass.YunTu_DataType_Name+'【'+CloudClass.Yuntu_Data_Name +'】';
      image.Canvas.TextOut(Round(TwoDimCloud.BmpWidth-TwoDimCloud.pic_width/20*4), Round(TwoDimCloud.TopBlank*5/8),Caption);
      Caption:='数据起止日期:'+FormatDateTime('yyyy-mm-dd hh:nn ',self.DataTimeAndFootAge.StartTime)
                              +'('+FormatFloat('0.00',DataTimeAndFootAge.Minfootage)+  '米)--' +
                               FormatDateTime('yyyy-mm-dd hh:nn ',self.DataTimeAndFootAge.EndTime) +
                               '('+FormatFloat('0.00',DataTimeAndFootAge.MAXfootage)+  '米)';
      image.Canvas.Font.Color :=ClBlue;
      TextW:=image.Canvas.TextWidth(Caption);
      Text_x:=Round(TwoDimCloud.BmpWidth/2-TextW/2);
      image.Canvas.TextOut(Text_x, Round(TwoDimCloud.TopBlank*5/8),Caption);
      image.Canvas.Font.Color:=clblack;

end;

procedure TDrawGrap.MakeContourChartCaption(Chart: Tchart;Series:TContourSeries);
var
 Caption:String;
 lowTime,highTime,InterValTime:integer;
 i:integer;
begin
    Chart.refresh;
    series.Clear;
     // 初始化字体
    ThreeDimCloud.titleSize:=14;
    ThreeDimCloud.TextSize:=9;

    Chart.Title.Font.Color :=ClBlack;

    Caption:=MainDataModule.Coal_Name+'煤矿【'+MainDataModule.WorkFace_Name +'工作面】实时矿压云图' ;

    Chart.Title.TextAlignment:=taCenter;
    Chart.Title.Font.Name :='黑体';
    Chart.Title.Font.Size :=ThreeDimCloud.titleSize;
    Chart.Title.Caption := Caption;

    Chart.SubTitle.Font.Color :=ClBlack;
    Chart.SubTitle.TextAlignment:=taCenter;
    Chart.SubTitle.Font.Name :='宋体';
    Chart.SubTitle.Font.Size :=ThreeDimCloud.TextSize;

    Caption:='起止日期:'+FormatDateTime('yyyy-mm-dd hh:nn ',self.DataTimeAndFootAge.StartTime)
                            +'('+FormatFloat('0.00',DataTimeAndFootAge.Minfootage)+  '米)--' +
                             FormatDateTime('yyyy-mm-dd hh:nn ',self.DataTimeAndFootAge.EndTime) +
                             '('+FormatFloat('0.00',DataTimeAndFootAge.MAXfootage)+  '米)';
    //Caption:='【'+CloudClass.YunTu_DataType_Name+':'+CloudClass.Yuntu_Data_Name +'】'+Caption;
    Caption:='【'+CloudClass.Yuntu_Data_Name +'】'+Caption;
    Chart.SubTitle.Caption := Caption;
    Chart.SubTitle.Font.Color :=ClBlack;
    // 图形边界
    Series.Pen.Visible :=true;
    Series.Pen.Width :=0;
    series.Filled :=true;
    // 网格的间隔
    series.IrregularGrid:=true;


    // 坐标轴
    Series.HorizAxis:=aBothHorizAxis ;
   // Chart.Legend.Visible :=false;
    Chart.BottomAxis.Visible :=true;
    //控制坐标横轴的显示方式
    if self.CloudClass.X_Axis_Disp_Type =0 then  begin
       Chart.BottomAxis.Automatic :=true;
       Chart.BottomAxis.SubAxes.Items[0].Automatic :=true;
       Chart.TopAxis.Automatic:=true;

    end else begin
       SetChartAxisMaxAndMinValue(Chart.BottomAxis,
                                 DataTimeAndFootAge.Graph_MinDao+CloudClass.X_Axis_Disp_Dao,
                                 DataTimeAndFootAge.Graph_MinDao
                                  );


       SetChartAxisMaxAndMinValue( Chart.TopAxis,
                                 DataTimeAndFootAge.Graph_MinDao+CloudClass.X_Axis_Disp_Dao,
                                 DataTimeAndFootAge.Graph_MinDao
                                  );


       SetChartAxisMaxAndMinValue(Chart.BottomAxis.SubAxes.Items[0],
                                 DataTimeAndFootAge.Graph_MinDao+CloudClass.X_Axis_Disp_Dao,
                                 DataTimeAndFootAge.Graph_MinDao
                                  );
        Chart.BottomAxis.Automatic :=false;
    end;
    Chart.BottomAxis.Title.Caption :='累计进刀数';
    Chart.BottomAxis.Title.Position  :=tpStart ;

    if self.ConTourSeriesPar.Display_DownFootage=1 then  begin
      Chart.BottomAxis.SubAxes.Items[0].Title.Caption:='累计进尺';
    end else begin
      Chart.BottomAxis.SubAxes.Items[0].Title.Caption:='开采时间';
    end;

      Chart.BottomAxis.SubAxes.Items[0].Title.Position:=tpEnd;
      Chart.BottomAxis.SubAxes.Items[0].Increment:=2;


    Chart.TopAxis.Visible :=true;
    if self.ConTourSeriesPar.Display_UpperFootage=1 then  begin
       Chart.TopAxis.Title.Caption:='累计进尺';
    end else begin
      Chart.TopAxis.Title.Caption:='开采时间';
    end;

    Chart.TopAxis.Title.Position  :=tpEnd ;

    Chart.LeftAxis.Title.Caption :='液压支架编号';
    Chart.LeftAxis.Title.Position  :=tpCenter ;
end;

procedure TDrawGrap.MakeGraphChartCaption(Chart: Tchart; Series: TLineSeries);
begin

end;

function TDrawGrap.MakeImageLegend(image:Timage): Boolean;
var
  i,TempColors:integer;
  P_F:Array [1..4] of TPoint;
begin
      // 下面是 画 云图图例
    image.Canvas.Pen.Style :=psClear;
    image.Canvas.Font.Color:=ClBlack;
    image.Canvas.TextOut(TwoDimCloud.X_pix_end+5,TwoDimCloud.Y_pix_end-10,FormatFloat('0',ColorValue.MinValue)+'MPA');
    for I := 0 to 7 do  begin
        P_F[1].X:=TwoDimCloud.X_pix_end +40; P_F[1].Y:=TwoDimCloud.Y_pix_end-Round(TwoDimCloud.pic_heigth/8*(i));
        P_F[2].X:=TwoDimCloud.X_pix_end +70; P_F[2].Y:=TwoDimCloud.Y_pix_end-Round(TwoDimCloud.pic_heigth/8*(i));
        P_F[3].X:=TwoDimCloud.X_pix_end +70; P_F[3].Y:=TwoDimCloud.Y_pix_end-Round(TwoDimCloud.pic_heigth/8*(i+1));
        P_F[4].X:=TwoDimCloud.X_pix_end +40; P_F[4].Y:=TwoDimCloud.Y_pix_end-Round(TwoDimCloud.pic_heigth/8*(i+1));

        TempColors:=Round(ColorValue.MinValue +(ColorValue.MaxValue- ColorValue.MinValue)/7*i);

        image.Canvas.TextOut(P_F[1].X-35,P_F[1].Y-10,IntToStr(TempColors)+'MPA');
        image.Canvas.Brush.Color :=ReturnMyColors(TempColors);
        image.Canvas.Polygon(P_F);
        image.Canvas.Brush.Style:=bsClear;
    end;
    image.Canvas.TextOut(TwoDimCloud.X_pix_end+5,TwoDimCloud.Y_pix_start,IntToStr(Round(ColorValue.MaxValue*1.2))+'MPA');

end;

procedure TDrawGrap.MakeThreeContourChartCaption(Chart: Tchart;
  Series: TCustom3DSeries);
var
 Caption:String;
 i:integer;
begin
   // Chart.Refresh;
    series.Clear;
    Chart.Chart3DPercent:=80;
    Chart.Aspect.Orthogonal:=False;
    Chart.Aspect.Zoom:=80;
    Chart.BackWall.Visible :=false;
    Chart.LeftWall.Visible :=false;
     // 初始化字体
    ThreeDimCloud.titleSize:=14;
    ThreeDimCloud.TextSize:=9;

    Chart.Title.Font.Color :=ClBlack;
    if jituan_name='' then    begin
       Caption:=jituan_name+':'+Mk_Name + '【' + FGzm.S_Name +'】工作面三维压力云图' ;
    end else begin
       Caption:=Mk_Name + '【' + FGzm.S_Name +'】工作面三维压力云图' ;
    end;

    Chart.Title.TextAlignment:=taCenter;
    Chart.Title.Font.Name :='黑体';
    Chart.Title.Font.Size :=ThreeDimCloud.titleSize;
    Chart.Title.Caption := Caption;

    Chart.SubTitle.Font.Color :=ClBlack;
    Chart.SubTitle.TextAlignment:=taCenter;
    Chart.SubTitle.Font.Name :='宋体';
    Chart.SubTitle.Font.Size :=ThreeDimCloud.TextSize;

    Caption:='起止日期:'+FormatDateTime('yyyy-mm-dd hh:nn ',self.DataTimeAndFootAge.StartTime)
                            +'('+FormatFloat('0.00',DataTimeAndFootAge.Minfootage)+  '米)--' +
                             FormatDateTime('yyyy-mm-dd hh:nn ',self.DataTimeAndFootAge.EndTime) +
                             '('+FormatFloat('0.00',DataTimeAndFootAge.MAXfootage)+  '米)';
    Caption:='【'+CloudClass.YunTu_DataType_Name+':'+CloudClass.Yuntu_Data_Name +'】'+Caption;
    Chart.SubTitle.Caption := Caption;
    Chart.SubTitle.Font.Color :=ClBlack;

    // 坐标轴
    Series.HorizAxis:=aBothHorizAxis ;
   // Chart.Legend.Visible :=false;
    Chart.BottomAxis.Visible :=true;
    Chart.BottomAxis.Title.Caption :='累计进尺';
    Chart.BottomAxis.Title.Position  :=tpStart ;

    Chart.BottomAxis.SubAxes.Items[0].Title.Caption:='累计进刀数';
    Chart.BottomAxis.SubAxes.Items[0].Title.Position:=tpEnd;

    Chart.TopAxis.Visible :=true;
    Chart.TopAxis.Title.Caption :='开采时间';
    Chart.TopAxis.Title.Position  :=tpEnd ;

    Chart.LeftAxis.Title.Caption :='液压支架编号';
    Chart.LeftAxis.Title.Position  :=tpCenter ;


end;

procedure TDrawGrap.Make_ThreeDim_axis_Chart(Chart: TChart);
var
  i,j,lowTime,highTime,InterValTime:integer;
begin
    Chart.BottomAxis.Visible :=true;
    Chart.BottomAxis.ExactDateTime :=true;
    Chart.BottomAxis.Title.Caption :='日期';
    Chart.BottomAxis.Title.Position  :=tpEnd;
    Chart.BottomAxis.Maximum :=DataTimeAndFootage.EndTime;
    Chart.BottomAxis.Minimum :=DataTimeAndFootage.StartTime ;
   // Chart.BottomAxis.DateTimeFormat('mm-dd');

    Chart.DepthAxis.Maximum :=120;

     lowTime:=trunc(DataTimeAndFootAge.StartTime);
     highTime:=trunc(DataTimeAndFootAge.EndTime+ThreeDimCloud.ForCaseDay);
     InterValTime:=highTime-lowTime+1;
     Chart.BottomAxis.Increment:=InterValtime div 10;
    // Chart.BottomAxis.LabelsAngle :=90;

     Chart.BottomAxis.SubAxes.Items[0].Title.Caption:='进尺';
     Chart.BottomAxis.SubAxes.Items[0].Title.Position:=tpEnd;

     Chart.BottomAxis.SubAxes.Items[0].Maximum :=DataTimeAndFootage.DownEndFootage;
     Chart.BottomAxis.SubAxes.Items[0].Minimum :=DataTimeAndFootage.DownStartFootage ;
     Chart.BottomAxis.SubAxes.Items[0].Increment:=Chart.BottomAxis.Increment;

     // 液压支架
     Chart.DepthAxis.Visible :=true;
     Chart.DepthAxis.Increment :=FGzm.SupEndUsedNumber /5;


end;


function TDrawGrap.Make_Three_Dim_Cycle_CloudChart(Series: TSurfaceSeries;PB:TProgressBar): Boolean;
 var
   i,sup,Number:integer;
   StartTime:TdateTime;
   invalTime,UseData:double;
   UseData1,UseData2:double;
   pt:array [0..3] of TPoint;
begin
      // 下面是 画 云图图例
   // StartTime:=DataTimeAndFootAge.StartTime;
    Series.StartColor :=clred;
    Series.MidColor :=clGreen;
    Series.EndColor :=clBlue;

    PB.Position :=0;
    PB.Step :=1;
    invalTime:=(DataTimeAndFootAge.EndTime -DataTimeAndFootAge.StartTime)/120;
    Number:=0;
  for sup := FGzm.SupStartNumber to FGzm.SupEndUsedNumber do  begin
       StartTime:=DataTimeAndFootAge.StartTime;
        while  startTime<=DataTimeAndFootAge.EndTime  do  begin
            for I := Number to SecondDPDataNumber do  begin
               if ( startTime<= MyGrid[i].EndTime ) and(sup =MyGrid[i].SupportBH) then   begin
//                   if self.CloudClass.Yuntu_CycleData =First_CData then  begin
//                       MyGrid[i].UseValue:= MyGrid[i].StartValue;
//                    end else if self.CloudClass.Yuntu_CycleData =MAX_CData then  begin
//                       MyGrid[i].UseValue:= MyGrid[i].MaxValue;
//                    end else if self.CloudClass.Yuntu_CycleData =AVG_CData then  begin
//                       MyGrid[i].UseValue:= MyGrid[i].AVGValue;
//                    end else begin
//                       MyGrid[i].UseValue:= MyGrid[i].LastValue;
//                    end;
                    UseData:=  MyGrid[i].LastValue;
                 //   if UseData<30  then  UseData:=30;
                   Series.AddXYZ(StartTime,UseData ,MYGrid[i].SupportBH
                       ,FormatDateTime('yyyy-mm-dd',StartTime), ReturnMyColors(Round(UseData)) ) ;

                   Number:=I;

                   PB.StepIt ;
                   if pb.Position >Pb.Max  then  PB.Position:=0;
                   break;
               end;

            end;
           startTime:=startTime+ invalTime;
        end;


    end;
   PB.Position:=pb.Max;
end;


function TDrawGrap.Make_Three_Dim_Dispose_CloudChart(
  series: TSurfaceSeries;PB:TProgressBar): Boolean;
 var
   i:integer;

   UseData:double;

begin
      // 下面是 画 云图图例
   // StartTime:=DataTimeAndFootAge.StartTime;
    Series.StartColor :=clred;
    Series.MidColor :=clGreen;
    Series.EndColor :=clBlue;

    PB.Position :=0;
    PB.Step :=1;


    for I := low(MyDisPoseGrid) to high(MyDisPoseGrid) do  begin
          if self.CloudClass.Yuntu_CycleData =Mzl_CData then  begin
             UseData:= MyDisPoseGrid[i].MzlData;
          end else if self.CloudClass.Yuntu_CycleData =MAX_CData then  begin
             UseData:= MyDisPoseGrid[i].MaxData;
          end else if self.CloudClass.Yuntu_CycleData =AVG_CData then  begin
             UseData:= MyDisPoseGrid[i].AGVData;
          end else if self.CloudClass.Yuntu_CycleData =SameTime_CData then  begin
             UseData:= MyDisPoseGrid[i].SameTimeData;
          end else if self.CloudClass.Yuntu_CycleData =Manual_CData then  begin
             UseData:= MyDisPoseGrid[i].ManualData;

          end;

           Series.AddXYZ(MyDisPoseGrid[i].STime,UseData,MyDisPoseGrid[i].y,
                        FormatDateTime('yyyy-mm-dd',MyDisPoseGrid[i].STime), ReturnMyColors(Round(UseData)) ) ;
           PB.StepIt ;
           if pb.Position >Pb.Max  then  PB.Position:=0;
    end;

   PB.Position:=pb.Max;
end;

procedure TDrawGrap.Make_Two_Dim_axis(image:Timage);
var
  i,j,lowTime,highTime,InterValTime:integer;
  MovePoint,LinePoint:Tpoint;
  XCount,YCount,TempColors:Integer;
  p:Array [1..7] of TPoint;
begin

     // 写时间标注
    Public_Basic.CanvasRotatedText(image.Canvas,TwoDimCloud.X_pix_start-45,TwoDimCloud.Y_pix_end,'宋体',8,0,ClRed,'日期:' );
    //进尺方向图例
    MovePoint.X:=TwoDimCloud.X_pix_start div 2 + TwoDimCloud.pic_width div 2;
    p[1]:=point( MovePoint.X -TwoDimCloud.pic_width div 4 ,TwoDimCloud.Y_pix_end+30);
    p[2]:=point( MovePoint.X +TwoDimCloud.pic_width div 4-35 ,TwoDimCloud.Y_pix_end+30);
    p[3]:=point( MovePoint.X +TwoDimCloud.pic_width div 4-35 ,TwoDimCloud.Y_pix_end+25);
    p[4]:=point( MovePoint.X +TwoDimCloud.pic_width div 4+35 ,TwoDimCloud.Y_pix_end+35);
    p[5]:=point( MovePoint.X +TwoDimCloud.pic_width div 4-35,TwoDimCloud.Y_pix_end+45);
    p[6]:=point( MovePoint.X +TwoDimCloud.pic_width div 4-35,TwoDimCloud.Y_pix_end+40);
    p[7]:=point( MovePoint.X -TwoDimCloud.pic_width div 4,TwoDimCloud.Y_pix_end+40);
    image.Canvas.Pen.Style :=psClear;
    image.Canvas.Brush.Color :=clGreen;
    image.Canvas.Polygon(p);
    image.Canvas.Brush.Style:=bsClear;
    // 写进尺
    Public_Basic.CanvasRotatedText(image.Canvas,TwoDimCloud.X_pix_start-60,TwoDimCloud.Y_pix_end+50,'宋体',8,0,ClRed,'下顺槽进尺:' );
    Public_Basic.CanvasRotatedText(image.Canvas,TwoDimCloud.X_pix_start-60,TwoDimCloud.Y_pix_start-30,'宋体',8,0,ClRed,'上顺槽进尺:' );
    //x 轴标尺
     lowTime:=trunc(DataTimeAndFootAge.StartTime);
     highTime:=trunc(DataTimeAndFootAge.EndTime+TwoDimCloud.ForCaseDay);
     InterValTime:=highTime-lowTime+1;
     XCount:=InterValtime div 15;
     if XCount <1 then  XCount:=1;

     for I := 0 to InterValTime do begin

         MovePoint.X:=TwoDimCloud.X_pix_start+Round(TwoDimCloud.X_Bl*i) ;
         MovePoint.y:=TwoDimCloud.Y_pix_end;
         image.Canvas.Pen.Color :=clblack;
         image.Canvas.Pen.Style :=psSolid;
         LinePoint.X:=TwoDimCloud.X_pix_start+Round(TwoDimCloud.X_Bl*i) ;
         LinePoint.y:=TwoDimCloud.Y_pix_end;
         if MovePoint.X>=TwoDimCloud.X_pix_end then   break;   // 框外侧的不画

         //
        if I mod XCount =0 then    begin   // 画长线标注
             //下顺槽标准
             image.Canvas.MoveTo(MovePoint.X,MovePoint.y);
             image.Canvas.LineTo(LinePoint.X,LinePoint.y+8);
             Public_Basic.CanvasRotatedText(image.Canvas,LinePoint.X-8,LinePoint.Y,'宋体',8, 315,Clblue,
                              FormatDateTime('mm/dd',lowTime+i));
              image.Canvas.Pen.Color :=clblack;
              image.Canvas.Pen.Style :=psDot;
              image.Canvas.MoveTo(LinePoint.X,LinePoint.y+8);
              image.Canvas.LineTo(LinePoint.X,LinePoint.y+58);
              Public_Basic.CanvasRotatedText(image.Canvas,LinePoint.X-5,LinePoint.Y+50,'宋体',8,0,ClBlack,
                               FormatFloat('0',DatetimeToFootage(lowTime+i,'Down') ) );
            //上顺槽标注
              image.Canvas.MoveTo(LinePoint.X,TwoDimCloud.Y_pix_start);
              image.Canvas.LineTo(LinePoint.X,TwoDimCloud.Y_pix_start-28);
              Public_Basic.CanvasRotatedText(image.Canvas,LinePoint.X-5,TwoDimCloud.Y_pix_start-30,'宋体',8,0,ClBlack,
                               FormatFloat('0',DatetimeToFootage(lowTime+i,'Upper') ) );
        end else begin
             // 下顺槽标准
             image.Canvas.MoveTo(MovePoint.X,MovePoint.y);
             image.Canvas.LineTo(LinePoint.X,LinePoint.y+5);
             // 上顺槽标注
             image.Canvas.MoveTo(LinePoint.X,TwoDimCloud.Y_pix_start);
             image.Canvas.LineTo(LinePoint.X,TwoDimCloud.Y_pix_start-5);
        end;
        //画当天小标尺
        for j := 1 to 3 do  begin
            // 下顺槽标准
           image.Canvas.MoveTo(MovePoint.X+Round(TwoDimCloud.X_Bl*0.25*j),MovePoint.y);
           image.Canvas.LineTo(LinePoint.X+Round(TwoDimCloud.X_Bl*0.25*j),LinePoint.y+3);
            // 上顺槽标注
           image.Canvas.MoveTo(MovePoint.X+Round(TwoDimCloud.X_Bl*0.25*j),TwoDimCloud.Y_pix_start);
           image.Canvas.LineTo(LinePoint.X+Round(TwoDimCloud.X_Bl*0.25*j),TwoDimCloud.Y_pix_start-3);
        end;
     end;
    // 以下 是 Y 轴 的标注
    YCount:=20;
    for I := Fgzm.SupStartNumber to Fgzm.SupEndUsedNumber do  begin
         MovePoint.X:=TwoDimCloud.X_pix_start;
         MovePoint.y:=TwoDimCloud.Y_pix_end-Round(TwoDimCloud.Y_Bl*i) ;
         LinePoint.X:=TwoDimCloud.X_pix_start ;
         LinePoint.y:=TwoDimCloud.Y_pix_end-Round(TwoDimCloud.Y_Bl*i);
         image.Canvas.Pen.Color :=clblack;
         image.Canvas.Pen.Style :=psSolid;
        if I mod YCount =0 then    begin   // 画长线标注
             image.Canvas.MoveTo(MovePoint.X,MovePoint.y);
             image.Canvas.LineTo(LinePoint.X-8,LinePoint.y);
             Public_Basic.CanvasRotatedText(image.Canvas,MovePoint.X-60,MovePoint.y-5,'宋体',8, 0,Clblue,
                              '【'+intTostr(i)+'】架');
        end else if I mod (YCount div 2) =0  then begin
             image.Canvas.MoveTo(MovePoint.X,MovePoint.y);
             image.Canvas.LineTo(LinePoint.X-8,LinePoint.y);
        end else if I mod (YCount div 4) =0  then begin
             image.Canvas.MoveTo(MovePoint.X,MovePoint.y);
             image.Canvas.LineTo(LinePoint.X-5,LinePoint.y);
        end;
    end;

end;

function TDrawGrap.Make_Two_Dim_Grid(image: TImage): Boolean;
var
  i,j,lowTime,highTime,InterValTime:integer;
  XCount,YCount:Integer;
  MovePoint,LinePoint:Tpoint;
begin
    //x 轴上网格
     lowTime:=trunc(DataTimeAndFootAge.StartTime);
     highTime:=trunc(DataTimeAndFootAge.EndTime+TwoDimCloud.ForCaseDay);
     InterValTime:=highTime-lowTime+1;
     XCount:=InterValtime div 15;
     if XCount <1 then  XCount:=1;
     image.Canvas.Pen.Color :=clBlack;
     image.Canvas.Pen.Style :=psSolid;
     for I := 0 to InterValTime do begin
         MovePoint.X:=TwoDimCloud.X_pix_start+Round(TwoDimCloud.X_Bl*i) ;
         MovePoint.y:=TwoDimCloud.Y_pix_end;
         if MovePoint.X>=TwoDimCloud.X_pix_end then   break;   // 框外侧的不画

        if I mod XCount =0 then    begin   // 画长线标注
             image.Canvas.MoveTo(MovePoint.X,MovePoint.y);
             image.Canvas.LineTo(MovePoint.X,TwoDimCloud.Y_pix_start);
        end ;
     end;
    // 以下 是 Y 轴 的标注
    YCount:=20;
    for I := Fgzm.SupStartNumber to Fgzm.SupEndUsedNumber do  begin
         MovePoint.X:=TwoDimCloud.X_pix_start;
         MovePoint.y:=TwoDimCloud.Y_pix_end-Round(TwoDimCloud.Y_Bl*i) ;
        if I mod YCount =0 then    begin   // 画长线标注
             image.Canvas.MoveTo(MovePoint.X,MovePoint.y);
             image.Canvas.LineTo(TwoDimCloud.X_pix_end,MovePoint.y);
        end;
    end;
end;

function TDrawGrap.Make_Two_Dim_Image(image: Timage;CloudType:TYuntuDataType): Boolean;
var
   i:integer;
   UseData:double;
begin
      // 下面是 画 云图图例
    image.Canvas.Pen.Style :=psClear;
    image.Canvas.Font.Color:=ClBlack;

    if CloudType = Cycle then   begin
       SelectMyGridColorValue(CloudClass.Yuntu_CycleData);// 初始化循环数据颜色值
       InitMYColors(ColorValue)  ;  //初始化颜色类别

          for I := 1 to SecondDPDataNumber -1 do  begin
              //查找本次显示最大值 最小值 初撑力 末阻力
              if self.CloudClass.Yuntu_CycleData =Mzl_CData then  begin
                 MyGrid[i].UseValue:= MyGrid[i].MzlValue;
              end else if self.CloudClass.Yuntu_CycleData =MAX_CData then  begin
                 MyGrid[i].UseValue:= MyGrid[i].MaxValue;
              end else if self.CloudClass.Yuntu_CycleData =AVG_CData then  begin
                 MyGrid[i].UseValue:= MyGrid[i].AVGValue;
              end else if self.CloudClass.Yuntu_CycleData =SameTime_CData then  begin
                 MyGrid[i].UseValue:= MyGrid[i].SameTimeVAlue;
              end else if self.CloudClass.Yuntu_CycleData =Manual_CData then  begin
                 MyGrid[i].UseValue:= MyGrid[i].ManualValue;
              end;
            //
            image.Canvas.Brush.Color :=RetrunManualDimColord(ColorValue,Round(MyGrid[i].UseValue ));
            image.Canvas.Polygon(MyGrid[i].TwoDimPt);
            image.Canvas.Brush.Style:=bsClear;
          end;
    end else if CloudType=DisPoseData then   begin
       SelectMyDisPoseGridColorValue(CloudClass.Yuntu_disposeData);// 初始化处理数据颜色值
       InitMYColors(ColorValue)  ;  //初始化颜色类别
         for I := 1 to High(MyDisPoseGrid) do  begin
              UseData:=0;
              if self.CloudClass.Yuntu_CycleData =Mzl_CData then  begin
                 MyGrid[i].UseValue:= MyGrid[i].MzlValue;
              end else if self.CloudClass.Yuntu_CycleData =MAX_CData then  begin
                 MyGrid[i].UseValue:= MyGrid[i].MaxValue;
              end else if self.CloudClass.Yuntu_CycleData =AVG_CData then  begin
                 MyGrid[i].UseValue:= MyGrid[i].AVGValue;
              end else if self.CloudClass.Yuntu_CycleData =SameTime_CData then  begin
                 MyGrid[i].UseValue:= MyGrid[i].SameTimeVAlue;
              end else if self.CloudClass.Yuntu_CycleData =Manual_CData then  begin
                 MyGrid[i].UseValue:= MyGrid[i].ManualValue;
              end;
            image.Canvas.Brush.Color :=ReturnMyColors(Round(UseData ));
            image.Canvas.Polygon(MyDisPoseGrid[i].TwoDimPt);
            image.Canvas.Brush.Style:=bsClear;
          end;
    end else if CloudType=ManualInput then  begin
         for I := 1 to SecondDPDataNumber -1 do  begin
              //查找本次显示最大值 最小值 初撑力 末阻力
              if self.CloudClass.Yuntu_CycleData =Mzl_CData then  begin
                 MyGrid[i].UseValue:= MyGrid[i].MzlValue;
              end else if self.CloudClass.Yuntu_CycleData =MAX_CData then  begin
                 MyGrid[i].UseValue:= MyGrid[i].MaxValue;
              end else if self.CloudClass.Yuntu_CycleData =AVG_CData then  begin
                 MyGrid[i].UseValue:= MyGrid[i].AVGValue;
              end else if self.CloudClass.Yuntu_CycleData =SameTime_CData then  begin
                 MyGrid[i].UseValue:= MyGrid[i].SameTimeVAlue;
              end else if self.CloudClass.Yuntu_CycleData =Manual_CData then  begin
                 MyGrid[i].UseValue:= MyGrid[i].ManualValue;
              end;
            //
            image.Canvas.Brush.Color :=RetrunManualDimColord(ColorValue,Round(MyGrid[i].UseValue ));
            image.Canvas.Polygon(MyGrid[i].TwoDimPt);
            image.Canvas.Brush.Style:=bsClear;
          end;
    end;


    MakeImageLegend(image) ;//制作图片的图例
    image.Canvas.Brush.Style:=bsClear;
end;

procedure TDrawGrap.MoveDoubleMYLine(image:TImage;MYPoint: TPoint);
var
   Horizontal_Origin,  Horizontal_Fin:TPoint;
   Vertical_Origin, Vertical_Fin:TPoint;
begin
   image.Canvas.Pen.Mode :=pmNotXor;
   image.Canvas.Brush.Style :=bsClear;//<<< !!!

   Horizontal_Origin.X:= TwoDimCloud.X_pix_start;
   Horizontal_Origin.Y:= MYPoint.Y;
   Horizontal_Fin.x:= TwoDimCloud.X_pix_end;
   Horizontal_Fin.Y:=  MYPoint.Y;
   Vertical_Origin.X:= MYPoint.X;
   Vertical_Origin.Y:=TwoDimCloud.Y_pix_start;
   Vertical_Fin.X:= MYPoint.X;
   Vertical_Fin.Y:=TwoDimCloud.Y_pix_end;

   //亦或
   if FirstLine.originP.X > TwoDimCloud.X_pix_start then   begin

       image.Canvas.Pen.Color :=FirstLine.lineColor ;
       drawLine(image,FirstLine.originP,FirstLine.finalP);
       image.Canvas.Pen.Color :=LastLine.lineColor ;
       drawLine(image,LastLine.originP,LastLine.finalP);
   end;
   // itsLine
   FirstLine.originP:=Horizontal_Origin;
   FirstLine.finalP:= Horizontal_Fin;
   FirstLine.lineColor:=ClRed;
   LastLine.originP:=Vertical_Origin;
   LastLine.finalP:= Vertical_Fin;
   LastLine.lineColor:=ClRed;
   //
   image.Canvas.Pen.Color :=FirstLine.lineColor ;
   drawLine(image,FirstLine.originP,FirstLine.finalP);
   image.Canvas.Pen.Color :=LastLine.lineColor ;
   drawLine(image,LastLine.originP,LastLine.finalP);

end;

function TDrawGrap.ReadContoueSeriesToClass(Steps: TOldSteps;DataType:integer): Boolean;
var
  Sql,sql2:string;
  id:integer;
  tmp:TOldOneStep;
begin
   Result:=true;
    try
       Sql:='Select * from  D_'+IntTostr(FGzm.Gzmbh)+'_ContourSteps  where  DataType =' +IntTostr(DataType) ;
       MySqlDataSet1.Close ;
       MySqlDataSet1.CommandText :=Sql;
       MySqlDataSet1.Open ;
       while not MySqlDataSet1.Eof  do  begin
         if DataType=2 then  begin
            tmp:=Steps.AddSteps;
            tmp.SetMinAndMaxSup(MySqlDataSet1.FieldByName('MinSup').AsFloat,MySqlDataSet1.FieldByName('MaxSup').AsFloat);
            tmp.SetMinAndMaxDao(MySqlDataSet1.FieldByName('MinDao').AsFloat,MySqlDataSet1.FieldByName('MaxDao').AsFloat);
            id:=MySqlDataSet1.FieldByName('id').AsInteger;
            tmp.Used :=1;
            tmp.ModifyData :=-1;
            tmp.OneStepInfo.ModifyData :=-1;
            FillOldOneStepPoint(tmp,id);
         end else if DataType=4 then  begin
            tmp:=Steps.AddSteps;
            tmp.SetMinAndMaxSup(MySqlDataSet1.FieldByName('MinSup').AsFloat,MySqlDataSet1.FieldByName('MaxSup').AsFloat);
            tmp.SetMinAndMaxDao(MySqlDataSet1.FieldByName('MinDao').AsFloat,MySqlDataSet1.FieldByName('MaxDao').AsFloat);
            id:=MySqlDataSet1.FieldByName('id').AsInteger;
            tmp.Used :=1;
            tmp.ModifyData :=4;
            tmp.OneStepInfo.ModifyData :=4;
            // 继续填充
            tmp.OneStepInfo.StartDao := MySqlDataSet1.FieldByName('MinDAo').AsInteger;
            tmp.OneStepInfo.EndDao := MySqlDataSet1.FieldByName('MaxDAo').AsInteger;
            tmp.OneStepInfo.StartSup := MySqlDataSet1.FieldByName('MinSup').AsInteger;
            tmp.OneStepInfo.EndSup := MySqlDataSet1.FieldByName('MaxSup').AsInteger;
            tmp.OneStepInfo.MinData := MySqlDataSet1.FieldByName('MinData').AsFloat;
            tmp.OneStepInfo.MaxData := MySqlDataSet1.FieldByName('MaxData').AsFloat;
            tmp.OneStepInfo.AGVDAta := MySqlDataSet1.FieldByName('AGVData').AsFloat;

            tmp.OneStepInfo.Start_MinDao := MySqlDataSet1.FieldByName('Start_MinDao').AsInteger;
            tmp.OneStepInfo.Start_maxDao := MySqlDataSet1.FieldByName('Start_MaxDao').AsInteger;
            tmp.OneStepInfo.Step_MaxWide_Dao := MySqlDataSet1.FieldByName('Step_MaxWide_Dao').AsInteger;
            tmp.OneStepInfo.Step_MinWide_Dao := MySqlDataSet1.FieldByName('Step_MinWide_Dao').AsInteger;
            tmp.OneStepInfo.Count := MySqlDataSet1.FieldByName('Step_Count').AsInteger;

            tmp.OneStepInfo.AreaQD := MySqlDataSet1.FieldByName('Step_Qd').AsFloat;
            tmp.OneStepInfo.AGVDataQD := MySqlDataSet1.FieldByName('AGVData_Qd').AsFloat;
            tmp.OneStepInfo.Start_MaxFootage := MySqlDataSet1.FieldByName('Start_MaxFootage').AsFloat;
            tmp.OneStepInfo.Start_MinFootage := MySqlDataSet1.FieldByName('Start_MinFootage').AsFloat;

            tmp.OneStepInfo.Step_end_MaxDao := MySqlDataSet1.FieldByName('Step_end_MaxDao').AsInteger;
            tmp.OneStepInfo.Step_end_MinDao := MySqlDataSet1.FieldByName('Step_end_MinDao').AsInteger;
            tmp.OneStepInfo.Step_end_MaxFootage := MySqlDataSet1.FieldByName('Step_end_MaxFootage').AsFloat;
            tmp.OneStepInfo.Step_end_minFootage := MySqlDataSet1.FieldByName('Step_end_minFootage').AsFloat;
            tmp.OneStepInfo.Step_Move_MinFootage := MySqlDataSet1.FieldByName('Step_Move_MinFootage').AsFloat;
            tmp.OneStepInfo.Step_Move_AGV_Footage:= MySqlDataSet1.FieldByName('Step_Move_AGVFootage').AsFloat;

            tmp.OneStepInfo.Step_end_AGVFootage := MySqlDataSet1.FieldByName('Step_end_AGVFootage').AsFloat;
            tmp.OneStepInfo.Step_Obvious_Footage[0] := MySqlDataSet1.FieldByName('Step_Obvious_max_Ft').AsFloat;
            tmp.OneStepInfo.Step_Obvious_Footage[1] := MySqlDataSet1.FieldByName('Step_Obvious_Min_Ft').AsFloat;
            tmp.OneStepInfo.Step_Obvious_Footage[2]:= MySqlDataSet1.FieldByName('Step_Obvious_AGV_Ft').AsFloat;
            tmp.OneStepInfo.Step_continue_Footage:= MySqlDataSet1.FieldByName('Step_continue_Footage').AsFloat;

            tmp.OneStepInfo.MaxData_Sup := MySqlDataSet1.FieldByName('MaxData_sup').AsInteger;
            tmp.OneStepInfo.MaxData_Dao := MySqlDataSet1.FieldByName('MaxData_Dao').AsInteger;
            tmp.OneStepInfo.MinData_Sup := MySqlDataSet1.FieldByName('MinData_Sup').AsInteger;
            tmp.OneStepInfo.MinData_Dao := MySqlDataSet1.FieldByName('MinData_Dao').AsInteger;

            tmp.OneStepInfo.SupportString:=MySqlDataSet1.FieldByName('SupString1').AsString +
                                           MySqlDataSet1.FieldByName('SupString2').AsString +
                                           MySqlDataSet1.FieldByName('SupString3').AsString;


            {MinDao,MaxDao,MinSup,MaxSup,MinData,MaxData,AGVData, '  +
            ' Start_MinDao,Start_MaxDao,Step_MaxWide_Dao,Step_MinWide_Dao,Step_Count,Step_Qd,AGVData_Qd, ' +
            ' Start_MaxFootage,Start_MinFootage,Step_end_MaxDao,Step_end_MinDao,Step_end_MaxFootage,' +
            ' Step_end_minFootage,Step_move_MaxFootage,Step_Move_MinFootage,Step_Move_AGVFootage,'  +
            ' Step_end_AGVFootage,Step_Obvious_max_Ft,Step_Obvious_Min_Ft,Step_Obvious_AGV_Ft,' +
            ' Step_continue_Footage,MaxData_sup,MaxData_Dao,MinData_Sup,MinData_Dao,SupString1,SupString2,SupString3}
            FillOldOneStepPoint(tmp,id);
         end;
         MySqlDataSet1.Next ;
       end;
       MySqlDataSet1.Close ;
    except
      Result:=False;
    end;


end;

function TDrawGrap.RefreshChart_ConTourSeries(Chart: Tchart;Series1: TContourSeries ;
                                 FirPB,SecPB: TProgressBar;Flag:integer):Boolean;
{   Flag =0 原始数据   =1 优化数据}
begin
   Result:=FALSE;

    MakeContourChartCaption(chart,series1);//把contour的chart 初始化
//

     if CloudClass.YunTu_DataClass=Cycle then  begin
//        if not ComputerTwoDimCloudCyclePoint then  exit;    // 循环进尺数据 二维云图
//
//        Make_Two_Dim_Image(TwoDimImage,Cycle); // 画循环进尺数据二维的图片
//        Make_Two_Dim_Grid(TwoDimImage );//画循环进尺数据二维网格线
//        Make_Three_Dim_Cycle_CloudChart(ThirdSeries,SecPB); // 循环进尺数据的三维云图

     end else if CloudClass.YunTu_DataClass=DisposeData then begin
//         FillDisPoseGrid;  // 按照网格密度补充  处理过的数据
//         ComputerTwoDimCloudDisposePoint; //二维处理过的数据进行处理
//         Make_Two_Dim_Image(TwoDimImage,DisposeData); // 画处理数据二维的图片
//         Make_Two_Dim_Grid(TwoDimImage );//画处理数据二维网格线
//         Make_Three_Dim_Dispose_CloudChart(ThirdSeries,SecPB); //制作处理数据三维云图
     end else if CloudClass.YunTu_DataClass=ManualInput  then begin  // 手动录入数据的曲线图
        ChangeThreeArrayContourGrid(ColorValue.UnitType,Ord(CloudClass.Yuntu_CycleData) );
        FillThreeContourSeriesData(series1,Flag);
        ContourSeries1_Basic_GroupLevle(ColorValue,series1);
        Chart.Refresh;
     end;
     Result:=TRUE;
end;

function TDrawGrap.RefreshChart_GraphLineSeries(Chart: Tchart;
  Series1: TLineSeries; FirPB, SecPB: TProgressBar): Boolean;
begin
  Result:=FALSE;

    MakeGraphChartCaption(chart,series1);//把GraphSeries的chart 初始化
//

     if CloudClass.YunTu_DataClass=Cycle then  begin

     end else if CloudClass.YunTu_DataClass=DisposeData then begin

     end else if CloudClass.YunTu_DataClass=ManualInput  then begin  // 手动录入数据的曲线图
//        ChangeThreeArrayContourGrid(ColorValue.UnitType );
//        FillThreeContourSeriesData(series1);
//        Chart.Legend.Repaint;
//        TwoDimChart_ContourSeries1_refreshColor(ColorValue,series1);

     end;
     Result:=TRUE;
end;

function TDrawGrap.RefreshChart_ThreeConTourSeries(Chart: Tchart;
  Series1: TCustom3DSeries; FirPB, SecPB: TProgressBar): Boolean;
begin
    Result:=FALSE;
    InitMYColors(ColorValue)  ;  //初始化颜色类别
    MakeThreeContourChartCaption(chart,series1);//把contour的chart 初始化
//

     if CloudClass.YunTu_DataClass=Cycle then  begin
//        if not ComputerTwoDimCloudCyclePoint then  exit;    // 循环进尺数据 二维云图
//
//        Make_Two_Dim_Image(TwoDimImage,Cycle); // 画循环进尺数据二维的图片
//        Make_Two_Dim_Grid(TwoDimImage );//画循环进尺数据二维网格线
//        Make_Three_Dim_Cycle_CloudChart(ThirdSeries,SecPB); // 循环进尺数据的三维云图

     end else if CloudClass.YunTu_DataClass=DisposeData then begin
//         FillDisPoseGrid;  // 按照网格密度补充  处理过的数据
//         ComputerTwoDimCloudDisposePoint; //二维处理过的数据进行处理
//         Make_Two_Dim_Image(TwoDimImage,DisposeData); // 画处理数据二维的图片
//         Make_Two_Dim_Grid(TwoDimImage );//画处理数据二维网格线
//         Make_Three_Dim_Dispose_CloudChart(ThirdSeries,SecPB); //制作处理数据三维云图
     end else if CloudClass.YunTu_DataClass=ManualInput  then begin  // 手动录入数据的曲线图

        ChangeThreeArrayContourGrid(ColorValue.UnitType,Ord(CloudClass.Yuntu_CycleData) );

        FillThreeContourSeriesData(series1,0);


     end;

     Result:=TRUE;

end;


function TDrawGrap.RetrunManualDimColord(CValue: TColorValue;
  DValue: Double): TColor;
var
  BarData:Double;
begin
    if CValue.UnitType =1 then  begin
       BarData:= DValue * 10 ;
    end else begin
       BarData:= DValue ;
    end;

    if BarData <300 then  begin
       Result:=$00E500;
    end else  if BarData <350  then  begin
       Result:=$0C8918;
    end else  if BarData <400  then  begin
       Result:=clBlue;
    end else  if BarData <450  then  begin
       Result:=$0000FF;
    end else    begin
       Result:=$000080;
    end;


end;

function TDrawGrap.ReturnDataBaseMin_MaxDao(var MinDao, MaxDao:integer): Boolean;
var
  Sql:string;
  id:integer;
begin
   Result:=true;
    try
       Sql:='Select Max(MaxDao) as MXD,Min(MinDao) as MID from  D_'+IntTostr(FGzm.Gzmbh)+'_ContourSteps   ' +
             ' where DataType =4' ;
       MySqlDataSet2.Close ;
       MySqlDataSet2.CommandText :=Sql;
       if MySqlDataSet2.Open  then begin
         MinDao:=MySqlDataSet2.FieldByName('MID').AsInteger;
         MaxDao:=MySqlDataSet2.FieldByName('MxD').AsInteger;
       end;
       MySqlDataSet2.Close ;
    except
      Result:=false;
    end;
end;

function TDrawGrap.ReturnMaxContourStepTableId: integer;
var
sql:String;
id:integer;
begin
   id:=-1;
   try
    Sql:=' select Max(id) as sd  from  D_'+IntTostr(FGzm.Gzmbh)+'_ContourSteps ';
    MySqlDataSet2.Close ;
    MySqlDataSet2.CommandText:=sql;
    if  MySqlDataSet2.Open  then
        id:=MySqlDataSet2.FieldByName('sd').AsInteger;
   finally
    MySqlDataSet2.Close ;
    Result:=id;
   end;

end;

function TDrawGrap.ReturnMinPoint(StartPoint, EndPoint: integer): integer;
var
  i,MaxA:Integer;
  l1,l3:double;

begin
    MaxA:=high(MyThirdGrid);
    if StartPoint+2>MaxA  then Result:=StartPoint;
    l1:=sqrt(sqr(MyThirdGrid[EndPoint].endTime-MyThirdGrid[StartPoint].endTime)+
             sqr(MyThirdGrid[EndPoint].Midsup-MyThirdGrid[StartPoint].Midsup));
    l3:=sqrt(sqr(MyThirdGrid[EndPoint].endTime-MyThirdGrid[StartPoint+2].endTime)+
             sqr(MyThirdGrid[EndPoint].Midsup-MyThirdGrid[StartPoint+2].Midsup));
    if l1> l3 then  result:= StartPoint+1  else Result:=StartPoint ;
end;

function TDrawGrap.ReturnMyColors( Value: integer): TColor;
var
  KValue:integer;
begin

   KValue:= KValue*2;
    if KValue <10 *ColorValue.UnitValue  then  begin
       Result:=MyColors[10];
    end else if KValue >= Round(ColorValue.MaxValue)*2*0.95*ColorValue.UnitValue  then  begin
        Result:=MyColors[199];
    end else begin
        Result:=MyColors[KValue];
    end;
end;



function TDrawGrap.SaveContourSeriesIntoDataBase(Steps: TOldSteps;DataType:integer): Boolean;
{
 DataType  2 是指 保存 原始的区域数据
           4 是指在 原始区域基础上 进行了数据处理，对 来压步距进行了综合判定的数据

}
var
  sql,s1,s2,s3,Tmp:string;
  i,j,Maxid:integer;
  MinDao,MaxDao,MinSup,MaxSup:integer;
begin
  Result:=true;
  try

     for i := 0 to length(Steps.ExSteps)-1 do  begin
       if (Steps.ExSteps[i].Used =0 ) then   continue;   {系统自动清除}
       if (Steps.ExSteps[i].Used =2 ) then   continue;   {系统手动清除}
       if (Steps.ExSteps[i].Used =3 ) then   continue;   {被屏蔽的数据}

       if length(Steps.ExSteps[i].OneStepInfo.SupportString) >380  then   begin
          S3:=Copy(Steps.ExSteps[i].OneStepInfo.SupportString,381,570);
          S2:=Copy(Steps.ExSteps[i].OneStepInfo.SupportString,191,380);
          S1:=Copy(Steps.ExSteps[i].OneStepInfo.SupportString,1,190);
       end else if length(Steps.ExSteps[i].OneStepInfo.SupportString) >190  then   begin
          S3:='';
          S2:=Copy(Steps.ExSteps[i].OneStepInfo.SupportString,191,
              length(Steps.ExSteps[i].OneStepInfo.SupportString));
          S1:=Copy(Steps.ExSteps[i].OneStepInfo.SupportString,1,190);
       end else begin
          S3:='';
          S2:='';
          S1:=Copy(Steps.ExSteps[i].OneStepInfo.SupportString,1,
              length(Steps.ExSteps[i].OneStepInfo.SupportString));
       end;

       if DataType=2 then     begin      // 原始区域数据
          MinDao:=Round(Steps.ExSteps[i].startDao);
          MaxDao:=Round(Steps.ExSteps[i].endDao );
          MinSup:=Round(Steps.ExSteps[i].startsup );
          MaxSup:=Round(Steps.ExSteps[i].endsup );
          if Steps.ExSteps[i].ModifyData <> 1 then  Continue;
          sql:='insert into D_'+IntTostr(FGzm.Gzmbh)+'_ContourSteps  (MinDao,MaxDao,MinSup,MaxSup,DataType '  +
            ' ) values ( '+
            IntToStr(Round(Steps.ExSteps[i].startDao ))+ ',' + IntToStr(Round(Steps.ExSteps[i].endDao ))+ ','  +
            IntToStr(Round(Steps.ExSteps[i].startsup ))+ ',' + IntToStr(Round(Steps.ExSteps[i].endsup ))+ ','  +
            IntToStr(DataType ) +
            ')';
       end else if  DataType=4 then  begin   // 对区域进行了综合判定的数据
          MinDao:=Steps.ExSteps[i].OneStepInfo.StartDao;
          MaxDao:=Steps.ExSteps[i].OneStepInfo.endDao ;
          MinSup:=Steps.ExSteps[i].OneStepInfo.startsup ;
          MaxSup:=Steps.ExSteps[i].OneStepInfo.EndSup;
          {只有标志没有保存信息的才保存  3 是预测的  }
          if (Steps.ExSteps[i].OneStepInfo.ModifyData =3 )   then  continue;
           {只有完整步距信息的才保存}
         // if Steps.ExSteps[i].OneStepInfo.NextStepClassID <0 then  continue;

          sql:='insert into D_'+IntTostr(FGzm.Gzmbh)+'_ContourSteps  (MinDao,MaxDao,MinSup,MaxSup,MinData,MaxData,AGVData, '  +
            ' Start_MinDao,Start_MaxDao,Step_MaxWide_Dao,Step_MinWide_Dao,Step_Count,Step_Qd,AGVData_Qd, ' +
            ' Start_MaxFootage,Start_MinFootage,Step_end_MaxDao,Step_end_MinDao,Step_end_MaxFootage,' +
            ' Step_end_minFootage,Step_move_MaxFootage,Step_Move_MinFootage,Step_Move_AGVFootage,'  +
            ' Step_end_AGVFootage,Step_Obvious_max_Ft,Step_Obvious_Min_Ft,Step_Obvious_AGV_Ft,' +
            ' Step_continue_Footage,MaxData_sup,MaxData_Dao,MinData_Sup,MinData_Dao, '+
            ' SupString1,SupString2,SupString3,DataType '  +
            ' ) values ( '+
            IntToStr(Steps.ExSteps[i].OneStepInfo.StartDao )+ ',' + IntToStr(Steps.ExSteps[i].OneStepInfo.EndDao )+ ','  +
            IntToStr(Steps.ExSteps[i].OneStepInfo.StartSup )+ ',' + IntToStr(Steps.ExSteps[i].OneStepInfo.EndSup )+ ','  +
            FormatFloat('0.00',Steps.ExSteps[i].OneStepInfo.MinData)+','+ FormatFloat('0.00',Steps.ExSteps[i].OneStepInfo.MaxData)+','+
            FormatFloat('0.00',Steps.ExSteps[i].OneStepInfo.AGVDAta)+','+
            IntToStr(Steps.ExSteps[i].OneStepInfo.Start_MinDao )+ ',' + IntToStr(Steps.ExSteps[i].OneStepInfo.Start_maxDao )+ ','  +
            IntToStr(Steps.ExSteps[i].OneStepInfo.Step_MaxWide_Dao )+ ',' + IntToStr(Steps.ExSteps[i].OneStepInfo.Step_MinWide_Dao )+ ','  +
            IntToStr(Steps.ExSteps[i].OneStepInfo.Count  )+ ',' +
            FormatFloat('0.00',Steps.ExSteps[i].OneStepInfo.AreaQD)+','+ FormatFloat('0.00',Steps.ExSteps[i].OneStepInfo.AGVDataQD)+','+
            FormatFloat('0.00',Steps.ExSteps[i].OneStepInfo.start_maxFootage)+','+ FormatFloat('0.00',Steps.ExSteps[i].OneStepInfo.start_minFootage)+','+
            IntToStr(Steps.ExSteps[i].OneStepInfo.Step_end_MAXDao )+ ',' + IntToStr(Steps.ExSteps[i].OneStepInfo.Step_end_MinDao )+ ','  +
            FormatFloat('0.00',Steps.ExSteps[i].OneStepInfo.Step_end_MaxFootage)+','+ FormatFloat('0.00',Steps.ExSteps[i].OneStepInfo.Step_end_MinFootage)+','+
            FormatFloat('0.00',Steps.ExSteps[i].OneStepInfo.Step_Move_MaxFootage)+','+ FormatFloat('0.00',Steps.ExSteps[i].OneStepInfo.step_Move_MinFootage)+','+
            FormatFloat('0.00',Steps.ExSteps[i].OneStepInfo.Step_Move_AGV_Footage)+','+ FormatFloat('0.00',Steps.ExSteps[i].OneStepInfo.Step_end_AGVFootage)+','+
            FormatFloat('0.00',Steps.ExSteps[i].OneStepInfo.Step_Obvious_Footage[0])+','+ FormatFloat('0.00',Steps.ExSteps[i].OneStepInfo.Step_Obvious_Footage[1])+','+
            FormatFloat('0.00',Steps.ExSteps[i].OneStepInfo.Step_Obvious_Footage[2])+','+
            FormatFloat('0.00',Steps.ExSteps[i].OneStepInfo.Step_Continue_Footage)+','+ IntToStr(Steps.ExSteps[i].OneStepInfo.MaxData_Sup )+ ','  +
            IntToStr(Steps.ExSteps[i].OneStepInfo.MaxData_Dao )+ ','  + IntToStr(Steps.ExSteps[i].OneStepInfo.MinData_Sup )+ ','  +
            IntToStr(Steps.ExSteps[i].OneStepInfo.MinData_Dao )+ ','  +
            ''''+ S1+''',''' +S2+''','''+S3+''',' +
            IntToStr(DataType ) +
            ')';
       end;

        //把数据库中已经保存的数据进行清除，然后重新保存
        DeleteContourStepTable( DataTimeAndFootAge.Graph_MinDao,
                                   DataTimeAndFootAge.Graph_MaxDao,
                                   0,
                                   FGzm.SupEndNumber,
                                   DataType);




       MyCommand1.CommandText :=Sql;
       MyCommand1.Execute ;
        if DataType=2 then     begin
           Steps.ExSteps[i].ModifyData:=2;
        end else if DataType=4 then     begin
           Steps.ExSteps[i].OneStepInfo.ModifyData :=2;
        end;
       //
       Maxid:=ReturnMaxContourStepTableId;
       if Maxid <0  then   continue;
       Sql:=' insert into D_'+IntTostr(FGzm.Gzmbh)+'_ContourSteps_points ( CoutourStepid,Pointxh,AXis_x,Axix_y ) Values ( ' ;
       for j := 0 to 7 do   begin
           Tmp:= intTostr(Maxid) + ','  +      intTostr(j) + ','  +
                IntToStr(Steps.ExSteps[i].MyOutLinePoint[j].Point.x)  +','  +
                IntToStr(Steps.ExSteps[i].MyOutLinePoint[j].Point.y )   +')';
           MyCommand1.CommandText :=Sql + Tmp;
           MyCommand1.Execute ;
       end;
     end;

  except
    REsult:=False;
  end;

end;



function TDrawGrap.SaveExtractDataFormSeries_SideData(tChart1:TChart;Series: TContourSeries;
  First, Second: TProgressBar; LeverLineValue: Double): Boolean;
var
   i, j, m,x0,x1,y0,y1: Integer;
  lvl: TContourLevel;
  seg: TLevelSegment;
  pt,p0,prv:Tpoint;
begin
    ContourSeries1_Extract_GroupLevel(LeverLineValue,ColorValue ,Series);
    StepProcegressBar(First,Second,0,10) ;
    Series.Repaint;
    tChart1.Refresh ;

  for I := 0 to High(MyContourDoubleGrid)-1 do    // 刀数
       for j := 0 to High(MyContourDoubleGrid[i]) do     //  支架数
         MyContourDoubleGrid[i][j].ContoursideData:=-1;
   // 抽数据
    for I := Series.Levels.Count-1 downto 0 do  begin
        lvl:=series.Levels.Items[i];
        m:=length(lvl.Segments);
       // ShowMessage('Level: ' + IntToStr(length(lvl.Segments) ) + ', UpToValue: ' + FormatFloat('#,##0.###', lvl.UpToValue));
        if (length(lvl.Segments)>0) and (lvl.UpToValue >= (LeverLineValue - FGzm.RockPressAnalysis.NearColorLineUp_DownValue)* ColorValue.UnitValue )
            and (lvl.UpToValue <= (LeverLineValue +FGzm.RockPressAnalysis.NearColorLineUp_DownValue)* ColorValue.UnitValue)then   begin
            StepProcegressBar(First,Second,10,0);
            for j:=0 to length(lvl.Segments)-1 do    begin
              StepProcegressBar(First,Second,0,10) ;
               {清理一个区域的节点}
               Auto_Judge_OldStep.ClearPoint;
               seg:=lvl.Segments[j];
                 for m := 0 to length(seg.Points)-1  do   begin
                      pt.x:= Round(seg.Points[m].x);
                      pt.y:= Round(seg.Points[m].Y);
                      if m=0 then  begin
                         MyContourDoubleGrid[pt.x][pt.y].ContoursideData:=50;
                         p0:=Pt;prv:=pt;
                      end else if m <length(seg.Points)-1  then begin
                         x0:= Min(prv.X ,pt.X);
                         x1:= Max(prv.X ,pt.X);
                         y0:= Min(prv.Y ,pt.Y);
                         Y1:= Max(prv.Y ,pt.Y);
                         while (x0<=x1) and (y0<=Y1) do begin
                            MyContourDoubleGrid[X0][Y0].ContoursideData:=50;
                            inc(x0);inc(Y0);
                         end;
                         MyContourDoubleGrid[X1][Y1].ContoursideData:=50;
                         prv:=pt;
                      end else  if m =length(seg.Points)-1  then begin
                         x0:= Min(p0.X ,pt.X);
                         x1:= Max(p0.X ,pt.X);
                         y0:= Min(p0.Y ,pt.Y);
                         Y1:= Max(p0.Y ,pt.Y);
                         while (x0<=x1) and (y0<=Y1) do begin
                            MyContourDoubleGrid[X0][Y0].ContoursideData:=50;
                            inc(x0);inc(Y0);
                         end;
                         MyContourDoubleGrid[X1][Y1].ContoursideData:=50;
                      end;

                 end;
            end;
       end;
    end;

end;

function TDrawGrap.SelectMineAndWorkFaceBh(Mk, Gzm: string): Boolean;
var
  sql:string;
  t_s:string;
begin

   Result:=False;
   Mk_Name:=Mk;
   Mk_id:=FGzm.SelKuangjingBianHao(Mk);
   FGzm.Gzmbh:=FGzm.IsExistWorkFace(Mk_id,Gzm);
   FGZm.S_Name:=Gzm;
   // 初始化工作面基本参数
   if not UseFGzmInitPStope then begin
      t_s:='工作面\钻孔\支架相关信息不完成，请及时补录!'+#13#10+'否则数据分析中的部分操作无法操作！';
      Application.MessageBox(Pwidechar(t_s),'提示',MB_OK+MB_ICONQUESTION);
   end;

   if FGzm.Gzmbh <0  then exit;

   FGzm.S_Name:=Gzm;
   sql:=' select jituanid,JituanName from kuangjingxinxibiao where id=' + IntToStr(Mk_id);
   MySqlDataSet1.Close ;
   MySqlDataSet1.CommandText :=sql;
   MySqlDataSet1.Open ;
   if MySqlDataSet1.RecordCount >0 then  begin
     Jituan_id:=MySqlDataSet1.FieldByName('jituanid').AsInteger ;
     Jituan_Name:=MySqlDataSet1.FieldByName('jituanName').AsString;
   end;
   MySqlDataSet1.Close ;
   Result:=true;
end;

function TDrawGrap.SelectMyDisPoseGridColorValue(Value: TDisPoseData): Boolean;
var
  i:integer;
begin
    ColorValue.MinValue :=1000;         //ThirdDpAGV,ThirdDpMax,ThirdDpMzl
    ColorValue.MaxValue :=0;

     if Value= ThirdDpAGV then begin
         for I := 0 to High(MyDisPoseGrid) do begin
            if ColorValue.MinValue > MyDisPoseGrid[i].AGVData then ColorValue.MinValue:=   MyDisPoseGrid[i].AGVData;
            if ColorValue.MaxValue < MyDisPoseGrid[i].AGVData then ColorValue.MaxValue:=   MyDisPoseGrid[i].AGVData;
         end;

     end else if  Value =ThirdDpMax then   begin
         for I := 0 to High(MyGrid) do begin
            if ColorValue.MinValue > MyDisPoseGrid[i].MaxData then ColorValue.MinValue:=   MyDisPoseGrid[i].MaxData;
            if ColorValue.MaxValue < MyDisPoseGrid[i].MaxData then ColorValue.MaxValue:=   MyDisPoseGrid[i].MaxData;
         end;

     end else if  Value =ThirdDpMzl then  begin
         for I := 0 to High(MyGrid) do begin
            if ColorValue.MinValue > MyDisPoseGrid[i].MzlData then ColorValue.MinValue:=   MyDisPoseGrid[i].MzlData;
            if ColorValue.MaxValue < MyDisPoseGrid[i].MzlData then ColorValue.MaxValue:=   MyDisPoseGrid[i].MzlData;
         end;

     end;

end;

function TDrawGrap.SelectMyGridColorValue(Value: TCycleData): Boolean;
var
  i:integer;
begin
    ColorValue.MinValue :=1000;         //First_CData,Last_CData,MAX_CData,AVG_CData
    ColorValue.MaxValue :=0;

     if Value= MAX_CData then begin
         for I := 0 to High(MyGrid) do begin
            if ColorValue.MinValue > MyGrid[i].MaxValue then ColorValue.MinValue:=   MyGrid[i].MaxValue;
            if ColorValue.MaxValue < MyGrid[i].MaxValue then ColorValue.MaxValue:=   MyGrid[i].MaxValue;
         end;

     end else if  Value =AVG_CData then   begin
         for I := 0 to High(MyGrid) do begin
            if ColorValue.MinValue > MyGrid[i].AVGValue then ColorValue.MinValue:=   MyGrid[i].AVGValue;
            if ColorValue.MaxValue < MyGrid[i].AVGValue then ColorValue.MaxValue:=   MyGrid[i].AVGValue;
         end;

     end else if  Value =MzL_CData then  begin
         for I := 0 to High(MyGrid) do begin
            if ColorValue.MinValue > MyGrid[i].MzlValue then ColorValue.MinValue:=   MyGrid[i].MzlValue;
            if ColorValue.MaxValue < MyGrid[i].MzlValue then ColorValue.MaxValue:=   MyGrid[i].MzlValue;
         end;
     end else if  Value =SameTime_CData then  begin
         for I := 0 to High(MyGrid) do begin
            if ColorValue.MinValue > MyGrid[i].SameTimeValue then ColorValue.MinValue:=   MyGrid[i].SameTimeValue;
            if ColorValue.MaxValue < MyGrid[i].SameTimeValue then ColorValue.MaxValue:=   MyGrid[i].SameTimeValue;
         end;
     end else if  Value =Manual_CData then  begin
         for I := 0 to High(MyGrid) do begin
            if ColorValue.MinValue > MyGrid[i].ManualValue then ColorValue.MinValue:=   MyGrid[i].ManualValue;
            if ColorValue.MaxValue < MyGrid[i].ManualValue then ColorValue.MaxValue:=   MyGrid[i].ManualValue;
         end;
     end;

end;



procedure TDrawGrap.SelectPressDataFromSupportMoveInfo( First,Second: TProgressBar;Flag:integer);
{
   Flag  0 1
   涉及到是否删除数据的问题
}
var
  i,Sup:integer;
  sql1,sql2,Strdt:String;
  MaxTime:TdateTime;
  JinDao,SupportBh:integer;
  Data0,Data1,Data2,Data3,Data4:double;
begin
  // 填充 进刀类
   FillBasicJinDao(BasicJinDao,DataTimeAndFootAge.Graph_MinDao,DataTimeAndFootAge.Graph_MaxDao);
    for I := 0 to BasicJinDao.Count-1 do   begin
         if (i>1) and (Data0<1) then  break;
         StepProcegressBar(First,Second,10,0);
         Strdt:=Public_Basic.ReturnDateTimeString(MainDataModule.DataType ,BasicJinDao.ArrayBasicJinDao[i].ShotTime);
         JinDao:=BasicJinDao.ArrayBasicJinDao[i].Daoshu;
         Sql1:=' select * from  D_'+IntToStr(FGzm.Gzmbh)+'_SupportMoveInfo ' +
               ' where EndTime >= ' + Strdt + ' and StartTime <= ' +Strdt+ ' order by SupportBh';
         MySqlDataSet1.Close ;
         MySqlDataSet1.CommandText :=sql1;
         SupportBh:=0;
         if MySqlDataSet1.Open then begin
            while not MySqlDataSet1.Eof  do begin
                StepProcegressBar(First,Second,0,1);
                if SupportBh <> MySqlDataSet1.FieldByName('Supportbh').AsInteger then  begin
                   SupportBh:=MySqlDataSet1.FieldByName('Supportbh').AsInteger;
                   if (SupportBh <=FGzm.SupEndNumber) then begin
                      if MyContourDoubleGrid[JinDao][SupportBh].DataType=0 then begin
                        MyContourDoubleGrid[JinDao][SupportBh].AGV_Value:=MySqlDataSet1.FieldByName('AGVData').AsFloat;
                        MyContourDoubleGrid[JinDao][SupportBh].MZL_Value:=MySqlDataSet1.FieldByName('BeforeMoveValue').AsFloat;
                        MyContourDoubleGrid[JinDao][SupportBh].Max_Value:=MySqlDataSet1.FieldByName('max_Value').AsFloat;
                        MyContourDoubleGrid[JinDao][SupportBh].DataType:=2;//表示添加的数据
                      end
                   end;
                end;
               MySqlDataSet1.Next
            end;
         end;
    end;
end;

function TDrawGrap.selectTenPointFromFourFangxiang(var TD: TDoubleContourRecord;
  pt: TPoint;  min_Dao,Max_Dao,Min_Sup,Max_Sup,inv_Sup:integer): Boolean;
var
  Dao,Sup,i,j,C_i,Flag:integer;
  findB:Boolean;
  ArPt: array [0..16] of TKrigePoint;
  t_D,t_S,S_C,s_Count:integer;
  D_x,S_y:integer;
  Judge_Value:double;
  AGV_Data,Variance, Standard_Deviation:double; //均值方差与标准差
begin

   for I := 0 to 16 do  ArPt[i].DataV:=-1;
   findB:=False;
   Dao:=pt.X;Sup:=pt.Y;
   C_i:=1;Flag:=1; S_C:=0;   t_D:=0;t_S:=0;
   for I := 0 to 15 do    begin
        repeat
            if t_D< C_i then begin
               Dao:=Dao+Flag;   inc(t_D);
            end else if t_S<C_i then  begin
               Sup:=sup+Flag*inv_Sup;  inc(T_s);
            end else begin
              inc(C_i);
              Flag:=-Flag;
              t_S:=0;
              t_D:=0;
              Dao:=Dao+Flag;   inc(t_D);
            end;


            if (Dao<min_Dao) or ( Dao> Max_Dao ) or(sup<Min_Sup) or (Sup>Max_Sup) then begin
               Judge_Value:=-1;
            end else begin
               Judge_Value:=TD[Dao][sup].Krigvalue ;
            end;

            inc(S_C);
            if S_C >900  then    break;

       until (Judge_Value > 0 ) ;

       if S_C >900  then    break;
       if not( (Dao<min_Dao) or ( Dao> Max_Dao ) or(sup<Min_Sup) or (Sup>Max_Sup)) then begin
         ArPt[i].pt.X:=Dao;
         ArPt[i].pt.Y:=sup;
         ArPt[i].DataV:=TD[Dao][sup].Krigvalue;
       end;

   end;

    s_Count:=0; Variance:=0; AGV_Data:=0;
   // 计算 均值
    for I := 0 to 15 do
      if ArPt[i].DataV>0  then   begin
        AGV_Data:=AGV_Data+ArPt[i].DataV;
        inc(s_Count);
      end;
    if s_Count>0 then
       AGV_Data:=AGV_Data/ s_Count;

    //计算 方差
    for I := 0 to s_Count-1 do
       Variance:=Variance+sqr(ArPt[i].DataV- AGV_Data);
    Variance:=Variance/(s_Count-1);
    // 标准差
    Standard_Deviation:=sqrt(Variance);
    ArPt[16].pt.x:=pt.X;
    ArPt[16].pt.y:=pt.Y;
    if s_Count>0  then
      ArPt[16]:=Kriging(ArPt[16],ArPt,s_Count);

    TD[Dao][sup].Krigvalue:= ArPt[16].DataV;
    if TD[Dao][sup].Krigvalue > AGV_Data + Standard_Deviation then begin
       TD[Dao][sup].Krigvalue:=AGV_Data + Standard_Deviation;
    end else if TD[Dao][sup].Krigvalue < AGV_Data - Standard_Deviation then begin
       TD[Dao][sup].Krigvalue:=AGV_Data - Standard_Deviation;
    end;


end;

procedure TDrawGrap.SetChartAxisMaxAndMinValue(BottomAxis: TChartAxis;MaxV,MinV:double);
begin
    BottomAxis.Automatic :=False;
    BottomAxis.Minimum :=0;
    if MaxV <10 then    BottomAxis.Maximum:=10
         else   BottomAxis.Maximum := MaxV;
    if MinV< MaxV then  begin
       BottomAxis.Minimum :=MinV;
    end;
      // BottomAxis.Increment:=5;
end;

function TDrawGrap.SetMyDisPoseGrid(pt: TDisposeGrid): integer;
begin
    MyDisPoseGridNumber:=MyDisPoseGridNumber+1;
    setlength(MyDisPoseGrid,MyDisPoseGridNumber) ;
    MyDisPoseGrid[MyDisPoseGridNumber-1].x:=Pt.x;
    MyDisPoseGrid[MyDisPoseGridNumber-1].y:=pt.y;
    MyDisPoseGrid[MyDisPoseGridNumber-1].MaxData:=pt.MaxData;
    MyDisPoseGrid[MyDisPoseGridNumber-1].MzlData:=pt.MzlData;
    MyDisPoseGrid[MyDisPoseGridNumber-1].AGVData:=pt.AGVData;
    MyDisPoseGrid[MyDisPoseGridNumber-1].STime:=pt.x;
    Result:= MyDisPoseGridNumber;
end;




procedure TDrawGrap.SetProcegressBarVisual(palen: TPanel; First,
  Second: TProgressBar; Value: Boolean; Max1, Max2: Integer);
begin
   if Value then  begin
     CreateFromWait(Application.Handle ) ;
     First.Max:=Max1;
     Second.Max:=Max2;
     palen.Visible:=true;
     First.Position:=0;
     Second.Position:=0;
   end else begin
      CloseFromWait;
      palen.Visible:=False;
   end;

end;


procedure TDrawGrap.SetYunColorType(Value: integer);
begin
    UsedYunTuColorTypeId:=Value;
end;

procedure TDrawGrap.StepProcegressBar(First, Second: TProgressBar; step1,
  step2: integer);
begin
   if step1>0 then begin
      if First.Position+step1 > First.Max then
         First.Position:=0;

      First.StepBy(step1);
      Second.Position :=0;
   end;

   if step2>0 then begin
      if Second.Position+step2 > Second.Max then
         Second.Position:=0;
       Second.StepBy(step2);
   end;

end;



function TDrawGrap.updateChartImage(TwoDimImage: Timage; Chart: TChart;
  ThirdSeries: TSurfaceSeries; FirPB,
  SecPB: TProgressBar): Boolean;
begin
     Result:=FALSE;

     if  not  InitCloud_TwoDim_Image(TwoDimImage)  then   exit;

       MakeCloudCaption(TwoDimImage);  //二维初始化
       Make_Two_Dim_axis(TwoDimImage);//画二维云图坐标轴
       InitThreeDimChart(Chart,ThirdSeries); //三维初始化
       Make_ThreeDim_axis_Chart(Chart);  //制作三维坐标轴

     if CloudClass.YunTu_DataClass=Cycle then  begin
        if not ComputerTwoDimCloudCyclePoint then  exit;    // 循环进尺数据 二维云图

        Make_Two_Dim_Image(TwoDimImage,Cycle); // 画循环进尺数据二维的图片
        Make_Two_Dim_Grid(TwoDimImage );//画循环进尺数据二维网格线
        Make_Three_Dim_Cycle_CloudChart(ThirdSeries,SecPB); // 循环进尺数据的三维云图

     end else if CloudClass.YunTu_DataClass=DisposeData then begin
         FillDisPoseGrid;  // 按照网格密度补充  处理过的数据
         ComputerTwoDimCloudDisposePoint; //二维处理过的数据进行处理
         Make_Two_Dim_Image(TwoDimImage,DisposeData); // 画处理数据二维的图片
         Make_Two_Dim_Grid(TwoDimImage );//画处理数据二维网格线
//         Make_Three_Dim_Dispose_CloudChart(ThirdSeries,SecPB); //制作处理数据三维云图
     end else if CloudClass.YunTu_DataClass=ManualInput  then begin  // 手动录入数据的曲线图
        if not ComputerTwoDimCloudCyclePoint then  exit;    // 循环进尺数据 二维云图

        Make_Two_Dim_Image(TwoDimImage,ManualInput); // 画循环进尺数据二维的图片
        Make_Two_Dim_Grid(TwoDimImage );//画循环进尺数据二维网格线
      //  Make_Three_Dim_Cycle_CloudChart(ThirdSeries,SecPB); // 循环进尺数据的三维云图
     end;


     Result:=TRUE;
end;

function TDrawGrap.UseFGzmInitPStope: Boolean;
{
    初始化工作面的类，把工作面参数填满
}
Var
  Gzm_simple,Gzm_Difficult,Zk_Str:String;
  ZhiJia:string;
  footage:double;
begin
    Result :=False;
    MainDataModule.ReadPublicUsedMkInfoFromFile;
    FGzm.setGzmNumber(Public_Basic.StrToInt_lu(MainDataModule.WorkFace_id));
    if not FGzm.ReadData then begin
        Public_Basic.MY_WriteLog('ReadData is Eorr!','[TCallPStope]') ;
        exit;
    end;
    //获得工作面录入进尺
    Footage:= (DataTimeAndFootAge.UpperEndFootage+DataTimeAndFootAge.DownEndFootage)/2;
    if not Fgzm.RefreshFootage(Footage)  then begin
       Public_Basic.MY_WriteLog('RefreshFootage is Eorr!','[TCallPStope]') ;
       exit;
    end;

    // GetGzmZkStr
    if not FGzm.GetGzmZkStr(Gzm_simple,Gzm_Difficult,Zk_Str)  then begin
       Public_Basic.MY_WriteLog('GetGzmZkStr is Eorr!','[TCallPStope]') ;
       exit;
    end;
    //GetzhijiaStr
    if not FGzm.GetSupportStr(ZhiJia)  then begin
       Public_Basic.MY_WriteLog('No Bulling Support Information!','[TCallPStope]') ;
       ZhiJia:='ZJ:综采,ZY13000/25/50,1.75,5,2.6,2,2.5,13000,1.46,2,.5,';
    end;
    Result:=True;

end;

{ TOldOneStep }

procedure TOldOneStep.AddPoint(pt: TDoublePoint);
begin
   Pointcount:=Pointcount+1;
   setLength(Points,Pointcount);

   Points[Pointcount-1].x :=pt.X;
   Points[Pointcount-1].Y :=Pt.Y;
   if Pointcount =1 then   begin
      Points[Pointcount-1].PrvId := -1;
   end else if Pointcount >1 then begin
      Points[Pointcount-1].PrvId := Pointcount-2;
      Points[Pointcount-2].Nextid:=Pointcount-1;
   end;
      Points[Pointcount-1].Nextid :=-1;
   //
   setlength(Point_Int,Pointcount) ;
   Point_Int[Pointcount-1].x :=Round(pt.X);
   Point_Int[Pointcount-1].Y :=Round(Pt.Y);
end;

procedure TOldOneStep.CalculateStep(TDC: TDoubleContourRecord);
var
  i,j,k,l:integer;
begin
    //第一步 计算每一个循环内不同支架的相关参数
     FillSupportStepInfo(TDC);
    //第二步 对整个来压情况进行综合
     OneStepInfo:=FillOneStepInfo(OneStepInfo,SupStep,Round(StartSup),Round(StartSup),Round(EndSup));

end;

procedure TOldOneStep.ClearPoints;
var
  i:integer;
begin
   setlength(Points,0)  ;
   setlength(Point_Int,0);

   Pointcount:=0;
   StartSup:=10000;
   StartDao:=10000;
   EndSup:=0;
   EndDao:=0;
   for I := 0 to 7 do  begin
      MyOutLinePoint[i].Point.x:=0;
      MyOutLinePoint[i].Point.y:=0;
      MyOutLinePoint[i].PointId:=-1;
   end;
end;

procedure TOldOneStep.CopyThisClass(Source: TOldOneStep);
var
  i:integer;
begin
    OneStepInfo := Source.OneStepInfo ;
    Setlength(SupStep,High(Source.SupStep)+1);
    for I := 0 to High(Source.SupStep) do
       SupStep[i]:= Source.SupStep[i];

end;

constructor TOldOneStep.Create;
begin
   Pointcount:=0;
   startsup:=0;;
   endsup:=0;
   startDao:=0;
   endDao:=0;
   MapSeriesIndex:=-1;
   Used:=1;
   ModifyData:=0;
end;

destructor TOldOneStep.Destroy;
begin
   ClearPoints;
end;

function TOldOneStep.FillOneStepInfo(OneStep:TcomprehensiveOldStep;ASup:Array of TOneSupportStep;
                 FirstArryid,St_Sup,End_Sup:integer ):TcomprehensiveOldStep;
{所有支架信息处理完毕后，处理本次来压整体信息
  OneStep 记录集合
  ASup  支架数据
  FirstArryid 支架数组 第一个下标 代表的 支架编号
  St_Sup 支架开始编号
  End_Sup 支架结束编号
}
var
  i,k:integer;
begin
   OneStep.Count :=0;
   OneStep.AGVData :=0;

   OneStep.startDao :=100000;    OneStep.StartDao_id :=-1;
   OneStep.endDao :=0;         OneStep.EndDao_id :=-1;
   OneStep.StartSup:=100000;     OneStep.StartSup_id :=-1;
   OneStep.endsup :=0;         OneStep.EndSup_id :=-1;

   OneStep.MaxData :=0;        OneStep.MaxData_id :=-1;
   OneStep.MinData :=10000;     OneStep.MinData_id:=-1;
   OneStep.start_maxDao:=0;    OneStep.Start_MaxDao_id :=-1;
   OneStep.Start_minDao:=100000; OneStep.Start_MinDao_id :=-1;
   OneStep.End_MaxDao :=0;       OneStep.End_MinDao :=100000;
   OneStep.Step_MaxWide_Dao:=0; OneStep.Step_MaxWide_Dao_id:=-1;  // 区域最宽处 刀数与编号
   OneStep.Step_MinWide_Dao:=100000;OneStep.Step_MinWide_Dao_id:=-1;

   for k := St_Sup to End_Sup  do  begin
       i:=k-FirstArryid;
       if ASup[i].Count<1 then  continue;
       OneStep.AGVData:=OneStep.AGVData+ASup[i].AGVData *ASup[i].Count ;
       OneStep.Count :=OneStep.Count +ASup[i].Count ;
       {最小进刀}
       if ASup[i].startDao< OneStep.startDao then begin
          OneStep.startDao:=Round(ReturnMin(ASup[i].startDao, OneStep.startDao));
          OneStep.StartDao_id :=i;
       end;
       {最小支架}
        if ASup[i].Supportbh < OneStep.StartSup then begin
          OneStep.StartSup:=Round(ReturnMin(ASup[i].Supportbh, OneStep.StartSup));
          OneStep.StartSup_id :=i;
       end;
       {最大支架}
       if ASup[i].Supportbh > OneStep.EndSup then begin
          OneStep.EndSup:=Round(ReturnMax(ASup[i].Supportbh, OneStep.EndSup));
          OneStep.EndSup_id :=i;
       end;
       {最大进刀}
       if ASup[i].endDao > OneStep.EndDao then begin
          OneStep.EndDao:=Round(ReturnMax(ASup[i].endDao, OneStep.EndDao));
          OneStep.EndDao_id :=i;
       end;
       {最大压力值}
       if ASup[i].MaxData>OneStep.MaxData  then  begin
          OneStep.MaxData:=ReturnMax(ASup[i].MaxData ,OneStep.MaxData );
          OneStep.MaxData_id:=i;
          OneStep.MaxData_Sup :=k;
          OneStep.MaxData_Dao:=ASup[i].MaxDataDao;
       end;
       {最小压力值}
       if ASup[i].MinData < OneStep.MinData  then  begin
          OneStep.MinData:=ReturnMin(ASup[i].MinData ,OneStep.MinData );
          OneStep.MinData_id:=i;
          OneStep.MinData_Sup :=k;
          OneStep.MinData_Dao:=ASup[i].MinDataDao;
       end;
       {最大开始刀数}

       if ASup[i].startDao > OneStep.Start_maxDao then begin
          OneStep.Start_maxDao:=Round(ReturnMax(ASup[i].startDao, OneStep.Start_maxDao));
          OneStep.Start_MaxDao_id :=i;
       end;

       {最小开始刀数}
       if ASup[i].startDao < OneStep.Start_MinDao then begin
          OneStep.Start_MinDao:=Round(ReturnMin(ASup[i].startDao, OneStep.Start_MinDao));
          OneStep.Start_MinDao_id :=i;
       end;

       {最大结束刀数}

       if ASup[i].endDao > OneStep.End_MaxDao then begin
          OneStep.End_MaxDao:=Round(ReturnMax(ASup[i].endDao, OneStep.End_MaxDao));

       end;

       {最小结束刀数}
       if ASup[i].endDao < OneStep.End_MinDao then begin
          OneStep.End_MinDao:=Round(ReturnMin(ASup[i].endDao, OneStep.End_MinDao));

       end;


       {最宽的编号}
       if  OneStep.Step_MaxWide_Dao < ASup[i].endDao -ASup[i].startDao +1 then begin
           OneStep.Step_MaxWide_Dao:= ASup[i].endDao -ASup[i].startDao +1;
           OneStep.Step_MaxWide_Dao_id :=i;
       end;

       {最窄的编号}
       if  OneStep.Step_MinWide_Dao > ASup[i].endDao -ASup[i].startDao +1 then begin
           OneStep.Step_MinWide_Dao:= ASup[i].endDao -ASup[i].startDao +1;
           OneStep.Step_MinWide_Dao_id :=i;
       end;


   end;
   //  有效性判定
       if OneStep.startDao > 90000 then OneStep.startDao:=Round(startDao);
      {最小支架}
       if OneStep.StartSup > 90000  then  OneStep.StartSup:=Round(startsup);
       {最大支架}
       if OneStep.EndSup <0  then  OneStep.EndSup:=Round(endsup);
       {最大进刀}
       if OneStep.EndDao < 0 then  OneStep.EndDao:=Round(endDao);
       {最大压力值}
       if OneStep.MaxData <0 then OneStep.MaxData:=0;
       {最小压力值}
       if OneStep.MinData >90000  then  OneStep.MinData:=0;
       {最大开始刀数}
       if  OneStep.Start_maxDao <0  then   OneStep.Start_maxDao:=  Round(startDao);
       {最小开始刀数}
       if  OneStep.Start_MinDao >90000 then   OneStep.Start_MinDao:=  Round(startDao);
       {最大结束刀数}
       if  OneStep.End_MaxDao <0  then   OneStep.End_MaxDao:=  Round(EndDao);
       {最小结束刀数}
       if  OneStep.End_MinDao >90000 then   OneStep.End_MinDao:=  Round(EndDao);
       {最宽的编号}
       if  OneStep.Step_MaxWide_Dao < 0 then  OneStep.Step_MaxWide_Dao:=0;

       {最窄的编号}
       if  OneStep.Step_MinWide_Dao > 90000 then OneStep.Step_MaxWide_Dao:=0;
       //计算两个平均值
       OneStep.Start_AGVDao:= (OneStep.Start_maxDao+OneStep.Start_MinDao) div 2;
       OneStep.End_AGVDao:= (OneStep.End_MaxDao+OneStep.End_MinDao) div 2;

   if OneStep.Count >0 then
      OneStep.AGVData :=OneStep.AGVData / OneStep.Count;


   OneStep.SupportString:='';
   for k := St_Sup to End_Sup  do  begin
       i:=k-FirstArryid;
       if ASup[i].Count<1 then  continue;
       ASup[i].StepQd :=(ASup[i].AGVData -OneStep.AGVData )/OneStep.AGVData *100;
       if ASup[i].StepQd>0 then
            OneStep.SupportString:=OneStep.SupportString+
                       IntTostr(ASup[i].Supportbh) +',';
   end;

   Result:= OneStep;
end;

function TOldOneStep.FillSupportStepInfo(TDC: TDoubleContourRecord):Boolean;
var
  SupNumber,PrvCount,NexCount,i,j:integer;
  pt:Tpoint;
  tmp:Double;
  Gen_Time:TdateTime;
begin
   SupNumber:=0;PrvCount:=0;NexCount:=0;
   SupNumber:=Round(EndSup)-Round(StartSup)+1;
   Setlength(SupStep,0);
   if SupNumber < 1 then  exit;
   Setlength(SupStep,SupNumber);
   for I := 0 to SupNumber-1 do  begin
      SupStep[i].Supportbh :=Round(StartSup)+i;
      SupStep[i].MaxData :=0;
      SupStep[i].MinData :=1000;
      SupStep[i].AGVData :=0;
      SupStep[i].StepQd :=0;
      SupStep[i].startDao:=-1;
      SupStep[i].Count :=0;
      Gen_Time:=-1;
      pt.y:=Round(StartSup)+i;
       for j := Round(StartDao) to Round(EndDao) do  begin
          pt.x:=j;
          if IsPtInOutLine(pt)  then   begin
             if SupStep[i].startDao< 0 then  SupStep[i].startDao:=j;
             SupStep[i].endDao :=j;
             tmp:=self.ReturnSupData(TDc,pt,Gen_Time);
             if tmp<=0 then continue;

             if tmp>SupStep[i].MaxData then  begin
                SupStep[i].MaxData:=ReturnMax(tmp,SupStep[i].MaxData);
                SupStep[i].MaxDataDao:= j;
                SupStep[i].MaxDataTime:= Gen_Time;
             end;

             if tmp < SupStep[i].MinData then  begin
                SupStep[i].MinData:=ReturnMin(tmp,SupStep[i].MinData);
                SupStep[i].MinDataDao:=j;
             end;


             SupStep[i].AGVData :=SupStep[i].AGVData +tmp;
             SupStep[i].Count:=SupStep[i].Count+1;
          end;
       end;

      if SupStep[i].Count>0 then
         SupStep[i].AGVData:=SupStep[i].AGVData/SupStep[i].Count;
   end;




end;

procedure TOldOneStep.FromOneStepInfoExactDataIntoOutLine;

begin
   Startsup:=OneStepInfo.StartSup ;
   EndSup:=OneStepInfo.EndSup ;
   StartDao:=OneStepInfo.StartDao ;
   EndDao:=OneStepInfo.EndDao ;
   //下面排列七个点
   MyOutLinePoint[0].Point.x:=Round(StartDao+(EndDao-StartDao)/2);
   MyOutLinePoint[0].Point.y:=OneStepInfo.EndSup;

   MyOutLinePoint[1].Point.x:=OneStepInfo.StartDao;
   MyOutLinePoint[1].Point.y:=OneStepInfo.EndSup;

   MyOutLinePoint[2].Point.x:=OneStepInfo.StartDao;
   MyOutLinePoint[2].Point.y:=Round(Startsup+(EndSup-Startsup)/2);

   MyOutLinePoint[3].Point.x:=OneStepInfo.StartDao;
   MyOutLinePoint[3].Point.y:=OneStepInfo.Startsup;

   MyOutLinePoint[4].Point.x:=  MyOutLinePoint[0].Point.x;
   MyOutLinePoint[4].Point.y:=OneStepInfo.Startsup;

   MyOutLinePoint[5].Point.x:=OneStepInfo.EndDao;
   MyOutLinePoint[5].Point.y:=OneStepInfo.Startsup;

   MyOutLinePoint[6].Point.x:= OneStepInfo.EndDao;
   MyOutLinePoint[6].Point.y:=MyOutLinePoint[2].Point.y;

   MyOutLinePoint[7].Point.x:=OneStepInfo.EndDao;
   MyOutLinePoint[7].Point.y:=OneStepInfo.EndSup;


end;

function TOldOneStep.GetDispTitle: String;
var
 Str:String;
begin
     Str:='进刀:'+FormatFloat('0',startDao)+'-'+FormatFloat('0',EndDao) ;
     Str:=Str+ '  架号:'+FormatFloat('0',startsup)+'-'+FormatFloat('0',Endsup) ;
     Str:=Str+'  区域';
     Result:=str;
end;

function TOldOneStep.GetMaxDao: Double;
begin
    Result:=StartDao;
end;

function TOldOneStep.GetMinDao: double;
begin
    Result:=StartDao;
end;

procedure TOldOneStep.InsertPoint(ProPt, NextPt, InPt: TDoublePoint);
var
  ProId,Nextid:integer;
begin
   Pointcount:=Pointcount+1;
   setLength(Points,Pointcount);
   Points[Pointcount-1].x :=InPt.X;
   Points[Pointcount-1].Y :=InPt.Y;
   //
   ProId:=NextPt.PrvId;
   Nextid:=ProPt.Nextid;

   Points[ProId].Nextid := Pointcount-1;

   Points[Pointcount-1].PrvId:= ProId;
   Points[Pointcount-1].Nextid:=Nextid;
   Points[Nextid].PrvId := Pointcount-1;;


end;

function TOldOneStep.IsPtInOutLine(pt: TPoint): Boolean;
{*------------------------------------------------------------------------------
  判断指定的点是否在 多边形圈定的区域
------------------------------------------------------------------------------*}
var
  i:integer;

  iPoints:Array [0..7] of TPoint;

begin
    for I := 0 to 7 do
      iPoints[i]:=MyOutLinePoint[i].Point;

    Result:=PointInPolygon(Pt,iPoints);
end;


function TOldOneStep.IsPtIn_PointPoly(Pt1: TPoint): Boolean;
 {*------------------------------------------------------------------------------
  判断指定的点是否在 多边形圈定的区域
------------------------------------------------------------------------------*}
begin
    Result:=PointInPolygon(pt1,Point_Int);
end;

function TOldOneStep.JudgeThisStepIsEfficient(var S_Sup, E_Sup, S_Dao,
  E_Dao: integer; Con_Sup,Con_Dao:integer): Boolean;
{
   该函数主要实现对圈定的区域进行液压支架编号有效性校验
   校验的主要目的是：
      保证区域液压有效性，防止出现 具体某点强制突出的现象
   该函数执行的原则是：
   （1） 首先把区域进行圈定
   （2） 在提取外框8个点进入 MyOutLinePoints 数组
   （3） 对8个点组成的区域进行 有效性判断
   数据有效性判定的原则是：
   （1） 寻找落入圈定区域的 支架开始 数量大于 con_Sup d的支架 编号
   （2） 寻找落入圈定区域的 支架结束 数量大于 con_Sup d的支架 编号
   （3） 寻找落入圈定区域的 进刀开始 数量大于 con_Sup d的支架 编号
   （4） 寻找落入圈定区域的 进到结束 数量大于 con_Sup d的支架 编号


}
var
  SupNumber,DaoNumber:integer;
  i,j:integer;
  pt:Tpoint;
  tmp:Double;
  Sup_Temp,Dao_Temp:Array of Integer;
begin

   S_Sup:=0; E_Sup:=0; S_Dao:=0; E_Dao:=0;
   SupNumber:=Round(EndSup)-Round(StartSup)+1;
   DaoNumber:=Round(endDao)-Round(startDao)+1;
   Setlength(Sup_Temp,SupNumber);
   Setlength(Dao_Temp,DaoNumber);

   Result:=False;
   // 整体记录 落在这个区域 某个支架的进刀数
   for I := 0 to SupNumber-1 do  begin
      Sup_Temp[i]:=0;
      pt.y:=Round(StartSup)+i;
       for j := Round(StartDao) to Round(EndDao) do  begin
          pt.x:=j;
          if IsPtInOutLine(pt)  then
             inc(Sup_Temp[i]);

       end;
   end;
    // 整体记录 落在这个区域 某刀的支架数
   for I := 0 to DaoNumber-1 do  begin
      Dao_Temp[i]:=0;
      pt.x:=Round(StartDao)+i;
       for j := Round(StartSup) to Round(EndSup) do  begin
          pt.y:=j;
          if IsPtInOutLine(pt)  then
             inc(Dao_Temp[i]);
       end;
   end;
  // 查找 连续进刀的最小支架编号
  for I := 0 to SupNumber-1 do
     if Sup_Temp[i]>=Con_Dao then  begin
        S_Sup:= Round(StartSup)+i;
        break;
     end;
    // 查找 连续进刀的最大支架编号
  for I := SupNumber-1 Downto 0 do
     if Sup_Temp[i]>=Con_Dao then  begin
        E_Sup:= Round(StartSup)+i;
        break;
     end;
    // 查找 连续支架的最小进刀数
  for I := 0 to DaoNumber-1 do
    if Dao_Temp[i]>=Con_Sup  then   begin
       S_Dao:= Round(StartDao)+i;
       break
    end;
     // 查找 连续支架的最大进刀数
  for I := DaoNumber-1 Downto 0 do
    if Dao_Temp[i]>=Con_Sup  then   begin
       E_Dao:= Round(StartDao)+i;
       break
    end;

  if (S_Sup>0) and (E_Sup>0 ) and (S_Dao>0) and (E_Dao>0) then
      if (E_Sup-S_Sup>= Con_Sup /2 ) and (E_Dao-S_Dao >=Con_Dao /2 )then
          Result:=True;
end;

function TOldOneStep.OutPoint(p1, p2, P3: TOutPoint): Boolean;
{ p1 p2 p3 逆时针 排列三个点
  判断 P2 在 P1--> P3 直线的外侧还是内侧
  如果为真 在外侧 否则 在那侧或者 在线上
}
var
  a1,a2:double;
begin
    Result:=False;
    if P3.Point.x=P1.Point.x then begin
       {如果 P1 与 P3 在一条垂线上 则 }
       a1:=(p2.Point.Y-p1.Point.y)/(P2.Point.x-P1.Point.x);
       if a1>0  then Result:=true;

    end else if P2.Point.x=p1.Point.x then  begin
       {如果在垂线上 }
       a1:=(p2.Point.Y-p1.Point.y);
       a2:=(p3.Point.Y-P1.Point.Y)/(P3.Point.x-P1.Point.x);
    end else begin
       {如果不在垂线上 }
       a1:=(p2.Point.Y-p1.Point.y)/(P2.Point.x-P1.Point.x);
       a2:=(p3.Point.Y-P1.Point.Y)/(P3.Point.x-P1.Point.x);
       if a2 >0  then   begin
          if (a1>0) and (a1<a2) then  Result:=true
       end else begin
          if (a1<0) and (a1<a2) then  Result:=true
       end;
    end;

end;

procedure TOldOneStep.Refresh;
var
  s_S,E_s,S_D,E_D:integer;
begin
   if not JudgeThisStepIsEfficient(s_S,E_s,S_D,E_D,ContinueSupport,ContinueJinDao) then  begin
      ModifyData :=5; //代表区域是局部区域 不代表整体来压
   end;
   startsup:=S_S;
   endsup:=E_s;
   startDao:=S_D;
   EndDao:=E_D;
end;

function TOldOneStep.Return_OutLine_Area(p1, p2, P3: TOutPoint): Double;
var
 Area:Double;
begin
    Area:= 0.5*(p1.point.x* (p2.point.Y-p3.point.y) +
                  p2.point.x* (p3.point.Y-P1.point.Y) +
                  p3.point.x* (p1.point.Y-p2.point.Y)   );
    Result:=Abs(Area);
end;

function TOldOneStep.Return_Whole_Area: Double;
var
  i:integer;
  SumArea:Double;
  p1,p2,p3:TOutPoint;
begin
   SumArea:=0;
   p1:=MyOutLinePoint[0];
   p2:=MyOutLinePoint[1];
   for I := 2 to 7 do begin
       p3:=MyOutLinePoint[i];
       SumArea:=SumArea+self.Return_OutLine_Area(p1,p2,p3);
       p2:=p3;
   end;
   Result:=SumArea;
end;

function TOldOneStep.ReturnMarkLabel: string;
var
  Mem1:TStringList;
begin
   Mem1:=TStringList.Create ;
   try
       Mem1.Add('本次来压信息如下：');
       if OneStepInfo.ModifyData =10 then  begin
         Mem1.Add('   来压性质：矿压显现显著区域');
       end else if   OneStepInfo.ModifyData =9 then  begin
         Mem1.Add('   来压性质：矿压显现明显区域');
       end else if  OneStepInfo.ModifyData =8 then  begin
         Mem1.Add('   来压性质：局部矿压异常区域');
       end else if  OneStepInfo.ModifyData =30 then  begin
         Mem1.Add('   来压性质：预测矿压显现显著');
       end else if  OneStepInfo.ModifyData =27 then  begin
         Mem1.Add('   来压性质：预测矿压显现明显');
       end;
       Mem1.Add('   支架 开始 于【'+IntTostr(OneStepInfo.StartSup )+'】号支架');
       Mem1.Add('   支架 结束 于【'+IntTostr(OneStepInfo.EndSup )+'】号支架');
       Mem1.Add('   进刀 开始 于【'+IntTostr(OneStepInfo.StartDao   )+'】刀');
       Mem1.Add('   进刀 结束 于【'+IntTostr(OneStepInfo.EndDao   )+'】刀');
       Mem1.Add('   来压最大压力【'+FormatFloat('0.00',OneStepInfo.MaxData   )+'】MPa');
       Mem1.Add('   期间  平均值【'+FormatFloat('0.00',OneStepInfo.AGVDAta   )+'】MPa');
       Mem1.Add('   压力强度系数【'+FormatFloat('0.00',OneStepInfo.AGVDataQD   )+'】均值为1');
       Mem1.Add('   面积强度系数【'+FormatFloat('0.00',OneStepInfo.AreaQD   )+'】均值为1');
       Mem1.Add('   综合强度系数【'+FormatFloat('0.00',OneStepInfo.AreaQD * OneStepInfo.AGVDataQD  )+'】均值为1');
       Mem1.Add('//======================');
       Mem1.Add('本次来压判断压力线【'+FormatFloat('0.00',OneStepInfo.JudgeLevelLineData )+'】MPa');

       if OneStepInfo.Step_move_MinFootage >0 then begin
           Mem1.Add('  来压步距下限【'+FormatFloat('0.0',OneStepInfo.Step_move_MinFootage)+ '】米');
           Mem1.Add('  来压步距上限【'+FormatFloat('0.0',OneStepInfo.Step_move_MaxFootage)+ '】米');

       end;
       if  OneStepInfo.Step_Obvious_Footage[1] >0 then begin
           Mem1.Add('  显著步距下限【'+FormatFloat('0.0',OneStepInfo.Step_Obvious_Footage[1])+ '】米');
           Mem1.Add('  显著步距上限【'+FormatFloat('0.0',OneStepInfo.Step_Obvious_Footage[0])+ '】米');

       end;

      if OneStepInfo.Step_Continue_Footage >0  then  begin
          Mem1.Add('  平稳推进距离【'+FormatFloat('0.0',OneStepInfo.Step_Continue_Footage)+ '】米');
      end;
          Mem1.Add('  压力较大支架【'+OneStepInfo.SupportString+ '】') ;
      Result:=Mem1.Text ;
   finally
      FreeAndNil(Mem1);
   end;
end;

function TOldOneStep.ReturnMax(x, y: double): double;
begin
     if X>y then     Result:=x
     else Result:=y;
end;

function TOldOneStep.ReturnMiddlePoint(P1, P3: TOutPoint): TOutPoint;
{
  本函数是寻找  P1--> p3 形成直线 外侧 面积 最大的点
}
var
  iP2,Pmax:TOutPoint;
  Currid :integer;
  Area,RA:double;
begin
    Area:=0;
    Currid:=P1.PointId;
    Pmax:=p1;
    while (Points[Currid].Nextid <> -1) and (Points[Currid].Nextid <> p3.PointId ) do  begin
         Currid:=Points[Currid].Nextid;
         ip2.point.x:=Round(Points[Currid].x);
         ip2.point.Y:=Round(Points[Currid].Y);
         ip2.PointId:= Currid;
         if  OutPoint (p1,ip2,p3) then begin
            {如果点在外侧 找 三点组成面积最大的点}
             RA:=Return_OutLine_Area(p1,ip2,p3);
             if (RA>Area) then  begin
               Area:=RA;
               Pmax:=ip2;
             end;
         end;
    end;
    Result:=Pmax;
end;

function TOldOneStep.ReturnMin(x, y: Double): Double;
begin
    if x> y then   Result:=y
       else Result:=x;
end;

function TOldOneStep.ReturnOutPtDoublePoint(pt: TDoublePoint): TOutPoint;
var
  Tp:TOutPoint;
begin
    Tp.Point.x:=trunc(pt.x);
    Tp.Point.Y:=trunc(pt.Y);
    Result:=Tp;
end;

function TOldOneStep.ReturnPt(pt: TDoublePoint): TPoint;
var
  Tp:TPoint;
begin
    Tp.X:=trunc(pt.x);
    Tp.Y:=trunc(pt.Y);
    Result:=Tp;

end;

function TOldOneStep.ReturnPtFromDoublePoint(pt: TDoublePoint): TPoint;
var
  Tp:TPoint;
begin
    Tp.X:=trunc(pt.x);
    Tp.Y:=trunc(pt.Y);
    Result:=Tp;
end;

function TOldOneStep.ReturnPtFromOutPoint(pt: TOutPoint): TPoint;
begin
end;

function TOldOneStep.ReturnSupData(TDC: TDoubleContourRecord;
  pt: TPoint;Var DT:TDateTime): Double;
var
  prvData,NextData:double;
  Sup,Dao:integer;
  PrvSup,NexSup:integer;
  DT1,DT2:TDateTime;
begin
   sup:=pt.Y;
   Dao:=pt.X;
   Result:=0;
   if TDC[Dao][Sup].DataType =1 then  begin
      Result:=TDC[Dao][Sup].UseData/TDC[Dao][Sup].UnitName ;
      DT:= TDC[Dao][Sup].generatetime;
      exit;
   end;

   PrvData:=0;
   NextData:=0;
   PrvSup:=Sup;
   while PrvSup > 1 do  begin
        PrvSup:=PrvSup-1;
        if TDC[Dao][PrvSup].DataType =1 then begin
           PrvData:=TDC[Dao][PrvSup].UseData/TDC[Dao][Sup].UnitName;
           DT1:= TDC[Dao][Sup].generatetime;
           break;
        end;

   end;
   if PrvSup=0 then  exit;
   NexSup:=Sup;
   while NexSup < length(TDC[Dao])-2 do begin
      NexSup:=NEXSup+1;
      if TDC[Dao][NexSup].DataType =1 then begin
           NextData:=TDC[Dao][NexSup].UseData/TDC[Dao][Sup].UnitName;
           DT2:= TDC[Dao][Sup].generatetime;
           break;
      end;
   end;
   if NexSup=length(TDC[Dao])-1 then  exit;

   Result:=PrvData+(NextData-PrvData)*(Sup-PrvSup)/(NexSup-PrvSup);
   DT:= (DT1+DT2)/2;

end;

procedure TOldOneStep.SelectIntPoint;
{

   对大于均值与小于均值的边界进行靠近取整
}
Var
  i:integer;
  AGVDao,AGVSup:double;
begin
   AGvDao:=(StartDao+EndDao)/2;
   AGVSup:=(StartSup+EndSup)/2;

   for I := 0 to Pointcount-1 do  begin
      if Points[i].x <= AGVDao then   begin
         Points[i].x:=Trunc(Points[i].x);
      end else begin
         Points[i].x:=Trunc(Points[i].x)+1;
      end;

      if Points[i].Y <= AGVSup then   begin
         Points[i].Y:=Trunc(Points[i].Y);
      end else begin
         Points[i].Y:=Trunc(Points[i].Y)+1;
      end;
   end;


end;

procedure TOldOneStep.setContinueSupport_Dao(Sup, Dao: integer);
begin
     ContinueSupport:=sup;
     ContinueJinDao:=Dao;
end;

procedure TOldOneStep.SetJudgeLevelLineDat(Value: Double);
begin
    OneStepInfo.JudgeLevelLineData:=Value;
end;

procedure TOldOneStep.SetMinAndMaxDao(Min_V, Max_V: double);
begin
     startDao:=Min_V;
     endDao:=Max_V;
end;

procedure TOldOneStep.SetMinAndMaxSup(Min_V, Max_V: double);
begin
   startsup:=Min_V;
   endsup:=Max_V;

end;

procedure TOldOneStep.SetMyOutLinePoint(id: integer; pt: TPoint);
begin
   MyOutLinePoint[id].Point.x:=pt.X;
   MyOutLinePoint[id].Point.y:=pt.Y;
end;

procedure TOldOneStep.setOutlinePoint;
var
  i:integer;
  MinSup,MaxSup,MinDao,MaxDao:integer;
begin
    MinSup:=10000;MinDao:=10000;
    MaxSup:=0;MaxDao:=0;

    if PointCount<1 then  exit;
    for I := 0 to PointCount-1 do  begin
        if MaxSup< Points[i].y then   begin
           { 支架最大的点}
           MaxSup:=Round(Points[i].y);
           MyOutLinePoint[0].point.x:=Round(Points[i].x);
           MyOutLinePoint[0].point.Y:=Round(Points[i].Y);
           MyOutLinePoint[0].PointId :=i;
        end;
        if MinSup > Points[i].y then   begin
           {支架最小的点}
           MinSup:=Round(Points[i].y);
           MyOutLinePoint[4].point.x:=Round(Points[i].x);
           MyOutLinePoint[4].point.Y:=Round(Points[i].Y);
           MyOutLinePoint[4].PointId :=i;
        end;

         if MaxDao < Points[i].x then   begin
            {进刀最大的点}
           MaxDao:=Round(Points[i].x);
           MyOutLinePoint[6].point.x:=Round(Points[i].x);
           MyOutLinePoint[6].point.Y:=Round(Points[i].Y);
           MyOutLinePoint[6].PointId :=i;
        end;

        if MinDao > Points[i].x then   begin
            {进刀最小的点}
           MinDao:=Round(Points[i].x);
           MyOutLinePoint[2].point.x:=Round(Points[i].x);
           MyOutLinePoint[2].point.Y:=Round(Points[i].Y);
           MyOutLinePoint[2].PointId :=i;
        end;
    end;

    MyOutLinePoint[1]:=ReturnMiddlePoint(MyOutLinePoint[0],MyOutLinePoint[2]);
    MyOutLinePoint[3]:=ReturnMiddlePoint(MyOutLinePoint[2],MyOutLinePoint[4]);
    MyOutLinePoint[5]:=ReturnMiddlePoint(MyOutLinePoint[4],MyOutLinePoint[6]);
    MyOutLinePoint[7]:=ReturnMiddlePoint(MyOutLinePoint[6],MyOutLinePoint[0]);

end;

{ TOldSteps }

procedure TOldSteps.AddLeftPoints(pt: TDoublePoint);
var
  Cur:integer;
begin
   LPC:=LPC+1;
   setLength(LeftPoints,LPC);

   Cur:= LPC-1;
   LeftPoints[Cur].x :=pt.X;
   LeftPoints[Cur].Y :=Pt.Y;

   if Cur =0 then   begin
      LeftPoints[0].PrvId := -1;
   end else if Cur >0 then begin
      LeftPoints[Cur].PrvId := Cur-1;
      LeftPoints[Cur-1].Nextid:=Cur;
   end;

   LeftPoints[Cur].Nextid :=-1;
end;

procedure TOldSteps.AddPoints(pt: TDoublePoint);
begin
   if LPC<1 then begin
      AddLeftPoints(pt);
   end else begin
      {如果支架不够1架，或者进尺小于1刀 无效点}
      if CalDis(LeftPoints[LPC-1],Pt)>=1.414  then
           AddLeftPoints(pt);
   end;


end;

function TOldSteps.AddSteps:TOldOneStep;
begin
   StepNumber:=StepNumber+1;
   setLength(inSteps,StepNumber);
       inSteps[StepNumber-1]:=TOldOneStep.Create ;
   inSteps[StepNumber-1].inn_InStep_id :=StepNumber-1;
   Result:=inSteps[StepNumber-1];

end;

function TOldSteps.CalArea(p1, p2, p3: TDoublePoint): Double;
var
 Area:Double;
begin
    Area:= 0.5*(p1.x* (p2.Y-p3.y) +
                  p2.x* (p3.Y-P1.Y) +
                  p3.x* (p1.Y-p2.Y)   );
    Result:=Abs(Area);

end;

procedure TOldSteps.CalculateComeStep(TDC: TDoubleContourRecord;FcD:Array of TContourFootageData;
                     Gzm:TGzm;SaveRecall:Boolean;MinDao,MaxDao:integer);
var
  i,j,count:Integer;
  Area:double;
 begin
   isCalComeStep:=true;
   SetMax_Min_Jindao(MinDao,MaxDao);
   Count:=0;  Area:=0;
    for I := 0 to length(ExSteps)-1 do   begin
        if ( ExSteps[i].Used <> 1)  then   continue;
        if ( ExSteps[i].ModifyData =2 ) or ( ExSteps[i].ModifyData = 3 )   then   continue;
        if ( ExSteps[i].startDao >=MinDao ) and (ExSteps[i].endDao <=MaxDao) then  begin
           {如果进刀数 在当前主要分析的范围内
            对进刀选择之内的已经保存的数据是否重新进行分析
           }
            if  SaveRecall then  begin
               { 如果确定进行重新分析
                 对进刀选择之内的已经保存的数据是否重新进行分析
               }
               if ExSteps[i].ModifyData =4 then  // 保存的 来压步距数据
                    ExSteps[i].ModifyData:=1;
            end else begin


            end;

        end else begin
           {如果进刀数 不在当前主要分析的范围内}
           if ExSteps[i].ModifyData =2 then  // 保存的 区域数据
             continue;
           if ExSteps[i].ModifyData =4 then  // 保存的 来压步距数据
             continue;
        end;

       {计算这个来压步距支架相关信息}
       ExSteps[i].CalculateStep(TDC);
       ExSteps[i].OneStepInfo.ExStepClassid :=ExSteps[i].inn_InStep_id ;

       if ExSteps[i].OneStepInfo.AGVData >0 then  begin
          inc(Count);
          ExSteps[i].OneStepInfo.AGVDataQD:=ExSteps[i].OneStepInfo.AGVData/ Whole_AGV_Data;
          Area:=Area+ExSteps[i].OneStepInfo.Count ;
       end;
    end;

    //所有的支架计算结束，开始总体评价
    if Count>0 then
        Area:=Area/count;


  // 计算所有步距的压力平均值
   for I := 0 to length(ExSteps)-1 do   begin
       if (ExSteps[i].Used <> 1)  then   continue;
       if ( ExSteps[i].ModifyData = 3 )  then   continue;
       if ( ExSteps[i].ModifyData = 2 )  then   continue;
       if ( ExSteps[i].ModifyData = 4 )  then   continue;

          ExSteps[i].OneStepInfo.AreaQD:=ExSteps[i].OneStepInfo.Count/Area;
          ExSteps[i].OneStepInfo.WholeQD :=ExSteps[i].OneStepInfo.AGVDataQD *
                                   ExSteps[i].OneStepInfo.AreaQD ;
          ExSteps[i].OneStepInfo.NormalQd :=ExSteps[i].OneStepInfo.MaxData / Whole_AGV_Data ;
       if ExSteps[i].OneStepInfo.WholeQD >=1  then  begin
          ExSteps[i].ModifyData :=10; // 老顶上位岩梁来压
          ExSteps[i].OneStepInfo.ModifyData :=10;
       end else if  ExSteps[i].OneStepInfo.WholeQD >=0.5  then  begin // 老顶下位岩梁来压
          ExSteps[i].ModifyData :=9; // 老顶下位岩梁来压
          ExSteps[i].OneStepInfo.ModifyData :=9;
       end else  if ExSteps[i].ModifyData =1 then begin
          ExSteps[i].ModifyData :=8; // 零星来压 估计是直接顶
          ExSteps[i].OneStepInfo.ModifyData :=8;
       end else begin
          ExSteps[i].ModifyData :=5; // 零星来压 估计是直接顶
          ExSteps[i].OneStepInfo.ModifyData :=5;
       end;
       // 给变量下一步与前一步 变量付初值
       ExSteps[i].OneStepInfo.NextStepCount :=0;
       ExSteps[i].OneStepInfo.ProStepCount :=0;
       ExSteps[i].OneStepInfo.Step_NO:=-1;
   end;

   // 首先对 上位岩梁来压进行步距查找
   for I := 0 to length(ExSteps)-1 do   begin
       if (ExSteps[i].Used <> 1)  then   continue;
       { 查找本次步距对应的下次步距信息
        只查找  老顶来压时的 步距，其他相关的步距 在此 不做判断
       }
       if ExSteps[i].ModifyData =10 then  begin
            SelectNextStepId(ExSteps[i],FCD,i);
       end;
   end;

    // 其次对 下位岩梁来压进行步距查找
   for I := 0 to length(ExSteps)-1 do   begin
       if (ExSteps[i].Used <> 1)  then   continue;
       { 查找本次步距对应的下次步距信息
        只查找  老顶来压时的 步距，其他相关的步距 在此 不做判断
       }
       if ExSteps[i].ModifyData =9 then  begin
            SelectNextStepId(ExSteps[i],FCD,i) ;
       end;
   end;
   // 对下位岩梁的次序进行重新排序
    for I := length(ExSteps)-1 downto 0 do   begin
       if (ExSteps[i].Used <> 1)  then   continue;
       if ExSteps[i].ModifyData =10 then  begin
          for j := length(ExSteps)-1 downto 0 do   begin
              if (ExSteps[j].Used <> 1)  then   continue;
              if (ExSteps[j].ModifyData =9 ) and (ExSteps[i].OneStepInfo.Step_NO =ExSteps[j].OneStepInfo.Step_NO )then
               if ExSteps[j].OneStepInfo.EndDao > ExSteps[i].OneStepInfo.EndDao then begin
                  ExSteps[j].OneStepInfo.Step_NO:= ExSteps[i].OneStepInfo.Step_NO    +1;
                  if ExSteps[j].OneStepInfo.ProStepCount<9 then begin
                     inc(ExSteps[j].OneStepInfo.ProStepCount );
                     ExSteps[j].OneStepInfo.ProStepClassID[ExSteps[j].OneStepInfo.ProStepCount-1]:=ExSteps[i].inn_InStep_id ;
                  end;
               end else begin
                  ExSteps[j].OneStepInfo.Step_NO:= ExSteps[i].OneStepInfo.Step_NO    -1;
                  if ExSteps[j].OneStepInfo.NextStepCount<9 then   begin
                      inc(ExSteps[j].OneStepInfo.NextStepCount  );
                      ExSteps[j].OneStepInfo.NextStepClassID[ExSteps[j].OneStepInfo.NextStepCount-1]:=ExSteps[i].inn_InStep_id ;
                  end;
               end;

          end;


       end;
    end;

   // 首先对 上位岩梁来压进行步距查找
   for I := 0 to length(ExSteps)-1 do   begin
       if (ExSteps[i].Used <> 1)  then   continue;
       if ExSteps[i].OneStepInfo.NextStepCount >0 then begin
           FindNextStepToFillOneInfo(ExSteps[i],FCD,true,Gzm);
        end else begin
           FindNextStepToFillOneInfo(ExSteps[i],FCD,False,Gzm);
        end;

   end;


end;

function TOldSteps.CalCulatePhaseStatistical_Data(FcD: TDoubleContourRecord;
        FDao:Array of TContourFootageData;Unit_KK:integer): Boolean;
var
   P,Dao,Sup,j,k:Integer;
begin
  for p := 0 to PhaseNumber-1 do  begin
        //初始化数据
        PhaseSteps[p].Statistical_data.Clear ;
       // 追加数据
       for Dao := 0 to High(fcD) do   // 遍历刀数
          for Sup := PhaseSteps[p].StartsupBh    to  PhaseSteps[p].EndSupBh   do
              if FcD[Dao][Sup].UseData > 0 then
                 PhaseSteps[p].Statistical_data.insertData(FcD[Dao][Sup].UseData / Unit_KK)   ;

      // 计算总体的 统计学数字
      PhaseSteps[p].Statistical_data.Caluate ;
      // 计算各个阶段的统计学数字
      PhaseSteps[p].CalPhaseAGVDAta(FcD,FDao); // 把数据放进 阶段内
      PhaseSteps[p].Cut_contour_AGVData; // 把阶段内的数据进行 区域剖切
      // 把数值填进 切分的类中   并计算相关统计数字
      for  j:= 0 to PhaseSteps[p].Step_Array_Count-1   do
           for k := 0 to PhaseSteps[p].PhaseAGV_Count-1 do  begin
             if (PhaseSteps[p].PhaseAGV_EvenDao[k].JinDao >=PhaseSteps[p].Step_Array[j].StartDao) and
                (PhaseSteps[p].PhaseAGV_EvenDao[k].JinDao <=PhaseSteps[p].Step_Array[j].EndDao)   then
                 PhaseSteps[p].Step_Array[j].insertData(PhaseSteps[p].PhaseAGV_EvenDao[k].AGVData) ;
               PhaseSteps[p].Step_Array[j].Caluate;
           end;


  end;


end;

procedure TOldSteps.CalculatePhaseStep(Gzm:TGzm;SaveRecall:Boolean;MinDao,MaxDao:integer);
var
  i,Stepid,Returnid:Integer;
  tmp:TcomprehensiveOldStep;
begin
    for I := 0 to PhaseNumber-1 do  begin
       //清理数据数组
       PhaseSteps[i].Clear ;
       phaseSteps[i].PhaseNumber :=i;
       phaseSteps[i].SetEndDao(MaxDao);
       //把最大进尺送进去
       phaseSteps[i].SetEndJinChi(MaxFootage);
       Stepid:=0;
       while Stepid < length(ExSteps) do  begin
            if ExSteps[Stepid].Used <> 1 then  begin
               inc(Stepid);
               continue; // 0 无效 2 删除
            end;

            if ExSteps[Stepid].ModifyData =3 then   begin
               inc(Stepid);
               continue;  // 3 预测步距
            end;
            if ExSteps[Stepid].ModifyData =2 then   begin
               inc(Stepid);
               continue;  // 2 保存区域数据
            end;
           //
            if (ExSteps[Stepid].startDao >=MinDao ) and (ExSteps[Stepid].endDao <=MaxDao) then  begin
                {如果进刀数 在当前主要分析的范围内
                 对进刀选择之内的已经保存的数据是否重新进行分析
                }
                if  SaveRecall then  begin
                   { 如果确定进行重新分析
                     对进刀选择之内的已经保存的数据是否重新进行分析
                   }
                    if ExSteps[i].ModifyData =4 then  // 保存的 来压步距数据
                       ExSteps[i].ModifyData:=1;
                end else begin


                end;

            end else begin
               {如果进刀数 不在当前主要分析的范围内}
                if ExSteps[Stepid].ModifyData =4 then  begin // 保存的 来压步距数据
                    inc(Stepid);
                    continue;
                end;
            end;

          // 查找相关本区域相关数据
          if phaseSteps[i].StepCount >0  then  begin
             Returnid:=SelectWhichStepInThisPhaseNumber ( Stepid,
                        phaseSteps[i].StartsupBh ,
                        phaseSteps[i].EndSupBh,
                        phaseSteps[i].Steps[phaseSteps[i].StepCount-1].StartDao,
                        phaseSteps[i].Steps[phaseSteps[i].StepCount-1].EndDao,
                        Gzm.RockPressAnalysis.JudgeMInQD
                        );
          end else begin
              Returnid:=SelectWhichStepInThisPhaseNumber ( Stepid,
                        phaseSteps[i].StartsupBh ,
                        phaseSteps[i].EndSupBh,
                        ExSteps[stepid].OneStepInfo.StartDao,
                        ExSteps[stepid].OneStepInfo.EndDao,
                        Gzm.RockPressAnalysis.JudgeMInQD
                        );
          end;

           if Returnid <0 then  begin
              inc(Stepid);
              continue; //
           end;

           if phaseSteps[i].StepCount >0  then  begin
               // 对来压有效性判定
               if (ExSteps[Returnid].OneStepInfo.startDao -
                       phaseSteps[i].Steps[phaseSteps[i].StepCount-1].EndDao   < Gzm.RockPressAnalysis.NearTwoStepDaoValue )  then begin //持续小于5刀

                  if ((ExSteps[Returnid].OneStepInfo.AreaQD > phaseSteps[i].Steps[phaseSteps[i].StepCount-1].AreaQD ) and
                     (ExSteps[Returnid].OneStepInfo.AreaQD >1) ) or
                     (ExSteps[Returnid].OneStepInfo.AGVDataQD > phaseSteps[i].Steps[phaseSteps[i].StepCount-1].AGVDataQD
                        *  Gzm.RockPressAnalysis.NearTwoStepAGvData_BS) then   begin
                         // 清洗数据
                          if  ExSteps[Returnid].ModifyData =1 then  begin// 如果等于1 需要对数据进行清洗了
                              tmp:=phaseSteps[i].CleanData(ExSteps[Returnid],ExSteps[Returnid].OneStepInfo);
                          end else if  ExSteps[Returnid].ModifyData =4 then begin  // 如果等于4 不需要需要对数据进行清洗了
                              tmp:=ExSteps[Returnid].OneStepInfo;
                          end;

                          if (tmp.EndSup -tmp.StartSup +1 >=Gzm.RockPressAnalysis.Continue_SupNumber  ) and
                              (tmp.EndDao- tmp.StartDao +1 >=Gzm.RockPressAnalysis.conTinue_DaoNumber )   then  begin
                                phaseSteps[i].Steps[phaseSteps[i].StepCount-1]:=tmp ;
                                phaseSteps[i].WithTwoStepFillPrevStepInfo(phaseSteps[i].StepCount-1 );
                          end;

                     end;

                   Stepid:=Returnid+1;
                   continue;
               end;

           end;
           //
           // 清洗数据
           if  ExSteps[Returnid].ModifyData =1 then  begin// 如果等于1 需要对数据进行清洗了
                tmp:=phaseSteps[i].CleanData(ExSteps[Returnid],ExSteps[Returnid].OneStepInfo);
            end else if  ExSteps[Returnid].ModifyData =4 then begin  // 如果等于4 不需要需要对数据进行清洗了
                tmp:=ExSteps[Returnid].OneStepInfo;
            end;

           if (tmp.EndSup -tmp.StartSup +1 >=Gzm.RockPressAnalysis.Continue_SupNumber  ) and
              (tmp.EndDao- tmp.StartDao +1 >=Gzm.RockPressAnalysis.conTinue_DaoNumber )   then  begin
                 phaseSteps[i].AddOneStep(tmp);
                 phaseSteps[i].WithTwoStepFillPrevStepInfo(phaseSteps[i].StepCount-1 );
              end;
           // 清理支架字符串
           if phaseSteps[i].StepCount >0  then  begin
                phaseSteps[i].Steps[phaseSteps[i].StepCount-1].SupportString :=self.SplitSupString(
                              phaseSteps[i].Steps[phaseSteps[i].StepCount-1].SupportString,
                              phaseSteps[i].StartsupBh, phaseSteps[i].EndSupBh  ) ;
           end;
           Stepid:=Returnid+1;
       end;

   end;


end;

procedure TOldSteps.CalCulatePhaseStep_Copy(Gzm: TGzm; SaveRecall: Boolean;
  MinDao, MaxDao: integer);
var
  p,j,t,m,k:Integer;
  tmp:TcomprehensiveOldStep;
begin
    for p := 0 to PhaseNumber-1 do  begin
       //清理数据数组
       PhaseSteps[p].Clear ;
       phaseSteps[p].PhaseNumber :=p;
       phaseSteps[p].SetStartDAo(MinDao);
       phaseSteps[p].SetEndDao(MaxDao);
       //把最大进尺送进去
       phaseSteps[p].SetEndJinChi(MaxFootage);
     for j := 0 to length(ExSteps)-1 do   begin
        if ( ExSteps[j].Used <> 1)  then   continue;
        if ( ExSteps[j].ModifyData =2 ) or ( ExSteps[j].ModifyData = 3 )   then   continue;
        if not (( ExSteps[j].startDao >=MinDao ) and (ExSteps[j].endDao <=MaxDao) ) then  begin
            {如果进刀数 不在当前主要分析的范围内}
           if ExSteps[j].ModifyData =2 then  // 保存的 区域数据
             continue;
           if ExSteps[j].ModifyData =4 then  // 保存的 来压步距数据
             continue;
        end;

         if (ExSteps[j].OneStepInfo.StartSup <=  phaseSteps[p].StartsupBh ) and
             (ExSteps[j].OneStepInfo.EndSup >=  phaseSteps[p].EndSupBh )  then    begin
            { 该来压区域完全包含 该区域}
            tmp:=ExSteps[j].OneStepInfo;
            tmp.StartSup := phaseSteps[p].StartsupBh;
            tmp.EndSup:= phaseSteps[p].EndSupBh;
         end else if (ExSteps[j].OneStepInfo.StartSup >  phaseSteps[p].StartsupBh ) and
                     (ExSteps[j].OneStepInfo.StartSup <=  phaseSteps[p].EndSupBh )  and
                     (ExSteps[j].OneStepInfo.EndSup >=  phaseSteps[p].EndSupBh )   then    begin
             { 该区域 结束支架在 区域的外部，开始支架在区域内}
            tmp:=ExSteps[j].OneStepInfo;
            tmp.EndSup:= phaseSteps[p].EndSupBh;
         end else if (ExSteps[j].OneStepInfo.EndSup >  phaseSteps[p].StartsupBh ) and
                 (ExSteps[j].OneStepInfo.EndSup <=  phaseSteps[p].EndSupBh )  and
                 (ExSteps[j].OneStepInfo.StartSup <=  phaseSteps[p].StartsupBh )   then    begin
             { 该区域 开始支架在 区域的外部，结束支架在区域内}
            tmp:=ExSteps[j].OneStepInfo;
            tmp.StartSup := phaseSteps[p].StartsupBh;
         end else if (ExSteps[j].OneStepInfo.StartSup >=  phaseSteps[p].StartsupBh ) and
                  (ExSteps[j].OneStepInfo.EndSup <=  phaseSteps[p].EndSupBh )    then    begin
             { 该区域 开始支架在 区域的内部，结束支架在区域内}
            tmp:=ExSteps[j].OneStepInfo;
         end else begin
            {该区域 与该阶段没有交集}
            continue;
         end;
         // 数据清洗
          tmp:=phaseSteps[p].CleanData(ExSteps[j],tmp);
         // 追加进类中
          phaseSteps[p].AddOneStep(tmp);
          //  清理支架字符串
           if phaseSteps[p].StepCount >0  then  begin
                phaseSteps[p].Steps[phaseSteps[p].StepCount-1].SupportString :=self.SplitSupString(
                              phaseSteps[p].Steps[phaseSteps[p].StepCount-1].SupportString,
                              phaseSteps[p].StartsupBh, phaseSteps[p].EndSupBh  ) ;
           end;

     end;
     // 把所有支架内的信息进行补全
     for t := 0 to phaseSteps[p].StepCount-1 do
        for m := 0 to phaseSteps[p].Steps[t].ProStepCount -1 do
            for k := 0 to t  do
               if phaseSteps[p].Steps[k].ExStepClassid = phaseSteps[p].Steps[t].ProStepClassID[m]  then
                     phaseSteps[p].WithTwoStepFillPrevStepInfo_Copy(phaseSteps[p].Steps[K],
                                       phaseSteps[p].Steps[t] );
   end;


end;

function TOldSteps.CalDis(pt1, pt2: TDoublePoint): double;
begin
   Result:=sqrt(sqr(pt1.X-pt2.x)+sqr(pt1.y-pt2.Y));
end;

function TOldSteps.CalPolygonArea_LeftPoints(Quan_start,
  Quan_End: integer): Double;
var
  Area:double;
  pt1,pt2,pt3:TDoublePoint;
begin
    Result:=0;
    pt1:=LeftPoints[Quan_Start];

    if (pt1.Nextid = Quan_End) or (pt1.Nextid =-1)  then exit;
    pt2:=LeftPoints[LeftPoints[Quan_Start].Nextid];


    if Pt2.Nextid=-1 then  exit;
       pt3:= LeftPoints[Pt2.Nextid];

    Area:=CalArea(pt1,pt2,pt3);
    while (pt3.Nextid <> -1) and (pt3.Nextid <= Quan_End) do begin
          pt2:=pt3;
          if (Pt2.Nextid <= Quan_End) and (Quan_End<>-1)  then  begin
             pt3:=LeftPoints[pt2.Nextid ];
             Area:=Area+CalArea(pt1,pt2,pt3);
          end else  break;
    end;
    Result:=Area;
end;

procedure TOldSteps.ClearPoint;
begin
  setlength(LeftPoints,0);
  LPc:=0;


end;

procedure TOldSteps.ClearSteps;
var
  i:integer;
begin
   self.ClearPoint ;
   for I := 0 to StepNumber-1 do
       if Assigned(inSteps[i]) then
          FreeandNil(inSteps[i]);
   StepNumber:=0;
   setlength(ExSteps,0);
   setlength(inSteps,0);
end;

procedure TOldSteps.ContinueFillStepInfo(CurrStep: TOldOneStep;
  FcD: array of TContourFootageData; finded:Boolean; Gzm: TGzm);
var
  prvFootage:Array [0..4 ] of double; // 0 最前 1 最后 3 最大步距    4 最小步距
  StartFootage, EndFootage:double;
  tmpDAo:integer;
  prvAGVSup:integer;
  NextStep:TOldOneStep;
begin
      if finded  then   begin // 表示找到了 后面的步距

         {找到本次运动步距}
         // CurrStep.OneStepInfo.NextStepClassID:=id;
         // NextStep:= ExSteps[id];
          {把当前步距进行赋值}
          // 结束最大值 等于下一个步距的 最大进刀
          CurrStep.OneStepInfo.Step_end_MAXDao :=NextStep.OneStepInfo.start_maxDao ;
          // 结束最小值 等于下一个步距的 最小进刀
          CurrStep.OneStepInfo.Step_end_MinDao:=NextStep.OneStepInfo.Start_minDao ;
          // 本次来压结束进刀的平均值 等于 最大与最小的均值
          prvAGVSup:=(CurrStep.OneStepInfo.startsup+CurrStep.OneStepInfo.endsup) div 2;

          {换算本次来压开始的最小进尺 主要通过上顺槽与下顺槽的差值实现}
          tmpDAo:=CurrStep.OneStepInfo.Start_MinDao ;
          if EffectJinDao(tmpDAo) then  begin
              StartFootage:=FcD[tmpDAo].Down_footage  + (FcD[tmpDAo].Upper_Footage-FcD[tmpDAo].Down_footage  ) *
                        prvAGVSup /Gzm.SupEndNumber ;
              CurrStep.OneStepInfo.start_minFootage:=StartFootage;
          end else begin
              StartFootage:=-1;
              CurrStep.OneStepInfo.start_minFootage:=StartFootage;
          end;

          {换算本次来压结束的最大进尺 主要通过上顺槽与下顺槽的差值实现}
          tmpDAo:=CurrStep.OneStepInfo.Step_end_MAXDao;
          if EffectJinDao(tmpDAo) then  begin
              EndFootage:=FcD[tmpDAo].Down_footage  + (FcD[tmpDAo].Upper_Footage-FcD[tmpDAo].Down_footage  ) *
                            prvAGVSup /Gzm.SupEndNumber ;
              CurrStep.OneStepInfo.Step_end_MaxFootage :=EndFootage;
          end else begin
              EndFootage:=-1;
              CurrStep.OneStepInfo.Step_end_MaxFootage :=EndFootage;
          end;
           {本次来压的最大行进步距}
          CurrStep.OneStepInfo.Step_Move_MaxFootage:= CurrStep.OneStepInfo.Step_end_MaxFootage -
                           CurrStep.OneStepInfo.start_minFootage;

           {换算本次来压开始的最大进尺 主要通过上顺槽与下顺槽的差值实现}
          tmpDAo:=CurrStep.OneStepInfo.Start_maxDao ;
          if EffectJinDao(tmpDAo) then  begin
              StartFootage:=FcD[tmpDAo].Down_footage  + (FcD[tmpDAo].Upper_Footage-FcD[tmpDAo].Down_footage  ) *
                            prvAGVSup /Gzm.SupEndNumber ;
              CurrStep.OneStepInfo.start_maxFootage:=StartFootage;
          end else begin
              StartFootage:=-1;
              CurrStep.OneStepInfo.start_maxFootage:=StartFootage;
          end;


           {换算本次来压结束的最小进尺 主要通过上顺槽与下顺槽的差值实现}
          tmpDAo:=CurrStep.OneStepInfo.Step_end_MinDao;
           if EffectJinDao(tmpDAo) then  begin
              EndFootage:=FcD[tmpDAo].Down_footage  + (FcD[tmpDAo].Upper_Footage-FcD[tmpDAo].Down_footage  ) *
                            prvAGVSup /Gzm.SupEndNumber ;
              CurrStep.OneStepInfo.Step_end_MinFootage:= EndFootage;
           end else begin
               EndFootage:=-1;
               CurrStep.OneStepInfo.Step_end_MinFootage:= EndFootage;
           end;

           {本次来压的最小行进步距}
          CurrStep.OneStepInfo.Step_move_MinFootage:=  CurrStep.OneStepInfo.Step_end_MinFootage-
                             CurrStep.OneStepInfo.start_maxFootage;

          {本次来压的平均结束进尺}
          CurrStep.OneStepInfo.Step_end_AGVFootage:=(CurrStep.OneStepInfo.Step_end_MinFootage+
                                   CurrStep.OneStepInfo.Step_end_MaxFootage) /2;
          {本次来压的平均行进步距}
          CurrStep.OneStepInfo.Step_Move_AGV_Footage:=(CurrStep.OneStepInfo.Step_Move_MaxFootage+
                                  CurrStep.OneStepInfo.step_Move_MinFootage)/2 ;

          {计算本次循环显著步距的主要参数}
          {中间支架的开始时的最小进刀转换为最小进尺}
          tmpDAo:=CurrStep.OneStepInfo.Start_MinDao ;
           if EffectJinDao(tmpDAo) then  begin
               prvFootage[0]:= FcD[tmpDAo].Down_footage  + (FcD[tmpDAo].Upper_Footage-FcD[tmpDAo].Down_footage  ) *
                        prvAGVSup /Gzm.SupEndNumber ;
           end else begin
                prvFootage[0]:=-1;
           end;

          {中间支架的开始时的最大进刀转换为最大进尺}
          tmpDAo:=CurrStep.OneStepInfo.Start_maxDao ;
          prvFootage[1]:= FcD[tmpDAo].Down_footage  + (FcD[tmpDAo].Upper_Footage-FcD[tmpDAo].Down_footage  ) *
                        prvAGVSup /Gzm.SupEndNumber ;

          {中间支架的 支架运动最宽处开始 时的进刀转换为进尺}
          tmpDAo:=CurrStep.SupStep[CurrStep.OneStepInfo.Step_MaxWide_Dao_id].startDao ;
           if EffectJinDao(tmpDAo) then  begin
              StartFootage:=FcD[tmpDAo].Down_footage  + (FcD[tmpDAo].Upper_Footage-FcD[tmpDAo].Down_footage  ) *
                            prvAGVSup /Gzm.SupEndNumber ;
           end else begin
              StartFootage:=-1;
           end;
           {中间支架的 支架运动最宽处结束 时的进尺}
          tmpDAo:=CurrStep.SupStep[CurrStep.OneStepInfo.Step_MaxWide_Dao_id].endDao+1 ;
          if EffectJinDao(tmpDAo) then  begin
              EndFootage:=FcD[tmpDAo].Down_footage  + (FcD[tmpDAo].Upper_Footage-FcD[tmpDAo].Down_footage  ) *
                            prvAGVSup /Gzm.SupEndNumber ;
          end else begin
               EndFootage:=-1;
          end;
           {中间支架的 最大运动显著运动步距}
          prvFootage[2]:= EndFootage-StartFootage;

           {中间支架的 支架运动最窄处开始 时的进刀转换为进尺}
          tmpDAo:=CurrStep.SupStep[CurrStep.OneStepInfo.Step_MinWide_Dao_id].startDao ;
          if EffectJinDao(tmpDAo) then  begin
              StartFootage:=FcD[tmpDAo].Down_footage  + (FcD[tmpDAo].Upper_Footage-FcD[tmpDAo].Down_footage  ) *
                            prvAGVSup /Gzm.SupEndNumber ;
          end else begin
              StartFootage:=-1;
          end;
           {中间支架的 支架运动最窄处结束时的进尺}
          tmpDAo:=CurrStep.SupStep[CurrStep.OneStepInfo.Step_MinWide_Dao_id].endDao+1 ;
          if EffectJinDao(tmpDAo) then  begin
              EndFootage:=FcD[tmpDAo].Down_footage  + (FcD[tmpDAo].Upper_Footage-FcD[tmpDAo].Down_footage  ) *
                        prvAGVSup /Gzm.SupEndNumber ;
          end else begin
              EndFootage:=-1;
          end;
           {中间支架的 最小运动显著运动步距}
          prvFootage[3]:= EndFootage-StartFootage;

          {显著运动步距数值保存}
          CurrStep.OneStepInfo.Step_Obvious_Footage[0] :=prvFootage[2];  //最大值
          CurrStep.OneStepInfo.Step_Obvious_Footage[1] :=prvFootage[3];  // 最小值
          CurrStep.OneStepInfo.Step_Obvious_Footage[2] :=(prvFootage[2]+prvFootage[3])/2;   //平均值
          {持续步距  平均运动步距减去 显著运动步距的平均值}
          CurrStep.OneStepInfo.Step_Continue_Footage :=CurrStep.OneStepInfo.Step_MOVE_AGV_Footage -
                          CurrStep.OneStepInfo.Step_Obvious_Footage[2];

      end else begin   // 表示没有找到后面的步距 把当前部分数据填满

          {最小开始进刀转换为进尺}
         // CurrStep.OneStepInfo.NextStepClassID:=-1;
          tmpDAo:=CurrStep.OneStepInfo.Start_MinDao ;
           if EffectJinDao(tmpDAo) then  begin
                StartFootage:=FcD[tmpDAo].Down_footage  + (FcD[tmpDAo].Upper_Footage-FcD[tmpDAo].Down_footage  ) *
                              prvAGVSup /Gzm.SupEndNumber ;
           end else begin
               StartFootage:=-1;
           end;
          CurrStep.OneStepInfo.start_minFootage:=StartFootage;

           {最大开始进刀转换为进尺}
          tmpDAo:=CurrStep.OneStepInfo.Start_maxDao ;
           if EffectJinDao(tmpDAo) then  begin
               StartFootage:=FcD[tmpDAo].Down_footage  + (FcD[tmpDAo].Upper_Footage-FcD[tmpDAo].Down_footage  ) *
                        prvAGVSup /Gzm.SupEndNumber ;
           end else begin
               StartFootage:=-1;
           end;
          CurrStep.OneStepInfo.start_maxFootage:=StartFootage;

          {中间支架的开始时的最小进刀转换为进尺}
          tmpDAo:=CurrStep.OneStepInfo.Start_MinDao ;
          prvFootage[0]:= FcD[tmpDAo].Down_footage  + (FcD[tmpDAo].Upper_Footage-FcD[tmpDAo].Down_footage  ) *
                        prvAGVSup /Gzm.SupEndNumber ;

          {中间支架的开始时的最大进刀转换为进尺}
          tmpDAo:=CurrStep.OneStepInfo.Start_MaxDao_id ;
           if EffectJinDao(tmpDAo) then  begin
                prvFootage[1]:= FcD[tmpDAo].Down_footage  + (FcD[tmpDAo].Upper_Footage-FcD[tmpDAo].Down_footage  ) *
                        prvAGVSup /Gzm.SupEndNumber ;
           end else begin
                prvFootage[1]:=-1;
           end;

          {中间支架的 支架运动最宽处开始 时的进刀转换为进尺}
          tmpDAo:=CurrStep.SupStep[CurrStep.OneStepInfo.Step_MaxWide_Dao_id].startDao ;
           if EffectJinDao(tmpDAo) then  begin
                StartFootage:=FcD[tmpDAo].Down_footage  + (FcD[tmpDAo].Upper_Footage-FcD[tmpDAo].Down_footage  ) *
                        prvAGVSup /Gzm.SupEndNumber ;
           end else begin
                 StartFootage:=-1;
           end;
          {中间支架的 支架运动最宽处结束 时的进刀转换为进尺}
          tmpDAo:=CurrStep.SupStep[CurrStep.OneStepInfo.Step_MaxWide_Dao_id].endDao+1 ;
           if EffectJinDao(tmpDAo) then  begin
                EndFootage:=FcD[tmpDAo].Down_footage  + (FcD[tmpDAo].Upper_Footage-FcD[tmpDAo].Down_footage  ) *
                        prvAGVSup /Gzm.SupEndNumber ;
           end else begin
               EndFootage:=-1;
           end;

          {中间支架的 最大运动显著运动步距}
          prvFootage[2]:= EndFootage-StartFootage;

          {中间支架的 支架运动最窄处开始 时的进刀转换为进尺}
          tmpDAo:=CurrStep.SupStep[CurrStep.OneStepInfo.Step_MinWide_Dao_id].startDao ;
          if EffectJinDao(tmpDAo) then  begin
              StartFootage:=FcD[tmpDAo].Down_footage  + (FcD[tmpDAo].Upper_Footage-FcD[tmpDAo].Down_footage  ) *
                            prvAGVSup /Gzm.SupEndNumber ;
          end else begin
              StartFootage:=-1;
          end;
           {中间支架的 支架运动最窄处结束时的进尺}
          tmpDAo:=CurrStep.SupStep[CurrStep.OneStepInfo.Step_MinWide_Dao_id].endDao+1 ;
           if EffectJinDao(tmpDAo) then  begin
                EndFootage:=FcD[tmpDAo].Down_footage  + (FcD[tmpDAo].Upper_Footage-FcD[tmpDAo].Down_footage  ) *
                        prvAGVSup /Gzm.SupEndNumber ;
           end else begin
                EndFootage:=-1;
           end;
           {中间支架的 最小运动显著运动步距}
          prvFootage[3]:= EndFootage-StartFootage;

          {显著运动步距数值保存}
          CurrStep.OneStepInfo.Step_Obvious_Footage[0] :=prvFootage[2];  //最大值
          CurrStep.OneStepInfo.Step_Obvious_Footage[1] :=prvFootage[3];  // 最小值
          CurrStep.OneStepInfo.Step_Obvious_Footage[2] :=(prvFootage[2]+prvFootage[3])/2;   //平均值
         
      end;


end;

procedure TOldSteps.CopyThisClass(Source: TOldSteps);
var
  i,j:integer;

begin
    for I := 0 to High(Source.inSteps ) do   begin
         AddSteps;
         inSteps[i].CopyThisClass(Source.inSteps[i]);
         inSteps[i].startsup :=Source.inSteps[i].startsup;
         inSteps[i].endsup :=Source.inSteps[i].endsup;
         inSteps[i].startDao :=Source.inSteps[i].startDao;
         inSteps[i].endDao :=Source.inSteps[i].endDao;
         inSteps[i].Used :=Source.inSteps[i].Used;
         inSteps[i].ModifyData :=Source.inSteps[i].ModifyData;

    end;
    Sort;

end;

constructor TOldSteps.Create;
var
  i:integer;
begin
   StepNumber:=0;
   LPC:=0;
   tempOneStep:=TOldOneStep.Create ;
   for I := 0 to 6 do
      PhaseSteps[i]:=TOldStepPhase.Create ;

    isCalComeStep:=False;// 是否计算了来压步距

end;

procedure TOldSteps.DeleteStep(id: integer);
var
  i:integer;
begin
   for I := id to StepNumber-2 do
       inSteps[i]:=inSteps[i+1];
   if Assigned(inSteps[StepNumber-1]) then
          FreeandNil(inSteps[StepNumber-1]);
   StepNumber:=StepNumber-1;
   setLength(inSteps,StepNumber);


end;

destructor TOldSteps.Destroy;
var
  i:integer;
begin
    ClearSteps;
    FreeAndNil(tempOneStep);
     for I := 0 to 6 do
      if Assigned(PhaseSteps[i]) then
         FreeAndNil(PhaseSteps[i]);

end;



function TOldSteps.DispostCycleData(Startid, Endid: integer): Boolean;
var
  Area:double;
begin
    if self.CalPolygonArea_LeftPoints(Startid,Endid) >= ContinueSupport*ContinueJinDao  then begin // 面积有效
       JudgeCycleDataToStep(Startid, Endid);
    end;
    // 把该圈切除
   if LeftPoints[Startid].PrvId<>-1 then
         LeftPoints[LeftPoints[Startid].PrvId].Nextid := LeftPoints[Endid].Nextid  ;

   LeftPoints[Startid].Nextid :=  LeftPoints[Endid].Nextid;
   //把该点直接切掉

   Result:=True;

end;

function TOldSteps.EffectJinDao(tempDao: integer): Boolean;
begin
   Result:=False;
   if (tempDao>=Grap_Mindao) and (tempDao<=Grap_Maxdao ) then   Result:=true;

end;

function TOldSteps.FillStepsInfoFromPrv_NextStep( Currstep :TOldOneStep;
  NextInFo: TcomprehensiveOldStep; FcD: array of TContourFootageData;
  finded: Boolean; Gzm: TGzm): TcomprehensiveOldStep;
var
  prvFootage:Array [0..4 ] of double; // 0 最前 1 最后 3 最大步距    4 最小步距
  StartFootage, EndFootage:double;
  tmpDAo:integer;
  prvAGVSup:integer;
  Temp_Step:TcomprehensiveOldStep;
begin
      if finded  then   begin // 表示找到了 后面的步距

         {找到本次运动步距}
          Currstep.OneStepInfo.FindNextStep :=true;
           // 结束最大值 等于下一个步距的 最大进刀
          Currstep.OneStepInfo.Step_end_MAXDao :=NextInFo.start_maxDao ;
          Currstep.OneStepInfo.Step_end_MaxDao_id:=NextInfo.Start_MaxDao_id;
          // 结束最小值 等于下一个步距的 最小进刀
          Currstep.OneStepInfo.Step_end_MinDao:=NextInfo.Start_minDao ;
          Currstep.OneStepInfo.Step_MinWide_Dao:=NextInfo.Start_MinDao_id;
          //把平均进刀换算为 进尺
          if EffectJinDao(Currstep.OneStepInfo.Start_AGVDao) then begin
             Currstep.OneStepInfo.Start_AGVFootage:= FcD[Currstep.OneStepInfo.Start_AGVDao].Down_footage
                    + (FcD[Currstep.OneStepInfo.Start_AGVDao].Upper_Footage-FcD[Currstep.OneStepInfo.Start_AGVDao].Down_footage  ) *
                         prvAGVSup /Gzm.SupEndNumber ;
          end else  begin
             Currstep.OneStepInfo.Start_AGVFootage:=0;
          end;
          if EffectJinDao(Currstep.OneStepInfo.End_AGVDao) then  begin
              Currstep.OneStepInfo.End_AGVFootage:= FcD[Currstep.OneStepInfo.End_AGVDao].Down_footage
                    + (FcD[Currstep.OneStepInfo.End_AGVDao].Upper_Footage-FcD[Currstep.OneStepInfo.End_AGVDao].Down_footage  ) *
                         prvAGVSup /Gzm.SupEndNumber ;
          end else begin
             Currstep.OneStepInfo.End_AGVFootage:=0;
          end;

          // 本次来压结束进刀的平均值 等于 最大与最小的均值
          prvAGVSup:=(Currstep.OneStepInfo.startsup+Currstep.OneStepInfo.endsup) div 2;

          {换算本次来压开始的最小进尺 主要通过上顺槽与下顺槽的差值实现}
          tmpDAo:=Currstep.OneStepInfo.Start_MinDao ;
          if EffectJinDao(tmpDAo) then  begin
              StartFootage:=FcD[tmpDAo].Down_footage  + (FcD[tmpDAo].Upper_Footage-FcD[tmpDAo].Down_footage  ) *
                        prvAGVSup /Gzm.SupEndNumber ;
              Currstep.OneStepInfo.start_minFootage:=StartFootage;
          end else begin
              Currstep.OneStepInfo.start_minFootage:=-1;
          end;

          {换算本次来压结束的最大进尺 主要通过上顺槽与下顺槽的差值实现}
          tmpDAo:=Currstep.OneStepInfo.Step_end_MAXDao;
          if EffectJinDao(tmpDAo) then  begin
              EndFootage:=FcD[tmpDAo].Down_footage  + (FcD[tmpDAo].Upper_Footage-FcD[tmpDAo].Down_footage  ) *
                            prvAGVSup /Gzm.SupEndNumber ;
              Currstep.OneStepInfo.Step_end_MaxFootage :=EndFootage;
          end else begin
              Currstep.OneStepInfo.Step_end_MaxFootage :=-1;
          end;
           {本次来压的最大行进步距}
           if (Currstep.OneStepInfo.start_minFootage> 0 ) and ( Currstep.OneStepInfo.Step_end_MaxFootage >0)   then  begin
               Currstep.OneStepInfo.Step_Move_MaxFootage:= Currstep.OneStepInfo.Step_end_MaxFootage -
                                   Currstep.OneStepInfo.start_minFootage;
           end;

          {换算本次来压开始的最大进尺 主要通过上顺槽与下顺槽的差值实现}
          tmpDAo:=Currstep.OneStepInfo.Start_maxDao ;
          if EffectJinDao(tmpDAo) then  begin
              StartFootage:=FcD[tmpDAo].Down_footage  + (FcD[tmpDAo].Upper_Footage-FcD[tmpDAo].Down_footage  ) *
                            prvAGVSup /Gzm.SupEndNumber ;
              Currstep.OneStepInfo.start_maxFootage:=StartFootage;
          end else begin
              Currstep.OneStepInfo.start_maxFootage:=-1;
          end;


           {换算本次来压结束的最小进尺 主要通过上顺槽与下顺槽的差值实现}
          tmpDAo:=Currstep.OneStepInfo.Step_end_MinDao;
           if EffectJinDao(tmpDAo) then  begin
              EndFootage:=FcD[tmpDAo].Down_footage  + (FcD[tmpDAo].Upper_Footage-FcD[tmpDAo].Down_footage  ) *
                            prvAGVSup /Gzm.SupEndNumber ;
              Currstep.OneStepInfo.Step_end_MinFootage:= EndFootage;
           end else begin
              Currstep.OneStepInfo.Step_end_MinFootage:= -1;
           end;

           {本次来压的最小行进步距}
          if (Currstep.OneStepInfo.start_maxFootage> 0 ) and ( Currstep.OneStepInfo.Step_end_MinFootage >0)   then  begin
               Currstep.OneStepInfo.Step_move_MinFootage:=  Currstep.OneStepInfo.Step_end_MinFootage-
                             Currstep.OneStepInfo.start_maxFootage;

              {本次来压的平均结束进尺}
              Currstep.OneStepInfo.Step_end_AGVFootage:=(Currstep.OneStepInfo.Step_end_MinFootage+
                                       Currstep.OneStepInfo.Step_end_MaxFootage) /2;
              {本次来压的平均行进步距}
              Currstep.OneStepInfo.Step_Move_AGV_Footage:=(Currstep.OneStepInfo.Step_Move_MaxFootage+
                                      Currstep.OneStepInfo.step_Move_MinFootage)/2 ;
          end;

          {计算本次循环显著步距的主要参数}
          {中间支架的开始时的最小进刀转换为最小进尺}
          tmpDAo:=Currstep.OneStepInfo.Start_MinDao ;
           if EffectJinDao(tmpDAo) then  begin
               prvFootage[0]:= FcD[tmpDAo].Down_footage  + (FcD[tmpDAo].Upper_Footage-FcD[tmpDAo].Down_footage  ) *
                        prvAGVSup /Gzm.SupEndNumber ;
           end else begin
                prvFootage[0]:=-1;
           end;

          {中间支架的开始时的最大进刀转换为最大进尺}
          tmpDAo:=Currstep.OneStepInfo.Start_maxDao ;
          prvFootage[1]:= FcD[tmpDAo].Down_footage  + (FcD[tmpDAo].Upper_Footage-FcD[tmpDAo].Down_footage  ) *
                        prvAGVSup /Gzm.SupEndNumber ;

          {中间支架的 支架运动最宽处开始 时的进刀转换为进尺}
          if high(CurrStep.SupStep) >=CurrStep.OneStepInfo.Step_MaxWide_Dao_id  then  begin

              tmpDAo:=CurrStep.SupStep[CurrStep.OneStepInfo.Step_MaxWide_Dao_id].startDao ;
              Currstep.OneStepInfo.Step_MaxWide_Dao :=TmpDao;
               if EffectJinDao(tmpDAo) then  begin
                  StartFootage:=FcD[tmpDAo].Down_footage  + (FcD[tmpDAo].Upper_Footage-FcD[tmpDAo].Down_footage  ) *
                                prvAGVSup /Gzm.SupEndNumber ;
               end else begin
                  StartFootage:=-1;
               end;
               {中间支架的 支架运动最宽处结束 时的进尺}
              tmpDAo:=CurrStep.SupStep[CurrStep.OneStepInfo.Step_MaxWide_Dao_id].endDao+1 ;
              Currstep.OneStepInfo.Step_MaxWide_Dao :=TmpDao-Currstep.OneStepInfo.Step_MaxWide_Dao;
              if EffectJinDao(tmpDAo) then  begin
                  EndFootage:=FcD[tmpDAo].Down_footage  + (FcD[tmpDAo].Upper_Footage-FcD[tmpDAo].Down_footage  ) *
                                prvAGVSup /Gzm.SupEndNumber ;
              end else begin
                   EndFootage:=-1;
              end;
           {中间支架的 最大运动显著运动步距}
            prvFootage[2]:= EndFootage-StartFootage;
          end;

           {中间支架的 支架运动最窄处开始 时的进刀转换为进尺}
         if high(CurrStep.SupStep) >=CurrStep.OneStepInfo.Step_MinWide_Dao_id  then  begin
              tmpDAo:=CurrStep.SupStep[CurrStep.OneStepInfo.Step_MinWide_Dao_id].startDao ;
              Currstep.OneStepInfo.Step_MinWide_Dao:=tmpDao;
              if EffectJinDao(tmpDAo) then  begin
                  StartFootage:=FcD[tmpDAo].Down_footage  + (FcD[tmpDAo].Upper_Footage-FcD[tmpDAo].Down_footage  ) *
                                prvAGVSup /Gzm.SupEndNumber ;
              end else begin
                  StartFootage:=-1;
              end;
               {中间支架的 支架运动最窄处结束时的进尺}
              tmpDAo:=CurrStep.SupStep[CurrStep.OneStepInfo.Step_MinWide_Dao_id].endDao+1 ;
              Currstep.OneStepInfo.Step_MinWide_Dao:=tmpDao- Currstep.OneStepInfo.Step_MinWide_Dao;
              if EffectJinDao(tmpDAo) then  begin
                  EndFootage:=FcD[tmpDAo].Down_footage  + (FcD[tmpDAo].Upper_Footage-FcD[tmpDAo].Down_footage  ) *
                            prvAGVSup /Gzm.SupEndNumber ;
              end else begin
                  EndFootage:=-1;
              end;
               {中间支架的 最小运动显著运动步距}
              prvFootage[3]:= EndFootage-StartFootage;

              {显著运动步距数值保存}
              CurrStep.OneStepInfo.Step_Obvious_Footage[0] :=prvFootage[2];  //最大值
              CurrStep.OneStepInfo.Step_Obvious_Footage[1] :=prvFootage[3];  // 最小值
              CurrStep.OneStepInfo.Step_Obvious_Footage[2] :=(prvFootage[2]+prvFootage[3])/2;   //平均值
              {持续步距  平均运动步距减去 显著运动步距的平均值}
              CurrStep.OneStepInfo.Step_Continue_Footage :=CurrStep.OneStepInfo.Step_MOVE_AGV_Footage -
                              CurrStep.OneStepInfo.Step_Obvious_Footage[2];
         end;

      end else begin
           {没有找到本次运动步距}
          Currstep.OneStepInfo.FindNextStep :=FALSE;
          {计算本次循环显著步距的主要参数}
          {中间支架的开始时的最小进刀转换为最小进尺}
          tmpDAo:=Currstep.OneStepInfo.Start_MinDao ;
           if EffectJinDao(tmpDAo) then  begin
               prvFootage[0]:= FcD[tmpDAo].Down_footage  + (FcD[tmpDAo].Upper_Footage-FcD[tmpDAo].Down_footage  ) *
                        prvAGVSup /Gzm.SupEndNumber ;
               Currstep.OneStepInfo.start_minFootage  :=prvFootage[0];
           end else begin
                prvFootage[0]:=-1;
                Currstep.OneStepInfo.start_minFootage:=prvFootage[0];
           end;

          //把平均进刀换算为 进尺
          if EffectJinDao(Currstep.OneStepInfo.Start_AGVDao) then begin
             Currstep.OneStepInfo.Start_AGVFootage:= FcD[Currstep.OneStepInfo.Start_AGVDao].Down_footage
                    + (FcD[Currstep.OneStepInfo.Start_AGVDao].Upper_Footage-FcD[Currstep.OneStepInfo.Start_AGVDao].Down_footage  ) *
                         prvAGVSup /Gzm.SupEndNumber ;
          end else  begin
             Currstep.OneStepInfo.Start_AGVFootage:=0;
          end;
          if EffectJinDao(Currstep.OneStepInfo.End_AGVDao) then  begin
              Currstep.OneStepInfo.End_AGVFootage:= FcD[Currstep.OneStepInfo.End_AGVDao].Down_footage
                    + (FcD[Currstep.OneStepInfo.End_AGVDao].Upper_Footage-FcD[Currstep.OneStepInfo.End_AGVDao].Down_footage  ) *
                         prvAGVSup /Gzm.SupEndNumber ;
          end else begin
             Currstep.OneStepInfo.End_AGVFootage:=0;
          end;

          {中间支架的开始时的最大进刀转换为最大进尺}
          tmpDAo:=Currstep.OneStepInfo.Start_maxDao ;
          if EffectJinDao(tmpDAo) then  begin
              prvFootage[1]:= FcD[tmpDAo].Down_footage  + (FcD[tmpDAo].Upper_Footage-FcD[tmpDAo].Down_footage  ) *
                        prvAGVSup /Gzm.SupEndNumber ;
              Currstep.OneStepInfo.start_maxFootage:=prvFootage[1];
          end else begin
              prvFootage[1]:=-1;
              Currstep.OneStepInfo.start_maxFootage:=prvFootage[1];
          end;
          {中间支架的 支架运动最宽处开始 时的进刀转换为进尺}
          if high(CurrStep.SupStep) >=CurrStep.OneStepInfo.Step_MaxWide_Dao_id  then  begin
              tmpDAo:=CurrStep.SupStep[CurrStep.OneStepInfo.Step_MaxWide_Dao_id].startDao ;
              Currstep.OneStepInfo.Step_MaxWide_Dao :=TmpDao;
               if EffectJinDao(tmpDAo) then  begin
                  StartFootage:=FcD[tmpDAo].Down_footage  + (FcD[tmpDAo].Upper_Footage-FcD[tmpDAo].Down_footage  ) *
                                prvAGVSup /Gzm.SupEndNumber ;

               end else begin
                  StartFootage:=-1;
               end;
               {中间支架的 支架运动最宽处结束 时的进尺}
              tmpDAo:=CurrStep.SupStep[CurrStep.OneStepInfo.Step_MaxWide_Dao_id].endDao+1 ;
              Currstep.OneStepInfo.Step_MaxWide_Dao :=TmpDao-Currstep.OneStepInfo.Step_MaxWide_Dao;
              if EffectJinDao(tmpDAo) then  begin
                  EndFootage:=FcD[tmpDAo].Down_footage  + (FcD[tmpDAo].Upper_Footage-FcD[tmpDAo].Down_footage  ) *
                                prvAGVSup /Gzm.SupEndNumber ;
              end else begin
                  EndFootage:=-1;
              end;
               {中间支架的 最大运动显著运动步距}
              prvFootage[2]:= EndFootage-StartFootage;
          end;

           {中间支架的 支架运动最窄处开始 时的进刀转换为进尺}
         if high(CurrStep.SupStep) >=CurrStep.OneStepInfo.Step_MinWide_Dao_id  then  begin
              tmpDAo:=CurrStep.SupStep[CurrStep.OneStepInfo.Step_MinWide_Dao_id].startDao ;
              Currstep.OneStepInfo.Step_MinWide_Dao:=tmpDao;
              if EffectJinDao(tmpDAo) then  begin
                  StartFootage:=FcD[tmpDAo].Down_footage  + (FcD[tmpDAo].Upper_Footage-FcD[tmpDAo].Down_footage  ) *
                                prvAGVSup /Gzm.SupEndNumber ;
              end else begin
                  StartFootage:=-1;
              end;
               {中间支架的 支架运动最窄处结束时的进尺}
              tmpDAo:=CurrStep.SupStep[CurrStep.OneStepInfo.Step_MinWide_Dao_id].endDao+1 ;
              Currstep.OneStepInfo.Step_MinWide_Dao:=tmpDao- Currstep.OneStepInfo.Step_MinWide_Dao;
              if EffectJinDao(tmpDAo) then  begin
                  EndFootage:=FcD[tmpDAo].Down_footage  + (FcD[tmpDAo].Upper_Footage-FcD[tmpDAo].Down_footage  ) *
                            prvAGVSup /Gzm.SupEndNumber ;
              end else begin
                  EndFootage:=-1;
              end;
               {中间支架的 最小运动显著运动步距}
              prvFootage[3]:= EndFootage-StartFootage;

              {显著运动步距数值保存}
              CurrStep.OneStepInfo.Step_Obvious_Footage[0] :=prvFootage[2];  //最大值
              CurrStep.OneStepInfo.Step_Obvious_Footage[1] :=prvFootage[3];  // 最小值
              CurrStep.OneStepInfo.Step_Obvious_Footage[2] :=(prvFootage[2]+prvFootage[3])/2;   //平均值
          end;

      end;

//      if Currstep.OneStepInfo.start_maxFootage<=0 then  begin
//
//         Currstep.OneStepInfo.start_maxFootage:=-2;
//      end;
end;

function TOldSteps.FillStringData(StrGrid:TStringGrid;Row,Stepcount:integer;
                            StartSup,EndSup:integer;
                            OneStepInfo:TcomprehensiveOldStep;
                            Col1Str,Col2Str:string):String;
{
   Row 行号
   StepCount ：预报次数
   OneStepInfo :综合的record
   ForCase: 是否进行下一次来压步距的预报  如果 级别 与前一级相同 则不预报
   WholeOrPhase:Boolean 整体还是部分
}
var
  i,Col:integer;
  MergeCell:string;
  Ex_Stepid:integer;
begin
         MergeCell:='';
         //------------
         StrGrid.Cells[0,Row]:= IntTostr(Row-2);   //序号
         StrGrid.Cells[1,Row]:=Col1Str;   //预报方式
         StrGrid.Cells[2,Row]:=Col2Str;   //来压阶段
         StrGrid.Cells[3,Row]:=IntTostr(StartSup);   //阶段开始支架
         StrGrid.Cells[4,Row]:=IntToStr(EndSup);   //阶段结束支架

         StrGrid.Cells[5,Row]:=IntTostr(StepCount);   //预报次数
         StrGrid.Cells[6,Row]:=IntToStr(OneStepInfo.StartDao );   //开始进刀开始均值
         StrGrid.Cells[7,Row]:=IntToStr(OneStepInfo.EndDao );   //开始进刀结束均值
         StrGrid.Cells[8,Row]:=IntToStr(OneStepInfo.StartSup);   //支架来压开始
         StrGrid.Cells[9,Row]:=IntToStr(OneStepInfo.EndSup);   //支架来压结束

         StrGrid.Cells[10,Row]:=FormatFloat('0.00',OneStepInfo.MinData);   //压力最小值
         StrGrid.Cells[11,Row]:=FormatFloat('0.00',OneStepInfo.MaxData);   //压力最大值
         StrGrid.Cells[12,Row]:=FormatFloat('0.00',OneStepInfo.AGVDAta);   //压力平均值
         StrGrid.Cells[13,Row]:=FormatFloat('0.00',OneStepInfo.AGVDataQD);  //平均压力系数
         StrGrid.Cells[14,Row]:=FormatFloat('0.00',OneStepInfo.AreaQD );  //面积强度系数
         StrGrid.Cells[15,Row]:=FormatFloat('0.00',OneStepInfo.WholeQD );  //来压总体强度系数
         if OneStepInfo.FindNextStep   then  begin
              {如果进行下一步来压预报}
               if OneStepInfo.Step_move_MinFootage >0 then   begin
                  StrGrid.Cells[16,Row]:=FormatFloat('0.0',OneStepInfo.Step_Move_AGV_Footage);  //来压步距平均
                  StrGrid.Cells[17,Row]:=FormatFloat('0.0',OneStepInfo.Step_move_MinFootage);  //来压步距最小
                  StrGrid.Cells[18,Row]:=FormatFloat('0.0',OneStepInfo.Step_move_MaxFootage);  //来压步距最大
               end;


               if OneStepInfo.Step_Obvious_Footage[1] >0 then begin
                  StrGrid.Cells[19,Row]:=FormatFloat('0.0',OneStepInfo.Step_Obvious_Footage[2]);  //显著步距平均
                  StrGrid.Cells[20,Row]:=FormatFloat('0.0',OneStepInfo.Step_Obvious_Footage[1]);  //显著步距最小
                  StrGrid.Cells[21,Row]:=FormatFloat('0.0',OneStepInfo.Step_Obvious_Footage[0]);  //显著步距最大
               end;

               if OneStepInfo.Step_Continue_Footage >0  then
                  StrGrid.Cells[22,Row]:=FormatFloat('0.0',OneStepInfo.Step_Continue_Footage);  //稳定步距
         end;
         StrGrid.Cells[23,Row]:=  OneStepInfo.SupportString;
         // 把后续的 来压区域打印出来
        Col:=23;
        for I := 0 to OneStepInfo.NextStepCount -1 do   begin
           if ExSteps[ ReturnExStepidFromInn_Stepid(OneStepInfo.NextStepClassID[i]) ].OneStepInfo.Step_NO =OneStepInfo.Step_NO then
              continue;

            inc(Col);
            if StrGrid.Cells [Col,0]='' then begin
                StrGrid.ColCount :=StrGrid.ColCount +6;
                StrGrid.Cells [Col,0]:='后续['+IntToStr(I+1)+']来压';
                StrGrid.Cells [Col+1,0]:='进刀范围(刀)';
                MergeCell:=MergeCell+ IntToStr(Col) +',0,' +IntToStr(Col+1)+ ',0;';
                StrGrid.Cells [Col,1]:='开始';
                StrGrid.Cells [Col+1,1]:='结束';
                StrGrid.ColWidths[Col]:=80;
                StrGrid.ColWidths[Col+1]:=80;

                StrGrid.Cells [Col+2,0]:='后续['+IntToStr(I+1)+']来压';
                StrGrid.Cells [Col+3,0]:='支架范围(架)';
                MergeCell:=MergeCell+ IntToStr(Col+2) +',0,' +IntToStr(Col+3)+ ',0;';
                StrGrid.Cells [Col+2,1]:='开始';
                StrGrid.Cells [Col+3,1]:='结束';
                StrGrid.ColWidths[Col+2]:=80;
                StrGrid.ColWidths[Col+3]:=80;
            end;
            Ex_Stepid:=ReturnExStepidFromInn_Stepid(OneStepInfo.NextStepClassID[i]);
            StrGrid.Cells[Col,Row]:=IntToStr(ExSteps[Ex_Stepid].OneStepInfo.StartDao );   //进刀开始
             inc(Col);
            StrGrid.Cells[Col,Row]:=IntToStr(ExSteps[Ex_Stepid].OneStepInfo.EndDao );   //进刀结束
             inc(Col);
            StrGrid.Cells[Col,Row]:=IntToStr(max(ExSteps[Ex_Stepid].OneStepInfo.StartSup,StartSup) );   //支架开始
             inc(Col);
            StrGrid.Cells[Col,Row]:=IntToStr(Min(ExSteps[Ex_Stepid].OneStepInfo.EndSup,EndSup) );   //支架开始

        end;
        ExSteps[ReturnExStepidFromInn_Stepid(OneStepInfo.ExStepClassid) ].OneStepInfo.PrintBool :=true;
    Result:=MergeCell;
end;

function TOldSteps.FillStringPhaseGzmData_Main(StrGrid: TStringGrid; startsup,EndSup:integer;
        PhaseStep:TcomprehensiveOldStep; var Row, Stepcount: integer;Col1Str,Col2Str:string): string;
var
  MergeCell:string;
  N,tempid :integer;
begin
     MergeCell:='';
      if  (not PhaseStep.PrintBool ) then  begin
           inc(Row);
           inc(StepCount);
           if StrGrid.RowCount < Row+2 then  StrGrid.RowCount:= Row+2;
           MergeCell:=MergeCell+ FillStringData(StrGrid, Row,StepCount,
                          startsup,EndSup,
                          PhaseStep ,
                          Col1Str,Col2Str
                          );

//            // 顺着这条线进行输出
//            for N := 0 to PhaseStep.NextStepCount -1 do begin
//                tempid:=ReturnExStepidFromInn_Stepid(PhaseStep.NextStepClassID[N]);
//                if ExSteps[tempid].OneStepInfo.PrintBool then  continue;
//                inc(Row);
//                inc(StepCount);
//                MergeCell:=MergeCell+ FillStringData(StrGrid, Gzm,
//                         Row,StepCount,
//                         ExSteps[tempid].OneStepInfo ,
//                         Col1Str,Col2Str
//                          );
//            end;
      end;
     Result:= MergeCell;

end;

function TOldSteps.FillStringWholeGZmData_Main(StrGrid: TStringGrid; Gzm: TGzm;
                iEx_stepid, iModiftyData:integer; var  Row, Stepcount: integer): string;
var
  Col1Str,Col2Str:String;
  MergeCell:string;
  N,tempid :integer;
begin
      MergeCell:='';
      if  ExSteps[iEx_stepid].OneStepInfo.MinData >9999 then  exit;

      if (ExSteps[iEx_stepid].ModifyData =iModiftyData) and (not ExSteps[iEx_stepid].OneStepInfo.PrintBool ) then  begin
           inc(Row);
           inc(StepCount);
           if StrGrid.RowCount < Row+2 then  StrGrid.RowCount:= Row+2;
           Col1Str:='分析';
           Col2Str:='整工作面';
           MergeCell:=MergeCell+ FillStringData(StrGrid,Row,StepCount,
                         GZm.SupStartNumber ,Gzm.SupEndNumber ,
                         ExSteps[iEx_stepid].OneStepInfo ,
                          Col1Str,Col2Str
                          );

            // 顺着这条线进行输出
            for N := 0 to ExSteps[iEx_stepid].OneStepInfo.NextStepCount -1 do begin
                tempid:=ReturnExStepidFromInn_Stepid(ExSteps[iEx_stepid].OneStepInfo.NextStepClassID[N]);
                if ExSteps[tempid].OneStepInfo.PrintBool then  continue;
                if   ExSteps[tempid].OneStepInfo.MinData >9999 then  continue;
                inc(Row);
                inc(StepCount);
                if StrGrid.RowCount < Row+2 then  StrGrid.RowCount:= Row+2;
                MergeCell:=MergeCell+ FillStringData(StrGrid, Row,StepCount,
                         GZm.SupStartNumber ,Gzm.SupEndNumber ,
                         ExSteps[tempid].OneStepInfo ,
                         Col1Str,Col2Str
                          );
            end;
      end;
     Result:= MergeCell;
end;

procedure TOldSteps.FindNextStepToFillOneInfo(CurrStep: TOldOneStep;
  FcD: array of TContourFootageData; finded: Boolean; Gzm: TGzm);
var
  i,j:integer;
  Next_Zh_Step: TcomprehensiveOldStep;
  Ex_Stepid:integer;
begin
   Next_Zh_Step.Start_MinDao :=10000;
   Next_Zh_step.Start_maxDao :=0;
  if finded then  begin

    for I := 0 to CurrStep.OneStepInfo.NextStepCount -1 do  begin
        Ex_stepid:=ReturnExStepidFromInn_Stepid(CurrStep.OneStepInfo.NextStepClassID[i]);
        if ExSteps[Ex_stepid].OneStepInfo.Step_NO = CurrStep.OneStepInfo.Step_NO then
           continue;

        if Next_Zh_Step.Start_MinDao > ExSteps[Ex_stepid].OneStepInfo.Start_MinDao  then   begin
           Next_Zh_Step.Start_MinDao := ExSteps[Ex_stepid].OneStepInfo.Start_MinDao ;
           Next_Zh_Step.Start_MinDao_id := ExSteps[Ex_stepid].OneStepInfo.Start_MinDao_id;
        end;

        if Next_Zh_Step.Start_maxDao < ExSteps[Ex_stepid].OneStepInfo.Start_maxDao  then   begin
           Next_Zh_Step.Start_maxDao := ExSteps[Ex_stepid].OneStepInfo.Start_maxDao ;
           Next_Zh_Step.Start_MaxDao_id := ExSteps[Ex_stepid].OneStepInfo.Start_MaxDao_id;
        end;
    end;
  end;

  if (Next_Zh_Step.Start_MinDao=10000) or (Next_Zh_step.Start_maxDao=0)  then Finded:=False;

    // 填充oneStepInfo
  FillStepsInfoFromPrv_NextStep(CurrStep,Next_Zh_Step,FCD,Finded,GzM);

end;

function TOldSteps.ForCaseOlsStep(Number: integer): Boolean;
var
  i,Stepid,Returnid:Integer;
  k:integer;
begin
   //清除原来预测的类
   for i := 0 to length(ExSteps)-1 do
      if ExSteps[i].ModifyData =3 then
         ExSteps[i].Used :=0;

  // 预测剧烈来压步距 2次

 for I := 1 to PhaseNumber-2 do  begin
   for k := 0 to 1 do  begin
       Stepid:= phaseSteps[i].ForcaseStep(1,10);
       if Stepid <0 then  continue;
       AddSteps;
       inSteps[StepNumber-1].Used :=1; // 有用数据
       inSteps[StepNumber-1].ModifyData :=3; // 预测数据
       inSteps[StepNumber-1].ForcaseId :=1; //  剧烈来压预测
       inSteps[StepNumber-1].OneStepInfo := phaseSteps[i].Steps[Stepid];
       inSteps[StepNumber-1].FromOneStepInfoExactDataIntoOutLine ;
   end;
 end;

 // 预测一般来压步距 3次
 for I := 1 to PhaseNumber-2 do  begin
   for k := 0 to 2 do  begin
       Stepid:= phaseSteps[i].ForcaseStep(1,9);
       if Stepid <0 then  continue;
       AddSteps;
       inSteps[StepNumber-1].Used :=1; // 有用数据
       inSteps[StepNumber-1].ModifyData :=3; // 预测数据
       inSteps[StepNumber-1].ForcaseId :=2; //  剧烈来压预测
       inSteps[StepNumber-1].OneStepInfo := phaseSteps[i].Steps[Stepid];
       inSteps[StepNumber-1].FromOneStepInfoExactDataIntoOutLine ;
   end;
 end;
   // 类排序
   sort;
   // 类刷新 主要实现对区域包含关系的 合并
   refresh;
end;

function TOldSteps.GetComeStepCount(ModifyData: Integer): Integer;
var
  s_C,i:integer;
begin
    s_C:=0;
     for I := 0 to length(ExSteps)-1 do
        if ExSteps[i].ModifyData= ModifyData then  begin
          if (ExSteps[i].OneStepInfo.EndDao>ExSteps[i].OneStepInfo.StartDao ) and
              (ExSteps[i].OneStepInfo.EndSup>ExSteps[i].OneStepInfo.StartSup ) then
                   inc(S_c);
        end;
   Result:=s_c;

end;

function TOldSteps.GetComeStepInfo(ModifyData: Integer; var AGVDao,
  AGVchi: Double): Boolean;
var
  s_C,i:integer;
begin
    s_C:=0; AGVDao:=0;AGVchi:=0;
     for I := 0 to length(ExSteps)-1 do
        if ExSteps[i].ModifyData= ModifyData then  begin
          if (ExSteps[i].OneStepInfo.EndDao>ExSteps[i].OneStepInfo.StartDao ) and
              (ExSteps[i].OneStepInfo.EndSup>ExSteps[i].OneStepInfo.StartSup ) then  begin
                 AGVDao:=AGVDao+ExSteps[i].OneStepInfo.EndDao-ExSteps[i].OneStepInfo.StartDao;
                 AGVchi:=AGVchi+ExSteps[i].OneStepInfo.End_AGVFootage -ExSteps[i].OneStepInfo.Start_AGVFootage;
                 inc(s_C);
              end;
        end;
    if s_C>0 then begin
       AGVDao:=AGVDao/ s_C;
       AGVchi:=AGVchi/S_c;
    end;
    Result:=true;
end;

function TOldSteps.InitPhaseSteps(Number:integer;Gzm:TGzm): Boolean;
var
  i,Startid:integer;
  EndBh,AGVBh,JG:Integer;
  mid_S,Mid_E:integer;
begin
   PhaseNumber:=Number;
   EndBh:=Gzm.SupEndNumber ;
   AGVBh:=EndBh div PhaseNumber;
   if Number=3 then  begin
      JG:=20;
   end else begin
      JG:=25;
   end;

   Startid:=1;
   AGVBh:=(EndBh-JG*2) div (PhaseNumber -2) ;
   mid_s:= (EndBh) div 2 - AGVBh div 2;
   mid_E:= (EndBh) div 2 + AGVBh div 2;
   for I := 0 to PhaseNumber-1 do begin
       PhaseSteps[i].StartsupBh :=Startid;
       if I=0 then  begin
          PhaseSteps[i].EndSupBh :=Startid+JG;
       end else  if i=PhaseNumber-2 then  begin
          PhaseSteps[i].EndSupBh :=EndBh-JG-1;
       end else if i=PhaseNumber div 2 then  begin
          PhaseSteps[i].EndSupBh :=Mid_E;
       end else if i=PhaseNumber div 2 -1 then  begin
          PhaseSteps[i].EndSupBh :=mid_s-1;
       end else  if i=PhaseNumber-1 then  begin
          PhaseSteps[i].EndSupBh :=EndBh;
          PhaseSteps[i].StartsupBh :=EndBh-JG;
       end  else begin
          PhaseSteps[i].EndSupBh :=Startid+AGVBh;
       end;
      Startid:=PhaseSteps[i].EndSupBh+1;
   end;
end;

function TOldSteps.JudgeChildCycle(Startid, Endid: integer): Boolean;
var
  Chlid_Start,Chlid_End:Integer;
  Head_i,tail_i:integer;

begin
     Result:=False;
     Chlid_Start:=LeftPoints[Startid].Nextid ;
     Chlid_End:=LeftPoints[Endid].PrvId ;
     if  (Chlid_Start=-1 ) or (Chlid_end=-1 ) then  exit;
     Head_i:=Chlid_Start;
     while (Head_i<>-1) and (Head_i <> Chlid_End) do  begin
        tail_i:=LeftPoints[Head_i].Nextid ;
        while (tail_i <> -1) and (Tail_i <> chlid_end) do  begin
               if (abs(LeftPoints[Head_i].X- LeftPoints[tail_i].X) <1 ) and
                    (abs(LeftPoints[Head_i].Y- LeftPoints[tail_i].Y)<1)   then  begin  // 认为两个点在同一个位置
                       if self.CalPolygonArea_LeftPoints(Head_i,tail_i) >= ContinueSupport*ContinueJinDao  then begin // 面积有效
                          SplitCycle(Head_i,tail_i);
                          break;
                       end else begin   // 面积无效 证明是 没有意义的圈
                           if LeftPoints[Head_i].PrvId<>-1 then
                               LeftPoints[LeftPoints[Head_i].PrvId].Nextid := LeftPoints[tail_i].Nextid
                             else  LeftPoints[Head_i].Nextid:= LeftPoints[tail_i].Nextid;
                       end;
               end else if (abs(LeftPoints[Head_i].X- LeftPoints[tail_i].X) < ContinueJinDao/3 ) and
                    (abs(LeftPoints[Head_i].Y- LeftPoints[tail_i].Y)<ContinueSupport/3)   then  begin  // 认为该圈可以终结
                      if self.CalPolygonArea_LeftPoints(Head_i,tail_i) >= ContinueSupport*ContinueJinDao  then begin // 面积有效
                         SplitCycle(Head_i,tail_i);
                         break;
                      end;
               end;
             tail_i:=LeftPoints[tail_i].Nextid ;
        end;
        Head_i:=LeftPoints[Head_i].Nextid ;
     end;


end;

function TOldSteps.JudgeCycleDataToStep(Startid, Endid: integer): Boolean;
var
  Currid:integer;
  tmp:TOldOneStep;
  S_S,E_S,S_D,E_D:double;
  S_Sup,E_Sup,S_Dao,E_Dao:integer;
begin
    S_S:=10000;S_D:=10000;
    E_S:=0;E_D:=0;
    S_Sup:=0;E_Sup:=0;S_Dao:=0;E_Dao:=0;
    Currid:=Startid;
    repeat
        S_S :=ReturnMin(LeftPoints[Currid].y,S_S) ;
        S_D :=ReturnMin(LeftPoints[Currid].x,S_D) ;
        E_S :=ReturnMax(LeftPoints[Currid].y,E_S) ;
        E_D :=ReturnMax(LeftPoints[Currid].x,E_D) ;
        Currid:=LeftPoints[Currid].Nextid;
        if Currid = Endid then  break;

    until ( LeftPoints[Currid].Nextid = -1);

    // 首先是面积够了 证明该处有 压力聚集情况
     Currid:=Startid;
     tmp:=AddSteps;
    // tmp:=insteps[StepNumber-1];
     repeat
         tmp.AddPoint(LeftPoints[Currid]);
         Currid:=LeftPoints[Currid].Nextid;
         if Currid = Endid then  break;
     until ( LeftPoints[Currid].Nextid = -1);

    {   是否对点进行 靠前 拖后处理,如果是  第二级级 与 第三级 灵敏度，对点进行处理
        对 支架与进刀编号的靠近取整
        一定注意顺序，先把最值送进去，在进行平滑数据
        }
    tmp.SetMinAndMaxSup(s_s,E_s);
    tmp.SetMinAndMaxDao(S_D,E_D);
    if Dispose_LMd >=1 then   tmp.SelectIntPoint ;

    tmp.setContinueSupport_Dao(ContinueSupport,ContinueJinDao);
    tmp.setOutlinePoint; // 首先获得该支架的外框边界
    // 判断该区域的有效性
    if tmp.JudgeThisStepIsEfficient(S_Sup,E_Sup,S_Dao,E_Dao,ContinueSupport,ContinueJinDao) then  begin
       tmp.SetMinAndMaxSup(S_Sup,E_Sup);
       tmp.SetMinAndMaxDao(S_Dao,E_Dao);
       tmp.Used :=1;  // 数据有效方式
       tmp.ModifyData :=1; // 数据来源 表示从云图中分析得来
    end else begin
       tmp.Used :=1;  // 表示是局部压力出现集中
       tmp.ModifyData :=5; // 表示是局部压力出现集中 后期进行处理
    end;


  Result:=true;

end;

function TOldSteps.JudgeNestStepisEfficent(PrvStep: ToldOneStep;
  Nextid: integer): Boolean;
var
  i:integer;
  Ex_Stepid:integer;
begin
   Result:=true;
   {如果进尺有交叉， 是后续一个步距，等待后续处理，两个步距可以合并}
   if ExSteps[Nextid].OneStepInfo.StartDao < PrvStep.OneStepInfo.EndDao  then  begin
        if PrvStep.OneStepInfo.ModifyData =10 then  begin
           ExSteps[Nextid].OneStepInfo.Step_NO :=PrvStep.OneStepInfo.Step_NO ;
        end;
        exit;
   end;

   for I := 0 to PrvStep.OneStepInfo.NextStepCount -1  do   begin
       Ex_Stepid:=ReturnExStepidFromInn_Stepid(PrvStep.OneStepInfo.NextStepClassID[i]);
      if  (
           ((ExSteps[Nextid].OneStepInfo.EndSup > ExSteps[Ex_Stepid].startsup  )    and
           (ExSteps[Nextid].OneStepInfo.EndSup < ExSteps[Ex_Stepid].endDao  ) )
           or
          ((ExSteps[Nextid].OneStepInfo.startsup > ExSteps[Ex_Stepid].startsup  )    and
           (ExSteps[Nextid].OneStepInfo.startsup < ExSteps[Ex_Stepid].endDao  ) )
           or
           ((ExSteps[Nextid].OneStepInfo.startsup < ExSteps[Ex_Stepid].startsup  )    and
           (ExSteps[Nextid].OneStepInfo.EndSup  > ExSteps[Ex_Stepid].endDao  ) )
           ) and
           (ExSteps[Nextid].OneStepInfo.StartDao > ExSteps[Ex_Stepid].endDao)    then  begin
              Result:=False;
              exit;
           end;




   end;



end;

function TOldSteps.JudgeOldstep: Boolean;
var
  Startid,Endid:integer;
  SysStartid:integer;

begin
    Result:=False;
    if LPc<1 then exit;
    Startid:=0;
    Endid:=0;
    SysStartid:=0;
    while LeftPoints[StartId].Nextid <> -1 do begin
          Endid:=LeftPoints[StartId].Nextid;
          while true do  begin
               if  StartId <>  Endid then begin
                   if (abs(LeftPoints[StartId].X- LeftPoints[Endid].X) <1 ) and
                        (abs(LeftPoints[StartId].Y- LeftPoints[Endid].Y)<1)   then  begin  // 认为两个点在同一个位置
                           if self.CalPolygonArea_LeftPoints(StartId,Endid) >= ContinueSupport*ContinueJinDao  then begin // 面积有效
                              if LeftPoints[StartId].PrvId<> -1  then // 不是开始点 就切
                                 if not JudgeOldStep_2(StartId,Endid) then break;
                           end else begin   // 面积无效 证明是 没有意义的圈
                               LeftPoints[StartId].Nextid:= LeftPoints[Endid].Nextid;
                           end;

                   end else if (abs(LeftPoints[StartId].X- LeftPoints[Endid].X) < ContinueJinDao/2 ) and
                        (abs(LeftPoints[StartId].Y- LeftPoints[Endid].Y)<ContinueSupport/2)   then  begin  // 认为两个点在同一个位置
                          if self.CalPolygonArea_LeftPoints(StartId,Endid) >= ContinueSupport*ContinueJinDao  then begin // 面积有效
                             if LeftPoints[StartId].PrvId<> -1  then // 不是开始点 就切
                                if not JudgeOldStep_2(StartId,Endid) then break;
                          end;
                   end;
               end;
               if LeftPoints[Endid].Nextid <> -1  then    Endid:=LeftPoints[Endid].Nextid
               else break;
          end;

         if LeftPoints[StartId].Nextid<> -1 then Startid:=LeftPoints[StartId].Nextid
            else break;
    end;
      {最后一圈的处理，涉及到切圈的问题}
    JudgeOldStep_2(SysStartid,Endid);
    Result:=true;
end;

function TOldSteps.JudgeOldStep_2(Var quan_start :integer;Quan_End:integer):Boolean;
var
  Currid:integer;
  tmp:TOldOneStep;
  S_S,E_S,S_D,E_D:double;
  S_Sup,E_Sup,S_Dao,E_Dao:integer;
begin
    S_S:=10000;S_D:=10000;
    E_S:=0;E_D:=0;
    S_Sup:=0;E_Sup:=0;S_Dao:=0;E_Dao:=0;
    Currid:=Quan_start;
    repeat
        S_S :=ReturnMin(LeftPoints[Currid].y,S_S) ;
        S_D :=ReturnMin(LeftPoints[Currid].x,S_D) ;
        E_S :=ReturnMax(LeftPoints[Currid].y,E_S) ;
        E_D :=ReturnMax(LeftPoints[Currid].x,E_D) ;
        Currid:=LeftPoints[Currid].Nextid;
        if Currid > Quan_End then  break;

    until ( LeftPoints[Currid].Nextid = -1);

     if (E_D -S_D > ContinueJinDao  ) and  (E_S -S_S > ContinueSupport  )  then  begin
         Currid:=Quan_start;
         tmp:=AddSteps;
        // tmp:=insteps[StepNumber-1];
         repeat
             tmp.AddPoint(LeftPoints[Currid]);
             Currid:=LeftPoints[Currid].Nextid;
             if Currid > Quan_End then  break;
         until ( LeftPoints[Currid].Nextid = -1);
        //添加进 确认的数组
        {是否对点进行 靠前 拖后处理,如果是
           第二级级 与 第三级 灵敏度，对点进行处理}
        tmp.SetMinAndMaxSup(s_s,E_s);
        tmp.SetMinAndMaxDao(S_D,E_D);
        if Dispose_LMd >=1 then   tmp.SelectIntPoint ;
        // 判断该区域的有效性
        if tmp.JudgeThisStepIsEfficient(S_Sup,E_Sup,S_Dao,E_Dao,ContinueSupport,ContinueJinDao) then  begin
           tmp.SetMinAndMaxSup(S_Sup,E_Sup);
           tmp.SetMinAndMaxDao(S_Dao,E_Dao);
          // tmp.setOutlinePoint;
           tmp.Used :=1;  // 数据有效方式
           tmp.ModifyData :=1; // 数据来源 表示从云图中分析得来
        end else begin
           tmp.Used :=0;  // 系统自动删除
           tmp.ModifyData :=3; // 表示无效数据
        end;
   end;
   // 把这个圈给切除
   if LeftPoints[Quan_start].PrvId= -1 then   begin
//        if LeftPoints[Quan_end].Nextid  <> -1  then begin
//           { 如果该圈的起点是开头，该圈的终点不是结尾
//             节点链中下一个点的节点 是起点  修改S_Start 的数值
//              并把起点返回，继续进行后面圈的剖切
//           }
//           LeftPoints[LeftPoints[Quan_end].Nextid ].PrvId :=-1;
//           Sys_start:=LeftPoints[Quan_end].Nextid ;
//           quan_Start:= Sys_start;
//           Result:=True;
//        end else begin
//           { 如果该圈的起点是开头，该圈的终点是结尾
//             所有的剖切结束
//           }
//           Sys_start:=0;
//           LeftPoints[Sys_start].Nextid :=-1;
//           Result:=False;
//        end;
   end else begin
        {
          如果该圈的起点不是开始，该圈的终点也不是结束
          该圈中 起点的上一个节点 指向 终点 的 下一个节点
          这样就把这个圈内所有的点切除
          继续
        }

         LeftPoints[LeftPoints[quan_Start].PrvId].Nextid:= LeftPoints[Quan_end].Nextid;
         Quan_start:= LeftPoints[Quan_end].Nextid ;
         Result:=True;
   end;
end;


function TOldSteps.mergeTwoOldSteps(First, Second: TOldOneStep): Boolean;
{
    两个区域合并的问题
    两个区域合并的原则
    如果两个区域出现重合， 把重合的部分 剔除，并有目的的强制内缩一个支架或者一次进刀
    DaoOrSup  =0 代表是进刀数兼容    =1 代表是支架 数兼容

}

var
  i,j,MinP_id:integer;
  inPt, pro,Nex:TDoublePoint;
  p1,p2,p3:ToutPoint;
  MinArea:Double;
  FlagB:Boolean;
  forCount:integer;
begin
     REsult:=False;  forCount:=0;
     for j := 0 to 7 do  begin
        FlagB:=False;
        while  (First.IsPtInOutLine(Second.MyOutLinePoint[j].Point)) do  begin
            FlagB:=true;
            inc(Forcount);
            //移动刀数
            for i := 5 to 7 do
              if First.MyOutLinePoint[i].Point.x > First.endDao then begin
                 First.MyOutLinePoint[i].Point.x:=round(First.endDao);
                 FlagB:=False;
              end;
            for i := 1 to 3 do
                if Second.MyOutLinePoint[i].Point.x < Second.startDao then   begin
                  Second.MyOutLinePoint[i].Point.x:=round(Second.startDao);
                  FlagB:=False;
                end;
            //移动支架
             for i := 0 to 1 do
              if First.MyOutLinePoint[i].Point.y > First.endsup then begin
                 First.MyOutLinePoint[i].Point.y:=round(First.endsup);
                 FlagB:=False;
              end;

              if First.MyOutLinePoint[7].Point.Y > First.endsup then begin
                 First.MyOutLinePoint[7].Point.Y:=round(First.endsup);
                 FlagB:=False;
              end;

            for i := 0 to 1 do
                if Second.MyOutLinePoint[i].Point.Y < Second.startsup then   begin
                  Second.MyOutLinePoint[i].Point.Y:=round(Second.startsup);
                  FlagB:=False;
                end;
            if Second.MyOutLinePoint[7].Point.Y < Second.startsup then begin
                 Second.MyOutLinePoint[7].Point.Y:=round(Second.startsup);
                 FlagB:=False;
              end;
             //

             if FlagB then  begin
                inc(Second.MyOutLinePoint[j].Point.x);
                inc(Second.MyOutLinePoint[j].Point.Y);
             end;

             if Forcount>10 then  break;

        end;
     end;


     REsult:=True;

end;

function TOldSteps.PrintOldStepResult(Memo: TMemo;Gzm:TGzm;SaveRecall,OutDao:Boolean;
                             MinDao,MaxDao:integer): Boolean;
var
  i,j:integer;
  ForCaseCount:integer;

begin
    Memo.Clear ;
    ForCaseCount:=0;
    for I := 0 to length(ExSteps)-1 do begin
         if ( ExSteps[i].Used <> 1)  then   continue;
         if ( ExSteps[i].ModifyData =3 )  then   continue;
         if ( ExSteps[i].ModifyData =2 )  then   continue;

        if (ExSteps[i].startDao >=MinDao ) and (ExSteps[i].endDao <=MaxDao) then  begin
           {如果进刀数 在当前主要分析的范围内}
            if  SaveRecall then  begin
               {如果确定进行重新分析}
                if ExSteps[i].ModifyData =4 then  // 保存的 来压步距数据
                    continue;
            end;

        end else begin
           {如果进刀数 不在当前主要分析的范围内}
           if not OutDao then
             if ExSteps[i].ModifyData =4 then  // 保存的 来压步距数据
                continue;
        end;

         if ( ExSteps[i].OneStepInfo.AreaQD < Gzm.RockPressAnalysis.JudgeMInQD ) then  continue;

         inc(ForCaseCount);
         Memo.Lines.Add('---------------------------------------------');
         Memo.Lines.Add('第【'+IntTostr(ForCaseCount)+'】矿压分析结果');
         Memo.Lines.Add('    本次来压进刀开始于【'+IntToStr(ExSteps[i].OneStepInfo.Start_MinDao)+
                         '】至【'+IntToStr(ExSteps[i].OneStepInfo.Start_maxDao)+'】刀') ;
         if ExSteps[i].OneStepInfo.Step_end_MinDao < ExSteps[i].OneStepInfo.Start_maxDao then   begin
             Memo.Lines.Add('    本次压力显现还没有结束,顶板压力显现即将开始！') ;
         end else begin
             Memo.Lines.Add('    本次压力显现进刀结束于【'+IntToStr(ExSteps[i].OneStepInfo.Step_end_MinDao)+
                         '】至【'+IntToStr(ExSteps[i].OneStepInfo.Step_end_MAXDao)+'】刀') ;
         end;

         Memo.Lines.Add('    本次压力显现支架范围【'+IntToStr(ExSteps[i].OneStepInfo.StartSup)+
                         '】至【'+IntToStr(ExSteps[i].OneStepInfo.EndSup)+'】架') ;
         Memo.Lines.Add('    本次压力显现最大压力【'+FormatFloat('0.00',ExSteps[i].OneStepInfo.MaxData)+
                         '】MPa') ;
         Memo.Lines.Add('    本次压力显现最小压力【'+FormatFloat('0.00',ExSteps[i].OneStepInfo.MinData)+
                         '】MPa') ;
         Memo.Lines.Add('    本次压力显现平均压力【'+FormatFloat('0.00',ExSteps[i].OneStepInfo.AGVDAta)+
                         '】MPa') ;
         Memo.Lines.Add('    本次压力显现均值系数为【'+FormatFloat('0.00',ExSteps[i].OneStepInfo.AGVDataQD)+
                         '】(均值为1)' );
         Memo.Lines.Add('    本次压力显现面积系数为【'+FormatFloat('0.00',ExSteps[i].OneStepInfo.AreaQD)+
                         '】(均值为1)') ;
         if ExSteps[i].OneStepInfo.Step_move_MinFootage >0 then
              Memo.Lines.Add('    本次压力显现步距为【'+FormatFloat('0.0',ExSteps[i].OneStepInfo.Step_move_MinFootage)+
                         '】至【'+FormatFloat('0.0',ExSteps[i].OneStepInfo.Step_move_MaxFootage)+'】米') ;
         if ExSteps[i].OneStepInfo.Step_Obvious_Footage[1] >0 then
              Memo.Lines.Add('    本次压力显现显著步距为【'+FormatFloat('0.00',ExSteps[i].OneStepInfo.Step_Obvious_Footage[1])+
                         '】至【'+FormatFloat('0.00',ExSteps[i].OneStepInfo.Step_Obvious_Footage[0])+'】米') ;

         if ExSteps[i].OneStepInfo.Step_Continue_Footage >0  then
               Memo.Lines.Add('    本次压力显现平稳推进距离为【'+FormatFloat('0.00',ExSteps[i].OneStepInfo.Step_Continue_Footage)+
                         '】米') ;
         Memo.Lines.Add('    本次压力显现压力较大支架为【'+ExSteps[i].OneStepInfo.SupportString+ '】') ;



    end;

end;

function TOldSteps.PrintPhaseSteps(Memo: TMemo; Gzm: TGzm;SaveRecall,OutDao:Boolean;
                       MinDao,MaxDao:integer): Boolean;
var
  i,j:integer;
  CalCount,CaseCount:integer;
begin
    Memo.Clear ;

    Memo.Lines.Add('--------------矿压分阶段压力显现计算结果展示--- -------------');
    for I := 0 to phaseNumber-1 do begin
         Memo.Lines.Add('---------------------------------------------');
         Memo.Lines.Add('第【'+IntTostr(i+1)+'】阶段压力显现结果');
         Memo.Lines.Add('   支架区间:第【'+IntTostr(PhaseSteps[i].StartsupBh)+'】 号 - ' +
                ' 【'+IntTostr(PhaseSteps[i].EndSupBh)+'】号');
         if PhaseSteps[i].StepCount<1 then  begin
            Memo.Lines.Add('   本阶段没有检测到明显压力显现');
            continue;
         end;
         CalCount:=1;CaseCount:=1;
        for j := 0 to PhaseSteps[i].StepCount -1 do   begin
            if PhaseSteps[i].Steps[j].ModifyData =3 then begin
                Memo.Lines.Add('---------------------------------------------');
                Memo.Lines.Add('   ##本阶段第【'+IntTostr(CaseCount)+'】次预测压力显现');

                Memo.Lines.Add('        预计压力显现进刀于【'+IntToStr(PhaseSteps[i].Steps[j].StartDao)+
                              '】至【'+IntToStr(PhaseSteps[i].Steps[j].EndDao)+'】刀之间') ;
                Memo.Lines.Add('        预计压力显现支架与【'+IntToStr(PhaseSteps[i].Steps[j].StartSup)+
                              '】至【'+IntToStr(PhaseSteps[i].Steps[j].EndSup)+'】之间') ;
                Memo.Lines.Add('        预计压力均值系数为【'+FormatFloat('0.00',PhaseSteps[i].Steps[j].AGVDataQD)+
                               '】(均值为1)' );
                Memo.Lines.Add('        预计压力显现面积系数为【'+FormatFloat('0.00',PhaseSteps[i].Steps[j].AreaQD)+
                               '】(均值为1)') ;
                Memo.Lines.Add('        预计压力显现过程将会持续【'+IntToStr(PhaseSteps[i].Steps[j].EndDao-
                                         PhaseSteps[i].Steps[j].StartDao)+'】刀') ;



               inc(CaseCount)
            end else begin
               Memo.Lines.Add('---------------------------------------------');
               Memo.Lines.Add('   #本阶段第【'+IntTostr(CalCount)+'】次压力显现');
               Memo.Lines.Add('        本次压力显现进刀开始于【'+IntToStr(PhaseSteps[i].Steps[j].Start_MinDao)+
                              '】至【'+IntToStr(PhaseSteps[i].Steps[j].Start_maxDao)+'】刀之间');
                if PhaseSteps[i].Steps[j].Step_end_MinDao < PhaseSteps[i].Steps[j].Start_maxDao then   begin
                   Memo.Lines.Add('        本次压力显现还没有结束,顶板压力显现即将开始！') ;
                end else begin
                   Memo.Lines.Add('        本次压力显现进刀结束于【'+IntToStr(PhaseSteps[i].Steps[j].Step_end_MinDao)+
                                  '】至【'+IntToStr(PhaseSteps[i].Steps[j].Step_end_MAXDao)+'】刀之间') ;
                end;
               Memo.Lines.Add('        本次压力显现支架范围【'+IntToStr(PhaseSteps[i].Steps[j].StartSup)+
                              '】至【'+IntToStr(PhaseSteps[i].Steps[j].EndSup)+'】架') ;
               Memo.Lines.Add('        本次压力显现最大压力【'+FormatFloat('0.00',PhaseSteps[i].Steps[j].MaxData)+
                               '】MPa') ;
               Memo.Lines.Add('        本次压力显现最小压力【'+FormatFloat('0.00',PhaseSteps[i].Steps[j].MinData)+
                               '】MPa') ;
               Memo.Lines.Add('        本次压力显现平均压力【'+FormatFloat('0.00',PhaseSteps[i].Steps[j].AGVDAta)+
                               '】MPa') ;
               Memo.Lines.Add('        本次压力均值系数为【'+FormatFloat('0.00',PhaseSteps[i].Steps[j].AGVDataQD)+
                               '】(均值为1)' );
               Memo.Lines.Add('        本次显现面积系数为【'+FormatFloat('0.00',PhaseSteps[i].Steps[j].AreaQD)+
                               '】(均值为1)') ;
               if PhaseSteps[i].Steps[j].Step_move_MinFootage >0 then
                   Memo.Lines.Add('        本次压力显现步距为【'+FormatFloat('0.0',PhaseSteps[i].Steps[j].Step_move_MinFootage)+
                               '】至【'+FormatFloat('0.0',PhaseSteps[i].Steps[j].Step_move_MaxFootage)+'】米') ;
               if PhaseSteps[i].Steps[j].Step_Obvious_Footage[1] >0 then

                   Memo.Lines.Add('        本次压力显现显著步距为【'+FormatFloat('0.00',PhaseSteps[i].Steps[j].Step_Obvious_Footage[1])+
                               '】至【'+FormatFloat('0.00',PhaseSteps[i].Steps[j].Step_Obvious_Footage[0])+'】米') ;

               if PhaseSteps[i].Steps[j].Step_Continue_Footage >0  then
                   Memo.Lines.Add('        本次压力显现平稳推进距离为【'+FormatFloat('0.00',PhaseSteps[i].Steps[j].Step_Continue_Footage)+
                               '】米') ;
               Memo.Lines.Add('        本次压力显现压力较大支架为【'+PhaseSteps[i].Steps[j].SupportString+ '】') ;

            end;
           inc(CalCount) ;
        end;
    end;


end;

function TOldSteps.PrintStepsIntoStringGrid(StrGrid: TStringGrid; Gzm:TGzm): string;
var
  i,j,N:integer;
  StepCount,CaseCount,GridRow:integer;
  MergeCell,Col1Str,Col2Str:string;
  Step_NO,Ex_Stepid:integer;
  prostep: TcomprehensiveOldStep;
  iSour_Row,forCaseCount:integer;
begin
    // 把打印标记清空
    for I := 0 to length(ExSteps)-1 do
       ExSteps[i].OneStepInfo.PrintBool :=False;

    StepCount:=0;
    GridRow:=2;

    //工作面 顶板剧烈压力显现信息
     MergeCell:='1,' + IntTostr(GridRow)+',21,' + IntTostr(GridRow) +';';
     SplitStringToStringCell(StrGrid,1,GridRow,'工作面顶板整体矿压显现判断模式——矿压显现显著步距信息');
     Step_NO:=0;
    for I := 0 to length(ExSteps)-1 do begin
         if StrGrid.RowCount < GridRow+2 then  StrGrid.RowCount:= GridRow+2;
            MergeCell:=MergeCell+
                  FillStringWholeGZmData_Main(StrGrid,Gzm,i,10,
                                     GridRow,StepCount
                                     ) ;

    end;
     //工作面 顶板轻度矿压显现信息
     inc(GridRow);
     MergeCell:=MergeCell+'1,' + IntTostr(GridRow)+',21,' + IntTostr(GridRow) +';';
     SplitStringToStringCell(StrGrid,1,GridRow,'工作面顶板整体矿压显现判断模式——矿压显现明显步距信息');
     StepCount:=0;
    for I := 0 to length(ExSteps)-1 do begin
        if StrGrid.RowCount < GridRow+2 then  StrGrid.RowCount:= GridRow+2;
           MergeCell:=MergeCell+
                  FillStringWholeGZmData_Main(StrGrid,Gzm,i,9,
                                     GridRow,StepCount
                                     );
    end;

      //工作面 顶板轻度矿压显现信息
     inc(GridRow);
     MergeCell:=MergeCell+'1,' + IntTostr(GridRow)+',21,' + IntTostr(GridRow) +';';
     SplitStringToStringCell(StrGrid,1,GridRow,'工作面顶板整体矿压显现判断模式——局部显现异常信息');
     StepCount:=0;
    for I := 0 to length(ExSteps)-1 do begin
         if StrGrid.RowCount < GridRow+2 then  StrGrid.RowCount:= GridRow+2;
         MergeCell:=MergeCell+
                  FillStringWholeGZmData_Main(StrGrid,Gzm,i,8,
                                     GridRow,StepCount
                                     ) ;
         MergeCell:=MergeCell+
                  FillStringWholeGZmData_Main(StrGrid,Gzm,i,5,
                                     GridRow,StepCount
                                     ) ;
         MergeCell:=MergeCell+
                  FillStringWholeGZmData_Main(StrGrid,Gzm,i,6,
                                     GridRow,StepCount
                                     ) ;

    end;


//    //阶段矿压显现方式
//
    inc(GridRow); inc(GridRow);
    if StrGrid.RowCount < GridRow+2 then  StrGrid.RowCount:= GridRow+2;
     MergeCell:=MergeCell+'1,' + IntTostr(GridRow)+',21,' + IntTostr(GridRow) +';';
     SplitStringToStringCell(StrGrid,1,GridRow,'工作面顶板按阶段矿压显现判断模式列表');
     for I := 0 to phaseNumber-1 do begin
         if PhaseSteps[i].StepCount<1 then  begin
            continue;
         end;


          for j := 0 to PhaseSteps[i].StepCount -1 do
              PhaseSteps[i].Steps[j].PrintBool:=False;


         inc(GridRow);   inc(GridRow);
         StepCount:=0;
         if StrGrid.RowCount < GridRow+2 then  StrGrid.RowCount:= GridRow+2;
         //-------------------
         iSour_Row:=GridRow;
          for j := 0 to PhaseSteps[i].StepCount -1 do
             if PhaseSteps[i].Steps[j].ModifyData =10  then begin
                FillStringPhaseGzmData_Main(StrGrid,
                                PhaseSteps[i].StartsupBh ,PhaseSteps[i].EndSupBh,
                                PhaseSteps[i].Steps[j],
                                GridRow,StepCount,
                                '分析','第['+IntToStr(i+1)+']阶段'
                                );
             end;

         if GridRow>iSour_Row then  begin
             MergeCell:=MergeCell+'6,' + IntTostr(iSour_Row)+',17,' + IntTostr(iSour_Row) +';';
            SplitStringToStringCell(StrGrid,6,iSour_Row,'第['+IntToStr(i+1)+']阶段——矿压显现显著步距信息');
         end else begin
            dec(GridRow);
         end;
         //---------------
         inc(GridRow);
         if StrGrid.RowCount < GridRow+2 then  StrGrid.RowCount:= GridRow+2;
         iSour_Row:=GridRow;
          for j := 0 to PhaseSteps[i].StepCount -1 do
             if PhaseSteps[i].Steps[j].ModifyData =9  then begin
                FillStringPhaseGzmData_Main(StrGrid,
                                PhaseSteps[i].StartsupBh ,PhaseSteps[i].EndSupBh,
                                PhaseSteps[i].Steps[j],
                                GridRow,StepCount,
                                '分析','第['+IntToStr(i+1)+']阶段'
                                );
             end;

         if GridRow>iSour_Row then  begin
             MergeCell:=MergeCell+'6,' + IntTostr(iSour_Row)+',17,' + IntTostr(iSour_Row) +';';
            SplitStringToStringCell(StrGrid,6,iSour_Row,'第['+IntToStr(i+1)+']阶段——矿压显现明显信息');
         end else begin
            dec(GridRow);
         end;
         //-------------------------
         inc(GridRow);
          if StrGrid.RowCount < GridRow+2 then  StrGrid.RowCount:= GridRow+2;
         iSour_Row:=GridRow;
         for j := 0 to PhaseSteps[i].StepCount -1 do
             if PhaseSteps[i].Steps[j].ModifyData =8  then begin
                FillStringPhaseGzmData_Main(StrGrid,
                                PhaseSteps[i].StartsupBh ,PhaseSteps[i].EndSupBh,
                                PhaseSteps[i].Steps[j],
                                GridRow,StepCount,
                                '分析','第['+IntToStr(i+1)+']阶段'
                                );
             end;

          for j := 0 to PhaseSteps[i].StepCount -1 do  begin
             if PhaseSteps[i].Steps[j].ModifyData =5  then begin
                FillStringPhaseGzmData_Main(StrGrid,
                                PhaseSteps[i].StartsupBh ,PhaseSteps[i].EndSupBh,
                                PhaseSteps[i].Steps[j],
                                GridRow,StepCount,
                                '分析','第['+IntToStr(i+1)+']阶段'
                                );
             end;

             if PhaseSteps[i].Steps[j].ModifyData =6
               then begin
                FillStringPhaseGzmData_Main(StrGrid,
                                PhaseSteps[i].StartsupBh ,PhaseSteps[i].EndSupBh,
                                PhaseSteps[i].Steps[j],
                                GridRow,StepCount,
                                '分析','第['+IntToStr(i+1)+']阶段'
                                );
             end;


          end;


         if GridRow>iSour_Row then  begin
             MergeCell:=MergeCell+'6,' + IntTostr(iSour_Row)+',17,' + IntTostr(iSour_Row) +';';
            SplitStringToStringCell(StrGrid,6,iSour_Row,'第['+IntToStr(i+1)+']阶段——局部矿压显现异常信息');
         end else begin
            dec(GridRow);
         end;


         //
         inc(GridRow);
          if StrGrid.RowCount < GridRow+2 then  StrGrid.RowCount:= GridRow+2;
         iSour_Row:=GridRow;
          forCaseCount:=0;
          for j := 0 to PhaseSteps[i].StepCount -1 do  begin
             if PhaseSteps[i].Steps[j].ModifyData =3 *10   then begin
                FillStringPhaseGzmData_Main(StrGrid,
                                PhaseSteps[i].StartsupBh ,PhaseSteps[i].EndSupBh,
                                PhaseSteps[i].Steps[j],
                                GridRow,forCaseCount,
                                '预测','第['+IntToStr(i+1)+']阶段'
                                );
             end;
          end;

         if GridRow>iSour_Row then  begin
              MergeCell:=MergeCell+'6,' + IntTostr(iSour_Row)+',17,' + IntTostr(iSour_Row) +';';
             SplitStringToStringCell(StrGrid,6,iSour_Row,'第['+IntToStr(i+1)+']阶段——预测矿压显现显著信息');
         end else begin
            dec(GridRow);
         end;
          //
         inc(GridRow);
          if StrGrid.RowCount < GridRow+2 then  StrGrid.RowCount:= GridRow+2;
         iSour_Row:=GridRow;
          forCaseCount:=0;
          for j := 0 to PhaseSteps[i].StepCount -1 do  begin
             if PhaseSteps[i].Steps[j].ModifyData =3 *9   then begin
                FillStringPhaseGzmData_Main(StrGrid,
                                PhaseSteps[i].StartsupBh ,PhaseSteps[i].EndSupBh,
                                PhaseSteps[i].Steps[j],
                                GridRow,forCaseCount,
                                '预测','第['+IntToStr(i+1)+']阶段'
                                );
             end;
          end;

         if GridRow>iSour_Row then  begin
              MergeCell:=MergeCell+'6,' + IntTostr(iSour_Row)+',17,' + IntTostr(iSour_Row) +';';
             SplitStringToStringCell(StrGrid,6,iSour_Row,'第['+IntToStr(i+1)+']阶段——预测矿压显现明显');
         end else begin
            dec(GridRow);
         end;
     end;



   Result:=MergeCell;
end;

procedure TOldSteps.Refresh;
var
  i,j,m:integer;
  pt:Tpoint;
begin
  for I := 0 to length(ExSteps)-1 do  begin
      if  ExSteps[i].Used <>1 then   continue;
      if  ExSteps[i].ModifyData =4    then  continue;   //4 是代表数据库 中提取的数据

       for j := i+1 to length(ExSteps)-1 do begin
            if ExSteps[j].Used <> 1 then   continue;    // 没有用的数据 不处理
            if ExSteps[j].ModifyData = 4 then continue;   // 4 是代表数据库 中提取的数据

            if i=j then continue;

            if ExSteps[j].startDao > ExSteps[i].endDao  then   continue;    // 如果开始刀数在后面
            if ExSteps[j].startsup > ExSteps[i].endsup  then   continue;    //   如果开始支架在后面


            {区域包含关系}
            if (ExSteps[i].startDao <=ExSteps[j].startDao )   and (ExSteps[i].endDao >=ExSteps[j].endDao )
                and (ExSteps[i].startsup <=ExSteps[j].startsup )   and (ExSteps[i].endsup >=ExSteps[j].endsup )  then
                  ExSteps[j].Used :=0;
            {区域兼容关系}
            if ExSteps[j].Used=1 then  begin
               mergeTwoOldSteps(ExSteps[i],ExSteps[j]);
            end;
       end;
      ExSteps[i].SetJudgeLevelLineDat(JudgeLevelLineData);
      ExSteps[i].Refresh;
  end;
end;

function TOldSteps.ReturnEffiectArea: Double;
var
  SumArea:Double;
  i:integer;
begin
    SumArea:=0;
    for I := 0 to length(ExSteps)-1 do
      if (ExSteps[i].Used =1)  and
         ((ExSteps[i].ModifyData =1) or (ExSteps[i].ModifyData =5) or (ExSteps[i].ModifyData =6)) then
          SumArea:=SumArea+ ExSteps[i].Return_Whole_Area;

   Result:=SumArea;


end;

function TOldSteps.ReturnExStepidFromInn_Stepid(In_id: integer): Integer;
var
  i:integer;
begin
    Result:=0;
    for I := 0 to length(ExSteps)-1 do
      if ExSteps[i].inn_InStep_id =In_id then  begin
         Result:=i;
         Exit;
      end;


end;

function TOldSteps.ReturnEXStepSortid(ps: TOldOneStep): integer;
{
  数组的排序以 进刀结束 为第一排序
            以结束支架为第二排序

}
var
  i:integer;
begin
    Result:=-1;
    for I := 0 to length(ExSteps)-1 do  begin
       if Round(ps.endDao)<Round(ExSteps[i].endDao) then  begin
          Result:=i;exit;
       end else  if (Round(ps.EndDao) =Round(ExSteps[i].EndDao) ) and (ps.EndSup <ExSteps[i].Endsup)  then begin
          Result:=i;exit;
       end;

    end;

end;

function TOldSteps.ReturnIntMax(X, Y: integer): integer;
begin
    if X>Y then  Result:=X
       Else REsult:=Y;
end;

function TOldSteps.ReturnIntMin(X, Y: integer): integer;
begin
   if X>Y then  Result:=Y
       Else REsult:=X;
end;

function TOldSteps.ReturnMax(x,y:double): double;
begin
    if X>y then     Result:=x
     else Result:=y;
end;

function TOldSteps.ReturnMin(x, y: double): double;
begin
        if x=0 then begin
           Result:=y ; exit;
        end;
        if Y=0 then begin
           Result:=X ; exit;
        end;

        if X>y then     Result:=y
        else Result:=x;
end;

function TOldSteps.ReturnOldStepForLineGrap(var Rec:TSupportRecord;Gzm:TGzm;SaveRecall,OutDao:Boolean;
                              MinDao,MaxDao,Unit_KK:integer):Boolean;
var
  i,j,ForCaseCount:integer;
  AGV_DAo:integer;
  tmptime,MaxTime:TdateTime;
  MaxData:Double;
  LabMark:string;
  id:integer;
begin


   Rec.QL_oldStepCount:=0;ForCaseCount:=0;
    // 首先标注 剧烈矿压显现信息
    for I := 0 to length(ExSteps)-1 do begin
        // 首先判断支架编号
         if (Rec.SupportBh < ExSteps[i].OneStepInfo.StartSup) or (Rec.SupportBh > ExSteps[i].OneStepInfo.EndSup ) then
             continue;
         if ( ExSteps[i].Used <> 1)  then   continue;
         if  ExSteps[i].ModifyData=10 then begin
             // 找到平均进刀
             AGV_DAo:= (ExSteps[i].OneStepInfo.StartDao+ExSteps[i].OneStepInfo.EndDao ) div 2;
             tmptime:=Gzm.ReturnDataTimeFromDao(AGV_DAo) ;
             if ReturnStepMaxData(Gzm,Rec.SupportBh,tmptime,MaxTime,MaxData) then begin
                if (MaxTime> Rec.MaxTime) or (MaxTime< Rec.MinTime ) then  continue;
                inc(ForCaseCount);
                LabMark:='矿压显现显著:['+IntTostr(Rec.SupportBh)+']架第(Q_'+IntTostr(ForCaseCount)+')次';
                id:=Rec.PointSeries.AddXY(MaxTime,MaxData*Unit_KK,LabMark) ;
                Rec.PointSeries.Marks.Item[id].Text.Text:=LabMark;
                inc(Rec.QL_oldStepCount);
                setlength(Rec.QL_oldsteps,Rec.QL_oldStepCount);
                Rec.QL_oldsteps[Rec.QL_oldStepCount-1]:= ExSteps[i];
             end;
         end;




//         //更改一下算法
//           if  ExSteps[i].ModifyData=10 then begin
//             for j := 0 to high(ExSteps[i].SupStep) do
//               if ExSteps[i].SupStep[j].Supportbh= Rec.SupportBh then
//                  if (ExSteps[i].SupStep[j].MaxDataTime<= Rec.MaxTime) and
//                     (ExSteps[i].SupStep[j].MaxDataTime >=Rec.MinTime )  then begin
//                      inc(ForCaseCount);
//                      LabMark:='['+IntTostr(Rec.SupportBh)+']架第('+IntTostr(ForCaseCount)+')次强烈矿压显现';
//                      Rec.PointSeries.AddXY(ExSteps[i].SupStep[j].MaxDataTime,ExSteps[i].SupStep[j].MaxData*Unit_KK,LabMark) ;
//                      Rec.PointSeries.Marks.Font.Size :=8;
//                      Rec.PointSeries.Marks.Color :=Clred;
//                      inc(Rec.oldStepCount);
//                      setlength(Rec.oldsteps,Rec.oldStepCount);
//                      Rec.oldsteps[Rec.oldStepCount-1]:= ExSteps[i];
//                  end;
//           end;


    end;

    ForCaseCount:=0; Rec.YB_oldStepCount:=0;

    // 首先标注 剧烈矿压显现信息
    for I := 0 to length(ExSteps)-1 do begin
        // 首先判断支架编号
         if (Rec.SupportBh < ExSteps[i].OneStepInfo.StartSup) or (Rec.SupportBh > ExSteps[i].OneStepInfo.EndSup ) then
             continue;
         if ( ExSteps[i].Used <> 1)  then   continue;
         if  ExSteps[i].ModifyData=9 then begin
             // 找到平均进刀
             AGV_DAo:= (ExSteps[i].OneStepInfo.StartDao+ExSteps[i].OneStepInfo.EndDao ) div 2;
             tmptime:=Gzm.ReturnDataTimeFromDao(AGV_DAo) ;
             if ReturnStepMaxData(Gzm,Rec.SupportBh,tmptime,MaxTime,MaxData) then begin
                if (MaxTime> Rec.MaxTime) or (MaxTime< Rec.MinTime ) then  continue;
                inc(ForCaseCount);
                LabMark:='矿压显现明显:['+IntTostr(Rec.SupportBh)+']架第(Y_'+IntTostr(ForCaseCount)+')次';
                Rec.PointSeries.AddXY(MaxTime,MaxData*Unit_KK,LabMark) ;
                inc(Rec.YB_oldStepCount);
                setlength(Rec.YB_oldsteps,Rec.YB_oldStepCount);
                Rec.YB_oldsteps[Rec.YB_oldStepCount-1]:= ExSteps[i];
             end;
         end;
    end;

    ForCaseCount:=0; Rec.JB_oldStepCount:=0;

    // 首先标注 剧烈矿压显现信息
    for I := 0 to length(ExSteps)-1 do begin
        // 首先判断支架编号
         if (Rec.SupportBh < ExSteps[i].OneStepInfo.StartSup) or (Rec.SupportBh > ExSteps[i].OneStepInfo.EndSup ) then
             continue;
         if ( ExSteps[i].Used <> 1)  then   continue;
         if  ExSteps[i].ModifyData=8 then begin
             // 找到平均进刀
             AGV_DAo:= (ExSteps[i].OneStepInfo.StartDao+ExSteps[i].OneStepInfo.EndDao ) div 2;
             tmptime:=Gzm.ReturnDataTimeFromDao(AGV_DAo) ;
             if ReturnStepMaxData(Gzm,Rec.SupportBh,tmptime,MaxTime,MaxData) then begin
                if (MaxTime> Rec.MaxTime) or (MaxTime< Rec.MinTime ) then  continue;
                inc(ForCaseCount);
                LabMark:='局部矿压异常:['+IntTostr(Rec.SupportBh)+']架第(J_'+IntTostr(ForCaseCount)+')次';
                Rec.PointSeries.Marks.Font.Size :=8;
                Rec.PointSeries.AddXY(MaxTime,MaxData*Unit_KK,LabMark) ;
                inc(Rec.JB_oldStepCount);
                setlength(Rec.JB_oldsteps,Rec.JB_oldStepCount);
                Rec.JB_oldsteps[Rec.JB_oldStepCount-1]:= ExSteps[i];
             end;
         end;
    end;
    Result:=true;
end;

function TOldSteps.ReturnStepArea_Ratio: Double;
var
  totalArea:Double;
begin
   Result:=0;
   totalArea:=MaxSupportNumber*(Grap_MaxDao-Grap_MinDao);
   if totalArea >0 then
       REsult:=ReturnEffiectArea/totalArea *100;
   UsedJudgeStep_Ratio:=  ReturnEffiectArea/totalArea *100;
end;

function TOldSteps.ReturnStepid(MPIndex: integer;var Edited:Boolean): Integer;
 var
   i:integer;
begin
   Result:=-1;
   Edited:=true;
   for I := 0 to length(ExSteps)-1 do
      if ExSteps[i].MapSeriesIndex =MPIndex then  begin
         if (ExSteps[i].ModifyData = 4 ) // 不重新计算 不可编辑状态
            then  exit;
         if (ExSteps[i].ModifyData = 3 )  then   // 预测数据不可编辑
             Edited:=False;
         Result:= i;
         exit;
      end;
end;

function TOldSteps.ReturnStepMaxData(Gzm:TGzm;Supbh: integer; TdTime: TdateTime;
  var MaxTime: TDateTime; var DataValue: Double): Boolean;
var
  str_td:string;
begin
    str_td:=Public_Basic.ReturnDateTimeString(MainDataModule.DataType ,TdTime);
    Result:=Gzm.ReturnCycleStepMaxValue(str_td,Supbh,MaxTime,DataValue) ;
end;


function TOldSteps.ReturnTwoStephaveSamePrvStep(First,
  Second: TcomprehensiveOldStep): Boolean;
var
  i,j:integer;
begin
     Result:=False;
     for i := 0 to First.ProStepCount -1 do
         for j := 0 to second.ProStepCount -1 do
           if First.ProStepClassID[i]=second.ProStepClassID[j] then  begin
             Result:=true;
             exit;
           end;


end;

function TOldSteps.SelectNextStepId(PrvStep: TOldOneStep;
               FcD:Array of TContourFootageData;Currid:integer): Boolean;
{主要功能是找到前面一个步距的编号}
var
  i:integer;
begin
    Result:=False;

    for I := 0 to length(EXSteps)-1 do begin
        if ExSteps[i].Used <>1  then   continue;
        if i= ReturnExStepidFromInn_Stepid(PrvStep.OneStepInfo.ExStepClassid)  then  continue;
        if ExSteps[i].ModifyData =3 then  continue;
        if ExSteps[i].ModifyData =2 then  continue;  //q区域步距
        if ExSteps[i].ModifyData < PrvStep.ModifyData  then     continue; // 不是一个级别的不考虑

        { 该步距在 查询步距的前方}
        if (ExSteps[i].OneStepInfo.endDao < PrvStep.OneStepInfo.startDao) or
           (ExSteps[i].OneStepInfo.startDao < PrvStep.OneStepInfo.startDao) then begin
           if (ExSteps[i].ModifyData> PrvStep.ModifyData)  then  begin
              if  (PrvStep.OneStepInfo.StartSup >=ExSteps[i].startsup  ) and
                  (PrvStep.OneStepInfo.EndSup  <=ExSteps[i].endsup  )   then
                if PrvStep.OneStepInfo.ProStepCount< 10 then   begin
                    inc(PrvStep.OneStepInfo.ProStepCount );
                    PrvStep.OneStepInfo.ProStepClassID[ExSteps[i].OneStepInfo.ProStepCount-1]:=ExSteps[i].inn_InStep_id ;
                end;
           end;
           continue;
        end;


        {该步距在查询步距的上方}
        if ExSteps[i].OneStepInfo.startsup > PrvStep.OneStepInfo.endsup then  continue;

        {该步距在查询步距的下方}
        if ExSteps[i].OneStepInfo.endsup < PrvStep.OneStepInfo.startsup  then   continue;

        {保证运动步距的有效性  相当于 面积}
        if ExSteps[i].OneStepInfo.Count <1  then  continue;
        if JudgeNestStepisEfficent(PrvStep,i) then
           if PrvStep.OneStepInfo.NextStepCount<10  then  begin
               if (PrvStep.OneStepInfo.Step_NO < 0 ) and (PrvStep.OneStepInfo.ProStepCount <1) then
                   if ExSteps[i].OneStepInfo.Step_NO >0 then   begin
                      if PrvStep.ModifyData =10 then begin
                         PrvStep.OneStepInfo.Step_NO:=ExSteps[i].OneStepInfo.Step_NO-4;
                      end else begin
                         PrvStep.OneStepInfo.Step_NO:=ExSteps[i].OneStepInfo.Step_NO-2;
                      end;


                   end else begin
                      PrvStep.OneStepInfo.Step_NO:=5;
                   end;
              inc(PrvStep.OneStepInfo.NextStepCount );
              prvStep.OneStepInfo.NextStepClassID[PrvStep.OneStepInfo.NextStepCount -1]:=ExSteps[i].inn_InStep_id;
              if ExSteps[i].OneStepInfo.Step_NO <0  then
                 ExSteps[i].OneStepInfo.Step_NO :=PrvStep.OneStepInfo.Step_NO+5;

              if ExSteps[i].OneStepInfo.ProStepCount< 10 then   begin
                  inc(ExSteps[i].OneStepInfo.ProStepCount );
                  ExSteps[i].OneStepInfo.ProStepClassID[ExSteps[i].OneStepInfo.ProStepCount-1]:=ExSteps[Currid].inn_InStep_id ;
              end;

              Result:=True;
           end;
    end;

end;

function TOldSteps.SelectWhichStepInThisPhaseNumber(startid:integer;StartSup, EndSup,
       StartDao,EndDao:integer;MaxQd:double): Integer;
var
  i:integer;
begin
   Result:=-1;
   if startid >length(ExSteps)-1 then   exit;

   for I := startid to length(ExSteps)-1 do   begin
      if ExSteps[i].Used <> 1 then  continue; // 0 无效 2 删除
      if ExSteps[i].ModifyData =3 then  continue;  // 3 预测步距

      if ExSteps[i].OneStepInfo.AreaQD <MaxQd then continue;

      if ExSteps[i].OneStepInfo.StartSup > EndSup  then continue;
      if ExSteps[i].OneStepInfo.EndSup < StartSup then  Continue;

      if ExSteps[i].OneStepInfo.EndDao < EndDao then  continue;

      Result:=i;
      break;

   end;

end;



procedure TOldSteps.SetJudgeBasicParameters(Sup, Dao: Double;lmd:integer);
begin
    ContinueSupport:=Round(Sup);
    ContinueJinDao:=Round(Dao);
    Dispose_LMd:=lmd;
end;



procedure TOldSteps.SetJudgeLevelLineDat(Value: Double);
begin
    JudgeLevelLineData:=Value;
end;

procedure TOldSteps.SetMaxFootage(Value: Double);
begin
   MaxFootage:=Value;
end;

procedure TOldSteps.SetMax_Min_Jindao(Min_D, MAx_D: Integer);
begin
   Grap_MinDao:=Min_D;
   Grap_MaxDao:=MAx_D;
end;

procedure TOldSteps.SetMax_Supportbh(Value: integer);
begin
   MaxSupportNumber:=Value;
end;

procedure TOldSteps.Sort;
var
  i,j:integer;
  ExCount,insertId:integer;
begin
    setlength(Exsteps,0) ;
    ExCount:=0;
    for I := 0 to length(inSteps) -1 do    begin
       // if inSteps[i].Used =0 then  continue;
        insertId:=ReturnEXStepSortid(inSteps[i]);
        inc(ExCount);
        setlength(Exsteps,ExCount) ;
        if insertId >=0  then  begin
           for j := ExCount-2 downto insertId do  begin
                Exsteps[j+1]:=Exsteps[j];
           end;
           Exsteps[insertId]:=inSteps[i];

        end else begin
           Exsteps[ExCount-1]:=inSteps[i];
        end;
    end;


end;

function TOldSteps.SplitCycle(Startid, Endid: integer): Boolean;
begin
   Result:=False;
   if CalPolygonArea_LeftPoints(Startid,Endid) > ContinueSupport*ContinueJinDao  then  begin
      JudgeChildCycle(Startid, Endid);
   end;
   DispostCycleData(Startid, Endid);
end;

function TOldSteps.SplitPhaseString(StrV: String): Boolean;
var
   s_temp,s2:Str_DT_array;
   C1,C2,i:integer;
begin
   Result:=False;
   if length(trim(StrV))>0 then   begin
         s_temp:=Public_Basic.split(StrV,';',C1);
         if C1> 0 then  begin
            PhaseNumber:=Public_Basic.StrToInt_lu(s_temp[0]) ;
         end else begin
            exit;
         end;

          for I := 0 to PhaseNumber-1 do  begin
              S2:=Public_Basic.split(s_temp[i+1],',',C2);
              if C2>0  then  begin
                 PhaseSteps[i].StartsupBh :=Public_Basic.StrToInt_lu(S2[0]) ;
                 PhaseSteps[i].EndSupBh:=Public_Basic.StrToInt_lu(S2[1]) ;
              end;
          end;
          Result:=true;
   end;


end;

procedure TOldSteps.SplitStringToStringCell(StrGrid: TStringGrid; Col,
  Row: integer; Str: String);
var
   i:integer;
begin
    i:=1;
    while i<= length(str) do begin
        StrGrid.Cells[Col,Row]:=Copy(str,i,2);
        inc(Col);
        i:=i+2;
    end;


end;

function TOldSteps.SplitSupString(Str: String; MinSup, MaxSup: Integer): String;
var
   s_temp:Str_DT_array;
   C1,i,sup:integer;
   st_tmp:string;
begin
   if Str='' then  exit;
   s_temp:=Public_Basic.split(Str,',',C1);
   st_tmp:='';
   for I := 0 to c1-1 do  begin
       sup:=Public_Basic.StrToInt_lu(s_temp[i]);
       if (sup>=MinSup) and (Sup<=MaxSup) then  begin
          st_tmp:=st_tmp+IntToStr(Sup) +',';
       end else if (Sup >MaxSup) then  begin
          break;
       end;
   end;

   Result:=st_tmp;
end;

{ TOldStepPhase }

procedure TOldStepPhase.AddOneStep(Step: TcomprehensiveOldStep);
begin
   inc(StepCount);
   setlength(steps,StepCount);
   Steps[StepCount-1]:=Step;
end;

procedure TOldStepPhase.addPhaseAGV_Dao(Va: TPhaseJinDaoAGVRec);
begin
  inc(PhaseAGV_Count);
  setlength(PhaseAGV_EvenDao,PhaseAGV_Count);
  PhaseAGV_EvenDao[PhaseAGV_Count-1]:=Va;
end;

procedure TOldStepPhase.ADD_Step_Array(st_id,Ed_id,St_dao,Ed_dao,Max_v,Min_V: integer;
             UpperLD,DownLD:double;ULSt,ULEd:integer);
{
    st_id 区间开始的内码编号
    Ed_id, 区间结束的内码编号
    St_dao, 区间开始的刀数
    Ed_dao, 区间结束的进刀数
    Max_v,  区间最大值进刀
    Min_V   区间最小值 进刀
    UpperLD  超过均值的得数 的平均值
    DownLD:   低于 均值的数的 平均均
    ULSt  超过 均值的开始编号
    ULEd  超过均值结束的编号

}
begin
  inc(Step_Array_Count);
  setlength(Step_Array,Step_Array_Count);
  Step_Array[Step_Array_Count-1]:=TPhaseRecord.Create ;
  Step_Array[Step_Array_Count-1].Startid:=st_id;
  Step_Array[Step_Array_Count-1].Endid:=ed_id;
  Step_Array[Step_Array_Count-1].StartDao :=st_dao;
  Step_Array[Step_Array_Count-1].EndDao:=Ed_dao;
  Step_Array[Step_Array_Count-1].MaxValueDao:=Max_v;
  Step_Array[Step_Array_Count-1].MinValueDao:=Min_V;
  Step_Array[Step_Array_Count-1].UpperLineData :=UpperLD;
  Step_Array[Step_Array_Count-1].DownLineData :=DownLd;
  Step_Array[Step_Array_Count-1].ULSt := ULSt;
  Step_Array[Step_Array_Count-1].ULEn := ULEd;
  if (st_id>=0) and (st_id<=High(PhaseAGV_EvenDao)) then
     Step_Array[Step_Array_Count-1].StartFootage:=PhaseAGV_EvenDao[st_id].Footage ;
  if (ed_id>=0) and (ed_id<=High(PhaseAGV_EvenDao)) then
     Step_Array[Step_Array_Count-1].EndFootage:=PhaseAGV_EvenDao[ed_id].Footage ;

  if (Step_Array[Step_Array_Count-1].EndFootage-Step_Array[Step_Array_Count-1].StartFootage) >
     (Step_Array[Step_Array_Count-1].EndDao-Step_Array[Step_Array_Count-1].StartDao)   then  begin
       Step_Array[Step_Array_Count-1].StartFootage:=Step_Array[Step_Array_Count-1].EndFootage-
        (Step_Array[Step_Array_Count-1].EndDao-Step_Array[Step_Array_Count-1].StartDao) *0.8;
     end;


  if (ULSt>=0) and (ULSt<=High(PhaseAGV_EvenDao)) then begin
     Step_Array[Step_Array_Count-1].UL_St_Dao:=PhaseAGV_EvenDao[ULSt].JinDao ;
     Step_Array[Step_Array_Count-1].UL_St_Footage:=PhaseAGV_EvenDao[ULSt].Footage ;
  end;

  if (ULEd>=0) and (ULEd<=High(PhaseAGV_EvenDao)) then begin
     Step_Array[Step_Array_Count-1].UL_En_Dao:=PhaseAGV_EvenDao[ULEd].JinDao ;
     Step_Array[Step_Array_Count-1].UL_En_Footage:=PhaseAGV_EvenDao[ULEd].Footage ;
  end;

end;

procedure TOldStepPhase.CalculateComeStepInfo(st, Ed: TcomprehensiveOldStep);
begin

end;



procedure TOldStepPhase.CalPhaseAGVDAta(DC: TDoubleContourRecord;FD:Array of TContourFootageData);
var
  i,j:integer;
  AGVData,MaxDAta,MzlData:double;
  Footage:double;
  Count:Integer;
  temp:TPhaseJinDaoAGVRec;
begin
   //清理
   Clear_AddPhaseGAv;
   for I := StartDao to EndDao do begin
      Count:=0; AGVData:=0; MaxDAta:=0;MzlData :=0;
      Footage:=0;
      for j := StartsupBh to EndSupBh do
        if (DC[i][j].DataType >0)  then  begin
           if DC[i][j].AGV_Value>0 then  begin
               AGVData:=AGVData+DC[i][j].AGV_Value;
               MaxDAta:=MaxDAta+DC[i][j].Max_Value;
               MzlData:=MzlData+DC[i][j].MZL_Value;
               Footage:=Footage+DC[i][j].footage ;
               inc(Count);
           end else if DC[i][j].Manual_Value>0 then  begin
               AGVData:=AGVData+DC[i][j].Manual_Value;
               Footage:=Footage+DC[i][j].footage ;
               inc(Count);
           end;
        end;

      if Count>0 then  begin
         temp.JinDao :=i;
         temp.AGVData:=AGVData/Count;
         temp.MAXData:=MaxDAta/Count;
         temp.MzlData:=MzlData/Count;
         temp.Footage:=Footage/Count;
         temp.gent:=FD[i].Dt;
         addPhaseAGV_Dao(temp);
      end;
   end;

end;

function  TOldStepPhase.CleanData(Step:TOldOneStep; TCoSt:TcomprehensiveOldStep ) :TcomprehensiveOldStep;
var
  i,in_j:integer;
  tmp:TcomprehensiveOldStep;
begin

    tmp:= TCoSt;
    if tmp.StartSup < Startsupbh then
       tmp.StartSup := Startsupbh;
    if tmp.EndSup > Endsupbh then
       tmp.EndSup :=EndSupbh;

    Result:=Step.FillOneStepInfo (tmp,Step.SupStep,Round(Step.startsup),tmp.StartSup,tmp.EndSup );
end;

procedure TOldStepPhase.Clear;
begin
   setlength(Steps,0);
   StepCount:=0;
end;

procedure TOldStepPhase.Clear_AddPhaseGAv;
begin
  PhaseAGV_Count:=0;
  setlength(PhaseAGV_EvenDao,0);

end;

procedure TOldStepPhase.Clear_Step_Array;
var
  i:integer;
begin
  for I := 0 to Step_Array_Count-1 do
     if Assigned(Step_Array[i]) then
          FreeAndNil(Step_Array[i]);
  Step_Array_Count:=0;
  setlength(Step_Array,0);
end;

constructor TOldStepPhase.Create;
begin
    Used:=true;
    StepCount:=0;
    Ex_Sup_inv:=5;
    Statistical_data:=TPhaseRecord.Create;
end;

procedure TOldStepPhase.Cut_contour_AGVData;
var
 st,ed:integer;
 i,j_t_0,j_t,max_i,Min_i:integer;
 Max_dao,Min_dao,changeFx:integer;
 ROrD:Boolean;
 Max_Value,Min_Value:Double;
 DXL,pro_data:double;
 Max_A,Min_A,Inv_A:double;
 ULD,DLD:double;  // 显现的值 与 内部的值
 ULSt,ULEd,UCount,DCount:integer;
 t_AGVData,StepLine:Double;
 tmStas:TPhaseRecord;
begin
   // 清空上次填充的类
   Clear_Step_Array;
   if PhaseAGV_Count<1 then  exit;

   t_AGVData:=0; Max_A:=0;Min_A:=1000;
   AGv_AGV_Data:=0;
   try
      tmStas:=TPhaseRecord.Create ;
      for I := 0 to High(PhaseAGV_EvenDao) do begin
         t_AGVData:=t_AGVData+PhaseAGV_EvenDao[i].AGVData;
         Max_A:=Max(Max_A,PhaseAGV_EvenDao[i].AGVData);
         Min_A:=Min(Min_A,PhaseAGV_EvenDao[i].AGVData);
         tmStas.insertData(PhaseAGV_EvenDao[i].AGVData);
      end;
      if PhaseAGV_Count>0 then
         t_AGVData:=t_AGVData/PhaseAGV_Count;
      if Max_A>Min_A then  Inv_A:=Max_A-Min_A
      else  Inv_A:=0;
      // 给资格线赋值
      if tmStas.Count >0 then begin
          ComeStepLine:=tmStas.Datas[Round(tmStas.Count*0.7)];
      end else begin
          ComeStepLine:=0;
      end;
      AGv_AGV_Data:=t_AGVData;
      StepLine:=ComeStepLine;
   finally
      FreeAndNil(tmStas);
   end;
    // 给临时变量付初值
    st:=0; Max_Dao:=-1;Min_Dao:=-1;
    Max_Value:=0;Min_Value:=1000;DXL:=0;
    changeFx:=0; ROrD:=true;
    j_t:=0;Max_i:=0; j_t_0:=0; Min_i:=0;
    st:=PhaseAGV_EvenDao[j_t].JinDao; inc(j_t);
    pro_data:=PhaseAGV_EvenDao[0].AGVData;
    while j_t<=High(PhaseAGV_EvenDao) do  begin
       Ed:=PhaseAGV_EvenDao[j_t].JinDao  ;
       DXL:=PhaseAGV_EvenDao[j_t].AGVData-pro_data;
       if (DXL>0) and (not ROrD ) then   begin// 下降趋势现在 上升
           inc(changeFx); ROrD:=true;
       end else if (DXL<0) and (ROrD) then  begin   //上升趋势 现在下降
           inc(changeFx); ROrD:=False;
       end;

       if (Max_Value < PhaseAGV_EvenDao[j_t-1].AGVData) and (DXL<0) and  (changeFx>0 ) and (j_t>0)
           and (PhaseAGV_EvenDao[j_t-1].AGVData > StepLine )then  begin
           // 比最大值 大 数据下降 回转了一次  最大值为前一个数据  进刀为前一次进刀
           Max_Value:=PhaseAGV_EvenDao[j_t-1].AGVData ;
           Max_Dao:= PhaseAGV_EvenDao[j_t-1].JinDao;
           Max_i:=j_t-1;
       end;

       if (Max_Value>0) and (Max_Value > StepLine ) and (DXL >0 ) and (changeFx >1) and(j_t>0)
          and (pro_data <t_AGVData  ) and (Min_Value> Pro_Data) then begin
          // 记录了最大值 最大值大于均值 现在是上升 回转了两次  am一个数值小于 均值 记录最小值
           Min_Value:=PhaseAGV_EvenDao[j_t-1].AGVData ;
           Min_Dao:= PhaseAGV_EvenDao[j_t-1].JinDao;
           Min_i:=J_t-1;
       end;

       if (Max_Dao>0) and (Min_Dao>0) and (PhaseAGV_EvenDao[j_t].AGVData>StepLine ) and
           (Min_Dao-st >=5 )  then begin
          // 如果找到了最大值 找到了最小值  找了了下一个大于均值的值
          // 增加一个小区间
          ULD:=0;DLD:=0;  UCount:=0;DCount:=0; ULSt:=-1;ULEd:=-1;
          for I := j_t_0 to Min_i do  begin
             if PhaseAGV_EvenDao[i].AGVData > StepLine then   begin
                ULD:=ULD+PhaseAGV_EvenDao[i].AGVData;
                inc(UCount);
                if (i<=Max_i) and (ULSt<0) and (ULEd<0 ) then
                   ULSt:=i;
             end else if PhaseAGV_EvenDao[i].AGVData < t_AGVData then   begin
                DLD:=DLD+PhaseAGV_EvenDao[i].AGVData;
                inc(DCount);
                if (i> Max_i) and (ULSt>=0) and (ULEd<0 ) then
                   ULEd:=i;
             end;
          end;
          //
          if UCount>0  then   ULD:=ULD/UCount;
          if DCount>0  then   DLD:=DLD/DCount;
          if ULEd<0 then   ULEd:= Min_i;
          if ULSt<0 then   ULSt:= j_t_0;


          {st_id 区间开始的内码编号      Ed_id, 区间结束的内码编号      St_dao, 区间开始的刀数
           Ed_dao, 区间结束的进刀数      Max_v,  区间最大值进刀         Min_V   区间最小值 进刀
           UpperLD  超过均值的得数 的平均值      DownLD:   低于 均值的数的 平均均
           ULSt  超过 均值的开始编号       ULEd  超过均值结束的编号}
          ADD_Step_Array(j_t_0,Min_i,st,Min_Dao,Max_Dao,Min_Dao,ULD,DLD,ULSt,ULEd);
          st:= Min_Dao+1;
          Max_Dao:=-1;Min_Dao:=-1;
          Max_Value:=0;Min_Value:=1000;DXL:=0;
          pro_data:=0; changeFx:=0; ROrD:=true;
          j_t:=Min_i;
          j_t_0:=Min_i+1;
       end;
       pro_data:=PhaseAGV_EvenDao[j_t].AGVData ;
       j_t:=j_t+1;
    end;
end;

destructor TOldStepPhase.Destroy;
begin
   Clear_AddPhaseGAv;
   Clear_Step_Array;

   if Assigned( Statistical_data) then
      FreeAndNil( Statistical_data);
end;

function TOldStepPhase.ForcaseStep(Number,ModifyData: integer): integer;
var
  K1:TArrayDouble;
  m,j,t,C1:integer;
  Str_Step:string;
  Move_Dao,St_Sup,End_Sup,Max_Obvious_Dao:double;
  s1:Str_DT_array;
  Stp_Con,Main_id,tmp_id:integer;
begin
     Result:=-1;
     if StepCount <2  then  exit;
     Str_Step:=GetEfficientSteps(ModifyData,Stp_Con);
     S1:=public_Basic.split(Str_Step,',',C1);
     if Stp_Con=C1-1 then Stp_Con:=Stp_Con-1;
     K1:=ReturnK(Stp_Con);
     t:=4;
     Main_id:=Public_Basic.StrToInt_lu(s1[0]);

     if Main_id< 1 then   exit;
     //付初值
     if Steps[Main_id].Step_Move_AGV_Footage <=0 then   begin
         Steps[Main_id].Step_Move_AGV_Footage:=0;
         Steps[Main_id].Step_Obvious_Footage[2]:=0;
         Steps[Main_id].Step_Continue_Footage:=0;
         Steps[Main_id].AreaQD :=0;
         Steps[Main_id].AGVDataQD:=0;
         Move_Dao:=0;
         Max_Obvious_Dao:=0;
         St_Sup:=0;
         end_Sup:=0;
     end else begin
         if Steps[Main_id].Step_move_AGVDao<=0 then  begin
            Move_Dao:=Steps[Main_id].Step_Move_AGV_Footage /0.8;
         end else begin
            Move_Dao:=Steps[Main_id].Step_move_AGVDao;
         end;
         if Steps[Main_id].Step_MaxWide_Dao<=0 then  begin
            Max_Obvious_Dao:=Steps[Main_id].EndDao-Steps[Main_id].StartDao+1 ;
         end else begin
            Max_Obvious_Dao:=Steps[Main_id].Step_MaxWide_Dao ;
         end;
         Max_Obvious_Dao:=0;
         St_Sup:=Steps[Main_id].StartSup;
         end_Sup:=Steps[Main_id].EndSup;
     end;


     for m := 1 to High(s1) do  begin
         tmp_id:=Public_Basic.StrToInt_lu(s1[m]);
        //平均运动步距
         Steps[Main_id].Step_Move_AGV_Footage := Steps[Main_id].Step_Move_AGV_Footage+
              steps[tmp_id].Step_Move_AGV_Footage * k1[t];
         //显著运动步距
         Steps[Main_id].Step_Obvious_Footage[2] :=Steps[Main_id].Step_Obvious_Footage[2]+
              steps[tmp_id].Step_Obvious_Footage[2] * k1[t];
         //持续运动步距
         Steps[Main_id].Step_Continue_Footage:= Steps[Main_id].Step_Move_AGV_Footage-
                      steps[tmp_id].Step_Obvious_Footage[2];
         // 面积强度
          Steps[Main_id].AreaQD := Steps[Main_id].AreaQD+steps[tmp_id].AreaQD * k1[t];

         // 均值强度
          Steps[Main_id].AGVDataQD := Steps[Main_id].AGVDataQD+ steps[tmp_id].AGVDataQD * k1[t];

          // 可能的进刀数
          Move_Dao:=Move_Dao+ steps[tmp_id].Step_move_AGVDao * k1[t];
          //显著运动刀数
          Max_Obvious_Dao:=Max_Obvious_Dao+ steps[tmp_id].Step_MaxWide_Dao*k1[t];
          //支架开始编号
          St_Sup:= St_Sup+steps[tmp_id].StartSup * k1[t];
          //支架结束编号
          end_Sup:= end_Sup+steps[tmp_id].EndSup * k1[t];

         t:=t-1;
         if t<0  then  break;

     end;
       // 整体强度
       Steps[Main_id].WholeQD :=  Steps[Main_id].AreaQD* Steps[Main_id].AGVDataQD ;
       Steps[Main_id].Step_move_AGVDao :=Round(Move_Dao);
       Steps[Main_id].Step_MaxWide_Dao :=Round(Max_Obvious_Dao);


      //增加一个区域
      AddOneStep(Steps[Main_id]);
      Steps[StepCount-1].ModifyData :=3*ModifyData; //代表 是预测的值
      if end_Sup> EndSupBh then          Steps[StepCount-1].EndSup :=EndSupBh
       else    Steps[StepCount-1].EndSup :=Round(end_Sup);
      if St_Sup> EndSupBh  then      Steps[StepCount-1].StartSup :=StartsupBh
       else    Steps[StepCount-1].StartSup :=Round(St_Sup);

      if Steps[StepCount-1].StartDao+Steps[StepCount-1].Step_move_AGVDao < EndDao then  begin
         Steps[StepCount-1].StartDao:=   EndDao +1;
      end else begin
         Steps[StepCount-1].StartDao:= Steps[StepCount-1].StartDao+Steps[StepCount-1].Step_move_AGVDao;
      end;

      Steps[StepCount-1].EndDao:= Steps[StepCount-1].StartDao+Steps[StepCount-1].Step_MaxWide_Dao;
      Steps[StepCount-1].Step_Move_AGV_Footage:=0;

      Result:= StepCount-1;


end;

function TOldStepPhase.GetComeStepCount(ModifyData: Integer): Integer;
var
  s_C,i:integer;
begin
    s_C:=0;
     for I := 0 to length(Steps)-1 do
        if Steps[i].ModifyData= ModifyData then  begin
          if (Steps[i].EndDao>steps[i].StartDao ) and
              (Steps[i].EndSup>Steps[i].StartSup ) then
                   inc(S_c);
        end;
   Result:=s_c;

end;

function TOldStepPhase.GetComeStepsInfo(ModifyData: Integer; var AGVDao,
  AGVChi: double): Boolean;
var
  s_C,i:integer;
begin
    s_C:=0; AGVDao:=0;AGVchi:=0;
      for I := 0 to length(Steps)-1 do
        if Steps[i].ModifyData= ModifyData then  begin
          if (Steps[i].EndDao>steps[i].StartDao ) and
              (Steps[i].EndSup>Steps[i].StartSup ) then begin
                 inc(S_c);
                 AGVDao:=AGVDao+Steps[i].EndDao-Steps[i].StartDao;
                 AGVchi:=AGVchi+Steps[i].End_AGVFootage -Steps[i].Start_AGVFootage;
                 inc(s_C);
              end;

        end;

    if s_C>0 then begin
       AGVDao:=AGVDao/ s_C;
       AGVchi:=AGVchi/S_c;
    end;
    Result:=true;

end;

function TOldStepPhase.GetEfficientSteps(ModifyData: integer;Var Stp_Con:integer): string;
var
  i:integer;
  Str_Count:string;
begin
    Str_Count:='';
    for I := StepCount-1 downto 0 do
         if ((Steps[i].ModifyData=ModifyData) or (Steps[i].ModifyData=ModifyData*3)  ) and
            (Steps[i].Step_Move_AGV_Footage =0 ) then begin
            Str_Count:=intToStr(i)+',';
            break;
         end;
    Stp_Con:=0;
    for I := StepCount-1 downto 0 do
         if((Steps[i].ModifyData=ModifyData) or (Steps[i].ModifyData=ModifyData*3)  ) and
            (Steps[i].Step_Move_AGV_Footage >0 ) then begin
            Str_Count:=Str_Count+intToStr(i)+',';
            inc(Stp_Con);
         end;


    REsult:=Str_Count;

end;

procedure TOldStepPhase.InsertDataIntoPhaseRecord;
var
  i,j:integer;
begin
   for I := 0 to Step_Array_Count-1 do  begin
       for j := Step_Array[i].Startid to Step_Array[i].Endid  do
           Step_Array[i].insertData(PhaseAGV_EvenDao[j].AGVData);

       Step_Array[i].Caluate;
   end;


end;

function TOldStepPhase.ReturnK(Number: integer): TArrayDouble;
var
  K1:TArrayDouble;
begin
   setlength(k1,5);
   if Number >=5 then    begin
      K1[0]:=0.05;K1[1]:=0.1;K1[2]:=0.2; K1[3]:=0.3;K1[4]:=0.35 ;
   end else if Number = 4 then    begin
      K1[0]:=0;K1[1]:=0.1;K1[2]:=0.2; K1[3]:=0.3;K1[4]:=0.4 ;
   end else if Number = 3 then    begin
      K1[0]:=0;K1[1]:=0;K1[2]:=0.2; K1[3]:=0.3;K1[4]:=0.5 ;
   end else if Number = 2 then    begin
      K1[0]:=0;K1[1]:=0;K1[2]:=0; K1[3]:=0.35;K1[4]:=0.65 ;
   end else if Number = 1 then    begin
      K1[0]:=0;K1[1]:=0;K1[2]:=0; K1[3]:=0;K1[4]:=1 ;
   end else  begin
      K1[0]:=0;K1[1]:=0;K1[2]:=0; K1[3]:=0;K1[4]:=0 ;
   end;


   Result:=K1;
end;

function TOldStepPhase.returnSupportList: String;
var
  i,inv,S_c,SupStar:integer;
  istr:string;
begin
    S_c:=0;
    inv:=(EndSupBh-StartsupBh) div 12;
    istr:='';
    if StartsupBh mod Ex_Sup_inv =0 then   begin
       SupStar:=   StartsupBh;
    end else  begin
       SupStar:=trunc(StartsupBh/Ex_Sup_inv) * Ex_Sup_inv + Ex_Sup_inv;
    end;
    i:=SupStar;
    while i <= EndSupBh do begin
        istr:=istr+ IntTostr(i)+',';
        inc(S_c);
        i:=i+ Ex_Sup_inv;
        if S_C > 12 then  break;
    end;

    if S_C< 12 then   begin
       i:=SupStar+2;
        while i <= EndSupBh do begin
            istr:=istr+  IntTostr(i)+',';
            inc(S_c);
            i:=i+ Ex_Sup_inv;
            if S_C > 12 then  break;
        end;
    end;

    if S_C< 12 then   begin
       i:=SupStar+4;
        while i <= EndSupBh do begin
            istr:=istr+ IntTostr(i)+',';
            inc(S_c);
            i:=i+ Ex_Sup_inv;
            if S_C > 12 then  break;
        end;
    end;

   if length(istr) >1  then  begin
      istr:=copy(istr,0,length(istr)-1);
   end else begin
      istr:='';
   end;
   Result:= istr;
end;

procedure TOldStepPhase.SetEndDao(Value: integer);
begin
   EndDao:=Value;
end;

procedure TOldStepPhase.SetEndJinChi(Value: double);
begin
   EndJinChi:=Value;
end;

procedure TOldStepPhase.SetStartDAo(Value: integer);
begin
   StartDao:=Value;
end;

procedure TOldStepPhase.SetSupportInval_ExUsed(Value: Integer);
begin
    Ex_Sup_inv:=Value;
end;

procedure TOldStepPhase.WithTwoStepFillPrevStepInfo(Currid: integer);
var
  prev:integer;
begin
    if Currid < 1 then  exit;
    if Currid >=StepCount then  exit;

    Prev:=Currid-1;
    steps[Prev].Step_end_MAXDao :=steps[Currid].Start_maxDao ; // 步距结束的最大进刀
    steps[Prev].Step_end_MinDao :=steps[Currid].Start_MinDao ; // 步距结束的最小进刀
    steps[Prev].Step_end_MaxFootage := steps[Currid].start_maxFootage ;   // 本次运动的最大进尺
    steps[Prev].Step_end_MinFootage := steps[Currid].start_minFootage ;  //本次运动的最小进尺
     // 本次运动的最大运动步距
    steps[Prev].Step_Move_MaxFootage  :=  steps[Prev].Step_end_MaxFootage - steps[Prev].start_minFootage  ;
    //  本次运动的最小运动步距
    steps[Prev].step_Move_MinFootage  :=  steps[Prev].Step_end_MinFootage - steps[Prev].start_maxFootage  ;
    //  本次运动的平均运动步距
    steps[Prev].Step_Move_AGV_Footage  := ( steps[Prev].step_Move_MinFootage + steps[Prev].Step_Move_MaxFootage)/2 ;
    // 本次运动的平均进刀数
    steps[Prev].Step_move_AGVDao :=Round( (steps[Prev].Step_end_MAXDao +steps[Prev].Step_end_MinDao
                            - steps[Prev].Start_maxDao - steps[Prev].Start_MinDao)/2 );
    {持续步距  平均运动步距减去 显著运动步距的平均值}
    steps[Prev].Step_Continue_Footage :=steps[Prev].Step_MOVE_AGV_Footage -steps[Prev].Step_Obvious_Footage[2];

end;

procedure TOldStepPhase.WithTwoStepFillPrevStepInfo_Copy(var Prv_step,
  Next_Step: TcomprehensiveOldStep);
begin
    // 进刀结束的最大值
    prv_Step.Step_end_MAXDao :=Next_Step.Start_maxDao;
    // 进刀结束最大值的 支架编号
    prv_step.Step_end_MaxDao_id :=Next_step.Start_MaxDao_id ;
    //进刀结束的最小值
    prv_Step.Step_end_MinDao  :=Next_Step.Start_MinDao;
    // 进刀结束最小值的 支架编号
    prv_step.Step_MinWide_Dao_id :=Next_step.Step_MinWide_Dao_id ;
     // 本次运动结束的最大进尺
    prv_Step.Step_end_MaxFootage :=Next_Step.start_maxFootage;
     // 本次运动结束的最小进尺
    prv_Step.Step_end_MinFootage :=Next_Step.start_minFootage;
    // 本次运动的最大运动步距
    prv_Step.Step_Move_MaxFootage  :=Prv_step.Step_end_MaxFootage -Prv_step.start_minFootage ;
    if prv_Step.Step_Move_MaxFootage  <0 then  begin
       prv_Step.Step_Move_MaxFootage:=0;
    end;

     //  本次运动的最小运动步距
    prv_Step.step_Move_MinFootage  :=Prv_step.Step_end_MinFootage -Prv_step.start_maxFootage ;
    //  本次运动的平均运动步距
    prv_Step.Step_Move_AGV_Footage :=(prv_step.Step_Move_MaxFootage +prv_Step.step_Move_MinFootage) /2;
    // 本次运动的平均进刀数
    prv_step.Step_move_AGVDao :=Round( (prv_step.Step_end_MAXDao +prv_step.Step_end_MinDao
                            - prv_step.Start_maxDao - prv_step.Start_MinDao)/2 );

    {持续步距  平均运动步距减去 显著运动步距的平均值}
    prv_Step.Step_Continue_Footage :=prv_step.Step_MOVE_AGV_Footage -prv_step.Step_Obvious_Footage[2];


end;

{ TPhaseRecord }



procedure TPhaseRecord.Caluate;
var
   i,k:integer;
   ZS:Array [0..100] of Integer;
   Max_Zs:integer;
   startid,Endid:integer;
begin
      {
      AGV_Data:=0;  // 平均数
        Standard_erro:=0;//  标准误差
        Median:=0;//  中位数
        Model:=0;//   众数
        Standard_Deviation:=0;// 标准差
        Variance:=0;// 方差
        peakedness:=0;// 峰度
        bs:=0;// 偏度
        Quyu:=0;// 区域
        MinData:=0;// 最小值
        MaxData:=0;//  最大值


      }

    if Count < 2  then  exit;

    // 计算 均值
    for I := 0 to Count-1 do
        AGV_Data:=AGV_Data+Datas[i];



    AGV_Data:=AGV_Data/Count;
    // 最小值
    MinData:=Datas[0];
    MaxData:=DataS[Count-1];
    Quyu:=MaxData-MinData;
    Median:=Datas[Count div 2];

    //计算 方差
    for I := 0 to Count-1 do
     Variance:=Variance+sqr(Datas[i]- AGV_Data);
     // 方差
     if Count>30  then  begin
        Variance:=Variance/Count;
     end else begin
        Variance:=Variance/(Count-1);
     end;
    // 标准差
    Standard_Deviation:=sqrt(Variance);
    //标准误差
    Standard_erro:= Variance/sqrt(Count);
    // 峰度 与 偏度
    for I := 0 to Count-1 do begin
        peakedness:=peakedness+sqr(sqr(Datas[i]- AGV_Data));
        bs:=bs+sqr(Datas[i]- AGV_Data)*(Datas[i]- AGV_Data);
    end;

    peakedness:=peakedness/(count-1)/sqr(sqr(Standard_Deviation ) );
    bs:= bs/ (count-1)/sqr(Standard_Deviation )/Standard_Deviation;
    //众数
    for I := 0 to High(zs) do
        ZS[i]:=0;
    for I := 0 to count-1 do  begin
        if DatAS[I]>98 then  DatAS[I] :=DatAS[I] /10;
        INC(Zs[Round(DatAS[I])]);
    end;

    Max_Zs:=0;
    for I := 0 to High(zs) do
       if Max_Zs< Zs[i] then begin
          Max_Zs:=  Zs[i];
          Model:=i;
       end;
   // 置信区间 95 %
   ZXQD95:=1; Startid:=0;Endid:=Count-1;
    for I := 1 to  Round(AGV_Data ) do   begin
        for k := 0 to Count-1 do begin
           if AGV_Data-I < Datas[k] then   begin
              Startid:=k;
              break;
           end;
        end;

        for k := Count-1 downto 0 do begin
           if AGV_Data+I > Datas[k] then   begin
              Endid:=k;
              break;
           end;
        end;

        if (Endid-Startid +1)/ count > 0.95 then  begin
            ZXQD95:=i;
            break;
        end;

    end;
   
end;

procedure TPhaseRecord.Clear;
begin
  Count:=0;
  setlength(Datas,0);
  AGV_Data:=0;  // 平均数
  Standard_erro:=0;//  标准误差
  Median:=0;//  中位数
  Model:=0;//   众数
  Standard_Deviation:=0;// 标准差
  Variance:=0;// 方差
  peakedness:=0;// 峰度
  bs:=0;// 偏度
  Quyu:=0;// 区域
  MinData:=0;// 最小值
  MaxData:=0;//  最大值
end;

constructor TPhaseRecord.Create;
begin
    phase_DZXS:=0;;
    Whole_DZXS:=0;
end;

destructor TPhaseRecord.Destroy;
begin

end;

function TPhaseRecord.Get_AGV: Double;
begin
    Result:= AGV_Data;
end;

function TPhaseRecord.Get_bs: double;
begin
   Result:=bs;
end;


function TPhaseRecord.Get_Count: integer;
begin
  Result:=Count;
end;

function TPhaseRecord.Get_DownLineData: double;
begin
  Result:=DownLineData;
end;

function TPhaseRecord.Get_Endid: integer;
begin
  Result:=Endid;
end;

function TPhaseRecord.Get_EndULid: integer;
begin
    Result:=ULEn;
end;

function TPhaseRecord.Get_End_FG: Double;
begin
  Result:=EndFootage;
end;

function TPhaseRecord.Get_End_JinD: integer;
begin
  Result:=EndDao;
end;

function TPhaseRecord.Get_MaxValueid: integer;
begin
   Result:=MaxValueDao;
end;

function TPhaseRecord.Get_Max_Data: Double;
begin
   Result:=MaxData;
end;

function TPhaseRecord.Get_max_Min: double;
begin
   Result:=Quyu;
end;

function TPhaseRecord.Get_Median: Double;
begin
   Result:=Median;
end;

function TPhaseRecord.Get_Min_Data: Double;
begin
   Result:=MinData;
end;

function TPhaseRecord.Get_Model: double;
begin
   Result:=Model;
end;

function TPhaseRecord.Get_peakedness: double;
begin
   Result:=peakedness;
end;

function TPhaseRecord.Get_Standard_Deviation: Double;
begin
    Result:=Standard_Deviation;
end;

function TPhaseRecord.Get_Standard_erro: double;
begin
   Result:=Standard_erro;
end;

function TPhaseRecord.Get_Startid: integer;
begin
   Result:=Startid;
end;

function TPhaseRecord.Get_StartULid: integer;
begin
  Result:=ULSt;
end;

function TPhaseRecord.Get_Start_FG: Double;
begin
  Result:=StartFootage;
end;

function TPhaseRecord.Get_Start_JinD: integer;
begin
  Result:=StartDao;
end;

function TPhaseRecord.Get_ToTal: double;
begin
   Result:=Count*AGV_Data;
end;

function TPhaseRecord.Get_UpperLineData: Double;
begin
   Result:=UpperLineData ;
end;

function TPhaseRecord.Get_U_Ed_FG: Double;
begin
  Result:=UL_En_Footage;
end;

function TPhaseRecord.Get_U_Ed_JinD: integer;
begin
  Result:=UL_En_Dao;
end;

function TPhaseRecord.Get_U_st_FG: Double;
begin
   Result:=UL_St_Footage;
end;

function TPhaseRecord.Get_U_st_JinD: integer;
begin
  REsult:=UL_St_Dao;
end;

function TPhaseRecord.Get_Variance: Double;
begin
   Result:=Variance;
end;

function TPhaseRecord.Get_ZXQD95: integer;
begin
   Result:=ZXQD95;
end;

procedure TPhaseRecord.insertData(Value: double);
var
  i:integer;
begin

     for I := 0 to Count-1 do  begin
        if Value< Datas[i] then  begin
           inc(Count);
           Setlength(Datas,Count);
           RemoveDataFromID(i);
           Datas[i]:=Value;
           Break;
        end;

     end;

     if I>=count then  begin
        inc(Count);
        Setlength(Datas,Count);
        Datas[Count-1]:=Value;
     end;


end;

procedure TPhaseRecord.RemoveDataFromID(Id: Integer);
var
  i:integer;
begin
    for I := Count-1 downto id+1 do
       Datas[i]:=Datas[i-1];
end;

function TPhaseRecord.Return(Memo1: TMemo): Boolean;
begin
    Memo1.Clear ;
    Memo1.Lines.Add('本次压力显现信息如下：');
    Memo1.Lines.Add('本次进刀开始：'+ IntToStr(StartDao) +'刀');
    Memo1.Lines.Add('本次进刀结束：'+ IntToStr(EndDao) +'刀');
    Memo1.Lines.Add('统计数据平均值：'+ FormatFloat('0.00',AGV_Data) +'MPa');
    Memo1.Lines.Add('统计数据 方 差：'+ FormatFloat('0.00',Variance) );
    Memo1.Lines.Add('统计数据标准差：'+ FormatFloat('0.00',Standard_Deviation) );
    Memo1.Lines.Add('统计数据 众 数：'+ FormatFloat('0.00',Model) +'MPa' );
    Memo1.Lines.Add('统计数据中位数：'+ FormatFloat('0.00',Median)  +'MPa');
    Memo1.Lines.Add('统计数据 峰 度：'+ FormatFloat('0.00',peakedness) );
    Memo1.Lines.Add('统计数据 偏 度：'+ FormatFloat('0.00',bs) );
    Memo1.Lines.Add('统计数据 误 差：'+ FormatFloat('0.00',Standard_erro) );
    Memo1.Lines.Add('统计数据最小值：'+ FormatFloat('0.00',MinData) +'MPa' );
    Memo1.Lines.Add('统计数据最大值：'+ FormatFloat('0.00',MaxData)  +'MPa');
    Memo1.Lines.Add('统计数据观测数：'+ FormatFloat('0',Count) );
    Memo1.Lines.Add('置信度（95%）：'+ FormatFloat('0',ZXQD95) );
    Memo1.Lines.Add('====================' );
    Memo1.Lines.Add('显现区域动载系数：'+ FormatFloat('0.00', phase_DZXS));
    Memo1.Lines.Add('显现整体动载系数：'+ FormatFloat('0.00', Whole_DZXS) );
    if ZXQD95 <= 2* Standard_Deviation then begin
       Memo1.Lines.Add('本区域数据基本符合正态分布，数据聚合性能较好' );
    end else begin
       Memo1.Lines.Add('本区域数据聚合性能较差，注意数据的维护' );
    end;

end;

procedure TPhaseRecord.SetAGVData(phaseAGV, WholeAGV: Double);
begin
    phase_DZXS:=UpperLineData/phaseAGV;
    Whole_DZXS:=UpperLineData/WholeAGV;
end;

end.



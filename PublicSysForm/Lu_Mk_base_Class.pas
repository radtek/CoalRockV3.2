//<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
//<<      文件名：Lu_Mk_base_class.pas                          <<
//<<      卢国志使用的个人Delphi文件                            <<
//<<      该文件主要是作为煤矿Com组件使用的                     <<
//<<      创建日期：2011.8.12                                   <<
//<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

unit Lu_Mk_base_Class;

interface

uses
  Windows, SysUtils, Classes, Messages, Controls, Forms, StdCtrls, ExtCtrls,
  ComCtrls,math,IniFiles,Jpeg,Graphics,Dialogs,Lu_Public_BasicModual;

type 

 //定义岩石类,为 TRock
   TRock =class(Tobject)
   
    public
      R_Name  :WideString;    //岩石名称
      R_h     :double;        //岩石厚度
      R_kyqd  : double;       // 抗压强度
      R_klqd  : double;       // 抗拉强度
      R_fchd  :double;        // 分层厚度
      R_k_Rock: double;      // 岩石碎胀系数
      R_r      : double;     //  岩石容重
      PNG_Change:integer;   //岩层是否更换纹理
      R_kjqd :double;//抗剪强度
      R_MinH :double; //岩层最小厚度
      R_MaxH :double;  // 岩层最大厚度
      R_sffc :bool;//     是否分层
      R_sfhsc:bool;//     是否含水
      Tuli:TMemoryStream; //图例
      MCId:integer; //煤层的id编号
           end;

 //定义岩层类 TYc_Rcok
  TYc_Rock =class(TRock)

    public
      //外部传入变量
      Yc_No       :integer;    //岩层编号
      M_Kc_YandN  :bool;      // 是否是开采煤层
      L_qx_xiashan   :double ;    //倾斜方向裂断拱下山距离倾斜中心线的长度
      L_qx_shangshan   :double ;    //倾斜方向裂断拱上山距离倾斜中心线的长度
      L_Tj        :double;     //推进方向裂断拱边线距离采煤工作面的距离
      //内部计算变量
      Step0      :double;    //计算每一个岩层的初次来压步距
      step_i     : array [0..4] of double ; // 计算每一个岩层的1-4次周期来压步距 ，第0 次 为 稳定周期步距
      Sa : array [0..2] of double ;     //  记录顶板下沉量 0 为初始下沉 1为 见方下沉；0.95  2 为 稳定下沉  0.85


    public
       procedure Step_Rock(h,Rc,r:double);

                end;

  //定义岩梁类
   TYL_beam =class (Tobject)
      public
        Start_YC_No :  integer;    //
        End_Yc_NO   :  integer;    //
        Ztc_ms      :double;       //支托层的厚度
        Sdc_mc      :double;       //随动层的厚度
        Step_0_Compr    :  double;     //  考虑随动层
        Step_i_Compr    :  array[0..5] of double;     //    下标0 为 稳定步距，1-5 为第一次到第5次周期来压
        Step_0_Simple   :  double;     //  不考虑随动层
        step_i_simple   :  array[0..5] of double;     //   下标0 为 稳定步距，1-5 为第一次到第5次周期来压
     //   is_init         :  bool ; //记录是否被初始化
        end;

  //定义钻孔类 TZk
   TZk_bore =class(Tobject)
     public
            Zk_No       :integer;             // 钻孔编号
            Zk_Yc_Count :integer;            // 岩层层数
            Zk_name     : WideString;        // 钻孔名称
            Yc_Rock    :array of TYc_Rock;   // 岩层数组（动态数组，下标为岩层的层数）
          //  Beam_Def_count    :integer;      //钻孔内挠曲岩梁的个数
            Beam_Def  :array[0..4] of TYL_beam;   //钻孔内挠曲岩梁的动态数组
           // Beam_step_count   :integer;     //  钻孔内步距岩梁的个数
            Beam_step :array[0..4] of TYL_beam;  // 钻孔内步距梁的动态数组
            main_coal  :  integer;  // 该处为岩层数组的编号
            is_init    :bool  ;
            Zk_ldg_end_no:integer;//  // 该处为裂断拱岩层终止的 岩层数组编号
           // 20160830
            Mineid:integer;



        function Init(s_zk:wideString;out sEorr:Widestring):WordBool;
        function ReturnSa(zk:TZk_bore):wideString;  stdcall;
        function ReturnCxbj(zk:TZk_bore):wideString;  stdcall;
        function Return_ZkCs:widestring; stdcall;
        destructor Destroy ;override;
   end;

  //定义工作面类 TG_stope
  TG_stope =class

       public
        S_Name   :WideString;         //  1工作面名称
        S_No     :WideString;         // 2 工作面编号
        S_mc_name:WideString;         // 3 所在煤层名称
        S_Cg_h   :double;             // 4 工作面采高
        S_cmfs   :WideString;         // 5 采煤方式
        S_Fm_h   :double;             // 6 放煤高度
        S_qj     :double;             // 7 煤层倾角
        S_mcsd_h :double;             // 8 埋藏深度
        S_L_qx   :double;             // 9 工作面倾斜长
        S_Sx_zx  :double;             // 10 工作面走向长
        S_Jc_L   :double;             // 11 工作面累计进尺
        S_f_PS   :double;             // 12  煤体的普氏系数
        S_M_mcj  :double;             // 13  煤体的内摩擦角
        S_M_njl  :double;             // 14  煤体的内聚力
        S_Bsb    :double;             // 15  媒体的泊松比
        S_K_zcfz :double;             // 16  支承压力峰值系数
        S_Dblb   :Widestring;         // 17   工作面顶板类别
        ZCYL_sx  :array[0..3] of double; //18 支承压力的范围   0 工作面前方， 1 下方 2 后方  3 上方
        ZCYL_s0  :double;             // 19  内应力场的范围
        ZCYL_s1  :array[0..3] of double;//20 支承压力高峰的范围 0为工作面前方与后方，1为 工作面两侧
        Hg_ldg   :double;              // 21 支承压力裂断拱
        is_init  :bool ;               // 22
        mbcsnl_l :double;              //23 煤壁丧失支撑能力的距离
        Dz_yxfx     :integer;             // 24  1	水平推进   		2	仰斜推进  3	俯斜推进
        Dz_JYHD	   :integer;            // 25   1	薄基岩  	2	一般基岩   3	中厚基岩     	4	巨厚基岩
        Dz_DCGZ     :integer;            //26 	1	地质构造较少    	2	背斜轴部     3	向斜轴部   4	断层密集，但不影响推进   5	断层密集，影响推进  6	构造极其复杂
        Dz_WSFC	   :integer;            // 27   1	瓦斯含量较低   	2	低瓦斯，局部超限  3	高瓦斯
        Dz_TopWater :integer;            // 28  	1	顶板无水  	2	含水层距离顶板较远  	3	含水层距离顶板较近   4	曾发生透水事故   	5	其他
        Dz_BottomWater: Integer;          // 29 	1	底板无水源   2	底板有水源，较远  3	底板有水源，较近   4	曾发生底板突出事故    5	其他
        Dz_HeoStress	:integer;           //  30  1	基本无水平应力  2	水平应力小于垂直应力  3	水平应力与垂直应力相当  4	水平应力大于垂直应力1.5倍以上
        Dz_Kyxx       :Integer;          // 31  	1	矿压显现不明显   2	有矿压显现，不影响生产  3	矿压显现较剧烈，影响生  4	发生过顶板事故
        Dz_HangDaoSup :integer;          //32   	1	巷道基本不需要支护  	2	巷道简单锚网支护   3	巷道架棚支护，基本不变形  	4	巷道变形，底鼓，安全影响小  5	巷道急速变形，底鼓，严重影响安全
        CK_Upkc       :integer;          //33      上届开采情况     0 未采  1 以采
        CK_UpMz       :double;           //34       上届煤柱
        CK_downkc     :integer;          //35     下届开采       0 未采  1 以采
        CK_downmz     :double;          // 36    下届煤住
        S_DayStep_speed: double;       //  37  工作面日推进速度
        S_Sh_UP       :double;         //  38  工作面上边界采深
        S_Sh_Down     :double;         //  39  工作面下边界采深
        S_SX_qj       :double;         //  40  工作面推进方向倾角
        UP_Ckq        :Integer;         // 41 工作面上方是否存在采空区
        UP_CKQ_Kc_H   :double;         // 42 采空区的采高
        UP_CKQ_JuLI   :double;         //43 采空区距离该工作面的距离
        Mc_FdBs       :double;         //44 煤层的放大倍数）画覆岩运动时使用
        Ci_xs         :double;         // 45  周期来压步距计算系数
        yklh          :integer;        // 46是否能实施高效沿空留巷，0 不能 1 可以  2 需要处理顶板  3 需要处理底板 
        yklh_hpct_h   :double;         // 47  沿空留巷 巷旁充填的高度
        yklh_tc_lu_w:    double;          //  48 沿空留巷填充墙体的 录入 宽度
        yklh_tc_js_w:    double;          //  49 沿空留巷填充墙体的  计算 宽度
        S_AGV_MCH    :double;        //50 煤层平均厚度
        S_Mtyd       :Integer;         // 51煤体硬度,对应的是编号 1(0.8);2(0.8-1.5) 3(1.5-2.5) 4(2.5 以上)
        DZ_Zhqk      : integer;       // 52 支护情况 1  单体支护  2 综采支架
        S_CMFS_INteger: integer;     //53采煤方法  的数字表示 1_炮采 2_普采  3_综采(一次采全高) 4_放顶煤 5_分层开采(上分层) 6_分层开采(下分层)

         function Init(str:wideString;out sEorr:Widestring):WordBool;
         function Init_GZM_simple(str:wideString;out sEorr:Widestring):WordBool;
         function Init_GZM_Difficult(str:wideString;out sEorr:Widestring):WordBool;
         function Return_Zcyl(Version:WideString;JinChi:double;zk:Tzk_bore):Widestring;//返回采煤工作面的支撑压力

      end;

   //定义直接顶 类
    TImmediate_roof=class
      Public
          Start_No  :integer;   //    直接顶开始 岩层数组下标
          End_No    :integer;    //   直接顶结束 岩层数组下标
          Surplus_h :double;     //   分层后的剩余高度
          Immroof_M  :double;   //    直接顶的累积高度
          Immroof_C0  :double;   //   直接顶的初次来压步距
          is_init     :bool;      //  直接顶是否初始化
          Imm_leibie      :Integer;//  直接顶类别
          FDm_leibie      :Integer;//顶煤冒放性类别

        function Cal_Immediate_roof(S_gzm: TG_stope; s_zk: TZk_bore;safe_h:double;out sEorr:widestring) :wordbool;
                //计算直接顶函数：s_gzm工作面对象   s_zk钻孔对象  saft_h计算直接顶的安全余量  s——eorr报错字符串
        function Cal_beam(S_gzm: TG_stope; s_zk: TZk_bore;out sEorr:widestring):wordbool ;
                //计算岩梁的属性，把数据填充到钻孔类内。


        function init(s_gzm: TG_stope; s_zk: TZk_bore;safe_h:double;out sEorr:widestring):wordbool ;
        function Get_Parameter(zk:Tzk_bore;Version:widestring):wideString;  stdcall;
        function Get_YC_Png(zk:Tzk_bore;s_gzm: TG_stope;t_imm:Timmediate_roof;JinChi:double):wideString;  stdcall;



        end;

  //定义老顶类
  TOld_roof=class
      public
        YL_struc: integer;//标记老顶的结构， 1 为单岩梁，2 为多岩梁
        YL_start :integer;    //  老顶开始岩层
        yl_max_End : integer;  //老顶最大结束岩层
        YL_min_End   :integer;    //  老顶最小结束岩层
        YL_max_m     :double;     //  老顶最大高度
        YL_min_m     :double;     //  老顶最小高度
        YL_First_step     : array[0..2] of double;    //初次来压步距  0 为最大值，1为最小值，2为平均值
        YL_Zhouqi_step    : array[0..2] of double;    //周期来压步距  0 为最大值，1为最小值，2为平均值
        is_init      :bool;
        Old_leibie       :Integer; // 老顶类别
        diban_leobie     :Integer; //底板类别

       function init(s_gzm: TG_stope; s_zk: TZk_bore;t_imm:Timmediate_roof; out sEorr: WideString):wordbool ;
       function Get_Parameter(s_gzm: TG_stope;zk:Tzk_bore;t_imm:Timmediate_roof;Version:Widestring):WideString;
       function Return_C0(zk:Tzk_bore):wideString;  stdcall; //返回岩梁的初次来压步距
       function Return_ldg(zk:Tzk_bore;s_gzm: TG_stope;t_imm:Timmediate_roof;Gzmjc:double;Version:WideString):wideString;  stdcall; //返回裂断拱的边界

      end;
   // //定义支架类
  TZJ_Class=class
      public
         Zj_Name: WideString;    //支架的名称
         ZJ_Tu_Bianhao:widestring; //支架图例编号
         Zj_BianHao:WideString;  //支架的编号
         Zj_XingHao:WideString;   //支架的型号
         Zj_Lizhu_count: Integer;  //支架立柱数量
         Zj_toall_F:double;       //支架整架阻抗力
         zj_toall_P:double;       //支架支护强度
         Zj_suoliang:double;      //支架最大缩量
         Zj_Max_h:double;         //支架最大高度
         Zj_min_h:double;         //支架最小高度
         Zj_KongdingJU:double;    //支架控顶距
         Zj_zhongxinju:double;    //支架中心矩
         Zj_hlzyd:double;        //合力作用点
         Zj_hubang_h:double;      //支架护帮高度
         Zj_hubang_jishu:integer;  //支架护帮级数
         zj_hubang_F:double;     //支架护帮阻力
         zj_hubang_P:double;     //支架护帮强度
         Zj_JiSuan_suoliang: double;// 支架计算的缩量
         Zj_JiSuan_C0_F: array[0..2] of double;// 初次来压时支架计算的阻力  0 最大值 1 最小值 2 平均值
         Zj_JiSuan_C0_P: array[0..2] of double;// 初次来压时支架计算的支护强度  0 最大值 1 最小值 2 平均值
         Zj_JiSuan_Ci_F: array[0..2] of double;// 周期来压时支架计算的阻力  0 最大值 1 最小值 2 平均值
         Zj_JiSuan_Ci_P: array[0..2] of double;// 期来压时支架计算的支护强度  0 最大值 1 最小值 2 平均值
         Zj_Jisuan_SL: array[0..2] of double;// 支架计算的缩量  0 最大值 1 最小值 2 平均值
         Zj_JiSuan_hubang_H: array[0..5] of double;// 支架计算互帮高度   '(0)为剪切滑移面，(1)为内摩擦角计算,(2)为压杆计算,(3)为煤体自身能力 ,(4)支架工作阻力方式计算
         Zj_JiSuan_hubang_P: array[0..2] of double;// 支架计算互帮强度   0 最大值 1 最小值 2 平均值
         JG_jx:widestring;     //  架型结构
         JG_Dl:widestring;     //  顶梁结构
         JG_Dz:widestring;     // 底座结构
         JG_slg:widestring;     // 四连干结构
         JG_ty:widestring;     // 推移结构
         JG_Fm:widestring;     // 放煤结构
         JG_Wl:widestring;     // 尾梁结构
         JG_Qc:widestring;     // 前梁、尾梁侧护板
         JG_Ct:widestring;     // 侧推结构
         JG_Dt:widestring;     //底调结构
         JG_Ql:widestring;     //前梁结构
         ZJ_JianYi_Type:Widestring;  //支架的选择型号
         zhiJia_F_xs  :double; // 支架阻力修订系数
         zhijia_L_xs  :double; // 支架缩量修订系数
         zhijia_hb_Q_xs :double;// 支架护帮强度修订系数
         Zj_DBFD_xs:  array[1..9] of double;// 保存不同类别的 参数
         OcxPath:widestring; //Ocx路径
         Zj_imm_p:double; // 支架支撑直接顶的压强
         Zj_old_C0_p:array[0..2] of double;// 初次来压时支架计算的支护强度  0 最大值 1 最小值 2 平均值
         Zj_old_Ci_p:array[0..2] of double;// 周期来压时支架计算的支护强度  0 最大值 1 最小值 2 平均值
         Zj_Lz_Diameter:double; //立柱的直径



         function Init(str:wideString;out sEorr:Widestring):WordBool; //初始化支架
         function Cal_Sup_Para(gzm:TG_Stope;Zk:Tzk_bore;imm:TImmediate_roof;old:Told_roof):WideString; //计算支架参sh
         function DzXd_Cal_sup_para(gzm:TG_Stope;Zk:Tzk_bore;imm:TImmediate_roof;old:Told_roof):WideString; //  根据地质条件修订支架的基本参数
         function Return_zj_Para(Version:WideString):WideString;   //返回支架参数
         function SpliJG(str:widestring;out sEorr:widestring):WordBool; //拆分传入支架结构字符串
         function ReadZhijia_XS(gzm:TG_Stope;Zk:Tzk_bore;imm:TImmediate_roof;old:Told_roof):WideString; //计算支架参sh
         procedure Draw_zhiJia(Image:TImage;x1,y1,x2,y2,mc_h:double;lizhushu,jia_type:integer);// jia_type 1 综采  2 综放

  end;

   // //定义计算域显示的类别
  TCal_Show=class
      public
        Zomm_D: double; //1 图像显示比例
        model_l:integer; //  2 岩层显示的开始层数  0 全部  1  缓沉带下部  2 1-2 个岩梁
        model_start_yc: integer; // 3 模拟岩层开始的层数
        hcd_bl: double; //  4 缓沉带显示比例

        function DrawFyyd(Image_Out:TImage;JinChi,X_pan_move:double;Tuxing,disp_two_tu,disp_ylg:integer;NQ_step:String;gzm:TG_stope;Zk:Tzk_bore;ZhiJia:TZJ_Class;imm:TImmediate_roof;old:Told_roof):Integer;

        function DrawZcyl(Image:TImage;P1,P2:TPoint;zcyl:Str_Dt_array;bl:double;left_right:bool):WordBool;
        // 外部image  进尺   X 平移   图例   挠曲还是 步距
        function Draw_YLG(Image:TImage;L1,L2,R1,R2:TStringList):WordBool;// 画支撑压力平衡拱

       
  end;

 TMainClass_PStope= Class
    public
       t_Gzm:TG_Stope;     //工作面
       t_zk:Tzk_bore;     //钻孔
       t_imm_r:TImmediate_roof; //直接顶
       t_old:Told_roof;    //老顶
       t_ZhiJia:TZJ_Class;  //支架
       t_Cal_show:TCal_Show;

      function InitModel(GzmStr,ZkStr:String;Var sEorr:String):Boolean;
      function Get_Stope_info:string;
      procedure Set_Old_Step(MaxValue, MinValue, AGVVale: Double); safecall;
      function Get_Edit_ZkCS: WideString; safecall;

      constructor Create;
      destructor Destroy;override;
 End;

      //游离于类之外的函数

      //计算支撑压力
    function Cal_Zcyl(zk:Tzk_bore;imm:TImmediate_roof;gzm:TG_stope;old_r:Told_roof;out S_zcyl: wideString):wordbool;
    // 计算裂断拱的边界
    function Cal_Ldg(zk:Tzk_bore;gzm:TG_stope;imm:TImmediate_roof;old_r:Told_roof;gzmjc:double;out S_ldg:widestring):wordbool;
    //  覆岩运动规律导出
    function Return_Fyyd(gzm:TG_Stope;Zk:Tzk_bore;imm:TImmediate_roof;old:Told_roof):WideString;


 implementation

// uses uMainFun;



  //\\\\\\\\\\\\\\\\\\\\\\\


//----- 煤矿基本类的定义结束
//--------初始化工作面类
  function TG_stope.Init(str: WideString;out sEorr:Widestring):wordbool;
     var
           temp1,temp2 :Str_Dt_array;
           i,Count1,Count2:integer;
      begin
        Result:=true;

      try
            temp1:=Public_Basic.split(str,':',Count1);
          
            if UpperCase(temp1[0])='GZM' then begin
                self.Init_GZM_simple(str,sEorr);
            end else if UpperCase(temp1[0])='GZM_D' then begin
                self.Init_GZM_Difficult(str,sEorr);
            end else begin
               Result:=False;
               sEorr:='工作面报头GZM错误!';
               Public_Basic.My_WriteLog('Eorr:Init 工作面报头GZM错误!','[TG_stope]');
               exit;
            end;

      except
              Result:=False;
              sEorr:='数据格式有误/';
              Public_Basic.My_WriteLog('Eorr:Init 数据格式有误/!','[TG_stope]');
              exit;
       end;

   end;
   //---------------------------------------  初始化工作面类第二次复杂的

  function TG_stope.Init_GZM_difficult(str: WideString;out sEorr:Widestring):wordbool;
     var
           temp1,temp2 :Str_Dt_array;
           i,Count1,Count2:integer;
      begin
        Result:=true;

      try
           temp1:=Public_Basic.split(str,':',Count1);
           temp2:=Public_Basic.split(temp1[1],',',Count2);
           if count2<27 then
               begin
               Result:=False;
               sEorr:='请仔细检查文件!';
               Public_Basic.My_WriteLog('Eorr:Init_GZM_difficult count2<27','[TG_stope]');
               exit;
              end;
         for i :=low(temp2) to high(temp2) do
           begin
             if length(temp2[i])=0 then continue;
                  case i of
                     0: self.S_No        :=Trim(StringReplace(temp2[i],#13#10,'',[]));
                     1: self.S_Name      :=Trim(StringReplace(temp2[i],#13#10,'',[]));
                     2: self.S_Mc_name   :=Trim(StringReplace(temp2[i],#13#10,'',[]));
                     3: self.S_cg_h      :=Public_Basic.strTodouble_lu(temp2[i]);
                     4: self.S_cmfs      :=Trim(StringReplace(temp2[i],#13#10,'',[]));
                     5: self.S_DayStep_speed  :=Public_Basic.strTodouble_lu(temp2[i]);
                     6: self.S_qj        :=Public_Basic.strTodouble_lu(temp2[i]);
                     7: self.S_SX_qj     :=Public_Basic.strTodouble_lu(temp2[i]);
                     8: self.S_Sh_UP     :=Public_Basic.strTodouble_lu(temp2[i]);
                     9: self.S_Sh_Down   :=Public_Basic.strTodouble_lu(temp2[i]);
                     10: self.S_mcsd_h   :=Public_Basic.strTodouble_lu(temp2[i]);
                     11: self.S_L_qx     :=Public_Basic.strTodouble_lu(temp2[i]);
                     12: self.S_Sx_zx    :=Public_Basic.strTodouble_lu(temp2[i]);
                     13:
                        begin
                         self.S_f_PS     :=Public_Basic.strTodouble_lu(temp2[i]);
                         if S_f_PS<1.1 then  begin
                             self.S_M_mcj:=20;
                             self.S_Bsb:=0.35;
                             self.S_M_njl:=10;
                             self.S_K_zcfz:=1.7-0.1*(self.S_Cg_h-4);
                          end else if S_f_PS<2.1 then  begin
                             self.S_M_mcj:=24;
                             self.S_Bsb:=0.3;
                             self.S_M_njl:=23;
                             self.S_K_zcfz:=2.0-0.1*(self.S_Cg_h-4);
                         end else if S_f_PS<3.1 then  begin
                             self.S_M_mcj:=28;
                             self.S_Bsb:=0.25;
                             self.S_M_njl:=40;
                             self.S_K_zcfz:=2.3-0.1*(self.S_Cg_h-4);
                         end else begin
                             self.S_M_mcj:=32;
                             self.S_Bsb:=0.2;
                             self.S_M_njl:=60;
                             self.S_K_zcfz:=2.6-0.1*(self.S_Cg_h-4);

                         end;

                        end;
                     14: self.Dz_yxfx    :=strToInt(temp2[i]);
                     15: self.Dz_JYHD    :=strToInt(temp2[i]);
                     16: self.Dz_DCGZ    :=strToInt(temp2[i]);
                     17: self.Dz_WSFC    :=strToInt(temp2[i]);
                     18: self.Dz_TopWater     :=strToInt(temp2[i]);
                     19: self.Dz_BottomWater  :=strToInt(temp2[i]);
                     20: self.Dz_HeoStress    :=strToInt(temp2[i]);
                     21: self.Dz_Kyxx    :=strToInt(temp2[i]);
                     22: self.Dz_HangDaoSup   :=strToInt(temp2[i]);
                     23: self.CK_Upkc   :=strToInt(temp2[i]);
                     24: self.CK_UpMz   :=Public_Basic.strTodouble_lu(temp2[i]);
                     25: self.CK_downkc :=strToInt(temp2[i]);
                     26: self.CK_downmz :=Public_Basic.strTodouble_lu(temp2[i]);
                  end;
             end; //endfor
              temp1:=nil;temp2:=nil;
      except
              Result:=False;
              sEorr:='数据格式有误/';
              Public_Basic.My_WriteLog('Eorr:Init_GZM_difficult 数据格式有误/','[TG_stope]');
              exit;
       end;

         //-------------
         if S_cg_h=0 then    // 判断采煤高度
           begin
             Result:=False;
             sEorr:=sEorr+'采煤高度/';
            end else begin
               if S_cg_h<2 then begin
                    Mc_FdBs:=1.5;
                end else begin
                    Mc_FdBs:=1;
                end;
            end;

        if S_No='' then //判断工作面编号
           begin
             Result:=False;
             sEorr:=sEorr+'工作面编号/';
             end;
         if S_Mc_name='' then //判断煤层名称
           begin
             Result:=False;
             sEorr:=sEorr+'煤层/';
            end;
         if S_cmfs='' then  // 判断采煤方法
           begin
             Result:=False;
             sEorr:=sEorr+'采煤方式(综采/综放/普采)/';
           end;
         if S_l_qx=0 then    // 判断工作面的倾斜长度
           begin
             Result:=False;
             sEorr:=sEorr+'倾斜长度/';
           end;
         if S_sx_zx=0 then    // 判断工作面的倾斜长度
           begin
             Result:=False;
             sEorr:=sEorr+'推进长度/';
           end;
         if S_mcsd_h=0 then    // 判断工作面的埋藏深度
           begin
             Result:=False;
             sEorr:=sEorr+'埋藏深度!';
           end;
          if S_f_ps=0 then    // 判断煤体的普氏系数
           begin
             Result:=False;
             sEorr:=sEorr+'普氏系数!';
           end;
         if Result then 
             self.is_init:=True
   end;
   //---------------------------------------  初始化工作面类原来d

   function TG_stope.Init_GZM_Simple(str: WideString;out sEorr:Widestring):wordbool;
     var
           temp1,temp2 :Str_Dt_array;
           i,Count1,Count2:integer;
      begin
        Result:=true;

      try
            temp1:=Public_Basic.split(str,':',Count1);

            if UpperCase(temp1[0])<>'GZM' then
             begin
               Result:=False;
               sEorr:='工作面报头GZM错误!';
               Public_Basic.My_WriteLog('Eorr:Init_GZM_Simple 工作面报头GZM错误!','[TG_stope]');
               exit;
             end;

           temp2:=Public_Basic.split(temp1[1],',',Count2);
           if count2<17 then
               begin
               Result:=False;
               sEorr:='请仔细检查文件!';
               Public_Basic.My_WriteLog('Eorr:Init_GZM_Simple count2<17','[TG_stope]');
               exit;
              end;
         for i :=low(temp2) to high(temp2) do
           begin
             if length(temp2[i])=0 then continue;
                  case i of
                     0: S_No  :=Trim(temp2[i]);
                     1: S_Name:=Trim(temp2[i]);
                     2: S_Mc_name :=Trim(temp2[i]);
                     3: S_cg_h  :=Public_Basic.strTodouble_lu(temp2[i]);
                     4: S_cmfs  :=Trim(temp2[i]);
                     5: S_fm_h  :=Public_Basic.strTodouble_lu(temp2[i]);
                     6: S_qj    :=Public_Basic.strTodouble_lu(temp2[i]);
                     7: S_mcsd_h:=Public_Basic.strTodouble_lu(temp2[i]);
                     8: S_l_qx  :=Public_Basic.strTodouble_lu(temp2[i]);
                     9: S_sx_zx :=Public_Basic.strTodouble_lu(temp2[i]);
                     10: S_jc_l :=Public_Basic.strTodouble_lu(temp2[i]);
                     11: S_f_ps :=Public_Basic.strTodouble_lu(temp2[i]);
                     12: S_M_mcj:=Public_Basic.strTodouble_lu(temp2[i]);
                     13: S_M_njl:=Public_Basic.strTodouble_lu(temp2[i]);
                     14: S_Bsb  :=Public_Basic.strTodouble_lu(temp2[i]);
                     15: S_K_zcfz:=Public_Basic.strTodouble_lu(temp2[i]);
                     16: S_Dblb :=Trim(temp2[i]);
                  end;
             end; //endfor
              temp1:=nil;temp2:=nil;
         except
              Result:=False;
              sEorr:='数据格式有误/';
              Public_Basic.My_WriteLog('Eorr:Init_GZM_Simple 数据格式有误/','[TG_stope]');
              exit;
       end;

         //-------------
         if S_cg_h=0 then    // 判断采煤高度
           begin
            S_cg_h:=2.5;
            end;
        if S_No='' then //判断工作面编号
           begin
              S_No:='新工作面';
             end;
         if S_Mc_name='' then //判断煤层名称
           begin
             S_Mc_name:='1';
            end;
         if S_cmfs='' then  // 判断采煤方法
           begin
             S_cmfs:='2';
           end;
         if S_l_qx=0 then    // 判断工作面的倾斜长度
           begin
             S_l_qx:=180;
           end;
         if S_sx_zx=0 then    // 判断工作面的倾斜长度
           begin
             S_sx_zx:=1000;
           end;
         if S_mcsd_h=0 then    // 判断工作面的埋藏深度
           begin
             S_mcsd_h:=500;
           end;
          if S_f_ps=0 then    // 判断煤体的普氏系数
           begin
             S_f_ps:=1.5;
           end;
         if Result then 
             self.is_init:=True ;

         if S_f_PS<1.1 then  begin
             self.S_M_mcj:=20;
             self.S_Bsb:=0.35;
             self.S_M_njl:=10;
             self.S_K_zcfz:=1.7-0.1*(self.S_Cg_h-4);
         end else if S_f_PS<2.1 then  begin
             self.S_M_mcj:=24;
             self.S_Bsb:=0.3;
             self.S_M_njl:=23;
             self.S_K_zcfz:=2.0-0.1*(self.S_Cg_h-4);
         end else if S_f_PS<3.1 then  begin
             self.S_M_mcj:=28;
             self.S_Bsb:=0.25;
             self.S_M_njl:=40;
             self.S_K_zcfz:=2.3-0.1*(self.S_Cg_h-4);
         end else begin
             self.S_M_mcj:=32;
             self.S_Bsb:=0.2;
             self.S_M_njl:=60;
             self.S_K_zcfz:=2.6-0.1*(self.S_Cg_h-4);
         end;
   end;



 //--------初始化钻孔类
function Tzk_bore.Init(S_Zk: WideString; out sEorr: WideString):wordbool;
   var
       yc1,yc2,yc3,yc4 :Str_Dt_array;
       i,Count1,Count2,count3,count4:integer;
       Mc_count:integer;
   begin
        Result:=true;
        MC_count:=0;
       try

            yc1:=Public_Basic.split(S_zk,':',Count1);   //把Zk的标识符批出来
            if UpperCase(yc1[0])<>'ZK' then
             begin
               Result:=False;
               sEorr:='钻孔报头ZK错误!';
               Public_Basic.My_WriteLog('Eorr:Init 钻孔报头ZK错误!','[Tzk_bore]');
               exit;
             end;
             //----
             yc2:=Public_Basic.split(yc1[1],';',Count2);   //把钻孔基本信息与岩层信息批出来
             yc3:=Public_Basic.split(yc2[0],',',Count3);   //yc3[0]为钻孔编号，yc3[1]为钻孔含有岩层的层数

              self.Zk_No:=Public_Basic.StrToInt_lu(yc3[0]);       //  给钻孔编号赋值
              self.Zk_Yc_Count:=Public_Basic.StrToInt_lu(yc3[1]);  //  给岩层层数变量赋值
             //--- 核对岩层层数信息，用传入信息与实际岩石信息比对
//              if Count2-1<>zk_yc_count then
//                 begin
//                  Result:=False;
//                  sEorr:='岩层层数信息有误，请仔细查看!';
//                  exit;
//                 end;

            SetLength(self.Yc_Rock ,self.Zk_Yc_Count+2);  //重新定义钻孔含有的岩层层数
              // 创建岩层动态数组
             for i :=0 to Zk_Yc_Count do
             begin
              if Yc_Rock[i]=nil then
                  Yc_Rock[i]:=TYc_rock.Create;
             end;

            for i :=low(yc2)+1 to high(yc2) do
               begin
                  yc4:=Public_Basic.split(yc2[i],',',Count4);   //把岩层的基本属性批出来
                  if high(yc4)<6 then   continue;
                  if i>Zk_Yc_Count then   Zk_Yc_Count:=i;
                  if Yc_Rock[i-1]=nil then   Yc_Rock[i-1]:=TYc_rock.Create;
                    self.Yc_Rock[i-1].Yc_No  :=Public_Basic.StrToInt_lu(yc4[0]);
                    self.Yc_Rock[i-1].R_Name :=Trim(StringReplace(yc4[1],#13#10,'',[]));
                    self.Yc_Rock[i-1].R_h    :=Public_Basic.StrTodouble_lu(yc4[2]);
                    self.Yc_Rock[i-1].R_kyqd :=Public_Basic.StrTodouble_lu(yc4[3]);
                    self.Yc_Rock[i-1].R_klqd :=Public_Basic.StrTodouble_lu(yc4[4]);

                    if Public_Basic.strtoint_lu(yc4[6])=0 then  begin
                          self.Yc_Rock[i-1].R_fchd :=Public_Basic.StrTodouble_lu(yc4[2]);  //如果不分层，分层厚度为本岩层的厚度
                          self.Yc_Rock[i-1].R_sffc :=false;
                        end  else   begin
                          self.Yc_Rock[i-1].R_fchd :=Public_Basic.StrTodouble_lu(yc4[5]);
                           self.Yc_Rock[i-1].R_sffc:=true;
                        end;
                    if high(yc4)<7 then  continue;
                       self.Yc_Rock[i-1].R_k_Rock :=Public_Basic.StrTodouble_lu(yc4[7]);
                    if high(yc4)<8 then  continue;
                        self.Yc_Rock[i-1].R_r     :=Public_Basic.StrTodouble_lu(yc4[8]);
                    if high(yc4)<9 then  continue;
                    if Public_Basic.strtoint_lu(yc4[9])=0 then
                        begin
                          self.Yc_Rock[i-1].M_Kc_YandN := False;
                        end
                      else
                        begin
                           self.Yc_Rock[i-1].M_Kc_YandN := True;
                           inc(Mc_count);
                           self.main_coal:=i-1;
                        end;

                     //------数据判断
                       if Yc_Rock[i-1].R_h =0 then    // 判断岩层的厚度
                             begin
                                Yc_Rock[i-1].R_h:=2;
                             end;

                      if Yc_Rock[i-1].R_klqd  =0 then    // 判断岩层 抗拉强度
                             begin
                               Yc_Rock[i-1].R_klqd:=3;
                             end;
                       if Yc_Rock[i-1].R_kyqd =0 then    // 判断岩层 抗压强度
                             begin
                               Yc_Rock[i-1].R_kyqd:=30;
                             end;
                      if Yc_Rock[i-1].R_r  =0 then    // 判断岩层 容重
                             begin
                               Yc_Rock[i-1].R_r:=2.5;
                             end;
                      
                       //计算岩层的步距
                         self.Yc_Rock[i-1].Step_Rock(Yc_Rock[i-1].R_h,Yc_Rock[i-1].R_klqd ,Yc_Rock[i-1].R_r );
                      
                     yc4:=nil;
               end;   //for循环结束
         except
              Result:=False;
              sEorr:='数据格式错误，请仔细查看!';
              Public_Basic.My_WriteLog('Eorr:Init 数据格式错误，请仔细查看!','[Tzk_bore]');
         end;
          //  创建动态数组
          for I := 0 to 4 do
            begin

              if  self.beam_def[i] = nil then begin
                   self.Beam_Def[i]:=TYL_beam.Create;
                   self.Beam_Def[i].Start_YC_No:=0;
                   self.Beam_Def[i].End_Yc_NO :=0;
              end;
              if  self.beam_step[i]= nil then begin
                  self.Beam_step[i]:=TYL_beam.Create ;
                  self.Beam_step[i].Start_YC_No :=0;
                  self.Beam_step[i].End_Yc_NO:=0;
              end;
                 
             end;

          self.is_init :=True;   
   end;   //- 本函数结束标记，

  //
destructor TZk_bore.Destroy;
 var
  i:integer;
begin
    try
      for I :=0 to Zk_Yc_Count-1 do    FreeAndNil(Yc_Rock[i]); ;
      for I := 0 to 3 do   FreeAndNil(Beam_Def[i]);
      for I := 0 to 3 do   FreeAndNil(Beam_step[i]);
    except
      on e:exception do begin
         Public_Basic.My_WriteLog('Eorr:Destroy'+e.message,'[Tzk_bore]');
      end;

    end;
      inherited Destroy;
end;
//=======岩层步距计算模块
  procedure Tyc_Rock.Step_Rock(h: Double; Rc: Double; r: Double);
  var
    k:integer;
  begin
       if r=0 then
          r:=25 ;
        self.Step0:=sqrt(1000*2*h*rc/r);  // 第一次步距
         // 1-4 为4次周期步距  0 为稳定步距
         //NextStep(c,i,mc,ms,qs,rs,qj:double):double ;//c 上一次的步距，i第几次
          for k := 1 to 4 do
             begin
                if k=1 then   begin
                       step_i[k]:=Public_Basic.NextStep(Step0,0,0,R_h ,R_klqd,R_r,0);
                end  else  begin
                       step_i[k]:=Public_Basic.NextStep(step_i[k-1],k-1,0,R_h ,R_klqd,R_r,0);
                 end;
             end ;
           step_i[0]:=Step0*0.4;
     end;   //  Tyc_Rock.Step_Rock  函数结束

 //计算岩梁结构
function TImmediate_roof.Cal_beam(S_gzm: TG_stope; s_zk: TZk_bore;out sEorr:widestring):wordbool ;
  var
     i,j,k :integer;
     YL_h:double;
     m,q,c_i: array of double;
     mq : double;
begin
    //计算老顶开始的位置
     Result:=true;
    try
      if self.Surplus_h =0 then
        begin
           i:=self.End_No-1;
           YL_h:=s_zk.Yc_Rock[i].R_h;
        end
      else
        begin
           i:=self.End_No;
           Yl_h:=self.Surplus_h;
           s_zk.Yc_Rock[End_No].Step_Rock(Surplus_h,s_zk.Yc_Rock[End_No].R_klqd,s_zk.Yc_Rock[End_No].R_r);
       end;
    //初始化动态数组
    setlength(m,i+1);
    setlength(q,i+1);
    setlength(c_i,i+1);
    for j := 0 to i  do
      begin
        if j=i then
          begin
             m[j]:=Yl_h;
          end
        else
         begin
             m[j]:=s_zk.Yc_Rock[j].R_h ;
         end;

         q[j]:=s_zk.Yc_Rock[j].R_klqd;
         c_i[j]:=s_zk.Yc_Rock[j].Step0 ;
      end;
     // 判断挠曲的岩梁
       mq:=m[i]*m[i]*q[i];
       k:=0;
       s_zk.Beam_Def[k].Start_YC_No :=i;
       s_zk.Beam_Def[k].Ztc_ms :=m[i];
       s_zk.Beam_Def[k].Sdc_mc :=0;
       for j := i-1 downto 0   do
         begin
           if k>3  then break;
           if  mq < 1.15*1.15*1.15*1.15*m[j]*m[j]*q[j] then
               begin
                 s_zk.Beam_Def[k].End_Yc_NO :=j+1;
                 inc(k);
                 s_zk.Beam_Def[k].Sdc_mc :=0;
                 if k>4  then break;
                 s_zk.Beam_Def[k].Start_YC_No :=j;
                 s_zk.Beam_Def[k].Ztc_ms :=m[j];
                 mq :=m[j]*m[j]*q[j];
                end  else  begin
                  s_zk.Beam_Def[k].Sdc_mc:=s_zk.Beam_Def[k].Sdc_mc+m[j];
                  s_zk.Beam_Def[k].End_Yc_NO :=j;
               end; 
        end;// 挠曲的end

     //判断步距的岩梁
      mq:=c_i[i];
      k:=0;
       s_zk.Beam_step[k].Start_YC_No :=i;
       s_zk.Beam_step[k].Ztc_ms :=m[i];
       s_zk.Beam_step[k].Sdc_mc :=0;
       for j := i-1 downto 0   do
         begin
           if k>3  then break;
           if  mq < 1.15 *c_i[j] then
               begin
                 s_zk.Beam_step[k].End_Yc_NO :=j+1;
                 inc(k);
                 s_zk.Beam_step[k].Sdc_mc :=0;
                 if k>4  then break;
                 s_zk.Beam_step[k].Start_YC_No:=j;
                 s_zk.Beam_step[k].Ztc_ms :=m[j];
                 mq :=c_i[j];
               end
            else
               begin
                 s_zk.Beam_step[k].Sdc_mc:=s_zk.Beam_step[k].Sdc_mc+m[j];
                 s_zk.Beam_step[k].End_Yc_NO :=j;
               end;
        end;// 步距的end

         if s_zk.Beam_Def[0].End_Yc_NO =0 then   s_zk.Beam_Def[0].End_Yc_NO :=1;
         if s_zk.Beam_step[0].End_Yc_NO =0 then  s_zk.Beam_step[0].End_Yc_NO :=1;       //


       //计算各自岩梁的步距，存入类中
       for j := 0 to 4 do
         begin
           //计算beam_def岩梁的初次来压步距

           if s_zk.Beam_Def[j].Ztc_ms >0  then
              begin
                 //考虑随动层的算法
                 s_zk.Beam_Def[j].Step_0_Compr:=Public_Basic.Firststep(s_zk.Beam_Def[j].Sdc_mc ,
                               s_zk.Beam_Def[j].Ztc_ms ,s_zk.Yc_Rock[s_zk.Beam_Def[j].Start_YC_No].R_klqd,
                               s_zk.Yc_Rock[s_zk.Beam_Def[j].Start_YC_No].R_r,s_gzm.S_qj);
                 s_zk.Beam_Def[j].Step_i_Compr[0]:=0.4*s_zk.Beam_Def[j].Step_0_Compr;
                    for k := 1 to 5 do
                       begin
                          if k=1 then
                               begin
                               s_zk.Beam_Def[j].Step_i_Compr[k]:=Public_Basic.NextStep(s_zk.Beam_Def[j].Step_0_Compr,
                                           k-1,s_zk.Beam_Def[j].Sdc_mc ,s_zk.Beam_Def[j].Ztc_ms ,
                                           s_zk.Yc_Rock[s_zk.Beam_Def[j].Start_YC_No].R_klqd,
                                           s_zk.Yc_Rock[s_zk.Beam_Def[j].Start_YC_No].R_r,s_gzm.S_qj);
                               end
                           else
                                begin
                               s_zk.Beam_Def[j].Step_i_Compr[k]:=Public_Basic.NextStep(s_zk.Beam_Def[j].Step_i_Compr[k-1],k-1,
                                             s_zk.Beam_Def[j].Sdc_mc ,s_zk.Beam_Def[j].Ztc_ms ,
                                             s_zk.Yc_Rock[s_zk.Beam_Def[j].Start_YC_No].R_klqd,
                                             s_zk.Yc_Rock[s_zk.Beam_Def[j].Start_YC_No].R_r,s_gzm.S_qj);

                           end;
                       end;
                 //不考虑随动层算法
                 s_zk.Beam_Def[j].Step_0_Simple:=Public_Basic.Firststep(0 ,s_zk.Beam_Def[j].Ztc_ms ,
                                  s_zk.Yc_Rock[s_zk.Beam_Def[j].Start_YC_No].R_klqd,
                                  s_zk.Yc_Rock[s_zk.Beam_Def[j].Start_YC_No].R_r,s_gzm.S_qj);
                 s_zk.Beam_Def[j].Step_i_Simple[0]:=0.4*s_zk.Beam_Def[j].Step_0_Simple;
                    for k := 1 to 5 do
                       begin
                          if k=1 then
                               begin
                               s_zk.Beam_Def[j].Step_i_Simple[k]:=Public_Basic.NextStep(s_zk.Beam_Def[j].Step_0_Simple,k-1,0 ,
                                                 s_zk.Beam_Def[j].Ztc_ms ,s_zk.Yc_Rock[s_zk.Beam_Def[j].Start_YC_No].R_klqd,
                                                 s_zk.Yc_Rock[s_zk.Beam_Def[j].Start_YC_No].R_r,s_gzm.S_qj);
                               end
                           else
                                begin
                               s_zk.Beam_Def[j].Step_i_Simple[k]:=Public_Basic.NextStep(s_zk.Beam_Def[j].Step_i_Simple[k-1],
                                              k-1,0 ,s_zk.Beam_Def[j].Ztc_ms ,s_zk.Yc_Rock[s_zk.Beam_Def[j].Start_YC_No].R_klqd,
                                              s_zk.Yc_Rock[s_zk.Beam_Def[j].Start_YC_No].R_r,s_gzm.S_qj);

                           end;
                       end;
              end;
           //计算beam_step岩梁的初次来压步距
           if s_zk.Beam_step[j].Ztc_ms >0  then
              begin
                 //考虑随动层的算法
                 s_zk.Beam_step[j].Step_0_Compr:=Public_Basic.Firststep(s_zk.Beam_step[j].Sdc_mc ,s_zk.Beam_step[j].Ztc_ms ,
                                 s_zk.Yc_Rock[s_zk.Beam_step[j].Start_YC_No].R_klqd,
                                 s_zk.Yc_Rock[s_zk.Beam_step[j].Start_YC_No].R_r,s_gzm.S_qj);
                 s_zk.Beam_step[j].Step_i_Compr[0]:=0.4*s_zk.Beam_step[j].Step_0_Compr;
                    for k := 1 to 5 do
                       begin
                          if k=1 then
                               begin
                               s_zk.Beam_step[j].Step_i_Compr[k]:=Public_Basic.NextStep(s_zk.Beam_step[j].Step_0_Compr,k-1,
                                                  s_zk.Beam_step[j].Sdc_mc ,s_zk.Beam_step[j].Ztc_ms ,
                                                  s_zk.Yc_Rock[s_zk.Beam_step[j].Start_YC_No].R_klqd,
                                                  s_zk.Yc_Rock[s_zk.Beam_step[j].Start_YC_No].R_r,s_gzm.S_qj);
                               end
                           else
                                begin
                               s_zk.Beam_step[j].Step_i_Compr[k]:=Public_Basic.NextStep(s_zk.Beam_step[j].Step_i_Compr[k-1],k-1,
                                            s_zk.Beam_step[j].Sdc_mc ,s_zk.Beam_step[j].Ztc_ms ,
                                            s_zk.Yc_Rock[s_zk.Beam_step[j].Start_YC_No].R_klqd,
                                            s_zk.Yc_Rock[s_zk.Beam_step[j].Start_YC_No].R_r,s_gzm.S_qj);

                           end;
                       end;
                 //不考虑随动层算法
                 s_zk.Beam_step[j].Step_0_Simple:=Public_Basic.Firststep(0 ,s_zk.Beam_step[j].Ztc_ms ,
                                         s_zk.Yc_Rock[s_zk.Beam_step[j].Start_YC_No].R_klqd,
                                         s_zk.Yc_Rock[s_zk.Beam_step[j].Start_YC_No].R_r,s_gzm.S_qj);
                 s_zk.Beam_step[j].step_i_simple[0]:=0.4*s_zk.Beam_step[j].Step_0_Simple;
                    for k := 1 to 5 do
                       begin
                          if k=1 then
                               begin
                               s_zk.Beam_step[j].step_i_simple[k]:=Public_Basic.NextStep(s_zk.Beam_step[j].Step_0_Compr,
                                               k-1,s_zk.Beam_step[j].Sdc_mc ,s_zk.Beam_step[j].Ztc_ms ,
                                               s_zk.Yc_Rock[s_zk.Beam_step[j].Start_YC_No].R_klqd,
                                               s_zk.Yc_Rock[s_zk.Beam_step[j].Start_YC_No].R_r,s_gzm.S_qj);
                               end
                           else
                                begin
                               s_zk.Beam_step[j].step_i_simple[k]:=Public_Basic.NextStep(s_zk.Beam_step[j].Step_i_Compr[k-1],
                                               k-1,s_zk.Beam_step[j].Sdc_mc ,s_zk.Beam_step[j].Ztc_ms ,
                                               s_zk.Yc_Rock[s_zk.Beam_step[j].Start_YC_No].R_klqd,
                                               s_zk.Yc_Rock[s_zk.Beam_step[j].Start_YC_No].R_r,s_gzm.S_qj);

                           end;
                       end;   //end k
              end;  //end if  t_zk


         end;   //end for  j
    except
      on e:exception do begin
        Result:=False ;
        sEorr:='计算岩梁错误！';
        Public_Basic.My_WriteLog('Eorr:.Cal_beam_'+e.message,'[TImmediate_roof]');
      end;
   end;  //end try
  end;  //   TImmediate_roof.Cal_beam 结束的标记
  //计算直接顶
function TImmediate_roof.Cal_Immediate_roof(S_gzm: TG_stope; s_zk: TZk_bore;safe_h:double;out sEorr:widestring) :wordbool;
    //计算直接顶函数：s_gzm工作面对象   s_zk钻孔对象  saft_h计算直接顶的安全余量  s——eorr报错字符串
 var
        i,j:integer;
        SA:double;
        j_count:bool;
 begin
         i:=s_zk.main_coal-1;  // 记录煤层上方第一个岩层的数组下标
         self.Immroof_C0:=s_zk.Yc_Rock[i].Step0;//传入直接顶的第一次来压步距。
         SA:=s_gzm.S_Cg_h+s_gzm.S_Fm_h;   //计算初始下沉距离
         self.Immroof_M:=s_zk.Yc_Rock[s_zk.main_coal].R_h-Sa; //把顶煤的厚度加入
         Result:=true;
         self.Surplus_h :=0;
         //直接顶第一次处理
         if SA<s_zk.Yc_Rock[i].R_h then
             if s_zk.Yc_Rock[i].R_sffc then   begin
                s_zk.Yc_Rock[i].Step_Rock(s_zk.Yc_Rock[i].R_fchd,s_zk.Yc_Rock[i].R_klqd,s_zk.Yc_Rock[i].R_r  );
                self.Immroof_C0:=s_zk.Yc_Rock[i].Step0;// 修订直接顶第一次来压步距。
             end;

     try
         self.Start_No:=i;     // 初始化直接顶开始岩层数组下标
          while i>0 do
            begin
             //坚硬顶板强制性处理
             if (s_zk.Yc_Rock[i].Step0 >120) and (not s_zk.Yc_Rock[i].R_sffc)then
               begin
                  self.End_No:=i+1;
                  self.is_init:=true;
                 // sEorr:='start:'+FloatToStr(self.Start_No)+':end'+ FloatToStr(self.End_No)+':剩余'+FloatToStr(self.Surplus_h)+':层厚'+FloatToStr(self.Immroof_M);
                  exit;
               end;

             if SA>=s_zk.Yc_Rock[i].R_h  then    //下沉空间大于本岩层的高度
                  begin
                     self.Immroof_M:=self.Immroof_M+s_zk.Yc_Rock[i].R_h;  // 直接顶高度累加
                     SA:=SA-(s_zk.Yc_Rock[i].R_k_Rock-1)* s_zk.Yc_Rock[i].R_h;  // 岩层下沉空间迭代
                     dec(i);
                  end   else  begin     //  //下沉空间小于本岩层的高度
                      j:=0;
                      j_count:=true;
                      while J_count do      //分层循环
                        begin

                           if  s_zk.Yc_Rock[i].R_fchd =0 then  begin //防止死循环设置
                            
                              J_count:=False;
                              self.End_No:=i+1;
                              self.Surplus_h :=0;
                              i:=0;
                            end else if  s_zk.Yc_Rock[i].R_h>j*s_zk.Yc_Rock[i].R_fchd then   begin   //  岩层厚度大于分层的累计厚度
                                  if  SA>=S_zk.Yc_Rock[i].R_fchd - safe_h  then    begin   //   岩层的下沉空间大于本次分层厚度
                                     
                                           self.Immroof_M :=self.Immroof_M + S_zk.Yc_Rock[i].R_fchd;
                                           SA:=SA-(s_zk.Yc_Rock[i].R_k_Rock-1)* s_zk.Yc_Rock[i].R_fchd;
                                           inc(j);
                                   end  else  begin      //   岩层的下沉空间小于本次分层厚度  直接顶计算结束
                                         J_count:=False;
                                         if j=0  then begin
                                            self.End_No:=i+1;
                                            self.Surplus_h :=0;
                                            i:=0;
                                          end else begin
                                            self.End_No:=i;
                                            self.Surplus_h :=s_zk.Yc_Rock[i].R_h -s_zk.Yc_Rock[i].R_fchd*j;
                                            i:=0;
                                         end;

                                  end;  //end     if  SA>S_zk.Yc_Rock[i].R_fchd +safe_h
                            end  else  begin    //  岩层厚度小于分层的累计厚度
                                J_count:=False;
                                self.Immroof_M:=self.Immroof_M+(s_zk.Yc_Rock[i].R_h-(j)*s_zk.Yc_Rock[i].R_fchd );
                                SA:=SA-(s_zk.Yc_Rock[i].R_k_Rock-1)* (s_zk.Yc_Rock[i].R_h-(j)*s_zk.Yc_Rock[i].R_fchd );
                                dec(i);
                            end ;//end if  s_zk.Yc_Rock[i].R_h>j*s_zk.Yc_Rock[i].R_fchd

                       end; //end while J_count=True

                  end; //end if   SA>=s_zk.Yc_Rock[i-1].R_h

            end;//----end  while i>0

     except
         on e:exception do begin
           Result:=False;
           sEorr:='直接顶计算错误！';
           Public_Basic.My_WriteLog('Eorr:.Cal_Immediate_roof_'+e.message,'[TImmediate_roof]');
         end;
     end;  //end try
           //剩余墙柱判断
            if (Surplus_h>0) and (Surplus_h <1)   then Surplus_h:=0;
           //剩余厚度大于零，重新计算本岩层的初次来压步距
           if Surplus_h>0  then
              s_zk.Yc_Rock[End_No].Step_Rock(Surplus_h,s_zk.Yc_Rock[End_No].R_klqd ,s_zk.Yc_Rock[End_No].R_r );
            //计算每一层岩层的下沉空间
           s_zk.Yc_Rock[self.Start_No].Sa[0]:=S_gzm.S_Cg_h+s_gzm.S_Fm_h;
           s_zk.Yc_Rock[self.Start_No].Sa[1]:=S_gzm.S_Cg_h+s_gzm.S_Fm_h;
           s_zk.Yc_Rock[self.Start_No].Sa[2]:=S_gzm.S_Cg_h+s_gzm.S_Fm_h;

          for I := self.Start_No-1  downto 0 do
             begin
                 if i>=self.End_No-1  then  begin
                    s_zk.Yc_Rock[i].Sa[0]:= s_zk.Yc_Rock[i+1].Sa[0]-(s_zk.Yc_Rock[i+1].R_k_Rock-1)* s_zk.Yc_Rock[i+1].R_h;  // 岩层下沉空间迭代
                    s_zk.Yc_Rock[i].Sa[1]:= s_zk.Yc_Rock[i+1].Sa[1]-(s_zk.Yc_Rock[i+1].R_k_Rock*0.95-1)* s_zk.Yc_Rock[i+1].R_h;  // 岩层下沉空间迭代
                    s_zk.Yc_Rock[i].Sa[2]:= s_zk.Yc_Rock[i+1].Sa[2]-(s_zk.Yc_Rock[i+1].R_k_Rock*0.85-1)* s_zk.Yc_Rock[i+1].R_h;  // 岩层下沉空间迭代

                    if s_zk.Yc_Rock[i].Sa[0]<=0 then s_zk.Yc_Rock[i].Sa[0]:=0.5; // 直接顶
                    if s_zk.Yc_Rock[i].Sa[1]<=0 then s_zk.Yc_Rock[i].Sa[1]:=0.8; //  直接顶
                    if s_zk.Yc_Rock[i].Sa[2]<=0 then s_zk.Yc_Rock[i].Sa[2]:=1;  //直接顶
                  end else begin
                    s_zk.Yc_Rock[i].Sa[0]:= s_zk.Yc_Rock[i+1].Sa[0]; // 老顶
                    s_zk.Yc_Rock[i].Sa[1]:= s_zk.Yc_Rock[i+1].Sa[1]; // 老顶
                    s_zk.Yc_Rock[i].Sa[2]:= s_zk.Yc_Rock[i+1].Sa[2];  // 老顶

                 end;  //end ifi>=self
             end; //end for i
          // sEorr:='start:'+FloatToStr(self.Start_No)+':end'+ FloatToStr(self.End_No)+':剩余'+FloatToStr(self.Surplus_h)+':层厚'+FloatToStr(self.Immroof_M);
    end; // TImmediate_roof.Cal_Immediate_roof  函数结束
  //=================================================================
 //初始化岩梁的类
function TImmediate_roof.init(s_gzm: TG_stope; s_zk: TZk_bore;safe_h:double;out sEorr:widestring):wordbool ;
    begin
          //---判断类是否创建
       try
          self.is_init:=False;
          Result:=True;
          if s_gzm=nil  then
           begin
             sEorr:='没有初始化工作面参数!';
             Result:=False;
             Public_Basic.My_WriteLog('Eorr:.工作面类创建错误!','[TImmediate_roof]');
              exit;
           end;
         if s_zk=nil then
             begin
              sEorr:='没有初始化钻孔参数!';
              Result:=False;
              Public_Basic.My_WriteLog('Eorr:.钻孔类创建错误!','[TImmediate_roof]');
              exit;
             end;
         if not s_gzm.is_init then
            begin
             sEorr:='没有初始化工作面参数!';
              Result:=False;
              Public_Basic.My_WriteLog('Eorr:工作面类初始化错误!','[TImmediate_roof]');
              exit;
            end;
         if not s_zk.is_init then
            begin
              sEorr:='没有初始化工作面参数!';
              Result:=False;
              Public_Basic.My_WriteLog('Eorr:.钻孔类初始化错误!','[TImmediate_roof]');
              exit;
            end;
        //--------------计算放顶煤的参数
         if s_gzm.S_cmfs='4' then begin
            s_gzm.S_Fm_h:=s_zk.Yc_Rock[s_zk.main_coal].R_h-s_gzm.S_Cg_h;
         end;   
        //--------------
         if not self.Cal_Immediate_roof(s_gzm,s_zk,safe_h,sEorr) then     //计算直接顶
             begin
               Result:=False;
               Public_Basic.My_WriteLog('Eorr:.直接顶计算错误!','[TImmediate_roof]');
               exit;
             end;
           if not  self.Cal_beam(s_gzm,s_zk,sEorr) then     //计算岩梁的结构
             begin
               Result:=False;
               Public_Basic.My_WriteLog('Eorr:.岩梁判断错误!','[TImmediate_roof]');
               exit;
             end;
         //判断直接顶的类别
          if self.Immroof_C0<=4 then  begin
              self.Imm_leibie:=1;
          end else if self.Immroof_C0<=8 then  begin
              self.Imm_leibie:=2;
          end else if self.Immroof_C0<=18 then  begin
              self.Imm_leibie:=3;
          end else if self.Immroof_C0<=32 then  begin
              self.Imm_leibie:=4;
          end else begin
              self.Imm_leibie:=5;
          end;
        //判断顶煤冒放性
         if s_gzm.S_cmfs='4' then  begin
               if s_gzm.S_f_PS =1 then begin
                  self.FDm_leibie :=1;
               end else if ((s_gzm.S_f_PS =2) and (s_gzm.Dz_DCGZ >3)) then begin
                  self.FDm_leibie :=1;
               end else if ((s_gzm.S_f_PS =2) and (s_gzm.Dz_DCGZ <4)) then begin
                  self.FDm_leibie :=2;
               end else if ((s_gzm.S_f_PS =3) and (s_gzm.Dz_DCGZ >3)) then begin
                  self.FDm_leibie :=3;
               end else if ((s_gzm.S_f_PS =3) and (s_gzm.Dz_DCGZ <4)) then begin
                  self.FDm_leibie :=4;
               end else  begin
                 self.FDm_leibie :=5;
               end;
         end else begin
             self.FDm_leibie :=0;
         end;

       except
         on e:exception do begin
           Result:=False;
           sEorr:='数据格式错误！';
           Public_Basic.My_WriteLog('Eorr:.init_'+e.message,'[TImmediate_roof]');
         end;

        end;
         if Result then
            self.is_init:=true;
    end; // TYL_beam.init 函数结束
  //-初始化老顶的类
  function Told_roof.init(s_gzm: TG_stope; s_zk: TZk_bore;t_imm:Timmediate_roof; out sEorr: WideString) :wordbool;
    var
      i,j:integer;
      Dn,N:double ; //Dn :老顶来压强度；N 直接顶填充系数
   begin
       is_init:=true;

       if not t_imm.is_init  then
            begin
              sEorr:='没有初始化直接顶参数!';
              Result:=False;
              exit;
            end;
   //2016.5.5
     //判断基本顶的类型 即几类基本顶的问题
         //通过 Dn=L0-15.2N+42.9M 的方式判断
         //Dn的分类 1级  Dn<=80.5  2级 80.5~128.4   3级  128.4~188.3   4级   188.3  248   5级 250
         N:=t_imm.Immroof_M/s_gzm.S_Cg_h;
         Dn:=self.YL_First_step[0]-15*N+42.9*s_gzm.S_Cg_h;
         if Dn<=80.5  then begin
             self.Old_leibie :=1;
             s_gzm.Ci_xs:=0.4;
         end else if Dn<=128.4 then begin
             self.Old_leibie :=2;
             s_gzm.Ci_xs:=0.35;
         end else if Dn<=188.3 then begin
             self.Old_leibie :=3;
             s_gzm.Ci_xs:=0.3;
         end else if Dn<=248 then begin
             self.Old_leibie :=4;
             s_gzm.Ci_xs:=0.3;
         end else begin
             self.Old_leibie :=5;
             s_gzm.Ci_xs:=0.288;
         end;
         //重新计算岩层的周期步距
         for I := 0 to s_zk.Zk_Yc_Count-1 do begin
            s_zk.Yc_Rock[i].step_i[0]:=s_gzm.Ci_xs* s_zk.Yc_Rock[i].Step0;
         end;
          //重新计算岩梁的周期步距
          for I := 0 to 4 do   begin
            s_zk.Beam_Def[i].Step_i_Compr[0]:= s_zk.Beam_Def[i].Step_0_Compr*s_gzm.Ci_xs;
            s_zk.Beam_Def[i].step_i_simple[0]:= s_zk.Beam_Def[i].Step_0_Simple*s_gzm.Ci_xs;
            s_zk.Beam_step[i].Step_i_Compr[0]:= s_zk.Beam_step[i].Step_0_Compr*s_gzm.Ci_xs;
            s_zk.Beam_step[i].step_i_simple[0]:= s_zk.Beam_step[i].Step_0_Simple*s_gzm.Ci_xs;

          end;

     //============================================================================


   try
        //判断老顶下位岩梁
        self.YL_max_m:=0;
        self.YL_min_m:=0;
        j:=0;
        self.YL_start :=s_zk.Beam_Def[0].Start_YC_No ;
     for I := 0 to 4 do
         begin
             self.YL_start :=s_zk.Beam_Def[i].Start_YC_No ;
             if s_zk.Beam_Def[i].End_Yc_NO =s_zk.Beam_step[i].End_Yc_NO  then   //如果挠曲与与步距 结束岩层相同
                begin
                   self.YL_max_End := s_zk.Beam_Def[i].End_Yc_NO;
                   self.YL_min_End := s_zk.Beam_Def[i].End_Yc_NO;
                   self.YL_max_m :=self.YL_max_m +s_zk.Beam_Def[i].Ztc_ms+s_zk.Beam_Def[i].Sdc_mc;
                   self.YL_min_m :=self.YL_min_m +s_zk.Beam_Def[i].Ztc_ms+s_zk.Beam_Def[i].Sdc_mc;
                end  else  begin
                     if s_zk.Beam_Def[i].End_Yc_NO < s_zk.Beam_step[i].End_Yc_NO  then    // 如果挠曲 小于 与步距 结束岩层
                         begin
                             self.YL_max_End := s_zk.Beam_Def[i].End_Yc_NO;
                             self.YL_min_End := s_zk.Beam_step[i].End_Yc_NO;
                             self.YL_max_m :=self.YL_max_m + s_zk.Beam_Def[i].Ztc_ms+s_zk.Beam_Def[i].Sdc_mc;
                             self.YL_min_m :=self.YL_min_m + s_zk.Beam_step[i].Ztc_ms+s_zk.Beam_step[i].Sdc_mc;
                          end  else  begin                                    // 如果挠曲 大于 与步距 结束岩层相同
                             self.YL_max_End := s_zk.Beam_step[i].End_Yc_NO;
                             self.YL_min_End := s_zk.Beam_def[i].End_Yc_NO;
                             self.YL_min_m :=self.YL_min_m + s_zk.Beam_Def[i].Ztc_ms+s_zk.Beam_Def[i].Sdc_mc;
                             self.YL_max_m :=self.YL_max_m + s_zk.Beam_step[i].Ztc_ms+s_zk.Beam_step[i].Sdc_mc;
                         end;      //    if s_zk.Beam_Def[0].End_Yc_NO < s_zk.Beam_step[0].End_Yc_NO  then

                end;  //  if s_zk.Beam_Def[0].End_Yc_NO =s_zk.Beam_step[0].End_Yc_NO  then
                 if self.YL_min_m > s_gzm.S_Cg_h then   begin   //如果下位岩梁较小，不能称之为一个岩梁，必须继续计算
                       j:=i;
                       break;
                    end;
                 if (YL_max_m+t_imm.Immroof_M)>s_gzm.S_Cg_h*10 then   begin  //对岩梁的厚度做最终判断
                       j:=i;
                       break;
                    end; 


          end; //end for


           // 下位岩梁初期来压步距最大值
           self.YL_First_step[0]:=Public_Basic.select_max(s_zk.Beam_Def[j].Step_0_Compr,s_zk.Beam_Def[j].Step_0_Simple ,
                            s_zk.Beam_step[j].Step_0_Compr ,s_zk.Beam_step[j].Step_0_Simple);
           // 下位岩梁初期来压步距最小值
           self.YL_First_step[1]:=Public_Basic.select_min(s_zk.Beam_Def[j].Step_0_Compr,s_zk.Beam_Def[j].Step_0_Simple ,
                            s_zk.Beam_step[j].Step_0_Compr ,s_zk.Beam_step[j].Step_0_Simple);
           // 下位岩梁初期来压步距平均值
           self.YL_First_step[2]:=0.25*(s_zk.Beam_Def[j].Step_0_Compr + s_zk.Beam_Def[j].Step_0_Simple +
                                    s_zk.Beam_step[j].Step_0_Compr + s_zk.Beam_step[j].Step_0_Simple);

            // 下位岩梁周期来压步距最大值
           self.YL_Zhouqi_step[0]:=YL_First_step[0] *s_gzm.Ci_xs;
            // 下位岩梁周期来压步距最小值
           self.YL_Zhouqi_step[1]:=self.YL_First_step[1]*s_gzm.Ci_xs;
            // 下位岩梁周期来压步距平均值
           self.YL_Zhouqi_step[2]:=self.YL_First_step[2]*s_gzm.Ci_xs;

          //判断老顶岩梁的结构
          if self.YL_max_m >10  then
              begin
                  self.YL_struc :=1;
              end
            else
              begin
                   if j>0 then
                     begin
                        self.YL_struc :=1;
                     end
                    else
                    begin
                      self.YL_struc :=2;
                    end;
              end;   //end if

       { //判断底板的类型 即底板分类问题  1级 ＜7.22   2级7.22～10.80  3级  10.80～15.21
        //4级   15.21～22.84   5级  22.84～41.79      6级 ＞41.79
        //通过底板的抗压强度判断 }
        if s_zk.Yc_Rock[s_zk.main_coal+1].R_kyqd <= 7.22 then  begin
           self.diban_leobie :=1;
        end else  if s_zk.Yc_Rock[s_zk.main_coal+1].R_kyqd <= 10.8 then  begin
           self.diban_leobie :=2;
        end else  if s_zk.Yc_Rock[s_zk.main_coal+1].R_kyqd <= 15.21 then  begin
           self.diban_leobie :=3;
        end else  if s_zk.Yc_Rock[s_zk.main_coal+1].R_kyqd <= 22.84 then  begin
           self.diban_leobie :=4;
        end else  if s_zk.Yc_Rock[s_zk.main_coal+1].R_kyqd <= 41.79 then  begin
           self.diban_leobie :=5;
        end else  begin
           self.diban_leobie :=6;  
        end;

      except
         Result:=False;
         Is_init:=false;
         sEorr:='老顶参数化失败！';
     end;   //end try
        Result:=true;
           // sEorr:='老顶初始化成功！';
       
   end; //   Told_roof.init 函数结束
  //====================
   //返回直接顶的基本参数
  function TImmediate_roof.Get_Parameter(zk:Tzk_bore;Version:widestring) :WideString;
     Var
       S_out:WideString;
   begin
       if not self.is_init  then
          begin
             S_out:='直接顶初始化失败!';
             exit;
          end;
    if Version='1.0' then begin
       S_out:='直接顶高度'+':';
           S_out:=S_out+FormatFloat('0.00',self.Immroof_M)+';';
       S_out:=S_out+' 直接顶初次跨落步距'+':';
           S_out:=S_out+FormatFloat('0.00',self.Immroof_C0 )+'米; ';
       S_out:=S_out+' 直接顶最上层岩层编号'+':';
           S_out:=S_out+IntToStr(zk.Yc_Rock[self.End_No].Yc_No )+';';
       S_out:=S_out+' 直接顶岩层层数'+':';
           S_out:=S_out+IntToStr(self.Start_No-self.End_No+1 )+'层;';

       Result:=S_out;
    end else if Version='2.0'  then  begin
       S_out:='';
           S_out:=S_out+FormatFloat('0.00',self.Immroof_M)+';';
           S_out:=S_out+FormatFloat('0.00',self.Immroof_C0 )+';';
           S_out:=S_out+IntToStr(zk.Yc_Rock[self.End_No].Yc_No )+';';
           S_out:=S_out+IntToStr(self.Start_No-self.End_No+1 )+';';

       Result:=S_out;
    end;

   end;
  //======================
    //返回岩层运动后的纹理图片
  function TImmediate_roof.Get_YC_Png(zk:Tzk_bore;s_gzm: TG_stope;t_imm:Timmediate_roof;JinChi:double):wideString;  stdcall;
     Var
       S_out:WideString;
       i :integer;
   begin
       if not self.is_init  then
          begin
             S_out:='直接顶初始化失败!';
             exit;
          end;
       S_out:='';
       //t_get_result.

       //  Cal_Ldg(zk,s_gzm,t_imm,JinChi,S_out);
       S_out:='';
       for I :=0  to zk.main_coal-1 do
         begin
             S_out:=S_out+IntToStr(zk.Yc_Rock[i].Yc_No)+',';
             S_out:=S_out+IntToStr(zk.Yc_Rock[i].PNG_Change) +';';

         end;


       Result:=S_out;
   end;
  //======================

  //返回岩层的初次来压步距
function Told_roof.Return_C0(zk:Tzk_bore):wideString;  stdcall;
   var
       S_out:WideString;
       i:integer;
    begin
        S_out:='';
        for I := 0 to zk.Zk_Yc_Count-1   do
         begin
           S_out:=S_out+IntToStr(zk.Yc_Rock[i].Yc_No)+','+ FormatFloat('0.00',zk.Yc_Rock[i].Step0 )+';';
         end;
         Result:=S_out;
    end;
   //返回老顶的裂断拱边界
 function Told_roof.Return_ldg(zk:Tzk_bore;s_gzm: TG_stope;t_imm:Timmediate_roof;Gzmjc:double;Version:WideString):wideString;  stdcall;
   var
       S_out:WideString;
       i:integer;
    begin

       // Cal_Ldg(zk:Tzk_bore;gzm:TG_stope;imm:TImmediate_roof;gzmjc:double;out S_ldg:widestring):wordbool
        Cal_Ldg(zk,s_gzm,t_imm,self,gzmjc,S_out);
        S_out:='';
        if Version='1.0' then begin ////返回裂断拱的边界
              for I :=0  to zk.main_coal-1 do
               begin

                   S_out:=S_out+IntToStr(zk.Yc_Rock[i].Yc_No)+','+ FormatFloat('0.00',zk.Yc_Rock[i].L_qx_xiashan )+',';
                   S_out:=S_out+ FormatFloat('0.00',zk.Yc_Rock[i].L_qx_shangshan )+',';
                   S_out:=S_out+ FormatFloat('0.00',zk.Yc_Rock[i].L_Tj )+';';

                end;//enf for
               Result:=S_out;
        end else if Version='2.0' then  begin
               S_out:=FormatFloat('0.00',s_gzm.Hg_ldg );
               Result:=S_out;
        end;
    end;
  //返回老顶的基本参数
 function Told_roof.Get_Parameter(s_gzm: TG_stope; zk: TZk_bore;t_imm:Timmediate_roof;Version:widestring):wideString;
   Var
     S_out:WideString;
  begin
      if not self.is_init  then
          begin
             S_out:='老顶初始化失败!';
             exit;
          end;
      if Version='1.0' then   begin
                S_out:='老顶综合岩梁的结构'+':';
                    if self.YL_struc=1 then
                         begin
                          S_out:=S_out+'单岩梁'+';';
                          end
                     else
                          begin
                          S_out:=S_out+'多岩梁'+';';
                      end;
                 S_out:=S_out+' 老顶下位岩梁最大厚度'+':';
                     S_out:=S_out+FormatFloat('0.00',self.YL_max_m )+'米;';
                 S_out:=S_out+' 老顶下位岩梁初次步距的平均值为'+':';
                     S_out:=S_out+FormatFloat('0.00',self.YL_First_step[2])+'米;';
                 S_out:=S_out+' 老顶下位岩梁周期步距的平均值'+':';
                     S_out:=S_out+FormatFloat('0.00',self.YL_Zhouqi_step[2])+'米;';
                 if t_imm.Surplus_h >0 then
                     begin
                     S_out:=S_out+' 老顶下位岩梁的支托层与直接顶最上部共处同处'+Trim(zk.Yc_Rock[self.YL_start].R_Name)+'岩层，老顶所得厚度为(米)'+':';
                          S_out:=S_out+FormatFloat('0.00',t_imm.Surplus_h )+';';
                     end;
                 S_out:=S_out+  #13+'   开采中建议:  ';


                 if self.YL_struc=2 then
                    begin
                       S_out:=S_out+'    对采煤工作面影响比较大的岩层是距离煤层顶板上方 '+':';
                          S_out:=S_out+FormatFloat('0.00',t_imm.Immroof_M+self.YL_min_m );
                          S_out:=S_out+'米,厚度为'+FormatFloat('0.00',zk.Yc_Rock[self.YL_min_End-1].R_h)+'米的'+Trim(zk.Yc_Rock[self.YL_min_End-1].R_Name)+',';
                          S_out:=S_out+'初次来压步距为'+FormatFloat('0.00',zk.Yc_Rock[self.YL_min_End-1].Step0 )+'(+/-1.5)米,';
                          S_out:=S_out+'周期来压步距为'+FormatFloat('0.00',zk.Yc_Rock[self.YL_min_End-1].Step0 *s_gzm.Ci_xs)+'(+/-1.5)米,';
                          S_out:=S_out+' 请工作中注意防范'+'！';
                    end  else    begin
                      S_out:=S_out+'对采煤工作面影响比较大的岩层是距离煤层顶板上方 '+':';
                          S_out:=S_out+FormatFloat('0.00',t_imm.Immroof_M );
                          S_out:=S_out+'米,厚度为'+FormatFloat('0.00',zk.Yc_Rock[self.YL_start].R_h)+'米的'+Trim(zk.Yc_Rock[self.YL_start].R_Name)+',';
                          S_out:=S_out+'初次来压步距为'+FormatFloat('0.00',self.YL_First_step[2] )+'(+/-1.5)米,';
                          S_out:=S_out+'周期来压步距为'+FormatFloat('0.00',self.YL_Zhouqi_step[2])+'(+/-1.5)米,';
                          S_out:=S_out+' 请工作中注意防范'+'！';

                     end;

                  Result:=S_out;
      end else if Version='3.0' then begin
             S_out:='';
                    if self.YL_struc=1 then
                         begin
                          S_out:=S_out+'单岩梁'+';';
                          end
                     else
                          begin
                          S_out:=S_out+'多岩梁'+';';
                      end;
                      S_out:=S_out+FormatFloat('0.00',self.YL_max_m )+';';   //最大厚度
                      S_out:=S_out+FormatFloat('0.00',self.YL_min_m )+';';
                      S_out:=S_out+FormatFloat('0.00',self.YL_First_step[0])+';'+FormatFloat('0.00',self.YL_First_step[1])+';'+FormatFloat('0.00',self.YL_First_step[2])+';';  // 老顶下位岩梁初次步距的最大/最小/平均值(米)'+':';
                      S_out:=S_out+FormatFloat('0.00',self.YL_Zhouqi_step[0])+';'+FormatFloat('0.00',self.YL_Zhouqi_step[1])+';'+FormatFloat('0.00',self.YL_Zhouqi_step[2])+';'; //    S_out:=S_out+'老顶下位岩梁周期步距的最大/最小/平均值(米)'+':';
              Result:=S_out;
       end else if Version='4.0' then begin
             S_out:='';
                    S_out:=S_out+FormatFloat('0.00',self.YL_Zhouqi_step[2]); //    S_out:=S_out+'老顶下位岩梁周期步距的/平均值(米)'+':';
             Result:=S_out;

      end;
  end; //老顶计算模块
  //====================================
  //计算支承压力函数
 function Cal_Zcyl(zk:Tzk_bore;imm:TImmediate_roof;gzm:TG_stope;old_r :Told_roof;out S_ZCYl:WideString):wordbool;
  var
    Zcyl_s1: double;//计算支承压力的的峰值距离煤壁的距离
    ZCyl_s0 :double;// 内应力场的距离
    Mbcsnl_l:double;//煤壁丧失支撑能力的距离
  begin
     if not gzm.is_init or not imm.is_init or not zk.is_init then
       begin
         Result:=False;
         Exit;
       end;
     mbcsnl_l:=2*zk.Yc_Rock[zk.main_coal].R_kyqd*1000/(gzm.S_mcsd_h *zk.Yc_Rock[imm.Start_No].R_r);
      if imm.Immroof_M=0 then    begin
           mbcsnl_l:=mbcsnl_l/gzm.S_Cg_h;
      end else begin
           mbcsnl_l:=mbcsnl_l/(imm.Immroof_M* zk.Yc_Rock[imm.Start_No].R_r )/gzm.S_Cg_h;
      end;
     if mbcsnl_l<5  then   mbcsnl_l:=5;
     if mbcsnl_l>imm.Immroof_C0 then  mbcsnl_l:= imm.Immroof_C0;
     
     gzm.mbcsnl_l:=mbcsnl_l;
     //0  值 赋值
     if gzm.S_M_mcj=0 then    gzm.S_M_mcj:=25;
     if gzm.S_M_njl=0 then    gzm.S_M_njl:=4000;
     if gzm.S_mcsd_h=0 then   gzm.S_mcsd_h:=500;
     if gzm.S_K_zcfz=0  then  gzm.S_K_zcfz:=2.5;
     
     zcyl_s1:=gzm.S_Cg_h*gzm.S_Bsb/2/tan(gzm.S_M_mcj/180*3.14159)/(1-gzm.S_Bsb ) *2;
     zcyl_s1:=zcyl_s1*ln(gzm.S_K_zcfz*gzm.S_mcsd_h*tan(gzm.S_M_mcj/180*3.14159)* 2.5 *10/gzm.S_M_njl +1);

     zcyl_s0:=sqrt(old_r.YL_First_step[2]*0.3*0.5*gzm.S_L_qx*zcyl_s1/gzm.S_K_zcfz/gzm.S_mcsd_h);



     //判断赋值  20140103

                     //通过煤层厚度修订参数
                if  zcyl_s1<3 then   begin
                    if gzm.S_Cg_h>3 then begin
                       gzm.ZCYL_s1[2]:=zcyl_s1*3;    //通过煤层厚度修订参数
                    end else begin
                       gzm.ZCYL_s1[2]:=zcyl_s1*gzm.S_Cg_h;
                    end;
                end else begin
                       gzm.ZCYL_s1[2]:=zcyl_s1;
                end;
              if zcyl_s0>gzm.ZCYL_s1[2] then  zcyl_s0:= gzm.ZCYL_s1[2]*0.4;

              if  ZCYL_s0<1 then  begin
                     if gzm.S_Cg_h>3 then begin
                       gzm.ZCYL_s0 := zcyl_s0*3;    //通过煤层厚度修订参数
                    end else begin
                       gzm.ZCYL_s0 := zcyl_s0*gzm.S_Cg_h;
                    end;
                end else begin
                    gzm.ZCYL_s0 := zcyl_s0;
                end;


     if zcyl_s1<1.5 then  zcyl_s1:=1.5;//强制最小值
     if zcyl_s0<1 then  zcyl_s0:=1; //强制最小值
     if zcyl_s1<zcyl_s0 then  zcyl_s1:=2*zcyl_s0; //  //强制最小值

          gzm.ZCYL_s1[0]:=gzm.ZCYL_s1[2]*1.2;
          gzm.ZCYL_s1[1]:=gzm.ZCYL_s1[2]*(1+sin(gzm.S_qj/180*3.14159));
          gzm.ZCYL_s1[2]:=gzm.ZCYL_s1[2];
          gzm.ZCYL_s1[3]:=gzm.ZCYL_s1[2]*(1-sin(gzm.S_qj/180*3.14159));

         if gzm.S_f_PS <2  then
            begin
                gzm.ZCYL_sx[0]:= gzm.ZCYL_s1[0]*5;
                gzm.ZCYL_sx[1]:= gzm.ZCYL_s1[1]*5;
                gzm.ZCYL_sx[2]:= gzm.ZCYL_s1[2]*5;
                gzm.ZCYL_sx[3]:= gzm.ZCYL_s1[3]*5;
            end
          else
            begin
                gzm.ZCYL_sx[0]:= gzm.ZCYL_s1[0]*4;
                gzm.ZCYL_sx[1]:= gzm.ZCYL_s1[1]*4;
                gzm.ZCYL_sx[2]:= gzm.ZCYL_s1[2]*4;
                gzm.ZCYL_sx[3]:= gzm.ZCYL_s1[3]*4;
            end;


       Result:=true;

  end; //计算支承压力结束的函数



 // 返回采煤工作面的支撑压力
function TG_stope.Return_Zcyl(Version:WideString;JinChi:Double;zk:Tzk_bore):Widestring;//返回采煤工作面的支撑压力
  var
    Str_temp:WideString;
    Str_s1_2:double;
    K1,K2 :double; //内外应力场峰值 大小
    s0,s1 :double; // 内外应力场范围
    JinC_sul:double;//剩余进尺的变量
  begin
      Str_temp:='';
    //开始计算煤壁丧失支撑能力的距离
      if JinChi<5 then JinChi:=5;

      if JinChi < self.mbcsnl_l  then  begin
          K1:=0;
          if self.S_f_PS>1.5 then   begin     //通过煤的硬度来判断支撑峰值
               K2:= 1+ sqrt(JinChi/40/3);  //外应力场的峰值    煤硬 支撑峰值在60米左右
          end else if self.S_f_PS>1 then begin
               K2:= 1+ sqrt(JinChi/50/3);  //外应力场的峰值   煤中等 支撑峰值在100米左右
          end else begin
               K2:= 1+ sqrt(JinChi/60/3);  //外应力场的峰值   煤软 支撑峰值在120米左右
          end;

          if K2<1.05 then k2:=1.05;

          if Version='1.0' then begin

                 Str_temp:='0;'+FormatFloat('0.00',K2)+';'; // k1,k2
                 Str_temp:=Str_temp+'0,0,0,0;' ; //S0 的四个数
                 Str_temp:=Str_temp+'0,0,0,0;' ; //S1 的四个数
                 Str_temp:=Str_temp+FormatFloat('0.0',self.ZCYL_sx[0]* JinChi/self.S_L_qx)+','; //Sx 的四个数   开切眼处
                 Str_temp:=Str_temp+FormatFloat('0.0',self.ZCYL_sx[1]* JinChi/self.S_L_qx)+','; //Sx 的四个数   下顺槽处
                 Str_temp:=Str_temp+FormatFloat('0.0',self.ZCYL_sx[2]* JinChi/self.S_L_qx)+','; //Sx 的四个数   工作面前方处
                 Str_temp:=Str_temp+FormatFloat('0.0',self.ZCYL_sx[3]* JinChi/self.S_L_qx)+';'; //Sx 的四个数   上顺槽处
                 Result:=Str_temp;
            end else if Version='2.0' then  begin     //仅返综合数据
                 Str_temp:='0;0;'+FormatFloat('0.00',K2)+';0;';    //k1,S0,K2,s1,
                 Str_temp:=Str_temp+FormatFloat('0.0',(k2-1)*40)+';';  //sx
                 Result:=Str_temp;
            end;   //end if Version='1.0' then begin

      end else begin
           if Jinchi<=self.S_L_qx  then   begin      //一次见方之内
               // K1:=0.8*Jinchi/self.S_L_qx;     // 内应力场峰值大小
                K1:=0.8;
                s0:=self.ZCYL_s0*(JinChi-self.mbcsnl_l)/self.S_L_qx;      // 内应力场范围
                if self.S_f_PS>1.5 then   begin     //通过煤的硬度来判断支撑峰值
                     K2:= 1+ sqrt(JinChi/40/3);  //外应力场的峰值    煤硬 支撑峰值在60米左右
                end else if self.S_f_PS>1 then begin
                     K2:= 1+ sqrt(JinChi/50/3);  //外应力场的峰值   煤中等 支撑峰值在100米左右
                end else begin
                     K2:= 1+ sqrt(JinChi/60/3);  //外应力场的峰值   煤软 支撑峰值在120米左右
                end;
                S1:=self.ZCYL_s1[2]* JinChi/self.S_L_qx;      // 外应力场范围
                if S1<S0 then  s1:=2*S0;
                
                  if K2>2.5 then  K2:=2.5;   //最大值强制
                  if Version='1.0' then begin
                       Str_s1_2:=0;
                       Str_temp:=FormatFloat('0.00',K1)+';';   // k1
                       Str_temp:=Str_temp+FormatFloat('0.00',K2)+';'; // k2
                       Str_temp:=Str_temp+FormatFloat('0.0',s0)+','; // so 开切眼后方
                       Str_temp:=Str_temp+FormatFloat('0.0',s0*(1+sin(self.S_qj/180*3.14159)))+','; // so  下顺槽处
                       //判断初次来压步距
                       if JinChi<zk.Yc_Rock[zk.main_coal-1].Step0-s0 then begin
                            Str_temp:=Str_temp+'0,'; // s0  工作面前方处
                            Str_s1_2:=s0+s1;  // s1 工作面前方处
                        end else if JinChi<=zk.Yc_Rock[zk.main_coal-1].Step0 then begin
                            Str_temp:=Str_temp+'0,'; // s0  工作面前方处
                            Str_s1_2:=s0+s1-(JinChi-zk.Yc_Rock[zk.main_coal-1].Step0 );  // s1 工作面前方处
                       end;  //end   if JinChi<zk.Yc_Rock[zk.main_coal-1].Step0-s0 then begin

                      JinC_sul:=JinChi-zk.Yc_Rock[zk.main_coal-1].Step0;

                       while JinC_sul>0 do   begin
                                if JinC_sul<zk.Yc_Rock[zk.main_coal-1].Step0*0.3-s0 then begin
                                      Str_temp:=Str_temp+'0,'; // s0  工作面前方处
                                      Str_s1_2:=s0+s1;  // s1 工作面前方处
                                   end else if JinC_sul<=zk.Yc_Rock[zk.main_coal-1].Step0*0.3 then begin
                                      Str_temp:=Str_temp+'0,'; // s0  工作面前方处
                                      Str_s1_2:=s0+s1-(JinC_sul-zk.Yc_Rock[zk.main_coal-1].Step0*0.3 );  // s1 工作面前方处

                                 end;  //end  if JinC_sul<zk.Yc_Rock[zk.main_coal-1].Step0*0.3-s0 then begin
                                 JinC_sul:=JinC_sul-zk.Yc_Rock[zk.main_coal-1].Step0*0.3;

                       end;  //end while do

                       Str_temp:=Str_temp+FormatFloat('0.0',s0*(1-sin(self.S_qj/180*3.14159)))+';'; // s0  上顺槽处

                       Str_temp:=Str_temp+FormatFloat('0.0',s1)+','; // s1 开切眼后方
                       Str_temp:=Str_temp+FormatFloat('0.0',s1*(1+sin(self.S_qj/180*3.14159)))+','; // s1  下顺槽处
                       Str_temp:=Str_temp+FormatFloat('0.0',Str_s1_2)+','; // s1  s1 工作面前方处
                       Str_temp:=Str_temp+FormatFloat('0.0',s1*(1-sin(self.S_qj/180*3.14159)))+';'; // s1  上顺槽处


                       Str_temp:=Str_temp+FormatFloat('0.0',self.ZCYL_sx[0]* JinChi/self.S_L_qx)+','; //Sx 的四个数   开切眼处
                       Str_temp:=Str_temp+FormatFloat('0.0',self.ZCYL_sx[1]* JinChi/self.S_L_qx)+','; //Sx 的四个数   下顺槽处
                       Str_temp:=Str_temp+FormatFloat('0.0',self.ZCYL_sx[2]* JinChi/self.S_L_qx)+','; //Sx 的四个数   工作面前方处
                       Str_temp:=Str_temp+FormatFloat('0.0',self.ZCYL_sx[3]* JinChi/self.S_L_qx)+';'; //Sx 的四个数   上顺槽处
                       Result:=Str_temp;
                  end else if Version='2.0' then  begin     //仅返综合数据
                       Str_temp:=FormatFloat('0.00',K1)+';';    //k1
                       Str_temp:=Str_temp+FormatFloat('0.0',s0)+';';  //s0
                       Str_temp:=Str_temp+FormatFloat('0.00',k2)+';';  //s0
                       Str_temp:=Str_temp+FormatFloat('0.0',s1)+';';  //s1
                       Str_temp:=Str_temp+FormatFloat('0.0',self.ZCYL_sx[0]* JinChi/self.S_L_qx)+';';  //sx
                       Result:=Str_temp;
                  end;   //end if Version='1.0' then begin

           end else if Jinchi<=self.S_L_qx*2  then begin     //一次见方之外二次见方之内
                K1:=0.8;     // 内应力场峰值大小
                s0:=self.ZCYL_s0;      // 内应力场范围
                if self.S_f_PS>1.5 then   begin     //通过煤的硬度来判断支撑峰值
                     K2:= 1+ sqrt(JinChi/40/3);  //外应力场的峰值    煤硬 支撑峰值在60米左右
                end else if self.S_f_PS>1 then begin
                     K2:= 1+ sqrt(JinChi/50/3);  //外应力场的峰值   煤中等 支撑峰值在100米左右
                end else begin
                     K2:= 1+ sqrt(JinChi/60/3);  //外应力场的峰值   煤软 支撑峰值在120米左右
                end;

                S1:=self.ZCYL_s1[2];      // 外应力场范围
                if K2>2.5 then  K2:=2.5;   //最大值强制
                if Version='1.0' then begin
                       Str_s1_2:=0;
                       Str_temp:=FormatFloat('0.00',K1)+';';   // k1
                       Str_temp:=Str_temp+FormatFloat('0.00',K2)+';'; // k2
                       Str_temp:=Str_temp+FormatFloat('0.0',s0)+','; // so 开切眼后方
                       Str_temp:=Str_temp+FormatFloat('0.0',s0*(1+0.5*(Jinchi-self.S_L_qx)/self.S_L_qx)*(1+sin(self.S_qj/180*3.14159)))+','; // so  下顺槽处
                       //判断初次来压步距
                       if JinChi<zk.Yc_Rock[zk.main_coal-1].Step0-s0 then begin
                            Str_temp:=Str_temp+'0,'; // s0  工作面前方处
                            Str_s1_2:=s0+s1;  // s1 工作面前方处
                        end else if JinChi<=zk.Yc_Rock[zk.main_coal-1].Step0 then begin
                            Str_temp:=Str_temp+'0,'; // s0  工作面前方处
                            Str_s1_2:=s0+s1-(JinChi-zk.Yc_Rock[zk.main_coal-1].Step0 );  // s1 工作面前方处
                       end;  //end   if JinChi<zk.Yc_Rock[zk.main_coal-1].Step0-s0 then begin

                      JinC_sul:=JinChi-zk.Yc_Rock[zk.main_coal-1].Step0;
                       while JinC_sul>0 do   begin
                                if JinC_sul<zk.Yc_Rock[zk.main_coal-1].Step0*0.3-s0 then begin
                                      Str_temp:=Str_temp+'0,'; // s0  工作面前方处
                                      Str_s1_2:=s0+s1;  // s1 工作面前方处
                                   end else if JinC_sul<=zk.Yc_Rock[zk.main_coal-1].Step0*0.3 then begin
                                      Str_temp:=Str_temp+'0,'; // s0  工作面前方处
                                      Str_s1_2:=s0+s1-(JinC_sul-zk.Yc_Rock[zk.main_coal-1].Step0*0.3 );  // s1 工作面前方处

                                 end;  //end  if JinC_sul<zk.Yc_Rock[zk.main_coal-1].Step0*0.3-s0 then begin
                                 JinC_sul:=JinC_sul-zk.Yc_Rock[zk.main_coal-1].Step0*0.3;

                       end;  //end while do

                       Str_temp:=Str_temp+FormatFloat('0.0',s0*(1+0.5*(Jinchi-self.S_L_qx)/self.S_L_qx)*(1-sin(self.S_qj/180*3.14159)))+';'; // s0  上顺槽处

                       Str_temp:=Str_temp+FormatFloat('0.0',s1)+','; // s1 开切眼后方
                       Str_temp:=Str_temp+FormatFloat('0.0',s1*(1+0.5*(Jinchi-self.S_L_qx)/self.S_L_qx)*(1+sin(self.S_qj/180*3.14159)))+','; // s1  下顺槽处
                       Str_temp:=Str_temp+FormatFloat('0.0',Str_s1_2)+','; // s1  s1 工作面前方处
                       Str_temp:=Str_temp+FormatFloat('0.0',s1*(1+0.5*(Jinchi-self.S_L_qx)/self.S_L_qx)*(1-sin(self.S_qj/180*3.14159)))+';'; // s1  上顺槽处


                       Str_temp:=Str_temp+FormatFloat('0.0',self.ZCYL_sx[0])+','; //Sx 的四个数   开切眼处
                       Str_temp:=Str_temp+FormatFloat('0.0',self.ZCYL_sx[1]*(1+0.5*(Jinchi-self.S_L_qx)/self.S_L_qx))+','; //Sx 的四个数   下顺槽处
                       Str_temp:=Str_temp+FormatFloat('0.0',self.ZCYL_sx[2])+','; //Sx 的四个数   工作面前方处
                       Str_temp:=Str_temp+FormatFloat('0.0',self.ZCYL_sx[3]*(1+0.5*(Jinchi-self.S_L_qx)/self.S_L_qx))+';'; //Sx 的四个数   上顺槽处
                       Result:=Str_temp;
                 end else if Version='2.0' then  begin     //仅返综合数据
                       Str_temp:=FormatFloat('0.00',K1)+';';    //k1
                       Str_temp:=Str_temp+FormatFloat('0.0',s0)+';';  //s0
                       Str_temp:=Str_temp+FormatFloat('0.00',k2)+';';  //s0
                       Str_temp:=Str_temp+FormatFloat('0.0',s1)+';';  //s0
                       Str_temp:=Str_temp+FormatFloat('0.0',self.ZCYL_sx[0])+';';  //sx
                       Result:=Str_temp;
                 end;   //end if Version='1.0' then begin
           end else begin
                  K1:=0.8;     // 内应力场峰值大小
                s0:=self.ZCYL_s0;      // 内应力场范围
                K2:= 1+ JinChi*JinChi*0.5*0.5/self.S_mcsd_h;  //外应力场的峰值
                S1:=self.ZCYL_s1[2];      // 外应力场范围
                if K2>2.5 then  K2:=2.5;   //最大值强制
                if Version='1.0' then begin
                       Str_s1_2:=0;
                       Str_temp:=FormatFloat('0.0',K1)+';';   // k1
                       Str_temp:=Str_temp+FormatFloat('0.00',K2)+';'; // k2
                       Str_temp:=Str_temp+FormatFloat('0.0',s0)+','; // so 开切眼后方
                       Str_temp:=Str_temp+FormatFloat('0.0',s0*(1.5)*(1+sin(self.S_qj/180*3.14159)))+','; // so  下顺槽处
                       //判断初次来压步距
                       if JinChi<zk.Yc_Rock[zk.main_coal-1].Step0-s0 then begin
                            Str_temp:=Str_temp+'0,'; // s0  工作面前方处
                            Str_s1_2:=s0+s1;  // s1 工作面前方处
                        end else if JinChi<=zk.Yc_Rock[zk.main_coal-1].Step0 then begin
                            Str_temp:=Str_temp+'0,'; // s0  工作面前方处
                            Str_s1_2:=s0+s1-(JinChi-zk.Yc_Rock[zk.main_coal-1].Step0 );  // s1 工作面前方处
                       end;  //end   if JinChi<zk.Yc_Rock[zk.main_coal-1].Step0-s0 then begin

                      JinC_sul:=JinChi-zk.Yc_Rock[zk.main_coal-1].Step0;
                       while JinC_sul>0 do   begin
                                if JinC_sul<zk.Yc_Rock[zk.main_coal-1].Step0*0.3-s0 then begin
                                      Str_temp:=Str_temp+'0,'; // s0  工作面前方处
                                      Str_s1_2:=s0+s1;  // s1 工作面前方处
                                   end else if JinC_sul<=zk.Yc_Rock[zk.main_coal-1].Step0*0.3 then begin
                                      Str_temp:=Str_temp+'0,'; // s0  工作面前方处
                                      Str_s1_2:=s0+s1-(JinC_sul-zk.Yc_Rock[zk.main_coal-1].Step0*0.3 );  // s1 工作面前方处

                                 end;  //end  if JinC_sul<zk.Yc_Rock[zk.main_coal-1].Step0*0.3-s0 then begin
                                 JinC_sul:=JinC_sul-zk.Yc_Rock[zk.main_coal-1].Step0*0.3;
                                 
                       end;  //end while do

                       Str_temp:=Str_temp+FormatFloat('0.0',s0*(1.5)*(1-sin(self.S_qj/180*3.14159)))+';'; // s0  上顺槽处

                       Str_temp:=Str_temp+FormatFloat('0.0',s1)+','; // s1 开切眼后方
                       Str_temp:=Str_temp+FormatFloat('0.0',s1*(1.5)*(1+sin(self.S_qj/180*3.14159)))+','; // s1  下顺槽处
                       Str_temp:=Str_temp+FormatFloat('0.0',Str_s1_2)+','; // s1  s1 工作面前方处
                       Str_temp:=Str_temp+FormatFloat('0.0',s1*(1.5)*(1-sin(self.S_qj/180*3.14159)))+';'; // s1  上顺槽处


                       Str_temp:=Str_temp+FormatFloat('0.0',self.ZCYL_sx[0])+','; //Sx 的四个数   开切眼处
                       Str_temp:=Str_temp+FormatFloat('0.0',self.ZCYL_sx[1]*1.5)+','; //Sx 的四个数   下顺槽处
                       Str_temp:=Str_temp+FormatFloat('0.0',self.ZCYL_sx[2])+','; //Sx 的四个数   工作面前方处
                       Str_temp:=Str_temp+FormatFloat('0.0',self.ZCYL_sx[3]*1.5)+';'; //Sx 的四个数   上顺槽处
                       Result:=Str_temp;
                 end else if Version='2.0' then  begin     //仅返综合数据
                       Str_temp:=FormatFloat('0.0',K1)+';';    //k1
                       Str_temp:=Str_temp+FormatFloat('0.0',s0)+';';  //s0
                       Str_temp:=Str_temp+FormatFloat('0.0',k2)+';';  //s0
                       Str_temp:=Str_temp+FormatFloat('0.0',s1)+';';  //s0
                       Str_temp:=Str_temp+FormatFloat('0.0',self.ZCYL_sx[0])+';';  //sx
                       Result:=Str_temp;
                 end;   //end if Version='1.0' then begin
           end; // end   if Jinchi<=self.S_L_qx
      end;  //end   if gzm.S_Jc_L > mbcsnl_l then  begin  
 end;



 // 计算裂断拱的边界
function Cal_Ldg(zk:Tzk_bore;gzm:TG_stope;imm:TImmediate_roof;old_r:Told_roof;gzmjc:double;out S_ldg:widestring):wordbool;
  var
    i:integer;
    a0,ai,C,b1,a_t: double; //支撑压力平衡拱开口距的一半
    cyxs: double;//测压系数
    hg  : double;//裂断拱的高度
    f   :double;//普氏系数
    K   :double;//安全系数
    s0  :double;//支撑压力峰值
    TemP:double;//临时变量
    nsj:double; //岩梁内缩的 角度
  begin
     try
      if not gzm.is_init or  not zk.is_init then
       begin
         Result:=False;
         Exit;
       end;
         K:=2.5;    //安全系数
        // nsj:=25;   // 岩层内缩的角度为25度
        if gzmjc>gzm.S_L_qx then  begin
             s0:=gzm.ZCYL_s0;
             ai:=s0+gzm.S_L_qx/2;
        end else  if gzmjc> gzm.mbcsnl_l then begin
             s0:=gzm.ZCYL_s0*(gzmjc/gzm.S_L_qx);;
             ai:=s0+gzmjc/2;
        end else begin
             s0:=0;
             ai:=s0+gzmjc/2;
        end;
            a0:=gzm.S_L_qx;
            hg:=0;   //裂断拱高赋空值
       //初始化内缩值
           for I := zk.main_coal-1 downto 0 do
             begin
                  zk.Yc_Rock[i].L_qx_xiashan:=-100;
                   zk.Yc_Rock[i].L_qx_shangshan :=-100;
                   zk.Yc_Rock[i].L_Tj:=-100;
             end;
     //TemP:= K*gzm.S_L_qx*cos(gzm.S_qj/180*3.1415926)*cos(gzm.S_qj/180*3.1415926);
     //        Trmp:=TemP/(2*cos(gzm.S_qj/180*3.1415926)*k-2*f*sin(gzm.S_qj/180*3.1415926));

       for I := zk.main_coal-1 downto 0 do
         begin
         if i>=imm.End_No  then  begin
                 ai:=ai;
                 hg:=hg+zk.Yc_Rock[i].R_h;
          end else begin
               //强制退出机制
              if ai*2<zk.Yc_Rock[i].Step0 then begin
                old_r.yl_max_End:=i;
                break;
              end;
              hg:=hg+zk.Yc_Rock[i].R_h;
              if (zk.Yc_Rock[i].R_kyqd <0.5) then begin
                 f:=0.1;
              end else begin
                 f:= zk.Yc_Rock[i].R_kyqd/10;
              end;
                 nsj:=16+3*f;
                 TemP:= K*a0*cos(gzm.S_qj/180*3.1415926)*cos(gzm.S_qj/180*3.1415926);
                 Temp:=TemP/(2*cos(gzm.S_qj/180*3.1415926)*k-2*f*sin(gzm.S_qj/180*3.1415926));

              b1:=k*ai/2/f;

             if b1<zk.Yc_Rock[i].R_h then  begin
                  ai:=0;
                end else  begin
                  a_t:=sqrt(f*ai*(b1-zk.Yc_Rock[i].R_h) );

                  if a_t<ai then
                        if zk.Yc_Rock[i].R_h*tan(nsj/180*3.14159)<ai-a_t then  begin
                           ai:=ai-zk.Yc_Rock[i].R_h*tan(nsj/180*3.14159);
                        end else begin
                           ai:=a_t;
                        end;

                end;  //end if  b1<zk.Yc_Rock[i].R_h
          end; //end if    i<imm.End_No
              //分级判断岩层内缩情况

             if gzmjc>gzm.S_L_qx  then  begin
                   zk.Yc_Rock[i].L_qx_xiashan:=gzm.S_L_qx/2-ai/cos(gzm.S_qj/180*3.1415926)+s0;
                   zk.Yc_Rock[i].L_qx_shangshan :=gzm.S_L_qx/2-ai*(1+ sin(gzm.S_qj/180*3.14159))+s0;
                   zk.Yc_Rock[i].L_Tj:=gzm.S_L_qx/2+s0-ai;
             end else begin
                   zk.Yc_Rock[i].L_qx_xiashan:=gzmjc/2-ai*(1-sin(gzm.S_qj/180*3.14159))+s0;
                   zk.Yc_Rock[i].L_qx_shangshan :=gzmjc/2-ai*(1+ sin(gzm.S_qj/180*3.14159))+s0;
                   zk.Yc_Rock[i].L_Tj:=gzmjc/2+s0-ai;  

             end;


          end;//enf for
             //把拱高赋予工作面的类
             gzm.Hg_ldg :=hg;
             zk.Zk_ldg_end_no:=i+1;
             S_ldg:=FormatFloat('0.0',hg)+';';

             Result:=true;
          // 判断纹理更换情况
             for I := zk.main_coal-1 downto 0 do
               begin
                    zk.Yc_Rock[i].PNG_Change :=0;
               end;

            for I := zk.main_coal-1 downto 0 do
             begin
                     if i> imm.End_No then  begin
                          if gzmjc <gzm.S_L_qx  then
                            begin
                               if (gzmjc-2*zk.Yc_Rock[i].L_Tj)<zk.Yc_Rock[i].Step0  then
                                  begin
                                      break;
                                  end else begin
                                      zk.Yc_Rock[i].PNG_Change :=1;
                                  end;

                            end else begin
                               zk.Yc_Rock[i].PNG_Change :=1;
                            end;
                     end else begin
                         break;
                     end;

             end;


          //--------把需要的东西返回
           for I := 0  to zk.Zk_Yc_Count  do
             begin
               S_ldg:=S_ldg+IntToStr(zk.Yc_Rock[i].Yc_No)+',';
               S_ldg:=S_ldg+(zk.Yc_Rock[i].R_Name)+',';
               S_ldg:=S_ldg+FormatFloat('0.0',zk.Yc_Rock[i].R_h)+',';
               S_ldg:=S_ldg+FormatFloat('0.0',zk.Yc_Rock[i].L_qx_xiashan )+',';
               S_ldg:=S_ldg+FormatFloat('0.0',zk.Yc_Rock[i].L_qx_shangshan)+',';
               S_ldg:=S_ldg+FormatFloat('0.0',zk.Yc_Rock[i].L_Tj )+';';

             end;
     except
        Result:=False;
     end;  //end try

  end;
  //覆岩运动规律导出
  function Return_Fyyd(gzm:TG_Stope;Zk:Tzk_bore;imm:TImmediate_roof;old:Told_roof):WideString;
   var
     S_Ret,S_ldg:WideString;
     i:integer;
  begin
     //工作面信息
      Cal_Ldg(Zk,gzm,imm,old,gzm.S_Jc_L,S_ldg);
      S_Ret:=S_Ret+'Gzm:';
      S_Ret:=S_Ret+gzm.S_Name+',';
  //    S_Ret:=S_Ret+gzm.S_Cg_h+';';
     // 钻孔基本信息
      S_Ret:=S_Ret+'zk:';
      S_Ret:=S_Ret+zk.Zk_name +',';
      S_Ret:=S_Ret+IntToStr(zk.Zk_Yc_Count) +',';
      S_Ret:=S_Ret+InttoStr(zk.main_coal) +'*';
      for I := 0 to zk.Zk_Yc_Count -1 do
        begin
           S_Ret:=S_Ret+InTtoStr(zk.Yc_Rock[i].Yc_No )+',';
           S_Ret:=S_Ret+zk.Yc_Rock[i].R_Name+',' ;
           S_Ret:=S_Ret+FormatFloat('0.0',zk.Yc_Rock[i].R_h )+',';
           S_Ret:=S_Ret+FormatFloat('0.0',zk.Yc_Rock[i].R_kyqd )+',';
           S_Ret:=S_Ret+FormatFloat('0.0',zk.Yc_Rock[i].R_klqd )+',';
           S_Ret:=S_Ret+FormatFloat('0.0',zk.Yc_Rock[i].R_r )+',';
           S_Ret:=S_Ret+FormatFloat('0.0',zk.Yc_Rock[i].Step0 )+',';
           S_Ret:=S_Ret+FormatFloat('0.0',zk.Yc_Rock[i].L_qx_xiashan  )+',';
           S_Ret:=S_Ret+FormatFloat('0.0',zk.Yc_Rock[i].L_qx_shangshan  )+',';
           S_Ret:=S_Ret+FormatFloat('0.0',zk.Yc_Rock[i].L_Tj  )+'*';
        end;
      S_Ret:=S_Ret+';';
      S_Ret:=S_Ret+'YL:';
    {  for I := 0 to 4 do
         begin
          if zk.Beam_Def[0]. then
          
         end;
     }


    Result:=S_Ret;


  end;
  // 返回每个岩层的沉降值
  function Tzk_bore.ReturnSa(zk:TZk_bore): WideString;
  var
     S_Out:WideString;
     i,j:integer;
     Sa_temp: array [0..2] of double;
  begin
      S_out:='';
      for j := 0 to 2 do
           Sa_temp[j]:=zk.Yc_Rock[zk.Zk_ldg_end_no].Sa[j];

      for I :=0  to zk.main_coal do
       begin
           if i<zk.Zk_ldg_end_no then
             begin
                S_out:=S_out+IntToStr(zk.Yc_Rock[i].Yc_No)+',' ;
                S_out:=S_out+FormatFloat('0.0',Sa_temp[0]*0.5 )+',';
                S_out:=S_out+FormatFloat('0.0',Sa_temp[1]*0.5 )+',';
                S_out:=S_out+FormatFloat('0.0',Sa_temp[2]*0.5 )+';';
             end else begin
                S_out:=S_out+IntToStr(zk.Yc_Rock[i].Yc_No)+',' ;
                S_out:=S_out+FormatFloat('0.0',zk.Yc_Rock[i].Sa[0])+',';
                S_out:=S_out+FormatFloat('0.0',zk.Yc_Rock[i].Sa[1] )+',';
                S_out:=S_out+FormatFloat('0.0',zk.Yc_Rock[i].Sa[2])+';';
             end;

       end;
       Result:=S_out;

  end;
function TZk_bore.Return_ZkCs: widestring;
Var
  EStr:WideString;
  i:integer;
begin
   EStr:='';
   for I := 0 to Zk_Yc_Count-1 do
       EStr:= EStr+IntToStr(Yc_Rock[i].Yc_No)+','
             + FormatFloat('0.00',Yc_Rock[i].R_klqd)+';';
   Result:=EStr;
end;

//返回开采岩层的影响范围
  function Tzk_bore.ReturnCxbj(zk: TZk_bore): WideString;
  begin

  end;
  //===============================================
  //===初始化支架
function TZJ_Class.Init(str:wideString;out sEorr:Widestring):WordBool;
var
           temp1,temp2 :Str_Dt_array;
           i,Count1,Count2:integer;
begin
        Result:=true;
        sEorr:='支架初始化成功!';
        if trim(str)='' then begin
            str:='ZJ:综采,ZY13000/25/50,1.75,5,2.6,2,2.5,13000,1.46,2,.5,';  
        end;
      try
            temp1:=Public_Basic.split(str,':',Count1);

            if UpperCase(temp1[0])<>'ZJ' then
             begin
               Result:=False;
               sEorr:='支架报头ZJ错误!';
               exit;
             end;

           temp2:=Public_Basic.split(temp1[1],',',Count2);
           if count2<12 then
               begin
               Result:=False;
               sEorr:='请仔细检查文件!';
               exit;
              end;
         for i :=low(temp2) to high(temp2) do
           begin
             if length(temp2[i])=0 then continue;
                  case i of
                     0: Zj_XingHao :=Trim(temp2[i]);
                     1: ZJ_BianHao:=Trim(temp2[i]);
                     2: ZJ_Zhongxinju :=Public_Basic.strTodouble_lu(temp2[i]);
                     3: ZJ_KongDingJU  :=Public_Basic.strTodouble_lu(temp2[i]);
                     4: Zj_Hlzyd  :=Public_Basic.strTodouble_lu(temp2[i]);
                     5: ZJ_Lizhu_count  :=Public_Basic.strToInt_lu(temp2[i]);
                     6: ZJ_suoliang    :=Public_Basic.strTodouble_lu(temp2[i]);
                     7: ZJ_toall_F:=Public_Basic.strTodouble_lu(temp2[i]);
                     8: ZJ_toall_P  :=Public_Basic.strTodouble_lu(temp2[i]);
                     9: ZJ_Hubang_h :=Public_Basic.strTodouble_lu(temp2[i]);
                     10: ZJ_Hubang_p :=Public_Basic.strTodouble_lu(temp2[i]);
                     11: Zj_Lz_Diameter:= Public_Basic.strTodouble_lu(temp2[i]);
                  end;
             end; //endfor
              temp1:=nil;temp2:=nil;
              //拆分支架最大高度与最小高度
              temp2:=Public_Basic.split(ZJ_Name,'/',Count2);
              if Count2>2 then    begin
                 ZJ_Min_h :=Public_Basic.StrTodouble_lu(Trim(temp2[1]));
                 ZJ_Max_h :=ZJ_min_h+ ZJ_suoliang;

              end;
              if Trim(ZJ_Name)<> '单体' then   begin

                       if ZJ_Zhongxinju=0  then //判断支架中心距
                         begin
                           Result:=False;
                           sEorr:=sEorr+'支架中心距/';
                          end;
                       if ZJ_KongDingJU=0  then  // 判断支架控顶距
                         begin
                           Result:=False;
                           sEorr:=sEorr+'支架控顶距/';
                         end;
                       if Zj_Hlzyd=0  then  // 判断支架合力作用点
                         begin
                           Result:=False;
                           sEorr:=sEorr+'合力作用点/';
                         end;
              end; //end    if Trim(ZJ_Name)<> '单体' then   begin
         except
              Result:=False;
              sEorr:='数据格式有误/';
              exit;
       end;
         zhiJia_F_xs :=1;   // 支架支护强度修订系数
         zhijia_L_xs :=1;; // 支架缩量修订系数
         zhijia_hb_Q_xs :=1;// 支架护帮强度修订系数

   end;

   //  拆分传入支架结构参数
 function TZJ_Class.SpliJG(str:widestring;out sEorr:widestring):WordBool;
  var
           temp1 :Str_Dt_array;
           i,Count1:integer;
  begin
        Result:=true;
        sEorr:='支架拆分成功!';
      try
            temp1:=Public_Basic.split(str,',',Count1);
         if count1<11 then
               begin
               Result:=False;
               sEorr:='请仔细检查文件!';
               exit;
              end;
         for i :=low(temp1) to high(temp1) do
           begin
                  if length(temp1[i])=0 then continue;
                  case i of
                     0: self.JG_jx   :=Trim(temp1[i]);
                     1: self.JG_Dl   :=Trim(temp1[i]);
                     2: self.JG_Dz   :=Trim(temp1[i]);
                     3: self.JG_slg  :=Trim(temp1[i]);
                     4: self.JG_ty   :=Trim(temp1[i]);
                     5: self.JG_Fm   :=Trim(temp1[i]);
                     6: self.JG_Wl   :=Trim(temp1[i]);
                     7: self.JG_Qc   :=Trim(temp1[i]);
                     8: self.JG_Ct   :=Trim(temp1[i]);
                     9: self.JG_Dt   :=Trim(temp1[i]);
                     10: self.JG_Ql  :=Trim(temp1[i]);

                  end;

             end; //endfor
         except
              Result:=False;
              sEorr:='数据格式有误/';
              exit;
        end;  //end try
         if Trim(self.JG_Dl)='DL1' then  //铰接顶梁
           begin
                 if  self.Zj_JiSuan_Ci_F[0]>=10000 then   begin
                      if  JG_jx='JX1' then   begin
                          self.ZJ_JianYi_Type:='112';
                      end else if  JG_jx='JX2' then begin
                          self.ZJ_JianYi_Type:='122';
                      end; //endif JG_jx='JX1'
                 end else begin
                      if  JG_jx='JX1' then   begin
                          self.ZJ_JianYi_Type:='212';
                      end else if  JG_jx='JX2' then begin
                          self.ZJ_JianYi_Type:='222';
                      end; //endif JG_jx='JX1'
                 end;  //  if  self.Zj_JiSuan_Ci_F[0]>=10000
           end else begin //esle if Trim(self.JG_Dl)='DL1' then  // 整体
                  if  self.Zj_JiSuan_Ci_F[0]>=10000 then   begin
                      if  JG_jx='JX1' then   begin
                          self.ZJ_JianYi_Type:='111';
                      end else if  JG_jx='JX2' then begin
                          self.ZJ_JianYi_Type:='121';
                      end; //endif JG_jx='JX1'
                 end else begin
                      if  JG_jx='JX1' then   begin
                          self.ZJ_JianYi_Type:='211';
                      end else if  JG_jx='JX2' then begin
                          self.ZJ_JianYi_Type:='221';
                      end; //endif JG_jx='JX1'
                 end;  //  if  self.Zj_JiSuan_Ci_F[0]>=10000

           end;  //end if  Trim(self.JG_Dl)='DL1'



        //单绞点 单摆杆
            if  JG_jx='JX3' then   begin
                self.ZJ_JianYi_Type:='JX3';
            end else if  JG_jx='JX4' then   begin
                self.ZJ_JianYi_Type:='JX4';
            end;

   end;
   //读取支架的系数
  function TZJ_Class.ReadZhijia_XS(gzm:TG_Stope;Zk:Tzk_bore;imm:TImmediate_roof;old:Told_roof):WideString; //计算支架参sh
   var
      pIniFile:     TIniFile;
      i:integer;
      in_Zj_DBFD_xs:  array [1..4] of array[1..9] of double;// 保存不同类别的 参数
      ZhijiaXiu_count:integer;
   begin
          if not FileExists(OcxPath +'\ZhijiaCs_lulei.dat') then   begin
              pIniFile := Tinifile.create(OcxPath+'\ZhijiaCs_lulei.dat');
                 // I
                  in_Zj_DBFD_xs[1][1] :=0.25;
                  in_Zj_DBFD_xs[1][2] :=0.5;
                  in_Zj_DBFD_xs[1][3] :=0.5;
                  in_Zj_DBFD_xs[1][4] :=1;
                  in_Zj_DBFD_xs[1][6] :=0.3;
                  in_Zj_DBFD_xs[1][7] :=0.6;
                  in_Zj_DBFD_xs[1][8] :=0.6;
                  in_Zj_DBFD_xs[1][9] :=1.1;


                   // II

                  in_Zj_DBFD_xs[2][1] :=0.25;
                  in_Zj_DBFD_xs[2][2] :=0.5;
                  in_Zj_DBFD_xs[2][3] :=0.5;
                  in_Zj_DBFD_xs[2][4] :=0.8;
                  in_Zj_DBFD_xs[2][6] :=0.4;
                  in_Zj_DBFD_xs[2][7] :=0.6;
                  in_Zj_DBFD_xs[2][8] :=0.6;
                  in_Zj_DBFD_xs[2][9] :=1;

                   // III
                  in_Zj_DBFD_xs[3][1] :=0.1;
                  in_Zj_DBFD_xs[3][2] :=0.3;
                  in_Zj_DBFD_xs[3][3] :=0.6;
                  in_Zj_DBFD_xs[3][4] :=1;
                  in_Zj_DBFD_xs[3][6] :=0.2;
                  in_Zj_DBFD_xs[3][7] :=0.4;
                  in_Zj_DBFD_xs[3][8] :=0.6;
                  in_Zj_DBFD_xs[3][9] :=1;


                  // IV
                  in_Zj_DBFD_xs[4][1] :=0.2;
                  in_Zj_DBFD_xs[4][2] :=0.5;
                  in_Zj_DBFD_xs[4][3] :=0.6;
                  in_Zj_DBFD_xs[4][4] :=1;
                  in_Zj_DBFD_xs[4][6] :=0.2;
                  in_Zj_DBFD_xs[4][7] :=0.4;
                  in_Zj_DBFD_xs[4][8] :=0.6;
                  in_Zj_DBFD_xs[4][9] :=1;

              pIniFile.Free;
          end else begin
                  pIniFile := Tinifile.create(OcxPath+'\ZhijiaCs_lulei.dat');
                  for I := 1 to 9 do  begin
                     // I
                     if i=5 then   continue;
                     in_Zj_DBFD_xs[1][i]:=pIniFile.ReadFloat('I',IntToStr(i),0);
                        // II
                     in_Zj_DBFD_xs[2][i]:=pIniFile.ReadFloat('II',IntToStr(i),0);
                        // III
                     in_Zj_DBFD_xs[3][i]:=pIniFile.ReadFloat('III',IntToStr(i),0);
                        // III
                     in_Zj_DBFD_xs[4][i]:=pIniFile.ReadFloat('IV',IntToStr(i),0);
                  end;
              pIniFile.Free;
          end;
          //  自助检索
           //判断规则：
           if old.Old_leibie<3 then  begin
                ZhijiaXiu_count:=1;
           end else if old.Old_leibie =3 then  begin
                ZhijiaXiu_count:=2;
           end else begin
                ZhijiaXiu_count:=3;
           end;

            if gzm.S_mcsd_h< 200 then  begin
                ZhijiaXiu_count:=4;
            end;


           for I := 1 to 9 do begin

               Zj_DBFD_xs[i]:=in_Zj_DBFD_xs[ZhijiaXiu_count][i];


           end;
   end;

 //计算支架基本参数
   function TZJ_Class.Cal_Sup_Para(gzm:TG_Stope;Zk:Tzk_bore;imm:TImmediate_roof;old:Told_roof):WideString;
   var
     Imm_F     :double ; //支架支撑直接顶的力
     Imm_P     :double;  //支架支撑直接顶的压强
     Imm_f_z   :double; //直接顶的悬顶系数
     Imm_ls    :double;//直接顶的悬顶距离
     Old_C0_F  :array[0..2] of double; // 老顶初次来压时支架的受力  0  最大值 1 最小值 2 平均值
     Old_Ci_F  :array[0..2] of double;  // 老顶周期来压时支架的受力  0  最大值 1 最小值 2 平均值
     Old_C0_L  :array[0..2] of double; // 老顶初次来压时支架的缩量   0  最大值 1 最小值 2 平均值
     Old_Ci_L  :array[0..2] of double;  // 老顶周期来压时支架的缩量  0  最大值 1 最小值 2 平均值
     YLFDXS    : double;//不同结构下岩梁的分担系数
     sResult   :WideString;//返回结果值
     MBphgd_t  :array[0..5] of Double ;//'(0)为剪切滑移面，(1)为内摩擦角计算,(2)为压杆计算,(3)为煤体自身能力 ,(4)支架工作阻力方式计算
     ZjGzzu    :double; //计算用支架的工作阻力
     Q1,Q2,Q3,Q0:double;// 计算互帮强度所需连是变量 Q1 直接顶的载荷 Q2 前方支撑压力的载荷 Q3 老顶通过基本顶传递的载荷  Q0 煤壁承担载荷
     i:integer;
   begin
      //单体支架另行处理
      if Trim(ZJ_Name)= '单体' then   begin
        Exit;
      end;
      //验证支架是否被初始化
      if length(Trim(Zj_XingHao))<1 then  begin   //验证支架是否被初始化
          ZJ_Zhongxinju:=1.5 ;//给支架中心距赋默认值
          ZJ_KongdingJu:=5 ;//给支架控顶距赋默认值
          ZJ_hlzyd:=3 ;//给支架合作作用点赋默认值

      end; //end  length(Trim(Zj_XingHao))>0
       //初始化支架修订参数
        self.DzXd_Cal_sup_para(gzm,zk,imm,old);
        //读取文件
        self.ReadZhijia_XS(gzm,zk,imm,old);
      //计算支架的悬顶系数
      if gzm.S_Fm_h> 1 then  begin   //20150506 edit
          Imm_ls:=0;
      end else begin
             if Imm.Immroof_C0*0.3>ZJ_Kongdingju then  begin  //判断支架控顶距与直接顶周期跨落的关系
                  if Imm.Immroof_C0*0.3- ZJ_Kongdingju > gzm.S_Cg_h then  begin
                     Imm_ls:=(gzm.S_Cg_h)+ imm.Immroof_M/2*tan(30/180*3.14159);
                  end else begin
                     Imm_ls:=( Imm.Immroof_C0*0.3- ZJ_Kongdingju)+ imm.Immroof_M/2*tan(30/180*3.14159);
                  end;
             end else begin
                  Imm_ls:=imm.Immroof_M/2*tan(30/180*3.14159);
             end;
      end;



       Imm_f_z :=ZJ_KongDingJu*Power(1*Imm_ls/ZJ_Kongdingju,2)/2/ZJ_hlzyd;
       //计算支架支撑直接顶的需要的力
         //201505060edit
         if gzm.S_Fm_h> 1 then  begin   //20150506 edit
            Imm_P:= Imm.Immroof_M *25 * Imm_f_z/ZJ_KongDingJu*(ZJ_KongDingJu-gzm.S_Fm_h*tan(30/180*3.14159));          //  直接顶的压强
         end else begin
            Imm_P:= Imm.Immroof_M *25 * Imm_f_z;          //  直接顶的压强
         end;

         Imm_F:= ZJ_Kongdingju * ZJ_ZhongxinJu *Imm_P ;
         zj_imm_p:=Imm_P/1000;
         {
           2013年12月为郑州煤机厂制定如下系数准则：
           （1）当有内应力场， 是单岩梁结构，考虑支架的让压作用  在初次来压阶段  系数暂定为 0.25 ，在周期来压阶段 系数暂定为 0.5
                                多岩梁结构，考虑支架的支撑作用  在初次来压阶段  系数暂定为 0.5 ，在周期来压阶段 系数暂定为 0.8
           （2）当无内应力场， 是单岩梁结构，考虑支架的让压作用  在初次来压阶段  系数暂定为 0.4 ，在周期来压阶段 系数暂定为 0.6
                                多岩梁结构，考虑支架的支撑作用  在初次来压阶段  系数暂定为 0.6 ，在周期来压阶段 系数暂定为 1

         }
       //判断内应立场的作用
       if gzm.ZCYL_s0>1 then   begin        //     1----  有内应力场
            if old.YL_struc =1 then begin   //   begin  2----单岩梁结构
                //老顶初次来压
                        //压力
                        YLFDXS :=Zj_DBFD_xs[1];
                        Old_C0_F[0] :=Imm_F+ old.YL_max_m*old.YL_First_step[0]*25*Zj_zhongxinju*YLFDXS;    //阻力最大值
                        YLFDXS :=Zj_DBFD_xs[1];
                        Old_C0_F[1] := Imm_F+old.YL_min_m *old.YL_First_step[1]*25* Zj_zhongxinju*YLFDXS;  //阻力最小值
                        YLFDXS :=Zj_DBFD_xs[1];
                        Old_C0_F[2] := Imm_F+old.YL_min_m *old.YL_First_step[2]*25* Zj_zhongxinju*YLFDXS;  //阻力平均值
                        //缩量
                        Old_C0_L[0] :=(gzm.S_Cg_h+gzm.S_Fm_h)*(gzm.ZCYL_s0+ZJ_hlzyd)/old.YL_First_step[1];  //缩量最大值
                        Old_C0_L[1] :=(gzm.S_Cg_h+gzm.S_Fm_h)*(gzm.ZCYL_s0+ZJ_hlzyd)/old.YL_First_step[0];  //缩量最 小值
                        Old_C0_L[2] :=(gzm.S_Cg_h+gzm.S_Fm_h)*(gzm.ZCYL_s0+ZJ_hlzyd)/old.YL_First_step[2];  //缩量平均值

                //老顶周期来压
                        YLFDXS :=Zj_DBFD_xs[2];
                        Old_Ci_F[0] :=Imm_F+ old.YL_max_m*old.YL_First_step[0]*25*Zj_zhongxinju*YLFDXS*0.408;    //阻力最大值
                        YLFDXS :=Zj_DBFD_xs[2];
                        Old_Ci_F[1] := Imm_F+old.YL_min_m *old.YL_First_step[1]*25* Zj_zhongxinju*YLFDXS*0.408;  //阻力最小值
                        YLFDXS :=Zj_DBFD_xs[2];
                        Old_Ci_F[2] := Imm_F+old.YL_min_m *old.YL_First_step[2]*25* Zj_zhongxinju*YLFDXS*0.408;  //阻力平均值

                         //缩量
                        Old_Ci_L[0] :=(gzm.S_Cg_h+gzm.S_Fm_h)*(gzm.ZCYL_s0+ZJ_hlzyd)/(old.YL_First_step[1]*0.408);  //缩量最大值
                        Old_Ci_L[1] :=(gzm.S_Cg_h+gzm.S_Fm_h)*(gzm.ZCYL_s0+ZJ_hlzyd)/(old.YL_First_step[0]*0.408);  //缩量最小值
                        Old_Ci_L[2] :=(gzm.S_Cg_h+gzm.S_Fm_h)*(gzm.ZCYL_s0+ZJ_hlzyd)/(old.YL_First_step[2]*0.408);  //缩量平均值


               end else begin // else 2         //多岩梁结构

                      //老顶初次来压
                        //压力
                        YLFDXS :=Zj_DBFD_xs[3];
                        Old_C0_F[0] :=Imm_F+ old.YL_max_m*old.YL_First_step[0]*25*Zj_zhongxinju*YLFDXS;    //阻力最大值
                        YLFDXS :=Zj_DBFD_xs[3];
                        Old_C0_F[1] := Imm_F+old.YL_min_m *old.YL_First_step[1]*25* Zj_zhongxinju*YLFDXS;  //阻力最小值
                        YLFDXS :=Zj_DBFD_xs[3];
                        Old_C0_F[2] := Imm_F+old.YL_min_m *old.YL_First_step[2]*25* Zj_zhongxinju*YLFDXS;  //阻力平均值
                        //缩量
                        Old_C0_L[0] :=(gzm.S_Cg_h+gzm.S_Fm_h)*(gzm.ZCYL_s0+ZJ_hlzyd)/old.YL_First_step[1];  //缩量最大值
                        Old_C0_L[1] :=(gzm.S_Cg_h+gzm.S_Fm_h)*(gzm.ZCYL_s0+ZJ_hlzyd)/old.YL_First_step[0];  //缩量最 小值
                        Old_C0_L[2] :=(gzm.S_Cg_h+gzm.S_Fm_h)*(gzm.ZCYL_s0+ZJ_hlzyd)/old.YL_First_step[2];  //缩量平均值

                    //老顶周期来压
                        YLFDXS :=Zj_DBFD_xs[4];
                        Old_Ci_F[0] :=Imm_F+ old.YL_max_m*old.YL_First_step[0]*25*Zj_zhongxinju*YLFDXS*0.408;    //阻力最大值
                        YLFDXS :=Zj_DBFD_xs[4];
                        Old_Ci_F[1] := Imm_F+old.YL_min_m *old.YL_First_step[1]*25* Zj_zhongxinju*YLFDXS*0.408;  //阻力最小值
                        YLFDXS :=Zj_DBFD_xs[4];
                        Old_Ci_F[2] := Imm_F+old.YL_min_m *old.YL_First_step[2]*25* Zj_zhongxinju*YLFDXS*0.408;  //阻力平均值

                         //缩量
                        Old_Ci_L[0] :=(gzm.S_Cg_h+gzm.S_Fm_h)*(gzm.ZCYL_s0+ZJ_hlzyd)/(old.YL_First_step[1]*0.408);  //缩量最大值
                        Old_Ci_L[1] :=(gzm.S_Cg_h+gzm.S_Fm_h)*(gzm.ZCYL_s0+ZJ_hlzyd)/(old.YL_First_step[0]*0.408);  //缩量最小值
                        Old_Ci_L[2] :=(gzm.S_Cg_h+gzm.S_Fm_h)*(gzm.ZCYL_s0+ZJ_hlzyd)/(old.YL_First_step[2]*0.408);  //缩量平均值



                end;    //  end 2
       end else begin            //无内应立场
               if old.YL_struc =1 then begin   //    单岩梁结构    begin  3
                //老顶初次来压
                        //压力
                        YLFDXS :=Zj_DBFD_xs[6];
                        Old_C0_F[0] := Imm_F+ old.YL_max_m *old.YL_First_step[0]*25* Zj_zhongxinju*YLFDXS;    //阻力最大值
                        YLFDXS :=Zj_DBFD_xs[6];
                        Old_C0_F[1] := Imm_F+ old.YL_min_m *old.YL_First_step[1]*25* Zj_zhongxinju*YLFDXS;  //阻力最小值
                        YLFDXS :=Zj_DBFD_xs[6];
                        Old_C0_F[2] := Imm_F+ old.YL_min_m *old.YL_First_step[2]*25* Zj_zhongxinju*YLFDXS;  //阻力平均值
                        //缩量
                        Old_C0_L[0] :=(gzm.S_Cg_h+gzm.S_Fm_h)*(gzm.ZCYL_s0+ZJ_hlzyd)/old.YL_First_step[1];  //缩量最大值
                        Old_C0_L[1] :=(gzm.S_Cg_h+gzm.S_Fm_h)*(gzm.ZCYL_s0+ZJ_hlzyd)/old.YL_First_step[0];  //缩量最 小值
                        Old_C0_L[2] :=(gzm.S_Cg_h+gzm.S_Fm_h)*(gzm.ZCYL_s0+ZJ_hlzyd)/old.YL_First_step[2];  //缩量平均值

                //老顶周期来压
                        YLFDXS :=Zj_DBFD_xs[7];
                        Old_Ci_F[0] :=Imm_F+ old.YL_max_m*old.YL_First_step[0]*25*Zj_zhongxinju*YLFDXS*0.408;    //阻力最大值
                        YLFDXS :=Zj_DBFD_xs[7];
                        Old_Ci_F[1] := Imm_F+old.YL_min_m *old.YL_First_step[1]*25* Zj_zhongxinju*YLFDXS*0.408;  //阻力最小值
                        YLFDXS :=Zj_DBFD_xs[7];
                        Old_Ci_F[2] := Imm_F+old.YL_min_m *old.YL_First_step[2]*25* Zj_zhongxinju*YLFDXS*0.408;  //阻力平均值

                         //缩量
                        Old_Ci_L[0] :=(gzm.S_Cg_h+gzm.S_Fm_h)*(gzm.ZCYL_s0+ZJ_hlzyd)/(old.YL_First_step[1]*0.408);  //缩量最大值
                        Old_Ci_L[1] :=(gzm.S_Cg_h+gzm.S_Fm_h)*(gzm.ZCYL_s0+ZJ_hlzyd)/(old.YL_First_step[0]*0.408);  //缩量最小值
                        Old_Ci_L[2] :=(gzm.S_Cg_h+gzm.S_Fm_h)*(gzm.ZCYL_s0+ZJ_hlzyd)/(old.YL_First_step[2]*0.408);  //缩量平均值


               end else begin // //多岩梁结构        else 3

                      //老顶初次来压
                        //压力
                        YLFDXS :=Zj_DBFD_xs[8];
                        Old_C0_F[0] :=Imm_F+ old.YL_max_m*old.YL_First_step[0]*25*Zj_zhongxinju*YLFDXS;    //阻力最大值
                        YLFDXS :=Zj_DBFD_xs[8];
                        Old_C0_F[1] := Imm_F+old.YL_min_m *old.YL_First_step[1]*25* Zj_zhongxinju*YLFDXS;  //阻力最小值
                        YLFDXS :=Zj_DBFD_xs[8];
                        Old_C0_F[2] := Imm_F+old.YL_min_m *old.YL_First_step[2]*25* Zj_zhongxinju*YLFDXS;  //阻力平均值
                        //缩量
                        Old_C0_L[0] :=(gzm.S_Cg_h+gzm.S_Fm_h)*(gzm.ZCYL_s0+ZJ_hlzyd)/old.YL_First_step[1];  //缩量最大值
                        Old_C0_L[1] :=(gzm.S_Cg_h+gzm.S_Fm_h)*(gzm.ZCYL_s0+ZJ_hlzyd)/old.YL_First_step[0];  //缩量最 小值
                        Old_C0_L[2] :=(gzm.S_Cg_h+gzm.S_Fm_h)*(gzm.ZCYL_s0+ZJ_hlzyd)/old.YL_First_step[2];  //缩量平均值

                    //老顶周期来压
                        YLFDXS :=Zj_DBFD_xs[9];
                        Old_Ci_F[0] :=Imm_F+ old.YL_max_m*old.YL_First_step[0]*25*Zj_zhongxinju*YLFDXS*0.408;    //阻力最大值
                        YLFDXS :=Zj_DBFD_xs[9];
                        Old_Ci_F[1] := Imm_F+old.YL_min_m *old.YL_First_step[1]*25* Zj_zhongxinju*YLFDXS*0.408;  //阻力最小值
                        YLFDXS :=Zj_DBFD_xs[9];
                        Old_Ci_F[2] := Imm_F+old.YL_min_m *old.YL_First_step[2]*25* Zj_zhongxinju*YLFDXS*0.408;  //阻力平均值

                         //缩量
                        Old_Ci_L[0] :=(gzm.S_Cg_h+gzm.S_Fm_h)*(gzm.ZCYL_s0+ZJ_hlzyd)/(old.YL_First_step[1]*0.408);  //缩量最大值
                        Old_Ci_L[1] :=(gzm.S_Cg_h+gzm.S_Fm_h)*(gzm.ZCYL_s0+ZJ_hlzyd)/(old.YL_First_step[0]*0.408);  //缩量最小值
                        Old_Ci_L[2] :=(gzm.S_Cg_h+gzm.S_Fm_h)*(gzm.ZCYL_s0+ZJ_hlzyd)/(old.YL_First_step[2]*0.408);  //缩量平均值



            end;      //end 3

       end;  //end   if gzm.ZCYL_s0<1    end  1
        //给类里面的压力与压强赋值
        Zj_jisuan_C0_F[0]:=Old_C0_F[0]*zhiJia_F_xs; Zj_jisuan_C0_F[1]:=Old_C0_f[1]*zhiJia_F_xs;  Zj_jisuan_C0_F[2]:=Old_C0_f[2]*zhiJia_F_xs;  //最大  最小 平均
        Zj_jisuan_Ci_F[0]:=Old_Ci_F[0]*zhiJia_F_xs; Zj_jisuan_Ci_F[1]:=Old_Ci_f[1]*zhiJia_F_xs;  Zj_jisuan_Ci_F[2]:=Old_Ci_f[2]*zhiJia_F_xs;  //最大  最小 平均
        // 强制处理  20160506
         if  Zj_jisuan_C0_F[2]>22000 then
              for I := 0 to 2 do
                 Zj_jisuan_C0_F[i]:=Zj_jisuan_C0_F[i]*(22000/Zj_jisuan_C0_F[2]);


          if  Zj_jisuan_Ci_F[2]>18000 then
               for I := 0 to 2 do
                 Zj_jisuan_Ci_F[i]:=Zj_jisuan_Ci_F[i]*(18000/Zj_jisuan_Ci_F[2]);

          if  gzm.S_Fm_h>0 then begin
            for I := 0 to 2 do
             begin
                       Zj_jisuan_C0_F[i]:=Zj_jisuan_C0_F[i]*(1-gzm.S_Fm_h/(gzm.S_Fm_h+gzm.S_Cg_h));
                       Zj_jisuan_Ci_F[i]:=Zj_jisuan_Ci_F[i]*(1-gzm.S_Fm_h/(gzm.S_Fm_h+gzm.S_Cg_h));

             end;

         end;

         //===============================20150506
        //支架的支护强度 初次
        Zj_jisuan_C0_p[0]:= Zj_jisuan_C0_F[0]/zj_kongdingju/zj_zhongxinju/1000;
           zj_old_C0_p[0]:= Zj_jisuan_C0_p[0]-zj_imm_p;
        Zj_jisuan_C0_p[1]:= Zj_jisuan_C0_F[1]/zj_kongdingju/zj_zhongxinju/1000;
           zj_old_C0_p[1]:= Zj_jisuan_C0_p[1]-zj_imm_p;
        Zj_jisuan_C0_p[2]:= Zj_jisuan_C0_F[2]/zj_kongdingju/zj_zhongxinju/1000;
           zj_old_C0_p[2]:= Zj_jisuan_C0_p[2]-zj_imm_p;
         //支架的支护强度  周期
        Zj_jisuan_Ci_p[0]:= Zj_jisuan_Ci_F[0]/zj_kongdingju/zj_zhongxinju/1000;
            zj_old_Ci_p[0]:= Zj_jisuan_Ci_p[0]-zj_imm_p;
        Zj_jisuan_Ci_p[1]:= Zj_jisuan_Ci_F[1]/zj_kongdingju/zj_zhongxinju/1000;
            zj_old_Ci_p[1]:= Zj_jisuan_Ci_p[1]-zj_imm_p;
        Zj_jisuan_Ci_p[2]:= Zj_jisuan_Ci_F[2]/zj_kongdingju/zj_zhongxinju/1000;
            zj_old_Ci_p[2]:= Zj_jisuan_Ci_p[2]-zj_imm_p;

        //支架的缩量
        Zj_jisuan_sl[0]:=Old_Ci_L[0]*zhiJia_L_xs;
        Zj_jisuan_sl[1]:=Old_Ci_L[1]*zhiJia_L_xs;
        Zj_jisuan_sl[2]:=Old_Ci_L[2]*zhiJia_L_xs;
       //====================以下为计算煤壁片帮的数据
         //(0)为剪切滑移面计算
            MBphgd_t[0] := Tan((45 + gzm.S_M_mcj / 2) / 180 * 3.14159) * gzm.ZCYL_s1[0];
         //(1)为内摩擦角计算
            MBphgd_t[1] := Tan(gzm.S_M_mcj / 180 * 3.14159) * gzm.ZCYL_s1[0];
         //(2)为压杆计算
            MBphgd_t[2] := 0.35 * gzm.S_Cg_h;
         //(3)煤体自身能力计算
            MBphgd_t[3] := 2 * gzm.S_M_njl * Tan((45 + gzm.S_M_mcj / 2) / 180 * 3.14159) / 15000;
        // (4) 支架工作状态煤体高度计算

            if Zj_toall_F<100 then  begin    //该处处理主要为防止支架录入数值太小，进行的异常处理
                 ZjGzzu:=Zj_jisuan_ci_p[2]; //使用平均值进行计算
            end else begin
                 ZjGzzu:=Zj_toall_p;
            end;

            MBphgd_t[4]:= Sqr(gzm.S_M_njl* gzm.S_M_njl * 4 - 2 * ZjGzzu * 1000 * Tan((45 - gzm.S_M_mcj / 2) / 180 * 3.14159));
            if MBphgd_t[1]> gzm.S_Cg_h/2 then MBphgd_t[1]:=0.5*gzm.S_Cg_h;
            if MBphgd_t[4]> gzm.S_Cg_h/2 then MBphgd_t[4]:=0.5*gzm.S_Cg_h;
        //给支架的互帮高度赋值
           zj_jisuan_hubang_h[0]:=MBphgd_t[0];  //   //(0)为剪切滑移面计算
           zj_jisuan_hubang_h[1]:=MBphgd_t[1];  //   //(1)为内摩擦角计算
           zj_jisuan_hubang_h[2]:=MBphgd_t[2];       //(2)为压杆计算
           zj_jisuan_hubang_h[3]:=MBphgd_t[3];       //(3)煤体自身能力计算
           zj_jisuan_hubang_h[4]:=MBphgd_t[4];       // (4) 支架工作状态煤体高度计算
       //煤壁互帮强度计算
           Q1:= Imm_P;
           if(gzm.ZCYL_s1[0]=0) then begin
                  Q2:= gzm.ZCYL_s0 * gzm.ZCYL_s0 / 2 * gzm.S_K_zcfz * gzm.S_Cg_h * 25 ;
           end else begin
                  Q2:= gzm.ZCYL_s0 * gzm.ZCYL_s0 / 2 / gzm.ZCYL_s1[0]   * gzm.S_K_zcfz * gzm.S_Cg_h * 25 ;
           end;


           Q3:= old.YL_max_m*old.YL_First_step[0]*25*Zj_zhongxinju*0.5*0.3;
           Q0:=Q1+Q2+Q3-ZjGzzu*1000*Zj_zhongxinju*zj_kongdingju*cos(70.0/180*3.1415926);
           if Q0<0 then  Q0:=0;      //强制处理
           if Q0>500 then  Q0:=500;  //强制处理
           
             Zj_jisuan_hubang_p[2]:=(Q0+0.5*gzm.ZCYL_s0*MBphgd_t[2]*15)/1000/MBphgd_t[2]*self.zhijia_hb_Q_xs;
             //Zj_jisuan_hubang_p[2]:=0.12;

   end;
    //---------------------------------
 function TZJ_Class.DzXd_Cal_sup_para(gzm:TG_Stope;Zk:Tzk_bore;imm:TImmediate_roof;old:Told_roof):WideString; //  根据地质条件修订支架的基本参数
  var
     s_out:widestring;
     Yl_stuct:integer;
     imm_m,Imm_c0,old_h_Max,Old_h_Min,old_l_max,old_l_min,Old_l_avg:double;
  begin
     //根据地质条件修订地质参数
      zhiJia_F_xs:=1;zhijia_L_xs:=1; //初始化系数
      if  gzm.S_cmfs='4' then begin       //采煤方式  放顶煤
          zhiJia_F_xs:=zhiJia_F_xs*1; //阻力修订系数
          zhijia_L_xs:=zhijia_L_xs *1.1;// 缩量修订系数
          zhijia_hb_Q_xs:= zhijia_hb_Q_xs*1.05;// 护帮强度修订
      end;
      //修改值保存
      yL_stuct:=old.YL_struc;
      imm_m:=imm.Immroof_M;
      imm_c0:=imm.Immroof_C0 ;
      old_h_max:=old.YL_max_m ;
      old_h_min:=old.YL_min_m ;
      old_l_max:= old.YL_First_step[0] ;
      old_l_min:= old.YL_First_step[1] ;
      old_l_avg:= old.YL_First_step[2] ;

      imm.init(gzm,zk,0.5,s_out);    //初始化直接顶
      old.init(gzm,zk,imm,s_out);  //初始化老顶
     // cal_zcyl(zk,imm,gzm,old,s_out);     //计算支撑压力
     // cal_ldg(zk,gzm,imm,200,s_out);  ;     //计算裂断拱
      //数值更替回来        
      old.YL_struc     :=yL_stuct;
      imm.Immroof_M  :=imm_m ;
      imm.Immroof_C0 :=imm_c0 ;
      old.YL_max_m     :=old_h_min ;
      old.YL_First_step[0] :=old_l_max ;
      old.YL_First_step[1] :=old_l_min;
      old.YL_First_step[2] :=old_l_avg  ;

      if  gzm.Dz_yxfx = 1 then begin       //仰斜
          zhiJia_F_xs:=zhiJia_F_xs*1.05; //阻力修订系数
          zhijia_L_xs:=zhijia_L_xs *0.95;// 缩量修订系数
          zhijia_hb_Q_xs:= zhijia_hb_Q_xs*1.1;// 护帮强度修订
      end else if gzm.Dz_yxfx = 2 then begin                          // 俯斜
          zhiJia_F_xs:=zhiJia_F_xs*0.95; //阻力修订系数
          zhijia_L_xs:=zhijia_L_xs *1.05;// 缩量修订系数
          zhijia_hb_Q_xs:= zhijia_hb_Q_xs*0.95;// 护帮强度修订
      end;

      if  gzm.Dz_JYHD  =1 then begin       //基岩厚度    薄基岩
          zhiJia_F_xs:=zhiJia_F_xs*3; //阻力修订系数
          zhijia_L_xs:=zhijia_L_xs *1;// 缩量修订系数
          zhijia_hb_Q_xs:= zhijia_hb_Q_xs*1.05;// 护帮强度修订
      end else if gzm.Dz_JYHD = 2 then begin            // 一般基岩
          zhiJia_F_xs:=zhiJia_F_xs*1.5; //阻力修订系数
          zhijia_L_xs:=zhijia_L_xs *1;// 缩量修订系数
          zhijia_hb_Q_xs:= zhijia_hb_Q_xs*1.05;// 护帮强度修订
      end;

      if  gzm.Dz_DCGZ  =1 then begin       //地质构造少
          zhiJia_F_xs:=zhiJia_F_xs*0.95; //阻力修订系数
          zhijia_L_xs:=zhijia_L_xs *1.05;   //
      end else if gzm.Dz_DCGZ >3  then begin            // 地址构造复杂
          zhiJia_F_xs:=zhiJia_F_xs*1.05; //阻力修订系数
          zhijia_L_xs:=zhijia_L_xs *1;// 缩量修订系数
          zhijia_hb_Q_xs:= zhijia_hb_Q_xs*1.05;// 护帮强度修订
      end;

      if  gzm.Dz_TopWater  =2  then begin       //顶板水
          zhiJia_F_xs:=zhiJia_F_xs*1.05; //阻力修订系数
          zhijia_L_xs:=zhijia_L_xs *1;   //
          zhijia_hb_Q_xs:= zhijia_hb_Q_xs*1.05;// 护帮强度修订
      end else if gzm.Dz_TopWater =4  then begin            //
          zhiJia_F_xs:=zhiJia_F_xs*1.05; //阻力修订系数
          zhijia_L_xs:=zhijia_L_xs *1;// 缩量修订系数
          zhijia_hb_Q_xs:= zhijia_hb_Q_xs*1.05;// 护帮强度修订
      end;

      if  gzm.Dz_BottomWater  =2  then begin       //底板水
          zhiJia_F_xs:=zhiJia_F_xs*0.95; //阻力修订系数
          zhijia_L_xs:=zhijia_L_xs *1;   //
      end else if gzm.Dz_BottomWater =4  then begin            //
          zhiJia_F_xs:=zhiJia_F_xs*0.95; //阻力修订系数
          zhijia_L_xs:=zhijia_L_xs *1;// 缩量修订系数
      end;

     
      if  gzm.Dz_Kyxx =3  then begin       //矿压现象
          zhiJia_F_xs:=zhiJia_F_xs*1.05; //阻力修订系数
          zhijia_L_xs:=zhijia_L_xs *1.05;   //
      end else if gzm.Dz_Kyxx =4  then begin            //
          zhiJia_F_xs:=zhiJia_F_xs*1.1; //阻力修订系数
          zhijia_L_xs:=zhijia_L_xs *1.05;// 缩量修订系数
          zhijia_hb_Q_xs:= zhijia_hb_Q_xs*1.05;// 护帮强度修订
      end;

      if  gzm.Dz_HangDaoSup =4  then begin       //巷道支护
          zhiJia_F_xs:=zhiJia_F_xs*0.95; //阻力修订系数
          zhijia_L_xs:=zhijia_L_xs *1.05;   //
      end else if gzm.Dz_HangDaoSup=5  then begin            //
          zhiJia_F_xs:=zhiJia_F_xs*0.9; //阻力修订系数
          zhijia_L_xs:=zhijia_L_xs *1.05;// 缩量修订系数
          zhijia_hb_Q_xs:= zhijia_hb_Q_xs*1.05;// 护帮强度修订
      end;

      if gzm.UP_Ckq =2 then  begin
         if gzm.UP_CKQ_JuLI < imm.Immroof_M then  begin
             imm.Immroof_M:=imm.Immroof_M+gzm.UP_CKQ_Kc_H*3;
         end else  if gzm.UP_CKQ_JuLI <gzm.Hg_ldg  then begin
             zhiJia_F_xs:=zhiJia_F_xs*1.1; //阻力修订系数
             zhijia_L_xs:=zhijia_L_xs *1;// 缩量修订系数
         end; 
      end;

     
  end;
    // //返回支架参数
 function TZJ_Class.Return_zj_Para(Version:WideString):WideString;   //返回支架参数
     var
         RStr:Widestring;
         i:integer;
     begin
       if Version='1.0'  then begin
             Rstr:='  老顶初次来压时:';
             for I := 0 to 2 do  begin    //组合工作阻力 单位KN
                if i<>2 then  begin
                   Rstr:=Rstr+ FormatFloat('0.0',zj_jisuan_c0_F[i])+'KN，';
                end else begin
                   Rstr:=Rstr+ FormatFloat('0.00',zj_jisuan_c0_F[i])+'KN；';
                end;

             end;
             for I := 0 to 2 do  begin    //组合工作强度 单位MPa
                if i<>2 then  begin
                   Rstr:=Rstr+ FormatFloat('0.0',zj_jisuan_c0_P[i])+'MPa，';
                end else begin
                   Rstr:=Rstr+ FormatFloat('0.00',zj_jisuan_c0_P[i])+'MPa。';
                end;

             end;

              Rstr:=Rstr+#13+'     老顶周期来压时:';
             for I := 0 to 2 do  begin    //组合工作阻力 单位KN
                if i<>2 then  begin
                   Rstr:=Rstr+ FormatFloat('0.0',zj_jisuan_ci_F[i])+'KN，';
                end else begin
                   Rstr:=Rstr+ FormatFloat('0.00',zj_jisuan_ci_F[i])+'KN；';
                end;

             end;
             for I := 0 to 2 do  begin    //组合工作强度 单位MPa
                if i<>2 then  begin
                   Rstr:=Rstr+ FormatFloat('0.0',zj_jisuan_ci_P[i])+'MPa，';
                end else begin
                   Rstr:=Rstr+ FormatFloat('0.00',zj_jisuan_ci_P[i])+'MPa。';
                end;

             end;
           {  Rstr:=Rstr+'护帮高度:';
              for I := 0 to 4 do  begin    //组合互帮高度 单位m
                if i<>4 then  begin
                   Rstr:=Rstr+ FormatFloat('0.0',zj_jisuan_hubang_H[i])+'m,';
                end else begin
                   Rstr:=Rstr+ FormatFloat('0.0',zj_jisuan_hubang_H[i])+'m#';
                end;

             end;
              Rstr:=Rstr+'护帮强度:';
              Rstr:=Rstr+ FormatFloat('0.0', Zj_jisuan_hubang_p[2])+'MPa#';
             }

       end; //end 1.0

      if Version='2.0'  then begin
          Rstr:='';
           for I := 0 to 2 do  begin    //组合工作阻力 单位KN
                if i<>2 then  begin
                   Rstr:=Rstr+ FormatFloat('0.0',zj_jisuan_c0_F[i])+',';
                end else begin
                   Rstr:=Rstr+ FormatFloat('0.00',zj_jisuan_c0_F[i])+';';
                end;

             end;
             for I := 0 to 2 do  begin    //组合工作强度 单位MPa
                if i<>2 then  begin
                   Rstr:=Rstr+ FormatFloat('0.0',zj_jisuan_c0_P[i])+',';
                end else begin
                   Rstr:=Rstr+ FormatFloat('0.00',zj_jisuan_c0_P[i])+';';
                end;

             end;


             for I := 0 to 2 do  begin    //组合工作阻力 单位KN
                if i<>2 then  begin
                   Rstr:=Rstr+ FormatFloat('0.0',zj_jisuan_ci_F[i])+',';
                end else begin
                   Rstr:=Rstr+ FormatFloat('0.00',zj_jisuan_ci_F[i])+';';
                end;

             end;
             for I := 0 to 2 do  begin    //组合工作强度 单位MPa
                if i<>2 then  begin
                   Rstr:=Rstr+ FormatFloat('0.0',zj_jisuan_ci_P[i])+',';
                end else begin
                   Rstr:=Rstr+ FormatFloat('0.00',zj_jisuan_ci_P[i])+';';
                end;

             end;

              for I := 0 to 4 do  begin    //组合互帮高度 单位m
                if i<>4 then  begin
                   Rstr:=Rstr+ FormatFloat('0.0',zj_jisuan_hubang_H[i])+',';
                end else begin
                   Rstr:=Rstr+ FormatFloat('0.0',zj_jisuan_hubang_H[i])+';';
                end;

             end;

               for I := 0 to 2 do  begin    //组合互帮强度 单位MPa
                if i<>2 then  begin
                   Rstr:=Rstr+ FormatFloat('0.0', Zj_jisuan_hubang_p[i])+',';
                end else begin
                    Rstr:=Rstr+ FormatFloat('0.0', Zj_jisuan_hubang_p[i])+';';
                end;

              end;


      end;  //end 2.0

       if Version='3.0'  then begin
                   Rstr:='';

                   Rstr:=Rstr+ FormatFloat('0.0',zj_jisuan_c0_F[2])+',';

                   Rstr:=Rstr+ FormatFloat('0.0',zj_jisuan_ci_F[2])+'';
       end;
       
       Result:=Rstr;
 end; //end function

 // 画支架
 
procedure TZJ_Class.Draw_zhiJia(Image:TImage;x1,y1,x2,y2,mc_h:double;lizhushu,jia_type:integer);// jia_type 1 综采  2 综放
 var
    zJ_H,zJ_w :double;
     Points: array[0..3] of TPoint;
     bitmap1:Tbitmap;//创建位图 bitmap1
 begin
  //=====================
   zj_w:=x2-x1;
    zj_h:=y2-y1;

    if jia_type=1  then begin    //综采支架
        //画底座    综采支架
        Image.Canvas.Pen.Width :=1;
        Image.Canvas.Pen.Color :=$000000;
        Image.Canvas.MoveTo(trunc(x1+zj_w/60*27),trunc(y2));
        Image.Canvas.LineTo(trunc(x2-zj_w/60*3),trunc(y2));
        Image.Canvas.LineTo(trunc(x2-zj_w/60*3),trunc(y2-zj_H/60*6)) ;
        Image.Canvas.LineTo(trunc(x2-zj_w/60*13),trunc(y2-zj_H/60*12)) ;
        Image.Canvas.LineTo(trunc(x2-zj_w/60*20),trunc(y2-zj_H/60*8)) ;
        Image.Canvas.LineTo(trunc(x1+zj_w/60*27),trunc(y2-zj_H/60*8)) ;
        Image.Canvas.LineTo(trunc(x1+zj_w/60*27),trunc(y2));
        //画背梁支撑  综采支架
        Image.Canvas.Pen.Width :=1;
        Image.Canvas.MoveTo(trunc(x2-zj_w/60*3),trunc(y2-zj_H/60*6)) ;
        Image.Canvas.LineTo(trunc(x2-zj_w/60*1),trunc(y2-zj_H/60*20)) ;
        Image.Canvas.LineTo(trunc(x2-zj_w/60*2),trunc(y2-zj_H/60*20)) ;
        Image.Canvas.LineTo(trunc(x2-zj_w/60*4),trunc(y2-zj_H/60*6)) ;

        Image.Canvas.MoveTo(trunc(x2-zj_w/60*13),trunc(y2-zj_H/60*12)) ;
        Image.Canvas.LineTo(trunc(x2-zj_w/60*6),trunc(y2-zj_H/60*30)) ;
        Image.Canvas.LineTo(trunc(x2-zj_w/60*5),trunc(y2-zj_H/60*28)) ;
        Image.Canvas.LineTo(trunc(x2-zj_w/60*12),trunc(y2-zj_H/60*11)) ;
        //画背梁   综采支架
        Image.Canvas.MoveTo(trunc(x2),trunc(y2-zj_H/60*20)) ;
        Image.Canvas.LineTo(trunc(x2-zj_w/60*13),trunc(y2-zj_H/60*58)) ;
        Image.Canvas.LineTo(trunc(x2-zj_w/60*15),trunc(y2-zj_H/60*56)) ;
        Image.Canvas.LineTo(trunc(x2-zj_w/60*2),trunc(y2-zj_H/60*18)) ;
        Image.Canvas.LineTo(trunc(x2),trunc(y2-zj_H/60*20)) ;
        ////画顶梁   综采支架
        Image.Canvas.MoveTo(trunc(x2-zj_w/60*12),trunc(y1)) ;
        Image.Canvas.LineTo(trunc(x2-zj_w/60*12),trunc(y1+zj_H/60*6)) ;
        Image.Canvas.LineTo(trunc(x2-zj_w/60*50),trunc(y1+zj_H/60*6)) ;
        Image.Canvas.LineTo(trunc(x2-zj_w/60*50),trunc(y1)) ;
        Image.Canvas.LineTo(trunc(x2-zj_w/60*12),trunc(y1)) ;

        if mc_h>2.5 then  begin
             //伸缩梁  综采支架
            Image.Canvas.MoveTo(trunc(x2-zj_w/60*50),trunc(y1+zj_H/30*1)) ;
            Image.Canvas.LineTo(trunc(x2-zj_w/60*51),trunc(y1)) ;
            Image.Canvas.LineTo(trunc(x2-zj_w/60*58),trunc(y1)) ;
            Image.Canvas.LineTo(trunc(x2-zj_w/60*58),trunc(y1+zj_H/30*2)) ;
            Image.Canvas.LineTo(trunc(x2-zj_w/60*50),trunc(y1+zj_H/30*2)) ;
            // //护帮  综采支架
            Image.Canvas.MoveTo(trunc(x2-zj_w/60*58),trunc(y1)) ;
            Image.Canvas.LineTo(trunc(x1),trunc(y1+zj_H/30*13)) ;
            Image.Canvas.LineTo(trunc(x1+zj_w/60*1),trunc(y1+zj_H/30*13)) ;
            Image.Canvas.LineTo(trunc(x2-zj_w/60*57),trunc(y1+zj_H/30*2)) ;

        end else begin
             //伸缩梁  综采支架
            Image.Canvas.MoveTo(trunc(x2-zj_w/60*50),trunc(y1+zj_H/30*1)) ;
            Image.Canvas.LineTo(trunc(x2-zj_w/60*51),trunc(y1)) ;
            Image.Canvas.LineTo(trunc(x1),trunc(y1)) ;
            Image.Canvas.LineTo(trunc(x1),trunc(y1+zj_H/30*2)) ;
            Image.Canvas.LineTo(trunc(x2-zj_w/60*50),trunc(y1+zj_H/30*2)) ;
        end;
         //立柱  综采支架
        if lizhushu=2 then  begin  // 两立柱   综采支架
           if mc_h>=4.0 then  begin  // 双伸缩  综采支架
                 // 下柱筒  综采支架
                 Points[0].X:=trunc(x2-zj_w/60*23);                  Points[0].Y:=trunc(y2-zj_H/60*8);
                 Points[1].X:=trunc(x2-zj_w/60*27);                  Points[1].Y:=trunc(y2-zj_H/60*28);
                 Points[2].X:=trunc(x2-zj_w/60*31);                  Points[2].Y:=trunc(y2-zj_H/60*28);
                 Points[3].X:=trunc(x2-zj_w/60*27);                  Points[3].Y:=trunc(y2-zj_H/60*8);
                 Image.canvas.Brush.Color:=$000000;
                 Image.canvas.Polygon(points);

                  // 中柱筒  综采支架
                 Points[0].X:=trunc(x2-zj_w/60*27.5);                  Points[0].Y:=trunc(y2-zj_H/60*28);
                 Points[1].X:=trunc(x2-zj_w/60*31.5);                  Points[1].Y:=trunc(y2-zj_H/60*46);
                 Points[2].X:=trunc(x2-zj_w/60*34.5);                  Points[2].Y:=trunc(y2-zj_H/60*46);
                 Points[3].X:=trunc(x2-zj_w/60*30.5);                  Points[3].Y:=trunc(y2-zj_H/60*28);
                 Image.canvas.Brush.Color:=$008000;
                 Image.canvas.Polygon(points);

                   // 上柱筒  综采支架
                 Points[0].X:=trunc(x2-zj_w/60*32);                  Points[0].Y:=trunc(y2-zj_H/60*46);
                 Points[1].X:=trunc(x2-zj_w/60*34);                  Points[1].Y:=trunc(y2-zj_H/60*54);
                 Points[2].X:=trunc(x2-zj_w/60*36);                  Points[2].Y:=trunc(y2-zj_H/60*54);
                 Points[3].X:=trunc(x2-zj_w/60*34);                  Points[3].Y:=trunc(y2-zj_H/60*46);
                 Image.canvas.Brush.Color:=$0000FF;
                 Image.canvas.Polygon(points);

            end else begin  // // 单伸缩   综采支架
                 Points[0].X:=trunc(x2-zj_w/60*23);                  Points[0].Y:=trunc(y2-zj_H/60*8);
                 Points[1].X:=trunc(x2-zj_w/60*27);                  Points[1].Y:=trunc(y2-zj_H/60*35);
                 Points[2].X:=trunc(x2-zj_w/60*31);                  Points[2].Y:=trunc(y2-zj_H/60*35);
                 Points[3].X:=trunc(x2-zj_w/60*27);                  Points[3].Y:=trunc(y2-zj_H/60*8);
                 Image.canvas.Brush.Color:=$008000;
                 Image.canvas.Polygon(points);

                   // 上柱筒    综采支架
                 Points[0].X:=trunc(x2-zj_w/60*28);       Points[0].Y:=trunc(y2-zj_H/60*35);
                 Points[1].X:=trunc(x2-zj_w/60*31);       Points[1].Y:=trunc(y2-zj_H/60*54);
                 Points[2].X:=trunc(x2-zj_w/60*33);       Points[2].Y:=trunc(y2-zj_H/60*54);
                 Points[3].X:=trunc(x2-zj_w/60*30);       Points[3].Y:=trunc(y2-zj_H/60*35);
                 Image.canvas.Brush.Color:=$0000FF;
                 Image.canvas.Polygon(points);

            end;    //end  if zj_h> 40 then  begin  // 双伸缩  综采支架

        end else begin   // 四立柱  综采支架
               if mc_h>=4.0 then  begin  // 双伸缩  综采支架
                 // 后柱下柱筒 综采支架
                 Points[0].X:=trunc(x2-zj_w/60*14);                  Points[0].Y:=trunc(y2-zj_H/60*9);
                 Points[1].X:=trunc(x2-zj_w/60*14);                  Points[1].Y:=trunc(y2-zj_H/60*28);
                 Points[2].X:=trunc(x2-zj_w/60*18);                  Points[2].Y:=trunc(y2-zj_H/60*28);
                 Points[3].X:=trunc(x2-zj_w/60*18);                  Points[3].Y:=trunc(y2-zj_H/60*9);
                 Image.canvas.Brush.Color:=$000000;
                 Image.canvas.Polygon(points);

                  // 后柱下中柱筒  综采支架
                 Points[0].X:=trunc(x2-zj_w/60*14.5);                  Points[0].Y:=trunc(y2-zj_H/60*28);
                 Points[1].X:=trunc(x2-zj_w/60*14.5);                  Points[1].Y:=trunc(y2-zj_H/60*46);
                 Points[2].X:=trunc(x2-zj_w/60*17.5);                  Points[2].Y:=trunc(y2-zj_H/60*46);
                 Points[3].X:=trunc(x2-zj_w/60*17.5);                  Points[3].Y:=trunc(y2-zj_H/60*28);
                 Image.canvas.Brush.Color:=$008000;
                 Image.canvas.Polygon(points);

                   // 后柱上下柱筒 综采支架
                 Points[0].X:=trunc(x2-zj_w/60*15);                  Points[0].Y:=trunc(y2-zj_H/60*46);
                 Points[1].X:=trunc(x2-zj_w/60*15);                  Points[1].Y:=trunc(y2-zj_H/60*54);
                 Points[2].X:=trunc(x2-zj_w/60*17);                  Points[2].Y:=trunc(y2-zj_H/60*54);
                 Points[3].X:=trunc(x2-zj_w/60*17);                  Points[3].Y:=trunc(y2-zj_H/60*46);
                 Image.canvas.Brush.Color:=$0000FF;
                 Image.canvas.Polygon(points);
                 // 前柱下柱筒  综采支架
                 Points[0].X:=trunc(x2-zj_w/60*26);                  Points[0].Y:=trunc(y2-zj_H/60*8);
                 Points[1].X:=trunc(x2-zj_w/60*29);                  Points[1].Y:=trunc(y2-zj_H/60*28);
                 Points[2].X:=trunc(x2-zj_w/60*33);                  Points[2].Y:=trunc(y2-zj_H/60*28);
                 Points[3].X:=trunc(x2-zj_w/60*30);                  Points[3].Y:=trunc(y2-zj_H/60*8);
                 Image.canvas.Brush.Color:=$000000;
                 Image.canvas.Polygon(points);

                  // 前柱中柱筒   综采支架
                 Points[0].X:=trunc(x2-zj_w/60*29.5);                  Points[0].Y:=trunc(y2-zj_H/60*28);
                 Points[1].X:=trunc(x2-zj_w/60*32);                  Points[1].Y:=trunc(y2-zj_H/60*46);
                 Points[2].X:=trunc(x2-zj_w/60*35);                  Points[2].Y:=trunc(y2-zj_H/60*46);
                 Points[3].X:=trunc(x2-zj_w/60*32.5);                  Points[3].Y:=trunc(y2-zj_H/60*28);
                 Image.canvas.Brush.Color:=$008000;
                 Image.canvas.Polygon(points);

                   // 前柱上柱筒 综采支架
                 Points[0].X:=trunc(x2-zj_w/60*32.5);                  Points[0].Y:=trunc(y2-zj_H/60*46);
                 Points[1].X:=trunc(x2-zj_w/60*34);                  Points[1].Y:=trunc(y2-zj_H/60*54);
                 Points[2].X:=trunc(x2-zj_w/60*36);                  Points[2].Y:=trunc(y2-zj_H/60*54);
                 Points[3].X:=trunc(x2-zj_w/60*34.5);                  Points[3].Y:=trunc(y2-zj_H/60*46);
                 Image.canvas.Brush.Color:=$0000FF;
                 Image.canvas.Polygon(points);

            end else begin  // // 单伸缩  综采支架
                 // 后柱 下竹筒   综采支架
                 Points[0].X:=trunc(x2-zj_w/60*14);                  Points[0].Y:=trunc(y2-zj_H/60*8);
                 Points[1].X:=trunc(x2-zj_w/60*14);                  Points[1].Y:=trunc(y2-zj_H/60*35);
                 Points[2].X:=trunc(x2-zj_w/60*18);                  Points[2].Y:=trunc(y2-zj_H/60*35);
                 Points[3].X:=trunc(x2-zj_w/60*18);                  Points[3].Y:=trunc(y2-zj_H/60*8);
                 Image.canvas.Brush.Color:=$008000;
                 Image.canvas.Polygon(points);

                   // 后柱 上柱筒  综采支架
                 Points[0].X:=trunc(x2-zj_w/60*15);       Points[0].Y:=trunc(y2-zj_H/60*35);
                 Points[1].X:=trunc(x2-zj_w/60*15);       Points[1].Y:=trunc(y2-zj_H/60*54);
                 Points[2].X:=trunc(x2-zj_w/60*17);       Points[2].Y:=trunc(y2-zj_H/60*54);
                 Points[3].X:=trunc(x2-zj_w/60*17);       Points[3].Y:=trunc(y2-zj_H/60*35);
                 Image.canvas.Brush.Color:=$0000FF;
                 Image.canvas.Polygon(points);
                  // 前柱下柱筒   综采支架
                 Points[0].X:=trunc(x2-zj_w/60*26);                  Points[0].Y:=trunc(y2-zj_H/60*8);
                 Points[1].X:=trunc(x2-zj_w/60*29);                  Points[1].Y:=trunc(y2-zj_H/60*35);
                 Points[2].X:=trunc(x2-zj_w/60*33);                  Points[2].Y:=trunc(y2-zj_H/60*35);
                 Points[3].X:=trunc(x2-zj_w/60*30);                  Points[3].Y:=trunc(y2-zj_H/60*8);
                  Image.canvas.Brush.Color:=$008000;
                 Image.canvas.Polygon(points);

                    // 前柱上柱筒 综采支架
                 Points[0].X:=trunc(x2-zj_w/60*30);                  Points[0].Y:=trunc(y2-zj_H/60*35);
                 Points[1].X:=trunc(x2-zj_w/60*32);                  Points[1].Y:=trunc(y2-zj_H/60*54);
                 Points[2].X:=trunc(x2-zj_w/60*34);                  Points[2].Y:=trunc(y2-zj_H/60*54);
                 Points[3].X:=trunc(x2-zj_w/60*32);                  Points[3].Y:=trunc(y2-zj_H/60*35);
                 Image.canvas.Brush.Color:=$0000FF;
                 Image.canvas.Polygon(points);

            end;    //end  if zj_h> 40 then  begin  // 双伸缩
        end;  //end 立柱数目
        //画背后矸石   综采支架
        //上段        综采支架
         {  Points[0].X:=trunc(x2-zj_w/60*8);                  Points[0].Y:=trunc(y1);
           Points[1].X:=trunc(x2-zj_w/60*10);                 Points[1].Y:=trunc(y2-zj_H/60*50);
           Points[2].X:=trunc(x2);                            Points[2].Y:=trunc(y2-zj_H/60*20);
           Points[3].X:=trunc(x2);                            Points[3].Y:=trunc(y1);
           Image.Canvas.Brush.Bitmap:=nil;
           Image.Canvas.Polygon(Points) ;
           bitmap1:=Tbitmap.Create;//创建位图 bitmap1
          // if  fileexists(dll_Path+'\BmpSi\矸石.Bmp') then  begin
          //            bitmap1.LoadFromFile(dll_Path+'\BmpFZ\矸石.Bmp');//装入图像文件
           bitmap1.LoadFromFile('C:\矸石.Bmp');//装入图像文件
           Image.Canvas.Brush.Bitmap:=bitmap1;
           Image.Canvas.FloodFill( Points[0].X+3,Points[0].Y+1,$000000,fsBorder);
           Image.Canvas.Brush.Bitmap:=nil;
            //下段   综采支架
           Points[0].X:=Points[2].X;                         Points[0].Y:=Points[2].Y;
           Points[1].X:=trunc(x2-zj_w/60*3);                 Points[1].Y:=trunc(y2-zj_H/60*6);
           Points[2].X:=trunc(x2-zj_w/60*3);                 Points[2].Y:=trunc(y2);
           Points[3].X:=trunc(x2);                           Points[3].Y:=trunc(y2);
           Image.Canvas.Polygon(Points) ;
           bitmap1:=Tbitmap.Create;//创建位图 bitmap1
           bitmap1.LoadFromFile(dll_Path+'\BmpSi\矸石.Bmp');//装入图像文件

           Image.Canvas.Brush.Bitmap:=bitmap1;
           Image.Canvas.FloodFill( Points[2].X+1,Points[2].Y-1,$000000,fsBorder);
           Image.Canvas.Brush.Bitmap:=nil;
           bitmap1.free;
         }  
           //画刮板输送机
            Image.Canvas.MoveTo(trunc(x2-zj_w/60*40),trunc(y2));
            Image.Canvas.LineTo(trunc(x2-zj_w/60*52),trunc(y2));
            Image.Canvas.LineTo(trunc(x2-zj_w/60*52),trunc(y2-zj_H/60*3));
            Image.Canvas.LineTo(trunc(x2-zj_w/60*51),trunc(y2-zj_H/60*3));
            Image.Canvas.LineTo(trunc(x2-zj_w/60*51),trunc(y2-zj_H/60*1));
            Image.Canvas.LineTo(trunc(x2-zj_w/60*41),trunc(y2-zj_H/60*1));
            Image.Canvas.LineTo(trunc(x2-zj_w/60*41),trunc(y2-zj_H/60*3));
            Image.Canvas.LineTo(trunc(x2-zj_w/60*40),trunc(y2-zj_H/60*3));
            Image.Canvas.LineTo(trunc(x2-zj_w/60*40),trunc(y2));
    end else begin     //综放
          //画底座   //综放
        Image.Canvas.Pen.Width :=1;
        Image.Canvas.Pen.Color :=$000000;
        Image.Canvas.MoveTo(trunc(x2-zj_w/60*40),trunc(y2));
        Image.Canvas.LineTo(trunc(x2-zj_w/60*13),trunc(y2));
        Image.Canvas.LineTo(trunc(x2-zj_w/60*13),trunc(y2-zj_H/60*6)) ;
        Image.Canvas.LineTo(trunc(x2-zj_w/60*16),trunc(y2-zj_H/60*6)) ;
        Image.Canvas.LineTo(trunc(x2-zj_w/60*16),trunc(y2-zj_H/60*9)) ;
        Image.Canvas.LineTo(trunc(x2-zj_w/60*20),trunc(y2-zj_H/60*9)) ;
        Image.Canvas.LineTo(trunc(x2-zj_w/60*20),trunc(y2-zj_H/60*12)) ;
        Image.Canvas.LineTo(trunc(x2-zj_w/60*23),trunc(y2-zj_H/60*12)) ;
        Image.Canvas.LineTo(trunc(x2-zj_w/60*24),trunc(y2-zj_H/60*8)) ;
        Image.Canvas.LineTo(trunc(x2-zj_w/60*40),trunc(y2-zj_H/60*8)) ;
        Image.Canvas.LineTo(trunc(x2-zj_w/60*40),trunc(y2));
        //画背梁支撑   //综放
        Image.Canvas.Pen.Width :=1;
        Image.Canvas.MoveTo(trunc(x2-zj_w/60*16),trunc(y2-zj_H/60*9)) ;
        Image.Canvas.LineTo(trunc(x2-zj_w/60*11),trunc(y2-zj_H/60*25)) ;
        Image.Canvas.LineTo(trunc(x2-zj_w/60*12),trunc(y2-zj_H/60*25)) ;
        Image.Canvas.LineTo(trunc(x2-zj_w/60*17),trunc(y2-zj_H/60*9)) ;

        Image.Canvas.MoveTo(trunc(x2-zj_w/60*21),trunc(y2-zj_H/60*11)) ;
        Image.Canvas.LineTo(trunc(x2-zj_w/60*16),trunc(y2-zj_H/60*35)) ;
        Image.Canvas.LineTo(trunc(x2-zj_w/60*17),trunc(y2-zj_H/60*35)) ;
        Image.Canvas.LineTo(trunc(x2-zj_w/60*22),trunc(y2-zj_H/60*12)) ;
        //画背梁   //综放
        Image.Canvas.MoveTo(trunc(x2-zj_w/60*9),trunc(y2-zj_H/60*25)) ;
        Image.Canvas.LineTo(trunc(x2-zj_w/60*23),trunc(y2-zj_H/60*58)) ;
        Image.Canvas.LineTo(trunc(x2-zj_w/60*25),trunc(y2-zj_H/60*56)) ;
        Image.Canvas.LineTo(trunc(x2-zj_w/60*11),trunc(y2-zj_H/60*23)) ;
        Image.Canvas.LineTo(trunc(x2-zj_w/60*9),trunc(y2-zj_H/60*25)) ;
        //画尾梁   //综放
        Image.Canvas.MoveTo(trunc(x2-zj_w/60*9),trunc(y2-zj_H/60*25)) ;
       // Image.Canvas.MoveTo(trunc(x2-zj_w/60*9),trunc(y2-zj_H/60*19)) ;
        Image.Canvas.LineTo(trunc(x2-zj_w/60*0),trunc(y2-zj_H/60*4)) ;
        Image.Canvas.LineTo(trunc(x2-zj_w/60*0),trunc(y2-zj_H/60*2)) ;
        Image.Canvas.LineTo(trunc(x2-zj_w/60*11),trunc(y2-zj_H/60*25)) ;
       ////画顶梁   //综放
        Image.Canvas.MoveTo(trunc(x2-zj_w/60*22),trunc(y1)) ;
        Image.Canvas.LineTo(trunc(x2-zj_w/60*22),trunc(y1+zj_H/60*6)) ;
        Image.Canvas.LineTo(trunc(x2-zj_w/60*50),trunc(y1+zj_H/60*6)) ;
        Image.Canvas.LineTo(trunc(x2-zj_w/60*50),trunc(y1)) ;
        Image.Canvas.LineTo(trunc(x2-zj_w/60*22),trunc(y1)) ;
         if mc_h>2.5 then  begin
             //伸缩梁  //综放
            Image.Canvas.MoveTo(trunc(x2-zj_w/60*50),trunc(y1+zj_H/30*1)) ;
            Image.Canvas.LineTo(trunc(x2-zj_w/60*51),trunc(y1)) ;
            Image.Canvas.LineTo(trunc(x2-zj_w/60*58),trunc(y1)) ;
            Image.Canvas.LineTo(trunc(x2-zj_w/60*58),trunc(y1+zj_H/30*2)) ;
            Image.Canvas.LineTo(trunc(x2-zj_w/60*50),trunc(y1+zj_H/30*2)) ;
            // //护帮   //综放
            Image.Canvas.MoveTo(trunc(x2-zj_w/60*58),trunc(y1)) ;
            Image.Canvas.LineTo(trunc(x1),trunc(y1+zj_H/30*13)) ;
            Image.Canvas.LineTo(trunc(x1+zj_w/60*1),trunc(y1+zj_H/30*13)) ;
            Image.Canvas.LineTo(trunc(x2-zj_w/60*57),trunc(y1+zj_H/30*2)) ;

        end else begin
             //伸缩梁   //综放
            Image.Canvas.MoveTo(trunc(x2-zj_w/60*50),trunc(y1+zj_H/30*1)) ;
            Image.Canvas.LineTo(trunc(x2-zj_w/60*51),trunc(y1)) ;
            Image.Canvas.LineTo(trunc(x1),trunc(y1)) ;
            Image.Canvas.LineTo(trunc(x1),trunc(y1+zj_H/30*2)) ;
            Image.Canvas.LineTo(trunc(x2-zj_w/60*50),trunc(y1+zj_H/30*2)) ;
        end;


         //立柱   //综放
        if lizhushu=2 then  begin  // 两立柱   //综放
           if mc_h>=4.0 then  begin  // 双伸缩  //综放
                 // 下柱筒  //综放
                 Points[0].X:=trunc(x2-zj_w/60*29);                  Points[0].Y:=trunc(y2-zj_H/60*8);
                 Points[1].X:=trunc(x2-zj_w/60*33);                  Points[1].Y:=trunc(y2-zj_H/60*28);
                 Points[2].X:=trunc(x2-zj_w/60*37);                  Points[2].Y:=trunc(y2-zj_H/60*28);
                 Points[3].X:=trunc(x2-zj_w/60*33);                  Points[3].Y:=trunc(y2-zj_H/60*8);
                 Image.canvas.Brush.Color:=$000000;
                 Image.canvas.Polygon(points);

                  // 中柱筒 //综放
                 Points[0].X:=trunc(x2-zj_w/60*33.5);                  Points[0].Y:=trunc(y2-zj_H/60*28);
                 Points[1].X:=trunc(x2-zj_w/60*37.5);                  Points[1].Y:=trunc(y2-zj_H/60*46);
                 Points[2].X:=trunc(x2-zj_w/60*40.5);                  Points[2].Y:=trunc(y2-zj_H/60*46);
                 Points[3].X:=trunc(x2-zj_w/60*36.5);                  Points[3].Y:=trunc(y2-zj_H/60*28);
                 Image.canvas.Brush.Color:=$008000;
                 Image.canvas.Polygon(points);

                   // 上柱筒   //综放
                 Points[0].X:=trunc(x2-zj_w/60*38);                  Points[0].Y:=trunc(y2-zj_H/60*46);
                 Points[1].X:=trunc(x2-zj_w/60*40);                  Points[1].Y:=trunc(y2-zj_H/60*54);
                 Points[2].X:=trunc(x2-zj_w/60*42);                  Points[2].Y:=trunc(y2-zj_H/60*54);
                 Points[3].X:=trunc(x2-zj_w/60*40);                  Points[3].Y:=trunc(y2-zj_H/60*46);
                 Image.canvas.Brush.Color:=$0000FF;
                 Image.canvas.Polygon(points);

            end else begin  // // 单伸缩  //综放
                 Points[0].X:=trunc(x2-zj_w/60*29);                  Points[0].Y:=trunc(y2-zj_H/60*8);
                 Points[1].X:=trunc(x2-zj_w/60*33);                  Points[1].Y:=trunc(y2-zj_H/60*35);
                 Points[2].X:=trunc(x2-zj_w/60*37);                  Points[2].Y:=trunc(y2-zj_H/60*35);
                 Points[3].X:=trunc(x2-zj_w/60*33);                  Points[3].Y:=trunc(y2-zj_H/60*8);
                 Image.canvas.Brush.Color:=$008000;
                 Image.canvas.Polygon(points);

                   // 上柱筒  //综放
                 Points[0].X:=trunc(x2-zj_w/60*34);       Points[0].Y:=trunc(y2-zj_H/60*35);
                 Points[1].X:=trunc(x2-zj_w/60*37);       Points[1].Y:=trunc(y2-zj_H/60*54);
                 Points[2].X:=trunc(x2-zj_w/60*39);       Points[2].Y:=trunc(y2-zj_H/60*54);
                 Points[3].X:=trunc(x2-zj_w/60*36);       Points[3].Y:=trunc(y2-zj_H/60*35);
                 Image.canvas.Brush.Color:=$0000FF;
                 Image.canvas.Polygon(points);

            end;    //end  if zj_h> 40 then  begin  // 双伸缩 //综放

        end else begin   // 四立柱  //综放
               if mc_h>=4.0 then  begin  // 双伸缩    //综放
                 // 后柱下柱筒  //综放
                 Points[0].X:=trunc(x2-zj_w/60*24);                  Points[0].Y:=trunc(y2-zj_H/60*8);
                 Points[1].X:=trunc(x2-zj_w/60*24);                  Points[1].Y:=trunc(y2-zj_H/60*28);
                 Points[2].X:=trunc(x2-zj_w/60*28);                  Points[2].Y:=trunc(y2-zj_H/60*28);
                 Points[3].X:=trunc(x2-zj_w/60*28);                  Points[3].Y:=trunc(y2-zj_H/60*8);
                 Image.canvas.Brush.Color:=$000000;
                 Image.canvas.Polygon(points);

                  // 后柱下中柱筒   //综放
                 Points[0].X:=trunc(x2-zj_w/60*24.5);                  Points[0].Y:=trunc(y2-zj_H/60*28);
                 Points[1].X:=trunc(x2-zj_w/60*24.5);                  Points[1].Y:=trunc(y2-zj_H/60*46);
                 Points[2].X:=trunc(x2-zj_w/60*27.5);                  Points[2].Y:=trunc(y2-zj_H/60*46);
                 Points[3].X:=trunc(x2-zj_w/60*27.5);                  Points[3].Y:=trunc(y2-zj_H/60*28);
                 Image.canvas.Brush.Color:=$008000;
                 Image.canvas.Polygon(points);

                   // 后柱上下柱筒   //综放
                 Points[0].X:=trunc(x2-zj_w/60*25);                  Points[0].Y:=trunc(y2-zj_H/60*46);
                 Points[1].X:=trunc(x2-zj_w/60*25);                  Points[1].Y:=trunc(y2-zj_H/60*54);
                 Points[2].X:=trunc(x2-zj_w/60*27);                  Points[2].Y:=trunc(y2-zj_H/60*54);
                 Points[3].X:=trunc(x2-zj_w/60*27);                  Points[3].Y:=trunc(y2-zj_H/60*46);
                 Image.canvas.Brush.Color:=$0000FF;
                 Image.canvas.Polygon(points);
                 // 前柱下柱筒  //综放
                 Points[0].X:=trunc(x2-zj_w/60*34);                  Points[0].Y:=trunc(y2-zj_H/60*8);
                 Points[1].X:=trunc(x2-zj_w/60*37);                  Points[1].Y:=trunc(y2-zj_H/60*28);
                 Points[2].X:=trunc(x2-zj_w/60*41);                  Points[2].Y:=trunc(y2-zj_H/60*28);
                 Points[3].X:=trunc(x2-zj_w/60*38);                  Points[3].Y:=trunc(y2-zj_H/60*8);
                 Image.canvas.Brush.Color:=$000000;
                 Image.canvas.Polygon(points);

                  // 前柱中柱筒   //综放
                 Points[0].X:=trunc(x2-zj_w/60*37.5);                  Points[0].Y:=trunc(y2-zj_H/60*28);
                 Points[1].X:=trunc(x2-zj_w/60*40);                  Points[1].Y:=trunc(y2-zj_H/60*46);
                 Points[2].X:=trunc(x2-zj_w/60*43);                  Points[2].Y:=trunc(y2-zj_H/60*46);
                 Points[3].X:=trunc(x2-zj_w/60*40.5);                  Points[3].Y:=trunc(y2-zj_H/60*28);
                 Image.canvas.Brush.Color:=$008000;
                 Image.canvas.Polygon(points);

                   // 前柱上柱筒  //综放
                 Points[0].X:=trunc(x2-zj_w/60*40.5);                  Points[0].Y:=trunc(y2-zj_H/60*46);
                 Points[1].X:=trunc(x2-zj_w/60*42);                  Points[1].Y:=trunc(y2-zj_H/60*54);
                 Points[2].X:=trunc(x2-zj_w/60*44);                  Points[2].Y:=trunc(y2-zj_H/60*54);
                 Points[3].X:=trunc(x2-zj_w/60*42.5);                  Points[3].Y:=trunc(y2-zj_H/60*46);
                 Image.canvas.Brush.Color:=$0000FF;
                 Image.canvas.Polygon(points);

            end else begin  // // 单伸缩 //综放
                 // 后柱 下竹筒 //综放
                 Points[0].X:=trunc(x2-zj_w/60*24);                  Points[0].Y:=trunc(y2-zj_H/60*8);
                 Points[1].X:=trunc(x2-zj_w/60*24);                  Points[1].Y:=trunc(y2-zj_H/60*35);
                 Points[2].X:=trunc(x2-zj_w/60*28);                  Points[2].Y:=trunc(y2-zj_H/60*35);
                 Points[3].X:=trunc(x2-zj_w/60*28);                  Points[3].Y:=trunc(y2-zj_H/60*8);
                 Image.canvas.Brush.Color:=$008000;
                 Image.canvas.Polygon(points);

                   // 后柱 上柱筒  //综放
                 Points[0].X:=trunc(x2-zj_w/60*25);       Points[0].Y:=trunc(y2-zj_H/60*35);
                 Points[1].X:=trunc(x2-zj_w/60*25);       Points[1].Y:=trunc(y2-zj_H/60*54);
                 Points[2].X:=trunc(x2-zj_w/60*27);       Points[2].Y:=trunc(y2-zj_H/60*54);
                 Points[3].X:=trunc(x2-zj_w/60*27);       Points[3].Y:=trunc(y2-zj_H/60*35);
                 Image.canvas.Brush.Color:=$0000FF;
                 Image.canvas.Polygon(points);
                  // 前柱下柱筒 //综放
                 Points[0].X:=trunc(x2-zj_w/60*34);                  Points[0].Y:=trunc(y2-zj_H/60*8);
                 Points[1].X:=trunc(x2-zj_w/60*37);                  Points[1].Y:=trunc(y2-zj_H/60*35);
                 Points[2].X:=trunc(x2-zj_w/60*41);                  Points[2].Y:=trunc(y2-zj_H/60*35);
                 Points[3].X:=trunc(x2-zj_w/60*38);                  Points[3].Y:=trunc(y2-zj_H/60*8);
                  Image.canvas.Brush.Color:=$008000;
                 Image.canvas.Polygon(points);

                    // 前柱上柱筒  //综放
                 Points[0].X:=trunc(x2-zj_w/60*38);                  Points[0].Y:=trunc(y2-zj_H/60*35);
                 Points[1].X:=trunc(x2-zj_w/60*40);                  Points[1].Y:=trunc(y2-zj_H/60*54);
                 Points[2].X:=trunc(x2-zj_w/60*42);                  Points[2].Y:=trunc(y2-zj_H/60*54);
                 Points[3].X:=trunc(x2-zj_w/60*40);                  Points[3].Y:=trunc(y2-zj_H/60*35);
                 Image.canvas.Brush.Color:=$0000FF;
                 Image.canvas.Polygon(points);

            end;    //end  if zj_h> 40 then  begin  // 双伸缩    //综放
        end;  //end 立柱数目  //综放
        //画背后矸石  //综放
        //上段
           //画背梁   //综放
         {  Points[0].X:=trunc(x2-zj_w/60*22);                  Points[0].Y:=trunc(y1);
           Points[1].X:=trunc(x2-zj_w/60*22);                 Points[1].Y:=trunc(y2-zj_H/60*55);
           Points[2].X:=trunc(x2);                            Points[2].Y:=trunc(y2-zj_H/60*4);
           Points[3].X:=trunc(x2);                            Points[3].Y:=trunc(y1);
           Image.Canvas.Brush.Bitmap:=nil;
           Image.Canvas.Polygon(Points) ;
           bitmap1:=Tbitmap.Create;//创建位图 bitmap1
           bitmap1.LoadFromFile(dll_Path+'\BmpSi\煤.Bmp');//装入图像文件

           Image.Canvas.Brush.Bitmap:=bitmap1;
           Image.Canvas.FloodFill( Points[0].X+3,Points[0].Y+1,$000000,fsBorder);
           Image.Canvas.Brush.Bitmap:=nil;
           bitmap1.Free;  }
            //画刮板输送机
            Image.Canvas.MoveTo(trunc(x2-zj_w/60*45),trunc(y2));
            Image.Canvas.LineTo(trunc(x2-zj_w/60*55),trunc(y2));
            Image.Canvas.LineTo(trunc(x2-zj_w/60*55),trunc(y2-zj_H/60*3));
            Image.Canvas.LineTo(trunc(x2-zj_w/60*54),trunc(y2-zj_H/60*3));
            Image.Canvas.LineTo(trunc(x2-zj_w/60*54),trunc(y2-zj_H/60*1));
            Image.Canvas.LineTo(trunc(x2-zj_w/60*46),trunc(y2-zj_H/60*1));
            Image.Canvas.LineTo(trunc(x2-zj_w/60*46),trunc(y2-zj_H/60*3));
            Image.Canvas.LineTo(trunc(x2-zj_w/60*45),trunc(y2-zj_H/60*3));
            Image.Canvas.LineTo(trunc(x2-zj_w/60*45),trunc(y2));

            Image.Canvas.MoveTo(trunc(x2-zj_w/60*2),trunc(y2));
            Image.Canvas.LineTo(trunc(x2-zj_w/60*12),trunc(y2));
            Image.Canvas.LineTo(trunc(x2-zj_w/60*12),trunc(y2-zj_H/60*3));
            Image.Canvas.LineTo(trunc(x2-zj_w/60*11),trunc(y2-zj_H/60*3));
            Image.Canvas.LineTo(trunc(x2-zj_w/60*11),trunc(y2-zj_H/60*1));
            Image.Canvas.LineTo(trunc(x2-zj_w/60*3),trunc(y2-zj_H/60*1));
            Image.Canvas.LineTo(trunc(x2-zj_w/60*3),trunc(y2-zj_H/60*3));
            Image.Canvas.LineTo(trunc(x2-zj_w/60*2),trunc(y2-zj_H/60*3));
            Image.Canvas.LineTo(trunc(x2-zj_w/60*2),trunc(y2));


    end;   //end  //综放

 //=============
end;
 //==========================
 function TCal_show.DrawZcyl(Image:TImage;P1,P2:TPoint;zcyl:Str_Dt_array;bl:double;left_right:bool):WordBool;  //画支撑压力曲线
  var
   Zcyl_d :array [0..4] of double;
   px,py: array [0..21] of double;
   Lu_x,Lu_y: array [0..300] of double;
   Num,Lu_n,i:integer;
   L_x,L_y:double;
   Y_bl: double;
   l_x_fort,sub_x:double;
   while_false:bool;
 begin
     L_y:=P2.y-P1.y;
     for I := 0 to 4 do  begin
        Zcyl_d[i]:=StrToFloat(zcyl[i]);  
     end;
     if left_right then  bl:=-bl;

      Y_bl:=L_y/zcyl_d[2];
            px[0]:=P2.X;                     py[0]:=P2.y;
            px[1]:=P2.X-zcyl_d[1]*bl/2;      py[1]:=P2.y-(zcyl_d[0]*Y_bl);
            px[2]:=P2.X-zcyl_d[1]*bl;        py[2]:=P2.y-(zcyl_d[0]*Y_bl/3);
            px[3]:=P2.X-zcyl_d[3]*bl/2;      py[3]:=P2.y-(zcyl_d[2]*Y_bl*3/6);
            px[4]:=P2.X-zcyl_d[3]*bl*2/3;    py[4]:=P2.y-(zcyl_d[2]*Y_bl*5/6);
            px[5]:=P2.X-zcyl_d[3]*bl;        py[5]:=P2.y-(zcyl_d[2]*Y_bl);
            px[6]:= px[5]-(zcyl_d[4]-zcyl_d[3])*bl*1/12;     py[6]:=P2.y-(((zcyl_d[2]-1)*5/6+1)*Y_bl);
            px[7]:= px[5]-(zcyl_d[4]-zcyl_d[3])*bl*2/12;      py[7]:=P2.y-(((zcyl_d[2]-1)*9/12+1)*Y_bl);
            px[8]:= px[5]-(zcyl_d[4]-zcyl_d[3])*bl*3/12;     py[8]:=P2.y-(((zcyl_d[2]-1)*8/12+1)*Y_bl);
            px[9]:= px[5]-(zcyl_d[4]-zcyl_d[3])*bl*4/12;      py[9]:=P2.y-(((zcyl_d[2]-1)*7/12+1)*Y_bl);
            px[10]:=px[5]-(zcyl_d[4]-zcyl_d[3])*bl*5/12;    py[10]:=P2.y-(((zcyl_d[2]-1)*6/12+1)*Y_bl);
            px[11]:= px[5]-(zcyl_d[4]-zcyl_d[3])*bl*6/12;      py[11]:=P2.y-(((zcyl_d[2]-1)*5/12+1)*Y_bl);
            px[12]:= px[5]-(zcyl_d[4]-zcyl_d[3])*bl*7/12;      py[12]:=P2.y-(((zcyl_d[2]-1)*4/12+1)*Y_bl);
            px[13]:= px[5]-(zcyl_d[4]-zcyl_d[3])*bl*8/12;      py[13]:=P2.y-(((zcyl_d[2]-1)*3/12+1)*Y_bl);
            px[14]:= px[5]-(zcyl_d[4]-zcyl_d[3])*bl*9/12;      py[14]:=P2.y-(((zcyl_d[2]-1)*2/12+1)*Y_bl);
            px[15]:= px[5]-(zcyl_d[4]-zcyl_d[3])*bl*10/12;      py[15]:=P2.y-(((zcyl_d[2]-1)*1/12+1)*Y_bl);
            px[16]:= px[5]-(zcyl_d[4]-zcyl_d[3])*bl*11/12;    py[16]:=P2.y-(1*Y_bl);
            px[17]:= P2.X-zcyl_d[4]*bl;         py[17]:=P2.y-(1*Y_bl);
            
            if left_right then   begin
                  if Px[17]> P1.x then   Px[17]:= P1.x ;
            end else begin
                  if Px[17]< P1.x then   Px[17]:= P1.x ;
            end;              

           Public_Basic.lu_spline(px,py,18,lu_x,Lu_y,Lu_n);
           Image.Canvas.Pen.Color:=clred;
           Image.Canvas.MoveTo(trunc(lu_x[0]),trunc(lu_y[0]));
           for I := 1 to lu_n-1 do begin
               Image.Canvas.LineTo(trunc(lu_x[i]),trunc(lu_y[i]))
           end;
           Image.Canvas.LineTo(p1.x,trunc(py[4])) ;
       //画支撑压力线的 垂直箭头
        l_x_fort:=lu_x[0];
       for i := 0 to lu_n-1 do begin
          sub_x:=abs(lu_x[i]-l_x_fort);
          if sub_x>=8 then  begin
             Image.Canvas.MoveTo(trunc(lu_x[i]),trunc(lu_y[i]));
             Image.Canvas.LineTo(trunc(lu_x[i]),p2.y);
             l_x_fort:=lu_x[i];
          end;
       end;
       while_false:=true;
       while while_false do  begin
          if left_right then  begin
           if l_x_fort<p1.x then begin
             Image.Canvas.MoveTo(trunc(l_x_fort),trunc(lu_y[Lu_n-1]));
             Image.Canvas.LineTo(trunc(l_x_fort),p2.y);
             l_x_fort:=l_x_fort+8;
           end else begin
             while_false:=false;
           end;
          end else begin
               if l_x_fort>p1.x then begin
                 Image.Canvas.MoveTo(trunc(l_x_fort),trunc(lu_y[Lu_n-1]));
                 Image.Canvas.LineTo(trunc(l_x_fort),p2.y);
                 l_x_fort:=l_x_fort-8;
               end else begin
                 while_false:=false;
               end;
          end;

       end;


     result:=true;
 end;
 //====================================================
 {



 }
  function TCal_show.Draw_YLG(Image:TImage;L1,L2,R1,R2:TStringList):WordBool;
  var
     i,j,k,t :integer;
     p1x,p1y: array [0..60] of double;
     p2x,p2y: array [0..60] of double;
     p1_x,p1_y,p2_x,P2_y: array [0..300] of double;
     while_t:bool;
     count1,count2,Lu_1,LU_2 :integer;
     temp1,temp2 :Str_Dt_array;
     LD_1,lD_2:double;
     LD_1_C,Ld_2_c: integer;
  begin
       while_t:=true;  t:=1;
       while while_t do  begin
          if L1.Count/t>29 then  begin
            t:=t+1;
          end else begin
            while_t:=false;
          end;

       end; //end while
     k:=0;
     for i := 0 to round(L1.Count/t) -1 do  begin
         if i mod t =0  then begin
             temp1:=Public_Basic.split(L1[i],',',Count1);
                 p1x[k]:=strTofloat(temp1[0]);
                 p1y[k]:=strTofloat(temp1[1]);

             temp2:=Public_Basic.split(L2[i],',',Count2);
                 p2x[k]:=strTofloat(temp2[0]);
                 p2y[k]:=strTofloat(temp2[1]);

             K:=K+1;
         end;
     end;


     for j := 0 to round(R1.Count/t) -1 do  begin
         if j mod t =0  then begin
             temp1:=Public_Basic.split(R1[j],',',Count1);
                 p1x[k]:=strTofloat(temp1[0]);
                 p1y[k]:=strTofloat(temp1[1]);

             temp2:=Public_Basic.split(R2[j],',',Count2);
                 p2x[k]:=strTofloat(temp2[0]);
                 p2y[k]:=strTofloat(temp2[1]);
             K:=K+1;
         end;
     end;
     // spline
     Public_Basic.lu_spline(p1x,p1y,K,p1_x,p1_y,Lu_1);
     Public_Basic.lu_spline(p2x,p2y,K,p2_x,p2_y,Lu_2);
     //连成线
      Image.Canvas.Pen.Color:=clRed;
      Image.Canvas.MoveTo(trunc(p1_x[0]),trunc(p1_y[0]));
     for i := 0 to Lu_1 - 1 do  begin
        Image.Canvas.LineTo(trunc(p1_x[i]),trunc(p1_y[i]));
     end;
       Image.Canvas.MoveTo(trunc(p2_x[0]),trunc(p2_y[0]));
     for i := 0 to Lu_2 - 1 do  begin
        Image.Canvas.LineTo(trunc(p2_x[i]),trunc(p2_y[i]));
     end;
     //画网格
      Image.Canvas.Pen.Color:=clgreen;
     LD_1_C:=0;
     for I := 1 to Lu_1  - 1 do   begin
         LD_1:=sqrt((p1_x[i]-P1_x[LD_1_C]) *(p1_x[i]-P1_x[LD_1_C])+(p1_y[i]-P1_y[LD_1_C])*(p1_y[i]-P1_y[LD_1_C]));
         if LD_1>10  then   begin
               LD_2_C:=I;
               for j :=  I to Lu_2 - 1 do  begin
                    LD_2:=sqrt((p2_x[j]-P2_x[LD_2_C]) *(p2_x[j]-P2_x[LD_2_C])+(p2_y[j]-P2_y[LD_2_C])*(p2_y[j]-P2_y[LD_2_C]));
                    if Ld_2 >10 then  begin
                       Image.Canvas.MoveTo(trunc(p1_x[i]),trunc(p1_y[i]));
                       Image.Canvas.lineto(trunc(p2_x[j]),trunc(p2_y[j]));
                       LD_1_C:=i;
                       break;
                    end;
               end; //end for j
         end;

     end;  // end for i

     Image.Canvas.Pen.Color:=clblack;
  end;


//==================================================
  {*------
   画推进方模拟开采
   @Image_Out:TImage;   //外部显示图片的 image
    @JinChi,            累计的进尺
    @X_pan_move:double;  图片平移的坐标
    @Tuxing,             岩层填充图形的类型  1 为 标准 1 为仿真
    @disp_two_tu,        显示两幅图  0 只显示 推进方向， 1 显示 推进方向与倾斜方向
    @disp_ylg:integer;    是否显示支撑压力拱  0 不显示 1 显示
    @NQ_step:String;      计算岩梁的方式  挠曲法与步距法
    @gzm:TG_stope;         工作面的类
    @Zk:Tzk_bore;           钻孔的类
   @ ZhiJia:TZJ_Class;      支架的类
   @ imm:TImmediate_roof;   直接顶的类
   @ old:Told_roof          老顶的类
    @ return                返回值为 图片的平移坐标 即   X_pan_move
  }
function TCal_show.DrawFyyd(Image_Out:TImage;JinChi,X_pan_move:double;Tuxing,disp_two_tu,disp_ylg:integer;NQ_step:String;gzm:TG_stope;Zk:Tzk_bore;ZhiJia:TZJ_Class;imm:TImmediate_roof;old:Told_roof):Integer;//游离于类之外的函数
   var
     Y_text_H,Y_text_bl :double;     //　Y 方向文字高度  与比例
     Y_tu_H,Y_tu_Bl :double;     //  Ｙ 方向图形高度  与比例
     X_wid,X_bl: double; // x 方向的总宽度 与比例
     ShiYong_bl:double; //画图中使用的比例
     i,j,k     :integer;   //  临时变量
     TitleText :Widestring; //标题
     Pointxy,Point_t_P,P_i_j_1,Point_wk  :Array [0..3] of TPoint; //  绘制柱矩形变量    4个点
     Point_Six_P,Point_Six_P_2,Point_Six_Right  :Array [0..5] of TPoint; //  绘制不规则图形坐标变量   6个点
     bitmap,BitM   :tbitmap;//定义位图变量
     Image_Inn:TImage;

     s_out:Widestring;//
     ZtPoint :Array [0..3] of Tpoint;//支托层填充数组

     TopBlank,BottomBlank: integer;  //图片上下的空白
     LeftBlank,RightBlank:integer;   // 图片左右的空白

     Yc_End_Nu :integer; //   最上面一层岩层的编号
     Left_Baoliu_wid,Right_Baoliu_wid: double; //图形左侧与右侧保留图形的宽度
     XianShi_kc_wid:double; //显示开采煤层的宽度
     t_Rec     :TRect;// 作为填充支架的工具
     temp_zcyl_sx:double; //临时变量支撑压力分布范围
     jpg: TJPEGImage;
     Zj_lizhu,zc_fd: integer; //记录支架立柱与采煤方法
     ZhiJIa_Zl_xs:double;//支架阻力系数
     temp1 :Str_Dt_array;  //剖返回支架
     Count1:integer;     //剖返回支架变量
     inn_left_y0,inn_left_y2,inn_left_x2,inn_right_y0,inn_right_y2,inn_Right_x2 :integer;  //记录inn 坐标位置
     out_right_y0,out_left_y0,out_left_y1:integer;  //记录out坐标位置
     Old_Beam:array[0..4] of TYL_beam; //计算的岩梁方式
     dll_Path:widestring; //控件
     HanziHeight:Integer;//汉字的高度
     Yl_name_count:Integer; //岩梁的个数
     Table_Title_H:integer;//表头的高度
     tu_max_width:integer; //画布最大的宽度
     X_move_Pix:Integer;//  画布在X方向移动的值
     X_Text_height:integer;//X横坐标 汉字の高度
     YanCengQingJiao,JinChi_sup,Used_h,Step0:double; //岩层倾角，进尺剩余比例
     ganshi_Y0,ganshi_Y1,ganshi_Y2,ganshi_right_x4,ganshi_Count:integer;// 记录矸石终止的岩层数
     ganshi_h:double; //记录矸石的高度
     YockLiang_Suo,while_j_sup_jinchi,Rock_sa,step_i:double; //岩梁内缩的距离
     while_j,while_image:wordbool;//while 循环变量
     Zjd_Wt: integer; //直接顶的位态
     Image_fill_P:TPoint;//图形填充的点
     break_i_105:integer;//break_i_105
     Sink_Sa_used: double;//参与角度计算的下沉量
     t_Str_Fir,t_Str_sec:TStringList;// 字符数组
     Y_min,Sink_leixing: integer; //下标为小得变量
     Zcyl_l_p1,zcyl_l_P2,Zcyl_R_p1,zcyl_R_P2:TPoint; //支撑压力线的坐标
     alert_p1,alert_p2 :TPoint; //预警框 的位置坐标
     Alert_str:string ;// 预警的语句
     YLG_L1,YLG_L2,YLG_R1,YLG_R2:TStringList;//记录 压力拱 的坐标
begin

  //取得Dll自身路径
      dll_Path:=zhijia.OcxPath ;
     // ShowMessage(dll_Path);
      bitmap:=Tbitmap.Create;  //创建位图 bitmap1
      bitM:=Tbitmap.Create;
      t_Str_Fir:=TStringList.Create ;
      t_Str_sec:=TStringList.Create;
      YLG_L1:=TStringList.Create;
      YLG_L2:=TStringList.Create;
      YLG_R1:=TStringList.Create;
      YLG_R2:=TStringList.Create;
      //初始化压力拱 数据
      YLG_L1.Clear ; YLG_L2.Clear ;YLG_R2.Clear ;YLG_R2.Clear ;
      //初始化支架阻力系数
      if JinChi<zk.Yc_Rock[old.YL_start].Step0 then  begin
          ZhiJIa_Zl_xs:=1;
      end else begin
           if ZhiJia.zj_toall_P < ZhiJia.Zj_imm_p *1.5 then  begin
                ZhiJIa_Zl_xs:=0.7;
            end  else  if ZhiJia.zj_toall_P < ZhiJia.Zj_JiSuan_Ci_P[2] then  begin
                ZhiJIa_Zl_xs:=0.8;
            end else if ZhiJia.zj_toall_P < ZhiJia.Zj_JiSuan_C0_P[2] then  begin
                ZhiJIa_Zl_xs:=0.9;
            end else begin
                ZhiJIa_Zl_xs:=1;
            end;
      end;

       //定标题
      if NQ_step='1' then begin   //1 挠曲 算法
            TitleText:=Gzm.S_Name+',编号:'+zk.Zk_name+' 钻孔(挠曲算法):支架岩梁关系图';
            for I := 0 to 4 do
               Old_beam[i]:=zk.Beam_Def[i] ;
      end else begin          //步距算法
            TitleText:=Gzm.S_Name+',编号:'+zk.Zk_name+' 钻孔(步距算法):支架岩梁关系图';
             for I := 0 to 4 do
                Old_beam[i]:=zk.Beam_step[i] ;
      end;
     TitleText:=Gzm.S_Name+',编号:'+zk.Zk_name+' 钻孔(挠曲算法):支架岩梁关系图';

      //判断岩梁的高度
      if old.YL_struc =1 then  begin    // 单岩梁
           for k := 1 downto 0 do
             if Old_beam[k].End_Yc_NO >0 then begin
                   Yc_End_Nu:=Old_beam[k].End_Yc_NO;
                   Yl_name_count:=k+1;
                   break;
              end;  //end if
      end else begin          //多岩梁
          for k := 1 downto 0 do
             if Old_beam[k].End_Yc_NO >0 then begin
                   Yc_End_Nu:=Old_beam[k].End_Yc_NO;
                   Yl_name_count:=k+1;
                   break;
              end;  //end if
      end;
    //初始化岩梁开始
    if model_l=0 then    begin
       model_start_yc:=0;
    end else if  model_l=1 then    begin
       if old.yl_max_End-2 >0  then  begin
          model_start_yc:=old.yl_max_End-2;
       end else begin
          model_start_yc:=0;
       end;
    end else if  model_l=2 then    begin
          model_start_yc:=Yc_End_Nu;
    end;
      //ShowMessage(IntTostr(model_start_yc));
     //空白边界初始化
     TopBlank:=trunc(Image_out.Height/30)+40 ;BottomBlank:=trunc(Image_out.Height/30)+20;
     LeftBlank:=trunc(Image_out.Width/30)+120;RightBlank:=trunc(Image_out.Width/30)+50;
     HanziHeight:=15; Table_Title_H:=15;X_Text_height:=30;
     ganshi_Count:=0;
     X_move_pix:=Trunc(X_pan_move);



      Y_tu_H:=0;
       Yl_name_count:=1;
      for I:=zk.main_coal downto model_start_yc do  begin
            Yl_name_count:=Yl_name_count+1;
            if I=zk.main_coal then  begin
                 Y_tu_H:=Y_tu_H+zk.Yc_Rock[i].R_h*gzm.Mc_FdBs;
            end else begin
                 if i<old.yl_max_End -2 then    begin
                    Y_tu_H:=Y_tu_H+zk.Yc_Rock[i].R_h*hcd_bl;
                 end else begin
                    Y_tu_H:=Y_tu_H+zk.Yc_Rock[i].R_h;
                 end;


            end;
      end; //end for i

       //判断可采煤层是否最后一层
      if zk.main_coal<zk.Zk_Yc_Count-1 then  begin
                 Y_tu_H:=Y_tu_H+zk.Yc_Rock[ zk.main_coal+1].R_h;
             end else begin
                 Y_tu_H:=Y_tu_H+3; //默认3米的粉砂岩
             end;
       // 计算比例
           
           while_j:=true;
           while while_j do  begin
                if Image_out.Height-TopBlank-BottomBlank-X_Text_height-40-Table_Title_H-(Yl_name_count)*HanziHeight< 0 then  begin
                    HanziHeight:=HanziHeight-1;
                end else begin
                    while_j:=false;
                end;

          end;

       Y_Text_Bl:=(Image_out.Height-TopBlank-BottomBlank-X_Text_height-40-Table_Title_H-(Yl_name_count)*HanziHeight)/Y_tu_H;



      Y_tu_BL:=(Image_out.Height-TopBlank-BottomBlank-X_Text_height-40)/Y_tu_H;
   //   Y_Text_Bl:=(Image_out.Height-TopBlank-BottomBlank-X_Text_height-40-(zk.Zk_Yc_Count-Yc_End_Nu+2)*HanziHeight)/Y_tu_H;
     //清除image
      Image_out.Picture.Graphic:=nil;
        Image_out.Canvas.Refresh;
        Image_out.Canvas.FillRect(Image_out.ClientRect); 

      //采高大于钻孔岩层高度的处理   2016.505
        if zk.Yc_Rock[zk.main_coal].R_h< gzm.S_Cg_h then   gzm.S_Cg_h:=zk.Yc_Rock[zk.main_coal].R_h  ;


      //写标题
      Image_out.Canvas.Font.Size := 18;
      Image_out.Canvas.TextOut(trunc(Image_out.Width/2-300),trunc(10),TitleText);
     //画坐标轴

       Image_out.Canvas.MoveTo(LeftBlank,TopBlank-Table_Title_H+40);
       Image_out.Canvas.LineTo(LeftBlank,Image_out.Height-BottomBlank-X_Text_height);
       Image_out.Canvas.LineTo(LeftBlank-120,Image_out.Height-BottomBlank-X_Text_height);

       Image_out.Canvas.MoveTo(LeftBlank-120,TopBlank-Table_Title_H+40-1);
       Image_out.Canvas.LineTo(LeftBlank-120,Image_out.Height-BottomBlank-X_Text_height);
       Image_out.Canvas.MoveTo(LeftBlank-60,TopBlank-Table_Title_H-1+40);
       Image_out.Canvas.LineTo(LeftBlank-60,Image_out.Height-BottomBlank-X_Text_height);
       Image_out.Canvas.MoveTo(LeftBlank-30,TopBlank-Table_Title_H-1+40);
       Image_out.Canvas.LineTo(LeftBlank-30,Image_out.Height-BottomBlank-X_Text_height);
       Image_out.Canvas.MoveTo(LeftBlank-120,TopBlank-Table_Title_H-1+40);
       Image_out.Canvas.LineTo(LeftBlank,TopBlank-Table_Title_H-1+40);   

      //===岩层名称

       Image_out.Canvas.Font.Size := 9;
       Image_out.Canvas.TextOut(LeftBlank-118,TopBlank-Table_Title_H+40,'岩层名称');
       Image_out.Canvas.TextOut(LeftBlank-58,TopBlank-Table_Title_H+40,'厚度');
       //x方向的比例
       X_bl:=(Image_out.Width-LeftBlank-RightBlank)/(Old_beam[0].Step_0_Simple+Old_beam[0].step_i_simple[1]+gzm.ZCYL_sx[0]+gzm.ZCYL_sx[2]);

         shiyong_bl:=Y_tu_BL* self.Zomm_D ;
         if Y_Text_Bl>shiyong_bl  then    Y_Text_Bl:=shiyong_bl ;

       tu_max_width:=trunc((gzm.ZCYL_sx[0]+gzm.ZCYL_sx[1]+gzm.S_L_qx*3)*shiyong_bl);  
         //创建Image_inn
         Image_inn:=TImage.Create(nil);
         Image_inn.Width :=tu_max_width;
         Image_inn.Height :=Image_out.Height-topBlank-BottomBlank;
         //Image_inn.Picture.Graphic.assign(nil);
         Image_inn.Picture.Graphic:=nil;
         Image_inn.Canvas.Refresh;
         Image_inn.Canvas.FillRect(Image_inn.ClientRect);
         image_inn.Canvas.Pen.Color :=clBlack;  
         Image_inn.Canvas.MoveTo(0,Image_inn.Height);  // 横轴
         Image_inn.Canvas.LineTo(Image_inn.Width ,Image_inn.Height);
         //剖分支承压力 数值
          temp1:=Public_Basic.split(Gzm.Return_Zcyl('2.0',Jinchi,zk),';',Count1);
          bitmap.FreeImage;
         //画底板
         if  zk.main_coal=zk.Zk_Yc_Count-1  then  begin // 没有底板
                Pointxy[0].X :=0;
                Pointxy[0].Y :=Image_inn.Height-X_Text_height-trunc(3*shiyong_bl);
                Pointxy[1].X :=Image_inn.Width;
                Pointxy[1].Y :=Pointxy[0].Y;
                Pointxy[2].X :=Pointxy[1].X  ;
                Pointxy[2].Y :=Image_inn.Height-X_Text_height;
                Pointxy[3].X :=Pointxy[0].X ;
                Pointxy[3].Y :=Pointxy[2].Y ;
                Image_inn.Canvas.Brush.Bitmap:=nil;
             //填充图例
                if Tuxing=0 then   begin
                  if  fileexists(dll_Path+'\BmpSi\粉砂岩.Bmp') then  begin
                      bitmap.LoadFromFile(dll_Path+'\BmpSi\粉砂岩.Bmp');//装入图像文件
                  end else begin
                      bitmap.LoadFromFile(dll_Path+'\BmpSi\NULL.Bmp');
                  end;

                end else begin
                    if  fileexists(dll_Path+'\BmpFz\粉砂岩.Bmp') then  begin
                      bitmap.LoadFromFile(dll_Path+'\BmpFZ\粉砂岩.Bmp');//装入图像文件
                    end else begin
                      bitmap.LoadFromFile(dll_Path+'\BmpFz\NULL.Bmp');
                    end;

                end;
                Image_out.Canvas.MoveTo(LeftBlank-120,trunc(Image_out.Height-BottomBlank-X_Text_height-hanziheight-3*Y_Text_Bl));
                Image_out.Canvas.LineTo(LeftBlank-30,trunc(Image_out.Height-BottomBlank-X_Text_height-hanziheight-3*Y_Text_Bl));
                Image_out.Canvas.TextOut(LeftBlank-118,trunc(Image_out.Height-BottomBlank-X_Text_height-hanziheight-3*Y_Text_Bl/2),'粉砂岩');
                Image_out.Canvas.TextOut(LeftBlank-58,trunc(Image_out.Height-BottomBlank-X_Text_height-hanziheight-3*Y_Text_Bl/2),'3');
                //画斜线
                Image_out.Canvas.MoveTo(LeftBlank-30,trunc(Image_out.Height-BottomBlank-X_Text_height-hanziheight-3*Y_Text_Bl));
                Image_out.Canvas.LineTo(LeftBlank, Image_out.Height-BottomBlank-X_Text_height-trunc(3*shiyong_bl));
                out_left_y0:=trunc(Image_out.Height-BottomBlank-X_Text_height-hanziheight-3*Y_Text_Bl);
                out_left_y1:= Image_out.Height-BottomBlank-X_Text_height-trunc(3*shiyong_bl);
            end else begin    //岩层录入有底板
                if zk.Yc_Rock[zk.main_coal+1].R_h <3 then zk.Yc_Rock[zk.main_coal+1].R_h:=3;
                Pointxy[0].X :=0 ;
                Pointxy[0].Y :=Image_inn.Height-X_Text_height-trunc(zk.Yc_Rock[zk.main_coal+1].R_h*shiyong_bl);
                Pointxy[1].X :=Image_inn.Width ;
                Pointxy[1].Y :=Pointxy[0].Y;
                Pointxy[2].X :=Pointxy[1].X  ;
                Pointxy[2].Y :=Image_inn.Height-X_Text_height;
                Pointxy[3].X :=Pointxy[0].X ;
                Pointxy[3].Y :=Pointxy[2].Y ;
                Image_inn.Canvas.Brush.Bitmap:=nil;
             //填充图例
                if Tuxing=0 then   begin
                  if  fileexists(dll_Path+'\BmpSi\'+zk.Yc_Rock[zk.main_coal+1].R_Name+'.Bmp') then  begin
                      bitmap.LoadFromFile(dll_Path+'\BmpSi\'+zk.Yc_Rock[zk.main_coal+1].R_Name+'.Bmp');//装入图像文件
                  end else begin
                      bitmap.LoadFromFile(dll_Path+'\BmpSi\NULL.Bmp');
                  end;

                end else begin
                    if  fileexists(dll_Path+'\BmpFZ\'+zk.Yc_Rock[zk.main_coal+1].R_Name+'.Bmp') then  begin
                      bitmap.LoadFromFile(dll_Path+'\BmpFZ\'+zk.Yc_Rock[zk.main_coal+1].R_Name+'.Bmp');//装入图像文件
                    end else begin
                      bitmap.LoadFromFile(dll_Path+'\BmpFz\NULL.Bmp');
                    end;

                end;
                Image_out.Canvas.MoveTo(LeftBlank-120,trunc(Image_out.Height-BottomBlank-X_Text_height-hanziheight-zk.Yc_Rock[zk.main_coal+1].R_h*Y_Text_Bl));
                Image_out.Canvas.LineTo(LeftBlank-30,trunc(Image_out.Height-BottomBlank-X_Text_height-hanziheight-zk.Yc_Rock[zk.main_coal+1].R_h*Y_Text_Bl));
                Image_out.Canvas.TextOut(LeftBlank-118,trunc(Image_out.Height-BottomBlank-X_Text_height-hanziheight-zk.Yc_Rock[zk.main_coal+1].R_h*Y_Text_Bl/2),zk.Yc_Rock[zk.main_coal+1].R_Name);
                Image_out.Canvas.TextOut(LeftBlank-58,trunc(Image_out.Height-BottomBlank-X_Text_height-hanziheight-zk.Yc_Rock[zk.main_coal+1].R_h*Y_Text_Bl/2),FormatFloat('0.0',zk.Yc_Rock[zk.main_coal+1].R_h));
                //画斜线
                Image_out.Canvas.MoveTo(LeftBlank-30,trunc(Image_out.Height-BottomBlank-X_Text_height-hanziheight-zk.Yc_Rock[zk.main_coal+1].R_h*Y_Text_Bl));
                Image_out.Canvas.LineTo(LeftBlank, Image_out.Height-BottomBlank-X_Text_height-trunc(zk.Yc_Rock[zk.main_coal+1].R_h*shiyong_bl));
                out_left_y0:=trunc(Image_out.Height-BottomBlank-X_Text_height-hanziheight-zk.Yc_Rock[zk.main_coal+1].R_h*Y_Text_Bl);
                out_left_y1:=Image_out.Height-BottomBlank-X_Text_height-trunc(zk.Yc_Rock[zk.main_coal+1].R_h*shiyong_bl);
            end; //end   if  Yc_Xiabiao = zk.main_coal  then  begin // 没有底板
             //无论有没有底板，都填充
             Image_inn.Canvas.Polygon(Pointxy) ;
             Image_inn.Canvas.Brush.Bitmap:=bitmap;
               if   (Pointxy[2].Y-Pointxy[1].Y>4)  then
                    Image_inn.Canvas.FloodFill(Trunc((Pointxy[0].X+Pointxy[1].X)/2),Trunc((Pointxy[1].Y+Pointxy[2].Y)/2),clBlack,fsBorder);
              inn_left_y0:=  Pointxy[0].Y;
                 //画底板斜面
                Pointxy[0].X := Image_out.Width -RightBlank ;
                Pointxy[0].Y :=Image_out.Height-BottomBlank-Image_inn.Height+Pointxy[0].Y ;
                Pointxy[3].X := Pointxy[0].X ;
                Pointxy[3].Y := Image_out.Height-BottomBlank-X_Text_height ;

                Pointxy[1].X := Pointxy[0].X+40 ;
                Pointxy[1].Y := Pointxy[0].Y-40;

                Pointxy[2].X := Pointxy[3].X+40 ;
                Pointxy[2].Y := Pointxy[3].Y-40;
                Image_out.Canvas.Polygon(Pointxy) ;
                Image_out.Canvas.Brush.Bitmap:=bitmap;   // 图片是底板的图片
                 if   (Pointxy[2].Y-Pointxy[1].Y>4)  then
                        Image_Out.Canvas.FloodFill(Trunc(Pointxy[0].X+1),Trunc((Pointxy[0].Y+Pointxy[3].Y)/2),clBlack,fsBorder);
                Image_out.Canvas.Brush.Bitmap:=nil;
                out_right_y0:=Pointxy[0].Y ;
                //标志X 横坐标
                 for I := 0 to round((gzm.S_L_qx*3)/10)-1 do
                 begin
                     image_inn.Canvas.MoveTo (trunc((gzm.ZCYL_sx[2]+i*10)*shiyong_bl),image_inn.Height-X_Text_height);
                     image_inn.Canvas.LineTo (trunc((gzm.ZCYL_sx[2]+i*10)*shiyong_bl),image_inn.Height-X_Text_height+5);
                     Image_inn.Canvas.TextOut(trunc((gzm.ZCYL_sx[2]+i*10)*shiyong_bl)+1,image_inn.Height-X_Text_height,Inttostr(i*10));
                 end;


           //煤层
            //画煤层
                    //填充图例
                   bitmap.FreeImage;
                   bitmap.LoadFromFile(dll_Path+'\BmpSi\煤.Bmp');//装入图像文件


                    //左侧
                      Point_Six_P[5].X :=0;
                           Point_Six_P[5].Y := inn_left_y0 ;
                      Point_Six_P[3].X :=Point_Six_P[5].X +trunc(gzm.ZCYL_sx[2]*shiyong_bl);
                           Point_Six_P[3].Y :=Point_Six_P[5].Y;
                      Point_Six_P[4].X :=Point_Six_P[3].X -trunc(StrToFloat(temp1[1])*shiyong_bl);
                           Point_Six_P[4].Y :=Point_Six_P[5].Y;
                      Point_Six_P[0].X :=Point_Six_P[5].X;
                           Point_Six_P[0].Y :=Point_Six_P[5].Y-trunc(gzm.S_Cg_h*gzm.Mc_FdBs*shiyong_bl);;
                      Point_Six_P[1].X :=Point_Six_P[4].X;
                           Point_Six_P[1].Y :=Point_Six_P[0].Y;
                      Point_Six_P[2].X :=Point_Six_P[3].X;
                           Point_Six_P[2].Y :=Point_Six_P[3].Y-trunc(gzm.S_Cg_h*ZhiJIa_Zl_xs*gzm.Mc_FdBs*shiyong_bl);;


                     Image_inn.Canvas.Brush.Bitmap:=nil;
                      Image_inn.Canvas.Polygon(Point_Six_P) ;
                      Image_inn.Canvas.Brush.Bitmap:=bitmap;    //煤层的 图例
                         if   (Point_Six_P[4].Y-Point_Six_P[1].Y>4)  then
                              Image_inn.Canvas.FloodFill(Trunc((Point_Six_P[0].X+Point_Six_P[3].X)/2),Trunc((Point_Six_P[1].Y+Point_Six_P[4].Y)/2),clBlack,fsBorder);
                      Image_inn.Canvas.Brush.Bitmap:=nil;
                       //

                      //填写左侧压力拱数据
                      if zk.Yc_Rock[zk.main_coal].R_h<= gzm.S_Cg_h then  begin
                            YLG_L1.Add(InttoStr(Point_Six_P[1].X)+','+InttoStr(Point_Six_P[1].Y) );
                            YLG_L2.Add(InttoStr(Point_Six_P[1].X-trunc(StrToFloat(temp1[4])*shiyong_bl))+','+InttoStr(Point_Six_P[1].Y) );
                      end;

                   //画支架
                     if Gzm.S_cmfs='4' then begin
                          zc_fd :=2;
                     end else begin
                          zc_fd :=1;
                     end;
                     if ZhiJia.JG_jx='JX2' then begin
                         zj_lizhu:=2;
                     end else begin
                         zj_lizhu:=4;
                     end;
                   
                      zhijia.Draw_zhiJia(Image_inn,
                                      Point_Six_P[2].X+trunc((jinchi+zhijia.Zj_KongdingJU)*shiyong_bl),
                                      Point_Six_P[2].Y,
                                      Point_Six_P[3].X+trunc(jinchi*shiyong_bl),
                                      Point_Six_P[3].Y,
                                      Gzm.S_Cg_h, zj_lizhu, zc_fd);

                     ganshi_right_x4:=Point_Six_P[3].X+trunc((jinchi-zhijia.Zj_KongdingJU)*shiyong_bl);

                     //根据进尺确定X的移动距离   屏幕向左移动
                      while  Image_out.Width-LeftBlank-RightBlank-Point_Six_P[2].X-trunc((jinchi+zhijia.Zj_KongdingJU)*shiyong_bl)+X_move_pix< Image_out.Width /30 do
                             X_move_pix:=X_move_pix+trunc(Image_out.Width/5);
                     //根据进尺确定X的移动距离   屏幕想向移动
                      while  Image_out.Width-LeftBlank-RightBlank-Point_Six_P[2].X-trunc((jinchi+zhijia.Zj_KongdingJU)*shiyong_bl)+X_move_pix > Image_out.Width /30*22 do
                             X_move_pix:=X_move_pix-trunc(Image_out.Width/5);



                     //右侧煤层
                      Point_Six_P[5].X :=Image_inn.Width  ;
                            Point_Six_P[5].Y := inn_left_y0 ;
                      Point_Six_P[3].X :=Point_Six_P[2].X+trunc((jinchi+zhijia.Zj_KongdingJU)*shiyong_bl);
                           Point_Six_P[3].Y :=Point_Six_P[5].Y;
                      Point_Six_P[4].X :=Point_Six_P[3].X +trunc(StrToFloat(temp1[1])*shiyong_bl);
                           Point_Six_P[4].Y :=Point_Six_P[5].Y;
                      Point_Six_P[0].X :=Point_Six_P[5].X;
                           Point_Six_P[0].Y :=Point_Six_P[5].Y-trunc(gzm.S_Cg_h*gzm.Mc_FdBs*shiyong_bl);;
                      Point_Six_P[1].X :=Point_Six_P[4].X;
                           Point_Six_P[1].Y :=Point_Six_P[0].Y;
                      Point_Six_P[2].X :=Point_Six_P[3].X;
                           Point_Six_P[2].Y :=Point_Six_P[3].Y-trunc(gzm.S_Cg_h*ZhiJIa_Zl_xs*gzm.Mc_FdBs*shiyong_bl);

                      Image_inn.Canvas.Brush.Bitmap:=nil;
                      Image_inn.Canvas.Polygon(Point_Six_P) ;
                      Image_inn.Canvas.Brush.Bitmap:=bitmap;
                         if   (Point_Six_P[4].Y-Point_Six_P[1].Y>4)  then
                              Image_inn.Canvas.FloodFill(Trunc((Point_Six_P[0].X+Point_Six_P[3].X)/2),Trunc((Point_Six_P[1].Y+Point_Six_P[4].Y)/2),clBlack,fsBorder);
                      Image_inn.Canvas.Brush.Bitmap:=nil;

                     //封存 2016.6.5
                       //填写右侧压力拱数据
                        if zk.Yc_Rock[zk.main_coal].R_h<= gzm.S_Cg_h then  begin
                              YLG_R1.add(InttoStr(Point_Six_P[4].X)+','+InttoStr(Point_Six_P[2].Y) );
                              YLG_R2.add(InttoStr(Point_Six_P[4].X+trunc(StrToFloat(temp1[4])*shiyong_bl))+','+InttoStr(Point_Six_P[2].Y) );
                             
                        end;

                      inn_left_y0:=Point_Six_P[0].Y ;inn_left_y2:=Point_Six_P[2].Y;
                      ganshi_Y0:=Point_Six_P[5].Y;

                       //image_out 标注
                       // 画煤层斜面
                      Pointxy[3].X := Image_out.Width -RightBlank;
                      Pointxy[3].Y := out_right_y0;
                      Pointxy[0].X :=  Pointxy[3].X;
                      Pointxy[0].Y := Pointxy[3].Y -trunc(zk.Yc_Rock[zk.main_coal].R_h*gzm.Mc_FdBs*shiyong_bl);
                      Pointxy[1].X := Pointxy[0].X+40 ;
                      Pointxy[1].Y := Pointxy[0].Y-40;

                      Pointxy[2].X := Pointxy[3].X+40 ;
                      Pointxy[2].Y := Pointxy[3].Y-40;
                      Image_out.Canvas.Polygon(Pointxy) ;
                      Image_out.Canvas.Brush.Bitmap:=bitmap; //煤层的图片
                       if   (Pointxy[2].Y-Pointxy[1].Y>4)  then
                              Image_Out.Canvas.FloodFill(Trunc(Pointxy[0].X+1),Trunc((Pointxy[0].Y+Pointxy[3].Y)/2),clBlack,fsBorder);
                      Image_out.Canvas.Brush.Bitmap:=nil;
                      Image_out.Canvas.MoveTo(LeftBlank-120,trunc(Out_left_y0-hanziheight-zk.Yc_Rock[zk.main_coal].R_h*gzm.Mc_FdBs*Y_Text_Bl));
                      Image_out.Canvas.LineTo(LeftBlank-30,trunc(Out_left_y0-hanziheight-zk.Yc_Rock[zk.main_coal].R_h*gzm.Mc_FdBs*Y_Text_Bl));
                      Image_out.Canvas.TextOut(LeftBlank-118,trunc(Out_left_y0-hanziheight-zk.Yc_Rock[zk.main_coal].R_h*gzm.Mc_FdBs*Y_Text_Bl/2),'煤');
                      Image_out.Canvas.TextOut(LeftBlank-58,trunc(Out_left_y0-hanziheight-zk.Yc_Rock[zk.main_coal].R_h*gzm.Mc_FdBs*Y_Text_Bl/2),FormatFloat('0.0',zk.Yc_Rock[zk.main_coal].R_h));
                      //画斜线
                      Image_out.Canvas.MoveTo(LeftBlank-30,trunc(Out_left_y0-hanziheight-zk.Yc_Rock[zk.main_coal].R_h*gzm.Mc_FdBs*Y_Text_Bl));
                      Image_out.Canvas.LineTo(LeftBlank, Out_left_y1-trunc(zk.Yc_Rock[zk.main_coal].R_h*gzm.Mc_FdBs*shiyong_bl));
                      out_left_y0:=trunc(Out_left_y0-hanziheight-zk.Yc_Rock[zk.main_coal].R_h*gzm.Mc_FdBs*Y_Text_Bl);
                      out_left_y1:=Out_left_y1-trunc(zk.Yc_Rock[zk.main_coal].R_h*gzm.Mc_FdBs*shiyong_bl);
                  for I:=zk.main_coal-1 downto model_start_yc do  begin
                      // 画斜面
                      Pointxy[3].X := Image_out.Width -RightBlank;
                      Pointxy[3].Y := Pointxy[0].Y;
                      Pointxy[0].X := Pointxy[3].X;
                      if i<old.yl_max_End-2 then  begin
                           Pointxy[0].Y := Pointxy[3].Y -trunc(zk.Yc_Rock[i].R_h*hcd_bl*shiyong_bl);
                      end else begin
                           Pointxy[0].Y := Pointxy[3].Y -trunc(zk.Yc_Rock[i].R_h*shiyong_bl);
                      end;

                      Pointxy[1].X := Pointxy[0].X+40 ;
                      Pointxy[1].Y := Pointxy[0].Y-40;

                      Pointxy[2].X := Pointxy[3].X+40 ;
                      Pointxy[2].Y := Pointxy[3].Y-40;

                      bitmap.FreeImage;
                       if Tuxing=0 then   begin
                           if  fileexists(dll_Path+'\BmpSi\'+zk.Yc_Rock[i].R_Name+'.Bmp') then  begin
                               bitmap.LoadFromFile(dll_Path+'\BmpSi\'+zk.Yc_Rock[i].R_Name+'.Bmp');//装入图像文件
                            end else begin
                               bitmap.LoadFromFile(dll_Path+'\BmpSi\NULL.Bmp');
                            end;
                       end else begin
                            if  fileexists(dll_Path+'\BmpFZ\'+zk.Yc_Rock[i].R_Name+'.Bmp') then  begin
                                bitmap.LoadFromFile(dll_Path+'\BmpFZ\'+zk.Yc_Rock[i].R_Name+'.Bmp');//装入图像文件
                            end else begin
                                bitmap.LoadFromFile(dll_Path+'\BmpFz\NULL.Bmp');
                            end;
                       end;
                      Image_out.Canvas.Brush.Bitmap:=nil;
                      Image_out.Canvas.Polygon(Pointxy) ;
                      Image_out.Canvas.Brush.Bitmap:=bitmap;
                       if   (Pointxy[2].Y-Pointxy[1].Y>4)  then
                              Image_Out.Canvas.FloodFill(Trunc(Pointxy[0].X+1),Trunc((Pointxy[0].Y+Pointxy[3].Y)/2),clBlack,fsBorder);
                      //如果最后一层 画斜面
                        if i=model_start_yc then  begin

                            Pointxy[2].X := Pointxy[0].X ;
                            Pointxy[2].Y := Pointxy[0].Y ;
                            Pointxy[3].X := Pointxy[2].X-5 ;
                            Pointxy[3].Y := Pointxy[2].Y ;

                            Pointxy[0].X := Pointxy[3].X ;
                            Pointxy[0].Y := Pointxy[1].Y;

                               Image_out.Canvas.Brush.Bitmap:=nil;
                               Image_out.Canvas.Polygon(Pointxy) ;
                               Image_out.Canvas.Brush.Bitmap:=bitmap;
                                if   (Pointxy[2].Y-Pointxy[1].Y>4)  then
                                      Image_out.Canvas.FloodFill(Trunc(Pointxy[0].X+1),Trunc((Pointxy[0].Y+Pointxy[3].Y)/2),clBlack,fsBorder);

                        end;
                   if i<old.yl_max_End-2 then  begin
                      Image_out.Canvas.MoveTo(LeftBlank-120,trunc(Out_left_y0-hanziheight-zk.Yc_Rock[i].R_h*hcd_bl*Y_Text_Bl));
                      Image_out.Canvas.LineTo(LeftBlank-30,trunc(Out_left_y0-hanziheight-zk.Yc_Rock[i].R_h*hcd_bl*Y_Text_Bl));
                      //写岩层的名字
                      Image_out.Canvas.TextOut(LeftBlank-118,trunc(Out_left_y0-hanziheight-zk.Yc_Rock[i].R_h*hcd_bl*Y_Text_Bl/2),zk.Yc_Rock[i].R_Name);
                      Image_out.Canvas.TextOut(LeftBlank-58,trunc(Out_left_y0-hanziheight-zk.Yc_Rock[i].R_h*hcd_bl*Y_Text_Bl/2),FormatFloat('0.0',zk.Yc_Rock[i].R_h));
                      //画斜线
                      Image_out.Canvas.MoveTo(LeftBlank-30,trunc(Out_left_y0-hanziheight-zk.Yc_Rock[i].R_h*hcd_bl*Y_Text_Bl));
                      Image_out.Canvas.LineTo(LeftBlank, Out_left_y1-trunc(zk.Yc_Rock[i].R_h*hcd_bl*shiyong_bl));
                      out_left_y0:=trunc(Out_left_y0-hanziheight-zk.Yc_Rock[i].R_h*hcd_bl*Y_Text_Bl);
                      out_left_y1:=Out_left_y1-trunc(zk.Yc_Rock[i].R_h*hcd_bl*shiyong_bl);
                   end else begin
                      Image_out.Canvas.MoveTo(LeftBlank-120,trunc(Out_left_y0-hanziheight-zk.Yc_Rock[i].R_h*Y_Text_Bl));
                      Image_out.Canvas.LineTo(LeftBlank-30,trunc(Out_left_y0-hanziheight-zk.Yc_Rock[i].R_h*Y_Text_Bl));
                     //写岩层的名字
                      Image_out.Canvas.TextOut(LeftBlank-118,trunc(Out_left_y0-hanziheight-zk.Yc_Rock[i].R_h*Y_Text_Bl/2),zk.Yc_Rock[i].R_Name);
                      Image_out.Canvas.TextOut(LeftBlank-58,trunc(Out_left_y0-hanziheight-zk.Yc_Rock[i].R_h*Y_Text_Bl/2),FormatFloat('0.0',zk.Yc_Rock[i].R_h));
                      //画斜线
                      Image_out.Canvas.MoveTo(LeftBlank-30,trunc(Out_left_y0-hanziheight-zk.Yc_Rock[i].R_h*Y_Text_Bl));
                      Image_out.Canvas.LineTo(LeftBlank, Out_left_y1-trunc(zk.Yc_Rock[i].R_h*shiyong_bl));
                      out_left_y0:=trunc(Out_left_y0-hanziheight-zk.Yc_Rock[i].R_h*Y_Text_Bl);
                      out_left_y1:=Out_left_y1-trunc(zk.Yc_Rock[i].R_h*shiyong_bl);
                   end;// end if
                 end; // end for i := 0 to List.Count - 1 do

            //画顶煤
               bitmap.FreeImage;
               bitM.FreeImage;
               ganshi_h:=0;
            if (zk.Yc_Rock[zk.main_coal].R_h-Gzm.S_Cg_h)>=0.5 then begin     //如果有顶煤
                  //左侧顶煤
                    bitM.LoadFromFile(dll_Path+'\BmpSi\煤.Bmp');//装入图像文件
                    Point_Six_P[5].X :=0;
                         Point_Six_P[5].Y :=inn_left_y0;
                      Point_Six_P[3].X :=Point_Six_P[5].X +trunc(gzm.ZCYL_sx[2]*shiyong_bl);
                           Point_Six_P[3].Y :=inn_left_y2;
                      Point_Six_P[4].X :=Point_Six_P[3].X -trunc(StrToFloat(temp1[1])*shiyong_bl);
                           Point_Six_P[4].Y :=Point_Six_P[5].Y;
                      Point_Six_P[0].X :=Point_Six_P[5].X;
                           Point_Six_P[0].Y :=Point_Six_P[5].Y-trunc((zk.Yc_Rock[zk.main_coal].R_h-Gzm.S_Cg_h)*gzm.Mc_FdBs*shiyong_bl);
                      Point_Six_P[1].X :=Point_Six_P[4].X;
                           Point_Six_P[1].Y :=Point_Six_P[0].Y;
                      Point_Six_P[2].X :=Point_Six_P[3].X;
                           Point_Six_P[2].Y :=Point_Six_P[3].Y-trunc((zk.Yc_Rock[zk.main_coal].R_h-Gzm.S_Cg_h)*ZhiJIa_Zl_xs*gzm.Mc_FdBs*shiyong_bl);

                      Image_inn.Canvas.Brush.Bitmap:=nil;
                      Image_inn.Canvas.Polygon(Point_Six_P) ;
                      Image_inn.Canvas.Brush.Bitmap:=bitM;
                       if  (Point_Six_P[4].Y-Point_Six_P[1].Y>4)  then
                            Image_inn.Canvas.FloodFill(Trunc((Point_Six_P[0].X+Point_Six_P[3].X)/2),Trunc((Point_Six_P[1].Y+Point_Six_P[4].Y)/2),clBlack,fsBorder);
                       //填写左侧压力拱数据
                      YLG_L1.Add(InttoStr(Point_Six_P[1].X)+','+InttoStr(Point_Six_P[1].Y) );
                      YLG_L2.Add(InttoStr(Point_Six_P[1].X-trunc(StrToFloat(temp1[4])*shiyong_bl))+','+InttoStr(Point_Six_P[1].Y));

                      //右侧顶煤
                     //支架上方部分
                                    Point_Six_P[5].X :=Image_inn.Width  ;
                                          Point_Six_P[5].Y := inn_left_y0;
                                    Point_Six_P[3].X :=Point_Six_P[2].X+trunc((Jinchi+zhijia.Zj_KongdingJU/60*22)*shiyong_bl);
                                         Point_Six_P[3].Y :=Point_Six_P[3].Y;
                                    Point_Six_P[4].X :=Point_Six_P[3].X +trunc(StrToFloat(temp1[1])*shiyong_bl);
                                         Point_Six_P[4].Y :=Point_Six_P[5].Y;
                                    Point_Six_P[0].X :=Point_Six_P[5].X;
                                         Point_Six_P[0].Y :=Point_Six_P[5].Y-trunc((zk.Yc_Rock[zk.main_coal].R_h-Gzm.S_Cg_h)*gzm.Mc_FdBs*shiyong_bl);
                                    Point_Six_P[1].X :=Point_Six_P[4].X;
                                         Point_Six_P[1].Y :=Point_Six_P[0].Y;
                                    Point_Six_P[2].X :=Point_Six_P[3].X;
                                         Point_Six_P[2].Y :=Point_Six_P[3].Y-trunc((zk.Yc_Rock[zk.main_coal].R_h-Gzm.S_Cg_h)*ZhiJIa_Zl_xs*gzm.Mc_FdBs*shiyong_bl);


                                   Image_inn.Canvas.Brush.Bitmap:=nil;
                                    Image_inn.Canvas.Polygon(Point_Six_P) ;
                                    Image_inn.Canvas.Brush.Bitmap:=bitM;    //煤层的 图例
                                       if   (Point_Six_P[4].Y-Point_Six_P[1].Y>4)  then
                                            Image_inn.Canvas.FloodFill(Trunc((Point_Six_P[0].X+Point_Six_P[3].X)/2),Trunc((Point_Six_P[1].Y+Point_Six_P[4].Y)/2),clBlack,fsBorder);
                                    Image_inn.Canvas.Brush.Bitmap:=nil;

                                      // 支架后背部分
                                      Point_Six_P_2[0].X :=Point_Six_P[3].X ;
                                          Point_Six_P_2[0].Y :=Point_Six_P[3].Y;

                                      Point_Six_P_2[5].X :=Point_Six_P[2].X ;
                                          Point_Six_P_2[5].Y :=Point_Six_P[2].Y;


                                      Point_Six_P_2[1].X :=Point_Six_P_2[0].X-trunc((zhijia.Zj_KongdingJU/60*22)*shiyong_bl); ;
                                          Point_Six_P_2[1].Y :=Point_Six_P[3].Y+trunc(gzm.S_Cg_h*gzm.Mc_FdBs*shiyong_bl);;
                                      Point_Six_P_2[4].X :=Point_Six_P_2[1].X ;
                                          Point_Six_P_2[4].Y :=Point_Six_P_2[5].Y;

                                      Point_Six_P_2[2].X :=Point_Six_P_2[1].X+trunc((zhijia.Zj_KongdingJU/60*3)*shiyong_bl); ;
                                          Point_Six_P_2[2].Y :=Point_Six_P_2[1].Y-trunc(gzm.S_Cg_h*0.75*gzm.Mc_FdBs*shiyong_bl);

                                      Point_Six_P_2[3].X :=Point_Six_P_2[2].X-trunc((zk.Yc_Rock[zk.main_coal].R_h-gzm.S_Cg_h)*0.95*0.2*shiyong_bl);
                                          Point_Six_P_2[3].Y :=Point_Six_P_2[2].Y-trunc((zk.Yc_Rock[zk.main_coal].R_h-gzm.S_Cg_h)*0.95*shiyong_bl);

                                       Image_inn.Canvas.Brush.Bitmap:=nil;
                                    Image_inn.Canvas.Polygon(Point_Six_P_2) ;
                                    Image_inn.Canvas.Brush.Bitmap:=bitM;    //煤层的 图例
                                       if   (Point_Six_P_2[1].Y-Point_Six_P_2[4].Y>3)  then
                                            Image_inn.Canvas.FloodFill(Trunc((Point_Six_P_2[0].X+Point_Six_P_2[3].X)/2),Trunc((Point_Six_P_2[1].Y+Point_Six_P_2[4].Y)/2),clBlack,fsBorder);
                                    Image_inn.Canvas.Brush.Bitmap:=nil;
                                 

                     //填写右侧压力拱数据
                      YLG_R1.Insert(0,InttoStr(Point_Six_P[4].X)+','+InttoStr(Point_Six_P[2].Y) );
                      YLG_R2.insert(0,InttoStr(Point_Six_P[4].X+trunc(StrToFloat(temp1[4])*shiyong_bl))+','+InttoStr(Point_Six_P[2].Y) );

                     inn_left_y0:=Point_Six_P[0].Y ;inn_left_y2:=Point_Six_P[2].Y;
                     ganshi_Count:=1;  ganshi_h :=zk.Yc_Rock[zk.main_coal].R_h-Gzm.S_Cg_h-Gzm.S_Fm_h;
                     ganshi_right_x4:=Point_Six_P[2].X-trunc((zhijia.Zj_KongdingJU/60*22)*shiyong_bl);
              end;
               //左侧直接顶
               inn_left_y0:=Point_Six_P[0].Y ;inn_left_y2:=Point_Six_P[2].Y;
               inn_right_y0:=Point_Six_P[0].Y ;inn_right_y2:=Point_Six_P[2].Y;
               inn_left_x2 :=trunc(gzm.ZCYL_sx[2]*shiyong_bl);  inn_Right_x2 :=trunc((Jinchi+gzm.ZCYL_sx[2])*shiyong_bl);
               ganshi_y1:=Point_Six_P[0].Y; YockLiang_Suo:=0;//first
               zcyl_L_P2.X:=inn_left_x2;   zcyl_l_P2.Y:=inn_left_y2;

               zcyl_R_P2.X:=trunc((Jinchi+gzm.ZCYL_sx[2]+zhijia.Zj_KongdingJU)*shiyong_bl);   zcyl_R_P2.Y:=inn_Right_y2;

               Zjd_Wt :=0;//直接顶的位态；
                  for I := imm.Start_No  downto imm.End_No do
                     begin
                        //
                        Step0:=zk.Yc_Rock[i].Step0;
                        if (i=imm.End_No) and (imm.Surplus_h>0) then    begin
                            used_h:= zk.Yc_Rock[i].R_h-imm.Surplus_h;
                            Step0:=sqrt(1000*2*used_h*zk.Yc_Rock[i].R_klqd/zk.Yc_Rock[i].R_r);
                        end else begin
                            used_h:= zk.Yc_Rock[i].R_h;
                        end;
                         //填充图例
                           bitM.FreeImage;
                           if Tuxing=0 then   begin
                              if  fileexists(dll_Path+'\BmpSi\'+zk.Yc_Rock[i].R_Name+'.Bmp') then  begin
                                  bitM.LoadFromFile(dll_Path+'\BmpSi\'+zk.Yc_Rock[i].R_Name+'.Bmp');//装入图像文件
                              end else begin
                                  bitM.LoadFromFile(dll_Path+'\BmpSi\NULL.Bmp');
                              end;

                             end else begin
                                if  fileexists(dll_Path+'\BmpFZ\'+zk.Yc_Rock[i].R_Name+'.Bmp') then  begin
                                  bitM.LoadFromFile(dll_Path+'\BmpFZ\'+zk.Yc_Rock[i].R_Name+'.Bmp');//装入图像文件
                                end else begin
                                  bitM.LoadFromFile(dll_Path+'\BmpFz\NULL.Bmp');
                                end;
                            end;

                        if jinChi+zhijia.Zj_KongdingJU+2*StrToFloat(temp1[1])-2*YockLiang_Suo< Step0 * 0.95  then  begin
                            break;
                        end else if  jinChi+zhijia.Zj_KongdingJU+2*StrToFloat(temp1[1])-2*YockLiang_Suo<= Step0*1.05  then   begin
                           //左侧

                             Point_Six_P[5].X :=0;
                                 Point_Six_P[5].Y :=inn_left_y0;

                             Point_Six_P[3].X :=inn_left_x2-trunc((StrToFloat(temp1[1])+YockLiang_Suo)*shiyong_bl);
                                 if StrToFloat(temp1[3])>0 then begin
                                      Point_Six_P[3].Y :=inn_left_y2-trunc((inn_left_y2-inn_left_y0)*(StrToFloat(temp1[3])-StrToFloat(temp1[1]))/StrToFloat(temp1[3]));
                                 end else begin
                                      Point_Six_P[3].Y :=inn_left_y2;
                                 end;
                             Point_Six_P[0].X :=Point_Six_P[5].X;
                                   Point_Six_P[0].Y :=Point_Six_P[5].Y-trunc(used_h*shiyong_bl);
                             Point_Six_P[2].X :=Point_Six_P[3].X;
                                   Point_Six_P[2].Y :=Point_Six_P[3].Y-trunc(used_h*shiyong_bl);
                              Point_Six_P[4].X :=inn_left_x2 -trunc(StrToFloat(temp1[1])*shiyong_bl);
                                   Point_Six_P[4].Y :=Point_Six_P[5].Y;
                              Point_Six_P[1].X :=Point_Six_P[4].X;
                                   Point_Six_P[1].Y :=Point_Six_P[0].Y;

                               Image_inn.Canvas.Polygon(Point_Six_P) ;
                               Image_inn.Canvas.Brush.Bitmap:=bitM;
                               Image_fill_P.x :=Trunc((Point_Six_P[5].X+Point_Six_P[3].X)/2); Image_fill_P.y:= Trunc((Point_Six_P[1].Y+Point_Six_P[4].Y)/2);
                                 while_image:=true;
                                 k:=0;
                                 while while_image  do begin
                                      if Public_Basic.IsPtInPoly (Image_fill_P.x,Image_fill_P.y,Point_Six_P) then begin
                                         Image_inn.Canvas.FloodFill(Image_fill_P.x ,Image_fill_P.y,clBlack,fsBorder);
                                         while_image:=false;
                                      end else begin
                                          K:=K+1;
                                          Image_fill_P.x :=Point_Six_P[5].X+K; Image_fill_P.y:=  Point_Six_P[5].Y-1;
                                          if K>5 then  while_image:=false;

                                      end;

                                 end;   //end while

                              Image_inn.Canvas.Brush.Bitmap:=nil;
                               //填写左侧压力拱数据
                              YLG_L1.Add(InttoStr(Point_Six_P[1].X)+','+InttoStr(Point_Six_P[1].Y) );
                              YLG_L2.Add(InttoStr(Point_Six_P[1].X-trunc(StrToFloat(temp1[4])*shiyong_bl))+','+InttoStr(Point_Six_P[1].Y) );
                             // if i=Yc_End_Nu then  begin
                                    Point_wk[3].X := Point_Six_P[0].X ;
                                    Point_wk[3].Y := Point_Six_P[0].Y;
                                    Point_wk[2].X := Point_Six_P[2].X; 
                                    Point_wk[2].Y := Point_Six_P[2].Y;

                                    Point_wk[0].X := Point_wk[3].X+40 ;
                                    Point_wk[0].Y := Point_wk[3].Y-40;
                                    Point_wk[1].X := Point_wk[2].X+40;
                                    Point_wk[1].Y := Point_wk[2].Y-40;
                                      Image_inn.Canvas.Brush.Bitmap:=nil;
                                      Image_inn.Canvas.Polygon(Point_wk);
                                      Image_inn.Canvas.Brush.Bitmap:=bitM;
                                        //图形填充
                                         Image_fill_P.x :=Trunc((Point_wk[0].X+Point_wk[2].X)/2); Image_fill_P.y:= Trunc((Point_wk[0].Y+Point_wk[2].Y)/2);
                                         while_image:=true;
                                         k:=0;
                                         while while_image  do begin
                                              if Public_Basic.IsPtInPoly (Image_fill_P.x,Image_fill_P.y,Point_wk) then begin
                                                 Image_inn.Canvas.FloodFill(Image_fill_P.x ,Image_fill_P.y,clBlack,fsBorder);
                                                 while_image:=false;
                                              end else begin
                                                  K:=K+1;
                                                  Image_fill_P.x :=Point_wk[0].X+K; Image_fill_P.y:=  Point_wk[0].Y;
                                                  if K>5 then  while_image:=false;
                                              end;

                                         end; // end while

                             // end;  //end  if i=Yc_End_Nu then  begin
                              //2015.6014 由转4247移到4103  行/
                            // ganshi_right_x4:= inn_left_x2+trunc((jinchi-zhijia.Zj_KongdingJU)*shiyong_bl);
                              ganshi_right_x4:= inn_left_x2+trunc((jinchi)*shiyong_bl);

                              inn_left_y0:=Point_Six_P[0].Y ;inn_left_y2:=Point_Six_P[2].Y;inn_left_x2 := Point_Six_P[2].X ;
                             //第一块
                               JinChi_sup:=Jinchi+zhijia.Zj_KongdingJU+2*StrToFloat(temp1[1])-step0*0.95;
                               YanCengQingJiao:=(arctan(used_h/Step0))*10*JinChi_sup/(Step0*1.05);

                              Pointxy[0].X :=Point_Six_P[3].X-trunc(0.5*used_h*sin(YanCengQingJiao)*shiyong_bl);
                              Pointxy[0].Y :=Point_Six_P[3].Y-trunc((0.5*used_h-0.5*used_h*Cos(YanCengQingJiao))*shiyong_bl);
                              Pointxy[1].X :=Pointxy[0].X +trunc(Used_h* sin(YanCengQingJiao)*shiyong_bl);
                              Pointxy[1].Y :=Pointxy[0].Y -trunc(Used_h* cos(YanCengQingJiao)*shiyong_bl);
                              Pointxy[2].X :=Pointxy[1].X +trunc(0.5*step0* cos(YanCengQingJiao)*shiyong_bl);
                              Pointxy[2].Y :=Pointxy[1].Y +trunc(0.5*step0* sin(YanCengQingJiao)*shiyong_bl);
                              Pointxy[3].X :=Pointxy[2].X -trunc(Used_h* sin(YanCengQingJiao)*shiyong_bl);
                              Pointxy[3].Y :=Pointxy[2].Y +trunc(Used_h* cos(YanCengQingJiao)*shiyong_bl);
                                Image_inn.Canvas.Brush.Bitmap:=nil;
                                Image_inn.Canvas.Polygon(Pointxy);
                                Image_inn.Canvas.Brush.Bitmap:=bitM;
                               //图形填充
                                 Image_fill_P.x :=Trunc((Pointxy[0].X+Pointxy[2].X)/2); Image_fill_P.y:= Trunc((Pointxy[0].Y+Pointxy[2].Y)/2);
                                 while_image:=true;
                                 k:=0;
                                 while while_image  do begin
                                      if Public_Basic.IsPtInPoly (Image_fill_P.x,Image_fill_P.y,Pointxy) then begin
                                         Image_inn.Canvas.FloodFill(Image_fill_P.x ,Image_fill_P.y,clBlack,fsBorder);
                                         while_image:=false;
                                      end else begin
                                          K:=K+1;
                                          Image_fill_P.x :=Pointxy[0].X+K; Image_fill_P.y:=  Pointxy[0].Y-1;
                                          if K>5 then  while_image:=false;

                                      end;

                                 end;  //end while
                                 Image_inn.Canvas.Brush.Bitmap:=nil;

                                    // if i=Yc_End_Nu then  begin
                                    Point_wk[3].X := Pointxy[1].X ;
                                    Point_wk[3].Y := Pointxy[1].Y;
                                    Point_wk[2].X := Pointxy[2].X; ;
                                    Point_wk[2].Y := Pointxy[2].Y;

                                    Point_wk[0].X := Point_wk[3].X+40 ;
                                    Point_wk[0].Y := Point_wk[3].Y-40;
                                    Point_wk[1].X := Point_wk[2].X+40;
                                    Point_wk[1].Y := Point_wk[2].Y-40;
                                      Image_inn.Canvas.Brush.Bitmap:=nil;
                                      Image_inn.Canvas.Polygon(Point_wk);
                                      Image_inn.Canvas.Brush.Bitmap:=bitM;
                                        //图形填充
                                         Image_fill_P.x :=Trunc((Point_wk[0].X+Point_wk[2].X)/2); Image_fill_P.y:= Trunc((Point_wk[0].Y+Point_wk[2].Y)/2);
                                         while_image:=true;
                                         k:=0;
                                         while while_image  do begin
                                              if Public_Basic.IsPtInPoly (Image_fill_P.x,Image_fill_P.y,Point_wk) then begin
                                                 Image_inn.Canvas.FloodFill(Image_fill_P.x ,Image_fill_P.y,clBlack,fsBorder);
                                                 while_image:=false;
                                              end else begin
                                                  K:=K+1;
                                                  Image_fill_P.x :=Point_wk[0].X+K; Image_fill_P.y:=  Point_wk[0].Y;
                                                  if K>5 then  while_image:=false;
                                              end;

                                         end; // end while

                             // end;  //end  if i=Yc_End_Nu then  begin

                              //右侧
                                Point_Six_P[5].X :=Image_inn.Width;
                                     Point_Six_P[5].Y :=inn_right_y0;
                                Point_Six_P[3].X :=inn_Right_x2+trunc((step0-StrToFloat(temp1[1])*2-Jinchi-YockLiang_Suo)*shiyong_bl);
                               //  Point_Six_P[3].X :=inn_Right_x2+trunc((zhijia.Zj_KongdingJU+step0-StrToFloat(temp1[1])*2-Jinchi-YockLiang_Suo)*shiyong_bl);


                               if StrToFloat(temp1[3])>0 then begin
                                      Point_Six_P[3].Y :=inn_right_y2-trunc((inn_left_y2-inn_left_y0)*(StrToFloat(temp1[3])-StrToFloat(temp1[1]))/StrToFloat(temp1[3]));
                                 end else begin
                                      Point_Six_P[3].Y :=inn_right_y2;
                                 end;

                                Point_Six_P[0].X :=Point_Six_P[5].X;
                                   Point_Six_P[0].Y :=Point_Six_P[5].Y-trunc(used_h*shiyong_bl);
                                Point_Six_P[2].X :=Point_Six_P[3].X;
                                   Point_Six_P[2].Y :=Point_Six_P[3].Y-trunc(used_h*shiyong_bl);

                                Point_Six_P[4].X :=Point_Six_P[3].X +trunc((zhijia.Zj_KongdingJU+StrToFloat(temp1[3]))*shiyong_bl);
                                     Point_Six_P[4].Y :=Point_Six_P[5].Y;
                                Point_Six_P[1].X :=Point_Six_P[4].X;
                                     Point_Six_P[1].Y :=Point_Six_P[0].Y;

                              Image_inn.Canvas.Polygon(Point_Six_P) ;
                              Image_inn.Canvas.Brush.Bitmap:=bitM;
                              Image_fill_P.x :=Trunc((Point_Six_P[5].X+Point_Six_P[3].X)/2); Image_fill_P.y:= Trunc((Point_Six_P[1].Y+Point_Six_P[4].Y)/2);
                                   while_image:=true;
                                   k:=0;
                                   while while_image  do begin
                                        if Public_Basic.IsPtInPoly (Image_fill_P.x,Image_fill_P.y,Point_Six_P) then begin
                                           Image_inn.Canvas.FloodFill(Image_fill_P.x ,Image_fill_P.y,clBlack,fsBorder);
                                           while_image:=false;
                                        end else begin
                                            K:=K+1;
                                            Image_fill_P.x :=Point_Six_P[5].X+K; Image_fill_P.y:=  Point_Six_P[5].Y-1;
                                            if K>5 then  while_image:=false;

                                        end;

                                   end;  //end while
                                   Image_inn.Canvas.Brush.Bitmap:=nil;
                                    //填写右侧压力拱数据
                                   YLG_R1.Insert(0,InttoStr(Point_Six_P[4].X)+','+InttoStr(Point_Six_P[2].Y) );
                                   YLG_R2.insert(0,InttoStr(Point_Six_P[4].X+trunc(StrToFloat(temp1[4])*shiyong_bl))+','+InttoStr(Point_Six_P[2].Y) );
                                 // if i=Yc_End_Nu then  begin
                                    Point_wk[3].X := Point_Six_P[2].X ;
                                    Point_wk[3].Y := Point_Six_P[2].Y;
                                    Point_wk[2].X := Point_Six_P[0].X;
                                    Point_wk[2].Y := Point_Six_P[0].Y;

                                    Point_wk[0].X := Point_wk[3].X+40 ;
                                    Point_wk[0].Y := Point_wk[3].Y-40;
                                    Point_wk[1].X := Point_wk[2].X+40;
                                    Point_wk[1].Y := Point_wk[2].Y-40;
                                      Image_inn.Canvas.Brush.Bitmap:=nil;
                                      Image_inn.Canvas.Polygon(Point_wk);
                                      Image_inn.Canvas.Brush.Bitmap:=bitM;
                                        //图形填充
                                         Image_fill_P.x :=Trunc((Point_wk[0].X+Point_wk[2].X)/2); Image_fill_P.y:= Trunc((Point_wk[0].Y+Point_wk[2].Y)/2);
                                         while_image:=true;
                                         k:=0;
                                         while while_image  do begin
                                              if Public_Basic.IsPtInPoly (Image_fill_P.x,Image_fill_P.y,Point_wk) then begin
                                                 Image_inn.Canvas.FloodFill(Image_fill_P.x ,Image_fill_P.y,clBlack,fsBorder);
                                                 while_image:=false;
                                              end else begin
                                                  K:=K+1;
                                                  Image_fill_P.x :=Point_wk[0].X+K; Image_fill_P.y:=  Point_wk[0].Y;
                                                  if K>5 then  while_image:=false;
                                              end;

                                         end; // end while

                             // end;  //end  if i=Yc_End_Nu then  begin

                             inn_right_y0:=Point_Six_P[0].Y ;inn_right_y2:=Point_Six_P[2].Y;inn_Right_x2 := Point_Six_P[2].X -trunc(zhijia.Zj_KongdingJU*shiyong_bl);
                             ganshi_y1:=Point_Six_P[5].Y;
                             //2015.6014 转移到 4103 行/
                             //ganshi_right_x4:= inn_left_x1+trunc((jinchi-zhijia.Zj_KongdingJU)*shiyong_bl);
                               //第二块

                              Pointxy[0].X :=Point_Six_P[3].X+trunc(0.5*used_h*sin(YanCengQingJiao)*shiyong_bl);
                              Pointxy[0].Y :=Point_Six_P[3].Y-trunc((0.5*used_h-0.5*used_h*Cos(YanCengQingJiao))*shiyong_bl);
                              Pointxy[1].X :=Pointxy[0].X -trunc(Used_h* sin(YanCengQingJiao)*shiyong_bl);
                              Pointxy[1].Y :=Pointxy[0].Y -trunc(Used_h* cos(YanCengQingJiao)*shiyong_bl);
                              Pointxy[2].X :=Pointxy[2].X;
                              Pointxy[2].Y :=Pointxy[2].Y;
                              Pointxy[3].X :=Pointxy[2].X +trunc(Used_h* sin(YanCengQingJiao)*shiyong_bl);
                              Pointxy[3].Y :=Pointxy[3].Y ;
                                Image_inn.Canvas.Brush.Bitmap:=nil;
                                Image_inn.Canvas.Polygon(Pointxy);
                                Image_inn.Canvas.Brush.Bitmap:=bitM;
                                Image_fill_P.x :=Trunc((Pointxy[0].X+Pointxy[3].X)/2); Image_fill_P.y:= Trunc((Pointxy[3].Y+Pointxy[2].Y)/2);
                                 while_image:=true;
                                 k:=0;
                                 while while_image  do begin
                                      if Public_Basic.IsPtInPoly (Image_fill_P.x,Image_fill_P.y,Pointxy) then begin
                                         Image_inn.Canvas.FloodFill(Image_fill_P.x ,Image_fill_P.y,clBlack,fsBorder);
                                         while_image:=false;
                                      end else begin
                                          K:=K+1;
                                          Image_fill_P.x :=Pointxy[0].X-K; Image_fill_P.y:=  Pointxy[0].Y-1;
                                          if K>5 then  while_image:=false;

                                      end;

                                 end;

                                 // if i=Yc_End_Nu then  begin
                                    Point_wk[3].X := Pointxy[2].X ;
                                    Point_wk[3].Y := Pointxy[2].Y;
                                    Point_wk[2].X := Pointxy[1].X; ;
                                    Point_wk[2].Y := Pointxy[1].Y;

                                    Point_wk[0].X := Point_wk[3].X+40 ;
                                    Point_wk[0].Y := Point_wk[3].Y-40;
                                    Point_wk[1].X := Point_wk[2].X+40;
                                    Point_wk[1].Y := Point_wk[2].Y-40;
                                      Image_inn.Canvas.Brush.Bitmap:=nil;
                                      Image_inn.Canvas.Polygon(Point_wk);
                                      Image_inn.Canvas.Brush.Bitmap:=bitM;
                                        //图形填充
                                         Image_fill_P.x :=Trunc((Point_wk[0].X+Point_wk[2].X)/2); Image_fill_P.y:= Trunc((Point_wk[0].Y+Point_wk[2].Y)/2);
                                         while_image:=true;
                                         k:=0;
                                         while while_image  do begin
                                              if Public_Basic.IsPtInPoly (Image_fill_P.x,Image_fill_P.y,Point_wk) then begin
                                                 Image_inn.Canvas.FloodFill(Image_fill_P.x ,Image_fill_P.y,clBlack,fsBorder);
                                                 while_image:=false;
                                              end else begin
                                                  K:=K+1;
                                                  Image_fill_P.x :=Point_wk[0].X+K; Image_fill_P.y:=  Point_wk[0].Y;
                                                  if K>5 then  while_image:=false;
                                              end;

                                         end; // end while

                             // end;  //end  if i=Yc_End_Nu then  begin
                                Image_inn.Canvas.Brush.Bitmap:=nil;
                                //终止循环
                                 Zjd_Wt:=1;
                        end else begin
                              //左侧
                             if Zjd_Wt=1 then   break;   // 如果下层没有沉降，上层出现沉降，退出

                             Point_Six_P[5].X :=0;
                                 Point_Six_P[5].Y :=inn_left_y0;

                             Point_Six_P[3].X :=inn_left_x2;
                                 if StrToFloat(temp1[3])>0 then begin
                                      Point_Six_P[3].Y :=inn_left_y2-trunc((inn_left_y2-inn_left_y0)*(StrToFloat(temp1[3])-StrToFloat(temp1[1]))/StrToFloat(temp1[3]));
                                 end else begin
                                      Point_Six_P[3].Y :=inn_left_y2;
                                 end;
                             Point_Six_P[0].X :=Point_Six_P[5].X;
                                   Point_Six_P[0].Y :=Point_Six_P[5].Y-trunc(used_h*shiyong_bl);
                                   YockLiang_Suo:=YockLiang_Suo+used_h*tan(25/180*3.1415926);
                             Point_Six_P[2].X :=Point_Six_P[3].X+trunc(used_h*tan(25/180*3.1415926)*shiyong_bl);
                                   Point_Six_P[2].Y :=Point_Six_P[3].Y-trunc(used_h*shiyong_bl);
                              Point_Six_P[4].X :=inn_left_x2 -trunc(StrToFloat(temp1[3])*shiyong_bl);
                                   Point_Six_P[4].Y :=Point_Six_P[5].Y;
                              Point_Six_P[1].X :=Point_Six_P[4].X;
                                   Point_Six_P[1].Y :=Point_Six_P[0].Y;

                              Image_inn.Canvas.Polygon(Point_Six_P) ;
                              Image_inn.Canvas.Brush.Bitmap:=bitM;
                              Image_fill_P.x :=Trunc((Point_Six_P[5].X+Point_Six_P[3].X)/2); Image_fill_P.y:= Trunc((Point_Six_P[1].Y+Point_Six_P[4].Y)/2);
                                   while_image:=true;
                                   k:=0;
                                   while while_image  do begin
                                        if Public_Basic.IsPtInPoly (Image_fill_P.x,Image_fill_P.y,Point_Six_P) then begin
                                           Image_inn.Canvas.FloodFill(Image_fill_P.x ,Image_fill_P.y,clBlack,fsBorder);
                                           while_image:=false;
                                        end else begin
                                            K:=K+1;
                                            Image_fill_P.x :=Point_Six_P[5].X+K; Image_fill_P.y:=  Point_Six_P[5].Y-1;
                                            if K>5 then  while_image:=false;

                                        end;

                                   end; //end; //end while
                              Image_inn.Canvas.Brush.Bitmap:=nil;
                                   //填写左侧压力拱数据
                              YLG_L1.Add(InttoStr(Point_Six_P[1].X)+','+InttoStr(Point_Six_P[1].Y) );
                              YLG_L2.Add(InttoStr(Point_Six_P[1].X-trunc(StrToFloat(temp1[4])*shiyong_bl))+','+InttoStr(Point_Six_P[1].Y) );
                         

                              inn_left_y0:=Point_Six_P[0].Y ;inn_left_y2:=Point_Six_P[2].Y;inn_left_x2 := Point_Six_P[2].X ;

                              //右侧
                               Point_Six_P[5].X :=Image_inn.Width;
                                     Point_Six_P[5].Y :=inn_right_y0;
                                Point_Six_P[3].X :=inn_Right_x2;
                                 if StrToFloat(temp1[3])>0 then begin
                                      Point_Six_P[3].Y :=inn_right_y2-trunc((inn_left_y2-inn_left_y0)*(StrToFloat(temp1[3])-StrToFloat(temp1[1]))/StrToFloat(temp1[3]));
                                 end else begin
                                      Point_Six_P[3].Y :=inn_right_y2;
                                 end;
                                Point_Six_P[0].X :=Point_Six_P[5].X;
                                   Point_Six_P[0].Y :=Point_Six_P[5].Y-trunc(used_h*shiyong_bl);
                                Point_Six_P[2].X :=Point_Six_P[3].X-trunc(used_h*tan(25/180*3.1415926)*shiyong_bl);
                                   Point_Six_P[2].Y :=Point_Six_P[3].Y-trunc(used_h*shiyong_bl);

                                Point_Six_P[4].X :=Point_Six_P[3].X +trunc((zhijia.Zj_KongdingJU+StrToFloat(temp1[3]))*shiyong_bl);
                                     Point_Six_P[4].Y :=Point_Six_P[5].Y;
                                Point_Six_P[1].X :=Point_Six_P[4].X;
                                     Point_Six_P[1].Y :=Point_Six_P[0].Y;

                              Image_inn.Canvas.Polygon(Point_Six_P) ;
                              Image_inn.Canvas.Brush.Bitmap:=bitM;
                              Image_fill_P.x :=Trunc((Point_Six_P[5].X+Point_Six_P[3].X)/2); Image_fill_P.y:= Trunc((Point_Six_P[1].Y+Point_Six_P[4].Y)/2);
                                   while_image:=true;
                                   k:=0;
                                   while while_image  do begin
                                        if Public_Basic.IsPtInPoly (Image_fill_P.x,Image_fill_P.y,Point_Six_P) then begin
                                           Image_inn.Canvas.FloodFill(Image_fill_P.x ,Image_fill_P.y,clBlack,fsBorder);
                                           while_image:=false;
                                        end else begin
                                            K:=K+1;
                                            Image_fill_P.x :=Point_Six_P[5].X+K; Image_fill_P.y:=  Point_Six_P[5].Y-1;
                                            if K>5 then  while_image:=false;

                                        end;

                                   end;  //end; //end while
                             Image_inn.Canvas.Brush.Bitmap:=nil;
                              //填写右侧压力拱数据
                             YLG_R1.Insert(0,InttoStr(Point_Six_P[4].X)+','+InttoStr(Point_Six_P[2].Y) );
                             YLG_R2.insert(0,InttoStr(Point_Six_P[4].X+trunc(StrToFloat(temp1[4])*shiyong_bl))+','+InttoStr(Point_Six_P[2].Y) );

                             inn_right_y0:=Point_Six_P[0].Y ;inn_right_y2:=Point_Six_P[2].Y;inn_Right_x2 := Point_Six_P[2].X ;
                             ganshi_y1:=Point_Six_P[0].Y;
                             ganshi_right_x4:= Point_Six_P[3].X;
                            // ganshi_right_x4:= Point_Six_P[3].X-trunc(zhijia.Zj_KongdingJU*shiyong_bl);
                             ganshi_h:=ganshi_h+zk.Yc_Rock[i].R_k_Rock*used_h;

                        end;
                            if i<=imm.Start_No  then  ganshi_Count:=2;
                     end;  //end for   i
                        ganshi_h:=ganshi_h+gzm.S_Cg_h*(gzm.Mc_FdBs-1) ;

                   //画 直接顶下 在当前推进进尺下 不动的岩层
                  if (i> imm.End_No) or(i=imm.End_No) then  begin
                       for j := i downto imm.End_No do  begin
                            Pointxy[0].X :=0 ;
                              if (j=imm.End_No) and (imm.Surplus_h>0) then    begin
                                  Pointxy[0].Y :=inn_left_y0-trunc((zk.Yc_Rock[j].R_h-imm.Surplus_h)*shiyong_bl);
                              end else begin
                                  Pointxy[0].Y :=inn_left_y0-trunc((zk.Yc_Rock[j].R_h)*shiyong_bl);
                              end;
                            Pointxy[1].X :=Image_inn.Width ;
                            Pointxy[1].Y :=Pointxy[0].Y;
                            Pointxy[2].X :=Pointxy[1].X  ;
                            Pointxy[2].Y :=inn_left_y0;
                            Pointxy[3].X :=Pointxy[0].X ;
                            Pointxy[3].Y :=Pointxy[2].Y ;
                            Image_inn.Canvas.Brush.Bitmap:=nil;
                         //填充图例
                            bitM.FreeImage;
                            if Tuxing=0 then   begin
                              if  fileexists(dll_Path+'\BmpSi\'+zk.Yc_Rock[j].R_Name+'.Bmp') then  begin
                                  bitM.LoadFromFile(dll_Path+'\BmpSi\'+zk.Yc_Rock[j].R_Name+'.Bmp');//装入图像文件
                              end else begin
                                  bitM.LoadFromFile(dll_Path+'\BmpSi\NULL.Bmp');
                              end;

                            end else begin
                                if  fileexists(dll_Path+'\BmpFZ\'+zk.Yc_Rock[j].R_Name+'.Bmp') then  begin
                                  bitM.LoadFromFile(dll_Path+'\BmpFZ\'+zk.Yc_Rock[j].R_Name+'.Bmp');//装入图像文件
                                end else begin
                                  bitM.LoadFromFile(dll_Path+'\BmpFz\NULL.Bmp');
                                end;

                            end; // end if Tuxing
                                Image_inn.Canvas.Brush.Bitmap:=nil;
                                Image_inn.Canvas.Polygon(Pointxy);
                                Image_inn.Canvas.Brush.Bitmap:=bitM;
                                Image_fill_P.x :=Trunc((Pointxy[0].X+Pointxy[1].X)/2); Image_fill_P.y:= Trunc((Pointxy[3].Y+Pointxy[0].Y)/2);
                                 while_image:=true;
                                 k:=0;
                                 while while_image  do begin
                                      if Public_Basic.IsPtInPoly (Image_fill_P.x,Image_fill_P.y,Pointxy) then begin
                                         Image_inn.Canvas.FloodFill(Image_fill_P.x ,Image_fill_P.y,clBlack,fsBorder);
                                         while_image:=false;
                                      end else begin
                                          K:=K+1;
                                          Image_fill_P.x :=Pointxy[3].X+K; Image_fill_P.y:=  Pointxy[3].Y-1;
                                          if K>5 then  while_image:=false;

                                      end;
                                 end; //end while
                                 Image_inn.Canvas.Brush.Bitmap:=nil;
                           
                            inn_left_y0:=Pointxy[0].Y;
                           //如果有不动的岩层，肯定没有完结
                            Zjd_Wt:=1;
                       end;  //end for j

                         
                  end;  // end if  i



               //画老顶
                 YockLiang_Suo:=0; Rock_sa:=0; //老顶岩梁的缩进与 下沉初值为0
                 inn_Left_x2:= trunc(gzm.ZCYL_sx[2]*shiyong_bl)-trunc(StrToFloat(temp1[1])*shiyong_bl);
                 inn_Right_x2:= trunc((gzm.ZCYL_sx[2]+Jinchi+zhijia.Zj_KongdingJU+StrToFloat(temp1[3]))*shiyong_bl);
                 ganshi_y2:=0; break_i_105:=0;
                 zcyl_l_P1.X:=0;   zcyl_l_P1.Y:=zcyl_l_P2.Y-trunc(gzm.S_Cg_h*gzm.Mc_FdBs*strtofloat(temp1[2])*shiyong_bl);
                 zcyl_R_P1.X:=Image_inn.Width;   zcyl_R_P1.Y:=zcyl_l_P1.Y;

                 Sink_leixing:=1;
                 for I := Old_beam[0].Start_YC_No downto model_start_yc do   begin

                        if Zjd_Wt=1 then  break; //如果直接顶没有沉降完毕。老顶不允许动

                        Step0:=zk.Yc_Rock[i].Step0;
                        if (i=imm.End_No) and (imm.Surplus_h>0) then    begin
                            used_h:= imm.Surplus_h;
                        end else begin
                            used_h:= zk.Yc_Rock[i].R_h;
                        end;
                       //填充图例
                       bitM.FreeImage;
                       if Tuxing=0 then   begin
                          if  fileexists(dll_Path+'\BmpSi\'+zk.Yc_Rock[i].R_Name+'.Bmp') then  begin
                              bitM.LoadFromFile(dll_Path+'\BmpSi\'+zk.Yc_Rock[i].R_Name+'.Bmp');//装入图像文件
                          end else begin
                              bitM.LoadFromFile(dll_Path+'\BmpSi\NULL.Bmp');
                          end;

                         end else begin
                            if  fileexists(dll_Path+'\BmpFZ\'+zk.Yc_Rock[i].R_Name+'.Bmp') then  begin
                              bitM.LoadFromFile(dll_Path+'\BmpFZ\'+zk.Yc_Rock[i].R_Name+'.Bmp');//装入图像文件
                            end else begin
                              bitM.LoadFromFile(dll_Path+'\BmpFz\NULL.Bmp');
                            end;
                        end;
                        //
                        if i<old.yl_max_End then   break;
                        
                        if jinChi+zhijia.Zj_KongdingJU+2*StrToFloat(temp1[1])-2*YockLiang_Suo< Step0 * 0.95  then  begin
                            break;
                        end else  begin
                            //左侧 老顶
                             //首先 确定顶板的下沉值
                             if  break_i_105 =0  then  begin
                                 if jinChi+zhijia.Zj_KongdingJU < gzm.S_L_qx then  begin
                                    rock_sa:=zk.Yc_Rock[i].Sa[0];
                                 end else if jinChi+zhijia.Zj_KongdingJU < gzm.S_L_qx *2  then  begin
                                    rock_sa:=zk.Yc_Rock[i].Sa[1];
                                 end else begin
                                    rock_sa:=zk.Yc_Rock[i].Sa[2];
                                 end;
                             end;

                             Sink_Sa_used:= used_h;
                             //左侧 老顶
                             Point_Six_P[5].X :=0;
                                 Point_Six_P[5].Y :=inn_left_y0;

                             Point_Six_P[3].X :=inn_left_x2+trunc(YockLiang_Suo*shiyong_bl);
                                 if StrToFloat(temp1[3])>0 then begin
                                      Point_Six_P[3].Y :=inn_left_y2-trunc((inn_left_y2-inn_left_y0)*(StrToFloat(temp1[3])-StrToFloat(temp1[1]))/StrToFloat(temp1[3]));
                                 end else begin
                                      Point_Six_P[3].Y :=inn_left_y2;
                                 end;

                             Point_Six_P[3].Y:=Public_Basic.FindPointY (Point_Six_P[3].X,Point_Six_P[3].Y,t_str_sec,1);

                             Point_Six_P[0].X :=Point_Six_P[5].X;
                                   Point_Six_P[0].Y :=Point_Six_P[5].Y-trunc(used_h*shiyong_bl);
                             Point_Six_P[2].X :=Point_Six_P[3].X;
                                   Point_Six_P[2].Y :=Point_Six_P[3].Y-trunc(used_h*shiyong_bl);
                              Point_Six_P[4].X :=Point_Six_P[3].X -trunc(StrToFloat(temp1[3])*shiyong_bl);
                                   Point_Six_P[4].Y :=Point_Six_P[5].Y;
                              Point_Six_P[1].X :=Point_Six_P[4].X;
                                   Point_Six_P[1].Y :=Point_Six_P[0].Y;

                             //如果是最后一层， //顶层画立体外壳
                            //  if i=Yc_End_Nu then  begin
                                    Point_wk[3].X := Point_Six_P[0].X ;
                                    Point_wk[3].Y := Point_Six_P[0].Y;
                                    Point_wk[2].X := Point_Six_P[2].X; ;
                                    Point_wk[2].Y := Point_Six_P[2].Y;

                                    Point_wk[0].X := Point_wk[3].X+40 ;
                                    Point_wk[0].Y := Point_wk[3].Y-40;
                                    Point_wk[1].X := Point_wk[2].X+40;
                                    Point_wk[1].Y := Point_wk[2].Y-40;
                                      Image_inn.Canvas.Brush.Bitmap:=nil;
                                      Image_inn.Canvas.Polygon(Point_wk);
                                      Image_inn.Canvas.Brush.Bitmap:=bitM;
                                        //图形填充
                                       Image_fill_P.x :=Trunc((Point_wk[0].X+Point_wk[2].X)/2); Image_fill_P.y:= Trunc((Point_wk[0].Y+Point_wk[2].Y)/2);
                                       while_image:=true;
                                       k:=0;
                                       while while_image  do begin
                                            if Public_Basic.IsPtInPoly (Image_fill_P.x,Image_fill_P.y,Point_wk) then begin
                                               Image_inn.Canvas.FloodFill(Image_fill_P.x ,Image_fill_P.y,clBlack,fsBorder);
                                               while_image:=false;
                                            end else begin
                                                K:=K+1;
                                                Image_fill_P.x :=Point_wk[0].X+K; Image_fill_P.y:=  Point_wk[0].Y;
                                                if K>5 then  while_image:=false;
                                            end;

                                       end; // end while

                             // end;   end  if i=Yc_End_Nu then  begin

                              //调函数判断
                              Image_inn.Canvas.Polygon(Point_Six_P) ;
                              //添加   t_Str_Fir
                              t_Str_Fir.Add(IntTostr( Point_Six_P[0].X )+','+IntTostr( Point_Six_P[0].Y ));
                              t_Str_Fir.Add(IntTostr( Point_Six_P[1].X )+','+IntTostr( Point_Six_P[1].Y ));
                              t_Str_Fir.Add(IntTostr( Point_Six_P[2].X )+','+IntTostr( Point_Six_P[2].Y ));


                              Image_inn.Canvas.Brush.Bitmap:=bitM;
                               //图形填充
                                 Image_fill_P.x :=Trunc((Point_Six_P[5].X+Point_Six_P[3].X)/2); Image_fill_P.y:= Trunc((Point_Six_P[1].Y+Point_Six_P[4].Y)/2);
                                 while_image:=true;
                                 k:=0;
                                 while while_image  do begin
                                      if Public_Basic.IsPtInPoly (Image_fill_P.x,Image_fill_P.y,Point_Six_P) then begin
                                         Image_inn.Canvas.FloodFill(Image_fill_P.x ,Image_fill_P.y,clBlack,fsBorder);
                                         while_image:=false;
                                      end else begin
                                          K:=K+1;
                                          Image_fill_P.x :=Point_Six_P[5].X+K; Image_fill_P.y:=  Point_Six_P[5].Y-1;
                                          if K>5 then  while_image:=false;

                                      end;

                                 end;
                                 Image_inn.Canvas.Brush.Bitmap:=nil;
                                      //填写左侧压力拱数据
                              YLG_L1.Add(InttoStr(Point_Six_P[2].X)+','+InttoStr(Point_Six_P[2].Y) );
                              YLG_L2.Add(InttoStr(Point_Six_P[2].X-trunc(StrToFloat(temp1[4])*shiyong_bl))+','+InttoStr(Point_Six_P[2].Y) );

                              //第一块 老顶
                               JinChi_sup:=Jinchi+zhijia.Zj_KongdingJU+2*StrToFloat(temp1[3])-2*YockLiang_Suo-step0*0.95;
                               if 10*JinChi_sup<Step0*1.05 then   begin
                                    YanCengQingJiao:=(arctan(Rock_sa/Step0))*10*JinChi_sup/(Step0*1.05);
                                    Sink_leixing:=0;
                               end else begin
                                    YanCengQingJiao:=arctan(Rock_sa/Step0*2);
                                    Sink_leixing:=1;
                               end;

                              Pointxy[0].X :=Point_Six_P[3].X-trunc(0.5*Sink_Sa_used*sin(YanCengQingJiao)*shiyong_bl);
                              Pointxy[0].Y :=Point_Six_P[3].Y-trunc((0.5*Sink_Sa_used-0.5*Sink_Sa_used*Cos(YanCengQingJiao))*shiyong_bl);
                              Pointxy[1].X :=Pointxy[0].X +trunc(Sink_Sa_used* sin(YanCengQingJiao)*shiyong_bl);
                              Pointxy[1].Y :=Pointxy[0].Y -trunc(Sink_Sa_used* cos(YanCengQingJiao)*shiyong_bl);
                              Pointxy[2].X :=Pointxy[1].X +trunc(0.5*step0* cos(YanCengQingJiao)*shiyong_bl);
                              Pointxy[2].Y :=Pointxy[1].Y +trunc(0.5*step0* sin(YanCengQingJiao)*shiyong_bl);
                              Pointxy[3].X :=Pointxy[2].X -trunc(Sink_Sa_used* sin(YanCengQingJiao)*shiyong_bl);
                              Pointxy[3].Y :=Pointxy[2].Y +trunc(Sink_Sa_used* cos(YanCengQingJiao)*shiyong_bl);
                              //判断下标  //调函数判断
                                Y_min :=Public_Basic.FindPointY(Pointxy[3].X,Pointxy[3].Y,t_str_sec,Sink_leixing);
                                  Pointxy[2].Y:=Pointxy[2].Y -(Pointxy[3].Y-Y_min);
                                  Pointxy[3].Y:=Y_min;

                                Image_inn.Canvas.Brush.Bitmap:=nil;
                                Image_inn.Canvas.Polygon(Pointxy);
                                   //添加   t_Str_Fir
                              t_Str_Fir.Add(IntTostr( Pointxy[1].X )+','+IntTostr( Pointxy[1].Y ));
                              t_Str_Fir.Add(IntTostr( Pointxy[2].X )+','+IntTostr( Pointxy[2].Y ));

                                Image_inn.Canvas.Brush.Bitmap:=bitM;
                                //图形填充
                                 Image_fill_P.x :=Trunc((Pointxy[0].X+Pointxy[2].X)/2); Image_fill_P.y:= Trunc((Pointxy[2].Y+Pointxy[3].Y)/2);
                                 while_image:=true;
                                 k:=0;
                                 while while_image  do begin
                                      if Public_Basic.IsPtInPoly (Image_fill_P.x,Image_fill_P.y,Pointxy) then begin
                                         Image_inn.Canvas.FloodFill(Image_fill_P.x ,Image_fill_P.y,clBlack,fsBorder);
                                         while_image:=false;
                                      end else begin
                                          K:=K+1;
                                          Image_fill_P.x :=Pointxy[0].X+K; Image_fill_P.y:=  Pointxy[0].Y-1;
                                          if K>5 then  while_image:=false;

                                      end;

                                 end;
                                  //如果是最后一层， //顶层画立体外壳
                            // if i=Yc_End_Nu then  begin
                                    Point_wk[3].X := Pointxy[1].X ;
                                    Point_wk[3].Y := Pointxy[1].Y;
                                    Point_wk[2].X := Pointxy[2].X; ;
                                    Point_wk[2].Y := Pointxy[2].Y;

                                    Point_wk[0].X := Point_wk[3].X+40 ;
                                    Point_wk[0].Y := Point_wk[3].Y-40;
                                    Point_wk[1].X := Point_wk[2].X+40;
                                    Point_wk[1].Y := Point_wk[2].Y-40;
                                      Image_inn.Canvas.Brush.Bitmap:=nil;
                                      Image_inn.Canvas.Polygon(Point_wk);
                                      Image_inn.Canvas.Brush.Bitmap:=bitM;
                                        //图形填充
                                         Image_fill_P.x :=Trunc((Point_wk[0].X+Point_wk[2].X)/2); Image_fill_P.y:= Trunc((Point_wk[0].Y+Point_wk[2].Y)/2);
                                         while_image:=true;
                                         k:=0;
                                         while while_image  do begin
                                              if Public_Basic.IsPtInPoly (Image_fill_P.x,Image_fill_P.y,Point_wk) then begin
                                                 Image_inn.Canvas.FloodFill(Image_fill_P.x ,Image_fill_P.y,clBlack,fsBorder);
                                                 while_image:=false;
                                              end else begin
                                                  K:=K+1;
                                                  Image_fill_P.x :=Point_wk[0].X+K; Image_fill_P.y:=  Point_wk[0].Y;
                                                  if K>5 then  while_image:=false;
                                              end;

                                         end; // end while

                            //  end;  end  if i=Yc_End_Nu then  begin
                                 Image_inn.Canvas.Brush.Bitmap:=nil;
                                //判断下沉值
                                  if used_h>rock_sa  then  begin
                                      break_i_105:=105;
                                      rock_sa:=(Pointxy[2].Y-Pointxy[1].Y)/shiyong_bl;
                                  end;
                               //判断矸石的高度
                                   if I = Old_beam[0].Start_YC_No then  begin
                                     ganshi_y2:=Pointxy[3].Y;
                                   end;
                               //预置第二块
                                 Point_t_P[2].X :=Pointxy[2].X;
                                 Point_t_P[2].Y :=Pointxy[2].Y;
                                 Point_t_P[3].X :=Pointxy[3].X+trunc(Sink_Sa_used* sin(YanCengQingJiao)*shiyong_bl);
                                 Point_t_P[3].Y :=Pointxy[3].Y;

                                 Point_Six_P[3].X :=inn_Left_x2+trunc((step0+YockLiang_Suo)*shiyong_bl);
                                 if StrToFloat(temp1[3])>0 then begin
                                      Point_Six_P[3].Y :=inn_right_y2-trunc((inn_left_y2-inn_left_y0)*(StrToFloat(temp1[3])-StrToFloat(temp1[1]))/StrToFloat(temp1[3]));
                                 end else begin
                                      Point_Six_P[3].Y :=inn_right_y2;
                                 end;

                                   //第二块 老顶
                                Point_t_P[0].X  :=Point_Six_P[3].X+trunc(0.5*Sink_Sa_used*sin(YanCengQingJiao)*shiyong_bl);
                                Point_t_P[0].Y :=Point_Six_P[3].Y-trunc((0.5*Sink_Sa_used-0.5*Sink_Sa_used*Cos(YanCengQingJiao))*shiyong_bl);
                                Point_t_P[1].X :=Point_t_P[0].X -trunc(Sink_Sa_used* sin(YanCengQingJiao)*shiyong_bl);
                                Point_t_P[1].Y :=Point_t_P[0].Y -trunc(Sink_Sa_used* cos(YanCengQingJiao)*shiyong_bl);


                                 // 初次来压步距结束
                                 if jinChi+zhijia.Zj_KongdingJU+2*StrToFloat(temp1[1])-2*YockLiang_Suo  >= Step0*1.05  then begin

                                     while_j:=true; j:=1;
                                     while_j_sup_jinchi:=jinChi+zhijia.Zj_KongdingJU+2*StrToFloat(temp1[1])-2*YockLiang_Suo - Step0 ;
                                     Point_Six_P[3].X :=inn_Left_x2+trunc((step0+YockLiang_Suo)*shiyong_bl);
                                     while while_j do
                                      begin
                                          if j<=4 then  begin
                                             while_j_sup_jinchi:= while_j_sup_jinchi-zk.Yc_Rock[i].step_i[j]*0.95;
                                             step_i:=zk.Yc_Rock[i].step_i[j];
                                          end else begin
                                             while_j_sup_jinchi:= while_j_sup_jinchi-zk.Yc_Rock[i].step_i[0]*0.95;
                                             step_i:=zk.Yc_Rock[i].step_i[0];
                                          end;

                                            if while_j_sup_jinchi<0  then begin
                                                  if j>1 then  begin

                                                    Image_inn.Canvas.Brush.Bitmap:=nil;
                                                     //判断下标
                                                     Y_min :=Public_Basic.FindPointY(P_i_j_1[3].X,P_i_j_1[3].Y,t_str_sec,Sink_leixing);
                                                        P_i_j_1[2].Y:=P_i_j_1[2].Y -(P_i_j_1[3].Y-Y_min);
                                                        P_i_j_1[3].Y:=Y_min;
                                                     Image_inn.Canvas.Polygon(P_i_j_1);
                                                    //  //添加   t_Str_Fir
                                                    t_Str_Fir.Add(IntTostr( P_i_j_1[1].X )+','+IntTostr( P_i_j_1[1].Y ));
                                                    t_Str_Fir.Add(IntTostr( P_i_j_1[2].X )+','+IntTostr( P_i_j_1[2].Y ));
                                                    Image_inn.Canvas.Brush.Bitmap:=bitM;
                                                     //图形填充
                                                     Image_fill_P.x :=Trunc((P_i_j_1[0].X+P_i_j_1[2].X)/2); Image_fill_P.y:= Trunc((P_i_j_1[0].Y+P_i_j_1[2].Y)/2);
                                                     while_image:=true;
                                                     k:=0;
                                                     while while_image  do begin
                                                          if Public_Basic.IsPtInPoly (Image_fill_P.x,Image_fill_P.y,P_i_j_1) then begin
                                                             Image_inn.Canvas.FloodFill(Image_fill_P.x ,Image_fill_P.y,clBlack,fsBorder);
                                                             while_image:=false;
                                                          end else begin
                                                              K:=K+1;
                                                              Image_fill_P.x :=P_i_j_1[0].X+K; Image_fill_P.y:=  P_i_j_1[0].Y-1;
                                                              if K>5 then  while_image:=false;
                                                          end;

                                                     end; // end while
                                                         //如果是最后一层， //顶层画立体外壳
                                                         // if i=Yc_End_Nu then  begin
                                                                Point_wk[3].X := P_i_j_1[1].X ;
                                                                Point_wk[3].Y := P_i_j_1[1].Y;
                                                                Point_wk[2].X := P_i_j_1[2].X; ;
                                                                Point_wk[2].Y := P_i_j_1[2].Y;

                                                                Point_wk[0].X := Point_wk[3].X+40 ;
                                                                Point_wk[0].Y := Point_wk[3].Y-40;
                                                                Point_wk[1].X := Point_wk[2].X+40;
                                                                Point_wk[1].Y := Point_wk[2].Y-40;
                                                                  Image_inn.Canvas.Brush.Bitmap:=nil;
                                                                  Image_inn.Canvas.Polygon(Point_wk);
                                                                  Image_inn.Canvas.Brush.Bitmap:=bitM;
                                                                    //图形填充
                                                                         Image_fill_P.x :=Trunc((Point_wk[0].X+Point_wk[2].X)/2); Image_fill_P.y:= Trunc((Point_wk[0].Y+Point_wk[2].Y)/2);
                                                                         while_image:=true;
                                                                         k:=0;
                                                                         while while_image  do begin
                                                                              if Public_Basic.IsPtInPoly (Image_fill_P.x,Image_fill_P.y,Point_wk) then begin
                                                                                 Image_inn.Canvas.FloodFill(Image_fill_P.x ,Image_fill_P.y,clBlack,fsBorder);
                                                                                 while_image:=false;
                                                                              end else begin
                                                                                  K:=K+1;
                                                                                  Image_fill_P.x :=Point_wk[0].X+K; Image_fill_P.y:=  Point_wk[0].Y;
                                                                                  if K>5 then  while_image:=false;
                                                                              end;

                                                                         end; // end while

                                                         // end;   end  if i=Yc_End_Nu then  begin
                                                     Image_inn.Canvas.Brush.Bitmap:=nil;
                                                  end; //end if j>1
                                                 // while over
                                                 while_j:=false;
                                                 break;

                                            end else begin
                                                   if 10*while_j_sup_jinchi<step_i*1.05 then   begin
                                                        YanCengQingJiao:=(arctan(Rock_sa/step_i))*5*while_j_sup_jinchi/(step_i*1.05);
                                                        Sink_leixing:=0;
                                                   end else begin
                                                        YanCengQingJiao:=arctan(Rock_sa/step_i);
                                                        Sink_leixing:=1;
                                                   end;
                                                   Point_Six_P[3].X :=Point_Six_P[3].X+trunc(step_i*shiyong_bl);
                                                  // Point_t_P
                                                   Pointxy[0].X :=Point_Six_P[3].X+trunc(0.5*Sink_Sa_used*sin(YanCengQingJiao)*shiyong_bl);
                                                   Pointxy[0].Y :=Point_Six_P[3].Y-trunc((0.5*Sink_Sa_used-0.5*Sink_Sa_used*Cos(YanCengQingJiao))*shiyong_bl);
                                                   Pointxy[1].X :=Pointxy[0].X -trunc(Sink_Sa_used* sin(YanCengQingJiao)*shiyong_bl);
                                                   Pointxy[1].Y :=Pointxy[0].Y -trunc(Sink_Sa_used* cos(YanCengQingJiao)*shiyong_bl);
                                                   Pointxy[2].X :=Pointxy[1].X -trunc(step_i* cos(YanCengQingJiao)*shiyong_bl);
                                                   Pointxy[2].Y :=Pointxy[1].Y +trunc(step_i* sin(YanCengQingJiao)*shiyong_bl);
                                                   Pointxy[3].X :=Pointxy[2].X +trunc(Sink_Sa_used* sin(YanCengQingJiao)*shiyong_bl);
                                                   Pointxy[3].Y :=Pointxy[2].Y +trunc(Sink_Sa_used* cos(YanCengQingJiao)*shiyong_bl);
                                                     //判断下标
                                                           Y_min :=Public_Basic.FindPointY(Pointxy[3].X,Pointxy[3].Y,t_str_sec,Sink_leixing);
                                                           Pointxy[2].Y:=Pointxy[2].Y -(Pointxy[3].Y-Y_min);
                                                           Pointxy[3].Y:=Y_min;

                                                    //修订 第二块
                                                    if j=1 then  begin
                                                         Point_t_P[0].X :=Pointxy[3].X;;
                                                         Point_t_P[0].Y :=Pointxy[3].Y;
                                                         Point_t_P[1].X :=Pointxy[2].X;
                                                         Point_t_P[1].Y :=Pointxy[2].Y;
                                                    end else begin
                                                         P_i_j_1[0].X :=Pointxy[3].X;;
                                                         P_i_j_1[0].Y :=Pointxy[3].Y;
                                                         P_i_j_1[1].X :=Pointxy[2].X;
                                                         P_i_j_1[1].Y :=Pointxy[2].Y;
                                                          Image_inn.Canvas.Brush.Bitmap:=nil;
                                                          //判断下标
                                                           Y_min :=Public_Basic.FindPointY(P_i_j_1[3].X,P_i_j_1[3].Y,t_str_sec,Sink_leixing);
                                                           P_i_j_1[2].Y:=P_i_j_1[2].Y -(P_i_j_1[3].Y-Y_min);
                                                           P_i_j_1[3].Y:=Y_min;
                                                           Image_inn.Canvas.Polygon(P_i_j_1);
                                                            //  //添加   t_Str_Fir
                                                            t_Str_Fir.Add(IntTostr( P_i_j_1[2].X )+','+IntTostr( P_i_j_1[2].Y ));
                                                            t_Str_Fir.Add(IntTostr( P_i_j_1[1].X )+','+IntTostr( P_i_j_1[1].Y ));
                                                           Image_inn.Canvas.Brush.Bitmap:=bitM;
                                                             //图形填充
                                                             Image_fill_P.x :=Trunc((P_i_j_1[0].X+P_i_j_1[2].X)/2); Image_fill_P.y:= Trunc((P_i_j_1[0].Y+P_i_j_1[2].Y)/2);
                                                             while_image:=true;
                                                             k:=0;
                                                             while while_image  do begin
                                                                  if Public_Basic.IsPtInPoly (Image_fill_P.x,Image_fill_P.y,P_i_j_1) then begin
                                                                     Image_inn.Canvas.FloodFill(Image_fill_P.x ,Image_fill_P.y,clBlack,fsBorder);
                                                                     while_image:=false;
                                                                  end else begin
                                                                      K:=K+1;
                                                                      Image_fill_P.x :=P_i_j_1[0].X+K; Image_fill_P.y:=  P_i_j_1[0].Y;
                                                                      if K>5 then  while_image:=false;
                                                                  end;

                                                             end; // end while
                                                             //如果是最后一层， //顶层画立体外壳
                                                             // if i=Yc_End_Nu then  begin
                                                                    Point_wk[3].X := P_i_j_1[1].X ;
                                                                    Point_wk[3].Y := P_i_j_1[1].Y;
                                                                    Point_wk[2].X := P_i_j_1[2].X; ;
                                                                    Point_wk[2].Y := P_i_j_1[2].Y;

                                                                    Point_wk[0].X := Point_wk[3].X+40 ;
                                                                    Point_wk[0].Y := Point_wk[3].Y-40;
                                                                    Point_wk[1].X := Point_wk[2].X+40;
                                                                    Point_wk[1].Y := Point_wk[2].Y-40;
                                                                      Image_inn.Canvas.Brush.Bitmap:=nil;
                                                                      Image_inn.Canvas.Polygon(Point_wk);
                                                                      Image_inn.Canvas.Brush.Bitmap:=bitM;
                                                                       //图形填充
                                                                         Image_fill_P.x :=Trunc((Point_wk[0].X+Point_wk[2].X)/2); Image_fill_P.y:= Trunc((Point_wk[0].Y+Point_wk[2].Y)/2);
                                                                         while_image:=true;
                                                                         k:=0;
                                                                         while while_image  do begin
                                                                              if Public_Basic.IsPtInPoly (Image_fill_P.x,Image_fill_P.y,Point_wk) then begin
                                                                                 Image_inn.Canvas.FloodFill(Image_fill_P.x ,Image_fill_P.y,clBlack,fsBorder);
                                                                                 while_image:=false;
                                                                              end else begin
                                                                                  K:=K+1;
                                                                                  Image_fill_P.x :=Point_wk[0].X+K; Image_fill_P.y:=  Point_wk[0].Y;
                                                                                  if K>5 then  while_image:=false;
                                                                              end;

                                                                         end; // end while

                                                              //end;  //end  if i=Yc_End_Nu then  begin
                                                             Image_inn.Canvas.Brush.Bitmap:=nil;
                                                    end;


                                                   //
                                                   if while_j_sup_jinchi< step_i* 0.1 then  begin
                                                       Image_inn.Canvas.Brush.Bitmap:=nil;
                                                       //判断下标
                                                           Y_min :=Public_Basic.FindPointY(Pointxy[3].X,Pointxy[3].Y,t_str_sec,Sink_leixing);
                                                              Pointxy[2].Y:=Pointxy[2].Y -(Pointxy[3].Y-Y_min);
                                                              Pointxy[3].Y:=Y_min;
                                                        Image_inn.Canvas.Polygon(Pointxy);
                                                         //  //添加   t_Str_Fir
                                                        t_Str_Fir.Add(IntTostr(Pointxy[1].X)+','+IntTostr(Pointxy[1].Y ));
                                                        t_Str_Fir.Add(IntTostr(Pointxy[2].X )+','+IntTostr( Pointxy[2].Y ));
                                                         Image_inn.Canvas.Brush.Bitmap:=bitM;
                                                        //图形填充
                                                       Image_fill_P.x :=Trunc((Pointxy[0].X+Pointxy[2].X)/2); Image_fill_P.y:= Trunc((Pointxy[0].Y+Pointxy[2].Y)/2);
                                                       while_image:=true;
                                                       k:=0;
                                                       while while_image  do begin
                                                            if Public_Basic.IsPtInPoly (Image_fill_P.x,Image_fill_P.y,Pointxy) then begin
                                                               Image_inn.Canvas.FloodFill(Image_fill_P.x ,Image_fill_P.y,clBlack,fsBorder);
                                                               while_image:=false;
                                                            end else begin
                                                                K:=K+1;
                                                                Image_fill_P.x :=Pointxy[0].X+K; Image_fill_P.y:=  Pointxy[0].Y;
                                                                if K>5 then  while_image:=false;

                                                            end;

                                                       end;
                                                       //如果是最后一层， //顶层画立体外壳
                                                        //  if i=Yc_End_Nu then  begin
                                                                Point_wk[3].X := Pointxy[1].X ;
                                                                Point_wk[3].Y := Pointxy[1].Y;
                                                                Point_wk[2].X := Pointxy[2].X; ;
                                                                Point_wk[2].Y := Pointxy[2].Y;

                                                                Point_wk[0].X := Point_wk[3].X+40 ;
                                                                Point_wk[0].Y := Point_wk[3].Y-40;
                                                                Point_wk[1].X := Point_wk[2].X+40;
                                                                Point_wk[1].Y := Point_wk[2].Y-40;
                                                                  Image_inn.Canvas.Brush.Bitmap:=nil;
                                                                  Image_inn.Canvas.Polygon(Point_wk);
                                                                  Image_inn.Canvas.Brush.Bitmap:=bitM;
                                                                    //图形填充
                                                                         Image_fill_P.x :=Trunc((Point_wk[0].X+Point_wk[2].X)/2); Image_fill_P.y:= Trunc((Point_wk[0].Y+Point_wk[2].Y)/2);
                                                                         while_image:=true;
                                                                         k:=0;
                                                                         while while_image  do begin
                                                                              if Public_Basic.IsPtInPoly (Image_fill_P.x,Image_fill_P.y,Point_wk) then begin
                                                                                 Image_inn.Canvas.FloodFill(Image_fill_P.x ,Image_fill_P.y,clBlack,fsBorder);
                                                                                 while_image:=false;
                                                                              end else begin
                                                                                  K:=K+1;
                                                                                  Image_fill_P.x :=Point_wk[0].X+K; Image_fill_P.y:=  Point_wk[0].Y;
                                                                                  if K>5 then  while_image:=false;
                                                                              end;

                                                                         end; // end while

                                                       //   end;   // end  if i=Yc_End_Nu then  begin
                                                       Image_inn.Canvas.Brush.Bitmap:=nil;
                                                       //while over
                                                       while_j:=false;
                                                       break;
                                                   end else begin
                                                       P_i_j_1[0].X:=  Pointxy[0].X ; P_i_j_1[0].Y:=  Pointxy[0].Y ;
                                                       P_i_j_1[1].X:=  Pointxy[1].X ; P_i_j_1[1].Y:=  Pointxy[1].Y ;
                                                       P_i_j_1[2].X:=  Pointxy[2].X ; P_i_j_1[2].Y:=  Pointxy[2].Y ;
                                                       P_i_j_1[3].X:=  Pointxy[3].X ; P_i_j_1[3].Y:=  Pointxy[3].Y ;
                                                       j:=j+1;
                                                   end;


                                            end;  //end if while_j_sup_jinchi<0  then begin


                                      end; // end while
                               end;  // end if  jinChi+zhijia.Zj_KongdingJU+2*StrToFloat(temp1[1])-2*YockLiang_Suo  > Step0*1.05  then begin
                                    //服值

                                 //inn_left_x2 := Point_Six_P[2].X ;
                                      //draw 右侧 老顶
                                 Point_Six_P[5].X :=Image_inn.Width;
                                      Point_Six_P[5].Y :=inn_left_y0;
                                 if StrToFloat(temp1[3])>0 then begin
                                      Point_Six_P[3].Y :=inn_right_y2-trunc((inn_left_y2-inn_left_y0)*(StrToFloat(temp1[3])-StrToFloat(temp1[1]))/StrToFloat(temp1[3]));
                                 end else begin
                                      Point_Six_P[3].Y :=inn_right_y2;
                                 end;

                            end ;//end    if jinChi+zhijia.Zj_KongdingJU+2*StrToFloat(temp1[1])-2*YockLiang_Suo< Step0 * 0.95  then  begin
                                  // 填充第二块
                                         Image_inn.Canvas.Brush.Bitmap:=nil;
                                          //判断下标
                                         Y_min :=Public_Basic.FindPointY(Point_t_P[3].X,Point_t_P[3].Y,t_str_sec,Sink_leixing);
                                            Point_t_P[2].Y:=Point_t_P[2].Y -(Point_t_P[3].Y-Y_min);
                                            Point_t_P[3].Y:=Y_min;

                                         Image_inn.Canvas.Polygon(Point_t_P);
                                           //  //添加   t_Str_Fir
                                          t_Str_Fir.Insert(5,IntTostr( Point_t_P[2].X )+','+IntToStr( Point_t_P[2].Y ));
                                          t_Str_Fir.Insert(6,IntTostr( Point_t_P[1].X )+','+IntToStr( Point_t_P[1].Y ));

                                         Image_inn.Canvas.Brush.Bitmap:=bitM;

                                         //图形填充
                                         Image_fill_P.x :=Trunc((Point_t_P[0].X+Point_t_P[2].X)/2); Image_fill_P.y:= Trunc((Point_t_P[0].Y+Point_t_P[2].Y)/2);
                                         while_image:=true;
                                         k:=0;
                                         while while_image  do begin
                                              if Public_Basic.IsPtInPoly (Image_fill_P.x,Image_fill_P.y,Point_t_P) then begin
                                                 Image_inn.Canvas.FloodFill(Image_fill_P.x ,Image_fill_P.y,clBlack,fsBorder);
                                                 while_image:=false;
                                              end else begin
                                                  K:=K+1;
                                                  Image_fill_P.x :=Point_t_P[0].X-K; Image_fill_P.y:=  Point_t_P[0].Y-1;
                                                  if K>5 then  while_image:=false;

                                              end;

                                         end;
                                          //如果是最后一层， //顶层画立体外壳
                                                       //   if i=Yc_End_Nu then  begin
                                                                Point_wk[3].X := Point_t_P[2].X ;
                                                                Point_wk[3].Y := Point_t_P[2].Y;
                                                                Point_wk[2].X := Point_t_P[1].X; ;
                                                                Point_wk[2].Y := Point_t_P[1].Y;

                                                                Point_wk[0].X := Point_wk[3].X+40 ;
                                                                Point_wk[0].Y := Point_wk[3].Y-40;
                                                                Point_wk[1].X := Point_wk[2].X+40;
                                                                Point_wk[1].Y := Point_wk[2].Y-40;
                                                                  Image_inn.Canvas.Brush.Bitmap:=nil;
                                                                  Image_inn.Canvas.Polygon(Point_wk);
                                                                  Image_inn.Canvas.Brush.Bitmap:=bitM;
                                                                   //图形填充
                                                                         Image_fill_P.x :=Trunc((Point_wk[0].X+Point_wk[2].X)/2); Image_fill_P.y:= Trunc((Point_wk[0].Y+Point_wk[2].Y)/2);
                                                                         while_image:=true;
                                                                         k:=0;
                                                                         while while_image  do begin
                                                                              if Public_Basic.IsPtInPoly (Image_fill_P.x,Image_fill_P.y,Point_wk) then begin
                                                                                 Image_inn.Canvas.FloodFill(Image_fill_P.x ,Image_fill_P.y,clBlack,fsBorder);
                                                                                 while_image:=false;
                                                                              end else begin
                                                                                  K:=K+1;
                                                                                  Image_fill_P.x :=Point_wk[0].X+K; Image_fill_P.y:=  Point_wk[0].Y;
                                                                                  if K>5 then  while_image:=false;
                                                                              end;

                                                                         end; // end while

                                                         // end;   //end  if i=Yc_End_Nu then  begin
                                                       Image_inn.Canvas.Brush.Bitmap:=nil;
                                         Image_inn.Canvas.Brush.Bitmap:=nil;

                                  //draw 右侧 老顶
                                 Point_Six_P[0].X :=Point_Six_P[5].X;
                                       Point_Six_P[0].Y :=Point_Six_P[5].Y-trunc(used_h*shiyong_bl);
                                 Point_Six_P[2].X :=Point_Six_P[3].X;
                                       Point_Six_P[2].Y :=Point_Six_P[3].Y-trunc(used_h*shiyong_bl);
                                  Point_Six_P[4].X :=Point_Six_P[3].X + trunc((StrToFloat(temp1[3])-StrToFloat(temp1[1]))*shiyong_bl);
                                       Point_Six_P[4].Y :=Point_Six_P[5].Y;
                                  Point_Six_P[1].X :=Point_Six_P[4].X;
                                       Point_Six_P[1].Y :=Point_Six_P[0].Y;

                                  Image_inn.Canvas.Polygon(Point_Six_P) ;
                                    //  //添加   t_Str_Fir
                                  t_Str_Fir.Add(IntTostr( Point_Six_P[2].X )+','+IntTostr( Point_Six_P[2].Y ));
                                  t_Str_Fir.Add(IntTostr( Point_Six_P[1].X )+','+IntTostr( Point_Six_P[1].Y ));
                                  t_Str_Fir.Add(IntTostr( Point_Six_P[0].X )+','+IntTostr( Point_Six_P[0].Y ));

                                  Image_inn.Canvas.Brush.Bitmap:=bitM;
                                               if  (Point_Six_P[4].Y-Point_Six_P[1].Y>4)  then
                                                    Image_inn.Canvas.FloodFill(Trunc((Point_Six_P[0].X+Point_Six_P[3].X)/2),Trunc((Point_Six_P[1].Y+Point_Six_P[4].Y)/2),clBlack,fsBorder);
                                 Image_inn.Canvas.Brush.Bitmap:=nil;
                                    //填写右侧压力拱数据
                                  YLG_R1.Insert(0,InttoStr(Point_Six_P[2].X)+','+InttoStr(Point_Six_P[2].Y) );
                                  YLG_R2.insert(0,InttoStr(Point_Six_P[2].X+trunc(StrToFloat(temp1[4])*shiyong_bl))+','+InttoStr(Point_Six_P[2].Y) );

                                  //如果是最后一层， //顶层画立体外壳
                             // if i=Yc_End_Nu then  begin
                                    Point_wk[3].X := Point_Six_P[2].X ;
                                    Point_wk[3].Y := Point_Six_P[2].Y;
                                    Point_wk[2].X := Point_Six_P[0].X; ;
                                    Point_wk[2].Y := Point_Six_P[0].Y;

                                    Point_wk[0].X := Point_wk[3].X+40 ;
                                    Point_wk[0].Y := Point_wk[3].Y-40;
                                    Point_wk[1].X := Point_wk[2].X+40;
                                    Point_wk[1].Y := Point_wk[2].Y-40;
                                      Image_inn.Canvas.Brush.Bitmap:=nil;
                                      Image_inn.Canvas.Polygon(Point_wk);
                                      Image_inn.Canvas.Brush.Bitmap:=bitM;
                                        //图形填充
                                         Image_fill_P.x :=Trunc((Point_wk[0].X+Point_wk[2].X)/2); Image_fill_P.y:= Trunc((Point_wk[0].Y+Point_wk[2].Y)/2);
                                         while_image:=true;
                                         k:=0;
                                         while while_image  do begin
                                              if Public_Basic.IsPtInPoly (Image_fill_P.x,Image_fill_P.y,Point_wk) then begin
                                                 Image_inn.Canvas.FloodFill(Image_fill_P.x ,Image_fill_P.y,clBlack,fsBorder);
                                                 while_image:=false;
                                              end else begin
                                                  K:=K+1;
                                                  Image_fill_P.x :=Point_wk[0].X+K; Image_fill_P.y:=  Point_wk[0].Y;
                                                  if K>5 then  while_image:=false;
                                              end;

                                         end; // end while

                             // end;  //end  if i=Yc_End_Nu then  begin

                            //本层决定下一层的内缩
                             YockLiang_Suo:=YockLiang_Suo+used_h*tan(25/180*3.1415926);
                             inn_left_y0:=Point_Six_P[0].Y ;inn_left_y2:=Point_Six_P[2].Y; inn_right_y2:= inn_left_y2;

                             t_str_sec.Clear;
                             t_str_sec.Text:=t_str_fir.Text;
                             s_out:=t_str_sec.Text;
                             t_str_fir.Clear ;

                 end; //end for i

                   //老顶 画 在当前推进进尺下 不动的岩层
                  if i>= 0 then  begin
                       for j := i downto model_start_yc do  begin
                            Pointxy[0].X :=0 ;

                              if (j=imm.End_No) and (imm.Surplus_h>0) then    begin
                                  used_h :=imm.Surplus_h;
                              end else begin
                                  used_h:=zk.Yc_Rock[j].R_h;
                              end;


                            if j<old.yl_max_End -2  then    begin
                                Pointxy[0].Y :=inn_left_y0-trunc((used_h*hcd_bl)*shiyong_bl);
                             end else begin
                                Pointxy[0].Y :=inn_left_y0-trunc((used_h)*shiyong_bl);
                             end;

                            Pointxy[1].X :=Image_inn.Width ;
                            Pointxy[1].Y :=Pointxy[0].Y;
                            Pointxy[2].X :=Pointxy[1].X  ;
                            Pointxy[2].Y :=inn_left_y0;
                            Pointxy[3].X :=Pointxy[0].X ;
                            Pointxy[3].Y :=Pointxy[2].Y ;
                            Image_inn.Canvas.Brush.Bitmap:=nil;
                         //填充图例
                            bitM.FreeImage;
                            if Tuxing=0 then   begin
                              if  fileexists(dll_Path+'\BmpSi\'+zk.Yc_Rock[j].R_Name+'.Bmp') then  begin
                                  bitM.LoadFromFile(dll_Path+'\BmpSi\'+zk.Yc_Rock[j].R_Name+'.Bmp');//装入图像文件
                              end else begin
                                  bitM.LoadFromFile(dll_Path+'\BmpSi\NULL.Bmp');
                              end;

                            end else begin
                                if  fileexists(dll_Path+'\BmpFZ\'+zk.Yc_Rock[j].R_Name+'.Bmp') then  begin
                                  bitM.LoadFromFile(dll_Path+'\BmpFZ\'+zk.Yc_Rock[j].R_Name+'.Bmp');//装入图像文件
                                end else begin
                                  bitM.LoadFromFile(dll_Path+'\BmpFz\NULL.Bmp');
                                end;

                            end; // end if Tuxing
                                Image_inn.Canvas.Brush.Bitmap:=nil;
                                Image_inn.Canvas.Polygon(Pointxy);
                                Image_inn.Canvas.Brush.Bitmap:=bitM;
                                 if   (Pointxy[2].Y-Pointxy[1].Y>4)  then
                                        Image_inn.Canvas.FloodFill(Trunc((Pointxy[0].X+Pointxy[2].X)/2),Trunc((Pointxy[0].Y+Pointxy[2].Y)/2),clBlack,fsBorder);
                                Image_inn.Canvas.Brush.Bitmap:=nil;

                            //如果是最后一层， //顶层画立体外壳
                            //  if j=Yc_End_Nu then  begin
                                    Point_wk[3].X := Pointxy[0].X ;
                                    Point_wk[3].Y := Pointxy[0].Y;
                                    Point_wk[2].X := Pointxy[1].X ;
                                    Point_wk[2].Y := Pointxy[1].Y;

                                    Point_wk[0].X := Point_wk[3].X+40 ;
                                    Point_wk[0].Y := Point_wk[3].Y-40;
                                    Point_wk[1].X := Point_wk[2].X+40;
                                    Point_wk[1].Y := Point_wk[2].Y-40;
                                      Image_inn.Canvas.Brush.Bitmap:=nil;
                                      Image_inn.Canvas.Polygon(Point_wk);
                                      Image_inn.Canvas.Brush.Bitmap:=bitM;
                                         //图形填充
                                       Image_fill_P.x :=Trunc((Point_wk[0].X+Point_wk[2].X)/2); Image_fill_P.y:= Trunc((Point_wk[0].Y+Point_wk[2].Y)/2);
                                       while_image:=true;
                                       k:=0;
                                       while while_image  do begin
                                            if Public_Basic.IsPtInPoly (Image_fill_P.x,Image_fill_P.y,Point_wk) then begin
                                               Image_inn.Canvas.FloodFill(Image_fill_P.x ,Image_fill_P.y,clBlack,fsBorder);
                                               while_image:=false;
                                            end else begin
                                                K:=K+1;
                                                Image_fill_P.x :=Point_wk[0].X+K; Image_fill_P.y:=  Point_wk[0].Y;
                                                if K>5 then  while_image:=false;
                                            end;

                                       end; // end while

                             // end;  end  if i=Yc_End_Nu then  begin

                           inn_left_y0:=Pointxy[0].Y;
                       end;  //end for j

                         
                  end;  // end if  i   }

               // 画 老塘矸石
                     if ganshi_Count>0 then  begin
                            Point_Six_P[0].X :=trunc(gzm.ZCYL_sx[2]*shiyong_bl)+2;
                                 Point_Six_P[0].Y :=ganshi_y0;
                                 if ganshi_y2>0 then   begin
                                     Point_Six_P[1].Y:=ganshi_y0+trunc((ganshi_y2-ganshi_y0)*0.5);
                                     Point_Six_P[2].Y:=ganshi_y2;

                                 end else begin
                                     Point_Six_P[1].Y :=ganshi_y0-trunc(ganshi_h*0.5*shiyong_bl);
                                     Point_Six_P[2].Y :=ganshi_y0-trunc(ganshi_h*shiyong_bl);
                                 end;

                            Point_Six_P[1].X := Point_Six_P[0].X+trunc((Point_Six_P[0].Y -Point_Six_P[1].Y )*tan(10/180*3.14159));

                            Point_Six_P[4].X :=ganshi_right_x4-trunc((Point_Six_P[0].Y -Point_Six_P[1].Y )*tan(15/180*3.14159));;
                                 Point_Six_P[4].Y :=Point_Six_P[1].Y ;

                            Point_Six_P[2].X :=Point_Six_P[1].X+trunc((Point_Six_P[1].Y -Point_Six_P[2].Y )*tan(30/180*3.14159));
                            Point_Six_P[3].X :=Point_Six_P[4].X-trunc((Point_Six_P[1].Y -Point_Six_P[2].Y )*tan(30/180*3.14159));
                                 Point_Six_P[3].Y :=Point_Six_P[2].Y;

                            Point_Six_P[5].X :=ganshi_right_x4;
                                 Point_Six_P[5].Y :=Point_Six_P[0].Y;

                            Image_inn.Canvas.Brush.Bitmap:=nil;
                            Image_inn.Canvas.Polygon(Point_Six_P) ;
                             //填充图例
                             bitM.FreeImage;
                              if Tuxing=0 then   begin
                                if  fileexists(dll_Path+'\BmpSi\矸石.Bmp') then  begin
                                    bitM.LoadFromFile(dll_Path+'\BmpSi\矸石.Bmp');//装入图像文件
                                end else begin
                                    bitM.LoadFromFile(dll_Path+'\BmpSi\NULL.Bmp');
                                end;

                               end else begin
                                  if  fileexists(dll_Path+'\BmpFZ\矸石.Bmp') then  begin
                                    bitM.LoadFromFile(dll_Path+'\BmpFZ\矸石.Bmp');//装入图像文件
                                  end else begin
                                    bitM.LoadFromFile(dll_Path+'\BmpFz\NULL.Bmp');
                                  end;
                              end;
                            Image_inn.Canvas.Brush.Bitmap:=bitM;
                               if  (Point_Six_P[0].Y-Point_Six_P[2].Y>4)  then
                                    Image_inn.Canvas.FloodFill(Trunc((Point_Six_P[0].X+Point_Six_P[3].X)/2),Trunc((Point_Six_P[1].Y+Point_Six_P[4].Y)/2),clBlack,fsBorder);

                            Image_inn.Canvas.Brush.Bitmap:=nil;  
                    end;
        //画支撑压力线
        //左侧
        drawZcyl(Image_inn,zcyl_l_p1,zcyl_L_p2,temp1,shiyong_bl,false);
        drawZcyl(Image_inn,zcyl_R_p1,zcyl_R_p2,temp1,shiyong_bl,true);
        //支撑压力平衡拱
        if disp_ylg=1 then  begin
           draw_ylg(Image_inn,YLG_L1,YLG_L2,YLG_R1,YLG_R2);

        end;
      
      StretchBlt(Image_out.Canvas.Handle,LeftBlank+1,topBlank+1,Image_out.Width-RightBlank-leftBlank-1,Image_out.Height-BottomBlank-TopBlank-1,Image_inn.Canvas.Handle,X_move_pix,1,Image_out.Width-RightBlank-LeftBlank-1,Image_inn.Height-1,SRCCOPY);
     // bitblt(Image_out.Canvas.Handle,LeftBlank+1,topBlank+1,Image_out.Width-RightBlank-leftBlank-1,Image_out.Height-BottomBlank-TopBlank-1,Image_inn.Canvas.Handle,+X_move_pix,1,SRCCOPY);

      bitmap.Free;
      bitM.free;
      Image_inn.Free;
      result:=X_move_pix;
      FreeAndnil(t_Str_Fir);
      FreeAndnil(t_Str_sec);
      FreeAndnil(YLG_L1);
      FreeAndnil(YLG_L2);
      FreeAndnil(YLG_R1);
      FreeAndnil(YLG_R2);
      //画 支撑压力曲线
    
end; //end procedure draw_fyyd



{ TMainClass_PStope }

constructor TMainClass_PStope.Create;
begin
       t_Gzm:=TG_Stope.Create ;     //工作面
       t_zk:=Tzk_bore.Create ;     //钻孔
       t_imm_r:=TImmediate_roof.Create; //直接顶
       t_old:=Told_roof.Create;    //老顶
       t_ZhiJia:=TZJ_Class.Create;  //支架
       t_Cal_show:=TCal_Show.Create;
end;

destructor TMainClass_PStope.Destroy;

begin
   freeAndNil(t_Gzm);     //工作面
   freeAndNil(t_zk) ;     //钻孔
   freeAndNil(t_imm_r) ; //直接顶
   freeAndNil(t_old) ;    //老顶
   freeAndNil(t_ZhiJia) ;  //支架
   freeAndNil(t_Cal_show);
   inherited Destroy;
end;

function TMainClass_PStope.Get_Edit_ZkCS: WideString;
begin
   Result:=t_zk.Return_ZkCs;
end;

function TMainClass_PStope.Get_Stope_info: string;
var
  EStr:String;
  MPa_Xs,kongding_s,liz_s,D:double;
begin
    kongding_s:=t_ZhiJia.Zj_KongdingJU*t_ZhiJia.Zj_zhongxinju;
    //计算立柱的直径
    if t_ZhiJia.Zj_Lz_Diameter=0 then begin
       D:=320 ;
    end  else D:=t_ZhiJia.Zj_Lz_Diameter;
    liz_s:=0.25*3.1415926*(D/1000)*(D/1000);
    if t_ZhiJia.Zj_Lizhu_count=0 then  t_ZhiJia.Zj_Lizhu_count:=2;
    MPa_Xs:= t_ZhiJia.zj_toall_P* kongding_s/liz_s/t_ZhiJia.Zj_Lizhu_count;  //计算出MPa系数

    EStr:=FormatFloat('0.00',t_old.YL_Zhouqi_step[0])+',' + //周期来压步距最大值
          FormatFloat('0.00',t_old.YL_Zhouqi_step[1])+',' + //周期来压步距小值
          FormatFloat('0.00',t_old.YL_Zhouqi_step[2])+',' + //周期来压步距平均值
          FormatFloat('0.00',t_ZhiJia.Zj_imm_p*MPa_Xs )+',' + //直接顶支护强度
          FormatFloat('0.00',t_ZhiJia.Zj_JiSuan_Ci_P[0]*MPa_Xs )+',' + //老顶支护强度最大值
          FormatFloat('0.00',t_ZhiJia.Zj_JiSuan_Ci_P[1]*MPa_Xs )+',' + //老顶支护强度最小值
          FormatFloat('0.00',t_ZhiJia.Zj_JiSuan_Ci_P[2]*MPa_Xs )+',' + //老顶支护强度平均值
          ' ' ;
   Result:=Estr;

end;

function TMainClass_PStope.InitModel(GzmStr, ZkStr: String;Var sEorr:String): Boolean;
Var
  StrE:wideString;
begin
     Result:=false;
     if (not (t_Gzm.Init(GzmStr,StrE))  or  (not T_Zk.Init(ZkStr,StrE)))   then  begin
       //MyMainFun.WriteLog('Eorr: GetGzmZkStr/UsedDrill.Zk_Yc_Count<1','[TGZM]');
       exit;
     end;

      //继续计算
     if not T_imm_r.init(T_gzm,t_zk,0.5,StrE) then   exit;
     if not t_old.init(t_Gzm,t_zk,t_imm_r,StrE) then  exit;
     Cal_Zcyl(t_zk,t_imm_r,t_gzm,t_old,StrE);
     Cal_Ldg(t_zk,t_gzm,t_imm_r,t_old,t_gzm.S_L_qx*1.5,StrE);
     sEorr:=StrE;
     Result:=true;
end;

procedure TMainClass_PStope.Set_Old_Step(MaxValue, MinValue, AGVVale: Double);
var
   Flag:Boolean;
   StepD:double;
   AddOrMin,i,AdjustCount:integer;
   sEorr:widestring;
begin
    Flag:=true;
    StepD:=0.5;
    AddOrMin:=0;
    if AGVVale< t_old.YL_Zhouqi_step[2]*0.9 then  AGVVale:= t_old.YL_Zhouqi_step[2]*0.9 ;
    if AGVVale > t_old.YL_Zhouqi_step[2]*1.1 then  AGVVale:= t_old.YL_Zhouqi_step[2]*1.1 ;
    AdjustCount:=0; //调节次数,防止循环
    while Flag do  begin
        if AGVVale >t_old.YL_Zhouqi_step[2]+0.5 then  begin   //实际距离超过计算距离
           if AddOrMin=-1 then   StepD:=StepD/2;
           AddOrMin:=1; AdjustCount:=AdjustCount+1;

            for I := t_old.YL_min_End+1 to t_old.YL_start do
               t_zk.Yc_Rock[i].R_klqd:=t_zk.Yc_Rock[i].R_klqd+StepD;

        end else  if AGVVale <t_old.YL_Zhouqi_step[2]-0.5  then  begin     //实际距离小于计算距离
          if AddOrMin=1 then   StepD:=StepD/2;
           AddOrMin:=-1; AdjustCount:=AdjustCount+1;
            for I := t_old.YL_min_End+1 to t_old.YL_start do
               t_zk.Yc_Rock[i].R_klqd:=t_zk.Yc_Rock[i].R_klqd-StepD;
        end else  begin
           Flag:=False;
        end;

         //重新计算
          T_imm_r.init(T_gzm,t_zk,0.5,sEorr);  //  直接顶计算
          t_old.init(t_Gzm,t_zk,t_imm_r,sEorr); //   老顶计算
          t_zhijia.Cal_Sup_Para(T_gzm,t_zk,T_imm_r,t_old);// 支架计算
          Cal_Zcyl(t_zk,t_imm_r,t_gzm,t_old,sEorr);  //计算支撑压力分布
          Cal_Ldg(t_zk,t_gzm,t_imm_r,t_old,t_gzm.S_L_qx*1.5,sEorr);//计算裂断带高度
       // 防止陷入无休止调节死循环
       if AdjustCount >10  then Flag:=False;
    end;
end;

end.       //本模块结束标记，不能更改！！！！


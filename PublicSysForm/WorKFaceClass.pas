unit WorKFaceClass;

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

implementation


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



 function TG_stope.Return_Zcyl(Version: WideString; JinChi: double;
  zk: Tzk_bore): Widestring;
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
   end;   function TZk_bore.ReturnCxbj(zk: TZk_bore): wideString;
begin

end;

function TZk_bore.ReturnSa(zk: TZk_bore): wideString;
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

//- 本函数结束标记，

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

{ TYc_Rock }

procedure TYc_Rock.Step_Rock(h, Rc, r: double);
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

end;

end. //end function

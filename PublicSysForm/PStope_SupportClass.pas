unit PStope_SupportClass;

interface

uses
  Windows, SysUtils, Classes, Messages, Controls, Forms, StdCtrls, ExtCtrls
  ,ComCtrls,math,IniFiles,Jpeg,Graphics,Dialogs,Lu_Public_BasicModual
  ,PStope_WorKFace,PStope_Immediate
   ;
type
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
         Zj_emp1_Formula:array[0..2] of double;// 经验方程1 计算支护强度
         Zj_emp2_Formula:array[0..2] of double;// 经验方程2 计算支护强度
         Zj_emp3_Formula:array[0..2] of double;// 经验方程2 计算支护强度
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

         function  Init(str:wideString;out sEorr:Widestring):WordBool; //初始化支架
         procedure Cal_empirical_formula1(gzm:TG_Stope); //动载系数法
         procedure Cal_empirical_formula2(gzm:TG_Stope); //开采高度法
         procedure Cal_empirical_formula3(gzm:TG_Stope;imm:TImmediate_roof;old:Told_roof); //经验公式法
         procedure Cal_sup_Beam_def(gzm:TG_Stope;Zk:Tzk_bore;imm:TImmediate_roof;old:Told_roof); //挠曲法计算压强
         procedure Cal_Sup_Beam_step( gzm:TG_Stope;Zk:Tzk_bore;imm:TImmediate_roof;old:Told_roof);//步距法计算压强
         function  OneBeam_sup(gzm:TG_Stope;Zk:Tzk_bore;imm:TImmediate_roof;old:Told_roof):double; // 单岩梁计算压力
         function  ManyBeam_sup(gzm:TG_Stope;Zk:Tzk_bore;imm:TImmediate_roof;old:Told_roof):double ; // 多梁计算压力
         procedure  Having_stress(gzm: TG_Stope; Zk: Tzk_bore; mm: TImmediate_roof; old: Told_roof;
                                  idefOrStep:string;BeamNumber:integer;MaxV,MinV:double); // 有内应力计算压力
         function  NOHaving_stress(gzm:TG_Stope;Zk:Tzk_bore;imm:TImmediate_roof;old:Told_roof):double ; // 无内应力计算压力
         procedure  Calculate_weight(gzm:TG_Stope;Zk:Tzk_bore;old:Told_roof;defOrStep:string;BeamNumber:integer;
                    var maxV,minV :double);

         function  Cal_Sup_Para(gzm:TG_Stope;Zk:Tzk_bore;imm:TImmediate_roof;old:Told_roof):WideString; //计算支架参sh

         function  DzXd_Cal_sup_para(gzm:TG_Stope;Zk:Tzk_bore;imm:TImmediate_roof;old:Told_roof):WideString; //  根据地质条件修订支架的基本参数
         function  Return_zj_Para(Version:WideString):WideString;   //返回支架参数
         function  SpliJG(str:widestring;out sEorr:widestring):WordBool; //拆分传入支架结构字符串
         function  ReadZhijia_XS(gzm:TG_Stope;Zk:Tzk_bore;imm:TImmediate_roof;old:Told_roof):WideString; //计算支架参sh
         procedure Draw_zhiJia(Image:TImage;x1,y1,x2,y2,mc_h:double;lizhushu,jia_type:integer);// jia_type 1 综采  2 综放
         procedure Revision_ZhiJiaZuli;// 修订支架阻力 根据现场的情况
  end;

implementation

{ TZJ_Class }

procedure TZJ_Class.Calculate_weight(gzm: TG_Stope; Zk: Tzk_bore;
  old: Told_roof; defOrStep: string; BeamNumber: integer; var maxV,
  minV: double);
begin
   maxV:=0;MinV:=0;
   if defOrStep='Def' then  begin
      if BeamNumber+1>old.YL_Dep_struct then  exit;
      maxV:=zk.Beam_Def[BeamNumber].Step_0_Simple* (zk.Beam_Def[BeamNumber].Ztc_ms+
               zk.Beam_Def[BeamNumber].Sdc_mc)*25;
      minV:=zk.Beam_Def[BeamNumber].Step_0_Compr* (zk.Beam_Def[BeamNumber].Ztc_ms+
               zk.Beam_Def[BeamNumber].Sdc_mc)*25;
   end else begin
      if BeamNumber+1>old.YL_Step_struct then  exit;

      maxV:=zk.Beam_step[BeamNumber].Step_0_Simple* (zk.Beam_step[BeamNumber].Ztc_ms+
               zk.Beam_step[BeamNumber].Sdc_mc)*25;
      minV:=zk.Beam_step[BeamNumber].Step_0_Compr* (zk.Beam_step[BeamNumber].Ztc_ms+
               zk.Beam_step[BeamNumber].Sdc_mc)*25;

   end;
end;

procedure TZJ_Class.Cal_empirical_formula1(gzm: TG_Stope);
var
  fujia_C:double;
begin
     {
     Q=h*r*D/(k-1)cosa *B
     Q 液压支架的支护强度；h 工作面开采采高   r顶板岩石容量   2.5
     D 顶板来压动载系数  ci <8 D=1.1; Ci <=15 D =1.3 ;ci<=20 D= 1.5  Ci >=25 D=1.7
     k 顶板岩石破碎膨胀系数    a工作面倾角
     B 附加阻力系数 两立柱取 1.2，四立柱取 1.6
     }
     if self.Zj_Lizhu_count=2 then  fujia_C:=1.2  else   fujia_C:=1.6 ;
     //最大值
     self.Zj_emp1_Formula[0]:=gzm.S_Cg_h*25*gzm.dynamic_factor* (fujia_C+0.1);
        self.Zj_emp1_Formula[0]:=self.Zj_emp1_Formula[0]/((1.1-1)*cos(gzm.S_qj/180.0*3.14159));
     //最小值
     self.Zj_emp1_Formula[1]:=gzm.S_Cg_h*23*gzm.dynamic_factor* (fujia_C-0.1);
        self.Zj_emp1_Formula[1]:=self.Zj_emp1_Formula[0]/((1.3-1)*cos(gzm.S_qj/180.0*3.14159));
     //中间值
     self.Zj_emp1_Formula[2]:=gzm.S_Cg_h*24*gzm.dynamic_factor* (fujia_C);
        self.Zj_emp1_Formula[2]:=self.Zj_emp1_Formula[0]/((1.2-1)*cos(gzm.S_qj/180.0*3.14159));


end;

procedure TZJ_Class.Cal_empirical_formula2(gzm: TG_Stope);
begin
    {
     Q=KHR
     Q 液压支架的支护强度；  r顶板岩石容量   2.5
     k 作用于支架上的顶板岩石系数    一般取 5-8
     h 工作面开采采高
     }
     //最大值
     self.Zj_emp2_Formula[0]:=gzm.S_Cg_h*25*8;
     //最小值
     self.Zj_emp2_Formula[1]:=gzm.S_Cg_h*23*5;
     //中间值
     self.Zj_emp2_Formula[2]:=gzm.S_Cg_h*24*6.5;
end;

procedure TZJ_Class.Cal_empirical_formula3(gzm: TG_Stope; imm: TImmediate_roof;
  old: Told_roof);
var
   N: double;
begin
    { 史学伟经验公式
      q=72.3M + 4.5 L2 +78.9 Ls-10.24N-62..1
      M 开采高度
      L2 老顶来压步距
      Ls 控顶宽度
    }
    N:=imm.Immroof_M/gzm.S_Cg_h;

     //最大值
     self.Zj_emp3_Formula[0]:=gzm.S_Cg_h*72.3+old.YL_Zhouqi_step[0]*4.5+78.9*self.Zj_KongdingJU
                  -10.24*N-62.1;
     //最小值
     self.Zj_emp3_Formula[1]:=gzm.S_Cg_h*72.3+old.YL_Zhouqi_step[1]*4.5+78.9*self.Zj_KongdingJU
                  -10.24*N-62.1;
     //中间值
     self.Zj_emp3_Formula[2]:=gzm.S_Cg_h*72.3+old.YL_Zhouqi_step[2]*4.5+78.9*self.Zj_KongdingJU
                  -10.24*N-62.1;
end;

procedure TZJ_Class.Cal_sup_Beam_def(gzm: TG_Stope; Zk: Tzk_bore;
  imm: TImmediate_roof; old: Told_roof);
begin

end;

procedure TZJ_Class.Cal_Sup_Beam_step(gzm: TG_Stope; Zk: Tzk_bore;
  imm: TImmediate_roof; old: Told_roof);
begin

end;

function TZJ_Class.Cal_Sup_Para(gzm: TG_Stope; Zk: Tzk_bore;
  imm: TImmediate_roof; old: Told_roof): WideString;
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

        old.YL_min_m:=Zk.Beam_step[0].Ztc_ms;
        old.YL_max_m:=old.YL_min_m+gzm.S_Cg_h;


       if gzm.ZCYL_s0>1 then   begin        //     1----  有内应力场
         if old.YL_struc =1 then begin   //   begin  2----单岩梁结构
            //老顶初次来压 //压力
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
            Old_Ci_F[0] :=Imm_F+ old.YL_max_m*old.YL_First_step[0]*25*Zj_zhongxinju*YLFDXS*gzm.Ci_xs;    //阻力最大值
            YLFDXS :=Zj_DBFD_xs[2];
            Old_Ci_F[1] := Imm_F+old.YL_min_m *old.YL_First_step[1]*25* Zj_zhongxinju*YLFDXS*gzm.Ci_xs;  //阻力最小值
            YLFDXS :=Zj_DBFD_xs[2];
            Old_Ci_F[2] := Imm_F+old.YL_min_m *old.YL_First_step[2]*25* Zj_zhongxinju*YLFDXS*gzm.Ci_xs;  //阻力平均值

             //缩量
            Old_Ci_L[0] :=(gzm.S_Cg_h+gzm.S_Fm_h)*(gzm.ZCYL_s0+ZJ_hlzyd)/(old.YL_First_step[1]*gzm.Ci_xs);  //缩量最大值
            Old_Ci_L[1] :=(gzm.S_Cg_h+gzm.S_Fm_h)*(gzm.ZCYL_s0+ZJ_hlzyd)/(old.YL_First_step[0]*gzm.Ci_xs);  //缩量最小值
            Old_Ci_L[2] :=(gzm.S_Cg_h+gzm.S_Fm_h)*(gzm.ZCYL_s0+ZJ_hlzyd)/(old.YL_First_step[2]*gzm.Ci_xs);  //缩量平均值


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
                    Old_Ci_F[0] :=Imm_F+ old.YL_max_m*old.YL_First_step[0]*25*Zj_zhongxinju*YLFDXS*gzm.Ci_xs;    //阻力最大值
                    YLFDXS :=Zj_DBFD_xs[4];
                    Old_Ci_F[1] := Imm_F+old.YL_min_m *old.YL_First_step[1]*25* Zj_zhongxinju*YLFDXS*gzm.Ci_xs;  //阻力最小值
                    YLFDXS :=Zj_DBFD_xs[4];
                    Old_Ci_F[2] := Imm_F+old.YL_min_m *old.YL_First_step[2]*25* Zj_zhongxinju*YLFDXS*gzm.Ci_xs;  //阻力平均值

                     //缩量
                    Old_Ci_L[0] :=(gzm.S_Cg_h+gzm.S_Fm_h)*(gzm.ZCYL_s0+ZJ_hlzyd)/(old.YL_First_step[1]*gzm.Ci_xs);  //缩量最大值
                    Old_Ci_L[1] :=(gzm.S_Cg_h+gzm.S_Fm_h)*(gzm.ZCYL_s0+ZJ_hlzyd)/(old.YL_First_step[0]*gzm.Ci_xs);  //缩量最小值
                    Old_Ci_L[2] :=(gzm.S_Cg_h+gzm.S_Fm_h)*(gzm.ZCYL_s0+ZJ_hlzyd)/(old.YL_First_step[2]*gzm.Ci_xs);  //缩量平均值



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
                Old_Ci_F[0] :=Imm_F+ old.YL_max_m*old.YL_First_step[0]*25*Zj_zhongxinju*YLFDXS*gzm.Ci_xs;    //阻力最大值
                YLFDXS :=Zj_DBFD_xs[7];
                Old_Ci_F[1] := Imm_F+old.YL_min_m *old.YL_First_step[1]*25* Zj_zhongxinju*YLFDXS*gzm.Ci_xs;  //阻力最小值
                YLFDXS :=Zj_DBFD_xs[7];
                Old_Ci_F[2] := Imm_F+old.YL_min_m *old.YL_First_step[2]*25* Zj_zhongxinju*YLFDXS*gzm.Ci_xs;  //阻力平均值

                 //缩量
                Old_Ci_L[0] :=(gzm.S_Cg_h+gzm.S_Fm_h)*(gzm.ZCYL_s0+ZJ_hlzyd)/(old.YL_First_step[1]*gzm.Ci_xs);  //缩量最大值
                Old_Ci_L[1] :=(gzm.S_Cg_h+gzm.S_Fm_h)*(gzm.ZCYL_s0+ZJ_hlzyd)/(old.YL_First_step[0]*gzm.Ci_xs);  //缩量最小值
                Old_Ci_L[2] :=(gzm.S_Cg_h+gzm.S_Fm_h)*(gzm.ZCYL_s0+ZJ_hlzyd)/(old.YL_First_step[2]*gzm.Ci_xs);  //缩量平均值


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
                    Old_Ci_F[0] :=Imm_F+ old.YL_max_m*old.YL_First_step[0]*25*Zj_zhongxinju*YLFDXS*gzm.Ci_xs;    //阻力最大值
                    YLFDXS :=Zj_DBFD_xs[9];
                    Old_Ci_F[1] := Imm_F+old.YL_min_m *old.YL_First_step[1]*25* Zj_zhongxinju*YLFDXS*gzm.Ci_xs;  //阻力最小值
                    YLFDXS :=Zj_DBFD_xs[9];
                    Old_Ci_F[2] := Imm_F+old.YL_min_m *old.YL_First_step[2]*25* Zj_zhongxinju*YLFDXS*gzm.Ci_xs;  //阻力平均值

                     //缩量
                    Old_Ci_L[0] :=(gzm.S_Cg_h+gzm.S_Fm_h)*(gzm.ZCYL_s0+ZJ_hlzyd)/(old.YL_First_step[1]*gzm.Ci_xs);  //缩量最大值
                    Old_Ci_L[1] :=(gzm.S_Cg_h+gzm.S_Fm_h)*(gzm.ZCYL_s0+ZJ_hlzyd)/(old.YL_First_step[0]*gzm.Ci_xs);  //缩量最小值
                    Old_Ci_L[2] :=(gzm.S_Cg_h+gzm.S_Fm_h)*(gzm.ZCYL_s0+ZJ_hlzyd)/(old.YL_First_step[2]*gzm.Ci_xs);  //缩量平均值



            end;      //end 3

       end;  //end   if gzm.ZCYL_s0<1    end  1
        //给类里面的压力与压强赋值
        Zj_jisuan_C0_F[0]:=Old_C0_F[0]*zhiJia_F_xs;  //最大
           Zj_jisuan_C0_F[1]:=Old_C0_f[1]*zhiJia_F_xs; // 最小
              Zj_jisuan_C0_F[2]:=Old_C0_f[2]*zhiJia_F_xs;  //平均

        Zj_jisuan_Ci_F[0]:=Old_Ci_F[0]*zhiJia_F_xs;    //最大
            Zj_jisuan_Ci_F[1]:=Old_Ci_f[1]*zhiJia_F_xs;  // 最小
               Zj_jisuan_Ci_F[2]:=Old_Ci_f[2]*zhiJia_F_xs;  //最大  最小 平均

        // 强制修订支架参数  20160506
          self.Revision_ZhiJiaZuli ;

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

procedure TZJ_Class.Draw_zhiJia(Image: TImage; x1, y1, x2, y2, mc_h: double;
  lizhushu, jia_type: integer);
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


end;

function TZJ_Class.DzXd_Cal_sup_para(gzm: TG_Stope; Zk: Tzk_bore;
  imm: TImmediate_roof; old: Told_roof): WideString;
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
      end else if gzm.Dz_yxfx = 2 then begin  // 俯斜
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

procedure TZJ_Class.Having_stress(gzm: TG_Stope; Zk: Tzk_bore;
  mm: TImmediate_roof; old: Told_roof; idefOrStep: string; BeamNumber: integer;
  MaxV, MinV: double);
var
   MaxValue,MinValue:double;
   YLFDXS:double;
begin
    {
       Calculate_weight(Zk:Tzk_bore;old:Told_roof;defOrStep:string;BeamNumber:integer;
                    var maxV,minV :double);

      （1）当有内应力场， 是单岩梁结构，考虑支架的让压作用  在初次来压阶段  系数暂定为 0.25 ，在周期来压阶段 系数暂定为 0.5
                          多岩梁结构，考虑支架的支撑作用  在初次来压阶段  系数暂定为 0.5 ，在周期来压阶段 系数暂定为 0.8
     （2）当无内应力场， 是单岩梁结构，考虑支架的让压作用  在初次来压阶段  系数暂定为 0.4 ，在周期来压阶段 系数暂定为 0.6
                         多岩梁结构，考虑支架的支撑作用  在初次来压阶段  系数暂定为 0.6 ，在周期来压阶段 系数暂定为 1

    }
       //判断内应立场的作用
      if idefOrStep='Def' then   begin
          if old.YL_Dep_struct=1 then   begin   //单岩梁



          end else begin  //  多岩梁结构

          end;

      end else begin

      end;


    //  if old.YL_struc =1 then begin   //   begin  2----单岩梁结构
            //老顶初次来压 //压力
//            YLFDXS :=Zj_DBFD_xs[1];
//            Old_C0_F[0] :=Imm_F+ old.YL_max_m*old.YL_First_step[0]*25*Zj_zhongxinju*YLFDXS;    //阻力最大值
//            YLFDXS :=Zj_DBFD_xs[1];
//            Old_C0_F[1] := Imm_F+old.YL_min_m *old.YL_First_step[1]*25* Zj_zhongxinju*YLFDXS;  //阻力最小值
//            YLFDXS :=Zj_DBFD_xs[1];
//            Old_C0_F[2] := Imm_F+old.YL_min_m *old.YL_First_step[2]*25* Zj_zhongxinju*YLFDXS;  //阻力平均值
//            //缩量
//            Old_C0_L[0] :=(gzm.S_Cg_h+gzm.S_Fm_h)*(gzm.ZCYL_s0+ZJ_hlzyd)/old.YL_First_step[1];  //缩量最大值
//            Old_C0_L[1] :=(gzm.S_Cg_h+gzm.S_Fm_h)*(gzm.ZCYL_s0+ZJ_hlzyd)/old.YL_First_step[0];  //缩量最 小值
//            Old_C0_L[2] :=(gzm.S_Cg_h+gzm.S_Fm_h)*(gzm.ZCYL_s0+ZJ_hlzyd)/old.YL_First_step[2];  //缩量平均值



end;

function TZJ_Class.Init(str: wideString; out sEorr: Widestring): WordBool;
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

function TZJ_Class.ManyBeam_sup(gzm: TG_Stope; Zk: Tzk_bore;
  imm: TImmediate_roof; old: Told_roof): double;
begin

end;

function TZJ_Class.NOHaving_stress(gzm: TG_Stope; Zk: Tzk_bore;
  imm: TImmediate_roof; old: Told_roof): double;
begin

end;

function TZJ_Class.OneBeam_sup(gzm: TG_Stope; Zk: Tzk_bore;
  imm: TImmediate_roof; old: Told_roof): double;
begin

end;

function TZJ_Class.ReadZhijia_XS(gzm: TG_Stope; Zk: Tzk_bore;
  imm: TImmediate_roof; old: Told_roof): WideString;
 var
      pIniFile:     TIniFile;
      i,j:integer;
      in_Zj_DBFD_xs:  array [1..4] of array[1..9] of double;// 保存不同类别的 参数
      ZhijiaXiu_count:integer;
   begin
          if not FileExists(Public_Basic.Get_MyModulePath +'ZhijiaCs_lulei.dll') then   begin
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

          end else begin
                  pIniFile := Tinifile.create(Public_Basic.Get_MyModulePath+'ZhijiaCs_lulei.dll');
                  for I := 1 to 9 do  begin
                     // I
                     if i=5 then   continue;
                     if i<3 then  begin
                         j:=i+2;
                     end else if i<8 then  begin
                         j:=i+3;
                     end else begin
                         j:=i+4;
                     end;
                     in_Zj_DBFD_xs[1][i]:=pIniFile.ReadFloat('I',IntToStr(j),0);
                        // II
                     in_Zj_DBFD_xs[2][i]:=pIniFile.ReadFloat('II',IntToStr(j),0);
                        // III
                     in_Zj_DBFD_xs[3][i]:=pIniFile.ReadFloat('III',IntToStr(j),0);
                        // III
                     in_Zj_DBFD_xs[4][i]:=pIniFile.ReadFloat('IV',IntToStr(j),0);
                  end;
              pIniFile.Free;
          end;
          //  自助检索
           //判断规则：
           if old.Old_leibie<3 then  begin
                ZhijiaXiu_count:=1;
                gzm.Dz_JYHD:=2;
           end else if old.Old_leibie =3 then  begin
                ZhijiaXiu_count:=2;
                gzm.Dz_JYHD:=2;
           end else begin
                ZhijiaXiu_count:=3;
                gzm.Dz_JYHD:=3;
           end;

           if gzm.S_mcsd_h< 200 then  begin
                ZhijiaXiu_count:=4;
                gzm.Dz_JYHD:=1;
           end;


           for I := 1 to 9 do begin
               Zj_DBFD_xs[i]:=in_Zj_DBFD_xs[ZhijiaXiu_count][i];
           end;
end;

function TZJ_Class.Return_zj_Para(Version: WideString): WideString;
  var
         RStr:Widestring;
         i:integer;
     begin
       if Version='1.0'  then begin
           Rstr:='老顶初次来压时:'+#13#10;
           for I := 0 to 2 do  begin    //组合工作阻力 单位KN
              if i=0 then  begin
                 Rstr:=Rstr+ '      阻力最大值:'+FormatFloat('0.0',zj_jisuan_c0_F[i])+'KN，';
                 Rstr:=Rstr+ '强度最大值:'+FormatFloat('0.0',zj_jisuan_c0_P[i])+'MPa;'+#13#10;
              end else if i=1 then  begin
                 Rstr:=Rstr+ '      阻力最小值:'+FormatFloat('0.0',zj_jisuan_c0_F[i])+'KN，';
                 Rstr:=Rstr+ '强度最小值:'+FormatFloat('0.0',zj_jisuan_c0_P[i])+'MPa;'+#13#10;
              end else if i=2 then begin
                 Rstr:=Rstr+ '      阻力建议值'+FormatFloat('0.00',zj_jisuan_c0_F[i])+'KN，';
                 Rstr:=Rstr+ '强度建议值:'+FormatFloat('0.00',zj_jisuan_c0_P[i])+'MPa。'+#13#10;
              end;

           end;


            Rstr:=Rstr+#13+'老顶周期来压时:'+#13#10;;
           for I := 0 to 2 do  begin    //组合工作阻力 单位KN
              if i=0 then  begin
                 Rstr:=Rstr+'      阻力最大值:'+ FormatFloat('0.0',zj_jisuan_ci_F[i])+'KN，';
                 Rstr:=Rstr+'强度最大值:'+FormatFloat('0.0',zj_jisuan_ci_P[i])+'MPa，'+#13#10;;
              end else   if i=1 then  begin
                 Rstr:=Rstr+'      阻力最小值:'+ FormatFloat('0.0',zj_jisuan_ci_F[i])+'KN，';
                 Rstr:=Rstr+'强度最小值:'+FormatFloat('0.0',zj_jisuan_ci_P[i])+'MPa，'+#13#10;;
              end else begin
                 Rstr:=Rstr+'      阻力建议值:'+ FormatFloat('0.00',zj_jisuan_ci_F[i])+'KN，';
                 Rstr:=Rstr+'强度建议值:'+FormatFloat('0.00',zj_jisuan_ci_P[i])+'MPa。'+#13#10;;
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

end;

procedure TZJ_Class.Revision_ZhiJiaZuli;
var
  i:integer;
  MaxSupp,MinSupp,Maxbl,MinBl:Single;
begin
    { 强制修订支架的阻力参数
      修订的原则  支架不能大于 260000KN， 如果大于 将    强制处理
      支架不能小于 8000KN  如果小于 将强制处理
    }
    MaxSupp:=0; MinSupp:=1000000;
    for I := 0 to 2 do begin
       if MaxSupp < self.Zj_JiSuan_C0_F[i]  then  MaxSupp := self.Zj_JiSuan_C0_F[i] ;
       if MaxSupp < self.Zj_JiSuan_Ci_F[i]  then  MaxSupp := self.Zj_JiSuan_Ci_F[i] ;
       if MinSupp > self.Zj_JiSuan_C0_F[i]  then  MinSupp := self.Zj_JiSuan_C0_F[i] ;
       if MinSupp > self.Zj_JiSuan_Ci_F[i]  then  MinSupp := self.Zj_JiSuan_Ci_F[i] ;
    end;
    if MaxSupp > 26000 then begin  Maxbl:= 8000/(MaxSupp-18000) ;
    end else if MaxSupp > 22000 then begin  Maxbl:= 4000/(MaxSupp-18000) ;
    end else if MaxSupp > 20000 then begin  Maxbl:= 2000/(MaxSupp-18000) ;
    end;

    if MinSupp < 4000 then begin     MinBl:= 2000/(6000-MinSupp) ;
    end else if MinSupp < 6000 then begin     MinBl:= 2000/(8000-MinSupp) ;
    end else if MinSupp < 8000 then begin     MinBl:= 2000/(8000-MinSupp) ;
    end;

   for I := 0 to 2 do begin
      if Zj_JiSuan_C0_F[i]> 26000 then  begin
         Zj_JiSuan_C0_F[i]:=18000+(Zj_JiSuan_C0_F[i]-18000)*Maxbl;
      end;
      if Zj_JiSuan_Ci_F[i]> 15000 then  begin
         Zj_JiSuan_Ci_F[i]:=15000+(Zj_JiSuan_Ci_F[i]-15000)*Maxbl;
      end;
      //
      if Zj_JiSuan_C0_F[i]< 10000 then  begin
         Zj_JiSuan_C0_F[i]:=10000-(10000-Zj_JiSuan_C0_F[i])*Minbl;
      end;
      if Zj_JiSuan_Ci_F[i]< 8000 then  begin
         Zj_JiSuan_Ci_F[i]:=8000-(8000-Zj_JiSuan_Ci_F[i])*Minbl;
      end;
  end;


end;

function TZJ_Class.SpliJG(str: widestring; out sEorr: widestring): WordBool;
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

end.

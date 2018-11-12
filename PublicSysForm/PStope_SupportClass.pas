unit PStope_SupportClass;

interface

uses
  Windows, SysUtils, Classes, Messages, Controls, Forms, StdCtrls, ExtCtrls
  ,ComCtrls,math,IniFiles,Jpeg,Graphics,Dialogs,Lu_Public_BasicModual
  ,PStope_WorKFace,PStope_Immediate
   ;
type
 // //����֧����
  TZJ_Class=class
      public
          Zj_Name: WideString;    //֧�ܵ�����
         ZJ_Tu_Bianhao:widestring; //֧��ͼ�����
         Zj_BianHao:WideString;  //֧�ܵı��
         Zj_XingHao:WideString;   //֧�ܵ��ͺ�
         Zj_Lizhu_count: Integer;  //֧����������
         Zj_toall_F:double;       //֧�������迹��
         zj_toall_P:double;       //֧��֧��ǿ��
         Zj_suoliang:double;      //֧���������
         Zj_Max_h:double;         //֧�����߶�
         Zj_min_h:double;         //֧����С�߶�
         Zj_KongdingJU:double;    //֧�ܿض���
         Zj_zhongxinju:double;    //֧�����ľ�
         Zj_hlzyd:double;        //�������õ�
         Zj_hubang_h:double;      //֧�ܻ���߶�
         Zj_hubang_jishu:integer;  //֧�ܻ��Ｖ��
         zj_hubang_F:double;     //֧�ܻ�������
         zj_hubang_P:double;     //֧�ܻ���ǿ��
         Zj_JiSuan_suoliang: double;// ֧�ܼ��������
         Zj_JiSuan_C0_F: array[0..2] of double;// ������ѹʱ֧�ܼ��������  0 ���ֵ 1 ��Сֵ 2 ƽ��ֵ
         Zj_JiSuan_C0_P: array[0..2] of double;// ������ѹʱ֧�ܼ����֧��ǿ��  0 ���ֵ 1 ��Сֵ 2 ƽ��ֵ
         Zj_JiSuan_Ci_F: array[0..2] of double;// ������ѹʱ֧�ܼ��������  0 ���ֵ 1 ��Сֵ 2 ƽ��ֵ
         Zj_JiSuan_Ci_P: array[0..2] of double;// ����ѹʱ֧�ܼ����֧��ǿ��  0 ���ֵ 1 ��Сֵ 2 ƽ��ֵ
         Zj_emp1_Formula:array[0..2] of double;// ���鷽��1 ����֧��ǿ��
         Zj_emp2_Formula:array[0..2] of double;// ���鷽��2 ����֧��ǿ��
         Zj_emp3_Formula:array[0..2] of double;// ���鷽��2 ����֧��ǿ��
         Zj_Jisuan_SL: array[0..2] of double;// ֧�ܼ��������  0 ���ֵ 1 ��Сֵ 2 ƽ��ֵ
         Zj_JiSuan_hubang_H: array[0..5] of double;// ֧�ܼ��㻥��߶�   '(0)Ϊ���л����棬(1)Ϊ��Ħ���Ǽ���,(2)Ϊѹ�˼���,(3)Ϊú���������� ,(4)֧�ܹ���������ʽ����
         Zj_JiSuan_hubang_P: array[0..2] of double;// ֧�ܼ��㻥��ǿ��   0 ���ֵ 1 ��Сֵ 2 ƽ��ֵ
         JG_jx:widestring;     //  ���ͽṹ
         JG_Dl:widestring;     //  �����ṹ
         JG_Dz:widestring;     // �����ṹ
         JG_slg:widestring;     // �����ɽṹ
         JG_ty:widestring;     // ���ƽṹ
         JG_Fm:widestring;     // ��ú�ṹ
         JG_Wl:widestring;     // β���ṹ
         JG_Qc:widestring;     // ǰ����β���໤��
         JG_Ct:widestring;     // ���ƽṹ
         JG_Dt:widestring;     //�׵��ṹ
         JG_Ql:widestring;     //ǰ���ṹ
         ZJ_JianYi_Type:Widestring;  //֧�ܵ�ѡ���ͺ�
         zhiJia_F_xs  :double; // ֧�������޶�ϵ��
         zhijia_L_xs  :double; // ֧�������޶�ϵ��
         zhijia_hb_Q_xs :double;// ֧�ܻ���ǿ���޶�ϵ��
         Zj_DBFD_xs:  array[1..9] of double;// ���治ͬ���� ����
         OcxPath:widestring; //Ocx·��
         Zj_imm_p:double; // ֧��֧��ֱ�Ӷ���ѹǿ
         Zj_old_C0_p:array[0..2] of double;// ������ѹʱ֧�ܼ����֧��ǿ��  0 ���ֵ 1 ��Сֵ 2 ƽ��ֵ
         Zj_old_Ci_p:array[0..2] of double;// ������ѹʱ֧�ܼ����֧��ǿ��  0 ���ֵ 1 ��Сֵ 2 ƽ��ֵ
         Zj_Lz_Diameter:double; //������ֱ��

         function  Init(str:wideString;out sEorr:Widestring):WordBool; //��ʼ��֧��
         procedure Cal_empirical_formula1(gzm:TG_Stope); //����ϵ����
         procedure Cal_empirical_formula2(gzm:TG_Stope); //���ɸ߶ȷ�
         procedure Cal_empirical_formula3(gzm:TG_Stope;imm:TImmediate_roof;old:Told_roof); //���鹫ʽ��
         procedure Cal_sup_Beam_def(gzm:TG_Stope;Zk:Tzk_bore;imm:TImmediate_roof;old:Told_roof); //����������ѹǿ
         procedure Cal_Sup_Beam_step( gzm:TG_Stope;Zk:Tzk_bore;imm:TImmediate_roof;old:Told_roof);//���෨����ѹǿ
         function  OneBeam_sup(gzm:TG_Stope;Zk:Tzk_bore;imm:TImmediate_roof;old:Told_roof):double; // ����������ѹ��
         function  ManyBeam_sup(gzm:TG_Stope;Zk:Tzk_bore;imm:TImmediate_roof;old:Told_roof):double ; // ��������ѹ��
         procedure  Having_stress(gzm: TG_Stope; Zk: Tzk_bore; mm: TImmediate_roof; old: Told_roof;
                                  idefOrStep:string;BeamNumber:integer;MaxV,MinV:double); // ����Ӧ������ѹ��
         function  NOHaving_stress(gzm:TG_Stope;Zk:Tzk_bore;imm:TImmediate_roof;old:Told_roof):double ; // ����Ӧ������ѹ��
         procedure  Calculate_weight(gzm:TG_Stope;Zk:Tzk_bore;old:Told_roof;defOrStep:string;BeamNumber:integer;
                    var maxV,minV :double);

         function  Cal_Sup_Para(gzm:TG_Stope;Zk:Tzk_bore;imm:TImmediate_roof;old:Told_roof):WideString; //����֧�ܲ�sh

         function  DzXd_Cal_sup_para(gzm:TG_Stope;Zk:Tzk_bore;imm:TImmediate_roof;old:Told_roof):WideString; //  ���ݵ��������޶�֧�ܵĻ�������
         function  Return_zj_Para(Version:WideString):WideString;   //����֧�ܲ���
         function  SpliJG(str:widestring;out sEorr:widestring):WordBool; //��ִ���֧�ܽṹ�ַ���
         function  ReadZhijia_XS(gzm:TG_Stope;Zk:Tzk_bore;imm:TImmediate_roof;old:Told_roof):WideString; //����֧�ܲ�sh
         procedure Draw_zhiJia(Image:TImage;x1,y1,x2,y2,mc_h:double;lizhushu,jia_type:integer);// jia_type 1 �۲�  2 �۷�
         procedure Revision_ZhiJiaZuli;// �޶�֧������ �����ֳ������
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
     Q Һѹ֧�ܵ�֧��ǿ�ȣ�h �����濪�ɲɸ�   r������ʯ����   2.5
     D ������ѹ����ϵ��  ci <8 D=1.1; Ci <=15 D =1.3 ;ci<=20 D= 1.5  Ci >=25 D=1.7
     k ������ʯ��������ϵ��    a���������
     B ��������ϵ�� ������ȡ 1.2��������ȡ 1.6
     }
     if self.Zj_Lizhu_count=2 then  fujia_C:=1.2  else   fujia_C:=1.6 ;
     //���ֵ
     self.Zj_emp1_Formula[0]:=gzm.S_Cg_h*25*gzm.dynamic_factor* (fujia_C+0.1);
        self.Zj_emp1_Formula[0]:=self.Zj_emp1_Formula[0]/((1.1-1)*cos(gzm.S_qj/180.0*3.14159));
     //��Сֵ
     self.Zj_emp1_Formula[1]:=gzm.S_Cg_h*23*gzm.dynamic_factor* (fujia_C-0.1);
        self.Zj_emp1_Formula[1]:=self.Zj_emp1_Formula[0]/((1.3-1)*cos(gzm.S_qj/180.0*3.14159));
     //�м�ֵ
     self.Zj_emp1_Formula[2]:=gzm.S_Cg_h*24*gzm.dynamic_factor* (fujia_C);
        self.Zj_emp1_Formula[2]:=self.Zj_emp1_Formula[0]/((1.2-1)*cos(gzm.S_qj/180.0*3.14159));


end;

procedure TZJ_Class.Cal_empirical_formula2(gzm: TG_Stope);
begin
    {
     Q=KHR
     Q Һѹ֧�ܵ�֧��ǿ�ȣ�  r������ʯ����   2.5
     k ������֧���ϵĶ�����ʯϵ��    һ��ȡ 5-8
     h �����濪�ɲɸ�
     }
     //���ֵ
     self.Zj_emp2_Formula[0]:=gzm.S_Cg_h*25*8;
     //��Сֵ
     self.Zj_emp2_Formula[1]:=gzm.S_Cg_h*23*5;
     //�м�ֵ
     self.Zj_emp2_Formula[2]:=gzm.S_Cg_h*24*6.5;
end;

procedure TZJ_Class.Cal_empirical_formula3(gzm: TG_Stope; imm: TImmediate_roof;
  old: Told_roof);
var
   N: double;
begin
    { ʷѧΰ���鹫ʽ
      q=72.3M + 4.5 L2 +78.9 Ls-10.24N-62..1
      M ���ɸ߶�
      L2 �϶���ѹ����
      Ls �ض�����
    }
    N:=imm.Immroof_M/gzm.S_Cg_h;

     //���ֵ
     self.Zj_emp3_Formula[0]:=gzm.S_Cg_h*72.3+old.YL_Zhouqi_step[0]*4.5+78.9*self.Zj_KongdingJU
                  -10.24*N-62.1;
     //��Сֵ
     self.Zj_emp3_Formula[1]:=gzm.S_Cg_h*72.3+old.YL_Zhouqi_step[1]*4.5+78.9*self.Zj_KongdingJU
                  -10.24*N-62.1;
     //�м�ֵ
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
     Imm_F     :double ; //֧��֧��ֱ�Ӷ�����
     Imm_P     :double;  //֧��֧��ֱ�Ӷ���ѹǿ
     Imm_f_z   :double; //ֱ�Ӷ�������ϵ��
     Imm_ls    :double;//ֱ�Ӷ�����������
     Old_C0_F  :array[0..2] of double; // �϶�������ѹʱ֧�ܵ�����  0  ���ֵ 1 ��Сֵ 2 ƽ��ֵ
     Old_Ci_F  :array[0..2] of double;  // �϶�������ѹʱ֧�ܵ�����  0  ���ֵ 1 ��Сֵ 2 ƽ��ֵ
     Old_C0_L  :array[0..2] of double; // �϶�������ѹʱ֧�ܵ�����   0  ���ֵ 1 ��Сֵ 2 ƽ��ֵ
     Old_Ci_L  :array[0..2] of double;  // �϶�������ѹʱ֧�ܵ�����  0  ���ֵ 1 ��Сֵ 2 ƽ��ֵ
     YLFDXS    : double;//��ͬ�ṹ�������ķֵ�ϵ��
     sResult   :WideString;//���ؽ��ֵ
     MBphgd_t  :array[0..5] of Double ;//'(0)Ϊ���л����棬(1)Ϊ��Ħ���Ǽ���,(2)Ϊѹ�˼���,(3)Ϊú���������� ,(4)֧�ܹ���������ʽ����
     ZjGzzu    :double; //������֧�ܵĹ�������
     Q1,Q2,Q3,Q0:double;// ���㻥��ǿ���������Ǳ��� Q1 ֱ�Ӷ����غ� Q2 ǰ��֧��ѹ�����غ� Q3 �϶�ͨ�����������ݵ��غ�  Q0 ú�ڳе��غ�
     i:integer;
   begin
      //����֧�����д���
      if Trim(ZJ_Name)= '����' then   begin
        Exit;
      end;
      //��֤֧���Ƿ񱻳�ʼ��
      if length(Trim(Zj_XingHao))<1 then  begin   //��֤֧���Ƿ񱻳�ʼ��
          ZJ_Zhongxinju:=1.5 ;//��֧�����ľำĬ��ֵ
          ZJ_KongdingJu:=5 ;//��֧�ܿض��ำĬ��ֵ
          ZJ_hlzyd:=3 ;//��֧�ܺ������õ㸳Ĭ��ֵ

      end; //end  length(Trim(Zj_XingHao))>0
       //��ʼ��֧���޶�����
        self.DzXd_Cal_sup_para(gzm,zk,imm,old);
        //��ȡ�ļ�
        self.ReadZhijia_XS(gzm,zk,imm,old);
      //����֧�ܵ�����ϵ��
      if gzm.S_Fm_h> 1 then  begin   //20150506 edit
          Imm_ls:=0;
      end else begin
         if Imm.Immroof_C0*0.3>ZJ_Kongdingju then  begin  //�ж�֧�ܿض�����ֱ�Ӷ����ڿ���Ĺ�ϵ
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
       //����֧��֧��ֱ�Ӷ�����Ҫ����
         //201505060edit
         if gzm.S_Fm_h> 1 then  begin   //20150506 edit
            Imm_P:= Imm.Immroof_M *25 * Imm_f_z/ZJ_KongDingJu*(ZJ_KongDingJu-gzm.S_Fm_h*tan(30/180*3.14159));          //  ֱ�Ӷ���ѹǿ
         end else begin
            Imm_P:= Imm.Immroof_M *25 * Imm_f_z;          //  ֱ�Ӷ���ѹǿ
         end;

         Imm_F:= ZJ_Kongdingju * ZJ_ZhongxinJu *Imm_P ;
         zj_imm_p:=Imm_P/1000;
         {
           2013��12��Ϊ֣��ú�����ƶ�����ϵ��׼��
           ��1��������Ӧ������ �ǵ������ṹ������֧�ܵ���ѹ����  �ڳ�����ѹ�׶�  ϵ���ݶ�Ϊ 0.25 ����������ѹ�׶� ϵ���ݶ�Ϊ 0.5
                                �������ṹ������֧�ܵ�֧������  �ڳ�����ѹ�׶�  ϵ���ݶ�Ϊ 0.5 ����������ѹ�׶� ϵ���ݶ�Ϊ 0.8
           ��2��������Ӧ������ �ǵ������ṹ������֧�ܵ���ѹ����  �ڳ�����ѹ�׶�  ϵ���ݶ�Ϊ 0.4 ����������ѹ�׶� ϵ���ݶ�Ϊ 0.6
                                �������ṹ������֧�ܵ�֧������  �ڳ�����ѹ�׶�  ϵ���ݶ�Ϊ 0.6 ����������ѹ�׶� ϵ���ݶ�Ϊ 1

         }
       //�ж���Ӧ����������

        old.YL_min_m:=Zk.Beam_step[0].Ztc_ms;
        old.YL_max_m:=old.YL_min_m+gzm.S_Cg_h;


       if gzm.ZCYL_s0>1 then   begin        //     1----  ����Ӧ����
         if old.YL_struc =1 then begin   //   begin  2----�������ṹ
            //�϶�������ѹ //ѹ��
            YLFDXS :=Zj_DBFD_xs[1];
            Old_C0_F[0] :=Imm_F+ old.YL_max_m*old.YL_First_step[0]*25*Zj_zhongxinju*YLFDXS;    //�������ֵ
            YLFDXS :=Zj_DBFD_xs[1];
            Old_C0_F[1] := Imm_F+old.YL_min_m *old.YL_First_step[1]*25* Zj_zhongxinju*YLFDXS;  //������Сֵ
            YLFDXS :=Zj_DBFD_xs[1];
            Old_C0_F[2] := Imm_F+old.YL_min_m *old.YL_First_step[2]*25* Zj_zhongxinju*YLFDXS;  //����ƽ��ֵ
            //����
            Old_C0_L[0] :=(gzm.S_Cg_h+gzm.S_Fm_h)*(gzm.ZCYL_s0+ZJ_hlzyd)/old.YL_First_step[1];  //�������ֵ
            Old_C0_L[1] :=(gzm.S_Cg_h+gzm.S_Fm_h)*(gzm.ZCYL_s0+ZJ_hlzyd)/old.YL_First_step[0];  //������ Сֵ
            Old_C0_L[2] :=(gzm.S_Cg_h+gzm.S_Fm_h)*(gzm.ZCYL_s0+ZJ_hlzyd)/old.YL_First_step[2];  //����ƽ��ֵ

            //�϶�������ѹ
            YLFDXS :=Zj_DBFD_xs[2];
            Old_Ci_F[0] :=Imm_F+ old.YL_max_m*old.YL_First_step[0]*25*Zj_zhongxinju*YLFDXS*gzm.Ci_xs;    //�������ֵ
            YLFDXS :=Zj_DBFD_xs[2];
            Old_Ci_F[1] := Imm_F+old.YL_min_m *old.YL_First_step[1]*25* Zj_zhongxinju*YLFDXS*gzm.Ci_xs;  //������Сֵ
            YLFDXS :=Zj_DBFD_xs[2];
            Old_Ci_F[2] := Imm_F+old.YL_min_m *old.YL_First_step[2]*25* Zj_zhongxinju*YLFDXS*gzm.Ci_xs;  //����ƽ��ֵ

             //����
            Old_Ci_L[0] :=(gzm.S_Cg_h+gzm.S_Fm_h)*(gzm.ZCYL_s0+ZJ_hlzyd)/(old.YL_First_step[1]*gzm.Ci_xs);  //�������ֵ
            Old_Ci_L[1] :=(gzm.S_Cg_h+gzm.S_Fm_h)*(gzm.ZCYL_s0+ZJ_hlzyd)/(old.YL_First_step[0]*gzm.Ci_xs);  //������Сֵ
            Old_Ci_L[2] :=(gzm.S_Cg_h+gzm.S_Fm_h)*(gzm.ZCYL_s0+ZJ_hlzyd)/(old.YL_First_step[2]*gzm.Ci_xs);  //����ƽ��ֵ


            end else begin // else 2         //�������ṹ

                  //�϶�������ѹ
                    //ѹ��
                    YLFDXS :=Zj_DBFD_xs[3];
                    Old_C0_F[0] :=Imm_F+ old.YL_max_m*old.YL_First_step[0]*25*Zj_zhongxinju*YLFDXS;    //�������ֵ
                    YLFDXS :=Zj_DBFD_xs[3];
                    Old_C0_F[1] := Imm_F+old.YL_min_m *old.YL_First_step[1]*25* Zj_zhongxinju*YLFDXS;  //������Сֵ
                    YLFDXS :=Zj_DBFD_xs[3];
                    Old_C0_F[2] := Imm_F+old.YL_min_m *old.YL_First_step[2]*25* Zj_zhongxinju*YLFDXS;  //����ƽ��ֵ
                    //����
                    Old_C0_L[0] :=(gzm.S_Cg_h+gzm.S_Fm_h)*(gzm.ZCYL_s0+ZJ_hlzyd)/old.YL_First_step[1];  //�������ֵ
                    Old_C0_L[1] :=(gzm.S_Cg_h+gzm.S_Fm_h)*(gzm.ZCYL_s0+ZJ_hlzyd)/old.YL_First_step[0];  //������ Сֵ
                    Old_C0_L[2] :=(gzm.S_Cg_h+gzm.S_Fm_h)*(gzm.ZCYL_s0+ZJ_hlzyd)/old.YL_First_step[2];  //����ƽ��ֵ

                    //�϶�������ѹ
                    YLFDXS :=Zj_DBFD_xs[4];
                    Old_Ci_F[0] :=Imm_F+ old.YL_max_m*old.YL_First_step[0]*25*Zj_zhongxinju*YLFDXS*gzm.Ci_xs;    //�������ֵ
                    YLFDXS :=Zj_DBFD_xs[4];
                    Old_Ci_F[1] := Imm_F+old.YL_min_m *old.YL_First_step[1]*25* Zj_zhongxinju*YLFDXS*gzm.Ci_xs;  //������Сֵ
                    YLFDXS :=Zj_DBFD_xs[4];
                    Old_Ci_F[2] := Imm_F+old.YL_min_m *old.YL_First_step[2]*25* Zj_zhongxinju*YLFDXS*gzm.Ci_xs;  //����ƽ��ֵ

                     //����
                    Old_Ci_L[0] :=(gzm.S_Cg_h+gzm.S_Fm_h)*(gzm.ZCYL_s0+ZJ_hlzyd)/(old.YL_First_step[1]*gzm.Ci_xs);  //�������ֵ
                    Old_Ci_L[1] :=(gzm.S_Cg_h+gzm.S_Fm_h)*(gzm.ZCYL_s0+ZJ_hlzyd)/(old.YL_First_step[0]*gzm.Ci_xs);  //������Сֵ
                    Old_Ci_L[2] :=(gzm.S_Cg_h+gzm.S_Fm_h)*(gzm.ZCYL_s0+ZJ_hlzyd)/(old.YL_First_step[2]*gzm.Ci_xs);  //����ƽ��ֵ



                end;    //  end 2
       end else begin            //����Ӧ����
               if old.YL_struc =1 then begin   //    �������ṹ    begin  3
                //�϶�������ѹ
                //ѹ��
                YLFDXS :=Zj_DBFD_xs[6];
                Old_C0_F[0] := Imm_F+ old.YL_max_m *old.YL_First_step[0]*25* Zj_zhongxinju*YLFDXS;    //�������ֵ
                YLFDXS :=Zj_DBFD_xs[6];
                Old_C0_F[1] := Imm_F+ old.YL_min_m *old.YL_First_step[1]*25* Zj_zhongxinju*YLFDXS;  //������Сֵ
                YLFDXS :=Zj_DBFD_xs[6];
                Old_C0_F[2] := Imm_F+ old.YL_min_m *old.YL_First_step[2]*25* Zj_zhongxinju*YLFDXS;  //����ƽ��ֵ
                //����
                Old_C0_L[0] :=(gzm.S_Cg_h+gzm.S_Fm_h)*(gzm.ZCYL_s0+ZJ_hlzyd)/old.YL_First_step[1];  //�������ֵ
                Old_C0_L[1] :=(gzm.S_Cg_h+gzm.S_Fm_h)*(gzm.ZCYL_s0+ZJ_hlzyd)/old.YL_First_step[0];  //������ Сֵ
                Old_C0_L[2] :=(gzm.S_Cg_h+gzm.S_Fm_h)*(gzm.ZCYL_s0+ZJ_hlzyd)/old.YL_First_step[2];  //����ƽ��ֵ

                //�϶�������ѹ
                YLFDXS :=Zj_DBFD_xs[7];
                Old_Ci_F[0] :=Imm_F+ old.YL_max_m*old.YL_First_step[0]*25*Zj_zhongxinju*YLFDXS*gzm.Ci_xs;    //�������ֵ
                YLFDXS :=Zj_DBFD_xs[7];
                Old_Ci_F[1] := Imm_F+old.YL_min_m *old.YL_First_step[1]*25* Zj_zhongxinju*YLFDXS*gzm.Ci_xs;  //������Сֵ
                YLFDXS :=Zj_DBFD_xs[7];
                Old_Ci_F[2] := Imm_F+old.YL_min_m *old.YL_First_step[2]*25* Zj_zhongxinju*YLFDXS*gzm.Ci_xs;  //����ƽ��ֵ

                 //����
                Old_Ci_L[0] :=(gzm.S_Cg_h+gzm.S_Fm_h)*(gzm.ZCYL_s0+ZJ_hlzyd)/(old.YL_First_step[1]*gzm.Ci_xs);  //�������ֵ
                Old_Ci_L[1] :=(gzm.S_Cg_h+gzm.S_Fm_h)*(gzm.ZCYL_s0+ZJ_hlzyd)/(old.YL_First_step[0]*gzm.Ci_xs);  //������Сֵ
                Old_Ci_L[2] :=(gzm.S_Cg_h+gzm.S_Fm_h)*(gzm.ZCYL_s0+ZJ_hlzyd)/(old.YL_First_step[2]*gzm.Ci_xs);  //����ƽ��ֵ


               end else begin // //�������ṹ        else 3

                  //�϶�������ѹ
                    //ѹ��
                    YLFDXS :=Zj_DBFD_xs[8];
                    Old_C0_F[0] :=Imm_F+ old.YL_max_m*old.YL_First_step[0]*25*Zj_zhongxinju*YLFDXS;    //�������ֵ
                    YLFDXS :=Zj_DBFD_xs[8];
                    Old_C0_F[1] := Imm_F+old.YL_min_m *old.YL_First_step[1]*25* Zj_zhongxinju*YLFDXS;  //������Сֵ
                    YLFDXS :=Zj_DBFD_xs[8];
                    Old_C0_F[2] := Imm_F+old.YL_min_m *old.YL_First_step[2]*25* Zj_zhongxinju*YLFDXS;  //����ƽ��ֵ
                    //����
                    Old_C0_L[0] :=(gzm.S_Cg_h+gzm.S_Fm_h)*(gzm.ZCYL_s0+ZJ_hlzyd)/old.YL_First_step[1];  //�������ֵ
                    Old_C0_L[1] :=(gzm.S_Cg_h+gzm.S_Fm_h)*(gzm.ZCYL_s0+ZJ_hlzyd)/old.YL_First_step[0];  //������ Сֵ
                    Old_C0_L[2] :=(gzm.S_Cg_h+gzm.S_Fm_h)*(gzm.ZCYL_s0+ZJ_hlzyd)/old.YL_First_step[2];  //����ƽ��ֵ

                //�϶�������ѹ
                    YLFDXS :=Zj_DBFD_xs[9];
                    Old_Ci_F[0] :=Imm_F+ old.YL_max_m*old.YL_First_step[0]*25*Zj_zhongxinju*YLFDXS*gzm.Ci_xs;    //�������ֵ
                    YLFDXS :=Zj_DBFD_xs[9];
                    Old_Ci_F[1] := Imm_F+old.YL_min_m *old.YL_First_step[1]*25* Zj_zhongxinju*YLFDXS*gzm.Ci_xs;  //������Сֵ
                    YLFDXS :=Zj_DBFD_xs[9];
                    Old_Ci_F[2] := Imm_F+old.YL_min_m *old.YL_First_step[2]*25* Zj_zhongxinju*YLFDXS*gzm.Ci_xs;  //����ƽ��ֵ

                     //����
                    Old_Ci_L[0] :=(gzm.S_Cg_h+gzm.S_Fm_h)*(gzm.ZCYL_s0+ZJ_hlzyd)/(old.YL_First_step[1]*gzm.Ci_xs);  //�������ֵ
                    Old_Ci_L[1] :=(gzm.S_Cg_h+gzm.S_Fm_h)*(gzm.ZCYL_s0+ZJ_hlzyd)/(old.YL_First_step[0]*gzm.Ci_xs);  //������Сֵ
                    Old_Ci_L[2] :=(gzm.S_Cg_h+gzm.S_Fm_h)*(gzm.ZCYL_s0+ZJ_hlzyd)/(old.YL_First_step[2]*gzm.Ci_xs);  //����ƽ��ֵ



            end;      //end 3

       end;  //end   if gzm.ZCYL_s0<1    end  1
        //���������ѹ����ѹǿ��ֵ
        Zj_jisuan_C0_F[0]:=Old_C0_F[0]*zhiJia_F_xs;  //���
           Zj_jisuan_C0_F[1]:=Old_C0_f[1]*zhiJia_F_xs; // ��С
              Zj_jisuan_C0_F[2]:=Old_C0_f[2]*zhiJia_F_xs;  //ƽ��

        Zj_jisuan_Ci_F[0]:=Old_Ci_F[0]*zhiJia_F_xs;    //���
            Zj_jisuan_Ci_F[1]:=Old_Ci_f[1]*zhiJia_F_xs;  // ��С
               Zj_jisuan_Ci_F[2]:=Old_Ci_f[2]*zhiJia_F_xs;  //���  ��С ƽ��

        // ǿ���޶�֧�ܲ���  20160506
          self.Revision_ZhiJiaZuli ;

          if  gzm.S_Fm_h>0 then begin
            for I := 0 to 2 do
             begin
                       Zj_jisuan_C0_F[i]:=Zj_jisuan_C0_F[i]*(1-gzm.S_Fm_h/(gzm.S_Fm_h+gzm.S_Cg_h));
                       Zj_jisuan_Ci_F[i]:=Zj_jisuan_Ci_F[i]*(1-gzm.S_Fm_h/(gzm.S_Fm_h+gzm.S_Cg_h));

             end;

         end;

         //===============================20150506
        //֧�ܵ�֧��ǿ�� ����
        Zj_jisuan_C0_p[0]:= Zj_jisuan_C0_F[0]/zj_kongdingju/zj_zhongxinju/1000;
           zj_old_C0_p[0]:= Zj_jisuan_C0_p[0]-zj_imm_p;
        Zj_jisuan_C0_p[1]:= Zj_jisuan_C0_F[1]/zj_kongdingju/zj_zhongxinju/1000;
           zj_old_C0_p[1]:= Zj_jisuan_C0_p[1]-zj_imm_p;
        Zj_jisuan_C0_p[2]:= Zj_jisuan_C0_F[2]/zj_kongdingju/zj_zhongxinju/1000;
           zj_old_C0_p[2]:= Zj_jisuan_C0_p[2]-zj_imm_p;
         //֧�ܵ�֧��ǿ��  ����
        Zj_jisuan_Ci_p[0]:= Zj_jisuan_Ci_F[0]/zj_kongdingju/zj_zhongxinju/1000;
            zj_old_Ci_p[0]:= Zj_jisuan_Ci_p[0]-zj_imm_p;
        Zj_jisuan_Ci_p[1]:= Zj_jisuan_Ci_F[1]/zj_kongdingju/zj_zhongxinju/1000;
            zj_old_Ci_p[1]:= Zj_jisuan_Ci_p[1]-zj_imm_p;
        Zj_jisuan_Ci_p[2]:= Zj_jisuan_Ci_F[2]/zj_kongdingju/zj_zhongxinju/1000;
            zj_old_Ci_p[2]:= Zj_jisuan_Ci_p[2]-zj_imm_p;

        //֧�ܵ�����
        Zj_jisuan_sl[0]:=Old_Ci_L[0]*zhiJia_L_xs;
        Zj_jisuan_sl[1]:=Old_Ci_L[1]*zhiJia_L_xs;
        Zj_jisuan_sl[2]:=Old_Ci_L[2]*zhiJia_L_xs;
       //====================����Ϊ����ú��Ƭ�������
         //(0)Ϊ���л��������
            MBphgd_t[0] := Tan((45 + gzm.S_M_mcj / 2) / 180 * 3.14159) * gzm.ZCYL_s1[0];
         //(1)Ϊ��Ħ���Ǽ���
            MBphgd_t[1] := Tan(gzm.S_M_mcj / 180 * 3.14159) * gzm.ZCYL_s1[0];
         //(2)Ϊѹ�˼���
            MBphgd_t[2] := 0.35 * gzm.S_Cg_h;
         //(3)ú��������������
            MBphgd_t[3] := 2 * gzm.S_M_njl * Tan((45 + gzm.S_M_mcj / 2) / 180 * 3.14159) / 15000;
        // (4) ֧�ܹ���״̬ú��߶ȼ���

            if Zj_toall_F<100 then  begin    //�ô�������ҪΪ��ֹ֧��¼����ֵ̫С�����е��쳣����
                 ZjGzzu:=Zj_jisuan_ci_p[2]; //ʹ��ƽ��ֵ���м���
            end else begin
                 ZjGzzu:=Zj_toall_p;
            end;

            MBphgd_t[4]:= Sqr(gzm.S_M_njl* gzm.S_M_njl * 4 - 2 * ZjGzzu * 1000 * Tan((45 - gzm.S_M_mcj / 2) / 180 * 3.14159));
            if MBphgd_t[1]> gzm.S_Cg_h/2 then MBphgd_t[1]:=0.5*gzm.S_Cg_h;
            if MBphgd_t[4]> gzm.S_Cg_h/2 then MBphgd_t[4]:=0.5*gzm.S_Cg_h;
        //��֧�ܵĻ���߶ȸ�ֵ
           zj_jisuan_hubang_h[0]:=MBphgd_t[0];  //   //(0)Ϊ���л��������
           zj_jisuan_hubang_h[1]:=MBphgd_t[1];  //   //(1)Ϊ��Ħ���Ǽ���
           zj_jisuan_hubang_h[2]:=MBphgd_t[2];       //(2)Ϊѹ�˼���
           zj_jisuan_hubang_h[3]:=MBphgd_t[3];       //(3)ú��������������
           zj_jisuan_hubang_h[4]:=MBphgd_t[4];       // (4) ֧�ܹ���״̬ú��߶ȼ���
       //ú�ڻ���ǿ�ȼ���
           Q1:= Imm_P;
           if(gzm.ZCYL_s1[0]=0) then begin
                  Q2:= gzm.ZCYL_s0 * gzm.ZCYL_s0 / 2 * gzm.S_K_zcfz * gzm.S_Cg_h * 25 ;
           end else begin
                  Q2:= gzm.ZCYL_s0 * gzm.ZCYL_s0 / 2 / gzm.ZCYL_s1[0]   * gzm.S_K_zcfz * gzm.S_Cg_h * 25 ;
           end;


           Q3:= old.YL_max_m*old.YL_First_step[0]*25*Zj_zhongxinju*0.5*0.3;
           Q0:=Q1+Q2+Q3-ZjGzzu*1000*Zj_zhongxinju*zj_kongdingju*cos(70.0/180*3.1415926);
           if Q0<0 then  Q0:=0;      //ǿ�ƴ���
           if Q0>500 then  Q0:=500;  //ǿ�ƴ���

           Zj_jisuan_hubang_p[2]:=(Q0+0.5*gzm.ZCYL_s0*MBphgd_t[2]*15)/1000/MBphgd_t[2]*self.zhijia_hb_Q_xs;
             //Zj_jisuan_hubang_p[2]:=0.12;

end;

procedure TZJ_Class.Draw_zhiJia(Image: TImage; x1, y1, x2, y2, mc_h: double;
  lizhushu, jia_type: integer);
var
    zJ_H,zJ_w :double;
     Points: array[0..3] of TPoint;
     bitmap1:Tbitmap;//����λͼ bitmap1
 begin
  //=====================
   zj_w:=x2-x1;
    zj_h:=y2-y1;

    if jia_type=1  then begin    //�۲�֧��
        //������    �۲�֧��
        Image.Canvas.Pen.Width :=1;
        Image.Canvas.Pen.Color :=$000000;
        Image.Canvas.MoveTo(trunc(x1+zj_w/60*27),trunc(y2));
        Image.Canvas.LineTo(trunc(x2-zj_w/60*3),trunc(y2));
        Image.Canvas.LineTo(trunc(x2-zj_w/60*3),trunc(y2-zj_H/60*6)) ;
        Image.Canvas.LineTo(trunc(x2-zj_w/60*13),trunc(y2-zj_H/60*12)) ;
        Image.Canvas.LineTo(trunc(x2-zj_w/60*20),trunc(y2-zj_H/60*8)) ;
        Image.Canvas.LineTo(trunc(x1+zj_w/60*27),trunc(y2-zj_H/60*8)) ;
        Image.Canvas.LineTo(trunc(x1+zj_w/60*27),trunc(y2));
        //������֧��  �۲�֧��
        Image.Canvas.Pen.Width :=1;
        Image.Canvas.MoveTo(trunc(x2-zj_w/60*3),trunc(y2-zj_H/60*6)) ;
        Image.Canvas.LineTo(trunc(x2-zj_w/60*1),trunc(y2-zj_H/60*20)) ;
        Image.Canvas.LineTo(trunc(x2-zj_w/60*2),trunc(y2-zj_H/60*20)) ;
        Image.Canvas.LineTo(trunc(x2-zj_w/60*4),trunc(y2-zj_H/60*6)) ;

        Image.Canvas.MoveTo(trunc(x2-zj_w/60*13),trunc(y2-zj_H/60*12)) ;
        Image.Canvas.LineTo(trunc(x2-zj_w/60*6),trunc(y2-zj_H/60*30)) ;
        Image.Canvas.LineTo(trunc(x2-zj_w/60*5),trunc(y2-zj_H/60*28)) ;
        Image.Canvas.LineTo(trunc(x2-zj_w/60*12),trunc(y2-zj_H/60*11)) ;
        //������   �۲�֧��
        Image.Canvas.MoveTo(trunc(x2),trunc(y2-zj_H/60*20)) ;
        Image.Canvas.LineTo(trunc(x2-zj_w/60*13),trunc(y2-zj_H/60*58)) ;
        Image.Canvas.LineTo(trunc(x2-zj_w/60*15),trunc(y2-zj_H/60*56)) ;
        Image.Canvas.LineTo(trunc(x2-zj_w/60*2),trunc(y2-zj_H/60*18)) ;
        Image.Canvas.LineTo(trunc(x2),trunc(y2-zj_H/60*20)) ;
        ////������   �۲�֧��
        Image.Canvas.MoveTo(trunc(x2-zj_w/60*12),trunc(y1)) ;
        Image.Canvas.LineTo(trunc(x2-zj_w/60*12),trunc(y1+zj_H/60*6)) ;
        Image.Canvas.LineTo(trunc(x2-zj_w/60*50),trunc(y1+zj_H/60*6)) ;
        Image.Canvas.LineTo(trunc(x2-zj_w/60*50),trunc(y1)) ;
        Image.Canvas.LineTo(trunc(x2-zj_w/60*12),trunc(y1)) ;

        if mc_h>2.5 then  begin
             //������  �۲�֧��
            Image.Canvas.MoveTo(trunc(x2-zj_w/60*50),trunc(y1+zj_H/30*1)) ;
            Image.Canvas.LineTo(trunc(x2-zj_w/60*51),trunc(y1)) ;
            Image.Canvas.LineTo(trunc(x2-zj_w/60*58),trunc(y1)) ;
            Image.Canvas.LineTo(trunc(x2-zj_w/60*58),trunc(y1+zj_H/30*2)) ;
            Image.Canvas.LineTo(trunc(x2-zj_w/60*50),trunc(y1+zj_H/30*2)) ;
            // //����  �۲�֧��
            Image.Canvas.MoveTo(trunc(x2-zj_w/60*58),trunc(y1)) ;
            Image.Canvas.LineTo(trunc(x1),trunc(y1+zj_H/30*13)) ;
            Image.Canvas.LineTo(trunc(x1+zj_w/60*1),trunc(y1+zj_H/30*13)) ;
            Image.Canvas.LineTo(trunc(x2-zj_w/60*57),trunc(y1+zj_H/30*2)) ;

        end else begin
             //������  �۲�֧��
            Image.Canvas.MoveTo(trunc(x2-zj_w/60*50),trunc(y1+zj_H/30*1)) ;
            Image.Canvas.LineTo(trunc(x2-zj_w/60*51),trunc(y1)) ;
            Image.Canvas.LineTo(trunc(x1),trunc(y1)) ;
            Image.Canvas.LineTo(trunc(x1),trunc(y1+zj_H/30*2)) ;
            Image.Canvas.LineTo(trunc(x2-zj_w/60*50),trunc(y1+zj_H/30*2)) ;
        end;
         //����  �۲�֧��
        if lizhushu=2 then  begin  // ������   �۲�֧��
           if mc_h>=4.0 then  begin  // ˫����  �۲�֧��
                 // ����Ͳ  �۲�֧��
                 Points[0].X:=trunc(x2-zj_w/60*23);                  Points[0].Y:=trunc(y2-zj_H/60*8);
                 Points[1].X:=trunc(x2-zj_w/60*27);                  Points[1].Y:=trunc(y2-zj_H/60*28);
                 Points[2].X:=trunc(x2-zj_w/60*31);                  Points[2].Y:=trunc(y2-zj_H/60*28);
                 Points[3].X:=trunc(x2-zj_w/60*27);                  Points[3].Y:=trunc(y2-zj_H/60*8);
                 Image.canvas.Brush.Color:=$000000;
                 Image.canvas.Polygon(points);

                  // ����Ͳ  �۲�֧��
                 Points[0].X:=trunc(x2-zj_w/60*27.5);                  Points[0].Y:=trunc(y2-zj_H/60*28);
                 Points[1].X:=trunc(x2-zj_w/60*31.5);                  Points[1].Y:=trunc(y2-zj_H/60*46);
                 Points[2].X:=trunc(x2-zj_w/60*34.5);                  Points[2].Y:=trunc(y2-zj_H/60*46);
                 Points[3].X:=trunc(x2-zj_w/60*30.5);                  Points[3].Y:=trunc(y2-zj_H/60*28);
                 Image.canvas.Brush.Color:=$008000;
                 Image.canvas.Polygon(points);

                   // ����Ͳ  �۲�֧��
                 Points[0].X:=trunc(x2-zj_w/60*32);                  Points[0].Y:=trunc(y2-zj_H/60*46);
                 Points[1].X:=trunc(x2-zj_w/60*34);                  Points[1].Y:=trunc(y2-zj_H/60*54);
                 Points[2].X:=trunc(x2-zj_w/60*36);                  Points[2].Y:=trunc(y2-zj_H/60*54);
                 Points[3].X:=trunc(x2-zj_w/60*34);                  Points[3].Y:=trunc(y2-zj_H/60*46);
                 Image.canvas.Brush.Color:=$0000FF;
                 Image.canvas.Polygon(points);

            end else begin  // // ������   �۲�֧��
                 Points[0].X:=trunc(x2-zj_w/60*23);                  Points[0].Y:=trunc(y2-zj_H/60*8);
                 Points[1].X:=trunc(x2-zj_w/60*27);                  Points[1].Y:=trunc(y2-zj_H/60*35);
                 Points[2].X:=trunc(x2-zj_w/60*31);                  Points[2].Y:=trunc(y2-zj_H/60*35);
                 Points[3].X:=trunc(x2-zj_w/60*27);                  Points[3].Y:=trunc(y2-zj_H/60*8);
                 Image.canvas.Brush.Color:=$008000;
                 Image.canvas.Polygon(points);

                   // ����Ͳ    �۲�֧��
                 Points[0].X:=trunc(x2-zj_w/60*28);       Points[0].Y:=trunc(y2-zj_H/60*35);
                 Points[1].X:=trunc(x2-zj_w/60*31);       Points[1].Y:=trunc(y2-zj_H/60*54);
                 Points[2].X:=trunc(x2-zj_w/60*33);       Points[2].Y:=trunc(y2-zj_H/60*54);
                 Points[3].X:=trunc(x2-zj_w/60*30);       Points[3].Y:=trunc(y2-zj_H/60*35);
                 Image.canvas.Brush.Color:=$0000FF;
                 Image.canvas.Polygon(points);

            end;    //end  if zj_h> 40 then  begin  // ˫����  �۲�֧��

        end else begin   // ������  �۲�֧��
               if mc_h>=4.0 then  begin  // ˫����  �۲�֧��
                 // ��������Ͳ �۲�֧��
                 Points[0].X:=trunc(x2-zj_w/60*14);                  Points[0].Y:=trunc(y2-zj_H/60*9);
                 Points[1].X:=trunc(x2-zj_w/60*14);                  Points[1].Y:=trunc(y2-zj_H/60*28);
                 Points[2].X:=trunc(x2-zj_w/60*18);                  Points[2].Y:=trunc(y2-zj_H/60*28);
                 Points[3].X:=trunc(x2-zj_w/60*18);                  Points[3].Y:=trunc(y2-zj_H/60*9);
                 Image.canvas.Brush.Color:=$000000;
                 Image.canvas.Polygon(points);

                  // ����������Ͳ  �۲�֧��
                 Points[0].X:=trunc(x2-zj_w/60*14.5);                  Points[0].Y:=trunc(y2-zj_H/60*28);
                 Points[1].X:=trunc(x2-zj_w/60*14.5);                  Points[1].Y:=trunc(y2-zj_H/60*46);
                 Points[2].X:=trunc(x2-zj_w/60*17.5);                  Points[2].Y:=trunc(y2-zj_H/60*46);
                 Points[3].X:=trunc(x2-zj_w/60*17.5);                  Points[3].Y:=trunc(y2-zj_H/60*28);
                 Image.canvas.Brush.Color:=$008000;
                 Image.canvas.Polygon(points);

                   // ����������Ͳ �۲�֧��
                 Points[0].X:=trunc(x2-zj_w/60*15);                  Points[0].Y:=trunc(y2-zj_H/60*46);
                 Points[1].X:=trunc(x2-zj_w/60*15);                  Points[1].Y:=trunc(y2-zj_H/60*54);
                 Points[2].X:=trunc(x2-zj_w/60*17);                  Points[2].Y:=trunc(y2-zj_H/60*54);
                 Points[3].X:=trunc(x2-zj_w/60*17);                  Points[3].Y:=trunc(y2-zj_H/60*46);
                 Image.canvas.Brush.Color:=$0000FF;
                 Image.canvas.Polygon(points);
                 // ǰ������Ͳ  �۲�֧��
                 Points[0].X:=trunc(x2-zj_w/60*26);                  Points[0].Y:=trunc(y2-zj_H/60*8);
                 Points[1].X:=trunc(x2-zj_w/60*29);                  Points[1].Y:=trunc(y2-zj_H/60*28);
                 Points[2].X:=trunc(x2-zj_w/60*33);                  Points[2].Y:=trunc(y2-zj_H/60*28);
                 Points[3].X:=trunc(x2-zj_w/60*30);                  Points[3].Y:=trunc(y2-zj_H/60*8);
                 Image.canvas.Brush.Color:=$000000;
                 Image.canvas.Polygon(points);

                  // ǰ������Ͳ   �۲�֧��
                 Points[0].X:=trunc(x2-zj_w/60*29.5);                  Points[0].Y:=trunc(y2-zj_H/60*28);
                 Points[1].X:=trunc(x2-zj_w/60*32);                  Points[1].Y:=trunc(y2-zj_H/60*46);
                 Points[2].X:=trunc(x2-zj_w/60*35);                  Points[2].Y:=trunc(y2-zj_H/60*46);
                 Points[3].X:=trunc(x2-zj_w/60*32.5);                  Points[3].Y:=trunc(y2-zj_H/60*28);
                 Image.canvas.Brush.Color:=$008000;
                 Image.canvas.Polygon(points);

                   // ǰ������Ͳ �۲�֧��
                 Points[0].X:=trunc(x2-zj_w/60*32.5);                  Points[0].Y:=trunc(y2-zj_H/60*46);
                 Points[1].X:=trunc(x2-zj_w/60*34);                  Points[1].Y:=trunc(y2-zj_H/60*54);
                 Points[2].X:=trunc(x2-zj_w/60*36);                  Points[2].Y:=trunc(y2-zj_H/60*54);
                 Points[3].X:=trunc(x2-zj_w/60*34.5);                  Points[3].Y:=trunc(y2-zj_H/60*46);
                 Image.canvas.Brush.Color:=$0000FF;
                 Image.canvas.Polygon(points);

            end else begin  // // ������  �۲�֧��
                 // ���� ����Ͳ   �۲�֧��
                 Points[0].X:=trunc(x2-zj_w/60*14);                  Points[0].Y:=trunc(y2-zj_H/60*8);
                 Points[1].X:=trunc(x2-zj_w/60*14);                  Points[1].Y:=trunc(y2-zj_H/60*35);
                 Points[2].X:=trunc(x2-zj_w/60*18);                  Points[2].Y:=trunc(y2-zj_H/60*35);
                 Points[3].X:=trunc(x2-zj_w/60*18);                  Points[3].Y:=trunc(y2-zj_H/60*8);
                 Image.canvas.Brush.Color:=$008000;
                 Image.canvas.Polygon(points);

                   // ���� ����Ͳ  �۲�֧��
                 Points[0].X:=trunc(x2-zj_w/60*15);       Points[0].Y:=trunc(y2-zj_H/60*35);
                 Points[1].X:=trunc(x2-zj_w/60*15);       Points[1].Y:=trunc(y2-zj_H/60*54);
                 Points[2].X:=trunc(x2-zj_w/60*17);       Points[2].Y:=trunc(y2-zj_H/60*54);
                 Points[3].X:=trunc(x2-zj_w/60*17);       Points[3].Y:=trunc(y2-zj_H/60*35);
                 Image.canvas.Brush.Color:=$0000FF;
                 Image.canvas.Polygon(points);
                  // ǰ������Ͳ   �۲�֧��
                 Points[0].X:=trunc(x2-zj_w/60*26);                  Points[0].Y:=trunc(y2-zj_H/60*8);
                 Points[1].X:=trunc(x2-zj_w/60*29);                  Points[1].Y:=trunc(y2-zj_H/60*35);
                 Points[2].X:=trunc(x2-zj_w/60*33);                  Points[2].Y:=trunc(y2-zj_H/60*35);
                 Points[3].X:=trunc(x2-zj_w/60*30);                  Points[3].Y:=trunc(y2-zj_H/60*8);
                  Image.canvas.Brush.Color:=$008000;
                 Image.canvas.Polygon(points);

                    // ǰ������Ͳ �۲�֧��
                 Points[0].X:=trunc(x2-zj_w/60*30);                  Points[0].Y:=trunc(y2-zj_H/60*35);
                 Points[1].X:=trunc(x2-zj_w/60*32);                  Points[1].Y:=trunc(y2-zj_H/60*54);
                 Points[2].X:=trunc(x2-zj_w/60*34);                  Points[2].Y:=trunc(y2-zj_H/60*54);
                 Points[3].X:=trunc(x2-zj_w/60*32);                  Points[3].Y:=trunc(y2-zj_H/60*35);
                 Image.canvas.Brush.Color:=$0000FF;
                 Image.canvas.Polygon(points);

            end;    //end  if zj_h> 40 then  begin  // ˫����
        end;  //end ������Ŀ
        //��������ʯ   �۲�֧��
        //�϶�        �۲�֧��
         {  Points[0].X:=trunc(x2-zj_w/60*8);                  Points[0].Y:=trunc(y1);
           Points[1].X:=trunc(x2-zj_w/60*10);                 Points[1].Y:=trunc(y2-zj_H/60*50);
           Points[2].X:=trunc(x2);                            Points[2].Y:=trunc(y2-zj_H/60*20);
           Points[3].X:=trunc(x2);                            Points[3].Y:=trunc(y1);
           Image.Canvas.Brush.Bitmap:=nil;
           Image.Canvas.Polygon(Points) ;
           bitmap1:=Tbitmap.Create;//����λͼ bitmap1
          // if  fileexists(dll_Path+'\BmpSi\��ʯ.Bmp') then  begin
          //            bitmap1.LoadFromFile(dll_Path+'\BmpFZ\��ʯ.Bmp');//װ��ͼ���ļ�
           bitmap1.LoadFromFile('C:\��ʯ.Bmp');//װ��ͼ���ļ�
           Image.Canvas.Brush.Bitmap:=bitmap1;
           Image.Canvas.FloodFill( Points[0].X+3,Points[0].Y+1,$000000,fsBorder);
           Image.Canvas.Brush.Bitmap:=nil;
            //�¶�   �۲�֧��
           Points[0].X:=Points[2].X;                         Points[0].Y:=Points[2].Y;
           Points[1].X:=trunc(x2-zj_w/60*3);                 Points[1].Y:=trunc(y2-zj_H/60*6);
           Points[2].X:=trunc(x2-zj_w/60*3);                 Points[2].Y:=trunc(y2);
           Points[3].X:=trunc(x2);                           Points[3].Y:=trunc(y2);
           Image.Canvas.Polygon(Points) ;
           bitmap1:=Tbitmap.Create;//����λͼ bitmap1
           bitmap1.LoadFromFile(dll_Path+'\BmpSi\��ʯ.Bmp');//װ��ͼ���ļ�

           Image.Canvas.Brush.Bitmap:=bitmap1;
           Image.Canvas.FloodFill( Points[2].X+1,Points[2].Y-1,$000000,fsBorder);
           Image.Canvas.Brush.Bitmap:=nil;
           bitmap1.free;
         }
           //���ΰ����ͻ�
            Image.Canvas.MoveTo(trunc(x2-zj_w/60*40),trunc(y2));
            Image.Canvas.LineTo(trunc(x2-zj_w/60*52),trunc(y2));
            Image.Canvas.LineTo(trunc(x2-zj_w/60*52),trunc(y2-zj_H/60*3));
            Image.Canvas.LineTo(trunc(x2-zj_w/60*51),trunc(y2-zj_H/60*3));
            Image.Canvas.LineTo(trunc(x2-zj_w/60*51),trunc(y2-zj_H/60*1));
            Image.Canvas.LineTo(trunc(x2-zj_w/60*41),trunc(y2-zj_H/60*1));
            Image.Canvas.LineTo(trunc(x2-zj_w/60*41),trunc(y2-zj_H/60*3));
            Image.Canvas.LineTo(trunc(x2-zj_w/60*40),trunc(y2-zj_H/60*3));
            Image.Canvas.LineTo(trunc(x2-zj_w/60*40),trunc(y2));
    end else begin     //�۷�
          //������   //�۷�
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
        //������֧��   //�۷�
        Image.Canvas.Pen.Width :=1;
        Image.Canvas.MoveTo(trunc(x2-zj_w/60*16),trunc(y2-zj_H/60*9)) ;
        Image.Canvas.LineTo(trunc(x2-zj_w/60*11),trunc(y2-zj_H/60*25)) ;
        Image.Canvas.LineTo(trunc(x2-zj_w/60*12),trunc(y2-zj_H/60*25)) ;
        Image.Canvas.LineTo(trunc(x2-zj_w/60*17),trunc(y2-zj_H/60*9)) ;

        Image.Canvas.MoveTo(trunc(x2-zj_w/60*21),trunc(y2-zj_H/60*11)) ;
        Image.Canvas.LineTo(trunc(x2-zj_w/60*16),trunc(y2-zj_H/60*35)) ;
        Image.Canvas.LineTo(trunc(x2-zj_w/60*17),trunc(y2-zj_H/60*35)) ;
        Image.Canvas.LineTo(trunc(x2-zj_w/60*22),trunc(y2-zj_H/60*12)) ;
        //������   //�۷�
        Image.Canvas.MoveTo(trunc(x2-zj_w/60*9),trunc(y2-zj_H/60*25)) ;
        Image.Canvas.LineTo(trunc(x2-zj_w/60*23),trunc(y2-zj_H/60*58)) ;
        Image.Canvas.LineTo(trunc(x2-zj_w/60*25),trunc(y2-zj_H/60*56)) ;
        Image.Canvas.LineTo(trunc(x2-zj_w/60*11),trunc(y2-zj_H/60*23)) ;
        Image.Canvas.LineTo(trunc(x2-zj_w/60*9),trunc(y2-zj_H/60*25)) ;
        //��β��   //�۷�
        Image.Canvas.MoveTo(trunc(x2-zj_w/60*9),trunc(y2-zj_H/60*25)) ;
       // Image.Canvas.MoveTo(trunc(x2-zj_w/60*9),trunc(y2-zj_H/60*19)) ;
        Image.Canvas.LineTo(trunc(x2-zj_w/60*0),trunc(y2-zj_H/60*4)) ;
        Image.Canvas.LineTo(trunc(x2-zj_w/60*0),trunc(y2-zj_H/60*2)) ;
        Image.Canvas.LineTo(trunc(x2-zj_w/60*11),trunc(y2-zj_H/60*25)) ;
       ////������   //�۷�
        Image.Canvas.MoveTo(trunc(x2-zj_w/60*22),trunc(y1)) ;
        Image.Canvas.LineTo(trunc(x2-zj_w/60*22),trunc(y1+zj_H/60*6)) ;
        Image.Canvas.LineTo(trunc(x2-zj_w/60*50),trunc(y1+zj_H/60*6)) ;
        Image.Canvas.LineTo(trunc(x2-zj_w/60*50),trunc(y1)) ;
        Image.Canvas.LineTo(trunc(x2-zj_w/60*22),trunc(y1)) ;
         if mc_h>2.5 then  begin
             //������  //�۷�
            Image.Canvas.MoveTo(trunc(x2-zj_w/60*50),trunc(y1+zj_H/30*1)) ;
            Image.Canvas.LineTo(trunc(x2-zj_w/60*51),trunc(y1)) ;
            Image.Canvas.LineTo(trunc(x2-zj_w/60*58),trunc(y1)) ;
            Image.Canvas.LineTo(trunc(x2-zj_w/60*58),trunc(y1+zj_H/30*2)) ;
            Image.Canvas.LineTo(trunc(x2-zj_w/60*50),trunc(y1+zj_H/30*2)) ;
            // //����   //�۷�
            Image.Canvas.MoveTo(trunc(x2-zj_w/60*58),trunc(y1)) ;
            Image.Canvas.LineTo(trunc(x1),trunc(y1+zj_H/30*13)) ;
            Image.Canvas.LineTo(trunc(x1+zj_w/60*1),trunc(y1+zj_H/30*13)) ;
            Image.Canvas.LineTo(trunc(x2-zj_w/60*57),trunc(y1+zj_H/30*2)) ;

        end else begin
             //������   //�۷�
            Image.Canvas.MoveTo(trunc(x2-zj_w/60*50),trunc(y1+zj_H/30*1)) ;
            Image.Canvas.LineTo(trunc(x2-zj_w/60*51),trunc(y1)) ;
            Image.Canvas.LineTo(trunc(x1),trunc(y1)) ;
            Image.Canvas.LineTo(trunc(x1),trunc(y1+zj_H/30*2)) ;
            Image.Canvas.LineTo(trunc(x2-zj_w/60*50),trunc(y1+zj_H/30*2)) ;
        end;


         //����   //�۷�
        if lizhushu=2 then  begin  // ������   //�۷�
           if mc_h>=4.0 then  begin  // ˫����  //�۷�
                 // ����Ͳ  //�۷�
                 Points[0].X:=trunc(x2-zj_w/60*29);                  Points[0].Y:=trunc(y2-zj_H/60*8);
                 Points[1].X:=trunc(x2-zj_w/60*33);                  Points[1].Y:=trunc(y2-zj_H/60*28);
                 Points[2].X:=trunc(x2-zj_w/60*37);                  Points[2].Y:=trunc(y2-zj_H/60*28);
                 Points[3].X:=trunc(x2-zj_w/60*33);                  Points[3].Y:=trunc(y2-zj_H/60*8);
                 Image.canvas.Brush.Color:=$000000;
                 Image.canvas.Polygon(points);

                  // ����Ͳ //�۷�
                 Points[0].X:=trunc(x2-zj_w/60*33.5);                  Points[0].Y:=trunc(y2-zj_H/60*28);
                 Points[1].X:=trunc(x2-zj_w/60*37.5);                  Points[1].Y:=trunc(y2-zj_H/60*46);
                 Points[2].X:=trunc(x2-zj_w/60*40.5);                  Points[2].Y:=trunc(y2-zj_H/60*46);
                 Points[3].X:=trunc(x2-zj_w/60*36.5);                  Points[3].Y:=trunc(y2-zj_H/60*28);
                 Image.canvas.Brush.Color:=$008000;
                 Image.canvas.Polygon(points);

                   // ����Ͳ   //�۷�
                 Points[0].X:=trunc(x2-zj_w/60*38);                  Points[0].Y:=trunc(y2-zj_H/60*46);
                 Points[1].X:=trunc(x2-zj_w/60*40);                  Points[1].Y:=trunc(y2-zj_H/60*54);
                 Points[2].X:=trunc(x2-zj_w/60*42);                  Points[2].Y:=trunc(y2-zj_H/60*54);
                 Points[3].X:=trunc(x2-zj_w/60*40);                  Points[3].Y:=trunc(y2-zj_H/60*46);
                 Image.canvas.Brush.Color:=$0000FF;
                 Image.canvas.Polygon(points);

            end else begin  // // ������  //�۷�
                 Points[0].X:=trunc(x2-zj_w/60*29);                  Points[0].Y:=trunc(y2-zj_H/60*8);
                 Points[1].X:=trunc(x2-zj_w/60*33);                  Points[1].Y:=trunc(y2-zj_H/60*35);
                 Points[2].X:=trunc(x2-zj_w/60*37);                  Points[2].Y:=trunc(y2-zj_H/60*35);
                 Points[3].X:=trunc(x2-zj_w/60*33);                  Points[3].Y:=trunc(y2-zj_H/60*8);
                 Image.canvas.Brush.Color:=$008000;
                 Image.canvas.Polygon(points);

                   // ����Ͳ  //�۷�
                 Points[0].X:=trunc(x2-zj_w/60*34);       Points[0].Y:=trunc(y2-zj_H/60*35);
                 Points[1].X:=trunc(x2-zj_w/60*37);       Points[1].Y:=trunc(y2-zj_H/60*54);
                 Points[2].X:=trunc(x2-zj_w/60*39);       Points[2].Y:=trunc(y2-zj_H/60*54);
                 Points[3].X:=trunc(x2-zj_w/60*36);       Points[3].Y:=trunc(y2-zj_H/60*35);
                 Image.canvas.Brush.Color:=$0000FF;
                 Image.canvas.Polygon(points);

            end;    //end  if zj_h> 40 then  begin  // ˫���� //�۷�

        end else begin   // ������  //�۷�
               if mc_h>=4.0 then  begin  // ˫����    //�۷�
                 // ��������Ͳ  //�۷�
                 Points[0].X:=trunc(x2-zj_w/60*24);                  Points[0].Y:=trunc(y2-zj_H/60*8);
                 Points[1].X:=trunc(x2-zj_w/60*24);                  Points[1].Y:=trunc(y2-zj_H/60*28);
                 Points[2].X:=trunc(x2-zj_w/60*28);                  Points[2].Y:=trunc(y2-zj_H/60*28);
                 Points[3].X:=trunc(x2-zj_w/60*28);                  Points[3].Y:=trunc(y2-zj_H/60*8);
                 Image.canvas.Brush.Color:=$000000;
                 Image.canvas.Polygon(points);

                  // ����������Ͳ   //�۷�
                 Points[0].X:=trunc(x2-zj_w/60*24.5);                  Points[0].Y:=trunc(y2-zj_H/60*28);
                 Points[1].X:=trunc(x2-zj_w/60*24.5);                  Points[1].Y:=trunc(y2-zj_H/60*46);
                 Points[2].X:=trunc(x2-zj_w/60*27.5);                  Points[2].Y:=trunc(y2-zj_H/60*46);
                 Points[3].X:=trunc(x2-zj_w/60*27.5);                  Points[3].Y:=trunc(y2-zj_H/60*28);
                 Image.canvas.Brush.Color:=$008000;
                 Image.canvas.Polygon(points);

                   // ����������Ͳ   //�۷�
                 Points[0].X:=trunc(x2-zj_w/60*25);                  Points[0].Y:=trunc(y2-zj_H/60*46);
                 Points[1].X:=trunc(x2-zj_w/60*25);                  Points[1].Y:=trunc(y2-zj_H/60*54);
                 Points[2].X:=trunc(x2-zj_w/60*27);                  Points[2].Y:=trunc(y2-zj_H/60*54);
                 Points[3].X:=trunc(x2-zj_w/60*27);                  Points[3].Y:=trunc(y2-zj_H/60*46);
                 Image.canvas.Brush.Color:=$0000FF;
                 Image.canvas.Polygon(points);
                 // ǰ������Ͳ  //�۷�
                 Points[0].X:=trunc(x2-zj_w/60*34);                  Points[0].Y:=trunc(y2-zj_H/60*8);
                 Points[1].X:=trunc(x2-zj_w/60*37);                  Points[1].Y:=trunc(y2-zj_H/60*28);
                 Points[2].X:=trunc(x2-zj_w/60*41);                  Points[2].Y:=trunc(y2-zj_H/60*28);
                 Points[3].X:=trunc(x2-zj_w/60*38);                  Points[3].Y:=trunc(y2-zj_H/60*8);
                 Image.canvas.Brush.Color:=$000000;
                 Image.canvas.Polygon(points);

                  // ǰ������Ͳ   //�۷�
                 Points[0].X:=trunc(x2-zj_w/60*37.5);                  Points[0].Y:=trunc(y2-zj_H/60*28);
                 Points[1].X:=trunc(x2-zj_w/60*40);                  Points[1].Y:=trunc(y2-zj_H/60*46);
                 Points[2].X:=trunc(x2-zj_w/60*43);                  Points[2].Y:=trunc(y2-zj_H/60*46);
                 Points[3].X:=trunc(x2-zj_w/60*40.5);                  Points[3].Y:=trunc(y2-zj_H/60*28);
                 Image.canvas.Brush.Color:=$008000;
                 Image.canvas.Polygon(points);

                   // ǰ������Ͳ  //�۷�
                 Points[0].X:=trunc(x2-zj_w/60*40.5);                  Points[0].Y:=trunc(y2-zj_H/60*46);
                 Points[1].X:=trunc(x2-zj_w/60*42);                  Points[1].Y:=trunc(y2-zj_H/60*54);
                 Points[2].X:=trunc(x2-zj_w/60*44);                  Points[2].Y:=trunc(y2-zj_H/60*54);
                 Points[3].X:=trunc(x2-zj_w/60*42.5);                  Points[3].Y:=trunc(y2-zj_H/60*46);
                 Image.canvas.Brush.Color:=$0000FF;
                 Image.canvas.Polygon(points);

            end else begin  // // ������ //�۷�
                 // ���� ����Ͳ //�۷�
                 Points[0].X:=trunc(x2-zj_w/60*24);                  Points[0].Y:=trunc(y2-zj_H/60*8);
                 Points[1].X:=trunc(x2-zj_w/60*24);                  Points[1].Y:=trunc(y2-zj_H/60*35);
                 Points[2].X:=trunc(x2-zj_w/60*28);                  Points[2].Y:=trunc(y2-zj_H/60*35);
                 Points[3].X:=trunc(x2-zj_w/60*28);                  Points[3].Y:=trunc(y2-zj_H/60*8);
                 Image.canvas.Brush.Color:=$008000;
                 Image.canvas.Polygon(points);

                   // ���� ����Ͳ  //�۷�
                 Points[0].X:=trunc(x2-zj_w/60*25);       Points[0].Y:=trunc(y2-zj_H/60*35);
                 Points[1].X:=trunc(x2-zj_w/60*25);       Points[1].Y:=trunc(y2-zj_H/60*54);
                 Points[2].X:=trunc(x2-zj_w/60*27);       Points[2].Y:=trunc(y2-zj_H/60*54);
                 Points[3].X:=trunc(x2-zj_w/60*27);       Points[3].Y:=trunc(y2-zj_H/60*35);
                 Image.canvas.Brush.Color:=$0000FF;
                 Image.canvas.Polygon(points);
                  // ǰ������Ͳ //�۷�
                 Points[0].X:=trunc(x2-zj_w/60*34);                  Points[0].Y:=trunc(y2-zj_H/60*8);
                 Points[1].X:=trunc(x2-zj_w/60*37);                  Points[1].Y:=trunc(y2-zj_H/60*35);
                 Points[2].X:=trunc(x2-zj_w/60*41);                  Points[2].Y:=trunc(y2-zj_H/60*35);
                 Points[3].X:=trunc(x2-zj_w/60*38);                  Points[3].Y:=trunc(y2-zj_H/60*8);
                  Image.canvas.Brush.Color:=$008000;
                 Image.canvas.Polygon(points);

                    // ǰ������Ͳ  //�۷�
                 Points[0].X:=trunc(x2-zj_w/60*38);                  Points[0].Y:=trunc(y2-zj_H/60*35);
                 Points[1].X:=trunc(x2-zj_w/60*40);                  Points[1].Y:=trunc(y2-zj_H/60*54);
                 Points[2].X:=trunc(x2-zj_w/60*42);                  Points[2].Y:=trunc(y2-zj_H/60*54);
                 Points[3].X:=trunc(x2-zj_w/60*40);                  Points[3].Y:=trunc(y2-zj_H/60*35);
                 Image.canvas.Brush.Color:=$0000FF;
                 Image.canvas.Polygon(points);

            end;    //end  if zj_h> 40 then  begin  // ˫����    //�۷�
        end;  //end ������Ŀ  //�۷�
        //��������ʯ  //�۷�
        //�϶�
           //������   //�۷�
         {  Points[0].X:=trunc(x2-zj_w/60*22);                  Points[0].Y:=trunc(y1);
           Points[1].X:=trunc(x2-zj_w/60*22);                 Points[1].Y:=trunc(y2-zj_H/60*55);
           Points[2].X:=trunc(x2);                            Points[2].Y:=trunc(y2-zj_H/60*4);
           Points[3].X:=trunc(x2);                            Points[3].Y:=trunc(y1);
           Image.Canvas.Brush.Bitmap:=nil;
           Image.Canvas.Polygon(Points) ;
           bitmap1:=Tbitmap.Create;//����λͼ bitmap1
           bitmap1.LoadFromFile(dll_Path+'\BmpSi\ú.Bmp');//װ��ͼ���ļ�

           Image.Canvas.Brush.Bitmap:=bitmap1;
           Image.Canvas.FloodFill( Points[0].X+3,Points[0].Y+1,$000000,fsBorder);
           Image.Canvas.Brush.Bitmap:=nil;
           bitmap1.Free;  }
            //���ΰ����ͻ�
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
    end;   //end  //�۷�


end;

function TZJ_Class.DzXd_Cal_sup_para(gzm: TG_Stope; Zk: Tzk_bore;
  imm: TImmediate_roof; old: Told_roof): WideString;
 var
     s_out:widestring;
     Yl_stuct:integer;
     imm_m,Imm_c0,old_h_Max,Old_h_Min,old_l_max,old_l_min,Old_l_avg:double;
  begin
     //���ݵ��������޶����ʲ���
      zhiJia_F_xs:=1;zhijia_L_xs:=1; //��ʼ��ϵ��
      if  gzm.S_cmfs='4' then begin       //��ú��ʽ  �Ŷ�ú
          zhiJia_F_xs:=zhiJia_F_xs*1; //�����޶�ϵ��
          zhijia_L_xs:=zhijia_L_xs *1.1;// �����޶�ϵ��
          zhijia_hb_Q_xs:= zhijia_hb_Q_xs*1.05;// ����ǿ���޶�
      end;
      //�޸�ֵ����
      yL_stuct:=old.YL_struc;
      imm_m:=imm.Immroof_M;
      imm_c0:=imm.Immroof_C0 ;
      old_h_max:=old.YL_max_m ;
      old_h_min:=old.YL_min_m ;
      old_l_max:= old.YL_First_step[0] ;
      old_l_min:= old.YL_First_step[1] ;
      old_l_avg:= old.YL_First_step[2] ;

      imm.init(gzm,zk,0.5,s_out);    //��ʼ��ֱ�Ӷ�
      old.init(gzm,zk,imm,s_out);  //��ʼ���϶�
     // cal_zcyl(zk,imm,gzm,old,s_out);     //����֧��ѹ��
     // cal_ldg(zk,gzm,imm,200,s_out);  ;     //�����ѶϹ�
      //��ֵ�������
      old.YL_struc     :=yL_stuct;
      imm.Immroof_M  :=imm_m ;
      imm.Immroof_C0 :=imm_c0 ;
      old.YL_max_m     :=old_h_min ;
      old.YL_First_step[0] :=old_l_max ;
      old.YL_First_step[1] :=old_l_min;
      old.YL_First_step[2] :=old_l_avg  ;

      if  gzm.Dz_yxfx = 1 then begin       //��б
          zhiJia_F_xs:=zhiJia_F_xs*1.05; //�����޶�ϵ��
          zhijia_L_xs:=zhijia_L_xs *0.95;// �����޶�ϵ��
          zhijia_hb_Q_xs:= zhijia_hb_Q_xs*1.1;// ����ǿ���޶�
      end else if gzm.Dz_yxfx = 2 then begin  // ��б
          zhiJia_F_xs:=zhiJia_F_xs*0.95; //�����޶�ϵ��
          zhijia_L_xs:=zhijia_L_xs *1.05;// �����޶�ϵ��
          zhijia_hb_Q_xs:= zhijia_hb_Q_xs*0.95;// ����ǿ���޶�
      end;

      if  gzm.Dz_JYHD  =1 then begin       //���Һ��    ������
          zhiJia_F_xs:=zhiJia_F_xs*3; //�����޶�ϵ��
          zhijia_L_xs:=zhijia_L_xs *1;// �����޶�ϵ��
          zhijia_hb_Q_xs:= zhijia_hb_Q_xs*1.05;// ����ǿ���޶�
      end else if gzm.Dz_JYHD = 2 then begin            // һ�����
          zhiJia_F_xs:=zhiJia_F_xs*1.5; //�����޶�ϵ��
          zhijia_L_xs:=zhijia_L_xs *1;// �����޶�ϵ��
          zhijia_hb_Q_xs:= zhijia_hb_Q_xs*1.05;// ����ǿ���޶�
      end;

      if  gzm.Dz_DCGZ  =1 then begin       //���ʹ�����
          zhiJia_F_xs:=zhiJia_F_xs*0.95; //�����޶�ϵ��
          zhijia_L_xs:=zhijia_L_xs *1.05;   //
      end else if gzm.Dz_DCGZ >3  then begin            // ��ַ���츴��
          zhiJia_F_xs:=zhiJia_F_xs*1.05; //�����޶�ϵ��
          zhijia_L_xs:=zhijia_L_xs *1;// �����޶�ϵ��
          zhijia_hb_Q_xs:= zhijia_hb_Q_xs*1.05;// ����ǿ���޶�
      end;

      if  gzm.Dz_TopWater  =2  then begin       //����ˮ
          zhiJia_F_xs:=zhiJia_F_xs*1.05; //�����޶�ϵ��
          zhijia_L_xs:=zhijia_L_xs *1;   //
          zhijia_hb_Q_xs:= zhijia_hb_Q_xs*1.05;// ����ǿ���޶�
      end else if gzm.Dz_TopWater =4  then begin            //
          zhiJia_F_xs:=zhiJia_F_xs*1.05; //�����޶�ϵ��
          zhijia_L_xs:=zhijia_L_xs *1;// �����޶�ϵ��
          zhijia_hb_Q_xs:= zhijia_hb_Q_xs*1.05;// ����ǿ���޶�
      end;

      if  gzm.Dz_BottomWater  =2  then begin       //�װ�ˮ
          zhiJia_F_xs:=zhiJia_F_xs*0.95; //�����޶�ϵ��
          zhijia_L_xs:=zhijia_L_xs *1;   //
      end else if gzm.Dz_BottomWater =4  then begin            //
          zhiJia_F_xs:=zhiJia_F_xs*0.95; //�����޶�ϵ��
          zhijia_L_xs:=zhijia_L_xs *1;// �����޶�ϵ��
      end;


      if  gzm.Dz_Kyxx =3  then begin       //��ѹ����
          zhiJia_F_xs:=zhiJia_F_xs*1.05; //�����޶�ϵ��
          zhijia_L_xs:=zhijia_L_xs *1.05;   //
      end else if gzm.Dz_Kyxx =4  then begin            //
          zhiJia_F_xs:=zhiJia_F_xs*1.1; //�����޶�ϵ��
          zhijia_L_xs:=zhijia_L_xs *1.05;// �����޶�ϵ��
          zhijia_hb_Q_xs:= zhijia_hb_Q_xs*1.05;// ����ǿ���޶�
      end;

      if  gzm.Dz_HangDaoSup =4  then begin       //���֧��
          zhiJia_F_xs:=zhiJia_F_xs*0.95; //�����޶�ϵ��
          zhijia_L_xs:=zhijia_L_xs *1.05;   //
      end else if gzm.Dz_HangDaoSup=5  then begin            //
          zhiJia_F_xs:=zhiJia_F_xs*0.9; //�����޶�ϵ��
          zhijia_L_xs:=zhijia_L_xs *1.05;// �����޶�ϵ��
          zhijia_hb_Q_xs:= zhijia_hb_Q_xs*1.05;// ����ǿ���޶�
      end;

      if gzm.UP_Ckq =2 then  begin
         if gzm.UP_CKQ_JuLI < imm.Immroof_M then  begin
             imm.Immroof_M:=imm.Immroof_M+gzm.UP_CKQ_Kc_H*3;
         end else  if gzm.UP_CKQ_JuLI <gzm.Hg_ldg  then begin
             zhiJia_F_xs:=zhiJia_F_xs*1.1; //�����޶�ϵ��
             zhijia_L_xs:=zhijia_L_xs *1;// �����޶�ϵ��
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

      ��1��������Ӧ������ �ǵ������ṹ������֧�ܵ���ѹ����  �ڳ�����ѹ�׶�  ϵ���ݶ�Ϊ 0.25 ����������ѹ�׶� ϵ���ݶ�Ϊ 0.5
                          �������ṹ������֧�ܵ�֧������  �ڳ�����ѹ�׶�  ϵ���ݶ�Ϊ 0.5 ����������ѹ�׶� ϵ���ݶ�Ϊ 0.8
     ��2��������Ӧ������ �ǵ������ṹ������֧�ܵ���ѹ����  �ڳ�����ѹ�׶�  ϵ���ݶ�Ϊ 0.4 ����������ѹ�׶� ϵ���ݶ�Ϊ 0.6
                         �������ṹ������֧�ܵ�֧������  �ڳ�����ѹ�׶�  ϵ���ݶ�Ϊ 0.6 ����������ѹ�׶� ϵ���ݶ�Ϊ 1

    }
       //�ж���Ӧ����������
      if idefOrStep='Def' then   begin
          if old.YL_Dep_struct=1 then   begin   //������



          end else begin  //  �������ṹ

          end;

      end else begin

      end;


    //  if old.YL_struc =1 then begin   //   begin  2----�������ṹ
            //�϶�������ѹ //ѹ��
//            YLFDXS :=Zj_DBFD_xs[1];
//            Old_C0_F[0] :=Imm_F+ old.YL_max_m*old.YL_First_step[0]*25*Zj_zhongxinju*YLFDXS;    //�������ֵ
//            YLFDXS :=Zj_DBFD_xs[1];
//            Old_C0_F[1] := Imm_F+old.YL_min_m *old.YL_First_step[1]*25* Zj_zhongxinju*YLFDXS;  //������Сֵ
//            YLFDXS :=Zj_DBFD_xs[1];
//            Old_C0_F[2] := Imm_F+old.YL_min_m *old.YL_First_step[2]*25* Zj_zhongxinju*YLFDXS;  //����ƽ��ֵ
//            //����
//            Old_C0_L[0] :=(gzm.S_Cg_h+gzm.S_Fm_h)*(gzm.ZCYL_s0+ZJ_hlzyd)/old.YL_First_step[1];  //�������ֵ
//            Old_C0_L[1] :=(gzm.S_Cg_h+gzm.S_Fm_h)*(gzm.ZCYL_s0+ZJ_hlzyd)/old.YL_First_step[0];  //������ Сֵ
//            Old_C0_L[2] :=(gzm.S_Cg_h+gzm.S_Fm_h)*(gzm.ZCYL_s0+ZJ_hlzyd)/old.YL_First_step[2];  //����ƽ��ֵ



end;

function TZJ_Class.Init(str: wideString; out sEorr: Widestring): WordBool;
var
           temp1,temp2 :Str_Dt_array;
           i,Count1,Count2:integer;
begin
        Result:=true;
        sEorr:='֧�ܳ�ʼ���ɹ�!';
        if trim(str)='' then begin
            str:='ZJ:�۲�,ZY13000/25/50,1.75,5,2.6,2,2.5,13000,1.46,2,.5,';
        end;
      try
            temp1:=Public_Basic.split(str,':',Count1);

            if UpperCase(temp1[0])<>'ZJ' then
             begin
               Result:=False;
               sEorr:='֧�ܱ�ͷZJ����!';
               exit;
             end;

           temp2:=Public_Basic.split(temp1[1],',',Count2);
           if count2<12 then
               begin
               Result:=False;
               sEorr:='����ϸ����ļ�!';
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
              //���֧�����߶�����С�߶�
              temp2:=Public_Basic.split(ZJ_Name,'/',Count2);
              if Count2>2 then    begin
                 ZJ_Min_h :=Public_Basic.StrTodouble_lu(Trim(temp2[1]));
                 ZJ_Max_h :=ZJ_min_h+ ZJ_suoliang;

              end;
              if Trim(ZJ_Name)<> '����' then   begin

                       if ZJ_Zhongxinju=0  then //�ж�֧�����ľ�
                         begin
                           Result:=False;
                           sEorr:=sEorr+'֧�����ľ�/';
                          end;
                       if ZJ_KongDingJU=0  then  // �ж�֧�ܿض���
                         begin
                           Result:=False;
                           sEorr:=sEorr+'֧�ܿض���/';
                         end;
                       if Zj_Hlzyd=0  then  // �ж�֧�ܺ������õ�
                         begin
                           Result:=False;
                           sEorr:=sEorr+'�������õ�/';
                         end;
              end; //end    if Trim(ZJ_Name)<> '����' then   begin
         except
              Result:=False;
              sEorr:='���ݸ�ʽ����/';
              exit;
       end;
         zhiJia_F_xs :=1;   // ֧��֧��ǿ���޶�ϵ��
         zhijia_L_xs :=1;; // ֧�������޶�ϵ��
         zhijia_hb_Q_xs :=1;// ֧�ܻ���ǿ���޶�ϵ��
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
      in_Zj_DBFD_xs:  array [1..4] of array[1..9] of double;// ���治ͬ���� ����
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
          //  ��������
           //�жϹ���
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
           Rstr:='�϶�������ѹʱ:'+#13#10;
           for I := 0 to 2 do  begin    //��Ϲ������� ��λKN
              if i=0 then  begin
                 Rstr:=Rstr+ '      �������ֵ:'+FormatFloat('0.0',zj_jisuan_c0_F[i])+'KN��';
                 Rstr:=Rstr+ 'ǿ�����ֵ:'+FormatFloat('0.0',zj_jisuan_c0_P[i])+'MPa;'+#13#10;
              end else if i=1 then  begin
                 Rstr:=Rstr+ '      ������Сֵ:'+FormatFloat('0.0',zj_jisuan_c0_F[i])+'KN��';
                 Rstr:=Rstr+ 'ǿ����Сֵ:'+FormatFloat('0.0',zj_jisuan_c0_P[i])+'MPa;'+#13#10;
              end else if i=2 then begin
                 Rstr:=Rstr+ '      ��������ֵ'+FormatFloat('0.00',zj_jisuan_c0_F[i])+'KN��';
                 Rstr:=Rstr+ 'ǿ�Ƚ���ֵ:'+FormatFloat('0.00',zj_jisuan_c0_P[i])+'MPa��'+#13#10;
              end;

           end;


            Rstr:=Rstr+#13+'�϶�������ѹʱ:'+#13#10;;
           for I := 0 to 2 do  begin    //��Ϲ������� ��λKN
              if i=0 then  begin
                 Rstr:=Rstr+'      �������ֵ:'+ FormatFloat('0.0',zj_jisuan_ci_F[i])+'KN��';
                 Rstr:=Rstr+'ǿ�����ֵ:'+FormatFloat('0.0',zj_jisuan_ci_P[i])+'MPa��'+#13#10;;
              end else   if i=1 then  begin
                 Rstr:=Rstr+'      ������Сֵ:'+ FormatFloat('0.0',zj_jisuan_ci_F[i])+'KN��';
                 Rstr:=Rstr+'ǿ����Сֵ:'+FormatFloat('0.0',zj_jisuan_ci_P[i])+'MPa��'+#13#10;;
              end else begin
                 Rstr:=Rstr+'      ��������ֵ:'+ FormatFloat('0.00',zj_jisuan_ci_F[i])+'KN��';
                 Rstr:=Rstr+'ǿ�Ƚ���ֵ:'+FormatFloat('0.00',zj_jisuan_ci_P[i])+'MPa��'+#13#10;;
              end;

           end;

           {  Rstr:=Rstr+'����߶�:';
              for I := 0 to 4 do  begin    //��ϻ���߶� ��λm
                if i<>4 then  begin
                   Rstr:=Rstr+ FormatFloat('0.0',zj_jisuan_hubang_H[i])+'m,';
                end else begin
                   Rstr:=Rstr+ FormatFloat('0.0',zj_jisuan_hubang_H[i])+'m#';
                end;

             end;
              Rstr:=Rstr+'����ǿ��:';
              Rstr:=Rstr+ FormatFloat('0.0', Zj_jisuan_hubang_p[2])+'MPa#';
             }

       end; //end 1.0

      if Version='2.0'  then begin
          Rstr:='';
           for I := 0 to 2 do  begin    //��Ϲ������� ��λKN
                if i<>2 then  begin
                   Rstr:=Rstr+ FormatFloat('0.0',zj_jisuan_c0_F[i])+',';
                end else begin
                   Rstr:=Rstr+ FormatFloat('0.00',zj_jisuan_c0_F[i])+';';
                end;

             end;
             for I := 0 to 2 do  begin    //��Ϲ���ǿ�� ��λMPa
                if i<>2 then  begin
                   Rstr:=Rstr+ FormatFloat('0.0',zj_jisuan_c0_P[i])+',';
                end else begin
                   Rstr:=Rstr+ FormatFloat('0.00',zj_jisuan_c0_P[i])+';';
                end;

             end;


             for I := 0 to 2 do  begin    //��Ϲ������� ��λKN
                if i<>2 then  begin
                   Rstr:=Rstr+ FormatFloat('0.0',zj_jisuan_ci_F[i])+',';
                end else begin
                   Rstr:=Rstr+ FormatFloat('0.00',zj_jisuan_ci_F[i])+';';
                end;

             end;
             for I := 0 to 2 do  begin    //��Ϲ���ǿ�� ��λMPa
                if i<>2 then  begin
                   Rstr:=Rstr+ FormatFloat('0.0',zj_jisuan_ci_P[i])+',';
                end else begin
                   Rstr:=Rstr+ FormatFloat('0.00',zj_jisuan_ci_P[i])+';';
                end;

             end;

              for I := 0 to 4 do  begin    //��ϻ���߶� ��λm
                if i<>4 then  begin
                   Rstr:=Rstr+ FormatFloat('0.0',zj_jisuan_hubang_H[i])+',';
                end else begin
                   Rstr:=Rstr+ FormatFloat('0.0',zj_jisuan_hubang_H[i])+';';
                end;

             end;

               for I := 0 to 2 do  begin    //��ϻ���ǿ�� ��λMPa
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
    { ǿ���޶�֧�ܵ���������
      �޶���ԭ��  ֧�ܲ��ܴ��� 260000KN�� ������� ��    ǿ�ƴ���
      ֧�ܲ���С�� 8000KN  ���С�� ��ǿ�ƴ���
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
        sEorr:='֧�ܲ�ֳɹ�!';
      try
            temp1:=Public_Basic.split(str,',',Count1);
         if count1<11 then
               begin
               Result:=False;
               sEorr:='����ϸ����ļ�!';
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
              sEorr:='���ݸ�ʽ����/';
              exit;
        end;  //end try
         if Trim(self.JG_Dl)='DL1' then  //�½Ӷ���
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
           end else begin //esle if Trim(self.JG_Dl)='DL1' then  // ����
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



        //���ʵ� ���ڸ�
            if  JG_jx='JX3' then   begin
                self.ZJ_JianYi_Type:='JX3';
            end else if  JG_jx='JX4' then   begin
                self.ZJ_JianYi_Type:='JX4';
            end;
end;

end.
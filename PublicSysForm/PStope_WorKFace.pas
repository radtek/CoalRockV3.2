unit PStope_WorKFace;

interface
uses
  Windows, SysUtils, Classes, Messages, Controls, Forms, StdCtrls, ExtCtrls,
  ComCtrls,math,IniFiles,Jpeg,Graphics,Dialogs,Lu_Public_BasicModual;
type

 //������ʯ��,Ϊ TRock
   TRock =class(Tobject)

    public
      R_Name  :WideString;    //��ʯ����
      R_h     :double;        //��ʯ���
      R_kyqd  : double;       // ��ѹǿ��
      R_klqd  : double;       // ����ǿ��
      R_fchd  :double;        // �ֲ���
      R_k_Rock: double;      // ��ʯ����ϵ��
      R_r      : double;     //  ��ʯ����
      PNG_Change:integer;   //�Ҳ��Ƿ��������
      R_kjqd :double;//����ǿ��
      R_MinH :double; //�Ҳ���С���
      R_MaxH :double;  // �Ҳ������
      R_sffc :bool;//     �Ƿ�ֲ�
      R_sfhsc:bool;//     �Ƿ�ˮ
      BmpFile :String; //ͼ��
      MCId:integer; //ú���id���
    end;

 //�����Ҳ��� TYc_Rcok
  TYc_Rock =class(TRock)

    public
      //�ⲿ�������
      Yc_No       :integer;    //�Ҳ���
      M_Kc_YandN  :bool;      // �Ƿ��ǿ���ú��
      L_qx_xiashan   :double ;    //��б�����ѶϹ���ɽ������б�����ߵĳ���
      L_qx_shangshan   :double ;    //��б�����ѶϹ���ɽ������б�����ߵĳ���
      L_Tj        :double;     //�ƽ������ѶϹ����߾����ú������ľ���
      //�ڲ��������
      Step0      :double;    //����ÿһ���Ҳ�ĳ�����ѹ����
      step_i     : array [0..4] of double ; // ����ÿһ���Ҳ��1-4��������ѹ���� ����0 �� Ϊ �ȶ����ڲ���
      step_fcbu  : array [0..4] of double ; // ��������Ҳ��зֲ�ĸ���ֲ㲽��ļ���
                                           //�Ҳ��1-4��������ѹ���� ����0 �� Ϊ �ȶ����ڲ���
      Sa : array [0..2] of double ;     //  ��¼�����³��� 0 Ϊ��ʼ�³� 1Ϊ �����³���0.95  2 Ϊ �ȶ��³�  0.85


    public
       procedure Step_Rock(h,Rc,r:double);     //����������ѹ����
       procedure Step_Rock_FC(h,Rc,r:double);  // ����ֲ���ѹ����
                end;

  //����������
   TYL_beam =class (Tobject)
      public
        Start_YC_No :  integer;    //
        End_Yc_NO   :  integer;    //
        Ztc_ms      :double;       //֧�в�ĺ��
        Sdc_mc      :double;       //�涯��ĺ��
        Step_0_Compr    :  double;     //  �����涯��
        Step_i_Compr    :  array[0..5] of double;     //    �±�0 Ϊ �ȶ����࣬1-5 Ϊ��һ�ε���5��������ѹ
        Step_0_Simple   :  double;     //  �������涯��
        step_i_simple   :  array[0..5] of double;     //   �±�0 Ϊ �ȶ����࣬1-5 Ϊ��һ�ε���5��������ѹ
     //   is_init         :  bool ; //��¼�Ƿ񱻳�ʼ��
        end;

  //��������� TZk
   TZk_bore =class(Tobject)
     public
            Zk_No       :integer;             // ��ױ��
            Zk_Yc_Count :integer;            // �Ҳ����
            Zk_name     : WideString;        // �������
            BmpFile     :Widestring ;        //ͼƬ�ļ�����
            Yc_Rock    :array of TYc_Rock;   // �Ҳ����飨��̬���飬�±�Ϊ�Ҳ�Ĳ�����
          //  Beam_Def_count    :integer;      //��������������ĸ���
            Beam_Def  :array[0..4] of TYL_beam;   //��������������Ķ�̬����
           // Beam_step_count   :integer;     //  ����ڲ��������ĸ���
            Beam_step :array[0..4] of TYL_beam;  // ����ڲ������Ķ�̬����
            main_coal  :  integer;  // �ô�Ϊ�Ҳ�����ı��
            is_init    :bool  ;
            Zk_ldg_end_no:integer;//  // �ô�Ϊ�ѶϹ��Ҳ���ֹ�� �Ҳ�������
           // 20160830
            Mineid:integer;
        function Init(s_zk:wideString;out sEorr:Widestring):WordBool;
        procedure DelZKHanzi;
        function ReturnSa(zk:TZk_bore):wideString;  stdcall;
        function ReturnCxbj(zk:TZk_bore):wideString;  stdcall;
        function Return_ZkCs:widestring; stdcall;
        procedure FreeInitCreateClass;
        destructor Destroy ;override;
   end;

  //���幤������ TG_stope
  TG_stope =class

       public
        S_Name   :WideString;         //  1����������
        S_No     :WideString;         // 2 ��������
        S_mc_name:WideString;         // 3 ����ú������
        S_Cg_h   :double;             // 4 ������ɸ�
        S_cmfs   :WideString;         // 5 ��ú��ʽ
        S_Fm_h   :double;             // 6 ��ú�߶�
        S_qj     :double;             // 7 ú�����
        S_mcsd_h :double;             // 8 ������
        s_max_h,s_min_h:double;       //  ��������������С����
        S_L_qx   :double;             // 9 ��������б��
        S_Sx_zx  :double;             // 10 ����������
        S_Jc_L   :double;             // 11 �������ۼƽ���
        S_f_PS   :double;             // 12  ú�������ϵ��
        S_M_mcj  :double;             // 13  ú�����Ħ����
        S_M_njl  :double;             // 14  ú����ھ���
        S_Bsb    :double;             // 15  ý��Ĳ��ɱ�
        S_K_zcfz :double;             // 16  ֧��ѹ����ֵϵ��
        S_Dblb   :Widestring;         // 17   �����涥�����
        ZCYL_sx  :array[0..3] of double; //18 ֧��ѹ���ķ�Χ   0 ������ǰ���� 1 �·� 2 ��  3 �Ϸ�
        ZCYL_s0  :double;             // 19  ��Ӧ�����ķ�Χ
        ZCYL_s1  :array[0..3] of double;//20 ֧��ѹ���߷�ķ�Χ 0Ϊ������ǰ����󷽣�1Ϊ ����������
        Hg_ldg   :double;              // 21 ֧��ѹ���ѶϹ�
        is_init  :bool ;               // 22
        mbcsnl_l :double;              //23 ú��ɥʧ֧�������ľ���
        Dz_yxfx     :integer;             // 24  1	ˮƽ�ƽ�   		2	��б�ƽ�  3	��б�ƽ�
        Dz_JYHD	   :integer;            // 25   1	������  	2	һ�����   3	�к����     	4	�޺����
        Dz_DCGZ     :integer;            //26 	1	���ʹ������    	2	��б�Ჿ     3	��б�Ჿ   4	�ϲ��ܼ�������Ӱ���ƽ�   5	�ϲ��ܼ���Ӱ���ƽ�  6	���켫�临��
        Dz_WSFC	   :integer;            // 27   1	��˹�����ϵ�   	2	����˹���ֲ�����  3	����˹
        Dz_TopWater :integer;            // 28  	1	������ˮ  	2	��ˮ����붥���Զ  	3	��ˮ����붥��Ͻ�   4	������͸ˮ�¹�   	5	����
        Dz_BottomWater: Integer;          // 29 	1	�װ���ˮԴ   2	�װ���ˮԴ����Զ  3	�װ���ˮԴ���Ͻ�   4	�������װ�ͻ���¹�    5	����
        Dz_HeoStress	:integer;           //  30  1	������ˮƽӦ��  2	ˮƽӦ��С�ڴ�ֱӦ��  3	ˮƽӦ���봹ֱӦ���൱  4	ˮƽӦ�����ڴ�ֱӦ��1.5������
        Dz_Kyxx       :Integer;          // 31  	1	��ѹ���ֲ�����   2	�п�ѹ���֣���Ӱ������  3	��ѹ���ֽϾ��ң�Ӱ����  4	�����������¹�
        Dz_HangDaoSup :integer;          //32   	1	�����������Ҫ֧��  	2	�����ê��֧��   3	�������֧��������������  	4	������Σ��׹ģ���ȫӰ��С  5	������ٱ��Σ��׹ģ�����Ӱ�찲ȫ
        CK_Upkc       :integer;          //33      �Ͻ쿪�����     0 δ��  1 �Բ�
        CK_UpMz       :double;           //34       �Ͻ�ú��
        CK_downkc     :integer;          //35     �½쿪��       0 δ��  1 �Բ�
        CK_downmz     :double;          // 36    �½�úס
        S_DayStep_speed: double;       //  37  ���������ƽ��ٶ�
        S_Sh_UP       :double;         //  38  �������ϱ߽����
        S_Sh_Down     :double;         //  39  �������±߽����
        S_SX_qj       :double;         //  40  �������ƽ��������
        UP_Ckq        :Integer;         // 41 �������Ϸ��Ƿ���ڲɿ���
        UP_CKQ_Kc_H   :double;         // 42 �ɿ����Ĳɸ�
        UP_CKQ_JuLI   :double;         //43 �ɿ�������ù�����ľ���
        Mc_FdBs       :double;         //44 ú��ķŴ������������˶�ʱʹ��
        Ci_xs         :double;         // 45  ������ѹ�������ϵ��
        yklh          :integer;        // 46�Ƿ���ʵʩ��Ч�ؿ����0 ���� 1 ����  2 ��Ҫ��������  3 ��Ҫ�����װ�
        yklh_hpct_h   :double;         // 47  �ؿ����� ���Գ���ĸ߶�
        yklh_tc_lu_w:    double;          //  48 �ؿ��������ǽ��� ¼�� ����
        yklh_tc_js_w:    double;          //  49 �ؿ��������ǽ���  ���� ����
        dynamic_factor:double;         //  50  �����涥�嶯��ϵ��

         function Init(str:wideString;out sEorr:Widestring):WordBool;
         procedure delGzmhanzi;
         function Init_GZM_simple(str:wideString;out sEorr:Widestring):WordBool;
         function Init_GZM_Difficult(str:wideString;out sEorr:Widestring):WordBool;
         function Return_Zcyl(Version:WideString;JinChi:double;zk:Tzk_bore):Widestring;//���ز�ú�������֧��ѹ��
         procedure Set_max_min_h(MaxV,MInV:double);
      end;

implementation


  //\\\\\\\\\\\\\\\\\\\\\\\


//----- ú�������Ķ������
//--------��ʼ����������
procedure TG_stope.delGzmhanzi;
var
  i:integer;
begin
    i:=Pos(String('������'),String(S_Name));
    if i>0 then
      S_Name:= copy(S_Name,1,i-1) ;
end;

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
               sEorr:='�����汨ͷGZM����!';
               Public_Basic.My_WriteLog('Eorr:Init �����汨ͷGZM����!','[TG_stope]');
               exit;
            end;

      except
              Result:=False;
              sEorr:='���ݸ�ʽ����/';
              Public_Basic.My_WriteLog('Eorr:Init ���ݸ�ʽ����/!','[TG_stope]');
              exit;
       end;
       delGzmhanzi;// ɾ�������������еĺ�����Ϣ
   end;
   //---------------------------------------  ��ʼ����������ڶ��θ��ӵ�

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
               sEorr:='����ϸ����ļ�!';
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
                     27: self.S_Jc_L    :=Public_Basic.strTodouble_lu(temp2[i]);
                  end;
             end; //endfor
              temp1:=nil;temp2:=nil;
      except
              Result:=False;
              sEorr:='���ݸ�ʽ����/';
              Public_Basic.My_WriteLog('Eorr:Init_GZM_difficult ���ݸ�ʽ����/','[TG_stope]');
              exit;
       end;

         //-------------
         if S_cg_h=0 then    // �жϲ�ú�߶�
           begin
             Result:=False;
             sEorr:=sEorr+'��ú�߶�/';
            end else begin
               if S_cg_h<2 then begin
                    Mc_FdBs:=1.5;
                end else begin
                    Mc_FdBs:=1;
                end;
            end;

        if S_No='' then //�жϹ�������
           begin
             Result:=False;
             sEorr:=sEorr+'��������/';
             end;
         if S_Mc_name='' then //�ж�ú������
           begin
             Result:=False;
             sEorr:=sEorr+'ú��/';
            end;
         if S_cmfs='' then  // �жϲ�ú����
           begin
             Result:=False;
             sEorr:=sEorr+'��ú��ʽ(�۲�/�۷�/�ղ�)/';
           end;
         if S_l_qx=0 then    // �жϹ��������б����
           begin
             Result:=False;
             sEorr:=sEorr+'��б����/';
           end;
         if S_sx_zx=0 then    // �жϹ��������б����
           begin
             Result:=False;
             sEorr:=sEorr+'�ƽ�����/';
           end;
         if S_mcsd_h=0 then    // �жϹ������������
           begin
             Result:=False;
             sEorr:=sEorr+'������!';
           end;
          if S_f_ps=0 then    // �ж�ú�������ϵ��
           begin
             Result:=False;
             sEorr:=sEorr+'����ϵ��!';
           end;
           // �������ȵ����ֵ����Сֵ��ֵ
        s_max_h:= S_mcsd_h+s_l_qx*sin(s_qj/180*3.1415926);
        s_max_h:= S_mcsd_h-s_l_qx*sin(s_qj/180*3.1415926);
         if Result then
             self.is_init:=True
   end;
   //---------------------------------------  ��ʼ����������ԭ��d

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
               sEorr:='�����汨ͷGZM����!';
               Public_Basic.My_WriteLog('Eorr:Init_GZM_Simple �����汨ͷGZM����!','[TG_stope]');
               exit;
             end;

           temp2:=Public_Basic.split(temp1[1],',',Count2);
           if count2<17 then
               begin
               Result:=False;
               sEorr:='����ϸ����ļ�!';
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
              sEorr:='���ݸ�ʽ����/';
              Public_Basic.My_WriteLog('Eorr:Init_GZM_Simple ���ݸ�ʽ����/','[TG_stope]');
              exit;
       end;

         //-------------
         if S_cg_h=0 then    // �жϲ�ú�߶�
           begin
            S_cg_h:=2.5;
            end;
        if S_No='' then //�жϹ�������
           begin
              S_No:='�¹�����';
             end;
         if S_Mc_name='' then //�ж�ú������
           begin
             S_Mc_name:='1';
            end;
         if S_cmfs='' then  // �жϲ�ú����
           begin
             S_cmfs:='2';
           end;
         if S_l_qx=0 then    // �жϹ��������б����
           begin
             S_l_qx:=180;
           end;
         if S_sx_zx=0 then    // �жϹ��������б����
           begin
             S_sx_zx:=1000;
           end;
         if S_mcsd_h=0 then    // �жϹ������������
           begin
             S_mcsd_h:=500;
           end;
          if S_f_ps=0 then    // �ж�ú�������ϵ��
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
    K1,K2 :double; //����Ӧ������ֵ ��С
    s0,s1 :double; // ����Ӧ������Χ
    JinC_sul:double;//ʣ����ߵı���
begin
    Str_temp:='';
    //��ʼ����ú��ɥʧ֧�������ľ���
  if JinChi<5 then JinChi:=5;
  if JinChi < self.mbcsnl_l  then  begin
      K1:=0;
      if self.S_f_PS>1.5 then   begin     //ͨ��ú��Ӳ�����ж�֧�ŷ�ֵ
           K2:= 1+ sqrt(JinChi/40/3);  //��Ӧ�����ķ�ֵ    úӲ ֧�ŷ�Χ��60������
      end else if self.S_f_PS>1 then begin
           K2:= 1+ sqrt(JinChi/50/3);  //��Ӧ�����ķ�ֵ   ú�е�֧�ŷ�Χ��100������
      end else begin
           K2:= 1+ sqrt(JinChi/60/3);  //��Ӧ�����ķ�ֵ   ú�� ֧�ŷ�Χ��120������
      end;

      if K2<1.05 then k2:=1.05;

      if Version='1.0' then begin
             Str_temp:='0;'+FormatFloat('0.00',K2)+';'; // k1,k2
             Str_temp:=Str_temp+'0,0,0,0;' ; //S0 ���ĸ���
             Str_temp:=Str_temp+'0,0,0,0;' ; //S1 ���ĸ���
             Str_temp:=Str_temp+FormatFloat('0.0',self.ZCYL_sx[0]* JinChi/self.S_L_qx)+','; //Sx ���ĸ���   �����۴�
             Str_temp:=Str_temp+FormatFloat('0.0',self.ZCYL_sx[1]* JinChi/self.S_L_qx)+','; //Sx ���ĸ���   ��˳�۴�
             Str_temp:=Str_temp+FormatFloat('0.0',self.ZCYL_sx[2]* JinChi/self.S_L_qx)+','; //Sx ���ĸ���   ������ǰ����
             Str_temp:=Str_temp+FormatFloat('0.0',self.ZCYL_sx[3]* JinChi/self.S_L_qx)+';'; //Sx ���ĸ���   ��˳�۴�
             Result:=Str_temp;
        end else if Version='2.0' then  begin     //�����ۺ�����
             Str_temp:='0;0;'+FormatFloat('0.00',K2)+';0;';    //k1,S0,K2,s1,
             Str_temp:=Str_temp+FormatFloat('0.0',(k2-1)*40)+';';  //sx
             Result:=Str_temp;
        end else if Version='4.0' then  begin     //�����ۺ�����
             Str_temp:='��Ӧ������ֵ��'+FormatFloat('0.00',0)+'��';    //k1
             Str_temp:=Str_temp+'��Ӧ������Χ��'+FormatFloat('0.0',0)+'�ף�';  //s0
             Str_temp:=Str_temp+'��Ӧ������ֵ��'+FormatFloat('0.00',k2)+'��';  //k2
             Str_temp:=Str_temp+'��Ӧ������Χ����ú�ھ��룺'+FormatFloat('0.0',0)+'�ף�';  //s1
             Str_temp:=Str_temp+'��Ӧ������Χ��'+FormatFloat('0.0',(k2-1)*40)+'�ס�';  //sx
             Result:=Str_temp;
        end;   //end if Version='1.0' then begin
 end else  if Jinchi<=self.S_L_qx  then   begin      //һ�μ���֮��
               // K1:=0.8*Jinchi/self.S_L_qx;     // ��Ӧ������ֵ��С
      K1:=0.8;
      s0:=self.ZCYL_s0*(JinChi-self.mbcsnl_l)/self.S_L_qx;      // ��Ӧ������Χ
      if self.S_f_PS>1.5 then   begin     //ͨ��ú��Ӳ�����ж�֧�ŷ�ֵ
           K2:= 1+ sqrt(JinChi/40/3);  //��Ӧ�����ķ�ֵ    úӲ ֧�ŷ�Χ��60������
      end else if self.S_f_PS>1 then begin
           K2:= 1+ sqrt(JinChi/50/3);  //��Ӧ�����ķ�ֵ   ú�е� ֧�ŷ�Χ��100������
      end else begin
           K2:= 1+ sqrt(JinChi/60/3);  //��Ӧ�����ķ�ֵ   ú�� ֧�ŷ�Χ��120������
      end;
      S1:=self.ZCYL_s1[2]* JinChi/self.S_L_qx;      // ��Ӧ������Χ
      if S1<S0 then  s1:=2*S0;

        if K2>2.5 then  K2:=2.5;   //���ֵǿ��
        if Version='1.0' then begin
             Str_s1_2:=0;
             Str_temp:=FormatFloat('0.00',K1)+';';   // k1
             Str_temp:=Str_temp+FormatFloat('0.00',K2)+';'; // k2
             Str_temp:=Str_temp+FormatFloat('0.0',s0)+','; // so �����ۺ�
             Str_temp:=Str_temp+FormatFloat('0.0',s0*(1+sin(self.S_qj/180*3.14159)))+','; // so  ��˳�۴�
             //�жϳ�����ѹ����
             if JinChi<zk.Yc_Rock[zk.main_coal-1].Step0-s0 then begin
                  Str_temp:=Str_temp+'0,'; // s0  ������ǰ����
                  Str_s1_2:=s0+s1;  // s1 ������ǰ����
              end else if JinChi<=zk.Yc_Rock[zk.main_coal-1].Step0 then begin
                  Str_temp:=Str_temp+'0,'; // s0  ������ǰ����
                  Str_s1_2:=s0+s1-(JinChi-zk.Yc_Rock[zk.main_coal-1].Step0 );  // s1 ������ǰ����
             end;  //end   if JinChi<zk.Yc_Rock[zk.main_coal-1].Step0-s0 then begin

            JinC_sul:=JinChi-zk.Yc_Rock[zk.main_coal-1].Step0;

             while JinC_sul>0 do   begin
                if JinC_sul<zk.Yc_Rock[zk.main_coal-1].Step0*0.3-s0 then begin
                      Str_temp:=Str_temp+'0,'; // s0  ������ǰ����
                      Str_s1_2:=s0+s1;  // s1 ������ǰ����
                   end else if JinC_sul<=zk.Yc_Rock[zk.main_coal-1].Step0*0.3 then begin
                      Str_temp:=Str_temp+'0,'; // s0  ������ǰ����
                      Str_s1_2:=s0+s1-(JinC_sul-zk.Yc_Rock[zk.main_coal-1].Step0*0.3 );  // s1 ������ǰ����

                 end;  //end  if JinC_sul<zk.Yc_Rock[zk.main_coal-1].Step0*0.3-s0 then begin
                 JinC_sul:=JinC_sul-zk.Yc_Rock[zk.main_coal-1].Step0*0.3;

             end;  //end while do

             Str_temp:=Str_temp+FormatFloat('0.0',s0*(1-sin(self.S_qj/180*3.14159)))+';'; // s0  ��˳�۴�

             Str_temp:=Str_temp+FormatFloat('0.0',s1)+','; // s1 �����ۺ�
             Str_temp:=Str_temp+FormatFloat('0.0',s1*(1+sin(self.S_qj/180*3.14159)))+','; // s1  ��˳�۴�
             Str_temp:=Str_temp+FormatFloat('0.0',Str_s1_2)+','; // s1  s1 ������ǰ����
             Str_temp:=Str_temp+FormatFloat('0.0',s1*(1-sin(self.S_qj/180*3.14159)))+';'; // s1  ��˳�۴�


             Str_temp:=Str_temp+FormatFloat('0.0',self.ZCYL_sx[0]* JinChi/self.S_L_qx)+','; //Sx ���ĸ���   �����۴�
             Str_temp:=Str_temp+FormatFloat('0.0',self.ZCYL_sx[1]* JinChi/self.S_L_qx)+','; //Sx ���ĸ���   ��˳�۴�
             Str_temp:=Str_temp+FormatFloat('0.0',self.ZCYL_sx[2]* JinChi/self.S_L_qx)+','; //Sx ���ĸ���   ������ǰ����
             Str_temp:=Str_temp+FormatFloat('0.0',self.ZCYL_sx[3]* JinChi/self.S_L_qx)+';'; //Sx ���ĸ���   ��˳�۴�
             Result:=Str_temp;
        end else if Version='2.0' then  begin     //�����ۺ�����
             Str_temp:=FormatFloat('0.00',K1)+';';    //k1
             Str_temp:=Str_temp+FormatFloat('0.0',s0)+';';  //s0
             Str_temp:=Str_temp+FormatFloat('0.00',k2)+';';  //k2
             Str_temp:=Str_temp+FormatFloat('0.0',s1)+';';  //s1
             Str_temp:=Str_temp+FormatFloat('0.0',self.ZCYL_sx[0]* JinChi/self.S_L_qx)+';';  //sx
             Result:=Str_temp;
        end else if Version='4.0' then  begin     //�����ۺ�����
             Str_temp:='��Ӧ������ֵ��'+FormatFloat('0.00',K1)+'��';    //k1
             Str_temp:=Str_temp+'��Ӧ������Χ��'+FormatFloat('0.0',s0)+'�ף�';  //s0
             Str_temp:=Str_temp+'��Ӧ������ֵ��'+FormatFloat('0.00',k2)+'��';  //k2
             Str_temp:=Str_temp+'��Ӧ������Χ����ú�ھ��룺'+FormatFloat('0.0',s1)+'�ף�';  //s1
             Str_temp:=Str_temp+'��Ӧ������Χ��'+FormatFloat('0.0',self.ZCYL_sx[0]* JinChi/self.S_L_qx)+'�ס�';  //sx
             Result:=Str_temp;
        end;   //end if Version='1.0' then begin

end else if Jinchi<=self.S_L_qx*2  then begin     //һ�μ���֮����μ���֮��
        K1:=0.8;     // ��Ӧ������ֵ��С
        s0:=self.ZCYL_s0;      // ��Ӧ������Χ
        if self.S_f_PS>1.5 then   begin     //ͨ��ú��Ӳ�����ж�֧�ŷ�ֵ
             K2:= 1+ sqrt(JinChi/40/3);  //��Ӧ�����ķ�ֵ    úӲ ֧�ŷ�ֵ��60������
        end else if self.S_f_PS>1 then begin
             K2:= 1+ sqrt(JinChi/50/3);  //��Ӧ�����ķ�ֵ   ú�е� ֧�ŷ�ֵ��100������
        end else begin
             K2:= 1+ sqrt(JinChi/60/3);  //��Ӧ�����ķ�ֵ   ú�� ֧�ŷ�ֵ��120������
        end;

        S1:=self.ZCYL_s1[2];      // ��Ӧ������Χ
        if K2>2.5 then  K2:=2.5;   //���ֵǿ��
        if Version='1.0' then begin
               Str_s1_2:=0;
               Str_temp:=FormatFloat('0.00',K1)+';';   // k1
               Str_temp:=Str_temp+FormatFloat('0.00',K2)+';'; // k2
               Str_temp:=Str_temp+FormatFloat('0.0',s0)+','; // so �����ۺ�
               Str_temp:=Str_temp+FormatFloat('0.0',s0*(1+0.5*(Jinchi-self.S_L_qx)/self.S_L_qx)*(1+sin(self.S_qj/180*3.14159)))+','; // so  ��˳�۴�
               //�жϳ�����ѹ����
               if JinChi<zk.Yc_Rock[zk.main_coal-1].Step0-s0 then begin
                    Str_temp:=Str_temp+'0,'; // s0  ������ǰ����
                    Str_s1_2:=s0+s1;  // s1 ������ǰ����
                end else if JinChi<=zk.Yc_Rock[zk.main_coal-1].Step0 then begin
                    Str_temp:=Str_temp+'0,'; // s0  ������ǰ����
                    Str_s1_2:=s0+s1-(JinChi-zk.Yc_Rock[zk.main_coal-1].Step0 );  // s1 ������ǰ����
               end;  //end   if JinChi<zk.Yc_Rock[zk.main_coal-1].Step0-s0 then begin

              JinC_sul:=JinChi-zk.Yc_Rock[zk.main_coal-1].Step0;
               while JinC_sul>0 do   begin
                        if JinC_sul<zk.Yc_Rock[zk.main_coal-1].Step0*0.3-s0 then begin
                              Str_temp:=Str_temp+'0,'; // s0  ������ǰ����
                              Str_s1_2:=s0+s1;  // s1 ������ǰ����
                           end else if JinC_sul<=zk.Yc_Rock[zk.main_coal-1].Step0*0.3 then begin
                              Str_temp:=Str_temp+'0,'; // s0  ������ǰ����
                              Str_s1_2:=s0+s1-(JinC_sul-zk.Yc_Rock[zk.main_coal-1].Step0*0.3 );  // s1 ������ǰ����

                         end;  //end  if JinC_sul<zk.Yc_Rock[zk.main_coal-1].Step0*0.3-s0 then begin
                         JinC_sul:=JinC_sul-zk.Yc_Rock[zk.main_coal-1].Step0*0.3;

               end;  //end while do

               Str_temp:=Str_temp+FormatFloat('0.0',s0*(1+0.5*(Jinchi-self.S_L_qx)/self.S_L_qx)*(1-sin(self.S_qj/180*3.14159)))+';'; // s0  ��˳�۴�

               Str_temp:=Str_temp+FormatFloat('0.0',s1)+','; // s1 �����ۺ�
               Str_temp:=Str_temp+FormatFloat('0.0',s1*(1+0.5*(Jinchi-self.S_L_qx)/self.S_L_qx)*(1+sin(self.S_qj/180*3.14159)))+','; // s1  ��˳�۴�
               Str_temp:=Str_temp+FormatFloat('0.0',Str_s1_2)+','; // s1  s1 ������ǰ����
               Str_temp:=Str_temp+FormatFloat('0.0',s1*(1+0.5*(Jinchi-self.S_L_qx)/self.S_L_qx)*(1-sin(self.S_qj/180*3.14159)))+';'; // s1  ��˳�۴�


               Str_temp:=Str_temp+FormatFloat('0.0',self.ZCYL_sx[0])+','; //Sx ���ĸ���   �����۴�
               Str_temp:=Str_temp+FormatFloat('0.0',self.ZCYL_sx[1]*(1+0.5*(Jinchi-self.S_L_qx)/self.S_L_qx))+','; //Sx ���ĸ���   ��˳�۴�
               Str_temp:=Str_temp+FormatFloat('0.0',self.ZCYL_sx[2])+','; //Sx ���ĸ���   ������ǰ����
               Str_temp:=Str_temp+FormatFloat('0.0',self.ZCYL_sx[3]*(1+0.5*(Jinchi-self.S_L_qx)/self.S_L_qx))+';'; //Sx ���ĸ���   ��˳�۴�
               Result:=Str_temp;
         end else if Version='2.0' then  begin     //�����ۺ�����
               Str_temp:=FormatFloat('0.00',K1)+';';    //k1
               Str_temp:=Str_temp+FormatFloat('0.0',s0)+';';  //s0
               Str_temp:=Str_temp+FormatFloat('0.00',k2)+';';  //s0
               Str_temp:=Str_temp+FormatFloat('0.0',s1)+';';  //s0
               Str_temp:=Str_temp+FormatFloat('0.0',self.ZCYL_sx[0])+';';  //sx
               Result:=Str_temp;
         end else if Version='4.0' then  begin     //�����ۺ�����
             Str_temp:='��Ӧ������ֵ��'+FormatFloat('0.00',K1)+'��';    //k1
             Str_temp:=Str_temp+'��Ӧ������Χ��'+FormatFloat('0.0',s0)+'�ף�';  //s0
             Str_temp:=Str_temp+'��Ӧ������ֵ��'+FormatFloat('0.00',k2)+'��';  //k2
             Str_temp:=Str_temp+'��Ӧ������Χ����ú�ھ��룺'+FormatFloat('0.0',s1)+'�ף�';  //s1
             Str_temp:=Str_temp+'��Ӧ������Χ��'+FormatFloat('0.0',self.ZCYL_sx[0]* JinChi/self.S_L_qx)+'�ס�';  //sx
             Result:=Str_temp;
         end;   //end if Version='1.0' then begin
end else begin
        K1:=0.8;     // ��Ӧ������ֵ��С
        s0:=self.ZCYL_s0;      // ��Ӧ������Χ
        K2:= 1+ JinChi*JinChi*0.5*0.5/self.S_mcsd_h;  //��Ӧ�����ķ�ֵ
        S1:=self.ZCYL_s1[2];      // ��Ӧ������Χ
        if K2>2.5 then  K2:=2.5;   //���ֵǿ��
        if Version='1.0' then begin
               Str_s1_2:=0;
               Str_temp:=FormatFloat('0.0',K1)+';';   // k1
               Str_temp:=Str_temp+FormatFloat('0.00',K2)+';'; // k2
               Str_temp:=Str_temp+FormatFloat('0.0',s0)+','; // so �����ۺ�
               Str_temp:=Str_temp+FormatFloat('0.0',s0*(1.5)*(1+sin(self.S_qj/180*3.14159)))+','; // so  ��˳�۴�
               //�жϳ�����ѹ����
               if JinChi<zk.Yc_Rock[zk.main_coal-1].Step0-s0 then begin
                    Str_temp:=Str_temp+'0,'; // s0  ������ǰ����
                    Str_s1_2:=s0+s1;  // s1 ������ǰ����
                end else if JinChi<=zk.Yc_Rock[zk.main_coal-1].Step0 then begin
                    Str_temp:=Str_temp+'0,'; // s0  ������ǰ����
                    Str_s1_2:=s0+s1-(JinChi-zk.Yc_Rock[zk.main_coal-1].Step0 );  // s1 ������ǰ����
               end;  //end   if JinChi<zk.Yc_Rock[zk.main_coal-1].Step0-s0 then begin

              JinC_sul:=JinChi-zk.Yc_Rock[zk.main_coal-1].Step0;
               while JinC_sul>0 do   begin
                        if JinC_sul<zk.Yc_Rock[zk.main_coal-1].Step0*0.3-s0 then begin
                              Str_temp:=Str_temp+'0,'; // s0  ������ǰ����
                              Str_s1_2:=s0+s1;  // s1 ������ǰ����
                           end else if JinC_sul<=zk.Yc_Rock[zk.main_coal-1].Step0*0.3 then begin
                              Str_temp:=Str_temp+'0,'; // s0  ������ǰ����
                              Str_s1_2:=s0+s1-(JinC_sul-zk.Yc_Rock[zk.main_coal-1].Step0*0.3 );  // s1 ������ǰ����

                         end;  //end  if JinC_sul<zk.Yc_Rock[zk.main_coal-1].Step0*0.3-s0 then begin
                         JinC_sul:=JinC_sul-zk.Yc_Rock[zk.main_coal-1].Step0*0.3;

               end;  //end while do

               Str_temp:=Str_temp+FormatFloat('0.0',s0*(1.5)*(1-sin(self.S_qj/180*3.14159)))+';'; // s0  ��˳�۴�

               Str_temp:=Str_temp+FormatFloat('0.0',s1)+','; // s1 �����ۺ�
               Str_temp:=Str_temp+FormatFloat('0.0',s1*(1.5)*(1+sin(self.S_qj/180*3.14159)))+','; // s1  ��˳�۴�
               Str_temp:=Str_temp+FormatFloat('0.0',Str_s1_2)+','; // s1  s1 ������ǰ����
               Str_temp:=Str_temp+FormatFloat('0.0',s1*(1.5)*(1-sin(self.S_qj/180*3.14159)))+';'; // s1  ��˳�۴�


               Str_temp:=Str_temp+FormatFloat('0.0',self.ZCYL_sx[0])+','; //Sx ���ĸ���   �����۴�
               Str_temp:=Str_temp+FormatFloat('0.0',self.ZCYL_sx[1]*1.5)+','; //Sx ���ĸ���   ��˳�۴�
               Str_temp:=Str_temp+FormatFloat('0.0',self.ZCYL_sx[2])+','; //Sx ���ĸ���   ������ǰ����
               Str_temp:=Str_temp+FormatFloat('0.0',self.ZCYL_sx[3]*1.5)+';'; //Sx ���ĸ���   ��˳�۴�
               Result:=Str_temp;
         end else if Version='2.0' then  begin     //�����ۺ�����
               Str_temp:=FormatFloat('0.0',K1)+';';    //k1
               Str_temp:=Str_temp+FormatFloat('0.0',s0)+';';  //s0
               Str_temp:=Str_temp+FormatFloat('0.0',k2)+';';  //s0
               Str_temp:=Str_temp+FormatFloat('0.0',s1)+';';  //s0
               Str_temp:=Str_temp+FormatFloat('0.0',self.ZCYL_sx[0])+';';  //sx
               Result:=Str_temp;
         end else if Version='4.0' then  begin     //�����ۺ�����
             Str_temp:='��Ӧ������ֵ��'+FormatFloat('0.00',K1)+'��';    //k1
             Str_temp:=Str_temp+'��Ӧ������Χ��'+FormatFloat('0.0',s0)+'�ף�';  //s0
             Str_temp:=Str_temp+'��Ӧ������ֵ��'+FormatFloat('0.00',k2)+'��';  //k2
             Str_temp:=Str_temp+'��Ӧ������Χ����ú�ھ��룺'+FormatFloat('0.0',s1)+'�ף�';  //s1
             Str_temp:=Str_temp+'��Ӧ������Χ��'+FormatFloat('0.0',self.ZCYL_sx[0]* JinChi/self.S_L_qx)+'�ס�';  //sx
             Result:=Str_temp;
         end;   //end if Version='1.0' then begin
end;  //end   if gzm.S_Jc_L > mbcsnl_l then  begin

end;

procedure TG_stope.Set_max_min_h(MaxV, MInV: double);
begin
     self.s_max_h:=MaxV;
     self.s_min_h:=MinV;
end;

//--------��ʼ�������
procedure TZk_bore.FreeInitCreateClass;
var
   i:integer;
begin
   for I :=0 to Zk_Yc_Count-1 do
       if Assigned( Yc_Rock[i]) then   FreeAndNil(Yc_Rock[i]); ;

   for I := 0 to 3 do
      if Assigned( Beam_Def[i]) then FreeAndNil(Beam_Def[i]);

   for I := 0 to 3 do
       if Assigned( Beam_step[i]) then FreeAndNil(Beam_step[i]);

end;

function Tzk_bore.Init(S_Zk: WideString; out sEorr: WideString):wordbool;
   var
       yc1,yc2,yc3,yc4 :Str_Dt_array;
       i,Count1,Count2,count3,count4:integer;
       Mc_count:integer;
   begin
       Result:=true;
       //����ԭ����������
       FreeInitCreateClass;

       MC_count:=0;
       try

            yc1:=Public_Basic.split(S_zk,':',Count1);   //��Zk�ı�ʶ��������
            if UpperCase(yc1[0])<>'ZK' then
             begin
               Result:=False;
               sEorr:='��ױ�ͷZK����!';
               Public_Basic.My_WriteLog('Eorr:Init ��ױ�ͷZK����!','[Tzk_bore]');
               exit;
             end;
             //----
             yc2:=Public_Basic.split(yc1[1],';',Count2);   //����׻�����Ϣ���Ҳ���Ϣ������
             yc3:=Public_Basic.split(yc2[0],',',Count3);   //yc3[0]Ϊ��ױ�ţ�yc3[1]Ϊ��׺����Ҳ�Ĳ���

              self.Zk_No:=Public_Basic.StrToInt_lu(yc3[0]);       //  ����ױ�Ÿ�ֵ
              self.Zk_name:=yc3[1];  //��������Ƹ�ֵ
              self.Zk_Yc_Count:=Public_Basic.StrToInt_lu(yc3[2]);  //  ���Ҳ����������ֵ
              if Count3>2 then  begin
                 self.Zk_name:=yc3[1];
                 DelZKHanzi;
              end;

              SetLength(self.Yc_Rock ,self.Zk_Yc_Count+2);  //���¶�����׺��е��Ҳ����
              // �����Ҳ㶯̬����
             for i :=0 to Zk_Yc_Count do
             begin
              if Yc_Rock[i]=nil then
                  Yc_Rock[i]:=TYc_rock.Create;
             end;

            for i :=low(yc2)+1 to high(yc2) do
               begin
                  yc4:=Public_Basic.split(yc2[i],',',Count4);   //���Ҳ�Ļ�������������
                  if high(yc4)<6 then   continue;
                  if i>Zk_Yc_Count then   Zk_Yc_Count:=i;
                  if Yc_Rock[i-1]=nil then   Yc_Rock[i-1]:=TYc_rock.Create;
                    self.Yc_Rock[i-1].Yc_No  :=Public_Basic.StrToInt_lu(yc4[0]);
                    self.Yc_Rock[i-1].R_Name :=Trim(StringReplace(yc4[1],#13#10,'',[]));
                    self.Yc_Rock[i-1].R_h    :=Public_Basic.StrTodouble_lu(yc4[2]);
                    self.Yc_Rock[i-1].R_kyqd :=Public_Basic.StrTodouble_lu(yc4[3]);
                    self.Yc_Rock[i-1].R_klqd :=Public_Basic.StrTodouble_lu(yc4[4]);

                    if Public_Basic.strtoint_lu(yc4[6])=0 then  begin
                          self.Yc_Rock[i-1].R_fchd :=Public_Basic.StrTodouble_lu(yc4[2]);  //������ֲ㣬�ֲ���Ϊ���Ҳ�ĺ��
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
                   if high(yc4)<10 then  continue;
                       self.Yc_Rock[i-1].BmpFile :=yc4[10];
                     //------�����ж�
                       if Yc_Rock[i-1].R_h =0 then    // �ж��Ҳ�ĺ��
                             begin
                                Yc_Rock[i-1].R_h:=2;
                             end;

                      if Yc_Rock[i-1].R_klqd  =0 then    // �ж��Ҳ� ����ǿ��
                             begin
                               Yc_Rock[i-1].R_klqd:=3;
                             end;
                       if Yc_Rock[i-1].R_kyqd =0 then    // �ж��Ҳ� ��ѹǿ��
                             begin
                               Yc_Rock[i-1].R_kyqd:=30;
                             end;
                      if Yc_Rock[i-1].R_r  =0 then    // �ж��Ҳ� ����
                             begin
                               Yc_Rock[i-1].R_r:=2.5;
                             end;

                       //�����Ҳ�Ĳ���  {��ʱ�����Ƿֲ��������������ɲ����е�����}
//                       if Yc_Rock[i-1].R_sffc then begin
//                           Yc_Rock[i-1].Step_Rock(Yc_Rock[i-1].R_fchd ,Yc_Rock[i-1].R_klqd ,Yc_Rock[i-1].R_r );
//                       end else begin
                           Yc_Rock[i-1].Step_Rock(Yc_Rock[i-1].R_h,Yc_Rock[i-1].R_klqd ,Yc_Rock[i-1].R_r );
//

                     yc4:=nil;
               end;   //forѭ������
         except
              Result:=False;
              sEorr:='���ݸ�ʽ��������ϸ�鿴!';
              Public_Basic.My_WriteLog('Eorr:Init ���ݸ�ʽ��������ϸ�鿴!','[Tzk_bore]');
         end;
          //  ������̬����
          for I := 0 to 4 do  begin

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
   end;  //- ������������ǣ�

///-----------------
function TZk_bore.ReturnCxbj(zk: TZk_bore): wideString;
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

//- ������������ǣ�

  //
procedure TZk_bore.DelZKHanzi;
var
  i:integer;
begin
    i:=pos(string('���'),String(Zk_name));
    if i>0 then
      Zk_name:= copy(Zk_name,1,i-1) ;
end;

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
        self.Step0:=sqrt(1000*2*h*rc/r);  // ��һ�β���
         // 1-4 Ϊ4�����ڲ���  0 Ϊ�ȶ�����
         //NextStep(c,i,mc,ms,qs,rs,qj:double):double ;//c ��һ�εĲ��࣬i�ڼ���
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

procedure TYc_Rock.Step_Rock_FC(h, Rc, r: double);
var
    k:integer;
    fc_Step0:Double;
begin
       if r=0 then  r:=25 ;
       fc_Step0:=sqrt(1000*2*h*rc/r);  // ��һ�ηֲ㲽��
         // 1-4 Ϊ4�����ڲ���  0 Ϊ�ȶ�����
      for k := 1 to 4 do          begin
        if k=1 then   begin
            step_fcbu[k]:=Public_Basic.NextStep(fc_Step0,0,0,R_h ,R_klqd,R_r,0);
        end  else  begin
            step_fcbu[k]:=Public_Basic.NextStep(step_fcbu[k-1],k-1,0,R_h ,R_klqd,R_r,0);
        end;
      end ;
      step_fcbu[0]:=fc_Step0*0.4;
end;

end. //end function
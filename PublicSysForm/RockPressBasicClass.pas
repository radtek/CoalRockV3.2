//<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
//<<      �ļ�����RockPressBasicClass                         <<
//<<      luleiʹ�õĸ���Delphi�ļ�                            <<
//<<      ���ļ���Ҫ����Ϊ��ѹ���ݷ���ʹ��
//<<      ��Ҫ�����������ڶ���ʹ��                    <<
//<<      �������ڣ�2018.1010                                   <<
//<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<


unit RockPressBasicClass;
interface

uses
  Windows, SysUtils, Classes, Messages, Controls, Forms, StdCtrls, ExtCtrls,
  ComCtrls,math,IniFiles,Jpeg,Graphics,Dialogs;

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
      BMP_File:String; //   ͼƬ�ļ�����
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
      Sa : array [0..2] of double ;     //  ��¼�����³��� 0 Ϊ��ʼ�³� 1Ϊ �����³���0.95  2 Ϊ �ȶ��³�  0.85
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

   end;

  TBasic_Stop=Class

    private
       List_Cmsf:string;           // 1_�ڲ� 2_�ղ�  3_�۲�(һ�β�ȫ��) 4_�Ŷ�ú 5_�ֲ㿪��(�Ϸֲ�) 6_�ֲ㿪��(�·ֲ�)
       List_mtyd:string;           /// 51ú��Ӳ��,��Ӧ���Ǳ�� 1(0.8);2(0.8-1.5) 3(1.5-2.5) 4(2.5 ����)
       List_yxfx:string;             // 24  1	ˮƽ�ƽ�   		2	��б�ƽ�  3	��б�ƽ�
       List_JYHD	   :string;            // 25   1	������  	2	һ�����   3	�к����     	4	�޺����
       List_DCGZ     :string;            //26 	1	���ʹ������    	2	��б�Ჿ     3	��б�Ჿ   4	�ϲ��ܼ�������Ӱ���ƽ�   5	�ϲ��ܼ���Ӱ���ƽ�  6	���켫�临��
       List_WSFC	   :string;            // 27   1	��˹�����ϵ�   	2	����˹���ֲ�����  3	����˹
       List_TopWater :string;            // 28  	1	������ˮ  	2	��ˮ����붥���Զ  	3	��ˮ����붥��Ͻ�   4	������͸ˮ�¹�   	5	����
       List_BottomWater: string;          // 29 	1	�װ���ˮԴ   2	�װ���ˮԴ����Զ  3	�װ���ˮԴ���Ͻ�   4	�������װ�ͻ���¹�    5	����
       List_HeoStress	:string;           //  30  1	������ˮƽӦ��  2	ˮƽӦ��С�ڴ�ֱӦ��  3	ˮƽӦ���봹ֱӦ���൱  4	ˮƽӦ�����ڴ�ֱӦ��1.5������
       List_Kyxx       :string;          // 31  	1	��ѹ���ֲ�����   2	�п�ѹ���֣���Ӱ������  3	��ѹ���ֽϾ��ң�Ӱ����  4	�����������¹�
       List_HangDaoSup :string;         // 	32	�����������Ҫ֧��  	2	�����ê��֧��   3	�������֧��������������  	4	������Σ��׹ģ���ȫӰ��С  5	������ٱ��Σ��׹ģ�����Ӱ�찲ȫ
       List_Zhqk      : string;       // 52 ֧����� 1  ����֧��  2 �۲�֧��

    public
       procedure InitListString;

       constructor Create;
       destructor Destroy;
  End;
  //���幤������ TG_stope
  TG_stope =class(TBasic_Stop)
       public
        S_Name   :WideString;         //  1����������
        S_No     :WideString;         // 2 ��������
        S_mc_name:WideString;         // 3 ����ú��id  ����ú����
        S_Cg_h   :double;             // 4 ������ɸ�
        S_cmfs   :WideString;         // 5 ��ú��ʽ
        S_Fm_h   :double;             // 6 ��ú�߶�
        S_qj     :double;             // 7 ú�����
        S_mcsd_h :double;             // 8 ������
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
        S_AGV_MCH    :double;        //50 ú��ƽ�����
        S_Mtyd       :Integer;         // 51ú��Ӳ��,��Ӧ���Ǳ�� 1(0.8);2(0.8-1.5) 3(1.5-2.5) 4(2.5 ����)
        DZ_Zhqk      : integer;       // 52 ֧����� 1  ����֧��  2 �۲�֧��
        S_CMFS_INteger: integer;     //53��ú����  �����ֱ�ʾ 1_�ڲ� 2_�ղ�  3_�۲�(һ�β�ȫ��) 4_�Ŷ�ú 5_�ֲ㿪��(�Ϸֲ�) 6_�ֲ㿪��(�·ֲ�)
        ZjName        : string;     //���� ֧�����ƣ�����û�а�֧�ܵĹ���ʹ��


       //2018 property
       gzm_b,gzm_k,gzm_d:String; // �������Կ���б�

       procedure initFiledListName;

       constructor Create;
       destructor Destroy;

      end;

   //����ֱ�Ӷ� ��
    TImmediate_roof=class
      Public
          Start_No  :integer;   //    ֱ�Ӷ���ʼ �Ҳ������±�
          End_No    :integer;    //   ֱ�Ӷ����� �Ҳ������±�
          Surplus_h :double;     //   �ֲ���ʣ��߶�
          Immroof_M  :double;   //    ֱ�Ӷ����ۻ��߶�
          Immroof_C0  :double;   //   ֱ�Ӷ��ĳ�����ѹ����
          is_init     :bool;      //  ֱ�Ӷ��Ƿ��ʼ��
          Imm_leibie      :Integer;//  ֱ�Ӷ����
          FDm_leibie      :Integer;//��úð�������
        end;

  //�����϶���
  TOld_roof=class
      public
        YL_struc: integer;//����϶��Ľṹ�� 1 Ϊ��������2 Ϊ������
        YL_start :integer;    //  �϶���ʼ�Ҳ�
        yl_max_End : integer;  //�϶��������Ҳ�
        YL_min_End   :integer;    //  �϶���С�����Ҳ�
        YL_max_m     :double;     //  �϶����߶�
        YL_min_m     :double;     //  �϶���С�߶�
        YL_First_step     : array[0..2] of double;    //������ѹ����  0 Ϊ���ֵ��1Ϊ��Сֵ��2Ϊƽ��ֵ
        YL_Zhouqi_step    : array[0..2] of double;    //������ѹ����  0 Ϊ���ֵ��1Ϊ��Сֵ��2Ϊƽ��ֵ
        is_init      :bool;
        Old_leibie       :Integer; // �϶����
        diban_leobie     :Integer; //�װ����

      end;
   // //����֧����
  TZJ_Class=class
      public
         Zj_Name: WideString;    //֧�ܵ�����
         ZJ_Tu_Bianhao:widestring; //֧��ͼ�����
         Zj_BianHao:WideString;  //֧�ܵı��
         Zj_XingHao:WideString;   //֧�ܵ��ͺ�
         Zj_leixing:WideString;   //֧�ܵ��ͺ�
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
         //Zj_Lz_Diameter:double; //������ֱ��


  end;


   TSupportStep =Class(TZj_Class)
        Lz_Diameter  :double;//������ֱ��������ʹ�õģ�
        SupportBh:integer;//   ֧�ܵı�� �� Zj_BianHao һ��
        initLoad:double; //    ֧�ܳ�ʼ֧��ǿ�� ����Ҳ�г�����
        EndOpenLoad: double; // ֧��Һѹ������ʱǿ��
   End;


implementation

{ TSupportStep }




{ TBasic_Stop }

constructor TBasic_Stop.Create;
begin
   InitListString ;
end;

destructor TBasic_Stop.Destroy;
begin

end;



procedure TBasic_Stop.InitListString;
begin
      // 1_�ڲ� 2_�ղ�  3_�۲�(һ�β�ȫ��) 4_�Ŷ�ú 5_�ֲ㿪��(�Ϸֲ�) 6_�ֲ㿪��(�·ֲ�)
       List_Cmsf:='�ڲ�,�ղ�,�۲�(һ�β�ȫ��),�Ŷ�ú,�ֲ㿪��(�Ϸֲ�),�ֲ㿪��(�·ֲ�)';
      /// 51ú��Ӳ��,��Ӧ���Ǳ�� 1(0.8);2(0.8-1.5) 3(1.5-2.5) 4(2.5 ����)
       List_mtyd:='0.8����,0.8-1.5,1.5-2.5,2.5����';
       // 24  1	ˮƽ�ƽ�   		2	��б�ƽ�  3	��б�ƽ�
       List_yxfx:='ˮƽ�ƽ�,��б�ƽ�,��б�ƽ�';
        // 25   1	������  	2	һ�����   3	�к����     	4	�޺����
       List_JYHD:='������,һ�����,�к����,�޺����';
       //26 	1	���ʹ������    	2	��б�Ჿ     3	��б�Ჿ   4	�ϲ��ܼ�������Ӱ���ƽ�   5	�ϲ��ܼ���Ӱ���ƽ�  6	���켫�临��
       List_DCGZ :='���ʹ������,��б�Ჿ,��б�Ჿ,�ϲ��ܼ�������Ӱ���ƽ�,�ϲ��ܼ���Ӱ���ƽ�,���켫�临��';
       // 27   1	��˹�����ϵ�   	2	����˹���ֲ�����  3	����˹
       List_WSFC:='��˹�����ϵ�,����˹���ֲ�����,����˹';
         // 28  	1	������ˮ  	2	��ˮ����붥���Զ  	3	��ˮ����붥��Ͻ�   4	������͸ˮ�¹�   	5	����
       List_TopWater :='������ˮ,��ˮ����붥���Զ,��ˮ����붥��Ͻ�,������͸ˮ�¹�,����';
         // 29 	1	�װ���ˮԴ   2	�װ���ˮԴ����Զ  3	�װ���ˮԴ���Ͻ�   4	�������װ�ͻ���¹�    5	����
       List_BottomWater:='�װ���ˮԴ,�װ���ˮԴ����Զ,�װ���ˮԴ���Ͻ�,�������װ�ͻ���¹�,����';
        //  30  1	������ˮƽӦ��  2	ˮƽӦ��С�ڴ�ֱӦ��  3	ˮƽӦ���봹ֱӦ���൱  4	ˮƽӦ�����ڴ�ֱӦ��1.5������
       List_HeoStress	:='������ˮƽӦ��,ˮƽӦ��С�ڴ�ֱӦ��,ˮƽӦ���봹ֱӦ���൱,ˮƽӦ�����ڴ�ֱӦ��1.5������';
         // 31  	1	��ѹ���ֲ�����   2	�п�ѹ���֣���Ӱ������  3	��ѹ���ֽϾ��ң�Ӱ����  4	�����������¹�
       List_Kyxx :='��ѹ���ֲ�����,�п�ѹ���֣���Ӱ������,��ѹ���ֽϾ��ң�Ӱ������,�����������¹�';
        // 	32	�����������Ҫ֧��  	2	�����ê��֧��   3	�������֧��������������  	4	������Σ��׹ģ���ȫӰ��С  5	������ٱ��Σ��׹ģ�����Ӱ�찲ȫ
       List_HangDaoSup:='�����������Ҫ֧��,�����ê��֧��,�������֧��������������,������Σ��׹ģ���ȫӰ��С,������ٱ��Σ��׹ģ�����Ӱ�찲ȫ';
        // 52 ֧����� 1  ����֧��  2 �۲�֧��
       List_Zhqk:='����֧��,�۲�֧��,�Ŷ�ú֧��';

end;

{ TG_stope }

constructor TG_stope.Create;
begin
  inherited;
  initFiledListName;
end;

destructor TG_stope.Destroy;
 var
  i:integer;
begin

  inherited;
end;

procedure TG_stope.initFiledListName;
begin
  gzm_b:='0,s_name,����������,edit,1,,string;'    //  S_Name   :WideString; 1����������
         +'0,S_mcsd_h,�����濪�����,edit,1,,double;'    //  8 ������
         +'0,S_qj,���������,edit,1,,double;'    // 7 ú�����
         +'0,S_L_qx,��������б����,edit,1,,double;'    // 9 ��������б��
         +'0,S_Sx_zx,�������ƽ�����,edit,1,,double;'    //10 ����������
         + '' ;
 gzm_k:= '0,S_Cg_h,�ɸ߸߶�,edit,1,,double;'    //  S_Cg_h   :double;  // 4 ������ɸ�
        +'0,S_CMFS_INteger,��ú����,list,1,list_cmfs,integer;'    //  S_CMFS_INteger: integer;     //53��ú����
        +'0,DZ_Zhqk,֧������,list,1,List_Zhqk,integer;'    //   List_Zhqk:='����֧��,�۲�֧��,�Ŷ�ú֧��';
        +'0,S_Jc_L,�ۼƽ���,edit,1,,double;'    //  11 �������ۼƽ���
        +'0,S_Mtyd,ú��Ӳ��,list,1,list_mtyd,integer;'    // 12  ú�������ϵ��
        +'0,S_M_mcj,��ú����Ħ����,edit,1,,double;'    //  13  ú�����Ħ����
        +'0,S_M_njl,��ú���ھ���,edit,1,,double;'    // 14  ú����ھ���
        +'0,S_Bsb,��ú�����ɱ�,edit,1,,double;'    // 15  ý��Ĳ��ɱ�

        + '' ;
 gzm_d:= '0,Dz_yxfx,��б/��б�ƽ�,list,1,List_yxfx,integer;'    //   24  1	ˮƽ�ƽ�   		2	��б�ƽ�  3	��б�ƽ�
       + '0,Dz_JYHD,�ϸ��Ҳ����״��,list,1,List_JYHD,integer;'  //  Dz_JYHD	   :integer;            // 25   1	������  	2	һ�����   3	�к����     	4	�޺����
       + '0,Dz_DCGZ,��������ʹ���,list,1,List_DCGZ,integer;'  //   Dz_DCGZ     :integer;            //26 	1	���ʹ������    	2	��б�Ჿ     3
       + '0,Dz_WSFC,��������˹����״��,list,1,List_WSFC,integer;'  //  Dz_WSFC	   :integer;            // 27   1	��˹�����ϵ�   	2	����˹
      + '0,Dz_TopWater,�����涥��ˮԴ״��,list,1,List_TopWater,integer;'  //  Dz_TopWater :integer;            // 28  	1	������ˮ  	2	��ˮ����붥���Զ
      + '0,Dz_BottomWater,������װ�ˮԴ״��,list,1,List_BottomWater,integer;'  //   Dz_BottomWater: Integer;          // 29 	1	�װ���ˮԴ   2	�װ���ˮԴ
      + '0,Dz_HeoStress,���ˮƽӦ���봹ֱӦ��,list,1,List_HeoStress,integer;'  //    Dz_HeoStress	:integer;           //  30  1	������ˮƽӦ��
      + '0,Dz_Kyxx,�ò�����ѹ����״��,list,1,List_Kyxx,integer;'  //   Dz_Kyxx       :Integer;          // 31  	1	��ѹ���ֲ�����   2	�п�ѹ���֣���Ӱ����
      + '0,Dz_HangDaoSup,������ú��֧����ʽ,list,1,List_HangDaoSup,integer;'  //   Dz_HangDaoSup :integer;          //32   	1	�����������Ҫ֧��  	2	�����
      +'';


end;


end.
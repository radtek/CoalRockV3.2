unit ImmediateClass;

interface

uses
  Windows, SysUtils, Classes, Messages, Controls, Forms, StdCtrls, ExtCtrls,
  ComCtrls,math,IniFiles,Jpeg,Graphics,Dialogs,Lu_Public_BasicModual
  ,WorKFaceClass
  ;

type
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


implementation

{ TImmediate_roof }

function TImmediate_roof.Cal_beam(S_gzm: TG_stope; s_zk: TZk_bore;
  out sEorr: widestring): wordbool;
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

end;

function TImmediate_roof.Cal_Immediate_roof(S_gzm: TG_stope; s_zk: TZk_bore;
  safe_h: double; out sEorr: widestring): wordbool;
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

function TImmediate_roof.Get_Parameter(zk: Tzk_bore;
  Version: widestring): wideString;
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

function TImmediate_roof.Get_YC_Png(zk: Tzk_bore; s_gzm: TG_stope;
  t_imm: Timmediate_roof; JinChi: double): wideString;
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

function TImmediate_roof.init(s_gzm: TG_stope; s_zk: TZk_bore; safe_h: double;
  out sEorr: widestring): wordbool;
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

end;

{ TOld_roof }

function TOld_roof.Get_Parameter(s_gzm: TG_stope; zk: Tzk_bore;
  t_imm: Timmediate_roof; Version: Widestring): WideString;
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
end;

function TOld_roof.init(s_gzm: TG_stope; s_zk: TZk_bore; t_imm: Timmediate_roof;
  out sEorr: WideString): wordbool;
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
end;

function TOld_roof.Return_C0(zk: Tzk_bore): wideString;
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

       // Cal_Ldg(zk,s_gzm,t_imm,self,gzmjc,S_out);
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



end.

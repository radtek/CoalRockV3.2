unit PStope_DealWith;

interface


uses
  Windows, SysUtils, Classes, Messages, Controls, Forms, StdCtrls, ExtCtrls,
  ComCtrls,math,IniFiles,Jpeg,Graphics,Dialogs,Lu_Public_BasicModual
  ,PStope_WorKFace,PStope_Immediate,PStope_SupportClass
  ;


type
   TPStope_DealWith=Class

    public
        function Cal_Zcyl(zk:Tzk_bore;imm:TImmediate_roof;gzm:TG_stope;old_r:Told_roof;out S_zcyl: wideString):wordbool;
    // 计算裂断拱的边界
        function Cal_Ldg(zk:Tzk_bore;gzm:TG_stope;imm:TImmediate_roof;old_r:Told_roof;gzmjc:double;out S_ldg:widestring):wordbool;
    //  覆岩运动规律导出
        function Return_Fyyd(gzm:TG_Stope;Zk:Tzk_bore;imm:TImmediate_roof;old:Told_roof):WideString;
   End;

//var
//  PS_DealWith:TPStope_DealWith;

implementation

{ TPStope_DealWith }

function TPStope_DealWith.Cal_Ldg(zk: Tzk_bore; gzm: TG_stope;
  imm: TImmediate_roof; old_r: Told_roof; gzmjc: double;
  out S_ldg: widestring): wordbool;
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

function TPStope_DealWith.Cal_Zcyl(zk: Tzk_bore; imm: TImmediate_roof;
  gzm: TG_stope; old_r: Told_roof; out S_zcyl: wideString): wordbool;
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

end;

function TPStope_DealWith.Return_Fyyd(gzm: TG_Stope; Zk: Tzk_bore;
  imm: TImmediate_roof; old: Told_roof): WideString;
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

end.

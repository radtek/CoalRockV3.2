unit Pstope_ShowWindows;

interface
uses
  Windows, SysUtils, Classes, Messages, Controls, Forms, StdCtrls, ExtCtrls,
  ComCtrls,math,IniFiles,Jpeg,Graphics,Dialogs,Lu_Public_BasicModual
  ,PStope_WorKFace,PStope_Immediate,PStope_SupportClass
  ;

type

  TDrawDTFZ_Record=class
       Y_text_H,Y_text_bl :double;     //　Y 方向文字高度  与比例
       Y_tu_H,Y_tu_Bl :double;     //  Ｙ 方向图形高度  与比例
       Total_Image_H,Use_Tu_H,Use_Text_H:double;   // Y方向使用的高度
       X_wid,X_bl: double; // x 方向的总宽度 与比例
       ShiYong_bl:double; //画图中使用的比例
     //  i,j,k     :integer;   //  临时变量
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
       //是否因为放大岩层强制退出
       ZoomExit:Boolean;    // 是否强制退出
       ExitNextYcid:integer;// 强制退出的下一层岩层的编号

        constructor Create;
        destructor Destroy;override;
  end;
  //
  // //定义计算域显示的类别
  TDraw_init= Class

     private
        pDrawRecord:TDrawDTFZ_Record;

       //外部使用
        Zomm_D: double; //1 图像显示比例
        model_l:integer; //  2 岩层显示的开始层数  0 全部  1  缓沉带下部  2 1-2 个岩梁
        model_start_yc: integer; // 3 模拟岩层开始的层数
        hcd_bl: double; //  4 缓沉带显示比例
       //-----
       EX_Image:TImage;
       JinChi,X_pan_move:double;
       Tuxing,disp_two_tu,disp_ylg:integer;
       NQ_step:String;
       gzm:TG_stope;
       Zk:Tzk_bore;
       ZhiJia:TZJ_Class;
       imm:TImmediate_roof;
       old:Told_roof;
       // procedure
       procedure Draw_BasicInit; // 1
         procedure First_initImage(); //初始化image变量   1- 1
         procedure First_Maketitle(DefOrStep:string); //定制标题 1-  2
         procedure First_BeamStruct();   //1-3
         procedure First_CountZK_H();  // 1-4 计算岩梁高度
         procedure first_ImageBlank();  //1-5  计算图形的基本边界与基本参数
         procedure DrawBottomFloor;  // 1-6 画底板
         procedure DrawCoalRock_Left;//1-7 画左侧煤层
         procedure DrawCoalRock_Right;//1-10 画右侧煤层
         procedure DrawCoalSupport;// 1-8 画支架
         procedure MoveScreen;// 1-9 移动屏幕坐标
       procedure Draw_Imm_Rock;// 2 上覆岩层运动 直接顶 步距模拟
         Procedure Draw_RockNameAndThreeBord(tu_Y,Text_Y:integer;Ycid:integer);// 画岩层的斜面
         procedure Draw_RockName_xieMian;// 2-1 绘制岩层柱状与斜面
         procedure Draw_Top_Coal; //2-2 绘制顶煤
         procedure Draw_imm_Main; //2-3 直接顶的引导
         procedure Draw_Imm_Left; // 2-3-1 左侧第一次来用直接顶
         procedure Draw_Imm_Rigth; // 2-3-2 右侧第一次来用直接顶
         procedure Draw_Imm_second_Left; // 2-3-3 左侧多次来压直接顶
         procedure Draw_Imm_Second_Rigth; // 2-3-4 右侧多次来压直接顶
         procedure Draw_Imm_NeverMove_Rock(YcId:integer);// 2-3-5 直接顶下 在当前推进进尺下 不动的岩层
       procedure Draw_Old_Rock;// 3 上覆岩层运动 老顶 步距模拟
         procedure Draw_Old_Left(YcId:integer); // 3-1  左侧老顶
         procedure Draw_Old_Left_LastRock(YcId:integer); // 3-1-1  左侧老顶 最后一层岩层
         procedure Draw_Old_Left_First(YcId:integer); // 3-1-2  左侧老顶 第一块
         procedure Draw_Old_Left_Two(YcId:integer); // 3-1-3  左侧老顶 第二块
         procedure Draw_Old_Left_Two_Basic(YcId:integer); // 3-1-3 -1 左侧老顶 第二块  基本信息
         procedure Draw_Old_Left_Two_FirstComePress(YcId:integer); // 3-1-3 -2 第一次来压步距结束
         procedure Draw_Old_Left_Two_FirstComePress_Last(YcId:integer;var YKid:integer); // 3-1-3 -2 -1 老顶周期来最后一块
         procedure Draw_Old_Left_Two_FirstComePress_Prev(YcId:integer;var YKid:integer); // 3-1-3 -2-2  老顶周期来前面N 块
         procedure Draw_Old_Left_Two_FirstComePress_Prev_Second(YcId:integer;var YKid:integer); // 3-1-3 -2-2 -1 老顶周期来前面N 块  第二块
         procedure Draw_Old_Left_Two_FirstComePress_Prev_Other(YcId:integer;var YKid:integer); // 3-1-3 -2-2 -2 老顶周期来前面N 块  第二块
         //
         procedure Draw_old_Two(YcId:integer); // 3-2  老顶周期第二块
         procedure Draw_old_Two_left(YcId:integer); // 3-2-1  老顶周期第二块 左侧
         procedure Draw_old_Two_Right(YcId:integer); // 3-2-2  老顶周期第二块 右侧
         //
         procedure Draw_Old_NeverMoveRock(YcId:integer); // 3-3 当前条件下不动的岩层
        procedure Draw_Ganshi;// 4 绘制矸石
        Procedure Draw_SanWei_Waike(pt1,pt2:TPoint);// 画三维的立体外壳
        procedure Fill_Image(Image_i:Timage;Px,Py:integer;Pt_Arry:Array of TPoint);// 给封闭的图形进行填充



      procedure CopyImage_TuToOut; //Last
      procedure SetZoom(Value:double);
      function GetZoom:double;
      function Set_Tu_H(Value:integer):double;
      function Set_Text_H(Value:integer):Double;
      procedure FillLastRockThreeAngleArea(Ycid:integer);


     public
       // 用类来表达
        procedure SetDrawClassDcFZ(Image:TImage);
        procedure SetDrawClass_canshu(JChi,X_pan:double;Tu,disp_two,ylg:integer;NQstep:String);
        procedure SetDrawZhulei(tgzm:TG_stope;tZk:Tzk_bore;tZhiJia:TZJ_Class;timm:TImmediate_roof;told:Told_roof);
        function DrawZcyl(Image:TImage;P1,P2:TPoint;zcyl:Str_Dt_array;bl:double;left_right:bool):WordBool;

        property Zoom:double read GetZoom write SetZoom;
        // 外部image  进尺   X 平移   图例   挠曲还是 步距
        function Draw_YLG(Image:TImage;L1,L2,R1,R2:TStringList):WordBool;// 画支撑压力平衡拱
        function  DrawFyydDtfz_main:integer;
        procedure setMoveStart(Value:double);

        constructor Create;
        destructor Destroy;override;
  End;

  TCal_Show=class(TDraw_init)

      private

      public
       // Zomm_D: double; //1 图像显示比例
        model_l:integer; //  2 岩层显示的开始层数  0 全部  1  缓沉带下部  2 1-2 个岩梁
        model_start_yc: integer; // 3 模拟岩层开始的层数
        hcd_bl: double; //  4 缓沉带显示比例


        constructor Create;
        destructor Destroy;override;
  end;

implementation

{ TCal_Show }

uses Main_PStope;

constructor TCal_Show.Create;
begin
   inherited;
   Zomm_D:=1.0;
end;

destructor TCal_Show.Destroy;
begin


  inherited;
end;

function TDraw_init.DrawZcyl(Image: TImage; P1, P2: TPoint; zcyl: Str_Dt_array;
  bl: double; left_right: bool): WordBool;
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

function TDraw_init.Draw_YLG(Image: TImage; L1, L2, R1,
  R2: TStringList): WordBool;
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

{ TDraw_init }

procedure TDraw_init.FillLastRockThreeAngleArea( Ycid: integer);
begin
     with pDrawRecord do begin
         // 右侧立体三角
         Pointxy[3].X := Ex_Image.Width -RightBlank;
         Pointxy[3].Y := Ex_Image.Height-BottomBlank-X_Text_height-trunc(Set_TU_H(0));
         Pointxy[2].X := Pointxy[3].X ;
         Pointxy[2].Y := Pointxy[3].Y ;

         Pointxy[0].X := Pointxy[3].X ;
         Pointxy[0].Y := Pointxy[3].Y-40;
         Pointxy[1].X := Pointxy[3].X+40 ;
         Pointxy[1].Y := Pointxy[3].Y-40 ;

         bitmap.FreeImage;
         ExPstopeClass.MySqliteTable.GetBMPToSQlite(zk.Yc_Rock[Ycid].BmpFile+'.Bmp',IntToStr(Tuxing+1),bitmap);
         Ex_Image.Canvas.Brush.Bitmap:=nil;
         Ex_Image.Canvas.Polygon(Pointxy) ;
         Ex_Image.Canvas.Brush.Bitmap:=bitmap;
         if   (Pointxy[2].Y-Pointxy[1].Y>2)  then
             Ex_Image.Canvas.FloodFill(Trunc(Pointxy[0].X+2),Trunc((Pointxy[0].Y+Pointxy[3].Y)/2),clBlack,fsBorder);

     end;
end;

procedure TDraw_init.Fill_Image(Image_i: Timage; Px, Py:integer;Pt_Arry:Array of TPoint);
var
  while_image:Boolean;
  K:integer;
begin
   while_image:=true;
   k:=0;
   while while_image  do begin
        if Public_Basic.IsPtInPoly (px,py,Pt_Arry) then begin
           Image_i.Canvas.FloodFill(px ,py,clBlack,fsBorder);
           while_image:=false;
        end else begin
            inc(K);
            if K=1 then  begin
               px:=px+1;
               Py:=Py;
            end else if K=2 then  begin
               px:=px;
               Py:=Py-1;
            end else if K=3 then  begin
               px:=px-1;
               Py:=Py;
            end else if K=4 then  begin
               px:=px;
               Py:=Py+1;
            end else begin
               while_image:=false;
            end;
        end;

   end;   //end while

end;

procedure TDraw_init.First_BeamStruct;
var
  k:integer;
begin
    //判断岩梁的高度
  with pDrawRecord do begin
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
  end;
end;

procedure TDraw_init.First_CountZK_H;
var
  i:integer;
begin
 with pDrawRecord do begin
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
          if Ex_Image.Height-TopBlank-BottomBlank-X_Text_height-40-Table_Title_H-(Yl_name_count)*HanziHeight< 0 then  begin
              HanziHeight:=HanziHeight-1;
          end else begin
              while_j:=false;
          end;

      end;
 end;
end;



procedure TDraw_init.CopyImage_TuToOut;
begin
  with pDrawRecord do begin
//      StretchBlt(Ex_Image.Canvas.Handle,LeftBlank+1,topBlank+1,Ex_Image.Width-RightBlank-leftBlank-1,
//                 Ex_Image.Height-BottomBlank-TopBlank-1,Image_inn.Canvas.Handle,X_move_pix,
//                 1,Image_inn.Width-RightBlank-LeftBlank-1,Image_inn.Height-1,SRCCOPY);
      bitblt(Ex_Image.Canvas.Handle,LeftBlank+1,topBlank+1,Ex_Image.Width-RightBlank-leftBlank-1,
                 Ex_Image.Height-BottomBlank-TopBlank-1,Image_inn.Canvas.Handle,X_move_pix,
                 1,SRCCOPY);
        // 左侧立体三角
       Pointxy[3].X := LeftBlank;
       Pointxy[3].Y := Ex_Image.Height-BottomBlank-X_Text_height-trunc(Set_TU_H(0));
       Pointxy[2].X := Pointxy[3].X ;
       Pointxy[2].Y := Pointxy[3].Y ;

       Pointxy[0].X := Pointxy[3].X ;
       Pointxy[0].Y := Pointxy[3].Y-40;
       Pointxy[1].X := Pointxy[3].X+40 ;
       Pointxy[1].Y := Pointxy[3].Y-40 ;

       bitmap.FreeImage;
       Ex_Image.Canvas.Brush.Bitmap:=nil;
       //Ex_Image.Canvas.Pen.Color :=clwhite;
       Ex_Image.Canvas.Polygon(Pointxy) ;
      // Ex_Image.Canvas.Brush.Bitmap:=bitmap;
       if   (Pointxy[2].Y-Pointxy[1].Y>2)  then
           Ex_Image.Canvas.FloodFill(Trunc(Pointxy[0].X+2),Trunc((Pointxy[0].Y+Pointxy[3].Y)/2),clBlack,fsBorder);
       Ex_Image.Canvas.Pen.Color :=clBlack;
  end;
end;

constructor TDraw_init.Create;
begin
   if not Assigned(pDrawRecord) then
     pDrawRecord:=TDrawDTFZ_Record.Create ;
   Zomm_D:=1.0;
end;

destructor TDraw_init.Destroy;
begin
  if Assigned(pDrawRecord) then
      FreeAndNil(pDrawRecord);
  inherited;
end;

procedure TDraw_init.DrawBottomFloor;
{//画底板  }
var
  i,JinchiFlag,dvi_zoom:integer;
begin
     with pDrawRecord do begin
         Image_inn.Width :=tu_max_width*3;
         Image_inn.Height :=Ex_Image.Height-topBlank-BottomBlank;
         Image_inn.Picture.Graphic:=nil;
         Image_inn.Canvas.Refresh;
         Image_inn.Canvas.FillRect(Image_inn.ClientRect);

         Image_inn.Canvas.Pen.Color :=clBlack;
         Image_inn.Canvas.MoveTo(0,Image_inn.Height);  // 横轴
         Image_inn.Canvas.LineTo(Image_inn.Width ,Image_inn.Height);

        //剖分支承压力 数值
         temp1:=public_Basic.split(Gzm.Return_Zcyl('2.0',Jinchi,zk),';',Count1);

        bitmap.FreeImage ;
        if  zk.main_coal=zk.Zk_Yc_Count-1  then  begin // 没有底板
            Pointxy[0].X :=0;
            Pointxy[0].Y :=Image_inn.Height-X_Text_height-trunc(3*shiyong_bl);
            Pointxy[1].X :=Image_inn.Width;
            Pointxy[1].Y :=Pointxy[0].Y;
            Pointxy[2].X :=Pointxy[1].X  ;
            Pointxy[2].Y :=Image_inn.Height-X_Text_height;
            Pointxy[3].X :=Pointxy[0].X ;
            Pointxy[3].Y :=Pointxy[2].Y ;
            Ex_Image.Canvas.MoveTo(LeftBlank-120,trunc(Ex_Image.Height-BottomBlank-X_Text_height-hanziheight-3*Y_Text_Bl));
            Ex_Image.Canvas.LineTo(LeftBlank-30,trunc(Ex_Image.Height-BottomBlank-X_Text_height-hanziheight-3*Y_Text_Bl));
            Ex_Image.Canvas.TextOut(LeftBlank-118,trunc(Ex_Image.Height-BottomBlank-X_Text_height-hanziheight-3*Y_Text_Bl/2),'粉砂岩');
            Ex_Image.Canvas.TextOut(LeftBlank-58,trunc(Ex_Image.Height-BottomBlank-X_Text_height-hanziheight-3*Y_Text_Bl/2),'3');
            //画斜线
            Ex_Image.Canvas.MoveTo(LeftBlank-30,trunc(Ex_Image.Height-BottomBlank-X_Text_height-hanziheight-3*Y_Text_Bl));
            Ex_Image.Canvas.LineTo(LeftBlank, Ex_Image.Height-BottomBlank-X_Text_height-trunc(3*shiyong_bl));
            out_left_y0:=trunc(Ex_Image.Height-BottomBlank-X_Text_height-hanziheight-3*Y_Text_Bl);
            out_left_y1:= Ex_Image.Height-BottomBlank-X_Text_height-trunc(3*shiyong_bl);
              //给填充附图填充图例
            ExPstopeClass.MySqliteTable.GetBMPToSQlite('fsy.Bmp',IntToStr(Tuxing+1),bitmap);
             // 累计图形高度
            Set_TU_H(trunc(3*shiyong_bl));
            Set_Text_H(Trunc(3*Y_Text_Bl));
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

            Ex_Image.Canvas.MoveTo(LeftBlank-120,trunc(Ex_Image.Height-BottomBlank-X_Text_height-hanziheight-zk.Yc_Rock[zk.main_coal+1].R_h*Y_Text_Bl));
            Ex_Image.Canvas.LineTo(LeftBlank-30,trunc(Ex_Image.Height-BottomBlank-X_Text_height-hanziheight-zk.Yc_Rock[zk.main_coal+1].R_h*Y_Text_Bl));
            Ex_Image.Canvas.TextOut(LeftBlank-118,
                           trunc(Ex_Image.Height-BottomBlank-X_Text_height-hanziheight-zk.Yc_Rock[zk.main_coal+1].R_h*Y_Text_Bl/2),
                           zk.Yc_Rock[zk.main_coal+1].R_Name);
            Ex_Image.Canvas.TextOut(LeftBlank-58,
                           trunc(Ex_Image.Height-BottomBlank-X_Text_height-hanziheight-zk.Yc_Rock[zk.main_coal+1].R_h*Y_Text_Bl/2),
                           FormatFloat('0.0',zk.Yc_Rock[zk.main_coal+1].R_h));
            //画斜线
            Ex_Image.Canvas.MoveTo(LeftBlank-30,trunc(Ex_Image.Height-BottomBlank-X_Text_height-hanziheight-zk.Yc_Rock[zk.main_coal+1].R_h*Y_Text_Bl));
            Ex_Image.Canvas.LineTo(LeftBlank, Ex_Image.Height-BottomBlank-X_Text_height-trunc(zk.Yc_Rock[zk.main_coal+1].R_h*shiyong_bl));
            out_left_y0:=trunc(Ex_Image.Height-BottomBlank-X_Text_height-hanziheight-zk.Yc_Rock[zk.main_coal+1].R_h*Y_Text_Bl);
            out_left_y1:=Ex_Image.Height-BottomBlank-X_Text_height-trunc(zk.Yc_Rock[zk.main_coal+1].R_h*shiyong_bl);
            //填充图例
            ExPstopeClass.MySqliteTable.GetBMPToSQlite(zk.Yc_Rock[zk.main_coal+1].BmpFile+'.Bmp',IntToStr(Tuxing+1),bitmap);
             // 累计图形高度
            Set_TU_H(trunc(zk.Yc_Rock[zk.main_coal+1].R_h*shiyong_bl));
            set_Text_H(trunc(zk.Yc_Rock[zk.main_coal+1].R_h*Y_Text_Bl));
        end; //end   if  Yc_Xiabiao = zk.main_coal  then  begin // 没有底板
         //无论有没有底板，都填充
         Image_inn.Canvas.Brush.Bitmap:=nil;
         Image_inn.Canvas.Polygon(Pointxy) ;
         Image_inn.Canvas.Brush.Bitmap:=bitmap;
         if   (Pointxy[2].Y-Pointxy[1].Y>4)  then
            Image_inn.Canvas.FloodFill(Trunc((Pointxy[0].X+Pointxy[1].X)/2),Trunc((Pointxy[1].Y+Pointxy[2].Y)/2),clBlack,fsBorder);

          inn_left_y0:=  Pointxy[0].Y;
          //画底板立体斜面
          Pointxy[0].X := Ex_Image.Width -RightBlank ;
          Pointxy[0].Y := Ex_Image.Height-BottomBlank-Image_inn.Height+Pointxy[0].Y ;
          Pointxy[3].X := Pointxy[0].X ;
          Pointxy[3].Y := Ex_Image.Height-BottomBlank-X_Text_height ;

          Pointxy[1].X := Pointxy[0].X+40 ;
          Pointxy[1].Y := Pointxy[0].Y-40;

          Pointxy[2].X := Pointxy[3].X+40 ;
          Pointxy[2].Y := Pointxy[3].Y-40;
          Ex_Image.Canvas.Polygon(Pointxy) ;
          Ex_Image.Canvas.Brush.Bitmap:=bitmap;   // 图片是底板的图片
           if   (Pointxy[2].Y-Pointxy[1].Y>2)  then
                  Ex_Image.Canvas.FloodFill(Trunc(Pointxy[0].X+1),Trunc((Pointxy[0].Y+Pointxy[3].Y)/2),clBlack,fsBorder);
          Ex_Image.Canvas.Brush.Bitmap:=nil;
          out_right_y0:=Pointxy[0].Y ;
          //标志X 横坐标
          JinchiFlag:=30;
          if trunc(Zoom) > 1 then  begin
              dvi_zoom:=trunc(Zoom);
          end else begin
              dvi_zoom:=1;
          end;

          JinchiFlag:=JinchiFlag div dvi_zoom;
           for I := 0 to round((gzm.S_L_qx*3)/JinchiFlag)-1 do  begin
               image_inn.Canvas.MoveTo (trunc((gzm.ZCYL_sx[2]+i*JinchiFlag)*shiyong_bl),image_inn.Height-X_Text_height);
               image_inn.Canvas.LineTo (trunc((gzm.ZCYL_sx[2]+i*JinchiFlag)*shiyong_bl),image_inn.Height-X_Text_height+5);
               Image_inn.Canvas.TextOut(trunc((gzm.ZCYL_sx[2]+i*JinchiFlag)*shiyong_bl)+1,
                                        image_inn.Height-X_Text_height,Inttostr(i*JinchiFlag));
           end;

     end;

end;

procedure TDraw_init.DrawCoalRock_Left;
{画 煤层}
begin
    with pDrawRecord do begin
       bitmap.FreeImage;
       ExPstopeClass.MySqliteTable.GetBMPToSQlite('m.Bmp',IntToStr(Tuxing+1),bitmap);
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
                Image_inn.Canvas.FloodFill(Trunc((Point_Six_P[0].X+Point_Six_P[3].X)/2),
                Trunc((Point_Six_P[1].Y+Point_Six_P[4].Y)/2),clBlack,fsBorder);
        Image_inn.Canvas.Brush.Bitmap:=nil;
         //

        //填写左侧压力拱数据
        if zk.Yc_Rock[zk.main_coal].R_h<= gzm.S_Cg_h then  begin
              YLG_L1.Add(InttoStr(Point_Six_P[1].X)+','+InttoStr(Point_Six_P[1].Y) );
              YLG_L2.Add(InttoStr(Point_Six_P[1].X-trunc(StrToFloat(temp1[4])*shiyong_bl))+','+InttoStr(Point_Six_P[1].Y) );
        end;
        // 累计图形高度 煤
       Set_TU_H(trunc(zk.Yc_Rock[zk.main_coal].R_h*shiyong_bl));
       Set_Text_H(trunc(zk.Yc_Rock[zk.main_coal].R_h*Y_Text_Bl));
    end;
end;

procedure TDraw_init.DrawCoalRock_Right;
{ 绘制右侧煤层}
begin
    with pDrawRecord do begin
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
        Pointxy[3].X := Ex_Image.Width -RightBlank;
        Pointxy[3].Y := out_right_y0;
        Pointxy[0].X :=  Pointxy[3].X;
        Pointxy[0].Y := Pointxy[3].Y -trunc(zk.Yc_Rock[zk.main_coal].R_h*gzm.Mc_FdBs*shiyong_bl);
        Pointxy[1].X := Pointxy[0].X+40 ;
        Pointxy[1].Y := Pointxy[0].Y-40;

        Pointxy[2].X := Pointxy[3].X+40 ;
        Pointxy[2].Y := Pointxy[3].Y-40;
        Ex_Image.Canvas.Polygon(Pointxy) ;
        Ex_Image.Canvas.Brush.Bitmap:=bitmap; //煤层的图片
         if   (Pointxy[2].Y-Pointxy[1].Y>2)  then
                Ex_Image.Canvas.FloodFill(Trunc(Pointxy[0].X+1),Trunc((Pointxy[0].Y+Pointxy[3].Y)/2),clBlack,fsBorder);
        Ex_Image.Canvas.Brush.Bitmap:=nil;
        Ex_Image.Canvas.MoveTo(LeftBlank-120,trunc(Out_left_y0-hanziheight-zk.Yc_Rock[zk.main_coal].R_h*gzm.Mc_FdBs*Y_Text_Bl));
        Ex_Image.Canvas.LineTo(LeftBlank-30,trunc(Out_left_y0-hanziheight-zk.Yc_Rock[zk.main_coal].R_h*gzm.Mc_FdBs*Y_Text_Bl));
        Ex_Image.Canvas.TextOut(LeftBlank-118,trunc(Out_left_y0-hanziheight-zk.Yc_Rock[zk.main_coal].R_h*gzm.Mc_FdBs*Y_Text_Bl/2),'煤');
        Ex_Image.Canvas.TextOut(LeftBlank-58,trunc(Out_left_y0-hanziheight-zk.Yc_Rock[zk.main_coal].R_h*gzm.Mc_FdBs*Y_Text_Bl/2),FormatFloat('0.0',zk.Yc_Rock[zk.main_coal].R_h));
        //画斜线
        Ex_Image.Canvas.MoveTo(LeftBlank-30,trunc(Out_left_y0-hanziheight-zk.Yc_Rock[zk.main_coal].R_h*gzm.Mc_FdBs*Y_Text_Bl));
        Ex_Image.Canvas.LineTo(LeftBlank, Out_left_y1-trunc(zk.Yc_Rock[zk.main_coal].R_h*gzm.Mc_FdBs*shiyong_bl));
        out_left_y0:=trunc(Out_left_y0-hanziheight-zk.Yc_Rock[zk.main_coal].R_h*gzm.Mc_FdBs*Y_Text_Bl);
        out_left_y1:=Out_left_y1-trunc(zk.Yc_Rock[zk.main_coal].R_h*gzm.Mc_FdBs*shiyong_bl);
    end;
end;

procedure TDraw_init.DrawCoalSupport;
begin
    with pDrawRecord do begin
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

         ganshi_right_x4:=Point_Six_P[3].X+trunc((jinchi)*shiyong_bl);
    end;
end;

function TDraw_init.DrawFyydDtfz_main:integer;
begin

   with pDrawRecord do begin
        {第一步 把绘图参数设置好}
       Draw_BasicInit;
        {第二步 绘图直接顶运动步距}
       Draw_imm_Rock;
        {第三步 绘图老顶运动步距}
       Draw_Old_Rock;
        {第四步 绘制矸石}
       Draw_Ganshi ;
        {第五步 绘制支承压力分布范围}
        // 右侧支承压力分布范围
       drawZcyl(Image_inn,zcyl_l_p1,zcyl_L_p2,temp1,shiyong_bl,false);
        // 左侧支持压力分布范围
       drawZcyl(Image_inn,zcyl_R_p1,zcyl_R_p2,temp1,shiyong_bl,true);
       {第六步 绘制裂断拱  //支撑压力平衡拱}
        if disp_ylg=1 then  begin
           draw_ylg(Image_inn,YLG_L1,YLG_L2,YLG_R1,YLG_R2);

        end;
       {第七步 把运动图拷贝到主图上}
       CopyImage_TuToOut;
       {最后一步 增加水印 释放位图}
       if not Public_Basic.Licensing  then
            Public_Basic.AddSingleTextWaterFormImage(Ex_Image) ;
       Result:=X_move_Pix;
   end;
end;

procedure TDraw_init.Draw_BasicInit;
{
   1------
   该函数是绘制覆岩运动动态仿真第一个函数
   主要是实现把画图的参数进行初始化
}
begin
   { 把 image 进行初始化}
   First_initImage(); //初始化image变量   1- 1
   {定制图片标题}
   First_Maketitle(NQ_step); //定制标题 1-  2
   {计算绘制岩梁，给岩梁参数付初始值}
   First_BeamStruct();   //1-3
   {确定图形绘制的高度}
   First_CountZK_H();  // 1-4 计算岩梁高度
   {计算图形的图形显示比例并绘制坐标轴}
   first_ImageBlank();  //1-5  计算图形的基本边界与基本参数
   {绘制煤层底板}
   DrawBottomFloor; //1-6
   {绘制左侧煤层}
   DrawCoalRock_Left;//1-7 画左侧煤层
   {绘制液压支架}
   DrawCoalSupport;// 1-8 画支架
   {控制屏幕坐标}
   MoveScreen;// 1-9 移动屏幕坐标
   {绘制右侧煤层}
   DrawCoalRock_Right;//1-10 画右侧煤层


end;

procedure TDraw_init.Draw_Ganshi;
{
  4 绘制矸石
}
begin
     with pDrawRecord do begin
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
                ExPstopeClass.MySqliteTable.GetBMPToSQlite('gs.Bmp',IntToStr(Tuxing+1),bitM);

                Image_inn.Canvas.Brush.Bitmap:=bitM;
                   if  (Point_Six_P[0].Y-Point_Six_P[2].Y>4)  then
                        Image_inn.Canvas.FloodFill(Trunc((Point_Six_P[0].X+Point_Six_P[3].X)/2),Trunc((Point_Six_P[1].Y+Point_Six_P[4].Y)/2),clBlack,fsBorder);

                Image_inn.Canvas.Brush.Bitmap:=nil;
        end;
     end;
end;

procedure TDraw_init.Draw_Imm_Rock;
begin
   {绘制岩层柱状与斜面}
   // Draw_RockName_xieMian;// 2-1 绘制岩层柱状与斜面
    {绘制顶煤}
    Draw_Top_Coal; //2-2 绘制顶煤
    {绘制直接顶}
    Draw_imm_Main;// 2-3 绘制直接顶
    {}
end;

procedure TDraw_init.Draw_Imm_Left;
var
  k:integer;
begin
   with pDrawRecord do begin
       // 把左侧的 直接顶进行填充
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
       Image_fill_P.x :=Trunc((Point_Six_P[5].X+Point_Six_P[3].X)/2);
          Image_fill_P.y:= Trunc((Point_Six_P[1].Y+Point_Six_P[4].Y)/2);
       //对圈定的区域进行填充
       Fill_Image(Image_inn,Image_fill_P.x,Image_fill_P.y,Point_Six_P);


      Image_inn.Canvas.Brush.Bitmap:=nil;
       //填写左侧压力拱数据
      YLG_L1.Add(InttoStr(Point_Six_P[1].X)+','+InttoStr(Point_Six_P[1].Y) );
      YLG_L2.Add(InttoStr(Point_Six_P[1].X-trunc(StrToFloat(temp1[4])*shiyong_bl))+','+InttoStr(Point_Six_P[1].Y) );

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
        //对圈定的区域进行填充
       Fill_Image(Image_inn,Image_fill_P.x,Image_fill_P.y,Point_wk);

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
        //对圈定的区域进行填充
       Fill_Image(Image_inn,Image_fill_P.x,Image_fill_P.y,Pointxy);
       Image_inn.Canvas.Brush.Bitmap:=nil;


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
           //对圈定的区域进行填充
        Fill_Image(Image_inn,Image_fill_P.x,Image_fill_P.y,Point_wk);

   end;
end;

procedure TDraw_init.Draw_imm_Main;
{
   直接顶引导函数
}
var
  Ycid:integer;
begin

    with pDrawRecord do begin
       //左侧直接顶
       inn_left_y0:=Point_Six_P[0].Y ;inn_left_y2:=Point_Six_P[2].Y;
       inn_right_y0:=Point_Six_P[0].Y ;inn_right_y2:=Point_Six_P[2].Y;
       inn_left_x2 :=trunc(gzm.ZCYL_sx[2]*shiyong_bl);  inn_Right_x2 :=trunc((Jinchi+gzm.ZCYL_sx[2])*shiyong_bl);
       ganshi_y1:=Point_Six_P[0].Y; YockLiang_Suo:=0;//first
       zcyl_L_P2.X:=inn_left_x2;   zcyl_l_P2.Y:=inn_left_y2;

       zcyl_R_P2.X:=trunc((Jinchi+gzm.ZCYL_sx[2]+zhijia.Zj_KongdingJU)*shiyong_bl);   zcyl_R_P2.Y:=inn_Right_y2;

       Zjd_Wt :=0;//直接顶的位态；
       // 对直接顶进行循环判定
        for Ycid := imm.Start_No  downto imm.End_No do begin
            //对直接顶 冒落的最后一层进行判定
            Step0:=zk.Yc_Rock[Ycid].Step0;
            if (Ycid=imm.End_No) and (imm.Surplus_h>0) then    begin
                used_h:= zk.Yc_Rock[Ycid].R_h-imm.Surplus_h;
                Step0:=sqrt(1000*2*used_h*zk.Yc_Rock[Ycid].R_klqd/zk.Yc_Rock[Ycid].R_r);
            end else begin
                used_h:= zk.Yc_Rock[Ycid].R_h;
            end;
             //填充图例
            bitM.FreeImage;
            ExPstopeClass.MySqliteTable.GetBMPToSQlite(zk.Yc_Rock[Ycid].BmpFile+'.Bmp',IntToStr(Tuxing+1),bitM);

            if jinChi+zhijia.Zj_KongdingJU+2*StrToFloat(temp1[1])-2*YockLiang_Suo< Step0 * 0.95  then  begin
                //没有直接顶
                break;
            end else if  jinChi+zhijia.Zj_KongdingJU+2*StrToFloat(temp1[1])-2*YockLiang_Suo<= Step0*1.05  then   begin
                // 直接顶裂断状态
                 Draw_Imm_Left; // 2-3-1 左侧直接顶
                 Draw_Imm_Rigth; // 2-3-2 右侧直接顶
            end else begin
               // 直接顶垮落状态
                 if Zjd_Wt=1 then   break;   // 如果下层没有沉降，上层出现沉降，退出
                 Draw_Imm_second_Left; // 2-3-3 左侧多次来压直接顶
                 Draw_Imm_Second_Rigth; // 2-3-4 右侧多次来压直接顶
                 ganshi_h:=ganshi_h+zk.Yc_Rock[Ycid].R_k_Rock*used_h;
            end;

           if Ycid<=imm.Start_No  then  ganshi_Count:=2;
           //制作柱状图与斜面
           Draw_RockNameAndThreeBord(trunc(Set_TU_H(0)),trunc(Set_Text_H(0)),Ycid);
           // 累计图形高度 煤
           Set_TU_H(trunc(used_h*shiyong_bl));
           Set_Text_H(trunc(used_h*Y_Text_Bl));
        end;

       ganshi_h:=ganshi_h+gzm.S_Cg_h*(gzm.Mc_FdBs-1) ;
       //
       if (Ycid> imm.End_No) or(Ycid=imm.End_No) then  begin
           for Ycid := Ycid downto imm.End_No do
                Draw_Imm_NeverMove_Rock(Ycid);  //2-3-5 直接顶下 在当前推进进尺下 不动的岩层
       end ;
    end;
end;

procedure TDraw_init.Draw_Imm_NeverMove_Rock(YcId:integer);
var
  k:integer;
  temp:double;
begin
     with pDrawRecord do begin

          //如果超出范围，退出
          if Use_Tu_H+zk.Yc_Rock[Ycid].R_h*shiyong_bl > Total_Image_H then begin
              ZoomExit:=true;    // 是否强制退出
              ExitNextYcid:=YcId+1;// 强制退出的下一层岩层的编号
              exit;
          end;

           Pointxy[0].X :=0 ;
//            if (YcId=imm.End_No) and (imm.Surplus_h>0) then    begin
//                Pointxy[0].Y :=inn_left_y0-trunc((zk.Yc_Rock[YcId].R_h-imm.Surplus_h)*shiyong_bl);
//            end else begin
//                Pointxy[0].Y :=inn_left_y0-trunc((zk.Yc_Rock[YcId].R_h)*shiyong_bl);
//
//            end;
          temp:= zk.Yc_Rock[YcId].R_h;
          Pointxy[0].Y :=inn_left_y0-trunc((zk.Yc_Rock[YcId].R_h)*shiyong_bl);

          Pointxy[1].X :=Image_inn.Width ;
          Pointxy[1].Y :=Pointxy[0].Y;
          Pointxy[2].X :=Pointxy[1].X  ;
          Pointxy[2].Y :=inn_left_y0;
          Pointxy[3].X :=Pointxy[0].X ;
          Pointxy[3].Y :=Pointxy[2].Y ;
          Image_inn.Canvas.Brush.Bitmap:=nil;
       //填充图例
          bitM.FreeImage;
          ExPstopeClass.MySqliteTable.GetBMPToSQlite(zk.Yc_Rock[YcId].BmpFile+'.Bmp',IntToStr(Tuxing+1),bitM);

          Image_inn.Canvas.Brush.Bitmap:=nil;
          Image_inn.Canvas.Polygon(Pointxy);
          Image_inn.Canvas.Brush.Bitmap:=bitM;
          Image_fill_P.x :=Trunc((Pointxy[0].X+Pointxy[1].X)/2); Image_fill_P.y:= Trunc((Pointxy[3].Y+Pointxy[0].Y)/2);
             //对圈定的区域进行填充
          Fill_Image(Image_inn,Image_fill_P.x,Image_fill_P.y,Pointxy);

           Image_inn.Canvas.Brush.Bitmap:=nil;
           inn_left_y0:=Pointxy[0].Y;
          //制作柱状图与斜面
          Draw_RockNameAndThreeBord(trunc(Set_TU_H(0)),trunc(Set_Text_H(0)),YcId);
           // 累计图形高度 煤
          Set_TU_H(trunc(temp*shiyong_bl));
          Set_Text_H(trunc(zk.Yc_Rock[YcId].R_h*Y_Text_Bl));
         //如果有不动的岩层，肯定没有完结
          Zjd_Wt:=1;

     end;
end;

procedure TDraw_init.Draw_Imm_Rigth;
var
  k:integer;
begin
   with pDrawRecord do begin
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
           //对圈定的区域进行填充
        Fill_Image(Image_inn,Image_fill_P.x,Image_fill_P.y,Point_Six_P);
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
                //对圈定的区域进行填充
             Fill_Image(Image_inn,Image_fill_P.x,Image_fill_P.y,Point_wk);

        inn_right_y0:=Point_Six_P[0].Y ;inn_right_y2:=Point_Six_P[2].Y;inn_Right_x2 := Point_Six_P[2].X -trunc(zhijia.Zj_KongdingJU*shiyong_bl);
       ganshi_y1:=Point_Six_P[5].Y;

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
             //对圈定的区域进行填充
          Fill_Image(Image_inn,Image_fill_P.x,Image_fill_P.y,Pointxy);


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
                //对圈定的区域进行填充
             Fill_Image(Image_inn,Image_fill_P.x,Image_fill_P.y,Point_wk);

      Image_inn.Canvas.Brush.Bitmap:=nil;
      Zjd_Wt:=1;
   end;
end;

procedure TDraw_init.Draw_Imm_second_Left;
var
  K:integer;
begin
    with pDrawRecord do begin
        //左侧
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
          //对圈定的区域进行填充
        Fill_Image(Image_inn,Image_fill_P.x,Image_fill_P.y,Point_Six_P);

        Image_inn.Canvas.Brush.Bitmap:=nil;
             //填写左侧压力拱数据
        YLG_L1.Add(InttoStr(Point_Six_P[1].X)+','+InttoStr(Point_Six_P[1].Y) );
        YLG_L2.Add(InttoStr(Point_Six_P[1].X-trunc(StrToFloat(temp1[4])*shiyong_bl))+','+InttoStr(Point_Six_P[1].Y) );


        inn_left_y0:=Point_Six_P[0].Y ;inn_left_y2:=Point_Six_P[2].Y;inn_left_x2 := Point_Six_P[2].X ;

    end;
end;

procedure TDraw_init.Draw_Imm_Second_Rigth;
var
  K:integer;
begin
    with pDrawRecord do begin
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
             //对圈定的区域进行填充
         Fill_Image(Image_inn,Image_fill_P.x,Image_fill_P.y,Point_Six_P);

         Image_inn.Canvas.Brush.Bitmap:=nil;
          //填写右侧压力拱数据
         YLG_R1.Insert(0,InttoStr(Point_Six_P[4].X)+','+InttoStr(Point_Six_P[2].Y) );
         YLG_R2.insert(0,InttoStr(Point_Six_P[4].X+trunc(StrToFloat(temp1[4])*shiyong_bl))+','+InttoStr(Point_Six_P[2].Y) );

         inn_right_y0:=Point_Six_P[0].Y ;inn_right_y2:=Point_Six_P[2].Y;inn_Right_x2 := Point_Six_P[2].X ;
         ganshi_y1:=Point_Six_P[0].Y;

    end;
end;

procedure TDraw_init.Draw_Old_Left(YcId:integer);
{ //左侧 老顶}
begin
   with pDrawRecord do begin
        //首先 确定顶板的下沉值
       if  break_i_105 =0  then  begin
           if jinChi+zhijia.Zj_KongdingJU < gzm.S_L_qx then  begin
              rock_sa:=zk.Yc_Rock[YcId].Sa[0];
           end else if jinChi+zhijia.Zj_KongdingJU < gzm.S_L_qx *2  then  begin
              rock_sa:=zk.Yc_Rock[YcId].Sa[1];
           end else begin
              rock_sa:=zk.Yc_Rock[YcId].Sa[2];
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

   end;
end;

procedure TDraw_init.Draw_Old_Left_First(YcId: integer);
{
 老顶第一块岩石
}
var
  K:integer;
begin
  with pDrawRecord do begin
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
          //对圈定的区域进行填充
        Fill_Image(Image_inn,Image_fill_P.x,Image_fill_P.y,Pointxy);

        //如果是最后一层， //顶层画立体外壳
       Draw_SanWei_Waike(Pointxy[1],Pointxy[2]);

       Image_inn.Canvas.Brush.Bitmap:=nil;
      //判断下沉值
        if used_h>rock_sa  then  begin
            break_i_105:=105;
            rock_sa:=(Pointxy[2].Y-Pointxy[1].Y)/shiyong_bl;
        end;
     //判断矸石的高度
       if YcId = Old_beam[0].Start_YC_No then  begin
         ganshi_y2:=Pointxy[3].Y;
       end;
  end;
end;

procedure TDraw_init.Draw_Old_Left_LastRock(YcId: integer);
var
  K:integer;
begin
   with pDrawRecord do begin
      //如果是最后一层， //顶层画立体外壳
      Draw_SanWei_Waike(Point_Six_P[0],Point_Six_P[2]);
     //调函数判断
      Image_inn.Canvas.Polygon(Point_Six_P) ;
        //添加   t_Str_Fir
        t_Str_Fir.Add(IntTostr( Point_Six_P[0].X )+','+IntTostr( Point_Six_P[0].Y ));
        t_Str_Fir.Add(IntTostr( Point_Six_P[1].X )+','+IntTostr( Point_Six_P[1].Y ));
        t_Str_Fir.Add(IntTostr( Point_Six_P[2].X )+','+IntTostr( Point_Six_P[2].Y ));


        Image_inn.Canvas.Brush.Bitmap:=bitM;
         //图形填充
         Image_fill_P.x :=Trunc((Point_Six_P[5].X+Point_Six_P[3].X)/2); Image_fill_P.y:= Trunc((Point_Six_P[1].Y+Point_Six_P[4].Y)/2);
              //对圈定的区域进行填充
         Fill_Image(Image_inn,Image_fill_P.x,Image_fill_P.y,Point_Six_P);

           Image_inn.Canvas.Brush.Bitmap:=nil;
                //填写左侧压力拱数据
        YLG_L1.Add(InttoStr(Point_Six_P[2].X)+','+InttoStr(Point_Six_P[2].Y) );
        YLG_L2.Add(InttoStr(Point_Six_P[2].X-trunc(StrToFloat(temp1[4])*shiyong_bl))+','+InttoStr(Point_Six_P[2].Y) );

   end;
end;

procedure TDraw_init.Draw_Old_Left_Two(YcId: integer);
{
    3-1-3 老顶第二块岩石
}
begin
    with pDrawRecord do begin
       Draw_Old_Left_Two_Basic(Ycid);// 3-1-3 -1   左侧老顶 第二块  基本信息
       if jinChi+zhijia.Zj_KongdingJU+2*StrToFloat(temp1[1])-2*YockLiang_Suo  >= Step0*1.05  then begin
          // 初次来压步距结束
          Draw_Old_Left_Two_FirstComePress(YcId); //3-1-3 -2 第一次来压步距 完成
       end;
    end;
end;

procedure TDraw_init.Draw_Old_Left_Two_Basic(YcId: integer);
{
   // 3-1-3 -1 左侧老顶 第二块  基本信息
}
begin
    with pDrawRecord do begin
      //预置第二块 信息
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

    end;
end;

procedure TDraw_init.Draw_Old_Left_Two_FirstComePress(YcId: integer);
{
   3-1-3 -2 第一次来压步距 完成
}
var
  j:integer;
begin
   with pDrawRecord do begin
       while_j:=true; j:=1;
       while_j_sup_jinchi:=jinChi+zhijia.Zj_KongdingJU+2*StrToFloat(temp1[1])-2*YockLiang_Suo - Step0 ;
       Point_Six_P[3].X :=inn_Left_x2+trunc((step0+YockLiang_Suo)*shiyong_bl);
       //第一次来压结束，进行多次循环
       while while_j do begin
          if j<=4 then  begin
             while_j_sup_jinchi:= while_j_sup_jinchi-zk.Yc_Rock[YcId].step_i[j]*0.95;
             step_i:=zk.Yc_Rock[YcId].step_i[j];
          end else begin
             while_j_sup_jinchi:= while_j_sup_jinchi-zk.Yc_Rock[YcId].step_i[0]*0.95;
             step_i:=zk.Yc_Rock[YcId].step_i[0];
          end;

         if while_j_sup_jinchi<0  then begin   //   如果是周期来压的最后一块
            if j>1 then
               Draw_Old_Left_Two_FirstComePress_Last(YcId,j);

            while_j:=false;
         end else begin  // 如果是周期来压前面的N 块
            Draw_Old_Left_Two_FirstComePress_Prev(YcId,j); // 3-1-3 -2-2  老顶周期来前面N 块
         end;

       end;

   end;
end;

procedure TDraw_init.Draw_Old_Left_Two_FirstComePress_Last(YcId:integer;var YKid:integer);
{
 // 3-1-3 -2 -1 老顶多次循环 的岩石块数  周期来压 最后一块
}
var
  K:integer;
begin
  with pDrawRecord do begin
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
        //对圈定的区域进行填充
     Fill_Image(Image_inn,Image_fill_P.x,Image_fill_P.y,P_i_j_1);

         //如果是最后一层， //顶层画立体外壳
      Draw_SanWei_Waike(P_i_j_1[1],P_i_j_1[2]);
      Image_inn.Canvas.Brush.Bitmap:=nil;
  end;
end;

procedure TDraw_init.Draw_Old_Left_Two_FirstComePress_Prev(YcId:integer;var YKid:integer);
{
 // 3-1-3 -2 -2 老顶多次循环 的岩石块数  周期来压 前面N块
}
begin
   with pDrawRecord do begin
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
       //
       Draw_Old_Left_Two_FirstComePress_Prev_Second(YcId,YKid); // 3-1-3 -2-2 -1 老顶周期来前面N 块  第二块
       Draw_Old_Left_Two_FirstComePress_Prev_Other(YcId,YKid); // 3-1-3 -2-2 -2 老顶周期来前面N 块  第二块
   end;
end;

procedure TDraw_init.Draw_Old_Left_Two_FirstComePress_Prev_Other(YcId:integer;var YKid:integer);
{
  // 3-1-3 -2-2 -2 老顶周期来前面N 块
  周期来压除了第二块不一样外，其他都一样
}
var
  K:integer;
begin
   with pDrawRecord do begin
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
             //对圈定的区域进行填充
           Fill_Image(Image_inn,Image_fill_P.x,Image_fill_P.y,Pointxy);

       //如果是最后一层， //顶层画立体外壳
          Draw_SanWei_Waike(Pointxy[1],Pointxy[2]);
          Image_inn.Canvas.Brush.Bitmap:=nil;
          while_j:=false;
       end else begin
           P_i_j_1[0].X:=  Pointxy[0].X ; P_i_j_1[0].Y:=  Pointxy[0].Y ;
           P_i_j_1[1].X:=  Pointxy[1].X ; P_i_j_1[1].Y:=  Pointxy[1].Y ;
           P_i_j_1[2].X:=  Pointxy[2].X ; P_i_j_1[2].Y:=  Pointxy[2].Y ;
           P_i_j_1[3].X:=  Pointxy[3].X ; P_i_j_1[3].Y:=  Pointxy[3].Y ;
           YKid:=YKid+1;
       end;

   end;
end;

procedure TDraw_init.Draw_Old_Left_Two_FirstComePress_Prev_Second(YcId:integer;var YKid:integer);
  {
     3-1-3 -2-2 -1 老顶周期来前面N 块  第二块
    老顶周期来压 第二块与其他各块大小不一样
  }
var
  K:integer;
begin
 with pDrawRecord do begin
      //修订 第二块
    if YKid=1 then  begin
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
              //对圈定的区域进行填充
        Fill_Image(Image_inn,Image_fill_P.x,Image_fill_P.y,P_i_j_1);


           //如果是最后一层， //顶层画立体外壳
          Draw_SanWei_Waike(P_i_j_1[1],P_i_j_1[2]);
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
                //对圈定的区域进行填充
           Fill_Image(Image_inn,Image_fill_P.x,Image_fill_P.y,Point_wk);

          Image_inn.Canvas.Brush.Bitmap:=nil;
    end;
 end;
end;

procedure TDraw_init.Draw_Old_NeverMoveRock(YcId:integer);
var
  k:integer;
begin
    with pDrawRecord do begin
        Pointxy[0].X :=0 ;
        if (YcId=imm.End_No) and (imm.Surplus_h>0) then    begin
            used_h :=imm.Surplus_h;
        end else begin
            used_h:=zk.Yc_Rock[YcId].R_h;
        end;

         if YcId<old.yl_max_End -2  then    begin
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
        ExPstopeClass.MySqliteTable.GetBMPToSQlite(zk.Yc_Rock[YcId].BmpFile+'.Bmp',IntToStr(Tuxing+1),bitM);

        Image_inn.Canvas.Brush.Bitmap:=nil;
        Image_inn.Canvas.Polygon(Pointxy);
        Image_inn.Canvas.Brush.Bitmap:=bitM;
         if   (Pointxy[2].Y-Pointxy[1].Y>4)  then
                Image_inn.Canvas.FloodFill(Trunc((Pointxy[0].X+Pointxy[2].X)/2),Trunc((Pointxy[0].Y+Pointxy[2].Y)/2),clBlack,fsBorder);
        Image_inn.Canvas.Brush.Bitmap:=nil;

        //如果是最后一层， //顶层画立体外壳
        Draw_SanWei_Waike(Pointxy[0],Pointxy[1]);
        inn_left_y0:=Pointxy[0].Y;

        //制作柱状图与斜面
        Draw_RockNameAndThreeBord(trunc(Set_TU_H(0)),trunc(Set_Text_H(0)),YcId);
         // 累计图形高度 煤
         if YcId<old.yl_max_End -2  then    begin
            Set_TU_H(trunc(used_h*hcd_bl*shiyong_bl));
            Set_Text_H(trunc(used_h*hcd_bl*Y_Text_Bl));
         end else begin
            Set_TU_H(trunc(used_h*shiyong_bl));
            Set_Text_H(trunc(used_h*Y_Text_Bl));
         end;


    end;
end;

procedure TDraw_init.Draw_Old_Rock;
{3-0  老顶制作导航}
var
  Ycid:integer;
  Add_H:double;
begin
   with pDrawRecord do begin
     YockLiang_Suo:=0; Rock_sa:=0; //老顶岩梁的缩进与 下沉初值为0
     inn_Left_x2:= trunc(gzm.ZCYL_sx[2]*shiyong_bl)-trunc(StrToFloat(temp1[1])*shiyong_bl);
     inn_Right_x2:= trunc((gzm.ZCYL_sx[2]+Jinchi+zhijia.Zj_KongdingJU+StrToFloat(temp1[3]))*shiyong_bl);
     ganshi_y2:=0; break_i_105:=0;
     zcyl_l_P1.X:=0;   zcyl_l_P1.Y:=zcyl_l_P2.Y-trunc(gzm.S_Cg_h*gzm.Mc_FdBs*strtofloat(temp1[2])*shiyong_bl);
     zcyl_R_P1.X:=Image_inn.Width;   zcyl_R_P1.Y:=zcyl_l_P1.Y;

     Sink_leixing:=1;
     //遍历 老顶岩层
     for Ycid := Old_beam[0].Start_YC_No downto model_start_yc do   begin
             //如果超出范围，退出
          if Use_Tu_H+zk.Yc_Rock[Ycid].R_h*shiyong_bl > Total_Image_H then begin
              ZoomExit:=true;    // 是否强制退出
              ExitNextYcid:=YcId+1;// 强制退出的下一层岩层的编号
              break;
          end;


          if Zjd_Wt=1 then  break; //如果直接顶没有沉降完毕。老顶不允许动

          Step0:=zk.Yc_Rock[Ycid].Step0;
          if (Ycid=imm.End_No) and (imm.Surplus_h>0) then    begin
              used_h:= imm.Surplus_h;
          end else begin
              used_h:= zk.Yc_Rock[Ycid].R_h;
          end;
         //填充图例
         bitM.FreeImage;
         ExPstopeClass.MySqliteTable.GetBMPToSQlite(zk.Yc_Rock[Ycid].BmpFile+'.Bmp',IntToStr(Tuxing+1),bitM);

         if Ycid<old.yl_max_End then   break;

         if jinChi+zhijia.Zj_KongdingJU+2*StrToFloat(temp1[1])-2*YockLiang_Suo< Step0 * 0.95  then  begin
            // 没有形成老顶
             break;
         end else  begin
            // 已经形成老顶
            Draw_Old_Left(Ycid); // 3-1  左侧老顶
            Draw_Old_Left_LastRock(Ycid); // 3-1-1  左侧老顶 最后一层岩层
            Draw_Old_Left_First(Ycid);//3-1-2 老顶第一块岩石
            Draw_Old_Left_Two(Ycid); // 3-1-3  左侧老顶 第二块
             //draw 右侧 老顶
             Point_Six_P[5].X :=Image_inn.Width;
                  Point_Six_P[5].Y :=inn_left_y0;
             if StrToFloat(temp1[3])>0 then begin
                  Point_Six_P[3].Y :=inn_right_y2-trunc((inn_left_y2-inn_left_y0)*(StrToFloat(temp1[3])-StrToFloat(temp1[1]))/StrToFloat(temp1[3]));
             end else begin
                  Point_Six_P[3].Y :=inn_right_y2;
             end;
         end;

        // 老顶岩梁第二块
        Draw_old_Two(Ycid); // 3-2  老顶周期第二块
        //制作柱状图与斜面
        Draw_RockNameAndThreeBord(trunc(Set_TU_H(0)),trunc(Set_Text_H(0)),Ycid);
        // 累计图形高度 煤
        Set_TU_H(trunc(used_h*shiyong_bl));
        Set_Text_H(trunc(used_h*Y_Text_Bl));
     end;

     // 画老顶在当前推进条件下不动的岩层
     if Ycid>= 0 then
        for Ycid := YcId downto model_start_yc do  begin
           if YcId<old.yl_max_End -2  then    Add_H :=trunc(zk.Yc_Rock[Ycid].R_h*hcd_bl*shiyong_bl)
              else   Add_H :=trunc(zk.Yc_Rock[Ycid].R_h*shiyong_bl);

          if Use_Tu_H+Add_H > Total_Image_H then begin
              ZoomExit:=true;    // 是否强制退出
              ExitNextYcid:=YcId+1;// 强制退出的下一层岩层的编号
              break;
          end;
          if (Zjd_Wt=1) and  (Ycid=imm.End_No) and (imm.Surplus_h>0)  then  continue;
            Draw_Old_NeverMoveRock(Ycid); // 3-3 当前条件下不动的岩层
        end;
     // 老顶全部画完，把最后一层的三维外壳画了
     if ZoomExit then begin
         FillLastRockThreeAngleArea(ExitNextYcid);
     end;

   end;
end;

procedure TDraw_init.Draw_old_Two(YcId: integer);
{
  3-2  老顶周期第二块
}
begin
   with pDrawRecord do begin
        Draw_old_Two_left(YcId); // 3-2-1  老顶周期第二块 左侧
        Draw_old_Two_Right(YcId); // 3-2-2  老顶周期第二块 右侧

         //本层决定下一层的内缩
     YockLiang_Suo:=YockLiang_Suo+used_h*tan(25/180*3.1415926);
     inn_left_y0:=Point_Six_P[0].Y ;inn_left_y2:=Point_Six_P[2].Y; inn_right_y2:= inn_left_y2;

     t_str_sec.Clear;
     t_str_sec.Text:=t_str_fir.Text;
     s_out:=t_str_sec.Text;
     t_str_fir.Clear ;
   end;
end;

procedure TDraw_init.Draw_old_Two_left(YcId: integer);
{
  3-2-1  老顶周期第二块 左侧
}
var
  k:integer;
begin
   with pDrawRecord do begin
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
       //对圈定的区域进行填充
        Fill_Image(Image_inn,Image_fill_P.x,Image_fill_P.y,Point_t_P);

        //如果是最后一层， //顶层画立体外壳
        Draw_SanWei_Waike( Point_t_P[2],Point_t_P[1]);

       Image_inn.Canvas.Brush.Bitmap:=nil;
       Image_inn.Canvas.Brush.Bitmap:=nil;
   end;
end;

procedure TDraw_init.Draw_old_Two_Right(YcId: integer);
{
  3-2-2  老顶周期第二块 右侧
}
var
  k:integer;
begin
   with pDrawRecord do begin
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
        Draw_SanWei_Waike( Point_Six_P[2],Point_Six_P[0]);

   end;
end;

procedure TDraw_init.Draw_RockNameAndThreeBord(tu_Y,Text_Y, Ycid: integer);
{  分层制作柱状图与斜面函数
   tu_Y ：图形开始的 Y坐标
   Text_Y： 柱状图开始的 Y 坐标
   Ycid： 岩层的编号
}
begin

   with pDrawRecord do begin
        tu_Y:=Ex_Image.Height-BottomBlank-X_Text_height-tu_Y;
        Text_Y:=Ex_Image.Height-BottomBlank-X_Text_height-Text_Y;
        //标注柱状图
         if Ycid<old.yl_max_End-2 then  begin
            Ex_Image.Canvas.MoveTo(LeftBlank-120,trunc(Text_Y-hanziheight-zk.Yc_Rock[Ycid].R_h*hcd_bl*Y_Text_Bl));
            Ex_Image.Canvas.LineTo(LeftBlank-30,trunc(Text_Y-hanziheight-zk.Yc_Rock[Ycid].R_h*hcd_bl*Y_Text_Bl));
            //写岩层的名字
            Ex_Image.Canvas.TextOut(LeftBlank-118,trunc(Text_Y-hanziheight-zk.Yc_Rock[Ycid].R_h*hcd_bl*Y_Text_Bl/2),zk.Yc_Rock[Ycid].R_Name);
            Ex_Image.Canvas.TextOut(LeftBlank-58,trunc(Text_Y-hanziheight-zk.Yc_Rock[Ycid].R_h*hcd_bl*Y_Text_Bl/2),FormatFloat('0.0',zk.Yc_Rock[Ycid].R_h));
            //画斜线
            Ex_Image.Canvas.MoveTo(LeftBlank-30,trunc(Text_Y-hanziheight-zk.Yc_Rock[Ycid].R_h*hcd_bl*Y_Text_Bl));
            Ex_Image.Canvas.LineTo(LeftBlank, tu_Y-trunc(zk.Yc_Rock[Ycid].R_h*hcd_bl*shiyong_bl));

         end else begin
            Ex_Image.Canvas.MoveTo(LeftBlank-120,trunc(Text_Y-hanziheight-zk.Yc_Rock[Ycid].R_h*Y_Text_Bl));
            Ex_Image.Canvas.LineTo(LeftBlank-30,trunc(Text_Y-hanziheight-zk.Yc_Rock[Ycid].R_h*Y_Text_Bl));
           //写岩层的名字
            Ex_Image.Canvas.TextOut(LeftBlank-118,trunc(Text_Y-hanziheight-zk.Yc_Rock[Ycid].R_h*Y_Text_Bl/2),zk.Yc_Rock[Ycid].R_Name);
            Ex_Image.Canvas.TextOut(LeftBlank-58,trunc(Text_Y-hanziheight-zk.Yc_Rock[Ycid].R_h*Y_Text_Bl/2),FormatFloat('0.0',zk.Yc_Rock[Ycid].R_h));
            //画斜线
            Ex_Image.Canvas.MoveTo(LeftBlank-30,trunc(Text_Y-hanziheight-zk.Yc_Rock[Ycid].R_h*Y_Text_Bl));
            Ex_Image.Canvas.LineTo(LeftBlank, tu_Y-trunc(zk.Yc_Rock[Ycid].R_h*shiyong_bl));

         end;// end if

           // 画斜面
          Pointxy[3].X := Ex_Image.Width -RightBlank;
          Pointxy[3].Y := tu_Y;
          Pointxy[0].X := Pointxy[3].X;
          if Ycid<old.yl_max_End-2 then  begin
               Pointxy[0].Y := Pointxy[3].Y -trunc(zk.Yc_Rock[Ycid].R_h*hcd_bl*shiyong_bl);
          end else begin
               Pointxy[0].Y := Pointxy[3].Y -trunc(zk.Yc_Rock[Ycid].R_h*shiyong_bl);
          end;

          Pointxy[1].X := Pointxy[0].X+40 ;
          Pointxy[1].Y := Pointxy[0].Y-40;

          Pointxy[2].X := Pointxy[3].X+40 ;
          Pointxy[2].Y := Pointxy[3].Y-40;

          bitmap.FreeImage;
          ExPstopeClass.MySqliteTable.GetBMPToSQlite(zk.Yc_Rock[Ycid].BmpFile+'.Bmp',IntToStr(Tuxing+1),bitmap);
          Ex_Image.Canvas.Brush.Bitmap:=nil;
          Ex_Image.Canvas.Polygon(Pointxy) ;
          Ex_Image.Canvas.Brush.Bitmap:=bitmap;
           if   (Pointxy[2].Y-Pointxy[1].Y>2)  then
                  Ex_Image.Canvas.FloodFill(Trunc(Pointxy[0].X+1),Trunc((Pointxy[0].Y+Pointxy[3].Y)/2),clBlack,fsBorder);
        //如果最后一层 画斜面
          if Ycid=model_start_yc then  begin
//              Pointxy[2].X := Pointxy[0].X ;
//              Pointxy[2].Y := Pointxy[0].Y ;
//              Pointxy[3].X := Pointxy[2].X-5 ;
//              Pointxy[3].Y := Pointxy[2].Y ;
//              Pointxy[0].X := Pointxy[3].X ;
//              Pointxy[0].Y := Pointxy[1].Y;
//              Ex_Image.Canvas.Brush.Bitmap:=nil;
//              Ex_Image.Canvas.Polygon(Pointxy) ;
//              Ex_Image.Canvas.Brush.Bitmap:=bitmap;
//              if   (Pointxy[2].Y-Pointxy[1].Y>2)  then
//                 Ex_Image.Canvas.FloodFill(Trunc(Pointxy[0].X+1),Trunc((Pointxy[0].Y+Pointxy[3].Y)/2),clBlack,fsBorder);

              FillLastRockThreeAngleArea(model_start_yc);

          end;
     end;

end;

procedure TDraw_init.Draw_RockName_xieMian;
var
  i:integer;
begin
     with pDrawRecord do begin
        //开始画上覆岩层
        for I:=zk.main_coal-1 downto model_start_yc do  begin
            // 画斜面
            Pointxy[3].X := Ex_Image.Width -RightBlank;
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
            ExPstopeClass.MySqliteTable.GetBMPToSQlite(zk.Yc_Rock[i].BmpFile+'.Bmp',IntToStr(Tuxing+1),bitmap);
            Ex_Image.Canvas.Brush.Bitmap:=nil;
            Ex_Image.Canvas.Polygon(Pointxy) ;
            Ex_Image.Canvas.Brush.Bitmap:=bitmap;
             if   (Pointxy[2].Y-Pointxy[1].Y>2)  then
                    Ex_Image.Canvas.FloodFill(Trunc(Pointxy[0].X+1),Trunc((Pointxy[0].Y+Pointxy[3].Y)/2),clBlack,fsBorder);
            //如果最后一层 画斜面
              if i=model_start_yc then  begin

                  Pointxy[2].X := Pointxy[0].X ;
                  Pointxy[2].Y := Pointxy[0].Y ;
                  Pointxy[3].X := Pointxy[2].X-5 ;
                  Pointxy[3].Y := Pointxy[2].Y ;

                  Pointxy[0].X := Pointxy[3].X ;
                  Pointxy[0].Y := Pointxy[1].Y;

                     Ex_Image.Canvas.Brush.Bitmap:=nil;
                     Ex_Image.Canvas.Polygon(Pointxy) ;
                     Ex_Image.Canvas.Brush.Bitmap:=bitmap;
                      if   (Pointxy[2].Y-Pointxy[1].Y>2)  then
                            Ex_Image.Canvas.FloodFill(Trunc(Pointxy[0].X+1),Trunc((Pointxy[0].Y+Pointxy[3].Y)/2),clBlack,fsBorder);

              end;
         if i<old.yl_max_End-2 then  begin
            Ex_Image.Canvas.MoveTo(LeftBlank-120,trunc(Out_left_y0-hanziheight-zk.Yc_Rock[i].R_h*hcd_bl*Y_Text_Bl));
            Ex_Image.Canvas.LineTo(LeftBlank-30,trunc(Out_left_y0-hanziheight-zk.Yc_Rock[i].R_h*hcd_bl*Y_Text_Bl));
            //写岩层的名字
            Ex_Image.Canvas.TextOut(LeftBlank-118,trunc(Out_left_y0-hanziheight-zk.Yc_Rock[i].R_h*hcd_bl*Y_Text_Bl/2),zk.Yc_Rock[i].R_Name);
            Ex_Image.Canvas.TextOut(LeftBlank-58,trunc(Out_left_y0-hanziheight-zk.Yc_Rock[i].R_h*hcd_bl*Y_Text_Bl/2),FormatFloat('0.0',zk.Yc_Rock[i].R_h));
            //画斜线
            Ex_Image.Canvas.MoveTo(LeftBlank-30,trunc(Out_left_y0-hanziheight-zk.Yc_Rock[i].R_h*hcd_bl*Y_Text_Bl));
            Ex_Image.Canvas.LineTo(LeftBlank, Out_left_y1-trunc(zk.Yc_Rock[i].R_h*hcd_bl*shiyong_bl));
            out_left_y0:=trunc(Out_left_y0-hanziheight-zk.Yc_Rock[i].R_h*hcd_bl*Y_Text_Bl);
            out_left_y1:=Out_left_y1-trunc(zk.Yc_Rock[i].R_h*hcd_bl*shiyong_bl);
         end else begin
            Ex_Image.Canvas.MoveTo(LeftBlank-120,trunc(Out_left_y0-hanziheight-zk.Yc_Rock[i].R_h*Y_Text_Bl));
            Ex_Image.Canvas.LineTo(LeftBlank-30,trunc(Out_left_y0-hanziheight-zk.Yc_Rock[i].R_h*Y_Text_Bl));
           //写岩层的名字
            Ex_Image.Canvas.TextOut(LeftBlank-118,trunc(Out_left_y0-hanziheight-zk.Yc_Rock[i].R_h*Y_Text_Bl/2),zk.Yc_Rock[i].R_Name);
            Ex_Image.Canvas.TextOut(LeftBlank-58,trunc(Out_left_y0-hanziheight-zk.Yc_Rock[i].R_h*Y_Text_Bl/2),FormatFloat('0.0',zk.Yc_Rock[i].R_h));
            //画斜线
            Ex_Image.Canvas.MoveTo(LeftBlank-30,trunc(Out_left_y0-hanziheight-zk.Yc_Rock[i].R_h*Y_Text_Bl));
            Ex_Image.Canvas.LineTo(LeftBlank, Out_left_y1-trunc(zk.Yc_Rock[i].R_h*shiyong_bl));
            out_left_y0:=trunc(Out_left_y0-hanziheight-zk.Yc_Rock[i].R_h*Y_Text_Bl);
            out_left_y1:=Out_left_y1-trunc(zk.Yc_Rock[i].R_h*shiyong_bl);
         end;// end if
       end; // end for i := 0 to List.Count - 1 do
     end;
end;

procedure TDraw_init.Draw_SanWei_Waike(pt1, pt2: TPoint);
{   //顶层画立体外壳
}
var
 K:integer;
begin
       with pDrawRecord do begin
          Point_wk[3].X := pt1.X ;
          Point_wk[3].Y := pt1.Y;
          Point_wk[2].X := pt2.X ;
          Point_wk[2].Y := pt2.Y;

          Point_wk[0].X := Point_wk[3].X+40 ;
          Point_wk[0].Y := Point_wk[3].Y-40;
          Point_wk[1].X := Point_wk[2].X+40;
          Point_wk[1].Y := Point_wk[2].Y-40;
          Image_inn.Canvas.Brush.Bitmap:=nil;
          Image_inn.Canvas.Polygon(Point_wk);
          Image_inn.Canvas.Brush.Bitmap:=bitM;
             //图形填充
           Image_fill_P.x :=Trunc((Point_wk[0].X+Point_wk[2].X)/2);
           Image_fill_P.y:= Trunc((Point_wk[0].Y+Point_wk[2].Y)/2);
              //对圈定的区域进行填充
           Fill_Image(Image_inn,Image_fill_P.x,Image_fill_P.y,Point_wk);

      end;
end;

procedure TDraw_init.Draw_Top_Coal;
begin
     with pDrawRecord do begin
        //画顶煤
          bitmap.FreeImage;
          bitM.FreeImage;
          ganshi_h:=0;
          if (zk.Yc_Rock[zk.main_coal].R_h-Gzm.S_Cg_h)>=0.5 then begin     //如果有顶煤
                  //左侧顶煤
                  ExPstopeClass.MySqliteTable.GetBMPToSQlite('m.Bmp',IntToStr(Tuxing+1),bitM); //装入图像文件

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
                     //ganshi_right_x4:=Point_Six_P[2].X-trunc((zhijia.Zj_KongdingJU/60*22)*shiyong_bl);
              end;
     end;
end;

procedure TDraw_init.First_ImageBlank;
{计算图形的基本边界与基本参数}
begin
  with pDrawRecord do begin
      Total_Image_H:=Ex_Image.Height-TopBlank-BottomBlank-X_Text_height-40;
      Y_Text_Bl:=(Ex_Image.Height-TopBlank-BottomBlank-X_Text_height-40-Table_Title_H-(Yl_name_count)*HanziHeight)/Y_tu_H;
      Y_tu_BL:=(Ex_Image.Height-TopBlank-BottomBlank-X_Text_height-40)/Y_tu_H;

      //清除image
      Ex_Image.Picture.Graphic:=nil;
      Ex_Image.Canvas.Refresh;
      Ex_Image.Canvas.FillRect(Ex_Image.ClientRect);
      Ex_Image.Canvas.Pen.Color :=clBlack;

      //采高大于钻孔岩层高度的处理   2016.505
       if zk.Yc_Rock[zk.main_coal].R_h< gzm.S_Cg_h then   gzm.S_Cg_h:=zk.Yc_Rock[zk.main_coal].R_h  ;


      //写标题
       Ex_Image.Canvas.Font.Size := 18;
       Ex_Image.Canvas.TextOut(trunc(Ex_Image.Width/2-300),trunc(10),TitleText);

       //画坐标轴
       Ex_Image.Canvas.MoveTo(LeftBlank,TopBlank-Table_Title_H+40);
       Ex_Image.Canvas.LineTo(LeftBlank-120,TopBlank-Table_Title_H+40);
       Ex_Image.Canvas.MoveTo(LeftBlank,TopBlank-Table_Title_H+40+X_Text_height);
       Ex_Image.Canvas.LineTo(LeftBlank-120,TopBlank-Table_Title_H+40+X_Text_height);

       Ex_Image.Canvas.MoveTo(LeftBlank,TopBlank-Table_Title_H+40);
       Ex_Image.Canvas.LineTo(LeftBlank,Ex_Image.Height-BottomBlank-X_Text_height+20);
       Ex_Image.Canvas.LineTo(LeftBlank-120,Ex_Image.Height-BottomBlank-X_Text_height+20);

       Ex_Image.Canvas.MoveTo(LeftBlank-120,TopBlank-Table_Title_H+40-1);
       Ex_Image.Canvas.LineTo(LeftBlank-120,Ex_Image.Height-BottomBlank-X_Text_height+20);
       Ex_Image.Canvas.MoveTo(LeftBlank-60,TopBlank-Table_Title_H-1+40);
       Ex_Image.Canvas.LineTo(LeftBlank-60,Ex_Image.Height-BottomBlank-X_Text_height+20);
       Ex_Image.Canvas.MoveTo(LeftBlank-30,TopBlank-Table_Title_H-1+40);
       Ex_Image.Canvas.LineTo(LeftBlank-30,Ex_Image.Height-BottomBlank-X_Text_height);
       Ex_Image.Canvas.MoveTo(LeftBlank-120,Ex_Image.Height-BottomBlank-X_Text_height);
       Ex_Image.Canvas.LineTo(LeftBlank,Ex_Image.Height-BottomBlank-X_Text_height);
       //===岩层名称

       Ex_Image.Canvas.Font.Size := 9;
       Ex_Image.Canvas.TextOut(LeftBlank-118,Ex_Image.Height-BottomBlank-X_Text_height+3,'岩层名称');
       Ex_Image.Canvas.TextOut(LeftBlank-58, Ex_Image.Height-BottomBlank-X_Text_height+3,'厚度(m)');
       //x方向的比例
       X_bl:=(Ex_Image.Width-LeftBlank-RightBlank)/(Old_beam[0].Step_0_Simple+Old_beam[0].step_i_simple[1]+gzm.ZCYL_sx[0]+gzm.ZCYL_sx[2]);
       // 定制使用比例
       shiyong_bl:=Y_tu_BL* Zomm_D ;
       Y_Text_Bl:=Y_Text_Bl*Zomm_D;

       if Y_Text_Bl>shiyong_bl  then    Y_Text_Bl:=shiyong_bl ;

       tu_max_width:=trunc((gzm.ZCYL_sx[0]+gzm.ZCYL_sx[1]+gzm.S_L_qx*3)*shiyong_bl);

  end;

end;

procedure TDraw_init.First_initImage;
begin
    with pDrawRecord do begin
         {清理内部画布}
          if  Assigned(bitmap) then   FreeandNil(bitmap);
          bitmap:=Tbitmap.Create;  //创建位图 bitmap1

          if  Assigned(bitM) then  FreeandNil(bitM);
          bitM:=Tbitmap.Create;
          bitmap.FreeImage ;
          bitM.FreeImage;

          if  Assigned(Image_inn) then
                 FreeandNil(Image_inn);
          Image_inn:=TImage.Create(Application);
          t_Str_Fir.Clear ;
          t_Str_sec.Clear;

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
         //空白边界初始化
         TopBlank:=trunc(Ex_Image.Height/30)+40 ;BottomBlank:=trunc(Ex_Image.Height/30)+20;
         LeftBlank:=trunc(Ex_Image.Width/30)+120;RightBlank:=trunc(Ex_Image.Width/30)+50;
         HanziHeight:=15; Table_Title_H:=15;X_Text_height:=30;
         ganshi_Count:=0;  Use_Tu_H:=0;Use_Text_H:=0;
         ZoomExit:=FALSE;    // 是否强制退出
         ExitNextYcid:=0;// 强制退出的下一层岩层的编号
         X_move_pix:=Trunc(X_pan_move);
    end;
end;

procedure TDraw_init.First_Maketitle(DefOrStep: string);
var
  i:integer;
begin
        //定标题
  with pDrawRecord do begin
      if DefOrStep='1' then begin   //1 挠曲 算法
            TitleText:=Gzm.S_Name+',编号:'+zk.Zk_name+' 钻孔(挠曲算法):支架岩梁关系图';
            for I := 0 to 4 do
               Old_beam[i]:=zk.Beam_Def[i] ;
      end else begin          //步距算法
            TitleText:=Gzm.S_Name+',编号:'+zk.Zk_name+' 钻孔(步距算法):支架岩梁关系图';
             for I := 0 to 4 do
                Old_beam[i]:=zk.Beam_step[i] ;
      end;
     TitleText:=Gzm.S_Name+',编号:'+zk.Zk_name+' 钻孔(挠曲算法):支架岩梁关系图';
  end;
end;

function TDraw_init.GetZoom: double;
begin
   Result:=Zomm_D;
end;

procedure TDraw_init.MoveScreen;
begin
   with pDrawRecord do begin
     //根据进尺确定X的移动距离   屏幕向右移动
      while  (Ex_Image.Width-LeftBlank-RightBlank-Point_Six_P[2].X-trunc((jinchi+zhijia.Zj_KongdingJU)*shiyong_bl)+
                       X_move_pix< Ex_Image.Width /15) or (X_move_pix <0)  do
             X_move_pix:=X_move_pix+trunc(Ex_Image.Width/15);
     //根据进尺确定X的移动距离   屏幕向左移动
      while  (Point_Six_P[2].X+trunc((jinchi+zhijia.Zj_KongdingJU)*shiyong_bl)< X_move_pix + trunc(gzm.ZCYL_sx[2]*shiyong_bl)) and
             (Ex_Image.Width-LeftBlank-RightBlank-Point_Six_P[2].X-trunc((jinchi+zhijia.Zj_KongdingJU)*shiyong_bl)+ X_move_pix > Ex_Image.Width /15 )
            do
               X_move_pix:=X_move_pix-trunc(Ex_Image.Width/15);
      // 强制 移动 防止退到 页面外边
      while  (Point_Six_P[2].X+trunc((jinchi+zhijia.Zj_KongdingJU)*shiyong_bl)< X_move_pix) do
               X_move_pix:=X_move_pix-trunc(Ex_Image.Width/15);
   end;

end;

procedure TDraw_init.SetDrawClassDcFZ(Image: TImage);
begin
     Ex_Image:=Image;
     //
end;

procedure TDraw_init.SetDrawClass_canshu(JChi, X_pan: double; Tu, disp_two,
  ylg: integer; NQstep: String);
begin
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
     JinChi:=JChi;
     X_pan_move:=X_pan;
     Tuxing:=Tu;
     disp_two_tu:=disp_two;
     disp_ylg:=ylg;
     NQ_step:=NQstep;

end;

procedure TDraw_init.SetDrawZhulei(tgzm: TG_stope; tZk: Tzk_bore;
  tZhiJia: TZJ_Class; timm: TImmediate_roof; told: Told_roof);
begin
    {*------
   画推进方模拟开采

    @gzm:TG_stope;         工作面的类
    @Zk:Tzk_bore;           钻孔的类
    @ ZhiJia:TZJ_Class;      支架的类
    @ imm:TImmediate_roof;   直接顶的类
    @ old:Told_roof          老顶的类
    @ return                返回值为 图片的平移坐标 即   X_pan_move
   }
   gzm:=tgzm;
   Zk:=tZk;
   ZhiJia:=tZhiJia ;
   imm:=timm;
   old:=told;
end;

procedure TDraw_init.setMoveStart(Value: double);
begin
    X_pan_move:=Value;
end;

function TDraw_init.Set_Tu_H(Value: integer): double;
begin
    with pDrawRecord do begin
       Use_Tu_H := Use_Tu_H+Value;
       Result:=Use_Tu_H;
    end;
end;

procedure TDraw_init.SetZoom(Value: double);
begin
    Zomm_D:=Value;
end;

function TDraw_init.Set_Text_H(Value: integer): Double;
begin
   with pDrawRecord do begin
       if Value >0  then
          Use_Text_H := Use_Text_H+Value+HanziHeight;
       Result:=Use_Text_H;
    end;
end;

{ TDrawDTFZ_Record }

constructor TDrawDTFZ_Record.Create;
begin
    if not Assigned(bitmap) then
        bitmap:=Tbitmap.Create;  //创建位图 bitmap1
    if not Assigned(bitM) then
        bitM:=Tbitmap.Create;
    if not Assigned(t_Str_Fir) then
       t_Str_Fir:=TStringList.Create ;
    if not Assigned(t_Str_sec) then
          t_Str_sec:=TStringList.Create;
    if not Assigned(YLG_L1) then
          YLG_L1:=TStringList.Create;
    if not Assigned(YLG_L2) then
          YLG_L2:=TStringList.Create;
    if not Assigned(YLG_R1) then
          YLG_R1:=TStringList.Create;
    if not Assigned(YLG_R2) then
          YLG_R2:=TStringList.Create;
    if not Assigned(Image_inn) then
          Image_inn:=TImage.Create(nil);

end;

destructor TDrawDTFZ_Record.Destroy;
begin
     if  Assigned(bitmap) then   FreeAndNil(bitmap);  //创建位图 bitmap1
     if  Assigned(bitM) then   FreeAndNil(bitM);
     if  Assigned(t_Str_Fir) then FreeAndNil(t_Str_Fir);
     if  Assigned(t_Str_sec) then FreeAndNil(t_Str_sec);
     if  Assigned(YLG_L1) then FreeAndNil(YLG_L1);
     if  Assigned(YLG_L2) then FreeAndNil(YLG_L2);
     if  Assigned(YLG_R1) then FreeAndNil(YLG_R1);
     if  Assigned(YLG_R2) then   FreeAndNil(YLG_R2);
     if  Assigned(Image_inn) then FreeAndNil(Image_inn);
  inherited;
end;

end.

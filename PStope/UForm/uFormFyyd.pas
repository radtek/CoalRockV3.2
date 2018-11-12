unit uFormFyyd;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, ExtCtrls, StdCtrls, Buttons
  ,PStope_WorKFace,PStope_Immediate,PStope_SupportClass ,PStope_DealWith
  ,Pstope_ShowWindows, System.ImageList, Vcl.ImgList, Vcl.Menus
  ;

type
   pDrawFyyd =^TFYYDRecord;
  TFYYDRecord=packed record
     Y_total_T :double;     //　Y 方向文字高度
     Y_total_H :double;     //  Ｙ 方向图形高度
     TitleText :Widestring; //标题
     Pointxy   :Array [0..3] of TPoint; //  绘制柱状图图时的坐标变量
     TableH    :Integer; //表头高度
     textHtemp :double;     // 计算岩层名称时的临时变量
     YLPoint   :Array [0..3] of Tpoint; // 绘制岩梁时的坐标变量
     Yc_Xiabiao:integer;// 从那一层岩层结束显示
     Yl_Name_bl,Yl_Text_bl:double;//    岩梁的名称与字符比例
     Yl_name_count,Yl_Text_count:integer;// 岩梁显示的行数
     Stop_H:Integer;   //表格后部线段终止

     ZtPoint :Array [0..3] of Tpoint;//之托曾填充数组
     HanziHeight:Integer;//汉字的最小高度
     X_Image_Bl,Y_Image_Bl:double;   //画图的比例
     X_Text_Bl,Y_Text_Bl:double;     //文字的比例
     TopBlank,BottomBlank: integer;  //图片上下的空白
     LeftBlank,RightBlank:integer;   // 图片左右的空白
     ZhuZhuangtu_Wid:Integer; //  指定柱状图的宽度
     Yc_End_Nu :integer; //   最上面一层岩层的编号


     //对比钻孔的绘制
     NQ_count,Bj_Count:integer; //
     Dep_k,Step_k:integer;  //临时变量

  end;

  TFormFyyd = class(TForm)
    Panel1: TPanel;
    Image_Fyyd: TImage;
    Panel4: TPanel;
    BitBtn3: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn4: TBitBtn;
    BitBtn5: TBitBtn;
    RadioGroup1: TRadioGroup;
    BitBtn1: TBitBtn;
    Splitter1: TSplitter;
    SaveDialog1: TSaveDialog;
    DispPopMemu: TPopupMenu;
    Pop_JianYue: TMenuItem;
    Pop_Fangzhen: TMenuItem;
    N3: TMenuItem;
    Pop_Naoqu: TMenuItem;
    N5: TMenuItem;
    Pop_step: TMenuItem;
    N7: TMenuItem;
    Pop_zonghe: TMenuItem;
    N9: TMenuItem;
    Pop_Save: TMenuItem;
    N11: TMenuItem;
    Pop_Exit: TMenuItem;
    ImageList1: TImageList;
    BitBtn6: TBitBtn;
    N1: TMenuItem;
    Pop_disptool: TMenuItem;
    procedure FormResize(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure RadioGroup1Click(Sender: TObject);
    procedure Image_FyydMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Pop_JianYueClick(Sender: TObject);
    procedure Pop_FangzhenClick(Sender: TObject);
    procedure Pop_NaoquClick(Sender: TObject);
    procedure Pop_stepClick(Sender: TObject);
    procedure Pop_zongheClick(Sender: TObject);
    procedure Pop_SaveClick(Sender: TObject);
    procedure Pop_ExitClick(Sender: TObject);
    procedure BitBtn6Click(Sender: TObject);
    procedure Pop_disptoolClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
     zk:Tzk_bore;
     gzm: TG_stope;
     imm:Timmediate_roof;
     old:Told_roof ;
     // 局部变量
     pDF:pDrawFyyd;
     ShowScreen:integer;
     {   Leixing 1 挠区算法     2 步距算法 3 综合对比
         Tuli 1 简单图片 图例   2 仿真图例
     }
     Leixing,Tuli:integer;//
     dll_Path_fy:Widestring;
     procedure drawtest(Img1:Timage);    //测试画图
     procedure ClearImage(UsedImg:TImage);  //清空Image
     procedure InitPDF;
     {1-0}
     procedure First_MainDrawImage(UsedImg:Timage);
      {1-1// 初始化图形基本参数}
     procedure First_InitImagBasicParam(UsedImg:Timage);
      {1-2//画覆岩图片的表头 }
     procedure First_Draw_TableHead(UsedImg:Timage);
      {1-3// 作为  填充图表的右侧}
     procedure First_Fill_RockBMP(UsedImg:Timage);
     {1-4 //作为图片第一福最后的补充}
     procedure First_Last_Draw(UsedImg:Timage);
     { // 表头 1-3-1}
     procedure First_Fill_RockBMP_First(UsedImg:Timage;Ycid:integer);
     //1-3-2
     procedure First_Fill_RockBmp_NaoQu_Right(UsedImg:Timage;Ycid:integer) ;
     //1-3-2-1
     procedure First_Fill_RockBmp_NaoQu_Right_Ztc(UsedImg:Timage;Ycid,Ylid:integer);
     //1-3-2-2
     procedure First_Fill_RockBmp_NaoQu_Right_Sdc_1(UsedImg:Timage;Ycid,Ylid:integer);
     //1-3-2-3
     procedure First_Fill_RockBmp_NaoQu_Right_Sdc_2(UsedImg:Timage;Ycid,Ylid:integer);
     //1-3-3
     procedure First_Fill_RockBmp_Step_Right(UsedImg:Timage;Ycid:integer) ;
     //1-3-3-1
     procedure First_Fill_RockBmp_step_Right_Ztc(UsedImg:Timage;Ycid,StepID:integer);
     //1-3-3-2
     procedure First_Fill_RockBmp_step_Right_Sdc_1(UsedImg:Timage;Ycid,StepID:integer);
     //1-3-3-3
     procedure First_Fill_RockBmp_step_Right_Sdc_2(UsedImg:Timage;Ycid,StepID:integer);
     //1-3-4
     procedure First_Fill_RockBMP_TextBH(UsedImg:Timage;Ycid:integer);
     //1-3-5
     procedure First_Fill_RockBMP_ImmRock(UsedImg:Timage;Ycid:integer);
     //1-3-6
     procedure First_Fill_RockBMP_CoalRock(UsedImg:Timage;Ycid:integer);
     //1-3-7
     procedure First_Fill_RockBMP_BottomRock(UsedImg:Timage;Ycid:integer);
     //=============================================================================
      {2-0}
     procedure Second_MainDrawImage(UsedImg:Timage);
      {2-1// 初始化图形基本参数}
     procedure Second_InitImagBasicParam(UsedImg:Timage);
      {2-2//画覆岩图片的表头 }
     procedure Second_Draw_TableHead(UsedImg:Timage);
      {2-3// 画岩梁挠曲算法基本结构}
     procedure Second_Draw_RockBeam(UsedImg:Timage);
      {2-3-1// 画挠曲岩梁的初始值}
     procedure Second_Draw_RockBeam_First(UsedImg:Timage);
      {2-3-2// 作为  挠曲算法岩层遍历的引导}
     procedure Second_Draw_RockBeam_FillData(UsedImg:Timage);
      {2-3-2-1// 作为  挠曲算法岩层遍历填充图例}
     procedure Second_Draw_RockBeam_FillData_Tuli(UsedImg:Timage;Ycid:integer);
      {2-3-2-2// 作为  挠曲算法岩层遍历填充数字}
     procedure Second_Draw_RockBeam_FillData_Beam(UsedImg:Timage;Ycid,Beamid:integer);
      {2-3-2-3// 作为  挠曲算法岩层遍历填充编号}
     procedure Second_Draw_RockBeam_FillData_Bh(UsedImg:Timage;Ycid:integer);
     //=====================
      {2-4// 画岩梁步距算法基本结构}
     procedure Second_Draw_RockStep(UsedImg:Timage);
      {2-4-1// 画步距算法的初始值}
     procedure Second_Draw_RockStep_First(UsedImg:Timage);
      {2-4-2// 作为  步距算法岩层遍历的引导}
     procedure Second_Draw_RockStep_FillData(UsedImg:Timage);
      {2-4-2-1// 作为  步距算法岩层遍历填充图例}
     procedure Second_Draw_RockStep_FillData_Tuli(UsedImg:Timage;Ycid:integer);
      {2-4-2-2// 作为  步距算法岩层遍历填充数字}
     procedure Second_Draw_RockStep_FillData_Beam(UsedImg:Timage;Ycid,Stepid:integer);
      {2-4-2-3// 作为  步距算法岩层遍历填充编号}
     procedure Second_Draw_RockStep_FillData_Bh(UsedImg:Timage;Ycid:integer);
      {2-5// 最后图表的补充}
     procedure Second_Last_Draw(UsedImg:Timage);
      {2-6// 开采建议}
     procedure Second_advice(UsedImg:Timage);


     procedure TransportCallAddDress;
     procedure First_Fill_RockBmp_Left(UsedImg: Timage; Ycid: integer);
     procedure Second_Fill_RockBMP(UsedImg: Timage);
     procedure Second_Fill_RockData(UsedImg: Timage);
     procedure Second_Draw_RockStepm_First(UsedImg: Timage);
     procedure Refresh_Image;
     //
     procedure DispFyydPop(Px,Py:Integer);//显示GraphChart 控制的工具栏
     procedure SetFromWidthAndHeigth(flag:integer);
     // 调整DPI显示
     procedure WMDpiChanged(var Message: TMessage); message WM_DPICHANGED;
  public
    { Public declarations }

  end;

 var
      FormFyyd: TFormFyyd;

  function ShowFyyd_inn(AHandle:THandle;ACaption:string;Width,Heigth,Flag:integer):integer;stdcall;
  procedure Set_fyyd_tu_inn(AHandle:THandle);


implementation
//自己引用


uses Lu_Public_BasicModual, Main_PStope, uLuSqliteDealWith;
{$R *.dfm}
function ShowFyyd_inn(AHandle:THandle;ACaption:string;Width,Heigth,Flag:integer):integer;stdcall;

begin
    if Assigned(FormFyyd) then   FreeAndNil(FormFyyd);
    FormFyyd:=TFormFyyd.Create(nil);
    try
        FormFyyd.Caption:=ACaption;
        FormFyyd.WindowState:= wsNormal;
        FormFyyd.ParentWindow:=Ahandle;
        if Heigth >FormFyyd.Height then
           FormFyyd.Top :=Round((Heigth-FormFyyd.Height)/2)
        else   FormFyyd.Top :=0;
        if Width> FormFyyd.Width then
            FormFyyd.Left:=Round((Width-FormFyyd.Width)/2)
        else  FormFyyd.Left:=0;

        FormFyyd.SetFromWidthAndHeigth(Flag);
        Result:=1;//函数值
    except
         FreeAndNil(FormFyyd);
    end;
end;
 //============
procedure Set_fyyd_tu_inn(AHandle:THandle);
 begin
    if Assigned(FormFyyd) then   FreeAndNil(FormFyyd);
    FormFyyd:=TFormFyyd.Create(nil);
    try
        FormFyyd.WindowState:= wsNormal;
        FormFyyd.ParentWindow:=Ahandle;
        FormFyyd.BitBtn3.Click ;
        if Public_Basic.Licensing  then  Public_Basic.AddSingleTextWaterFormImage(FormFyyd.Image_Fyyd)
            else Public_Basic.AddMultTextWaterFormImage(FormFyyd.Image_Fyyd);

        FormFyyd.Image_Fyyd.Picture.SaveToFile(public_Basic.Get_MyModulePath +'SaveBMP\FYYD\NQF.JPG');
        FormFyyd.BitBtn4.Click ;

         if Public_Basic.Licensing  then  Public_Basic.AddSingleTextWaterFormImage(FormFyyd.Image_Fyyd)
            else Public_Basic.AddMultTextWaterFormImage(FormFyyd.Image_Fyyd);


        FormFyyd.Image_Fyyd.Picture.SaveToFile(public_Basic.Get_MyModulePath +'SaveBMP\FYYD\BJF.JPG');
        FormFyyd.BitBtn5.Click ;

         if Public_Basic.Licensing  then  Public_Basic.AddSingleTextWaterFormImage(FormFyyd.Image_Fyyd)
            else Public_Basic.AddMultTextWaterFormImage(FormFyyd.Image_Fyyd);


        FormFyyd.Image_Fyyd.Picture.SaveToFile(public_Basic.Get_MyModulePath +'SaveBMP\FYYD\ZHSF.JPG');
        //FormFyyd.Show;

    finally
        FreeAndNil(FormFyyd);
    end;
 end;

      //=============================

 procedure TFormFyyd.BitBtn1Click(Sender: TObject);
begin
     self.SaveDialog1.Execute();
     if trim(self.SaveDialog1.FileName)  <>'' then  begin
          if Public_Basic.Licensing  then  Public_Basic.AddSingleTextWaterFormImage(FormFyyd.Image_Fyyd)
            else Public_Basic.AddMultTextWaterFormImage(FormFyyd.Image_Fyyd);

          if SaveDialog1.FilterIndex =2 then  begin
             if ExtractFileExt(SaveDialog1.FileName) <> '.jpg' then
                 SaveDialog1.FileName := ChangeFileExt(SaveDialog1.FileName,'.jpg');
          end else if SaveDialog1.FilterIndex =3 then  begin
             if ExtractFileExt(SaveDialog1.FileName) <> '.png' then
                 SaveDialog1.FileName := ChangeFileExt(SaveDialog1.FileName,'.png');
          end else  begin
             if ExtractFileExt(SaveDialog1.FileName) <> '.bmp' then
                 SaveDialog1.FileName := ChangeFileExt(SaveDialog1.FileName,'.bmp');
          end;
          FormFyyd.Image_Fyyd.Picture.SaveToFile(SaveDialog1.FileName);
     end;

end;

procedure TFormFyyd.BitBtn2Click(Sender: TObject);
begin
   Panel4.Visible:=False;
end;

procedure TFormFyyd.BitBtn3Click(Sender: TObject);
begin
   Leixing:=1;
   First_MainDrawImage(Image_Fyyd);

end;

procedure TFormFyyd.BitBtn4Click(Sender: TObject);
begin
   Leixing:=2;
   First_MainDrawImage(Image_Fyyd);

end;

procedure TFormFyyd.BitBtn5Click(Sender: TObject);
begin
   Leixing:=3;
   Second_MainDrawImage(Image_Fyyd);

end;

procedure TFormFyyd.BitBtn6Click(Sender: TObject);
begin
    Close;
end;

procedure TFormFyyd.ClearImage(UsedImg:TImage);
begin
      UsedImg.Picture.Graphic.assign(nil);
      UsedImg.Picture.Graphic:=nil;
      UsedImg.Canvas.Refresh;
      UsedImg.Canvas.FillRect(UsedImg.ClientRect);
 end;
 procedure TFormFyyd.DispFyydPop(Px, Py: Integer);
begin
   DispPopMemu.Popup(px,py);
end;

//=================
procedure TFormFyyd.First_InitImagBasicParam(UsedImg:Timage);
{
 >> 1-1
 >> 该函数主要实现了
 >> (1) 把Image 图片 的边界进行了初始化
 >> (2) 定义了图片的标题
 >> (3) 计算了显示比例变量
 }
var
 i,k:integer;
begin
     //空白边界初始化
     pDF.TopBlank:=round(UsedImg.Height/30)+50 ;
     pDF.BottomBlank:=round(UsedImg.Height/30);
     pDF.LeftBlank:=round(UsedImg.Width/30)+50;
     pDF.RightBlank:=0;
     pDF.TableH:=20;
     pDF.HanziHeight:=20;
     //判断可采煤层是否最后一层
      if zk.main_coal<zk.Zk_Yc_Count-1 then  begin
         pDF.Yc_Xiabiao:= zk.main_coal+1;
      end else begin
         pDF.Yc_Xiabiao:= zk.main_coal;
      end;
      pDF.Yc_End_Nu:=0;
      pDF.Yl_name_count:=1;
      pDF.Yl_Text_count:=1;
     //判断传入的类型
      if Leixing=1 then  begin  //挠曲算法
         for k := 4 downto 0 do          begin
            if zk.Beam_Def[k].End_Yc_NO >0 then begin
                 pDF.Yc_End_Nu:=zk.Beam_Def[k].End_Yc_NO;
                 pDF.Yl_name_count:=k+1;
                 break;
            end;  //end if
         end;  //end for    k
         //计算两个比例
         pDF.Yl_Text_count:=0;
         for k := pDF.Yl_name_count-1 downto 0 do    begin
            if zk.Beam_Def[k].Sdc_mc >0 then begin
               pDF.Yl_Text_count:=pDF.Yl_Text_count+2;
            end;  //end if
         end;  //end for    k
              //定标题
         pDF.TitleText:='【'+gzm.S_Name+'】工作面【'+zk.Zk_name+'】钻孔数据'+'挠曲算法';

      end else if Leixing=2 then  begin  //else  if  (Leixing=2) then  begin  //步距算法
        for k := 4 downto 0 do     begin
            if zk.Beam_step[k].End_Yc_NO>0 then begin
                 pDF.Yc_End_Nu:=zk.Beam_step[k].End_Yc_NO;
                 pDF.Yl_name_count:=k+1;
                 break;
            end;  //end if
        end;  //end for    k
         //计算两个比例
        pDF.Yl_Text_count:=0;
       for k := pDF.Yl_name_count-1 downto 0 do   begin
          if zk.Beam_step[k].Sdc_mc >0 then begin
             pDF.Yl_Text_count:=pDF.Yl_Text_count+2;
          end;  //end if
       end;  //end for    k

              //定标题
       pDF.TitleText:='【'+gzm.S_Name+'】工作面【'+zk.Zk_name+'】钻孔数据'+'步距算法';
      end;   //end if (Leixing=1) or (Leixing=2) then  begin

      pDF.Y_total_H:=0;


       for I:=pDF.Yc_Xiabiao downto pDF.Yc_End_Nu do  begin
              pDF.Y_total_H:=pDF.Y_total_H+zk.Yc_Rock[i].R_h;
              pDF.Y_Text_Bl:=(UsedImg.Height-pDF.TopBlank-pDF.BottomBlank-pDF.TableH-
                             (zk.Zk_Yc_Count-i)*pDF.HanziHeight)/pDF.Y_total_H;
              if pDF.Y_Text_Bl<0 then  begin
                 pDF.Yc_End_Nu:=I+1;
                 pDF.Y_total_H:=pDF.Y_total_H-zk.Yc_Rock[i].R_h;
                 pDF.Y_Text_Bl:=(UsedImg.Height-pDF.TopBlank-pDF.BottomBlank-pDF.TableH-
                               (zk.Zk_Yc_Count-pDF.Yc_End_Nu)*pDF.HanziHeight)/pDF.Y_total_H;

                 break;
              end;

       end; //end for i
       pDF.Y_Image_BL:=(UsedImg.Height-pDF.TopBlank-pDF.BottomBlank-pDF.TableH)/pDF.Y_total_H;
       pDF.Yl_Name_bl:= (UsedImg.Height-pDF.TopBlank-pDF.BottomBlank-pDF.TableH-
                          (pDF.Yl_name_count+3)*pDF.HanziHeight)/pDF.Y_total_H;
       pDF.Yl_Text_bl:= (UsedImg.Height-pDF.TopBlank-pDF.BottomBlank-pDF.TableH-
                          (pDF.Yl_Text_count+3)*pDF.HanziHeight)/pDF.Y_total_H;


end;

procedure TFormFyyd.First_Last_Draw(UsedImg: Timage);
{
  >> 1-4
  >> 主要实现对图形最后的补充

}
var
  i:integer;
begin
     //画整体竖线  第0根
      UsedImg.Canvas.MoveTo(pDF.LeftBlank-30,pDF.TopBlank-20);
      UsedImg.Canvas.LineTo(pDF.LeftBlank-30,pDF.Pointxy[0].Y);

       //第8根
      UsedImg.Canvas.MoveTo(pDF.LeftBlank+trunc(pDF.ZhuZhuangtu_wid*6.5),pDF.TopBlank-20);
      UsedImg.Canvas.LineTo(pDF.LeftBlank+trunc(pDF.ZhuZhuangtu_wid*6.5),pDF.Pointxy[0].Y);
      //第9根
      UsedImg.Canvas.MoveTo(pDF.LeftBlank+trunc(pDF.ZhuZhuangtu_wid*7.5),pDF.TopBlank-20);
      UsedImg.Canvas.LineTo(pDF.LeftBlank+trunc(pDF.ZhuZhuangtu_wid*7.5),pDF.Pointxy[0].Y);
      //第10根
      for I := 0 to 17 do
         begin
              if i=7 then continue;

              if (i>9) and (i<>17) then  begin
                 if (i=12) or (i=14)  or (i=16)  then begin
                     UsedImg.Canvas.MoveTo(pDF.LeftBlank+trunc(pDF.ZhuZhuangtu_wid*i),pDF.TopBlank);
                 end else begin
                    UsedImg.Canvas.MoveTo(pDF.LeftBlank+trunc(pDF.ZhuZhuangtu_wid*i),pDF.TopBlank-20);
                 end;
                    UsedImg.Canvas.LineTo(pDF.LeftBlank+trunc(pDF.ZhuZhuangtu_wid*i),pDF.Stop_H);
              end else begin
                UsedImg.Canvas.MoveTo(pDF.LeftBlank+trunc(pDF.ZhuZhuangtu_wid*i),pDF.TopBlank-20);
                UsedImg.Canvas.LineTo(pDF.LeftBlank+trunc(pDF.ZhuZhuangtu_wid*i),pDF.Pointxy[0].Y);
              end;

         end;

  //  draw line
      UsedImg.Canvas.Pen.Color :=clBlack;
      //画最后一行线  横线
      UsedImg.Canvas.MoveTo(pDF.LeftBlank-30,pDF.Pointxy[0].Y);
      UsedImg.Canvas.LineTo(pDF.LeftBlank+trunc(pDF.ZhuZhuangtu_wid*7),pDF.Pointxy[0].Y);

end;


procedure TFormFyyd.Image_FyydMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
 var
  pt:Tpoint;

begin
   if Button=mbRight then begin
      pt:= Image_Fyyd.ClientToScreen(Point(0,0));
      DispFyydPop(pt.X+x,pt.Y +y);

   end;
end;

procedure TFormFyyd.InitPDF;
begin
    Dispose(pDF);
    new(pDf);
end;

procedure TFormFyyd.Pop_disptoolClick(Sender: TObject);
begin
     Panel4.Visible:=not  Panel4.Visible;
     if Panel4.Visible then  begin
        Pop_disptool.Caption :='隐藏工具栏';
     end else begin
        Pop_disptool.Caption :='显示工具栏';
     end;
    Refresh_Image;
end;

procedure TFormFyyd.Pop_ExitClick(Sender: TObject);
begin
   Close;
end;

procedure TFormFyyd.Pop_FangzhenClick(Sender: TObject);
begin
    Tuli:=2;    Refresh_Image;
end;

procedure TFormFyyd.Pop_JianYueClick(Sender: TObject);
begin
    Tuli:=1;    Refresh_Image;
end;

procedure TFormFyyd.Pop_NaoquClick(Sender: TObject);
begin
    Leixing:=1;
   First_MainDrawImage(Image_Fyyd);
end;

procedure TFormFyyd.Pop_SaveClick(Sender: TObject);
begin
  BitBtn1.Click ;
end;

procedure TFormFyyd.Pop_stepClick(Sender: TObject);
begin
    Leixing:=2;
   First_MainDrawImage(Image_Fyyd);
end;

procedure TFormFyyd.Pop_zongheClick(Sender: TObject);
begin
    Leixing:=3;
    Second_MainDrawImage(Image_Fyyd);
end;

//主要画图函数
procedure TFormFyyd.First_MainDrawImage(UsedImg:Timage);
{
 >> 1-0 实现对 钻孔 挠曲画法与步距画法的 绘制
 >> 该函数 也是引导函数 主要 有四个函数组成
 >> leixing = 1 or 2
}

begin
      {初始化变量}
      InitPDF;
      {1-1// 初始化图形基本参数}
      First_InitImagBasicParam(UsedImg);
      {1-2//画覆岩图片的表头 }
      First_Draw_TableHead(UsedImg);
      {1-3// 填充图片的整体}
      First_Fill_RockBMP(UsedImg);
      {1-4// 最后的补充}
      First_Last_Draw(UsedImg);
       {标注水印}
      if not public_Basic.Licensing  then
         public_Basic.AddSingleTextWaterFormImage(UsedImg);
end;

procedure TFormFyyd.First_Draw_TableHead(UsedImg: Timage);
  {
   >> 1-2
   >> 主要是画覆岩运动的表头
  }
begin

  //指定柱状图的宽度
    pDF.ZhuZhuangtu_Wid:=round(UsedImg.Width/20);

    ClearImage(UsedImg);
    // //写标题
    UsedImg.Canvas.Font.Size := 18;
    UsedImg.Canvas.TextOut(round((UsedImg.Width-18*length(pDF.TitleText))/2)-4*18,
            round(UsedImg.Height/50),pDF.TitleText);
   //画表头
     UsedImg.Canvas.MoveTo(pDF.LeftBlank-30,pDF.TopBlank-20);
     UsedImg.Canvas.LineTo(pDF.LeftBlank+round(pDF.ZhuZhuangtu_Wid*17),pDF.TopBlank-20);

     UsedImg.Canvas.MoveTo(pDF.LeftBlank-30,pDF.TopBlank+pDF.TableH);
     UsedImg.Canvas.LineTo(pDF.LeftBlank+round(pDF.ZhuZhuangtu_Wid*17),pDF.TopBlank+pDF.TableH);
     UsedImg.Canvas.MoveTo(pDF.LeftBlank+round(pDF.ZhuZhuangtu_Wid*11),pDF.TopBlank);
     UsedImg.Canvas.LineTo(pDF.LeftBlank+round(pDF.ZhuZhuangtu_Wid*17),pDF.TopBlank);


     //===岩层名称

     UsedImg.Canvas.Font.Size := 8;
     UsedImg.Canvas.TextOut(pDF.LeftBlank-29,pDF.TopBlank-10,'编号');
     UsedImg.Canvas.TextOut(pDF.LeftBlank+Round((pDF.ZhuZhuangtu_wid)/2)-25,pDF.TopBlank-10,'岩层名称');
     //写岩层厚度
     UsedImg.Canvas.TextOut(pDF.LeftBlank+round(pDF.ZhuZhuangtu_wid)+
                       Round((pDF.ZhuZhuangtu_wid)/2)-25,pDF.TopBlank-10,'厚度(米)');
     UsedImg.Canvas.TextOut(pDF.LeftBlank+round(pDF.ZhuZhuangtu_wid*2)+
                       Round((pDF.ZhuZhuangtu_wid)/2)-25,pDF.TopBlank-19,'抗压强度');
     UsedImg.Canvas.TextOut(pDF.LeftBlank+round(pDF.ZhuZhuangtu_wid*2)+
                       Round((pDF.ZhuZhuangtu_wid)/2)-10,pDF.TopBlank,'Mpa');
     UsedImg.Canvas.TextOut(pDF.LeftBlank+round(pDF.ZhuZhuangtu_wid*3)+
                       Round((pDF.ZhuZhuangtu_wid)/2)-25,pDF.TopBlank-19,'抗拉强度');
     UsedImg.Canvas.TextOut(pDF.LeftBlank+round(pDF.ZhuZhuangtu_wid*3)+
                       Round((pDF.ZhuZhuangtu_wid)/2)-10,pDF.TopBlank,'Mpa');
     UsedImg.Canvas.TextOut(pDF.LeftBlank+round(pDF.ZhuZhuangtu_wid*4)+
                       Round((pDF.ZhuZhuangtu_wid)/2)-25,pDF.TopBlank-19,'抗剪强度');
     UsedImg.Canvas.TextOut(pDF.LeftBlank+round(pDF.ZhuZhuangtu_wid*4)+
                       Round((pDF.ZhuZhuangtu_wid)/2)-10,pDF.TopBlank,'Mpa');
     UsedImg.Canvas.TextOut(pDF.LeftBlank+round(pDF.ZhuZhuangtu_wid*5)+
                       Round((pDF.ZhuZhuangtu_wid)/2)-15,pDF.TopBlank-19,'容   重');
     UsedImg.Canvas.TextOut(pDF.LeftBlank+round(pDF.ZhuZhuangtu_wid*5)+
                   Round((pDF.ZhuZhuangtu_wid)/2)-10,pDF.TopBlank,'t/m');
     //---------
     UsedImg.Canvas.Font.Size := 7;
     UsedImg.Canvas.TextOut(pDF.LeftBlank+round(pDF.ZhuZhuangtu_wid*5)+
                   Round((pDF.ZhuZhuangtu_wid)/2)+12,pDF.TopBlank-2,'3');
     //--------
     UsedImg.Canvas.Font.Size := 8;

     UsedImg.Canvas.TextOut(pDF.LeftBlank+Round(pDF.ZhuZhuangtu_wid*6.5)+
                       Round((pDF.ZhuZhuangtu_wid)/2)-25,pDF.TopBlank-10,'柱状图');
     UsedImg.Canvas.TextOut(pDF.LeftBlank+Round(pDF.ZhuZhuangtu_wid*8)+
                       Round((pDF.ZhuZhuangtu_wid)/2)-25,pDF.TopBlank-10,'岩梁名称');
     UsedImg.Canvas.TextOut(pDF.LeftBlank+Round(pDF.ZhuZhuangtu_wid*9)+
                       Round((pDF.ZhuZhuangtu_wid)/2)-25,pDF.TopBlank-10,'岩层结构');
     UsedImg.Canvas.TextOut(pDF.LeftBlank+Round(pDF.ZhuZhuangtu_wid*10)+
                       Round((pDF.ZhuZhuangtu_wid)/2)-25,pDF.TopBlank-10,'厚度(米)');
     UsedImg.Canvas.TextOut(pDF.LeftBlank+Round(pDF.ZhuZhuangtu_wid*11.1)+
                       Round((pDF.ZhuZhuangtu_wid)/2),pDF.TopBlank-19,'考虑随动层');
     UsedImg.Canvas.TextOut(pDF.LeftBlank+Round(pDF.ZhuZhuangtu_wid*11)+
                       Round((pDF.ZhuZhuangtu_wid)/2)-25,pDF.TopBlank+1,'初次步距m');
     UsedImg.Canvas.TextOut(pDF.LeftBlank+Round(pDF.ZhuZhuangtu_wid*12)+
                       Round((pDF.ZhuZhuangtu_wid)/2)-25,pDF.TopBlank+1,'周期步距m');
     UsedImg.Canvas.TextOut(pDF.LeftBlank+Round(pDF.ZhuZhuangtu_wid*13.1)+
                       Round((pDF.ZhuZhuangtu_wid)/2),pDF.TopBlank-19,'不考虑随动层');
     UsedImg.Canvas.TextOut(pDF.LeftBlank+Round(pDF.ZhuZhuangtu_wid*13)+
                       Round((pDF.ZhuZhuangtu_wid)/2)-25,pDF.TopBlank+1,'初次步距m');
     UsedImg.Canvas.TextOut(pDF.LeftBlank+Round(pDF.ZhuZhuangtu_wid*14)+
                       Round((pDF.ZhuZhuangtu_wid)/2)-25,pDF.TopBlank+1,'周期步距m');
     UsedImg.Canvas.TextOut(pDF.LeftBlank+Round(pDF.ZhuZhuangtu_wid*15.2)+
                       Round((pDF.ZhuZhuangtu_wid)/2),pDF.TopBlank-19,'综合考虑');
     UsedImg.Canvas.TextOut(pDF.LeftBlank+Round(pDF.ZhuZhuangtu_wid*15)+
                       Round((pDF.ZhuZhuangtu_wid)/2)-25,pDF.TopBlank+1,'初次步距m');
     UsedImg.Canvas.TextOut(pDF.LeftBlank+Round(pDF.ZhuZhuangtu_wid*16)+
                       Round((pDF.ZhuZhuangtu_wid)/2)-25,pDF.TopBlank+1,'周期步距m');


end;

procedure TFormFyyd.First_Fill_RockBMP(UsedImg: Timage);
{
  >> 1-3
  >> 主要实现对左侧 岩层的柱状进行填充

}
var
   i:integer;
begin

   //   // 临时变量初值
   PDF.Pointxy[0].X :=PDF.LeftBlank+Round(PDF.ZhuZhuangtu_wid*6.5);
   PDF.Pointxy[0].Y :=PDF.TopBlank+PDF.TableH;

   PDF.Pointxy[1].X := PDF.Pointxy[0].X+PDF.ZhuZhuangtu_wid;
   PDF.Pointxy[1].Y := PDF.Pointxy[0].Y;

   PDF.YLPoint[0].X:=PDF.LeftBlank+Round(PDF.ZhuZhuangtu_wid*8);
       PDF.YLPoint[0].Y:=PDF.TopBlank+PDF.TableH;
   PDF.YLPoint[1].X:=PDF.YLPoint[0].X+(PDF.ZhuZhuangtu_wid);
       PDF.YLPoint[1].Y:=PDF.YLPoint[0].Y;

   PDF.textHtemp:=PDF.TopBlank+PDF.TableH;
   PDF.Y_total_H:=0;PDF.Y_total_T:=PDF.textHtemp;

   for I := PDF.Yc_End_Nu to PDF.Yc_Xiabiao do begin//岩层的循环
        //填充图例  1-3-1
        First_Fill_RockBMP_First(UsedImg,i);
        //画右侧
        if  Leixing=1 then  begin  //挠曲算法
             // 1-3-2  挠曲法画法
            First_Fill_RockBmp_NaoQu_Right(UsedImg,i);
        end else if Leixing=2 then begin  //else  if  (Leixing=2) then  begin  //步距算法
             // 1-3-3 步距法画法
            First_Fill_RockBmp_Step_Right(UsedImg,i);
        end;
        // 1-3-4  填写编号
        First_Fill_RockBMP_TextBH(UsedImg,i);
        // 1-3-5  填写直接顶
        First_Fill_RockBMP_ImmRock(UsedImg,i);
        // 1-3-6  填写 煤层
        First_Fill_RockBMP_CoalRock(UsedImg,i);
        //1-3-7 填写 底板
        First_Fill_RockBMP_BottomRock(UsedImg,i);
   end;

end;

procedure TFormFyyd.First_Fill_RockBMP_BottomRock(UsedImg: Timage;
  Ycid: integer);
{
  >> 1-3-7
  >> 主要底板
}
begin
      if Ycid>zk.main_coal then  begin

          PDF.YLPoint[2].X :=PDF.LeftBlank+trunc(PDF.ZhuZhuangtu_wid*9);
          PDF.YLPoint[2].Y :=PDF.Pointxy[2].Y ;
          PDF.YLPoint[3].X :=PDF.LeftBlank+trunc(PDF.ZhuZhuangtu_wid*8);
          PDF.YLPoint[3].Y :=PDF.Pointxy[2].Y;

          UsedImg.Canvas.Polygon(PDF.YLPoint) ;
          UsedImg.Canvas.TextOut(trunc((PDF.YLPoint[0].x+PDF.YLPoint[1].x)/2)-25,
                            trunc((PDF.YLPoint[0].Y+PDF.YLPoint[2].Y)/2)-10,'底板');

          UsedImg.Canvas.MoveTo(PDF.YLPoint[3].X,PDF.YLPoint[3].Y);
          UsedImg.Canvas.LineTo( PDF.Pointxy[2].X, PDF.Pointxy[2].Y);

          UsedImg.Canvas.MoveTo(PDF.YLPoint[3].X,PDF.YLPoint[3].Y);
          UsedImg.Canvas.LineTo(PDF.LeftBlank+trunc(PDF.ZhuZhuangtu_wid*17),PDF.YLPoint[3].Y);

      end;
     //=============

     PDF.textHtemp:=PDF.Y_total_T ;
     PDF.Pointxy[1].X :=PDF.LeftBlank+trunc(PDF.ZhuZhuangtu_wid*6.5)+PDF.ZhuZhuangtu_wid;
     PDF.Pointxy[1].Y :=PDF.TopBlank+PDF.TableH+trunc(PDF.Y_total_H*PDF.Y_Image_BL);


     PDF.Pointxy[0].X :=PDF.LeftBlank+trunc(PDF.ZhuZhuangtu_wid*6.5);
     PDF.Pointxy[0].Y :=PDF.TopBlank+PDF.TableH+trunc(PDF.Y_total_H*PDF.Y_Image_BL);
//



end;

procedure TFormFyyd.First_Fill_RockBMP_CoalRock(UsedImg: Timage; Ycid: integer);
{
  >> 1-3-6
  >> 主要画煤层
}
begin
     if Ycid<>zk.main_coal then  exit;

    PDF.YLPoint[2].X :=PDF.LeftBlank+trunc(PDF.ZhuZhuangtu_wid*9);
    PDF.YLPoint[2].Y :=PDF.YLPoint[0].Y+PDF.HanziHeight+trunc(zk.Yc_Rock[Ycid].R_h*PDF.Yl_Name_bl);
    PDF.YLPoint[3].X :=PDF.LeftBlank+trunc(PDF.ZhuZhuangtu_wid*8);
    PDF.YLPoint[3].Y :=PDF.YLPoint[0].Y+PDF.HanziHeight+trunc(zk.Yc_Rock[Ycid].R_h*PDF.Yl_Name_bl);

    UsedImg.Canvas.Polygon(PDF.YLPoint) ;
    UsedImg.Canvas.TextOut(trunc((PDF.YLPoint[0].x+PDF.YLPoint[1].x)/2)-25,
               trunc((PDF.YLPoint[0].Y+PDF.YLPoint[2].Y)/2)-10,'煤层');

    UsedImg.Canvas.MoveTo( PDF.Pointxy[2].X, PDF.Pointxy[2].Y);
    UsedImg.Canvas.Lineto(PDF.YLPoint[3].X,PDF.YLPoint[3].Y);

    PDF.YLPoint[0].X :=PDF.YLPoint[3].x;
    PDF.YLPoint[0].Y := PDF.YLPoint[3].Y;

    PDF.YLPoint[1].X :=PDF.YLPoint[2].X;
    PDF.YLPoint[1].Y :=PDF.YLPoint[2].Y;

end;

procedure TFormFyyd.First_Fill_RockBMP_First(UsedImg: Timage;Ycid: integer);
  {
   >> 该  函数主要是填充右侧图形的 岩层图例
   >> 1-3-1
  }
var
 bmap1:Tbitmap;//创建位图 bitmap1
begin
   bmap1:=Tbitmap.Create;//创建位图 bitmap1

   PDF.Y_total_H:=PDF.Y_total_H+zk.Yc_Rock[Ycid].R_h;
   PDF.Y_total_T:=PDF.Y_total_T+PDF.HanziHeight+zk.Yc_Rock[Ycid].R_h*PDF.Y_Text_Bl;
   PDF.Pointxy[2].X :=PDF.Pointxy[1].X ;
   PDF.Pointxy[2].Y :=PDF.TopBlank+PDF.TableH+Trunc(PDF.Y_total_H*PDF.Y_Image_BL);
   PDF.Pointxy[3].X :=PDF.Pointxy[0].X ;
   PDF.Pointxy[3].Y :=PDF.Pointxy[2].Y ;

   UsedImg.Canvas.Brush.Bitmap:=nil;
   //填充岩层的图例

   if zk.Yc_Rock[Ycid].BmpFile <>'' then begin
       ExPstopeClass.MySqliteTable.GetBMPToSQlite(zk.Yc_Rock[Ycid].BmpFile+'.Bmp',IntToStr(Tuli),bmap1);
       UsedImg.Canvas.Polygon(PDF.Pointxy) ;
       UsedImg.Canvas.Brush.Bitmap:=bmap1;
       if   (PDF.Pointxy[2].Y-PDF.Pointxy[1].Y>4)  then
            UsedImg.Canvas.FloodFill(Trunc((PDF.Pointxy[0].X+PDF.Pointxy[1].X)/2),
                      Trunc((PDF.Pointxy[1].Y+PDF.Pointxy[2].Y)/2),clBlack,fsBorder);
       UsedImg.Canvas.Brush.Bitmap:=nil;
   end;

    FreeAndNil(bmap1);
end;

procedure TFormFyyd.First_Fill_RockBMP_ImmRock(UsedImg: Timage; Ycid: integer);
{
  >>1-3-5
  >> 主要画直接顶
}
var
  s_out:String;
begin
    if Ycid<>imm.Start_No then   exit;

    UsedImg.Canvas.Brush.Color :=Clwhite;
    PDF.YLPoint[2].X :=PDF.LeftBlank+trunc(PDF.ZhuZhuangtu_wid*9);
    PDF.YLPoint[2].Y :=PDF.YLPoint[0].Y+PDF.HanziHeight+trunc(imm.Immroof_M*PDF.Yl_Name_bl);
    PDF.YLPoint[3].X :=PDF.LeftBlank+trunc(PDF.ZhuZhuangtu_wid*8);
    PDF.YLPoint[3].Y :=PDF.YLPoint[0].Y+PDF.HanziHeight+trunc(imm.Immroof_M*PDF.Yl_Name_bl);

    UsedImg.Canvas.Polygon(PDF.YLPoint) ;
    UsedImg.Canvas.TextOut(trunc((PDF.YLPoint[0].x+PDF.YLPoint[1].x)/2)-25,
                       trunc((PDF.YLPoint[0].Y+PDF.YLPoint[2].Y)/2)-10,'直接顶');
    s_out:='直接顶高'+FormatFloat('0.00', imm.Immroof_M )+'米(包括'+
                      FormatFloat('0.00', zk.Yc_Rock[zk.main_coal].R_h-gzm.S_Cg_h-gzm.S_Fm_h)+'米顶煤),初次跨落步距'+
                      FormatFloat('0.00', imm.Immroof_C0 )+'米.';
    UsedImg.Canvas.TextOut(trunc((PDF.YLPoint[0].x+PDF.YLPoint[1].x)/2)+trunc(PDF.ZhuZhuangtu_wid*1)-25,
                      trunc((PDF.YLPoint[0].Y+PDF.YLPoint[2].Y)/2)-10,S_out);

    //画斜线
    UsedImg.Canvas.MoveTo( PDF.Pointxy[2].X, trunc(PDF.Pointxy[2].Y+
                      (zk.Yc_Rock[zk.main_coal].R_h-gzm.S_Cg_h-gzm.S_Fm_h)*PDF.Y_Image_BL));
    UsedImg.Canvas.Lineto(PDF.YLPoint[3].X,PDF.YLPoint[3].Y);

    UsedImg.Canvas.MoveTo(PDF.YLPoint[3].X,PDF.YLPoint[3].Y);
    UsedImg.Canvas.LineTo(PDF.LeftBlank+trunc(PDF.ZhuZhuangtu_wid*17),PDF.YLPoint[3].Y);
    PDF.YLPoint[0].X :=PDF.YLPoint[3].x;
    PDF.YLPoint[0].Y := PDF.YLPoint[3].Y;

    PDF.YLPoint[1].X :=PDF.YLPoint[2].X;
    PDF.YLPoint[1].Y :=PDF.YLPoint[2].Y;


end;

procedure TFormFyyd.First_Fill_RockBmp_Left(UsedImg: Timage; Ycid: integer);

begin

end;


procedure TFormFyyd.First_Fill_RockBmp_NaoQu_Right(UsedImg: Timage;
  Ycid: integer);
  {
 //=========  挠曲计算 画岩梁左边
  >> 1-3-2
}
var
  k:integer;
begin
   for k := PDF.Yl_name_count-1 downto 0 do  begin    // 岩梁的遍历
         if zk.Beam_Def[k].Start_YC_No =Ycid then begin
            //1-3-2-1
            First_Fill_RockBmp_NaoQu_Right_Ztc(UsedImg,Ycid,k);
            if K=0 then  PDF.Stop_H:= PDF.YLPoint[2].Y;

              if zk.Beam_Def[k].Sdc_mc >0 then begin
                 //1-3-2-2
                 First_Fill_RockBmp_NaoQu_Right_Sdc_1(UsedImg,Ycid,k);
              end else begin
                 // 1-3-2-3
                 First_Fill_RockBmp_NaoQu_Right_Sdc_2(UsedImg,Ycid,k);
              end;
            UsedImg.Canvas.Font.Size := 9;
            PDF.YLPoint[0].X := PDF.YLPoint[3].x;
            PDF.YLPoint[0].Y := PDF.YLPoint[3].Y;

            PDF.YLPoint[1].X :=PDF.YLPoint[2].X;
            PDF.YLPoint[1].Y :=PDF.YLPoint[2].Y;
            //  填充之托曾
            PDF.ZtPoint[0].X :=PDF.LeftBlank-30;                                PDF.ZtPoint[0].Y :=trunc(PDF.textHtemp);
            PDF.ZtPoint[1].X :=PDF.LeftBlank-30+trunc(PDF.ZhuZhuangtu_wid*6.5); PDF.ZtPoint[1].Y :=trunc(PDF.textHtemp);
            PDF.ZtPoint[2].X :=PDF.LeftBlank-30+trunc(PDF.ZhuZhuangtu_wid*6.5); PDF.ZtPoint[2].Y :=round(PDF.Y_total_T);
            PDF.ZtPoint[3].X :=PDF.LeftBlank-30;                                PDF.ZtPoint[3].Y :=round(PDF.Y_total_T);

            UsedImg.Canvas.Polygon(PDF.ZtPoint) ;
            UsedImg.Canvas.Brush.Color :=$FF66CC;
            if (PDF.ZtPoint[2].Y-PDF.ZtPoint[1].Y>4)  then
                UsedImg.Canvas.FloodFill( PDF.ZtPoint[0].X +1, PDF.ZtPoint[0].Y+1 ,clBlack,fsBorder);
           // Image1.Canvas.Brush.Color :=Clwhite;

             break;
        end;  //end if
      end;  //end for
end;

procedure TFormFyyd.First_Fill_RockBmp_NaoQu_Right_Sdc_1(UsedImg: Timage; Ycid,
  Ylid: integer);
  {
    >> 1-3-2-2
    // 挠曲计算
   //如果随动层大于0
  }
begin
    PDF.ZtPoint[0].X :=PDF.YLPoint[0].x+Round(PDF.ZhuZhuangtu_wid*1);
    PDF.ZtPoint[0].X :=PDF.YLPoint[0].x+Round(PDF.ZhuZhuangtu_wid*1);
       if (PDF.Y_total_H-zk.Beam_Def[Ylid].Ztc_ms-zk.Beam_Def[Ylid].Sdc_mc)>0 then  begin
             PDF.ZtPoint[0].Y :=PDF.YLPoint[1].Y+PDF.HanziHeight+trunc((zk.Beam_Def[Ylid].Sdc_mc)*PDF.Yl_Text_bl);
       end else begin
             PDF.ZtPoint[0].Y :=PDF.YLPoint[1].Y+trunc(PDF.Y_total_H*PDF.Yl_Text_bl)-PDF.HanziHeight;
       end;
    PDF.ZtPoint[1].Y :=PDF.ZtPoint[0].Y;
    PDF.ZtPoint[1].X :=PDF.YLPoint[1].x+Round(PDF.ZhuZhuangtu_wid*1);
    PDF.ZtPoint[2].X :=PDF.YLPoint[2].x+Round(PDF.ZhuZhuangtu_wid*1);
       PDF.ZtPoint[2].Y :=PDF.YLPoint[2].Y;
    PDF.ZtPoint[3].X :=PDF.YLPoint[3].x+Round(PDF.ZhuZhuangtu_wid*1);
       PDF.ZtPoint[3].Y :=PDF.YLPoint[3].Y;
    UsedImg.Canvas.Polygon(PDF.ZtPoint) ;
    UsedImg.Canvas.Brush.Color :=$FF66CC;

     if   (PDF.ZtPoint[2].Y-PDF.ZtPoint[1].Y>4)  then
          UsedImg.Canvas.FloodFill( PDF.ZtPoint[0].X +1, PDF.ZtPoint[1].Y+1 ,clBlack,fsBorder);
    UsedImg.Canvas.TextOut(round((PDF.YLPoint[0].x+PDF.YLPoint[1].x)/2)+
                  Round(PDF.ZhuZhuangtu_wid*1)-25,round((PDF.ZtPoint[1].Y +PDF.ZtPoint[2].Y )/2)-10,'支托层');

    UsedImg.Canvas.Brush.Color :=Clwhite;
    UsedImg.Canvas.TextOut(round((PDF.YLPoint[0].x+PDF.YLPoint[1].x)/2)+
                   Round(PDF.ZhuZhuangtu_wid*1)-25,round((PDF.YLPoint[0].Y+PDF.ZtPoint[1].Y)/2)-10,'随动层');
    UsedImg.Canvas.TextOut(round((PDF.YLPoint[0].x+PDF.YLPoint[1].x)/2)+Round(PDF.ZhuZhuangtu_wid*2)-10,
                  round((PDF.YLPoint[0].Y+PDF.ZtPoint[1].Y)/2)-10,FormatFloat('0.00', zk.Beam_Def[Ylid].Sdc_mc ));
    UsedImg.Canvas.TextOut(round((PDF.YLPoint[0].x+PDF.YLPoint[1].x)/2)+Round(PDF.ZhuZhuangtu_wid*2)-10,
                  round((PDF.ZtPoint[1].Y +PDF.ZtPoint[2].Y )/2)-10,FormatFloat('0.00', zk.Beam_Def[Ylid].Ztc_ms ));
    //画延长线
    UsedImg.Canvas.MoveTo(PDF.ZtPoint[1].x,PDF.ZtPoint[1].Y  );
    UsedImg.Canvas.LineTo(PDF.ZtPoint[1].x+PDF.ZhuZhuangtu_wid,PDF.ZtPoint[1].Y  );
end;

procedure TFormFyyd.First_Fill_RockBmp_NaoQu_Right_Sdc_2(UsedImg: Timage; Ycid,
  Ylid: integer);
   {
    >> 1-3-2-3
    // 挠曲计算
   //如果随动层小于0
  }
begin
    PDF.ZtPoint[0].X :=PDF.YLPoint[0].x+Round(PDF.ZhuZhuangtu_wid*1);        PDF.ZtPoint[0].Y :=PDF.YLPoint[0].Y;
    PDF.ZtPoint[1].X :=PDF.YLPoint[1].x+Round(PDF.ZhuZhuangtu_wid*1);        PDF.ZtPoint[1].Y :=PDF.YLPoint[1].Y;
    PDF.ZtPoint[2].X :=PDF.YLPoint[2].x+Round(PDF.ZhuZhuangtu_wid*1);        PDF.ZtPoint[2].Y :=PDF.YLPoint[2].Y;
    PDF.ZtPoint[3].X :=PDF.YLPoint[3].x+Round(PDF.ZhuZhuangtu_wid*1);        PDF.ZtPoint[3].Y :=PDF.YLPoint[3].Y;

    UsedImg.Canvas.Polygon(PDF.ZtPoint) ;
    UsedImg.Canvas.Brush.Color :=$FF66CC;
      if   (PDF.ZtPoint[2].Y-PDF.ZtPoint[1].Y>4)  then
         UsedImg.Canvas.FloodFill( trunc((PDF.ZtPoint[0].X+PDF.ZtPoint[1].X )/2),
                   trunc((PDF.ZtPoint[1].Y+PDF.ZtPoint[2].Y)/2 ),clBlack,fsBorder);
    UsedImg.Canvas.TextOut(round((PDF.YLPoint[0].x+PDF.YLPoint[1].x)/2)+
               Round(PDF.ZhuZhuangtu_wid*1)-30,round((PDF.YLPoint[1].Y+PDF.YLPoint[2].Y)/2)-10,'支托层');
    UsedImg.Canvas.Brush.Color :=Clwhite;
    UsedImg.Canvas.TextOut(round((PDF.YLPoint[0].x+PDF.YLPoint[1].x)/2)+Round(PDF.ZhuZhuangtu_wid*2)-10,
              round((PDF.YLPoint[1].Y+PDF.YLPoint[2].Y)/2)-10,FormatFloat('0.00', zk.Beam_Def[Ylid].Ztc_ms ));
    //画延长线
    UsedImg.Canvas.MoveTo(PDF.ZtPoint[1].x,PDF.ZtPoint[1].Y  );
    UsedImg.Canvas.LineTo(PDF.ZtPoint[1].x+PDF.ZhuZhuangtu_wid,PDF.ZtPoint[1].Y  );
end;

procedure TFormFyyd.First_Fill_RockBmp_NaoQu_Right_Ztc(UsedImg: Timage;
  Ycid,Ylid: integer);
{
  // 挠曲计算//岩梁的支托层 画法
   >> 1-3-2-1
}
begin
      PDF.YLPoint[2].X :=PDF.YLPoint[1].X;
      if (PDF.Y_total_H-zk.Beam_Def[Ylid].Ztc_ms-zk.Beam_Def[Ylid].Sdc_mc)>0 then  begin
         PDF.YLPoint[2].Y :=PDF.YLPoint[1].Y+PDF.HanziHeight+
               round((zk.Beam_Def[Ylid].Ztc_ms+zk.Beam_Def[Ylid].Sdc_mc)*PDF.Yl_Name_bl);
      end else begin
         PDF.YLPoint[2].Y :=PDF.YLPoint[1].Y+PDF.HanziHeight+round(PDF.Y_total_h*PDF.Yl_Name_bl);
      end;
      PDF.YLPoint[3].X :=PDF.YLPoint[0].X;
      PDF.YLPoint[3].Y :=PDF.YLPoint[2].Y;
      UsedImg.Canvas.Polygon(PDF.YLPoint) ;
      UsedImg.Canvas.TextOut(round((PDF.YLPoint[0].x+PDF.YLPoint[1].x)/2)-25,
                 round((PDF.YLPoint[0].Y+PDF.YLPoint[2].Y)/2)-10,'第'+IntToStr(Ylid+1)+'岩梁');
      UsedImg.Canvas.TextOut(round((PDF.YLPoint[0].x+PDF.YLPoint[1].x)/2)+
                 Round(PDF.ZhuZhuangtu_wid*3)-10,round((PDF.YLPoint[0].Y+PDF.YLPoint[2].Y)/2)-10,FormatFloat('0.00', zk.Beam_Def[Ylid].Step_0_Compr ));
      UsedImg.Canvas.TextOut(round((PDF.YLPoint[0].x+PDF.YLPoint[1].x)/2)+
                 Round(PDF.ZhuZhuangtu_wid*4)-10,round((PDF.YLPoint[0].Y+PDF.YLPoint[2].Y)/2)-10,FormatFloat('0.00', zk.Beam_Def[Ylid].Step_i_Compr[0] ));
      UsedImg.Canvas.TextOut(round((PDF.YLPoint[0].x+PDF.YLPoint[1].x)/2)+
                 Round(PDF.ZhuZhuangtu_wid*5)-10,round((PDF.YLPoint[0].Y+PDF.YLPoint[2].Y)/2)-10,FormatFloat('0.00', zk.Beam_Def[Ylid].Step_0_Simple ));
      UsedImg.Canvas.TextOut(round((PDF.YLPoint[0].x+PDF.YLPoint[1].x)/2)+
                 Round(PDF.ZhuZhuangtu_wid*6)-10,round((PDF.YLPoint[0].Y+PDF.YLPoint[2].Y)/2)-10,FormatFloat('0.00', zk.Beam_Def[Ylid].step_i_simple[0]));

      UsedImg.Canvas.TextOut(round((PDF.YLPoint[0].x+PDF.YLPoint[1].x)/2)+
                 Round(PDF.ZhuZhuangtu_wid*7)-10,round((PDF.YLPoint[0].Y+PDF.YLPoint[2].Y)/2)-10,
                  FormatFloat('0.00', (zk.Beam_Def[Ylid].Step_0_Compr+zk.Beam_Def[Ylid].Step_0_Simple )/2 ));

      UsedImg.Canvas.TextOut(round((PDF.YLPoint[0].x+PDF.YLPoint[1].x)/2)+
                 Round(PDF.ZhuZhuangtu_wid*8)-10,round((PDF.YLPoint[0].Y+PDF.YLPoint[2].Y)/2)-10,FormatFloat('0.00',
                 (zk.Beam_Def[Ylid].Step_i_Compr[0]+zk.Beam_Def[Ylid].step_i_simple[0])/2));
      //画斜线
      UsedImg.Canvas.MoveTo(PDF.YLPoint[3].X,PDF.YLPoint[3].Y);
      UsedImg.Canvas.LineTo( PDF.Pointxy[2].X, PDF.Pointxy[2].Y);
      // 画延长线
      UsedImg.Canvas.MoveTo(PDF.YLPoint[3].X,PDF.YLPoint[3].Y);
      UsedImg.Canvas.LineTo(PDF.LeftBlank+Round(PDF.ZhuZhuangtu_wid*17),PDF.YLPoint[3].Y);
      //继续写支托层与随动层
      UsedImg.Canvas.Font.Size := 8;
      UsedImg.Canvas.MoveTo(PDF.YLPoint[3].X+Round(PDF.ZhuZhuangtu_wid*5),PDF.YLPoint[2].Y );
      UsedImg.Canvas.LineTo(PDF.YLPoint[2].X+Round(PDF.ZhuZhuangtu_wid*6),PDF.YLPoint[2].Y );


end;

procedure TFormFyyd.First_Fill_RockBmp_Step_Right(UsedImg: Timage;
  Ycid: integer);
 {
 //=========  步距计算 画岩梁左边
  >> 1-3-3
}
var
  k:integer;
begin
   for k := PDF.Yl_name_count-1 downto 0 do  begin    // 岩梁的遍历
         if zk.Beam_step[k].Start_YC_No =Ycid then begin
            //1-3-3-1
            First_Fill_RockBmp_Step_Right_Ztc(UsedImg,Ycid,k);

            if K=0 then  PDF.Stop_H:= PDF.YLPoint[2].Y;

              if zk.Beam_Def[k].Sdc_mc >0 then begin
                 //1-3-3-2
                 First_Fill_RockBmp_Step_Right_Sdc_1(UsedImg,Ycid,k);
              end else begin
                 //  1-3-3-3
                 First_Fill_RockBmp_Step_Right_Sdc_2(UsedImg,Ycid,k);
              end;


            UsedImg.Canvas.Font.Size := 9;
            PDF.YLPoint[0].X := PDF.YLPoint[3].x;
            PDF.YLPoint[0].Y := PDF.YLPoint[3].Y;

            PDF.YLPoint[1].X :=PDF.YLPoint[2].X;
            PDF.YLPoint[1].Y :=PDF.YLPoint[2].Y;
            //  填充之托曾
            PDF.ZtPoint[0].X :=PDF.LeftBlank-30;                                PDF.ZtPoint[0].Y :=trunc(PDF.textHtemp);
            PDF.ZtPoint[1].X :=PDF.LeftBlank-30+trunc(PDF.ZhuZhuangtu_wid*6.5); PDF.ZtPoint[1].Y :=trunc(PDF.textHtemp);
            PDF.ZtPoint[2].X :=PDF.LeftBlank-30+trunc(PDF.ZhuZhuangtu_wid*6.5); PDF.ZtPoint[2].Y :=round(PDF.Y_total_T);
            PDF.ZtPoint[3].X :=PDF.LeftBlank-30;                                PDF.ZtPoint[3].Y :=round(PDF.Y_total_T);

            UsedImg.Canvas.Polygon(PDF.ZtPoint) ;
            UsedImg.Canvas.Brush.Color :=$FF66CC;
            if (PDF.ZtPoint[2].Y-PDF.ZtPoint[1].Y>4)  then
                UsedImg.Canvas.FloodFill( PDF.ZtPoint[0].X +1, PDF.ZtPoint[0].Y+1 ,clBlack,fsBorder);
           // Image1.Canvas.Brush.Color :=Clwhite;

             break;
        end;  //end if
      end;  //end for
end;

procedure TFormFyyd.First_Fill_RockBmp_step_right_Sdc_1(UsedImg: Timage; Ycid,
  StepID: integer);
 {   >> 1-3-3-2
    // 步距计算
   //如果随动层大于0
  }
begin
    PDF.ZtPoint[0].X :=PDF.YLPoint[0].x+Round(PDF.ZhuZhuangtu_wid*1);
    PDF.ZtPoint[0].X :=PDF.YLPoint[0].x+Round(PDF.ZhuZhuangtu_wid*1);
       if (PDF.Y_total_H-zk.Beam_step[StepID].Ztc_ms-zk.Beam_step[StepID].Sdc_mc)>0 then  begin
             PDF.ZtPoint[0].Y :=PDF.YLPoint[1].Y+PDF.HanziHeight+trunc((zk.Beam_step[StepID].Sdc_mc)*PDF.Yl_Text_bl);
       end else begin
             PDF.ZtPoint[0].Y :=PDF.YLPoint[1].Y+trunc(PDF.Y_total_H*PDF.Yl_Text_bl)-PDF.HanziHeight;
       end;
    PDF.ZtPoint[1].Y :=PDF.ZtPoint[0].Y;
    PDF.ZtPoint[1].X :=PDF.YLPoint[1].x+Round(PDF.ZhuZhuangtu_wid*1);
    PDF.ZtPoint[2].X :=PDF.YLPoint[2].x+Round(PDF.ZhuZhuangtu_wid*1);
       PDF.ZtPoint[2].Y :=PDF.YLPoint[2].Y;
    PDF.ZtPoint[3].X :=PDF.YLPoint[3].x+Round(PDF.ZhuZhuangtu_wid*1);
       PDF.ZtPoint[3].Y :=PDF.YLPoint[3].Y;
    UsedImg.Canvas.Polygon(PDF.ZtPoint) ;
    UsedImg.Canvas.Brush.Color :=$FF66CC;

     if   (PDF.ZtPoint[2].Y-PDF.ZtPoint[1].Y>4)  then
          UsedImg.Canvas.FloodFill( PDF.ZtPoint[0].X +1, PDF.ZtPoint[1].Y+1 ,clBlack,fsBorder);
    UsedImg.Canvas.TextOut(round((PDF.YLPoint[0].x+PDF.YLPoint[1].x)/2)+
                  Round(PDF.ZhuZhuangtu_wid*1)-25,round((PDF.ZtPoint[1].Y +PDF.ZtPoint[2].Y )/2)-10,'支托层');

    UsedImg.Canvas.Brush.Color :=Clwhite;
    UsedImg.Canvas.TextOut(round((PDF.YLPoint[0].x+PDF.YLPoint[1].x)/2)+
                   Round(PDF.ZhuZhuangtu_wid*1)-25,round((PDF.YLPoint[0].Y+PDF.ZtPoint[1].Y)/2)-10,'随动层');
    UsedImg.Canvas.TextOut(round((PDF.YLPoint[0].x+PDF.YLPoint[1].x)/2)+Round(PDF.ZhuZhuangtu_wid*2)-10,
                  round((PDF.YLPoint[0].Y+PDF.ZtPoint[1].Y)/2)-10,FormatFloat('0.00', zk.Beam_step[StepID].Sdc_mc ));
    UsedImg.Canvas.TextOut(round((PDF.YLPoint[0].x+PDF.YLPoint[1].x)/2)+Round(PDF.ZhuZhuangtu_wid*2)-10,
                  round((PDF.ZtPoint[1].Y +PDF.ZtPoint[2].Y )/2)-10,FormatFloat('0.00', zk.Beam_step[StepID].Ztc_ms ));
    //画延长线
    UsedImg.Canvas.MoveTo(PDF.ZtPoint[1].x,PDF.ZtPoint[1].Y  );
    UsedImg.Canvas.LineTo(PDF.ZtPoint[1].x+PDF.ZhuZhuangtu_wid,PDF.ZtPoint[1].Y  );

end;

procedure TFormFyyd.First_Fill_RockBmp_step_Right_Sdc_2(UsedImg: Timage; Ycid,
  StepID: integer);
  {  >> 1-3-3-3
    // 步距计算
   //如果随动层小于0
  }
begin
    PDF.ZtPoint[0].X :=PDF.YLPoint[0].x+Round(PDF.ZhuZhuangtu_wid*1);        PDF.ZtPoint[0].Y :=PDF.YLPoint[0].Y;
    PDF.ZtPoint[1].X :=PDF.YLPoint[1].x+Round(PDF.ZhuZhuangtu_wid*1);        PDF.ZtPoint[1].Y :=PDF.YLPoint[1].Y;
    PDF.ZtPoint[2].X :=PDF.YLPoint[2].x+Round(PDF.ZhuZhuangtu_wid*1);        PDF.ZtPoint[2].Y :=PDF.YLPoint[2].Y;
    PDF.ZtPoint[3].X :=PDF.YLPoint[3].x+Round(PDF.ZhuZhuangtu_wid*1);        PDF.ZtPoint[3].Y :=PDF.YLPoint[3].Y;

    UsedImg.Canvas.Polygon(PDF.ZtPoint) ;
    UsedImg.Canvas.Brush.Color :=$FF66CC;
      if   (PDF.ZtPoint[2].Y-PDF.ZtPoint[1].Y>4)  then
         UsedImg.Canvas.FloodFill( trunc((PDF.ZtPoint[0].X+PDF.ZtPoint[1].X )/2),
                   trunc((PDF.ZtPoint[1].Y+PDF.ZtPoint[2].Y)/2 ),clBlack,fsBorder);
    UsedImg.Canvas.TextOut(round((PDF.YLPoint[0].x+PDF.YLPoint[1].x)/2)+
               Round(PDF.ZhuZhuangtu_wid*1)-30,round((PDF.YLPoint[1].Y+PDF.YLPoint[2].Y)/2)-10,'支托层');
    UsedImg.Canvas.Brush.Color :=Clwhite;
    UsedImg.Canvas.TextOut(round((PDF.YLPoint[0].x+PDF.YLPoint[1].x)/2)+Round(PDF.ZhuZhuangtu_wid*2)-10,
              round((PDF.YLPoint[1].Y+PDF.YLPoint[2].Y)/2)-10,FormatFloat('0.00', zk.Beam_step[StepID].Ztc_ms ));
    //画延长线
    UsedImg.Canvas.MoveTo(PDF.ZtPoint[1].x,PDF.ZtPoint[1].Y  );
    UsedImg.Canvas.LineTo(PDF.ZtPoint[1].x+PDF.ZhuZhuangtu_wid,PDF.ZtPoint[1].Y  );

end;

procedure TFormFyyd.First_Fill_RockBmp_step_Right_Ztc(UsedImg: Timage; Ycid,
  StepID: integer);
{
  >> 1-3-3-1
  // 步距计算//岩梁的支托层 画法
}
begin
      PDF.YLPoint[2].X :=PDF.YLPoint[1].X;
      if (PDF.Y_total_H-zk.Beam_step[StepID].Ztc_ms-zk.Beam_step[StepID].Sdc_mc)>0 then  begin
         PDF.YLPoint[2].Y :=PDF.YLPoint[1].Y+PDF.HanziHeight+
               round((zk.Beam_step[StepID].Ztc_ms+zk.Beam_step[StepID].Sdc_mc)*PDF.Yl_Name_bl);
      end else begin
         PDF.YLPoint[2].Y :=PDF.YLPoint[1].Y+PDF.HanziHeight+round(PDF.Y_total_h*PDF.Yl_Name_bl);
      end;
      PDF.YLPoint[3].X :=PDF.YLPoint[0].X;
      PDF.YLPoint[3].Y :=PDF.YLPoint[2].Y;
      UsedImg.Canvas.Polygon(PDF.YLPoint) ;
      UsedImg.Canvas.TextOut(round((PDF.YLPoint[0].x+PDF.YLPoint[1].x)/2)-25,
                 round((PDF.YLPoint[0].Y+PDF.YLPoint[2].Y)/2)-10,'第'+IntToStr(StepID+1)+'岩梁');
      UsedImg.Canvas.TextOut(round((PDF.YLPoint[0].x+PDF.YLPoint[1].x)/2)+
                 Round(PDF.ZhuZhuangtu_wid*3)-10,round((PDF.YLPoint[0].Y+PDF.YLPoint[2].Y)/2)-10,FormatFloat('0.00', zk.Beam_step[StepID].Step_0_Compr ));
      UsedImg.Canvas.TextOut(round((PDF.YLPoint[0].x+PDF.YLPoint[1].x)/2)+
                 Round(PDF.ZhuZhuangtu_wid*4)-10,round((PDF.YLPoint[0].Y+PDF.YLPoint[2].Y)/2)-10,FormatFloat('0.00', zk.Beam_step[StepID].Step_i_Compr[0] ));
      UsedImg.Canvas.TextOut(round((PDF.YLPoint[0].x+PDF.YLPoint[1].x)/2)+
                 Round(PDF.ZhuZhuangtu_wid*5)-10,round((PDF.YLPoint[0].Y+PDF.YLPoint[2].Y)/2)-10,FormatFloat('0.00', zk.Beam_step[StepID].Step_0_Simple ));
      UsedImg.Canvas.TextOut(round((PDF.YLPoint[0].x+PDF.YLPoint[1].x)/2)+
                 Round(PDF.ZhuZhuangtu_wid*6)-10,round((PDF.YLPoint[0].Y+PDF.YLPoint[2].Y)/2)-10,FormatFloat('0.00', zk.Beam_step[StepID].step_i_simple[0]));

      UsedImg.Canvas.TextOut(round((PDF.YLPoint[0].x+PDF.YLPoint[1].x)/2)+
                 Round(PDF.ZhuZhuangtu_wid*7)-10,round((PDF.YLPoint[0].Y+PDF.YLPoint[2].Y)/2)-10,
                  FormatFloat('0.00', (zk.Beam_step[StepID].Step_0_Compr+zk.Beam_step[StepID].Step_0_Simple )/2 ));

      UsedImg.Canvas.TextOut(round((PDF.YLPoint[0].x+PDF.YLPoint[1].x)/2)+
                 Round(PDF.ZhuZhuangtu_wid*8)-10,round((PDF.YLPoint[0].Y+PDF.YLPoint[2].Y)/2)-10,FormatFloat('0.00',
                 (zk.Beam_step[StepID].Step_i_Compr[0]+zk.Beam_step[StepID].step_i_simple[0])/2));
      //画斜线
      UsedImg.Canvas.MoveTo(PDF.YLPoint[3].X,PDF.YLPoint[3].Y);
      UsedImg.Canvas.LineTo( PDF.Pointxy[2].X, PDF.Pointxy[2].Y);
      // 画延长线
      UsedImg.Canvas.MoveTo(PDF.YLPoint[3].X,PDF.YLPoint[3].Y);
      UsedImg.Canvas.LineTo(PDF.LeftBlank+Round(PDF.ZhuZhuangtu_wid*17),PDF.YLPoint[3].Y);
      //继续写支托层与随动层
      UsedImg.Canvas.Font.Size := 8;
      UsedImg.Canvas.MoveTo(PDF.YLPoint[3].X+Round(PDF.ZhuZhuangtu_wid*5),PDF.YLPoint[2].Y );
      UsedImg.Canvas.LineTo(PDF.YLPoint[2].X+Round(PDF.ZhuZhuangtu_wid*6),PDF.YLPoint[2].Y );


end;

procedure TFormFyyd.First_Fill_RockBMP_TextBH(UsedImg: Timage; Ycid: integer);
{
  >> 主要填写岩层的编号与岩层的名称
  >> 1-3-4
}
begin
    //写编号
     UsedImg.Canvas.Font.Size := 8;
     UsedImg.Canvas.MoveTo(PDF.LeftBlank-30+trunc(PDF.ZhuZhuangtu_wid),trunc(PDF.Y_total_T));
     UsedImg.Canvas.LineTo(PDF.LeftBlank-30,trunc(PDF.Y_total_T) );
     UsedImg.Canvas.TextOut(PDF.LeftBlank+trunc((PDF.ZhuZhuangtu_wid)/2)-55,
                    trunc((PDF.textHtemp+PDF.Y_total_T)/2)-8,IntToStr(zk.Yc_Rock[Ycid].Yc_No));
     //写岩层名称
     UsedImg.Canvas.MoveTo(PDF.LeftBlank+trunc(PDF.ZhuZhuangtu_wid*6),trunc(PDF.Y_total_T));
     UsedImg.Canvas.LineTo(PDF.LeftBlank,trunc(PDF.Y_total_T) );
     UsedImg.Canvas.TextOut(PDF.LeftBlank+trunc((PDF.ZhuZhuangtu_wid)/2)-25,
                    trunc((PDF.textHtemp+PDF.Y_total_T)/2)-8,zk.Yc_Rock[Ycid].R_Name);

     //写岩层厚度
      UsedImg.Canvas.TextOut(PDF.LeftBlank+trunc(PDF.ZhuZhuangtu_wid)+trunc((PDF.ZhuZhuangtu_wid)/2)-25,
                    trunc((PDF.textHtemp+PDF.Y_total_T)/2)-8,FormatFloat('0.00',zk.Yc_Rock[Ycid].R_h ));
     //写抗拉
     UsedImg.Canvas.TextOut(PDF.LeftBlank+trunc(PDF.ZhuZhuangtu_wid*2)+trunc((PDF.ZhuZhuangtu_wid)/2)-25,
                    trunc((PDF.textHtemp+PDF.Y_total_T)/2)-8,FormatFloat('0.00',zk.Yc_Rock[Ycid].R_kyqd ));
     UsedImg.Canvas.TextOut(PDF.LeftBlank+trunc(PDF.ZhuZhuangtu_wid*3)+trunc((PDF.ZhuZhuangtu_wid)/2)-25,
                    trunc((PDF.textHtemp+PDF.Y_total_T)/2)-8,FormatFloat('0.00',zk.Yc_Rock[Ycid].R_klqd ));
     UsedImg.Canvas.TextOut(PDF.LeftBlank+trunc(PDF.ZhuZhuangtu_wid*4)+trunc((PDF.ZhuZhuangtu_wid)/2)-25,
                    trunc((PDF.textHtemp+PDF.Y_total_T)/2)-8,FormatFloat('0.00',zk.Yc_Rock[Ycid].R_kjqd ));
     UsedImg.Canvas.TextOut(PDF.LeftBlank+trunc(PDF.ZhuZhuangtu_wid*5)+trunc((PDF.ZhuZhuangtu_wid)/2)-10,
                    trunc((PDF.textHtemp+PDF.Y_total_T)/2)-8,FormatFloat('0.00',zk.Yc_Rock[Ycid].R_r/10 ));



     UsedImg.Canvas.MoveTo(PDF.LeftBlank+trunc(PDF.ZhuZhuangtu_wid*6),trunc(PDF.Y_total_T) );
     UsedImg.Canvas.LineTo( PDF.Pointxy[3].X, PDF.Pointxy[3].Y);

     UsedImg.Canvas.Brush.Color :=Clwhite;
end;

//=========================
procedure TFormFyyd.RadioGroup1Click(Sender: TObject);
begin
   case RadioGroup1.ItemIndex of
      0: Tuli:=1;
      1: Tuli:=2;
   end;
   Refresh_Image;
end;

procedure TFormFyyd.Refresh_Image;
begin
      Image_Fyyd.Picture.Bitmap.Width := Image_Fyyd.ClientWidth;
      Image_Fyyd.Picture.Bitmap.Height := Image_Fyyd.ClientHeight;
      if Leixing=3 then begin
         Second_MainDrawImage(Image_Fyyd);
      end else  begin
         First_MainDrawImage(Image_Fyyd);
      end;
      self.Image_Fyyd.Repaint;
end;

procedure TFormFyyd.Second_advice(UsedImg: Timage);
{
 >> 2-6// 开采建议
}
var
  S_out:String;
  k,Rows,i,j,Count1:integer;
  yc1 :Str_Dt_array;
 begin
     //综合建议
     S_out:='';
     S_out:=imm.Get_Parameter(zk,'1.0');
     k:=1;
     UsedImg.Canvas.TextOut(PDF.LeftBlank+2,PDF.Pointxy[0].Y+ 2,'友情提示：');
     while length(S_out)>0 do begin
        j:=trunc((PDF.ZhuZhuangtu_wid*15+30)/10);
        if K=1 then   begin
           UsedImg.Canvas.TextOut(PDF.LeftBlank+20,PDF.Pointxy[0].Y+20,Copy(s_out,1,j));
        end else begin
           UsedImg.Canvas.TextOut(PDF.LeftBlank+2,PDF.Pointxy[0].Y+5+ k*15,Copy(s_out,1,j));
        end;
       S_out:=copy(s_out,j+1,length(s_out)-j);
       K:=K+1;
     end;

     S_out:=old.Get_Parameter(gzm,zk,imm,'1.0');
     yc1:=Public_Basic.split(S_out,'$',Count1);   //把Zk的标识符批出来
     if Count1>0 then begin
        for I := 0 to 1 do begin
           Rows:=k;S_out:=yc1[i];
           while length(S_out)>0 do begin
              j:=trunc((PDF.ZhuZhuangtu_wid*15+30)/10);
              if K=Rows then   begin
                 UsedImg.Canvas.TextOut(PDF.LeftBlank+20,PDF.Pointxy[0].Y+5+ k*15,Copy(s_out,1,j));
              end else begin
                 UsedImg.Canvas.TextOut(PDF.LeftBlank+2,PDF.Pointxy[0].Y+5+ k*15,Copy(s_out,1,j));
              end;
             S_out:=copy(s_out,j+1,length(s_out)-j);
             K:=K+1;
           end;
        end;
     end;

end;

procedure TFormFyyd.Second_Draw_RockBeam(UsedImg: Timage);
{
   >> 2-3
  >> 主要实现对岩梁挠曲数据的填充

}
begin
     //2-3-1 画挠曲岩梁的初始值
     Second_Draw_RockBeam_First(UsedImg);
     //2-3-2 挠曲算法岩层遍历的引导
     Second_Draw_RockBeam_FillData(UsedImg);
end;

procedure TFormFyyd.Second_Draw_RockBeam_FillData(UsedImg: Timage);
{
   >> 2-3-2// 作为  挠曲算法岩层遍历的引导

}
var
  i,k:integer;
begin
    for I := PDF.Yc_End_Nu to PDF.Yc_Xiabiao do  begin
        //2-3-2-1
        Second_Draw_RockBeam_FillData_Tuli(UsedImg,i);
        //=========   画岩梁左边
        for k := pDf.Yl_name_count-1 downto 0 do
          //2-3-2-2
           Second_Draw_RockBeam_FillData_Beam(UsedImg,i,k);
        //2-3-2-3
        Second_Draw_RockBeam_FillData_Bh(UsedImg,i);

    end;

end;

procedure TFormFyyd.Second_Draw_RockBeam_FillData_Beam(UsedImg: Timage; Ycid,
  Beamid: integer);
{
  >> 2-3-2-2// 作为  挠曲算法岩层遍历填充数字
 }
begin

  if zk.Beam_Def[Beamid].Start_YC_No <> Ycid then exit;

   if Beamid= pDf.Yl_name_count-1 then begin
     pDf.YLPoint[0].X:=pDf.LeftBlank+trunc(pDf.ZhuZhuangtu_wid*4);
     pDf.YLPoint[1].X:=pDf.LeftBlank+trunc(pDf.ZhuZhuangtu_wid*5);
     if (pDf.Y_total_H-zk.Beam_Def[Beamid].Ztc_ms-zk.Beam_Def[Beamid].Sdc_mc)>0 then begin
          pDf.YLPoint[0].Y:=pDf.YLPoint[0].Y+trunc((pDf.Y_total_H-zk.Beam_Def[Beamid].Ztc_ms-
                       zk.Beam_Def[Beamid].Sdc_mc)*pDf.Yl_Name_bl);
     end;
     pDf.YLPoint[1].Y:=pDf.YLPoint[0].Y;
   end else begin
      pDf.YLPoint[0].X :=pDf.YLPoint[3].x;
      pDf.YLPoint[0].Y := pDf.YLPoint[3].Y;

      pDf.YLPoint[1].X :=pDf.YLPoint[2].X;
      pDf.YLPoint[1].Y :=pDf.YLPoint[2].Y;
   end;

    pDf.YLPoint[2].X :=pDf.LeftBlank+trunc(pDf.ZhuZhuangtu_wid*5);
    pDf.YLPoint[2].Y :=pDf.YLPoint[0].Y+pDf.HanziHeight+trunc((zk.Beam_Def[Beamid].Ztc_ms+
                   zk.Beam_Def[Beamid].Sdc_mc)*pDf.Yl_Name_bl);
    pDf.YLPoint[3].X :=pDf.LeftBlank+trunc(pDf.ZhuZhuangtu_wid*4);
    pDf.YLPoint[3].Y :=pDf.YLPoint[0].Y+pDf.HanziHeight+trunc((zk.Beam_Def[Beamid].Ztc_ms+
                   zk.Beam_Def[Beamid].Sdc_mc)*pDf.Yl_Name_bl);
    UsedImg.Canvas.Polygon(pDf.YLPoint) ;
    UsedImg.Canvas.TextOut(trunc((pDf.YLPoint[0].x+pDf.YLPoint[1].x)/2)-25,
                   trunc((pDf.YLPoint[0].Y+pDf.YLPoint[2].Y)/2)-10,'第'+IntToStr(Beamid+1)+'岩梁');
    UsedImg.Canvas.TextOut(trunc((pDf.YLPoint[0].x+pDf.YLPoint[1].x)/2)+
                    trunc(pDf.ZhuZhuangtu_wid*2)-10,trunc((pDf.YLPoint[0].Y+pDf.YLPoint[2].Y)/2)-10,
                    FormatFloat('0.00', (zk.Beam_Def[Beamid].Step_0_Compr+zk.Beam_Def[Beamid].Step_0_Simple )/2 ));
    UsedImg.Canvas.TextOut(trunc((pDf.YLPoint[0].x+pDf.YLPoint[1].x)/2)+
                    trunc(pDf.ZhuZhuangtu_wid*3)-10,trunc((pDf.YLPoint[0].Y+pDf.YLPoint[2].Y)/2)-10,
                    FormatFloat('0.00', (zk.Beam_Def[Beamid].Step_i_Compr[0]+zk.Beam_Def[Beamid].step_i_simple[0])/2));


     //画斜线
    UsedImg.Canvas.MoveTo(pDf.YLPoint[3].X,pDf.YLPoint[3].Y);
    UsedImg.Canvas.LineTo( pDf.Pointxy[2].X, pDf.Pointxy[2].Y);
    UsedImg.Canvas.MoveTo(pDf.YLPoint[3].X,pDf.YLPoint[3].Y);
    UsedImg.Canvas.LineTo(pDf.LeftBlank+trunc(pDf.ZhuZhuangtu_wid*8),pDf.YLPoint[3].Y);
    //继续写支托层与随动层
    UsedImg.Canvas.Font.Size := 8;
    if Beamid=0 then  pDf.Stop_H:= pDf.YLPoint[2].Y;

    if zk.Beam_Def[Beamid].Sdc_mc >0 then begin
        pDf.ZtPoint[0].X :=pDf.YLPoint[0].x+trunc(pDf.ZhuZhuangtu_wid*1);
             pDf.ZtPoint[0].Y :=pDf.YLPoint[0].Y+pDf.HanziHeight+trunc((zk.Beam_Def[Beamid].Sdc_mc)*pDf.Yl_Text_bl);
        pDf.ZtPoint[1].X :=pDf.YLPoint[1].x+trunc(pDf.ZhuZhuangtu_wid*1);
             pDf.ZtPoint[1].Y :=pDf.YLPoint[0].Y+pDf.HanziHeight+trunc((zk.Beam_Def[Beamid].Sdc_mc)*pDf.Yl_Text_bl);
        pDf.ZtPoint[2].X :=pDf.YLPoint[2].x+trunc(pDf.ZhuZhuangtu_wid*1);
             pDf.ZtPoint[2].Y :=pDf.YLPoint[2].Y;
        pDf.ZtPoint[3].X :=pDf.YLPoint[3].x+trunc(pDf.ZhuZhuangtu_wid*1);
             pDf.ZtPoint[3].Y :=pDf.YLPoint[3].Y;
        UsedImg.Canvas.Polygon(pDf.ZtPoint) ;
        UsedImg.Canvas.Brush.Color :=$FF66CC;
          if ( pDf.ZtPoint[2].Y- pDf.ZtPoint[1].Y)>4 then
               UsedImg.Canvas.FloodFill( pDf.ZtPoint[0].X +1, pDf.ZtPoint[0].Y+1 ,clBlack,fsBorder);
        UsedImg.Canvas.TextOut(trunc((pDf.YLPoint[0].x+pDf.YLPoint[1].x)/2)+
               trunc(pDf.ZhuZhuangtu_wid*1)-10,trunc((pDf.YLPoint[2].Y+pDf.YLPoint[0].Y+20+
               trunc((zk.Beam_Def[Beamid].Sdc_mc)*pDf.Yl_Text_bl))/2)-10,FormatFloat('0.00', zk.Beam_Def[Beamid].Ztc_ms ));
        UsedImg.Canvas.Brush.Color :=Clwhite;
        UsedImg.Canvas.MoveTo(pDf.YLPoint[3].X+trunc(pDf.ZhuZhuangtu_wid*1),pDf.YLPoint[0].Y+20+
               trunc((zk.Beam_Def[Beamid].Sdc_mc)*pDf.Yl_Text_bl));
        UsedImg.Canvas.LineTo(pDf.YLPoint[2].X+trunc(pDf.ZhuZhuangtu_wid*1),pDf.YLPoint[0].Y+20+
               trunc((zk.Beam_Def[Beamid].Sdc_mc)*pDf.Yl_Text_bl));
        UsedImg.Canvas.TextOut(trunc((pDf.YLPoint[0].x+pDf.YLPoint[1].x)/2)+trunc(pDf.ZhuZhuangtu_wid*1)-10,
               trunc((pDf.YLPoint[0].Y+pDf.YLPoint[0].Y+20+trunc((zk.Beam_Def[Beamid].Sdc_mc)*pDf.Yl_Text_bl))/2)-10,
               FormatFloat('0.00', zk.Beam_Def[Beamid].Sdc_mc ));


    end else begin
        //  填充支托层
        pDf.ZtPoint[0].X :=pDf.YLPoint[0].x+trunc(pDf.ZhuZhuangtu_wid*1);
              pDf.ZtPoint[0].Y :=pDf.YLPoint[0].Y;
        pDf.ZtPoint[1].X :=pDf.YLPoint[1].x+trunc(pDf.ZhuZhuangtu_wid*1);
              pDf.ZtPoint[1].Y :=pDf.YLPoint[1].Y;
        pDf.ZtPoint[2].X :=pDf.YLPoint[2].x+trunc(pDf.ZhuZhuangtu_wid*1);
              pDf.ZtPoint[2].Y :=pDf.YLPoint[2].Y;
        pDf.ZtPoint[3].X :=pDf.YLPoint[3].x+trunc(pDf.ZhuZhuangtu_wid*1);
              pDf.ZtPoint[3].Y :=pDf.YLPoint[3].Y;

        UsedImg.Canvas.Polygon(pDf.ZtPoint) ;
        UsedImg.Canvas.Brush.Color :=$FF66CC;
             if ( pDf.ZtPoint[2].Y- pDf.ZtPoint[1].Y)>4 then
                UsedImg.Canvas.FloodFill( pDf.ZtPoint[0].X +1, pDf.ZtPoint[0].Y+1 ,clBlack,fsBorder);
        UsedImg.Canvas.TextOut(trunc((pDf.YLPoint[0].x+pDf.YLPoint[1].x)/2)+
                trunc(pDf.ZhuZhuangtu_wid*1)-10,trunc((pDf.YLPoint[0].Y+pDf.YLPoint[2].Y)/2)-10,
                FormatFloat('0.00', zk.Beam_Def[Beamid].Ztc_ms ));
        UsedImg.Canvas.Brush.Color :=Clwhite;
    end;

    UsedImg.Canvas.Font.Size := 8;

    //  填充支托层
    pDf.ZtPoint[0].X :=pDf.LeftBlank-30;
         pDf.ZtPoint[0].Y :=trunc(pDf.textHtemp);
    pDf.ZtPoint[1].X :=pDf.LeftBlank-30+trunc(pDf.ZhuZhuangtu_wid*2.5);
         pDf.ZtPoint[1].Y :=trunc(pDf.textHtemp);
    pDf.ZtPoint[2].X :=pDf.LeftBlank-30+trunc(pDf.ZhuZhuangtu_wid*2.5);
         pDf.ZtPoint[2].Y :=trunc(pDf.Y_total_T);
    pDf.ZtPoint[3].X :=pDf.LeftBlank-30;
         pDf.ZtPoint[3].Y :=trunc(pDf.Y_total_T);

    UsedImg.Canvas.Polygon(pDf.ZtPoint) ;
    UsedImg.Canvas.Brush.Color :=$FF66CC;
    if ( pDf.ZtPoint[2].Y- pDf.ZtPoint[1].Y)>4 then
       UsedImg.Canvas.FloodFill( pDf.ZtPoint[0].X +1, pDf.ZtPoint[0].Y+1 ,clBlack,fsBorder);

end;

procedure TFormFyyd.Second_Draw_RockBeam_FillData_Bh(UsedImg: Timage; Ycid: integer);
   {
    >>2-3-2-3// 作为  挠曲算法岩层遍历填充编号
    }
begin
    //写编号
     UsedImg.Canvas.Font.Size := 8;
     UsedImg.Canvas.MoveTo( pDf.LeftBlank-30+trunc( pDf.ZhuZhuangtu_wid),trunc( pDf.Y_total_T));
     UsedImg.Canvas.LineTo( pDf.LeftBlank-30,trunc( pDf.Y_total_T) );
     UsedImg.Canvas.TextOut( pDf.LeftBlank+trunc(( pDf.ZhuZhuangtu_wid)/2)-55,
                  trunc(( pDf.textHtemp+ pDf.Y_total_T)/2)-8,IntToStr(zk.Yc_Rock[Ycid].Yc_No));
     //写岩层名称
     UsedImg.Canvas.MoveTo( pDf.LeftBlank+trunc( pDf.ZhuZhuangtu_wid*2),trunc( pDf.Y_total_T));
     UsedImg.Canvas.LineTo( pDf.LeftBlank,trunc( pDf.Y_total_T) );
     UsedImg.Canvas.TextOut( pDf.LeftBlank+trunc(( pDf.ZhuZhuangtu_wid)/2)-25,
                   trunc(( pDf.textHtemp+ pDf.Y_total_T)/2)-8,zk.Yc_Rock[Ycid].R_Name);

     //写岩层厚度
     UsedImg.Canvas.TextOut( pDf.LeftBlank+trunc( pDf.ZhuZhuangtu_wid)+trunc(( pDf.ZhuZhuangtu_wid)/2)-25,
                    trunc(( pDf.textHtemp+ pDf.Y_total_T)/2)-8,FormatFloat('0.00',zk.Yc_Rock[Ycid].R_h ));

     UsedImg.Canvas.MoveTo( pDf.LeftBlank+trunc( pDf.ZhuZhuangtu_wid*2),trunc( pDf.Y_total_T) );
     UsedImg.Canvas.LineTo(  pDf.Pointxy[3].X,  pDf.Pointxy[3].Y);

     UsedImg.Canvas.Brush.Color :=Clwhite;
      pDf.textHtemp:= pDf.Y_total_T ;
      pDf.Pointxy[1].X := pDf.Pointxy[2].X;
      pDf.Pointxy[1].Y := pDf.Pointxy[2].Y;


      pDf.Pointxy[0].X := pDf.Pointxy[3].X;
      pDf.Pointxy[0].Y := pDf.Pointxy[3].Y;
end;

procedure TFormFyyd.Second_Draw_RockBeam_FillData_Tuli(UsedImg: Timage;
  Ycid: integer);
  {
    >>2-3-2-1// 作为  挠曲算法岩层遍历填充图例
    }
var
 bmap1:Tbitmap;//创建位图 bitmap1
begin
   bmap1:=Tbitmap.Create;//创建位图 bitmap1

   PDF.Y_total_H:=PDF.Y_total_H+zk.Yc_Rock[Ycid].R_h;
   PDF.Y_total_T:=PDF.Y_total_T+PDF.HanziHeight+zk.Yc_Rock[Ycid].R_h*PDF.Y_Text_Bl;
   PDF.Pointxy[2].X := PDF.Pointxy[1].X;
   PDF.Pointxy[2].Y :=PDF.TopBlank+PDF.TableH+trunc(PDF.Y_total_H*PDF.Y_Image_BL);
   PDF.Pointxy[3].X := PDF.Pointxy[0].X;
   PDF.Pointxy[3].Y := PDF.Pointxy[2].Y ;

   //填充图例  //填充岩层的图例
   UsedImg.Canvas.Brush.Bitmap:=nil;
   if zk.Yc_Rock[Ycid].BmpFile <>'' then begin
       ExPstopeClass.MySqliteTable.GetBMPToSQlite(zk.Yc_Rock[Ycid].BmpFile+'.Bmp',IntToStr(Tuli),bmap1);
       UsedImg.Canvas.Polygon(PDF.Pointxy) ;
       UsedImg.Canvas.Brush.Bitmap:=bmap1;
       if   (PDF.Pointxy[2].Y-PDF.Pointxy[1].Y>4)  then
            UsedImg.Canvas.FloodFill(Trunc((PDF.Pointxy[0].X+PDF.Pointxy[1].X)/2),
                      Trunc((PDF.Pointxy[1].Y+PDF.Pointxy[2].Y)/2),clBlack,fsBorder);
       UsedImg.Canvas.Brush.Bitmap:=nil;
   end;

   FreeAndNil(bmap1);
end;

procedure TFormFyyd.Second_Draw_RockBeam_First(UsedImg: Timage);
{
   >>//2-3-1// 画挠曲岩梁的初始值
}
var
  i,k:integer;
begin
      //   // 挠曲填充临时变量初值
   PDF.Pointxy[0].X :=PDF.LeftBlank+trunc(PDF.ZhuZhuangtu_wid*2.5);
   PDF.Pointxy[0].Y :=PDF.TopBlank+PDF.TableH;

   PDF.Pointxy[1].X :=PDF.Pointxy[0].X+PDF.ZhuZhuangtu_wid;
   PDF.Pointxy[1].Y :=PDF.Pointxy[0].Y;

   PDF.YLPoint[0].X:=PDF.LeftBlank+trunc(PDF.ZhuZhuangtu_wid*4);
       PDF.YLPoint[0].Y:=PDF.TopBlank+PDF.TableH;
   PDF.YLPoint[1].X:=PDF.LeftBlank+trunc(PDF.ZhuZhuangtu_wid*5);
       PDF.YLPoint[1].Y:=PDF.TopBlank+PDF.TableH;
   PDF.YLPoint[3].X:= PDF.YLPoint[0].X; PDF.YLPoint[3].Y:=PDF.YLPoint[0].Y;
   PDF.YLPoint[2].X:= PDF.YLPoint[1].X; PDF.YLPoint[2].Y:=PDF.YLPoint[1].Y;

    PDF.Yl_name_count:=1; PDF.Yl_Text_count:=0;
    for k := 4 downto 0 do     begin
        if zk.Beam_Def[k].End_Yc_NO>0 then begin
             PDF.Yl_name_count:=k+1;
             break;
        end;  //end if
    end;  //end for    k

    PDF.Yl_Text_count:=0;   //随动层
    for k := PDF.Yl_name_count-1 downto 0 do    begin
          if zk.Beam_Def[k].Sdc_mc >0 then begin
             PDF.Yl_Text_count:=PDF.Yl_Text_count+2;
          end;  //end if
    end;  //end for    k


    PDF.Y_total_H:=0;
    {根据显示汉字的行数来确定 最终显示的层数}
     for I:=PDF.Yc_Xiabiao downto PDF.Yc_End_Nu do  begin
          PDF.Y_total_H:=PDF.Y_total_H+zk.Yc_Rock[i].R_h;
          PDF.Y_Text_Bl:=(UsedImg.Height-PDF.TopBlank-PDF.BottomBlank-PDF.TableH-
                        (zk.Zk_Yc_Count-i)*PDF.HanziHeight)/PDF.Y_total_H;
          if PDF.Y_Text_Bl<0 then  begin
             PDF.Yc_End_Nu:=I+1;
             PDF.Y_total_H:=PDF.Y_total_H-zk.Yc_Rock[i].R_h;
             PDF.Y_Text_Bl:=(UsedImg.Height-PDF.TopBlank-PDF.BottomBlank-PDF.TableH-
                     (zk.Zk_Yc_Count-PDF.Yc_End_Nu)*PDF.HanziHeight)/PDF.Y_total_H;
             if PDF.Yc_End_Nu> pDF.NQ_count then  zk.Beam_Def[PDF.Dep_k].End_Yc_NO:=PDF.Yc_End_Nu;
             if PDF.Yc_End_Nu> pDF.Bj_count then  zk.Beam_step[PDF.Step_k].End_Yc_NO:=PDF.Yc_End_Nu;
             break;
          end;
     end;
     //
    PDF.Y_Image_BL:=(UsedImg.Height-PDF.TopBlank-PDF.BottomBlank-PDF.TableH)/PDF.Y_total_H;
    PDF.Yl_Name_bl:= (UsedImg.Height-PDF.TopBlank-PDF.BottomBlank-PDF.TableH-
                  (PDF.Yl_name_count+3)*PDF.HanziHeight)/PDF.Y_total_H;
    PDF.Yl_Text_bl:= (UsedImg.Height-PDF.TopBlank-PDF.BottomBlank-PDF.TableH-
                   (PDF.Yl_Text_count+3)*PDF.HanziHeight)/PDF.Y_total_H;

    PDF.textHtemp:=PDF.TopBlank+PDF.TableH;
    PDF.Y_total_H:=0;PDF.Y_total_T:=PDF.textHtemp;
end;

procedure TFormFyyd.Second_Draw_RockStep(UsedImg: Timage);
{
   >> 2-4
  >> 主要实现对岩梁步距曲数据的填充

}
begin
     //2-4-1 画步距岩梁的初始值
     Second_Draw_RockStep_First(UsedImg);
     //2-4-2 步距算法岩层遍历的引导
     Second_Draw_RockStep_FillData(UsedImg);
end;

procedure TFormFyyd.Second_Draw_RockStepm_First(UsedImg: Timage);
begin

end;

procedure TFormFyyd.Second_Draw_RockStep_FillData(UsedImg: Timage);
{
   >> 2-4-2// 作为  步距算法岩层遍历的引导

}
var
  i,k:integer;
begin
    for I := PDF.Yc_End_Nu to PDF.Yc_Xiabiao do  begin
        //2-4-2-1
        Second_Draw_RockStep_FillData_Tuli(UsedImg,i);

        //=========   画岩梁左边
        for k := pDf.Yl_name_count-1 downto 0 do
          //2-4-2-2
          Second_Draw_RockStep_FillData_Beam(UsedImg,i,k);

        //2-4-2-3
        Second_Draw_RockStep_FillData_Bh(UsedImg,i);
    end;
end;

procedure TFormFyyd.Second_Draw_RockStep_FillData_Beam(UsedImg: Timage; Ycid,
  Stepid: integer);
{
  >> 2-4-2-2// 作为  步距算法岩层遍历填充数字
 }
begin
  if zk.Beam_step[Stepid].Start_YC_No <> Ycid then exit;

  if Stepid= PDF.Yl_name_count-1 then begin
       PDF.YLPoint[0].X:=PDF.LeftBlank+trunc(PDF.ZhuZhuangtu_wid*12);
       PDF.YLPoint[1].X:=PDF.LeftBlank+trunc(PDF.ZhuZhuangtu_wid*13);
       if (PDF.Y_total_H-zk.Beam_step[Stepid].Ztc_ms-zk.Beam_step[Stepid].Sdc_mc)>0 then begin
              PDF.YLPoint[0].Y:=PDF.YLPoint[0].Y+trunc((PDF.Y_total_H-zk.Beam_step[Stepid].Ztc_ms-
            zk.Beam_step[Stepid].Sdc_mc)*PDF.Yl_Name_bl);

       end;
       PDF.YLPoint[1].Y:=PDF.YLPoint[0].Y;
  end else begin
        PDF.YLPoint[0].X :=PDF.YLPoint[3].x;
        PDF.YLPoint[0].Y := PDF.YLPoint[3].Y;

        PDF.YLPoint[1].X :=PDF.YLPoint[2].X;
        PDF.YLPoint[1].Y :=PDF.YLPoint[2].Y;
  end;

    //
    PDF.YLPoint[2].X :=PDF.YLPoint[1].X;
    PDF.YLPoint[2].Y :=PDF.YLPoint[0].Y+PDF.HanziHeight+
                trunc((zk.Beam_step[Stepid].Ztc_ms+zk.Beam_step[Stepid].Sdc_mc)*PDF.Yl_Name_bl);
    PDF.YLPoint[3].X :=PDF.YLPoint[0].X;
    PDF.YLPoint[3].Y :=PDF.YLPoint[2].Y;

    UsedImg.Canvas.Polygon(PDF.YLPoint) ;
    UsedImg.Canvas.TextOut(trunc((PDF.YLPoint[0].x+PDF.YLPoint[1].x)/2)-25,
                trunc((PDF.YLPoint[0].Y+PDF.YLPoint[2].Y)/2)-10,'第'+IntToStr(Stepid+1)+'岩梁');
    UsedImg.Canvas.TextOut(trunc((PDF.YLPoint[0].x+PDF.YLPoint[1].x)/2)-trunc(PDF.ZhuZhuangtu_wid*2)-10,
                trunc((PDF.YLPoint[0].Y+PDF.YLPoint[2].Y)/2)-10,FormatFloat('0.00',
                      (zk.Beam_step[Stepid].Step_0_Compr+zk.Beam_step[Stepid].Step_0_Simple )/2 ));
    UsedImg.Canvas.TextOut(trunc((PDF.YLPoint[0].x+PDF.YLPoint[1].x)/2)-trunc(PDF.ZhuZhuangtu_wid*3)-10,
                trunc((PDF.YLPoint[0].Y+PDF.YLPoint[2].Y)/2)-10,FormatFloat('0.00', (zk.Beam_step[Stepid].Step_i_Compr[0]+
                zk.Beam_step[Stepid].step_i_simple[0])/2));


     //画斜线
    UsedImg.Canvas.MoveTo(PDF.YLPoint[2].X,PDF.YLPoint[2].Y);
    UsedImg.Canvas.LineTo( PDF.Pointxy[3].X, PDF.Pointxy[3].Y);
    UsedImg.Canvas.MoveTo(PDF.YLPoint[3].X,PDF.YLPoint[3].Y);
    UsedImg.Canvas.LineTo(PDF.LeftBlank+trunc(PDF.ZhuZhuangtu_wid*9),PDF.YLPoint[3].Y);
    //继续写支托层与随动层
    UsedImg.Canvas.Font.Size := 8;
    if Stepid=0 then  PDF.Stop_H:= PDF.YLPoint[2].Y;

    if zk.Beam_step[Stepid].Sdc_mc >0 then begin
        PDF.ZtPoint[0].X :=PDF.YLPoint[0].x-trunc(PDF.ZhuZhuangtu_wid*1);
            PDF.ZtPoint[0].Y :=PDF.YLPoint[0].Y+PDF.HanziHeight+trunc((zk.Beam_step[Stepid].Sdc_mc)*PDF.Yl_Text_bl);
        PDF.ZtPoint[1].X :=PDF.YLPoint[1].x-trunc(PDF.ZhuZhuangtu_wid*1);
            PDF.ZtPoint[1].Y :=PDF.YLPoint[0].Y+PDF.HanziHeight+trunc((zk.Beam_step[Stepid].Sdc_mc)*PDF.Yl_Text_bl);
        PDF.ZtPoint[2].X :=PDF.YLPoint[2].x-trunc(PDF.ZhuZhuangtu_wid*1);
            PDF.ZtPoint[2].Y :=PDF.YLPoint[2].Y;
        PDF.ZtPoint[3].X :=PDF.YLPoint[3].x-trunc(PDF.ZhuZhuangtu_wid*1);
           PDF.ZtPoint[3].Y :=PDF.YLPoint[3].Y;
        UsedImg.Canvas.Polygon(PDF.ZtPoint) ;
        UsedImg.Canvas.Brush.Color :=$FF66CC;
        if (PDF.ZtPoint[2].y-PDF.ZtPoint[1].y)>4 then
            UsedImg.Canvas.FloodFill( PDF.ZtPoint[0].X +1, PDF.ZtPoint[0].Y+1 ,clBlack,fsBorder);
        UsedImg.Canvas.TextOut(trunc((PDF.YLPoint[0].x+PDF.YLPoint[1].x)/2)-trunc(PDF.ZhuZhuangtu_wid*1)-10,
                       trunc((PDF.YLPoint[2].Y+PDF.YLPoint[0].Y+20+trunc((zk.Beam_step[Stepid].Sdc_mc)*PDF.Yl_Text_bl))/2)-10,
                       FormatFloat('0.00', zk.Beam_step[Stepid].Ztc_ms ));
        UsedImg.Canvas.Brush.Color :=Clwhite;
        UsedImg.Canvas.MoveTo(PDF.YLPoint[3].X-trunc(PDF.ZhuZhuangtu_wid*1),PDF.YLPoint[0].Y+20+
                      trunc((zk.Beam_step[Stepid].Sdc_mc)*PDF.Yl_Text_bl));
        UsedImg.Canvas.LineTo(PDF.YLPoint[2].X-trunc(PDF.ZhuZhuangtu_wid*1),PDF.YLPoint[0].Y+20+
                      trunc((zk.Beam_step[Stepid].Sdc_mc)*PDF.Yl_Text_bl));
        UsedImg.Canvas.TextOut(trunc((PDF.YLPoint[0].x+PDF.YLPoint[1].x)/2)-trunc(PDF.ZhuZhuangtu_wid*1)-10,
                      trunc((PDF.YLPoint[0].Y+PDF.YLPoint[0].Y+20+trunc((zk.Beam_step[Stepid].Sdc_mc)*PDF.Yl_Text_bl))/2)-10,
                      FormatFloat('0.00', zk.Beam_step[Stepid].Sdc_mc ));


    end else begin
        //  填充之托曾
        PDF.ZtPoint[0].X :=PDF.YLPoint[0].x-trunc(PDF.ZhuZhuangtu_wid*1);
                PDF.ZtPoint[0].Y :=PDF.YLPoint[0].Y;
        PDF.ZtPoint[1].X :=PDF.YLPoint[1].x-trunc(PDF.ZhuZhuangtu_wid*1);
               PDF.ZtPoint[1].Y :=PDF.YLPoint[1].Y;
        PDF.ZtPoint[2].X :=PDF.YLPoint[2].x-trunc(PDF.ZhuZhuangtu_wid*1);
               PDF.ZtPoint[2].Y :=PDF.YLPoint[2].Y;
        PDF.ZtPoint[3].X :=PDF.YLPoint[3].x-trunc(PDF.ZhuZhuangtu_wid*1);
               PDF.ZtPoint[3].Y :=PDF.YLPoint[3].Y;

        UsedImg.Canvas.Polygon(PDF.ZtPoint) ;
        UsedImg.Canvas.Brush.Color :=$FF66CC;
        if (PDF.ZtPoint[2].y-PDF.ZtPoint[1].y)>4 then
             UsedImg.Canvas.FloodFill( PDF.ZtPoint[0].X +1, PDF.ZtPoint[0].Y+1 ,clBlack,fsBorder);
        UsedImg.Canvas.TextOut(trunc((PDF.YLPoint[0].x+PDF.YLPoint[1].x)/2)-trunc(PDF.ZhuZhuangtu_wid*1)-10,
                    trunc((PDF.YLPoint[0].Y+PDF.YLPoint[2].Y)/2)-10,FormatFloat('0.00', zk.Beam_step[Stepid].Ztc_ms ));

        UsedImg.Canvas.Brush.Color :=Clwhite;
    end;
    UsedImg.Canvas.Font.Size := 9;

    //  填充之托曾
    PDF.ZtPoint[0].X :=PDF.LeftBlank+trunc(PDF.ZhuZhuangtu_wid*15);  PDF.ZtPoint[0].Y :=trunc(PDF.textHtemp);
    PDF.ZtPoint[1].X :=PDF.LeftBlank+trunc(PDF.ZhuZhuangtu_wid*16); PDF.ZtPoint[1].Y :=trunc(PDF.textHtemp);
    PDF.ZtPoint[2].X :=PDF.LeftBlank+trunc(PDF.ZhuZhuangtu_wid*16); PDF.ZtPoint[2].Y :=trunc(PDF.Y_total_T);
    PDF.ZtPoint[3].X :=PDF.LeftBlank+trunc(PDF.ZhuZhuangtu_wid*15); PDF.ZtPoint[3].Y :=trunc(PDF.Y_total_T);

    UsedImg.Canvas.Polygon(PDF.ZtPoint) ;
    UsedImg.Canvas.Brush.Color :=$FF66CC;
      if (PDF.ZtPoint[2].y-PDF.ZtPoint[1].y)>4 then
         UsedImg.Canvas.FloodFill( PDF.ZtPoint[0].X +1, PDF.ZtPoint[0].Y+1 ,clBlack,fsBorder);

end;

procedure TFormFyyd.Second_Draw_RockStep_FillData_Bh(UsedImg: Timage;
  Ycid: integer);
begin
     //写编号
     UsedImg.Canvas.Font.Size := 8;
     UsedImg.Canvas.MoveTo(pDf.LeftBlank+trunc(pDf.ZhuZhuangtu_wid*16),trunc(pDf.Y_total_T));
     UsedImg.Canvas.LineTo(pDf.LeftBlank+trunc(pDf.ZhuZhuangtu_wid*16)+30,trunc(pDf.Y_total_T) );
     UsedImg.Canvas.TextOut(pDf.LeftBlank+trunc(pDf.ZhuZhuangtu_wid*16)+5,
                       trunc((pDf.textHtemp+pDf.Y_total_T)/2)-8,IntToStr(zk.Yc_Rock[Ycid].Yc_No));
     //写岩层名称
     UsedImg.Canvas.MoveTo(pDf.LeftBlank+trunc(pDf.ZhuZhuangtu_wid*15),trunc(pDf.Y_total_T));
     UsedImg.Canvas.LineTo(pDf.LeftBlank+trunc(pDf.ZhuZhuangtu_wid*16),trunc(pDf.Y_total_T) );
     UsedImg.Canvas.TextOut(pDf.LeftBlank+trunc(pDf.ZhuZhuangtu_wid*15)+trunc((pDf.ZhuZhuangtu_wid)/2)-25,
                     trunc((pDf.textHtemp+pDf.Y_total_T)/2)-8,zk.Yc_Rock[Ycid].R_Name);
     
     //写岩层厚度
     UsedImg.Canvas.MoveTo(pDf.LeftBlank+trunc(pDf.ZhuZhuangtu_wid*15),trunc(pDf.Y_total_T) );
     UsedImg.Canvas.LineTo( pDf.Pointxy[2].X, pDf.Pointxy[2].Y);
     UsedImg.Canvas.Brush.Color :=Clwhite;

     pDf.textHtemp:=pDf.Y_total_T ;
     pDf.Pointxy[1].X :=pDf.LeftBlank+trunc(pDf.ZhuZhuangtu_wid*13.5)+pDf.ZhuZhuangtu_wid;
     pDf.Pointxy[1].Y :=pDf.TopBlank+pDf.TableH+trunc(pDf.Y_total_H*pDf.Y_Image_BL);


     pDf.Pointxy[0].X :=pDf.LeftBlank+trunc(pDf.ZhuZhuangtu_wid*13.5);
     pDf.Pointxy[0].Y :=pDf.TopBlank+pDf.TableH+trunc(pDf.Y_total_H*pDf.Y_Image_BL);
end;

procedure TFormFyyd.Second_Draw_RockStep_FillData_Tuli(UsedImg: Timage;
  Ycid: integer);
 {
    >>2-4-2-1// 作为  步距算法岩层遍历填充图例
    }
var
 bmap1:Tbitmap;//创建位图 bitmap1
begin
   bmap1:=Tbitmap.Create;//创建位图 bitmap1

   PDF.Y_total_H:=PDF.Y_total_H+zk.Yc_Rock[Ycid].R_h;
   PDF.Y_total_T:=PDF.Y_total_T+PDF.HanziHeight+zk.Yc_Rock[Ycid].R_h*PDF.Y_Text_Bl;
   PDF.Pointxy[2].X := PDF.Pointxy[1].X;
   PDF.Pointxy[2].Y :=PDF.TopBlank+PDF.TableH+trunc(PDF.Y_total_H*PDF.Y_Image_BL);
   PDF.Pointxy[3].X := PDF.Pointxy[0].X;
   PDF.Pointxy[3].Y := PDF.Pointxy[2].Y ;

   //填充图例  //填充岩层的图例
   UsedImg.Canvas.Brush.Bitmap:=nil;
   if zk.Yc_Rock[Ycid].BmpFile <>'' then begin
       ExPstopeClass.MySqliteTable.GetBMPToSQlite(zk.Yc_Rock[Ycid].BmpFile+'.Bmp',IntToStr(Tuli),bmap1);
       UsedImg.Canvas.Polygon(PDF.Pointxy) ;
       UsedImg.Canvas.Brush.Bitmap:=bmap1;
       if   (PDF.Pointxy[2].Y-PDF.Pointxy[1].Y>4)  then
            UsedImg.Canvas.FloodFill(Trunc((PDF.Pointxy[0].X+PDF.Pointxy[1].X)/2),
                      Trunc((PDF.Pointxy[1].Y+PDF.Pointxy[2].Y)/2),clBlack,fsBorder);
       UsedImg.Canvas.Brush.Bitmap:=nil;
   end;

   FreeAndNil(bmap1);

end;

procedure TFormFyyd.Second_Draw_RockStep_First(UsedImg: Timage);
{
   >>//2-4-1// 画步距岩梁的初始值
}
var
  i,k:integer;
begin
    pDf.Yl_name_count:=1;
    for k := 4 downto 0 do   begin
        if zk.Beam_step[k].End_Yc_NO>0 then begin
             pDf.Yl_name_count:=k+1;
             break;
        end;  //end if
      end;  //end for    k
    pDf.Yl_Text_count:=0;

    for k := pDf.Yl_name_count-1 downto 0 do  begin
        if zk.Beam_step[k].Sdc_mc >0 then begin
           pDf.Yl_Text_count:=pDf.Yl_Text_count+2;
        end;  //end if
    end;  //end for    k


    pDf.Y_total_H:=0;

     for I:=pDf.Yc_Xiabiao downto pDf.Yc_End_Nu do  begin
            pDf.Y_total_H:=pDf.Y_total_H+zk.Yc_Rock[i].R_h;

     end;

     pDf.Y_Image_BL:=(UsedImg.Height-pDf.TopBlank-pDf.BottomBlank-pDf.TableH)/pDf.Y_total_H;
     pDf.Yl_Name_bl:= (UsedImg.Height-pDf.TopBlank-pDf.BottomBlank-pDf.TableH-
                     (pDf.Yl_name_count+3)*pDf.HanziHeight)/pDf.Y_total_H;
     pDf.Yl_Text_bl:= (UsedImg.Height-pDf.TopBlank-pDf.BottomBlank-pDf.TableH-
                      (pDf.Yl_Text_count+3)*pDf.HanziHeight)/pDf.Y_total_H;
     pDf.Y_Text_Bl:=(UsedImg.Height-pDf.TopBlank-pDf.BottomBlank-pDf.TableH-
                      (zk.Zk_Yc_Count-pDf.Yc_End_Nu)*pDf.HanziHeight)/pDf.Y_total_H;

         //ShowMessage(FloatToStr(Yl_Name_bl));
         //   // 步距填充临时变量初值
     pDf.Pointxy[0].X :=pDf.LeftBlank+trunc(pDf.ZhuZhuangtu_wid*13.5);
     pDf.Pointxy[0].Y :=pDf.TopBlank+pDf.TableH;

     pDf.Pointxy[1].X :=pDf.Pointxy[0].X+pDf.ZhuZhuangtu_wid;
     pDf.Pointxy[1].Y :=pDf.TopBlank+pDf.TableH;

     pDf.YLPoint[0].X:=pDf.LeftBlank+trunc(pDf.ZhuZhuangtu_wid*12);
          pDf.YLPoint[0].Y:=pDf.TopBlank+pDf.TableH;
     pDf.YLPoint[1].X:=pDf.LeftBlank+trunc(pDf.ZhuZhuangtu_wid*13);
          pDf.YLPoint[1].Y:=pDf.TopBlank+pDf.TableH;

      PDF.YLPoint[3].X:= PDF.YLPoint[0].X; PDF.YLPoint[3].Y:=PDF.YLPoint[0].Y;
      PDF.YLPoint[2].X:= PDF.YLPoint[1].X; PDF.YLPoint[2].Y:=PDF.YLPoint[1].Y;

     pDf.textHtemp:=pDf.TopBlank+pDf.TableH;
     pDf.Y_total_H:=0;pDf.Y_total_T:=pDf.textHtemp;
end;

procedure TFormFyyd.Second_Draw_TableHead(UsedImg: Timage);
 {
   >> 2-2
   >> 主要是画覆岩运动的表头
  }
begin

  //指定柱状图的宽度
    pDF.ZhuZhuangtu_Wid:=round(UsedImg.Width/19);

    ClearImage(UsedImg);
    // //写标题
    UsedImg.Canvas.Font.Size := 18;
    UsedImg.Canvas.TextOut(round((UsedImg.Width-18*length(pDF.TitleText))/2)-4*18,
            round(UsedImg.Height/50),pDF.TitleText);
   //画表头
     UsedImg.Canvas.MoveTo(pDF.LeftBlank-30,pDF.TopBlank-20);
     UsedImg.Canvas.LineTo(pDF.LeftBlank+round(pDF.ZhuZhuangtu_Wid*16)+30,pDF.TopBlank-20);

     UsedImg.Canvas.MoveTo(pDF.LeftBlank-30,pDF.TopBlank+pDF.TableH);
     UsedImg.Canvas.LineTo(pDF.LeftBlank+round(pDF.ZhuZhuangtu_Wid*16)+30,pDF.TopBlank+pDF.TableH);
     UsedImg.Canvas.MoveTo(pDF.LeftBlank+round(pDF.ZhuZhuangtu_Wid*4),pDF.TopBlank);
     UsedImg.Canvas.LineTo(pDF.LeftBlank+round(pDF.ZhuZhuangtu_Wid*13),pDF.TopBlank);


     //===岩层名称

     UsedImg.Canvas.Font.Size := 9;
     UsedImg.Canvas.TextOut(pDF.LeftBlank-29,pDF.TopBlank-10,'编号');
     UsedImg.Canvas.TextOut(pDF.LeftBlank+Round((pDF.ZhuZhuangtu_wid)/2)-25,pDF.TopBlank-10,'岩层名称');
     //写岩层厚度
     UsedImg.Canvas.TextOut(pDF.LeftBlank+trunc(pDF.ZhuZhuangtu_wid)+
                    trunc((pDF.ZhuZhuangtu_wid)/2)-25,pDF.TopBlank-10,'厚度(米)');
     UsedImg.Canvas.TextOut(pDF.LeftBlank+trunc(pDF.ZhuZhuangtu_wid*2.5)+
                    trunc((pDF.ZhuZhuangtu_wid)/2)-25,pDF.TopBlank-10,'柱状图');
     UsedImg.Canvas.TextOut(pDF.LeftBlank+trunc(pDF.ZhuZhuangtu_wid*4)+
                    trunc((pDF.ZhuZhuangtu_wid*3)/2)-30,pDF.TopBlank-19,'挠曲算法参数');
     UsedImg.Canvas.TextOut(pDF.LeftBlank+trunc(pDF.ZhuZhuangtu_wid*4)+
                     trunc((pDF.ZhuZhuangtu_wid)/2)-18,pDF.TopBlank+1,'岩梁结构');
     UsedImg.Canvas.TextOut(pDF.LeftBlank+trunc(pDF.ZhuZhuangtu_wid*5)+
                     trunc((pDF.ZhuZhuangtu_wid)/2)-18,pDF.TopBlank+1,'厚度(米)');          ;
     UsedImg.Canvas.TextOut(pDF.LeftBlank+trunc(pDF.ZhuZhuangtu_wid*6)+
                     trunc((pDF.ZhuZhuangtu_wid)/2)-25,pDF.TopBlank+1,'初次步距m');
     UsedImg.Canvas.TextOut(pDF.LeftBlank+trunc(pDF.ZhuZhuangtu_wid*7)+
                     trunc((pDF.ZhuZhuangtu_wid)/2)-25,pDF.TopBlank+1,'周期步距m');

     UsedImg.Canvas.TextOut(pDF.LeftBlank+trunc(pDF.ZhuZhuangtu_wid*9)+
                     trunc((pDF.ZhuZhuangtu_wid*3)/2)-30,pDF.TopBlank-19,'步距算法参数');
     UsedImg.Canvas.TextOut(pDF.LeftBlank+trunc(pDF.ZhuZhuangtu_wid*9)+
                     trunc((pDF.ZhuZhuangtu_wid)/2)-25,pDF.TopBlank+1,'周期步距m');
     UsedImg.Canvas.TextOut(pDF.LeftBlank+trunc(pDF.ZhuZhuangtu_wid*10)+
                     trunc((pDF.ZhuZhuangtu_wid)/2)-25,pDF.TopBlank+1,'初次步距m');          ;
     UsedImg.Canvas.TextOut(pDF.LeftBlank+trunc(pDF.ZhuZhuangtu_wid*11)+
                      trunc((pDF.ZhuZhuangtu_wid)/2)-18,pDF.TopBlank+1,'厚度m');
     UsedImg.Canvas.TextOut(pDF.LeftBlank+trunc(pDF.ZhuZhuangtu_wid*12)+
                      trunc((pDF.ZhuZhuangtu_wid)/2)-18,pDF.TopBlank+1,'岩梁结构');

     UsedImg.Canvas.TextOut(pDF.LeftBlank+trunc(pDF.ZhuZhuangtu_wid*13.5)+
                      trunc((pDF.ZhuZhuangtu_wid)/2)-25,pDF.TopBlank-10,'柱状图');
     UsedImg.Canvas.TextOut(pDF.LeftBlank+trunc(pDF.ZhuZhuangtu_wid*15)+
                     trunc((pDF.ZhuZhuangtu_wid)/2)-25,pDF.TopBlank-10,'岩层名称');
     UsedImg.Canvas.TextOut(pDF.LeftBlank+trunc(pDF.ZhuZhuangtu_wid*16)+
                     trunc((pDF.ZhuZhuangtu_wid)/2)-25,pDF.TopBlank-10,'编号');



end;

procedure TFormFyyd.Second_Fill_RockBMP(UsedImg: Timage);
begin

end;

procedure TFormFyyd.Second_Fill_RockData(UsedImg: Timage);
begin

end;

procedure TFormFyyd.Second_InitImagBasicParam(UsedImg: Timage);
{
 >> 2-1
 >> 该函数主要实现了
 >> (1) 把Image 图片 的边界进行了初始化
 >> (2) 定义了图片的标题
 >> (3) 计算了显示比例变量
 }
var
 i,k:integer;
begin
     //空白边界初始化
     pDF.TopBlank:=round(UsedImg.Height/30)+50 ;
     pDF.BottomBlank:=round(UsedImg.Height/5);
     pDF.LeftBlank:=round(UsedImg.Width/30)+50;
     pDF.RightBlank:=0;
     pDF.TableH:=20;
     pDF.HanziHeight:=15;
      //定标题
     pDF.TitleText:='【'+gzm.S_Name+'】工作面【'+zk.Zk_name+'】钻孔数据'+'挠曲与步距算法比较图';

    //判断可采煤层是否最后一层
       pDF.NQ_count:=0;  pDF.Bj_count:=0;
      if zk.main_coal<zk.Zk_Yc_Count-1 then  begin
           pDF.Yc_Xiabiao:= zk.main_coal+1;
       end else begin
           pDF.Yc_Xiabiao:= zk.main_coal;
       end;

     for k := 4 downto 0 do     begin
        if zk.Beam_Def[k].End_Yc_NO >0 then begin
             pDF.NQ_count:=zk.Beam_Def[k].End_Yc_NO;
             pDF.Dep_k:=k;
             break;
        end;  //end if
     end;  //end for    k

     for k := 4 downto 0 do           begin
        if zk.Beam_step[k].End_Yc_NO>0 then begin
             pDF.Bj_count:=zk.Beam_step[k].End_Yc_NO;
             pDF.Step_k:=k;
             break;
        end;  //end if
     end;  //end for    k

     if  pDF.NQ_count<  pDF.Bj_count then begin
         pDF.Yc_End_Nu:= pDF.NQ_count;
     end else begin
         pDF.Yc_End_Nu:= pDF.Bj_count;
     end;



end;

procedure TFormFyyd.Second_Last_Draw(UsedImg: Timage);
var
  i:integer;
begin
      //画整体竖线  第0根
      UsedImg.Canvas.MoveTo(pDF.LeftBlank-30,pDF.TopBlank-20);
      UsedImg.Canvas.LineTo(pDF.LeftBlank-30,pDF.Pointxy[0].Y+trunc(UsedImg.Height/6));


      //第10根
      for I := 0 to 16 do
         begin
              if (i=3) or (i=14) then continue;

              if (i=5) or (i=6)  or (i=7) or (i=10) or (i=11)  or (i=12)then begin
                     UsedImg.Canvas.MoveTo(pDF.LeftBlank+trunc(pDF.ZhuZhuangtu_wid*i),pDF.TopBlank);
                 end else begin
                     UsedImg.Canvas.MoveTo(pDF.LeftBlank+trunc(pDF.ZhuZhuangtu_wid*i),pDF.TopBlank-20);
                 end;
              if  (i=8) or (i=9)  then   begin
                  UsedImg.Canvas.Pen.Width :=2;
                  UsedImg.Canvas.Pen.Color :=Clred;
              end else begin
                  UsedImg.Canvas.Pen.Width :=1;
                  UsedImg.Canvas.Pen.Color :=ClBlack;
              end;

             UsedImg.Canvas.LineTo(pDF.LeftBlank+trunc(pDF.ZhuZhuangtu_wid*i),pDF.Pointxy[0].Y);
         end;

      //倒数第2根线 横线
     UsedImg.Canvas.Moveto(pDF.LeftBlank-30,pDF.Pointxy[0].Y);
     UsedImg.Canvas.LineTo(pDF.LeftBlank+trunc(pDF.ZhuZhuangtu_wid*16)+30,pDF.Pointxy[0].Y);
     //倒数第1根线  横线
     UsedImg.Canvas.Moveto(pDF.LeftBlank-30,pDF.Pointxy[0].Y+trunc(UsedImg.Height/6));
     UsedImg.Canvas.LineTo(pDF.LeftBlank+trunc(pDF.ZhuZhuangtu_wid*16)+30,pDF.Pointxy[0].Y+trunc(UsedImg.Height/6));
      //倒数第1根线  竖线
      UsedImg.Canvas.MoveTo(pDF.LeftBlank+trunc(pDF.ZhuZhuangtu_wid*16)+30,pDF.TopBlank-20);
      UsedImg.Canvas.LineTo(pDF.LeftBlank+trunc(pDF.ZhuZhuangtu_wid*16)+30,pDF.Pointxy[0].Y+trunc(UsedImg.Height/6));
      //Image1.Height/10

  //  draw line
      UsedImg.Canvas.Pen.Color :=clBlack;

end;

procedure TFormFyyd.Second_MainDrawImage(UsedImg: Timage);
{
 >> 2-0 实现对 对比钻孔图形 绘制
 >> 该函数 也是引导函数 主要 有四个函数组成
 >> leixing =3
}

begin
      {初始化变量}
      InitPDF;
      {2-1// 初始化图形基本参数}
      Second_InitImagBasicParam(UsedImg);
      {2-2//画覆岩图片的表头 }
      Second_Draw_TableHead(UsedImg);
      {2-3// 画岩梁挠曲算法基本结构}
      Second_Draw_RockBeam(UsedImg);
      {2-4// 画岩梁步距算法基本结构}
      Second_Draw_RockStep(UsedImg);
      {2-5// 最后图表的补充}
      Second_Last_Draw(UsedImg);
      {2-6// 开采建议}
      Second_advice(UsedImg);
      {标注水印}
      if not public_Basic.Licensing  then
         public_Basic.AddSingleTextWaterFormImage(UsedImg);

end;

procedure TFormFyyd.SetFromWidthAndHeigth(flag: integer);
begin
   if Flag=1  then  begin
       ShowScreen:=1;
       Show;
   end else begin
       ShowScreen:=0;
       Show;
   end;
end;

procedure TFormFyyd.TransportCallAddDress;
begin
     zk:= ExPstopeClass.Ex_zk;
     gzm:=ExPstopeClass.Ex_Gzm;
     imm:=ExPstopeClass.Ex_imm_r;
     old:=ExPstopeClass.Ex_old;
end;


procedure TFormFyyd.WMDpiChanged(var Message: TMessage);
  {$IFDEF DELPHI_STYLE_SCALING}
  function FontHeightAtDpi(aDPI, aFontSize: integer): integer;
  var
    tmpCanvas: TCanvas;
  begin
    tmpCanvas := TCanvas.Create;
    try
      tmpCanvas.Handle := GetDC(0);
      tmpCanvas.Font.Assign(self.Font);
      tmpCanvas.Font.PixelsPerInch := aDPI; //must be set BEFORE size
      tmpCanvas.Font.size := aFontSize;
      result := tmpCanvas.TextHeight('0');
    finally
      tmpCanvas.free;
    end;
  end;
  {$ENDIF}

begin
  inherited;
  {$IFDEF DELPHI_STYLE_SCALING}
  ChangeScale(FontHeightAtDpi(LOWORD(Message.wParam), self.Font.Size), FontHeightAtDpi(self.PixelsPerInch, self.Font.Size));
  {$ELSE}
  ChangeScale(LOWORD(Message.wParam), self.PixelsPerInch);
  {$ENDIF}
  self.PixelsPerInch := LOWORD(Message.wParam);


end;

//===========
procedure TFormFyyd.drawtest(Img1:Timage);
begin
     ClearImage(Img1);
     Img1.Canvas.MoveTo(10,10);
          Img1.Canvas.LineTo(Img1.Width,Img1.Height);
end;

procedure TFormFyyd.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
var
   pic_Path:string;
   pt1,pt2:TPoint;
begin
   Pic_Path  :=Public_Basic.Get_MyModulePath+'saveBmp\CoalBMP\OneCoal'+'_0_1.BMP';
   if ShowScreen=1 then begin
      FormFyyd.Image_Fyyd.Picture.SaveToFile(Pic_Path);
   end;

   if Assigned(FormFyyd) then   FreeAndNil(FormFyyd);
end;

procedure TFormFyyd.FormCreate(Sender: TObject);
begin
    Panel4.Visible:=False;
    Leixing:=3;  //
    Tuli:=1;
    New(pDF);
    TransportCallAddDress;

    Refresh_Image;

end;

procedure TFormFyyd.FormDestroy(Sender: TObject);
begin
   Dispose(pDF);
end;

procedure TFormFyyd.FormResize(Sender: TObject);
begin
    Refresh_Image;
end;

procedure TFormFyyd.FormShow(Sender: TObject);
begin
  Refresh_Image;
end;

end. //模块结束标志

unit UIPStopeGuidUnit;

//<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
//<<      文件名：UIPStopeGuidUnit.pas                          <<
//<<      lulei使用的个人Delphi文件                            <<
//<<      该文件是PstopeDll.dll delphi  引用文件           <<
//<<      该文件与 dll文件一同发布，dll不需要注册使用          <<
//<<      创建日期：2018.1.10                                   <<
//<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

interface

uses  Classes;

type

   TDefine_PstopeGuid = class (TObject)
     protected

     public

          //外部函数
        function init_model(const Gzm, zk,Zhijia: Pansichar): Boolean; virtual;abstract;
        procedure OpenFyyd(AHandle:THandle;Caption:Pansichar;Width,Heigth,Flag:integer);virtual;abstract;
        procedure GetFyydBmp(AHandle:THandle);virtual;abstract;
        procedure OpenDTFZ(AHandle:THandle;Caption:Pansichar;Width,Heigth,Flag:integer);virtual;abstract;
        procedure OpenZCYL(AHandle:THandle;Caption:Pansichar;Width,Heigth,Flag:integer);virtual;abstract;
        procedure GetZCYLBmp(AHandle:THandle);virtual;abstract;
        procedure SetDTFZ_JinChi(Value:integer);virtual;abstract;
        procedure GetDTFZBmp(AHandle:THandle);virtual;abstract;
        function  Get_immediate_roof(Version:Pansichar): Pansichar ;virtual;abstract;
        function  Get_Old_roof(Version:Pansichar): Pansichar ;virtual;abstract;
        function Get_kcjstj(const Version: Pansichar): Pansichar; virtual;abstract;
        function  Get_Support_P(Version:Pansichar): Pansichar ;virtual;abstract;
        procedure OpenEditPStopindows(AHandle:THandle;Caption:Pansichar;Width,Heigth,Flag:integer);virtual;abstract;

        function  Get_yklh_ctcs(const Version: Pansichar; width, Hd_wideth, Hd_heigth: Single): Pansichar; virtual;abstract;
        function  Get_yklh_fzzh(const Version: Pansichar): Pansichar; virtual;abstract;
        function  Get_yklh_JJxy(const Version: Pansichar; M_dj, Mzhu_w, T_cong_sj,
                     N_Speed,YK_Speed,HD_Wh_P,HD_JN_P,Coal_ZH_P: Single): Pansichar;virtual;abstract;
        function  Get_Zcyl(const Version: Pansichar; JinChi: Double): Pansichar;virtual;abstract;
        function  VerFityUserName(Var DWName:Pansichar):Boolean;virtual;abstract;
        function GetWinFormIsExsit(WinName:Pansichar):Boolean;virtual;abstract;
         procedure CloseActiveForm(FormStr:Pansichar); virtual;abstract;
         //系统函数
        constructor Create; virtual;abstract;
   end;

   TClassStateMent_PStopeGuid = class of TDefine_PstopeGuid;

implementation

end.

unit uHintWin;
interface
uses
Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
Dialogs,CommCtrl;

type
THintWin = class(THintWindow)
private
    FLastActive:   THandle;
public
    procedure   ActivateHint(hWnd:DWORD;Const   AHint:string);
end;

implementation



{ THintWin }
procedure   AddTipTool(hWnd:   DWORD;   IconType:   Integer;   Title,   Text:   PChar);
const
  TTS_BALLOON   =$0040 ;                  //ToolTip��ʾ���ڵ����Σ�ָ��Ϊ������
  TTM_SETTITLE=WM_USER +32;         //������ʾ������Ϣ����Ϣ
var
  hWndTip:   DWORD;
  ToolInfo:   TToolInfo;
begin
  hWndTip:=CreateWindow(TOOLTIPS_CLASS,   nil,
                  WS_POPUP   or   TTS_NOPREFIX   or   TTS_BALLOON   or   TTS_ALWAYSTIP ,
                  0,   0,   0,   0,   hWnd,   0,   HInstance,   nil);
  if   (hWndTip <> 0)   then
  begin
      ToolInfo.cbSize:=SizeOf(ToolInfo);                                             //����ToolInfo�Ĵ�С
      ToolInfo.uFlags:=TTF_IDISHWND   or   TTF_SUBCLASS   or   TTF_TRANSPARENT;      //���û������
      ToolInfo.uId:=hWnd;                                                            //���������ߵľ��
      ToolInfo.lpszText:=Text;
      SendMessage(hWndTip,TTM_ADDTOOL,1,Integer(@ToolInfo));
      SendMessage(hWndTip,TTM_SETTITLE,2,Integer(Title));            //�������ݴ������ʾͼ��ͱ�����Ϣ
      SendMessage(hWndTip, TTM_SETTIPBKCOLOR, $D2FAFA, 0);          //���ñ���ɫ
      SendMessage(hWndTip, TTM_SETTIPTEXTCOLOR, $4040 , 0);        //����������ɫ
  end;
  InitCommonControls();

end;

procedure THintWin.ActivateHint(hWnd:DWORD;const AHint: string);
begin
//inherited;
//    if   FLastActive <> WindowFromPoint(Mouse.CursorPos)   then
//    AddTipTool(WindowFromPoint(Mouse.CursorPos),1,'',   PChar(AHint));//Application.Hint));
//    FLastActive:=WindowFromPoint(Mouse.CursorPos);
      if   FLastActive <> hWnd   then
         AddTipTool(hWnd,1,'',   PChar(AHint));//Application.Hint));
      FLastActive:=hWnd;
end;

initialization
Application.HintPause:=0;
Application.ShowHint:=False;
HintWindowClass:=THintWin;
Application.ShowHint:=True;

end.
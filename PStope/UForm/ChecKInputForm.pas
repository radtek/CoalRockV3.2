unit ChecKInputForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls,IniFiles;

type
  TCheckForm = class(TForm)
    Button4: TButton;
    Label1: TLabel;
    E_Mc: TEdit;
    Label2: TLabel;
    E_step: TEdit;
    Label3: TLabel;
    E_Max: TEdit;
    Label4: TLabel;
    E_Min: TEdit;
    Label5: TLabel;
    E_S_min: TEdit;
    Label6: TLabel;
    E_S_Max: TEdit;
    Button1: TButton;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    E_JinChi: TEdit;
    Label11: TLabel;
    Label12: TLabel;
    ComboBox1: TComboBox;
    ComboBox2: TComboBox;
    Label13: TLabel;
    procedure E_McKeyPress(Sender: TObject; var Key: Char);
    procedure E_McExit(Sender: TObject);
    procedure E_stepKeyPress(Sender: TObject; var Key: Char);
    procedure E_MaxKeyPress(Sender: TObject; var Key: Char);
    procedure E_MinKeyPress(Sender: TObject; var Key: Char);
    procedure E_S_minKeyPress(Sender: TObject; var Key: Char);
    procedure E_S_MaxKeyPress(Sender: TObject; var Key: Char);
    procedure E_stepExit(Sender: TObject);
    procedure E_MaxExit(Sender: TObject);
    procedure E_MinExit(Sender: TObject);
    procedure E_S_minExit(Sender: TObject);
    procedure E_S_MaxExit(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure E_JinChiKeyPress(Sender: TObject; var Key: Char);
    procedure E_JinChiExit(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure E_McClick(Sender: TObject);
    procedure E_stepClick(Sender: TObject);
    procedure E_MaxClick(Sender: TObject);
    procedure E_MinClick(Sender: TObject);
    procedure E_S_minClick(Sender: TObject);
    procedure E_S_MaxClick(Sender: TObject);
    procedure E_JinChiClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure InitForm(Sender: TObject);
  end;

var
  CheckForm: TCheckForm;

implementation

uses UnF_CDFz, Main_PStope;

{$R *.dfm}

procedure TCheckForm.Button1Click(Sender: TObject);
begin
     close();
end;

procedure TCheckForm.Button4Click(Sender: TObject);
begin
      ExPstopeClass.Ex_Gzm.Mc_FdBs:=StrToFloat(self.E_Mc.Text);// :=FormatFloat('0.00',P_stope.t_Gzm.Mc_FdBs );
      FormCdmn_inn.Step_x:=StrToFloat(self.E_step.Text);//:=FormatFloat('0.00',FormCdmn_inn.Step_x);
      FormCdmn_inn.Zoom_max:=StrToFloat(self.E_Max.Text);//:= FormatFloat('0.00',FormCdmn_inn.Zoom_max);
      FormCdmn_inn.Zoom_min:=StrToFloat(self.E_min.Text);//:= FormatFloat('0.00',FormCdmn_inn.Zoom_min);
      FormCdmn_inn.Step_end:=StrToFloat(self.E_S_Max.Text);//:= FormatFloat('0',FormCdmn_inn.Step_end);
      FormCdmn_inn.Step_start:=StrToFloat(self.E_S_min.Text);//:= FormatFloat('0',FormCdmn_inn.Step_start);
      FormCdmn_inn.Leiji_Jinchi:=StrToFloat(self.E_JinChi.Text);
      FormCdmn_inn.Model_l:=self.ComboBox1.ItemIndex;
      if combobox2.ItemIndex=0 then  begin
          FormCdmn_inn.hcd_bl :=0.2;
      end else if combobox2.ItemIndex=1 then  begin
          FormCdmn_inn.hcd_bl :=0.5;
      end else if combobox2.ItemIndex=2 then  begin
          FormCdmn_inn.hcd_bl :=0.8;
      end else if combobox2.ItemIndex=3 then  begin
          FormCdmn_inn.hcd_bl :=1;
      end;
      ExPstopeClass.Ex_Cal_show.model_l:=FormCdmn_inn.Model_l;
      ExPstopeClass.Ex_Cal_show.hcd_bl:= FormCdmn_inn.hcd_bl;

      FormCdmn_inn. Draw_Fyyd_DTFZ_new;
      FormCdmn_inn.StatusBar1.Panels[0].Text :='当前推进到：'+FormatFloat('0.00',FormCdmn_inn.Leiji_Jinchi)+'米';

      close();
end;

procedure TCheckForm.ComboBox1Change(Sender: TObject);
begin
   if combobox1.ItemIndex=0 then begin
      combobox2.Enabled :=true;
      if FormCdmn_inn.hcd_bl =0.2 then  begin
          combobox2.ItemIndex :=0;
      end else if FormCdmn_inn.hcd_bl =0.5 then  begin
          combobox2.ItemIndex :=1;
      end else if FormCdmn_inn.hcd_bl =0.8 then  begin
          combobox2.ItemIndex :=2;
      end else if FormCdmn_inn.hcd_bl =1 then  begin
          combobox2.ItemIndex :=3;
      end;

   end;

end;

procedure TCheckForm.E_JinChiClick(Sender: TObject);
begin
   E_JinChi.SetFocus;
end;

procedure TCheckForm.E_JinChiExit(Sender: TObject);
begin
    if Strtofloat(E_JinChi.Text)> ExPstopeClass.Ex_Gzm.S_L_qx*2  then  begin
        E_JinChi.Text:=FormatFloat('0',ExPstopeClass.Ex_Gzm.S_L_qx*2);;
    end;
     if Strtofloat(E_JinChi.Text)<5  then  begin
        E_JinChi.Text:='5';
    end;
end;

procedure TCheckForm.E_JinChiKeyPress(Sender: TObject; var Key: Char);
begin
    if not (key in ['0'..'9','.',#8]) then key:=#0  ;
end;

procedure TCheckForm.E_MaxClick(Sender: TObject);
begin
    E_Max.SetFocus ;
end;

procedure TCheckForm.E_MaxExit(Sender: TObject);
begin
     if Strtofloat(E_Max.Text)> 5  then  begin
        E_Max.Text:='5';
    end;
     if Strtofloat(E_Max.Text)<1  then  begin
        E_Max.Text:='1';
    end;
end;

procedure TCheckForm.E_MaxKeyPress(Sender: TObject; var Key: Char);
begin
   if not (key in ['0'..'9','.',#8]) then key:=#0  ;
end;

procedure TCheckForm.E_McClick(Sender: TObject);
begin
    E_Mc.SetFocus;
end;

procedure TCheckForm.E_McExit(Sender: TObject);
begin
    if Strtofloat(E_Mc.Text)> 3  then  begin
        E_Mc.Text:='3';
    end;
     if Strtofloat(E_Mc.Text)< 0.5  then  begin
        E_Mc.Text:='0.5';
    end;

end;

procedure TCheckForm.E_McKeyPress(Sender: TObject; var Key: Char);
begin
      if not (key in ['0'..'9','.',#8]) then key:=#0  ;
end;

procedure TCheckForm.E_MinClick(Sender: TObject);
begin
   E_min.SetFocus;
end;

procedure TCheckForm.E_MinExit(Sender: TObject);
begin
    if Strtofloat(E_Min.Text)> 1  then  begin
        E_Min.Text:='1';
    end;
     if Strtofloat(E_Min.Text)<0.1  then  begin
        E_Min.Text:='0.1';
    end;
end;

procedure TCheckForm.E_MinKeyPress(Sender: TObject; var Key: Char);
begin
     if not (key in ['0'..'9','.',#8]) then key:=#0  ;
end;

procedure TCheckForm.E_stepClick(Sender: TObject);
begin
  E_STEP.SetFocus ;
end;

procedure TCheckForm.E_stepExit(Sender: TObject);
begin
    if Strtofloat(E_step.Text)> 10  then  begin
        E_step.Text:='10';
    end;
     if Strtofloat(E_step.Text)< 0.1  then  begin
        E_step.Text:='0.1';
    end;
end;

procedure TCheckForm.E_stepKeyPress(Sender: TObject; var Key: Char);
begin
       if not (key in ['0'..'9','.',#8]) then key:=#0  ;
end;

procedure TCheckForm.E_S_MaxClick(Sender: TObject);
begin
    E_S_max.SetFocus ;
end;

procedure TCheckForm.E_S_MaxExit(Sender: TObject);
begin
     if Strtofloat(E_S_Max.Text)> ExPstopeClass.Ex_Gzm.S_L_qx*2  then  begin
        E_S_Max.Text:=FormatFloat('0',ExPstopeClass.Ex_Gzm.S_L_qx*2);;
    end;
     if Strtofloat(E_S_Max.Text)<10  then  begin
        E_S_Max.Text:='10';
    end;
end;

procedure TCheckForm.E_S_MaxKeyPress(Sender: TObject; var Key: Char);
begin
   if not (key in ['0'..'9','.',#8]) then key:=#0  ;
end;

procedure TCheckForm.E_S_minClick(Sender: TObject);
begin
  E_S_min.SetFocus;
end;

procedure TCheckForm.E_S_minExit(Sender: TObject);
begin
     if Strtofloat(E_S_min.Text)> ExPstopeClass.Ex_Gzm.S_L_qx  then  begin
        E_S_min.Text:=FormatFloat('0',ExPstopeClass.Ex_Gzm.S_L_qx);;
    end;
     if Strtofloat(E_S_min.Text)<0  then  begin
        E_S_min.Text:='0';
    end;
end;

procedure TCheckForm.E_S_minKeyPress(Sender: TObject; var Key: Char);
begin
     if not (key in ['0'..'9','.',#8]) then key:=#0  ;
end;

procedure TCheckForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
    if Assigned(CheckForm) then  FreeAndNil(CheckForm);
end;

procedure TCheckForm.InitForm(Sender: TObject);
  begin
      self.E_Mc.Text:=FormatFloat('0.00',ExPstopeClass.Ex_Gzm.Mc_FdBs );
      self.E_step.Text:=FormatFloat('0.00',FormCdmn_inn.Step_x);
      self.E_Max.Text:= FormatFloat('0.00',FormCdmn_inn.Zoom_max);
      self.E_min.Text:= FormatFloat('0.00',FormCdmn_inn.Zoom_min);
      self.E_S_Max.Text:= FormatFloat('0',FormCdmn_inn.Step_end);
      self.E_S_min.Text:= FormatFloat('0',FormCdmn_inn.Step_start);
      self.E_JinChi.Text:= FormatFloat('0',FormCdmn_inn.Leiji_Jinchi);
      self.ComboBox1.ItemIndex := FormCdmn_inn.Model_l;

  end;
end.

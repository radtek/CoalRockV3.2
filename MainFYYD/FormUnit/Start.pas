unit Start;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, Vcl.ComCtrls;

type
  TKcover = class(TForm)
    Image1: TImage;
    Timer1: TTimer;
    ProgressBar1: TProgressBar;
    procedure FormCreate(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    { Private declarations }
    TimeCount:integer;
  public
    { Public declarations }
     ExePath:AnsiString;
  end;

var
  Kcover: TKcover;

implementation

{$R *.dfm}

uses MainForm;

procedure TKcover.FormCreate(Sender: TObject);

begin
   Image1.Picture.LoadFromFile(ExePath+'BJTP/Welcome.Bmp') ;
   TimeCount:=0;
   Timer1.Enabled :=true;
   ProgressBar1.StepIt;
end;

procedure TKcover.Timer1Timer(Sender: TObject);
begin
    ProgressBar1.StepIt;
end;

end.

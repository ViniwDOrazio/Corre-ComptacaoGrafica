program CorrePrimitivasGraficas;

uses
  Vcl.Forms,
  uMatrizPixel in 'uMatrizPixel.pas' {frmMatrizPixel};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'Primitivas Gr�ficas';
  Application.CreateForm(TfrmMatrizPixel, frmMatrizPixel);
  Application.Run;
end.

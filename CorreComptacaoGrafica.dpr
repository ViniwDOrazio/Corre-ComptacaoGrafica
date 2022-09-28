program CorreComptacaoGrafica;

uses
  Vcl.Forms,
  uMatrizPixel in 'uMatrizPixel.pas' {frmMatrizPixel};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmMatrizPixel, frmMatrizPixel);
  Application.Run;
end.

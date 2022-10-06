unit uMatrizPixel;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Buttons, System.Generics.Collections;

type
  TTipoDesenho = (tdPonto, tdLinhaDDA, tdBresenhamLinha, tdCirculo);

  TAjustaXY = procedure(var X, Y: Integer) of object;

  TPonto = class
  private
    FX: Integer;
    FY: Integer;
    function getCordenadas: String;
  public
    constructor Create(pX, pY: Integer); reintroduce;
    property Cordenadas: String read getCordenadas;
    property X: Integer read FX write FX;
    property Y: Integer read FY write FY;
  end;

  TDesenho = class
  private
    FPontos: TList<TPonto>;
    FOnAjustar: TAjustaXY;
    FTipoDesenho: TTipoDesenho;
    FRaio: Integer;
    procedure LinhaBresenham(Canvas: TCanvas; PontoInicial, PontoFinal: TPonto; TamanhoPixel: Integer; Marcado: Boolean);
    procedure LinhaDDA(Canvas: TCanvas; PontoInicial, PontoFinal: TPonto; TamanhoPixel: Integer; Marcado: Boolean);
    function getDescricao: String;
    procedure Circulo(Canvas: TCanvas; DesvioX, DesvioY, Raio, TamanhoPixel: Integer; Marcado: Boolean);
  public
    constructor Create(Ajustar: TAjustaXY);
    destructor Destroy; override;
    property Pontos: TList<TPonto> read FPontos write FPontos;
    property OnAjustar: TAjustaXY read FOnAjustar write FOnAjustar;
    property TipoDesenho: TTipoDesenho read FTipoDesenho write FTipoDesenho;
    property Raio: Integer read FRaio write FRaio;
    class function CriarPonto(X, Y: Integer; Ajustar: TAjustaXY): TDesenho;
    class function CriarLinhaDDA(X, Y, X2, Y2: Integer; Ajustar: TAjustaXY): TDesenho;
    class function CriarLinhaBresenham(X, Y, X2, Y2: Integer; Ajustar: TAjustaXY): TDesenho;
    class function CriarCirculo(X, Y, Raio: Integer; Ajustar: TAjustaXY): TDesenho;
    procedure PintarPixel(Canvas: TCanvas; X, Y, TamanhoPixel: Integer; Marcado: Boolean);
    procedure Pintar(Canvas: TCanvas; TamanhoPixel: Integer; Marcado: Boolean);
    property Descricao: String read getDescricao;
  end;

  TfrmMatrizPixel = class(TForm)
    pnlSegueMouse: TPanel;
    lblTamanhoPixel: TLabel;
    edtTamanhoPixel: TEdit;
    pPixel: TPanel;
    pnlTamanhoPixel: TPanel;
    lblPixel: TLabel;
    gpPixelXY: TGridPanel;
    edtX: TEdit;
    edtY: TEdit;
    gpOpcoesAdd: TGridPanel;
    btnPixel: TSpeedButton;
    btnLinha: TSpeedButton;
    btnCirculo: TSpeedButton;
    lblPosicao: TLabel;
    chkMostrarCordenadas: TCheckBox;
    gpLinhas: TGridPanel;
    btnDDA: TSpeedButton;
    btnBresenham: TSpeedButton;
    tmrPintar: TTimer;
    lstDesenhos: TListBox;
    pTamanhoCirculo: TPanel;
    lblTamanhoCirculo: TLabel;
    edtRaio: TEdit;
    pControladorPadrao: TPanel;
    btnCirculoCriar: TSpeedButton;
    procedure FormPaint(Sender: TObject);
    procedure FormMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure FormMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure btnPixelClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnLinhaClick(Sender: TObject);
    procedure btnBresenhamClick(Sender: TObject);
    procedure chkMostrarCordenadasClick(Sender: TObject);
    procedure tmrPintarTimer(Sender: TObject);
    procedure lstDesenhosKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure lstDesenhosKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnCirculoClick(Sender: TObject);
    procedure btnCirculoCriarClick(Sender: TObject);
    procedure lstDesenhosClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
  private
    { Private declarations }
    FDesenhos: TList<TDesenho>;
    FPonto: TPonto;
    procedure DesenhaLinhaReta(X, Y: Integer; Destaque: Boolean);
    procedure ConverteXYPosicaoToCordenada(var X, Y: Integer);
    procedure ConverteXYCordenadaToPosicao(var X, Y: Integer);
    function ObterTamanhoPixel: Integer;
    procedure AtualizarListaDesenho;
    procedure ChamarPaint;
  public
    { Public declarations }
  end;

var
  frmMatrizPixel: TfrmMatrizPixel;

implementation

{$R *.dfm}

procedure TfrmMatrizPixel.AtualizarListaDesenho;
var Desenho: TDesenho;
begin
  lstDesenhos.Items.Clear;
  for Desenho in FDesenhos do
    lstDesenhos.Items.Add(Desenho.Descricao)
end;

procedure TfrmMatrizPixel.btnBresenhamClick(Sender: TObject);
begin
  gpOpcoesAdd.Visible := True;
  gpLinhas.Visible := False;

  if Sender = btnDDA then
    FDesenhos.Add(TDesenho.CriarLinhaDDA(FPonto.X, FPonto.Y, StrToIntDef(edtX.Text, 0), StrToIntDef(edtY.Text, 0), ConverteXYCordenadaToPosicao))
  else
    FDesenhos.Add(TDesenho.CriarLinhaBresenham(FPonto.X, FPonto.Y, StrToIntDef(edtX.Text, 0), StrToIntDef(edtY.Text, 0), ConverteXYCordenadaToPosicao));

  FreeAndNil(FPonto);

  pnlSegueMouse.Visible := False;
  ChamarPaint;
end;

procedure TfrmMatrizPixel.btnCirculoClick(Sender: TObject);
begin
  pControladorPadrao.Visible := False;
  pTamanhoCirculo.Visible := True;
end;

procedure TfrmMatrizPixel.btnCirculoCriarClick(Sender: TObject);
begin
  pControladorPadrao.Visible := True;
  pTamanhoCirculo.Visible := False;

  FDesenhos.Add(TDesenho.CriarCirculo(StrToIntDef(edtX.Text, 0), StrToIntDef(edtY.Text, 0), StrToIntDef(edtRaio.Text, 1), ConverteXYCordenadaToPosicao));
  pnlSegueMouse.Visible := False;

  ChamarPaint;
end;

procedure TfrmMatrizPixel.btnLinhaClick(Sender: TObject);
begin
  if not Assigned(FPonto) then
  begin
    FPonto := TPonto.Create(StrToIntDef(edtX.Text, 0), StrToIntDef(edtY.Text, 0));
    gpOpcoesAdd.Visible := False;
    gpLinhas.Visible := True;
  end;
  pnlSegueMouse.Visible := False;
end;

procedure TfrmMatrizPixel.btnPixelClick(Sender: TObject);
begin
  FDesenhos.Add(TDesenho.CriarPonto(StrToIntDef(edtX.Text, 0), StrToIntDef(edtY.Text, 0), ConverteXYCordenadaToPosicao));
  pnlSegueMouse.Visible := False;

  ChamarPaint;
end;

procedure TfrmMatrizPixel.ChamarPaint;
var indice: Integer;
begin
  if lstDesenhos.Visible then
  begin
    indice := lstDesenhos.ItemIndex;
    AtualizarListaDesenho;
    lstDesenhos.ItemIndex := indice;
  end;
  Paint;
  tmrPintar.Enabled := True;
end;

procedure TfrmMatrizPixel.chkMostrarCordenadasClick(Sender: TObject);
begin
  lblPosicao.Visible := chkMostrarCordenadas.Checked;
end;

procedure TfrmMatrizPixel.ConverteXYCordenadaToPosicao(var X, Y: Integer);
var XMeio, YMeio, TamanhoPixel: Integer;
begin
  TamanhoPixel := ObterTamanhoPixel();

  YMeio := Trunc(ClientHeight / 2) - Trunc(TamanhoPixel / 2);

  Y := (Y * TamanhoPixel) + YMeio;

  XMeio := Trunc(ClientWidth / 2) - Trunc(TamanhoPixel / 2);

  X := (X * TamanhoPixel) + XMeio;
end;

procedure TfrmMatrizPixel.ConverteXYPosicaoToCordenada(var X, Y: Integer);
var XMeio, YMeio, Sobra, TamanhoPixel: Integer;
begin
  TamanhoPixel := ObterTamanhoPixel();

  YMeio := Trunc(ClientHeight / 2) - Trunc(TamanhoPixel / 2);
  Sobra := YMeio - (Trunc(YMeio / TamanhoPixel) * TamanhoPixel);

  if (Y > YMeio) and (Y < (YMeio + TamanhoPixel)) then
    Y := 0
  else
  begin
    if (Y > (YMeio + TamanhoPixel)) then
      YMeio := YMeio - TamanhoPixel;

    Y := Trunc((Y - Sobra - YMeio) / TamanhoPixel);
  end;

  XMeio := Trunc(ClientWidth / 2) - Trunc(TamanhoPixel / 2);
  Sobra := XMeio - (Trunc(XMeio / TamanhoPixel) * TamanhoPixel);

  if (X > XMeio) and (X < (XMeio + TamanhoPixel)) then
    X := 0
  else
  begin
    if (X > (XMeio + TamanhoPixel)) then
      XMeio := XMeio - TamanhoPixel;

    X := Trunc((X - Sobra - XMeio) / TamanhoPixel);
  end;
end;

procedure TfrmMatrizPixel.DesenhaLinhaReta(X, Y: Integer; Destaque: Boolean);
begin
  if (((X = 0) or (Y = 0)) and not((X = 0) and (Y = 0))) then
  begin
    if Destaque then
    begin
      Canvas.Pen.Color := clSilver;
      Canvas.Pen.Width := 3;
    end else
    begin
      Canvas.Pen.Color := clSilver;
      Canvas.Pen.Width := 1;
    end;

    Canvas.MoveTo(X, Y);
    if X = 0 then
      X := Self.ClientWidth;
    if Y = 0 then
      Y := Self.ClientHeight;
    Canvas.LineTo(X, Y);
  end;
end;

procedure TfrmMatrizPixel.FormCreate(Sender: TObject);
begin
  FDesenhos := TList<TDesenho>.Create;
end;

procedure TfrmMatrizPixel.FormDestroy(Sender: TObject);
begin
  FreeAndNil(FDesenhos)
end;

procedure TfrmMatrizPixel.FormMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if (Button = TMouseButton.mbRight) then
  begin
    Self.Paint;
    lstDesenhos.Visible := not lstDesenhos.Visible;
    if lstDesenhos.Visible then
      AtualizarListaDesenho;
  end
  else
  if (Button = TMouseButton.mbLeft) then
  begin
    if not pnlSegueMouse.Visible then
    begin
      pnlSegueMouse.Top := Y - Trunc(pnlSegueMouse.Height / 2);
      if pnlSegueMouse.Top <= 0 then
        pnlSegueMouse.Top := 0;
      if pnlSegueMouse.Top + pnlSegueMouse.Height > Self.ClientHeight then
        pnlSegueMouse.Top := Self.ClientHeight - pnlSegueMouse.Height;

      pnlSegueMouse.Left := X - Trunc(pnlSegueMouse.Width / 2);
      if pnlSegueMouse.Left <= 0 then
        pnlSegueMouse.Left := 0;
      if pnlSegueMouse.Left + pnlSegueMouse.Width > Self.ClientWidth then
        pnlSegueMouse.Left := Self.ClientWidth - pnlSegueMouse.Width;
    end;
    pnlSegueMouse.Visible := not pnlSegueMouse.Visible;
  end;
end;

procedure TfrmMatrizPixel.FormMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
begin
  lblPosicao.Caption := '(' + IntToStr(X) + ', ' + IntToStr(Y) + ')';
  ConverteXYPosicaoToCordenada(X, Y);
  lblPosicao.Caption := lblPosicao.Caption + '(' + IntToStr(X) + ', ' + IntToStr(Y) + ')';

  if not pnlSegueMouse.Visible then
  begin
    edtX.Text := IntToStr(X);
    edtY.Text := IntToStr(Y);
  end;
end;

procedure TfrmMatrizPixel.FormPaint(Sender: TObject);
var X, Y, XMeio, YMeio, Sobra, TamanhoPixel, i: Integer;
begin
  Canvas.Pen.Color := clWhite;
  Canvas.Brush.Color := clWhite;
  //Limpa
  Canvas.Rectangle(0, 0, ClientWidth, ClientHeight);

  TamanhoPixel := ObterTamanhoPixel();

  X := 0;
  YMeio := Trunc(ClientHeight / 2) - Trunc(TamanhoPixel / 2);
  Sobra := YMeio - (Trunc(YMeio / TamanhoPixel) * TamanhoPixel);
  Y := Sobra;
  while Y < Self.ClientHeight do
  begin
    DesenhaLinhaReta(X, Y, False);
    Y := Y + TamanhoPixel;
  end;

  Y := 0;
  XMeio := Trunc(ClientWidth / 2) - Trunc(TamanhoPixel / 2);
  Sobra := XMeio - (Trunc(XMeio / TamanhoPixel) * TamanhoPixel);
  X := Sobra;
  while X < Self.ClientWidth do
  begin
    DesenhaLinhaReta(X, Y, False);
    X := X + TamanhoPixel;
  end;

  DesenhaLinhaReta(XMeio, 0, True);
  DesenhaLinhaReta(XMeio + TamanhoPixel, 0, True);
  DesenhaLinhaReta(0, YMeio, True);
  DesenhaLinhaReta(0, YMeio + TamanhoPixel, True);

  for i := 0 to FDesenhos.Count - 1 do
    FDesenhos[i].Pintar(Canvas, TamanhoPixel, ((lstDesenhos.Visible) and (lstDesenhos.ItemIndex = i)));
end;

procedure TfrmMatrizPixel.FormResize(Sender: TObject);
begin
  ChamarPaint;
end;

procedure TfrmMatrizPixel.lstDesenhosClick(Sender: TObject);
begin
  ChamarPaint;
end;

procedure TfrmMatrizPixel.lstDesenhosKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = 46 then
  begin
    if (lstDesenhos.ItemIndex > -1) then
    begin
      FDesenhos.Delete(lstDesenhos.ItemIndex);
      AtualizarListaDesenho;
    end;
  end;
end;

procedure TfrmMatrizPixel.lstDesenhosKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = 46 then
  begin
    if (lstDesenhos.ItemIndex > -1) then
    begin
      FDesenhos.Delete(lstDesenhos.ItemIndex);
      AtualizarListaDesenho;
    end;
  end;
end;

function TfrmMatrizPixel.ObterTamanhoPixel: Integer;
begin
  Result := StrToIntDef(edtTamanhoPixel.Text, 0);
  if Result <= 2 then
    Result := 15;
end;

procedure TfrmMatrizPixel.tmrPintarTimer(Sender: TObject);
begin
  tmrPintar.Enabled := False;
  Self.Paint;
end;

{ TDesenho }

procedure TDesenho.Circulo(Canvas: TCanvas; DesvioX, DesvioY, Raio, TamanhoPixel: Integer; Marcado: Boolean);
var X, Y, D: Integer;
  procedure PintarOitoPontos(Canvas: TCanvas; X, Y, DesvioX, DesvioY, TamanhoPixel: Integer; Marcado: Boolean);
  const PontoCirculoX: array [0..3] of Integer = (1,1,-1,-1);
        PontoCirculoY: array [0..3] of Integer = (1,-1,1,-1);
  var i: Integer;
  begin
    for i := Low(PontoCirculoX) to High(PontoCirculoX) do
    begin
      PintarPixel(Canvas, X * PontoCirculoX[i] + DesvioX, Y * PontoCirculoY[i] + DesvioY, TamanhoPixel, Marcado);
      PintarPixel(Canvas, Y * PontoCirculoX[i] + DesvioX, X * PontoCirculoY[i] + DesvioY, TamanhoPixel, Marcado);
    end;
  end;
begin
  X := 0;
  Y := Raio;
  D := 3 - 2 * Raio;

  PintarOitoPontos(Canvas, X, Y, DesvioX, DesvioY, TamanhoPixel, Marcado);
  while X <= Y do
  begin
    if (d <= 0) then
      D := D + 4 * X + 6
    else
    begin
      D := D + 4 * X - 4 * Y + 10;
      Y := Y - 1;
    end;
    X := X + 1;
    PintarOitoPontos(Canvas, X, Y, DesvioX, DesvioY, TamanhoPixel, Marcado);
  end;
end;

constructor TDesenho.Create(Ajustar: TAjustaXY);
begin
  inherited Create;
  FOnAjustar := Ajustar;
  FPontos := TList<TPonto>.Create;
  FRaio := 0;
end;

class function TDesenho.CriarCirculo(X, Y, Raio: Integer; Ajustar: TAjustaXY): TDesenho;
begin
  Result := TDesenho.Create(Ajustar);
  Result.TipoDesenho := tdCirculo;
  Result.Pontos.Add(TPonto.Create(X, Y));
  Result.Raio := Raio;
end;

class function TDesenho.CriarLinhaBresenham(X, Y, X2, Y2: Integer; Ajustar: TAjustaXY): TDesenho;
begin
  Result := TDesenho.Create(Ajustar);
  Result.TipoDesenho := tdBresenhamLinha;
  Result.Pontos.Add(TPonto.Create(X, Y));
  Result.Pontos.Add(TPonto.Create(X2, Y2));
end;

class function TDesenho.CriarLinhaDDA(X, Y, X2, Y2: Integer; Ajustar: TAjustaXY): TDesenho;
begin
  Result := TDesenho.Create(Ajustar);
  Result.TipoDesenho := tdLinhaDDA;
  Result.Pontos.Add(TPonto.Create(X, Y));
  Result.Pontos.Add(TPonto.Create(X2, Y2));
end;

class function TDesenho.CriarPonto(X, Y: Integer; Ajustar: TAjustaXY): TDesenho;
begin
  Result := TDesenho.Create(Ajustar);
  Result.TipoDesenho := tdPonto;
  Result.Pontos.Add(TPonto.Create(X, Y));
end;

destructor TDesenho.Destroy;
begin
  FreeAndNil(FPontos);
  inherited;
end;

function TDesenho.getDescricao: String;
const DescricaoBase: array [TTipoDesenho] of String = ('Ponto', 'Linha DDA', 'Linha Bresenham', 'Circulo');
var Ponto: TPonto;
begin
  Result := DescricaoBase[FTipoDesenho];
  case FTipoDesenho of
    tdPonto, tdCirculo:
    begin
      if FPontos.Count > 1 then
        raise Exception.Create('Mais de um ponto.');

      if (FPontos.Count = 0) then
        raise Exception.Create('Nenhum Ponto para pintar.');

      Ponto := FPontos[0];
      Result := Result + Ponto.Cordenadas;
      if FTipoDesenho = tdCirculo then
        Result := Result + ' R' + IntToStr(FRaio);
    end;

    tdBresenhamLinha, tdLinhaDDA:
    begin
      if FPontos.Count > 2 then
        raise Exception.Create('Uma reta precisa de dois pontos apenas.');

      if (FPontos.Count = 0) then
        raise Exception.Create('Não se faz uma reta com menos de dois pontos.');

      Ponto := FPontos[0];
      Result := Result + '(' + Ponto.Cordenadas;
      Ponto := FPontos[1];
      Result := Result + ', ' + Ponto.Cordenadas + ')';
    end;
  end;
end;

procedure TDesenho.LinhaBresenham(Canvas: TCanvas; PontoInicial, PontoFinal: TPonto; TamanhoPixel: Integer; Marcado: Boolean);
var slope, dx, dy, incE, incNE, d, x, y, XInicial, YInicial, XFinal, YFinal: Integer;
    XYInvertido: Boolean;
begin
  // Onde inverte a linha x1 > x2
  XInicial := PontoInicial.X;
  XFinal := PontoFinal.X;

  YInicial := PontoInicial.Y;
  YFinal := PontoFinal.Y;

  if (XFinal > XInicial) then
    dx := XFinal - XInicial
  else
    dx := XInicial - XFinal;

  if (YFinal > YInicial) then
    dy := YFinal - YInicial
  else
    dy := YInicial - YFinal;

  if dx > dy then
  begin
    XYInvertido := False;
    if PontoInicial.X < PontoFinal.X then
    begin
      XInicial := PontoInicial.X;
      XFinal := PontoFinal.X;

      YInicial := PontoInicial.Y;
      YFinal := PontoFinal.Y;
    end else
    begin
      XInicial := PontoFinal.X;
      XFinal := PontoInicial.X;

      YInicial := PontoFinal.Y;
      YFinal := PontoInicial.Y;
    end;
  end else
  begin
    XYInvertido := True;
    if PontoInicial.Y < PontoFinal.Y then
    begin
      XInicial := PontoInicial.Y;
      XFinal := PontoFinal.Y;

      YInicial := PontoInicial.X;
      YFinal := PontoFinal.X;
    end else
    begin
      XInicial := PontoFinal.Y;
      XFinal := PontoInicial.Y;

      YInicial := PontoFinal.X;
      YFinal := PontoInicial.X;
    end;
  end;

	dx := XFinal - XInicial;
	dy := YFinal - YInicial;

  if (dy < 0) then
  begin
    slope := -1;
    dy := 0 - dy;
  end
  else
  begin
    slope := 1;
  end;
  // Constante de Bresenham
  incE := 2 * dy;
  incNE := 2 * dy - 2 * dx;
  d := 2 * dy - dx;
  y := YInicial;
  for x := XInicial to XFinal do
  begin
    if (XYInvertido) then
      PintarPixel(Canvas, Y, X, TamanhoPixel, Marcado)
    else
      PintarPixel(Canvas, X, Y, TamanhoPixel, Marcado);
    if (d <= 0) then
      d := d + incE
    else
    begin
      d := d + incNE;
      y := Y + slope;
    end;
  end;
end;

procedure TDesenho.LinhaDDA(Canvas: TCanvas; PontoInicial, PontoFinal: TPonto; TamanhoPixel: Integer; Marcado: Boolean);
var dx, dy, x, y, XInicial, YInicial, XFinal, YFinal: Integer;
    XYInvertido: Boolean;
begin
  // Onde inverte a linha x1 > x2
  XInicial := PontoInicial.X;
  XFinal := PontoFinal.X;

  YInicial := PontoInicial.Y;
  YFinal := PontoFinal.Y;

  if (XFinal > XInicial) then
    dx := XFinal - XInicial
  else
    dx := XInicial - XFinal;

  if (YFinal > YInicial) then
    dy := YFinal - YInicial
  else
    dy := YInicial - YFinal;

  if dx > dy then
  begin
    XYInvertido := False;
    if PontoInicial.X < PontoFinal.X then
    begin
      XInicial := PontoInicial.X;
      XFinal := PontoFinal.X;

      YInicial := PontoInicial.Y;
      YFinal := PontoFinal.Y;
    end else
    begin
      XInicial := PontoFinal.X;
      XFinal := PontoInicial.X;

      YInicial := PontoFinal.Y;
      YFinal := PontoInicial.Y;
    end;
  end else
  begin
    XYInvertido := True;
    if PontoInicial.Y < PontoFinal.Y then
    begin
      XInicial := PontoInicial.Y;
      XFinal := PontoFinal.Y;

      YInicial := PontoInicial.X;
      YFinal := PontoFinal.X;
    end else
    begin
      XInicial := PontoFinal.Y;
      XFinal := PontoInicial.Y;

      YInicial := PontoFinal.X;
      YFinal := PontoInicial.X;
    end;
  end;

	dx := XFinal - XInicial;
	dy := YFinal - YInicial;

//  Y := YInicial;

  for X := XInicial to XFinal do
  begin
    Y := Trunc(YInicial + (x - XInicial) * (dy / dx));
    //Y + (Y * dy / dx));

    if (XYInvertido) then
      PintarPixel(Canvas, Y, X, TamanhoPixel, Marcado)
    else
      PintarPixel(Canvas, X, Y, TamanhoPixel, Marcado);
  end;
end;

procedure TDesenho.Pintar(Canvas: TCanvas; TamanhoPixel: Integer; Marcado: Boolean);
var XInicial, YInicial: Integer;
    PontoInicial, PontoFinal: TPonto;
begin
  case FTipoDesenho of
    tdPonto, tdCirculo:
    begin
      if FPontos.Count > 1 then
        raise Exception.Create('Mais de um ponto.');

      if (FPontos.Count = 0) then
        raise Exception.Create('Nenhum Ponto para pintar.');

      PontoInicial := FPontos[0];
      XInicial := PontoInicial.X;
      YInicial := PontoInicial.Y;

      if FTipoDesenho = tdPonto then
        PintarPixel(Canvas, XInicial, YInicial, TamanhoPixel, Marcado)
      else
        Circulo(Canvas, XInicial, YInicial, Raio, TamanhoPixel, Marcado);
    end;

    tdBresenhamLinha, tdLinhaDDA:
    begin
      if FPontos.Count > 2 then
        raise Exception.Create('Uma reta precisa de dois pontos apenas.');

      if (FPontos.Count = 0) then
        raise Exception.Create('Não se faz uma reta com menos de dois pontos.');

      PontoInicial := FPontos[0];
      PontoFinal := FPontos[1];
      if FTipoDesenho = tdBresenhamLinha then
        LinhaBresenham(Canvas, PontoInicial, PontoFinal, TamanhoPixel, Marcado)
      else
        LinhaDDA(Canvas, PontoInicial, PontoFinal, TamanhoPixel, Marcado);
    end;
  end;
end;

procedure TDesenho.PintarPixel(Canvas: TCanvas; X, Y, TamanhoPixel: Integer; Marcado: Boolean);
begin
  if (Marcado) then
  begin
    Canvas.Pen.Color := clBlack;
    Canvas.Pen.Width := 3;
  end
  else
  begin
    Canvas.Pen.Color := clGray;
    Canvas.Pen.Width := 1;
  end;
  Canvas.Brush.Color := clGray;

  if Assigned(FOnAjustar) then
    FOnAjustar(X, Y);

  Canvas.Rectangle(X, Y, X + TamanhoPixel, Y + TamanhoPixel);
end;

{ TPonto }

constructor TPonto.Create(pX, pY: Integer);
begin
  inherited Create;
  FX := pX;
  FY := pY;
end;

function TPonto.getCordenadas: String;
begin
  Result := '(' + IntToStr(FX) + ', ' + IntToStr(FY) + ')';
end;

end.

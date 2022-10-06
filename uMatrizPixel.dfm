object frmMatrizPixel: TfrmMatrizPixel
  Left = 0
  Top = 0
  Caption = 'Tela Pixelada'
  ClientHeight = 432
  ClientWidth = 724
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  WindowState = wsMaximized
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnMouseDown = FormMouseDown
  OnMouseMove = FormMouseMove
  OnPaint = FormPaint
  OnResize = FormResize
  DesignSize = (
    724
    432)
  PixelsPerInch = 96
  TextHeight = 13
  object lblPosicao: TLabel
    Left = 658
    Top = 419
    Width = 66
    Height = 13
    Anchors = [akRight, akBottom]
    BiDiMode = bdRightToLeft
    Caption = '((0, 0),(0, 0))'
    ParentBiDiMode = False
    Visible = False
  end
  object pnlSegueMouse: TPanel
    Left = 220
    Top = 0
    Width = 174
    Height = 147
    Anchors = [akRight, akBottom]
    ParentBackground = False
    TabOrder = 0
    Visible = False
    object pnlTamanhoPixel: TPanel
      AlignWithMargins = True
      Left = 5
      Top = 47
      Width = 164
      Height = 34
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 0
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 1
      ExplicitTop = 26
      object lblTamanhoPixel: TLabel
        Left = 0
        Top = 0
        Width = 164
        Height = 13
        Align = alTop
        Caption = 'Tamanho Pixel'
        ExplicitWidth = 69
      end
      object edtTamanhoPixel: TEdit
        Left = 0
        Top = 13
        Width = 164
        Height = 21
        Align = alTop
        Alignment = taRightJustify
        TabOrder = 0
        Text = '30'
      end
    end
    object chkMostrarCordenadas: TCheckBox
      AlignWithMargins = True
      Left = 5
      Top = 26
      Width = 164
      Height = 17
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 0
      Align = alTop
      Caption = 'Mostrar Cordenadas'
      TabOrder = 0
      OnClick = chkMostrarCordenadasClick
      ExplicitLeft = 1
      ExplicitTop = 6
    end
    object pTamanhoCirculo: TPanel
      AlignWithMargins = True
      Left = 5
      Top = 174
      Width = 164
      Height = 56
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 0
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 2
      Visible = False
      ExplicitTop = 153
      object lblTamanhoCirculo: TLabel
        Left = 0
        Top = 0
        Width = 164
        Height = 13
        Align = alTop
        Caption = 'Raio'
        ExplicitWidth = 21
      end
      object btnCirculoCriar: TSpeedButton
        AlignWithMargins = True
        Left = 2
        Top = 34
        Width = 160
        Height = 22
        Margins.Left = 2
        Margins.Top = 0
        Margins.Right = 2
        Margins.Bottom = 0
        Align = alBottom
        Caption = 'Circulo'
        OnClick = btnCirculoCriarClick
        ExplicitLeft = -6
      end
      object edtRaio: TEdit
        AlignWithMargins = True
        Left = 0
        Top = 13
        Width = 162
        Height = 21
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 2
        Margins.Bottom = 0
        Align = alClient
        Alignment = taRightJustify
        TabOrder = 0
        Text = '1'
      end
    end
    object pControladorPadrao: TPanel
      Left = 1
      Top = 81
      Width = 172
      Height = 89
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 3
      ExplicitTop = 60
      object pPixel: TPanel
        AlignWithMargins = True
        Left = 4
        Top = 4
        Width = 164
        Height = 34
        Margins.Left = 4
        Margins.Top = 4
        Margins.Right = 4
        Margins.Bottom = 0
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 0
        object lblPixel: TLabel
          Left = 0
          Top = 0
          Width = 164
          Height = 13
          Align = alTop
          Caption = 'Pixel'
          ExplicitWidth = 22
        end
        object gpPixelXY: TGridPanel
          Left = 0
          Top = 13
          Width = 164
          Height = 21
          Align = alClient
          BevelOuter = bvNone
          ColumnCollection = <
            item
              Value = 50.000000000000000000
            end
            item
              Value = 50.000000000000000000
            end>
          ControlCollection = <
            item
              Column = 0
              Control = edtX
              Row = 0
            end
            item
              Column = 1
              Control = edtY
              Row = 0
            end>
          RowCollection = <
            item
              Value = 100.000000000000000000
            end>
          TabOrder = 0
          object edtX: TEdit
            AlignWithMargins = True
            Left = 0
            Top = 0
            Width = 80
            Height = 21
            Margins.Left = 0
            Margins.Top = 0
            Margins.Right = 2
            Margins.Bottom = 0
            Align = alClient
            Alignment = taRightJustify
            TabOrder = 0
            Text = '0'
          end
          object edtY: TEdit
            AlignWithMargins = True
            Left = 82
            Top = 0
            Width = 80
            Height = 21
            Margins.Left = 0
            Margins.Top = 0
            Margins.Right = 2
            Margins.Bottom = 0
            Align = alClient
            Alignment = taRightJustify
            TabOrder = 1
            Text = '0'
          end
        end
      end
      object gpOpcoesAdd: TGridPanel
        AlignWithMargins = True
        Left = 4
        Top = 42
        Width = 164
        Height = 22
        Margins.Left = 4
        Margins.Top = 4
        Margins.Right = 4
        Margins.Bottom = 0
        Align = alTop
        BevelOuter = bvNone
        ColumnCollection = <
          item
            Value = 33.333333333333340000
          end
          item
            Value = 33.333333333333340000
          end
          item
            Value = 33.333333333333310000
          end>
        ControlCollection = <
          item
            Column = 0
            Control = btnPixel
            Row = 0
          end
          item
            Column = 1
            Control = btnLinha
            Row = 0
          end
          item
            Column = 2
            Control = btnCirculo
            Row = 0
          end>
        RowCollection = <
          item
            Value = 100.000000000000000000
          end>
        TabOrder = 1
        object btnPixel: TSpeedButton
          AlignWithMargins = True
          Left = 2
          Top = 0
          Width = 51
          Height = 22
          Margins.Left = 2
          Margins.Top = 0
          Margins.Right = 2
          Margins.Bottom = 0
          Align = alClient
          Caption = 'Pixel'
          OnClick = btnPixelClick
          ExplicitTop = -1
        end
        object btnLinha: TSpeedButton
          AlignWithMargins = True
          Left = 57
          Top = 0
          Width = 50
          Height = 22
          Margins.Left = 2
          Margins.Top = 0
          Margins.Right = 2
          Margins.Bottom = 0
          Align = alClient
          Caption = 'Linha'
          OnClick = btnLinhaClick
          ExplicitTop = -1
        end
        object btnCirculo: TSpeedButton
          AlignWithMargins = True
          Left = 111
          Top = 0
          Width = 51
          Height = 22
          Margins.Left = 2
          Margins.Top = 0
          Margins.Right = 2
          Margins.Bottom = 0
          Align = alClient
          Caption = 'Circulo'
          OnClick = btnCirculoClick
          ExplicitTop = -1
        end
      end
      object gpLinhas: TGridPanel
        AlignWithMargins = True
        Left = 4
        Top = 68
        Width = 164
        Height = 22
        Margins.Left = 4
        Margins.Top = 4
        Margins.Right = 4
        Margins.Bottom = 0
        Align = alTop
        BevelOuter = bvNone
        ColumnCollection = <
          item
            Value = 50.000000000000000000
          end
          item
            Value = 50.000000000000000000
          end>
        ControlCollection = <
          item
            Column = 0
            Control = btnDDA
            Row = 0
          end
          item
            Column = 1
            Control = btnBresenham
            Row = 0
          end>
        RowCollection = <
          item
            Value = 100.000000000000000000
          end>
        TabOrder = 2
        Visible = False
        object btnDDA: TSpeedButton
          AlignWithMargins = True
          Left = 2
          Top = 0
          Width = 78
          Height = 22
          Margins.Left = 2
          Margins.Top = 0
          Margins.Right = 2
          Margins.Bottom = 0
          Align = alClient
          Caption = 'DDA'
          OnClick = btnBresenhamClick
          ExplicitTop = -4
        end
        object btnBresenham: TSpeedButton
          AlignWithMargins = True
          Left = 84
          Top = 0
          Width = 78
          Height = 22
          Margins.Left = 2
          Margins.Top = 0
          Margins.Right = 2
          Margins.Bottom = 0
          Align = alClient
          Caption = 'Bresenham'
          OnClick = btnBresenhamClick
          ExplicitTop = -4
        end
      end
    end
    object chkPassoAPasso: TCheckBox
      AlignWithMargins = True
      Left = 5
      Top = 5
      Width = 164
      Height = 17
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 0
      Align = alTop
      Caption = 'Passo a passo'
      TabOrder = 4
      OnClick = chkMostrarCordenadasClick
      ExplicitLeft = 1
      ExplicitTop = 6
    end
  end
  object lstDesenhos: TListBox
    Left = 0
    Top = 0
    Width = 214
    Height = 432
    Align = alLeft
    ItemHeight = 13
    TabOrder = 1
    Visible = False
    OnClick = lstDesenhosClick
    OnKeyUp = lstDesenhosKeyUp
  end
  object pPassoPasso: TPanel
    Left = 336
    Top = 402
    Width = 113
    Height = 22
    Anchors = [akLeft, akBottom]
    TabOrder = 2
    Visible = False
    object btnTerminar: TSpeedButton
      Left = 24
      Top = 1
      Width = 65
      Height = 20
      Align = alClient
      Caption = 'Terminar'
      ExplicitLeft = 18
    end
    object btnAnterior: TSpeedButton
      Left = 1
      Top = 1
      Width = 23
      Height = 20
      Align = alLeft
      Caption = '<'
      ExplicitLeft = -5
    end
    object btnProximo: TSpeedButton
      Left = 89
      Top = 1
      Width = 23
      Height = 20
      Align = alRight
      Caption = '>'
      ExplicitLeft = 48
      ExplicitTop = 8
      ExplicitHeight = 22
    end
  end
  object tmrPintar: TTimer
    Interval = 20
    OnTimer = tmrPintarTimer
    Left = 576
    Top = 40
  end
end

object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Kalkulator Jozzz'
  ClientHeight = 347
  ClientWidth = 635
  Color = clAqua
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 192
    Top = 75
    Width = 28
    Height = 13
    Caption = 'Nilai 1'
  end
  object Label2: TLabel
    Left = 192
    Top = 107
    Width = 28
    Height = 13
    Caption = 'Nilai 2'
  end
  object Label3: TLabel
    Left = 192
    Top = 139
    Width = 22
    Height = 13
    Caption = 'Hasil'
  end
  object NIlai_1: TEdit
    Left = 256
    Top = 72
    Width = 177
    Height = 21
    TabOrder = 0
  end
  object Nilai_2: TEdit
    Left = 256
    Top = 99
    Width = 177
    Height = 21
    TabOrder = 1
  end
  object Edit3: TEdit
    Left = 256
    Top = 136
    Width = 177
    Height = 21
    TabOrder = 2
  end
  object Tambah: TButton
    Left = 48
    Top = 176
    Width = 81
    Height = 41
    Caption = '+'
    TabOrder = 3
    OnClick = TambahClick
  end
  object Kurang: TButton
    Left = 144
    Top = 176
    Width = 81
    Height = 41
    Caption = '-'
    TabOrder = 4
    OnClick = KurangClick
  end
  object Bagi: TButton
    Left = 240
    Top = 176
    Width = 81
    Height = 41
    Caption = '/'
    TabOrder = 5
    OnClick = BagiClick
  end
  object Kali: TButton
    Left = 336
    Top = 176
    Width = 81
    Height = 41
    Caption = '*'
    TabOrder = 6
    OnClick = KaliClick
  end
  object SIsa: TButton
    Left = 431
    Top = 176
    Width = 75
    Height = 41
    Caption = 'MOD'
    TabOrder = 7
    OnClick = SIsaClick
  end
  object Selisih: TButton
    Left = 520
    Top = 176
    Width = 73
    Height = 41
    Caption = 'DIV'
    TabOrder = 8
    OnClick = SelisihClick
  end
  object Title: TPanel
    Left = 0
    Top = 0
    Width = 635
    Height = 49
    Align = alTop
    Caption = 'Kalkulator Jozzz'
    Color = clActiveCaption
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -21
    Font.Name = 'Calibri'
    Font.Style = []
    ParentBackground = False
    ParentFont = False
    TabOrder = 9
  end
  object Copyright: TPanel
    Left = 0
    Top = 298
    Width = 635
    Height = 49
    Align = alBottom
    Caption = 'Copyright by Gege Desembri'
    Color = clActiveCaption
    ParentBackground = False
    TabOrder = 10
    ExplicitTop = 248
    ExplicitWidth = 633
  end
  object Hapus: TButton
    Left = 88
    Top = 232
    Width = 193
    Height = 49
    Caption = 'CLEAR'
    TabOrder = 11
    OnClick = HapusClick
  end
  object Keliuar: TButton
    Left = 376
    Top = 232
    Width = 185
    Height = 49
    Caption = 'EXIT'
    TabOrder = 12
    OnClick = KeliuarClick
  end
end

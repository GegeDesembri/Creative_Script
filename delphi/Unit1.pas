unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TForm1 = class(TForm)
    NIlai_1: TEdit;
    Nilai_2: TEdit;
    Edit3: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Tambah: TButton;
    Kurang: TButton;
    Bagi: TButton;
    Kali: TButton;
    SIsa: TButton;
    Selisih: TButton;
    Title: TPanel;
    Copyright: TPanel;
    Hapus: TButton;
    Keliuar: TButton;
    procedure TambahClick(Sender: TObject);
    procedure KurangClick(Sender: TObject);
    procedure BagiClick(Sender: TObject);
    procedure KaliClick(Sender: TObject);
    procedure SIsaClick(Sender: TObject);
    procedure SelisihClick(Sender: TObject);
    procedure KeliuarClick(Sender: TObject);
    procedure HapusClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.TambahClick(Sender: TObject);
VAR
  A,B,C:single;
begin
  A:=STRTOFLOAT(Edit1.Text);
  B:=STRTOFLOAT(Edit2.Text);
  C:=A+B;
  Edit3.Text:=FLOATTOSTR(C);

end;

procedure TForm1.KurangClick(Sender: TObject);
VAR
  A,B,C:single;
begin
  A:=STRTOFLOAT(Edit1.text);
  B:=STRTOFLOAT(Edit2.text);
  C:=A-B;
  Edit3.Text:=FLOATTOSTR(C);

end;

procedure TForm1.BagiClick(Sender: TObject);
VAR
  A,B,C:single;
begin
  A:=STRTOFLOAT(Edit1.text);
  B:=STRTOFLOAT(Edit2.text);
  C:=A/B;
  Edit3.Text:=FLOATTOSTR(C);

end;

procedure TForm1.KaliClick(Sender: TObject);
VAR
  A,B,C:single;
begin
  A:=STRTOFLOAT(Edit1.text);
  B:=STRTOFLOAT(Edit2.text);
  C:=A*B;
  Edit3.Text:=FLOATTOSTR(C);

end;

procedure TForm1.SIsaClick(Sender: TObject);
VAR
  A,B,C:single;
begin
  A:=STRTOINT(Edit1.text);
  B:=STRTOINT(Edit2.text);
  C:=A mod B;
  Edit3.Text:=INTTOSTR(C);

end;

procedure TForm1.SelisihClick(Sender: TObject);
VAR
  A,B,C:single;
begin
  A:=STRTOINT(Edit1.text);
  B:=STRTOINT(Edit2.text);
  C:=A div B;
  Edit3.Text:=STRTOINT(C);

end;

procedure TForm1.HapusClick(Sender: TObject);
begin
Edit3.Text( );
end;

procedure TForm1.KeliuarClick(Sender: TObject);
begin
close;
end;

end.

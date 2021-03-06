unit Magnet;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, xyyGraph, math, clipbrd;

type
  TForm1 = class(TForm)
    xyyGraph1: TxyyGraph;
    Button1: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    Label3: TLabel;
    Edit3: TEdit;
    Button2: TButton;
    CheckBox1: TCheckBox;
    Label4: TLabel;
    Edit4: TEdit;
    Label5: TLabel;
    Edit5: TEdit;
    Label6: TLabel;
    Label7: TLabel;
    Edit6: TEdit;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    CheckBox2: TCheckBox;
    Button3: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

procedure TForm1.Button1Click(Sender: TObject);
var
x,r,L,Distance,CoilOutDiam,WireLength,WireDiam : Double;
i,N,Steps: Integer;
result,result1,result2: Array [0..1000] of Double;

begin
xyyGraph1.Update;
Steps:=StrtoInt(Edit5.Text);

r:=StrtoFloat(Edit1.Text);
L:=StrtoFloat(Edit2.Text);
N:=StrtoInt(Edit3.Text);
Distance:=StrtoFloat(Edit4.Text)+L;

WireDiam:=StrtoFloat(Edit6.Text)/10;

CoilOutDiam:=2*(r+WireDiam*N/L*WireDiam);

WireLength:=2*PI*(r+(CoilOutDiam/2-r)/2)*N/100/1000;

Label14.Caption:=FloattoStrF(CoilOutDiam,ffgeneral,2,2);
Label15.Caption:=FloattoStrF(WireLength,ffgeneral,2,2);

if checkbox2.checked then r:=r+ (CoilOutDiam/2-r)/2;

if checkbox1.checked then
begin
for i:=0 to Steps do
begin
x:=i/Steps*5*L;
{if (x<1) then
result[i]:=(L/2+x)/sqrt(r*r+(L/2+x)*(L/2+x))-x/sqrt(r*r+(x)*(x))
else
}
result[i]:=
0.01256*N/2/L*((x+L/2)/sqrt(r*r+(L/2+x)*(L/2+x))-(x-L/2)/sqrt(r*r+(x-L/2)*(x-L/2)))
+
0.01256*N/2/L*(((Distance-x)+L/2)/sqrt(r*r+(L/2+(Distance-x))*(L/2+(Distance-x)))-((Distance-x)-L/2)/sqrt(r*r+((Distance-x)-L/2)*((Distance-x)-L/2)))
;
end;
end
else
begin
for i:=0 to Steps do
begin
x:=i/Steps*5*L;
{if (x<1) then
result[i]:=(L/2+x)/sqrt(r*r+(L/2+x)*(L/2+x))-x/sqrt(r*r+(x)*(x))
else
}
result[i]:=0.01256*N/2/L*((x+L/2)/sqrt(r*r+(L/2+x)*(L/2+x))-(x-L/2)/sqrt(r*r+(x-L/2)*(x-L/2)));
end;
end;

for i:=0 to Steps do
begin
x:=i/Steps*5*L;
xyyGraph1[1].AddPoint(x,result[i]);
end;

end;

procedure TForm1.Button2Click(Sender: TObject);
begin
xyyGraph1[1].Clear;
end;

procedure TForm1.Button3Click(Sender: TObject);
var
AllCurve: String;
j,i: Integer;

begin
AllCurve:='';
AllCurve:=AllCurve+Label1.Caption+Edit1.Text+Label12.Caption+#13+#10;
AllCurve:=AllCurve+Label2.Caption+Edit2.Text+Label13.Caption+#13+#10;
AllCurve:=AllCurve+Label3.Caption+Edit3.Text+#13+#10;
AllCurve:=AllCurve+Label5.Caption+Edit5.Text+#13+#10;
AllCurve:=AllCurve+Label7.Caption+Edit6.Text+Label11.Caption+#13+#10;
AllCurve:=AllCurve+Label6.Caption+Label14.Caption+Label10.Caption+#13+#10;
AllCurve:=AllCurve+Label8.Caption+Label15.Caption+Label9.Caption+#13+#10;

AllCurve:=AllCurve+#13+#10;


for i:=0 to (xyyGraph1[1].Size-1) do
begin
AllCurve:=AllCurve+
FloattoStr(xyyGraph1[1].x[i])+#9+
FloattoStr(xyyGraph1[1].y[i])+#9;
AllCurve:=AllCurve+#13+#10;
end;
Application.ProcessMessages;
Clipboard.AsText:=AllCurve;
end;


end.

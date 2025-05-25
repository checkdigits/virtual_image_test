unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.BaseImageCollection,
  Vcl.ImageCollection, Vcl.VirtualImage, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TForm1 = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    VirtualImage1: TVirtualImage;
    EnabledCollection: TImageCollection;
    CheckBox1: TCheckBox;
    DisabledCollection: TImageCollection;
    procedure CheckBox1Click(Sender: TObject);
  private
    procedure SetControlEnablement(ThePanel: TPanel; const IsEnabled: boolean);
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.CheckBox1Click(Sender: TObject);
begin
  SetControlEnablement(Panel1, CheckBox1.Checked);
end;

procedure TForm1.SetControlEnablement(ThePanel: TPanel; const IsEnabled: boolean);
begin
  var LChildCount, LImageIndex: Integer;
  var LChild:     TControl;
  for LChildCount := 0 to Pred(ThePanel.ControlCount) do
  begin
    LChild := ThePanel.Controls[LChildCount];
    LChild.Enabled := IsEnabled;
    if LChild is TVirtualImage then
    begin
      // Store the current index because changing the collection resets it to 0-1
      LImageIndex := TVirtualImage(LChild).ImageIndex;
      if IsEnabled then
        TVirtualImage(LChild).ImageCollection := EnabledCollection
      else
        TVirtualImage(LChild).ImageCollection := DisabledCollection;
      // TVirtual image is a little quirky so you have to blank out the image name to select via Index
      // this is because we are reusing the same index and TVirtualImage will not fetch the new name :)
      TVirtualImage(LChild).ImageName  := '';
      TVirtualImage(LChild).ImageIndex := LImageIndex;
    end;
  end;
end;

end.

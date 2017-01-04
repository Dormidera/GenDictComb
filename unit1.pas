unit Unit1;

{$mode objfpc}{$H+}

interface

uses
        Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs,
	StdCtrls, ExtCtrls, ComCtrls, Math;

type

	{ TmainForm }

        TmainForm = class(TForm)
		Button1: TButton;
		EditItems: TEdit;
		EditLength: TEdit;
		Label1: TLabel;
		Label2: TLabel;
		ProgressBar: TProgressBar;
		rgMode: TRadioGroup;
		SaveDialog: TSaveDialog;
		UpDown1: TUpDown;
		procedure Button1Click(Sender: TObject);
		procedure EditItemsChange(Sender: TObject);
        private
                { private declarations }
                procedure GenerateComb(items: string; actual: string; ammount : integer);
        public
                { public declarations }
        end;

var
        mainForm: TmainForm;
        f : textfile;

implementation

{$R *.lfm}

{ TmainForm }

procedure TmainForm.Button1Click(Sender: TObject);
begin
     if Length(EditLength.Text) > StrToInt(EditLength.Text) then
        EditLength.Text := IntToStr(Length(EditLength.Text));
     if SaveDialog.Execute then
     begin
          with ProgressBar do
          begin
               Max := Trunc(Power(Length(EditItems.Text), StrToInt(EditLength.Text)));
               Position := 0;
	  end;
	  mainForm.Cursor:= crHourGlass;
          AssignFile(f, SaveDialog.FileName);
          Rewrite(f);
          GenerateComb(EditItems.Text,'',StrToInt(EditLength.Text));
          CloseFile(f);
          mainForm.Cursor:= crDefault;
     end;
end;

procedure TmainForm.EditItemsChange(Sender: TObject);
begin
     UpDown1.Max := Length(EditItems.Text);

end;

procedure TmainForm.GenerateComb(items: string; actual: string; ammount: integer);
var
        i: integer;
begin
        if (ammount = 0) then
        begin
           if (Length(Trim(actual)) = StrToInt(EditLength.Text)) then
           begin
              if rgMode.ItemIndex = 0 then WriteLn(f, actual) else Write(f, actual+#10);
              ProgressBar.Position := ProgressBar.Position + 1;
              mainForm.Refresh;
           end;
	end
	else
           for i:=0 to Length(items) do GenerateComb(items, Trim(actual)+items[i],ammount -1);
end;

end.


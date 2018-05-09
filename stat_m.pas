Unit stat_m;
Interface
uses crt,dos;
type screentype   = (mono,color);
var stype : screentype;
	 i,b : byte;
	 regs : registers;
	 opsi2,opsi3,tombol : char;

	 Procedure Cbesar;
	 Procedure Cmati;
	 Procedure Cursor(awal,akhir : byte);
	 Procedure Cnormal;
	 procedure tampilan(st:string);
	 Procedure Enter;
	 Procedure Escape;
	 Procedure menus(tulis2,tulis1 : string);
         Procedure Wbingkai(warna : byte);
         procedure gelap;
	 Function  Hbesar(kal : string) : string;
	 Function  Hkecil(kal : string) : string;

Implementation

    Procedure Cbesar;
    begin
        FillChar(regs,sizeof(regs),0);
        regs.AH := 1;
        regs.CH := 0;
        case stype of
	   mono :regs.CL:= 9;
	   color:regs.CL:= 8;
        end;
		  intr($10,regs);
    end;

    Procedure Cmati;
	 begin
        fillChar(regs,sizeof(regs),0);
        with regs do
        begin
             AH:= $01;
             CH:= $20;
             CL:= $20;
        end;
        intr($10,regs);
    end;

    Procedure Cursor(awal,akhir : byte);
    begin
         regs.ah := 1;
         regs.ch := awal;
         regs.cl := akhir;
         intr($10,regs);
	 end;

	 Procedure Cnormal;
	 begin
			regs.ah := 1;
			regs.ch := 6;
			regs.cl := 7;
			intr($10,regs);
	 end;
	 {cursor(32,0) cursor mati
	  cursor(6,7) cursor normal}

procedure tampilan(st:string);
begin
	  clrscr;
	  textbackground(brown);
	  textcolor(white);
	  for i := 1 to 78 do write(' ');
	  gotoxy(1,1);
	  write(st);
	  gotoxy(45,1); write('<<<<< Basic Statistics 1.1 >>>>>');
	  textbackground(black);
	  textcolor(white);
	  gotoxy(1,2);
	  write('==============================================================================');
end;

Procedure Enter;
const tulis2 = '';
	 tulis1 = 'Tekan <Enter>';
begin
	cmati;
	textbackground(cyan);
	for i := 1 to 79 do
	begin
		gotoxy(i,25); write(' ');
	end;
	textcolor(white);
	gotoxy(79-length(tulis1),25); write(tulis1);
	gotoxy(2,25); write(tulis2);
	textbackground(black);
	tombol := readkey;
end;

Procedure escape;
const tulis2 = '';
	 tulis1 = 'Tekan <esc>';
begin
	cmati;
	textbackground(cyan);
	for i := 1 to 79 do
	begin
		gotoxy(i,25); write(' ');
	end;
	textcolor(white);
	gotoxy(79-length(tulis1),25); write(tulis1);
	gotoxy(2,25); write(tulis2);
	textbackground(black);
	tombol := readkey;
end;

Procedure menus(tulis2,tulis1 : string);
begin
	cmati;
	textbackground(cyan);
	for i := 1 to 79 do
	begin
		gotoxy(i,25); write(' ');
	end;
	textcolor(white);
	gotoxy(79-length(tulis1),25); write(tulis1);
	gotoxy(2,25); write(tulis2);
	textbackground(black);
	tombol := readkey;
end;

	 Procedure Wbingkai(warna : byte);
	 begin
			port[$03D9] := $F and warna;
    end;

    procedure gelap;
    begin
         textbackground(black);
         textcolor(white);
    end;

    function Hbesar;
    begin
         for b := 1 to length(kal) do kal[b] := upcase(kal[b]);
         Hbesar := kal;
    end;

    function Hkecil;
    var sel : integer;
    begin
         sel := ord('a') - ord('A');
         for b := 1 to length(kal) do
         if (kal[b] >= 'A') and (kal[b] <= 'Z') then
         kal[b] := chr(ord(kal[b]) + sel);
         Hkecil := kal;
    end;
end.
        2
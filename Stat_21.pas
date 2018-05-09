{$N+}
Program Tabel_Z;
uses stat_m,crt;
type rext = array[1..100] of extended;
Const
     toleransi  = 1.0e-5;
var
   tz,pel,O,E,OE : array[1..100] of real;
   total2,total12,kelas,prob2 : rext;
   sigma,sbs,sigmaximu,sigmaxixbar,xbar,mu,sigmafx,sigmaxbar,
   rkecBes,sigmas,batas,fak,atas,bawah,itatas,itbawah,ttatas,
   ttbawah,akhir,delx,mid,ganjil,genap,total,total1,xi,prob,
   ft,ftt,sft,sftt,chi,chitab,pelm,pelz : real;
   segmen,segmen2,bidang      : extended;
   i,j,bagian,probii,probi    : integer;
   opsi1,opsi2,lagi                       : char;

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

Procedure tuptext2;
const tulis2 = '<Esc> Menu';
	 tulis1 = '<Enter> Ulang';
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
	opsi2 := readkey;
end;


    procedure Simpson(atas,bawah : real; var total : extended);

    function Fx(xi : real) : extended;
    var normal,zet : real;
        expon      : extended;
    begin
         normal := sigma*sqrt(2*pi);
         zet    := sqr((xi-mu)/sigma);
         expon  := exp(-0.5*zet);
         Fx     := (1/normal)*expon;
    end;

    begin
     bagian := 2;
     j      := 1;
     delx   := (atas-bawah)/bagian;
     ganjil := fx(bawah+delx);
     genap  := 0;
     akhir  := Fx(bawah)+Fx(atas);
     total  := (akhir+4*ganjil)*delx/3;
     repeat
           bagian := bagian*2;
           total1 := total;
           delx   := (atas-bawah)/bagian;
           genap  := genap + ganjil;
           ganjil := 0;
           for i := 1 to (bagian div 2) do
           begin
                xi      := bawah + delx*(2.0*i-1.0);
                ganjil  := ganjil + Fx(xi);
           end;
           total := (akhir + 4*ganjil+2*genap)* delx/3;
           j := j + 1;
     until abs(total - total1) <= abs(toleransi*total);
    end;

    procedure integrasi1;
    begin
     itatas := 0;
     repeat
           simpson(itatas,itbawah,segmen);
           prob := (segmen);
           gotoXY(5,4); write('Harga peluang = ',prob:10:6);
           gotoXY(5,5); write('Harga Z       = ',itatas:10:6);
           itatas := itatas + 0.00001
     until abs(prob-pelz) <= 1e-5;
    end;

    procedure integrasi2;
    begin
     simpson(itatas,itbawah,segmen);
     prob := segmen;
    end;

    procedure hasil1;
    begin
           tampilan('Distribusi normal (Z)');
           itbawah := 0;
           repeat
                 gotoXY(5,4); write('Harga peluang =               ');
                 gotoXY(5,5); write('Harga Z       =               ');
                 gotoXY(5,4); write('Harga peluang = '); readln(pelz);
           until abs(pelz) < 0.5;
           pelm := pelz;
           if pelm < 0 then pelz := -pelz;
           sigma   := 1;        mu      := 0;
           probi   := 0;        probii  := 0;
           cmati;
           integrasi1;
           if pelm < 0 then itatas := -itatas;
           if pelm < 0 then prob := -prob;
           gotoXY(5,4); write('Harga peluang = ',prob:10:6);
           gotoXY(5,5); write('Harga Z       = ',itatas:10:6);
    end;

    procedure hasil2;
    var atasm : real;
    begin
           tampilan('Distribusi normal (Z)');
           itbawah := 0;
           gotoxy(5,4); write('Harga Z       = ');
           gotoXY(5,5); write('Harga peluang = ');
           gotoxy(5,4); write('Harga Z       = '); readln(itatas);
           gotoxy(5,4); write('Harga Z       = ',itatas:10:6);
           atasm := itatas;
           if atasm < 0 then itatas := -itatas;
           sigma   := 1;        mu      := 0;
           probi   := 0;        probii  := 0;
           cmati;
           integrasi2;
           pel[probi] := prob + (probi-probi);
           if atasm < 0 then itatas := -itatas;
           if atasm < 0 then pel[probi] := -pel[probi];
           gotoXY(5,5); write('Harga peluang = ',pel[probi]:10:6);
    end;

     procedure menu;
     begin
         clrscr;
         textbackground(brown); textcolor(yellow);
         gotoxy(25,2);   writeln('             MENU :              ');
         textbackground(blue); textcolor(white);
         gotoxy(25,4);   writeln('                                 ');
	    gotoxy(25,5);   writeln(' A. MENCARI HARGA Z              ');
	    gotoxy(25,6);   writeln(' B. MENCARI PROBABILITAS         ');
	    gotoxy(25,7);   writeln(' X. [EXIT]                       ');
	    gotoxy(25,8);   writeln('                                 ');
	    textcolor(yellow);
	    gotoxy(25,5);   writeln(' A');
	    gotoxy(25,6);   writeln(' B');
	    gotoxy(25,7);   writeln(' X');
	    textbackground(cyan); textcolor(yellow);
	    cbesar;
	    gotoxy(25,10);  writeln('           Pilihan :             ');
	    cmati;
	    i := 0;
	    repeat
		 textbackground(black);
		 textcolor(i);
		 gotoxy(35,23);
		 write(Hbesar('programer:'));
		 gotoxy(32,24);
		 write('Drs. Kasmui, M.Si');
		 gotoxy(28,25);
		 write(Hbesar('jurusan kimia fmipa unnes'));
		 textbackground(cyan);
		 textcolor(i+6);
		 gotoxy(46,10); write('-');
		 delay(300);
		 inc(i,1);
	    until keypressed;
	    cbesar;
	end;
begin
	clrscr;
     textbackground(black);
     repeat
           menu;
           opsi1 := readkey;
           textbackground(black);
           textcolor(white);
           case upcase(opsi1) of
           'A' : begin
                      repeat
                            cbesar;
                            hasil1;
                            tuptext2;
                      until opsi2 = #27;
                 end;
           'B' : begin
                      repeat
                            cbesar;
                            hasil2;
                            tuptext2;
                      until opsi2 = #27;
                 end;
           'X' : halt;
           end;
     until upcase(opsi1) = 'X'
end.


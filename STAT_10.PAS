Program uji_tanda;
uses crt,dos,stat_m;
type datar  = array[1..100] of real;
var opsi1,opsi2,opsi3,metu,ps:char;
    j,jj,cnt,ndp,min,plus,hdata : integer;
    hbatas : real;
    x,y:datar;
    reg : registers;

procedure printing;
begin
     clrscr;
	  textbackground(lightgray);
     textcolor(white);
     gotoxy(27,2); write('                             ');
     gotoxy(27,3); write('    TUJUAN OUTPUT :          ');
     gotoxy(27,4); write(' 1. Display di monitor       ');
     gotoxy(27,5); write(' 2. Cetak di printer         ');
     gotoxy(27,6); write('                             ');
     textcolor(yellow);
     gotoxy(27,4); write(' 1');
     gotoxy(27,5); write(' 2');
     textbackground(brown);
     textcolor(yellow);
	  gotoxy(27,8); write('    Pilihanku :              ');
     gotoxy(43,8);
     textbackground(black);
     ps := readkey;
     if ps = '1' then begin end;
end;

Procedure Warna(xb,yb,xe,ye : word; B : word);
begin
     for i := yb to ye do
     begin
          for j := xb to xe do
          begin
               TextBackGround(B);
               GotoXY(i,j);
               write(char(255));
          end;
     end;
end;

    procedure tampilan(st:string);
    begin
     clrscr;
     textbackground(brown);
     textcolor(white);
     for i := 1 to 76 do write(' ');
     gotoxy(1,1);
     write(st);
     gotoxy(45,1); write('<<<<< Basic Statistics 1.1 >>>>>');
     gotoxy(1,2);
     textbackground(black);
     write('============================================================================');
	 end;

	 procedure input;
	 type
		kata   = string[10];
		freal  = file of real;
		fint   = file of integer;
		fkata  = file of kata;
	 var nama    : kata;
		  fk      : fkata;
	fi      : fint;
	frx,fry : freal;

	 begin
		 clrscr;
		 Cbesar;
		 tampilan('Nonparametrik : Uji tanda');
		 gotoxy(15,3); write('NAMA FILE : '); readln(nama);
		 writeln;
		 assign(fk,nama);
		 assign(fi, nama+'.dat');
		 assign(frx,nama+'xi.dat');
		 assign(fry,nama+'yi.dat');
		 rewrite(fk);
		 rewrite(fi);
		 rewrite(frx);
		 rewrite(fry);
		 write(fk,nama);
		 gotoxy(15,4); write('Banyaknya data sampel = '); readln(ndp);
	    write(fi,ndp);
	    writeln;
	    for cnt := 1 to ndp do
	    begin
		    write('x(':16,cnt,') = '); readln(x[cnt]); write(frx,x[cnt]);
		    write('y(':16,cnt,') = '); readln(y[cnt]); write(fry,y[cnt]);
		    writeln;
	    end;
	    close(fk);
	    close(fi);
	    close(frx);
	    close(fry);
    end;

    procedure load;
    type
        kata   = string[10];
		  freal  = file of real;
        fint   = file of integer;
        fkata  = file of kata;
    var nama    : kata;
        fk      : fkata;
        fi      : fint;
        frx,fry : freal;
        ada     : boolean;
        metu    : char;
    label 01;

    begin
         01:
         clrscr;
			cbesar;
			tampilan('Nonparametrik : Uji tanda');
			textbackground(black);
			textcolor(yellow);
			gotoxy(5,3); write('NAMA FILE : '); readln(nama);
			{$I-}
         assign(fk,nama);
         assign(fi,nama+'.dat');
         assign(frx,nama+'xi.dat');
         assign(fry,nama+'yi.dat');
         reset(fk);
			reset(fi);
         reset(frx);
         reset(fry);
         {$I+}
         ada := (IOResult = 0);
         if ada then
         begin
              read(fk,nama);
              read(fi,ndp);
              for cnt := 1 to ndp do
              begin
                   read(frx,x[cnt]);
              end;
              for cnt := 1 to ndp do
              begin
                   read(fry,y[cnt]);
              end;
         end;
         if not ada then
         begin
              clrscr;
              cmati;
				  textcolor(lightred); write(#7);
				  gotoxy(20,5); write('FILE TIDAK ADA ! ');
              gotoxy(20,7); write('Tekan <Esc> Keluar atau <Enter> Ulang');
              metu := readkey;
				  if metu = #27 then halt else goto 01;
         end;
         close(fk);
         close(fi);
         close(frx);
         close(fry);
    end;

Procedure tekan_esc;
const tulis2 = '<Esc> Keluar';
	 tulis1 = '<Enter> Ulang';
begin
	cmati;
	textbackground(cyan);
	for i := 1 to 79 do
	begin
		gotoxy(i,25); write(' ');
	end;
	textcolor(white);
	gotoxy(79-length(tulis1),25);
	write(tulis1);
	gotoxy(2,25);
	write(tulis2);
	opsi2 := readkey;
	textbackground(black);
end;

	 procedure menu;
	 begin
	      clrscr;
	      textbackground(brown);
	      textcolor(white);
	      gotoxy(27,3); write('         UJI TANDA           ');
	textbackground(blue);
	textcolor(white);
	gotoxy(27,5); write('                             ');
	gotoxy(27,6); write(' 0. [MENU UTAMA]             ');
	gotoxy(27,7); write(' 1. Memasukkan data baru     ');
	gotoxy(27,8); write(' 2. Mengambil data tersimpan ');
	gotoxy(27,9); write('                             ');
	textcolor(yellow);
	gotoxy(27,6); write(' 0');
	gotoxy(27,7); write(' 1');
	gotoxy(27,8); write(' 2');
	textbackground(cyan);
	textcolor(yellow);
	gotoxy(27,11); write('    Pilihanku :              ');
	gotoxy(43,11);
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
			  gotoxy(45,11); write('-');
			  delay(300);
			  inc(i,1);
	until keypressed;
        textbackground(black);
	textcolor(white);
	opsi1 := readkey;
	case opsi1 of
	'1' : input;
	'2' : load;
	'0' : halt;
	end;
    end;

    procedure tanda;
	 begin
         min := 0;
         plus := 0;
         for cnt := 1 to ndp do
         begin
              if (x[cnt]-y[cnt]) < 0 then min := min + 1;
              if (x[cnt]-y[cnt]) > 0 then plus := plus + 1;
         end;
         if min < plus then hdata := min;
         if min > plus then hdata := plus;
         hbatas := 0.5*(ndp-1)-0.98*sqrt(ndp+1);
         hbatas := round(hbatas);
         gotoxy(5,5); write('Ukuran sampel = ',ndp);
         gotoxy(5,6); write('Harga h data  = ',hdata);
         gotoxy(5,7); write('Harga h batas = ',hbatas:1:0);
         gotoxy(5,9); write('Kesimpulan    :');
         if hdata > hbatas then
         begin
              gotoxy(5,10);
				  write('Karena h data > h batas maka');
              gotoxy(5,11);
              write('Ada perbedaan signifikan pada alpha 0,05.');
         end else
         begin
              gotoxy(5,10);
              write('Karena h data < h batas maka');
              gotoxy(5,11);
              write('Tidak ada perbedaan signifikan pada alpha 0,05.');
         end;
    end;

Begin
     clrscr;
     repeat
           clrscr;
			  warna(0,0,80,25,black);
			  repeat
					menu;
			  until opsi1 in ['1','2','0'];
           clrscr;
           printing;
			  tampilan('Nonparametrik : Uji tanda');
			  tanda;
			  if ps = '2' then intr(5,reg);
			  tekan_esc;
	  until opsi2 = #27;
end.

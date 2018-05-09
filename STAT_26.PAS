Program display;
Uses CRT,stat_m;
type vector  = array[1..100] of real;
	matrika = array[1..100,1..100] of real;
	datak   = array[1..100] of byte;
	datar   = vector;
	screentype   = (mono,color);
var x,y,w,ytopi,yaksen,residu,sqresidu                  : vector;
    cnt,ndp : integer;
    jvar : byte;
    opsi,opsi2 : char;

Procedure tuptext;
const tulis2 = '<Esc>-Menu';
	 tulis1 = '<Enter>-Ulang';
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
	opsi2:= readkey;
	textbackground(black);
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
	frx,fry,frw : freal;

    begin
         clrscr;
	 Cbesar;
	 tampilan('Menyimpan data baru');
	 gotoxy(15,3); write('NAMA FILE       : '); readln(nama);
         Repeat
               gotoxy(15,4); ClrEol;
               gotoxy(15,4); write('JUMLAH VARIABEL : '); readln(jvar);
         Until jvar < 4;

         if jvar = 2 then
         begin
	      writeln;
	      assign(fk,nama);
	      assign(fi,nama+'.dat');
	      assign(frx,nama+'xi.dat');
	      assign(fry,nama+'yi.dat');
	      rewrite(fk);
	      rewrite(fi);
	      rewrite(frx);
	      rewrite(fry);
	      write(fk,nama);
	      gotoxy(15,5); write('Banyaknya data sampel = '); readln(ndp);
	      write(fi,ndp);
	      writeln;
	      for cnt := 1 to ndp do
	      begin
	           write('x(':16,cnt,') = '); readln(x[cnt]);
		   if x[1] = 0 then x[1] := 0.0000001;
		   write(frx,x[cnt]);

		   write('y(':16,cnt,') = '); readln(y[cnt]);
                   write(fry,y[cnt]);
		   writeln;
	      end;
	      close(fk);
	      close(fi);
	      close(frx);
	      close(fry);
	 end;

         if jvar = 1 then
         begin
	      writeln;
	      assign(fk,nama);
	      assign(fi,nama+'.dat');
	      assign(frx,nama+'xi.dat');
	      rewrite(fk);
	      rewrite(fi);
	      rewrite(frx);
	      write(fk,nama);
	      gotoxy(15,5); write('Banyaknya data sampel = '); readln(ndp);
	      write(fi,ndp);
	      writeln;
	      for cnt := 1 to ndp do
	      begin
	           write('x(':16,cnt,') = '); readln(x[cnt]);
		   if x[1] = 0 then x[1] := 0.0000001;
		   write(frx,x[cnt]);
	      end;
	      close(fk);
	      close(fi);
	      close(frx);
	 end;

         if jvar = 3 then
         begin
	      writeln;
	      assign(fk,nama);
	      assign(fi,nama+'.dat');
	      assign(frx,nama+'xi.dat');
	      assign(fry,nama+'yi.dat');
	      assign(frw,nama+'wi.dat');
	      rewrite(fk);
	      rewrite(fi);
	      rewrite(frx);
	      rewrite(fry);
	      rewrite(frw);
	      write(fk,nama);
	      gotoxy(15,5); write('Banyaknya data sampel = '); readln(ndp);
	      write(fi,ndp);
	      writeln;
	      for cnt := 1 to ndp do
	      begin
	           write('x(':16,cnt,') = '); readln(x[cnt]);
		   if x[1] = 0 then x[1] := 0.0000001;
		   write(frx,x[cnt]);

		   write('y(':16,cnt,') = '); readln(y[cnt]);
                   write(fry,y[cnt]);

		   write('w(':16,cnt,') = '); readln(w[cnt]);
		   write(frw,w[cnt]);
                   writeln;
	      end;
	      close(fk);
	      close(fi);
	      close(frx);
	      close(fry);
	      close(frw);
	 end;
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
	frx,fry,frw : freal;
        ada     : boolean;
	metu    : char;
    label 01;

    begin
         01:
         clrscr;
	 cbesar;
	 tampilan('Ambil data tersimpan');
         textbackground(black);
         textcolor(yellow);
	 gotoxy(25,3); write('NAMA FILE       : '); readln(nama);
         Repeat
               gotoxy(15,4); ClrEol;
               gotoxy(25,4); write('JUMLAH VARIABEL : '); readln(jvar);
         Until jvar < 4;

         if jvar = 3 then
         begin
              {$I-}
	      assign(fk,nama);
              assign(fi,nama+'.dat');
              assign(frx,nama+'xi.dat');
	      assign(fry,nama+'yi.dat');
	      assign(frw,nama+'wi.dat');
	      reset(fk);
	      reset(fi);
	      reset(frx);
	      reset(fry);
	      reset(frw);
	      {$I+}
	      ada := (IOResult = 0);
	      if ada then
	      begin
	           read(fk,nama);
	           read(fi,ndp);
	           for cnt := 1 to ndp do
	           begin
	                read(frx,x[cnt]);
		        if x[1] = 0 then x[1] := 0.0000001;
	           end;
	           for cnt := 1 to ndp do
	           begin
	                read(fry,y[cnt]);
	           end;
	           for cnt := 1 to ndp do
	           begin
	                read(frw,w[cnt]);
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
	      close(frw);
         end;
         if jvar = 2 then
         begin
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
		        if x[1] = 0 then x[1] := 0.0000001;
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
         if jvar = 1 then
         begin
              {$I-}
	      assign(fk,nama);
              assign(fi,nama+'.dat');
              assign(frx,nama+'xi.dat');
	      reset(fk);
	      reset(fi);
	      reset(frx);
	      {$I+}
	      ada := (IOResult = 0);
	      if ada then
	      begin
	           read(fk,nama);
	           read(fi,ndp);
	           for cnt := 1 to ndp do
	           begin
	                read(frx,x[cnt]);
		        if x[1] = 0 then x[1] := 0.0000001;
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
         end;
end;

procedure menu1;
begin
                        textbackground(black);
		        clrscr;
		        textbackground(black); textcolor(yellow);
			clrscr;
			tampilan('MANAJEMEN DATA');
                        textbackground(brown); textcolor(yellow);
			gotoxy(30,3);   write('   ASAL DATA    ');
			textbackground(blue); textcolor(white);
			gotoxy(30,5);   write('                 ');
			gotoxy(30,6);   write(' 1. Data Baru    ');
			gotoxy(30,7);   write(' 2. Data Lama    ');
			gotoxy(30,8);   write(' 3. Menu Utama   ');
			gotoxy(30,9);   write('                 ');
			textcolor(yellow);
			gotoxy(30,6);   write(' 1');
			gotoxy(30,7);   write(' 2');
			gotoxy(30,8);   write(' 3');
			textbackground(cyan); textcolor(yellow);
			gotoxy(30,11);   write('   Pilihan :     ');
			gotoxy(43,11);
			opsi := readkey;
			textbackground(black);
			case opsi of
			'1' : begin
			           input;
                              end;
                        '2' : begin
                                   load;
                              end;
                        '3' : halt;
                        end;
end;

begin
     Repeat
     menu1;
     ClrScr;
     cbesar;
     tampilan('Display data tersimpan');
     textbackground(black);
     textcolor(yellow);
     gotoxy(1,3); clreol;
     gotoxy(25,3);  write('Data 1 : ');
     gotoxy(40,3);  write('Data 2 : ');
     gotoxy(55,3);  writeln('Data 3 : ');
     cmati;
     if ndp < 21 then
     begin
          for cnt := 1 to ndp do
	  begin
	       gotoxy(25,cnt + 4);  write(x[cnt]:5:4);
	       gotoxy(40,cnt + 4);  write(y[cnt]:5:4);
               gotoxy(55,cnt + 4);  write(w[cnt]:5:4);
	  end;
     end else
     begin
          for cnt := 1 to 20 do
	  begin
	       writeln(cnt:15,x[cnt]:15:4,y[cnt]:15:4,w[cnt]:15:4);
	  end;
	  readln;
	  for cnt := 21 to ndp do
	  begin
	       writeln(cnt:15,x[cnt]:15:4,y[cnt]:15:4,w[cnt]:15:4);
	  end;
     end;
     tuptext;
     Until opsi2 = #27;
end.


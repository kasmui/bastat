Program Mengedit_data;
Uses CRT,stat_m;
type vector  = array[1..100] of real;
	matrika = array[1..100,1..100] of real;
	datak   = array[1..100] of byte;
	datar   = vector;{array[1..50] of real;}
	screentype   = (mono,color);
var x,y,w,ytopi,yaksen,residu,sqresidu                  : vector;
   jj,cnt,ndp,i,pilih                                     : integer;
   metu : char;
Label 140;

Procedure edit_data;
	 type
		kata   = string[10];
		  freal  = file of real;
		  fint   = file of integer;
        fkata  = file of kata;
    var nama,namaf    : kata;
        fk,fke      : fkata;
        fi,fie      : fint;
		  frx,fry,frw,frxe,frye,frwe  : freal;
		  yt : char;
	 Label 01;
    begin
         01 :
         clrscr;
                        textbackground(black);
		        clrscr;
		        textbackground(black); textcolor(yellow);
			tampilan('Edit data tersimpan');
			textcolor(yellow);
			cbesar;
			gotoxy(10,3); write('NAMA FILE : '); readln(nama);
			{$I-}
			assign(fk,nama);
			assign(fi,nama+'.dat');
			assign(frx,nama+'xi.dat');
			assign(fry,nama+'yi.dat');
			{assign(frw,nama+'wi.dat');}

			reset(fk);
			reset(fi);
			reset(frx);
			reset(fry);
			{reset(frw);}
			{$I+}
			if IOResult = 0 then
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
				  {for cnt := 1 to ndp do
				  begin
						 read(frw,w[cnt]);
				  end;}
			end else
			begin
				  clrscr;
				  cmati;
				  textcolor(lightred); write(#7);
				  gotoxy(20,5); write('FILE TIDAK ADA ! ');
				  gotoxy(20,7); write('Tekan <Esc> Keluar atau <Enter> Ulang');
				  metu := readkey;
				  if metu = #27 then exit else goto 01;
			end;

			cbesar;
			textcolor(yellow);
			gotoxy(10,4); write('FILE BARU (harus sama dengan nama file asal) : '); readln(namaf);
			gotoxy(10,5); write('BANYAKNYA DATA : '); readln(ndp);

			assign(fke,namaf);
			assign(fie,namaf+'.dat');
			assign(frxe,namaf+'xi.dat');
			assign(frye,namaf+'yi.dat');
			{assign(frwe,namaf+'wi.dat');}

			rewrite(fke);
			rewrite(fie);
			rewrite(frxe);
			rewrite(frye);
			{rewrite(frwe);}

			write(fke,namaf);

			GotoXY(20,7);  write('   OPTION :     ');
			GotoXY(20,8);  write('1. EDIT DATA    ');
			GotoXY(20,9);  write('2. TAMBAH DATA  ');
			GotoXY(20,10);  write('3. EXIT  ');
			GotoXY(20,12);  write('   PILIHAN :    ');
			yt := readkey;
			if yt = '1' then
		 begin
				  write(fie,ndp);
				  repeat
						  GotoXY(37,13);  write('           ');
						  GotoXY(37,14);  write('           ');
						  GotoXY(37,15);  write('           ');
						  GotoXY(37,16);  write('           ');
						  GotoXY(37,17);  write('           ');
						  GotoXY(20,13);  write('NOMOR DATA     ? '); read(cnt);
						  if cnt <> 0 then
						  begin
								 GotoXY(20,14);  write('Harga X semula = ',X[cnt]:6:2);
								 GotoXY(20,15);  write('Harga Y semula = ',y[cnt]:6:4);
								 GotoXY(20,16);  write('Harga X baru   = ');
								 read(X[cnt]);
								 GotoXY(20,17);  write('Harga Y baru   = ');
								 read(y[cnt]);
								 GotoXY(20,19);  write('ISI <0> UNTUK SELESAI EDIT ');
						  end;
				  until cnt = 0 ;
			 for cnt := 1 to ndp do
				  begin
						 write(frxe,x[cnt]);
				  end;
				  for cnt := 1 to ndp do
				  begin
						 write(frye,y[cnt]);
				  end;
				  {for cnt := 1 to ndp do
				  begin
						 w[cnt] := 1;
						 write(frwe,w[cnt]);
				  end;}
			end;
			if yt = '2' then
			begin
				  cnt := ndp;
				  repeat
						  cnt := cnt + 1;
						  GotoXY(20,12);  write('                          ');
						  GotoXY(20,11);  write('Nomor data     = ',cnt);
						  GotoXY(20,12);  write('Harga X baru   = ');
						  read(X[cnt]);
						  GotoXY(20,13);  write('Harga Y baru   = ');
						  read(Y[cnt]);
						  GotoXY(20,15);  write('ISI HARGA Y = 999 UNTUK SELESAI EDIT ');
						  jj := cnt;
				  until (y[cnt] >= 999) or (X[cnt] >= 999) ;
				  ndp := jj - 1;
				  write(fie,ndp);
				  for cnt := 1 to ndp do
				  begin
						 write(frxe,x[cnt]);
				  end;
				  for cnt := 1 to ndp do
				  begin
						 write(frye,y[cnt]);
				  end;
				  {for cnt := 1 to ndp do
				  begin
				 w[cnt] := 1;
						 write(frwe,w[cnt]);
				  end;}
			end;
			if yt = '3' then exit;

			close(fk);
			close(fi);
			close(frx);
			close(fry);
			{close(frw);}

			close(fke);
			close(fie);
			close(frxe);
			close(frye);
			{close(frwe);}
	 end;

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


Begin
     cbesar;
     edit_data;
end.
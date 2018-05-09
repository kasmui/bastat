{$M 4000,0,0}
Program Variansi_rata;
Uses CRT,stat_m,dos;
type
	 Dr = array[1..200] of real;
	 {Drr= array[1..10,1..10] of real;}
var
	reg : registers;
	sd,dss,rs,x,us,dk,s,s2,ls2,dls2,ds2,dsi : dr;
	sigmaxixbar,jx,jx2,xbar,sbs,min,mak,js,jdk,js2,jls2,jdls2,jds2,sgab,a,b,cd,ct : real;
	sdl,lsd,ttab,sus,us1,dks,usj,dkj,sj,s2j,ls2j,dls2j,ds2j,jdsi,jdsi2 : real;
	i,ii,j,jj,jjj : byte;
	ng,ndp,nkec,iii : integer;
	Rx,Ax,Dx,fd,ft,chitab : real;
	pmenu,ps,lagi,dopsi,opsi,opsi1,opsi2,opsi3 : char;
	nama,namaf : string[10];
	sig : string[20];

procedure Hapus_layar;
begin
	  clrscr;
	  textbackground(black);
	  textcolor(white);
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

procedure min_mak(ndp : integer; var min,mak : real);
var i : integer;
begin
	  min := x[1];
     mak := x[1];
     for i := 2 to ndp do
     begin
          if x[i] < min then min := x[i];
			 if x[i] > mak then mak := x[i];
	  end;
end;

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
	  writeln('==============================================================================');
	  textbackground(black);
end;

procedure printing;
begin
	  clrscr;
	  textbackground(7);
     textcolor(white);
     gotoxy(27,2); write('                             ');
     gotoxy(27,3); write(' 0. [MENU]                   ');
     gotoxy(27,4); write(' 1. Display di monitor       ');
     gotoxy(27,5); write(' 2. Cetak di printer         ');
     gotoxy(27,6); write('                             ');
     textcolor(yellow);
     gotoxy(27,3); write(' 0');
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

Procedure ulang;
const tulis2 = '<Y>-Menu';
	 tulis1 = '<T>-Keluar';
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

Procedure terus;
const tulis2 = '';
	 tulis1 = 'Tekan enter';
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
	readln;
	textbackground(black);
end;

procedure enter(var ndp : integer);
type
	 kata     = string[10];
	 filereal = file of real;
	 fileint  = file of integer;
	 filekata = file of kata;
var
	namaf,nama : kata;
	fk    : filekata;
	fi    : fileint;
	frx    : filereal;

begin
	  clrscr;
	  cbesar;
	  tampilan('Memasukkan data baru');
	  gotoxy(20,3); write('Nama File : '); readln(nama);
	  namaf := nama;
	  writeln;
	  assign(fk,nama);
	  assign(fi,nama+'.dat');
	  assign(frx,nama+'xi.dat');
	  rewrite(fk);
	  rewrite(fi);
	  rewrite(frx);
	  gotoxy(20,4); write('                      ');
	  gotoxy(20,4); write('Ukuran Sampel    = '); readln(ndp);
	  writeln;
	  for i := 1 to ndp do
	  begin
			 if i < 20 then
			 begin
					gotoxy(20,4+i); write('Data ',i,' = ');
					readln(x[i]);  write(frx,x[i]);
			 end else
			 begin
					gotoxy(45,i-15); write('Data ',i,' = ');
					readln(x[i]);  write(frx,x[i]);
			 end;
	  end;
	  min_mak(ndp,min,mak);
	  write(fk,nama);
	  write(fi,ndp);
	  close(fk);
	  close(fi);
	  close(frx);
end;

procedure load(var ndp : integer);
type
	 kata     = string[10];
	 filereal = file of real;
	 fileint  = file of integer;
	 filekata = file of kata;
var
	nama,namaf : kata;
	fk    : filekata;
	fi    : fileint;
	frx    : filereal;
	metu : char;
label 01;

begin
	  01:
	  clrscr;
	  cbesar;
	  tampilan('Mengambil data tersimpan');
	  gotoxy(20,3); write('Nama File                : '); readln(nama);
	  namaf := nama;
	  gotoxy(20,4); write('Pilihan variabel (x/y/w) : ');
	  dopsi := readkey;
	  assign(fk,nama);
	  assign(fi,nama+'.dat');
	  assign(frx,nama+dopsi+'i.dat');
	  {$I-}
	  reset(fk);
	  reset(fi);
	  reset(frx);
	  {$I+}
	  if IOResult = 0 then
	  begin
			 clrscr;
			 read(fk,nama);
			 read(fi,ndp);
			 for i := 1 to ndp do
			 begin
					read(frx,x[i]);
			 end;
	  end else
	  begin
			 clrscr;
			 cmati;
			 gotoxy(10,3); write('File tidak ditemukan !');
			 gotoxy(10,4); write('Tekan <Esc> Keluar Tekan <Enter> Ulang... !');
			 write(#7);
			 metu := readkey;
			 if metu = #27 then halt else goto 01;
	  end;
	  min_mak(ndp,min,mak);
     close(fk);
     close(fi);
     close(frx);
end;

procedure SESamp;
begin
     xbar := 0;
	  jx := 0;
     jx2 := 0;
	  for i := 1 to nkec do
     begin
          xbar := xbar + x[i];
			 jx   := jx + x[i];
          jx2  := jx2 + sqr(x[i]);
     end;
     xbar := xbar/nkec;
     sigmaxixbar := 0;
	  for i := 1 to nkec do
     begin
          sigmaxixbar := sigmaxixbar + sqr((x[i]-xbar))
     end;
     sbs := sqrt(sigmaxixbar/(nkec-1))
end;

procedure display_data(nama : string; var ndp : Integer);
var namaf : string[20];
begin
	  gotoxy(45,4); write('Data pilihan ',upcase(opsi));
	  {gotoxy(60,4); write(' file : ',namaf);}
	  if ndp < 39 then
     begin
			 for i := 1 to ndp do
          begin
               if i < 20 then
               begin
                    gotoxy(45,i+4); writeln(i,'. ');
						  gotoxy(50,i+4); writeln(x[i]:3:2);
               end else
               begin
                    gotoxy(60,i-15); writeln(i,'. ');
                    gotoxy(65,i-15); writeln(x[i]:3:2);
               end;
			 end;
     end else
     begin
          for i := 1 to ndp do
          begin
               if i < 20 then
               begin
						  gotoxy(45,i+4); writeln(i,'. ');
						  gotoxy(50,i+4); writeln(x[i]:3:2);
               end else
               begin
                    if (i >= 20) and (i < 38) then
                    begin
								 gotoxy(60,i-15); writeln(i,'. ');
                         gotoxy(65,i-15); writeln(x[i]:3:2);
                    end else
                    begin
                         if i = 38 then
                         begin
										gotoxy(60,23);
                              writeln('38.  Dst ...');
                         end;
                         if i > 38 then
                         begin
                         end;
                    end;
               end;
			 end;
     end;
	  ng := ndp+4;
	  if ndp > 20  then ng := 23;
     for i := 2 to ng do
	  begin
          gotoxy(40,i); writeln('+');
     end;
end;

procedure menu(var ndp : integer);
begin
	  clrscr;
	  tampilan('ONEWAY ANOVA');
	  textbackground(3);
	  textcolor(white);
	  cbesar;
	  gotoxy(27,3); write('                             ');
	  gotoxy(27,4); write(' 0. [MENU]                   ');
	  gotoxy(27,5); write(' 1. Memasukkan data baru     ');
	  gotoxy(27,6); write(' 2. Mengambil data tersimpan ');
	  gotoxy(27,7); write('                             ');
	  textcolor(yellow);
	  gotoxy(27,4); write(' 0');
	  gotoxy(27,5); write(' 1');
	  gotoxy(27,6); write(' 2');
	  textbackground(brown);
	  textcolor(yellow);
	  gotoxy(27,9); write('    Pilihanku :              ');
	  gotoxy(43,9);
	  textbackground(black);
	  cmati;
end;

procedure menu2;
begin
	  clrscr;
	  tampilan('Pilihan data');
	  textbackground(3);
	  textcolor(white);
	  cbesar;
	  gotoxy(27,3); write('                             ');
	  gotoxy(27,4); write(' 0. [MENU]                   ');
	  gotoxy(27,5); write(' 1. Input data 1             ');
	  gotoxy(27,6); write(' 2. Input data 2             ');
	  gotoxy(27,7); write('                             ');
	  textcolor(yellow);
	  gotoxy(27,4); write(' 0');
	  gotoxy(27,5); write(' 1');
	  gotoxy(27,6); write(' 2');
	  textbackground(brown);
	  textcolor(yellow);
	  gotoxy(27,9); write('    Pilihanku :              ');
	  gotoxy(43,9);
	  textbackground(black);
	  cmati;
end;

	procedure tabelchi(js : real; var dks,chitab : real);
	begin
	  dks := js-1;
	  case round(dks) of
	  1    :  chitab := 3.84;  2    :  chitab := 5.99;  3    :  chitab := 7.81;
     4    :  chitab := 9.49;  5    :  chitab := 11.1;  6    :  chitab := 12.6;
     7    :  chitab := 14.1;  8    :  chitab := 15.5;  9    :  chitab := 16.9;
     10   :  chitab := 18.3;  11   :  chitab := 19.7;  12   :  chitab := 21.0;
     13   :  chitab := 22.4;  14   :  chitab := 23.7;  15   :  chitab := 25.0;
	  16   :  chitab := 26.3;  17   :  chitab := 27.6;  18   :  chitab := 28.9;
     19   :  chitab := 30.1;  20   :  chitab := 31.4;  21   :  chitab := 32.7;
     22   :  chitab := 33.9;  23   :  chitab := 35.2;  24   :  chitab := 36.4;
     25   :  chitab := 37.7;  26   :  chitab := 38.9;  27   :  chitab := 40.1;
	  28   :  chitab := 41.3;  29   :  chitab := 42.6;  30..39 :  chitab := 43.8;
	  40..49   :  chitab := 55.8;  50..59   :  chitab := 67.5;  60..69   :  chitab := 79.1;
	  70..79   :  chitab := 90.5;  80..89   :  chitab := 101.9; 90..99   :  chitab := 118.1;
	  end;
   end;

   procedure homvar(ps : char);
   begin
        clrscr;
		  tampilan('HOMOGENITAS VARIANS');
		  textbackground(black);
        cbesar;
        textcolor(white);
		  gotoxy(5,3); write('Jumlah sampel = '); readln(js);
		  gotoxy(45,3); write('US = Ukuran sampel');
		  usj  := 0; dkj   := 0; sj   := 0; s2j := 0;
		  ls2j := 0; dls2j := 0; ds2j := 0;
		  textcolor(yellow);
		  gotoxy(5,4); write('Sampel  US  dk   Si      Siý      logSiý    dklogSiý   dkSiý');
		  textcolor(white);
		  for ii := 1 to round(js) do
		  begin
				 gotoxy(5,4+ii);  write(ii:2);
				 repeat
					gotoxy(13,4+ii); write('   ');
					gotoxy(13,4+ii); read(us[ii]);
				 until us[ii] < 101;
				 usj := usj + us[ii];
				 dk[ii] := us[ii]-1;
				 dkj := dkj + dk[ii];
				 gotoxy(17,4+ii); write(dk[ii]:0:0);
				 gotoxy(17,5+round(js)); write(dkj:0:0);
				 nkec := round(us[ii]);
				 gotoxy(5,22); write('Masukkan data sampel ',ii);
				 for i := 1 to nkec do
				 begin
					if i <= 15 then
					begin
						gotoxy(5*i,23); read(dsi[i]);
						x[i] := dsi[i];
					end;
					if (i > 15) and (i <= 30) then
					begin
						gotoxy((5*i)-75,24); read(dsi[i]);
						x[i] := dsi[i];
					end;
				 end;
				 SEsamp;
				 s[ii] := sbs;
				 gotoxy(1,22); clreol;
				 gotoxy(1,23); clreol;
				 gotoxy(1,24); clreol;
				 gotoxy(21,4+ii); write(s[ii]:0:4);
				 sj := sj + s[ii];
				 s2[ii] := sqr(s[ii]);
				 s2j := s2j + s2[ii];
				 gotoxy(28,4+ii); write(s2[ii]:0:4);
				 gotoxy(28,5+round(js)); write(s2j:0:4);
				 ls2[ii] := ln(s2[ii])/ln(10);
				 ls2j := ls2j + ls2[ii];
				 gotoxy(39,4+ii); write(ls2[ii]:0:4);
				 gotoxy(39,5+round(js)); write(ls2j:0:4);
				 dls2[ii] := dk[ii]*ls2[ii];
				 dls2j := dls2j + dls2[ii];
				 gotoxy(49,4+ii); write(dls2[ii]:0:4);
				 gotoxy(49,5+round(js)); write(dls2j:0:4);
				 ds2[ii] := dk[ii]*s2[ii];
				 ds2j := ds2j + ds2[ii];
				 gotoxy(60,4+ii); write(ds2[ii]:0:4);
				 gotoxy(60,5+round(js)); write(ds2j:0:4);
		  end;
		  sgab := ds2j/dkj;
		  gotoxy(5,7+round(js));  write('Varians gabungan sampel  = ',sgab:8:4);
		  B := (ln(sgab)/ln(10))*dkj;
		  gotoxy(5,8+round(js));  write('Harga B                  = ',B:8:4);
		  cd := ln(10)*(B-dls2j);
		  gotoxy(5,9+round(js)); write('Harga Chiý data          = ',cd:8:4);
		  tabelchi(js,dks,chitab);
		  ct := chitab;
		  gotoxy(5,10+round(js)); write('Harga Chiý tabel         = ',ct:8:4);
		  textcolor(yellow);
		  if cd < ct then
		  begin
				 gotoxy(5,12+round(js)); write('Kesimpulan :');
				 textcolor(white);
				 gotoxy(5,13+round(js)); write('Karena Chiý data < Chiý tabel maka');
				 gotoxy(5,14+round(js)); write('Sampel memiliki variansi yang sama/homogen');
		  end else
		  begin
				 gotoxy(5,12+round(js)); write('Kesimpulan :');
				 textcolor(white);
				 gotoxy(5,13+round(js)); write('Karena Chiý data > Chiý tabel maka');
				 gotoxy(5,14+round(js)); write('Sampel tidak memiliki variansi yang sama/homogen');
		  end;
		  if ps = '2' then intr(5,reg);
	end;

	procedure bartlett(ps : char);
	begin
		  clrscr;
		  tampilan('ANAVA 1 JALUR');
		  cbesar;
		  textbackground(black);
		  textcolor(white);
		  gotoxy(5,3); write('Jumlah sampel = ');
		  gotoxy(22,3);
		  exec('anova.exe','');
		  gotoxy(5,3); write('Jumlah sampel = '); readln(js);
		  gotoxy(50,3); write('US = Ukuran sampel');
		  usj  := 0; sj   := 0; s2j := 0;
		  ls2j := 0; dls2j := 0; ds2j := 0;
		  sus := 0;
		  textcolor(yellow);
		  gotoxy(5,4); write('Sampel      US         äX            äXý          Rata-rata');
		  textcolor(white);
		  for i := 1 to round(js) do
		  begin
				 gotoxy(5,4+i);  write(i:2);
				 gotoxy(5,5+round(js));  write('Jumlah':2);
				 repeat
					gotoxy(17,4+i); write('   ');
					gotoxy(17,4+i); read(us[i]);
				 until us[i] < 101;
				 us1 := us[1];
				 usj := usj + us[i];
				 sus := us[i]-sus;
				 gotoxy(17,5+round(js)); write(usj:0:0);
				 jdsi  := 0;
				 jdsi2 := 0;
				 gotoxy(5,22); write('Masukkan data sampel ',i);
				 for j := 1 to round(us[i]) do
				 begin
					if j <= 15 then
					begin
						gotoxy(5*j,23); read(dsi[j]);
					end;
					if (j > 15) and (j <=30) then
					begin
						gotoxy((5*j)-75,24); read(dsi[j]);
					end;
					jdsi := jdsi + dsi[j];
					jdsi2 := jdsi2 + sqr(dsi[j]);
				 end;
				 gotoxy(1,22); clreol;
				 gotoxy(1,23); clreol;
				 gotoxy(1,24); clreol;
				 s[i] := jdsi;
				 gotoxy(26,4+i); write(s[i]:0:4);
				 rs[i] := s[i]/us[i];
				 gotoxy(55,4+i); write(rs[i]:0:4);
				 sj := sj + s[i];
				 gotoxy(26,5+round(js)); write(sj:0:4);
				 s2[i] := jdsi2;
				 gotoxy(40,4+i); write(s2[i]:0:4);
				 s2j := s2j + s2[i];
				 gotoxy(40,5+round(js)); write(s2j:0:4);
		  end;
		  jj := 0;
		  for i := 1 to round(js) do
		  begin
					for j := 1 to round(js) do
					begin
							jj := jj + 1;
							dss[jj] := abs(rs[i]-rs[j]);
					end;
		  end;
		  Rx := sqr(sj)/usj;
		  for i := 1 to round(js) do
		  begin
				 ls2j := ls2j + sqr(s[i])/us[i];
		  end;
		  Ax := ls2j - Rx;
		  Dx := s2j - Rx - Ax;
		  fd := (Ax/(js-1))/(Dx/(usj-js));
		  gotoxy(5,round(js)+7);  write('=================================================================');
		  gotoxy(5,round(js)+8);  write('Sumber');
		  gotoxy(5,round(js)+9); write('variasi');
		  gotoxy(5,round(js)+10); write('=================================================================');
		  gotoxy(5,round(js)+12); write('Antar klp');
		  gotoxy(5,round(js)+13); write('Dalam klp');
		  gotoxy(5,round(js)+11); write('Rata-rata');
		  gotoxy(5,round(js)+14); write('=================================================================');
		  gotoxy(5,round(js)+15); write('Total');
		  gotoxy(20,round(js)+8); write('dk');
		  gotoxy(20,round(js)+12);write((js-1):1:0);
		  gotoxy(33,round(js)+8); write('JK');
		  gotoxy(30,round(js)+12);write(Ax:8:4);
		  gotoxy(48,round(js)+8); write('KT');
		  gotoxy(45,round(js)+12);write((Ax/(js-1)):8:4);
		  gotoxy(20,round(js)+13);write((usj-js):1:0);
		  gotoxy(30,round(js)+13);write(Dx:8:4);
		  gotoxy(45,round(js)+13);write((Dx/(usj-js)):8:4);
		  gotoxy(62,round(js)+8); write('F data');
		  gotoxy(60,round(js)+13);write(Fd:8:4);
		  gotoxy(20,round(js)+11);write('1');
		  gotoxy(30,round(js)+11);write(Rx:8:4);
		  gotoxy(45,round(js)+11);write((Rx/1):8:4);
		  gotoxy(20,round(js)+15); write(usj:1:0);
		  gotoxy(30,round(js)+15); write((Ax+Dx+Rx):8:4);
		  gotoxy(5,17+round(js)); write('Harga F                  = ');
		  gotoxy(13,17+round(js)); write(' 0,95 (',round(js)-1,';',round(usj-js),')');
		  gotoxy(32,17+round(js)); readln(ft);

		  textcolor(yellow);
		  if fd < ft then
		  begin
				 gotoxy(5,18+round(js)); write('Kesimpulan :');
				 textcolor(white);
				 gotoxy(5,19+round(js)); write('Karena F data < F tabel maka sampel memiliki rata-rata yang sama');
		  end else
		  begin
				 gotoxy(5,18+round(js)); write('Kesimpulan :');
				 textcolor(white);
				 gotoxy(5,19+round(js)); write('Karena F data >= F tabel maka sampel tidak memiliki rata-rata yang sama');
		  end;
		  if ps = '2' then intr(5,reg);
		  if (fd > ft) and ((sus = 0) or (sus = us1)) then
		  begin
				terus;
				tampilan('Least Significance Difference');
				gotoxy(5,3);
				cbesar;
				write('Harga t 0,975 (',round(js*(us1-1)),') = '); readln(ttab);
				gotoxy(5,3);
				write('Harga t 0,975 (',round(js*(US1-1)),') = ',ttab:8:4);
				Dx := Dx/(usj-js);
				sdl := sqrt(2*(Dx/us1));
				lsd := ttab*sdl;
				textcolor(yellow);
				gotoxy(5,4); write('No.':2,'Sampel':10,'Sampel':7,'Beda':10,'Keterangan':22);
				textcolor(white);
				for jjj := 1 to round(js*js) do
				begin
					b := jjj mod round(js);
					a := jjj div round(js);
					if b = 0 then a := a - 1;
					a := a + 1;
					if b = 0 then b := js;
					if (a <> b) and ( a < b ) then textcolor(lightgreen)
					else textcolor(white);
					if dss[jjj] >= lsd then sig := 'signifikan'
					else sig := 'tidak signifikan';
					gotoxy(5,4+jjj); write(jjj:2,'.',a:8:0,b:7:0,dss[jjj]:14:4,sig:20);
				end;
				gotoxy(41,3); write('Sd = ',sdl:0:4,'LSD = ':10,lsd:10:4);
		  end;
	end;

	procedure homvar2(ps : char);
   begin
        clrscr;
        tampilan('HOMOGENITAS VARIANS');
        cbesar;
        textcolor(white);
        gotoxy(5,4); write('Jumlah sampel = '); readln(js);
        gotoxy(45,4); write('US = Ukuran sampel');
        usj  := 0; dkj   := 0; sj   := 0; s2j := 0;
        ls2j := 0; dls2j := 0; ds2j := 0;
        textcolor(yellow);
        gotoxy(5,5); write('Sampel  US  dk   Si      Siý      logSiý    dklogSiý   dkSiý');
        textcolor(white);
        for i := 1 to round(js) do
        begin
				 gotoxy(5,5+i);  write(i:2);
             gotoxy(13,5+i); read(us[i]);
             usj := usj + us[i];
             dk[i] := us[i]-1;
             dkj := dkj + dk[i];
				 gotoxy(17,5+i); write(dk[i]:0:0);
             gotoxy(17,6+round(js)); write(dkj:0:0);
             gotoxy(21,5+i); read(s[i]);
             sj := sj + s[i];
             s2[i] := sqr(s[i]);
             s2j := s2j + s2[i];
             gotoxy(28,5+i); write(s2[i]:0:4);
             gotoxy(28,6+round(js)); write(s2j:0:4);
             ls2[i] := ln(s2[i])/ln(10);
             ls2j := ls2j + ls2[i];
             gotoxy(39,5+i); write(ls2[i]:0:4);
             gotoxy(39,6+round(js)); write(ls2j:0:4);
             dls2[i] := dk[i]*ls2[i];
             dls2j := dls2j + dls2[i];
             gotoxy(49,5+i); write(dls2[i]:0:4);
				 gotoxy(49,6+round(js)); write(dls2j:0:4);
             ds2[i] := dk[i]*s2[i];
             ds2j := ds2j + ds2[i];
             gotoxy(60,5+i); write(ds2[i]:0:4);
             gotoxy(60,6+round(js)); write(ds2j:0:4);
		  end;
        sgab := ds2j/dkj;
        gotoxy(5,8+round(js));  write('Varians gabungan sampel  = ',sgab:8:4);
        B := (ln(sgab)/ln(10))*dkj;
        gotoxy(5,9+round(js));  write('Harga B                  = ',B:8:4);
        cd := ln(10)*(B-dls2j);
        gotoxy(5,10+round(js)); write('Harga Chiý data          = ',cd:8:4);
        tabelchi(js,dks,chitab);
        ct := chitab;
        gotoxy(5,11+round(js)); write('Harga Chiý tabel         = ',ct:8:4);
        textcolor(yellow);
        if cd < ct then
        begin
             gotoxy(5,13+round(js)); write('Kesimpulan :');
             textcolor(white);
				 gotoxy(5,14+round(js)); write('Karena Chiý data < Chiý tabel maka');
             gotoxy(5,15+round(js)); write('Sampel memiliki variansi yang sama/homogen');
        end else
        begin
             gotoxy(5,13+round(js)); write('Kesimpulan :');
				 textcolor(white);
				 gotoxy(5,14+round(js)); write('Karena Chiý data >= Chiý tabel maka');
				 gotoxy(5,15+round(js)); write('Sampel tidak memiliki variansi yang sama/homogen');
		  end;
		  if ps = '2' then intr(5,reg);
	end;

	procedure bartlett2(ps : char);
   begin
        clrscr;
        tampilan('ANAVA 1 JALUR');
        cbesar;
        textcolor(white);
        gotoxy(5,4); write('Jumlah sampel = '); readln(js);
        gotoxy(50,4); write('US = Ukuran sampel');
		  usj  := 0; sj   := 0; s2j := 0;
        ls2j := 0; dls2j := 0; ds2j := 0;
        textcolor(yellow);
        gotoxy(5,5); write('Sampel      US       äX            äXý      ');
        textcolor(white);
		  for i := 1 to round(js) do
        begin
             gotoxy(5,5+i);  write(i:2);
             gotoxy(5,6+round(js));  write('ä':2);
             gotoxy(17,5+i); read(us[i]);
             usj := usj + us[i];
             gotoxy(17,6+round(js)); write(usj:0:0);
             gotoxy(26,5+i); read(s[i]);
             sj := sj + s[i];
             gotoxy(26,6+round(js)); write(sj:0:4);
             gotoxy(40,5+i); read(s2[i]);
             s2j := s2j + s2[i];
             gotoxy(40,6+round(js)); write(s2j:0:4);
        end;
        Rx := sqr(sj)/usj;
		  for i := 1 to round(js) do
        begin
             ls2j := ls2j + sqr(s[i])/us[i];
        end;
        Ax := ls2j - Rx;
		  Dx := s2j - Rx - Ax;
        fd := (Ax/(js-1))/(Dx/(usj-js));
        gotoxy(5,round(js)+8);  write('=================================================================');
        gotoxy(5,round(js)+9);  write('Sumber');
        gotoxy(5,round(js)+10); write('variasi');
        gotoxy(5,round(js)+11); write('=================================================================');
        gotoxy(5,round(js)+13); write('Antar klp');
        gotoxy(5,round(js)+14); write('Dalam klp');
        gotoxy(5,round(js)+12); write('Rata-rata');
        gotoxy(5,round(js)+15); write('=================================================================');
        gotoxy(5,round(js)+16); write('Total');
        gotoxy(20,round(js)+9); write('dk');
        gotoxy(20,round(js)+13);write((js-1):1:0);
        gotoxy(33,round(js)+9); write('JK');
        gotoxy(30,round(js)+13);write(Ax:8:4);
		  gotoxy(48,round(js)+9); write('KT');
        gotoxy(45,round(js)+13);write((Ax/(js-1)):8:4);
        gotoxy(20,round(js)+14);write((usj-js):1:0);
        gotoxy(30,round(js)+14);write(Dx:8:4);
        gotoxy(45,round(js)+14);write((Dx/(usj-js)):8:4);
		  gotoxy(62,round(js)+9); write('F data');
        gotoxy(60,round(js)+14);write(Fd:8:4);
        gotoxy(20,round(js)+12);write('1');
        gotoxy(30,round(js)+12);write(Rx:8:4);
        gotoxy(45,round(js)+12);write((Rx/1):8:4);
        gotoxy(20,round(js)+16); write(usj:1:0);
        gotoxy(30,round(js)+16); write((Ax+Dx+Rx):8:4);
        gotoxy(5,18+round(js)); write('Harga F                  = ');
		  gotoxy(13,18+round(js)); write(' 0,95 (',round(js)-1,';',round(usj-js),')');
		  gotoxy(32,18+round(js)); readln(ft);

		  textcolor(yellow);
		  if fd < ft then
		  begin
				 gotoxy(5,19+round(js)); write('Kesimpulan :');
				 textcolor(white);
				 gotoxy(5,20+round(js)); write('Karena F data < F tabel maka sampel memiliki rata-rata yang sama');
		  end else
		  begin
				 gotoxy(5,19+round(js)); write('Kesimpulan :');
				 textcolor(white);
				 gotoxy(5,20+round(js)); write('Karena F data >= F tabel maka sampel tidak memiliki rata-rata yang sama');
		  end;
		  if ps = '2' then intr(5,reg);
	end;

	procedure menu1;
	label 10,20,30;
	begin
		  10:
		  repeat
			  textbackground(black);
			  clrscr;
			  textbackground(brown);
			  textcolor(yellow);
			  gotoxy(25,2);   write('       ANAVA 1 JALUR           ');
			  textbackground(blue);
			  textcolor(white);
			  gotoxy(25,4);   write('                               ');
			  gotoxy(25,5);   write(' A. DESKRIPSI DATA             ');
			  gotoxy(25,6);   write(' B. UJI HOMOGENITAS VARIANS    ');
			  gotoxy(25,7);   write(' C. UJI BARTLETT/ANAVA 1 JALUR ');
			  gotoxy(25,8);   write(' X. [MENU UTAMA]               ');
			  gotoxy(25,9);   write('                               ');
			  textcolor(yellow);
			  gotoxy(25,5);   write(' A');
			  gotoxy(25,6);   write(' B');
			  gotoxy(25,7);   write(' C');
			  gotoxy(25,8);   write(' X');
			  textbackground(cyan);
			  textcolor(yellow);
			  gotoxy(25,11);  write('        Pilihanku :            ');
			  cmati;
			  repeat
					  i := random(552);
					  textbackground(black);
					  textcolor(i+blink);
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
			  until keypressed;
			  textbackground(black);
			  textcolor(yellow);
			  gotoxy(45,11);
			  opsi1 := readkey;
			  case upcase(opsi1) of
			  'A' : begin
								clrscr;
								menu(nkec);
								pmenu := readkey;
								case pmenu of
								'0': goto 10;
								'1': Enter(nkec);
								'2': Load(nkec);
								end;
								tampilan('Deskripsi data sampel');
								display_data(namaf,nkec);
								SESamp;
								gotoxy(1,5); write('Ukuran sampel           = ',nkec);
								gotoxy(1,6); write('Rata-rata sampel        = ',xbar:3:4);
								gotoxy(1,7); write('Standar error sampel    = ',sbs:3:4);
								gotoxy(1,8); write('Variansi sampel         = ',sqr(sbs):3:4);
								gotoxy(1,9); write('Data minimal            = ',min:3:4);
								gotoxy(1,10);write('Data maksimal           = ',mak:3:4);
								gotoxy(1,11);write('Jumlah X                = ',jx:3:4);
								gotoxy(1,12);write('Jumlah Xý               = ',jx2:3:4);
								ulang;
								if upcase(opsi2) = 'T' then exit
								else goto 10;
					  end;

			  'B' : begin
								clrscr;
								menu2;
								pmenu := readkey;
								if pmenu = '0'then goto 10;
								clrscr;
								printing;
								if ps = '0' then goto 10;
								case pmenu of
								'1': homvar(ps);
								'2': homvar2(ps);
								end;
								ulang;
								if upcase(opsi2) = 'T' then exit
								else goto 10;
					  end;
			  'C' : begin
								clrscr;
								menu2;
								pmenu := readkey;
								if pmenu = '0'then goto 10;
								clrscr;
								printing;
								if ps = '0' then goto 10;
								case pmenu of
								'1': bartlett(ps);
								'2': bartlett2(ps);
								end;
								ulang;
								if upcase(opsi2) = 'T' then exit
								else goto 10;
					  end;
			  'X' : begin halt; end;
			  end;
	  until upcase(opsi1) in ['A','B','C','X'];
	end;

Begin
	  Hapus_layar;
	  menu1;
          Hapus_layar;
end.

{$M 4000,0,0}
Program Kruskal_Wallis_test;
Uses CRT,stat_m,dos;
type
	 Dr = array[1..100] of real;
var
	reg : registers;
	p,q,r,sd,v,w,x,dss,rs,us,dk,s,s2,ls2,dls2,ds2,dsi : dr;
	sigmaxixbar,jx,jx2,xbar,sbs,min,mak,js,jdk,js2,
	jls2,jdls2,jds2,sgab,a,b,cd,ct : real;
	se,sf,sg,sh,si,sk,sl,sm,sdl,lsd,ttab,sus,us1,dks,usj,dkj,
	sj,s2j,ls2j,dls2j,ds2j,jdsi,jdsi2 : real;
	d1,d2,d3,d4,d5,d6,i,ii,j,jj,jjj : byte;
	ng,ndp,nkec,iii : integer;
	Rx,Rx1,Rx2,Rx3,Ax,Dx,fd,ft,chitab : real;
	pmenu,ps,lagi,dopsi,opsi,opsi1,opsi2,opsi3 : char;
	nama,namaf : string[10];
	sig : string[20];

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
	  textbackground(brown);
	  textcolor(white);
	  gotoxy(27,2); write('    UJI RANK KRUSKAL WALLIS  ');
	  textbackground(blue);
	  textcolor(white);
	  gotoxy(27,4); write('                             ');
	  gotoxy(27,5); write(' 0. [MENU]                   ');
	  gotoxy(27,6); write(' 1. Display di monitor       ');
	  gotoxy(27,7); write(' 2. Cetak di printer         ');
	  gotoxy(27,8); write('                             ');
	  textcolor(yellow);
	  gotoxy(27,5); write(' 0');
	  gotoxy(27,6); write(' 1');
	  gotoxy(27,7); write(' 2');
	  textbackground(brown);
	  textcolor(yellow);
	  gotoxy(27,10); write('    Pilihanku :              ');
          gotoxy(43,10);
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
			  textbackground(brown);
			  textcolor(i+6);
			  gotoxy(45,10); write('-');
			  delay(300);
			  inc(i,1);
	  until keypressed;
          textbackground(black);
	  ps := readkey;
	  if ps = '1' then begin end;
end;

Procedure ulang;
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
	textbackground(black);
end;

Procedure terus;
const tulis2 = '';
	 tulis1 = 'Tekan <Esc>...';
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
	repeat until readkey = #27;
	textbackground(black);
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
	  28   :  chitab := 41.3;  29   :  chitab := 42.6;  30..39   :  chitab := 43.8;
	  40..49   :  chitab := 55.8;  50..59   :  chitab := 67.5;  60..69   :  chitab := 79.1;
	  70..79   :  chitab := 90.5;  80..89   :  chitab := 101.9; 90..99   :  chitab := 118.1;
	  end;
	end;

	 procedure sort2(ndp : integer; var ra,rb : dr);
	 label 99;
	 var l,j,ir,i : integer; rrb,rra : real;
	 begin
		l := (ndp div 2)+1;
		ir := ndp;
		while true do
		begin
			if (l > 1) then
			begin
				l := l - 1; rra := ra[l]; rrb := rb[l];
			end else
			begin
				rra := ra[ir]; rrb := rb[ir]; ra[ir] := ra[1]; rb[ir] := rb[1];
				ir := ir-1;
				if (ir = 1) then
				begin
					ra[1] := rra; rb[1] := rrb;
					goto 99;
				end;
			end;
			i := l; j := l + l;
			while (j <= ir) do
			begin
				if (j < ir) then
					if (ra[j] < ra[j+1]) then
						j := j + 1;
				if (rra < ra[j]) then
				begin
					ra[i] := ra[j]; rb[i] := rb[j]; i := j; j := j + j;
				end else j := ir + 1;
			end;
			ra[i] := rra; rb[i] := rrb;
		end;
99: end;

	 procedure sort(ndp : integer; var ra : dr);
	 label 99;
	 var l,j,ir,i : integer; rra : real;
	 begin
		l := (ndp div 2)+1;
		ir := ndp;
		while true do
		begin
			if (l > 1) then
			begin
				l := l - 1; rra := ra[l];
			end else
			begin
				rra := ra[ir]; ra[ir] := ra[1]; ir := ir-1;
				if (ir = 1) then
				begin
					ra[1] := rra;
					goto 99;
				end;
			end;
			i := l; j := l + l;
			while (j <= ir) do
			begin
				if (j < ir) then
					if (ra[j] < ra[j+1]) then
						j := j + 1;
				if (rra < ra[j]) then
				begin
					ra[i] := ra[j]; i := j; j := j + j;
				end else j := ir + 1;
			end;
			ra[i] := rra;
		end;
99: end;


	 procedure crank(ndp: integer; var w :dr; var s : real);
	 label 2;
	 var j,ji,jt,ibl1,ibl2 : integer; t,rank : real;
	 begin
		s := 0; j := 1;
		while (j < ndp) do
		begin
			if (w[j+1] <> w[j]) then
			begin
				w[j] := j; j := j + 1;
			end else
			begin
				for jt := j+1 to ndp do
				begin
					if (w[jt] <> w[j]) then goto 2;
				end;
				jt := ndp+1;
		2:		rank := 0.5*(j+jt-1);
				for ji := j to jt-1 do w[ji] := rank;
				t := jt-j; s := s+t*t*t-t; j := jt
			end;
		end;
		if (j = ndp) then w[ndp] := ndp;
	 end;


	procedure Kruskal_Wallis(ps : char);
	begin
		  clrscr;
		  tampilan('ANOVA Rank Kruskal Wallis');
		  cbesar;
		  textbackground(black);
		  textcolor(white);
		  repeat
		        gotoxy(5,3); write('Jumlah sampel = '); readln(js);
		  until js < 6;

		  gotoxy(50,3); write('US = Ukuran sampel');
		  textcolor(yellow);
		  gotoxy(5,4); write('Sampel  US  Jumlah rank   Jml rank kuadrat   Rata-rata jml rank kuadrat');
		  textcolor(white);
		  usj  := 0;
		  for i := 1 to round(js) do
		  begin
		       gotoxy(5,4+i);  write(i:2,'.');
		       gotoxy(13,4+i); read(us[i]);
		       usj := usj + us[i];
		       gotoxy(13,5+round(js)); write(usj:0:0);
		  end;
		  d1 := round(us[1]);
		  d2 := round(us[2]);
		  d3 := round(us[3]);
		  d4 := round(us[4]);
		  d5 := round(us[5]);
		  d6 := round(us[6]);

		  for j := 1 to round(usj) do
		  begin
				 gotoxy(5,5+round(js));  write('Jumlah':2);
				 textcolor(yellow);
				 gotoxy(5,22); write('Masukkan data sampel no. ',j);
				 textcolor(white);
				 if (j <= 15) {or ((j > 30) and (j <= 45)) }then
				 begin
						gotoxy(5*j,23); read(dsi[j]);
				 end;
				 if ((j > 15) and (j <=30)) {or ((j > 45) and (j <=60))} then
				 begin
						gotoxy((5*j)-75,24); read(dsi[j]);
				 end;
		  end;

		  for i := 1 to round(usj) do
		  begin
				dss[i] := dsi[i];
				sd[i]  := dsi[i];
				w[i]   := dsi[i];
		  end;

		  gotoxy(1,22); clreol;
		  gotoxy(1,23); clreol;
		  gotoxy(1,24); clreol;

		  sort2(round(usj),dsi,dss);
		  p := dsi;
		  crank(round(usj),dsi,sf);
		  q := dsi;
		  sort2(round(usj),sd,dsi);

                  terus;
                  clrscr;
		  tampilan('ANOVA Rank Kruskal Wallis');
		  writeln('Asli':14,'Urut':12,'Rank':10,'Asli':15,'Rank':10);
		  for i := 1 to round(usj) do
		  begin
		       writeln(i:2,'. ',w[i]:10:4,p[i]:12:4,q[i]:10:4,w[i]:15:4,dsi[i]:10:4);
		  end;
		  sf := 0;
		  for i := 1 to round(usj) do
		  begin
				r[i] := dsi[i];
				sf := sf + dsi[i];
		  end;

		  sg := 0;
		  for i := 1 to round(d1) do
		  begin
				sg := sg + r[i];
		  end;
		  s[1] := sg;

		  sh := 0;
		  for i := round(d1+1) to round(d1+d2) do
		  begin
				sh := sh + r[i];
		  end;
		  s[2] := sh;

		  si := 0;
		  for i := round(d1+d2+1) to round(d1+d2+d3) do
		  begin
				si := si + r[i];
		  end;
		  s[3] := si;

		  sk := 0;
		  for i := round(d1+d2+d3+1) to round(d1+d2+d3+d4) do
		  begin
				sk := sk + r[i];
		  end;
		  s[4] := sk;

		  sl := 0;
		  for i := round(d1+d2+d3+d4+1) to round(d1+d2+d3+d4+d5) do
		  begin
				sl := sl + r[i];
		  end;
		  s[5] := sl;

		  textcolor(white);
		  sj   := 0; s2j := 0;
		  for i := 1 to round(js) do
		  begin
				gotoxy(19,4+i); write(s[i]:0:4);
				sj := sj + s[i];
				gotoxy(19,5+round(js)); write(sj:0:4);
				gotoxy(19,6+round(js)); write(sf:0:4);

				rs[i] := sqr(s[i]);
				gotoxy(35,4+i);         write(rs[i]:0:4);

				s2[i] := rs[i]/us[i];
				gotoxy(55,4+i); write(s2[i]:0:4);

				s2j := s2j + s2[i];
				gotoxy(55,5+round(js)); write(s2j:0:4);
		  end;

		  Rx1 := 12/(usj*(usj+1));
		  Rx2 := 3*(usj+1);
		  Rx  := (Rx1*s2j)-Rx2;
		  tabelchi(js,dks,chitab);
		  gotoxy(5,10+round(js)); write('Harga H data    = ',Rx:8:4);
		  gotoxy(5,11+round(js)); write('Harga dk        = ',dks:8:0);
		  gotoxy(5,12+round(js)); write('Harga Chi Tabel = ',chitab:8:4);
		  textcolor(yellow);
		  if Rx < chitab then
		  begin
				 gotoxy(5,14+round(js)); write('Kesimpulan :');
				 textcolor(white);
				 gotoxy(5,15+round(js)); write('Karena H data < Chi tabel maka sampel identik');
		  end else
		  begin
				 gotoxy(5,14+round(js)); write('Kesimpulan :');
				 textcolor(white);
				 gotoxy(5,15+round(js)); write('Karena H data > Chi tabel maka sampel tidak identik');
		  end;
		  if ps = '2' then intr(5,reg);

	end;

	procedure menu1;
	begin
		  repeat
			  textbackground(black);
			  clrscr;
			  printing;
			  if ps = '0' then exit;
			  kruskal_wallis(ps);
			  ulang;
		until readkey = #27;
	end;

Begin
	  clrscr;
	  menu1;
end.

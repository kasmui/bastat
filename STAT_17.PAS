Program Wilcoxon_rank_sum_test;
uses crt,dos,stat_m;
type datar  = array[1..200] of real;
var opsi1,opsi2,opsi3,metu,ps:char;
	 j,jj,cnt,ndp,ndp1,ndp2,ndp3,ndp4,min,plus,hdata : integer;
	 s,zw,ztab,sf,sg,sh : real;
	 p,q,r,w,sr,x,y,z,b,bb,a,aa,yreg:datar;
	 wksp1,wksp2 : datar;
    reg : registers;

procedure printing;
begin
     clrscr;
     textbackground(blue);
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
	  writeln('============================================================================');
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
		  frx     : freal;

    begin
	    clrscr;
		 Cbesar;
		 tampilan('Nonparametrik : Uji jumlah rank Wilcoxon');
		 gotoxy(15,3); write('NAMA FILE : '); readln(nama);
		 writeln;
		 assign(fk,nama);
		 assign(fi,nama+'.dat');
		 assign(frx,nama+'xi.dat');
		 rewrite(fk);
		 rewrite(fi);
		 rewrite(frx);
		 write(fk,nama);
			gotoxy(15,4); write('                                 ');
			gotoxy(15,4); write('Ukuran sampel kelompok 1 = '); readln(ndp1);
			gotoxy(15,5); write('                                 ');
			gotoxy(15,5); write('Ukuran sampel kelompok 2 = '); readln(ndp2);
		 ndp := ndp1 + ndp2;
		 write(fi,ndp);
		 writeln;
		 for cnt := 1 to ndp do
		 begin
			 if cnt <= ndp1 then
			 begin
				textcolor(white);
				write('Sampel 1 (':16,cnt,') = ');
				readln(x[cnt]);
				write(frx,x[cnt]);
			 end;
			 if cnt > ndp1 then
			 begin
				textcolor(yellow);
				write('Sampel 2 (':16,cnt-ndp1,') = ');
				readln(x[cnt]);
				write(frx,x[cnt]);
			 end;
		 end;
		 close(fk);
		 close(fi);
		 close(frx);
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
		  frx     : freal;
		  ada     : boolean;
		  metu    : char;
	 label 01;

	 begin
			01:
			clrscr;
			cbesar;
			tampilan('Nonparametrik : Uji jumlah rank Wilcoxon');
			textbackground(black);
			textcolor(yellow);
			gotoxy(25,3); write('NAMA FILE : '); readln(nama);
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
	gotoxy(79-length(tulis1),25); write(tulis1);
	gotoxy(2,25); write(tulis2);
	opsi2 := readkey;
end;

Procedure tunggu;
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
	readln;
end;

	 procedure menu;
	 begin
		clrscr;
		textbackground(brown);
		textcolor(white);
		gotoxy(27,3); write('    UJI JUMLAH RANK WILCOXON ');
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

	 procedure sort2(ndp : integer; var ra,rb : datar);
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

	 procedure sort(ndp : integer; var ra : datar);
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

	 procedure crank(ndp: integer; var w :datar; var s : real);
	 label 2;
	 var j,ji,jt,ibl1,ibl2 : integer; t,rank : real;
	 begin
		j := 1; s := 0;
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
		if (j= ndp) then w[ndp] := ndp;
	 end;

	 procedure wilcox;
	 begin
			tampilan('Nonparametrik : Uji jumlah rank Wilcoxon');
			write('Ukuran sampel kelompok 1 = '); readln(ndp1);
			write('Ukuran sampel kelompok 2 = '); readln(ndp2);
			ndp := ndp1 + ndp2;
			for cnt := 1 to ndp do
			begin
				y[cnt] := x[cnt];
				z[cnt] := x[cnt];
				w[cnt] := x[cnt];
			end;

			sort2(ndp,x,y);
			p := x;
			crank(ndp,x,sf);
			q := x;
			sort2(ndp,z,x);

			tampilan('Nonparametrik : Uji jumlah rank Wilcoxon');
			writeln('Asli':14,'Urut':12,'Rank':10,'Asli':15,'Rank':10);
			sf := 0;
			for cnt := 1 to ndp do
			begin
				r[cnt] := x[cnt];
				sf := sf + x[cnt];
				if cnt <= ndp1 then textcolor(white) else textcolor(yellow);
				writeln(cnt:2,'. ',w[cnt]:10:4,p[cnt]:12:4,q[cnt]:10:4,
						  w[cnt]:15:4,x[cnt]:10:4);
			end;
			sg := 0;
			for cnt := 1 to ndp1 do
			begin
				sg := sg + r[cnt];
			end;
			sh := sf-sg;

			tunggu;
			textbackground(black);
			cbesar;
			zw := (sg-((ndp1*(ndp+1))/2))/(sqrt((ndp1*ndp2*(ndp+1))/12));
			tampilan('Nonparametrik : Uji jumlah rank Wilcoxon');
			gotoxy(5,5);  write('Ukuran sampel kelompok 1 = ',ndp1:10);
			gotoxy(5,6);  write('Ukuran sampel kelompok 2 = ',ndp2:10);
			gotoxy(5,7);  write('Jumlah rank kelompok 1   = ',sg:10:4);
			gotoxy(5,8);  write('Jumlah rank kelompok 2   = ',sh:10:4);
			gotoxy(5,9);  write('Jumlah rank total        = ',sf:10:4);
			gotoxy(5,10); write('Harga Z data             = ',zw:10:4);
			ztab := 1.96;
			gotoxy(5,11); write('Harga Z (0,475)          = ',ztab:10:4);
			gotoxy(5,13); write('Harga Kesimpulan :');
			if (zw > ztab) or (zw < -ztab)then
			begin
				gotoxy(5,14); write('Hipotesis nol ditolak maka ');
				gotoxy(5,15); write('Terdapat perbedaan signifikan pada alpha 0,05');
			end else
			begin
				gotoxy(5,14); write('Hipotesis nol diterima maka ');
				gotoxy(5,15); write('Tidak terdapat perbedaan signifikan pada alpha 0,05');
			end
	 end;


Begin
	  clrscr;
	  repeat
			  clrscr;
			  warna(0,0,80,25,black);
			  menu;
			  clrscr;
			  printing;
			  tampilan('Nonparametrik : Uji jumlah rank Wilcoxon');
			  wilcox;
			  if ps = '2' then intr(5,reg);
			  tekan_esc;
	  until opsi2 = #27;
end.

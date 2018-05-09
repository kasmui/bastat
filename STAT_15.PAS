Program wilcoxon;
uses crt,dos,stat_m;
type datar  = array[1..100] of real;
var opsi1,opsi2,opsi3,metu,ps:char;
	 j,jj,cnt,ndp,ndp1,ndp2,ndp3,ndp4,min,plus,hdata : integer;
	 rbatas,aveb,avea,meda : real;
	 x,y,b,bb,a,aa,yreg:datar;
	 wksp,wksp1,wksp2 : datar;
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
		 tampilan('Nonparametrik : Uji tanda rank Wilcoxon');
		 gotoxy(15,3); write('NAMA FILE : '); readln(nama);
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
		 repeat
			gotoxy(15,4); write('                                 ');
			gotoxy(15,4); write('Ukuran sampel         = '); readln(ndp);
		 until (ndp > 5) and( ndp < 26);
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
			tampilan('Nonparametrik : Uji tanda rank Wilcoxon');
			textbackground(black);
			textcolor(yellow);
			gotoxy(25,3); write('NAMA FILE : '); readln(nama);
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

Procedure tuptext;
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


	 procedure menu;
	 begin
		clrscr;
		textbackground(brown);
		textcolor(white);
		gotoxy(27,3); write('    UJI TANDA RANK WILCOXON  ');
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

	 procedure r_batas;
	 begin
	 if ndp <= 25 then
	 begin
		case ndp of
		6 : rbatas := 0;
		7 : rbatas := 2;
		8 : rbatas := 4;
		9 : rbatas := 6;
	  10 : rbatas := 8;
	  11 : rbatas := 11;
	  12 : rbatas := 14;
	  13 : rbatas := 17;
	  14 : rbatas := 21;
	  15 : rbatas := 25;
	  16 : rbatas := 30;
	  17 : rbatas := 35;
	  18 : rbatas := 40;
	  19 : rbatas := 46;
	  20 : rbatas := 52;
	  21 : rbatas := 59;
	  22 : rbatas := 66;
	  23 : rbatas := 73;
	  24 : rbatas := 81;
	  25 : rbatas := 89;
	  end;
	 end else
	 begin
		{rbatas := -99+7.51*ndp}
		rbatas := -1.708-(0.4892*ndp)+(0.1346*sqr(ndp))+(0.0012*sqr(ndp)*ndp);
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

	 procedure crank(ndp: integer; var w :datar; var s : real);
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
		if (j= ndp) then w[ndp] := ndp;
	 end;

	 procedure wilc(x,y : datar; ndp : integer);
	 var j : integer; d1,d2,jd,vard,t,sg,sf,fac,en3en,en,df,aved : real;

	 begin
		for j := 1 to ndp do
		begin
			wksp1[j] := x[j]-y[j];
			if wksp1[j] < 0 then wksp[j] := -1
			else wksp[j] := +1;
			wksp2[j] := abs(wksp1[j]);
		end;
		sort2(ndp,wksp2,wksp);
		crank(ndp,wksp2,sf);
		for j := 1 to ndp do
		begin
			wksp2[j] := wksp2[j]*wksp[j]
		end;
		d1 := 0;
		d2 := 0;
		for j := 1 to ndp do
		begin
			if wksp2[j] > 0 then d1:= d1+ wksp2[j]
			else d2:= d2+ wksp2[j];
		end;
		if abs(d1) < abs(d2) then jd := abs(d1)
		else jd := abs(d2);
		r_batas;
		gotoxy(5,5);  write('Ukuran sampel      = ',ndp:8);
		gotoxy(5,7);  write('Harga J data       = ',jd:8:4);
		if ndp <=25 then
		begin
			gotoxy(5,8);  write('Harga J batas      = ',rbatas:8:4);
		end else
		begin
			gotoxy(5,8);  write('Harga J batas      > ',rbatas:8:4);
		end;

		gotoxy(5,10); write('Harga Kesimpulan :');
		if (jd >= rbatas) then
		begin
			gotoxy(5,11); write('Karena J data > J batas maka ');
			gotoxy(5,12); write('Terdapat perbedaan signifikan pada alpha 0,05');
		end else
		begin
			gotoxy(5,11); write('Karena J data < J batas maka ');
			gotoxy(5,12); write('Tidak terdapat perbedaan signifikan pada alpha 0,05');
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
			  tampilan('Nonparametrik : Uji tanda rank Wilcoxon');
			  wilc(x,y,ndp);
			  if ps = '2' then intr(5,reg);
			  tuptext;
	  until opsi2 = #27;
end.

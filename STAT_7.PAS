{$N+}
Program Statistika;
uses crt,printer,dos,graph,stat_m;
type vector  = array[1..100] of real;
	matrika = array[1..100,1..100] of real;
	datak   = array[1..100] of byte;
	datar   = array[1..100] of real;
	screentype   = (mono,color);
var ry1,ry2,r12,ry12,ry21,ry,a0,a1,a2,tdata1,tdata2,
    sx12,sx22,sy2,sx1x2,sx1y,sx2y,jkr,jks,pred,sa1,sa2,sy122,tdata : real;
var x,y,w,ytopi,yaksen,residu,sqresidu                  : vector;
    sl,ic,a,b,ss,dsl,dic,dev,ftab,ttab                  : real;
    cnt,ndp,i,pilih                                     : integer;
    sum1,sum2,sum3,sum4,sum5,sum6,sum7,sum8,sum9,sum10,
    JKtot,JKa,RJKa,sum11,sum12,sum13,sum14,sum15,sum16,
    sum17,sum18,sum19,sum20,sum21,x5,x6,x2y,x3y,sstotal,
    ssresidu,ssregresi,MSregresi,Msresidu,fdata,fdata1,fdata2,
    JKresidu,rsquared,r,sgsqb,sigmab,sgsqa,sigmaa,dif1,
    dif2,den,meanx,meany,meanw,
    s2ep,s2t,fdlin,jker,jktc,jkba,msba                  : real;
    nu1,nu2,jd,j,jj,kj                                     : byte;
    k                                                   : datak;
    sumy,sum2y,sumy2,jk                                 : datar;
    ps,lagi,answer,opsi,opsiu,opsi2,opsi3,opsi4,opsi5      : char;
    stype                                               : screentype;
    flag                                                : boolean;
    reg : registers;
Label 10,20,30,40,50,60;

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

    procedure tampilan(st:string);
    begin
     clrscr;
     textbackground(brown);
     textcolor(white);
     for i := 1 to 76 do write(' ');
     gotoxy(1,1);
     write(st);
     gotoxy(45,1); write('<<<<< Basic Statistics 1.1 >>>>>');
     textbackground(black);
     textcolor(white);
     gotoxy(1,2);
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
	   frx,fry,
	   frw     : freal;

    begin
		 clrscr;
		 tampilan('Input data');
	    Cbesar;
            textbackground(black);
            textcolor(white);
		 gotoxy(14,3); write('NAMA FILE : '); readln(nama);
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
				repeat
						gotoxy(1,5); clreol;
						gotoxy(45,5); write('(minimal 5 data)');
				 gotoxy(14,5); write('Berapa buah data     = '); readln(ndp);
				until ndp > 4;
		 write(fi,ndp);
		 writeln;
		 for cnt := 1 to ndp do
		 begin
			 write('X1(':16,cnt,') = '); readln(x[cnt]); write(frx,x[cnt]);
			 write('X2(':16,cnt,') = '); readln(y[cnt]); write(fry,y[cnt]);
			 write('Y (':16,cnt,') = '); readln(w[cnt]); write(frw,w[cnt]);
			 writeln;
		 end;
		 close(fk);
		 close(fi);
		 close(frx);
		 close(fry);
		 close(frw);
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
		  frx,fry,frw     : freal;
		  ada     : boolean;
		  metu	: char;
	 label 01;

	 begin
			01:
			clrscr;
			tampilan('Ambil data');
			cbesar;
			textbackground(black);
			textcolor(white);
			gotoxy(25,3); write('NAMA FILE : '); readln(nama);
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
				  textcolor(red);
				  write(#7);
				  gotoxy(5,22); write('FILE TIDAK ADA ! ');
				  gotoxy(5,23); write('Tekan <Esc> Keluar atau <Enter> Ulang');
				  metu := readkey;
				  if metu = #27 then halt else goto 01;
			end;
			close(fk);
			close(fi);
			close(frx);
			close(fry);
			close(frw);
	 end;

Procedure tuptext2;
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
	opsi2 := readkey;
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


    procedure calc;
    begin
	    sum1  := 0;  sum2  := 0;  sum3  := 0;  sum4 := 0;  sum5  := 0;
	    sum6  := 0;  sum7  := 0;  sum8  := 0;  sum9 := 0;  sum10 := 0;
	    sum11 := 0;  sum12 := 0; sum13  := 0; sum14 := 0;  sum15 := 0;
	    sum16 := 0;  sum17 := 0;  sum18 := 0; sum19 := 0;  sum20 := 0;
	    sum21 := 0;  x2y   := 0;  x3y   := 0; x5    := 0;  x6    := 0;
	    for cnt := 1 to ndp do
	    begin
		    sum1  := sum1  + w[cnt]; {sigma y}
		    sum2  := sum2  + x[cnt]; {sigma x1}
		    sum3  := sum3  + y[cnt]; {sigma x2}
		    sum4  := sum4  + sqr(x[cnt]); {sigma x1ý}
		    sum5  := sum5  + x[cnt]*y[cnt]; {sigma x1x2}
		    sum6  := sum6  + sqr(y[cnt]); {sigma x2ý}
		    sum7  := sum7  + sqr(y[cnt])*y[cnt]; {sigma x2^3}
		    sum8  := sum8  + sqr(x[cnt])*x[cnt]; {sigma x1^3}
		    sum9  := sum9  + sqr(y[cnt])*sqr(y[cnt]); {sigma x2^4}
		    sum10 := sum10 + sqr(x[cnt])*sqr(x[cnt]); {sigma x1^4}
		    sum11 := sum11 + sqr(w[cnt]); {sigma yý}
		    sum12 := sum12 + (y[cnt])*w[cnt]; {sigma x2y}
		    sum13 := sum13 + (x[cnt])*w[cnt]; {sigma x1y}
		    x5    := x5    + sqr(x[cnt])*sqr(x[cnt])*x[cnt]; {sigma x^5}
		    x6    := x6    + sqr(x[cnt])*sqr(x[cnt])*sqr(x[cnt]);
		    x2y   := x2y   + sqr(x[cnt])*y[cnt]; {sigma x1ýx2}
	    end;
	    meanx := sum2/ndp;
	    meany := sum3/ndp;
	    meanw := sum1/ndp;
	    for cnt := 1 to ndp do
	    begin
		    sum17 := sum17 + (x[cnt]-meanx); {sigma x1-xbar}
		    sum18 := sum18 + sqr((x[cnt]-meanx)); {sigma sqrx1-xbar}
		    sum19 := sum19 + (y[cnt]-meany); {sigma x2-ybar}
		    sum20 := sum20 + sqr((y[cnt]-meany)); {sigma sqrx2-ybar}
	    end;
    end; {calc}

    procedure sum;
    begin
	    clrscr;
	    tampilan('Ringkasan hitungan data ');
	    gotoxy(20,3);writeln('ä Y            = ',sum1:10:8);
	    gotoxy(20,4);writeln('ä X1           = ',sum2:10:8);
	    gotoxy(20,5);writeln('ä X2           = ',sum3:10:8);
	    gotoxy(20,6);writeln('Mean X1        = ',meanx:10:8);
	    gotoxy(20,7);writeln('Mean X2        = ',meany:10:8);
	    gotoxy(20,8);writeln('Mean Y         = ',meanw:10:8);
	    gotoxy(20,9);writeln('ä X1ý          = ',sum4:10:8);
	    gotoxy(20,10);writeln('ä X2ý          = ',sum6:10:8);
	    gotoxy(20,11);writeln('ä X1X2         = ',sum5:10:8);
	    gotoxy(20,12);writeln('ä X1ýX2        = ',x2y:10:8);
	    gotoxy(20,13);writeln('ä X1^3         = ',sum8:10:8);
	    gotoxy(20,14);writeln('ä X2^3         = ',sum7:10:8);
	    gotoxy(20,15);writeln('ä X1^4         = ',sum10:10:8);
	    gotoxy(20,16);writeln('ä X1^5         = ',x5:10:8);
	    gotoxy(20,17);writeln('ä X1^6         = ',x6:10:8);
	    gotoxy(20,18);writeln('ä X2^4         = ',sum9:10:8);
	    gotoxy(20,19); writeln('ä (X1-Xbar)ý   = ',sum18:10:8);
	    gotoxy(20,20);writeln('ä (X2-Ybar)ý   = ',sum20:10:8);
	    tuptext;
    end;

    procedure korelasi_ganda;
    begin
		ry1 := (ndp*sum13-(sum2*sum1))/
			  (sqrt((ndp*sum4-sqr(sum2))*(ndp*sum11-sqr(sum1))));
		ry2 := (ndp*sum12-(sum3*sum1))/
			  (sqrt((ndp*sum6-sqr(sum3))*(ndp*sum11-sqr(sum1))));
		r12 := (ndp*sum5-(sum2*sum3))/
			  (sqrt((ndp*sum4-sqr(sum2))*(ndp*sum6-sqr(sum3))));
		ry12 := (ry1-(ry2*r12))/(sqrt((1-sqr(ry2))*(1-sqr(r12))));
		ry21 := (ry2-(ry1*r12))/(sqrt((1-sqr(ry1))*(1-sqr(r12))));
		ry := sqrt(((sqr(ry1)+sqr(ry2))-(2*ry1*ry2*r12))/(1-sqr(r12)));
		fdata1 := ry12/((1-sqr(ry12))/(ndp-2));
		fdata2 := ry21/((1-sqr(ry21))/(ndp-2));
		fdata := (sqr(ry)/2)/((1-sqr(ry))/(ndp-2-1));
    end;

    procedure regresi_ganda;
    begin
		korelasi_ganda;
		sx12 := sum4-(sqr(sum2)/ndp);
		sx22 := sum6-(sqr(sum3)/ndp);
		sy2  := sum11-(sqr(sum1)/ndp);
		sx1x2 := sum5-((sum3*sum2)/ndp);
		sx1y := sum13-((sum1*sum2)/ndp);
		sx2y := sum12-((sum1*sum3)/ndp);
		a1 := (sx22*sx1y-(sx1x2*sx2y))/((sx12*sx22)-(sqr(sx1x2)));
		a2 := (sx12*sx2y-(sx1x2*sx1y))/((sx12*sx22)-(sqr(sx1x2)));
		a0 := meanw-a1*meanx-a2*meany;
		jkr := a1*sx1y+a2*sx2y;
		jks := sy2-jkr;
		fdata := (jkr/2)/((jks/(ndp-2-1)));
		sy122 := jks/(ndp-2-1);
		sa1 := sqrt(sy122/(sx12*(1-sqr(ry))));
		sa2 := sqrt(sy122/(sx22*(1-sqr(ry))));
		tdata1 := a1/sa1;
		tdata2 := a2/sa2;
    end;

    procedure display_kg;
    begin
		korelasi_ganda;
		clrscr;
                printing;
                clrscr;
		tampilan('Korelasi ganda');
		textbackground(black);
		gotoxy(2,4);
		write('Penentuan koefisien korelasi parsial :');
		gotoxy(2,5);
		write('Koef korelasi Y dan X1 jika X2 konstan = ',ry12:8:4);
		gotoxy(2,6);
		write('Koef korelasi Y dan X2 jika X1 konstan = ',ry21:8:4);
		gotoxy(2,7);
		write('Koef korelasi Y dan X1                 = ',ry1:8:4);
		gotoxy(2,8);
		write('Koef korelasi Y dan X2                 = ',ry2:8:4);
		gotoxy(2,9);
		write('Koef korelasi X1 dan X2                = ',r12:8:4);
		gotoxy(2,11);
		write('Uji keberartian koefisien korelasi parsial :');
		gotoxy(2,12);
		write('F data 1 untuk menguji korelasi Y dan X1 (X2 konstan) = ',fdata1:8:4);
		gotoxy(2,13);
		write('F data 2 untuk menguji korelasi Y dan X2 (X1 konstan) = ',fdata2:8:4);
		gotoxy(2,14);
		write('F tabel = F 0,95 (1;',ndp-2,') = '); readln(Ftab);
		gotoxy(2,16);
                textcolor(yellow);
		write('Kesimpulan :');
                textcolor(white);

		if fdata1 >= ftab then
		begin
			gotoxy(2,17);
			write('Karena F data 1 > F tabel maka koef korelasi Y dan X1 berarti');
		end else
		begin
			gotoxy(2,17);
			write('Karena F data 1 < F tabel maka koef korelasi Y dan X1 tidak berarti');
		end;
		if fdata2 >= ftab then
		begin
			gotoxy(2,18);
			write('Karena F data 2 > F tabel maka koef korelasi Y dan X2 berarti');
		end else
		begin
			gotoxy(2,18);
			write('Karena F data 2 < F tabel maka koef korelasi Y dan X2 tidak berarti');
		end;
		gotoxy(2,20);
		write('Koefisien korelasi ganda = ',ry:8:4);
		gotoxy(2,21);
		write('Uji keberartian koefisien korelasi ganda :');
		gotoxy(2,22);
		write('F data  = ',fdata:8:4);
		gotoxy(2,23);
		write('F tabel = F 0,95(2;',ndp-3,') = '); readln(Ftab);
		if fdata >= ftab then
		begin
			gotoxy(2,24);
			write('Karena F data > F tabel maka koef korelasi ganda berarti');
		end else
		begin
			gotoxy(2,24);
			write('Karena F data < F tabel maka koef korelasi ganda tidak berarti');
		end;
                if ps = '2' then intr(5,reg);
		tuptext;
    end;

    procedure display_rg;
    begin
		regresi_ganda;
		clrscr;
                printing;
                clrscr;
		tampilan('Regresi ganda');
		textbackground(black);
		gotoxy(2,4);
		write('Penentuan koefisien regresi ganda :');
		gotoxy(2,5);
		write('ao = ',a0:8:4);
		gotoxy(20,5);
		write('a1 = ',a1:8:4);
		gotoxy(40,5);
		write('a2 = ',a2:8:4);
		gotoxy(2,6);
		write('Persamaan regresi ganda :');
		gotoxy(2,7);
		write('Y = ',a0:8:4,' + ',a1:8:4,' X1 + ',a2:8:4,' X2');
		gotoxy(2,9);
		write('Uji kebermaknaan regresi ganda : ');
		gotoxy(2,10);
		write('Jk regresi = ',jkr:8:4);
		gotoxy(2,11);
		write('Jk residu  = ',jks:8:4);
		gotoxy(2,12);
		write('F data     = ',fdata:8:4);
		gotoxy(2,13);
		write('F tabel    =  F 0,95(2;',ndp-3,') = '); readln(ftab);
		if fdata >= ftab then
		begin
			gotoxy(2,14);
			write('Karena F data > F tabel maka model regresi ganda itu berarti');
		end else
		begin
			gotoxy(2,14);
			write('Karena F data < F tabel maka model regresi ganda itu tidak berarti');
		end;
		gotoxy(2,16);
		write('Uji keberartian koefisien regresi ganda : ');
		gotoxy(2,17);
		write('S a1       = ',sa1:8:4);
		gotoxy(2,18);
		write('S a2       = ',sa2:8:4);
		gotoxy(2,19);
		write('t data 1   = ',tdata1:8:4);
		gotoxy(2,20);
		write('t data 2   = ',tdata2:8:4);
		gotoxy(2,21);
		write('t tabel    =  t 0,975 (',ndp-3,') = '); readln(ttab);
		gotoxy(2,22);
		write('Simpulan   : ');
		if (tdata1 > ttab) or (tdata1 < -ttab) then
		begin
			gotoxy(2,23);
			write('Koefisien regresi a1 bermakna');
		end else
		begin
			gotoxy(2,23);
			write('Koefisien regresi a1 tidak bermakna');
		end;
		if (tdata2 > ttab) or (tdata2 < -ttab) then
		begin
			gotoxy(2,24);
			write('Koefisien regresi a2 bermakna');
		end else
		begin
			gotoxy(2,24);
			write('Koefisien regresi a2 tidak bermakna');
		end;
                if ps = '2' then intr(5,reg);
		tuptext;
    end;

    procedure compare;
    var cnt : integer;
    begin
	    clrscr; cmati;
	    textcolor(yellow);
	    writeln('     Membandingkan harga input dengan harga regresi');
	    writeln;
	    textcolor(white);
	    writeln('x':7,'y(input)':19,'y(regression)':17,
		  'y(residual)':15,'y(residual)ý':15,'no':4);
	    writeln;
	    for cnt := 1 to ndp do
		   writeln(x[cnt]:12:5,y[cnt]:14:5,ytopi[cnt]:15:5,
		   residu[cnt]:15:5,sqresidu[cnt]:15:5,cnt:6);
	    writeln('JK Residual = ':57,sum21:14:5);
    end; {compare}

    procedure printcompare;
    var cnt : integer;
    begin
	    compare;
	    writeln(lst,'Membandingkan harga input dengan harga regresi');
	    writeln(lst,'x':7,'y(input)':19,'y(regression)':15,
		  'y(residual)':15,'y(sqresidual)':15);
	    for cnt := 1 to ndp do
		   writeln(lst,x[cnt]:12:5,y[cnt]:14:5,ytopi[cnt]:15:5,
		   residu[cnt]:15:5,sqresidu[cnt]:15:5,cnt:5);
	    writeln(lst,'JK Residual = ':57,sum21:14:5);
	    tuptext2;
    end; {pcompare}

    procedure comsearch;
    begin
	    cbesar;
	    gotoxy(15,2); write('Apakah akan membandingkan harga input ');
	    gotoxy(15,3); write('dengan harga regresi (y/n) ? ');
	    readln(answer);
	    if (answer in ['j','J','y','Y']) then
	    begin
		    gotoxy(15,5); write('1. Display di monitor');
		    gotoxy(15,6); write('2. Cetak di printer');
		    gotoxy(15,8); write('   Pilihan : '); readln(pilih);
		    case pilih of
		    1 : begin compare; end;
		    2 : printcompare;
		    end;
	    end;
    end;

    procedure menu1;
    begin
	    clrscr;
	    textbackground(brown); textcolor(yellow);
	    gotoxy(30,2);   write('   ASAL DATA    ');
	    textbackground(blue); textcolor(white);
	    gotoxy(30,4);   write('                ');
	    gotoxy(30,5);   write(' 1. Data baru   ');
	    gotoxy(30,6);   write(' 2. Ambil data  ');
	    gotoxy(30,7);   write(' 3. Menu Utama  ');
	    gotoxy(30,8);   write('                ');
	    textcolor(yellow);
	    gotoxy(30,5);   write(' 1');
	    gotoxy(30,6);   write(' 2');
	    gotoxy(30,7);   write(' 3');
	    textbackground(cyan); textcolor(yellow);
	    gotoxy(30,10);   write('   Pilihan :    ');
	    gotoxy(43,10);
	    opsi := readkey;
	    textbackground(black);
	    case opsi of
	    '1' : begin
				input;
				calc;
			end;
	    '2' : begin
				load;
				calc;
			end;
		 '3' : exit;
	    end;
    end;

    procedure menu2;
    begin
	    clrscr;
	    textbackground(brown); textcolor(yellow);
	    gotoxy(25,2);   writeln('     KORELASI/REGRESI GANDA      ');
	    textbackground(blue); textcolor(white);
	    gotoxy(25,4);   writeln('                                 ');
	    gotoxy(25,5);   writeln(' A. Deskripsi data               ');
	    gotoxy(25,6);   writeln(' B. Korelasi ganda               ');
	    gotoxy(25,7);   writeln(' C. Regresi ganda                ');
	    gotoxy(25,8);   writeln(' X. [MENU UTAMA]                 ');
	    gotoxy(25,9);   writeln('                                 ');
	    textcolor(yellow);
	    gotoxy(25,5);   writeln(' A');
	    gotoxy(25,6);   writeln(' B');
	    gotoxy(25,7);   writeln(' C');
	    gotoxy(25,8);   writeln(' X');
	    textbackground(cyan); textcolor(brown);
	    cbesar;
	    gotoxy(25,11);  writeln('           Pilihan :             ');
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
		 gotoxy(46,11); write('-');
		 delay(300);
		 inc(i,1);
	    until keypressed;
	    cbesar;
    end;

begin
	10:
	repeat
		textbackground(black);
		menu2;
		opsi3 := readkey;
	until upcase(opsi3) in ['A','B','C','X'];
	textbackground(black);
	case upcase(opsi3) of
		 'A' : begin
				  20: menu1;
				  if opsi = '3' then goto 10;
				  sum;
                      if opsi2 = #13 then goto 20 else goto 10;
                 end;
           'B' : begin
                      30: menu1;
                      if opsi = '3' then goto 10;
							 display_kg;
							 if opsi2 = #13 then goto 30 else goto 10;
                 end;
           'C' : begin
                      40: menu1;
                      if opsi = '3' then goto 10;
							 display_rg;
                      if opsi2 = #13 then goto 40 else goto 10;
                 end;
		 'X' : halt;
     end;
end.




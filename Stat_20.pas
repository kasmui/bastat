{$N+}
Program Distribusi_T;
uses crt,stat_gam,stat_m;
const
     toleransi  = 1.0e-5;
     tol        = 1e-4;
var
     atas,bawah,itatas,itbawah,akhir,delx,mid,ganjil,pel,pelm,
     genap,total,total1,x,xi,t,prob,probt,dprob,segmen : real;
     i,j,bagian,pilih,nu : integer;
     ii                  : longint;
     taua,taub,tau,xa,xb,tperv,pang,pangkat : real;
     opsi1,opsi2,lagi : char;

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



     procedure Simpson(atas,bawah : real; var total : real);
     function pow(a,b : real): extended;
     begin
          pow := exp(b*ln(a));
     end;

     function Fx(t : real) : real;
     begin
          x := (nu+1)/2;
          taua := gam(x);
          x := nu/2;
          taub := gam(x);
          tau  := taua/(taub*sqrt(pi*nu));
          tperv:= 1+(sqr(t)/nu);
          pang := -0.5*(nu+1);
          pangkat := pow(tperv,pang);
          fx := tau * pangkat;
     end;

     begin
          bagian := 2; j := 1;
          delx := (atas-bawah)/bagian;
          ganjil := fx(bawah+delx);
          genap := 0;
          akhir := Fx(bawah)+Fx(atas);
          total := (akhir+4*ganjil)*delx/3;
          repeat
                bagian := bagian*2;
                total1 := total;
                delx := (atas-bawah)/bagian;
                genap := genap + ganjil;
                ganjil := 0;
                for i := 1 to (bagian div 2) do
                begin
                     xi := bawah + delx*(2.0*i-1.0);
                     ganjil := ganjil + Fx(xi);
                end;
                total := (akhir + 4*ganjil+2*genap)* delx/3;
                j := j + 1;
          until abs(total - total1) <= abs(toleransi*total);
     end;

     procedure integrasi1;
     begin
          t := 0;
          repeat
                simpson(t,0,segmen);
                prob := segmen;
                gotoXY(10,7);  write('Peluang  = ',(prob+0.5):9:6);
                gotoXY(10,9);  write('Harga t  = ',t:9:6);
                t := t + 0.0001;
          until abs((prob+0.5)-pel) <= tol;
     end;

     procedure integrasi2;
     begin
		simpson(t,0,segmen);
		prob := segmen;
		prob := prob + 0.5;
	end;

	Procedure data1;
	begin
		gotoXY(10,5);  write('Mencari harga t jika peluang dan dk diketahui :');
		gotoXY(10,8);  write('Harga dk = ');
		gotoXY(10,9);  write('Harga t  = ');
		repeat
			 gotoXY(10,7);  write('Peluang  =  ');  readln(pel);
		until pel > 0;
		pelm := pel;
		if pel < 0.5 then
		begin
			pel := 1 - pel;
		end;
		gotoXY(10,8);  write('Harga dk =  '); readln(nu);
	end;

	Procedure data2;
	begin
		gotoXY(10,5);  write('Mencari harga peluang jika t dan dk diketahui :');
          gotoXY(10,7);  write('Harga dk = ');
          gotoXY(10,8);  write('Harga t  = ');
          gotoXY(10,9);  write('Peluang  = ');
          cbesar;
          gotoXY(10,7);  write('Harga dk = '); readln(nu);
          gotoXY(10,8);  write('Harga t  = '); readln(t);
          cmati;
     end;

     Procedure peluang1;
     begin
          itatas := t;
          integrasi1;
          prob := prob + 0.5;
     end;

     Procedure hasil1;
     begin
          if pelm < 0.5 then t := -t;
          gotoXY(10,9);  write('Harga t  = ',t:9:6);
          if pelm < 0.5 then prob := 1 - prob;
          gotoXY(10,7);  write('Peluang  = ',prob:9:6);
     end;

     procedure hasil2;
     begin
          gotoXY(10,9);  write('Peluang  = ',prob:9:6);
     end;

     procedure menu;
     begin
         clrscr;
         textbackground(brown); textcolor(yellow);
         gotoxy(25,2);   writeln('           MAIN MENU             ');
         textbackground(blue); textcolor(white);
         gotoxy(25,4);   writeln('                                 ');
	    gotoxy(25,5);   writeln(' A. MENCARI HARGA t              ');
	    gotoxy(25,6);   writeln(' B. MENCARI PROBABILITAS         ');
	    gotoxy(25,7);   writeln(' X. [EXIT]                       ');
	    gotoxy(25,8);   writeln('                                 ');
         textcolor(yellow);
         gotoxy(25,5);   writeln(' A');
         gotoxy(25,6);   writeln(' B');
         gotoxy(25,7);   writeln(' X');
         textbackground(blue); textcolor(lightgreen);
         cbesar;
         gotoxy(25,12);  writeln('           Pilihan :             ');
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
           textbackground(blue);
           textcolor(i+6);
           gotoxy(46,12); write('-');
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
           textcolor(yellow);
           case upcase(opsi1) of
           'A' : begin
				  repeat
					   clrscr;
					   tampilan('Distribusi student (t)');
					   cbesar;
					   data1;
					   cmati;
					   peluang1;
					   hasil1;
					   tuptext2;
				  until opsi2 = #27;
			  end;
		 'B' : begin
		       repeat
		            clrscr;
		            tampilan('Distribusi student (t)');
                            data2;
                            integrasi2;
                            hasil2;
                            tuptext2;
                       until opsi2 = #27;
                 end;
           'X' : halt;
           end;
     until upcase(opsi1) = 'X'
end.

begin
     clrscr;
     repeat
           data1;
           peluang1;
           hasil1;
     until upcase(lagi) <> 'Y'
end.
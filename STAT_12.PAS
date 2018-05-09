Program metode_theil;
uses crt,dos,stat_m;
type datar  = array[1..100] of real;
var opsi1,opsi2,opsi3,metu,ps:char;
	 j,jj,cnt,ndp,ndp2,ndp3,ndp4,min,plus,hdata : integer;
	 aveb,avea,meda : real;
	 x,y,b,bb,a,aa,yreg:datar;
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
		 tampilan('Nonparametrik : Regresi metode Theil');
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
			gotoxy(15,4); write('Ukuran sampel (genap) = '); readln(ndp);
		 until (ndp mod 2 = 0)and (ndp < 21);
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
			tampilan('Nonparametrik : Regresi metode Theil');
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
		gotoxy(27,3); write('    REGRESI METODE THEIL     ');
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

	procedure sort(var v : datar; ndp : integer);
	procedure qsort(var v : datar; mdp,ndp : integer);
	var i,j : integer;

		procedure partit(var a : datar; var i,j,left,right : integer);
		var pivot : real;

			 procedure swap(var p,q : real);
			 var hold : real;
			 begin
				hold := p;
				p := q;
				q := hold;
			 end;
		begin
			pivot := a[(left+right) div 2];
			i := left;
			j := right;
			while i <= j do
			begin
				while a[i] < pivot do i := i + 1;
				while pivot < a[j] do j := j - 1;
				if i <= j then
				begin
					swap(a[i],a[j]);
					i := i + 1;
					j := j - 1;
				end;
			end;
		end;
	begin
		if mdp < ndp then
		begin
			partit(v,i,j,mdp,ndp);
			qsort(v,mdp,j);
			qsort(v,i,ndp);
		end;
	end;
	begin
		qsort(v,1,ndp);
	end;

	 procedure theil;
	 begin
		ndp2 := ndp div 2;
		ndp3 := ndp2+1;
		for cnt := 1 to ndp2 do
		begin
			b[cnt] := (y[ndp2+cnt]-y[cnt])/x[ndp3];
			bb[cnt] := b[cnt];
		end;
		sort(b,ndp2);
		ndp4 := ndp2 div 2;
		aveb := b[ndp4]+((b[ndp4+1]-b[ndp4])/2);
		for cnt := 1 to ndp do
		begin
			a[cnt] := y[cnt]-(aveb*x[cnt]);
			aa[cnt] := a[cnt];
		end;
		sort(a,ndp);
		meda := (a[ndp3]-a[ndp2])/2;
		avea := abs(a[ndp2])+meda;
		for cnt := 1 to ndp do
		begin
			yreg[cnt] := avea+ (aveb*x[cnt]);
		end;
		gotoxy(5,3); write('Slope':8);
		for cnt := 1 to ndp2 do
		begin
			gotoxy(5,3+cnt); write(bb[cnt]:8:4);
		end;
		gotoxy(5,5+ndp2); write(aveb:8:4);
		gotoxy(20,3); write('Intercept');
		for cnt := 1 to ndp do
		begin
			gotoxy(20,3+cnt); write(aa[cnt]:8:4);
		end;
		gotoxy(20,5+ndp); write(meda:8:4);
		gotoxy(35,3); write('X':6,'Y data':14,'Y reg':10);
		for cnt := 1 to ndp do
		begin
			gotoxy(35,3+cnt); write(x[cnt]:10:4,y[cnt]:10:4,yreg[cnt]:10:4);
		end;

		gotoxy(5,7+ndp); write('Persamaan regresi:');
		gotoxy(5,8+ndp); write('Y = ',avea:8:4,' + ',aveb:8:4,' X');
	 end;



Begin
	  clrscr;
	  repeat
			  clrscr;
			  warna(0,0,80,25,black);
			  menu;
			  clrscr;
			  printing;
			  tampilan('Nonparametrik : Regresi metode Theil');
			  theil;
			  if ps = '2' then intr(5,reg);
			  tuptext;
	  until opsi2 = #27;
end.

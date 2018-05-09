Unit stat_mat;
interface
uses stat_m,crt;
const max  = 50;
      imax = 50;
type indeks_1 = 1..max;
     indeks_2 = 1..imax;
     matrix = array[indeks_1,indeks_2] of real;
     vektor = array[indeks_2] of real;
var i,j : byte;

procedure tekan_esc;
Procedure Tekan_enter;
procedure determinan(baris,kolom : byte;  x:matrix; var det : real);
procedure jumlah(baris,kolom:byte; x,y :matrix; var z : matrix);
procedure selisih(baris,kolom:byte; x,y :matrix; var z : matrix);
procedure transpose(baris,kolom:byte; mat : matrix; var matt : matrix);
procedure kali_transpose_1(m,n: byte; x: matrix; y: vektor; var z: vektor);
procedure kali_transpose_2(m,n: byte; x: matrix; var z: matrix);
procedure kali_transpose_3(n: byte; y1,y2: vektor; var z: real);
procedure kali_skalar(baris,kolom:byte; konst : real; x:matrix; var z : matrix);
procedure kali_transpose(m,n: byte; x: matrix; var z: matrix);
procedure matriks_invers(baris : byte; x : matrix; var z:matrix);
procedure kali_matriks(baris_x,kolom_x,kolom_y: byte; x,y: matrix; var z: matrix);
procedure kali_matriks_2(baris_x,kolom_x,kolom_y: byte; x: matrix; y:vektor;var z: vektor);
procedure varian_kovarian(baris,kolom:byte; data:matrix; var varco : matrix);
procedure anova(k,m : byte; koef,z,zk : vektor; var r,mse : real);
procedure varian_kovarian_2(k:byte; zk:matrix; mse:real; var szk : matrix);
procedure test_t(k:byte; szk:matrix; koef:vektor; var t:vektor);
procedure estimasi(n,k : byte; szk: matrix; var inz : matrix);

implementation

Procedure Tekan_Esc;
const tulis2 = '';
      tulis1 = 'Tekan <Esc>';
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
     repeat until readkey = #27;
end;

Procedure Tekan_enter;
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
     repeat until readkey = #13;
end;


procedure determinan(baris,kolom : byte;  x:matrix; var det : real);
var
   tanda : integer;
   j,k,l,m,n : byte;
   konst : real;

begin
     tanda := 1;
     for l := 2 to baris do
     begin
          for m := 1 to baris do
	  begin
               k := l-1;
               if x[k,k] = 0 then
	       begin
	            konst := 0;
                    n := k-1;
                    while (konst=0) and (n<= baris) do
		    begin
                         n := n+1;
                         konst := x[n,k];
                    end;
		    if konst <> 0 then
                    begin
                         tanda := -tanda;
                         for j := k to kolom do
			 begin
                              konst := x[k,j];
                              x[k,j] := x[n,j];
                              x[n,j] := konst;
			 end;
		    end else
                    begin
                         x[k,k] := 1;
		         tanda := 0;
		    end;
               end;
               konst := x[m,k]/x[k,k];
	       for n := k to kolom do x[m,n] := x[m,n]-konst*x[k,n];
          end;
     end;
     det := tanda;
     for m := 1 to baris do det := det*x[m,m];
end;

procedure jumlah(baris,kolom:byte; x,y :matrix; var z : matrix);
var i,j : byte;
begin
     for i := 1 to baris do
         for j := 1 to kolom do z[i,j] := x[i,j]+y[i,j];
end;

procedure selisih(baris,kolom:byte; x,y :matrix; var z : matrix);
var i,j : byte;
begin
     for i := 1 to baris do
         for j := 1 to kolom do z[i,j] := x[i,j]-y[i,j];
end;

procedure transpose(baris,kolom:byte; mat : matrix; var matt : matrix);
var i,j : byte;
begin
     for i := 1 to baris do
         for j := 1 to kolom do matt[j,i] := mat[i,j];
end;

procedure kali_transpose_1(m,n: byte; x: matrix; y: vektor; var z: vektor);
var i,k : byte;
begin
     for i := 1 to m do
     begin
          z[i] := 0;
	  for k := 1 to n do z[i] := z[i] + x[k,i]*y[k];
     end;
end;

procedure kali_transpose_2(m,n: byte; x: matrix; var z: matrix);
var i,j,k : byte;
begin
     for i := 1 to m do
         for j := 1 to m do
	 begin
	      z[i,j] := 0;
	      for k := 1 to n do z[i,j] := z[i,j] + x[k,i]*x[k,j];
	 end;
end;

procedure kali_transpose_3(n: byte; y1,y2: vektor; var z: real);
var i,k : byte;
begin
     z := 0;
     for i := 1 to n do z := z + y1[i]*y2[i];
end;

procedure kali_skalar(baris,kolom:byte; konst : real; x:matrix; var z : matrix);
var i,j : byte;
begin
     for i := 1 to baris do
         for j := 1 to kolom do z[i,j] := konst*x[i,j];
end;

procedure kali_transpose(m,n: byte; x: matrix; var z: matrix);
var i,j,k : byte;
begin
     for i := 1 to m do
         for j := 1 to m do
	 begin
	      z[i,j] := 0;
	      for k := 1 to n do z[i,j] := z[i,j] + x[k,i]*x[k,j];
	 end;
end;

procedure matriks_invers(baris : byte; x : matrix; var z:matrix);
var xx,yy : array[1..10,1..20] of real;
    y : real;
    i,j,k : byte;
begin
     for i := 1 to baris do
         for j := 1 to baris do xx[i,j] := x[i,j];

     for i := 1 to baris do
         for j := 1 to baris do
	 if i = j then xx[i,baris+j] := 1
	 else xx[i,baris+j] := 0;

     for i := 1 to baris do
     begin
          if xx[i,i] = 0 then
	  begin
	       for j := i+1 to baris do
	       begin
	            if xx[j,i] <> 0 then
		    begin
		         for k := 1 to 2*baris do
			 begin
			      y := xx[i,k];
			      xx[i,k] := xx[j,k];
			      xx[j,k] := y;
			 end;
		    end;
	       end;
	  end;

	  y := xx[i,i];
	  for j := i to 2*baris do xx[i,j] := xx[i,j]/y;

          for j := 1 to baris do
	  begin
	       if j <> i then
	       begin
	            for k := i to 2*baris do yy[j,k] := xx[j,k]-xx[j,i]*xx[i,k];
		    for k := i to 2*baris do xx[j,k] := yy[j,k];
	       end;
	  end;
     end;
     for i := 1 to baris do
         for j := 1 to baris do z[i,j] := xx[i,j+baris];
end;

procedure kali_matriks(baris_x,kolom_x,kolom_y: byte; x,y: matrix; var z: matrix);
var k,m,n : byte;
begin
     for m := 1 to baris_x do
         for n := 1 to kolom_y do
	 begin
	      z[m,n] := 0;
	      for k := 1 to kolom_x do z[m,n] := z[m,n] + x[m,k]*y[k,n];
	 end;
end;

procedure kali_matriks_2(baris_x,kolom_x,kolom_y: byte; x: matrix; y:vektor;var z: vektor);
var k,m,n : byte;
begin
     for m := 1 to baris_x do
         for n := 1 to kolom_y do
         begin
	      z[m] := 0;
	      for k := 1 to kolom_x do z[m] := z[m] + x[m,k]*y[k];
	 end;
end;

procedure varian_kovarian(baris,kolom:byte; data:matrix; var varco : matrix);
type rata = array[indeks_2] of real;
var i,j,k : byte;
    r : rata;
begin
     for j := 1 to kolom do
     begin
          r[j] :=0;
	  for i := 1 to baris do r[j] := r[j] + data[i,j];
	  r[j] := r[j]/baris;
     end;

     for k := 1 to kolom do
     begin
          for j := 1 to kolom do
	  begin
	       varco[k,j] := 0;
	       for i := 1 to baris do
	           varco[k,j] := varco[k,j] + (data[i,k]-r[k])*(data[i,j]-r[j]);
		   varco[k,j] := varco[k,j]/(baris-1);
	  end;
     end;
end;

procedure anova(k,m : byte; koef,z,zk : vektor; var r,mse : real);
var i : byte;
	 f,sst,ssr,sse,msr,ay : real;

	 function rata_rata(n : integer; x : vektor) : real;
	 var i : integer;
		  sum_x : real;
	 begin
			sum_x := 0;
			for i := 1 to n do
				 sum_x := sum_x + x[i];
			rata_rata := sum_x/n;
	 end;

	 procedure tabel_anova(k,n : byte; sst,ssr,sse,msr,mse,f : real);
	 var i : byte;
	 begin
			writeln;
			writeln;
			writeln('Tabel ANOVA:');
			for i := 3 to 78 do write('=');
			writeln;
			writeln('Sumber');
			gotoxy(19,wherey-1); writeln('Jumlah');
			gotoxy(49,wherey-1); writeln('Rata-rata');
			writeln('variasi');
			gotoxy(19,wherey-1); writeln('kuadrat');
			gotoxy(32,wherey-1); writeln('dk':10);
			gotoxy(49,wherey-1); writeln('kuadrat');
			gotoxy(64,wherey-1); writeln('F':10);
			for i := 3 to 78 do write('-');
			writeln;

			writeln('Regresi');
			gotoxy(16,wherey-1); writeln(ssr:10:3);
			gotoxy(32,wherey-1); writeln(k-1:10);
			gotoxy(48,wherey-1); writeln(msr:10:3);
			gotoxy(64,wherey-1); writeln(f:10:3);

			writeln('Kesalahan');
			gotoxy(16,wherey-1); writeln(sse:10:3);
			gotoxy(32,wherey-1); writeln(n-k:10);
			gotoxy(48,wherey-1); writeln(mse:10:3);
			for i := 3 to 78 do write('-');
			writeln;

			writeln('Total');
			gotoxy(16,wherey-1); writeln(sst:10:3);
			gotoxy(32,wherey-1); writeln(n-1:10);

			for i := 3 to 78 do write('=');
			writeln;
			writeln;
			gotoxy(1,wherey-1); writeln('Harga r = ',r:10:4);
	 end;

begin
	  kali_transpose_3(m,z,z,ay);
	  sst := ay-m*sqr(rata_rata(m,z));
	  kali_transpose_3(m,koef,zk,ay);
	  ssr := ay-m*sqr(rata_rata(m,z));
	  sse := sst-ssr;
	  msr := ssr/(k-1);
	  mse := sse/(m-k);
	  f := msr/mse;
	  r := sqrt(ssr/sst);
	  tabel_anova(k,m,sst,ssr,sse,msr,mse,f);
end;

procedure varian_kovarian_2(k:byte; zk:matrix; mse:real; var szk : matrix);
var i,j : byte;
begin
		for i := 1 to k do
			 for j := 1 to k do
				  szk[i,j] := mse*zk[i,j];
end;

procedure test_t(k:byte; szk:matrix; koef:vektor; var t:vektor);
var i,j : byte;
begin
	  for i := 1 to k do t[i] := koef[i]/sqrt(szk[i,i]);
end;

procedure estimasi(n,k : byte; szk: matrix; var inz : matrix);
var t : real;
	 i,j : byte;
begin
	  writeln('Derajat kebebasan         : ',n-k);
	  write('t tabel                   : '); readln(t);
	  writeln;
	  for i := 1 to k do inz[i,i] := sqrt(szk[i,i])*t;
end;

END.






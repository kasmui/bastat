{$M 40000,0,0}
Program statistika_dasar;
uses CRT,dos,stat_m;
var opsi,opsi1,opsi2,opsi3 : char;
	 i : byte;


Procedure ulang;
const tulis2 = '<Esc> Keluar';
	 tulis1 = '';
begin
	cmati;
	textbackground(brown);
	for i := 1 to 79 do
	begin
		gotoxy(i,25); write(' ');
	end;
	textcolor(yellow);
	gotoxy(79-length(tulis1),25); write(tulis1);
	gotoxy(2,25); write(tulis2);
end;

	procedure programer(xx:byte);
	begin
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
				gotoxy(45,xx); write('-');
				delay(300);
				inc(i,1);
		  until keypressed;
	end;

	procedure menu1;
	begin
	repeat
		  textbackground(black);
		  clrscr;
		  textbackground(brown); textcolor(yellow);
		  gotoxy(25,2);   write('      ANALISIS VARIANS         ');
		  textbackground(blue); textcolor(white);
		  gotoxy(25,4);   write('                               ');
		  gotoxy(25,5);   write(' A. RANDOMIZED BLOCKS ANOVA    ');
		  gotoxy(25,6);   write(' B. TWO-WAY ANOVA              ');
		  gotoxy(25,7);   write(' C. THREE-WAY ANOVA            ');
		  gotoxy(25,8);   write(' D. FOUR-WAY ANOVA             ');
		  gotoxy(25,9);   write(' X. [MENU UTAMA]               ');
		  gotoxy(25,10);   write('                               ');
		  textcolor(yellow);
		  gotoxy(25,5);   write(' A');
		  gotoxy(25,6);   write(' B');
		  gotoxy(25,7);   write(' C');
		  gotoxy(25,8);   write(' D');
		  gotoxy(25,9);   write(' X');
		  textbackground(cyan); textcolor(yellow);
		  gotoxy(25,12);  write('        Pilihanku :            ');
		  cmati;
		  programer(12);
		  textbackground(black);
		  textcolor(yellow);
		  gotoxy(45,12);
		  opsi1 := readkey;
		  case upcase(opsi1) of
		  'A' : begin exec('stat_13.exe',''); end;
		  'B' : begin exec('stat_9.exe',''); end;
		  'C' : begin exec('stat_8.exe',''); end;
		  'D' : begin exec('stat_24.exe',''); end;
		  'X' : begin exit; end;
		  end;
	until upcase(opsi1) in ['A','B','C','D','X'];
	end;

	procedure menu2;
	begin
	repeat
		 textbackground(black);
		 clrscr;
		 textbackground(brown); textcolor(yellow);
		 gotoxy(25,2);   write('        DISTRIBUSI DATA        ');
		 textbackground(blue); textcolor(white);
		 gotoxy(25,4);   write('                               ');
		 gotoxy(25,5);   write(' A. Tabel Z                    ');
		 gotoxy(25,6);   write(' B. Tabel t                    ');
		 gotoxy(25,7);   write(' C. Tabel Chiý                 ');
		 gotoxy(25,8);   write(' X. [MENU UTAMA]               ');
		 gotoxy(25,9);   write('                               ');
		 textcolor(yellow);
		 gotoxy(25,5);   write(' A');
		 gotoxy(25,6);   write(' B');
		 gotoxy(25,7);   write(' C');
		 gotoxy(25,8);   write(' X');
		 textbackground(cyan); textcolor(yellow);
		 gotoxy(25,11);  write('        Pilihanku :            ');
		 cmati;
		 programer(11);
		 textbackground(black);
		 textcolor(yellow);
		 gotoxy(45,10);
		 opsi1 := readkey;
		 case upcase(opsi1) of
		 'A' : begin exec('Stat_21.exe',''); end;
		 'B' : begin exec('Stat_20.exe',''); end;
		 'C' : begin exec('Stat_19.exe',''); end;
		 'X' : begin exit; end;
		 end;
	until upcase(opsi1) in ['A','B','C','X'];
   end;

	procedure menu3;
	begin
	repeat
		  textbackground(black);
		  clrscr;
		  textbackground(brown); textcolor(yellow);
		  gotoxy(25,2);   write('    STATISTIKA NONPARAMETRIK   ');
		  textbackground(blue); textcolor(white);
		  gotoxy(25,4);   write('                               ');
		  gotoxy(25,5);   write(' A. UJI TANDA                  ');
		  gotoxy(25,6);   write(' B. UJI TANDA RANK WILCOXON    ');
		  gotoxy(25,7);   write(' C. UJI JUMLAH RANK WILCOXON   ');
		  gotoxy(25,8);   write(' D. TABEL KONTINGENSI          ');
		  gotoxy(25,9);   write(' E. REGRESI METODE THEIL       ');
		  gotoxy(25,10);  write(' F. KORELASI RANK/SPEARMAN     ');
                  gotoxy(25,11);  write(' G. UJI RANK KRUSKAL WALLIS    ');
		  gotoxy(25,12);  write(' X. [MENU UTAMA]               ');
		  gotoxy(25,13);  write('                               ');
		  textcolor(yellow);
		  gotoxy(25,5);   write(' A');
		  gotoxy(25,6);   write(' B');
		  gotoxy(25,7);   write(' C');
		  gotoxy(25,8);   write(' D');
		  gotoxy(25,9);   write(' E');
		  gotoxy(25,10);  write(' F');
                  gotoxy(25,11);  write(' G');
		  gotoxy(25,12);  write(' X');
		  textbackground(cyan); textcolor(yellow);
		  gotoxy(25,15);  write('        Pilihanku :            ');
		  cmati;
		  programer(15);
		  textbackground(black);
		  textcolor(yellow);
		  gotoxy(45,14);
		  opsi1 := readkey;
		  case upcase(opsi1) of
		  'A' : begin exec('stat_10.exe',''); end;
		  'B' : begin exec('stat_15.exe',''); end;
		  'C' : begin exec('stat_17.exe',''); end;
		  'D' : begin exec('stat_11.exe',''); end;
		  'E' : begin exec('stat_12.exe',''); end;
		  'F' : begin exec('stat_14.exe',''); end;
                  'G' : begin exec('stat_18.exe',''); end;
		  'X' : begin exit; end;
		  end;
	until upcase(opsi1) in ['A','B','C','D','E','F','G','X'];
	end;

        procedure menu4;
	begin
             Repeat
		 textbackground(black);
		 clrscr;
		 textbackground(brown); textcolor(yellow);
		 gotoxy(25,2);   write('        MANAGEMEN DATA        ');
		 textbackground(blue); textcolor(white);
		 gotoxy(25,4);   write('                       ');
		 gotoxy(25,5);   write(' A. Data Baru dan Lama ');
		 gotoxy(25,6);   write(' C. Edit Data          ');
		 gotoxy(25,7);   write(' X. [MENU UTAMA]       ');
		 gotoxy(25,8);   write('                       ');
		 textcolor(yellow);
		 gotoxy(25,5);   write(' A');
		 gotoxy(25,6);   write(' B');
		 gotoxy(25,7);   write(' X');
		 textbackground(cyan); textcolor(yellow);
		 gotoxy(25,10);  write('        Pilihanku :    ');
		 cmati;
		 programer(10);
		 textbackground(black);
		 textcolor(yellow);
		 gotoxy(45,10);
		 opsi1 := readkey;
		 case upcase(opsi1) of
		 'A' : begin exec('Stat_26.exe',''); end;
		 'B' : begin exec('Stat_25.exe',''); end;
		 'X' : begin exit; end;
		 end;
             until upcase(opsi1) in ['A','B','X'];
   end;



begin
	  exec('stat_k.exe','');
          gelap;
	  exec('stat_b.exe','');
	  repeat
                gelap;
		clrscr;
		textbackground(brown); textcolor(yellow);
		gotoxy(25,2);   write('  MENU UTAMA BASIC STATISTICS  ');
		textbackground(7); textcolor(blue);
		gotoxy(25,4);   write('                               ');
		gotoxy(25,5);   write(' A. STATISTIKA DESKRIPTIF      ');
		gotoxy(25,6);   write(' B. STATISTIKA EKSPLORATIF     ');
		gotoxy(25,7);   write(' C. STATISTIKA KOMPARATIF      ');
		gotoxy(25,8);   write(' D. ONE-WAY ANOVA/UJI BARTLETT ');
		gotoxy(25,9);   write(' E. REGRESI LINIER/NONLINIER   ');
		gotoxy(25,10);  write(' F. KORELASI TUNGGAL           ');
		gotoxy(25,11);  write(' G. KORELASI/REGRESI GANDA     ');
		gotoxy(25,12);  write(' H. REGRESI MULTIPEL           ');
		gotoxy(25,13);  write(' I. ANAVA MULTI JALUR          ');
		gotoxy(25,14);  write(' J. STATISTIKA NONPARAMETRIK   ');
		gotoxy(25,15);  write(' K. DISTRIBUSI PROBABILITAS    ');
		gotoxy(25,16);  write(' L. DAFTAR FILE                ');
                gotoxy(25,17);  write(' M. MANAJEMEN DATA             ');
		gotoxy(25,18);  write(' X. KELUAR                     ');
		gotoxy(25,19);  write('                               ');
		textcolor(lightred);
		gotoxy(25,5);   write(' A');
		gotoxy(25,6);   write(' B');
		gotoxy(25,7);   write(' C');
		gotoxy(25,8);   write(' D');
		gotoxy(25,9);   write(' E');
		gotoxy(25,10);  write(' F');
		gotoxy(25,11);  write(' G');
		gotoxy(25,12);  write(' H');
		gotoxy(25,13);  write(' I');
		gotoxy(25,14);  write(' J');
		gotoxy(25,15);  write(' K');
		gotoxy(25,16);  write(' L');
                gotoxy(25,17);  write(' M');
		gotoxy(25,18);  write(' X');
		textbackground(cyan); textcolor(yellow);
		gotoxy(25,21);  write('        Pilihanku :            ');
		cmati;
		programer(21);
		cbesar;
		textbackground(black);
		textcolor(yellow);
		opsi := readkey;
		case upcase(opsi) of
		'A' : begin exec('stat_1.exe',''); end;
		'B' : begin exec('stat_2.exe',''); end;
		'C' : begin exec('stat_3.exe',''); end;
		'D' : begin exec('stat_4.exe',''); end;
		'E' : begin exec('stat_5.exe',''); end;
		'F' : begin exec('stat_6.exe',''); end;
		'G' : begin exec('stat_7.exe',''); end;
		'H' : begin exec('stat_16.exe',''); end;
		'I' : begin menu1; end;
		'J' : begin menu3; end;
		'K' : begin menu2; end;
		'L' : begin
		           clrscr;
			   exec('Stat_22.exe','');
			   ulang;
			   repeat until keypressed;
		      end;
                'M' : begin
		           menu4;
		      end;
		'X' : begin halt; end;
		end;
		until upcase(opsi2) = 'X';
end.

Program ANAVA_4;
uses crt,dos,stat_m;
const mbaris = 5; mkolom = 5;
type ibaris = 1..mbaris;
	ikolom = 1..mkolom;
	data_F = array[1..15] of real;
	data_kol = array[1..mkolom] of byte;
	data_x = array[ibaris,ibaris,ikolom,ikolom,ikolom] of real;
var  i,j,k,l,m,kv1,kv2,kv3,kv4,replik,ntot,dka,dkb,dkc,dkd,dkad,dkbd,dkcd,
	dkdl,dkacd,dkbcd,dkabd,dkab,dkac,dkbc,dkabc,dkabcd : byte;
	ftab : data_f;
	berkas : file of data_x;
	Jdata : file of byte;
	ps,opsi,opsi1,opsi2 : char;
	nama : string[14];
	x : data_x;
	kelvar : data_kol;
	sum_x,sum_x2,sum_tot,sum_bar,sum_ab,sum_ba,msa,msb,msc,msd,msdl,
	msad,msbd,mscd,msabd,msbcd,msacd,msabcd,sum_abcd1,sum_abcd2,sum_abcd3,
	msab,msac,msbc,msabc,fkor,sum_xabc,sum_aa,sum_bb,sum_cc,sum_dd,
	sum_ac,sum_ca,sum_bc,sum_cb,sum_abc,sum_cba,sum_xa,sum_xb,
	sum_xc,sum_xd,sum_xab,sum_xac,sum_xbc,sum_a,sum_b,sum_c,sum_d,
	sum_ad,sum_da,sum_xad,sum_bd,sum_db,sum_xbd,sum_cd,sum_dc,sum_xcd,
	sum_abd,sum_dba,sum_xabd,sum_bcd,sum_dcb,sum_abcd,sum_xbcd,sum_dcba,
	sum_acd,sum_dca,sum_xacd,sum_dl,sum_xabcd,
	test_f1,test_f2,test_f3,test_f4,test_f5,test_f6,test_f7,test_f8,test_f9,
	test_f10,test_f11,test_f12,test_f13,test_f14,test_f15 : real;
	reg : registers;
Label 01,02;

procedure printing;
begin
     clrscr;
	  textbackground(lightgray);
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

	procedure garis_mendatar(y:integer);
	var x : integer;
	begin
		for x := 2 to 78 do
		begin
			gotoxy(x,y);
			writeln('-');
		end;
	end;

	procedure garis_tegak(x:integer);
	var y:integer;
	begin
		for y := 2 to 16 do
		begin
			gotoxy(x,y);
			writeln('³');
		end;
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
     for i := 1 to 78 do write(' ');
     gotoxy(1,1);
     write(st);
     gotoxy(45,1); write('<<<<< Basic Statistics 1.1 >>>>>');
	  textbackground(black);
     textcolor(white);
     gotoxy(1,2);
     write('==============================================================================');
	 end;

	 procedure tampilan2(st:string);
	 begin
	  clrscr;
	  textbackground(brown);
	  textcolor(white);
	  for i := 1 to 78 do write(' ');
	  gotoxy(30,1);
	  write(st);
	  textbackground(black);
	  textcolor(white);
	 end;

Procedure Daftar_ANOVA;
begin
	tampilan2('TABEL ANAVA 4 JALUR');
	textbackground(black);
	garis_mendatar(2);
	gotoxy(4,3);  writeln('Sumber');
	gotoxy(4,4);  writeln('variasi');
	gotoxy(19,3); writeln('Derajat');
	gotoxy(19,4); writeln('kebebasan');
	gotoxy(36,3); writeln('Jumlah');
	gotoxy(36,4); writeln('kuadrat');
	gotoxy(51,3); writeln('Rata-rata');
	gotoxy(51,4); writeln('kuadrat');
	gotoxy(69,3); writeln('F');
	gotoxy(69,4); writeln('data');

	garis_mendatar(5);
	gotoxy(4,6);  writeln('A');
	gotoxy(4,7);  writeln('B');
	gotoxy(4,8);  writeln('C');
	gotoxy(4,9);  writeln('D');
	gotoxy(4,10); writeln('AxB');
	gotoxy(4,11); writeln('AxC');
	gotoxy(4,12); writeln('AxD');
	gotoxy(4,13); writeln('BxC');
	gotoxy(4,14); writeln('BxD');
	gotoxy(4,15); writeln('CxD');
	gotoxy(4,16); writeln('AxBxC');
	gotoxy(4,17); writeln('AxBxD');
	gotoxy(4,18); writeln('BxCxD');
	gotoxy(4,19); writeln('AxCxD');
	gotoxy(4,20); writeln('AxBxCxD');
	gotoxy(4,21); writeln('Dalam');
	garis_mendatar(22);
	gotoxy(4,23); writeln('Total');
	garis_mendatar(24);
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
end;

procedure save;
begin
	clrscr;
	cbesar;
	tampilan('ANAVA 4 Jalur: Data Baru');
	gotoxy(1,3);
	write('Nama File : '); readln(nama);
	assign(jdata,nama+'xi.dat');
	assign(berkas,nama+'.dat');
	rewrite(jdata);
	rewrite(berkas);
	gotoxy(1,22);
	write('Banyak variabel                        : 4');
	for i := 1 to 4 do
	begin
		gotoxy(1,23); clreol;
		write('Banyak kelompok untuk variabel ke-',i,'    : '); readln(kelvar[i]);
	end;
	kv1 := kelvar[1]; kv2 := kelvar[2]; kv3 := kelvar[3]; kv4 := kelvar[4];
	write(jdata,kv1); write(jdata,kv2); write(jdata,kv3); write(jdata,kv4);
	repeat
		gotoxy(1,24); clreol;
		write('Banyak replikasi untuk setiap kelompok : '); readln(replik);
	until replik > 1;
	write(jdata,replik);

	clrscr;
	tampilan('ANAVA 4 Jalur: Data Baru');

	for i := 1 to kv1 do
	begin
		ClrScr;
		for j := 1 to kv2 do
		begin
			for k := 1 to kv3 do
			begin
				for l := 1 to kv4 do
				begin
					for m := 1 to replik do
					begin
						textcolor(m+9);
						gotoxy((25*(j-1))+8,kv4+1);      			write('A',i);
						gotoxy((25*(j-1))+10,kv4+1);      			write('B',j);
						gotoxy(1,(kv4*k)+2); 		 					write('C',k);
						gotoxy(3,(kv4*k)+l+1); 		  					write('D',l);
						gotoxy((25*(j-1))+(8*m),(kv4*k)+l+1); 	write('-');
						gotoxy(1,24);
						write('Masukkan data(',i,j:2,k:2,l:2,m:2,') : '); readln(x[i,j,k,l,m]);
						gotoxy(1,24); clreol;
						gotoxy((25*(j-1))+(8*m),(kv4*k)+l+1);
						write(x[i,j,k,l,m]:5:4);
					end;
				end;
			end;
		end;
	end;

	textcolor(white);

	for i := 1 to kv1 do
	begin
		for j := 1 to kv2 do
		begin
			for k := 1 to kv3 do
			begin
				for l := 1 to kv4 do
				begin
					for m := 1 to replik do
					begin
						write(berkas,x);
					end;
				end;
			end;
		end;
	end;

	cmati;
	garis_mendatar(24);
	gotoxy(2,25); write('Tekan <Enter>... ');
	readln;
	cbesar;
	close(jdata);
	close(berkas);
end;

procedure load;
var n : byte;
label 001;
begin
	001:
	clrscr;
	cbesar;
	tampilan('ANAVA 4 Jalur: Ambil Data');
	gotoxy(1,3);
	write('Nama File : '); readln(nama);
	{$I-}
	assign(jdata,nama+'xi.dat');
	assign(berkas,nama+'.dat');
	reset(jdata);
	reset(berkas);
	{$I+}
	if IOresult = 0 then
	begin
		read(jdata,kv1); read(jdata,kv2);
		read(jdata,kv3); read(jdata,kv4);
		read(jdata,replik);

		for i := 1 to kv1 do
		begin
			for j := 1 to kv2 do
			begin
				for k := 1 to kv3 do
				begin
					for l := 1 to kv4 do
					begin
						for m := 1 to replik do
						begin
							read(berkas,x);
						end;
					end;
				end;
			end;
		end;
	end else
	begin
		clrscr;
		gotoxy(1,3); clreol;
		write(#7);
		cmati;
		writeln('File tidak ada ...!');
		write('Tekan <Esc> Keluar atau <Enter> Ulangi');
		opsi := readkey;
		if opsi = #27 then halt else goto 001;
	end;
	close(jdata);
	close(berkas);
end;

procedure display_data;
begin
	clrscr;
	printing;
	clrscr;
	tampilan('Display Data ANAVA 4 jalur');
	cmati;
	for i := 1 to kv1 do
	begin
		for j := 1 to kv2 do
		begin
			for k := 1 to kv3 do
			begin
				for l := 1 to kv4 do
				begin
					for m := 1 to replik do
					begin
						textcolor(m+9);
						gotoxy((25*(j-1))+8,kv4+1);      			write('A',i);
						gotoxy((25*(j-1))+10,kv4+1);      			write('B',j);
						gotoxy(1,(kv4*k)+2); 		 					write('C',k);
						gotoxy(3,(kv4*k)+l+1); 		  					write('D',l);
						gotoxy((25*(j-1))+(8*m),(kv4*k)+l+1); 	write('-');
						gotoxy(1,24);
						write('Masukkan data(',i,j:2,k:2,l:2,m:2,') : ');
						gotoxy(1,24); clreol;
						gotoxy((25*(j-1))+(8*m),(kv4*k)+l+1);
						write(x[i,j,k,l,m]:5:4);
					end;
				end;
			end;
		end;
		readln;
	end;

	textcolor(white);

	if ps = '2' then intr(5,reg);
	garis_mendatar(24);
	cmati;
	if opsi <> #27 then
	begin
		gotoxy(2,25); write('Tekan <Enter>... ');
		readln;
	end;
	cbesar;
end;

procedure menu;
begin
	clrscr;
	textbackground(brown);
	textcolor(white);
	gotoxy(27,3); write('        ANAVA 4 JALAN        ');
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
	'1' : save;
	'2' : load;
	'0' : halt;
	end;
end;

Procedure sumtotal;
begin
	sum_x := 0;
	sum_x2:= 0;
	for i := 1 to kv1 do
	begin
		for j := 1 to kv2 do
		begin
			for k := 1 to kv3 do
			begin
				for l := 1 to kv4 do
				begin
					for m := 1 to replik do
					begin
						sum_x := sum_x + x[i,j,k,l,m];
						sum_x2 := sum_x2 + sqr(x[i,j,k,l,m]);
					end;
				end;
			end;
		end;
	end;
	ntot := kv1*kv2*kv3*kv4*replik;
	fkor := sqr(sum_x)/ntot;
	sum_tot := sum_x2-fkor;
end;

procedure sumabcd;
begin
	sum_a := 0;
	for i := 1 to kv1 do
	begin
		sum_bar := 0;
		for j := 1 to kv2 do
		begin
			for k := 1 to kv3 do
			begin
				for l := 1 to kv4 do
				begin
					for m := 1 to replik do
					begin
						sum_bar := sum_bar + x[i,j,k,l,m];
					end;
				end;
			end;
		end;
		sum_aa := sqr(sum_bar)/(ntot/kv1);
		sum_a := sum_a + sum_aa;
	end;
	sum_A := sum_a-fkor;

	sum_b := 0;
	for j := 1 to kv2 do
	begin
		sum_bar := 0;
		for i := 1 to kv1 do
		begin
			for k := 1 to kv3 do
			begin
				for l := 1 to kv4 do
				begin
					for m := 1 to replik do
					begin
						sum_bar := sum_bar + x[i,j,k,l,m];
					end;
				end;
			end;
		end;
		sum_bb := sqr(sum_bar)/(ntot/kv2);
		sum_b := sum_b + sum_bb;
	end;
	sum_b := sum_b-fkor;

	sum_c := 0;
	for k := 1 to kv3 do
	begin
		sum_bar := 0;
		for i := 1 to kv1 do
		begin
			for j := 1 to kv2 do
			begin
				for l := 1 to kv4 do
				begin
					for m := 1 to replik do
					begin
						sum_bar := sum_bar + x[i,j,k,l,m];
					end;
				end;
			end;
		end;
		sum_cc := sqr(sum_bar)/(ntot/kv3);
		sum_c := sum_c + sum_cc;
	end;
	sum_c := sum_c-fkor;

	sum_d := 0;
	for l := 1 to kv4 do
	begin
		sum_bar := 0;
		for i := 1 to kv1 do
		begin
			for j := 1 to kv2 do
			begin
				for k := 1 to kv3 do
				begin
					for m := 1 to replik do
					begin
						sum_bar := sum_bar + x[i,j,k,l,m];
					end;
				end;
			end;
		end;
		sum_dd := sqr(sum_bar)/(ntot/kv4);
		sum_d := sum_d + sum_dd;
	end;
	sum_d := sum_d-fkor;

	sum_ab := 0;
	for i := 1 to kv1 do
	begin
		for j := 1 to kv2 do
		begin
			sum_bar := 0;
			for k := 1 to kv3 do
			begin
				for l := 1 to kv4 do
				begin
					for m := 1 to replik do
					begin
						sum_bar := sum_bar + x[i,j,k,l,m];
					end;
				end;
			end;
			sum_ba := sqr(sum_bar)/(ntot/(kv1*kv2));
			sum_ab := sum_ab + sum_ba;
		end;
	end;
	sum_xab := sum_ab-fkor-sum_a-sum_b;

	sum_ac := 0;
	for i := 1 to kv1 do
	begin
		for k := 1 to kv3 do
		begin
			sum_bar := 0;
			for j := 1 to kv2 do
			begin
				for l := 1 to kv4 do
				begin
					for m := 1 to replik do
					begin
						sum_bar := sum_bar + x[i,j,k,l,m];
					end;
				end;
			end;
			sum_ca := sqr(sum_bar)/(ntot/(kv1*kv3));
			sum_ac := sum_ac + sum_ca;
		end;
	end;
	sum_xac := sum_ac-fkor-sum_a-sum_c;

	sum_ad := 0;
	for i := 1 to kv1 do
	begin
		for l := 1 to kv4 do
		begin
			sum_bar := 0;
			for j := 1 to kv2 do
			begin
				for k := 1 to kv3 do
				begin
					for m := 1 to replik do
					begin
						sum_bar := sum_bar + x[i,j,k,l,m];
					end;
				end;
			end;
			sum_da := sqr(sum_bar)/(ntot/(kv1*kv4));
			sum_ad := sum_ad + sum_da;
		end;
	end;
	sum_xad := sum_ad-fkor-sum_a-sum_d;

	sum_bc := 0;
	for j := 1 to kv2 do
	begin
		for k := 1 to kv3 do
		begin
			sum_bar := 0;
			for i := 1 to kv1 do
			begin
				for l := 1 to kv4 do
				begin
					for m := 1 to replik do
					begin
						sum_bar := sum_bar + x[i,j,k,l,m];
					end;
				end;
			end;
			sum_cb := sqr(sum_bar)/(ntot/(kv2*kv3));
			sum_bc := sum_bc + sum_cb;
		end;
	end;
	sum_xbc := sum_bc-fkor-sum_b-sum_c;

	sum_bd := 0;
	for j := 1 to kv2 do
	begin
		for l := 1 to kv4 do
		begin
			sum_bar := 0;
			for i := 1 to kv1 do
			begin
				for k := 1 to kv3 do
				begin
					for m := 1 to replik do
					begin
						sum_bar := sum_bar + x[i,j,k,l,m];
					end;
				end;
			end;
			sum_db := sqr(sum_bar)/(ntot/(kv2*kv4));
			sum_bd := sum_bd + sum_db;
		end;
	end;
	sum_xbd := sum_bd-fkor-sum_d-sum_b;

	sum_cd := 0;
	for k := 1 to kv3 do
	begin
		for l := 1 to kv4 do
		begin
			sum_bar := 0;
			for i := 1 to kv1 do
			begin
				for j := 1 to kv2 do
				begin
					for m := 1 to replik do
					begin
						sum_bar := sum_bar + x[i,j,k,l,m];
					end;
				end;
			end;
			sum_dc := sqr(sum_bar)/(ntot/(kv3*kv4));
			sum_cd := sum_cd + sum_dc;
		end;
	end;
	sum_xcd := sum_cd-fkor-sum_d-sum_c;

	sum_abc := 0;
	for i := 1 to kv1 do
	begin
		for j := 1 to kv2 do
		begin
			for k := 1 to kv3 do
			begin
				sum_bar := 0;
				for l := 1 to kv4 do
				begin
					for m := 1 to replik do
					begin
						sum_bar := sum_bar + x[i,j,k,l,m];
					end;
				end;
				sum_cba := sqr(sum_bar)/(ntot/(kv1*kv2*kv3));
				sum_abc := sum_abc + sum_cba;
			end;
		end;
	end;
	sum_xabc := sum_abc-fkor-sum_a-sum_b-sum_c-sum_xab-sum_xac-sum_xbc;

	sum_abd := 0;
	for i := 1 to kv1 do
	begin
		for j := 1 to kv2 do
		begin
			for l := 1 to kv4 do
			begin
				sum_bar := 0;
				for k := 1 to kv3 do
				begin
					for m := 1 to replik do
					begin
						sum_bar := sum_bar + x[i,j,k,l,m];
					end;
				end;
				sum_dba := sqr(sum_bar)/(ntot/(kv1*kv2*kv4));
				sum_abd := sum_abd + sum_dba;
			end;
		end;
	end;
	sum_xabd := sum_abd-fkor-sum_a-sum_b-sum_d-sum_xab-sum_xad-sum_xbd;

	sum_bcd := 0;
	for j := 1 to kv2 do
	begin
		for k := 1 to kv3 do
		begin
			for l := 1 to kv4 do
			begin
				sum_bar := 0;
				for i := 1 to kv1 do
				begin
					for m := 1 to replik do
					begin
						sum_bar := sum_bar + x[i,j,k,l,m];
					end;
				end;
				sum_dcb := sqr(sum_bar)/(ntot/(kv2*kv3*kv4));
				sum_bcd := sum_bcd + sum_dcb;
			end;
		end;
	end;
	sum_xbcd := sum_bcd-fkor-sum_b-sum_c-sum_d-sum_xbc-sum_xbd-sum_xcd;

	sum_acd := 0;
	for i := 1 to kv1 do
	begin
		for k := 1 to kv3 do
		begin
			for l := 1 to kv4 do
			begin
				sum_bar := 0;
				for j := 1 to kv2 do
				begin
					for m := 1 to replik do
					begin
						sum_bar := sum_bar + x[i,j,k,l,m];
					end;
				end;
				sum_dca := sqr(sum_bar)/(ntot/(kv1*kv3*kv4));
				sum_acd := sum_acd + sum_dca;
			end;
		end;
	end;
	sum_xacd := sum_acd-fkor-sum_a-sum_c-sum_d-sum_xac-sum_xad-sum_xcd;

	sum_abcd := 0;
	for i := 1 to kv1 do
	begin
		for j := 1 to kv2 do
		begin
			for k := 1 to kv3 do
			begin
				for l := 1 to kv4 do
				begin
					sum_bar := 0;
					for m := 1 to replik do
					begin
						sum_bar := sum_bar + x[i,j,k,l,m];
					end;
					sum_dcba := sqr(sum_bar)/(ntot/(kv1*kv2*kv3*kv4));
					sum_abcd := sum_abcd + sum_dcba;
				end;
			end;
		end;
	end;
	sum_abcd1 := sum_a+sum_b+sum_c+sum_d;
	sum_abcd2 := sum_xab+sum_xac+sum_xad+sum_xbc+sum_xbd+sum_xcd;
	sum_abcd3 := sum_xabc+sum_xabd+sum_xbcd+sum_xacd;

	sum_xabcd := sum_abcd-fkor-sum_abcd1-sum_abcd2-sum_abcd3;

	sum_dl := sum_tot-sum_abcd1-sum_abcd2-sum_abcd3-sum_xabcd;
end;

procedure dkmstest;
begin
	dka  := kv1-1;
	dkb  := kv2-1;
	dkc  := kv3-1;
	dkd  := kv4-1;

	dkab := dka*dkb;
	dkac := dka*dkc;
	dkad := dka*dkd;
	dkbc := dkb*dkc;
	dkbd := dkb*dkd;
	dkcd := dkc*dkd;

	dkabc  := dka*dkb*dkc;
	dkabd  := dka*dkb*dkd;
	dkbcd  := dkb*dkc*dkd;
	dkacd  := dka*dkc*dkd;
	dkabcd := dka*dkb*dkc*dkd;

	dkdl  := (ntot-1)-dka-dkb-dkc-dkd-dkab-dkac-dkad-dkbc-dkbd-dkcd-
				dkabc-dkabd-dkbcd-dkacd-dkabcd;

	msa  := sum_a/dka;
	msb  := sum_b/dkb;
	msc  := sum_c/dkc;
	msd  := sum_d/dkd;

	msab := sum_xab/dkab;
	msac := sum_xac/dkac;
	msad := sum_xad/dkad;
	msbc := sum_xbc/dkbc;
	msbd := sum_xbd/dkbd;
	mscd := sum_xcd/dkcd;

	msabc:= sum_xabc/dkabc;
	msabd:= sum_xabd/dkabd;
	msbcd:= sum_xbcd/dkbcd;
	msacd:= sum_xacd/dkacd;

	msabcd:= sum_xabcd/dkabcd;

	msdl  := sum_dl/dkdl;

	test_f1 := msa/msdl;
	test_f2 := msb/msdl;
	test_f3 := msc/msdl;
	test_f4 := msd/msdl;

	test_f5  := msab/msdl;
	test_f6  := msac/msdl;
	test_f7  := msad/msdl;
	test_f8  := msbc/msdl;
	test_f9  := msbd/msdl;
	test_f10 := mscd/msdl;

	test_f11 := msabc/msdl;
	test_f12 := msabd/msdl;
	test_f13 := msbcd/msdl;
	test_f14 := msacd/msdl;
	test_f15 := msabcd/msdl;
end;

procedure tampilan_anova;
begin
	cmati;
	daftar_ANOVA;
	gotoxy(16,6);  writeln(dka:8);
	gotoxy(16,7);  writeln(dkb:8);
	gotoxy(16,8);  writeln(dkc:8);
	gotoxy(16,9);  writeln(dkd:8);

	gotoxy(16,10); writeln(dkab:8);
	gotoxy(16,11); writeln(dkac:8);
	gotoxy(16,12); writeln(dkad:8);
	gotoxy(16,13); writeln(dkbc:8);
	gotoxy(16,14); writeln(dkbd:8);
	gotoxy(16,15); writeln(dkcd:8);

	gotoxy(16,16); writeln(dkabc:8);
	gotoxy(16,17); writeln(dkabd:8);
	gotoxy(16,18); writeln(dkbcd:8);
	gotoxy(16,19); writeln(dkacd:8);

	gotoxy(16,20); writeln(dkabcd:8);

	gotoxy(16,21); writeln(dkdl:8);
	gotoxy(16,23); writeln(ntot-1:8);

	gotoxy(33,6);  writeln(sum_a:10:4);
	gotoxy(33,7);  writeln(sum_b:10:4);
	gotoxy(33,8);  writeln(sum_c:10:4);
	gotoxy(33,9);  writeln(sum_d:10:4);

	gotoxy(33,10); writeln(sum_xab:10:4);
	gotoxy(33,11); writeln(sum_xac:10:4);
	gotoxy(33,12); writeln(sum_xad:10:4);
	gotoxy(33,13); writeln(sum_xbc:10:4);
	gotoxy(33,14); writeln(sum_xbd:10:4);
	gotoxy(33,15); writeln(sum_xcd:10:4);

	gotoxy(33,16); writeln(sum_xabc:10:4);
	gotoxy(33,17); writeln(sum_xabd:10:4);
	gotoxy(33,18); writeln(sum_xbcd:10:4);
	gotoxy(33,19); writeln(sum_xacd:10:4);

	gotoxy(33,20); writeln(sum_xabcd:10:4);

	gotoxy(33,21); writeln(sum_dl:10:4);

	gotoxy(33,23); writeln(sum_tot:10:4);

	gotoxy(50,6);  writeln(msa:10:4);
	gotoxy(50,7);  writeln(msb:10:4);
	gotoxy(50,8);  writeln(msc:10:4);
	gotoxy(50,9);  writeln(msd:10:4);

	gotoxy(50,10); writeln(msab:10:4);
	gotoxy(50,11); writeln(msac:10:4);
	gotoxy(50,12); writeln(msad:10:4);
	gotoxy(50,13); writeln(msbc:10:4);
	gotoxy(50,14); writeln(msbd:10:4);
	gotoxy(50,15); writeln(mscd:10:4);

	gotoxy(50,16); writeln(msabc:10:4);
	gotoxy(50,17); writeln(msabd:10:4);
	gotoxy(50,18); writeln(msbcd:10:4);
	gotoxy(50,19); writeln(msacd:10:4);

	gotoxy(50,20); writeln(msabcd:10:4);

	gotoxy(50,21); writeln(msdl:10:4);
	gotoxy(50,23); writeln('-':6);

	gotoxy(65,6);  writeln(test_f1:10:4);
	gotoxy(65,7);  writeln(test_f2:10:4);
	gotoxy(65,8);  writeln(test_f3:10:4);
	gotoxy(65,9);  writeln(test_f4:10:4);
	gotoxy(65,10); writeln(test_f5:10:4);
	gotoxy(65,11); writeln(test_f6:10:4);
	gotoxy(65,12); writeln(test_f7:10:4);
	gotoxy(65,13); writeln(test_f8:10:4);
	gotoxy(65,14); writeln(test_f9:10:4);
	gotoxy(65,15); writeln(test_f10:10:4);
	gotoxy(65,16); writeln(test_f11:10:4);
	gotoxy(65,17); writeln(test_f12:10:4);
	gotoxy(65,18); writeln(test_f13:10:4);
	gotoxy(65,19); writeln(test_f14:10:4);
	gotoxy(65,20); writeln(test_f15:10:4);

	gotoxy(65,21); writeln('-':6);
	gotoxy(65,23); writeln('-':6);
end;

procedure f_tabel;
begin
	cbesar;
	gotoxy(1,5);  write('F 0,95(',dka,';',dkdl,') = '); readln(ftab[1]);

	if dkb <> dka then
	begin
		gotoxy(1,6);  write('F 0,95(',dkb,';',dkdl,') = '); readln(ftab[2]);
	end else
	begin
		ftab[2] := ftab[1];
	end;

	if (dkc <> dkb) and (dkc <> dka) then
	begin
		gotoxy(1,7);  write('F 0,95(',dkc,';',dkdl,') = '); readln(ftab[3]);
	end else
	begin
		if dkc = dka then ftab[3] :=ftab[1];
		if dkc = dkb then ftab[3] :=ftab[2];
	end;
	if (dkd <> dkc) and (dkd <> dkb) and (dkd <> dka)then
	begin
		gotoxy(1,8);  write('F 0,95(',dkd,';',dkdl,') = '); readln(ftab[4]);
	end else
	begin
		if dkd = dka then ftab[4] :=ftab[1];
		if dkd = dkb then ftab[4] :=ftab[2];
		if dkd = dkc then ftab[4] :=ftab[3];
	end;

	if (dkab <> dka) and (dkab <> dkb) and (dkab <> dkc) and (dkab <> dkd)then
	begin
		gotoxy(1,9);  write('F 0,95(',dkab,';',dkdl,') = '); readln(ftab[5]);
	end else
	begin
		if dkab = dka then ftab[5] :=ftab[1];
		if dkab = dkb then ftab[5] :=ftab[2];
		if dkab = dkc then ftab[5] :=ftab[3];
		if dkab = dkd then ftab[5] :=ftab[4];
	end;
	if (dkac <> dka) and (dkac <> dkb) and (dkac <> dkc) and
		(dkac <> dkd) and (dkac <> dkab) then
	begin
		gotoxy(1,10);  write('F 0,95(',dkac,';',dkdl,') = '); readln(ftab[6]);
	end else
	begin
		if dkac = dka then ftab[6] :=ftab[1];
		if dkac = dkb then ftab[6] :=ftab[2];
		if dkac = dkc then ftab[6] :=ftab[3];
		if dkac = dkd then ftab[6] :=ftab[4];
		if dkac = dkab then ftab[6] :=ftab[5];
	end;

	if (dkad <> dka) and (dkad <> dkb)  and (dkad <> dkc) and
		(dkad <> dkd) and (dkad <> dkab) and (dkad <> dkac) then
	begin
		gotoxy(1,11);  write('F 0,95(',dkad,';',dkdl,') = '); readln(ftab[7]);
	end else
	begin
		if dkad = dka then ftab[7] :=ftab[1];
		if dkad = dkb then ftab[7] :=ftab[2];
		if dkad = dkc then ftab[7] :=ftab[3];
		if dkad = dkd then ftab[7] :=ftab[4];
		if dkad = dkab then ftab[7] :=ftab[5];
		if dkad = dkac then ftab[7] :=ftab[6];
	end;

	if (dkbc <> dka) and (dkbc <> dkb)  and (dkbc <> dkc) and
		(dkbc <> dkd) and (dkbc <> dkab) and (dkbc <> dkac) and
		(dkbc <> dkad) then
	begin
		gotoxy(1,12);  write('F 0,95(',dkbc,';',dkdl,') = '); readln(ftab[8]);
	end else
	begin
		if dkbc = dka then ftab[8] :=ftab[1];
		if dkbc = dkb then ftab[8] :=ftab[2];
		if dkbc = dkc then ftab[8] :=ftab[3];
		if dkbc = dkd then ftab[8] :=ftab[4];
		if dkbc = dkab then ftab[8] :=ftab[5];
		if dkbc = dkac then ftab[8] :=ftab[6];
		if dkbc = dkad then ftab[8] :=ftab[7];
	end;

	if (dkbd <> dka) and (dkbd <> dkb)  and (dkbd <> dkc) and
		(dkbd <> dkd) and (dkbd <> dkab) and (dkbd <> dkac) and
		(dkbd <> dkad) and (dkbd <> dkbc) then
	begin
		gotoxy(1,13);  write('F 0,95(',dkbd,';',dkdl,') = '); readln(ftab[9]);
	end else
	begin
		if dkbd = dka then ftab[9] :=ftab[1];
		if dkbd = dkb then ftab[9] :=ftab[2];
		if dkbd = dkc then ftab[9] :=ftab[3];
		if dkbd = dkd then ftab[9] :=ftab[4];
		if dkbd = dkab then ftab[9] :=ftab[5];
		if dkbd = dkac then ftab[9] :=ftab[6];
		if dkbd = dkad then ftab[9] :=ftab[7];
		if dkbd = dkbc then ftab[9] :=ftab[8];
	end;

	if (dkcd <> dka) and (dkcd <> dkb)  and (dkcd <> dkc) and
		(dkcd <> dkd) and (dkcd <> dkab) and (dkcd <> dkac) and
		(dkcd <> dkad) and (dkcd <> dkbc) and (dkcd <> dkbd) then
	begin
		gotoxy(1,14);  write('F 0,95(',dkcd,';',dkdl,') = '); readln(ftab[10]);
	end else
	begin
		if dkcd = dka then ftab[10] :=ftab[1];
		if dkcd = dkb then ftab[10] :=ftab[2];
		if dkcd = dkc then ftab[10] :=ftab[3];
		if dkcd = dkd then ftab[10] :=ftab[4];
		if dkcd = dkab then ftab[10] :=ftab[5];
		if dkcd = dkac then ftab[10] :=ftab[6];
		if dkcd = dkad then ftab[10] :=ftab[7];
		if dkcd = dkbc then ftab[10] :=ftab[8];
		if dkcd = dkbd then ftab[10] :=ftab[9];
	end;

	if (dkabc <> dka)  and (dkabc <> dkb) and (dkabc <> dkc) and
		(dkabc <> dkd)  and (dkabc <> dkab) and (dkabc <> dkac) and
		(dkabc <> dkad) and (dkabc <> dkbc)  and (dkabc <> dkbd) and
		(dkabc <> dkcd) then
	begin
		gotoxy(1,15);  write('F 0,95(',dkabc,';',dkdl,') = '); readln(ftab[11]);
	end else
	begin
		if dkabc = dka then ftab[11] :=ftab[1];
		if dkabc = dkb then ftab[11] :=ftab[2];
		if dkabc = dkc then ftab[11] :=ftab[3];
		if dkabc = dkd then ftab[11] :=ftab[4];
		if dkabc = dkab then ftab[11] :=ftab[5];
		if dkabc = dkac then ftab[11] :=ftab[6];
		if dkabc = dkad then ftab[11] :=ftab[7];
		if dkabc = dkbc then ftab[11] :=ftab[8];
		if dkabc = dkbd then ftab[11] :=ftab[9];
		if dkabc = dkcd then ftab[11] :=ftab[10];
	end;

	if (dkabd <> dka)  and (dkabd <> dkb) and (dkabd <> dkc) and
		(dkabd <> dkd)  and (dkabd <> dkab) and (dkabd <> dkac) and
		(dkabd <> dkad) and (dkabd <> dkbc)  and (dkabd <> dkbd) and
		(dkabd <> dkcd) and (dkabd <> dkabc)then
	begin
		gotoxy(1,16);  write('F 0,95(',dkabd,';',dkdl,') = '); readln(ftab[12]);
	end else
	begin
		if dkabd = dka then ftab[12] :=ftab[1];
		if dkabd = dkb then ftab[12] :=ftab[2];
		if dkabd = dkc then ftab[12] :=ftab[3];
		if dkabd = dkd then ftab[12] :=ftab[4];
		if dkabd = dkab then ftab[12] :=ftab[5];
		if dkabd = dkac then ftab[12] :=ftab[6];
		if dkabd = dkad then ftab[12] :=ftab[7];
		if dkabd = dkbc then ftab[12] :=ftab[8];
		if dkabd = dkbd then ftab[12] :=ftab[9];
		if dkabd = dkcd then ftab[12] :=ftab[10];
		if dkabd = dkabc then ftab[12] :=ftab[11];
	end;

	if (dkbcd <> dka)  and (dkbcd <> dkb) and (dkbcd <> dkc) and
		(dkbcd <> dkd)  and (dkbcd <> dkab) and (dkbcd <> dkac) and
		(dkbcd <> dkad) and (dkbcd <> dkbc)  and (dkbcd <> dkbd) and
		(dkbcd <> dkcd) and (dkbcd <> dkabc) and (dkbcd <> dkabd) then
	begin
		gotoxy(1,17);  write('F 0,95(',dkbcd,';',dkdl,') = '); readln(ftab[13]);
	end else
	begin
		if dkbcd = dka then ftab[13] :=ftab[1];
		if dkbcd = dkb then ftab[13] :=ftab[2];
		if dkbcd = dkc then ftab[13] :=ftab[3];
		if dkbcd = dkd then ftab[13] :=ftab[4];
		if dkbcd = dkab then ftab[13] :=ftab[5];
		if dkbcd = dkac then ftab[13] :=ftab[6];
		if dkbcd = dkad then ftab[13] :=ftab[7];
		if dkbcd = dkbc then ftab[13] :=ftab[8];
		if dkbcd = dkbd then ftab[13] :=ftab[9];
		if dkbcd = dkcd then ftab[13] :=ftab[10];
		if dkbcd = dkabc then ftab[13] :=ftab[11];
		if dkbcd = dkabd then ftab[13] :=ftab[12];
	end;

	if (dkacd <> dka)  and (dkacd <> dkb) and (dkacd <> dkc) and
		(dkacd <> dkd)  and (dkacd <> dkab) and (dkacd <> dkac) and
		(dkacd <> dkad) and (dkacd <> dkbc)  and (dkacd <> dkbd) and
		(dkacd <> dkcd) and (dkacd <> dkabc) and (dkacd <> dkabd) and
		(dkacd <> dkbcd) then
	begin
		gotoxy(1,18);  write('F 0,95(',dkacd,';',dkdl,') = '); readln(ftab[14]);
	end else
	begin
		if dkacd = dka then ftab[14] :=ftab[1];
		if dkacd = dkb then ftab[14] :=ftab[2];
		if dkacd = dkc then ftab[14] :=ftab[3];
		if dkacd = dkd then ftab[14] :=ftab[4];
		if dkacd = dkab then ftab[14] :=ftab[5];
		if dkacd = dkac then ftab[14] :=ftab[6];
		if dkacd = dkad then ftab[14] :=ftab[7];
		if dkacd = dkbc then ftab[14] :=ftab[8];
		if dkacd = dkbd then ftab[14] :=ftab[9];
		if dkacd = dkcd then ftab[14] :=ftab[10];
		if dkacd = dkabc then ftab[14] :=ftab[11];
		if dkacd = dkabd then ftab[14] :=ftab[12];
		if dkacd = dkbcd then ftab[14] :=ftab[13];
	end;

	if (dkabcd <> dka)  and (dkabcd <> dkb) and (dkabcd <> dkc) and
		(dkabcd <> dkd)  and(dkabcd <> dkab) and (dkabcd <> dkac) and
		(dkabcd <> dkad) and (dkabcd <> dkbc) and (dkabcd <> dkbd) and
		(dkabcd <> dkcd) and (dkabcd <> dkabc) and (dkabcd <> dkabd) and
		(dkabcd <> dkbcd) and (dkabcd <> dkacd) then
	begin
		gotoxy(1,19);  write('F 0,95(',dkabcd,';',dkdl,') = '); readln(ftab[15]);
	end else
	begin
		if dkabcd = dka then ftab[15] :=ftab[1];
		if dkabcd = dkb then ftab[15] :=ftab[2];
		if dkabcd = dkc then ftab[15] :=ftab[3];
		if dkabcd = dkd then ftab[15] :=ftab[4];
		if dkabcd = dkab then ftab[15] :=ftab[5];
		if dkabcd = dkac then ftab[15] :=ftab[6];
		if dkabcd = dkad then ftab[15] :=ftab[7];
		if dkabcd = dkbc then ftab[15] :=ftab[8];
		if dkabcd = dkbd then ftab[15] :=ftab[9];
		if dkabcd = dkcd then ftab[15] :=ftab[10];
		if dkabcd = dkabc then ftab[15] :=ftab[11];
		if dkabcd = dkabd then ftab[15] :=ftab[12];
		if dkabcd = dkbcd then ftab[15] :=ftab[13];
		if dkabcd = dkacd then ftab[15] :=ftab[14];
	end;
end;

procedure kesimpulan;
begin
	tampilan('Kesimpulan ANAVA 4 Jalur');
	f_tabel;

	if test_f1 >= ftab[1] then
	begin
		gotoxy(25,5);  write('Sumber variasi A       : Ada perbedaan signifikan ');
	end else
	begin
		gotoxy(25,5);  write('Sumber variasi A       : Tidak ada perbedaan signifikan');
	end;
	if test_f2 >= ftab[2] then
	begin
		gotoxy(25,6);  write('Sumber variasi B       : Ada perbedaan signifikan ')
	end else
	begin
		gotoxy(25,6);  write('Sumber variasi B       : Tidak ada perbedaan signifikan');
	end;

	if test_f3 >= ftab[3] then
	begin
		gotoxy(25,7);  write('Sumber variasi C       : Ada perbedaan signifikan ')
	end else
	begin
		gotoxy(25,7);  write('Sumber variasi C       : Tidak ada perbedaan signifikan');
	end;

	if test_f4 >= ftab[4] then
	begin
		gotoxy(25,8);  write('Sumber variasi D       : Ada perbedaan signifikan ')
	end else
	begin
		gotoxy(25,8);  write('Sumber variasi D       : Tidak ada perbedaan signifikan');
	end;

	if test_f5 >= ftab[5] then
	begin
		gotoxy(25,9);  write('Sumber variasi AxB     : Ada perbedaan signifikan ')
	end else
	begin
		gotoxy(25,9);  write('Sumber variasi AxB     : Tidak ada perbedaan signifikan');
	end;

	if test_f6 >= ftab[6] then
	begin
		gotoxy(25,10);  write('Sumber variasi AxC     : Ada perbedaan signifikan ')
	end else
	begin
		gotoxy(25,10);  write('Sumber variasi AxC     : Tidak ada perbedaan signifikan');
	end;

	if test_f7 >= ftab[7] then
	begin
		gotoxy(25,11);  write('Sumber variasi AxD     : Ada perbedaan signifikan ')
	end else
	begin
		gotoxy(25,11);  write('Sumber variasi AxD     : Tidak ada perbedaan signifikan');
	end;

	if test_f8 >= ftab[8] then
	begin
		gotoxy(25,12);  write('Sumber variasi BxC     : Ada perbedaan signifikan ')
	end else
	begin
		gotoxy(25,12);  write('Sumber variasi BxC     : Tidak ada perbedaan signifikan');
	end;

	if test_f9 >= ftab[9] then
	begin
		gotoxy(25,13);  write('Sumber variasi BxD     : Ada perbedaan signifikan ')
	end else
	begin
		gotoxy(25,13);  write('Sumber variasi BxD     : Tidak ada perbedaan signifikan');
	end;

	if test_f10 >= ftab[10] then
	begin
		gotoxy(25,14);  write('Sumber variasi CxD     : Ada perbedaan signifikan ')
	end else
	begin
		gotoxy(25,14);  write('Sumber variasi CxD     : Tidak ada perbedaan signifikan');
	end;

	if test_f11 >= ftab[11] then
	begin
		gotoxy(25,15);  write('Sumber variasi AxBxC   : Ada perbedaan signifikan ')
	end else
	begin
		gotoxy(25,15);  write('Sumber variasi AxBxC   : Tidak ada perbedaan signifikan');
	end;

	if test_f12 >= ftab[12] then
	begin
		gotoxy(25,16);  write('Sumber variasi AxBxD   : Ada perbedaan signifikan ')
	end else
	begin
		gotoxy(25,16);  write('Sumber variasi AxBxD   : Tidak ada perbedaan signifikan');
	end;

	if test_f13 >= ftab[13] then
	begin
		gotoxy(25,17);  write('Sumber variasi BxCxD   : Ada perbedaan signifikan ')
	end else
	begin
		gotoxy(25,17);  write('Sumber variasi BxCxD   : Tidak ada perbedaan signifikan');
	end;

	if test_f14 >= ftab[14] then
	begin
		gotoxy(25,18);  write('Sumber variasi AxCxD   : Ada perbedaan signifikan ')
	end else
	begin
		gotoxy(25,18);  write('Sumber variasi AxCxD   : Tidak ada perbedaan signifikan');
	end;

	if test_f15 >= ftab[15] then
	begin
		gotoxy(25,19);  write('Sumber variasi AxBxCxD : Ada perbedaan signifikan ')
	end else
	begin
		gotoxy(25,19);  write('Sumber variasi AxBxCxD : Tidak ada perbedaan signifikan');
	end;
end;


Begin
	01:
	warna(0,0,80,25,black);
	cbesar;
	repeat
		menu;
	until opsi1 in ['1','2','0'];
	if opsi1 = '0' then goto 01;
	if opsi1 = '2' then display_data;
	if opsi  = #27 then goto 01;
	sumtotal;
	sumabcd;
	dkmstest;
	clrscr;
	printing;
	clrscr;
	tampilan_anova;
	if ps = '2' then intr(5,reg);
	readln;
	clrscr;
	printing;
	ClrScr;
	kesimpulan;

	if ps = '2' then intr(5,reg);
	tekan_esc;
	opsi2 := readkey;
	if opsi2 = #27 then halt
	else goto 01;
end.

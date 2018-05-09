Program ANAVA_3;
uses crt,dos,stat_m;
const mbaris = 5; mkolom = 5;
type ibaris = 1..mbaris;
	ikolom = 1..mkolom;
	data_F = array[1..7] of real;
	data_kol = array[1..mkolom] of byte;
	data_x = array[ibaris,ibaris,ikolom,ikolom] of real;
var  i,j,k,l,kv1,kv2,kv3,replik,ntot,dka,dkb,dkc,dkd,
	dkab,dkac,dkbc,dkabc : byte;
	ftab : data_f;
	berkas : file of data_x;
	Jdata : file of byte;
	ps,opsi,opsi1,opsi2 : char;
	nama : string[14];
	x : data_x;
	kelvar : data_kol;
	sum_x,sum_x2,sum_tot,sum_bar,sum_ab,sum_ba,msa,msb,msc,msd,
	msab,msac,msbc,msabc,fkor,sum_xabc,sum_aa,sum_bb,sum_cc,
	sum_ac,sum_ca,sum_bc,sum_cb,sum_abc,sum_cba,sum_xa,sum_xb,
	sum_xc,sum_xd,sum_xab,sum_xac,sum_xbc,sum_a,sum_b,sum_c,sum_d,
	test_f1,test_f2,test_f3,test_f4,test_f5,test_f6,test_f7 : real;
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
	tampilan2('TABEL ANAVA 3 JALUR');
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
	gotoxy(4,9);  writeln('AxB');
	gotoxy(4,10); writeln('AxC');
	gotoxy(4,11); writeln('BxC');
	gotoxy(4,12); writeln('AxBxC');
	gotoxy(4,13); writeln('Dalam');
	garis_mendatar(14);
	gotoxy(4,15); writeln('Total');
	garis_mendatar(16);
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
	tampilan('ANAVA 3 jalur');
	gotoxy(1,3);
	write('Nama File : '); readln(nama);
	assign(jdata,nama+'xi.dat');
	assign(berkas,nama+'.dat');
	rewrite(jdata);
	rewrite(berkas);
	gotoxy(1,22);
	write('Banyak variabel                        : 3');
	for i := 1 to 3 do
	begin
		gotoxy(1,23); clreol;
		write('Banyak kelompok untuk variabel ke-',i,'    : '); readln(kelvar[i]);
	end;
	kv1 := kelvar[1]; kv2 := kelvar[2]; kv3 := kelvar[3];
	write(jdata,kv1); write(jdata,kv2); write(jdata,kv3);
	repeat
		gotoxy(1,24); clreol;
		write('Banyak replikasi untuk setiap kelompok : '); readln(replik);
	until replik > 1;
	write(jdata,replik);

	clrscr;
	tampilan('ANAVA 3 jalur');

	for i := 1 to kv1 do
	begin
		for j := 1 to kv2 do
		begin
			for k := 1 to kv3 do
			begin
				for l := 1 to replik do
				begin
					textcolor(l+9);
					gotoxy((19*(i-1))+8,kv3+1);      write('A',i);
					gotoxy(1,(kv3*j)+2); 		 write('B',j);
					gotoxy(3,(kv3*j)+k+1); 		 write('C',k);
					gotoxy((19*(i-1))+(8*l),(kv3*j)+k+1); write('-');
					gotoxy(1,24);
					write('Masukkan data(',i,j:2,k:2,l:2,') : '); readln(x[i,j,k,l]);
					{write(berkas,x);}
					gotoxy(1,24); clreol;
					gotoxy((19*(i-1))+(8*l),(kv3*j)+k+1);
					write(x[i,j,k,l]:3:4);
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
				for l := 1 to replik do
				begin
					write(berkas,x);
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
	tampilan('ANAVA 3 jalur');
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
		read(jdata,kv3); read(jdata,replik);
		for i := 1 to kv1 do
		begin
			for j := 1 to kv2 do
			begin
				for k := 1 to kv3 do
				begin
					for l := 1 to replik do
					begin
						read(berkas,x);
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
	tampilan('ANAVA 3 jalur');
	for i := 1 to kv1 do
	begin
		for j := 1 to kv2 do
		begin
			for k := 1 to kv3 do
			begin
				for l := 1 to replik do
				begin
					textcolor(l+9);
					gotoxy((19*(i-1))+8,(kv3)+1);         write('A',i);
					gotoxy(1,(kv3*j)+1+1); 			 write('B',j);
					gotoxy(3,(kv3*j)+k+1); 			 write('C',k);
					gotoxy((19*(i-1))+(8*l),(kv3*j)+k+1); write('-');
					gotoxy((19*(i-1))+(8*l),(kv3*j)+k+1);
					write(x[i,j,k,l]:3:2);
				end;
			end;
		end;
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
	gotoxy(27,3); write('        ANAVA 3 JALAN        ');
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
	sum_x := 0;
	sum_x2:= 0;
	for i := 1 to kv1 do
	begin
		for j := 1 to kv2 do
		begin
			for k := 1 to kv3 do
			begin
				for l := 1 to replik do
				begin
					sum_x := sum_x + x[i,j,k,l];
					sum_x2 := sum_x2 + sqr(x[i,j,k,l]);
				end;
			end;
		end;
	end;
	ntot := kv1*kv2*kv3*replik;
	fkor := sqr(sum_x)/ntot;
	sum_tot := sum_x2-fkor;

	sum_a := 0;
	for i := 1 to kv1 do
	begin
		sum_bar := 0;
		for j := 1 to kv2 do
		begin
			for k := 1 to kv3 do
			begin
				for l := 1 to replik do
				begin
					sum_bar := sum_bar + x[i,j,k,l];
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
				for l := 1 to replik do
				begin
					sum_bar := sum_bar + x[i,j,k,l];
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
				for l := 1 to replik do
				begin
					sum_bar := sum_bar + x[i,j,k,l];
				end;
			end;
		end;
		sum_cc := sqr(sum_bar)/(ntot/kv3);
		sum_c := sum_c + sum_cc;
	end;
	sum_c := sum_c-fkor;

	sum_ab := 0;
	for i := 1 to kv1 do
	begin
		for j := 1 to kv2 do
		begin
			sum_bar := 0;
			for k := 1 to kv3 do
			begin
				for l := 1 to replik do
				begin
					sum_bar := sum_bar + x[i,j,k,l];
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
				for l := 1 to replik do
				begin
					sum_bar := sum_bar + x[i,j,k,l];
				end;
			end;
			sum_ca := sqr(sum_bar)/(ntot/(kv1*kv3));
			sum_ac := sum_ac + sum_ca;
		end;
	end;
	sum_xac := sum_ac-fkor-sum_a-sum_c;

	sum_bc := 0;
	for j := 1 to kv2 do
	begin
		for k := 1 to kv3 do
		begin
			sum_bar := 0;
			for i := 1 to kv1 do
			begin
				for l := 1 to replik do
				begin
					sum_bar := sum_bar + x[i,j,k,l];
				end;
			end;
			sum_cb := sqr(sum_bar)/(ntot/(kv2*kv3));
			sum_bc := sum_bc + sum_cb;
		end;
	end;
	sum_xbc := sum_bc-fkor-sum_b-sum_c;

	sum_abc := 0;
	for i := 1 to kv1 do
	begin
		for j := 1 to kv2 do
		begin
			for k := 1 to kv3 do
			begin
				sum_bar := 0;
				for l := 1 to replik do
				begin
					sum_bar := sum_bar + x[i,j,k,l];
				end;
				sum_cba := sqr(sum_bar)/(ntot/(kv1*kv2*kv3));
				sum_abc := sum_abc + sum_cba;
			end;
		end;
	end;
	sum_xabc := sum_abc-fkor-sum_a-sum_b-sum_c-sum_xab-sum_xac-sum_xbc;

	sum_d := sum_tot-sum_a-sum_b-sum_c-sum_xab-sum_xac-sum_xbc-sum_xabc;

	dka  := kv1-1;
	dkb  := kv2-1;
	dkc  := kv3-1;

	dkab := dka*dkb;
	dkac := dka*dkc;
	dkbc := dkc*dkb;

	dkabc:= dka*dkb*dkc;

	dkd  := (ntot-1)-dka-dkb-dkc-dkab-dkac-dkbc-dkabc;

	msa  := sum_a/dka;
	msb  := sum_b/dkb;
	msc  := sum_c/dkc;

	msab := sum_xab/dkab;
	msac := sum_xac/dkac;
	msbc := sum_xbc/dkbc;
	msabc:= sum_xabc/dkabc;
	msd  := sum_d/dkd;

	test_f1 := msa/msd;
	test_f2 := msb/msd;
	test_f3 := msc/msd;
	test_f4 := msab/msd;
	test_f5 := msac/msd;
	test_f6 := msbc/msd;
	test_f7 := msabc/msd;

	clrscr;
	printing;
	clrscr;
	daftar_ANOVA;
	gotoxy(16,6);  writeln(dka:8);
	gotoxy(16,7);  writeln(dkb:8);
	gotoxy(16,8); writeln(dkc:8);
	gotoxy(16,9); writeln(dkab:8);
	gotoxy(16,10); writeln(dkac:8);
	gotoxy(16,11); writeln(dkbc:8);
	gotoxy(16,12); writeln(dkabc:8);
	gotoxy(16,13); writeln(dkd:8);
	gotoxy(16,15); writeln(ntot-1:8);

	gotoxy(33,6);  writeln(sum_a:10:4);
	gotoxy(33,7);  writeln(sum_b:10:4);
	gotoxy(33,8); writeln(sum_c:10:4);
	gotoxy(33,9); writeln(sum_xab:10:4);
	gotoxy(33,10); writeln(sum_xac:10:4);
	gotoxy(33,11); writeln(sum_xbc:10:4);
	gotoxy(33,12); writeln(sum_xabc:10:4);
	gotoxy(33,13); writeln(sum_d:10:4);
	gotoxy(33,15); writeln(sum_tot:10:4);

	gotoxy(50,6);  writeln(msa:10:4);
	gotoxy(50,7);  writeln(msb:10:4);
	gotoxy(50,8); writeln(msc:10:4);
	gotoxy(50,9); writeln(msab:10:4);
	gotoxy(50,10); writeln(msac:10:4);
	gotoxy(50,11); writeln(msbc:10:4);
	gotoxy(50,12); writeln(msabc:10:4);
	gotoxy(50,13); writeln(msd:10:4);
	gotoxy(50,15); writeln('-':6);

	gotoxy(65,6);  writeln(test_f1:10:4);
	gotoxy(65,7);  writeln(test_f2:10:4);
	gotoxy(65,8); writeln(test_f3:10:4);
	gotoxy(65,9); writeln(test_f4:10:4);
	gotoxy(65,10); writeln(test_f5:10:4);
	gotoxy(65,11); writeln(test_f6:10:4);
	gotoxy(65,12); writeln(test_f7:10:4);
	gotoxy(65,13); writeln('-':6);
	gotoxy(65,15); writeln('-':6);

	gotoxy(1,18);  write('F 0,95(',dka,';',dkd,') = '); readln(ftab[1]);
	if dkb <> dka then
	begin
		gotoxy(1,19);  write('F 0,95(',dkb,';',dkd,') = '); readln(ftab[2]);
	end else
	begin
		ftab[2] := ftab[1];
	end;
	if (dkc <> dkb) and (dkc <> dka) then
	begin
		gotoxy(1,20);  write('F 0,95(',dkc,';',dkd,') = '); readln(ftab[3]);
	end else
	begin
		if dkc = dka then ftab[3] :=ftab[1];
		if dkc = dkb then ftab[3] :=ftab[2];
	end;
	if (dkab <> dka) and (dkab <> dkb) and (dkab <> dkc) then
	begin
		gotoxy(1,21);  write('F 0,95(',dkab,';',dkd,') = '); readln(ftab[4]);
	end else
	begin
		if dkab = dka then ftab[4] :=ftab[1];
		if dkab = dkb then ftab[4] :=ftab[2];
		if dkab = dkc then ftab[4] :=ftab[3];
	end;
	if (dkac <> dka) and (dkac <> dkb) and (dkac <> dkc) and (dkac <> dkab) then
	begin
		gotoxy(1,22);  write('F 0,95(',dkac,';',dkd,') = '); readln(ftab[5]);
	end else
	begin
		if dkac = dka then ftab[5] :=ftab[1];
		if dkac = dkb then ftab[5] :=ftab[2];
		if dkac = dkc then ftab[5] :=ftab[3];
		if dkac = dkab then ftab[5] :=ftab[4];
	end;
	if (dkbc <> dka) and (dkbc <> dkb) and (dkbc <> dkc) and (dkbc <> dkab)
	and (dkbc <> dkac) then
	begin
		gotoxy(1,23);  write('F 0,95(',dkbc,';',dkd,') = '); readln(ftab[6]);
	end else
	begin
		if dkbc = dka then ftab[6] :=ftab[1];
		if dkbc = dkb then ftab[6] :=ftab[2];
		if dkbc = dkc then ftab[6] :=ftab[3];
		if dkbc = dkab then ftab[6] :=ftab[4];
		if dkbc = dkac then ftab[6] :=ftab[5];
	end;
	if (dkabc <> dka) and (dkabc <> dkb) and (dkabc <> dkc) and (dkabc <> dkab)
	and (dkabc <> dkac) and (dkabc <> dkbc) then
	begin
		gotoxy(1,24);  write('F 0,95(',dkabc,';',dkd,') = '); readln(ftab[7]);
	end else
	begin
		if dkabc = dka then ftab[7] :=ftab[1];
		if dkabc = dkb then ftab[7] :=ftab[2];
		if dkabc = dkc then ftab[7] :=ftab[3];
		if dkabc = dkab then ftab[7] :=ftab[4];
		if dkabc = dkac then ftab[7] :=ftab[5];
		if dkabc = dkbc then ftab[7] :=ftab[6];
	end;
	if test_f1 >= ftab[1] then
	begin
		gotoxy(25,18);  write('Sumber variasi A     : Ada perbedaan signifikan ');
	end else
	begin
		gotoxy(25,18);  write('Sumber variasi A     : Tidak ada perbedaan signifikan');
	end;
	if test_f2 >= ftab[2] then
	begin
		gotoxy(25,19);  write('Sumber variasi B     : Ada perbedaan signifikan ')
	end else
	begin
		gotoxy(25,19);  write('Sumber variasi B     : Tidak ada perbedaan signifikan');
	end;
	if test_f3 >= ftab[3] then
	begin
		gotoxy(25,20);  write('Sumber variasi C     : Ada perbedaan signifikan ')
	end else
	begin
		gotoxy(25,20);  write('Sumber variasi C     : Tidak ada perbedaan signifikan');
	end;
	if test_f4 >= ftab[4] then
	begin
		gotoxy(25,21);  write('Sumber variasi AxB   : Ada perbedaan signifikan ')
	end else
	begin
		gotoxy(25,21);  write('Sumber variasi AxB   : Tidak ada perbedaan signifikan');
	end;
	if test_f5 >= ftab[5] then
	begin
		gotoxy(25,22);  write('Sumber variasi AxC   : Ada perbedaan signifikan ')
	end else
	begin
		gotoxy(25,22);  write('Sumber variasi AxC   : Tidak ada perbedaan signifikan');
	end;
	if test_f6 >= ftab[6] then
	begin
		gotoxy(25,23);  write('Sumber variasi BxC   : Ada perbedaan signifikan ')
	end else
	begin
		gotoxy(25,23);  write('Sumber variasi BxC   : Tidak ada perbedaan signifikan');
	end;
	if test_f7 >= ftab[7] then
	begin
		gotoxy(25,24);  write('Sumber variasi AxBxC : Ada perbedaan signifikan ')
	end else
	begin
		gotoxy(25,24);  write('Sumber variasi AxBxC : Tidak ada perbedaan signifikan');
	end;
		  if ps = '2' then intr(5,reg);
	tekan_esc;
	opsi2 := readkey;
	if opsi2 = #27 then halt
	else goto 01;
end.

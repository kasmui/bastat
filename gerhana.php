<?php
    // File: gerhana.php
?>
<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <title>Gerhana Bulan & Matahari</title>
    <link rel="shortcut icon" href="https://falakmu.id/moon.png">
    <style>
        body {
            font-family: Arial, sans-serif;
            color: #f1f5f9;
            margin: 0;
            padding: 0;
        }
        header {
            background-color: #1e293b;
            color: white;
            padding: 2px;
            text-align: center;
        }
        .container {
            max-width: 1200px;
            margin: auto;
            padding: 2px;
            opacity: 0.8;
        }
        .section {
            margin-bottom: 3rem;
            background-color: #1e293b;
            border-radius: 8px;
            padding: 10px;
            box-shadow: 0 0 10px rgba(0,0,0,0.5);
        }
        h3 {
            color: #64748b;
        }
        label {
            display: block;
            margin-bottom: 0.5rem;
        }
        input[type="number"] {
            padding: 10px;
            width: 150px;
            margin-right: 1rem;
            border-radius: 4px;
            border: none;
        }
        button {
            padding: 10px 20px;
            background-color: #3b82f6;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }
        button:hover {
            background-color: #2563eb;
        }

        /* Styling khusus tabel gerhana bulan */
        #moon-output table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 1rem;
            background-color: #2f3e52;
            color: #f8fafc;
            font-size: 0.9rem;
            box-shadow: 0 0 10px rgba(255, 255, 255, 0.1);
        }
        #moon-output th, #moon-output td {
            padding: 0.75rem;
            border: 1px solid #475569;
            text-align: center;
        }
        #moon-output th {
            background-color: #1e3a8a;
            color: #dbeafe;
            text-transform: uppercase;
        }
        #moon-output tr:hover {
            background-color: #3b5b7a;
        }
        #moon-output td.kiri {
            text-align: left;
            padding-left: 2px;
        }

        /* Tabel Gerhana Matahari (tetap tidak diubah) */
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 1rem;
            background-color: #334155;
            font-size: 0.7rem;
            word-wrap: break-word;
        }
        th, td {
            padding: 10px 5px;
            border: 1px solid #475569;
            text-align: center;
        }
        th {
            background-color: #1e3a8a;
            color: white;
        }
        tr.year-different {
            background-color: #fde047;
            color: #1e293b;
            font-weight: bold;
        }
        .kiri {
            text-align: left;
        }

        #eclipseData table {
            background-color: #1e293b;
            color: #f1f5f9;
        }

        #eclipseData th {
            background-color: #3b82f6;
            color: #ffffff;
        }

        #eclipseData tr:nth-child(even) {
            background-color: #334155;
        }

        .footer {
            text-align: center;
            padding: 2px;
            background-color: #1e293b;
            color: #94a3b8;
            font-size: 0.9rem;
        }

        /* Notifikasi Gerhana Terdekat */
        #notif-section {
            background-color: #0f172a;
            border-left: 5px solid #3b82f6;
        }
        #eclipse-notification {
            padding: 1rem;
            font-size: 1.1rem;
        }
        .notif-box {
            margin-bottom: 1rem;
            padding: 1rem;
            border-radius: 6px;
            color: white;
        }
        .notif-solar {
            background-color: #ea580c; /* Oranye */
        }
        .notif-lunar {
            background-color: #6d28d9; /* Ungu */
        }
        .notif-urgent {
            background-color: #dc2626; /* Merah */
            animation: blinker 1s linear infinite;
        }
        @keyframes blinker {
            50% { opacity: 0.7; }
        }

        /* Responsif untuk layar kecil */
        @media (max-width: 768px) {
            table, thead, tbody, th, td, tr {
                display: block;
            }
            thead tr {
                position: absolute;
                top: -9999px;
                left: -9999px;
            }
            tr { border: 1px solid #ccc; }
            td {
                border: none;
                border-bottom: 1px solid #eee;
                position: relative;
                padding-left: 50%;
            }
            td:before {
                position: absolute;
                top: 6px;
                left: 6px;
                width: 45%;
                padding-right: 10px;
                white-space: nowrap;
            }

            td:nth-of-type(1):before { content: "Date (WIB)"; }
            td:nth-of-type(2):before { content: "Month"; }
            td:nth-of-type(3):before { content: "Day"; }
            td:nth-of-type(4):before { content: "Time (UTC)"; }
            td:nth-of-type(5):before { content: "GE"; }
            td:nth-of-type(6):before { content: "Saros"; }
            td:nth-of-type(7):before { content: "Type"; }
            td:nth-of-type(8):before { content: "Ec_Gamma"; }
            td:nth-of-type(9):before { content: "Ec_Mag."; }
            td:nth-of-type(10):before { content: "Lat."; }
            td:nth-of-type(11):before { content: "Long."; }
            td:nth-of-type(12):before { content: "Alt."; }
            td:nth-of-type(13):before { content: "Azim."; }
            td:nth-of-type(14):before { content: "Width"; }
            td:nth-of-type(15):before { content: "Duration"; }

            .container {
                padding: 1rem;
            }
        }

        tr.year-different {
            background-color: #fde047;
            color: #1e293b;
            font-weight: bold;
        }
    </style>
 <style>
    .glossary {
      width: 90%;
      margin: auto;
      background-color: #ffffff;
      border-radius: 8px;
      box-shadow: 0 0 10px rgba(0,0,0,0.1);
      padding: 20px;
      opacity: 0.8;
    }

    .term {
      margin-bottom: 20px;
      border-bottom: 1px solid #ddd;
      padding-bottom: 15px;
    }

    .term h2 {
      color: #2980b9;
      margin-top: 0;
    }

    .term p, li {
      margin-left: 20px;
      color: blue;
    }

    .example {
      color: #27ae60;
      font-style: italic;
      margin-top: 5px;
    }

    ul {
      margin-left: 20px;
    }

    li {
      margin-bottom: 5px;
    }
  </style>
</head>
<body background="https://webspace.science.uu.nl/~gent0113/islam/images/surat_al_ikhlas.gif"  bgproperties="fixed" oncontextmenu="return false;">
<script>
    document.addEventListener('contextmenu', function(e) {
        e.preventDefault();
    });
    document.addEventListener('keydown', function(e) {
        if (e.ctrlKey && (e.keyCode === 85 || e.keyCode === 73 || e.keyCode === 74 || e.keyCode === 83)) {
            e.preventDefault();
        }
    });
</script>
<header>
    <h1>Informasi Gerhana Bulan & Matahari</h1>
</header>
<div class="container">
    <!-- Pencarian Gerhana Bulan -->
    <div class="section">
        <h3>Cari Gerhana Bulan Berdasarkan Tahun</h3>
        <label for="yearInput">Tahun:</label>
        <input type="number" id="yearInput" value="2025">
        <button style="margin-bottom: 10px; padding: 10px;" onclick="CariGerhana()">Cari</button>
        <br/>
        <div  id="moon-output"></div>
    </div>

    <!-- Tabel Data Gerhana Matahari -->
    <div class="section">
        <h3 style="padding: 10px;">Data Gerhana Matahari (2023 - 2032)</h3>
        <p style="color: #cbd5e1; text-align: justify; padding: 10px;">
            Berikut adalah daftar gerhana matahari dari tahun 2023 hingga 2032. Kolom "Date (WIB)" menunjukkan waktu puncak gerhana dalam Waktu Indonesia Barat (UTC+7).
        </p>
        <div style="padding: 10px;" id="eclipseData"></div>
    </div>
</div>


  <h1 style="color: blue; text-align: center;">Penjelasan Istilah dalam Tabel Data Gerhana</h1>

  <div class="glossary">

    <div class="term">
      <h2>GE (Gamma Earth)</h2>
      <p><strong>Penjelasan:</strong> Nilai Ec_Gamma atau sering disebut sebagai Gamma dalam konteks gerhana adalah jarak tegak lurus dari pusat Bumi ke jalur konus bayangan Bulan (untuk gerhana matahari) atau jarak dari pusat Bulan ke pusat konus bayangan Bumi (untuk gerhana bulan), dinyatakan dalam satuan radius ekuator Bumi.</p>
      <p class="example"><strong>Nilai positif/negatif:</strong> Menunjukkan arah deviasi dari pusat bumi terhadap jalur bayangan, biasanya digunakan untuk memprediksi jenis dan visibilitas gerhana.</p>
    </div>

    <div class="term">
      <h2>Saros</h2>
      <p><strong>Penjelasan:</strong> Saros adalah siklus periodik sekitar 18 tahun 11 hari, di mana kondisi astronomis (posisi Matahari, Bulan, dan Bumi) kembali hampir sama. Setiap gerhana termasuk dalam suatu deret Saros tertentu, sehingga memiliki karakteristik serupa dengan gerhana-gerhana lain dalam deret tersebut.</p>
      <p class="example"><strong>Contoh:</strong> Gerhana pertama dalam tabel berada dalam deret Saros ke-288.</p>
    </div>

    <div class="term">
      <h2>Type</h2>
      <p><strong>Penjelasan:</strong> Jenis gerhana. Dapat berupa:</p>
      <ul>
        <li><strong>T (Total):</strong> Bulan/Matahari sepenuhnya tertutup oleh bayangan.</li>
        <li><strong>A (Annular):</strong> Gerhana cincin, Bulan berada di titik apogee sehingga tampak lebih kecil dari Matahari, menyisakan cincin terang.</li>
        <li><strong>H (Hybrid):</strong> Jenis transisi antara total dan annular, tergantung lokasi pengamat.</li>
        <li><strong>P (Partial):</strong> Hanya sebagian dari Bulan/Matahari tertutup bayangan.</li>
      </ul>
    </div>

    <div class="term">
      <h2>Ec_Mag (Eclipse Magnitude)</h2>
      <p><strong>Penjelasan:</strong> Jumlah maksimum bagian dari piringan Matahari/Bulan yang tertutup selama gerhana. Untuk gerhana matahari, ini menunjukkan fraksi diameter Matahari yang tertutup oleh Bulan. Untuk gerhana bulan, ini adalah fraksi diameter Bulan yang masuk ke dalam bayangan Bumi.</p>
    </div>

    <div class="term">
      <h2>Lat. (Latitude)</h2>
      <p><strong>Penjelasan:</strong> Garis lintang geografis di permukaan Bumi tempat jalur gerhana melewati titik tengahnya pada waktu maksimum gerhana.</p>
      <p class="example"><strong>Contoh:</strong> -9.6S artinya 9.6° Lintang Selatan.</p>
    </div>

    <div class="term">
      <h2>Long. (Longitude)</h2>
      <p><strong>Penjelasan:</strong> Garis bujur geografis di permukaan Bumi tempat jalur gerhana melewati titik tengahnya pada waktu maksimum gerhana.</p>
      <p class="example"><strong>Contoh:</strong> 125.8E artinya 125.8° Bujur Timur.</p>
    </div>

    <div class="term">
      <h2>Alt. (Altitude of the Sun)</h2>
      <p><strong>Penjelasan:</strong> Ketinggian sudut Matahari di langit (dari horizon) saat gerhana mencapai maksimum di lokasi tersebut, dalam satuan derajat.</p>
      <p class="example"><strong>Contoh:</strong> 67° berarti Matahari berada cukup tinggi di langit.</p>
    </div>

    <div class="term">
      <h2>Azim. (Azimuth of the Sun)</h2>
      <p><strong>Penjelasan:</strong> Arah posisi Matahari di langit relatif terhadap utara geografis saat gerhana maksimum, dalam satuan derajat.</p>
      <p class="example"><strong>Contoh:</strong> 334° berarti Matahari berada di arah sekitar barat laut.</p>
    </div>

    <div class="term">
      <h2>Width</h2>
      <p><strong>Penjelasan:</strong> Lebar jalur gerhana total atau cincin di permukaan Bumi, dalam kilometer.</p>
      <p class="example"><strong>Contoh:</strong> 49 km adalah lebar jalur gerhana total.</p>
    </div>

    <div class="term">
      <h2>Duration</h2>
      <p><strong>Penjelasan:</strong> Durasi gerhana total atau cincin, yaitu lamanya fase total/cincin berlangsung pada lokasi yang optimal.</p>
      <p class="example"><strong>Contoh:</strong> 01m16s berarti 1 menit 16 detik durasi fase total.</p>
    </div>
  </div>

<footer class="footer" style="margin-top: 50px;">
    &copy; <?= date('Y') ?> - <a href="https://eclipse.gsfc.nasa.gov/" target="_bank" style="color: white;" >https://eclipse.gsfc.nasa.gov/</a>
</footer>

<!-- Script Astronomy -->
<script src="https://falakmu.id/astronomy.browser.js"></script>

<!-- JavaScript Utama -->
<script>
    function Pad(s, w) {
        s = s.toFixed(0);
        while (s.length < w) {
            s = '0' + s;
        }
        return s;
    }

    function FormatDate(t) {
        const wibOffset = 7 * 60 * 60 * 1000;
        const wibDate = new Date(t.date.getTime() + wibOffset);
        var year = Pad(wibDate.getUTCFullYear(), 4);
        var month = Pad(1 + wibDate.getUTCMonth(), 2);
        var day = Pad(wibDate.getUTCDate(), 2);
        var hour = Pad(wibDate.getUTCHours(), 2);
        var minute = Pad(wibDate.getUTCMinutes(), 2);
        var second = Pad(wibDate.getUTCSeconds(), 2);
        return `${year}-${month}-${day} ${hour}:${minute}:${second} WIB`;
    }

    function PrintEclipse(e) {
        const MINUTES_PER_DAY = 24 * 60;
        const output = document.getElementById('moon-output');

        // Hapus konten lama jika belum ada tabel
        if (!output.querySelector('table')) {
            output.innerHTML = '';
            output.innerHTML = `
                <table id="moon-table">
                    <tr><th>Waktu</th><th>Keterangan</th></tr>
                </table>`;
        }

        const table = output.querySelector('#moon-table');

        const p1 = e.peak.AddDays(-e.sd_partial / MINUTES_PER_DAY);
        table.innerHTML += `<tr><td class="kiri">${FormatDate(p1)}</td><td>Gerhana parsial mulai</td></tr>`;

        if (e.sd_total > 0) {
            const t1 = e.peak.AddDays(-e.sd_total / MINUTES_PER_DAY);
            table.innerHTML += `<tr><td>${FormatDate(t1)}</td><td>Gerhana total mulai</td></tr>`;
        }

        table.innerHTML += `<tr><td>${FormatDate(e.peak)}</td><td>Puncak gerhana ${e.kind}</td></tr>`;

        if (e.sd_total > 0) {
            const t2 = e.peak.AddDays(+e.sd_total / MINUTES_PER_DAY);
            table.innerHTML += `<tr><td>${FormatDate(t2)}</td><td>Gerhana total berakhir</td></tr>`;
        }

        const p2 = e.peak.AddDays(+e.sd_partial / MINUTES_PER_DAY);
        table.innerHTML += `<tr><td>${FormatDate(p2)}</td><td>Gerhana parsial berakhir</td></tr>`;
    }

    function ParseDate(text) {
        const d = new Date(text);
        if (!Number.isFinite(d.getTime())) {
            document.getElementById('moon-output').innerHTML += `ERROR: Not a valid date: "${text}"<br>`;
            return null;
        }
        return d;
    }

    function CariGerhana() {
        const yearInput = document.getElementById('yearInput').value;
        const date = new Date(`${yearInput}-01-01T00:00:00Z`);
        const output = document.getElementById('moon-output');
        output.innerHTML = '';

        if (!Number.isNaN(date.getTime())) {
            let count = 0;
            let eclipse = Astronomy.SearchLunarEclipse(date);

            for (;;) {
                if (eclipse.kind !== Astronomy.EclipseKind.Penumbral) {
                    PrintEclipse(eclipse);
                    if (++count === 10) break;
                }
                eclipse = Astronomy.NextLunarEclipse(eclipse.peak);
            }
        } else {
            output.innerHTML = `ERROR: Tahun tidak valid: "${yearInput}"<br>`;
        }
    }
</script>

<!-- Script Tabel Data Gerhana Matahari -->
<script>
    const eclipseDataText = `
        2023 Apr 20  04:17:56     73    288  H   -0.3952  1.0132   9.6S 125.8E  67 334   49  01m16s
        2023 Oct 14  18:00:41     74    294  A    0.3753  0.9520  11.4N  83.1W  68 208  187  05m17s
        2024 Apr 08  18:18:29     74    300  T    0.3431  1.0566  25.3N 104.1W  70 149  198  04m28s
        2024 Oct 02  18:46:13     74    306  A   -0.3509  0.9326  22.0S 114.5W  69  31  266  07m25s
        2025 Mar 29  10:48:36     75    312  P    1.0405  0.9376  61.1N  77.1W   0  83
        2025 Sep 21  19:43:04     75    318  P   -1.0651  0.8550  60.9S 153.5E   0  89
        2026 Feb 17  12:13:06     75    323  A   -0.9743  0.9630  64.7S  86.8E  12 268  616  02m20s
        2026 Aug 12  17:47:06     75    329  T    0.8977  1.0386  65.2N  25.2W  26 248  294  02m18s
        2027 Feb 06  16:00:48     76    335  A   -0.2952  0.9281  31.3S  48.5W  73 334  282  07m51s
        2027 Aug 02  10:07:50     76    341  T    0.1421  1.0790  25.5N  33.2E  82 202  258  06m23s
        2028 Jan 26  15:08:59     76    347  A    0.3901  0.9208   3.0N  51.5W  67 161  323  10m27s
        2028 Jul 22  02:56:40     77    353  T   -0.6056  1.0560  15.6S 126.7E  53  17  230  05m10s
        2029 Jan 14  17:13:48     77    359  P    1.0553  0.8714  63.7N 114.2W   0 145
        2029 Jun 12  04:06:13     77    364  P    1.2943  0.4576  66.8N  66.2W   0 355
        2029 Jul 11  15:37:19     77    365  P   -1.4191  0.2303  64.3S  85.6W   0  30
        2029 Dec 05  15:03:58     77    370  P   -1.0609  0.8911  67.5S 135.7E   0 177
        2030 Jun 01  06:29:13     78    376  A    0.5626  0.9443  56.5N  80.1E  55 176  250  05m21s
        2030 Nov 25  06:51:37     78    382  T   -0.3867  1.0468  43.6S  71.2E  67   7  169  03m44s
        2031 May 21  07:16:04     78    388  A   -0.1970  0.9589   8.9N  71.7E  79 354  152  05m26s
        2031 Nov 14  21:07:31     79    394  H    0.3078  1.0106   0.6S 137.6W  72 189   38  01m08s
        2032 May 09  13:26:42     79    400  A   -0.9375  0.9957  51.3S   7.1W  20 345   44  00m22s
        2032 Nov 03  05:34:13     79    406  P    1.0643  0.8554  70.4N 132.6E   0 218
    `;
    const eclipseDataLines = eclipseDataText.trim().split('\n');
    const table = document.createElement('table');
    const headerRow = table.insertRow(0);
    const headers = ['Date (WIB)', 'Month', 'Day', 'Time (UTC)', 'GE', 'Saros', 'Type', 'Ec_Gamma', 'Ec_Mag.', 'Lat.', 'Long.', 'Alt.', 'Azim.', 'Width', 'Duration'];
    headers.forEach((headerText, index) => {
        const header = document.createElement('th');
        header.innerHTML = headerText;
        headerRow.appendChild(header);
    });
    let currentYear = null;
    eclipseDataLines.forEach((line) => {
        const parts = line.trim().split(/\s+/);
        if (parts.length >= 15) {
            const row = table.insertRow();
            for (let i = 0; i < 15; i++) {
                const cell = row.insertCell(i);
                if (i === 0) {
                    const utcTime = parts.slice(0, 4).join(' ');
                    const wibOffset = 7 * 60 * 60 * 1000;
                    const utcDate = new Date(utcTime);
                    const wibDate = new Date(utcDate.getTime() + wibOffset);
                    cell.innerHTML = wibDate.toLocaleString('en-US', { timeZone: 'Asia/Jakarta' });
                    cell.style.textAlign = 'left';
                    const year = wibDate.getFullYear();
                    if (currentYear !== year) {
                        row.classList.add("year-different");
                        currentYear = year;
                    }
                } else {
                    cell.innerHTML = parts[i];
                }
            }
        }
    });
    const eclipseDataContainer = document.getElementById('eclipseData');
    eclipseDataContainer.appendChild(table);
</script>

<!-- Script untuk Notifikasi Gerhana Terdekat -->
<script>
    function FormatDateWIB(date) {
        const wibOffset = 7 * 60 * 60 * 1000;
        const wibDate = new Date(date.getTime() + wibOffset);
        return wibDate.toLocaleString('id-ID', { timeZone: 'Asia/Jakarta' });
    }
    function getClosestEclipses() {
        const now = new Date();
        const oneYearFromNow = new Date(now.getTime() + 365 * 24 * 60 * 60 * 1000);
        const container = document.getElementById("eclipse-notification");
        container.innerHTML = 'Memuat data...';
        let nextSolar = null;
        let nextLunar = null;
        try {
            nextSolar = Astronomy.SearchSolarEclipse(now);
            nextLunar = Astronomy.SearchLunarEclipse(now);
        } catch (e) {
            container.innerHTML = `<p style="color:red;">Error memuat data gerhana: ${e.message}</p>`;
            return;
        }
        if (nextSolar && nextSolar.peak <= oneYearFromNow) {
            const daysLeft = Math.ceil((nextSolar.peak - now) / (1000 * 60 * 60 * 24));
            let className = "notif-box notif-solar";
            if (daysLeft < 7) className = "notif-box notif-urgent";
            else if (daysLeft < 30) className = "notif-box notif-solar";
            container.innerHTML += `
                <div class="${className}">
                    â›… Gerhana Matahari Terdekat<br/>
                    Puncak: ${FormatDateWIB(nextSolar.peak)}<br/>
                    Tersisa: <strong>${daysLeft} hari</strong><br/>
                    Jenis: ${nextSolar.kind}
                </div>`;
        } else {
            container.innerHTML += `<p>Tidak ada gerhana matahari dalam 1 tahun ke depan.</p>`;
        }
        if (nextLunar && nextLunar.peak <= oneYearFromNow) {
            const daysLeft = Math.ceil((nextLunar.peak - now) / (1000 * 60 * 60 * 24));
            let className = "notif-box notif-lunar";
            if (daysLeft < 7) className = "notif-box notif-urgent";
            else if (daysLeft < 30) className = "notif-box notif-lunar";
            container.innerHTML += `
                <div class="${className}">
                    ðŸŒ• Gerhana Bulan Terdekat<br/>
                    Puncak: ${FormatDateWIB(nextLunar.peak)}<br/>
                    Tersisa: <strong>${daysLeft} hari</strong><br/>
                    Jenis: ${nextLunar.kind}
                </div>`;
        } else {
            container.innerHTML += `<p>Tidak ada gerhana bulan dalam 1 tahun ke depan.</p>`;
        }
    }
    window.onload = getClosestEclipses;
</script>
</body>
</html>

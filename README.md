# REPOSITORI TUGAS KELOMPOK FINAL PROJECT A09

## Nama anggota:

1. Fauziah Putri Fajrianti - 2106707435
2. Hizkia Sebastian Ginting - 2106750881
3. Laura Glory Evangeline Sihombing - 2106751751
4. Muhamnad Fariz Eda Andhika - 2106653546
5. Made Indri Maharani Natiadewi - 2106704295
6. Rathina Shabur - 2106651906
7. Syadza Nayla Arrana Desvianto - 2106634055


## Link App Railway
Link: https://wazzt.up.railway.app/

## Penjelasan Aplikasi
### Judul Aplikasi:	
Wazzt
### Topics: 	
Environment & Climate Sustainability

Forum The Group of Twenty (G20) merupakan suatu himpunan antara 20 negara dunia yang aktif membahas isu-isu penting di dunia. G20 memiliki kelompok kerja yang fokus pada bidang Environment & Climate Sustainability. Kelompok ini bertujuan untuk mempercepat transisi energi, ekonomi hijau, dan environmental sustainability. Beberapa misi dari kelompok ini adalah memerangi punahnya keanekaragaman hayati dan meningkatkan kualitas udara.

Banyaknya jumlah masyarakat dan sampah yang dihasilkan berdampak pada kesejahteraan lingkungan manusia dan bahkan untuk makhluk hidup lainnya. Data menunjukkan, bahwa setiap tahunnya dihasilkan 2.12 miliar ton sampah, yang 33% darinya tidak diolah dengan baik dan mengganggu lingkungan. Banyak hewan-hewan yang terganggu lingkungan hidupnya karena sampah, yang mengakibatkan kematian bagi hewan-hewan tersebut. Sampah-sampah yang menumpuk pada udara terbuka dan tidak diolah dengan baik menghasilkan gas metana yang merupakan salah satu gas yang dapat menjadi salah satu faktor terjadinya perubahan iklim yang ekstrim sehingga berdampak juga terhadap pemanasan global.

Maka dari itu, sebagai bentuk aksi untuk ikut berkontribusi dalam mencapai Environment & Climate Sustainability, kami membuat aplikasi Wazzt. Aplikasi ini bertujuan untuk mengatasi permasalahan sampah di Indonesia sekaligus memotivasi warga untuk memilah sampah dengan menyediakan sistem point reward & leaderboard.

## Modul yang diimplementasikan
1. Login/Logout/Sign Up akan dikerjakan oleh Fauziah Putri Fajrianti
    - Login: username, email, password
    - Sign up untuk user biasa: nama, username, umur, jenis kelamin, email, password, domisili
    - Sign up untuk user bank sampah: nama institusi, email, password, domisili, alamat lengkap
    - Logout
2. Forum akan dikerjakan oleh Hizkia Sebastian Ginting
    - Daftar Pertanyaan
    - Form pertanyaan
    - Form menjawab
3. Profile akan dikerjakan oleh Rathina Shabur
    - Lihat profile
    - Edit profile
4. Home & Leaderboard untuk user akan dikerjakan oleh Made Indri Maharani Natiadewi
    - Home: About us, Daftar Bank sampah (berupa card-card), visi misi
    - Leaderboard: berupa tabel yang isinya ada peringkat, nama, domisili, berat sampah total
5. Form upload deskripsi bank sampah & Halaman detail bank sampah akan dikerjakan oleh Syadza Nayla Arrana Desvianto
    - Form upload: judul, tanggal, image, deskripsi
    - Halaman detail: informasi umum bank sampah, deskripsi-deskripsi yang sudah di-upload
6. Form mennyumbang sampah & history akan dikerjakan oleh Muhamnad Fariz Eda Andhika
    - Form: jenis sampah, berat sampah
    - History: nama bank sampah, berat sampah, tanggal penyumbangan, poin
7. Tukar poin akan dikerjakan oleh Laura Glory Evangeline Sihombing
    - Poin Anda -> berkurang
    - Voucher Anda (daftar voucher)
    - List Voucher

## Role atau peran pengguna beserta deskripsinya
1. User Non-Login:
    - About us
    - Login/Sign up
    - Contact information
    - Daftar bank sampah
2. User biasa:
    - Login/Logout dan Sign Up
    - Forum
    - Profile
    - Daftar bank sampah
    - History setiap pengguna
    - Leaderboard
    - Form jenis sampah untuk poin
    - Tukar poin
5. User Bank Sampah:
    - Login/Logout dan Sign Up
    - Profile
    - Forum
    - Mengupload deskripsi


## Integrasi dengan Web Service
1. Melengkapi end point pada web untuk tiap modul (baik untuk mengambil dan mengirim data)
2. Menambahkan middleware di Django agar API dapat diakses dari luar website
3. Membuat fungsi async untuk setiap proses yang berkaitan dengan mengambil, mengirim, ataupun mengubah data
4. Untuk mengambil data akan digunakan http.GET dari end point data di web yang hasil pemanggilannya akan digunakan untuk ditampilkan pada widget yang digunakan
5. Untuk mengirim data akan digunakan http.POST yang menuju ke end point untuk menyimpan data yang disimpan di database Django

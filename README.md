Tugas 9

Nomor 1 : Jelaskan mengapa kita perlu membuat model Dart saat mengambil/mengirim data JSON? Apa konsekuensinya jika langsung memetakan Map<String, dynamic> tanpa model (terkait validasi tipe, null-safety, maintainability)?

Pembuatan model Dart diperlukan untuk memetakan data JSON dari server menjadi objek yang terstruktur, memastikan tipe data yang benar, dan memudahkan akses properti melalui fitur autocomplete di IDE. Jika kita langsung menggunakan Map<String, dynamic>, kita kehilangan fitur validasi tipe otomatis dan compile-time checks, sehingga rentan terjadi runtime error akibat kesalahan penulisan key atau ketidaksesuaian tipe data, dan juga mempersulit proses maintenance karena kode menjadi kurang terbaca dan lebih sulit didesain untuk menangani nilai null dengan aman.


Nomor 2 : Apa fungsi package http dan CookieRequest dalam tugas ini? Jelaskan perbedaan peran http vs CookieRequest. 

Package http digunakan untuk melakukan HTTP request seperti GET, POST, dan DELETE. Sementara CookieRequest digunakan untuk menyimpan dan mengelola cookie session Django. Perbedaan perannya adalah http berfungsi untuk mengakses endpoint biasa, sedangkan CookieRequest digunakan untuk endpoint yang memerlukan session, seperti autentikasi.


Nomor 3 : Jelaskan mengapa instance CookieRequest perlu untuk dibagikan ke semua komponen di aplikasi Flutter.

Instance CookieRequest perlu dibagikan ke seluruh komponen aplikasi karena objek ini bertugas menyimpan cookie sesi login yang unik untuk pengguna saat ini. Jika setiap halaman atau komponen membuat instance baru sendiri-sendiri, maka informasi login (cookie) tidak akan tersimpan secara konsisten, yang mengakibatkan server menganggap pengguna belum terautentikasi saat berpindah antar halaman.


Nomor 4 : Jelaskan konfigurasi konektivitas yang diperlukan agar Flutter dapat berkomunikasi dengan Django. Mengapa kita perlu menambahkan 10.0.2.2 pada ALLOWED_HOSTS, mengaktifkan CORS dan pengaturan SameSite/cookie, dan menambahkan izin akses internet di Android? Apa yang akan terjadi jika konfigurasi tersebut tidak dilakukan dengan benar? 

Konfigurasi 10.0.2.2 pada ALLOWED_HOSTS diperlukan agar emulator Android dapat mengakses localhost komputer, jika tidak ditambahkan, Django akan menganggap request dari Flutter tidak sah karena host tidak terdaftar.  CORS dan pengaturan SameSite/cookie juga diperlukan agar aplikasi Django dapat berbagi resource dan mengirim cookie ke aplikasi Flutter yang berasal dari origin berbeda, jika tidak ditambahkan, aplikasi web dan mobile tidak dapat saling berkomunikasi. Yang terakhir, menambahkan izin akses internet di Android juga diperlukan karena akses jaringan dimatikan secara default pada Android demi keamanan. Jika konfigurasi ini tidak dilakukan atau salah, aplikasi akan mengalami kegagalan koneksi seperti Connection Refused, pemblokiran oleh browser karena kebijakan keamanan, atau aplikasi Android akan crash saat mencoba mengakses jaringan.


Nomor 5 : Jelaskan mekanisme pengiriman data mulai dari input hingga dapat ditampilkan pada Flutter. 

Mekanisme ini dimulai saat pengguna mengisi input pada form di Flutter, kemudian data divalidasi dan dikonversi menjadi format JSON. Data JSON tersebut dikirim melalui request HTTP POST ke server Django, yang kemudian memproses dan menyimpannya ke database. Setelah server memberikan respons sukses, aplikasi Flutter akan melakukan request ulang (GET) untuk mengambil data terbaru, mengubah JSON yang diterima menjadi objek Model Dart, dan akhirnya memperbarui tampilan (UI) untuk memunculkan data tersebut kepada pengguna.


Nomor 6 : Jelaskan mekanisme autentikasi dari login, register, hingga logout. Mulai dari input data akun pada Flutter ke Django hingga selesainya proses autentikasi oleh Django dan tampilnya menu pada Flutter. 

Proses autentikasi dimulai ketika pengguna membuka aplikasi, jika belum terdaftar, pengguna mengisi form registrasi yang kemudian dikirimkan oleh Flutter melalui metode HTTP POST ke Django untuk divalidasi dan disimpan ke dalam database. Setelah akun dibuat, pengguna melakukan login dengan mengirimkan kredensial (username dan password) ke server, di mana Django akan memverifikasi kecocokan data tersebut. Jika valid, Django membuat session cookie dan mengirimkannya kembali ke Flutter melalui instans CookieRequest sebagai penanda bahwa pengguna telah berhasil masuk. Dengan tersimpannya sesi ini, aplikasi menampilkan menu utama, dan proses diakhiri saat pengguna memilih opsi logout, di mana Flutter mengirimkan permintaan ke Django untuk menghapus sesi aktif tersebut dan mengembalikan pengguna ke halaman awal login.


Nomor 7 : Jelaskan bagaimana cara kamu mengimplementasikan checklist di atas secara step-by-step! (bukan hanya sekadar mengikuti tutorial).


Memastikan deployment proyek tugas Django kamu telah berjalan dengan baik: Langkah pertama, saya memastikan backend di PWS sudah terdeploy dengan benar. Saya melakukan git add, commit, push ke repositori PWS, lalu mengecek manual lewat browser untuk menjamin semua perubahan fitur sudah berjalan sesuai rencana di server.

Mengimplementasikan fitur registrasi akun pada proyek tugas Flutter: Saya membuat halaman register di Flutter dan menyiapkan endpoint khusus di Django. Tujuannya supaya aplikasi Flutter bisa mengirim data pengguna baru lewat POST request, dan data tersebut langsung tersimpan rapih di database Django.

Membuat halaman login pada proyek tugas Flutter: Saya membuat halaman login di Flutter dan menghubungkannya dengan endpoint login yang sudah saya buat di Django. Jadi nanti saat pengguna memasukkan username dan password, Flutter bisa menerima session cookie dari server sebagai tanda akses masuk berhasil.

Mengintegrasikan sistem autentikasi Django dengan proyek tugas Flutter: Supaya fitur login, register, dan logout sinkron, saya mengatur logika views nya di Django dulu. Di sisi Flutter, saya pakai CookieRequest dan membagikannya ke seluruh aplikasi, jadi status login (sesi) pengguna tetap terjaga di halaman mana pun.

Membuat model kustom sesuai dengan proyek aplikasi Django: Saya membuat file model products_entry.dart yang isinya menyesuaikan struktur data di Django. Langkah ini penting banget supaya data JSON yang diambil dari server bisa diparse jadi objek Dart dengan mudah dan tipenya aman.

Membuat halaman yang berisi daftar semua item yang terdapat pada endpoint JSON di Django yang telah kamu deploy: Saya menyiapkan endpoint JSON di Django berisi data produk, lalu membuat halaman list di Flutter untuk mengambil data tersebut. Biar tampilannya bagus, saya bikin widget card kustom yang isinya info penting kayak nama, harga, kategori, dll.

Membuat halaman detail untuk setiap item yang terdapat pada halaman daftar Item: Setiap kartu produk saya kasih fungsi onTap. Jadi kalau diklik, dia bakal pindah ke halaman detail pakai Navigator.push() sambil membawa data produknya. Di halaman detail itu, semua info lengkap produk ditampilkan, dan ada tombol back bawaan buat balik ke daftar sebelumnya.

Melakukan filter pada halaman daftar item dengan hanya menampilkan item yang terasosiasi dengan pengguna yang login: Saya menambahkan implementasi untuk My Products, dan melakukan pengecekan berdasarkan user ID yang diperoleh setelah proses login. Setelah login berhasil, Flutter mengirim permintaan ke endpoint /get_user/ untuk mengambil data pengguna, lalu menyimpan id tersebut ke dalam request.jsonData. Kemudian, pada halaman daftar produk, saya memodifikasi fungsi fetchProducts() sehingga ketika mode My Products aktif (showMine = true), data produk akan difilter menggunakan kondisi p.userId == currentUserId. Dengan demikian, hanya produk yang dibuat oleh pengguna yang sedang login yang akan ditampilkan di halaman My Products, sedangkan Products Entry List tetap menampilkan semua produk. Selain itu, saya juga menambahkan tombol filter. Jadi saat sedang berada di halaman All Products dan kita klik tombol filter tersebut, maka akan berpindah ke My Products, dan sebaliknya.



Tugas 8


Nomor 1 : Jelaskan perbedaan antara Navigator.push() dan Navigator.pushReplacement() pada Flutter. Dalam kasus apa sebaiknya masing-masing digunakan pada aplikasi Football Shop kamu?


Navigator.push() digunakan untuk menambahkan halaman baru di atas tumpukan (stack) halaman yang sedang aktif sehingga pengguna masih dapat kembali ke halaman sebelumnya menggunakan tombol “back”. Sementara itu, Navigator.pushReplacement() menggantikan halaman yang sedang aktif dengan halaman baru dan menghapus halaman lama dari tumpukan, sehingga pengguna tidak dapat kembali ke halaman sebelumnya. Dalam konteks aplikasi Football Shop punya saya, Navigator.push() sebaiknya digunakan ketika kita ingin membuka halaman yang bersifat sementara, seperti melihat detail produk dari daftar produk. Sedangkan Navigator.pushReplacement() cocok digunakan ketika kita ingin mengganti halaman secara permanen, misalnya setelah pengguna berhasil login atau logout sehingga tidak bisa kembali ke halaman sebelumnya. (Sumber: Flutter Official Documentation - Navigation and Routing)


Nomor 2 : Bagaimana kamu memanfaatkan hierarchy widget seperti Scaffold, AppBar, dan Drawer untuk membangun struktur halaman yang konsisten di seluruh aplikasi?


Hierarchy widget seperti Scaffold, AppBar, dan Drawer dimanfaatkan untuk menjaga konsistensi tampilan di seluruh aplikasi. Scaffold berperan sebagai kerangka utama yang menampung struktur dasar halaman seperti AppBar di bagian atas, Drawer di sisi kiri, dan body sebagai konten utama. AppBar digunakan untuk menampilkan judul halaman serta tombol aksi, sementara Drawer berfungsi sebagai menu navigasi yang memudahkan pengguna berpindah antarhalaman dengan cepat. Dengan menempatkan komponen-komponen ini secara konsisten pada setiap halaman, kita dapat menciptakan pengalaman pengguna yang seragam, mudah digunakan, dan memiliki struktur visual yang rapih di seluruh bagian aplikasi. (Sumber: Flutter.dev - Scaffold class documentation)


Nomor 3 : Dalam konteks desain antarmuka, apa kelebihan menggunakan layout widget seperti Padding, SingleChildScrollView, dan ListView saat menampilkan elemen-elemen form? Berikan contoh penggunaannya dari aplikasi kamu.


Penggunaan layout widget seperti Padding, SingleChildScrollView, dan ListView memberikan banyak keuntungan dalam menata elemen-elemen form. Padding digunakan untuk memberikan jarak antar elemen agar tampilannya lebih nyaman dibaca. SingleChildScrollView berguna agar seluruh isi form tetap dapat di-scroll ke bawah ketika jumlah elemen melebihi tinggi layar, sehingga pengguna tetap bisa mengisi semua data tanpa terpotong. Sementara itu, ListView sangat efisien untuk menampilkan daftar elemen yang banyak karena hanya merender bagian yang terlihat di layar. Dalam aplikasi Football Shop saya, kombinasi Padding dan SingleChildScrollView digunakan pada halaman tambah produk agar setiap field input tetap terlihat rapih dan dapat di-scroll di perangkat dengan layar yang kecil. (Sumber: Flutter.dev - Layout widgets guide)


Nomor 4 : Bagaimana kamu menyesuaikan warna tema agar aplikasi Football Shop memiliki identitas visual yang konsisten dengan brand toko?


Penyesuaian warna tema dilakukan dengan menggunakan properti ThemeData pada widget MaterialApp untuk menentukan warna utama, warna aksen, serta gaya visual lainnya. Dengan mendefinisikan satu palet warna utama yang sesuai dengan identitas brand toko, seperti biru tua untuk nuansa profesional dan sporty, seluruh elemen seperti AppBar, tombol, dan ikon dapat memiliki tampilan yang konsisten. Ini membuat perubahan warna lebih mudah karena cukup dilakukan di 1 tempat tanpa perlu mengubah setiap widget secara manual. Selain itu, konsistensi warna juga membantu memperkuat identitas visual aplikasi dan memberikan pengalaman yang lebih menyatu bagi pengguna. (Sumber: Flutter.dev - ThemeData class documentation)



Tugas 7

Nomor 1 : Apa itu widget tree pada Flutter dan bagaimana hubungan parent-child (induk-anak) bekerja antar widget?
Dalam Flutter, seluruh tampilan aplikasi dibangun dari kumpulan widget yang tersusun dalam bentuk struktur pohon yang disebut widget tree. Setiap widget bisa memiliki satu atau lebih widget di dalamnya (child) dan bersama-sama membentuk hierarki. Widget di bagian atas disebut parent dan widget di dalamnya disebut child. Parent mengatur bagaimana child ditampilkan, misalnya dalam posisi, ukuran. Contohnya, Column adalah parent dari beberapa tombol (ElevatedButton) di dalam proyek saya ini.


Nomor 2 : Sebutkan semua widget yang kamu gunakan dalam proyek ini dan jelaskan fungsinya.

MaterialApp : Sebagai root dari aplikasi, mengatur tema dan navigasi utama.

Scaffold : Menyediakan struktur dasar aplikasi seperti AppBar dan body.

AppBar : Bagian atas aplikasi buat menampilkan judul.

Center : Menempatkan seluruh isi halaman di tengah layar.

Column : Menyusun beberapa widget child secara vertikal.

ElevatedButton.icon : Tombol yang berisi ikon dan teks, digunakan untuk membuat tombol All Products, My Products, dan Create Product.

Icon : Menampilkan ikon di setiap tombol.

Text : Menampilkan teks pada tombol dan judul AppBar.

SizedBox : Memberi jarak antar tombol agar tampilan lebih rapi.

SnackBar : Muncul sementara di bagian bawah layar sebagai respons ketika tombol ditekan.


Nomor 3 : Apa fungsi dari widget MaterialApp? Jelaskan mengapa widget ini sering digunakan sebagai widget root.
Sumber yang saya gunakan: https://api.flutter.dev/flutter/material/MaterialApp-class.html
MaterialApp berfungsi sebagai tempat utama yang mengatur struktur dasar aplikasi berbasis Material Design. Widget ini mengelola banyak hal seperti tema warna, rute (halaman), dan konfigurasi teks. Biasanya MaterialApp dijadikan widget root karena hampir semua aplikasi Flutter modern memakai gaya desain Material yang konsisten dengan Android. Dengan MaterialApp, kita bisa memastikan tampilan aplikasi memiliki gaya visual yang seragam dan mudah diatur dari satu tempat.


Nomor 4 : Jelaskan perbedaan antara StatelessWidget dan StatefulWidget. Kapan kamu memilih salah satunya?
Sumber yang saya gunakan: https://docs.flutter.dev/ui/interactivity
StatelessWidget adalah widget yang tidak memiliki state atau data yang bisa berubah. Artinya, tampilan widget ini akan tetap sama selama aplikasi berjalan. Sementara itu, StatefulWidget bisa menyimpan dan mengubah state, sehingga tampilan bisa diperbarui saat ada perubahan data. Dalam proyek ini, saya menggunakan StatelessWidget karena tombol-tombol yang dibuat tidak memiliki perubahan data dinamis. Kalo misalnya nanti ada fitur seperti keranjang belanja atau daftar produk yang bisa berubah, baru nanti saya akan menggunakan StatefulWidget.



Nomor 5 : Apa itu BuildContext dan mengapa penting di Flutter? Bagaimana penggunaannya di metode build?
BuildContext adalah objek yang memberikan informasi tentang posisi suatu widget dalam widget tree. Objek ini penting karena digunakan Flutter untuk mengetahui di mana sebuah widget berada dan bagaimana ia berinteraksi dengan widget lain. BuildContext sering digunakan untuk mengakses tema, navigator, atau menampilkan SnackBar. Dalam proyek ini, BuildContext digunakan pada metode build di MyHomePage dan dipakai oleh ScaffoldMessenger.of(context) untuk menampilkan SnackBar di layar yang benar.


Nomor 6 : Jelaskan konsep "hot reload" di Flutter dan bagaimana bedanya dengan "hot restart".
Hot reload adalah fitur Flutter yang memungkinkan kita melihat perubahan kode secara langsung tanpa harus memulai ulang aplikasi dari awal. Flutter hanya memperbarui bagian kode yang berubah, sehingga sangat cepat dan tidak menghapus state yang sedang berjalan. Sedangkan hot restart akan memulai ulang aplikasi dari awal dan menghapus semua state yang sedang aktif. Biasanya hot reload digunakan untuk perubahan kecil pada tampilan, sementara hot restart digunakan kalo perubahan yang dilakukan berpengaruh pada struktur program secara keseluruhan.
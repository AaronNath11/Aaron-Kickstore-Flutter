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
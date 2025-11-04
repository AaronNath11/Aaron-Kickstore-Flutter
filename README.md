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
## Pengertian DevOps menurut saya
DevOps adalah metode kerja yang menggabungkan tim Developer dan Operations agar proses pembuatan,pengujian, hingga deployment aplikasi dapat dilakukan dengan lebih cepat, efisien, dan terstruktur.

## cara instalasi ubuntu server
1. Download oracle virtual box melalui https://www.virtualbox.org/
2. Download ubuntu server melalui https://ubuntu.com/download/server
3. install oracle virtual box
4. setelah virtual box berhasil diinstall, buka aplikasi dan klik new VM
5. isi VM Name, lalu pilih ISO ubuntu server yang telah di download sebelumnya.
![Gambar 1](gambar1.png)
6. selanjutnya konfigurasi virtual hardware(sesuaikan dengan kemampuan perangkat masing - masing). Di konfigurasi saya, saya mengatur base memory 2048 MB, dan Numbers of CPU 3.
![Gambar 2](gambar2.png)
7. Selanjutnya Konfigurasi virtual hard disk(sesuaikan dengan kemampuan perangkat masing - masing). Di konfigurasi saya, saya mengatur virtual hard disk 10 GB.
![Gambar 3](gambar3.png)
8. setelah virtual machine berhasil dibuat, jalankan dengan menekan tombol start
![Gambar 4](gambar4.png)
9. setelah virtual machine berhasil dijalankan, pilih opsi 'try or install Ubuntu Server'
![Gambar 5](gambar5.png)
10. Selanjutnya, pilih bahasa sesuai yang diinginkan. Disarankan untuk menggunakan bahasa inggris.
![Gambar 6](gambar6.png)
11. Selanjutnya, terdapat pilihan unuk update to new installer atau continue without updating(opsional / disesuaikan)
![Gambar 7](gambar7.png)
12. Selanjutnya, terdapat pilihan tipe instalasi, pilih 'ubuntu server'. Untuk additional options abaikan saja.
![Gambar 8](gambar8.png)
13. Selanjutnya masuk ke Network Configuration, tekan enter pada enp0s3 lalu pilih edit IPv4, lalu pilih IPv4 Method menjadi manual.
![Gambar 9](gambar9.png)
14. selanjutnya isi subnet, address dengan xxx.xxx.xxx.208,gateway, dan name servers(sesuaikan dengan jaringan perangkat masing - masing). Di konfigurasi ini,saya mengisi seperti gambar yang dicantumkan dibawah ini.
![Gambar 11](gambar11.png)
15. Setelah berhasil konfigurasi jaringan maka output seperti gambar dibawah ini yang menandakan bahwa internet berhasil terhubung.
![Gambar 12](gambar12.png)
16. Selanjutnya di menu konfigurasi proxy. Di menu ini abaikan saja agar di kosongkan dan lanjut ke tahap selanjutnya.
![Gambar 13](gambar13.png)
17. Selanjutnya di menu Ubuntu archive mirror configuration abaikan saja agar langsung menuju menu selanjutnya.
![Gambar 14](gambar14.png)
18. Selanjutnya masuk kedalam menu konfigurasi penyimpanan. Di menu ini, pilih opsi Custom storage layout.
![Gambar 15](gambar15.png)
19. Di konfigurasi penyimpanan, tambahkan GPT partition pada free space seperti gambar yang dicantumkan dibawah ini. (atur sesuai kebutuhan / kemampuan)
![Gambar 16](gambar16.png)
20. Di konfigurasi ini, saya menambahkan 7gb untuk partisi.
![Gambar 17](gambar17.png)
21. Di konfigurasi ini, saya juga menambahkan 2.800G untuk swap.
![Gambar 18](gambar18.png)
22. Setelah konfigurasi penyimpanan, masuk ke dalam menu konfigurasi profil. Disini isi sesuai dengan yang diinginkan.
![Gambar 21](gambar21.png)
23. setelah berhasil mengisi profil, selanjutnya terdapat pilihan untuk upgrade to ubunto pro, pilih skip for now.
![Gambar 22](gambar22.png)
24. selanjutnya masuk ke dalam konfigurasi SSH, abaikan saja dan langsung menuju menu selanjutnya.
![Gambar 23](gambar23.png)
25. Selanjutnya masuk ke dalam menu Featured server snaps, abaikan saja dan langsung menuju proses selanjutnya.
![Gambar 24](gambar24.png)
26. proses instalasi server sedang berjalan.
![Gambar 25](gambar25.png)
27. Setelah berhasil di install, Lakukan reboot.
![Gambar 26](gambar26.png)
28. Setelah berhasil masuk reboot dan masuk ke dalam sistem, login menggunakan profil yang telah didaftarkan di menu konfigurasi profil.
![Gambar 27](gambar27.png)
29. Setelah berhasil login, maka kita berhasil akses ke dalam server. Masukkan perintah ping 8.8.8.8 untuk test koneksi jaringan.
![Gambar 28](gambar28.png)
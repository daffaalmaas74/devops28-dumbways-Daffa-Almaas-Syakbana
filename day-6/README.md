#### 1.  Gambarkan sturktur web server menggunakan reverse proxy dan jelaskan cara kerjanya!

 ![Gambar 1](gambar1.png)

 cara kerja :
 
 1. User membuka alamat website melalui browser, Request dari user masuk ke web server.

 2. Web server menerima request dari user lalu meneruskannya ke VM APP(server)

 3. VM App(server) mengirim response ke web server 

 4. Web server mengirim response ke user


 #### 2. Buatlah Reverse Proxy untuk aplilkasi yang sudah kalian deploy kemarin. (wayshub), untuk domain nya sesuaikan nama masing" ex: ade.xyz .
 
 1. Menginstall Nginx

  ![Gambar 2](gambar2.png)

2. edit file hosts di C:\Windows\System32\drivers\etc, lalu masukkan ip adress server dan nama domain

![Gambar 3](gambar3.png)

3. Buka direktori /etc/nginx/sites-enabled, dan buat file baru dengan format .conf

![Gambar 4](gambar4.png)

4. Isi file wayshub.conf yang telah dibuat dengan isi seperti gambar dibawah

![Gambar 5](gambar5.png)

5. Jalankan perintah " sudo nginx -t " untuk mengecek konfigurasi apakah sudah sesuai

![Gambar 6](gambar6.png)

6. Jalankan perintah sudo systemctl reload nginx

![Gambar 7](gambar7.png)

7. Domain daffa.xyz berhasil digunakan dan aplikasi wayshub berhasil ditampilkan

![Gambar 8](gambar8.png)


 #### 3. Challenge menggunakan load balancer

 1. Edit wayshub.conf seperti gambar dibawah

![Gambar 9](gambar9.png)

2. Lakukan "sudo nginx -t" untuk mengecek konfigurasi dan "sudo systemctl reload nginx" untuk reload nginx

![Gambar 10](gambar10.png)

3. Aplikasi berhasil dibuka dengan menggunakan domain daffa.xyz serta menggunakan load balancer

![Gambar 11](gambar11.png)

 
# Penjelasan server
### 1. Server 1 : webserver
### 2. Server 2 : bootcamp (frontend)
### 3. Server 3 : backend
### 4. Server 4 : database

### Semua server telah dibuat user baru manual bernama daffaalmaas dan sudah disetup agar tidak bisa login menggunakan password dan hanya bisa login menggunakan SSH - KEY.

### Login server webserver

![Gambar 1](gambar1.png)

![Gambar 74](gambar74.png)

### Login server bootcamp(frontend)

![Gambar 2](gambar2.png)

![Gambar 75](gambar75.png)

### Login server backend

![Gambar 3](gambar3.png)

![Gambar 76](gambar76.png)

### Login server database

![Gambar 4](gambar4.png)

![Gambar 77](gambar77.png)

# Deploy Database MySQL

## 1. Lakukan update untuk mendapatkan pembaruan sistem server dengan perintah " sudo apt update && sudo apt upgrade -y " .

![Gambar 5](gambar5.png)

## 2. Install mysql-server dengan perintah " sudo apt install mysql-server -y " .

![Gambar 6](gambar6.png)

## 3. Setup secure_installation dengan menggunakan perintah " sudo mysql_secure_installation " .

![Gambar 7](gambar7.png)

## 4. Masuk kedalam mysql dengan menggunakan perintah " sudo mysql " lalu berikan password terhadap root dengan perintah " ALTER USER 'root'@'localhost' IDENTIFIED WITH caching_sha2_password BY 'isi_password'; " .

![Gambar 8](gambar8.png)

## 5. Lakukan flush privilages untuk reload hak akses, dan keluar dari mysql.

![Gambar 9](gambar9.png)

## 6. Masuk kedalam mysql dengan menggunakan root dengan perintah " sudo mysql -u root -p " .

![Gambar 10](gambar10.png)

## 7. Setelah berhasil masuk,buat database bernama wayshub dengan perintah " CREATE DATABASE wayshub; " .

![Gambar 11](gambar11.png)

## 8. Buat user baru dengan perintah " CREATE USER 'nama_user'@'%' IDENTIFIED BY 'isi_password'; " dan lakukan reload hak akses dengan menggunakan perintah " FLUSH PRIVILEGES; " .

![Gambar 12](gambar12.png)

## 9. Berikan hak akses penuh pada database wayshub terhadap user dengan perintah " GRANT ALL PRIVILEGES ON wayshub.* TO 'nama_user'@'%'; " dan lakukan reload hak akses.

![Gambar 13](gambar13.png)

## 10. Setelah berhasil, keluar dari mysql dan edit isi file konfigurasi mysqld.cnf di direktori /etc/mysql/mysql.conf.d menggunakan perintah " sudo nano /etc/mysql/mysql.conf.d/mysqld.cnf  ", lalu ubah isi 'bind-address' dan 'mysql-bind-address'  menjadi 0.0.0.0 seperti pada gambar dibawah.

![Gambar 14](gambar14.png)

## 11. Restart MySQL dengan perintah " sudo systemctl restart MySQL " .

![Gambar 25](gambar25.png)

# Deploy Wayshub-backend

## 1. Login SSH ke server backend.

![Gambar 15](gambar15.png)

## 2. Install node version 14 dengan perintah " nvm install 14 " dan jadikan node version 14 menjadi default dengan perintah " nvm alias default 14 " .

![Gambar 26](gambar26.png)

## 3. Lakukan clone terhadap https://github.com/dumbwaysdev/wayshub-backend.git.

![Gambar 16](gambar16.png)

## 4. Buka direktori wayshub-backend, lalu install depedensi/library yang dibutuhkan oleh project wayshub-backend dengan menggunakan perintah " npm install " .

![Gambar 17](gambar17.png)

## 5. Buka file config/config.json menggunakan perintah nano config/config.json. Pada bagian environment development, sesuaikan username dan password dengan user yang memiliki akses ke database wayshub, ubah isi database menjadi " wayshub ", serta isi host dengan IP address server database.

![Gambar 18](gambar18.png)

## 6. Install sequelize-cli dengan perintah " npm i -g sequelize-cli " .

![Gambar 19](gambar19.png)

## 7. Lakukan migrasi tabel ke database dengan perintah " sequelize db:migrate " .

![Gambar 20](gambar20.png)

## 8. Install PM2 dengan perintah " npm install -g pm2 " .

![Gambar 21](gambar21.png)

## 9. Buat file konfigurasi ecosystem PM2 dengan perintah " PM2 init " yang berfungsi menyimpan pengaturan aplikasi saat dijalankan oleh PM2.

## 10. Edit isi file ecosystem.config.js dengan perintah " nano ecosystem.config.js ", lalu tambahkan key / property name diatas 'script' seperti pada gambar dibawah.

![Gambar 22](gambar22.png)

## 11. Jalankan aplikasi diatas PM2 dengan perintah " PM2 start ecosystem.config.js " .

![Gambar 23](gambar23.png)

## 12. Aplikasi berhasil dijalankan di http://23.100.98.52:5000/.

![Gambar 24](gambar24.png)

# Deploy Wayshub-frontend

## 1. Login SSH ke server bootcamp.

![Gambar 27](gambar27.png)

## 2. Install node version 14 dengan perintah " nvm install 14 " dan buat node version 14 menjadi default dengan perintah " nvm alias default 14 " .

![Gambar 28](gambar28.png)

## 3. Clone terhadap repositori https://github.com/dumbwaysdev/wayshub-frontend.git.

![Gambar 29](gambar29.png)

## 4. Buka direktori wayshub-frontend dan install library/depedency yang dibutuhkan oleh project dengan perintah " npm install " .

![Gambar 30](gambar30.png)

## 5. Buka file src/config/api.js menggunakan perintah " nano src/config/api.js ". Pada bagian baseURL, masukkan ip adress server backend dengan tambahan port 5000 seperti gambar dibawah.

![Gambar 31](gambar31.png)

## 6. Install PM2 dengan perintah " npm install -g pm2 " .

![Gambar 32](gambar32.png)

## 7. Buat file konfigurasi ecosystem PM2 dengan perintah " PM2 init " yang berfungsi menyimpan pengaturan aplikasi saat dijalankan oleh PM2.

![Gambar 33](gambar33.png)

## 8. Edit isi file ecosystem.config.js dengan perintah " nano ecosystem.config.js " seperti gambar dibawah.

![Gambar 34](gambar34.png)

## 9. Jalankan aplikasi diatas PM2 dengan perintah " PM2 start ecosystem.config.js " .

![Gambar 35](gambar35.png)

## 10. Aplikasi berhasil dijalankan di http://20.92.79.165:3000/.

![Gambar 36](gambar36.png)


# Konfigurasi Domain

## 1. Buka cloudflare.com dan login.

![Gambar 37](gambar37.png)

## 2. Setelah login, buka akun Demo.dumbways@gmail.com.

![Gambar 38](gambar38.png)

## 3. Buka domain studentdumbways.my.id.

![Gambar 39](gambar39.png)

## 4. Buka menu DNS/Record.

![Gambar 40](gambar40.png)

## 5. Tambahkan record baru untuk frontend dengan isi name 'daffaalmaas' dan Ipv4 address isi dengan ip address server webserver seperti gambar dibawah.

![Gambar 41](gambar41.png)

## 6. Tambahkan record baru untuk backend dengan isi name 'api.daffaalmaas' dan IPv4 adress isi dengan ip address server webserver seperti gambar dibawah.

![Gambar 42](gambar42.png)


# Konfigurasi Reverse Proxy menggunakan nginx

## 1. Login SSH ke server webserver.

![Gambar 43](gambar43.png)

# 2. Lakukan pembaruan sistem/package dengan perintah " sudo apt update && sudo apt upgrade -y " .

![Gambar 44](gambar44.png)

## 3. Install Nginx dengan perintah " sudo apt install nginx " .

![Gambar 45](gambar45.png)

## 4. Setelah berhasil install, edit file nginx.conf didalam direktori /etc/nginx dengan perintah " sudo nano /etc/nginx/nginx.conf ". Tambahkan " include /etc/nginx/wayshub/*; " seperti gambar dibawah agar semua konfigurasi didalam folder wayshub dapat digunakan oleh nginx.

![Gambar 46](gambar46.png)

## 5. Buat direktori bernama 'wayshub' didalam direktori /etc/nginx.

![Gambar 47](gambar47.png)

## 6. Masuk ke direktori wayshub, kemudian buat file konfigurasi dengan nama 'daffaalmaas.studentdumbways.my.id'. Setelah itu, edit isi file tersebut seperti pada gambar dibawah.

![Gambar 48](gambar48.png)

## 7. Buat juga file bernama 'api.daffaalmaas.studentdumbways.my.id' didalam direktori wayshub. Setelah itu, edit isi file tersebut seperti pada gambar dibawah.

![Gambar 49](gambar49.png)

## 8. Restart nginx dengan perintah " sudo systemctl restart nginx " .

![Gambar 50](gambar50.png)

## 9. Uji konfigurasi nginx dengan perintah " sudo nginx -t " dan reload nginx dengan perintah " sudo systemctl reload nginx " .

![Gambar 51](gambar51.png)

## 10. Aplikasi berhasil dijalankan menggunakan reverse proxy dengan alamat http://daffaalmaas.studentdumbways.my.id/ untuk front-end dan http://api.daffaalmaas.studentdumbways.my.id/ untuk back-end serta telah terintegrasi dengan database.

![Gambar 52](gambar52.png)

![Gambar 53](gambar53.png)

# Konfigurasi SSL menggunakan Certbot

## 1. Login SSH ke server webserver.

![Gambar 54](gambar54.png)

## 2. Lakukan pembaruan terhadap sistem dan package dengan perintah " sudo apt update -y && sudo apt upgrade -y " .

![Gambar 55](gambar55.png)

## 3. Install Certbot menggunakan snap dengan perintah " sudo snap install --classic certbot " .

![Gambar 56](gambar56.png)

## 4. Jalankan perintah " sudo ln -s /snap/bin/certbot /usr/local/bin/certbot " untuk membuat symbolic link (symlink) agar command certbot bisa ditemukan melalui lokasi /usr/local/bin.

![Gambar 57](gambar57.png)

## 5. Jalankan perintah " sudo certbot --nginx " untuk mendapatkan sertifikat SSL dan secara otomatis mengonfigurasi Nginx agar domain dapat diakses melalui HTTPS. Selanjutnya, masukkan alamat email, setujui Terms of Service, kemudian pilih domain yang ingin diaktifkan HTTPS-nya seperti yang ditunjukkan pada gambar di bawah.

![Gambar 58](gambar58.png)

## 6. Pada project wayshub-frontend di server bootcamp, edit file src/config/api.js dan ganti nilai baseURL dari http://23.100.98.52:5000/api/v1 menjadi https://api.daffaalmaas.studentdumbways.my.id/api/v1.

![Gambar 61](gambar61.png)

## 7. SSL berhasil diterapkan dan kedua domain dapat diakses menggunakan protokol HTTPS, yaitu https://daffaalmaas.studentdumbways.my.id dan https://api.daffaalmaas.studentdumbways.my.id/.

![Gambar 59](gambar59.png)

![Gambar 60](gambar60.png)


# role based MYSQL

## 1. Login SSH ke server database.

![Gambar 62](gambar62.png)

## 2. Masuk ke MySQL dengan menggunakan user root dengan perintah " sudo mysql -u root -p " .

![Gambar 63](gambar63.png)

## 3. Buat database dummy bernama 'demo' dengan perintah " create database demo; " .

![Gambar 64](gambar64.png)

## 4. Gunakan database demo dengan perintah " USE demo; ", kemudian buat tabel bernama transaction dengan struktur sebagai berikut:

    - id — INT AUTO_INCREMENT PRIMARY KEY
    - amount — BIGINT NOT NULL
    - date — TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP

    Gunakan perintah SQL berikut :
    CREATE TABLE transaction (
        id INT AUTO_INCREMENT PRIMARY KEY,
        amount BIGINT NOT NULL,
        date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
    ); 

![Gambar 65](gambar65.png)

## 5. Isi data dummy ke dalam tabel dengan perintah sebagai berikut :
    INSERT INTO transaction (amount)
    VALUES
        (isi_amount),
        (isi_amount),
        (isi_amount),
        -- Dan seterusnya
        (isi_amount);

![Gambar 66](gambar66.png)

## 6. Buat role admin dan guest dengan perintah " CREATE ROLE 'admin', 'guest'; " .

![Gambar 67](gambar67.png)

## 7. Berikan hak akses SELECT, INSERT, UPDATE, DAN DELETE ke tabel transaction untuk admin  dengan perintah sebagai berikut :

    GRANT SELECT, INSERT, UPDATE, DELETE
    ON demo.transaction
    TO 'admin';

![Gambar 68](gambar68.png)

## 8. Berikan hak akses SELECT ke tabel transaction untuk guest dengan perintah sebagai berikut :

    GRANT SELECT
    ON demo.transaction
    TO 'guest';

![Gambar 69](gambar69.png)

## 9. Buat 2 user dengan perintah 'CREATE USER " nama_user'@'%' IDENTIFIED BY 'isi_password'; " .

![Gambar 70](gambar70.png)

user berhasil dibuat,yaitu admin_daffa dan guest_daffa.

## 10. Masukkan perintah " GRANT 'nama_role' TO 'nama_user'@'%'; " untuk memberikan role ke masing-masing user, lalu jalankan SET " DEFAULT ROLE 'nama_role' TO 'nama_user'@'%';  "agar role tersebut otomatis aktif sebagai default sehingga tidak perlu diatur ulang saat login.

![Gambar 71](gambar71.png)

Role admin berhasil diberikan terhadap user admin_daffa dan role guest berhasil diberikan terhadap user guest_daffa.

## 11. Berdasarkan role tersebut, user admin_daffa bisa melakukan SELECT,INSERT,UPDATE dan DELETE dan user guest_daffa hanya bisa melakukan SELECT terhadap data di tabel transaction.

Role Admin

![Gambar 72](gambar72.png)

Role Guest

![Gambar 73](gambar73.png)



# Remote database dari local computer menggunakan mysql-client

## 1. Buka Terminal WSL dan lakukan pembaruan sistem atau package dengan perintah " sudo apt update -y && sudo apt upgrade -y " .

![Gambar 78](gambar78.png)

## 2. Jalankan Perintah " sudo apt install mysql-client -y " untuk menginstal mysql-client.

![Gambar 79](gambar79.png)

## 3. Masukkan Perintah " mysql -h ip_address_server_database -u nama_user_mysql -p " untuk melakukan remote ke database.

![Gambar 80](gambar80.png)

### Berdasarkan gambar diatas,remote ke database berhasil dilakukan.

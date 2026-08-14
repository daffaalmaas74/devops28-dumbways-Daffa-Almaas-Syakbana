## Akses server menggunakan Windows Terminal
![Gambar 1](gambar1.png)



## Konfigurasi ssh agar bisa di akses hanya menggunakan publickey (password dimatikan)
1. masukkan perintah ssh-keygen di terminal untuk membuat kunci ssh yang nantinya akan digunakan untuk autentikasi. saya memberikan nama 'kunci' untuk key nya.

![Gambar 2](gambar2.png)
![Gambar 3](gambar3.png)

2. Setelah berhasil, buka folder c:user/nama/.ssh dan buka file kunci.pub menggunakan teks editor,kemudian copy semua isi file.

![Gambar 4](gambar4.png)

3. setelah copy,masuk ke dalam server lalu jalankan perintah seperti pada gambar untuk membuar direktori bernama .ssh

![Gambar 5](gambar5.png)

4. lakukan chmod 700 pada folder .ssh seperti perintah pada gambar di bawah ini agar hanya user yang dapat membuka,melihat, dan mengubah folder .ssh

![Gambar 6](gambar6.png)

5. buat file bernama authorized_keys dengan perintah pada gambar di bawah ini

![Gambar 7](gambar7.png)

6. lakukan sudo nano authorized_keys untuk mengedit isi file dan paste isi file kunci.pub yang telah di copy sebelumnya

![Gambar 8](gambar8.png)

7. setelah itu, buka folder etc/ssh dengan menggunakan perintah cd /etc/ssh

![Gambar 9](gambar9.png)

8. masukkan perintah sudo nano sshd_config untuk mengedit isi file tersebut

![Gambar 10](gambar10.png)

9. hapus tanda pagar pada PubkeyAuthentication, kemudian hapus tanda pagar pada PasswordAuthentication serta rubah dari yang sebelumnya yes menjadi no

![Gambar 11](gambar11.png)

10. lakukan sudo systemctl restart ssh untuk restart ssh setelah konfigurasi dirubah

![Gambar 12](gambar12.png)

11. selanjutnya coba akses ke server dengan menggunakan perintah ssh -i .ssh\kunci almaasd@192.168.1.208,maka kita berhasil langsung masuk ke dalam server.

![Gambar 13](gambar13.png)

12. Jika kita coba dengan menggunakan ssh almaasd@192.168.1.208 akses langsung ditolak karna tidak diizinkan autentikasi password

![Gambar 14](gambar14.png)

## penggunaan text manipulation (grep,sed,cat, dan echo)

1. grep
A. Menampilkan baris yang mengandung kata yang ingin dicari
    Gunakan perintah:
    grep "kata yang ingin dicari" nama_file

![Gambar 15](gambar15.png)

B. Menampilkan nomor baris dari kata yang dicari
    Gunakan perintah:
    grep -n "kata yang ingin dicari" nama_file

![Gambar 16](gambar16.png)

C. Menampilkan baris yang tidak mengandung kata yang dicari
    Gunakan perintah:
    grep -v "kata yang ingin dicari" nama_file

![Gambar 17](gambar17.png)

D. Menghitung jumlah baris yang mengandung kata yang dicari
    Gunakan perintah:
    grep -c "kata yang ingin dicari" nama_file

![Gambar 18](gambar18.png)

2. sed
A. Mengganti Kata tanpa menyimpan perubahan asli di file
    Gunakan perintah:
    sed 's/kata_lama/kata_baru/' nama_file

![Gambar 19](gambar19.png)

B. Mengganti kata dan menyimpan Perubahan asli di file
    Gunakan perintah :
    sed -i 's/kata_lama/kata_baru/g' nama_file

![Gambar 20](gambar20.png)

C. Menghapus baris yang mengandung kata tertentu
    Gunakan perintah:
    sed '/kata yang ingin dihapus/d' nama_file
    (tambahkan -i jika ingin langsung menyimpan perubahan file)

![Gambar 21](gambar21.png)

3. cat
A. Menampilkan isi file
    Gunakan perintah:
    cat nama_file

![Gambar 22](gambar22.png)

B. Menampilkan Isi Beberapa File
    Gunakan perintah:
    cat nama_file1 nama_file2

![Gambar 23](gambar23.png)

C. Menggabungkan File 
    Gunakan perintah:
    cat nama_file1 nama_file2 > nama_file_baru

![Gambar 24](gambar24.png)

4. echo
A. Mencetak teks
    Gunakan perintah:
    echo "teks yang ingin dicetak"

![Gambar 25](gambar25.png)

B. Menulis Teks ke file
    Gunakan perintah:
    echo "isi_teks" > nama_file
    - jika nama_file belum ada, maka file akan dibuat
    - jika sudah ada, isi file akan ditimpa

![Gambar 26](gambar26.png)

C. Menambahkan Teks ke File (tidak menimpa isi file sebelumnya)
    Gunakan perintah:
    echo "isi_teks" >> nama_file

![Gambar 27](gambar27.png)


## Menyalakan ufw dengan memberikan akses untuk port 22, 80, 443, 3000, 5000 dan 6969

1. Aktifkan firewall dengan menggunakan perintah:
    sudo ufw enable

    ![Gambar 28](gambar28.png)

2. Berikan akses terhadap masing - masing port dengan menggunakan perintah:
    sudo ufw allow nomor_port

    ![Gambar 29](gambar29.png)

3. cek status firewall dengan perintah:
    sudo ufw status

    ![Gambar 30](gambar30.png)

    berdasarkan gambar diatas, port 22, 80, 443, 3000, 5000 dan 6969 telah diberikan akses.


## challenge mengganti ip address

1. Masukkan perintah dibawah untuk mengedit configurasi network :
    sudo nano /etc/netplan/50-cloud-init.yaml

2. Ubah ip adress dari 192.168.1.208 menjadi 192.168.1.210

    ![Gambar 31](gambar31.png)

3. lakukan uji konfigurasi dan konfirmasi perubahan menggunakan perintah:
    sudo netplan try

    ![Gambar 32](gambar32.png)

4. cek status jaringan dengan menggunakan perintah:
    sudo netplan status

    ![Gambar 33](gambar33.png)
    
    berdasarkan gambar diatas, ip adress berhasil dirubah dari 192.168.1.208 menjadi 192.168.1.210.







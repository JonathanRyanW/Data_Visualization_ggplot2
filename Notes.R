"Kolom survived sama pclass itu kan dibaca sebagai integer(dari sapply ketauan)
Kita pengen baca kolom itu sebagai factor karena ggplot2 nanti bisa kasih kita
visualisasi yang sangat bagus kalau dia tau yang mana yang sebenernya adalah
factor. Jadi kita ubah kedua kolom tersebut jadi factor"

data_titanic$Survived <- as.factor(data_titanic$Survived)
data_titanic$Pclass <- as.factor(data_titanic$Pclass)

"Selain itu, sex dan embarked juga kolom2 yang sebenernya factor tapi dibaca
oleh r sebagai string/character. Kita ubah juga, dengan alasan yang sama seperti
diatas."

data_titanic$Sex <- as.factor(data_titanic$Sex)
data_titanic$Embarked <- as.factor(data_titanic$Embarked)

"Sekarang kalau kita cek pake sapply, keempat kolom tersebut udah jadi factor"

"Kita mau bikin tabel penumpang yang selamat dan mati. Karena survived adalah
factor, grafik yang bagus adalah bar chart atau pie chart juga bisa sebenernya.
Cara bikin bar chart pake ggplot adalah sebagai berikut"

ggplot(data = data_titanic, aes(x = Survived)) +
  geom_bar()

"Pertama2 kasih tau datanya apa, trus panggil fungsi aes utk aesthetic mapping
Kasih tau bahwa kita pengen x nya jdi survived dan ditampilin pake bar chart
dengan geom_bar(). Sebenernya ada banyak bgt chart lain dan itu semuanya berawal
dengan geom.

Di chart ini nggak ada angka diatas barnya, buat nampilin itu bisa tapi katanya
sih codenya ribet jadi nanti dulu. Kalau mau tau count atau percentagenya bisa
pake code ini"

count <- table(data_titanic$Survived)
percentage <- prop.table(table(data_titanic$Survived))

"Boleh banget diinget ini fungsi prop.table(). Selama ini gw nyari proporsi
dibagi manual sama jumlah data. Pake fs ini kan lebih praktis."

"Default background color dari plot yang dibuat oleh ggplot adalah abu2. Warna
ini bisa diubah. Perhatikan juga di plot kita y nya cuman 'count' aja namanya.
Trus juga plot kita kagak punya judul. Kita bakal kasih semua info ini."

ggplot(data = data_titanic, aes(x = Survived)) + 
  geom_bar() +
  theme_bw() +
  labs(y = "Passenger Count", title = "Titanic Survival Rates")

"Sekarang plot kita punya y label dan judul, abis itu bg color juga jadi warna
putih. Bg color diubah pake fs theme_bw(), sementara fs labs dipake buat kasih
label ke sumbu y dan kasih title/judul. Perhatikan bahwa fs labs juga bisa
dipake buat kasih subtitle."

"Selanjutnya kita mau tau survival rate berdasarkan gender. Hal ini bisa kita
cari dengan menambahkan argumen fill di fungsi aes dan mengganti x"

ggplot(data = data_titanic, aes(x = Sex, fill = Survived)) + 
  geom_bar() +
  theme_bw() +
  labs(y = "Passenger Count", title = "Titanic Survival Rates by Sex")

"hasilnya bagus! Keliatan banget bahwa memang wanita jauh lebih mungkin untuk
selamat dibanding pria. Hal ini bisa dilihat pake angka juga (gw udh melakukan
hal ini), tapi orang2 yang kurang suka dengan angka dan matematika pasti lebih
memilih untuk ngeliat kayak gini. Ini lebih intuitif buat mereka."

"Sekarang gw mau tau survival rate berdasarkan kelas. Hal ini udah gw cari juga
dan hasilnya memang org2 dari kelas 1 dan kelas 2 lebih mungkin selamat drpd
org2 dari kelas 3. Tapi kali ini kita nggak akan scr lgsg liat angkanya, kita
bakal visualisasi pake bar chart."

ggplot(data = data_titanic, aes(x = Pclass, fill = Survived)) + 
  geom_bar() +
  theme_bw() +
  labs(y = "Passenger Count", title = "Titanic Survival Rates by Class")

"yak hasilnya keluar dan memang jelas juga dari sini bahwa kemungkinan selamat
dari kelas 1 tinggi(jelas bgt lebih dr 50%) sementara kelas 3 rendah(klo diliat
liat kayaknya 25% gitu)."

"Bagaimana kalau kita mau tau survival rate berdasarkan sex dan kelas? Ini udh
gw lakukan juga, waktu itu cuman tau angkanya doang, nggak pake visualisasi.
sekarang gw bakal visualisasi pake ggplot. Kita udh visualisasi berdasarkan
sex sebelumnya, sekarang kita cuman perlu bagi data tersebut berdasarkan class
dengan menggunakan fungsi facet_wrap()"

ggplot(data = data_titanic, aes(x = Sex, fill = Survived)) + 
  geom_bar() +
  theme_bw() +
  facet_wrap(~ Pclass) +
  labs(y = "Passenger Count", title = "Titanic Survival Rates by Sex and Class")

"Hasilnya bagus dan jelas sekali! Konsisten dengan probability yg sebelumnya gw
udh dapetin dari hasil ngitung2. Ini jelas bgt! Di kelas 1 kalau u cewe dan mati
u sial banget artinya. Karena ya liat aja itu yang mati cuman sedikit bgt. Hal
yang sama berlaku juga di kelas 2, cewe2 pada selamat semua. Sayangnya di kelas
3 probability utk selamatnya rendah bgt."

"Oke sekarang gw mau tau sebaran dari umur penumpang di Titanic. Ini udh gw
lakukan juga sblmnya pake fungsi hist() dari R. Tapi sekarang gw mau pake fs
geom_histogram untuk bikin sebarannya"

ggplot(data = data_titanic, aes(x = Age)) + 
  geom_histogram(binwidth = 5) +
  theme_bw() +
  labs(y = "Passenger Count", x = "Age",title = "Age Distribution")

"Perlu diperhatikan bahwa data umur ini kan punya ekor yang panjang di kanan.
Ini sebenernya betul bahkan untuk zaman sekarang karena memang orang tua
jarang naik kapal. Tapi di masa Titanic ini jelas banget datanya menjulur ke
kanan karena di tahun 1912 memang umur orang nggak sepanjang sekarang jd jmlh
orang tua memang lebih sedikit."

"Binwidth penting bgt disini, binwidth itu mengatur lebar dari masing2 age
group. Karena kita kasih 5 maka histogramnya bakal terbentuk untuk umur 0-5, 
6-10, 11-15, dst. Binwidth mungkin perlu dicari2 berapa yang paling cocok utk
analisa kita. Nggak ush takut untuk coba2 bbrp angka."

"Perhatikan juga bahwa ada warning message dari r mengenai missing value.
Sebelumnya gw emg udh tau bahwa ada 177 NA di data umur ini. Ggplot secara
otomatis akan mengabaikan NA dan bikin hist berdasarkan data yang ada."

"Sekarang bagaimana kalau kita pengen tau kemungkinan selamat berdasarkan umur
Kita cuman perlu tambahin argumen fill lagi."

ggplot(data = data_titanic, aes(x = Age, fill = Survived)) + 
  geom_histogram(binwidth = 5) +
  theme_bw() +
  labs(y = "Passenger Count", x = "Age",title = "Age Distribution")

"dari hasil hist nya kita bisa lihat bahwa memang kemungkinan selamat untuk
anak2 lebih tinggi, 0-10 tahun itu lebih dr 50%. Sementara liat untuk org
dewasa, kemunkginannya <50%. Yang menarik adalah bahwa hal ini tidak keliatan
dari sekadar melihat mean penumpang keseluruhan dan mean penumpang selamat.
Gw udh melakukan hal ini dan hasilnya adalah 29 dan 28 tahun. Ini perbedaan
yg terlalu kecil. Kemungkinan besar alasan kenapa perbedaannya kecil adalah
krn sebaran dari umur penumpang yang selamat kurang lebih sama dengan sebaran
umur seluruh penumpang. Makanya meannya sama. Hal ini bisa dilihat di plot yg
barusan kita buat, liat secara keseluruhan kemudian liat yg biru doang. Mirip
polanya, makanya meannya mirip juga."

"Adalah ide yang bagus untuk melihat sebuah data dengan banyak metode. Mari
kita lihat data umur penumpang dengan menggunakan boxplot"

ggplot(data = data_titanic, aes(x = Survived, y = Age)) + 
  geom_boxplot() +
  theme_bw() +
  labs(y = "Age", x = "Survived",title = "Survival Rate by Age")

"fungsi geom_boxplot() bakal ngasih kita boxplot dari data kita. Kasih label
x unutk survived dan y untuk age. Hasilnya adalah memang org2 yg survive itu
punya umur yang lebih rendah daripada yang mati. Tpi perbedaannya nggak jauh2
banget."

"Terakhir, bagaimana kalau kita mau lihat semuanya, kita mau lihat kemungkinan
selamat untuk semua penumpang dibagi berdasarkan sex, kelas, dan umur. Kita
akan bikin pake histogram digabung dengan fungsi facet_wrap"

ggplot(data = data_titanic, aes(x = Age, fill = Survived)) + 
  geom_histogram(binwidth = 5) +
  theme_bw() +
  facet_wrap(Sex ~ Pclass) +
  labs(y = "Age", x = "Survived",title = "Survival Rate by Age, Sex, and Class")

"Kita dapet hasilnya ada 6 grafik karena ada 2 sex dan 3 kelas kemudian dari
masing2 grafik, kita buat histogram umur penumpang, kemudian kita bagi
histogram itu berdasarkan survived atau tidak."
  
"Kita juga bisa bikin grafik yang sama tapi pake density graph. Caranya adlh
dengan menggunakan fungsi geom_density()"

ggplot(data = data_titanic, aes(x = Age, fill = Survived)) + 
  geom_density(alpha = 0.5) +
  theme_bw() +
  facet_wrap(Sex ~ Pclass) +
  labs(y = "Age", x = "Survived",title = "Survival Rate by Age, Sex, and Class")

"Kita dapet grafik yang sama dengan yang sebelumnya tapi kali ini lebih halus
karena pake densitas. Beberapa orang memang lebih suka melihat grafik densitas
dibandingkan dengan histogram. Alpha itu gunanya adalah supaya grafiknya sedikit
transparan jadinya kita bisa ngeliat kedua warna"
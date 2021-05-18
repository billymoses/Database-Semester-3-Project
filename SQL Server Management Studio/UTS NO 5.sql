CREATE TABLE PELANGGAN (
kode CHAR (3) NOT NULL PRIMARY KEY,
nama CHAR (10) NOT NULL,
alamat VARCHAR (100) NOT NULL,
jenis_kelamin CHAR (1) NOT NULL CHECK (jenis_kelamin LIKE 'L'
OR jenis_kelamin LIKE 'P'),
pekerjaan CHAR (15) NOT NULL,
tanggal_lahir DATE
)

INSERT INTO PELANGGAN
VALUES ('001', 'Arif', 'Jl. Permai No. 11 Jagakarsa', 'L', 'polisi', '1980-02-12'),
('002', 'Diana', 'Jl. Harum No.3 Depok', 'P', 'guru', '1984-05-11'),
('003', 'Fandi', 'Jl. Pusaka No. 5 Depok Jawa Barat', 'L', 'dokter', '1978-10-01');

SELECT * FROM PELANGGAN

CREATE TABLE KARYAWAN (
nik VARCHAR (4) NOT NULL PRIMARY KEY
CHECK (nik LIKE 'k[0-9][0-9][0-9]'),
nama CHAR (10) NOT NULL,
alamat VARCHAR (100) NOT NULL,
jenis_kelamin CHAR (1) NOT NULL CHECK (jenis_kelamin LIKE 'L'
OR jenis_kelamin LIKE 'P'),
tanggal_lahir DATE,
jabatan CHAR (10)
)

INSERT INTO KARYAWAN
VALUES ('k001', 'Anita', 'Lebak Bulus', 'P', '1988-05-10', 'kasir'),
('k002', 'Vita', 'Cakung', 'P', '1990-04-20', 'kasir');

SELECT * FROM KARYAWAN

CREATE TABLE BARANG (
kode VARCHAR (4) NOT NULL PRIMARY KEY
CHECK (kode LIKE 'b[0-9][0-9][0-9]'),
nama CHAR (15) NOT NULL,
harga_jual NUMERIC (10),
stok NUMERIC (6)
)

INSERT INTO BARANG
VALUES('b001','biskuit',30000,50),
('b002','Indomie',5000,200),
('b003','shampo',25000,15),
('b004','gunting',50000,100);

SELECT * FROM BARANG

CREATE TABLE TRANSAKSI (
kode VARCHAR (4) NOT NULL PRIMARY KEY
CHECK (kode LIKE 't[0-9][0-9][0-9]'),
nik_kasir VARCHAR (4) NOT NULL FOREIGN KEY REFERENCES KARYAWAN(nik),
tanggal DATE,
kode_pelanggan CHAR (3) NOT NULL FOREIGN KEY REFERENCES PELANGGAN(kode),
harga_total NUMERIC (10)
)

INSERT INTO TRANSAKSI 
VALUES('t001','k001','2015-02-16','002',250000),
('t002','k002','2015-03-04','002',150000), 
('t003','k002','2015-03-12','001',1100000);

SELECT * FROM TRANSAKSI

CREATE TABLE DETAIL_TRANS (
kode_trans VARCHAR (4) NOT NULL FOREIGN KEY REFERENCES TRANSAKSI (kode),
kode_barang VARCHAR (4) NOT NULL FOREIGN KEY REFERENCES BARANG(kode),
jumlah NUMERIC (4)
)

INSERT INTO DETAIL_TRANS
VALUES('t001','b002',40),
('t001','b003',2),
('t002','b001',5),
('t003','b003',4),
('t003','b004',20);

SELECT * FROM DETAIL_TRANS

-- a

SELECT
b.nama,
dt.jumlah AS 'total unit terjual'
FROM BARANG b
INNER JOIN DETAIL_TRANS dt ON dt.kode_barang = b.kode
INNER JOIN TRANSAKSI t ON t.kode = dt.kode_trans
WHERE DATEPART (MONTH, tanggal) = '3'
ORDER BY [total unit terjual] DESC

/*b.	Buatlah VIEW 
bernama PELANGGAN_KASIR yang menampilkan
kode transaksi, nama pelanggan, dan nama karyawan yang melayani transaksi tersebut (qunakan basic query). */

CREATE VIEW PELANGGAN_KASIR
AS SELECT TRANSAKSI.kode AS [kode transaksi],
PELANGGAN.nama AS [nama pelanggan],
KARYAWAN.nama AS [nama karyawan]
FROM TRANSAKSI, PELANGGAN, KARYAWAN
WHERE TRANSAKSI.nik_kasir = KARYAWAN.nik AND
TRANSAKSI.kode_pelanggan = PELANGGAN.kode

/*c.	Buatlah STORE PROCEDURE bernama HARGA_TOTAL
untuk menampilkan jumlah total harga barang yang dibeli untuk setiap transaksi.
(rumus harga total= jumlah barang+harga barang satuan) */

CREATE PROCEDURE HARGA_TOTAL
AS
SELECT TRANSAKSI.kode,
SUM(Jumlah*harga_jual) AS [harga total]
FROM TRANSAKSI, DETAIL_TRANS, BARANG
WHERE TRANSAKSI.kode = DETAIL_TRANS.kode_trans AND DETAIL_TRANS.kode_barang = BARANG.kode
GROUP BY TRANSAKSI.kode
GO

EXECUTE HARGA_TOTAL
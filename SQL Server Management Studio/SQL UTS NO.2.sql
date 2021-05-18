-- Modul for UTS no.2

CREATE TABLE KelasMahasiswa (
KodeKelasLecture CHAR (4) NOT NULL PRIMARY KEY CHECK (KodeKelasLecture LIKE 'L[A-Z][0-9][0-9]'),
NamaKelas VARCHAR (50) NOT NULL,
JumlahSKS NUMERIC (1) NOT NULL
)

CREATE TABLE Mahasiswa (
NIM NUMERIC (10) NOT NULL PRIMARY KEY,
NamaMahasiswa CHAR (50) NOT NULL,
KodeKelasLecture CHAR (4) NOT NULL FOREIGN KEY REFERENCES KelasMahasiswa(KodeKelasLecture)
)

INSERT INTO KelasMahasiswa
VALUES ('LA10', 'Database System', '4'),
('LA20', 'Database System', '4'),
('LA30', 'Database System', '4'),
('LA40', 'Database System', '4');


INSERT INTO Mahasiswa
VALUES ('2301900001', 'Gusti Ganteng 1', 'LA10'),
('2301900002', 'Gusti Ganteng 2', 'LA10'),
('2301900003', 'Gusti Ganteng 3', 'LA20'),
('2301900004', 'Gusti Ganteng 4', 'LA30'),
('2301900005', 'Gusti Ganteng 5', 'LA40');

SELECT * FROM KelasMahasiswa
SELECT * FROM Mahasiswa
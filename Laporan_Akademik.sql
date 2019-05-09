DROP TABLE DOSEN CASCADE CONSTRAINT PURGE;
DROP TABLE JADWAL_MATAKULIAH CASCADE CONSTRAINT PURGE;
DROP TABLE MAHASISWA CASCADE CONSTRAINT PURGE;
DROP TABLE MATAKULIAH_MAHASISWA CASCADE CONSTRAINT PURGE;
DROP TABLE MASTER_JURUSAN CASCADE CONSTRAINT PURGE;

/*==============================================================*/
/* Table: MASTER_JURUSAN */
/*==============================================================*/
CREATE TABLE MASTER_JURUSAN 
(
   KODE_MJ INTEGER NOT NULL,
   NAMA_MJ VARCHAR(30) NOT NULL,
   CONSTRAINT PK_MASTER_JURUSAN PRIMARY KEY (KODE_MJ)
);

/*==============================================================*/
/* Table: DOSEN */
/*==============================================================*/
CREATE TABLE DOSEN 
(
   KODE_DOSEN VARCHAR(10) NOT NULL,
   NAMA_DOSEN VARCHAR(50) NOT NULL,
   JK_DOSEN VARCHAR(1) NOT NULL CHECK(JK_DOSEN='L' OR JK_DOSEN='P'),
   EMAIL_DOSEN VARCHAR(50) NOT NULL,
   ALAMAT_DOSEN VARCHAR(50) NOT NULL,
   TELP_DOSEN VARCHAR(20) NOT NULL,
   STATUS_DOSEN VARCHAR(15) NOT NULL CHECK(STATUS_DOSEN='Tetap' OR STATUS_DOSEN='Tidak Tetap'),
   CONSTRAINT PK_DOSEN PRIMARY KEY (KODE_DOSEN)
);

/*==============================================================*/
/* Table: JADWAL_MATAKULIAH */
/*==============================================================*/
CREATE TABLE JADWAL_MATAKULIAH 
(
   KODE_MK VARCHAR(10) NOT NULL,
   NAMA_MK VARCHAR(30) NOT NULL,
   JURUSAN_MK VARCHAR(30) NOT NULL,
   SMST_MK INTEGER NOT NULL CHECK(SMST_MK>0 AND SMST_MK<=8),
   SKS_MATKUL INTEGER NOT NULL CHECK(SKS_MATKUL>=2 AND SKS_MATKUL<=4),
   KELAS_MK VARCHAR(1) NOT NULL CHECK(KELAS_MK='A' OR KELAS_MK='B' OR KELAS_MK='C'),
   HARI_MK VARCHAR(10) NOT NULL CHECK(HARI_MK='Senin' OR HARI_MK='Selasa' OR HARI_MK='Rabu' OR HARI_MK='Kamis' OR HARI_MK='Jumat'),
   JAM_MK VARCHAR(10) NOT NULL,
   RUANG_MK VARCHAR(10) NOT NULL,
   KODE_PENGAJAR VARCHAR(10) REFERENCES DOSEN(KODE_DOSEN)
);

/*==============================================================*/
/* Table: MAHASISWA */
/*==============================================================*/
CREATE TABLE MAHASISWA 
(
   NRP_MHS INTEGER NOT NULL,
   THN_REG INTEGER NOT NULL,
   NAMA_MHS VARCHAR(50) NOT NULL,
   JURUSAN_MHS VARCHAR(40) NOT NULL,
   KELAS_MHS VARCHAR(1) NOT NULL CHECK(KELAS_MHS='A' OR KELAS_MHS='B' OR KELAS_MHS='C'),
   TGL_LAHIR_MHS DATE NOT NULL,
   JK_MHS VARCHAR(1) NOT NULL CHECK(JK_MHS='L' OR JK_MHS='P'),
   EMAIL_MHS VARCHAR(50) NOT NULL,
   ALAMAT_MHS VARCHAR(50) NOT NULL,
   TELP_MHS VARCHAR(20) NOT NULL,
   STATUS_MHS VARCHAR(15) NOT NULL CHECK(STATUS_MHS='Aktif' OR STATUS_MHS='Cuti' OR STATUS_MHS='Tidak Aktif'),
   KODE_DOSEN_WALI VARCHAR(10) NOT NULL REFERENCES DOSEN(KODE_DOSEN),
   CONSTRAINT PK_MAHASISWA PRIMARY KEY (NRP_MHS)
);

/*==============================================================*/
/* Table: MATAKULIAH_MAHASISWA */
/*==============================================================*/
CREATE TABLE MATAKULIAH_MAHASISWA 
(
   NRP_MHS INTEGER NOT NULL REFERENCES MAHASISWA(NRP_MHS),
   KODE_MATKUL VARCHAR(10) NOT NULL,
   NILAI_UTS INTEGER NOT NULL CHECK(NILAI_UTS>=0 AND NILAI_UTS<=100),
   NILAI_UAS INTEGER NOT NULL CHECK(NILAI_UAS>=0 AND NILAI_UAS<=100),
   NILAI_AKHIR INTEGER NOT NULL CHECK(NILAI_AKHIR>=0 AND NILAI_AKHIR<=100),
   GRADE VARCHAR(1) NOT NULL CHECK(GRADE='A' OR GRADE='B' OR GRADE='C' OR GRADE='D' OR GRADE='E'),
   STATUS_MATKUL VARCHAR(15) NOT NULL CHECK(STATUS_MATKUL='Lulus' OR STATUS_MATKUL='Tidak Lulus'),
   KE INTEGER NOT NULL CHECK(KE>0 AND KE<=10)
);

INSERT INTO MASTER_JURUSAN VALUES(116,'Teknik Informatika');
INSERT INTO MASTER_JURUSAN VALUES(180,'Sistem Informasi Bisnis');
INSERT INTO MASTER_JURUSAN VALUES(170,'Desain Komunikasi Visual');
INSERT INTO MASTER_JURUSAN VALUES(140,'Desain Produk');
INSERT INTO MASTER_JURUSAN VALUES(102,'Teknik Elektro');
INSERT INTO MASTER_JURUSAN VALUES(120,'Teknik Industri');

CREATE OR REPLACE TRIGGER INSERTJURUSAN
BEFORE INSERT ON MASTER_JURUSAN
FOR EACH ROW
DECLARE
   CTR INTEGER; RAN INTEGER;
BEGIN
   LOOP
      RAN:=DBMS_RANDOM.VALUE(100,999);
      SELECT COUNT(KODE_MJ) INTO CTR FROM MASTER_JURUSAN WHERE KODE_MJ=RAN;
      EXIT WHEN CTR<1;
   END LOOP; :NEW.KODE_MJ:=RAN;
END;
/  
SHOW ERR;

INSERT INTO MASTER_JURUSAN VALUES(0,'Psikologi');

INSERT INTO DOSEN VALUES('TM001','Tamariska Marcelline','P','tamariskacelline@gmail.com','jalan Ahmad No. 12','081384552458','Tetap');
INSERT INTO DOSEN VALUES('AG001','Agatha','P','agatha@gmail.com','jalan Kendari blok AA No. 57','085911274387','Tetap');
INSERT INTO DOSEN VALUES('TM002','Tony Mario','L','tonym@gmail.com','jalan Kupang Jaya gang XV No. 66','085143358003','Tetap');
INSERT INTO DOSEN VALUES('DT001','Devina Tammy','P','devi@gmail.com','jalan Bukittinggi No. 129','085427380075','Tetap');
INSERT INTO DOSEN VALUES('GG001','Goofy Gunardi Setiawan','L','goofygs@rocketmail.com','jalan Kertajaya blok I No. 04','082416987873','Tetap');
INSERT INTO DOSEN VALUES('KS001','Kushno Santoso','L','kushno@gmail.com','jalan Villa Regensi blok III No. 16','081680590957','Tetap');
INSERT INTO DOSEN VALUES('IR001','Indah Rejeki','P','indahrejeki@yahoo.com','jalan Villa Bukit Merah blok AC No. 110','083255125830','Tetap');
INSERT INTO DOSEN VALUES('MK001','Metta Karimun','P','metta@yahoo.com','jalan Anggur Merah No. 41','083255125830','Tetap');
INSERT INTO DOSEN VALUES('SS001','Sekar Sari','P','sekarsari@yahoo.com','jalan Anggur Putih No. 16','083673927839','Tidak Tetap');
INSERT INTO DOSEN VALUES('RG001','Robyn Gunawan','L','robyng@yahoo.com','jalan Tinjauan No. 306','085630165125','Tidak Tetap');

CREATE OR REPLACE TRIGGER INSERTDOSEN
BEFORE INSERT ON DOSEN
FOR EACH ROW
DECLARE 
   JUMKAT NUMBER; IDM NUMBER; NM VARCHAR2(10); CH CHAR; ERR EXCEPTION;
BEGIN
   LOOP
      CH:=SUBSTR(:NEW.NAMA_DOSEN,1,1);
      IF CH=' ' THEN
         CH:=REPLACE(:NEW.NAMA_DOSEN,' ','');
      END IF;
      EXIT WHEN CH!=' ';
   END LOOP;
   IF LENGTH(:NEW.NAMA_DOSEN)<2 THEN
      RAISE ERR;
   ELSE
      JUMKAT:=LENGTH(:NEW.NAMA_DOSEN)-LENGTH(REPLACE(:NEW.NAMA_DOSEN,' ',''))+1;
      IF JUMKAT<2 THEN
         NM:=UPPER(SUBSTR(:NEW.NAMA_DOSEN,1,2));
      ELSE
         NM:=SUBSTR(:NEW.NAMA_DOSEN,1,1)||SUBSTR(:NEW.NAMA_DOSEN,INSTR(:NEW.NAMA_DOSEN,' ')+1,1);
      END IF;
      SELECT MAX(SUBSTR(KODE_DOSEN,3,3))+1 INTO IDM FROM DOSEN WHERE SUBSTR(KODE_DOSEN,1,2)=NM;
      IF IDM IS NULL THEN IDM:=1; 
      END IF;
      :NEW.KODE_DOSEN:=UPPER(NM)||LPAD(IDM,3,0);
   END IF;
EXCEPTION
   WHEN ERR THEN
      RAISE_APPLICATION_ERROR(-20000,'Panjang Nama Dosen harus lebih dari satu huruf');
END;
/  
SHOW ERR;

INSERT INTO DOSEN VALUES('','Randi Setiadi','L','randis@yahoo.com','jalan Kunjungan No. 68','085169535125','Tetap');

CREATE OR REPLACE TRIGGER INSERTMK
BEFORE INSERT ON JADWAL_MATAKULIAH
FOR EACH ROW
DECLARE
   JUR NUMBER; JUM NUMBER; NOKODE NUMBER; CEKKELAS INTEGER; IND INTEGER; KOD VARCHAR2(10); ERR EXCEPTION; ERR2 EXCEPTION;
BEGIN
   IF :NEW.JURUSAN_MK='Teknik Informatika' THEN SELECT COUNT(*) INTO JUR FROM JADWAL_MATAKULIAH WHERE JURUSAN_MK=:NEW.JURUSAN_MK;
      IF JUR>0 THEN SELECT COUNT(NAMA_MK) INTO JUM FROM JADWAL_MATAKULIAH WHERE NAMA_MK=:NEW.NAMA_MK AND JURUSAN_MK=:NEW.JURUSAN_MK;
         IF JUM>0 THEN SELECT COUNT(*) INTO CEKKELAS FROM JADWAL_MATAKULIAH WHERE KELAS_MK=:NEW.KELAS_MK AND JURUSAN_MK=:NEW.JURUSAN_MK AND NAMA_MK=:NEW.NAMA_MK;
            IF CEKKELAS>=1 THEN RAISE ERR;
            ELSE SELECT MAX(SUBSTR(KODE_MK,4,3)) INTO NOKODE FROM JADWAL_MATAKULIAH WHERE NAMA_MK=:NEW.NAMA_MK AND JURUSAN_MK=:NEW.JURUSAN_MK;
            END IF;
         ELSE SELECT MAX(SUBSTR(KODE_MK,4,3))+1 INTO NOKODE FROM JADWAL_MATAKULIAH WHERE JURUSAN_MK=:NEW.JURUSAN_MK;
         END IF; 
      ELSE NOKODE:=1;
      END IF; :NEW.KODE_MK:=UPPER(SUBSTR(:NEW.JURUSAN_MK,INSTR(:NEW.JURUSAN_MK,' ')+1,3))||LPAD(NOKODE,3,0);
   ELSIF :NEW.JURUSAN_MK='Sistem Informasi Bisnis' THEN SELECT COUNT(*) INTO JUR FROM JADWAL_MATAKULIAH WHERE JURUSAN_MK=:NEW.JURUSAN_MK;
      IF JUR>0 THEN SELECT COUNT(NAMA_MK) INTO JUM FROM JADWAL_MATAKULIAH WHERE NAMA_MK=:NEW.NAMA_MK AND JURUSAN_MK=:NEW.JURUSAN_MK;
         IF JUM>0 THEN SELECT COUNT(*) INTO CEKKELAS FROM JADWAL_MATAKULIAH WHERE KELAS_MK=:NEW.KELAS_MK AND JURUSAN_MK=:NEW.JURUSAN_MK AND NAMA_MK=:NEW.NAMA_MK;
            IF CEKKELAS>=1 THEN RAISE ERR;
            ELSE SELECT MAX(SUBSTR(KODE_MK,4,3)) INTO NOKODE FROM JADWAL_MATAKULIAH WHERE NAMA_MK=:NEW.NAMA_MK AND JURUSAN_MK=:NEW.JURUSAN_MK;
            END IF;
         ELSE SELECT MAX(SUBSTR(KODE_MK,4,3))+1 INTO NOKODE FROM JADWAL_MATAKULIAH WHERE JURUSAN_MK=:NEW.JURUSAN_MK;
         END IF; 
      ELSE NOKODE:=1;
      END IF; :NEW.KODE_MK:='SIB'||LPAD(NOKODE,3,0);
   ELSIF :NEW.JURUSAN_MK='Desain Komunikasi Visual' THEN SELECT COUNT(*) INTO JUR FROM JADWAL_MATAKULIAH WHERE JURUSAN_MK=:NEW.JURUSAN_MK;
      IF JUR>0 THEN SELECT COUNT(NAMA_MK) INTO JUM FROM JADWAL_MATAKULIAH WHERE NAMA_MK=:NEW.NAMA_MK AND JURUSAN_MK=:NEW.JURUSAN_MK;
         IF JUM>0 THEN SELECT COUNT(*) INTO CEKKELAS FROM JADWAL_MATAKULIAH WHERE KELAS_MK=:NEW.KELAS_MK AND JURUSAN_MK=:NEW.JURUSAN_MK AND NAMA_MK=:NEW.NAMA_MK;
            IF CEKKELAS>=1 THEN RAISE ERR;
            ELSE SELECT MAX(SUBSTR(KODE_MK,4,3)) INTO NOKODE FROM JADWAL_MATAKULIAH WHERE NAMA_MK=:NEW.NAMA_MK AND JURUSAN_MK=:NEW.JURUSAN_MK;
            END IF;
         ELSE SELECT MAX(SUBSTR(KODE_MK,4,3))+1 INTO NOKODE FROM JADWAL_MATAKULIAH WHERE JURUSAN_MK=:NEW.JURUSAN_MK;
         END IF; 
      ELSE NOKODE:=1;
      END IF; :NEW.KODE_MK:='DKV'||LPAD(NOKODE,3,0);
   ELSIF :NEW.JURUSAN_MK='Desain Produk' THEN SELECT COUNT(*) INTO JUR FROM JADWAL_MATAKULIAH WHERE JURUSAN_MK=:NEW.JURUSAN_MK;
      IF JUR>0 THEN SELECT COUNT(NAMA_MK) INTO JUM FROM JADWAL_MATAKULIAH WHERE NAMA_MK=:NEW.NAMA_MK AND JURUSAN_MK=:NEW.JURUSAN_MK;
         IF JUM>0 THEN SELECT COUNT(*) INTO CEKKELAS FROM JADWAL_MATAKULIAH WHERE KELAS_MK=:NEW.KELAS_MK AND JURUSAN_MK=:NEW.JURUSAN_MK AND NAMA_MK=:NEW.NAMA_MK;
            IF CEKKELAS>=1 THEN RAISE ERR;
            ELSE SELECT MAX(SUBSTR(KODE_MK,4,3)) INTO NOKODE FROM JADWAL_MATAKULIAH WHERE NAMA_MK=:NEW.NAMA_MK AND JURUSAN_MK=:NEW.JURUSAN_MK;
            END IF;
         ELSE SELECT MAX(SUBSTR(KODE_MK,4,3))+1 INTO NOKODE FROM JADWAL_MATAKULIAH WHERE JURUSAN_MK=:NEW.JURUSAN_MK;
         END IF; 
      ELSE NOKODE:=1;
      END IF; :NEW.KODE_MK:=UPPER(SUBSTR(:NEW.JURUSAN_MK,1,3))||LPAD(NOKODE,3,0);
   ELSIF :NEW.JURUSAN_MK='Teknik Elektro' THEN SELECT COUNT(*) INTO JUR FROM JADWAL_MATAKULIAH WHERE JURUSAN_MK=:NEW.JURUSAN_MK;
      IF JUR>0 THEN SELECT COUNT(NAMA_MK) INTO JUM FROM JADWAL_MATAKULIAH WHERE NAMA_MK=:NEW.NAMA_MK AND JURUSAN_MK=:NEW.JURUSAN_MK;
         IF JUM>0 THEN SELECT COUNT(*) INTO CEKKELAS FROM JADWAL_MATAKULIAH WHERE KELAS_MK=:NEW.KELAS_MK AND JURUSAN_MK=:NEW.JURUSAN_MK AND NAMA_MK=:NEW.NAMA_MK;
            IF CEKKELAS>=1 THEN RAISE ERR;
            ELSE SELECT MAX(SUBSTR(KODE_MK,4,3)) INTO NOKODE FROM JADWAL_MATAKULIAH WHERE NAMA_MK=:NEW.NAMA_MK AND JURUSAN_MK=:NEW.JURUSAN_MK;
            END IF;
         ELSE SELECT MAX(SUBSTR(KODE_MK,4,3))+1 INTO NOKODE FROM JADWAL_MATAKULIAH WHERE JURUSAN_MK=:NEW.JURUSAN_MK;
         END IF; 
      ELSE NOKODE:=1;
      END IF; :NEW.KODE_MK:='ELK'||LPAD(NOKODE,3,0);
   ELSIF :NEW.JURUSAN_MK='Teknik Industri' THEN SELECT COUNT(*) INTO JUR FROM JADWAL_MATAKULIAH WHERE JURUSAN_MK=:NEW.JURUSAN_MK;
      IF JUR>0 THEN SELECT COUNT(NAMA_MK) INTO JUM FROM JADWAL_MATAKULIAH WHERE NAMA_MK=:NEW.NAMA_MK AND JURUSAN_MK=:NEW.JURUSAN_MK;
         IF JUM>0 THEN SELECT COUNT(*) INTO CEKKELAS FROM JADWAL_MATAKULIAH WHERE KELAS_MK=:NEW.KELAS_MK AND JURUSAN_MK=:NEW.JURUSAN_MK AND NAMA_MK=:NEW.NAMA_MK;
            IF CEKKELAS>=1 THEN RAISE ERR;
            ELSE SELECT MAX(SUBSTR(KODE_MK,4,3)) INTO NOKODE FROM JADWAL_MATAKULIAH WHERE NAMA_MK=:NEW.NAMA_MK AND JURUSAN_MK=:NEW.JURUSAN_MK;
            END IF;
         ELSE SELECT MAX(SUBSTR(KODE_MK,4,3))+1 INTO NOKODE FROM JADWAL_MATAKULIAH WHERE JURUSAN_MK=:NEW.JURUSAN_MK;
         END IF; 
      ELSE NOKODE:=1;
      END IF; :NEW.KODE_MK:=UPPER(SUBSTR(:NEW.JURUSAN_MK,INSTR(:NEW.JURUSAN_MK,' ')+1,3))||LPAD(NOKODE,3,0);
   ELSE
      IF LENGTH(:NEW.JURUSAN_MK)<3 THEN RAISE ERR2;
      ELSE JUM:=LENGTH(:NEW.JURUSAN_MK)-LENGTH(REPLACE(:NEW.JURUSAN_MK,' ',''))+1;
         IF JUM<2 THEN IND:=1; KOD:=''; LOOP IF SUBSTR(:NEW.JURUSAN_MK,IND,1)<>' ' THEN KOD:=KOD||UPPER(SUBSTR(:NEW.JURUSAN_MK,IND,1));
               END IF; IND:=IND+1; EXIT WHEN LENGTH(KOD)=3; END LOOP;
         ELSE KOD:=UPPER(SUBSTR(:NEW.JURUSAN_MK,INSTR(:NEW.JURUSAN_MK,' ')+1,3));
         END IF;
      END IF;
      SELECT COUNT(*) INTO JUM FROM JADWAL_MATAKULIAH WHERE SUBSTR(KODE_MK,1,3)=KOD;
      IF JUM>0 THEN SELECT COUNT(*) INTO JUR FROM JADWAL_MATAKULIAH WHERE JURUSAN_MK=:NEW.JURUSAN_MK AND SUBSTR(KODE_MK,1,3)=KOD;
         IF JUR>0 THEN SELECT COUNT(NAMA_MK) INTO JUM FROM JADWAL_MATAKULIAH WHERE NAMA_MK=:NEW.NAMA_MK AND JURUSAN_MK=:NEW.JURUSAN_MK;
            IF JUM>0 THEN SELECT COUNT(*) INTO CEKKELAS FROM JADWAL_MATAKULIAH WHERE KELAS_MK=:NEW.KELAS_MK AND JURUSAN_MK=:NEW.JURUSAN_MK AND NAMA_MK=:NEW.NAMA_MK;
               IF CEKKELAS>=1 THEN RAISE ERR;
               ELSE SELECT MAX(SUBSTR(KODE_MK,4,3)) INTO NOKODE FROM JADWAL_MATAKULIAH WHERE NAMA_MK=:NEW.NAMA_MK AND JURUSAN_MK=:NEW.JURUSAN_MK;
               END IF;
            ELSE SELECT MAX(SUBSTR(KODE_MK,4,3))+1 INTO NOKODE FROM JADWAL_MATAKULIAH WHERE JURUSAN_MK=:NEW.JURUSAN_MK;
            END IF;      
         ELSE KOD:=''; LOOP KOD:=KOD||SUBSTR('ABCDEFGHIJKLMNOPQRSTUVWXYZ',DBMS_RANDOM.VALUE(1,26),1); 
            EXIT WHEN LENGTH(KOD)=3; END LOOP; NOKODE:=1;
         END IF;
      ELSE NOKODE:=1;
      END IF; 
      SELECT COUNT(*) INTO JUM FROM JADWAL_MATAKULIAH WHERE JURUSAN_MK=:NEW.JURUSAN_MK;
      IF JUM>0 THEN KOD:=''; SELECT MAX(SUBSTR(KODE_MK,1,3)) INTO KOD FROM JADWAL_MATAKULIAH WHERE JURUSAN_MK=:NEW.JURUSAN_MK;
         SELECT COUNT(*) INTO JUR FROM JADWAL_MATAKULIAH WHERE JURUSAN_MK=:NEW.JURUSAN_MK AND SUBSTR(KODE_MK,1,3)=KOD;
         IF JUR>0 THEN SELECT COUNT(NAMA_MK) INTO JUM FROM JADWAL_MATAKULIAH WHERE NAMA_MK=:NEW.NAMA_MK AND JURUSAN_MK=:NEW.JURUSAN_MK AND SUBSTR(KODE_MK,1,3)=KOD;
            IF JUM>0 THEN SELECT COUNT(*) INTO CEKKELAS FROM JADWAL_MATAKULIAH WHERE KELAS_MK=:NEW.KELAS_MK AND JURUSAN_MK=:NEW.JURUSAN_MK AND NAMA_MK=:NEW.NAMA_MK AND SUBSTR(KODE_MK,1,3)=KOD;
               IF CEKKELAS>=1 THEN RAISE ERR;
               ELSE SELECT MAX(SUBSTR(KODE_MK,4,3)) INTO NOKODE FROM JADWAL_MATAKULIAH WHERE NAMA_MK=:NEW.NAMA_MK AND JURUSAN_MK=:NEW.JURUSAN_MK AND SUBSTR(KODE_MK,1,3)=KOD;
               END IF;
            ELSE SELECT MAX(SUBSTR(KODE_MK,4,3))+1 INTO NOKODE FROM JADWAL_MATAKULIAH WHERE JURUSAN_MK=:NEW.JURUSAN_MK AND SUBSTR(KODE_MK,1,3)=KOD;
            END IF;      
         ELSE KOD:=''; LOOP KOD:=KOD||SUBSTR('ABCDEFGHIJKLMNOPQRSTUVWXYZ',DBMS_RANDOM.VALUE(1,26),1); 
            EXIT WHEN LENGTH(KOD)=3; END LOOP; NOKODE:=1;
         END IF;
      END IF; :NEW.KODE_MK:=KOD||LPAD(NOKODE,3,0);
   END IF;
EXCEPTION
   WHEN ERR THEN RAISE_APPLICATION_ERROR(-20000,'Kelas sudah tersedia');
   WHEN ERR2 THEN RAISE_APPLICATION_ERROR(-20001,'Panjang Nama Jurusan harus minimal tiga huruf');
END;
/
SHOW ERR;

INSERT INTO JADWAL_MATAKULIAH VALUES('','Bahasa Indonesia','Teknik Informatika',1,3,'B','Selasa','15.30','U-401','TM001');
INSERT INTO JADWAL_MATAKULIAH VALUES('','Bahasa Indonesia','Teknik Informatika',1,3,'A','Selasa','15.30','U-401','TM001');
INSERT INTO JADWAL_MATAKULIAH VALUES('','Bahasa Inggris','Teknik Informatika',1,3,'C','Selasa','15.30','U-401','TM001');
INSERT INTO JADWAL_MATAKULIAH VALUES('','Bahasa Romawi','Teknik Informatika',1,3,'B','Selasa','15.30','U-401','TM001');
INSERT INTO JADWAL_MATAKULIAH VALUES('','Bahasa Perancis','Teknik Informatika',1,3,'A','Selasa','15.30','U-401','TM001');
INSERT INTO JADWAL_MATAKULIAH VALUES('','Bahasa Rusia','Teknik Informatika',1,3,'A','Selasa','15.30','U-401','TM001');
INSERT INTO JADWAL_MATAKULIAH VALUES('','Pendidikan Kewarganegaraan','Teknik Informatika',1,3,'C','Selasa','15.30','U-401','TM001');
INSERT INTO JADWAL_MATAKULIAH VALUES('','Bahasa Rusia','Bahasa',1,3,'A','Selasa','15.30','U-401','TM001');
INSERT INTO JADWAL_MATAKULIAH VALUES('','Bahasa Rusia','Ilmu Komunikasi',1,3,'A','Selasa','15.30','U-401','TM001');
INSERT INTO JADWAL_MATAKULIAH VALUES('','Pendidikan Kewarganegaraan','Desain Komunikasi Visual',2,3,'A','Senin','08.00','E-305','DT001');

INSERT INTO JADWAL_MATAKULIAH VALUES('','Budi Pekerti','Desain Interior',2,3,'B','Senin','08.00','E-305','DT001');
INSERT INTO JADWAL_MATAKULIAH VALUES('','Geografi','Desain Interior',2,3,'A','Senin','08.00','E-305','DT001');
INSERT INTO JADWAL_MATAKULIAH VALUES('','Sejarah','Desain Interior',2,3,'B','Senin','08.00','E-305','DT001');
INSERT INTO JADWAL_MATAKULIAH VALUES('','Budi Pekerti','Ahli Interior',2,3,'A','Senin','08.00','E-305','DT001');
INSERT INTO JADWAL_MATAKULIAH VALUES('','Geografi','Ahli Interior',2,3,'B','Senin','08.00','E-305','DT001');
INSERT INTO JADWAL_MATAKULIAH VALUES('','Sejarah','Ahli Interior',2,3,'A','Senin','08.00','E-305','DT001');
INSERT INTO JADWAL_MATAKULIAH VALUES('','Matematika','Ahli Interior',2,3,'B','Senin','08.00','E-305','DT001');
INSERT INTO JADWAL_MATAKULIAH VALUES('','Sejarah','Farmasi',2,3,'A','Senin','08.00','E-305','DT001');
INSERT INTO JADWAL_MATAKULIAH VALUES('','Sejarah1','Farmasi',2,3,'B','Senin','08.00','E-305','DT001');
INSERT INTO JADWAL_MATAKULIAH VALUES('','Sejarah2','Farmasi',2,3,'B','Senin','08.00','E-305','DT001');

INSERT INTO JADWAL_MATAKULIAH VALUES('','Pemrograman Client Server','Teknik Informatika',4,3,'A','Jumat','10.30','L-204','TM002');
INSERT INTO JADWAL_MATAKULIAH VALUES('','Pemrograman Client Server','Sistem Informasi Bisnis',4,3,'C','Jumat','10.30','L-304','TM001');
INSERT INTO JADWAL_MATAKULIAH VALUES('','Akuntansi','Sistem Informasi Bisnis',4,2,'A','Jumat','10.30','U-303','TM001');
INSERT INTO JADWAL_MATAKULIAH VALUES('','Akuntansi','Sistem Informasi Bisnis',4,2,'B','Jumat','10.30','U-102','GG001');
INSERT INTO JADWAL_MATAKULIAH VALUES('','Sistem Digital','Teknik Elektro',1,3,'A','Kamis','10.30','L-102','KS001');
INSERT INTO JADWAL_MATAKULIAH VALUES('','Kalkulus 3','Teknik Industri',6,3,'B','Kamis','10.30','B-304','IR001');
INSERT INTO JADWAL_MATAKULIAH VALUES('','Teknik Desain','Desain Produk',2,2,'A','Rabu','13.00','E-301','MK001');
INSERT INTO JADWAL_MATAKULIAH VALUES('','Software Design Pattern','Teknik Informatika',7,3,'A','Rabu','13.00','U-401','TM002');
INSERT INTO JADWAL_MATAKULIAH VALUES('','Software Design Pattern','Teknik Informatika',7,3,'B','Rabu','13.00','U-401','TM002');

CREATE OR REPLACE TRIGGER INSERTMHS
BEFORE INSERT ON MAHASISWA
FOR EACH ROW
DECLARE
   NOM VARCHAR2(5); NOM1 VARCHAR2(5); NOM2 NUMBER; RAN2 VARCHAR2(5); RN1 NUMBER(5); NONRP NUMBER;
BEGIN
   NOM:=SUBSTR(:NEW.THN_REG,1,1)||SUBSTR(:NEW.THN_REG,3,2);
   IF :NEW.JURUSAN_MHS='Teknik Informatika' THEN NOM1:='116';
   ELSIF :NEW.JURUSAN_MHS='Sistem Informasi Bisnis' THEN NOM1:='180';
   ELSIF :NEW.JURUSAN_MHS='Desain Komunikasi Visual' THEN NOM1:='170';
   ELSIF :NEW.JURUSAN_MHS='Desain Produk' THEN NOM1:='140';
   ELSIF :NEW.JURUSAN_MHS='Teknik Elektro' THEN NOM1:='102';
   ELSIF :NEW.JURUSAN_MHS='Teknik Industri' THEN NOM1:='120';
   ELSE SELECT COUNT(*) INTO NOM2 FROM MAHASISWA WHERE JURUSAN_MHS=:NEW.JURUSAN_MHS;
      IF NOM2>0 THEN SELECT MAX(SUBSTR(NRP_MHS,4,3)) INTO NOM1 FROM MAHASISWA WHERE JURUSAN_MHS=:NEW.JURUSAN_MHS;
         SELECT MAX(SUBSTR(NRP_MHS,7,3))+1 INTO NONRP FROM MAHASISWA WHERE JURUSAN_MHS=:NEW.JURUSAN_MHS; 
      ELSE RN1:=DBMS_RANDOM.VALUE(1,400); NOM1:=LPAD(RN1,3,0); NONRP:=1;
      END IF;
   END IF; RAN2:=LPAD(NONRP,3,0); :NEW.NRP_MHS:=NOM||NOM1||RAN2;
   IF :NEW.JURUSAN_MHS='Teknik Informatika' OR :NEW.JURUSAN_MHS='Sistem Informasi Bisnis' OR :NEW.JURUSAN_MHS='Desain Komunikasi Visual' 
   OR :NEW.JURUSAN_MHS='Desain Produk' OR :NEW.JURUSAN_MHS='Teknik Elektro' OR :NEW.JURUSAN_MHS='Teknik Industri' THEN
      SELECT COUNT(*) INTO NOM2 FROM MAHASISWA WHERE JURUSAN_MHS=:NEW.JURUSAN_MHS;
      IF NOM2>0 THEN SELECT MAX(SUBSTR(NRP_MHS,7,3))+1 INTO NONRP FROM MAHASISWA WHERE JURUSAN_MHS=:NEW.JURUSAN_MHS; 
      ELSE NONRP:=1; END IF; RAN2:=LPAD(NONRP,3,0); :NEW.NRP_MHS:=NOM||NOM1||RAN2;
   END IF;
END;
/
SHOW ERR;

INSERT INTO MAHASISWA VALUES(0,2016,'Edwin Lo','Teknik Informatika','B',TO_DATE('24-06-1998', 'DD-MM-YYYY'),'L','edwin@gmail.com','SDPS Gang 15 No. 150','082337123047','Aktif','TM002');
INSERT INTO MAHASISWA VALUES(0,2015,'Matalangit Zerafim','Teknik Informatika','A',TO_DATE('05-09-1997', 'DD-MM-YYYY'),'L','matalangit@yahoo.com','jalan Kertajaya No. 225','083521375645','Aktif','TM001');
INSERT INTO MAHASISWA VALUES(0,2018,'Ricardo','Teknik Elektro','C',TO_DATE('01-11-2000', 'DD-MM-YYYY'),'L','ricardo@yahoo.com','jalan Bukit Indah No. 02','083521375645','Cuti','KS001');
INSERT INTO MAHASISWA VALUES(0,2018,'Fransisca Maria','Teknik Industri','A',TO_DATE('06-06-2000', 'DD-MM-YYYY'),'P','maria@gmail.com','jalan Melati Putih No. 13','031177006868','Aktif','IR001');
INSERT INTO MAHASISWA VALUES(0,2016,'Fanny Kusuma','Desain Produk','A',TO_DATE('27-08-1998', 'DD-MM-YYYY'),'P','sunny@gmail.com','jalan Pelangi No. 149','085948133712','Tidak Aktif','MK001');
INSERT INTO MAHASISWA VALUES(0,2017,'Hansen Oetomo','Desain Komunikasi Visual','B',TO_DATE('12-10-1999', 'DD-MM-YYYY'),'L','hansen@gmail.com','jalan Surakarta No. 09','081029124149','Cuti','DT001');
INSERT INTO MAHASISWA VALUES(0,2016,'Philip Cahya','Sistem Informasi Bisnis','C',TO_DATE('28-02-1998', 'DD-MM-YYYY'),'L','philip@gmail.com','jalan Sekarjaya Blok C No. 34','085600402155','Tidak Aktif','GG001');
INSERT INTO MAHASISWA VALUES(0,2016,'Karent Finnartha','Teknik Informatika','B',TO_DATE('24-06-1998', 'DD-MM-YYYY'),'L','karent@gmail.com','SDPS Gang 15 No. 150','082337123047','Aktif','TM002');
INSERT INTO MAHASISWA VALUES(0,2015,'Steven Kwan','Teknik Sipil','A',TO_DATE('05-09-1997', 'DD-MM-YYYY'),'L','steve@yahoo.com','jalan Kertajaya No. 225','083521375645','Aktif','TM001');
INSERT INTO MAHASISWA VALUES(0,2018,'Henny Widayanti','Desain Interior','C',TO_DATE('01-11-2000', 'DD-MM-YYYY'),'P','henny@yahoo.com','jalan Bukit Indah No. 02','083521375645','Cuti','KS001');
INSERT INTO MAHASISWA VALUES(0,2018,'Olive Liman','Pariwisata','A',TO_DATE('06-06-2000', 'DD-MM-YYYY'),'P','olive@gmail.com','jalan Melati Putih No. 13','031177006868','Aktif','IR001');
INSERT INTO MAHASISWA VALUES(0,2016,'Hana Regina','Arsitek','A',TO_DATE('27-08-1998', 'DD-MM-YYYY'),'P','hana@gmail.com','jalan Pelangi No. 149','085948133712','Tidak Aktif','MK001');
INSERT INTO MAHASISWA VALUES(0,2017,'Rico Sumargo','Desain Komunikasi Visual','B',TO_DATE('12-10-1999', 'DD-MM-YYYY'),'L','rico@gmail.com','jalan Surakarta No. 09','081029124149','Cuti','DT001');
INSERT INTO MAHASISWA VALUES(0,2016,'Hendarto Wijaya','Sistem Informasi Bisnis','C',TO_DATE('28-02-1998', 'DD-MM-YYYY'),'L','hendartowijaya@gmail.com','jalan Sekarjaya Blok C No. 34','085600402155','Tidak Aktif','GG001');
INSERT INTO MAHASISWA VALUES(0,2012,'Danny Hendrawan','Teknik Nuklir','C',TO_DATE('28-02-1998', 'DD-MM-YYYY'),'L','danny@gmail.com','jalan Sekarjaya Blok C No. 34','085600402155','Tidak Aktif','GG001');

CREATE OR REPLACE TRIGGER INSERTMKMAHASISWA
BEFORE INSERT ON MATAKULIAH_MAHASISWA
FOR EACH ROW
DECLARE
   CEK NUMBER; ERR EXCEPTION; ERR2 EXCEPTION;
BEGIN
   SELECT COUNT(NRP_MHS) INTO CEK FROM MAHASISWA WHERE NRP_MHS=:NEW.NRP_MHS;
   IF CEK>=1 THEN SELECT COUNT(KODE_MK) INTO CEK FROM JADWAL_MATAKULIAH WHERE KODE_MK=:NEW.KODE_MATKUL;
      IF CEK>0 THEN :NEW.NILAI_AKHIR:=(:NEW.NILAI_UTS+:NEW.NILAI_UAS)/2;
         IF :NEW.NILAI_AKHIR>=80 THEN :NEW.GRADE:='A'; :NEW.STATUS_MATKUL:='Lulus';
         ELSIF :NEW.NILAI_AKHIR>=70 AND :NEW.NILAI_AKHIR<80 THEN :NEW.GRADE:='B'; :NEW.STATUS_MATKUL:='Lulus';
         ELSIF :NEW.NILAI_AKHIR>=56 AND :NEW.NILAI_AKHIR<=69 THEN :NEW.GRADE:='C'; :NEW.STATUS_MATKUL:='Lulus';
         ELSIF :NEW.NILAI_AKHIR>=46 AND :NEW.NILAI_AKHIR<56 THEN :NEW.GRADE:='D'; :NEW.STATUS_MATKUL:='Lulus';
         ELSIF :NEW.NILAI_AKHIR<46 THEN :NEW.GRADE:='E'; :NEW.STATUS_MATKUL:='Tidak Lulus';
         END IF;
      ELSE RAISE ERR2;
      END IF; SELECT MAX(KE) INTO :NEW.KE FROM MATAKULIAH_MAHASISWA WHERE KODE_MATKUL=:NEW.KODE_MATKUL;
      IF :NEW.KE IS NULL THEN :NEW.KE:=1; ELSE :NEW.KE:=:NEW.KE+1; END IF;
   ELSE RAISE ERR;
   END IF;
EXCEPTION
   WHEN ERR THEN RAISE_APPLICATION_ERROR(-20000,'NRP Tidak Tersedia');
   WHEN ERR2 THEN RAISE_APPLICATION_ERROR(-20001,'Mata Kuliah Tidak Tersedia');
END;
/
SHOW ERR;

INSERT INTO MATAKULIAH_MAHASISWA VALUES(212213001,'INF001',70,58,0,'','',0);
INSERT INTO MATAKULIAH_MAHASISWA VALUES(212213002,'INF001',70,58,0,'','',0);
INSERT INTO MATAKULIAH_MAHASISWA VALUES(215116002,'INF002',70,78,0,'','',0);
INSERT INTO MATAKULIAH_MAHASISWA VALUES(215321001,'INF002',76,90,0,'','',0);
INSERT INTO MATAKULIAH_MAHASISWA VALUES(216036001,'INF003',75,91,0,'','',0);
INSERT INTO MATAKULIAH_MAHASISWA VALUES(216116001,'INT001',60,90,0,'','',0);
INSERT INTO MATAKULIAH_MAHASISWA VALUES(216140001,'DKV001',55,61,0,'','',0);
INSERT INTO MATAKULIAH_MAHASISWA VALUES(218059001,'SIB001',39,56,0,'','',0);
INSERT INTO MATAKULIAH_MAHASISWA VALUES(218120001,'SIB002',40,50,0,'','',0);

-- CREATE USER TM001 IDENTIFIED BY TM001;
-- GRANT CONNECT, RESOURCE, DBA TO TM001;
-- GRANT UNLIMITED TABLESPACE TO TM001;--DOSEN

-- CREATE USER M216116536 IDENTIFIED BY M216116536;
-- GRANT CONNECT, RESOURCE, DBA TO M216116536;
-- GRANT UNLIMITED TABLESPACE TO M216116536;--MAHASISWA

COMMIT;
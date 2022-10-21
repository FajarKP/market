-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Oct 21, 2022 at 10:16 AM
-- Server version: 10.4.21-MariaDB
-- PHP Version: 8.0.11

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `market`
--

-- --------------------------------------------------------

--
-- Table structure for table `akun`
--

CREATE TABLE `akun` (
  `id_akun` int(11) NOT NULL,
  `nama` varchar(50) NOT NULL,
  `status` enum('admin','member','seller') NOT NULL,
  `username` varchar(20) NOT NULL,
  `password` varchar(50) NOT NULL,
  `email` varchar(100) NOT NULL,
  `foto` varchar(100) NOT NULL,
  `jenis_kelamin` enum('','laki-laki','perempuan') NOT NULL,
  `tanggal_lahir` date NOT NULL,
  `alamat` varchar(100) NOT NULL,
  `kota` varchar(50) NOT NULL,
  `provinsi` varchar(50) NOT NULL,
  `no_telp` varchar(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `akun`
--

INSERT INTO `akun` (`id_akun`, `nama`, `status`, `username`, `password`, `email`, `foto`, `jenis_kelamin`, `tanggal_lahir`, `alamat`, `kota`, `provinsi`, `no_telp`) VALUES
(1, 'Admin', 'admin', 'admin', '21232f297a57a5a743894a0e4a801fc3', 'admin@gmail.com', 'admin.jpg', '', '0000-00-00', '', '', '', ''),
(12, 'Fajar Kurniawan', 'seller', 'fajar', '7bedc9fd30769590c992b8f7f23738f7', 'fajarkurniawanp19@gmail.com', 'pika.jpg', 'laki-laki', '2000-06-19', 'Jl. Panderman No.47', '', '', '087879158540'),
(13, 'Ani', 'seller', 'ani', 'a6c45362cf65dee14014c5396509ba22', 'ani@gmail.com', '', 'perempuan', '0000-00-00', '', '', '', ''),
(14, 'Fani', 'seller', 'fani', '5a6c3117f5348275ca26005ae5e40f3c', '', '', '', '0000-00-00', '', '', '', '');

-- --------------------------------------------------------

--
-- Table structure for table `barang`
--

CREATE TABLE `barang` (
  `id_barang` int(11) NOT NULL,
  `id_toko` int(11) NOT NULL,
  `jenis_barang` varchar(50) NOT NULL,
  `nama_barang` varchar(50) NOT NULL,
  `harga_barang` float NOT NULL,
  `variasi` varchar(100) NOT NULL,
  `warna` varchar(100) NOT NULL,
  `deskripsi` varchar(100) DEFAULT NULL,
  `stok_barang` int(11) NOT NULL,
  `foto_barang` varchar(50) NOT NULL,
  `foto_barang2` varchar(50) NOT NULL,
  `foto_barang3` varchar(50) NOT NULL,
  `foto_barang4` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `barang`
--

INSERT INTO `barang` (`id_barang`, `id_toko`, `jenis_barang`, `nama_barang`, `harga_barang`, `variasi`, `warna`, `deskripsi`, `stok_barang`, `foto_barang`, `foto_barang2`, `foto_barang3`, `foto_barang4`) VALUES
(2, 3, 'Elektronik dan Aksesoris', 'Laptop', 5700000, '', '', '', 44, 'laptop.jpeg', '', '', ''),
(3, 3, 'Elektronik dan Aksesoris', 'Handphone', 2400000, '', '', '', 48, 'hp.jpg', '', '', ''),
(4, 2, 'Pakaian dan Aksesoris', 'Celana', 20000, '', '', '', 44, 'celana.jpg', '', '', ''),
(6, 2, 'Pakaian dan Aksesoris', 'Baju', 20000, 'Ukuran-S, Ukuran-M, Ukuran-L', 'Abu-abu, Biru', '', 0, 'baju.jpg', '', '', '');

-- --------------------------------------------------------

--
-- Table structure for table `cart`
--

CREATE TABLE `cart` (
  `id_cart` int(11) NOT NULL,
  `id_akun` int(11) NOT NULL,
  `id_toko` int(11) NOT NULL,
  `id_barang` int(11) NOT NULL,
  `variasi_cart` varchar(100) NOT NULL,
  `warna_cart` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `cart`
--

INSERT INTO `cart` (`id_cart`, `id_akun`, `id_toko`, `id_barang`, `variasi_cart`, `warna_cart`) VALUES
(133, 12, 2, 4, '', ''),
(134, 12, 3, 3, '', ''),
(135, 12, 3, 2, '', '');

-- --------------------------------------------------------

--
-- Table structure for table `checkout`
--

CREATE TABLE `checkout` (
  `id_order` int(11) NOT NULL,
  `id_akun` int(11) NOT NULL,
  `id_toko` int(11) NOT NULL,
  `id_barang` int(11) NOT NULL,
  `variasi_order` varchar(100) NOT NULL,
  `warna_order` varchar(100) NOT NULL,
  `jumlah` int(11) NOT NULL,
  `subtotal` int(11) NOT NULL,
  `status_order` enum('belum dibayar','dibayar','dibatalkan','dalam proses','dalam pengiriman','terkirim') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Triggers `checkout`
--
DELIMITER $$
CREATE TRIGGER `kurang_stok` AFTER INSERT ON `checkout` FOR EACH ROW BEGIN
	UPDATE barang SET stok_barang = stok_barang - NEW.jumlah WHERE id_barang = NEW.id_barang;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `kategori`
--

CREATE TABLE `kategori` (
  `id_kategori` int(11) NOT NULL,
  `jenis_barang` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `kategori`
--

INSERT INTO `kategori` (`id_kategori`, `jenis_barang`) VALUES
(7, 'Barang Digital'),
(5, 'Buku dan Alat Tulis'),
(1, 'Elektronik dan Aksesoris'),
(10, 'Hobi dan Koleksi'),
(9, 'Mainan dan Bayi'),
(8, 'Olahraga'),
(6, 'Otomotif'),
(2, 'Pakaian dan Aksesoris'),
(3, 'Perawatan dan Kecantikan'),
(4, 'Perlengkapan Rumah');

-- --------------------------------------------------------

--
-- Table structure for table `saldo`
--

CREATE TABLE `saldo` (
  `id_saldo` int(11) NOT NULL,
  `jumlah_saldo` float NOT NULL,
  `keterangan` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `toko`
--

CREATE TABLE `toko` (
  `id_toko` int(11) NOT NULL,
  `id_akun` int(11) NOT NULL,
  `nama_toko` varchar(100) NOT NULL,
  `foto_toko` varchar(100) NOT NULL,
  `alamat_toko` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `toko`
--

INSERT INTO `toko` (`id_toko`, `id_akun`, `nama_toko`, `foto_toko`, `alamat_toko`) VALUES
(2, 12, 'Toko Fajar', '', 'Jl. Panderman'),
(3, 13, 'Toko Elektronik', '', ''),
(5, 14, 'Toko Fani', '', '');

--
-- Triggers `toko`
--
DELIMITER $$
CREATE TRIGGER `ubah_seller` AFTER INSERT ON `toko` FOR EACH ROW BEGIN
	 UPDATE akun SET status = 'seller' WHERE id_akun = NEW.id_akun;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `wishlist`
--

CREATE TABLE `wishlist` (
  `id_wish` int(11) NOT NULL,
  `id_barang` int(11) NOT NULL,
  `id_akun` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `akun`
--
ALTER TABLE `akun`
  ADD PRIMARY KEY (`id_akun`);

--
-- Indexes for table `barang`
--
ALTER TABLE `barang`
  ADD PRIMARY KEY (`id_barang`),
  ADD KEY `jenis_barang` (`jenis_barang`),
  ADD KEY `id_toko` (`id_toko`);

--
-- Indexes for table `cart`
--
ALTER TABLE `cart`
  ADD PRIMARY KEY (`id_cart`),
  ADD KEY `id_barang` (`id_barang`) USING BTREE,
  ADD KEY `id_akun` (`id_akun`) USING BTREE,
  ADD KEY `id_toko` (`id_toko`);

--
-- Indexes for table `checkout`
--
ALTER TABLE `checkout`
  ADD PRIMARY KEY (`id_order`),
  ADD KEY `id_akun` (`id_akun`),
  ADD KEY `id_barang` (`id_barang`),
  ADD KEY `id_toko` (`id_toko`);

--
-- Indexes for table `kategori`
--
ALTER TABLE `kategori`
  ADD PRIMARY KEY (`id_kategori`),
  ADD KEY `jenis_barang` (`jenis_barang`);

--
-- Indexes for table `saldo`
--
ALTER TABLE `saldo`
  ADD PRIMARY KEY (`id_saldo`);

--
-- Indexes for table `toko`
--
ALTER TABLE `toko`
  ADD PRIMARY KEY (`id_toko`),
  ADD KEY `id_akun` (`id_akun`);

--
-- Indexes for table `wishlist`
--
ALTER TABLE `wishlist`
  ADD PRIMARY KEY (`id_wish`),
  ADD KEY `id_barang` (`id_barang`),
  ADD KEY `id_akun` (`id_akun`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `akun`
--
ALTER TABLE `akun`
  MODIFY `id_akun` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `barang`
--
ALTER TABLE `barang`
  MODIFY `id_barang` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `cart`
--
ALTER TABLE `cart`
  MODIFY `id_cart` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=136;

--
-- AUTO_INCREMENT for table `checkout`
--
ALTER TABLE `checkout`
  MODIFY `id_order` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT for table `kategori`
--
ALTER TABLE `kategori`
  MODIFY `id_kategori` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `toko`
--
ALTER TABLE `toko`
  MODIFY `id_toko` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `wishlist`
--
ALTER TABLE `wishlist`
  MODIFY `id_wish` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

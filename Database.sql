-- phpMyAdmin SQL Dump
-- version 4.9.0.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 01, 2023 at 11:03 AM
-- Server version: 10.3.15-MariaDB
-- PHP Version: 7.3.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `nfteasy`
--

-- --------------------------------------------------------

--
-- Table structure for table `nft_data`
--

CREATE TABLE `nft_data` (
  `contractAdd` text NOT NULL,
  `name` text NOT NULL,
  `tokenURI` text NOT NULL,
  `price` double NOT NULL,
  `tokenID` int(11) NOT NULL,
  `listingID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf32;

--
-- Dumping data for table `nft_data`
--

INSERT INTO `nft_data` (`contractAdd`, `name`, `tokenURI`, `price`, `tokenID`, `listingID`) VALUES
('0xbA41Ab08BE9a43ceb42beFABB89FDf87132aa262', 'Ape 1', 'https://www.benzinga.com/files/images/story/2022/boredapeyachtclub_nft_image_56.png', 0.001213121, 1, 1),
('0xde031f524171e7F6Dde570a870687390EC0d18fe', 'Ape2', 'https://www.northspace.life/wp-content/uploads/2022/11/NFT_CNX-Cat_Jazzy-1.png', 0.0005464, 2, 2);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `nft_data`
--
ALTER TABLE `nft_data`
  ADD PRIMARY KEY (`listingID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

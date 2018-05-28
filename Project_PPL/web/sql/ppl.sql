-- phpMyAdmin SQL Dump
-- version 4.5.1
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: May 28, 2018 at 05:38 PM
-- Server version: 10.1.16-MariaDB
-- PHP Version: 5.6.24

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `ppl`
--

-- --------------------------------------------------------

--
-- Table structure for table `bookmark`
--

CREATE TABLE `bookmark` (
  `Id` int(11) NOT NULL,
  `HospitalID` int(11) DEFAULT '0',
  `DoctorID` int(11) DEFAULT '0',
  `PatientID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `bookmark`
--

INSERT INTO `bookmark` (`Id`, `HospitalID`, `DoctorID`, `PatientID`) VALUES
(9, 7, 0, 78),
(11, 0, 2, 78),
(12, 0, 1, 78);

-- --------------------------------------------------------

--
-- Table structure for table `contact`
--

CREATE TABLE `contact` (
  `Id` int(11) NOT NULL,
  `UserName` varchar(30) NOT NULL,
  `Email` varchar(50) NOT NULL,
  `Comments` text NOT NULL,
  `Dates` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `contact`
--

INSERT INTO `contact` (`Id`, `UserName`, `Email`, `Comments`, `Dates`) VALUES
(13, 'null', 'v@gmail.com.com', 'asfsdf', '0000-00-00 00:00:00'),
(14, 'vu', 'hung139232s89@gmail.com', 'asdafsa', '0000-00-00 00:00:00'),
(15, 'vu', 'hung13923289@gmail.com', 'aaaaaaaaa', '0000-00-00 00:00:00'),
(16, 'yyyy', 'v1232@gmail.com.com', 'sfgsgsd', '0000-00-00 00:00:00'),
(17, 's', 'v@gmail.com.com', 'adfsa', '0000-00-00 00:00:00'),
(18, 'vu', 'hung13923289@gmail.com', 'luong khanh vu can u help me', '0000-00-00 00:00:00'),
(19, 'hello', 'hung13923289@gmail.com', 'mangaodo kuv', '2018-05-26 01:33:31');

-- --------------------------------------------------------

--
-- Table structure for table `doctor`
--

CREATE TABLE `doctor` (
  `Id` int(11) NOT NULL,
  `FirstName` varchar(50) NOT NULL,
  `LastName` varchar(50) NOT NULL,
  `Gender` varchar(10) NOT NULL,
  `Degree` text NOT NULL,
  `Insurance` varchar(10) NOT NULL,
  `Spec` text NOT NULL,
  `OfficeHours` varchar(20) NOT NULL,
  `Language` varchar(20) NOT NULL,
  `Roles` varchar(10) DEFAULT 'doctor'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `doctor`
--

INSERT INTO `doctor` (`Id`, `FirstName`, `LastName`, `Gender`, `Degree`, `Insurance`, `Spec`, `OfficeHours`, `Language`, `Roles`) VALUES
(1, 'vu ', 'luong ds', 'Male', 'bachelor', 'yes', 'Acident', 'mon--morning', 'VN', 'doctor'),
(2, 'vinh hello', 'luong', 'Male', 'bachelor', 'yes', 'OK', 'tue--afternoon', 'VN', 'doctor');

-- --------------------------------------------------------

--
-- Table structure for table `hospital`
--

CREATE TABLE `hospital` (
  `Id` int(11) NOT NULL,
  `Name` varchar(100) NOT NULL,
  `Address` text NOT NULL,
  `Website` varchar(100) NOT NULL,
  `AdminName` varchar(50) NOT NULL,
  `AdminEmail` text NOT NULL,
  `Password` text NOT NULL,
  `Hash` text NOT NULL,
  `Status` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `hospital`
--

INSERT INTO `hospital` (`Id`, `Name`, `Address`, `Website`, `AdminName`, `AdminEmail`, `Password`, `Hash`, `Status`) VALUES
(6, 'Vu', 'Dương Đình Hội', 'Hello.com', 'my Hospital', 'luongkhanhvu3289@gmail.com', 'Kcg7CaHfR/64tyfWvLZki7qhnd6l+plPPUdA99aCe53vMkTkvKkSZDY6DrGq9CjMyL83EZ8uY+nNWk6eGJJlG4+1VAGOTjmQDcqHpU36GpCwbZmfauS+LTgSfwPLCUq69h6q94iAHDwd3AUlj7AYbV2uHGBXFXgA/uJE3P0GwulDQ0PZgWZV3y9N8/i6wikN4kmFtSEJKo8ZqGBfdqjnqxf+JSQki48CkEd37vqkCCoCgFXWyK+Rn5bwpgsfuZfDVOnIiqIFWwtjvsvgOa3NTZZrOQUZvzMffWUj0PxjzdHQudsTkN/s7uNvYHSGGSNhziugA54wB1hXRmJxP/aDVQ==', '9908279ebbf1f9b250ba689db6a0222b', 1),
(7, 'Name hee', 'Address H1', 'Website Hospital', 'Admin Hospital 1', 'hung13923289@gmail.com', 'WybGe7vmZJNTZCGatWHlvYmCX6xuhxYEolPNS3xC6clbdDx1nApLHZ9e8c8ShyzgDWSpeJWkAbvSiYzn6pEVclUaAo4JHbt3OQ0mstTLOPzC5OMpqLVYpzAeey1iFCZIxT+ZV+PgooAjIC7mYAnBvcHcLva0Tpv2RO0yOWDC12H8+TF5olw6d6ZjNnCrHwNTeYVJF/Fbh659fQ5b29SXKzhzhyxuj7/WHrK4xoLtne4iE6V1Mtac1shn4FRKu+ca2ZbYfrcl2yqn680RysWINzC7UWV2XDWnFGCBQdJcBudAylo18aNv2BTlToqGy/dQFMecH40LZ7+zBZXLkOrCsA==', 'bbf94b34eb32268ada57a3be5062fe7d', 0);

-- --------------------------------------------------------

--
-- Table structure for table `patient`
--

CREATE TABLE `patient` (
  `Id` int(11) NOT NULL,
  `FirstName` varchar(20) NOT NULL,
  `LastName` varchar(20) NOT NULL,
  `Gender` varchar(10) NOT NULL,
  `Email` text NOT NULL,
  `Password` text NOT NULL,
  `Address` text NOT NULL,
  `Language` varchar(10) NOT NULL,
  `Hash` varchar(32) NOT NULL,
  `Status` int(10) NOT NULL DEFAULT '0',
  `RegisterDay` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `patient`
--

INSERT INTO `patient` (`Id`, `FirstName`, `LastName`, `Gender`, `Email`, `Password`, `Address`, `Language`, `Hash`, `Status`, `RegisterDay`) VALUES
(77, 'vinh hello', 'vu khanh', 'Male', 'luongkhanhvu389@gmail.com', 'WybGe7vmZJNTZCGatWHlvYmCX6xuhxYEolPNS3xC6clbdDx1nApLHZ9e8c8ShyzgDWSpeJWkAbvSiYzn6pEVclUaAo4JHbt3OQ0mstTLOPzC5OMpqLVYpzAeey1iFCZIxT+ZV+PgooAjIC7mYAnBvcHcLva0Tpv2RO0yOWDC12H8+TF5olw6d6ZjNnCrHwNTeYVJF/Fbh659fQ5b29SXKzhzhyxuj7/WHrK4xoLtne4iE6V1Mtac1shn4FRKu+ca2ZbYfrcl2yqn680RysWINzC7UWV2XDWnFGCBQdJcBudAylo18aNv2BTlToqGy/dQFMecH40LZ7+zBZXLkOrCsA==', 'duong Đình Hội', 'VN', 'f47d0ad31c4c49061b9e505593e3db98', 0, '2018-05-26 13:19:54'),
(78, 'Hello', 'Make', 'Male', 'hung13923289@gmail.com', 'WybGe7vmZJNTZCGatWHlvYmCX6xuhxYEolPNS3xC6clbdDx1nApLHZ9e8c8ShyzgDWSpeJWkAbvSiYzn6pEVclUaAo4JHbt3OQ0mstTLOPzC5OMpqLVYpzAeey1iFCZIxT+ZV+PgooAjIC7mYAnBvcHcLva0Tpv2RO0yOWDC12H8+TF5olw6d6ZjNnCrHwNTeYVJF/Fbh659fQ5b29SXKzhzhyxuj7/WHrK4xoLtne4iE6V1Mtac1shn4FRKu+ca2ZbYfrcl2yqn680RysWINzC7UWV2XDWnFGCBQdJcBudAylo18aNv2BTlToqGy/dQFMecH40LZ7+zBZXLkOrCsA==', 'Duong', 'VN', 'eb163727917cbba1eea208541a643e74', 1, '2018-05-28 19:59:43');

-- --------------------------------------------------------

--
-- Table structure for table `specialty`
--

CREATE TABLE `specialty` (
  `Id` int(11) NOT NULL,
  `Specialty` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `specialty`
--

INSERT INTO `specialty` (`Id`, `Specialty`) VALUES
(1, 'Accident surgery make'),
(2, 'Anaesthesiology and intensive-care medicine'),
(3, 'Anatomy'),
(4, 'Blood group serology and transfusion medicine'),
(5, 'Cardiac surgery'),
(6, 'Certified pysician'),
(7, 'child and adolescent psychiatry and psychotherapeutic medicine'),
(8, 'Dermatology');

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `Id` int(10) NOT NULL,
  `FirstName` varchar(50) NOT NULL,
  `LastName` varchar(50) NOT NULL,
  `Gender` varchar(10) NOT NULL,
  `Email` varchar(100) NOT NULL,
  `PassWord` text NOT NULL,
  `Phone` varchar(20) NOT NULL,
  `Address` varchar(200) NOT NULL,
  `Language` varchar(20) NOT NULL,
  `Avatar` blob NOT NULL,
  `DateOfBirth` date NOT NULL,
  `RegisterDay` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `Role` varchar(10) NOT NULL,
  `Status` tinyint(1) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`Id`, `FirstName`, `LastName`, `Gender`, `Email`, `PassWord`, `Phone`, `Address`, `Language`, `Avatar`, `DateOfBirth`, `RegisterDay`, `Role`, `Status`) VALUES
(3, 'vinh hello', 'vu', 'Male', 'luongkhanhvu3289@gmail.com', 'WybGe7vmZJNTZCGatWHlvYmCX6xuhxYEolPNS3xC6clbdDx1nApLHZ9e8c8ShyzgDWSpeJWkAbvSiYzn6pEVclUaAo4JHbt3OQ0mstTLOPzC5OMpqLVYpzAeey1iFCZIxT+ZV+PgooAjIC7mYAnBvcHcLva0Tpv2RO0yOWDC12H8+TF5olw6d6ZjNnCrHwNTeYVJF/Fbh659fQ5b29SXKzhzhyxuj7/WHrK4xoLtne4iE6V1Mtac1shn4FRKu+ca2ZbYfrcl2yqn680RysWINzC7UWV2XDWnFGCBQdJcBudAylo18aNv2BTlToqGy/dQFMecH40LZ7+zBZXLkOrCsA==', '016409881392', 'Dương Đinh Hội', 'VN', '', '1970-02-03', '2018-05-27 17:54:07', 'admin', 1);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `bookmark`
--
ALTER TABLE `bookmark`
  ADD PRIMARY KEY (`Id`);

--
-- Indexes for table `contact`
--
ALTER TABLE `contact`
  ADD PRIMARY KEY (`Id`);

--
-- Indexes for table `doctor`
--
ALTER TABLE `doctor`
  ADD PRIMARY KEY (`Id`);

--
-- Indexes for table `hospital`
--
ALTER TABLE `hospital`
  ADD PRIMARY KEY (`Id`);

--
-- Indexes for table `patient`
--
ALTER TABLE `patient`
  ADD PRIMARY KEY (`Id`);

--
-- Indexes for table `specialty`
--
ALTER TABLE `specialty`
  ADD PRIMARY KEY (`Id`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`Id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `bookmark`
--
ALTER TABLE `bookmark`
  MODIFY `Id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;
--
-- AUTO_INCREMENT for table `contact`
--
ALTER TABLE `contact`
  MODIFY `Id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;
--
-- AUTO_INCREMENT for table `doctor`
--
ALTER TABLE `doctor`
  MODIFY `Id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `hospital`
--
ALTER TABLE `hospital`
  MODIFY `Id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;
--
-- AUTO_INCREMENT for table `patient`
--
ALTER TABLE `patient`
  MODIFY `Id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=79;
--
-- AUTO_INCREMENT for table `specialty`
--
ALTER TABLE `specialty`
  MODIFY `Id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;
--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `Id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

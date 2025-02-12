Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2064.outbound.protection.outlook.com [40.107.237.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D035779C2;
	Wed, 12 Feb 2025 10:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739356929; cv=fail; b=qmXRIP3o5ydRqIxEW6xN6GxMSozhrh9e5xj2hr4odgoHOE8WKbsD6q/7S1HxYsdu19PWI2EqJM3PVFIzpfM5gn/kokryFaqQF5DV74q4+1K3tBeeNgIDkrTzP8b4F/TuBelRcuIbpyujjIVHXSn9JBmR4bt4jSdo5lysvDFCXJA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739356929; c=relaxed/simple;
	bh=cUHQn4OibTUvhpGku9AXCSE1Ho9+G19JKDUXp4CjjDw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SEQbQ2MswiSvKmNuakvLz8pVhxhbh+JzJCQTHXICge/RsV99SGQpZzOFyMHGU05B0HVlf0xPJ1B82ek9JDQrnb+8CwSX3w/7NvM2UjbkoxChHlvTOpFteq2xjRtTJp790Fm9im0vO05oidbKq4mBStqNVncn8F9M0eVyf5w5W0o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jFVt1Eql; arc=fail smtp.client-ip=40.107.237.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jFVt1Eql"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xIAI6ow0GisQspf4CruXTWqU+umKPRyyIH0UfLSwTzk51TjmutHTFy51r6sT12r2zBA+CONjHOuNhvzEZKs4OugRM8clQsKHanKWN0jFiN18SXSqaNOy3mpQeQqVyZzLjFtrl6F9jaAHQLNBXsvtXhoTtT1YDflOn/3uMmhhP3f0x+8qsLM03kQYOY7ncKZhBT1C1+SkfCHQ1vHKPbUVj5l3z3BCLyqwcrhipc8co2chiTGRQ/bNin+ny+EoWdAcwe17aK4pLfVLfv0W3kpQI/fXYJ/5Fea/sM2rJNhzsSC/CTxqyxXuwoyEuZ3Oql2+9wc3Uywya/jOdKmLLjfGkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n5FdbYIxoTyIHTMsA1TTsLw7YD75EFpAdm/uuCJ3Xz4=;
 b=bS3Moal6DiwosV3BafC5BrrgAK/YOb34K3B/265hvMxYMTyva9g8WUNmfmghPqyxXWUsY9A0g0PW5t34dvCWQpAH7yGGyFh08Jbazsj+TPwVVTDShRkF5ofpBrjb+KkzJ0T+B4CDyrvVecwx9uDWJUlvfRmm0tOiFRBz9r0lOIg5SY9tuddhChP+xBhatPfC2byW6q/eTIva3OWyC5G3nC0n7tS7juBoMDEoiCL8JREBUt56AmW9c8nT1Qa5OLaguHjjsl4QuGGQpo2+/kdC0KhxOQeZJUbIK59P5tTljqhF95MRxyYqqwfOGClECfZ8wIiocvotqaN5iOGSIBhpjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n5FdbYIxoTyIHTMsA1TTsLw7YD75EFpAdm/uuCJ3Xz4=;
 b=jFVt1EqlcEPM/Xqo0zYPA770cNCPL9WrcoQFw3JN82EcJ7K5aObozvMGx9xB6LMW13WAnqUALcWiu8UpDLA1xQyzLhNsqw3k1f4w3cqvOEY/06VM5DROm+OBZo3eCf5VTj51CpvF5ALpr6NOnXsAfm8ACy13WKAkD+hgUm6rIWWAjrTU/e2kcYD8bm7/h1G35IfREB72X6aXE8LJn0DYMG+h8Ps0GW0UpajTGQF1totVVZML4A7A+A3o5cxGGhGzoBnQ67VufM9p/7qFRA8kh3QtEqh28SJ1JNSBKwsT8KLIrYy8VxHAhd2Ip3ZIece8W4h1IH1s+ljIgKrS3aQ7mw==
Received: from BYAPR11CA0048.namprd11.prod.outlook.com (2603:10b6:a03:80::25)
 by MN2PR12MB4045.namprd12.prod.outlook.com (2603:10b6:208:1d6::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.19; Wed, 12 Feb
 2025 10:42:02 +0000
Received: from CO1PEPF000044F2.namprd05.prod.outlook.com
 (2603:10b6:a03:80:cafe::7) by BYAPR11CA0048.outlook.office365.com
 (2603:10b6:a03:80::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.31 via Frontend Transport; Wed,
 12 Feb 2025 10:42:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CO1PEPF000044F2.mail.protection.outlook.com (10.167.241.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8445.10 via Frontend Transport; Wed, 12 Feb 2025 10:42:01 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 12 Feb
 2025 02:41:53 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 12 Feb 2025 02:41:53 -0800
Received: from NV-2XGVVG3.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Wed, 12 Feb 2025 02:41:49 -0800
From: Kartik Rajput <kkartik@nvidia.com>
To: <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <thierry.reding@gmail.com>,
	<jonathanh@nvidia.com>, <hvilleneuve@dimonoff.com>, <arnd@kernel.org>,
	<geert+renesas@glider.be>, <robert.marko@sartura.hr>,
	<schnelle@linux.ibm.com>, <andriy.shevchenko@linux.intel.com>,
	<linux-kernel@vger.kernel.org>, <linux-serial@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>
Subject: [PATCH v3 0/2] Add support for Tegra UART Trace Controller (UTC) client
Date: Wed, 12 Feb 2025 16:11:30 +0530
Message-ID: <20250212104132.61060-1-kkartik@nvidia.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F2:EE_|MN2PR12MB4045:EE_
X-MS-Office365-Filtering-Correlation-Id: 999b816c-df76-44a5-331c-08dd4b51e208
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|7416014|376014|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Y09QpfhrssShT2ds4L8zndsIC5503BU3+nUi3p++IhUO4XWZp3dcP4uwpuaX?=
 =?us-ascii?Q?bAFEFERqk3f7TOHX3ixm/5kQcIg5RMCCOfWXdSiNzu5R8iJY9dLagCnmsMu4?=
 =?us-ascii?Q?HWM3Cm13mJh6lQUf1l8USJUG3ABjl86ov74yaqLvzZx8wrkXkJJ18Cji9M6c?=
 =?us-ascii?Q?sSSScW5xfQT3QL92HNd2rODlYAZK9FedWFRkWTM7A6ILN7n1aKPA39mfoPo4?=
 =?us-ascii?Q?ZMOg26iRGNAP+ZIbdssdmrWfo6UOKSC/Kxto/rTm7q2svZZXjhv3UxGn8Vib?=
 =?us-ascii?Q?OKIcDQ2WUrMyksViMOT0MxXzpW24BWoqRzeoKQax1xOc8x+B2DZbgdNjgCI8?=
 =?us-ascii?Q?bWmX61Qn+qLj4SW3MptTNKNQ5PbLXE0l9OJMudbDiULE3qa7h73GDU3VPYS0?=
 =?us-ascii?Q?qAVD3uvqoTom5d/MLlgsVfiAHjtfrlFfFlrPXwIfqzU8FoDXoXHEjPhmHaWE?=
 =?us-ascii?Q?uEiTVlN4XmtXnB7zayczyVHTQ36z+mlShYUugIV9p/9LuFDQuU4AelU8qNsy?=
 =?us-ascii?Q?IlmICdKDXwp6O9JsvdIHGh7xZ3jCsNXVuuIYWmrVh4NgeySlsksIWPyNHuVF?=
 =?us-ascii?Q?U2Ti/NPgoS/9OxzUYNGJDDqfLUNzwW7tAxm7F5jXis6DxejXCAi/ygycAD2W?=
 =?us-ascii?Q?XzfASTLiuyQWCBxn08FTR4SI74Vq5WVJYeR7PrJcMFxzqliThu1AN9jamh9u?=
 =?us-ascii?Q?4R4P9UnlBseJp8Nf/ekuxgODrSGjgNATDeUiq8IzIfgxpgtBQixW8NxLFGnA?=
 =?us-ascii?Q?pCQaFCL1e6mYRlLinQCf7q5RLH4kEXUGzQtDT26l9ZRfQD+D8sVQ1FLVcf7B?=
 =?us-ascii?Q?EhmCOL222RIqvrZ7YrXCRzAHJxtX+v3CFtL3dGwAKWCI5DEADI6am5kCX2P1?=
 =?us-ascii?Q?cXbvRWDuVQ5GfEWDsSBQTYFm/qi17qxX4Bcf5h9Hb0iQjeGtpT38Ad7SCVu0?=
 =?us-ascii?Q?nhRAwZwIMca3n59nXRJUYoixSzVeohqv2BO6gb2cWkPQUM8VItK8WLkgMbXI?=
 =?us-ascii?Q?GGOc6N0JEVJFz6CN4M/84kqS76jEfsv150E999lk7jfJdVt/2alwHoDjKyHT?=
 =?us-ascii?Q?YkQp3ETWzgxnDb3D1vLejs352ol54s8FGFF+vLQEsvyFvtkY7FyZRUJ4IbnN?=
 =?us-ascii?Q?9vc/psyToSnHHb1OATsuy3+0CpZ7NsI0j1KRN/R16a74mFUWIKUuIRfdeVc2?=
 =?us-ascii?Q?h7gFWfLlKkUa4x7MwpEBlGGgu8FLcbcONrLCJuMgpbbhWETiuh0/I5T4rOlH?=
 =?us-ascii?Q?ZIkHClhaIkFI6lmk9Id16sMe13pItbVIpMU8xpBlceFcTWtwtYS+rX3/EFYT?=
 =?us-ascii?Q?gbXcbKXNgAI9fKgD66GLjTr+BaIOI7FAk63V7OPOzE/76YzhZxaL6vQq/VBv?=
 =?us-ascii?Q?XmXSrxJHYEkebQ+Fx7se/rNjMnrjGOFRp3XDF+g9otl/cbI6jiZ868tJ4TyN?=
 =?us-ascii?Q?aH++JuokoaHpR8W0sdqDHNwe3HZfokTtcIrx8F+6rRFaZh6KV39fuND3NWRZ?=
 =?us-ascii?Q?xYsErlFFG50ww88=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(7416014)(376014)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2025 10:42:01.2319
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 999b816c-df76-44a5-331c-08dd4b51e208
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4045

The Tegra UTC (UART Trace Controller) is a hardware controller that allows
multiple systems within the Tegra SoC to share a hardware UART interface.
It supports up to 16 clients, with each client having its own interrupt and a
FIFO buffer for both RX (receive) and TX (transmit), each capable of holding
128 characters.

The Tegra UTC uses 8-N-1 configuration and operates on a pre-configured
baudrate, which is configured by the bootloader.

Kartik Rajput (2):
  dt-bindings: serial: Add bindings for nvidia,tegra264-utc
  serial: tegra-utc: Add driver for Tegra UART Trace Controller (UTC)

 .../bindings/serial/nvidia,tegra264-utc.yaml  |  73 ++
 drivers/tty/serial/Kconfig                    |  23 +
 drivers/tty/serial/Makefile                   |   1 +
 drivers/tty/serial/tegra-utc.c                | 634 ++++++++++++++++++
 4 files changed, 731 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/serial/nvidia,tegra264-utc.yaml
 create mode 100644 drivers/tty/serial/tegra-utc.c

-- 
2.43.0


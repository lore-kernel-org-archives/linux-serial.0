Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2043.outbound.protection.outlook.com [40.107.95.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 385F533998;
	Thu, 13 Feb 2025 12:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739450929; cv=fail; b=kYq4ztFwvfGn9sQDrf8+z++l5wydLrKgfh6FcblMCHkBXGGxr2Uqgyq/PjnX4zTfgERitFH+qTJH0AQ5sWHzVcOFQ0/djsS4L/EMWRw5aqF3sv5fn6YW6bt0dlwLrTkojgYd0o7fZlY+zInPJBGemU+Ewrja9T0poB7rHMwxxjo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739450929; c=relaxed/simple;
	bh=Jlf6YrZjZjyKswlRWcGZen7WrnylwvP7ClaIDq75Jbw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=saGK+xnVp/6pzhAKVAN23OKC2sXTbWd4eqtRvq0DY4kRx0kRoKTtJDfbdzEQiZRDhv1dzZjUxxeqbfshdi8UxCF/gmMcNbg/UeZNEzg2FwBeD3ifi/0wbyT+GUCcTebs46OsiHun0LAh6sGW5nsc6gdr+zve7GZI5I8hsC6wxJ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=sm69r93N; arc=fail smtp.client-ip=40.107.95.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="sm69r93N"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZTKwpNdI611DUr36UpDBztDuLYNT8LwFlC444CtCCFJF7i5JqoihMJZ96tQmsOuMnL1JX4+/1HSf5TyLVva3sRWieGr9YLdR0GK4QHEbaHuV8Jq7RDCZ2Dw4W7So5qVs1xZIRCiXTiJL2B46dZ80NN2TYM2N8Bt54Tp6cYa6LQe2x5I0hamgEgtgimDcoMW2m30hAj632e8YS53Agvt+JMcrGpcozrOK6A3TBjEhQEaRzXKxR46QQ9BUpOIMbudkiymwjkXdenEJnbmgiQnV9/+737z7RdcDGUaCucfDHHHXUjniRP67BDHCc5rP4Eku2Nf8SoLu0PRxoALoGZUuqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p4UVKXAu2bMNuD93pjAvo/2q8qW5+sybznugIUZsc9s=;
 b=Jx9HOxyMMl2cP+N+E1Fp+pVzA6qfg+1iCvvk4gnVYi/nqFg3dCwoR6KuAhr1w2uFCVJaK/EKy4fMAp0VoCxbwKdT6+5I7q3hgHDoqZygvxM1wH0TnrK94BgROg/niXqWOwfIB1DVApPB8zCRUyVBD/4w1doLood/1zt8PwCgyueZKXMemMoM8ppxuHuGcg+Zhk2yegEd2bbt4vqQyuH8TOhKgDwg60etqGgTqlh+kbEae64WZ3h44Mc1jCs4bDSOd09CxaV2tBlIQ0cpb7OTh1qDhvDcKbu0evR9yYYcKHf+Gx9dXyaijPpAX4Yy7NzGX8SV0z9OGW4qlf/48nA9tA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p4UVKXAu2bMNuD93pjAvo/2q8qW5+sybznugIUZsc9s=;
 b=sm69r93N8Fiu/xOHu2Ldf3EuurZnmLRdHPl4m+2s/bCrmadDhm1xAqQVUHeVXufNMmrmnuPVjBJwJKhE1oOGacidI9iwX1xzFsm7t0TGfBJjWaZz3vhprFlCm7u8g6Ue95eiurLjZdC9PRoiAc6Mvvj4WcyDzYAmNQTd8Qgu4PiW9eCxfGbxoyXDVN2JKiSpoAg3YMVE1gor+BInwb2NFmHnmjANc/wKbAPDVRaumeLiHvuxIRfIFzw2lHjPC195jHggMp9M8JqmBmc9zZ4qFvPtmquZihVLAayuO0E08z8kHaXqfDqdQZKqpc83vgAGVNIqvlAc3Nq4kRb7K30NNA==
Received: from BLAPR05CA0009.namprd05.prod.outlook.com (2603:10b6:208:36e::16)
 by CH3PR12MB8583.namprd12.prod.outlook.com (2603:10b6:610:15f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.11; Thu, 13 Feb
 2025 12:48:45 +0000
Received: from BL02EPF00021F69.namprd02.prod.outlook.com
 (2603:10b6:208:36e:cafe::fb) by BLAPR05CA0009.outlook.office365.com
 (2603:10b6:208:36e::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.8 via Frontend Transport; Thu,
 13 Feb 2025 12:48:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF00021F69.mail.protection.outlook.com (10.167.249.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8445.10 via Frontend Transport; Thu, 13 Feb 2025 12:48:44 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 13 Feb
 2025 04:48:28 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 13 Feb
 2025 04:48:27 -0800
Received: from NV-2XGVVG3.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Thu, 13 Feb 2025 04:48:23 -0800
From: Kartik Rajput <kkartik@nvidia.com>
To: <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <thierry.reding@gmail.com>,
	<jonathanh@nvidia.com>, <hvilleneuve@dimonoff.com>, <arnd@kernel.org>,
	<geert+renesas@glider.be>, <robert.marko@sartura.hr>,
	<schnelle@linux.ibm.com>, <andriy.shevchenko@linux.intel.com>,
	<linux-kernel@vger.kernel.org>, <linux-serial@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>
Subject: [PATCH v5 0/2] Add support for Tegra UART Trace Controller (UTC) client
Date: Thu, 13 Feb 2025 18:18:03 +0530
Message-ID: <20250213124805.2588-1-kkartik@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF00021F69:EE_|CH3PR12MB8583:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a78aea1-f6a6-487e-580c-08dd4c2cc091
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|82310400026|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?u6tb8A9pG0r88vmJPavMvnWFOYz25e05sx2UAFM/Xmk2JZ0z63i2Ml5Vci/L?=
 =?us-ascii?Q?uGyaCOsvMhiBr8VVhYSFZcLNOhSdwRbECOUL+x6EVidDtpesecH8RX5xY9IW?=
 =?us-ascii?Q?8AB8jeyeHK/bGu1W7rxNy0CLltesSgEmuMANucLdQKtpki1oJPLhO/JoSW/L?=
 =?us-ascii?Q?FqLdUKZgoj6R9929IfOUpWZoaKQAHEbf+ZABqrrWNNHdqeH4UFHUnqHrd/pp?=
 =?us-ascii?Q?8idWrDpOWS/xneDqhtdezDOpoBjA7yY85vepgqPRYsp3i7qCdTjHWrUfcy84?=
 =?us-ascii?Q?2A6Us4fjioKXoE1x/XUYFsClpHEHiTcCuvfjgLzmG8hBnnrh7s90lfwLwotF?=
 =?us-ascii?Q?pQLw6Zandgwwtuac5dfiCGNTW9967jfnoOs+XsnPMIuJdtiWeUf4uMybRNcX?=
 =?us-ascii?Q?xLvoTo5uWu/EkcauQjsgfYTbKSiJsGezGis6v+T9uKOYVLtdT36ZKiE5SAsQ?=
 =?us-ascii?Q?F/RxxY7Qa6D7elQNKiaf1npJvhxhnoCT8nSuUKIf92kTvuKn5G82tRWJYvjZ?=
 =?us-ascii?Q?ilSoEXWwaUHGBA2eCSe4Bu6t1BEJDHRutB6orqIVOk8K6moK+JxxkDLb8KA8?=
 =?us-ascii?Q?bneKpDtuVKk2AqY0jsvxraytFDmbJ4S5IpZmqK3qAF5Mrxn6XWpPUE465crn?=
 =?us-ascii?Q?1XJdWhVJlxjSQQU1hUrw3PIUgxcgUnSNlCvi9f4oVGZSkg8UaPrf3DPujAb2?=
 =?us-ascii?Q?s1BmJaPbkNqrio/zzXOOJunbCeY9PAi1ksoQ0Lg/J08ZSJ2wQRu8y1Iidngc?=
 =?us-ascii?Q?V1wdsBvP0v7atZ/ZbLi65dIdAZZTH2U4m2sCA9/X/j47xforMHvA2Y35DD4p?=
 =?us-ascii?Q?EutklOyTNqQP7HFgbN6COeEAHU0cVuep14079yJuPMEa24gq/gszjSbAFMno?=
 =?us-ascii?Q?/ezJDtR875ARGCu2I4EOo7n5451Jfy8dqSLFgNW6SqoIMMCzYVrvbcEU7Mt9?=
 =?us-ascii?Q?4mwGyjKWzsu2oieF52hykK/V2/Ab05L49Dq6fVEH1QF6gdr7LLjZtLA2gzIu?=
 =?us-ascii?Q?tnwphol6jU/N2Ysp31RlN46qm01ivjXcEP1HjW2xxEQL7kU2nGU1ATfrGjbC?=
 =?us-ascii?Q?IJS27bIvuRV7L2/iKm5s5yBrDSLdJ0oukZNEphaWrqUWyMufISU1E130Fcw9?=
 =?us-ascii?Q?5sKvCQ5F7aSIRPQdD1SXb/bjX1fU0/AOwaaANdT9DghlnxWADqZTAyfMJ4Nc?=
 =?us-ascii?Q?o6f2XHrF2d6X9KGBZqtSMZMy6YgRR58NhROYUq8lswMlxiESCRuqcreMbPFy?=
 =?us-ascii?Q?uwGr2Nwjm2l1QP9SWQHRiDEKuMgatuFqaQHxLWkRaUBIEhOTZpi920yP2y8I?=
 =?us-ascii?Q?kr7ACjY36XuhhBWIS5AsOTaSDRoJ2FZ/gy1kVzAUKSh8vsSEmQFXkdtvdx9C?=
 =?us-ascii?Q?6IfEiZHmUrnslUmsoRoUy79JLQowOwd3Wst5mYW7SBKWGfhhgWP9UjzW3YEG?=
 =?us-ascii?Q?Nlxa4RsOnqA6ZukWxv7rpMSCqUgMNObW4GmPvQvw/86BRDh9mlLR5TCgosbv?=
 =?us-ascii?Q?QdBSfeBospVJ/rU=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(82310400026)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2025 12:48:44.7313
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a78aea1-f6a6-487e-580c-08dd4c2cc091
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F69.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8583

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
 drivers/tty/serial/tegra-utc.c                | 625 ++++++++++++++++++
 4 files changed, 722 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/serial/nvidia,tegra264-utc.yaml
 create mode 100644 drivers/tty/serial/tegra-utc.c

-- 
2.43.0


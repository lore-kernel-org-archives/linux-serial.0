Received: from ZRZP278CU001.outbound.protection.outlook.com (mail-switzerlandnorthazon11021131.outbound.protection.outlook.com [40.107.167.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70B0522157E;
	Tue, 30 Dec 2025 22:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.167.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767132048; cv=fail; b=FR8DjrMDloNzaGvVrQR+eplKg83IRAHy1dCE0l2Ylhrt7gRrnBXgh7IrmnJMiO2oS/qW09+8JHux/JMMwtrMf23zp5Owb/hcZJvhZhx+D/9GvPUg4GKn9t7AXnfeMbkbqG38NjnUYs4NvRduzboKErfIi5t9EGJNQ0fn/MsUGIc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767132048; c=relaxed/simple;
	bh=MpLQ+8bxtu7HxlttHmjeoahGkR0INhl2NaBqW1v6MBI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OymsQ8WTmGYc+Sf2AUDhKCCq6hoj+ulY/LKiaJ6Zyma2Gj1qIxeHultVG4083rqEIIE0ycizFJ1+IRYwG2bBkmjgSfsNZOtRvR5Ix89lN2uacXiYXiDO8tPyQEMcUw9TgDFNBqStuXc90mUermzzJwR8EYXs8eqJtC/hwb3ie6M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=duagon.com; spf=pass smtp.mailfrom=duagon.com; dkim=pass (1024-bit key) header.d=duagon.com header.i=@duagon.com header.b=FqTjWiwx; arc=fail smtp.client-ip=40.107.167.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=duagon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=duagon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=duagon.com header.i=@duagon.com header.b="FqTjWiwx"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kMFqfcRvFAIbeTbjBs61ufY7xRV1Q/6JFFYGWpKZc+qmLpe4N08aH8zDMmntUyMjSjGAktRpWT486AZTYJ8b1Q31up9gTLDeLqMJZxlgqMhveb1AIIyig6aWdXxiyfrTY9me02WBgjnB1zylWjJofQdUm3OH2abmabewDh0eZRUkzjMMNYJ2U+0gCsI5SgkJshTPkT62moIvyshl5WGjgYe8dfq4Vmzy/e1MfDIjv1HZ4jMNb2MyQaG4ZNW9FfdNYG+OINnRieZOC112DNOtKit0GdqV7kgtslaQaLJQ31lD31IJ3I8981nxiTAaudKoL9FNNBwLAcnEBDZbUwbD3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MpLQ+8bxtu7HxlttHmjeoahGkR0INhl2NaBqW1v6MBI=;
 b=d0Bx44H05rAi9vGesDaYdi1BYbj3+dgO1idXFlsLtyi6Yzk6s547kgc8NFwEJBhjDs0gyDkre9+4QqsvnnlypgpXoBUX8PBgq4XjOfTUvX0fXPZGsffn4KPUGjsdFw5vLdWygKmgOIxmMiqeFjShUejg8Btd8P22m/6fr697xPnoA8un1eil1pwkeekDkjm5at6p1hET3o8ddpMicCK0U08GzHHyDmVU8Km+qgDcAp2/FaDoZE1NzQTIdBKt0ftA8j/5Y0dsvf0ie4xUV9m5z/8RtZnzsCBsXyJL9TgNuW02QcKbD9hRaMfZGTFrfryPnm1tNQB01pCutGwxBVlSjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 40.93.85.2) smtp.rcpttodomain=kernel.org smtp.mailfrom=duagon.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=duagon.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=duagon.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MpLQ+8bxtu7HxlttHmjeoahGkR0INhl2NaBqW1v6MBI=;
 b=FqTjWiwxZK7IvZFkzkeAQ8vf0eh+2hEtFr+cPZz11CvgccVQIZxMvqcDQObc/VZXUMWJtXNMtpB2c363dbOOL2XWVoiVI9TmyKyghffJNEbL/jpFz9zD7EglTGSB/s6Uy6aiP5xs8vW4LkBVbQq8+G0VTnkxM3RBhmlvGBGWeaA=
Received: from PA7P264CA0540.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:3db::17)
 by ZRZP278MB2022.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:ba::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Tue, 30 Dec
 2025 22:00:42 +0000
Received: from AM4PEPF00025F9C.EURPRD83.prod.outlook.com
 (2603:10a6:102:3db:cafe::c4) by PA7P264CA0540.outlook.office365.com
 (2603:10a6:102:3db::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9478.4 via Frontend Transport; Tue,
 30 Dec 2025 22:00:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 40.93.85.2)
 smtp.mailfrom=duagon.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=duagon.com;
Received-SPF: Pass (protection.outlook.com: domain of duagon.com designates
 40.93.85.2 as permitted sender) receiver=protection.outlook.com;
 client-ip=40.93.85.2; helo=ZRAP278CU002.outbound.protection.outlook.com; pr=C
Received: from hz-deliver01.de.seppmail.cloud (2a01:4f8:a0:900b::219) by
 AM4PEPF00025F9C.mail.protection.outlook.com (2603:10a6:20f:fff4::b) with
 Microsoft SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id
 15.20.9499.0 via Frontend Transport; Tue, 30 Dec 2025 22:00:42 +0000
Received: from hz-glue05.de.seppmail.cloud (unknown [10.11.0.47])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by hz-deliver01.de.seppmail.cloud (Postfix) with ESMTPS id 4dgn8T4LQMz4wxW;
	Tue, 30 Dec 2025 23:00:41 +0100 (CET)
Received: from hz-glue05.de.seppmail.cloud (unknown [172.18.0.6])
	by hz-glue05.de.seppmail.cloud (Postfix) with SMTP id 4dgn8T3sm2z1yNr;
	Tue, 30 Dec 2025 23:00:41 +0100 (CET)
X-SEPP-Suspect: 5472fcfb16e1400d863c17d3c9437feb
Received: from hz-scan09.de.seppmail.cloud (unknown [10.11.0.50])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by hz-glue05.de.seppmail.cloud (Postfix) with ESMTPS id 4dgn8T3Lz8z1wPw;
	Tue, 30 Dec 2025 23:00:41 +0100 (CET)
Received: from hz-scan09 (localhost [127.0.0.1])
	by hz-scan09.de.seppmail.cloud (Postfix) with SMTP id 4dgn8T2mHYz19DL;
	Tue, 30 Dec 2025 23:00:41 +0100 (CET)
Received: from hz-m365gate03.de.seppmail.cloud (unknown [10.11.0.36])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by hz-scan09.de.seppmail.cloud (Postfix) with ESMTPS;
	Tue, 30 Dec 2025 23:00:40 +0100 (CET)
Received: from ZRAP278CU002.outbound.protection.outlook.com (mail-switzerlandnorthazlp17010002.outbound.protection.outlook.com [40.93.85.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (not verified))
	by hz-m365gate03.de.seppmail.cloud (Postfix) with ESMTPS id 4dgn8R4JtNz1w4h;
	Tue, 30 Dec 2025 23:00:39 +0100 (CET)
Received: from AS4P189CA0015.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:5d7::19)
 by GV0P278MB1765.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:6c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Tue, 30 Dec
 2025 22:00:35 +0000
Received: from AMS1EPF00000046.eurprd04.prod.outlook.com
 (2603:10a6:20b:5d7:cafe::38) by AS4P189CA0015.outlook.office365.com
 (2603:10a6:20b:5d7::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9478.4 via Frontend Transport; Tue,
 30 Dec 2025 22:00:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.79.222.204)
 smtp.mailfrom=duagon.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=duagon.com;
Received-SPF: Pass (protection.outlook.com: domain of duagon.com designates
 20.79.222.204 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.79.222.204; helo=de2-emailsignatures-cloud.codetwo.com; pr=C
Received: from de2-emailsignatures-cloud.codetwo.com (20.79.222.204) by
 AMS1EPF00000046.mail.protection.outlook.com (10.167.16.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9478.4 via Frontend Transport; Tue, 30 Dec 2025 22:00:35 +0000
Received: from ZRAP278CU002.outbound.protection.outlook.com (40.93.85.3) by de2-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Tue, 30 Dec 2025 22:00:34 +0000
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=duagon.com;
Received: from ZR0P278MB0523.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:34::6) by
 ZR1P278MB1410.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:98::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9456.14; Tue, 30 Dec 2025 22:00:32 +0000
Received: from ZR0P278MB0523.CHEP278.PROD.OUTLOOK.COM
 ([fe80::39da:49d1:7c23:953e]) by ZR0P278MB0523.CHEP278.PROD.OUTLOOK.COM
 ([fe80::39da:49d1:7c23:953e%7]) with mapi id 15.20.9478.004; Tue, 30 Dec 2025
 22:00:32 +0000
From: Javier Rodriguez <josejavier.rodriguez@duagon.com>
To: linux-kernel@vger.kernel.org
CC: Jose Javier Rodriguez Barbarin <dev-josejavier.rodriguez@duagon.com>,
	Jorge Sanjuan Garcia <dev-jorge.sanjuangarcia@duagon.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	linux-serial@vger.kernel.org
Subject: [PATCH 2/5] serial: men_z135_uart: drop unneeded MODULE_ALIAS
Date: Tue, 30 Dec 2025 22:59:25 +0100
Message-ID: <20251230215928.62258-3-josejavier.rodriguez@duagon.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251230215928.62258-1-josejavier.rodriguez@duagon.com>
References: <20251230215928.62258-1-josejavier.rodriguez@duagon.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: MA2P292CA0027.ESPP292.PROD.OUTLOOK.COM (2603:10a6:250::16)
 To ZR0P278MB0523.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:34::6)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	ZR0P278MB0523:EE_|ZR1P278MB1410:EE_|AMS1EPF00000046:EE_|GV0P278MB1765:EE_|AM4PEPF00025F9C:EE_|ZRZP278MB2022:EE_
X-MS-Office365-Filtering-Correlation-Id: e0f0fc40-925a-4f27-bb9e-08de47eee047
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?nH1dM7BuOTTX1tttOFXRLx0FhM6DAt2/nUZH3GVt/2MF4I/z51wZ2nLF8VQs?=
 =?us-ascii?Q?pqrtVLm0R8fiscJ0NM6gHnm1Y+wkN7vWera+RXEsRjVJ1lvNgTFzdhmtJIaw?=
 =?us-ascii?Q?Y1i8DTTQRE+xKBbBiJk/miivtR8moQ5XRz2tisTnawehbvQcQMXZzEX45YrK?=
 =?us-ascii?Q?cCVrLDbscpSZoDVbcyhpbB5l5ePcrSGBErRoHs9YU4h+y9SvNDFtCFkAOHPr?=
 =?us-ascii?Q?W68mjeMn/N4s/yio6XQpDm7U8I4W3sejCUmntHNE6HDeqZS3Dd7RZNsZdlfP?=
 =?us-ascii?Q?qoLLBXuiEoVAOTkCTAnNdsBzalequhodGFHqyNsUev62foopGo8iZkSo7AJt?=
 =?us-ascii?Q?/sMD9QX12qU2Hotg3eGnOJQa4/DJjqiNDa1eGl2HN44ZcN7IX3i98XMdRU3j?=
 =?us-ascii?Q?gxGLus4Jmh9XchjMbpmvAZ7jYxx9CLMw7rTe28frlO0S7+5B8MC+S0etca5f?=
 =?us-ascii?Q?bo7RsaGTAzHpppZQBmTkWyNkn4sKJNjQG7FEfVe1LwJIVfqM0zV7PYjlAPP9?=
 =?us-ascii?Q?V9CscCXj0QCaoOyKS/ek2cS7XmvII/Edd4Uhtx+mGHaZhMVaUxoLKfC3Jipg?=
 =?us-ascii?Q?9UQxKR2o5Xq166fit/vsBK73JhqJJB87s2enfdTMyLYxqKqo8awJOJpEn1o/?=
 =?us-ascii?Q?L8/5X5Wip4FV7qlx11tXIQc/jwOXhOwzXCUfLeZN4P5wdLCkCGdm7RwkGS1L?=
 =?us-ascii?Q?2D7A4ujZC874J9pqyoF3iCUpxtoSTfVczluPmPfp+rPB0pL3qnQ+ZdOGKCBW?=
 =?us-ascii?Q?Iea5A0nF7DghbSe0/Pg0vRYubc14v1h/Yx4U25uQiZVTTUVsAwxVN7+u+DVD?=
 =?us-ascii?Q?gcARnr4oZoayqVl8TSfKuEc/OSgprCcdwYBaIZCqKDVg+wzQBjLeRgDAZ0Qe?=
 =?us-ascii?Q?M3ZQXRcr+QEmZLmze455WUGRovB+XgrDAE0Y2h6ZJ1fL5ocXSLcfpJAjUpzV?=
 =?us-ascii?Q?irqapci/kPvFLiSSs08SR3WsjVzlwypjApaGZtNOHMPGKiM2NmmEKq0cmCCw?=
 =?us-ascii?Q?99hjK4k2KCQxTjHiS9YonfG8TqNkOKQ8JdFe+FO4OrNQmvKJ68yzS0pB5jin?=
 =?us-ascii?Q?ChOt9Yk6reFpCHQalI5ui4YJN1xh6nqhrx+aG19H7x7QV1SEU0D+ycxLZp7X?=
 =?us-ascii?Q?pF42DFqPnNyJcgXlhO8esacUwcNY+SXJ/8q4iSN73XnQ4uEyBFpcQzpFuah9?=
 =?us-ascii?Q?iAOqTIAZL+hx4uW4+gKyZKDkxurWmakWdr4d0AXLTvgRp11T3VqXfPiIVGv8?=
 =?us-ascii?Q?jaIgFgiXku1IVDlDLTCwF51Ga5i5OhIubU0WQzbz1Oh98tTyGC9rKvXbOvzN?=
 =?us-ascii?Q?FPu6WzybTmkV46QYvzMGkyH5f+Lx1WIoQUYORaE7usXE9Zx8KOW/BxNDkrLN?=
 =?us-ascii?Q?PWoxvYj3jrNObHPHl7oGtoBcy4U/sXtqWbC0eQga0k7BK3pJiWsVSyVQU2/m?=
 =?us-ascii?Q?R8cCvpRLyEJUhbIEBIVVSaJ9Fst2bP5W6M12Qf20yY9xQ65iVLCBaS9juRny?=
 =?us-ascii?Q?tHKjliznXoHS0mx1F80nljyc6RLZoTGNXqY0?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZR0P278MB0523.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR1P278MB1410
X-CodeTwo-MessageID: 26139af7-b76e-4ded-acb6-86760e3f6b1d.20251230220034@de2-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 1
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS1EPF00000046.eurprd04.prod.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs:
 440e1943-1c4e-46e8-ab30-08de47eeda89
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|1800799024|82310400026|36860700013|14060799003|35042699022|376014;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?J9KVhkRa/7GKcA1cUjixwucaD+C0xXwmq1kPY3u1L/73HhiK+7AsbeC75OxF?=
 =?us-ascii?Q?Mvbxga9v1+fzN8Nguz5daXwbMfJb0wHezMRI6IHZW1lsSkURHx8BAgJ0zcsn?=
 =?us-ascii?Q?+HoSebEHfKn5zrh/tATFC2IHkBSyjAEE/rkann6AAJTOeenKA5HpE/yuj+Fp?=
 =?us-ascii?Q?lankAP+Zmv/9G2nVsarLgkt6VgK3/nz8+jclU+6tGhCI1Frt7ahPMrftKVlo?=
 =?us-ascii?Q?KZ8jq+A/sZjy/K3Lz8hkfmS3rXB6QzyO1px8MHMJBu8lV/oMKAnGgIFuj/Io?=
 =?us-ascii?Q?0v4Xz1ygeR03F61Gbgrdq4IEmlQUD7DNwawAxQ/SHB7FPO1F55bkaJ6E6CwZ?=
 =?us-ascii?Q?6B09pjmM1bdTtDTJ5g3DVrzshqadl3Olv8fdtSNFDNh/L+L1VkVUJN/P/DAf?=
 =?us-ascii?Q?Q9UME2nA6scKSIOx49Qqi5rjH/8PsAd6cgvMjATjR+ChdJvBMDrujkEzfNW3?=
 =?us-ascii?Q?S0OCoqW7gc2JXT8S69wU9tk2z0Dj91wUmiTnyuykrqqlpnUwtPjQZE94DBJb?=
 =?us-ascii?Q?BgQXZME8SIXJHfg7arfH47zx3TFXPIX2c4/in72hNleKZgLcVL9jKtXqmng9?=
 =?us-ascii?Q?XIlfWNpLJntG5aavmXEEvigAp4tCDYqjI369qYWoGXxp6NWVG7uJvG6YvOqI?=
 =?us-ascii?Q?hkqx3rxuURlNp0DXcvEya8BMshxWeOB4Y9CzFHCFB2l3BupvMy0ids0LWzNB?=
 =?us-ascii?Q?fISBuWCorViv8owjL4aUA6iEwMAW7K5ujxwI53+etbQa3gBBTj6WS1HN7JtT?=
 =?us-ascii?Q?s/Hk4MxFVa1FcghEd9nz693zlzhU9fqxoteqlwSde8YhDaVWWyAP0d0wdhTw?=
 =?us-ascii?Q?amuhRNTlAISyJ68FZcn+0es/+pVl6ACMP9ckIC/1Fc+y2Cosq72pdi51OV7P?=
 =?us-ascii?Q?xZvJj521Clr3B+CX53+kh0elREqfkmmJ0LbAyCauwjIJ0NKZl3PIhOrGRjpg?=
 =?us-ascii?Q?jksmr/MlU70z6klyfCU6fQiUJt4HaQdz4zxK22r8OZq3cBTrw7/gk95+N14J?=
 =?us-ascii?Q?L32Dpc3HrVuKX1TmlW+6cNKccIEQnQdzwGl68Dkp/F3eLxYfg8QV1Ubv0fTZ?=
 =?us-ascii?Q?VAf5PlR8lpgoLwLGWm4yavfe5bWoLGugWvk2RQZQYwtAOXAu5Y79wc8cf9wC?=
 =?us-ascii?Q?wJfhB76aLoSqr4SYfV4NfGTLxPnDJe7c1ECIlb9CnWQhwxdQRR9c0MOtXxL4?=
 =?us-ascii?Q?5rGG8KkbgIq3lvztMhvCf7x8qj7fdztXA8pNEzk57Z/ZJ3BeWkn87xPuj17G?=
 =?us-ascii?Q?FRvnW+bCLDp/1p4Xtst6m1je95K5GB+qCToLtsac9Zur7nfORMtXNelcJ6s7?=
 =?us-ascii?Q?G3d7/cYwz9AF5JJ+4SHxZTHG1qtUGU7cDgWiKbtNsfoFT4NjzhI8L3oYZ4YJ?=
 =?us-ascii?Q?REVbYf47dqeRdFkzga8vTqHQGu+HZzyB0yVXgX6KdZkkJJSSHhSIbcwe5ShP?=
 =?us-ascii?Q?BVh49skccSypoeAfMSDApS76nzppXkta9PI2m6fPWs3nZkUl75r6lnffRER3?=
 =?us-ascii?Q?6oxKllP7Pbqw45bUyiTFab8qFHUCTK3b3zz6ZMVFxUgInQAiPHVyKVlI1AgP?=
 =?us-ascii?Q?mBWPOS7KUp/9kdM5YGk=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:20.79.222.204;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:de2-emailsignatures-cloud.codetwo.com;PTR:de2-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(14060799003)(35042699022)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV0P278MB1765
X-SEPP-CCCVersion: 2025-12-11T08:12:51+01:00 9ed91da2
X-MS-Exchange-SkipListedInternetSender:
 ip=[40.93.85.2];domain=ZRAP278CU002.outbound.protection.outlook.com
X-MS-Exchange-ExternalOriginalInternetSender:
 ip=[40.93.85.2];domain=ZRAP278CU002.outbound.protection.outlook.com
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM4PEPF00025F9C.EURPRD83.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	ed5a6743-c62a-4a20-2d55-08de47eedc00
X-SM-ruleversion: 2.1.0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|35042699022|376014|36860700013|82310400026|10070799003|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?aaVOkJANp9+egwMvgS9mvFRKlR/g/JafiD2UvOZdt6RisM6GAci8da4KiGCz?=
 =?us-ascii?Q?2doppWPHSS0dndzYsLOFpX0Qi32QycBkqLeVQID7uh96XY/4jZM1o+zYMs1o?=
 =?us-ascii?Q?eVCL0y34Wcyxt1EhXYdh4Yz7E+ep2PlfhOc20QUac7sB3/fIybLG+GAjJhUJ?=
 =?us-ascii?Q?SeqojEzo67KLeslphrB5+90JiB3T7niBR52cRuZt79gvTgAlPJsn8GrQA51b?=
 =?us-ascii?Q?KvNNHNK29HtLIAPvv3cdm+VZnpRMOFhrKUPJVElKigCcO0F2OP7X5aBz00KN?=
 =?us-ascii?Q?6oygI0NjFoHbK1rbXGEz/6g246gcrCkF9gj4cJbWgeBeRTy+YvBxym+jxJY+?=
 =?us-ascii?Q?BvJsyyCondcvavn/Wy18G4OgiyG7tu48lXMKC53HvRzXAIWXVw1vX1oTaFwC?=
 =?us-ascii?Q?U5UyYInWt1AR5nAb53JGQrmSj0HIcfBAyZDqGE4SD0KFiWi/L6FjLQiPT/XE?=
 =?us-ascii?Q?O2s1QdbzxfbPDHhMtThbStccgdYDlfpVYYo/zt8X1TvetB/tVrW3jzrjTRMm?=
 =?us-ascii?Q?k4hKHcYL3SlkmLfj3a8zNXFJuAN8t/RW465W2UHDmzwIDrKxhmU9ndEi0xcx?=
 =?us-ascii?Q?yV0XktBRrdTUicqXop/yBHyVmsorm31RLcBzDFFvPdBa9VrXtlep4d6cpYou?=
 =?us-ascii?Q?ty7mpkVJCDNPmXNKLwDTodaEQKimluN/J7N+DN6tNWursovYnoj+VMDv9gdT?=
 =?us-ascii?Q?gjU4sHEom6oq6Q6vk0J6Bq2mKgh10hkaaBc0uh5l5f/E7qIdSmS1Xa5vwU8H?=
 =?us-ascii?Q?DyAETVgF0sR+XzDNNQoOQxiO3bcHc0xFjna1l0kutdjR1eKjGUK3deaRfN9T?=
 =?us-ascii?Q?qCCPtKoTYXyHZumKWSkOXIf1jJ8tbuiSEHSSxrSjXydkX+9vpycTv+/jbqKm?=
 =?us-ascii?Q?PjGpo0bTH4yIoTWlXFz0YPdxZ38NtYcOoa+wzOu6pct5hmv4z213FRv1WwOD?=
 =?us-ascii?Q?k0dlh3z1EIoriCkar6oEIfFpKuDfF9Yz+TxghMs6JA/NStBGdogHK1zkt0DZ?=
 =?us-ascii?Q?bK0xH7fxY7c1HCm32eYipB1Kh3geZRbIqeyxvX2CNeZTWMkPEMzDUvecFXzH?=
 =?us-ascii?Q?RHmSpi1zcD1PGm+uJVpmc/aqzQDPZNqLvzW1toyZCguEqUUi0+Dow7/lRVvr?=
 =?us-ascii?Q?l5k7qF3GpJtN?=
X-Forefront-Antispam-Report:
	CIP:2a01:4f8:a0:900b::219;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZRAP278CU002.outbound.protection.outlook.com;PTR:mail-switzerlandnorthazlp17010002.outbound.protection.outlook.com;CAT:NONE;SFS:(13230040)(35042699022)(376014)(36860700013)(82310400026)(10070799003)(1800799024)(7053199007);DIR:OUT;SFP:1102;
X-OriginatorOrg: duagon.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Dec 2025 22:00:42.2966
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e0f0fc40-925a-4f27-bb9e-08de47eee047
X-MS-Exchange-CrossTenant-Id: e5e7e96e-8a28-45d6-9093-a40dd5b51a57
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5e7e96e-8a28-45d6-9093-a40dd5b51a57;Ip=[2a01:4f8:a0:900b::219];Helo=[hz-deliver01.de.seppmail.cloud]
X-MS-Exchange-CrossTenant-AuthSource:
	AM4PEPF00025F9C.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZRZP278MB2022

From: Jose Javier Rodriguez Barbarin <dev-josejavier.rodriguez@duagon.com>

The MODULE_ALIAS() is redundant since the module alias is now
automatically generated from the MODULE_DEVICE_TABLE().

Remove the explicit alias.

No functional change intended.

Fixes: 1f4ea4838b13 ("mcb: Add missing modpost build support")
Reviewed-by: Jorge Sanjuan Garcia <dev-jorge.sanjuangarcia@duagon.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: linux-serial@vger.kernel.org
Signed-off-by: Jose Javier Rodriguez Barbarin <dev-josejavier.rodriguez@dua=
gon.com>
---
 drivers/tty/serial/men_z135_uart.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/tty/serial/men_z135_uart.c b/drivers/tty/serial/men_z1=
35_uart.c
index 9cc15449b673..6fad57fee912 100644
--- a/drivers/tty/serial/men_z135_uart.c
+++ b/drivers/tty/serial/men_z135_uart.c
@@ -919,5 +919,4 @@ module_exit(men_z135_exit);
 MODULE_AUTHOR("Johannes Thumshirn <johannes.thumshirn@men.de>");
 MODULE_LICENSE("GPL v2");
 MODULE_DESCRIPTION("MEN 16z135 High Speed UART");
-MODULE_ALIAS("mcb:16z135");
 MODULE_IMPORT_NS("MCB");
--=20
2.52.0

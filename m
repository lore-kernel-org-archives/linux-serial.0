Received: from ZRAP278CU002.outbound.protection.outlook.com (mail-switzerlandnorthazon11020092.outbound.protection.outlook.com [52.101.186.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16A23466B5E;
	Thu,  8 Jan 2026 13:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.186.92
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767879741; cv=fail; b=Gh5cZOtT/JNxMf7uYyuoQv99HUOgCf6KsGsz24UiZxPPS/26l4ZruiGYQiwgGeWmRrNZZ8lbUNm1ugtK++KFgG9QwYcP4Wkgn7UWE4PlbTWF+Q7qB0Yk/vkDuaIqYTlSlD+Jd9uHkoBEMrLbnhvdA7aBR9NtvxD85YzlybZyXJY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767879741; c=relaxed/simple;
	bh=YJzwIhsSK1fM6lufP+0pwwRN5ti3r4lcY0NtlHg8u60=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WP1O2GLbdNiDISthOwHleel0rkBx9NcJnN/94Pa2ywH0NYshYkjJ1ycWKet2VVEkLEGFLzxJneegOAfG8X/i1woagZhWBQN+HKydkRWZR30i+g9JoF5s+PT7I0E5Fv/fAxUKKJx9wL/JGic361du4dIJZY/+yF7lLW27orSgdVg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=duagon.com; spf=pass smtp.mailfrom=duagon.com; dkim=pass (1024-bit key) header.d=duagon.com header.i=@duagon.com header.b=L/Isfn0a; arc=fail smtp.client-ip=52.101.186.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=duagon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=duagon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=duagon.com header.i=@duagon.com header.b="L/Isfn0a"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ylMjXaqiE8lXMstbDJ/IBbWBdY7/hL+v8KibkY6ExFjdSHOOvA2Wr7ASaBBOZrI15leN2NHb5Eurk0lyGMbSt8KPYIi62VlNrn2DcwxPo1ZRIaodRdwG32hjhGG8wdO+0J15WMPptkbQAQh7UsgpQvoaFqM6uDyV/7cIwm6V1fHRoYeMAZxOEFdirnJ4cxrkaVNAfkoQfx1PQO/0Zsv6bkWgSN7P1jzgWXz5ygglXTLERWfNs+iPUM03WRU2uKvmUcmYixSFZim/yvZJI0yOPPbMtdwpbW8CA+tgERk0uthAfv48Ix6KNl7rldYsSqxidDQYjBdIwCrUvWlsQbmXUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YJzwIhsSK1fM6lufP+0pwwRN5ti3r4lcY0NtlHg8u60=;
 b=ETrrGDcdD/xtXWgrgxIebsPtQtbbSTPFN2W9hUNO2RKqjemKPEzo+uGkv/pish65frObxqb0pmmDayzMIPG0jhW38Nr1FGfQaENAifsGePNFl7DWYbNG9mCftXPbveGvI3E/tCHEQQU32EByKgkmv+0CkIfvVKUZ+Y/2FIQQ/eDeuiTg/k9x7nLc9Rfek9F/EiQcQ7rTsJsekb44tOgrX/x508HJS96nBC8+O9A/8jb1PooWVU+jNOnmmii5rhmBWZ0eHfJ6/oksGGYR2rR5nZEX9bOurJbFtkYcI3kQdZb3TdMpsCbtch8R95V7Ui367ZZ+LnHVMxvrY/bXTslyxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 40.93.85.31) smtp.rcpttodomain=intel.com smtp.mailfrom=duagon.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=duagon.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=duagon.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YJzwIhsSK1fM6lufP+0pwwRN5ti3r4lcY0NtlHg8u60=;
 b=L/Isfn0aF5HlMEBhzXFJs24StfzZ0WiYjK5961YSJhQ/6h8Yh7LYU4rFBwThVHBHP3eUMRRV0+16PD4GIU9opsNUktYQLSCNjvcO59wHTvDMaWnRMa+9f1CIgFr8G29t6Xz0bDvkGNPSqy9K+OJoGWXnQcVm6YWl15iqlretRa0=
Received: from AM0PR10CA0027.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:17c::37)
 by ZR1PPF183F358EB.CHEP278.PROD.OUTLOOK.COM (2603:10a6:918::289) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.3; Thu, 8 Jan
 2026 13:42:14 +0000
Received: from AMS1EPF00000040.eurprd04.prod.outlook.com
 (2603:10a6:208:17c:cafe::b) by AM0PR10CA0027.outlook.office365.com
 (2603:10a6:208:17c::37) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.2 via Frontend Transport; Thu, 8
 Jan 2026 13:42:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 40.93.85.31)
 smtp.mailfrom=duagon.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=duagon.com;
Received-SPF: Pass (protection.outlook.com: domain of duagon.com designates
 40.93.85.31 as permitted sender) receiver=protection.outlook.com;
 client-ip=40.93.85.31; helo=ZRZP278CU001.outbound.protection.outlook.com;
 pr=C
Received: from hz-deliver01.de.seppmail.cloud (2a01:4f8:a0:900b::219) by
 AMS1EPF00000040.mail.protection.outlook.com (2603:10a6:20f:fff4:0:2:0:5) with
 Microsoft SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Thu, 8 Jan 2026 13:42:12 +0000
Received: from hz-glue05.de.seppmail.cloud (unknown [10.11.0.47])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by hz-deliver01.de.seppmail.cloud (Postfix) with ESMTPS id 4dn5g824m5z4wvr;
	Thu,  8 Jan 2026 14:42:12 +0100 (CET)
Received: from hz-glue05.de.seppmail.cloud (unknown [172.18.0.4])
	by hz-glue05.de.seppmail.cloud (Postfix) with SMTP id 4dn5g81q5sz20y7;
	Thu,  8 Jan 2026 14:42:12 +0100 (CET)
X-SEPP-Suspect: 6215ae8dd39d4f04ac2180b192500459
Received: from hz-scan05.de.seppmail.cloud (unknown [10.11.0.38])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by hz-glue01.de.seppmail.cloud (Postfix) with ESMTPS id 4dn5g81H72z1vfL;
	Thu,  8 Jan 2026 14:42:12 +0100 (CET)
Received: from hz-scan05 (localhost [127.0.0.1])
	by hz-scan05.de.seppmail.cloud (Postfix) with SMTP id 4dn5g80gJ0z8mlQ;
	Thu, 08 Jan 2026 14:42:12 +0100 (CET)
Received: from hz-m365gate03.de.seppmail.cloud (unknown [10.11.0.36])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by hz-scan05.de.seppmail.cloud (Postfix) with ESMTPS;
	Thu, 08 Jan 2026 14:42:10 +0100 (CET)
Received: from ZRZP278CU001.outbound.protection.outlook.com (mail-switzerlandnorthazlp17011031.outbound.protection.outlook.com [40.93.85.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (not verified))
	by hz-m365gate03.de.seppmail.cloud (Postfix) with ESMTPS id 4dn5g52hvrz1wR1;
	Thu,  8 Jan 2026 14:42:09 +0100 (CET)
Received: from DUZPR01CA0160.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bd::20) by GV0P278MB2028.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:710:6f::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.3; Thu, 8 Jan
 2026 13:42:06 +0000
Received: from DU2PEPF00028D02.eurprd03.prod.outlook.com
 (2603:10a6:10:4bd:cafe::e4) by DUZPR01CA0160.outlook.office365.com
 (2603:10a6:10:4bd::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.3 via Frontend Transport; Thu, 8
 Jan 2026 13:42:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.79.222.204)
 smtp.mailfrom=duagon.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=duagon.com;
Received-SPF: Pass (protection.outlook.com: domain of duagon.com designates
 20.79.222.204 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.79.222.204; helo=de2-emailsignatures-cloud.codetwo.com; pr=C
Received: from de2-emailsignatures-cloud.codetwo.com (20.79.222.204) by
 DU2PEPF00028D02.mail.protection.outlook.com (10.167.242.186) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Thu, 8 Jan 2026 13:42:05 +0000
Received: from ZRZP278CU001.outbound.protection.outlook.com (40.93.85.31) by de2-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Thu, 08 Jan 2026 13:42:04 +0000
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=duagon.com;
Received: from ZR0P278MB0523.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:34::6) by
 ZR4P278MB1901.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:b6::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9499.3; Thu, 8 Jan 2026 13:42:02 +0000
Received: from ZR0P278MB0523.CHEP278.PROD.OUTLOOK.COM
 ([fe80::39da:49d1:7c23:953e]) by ZR0P278MB0523.CHEP278.PROD.OUTLOOK.COM
 ([fe80::39da:49d1:7c23:953e%7]) with mapi id 15.20.9499.003; Thu, 8 Jan 2026
 13:42:01 +0000
From: Jose Javier Rodriguez Barbarin <dev-josejavier.rodriguez@duagon.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org
CC: andriy.shevchenko@intel.com,
	dev-jorge.sanjuangarcia@duagon.com,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jose Javier Rodriguez Barbarin <dev-josejavier.rodriguez@duagon.com>
Subject: [PATCH v2 2/2] 8250_men_mcb: drop unneeded MODULE_ALIAS
Date: Thu, 8 Jan 2026 14:41:10 +0100
Message-ID: <20260108134110.25278-3-dev-josejavier.rodriguez@duagon.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260108134110.25278-1-dev-josejavier.rodriguez@duagon.com>
References: <20260108134110.25278-1-dev-josejavier.rodriguez@duagon.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: MA3P292CA0040.ESPP292.PROD.OUTLOOK.COM
 (2603:10a6:250:46::12) To ZR0P278MB0523.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:34::6)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	ZR0P278MB0523:EE_|ZR4P278MB1901:EE_|DU2PEPF00028D02:EE_|GV0P278MB2028:EE_|AMS1EPF00000040:EE_|ZR1PPF183F358EB:EE_
X-MS-Office365-Filtering-Correlation-Id: e1fd025c-4def-4f2a-c12c-08de4ebbba62
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?bTqgyAjiJdPiT9JFfd0GEjwFeRf+MOXpoHTC9U5SMh1FAYF1WNbIOkTJ/cqd?=
 =?us-ascii?Q?eR2XlfU6ZhzU4xSFaHcjQH3CusiFLw/OM1MFg9W0xzYwFa5NJp3XGnOxbzOg?=
 =?us-ascii?Q?QoiaxPL7bVrNK/YH+0aeb4J+WuZ8xGH4mMeoacIGAIGLpBF+DLIpaiE9hX72?=
 =?us-ascii?Q?y9oFICJE/FoE2ScLgu0uYhjcjmlYTcYqiBgZarQjkGytyPY8jMCMRkdIQwCK?=
 =?us-ascii?Q?kF4hvE1e84BsyB21Kx+Tg+VYLGGL6ocingKpVZ8I0uWixz7biPj7eiDy9wgG?=
 =?us-ascii?Q?Bmv3FxNHexUdJh+VpDqhM6UyFLsR0mmpxlUIRkKH2rjmbqFZEW0/xFapTTJg?=
 =?us-ascii?Q?VVa590Ov1WdLKwT9z1NACFG6NQ/EAT9epHPvcRJMYQiRiW6TNd0WLGKN7kCd?=
 =?us-ascii?Q?gI7uj14hqzEoRWe3y/Iqs5rN/sXDSbQi/0LlPB4UtgPJ9klbs6mntNP2c5wG?=
 =?us-ascii?Q?Sc3F96wZLUq1dP/79jKPJyADceiLuVLIwrDNX5Zt71GsuvGPMvPTodUxzrPc?=
 =?us-ascii?Q?x1YmxBlrg854kN9NMMr5gXb8vihl8LedTOf/q/xbPzUFyfbINOjpuFb1ZBWU?=
 =?us-ascii?Q?vqe87fMvEOFRdFzAr7BG3UE/1g+L1byqlhabbwPZiOSoklIbcqDrVq2NoMdI?=
 =?us-ascii?Q?ZNbbkx4HcZraNX1zKgccOfUotFucMswDLg3DMF6iyIwoBrWgGPkUPSjnxsJR?=
 =?us-ascii?Q?rwrBss3nvZKUFbY48TpXS6XoziM9VTz8enH5RUb8aTIhAgN53unzEMfbp/8R?=
 =?us-ascii?Q?5Lwj9dZI/S7ZX5Dmh7qIuYZo03jXJmaaMusytaG9b2kvX1+M7Z3CQmGW3yd4?=
 =?us-ascii?Q?RUDerx5hvAlOCmdkV9ujbES1+e9ncYZhMAkQwUc/U0qVknJPbayvZgk18Z++?=
 =?us-ascii?Q?8z89lAJX9hH6fG+l6CSyBnVt+BCRMQVyQWoAbzl0ILXze5ojYCFXZzwKgfKw?=
 =?us-ascii?Q?Ko+a8mUOK32Cw3eB3tRWbFTSsiFzkFJ6Z6f3kIs0vodufBhonNTU8Ej+Tv9n?=
 =?us-ascii?Q?3P/G8i/kn6CKcl/EpU9tbscDvlAvUvspziYVyCo/5Ac05qK4HCi9AIvbD7Yg?=
 =?us-ascii?Q?msSWd9z37umpONjvhxcDPXPZOS7xhaBrKxtUowfCfbXKuqPIoYpdBbFPURzt?=
 =?us-ascii?Q?qRaRKQT5PHOaYLPfLQc9foFA8ZTlXJcu0o+F8MPYvxjDqZI6bvqOrOwrFAeZ?=
 =?us-ascii?Q?87cBqaC15/L2p4DrurCcAD2OiMgakO1zgTUBhMdMPxvgEuesbNdNShF6Mj5B?=
 =?us-ascii?Q?y/6NQ7/g/2FfWhBSA0yYMS+yuPgXBU/zdvCzaUhniM7wW59aUvoVI0sq5Y7v?=
 =?us-ascii?Q?j5VPDCKHkGRKLTsLb9OcVjWkxqlJq5GUNF8hONIi9E/snIGiAzbVVcD9LqYu?=
 =?us-ascii?Q?Pc/lh8Wu6B4Ib8W1m28e73z/Cvxj9lhQZyL+tO0zrFVvopyQVB/ZjC/mELmp?=
 =?us-ascii?Q?fPdnjAz7ftc5HMl4GVbzidiM+RUtiaRkeMGkWYiF7kbV3g1v4zWKwrzEjHIY?=
 =?us-ascii?Q?xWcx4L5nSoJQB22Oibtr8frKouv1r4tyH3gR?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZR0P278MB0523.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR4P278MB1901
X-CodeTwo-MessageID: 6e6f0bee-e74e-47b7-ba3b-db4831ea9ecd.20260108134204@de2-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 1
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DU2PEPF00028D02.eurprd03.prod.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs:
 2486c574-3f33-4ad2-6a08-08de4ebbb362
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|36860700013|376014|1800799024|14060799003|82310400026|35042699022;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?iuUHtXYDk2dJRYDRJ+4DSjhB5U239zA5d64KX+dNB8o/t3t3QvzuBqgA0sQ+?=
 =?us-ascii?Q?iGt6jHv+go/9EQ881CjWfSwIb1mNq3Ximc+EkvXlpn70M6o2i69J64kVVi+j?=
 =?us-ascii?Q?P2QkO+O5DbSTkqfgX2vpikesKEcj3ynnv+djJa0YJqJHlVZlfArkxxEbEajO?=
 =?us-ascii?Q?anLs+KZb0lfIGoeOphzx/tnGeDgcKPI+9C04KIhDVhKkBJ0p62+WqCZdFHa4?=
 =?us-ascii?Q?A44i9cyT/oUFwVR/I7t00axi4Y6K1/tYlvEDx2k7iIhgNfyYh3pjG1LnvkTj?=
 =?us-ascii?Q?0diW6360u3Rl53+73+6NvvHpvpBnmZEvO0cmWGXupUqufXhxDd3CV0y/i+e2?=
 =?us-ascii?Q?aXU+8pYGJ9N6KDNrgXSexfK82Xo4rbWbNQoWECYPs6hntRUJb2cMRcOnaHWl?=
 =?us-ascii?Q?ufFz4QPJmJe437Rg4Lt1y6LAnAINTXBtU63rbIfAXs/T08sEPX7zpoyeL3X5?=
 =?us-ascii?Q?qnHRMSdFXVaHVM/YbCQyrHUJBCSf4mV+tu7dKFYhPbvzj/8NOAfLgXyRhNap?=
 =?us-ascii?Q?5MSjroOvurr6oT0l3tSQgVfhUM2M1tW/lHS0sGvm6UdqT2OfHCp6VvjsO+El?=
 =?us-ascii?Q?4CS5ccp6OmeNRVGC6aI1JOSr/FsjgkV5aXCLkwfL3idG6Dy/BrWhB1WPzKK/?=
 =?us-ascii?Q?RPLdcvFZnL0glhuZB/wHTDO0UuXN5DJ1+Huu3oEWVG2yLYu7Fok8uRavkUmL?=
 =?us-ascii?Q?W6o5WiOzCHWDPul6fNA/RnXEVDxfofQS+rxdcdBaNE7CtgepT9VYDWu97YTp?=
 =?us-ascii?Q?hy9FxhMbS/SZOhup31/OkRDzj8pQXPbNQNAORyjmTOyfEyRUXwH/kh0K7Bnx?=
 =?us-ascii?Q?Gbml/rtn+hiMeddsbPZtSVvj/h2kFFfwRw2piSuh4p5YGLQbPvI+OnEMN9YQ?=
 =?us-ascii?Q?ZMmLRBL469fxnASGkUgad633JwGsetfYoH28icIjg43MwtQ7bV4JD4pUO8Oj?=
 =?us-ascii?Q?RyDvY++d/t97Pjww0w8f6v+BMtd48exOjp+SNF44I6seQLCwNYI96Pf6HFjA?=
 =?us-ascii?Q?NulejzWuZzggVOKtIRoWfkmmrT9m0v/rUfAo1au18o3Ulo+Q+MfjrIRVDpr7?=
 =?us-ascii?Q?ahSjRLRiMgMphOlYHQzztxRCfOTPhML1N5p/5A1bi1R9d/mgmD3bRNRewo+2?=
 =?us-ascii?Q?NQIFpWFmZMd8E66qL88vosHr2iB6FHvAs4W6VEiW5VXrwj1oWwNMrDRkTw1u?=
 =?us-ascii?Q?WcBu5vFEfYvMcJgKqADsq/5lZIWpOVk1vesd87caozF9elIJkkhnIUz7rADH?=
 =?us-ascii?Q?XQTU6ijma29VVNuA+WvFcde/KW9JRHdvaOX48Gj0ysx5VbvVibrMdwFsFTDh?=
 =?us-ascii?Q?TstcoomksvnS/qMbS14TZ0ZbRYkKskBhoahuhvV4atKaXeCMNkxAswNtDiJz?=
 =?us-ascii?Q?K00Oi4Ny1pmIexNlCqXLIQxQpUyZN7W3E8r0tIBwkI/rZZ2gJmCCivYYRdBp?=
 =?us-ascii?Q?6TnPQfA5hjXVNUy6nLpChKw7+2Fg3GHQRBUdykf8k2JJDhv2NqYUMaGuR0oI?=
 =?us-ascii?Q?m3uJJPPTcbV1fiNLQXS8ZBTb88tfc4OhgksnId0faQeDJ2hrQ9W14Hv6MM+q?=
 =?us-ascii?Q?FWu460n56fBqnX3Orfk=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:20.79.222.204;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:de2-emailsignatures-cloud.codetwo.com;PTR:de2-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(14060799003)(82310400026)(35042699022);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV0P278MB2028
X-SEPP-CCCVersion: 2025-12-11T08:12:51+01:00 9ed91da2
X-MS-Exchange-SkipListedInternetSender:
 ip=[40.93.85.31];domain=ZRZP278CU001.outbound.protection.outlook.com
X-MS-Exchange-ExternalOriginalInternetSender:
 ip=[40.93.85.31];domain=ZRZP278CU001.outbound.protection.outlook.com
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS1EPF00000040.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	e07550fe-c8c7-494f-7680-08de4ebbb654
X-SM-ruleversion: 2.1.0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|10070799003|82310400026|1800799024|35042699022;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?afUXOl1QRERhbBjLc9NTkSKVX/sTsSlHv2fYwp2I3CvhV6pMzL2qtpdadMly?=
 =?us-ascii?Q?fzYXRdKoZ5A1GAgZ8Tg3ThLveAMwEwZDoqyydO7QFOABOqC4dduYSv6t7ej2?=
 =?us-ascii?Q?vALACPlk3xkZgdpIN1s+xFLMt0WIugJl7o/LAefM58o7+s9iCd8COmSFfLOz?=
 =?us-ascii?Q?MoXYyM/cNnuR8bUiOFCdGf5ajn5LmcBxMaogRzsdTS7eCpny56LDm15/P11a?=
 =?us-ascii?Q?uDwZbmXcDv3wzP6vKgUFDy3uDBqRle615eTcM3NRgJfdTFd5vCo/wpeZhjr7?=
 =?us-ascii?Q?wtm3O6F92bJxn5IQPqnKyerZIqrq+//GvWhHA6zKp7Fr+0z60A69Y1Cfz8IR?=
 =?us-ascii?Q?52q6795AfW4jca2Msyiu1AfgHImOsQO5Ulz5LE25cMi6Co2bUpS0Iz5ixM4t?=
 =?us-ascii?Q?dA4m2uLG6/BhJKSvs7faJUvlNRJK2gdcYAnDFaQpV6maYTB4k4KlW+HYkKbb?=
 =?us-ascii?Q?GbUHmXKoQSGYEOxUzEYUjJWa2xdVC6U315dckLquivPu7T+spQ7nZEvG2pa+?=
 =?us-ascii?Q?q39MgG1X/bH0iemA7jFvJJKjLJ+94ABBC0hkHKCqTvpnOGfeBvjPGN9rB/ZS?=
 =?us-ascii?Q?4xunWc1DDgjvWgx6GKYCNd7cVdhBFxWkOVHPcYESuTlOqtiYS72ubtiK+lL0?=
 =?us-ascii?Q?ybhMZXibOIbQKQv59/0NdL+sRnVEkM/aWv7fZxC1DAthw6ZPjdcmQ9m60OEM?=
 =?us-ascii?Q?5qgn+178kvmSQ77ZJxbNLCfuLCztfuSopfPIfPoPUG7P959gteGTrryc9ruk?=
 =?us-ascii?Q?iOO+pT9zP0GIOoKtjLyJMBRKmLpWiSCJMMbVp40P8AkulYeowcXULku/s3GG?=
 =?us-ascii?Q?gVKcEDNQ9AU2c44hp5u115q9KXNq9dcP1z+T2/8wW/5u6YFlfDNiCLIRVzjY?=
 =?us-ascii?Q?c4vh/8j7ZdEccDQc1eMA5KWqSeuMkL6akrUJSykvLlapHesjs6JS7g31PWSM?=
 =?us-ascii?Q?QTj1MjHiAjX0V2vn31jH6nywJmlFCHxUVJYeOCeYp6Rtb81jP1BaL6XnLNIP?=
 =?us-ascii?Q?hQdBzsyrJH7RRGxQwydhRyH9QeysYZzD6+fiD+7z9nQJDaxosno8MidQbh7m?=
 =?us-ascii?Q?pnDuWhNsy/CaFrB4n0WYPhGOSncqhf+7dANQfjLsBJkpY7knHBD5Kqlrawf+?=
 =?us-ascii?Q?8p2RRWl2dXQt?=
X-Forefront-Antispam-Report:
	CIP:2a01:4f8:a0:900b::219;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZRZP278CU001.outbound.protection.outlook.com;PTR:mail-switzerlandnorthazlp17011031.outbound.protection.outlook.com;CAT:NONE;SFS:(13230040)(376014)(36860700013)(10070799003)(82310400026)(1800799024)(35042699022);DIR:OUT;SFP:1102;
X-OriginatorOrg: duagon.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 13:42:12.5269
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e1fd025c-4def-4f2a-c12c-08de4ebbba62
X-MS-Exchange-CrossTenant-Id: e5e7e96e-8a28-45d6-9093-a40dd5b51a57
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5e7e96e-8a28-45d6-9093-a40dd5b51a57;Ip=[2a01:4f8:a0:900b::219];Helo=[hz-deliver01.de.seppmail.cloud]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS1EPF00000040.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR1PPF183F358EB

Since commit 1f4ea4838b13 ("mcb: Add missing modpost build support")
the MODULE_ALIAS() is redundant as the module alias is now
automatically generated from the MODULE_DEVICE_TABLE().

Remove the explicit alias.

No functional change intended.

Reviewed-by: Jorge Sanjuan Garcia <dev-jorge.sanjuangarcia@duagon.com>
Signed-off-by: Jose Javier Rodriguez Barbarin <dev-josejavier.rodriguez@dua=
gon.com>
---
 drivers/tty/serial/8250/8250_men_mcb.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_men_mcb.c b/drivers/tty/serial/82=
50/8250_men_mcb.c
index a78ef35c8187..9774a95f2980 100644
--- a/drivers/tty/serial/8250/8250_men_mcb.c
+++ b/drivers/tty/serial/8250/8250_men_mcb.c
@@ -268,7 +268,4 @@ module_mcb_driver(mcb_driver);
 MODULE_LICENSE("GPL v2");
 MODULE_DESCRIPTION("MEN 8250 UART driver");
 MODULE_AUTHOR("Michael Moese <michael.moese@men.de");
-MODULE_ALIAS("mcb:16z125");
-MODULE_ALIAS("mcb:16z025");
-MODULE_ALIAS("mcb:16z057");
 MODULE_IMPORT_NS("MCB");
--=20
2.52.0

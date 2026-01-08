Received: from ZRAP278CU002.outbound.protection.outlook.com (mail-switzerlandnorthazon11020080.outbound.protection.outlook.com [52.101.186.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B917C396B99;
	Thu,  8 Jan 2026 13:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.186.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767879736; cv=fail; b=K5rkX5PSk97oHmKCj8tpqARG4ZW9q3LcyYAIdNbRlM1jtZt7fj5QDUhm4ceecUyECQVn0ihLBNeuTOr09KWZdfEQ8EVhdHC3uNCWj7ZTAhEccdjikyLuizeIAiQUvdgM+sL5s0GGEQcu4ryKryWIDegIlxcHi7QrIHVEWOXsq1U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767879736; c=relaxed/simple;
	bh=qkHomf/6qsmkeI9qvaRkO+suntqxYXl5K3+9IpKAXoQ=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=RhrpSGYfrAVHiBJvgL6FfdLNYLr5Ni9tRXE/IiG5fXNcIjlFY4/vYn2kkdxs/xVgBJmMxDzHdTs0gM/rhlBc/btUjRPGNlkD1vAe2AqrH/9THVDchX3/RCjhetq/iGqq9CCmnkCanaWH4UkKRBoClRZ1/MHoCXOSGTrv53lHeqc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=duagon.com; spf=pass smtp.mailfrom=duagon.com; dkim=pass (1024-bit key) header.d=duagon.com header.i=@duagon.com header.b=vPZoqUOz; arc=fail smtp.client-ip=52.101.186.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=duagon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=duagon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=duagon.com header.i=@duagon.com header.b="vPZoqUOz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DrcDp5y9RlTs7XlF2hLl3umJKgyhXiPRy7grxc87AWG960YrNRE7TyGomZqQjv/TTva7I9OHqOSvKbPbjBJL2dsKJO40ucC1Fvcl2ahzik8s4QduFRvCMZWtbEWZ/C15M5IpWnhVWbocaLdQmgD8UYZTS/6Qcr5qbVk3Gy8ukIUV/ETjh7tOZzXGZIpLOaZdyq/hhFs7cbnl2bqjkz2UCdJSRvT7RorPVHgsVnhibKMcH1SQa2tlchXwpZ3dZMewiiMUaSSLtlodHmqsujthXG73PnW8UtZIittqXcDwtOGs2rFz4BNPT6kuXTPfQxXxpP6Ui+l28v7Tjqokojxg4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dUCh4ruNVnjoJouh4R9DlNe04w1KixXC8DlGAznJ7zA=;
 b=M7hk6E+ns4tbDTtgF+llM9BMt1KD3u3pWggR/KJ90o1+ZPwWoe/C96lZ1HfIdVcgMyuasx6ZxOWLt3sayk4C7NucdgAts1gGTj8Vl/Zd+zA8NHCMKSz0Poy3tBsdxpiKDOXHYvoi/sLTSEB/SpR/KcAxEyoqFXfE6fpdeLhFUF2p57MWpWVvBxH+mAo+RusD6BqpVAx0JljlMhthIi+zusfTY7C4Q+4BYS03gqRsmJaN5ouG3Htvq6aX6AKpNUsHks3EML3W2qVSNG+y9g8/T0q1YFcxLDE0ZtYEGlidKen2/3LhsvylA4fYi7u1Y/h9yPx10r7XezHzFTxwRGggrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 40.93.85.55) smtp.rcpttodomain=intel.com smtp.mailfrom=duagon.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=duagon.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=duagon.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dUCh4ruNVnjoJouh4R9DlNe04w1KixXC8DlGAznJ7zA=;
 b=vPZoqUOzA6Zz6zOnfCx6VjfzXtgkQjzuRZvHam7P8EWHaaNlk028+L0Szs8pKM9aMuymIX22Mk3+T+ProKoGreFCQSSREICG0NPm2rUJZsLHf22NPLjs0wg9XQjyLivyMkzcr+VHU5hhQzVn+6SRlZcLQlLERn/p89p6VuxlLX4=
Received: from AS4P250CA0012.EURP250.PROD.OUTLOOK.COM (2603:10a6:20b:5df::18)
 by GV0P278MB0033.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:1e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.3; Thu, 8 Jan
 2026 13:42:07 +0000
Received: from AMS1EPF00000042.eurprd04.prod.outlook.com
 (2603:10a6:20b:5df:cafe::35) by AS4P250CA0012.outlook.office365.com
 (2603:10a6:20b:5df::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.3 via Frontend Transport; Thu, 8
 Jan 2026 13:42:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 40.93.85.55)
 smtp.mailfrom=duagon.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=duagon.com;
Received-SPF: Pass (protection.outlook.com: domain of duagon.com designates
 40.93.85.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=40.93.85.55; helo=ZR1P278CU001.outbound.protection.outlook.com;
 pr=C
Received: from hz-deliver01.de.seppmail.cloud (2a01:4f8:a0:900b::219) by
 AMS1EPF00000042.mail.protection.outlook.com (2603:10a6:20f:fff4:0:2:0:7) with
 Microsoft SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Thu, 8 Jan 2026 13:42:06 +0000
Received: from hz-glue05.de.seppmail.cloud (unknown [10.11.0.47])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by hz-deliver01.de.seppmail.cloud (Postfix) with ESMTPS id 4dn5g23Kwtz4www;
	Thu,  8 Jan 2026 14:42:06 +0100 (CET)
Received: from hz-glue05.de.seppmail.cloud (unknown [172.18.0.4])
	by hz-glue05.de.seppmail.cloud (Postfix) with SMTP id 4dn5g232ngz1yNh;
	Thu,  8 Jan 2026 14:42:06 +0100 (CET)
X-SEPP-Suspect: cd0afd6055184e64b3e41b59f5d212e4
Received: from hz-scan03.de.seppmail.cloud (unknown [10.11.0.33])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by hz-glue01.de.seppmail.cloud (Postfix) with ESMTPS id 4dn5g22Y84z1vfL;
	Thu,  8 Jan 2026 14:42:06 +0100 (CET)
Received: from hz-scan03 (localhost [127.0.0.1])
	by hz-scan03.de.seppmail.cloud (Postfix) with SMTP id 4dn5g21XTqz2XGW;
	Thu, 08 Jan 2026 14:42:06 +0100 (CET)
Received: from hz-m365gate01.de.seppmail.cloud (unknown [10.11.0.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by hz-scan03.de.seppmail.cloud (Postfix) with ESMTPS;
	Thu, 08 Jan 2026 14:42:04 +0100 (CET)
Received: from ZR1P278CU001.outbound.protection.outlook.com (mail-switzerlandnorthazlp17012055.outbound.protection.outlook.com [40.93.85.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (not verified))
	by hz-m365gate01.de.seppmail.cloud (Postfix) with ESMTPS id 4dn5fz1BYDz2x0h;
	Thu,  8 Jan 2026 14:42:02 +0100 (CET)
Received: from DUZPR01CA0006.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:3c3::13) by ZR0P278MB1535.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:a2::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.4; Thu, 8 Jan
 2026 13:42:00 +0000
Received: from DB1PEPF000509FC.eurprd03.prod.outlook.com
 (2603:10a6:10:3c3:cafe::d4) by DUZPR01CA0006.outlook.office365.com
 (2603:10a6:10:3c3::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.3 via Frontend Transport; Thu, 8
 Jan 2026 13:42:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.79.222.204)
 smtp.mailfrom=duagon.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=duagon.com;
Received-SPF: Pass (protection.outlook.com: domain of duagon.com designates
 20.79.222.204 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.79.222.204; helo=de2-emailsignatures-cloud.codetwo.com; pr=C
Received: from de2-emailsignatures-cloud.codetwo.com (20.79.222.204) by
 DB1PEPF000509FC.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Thu, 8 Jan 2026 13:42:00 +0000
Received: from ZR1P278CU001.outbound.protection.outlook.com (40.93.85.53) by de2-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Thu, 08 Jan 2026 13:41:59 +0000
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=duagon.com;
Received: from ZR0P278MB0523.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:34::6) by
 ZR4P278MB1901.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:b6::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9499.3; Thu, 8 Jan 2026 13:41:56 +0000
Received: from ZR0P278MB0523.CHEP278.PROD.OUTLOOK.COM
 ([fe80::39da:49d1:7c23:953e]) by ZR0P278MB0523.CHEP278.PROD.OUTLOOK.COM
 ([fe80::39da:49d1:7c23:953e%7]) with mapi id 15.20.9499.003; Thu, 8 Jan 2026
 13:41:55 +0000
From: Jose Javier Rodriguez Barbarin <dev-josejavier.rodriguez@duagon.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org
CC: andriy.shevchenko@intel.com,
	dev-jorge.sanjuangarcia@duagon.com,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jose Javier Rodriguez Barbarin <dev-josejavier.rodriguez@duagon.com>
Subject: [PATCH v2 0/2] serial: Remove MODULE_ALIAS from mcb client drivers
Date: Thu, 8 Jan 2026 14:41:08 +0100
Message-ID: <20260108134110.25278-1-dev-josejavier.rodriguez@duagon.com>
X-Mailer: git-send-email 2.52.0
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
	ZR0P278MB0523:EE_|ZR4P278MB1901:EE_|DB1PEPF000509FC:EE_|ZR0P278MB1535:EE_|AMS1EPF00000042:EE_|GV0P278MB0033:EE_
X-MS-Office365-Filtering-Correlation-Id: e307836e-26ef-435b-0208-08de4ebbb6f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?wJEVRcdvEiAg9aza9p5kWA0BJviK8pmNdHc/obOKuEAJ/8YVjp/8vDwsGQ7G?=
 =?us-ascii?Q?ueArvW2qEbe6+O4MeK68sr+f11uwgkB0I4I6D8lnWcmCE/o3ul0INYRr64GI?=
 =?us-ascii?Q?Bf2efE52DichTQFXvZg5ZLGvhu86YWm1liHTOEqlkDU1WzHzAyXqBRENDz1r?=
 =?us-ascii?Q?eI0YVf8UoRHRNTd3I58e/wK6pu/2vHh5d9a8Ud+6+Pc5O60gZe1eR7orLIhk?=
 =?us-ascii?Q?TFklco5pwxLcDSindQ3zcX9BvKTpPVnd8r/0D4au0fe6OO0QIDwleHnie0Ne?=
 =?us-ascii?Q?xZ0OXmU+TjQOaTkLJjeKoyC667O+YN9Ch+zHkCXZKpU8QQ4xpX485MLB5mhv?=
 =?us-ascii?Q?8blqOnZYP31yWTmoqPSv+R9R7nWGXiEgICK3Kq/dHwNksUBtZ0RN0I2QQQ6q?=
 =?us-ascii?Q?VVqr3K61wXq1T/MsAnUf3XxqBrXz/mOwUz5uE9OEzddOYxmwsMcwc26HuNbc?=
 =?us-ascii?Q?HlP34aDs/rc1lagBP8KS6lD9/MJRVjsWPGUzx1N2cHMKWAf0TjnlNPugsjSs?=
 =?us-ascii?Q?Nzezlug3wpgMZObseoJdVWcblyVVjFbaY9df0yJ8sQK9uCEjsRzkxPc26EQK?=
 =?us-ascii?Q?Loyy1gf+X1ApI9wVhKYUOkaDOSHZn9yE2u5Vq7Iev9nYVTwNnTQmRtVf1DU5?=
 =?us-ascii?Q?SXRC/8oc7hc4ERK6kTlQXoAZnWPpr+/w27osZkBoXVpay9EeYB56trGwfcDf?=
 =?us-ascii?Q?Waqb3O3wYDQJFrhNMtddEy580qj8ybNxr5+jpna9L4yUmn9S1/DajrYa/ks9?=
 =?us-ascii?Q?C61BsMdHIOta42lYxHtm+I9fYA2shxoSpj6zsOhUHV8nw3CD6zA5kiEdlsW8?=
 =?us-ascii?Q?yXkTlXaYV0y/ALxuKMw4oVzoJpHCiVEHtf1tJAh/ktrBoVo0bIWfu0YL7zOx?=
 =?us-ascii?Q?fSemfAbJ6cyqFuweTLBzijyF7DsP2J/c3XGwOd73Fs8IFnHhsxfJuR/yrR5b?=
 =?us-ascii?Q?g2yOkeDZUhb4qSdnTIbUlHMlvD8JIacKgT6vfucN9TB9oTZf/5Unn32M/Q7s?=
 =?us-ascii?Q?/pheZf1/tnN6ujmXehiGS+kOoT/PE0R/yA+qbxpze9q26IbjGCU42WuGF7yg?=
 =?us-ascii?Q?6GBBhBbq3O0nIChWK27Ks9RqL2hZbCH+NzXzTqhDZah3VOzs8UYSv11PxmOj?=
 =?us-ascii?Q?b5cWIV5QxHZu3JFzB9VfOr+Tdxm0ngyp62FQNRt2i3IaIaj1DYNUs/pDnj0K?=
 =?us-ascii?Q?ssv5dBZC0qhinB2mJyU/uIWE2QD+OiBMyVggBL9lcXzM6JqNFjhNQj6S+R5B?=
 =?us-ascii?Q?HuLb7stlfRXmOblIO6jBIa0uELWpUsTqzW5/Koq1Ro1q8fxQzxHPjmMdTDaw?=
 =?us-ascii?Q?DztUorRtMs+Yjl4g7nykUlGV3GN2IZNYaB0IpXDvb2P/3hgjOFZoK1mV36y0?=
 =?us-ascii?Q?w/UyCxpD4mgkdO34GVOgQBgdJXu1xIpUSdinhRNsG4fGHannUxyBn12QDeTf?=
 =?us-ascii?Q?f26ImdOHb+j0ZySFrpg/yyARv0O/MN6RcSCwbBQsSR+1hTXEnZ0+7lY/l15h?=
 =?us-ascii?Q?5ABS7hg0KjKHO5V253G9PEJlpaGHxiRCPJxR?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZR0P278MB0523.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR4P278MB1901
X-CodeTwo-MessageID: 109630ac-43e9-4785-a341-a1008f5285b0.20260108134159@de2-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 1
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB1PEPF000509FC.eurprd03.prod.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs:
 9d0baf55-cf5b-4a18-89a8-08de4ebbb04f
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|1800799024|82310400026|14060799003|35042699022|36860700013|376014;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?BMjZdPTiR6Ix5cpsa2/wVGoaysFh99GvNYB/VoDY+47OUXLHSXzjpW0ULVq4?=
 =?us-ascii?Q?L6cpodsoD3V7r0Xyd92xzdwRT2vZ5sFaYDz8vg5Ix2rqNOwFVggA9lwdrQrL?=
 =?us-ascii?Q?u0fakXdpUZNbfZ0gBHY9FJEdkzFuW2iLo3fLmst6ys5FCIqaTLQ7zsVtDtR1?=
 =?us-ascii?Q?xmrBHqjCJksDEam4qIkf5K0nwxRCmplnXR41jgi7uRxRDmPAJk15Z+y2Q0Ck?=
 =?us-ascii?Q?2H8y1JMiajZpvkJEPfV89NdpuqAEAEoxjPj5/896ZKfsE7yZlQeAMqpVpQ3f?=
 =?us-ascii?Q?CjGfk1Dj0Bt2KMvMzQXhPUQeZcEefTA6kHZlRYXu43eFEz+s6hGNW7fsf99f?=
 =?us-ascii?Q?/GkGkH9qPZhxgtuGgdLdjvwmSLQfKT9jZJKP9vqyB9IdaNfnu1HrGw+VaFNP?=
 =?us-ascii?Q?A8iRjCmCV0ORPA15WCDnrVN+wMWAIowvVF04bs6xr/AkUnWyMmRZcujHHx0M?=
 =?us-ascii?Q?NGfzatmei+Y5HNKbS0l2TVD+GYRY9H1isfb8/y/aM+WvvQuxALedeXVOVsHI?=
 =?us-ascii?Q?4Gp24U1mSwEqUrx33ejZWu7WtRTUqwxECV33dcHaUeONxoHErkunauzaOWyV?=
 =?us-ascii?Q?ocR1cpRfYNXJVZ3E/PqCulGrFwMjkgAArD0F1BVTH9zXraYChIswon7PtYXv?=
 =?us-ascii?Q?5If9TCxZzTtJHrIfB5y5AMtPDuRSjy9BsaTNNPMoX6NGOgoMai1okCVOYwmX?=
 =?us-ascii?Q?009jCV1FibOXc/12ECiEWe4fYXazwFZHedrtb0BPuHR4XHGLgSx/lwL9Ao6i?=
 =?us-ascii?Q?NL2RwY6t6+WbAJG5bFQDVXxyHxnUKlGoq8DkRzN05Z9VL/Ek8F0IiVbuQxdu?=
 =?us-ascii?Q?L0FXCMice5htY0tylyU4pFrTUJMOQ9X3uhGp9LIUoRMqIFv0HmY+P06ajs9V?=
 =?us-ascii?Q?zapzLVTjomDwqyBbi6lzaaAE5EG6NNEn4DDQdiiATcfvt1hsY2NBwceOkCz+?=
 =?us-ascii?Q?SZXG5VFA32Z65XhO7Q6frn+ljptObeJc5J/2A4uisRlfbqtSXwlysFXCLhM/?=
 =?us-ascii?Q?/JVM9DzqNjrhW4RftCy0vK3fWlLlEMmjRt1Qx+tUef2vNtP3HK7dUoGV4252?=
 =?us-ascii?Q?qyQUbkusafdUdu6GqD0nTeqDR0AVJvRdG8BGX9bZ2ucFct4ILAqZ8eid4OwI?=
 =?us-ascii?Q?S8vyywR+W3ntKFFLfWGrtYnMp+TJsfZoLOQ8qVww8RRUxcvBd/j6G3eFV8On?=
 =?us-ascii?Q?n4Ch3mQpuUgCAWhveNREpq4ek7M5O0Klqh3oO+c3GN/jCVKO3T0sXtVsYf/i?=
 =?us-ascii?Q?SQf6/Mpluo1tkk1hSdB6x9lzN1BShqBYDMlxyuqsAACRYDNBK793wsfwwM36?=
 =?us-ascii?Q?RlF0/8/CwUqrVGHVRDikD3oIZxsRP6tsnYK3cljHkB2HskzPhHWNfwVCm24f?=
 =?us-ascii?Q?s2nHnAz2SQPvTdUhIC1caRuMdIaOC/79+V4MSFZ/IeaRQPyEyWd6EZe3S+Li?=
 =?us-ascii?Q?cXg2QJOSMdA0IaQRNFbwJR+OMBqpaXsmKuwrUhJGd6ig96FZY5gqT7t4x2oY?=
 =?us-ascii?Q?ZggtFVPWsN+fX5zlEAbScXtMgrZ/n59XyWXwPVD7z39PZiCdDTobugDy2+w3?=
 =?us-ascii?Q?MlB0n9+hqby0NJTM43c=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:20.79.222.204;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:de2-emailsignatures-cloud.codetwo.com;PTR:de2-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(14060799003)(35042699022)(36860700013)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR0P278MB1535
X-SEPP-CCCVersion: 2025-12-11T08:12:51+01:00 9ed91da2
X-MS-Exchange-SkipListedInternetSender:
 ip=[40.93.85.55];domain=ZR1P278CU001.outbound.protection.outlook.com
X-MS-Exchange-ExternalOriginalInternetSender:
 ip=[40.93.85.55];domain=ZR1P278CU001.outbound.protection.outlook.com
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS1EPF00000042.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	be853e98-5ea9-476c-fac0-08de4ebbb300
X-SM-ruleversion: 2.1.0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|35042699022|82310400026|10070799003|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/EAlzt4k0+g6VVpgyWZo31TMF+ZaB7kZyW7OdWEOFFw4+tSDm9+tEN0WpOlx?=
 =?us-ascii?Q?jiVIdOsNd99SeRTS6+PnRkfyUafDEWhmGuVC9czKKJwdNvyj3tCmgKQ2FTDe?=
 =?us-ascii?Q?DtVaW8bl5BBYUdrgvpsT67wzPGNQS3PLJr4A2Ig0pkl9jv8yFem5XYtmiow8?=
 =?us-ascii?Q?eaYRUCSiK2T8aem0YK9GxwASVxxLVKlL1P/LR/JOyzyTQXwtmvIwqDygvL+F?=
 =?us-ascii?Q?Wuu0fDStX8c4ssDtVTyTOlTOdF8HlUXBgfyXWdOM8e6eIQVRzjtjXtya2Djc?=
 =?us-ascii?Q?uWrQFdVzml/0yDDrl544zLqye438LnYCthVW2FirooBtT65P1x6LtaaYYbXV?=
 =?us-ascii?Q?XaBopzKIDl8Z17vPeQj0cAClsDsEQZsAzSOT9j+DAbK8kQEQH0jmmCoQ5rl8?=
 =?us-ascii?Q?KLiM2HaCv8vTTj1oBRn/dsS5HhzsqoonAADe2Lg0B4fD+c82kA9dnaVRNnWU?=
 =?us-ascii?Q?Gns5bR0nXCVWIHvxhf5t5zkvd5WBLoHclhVfLowVlefAYLB1HUv9v6p77iKJ?=
 =?us-ascii?Q?VzogacCOosjOPwrXRFu2wg+3WKK/4rnLCy/Aj6qXGL8WXhk5+g+fGJrUoNIH?=
 =?us-ascii?Q?5OITENY29tW2Im7tjrHpgXXhm+NBA352ZvuS9TpSgZ75T1Gk3TCmNMZGAWMd?=
 =?us-ascii?Q?UYDYRM4hoZFe/mKhXBiZQLgqHznlAI3jVReDcGR78Cq08VZVRzpCCn3HE5eR?=
 =?us-ascii?Q?wOzUuY0eVZsEzWKRjpHGp3nOd+TywYq4eI6BdOlz+sXQhy8FI0/41T6kHx22?=
 =?us-ascii?Q?T1wX+9gLMha+6/klRkAbTAyUto+9MkJfhDVaJB0fBFxDVEQvCiUYWlZM3lzt?=
 =?us-ascii?Q?R8QeVKXCgBr9RoFVfT5eMDAfMFN1jcwrgP8srE/3hzveKCLfykkN7ZTD1q53?=
 =?us-ascii?Q?vtkr2RWAWeHurwtZW5f9GDPfPr6crojxE8FDjCKxp74NAUZSzjkVZ+aN9mK2?=
 =?us-ascii?Q?yOmXinnpWX0zUmyiPnOi5ZJ8VAzHAruY7asGmA7dUuDSHkTXsAAWfS3H2buh?=
 =?us-ascii?Q?erk8AFDvZx/aECZlIk+dAcD6gqGXtXuyZGzPlPlCGelYC8yvRnH4AyZiXf5X?=
 =?us-ascii?Q?vvz/crhcg8HEnY1pplOcCvmH0Xfjd6/5C2lLcsiQc8Zeec294LqyXCTDz29f?=
 =?us-ascii?Q?K7Hy7s1qb673?=
X-Forefront-Antispam-Report:
	CIP:2a01:4f8:a0:900b::219;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZR1P278CU001.outbound.protection.outlook.com;PTR:mail-switzerlandnorthazlp17012055.outbound.protection.outlook.com;CAT:NONE;SFS:(13230040)(376014)(35042699022)(82310400026)(10070799003)(36860700013)(1800799024);DIR:OUT;SFP:1102;
X-OriginatorOrg: duagon.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 13:42:06.7621
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e307836e-26ef-435b-0208-08de4ebbb6f3
X-MS-Exchange-CrossTenant-Id: e5e7e96e-8a28-45d6-9093-a40dd5b51a57
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5e7e96e-8a28-45d6-9093-a40dd5b51a57;Ip=[2a01:4f8:a0:900b::219];Helo=[hz-deliver01.de.seppmail.cloud]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS1EPF00000042.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV0P278MB0033

The first patches I sent for fixing the autoload problem encountered
on mcb device drivers were 2. The first [1] was focused on updating the
modpost process for letting kbuild to access to the data within
MODULE_DEVICE_TABLE and the second one [2] for removing the MODULE_ALIAS
on all mcb client drivers.

They were rejected and Andy suggested me to split the second patch
in a per-driver basis instead of sending all drivers' changes in a
single patch once the first patch was merged.

The first patch is already merged on Linus's Git repository for 6.19-rc4

commit 1f4ea4838b13 ("mcb: Add missing modpost build support")

So now I am sending this patch series for removing MODULE_ALIAS
on all mcb client drivers as it is no longer required. This cleanup
is being sent to each affected subsystem separately, as per the review
suggestion to ease the handling for maintainers.

[1] https://lore.kernel.org/all/20251127155452.42660-2-dev-josejavier.rodri=
guez@duagon.com/
[2] https://lore.kernel.org/all/20251127155452.42660-3-dev-josejavier.rodri=
guez@duagon.com/

changes in v2:
- Renane commit messages

Jose Javier Rodriguez Barbarin (2):
  serial: men_z135_uart: drop unneeded MODULE_ALIAS
  8250_men_mcb: drop unneeded MODULE_ALIAS

 drivers/tty/serial/8250/8250_men_mcb.c | 3 ---
 drivers/tty/serial/men_z135_uart.c     | 1 -
 2 files changed, 4 deletions(-)

--=20
2.52.0

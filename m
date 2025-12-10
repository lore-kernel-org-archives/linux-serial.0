Received: from ZR1P278CU001.outbound.protection.outlook.com (mail-switzerlandnorthazon11022111.outbound.protection.outlook.com [40.107.168.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEA7D311964;
	Wed, 10 Dec 2025 16:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.168.111
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765385326; cv=fail; b=LcKxzezkgfor4LWYyoEj271N91m4phftvrZEnr8BN2BXA+gzKCLMbzwYyr2vU2JzXSbUjeE47J+7bYXOLQECP/w/IflgU6TmBv8ASOy4gIZgFZKTEh5F/ZukxUHmOZIt2l7dk6C5DbwSTbPEGwb+GzyFf4eLcbREMqh3lm9ocCM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765385326; c=relaxed/simple;
	bh=emtkTQVXN20R7h9n97QZXKhg1kF6TTVYzORXWHMqEHQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Z6LUxyQtDNF20Pb36MBEMD9ddKT9zbWBxgbVflr+HWdV+Syb9R/eyJKIhZ6V6bFI2z/hQ21cmV5tsd+00bRbK5B3sccuEhjR8gDYZMKPK8VZVw/hTZpy7CluQVawmloDy0S5b/CPNWP+SJjwxPrwNKKVHgerD7v8BRjZqksypq8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=duagon.com; spf=pass smtp.mailfrom=duagon.com; dkim=pass (1024-bit key) header.d=duagon.com header.i=@duagon.com header.b=sn1xUD9F; arc=fail smtp.client-ip=40.107.168.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=duagon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=duagon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=duagon.com header.i=@duagon.com header.b="sn1xUD9F"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QMRjnCB3QI/NOQPuT71yVkKrLn1hnBALVN6U0F7ajiljBMsLb79mzQN15+8qvFHu1yAkPn85TphDXClqmhOenCYtV4m9igjORgNx53ysNHE4HsCOQh2rcVran83l7oskSwZXx7WE1c61fZRhCA0dztOwKLbJ3q3hGiJK+A4r3mB6+hGXqp3IeTooh7FUVGv7LcZeymbQfc7W7bQUhvEC/46zVr335VxM7YcCA39KS7w43hY1zDwH+hvxF2oAU8zVjJcfzFeYt05IoCRb5mYh/DihPygbohDMii/hfpfxyRfA2dofukaOfs5o5FkYpRYWLxixTpDWLQy37n8djj5zSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OQJFWRN6qQTBFoihsoqr9FMAAPUktd/UakbaofLM+eA=;
 b=tfJjEsr6tSuinMM5KAa8ZB2668csBm5aI8YZ70to8I9dHvLI9L/JlvYg4AOmn/IXXZzXUuyn/o3N4KTQdXwTyp1tscQWqUHglARr4mgTNaGB2xAfVFHsQKKaN01WRdc89Zls+3J5VIuS8VCMjB+9N5JVOQQaXOLfsND/7v8PZ/anA0Kybrih+VSwb2DONYCWA1XkIu0lBXqMyHnGeaN/7jYTacHmxYkcyVokw8W3n5PUdMm2nikq1rxRp1cYmv01tI+QOuKucmWo1TtTvMYFU2ch3itGYdB+22Pd7BOGJMv5s6i0/WXw+C1QxlZZlKyNYSV0bugvidAdGyjvnq4DRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 40.93.85.4) smtp.rcpttodomain=kernel.org smtp.mailfrom=duagon.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=duagon.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=duagon.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OQJFWRN6qQTBFoihsoqr9FMAAPUktd/UakbaofLM+eA=;
 b=sn1xUD9FGwEoAX9SrNinb6QXSpoJBp1tnAB8fxbSOC0kbb7Y26i7o5kX14aJCOmmkz8WBipIooOHHE/sIJ3sImwCeJ6mm/8lSAX5hVQMsHNNMKMVBrGkUt0xrzY1QKLOxtC/GkWbJE5B42A1b5IU8sbKXM2Oc1SR51f0ybyCFys=
Received: from CWLP123CA0080.GBRP123.PROD.OUTLOOK.COM (2603:10a6:401:5b::20)
 by ZR0P278MB1267.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:83::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.14; Wed, 10 Dec
 2025 16:48:38 +0000
Received: from AM3PEPF0000A798.eurprd04.prod.outlook.com
 (2603:10a6:401:5b:cafe::b0) by CWLP123CA0080.outlook.office365.com
 (2603:10a6:401:5b::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9412.6 via Frontend Transport; Wed,
 10 Dec 2025 16:48:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 40.93.85.4)
 smtp.mailfrom=duagon.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=duagon.com;
Received-SPF: Pass (protection.outlook.com: domain of duagon.com designates
 40.93.85.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=40.93.85.4; helo=ZRAP278CU002.outbound.protection.outlook.com; pr=C
Received: from hz-deliver02.de.seppmail.cloud (2a01:4f8:272:5fe6::218) by
 AM3PEPF0000A798.mail.protection.outlook.com (2603:10a6:20f:fff4:0:6:0:7) with
 Microsoft SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id
 15.20.9412.4 via Frontend Transport; Wed, 10 Dec 2025 16:48:37 +0000
Received: from hz-glue06.de.seppmail.cloud (unknown [10.11.0.48])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by hz-deliver02.de.seppmail.cloud (Postfix) with ESMTPS id 4dRM9d5dD7z1144;
	Wed, 10 Dec 2025 17:48:37 +0100 (CET)
Received: from hz-glue06.de.seppmail.cloud (unknown [172.18.0.4])
	by hz-glue06.de.seppmail.cloud (Postfix) with SMTP id 4dRM9d5R5Yz1y33;
	Wed, 10 Dec 2025 17:48:37 +0100 (CET)
X-SEPP-Suspect: 259ce07f504c4430821e1d6d36c1b952
Received: from hz-scan10.de.seppmail.cloud (unknown [10.11.0.51])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by hz-glue02.de.seppmail.cloud (Postfix) with ESMTPS id 4dRM9d4yBgz1vfL;
	Wed, 10 Dec 2025 17:48:37 +0100 (CET)
Received: from hz-scan10 (localhost [127.0.0.1])
	by hz-scan10.de.seppmail.cloud (Postfix) with SMTP id 4dRM9d4V0Gz4gdB;
	Wed, 10 Dec 2025 17:48:37 +0100 (CET)
Received: from hz-m365gate02.de.seppmail.cloud (unknown [10.11.0.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by hz-scan10.de.seppmail.cloud (Postfix) with ESMTPS;
	Wed, 10 Dec 2025 17:48:37 +0100 (CET)
Received: from ZRAP278CU002.outbound.protection.outlook.com (mail-switzerlandnorthazlp17010004.outbound.protection.outlook.com [40.93.85.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (not verified))
	by hz-m365gate02.de.seppmail.cloud (Postfix) with ESMTPS id 4dRM9c37Xfz2wJh;
	Wed, 10 Dec 2025 17:48:36 +0100 (CET)
Received: from DUZPR01CA0354.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b8::6) by GV0P278MB0163.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:710:2f::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.15; Wed, 10 Dec
 2025 16:48:33 +0000
Received: from DB5PEPF00014B88.eurprd02.prod.outlook.com
 (2603:10a6:10:4b8:cafe::5) by DUZPR01CA0354.outlook.office365.com
 (2603:10a6:10:4b8::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9412.7 via Frontend Transport; Wed,
 10 Dec 2025 16:48:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.79.220.33)
 smtp.mailfrom=duagon.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=duagon.com;
Received-SPF: Pass (protection.outlook.com: domain of duagon.com designates
 20.79.220.33 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.79.220.33; helo=de1-emailsignatures-cloud.codetwo.com; pr=C
Received: from de1-emailsignatures-cloud.codetwo.com (20.79.220.33) by
 DB5PEPF00014B88.mail.protection.outlook.com (10.167.8.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Wed, 10 Dec 2025 16:48:33 +0000
Received: from ZRZP278CU001.outbound.protection.outlook.com (40.93.85.28) by de1-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Wed, 10 Dec 2025 16:48:32 +0000
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=duagon.com;
Received: from ZR0P278MB1218.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:80::5) by
 ZR0P278MB1556.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:a3::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.15; Wed, 10 Dec 2025 16:48:31 +0000
Received: from ZR0P278MB1218.CHEP278.PROD.OUTLOOK.COM
 ([fe80::a0e2:7867:dcd3:b9c3]) by ZR0P278MB1218.CHEP278.PROD.OUTLOOK.COM
 ([fe80::a0e2:7867:dcd3:b9c3%5]) with mapi id 15.20.9388.013; Wed, 10 Dec 2025
 16:48:31 +0000
From: Filip Jensen <dev-Felipe.Jensen@duagon.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org
CC: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	Filip Jensen <dev-Felipe.Jensen@duagon.com>,
	Jose Javier Rodriguez Barbarin <dev-josejavier.rodriguez@duagon.com>
Subject: [PATCH 2/2] serial: 8250_men_mcb: Parameter for base clockrate
Date: Wed, 10 Dec 2025 17:48:04 +0100
Message-ID: <20251210164804.94801-3-dev-Felipe.Jensen@duagon.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251210164804.94801-1-dev-Felipe.Jensen@duagon.com>
References: <20251210164804.94801-1-dev-Felipe.Jensen@duagon.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: MA2P292CA0028.ESPP292.PROD.OUTLOOK.COM (2603:10a6:250::15)
 To ZR0P278MB1218.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:80::5)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	ZR0P278MB1218:EE_|ZR0P278MB1556:EE_|DB5PEPF00014B88:EE_|GV0P278MB0163:EE_|AM3PEPF0000A798:EE_|ZR0P278MB1267:EE_
X-MS-Office365-Filtering-Correlation-Id: a9449aab-d69c-4893-3946-08de380bf775
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|376014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?sB2izPVVSQWeypCS0U9hYlGA6Cc1a7iknmnaGMmg9Iw1gjJ+P7ED+aHyzc5B?=
 =?us-ascii?Q?3JZxKJvhJFKof0GmqrQznYRsgrDdFF+NdEdmIJovx9OtvAhfHXBnQdzjvq4Y?=
 =?us-ascii?Q?XnfAZEBeUJ87v7q6y0ufCPV//nCA5KU3JE6RB/Fmuz+OTHr3F/dYicW2r4eS?=
 =?us-ascii?Q?ybOpWgnGD9eZEHM4cLbA5Nv/wPBGc88IlJR3lTtgeV7pb7llAaAIwgwucZH4?=
 =?us-ascii?Q?NG3OmwySlPcHolfg32flaOMSojWVSEoRyNBd9MnJXvvzcWzzlODP2Cu+A3nx?=
 =?us-ascii?Q?37M1R8NRwe6/SwnuMG1ees9qqcZGX+MfAhOn48lL2iEFiOJM1QRk/AivfW6F?=
 =?us-ascii?Q?MyUqhhw27ckuiKThfZzcrV7EV3+x3f68mAhIOetLZe7hxpTsOzn2ebcFBKTc?=
 =?us-ascii?Q?f4MCjw3NqfaCzauVL6YWcQRR0NSCNiduhEBX9ZF9SPsjUYBFDQFBASZ/ALaX?=
 =?us-ascii?Q?kFGNPFKyKFtzKRhOIkk7x81fJ2c2q07+oXPxgFWdQwnSVagWjuqg/Yd+yRuE?=
 =?us-ascii?Q?UvwZHzLdtnqohw8rtaqnxZ+Tjrrlwv9h4j+UUPSsrzJiu0NzG8AWHi1Ogyul?=
 =?us-ascii?Q?Vz7i0OU5FF3gOZZPBZMRMg6GRbKHBFFO/3mEJVQn+RVpP2cFa0hqoPPjaB9d?=
 =?us-ascii?Q?fERvI5aXpxBmUB68H54wAw7OMXLG/p7WHMNdFaFPXUe4rnHnN1c+B3SUxQgS?=
 =?us-ascii?Q?XniVxUr/aa/JedD1EruojSAbAbHvHYqQU6Dfb8S3mHcFHA2cBGoHi4nMADT6?=
 =?us-ascii?Q?kj7kSCuv7uM7k1Clq+vfxhDyhWlhGwjntSZ6Pvr+5XeGy9DnvFG2IUQOOXsX?=
 =?us-ascii?Q?qmvfdIWge9qj1KOZdtWwt1Phnc92xYz81XZgiFiom4hkK2Ri+1CLU7m1TARI?=
 =?us-ascii?Q?PKpB6wzoggNkzbhHRH6HFUSQykQdQ6KuPcu2bdrP52PqaWYirigh3C186LCA?=
 =?us-ascii?Q?W7/GcPrAM0tMUFAE1qddlPoMZsb9McVjk1Y4gy2PQZqauqPQHxmdm2BBIBGK?=
 =?us-ascii?Q?lHEPuwrqfluyN8GCF6wBJziBR2QD9KiDCKa5sm5WchO1fMAyNpFDgjyovLYh?=
 =?us-ascii?Q?gRgzzVlgZu5lzodIrmGU1FDievmDNMAepYBeSKvGtf4IVW3wcgR5dIy2Kohn?=
 =?us-ascii?Q?G7EJDmpJEdFnsrc3bvO+H2zz59uLx7uNXG4c7g6AbvIkOxrTMWQaKqARQR2s?=
 =?us-ascii?Q?4xbPs+nv5Avc9YWdbXG6JRYmYTBOhTgxcqOKbvnpfjDuoED7gIuQj/z3SwPg?=
 =?us-ascii?Q?FEFmnZ/jHzgEsohWa5L1GBGQCc4ddD7o9VOBskEeELg6oZxM5jfsJjniz2xl?=
 =?us-ascii?Q?4ta7ymwsqDxvyyLbL1JhABVXBxz5qXiPcWLMUPycw2t7b576mB3XYVFKpFa6?=
 =?us-ascii?Q?lLkpqpBw7IlwswECn/GMJyqB7grezsSKp8u3AxeFc1K0bbqhuV9tsZucTiqd?=
 =?us-ascii?Q?JUm04ESZvbELB4dmjYC7bVu65Gtyc5b9EZ5R+w28wfqEJtHn6sJ27S1YPXm6?=
 =?us-ascii?Q?BHzJ0OnjMFDIMbzUAnh7js0LItKOAG/8Y4FJ?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZR0P278MB1218.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR0P278MB1556
X-CodeTwo-MessageID: 29f925dc-85a9-413a-b2b0-0865f245cfd3.20251210164832@de1-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 1
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB5PEPF00014B88.eurprd02.prod.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs:
 4f89c636-0ff9-498a-6f1c-08de380bf343
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|82310400026|14060799003|35042699022|36860700013|1800799024|376014;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?82/zuvFihDc2XFZxZ5XjeHoZ7s1UlqG2vxK007DpshfuDSMFNXW09ZUuWi/G?=
 =?us-ascii?Q?PZHiN8TMb9sbsMdgS04wtA9UZfonm7zw2AZ7zZ6cpk6hxiFmqyFfAoFvqbAc?=
 =?us-ascii?Q?ETjfd/qtVN4J5uTdUUKVlkhDVVw2gW6GeWCDEh4zSSOgspVywkWFtxqwlhgq?=
 =?us-ascii?Q?zbKvi7Xqe/o/kt9lxm/R/VXUMU5PK87AKcKPWlD0cbVRc9KPYutyxYn1cTL9?=
 =?us-ascii?Q?nw5R0y1PvT4SrWSrA8L2HOZ5mJMraeqeodOK7PYS4QZ++hcqA6HYWh8GZuuo?=
 =?us-ascii?Q?oVScAUby7AfCVFjtDZe0qRuwzFrqkp5z7uaSp/fQ/fZrBlBM/okVIoWUQP9X?=
 =?us-ascii?Q?/NT1Lu90peMNEyDNJcV2kNl6VjaCWHaVVKi3PA8N5Igu+tAGuXm/NSJ6bTOZ?=
 =?us-ascii?Q?fuj0RiITZrgLA8L4Y3jYw8PQRdyaKh6AkNulETgYVB1OaY0xUm2IOe9Cx/36?=
 =?us-ascii?Q?8ce4+uP82AyEdw2xOpOdenB/7IrbK6Qq+hspakva5oO6HemD0ba8OM4YvVAO?=
 =?us-ascii?Q?EvPGg+TltKMrs9o/j1wG3VNK8gsKe7nCCSeui35GPFfI/C7sKVBiA7oWe19w?=
 =?us-ascii?Q?IXvne5Mf01043IxfYW+pgqq8xO3lJMJvTHdTOhPeJZeEpQESJ1bUtKi17Hw/?=
 =?us-ascii?Q?r2DtzfeV/YWnUGVLmdN3GXpBOqjZ1fnAQX9ZN4WUjns4zMtfbgnV9LPT0Toi?=
 =?us-ascii?Q?EIA5CLF3Wq+exG75oUfIM8/CO7zwpnpwS0FyUFB+PSsY0VMfV789fSRa30dr?=
 =?us-ascii?Q?DNUrpDhDSxhFCpNCKK/+iVCKAdZjlsW2lItx3qQnLpGrhvxgFhHt68P15dbi?=
 =?us-ascii?Q?U1ZX8mASZkLsthGjL0F9qLvFisQf9fN/5NT5lXVnCDNM2WwX8wbZ0GZzToLf?=
 =?us-ascii?Q?lZdf2/YLDRkndXmZhrg+JkFIPqHrEa9/l2GeVCdBlRrefByDXeCUhb8s+w9v?=
 =?us-ascii?Q?+fLDyIbbSYvnXgV2e11aOq7dEaGf2wJ3n2qjAUkbilvipF7GBihLT/PdhQeD?=
 =?us-ascii?Q?B+hQeIqGMmSicNbTpsmdti9UpYfHSiCcFo2eBXbEfUrEiGru7XVWJ4oo/UTV?=
 =?us-ascii?Q?aniKQCe+yh2VzLGfL7KccGvAAik1IDPj5YA4WQGPFu/pWnxKoj/SUIOE7yAO?=
 =?us-ascii?Q?bscw8+f0q+EY/XQK2Ib4MDYMfIEknLIWVCeFAZRfCbXZ5FLP8TdrTz7zV5//?=
 =?us-ascii?Q?TSEUdGuk5r8J5aCzSt3eQHledVTciz5mYbzAbQ3TTgJeu8pj+HlCYQq7DSpG?=
 =?us-ascii?Q?oUOESgaCzAboPS86egXi5/EwGcXp30mR6v0vRTRUm4FlIMAYnvVysUa4A9N5?=
 =?us-ascii?Q?4GkZ7ZveSZ/WZZdwgoQ4OBJ6terP0ne6zx5CkMS+X/7Nu9eOZ4IpErzSA4ny?=
 =?us-ascii?Q?crP8PgOffUkFQPksK0cJz4nDMPG5+7kSrsdF5vQFICv9d5pZ+vKxMM8xLq4s?=
 =?us-ascii?Q?tbNXZrQDfbI/c1PLiw+HgbAPmXZ44GxSx4A3H7QwYl6iKE7Rj44+V6Qj/1Fm?=
 =?us-ascii?Q?rCb986xVrd6iRyuQH8wQs/ev8amKD00pceLHnDs3kojfjxYpENvZFCLjAn9T?=
 =?us-ascii?Q?ClTGlTisl3RKB2Y8r6g=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:20.79.220.33;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:de1-emailsignatures-cloud.codetwo.com;PTR:de1-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230040)(82310400026)(14060799003)(35042699022)(36860700013)(1800799024)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV0P278MB0163
X-SEPP-CCCVersion: 2025-11-05T14:36:24+01:00 6c313bee
X-MS-Exchange-SkipListedInternetSender:
 ip=[40.93.85.4];domain=ZRAP278CU002.outbound.protection.outlook.com
X-MS-Exchange-ExternalOriginalInternetSender:
 ip=[40.93.85.4];domain=ZRAP278CU002.outbound.protection.outlook.com
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM3PEPF0000A798.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	074b8388-1146-4d7a-0664-08de380bf493
X-SM-ruleversion: 2.1.0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|82310400026|35042699022|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ozriRHk0mL0sUHjdAPvTiyOSWK5SY7QT1iJk2C8+GPo9C8HVdLUsUPO0o8N+?=
 =?us-ascii?Q?u8Td9qt6cK6Pn8VZMhttZfhmX7vvcQQOLhDIoePYQl3nbEFZ7QmIUOQ2gT3P?=
 =?us-ascii?Q?+PI2GyYWZPKyNJp8XQubwRNrPZ8TgWVENAGGHoAHd3AhKX4Ju58RVomADCKE?=
 =?us-ascii?Q?C8AaE0fQm4aPMhGVk3bZTIGvBvn9uwZyNNwC56/m88ydcNsxWG+hI8n+V1hz?=
 =?us-ascii?Q?YYHZdrDN3bbWcSi6jzoVc24Z8bPJtB5Pt/G759w2XDeygfHgywPInTiJY9r2?=
 =?us-ascii?Q?9zcgzFd9MEa0+W6pyCncsucR+o2ljBGGg6NiFlqk1JehVAJWBT2T5ZhqJ7zG?=
 =?us-ascii?Q?KNjv/kG3UirViKmljJfIWGgSEQKqFE9bLA+BrtaqzFOC+NUBz57Ydpnn4P1N?=
 =?us-ascii?Q?mpYNvCReJ4csFIwwvjewCK6C34nw/jAixOW//GJyH2xlF0WPuU7McG7zJErC?=
 =?us-ascii?Q?6oimjiLUGCph/lnzRADY3vxZUisPhSa54RMHbM2mj012ig1nQZpaRegXOZKi?=
 =?us-ascii?Q?cdBFBR1MJ3fR84wxp+F3AZOB/iYpMqgVZl6aSIjLaP5LBbouha2zjVc6Y8RK?=
 =?us-ascii?Q?790uO2iH5s5+P+7qhESOMey+0fSFS1j7GT5dzFLzmLwV2jHjyL1QYX/YGwQ8?=
 =?us-ascii?Q?6tK+InO6WMS3YdpW359D1bLPK+79gaxlshZHmHkio3adC+oCJRcMfFa9Z3o4?=
 =?us-ascii?Q?8rFITxDu4NsQlT0AVIzI2ML102Hf4kIhFz0qM3t42HWg2tFgquCTRdyp4X33?=
 =?us-ascii?Q?24q2j+L69UxG1p4Ncpu4E4N/nD/BHolZuc8AoVz8/nHJwAk7Qwq1EY/2JxBF?=
 =?us-ascii?Q?l2fbvHqKZ0afEqBx5AL3kBOoV+lsvrsphKCA8hsT0lkFpLKKtH7fIY5/KyFQ?=
 =?us-ascii?Q?DTDHTlXj87ikO/5G9ASXShPEbZRjLZgtKChJuAvPL9Gps40xo29ADroUFVKp?=
 =?us-ascii?Q?ehcaEUJggD592y4LQXgAlUMWjIzmHNkIGKSf2fcjmTeAnJriNtNo8Azl7rom?=
 =?us-ascii?Q?9mdBURbRWTzMNGEdpTNoQwMh/up7h0KsSXpSOEIkbtBJW44we0D87rusRIrM?=
 =?us-ascii?Q?j0gM5ey1bMi3UhjMH7T1w8jt8angGVKKztyyvCQG+ZU3x5mXmdL7F+SQQros?=
 =?us-ascii?Q?wPVUejRh0SQp?=
X-Forefront-Antispam-Report:
	CIP:2a01:4f8:272:5fe6::218;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZRAP278CU002.outbound.protection.outlook.com;PTR:mail-switzerlandnorthazlp17010004.outbound.protection.outlook.com;CAT:NONE;SFS:(13230040)(10070799003)(82310400026)(35042699022)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1102;
X-OriginatorOrg: duagon.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2025 16:48:37.9843
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a9449aab-d69c-4893-3946-08de380bf775
X-MS-Exchange-CrossTenant-Id: e5e7e96e-8a28-45d6-9093-a40dd5b51a57
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5e7e96e-8a28-45d6-9093-a40dd5b51a57;Ip=[2a01:4f8:272:5fe6::218];Helo=[hz-deliver02.de.seppmail.cloud]
X-MS-Exchange-CrossTenant-AuthSource:
	AM3PEPF0000A798.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR0P278MB1267

A parameter is needed for allowing to change the base clockrate for
each uart port, as this fpga units have no fixed base clock. If the
parameter is not set or is set to 0, it will use the default value.
Allows setting the clockrate up to 64 UARTs.

Reviewed-by: Jose Javier Rodriguez Barbarin <dev-josejavier.rodriguez@duago=
n.com>
Signed-off-by: Filip Jensen <dev-Felipe.Jensen@duagon.com>
---
 drivers/tty/serial/8250/8250_men_mcb.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_men_mcb.c b/drivers/tty/serial/82=
50/8250_men_mcb.c
index 6ba7464bb2dd..01dcb9c17b0c 100644
--- a/drivers/tty/serial/8250/8250_men_mcb.c
+++ b/drivers/tty/serial/8250/8250_men_mcb.c
@@ -28,6 +28,7 @@
 #define MEN_UART3_MASK	0x04
 #define MEN_UART4_MASK	0x08
=20
+#define MEN_8250_MAX_SETUP		64
 #define MEN_Z025_MAX_UARTS		4
 #define MEN_UART_MEM_SIZE		0x10
 #define MEM_UART_REGISTER_SIZE		0x01
@@ -45,12 +46,18 @@ struct serial_8250_men_mcb_data {
 	int line[MEN_Z025_MAX_UARTS];
 	unsigned int offset[MEN_Z025_MAX_UARTS];
 };
+static int portindex;
+static ulong uartclk[MEN_8250_MAX_SETUP];
+module_param_array(uartclk, ulong, NULL, 0664);
+MODULE_PARM_DESC(
+	uartclk,
+	"Base for baudrate generation for each port. E.g.: uartclk=3D1843200,1843=
200,1041666,1041666. If set to 0 it will use board's default");
=20
 /*
  * The Z125 16550-compatible UART has no fixed base clock assigned
  * So, depending on the board we're on, we need to adjust the
- * parameter in order to really set the correct baudrate, and
- * do so if possible without user interaction
+ * parameter in order to really set the correct baudrate. Can be
+ * overridden with uartclk parameter.
  */
 static u32 men_lookup_uartclk(struct mcb_device *mdev)
 {
@@ -60,7 +67,9 @@ static u32 men_lookup_uartclk(struct mcb_device *mdev)
 	dev_info(&mdev->dev, "%s on board %s\n",
 		dev_name(&mdev->dev),
 		mdev->bus->name);
-	if  (strncmp(mdev->bus->name, "F075", 4) =3D=3D 0)
+	if (portindex < MEN_8250_MAX_SETUP && uartclk[portindex])
+		clkval =3D uartclk[portindex];
+	else if (strncmp(mdev->bus->name, "F075", 4) =3D=3D 0)
 		clkval =3D 1041666;
 	else if (strncmp(mdev->bus->name, "F216", 4) =3D=3D 0)
 		clkval =3D 1843200;
@@ -72,6 +81,7 @@ static u32 men_lookup_uartclk(struct mcb_device *mdev)
 		dev_info(&mdev->dev,
 			 "board not detected, using default uartclk\n");
=20
+	++portindex;
 	clkval =3D clkval  << 4;
=20
 	return clkval;
--=20
2.34.1

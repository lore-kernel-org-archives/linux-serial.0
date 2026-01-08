Received: from ZR1P278CU001.outbound.protection.outlook.com (mail-switzerlandnorthazon11022102.outbound.protection.outlook.com [40.107.168.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F9C9466B59;
	Thu,  8 Jan 2026 13:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.168.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767879742; cv=fail; b=t65WKxQqTrJ/twXPi+0joLiDJd5Oe+jPSSR/hNwMcGjpsoEobwCVP3+J8d0Eg9IXF9YtjxhxXNX+Tu4K+FIQZ2E305OK2ZZN3wyDbaEK6NC2y8o8DJDjjzbTWsORuSfYJdh1IROx7yfS6EfG4xYtakJCo8KNYvxqt/OELP2pWj0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767879742; c=relaxed/simple;
	bh=getwpVr9bGltds/AokYZ+elocxrBTg3iGV678UK9lnQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Zo1M3CTpZ6KoixF3ooOrr/vh48dUMUlxrEfEvVqDsvPK+5niFdWszqlATuxYRXE/ellfXaj9eiJiyLquokLikfY6VOgbFXDJVKFkzB4mQA/iV0flEN0Fnv33fq1XxFwkFiJX/kO5M0NZrjzXFELsuKVY035NlZZLpRZ2xD1z4tg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=duagon.com; spf=pass smtp.mailfrom=duagon.com; dkim=pass (1024-bit key) header.d=duagon.com header.i=@duagon.com header.b=HLXq98+X; arc=fail smtp.client-ip=40.107.168.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=duagon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=duagon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=duagon.com header.i=@duagon.com header.b="HLXq98+X"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oUSEFhtfBZ+uOcEs1/8kWJjPXyMKE2uG19VlZ2Yb9NCcL3SBV85VldOXC7XGY72X6MFnNAhK/s182NXnyNS9aiZAWLemCf6XHQOBXZq1I6l9853UsnIHlFuKC2y/nYmRv6wsEL74mCJ3xRH26QobZ0urXnq3D5iPEdnzjIn/WbQ8WhsMrlUGP0qEfHcNF/ZOheFgt5vy7FbG5XAGJhFmF/tTi9gkAyz+8OwfkD3drE09Th4d1o6TjeON1q8C6BYdwsN8dT/n/U2MQH6rxhnoRg3Yft9Vq/hXJG8m0n9gvZN6w0rb9KdvnJjszyc423cnKbc58OQgPZEsxeihunZ9sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=getwpVr9bGltds/AokYZ+elocxrBTg3iGV678UK9lnQ=;
 b=WN+0ZTnIfE5S2jyYRfWa7ZvNNGYANYz7fQtJ09+jTXiYIu8Lrp34W56aSrf/sVts7tW/xpmS8hAr53nW37U/bjKWYzxpKERlcfA5WJA5dPO3uGUY81Lo/dSBw6mJChfDmHX80UKbFBwKLPHTaUblyC/s8+lnF/Ctg7X8PC2AhvUZgRL3moI+qm9uHDO9NFcPrDXbFidI8SJUKmyZdWNLVFAMFZAiZW65tem1w0z0lHyMZ485Lvp34HdGp6QUIZKISk2v0t6Do4zkwSvpINnynw8qZ/7/hmxctleRAjSdkFrWmvqQauJacLvtr8HCKlxvQgx1WDBxqU491gV8OywG+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 40.93.85.2) smtp.rcpttodomain=intel.com smtp.mailfrom=duagon.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=duagon.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=duagon.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=getwpVr9bGltds/AokYZ+elocxrBTg3iGV678UK9lnQ=;
 b=HLXq98+XnfXe8u9kLypoMQFURDfSn6pI8r7FT8Ze56Ycu/Li4ZAXBQtbgVbudHx4MM6RVpaxHCY7NaMJRjxLLPz8ihGK+yt+8GhEl6zmwyh/8T67BsKL1ZRBrQmOyrhcT8WFazZ8FfxqIcWUpkRzulBqCz4K7hlyTLHtQrtzCTo=
Received: from DU6P191CA0044.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:53f::24)
 by ZR4P278MB1772.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:b2::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.3; Thu, 8 Jan
 2026 13:42:13 +0000
Received: from DU6PEPF0000A7E1.eurprd02.prod.outlook.com
 (2603:10a6:10:53f:cafe::5f) by DU6P191CA0044.outlook.office365.com
 (2603:10a6:10:53f::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.3 via Frontend Transport; Thu, 8
 Jan 2026 13:42:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 40.93.85.2)
 smtp.mailfrom=duagon.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=duagon.com;
Received-SPF: Pass (protection.outlook.com: domain of duagon.com designates
 40.93.85.2 as permitted sender) receiver=protection.outlook.com;
 client-ip=40.93.85.2; helo=ZRAP278CU002.outbound.protection.outlook.com; pr=C
Received: from hz-deliver02.de.seppmail.cloud (162.55.72.218) by
 DU6PEPF0000A7E1.mail.protection.outlook.com (10.167.8.40) with Microsoft SMTP
 Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.1 via
 Frontend Transport; Thu, 8 Jan 2026 13:42:12 +0000
Received: from hz-glue04.de.seppmail.cloud (unknown [10.11.0.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by hz-deliver02.de.seppmail.cloud (Postfix) with ESMTPS id 4dn5g767tdz11Cl;
	Thu,  8 Jan 2026 14:42:11 +0100 (CET)
Received: from hz-glue04.de.seppmail.cloud (unknown [172.18.0.6])
	by hz-glue04.de.seppmail.cloud (Postfix) with SMTP id 4dn5g75tM8z231P;
	Thu,  8 Jan 2026 14:42:11 +0100 (CET)
X-SEPP-Suspect: 255009d536a14eb1b783a9302848491a
Received: from hz-scan04.de.seppmail.cloud (unknown [10.11.0.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by hz-glue06.de.seppmail.cloud (Postfix) with ESMTPS id 4dn5g75HkTz1yNj;
	Thu,  8 Jan 2026 14:42:11 +0100 (CET)
Received: from hz-scan04 (localhost [127.0.0.1])
	by hz-scan04.de.seppmail.cloud (Postfix) with SMTP id 4dn5g74Yrrz6q73;
	Thu, 08 Jan 2026 14:42:11 +0100 (CET)
Received: from hz-m365gate04.de.seppmail.cloud (unknown [10.11.0.37])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by hz-scan04.de.seppmail.cloud (Postfix) with ESMTPS;
	Thu, 08 Jan 2026 14:42:09 +0100 (CET)
Received: from ZRAP278CU002.outbound.protection.outlook.com (mail-switzerlandnorthazlp17010002.outbound.protection.outlook.com [40.93.85.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (not verified))
	by hz-m365gate04.de.seppmail.cloud (Postfix) with ESMTPS id 4dn5g45xqtz1xfj;
	Thu,  8 Jan 2026 14:42:08 +0100 (CET)
Received: from AM6P191CA0065.EURP191.PROD.OUTLOOK.COM (2603:10a6:209:7f::42)
 by GVAP278MB0071.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:24::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.3; Thu, 8 Jan
 2026 13:42:06 +0000
Received: from AM2PEPF0001C714.eurprd05.prod.outlook.com
 (2603:10a6:209:7f:cafe::8) by AM6P191CA0065.outlook.office365.com
 (2603:10a6:209:7f::42) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9478.5 via Frontend Transport; Thu, 8
 Jan 2026 13:42:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.79.222.204)
 smtp.mailfrom=duagon.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=duagon.com;
Received-SPF: Pass (protection.outlook.com: domain of duagon.com designates
 20.79.222.204 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.79.222.204; helo=de2-emailsignatures-cloud.codetwo.com; pr=C
Received: from de2-emailsignatures-cloud.codetwo.com (20.79.222.204) by
 AM2PEPF0001C714.mail.protection.outlook.com (10.167.16.184) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Thu, 8 Jan 2026 13:42:04 +0000
Received: from ZRZP278CU001.outbound.protection.outlook.com (40.93.85.31) by de2-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Thu, 08 Jan 2026 13:42:04 +0000
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=duagon.com;
Received: from ZR0P278MB0523.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:34::6) by
 ZR4P278MB1901.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:b6::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9499.3; Thu, 8 Jan 2026 13:41:59 +0000
Received: from ZR0P278MB0523.CHEP278.PROD.OUTLOOK.COM
 ([fe80::39da:49d1:7c23:953e]) by ZR0P278MB0523.CHEP278.PROD.OUTLOOK.COM
 ([fe80::39da:49d1:7c23:953e%7]) with mapi id 15.20.9499.003; Thu, 8 Jan 2026
 13:41:59 +0000
From: Jose Javier Rodriguez Barbarin <dev-josejavier.rodriguez@duagon.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org
CC: andriy.shevchenko@intel.com,
	dev-jorge.sanjuangarcia@duagon.com,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jose Javier Rodriguez Barbarin <dev-josejavier.rodriguez@duagon.com>
Subject: [PATCH v2 1/2] serial: men_z135_uart: drop unneeded MODULE_ALIAS
Date: Thu, 8 Jan 2026 14:41:09 +0100
Message-ID: <20260108134110.25278-2-dev-josejavier.rodriguez@duagon.com>
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
	ZR0P278MB0523:EE_|ZR4P278MB1901:EE_|AM2PEPF0001C714:EE_|GVAP278MB0071:EE_|DU6PEPF0000A7E1:EE_|ZR4P278MB1772:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d5bb298-2700-484f-9b52-08de4ebbba80
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?htjFwh3dfL3E4FSYuZArRa6O+I2OSpkBw+y/mpOUxqtI+TaGq3Dih5jbqL4e?=
 =?us-ascii?Q?n4S2dL0213dtF+V2a3fkfNmlK0xBYCH4ZCrQ/iWsW/y6uJX18P8/dN9aFqdc?=
 =?us-ascii?Q?XPKC2h7EmPnkWgFO6DzgbIRL5fCUbidHD0ptl59qULfSLCFjYP7+h+E9ycKD?=
 =?us-ascii?Q?PiZ5tEduENJB6iWfplcWjc/faqqv6WPh8+GQlVfaPog24yIttR3mSwxJcVfb?=
 =?us-ascii?Q?Z8xm6gW5Du6jFAGhG5lE/39cRLIJQBWF+QxkGy7dycHgr5eJBCmHowVTGa/S?=
 =?us-ascii?Q?j9lm4/g1YQpnXAfWzls4gN9YU3gGDMtPo/BnDIYbbf1g775wK1Kpp9tEWvz4?=
 =?us-ascii?Q?qRux6xX3hSGN873+f16pz+ckeJu14iszjUXxrgmOpMS7Q/NWmboQUKgbMxPT?=
 =?us-ascii?Q?p1KSldI6tSik/Osrdr9p9uMKkKQFU5jRFK6R0Xw8E5421ZwPNhH47Hyw1W+F?=
 =?us-ascii?Q?6OV34rHpXjy83LXnIso3WaullhVmf5p3qvAL03LPCOkpe1W+v1IaC94FaZeJ?=
 =?us-ascii?Q?koFGsC/bTIwtth/XsTZvJfkD1AYyMKMh6UObO+GN6eCQhJ6wxA5uxV5MI2qH?=
 =?us-ascii?Q?eEwMkblFgSBubkEKPU6k7guADPPtm9uoBIaNKH6flMH23w6fiWnTOQlO9gmN?=
 =?us-ascii?Q?/Qyc0D/5xs6wiB6wnaKcwzxplT2ZWCPw97OO5XgS6m+sXvSf5+xXXo/7Egun?=
 =?us-ascii?Q?9jL+zaIKz1SN8geSIqWa71kS5GwM9p3PHbKlZ8TPMnRdo7gyC1teYkWsl65T?=
 =?us-ascii?Q?bzBDfCp3+DZqWw5PsylOijxTtsREYdaY4F+WzRPfU0wng5z20jBivFss0Xbf?=
 =?us-ascii?Q?pszOIIOVWX8zAF7Kff5cuX7qsHYEdfrxjDOq72MHxpRNeShIWihp5dTnqLg/?=
 =?us-ascii?Q?6KBaVrMZY4BiXzC+mhgh0eQflqhN/RIy3p8daP53cD8W7PB+G3NJBj380swL?=
 =?us-ascii?Q?NfQMdblYgxaJZ06pr0DSPVIdYzrG42/tUKVu3jj4ErKkJ2p90oGv+oC0c5MX?=
 =?us-ascii?Q?UC7fctjltKcNKThS81XqZb382AMkpVf73nVY8eHG7RLKHdArqrXGpfu0mlXP?=
 =?us-ascii?Q?GbzvUT0lT9OqeyLFFAwPT0ROIyLf0pYkv0ZWh7Ss1R1GdmsafWCZSbvtVzNs?=
 =?us-ascii?Q?dqsFFwcVvC3Obq9Y5NMSzlzmai2CfsVruDXahv7zwHEsXZbwdks1GL8axUG3?=
 =?us-ascii?Q?rd6G4d87ozOhF5+j4pRvtYaB6cAhDqIN83S7R3bEzsOq0wF1YCFy/ehAIsMQ?=
 =?us-ascii?Q?ilduGo4+n9OuuL7A3HM3guZy51/qCEjwQuDt3C6wkdX2FyWfYQlw7YE7f9pt?=
 =?us-ascii?Q?4o7Pwx5tCDTk9rOjtZad8/p23/ofGQqMLXbb13Ur1D0l/BzRJxZloCQjOSS5?=
 =?us-ascii?Q?V9D0picA2U+pXs0hUcWbPlxV0UqXS+L3WR/Jd8ZUoT1a35jU15n5ty7S7p39?=
 =?us-ascii?Q?ba4FVLHeneHPpqLVDXxvxqAgAT0rFHzeNpQGpa5KEb/UvyCm9sgItKRHERv9?=
 =?us-ascii?Q?qUFdI7lNI1ful7tQtaLtImTs3VDPuJ4+viFX?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZR0P278MB0523.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR4P278MB1901
X-CodeTwo-MessageID: 6e5ebe5c-3b82-454f-b56b-166c546bd7a6.20260108134204@de2-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 1
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM2PEPF0001C714.eurprd05.prod.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs:
 9b6b2807-3dcd-4d46-45a7-08de4ebbb287
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|35042699022|376014|82310400026|1800799024|14060799003|36860700013;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?kOdAZSITbZquaWvaqPlhfkXX45DMwp1DgdhKYYl/BJQZHQUtcL52Tk2Be2HE?=
 =?us-ascii?Q?igY04Utn7mtnnecgk+uVDRStumAcNEyDCxXmQOzFCgGy3zGK89KCoH3I/2L8?=
 =?us-ascii?Q?ZJn/wrEQQiaWLqEtOY4Yf1w9r/AkVZSR9HpTPOz+qYQVR4Cln7D0CvrnDuRV?=
 =?us-ascii?Q?LWS2q8KpVaVE6EtaJk7xaXBwvF8OwM62ayR7C4z6TFfM8K73tCLnWiMfOmnw?=
 =?us-ascii?Q?INK69oqY/8rJF2hia5v+GoekW6ARTs0JJcf8eHWqk75ONsWQOK9pvQY+ZrZb?=
 =?us-ascii?Q?b0MC7kQJBL2mWcTTMwGYT2jq//68HqCXCBe5rLhahegBwkVuG3sbFEI86zEZ?=
 =?us-ascii?Q?f3zh4PHTH6ANEtanH3keFx8HUNwOItUDna5ym0TvkA6tM+xIGLdgCMQPJLEc?=
 =?us-ascii?Q?+kFoMGZtpRYbACPRp00cK1tDAc3jvYz5H7KrsPFcDyvtDXLj479xbJOHtuPZ?=
 =?us-ascii?Q?coInQq7dwqXHuGisAnyZnsoemLVeGYjf9vWWwsGJ4YkA3xYp5rJrk/f7UJtp?=
 =?us-ascii?Q?mhxGPT+X4/PCN922tkMV0lFwk7BV/Y00NpK5UzZZDocpNuXB5VapCvOE9kru?=
 =?us-ascii?Q?nBnXKBtCZ4JRtj0u+z+9zNDArz/lgo5VsR9vtccjT9nCedh52joFdAz06U+3?=
 =?us-ascii?Q?lz3RIFUXffMGb76M5R69wmWrUO2JQgfBhG1rHFLciHFtYAdOzbz9Bam1ZemI?=
 =?us-ascii?Q?eY3bpP90PoicG45wx6y79IFcuzviDIMNv45qoCnUFa9gJuC7yPLl5fe1jL11?=
 =?us-ascii?Q?rAYOQrYTSWLV9XIAoJM2cPuoQoxsDvTtbFnQ4TphbkyVH4XtAY70D9QG6nVn?=
 =?us-ascii?Q?Jy9yEN50F8vcBVYeXljPtsqTKTVsPU5Dw3FjyCvI0zetnGt9W14nKy7IDY1J?=
 =?us-ascii?Q?08SN1lXBA3t5Pu1qqZR2M3jf1yYIE2W7Ar1Qu4fyw4rGMVbt0sBkJDesswFm?=
 =?us-ascii?Q?D5bfdeiRvNpdupDkqQpgWXZ4ySbWD+x+ZPPp1tT6+CJcdR7jYCPbGV0hRH8I?=
 =?us-ascii?Q?2A472RaUIYKRrEoxfLF4OGWQN7uRdjzD7KvCIMpMGF4qPaDW6VsW+fQ0QTHU?=
 =?us-ascii?Q?EL8JOgzpQ/40prOBqCBhp/KFJiYcs9DCh/fsQgo9AEGarQbYjFwLpmW6EEJI?=
 =?us-ascii?Q?ufrDqEe7ydPLi5L423vQ0Ii7N6yEZDBWkMh5efIiyQEA9yP7S/kxJtn+CVuO?=
 =?us-ascii?Q?/UlusuySsLkK2O3Geq6Dky8rEzSaIxcVdZOEqVgBA/cr819a4C9AMbpHXKvX?=
 =?us-ascii?Q?hotgLaAK6EBNJtSTafGt/Cqee5c7t0BxxX7Ib24Od/+r0Qtv0jeL85WvB/R4?=
 =?us-ascii?Q?ewNGVuF5xlGK/t2yKUcNKXXlNQmMNBjz8LttJJxipYJXMTnnPMEvrCZJRhs/?=
 =?us-ascii?Q?atsCDdbliVoCyvGQSy0NANSkp/06kIcjcba+83GXgZN1Mn19MHwI/eXremA4?=
 =?us-ascii?Q?c84eW+mCTpQ5jEEHjwGt6oy8khIpQuoJtWxml4FMaBS7o4BBkWJaD9EpNDqw?=
 =?us-ascii?Q?Yxgrsrev6T/KOwgiRrE6161n1sQBZ63ZI5uQuqYFUJUICz5dxNSQCv/kUnJc?=
 =?us-ascii?Q?LqxyGfeld+oRfPhsCyk=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:20.79.222.204;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:de2-emailsignatures-cloud.codetwo.com;PTR:de2-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230040)(35042699022)(376014)(82310400026)(1800799024)(14060799003)(36860700013);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVAP278MB0071
X-SEPP-CCCVersion: 2025-12-11T08:12:51+01:00 9ed91da2
X-MS-Exchange-SkipListedInternetSender:
 ip=[40.93.85.2];domain=ZRAP278CU002.outbound.protection.outlook.com
X-MS-Exchange-ExternalOriginalInternetSender:
 ip=[40.93.85.2];domain=ZRAP278CU002.outbound.protection.outlook.com
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DU6PEPF0000A7E1.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	aa1268d7-2979-4d04-d0ea-08de4ebbb5da
X-SM-ruleversion: 2.1.0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|156008|35042699022|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?U7a9Yh94u2hvlXA92SU8KD5jsUTW5D5E3alvOBNU3ehrQ0bxpExk3TiwgwBn?=
 =?us-ascii?Q?uHdAH297Q9wY/+DEDSAZiTKcmBR3uANLGcoQUq9XFALwRq+ntBX95Sm66lUl?=
 =?us-ascii?Q?WMmaHNXgP2a486vFLX8aHW9d7kq3A3VWznEXVEQ/BkOC0Ar44bsvgBX37oh7?=
 =?us-ascii?Q?pIRKdjelTvY1xHabSOoMPSG4GsAdXXsBFF6L686j/X+geQO6w/wa9yn47QJO?=
 =?us-ascii?Q?Kf82/DKKQvHQNy/k/pr3s11fQ3Ty3V9qPpUEXmokXUiH8+PWCjCVjYNZzkSD?=
 =?us-ascii?Q?6KBG8gaHe7Z3MoYsePBhnpVV7In2uPu+Y9C65QXEzkrlsWnGeGtj126c922p?=
 =?us-ascii?Q?B6EBU2dRbt8ie66lrdxTD4d4iWk2fYoxBJpkXDa3GJYFT4b87GK1HumnPuYA?=
 =?us-ascii?Q?Gi5wiB04Ahz1r7sW8huTrADkoeorhZUdIV9LYbzFA4bNvhHFHIcUld7BusCf?=
 =?us-ascii?Q?Do7Q3Y+E8tw6C3g7V4SPdgqpci/yffv2xaMT9bgia7DpsOrpc3flCfuq70wj?=
 =?us-ascii?Q?ojUF38qppi9u88UUpPW8iIwJI03FcLLkZ2Xp2EgxI5tGgmpPjWxKUPwy+wu9?=
 =?us-ascii?Q?BD7V6b6saiND3bigjybQTArir1fBFZrNqTmPkVKuGDwb8nkSW3rRpuvcE1KE?=
 =?us-ascii?Q?E3khi4IDzbhmqD26WPuEjjKN8EF69+ptiD8hbuKxfSgLw0f/ilRZJf52Vnrr?=
 =?us-ascii?Q?ljKNKFuZCXHW6Vq6lxnTPPNSrKulj0frEVBy/oMBuMIVchh0l8OdtFQl0jSw?=
 =?us-ascii?Q?jWmSCefjzS82cKOiKes0nfu3hC7CaqA15sBnzi7gvTSPmqlXvC6DUOb46kvW?=
 =?us-ascii?Q?rQO8qiL4yjPxRNNzSKHD9nuun9cfkfBxaOMV24c99V51ssmSNZew6aE5aenc?=
 =?us-ascii?Q?zIDSbtdkG555kDjLUB4x0OiAow4yUIg/gMEDcFGI+FVCT3x+vFv45SBNwgML?=
 =?us-ascii?Q?hgzTteHubI0Cb9nRJJ7fas2zMBU/BPH/17iDQvky0R6oH2wkhqnOcKycvuHt?=
 =?us-ascii?Q?sgBajNrPRKq2Qp0r8CEO+2KtfSaugx/9ILVB8uYNkKuboFDkShT2kM3LBryI?=
 =?us-ascii?Q?NpCz03ltPB8XQWQP6wuJzNUIpt/jFQg8tbZ8Y3Q8uw8qBqltanamOyVyw6jr?=
 =?us-ascii?Q?jI4455B6pBWk?=
X-Forefront-Antispam-Report:
	CIP:162.55.72.218;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZRAP278CU002.outbound.protection.outlook.com;PTR:mail-switzerlandnorthazlp17010002.outbound.protection.outlook.com;CAT:NONE;SFS:(13230040)(376014)(156008)(35042699022)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1102;
X-OriginatorOrg: duagon.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 13:42:12.6690
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d5bb298-2700-484f-9b52-08de4ebbba80
X-MS-Exchange-CrossTenant-Id: e5e7e96e-8a28-45d6-9093-a40dd5b51a57
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5e7e96e-8a28-45d6-9093-a40dd5b51a57;Ip=[162.55.72.218];Helo=[hz-deliver02.de.seppmail.cloud]
X-MS-Exchange-CrossTenant-AuthSource:
	DU6PEPF0000A7E1.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR4P278MB1772

Since commit 1f4ea4838b13 ("mcb: Add missing modpost build support")
the MODULE_ALIAS() is redundant as the module alias is now
automatically generated from the MODULE_DEVICE_TABLE().

Remove the explicit alias.

No functional change intended.

Reviewed-by: Jorge Sanjuan Garcia <dev-jorge.sanjuangarcia@duagon.com>
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

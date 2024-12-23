Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2113.outbound.protection.outlook.com [40.107.22.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74B6B1AF0C8;
	Mon, 23 Dec 2024 14:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.113
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734964063; cv=fail; b=nShoYj6vMwQK/Y6bUliaXJvIVeWYf+PMQGZdcS3SLSqffL+kCAFfO1d6UdXKDzRJRnfrDThFnI2dlDPA2iAXVPzbdtRSRaXEN9zzxjIUWkMPVhyyXLtkXfWJCO9CP+PEyGwK5FnKDgtQDg+7ycnoIHvFX/DBvg0uGisnBc9lp24=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734964063; c=relaxed/simple;
	bh=Q74ETxlm1oaHYtRoQRRBFmu7uy5Lx8V8bJqEEaox/9E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=W8xHYBIge16Z8VTE4hovvMSJKAJDcUskC6exGz4t4jw8OCyeAmoa9WKQgG9tnkNgmJcNf2iahR04kNC2cUFlbLbzIeACkZT7CCpSm+tV2l3v2B4M6sLBPh/fsmZRTyHUZ3mE13TundmZyMx4cEDujR3otR8RjyTATlrAXiyhHRY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sttls.nl; spf=pass smtp.mailfrom=sttls.nl; dkim=pass (2048-bit key) header.d=sttls.nl header.i=@sttls.nl header.b=qdorb01n; arc=fail smtp.client-ip=40.107.22.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sttls.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sttls.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sttls.nl header.i=@sttls.nl header.b="qdorb01n"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ye7VyOs05pyYCcuYbWf1JJ3iyY4SO3JjRFwbbzxy+HeO+BK6YSeuDtknz3sSnTFehWO0B41dBUZGax5uxdvwnPBsoE7H139gKxuIx2+10u5G2WjcXFOfXeW4Z4xwKw64ZCwfayh7Vx78Skj7mZfUIpFM6TLlR3b8x6CXYZVB5flRjgw7dZ/XQxM7t1jYKNMKnFkF10jOD+vGLIcRXvj8ntF4kJVKf7itTJwEzI04y/B4utjeI2AnTijWbxpVB4xCpXqhrmEL8Lhi7znrcZQIHtsKGBV35wQ556VGDfgSwPX273puv+2IAFrWOLAn99yifudgxc2oPqr5LHKr8YXdRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q74ETxlm1oaHYtRoQRRBFmu7uy5Lx8V8bJqEEaox/9E=;
 b=WWBY6VxkJAuoS9qKmaA/Q+mFmm9K4JqHFIA01HFqfswxjRN1vm+q+p8WG8z4juMSNkRldEcKn3HTVWsssWDvSt2+V/jxCQzRXCUGdUjjtddX5ne0t9t++LgAEJiUY/uh+IW8twsgQAFQMWbQ+Qamj45VKCbjAuWMWDIAThYTL6pANznlOTmPfNy9rk2Ah5NgF1QGEvv0ONSCD4bCLp7NzO3qKy/LVcJ22/RoUUkU7hLWcMqzCzgUNEA6Z6mEf9yCPB7mk9JIhRlupynH24KgCl6rqTOSKRn19Ak8nsana120malgGMgpMuRqFh91BUGVQTZpa9gjF5FgI6gdL5pJAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 20.93.157.195) smtp.rcpttodomain=systec-electronic.com
 smtp.mailfrom=sttls.nl; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=sttls.nl; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sttls.nl; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q74ETxlm1oaHYtRoQRRBFmu7uy5Lx8V8bJqEEaox/9E=;
 b=qdorb01n+JqVYAz0d9VJpqUzhtkjegLOeco2JxsOr71BLL5qiyC6OC+GiOyxy75C1KffbyTb96iV1lSkJrvU4S4mFs+loDjMOnsJcB8/38IQ3Hmqs43HzK8ka7VyUIwKPp+tzcFzcMCrJQ+JNU1QTrUHRxLezCl0hZVOTpHiKx436tDW8TLb0h6DQVq6xWkkhZ2c4A74Hb6rsYWQQEFrAT3OGcp2FUEprl74hMInHCn8QL9YLMc5l9027oyf4U/+jk41xribwPRjeBl8AAvbXw18uY2JEAfK+Ud3t6u6Q/Gsmmq2IUFQh6I3/ZddVt1aKxl/z/+vk/C2xYf90doJdw==
Received: from DB7PR05CA0026.eurprd05.prod.outlook.com (2603:10a6:10:36::39)
 by VI0PR05MB11486.eurprd05.prod.outlook.com (2603:10a6:800:244::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.16; Mon, 23 Dec
 2024 14:27:29 +0000
Received: from DU2PEPF00028D06.eurprd03.prod.outlook.com
 (2603:10a6:10:36:cafe::b9) by DB7PR05CA0026.outlook.office365.com
 (2603:10a6:10:36::39) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8272.19 via Frontend Transport; Mon,
 23 Dec 2024 14:27:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.93.157.195)
 smtp.mailfrom=sttls.nl; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=sttls.nl;
Received-SPF: Pass (protection.outlook.com: domain of sttls.nl designates
 20.93.157.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.93.157.195; helo=westeu11-emailsignatures-cloud.codetwo.com;
 pr=C
Received: from westeu11-emailsignatures-cloud.codetwo.com (20.93.157.195) by
 DU2PEPF00028D06.mail.protection.outlook.com (10.167.242.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8293.12 via Frontend Transport; Mon, 23 Dec 2024 14:27:28 +0000
Received: from DUZPR83CU001.outbound.protection.outlook.com (40.93.64.11) by westeu11-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Mon, 23 Dec 2024 14:27:28 +0000
Received: from AS8PR05MB9810.eurprd05.prod.outlook.com (2603:10a6:20b:5c2::16)
 by PA1PR05MB11503.eurprd05.prod.outlook.com (2603:10a6:102:45b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.18; Mon, 23 Dec
 2024 14:27:22 +0000
Received: from AS8PR05MB9810.eurprd05.prod.outlook.com
 ([fe80::841e:3b57:8c60:5734]) by AS8PR05MB9810.eurprd05.prod.outlook.com
 ([fe80::841e:3b57:8c60:5734%3]) with mapi id 15.20.8272.013; Mon, 23 Dec 2024
 14:27:22 +0000
From: Maarten Brock <Maarten.Brock@sttls.nl>
To: Andre Werner <andre.werner@systec-electronic.com>, Greg KH
	<gregkh@linuxfoundation.org>
CC: "jirislaby@kernel.org" <jirislaby@kernel.org>, "hvilleneuve@dimonoff.com"
	<hvilleneuve@dimonoff.com>, "andy@kernel.org" <andy@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
	"lech.perczak@camlingroup.com" <lech.perczak@camlingroup.com>
Subject: RE: [External Email] Re: [PATCH] serial: sc16is7xx: Add polling
 feature if no IRQ usage possible
Thread-Topic: [External Email] Re: [PATCH] serial: sc16is7xx: Add polling
 feature if no IRQ usage possible
Thread-Index: AQHbUfPospPOLiqIZ0y5PlXWz86ZQLLtSzEAgAAFO4CAAVHCAIAFQ6pQ
Date: Mon, 23 Dec 2024 14:27:22 +0000
Message-ID: <AS8PR05MB9810B543A1223ED04729EAAE83022@AS8PR05MB9810.eurprd05.prod.outlook.com>
References: <20241219084638.960253-1-andre.werner@systec-electronic.com>
 <2024121931-turbojet-preamble-b520@gregkh>
 <fbd224a3-8f10-3ccf-5480-38fcd839d409@systec-electronic.com>
 <2024121906-reach-hash-3d7c@gregkh>
 <5a524cb7-23d9-63b8-81fc-b68a23fddd65@systec-electronic.com>
In-Reply-To: <5a524cb7-23d9-63b8-81fc-b68a23fddd65@systec-electronic.com>
Accept-Language: en-US, nl-NL
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sttls.nl;
x-ms-traffictypediagnostic:
	AS8PR05MB9810:EE_|PA1PR05MB11503:EE_|DU2PEPF00028D06:EE_|VI0PR05MB11486:EE_
X-MS-Office365-Filtering-Correlation-Id: ec002985-8461-4021-e588-08dd235dedf6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?NEtXTzIrWGVQQkNSSEc0S1pEcnowaGw1OHdtZlBPVTR2a2hxb2U5c1J2anJj?=
 =?utf-8?B?M2pQaTdSWkxkelBTMUUyeDAzMmlIRFFSWmJaNG5NK0k5cmgwakRyQ1Z3Qld6?=
 =?utf-8?B?bXFBY2RyQTUzTEcyWVIycS9YSGhPbVNjamhjb21XU3RoT2RacnBMOFBmTnNP?=
 =?utf-8?B?c0dKR3k3cTZLUHBDYmhLMllrT3N5WUNtRzNuSHQyNFlUVXR5WlBrL0ZtbWM1?=
 =?utf-8?B?WEtLQ20yZldKaXdHU3NWL1YwellZdlZTS2FNMjIvcTVTcHhRbS9PeldWcEU4?=
 =?utf-8?B?K3ErYk5jWXh2L1hWRlppZldsV2t2VGxqT01qNlNPUkZqbStlWVdrOXZQSllI?=
 =?utf-8?B?dGNUV2ZlRStkbnh4U1ZXSXhvWXZ0WnAyemhyVVVyYlY4TEhVRi8vNEQwZWpX?=
 =?utf-8?B?S0FCL05ZVEsrdHB3WW5QSDREMFd3ZmpFOFVCaE5OZDFrZ055c2NjQWNQcmJk?=
 =?utf-8?B?UlBTQ0ZpcE5za3V5S1NONzlmRU9FQzJQV0Zua3hnRTNhMTByejlLZlhlUjJk?=
 =?utf-8?B?Sk5SM2hTREtwZXkwSWswTUFnLzdlMDBkbndKYzlMaitjZG1QeXhndVY1a0dw?=
 =?utf-8?B?S09JUERobVpFcUp2OUJVWnB4Y2p0RlZXZ01DL2xQdUtDb1Ezdk5qQUQrYWcy?=
 =?utf-8?B?T1BQRS9EZHYvTzJiTmxtcHNoVFY3c1lkRDVjNHVJMDkyOThIaGZVT0lyT2J4?=
 =?utf-8?B?UzRuTUZ2T3JxbmJPaVE5WkNsVDF1cHVjb2ptZHBSamk3Y3c3Tm5IRkN0NENp?=
 =?utf-8?B?UUR4b3NRUzhxcmNzS0V6N2tockN0c1hBWi81SjJEdDM3UjNwZmZSVncrMXE5?=
 =?utf-8?B?eTJPZ2NkMXVrOTlZN292SG5SR2FtbFQxQlY0MHFFc0V2SUpPdlUvRWhiUE9r?=
 =?utf-8?B?a0NneWtSMDVOL3Irc0JnS2psWTUzcjZSdDlqMkJUZzNTNk5lTU9mZFZ1em5R?=
 =?utf-8?B?dlJ0MUU2OGxVQUJZNUV3OEFtTFhrb2NpUTVqYzhlVDJnVThXRkM3SzlLT2c2?=
 =?utf-8?B?S0pPRGZtZnRPLzlaaHVRVE9zZ0lVK0pqUVRGUHdabUV0dVRndnNReUswQ1Nr?=
 =?utf-8?B?eEszVHJLWXFMNDVEdGNyT2JVTSs2d2pMbGgyU3p4dDhLTzU3MnF5Nk5aYjB3?=
 =?utf-8?B?QkIxRDVjV21rMkNEcW1JakdBVG1KT3AwZWlpYldjT2JJSkNickRTWWxzTkR3?=
 =?utf-8?B?emw5Q283V2RxS0tONG9Lblk5TnYvMXNOVDNvWHFpTEdscnoxSERLdHNnOUxK?=
 =?utf-8?B?MjBQOXlXUzN2bTRCMGdtNGZZZUpkMGlJdTRURmp3YzlCQmxCdHE1Ry8wT3VM?=
 =?utf-8?B?TDI3Smg5M0RrOGRkMWpXR3FpK3BtQ3dlZ2xkZEpJY1hRNkxiWHVmTUpFRzNF?=
 =?utf-8?B?dzJRZzcvbDNFOUJvVit4emRpQy8yZ0EwWW5RL1daaHpnYUZESnNsRklyMzND?=
 =?utf-8?B?K1o2dXpnbkdKcStaaGwvbHRCb2s3d2ZVR3Yxc1RYVzBOZ0hqS095Q3RRb2xD?=
 =?utf-8?B?RFNGRFBuRStlbE5USUJJb21UWVYydTRzSitZZHV2VkU0U1hNeHJxWHovaFRz?=
 =?utf-8?B?VGRLdk1ubTJMUVRPNUhrT2dVQVhkdmJZL0JTRzQyODRvNnBmaElJanVuZld6?=
 =?utf-8?B?ellmQ1N5Z1F1MWpLeTNjdFpzRjlzMU4zZm9CV2t1WGE0ZU5qcjMxSm9pQWRG?=
 =?utf-8?B?aUNtZlk3VDEwS09xZHZnZ1BnaWpCRko5UzQ5aHFlZlZGaGFjUjgyTnRmYmZX?=
 =?utf-8?B?dkFDVVc5bys1a29QK3FFYWVwYlhERERHTERWOTV1RnFZVGh0WXVqZHJEdEpa?=
 =?utf-8?B?Z0txc0lmS3BiQy9Od0g0dU9VYzZ6dkZGci9iUWlsaFdKTHhLMFhRMU1tTXB4?=
 =?utf-8?B?Q3RwblhxR3RnaUtMdXlGUURpUnBId1BGcnVleWtmdmswWVYyYTl4Q3pRR3Y4?=
 =?utf-8?Q?HfcAusMVuVHuK0HJqOhetM/LKqVmPrhN?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR05MB9810.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1102;
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR05MB11503
X-CodeTwo-MessageID: e57905bb-b9d5-46fd-adf1-0aab686004ad.20241223142728@westeu11-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DU2PEPF00028D06.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	6ab56a31-77d2-490f-205b-08dd235dea1e
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|14060799003|1800799024|376014|30052699003|82310400026|35042699022|36860700013|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Q1Z1VEttYjJlbXBuWjFYS011anRCQ001SVR3NGVMZHd2ajdzZEg3TldFNnB0?=
 =?utf-8?B?ZzN0c0tLbWQ5K2ZpN2RSODZ2ZVhTODhNbXl3c1hZM3NCcUJsVDBWMGlCUFdk?=
 =?utf-8?B?eFJnQ0pORmorS1ErbWtwcysxR25wSGdIT2E5NGNKYm1NNUFzMXdzbCt6Titq?=
 =?utf-8?B?M2N4bG1EY1VNd0hGVkNjcGdzWWVpVW1MZVp3b3FqMTNYY3FMcDNLRlBNQS9r?=
 =?utf-8?B?Rm1sSmNEMFN4MkFxdFhDQW1kNTI4T2NzajR6dmF3WXRZKzlneXRQaWU4ZWN0?=
 =?utf-8?B?c1IzYWw0Zjl1MlkzTDZvSmVqdEpIeG5EYUNQclFLclc3a2YweTFmazkyb1BN?=
 =?utf-8?B?UEZVdVJ2ZjJDSHA5NE5zYjdhN294bHlNcUk2eTFQRnBxbHF3SDM5R1JYMFhC?=
 =?utf-8?B?a1IwTHF5N0tYTUx0V0lPWkI0bUplV2oyY1RML2ZLYVJyNHFtNDB6aURtK1JL?=
 =?utf-8?B?bWVtK3RiQ0pBY3N2V3Q1U1ZXbGVGb2hIdk1kdFFGc0w5Q2VHYUx5TnQzR05i?=
 =?utf-8?B?Ni94WHdldkk2T2puUWNleVlCOHJIM1M1MW1qTmdHNjVzQk03cFhGbHdxbDcv?=
 =?utf-8?B?cGdMZ2t3QU05cmk1TmN1Z3dsWUtaZzd1MnBxN1lYU3VQMi9VT1BaSFpMTFdW?=
 =?utf-8?B?WUZId0MwSEczaGhXK2xOc2E2eURIRW9vZFJmWVlucXBuSXczdU1LaVd6LzRx?=
 =?utf-8?B?UzFsNFZudjlIaE9xT05tOGtjakxROFdUSVZXb25XbkVHcnZlWkRhN3loaXhm?=
 =?utf-8?B?eHMxdjgxVmh2SlcxUXE2cnNPVXVjTjBpb0JrUDdNUmtkc3NiRlZaMS9jelVx?=
 =?utf-8?B?aHd5K2FkZnVjUDBFUTVIUnhUQkFXSXlnWXlUdnU0UEEwZWZOR1F5aXRXa0I3?=
 =?utf-8?B?TkdQUk5zY0Z1eHNTUk9CWFAzMzF6dWVFQmV5Unc4OUpGVU8vWFlpbzh6cEZY?=
 =?utf-8?B?dFhsaGxNRW5KMGc5UmF3ekNwV1FSVnZmYThzNC9NTnBtSzVBcDIzakRvRlhq?=
 =?utf-8?B?K04zaDFRd3JSeWtwbW5VU2hWMmdVRi9WcjVoVjExbUNNVEMxZENHRzFQOFZK?=
 =?utf-8?B?bHBjZmtOUXpyK0xiMXBad0lmeEw1cWNEL3l0VnNGd0VERGV4VUxYMncwbFhx?=
 =?utf-8?B?NFQxYS9wSnFYWmlBYW9Od3djTGFXYWg1cGFVbHEyeU9hUS9CMzdyRGkxRkw0?=
 =?utf-8?B?MXErZnVuTGFsYlN0N281UGZGcXlrS0JIenJlWmFDMXpPOVdiQXZldlFWeXB2?=
 =?utf-8?B?QzBTRXpTZVBKbEUyazA4RGs2NGN4VFpxbElqaGN3Q2VrZ3YrZ2IxUmlvUlFj?=
 =?utf-8?B?b1FuYkV5dXlxTFdHTWlyMkptWFUwVFB4bDEyRjBBcXoxVmlobTU3Y1ZwbHdT?=
 =?utf-8?B?VEYvY0Z5S0NSUnIybnhIcVBTU3pxRTQ2YjZJYXUzZlZnOFY0cGYzK3lZS2tj?=
 =?utf-8?B?QlN3eWY0cTdydTdIVTNZeVFKQWpHNlphT09kRGQ1bEFXWXA4MVZOdkxER3Fh?=
 =?utf-8?B?bEhYQjNnSFNmTGZ4WTVxbkVjWTNrMklYdGVjbWFteVZ6dEJNMVBRMVBxMUNq?=
 =?utf-8?B?R09Ua0lpRU1ZZ29hVlNHU0lDNWpBYzBZTzNEM2JNUklKNFNEUTJUTXN1RytV?=
 =?utf-8?B?L3VPMEZKVWQ0a0JWYUJlWnFJVFBIbm1abUV0VWVsa1prdDFBL0ZpTzdLTUoz?=
 =?utf-8?B?M2VKak05Q1NHV3hlT0sxaWIveTk3TkFjLzNsVHArWm9Ha2lEd2VReUpxcWox?=
 =?utf-8?B?VXZoSEpJeW9XQ2x1YWV3aDNNbXMyUStiZERoM2czUm1rTXBzbEdSb2lZZHVG?=
 =?utf-8?B?MGVYK0FoTVRmRVM4dGhIdEc2Q1JBa05hd0ZDRk9HUFZwQnVPRTVDcDBJVGR5?=
 =?utf-8?B?RUs3eXNNSU1zQVBPWksvVkJDS2VteXJyeWtZYzlXbVp3KzVDd0w5cHdNTGhB?=
 =?utf-8?B?QlFZa051elY2OThGYzMxa2lnbVljRllmT1hsRVFpODlhVHdwN1N4ZUdSTU4w?=
 =?utf-8?Q?9V3ewN4KJaIwAkHeDPd6Ga+kOp+hCs=3D?=
X-Forefront-Antispam-Report:
	CIP:20.93.157.195;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:westeu11-emailsignatures-cloud.codetwo.com;PTR:westeu11-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230040)(14060799003)(1800799024)(376014)(30052699003)(82310400026)(35042699022)(36860700013)(7053199007);DIR:OUT;SFP:1102;
X-OriginatorOrg: sttls.nl
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Dec 2024 14:27:28.6383
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ec002985-8461-4021-e588-08dd235dedf6
X-MS-Exchange-CrossTenant-Id: 86583a9a-af49-4f90-b51f-a573c9641d6a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=86583a9a-af49-4f90-b51f-a573c9641d6a;Ip=[20.93.157.195];Helo=[westeu11-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF00028D06.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR05MB11486

SGVsbG8gR3JlZyBhbmQgQW5kcmUsDQoNCj4gRnJvbTogQW5kcmUgV2VybmVyIDxhbmRyZS53ZXJu
ZXJAc3lzdGVjLWVsZWN0cm9uaWMuY29tPg0KPiANCj4gRGVhciBHcmVnOg0KPiANCj4gT24gVGh1
LCAxOSBEZWMgMjAyNCwgR3JlZyBLSCB3cm90ZToNCj4gDQo+ID4gT24gVGh1LCBEZWMgMTksIDIw
MjQgYXQgMTA6MjI6NDBBTSArMDEwMCwgQW5kcmUgV2VybmVyIHdyb3RlOg0KPiA+ID4gRGVhciBH
cmVnLA0KPiA+ID4gT24gVGh1LCAxOSBEZWMgMjAyNCwgR3JlZyBLSCB3cm90ZToNCj4gPiA+DQo+
ID4gPiA+IE9uIFRodSwgRGVjIDE5LCAyMDI0IGF0IDA5OjQ2OjM4QU0gKzAxMDAsIEFuZHJlIFdl
cm5lciB3cm90ZToNCj4gPiA+ID4gPiBGYWxsIGJhY2sgdG8gcG9sbGluZyBtb2RlIGlmIG5vIGlu
dGVycnVwdCBpcyBjb25maWd1cmVkIGJlY2F1c2Ugbm90DQo+ID4gPiA+ID4gcG9zc2libGUuIElm
ICJpbnRlcnJ1cHRzIiBwcm9wZXJ0eSBpcyBtaXNzaW5nIGluIGRldmljZXRyZWUgdGhlIGRyaXZl
cg0KPiA+ID4gPiA+IHVzZXMgYSBkZWxheWVkIHdvcmtlciB0byBwdWxsIHN0YXRlIG9mIGludGVy
cnVwdCBzdGF0dXMgcmVnaXN0ZXJzLg0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gU2lnbmVkLW9mZi1i
eTogQW5kcmUgV2VybmVyIDxhbmRyZS53ZXJuZXJAc3lzdGVjLWVsZWN0cm9uaWMuY29tPg0KPiA+
ID4gPiA+IC0tLQ0KPiA+ID4gPiA+IFRoaXMgZHJpdmVyIHdhcyB0ZXN0ZWQgb24gTGludXggNS4x
MC4gV2UgaGFkIGEgY3VzdG9tIGJvYXJkIHRoYXQgd2FzIG5vdA0KPiA+ID4gPiA+IGFibGUgdG8g
Y29ubmVjdCB0aGUgaW50ZXJydXB0IHBvcnQuIE9ubHkgSTJDIHdhcyBhdmFpbGFibGUuDQo+ID4g
PiA+DQo+ID4gPiA+IENvdWxkIHlvdSBub3QgdGVzdCB0aGlzIG9uIHRoZSBsYXRlc3QgdHJlZT8g
IDUuMTAgaXMgX1ZFUllfIG9sZCBub3cuDQo+ID4gPg0KPiA+ID4gSSB3aWxsIHRyeSBpdCBvbiBk
ZXZib2FyZCB3aXRoIGEgNi4xIEtlcm5lbC4gSXMgdGhhdCBva2F5IGZvciB5b3U/DQo+ID4NCj4g
PiA2LjEgd2FzIHJlbGVhc2VkIGluIERlY2VtYmVyIG9mIDIwMjIsIDIgZnVsbCB5ZWFycyBhbmQg
aHVuZHJlZHMgb2YNCj4gPiB0aG91c2FuZHMgb2YgY2hhbmdlcyBhZ28uICBQbGVhc2Ugd29yayBv
ZmYgb2YgTGludXMncyBsYXRlc3QgdHJlZSwgd2UNCj4gPiBjYW4ndCBnbyBiYWNrIGluIHRpbWUg
OikNCg0KSSBhZ3JlZSB3aXRoIEdyZWcgdGhhdCBzdWNoIGEgbmV3IGZlYXR1cmUgb25seSBiZWxv
bmdzIGluIHRoZSBjdXJyZW50IGRldmVsb3BtZW50Lg0KDQo+ID4gPiA+ID4gQEAgLTE1MzcsNyAr
MTU2NCwxMyBAQCBpbnQgc2MxNmlzN3h4X3Byb2JlKHN0cnVjdCBkZXZpY2UgKmRldiwgY29uc3QN
Cj4gc3RydWN0IHNjMTZpczd4eF9kZXZ0eXBlICpkZXZ0eXBlLA0KPiA+ID4gPiA+DQo+ID4gPiA+
ID4gIAkvKiBBbHdheXMgYXNrIGZvciBmaXhlZCBjbG9jayByYXRlIGZyb20gYSBwcm9wZXJ0eS4g
Ki8NCj4gPiA+ID4gPiAgCWRldmljZV9wcm9wZXJ0eV9yZWFkX3UzMihkZXYsICJjbG9jay1mcmVx
dWVuY3kiLCAmdWFydGNsayk7DQo+ID4gPiA+ID4gKwlzLT5wb2xsaW5nID0gIWRldmljZV9wcm9w
ZXJ0eV9wcmVzZW50KGRldiwgImludGVycnVwdHMiKTsNCj4gPiA+ID4gPg0KPiA+ID4gPiA+ICsJ
aWYgKHMtPnBvbGxpbmcpIHsNCj4gPiA+ID4gPiArCQlkZXZfd2FybihkZXYsDQo+ID4gPiA+ID4g
KwkJCSAiTm8gaW50ZXJydXB0IGRlZmluaXRpb24gZm91bmQuIEZhbGxpbmcgYmFjayB0bw0KPiBw
b2xsaW5nIG1vZGUuXG4iKTsNCj4gPiA+ID4NCj4gPiA+ID4gV2hhdCBpcyBhIHVzZXIgc3VwcG9z
ZWQgdG8gZG8gd2l0aCB0aGlzIG1lc3NhZ2U/ICBBbmQgd2h5IHdvdWxkIGEgZGV2aWNlDQo+ID4g
PiA+IE5PVCBoYXZlIGFueSBpbnRlcnJ1cHRzPyAgVGhpcyBmZWVscyBsaWtlIGl0IGlzIGp1c3Qg
Z29pbmcgdG8gcG91bmQgb24NCj4gPiA+ID4gdGhlIGRldmljZSBhbmQgY2F1c2UgYSBsb3Qgb2Yg
cG93ZXIgZHJhaW4gZm9yIGp1c3QgYSBzaW1wbGUgbGl0dGxlIHVhcnQuDQo+ID4gPg0KPiA+ID4g
SSB0aG91Z2h0IGl0IGNvdWxkIGJlIGludGVyZXN0aW5nIHRvIGtub3cgdGhhdCB0aGUgZGV2aWNl
IGhhcyBtaXNzaW5nDQo+ID4gPiBpbnRlcnJ1cHQgc3VwcG9ydC4NCj4gPg0KPiA+IE1heWJlLCBi
dXQgYXMgeW91IGFyZSBub3cgd2FybmluZyBhIHVzZXIgYWJvdXQgdGhpcywgd2hhdCBhcmUgdGhl
eQ0KPiA+IHN1cHBvc2VkIHRvIGRvIHRvIGZpeCBpdD8NCg0KQWdhaW4sIEkgYWdyZWUgd2l0aCBH
cmVnLCB0aGlzIG1lc3NhZ2UgaXMgYXBwcm9wcmlhdGUgdG8gdGhlIGRldmVsb3BlciBvbmx5Lg0K
SSBzdWdnZXN0IHRvIGNoYW5nZSB0aGUgbG9nIGxldmVsLg0KDQo+ID4gPiA+IFdoeSBjYW4ndCB5
b3VyIHN5c3RlbSBwcm92aWRlIGEgdmFsaWQgaXJxIGxpbmU/DQoNCkhlcmUsIEkgYW0gbW9yZSB3
aXRoIEFuZHJlLiBUaGlzIGp1c3QgaGFwcGVucyBzb21ldGltZXMsIGVzcC4gaW4gZW1iZWRkZWQN
CnNvbHV0aW9ucy4NCg0KPiA+ID4gSW4gb3VyIGNhc2Ugd2UgaGF2ZSBvbmx5IGFuIEkyQyBhdmFp
bGFibGUgaW4gYSBjb25uZWN0aW9uIGNhYmxlIGFuZCB0aGUNCj4gPiA+IEdQSU9zIGFyZSBsaW5r
ZWQgdGhyb3VnaCBhIHR3byB3YXkgbGV2ZWwgc2hpZnRlci4NCj4gPiA+IEl0IHdhcyBhIHZlcnkg
c3BlY2lhbCBzaXR1YXRpb24gaW4gb3VyIGNhc2UgYmVjYXVzZSB0YXJnZXQgcGxhdGZvcm0gYW5k
DQo+ID4gPiBzZW5zb3IgcGxhdGZvcm0gYXJlIHByb3ZpZGVkLg0KPiA+ID4gVGhlIElSUSBmcm9t
IHRoZSBzZW5zb3Igd2FyIG5vdCBhYmxlIHRvIGRyaXZlIHRoZSB0d28gd2F5IGxldmVsIHNoaWZ0
ZXIgbG93IHNvDQo+ID4gPiB3ZSBhbHdheXMgZGV0ZWN0IG91dGdvaW5nIHRyYWZmaWMgYW5kIHRo
ZSBJUlEgc2lnbmFsIGJ1dCBhdCB0aGUgdGFyZ2V0DQo+ID4gPiBib2FyZCBhZnRlciB0aGUgbGV2
ZWwgc2hpZnRlciB0aGUgc2lnbmFsIHJlbWFpbnMgc3RhYmxlLiBTbw0KPiA+ID4gY29tbXVuaWNh
dGlvbiBmYWlsZWQgd2l0aCBhIHRpbWVvdXQuIFNvIHdlIG5lZWQgdG8gZm9yY2UgcG9sbGluZyB0
aGUNCj4gPiA+IGludGVycnVwdCBzdGF0dXMgcmVnaXN0ZXIgYmVjYXVzZQ0KPiA+ID4gYm90aCBI
VyBzb2x1dGlvbiBzaG91bGQgbm90IGJlIGNoYW5nZWQgaW4gYW55IHdheS4NCj4gPg0KPiA+IEFn
YWluLCB5b3UgYXJlIGJ1cm5pbmcgYSBUT04gb2YgcG93ZXIganVzdCBmb3IgYSBzaW1wbGUgbGl0
dGxlIHVhcnQsDQo+ID4gd2l0aCB5b3VyIHN5c3RlbSBuZXZlciBiZWluZyBhYmxlIHRvIGdvIHRv
IHNsZWVwLCBhcmUgeW91IHN1cmUgdGhpcyBpcw0KPiA+IHNvbWV0aGluZyB0aGF0IHlvdSB3YW50
IG90aGVycyB0byBlbXVsYXRlIGFuZCBzdXBwb3J0Pw0KDQpCdXQgdGhlIGFsdGVybmF0aXZlIGlz
IGV2ZW4gd29yc2U6IGEgbm9uLWZ1bmN0aW9uaW5nIHVhcnQuIFNvbWV0aGluZyB0aGF0DQp3b3Jr
cyBidXQgY29uc3VtZXMgdG9vIG11Y2ggcG93ZXIgaXMgYmV0dGVyIHRoYW4gc29tZXRoaW5nIHRo
YXQgZG9lc24ndA0KZXZlbiB3b3JrIGF0IGFsbC4NCg0KPiBJIGdvdCB5b3VyIHBvaW50IGFuZCBJ
J20gZnVsbHkgd2l0aC4gVGhpcyBjYXVzZWQgbWUgdG8gcHJpbnQgYSB3YXJuaW5nDQo+IGluIEtl
cm5lbCBsb2cgYmVjYXVzZSBpdCBzaG91bGQgbm90IGJlIHRoZSBnZW5lcmFsIHdvcmtpbmcgbWV0
aG9kLg0KPiBJbiBvdXIgc3BlY2lhbCBjYXNlIHdlIGRvIG5vdCBoYXZlIGFueSBvdGhlciBvcHRp
b24gYmVjYXVzZSB0aGUgc2Vuc29yDQo+IG1vZHVsZSB1c2luZyB0aGUgU0MxNklTN3h4IGFuZCB0
aGUgaGFyZHdhcmUgd2l0aCB0aGUgTUNVIHJ1bm5pbmcgTGludXggT1MNCj4gYXJlIGZpeGVkLiBX
ZSBoYWQgbm8gcG9zc2liaWxpdGllcyB0byBtb3ZlIGFueSBHUElPIG9yIHN1Y2guIFRoaXMgd2Fz
DQo+IHRoZSBvbmx5IGNoYW5jZSAgdG8gc3VwcG9ydCB0aGUgZGVkaWNhdGVkIHNlbnNvciBwbGF0
Zm9ybSBhbmQgSSBtYXkgYmUNCj4gdGhlIGNhc2UgdGhhdCBzb21lb25lIGVsc2UgZmFjZXMgdGhl
IHNhbWUgcHJvYmxlbXMuIEkgdGhvdWdodCB0aGF0DQo+IHNvbWVvbmUgZWxzZSBtYXkgYmVuZWZp
dCBmcm9tIHRoaXMgd29ya2Fyb3VuZCB0b28uIEJ1dCBhcyBJIGdvdCB5b3VyDQo+IHBvaW50IEkn
bSBhbHNvIGZpbmUgaWYgaXQgaXMgbm90IG1lcmdlZCBpbnRvIG1haW4gTGludXggS2VybmVsIHNv
dXJjZXMuDQoNCkkgdm90ZSB0aGlzIHBhdGNoIHRvIGdvIGluIChhZnRlciBtb2RpZmljYXRpb24p
Lg0KDQpLaW5kIHJlZ2FyZHMsDQpNYWFydGVuDQoNCg==

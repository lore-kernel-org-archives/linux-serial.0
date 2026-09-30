Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11021115.outbound.protection.outlook.com [52.101.65.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF0764E3EF6;
	Wed, 30 Sep 2026 14:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.115
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790780243; cv=fail; b=F5NkY+ZBKiwxB8YZSGYgTMLVltCGpSiwvncodsCCD/ugkKhp1Nv0L2VjKxcOWbpWeFf9evjzVNtB7MEZ0RkKhDd0QJkpYdFX2quf5yXH53mYNyhakE3d7Dzze3LYGEygYCzjkgwXR4eTYoEgL1X1PKWsofzQZlvUYhO5x6MMhRI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790780243; c=relaxed/simple;
	bh=OB1pSAP9s7n4/VntMxs9RSWZbFakNqKzN0qqG23TjSc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=isZxy3lHT5srBZN0IdTUjof+sc0I27xFz60AXyGMpXIhvEY/+WRuTw0xytiDtRYE27Daa21N5GNpxTb4Q6nXlpxCpr+O6VEa6TZtW3VsUXdYX4aYOWo9zKZA06WpTlOzmt994dG6zI34hCcbXxv76nCTsh89Ml3D4zWtOtkRSEg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ziehl-abegg.de; spf=pass smtp.mailfrom=ziehl-abegg.de; dkim=pass (1024-bit key) header.d=ziehl-abegg.de header.i=@ziehl-abegg.de header.b=PMaHfp0C; arc=fail smtp.client-ip=52.101.65.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ziehl-abegg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziehl-abegg.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ziehl-abegg.de header.i=@ziehl-abegg.de header.b="PMaHfp0C"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EpnHtX+vO3onAIwr3jP3jsEFQpdozo2Zzp4HjHUIPWOa8AYsKU59v4wiaRBsXeaieA693O9Mskdhr12iMG7y3VkIlAWMxzld4PpxlF3ljBlztZs3tgnvU9ZiIjcvVt8CfKkg+7di8dho3LSN+EPRxb3+iE7PHs6XE91VFe2IkCgV9xDaglXQhb3XwMEMn/BNeDvad8Xs7SprtE7AO1i0OCTQSRIBzKglrgo1/b4Uo36pnrtcO8gPP3CstF+zZ6+Kr7w5IGyybGK3v2IkhcS25G+zZHWfuavWLW+UEeAJsHhS8g6FMe+GUxAdDrsZULfc/bjWslW64xAINoXRVwL6sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZHnEZAFbjPF3QGXF8wjCD6r9bj5N3OCHG0Skfnep1IA=;
 b=F7l603yKgcFm255GkGdjTh6JuvaexeRKpgevlQ3jZNV1Y991vewYwU3+Wfl3UlSyqM81wxDpJ/ZTLjSZusZ05kA98xXouyfQhS0mXwSuBn2AIZ+sRKoxOK7hfkIWoVwqjifKsdxQ4KUaVgW6ErYVJQ9nSvrnWAYxMZ+zFF4EDUIISTNgUDGACX9W36eftTLsny9zVN/+P823dP/L0yRvxwVp6LA/t+hQQwYTJql5bsHv4YYhgBKOo/I+gco8cOTbq7Njyq2bTUlVDscjJ7fsot9JlH1HRyzn1lGtHQRei2A8OMsq9c+HTDdKKs9u+m0/AX5n8UU3EnQNCsvcsk18vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 13.74.137.176) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=ziehl-abegg.de; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=ziehl-abegg.de; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziehl-abegg.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZHnEZAFbjPF3QGXF8wjCD6r9bj5N3OCHG0Skfnep1IA=;
 b=PMaHfp0CkqJ1UdTFsy/WmPWihguU+EyD48GtUVbNB+G0trEmm4XqxWHNvnJTTqVXm06n8U73I3dHVSU1AnqR8EG2VTJaxMjvNNFl+Z4wDM9j+/PkM0+DnMYcI8b4/sCCmY3snG+fN1Acec4TSaRJIlLeFgPgndjj4bktAi3m4iw=
Received: from DU7P190CA0005.EURP190.PROD.OUTLOOK.COM (2603:10a6:10:550::22)
 by DBAPR02MB6231.eurprd02.prod.outlook.com (2603:10a6:10:193::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Wed, 30 Sep
 2026 14:57:07 +0000
Received: from DB1PEPF000509FB.eurprd03.prod.outlook.com
 (2603:10a6:10:550:cafe::23) by DU7P190CA0005.outlook.office365.com
 (2603:10a6:10:550::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.15 via Frontend Transport; Wed,
 30 Sep 2026 14:57:07 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 13.74.137.176) smtp.mailfrom=ziehl-abegg.de; dkim=none (message not
 signed) header.d=none;dmarc=pass action=none header.from=ziehl-abegg.de;
Received-SPF: Pass (protection.outlook.com: domain of ziehl-abegg.de
 designates 13.74.137.176 as permitted sender)
 receiver=protection.outlook.com; client-ip=13.74.137.176;
 helo=eu21-emailsignatures-cloud.codetwo.com; pr=C
Received: from eu21-emailsignatures-cloud.codetwo.com (13.74.137.176) by
 DB1PEPF000509FB.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Wed, 30 Sep 2026 14:57:07 +0000
Received: from DB3PR08CU002.outbound.protection.outlook.com (40.93.64.86) by eu21-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Wed, 30 Sep 2026 14:57:06 +0000
Received: from PA7P264CA0203.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:36d::13)
 by AM9PR02MB7185.eurprd02.prod.outlook.com (2603:10a6:20b:3b4::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Wed, 30 Sep
 2026 14:57:03 +0000
Received: from MI3PEPF0000848E.eurprd03.prod.outlook.com
 (2603:10a6:102:36d:cafe::5d) by PA7P264CA0203.outlook.office365.com
 (2603:10a6:102:36d::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.15 via Frontend Transport; Wed,
 30 Sep 2026 14:57:02 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 91.26.242.194) smtp.mailfrom=ziehl-abegg.de; dkim=none (message not
 signed) header.d=none;dmarc=fail action=quarantine
 header.from=ziehl-abegg.de;
Received-SPF: Fail (protection.outlook.com: domain of ziehl-abegg.de does not
 designate 91.26.242.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=91.26.242.194; helo=mail.za.ziehl-abegg.de;
Received: from mail.za.ziehl-abegg.de (91.26.242.194) by
 MI3PEPF0000848E.mail.protection.outlook.com (10.167.240.149) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Wed, 30 Sep 2026 14:57:02 +0000
Received: from vEX02.za.ziehl-abegg.de (10.1.201.106) by
 DEKUN-EX01.za.ziehl-abegg.de (10.1.200.169) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.49; Wed, 30 Sep 2026 16:56:47 +0200
Received: from localhost (10.1.200.37) by vEX02.za.ziehl-abegg.de
 (10.1.201.106) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.61; Wed, 30 Sep
 2026 16:56:46 +0200
From: Paul Mbewe <paultyson.mbewe@ziehl-abegg.de>
To: <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>
CC: <linux-serial@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<hugo@hugovil.com>, <tobias.gannert@ziehl-abegg.de>,
	<joachim.knorr@ziehl-abegg.de>, <david.laight.linux@gmail.com>,
	<Maarten.Brock@sttls.nl>, <crescentcy.hsieh@moxa.com>, Paul Mbewe
	<paultyson.mbewe@ziehl-abegg.de>
Subject: [PATCH v2 RESEND 2/2] serial: sc16is7xx: reduce TX refill rate with half-FIFO trigger
Date: Wed, 30 Sep 2026 16:56:28 +0200
Message-ID: <20260930145628.566535-3-paultyson.mbewe@ziehl-abegg.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260930145628.566535-1-paultyson.mbewe@ziehl-abegg.de>
References: <20260930145628.566535-1-paultyson.mbewe@ziehl-abegg.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: DEKUN-EX02.za.ziehl-abegg.de (10.1.200.170) To
 vEX02.za.ziehl-abegg.de (10.1.201.106)
X-TM-AS-Product-Ver: SMEX-14.0.0.3239-9.1.2019-30228.007
X-TM-AS-Result: No-10--7.994300-8.000000
X-TMASE-MatchedRID: FAFsbbC+0kDXawTAU03F+/BDRnTpQBJavFCXgblZQIoQf0y6Uur6EURs
	ySutOPIkvFNe78tGA8O7iReq4gAXGCM91zH2uCFQCcgav7k++ok4U3ArDcUbSQgL4L25Ji1Uq4L
	JrY97XCSF55Ys0o/JbJA8HdpwQWyHgY+AXXZiDlff2e6voWUFXjLai1uomgFqzFKdnOXKuLS2Tk
	AkMLY2gSLQ8cY2BUid29L7Igrv/gEtCqyfTZdVd47tl5XBMfR0XpSxZKDDzFhHRgtlV1ORVFrtD
	485nSLlM6XvJqjbqdOUSxoeePz2Y9i9ssa715k/GQ+246vupTBs2NNIWkvEKNrm58Qo63ifGeae
	xNfJrdtHr0g+R+j4elwJ057ljktmGJuJCTvCT4liyuQOZndK/eaOLqeqLSisdtS6bgciNVA07NR
	XVZxhneIgmAa8mqZkqUBxX8Yc3H9EMi8SG5dDPQ==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--7.994300-8.000000
X-TMASE-Version: SMEX-14.0.0.3239-9.1.2019-30228.007
X-TM-SNTS-SMTP: AE92F539B870DF53E60CF34A7B851E75BD944EFAEE374C4844C424B5DDFB06022000:8
X-EOPAttributedMessage: 1
X-MS-TrafficTypeDiagnostic:
	MI3PEPF0000848E:EE_|AM9PR02MB7185:EE_|DB1PEPF000509FB:EE_|DBAPR02MB6231:EE_
X-MS-Office365-Filtering-Correlation-Id: 2776b6a1-7b96-4e51-8490-08df1f0318e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|1800799024|376014|23010399003|36860700016|82310400026|11063799006|10067099003|56012099006|6133799003|18002099003|22082099003|13003099007;
X-Microsoft-Antispam-Message-Info-Original:
 IhWx+6xTpCK761NHhnOOE9Yw98WBcILw1GZGrrUyElcVr/MGoj48Y3gnZhOvisAjJRQpJ8xWedyfaRD6OVcMA+QR2dm62zYz7xD9VrcRvXDTY8ljBpTwQEzwh1Yd82iTLiXYMKVAh9lYSkm1DOlXGYEmJEr329ed3+eMLvKKdE/LqA3WuN5GivI4OCbyeUNgWbfE8vGgiJo2rNpCkYM0eNlApv8PAWMXzdTweoT2CnIIIuIR3wedJ+i0yJmqkwuiVXLHxikNAQPaqKBMM0HnPyQzPYvsMnuchL3GcW7yQP7lbW8bqOSCSF0yW6IUp798SdGhD0nEzdus0msXPi1HMdKSSZ3Qqj8tgmDj/VidvfAtiyGDbFPAm2jfhb5oG0vRXTUaE9+1K/n4/N8LqtOY0hRZdjcq2B33G+J63FlNp5nDNDG1rwliIbZgR8ZW+rRoeCF0zik6CPCokVnw530G3R10wUfEWhcCWUZ9O89XbQ/JMxQuqUm3tOn0wA8pNE8tII8OrwQ2Oejs4I4Mo560rYCFyhfgEoylagBjlIfzNIO/RA/aS3VU7Fn2W+W4sidV3QkrNnwMgZc4Znx/2oKQ+kmv8mkXrOjXEXWnPWAR99Mfys9yoW0opdC6kfu9JRiHswkDqonCWZd1+GveKJZoJandMlVKvH1IXunWNGZ0Wcg=
X-Forefront-Antispam-Report-Untrusted:
 CIP:91.26.242.194;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.za.ziehl-abegg.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(36860700016)(82310400026)(11063799006)(10067099003)(56012099006)(6133799003)(18002099003)(22082099003)(13003099007);DIR:OUT;SFP:1102;
X-Exchange-RoutingPolicyChecked: gp1A2OuUIJC5MHF10G7pxzNJR3Mk3DscJuEkUtJtq4ulJHX/5e5+8okzWj7pHJnll44bDxPhFexqtNWHf1/YqVSSck3bHyXXZYIc+Pb37UZpyOgbB4lX6g613DvDVtAKGNAmcLxHIMo0F1jG0LTpLD1FB2tooQTNiOMwKtIk7I3Kx0Rf04todYaF//GiPCsSjYIKUtBFjnAN6gJTeJizemuodOGjsygmocIVaDnG/nx4nJargyOc7+hEVQeFiuKpLOM3AeNxcXjrmRwg2Lujy3aCdOs8iG7kzKBPXPNt8GkcPv4Kx/G9xIaebsFABrvGgeRb88bGEtiZKyifwVGQNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR02MB7185
X-CodeTwo-MessageID: b31661b0-5a69-48e8-8e64-5eaf5f64bf20.20260930145706@eu21-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB1PEPF000509FB.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	8df4dcf3-9c9e-4d61-410b-08df1f031644
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|35042699022|376014|14060799003|1800799024|82310400026|36860700016|22082099003|18002099003|6133799003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	xonBYgYPCo5xhXn1WtWQX5Vl5j1KJOcdjcW+vElg509eyFld/3UvZhgOA8Z5joPOdkx+pvd37YAooEC3w5UUp1rZZV6JLVvc05w1XusNlzHg8EFzDsTHJ/FXPAs75cSW9e8R69YHiB7iznhiOMnB5zCLcq/fLFB5UO/t06W1ajaZdwQY0RxcBw+jhQv7kM4KRgnAESN7i7AaVrC1bIMrBlZp9ulGc/BjUTUdaQhG5AY0QnjywtDZkNnuWzuljSvq0XOohftJDyRkwNIZ5/aRORNXls7HM8QEYLj5AfsBe5efM62amIX+sVQvTnN6FyDN3EBtIr0sS1cx0BQ0SAhVqyGDGZw5WpdZaaZ/0cRlFFPGxgOBDlwLWW2v9yar0UYZYhuFjHynxtavVGrvDauAty5MUbiRT6AZpKJPQbkOzDcsWJxJamvzen4nKjh513CrlSzmMsmmNYneGRLYV6ecyEJnsJqTrggc126jnpwPAaoooFeg5e5CGBLUsyqvpWrgA0VX+Ztq4Sj+B00lVdOpo81G7itxn0Z/AZn0mRrVTzA7A7vaJXEgqm1lMQt/akTWVdtKbc+rVu9Szk98WZAwoIKbGpVURZi3m2IminIBumpsf06RrTT8qKn3MrLCw/USepysH9MErCXbT/pC4Biah//QVwLAgNvDXIXqe9GGvt0=
X-Forefront-Antispam-Report:
	CIP:13.74.137.176;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:eu21-emailsignatures-cloud.codetwo.com;PTR:eu21-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230040)(23010399003)(35042699022)(376014)(14060799003)(1800799024)(82310400026)(36860700016)(22082099003)(18002099003)(6133799003)(10067099003)(56012099006)(11063799006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	AqPgSIF1+cWSluEmFhSEkGBxfeFZC4k5d9Hxjqvm3/qimaLET6SCOTKsiaurFhONCBv/l/XW0pdqx/JfaBT3tRkNRzQS+wwyTB/yc6jepMP3h3p8c15gK6rhfLQbWrokjDCAQpPzGTsyv0Gxuht5831zjQe8cP3e072DgvN15eSyqNOkzn7v6SmdW0YZjsFM5Le122hnrlwThYX+CMmRwb6lScM17YAZvkp9uluxpX3iUcvHufko8KLCPwsVFq/PK+tgS8sh3j/GPdYeeOet3vfI8AZpK95Irl/e4ItQbZ/wS8Y7JBCFd2PDLsffk9C8nYLVJ14XctvZ9WrlC1cqPf0AhkpHrs02AUgBMJMXQVk3OWFhkBrO7e525wzSEZrTZUC52aaU9+8ad0NSMhZKVmA3+CLEyIIHD0dye2QI/UHwfOsYnFcVopVvrv1Amcgk
X-OriginatorOrg: ziehl-abegg.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 14:57:07.2689
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2776b6a1-7b96-4e51-8490-08df1f0318e3
X-MS-Exchange-CrossTenant-Id: 11a5c065-3ef5-41f0-92f9-a77cbf208c03
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=11a5c065-3ef5-41f0-92f9-a77cbf208c03;Ip=[13.74.137.176];Helo=[eu21-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509FB.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR02MB6231

With the TX trigger set to 8 free spaces, THRI is generated roughly once
per 8 transmitted bytes. At 115200 baud 8N1, this corresponds to
approximately 0.7 ms between TX refill events.

Set the TX trigger to 32 free spaces via TLR[3:0]. This makes each refill
larger and reduces the refill rate by about 4x. At 115200 baud 8N1, the
refill cadence becomes approximately 2.8 ms.

The trade-off is that the time-to-empty after THRI asserts is reduced
from 56 to 32 byte times. The fresh-TXLVL refill loop fills the hardware
TX FIFO strictly below whichever trigger is selected. This patch changes
only the refill frequency and the associated latency trade-off.

With the two TX gap fixes applied in both configurations, changing the
trigger from 8 to 32 free spaces produced the following median values
from repeated top snapshots under the same continuous Modbus RTU load.
Each transaction used an 8-byte RX request and a 255-byte TX response,
so the workload was dominated by TX traffic:

                         trigger=3D8     trigger=3D32
  SPI IRQ thread CPU        15%            5%
  system CPU                44%           29%
  idle CPU                  40%           52%
  one-minute load           2.02          0.99

The datasets contain 547 snapshots with trigger=3D8 and 535 snapshots with
trigger=3D32.

Only TLR[3:0] is changed. TLR[7:4] remains zero so the RX trigger retains
its FCR setting. RX trigger tuning may also be useful, but generic RX/TX
trigger configuration is left for follow-up work.

SC16IS7XX_TX_TRIGGER_LEVEL is used for both the programmed TLR value and
the TXLVL refill-loop threshold, keeping the hardware trigger and the
software refill condition synchronized.

TCR/TLR access requires EFR[4] and MCR[2], which are already enabled by
the TCR setup immediately preceding the TLR write.

Reviewed-by: Joachim Knorr <joachim.knorr@ziehl-abegg.de>
Link: https://lore.kernel.org/linux-serial/20260623112225.82386-3-paultyson=
.mbewe@ziehl-abegg.de/
Signed-off-by: Paul Mbewe <paultyson.mbewe@ziehl-abegg.de>
---
Changes in v2:
  - Split the trigger-level change from the stale-TXLVL refill fix
  - Reworked the change as a TX load-reduction patch
  - Corrected the trigger-level explanation: trigger=3D32 reduces the
    refill rate by about 4x but reduces the time-to-empty after THRI
    from 56 to 32 byte times
  - Added post-fix A/B CPU and load measurements
  - Used one constant for the programmed trigger and refill-loop threshold
  - Left the RX trigger unchanged; generic RX/TX trigger configuration
    is deferred to follow-up work

 drivers/tty/serial/sc16is7xx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.=
c
index 1f7e98c2b570..296079c16fdb 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -216,6 +216,6 @@
 #define SC16IS7XX_TLR_RX_TRIGGER(words)	((((words) / 4) & 0x0f) << 4)
=20
-#define SC16IS7XX_TX_TRIGGER_LEVEL	8
+#define SC16IS7XX_TX_TRIGGER_LEVEL	32
=20
 /* IOControl register bits (Only 75x/76x) */
 #define SC16IS7XX_IOCONTROL_LATCH_BIT	BIT(0)   /* Enable input latching */
--=20
2.43.0

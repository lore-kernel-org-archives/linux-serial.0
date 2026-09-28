Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11023141.outbound.protection.outlook.com [40.107.159.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2C48492E2C;
	Mon, 28 Sep 2026 09:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790588806; cv=fail; b=jjV8HNM08GjQ8B9IJoFSAhhlZ17yG1yr1rMYadH09uImKDudljHZ9OpNYcnrpcBCc+Bv7F15WXUFygwSzVS8SQJmybVcChZy7Kaiwf966CswZeC5Q6OTiEsdEpLWrQqt7pyfECKtTkwcvYHMjjqS8bHrgOzcpZo+DOPpMc17BgA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790588806; c=relaxed/simple;
	bh=OB1pSAP9s7n4/VntMxs9RSWZbFakNqKzN0qqG23TjSc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hZLwRyoCJvqRHfLbVjRYLFlGfcc1rf1ojzK0RM6H+H2+V7yA/zdmxodnGsIBt/BCfNxSwNJFP78uir+wA3nLFWa4J9i8mcShoucdIBv9ZyNWc+zGQqnBnSC02EyROWdYxwnRWqCZBlThlRvPrYcqzbc0K/yqM+NK/veedzIHtIQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ziehl-abegg.de; spf=pass smtp.mailfrom=ziehl-abegg.de; dkim=pass (1024-bit key) header.d=ziehl-abegg.de header.i=@ziehl-abegg.de header.b=eHPuPDwK; arc=fail smtp.client-ip=40.107.159.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ziehl-abegg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziehl-abegg.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ziehl-abegg.de header.i=@ziehl-abegg.de header.b="eHPuPDwK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B9beZR1ehexSCZo2SqMBvNcZC/VLRPh7FPg8zot1P6u+BqyKt/qF5Hxy0PrT2YDlxAYnfkdF05TEwfgp4PC9r7JA7G3shdfhzKN59VyachX9Fh74WdcPOlmATrKmFMiHFgjZbz+7NdvjGwMwgRi0y3n+CDexXOzKbeDT51DLqfJkpnCEwDVp0cSF1iJWIouJZjvtNo2WvXX3OChiJ5BTqbzKPUa1OyGKGs9n2AJztwzHK1HgFkuQOa1jcRjhV/sZivhueynObqKFWd7fIJGpgc2o4McYL1sno9tK517dX0fJo419QCSmmy6/oA+h4vK8ajJgv3OQiBO5TqT8zNCXYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZHnEZAFbjPF3QGXF8wjCD6r9bj5N3OCHG0Skfnep1IA=;
 b=D2SxkGi1ESiFm+Gb8YgjDjZdmPHmDW2bRSr541Tkj8TuFl/ITSS+09Wmgtx9Dy35r8cG5zVRHv7ZtHqukc4OTNsbFuDkLE3vkGlS8dj/L2jil9vvhSMpr0cHN2TdEE7ma6RwtPWXSS+E1q4+uNMiFDsM0oIygIN+z/G+ssTfWec5rDwWs6TtTovga2rnGOHryP6szxuvAwVw1TVUDD1xe6HLCE5RmlV538dyD+8VFTEuyge2V8ul3bKdosk6RFIYSMuRv+Iw2FU/Ltz5XsMx5hTDbJl5HO/cXEwif60cI9v1c87zD0uFCddgLi3fHKsb62Zm+sKl9VBFEv+3xhVZOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 13.74.137.176) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=ziehl-abegg.de; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=ziehl-abegg.de; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziehl-abegg.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZHnEZAFbjPF3QGXF8wjCD6r9bj5N3OCHG0Skfnep1IA=;
 b=eHPuPDwK/nN23uhMt1lOuoS4qnFCX3Ib7YN4Ec9R1KHmjxo0KhxSbD7LLeCjrAw9jKP+twZ9MLbXIh5aohhESC1rLM6v8YKHK6HNP5xBohRMcvWRMhHDCsE1BxHRGqGPZulGmM+1HUAEhLvlIa0kq+KbbwspWGzMn5XOOxx/AwQ=
Received: from PA7P264CA0154.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:36c::17)
 by AS8PR02MB6824.eurprd02.prod.outlook.com (2603:10a6:20b:255::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.23; Mon, 28 Sep
 2026 09:46:39 +0000
Received: from MAD0EPF000008C0.eurprd05.prod.outlook.com
 (2603:10a6:102:36c:cafe::29) by PA7P264CA0154.outlook.office365.com
 (2603:10a6:102:36c::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.23 via Frontend Transport; Mon,
 28 Sep 2026 09:46:39 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 13.74.137.176) smtp.mailfrom=ziehl-abegg.de; dkim=none (message not
 signed) header.d=none;dmarc=pass action=none header.from=ziehl-abegg.de;
Received-SPF: Pass (protection.outlook.com: domain of ziehl-abegg.de
 designates 13.74.137.176 as permitted sender)
 receiver=protection.outlook.com; client-ip=13.74.137.176;
 helo=eu21-emailsignatures-cloud.codetwo.com; pr=C
Received: from eu21-emailsignatures-cloud.codetwo.com (13.74.137.176) by
 MAD0EPF000008C0.mail.protection.outlook.com (10.167.241.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Mon, 28 Sep 2026 09:46:39 +0000
Received: from AS8PR07CU003.outbound.protection.outlook.com (40.93.65.52) by eu21-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Mon, 28 Sep 2026 09:46:28 +0000
Received: from AS4P192CA0004.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:5da::12)
 by PA4PR02MB6688.eurprd02.prod.outlook.com (2603:10a6:102:d0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.23; Mon, 28 Sep
 2026 09:46:23 +0000
Received: from AM7PEPF00000057.EURPRD83.prod.outlook.com
 (2603:10a6:20b:5da:cafe::1b) by AS4P192CA0004.outlook.office365.com
 (2603:10a6:20b:5da::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.24 via Frontend Transport; Mon,
 28 Sep 2026 09:46:22 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 91.26.242.194) smtp.mailfrom=ziehl-abegg.de; dkim=none (message not
 signed) header.d=none;dmarc=fail action=quarantine
 header.from=ziehl-abegg.de;
Received-SPF: Fail (protection.outlook.com: domain of ziehl-abegg.de does not
 designate 91.26.242.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=91.26.242.194; helo=mail.za.ziehl-abegg.de;
Received: from mail.za.ziehl-abegg.de (91.26.242.194) by
 AM7PEPF00000057.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.21.496.3 via Frontend Transport; Mon, 28 Sep 2026 09:46:22 +0000
Received: from localhost (10.1.201.87) by vEX02.za.ziehl-abegg.de
 (10.1.201.106) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.61; Mon, 28 Sep
 2026 11:46:21 +0200
From: Paul Mbewe <paultyson.mbewe@ziehl-abegg.de>
To: <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>
CC: <linux-serial@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<hugo@hugovil.com>, <tobias.gannert@ziehl-abegg.de>,
	<joachim.knorr@ziehl-abegg.de>, <david.laight.linux@gmail.com>,
	<Maarten.Brock@sttls.nl>, <crescentcy.hsieh@moxa.com>, Paul Mbewe
	<paultyson.mbewe@ziehl-abegg.de>
Subject: [PATCH v2 2/2] serial: sc16is7xx: reduce TX refill rate with half-FIFO trigger
Date: Mon, 28 Sep 2026 11:45:27 +0200
Message-ID: <20260928094527.3413351-3-paultyson.mbewe@ziehl-abegg.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260928094527.3413351-1-paultyson.mbewe@ziehl-abegg.de>
References: <20260928094527.3413351-1-paultyson.mbewe@ziehl-abegg.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: vEX04.za.ziehl-abegg.de (10.1.201.108) To
 vEX02.za.ziehl-abegg.de (10.1.201.106)
X-TM-AS-Product-Ver: SMEX-14.0.0.3239-9.1.2019-30224.004
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
X-TMASE-Version: SMEX-14.0.0.3239-9.1.2019-30224.004
X-TM-SNTS-SMTP: 1A5A298E5604041AC04A481155E86ACEC2E382FD9947BEA1189BDA6E7CD55E282000:8
X-EOPAttributedMessage: 1
X-MS-TrafficTypeDiagnostic:
	AM7PEPF00000057:EE_|PA4PR02MB6688:EE_|MAD0EPF000008C0:EE_|AS8PR02MB6824:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f93ee5f-d0ed-4afc-7c2e-08df1d4564ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|36860700016|376014|82310400026|1800799024|23010399003|13003099007|6133799003|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info-Original:
 k7yvDMw3vyximRbYbQDvD4zWo27QAucqOFDoEOh11e2YQ9aCTf8IuR4/e6O9Z3xAeu7U3HdiGSMRPeDbMSIwxUEkkBYDj+NUDcIqRelrcmAXQQSnkPPCuxczx1ny7gsrmbSRGTeF/orWJWsCghfX5yWS5F0/z6SttJzKBrIe8M3ZDwCt0o/2VXt1CDpmRA7xFjIkFNYWQMK80h7KUlrUNIou4LPEzXvm6LiroKBYOKrMhoqZ2E03u0zWADtYaDqqawswpyBJKy13002G9kxZyPlEgyS+ev6Ldp976iaBPRSWEyYa4wwDtRszenRwJj/9wVzBszVVDlb7GWLPQGjerOb3XSnQFCqDRCV/GFqQ4q3zOE1B+mrVMXLnh2wVli2h3PBaSE5fqtqk/Lr6tPLm2kC5ETh7zeF5Da4kLofOq5kzngYzz2CiGEnqkE3ugQFyuuYZgPxqJC5LB5YXBY8y0iqa1s4rSja3VZbpbJaq4cdfBs96bEc03V3tB5JU6JBaIVI+xE5ItSJvtsOmcBBw53JTwiAH1WKgBZPe11R+a30iGIUoJFoNP8ke36333e/OUMDRSaewqh9TsIjaeuq7yCm006sP2x9Dl28swjVB8OuH+71CkndXpyu7p+ocz2HXiRdDANU2hIituYRZSkK0Q388PEgS62TfKE8DGax6B2g=
X-Forefront-Antispam-Report-Untrusted:
 CIP:91.26.242.194;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.za.ziehl-abegg.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(376014)(82310400026)(1800799024)(23010399003)(13003099007)(6133799003)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-Exchange-RoutingPolicyChecked: nD9z8R/kA/Dv+KHRwQ/iu5fRDOVwUAMydAhB5kzRV5+aX/4jPH30HOwDC5hdoXa5qNOMQbjKvdfqMCBGWwu5yzikMWm6HzW/f+4sHeUo+s0S0xypsdV0Dg84VuhER+TC1vg2oDaIvOrqXUy2nTlF5FXWUCfn1Ne2dWZTDwNr+ve3AchwHGUaSdndhvpG5iR/M3vafn5d0ESlKxAiLZRG9+lorj3iSYFaj9fPGj6yOJjOmz5XnqBzx6bjzJ3nj8BKVYAbvfGWY5Dmom520ZYAh65M1tNL6XpjsxZHwkphe1+j2HQE+92Vl8V4wo8W75iKJ2afO0D6CduguF1LQUK1DA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR02MB6688
X-CodeTwo-MessageID: 47608016-0b7b-420c-885e-42fa9e424213.20260928094628@eu21-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 MAD0EPF000008C0.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	d39f53bc-e8f9-4ba9-aa72-08df1d455b20
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|35042699022|82310400026|14060799003|23010399003|36860700016|13003099007|6133799003|10067099003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	AeFiUXfUKCytzQWaHh66tKXJc85tgNXa0GQ9NUq3aK6TSqPE/EkTv3z3WITpX5pLC2k6qIKmzAEqMOYXua0EqZ5uZvGsqla/8uwNu1bATh7AGhVNTG6PU6t9Rx/wIu6VD489per8/82g1+yt62hzX79YB+5zXJLH+Crj4l6RQ641Dj02kjY+pPWAho2qdfWurQMPvltss/wsn853XzYvuELoCwlmocWSLVxjASoRqaovoAvuLqHg1JmPgcGkg/NsjYgfLEm4zoy1jYdPpyc1dcbGdG4eNUP3cpFaY2ckHBf445rpmKFZxvs6pQ1zDa8MKNCNskdfirOcowJlGHec3BF2P+Y8BakD15WvT7lFRii6VrDqPHdogx74FdW1ScvTr8xm4gz7h2qarhIlEqelX+OhGEt5cJ9T0PMcJtSWragNGZFfjbyCiHvyxDEKjJR4S2Rtvf2tal3tVYZraADdwGqvH7q77Kg8n75Jwqvk08F2NUGi6wXSK2HmfZPVz3Fe7ja+uLEWOiKdf7lIaSPwbO8dDqhmxyylWjZhhu1KD6Wdcd1IPRxrfpPee6cJ71PotDtuMyNJht2CAKxJ1nKwigXQb3pqkefyDepOj7MJYfkwy2/n7DHQkA2Ljedb8BFGrAzA7nsN0adXz6P+W/x5TwzJCqdrVNZQU95aK4wxtuA=
X-Forefront-Antispam-Report:
	CIP:13.74.137.176;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:eu21-emailsignatures-cloud.codetwo.com;PTR:eu21-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(35042699022)(82310400026)(14060799003)(23010399003)(36860700016)(13003099007)(6133799003)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	UTiglAbrGav0yxE0P76s3JjBN57CUE5fH/nDQYSvVSfd9ZRlqmUBa4g4/BD2q4NCGaQkEiD0QLEhJHU54+OP58dw8uqjKEx43fQvPuC6ytuJ8iHDR1OXUycXEDQBRaZEBeQhOhyNAJGKsPZSU6ry5kRU1RLMAnH7eCfWQFhthp73AEQfvLGN8g1qE5YilFKX/eo1LXHtKr3mVrPFfIED1zKsI7P+A7emBNo8W/fFczbdEzXVJSOoaNC2tTeZvRbSReXaxpii3gIG/fXmGaLotuI1bqcU5mI+a4PcDnrTZIwo43ReDzPRAtNrXqzyoeayLTJf8F4sb5JbYNfbi/QMk+ihOaaCUO9DIPQV+0IwrnoYsLs7iIuvYGzfueJflS9H1T8/AW1hjEbkuMh2Z8zqgecebexIzYx7vFGm54QZIWGzzNkRrUhOPNQHUI09Y8AV
X-OriginatorOrg: ziehl-abegg.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2026 09:46:39.1223
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f93ee5f-d0ed-4afc-7c2e-08df1d4564ed
X-MS-Exchange-CrossTenant-Id: 11a5c065-3ef5-41f0-92f9-a77cbf208c03
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=11a5c065-3ef5-41f0-92f9-a77cbf208c03;Ip=[13.74.137.176];Helo=[eu21-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MAD0EPF000008C0.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR02MB6824

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

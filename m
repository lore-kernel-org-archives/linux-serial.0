Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11021118.outbound.protection.outlook.com [52.101.70.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ABD94266A8;
	Fri, 10 Jul 2026 12:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.118
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783687402; cv=fail; b=fSLG8G45UgBZKbixgrdcNmPk/k9kp05kJiWrJZcvriyatKJlEfpdQYePvNosvgmaI9o8+XOzDQ6/65X36bo/TQb4nEkhKVTKWEQTYRkFHiDXmtP4+HE9eBv97uxVTL8BE86dIVoeQQolNWAir+V2hNAJd3Gn48fJbKqtLPlTG0g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783687402; c=relaxed/simple;
	bh=hEjyRYVEkY0mv8Zq3EKwbODQfLpOr/AH3Kt36J+WJfE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=opVhsgO+LrCLnPYR1MklRnkbKKycKXRRYQ4jS/hyqZOZtusmXj3YK53cSJBClRQ6XEkOlRdFtvQlAWqD9wKlNX9a8r59bDf/rxWxoAz5WKggTtaCfIAGGbaclCqqXvIY28cObht7CaQisDCrIQdQLxozqvrK4C3z55dm6V7tqhI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ziehl-abegg.de; spf=pass smtp.mailfrom=ziehl-abegg.de; dkim=pass (1024-bit key) header.d=ziehl-abegg.de header.i=@ziehl-abegg.de header.b=j1fzNkEN; arc=fail smtp.client-ip=52.101.70.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ziehl-abegg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziehl-abegg.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ziehl-abegg.de header.i=@ziehl-abegg.de header.b="j1fzNkEN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VBnmPEUOzq4jSt8FX7xKlCwoPIcbNO9mfr5kh06hvPZa7HVSmmp5lfYAPCTv9hKaHGL6FfjaAsF5Lx+jU9Rh1iqJ618ikNYl279AVCmLefhvq8VRj/vciBVlkMzUaU2PBTS0cGnRRzeLtqkYTH5KaJh2XpBpl7CipSG9fTw5I0qe6s2kswyVcRXc8GdKufgz78JhAQUCfJQyb4J8038M0HCgjm+unnwxJvzZqeVdly51yjPGZufRzuD48T5AxBqLx9IjdB+7uHiFaUAApny2bQtF08pyYmTPMonfSk+aSZ958SBMXTL1PC4ZZs4+pP0PVnjrI2qNZTZZGIpEEumLlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hEjyRYVEkY0mv8Zq3EKwbODQfLpOr/AH3Kt36J+WJfE=;
 b=AojLwlStAsVYLyFiziJk8kBvsxoVHAYt5oI9dqMOKVTR2f3YxWxWyRo1T1ZiODmUMjPaF4qgYKlpLr0B17dLMtWX87EWL0H4miuD7V13lbl280qcwXYdWTjoHaWFO6DlU4DE1QIyjoE9CwFpaAoVez2EmUrxq9kY9Y6zptoVvK2xjgCgwcOpcuJxqzHjP+RJe5A3Nsv89kwUSrQo/5DSiJhGWK9iGD1rEiCNGwNFN0YWMWHM3d8b+qBeiIbG8FWutNV6p8T59EtjNnoyhC4KUhljqwre4SqFrYOCK5662hjq8AnVOcWb4fowLGPYrUrXaVz5IcdauaMA+akiLT+Ufg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 13.74.137.176) smtp.rcpttodomain=vger.kernel.org
 smtp.mailfrom=ziehl-abegg.de; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=ziehl-abegg.de; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziehl-abegg.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hEjyRYVEkY0mv8Zq3EKwbODQfLpOr/AH3Kt36J+WJfE=;
 b=j1fzNkENceASB+dxT6ssotg51NQC/P+y2Du1z65KnO1SY7sSvkk8GDla4UphrBEXobNmG6b39Mo0lIgn5/iAJdguj3cm1z9Ow4eAzRydeMKizR5dUxyeE69ECoCGSjnTjhuKYk5wvet2fuJ+QHTSZn2/Ue4SqMIcqQ64lrz0N2o=
Received: from AM9P192CA0005.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:21d::10)
 by DU0PR02MB8167.eurprd02.prod.outlook.com (2603:10a6:10:31f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Fri, 10 Jul
 2026 12:43:15 +0000
Received: from AMS1EPF0000004C.eurprd04.prod.outlook.com
 (2603:10a6:20b:21d:cafe::70) by AM9P192CA0005.outlook.office365.com
 (2603:10a6:20b:21d::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.10 via Frontend Transport; Fri,
 10 Jul 2026 12:43:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 13.74.137.176)
 smtp.mailfrom=ziehl-abegg.de; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ziehl-abegg.de;
Received-SPF: Pass (protection.outlook.com: domain of ziehl-abegg.de
 designates 13.74.137.176 as permitted sender)
 receiver=protection.outlook.com; client-ip=13.74.137.176;
 helo=eu21-emailsignatures-cloud.codetwo.com; pr=C
Received: from eu21-emailsignatures-cloud.codetwo.com (13.74.137.176) by
 AMS1EPF0000004C.mail.protection.outlook.com (10.167.16.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Fri, 10 Jul 2026 12:43:15 +0000
Received: from GV1PR07CU001.outbound.protection.outlook.com (40.93.214.99) by eu21-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Fri, 10 Jul 2026 12:43:14 +0000
Received: from AS9PR06CA0138.eurprd06.prod.outlook.com (2603:10a6:20b:467::24)
 by GV2PR02MB12339.eurprd02.prod.outlook.com (2603:10a6:150:367::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.17; Fri, 10 Jul
 2026 12:43:08 +0000
Received: from AMS0EPF00000194.eurprd05.prod.outlook.com
 (2603:10a6:20b:467:cafe::77) by AS9PR06CA0138.outlook.office365.com
 (2603:10a6:20b:467::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.13 via Frontend Transport; Fri,
 10 Jul 2026 12:43:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 217.6.247.99)
 smtp.mailfrom=ziehl-abegg.de; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ziehl-abegg.de;
Received-SPF: Pass (protection.outlook.com: domain of ziehl-abegg.de
 designates 217.6.247.99 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.6.247.99; helo=mail.za.ziehl-abegg.de; pr=C
Received: from mail.za.ziehl-abegg.de (217.6.247.99) by
 AMS0EPF00000194.mail.protection.outlook.com (10.167.16.214) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.21.181.6 via Frontend Transport; Fri, 10 Jul 2026 12:43:08 +0000
Received: from localhost (10.1.201.87) by vEX02.za.ziehl-abegg.de
 (10.1.201.106) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.61; Fri, 10 Jul
 2026 14:43:07 +0200
From: Paul Mbewe <paultyson.mbewe@ziehl-abegg.de>
To: <david.laight.linux@gmail.com>
CC: <Maarten.Brock@sttls.nl>, <crescentcy.hsieh@moxa.com>,
	<linux-serial@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<gregkh@linuxfoundation.org>, <jirislaby@kernel.org>,
	<hvilleneuve@dimonoff.com>, <tobias.gannert@ziehl-abegg.de>,
	<joachim.knorr@ziehl-abegg.de>
Subject: Re: [PATCH 2/2] serial: sc16is7xx: set TX FIFO trigger level to half FIFO to prevent underruns
Date: Fri, 10 Jul 2026 14:43:02 +0200
Message-ID: <20260710124302.504636-1-paultyson.mbewe@ziehl-abegg.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260707185025.2645b7b4@pumpkin>
References: <20260707185025.2645b7b4@pumpkin>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: vEX01.za.ziehl-abegg.de (10.1.201.105) To
 vEX02.za.ziehl-abegg.de (10.1.201.106)
X-TM-AS-Product-Ver: SMEX-14.0.0.3239-9.1.2019-30058.007
X-TM-AS-Result: No-10--11.131800-8.000000
X-TMASE-MatchedRID: 6otD/cJAac0ovbYeSj1r+dwK3aKXLlLA48GqN2zdnsmBaX4iQh46DzTb
	Z6srEVh3Xzc5ale1cdlfSHsavrpa7o7c1MxzsflBCffN9El9NwNxVc+u5bPwgAjFKQ2bn+vAw5n
	Zy2X+Nx4LMaf9rmZofTyazTdxuZuUrq8WPqaDgOoJyBq/uT76iZSIYuRjwBnjtvxIJM7kv15eZn
	3eMfUCs3ijlWmcvjCXNb8bCdFYsNwn1eDG1kbD8K3TyHL2jyH2qByXFHB7WqpNbINBwEGUTXB/4
	oLsndtiL2OmPPXeydnGf6tAsIqH/qX1/V5ayeKcES46qCSbf/V8LgjA4u/K55I58E38hpsBcYO7
	LzLWqS4ibGdC+CRqLVYHXldrySG2o6/uGMlWKtit8uyZmJ1Lz0XDYXEz/0KWMYYlSzIV5tMUrUS
	G8AuOzQ==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--11.131800-8.000000
X-TMASE-Version: SMEX-14.0.0.3239-9.1.2019-30058.007
X-TM-SNTS-SMTP: F53B9D56A4A1EA6FD51C561A6D14E6B652C599731C2793A4018D87F5A8C5A98B2000:8
X-EOPAttributedMessage: 1
X-MS-TrafficTypeDiagnostic:
	AMS0EPF00000194:EE_|GV2PR02MB12339:EE_|AMS1EPF0000004C:EE_|DU0PR02MB8167:EE_
X-MS-Office365-Filtering-Correlation-Id: c4f2858d-9472-415c-561b-08dede80cfa7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|36860700016|1800799024|82310400026|376014|23010399003|18002099003|22082099003|56012099006|11063799006|3023799007;
X-Microsoft-Antispam-Message-Info-Original:
 efhnPpOq4ntqIYEFLyufOS5bSlcD3UaRPdUAEUQkDJTFV8b39fmKsaGeX8Ys8B9zvCwK5Yv+k+9Zhu2Sk2C7KLBarGacFIA4JNFkw+prcr+kSiKGpePrHJ1aXoYZT93lHU2F/9UEBOC+mHivOgSRaLIsCAhaZS+94YwuZ4B8aPAJ7t1OOl+tqpdGqfNUGa/mnDb0Nv9K9atraVjILkmM5Eqhdz1CParRgSKw0Mr1SuAaeuEm44+rU65DIFfwEm3c5/m1cOQewcnoNStDYWz4sRk4SYUmgq4KfZY97Yce0a6fbr6nyPrVWEeULUKhw5icv0Upyi+0lGKkNASjrOEYPCQfWf8EKykjcKW58wXMky+29kV0p3OvvvCBZsBSPIiX6N1wL/Qybizoxlp6BXVQ2fTStn/Ru4uYhvycfq1tpzsEDZIkTrJn9s+o56vHN9W7qhCVxpuA2nLafzbCMBoBWOFD8dK54ePIYAWFfAmO0S2Y59JOdwd8A31ofECCJvrVLNJetjyNMY0uradHVUQ6qG6e3w6Okce2rrWkUYzOVVqYsUzNAQcscYyU1H/0nZ/7UIZN36L7S5ti2nMUud8RUm93j2FPV3FaB7I8GjZE15agnOWXqOA8r5LxQ6V7p+nusHumrqYOoNAc+jTIjhe08JO43LmNUUIEIPhkx/g3NPBpeL79M0x4HGNq2R0G3S4bosAfbMahIA+bvMKLY+1sLg==
X-Forefront-Antispam-Report-Untrusted:
 CIP:217.6.247.99;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.za.ziehl-abegg.de;PTR:nix.ziehl-abegg.de;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(82310400026)(376014)(23010399003)(18002099003)(22082099003)(56012099006)(11063799006)(3023799007);DIR:OUT;SFP:1102;
X-Exchange-RoutingPolicyChecked: eki3irhgH+tqN9S4aZTr4gOpNRuvpnIr3KwInIVXQsfLM0TRA9n4EOUE7pNuo73Vh0+krrK5FzQ4eGPGeaWoHDPZg6DvnlMvd4Frcn5P96GkD51/8khFG02Pki7Ex30/VUh4AMoSWEU2PsqBQ6arYK4huVIo5R1Xpsa2kUpR5tuRICfQ3eHt55r64X9garbKI6zdP8YXyGjvCW2lMCPn/yqUCcwfn4ybtJjssavAdKP97W1N3nUgeuatpeORDdjP5JTyHAYcPNwWYEOxH2p0dY2aMQMxe+A/8GHEu0v6eD6V62inUfighawVH4koxnPOt1dS1peqI+LWoNSpIjspxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR02MB12339
X-CodeTwo-MessageID: 77c3dd74-0492-4d95-938c-5db41a3ae0df.20260710124314@eu21-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS1EPF0000004C.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	d0c6f2be-52a4-429e-eded-08dede80cbb2
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|14060799003|35042699022|23010399003|36860700016|82310400026|1800799024|376014|3023799007|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	bzLpI9OW/cVNvarvcCQ9PFkpl3cRzlQ6YzTIwiLJtenhvR5qJKtLh5OnDhVmx91UQ3oJsSPOjH6da2CUiuGRJZwkjR77oJLFPG6cZZhZzD7dnF7NyN2PSconzC+O4IdcL5Xp3bm2c4HBea1iDLnHsYuzofjJPkvbijNfSll3PbNm+xE9A1B/oXsj1Tw/1HsN9U5WWzG65SkdFxv51ZJmCT8ZyREbmXv8HG5nMAvZ7Y+z7KJC4irI66gcFsBpUCSyz2p0eJH/Y2/+Fp8kah28FRRRjNtr0BAWHsx5/O8TIU4VMNq74NbnNW3SoPmPaK+Xw7kOHyOq6FbMj2bNu8z/FIhmH/5z4CeozjMBXySMfPe674bXJx4H1I9zR88KBxeG1f6o0dkAy4eoewe4T1EyZFUmTE1cTrXWpgey5I2pZ+7TJseBBo+55PRq+pFzZv5Gcp+oPHtc59PGshMttn5FiWYEEiabTp68Gn/PomO1NO7dIRXb622HjVAihPlKdhchgBByD8E7FMW2E9BjB+mhnkT9eaDhirLZbjG0GE6dDpw7OL//6XrGHRvpxxwIqkRQM/MhR5lIPC5DtTsn4ZiWIQUkjCyLe4Ls5aN2Qgafxo7qC4RHVqoG1Iq1CL3sx/1VVl3yWueGTvjSmBvNA9q58nOhGZk9nXBhmKSnw1jOlsGNl8oGbhxQyNalpTZ1OnrwpTtehQ8b3BTTHeWLNCpweg==
X-Forefront-Antispam-Report:
	CIP:13.74.137.176;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:eu21-emailsignatures-cloud.codetwo.com;PTR:eu21-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230040)(14060799003)(35042699022)(23010399003)(36860700016)(82310400026)(1800799024)(376014)(3023799007)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	hpJ3VpYKYHJBGWITb2q+pPdm9TX+cb4OE1iSMqOiRLyKGbXbfXTLYai4S6Medey+bYY1nig1nn/DKu4opX/NFoeThWnepIq9T0w301HleKkDTeqHgHpRORmupCJ+S0zMYMiOLJGkRZLvlWSODG19Yl6nB5fZSMyGM1RpdPRVeV7ybsIGY6l6YF2V1iEuaqCVhC0IP7XcamUE9FaOYxkZt1fyBN0lNQLLLcktDeRrrRvf7dyC19CzdccJY1Sp29PwpvmRD/bHWCLk3LUcQKyyz6Z56AQTyOfKWVDJjDakuqSl3PIAPhkB/0fxqVwIxwXxwhvte9DwR8SQI3sgaj+wzedKftj069I1eGHLI95RkOxM6ud9V51Ms3DsxuVcJTcNq+WQe8dCYo1+oeYb8OXgwpJ+J9X56suShVVflWykch5yDRY5uyu/BRf24s8bTr6y
X-OriginatorOrg: ziehl-abegg.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2026 12:43:15.3102
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c4f2858d-9472-415c-561b-08dede80cfa7
X-MS-Exchange-CrossTenant-Id: 11a5c065-3ef5-41f0-92f9-a77cbf208c03
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=11a5c065-3ef5-41f0-92f9-a77cbf208c03;Ip=[13.74.137.176];Helo=[eu21-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS1EPF0000004C.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR02MB8167

Hi David,

> Does filling the tx buffer clear the IER bit?

No, filling the TX FIFO does not clear IER[1]. A THR write only clears the
pending TX interrupt condition/IRQ line, not the enable bit; for SPI this
is Fig. 33, "SPI write THR to clear TX interrupt".

During active TX, sc16is7xx_ier_set(THRI) is therefore just ensuring an
already-enabled interrupt remains enabled. It may be worth cleaning up
redundant updates later, but I would leave the current enable/disable polic=
y
unchanged for the underrun fix.

> You might also be able to leave the tx interrupt permanently enabled.

THRI is already kept enabled during an active TX burst and is only cleared
by sc16is7xx_stop_tx() when the xmit FIFO becomes empty.

I think leaving it enabled while idle is a separate question. Since a THR
write clears the pending TX interrupt condition, an empty software FIFO mea=
ns
there may be no write to clear a pending TX interrupt. With a level-low IRQ=
,
that could cause repeated wakeups while the hardware TX FIFO is empty.
So disabling IER[1] when the xmit FIFO is empty still looks like the right
policy. The cleanup I had in mind is only to avoid redundant 1->1 updates
while TX is already active.

> Did you try putting the second scope channel of the spi clock/data
> to get the scope to show you the pattern of transfers and the latencies?

Not yet. I scoped the RS-485 A/B output and the INT pin, while ftrace timed
the TXLVL read, FIFO write, and post-write TXLVL read separately. That was
enough to identify the stale-TXLVL under-fill. Capturing SCLK/SI/SO would
still be useful as an extra correlation check.

I am testing the re-read/top-up change now and want to get it validated on
another setup as well before sending v2. I will include the results in the
v2 cover letter.

Thanks
Paul

Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11021088.outbound.protection.outlook.com [40.107.130.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E98B348FF91;
	Mon, 28 Sep 2026 09:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790588793; cv=fail; b=I7ixyxlb1J3uAwTRCX0Wa3ONIimrYuVLE313LwwzqmGFFl9hnRd1/Rg8/krsSG7nTV2P21Fpt07YPWVJzV7TQo1itzWNZnBSq7LCcju4JYa3wLk+Eb7eJPVX0ZRvSFv6wDmzek+wOhzVGQszqMOwCCRLN9efekLJ7CcQH/atj9Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790588793; c=relaxed/simple;
	bh=DdKZe/QphWitYlvNomc+vjzE7nD4qqvG5s3/IPW3GP8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SWtiqPP8g17cdOfP5l8eIXMOxqnxuirPZNd/ysZeMIzIaV/5mX7+nSliuFk4nMSK6DT/tT6MHwH2Ww+W5WcummnrlgklYOfqmZLXLZpnHgmvzntp/jUhsz51Kfk7UWjGdRVqQGSSsTWabw40GZvNBqIzT65k5O+2o0MxwcGfv14=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ziehl-abegg.de; spf=pass smtp.mailfrom=ziehl-abegg.de; dkim=pass (1024-bit key) header.d=ziehl-abegg.de header.i=@ziehl-abegg.de header.b=XHsz4sKv; arc=fail smtp.client-ip=40.107.130.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ziehl-abegg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziehl-abegg.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ziehl-abegg.de header.i=@ziehl-abegg.de header.b="XHsz4sKv"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zg+5NTmVLMHQzCh19bwKR9DhanB6nNXRvcB0l2Q4lQHi8MzTs53Jg5qrPg89KDNGjMxIwj3YBUtJA7S0AQItvE3ve+HlcqqURPXivjWUoDQc099Ld8hIWh+oJ36UoJE9hctN0NAkTE7jmsrsAbSXMhZP9tlrI29veDxUEhFQzSYfz2IsquKh9c7tiRf60L2Tkb0UEQVCBFLtPApWnlmyiv+Rv4k+g//5v1RKNe4itsvZuVasaQ1H/qxaK/1DclmmIgUkVscItxhHMfEfetZdfjSsP3ynv21Mre7sUBBA9gf5QfFoLXbVhGcbeYFfd4njC7zTZCNnsMaKNG09rlrNNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CWk/uxoJCDluDMphfIeMc1zLTsGPUlBQ5NdQ+PCxfSA=;
 b=jUVQrzQ83xIkHZvFOqa3HmBmcjp6mvTwA52EMLzYVw35JHx4QGqhTUs/He7BZEHvGPUcHzZCZD8BZS9s/5QHp1KQ6gbO67DrVBkrylwAZVqRZNGwcdqKyNVWDBfkZmDFtgG+P2zDK+rIjc+r43RyczxMvLGa91t8opr0L/Iju0837crR3HRfkvQq4oMFFfr62UOERvEry7L4OLsTSiu5vKwkWfUvN2kPXxq6WJK+0XF4y42IV5+/r3RLIWm13KjmSaooF+gQhjgGVQ7+8d2OZS4HCOC2Su9ucwYro9DfQeSm5KaQGve0JelaXXsoV+ftX/N3DT07BILUqQSY2jQWsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 13.74.137.176) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=ziehl-abegg.de; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=ziehl-abegg.de; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziehl-abegg.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CWk/uxoJCDluDMphfIeMc1zLTsGPUlBQ5NdQ+PCxfSA=;
 b=XHsz4sKv0x5TFt+9nZrPOrqsfm82H+f2ReeP61HFHpSq8osnTTjO9s9f/KKGghg+nRiAvBPx8GIOBps2lmlq5r3IGuW7kAtj8Dp0mAU1b8FvGa8KcgS5/GoFDN75qW3Vmm3nHtRLQXOH5lN4kdYB6Skmtr976o1Jxs+DO+PTYac=
Received: from DUZPR01CA0141.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bd::28) by BESPR02MB12295.eurprd02.prod.outlook.com
 (2603:10a6:b10:ff::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.23; Mon, 28 Sep
 2026 09:46:26 +0000
Received: from MA3PEPF00000404.eurprd04.prod.outlook.com
 (2603:10a6:10:4bd:cafe::90) by DUZPR01CA0141.outlook.office365.com
 (2603:10a6:10:4bd::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.14 via Frontend Transport; Mon,
 28 Sep 2026 09:46:25 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 13.74.137.176) smtp.mailfrom=ziehl-abegg.de; dkim=none (message not
 signed) header.d=none;dmarc=pass action=none header.from=ziehl-abegg.de;
Received-SPF: Pass (protection.outlook.com: domain of ziehl-abegg.de
 designates 13.74.137.176 as permitted sender)
 receiver=protection.outlook.com; client-ip=13.74.137.176;
 helo=eu21-emailsignatures-cloud.codetwo.com; pr=C
Received: from eu21-emailsignatures-cloud.codetwo.com (13.74.137.176) by
 MA3PEPF00000404.mail.protection.outlook.com (10.167.241.149) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Mon, 28 Sep 2026 09:46:25 +0000
Received: from DUZPR08CU001.outbound.protection.outlook.com (40.93.64.66) by eu21-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Mon, 28 Sep 2026 09:46:08 +0000
Received: from PA7P264CA0182.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:376::16)
 by VI0PR02MB10766.eurprd02.prod.outlook.com (2603:10a6:800:202::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.23; Mon, 28 Sep
 2026 09:46:04 +0000
Received: from AM7PEPF00000054.EURPRD83.prod.outlook.com
 (2603:10a6:102:376:cafe::4a) by PA7P264CA0182.outlook.office365.com
 (2603:10a6:102:376::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.23 via Frontend Transport; Mon,
 28 Sep 2026 09:46:04 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 178.15.18.66) smtp.mailfrom=ziehl-abegg.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=ziehl-abegg.de;
Received-SPF: Fail (protection.outlook.com: domain of ziehl-abegg.de does not
 designate 178.15.18.66 as permitted sender) receiver=protection.outlook.com;
 client-ip=178.15.18.66; helo=mail.za.ziehl-abegg.de;
Received: from mail.za.ziehl-abegg.de (178.15.18.66) by
 AM7PEPF00000054.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.21.496.3 via Frontend Transport; Mon, 28 Sep 2026 09:46:04 +0000
Received: from localhost (10.1.201.87) by vEX02.za.ziehl-abegg.de
 (10.1.201.106) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.61; Mon, 28 Sep
 2026 11:46:03 +0200
From: Paul Mbewe <paultyson.mbewe@ziehl-abegg.de>
To: <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>
CC: <linux-serial@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<hugo@hugovil.com>, <tobias.gannert@ziehl-abegg.de>,
	<joachim.knorr@ziehl-abegg.de>, <david.laight.linux@gmail.com>,
	<Maarten.Brock@sttls.nl>, <crescentcy.hsieh@moxa.com>, Paul Mbewe
	<paultyson.mbewe@ziehl-abegg.de>
Subject: [PATCH v2 0/2] serial: sc16is7xx: improve TX FIFO refill
Date: Mon, 28 Sep 2026 11:45:25 +0200
Message-ID: <20260928094527.3413351-1-paultyson.mbewe@ziehl-abegg.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: vEX02.za.ziehl-abegg.de (10.1.201.106) To
 vEX02.za.ziehl-abegg.de (10.1.201.106)
X-TM-AS-Product-Ver: SMEX-14.0.0.3239-9.1.2019-30224.004
X-TM-AS-Result: No-10--24.656000-8.000000
X-TMASE-MatchedRID: YD/6842MUCNWBEdhLwMbrFmcWIT2GKzJJeVHOyz36PTCnG8raj995953
	NOvzenyJigGtWsFDX+6g41+zJRYGghO0aVCCMKduftn7iRH3dJZ+rvFZ7FWrXE1sg0HAQZRNo2g
	J/wTTTH6wDKLbeTXawA7m5LW4hzVWAfRvC6P/9/nHGHox1te4oB+HTcaJMBgqz8XLYGqis+H9tg
	NTBJosaYhqDyppDIJTrhKoScYL834uECRdn8TO930R968WXL3fiWuvX6uqb1o32MNYHthSk6JX6
	Xtt4U61jymDLmVuTjHBnAsKTQpTShdcFSUIoS+mO3Y9BE9+f5Ht08AkgFFynXgwJo5QMsV98s+Q
	8gmXQO3SuhDS+jJWiXVGPf0MaYgPGze83GC3Y4pWQd3myrqg2Q2LmwHT7i+ngc9mXG9bNRR38U+
	52trmLNh5c4TN8zbZXO2SJ/uvWJUlTScbe2l74Ff0czs/wYTp
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--24.656000-8.000000
X-TMASE-Version: SMEX-14.0.0.3239-9.1.2019-30224.004
X-TM-SNTS-SMTP: F713DC5807DCBA749D8B776A5A161DFD63073700180E8127C688B38F3592C4D32000:8
X-EOPAttributedMessage: 1
X-MS-TrafficTypeDiagnostic:
	AM7PEPF00000054:EE_|VI0PR02MB10766:EE_|MA3PEPF00000404:EE_|BESPR02MB12295:EE_
X-MS-Office365-Filtering-Correlation-Id: c26a7676-b1dd-481a-ae6b-08df1d455cb4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|376014|23010399003|36860700016|1800799024|82310400026|11063799006|56012099006|10067099003|18002099003|6133799003|13003099007;
X-Microsoft-Antispam-Message-Info-Original:
 jPFYNiCf4xHBVuLiTppFrvs4xdPa6BCojgUPTrYVZlVsONFKT47gAQ2PqCsP/i8nbjpPKFngihX/tylPUjAGRBDkLgdFaWA99vAbF2/oL2PvE70Ujw3LXFzEjHp76WZPneIZyIA+vn2gZpCubNCzEUzfHYHSAtBbxSUeaSdYYgfw6ZV3U7faq1w/LkL9IWHZO1YVi+oKaPyAoPpLDhZxJLTocrsU4GmPv5umu8Q2YIwDBQyb3KXElZxw8amRd6zP8/vgXHcdU41Jm4YvgjN/rwXx9Uey3q7hYa8ioYqT0hTfvzQrTLw0LLxiaFIYkUkPtExPHLBuHwoSk6lYeKhqltBTo8zdiMoQOWz3sgZ2V4DbrowArsFhwtqcZ+I9qLIiapPvGvorVIXVVz65EHhYNrUvpKVbFd0OwCm09oWdJrcRQObVu/Amgxkkug/7kQVDZ/E556UZo9Om166qHhoQ0fT1nBmezGFdi458GRvn6ptqIMSxjNPg4UWIYnXrGaur0md0Gk5XfEBElx7a1K8Bh4s+riSGBuQFXSQeLHzP7grm8pwyjII0Ri27yr10a6AfbdBdsOggJ1V5JtQcmN+986Z08DtvNbkekDhEvUwWEbUfNra3mrrU0tBnpASgON6Tqp9ExVw+mvlkD1+U5Sz+afFgLu/Xe64pGzvRL3UpeoE=
X-Forefront-Antispam-Report-Untrusted:
 CIP:178.15.18.66;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.za.ziehl-abegg.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(23010399003)(36860700016)(1800799024)(82310400026)(11063799006)(56012099006)(10067099003)(18002099003)(6133799003)(13003099007);DIR:OUT;SFP:1102;
X-Exchange-RoutingPolicyChecked: 5T7jJ9tQ9PezXC5X+Ew0uJJ1TOUT2fdWdT/NHbohVuO0TmWJnGz7+gSAe5Y1ftxRqeVmGIoe+s0/328w/SGbndGnl6pGK/dSj31G8sgHt6GSpIU2k+Pb4BI7ntTqeBKLDak+0s7F0oJPze1ZmLblUmJPbcSncq3G6myz2yc7jfxKntZJNXEPh9UHHKGS5ZRdypayfFR2Xlkf78OYQKlLwNzIwc31TOVJHVCBOy2DnulaaHqY8opj023g6906um7wKMslrpgUTFDnhiGiUO+QJuxBJ34FwEjHbMDDs7OF1V85xdYNCNEtwGY+CYDOyK9NFsimRqG6cexFpWW970pVmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR02MB10766
X-CodeTwo-MessageID: d91dcd42-f1b4-44d8-8a5e-e352fbfd1c99.20260928094608@eu21-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 MA3PEPF00000404.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	0333db9a-dc62-4bdf-9cd3-08df1d455006
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|14060799003|36860700016|23010399003|376014|1800799024|35042699022|10067099003|11063799006|6133799003|18002099003|56012099006|13003099007;
X-Microsoft-Antispam-Message-Info:
	WKW6cUbF3N2xiKRIBbTDTfr42mKuS6dcnAxEvxSq61cf2CS5G0Op6+zj7M0V4TBB4xCPBFLMFwNdmnZqN86GB8YsRorxyAmz4cafZ+yO8iXmQ69JmZf0Gs0TvyMA/BeZsZQ7bLgMz8Q3Iyarm6QrFU5mr+2OcqcQv6J9GemEOdVDNhb3IUvMRaRxUnlEaXS998lecQgRnB8NSVZBHj3fKIgkNwMCxlMkChlrIa7k+OqiRMowyLly+nJIzVDssQgmMzVp/jHNpOjTiBwEZv07rmHw10OJz8eXz7MLgU9IUfiml3kkg5NA7Vp0gFUoVV7qyBIMrGh+fz4LQXXjoIRKZxIO+eH4TJZjdDmWRNLGeIKDEAe5tj5oVD3Z0zh9c3wLpvGJDIMKiQuu2ZyabuzCmMvylDQQr5r/Q5O9Xplu/3/WXrN6Hup8aXC9RKTbSGSBxvpvQXboj3Me5kUMQdqmosQ5yuFJ0oUwzjhu6b6tJ4v/++MXTffAPZzMWJM+LKQ8t6PbVWZldaWkzcjA/xkWRT4zYQKKAYM4OqreZPAucLqLwftfwcAe8vVo/KpVILjwfQhZp1IV89sp/nQy89SAOgqQ10HH7y4RGUZCe9ydG/NqoDAyLohP7+dgSY2I386GZOZcOkSfmMSiHqF5E+6V/lA/uRsdkMuTTLiJS7dDQpM=
X-Forefront-Antispam-Report:
	CIP:13.74.137.176;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:eu21-emailsignatures-cloud.codetwo.com;PTR:eu21-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230040)(82310400026)(14060799003)(36860700016)(23010399003)(376014)(1800799024)(35042699022)(10067099003)(11063799006)(6133799003)(18002099003)(56012099006)(13003099007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	XqjANq6k8yoZOhkB196QFTdPcWeuAoA8dJVq15KFGvSwReDnNyfIHuhMLdagwBSOVWb9RQbVGN61fmQ55Wk5hDBpJEr2mnI+2dnh4THYWuWgfCBZN9C799DMXnsnk/aAwakUVH0qarMCLp/VxqgiL200kqLDXCivXAttrbl++1Hbb+YH2/f9oi/T8zbE2VSVcAx3CH+6ASoctDAo1f5GOTppE+IU/IvQ6tgKay+ZtowYTZc2XP3RaTV7wFxP51hCOJSNEC5nIdBAHUsehyS+Fg9lekszAYQFG1Oe8rQTxs1Ner6h+UFOJTssNMNCx3cK2JK6itAFBIsROi9Q79FEpFuQSHaPUmPzi2GZq1m3x30YL4YoCMN0rKAz3Jse4KwXUidiQHjcp5JaHgp+7zmtVmWx07ZNi6HPCaQ1CrmnbTh2Xg4/W/ZQl5w6VFqLq88t
X-OriginatorOrg: ziehl-abegg.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2026 09:46:25.3519
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c26a7676-b1dd-481a-ae6b-08df1d455cb4
X-MS-Exchange-CrossTenant-Id: 11a5c065-3ef5-41f0-92f9-a77cbf208c03
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=11a5c065-3ef5-41f0-92f9-a77cbf208c03;Ip=[13.74.137.176];Helo=[eu21-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MA3PEPF00000404.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BESPR02MB12295

This series follows the TX inter-frame-gap work submitted as:

  [PATCH 0/2] serial: sc16is7xx: fix TX inter-frame gaps on SPI UARTs

Following review, the kfifo wrap-around fix was resent separately as a
standalone v2 patch. This series depends on that fix
because patch 1/2 extends its multi-segment TX refill loop.

The original trigger-level patch has been split into:

  1. a stale-TXLVL under-fill correctness fix; and
  2. a separate trigger-level load-reduction change.

Patch 1/2 re-reads TXLVL after each hardware TX FIFO write while data
remains queued. It continues refilling until the xmit kfifo is empty or
the hardware TX FIFO free space is strictly below the programmed
trigger. The hardware trigger and software refill threshold use the
same constant.

Patch 2/2 raises that trigger from 8 to 32 free spaces. This reduces the
TX refill rate by about 4x, but also reduces the time-to-empty after THRI
from 56 to 32 byte times.

The changes were tested with SC16IS752 over 1 MHz SPI on an i.MX6ULL
single-core PREEMPT_RT system, transmitting RS-485 at 115200 baud 8N1
under continuous Modbus RTU load. Each transaction used an 8-byte RX
request and a 255-byte TX response.

For the benchmark, "both TX fixes" includes the standalone kfifo
wrap-around fix and patch 1/2. "Fixes + trigger" additionally includes
patch 2/2.

                         before fixes   both TX fixes   fixes + trigger
                                           trigger=3D8       trigger=3D32
  SPI IRQ thread CPU          16%            15%             5%
  system CPU                  49%            44%            29%
  idle CPU                    36%            40%            52%
  one-minute load             2.04           2.02           0.99
  samples                     579            547            535

Comparing the final two configurations isolates patch 2/2. Raising the
trigger reduced median SPI IRQ thread CPU usage from 15% to 5% and
median system CPU usage from 44% to 29%, while median idle CPU increased
from 40% to 52%.

RX trigger tuning and generic RX/TX trigger configuration are left for
follow-up work.

Paul Mbewe (2):
  serial: sc16is7xx: refill TX FIFO below trigger using fresh TXLVL
  serial: sc16is7xx: reduce TX refill rate with half-FIFO trigger

 drivers/tty/serial/sc16is7xx.c | 38 ++++++++++++++++++++++++++++++--------
 1 file changed, 30 insertions(+), 8 deletions(-)
---
Changes in v2:
  - Submitted the kfifo wrap-around fix separately as a standalone patch
  - Split the original trigger-level patch into a stale-TXLVL correctness
    fix and an independent trigger-level load-reduction change
  - Re-read TXLVL and refill until free space is strictly below the
    programmed trigger; use the same constant for hardware and software
  - Corrected the trigger trade-off explanation and added post-fix A/B
    CPU and load measurements
  - Deferred generic RX/TX trigger configuration

Link: https://lore.kernel.org/linux-serial/20260623112225.82386-1-paultyson=
.mbewe@ziehl-abegg.de/
prerequisite-message-id: <20260928085559.3341419-1-paultyson.mbewe@ziehl-ab=
egg.de>
prerequisite-patch-id: c177f0e42a7122bbb1accf4397c73ccec4eaabb6

base-commit: f0100363d8c374bd8e9ea7c9ba02744f0b802ca4
--=20
2.43.0

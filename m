Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11021115.outbound.protection.outlook.com [40.107.130.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B09273D3CE3;
	Tue, 23 Jun 2026 11:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.115
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782213820; cv=fail; b=CEqmEWVDw35suv9Tk65ia19V/Br1EjgdrRX1QmgjUUAJeMIZgmlQS8L1dTXLrwuEWtAi3YH3capUbeLsm7CUa827xC3ovzrNPfAIMV8pbwdsdgiPs+Jm5nDz95L4SQr7Q903YSBEsP9o9bkcdujaznrn9Ye4i6KF5I8d4EtrlMc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782213820; c=relaxed/simple;
	bh=PhKJWT2T/4JUO1YO1cpz1P8Zr7cVivdi8+ffl0x9prI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oIWSmJWjbrcKcLzTnpp94swbxx9g0EBXDMKVbMD6rwgIpV0xzRP3CIFwv8ncFXMnNuGpWoJM8lo1qefUj81NfExRfracf2kf49qtSXuJF7tXUAh+pVmuxaSS6bronew0E2NwQgwj6HdoY8IL0d352Z06i6ZHVT0TkcksCwILmsU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ziehl-abegg.de; spf=pass smtp.mailfrom=ziehl-abegg.de; dkim=pass (1024-bit key) header.d=ziehl-abegg.de header.i=@ziehl-abegg.de header.b=SiUB6TJ1; arc=fail smtp.client-ip=40.107.130.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ziehl-abegg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziehl-abegg.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ziehl-abegg.de header.i=@ziehl-abegg.de header.b="SiUB6TJ1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m6CnG1cAl/uc6R0t/0eyHiLLaC/M5Vle3dGSmrztvkZK/RJryG+3fUvuxa95OD1sLdpilZTPfGQG5d4xlmdGm+D6ySl4hT+LeevWUWMlHFOcL9iDXpXLD4wgNGSgwsogVAhwV1h/BQbnzF9cdB/ojRTzo6jUSwY8o49nWrR2nsQVr9WhkoAlwWdv0fwDUHEkU5+FrByysV289PJCWYKrD4bDyrGi9uE11P9CjZWexLAAcCiBPCIr9moKwKQI77brBr7TDijJ+lO1EH4sfxYxAi7hYYtt2z0cH+3RE9/pzbwNPlf5AiSC025091jHbJ0vQ3aBaVd2YqWr7CZlutdJMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/2wBzGkXRBReLv8GnQdhr6F+5tWk95wH5Glr/B0ybpg=;
 b=uIfOQFzmd9AtdAeklC6T/hoJt1RQl0Hgit3dBj1yRVQohZBeslelfyeF8Ti0kZQBf00JFPo3rufV9cVKnSmnjQj0uw0jsC9XWfHTDMs4w7VY48evjsc64ez8AWm2v4YhByOnTIFMOAd3bub6D0KdsxP+jS61uZvnfDHWeWmJJKjdSmIl+xc3bsRCDEw+vsqom0ovmUK7Opdyd7rk9RFcnE+sLufD3BawaKtcVxRLESndS31qXhh+D6QjGVXmzDMcQNTsWw4U+Wh3oQp0s37gsHkaSLNaOr+aSGL9f0QgXgh3w7y6lyN30y6xGqTGW9l9Su4KLdMGgvvMUcnvdP/4rQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 52.138.216.130) smtp.rcpttodomain=vger.kernel.org
 smtp.mailfrom=ziehl-abegg.de; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=ziehl-abegg.de; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziehl-abegg.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/2wBzGkXRBReLv8GnQdhr6F+5tWk95wH5Glr/B0ybpg=;
 b=SiUB6TJ12rDeJx3IpKdhoPvxp0PwMIPyYjSRTRnjE7X0JA5NVRT9dIXG01MhSuuKASMb4Fuoc+6l0s8V9Nch6Lq9qWBozvZiKb9FX42l4dGrC9ZNde4wzuW0QZD20SMuJ8JMXhE6pTpV2qjRyFMUvUoyTQhMoKVx3IFHTNHFZTw=
Received: from PA7P264CA0314.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:395::16)
 by PR3PR02MB5979.eurprd02.prod.outlook.com (2603:10a6:102:2f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Tue, 23 Jun
 2026 11:23:31 +0000
Received: from AM4PEPF00025F9C.EURPRD83.prod.outlook.com
 (2603:10a6:102:395:cafe::58) by PA7P264CA0314.outlook.office365.com
 (2603:10a6:102:395::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.20 via Frontend Transport; Tue,
 23 Jun 2026 11:23:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 52.138.216.130)
 smtp.mailfrom=ziehl-abegg.de; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ziehl-abegg.de;
Received-SPF: Pass (protection.outlook.com: domain of ziehl-abegg.de
 designates 52.138.216.130 as permitted sender)
 receiver=protection.outlook.com; client-ip=52.138.216.130;
 helo=eu22-emailsignatures-cloud.codetwo.com; pr=C
Received: from eu22-emailsignatures-cloud.codetwo.com (52.138.216.130) by
 AM4PEPF00025F9C.mail.protection.outlook.com (10.167.16.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.0 via Frontend Transport; Tue, 23 Jun 2026 11:23:31 +0000
Received: from DB6PR07CU003.outbound.protection.outlook.com (40.93.64.89) by eu22-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Tue, 23 Jun 2026 11:23:30 +0000
Received: from AS9PR06CA0679.eurprd06.prod.outlook.com (2603:10a6:20b:49c::23)
 by VI1PR02MB6288.eurprd02.prod.outlook.com (2603:10a6:800:190::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Tue, 23 Jun
 2026 11:23:23 +0000
Received: from AM4PEPF00025F99.EURPRD83.prod.outlook.com
 (2603:10a6:20b:49c:cafe::33) by AS9PR06CA0679.outlook.office365.com
 (2603:10a6:20b:49c::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.17 via Frontend Transport; Tue,
 23 Jun 2026 11:23:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 217.6.247.99)
 smtp.mailfrom=ziehl-abegg.de; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ziehl-abegg.de;
Received-SPF: Pass (protection.outlook.com: domain of ziehl-abegg.de
 designates 217.6.247.99 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.6.247.99; helo=mail.za.ziehl-abegg.de; pr=C
Received: from mail.za.ziehl-abegg.de (217.6.247.99) by
 AM4PEPF00025F99.mail.protection.outlook.com (10.167.16.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.21.181.0 via Frontend Transport; Tue, 23 Jun 2026 11:23:23 +0000
Received: from localhost (10.1.201.87) by vEX02.za.ziehl-abegg.de
 (10.1.201.106) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.61; Tue, 23 Jun
 2026 13:23:22 +0200
From: Paul Mbewe <paultyson.mbewe@ziehl-abegg.de>
To: <linux-serial@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>,
	<hvilleneuve@dimonoff.com>, Paul Mbewe <paultyson.mbewe@ziehl-abegg.de>
Subject: [PATCH 0/2] serial: sc16is7xx: fix TX inter-frame gaps on SPI UARTs
Date: Tue, 23 Jun 2026 13:22:23 +0200
Message-ID: <20260623112225.82386-1-paultyson.mbewe@ziehl-abegg.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: vEX03.za.ziehl-abegg.de (10.1.201.107) To
 vEX02.za.ziehl-abegg.de (10.1.201.106)
X-TM-AS-Product-Ver: SMEX-14.0.0.3239-9.1.2019-30024.005
X-TM-AS-Result: No-10--5.206400-8.000000
X-TMASE-MatchedRID: gLMW9eIxGuUcP7pp+NW9hB10V8fYzFslZK1SF2R3edgqikrexvmHw+qq
	ko1PXeESof7QzEon7FvtsgpIym2RqL7ldv0N5D1dxxh6MdbXuKDdXycy6rwHov5CEAGScl89fw5
	/fdoSsJBRu1oDF3mkxcq80Y2YbRJTr54JIx46I6QKjLWrARtsc1mur05CscKy0Um8j0thxXcibG
	dC+CRqLQObIzLs3GAWeTKZayz4M/eq2KOMZ6VdFBiFRRcniIvUYNa100HsTEda4lUykSuqS5Wa1
	HTl0YYn
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--5.206400-8.000000
X-TMASE-Version: SMEX-14.0.0.3239-9.1.2019-30024.005
X-TM-SNTS-SMTP: 30C5C7936B601D96E58529DB21172E84434CD1A7D17859073595F2A0992F45932000:8
X-EOPAttributedMessage: 1
X-MS-TrafficTypeDiagnostic:
	AM4PEPF00025F99:EE_|VI1PR02MB6288:EE_|AM4PEPF00025F9C:EE_|PR3PR02MB5979:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a2c07cb-1599-4360-ff2f-08ded119db07
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|376014|36860700016|82310400026|23010399003|1800799024|11063799006|6133799003|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info-Original:
 8OLMHJygIahFpr6R6LKK6RHlTQ3FtHnwvVhrOIHmYFgboJZdgL+2qfDgSqyROTkY554wNQU6vorL529YthxCTiWo00nJPg8Q1O/C+Fm6bANNyla5jna7/jBpETWCjBtYaTbbHFY3ziCUmDudVgseoJyXkvAPYZwtayqEDJtB3b8PResGRdv3A0t2ptinXPz1wXUl6ax7+pCfaB64DpFUtyw/iFyMC7YL26tvde2A/C+URR3g7bQGDUabxuuU+RctsRKWyxI1OqU7LzVk4LwUPaiOHvkCCSzW4bPMA8teEiywzKH2DqbdePetbV74W/2zLQmQONy21dLJ/0WndU2eBERJZzCJ9gz/40uc4HxasbK7uZJIa5CNBfnW5OmwLvkq2jz9zUGiYiE/04Ed357AliMYIiywsPPbDTUb8b8WGGlI8Sgfd9RIW1xBYuDobcFtBFLKloHjPJ64+1nfCkOycGuFFbBo2ikclsE9bjXkCrs9Lzbf5q4dJLpPNOg8potn32sD0eS9fIMWxHmJkAq1QzeuMgXt31mxTRdw83PfDIm9RVbL9TrTpyFicax6jXSoUa21ZgR7RH+ME+g2p1+7H9NEB+MNDIEN6x14OXHTjwXux7SXq4kwJ2vGAhrPJ1zlqbq/xoZlWiVieKOmalqZhpmaQa5gvSraScCI0dnfnHrDtoaBiaimswC2L6Tw9IS0wYDUCR5NR0MQ8ihncE6uIg==
X-Forefront-Antispam-Report-Untrusted:
 CIP:217.6.247.99;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.za.ziehl-abegg.de;PTR:nix.ziehl-abegg.de;CAT:NONE;SFS:(13230040)(376014)(36860700016)(82310400026)(23010399003)(1800799024)(11063799006)(6133799003)(56012099006)(18002099003);DIR:OUT;SFP:1102;
X-Exchange-RoutingPolicyChecked: TySIx20dHpl1PvcVb1YScDqvUO2lMcAnTkH2OAyYrg6cV4pBN6Qk7vOVioppV3ZYjYwL/Z5rpRZSWwDt5FmL3arjDGD2YpvECOlcmESf7Oq+fYD2ud/KsQMnVDiMKIycwsQFN64UhxuwgYS599txUgqv+dtIjDl5nf3U6EII7jjTz/htB8DaXWtPawT54+1GymFL7rU6uoP1rlxgbvTEIJr/FLRuxiC/yOvc/ebQOL+MYBdruMno/GYHdbtC8/R/R7gyV7ssAz/8MB/tc4wu53EOHFoRBIMTCpIqB8P5rgIqOx60i56l/PcfQN3naP/GtTcLn3DBr2M/Bj8QsWrYbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR02MB6288
X-CodeTwo-MessageID: 74f88a90-7309-4d19-8ace-eb39b360a5ec.20260623112329@eu22-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM4PEPF00025F9C.EURPRD83.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	a89cfdef-4abc-4c4a-8687-08ded119d637
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|14060799003|376014|82310400026|35042699022|23010399003|1800799024|36860700016|18002099003|6133799003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	HjXI/YGlBySPB9XI2VAZOKpsW12di5EgQ6Rn8BRZFnGdTJ1Ec+PxDPxpp6XX828gEKqWKR1N5dtkWwr0HjrXT/aEKcfw3aOdOB2IJ4T4ZaY93YOt8SHlseAATaJCGoNw2od78qpUC2JkB+nfB022GUQWiNlYMJru0BCg5Ma4gIg5TqjvRGf12jqB8rdO65PlR+3UVRHW7ysp36dy4O9QSxCIdyzRoqJRxsvoO1dPhl+7HSdlZc8MxmTEGjIs0xftf4desBu7PmJ7bEEYSaosU8guaChpp0lo4Ymcntng18kkdMqibikDHTjUbBRGVaazcnwkWLuRvxhGbxcC+ueV5RUWgW4awj/tnsJnTPRjmb4lbLrO9zvmEE2J8jq59f3LZxC0LJCjP6P3uhPNon5b5Y7Z+ZL7PH3SnQEFfBLfOI2A1j/k2/felNNz4kmBnBGQEVbxPf9iNF1eb7DHI9qGoSvyrG7DtsB+6nL2EYj1mbpRJCs1a7rJql4w6XN6R+wU/TjFVsXBqFML/qb04dJaujJkOMdUb2kjvQijuVG6TwWEO4kljCLp8rJBZ7uzfX0kp3/tTw+TEBgz14X50kNLwcQtoJr1onB6lPZs12J1ROP5Lla5WVdU4i1iCjhiAWTyOYGZcdFSbuPjIh396qnGxyhhto8LEODuOKfC+Z582LCoSW1AH0ZVfnjgVM+DmWhrdLhaVKJuNyV4s7Z+AgBnYQ==
X-Forefront-Antispam-Report:
	CIP:52.138.216.130;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:eu22-emailsignatures-cloud.codetwo.com;PTR:eu22-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230040)(14060799003)(376014)(82310400026)(35042699022)(23010399003)(1800799024)(36860700016)(18002099003)(6133799003)(11063799006)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	1NFljzob3Gp820ctEKj3qqF2I8OgSk7quS8ecSeBdgP3FushGUTNZUVQqEOTejzM3Rc+wrwaZXurXh3mWHf4Lw/qvdDl6WmNp3ryjEyPQ50+Hjk/GIU/UQo72r0rKiB/Oa1opb8rQIYaR3h65blFKsGNG1zE+I00Sk//Rs/H4HfDPySaXguRXzeJLU7t8uYuyqdpvL2gmfXvs6i2rhzGjZtcTjrMj/3Vxqxkc+gbTvWgXx53BsWNIwmhremTiFNJSy1Aqgzi7KL/gDfVSnzjywydXgbC/huYc5f3k1qKiXiOxoOXIov7KexespsmMYzUdDXFZy3A5yNtJGGvnyi1CYo3JwSLXrjIaFj4TjmVWJMnKr7Q8qFRha/LQqmFBLS5c3EkOkaJwIincCGHNcF0K75GNvW9kBGjZQO7+NgmtMnBd9plATST1SRBzCsn38W4
X-OriginatorOrg: ziehl-abegg.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 11:23:31.1335
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a2c07cb-1599-4360-ff2f-08ded119db07
X-MS-Exchange-CrossTenant-Id: 11a5c065-3ef5-41f0-92f9-a77cbf208c03
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=11a5c065-3ef5-41f0-92f9-a77cbf208c03;Ip=[52.138.216.130];Helo=[eu22-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM4PEPF00025F9C.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR02MB5979

This series fixes two related TX path issues in the sc16is7xx SPI UART
driver that cause visible inter-frame gaps on the wire, breaking Modbus
RTU communication.

Patch 1 fixes a data loss / gap caused by kfifo_out_linear_ptr() only
returning one contiguous segment of the circular buffer. When TX data
wraps around the kfifo boundary, the remainder is delayed until the next
TX interrupt, producing a silence gap that violates the Modbus 1.5
character-time limit.

Patch 2 raises the TX FIFO trigger level from 8 to 32 free spaces via
the TLR register. The default trigger of 8 causes excessive SPI
round-trips on slow single-core hosts, leading to TX FIFO underruns
between bursts.

Tested on SC16IS752 (SPI, 1 MHz) on i.MX6ULL driving RS-485 at 115200
baud. Oscilloscope confirmed both gap types are eliminated after the
fix.

Paul Mbewe (2):
  serial: sc16is7xx: fix TX gap caused by kfifo circular buffer
    wrap-around
  serial: sc16is7xx: set TX FIFO trigger level to half FIFO to prevent
    underruns

 drivers/tty/serial/sc16is7xx.c | 24 +++++++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

--=20
2.43.0


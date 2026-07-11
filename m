Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11023089.outbound.protection.outlook.com [40.107.159.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D71339280D;
	Sat, 11 Jul 2026 09:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783762990; cv=fail; b=Rgfl9vV1h9bYUjvh8mxoMfg7BdEMDvmZB52ZWC0unkJs4+e6a7lwwwqp8sKbU0qnv5D1UGZQxeMPUFod9cTxb2qjArAUF8uG3UQgGll9kxSS6hrlR1UC9FqnVPUk+bPSmo5RMTjkvbP6K+h/vOtYHTgEB690wQ1EYJPC3Ot+P4I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783762990; c=relaxed/simple;
	bh=iYatCvYizulhfEAWsfH42GJ/+8ULZG8VVzp3hsXDY2o=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=m/BHcVLQuiUFpL7MrbLd9rpOfHVWAy6y2JN1+AgdPjh+Oq3kb1dCRcaYcQ5TnaA8twgZjSLalqasF1yLuOJ/18BEINyrc0k1mHRxIzUXzA8L7ZsMuyaixyOjqCgL/eShHhz4d8HWQUATjP4h1wjKdBlfJlwgyx/EMor5bG7wiho=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sttls.nl; spf=pass smtp.mailfrom=sttls.nl; dkim=pass (2048-bit key) header.d=sttls.nl header.i=@sttls.nl header.b=T2TkdEfv; arc=fail smtp.client-ip=40.107.159.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sttls.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sttls.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sttls.nl header.i=@sttls.nl header.b="T2TkdEfv"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FOHoQhEkMLStfOwn6+fTEX79CoK6BgHKyCx8ZWC9iWio5lq0BrfBVaupmwhhO6zU/jXpePhk1zypPonxJP9Da8DWdxugK8kEeMk6BJsc2aiTlXV7HYEkWh2MEX7iZ4L/QEXAQi6vbM2SB7Lf1qRBzt9Y1A5RjdwBaEyxO0mZLhpFikEyVi1/1brjoLP/H/x5bWiDnTL4cwMT4+PNcaVisxMQn1gZ5HQGFm7zeuBpPqoB8Gj+gjANrP3zwvqnA34emNhPx/s2vjFliCaj22rRVZJK3IY9F9kBQe2iQcQqAMMf5D2BRqUxCrbKYP3+lLq7thEq6MdXJlm43GTConJvIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iYatCvYizulhfEAWsfH42GJ/+8ULZG8VVzp3hsXDY2o=;
 b=G8XJWfSGArViOW5UZabAyU3LBG6qoefn5VuVifmbO2pdHM9T1/OIjRScuiQzZTuzfEPVs5p8G7ijhGUu1QSpTwHT/pAN41ONMfkS8zDSsvuxLkMBtJqsruZ/Bvxg/7wA3bQBn0SaB7vbBomLeZytobNksGh/7ROlWzqto3YDT4HmmnukNgwBKz9M2isxHK1BqYQfkmN3JUP5BcOqDqIJbq83PM8L3aZGlO9PcWHlHjZYSLkjYHhhync8itTVeoZ3Dh+ggheRDm5BZ2Etvm8DsGBq42DkVziiw5MIfx1rsTfhZBL8AzFrx4p2FONQQFEQefq67ytrdEXyGQUBerQVNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 20.93.157.195) smtp.rcpttodomain=ziehl-abegg.de smtp.mailfrom=sttls.nl;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=sttls.nl;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sttls.nl; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iYatCvYizulhfEAWsfH42GJ/+8ULZG8VVzp3hsXDY2o=;
 b=T2TkdEfvC4LzTkeZbp065EHipDLJiXRIeMvsUMbtDaWcefzrcz+I5k9n073QpSEFZAAfsBGGQVM5m1jOced1GMwIXNRe5A/wQKyJmGOeynj7tyvnk6FXkdXL7mdLsON1V3RzXqSvesfAROgiNRCv88xYJXYA9BTZWiKVqytROTR2KYz/kUJ5PLZ7gcs5A4cO/e8tvnG6SjiqDaAiy3GXVri2FzcJ7dxzsvEprcDKOq+QjWQ0yVMThYxzQvL87HBvxF1RY1p4Onlh5q4PecxwfaVememRcTMu+WeqMFkPOamKjkOrr2XYO1l3q2Nj/qN6Hry/gCMxsvnsxisgPnC+tA==
Received: from DUZPR01CA0212.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b4::18) by VI1PR05MB6973.eurprd05.prod.outlook.com
 (2603:10a6:800:182::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.17; Sat, 11 Jul
 2026 09:43:02 +0000
Received: from DU2PEPF00028D0E.eurprd03.prod.outlook.com
 (2603:10a6:10:4b4:cafe::80) by DUZPR01CA0212.outlook.office365.com
 (2603:10a6:10:4b4::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.18 via Frontend Transport; Sat,
 11 Jul 2026 09:43:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.93.157.195)
 smtp.mailfrom=sttls.nl; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=sttls.nl;
Received-SPF: Pass (protection.outlook.com: domain of sttls.nl designates
 20.93.157.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.93.157.195; helo=westeu11-emailsignatures-cloud.codetwo.com;
 pr=C
Received: from westeu11-emailsignatures-cloud.codetwo.com (20.93.157.195) by
 DU2PEPF00028D0E.mail.protection.outlook.com (10.167.242.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Sat, 11 Jul 2026 09:43:02 +0000
Received: from AS8PR07CU003.outbound.protection.outlook.com (40.93.65.50) by westeu11-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Sat, 11 Jul 2026 09:43:01 +0000
Received: from GV2PR05MB11941.eurprd05.prod.outlook.com
 (2603:10a6:150:2cf::21) by DBAPR05MB7078.eurprd05.prod.outlook.com
 (2603:10a6:10:179::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.19; Sat, 11 Jul
 2026 09:42:59 +0000
Received: from GV2PR05MB11941.eurprd05.prod.outlook.com
 ([fe80::86e3:136c:737e:e29a]) by GV2PR05MB11941.eurprd05.prod.outlook.com
 ([fe80::86e3:136c:737e:e29a%6]) with mapi id 15.21.0181.010; Sat, 11 Jul 2026
 09:42:59 +0000
From: Maarten Brock <Maarten.Brock@sttls.nl>
To: Paul Mbewe <paultyson.mbewe@ziehl-abegg.de>,
	"david.laight.linux@gmail.com" <david.laight.linux@gmail.com>
CC: "crescentcy.hsieh@moxa.com" <crescentcy.hsieh@moxa.com>,
	"linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"jirislaby@kernel.org" <jirislaby@kernel.org>, "hvilleneuve@dimonoff.com"
	<hvilleneuve@dimonoff.com>, "tobias.gannert@ziehl-abegg.de"
	<tobias.gannert@ziehl-abegg.de>, "joachim.knorr@ziehl-abegg.de"
	<joachim.knorr@ziehl-abegg.de>
Subject: Re: [PATCH 2/2] serial: sc16is7xx: set TX FIFO trigger level to half
 FIFO to prevent underruns
Thread-Topic: [PATCH 2/2] serial: sc16is7xx: set TX FIFO trigger level to half
 FIFO to prevent underruns
Thread-Index: AQHdAwLMAOuYhCbC9UaQhkHW0WDA6rZMFloAgAAVUoCAABJ2gIAAIw8AgAAY2QCAAqq0YIAJxgMAgAAQ/QCAATFtAIAAnzgAgAFenICAACZfgIAF7DcAgAAuk4CABGEcAIABRxjA
Date: Sat, 11 Jul 2026 09:42:58 +0000
Message-ID: <GV2PR05MB11941C5497C984B966D15FC9583FC2@GV2PR05MB11941.eurprd05.prod.outlook.com>
References: <20260707185025.2645b7b4@pumpkin>
 <418f9ae5-8827-475c-b465-1271a784fbf1.bc56e27e-ecd8-43ae-bb87-75bfd472a28d.445910ff-4335-4942-97c3-f799a0bef2e1@emailsignatures365.codetwo.com>
 <20260710124302.504636-1-paultyson.mbewe@ziehl-abegg.de>
In-Reply-To: <20260710124302.504636-1-paultyson.mbewe@ziehl-abegg.de>
Accept-Language: en-US, nl-NL
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sttls.nl;
x-ms-traffictypediagnostic:
	GV2PR05MB11941:EE_|DBAPR05MB7078:EE_|DU2PEPF00028D0E:EE_|VI1PR05MB6973:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b0f335a-ef8d-4c10-8bea-08dedf30ccef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|10070799003|23010399003|18002099003|22082099003|4143699003|38070700021|6133799003|56012099006;
X-Microsoft-Antispam-Message-Info-Original:
 reO7/qD/DwFq+Y21uTXRvn1KZaIePK1SoKUP/MAS+qGho9m6OQKHSCOYtdQF4QrdCMZHzhJB9DO0nkfDGU+FJ/aIaq+UKX5RLaSMhJ2ST7yQVZZMM/v8OIssfsjAs/uFhxZC7QrzVplsAhkvdwX14Ip3UhavcrLjfIBWpMjgFUjSy/2jGXDN23zw0HYrGjMzhe81uzPEFq1MX0vrLeHFIrP16rthbvesSXKqFO3ugF8xmRJNuaO77C/YoX2331YJU1Yr7Lg7orTNyiksUEI2mQCBkTQ/fbszkXbzK7AXNL8Ya912NH1vB/qcTQiP8314o/AlyG566JKOHFryIaaV2mnGmkDvyVBOr1CkO3s2eVBr8mHGJ3fmN4pBmJQ8Ekp0JAz6st5NRxivWNzyhizsu1sw5pyNKLOv7xqD/YxrWPYRtzVrOoyqKDgV223r88waBI0R9vXtvvf4w7H3rWUcqi6sYiJpvu8gbeyW49BQMoQBz8XV45MrZI4S1Y/SP/HI3yHxmibVkiJ60fPiCof9VOxa2O6YEcZa3LUGBkI25MwMlms27B1VDI9ANlsnzF7vW0jFPitdjhaVd0yxs4GXTADQ5tNH6pCszvPxXyyIj5OhRgCn+zPUJ41Y9T3A8M8USLAtkH/kZbjfYwXTH/gWDKRnxx4BZPwuEl/5yh7p6dS6qqP0TDeKaz+Iqj2ptXgjVsXTcB6MJPOJ04YeLa3xZOa7x9oh+qeVWrSRDPss210=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR05MB11941.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(10070799003)(23010399003)(18002099003)(22082099003)(4143699003)(38070700021)(6133799003)(56012099006);DIR:OUT;SFP:1102;
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: PwF3ZNcS4xg2fHxFMhh5l92JSogAy89bomx6WS1S/b+tiZq8h7ykd+TTwzTZytdPMOZ2TKhcioTNaSmEg9Vj9qa+PFcFrWhyV8zbhipmwMae098Tr3uMj7U99q4NK9UE8qLF0DHmKo4Vak4W9szI3qwvr4E6xnI2Sj8PUci4roNtunuzvfHmU0hZw3n9v0vc9h1Ln31Mpxf0NORCJXnH1JUQzucHD05ht5KPkUSKXdyRkolW4Hx2Y+0MkUSn8IvgYgZbF3xIjHl+0s7d2w/qnUSrC39aumx6H450KLTIzLOK/XfGx56rJUTWkx/0VCJAppCFxFZdpYYgQ4FWdSZamQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR05MB7078
X-CodeTwo-MessageID: b79ca16b-2b2d-4663-a073-d2e13e36de0f.20260711094301@westeu11-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DU2PEPF00028D0E.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	21a1fcc5-4506-40ea-5bf3-08dedf30caf5
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|1800799024|23010399003|14060799003|36860700016|35042699022|22082099003|18002099003|4143699003|6133799003|56012099006;
X-Microsoft-Antispam-Message-Info:
	ydBakB1QwgwOPGf/TceCa1C80L9UwZZSDOgnLWm4wqv2C7OV4D01xfOHapvqUMr3IBlEVxjLkkT4mBlT138fa7C1i65NgJrchrRBrXx+J2n9NCqyq0o8gB1B2MfYrzVyo+ChyrMjXZkZpY1vwdvvr7+ViYyIilCR2m+8WoIFmhQWeJD1OhWOhzwpr/JcZcseZMxKv78hmVamAlBRpdgd0OlTo6N0PIZVq2kvLOdzNEZBrAk/Ieh2oNAZIPmp4mtbHqyC8POcagzRyMt+COJoR/hkFWDN8w7DR704VuCwwvzP00rFc0n2ggGMI50tFEhqeAGNcyXJRZ3pBmp5q2GSG34nmBNpILvsR5CwZ0sFtJXtDP73Z3aaqzyio1LAk9PRrSs5TV8uBNtI5UWyV5V5dxNoLG4Mc6tGrOcgCbz86dEGqBhzfhhIwSU+AmaLkE48FdvpbMYkOYAHWl5lRV5phialLlXAOg6cZ2eMVMiNQkX3TtiT2nShRh6/E5ySQDci48Yn6Ac5PzaLSG8LFrVtNmuwrziX66C+KiozTrLb93SWyCgKO0hec43/4mQpywObOn48Bj9+qRwzIstUMn3CCxGNlVYCco3dCAiUpqlXcNIPH9Rwq33GvLMGk+xCzY7/1rwvO/bM4u6PF0MtIojVNxyDJk3a7xecop7gWqZ5F5W5MJ4/trISuKZdHJv2zLgxhrFe9KS1b9oWKWvwAqslOA==
X-Forefront-Antispam-Report:
	CIP:20.93.157.195;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:westeu11-emailsignatures-cloud.codetwo.com;PTR:westeu11-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(1800799024)(23010399003)(14060799003)(36860700016)(35042699022)(22082099003)(18002099003)(4143699003)(6133799003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	asTlRicJK6qt9BFNI2PoMeIdZuLHES987g0CZNgQ8fq/AOHReQKaBzOcYjJJHqnKMJyuHZyZ9VSgy2q+kib36GTgnrU1RHYAT94ppKtMOFc2HvZyqyGHiX9+HFAPEKhtmO+x+rA1p/zVIXmkSI9S8RNjzk5NAZMzAKAtbc/intxt1NG5dDFIzfR/jiSyDaiTIC1TVF6uD0RbodYitbgiOed9/NQgHtgRu+/1Fzvc/3ZzXXndOv/hhhogi35Gh+w7CRiGNxNcPrh7u/y95Mh1nbkT8y64FEyR0Td9EmtT3outu4cQn/tU4uRK7pp7U8FGRsVp2mti53q1ksWKNnqbYh6oj4tjUB2vPzpgUJ48U60gh8lVlZyg8vcYkUNvOtTLDfdogUD71xHFZ9XM76b7/7z5PygLA2kMbwXgQ74ApG0obahyGbhM+7gpYc2J5oa7
X-OriginatorOrg: sttls.nl
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2026 09:43:02.1079
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b0f335a-ef8d-4c10-8bea-08dedf30ccef
X-MS-Exchange-CrossTenant-Id: 86583a9a-af49-4f90-b51f-a573c9641d6a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=86583a9a-af49-4f90-b51f-a573c9641d6a;Ip=[20.93.157.195];Helo=[westeu11-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF00028D0E.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB6973

Hello Paul,=0A=
=0A=
> > Does filling the tx buffer clear the IER bit?=0A=
> =0A=
> No, filling the TX FIFO does not clear IER[1]. A THR write only clears th=
e=0A=
> pending TX interrupt condition/IRQ line, not the enable bit; for SPI this=
=0A=
> is Fig. 33, "SPI write THR to clear TX interrupt".=0A=
=0A=
It would be weird if any enable bit in IER would be changed by hardware.=0A=
=0A=
But I consider it unfortunate that a THR interrupt is not active for any va=
cancy level over the selected threshold. There should be no need for a thre=
shold crossing. Still, the datasheet of the SC16IS740/50/60 does use this w=
ording for THR interrupt in IIR (my emphasis):=0A=
=0A=
"Transmit FIFO empty (FIFO disable) or TX FIFO *passes* above trigger level=
 (FIFO enable)"=0A=
=0A=
And also the following indicates it is not a level detector:=0A=
=0A=
"Re-enabling IER[1] will not cause a new interrupt if the THR is below the =
threshold."=0A=
=0A=
> During active TX, sc16is7xx_ier_set(THRI) is therefore just ensuring an=
=0A=
> already-enabled interrupt remains enabled. It may be worth cleaning up=0A=
> redundant updates later, but I would leave the current enable/disable pol=
icy=0A=
> unchanged for the underrun fix.=0A=
=0A=
I'm not so sure this is a redundant update, because the register is not mar=
ked volatile in sc16is7xx_regmap_volatile(). So I expect the IER register n=
ot to be rewritten. But it probably does unnecessarily wake up the kworker =
thread.=0A=
=0A=
> > You might also be able to leave the tx interrupt permanently enabled.=
=0A=
> =0A=
> THRI is already kept enabled during an active TX burst and is only cleare=
d=0A=
> by sc16is7xx_stop_tx() when the xmit FIFO becomes empty.=0A=
> =0A=
> I think leaving it enabled while idle is a separate question. Since a THR=
=0A=
> write clears the pending TX interrupt condition, an empty software FIFO m=
eans=0A=
> there may be no write to clear a pending TX interrupt. With a level-low I=
RQ,=0A=
> that could cause repeated wakeups while the hardware TX FIFO is empty.=0A=
> So disabling IER[1] when the xmit FIFO is empty still looks like the righ=
t=0A=
> policy.=0A=
=0A=
I agree.=0A=
=0A=
> The cleanup I had in mind is only to avoid redundant 1->1 updates while=
=0A=
> TX is already active.=0A=
=0A=
As stated above, I expect you can save CPU cycles, but no SPI write.=0A=
=0A=
Kind regards,=0A=
Maarten=0A=

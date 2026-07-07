Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11022099.outbound.protection.outlook.com [52.101.66.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEBE6379991;
	Tue,  7 Jul 2026 15:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.99
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783436649; cv=fail; b=b8PAjcW3OBEnWqM+YvQikKlLLAgfhjMdijHLhTege7lymvLnKPtT0VaOTH0Q70h42FyuLftqd+xHuYeVueY41qnPlNLFI2VS4YQof7fklvpxRvh3FhBOqNxl26h3kvgDbjHIotcAutM2xAdJFZG/JIzHuJ38wPgGOEo4ov7jMpg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783436649; c=relaxed/simple;
	bh=Cr8m/h+R64NHPqZ1obrz7ZO6vSX3oCNIHpeU1rkKDgc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LeMDscSVX15gffUNj5R4z1dyQbDsLFOG4cbOJKyTPr5fghyGprgBzRWVwC+EkLL+GLzRD+rf0XwvZYUReJ7IrDC1U+Td2Xsp+N88nDNRh/UR3NORnd/InreN99fl3d0A38aVChoVsaqwDFQU5Wu8/8LqzETF7fnklOguuu/5/RM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ziehl-abegg.de; spf=pass smtp.mailfrom=ziehl-abegg.de; dkim=pass (1024-bit key) header.d=ziehl-abegg.de header.i=@ziehl-abegg.de header.b=Hcu0jz/P; arc=fail smtp.client-ip=52.101.66.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ziehl-abegg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziehl-abegg.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ziehl-abegg.de header.i=@ziehl-abegg.de header.b="Hcu0jz/P"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IsbGhUECvsefvaEzoswJRVqJ2909k4JYnFG06yZa9v6f25bdjI0aogX34U7A1eudJYQ29fMbh0MDeRpenZmUzb9HUj/JFElOjYCkyPSdftpBl/I3jP8eVDqvtBUqAXLpgeK3aYb2Qr8yzkeOTe5lxpEBqayoUA3AHEUnzxJAP5CnBgONlZoVHsWhsEkAsY07WqFoIjNf8gWyoahJQ/yrwRzEkS8XNXQjR09byuBWOk8NPzioF1e1mMnx5s9hMfDPdmUZp1c1+CY5XYFsKwCz+JjIEaMr5mNZgAUmBaew2jRSaCwkSFHgcEuX00Xs02CTHu+8INcf+1bg8AILxuIisw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u7DtJT1UX3r69R4z9bs58Op0RbkejcfHzPXA4RJLMFY=;
 b=On1uxtPDs5+xgC4JQE3dFsDJObpnAmrwneub2ZXSudU15sVkmNGgbZXSOrA6RMRVJHcO2On6yztfV3gcuQwCiPY4mlp7OzzB8KuWRXidhtY1bwe2F6T2wQWE+RJ3yefMxFYlEckQ+Oi1T9QWo60BF6M6Z9mm6gc58DX5Nu7C7gPf4aF74WVGQYh+LVhevM79UPEHU/NRHAbtHSC5fCoab7ExsQtahoKdwAKJ0zmdcClUECldvLHhHvj2q/xnMoSoC2L50rqihdUrDPSWQrj+EfiUw2cquQBsM5sJXXnU+dGl9iqFlSqtkDk8whrmtW9ZFgc6SeZaAO+9SUIgTx4sBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 52.138.216.130) smtp.rcpttodomain=vger.kernel.org
 smtp.mailfrom=ziehl-abegg.de; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=ziehl-abegg.de; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziehl-abegg.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u7DtJT1UX3r69R4z9bs58Op0RbkejcfHzPXA4RJLMFY=;
 b=Hcu0jz/POfO7cw3RaSeLhyu5tSyebIHdww+GHIrH8glc8l+17xdvH6hNV9kXuzCEDIa93Ch+tspqfTYXhNuZDPpZgFWirnv3R+CuXyTp8ADAq13aVTmMwWbnhXiJDx7UcOWNRkSE25D+4QGcFGUO6DfCk+pCZdayd3XIR7ADjew=
Received: from DUZPR01CA0351.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b8::12) by GV1PR02MB8836.eurprd02.prod.outlook.com
 (2603:10a6:150:a2::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.11; Tue, 7 Jul
 2026 15:04:00 +0000
Received: from DU2PEPF00028D0B.eurprd03.prod.outlook.com
 (2603:10a6:10:4b8:cafe::63) by DUZPR01CA0351.outlook.office365.com
 (2603:10a6:10:4b8::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.9 via Frontend Transport; Tue, 7
 Jul 2026 15:04:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 52.138.216.130)
 smtp.mailfrom=ziehl-abegg.de; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ziehl-abegg.de;
Received-SPF: Pass (protection.outlook.com: domain of ziehl-abegg.de
 designates 52.138.216.130 as permitted sender)
 receiver=protection.outlook.com; client-ip=52.138.216.130;
 helo=eu22-emailsignatures-cloud.codetwo.com; pr=C
Received: from eu22-emailsignatures-cloud.codetwo.com (52.138.216.130) by
 DU2PEPF00028D0B.mail.protection.outlook.com (10.167.242.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Tue, 7 Jul 2026 15:04:00 +0000
Received: from DB3PR08CU002.outbound.protection.outlook.com (40.93.64.84) by eu22-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Tue, 07 Jul 2026 15:03:59 +0000
Received: from AS4P191CA0046.EURP191.PROD.OUTLOOK.COM (2603:10a6:20b:657::6)
 by PAWPR02MB9997.eurprd02.prod.outlook.com (2603:10a6:102:2e6::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.18; Tue, 7 Jul
 2026 15:03:52 +0000
Received: from AM3PEPF0000A791.eurprd04.prod.outlook.com
 (2603:10a6:20b:657:cafe::51) by AS4P191CA0046.outlook.office365.com
 (2603:10a6:20b:657::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.13 via Frontend Transport; Tue, 7
 Jul 2026 15:03:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 217.6.247.99)
 smtp.mailfrom=ziehl-abegg.de; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ziehl-abegg.de;
Received-SPF: Pass (protection.outlook.com: domain of ziehl-abegg.de
 designates 217.6.247.99 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.6.247.99; helo=mail.za.ziehl-abegg.de; pr=C
Received: from mail.za.ziehl-abegg.de (217.6.247.99) by
 AM3PEPF0000A791.mail.protection.outlook.com (10.167.16.120) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.21.181.6 via Frontend Transport; Tue, 7 Jul 2026 15:03:52 +0000
Received: from localhost (10.1.201.87) by vEX02.za.ziehl-abegg.de
 (10.1.201.106) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.61; Tue, 7 Jul
 2026 17:03:51 +0200
From: Paul Mbewe <paultyson.mbewe@ziehl-abegg.de>
To: <david.laight.linux@gmail.com>
CC: <Maarten.Brock@sttls.nl>, <crescentcy.hsieh@moxa.com>,
	<linux-serial@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<gregkh@linuxfoundation.org>, <jirislaby@kernel.org>,
	<hvilleneuve@dimonoff.com>, <tobias.gannert@ziehl-abegg.de>,
	<joachim.knorr@ziehl-abegg.de>
Subject: Re: [PATCH 2/2] serial: sc16is7xx: set TX FIFO trigger level to half FIFO to prevent underruns
Date: Tue, 7 Jul 2026 17:03:44 +0200
Message-ID: <20260707150344.353068-1-paultyson.mbewe@ziehl-abegg.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260703213659.0ef977a8@pumpkin>
References:
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
X-TM-AS-Product-Ver: SMEX-14.0.0.3239-9.1.2019-30052.006
X-TM-AS-Result: No-10--25.551900-8.000000
X-TMASE-MatchedRID: H0/uSqZo4D453MvLYrUDiJGPSO6O5JCaKlC/VcK5qZ+0sdSrJZyyxqNo
	Cf8E00x+I+rRXEKy0t+DcfrvKPXZBywi5Q5zBGJNDncGH7ixSLzXT+yjPvIHsezdyUp3wS5Irby
	+M3Ff83zT+mKlRNelARAKgSSN77Q39L4jg3SWeIFakEr6mj52AzdF+uIxstnWGIDEO8l9mY0P7x
	OYDY9f+E4iVAOfN7Ka6FaDT4wL+MTVkohFJYJ4y9wK3aKXLlLAusBvtbk1teDyYHi4HOy3fK0Fk
	4A9fLj20Qu0okOwEW4EjqN9Uybo1ynlDi9/IkBN5PkCeM7tNe3NG2qLXUFOTp2PoOrVGH+/CLVt
	RddRcdM6bQZruhL3u1Xl4PZceefSS98N8MeG868lQx76zly9oyf+LS7y2FykgsoIaI6dcNuG2he
	kUE2c/R+40ck5aOVoaTo+ElbLZ2qO3NTMc7H5QQYB1AFEvUEX004TsKKyALboRtsOA/R6GX1RhS
	VxYZpUCSxtEZcFA86YXHiLsDcWht4Iw3tnLzyTNcBo7kNEyMNPV5HtvDPOzQHLbwVxgAxpjo9a/
	ZwcuNDWvh4zXQtf/8DF9yLCnA9V1xpwEhdebvcRLjqoJJt/9bkluvFQnURkoli4ZoiOHT8g4pZY
	xslhbbNkeEYGbJYuA/3R8k/14e0=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--25.551900-8.000000
X-TMASE-Version: SMEX-14.0.0.3239-9.1.2019-30052.006
X-TM-SNTS-SMTP: 09BE2A8F1F793F77F22BBE9DDC4DD13BEFFD3349EC3F1CB140FA956B6A25A19A2000:8
X-EOPAttributedMessage: 1
X-MS-TrafficTypeDiagnostic:
	AM3PEPF0000A791:EE_|PAWPR02MB9997:EE_|DU2PEPF00028D0B:EE_|GV1PR02MB8836:EE_
X-MS-Office365-Filtering-Correlation-Id: b321b00c-4c5c-4f34-33f9-08dedc38fa1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|23010399003|36860700016|1800799024|376014|82310400026|6133799003|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info-Original:
 0zqk9zSdNLlY+Iwhf+/EyvzLGG1vOkkVOtbjYtAGtv66OJx6HLCL5khemldMkglV/LJw9yAvy38BOiNwqhXaY4XYEtyEZWzojEHJQQhDr2tKpB93F18ptI+BqtjPIhf/+rEHvfv/sqRHwo1pudjh2ON/2+lFfxO/XVXowCUAF4tQ5cBZwyCOGgngmeOTYTCZA5nL0Hw7arTc5BmHBB5vCGD5mtb1XvbUQLPyBzCe0v4XbQUcBCXCoP0FzYZ6mVka+UnmNWNBmCWHWk2rnjs4wLbQFPivMdbv85oDCcgFv+VXgQJYcVcU4MNivyyN4N1RURReWwE6Wi4BM18rPm6u86lRsu84KIqYB5S3ADluD4Tp2iBLOf5aJii35mz5y6z/lSfhQ/6ksLjANt04cl3IN6ZFRwbVlQmsfCgQ/W15BXt23IH9Ki5LnXBqo1KoXuHVoxMOsQrS5b+ZtRsW5QXaHaQUhvNRTRQbfrlxI6ixsOXsh5QoKQynDdUzLj8AspKbkLX5ePhfOzZvmnty5U+jh0rL51wBSRGVLTmX7zdHJR0D4qAR4GGxxFrX7LA4CUFc1WkAQi+42xVtfox+DIu8HJSlCFFB/E/qEDvQ4y7mdJwtuuJpK170ZR2K7hxyVBZ+9Onw9VXXGGOv4kY/x1iL30PJ7Jr+UJ8OJFxyqwoVTLZEBtSbLCf996vitbwDA4Rduh9fGmF04jjFmVK184Ii9g==
X-Forefront-Antispam-Report-Untrusted:
 CIP:217.6.247.99;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.za.ziehl-abegg.de;PTR:nix.ziehl-abegg.de;CAT:NONE;SFS:(13230040)(23010399003)(36860700016)(1800799024)(376014)(82310400026)(6133799003)(18002099003)(22082099003)(56012099006)(11063799006);DIR:OUT;SFP:1102;
X-Exchange-RoutingPolicyChecked: S9/SXuit3dbecHDO6JRhwLTuXCMXZse4+xpQaeQ9L+xfpAmnprk7mP5FDwmyb2iQaW1BYTTanchekKfaq4y/JydM0VaMvVjJdSZ+AdHVVW7a3/kr8os1t4SKPV5+dMdtIHyT9TgWfRg6vQPPJApux1kMp6Chf9idE2zhzl0RQ2XhQcRtuDpKZeCkX+nQmteFS9km7xVaxH96Qdx1lQPu6LzIgM4QN4QLwct1kklQtHmgVEgufKkLYUqfUQ+HjkapurlAjRyb58vtAbPh4/p3vEP6z/dL0coTccXemZ8E2cGyzg1Vr3hIl+TiYgf07rll9jUurecmbKYRIFPB2TtGjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR02MB9997
X-CodeTwo-MessageID: 9dbfe867-be1c-4b09-9604-1c3b7acd7127.20260707150359@eu22-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DU2PEPF00028D0B.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	8a5bfbe5-4760-4f1e-fa72-08dedc38f584
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|14060799003|1800799024|35042699022|23010399003|376014|36860700016|11063799006|56012099006|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	zbpeJNwv3UF517bmTDrnuYSSAMAS2xKngi5DaWufMdwEIfpRek/W1WtYMJsOy4npdOQFzm2iLtKRuZKGpP55/+QXWc4lxSrTigmZQKInfBalsN/MVP9f/Lj5Q71EscdP4JQ9jOSBbEsnhfSqsWDXbUxEgMT8d4zpdI8TbFg26vNXGa6mpWJI2RP5m9RngExsAbgrnWMgEA8BvZSaXIciklGJo8Er1ZTD022Rmb1qzWXTuywP8IpwV2VSbQnp1wh6PieoOWfnrUfWV7nN0YMvrUCDCiQ+aY41izc36PDfuUKiOnW4gyofHqso00E5Ubsae7XMyb+8rtGTKr9liRoFVP4vzy/rfShsV15egKyiAmSMuZAdeYFY6R6z0IiE97FO9qvQ3BPrTVunKGDr4SrybTQ/tvJ+tN7UkRMJGua0lvqQzXndrH5EqUcNv2uwRtVRGQWs5ojsqAGXjATzcOLo7YI2dol/SZwqyBFUtIpZl5YN9+mHriChMZT9aluwRDl62XTQ58zgvzAbIC+1aI+l7n/oBWnOr84Ke6QYt4BWrOfQy6xZ2Xn7j791uLPgqKy8CsNEaHdurdB6qxTWi2hahLuXFvWeCw/k6CmnC6AuivS0sbY6yHKfGl+k/B6XBoK6EuDLnVFcHbzcXLEz6vFfeL4Rg3cRMC7T9AYi+e5CZzpuTkozM+ehrofuqXBtiFO5RTgil5U//2XaQQ2AZnin4w==
X-Forefront-Antispam-Report:
	CIP:52.138.216.130;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:eu22-emailsignatures-cloud.codetwo.com;PTR:eu22-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230040)(82310400026)(14060799003)(1800799024)(35042699022)(23010399003)(376014)(36860700016)(11063799006)(56012099006)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	MfiMrDDG4g1fswrBNjPbGxl32Zk736U62S8kn5bCjPwzbYXtw8AytGBZxDkl8KjyZnGL9QojQAmFLXGBaDvPySTnN3Bddp6Aj9wpK5GlxL3JF2/MfUbjZglN8zFQrnDQgJ4qk7mXivLgxPJuZpIyqYwWOIeX4oL9DvOSjhVg4t6Q/hGk4dUAGbw7PD5gRHUrepnn8+G9Xbxm19wjyXwY1s+72708dmt5EHaolVjO8QUGqo1yW3c+j85x+/7G2FrrR9Sj3e0bM2PQptYsxMiOPIx+7SEVzv/FT2aNZ9ZTnaDdbyqlT0IupbnqbKPK8x8wRhRtx/qzzln7pW1kFCEc0Y80iVmDYjPJ1FaBs6+hmh7sb/OgFfLDo8dosC3DWNeKi5onvSaNXMuSlwZamDnmMkZ4bVv825iaJf6GixK3QvWFFEOmlSYtcfkXldl/4fId
X-OriginatorOrg: ziehl-abegg.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 15:04:00.5676
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b321b00c-4c5c-4f34-33f9-08dedc38fa1f
X-MS-Exchange-CrossTenant-Id: 11a5c065-3ef5-41f0-92f9-a77cbf208c03
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=11a5c065-3ef5-41f0-92f9-a77cbf208c03;Ip=[52.138.216.130];Helo=[eu22-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF00028D0B.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR02MB8836

Hi David, Maarten,

Thanks, I double-checked this with finer TXLVL instrumentation, and the
root cause is clearer now: the failures are stale-TXLVL under-fills, not a
separate THRI re-arm issue.

> You need the refill path to be much faster then the drain path.

Agreed. The issue is that sc16is7xx reads TXLVL once and sizes the FIFO
write from that value. On this SPI-backed path, hardirq/softirq activity,
RT scheduling and the synchronous SPI transfer wait can delay the refill
while the UART continues draining. So the TXLVL value can become stale
before the write completes.

One failing example:

  tx_start       txlvl=3D9  txlvl_read_us=3D580
  tx_pre_write   sent=3D9   pre_write_us=3D16
  tx_segment     sent=3D9   seg_us=3D364
  tx_post_write  txlvl_before=3D9 sent=3D9 txlvl_after=3D12 pending_after=
=3D29
                 post_gap_us=3D12 post_txlvl_us=3D130

Here TXLVL is free space, and the trigger is 8 free spaces. The driver
read 9 free spaces and wrote 9 bytes, but the post-write read still saw
12 free spaces with data pending. Even allowing for the post-write read
window, the FIFO was not reliably pushed below the trigger, so no new
threshold crossing was expected. All failing samples I have checked show
the same pattern.

> The block of data also isn't guaranteed to fill the hardware fifo,
> it only contains data to the end of the software ring buffer - so
> might only be 1 byte.

Yes, exactly. Patch 1 fixes that by looping over contiguous kfifo segments
instead of stopping after the first linear segment.

Patch 2 fixes the stale TXLVL part: after a FIFO write, re-read TXLVL and
top up again if data remains pending and the FIFO is still above the TX
trigger level. This follows the same principle as max310x: do not base the
whole refill on a single FIFO-level sample.

> Are you sure?
> I'd expect it to be active low and asserted throughout.

Yes, I checked with the scope. In the failing case the trigger-level interr=
upt
does not assert; the next INT assertion is only the late FIFO-empty event,
where ftrace reads TXLVL=3D64 with data still pending. So this is not a los=
t SoC
edge or a held-low level interrupt missed by the interrupt controller.

> I'd look up what causes the IIR to report THRI.

The FIFO has to be refilled below the trigger so that draining can cross it
again; re-enabling THRI alone is not enough. The datasheet notes that
"Re-enabling IER[1] will not cause a new interrupt if the THR is below the
threshold." So if data remains pending and post-write TXLVL is still above
the trigger, the driver has to top up again.

> I also noticed that the code seems to be doing slow RMW cycles at the end
> of every tx to enable/disable the tx interrupt.

Agreed. Mid-frame the trailing sc16is7xx_ier_set(THRI) is only a 1->1
update because THRI is already enabled. It does not generate a fresh event.
I will keep any cleanup of that path separate so the underrun fix stays
focused.

> Something subtle makes it happen less often, but whatever it is can
> still happen.

Yes. The 32 free-space trigger is still useful in practice: it makes each r=
efill
larger and reduces the refill rate. At 115200 8N1, the same stale-refill
condition would need roughly a 2.8 ms delay instead of about 0.7 ms with
the default 8-free-space trigger. So I will keep it as a separate
load-reduction / margin patch, while the TXLVL re-read/top-up remains the
correctness fix.

I have been running the re-read/top-up change overnight and want to get it
validated on another setup as well before sending v2. I will include the
results in the v2 cover letter.

For v2 I plan to split this as:

  1. kfifo wrap-around fix;
  2. TXLVL re-read/top-up fix;
  3. 32 free-space trigger as a separate load-reduction patch.

For follow-up, as discussed with Maarten, I will coordinate with Crescent
Hsieh around the existing rx_trig_bytes work and look at a matching TX
trigger interface. I would keep that separate from v2 so the underrun fix
stays focused.

Thanks
Paul

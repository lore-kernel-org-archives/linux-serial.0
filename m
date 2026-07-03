Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11023133.outbound.protection.outlook.com [52.101.83.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B2522BE05A;
	Fri,  3 Jul 2026 18:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.133
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783102799; cv=fail; b=Os2lB0eGC45Vg/ffVx0CAJGTBE8RmUHl81wlrbkk/Jw5+qio74OEcoclGaGGMvOKXHvc0pSSu70XIihSdIzzlJZSSfPTzeTJmlNy93xlfMM+NAdstPkLD5+8NTB9of4vlNztTw3YsGBTb0ppOl/9PNL//JfFWWuAVZLYamN5lSY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783102799; c=relaxed/simple;
	bh=cu/txTwjc0KAlNgxRB9fvEVuDqhekfYGyTuZJQ2lvBA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FIc/GzMCuS6fJ0hhUFbsJNaJUR0LlRbs2moFkCVHF4OHnpMh/pHY9HemwEKhc4Fa55AJG5sYdzYPVsLZyt7R2nL9ukkmkE4vRlCjf0r92e2nOJblMktDOsJLglIolPy4G1S3iOry+tYLDwPA/wV1eJbeFfOav32VQIapuQ16Zoc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ziehl-abegg.de; spf=pass smtp.mailfrom=ziehl-abegg.de; dkim=pass (1024-bit key) header.d=ziehl-abegg.de header.i=@ziehl-abegg.de header.b=DgQi7q/b; arc=fail smtp.client-ip=52.101.83.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ziehl-abegg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziehl-abegg.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ziehl-abegg.de header.i=@ziehl-abegg.de header.b="DgQi7q/b"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h/6uZKYIrdyiCTOtBFW3qQNcfiyiyPFcp3qAYGTFvvOqp1f2qc/UHwzcNkCx1ZvIqCsKGwsbCQAkcu0rj5RNGpBVnJFwYwMZBwmaETyDHG9UWVHundRpvylDl6akjk1srRAAhrVRwvHsWhgZw7xJ2ac1IFw7FKq/vrvHxvwtxFpghFPHfkR36VHAXhS8jrpAR9kmEP/ou/y3ZxWE94AkbmFb10mc4mOj3QfiEJkxNhF6BsoJ0xEDKxTF7s+Q9l9T8JWToDRMY290fEeenP/No0cuBl6Lya3naI7WTDO6gAIVbGcfRu4E9v0b8l07WT+njYb454+ein3Rh8bG/NfqVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lg4xgsrLbq75wVTHffyDvXBEc33DZM6vtNUxgQbf+Qk=;
 b=ElHO3FVCu8uPoy84RTht4Fvg9wwu8EDSi0lhboAJginlw7Hve2Z8pn6kDdj5TOfd0fKASfJoFL2gxHJJ0bKpST4D8fcihNJ2YmBtv+wTrB2oJh69pjRI6EeCOXTqzRDZIY0K2nFmBcuPe6ewLmpe7sJV/4aEr67yYZhKCeOaoyvEG3ASD9w3osIev+zk1gqQLH8YWhJYoHYV6ovGjHLtFI1PNVwRz2imIi/4RSYnFZySoPTIDxTIpMnQ98zfa1tGZOEDLvGtseOkdsBsKNzFx0rEgM2oHN1cinlLwc0IUF/FQAtHdLxAWaimEC9K0TRVri++e76spMMhyuooD7dE3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 52.138.216.130) smtp.rcpttodomain=vger.kernel.org
 smtp.mailfrom=ziehl-abegg.de; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=ziehl-abegg.de; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziehl-abegg.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lg4xgsrLbq75wVTHffyDvXBEc33DZM6vtNUxgQbf+Qk=;
 b=DgQi7q/bmVTT027iI26JLsQZOjC3+syXSjp/aIp1355d7kXgkNDxnZ3oiJppWH4YpT5XkrowvMQxuCrm4w04QAgKg3SltmoJ37Xln4xP/2VqntLBhkrjWbgZChGGWf39UD/2VoNF5Kp99qYAo886QsILBNLpPxvIgNjAo7+tnVo=
Received: from DU2PR04CA0227.eurprd04.prod.outlook.com (2603:10a6:10:2b1::22)
 by AS8PR02MB9530.eurprd02.prod.outlook.com (2603:10a6:20b:5a6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.11; Fri, 3 Jul
 2026 18:19:53 +0000
Received: from DB5PEPF00014B89.eurprd02.prod.outlook.com
 (2603:10a6:10:2b1:cafe::2a) by DU2PR04CA0227.outlook.office365.com
 (2603:10a6:10:2b1::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.11 via Frontend Transport; Fri, 3
 Jul 2026 18:19:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 52.138.216.130)
 smtp.mailfrom=ziehl-abegg.de; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ziehl-abegg.de;
Received-SPF: Pass (protection.outlook.com: domain of ziehl-abegg.de
 designates 52.138.216.130 as permitted sender)
 receiver=protection.outlook.com; client-ip=52.138.216.130;
 helo=eu22-emailsignatures-cloud.codetwo.com; pr=C
Received: from eu22-emailsignatures-cloud.codetwo.com (52.138.216.130) by
 DB5PEPF00014B89.mail.protection.outlook.com (10.167.8.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Fri, 3 Jul 2026 18:19:52 +0000
Received: from AS8PR07CU003.outbound.protection.outlook.com (40.93.65.51) by eu22-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Fri, 03 Jul 2026 18:19:51 +0000
Received: from DUZPR01CA0098.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bb::29) by AS8PR02MB9984.eurprd02.prod.outlook.com
 (2603:10a6:20b:614::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.17; Fri, 3 Jul
 2026 18:19:49 +0000
Received: from DU6PEPF0000A7DE.eurprd02.prod.outlook.com
 (2603:10a6:10:4bb:cafe::12) by DUZPR01CA0098.outlook.office365.com
 (2603:10a6:10:4bb::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.11 via Frontend Transport; Fri, 3
 Jul 2026 18:19:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 217.6.247.99)
 smtp.mailfrom=ziehl-abegg.de; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ziehl-abegg.de;
Received-SPF: Pass (protection.outlook.com: domain of ziehl-abegg.de
 designates 217.6.247.99 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.6.247.99; helo=mail.za.ziehl-abegg.de; pr=C
Received: from mail.za.ziehl-abegg.de (217.6.247.99) by
 DU6PEPF0000A7DE.mail.protection.outlook.com (10.167.8.38) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.21.181.6 via Frontend Transport; Fri, 3 Jul 2026 18:19:49 +0000
Received: from localhost (10.1.201.87) by vEX02.za.ziehl-abegg.de
 (10.1.201.106) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.61; Fri, 3 Jul
 2026 20:19:47 +0200
From: Paul Mbewe <paultyson.mbewe@ziehl-abegg.de>
To: <david.laight.linux@gmail.com>
CC: <Maarten.Brock@sttls.nl>, <crescentcy.hsieh@moxa.com>,
	<linux-serial@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<gregkh@linuxfoundation.org>, <jirislaby@kernel.org>,
	<hvilleneuve@dimonoff.com>, <tobias.gannert@ziehl-abegg.de>,
	<joachim.knorr@ziehl-abegg.de>
Subject: Re: [PATCH 2/2] serial: sc16is7xx: set TX FIFO trigger level to half FIFO to prevent underruns
Date: Fri, 3 Jul 2026 20:19:39 +0200
Message-ID: <20260703181939.502838-1-paultyson.mbewe@ziehl-abegg.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260702222446.0e06a21c@pumpkin>
References: <20260702222446.0e06a21c@pumpkin>
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
X-TM-AS-Product-Ver: SMEX-14.0.0.3239-9.1.2019-30046.000
X-TM-AS-Result: No-10--16.751500-8.000000
X-TMASE-MatchedRID: byfwvk+IcRk53MvLYrUDiGSPjlduu7y+EIraMJLNrJ4i1tnHAtK8I0O1
	RczbdFwYRRf76sBdMszp2YUg7eG506aH+fkVzHL2Gwz+ElW8lobPaW4rD8GWjH9hYTiV+1GZyWf
	JvanSlfW/y8obRAYYvreH6Y8hKRTaBGdZpudIgG7XIza/NEqjlUxxdO0jL6vkwDkSxp9XfnQP7x
	OYDY9f+HrNI+gVh06cajRtZPbq7g8p4VzpooE8Wku+LBodhvWx0oNj5O85xamD1a6T0HdfmayPz
	MGYfTp99vdD9AzWlkmxOm+JsuIGBEoa8vEWKCwKn44P8x8zBonEu6IYOQ1zF0smzUXhtjBTO5lZ
	WnI4HUsC1IWtBSdZI3c7qlSuLvBIxc32rOGXVhx5ax/05CgrEaODSWu0oxbKJP/2DvkXaK9aOxp
	gjiWHdTudE/QO+BwrthRFAcCnfMqUTGVAhB5EbQ==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--16.751500-8.000000
X-TMASE-Version: SMEX-14.0.0.3239-9.1.2019-30046.000
X-TM-SNTS-SMTP: 8DD72CB080604CAF85223989562B59B2AEF6326024D8AA8902E3912679006E702000:8
X-EOPAttributedMessage: 1
X-MS-TrafficTypeDiagnostic:
	DU6PEPF0000A7DE:EE_|AS8PR02MB9984:EE_|DB5PEPF00014B89:EE_|AS8PR02MB9530:EE_
X-MS-Office365-Filtering-Correlation-Id: 817c8380-0894-4e45-327f-08ded92fad5b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|376014|36860700016|23010399003|82310400026|1800799024|22082099003|18002099003|56012099006|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info-Original:
 YXZX/csrRmLAiP6pGq/LW1Disdf5W2k9AX2nrCmCUsM2NeQjydczAiqBdorGqX4/pRL3uBFuITBrixHv52VzDNyOX+BhKuLtTLUE2oAoSfbcMfkQ5GNWfxgTHSURk7/XsKTicJ3nRxennH48NMv/OdxMqsONKHH5c0pRve//ZGojBIUbi1/Uc3va8a3fkjx2AI/LU1csDGqvBCkwCGRHkKC8eq51gHF6cDomiWfkgFWQOAA0+t9MTcazTKXfKraTKwZEq2S0PEE2xyWsxQ0HcDgQf5XhH8g5i0UFfUTE24C6KYcnwp/r13XE5FcW9v/2j4dj8lEWx+kzc76GGW0bGsPMLBYREZeIqx+xFaGBbek5MngbgkHOu41ZsfQtcPEIO7hbCwRNjzfWtWiWgL9mVPwxlH+JqQ3cPuKYCs1hNNd5fju3yUdNm4McA8ay7RxlKnW/LIChePJI2j4+AMTOVXy8hKEnlEwd+aH+8H2RPdxS66JKnETod86X4yPKEC0y9ODABhHTQmZkLbngcZ3udHC18Oeli6c3+gtFsKQdDmSA3Ux7V9HkPG0S4ALSk/MKnQhwvUzsPehz8qsFmek+T9lt4dsEso5RcYTjvPmTSnHs1ddu571sAhO5MJSkCNnachI/eMszUu6sNAC/NFre8iKE1V/DZ1N0DeLjZivwyfm3OzO4sciT7XXgH3ZdgLYGO4uUK5E/ObyyBqdrDZvhkQ==
X-Forefront-Antispam-Report-Untrusted:
 CIP:217.6.247.99;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.za.ziehl-abegg.de;PTR:nix.ziehl-abegg.de;CAT:NONE;SFS:(13230040)(376014)(36860700016)(23010399003)(82310400026)(1800799024)(22082099003)(18002099003)(56012099006)(11063799006)(6133799003);DIR:OUT;SFP:1102;
X-Exchange-RoutingPolicyChecked: LxdJu9Z7fMt2iWzY4OIy4phHMrHpGi0Deihx6ZRb+m6NuZV7LYte3qs7UPyW98mqT6zFUxq2BlYCekpCJgjFQ8fMZ56C18yH4M9FatAcXnOnN8gbJM0lLN3rOsDO5Eax/M9txa1PdK5x/ThTWSFM8PS55D6k5zINLMydsDBO58ySrWiia2aQ2Y2BrNNmIfJkYaA5DB8A9GaoHTHWT8k7CtSYsLjxr1/H94VnwAd1doSGrFw2dUEQvy2Gudw6/Djg2lgHWCHaP4W6l1QBGjSAg0a7xVSTzP7yV7N6BCN+nKyTHT+31uH0JrZ7oAdNVSRSx/bug+8h28MOaOUc6XxAag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR02MB9984
X-CodeTwo-MessageID: e93bc0fc-15dc-4f95-93e6-07ba64284794.20260703181951@eu22-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB5PEPF00014B89.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	edc04613-2adb-43d7-4a32-08ded92fab42
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|23010399003|376014|14060799003|36860700016|1800799024|35042699022|6133799003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	rvR6tzlE+5BXjsZ7VJf7xchBdkltVGvhpJuJf9FdrJWcb/lxwsZDdFGuNo5uIXn3aveCKATIzYrXWzMbe90WzH9/EMnV1c9fdsOtI8sLZ0kusrSmdTBz9hFPI9IYr/8wh+gPiQ7QVA9txqf3M4WxluzVkaO8i370vnHNrCJC6JjFxpUSLjJChE06x3WbN2yUfK9sSvMebt2H7VMi2FMA9kSwwgNjIm/NK24nlEQS/NnHY7fUbgUANuEfsnTm1xNxtuRDNX4Fvi/OFRne2wN5Ju0oQK/EFMOhMDg3kI9fvsn0obQVJnRNYMDpBsC3yFmUT1izbg4bSatDP33nbJ9RNZS9CQZ5cvcpDeF7Jx1RetFdzZ08GLN7KMdT6i5R4jfn/AxH1vLXStwSl7xPQdNKYjCA11eDqx7w5lr+qerRYM7Xmh7xI55sT6xOmOnC+0DVip4iA/O9gIaBqMGYK1YMbt/Bgsv8I2mUvLp7zf61/kvT7bvUvh9igrK71dq7uUly0YjflivXCu2ApswMVrm32CJ4fmCPljfu5osWWwHbc1tDwQE03JPoHxaOYwhtY4s0ApxxWNewZVDC6pOzZ/eDmYvJ4lAJj2PLQ8vN2MEsO/EoU1l1SbAzLNOFKVwcQ9gXyJb9Y2aQVeo3sy+zK2BpMax1Tv1UDOCCJ2T7nIt8vuDwBcue0DgRpyTvDJTn5jBSAgKz/VfJS2r2jNsSiaOwIw==
X-Forefront-Antispam-Report:
	CIP:52.138.216.130;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:eu22-emailsignatures-cloud.codetwo.com;PTR:eu22-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230040)(82310400026)(23010399003)(376014)(14060799003)(36860700016)(1800799024)(35042699022)(6133799003)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	d3yoGz/OGlkPtXKAXuyRGgstEJYijM25vlPw8OFR27NNr4speknJC+s3IB1JcDaM8lrUD4TkImxVMjHVJDl0LeYf87QXSegGoBcg07cSqYBNyYcy84I7NFO5OpNXKSKE876NzS/zh5O/mSQFqE0yrYhJ86qiRhB7ex1/iVKaouU53PEsbPFqNr163WwBpdaLNUD8kMVLCVtihsqd06s54C11Tu2T3CN/81tH6T3O2vnZXtFbGXveholHKbmLWlzIOQvdLHKJgvshwKRqZ6LtGEvLzy8HfmlUnHLIdth93GS2BjQMbuPh8XJq8zxrhmEe/y89VEKyyTQTfOhfTUbq91v8+48GSfRCkikuLbr5yPP/khzqMsgDtFjO9I/kjM0/xANCduThdI6w6T0zp4Z/IdTo+oxqCEtBHJDjE9bef7ET/b612zL8Rqt4pQg1q2RX
X-OriginatorOrg: ziehl-abegg.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 18:19:52.8236
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 817c8380-0894-4e45-327f-08ded92fad5b
X-MS-Exchange-CrossTenant-Id: 11a5c065-3ef5-41f0-92f9-a77cbf208c03
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=11a5c065-3ef5-41f0-92f9-a77cbf208c03;Ip=[52.138.216.130];Helo=[eu22-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB5PEPF00014B89.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR02MB9530

Hi David, Maarten,

short status update before v2.

David, your ethernet-rx double-check analogy reinforced the direction I
had started investigating from the ftrace data. With ftrace plus a scope
on the INT line, I now see two refill-latency modes:

  1. Under-fill, common case.

     sc16is7xx reads TXLVL once and writes that many bytes. On a slow SPI
     write, the wire can drain about as fast as the driver fills. The FIFO
     free space then stays at or above the trigger level, no new threshold
     crossing occurs, and no further THRI is generated until the FIFO is
     empty.

     The scope confirms that the INT line stays deasserted in this case,
     so this is not a lost SoC edge. max310x avoids this pattern by
     re-reading the FIFO level each refill iteration and filling until the
     xmit FIFO is empty or the hardware FIFO is full. I am testing the same
     refill pattern for sc16is7xx.

  2. Preempted refill, rarer case.

     Some traces show the IRQ thread being delayed during the refill path.
     In those cases the FIFO does appear to be pushed below the trigger,
     but the next THRI still does not arrive until the FIFO is empty. That
     looks closer to your "threshold reached while the threaded ISR is
     still running and the re-arm is lost" case.

     I want to see whether this still survives the TXLVL re-read fix before
     adding a TX watchdog.

On your specific questions:

  - The trailing sc16is7xx_ier_set(THRI) is a 1->1 update mid-message. The
    bit is already set, so it does not create a fresh event. The driver
    relies on the FIFO being refilled far enough for the chip to produce a
    new threshold crossing.

  - trigger=3D32 is not a wider refill window. It gives about 4x fewer
    refills, lowering IRQ/SPI load and reducing exposure to these latency
    outliers. I will keep it as a separate load-reduction patch with the
    corrected wording, no longer as the root fix.

Maarten, I will drop the SPI-only guard. I also agree that configurable
RX/TX trigger levels belong with Crescent's rx_trig_bytes work as a
follow-up, rather than blocking this underrun fix.

I will follow up with the A/B numbers on Monday.

Thanks,
Paul

Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 116E2246799;
	Mon, 14 Jul 2025 14:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752503222; cv=fail; b=ODd1lN+pc208aLTzWjicOCdp1IYYyeEF3v4OQdBoatE243FmQ/Xu8N85tRoCFrH2xD4rzSxGwGrsxjmHDyS0Rl8RlL6NaB9PwVJUVAlPTUWnrguKZ9RLU9TZHV18Pne5/itEm546RVBQF8H9FuWmx6Ez0Es0hAqS8tgdD6HDWNU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752503222; c=relaxed/simple;
	bh=OD6R/qNaixrudaa2guMCpJH3TiZozvioAWN+bvk/71w=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Xg/cnqoFNHjTRNAUXOoj7sF1cEntTaB8zYcQFs7VbOGdJYPSC96iA2ujV0ZWL/5maA0+KjX+WAJFQSsAAQCmzSw5TmXE9asF7Nb01EDEYsNMmzwh3fOHhTohMv8NvPOdUW6RYn4l7oYAguD5YiGhvxn+FN1R1rjV+2Gva+dLdn0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=feoNol4j; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=nfGMKTZy; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="feoNol4j";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="nfGMKTZy"
X-UUID: 96359ce060be11f0b1510d84776b8c0b-20250714
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=OD6R/qNaixrudaa2guMCpJH3TiZozvioAWN+bvk/71w=;
	b=feoNol4jaeHgdL8W6QqdECGIdSXWT04mTBBN8nZA5MC1spIhqu7XkXrCr97kD7FkBTqUd6lmD/riIb1/ld0uaXlNwmmXulRMVZBk9QdZS+lUTACggOY5HA6MSeKrL6VarkMEHlW5fGlozAKs35laSYfY59IqAnktkfAAFPUwmzc=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.2,REQID:57b3ec72-482d-430b-a426-93a040e4d14f,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:9eb4ff7,CLOUDID:afdf24df-2070-40bb-9c24-dfabef7c07f4,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111,TC:nil,Conte
	nt:0|50,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,
	OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 96359ce060be11f0b1510d84776b8c0b-20250714
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw01.mediatek.com
	(envelope-from <sirius.wang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1613961145; Mon, 14 Jul 2025 22:26:52 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Mon, 14 Jul 2025 22:26:51 +0800
Received: from TYPPR03CU001.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Mon, 14 Jul 2025 22:26:49 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lw+k/I9D39Bgk2BngoG3FCs37lzgFQt7boJhx0m/BZN8Bj4KlAeRVFe9+gKBE/2XcsdDbN7Yy/8qjqyq+FPiILUg0KhBVOgRBzR4e6iZRVvB5/5qe7LT1QNI5c1+yeosYMtg8HSnDpCXzYTiCon6ZGbe07Z29TZN9O3Jswd6+1fokNHKnRexC7bYDqRneM+m9f20qcRSX+MeLcbXKq4cC4DZ5zc4oGLCE5paYR4wv+H7K8tNR63iPGmeTXK8FmXxJWXJFaHSTB3tXrBAvJNrD+E1ukfnBKDhfzp5YoSBT4pt5ZVOzC777c5mWEcGUPKxjKE/cARnFFk9QiiAkkqpmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OD6R/qNaixrudaa2guMCpJH3TiZozvioAWN+bvk/71w=;
 b=WzoZTeN5DwXrD9fQcx3QbkTDr3Cy038v53rek7huWQwspQsFpqSKJGcQMLBzjRpPUqSem9bBpiEqDzpy8QoTOhLnSlz1rP49Mmh2ZDK/XgwfARbEKCN1cug3+xOl4XcD0h9MWAKu2gbWzkOe1yWP4gMHoCRcot6h8PB1A4TNXnCKEJWcw9OcKLP8Z4ZE4e7K9kwHDDxdU2rWKH7qAUw2P5iK6I9IieHXZX6536P+vDqjRkmE4pu/pNGM72CCQm6lWA7ruPNTsb7q78jDIe59dJHVsQZxELuZQ/PyGYEJ64mMECb1tJrzRzCczsuWoDpUB2ZG30+VAONpMMjPBexHFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OD6R/qNaixrudaa2guMCpJH3TiZozvioAWN+bvk/71w=;
 b=nfGMKTZy9vLQYogcFCjHQukKTf4L7RZng0RmWj+/pI+4Wjoq0g/6E75Ah3CIEAG0sO7KZlU/8D/fN06eIuGASqEKF3je5yssfCr5o8Zl6ZrpYCpEjb8HDBOGvWslCfjtYSj0xmEl9uiyupNmwXXpFR2LN3Qr86hvhl3CtJpeM2M=
Received: from TYZPR03MB6493.apcprd03.prod.outlook.com (2603:1096:400:1ca::11)
 by SE1PPFF8E6D3F8F.apcprd03.prod.outlook.com (2603:1096:108:1::872) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Mon, 14 Jul
 2025 14:26:46 +0000
Received: from TYZPR03MB6493.apcprd03.prod.outlook.com
 ([fe80::bba9:4ca1:50ba:7923]) by TYZPR03MB6493.apcprd03.prod.outlook.com
 ([fe80::bba9:4ca1:50ba:7923%3]) with mapi id 15.20.8901.033; Mon, 14 Jul 2025
 14:26:45 +0000
From: =?utf-8?B?U2lyaXVzIFdhbmcgKOeOi+eak+aYsSk=?= <Sirius.Wang@mediatek.com>
To: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "jirislaby@kernel.org" <jirislaby@kernel.org>, "Sean
 Wang" <Sean.Wang@mediatek.com>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>
CC: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "wenst@chromium.org" <wenst@chromium.org>,
	=?utf-8?B?WGF2aWVyIENoYW5nICjlvLXnjbvmlocp?= <Xavier.Chang@mediatek.com>
Subject: Re: [PATCH v4 0/3] Add mt8189 dts evaluation board and Makefile
Thread-Topic: [PATCH v4 0/3] Add mt8189 dts evaluation board and Makefile
Thread-Index: AQHb9Mh4li1KLeJLAUqskDxm5RX8iLQxrRQA
Date: Mon, 14 Jul 2025 14:26:45 +0000
Message-ID: <4c74abbfed2a02a7cf6bfc0b6050489c4446571f.camel@mediatek.com>
References: <20250714140608.2065966-1-sirius.wang@mediatek.com>
In-Reply-To: <20250714140608.2065966-1-sirius.wang@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6493:EE_|SE1PPFF8E6D3F8F:EE_
x-ms-office365-filtering-correlation-id: 0f5a38ce-4af7-4d0d-f179-08ddc2e2763d
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?VjYwMU1OZTg0ZmpTaFdMbUhJNmw0dlZ5NEdJcVFYRUdRMHRLbzZKQ0l3Slk5?=
 =?utf-8?B?dFE0OEFMRk1rNldvRE90R09CeEFsVDdpY2tHd2FGMUxNUFJpSHB5aEpPcGky?=
 =?utf-8?B?RXRUNmNUejZxVDVuWjhVL2xlV3M4SVZ0MUc3ZEJ1NWlSTUFzQVBqZUZ4QjVk?=
 =?utf-8?B?UHFRY0hxV3FCYjNselZFbUZYSGNlaFp1NjB1QTRpRVhwTUl1d2FWaC9pYlEr?=
 =?utf-8?B?Wm1TVldkM3JCVnRwV0tDNGwyQ2pSZHhkQzRMTmJJY0JaMEZKaDRjejVxdHdS?=
 =?utf-8?B?RlV0dUJoc2F6S0RzbEg0NEh0RXJNUEQ4MDVEakJSdHpZSzdXU2M1RC9nWGJi?=
 =?utf-8?B?Nk5qbDRLRGpWNmNFUzM4T0VkS1lyd1RlV2IybmhVeUQ1QlQ3QUFNNFVBZVE2?=
 =?utf-8?B?TWZDMmFtam5wN05CUVZ4T2wycXMxUzZpUlFSYUtWWkpYRXpaVnQ3M29Xa2xW?=
 =?utf-8?B?b0JLdVFzREJ3WktickN4NnFXd0ZZR1hVUXFFcmZiREZRbGU1RGRFeElKdDZh?=
 =?utf-8?B?Q3NYYk5xeWdORHQxYTAzRkYwa3UzNzk1R05kbGtrbXRwcVZNWGpUZHdWeHBn?=
 =?utf-8?B?OGdKbklmM1RROFR3ajBxRUhOM2lnQ3lZMk03c0t4MEI3VDFTM1d1K1prVWhv?=
 =?utf-8?B?Zk5zakMwRXNvd3lxMTI0TFpjSzBEbnZDaHZpb3JadmZnM3RhTlBkOS9WV2hq?=
 =?utf-8?B?ZXg2Q2pqckdwUTZqSGN5OEppcHkvSUt0TmIxUllzUW4rc2JLSGZ4c0dXQ0Ns?=
 =?utf-8?B?Wm0wNVZqTWh0alVKaWNjV3BPZ3Z3U0x1cWFLTUQ0SFlSQy9nMHRGRGUzVE41?=
 =?utf-8?B?NWwwM2ZqMlVPZStIUmJOOHVEc1J0ZEl1YUlyWHBVb0Mza0ZWM2dvV1Bwb1Zy?=
 =?utf-8?B?dVYrb1Nhb1ZBbWpQZGNUVllUd3ByQzVNNEhmcGZzQnhZdkttakVnRjJCNU1t?=
 =?utf-8?B?SXV3N0ZoMHFXeGFpbWpGc2I4aVJCK1FSa2pVK3llZVBMRzNFSVNUZkgwb2lO?=
 =?utf-8?B?YnVjYWI2U2YvcXYvK3E0MS9VMERsTU0xayt0TmREOFdkNEw2eGU3QkdwUUVk?=
 =?utf-8?B?TzFnVjRHWGJ4bHF6NWJtK2VDT0pxcUxXWE5kblhXVnhwZHRJZUMyNkdqcE5Q?=
 =?utf-8?B?amtuZG1XQ2JJUnFUcHJndHRvREFIOG1mWWRPNXFIUkRNM2d4WG5UdFdWWkI0?=
 =?utf-8?B?ZnBMa1hBYWZVeG9ySHJjWGdvVVk1TUVjaThjcXBheHRCVWFwb204TjRVTXNK?=
 =?utf-8?B?SVR2bWdORjRiQUlWd0xrMU50YmhrSTVVZWZFc0M1RlhlY1NUV015RHRRVHZM?=
 =?utf-8?B?dlkyUE9lTXFhVVJGZ29yUjBXaUh5RTJpOW12VG1vWEVQRFk3aWV2TmhmL1Nm?=
 =?utf-8?B?OWh4T3NiYTUvUy82a0ZHR0xUcjlTbk5qcDhBTnRTbEZGSHM1WEc0QjBuZklj?=
 =?utf-8?B?czhsNmZTR0Y3MHhBVzRyNW9yL3VnMjZ4S3kwNFBtSUpFWjRmT1E3NnNyd0x0?=
 =?utf-8?B?R2t0NWVsT1JWeG9EdGMrdmNFaUF2WDdDanB2elo1b1NyRUNHVE00aTBWblJW?=
 =?utf-8?B?QkthejdqTERZalRrK04zNWYzYmYyMkQrZTVDZXNRU1dEV1RqWHRROXdmTjVB?=
 =?utf-8?B?eTZpNU9aZmdxS0pOT2dqK1F0WE5pSnUrcTJvb1BXOVJvQXp4czE1d3M4MTRM?=
 =?utf-8?B?LzhidlJ5WCttNHVSZVRqMnZlMDJHdmlIaEJmK2JxSURwdFNibHp6bm5uNWFY?=
 =?utf-8?B?bFZvWmtaQy9SZHMvTHdXamI4Y0hnVVMyNklRNmd0Y3dnU1hNZ1lrVXdlQlpB?=
 =?utf-8?B?SE00R3RFMGVSUG0yeVdkWCtGMlN3ODVBRmtZRlZ1N2lPQmpseVQ2a05zVWJM?=
 =?utf-8?B?dGZkeWt5QWg5Slh4NjUvcXd1dVVyQ0dUQUZ2ZVRFeEJibGk2TnpIQ0pXakF2?=
 =?utf-8?B?Sms0M1I2RlEzMUYzdTI2cWIxRVN5bC93UUw4eGQvZFVSRUZCNWxOaDlnUDkz?=
 =?utf-8?B?NTRSTGJ5R3p3PT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6493.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VGZ4MTd1SkpLS1dBL01rd1gyQlByaUd2ZmRTN1VQOWplYTdZZ014Y1JrWE1s?=
 =?utf-8?B?Z3I2aUl6MFE3akZZOHlPTGg2MHpTbTdZL2VLenhncE1tZFROMjR0STE0UEps?=
 =?utf-8?B?Uk9JMnMrRkhOUDlXOWxNMW9pZ0ZvQUhmalB1ODMva1hZYjl6VGZyanhyY2ZT?=
 =?utf-8?B?alNtcGlhZHhaV0hhYkk4MkJEM0VsNE5sVWNrV095L0VuNnF4dWFGRVdwVDJj?=
 =?utf-8?B?djM4Ukw4TXdSOGVsZVNnTS9nS3J5ODNCcXdVc05oem0yUlB0a1NYNGNpQWd0?=
 =?utf-8?B?Ymh1QmhkTk0zYXgxMEw5R0Q0aEdVS2N4cVFwbWFzSFNUTTBOaVBQUWZWSHdV?=
 =?utf-8?B?YW1XcVZ3Mm1pQy9GSXVjbSsyOHp4b2VaN3FhSFpWTkVaZlZEVXV0VDFQdnVR?=
 =?utf-8?B?NEkxUzAySEljT2dhdGZML1A2UjNxaWk3NmcxYU54SnFicEUrKzNmcm1vMTJx?=
 =?utf-8?B?cERNUE5XMWtpekV0SUMzUWZDQVQ5TmhHYUdRRHNFQnNpV3IwNWFXcHBBMSt6?=
 =?utf-8?B?Qy9FcFVPZHlFb3dBOWdwMHJkRWdZcGFYNXJrUmhGcUpVM2cyNExHTEpmS202?=
 =?utf-8?B?TXMyQWRZZGJjOHJMS01EQXZ2U1kvazlPL0hZZkM5K28yaHEwd3JTckZQOVlk?=
 =?utf-8?B?RC9pT3FWeEcxbjZ2cmtqVXZwdC9ua2lXUWhuSDlhV2R3RjZjTnBTYS94dUxM?=
 =?utf-8?B?emdJVW0rSG5FVnRnTzFjdE5UZVo2R2tSZ0sxdzdCL0ZIKzMzdWJTZlhlSS95?=
 =?utf-8?B?Z0Q4OXY5KzZRQ3FCYlBwR0dsREFRY2w4YTNWQldTVDhkdUkxeHErbVpDbVZy?=
 =?utf-8?B?MHQ0NnRlVFdDcDliQ2QrSFVjWFZySjd0SHU5TjQ1S25ROFVsVjJLQVVsTUsr?=
 =?utf-8?B?V3RXQ0QvaWxCTTB3Ymcrdk52cjFITllhTVFtTHFTalZybzRhUzVGU0JlS3NK?=
 =?utf-8?B?NkdLSmxyNVZMYVA1U0tCSWEwZVVhMWpwdnhJNks4N3R3NklRM2dYYzloYld3?=
 =?utf-8?B?Q0xHdmwwZmJTRTlOVThibzlBbVZUbHVka25yeGFhdFo0enF4RE14UE03cCto?=
 =?utf-8?B?MndGbnM5OEhCZ2poZmlMc1lFRFE3TEp0NTI1NUM1akR4UWszdXR1UkpCTVEw?=
 =?utf-8?B?dEU3R2Nody9FTXR1QUtzNWJGVlp6bjBtdFVzbjh5WGJlSWVnODhhb3VJd2hu?=
 =?utf-8?B?aHJyQlc1R3dsVHNpSXgrblVCZmFHenRwT2dpdXhIZ3QxRExzcE5vT3V5QVhH?=
 =?utf-8?B?YmhhUHk5OVFLSk9LNEJyNjAzWDBacUxweDF0amYyWndZWXppTmt3T3hxWEJw?=
 =?utf-8?B?dWtRWVBJdWdhK0RENjNxRTUzaE9nSnBITVBSOWJuTVltY05HVTgrREtJTHo1?=
 =?utf-8?B?NmR4V0tyMkdVSld6cnJVMjE2ZUxFNmRmVkNXdFJYc2Vab3JSUHc0bUplbThB?=
 =?utf-8?B?NjJ1cWpwNkhSVGE1cUtYOWNvdUJOL1B0ak9oNG41WE90YnlKRTFvM25RNWFi?=
 =?utf-8?B?cHNaNjMvblVVSnZoRE54cWFpTHBBNUFVUlpLcHpwRzZnNDFJZVVQckFWeTZs?=
 =?utf-8?B?ZjJ4NjV1MHBvSVJrejZ6RWJUZFEzcGhSb0lneGYxNlUxM3ZJUEJTaFcxbDVI?=
 =?utf-8?B?cUpOZVZpTjRBWkw2d0FyOE5WelZONHpmRDBrOFkvMTVaakVRNVVBaUxYZm5L?=
 =?utf-8?B?N0lSRThpZld2eG13bmhhUWNjeVZoUEc2OUVwcmNHVW9Ib2xBTkljemt4ZnNl?=
 =?utf-8?B?aDBwa0c5K29BZnVkelJHMEF5RDNKOFBMdkV2N3l2WDRWL2RJdFR1bFNjMlcz?=
 =?utf-8?B?cXdWRE1rOGdsTVZmYkpMaytvdVEvQWVneWMvdGR4UXVBVWdPWDBHL1lkaUpY?=
 =?utf-8?B?aTUwKzJGNWNJUFZOZmVFOHJYWFh6ZzFyL3RoWWNiSEdpbE9Xd29Nenh0QkhT?=
 =?utf-8?B?NHB3SXNmZWVTYTdnc0tqbjd0V2JBL3U0SVJjS3JjZlhOTTFZTmxhRHpMUXB2?=
 =?utf-8?B?L2pvQ3prVmY1dkpnQmFsOUNwbkkyRks3enZpYXA1VncxRGsxTEc1c1FTZUFi?=
 =?utf-8?B?b3JBY1YxYlJtL2ZlaytrRmZvUEVBNXV3b09QRklXaVNNN1dMdjY1MVJqN3I2?=
 =?utf-8?B?cnBSczd1UVFzV0xlcmx1ZGZmdUlpYjBuOURSc09HZWx3TUN5ZHhSRDZpcHd1?=
 =?utf-8?B?amc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <55163FE5911D8A42975D75C7185367A9@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6493.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f5a38ce-4af7-4d0d-f179-08ddc2e2763d
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2025 14:26:45.8158
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XI05PzZgNEy7Z5KCGTnGlQVBh+gCfw9IscFzZ8jniv0t8YqaaZTwtkAwqZ3pa1Vuda72HCN4MRU2NZTedHfWquQ4HVLnI1BfkF3Un6b1JGw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SE1PPFF8E6D3F8F

T24gTW9uLCAyMDI1LTA3LTE0IGF0IDIyOjA2ICswODAwLCBTaXJpdXMgV2FuZyB3cm90ZToNCj4g
V2UgYWRkIGJhc2ljIGNoaXAgc3VwcG9ydCBmb3IgTWVkaWF0ZWsgTVQ4MTg5IG9uIGV2YWx1YXRp
b24gYm9hcmQuDQo+IA0KPiBJbiB0aGlzIHNlcmllcywgd2UgYWxzbyBhZGQgZHQtYmluZGluZ3Mg
ZG9jdW1lbnQgZGVmaW5pdGlvbiBmb3INCj4gTVQ4MTg5Lg0KPiANCj4gVGhpcyBzZXJpZXMgaXMg
YmFzZWQgb24gdGFnOiBuZXh0LTIwMjUwNzE0DQo+IA0KPiBDaGFuZ3MgaW4gdjQ6DQo+IMKgLSBD
b3JyZWN0IGNwdS1pZGxlLXN0YXRlcw0KPiDCoC0gQ2hhbmdlIHRoZSAicmVnIiBwcm9wZXJ0eSBu
YW1lIG9mIHRoZSAibWVtb3J5IiBub2RlIGluIHRoZSANCj4gwqDCoCBkZXZpY2UgdHJlZSBzb3Vy
Y2UgKERUUykgdG8gbG93ZXJjYXNlLg0KPiANCj4gQ2hhbmdzIGluIHYzOg0KPiDCoC0gTW92ZSB1
bHBvc2MgYW5kIHVscG9zYzMgYmVmb3JlIGNwdSBub2Rlcy4NCj4gwqAtIFJlZmFjdG9yIGNwdS1t
YXAgdG8gYSBzaW5nbGUgY2x1c3RlcjAuDQo+IMKgLSBDaGFuZ2UgY3B1IG5vZGVzIG5hbWUgZnJv
bSBtZWRpdW0gY29yZSB0byBiaWcgY29yZS4NCj4gwqAtIE1vdmUgcHNjaSBiZWZvcmUgdGltZXIg
bm9kZXMuDQo+IA0KPiBDaGFuZ3MgaW4gdjI6DQo+IMKgLSBGaXggd2FybmluZyBpc3N1ZXMgZm9y
IG1ha2UgQ0hFQ0tfRFRCUz15DQo+IMKgLSBBZGQgbWVkaWF0ZWssdWFydC55YW1sIGRvY3VtZW50
DQo+IA0KPiANCj4gU2lyaXVzIFdhbmcgKDMpOg0KPiDCoCBkdC1iaW5kaW5nczogYXJtOiBBZGQg
Y29tcGF0aWJsZSBmb3IgTWVkaWFUZWsgTVQ4MTg5DQo+IMKgIGR0LWJpbmRpbmdzOiBzZXJpYWw6
IG1lZGlhdGVrLHVhcnQ6IEFkZCBjb21wYXRpYmxlIGZvciBNVDgxODkNCj4gwqAgYXJtNjQ6IGR0
czogbXQ4MTg5OiBBZGQgbXQ4MTg5IGR0cyBldmFsdWF0aW9uIGJvYXJkIGFuZCBNYWZlZmlsZQ0K
PiANCj4gwqAuLi4vZGV2aWNldHJlZS9iaW5kaW5ncy9hcm0vbWVkaWF0ZWsueWFtbMKgwqDCoMKg
IHzCoMKgIDQgKw0KPiDCoC4uLi9iaW5kaW5ncy9zZXJpYWwvbWVkaWF0ZWssdWFydC55YW1swqDC
oMKgwqDCoMKgwqAgfMKgwqAgMSArDQo+IMKgYXJjaC9hcm02NC9ib290L2R0cy9tZWRpYXRlay9N
YWtlZmlsZcKgwqDCoMKgwqDCoMKgwqAgfMKgwqAgMSArDQo+IMKgYXJjaC9hcm02NC9ib290L2R0
cy9tZWRpYXRlay9tdDgxODktZXZiLmR0c8KgwqAgfMKgIDIwICsNCj4gwqBhcmNoL2FybTY0L2Jv
b3QvZHRzL21lZGlhdGVrL210ODE4OS5kdHNpwqDCoMKgwqDCoCB8IDQxOQ0KPiArKysrKysrKysr
KysrKysrKysNCj4gwqA1IGZpbGVzIGNoYW5nZWQsIDQ0NSBpbnNlcnRpb25zKCspDQo+IMKgY3Jl
YXRlIG1vZGUgMTAwNjQ0IGFyY2gvYXJtNjQvYm9vdC9kdHMvbWVkaWF0ZWsvbXQ4MTg5LWV2Yi5k
dHMNCj4gwqBjcmVhdGUgbW9kZSAxMDA2NDQgYXJjaC9hcm02NC9ib290L2R0cy9tZWRpYXRlay9t
dDgxODkuZHRzaQ0KPiANCg0KRGVhciBtYWludGFpbmVycyBhbmQgcmV2aWV3ZXJzOg0KDQpJIGFw
b2xvZ2l6ZSBmb3IgaW5jb252ZW5pZW5jZSBmb3Igc2VuZGluZyB0aGUgaW5jb3JyZWN0IHZlcnNp
b24gb2YgdGhpcw0KcGF0Y2hlc2UuDQoNCkkgd2lsbCBjb3JyZWN0IHRoZSBpc3N1ZSBhbmQgc3Vi
bWl0IHRoZSBjb3JyZWN0IHZlcnNpb24gb2YgdGhlIHBhdGNocw0KYXMgc29vbiBhcyBwb3NzaWJs
ZS4NCg0KVGhhbmsgeW91IGZvciB5b3VyIHVuZGVyc3RhbmRpbmcgYW5kIHBhdGllbmNlLg0KDQpC
ZXN0IHJlZ2FyZHMsDQoNClNpcml1cw0K

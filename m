Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04F5831F995;
	Wed, 25 Mar 2026 06:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774420798; cv=fail; b=Rhl6s0HzhV0ds6bqrfwDGe5RE64mx5Ma2ienaupyjxD2IeESH00pTq7tWxYxN5vQ1zZOcYyFEeU9XkSe+nefFqhckKhYnhKzQoL+2olNT1PGVleSdQK1mgL3xtbDSW/MjpdHUzEDK0B+j1IaMHEnyo2A3QiRtulThE+enEjwowM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774420798; c=relaxed/simple;
	bh=W2v5uEHtlYoxFq19MTA/py0ndOneemtaPcy43/f/9rc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LW5Ge6jCrFFzbJ2wzEYeFP/ysw1mH2QIMzEinw1Q/qYTwkeMyk3LGkQQqj7t/xGEbJ/tBuEZfxi0Mx+kOC8QKkYLXBlycA5b91HdWjtrGdlhRPcHVXMnE8g/f2/TAYYSMSfhC9QANFhsMT5fZmkWWB+J9gGurlKhPspHS5XDpC8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=b809iG4a; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=Pz1W5aYL; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="b809iG4a";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="Pz1W5aYL"
X-UUID: 6c344bf2281511f1a39cd589f645bc18-20260325
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=W2v5uEHtlYoxFq19MTA/py0ndOneemtaPcy43/f/9rc=;
	b=b809iG4apOfk2Q19T5ZBE2mHOWJO+zCayo0Pt9BSYEa/N8CfYp7+dVURpz8Ai6Lwn5tHlxxZOg86xGK/gib5DFaJdKUopKGRTptrJRxZOYki1iXo9KXEl16fXpTrORZw5OOqVmLBBaD+77DPfSG3M1t4LKVrnQpnFD1nrVTG1zk=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:faca5e40-79a3-4f27-bfb5-4b970be27bb3,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:e7bac3a,CLOUDID:c6302f94-f8ef-4ca8-bea0-143568f9ca1d,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111|836|888|898,
	TC:-5,Content:0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BE
	C:-1,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 6c344bf2281511f1a39cd589f645bc18-20260325
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw02.mediatek.com
	(envelope-from <zhiyong.tao@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 576309555; Wed, 25 Mar 2026 14:39:49 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 25 Mar 2026 14:39:48 +0800
Received: from SI4PR04CU002.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Wed, 25 Mar 2026 14:39:48 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w8xO75BSL4vBg71OEVtMa2p/jcu//ixOwzrx16a1AcSlrpv/S+gVbNiq0ztsnPPFBAXhRGGekFD7owgkD6wh81i6IVNmHFwdKSJveGoB38locg+6WALhRtt6beq5qY1NmmvaV23rl1SSe08Itg63b1noLtOETPgoJlX5zoJoxBeGgHN9aeMmvNi07Vt7J16ht6hhYuC2d8Xcnk6TyW8xqgznDBmEctlWeRo9bm+vmbuzvivgDxO6woOcEDkXSi5EptkOgDVsvembAUhI3Z1NgtutObqCIIANpNuWWAhPdugNrsDTOR/u4yAZaBlzc+6L/90aKR893M/F80Nf2QlAqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W2v5uEHtlYoxFq19MTA/py0ndOneemtaPcy43/f/9rc=;
 b=GAjtFsPOswKgYz6l9hZXc4bl4I12jaV2iApH2u+ZF+QFyBLuplsgiBa0uMfz2zEg7Es34M7tosLuabEKw9PGCpsnb4WXtP0d1LHs4lWQoqcSSh0Sv4PLby6zbGIfxu1N6Eq1hD8F647yJymkhW4nap6v3UYp6BL4MYFH1a7BwGkqlUgGy3bQcutFeToMtH0JM+UiKiKF8UNvnEQFJjSdpbr68lb2YqJa28U5RuadTx9uUtu1cRqtdAkICHGO4ak+GPb1SIPjm7dVAyNsnBMMedl38eznuDerjqtfnkz+TV988RTRJeYF4QQYjIPm/cFLSNpc4H4KR35dWi91zUZy3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W2v5uEHtlYoxFq19MTA/py0ndOneemtaPcy43/f/9rc=;
 b=Pz1W5aYLi/pV1s+MtYrxM42Hqsz7La5fTxgSte5YxhKpGlpNKH8qdZVSLiwAcZIRygTfouKuVaIqF/2H+NH/ef98qsn4S6yFkFc1Nr/I66PJ2jR/UFlNfUWr1Qa7+4OBTxyzg61+mZUNM/zw4Rv+rz1xy0OUuwQQ6DpctOUAqZ4=
Received: from SI2PR03MB5690.apcprd03.prod.outlook.com (2603:1096:4:15d::13)
 by TY0PR03MB6824.apcprd03.prod.outlook.com (2603:1096:400:219::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.31; Wed, 25 Mar
 2026 06:39:43 +0000
Received: from SI2PR03MB5690.apcprd03.prod.outlook.com
 ([fe80::7361:3cf0:b441:7d0e]) by SI2PR03MB5690.apcprd03.prod.outlook.com
 ([fe80::7361:3cf0:b441:7d0e%6]) with mapi id 15.20.9745.019; Wed, 25 Mar 2026
 06:39:43 +0000
From: =?utf-8?B?WmhpeW9uZyBUYW8gKOmZtuW/l+WLhyk=?= <Zhiyong.Tao@mediatek.com>
To: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC: Project_Global_Digits_Upstream_Group
	<Project_Global_Digits_Upstream_Group@mediatek.com>, "fred2599@gmail.com"
	<fred2599@gmail.com>, =?utf-8?B?WWVuY2hpYSBDaGVuICjpmbPlvaXlmIkp?=
	<Yenchia.Chen@mediatek.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, =?utf-8?B?TGlndW8gWmhhbmcgKOW8oOeri+WbvSk=?=
	<Liguo.Zhang@mediatek.com>, "jirislaby@kernel.org" <jirislaby@kernel.org>,
	"linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Vasanth Reddy
	<Vasanth.Reddy@mediatek.com>, "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] MEDIATEK: serial: 8250_mtk: Add ACPI support
Thread-Topic: [PATCH] MEDIATEK: serial: 8250_mtk: Add ACPI support
Thread-Index: AQHcfey/SO6Kleh1dki/LWqHFZdmJbVE6yeAgBdV9YCAWGQMgIAAI2UAgAp/5AA=
Date: Wed, 25 Mar 2026 06:39:43 +0000
Message-ID: <55bc4250d7cdd37aead9969e066b49746d888307.camel@mediatek.com>
References: <20260105024103.2027085-1-zhiyong.tao@mediatek.com>
	 <20260105024103.2027085-2-zhiyong.tao@mediatek.com>
	 <2026010643-ladybug-tiring-7f3c@gregkh>
	 <434e34f05bb5f87b59402811012e3a2f56f2182e.camel@mediatek.com>
	 <6478a71ffca65e58fa19a5edbc25eb5f51a8cc12.camel@mediatek.com>
	 <2026031837-slimness-playset-a62b@gregkh>
In-Reply-To: <2026031837-slimness-playset-a62b@gregkh>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR03MB5690:EE_|TY0PR03MB6824:EE_
x-ms-office365-filtering-correlation-id: f95b15a0-f43c-4879-6039-08de8a394c92
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700021|22082099003|7053199007|56012099003|18002099003;
x-microsoft-antispam-message-info: LqGG8UJqttlTu5JzEyJ/HapF7vVgounqgqIVS0NqczC/5kDjthLgqUk6KkLpj1YFUJ+NrcDwtQJYYWuYFVwC+SxQvT0w8miAABSKI8IsN6uj+SUhNwl+Q1hSeJECJqw9YzcW4X/j8AnEwasD7bRKjCHX714g73/3eZVOx+1Fc+yG+3qz7HowTF+4AhKOekljjxJfrLXbFXr43eB4y5YfSOLsgUWTwc4a1DNWBvkYBISAHdrmxO3Ug9iXTj3Gdb3LxmY31q7UBUD+tF6pY10rKJ6VW3VAeKNxsEdrTeiNb7DkkXHdXkXvjPaJXJOhvr94MKvRgFZB6YxRaJeROiNhe4QUVGxW20zevZ4KvMPShKMJ55kUbEAag6coCTManCcs6CTVtUNqJkp+F49fb570/OhJHmuJwRScuFX2w0NmJysWNv/XHKcWtgiygACG5curkODBPFBtgnX+h/EXeGSsG5QKlPVPazT4NM10Wkr+o1qjwLFOX2pHFIPMYOYxm0bits3j1HgVrJJfuRgkIKdsZ1u2DJR4m9Qr16ACpW2g1RJs52rRMgZohizsoLAC6nRWNfSCdgNHYHjN6zRyl3IVbowkLh1w3QXmMq3s8kIoXBdZKfrRC3axsyCOLBR31S0K1bv5FfgaC0PvWrffsf6AA0muNCsH2gRrUtmml23aUDK1gjA+921n9348y1yfUfCiIXOttqywonl7NDIO4cJmkiVUfOlc1Ovxpgo1xHns5dXEvXX0X0dMz89MRe42uftN4pIkVjWf4jHWGxSvCHmz20mopheILAXbFj0SC7AB2xk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR03MB5690.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700021)(22082099003)(7053199007)(56012099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SVVHRGtwb1lGa0R6MmtScE5QOTJKazgwT09RTExxLzJJQmF6TGtpVmlzczFC?=
 =?utf-8?B?bjlMY2dFNXRDRzRNNy82ZlAzWVUvcS9vak11TGo5dW9jM0wwTUdjdTRjVjZv?=
 =?utf-8?B?akpZUFdJR05CTkkyRTR6RnBOZSt4NHo4enhEeGFRMXAxbnN2aHBVZ0s4VUdx?=
 =?utf-8?B?TTVGdVFwSzhTMHZndUVzRjQ2QURpTFBLVXl1MmErYTJ4WWp6eE5PRDcrbE4w?=
 =?utf-8?B?T09xQy81dzhDYVVLZUVVeEx4YWVid2ZHSUJVM3lSSitCMmZIQnhmQkpJNUoy?=
 =?utf-8?B?MjF4di9rMnFtWCsrQkVaS1hwS3NBK3loaFJ4cTBmcDNUWWV6WmdHbktsVUJY?=
 =?utf-8?B?T1RDRkFVMDFPbnpsVEdwQXdaVXIrcW0wVEhTTGkyd1BQUFBTNzFlaU9UYVdI?=
 =?utf-8?B?MG5vVFZBeE1oWkYyRHpiWXgzMmNJZzhxNmE0dkhxTE1qNXhabUlKeFg5SGV2?=
 =?utf-8?B?R3ZhVXNXZjdmMHVGd3p6dmh5U1A2UEI4U1oxcnVjbW44VU9rYzdFaXJIbnF4?=
 =?utf-8?B?bWNVMjdoS2ZqVjZpSk4rMnlPNlJrVFVVRllhbDhSenl6cjhOUEdXTkZ3OXRy?=
 =?utf-8?B?MCt3dXlWeVpXaWJsei91bDY5SEJYU3pOdjRnZFpIUFdKSFZrdXJia1dYaytj?=
 =?utf-8?B?MW1RVkMzQ0hnWGJsV3Q1dU4wanNvd2NGbS9ucURKc1R4bHk5eUxnelpOK3pS?=
 =?utf-8?B?bVp5eXdmbXZwM3BWVEhzTWpvTTcyYTlzeFlCZEVQb1hEWkZGb3pEZGRBS01z?=
 =?utf-8?B?RXVZeFgwdkwva3RyNWdpTllGVTNlMnhJT281dDRXWTBhb0I3SGFoKzJTUEV2?=
 =?utf-8?B?TFphNzRNZUxuOEY3Qnp2NHZLTUYvYUpzMHJMRTBldGl3TlVmM3AvQS9YUXRX?=
 =?utf-8?B?NVllWVVZWVdlWGNWbHJ6bHB2N21KQURxbmR0TjgvZHZ0aEpEOG1KUUdTaTFr?=
 =?utf-8?B?cHJaWGxrUmprUWZsS1NOVllRQ2FOMWJKR0VUbSs5eTIzR0pnVEFQcEF3dnVS?=
 =?utf-8?B?aUcwL1VsdXlBTWwxUlZRYkhtN2NKa2ZJQkdzaHV0L0tJS1RaWEtDZlRTb0NE?=
 =?utf-8?B?R2VaWTZhcmp5dGtvMGtpR0swU05LZU0zWk5GUm9neXJOSnpZNCtvMVp1TXdj?=
 =?utf-8?B?VlVMcUdsWG1TbXZoWmR3dnRzSVlKUStFMjg2N2pYU0I0TTBOZWhPNzFrSm5F?=
 =?utf-8?B?LzN0TnNleFZGc2VFTkUrdEtCTnE4eU5vUW5IZUMwVlBqRXZjSys0eHJSS1VX?=
 =?utf-8?B?c3pqOGZwcE9IV1VhNmgwclhieTRnUWxMVU9KYWFEc1V3RWlkOGNwU3BROUc5?=
 =?utf-8?B?OVM2V3puVnMyM29qaU1pWjNPbkhZaWVmalh5ZzQ1NG9hYU1IN3phN2pCNFI5?=
 =?utf-8?B?OUdmczNUamxXMFdrRFFNd2MxMS9zZ25qZU5NK1ZncGQ4dmRSMWdJLzVldDh1?=
 =?utf-8?B?dnYzc2lpL1lSamRpRXJvL0pTZ3RRR3YzWUJiSVRhUXNVamhMcGxqdm5vdVYw?=
 =?utf-8?B?UHVDcjR4WDc1clZhTnBGSTBpN29RYytJL1hSbFpuekZWMGt2c1dyUlRFWmJT?=
 =?utf-8?B?VXpobi9PNjJxbkgxUW9NL3pIMzN0a1pPSHdpTjZyQmpHY1JyVi9paEEzZFRx?=
 =?utf-8?B?RWgwdUdkZ2tKcmgrdnlGNHlneksxMmNiY3A3NUt4WXpMNDdkUmsyeUdRbDRs?=
 =?utf-8?B?RktUeGR1eTBUQUdoU3VHNy95aXpnK1BjT3pnaXFCOXV1T2x4d212R0kxRFNk?=
 =?utf-8?B?Tm85ZndlRlZ6NGZMMXBhTjNwT0JWVWpMR2RHUEw4QWxJVVUyUzBQZFdRUTFY?=
 =?utf-8?B?UjVucDZOT0d6R0g1UVN3MnUrY3crSTBzZHZjaC9Cbmg1ZHJST1A0WWxwbEtu?=
 =?utf-8?B?ZGRxWFNNRXRBMWlDTWFkZkJWZFJvck5kVW03YmhtUkRVK0N3RTJRSWI4ZjVN?=
 =?utf-8?B?d2dDN2RPcEJ6YjBYTjVBMWNqdWFteklCTmtmcFRpVGlNdU9sekRIY1Nzc0Fk?=
 =?utf-8?B?NnZveUM4UFBzekoxRHBhN043eFdBc2JhRGljaXhZNEEwNVoxeEFrWVZZR0VG?=
 =?utf-8?B?Wk41MnpkSWpaQUpBdVlqTWdzZDFzU3BvVW9VQTVaV3NnRitqRlVUT29xWjdC?=
 =?utf-8?B?cUtDaXRjZmhJQnlJcEJTalRpODh4QWFheS9USzExMGgvYW5HV29ZN21hMTVZ?=
 =?utf-8?B?Y0lkTEpkN29wWHBja3F3Y3owWEVPUmlqZStsZ3YrSWphUmViYmlWdmFsSEhU?=
 =?utf-8?B?c01wMy8xaWNRNEZSejZzaEhiTkFvcW9Wbk5sSVZOWFk1QWovMTJtdDdVTWVF?=
 =?utf-8?B?bCtjcy9mVUg0bEZZRW9ZZHVYNTFNdVhNRWRjdWQ4UmZHOUszWENlKzlPSEpY?=
 =?utf-8?Q?Q3njkC4331TN4ZaE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8997D5182012AF468C5EB010ACC42EBD@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: gQmwARZ0Fr8Dg6uWs3xPIcwcRQgbmL7SMbh811yNwvdcgczBszlUy+QaJfbFtxU/6PoLTvRRH1N7FQCNZgZvd7OJDiFw7ErrvAluIuSSUTpLD6ZnHrsLzzs1aBjmTVsi0YWkXJaLMwgCodi7Q1nkMknTdtqfCb9E2cQryi6/0SGv0qtbCkFu1D4WZzev2M3bjy2OO5af+Uxy4sHIaMU8CnRQZF3ywcLjh15iVJ0ElMSTcBfR5o67NuEg1E/iacZ8qBLlPvRY+ypPlLp2BMtcFH7PzzBkKYGxK4BdzA7ntuCwK603e89pP3VZWfQTChTyC0T4DBJVKpfPnWzij4ucaQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR03MB5690.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f95b15a0-f43c-4879-6039-08de8a394c92
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2026 06:39:43.5063
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UC//kcpGi55J3D8t/1fEjtQ+NsYTV9zNSURcmEo71xcrAZWNg/UxpblJQN41W9J1YI93Rr72rwC4J/h68GajUZ/849PvFnLUIUKHwhj5vEk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR03MB6824
X-MTK: N

T24gV2VkLCAyMDI2LTAzLTE4IGF0IDE1OjE5ICswMTAwLCBncmVna2hAbGludXhmb3VuZGF0aW9u
Lm9yZyB3cm90ZToNCj4gT24gV2VkLCBNYXIgMTgsIDIwMjYgYXQgMTI6MTI6MzZQTSArMDAwMCwg
WmhpeW9uZyBUYW8gKOmZtuW/l+WLhykgd3JvdGU6DQo+ID4gT24gV2VkLCAyMDI2LTAxLTIxIGF0
IDE0OjIzICswODAwLCBaaGl5b25nIFRhbyB3cm90ZToNCj4gPiA+IE9uIFR1ZSwgMjAyNi0wMS0w
NiBhdCAxMTowMiArMDEwMCwgR3JlZyBLSCB3cm90ZToNCj4gPiA+ID4gT24gTW9uLCBKYW4gMDUs
IDIwMjYgYXQgMTA6Mzk6NTVBTSArMDgwMCwgWmhpeW9uZyBUYW8gd3JvdGU6DQo+ID4gPiA+ID4g
RnJvbTogIlpoaXlvbmcuVGFvIiA8emhpeW9uZy50YW9AbWVkaWF0ZWsuY29tPg0KPiA+ID4gPiA+
IA0KPiA+ID4gPiA+IEFkZCBBQ1BJIHN1cHBvcnQgdG8gODI1MF9tdGsgZHJpdmVyLiBUaGlzIG1h
a2VzIGl0IHBvc3NpYmxlDQo+ID4gPiA+ID4gdG8NCj4gPiA+ID4gPiB1c2UgVUFSVCBvbiBBUk0t
YmFzZWQgZGVza3RvcHMgd2l0aCBFREsyIFVFRkkgZmlybXdhcmUuDQo+ID4gPiA+ID4gDQo+ID4g
PiA+ID4gU2lnbmVkLW9mZi1ieTogWWVuY2hpYSBDaGVuIDx5ZW5jaGlhLmNoZW5AbWVkaWF0ZWsu
Y29tPg0KPiA+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IFpoaXlvbmcuVGFvIDx6aGl5b25nLnRhb0Bt
ZWRpYXRlay5jb20+DQo+ID4gPiA+ID4gLS0tDQo+ID4gPiA+ID4gwqBkcml2ZXJzL3R0eS9zZXJp
YWwvODI1MC84MjUwX210ay5jIHwgMjMgKysrKysrKysrKysrKysrKysrKy0NCj4gPiA+ID4gPiAt
LS0NCj4gPiA+ID4gPiDCoDEgZmlsZSBjaGFuZ2VkLCAxOSBpbnNlcnRpb25zKCspLCA0IGRlbGV0
aW9ucygtKQ0KDQo9PT5IaSBHcmVnLA0KDQpZZXMsIGl0IGlzIGEgcmVzZW5kIG9mIHRoZSBwcmV2
aW91cyB2ZXJzaW9uIHRvIHJlYmFzZSB0byB0aXAgZm9yDQpmcmllbmRseSBwaW5nLiBpdCBpcyBi
YXNlZCBvbiB0aGUgbGF0ZXN0IGxpbnV4LW5leHQgdmVyc2lvbi4NCg0KVGhhbmtzDQoNCj4gPiA+
ID4gDQo+ID4gPiA+IFRoaXMgaXMgYSByZXNlbmQgb2YgdGhlIHByZXZpb3VzIHZlcnNpb24sIHJp
Z2h0P8KgIE9yIGRpZA0KPiA+ID4gPiBzb21ldGhpbmcNCj4gPiA+ID4gY2hhbmdlPw0KPiA+ID4g
PiANCj4gPiA+ID4gY29uZnVzZWQsDQo+ID4gPiA+IA0KPiA+ID4gPiBncmVnIGstaA0KPiA+ID4g
DQo+ID4gPiA9PT4gSGkgR3JlZywNCj4gPiA+IFllcywgcHJldmlvdXNseSBZZW5jaGlhIENoZW4g
aGVscGVkIHRvIHNlbmQgb3V0IGEgdmVyc2lvbi4NCj4gPiA+IEN1cnJlbnRseSwNCj4gPiA+IHRo
aXMgc29sdXRpb24gaXMgc3BlY2lmaWNhbGx5IGZvciB0aGUgR0IxMCBwcm9qZWN0IGFuZCB3YXMg
bWFkZQ0KPiA+ID4gdG8NCj4gPiA+IHN1cHBvcnQgV2luZG93cyBBQ1BJIHNldHRpbmdzLiANCj4g
PiA+IA0KPiA+ID4gSW4gYWN0dWFsIGFwcGxpY2F0aW9uIHNjZW5hcmlvcywgdGhlIGFwZG1hIGNs
ayB3aWxsIG5vdCBiZSB0dXJuZWQNCj4gPiA+IG9mZg0KPiA+ID4gaW4gbm9ybWFsIG1vZGUuIEl0
IGlzIG9ubHkgdHVybmVkIG9mZiBpbiB0aGUgU1NQTSBtaWNyb3Byb2Nlc3Nvcg0KPiA+ID4gYWZ0
ZXINCj4gPiA+IGVudGVyaW5nIHN0YW5kYnksIGFuZCB3aGVuIHJlc3VtaW5nLCB0aGUgYXBkbWEg
Y2xrIGlzIHJlLWVuYWJsZWQNCj4gPiA+IGJ5DQo+ID4gPiBTU1BNLg0KPiA+ID4gDQo+ID4gPiBB
cyBmb3Igb3RoZXIgTGludXggcHJvamVjdHMsIGFwZG1hIHN0aWxsIHVzZXMgdGhlIERUUyBub2Rl
Lg0KPiA+ID4gDQo+ID4gPiBUaGFua3MNCj4gPiA+IA0KPiA+IA0KPiA+IEhpIEdyZWcsDQo+ID4g
RG8geW91IGhhdmUgb3RoZXIgc3VnZ2VzdGlvbiBmb3IgdGhpcz8NCj4gDQo+IFlvdSBjYW4ndCBq
dXN0IHJlc2VuZCBzb21ldGhpbmcgYW5kIG5vdCBzYXkgd2h5IHlvdSBhcmUgcmVzZW5kaW5nIGl0
Lg0KPiBBbHNvLCB0aGUgYXV0aG9yc2hpcCBpbmZvcm1hdGlvbiBzZWVtcyB0byBiZSBiYWNrd2Fy
ZHMuDQo+IA0KPiB0aGFua3MsDQo+IA0KPiBncmVnIGstaA0KDQo=

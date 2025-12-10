Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CC7B2FFFB2;
	Wed, 10 Dec 2025 16:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765383593; cv=fail; b=KkuXtU80+haiWJ5QLC2TU0hcvmGv7mTjHcUYZO0YhFOPRup8svmsvqs9d/UsUzbrz1FsWa2Y1XnXcMu4sUdnu3JslrBctYwHaEFSxxA0wDDJnhTFKkMAKZaNEG5K5uGEQ6iFeKrZuppzSJrVlaxEWPaq4K7MZknxEXdYyTr18mo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765383593; c=relaxed/simple;
	bh=tVzGQ/o2eV74I9OjVnCu9SfGebQPH63DvmpIK2a0p1g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=V1bk7Mb0pHxd8wv1SpvgHiFE9XtVvqKPtE/5GLslJ1veOUmWqAlPuevulYNzKPSnMQWzqxWGwrtWxenB7V1mVgcimrg8s0BdJFbbumc6SalolH1GyG31L5PQCH8+2TVDpQEtQXakSTlswdA3690fo3gmWo0kZSo61HpteS9h/Ps=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=nBEzcBNr; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=s2foePNy; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="nBEzcBNr";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="s2foePNy"
X-UUID: 09f958acd5e411f0b2bf0b349165d6e0-20251211
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=tVzGQ/o2eV74I9OjVnCu9SfGebQPH63DvmpIK2a0p1g=;
	b=nBEzcBNrIpQb5kk6d31DYo6mxKmxSfw6HSaJQD5/YdgEBa54zR1lBS/b6Z/5BMOaw9AAJVYVi0GSbYPHNwdumr0QsxlJ//ySQ8+EFZhjKceHdeaMREmxrMca9DuVbMmy5t+r/kK3vBcRqEFEI6VAOgkDbSio8+ApRBj3A1GsBj0=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:ae26c538-0ec1-467d-83c5-de2ed4cdaee0,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:a9d874c,CLOUDID:02c80baa-6421-45b1-b8b8-e73e3dc9a90f,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111|836|888|898,
	TC:-5,Content:0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BE
	C:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 09f958acd5e411f0b2bf0b349165d6e0-20251211
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
	(envelope-from <macpaul.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 2141656674; Thu, 11 Dec 2025 00:19:44 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 11 Dec 2025 00:19:42 +0800
Received: from SI4PR04CU001.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1748.26 via Frontend Transport; Thu, 11 Dec 2025 00:19:42 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C6PTPhbf9KR89Yh8wJyX36mkcO7bPaJnQ9XnTNi8VRN7Ju7kLthqT1g2rhTys68wDEOBkK+mgwgFXI5X94PniM0oAqJ35sWx0iRjXMCsvfKtXsFGn/S975gnosdtnEDjW35rN+1EHcd6P9ZtYFMB8Uk9+CUujFuHa4LXaiDY0sumuzfR9vi0eSqKv/ZiOdQ4cYd5KtJlFh9U0RuoV8LnILLbmta1YF5rTHbMyQvQuhbSU7cSNmVlsSN6EJ7JQYfALJiRAES2otikxR5MlNYnTmldXETT9+ZTCH1TqfG6bX+7uVBuQrdJ4+Fxeh0ffR0sakkdlrWQwuV1xeaUdwPS0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tVzGQ/o2eV74I9OjVnCu9SfGebQPH63DvmpIK2a0p1g=;
 b=AZV+09FCYhssjkSmkkozeepqv+BTrYVXHKVNSx+HUec99491SkIKdn+ENky/qu8VSbJFFDIBKX+zWb/mqCT+JYLJJK+eb1bvwERFCk2+2Fl3YedEnevpUNP96wHjiLMyo+c4AEcccr5tfMa+BCV6yR+F4QKxwxogN+nhSO+JHPhwwNutfJYoajL6Pg0yiikBnl+1M/DiL8HtOxal0yswNQ8ZyTBWxmhqJPjmB5D7QlHOK9IvoYArZCzGTiuS9KZinKxW3yJrxOyOuugmIwW8Ksa80mrHJqdDAVd0nk2WZLPmozYasc+o5LcVfcDXmu/TuYa6PFPW1D19Fs2j1yZhkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tVzGQ/o2eV74I9OjVnCu9SfGebQPH63DvmpIK2a0p1g=;
 b=s2foePNyEb4lwYkICvWm8cvPhmtMwaaggn+ryw/axA33fkgAZT/LcqZ3sQru3X1+yKaxqrcNtKCkiUe50/n7m5wb1iZsxtMLgdG8rK/rbuWYEleGs9jQqBsIl3MHVyw0o+rZHBlNL+eThA9+F9qqJbxmtJmi+bsoR+Dxdw5/bHM=
Received: from SEZPR03MB7810.apcprd03.prod.outlook.com (2603:1096:101:184::13)
 by TYUPR03MB7230.apcprd03.prod.outlook.com (2603:1096:400:356::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.7; Wed, 10 Dec
 2025 16:19:38 +0000
Received: from SEZPR03MB7810.apcprd03.prod.outlook.com
 ([fe80::2557:de4d:a3c7:41e8]) by SEZPR03MB7810.apcprd03.prod.outlook.com
 ([fe80::2557:de4d:a3c7:41e8%4]) with mapi id 15.20.9412.005; Wed, 10 Dec 2025
 16:19:37 +0000
From: =?utf-8?B?TWFjcGF1bCBMaW4gKOael+aZuuaWjCk=?= <Macpaul.Lin@mediatek.com>
To: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "jirislaby@kernel.org" <jirislaby@kernel.org>, "Sean
 Wang" <Sean.Wang@mediatek.com>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>
CC: =?utf-8?B?QmVhciBXYW5nICjokKnljp/mg5/lvrcp?= <bear.wang@mediatek.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	=?utf-8?B?UGFibG8gU3VuICjlravmr5Pnv5Qp?= <pablo.sun@mediatek.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-serial@vger.kernel.org"
	<linux-serial@vger.kernel.org>, "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>, "kernel@collabora.com"
	<kernel@collabora.com>
Subject: Re: [PATCH 1/4] dt-bindings: serial: mediatek,uart: Add compatible
 for MT8189 SoC
Thread-Topic: [PATCH 1/4] dt-bindings: serial: mediatek,uart: Add compatible
 for MT8189 SoC
Thread-Index: AQHcZF0uL1pnI+mXKUiUyk/nFgXBebUbGNSA
Date: Wed, 10 Dec 2025 16:19:37 +0000
Message-ID: <b5cbb1fa0e56d926b4e9c0938d1364533d265c90.camel@mediatek.com>
References: <20251203-add-mediatek-genio-520-720-evk-v1-0-df794b2a30ae@collabora.com>
	 <20251203-add-mediatek-genio-520-720-evk-v1-1-df794b2a30ae@collabora.com>
In-Reply-To: <20251203-add-mediatek-genio-520-720-evk-v1-1-df794b2a30ae@collabora.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR03MB7810:EE_|TYUPR03MB7230:EE_
x-ms-office365-filtering-correlation-id: 16d1c8c8-db73-4986-2a3f-08de3807ea29
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?ekJYZWEzRnA1bmx0SVhhZStKeWlxS2hObHNEc29Fa25sYnRBQjFOcU1zTlht?=
 =?utf-8?B?NmNwQ3U1ZHRBSk4zRitVbUQ4MUdGSlZDKzBtclo2MEdDa0ZDb2o3dUU2NUhp?=
 =?utf-8?B?T2hvcHlMTHN1ckdwVWMwWTVMZFNmbVdUbmM2cDM3ZkgySlg2eG1yREs4eW0z?=
 =?utf-8?B?UUZoMGF0ekdvb21xVDlMcUg3WjZXckJ4aFRVZHdQdHB0KzRPeDJPd2kxU3g3?=
 =?utf-8?B?QThNMjZHb093VlJLNnJ0NnR5MDRPbUdJMnV2VUZQMXpxRWtPbDBFaEM5eEdo?=
 =?utf-8?B?dEJ1RGhoK2FMOXdyMHFaZkJBMURZeVNkUVk0Y2JISWZDRzcra2ZkQThISmsy?=
 =?utf-8?B?aW1YNXBXYmtFQzVwSGhLdWd5TGE3NWh6bW9iWDJTREpWbVJGek1XTmZQbU5L?=
 =?utf-8?B?R3JvSDhaNVQ5WVRrK3pnRW9IMzFzQmFyMUFWWkxNcEMxanRYQ0tSdDhhc1Bv?=
 =?utf-8?B?UDBsZUFpZWNySVZtOCs1bnpSbUNnb3dGbnhNYU1SQ2h0RlgxVVAvdGY4eUFm?=
 =?utf-8?B?OTBXbnhZSzdJUWNQaWc0czMyNmNVUU8wVWlWQmRCeUNNcEJPeDA3UnNkMiti?=
 =?utf-8?B?Nk4yYmlOdCtSaE01UkpiSWk5aXlNM2R2eXl3TTUzcW1LcGcybTFEbEdBeWta?=
 =?utf-8?B?UjJKN3JrYlhNa3dkZzgxSTJ5RmZaMzcvY3ZuV2h4azFIZXYxM3ZiMmVqbGFm?=
 =?utf-8?B?VU5VL2Z2RW55b1NzRU8xRnpGMTN0UlVPbGYvSUZuRG1RZlJjZ3FJVkJWQldX?=
 =?utf-8?B?OGw4R3ByeXZpby9vcDkvcVQ3aklMRVRqb2ZzYTJHZ1liMzR4UlVEbGpNNnlI?=
 =?utf-8?B?RmZUSmlsNUhUaVRLcFZnak9CZkZSK290Wi9Sekhla2xDVmdSWDRxa2tuVy91?=
 =?utf-8?B?cU9hekVoMFNXSlgvZW5VM2RBWWg4WnM4TFhYY1hNUzNobTltY2IvenlKaGZK?=
 =?utf-8?B?eDA2T0ZaY0ZGSGxaME5sd3h5QzBPcW1DSytvUmpyaGhoNDZpaDlUWmhjcUJo?=
 =?utf-8?B?aURnQXhKaFJJN2JpVGR0eXljNDloSUVvbWFiT0xzc3psSWZwdHdqZW54SjJY?=
 =?utf-8?B?czUrdTZya3dGMFdCcGdLNDRaM1RTTFhweGpZZmROOWlJOU5QZmRuZDV1a0ha?=
 =?utf-8?B?QWRNOXdTZE1PSWc0cEpqdStVZjg3UURHaUhiK0FHQVN2RTRiWE8wOStlQUZP?=
 =?utf-8?B?bjNYMFVjeEJtN0xsaVQxZUhBdVAwclhCYnpoR0s4QmhDdzBGd043dkhiK1ZB?=
 =?utf-8?B?WnlQbUdIRjBRV1h2MmFHOW5IRHV4VzFEeGNmOXp6TGZQNDhhaENIYmpRbXN4?=
 =?utf-8?B?UVZkWmRESVloUlFyOHZHY0UyMjFmT293ZnZVNUlCYm5SaDJranp3Q3dSeWEw?=
 =?utf-8?B?MkRwMk5TZTQ1NzFaTDF4Q0VKSXp1d0p1REpRSTFIY09wQjhYQXhMR1AzZGxh?=
 =?utf-8?B?V2lQTDA2MEYzS3BOZUNtcjBvdjhOMXo0ck9yU3k0ZXBML3BhUFNNYmVrcS9x?=
 =?utf-8?B?UXdUVnMyZnNVNEp4b0VxTWlnMHg5LzRPY0VybDlnNGR2cUNCbnZmalZDR05E?=
 =?utf-8?B?SGJHR09vcDgwQjVRQVZVc1BtdDcyRElGeS9hcGozeFZ5U2YrMjNpbEt5QXlV?=
 =?utf-8?B?UlVLSFVrV2owMTE3RERCVjVicHFVUm5RUlFvWnBET2lpOHFHK0ZUN2dKZDFR?=
 =?utf-8?B?eWRQMitqa0N1MzM2VWFIYUh2WDdpbWFGVzFZQWJPa1d3ZkxZbEkxNGt6NnF4?=
 =?utf-8?B?LzhJTWlTVmJ1U3hHSHR2UWdicVJhQUNYM00yQ2lpUXhKTVllcWc4ZW9OSUpZ?=
 =?utf-8?B?STVOZUVLRDVweVpGbTZ5OTNHTGp1WUFSbGNoZ1lNSForaG5JdzFvUjdKNkEx?=
 =?utf-8?B?b3RnblpvdWE4SDJ3UlNIV21lVi9UTkVabUlEV05ZL0ViTnVMV1JGM3dwdFNa?=
 =?utf-8?B?NHJ0dEhDMUxnTGxDM1hQc3YvSnE1SGlITWdaTm01UVMwQmVOQU1aQlltenVM?=
 =?utf-8?B?OHRJSStWdzNoYWx6Um5KOFd4RnpmSmZTUjNUM0VxSzNRQk5ZbUVMemFxNEpM?=
 =?utf-8?Q?jfEEn+?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR03MB7810.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dVk1OEpqRTFTNndpVWQybEFSVjZLTFhnY0lwME9vMUtPb2g4ZUZuMkhjR3pU?=
 =?utf-8?B?eFFHYkdOTTZXanlJcCtKTTJQaEpMRWE3RU00Y1JManJJazkvT0s4cFlTUTRa?=
 =?utf-8?B?T0dQK1ZKTTdUZnEwMCtJZWxsQ1pRUTI2bW11WDRiUEZrSHF0cEFGblZ2UnJu?=
 =?utf-8?B?U2pBM1pJaG9JUXFaNjE1SHlFcWxyNXNHcFNESFZNd040VldZa0gwTVUrODJz?=
 =?utf-8?B?ZjBsakdybDlZQ2d3V2hldTkwRFNzUTZKNHpKMXdyVFF5eXFoem9JNWp6dlJ1?=
 =?utf-8?B?U2FxVmxyKzZ2b3Z3TldJc0NXSUlPR1dsNkgyYkp2QVNrMmxieCtyaUhDRTQ2?=
 =?utf-8?B?andjUytTYlIwRnRKcU8zejdtSTdRb05ab21CcHBHV0prZHpsakMvcHVqR0pT?=
 =?utf-8?B?M2kzb1Qxd1ErdENIVVNpVGxOajlRQXlMYjM1bklzc20xVVRLK0VZdkxGZFRx?=
 =?utf-8?B?dG1tbCtoRUZRRTUzd0pzYlNlZjdvbDhTWlRNMWY2aWZVeW9SZWJNRzdxZ0xv?=
 =?utf-8?B?NENCRHBOeWw3cEYzNEw1V1RaT0ZmWWdKRUtxbHd1RkFGQkd0RzdtK2dVWHMr?=
 =?utf-8?B?eHJDQ2VKTnVIbHNhVTJ3Q3lrc0RjQXdURm5tVFRTTTd4Q3pCazVJMEhwR05m?=
 =?utf-8?B?eE5sbW96WWJzc21WamM0VDVnUEU3NWNVMmU1anJBdS9uQjc3akYreDhaOVRm?=
 =?utf-8?B?TGo0Ry8zM3BRWHRtWDB5bkVxRDVzS2xaN1FqWUVBMHB0cmNzV0dndjlTeWRC?=
 =?utf-8?B?T2NZcnNWRnlONzc4REVYNnRaYVQvQVU4MnhYMW13VHVwbk81S3l0K2Vyc0tI?=
 =?utf-8?B?am1aOWlNZVNNeE50ZE1NOE5uZHh6VGFaY1lXUDRQbURLY1h0aXBoalV5RkMy?=
 =?utf-8?B?MmJjUHZXcEJaU0FRWTlkSVRsTFZiSWN4cTBOYnJpakNEbW5haW9GU2l4dGxt?=
 =?utf-8?B?a3gvaHJhazFFYldwV3BsUU5CQ2pWUWFpZnA2TEtEWGhla3Jrd2tVM1o2ZENM?=
 =?utf-8?B?SGVyQkp6NmVGYlZ2NWNpVmV3SmkvUjRMRzJFaUNrT2VtWHRpWGV3RXEvV3ZM?=
 =?utf-8?B?bkEyZllDY01RVDF2MnVJNjlISWRBVkcyVTl3eHVLb2REYkwrWmJJVWJCUkp3?=
 =?utf-8?B?VUdKcEdpeCtmc0dab2Zsak0xdUhSRDRpR056NGRHSHA3UTViQmtXS3gxb0xJ?=
 =?utf-8?B?UGluN1pRRFZTSjJzL1VCOGNzSG9uMTFiazFRazRzU2h5SVFNT0w4bjJjN2RE?=
 =?utf-8?B?SytvY21PWHRjUWVXMXhRWmlEL0RRWGF0YjBHQTZkYzRObTB5aDdkUSt6cUNw?=
 =?utf-8?B?eWJtVC9GZ1N2STJkOStvMDJMaTZuZmpic1VRZkJHRUV3a0dIRUZGdmNuN0s5?=
 =?utf-8?B?TCtRMTRleWN2VW5xaFpHdEFONmxwUVVndlNFMFl2cHNqYzkwUW1VS0dWQ0xw?=
 =?utf-8?B?U3AvcWxEamloeTVydWtZM2plVXVvU0k2OHpwZUxVa3VOMUdMelJXbHBRSTVn?=
 =?utf-8?B?VmR4SGNYa3o0YURVTEdXUGhNcHRWVjlsV1VvbmNOSHdOOVBuMXovWTc2U0xX?=
 =?utf-8?B?M0gySWJJVHdoenVPaDNMOEhNaU8rQUZIWC9ZSlk5YnVUNXhxcy80VysvMkll?=
 =?utf-8?B?R3J1U1hVa3BwT1dVajZDTlB4amY5cVU3TzVFeXdZSGh0SHFFVjROQjRyUFpK?=
 =?utf-8?B?MWcya0k3ZGlRNGdqR09yc1NrQXNMSjZxR0xQNnNCNjc2c0wyYXh6bUllTkw4?=
 =?utf-8?B?R0gwRGU2Z0pUcE5yLzVqTFBoS0lMKzVlemZ4WUQzMmw0MUQrTTNWbkNGVlNm?=
 =?utf-8?B?MnZ1QWpMTUdYRmZ4eXdoZzJnNTFnVkpqQTczQ0ljYlNGUU9iSWxRRXY0WkNk?=
 =?utf-8?B?VUxyZ0x4cXRvTXpHL3VDalFKSllZNDdKMTl5RjM5RWEyK2tWMjVzZmNGTnBV?=
 =?utf-8?B?V1orUStvVng2aWVqM3FwckIxaWpMMWFpUHhDbTc1QVNpcGhVWnFvZ2VsQk5H?=
 =?utf-8?B?THRMNXJmdTBEZGhLR1B1bjY1TmIrZUhMbUZnNGQrVW5jak1kYStRT2gyU2hT?=
 =?utf-8?B?bk1ETGV5a1p0Q2NsOHlOUHJwUkpXMURvY2FvcGlRQjA3Wmt2N3hJbEZKMVZF?=
 =?utf-8?B?RkFlQUt4bDd6K2xzbllET3pLMDZzUTlOdDRNRWRwWnJGTENCSWxpQ0FIOU13?=
 =?utf-8?B?Wnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <04DB5CB4A28098449BCBD3721F76E339@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR03MB7810.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16d1c8c8-db73-4986-2a3f-08de3807ea29
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2025 16:19:37.7365
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kCfKMZnm2gkjuydaWnt+MYCcMWmBPdktl4AorWd3vAJEoiquoVbL6fbozSGNiIcWk23IELbIf5XUOc4knZDXwIbv1ieuYL7wRZzIn5FjgW8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYUPR03MB7230

T24gV2VkLCAyMDI1LTEyLTAzIGF0IDE0OjU5ICswMTAwLCBMb3Vpcy1BbGV4aXMgRXlyYXVkIHdy
b3RlOg0KPiANCj4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtzIG9y
IG9wZW4gYXR0YWNobWVudHMgdW50aWwNCj4geW91IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRlciBv
ciB0aGUgY29udGVudC4NCj4gDQo+IA0KPiBBZGQgYSBjb21wYXRpYmxlIHN0cmluZyBmb3IgdGhl
IE1UODE4OSBTb0MuDQo+IFRoZSBVQVJUIElQcyBpbiB0aGlzIGNoaXAgYXJlIGZ1bGx5IGNvbXBh
dGlibGUgd2l0aCB0aGUgb25lIGZvdW5kIGluDQo+IE1UNjU3NyBTb0MuDQo+IA0KPiBTaWduZWQt
b2ZmLWJ5OiBMb3Vpcy1BbGV4aXMgRXlyYXVkIDxsb3Vpc2FsZXhpcy5leXJhdWRAY29sbGFib3Jh
LmNvbT4NCj4gLS0tDQo+IMKgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3Nlcmlh
bC9tZWRpYXRlayx1YXJ0LnlhbWwgfCAxICsNCj4gwqAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRp
b24oKykNCj4gDQo+IGRpZmYgLS1naXQNCj4gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmlu
ZGluZ3Mvc2VyaWFsL21lZGlhdGVrLHVhcnQueWFtbA0KPiBiL0RvY3VtZW50YXRpb24vZGV2aWNl
dHJlZS9iaW5kaW5ncy9zZXJpYWwvbWVkaWF0ZWssdWFydC55YW1sDQo+IGluZGV4DQo+IDViZDhh
ODg1M2FlMGQ0YWUzMDlkMjgzNTBmZDU0YjZmOWI0ZTczMWUuLjNmMGY0YWVhMGE0YzBlZjExMDU1
ZGRkMDhiYQ0KPiA3MWQwNDVlN2ZhNTE5IDEwMDY0NA0KPiAtLS0gYS9Eb2N1bWVudGF0aW9uL2Rl
dmljZXRyZWUvYmluZGluZ3Mvc2VyaWFsL21lZGlhdGVrLHVhcnQueWFtbA0KPiArKysgYi9Eb2N1
bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mvc2VyaWFsL21lZGlhdGVrLHVhcnQueWFtbA0K
PiBAQCAtNDcsNiArNDcsNyBAQCBwcm9wZXJ0aWVzOg0KPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIC0gbWVkaWF0ZWssbXQ4MTgzLXVhcnQNCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCAtIG1lZGlhdGVrLG10ODE4Ni11YXJ0DQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgLSBtZWRpYXRlayxtdDgxODgtdWFydA0KPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
LSBtZWRpYXRlayxtdDgxODktdWFydA0KPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIC0g
bWVkaWF0ZWssbXQ4MTkyLXVhcnQNCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAtIG1l
ZGlhdGVrLG10ODE5NS11YXJ0DQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgLSBtZWRp
YXRlayxtdDgzNjUtdWFydA0KPiANCj4gLS0NCj4gMi41Mi4wDQo+IA0KPiANCg0KUmV2aWV3ZWQt
YnkgTWFjcGF1bCBMaW4gPG1hY3BhdWwubGluQG1lZGlhdGVrLmNvbT4NCg0KQmVzdCByZWdhcmRz
LA0KTWFjcGF1bCBMaW4NCg==

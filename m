Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2080.outbound.protection.outlook.com [40.107.7.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 554125D8E8
	for <linux-serial@vger.kernel.org>; Tue, 20 Feb 2024 08:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708418358; cv=fail; b=Lg4bM8LjYKLBoFERpB5RHtRp4EUESRkX2aD8S2OI1HBMlKJoHspvP/qvkwf+mA7mIIpVzcz7GknUyNKe8GQwdNElBsQcv9gc0uz5j6SoCRlI7UXuLP8YCbmv9BLsm3/c1HUuuXgO/kCZo76RZPxt0bOndOF6d9BpjsqzU2rVXd0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708418358; c=relaxed/simple;
	bh=u4MhHT6+fhLgqO9Ng7ILpKlKLbWW4Qh2ru1ehQMYFYM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fBdQ5pww/XmHRMuKrzP0BI5QteDfYco61hHHAmmFY5KdBt75AueZ5SpNSUILZI9VEAkq6oPsGPRVDBL1N18eqLFrDzvLM6FpRv6ALil4K+4abZcHhY4vDzK1nb1S3y9CgV3qvinqglYUKon61moOyXXhwyk8S1bh1HnygANywl4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=n5kwNyk2; arc=fail smtp.client-ip=40.107.7.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="n5kwNyk2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vey5n9h/5MxXa/gsNuj3G3vZojcuHbelUvxINQo2MgWIhjViJNZbAzQ910kg7TOv0CXgWWAD6eJPlu2sbegn1JFrwO4FipkmB4WXJ7vBRzjUtJGBM2HWFtIN8uWcMyueqJmPZFKBplZKgJPJ8/IbKDLflzX6GmrHPbuJbQGBvxelRepSswZxHAqmksHAWbTSWClOWxPHtNvAd5zDiAp87GH2zoi3vRz63mvqN2IeEef2qS/WEWxft8KCy+WDvxKyAkyLHiUp8EV2UcZuAOxRnGoQdDEoVoMStT2DPyUi0VWCEw9m0cv7fgv8eyTNAJTWrf+3g1zaXBt5Eta9L36WYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u4MhHT6+fhLgqO9Ng7ILpKlKLbWW4Qh2ru1ehQMYFYM=;
 b=muqKhaCrtYKhQQN9lIJYwfrENqWzNcnPn/s0WBxB70Fv54MVwgzNhP1TCbmwO+lfGZUjBAeXgoBzZz0ckTRHPMzInYN3TG+corcErwtyPdBK03uKDboqly4fmCzpmc3bwmIG0+Y9Z7mAl1ML/U3K3Vairati1UUa4gSAe4CGTV+Wt5H3aTFZUBGDv1GW31EYMwOUVpaOxD+zmn3Ptr3Un6KvSHJw5se4lnKF6LSd7rlPjq3b8Dh0VoX8Sl5yLzi8EDYJ0+tr37hsC+pDgD1BPU0B0y7f9qTCjdSxWNOnvAsI7agTdWJkeOU1Qbtr28lyi2kNvngc2g8sx9xogpwppw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axis.com; dmarc=pass action=none header.from=axis.com;
 dkim=pass header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u4MhHT6+fhLgqO9Ng7ILpKlKLbWW4Qh2ru1ehQMYFYM=;
 b=n5kwNyk29fYXH6mN6M3U2slQZlu0nut8KlT9YtcRyJ8gQu39bfyrsCIu0dHpZancx7kkofGtQzSe6dCmLmas28tcVYxTuaUn3xhjcmoaibPBp6to2xOHpuZzWkIpTZmvPOxvWhx7EPih3ZrzsceSqBkfCxcu7yS8JzvWhy9TXIs=
Received: from AS8PR02MB9505.eurprd02.prod.outlook.com (2603:10a6:20b:5a4::17)
 by AS2PR02MB9239.eurprd02.prod.outlook.com (2603:10a6:20b:5ff::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.39; Tue, 20 Feb
 2024 08:39:11 +0000
Received: from AS8PR02MB9505.eurprd02.prod.outlook.com
 ([fe80::206b:6313:195:cea5]) by AS8PR02MB9505.eurprd02.prod.outlook.com
 ([fe80::206b:6313:195:cea5%4]) with mapi id 15.20.7292.036; Tue, 20 Feb 2024
 08:39:11 +0000
From: Rickard X Andersson <Rickard.Andersson@axis.com>
To: Marek Vasut <marex@denx.de>, "linux-serial@vger.kernel.org"
	<linux-serial@vger.kernel.org>, "rickard314.andersson@gmail.com"
	<rickard314.andersson@gmail.com>, "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>, "shawnguo@kernel.org" <shawnguo@kernel.org>,
	"s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "kernel@pengutronix.de"
	<kernel@pengutronix.de>, "festevam@gmail.com" <festevam@gmail.com>,
	"linux-imx@nxp.com" <linux-imx@nxp.com>, "martin.fuzzey@flowbird.group"
	<martin.fuzzey@flowbird.group>, Christoph Niedermaier
	<cniedermaier@dh-electronics.com>
CC: kernel <kernel@axis.com>
Subject: Re: [PATCH] tty: serial: imx: Fix broken RS485
Thread-Topic: [PATCH] tty: serial: imx: Fix broken RS485
Thread-Index: AQHaYNYuUklxWqRruUu9inbC0l9gq7ENFMWAgAWuUCqAAA4DgIAAG7yn
Date: Tue, 20 Feb 2024 08:39:11 +0000
Message-ID:
 <AS8PR02MB95056A7F8A964A8A09B31BC481502@AS8PR02MB9505.eurprd02.prod.outlook.com>
References: <20240216124601.3752039-1-rickaran@axis.com>
 <e39a6ecd-1250-4889-99aa-31a5a219f6a5@denx.de>
 <AS8PR02MB950598080305172CFBE4B0D381502@AS8PR02MB9505.eurprd02.prod.outlook.com>
 <bba053d5-c182-41db-b9d5-fbb239fb9ea7@denx.de>
In-Reply-To: <bba053d5-c182-41db-b9d5-fbb239fb9ea7@denx.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR02MB9505:EE_|AS2PR02MB9239:EE_
x-ms-office365-filtering-correlation-id: fcef589f-a88e-4e3f-e965-08dc31ef6965
x-ld-processed: 78703d3c-b907-432f-b066-88f7af9ca3af,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 JKXNXQKTIRoUEwwAHWa3T4GEfNojEMzFrBoYV8IpPoKelODjNxqisCKiKFcR/oa4zhlSJQK3jZq1BFQvtOac3apS5iNebORWVA/SVEH630bk5VKTvZTkGWrK2mhyhB1SDQe3cIqlFoZkhUcTmQDKOvMGTHZ0mLgm8HHY9VqztMcYQP/jKB2oMH65DnRJdx7AP8R99fl0GnpcnV5uVOtAjduc4PRzR4LITKT5qIbReeQO09gSi0K1+5VpMHL1vJjkofzgwLaiWQ2XSEBLJTgYpBvl6c1Nzug5rBP6CerFf/n8wzsXsb43RKLameZx4ayt4QEEsNCJSYat4P4efmm8+1TZd9ijE8kaUJonY3n0Tx9xsqTTNIzXzM76QMyPj3CXXeY5O2XaxDtmAWk0Idom8xNAFYvjpwMMcJBX2jxy6812mLUkkZFos0U03wcuGmnU/R3rwx5bbDwxOCbmP3BUxD1XUvf/OCGDDBTjbPoAmi/GaVdA1M7JeKJE0Rzb2FJaWmwFAR5IANlzFRq4hb7YwgWTvVlgOO6g7IBnD60qOCl/7P2qb/gRFOTaXTrBpJeKeimV4U+6dx2toVM3dan7odhYCWp8pp87P17gNYmKpT8r7OXbJUiuAwtJJI0Z4LflD18aIQWkIit7WCq6ctSnGw==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR02MB9505.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(921011)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MnVNQ0hkUE4xTkdpSmdSek9KRS81dTFLWGFkMjI2cCtmc3NKRzlpOU0rQis5?=
 =?utf-8?B?NE1sR3BOYkx3UTdFRi9YNlgvU2xhR3NNdkpjNnJ0OGR6aXFtVEd0K2dFMEFz?=
 =?utf-8?B?ZEV6eDNGcTRUK0gyN0pNdFpkeWtDSU10UVVoayt2bUJSYjJIMnFBY0h4OFQ3?=
 =?utf-8?B?eTdNbkRWN1hrV0xBaWRpc2prR1p6SUdDdzRjMnNXRk83Q0tEV1hNMHh2ZUlI?=
 =?utf-8?B?MXdlc1J3Q3J3Sitxam4xK3FWZGJkeEpJK3BqUFBrNVhtZk1JT2c1Y0FkMXZG?=
 =?utf-8?B?S3ZEY2k5dHFkMmdlanl1bm84S2t4MTlxazFTenQ3ZmU2SysraldPMUdjVTZY?=
 =?utf-8?B?OHNoYVBnQmEyZGN4ZmNHN2N5MFVHR2R2TWsrYlZTTGZhQjlzcURsdlMrY2ZF?=
 =?utf-8?B?bzA4WkdKTEUyQzdjTFJaSVRvekEyTzduQ0szdm11ZVhrdmdRanhsRk8vVVpZ?=
 =?utf-8?B?WHBzSW93eGVic0xpaG0rSERaNWZvR2ViMmlMdHVLcjVYSWEzb2luNTIvUFM0?=
 =?utf-8?B?N0ZJMjRLV013c0NTbEhLeTNXVFdCMXVGQVUwM1QvQ2ZONzFYZk14anJVTWhP?=
 =?utf-8?B?NlhCcFEweG1HUmVwNDBXMmZVeEdPV3lCL1lyQlQ5Tzk0enYzazdxMGM4UE5l?=
 =?utf-8?B?TFd2azNwMzhYTzAyTWtURGhMeklrcUJQMnp2RmgyUzA3cUUwMjZvRmdmdVRp?=
 =?utf-8?B?VkVjNjhHQml2cGp0NE53V2xobVdYQWJWNEd2am9ZeDJvQ0p6QlJJV2xobkpJ?=
 =?utf-8?B?eGgwQ1FhcW1uOFd1TWthVk9CbVkyK1RYdmtJQnFTS1BPbnNPUEZmcTJ4Q0M5?=
 =?utf-8?B?Zk9PU1pXUWdvWWt1SHFXWEtvRk9JMXpRWm5Oc2xOVEFuZW0vcG5sMVZhUUlU?=
 =?utf-8?B?TiszN2R4V0h1VytiUityZ0M2ZmIxSjUybG5LOGpDRkRZNGNMZzFOMnZxMC9C?=
 =?utf-8?B?M0taM09JWVR4QnVuOFlqYWtjLzF6a0x6VmtYVXBGNk1ZT01CZWRzNEFoeVE3?=
 =?utf-8?B?TUNaRjdHenZreVJsUjZDbE8xd2t2WUdMNTVKYjBLUjdtdHRsUjF3ZERaNHVl?=
 =?utf-8?B?NWg0TVdGLzNwc0FaSGNPMTF3UVV4eXlTUjdLR3BHUmtHZVlnREt3VjBPeHhv?=
 =?utf-8?B?NlV3L2E2U09lODNoUzRmbk4zeXREb3pDVnFJbVpxVVNBMXkweVdRUFRIek1F?=
 =?utf-8?B?TEFjcXZqSzJibUgyS0hFTzAzOFY1bW5pN2h3aWRLN3NoV3ZpMmtPT1l2cXly?=
 =?utf-8?B?RXYraHJ3MVd2TDY0VmNrS0RJcWd4YWRaYThqSzlwb2wzbEpmRHBkeXRvcHky?=
 =?utf-8?B?bGFoOThlWWpnNzhhTjBrTDQwOEdiWHJlYXhOZkUyNWtKblQ0OU42ZlFtS2NJ?=
 =?utf-8?B?cU1yWGNXb01BSFdic25LR0szc09naUw4Y09DNGEvMDI4SnVCRmo2SDlpMGJK?=
 =?utf-8?B?cENLSFRrdG4vTVhzeUVmVDA1YkZydCtpM2FqRkIwWGU4SWVERFRiUXFab1Jl?=
 =?utf-8?B?T3VkTHp3cUhlVEpjTEUya3dURm9ha1NxUXkrSW5CSFlCUWsxU28xRVJKZmtT?=
 =?utf-8?B?K2RpSFc0Zkk5Qi9LY1ZKV1NrTlhYQTBMaC8yTnVUQTZZUzVBMVlrUkxXRDRC?=
 =?utf-8?B?SVk3OWREaFBsWjlwZWRudVBlWHFrMEJTWExPTExyUGl5Q1RPdndXYWRNc09h?=
 =?utf-8?B?TjZ3V0NJTjh4V2FFMkc1UTFDSUVIb09iS0w3eDBCcHgwQjdaVXYxVVdtalBJ?=
 =?utf-8?B?MGJLOXFDSC9FUWlyQ1U4VGVRNmlTMkZDWHdrMlEvTHA4QmZZUFM0T05JQm5i?=
 =?utf-8?B?eFBuaVdzVDVuL0tHNjNQcXQrckpjOVV3bGovcmE2T0NPTVYzMkcwMW14SmpP?=
 =?utf-8?B?YkQvTlhQNE52bE5sOUpYeGp4NXRmZHJIOExFVTFCSXIxYWs2VXp3M250MWti?=
 =?utf-8?B?ZDAzTXJ0YVByeWpsMHptRmdFTlNvalVncCtKZnQxa1o1REhlMGp3VWx3QjJR?=
 =?utf-8?B?SkZnbmt5RkdGeEh1Umw3eDdFT0lDRVBoYzd4a3ZyaGJMV3F5Qm5xMis3b0Rs?=
 =?utf-8?B?N1Exejh4dmpvNlFSWkx2clRnS3djR0g3U2JZVElkYnJUU0t2S0tXcFRXdm45?=
 =?utf-8?Q?jX3w=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR02MB9505.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fcef589f-a88e-4e3f-e965-08dc31ef6965
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2024 08:39:11.4739
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: m30cO+hXNT1xz+fcE4oniaPI9Tx7AxRQLtmWkDDs73sgELs9K6mpygrksFakhMkDn+a/K+3PO0sgM/4tn6y1iQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR02MB9239

DQo+ID4+IE1heWJlIGl0IHdvdWxkIGJlIGJldHRlciB0byB1cGRhdGUgdGhlIHN0b3BfcnggYW5k
IGFkZCBwYXJhbWV0ZXIsDQo+ID4+IHdoZXRoZXIgaXQgc2hvdWxkL3Nob3VsZG4ndCBlbmFibGUg
dGhlIGxvb3BiYWNrID8NCj4gPg0KPiA+IFNpbmNlICpzdG9wX3J4IGlzIHBhcnQgb2Ygc3RydWN0
IHVhcnRfb3BzIEkgY2FuIG5vdCBhZGQgYW4gaW5wdXQgYXJndW1lbnQgdG8gdGhlIGZ1bmN0aW9u
Lg0KPg0KPiBZb3UgY291bGQgYWRkIGEgd3JhcHBlciBmdW5jdGlvbiBhbmQgbWFrZSBzdG9wX3R4
IGNhbGwgdGhhdCBvbmUuDQoNCk9rLCB5ZXMgdGhhdCBpcyBwb3NzaWJsZS4gRG8geW91IHdhbnQg
bWUgdG8gZG8gdGhhdCBjaGFuZ2U/DQoNCkJlc3QgcmVnYXJkcywNClJpY2thcmQNCg0KX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXw0KRnJvbTogTWFyZWsgVmFzdXQgPG1h
cmV4QGRlbnguZGU+DQpTZW50OiBUdWVzZGF5LCBGZWJydWFyeSAyMCwgMjAyNCA3OjUyIEFNDQpU
bzogUmlja2FyZCBYIEFuZGVyc3NvbjsgbGludXgtc2VyaWFsQHZnZXIua2VybmVsLm9yZzsgcmlj
a2FyZDMxNC5hbmRlcnNzb25AZ21haWwuY29tOyBncmVna2hAbGludXhmb3VuZGF0aW9uLm9yZzsg
c2hhd25ndW9Aa2VybmVsLm9yZzsgcy5oYXVlckBwZW5ndXRyb25peC5kZTsga2VybmVsQHBlbmd1
dHJvbml4LmRlOyBmZXN0ZXZhbUBnbWFpbC5jb207IGxpbnV4LWlteEBueHAuY29tOyBtYXJ0aW4u
ZnV6emV5QGZsb3diaXJkLmdyb3VwOyBDaHJpc3RvcGggTmllZGVybWFpZXINCkNjOiBrZXJuZWwN
ClN1YmplY3Q6IFJlOiBbUEFUQ0hdIHR0eTogc2VyaWFsOiBpbXg6IEZpeCBicm9rZW4gUlM0ODUN
Cg0KT24gMi8yMC8yNCAwNzowNywgUmlja2FyZCBYIEFuZGVyc3NvbiB3cm90ZToNCj4gT24gRnJp
LCBGZWIgMTYsIDIwMjQgYXQgNDoxN+KAr1BNIE1hcmVrIFZhc3V0IDxtYXJleEBkZW54LmRlPiB3
cm90ZToNCj4+DQo+PiBPbiAyLzE2LzI0IDEzOjQ2LCBSaWNrYXJkIEFuZGVyc3NvbiB3cm90ZToN
Cj4+PiBGcm9tOiBSaWNrYXJkIHggQW5kZXJzc29uIDxyaWNrYXJhbkBheGlzLmNvbT4NCj4+Pg0K
Pj4+IFdoZW4gYWJvdXQgdG8gdHJhbnNtaXQgdGhlIGZ1bmN0aW9uIGlteF91YXJ0X3N0YXJ0X3R4
IGlzIGNhbGxlZCBhbmQgaW4NCj4+PiBzb21lIFJTNDg1IGNvbmZpZ3VyYXRpb25zIHRoaXMgZnVu
Y3Rpb24gd2lsbCBjYWxsIGlteF91YXJ0X3N0b3BfcnguIFRoZQ0KPj4+IHByb2JsZW0gaXMgdGhh
dCBpbXhfdWFydF9zdG9wX3J4IHdpbGwgZW5hYmxlIGxvb3BiYWNrIGFuZCB3aGVuIGxvb3BiYWNr
DQo+Pj4gaXMgZW5hYmxlZCB0cmFuc21pdHRlZCBkYXRhIHdpbGwganVzdCBiZSBsb29wZWQgdG8g
UlguDQo+Pj4NCj4+PiBUaGlzIHBhdGNoIGZpeGVzIHRoZSBhYm92ZSBwcm9ibGVtIGJ5IGV4cGxp
Y2l0bHkgZGlzYWJsaW5nIGxvb3BiYWNrIGluDQo+Pj4gdGhlIGNhc2UgZGVzY3JpYmVkIGFib3Zl
Lg0KPj4+DQo+Pj4gU2lnbmVkLW9mZi1ieTogUmlja2FyZCB4IEFuZGVyc3NvbiA8cmlja2FyYW5A
YXhpcy5jb20+DQo+Pg0KPj4gRml4ZXM6IHRhZyBpcyBtaXNzaW5nLg0KPg0KPiBPaywgSSB3aWxs
IGFkZC4NCj4+DQo+Pj4gLS0tDQo+Pj4gICAgZHJpdmVycy90dHkvc2VyaWFsL2lteC5jIHwgOSAr
KysrKysrKy0NCj4+PiAgICAxIGZpbGUgY2hhbmdlZCwgOCBpbnNlcnRpb25zKCspLCAxIGRlbGV0
aW9uKC0pDQo+Pj4NCj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy90dHkvc2VyaWFsL2lteC5jIGIv
ZHJpdmVycy90dHkvc2VyaWFsL2lteC5jDQo+Pj4gaW5kZXggNGFhNzJkNWFlYWZiLi44OTllMzMx
YmRmYzggMTAwNjQ0DQo+Pj4gLS0tIGEvZHJpdmVycy90dHkvc2VyaWFsL2lteC5jDQo+Pj4gKysr
IGIvZHJpdmVycy90dHkvc2VyaWFsL2lteC5jDQo+Pj4gQEAgLTY4Myw4ICs2ODMsMTUgQEAgc3Rh
dGljIHZvaWQgaW14X3VhcnRfc3RhcnRfdHgoc3RydWN0IHVhcnRfcG9ydCAqcG9ydCkNCj4+PiAg
ICAgICAgICAgICAgICAgICAgICAgIGlteF91YXJ0X3dyaXRlbChzcG9ydCwgdWNyMiwgVUNSMik7
DQo+Pj4NCj4+PiAgICAgICAgICAgICAgICAgICAgICAgIGlmICghKHBvcnQtPnJzNDg1LmZsYWdz
ICYgU0VSX1JTNDg1X1JYX0RVUklOR19UWCkgJiYNCj4+PiAtICAgICAgICAgICAgICAgICAgICAg
ICAgICFwb3J0LT5yczQ4NV9yeF9kdXJpbmdfdHhfZ3BpbykNCj4+PiArICAgICAgICAgICAgICAg
ICAgICAgICAgICFwb3J0LT5yczQ4NV9yeF9kdXJpbmdfdHhfZ3Bpbykgew0KPj4+ICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBpbXhfdWFydF9zdG9wX3J4KHBvcnQpOw0KPj4+ICsgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIC8qDQo+Pj4gKyAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICogVGhlIGZ1bmN0aW9uIGlteF91YXJ0X3N0b3BfcnggcmlnaHQgYWJvdmUNCj4+PiAr
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgKiB3aWxsIGVuYWJsZSBsb29wYmFjaywgYnV0
IHNpbmNlIHdlIGFyZSBqdXN0DQo+Pj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICog
YWJvdXQgdG8gdHJhbnNtaXQgdGhlbiBkaXNhYmxlIGxvb3BiYWNrLg0KPj4+ICsgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAqLw0KPj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IGlteF91YXJ0X2Rpc2FibGVfbG9vcGJhY2tfcnM0ODUoc3BvcnQpOw0KPj4+ICsgICAgICAgICAg
ICAgICAgICAgICB9DQo+Pg0KPj4gTWF5YmUgaXQgd291bGQgYmUgYmV0dGVyIHRvIHVwZGF0ZSB0
aGUgc3RvcF9yeCBhbmQgYWRkIHBhcmFtZXRlciwNCj4+IHdoZXRoZXIgaXQgc2hvdWxkL3Nob3Vs
ZG4ndCBlbmFibGUgdGhlIGxvb3BiYWNrID8NCj4NCj4gU2luY2UgKnN0b3BfcnggaXMgcGFydCBv
ZiBzdHJ1Y3QgdWFydF9vcHMgSSBjYW4gbm90IGFkZCBhbiBpbnB1dCBhcmd1bWVudCB0byB0aGUg
ZnVuY3Rpb24uDQoNCllvdSBjb3VsZCBhZGQgYSB3cmFwcGVyIGZ1bmN0aW9uIGFuZCBtYWtlIHN0
b3BfdHggY2FsbCB0aGF0IG9uZS4NCg==

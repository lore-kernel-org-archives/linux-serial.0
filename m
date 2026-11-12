Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.228.17
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794470374;
	b=v9TF8rmFcFkpYKVFG5DxU87TckKNRqoxKvk7c9Zl/SqbSOkfvV1nfD1F+ghebyo8GE4+
	 ebAACXSHFrXK2gBbdv4kn6kiT1z5cQkrgbCEg8vz9ONsE+TRlDco2Cxu6OWVItr4637Cp
	 z30lNLzWM/odFKeSQy/r5Lnbg5QtZCYevjf0KSR96v735kE47MgK+zBV11zwJOseD2953
	 gmc2y1JkmdbpWsSDUcbjzV6b1Adf/+Ln165/1CboXYe4FhRZJwENydQMhb5B60t1PHFfa
	 b/KcN/WFgN2uU0V1gDFtvMxp4jhpJO4HXLEfoOwyn9K0TvkC6JhMGbE0H2CkUgAZXRw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794470374;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:References:In-Reply-To:
	 Accept-Language:Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-ld-processed:
	 x-ms-exchange-senderadcheck:x-ms-exchange-antispam-relay:
	 x-microsoft-antispam:x-microsoft-antispam-message-info:
	 x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=//wkfIE0/P3cEjwyZifq+e/EcizhaQEq5ZvtCAFQV8Y=;
	b=jzAS7tRmEq+oGdc6y+6UbjChSBGapO4aew210xLP50REOp7YXgJQ6eKeK7y7nn4pGpg4
	 ScFAdLweeibOfCqssb8pqrnxCecyDZ6zVIGkuCG8dCgITfdgRJ1TnnwyaSjRdgriQnUSB
	 OuTdEsWMZCvUCSw+LzaXQoXE6PejvRskUgf6cwzoM1fkpX753lYGbQFTc6z5z30c54slF
	 oPV2a+7Jg/Tbrvz5KCkjppVFQ/olpPlUXBj236QArE9ZFxHmTfpFRhEi0xPrUIAIqkifo
	 qXvlW5/KOnI9a9ah3vf42nUbtDoCKoih5FLs5UBYiSTO0vcKxYAmrOTZOHQlISxFkQg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bp.renesas.com;
	spf=pass smtp.mailfrom=bp.renesas.com;
	dkim=pass header.d=bp.renesas.com header.i=@bp.renesas.com header.a=rsa-sha256 header.s=selector1 header.b=PjO4zad7;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.228.17
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010017.outbound.protection.outlook.com [52.101.228.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE6B4606A89A;
	Thu, 12 Nov 2026 07:59:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CE6B4606A89A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=bp.renesas.com header.i=@bp.renesas.com header.a=rsa-sha256 header.s=selector1 header.b=PjO4zad7
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E5z/+MnzaA9p0SnsFipqeTX4Q1IrlMc5OhtTX1zIsWKGQoEYJhpe0mBA3lQecnc6Y/AElIYGWzGNd2t4rnxVhAl0Teo1Jt8zZXe6TlIDtp4kwKOJPsUxl7W9zKwCF4RoEMlKi0xekOQORvBHffeM/FlipR8Cik3lLHkUiKq5xkcw7TkTYY9fIUQFCo+zTo74gLj4hApkywBTZVdntLi+IFQ7e3ksrZN3AONJK2fNnHkC02a9rMthaApFCxPDJF1eCh9S/Zinp75UdLD/tYFf8pORP81yBd3YvdC4BLa70JhwE5XJXOd/7HHcZFHf+9SNxv8Z25PeXpQNXluBHLUIZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=//wkfIE0/P3cEjwyZifq+e/EcizhaQEq5ZvtCAFQV8Y=;
 b=mwO3ObApAN4DJbJ61Rr26anhsnp6Rxr5bdEIpAQE7ca0K52RmRWFo0AOVL84MZdFB1pedz2Rw/Iyjql765nV6dgfFCbsiTucqcyAEJpxQrWNeEeBqZMSngBcYLYcW3amrhmPyeaCBRIpCkJB+uhDzaLqZIQ/4kQsKV23Dc6bM2dJj/+pz4qEBY91LzibY/UxXBBdGeUt1gq5aDGE+MYZ6eipPPHHpCBy6YV5DnV7j6XyhwF2+5AKJL+RYZebn6XY1NNk3qmzeyEpAhKhyCLIkmZJ6POHzVvY7ix9K6Sl8rRburJ5IOBjjxhKlhH/7SiaLuGlWKQhqvOoBEGRrfunTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=//wkfIE0/P3cEjwyZifq+e/EcizhaQEq5ZvtCAFQV8Y=;
 b=PjO4zad7sK51RTJ9r8CatesdFSNT2i9UMM9E+HIHUWo4U+EsC43K6IiUILRD2K+z0Itx/plWkKEnr+4EKwSTKANrn6LUwwbXTVFK5ttMeGhMlqMj41lMXjrnYmWwRYcgVcHEAkPBUgPHdR9x4mY9VoDzdQDFrzNEymTRA0P5uEM=
Received: from TYYPR01MB6603.jpnprd01.prod.outlook.com (2603:1096:400:e0::9)
 by TY5PR01MB18221.jpnprd01.prod.outlook.com (2603:1096:405:3e9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Thu, 12 Nov
 2026 07:59:28 +0000
Received: from TYYPR01MB6603.jpnprd01.prod.outlook.com
 ([fe80::145b:b854:162:2e7f]) by TYYPR01MB6603.jpnprd01.prod.outlook.com
 ([fe80::145b:b854:162:2e7f%5]) with mapi id 15.21.0615.008; Thu, 12 Nov 2026
 07:59:27 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: "biju.das.au" <biju.das.au@gmail.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, Kiryl
 Shutsemau <kas@kernel.org>, Rick Edgecombe <rick.p.edgecombe@intel.com>, Dave
 Hansen <dave.hansen@linux.intel.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>, Au
 Dang <au.dang.jx@renesas.com>
Subject: RE: [PATCH v3 0/4] Fix transmit handling on SCI/RSCI ports
Thread-Topic: [PATCH v3 0/4] Fix transmit handling on SCI/RSCI ports
Thread-Index: AQHdZTx0nCl6r9+vN06096idU3GgbbcqLMTg
Date: Thu, 12 Nov 2026 07:59:27 +0000
Message-ID:
 <TYYPR01MB6603E9A5CD5E21CBEA1C8FFB86702@TYYPR01MB6603.jpnprd01.prod.outlook.com>
References: <20261026-g2ul_sci-v3-0-b3097163edd5@bp.renesas.com>
In-Reply-To: <20261026-g2ul_sci-v3-0-b3097163edd5@bp.renesas.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYYPR01MB6603:EE_|TY5PR01MB18221:EE_
x-ms-office365-filtering-correlation-id: 381da268-ed5e-428e-dfae-08df4092e014
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|38070700021|10067099003|5023799004|11063799006|56012099006|261021123027099003|261021121427099003|261022105027099003|261022075727099003|261009223027099003|261102123227099003|261028144727099003|261026121527099003|261026140227099003|18002099003|22082099003|3023799007;
x-microsoft-antispam-message-info:
 rESSMOzVmQpkYUeVL7UAcOF2rG3G6AbbIfdQAd8tXBdEujGSfWpJ9tJaxdHkcbZUsvmfYoBrG/ivr/LvCsss9jGDJj3kfLkzEm8SVRLRk+pzU285tVuMk3ghuyMu8xhbyoLs3t0Hrk0tw+0ZKqw8GfKHLmulyC86f+yxVGzapmYz2fPUoLv5qRM7kAcNEqYjyWpmio77Xb8Qtki1co/WbTJCb+2EuSIGhzmJ/UslhsSFowUQt1Pq7SgzYm5e3+tFunRoIhnsnRuNOkmlyW03YcW5KLI6WgE2f+SVboEujbtTLSxuqF8hW/xVYLgyI44wGgGRBz1p8rUHme8QANaQIa5e2ZOfatWAFuNeitGfdC2MRx9tJ7qrOHHk80SPhqtFuI7FZ+LUJm9pW572VUh/C1F7wjyN1d5enHfcNrOa5qviFmLaGxb0TREaYf8Cm0SvLy6cPfjIDEfDgytdPMF8kQMrmIHFnqL1FEKGA+8gIlxuTFM2FM+NDAFYKj1S36NZXZ/+kqokTmIYYOwP55kJFcUqFHChvOw6XiRBhfEgnJDmBMdCW7AmNPvFHlT7sMwm+OpJbypUZyHpcZv3Iyeq9obZDWaXv7Zb8CFId9/7oyE3DE+ED/XIcByAGr3RgGlY4e5P2OuUKvXVC88uh25Mwdt8g1m0IL518Hy0ev88+O0=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYYPR01MB6603.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(38070700021)(10067099003)(5023799004)(11063799006)(56012099006)(261021123027099003)(261021121427099003)(261022105027099003)(261022075727099003)(261009223027099003)(261102123227099003)(261028144727099003)(261026121527099003)(261026140227099003)(18002099003)(22082099003)(3023799007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TVc3YWxWQndwSUlzOW9XVDk0VVh6TWsrTmNBajcxUkkwK3FDTk5Ga0VqZ2pu?=
 =?utf-8?B?dHo1S255VTBuVFVIZUUyZ1RhamR3bVRYVWRTQmlOanUreUF3T1ZzMEtmSFd0?=
 =?utf-8?B?S0JsSEFRUEp6MDc0WVBUTnhxekMydnJ6Q01VMVdYVGE5N3daUlNNMnFYcHFu?=
 =?utf-8?B?TnNHMFJXeFJvTE8vS2ZVczFpbTlud2svckxqaHRtcFhidHdRMTB4UUpGL0Mx?=
 =?utf-8?B?MDRnNmcvZkFERHc5TmcwRFVPbHRvUmRraWNGQ0xGaEwxR3JwWTBjSnNXeTVz?=
 =?utf-8?B?QlRidzkxQTc5K2dmZk9aVkI5OE9nUzFQY2VYcEZMMUtTa05QYmpoUWZuc2pC?=
 =?utf-8?B?Ym5kZGhUcTEzZ2IxZXhiWTFpbDB1RlZraTg5Y3hMWWdpSU9UVDFrZGVhTDVR?=
 =?utf-8?B?UlRmZ2ZnR3EvNWFLVmttS1dTQnFSckN6NU8yeW5YaFRDVHFHSzhoakNaaDJl?=
 =?utf-8?B?OC8wdWp0SVhpYU1rL3NOcFNmNDB6K0w3RlptUnJhMTRCbnBlTndGWEZRUTRF?=
 =?utf-8?B?QStPN2k5c2YzTDhYaGZFU1FFM2xmZnNPMCttRzczWW52aHc5aGxnMnVMR1dD?=
 =?utf-8?B?ZU1tODNjeURPYXprNnFjWlZuNnVFRUUvTzNkNUpmL2dvcnJUVjZmWVI0UFNC?=
 =?utf-8?B?N3llTk91ejhueHAxS2NhUCtoeVdWRGJOaC9MMW5tZDRBK0xLUEo1UkJNSFhz?=
 =?utf-8?B?c1hoa2Jqc3Y3RktEa09IU3lJK1hsWWpLemwrZkkrVU9vTTJpcGswMmtUa1Rn?=
 =?utf-8?B?TGlEL2dvR0FWOVNEL25SbndqZ3pFWDd4U2EvZHcrRkZ0SVloc1lMcldpTVBi?=
 =?utf-8?B?czM4K1dnZ2hQYlM4SFQwOUxhS212aE5yVzByc1h5cXNZUld4WW1HaDVPUDUz?=
 =?utf-8?B?VjdDaGNqcDJ5Z21TRnhLdnV3d2R5Z0p2ME5MQ1FsbW42T1dmdnJOOE1vR1h6?=
 =?utf-8?B?ZnRZQ2ViN1R4NEw4Z1pLRVRhSTVjRHNQK2hVT2llblNmczcwSzk3NTFDNGhw?=
 =?utf-8?B?L2haZW5SdGpJczNTOXovNHR6NXRJT1V6a2ptZGhtcnoxdU1ocDlWODI3V015?=
 =?utf-8?B?VmRyeXNhei9ETi9tRnAzdm43TnVSOVhHQUpFRmhHU3Mvcll3d3VhNEZOK2hI?=
 =?utf-8?B?T21KazRESDA1Rkc4Ri8wc1QzU0VCZGJtalhBakVKNnBIS3VLOUxHdXN0OTdH?=
 =?utf-8?B?Tm5RVWdOOUhOWWJYem85ZzVkTDVZcmdOZk0zOUhtRnJCMEtnRUlxa3c4cU5X?=
 =?utf-8?B?L3J6UDBZV3VEemphd1czc2RTZXFQZzFiNHU4cCtCenE4YTFHdzFVMkdOTkFu?=
 =?utf-8?B?MzlUYVYrN1ZFM0duK1FHc09NbXlSeFBybHZXN3RkRTFoQ3VKdU02MzQzZ3RS?=
 =?utf-8?B?aGkxR2dWVHdVVGQ5c1hzdzU3dXFBM0ZVeVF6ZWEveUlsZXFKdVFzY2ltRndj?=
 =?utf-8?B?Sk9CazV4Z3RUZHFmL0o5aGJsdk5hcDVvNHZ6WXV5NnBGdFc2WEpabld6dEY0?=
 =?utf-8?B?OWlVWFpQQm54ZXVGMDhZQmVnQkZ6WkZrNnQ5OVZYem1iRHBGcGFSZ2Nad2lC?=
 =?utf-8?B?T0dwdEdNNWNzRWdRTTl1ZWVsWjUrci9LaS9wUG5jdlJsMXc1ZG9aZUsvcytq?=
 =?utf-8?B?NVNqSU1BcW1rREp0NzJvK0xIdy8vK0lCd3dJdkc5YjVWT0NBL09uN2R2VnMr?=
 =?utf-8?B?d1U5UUFET3drVTBMUTlpeU5iRXdDRHBmdGpxMkhaeUQ0eFBQaW94Nm9CQWdB?=
 =?utf-8?B?ZnpHQXFDdndzTmxHa1RSNHVPVVJkMENmeDR1RXZWUWhBZXFVOWJNbmZoOGNa?=
 =?utf-8?B?WkI5dDZoQlh3cS9pQ3dqY1lCQ2U1MloxNDl6Q2FxSnpIcmVhZ3ZEU0hrNGo5?=
 =?utf-8?B?Z05xeVg0NFZwWGdmRVRMemxLeWxUSlpwTVc1elVFWUhDdklEQ25YbTZwNEdB?=
 =?utf-8?B?NUNKTFJZMHd0SjdUTG1vY2RWVi8xMk1KK3BGTUlpZUdPcmh2MUMvcW5CcUpI?=
 =?utf-8?B?bEUwbnV4b1ZONmxFUGpIOTlwNXBHcHRtYWUyREk5eXoxTk9PWjlTWmRrbWtB?=
 =?utf-8?B?TXU0LzVMbEY1U0pvK2htWitvOUI0QkdockRXTzVta3lCVDg5ZlBTRWdvVm4z?=
 =?utf-8?B?Zm5xQjRCNkFsUWJtUk5IZHhYYmVZZkxEbW9hTC9NWTA1emZtZGZ5SHpMcmdO?=
 =?utf-8?B?WWtZcmtCU3JyclJsUDc1QU1mdE1JR0d1ZC9ScGdhMy8xNXMxaExRWHNRVjM0?=
 =?utf-8?B?aFhCRnFqOGdtK0wzNTQ1Mi9XMXZqV0diMnMranlUSCs5QTgrSVdzcndLb1dH?=
 =?utf-8?B?MVBsdWo3K1RyNVJHdUxWS3prV1VVTUZTNTZBTmhWdzVVa1FXSVF1QT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYYPR01MB6603.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 381da268-ed5e-428e-dfae-08df4092e014
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2026 07:59:27.7768
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /kmYhC99PDFVc4nEdN48sSSuZZ5D8euftSmNmtzcUEW/RCwJNj81hEVQiDIQ+rbo9gV9X9v90jUQdgiRoYsoGF2pegJpsKGAexqZbUZ8uIA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY5PR01MB18221

SGkgQWxsLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEJpanUgRGFz
IDxiaWp1LmRhcy5hdUBnbWFpbC5jb20+DQo+IFNlbnQ6IDI2IE9jdG9iZXIgMjAyNiAxMToyNA0K
PiBTdWJqZWN0OiBbUEFUQ0ggdjMgMC80XSBGaXggdHJhbnNtaXQgaGFuZGxpbmcgb24gU0NJL1JT
Q0kgcG9ydHMNCj4gDQo+IEhpIEFsbCwNCj4gDQo+IFRoaXMgc2VyaWVzIGZpeGVzIHNldmVyYWwg
dHJhbnNtaXQgcHJvYmxlbXMgb24gdGhlIFNDSSAoUE9SVF9TQ0kpIGFuZCBSU0NJIHBvcnRzIG9m
IHRoZSBzaC1zY2kgZHJpdmVyLA0KPiBzZWVuIG9uIFJlbmVzYXMgUlogU29DczoNCj4gDQo+ICAt
IFBhdGNoIDEgcmVtb3ZlcyB0aGUgY29kZSB0aGF0IGRpc2FibGVzIFRFIGF0IHRoZSBlbmQgb2Yg
YQ0KPiAgICB0cmFuc21pc3Npb24gb24gU0NJLCB3aGljaCB0aGUgaGFyZHdhcmUgbWFudWFsIGRv
ZXMgbm90IGRlc2NyaWJlLg0KPiAgLSBQYXRjaCAyIHN0b3BzIHRoZSBURUkgaGFuZGxlciBmcm9t
IHR1cm5pbmcgdGhlIHRyYW5zbWl0dGVyIG9mZg0KPiAgICB3aGlsZSB0aGUgeG1pdCBrZmlmbyBz
dGlsbCBob2xkcyBkYXRhLCB3aGljaCBjb3VsZCBzdGFsbCBvciBsb3NlDQo+ICAgIG91dHB1dC4g
SXQgYWxzbyBjb3ZlcnMgdGhlIFRFIGhhbmRsaW5nIHRoYXQgcGF0Y2ggMSBubyBsb25nZXIgZG9l
cw0KPiAgICBpbiBzY2lfdHJhbnNtaXRfY2hhcnMoKS4NCj4gIC0gUGF0Y2ggMyBza2lwcyB0aGUg
c29mdHdhcmUgY2xlYXIgb2YgdGhlIFREeEUgZmxhZyBvbiBTQ0ksIHNpbmNlDQo+ICAgIGhhcmR3
YXJlIGNsZWFycyBpdCBvbiBhIFREUiB3cml0ZSBhbmQgdGhlIGV4dHJhIGNsZWFyIGNhdXNlZCBh
DQo+ICAgIHNwdXJpb3VzIFRYSSBhbmQgYSBkdXBsaWNhdGVkIGxhc3QgY2hhcmFjdGVyLg0KPiAg
LSBQYXRjaCA0IGZvcmNlcyBhIFRFIHRvZ2dsZSB3aGVuIHJlc3RvcmluZyBTQ1NDUiBpbiB0aGUg
Y29uc29sZQ0KPiAgICB3cml0ZSBwYXRoIG9uIFNDSSwgc28gdGhlIFRYSSB0aGF0IHJlc3RhcnRz
IGFuIGludGVycnVwdGVkIGRyYWluIGlzDQo+ICAgIGdlbmVyYXRlZC4gV2l0aG91dCBpdCB0aGUg
UlovRzJVTCBjb25zb2xlIGNhbiBoYW5nIGR1cmluZyBib290Lg0KPiANCj4gU2lnbmVkLW9mZi1i
eTogQmlqdSBEYXMgPGJpanUuZGFzLmp6QGJwLnJlbmVzYXMuY29tPg0KPiAtLS0NCj4gQ2hhbmdl
cyBpbiB2MzoNCj4gICogVXBkYXRlZCBjb21taXQgZGVzY3JpcHRpb24gZm9yIHBhdGNoIzINCj4g
ICogV2hlbiB0aGUgcG9ydCBpcyBzdG9wcGVkIHdpdGggZGF0YSBzdGlsbCBxdWV1ZWQsIHRoZSB0
cmFuc21pdF9jaGFycygpDQo+ICAgIHBhdGhzIChzY2lfdHJhbnNtaXRfY2hhcnMoKSBhbmQgcnNj
aV90cmFuc21pdF9jaGFycygpKSBub3cgYWxzbyBzd2FwDQo+ICAgIFRJRSBmb3IgVEVJRSwgYXMg
dGhleSBhbHJlYWR5IGRpZCBmb3IgYW4gZW1wdHkga2ZpZm8uIFdpdGhvdXQgdGhpcywgVElFDQo+
ICAgIHdvdWxkIGtlZXAgZmlyaW5nIHdpdGggbm90aGluZyB0aGUgZHJpdmVyIGlzIGFsbG93ZWQg
dG8gc2VuZCwgYW5kIFRFSQ0KPiAgICB3b3VsZCBuZXZlciBiZSByYWlzZWQgdG8gY29tcGxldGUg
dGhlIHRyYW5zbWlzc2lvbi4NCj4gICogUmVwbGFjZWQgc2NpX3R4X2ludGVycnVwdCgpIHdpdGgg
cG9ydCdzIHRyYW5zbWl0X2NoYXJzKCkgdG8gYXZvaWQNCj4gICAgbG9jayBkcm9wIHJhY2UgaW4g
c2NpX3R4X2VuZF9pbnRlcnJ1cHQoKSBiZWZvcmUgVFggaGFuZG9mZi4NCj4gICogQWRkZWQgbWlz
c2luZyBoYXNfdGR4ZV9hdXRvX2NsZWFyIGluaXQgaW4gc2NpeF9lYXJseV9jb25zb2xlX3NldHVw
KCkuDQo+ICAqIFJlcGxhY2VkIHRvX3NjaV9wb3J0KHBvcnQpLT50eXBlIHdpdGggc2NpX3BvcnQt
PnR5cGUgaW4NCj4gICAgc2VyaWFsX2NvbnNvbGVfd3JpdGUoKS4NCj4gLSBMaW5rIHRvIHYyOiBo
dHRwczovL2xvcmUua2VybmVsLm9yZy9yLzIwMjYxMDIxLWcydWxfc2NpLXYyLTAtYjRlMDM4MjIw
MDE4QGJwLnJlbmVzYXMuY29tDQo+IENoYW5nZXMgaW4gdjI6DQo+ICAqIFVwZGF0ZWQgY29tbWl0
IGhlYWRlciBhbmQgZGVzY3JpcHRpb24gZm9yIHBhdGNoIzIgYW5kICMzLg0KPiAgKiBUYWtlIHRo
ZSBwb3J0IGxvY2sgYmVmb3JlIHJlYWRpbmcgdGhlIGNvbnRyb2wgcmVnaXN0ZXIsIHNvIHRoZQ0K
PiAgICByZWFkLW1vZGlmeS13cml0ZSBpbiBzY2lfdHhfZW5kX2ludGVycnVwdCgpIGlzIHByb3Rl
Y3RlZC4NCj4gICogRXh0ZW5kZWQgdGhlIHBlbmRpbmctZGF0YSBjaGVjayBpbiBzY2lfdHhfZW5k
X2ludGVycnVwdCgpIHRvIGNvdmVyDQo+ICAgIHhfY2hhciBhbmQgYSBzdG9wcGVkIHBvcnQsIG5v
dCBvbmx5IGEgbm9uLWVtcHR5IHhtaXQga2ZpZm8uDQo+ICAqIFJlcGxhY2VkIHRoZSBQT1JUX1ND
SSBjaGVjayB3aXRoIGEgaGFzX3RkeGVfYXV0b19jbGVhciBmbGFnIGluDQo+ICAgIHN0cnVjdCBz
Y2lfcG9ydCwgc2V0IGZyb20gdGhlIG5ldyB0ZHhlX2F1dG9fY2xlYXIgZmllbGQgaW4NCj4gICAg
c3RydWN0IHNjaV9vZl9kYXRhLg0KPiAtIExpbmsgdG8gdjE6IGh0dHBzOi8vbG9yZS5rZXJuZWwu
b3JnL3IvMjAyNjEwMTkxNzAxMzkuNDczODA4LTEtYmlqdS5kYXMuanpAYnAucmVuZXNhcy5jb20N
Cj4gDQo+IC0tLQ0KPiBBdSBEYW5nICgyKToNCj4gICAgICAgc2VyaWFsOiBzaC1zY2k6IFNraXAg
VER4RSBjbGVhciB3aGVuIGhhcmR3YXJlIGNsZWFycyBpdCBhdXRvbWF0aWNhbGx5DQo+ICAgICAg
IHNlcmlhbDogc2gtc2NpOiBUb2dnbGUgVEUgd2hlbiByZXN0b3JpbmcgU0NTQ1IgaW4gY29uc29s
ZSB3cml0ZSBvbiBTQ0kNCj4gDQo+IEJpanUgRGFzICgyKToNCj4gICAgICAgc2VyaWFsOiBzaC1z
Y2k6IERyb3AgVEUgZGlzYWJsZSBhdCBlbmQgb2YgdHJhbnNtaXNzaW9uIG9uIFNDSQ0KPiAgICAg
ICBzZXJpYWw6IHNoLXNjaTogS2VlcCBUWCBlbmFibGVkIG9uIFRFSSB3aGlsZSBkYXRhIGlzIHBl
bmRpbmcNCj4gDQo+ICBkcml2ZXJzL3R0eS9zZXJpYWwvcnNjaS5jICAgICAgICAgIHwgIDQgKyst
DQo+ICBkcml2ZXJzL3R0eS9zZXJpYWwvc2gtc2NpLWNvbW1vbi5oIHwgIDQgKysrDQo+ICBkcml2
ZXJzL3R0eS9zZXJpYWwvc2gtc2NpLmMgICAgICAgIHwgNzEgKysrKysrKysrKysrKysrKysrKysr
KysrKystLS0tLS0tLS0tLS0NCj4gIDMgZmlsZXMgY2hhbmdlZCwgNTYgaW5zZXJ0aW9ucygrKSwg
MjMgZGVsZXRpb25zKC0pDQo+IC0tLQ0KPiBiYXNlLWNvbW1pdDogOGY3ZGYwMDVhNzU2NGJkN2Zm
YTc1ZGE5YzMwODVkNWI5OTZmMWUxNg0KPiBjaGFuZ2UtaWQ6IDIwMjYxMDIwLWcydWxfc2NpLWI2
MTA2MDZlYTViNQ0KPiANCj4gQmVzdCByZWdhcmRzLA0KPiAtLQ0KPiBCaWp1IERhcyA8YmlqdS5k
YXMuanpAYnAucmVuZXNhcy5jb20+DQoNCkdlbnRsZSBwaW5nLg0KDQpDaGVlcnMsDQpCaWp1DQoN
Cg==

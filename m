Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.228.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793085664;
	b=EDIpnIDcoQ04R9MXzXwzL94NGy9ZAFo+DjIwt8T/Ci9rkbrqhhvyC2EiWiWyh2IzTx1n
	 PhJk3U5LrgxcxInh7yG6SLtPlagiaR2vm1TeylspaEcml7sJg276pWpP4rvvVGrvtHKkm
	 PYeF8HQvnlnUhK517HfL3jgDCTp5gwTHOLJ9rDeFUO9xuzjTttiNJe0pE7V40+CFo+9Rm
	 1wXZ2aywz5CJ6qj25QegK387tUFMjR6mGDyhHgC7KWAtTXYcet/tigJtO8nS/2P1co1EZ
	 1KEhedaplgjBwJfGOeyX1mY6Hxi+K+v/WQ25HJxlB5efmRDrq8ytQWiLtOeu++MDkbA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793085664;
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
	bh=pQtvOHWT2gjKmQImOlsojc2woFcl0vIHbgtoe70uGdg=;
	b=UvGi4kDjt9TFTj9+5YwGWIWj4sQvEWn1PTBCPqVNWO9PAOMn6B8vMwBiw8r7o8MUI2QB
	 Gj0Bite5lrxnAA5lCFgoRDjRIWPLxavsaG1ej8Xb4TINI7S9fTCduixf9Ro3zTPCUwhe/
	 xw7ANkAvuOZrYhExy7pAX+NGKfadUa6d4Os03gVspWzHl/5ckyvueA2Mp9q48QrGgEkxv
	 JVnnfswQ4wEvAEuqbfAzsvokbQVq0gqXiuM9ZUWkN76Nl+aILJQZgTy2myy8mDTMihcPc
	 YEcir5F1mYvcJMO1zOV4KMcAwn9d8KzFCt0oH3isQMp8GPVLrNy6J2K9i3G2ODcN5yQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bp.renesas.com;
	spf=pass smtp.mailfrom=bp.renesas.com;
	dkim=pass header.d=bp.renesas.com header.i=@bp.renesas.com header.a=rsa-sha256 header.s=selector1 header.b=CYKzhBPj;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.228.50
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010050.outbound.protection.outlook.com [52.101.228.50])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F6BE606A323;
	Tue, 27 Oct 2026 07:21:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0F6BE606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=bp.renesas.com header.i=@bp.renesas.com header.a=rsa-sha256 header.s=selector1 header.b=CYKzhBPj
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XStFUgYscihqm+Apf9tFSeOfb2JdWMv9g14AyV7sHgsFyBe5B+tZ+DSL8pse+Bl2xvh+WN1K3nfXmoW+oexp/shMPp+xAmEB0yG2BV5WROev4DkdMJhFpxORpgIqls7tgnvi4KN8sGenlHAVYvFHsbZeNEttSiE4QbgjoRNusabhX2IRVDfA8PID6BHCgSgtVK/uQHjNAHspV7gq/ZwlpwpeYpOXS6rRAYEI1w/oQ1cTiTb9g+Rj9YF5ENXtlyB/he+GeD2gpbiAGAokN8X2PHxK9qJYSScCc3qrU5MflXxthm4bzd1vfQBVOh70JG4/yMEJA7ds2A9StH27q2XmhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pQtvOHWT2gjKmQImOlsojc2woFcl0vIHbgtoe70uGdg=;
 b=FnE8uZEuLmS6Q2Nt6ZzMaUranWSWVzcGrTMUz4hB3DyuSEuOt02l/LMxF4Mkvk9d7AyXkk4u6TeTT80qYE9cCvEMPeF4lyOfknQIE710RtSqSS5FeWATQ/0NSknNCVrSxwCdRyNo7m1jrI+6CBpReFwUrZAKfk90WYFCI6KnkDy0Bc2X4i5kQV7fC31jmeKn0hIISBfmv6dTg6blm8xt/k6MxUJM6/cUqSxZM274gwEltW6cZRzpAAc9cKD/Pe+xzRgJmSK0L/zAA4GMHy/+KWiLWHBxiQ+EoyDOzi8hqAIeTKsuOYrki+SWMNoQ4nDS5N1LNGkLdyrs3nfOwwmbgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pQtvOHWT2gjKmQImOlsojc2woFcl0vIHbgtoe70uGdg=;
 b=CYKzhBPjvxYZdj6dckn19dfziOqKLCWL/6XshPXTEhbVCtHo+EpBmDcKdtoNF6FnkOiql2tMNDKNY/7hCmhJjb2esKnyABEzk/7fDvIvWt/NjldCHH+8PrbQ3P7FdcUGSobHtqycCU3g4PRNye9GZIaF4HLZL8BXDaHgiTQ/mKk=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by OS7PR01MB13571.jpnprd01.prod.outlook.com (2603:1096:604:35b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 07:19:19 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de%6]) with mapi id 15.21.0546.021; Tue, 27 Oct 2026
 07:19:18 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Borislav Petkov <bp@alien8.de>, "biju.das.au" <biju.das.au@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby
	<jirislaby@kernel.org>, Kiryl Shutsemau <kas@kernel.org>, Rick Edgecombe
	<rick.p.edgecombe@intel.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
	"x86@kernel.org" <x86@kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, Au
 Dang <au.dang.jx@renesas.com>
Subject: RE: [PATCH v3 0/4] Fix transmit handling on SCI/RSCI ports
Thread-Topic: [PATCH v3 0/4] Fix transmit handling on SCI/RSCI ports
Thread-Index: AQHdZTx0nCl6r9+vN06096idU3GgbbcQ5bkAgAAVSvA=
Date: Tue, 27 Oct 2026 07:19:18 +0000
Message-ID:
 <TY3PR01MB113468FBD8E5EFA65C4B4E5EB86602@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20261026-g2ul_sci-v3-0-b3097163edd5@bp.renesas.com>
 <20261027055750.GBauA9XlPykc1c1Xhv@fat_crate.local>
In-Reply-To: <20261027055750.GBauA9XlPykc1c1Xhv@fat_crate.local>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|OS7PR01MB13571:EE_
x-ms-office365-filtering-correlation-id: a89d22eb-0abf-417a-08f4-08df33fa9d59
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|23010399003|1800799024|261026121527099003|38070700021|11063799006|4143699003|56012099006|261021123027099003|261021121427099003|261022105027099003|261009223027099003|10067099003|22082099003|18002099003|261026140227099003;
x-microsoft-antispam-message-info:
 ATAlZQ0jnz+Ayc8oT/YURV/1xGRPBqlisBH/LDAKwBO0cpIzOGG0SjeD3i/EhjGATZNCRsv2XVDiuutZpiBDXdOeHxg2jip1WYQseG8P+7T2xS2eFBjjA0Vj6WnGioIcZsDmWCrnkV1MeyXO/xJeTiuwdSMmniUqrLX6pHzJgWkpIX4hNu9Sgv5yaVNCbF4B9WPeUaHPLnoJzuQZ/BMWmar9DYYPMUIHNmc1NL7RKBfKoTO0t6Ma1pQ44Ep0pWQHougwavmhpqNY+xUbXvEgFAheyxxCWUruDzKuDIxTa/BvmlkaCKgnqB762inNgY6151yooTe/6KNQU5/B/edI0pyhPGsy2YtfxfH3FNmcv3n/XbJkgO5h82XHcm1FSZpjyuzlebgK1/my0nKvlNartvSvQS+ZuMQ6JsrRsGlvykc10Bk3zSwLOrDmxmxfX2LR5AlNk6Zxfw2rLAaUFxBBSW5VODyZNKT6CBcXZz+G7BPueu5Do8zEJx2LmCbzhcd7mOmquTtSEVrd7JHckGKhXOt5agMURD6XObgy9KJLiudkZfKPEmM4JRwO+EcHivk1FzQE9mGo0Isp/JPcLyne7UTLBmKGgc2KXqezsk8MxMBN2KZI9ufOu5rmCTEXcZqJ1JSbW/QBTIQMdz2yVjoyJM3r338maLErRABsrmhsg9Zai1YbqItxsbcN2rIWM3ic98VFEEz8oQwBlcXpftyxzGUMs00NutSRhdz0Lwhk/Q8=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(23010399003)(1800799024)(261026121527099003)(38070700021)(11063799006)(4143699003)(56012099006)(261021123027099003)(261021121427099003)(261022105027099003)(261009223027099003)(10067099003)(22082099003)(18002099003)(261026140227099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SGZ1Ym1VdXZhR05iQnNtUGpRbUx0TXZTM0JwZm4yNitENnIyblVZZkhGc2Jr?=
 =?utf-8?B?aUN1anJjdDJQSkhQVGZVRmNUTTNKRFM2RW01VXRxL3F4NXQ4R3B3SzNpZEUr?=
 =?utf-8?B?SmtReFdSTU5wSGlQUm5reEtZVXZKRE9OWmNoOUhKU0cvK2dmNStXTlAyTm5S?=
 =?utf-8?B?Y3I3dHRmRG45MXJnZlV1Zmp2c1JWZ1d1dVNoelV0d05WaFJ6Z1R1VG5GeDMr?=
 =?utf-8?B?UlI0R2ptMGZvSWJsVkNmWS94TFhXMnBZVjZlVE9YS1VHTFg1Umdhemt4dktS?=
 =?utf-8?B?WVphemViRDU0d1pvTUt1UkNaVnJrbGpQZkRHRlowbDN5cWcrU0tKRFJTS3N0?=
 =?utf-8?B?emtJR3JkS1g3dWhlSHVDZEhLUjB3dVY3TlI0WGRTYkp3TFRlOEFQTXV6WEFl?=
 =?utf-8?B?NXMrYjFjMGVKUncxcTl6Y0dLTDdjdHA2WG9UN1FMUjJycXUxb3BqYU43VUhC?=
 =?utf-8?B?c205TXhYUE1MemtTWFhOYTJjT1N6T2NTWU80QU1ockVDQll4cUVZZElRVTV5?=
 =?utf-8?B?eUFqSE9IVFJ5SGxTWVpqQWF4dmFlcEdPTWQ3eXpmRjRtL1pJZkRKYUEzQ1ZD?=
 =?utf-8?B?NFRtVEVDWGtNUVVMQ3N4bGVUdEhack5pbWVFUDQ3MzlIL2doR2U0dEJXV1B1?=
 =?utf-8?B?WUQ1NkxqYWtsVXNYNmpwVkZpZlhGaUVNd01zUHhFbXllVVZkZGxoVDBrNzNy?=
 =?utf-8?B?VXhGdGNQbzBEbG5FdjFoZFl2b1JmbUVFSzRCOUZlVWN3ek1BUVZzSHV3T21h?=
 =?utf-8?B?djJabUhvT0MwUHRYR1Y1SkRCMjdLK3V3V3dtR09WZW95QmxIKzBDa05XMlRH?=
 =?utf-8?B?TGtEK2hrZTNQZm9TQmVyeERBVVdMdE1xWDNXZ0c0ckJIRExacjBRQ1hXMHJX?=
 =?utf-8?B?UE1RL0hBcU16dGFWdjk1RUpzYjk4YnN0dTlBK3dGaDlxcnQ0a25XRUFZTXF3?=
 =?utf-8?B?bk5xUU5jMUdFQnhZVVN6ZjE1NFducU1yV3YrWTg4YiswcjM1SDlCN1o0eG0v?=
 =?utf-8?B?YjNoQnAwNktiQ2VyVWg5VUR4Tlo3bUJsMzljOXA4bTg0SkxHUkVPRTdMbDhG?=
 =?utf-8?B?UHVSdDVaQWFNN1dFdGVlR21EZ3VwQkNITXdadVdyZEV4U3lmQmJ4WTVaWWhT?=
 =?utf-8?B?Q3JvTTRYZ3RJODQ0dTBkNjhhTTV4U3VOdHhOSnZQQWFJRWw3UTlwaHRvUGY1?=
 =?utf-8?B?QmM2R09Rb3BTUnd1bHFzVnI2ckhiSjBvQWtQa1ZXc3VEeHM4YkxHZjVFVStr?=
 =?utf-8?B?Tzh6dEJQRFZ0dnRrek1KNWppUzdhYUsrcHp1ck5MbE5FYUkwUEhXTXg2QnA0?=
 =?utf-8?B?U0dWcGtoVE5ncURDTmRURko3YnZHYVF1QllieTB0WUlORkxtQ3VoRlVKUy9E?=
 =?utf-8?B?Z2lqdDlGZ0V0TCt6VDRCWXRJclJ1WGE1Ykc5V2dxTGtJWlRtQlpRdlNOdkV6?=
 =?utf-8?B?VnpJdTRMeFNYYWNoZnNLa2t0WXpuNTYyc0FSVkMrUjAwT0VNUm1rOEFvZ3BD?=
 =?utf-8?B?S2RLRjhHVTNxVXV3aTlwVGloSzg1eFRFRmtEM1h4Z1VLWnp1NGd1dXNpdysz?=
 =?utf-8?B?dXNkQmtTV2F1MU0yVE5ua2ZWMmtvQTNzZE96endXUmlaZVNvZGZ4TDRxdTFS?=
 =?utf-8?B?RGJRVUdILzJmSG1tUmx4SEN0eFlVYlJCbHl6QnI3cm91WWFnN1lySWQycUt3?=
 =?utf-8?B?emFjaGgvSHVMMW9TWXFBZGtSWFZJaWdRTjZxdFJxaTJzUU85NmJSWjJRZ3VK?=
 =?utf-8?B?UFpRSVVIU0hzSm5tYTcvc0VzN1VJWlBjSmxYZjh6Kzk1Tmk1dDg2ZGN5M3JM?=
 =?utf-8?B?SE03YmsvcEdEQmR0azhnN0I2QnRmSmE5ZGNWT3FHdVE3bkJJV2tOSzJDc0VH?=
 =?utf-8?B?RmdYcWg2MXd0S0pMS280YjlBT2V6K2QrQ3RtS0NObzdRdE9RMkIxR2VsM3pR?=
 =?utf-8?B?cldYUk44QWdIbGdtOFNvQ3NNdktXME95YVNWOEF1SEMzQno0a29jYStHWVRl?=
 =?utf-8?B?eWtLbzR5eGJQeXY3TU5XazIxMlgvazRkMjNxczByNFc2Vjd6TUR6VGlTdmdB?=
 =?utf-8?B?RjNTNEl5dDhFcHVxYW41WDhJekRGUlMxVEx2MTQyVW50MmcrNUlMZitoS2VH?=
 =?utf-8?B?V1h3bmF5U1ViUCt1SCtKYnZaSVoxUExXamFLdWtSbDRwcFFvTjQ1UDYyMTRk?=
 =?utf-8?B?d2huSlBWZkNVTDh6TUZIVFFUbXFKRkZ3d2NRekN3Rk5BTEY1bmxNcFh3MUdq?=
 =?utf-8?B?OE1pL3BIcjNpOGVvdHFXeWlnZWhwaEYySnNldFdyelhja0NNRlBJRWNhWXlm?=
 =?utf-8?B?bHhaU0xiNVpwWk9BdHRMQmFOU0p1bUQyVVBnYXZ5ekh3cHkxbUhiUT09?=
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
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11346.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a89d22eb-0abf-417a-08f4-08df33fa9d59
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2026 07:19:18.4559
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YELHYEN0FoY1CpYQuuSn8O/K5dqyrBI0aL1h0iQRFC5Y5hehBhDbdt99TmK1d5iF16STpvWErfg2rRljL0zPtAKRl1mifCMqnKBqQTdY+qU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7PR01MB13571

SGkgQm9yaXNsYXYgUGV0a292LA0KDQpUaGFua3MgZm9yIHRoZSBmZWVkYmFjay4NCg0KPiAtLS0t
LU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBCb3Jpc2xhdiBQZXRrb3YgPGJwQGFsaWVu
OC5kZT4NCj4gU2VudDogMjcgT2N0b2JlciAyMDI2IDA1OjU4DQo+IFN1YmplY3Q6IFJlOiBbUEFU
Q0ggdjMgMC80XSBGaXggdHJhbnNtaXQgaGFuZGxpbmcgb24gU0NJL1JTQ0kgcG9ydHMNCj4gDQo+
IE9uIE1vbiwgT2N0IDI2LCAyMDI2IGF0IDExOjIzOjMyQU0gKzAwMDAsIEJpanUgRGFzIHdyb3Rl
Og0KPiA+ICBkcml2ZXJzL3R0eS9zZXJpYWwvcnNjaS5jICAgICAgICAgIHwgIDQgKystDQo+ID4g
IGRyaXZlcnMvdHR5L3NlcmlhbC9zaC1zY2ktY29tbW9uLmggfCAgNCArKysNCj4gPiAgZHJpdmVy
cy90dHkvc2VyaWFsL3NoLXNjaS5jICAgICAgICB8IDcxICsrKysrKysrKysrKysrKysrKysrKysr
KysrLS0tLS0tLS0tLS0tDQo+ID4gIDMgZmlsZXMgY2hhbmdlZCwgNTYgaW5zZXJ0aW9ucygrKSwg
MjMgZGVsZXRpb25zKC0pDQo+IA0KPiAkIC4vc2NyaXB0cy9nZXRfbWFpbnRhaW5lci5wbCAtLW5v
LXJvbGVzdGF0cyAtZiBkcml2ZXJzL3R0eS9zZXJpYWwvcnNjaS5jICBkcml2ZXJzL3R0eS9zZXJp
YWwvc2gtc2NpLQ0KPiBjb21tb24uaCAgZHJpdmVycy90dHkvc2VyaWFsL3NoLXNjaS5jIEdyZWcg
S3JvYWgtSGFydG1hbiA8Z3JlZ2toQGxpbnV4Zm91bmRhdGlvbi5vcmc+IEppcmkgU2xhYnkNCj4g
PGppcmlzbGFieUBrZXJuZWwub3JnPiBCaWp1IERhcyA8YmlqdS5kYXMuanpAYnAucmVuZXNhcy5j
b20+IEdlZXJ0IFV5dHRlcmhvZXZlbiA8Z2VlcnQrcmVuZXNhc0BnbGlkZXIuYmU+DQo+IEh1Z28g
VmlsbGVuZXV2ZSA8aHZpbGxlbmV1dmVAZGltb25vZmYuY29tPiBMYWQgUHJhYmhha2FyIDxwcmFi
aGFrYXIubWFoYWRldi1sYWQucmpAYnAucmVuZXNhcy5jb20+DQo+IEZyYW5rIExpIDxGcmFuay5M
aUBueHAuY29tPg0KPiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IGxpbnV4LXNlcmlh
bEB2Z2VyLmtlcm5lbC5vcmcNCj4gDQo+IFNvIHdoeSBpcw0KPiANCj4geDg2QGtlcm5lbC5vcmcs
IGxpbnV4LWNvY29AbGlzdHMubGludXguZGV2DQo+IA0KPiBpbiB5b3VyIENjOiBsaXN0Pw0KPiAN
Cj4gV2hhdCBjYW4gdGhvc2UgcGVvcGxlIGRvIGFib3V0IFJlbmVzYXMtc29tZXRoaW5nLXNlcmlh
bCBkcml2ZXI/DQoNCkkgaGF2ZSBiZWVuIHRvbGQgYnkgc29tZSBtYWludGFpbmVycyB0byB1c2Ug
YjQgZm9yIGVhc3kgcmV2aWV3DQpyYXRoZXIgdGhhbiB1c2luZyAnZ2l0IHNlbmQtbWFpbCcuDQoN
CklmIEkgZG8gJ2I0IHByZXAgLS1hdXRvLXRvLWNjJyBhcyBwZXIgdGhlIGI0IGRvY3VtZW50YXRp
b24sDQp4ODZAa2VybmVsLm9yZyBpcyBhdXRvbWF0aWNhbGx5IGxpc3RlZC4NCg0KQ2FuIHlvdSBw
bGVhc2UgZ3VpZGUgbWUgaG93IHRvIHJlbW92ZSB4ODZAa2VybmVsLm9yZyBmcm9tIGI0IHRvb2xp
bmcNClNvIHRoYXQgeDg2QGtlcm5lbC5vcmcgd2lsbCBub3QgYXV0b21hdGljYWxseSBsaXN0ZWQ/
DQoNCkNoZWVycywNCkJpanUNCg0K

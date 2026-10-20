Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.228.60
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792489256;
	b=gAe4uSqRCI9PvBZ+ePZRmH9yWwlPMRtznPeU09Liod6Qky6JkJxgWZ/FVvt+Xl8Apn55
	 6Hst2jjomTtm3ABnIQwiJcXVmA6zDzXa/uBfIAyWjdNQQDosI3YzGyO3jWPf95aop8H6t
	 fstStf0QIbCPTnCmqLXw9FMjORtwcY8sqt0BAcfGjTg4ajNHfU0Wm94rvuhOBVtVYJJkp
	 Ig0xndYjRtv1KpGGb8w8E+/b8dG4PX0oOWylwqe8Pg84XtYza1hLk5ckXhQ6M+VWbzRrT
	 OwNlQ+78lZjOd/wLOge0hJJKrr2QZVyPbG36P7F9wnoiPFSIF5kd+8/GKLRqWPQOQKw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792489256;
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
	bh=z9r3c3CCNmfgLUST/Xvp5ZAjrEEHkxWUnnXwAnwDhoI=;
	b=RgJ07zsmBuoDVYPmCrrv3zqXn9uxvJ12tS57+UNowKY5fnFskmaBj/eqjybepZ8GCNdz
	 0f6ClzatZ+s6bW/SEle0tUbe4tj0NRUsJ6+plHrKkj1xKANbKUezy8R60xTjJTYEH5WbB
	 vpXXdDIwfk7B6O4SMhk8fNGnamEPQfRrlus4R0keqxuxXQ+7cXheelps1c1TNGUHKhJrI
	 KRdFpYMr0b7caoiXMwdbqjAz5I6V8zPRhqnl+4ZsnCnh+iWCHnDaZoxVBpWP81agMqQi8
	 Y6QsEVfKdWughAwE3nDKBoMe1y/YOp8zckKfX3YFzRBAMiOzb44Zsul/BunzsFzlzyw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bp.renesas.com;
	spf=pass smtp.mailfrom=bp.renesas.com;
	dkim=pass header.d=bp.renesas.com header.i=@bp.renesas.com header.a=rsa-sha256 header.s=selector1 header.b=B6KIXhtT;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.228.60
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010060.outbound.protection.outlook.com [52.101.228.60])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AC3760A2605;
	Tue, 20 Oct 2026 09:40:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6AC3760A2605
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=bp.renesas.com header.i=@bp.renesas.com header.a=rsa-sha256 header.s=selector1 header.b=B6KIXhtT
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Cuf8iMY5ofoQvdAuWoWZM9FgrlElf4qp9sKrBvS1yrnIddXwL+5P+AfCf4uUHX4SlEBoxvHdqw72Isvio06Et7Ph/CfYgZT/KNAAekN1t0iQ0YcFflrb2lkWn8r2ugJzFBPLqBrpwyIHkmp7s+FN4lWM9Vv/Pkfte0ApF1bLfzM3nsJWyQxiLXfwznbx0+JNqYxA56pvtNNQBfb+MnhOEVcT3/EiH+LfkMcS0T5AHGN4N35vuPeM+fmNNghatYaSavn04uH9dLvvk/BNCz+zZIx9Xx7RSUv2rYoVHt+ITqjdYGwT93y0+Q6UY/ubIrPMHoJKlQCaaPgs5cGNXG0FCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z9r3c3CCNmfgLUST/Xvp5ZAjrEEHkxWUnnXwAnwDhoI=;
 b=ZN4k73G2GitbTkg1nroJQIAUWY0j09Qo8Zt4sw7aVpKsH4w6BvoGqCqIH/YC+SO/KZoX2r0PxF25GsnrfnbC71IX5z6B+DIZ+MPqglGpYYMxoaWZONp8GecaR0Fsz2gR7cUqD74uyKRF8O6UyF54wITXSzUU2RMHQM9yot0pV7+zSXH7qhCVrt/NbBkQdECraen2LGD2J8hwxOTcE/2idfP1W3yUG/dkvgPQGvkXeLPNwqeBqXM+GdbiMhC+PYBRn7SfOTv4mHlKvVhWR8Ns9QdpKV4RpkRS9nVhy64JZ3zWvVjSKpz1+yvNbIePOR5KG/pquRfYJ3xbmPJ+GMdWgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z9r3c3CCNmfgLUST/Xvp5ZAjrEEHkxWUnnXwAnwDhoI=;
 b=B6KIXhtT8j5jbzWB8Skg1i8a4RP40+mZyKQAgMTklRvJEbnntsyMLaYDIBtZAxGG5JMx+RFZat2FtuCDm+qOuYtx8Lgbxw+MCl0XHrrJ0tWS8T91L9qa7cFxZRogb6EbiaeUQ8RjGlHDseSW5fl7zAJY4rvyl3qd5PR5z2WIbjk=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by OS3PR01MB9429.jpnprd01.prod.outlook.com (2603:1096:604:1c7::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Tue, 20 Oct
 2026 09:40:49 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de%6]) with mapi id 15.21.0496.021; Tue, 20 Oct 2026
 09:40:48 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: geert <geert@linux-m68k.org>, "biju.das.au" <biju.das.au@gmail.com>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby
	<jirislaby@kernel.org>, Au Dang <au.dang.jx@renesas.com>, Geert Uytterhoeven
	<geert+renesas@glider.be>, Prabhakar Mahadev Lad
	<prabhakar.mahadev-lad.rj@bp.renesas.com>, Frank Li <Frank.Li@nxp.com>,
	Cosmin-Gabriel Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH 3/4] serial: sh-sci: Skip TDxE status clear for PORT_SCI
Thread-Topic: [PATCH 3/4] serial: sh-sci: Skip TDxE status clear for PORT_SCI
Thread-Index: AQHdX+uKU5XdgtR0/E+7uhFwdkpa+bcGHFIAgAAHjHA=
Date: Tue, 20 Oct 2026 09:40:48 +0000
Message-ID:
 <TY3PR01MB1134642EE67B528D5C9DF9A1786672@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20261019170139.473808-1-biju.das.jz@bp.renesas.com>
 <20261019170139.473808-4-biju.das.jz@bp.renesas.com>
 <CAMuHMdVJAYL7L8q0ShxF8vJ-nhmyCiTgTNLJxLv9wLcshLfLGQ@mail.gmail.com>
In-Reply-To:
 <CAMuHMdVJAYL7L8q0ShxF8vJ-nhmyCiTgTNLJxLv9wLcshLfLGQ@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|OS3PR01MB9429:EE_
x-ms-office365-filtering-correlation-id: 77a4f366-94fd-4330-2ae5-08df2e8e3929
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|23010399003|38070700021|56012099006|11063799006|4143699003|261009223027099003|10067099003|22082099003|18002099003;
x-microsoft-antispam-message-info:
 1Lc6MpzTV0VCIiegCaYMKYmqL7zZSIEHDAxfm46sknPYQTRVg5z1RS4fZz3X2mTPSL4OwCpFMk3SRYPTrk9ETUzgylDXJGWyupu96fJ3XTZ9DBqZGwSEISjtugvd8NhPR/PFiuiMC432luGf8MLKwJsE1qMYrrSW/uEcoEL7ossv8tmw0hsWwhL+qwEFNioXiA9kN2Wx23KJl7AZhn3CmQye3WbLmeapzZeKBc0vvjgLzbXbUZxV0HhauUo+bVD/Bk7vTR+eRZAUS0EhRZAHbD0BEMoUUn7d3wj+KsK3LatnwgsI9/Dl1MWiS5v+NLfDupZA5iCmZo/J80vLaGFkIlaUWn/T1mkfN1wDwuBfinlsGSxJMZzv9+QCNMkz2W1EqGwTB13I7BPryVo6d1uiARd/XWu1g3CCj0cQCzU8SMyHj3Aw+pR12xj9rLN2L7WDWx2+OMbKYXdAsiBzV0dnsgEai5tRoUHWhMGLINmVjNkQLTIsC5Hj9uyJqJeQ2p9iQb+MLakd2/8Ms2+KtIM+zdYVdl17BlJRkfyfbCfVLCIfmFmBwkgMAH+B2Lqw05p4NVUrXYwRTjgeBJQPMlrIamDzRbLZToqRzSn6UH2SRDJHNH4T3gxvt2bpqRkSmpHMdLCPpd55Qp6mYmQOfGi54iqf4FphIK3J2t1pzFFbQS25HAOTTF66Jckk2m2hHfUvGEAl8ArjZwIsUJWATl31KlXUeokTKN0NHXdYd+Y4UkY=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(38070700021)(56012099006)(11063799006)(4143699003)(261009223027099003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RXhQSGF4L0c2WEhkOFl0ME4vTWhiOWdZV1RXS2dIL3F1V2tIV1UrbVBiQmpn?=
 =?utf-8?B?TENXdWdKYXV2cHJ0WGtRRlhjcGNyMUV0dzdZcHVDVzczeDg2Qlg5VG96L1pL?=
 =?utf-8?B?dDJ4dVJ0UWcxUVkrMHVvczdmUzFOY09tOG5HMVFuK2NNVXRWM1RZTTZENU9a?=
 =?utf-8?B?eUl1TlprYzdzVzlmdXBxQkJvU3BONk9TcTErejY5TjFlVlRDT2QwcWEyL25t?=
 =?utf-8?B?UUwvbzVONlFWRVAxdVZjbzAzNE9kT3NxUlhKTUpEQXEwSEI2Y003OHkvdnpw?=
 =?utf-8?B?U2p1M0g1eTBPcnhKa0EzSDA3Vit0aTZybmh3NWZxNnA1L2xaZDgwRUhjcVFK?=
 =?utf-8?B?NUU1T01zWnRCNE9LQXNlQXVkaE53UzZNVTMvVHVQc25jYVdXeG9XK3oyT0tC?=
 =?utf-8?B?R0s5NnlZOU1hTXd1T0lLNDNEdjE1WTRjSXRaa09ObGRHb3BGK1BFYzkwYTJh?=
 =?utf-8?B?S2JRRkNIc3JmNHhZMnNkbjFmQ0Fxb01RWEQ0STdKaTAxZ3ZmUWxObU1BTDlR?=
 =?utf-8?B?WGg3M1B5K0tjTXZFbExYM203ZG00UkpkYy9kQ05ia0Z6NkVocWNLaGh1cWxW?=
 =?utf-8?B?eW04MlAySVlIWE9qUDU0U0pRVVh1OVUyVDZzM29xQmNHWU1uSVJEb1ExSGh4?=
 =?utf-8?B?ajRTRTkrdmRMNjZUbDh3TW5jTHpQRkFMMXZCZ2cvcEhwc1NXdytCZzhkN2sx?=
 =?utf-8?B?alhjRDNNbUxwalpXMTUxazl5c2VDRzJmSXpJcnFmYzJ0VUFwclJ6TWRwQ2Uw?=
 =?utf-8?B?RTdvK3IxZTlXdHpsbTR5Y1NIdHpaTGtiQ0wyQXdPR1hEK1dUdU40dEd5ZFV2?=
 =?utf-8?B?ZGwycXVQVXZLTTFhMlZmdkRjVnE3M3B6TXQveU1Gb1c1QThrMUMwanphbGNw?=
 =?utf-8?B?Y2VGZWd1aCsxenZpSnJ0bnpmUElkVlI2SDdEQUZ0UllxKytnL1hpejcxZVpi?=
 =?utf-8?B?bDlPMjArRFZyNWtDRHU5eUFUMTdpRE1aVjF1VFphN3VRK3pCYVVpOFYxRmlh?=
 =?utf-8?B?RFBTZjZoUmxVV1plQ2dPUjFDL1B1YitQdkp3YVpkUTdLNEJGYkc4R0lrTHpn?=
 =?utf-8?B?d2JNTlAyM29seC9ITWpKK0V0U0h0cXA3ZTVjeURlU3pPU1hPdmxQN280d1ZF?=
 =?utf-8?B?eHJnTEdDU2xiZ0pMa000Y1dpdjNRd0xmN3NVTFRUb1ZtTWdhQW5DSlIwd01s?=
 =?utf-8?B?T1NkMjFkOW1ZckhjMWk3dDVlT0tyYVlsRUpwTHR3Sjh3UFY2c2FqVUhicUNt?=
 =?utf-8?B?UkJOeTJnNndHMTdVNklwS0R0c2o3b0tvSkZPS3kvTFQvWGFiSlRRYys1V0ZY?=
 =?utf-8?B?S25hcW9WMVROZnhYMDZGeHllRWx6ODc0d1pWenllWjlZOWMwZW5Dd1RySmdy?=
 =?utf-8?B?ZVp2Z2pBcDgrZnlxZXdUcTlIUDFObFlvSVhQMlZ1MGtFdkVVdGVmZ2xmS2c2?=
 =?utf-8?B?WVRkTVBwM04ya1hmc0tlTWRFcG1nV3pHbWlHYmhya3ltZTE2MnV6NWdrT2tj?=
 =?utf-8?B?TGtxYXpCL0FzdS9PL0VpckJWMG41dUp5RmVLUjNLQ3BFeGRVSW1XbkxrK3Er?=
 =?utf-8?B?YWwybkJLNWlJQ3MxMW1XdGFEeWRmZDNVMUxNTjIrUTB1ZkhJNTdDUCsvWUdK?=
 =?utf-8?B?cU5aZnFFTUZIUlJ6Y3VBeDl6bmJuYXdYTURFMUtOM2IrQWRPaTQ2V0RKU1A3?=
 =?utf-8?B?UXlmaXRPaTdlTDNqQTV1VUJBNXpxcG1LdDdXbVNFWU1wV1RpLzZIbFkwb1lT?=
 =?utf-8?B?b29XWjBNQVVSVzRRbVM4eFR0WG4zOEFYeWVzb3c3OXhDdHZKbVB6MW1Wdzlo?=
 =?utf-8?B?NlJtZ2xYblFVdXJyZkpGYUxTdFlEMGpTWDFQY1dYZHBuL0Z4cUUwRitnWDEx?=
 =?utf-8?B?cnJSU0JPT3pSQnRRaWhnaEE2VXRYU3NSRzVwZkV3R3RoSVIvV1pNOU14QTdJ?=
 =?utf-8?B?NWpXTHZtUlJBNFlFWlNKY1Jqb0lPNDI3TmVwZGtGSzlmTVUvcGhIZGZwVFla?=
 =?utf-8?B?MkdSNUkyQXNRL25jbWdjMWxSOUVWanhrNGlUUmNuUTlkM3JGWVhVVFFYV3FD?=
 =?utf-8?B?WHdrbVk3OWE5c0ozZEc4T0tib0U0SjExWEEvOTVTcklBWjFkZmttMjVUdkdj?=
 =?utf-8?B?Qm11clVYV2pTTWVKRGFZRHNXcUVacFAvK0k1TzN1SkRBb1BPbVJBWm10MkVx?=
 =?utf-8?B?MGgrakY1Z3BpaGtzUnVmekE4V3Q5SlRYT0tWNVg3Lzc1N3lvRGJVYldRUFR4?=
 =?utf-8?B?TDl6YjJuTTNtWVZXM0NkNTNmcTk4dEMyZytibUtIS2FibGRBT2g4bE94L0w0?=
 =?utf-8?B?aHFpUnlHRUNpazg1dERvSHEyQnp5QkFveGVwK3Y3TUdIeWNtdVZ2dz09?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 77a4f366-94fd-4330-2ae5-08df2e8e3929
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2026 09:40:48.8915
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: roSyQ5OKPviTQmMHPajPF4B0Kt+Hoc+i8pgGxTDC/XIGhXIAEQd8Wjr9BeOaZnV/qmk2TL9joFcxbfwvQolprI3E/xcgOi8UMKsSuqjD9m4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB9429

SGkgR2VlcnQsDQoNClRoYW5rcyBmb3IgdGhlIGZlZWRiYWNrLg0KDQo+IC0tLS0tT3JpZ2luYWwg
TWVzc2FnZS0tLS0tDQo+IEZyb206IEdlZXJ0IFV5dHRlcmhvZXZlbiA8Z2VlcnRAbGludXgtbTY4
ay5vcmc+DQo+IFNlbnQ6IDIwIE9jdG9iZXIgMjAyNiAwOTozNg0KPiBTdWJqZWN0OiBSZTogW1BB
VENIIDMvNF0gc2VyaWFsOiBzaC1zY2k6IFNraXAgVER4RSBzdGF0dXMgY2xlYXIgZm9yIFBPUlRf
U0NJDQo+IA0KPiBIaSBCaWp1LA0KPiANCj4gT24gTW9uLCAxOSBPY3QgMjAyNiBhdCAxOTowMSwg
QmlqdSA8YmlqdS5kYXMuYXVAZ21haWwuY29tPiB3cm90ZToNCj4gPiBGcm9tOiBBdSBEYW5nIDxh
dS5kYW5nLmp4QHJlbmVzYXMuY29tPg0KPiA+DQo+ID4gT24gUE9SVF9TQ0ksIHRoZSBURHhFIChU
cmFuc21pdCBEYXRhIEVtcHR5KSBmbGFnIGluIFNDeFNSIGlzIGNsZWFyZWQNCj4gPiBhdXRvbWF0
aWNhbGx5IGJ5IGhhcmR3YXJlIHdoZW4gZGF0YSBpcyB3cml0dGVuIHRvIFREUi4gQ2xlYXJpbmcg
aXQNCj4gPiBhZ2FpbiBmcm9tIHNvZnR3YXJlIHZpYSBjbGVhcl9TQ3hTUigpIGdlbmVyYXRlcyBh
IHNwdXJpb3VzIFRYSQ0KPiA+IGludGVycnVwdCwgd2hpY2ggY2F1c2VzIHRoZSBsYXN0IGNoYXJh
Y3RlciB0byBiZSB0cmFuc21pdHRlZCB0d2ljZS4NCj4gPg0KPiA+IFNraXAgdGhlIGNsZWFyX1ND
eFNSKCkgY2FsbCBmb3IgUE9SVF9TQ0kgaW4gc2NpX3RyYW5zbWl0X2NoYXJzKCkgYW5kDQo+ID4g
c2NpX3BvbGxfcHV0X2NoYXIoKSwgYXMgdGhlIGhhcmR3YXJlIGFscmVhZHkgaGFuZGxlcyBpdCBh
ZnRlciBlYWNoIFREUg0KPiA+IHdyaXRlLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogQXUgRGFu
ZyA8YXUuZGFuZy5qeEByZW5lc2FzLmNvbT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBCaWp1IERhcyA8
YmlqdS5kYXMuanpAYnAucmVuZXNhcy5jb20+DQo+IA0KPiBUaGFua3MgZm9yIHlvdXIgcGF0Y2gh
DQo+IA0KPiA+IC0tLSBhL2RyaXZlcnMvdHR5L3NlcmlhbC9zaC1zY2kuYw0KPiA+ICsrKyBiL2Ry
aXZlcnMvdHR5L3NlcmlhbC9zaC1zY2kuYw0KPiA+IEBAIC05MTMsNyArOTEzLDggQEAgc3RhdGlj
IHZvaWQgc2NpX3BvbGxfcHV0X2NoYXIoc3RydWN0IHVhcnRfcG9ydCAqcG9ydCwgdW5zaWduZWQg
Y2hhciBjKQ0KPiA+ICAgICAgICAgfSB3aGlsZSAoIShzdGF0dXMgJiBTQ3hTUl9URHhFKHBvcnQp
KSk7DQo+ID4NCj4gPiAgICAgICAgIHNjaV9zZXJpYWxfb3V0KHBvcnQsIFNDeFREUiwgYyk7DQo+
ID4gLSAgICAgICBzLT5vcHMtPmNsZWFyX1NDeFNSKHBvcnQsIFNDeFNSX1REeEVfQ0xFQVIocG9y
dCkgJiB+U0N4U1JfVEVORChwb3J0KSk7DQo+ID4gKyAgICAgICBpZiAocy0+dHlwZSAhPSBQT1JU
X1NDSSkNCj4gPiArICAgICAgICAgICAgICAgcy0+b3BzLT5jbGVhcl9TQ3hTUihwb3J0LCBTQ3hT
Ul9URHhFX0NMRUFSKHBvcnQpICYNCj4gPiArIH5TQ3hTUl9URU5EKHBvcnQpKTsNCj4gDQo+IElz
IHRoaXMgaXNzdWUgcHJlc2VudCBvbiBib3RoIGNsYXNzaWMgU0NJIGFuZCBSWiBSU0NJPw0KPiBz
LT5vcHMtPmNsZWFyX1NDeFNSKCkgcG9pbnRzIHRvIGVpdGhlciBzY2lfY2xlYXJfU0N4U1IoKSBv
cg0KPiByc2NpX2NsZWFyX0NGQygpLiBUaGUgZm9ybWVyIGFscmVhZHkgaGFzIGFuIGludGVybmFs
IGNoZWNrIGZvciBQT1JUX1NDSSwgdGhlIGxhdHRlciBoYXMgbm90LiBTbyBwcm9iYWJseQ0KPiBp
dCBzaG91bGQgYmUgaGFuZGxlZCB0aGVyZS4NCg0KSXQgaXMgYXBwbGljYWJsZSBmb3IgUlovRzJV
TCBiYXNlZCBTQ0kgYXMgZm9yIFREUkUgYW5kIHRoZSBoYXJkd2FyZSB0ZWFtIGNvbmZpcm1lZA0K
aXQgd2lsbCBiZSBhdXRvIGNsZWFyZWQgYnkgdGhlIGhhcmR3YXJlLg0KDQpPbiBSU0NJLCB3ZSBu
ZWVkZWQgdG8gZXhwbGljaXRseSBjbGVhciBpdCBhbmQgaXQgaXMgaGFuZGxlZCBpbg0KcnNjaV90
cmFuc21pdF9jaGFycygpLyByc2NpX3BvbGxfcHV0X2NoYXIoKQ0KDQpDaGVlcnMsDQpCaWp1DQoN
Cj4gDQo+ID4gIH0NCj4gPiAgI2VuZGlmIC8qIENPTkZJR19DT05TT0xFX1BPTEwgfHwgQ09ORklH
X1NFUklBTF9TSF9TQ0lfQ09OU09MRSB8fA0KPiA+ICAgICAgICAgICBDT05GSUdfU0VSSUFMX1NI
X1NDSV9FQVJMWUNPTiAqLyBAQCAtMTA0OSw3ICsxMDUwLDggQEANCj4gPiBzdGF0aWMgdm9pZCBz
Y2lfdHJhbnNtaXRfY2hhcnMoc3RydWN0IHVhcnRfcG9ydCAqcG9ydCkNCj4gPiAgICAgICAgICAg
ICAgICAgcG9ydC0+aWNvdW50LnR4Kys7DQo+ID4gICAgICAgICB9IHdoaWxlICgtLWNvdW50ID4g
MCk7DQo+ID4NCj4gPiAtICAgICAgIHMtPm9wcy0+Y2xlYXJfU0N4U1IocG9ydCwgU0N4U1JfVER4
RV9DTEVBUihwb3J0KSk7DQo+ID4gKyAgICAgICBpZiAocy0+dHlwZSAhPSBQT1JUX1NDSSkNCj4g
PiArICAgICAgICAgICAgICAgcy0+b3BzLT5jbGVhcl9TQ3hTUihwb3J0LCBTQ3hTUl9URHhFX0NM
RUFSKHBvcnQpKTsNCj4gPg0KPiA+ICAgICAgICAgaWYgKGtmaWZvX2xlbigmdHBvcnQtPnhtaXRf
ZmlmbykgPCBXQUtFVVBfQ0hBUlMpDQo+ID4gICAgICAgICAgICAgICAgIHVhcnRfd3JpdGVfd2Fr
ZXVwKHBvcnQpOw0KPiANCj4gR3J7b2V0amUsZWV0aW5nfXMsDQo+IA0KPiAgICAgICAgICAgICAg
ICAgICAgICAgICBHZWVydA0KPiANCj4gLS0NCj4gR2VlcnQgVXl0dGVyaG9ldmVuIC0tIFRoZXJl
J3MgbG90cyBvZiBMaW51eCBiZXlvbmQgaWEzMiAtLSBnZWVydEBsaW51eC1tNjhrLm9yZw0KPiAN
Cj4gSW4gcGVyc29uYWwgY29udmVyc2F0aW9ucyB3aXRoIHRlY2huaWNhbCBwZW9wbGUsIEkgY2Fs
bCBteXNlbGYgYSBoYWNrZXIuIEJ1dCB3aGVuIEknbSB0YWxraW5nIHRvDQo+IGpvdXJuYWxpc3Rz
IEkganVzdCBzYXkgInByb2dyYW1tZXIiIG9yIHNvbWV0aGluZyBsaWtlIHRoYXQuDQo+ICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgLS0gTGludXMgVG9ydmFsZHMNCg==

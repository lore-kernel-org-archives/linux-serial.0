Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11013048.outbound.protection.outlook.com [40.107.44.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C3501A5B9E;
	Thu,  1 Oct 2026 03:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790824657; cv=fail; b=oj03m9mpTKxCb0XE0N9fBtxTwoADtZi8/tJugcAnhy1IAPgrMbIrp/HwxwpKjGeOIpmDn3uPUX4g7W+XNY7zYFl88/zcJfJabPks0yayK8X04jN8mwoxIfsuch57s3kl45EsHxvRXdmV9EfgRii5yl0A8of0AqnQq9xsoLfKe1o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790824657; c=relaxed/simple;
	bh=UcfiAk10JkudcZR9ZxbTe7KZZBbh+e4Oj7egZ2fzCl0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WmA9mAD0Hkfl+ZUny6tRIyJBx7y9i0RjGjHA1lsraeBkd8iu/PFoAOua2JEF+C2JSkM0oTHk/Ab8CpkWHhoRUMp2P9KZ/UD1VPmV/ngwr3KRrXu87siOsiCFjkmbCfD6nOAo4khPKGJsLApxw2qzj96yJ+p/1+X9ud2UMtAgVuc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cortina-access.com; spf=pass smtp.mailfrom=cortina-access.com; dkim=pass (1024-bit key) header.d=CORTINA-ACCESS.COM header.i=@CORTINA-ACCESS.COM header.b=e0UI+jBp; arc=fail smtp.client-ip=40.107.44.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cortina-access.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cortina-access.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=CORTINA-ACCESS.COM header.i=@CORTINA-ACCESS.COM header.b="e0UI+jBp"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dfqQtTxPAx22NGFRZTq6Q6nitWewmxruxIMDmUDiNJ3FdetlSd2CiWHZpfr+tP9rq05s7lLMG6paVXz+mSEMABCKWiAPukAicB44aKnbdTJ/X1y44KrbkmKyeDFMwe+KYVxqfaPwDEIB68Koxn6iBHE+oItcAgRoSMyiGrjA8gziEwQoYcCVvaLJCEmoqRt0u0U/MtXZlbc09HXk6eKv4reohIwpdmDaah50BG+d4wLj4yB75fyOTkTpFPAeuOpZqAaenOJTtaltqnj3yAPuNSocnQqAlVFA46v1yoaGMdnpnIW6ddicAiOwp1588mKRGKt7ZZziUeISnB0xYlAfbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UcfiAk10JkudcZR9ZxbTe7KZZBbh+e4Oj7egZ2fzCl0=;
 b=U3aMrWjMGqiO1tZ8Db+4ceC/m4deHif2xyYZO5HLsEggIdHYJtEAF9eO9Ahb82Y54Hsoxd98eIxUCAU/9fZigZBl+tMHqreLG83FwBVdXpPaz+H4aC0wsCqmDDEqv9hMFgQYux5wCO8UaiUM9QkgOIM05ZxSEyhot4sgJjRNGKx/QHM271ENizGXPj5KbLsFJXwytTnEyZ+CN4bbtKkjgF02RmrOCtlfOTJdUip6/nhujU+igYEbqFqIraRmIz0Vc3JGBduENvziWOoW/m+3WL3FkmHca+tyGt2NDm3nfc5JXodHwBzjmWDbLir1g1BGcqvXAGlMcI4Z6+gc2iIEJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cortina-access.com; dmarc=pass action=none
 header.from=cortina-access.com; dkim=pass header.d=cortina-access.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=CORTINA-ACCESS.COM;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UcfiAk10JkudcZR9ZxbTe7KZZBbh+e4Oj7egZ2fzCl0=;
 b=e0UI+jBp+wZcCpIFIaeXRv0erys2NpQcdS2G9irs5Y7OV5rHmnMlxHujRYsdL2d/FXEBXlLc8EZzIPXknVQlwxGTX1KzfDDl2AE19xpdJjf1Vf6Q4GX2jbRgzCmrVEtnpFVV4cDa/m94BeoErwfgs1qclX8hKcUGRsQbAXOFESE=
Received: from SEZPR01MB4208.apcprd01.prod.exchangelabs.com
 (2603:1096:101:4e::6) by PUZPR01MB4956.apcprd01.prod.exchangelabs.com
 (2603:1096:301:f3::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Thu, 1 Oct
 2026 03:17:29 +0000
Received: from SEZPR01MB4208.apcprd01.prod.exchangelabs.com
 ([fe80::7087:4bde:9129:725c]) by SEZPR01MB4208.apcprd01.prod.exchangelabs.com
 ([fe80::7087:4bde:9129:725c%4]) with mapi id 15.21.0451.022; Thu, 1 Oct 2026
 03:17:29 +0000
From: Jason Li <jason.li@cortina-access.com>
To: Fil Dunsky <filipp.dunsky@gmail.com>, Arnd Bergmann <arnd@arndb.de>
CC: Linus Walleij <linusw@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>,
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, Russell King
	<linux@armlinux.org.uk>, Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Drew Fustini <fustini@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-serial@vger.kernel.org"
	<linux-serial@vger.kernel.org>
Subject: RE: [PATCH RFC 07/10] tty: serial: Add Cortina Systems CS75xx UART
 driver
Thread-Topic: [PATCH RFC 07/10] tty: serial: Add Cortina Systems CS75xx UART
 driver
Thread-Index: AQHdUMwOK5V3y77FgkSOeOEe0ntIqrbm+wWAgAD5pVA=
Date: Thu, 1 Oct 2026 03:17:28 +0000
Message-ID:
 <SEZPR01MB42087271C56AD1C7E926AF35A28A2@SEZPR01MB4208.apcprd01.prod.exchangelabs.com>
References: <20260930-b4-cs75xx-v1-0-4617c4463529@gmail.com>
 <20260930-b4-cs75xx-v1-7-4617c4463529@gmail.com>
 <CAD++jLkzcf7gJB82XT3-xb4jLujtWSNz1kT2r1-4N54rRfRNMA@mail.gmail.com>
 <1d81c2ef-7a5b-4306-83d2-ff96b0eb6a06@app.fastmail.com>
 <179076749140.3134070.3869742286743401078@gmail.com>
In-Reply-To: <179076749140.3134070.3869742286743401078@gmail.com>
Accept-Language: en-US, zh-TW, en-AS
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cortina-access.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR01MB4208:EE_|PUZPR01MB4956:EE_
x-ms-office365-filtering-correlation-id: e4354a77-7b22-45af-4af1-08df1f6a8645
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|7416014|10067099003|56012099006|4143699003|11063799006|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info:
 DF6M8vxjNzTo4jC3aqsq7hFVfBOxOikqtoquzlKJSV3ivv/uUgUg5hvTfrJxbjTWfsKjCuGGA8AA22f3fdGFgCKbwxBhID8GOjtQbo3rRn5ekYKA4UJSD3K3NxyKUCrDlbj9wLGBomJKXPD1Uvq4hAy2e0RBoB6WCHQu//Oc6HO2yTE5cKxtsM7B4kLjWallU37wkiD88+f64u8f/PN4h1HAMn/94Kjqakcpmr1amxp7rsFAzSVCCtkMqPVcl/CzswLU4YY6F18SCdJBMjZabLepU8PBZqVuMDF+6vbrxaKkyMi4eZQmSOndsZM/P3bMDPPMsgFH4eezkp27imkSSSv+O8TAZBMkWVD3Q6bi9ovNwHw3pJojKU+iitd+/QCHIZmbElM9zLD8NXyauq9mo0qCcb0esGeSX7q/5B6J+pixcsdG94u4a/8onfdWJhySxLbJysPkpGPPfqCwOlw+PgThQ7a8/JPEuWvBvjeJSH2QWaR8N7u7e6m9kzJ43mhnYnad2x77nPxHJp9c0921lZiM3CIsQymKr/TfFQGSa9wAUmhfVEVkVqMTy7LDZVT5KUfBKZL447eLGgqSU3f3esKoxyQ/Hut6CrJZfL1hJYI6x+xBMTcBFNL+JkfGOGy1R/PzEv4JI7tTe6RtazBtDvX3D7/0y2lz8FNtF7vKuNA=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR01MB4208.apcprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(7416014)(10067099003)(56012099006)(4143699003)(11063799006)(22082099003)(18002099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?eDRHY1M0R2w1Rit2WnhKRWJVQ05ReFBlSFJHUGhtUi91eGpxNS9VVVhsSHZD?=
 =?utf-8?B?Mk52ZVRjVTFkb3BIc01VekpLWFNzSUcrT2F1VUl3V3ljTjdWaUJEbHN6WGph?=
 =?utf-8?B?MGVGUkgzdUJiMzdvZHJCK1ZFZktMbXVCMURGODBRREhlWXRVTERRVjlONVUr?=
 =?utf-8?B?em5TNE51Y24wQThMUzNaL3RMRHUvUVJ0bnY3cmEycHRXMkprTUVtR0RuZS9R?=
 =?utf-8?B?R21lc3Y4WWlpNXR6Vi81RjdnTCtISDMyOE1HQTRIU1hKanNBVzlEcTU0b0ha?=
 =?utf-8?B?UEszT0pvb1R6OFR0NFlIekxoWWx6Rm92QjJiUDNNQ0xZSlJnVnZwSHE0MWV6?=
 =?utf-8?B?QXNaamI0RHBNc3VKQ0RNNjdDSE9MSFFMa08zMFY3UDVVTFBKTzdNbEFlSGIy?=
 =?utf-8?B?Ni82K3lIOXNTcGxUcDRDRitINm1LaXNqWW9zejhiMERVNFYxa1NneDRXTStq?=
 =?utf-8?B?eFJyakRpR3JYYWV4aFNCcGJ3TWtsdm8rQVNpY2ZNdGR1WisxVmEyNDN6NmUw?=
 =?utf-8?B?ei9wc0tqNGIxWS9WTjNTRXpyYmR0RENwMW9jY3dwNm83aC96Y2tFekVRVmdr?=
 =?utf-8?B?bWdXUHJXeGxkQ2ZYTU1mdGtnTTdEYnk1aWVlZ011VU11OVE2Z2lCTUN4dG40?=
 =?utf-8?B?cy9ZRG44Rm5PbDdrQWhscDlwNlN2b2g0c2x4M3VmUzh1QnpmZkFrUUJuaWxr?=
 =?utf-8?B?eVRibGdaMjloRXhiOEtxWjZFalRodFZCbEgybnBPayt4UnNVdnliWEdHeUpq?=
 =?utf-8?B?UXd3RHYza01yOGxnTmhST3V4WkRvbWtEd0cycVdoUUFCZjd2emN2MFhMb1M0?=
 =?utf-8?B?S2NHUWJJSjc4R3FhK1dwSDFMR0JiQkdMVU5aQWYyWTcweVY3V21lMWNxWTln?=
 =?utf-8?B?M1d0QXVMZG1ZZHlKZUd3WmgrUk5BeXpXRWFrMzVBcEdSSXBvamJjSHdkQmpM?=
 =?utf-8?B?cCs1SnFnL0pGU1BGWlY5QTlzWUVWV2hmY3phc1FtaWxxTldOMWg4dS9sS3Vw?=
 =?utf-8?B?S1AxeWZKcmJNWjl0MFVxMmlPbHJIYmxNRUx2d0dtdkRVZGd4RnNCUlZ4ajQ2?=
 =?utf-8?B?YmE2S0E0ZDB0dmFwVVU0RXVkM1p1cWNId1p1OXBPc3JFNTJCdlUrNWY0L2Zp?=
 =?utf-8?B?K2NmWS9XcFBpamNRQnFKbkpmQzhlTUw0dm9UMVUwc2ZwVTRFbUZWc205TFRu?=
 =?utf-8?B?UHF2MWFUU1ZaV0dHVEZOcFlLQWk3SGRsRXlJUzBudk1NSndpeGVua0FsTEY3?=
 =?utf-8?B?ZHY4bGNiOVhmYUhkVWEyRHhReEIvZFUveHVjV2ZPUW5zY0YzUVZ6UTdscG1C?=
 =?utf-8?B?WHFmU2prcDJDd3d1LzNQQzlJTlZiY3MrRWhraCswVTJJYUhFaGpyYkVJR0lB?=
 =?utf-8?B?VGJENXpsTVozZGtHTitnMEJjQm1ZY0pVNVJacm9Sd29GczZIZXI5SVk2WDcy?=
 =?utf-8?B?U3E5RUpJcnJjNUZCSFQzdnRRUkRsc0dMWkVyeHFjaVdsakdTeEk5Sjk4S0ND?=
 =?utf-8?B?Nyt0bGxXbVE0TDEyMnV0TGVCeEYvTUl6OWcxblZpSXYrcjQ2ckNpTWo4V3Vv?=
 =?utf-8?B?c0UvYlI5Y1pyS0hzNmNLZHNseTNuTGtsTDVsM3BkVVJRVWd2ay9DMFdMdU9O?=
 =?utf-8?B?cGN1OStjdkxMUEE3WDdDNXZuenh2dGtSSXRhR3ZQajZrMXZLK0MxSXZJRkxG?=
 =?utf-8?B?QUFnaTJodlFZZ0VUVVl3b21rbGVFNVRaMC9PaUtxTGpXTnBYK0J0TGVlTng4?=
 =?utf-8?B?R0Y2aUVLNVZic0RTMmhJWU1PSDZkVU01NUZCUXVRMmVxMzc0eEp2NHYycFV2?=
 =?utf-8?B?c3I4REhUSDIreUp4dW9CdXNjOVN5QVhyQzdDU0wrSTY1eEFVVUlDMGFPNkN4?=
 =?utf-8?B?TStuMXcvcXlvS1RMaml3OGVjZlAzTW05ZXRQbDk4N2VrMlVKMzJKWVYyS0U3?=
 =?utf-8?B?VTNEUDkwcGFMZXc1UWxxVzNqZitaZkhQMzltWTN5bEY0bFhGS1p1L2dxaCtr?=
 =?utf-8?B?OGpyTVBiSjJFWGVvWFd4MWRzSGZNL0tqMnNqck9UNXRHYTEzWDlIUnlqeXox?=
 =?utf-8?B?QU1qQUpLRDlMdkNuVlF5aWFvQk9kWnpQcExzdWsrUHJuNlpWelN2RjFrRnFy?=
 =?utf-8?B?UHlmd0huU01PVTNNMUFJbzNyTWFPMnlkNUlrTEdxdU1rMFB1THZxclo3eGVZ?=
 =?utf-8?B?VklVL3R1akFqSzdOV2lScVRlT0UzTUFlOTN0VlhKN3FndkVHSXBHTmdtVXlo?=
 =?utf-8?B?MGRLeUFKMTNNam92aFRCem9jZU9zcVRDT3Q2MXREZDQ0VFpEWG5FT0FzR1kv?=
 =?utf-8?B?R0dQT0U0a2NRcFFsa2hKckZuR2tEM1EyMjRUbDdwakkzSXBSM1Z5QT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: CORTINA-ACCESS.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR01MB4208.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4354a77-7b22-45af-4af1-08df1f6a8645
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2026 03:17:28.9260
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0694623c-6669-497c-89c3-3a32a9934313
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qIth1k6r/R+JGb7zhtVrL64Uy1LnTJPE/oXedfdNLKgEhUKLZVdDTwYsJy9vOW3s8HUG2Paf9bI31nPdOw0yNsnAtgwOhscB/zFbxMPkv60=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR01MB4956

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBGaWwgRHVuc2t5IDxmaWxpcHAu
ZHVuc2t5QGdtYWlsLmNvbT4NCj4gU2VudDogV2VkbmVzZGF5LCBTZXB0ZW1iZXIgMzAsIDIwMjYg
NzoyNSBQTQ0KPiBUbzogQXJuZCBCZXJnbWFubiA8YXJuZEBhcm5kYi5kZT4NCj4gQ2M6IExpbnVz
IFdhbGxlaWogPGxpbnVzd0BrZXJuZWwub3JnPjsgS3J6eXN6dG9mIEtvemxvd3NraSA8a3J6a0Br
ZXJuZWwub3JnPjsNCj4gUm9iIEhlcnJpbmcgPHJvYmhAa2VybmVsLm9yZz47IEtyenlzenRvZiBL
b3psb3dza2kgPGtyemsrZHRAa2VybmVsLm9yZz47DQo+IENvbm9yIERvb2xleSA8Y29ub3IrZHRA
a2VybmVsLm9yZz47IEdyZWcgS3JvYWgtSGFydG1hbg0KPiA8Z3JlZ2toQGxpbnV4Zm91bmRhdGlv
bi5vcmc+OyBKaXJpIFNsYWJ5IDxqaXJpc2xhYnlAa2VybmVsLm9yZz47IFJ1c3NlbGwgS2luZw0K
PiA8bGludXhAYXJtbGludXgub3JnLnVrPjsgQWxleGFuZHJlIEJlbGxvbmkgPGFsZXhhbmRyZS5i
ZWxsb25pQGJvb3RsaW4uY29tPjsNCj4gRHJldyBGdXN0aW5pIDxmdXN0aW5pQGtlcm5lbC5vcmc+
OyBMb3JlbnpvIFBpZXJhbGlzaSA8bHBpZXJhbGlzaUBrZXJuZWwub3JnPjsNCj4gbGludXgtYXJt
LWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOyBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsN
Cj4gbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgbGludXgtc2VyaWFsQHZnZXIua2VybmVs
Lm9yZzsgSmFzb24gTGkNCj4gPGphc29uLmxpQGNvcnRpbmEtYWNjZXNzLmNvbT47IEphc29uIExp
IDxqYXNvbi5saUBjb3J0aW5hLWFjY2Vzcy5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggUkZD
IDA3LzEwXSB0dHk6IHNlcmlhbDogQWRkIENvcnRpbmEgU3lzdGVtcyBDUzc1eHggVUFSVA0KPiBk
cml2ZXINCj4gDQo+IEV4dGVybmFsIG1haWwgOg0KPiBUaGlzIGVtYWlsIG9yaWdpbmF0ZWQgZnJv
bSBvdXRzaWRlIHRoZSBvcmdhbml6YXRpb24uIERvIG5vdCByZXBseSwgY2xpY2sgbGlua3MsIG9y
DQo+IG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSByZWNvZ25pemUgdGhlIHNlbmRlciBhbmQg
a25vdyB0aGUgY29udGVudCBpcw0KPiBzYWZlLg0KPiANCj4gT24gV2VkLCBTZXAgMzAsIDIwMjYg
YXQgMDE6MDg6MDdQTSArMDIwMCwgQXJuZCBCZXJnbWFubiB3cm90ZToNCj4gPiBPbiBXZWQsIFNl
cCAzMCwgMjAyNiwgYXQgMTI6NTcsIExpbnVzIFdhbGxlaWogd3JvdGU6DQo+ID4+IExvb2sgYXQg
dGhpcyBpbiB5b3VyIExpbnV4IHRyZWU6DQo+ID4+IGdpdCBsb2cgLXAgYjYxYzhiZjQ2OTRiNTEx
NTc2Njg0OTM3OGRjYjg3ODdmZjU0ZTY1ZQ0KPiA+Pg0KPiA+PiBUaGlzIGlzIGVzc2VudGlhbGx5
IGEgcmVzdXJyZWN0aW9uIG9mIHRoYXQgZHJpdmVyLg0KPiA+DQo+ID4gSmFzb24gYWN0dWFsbHkg
Y2FtZSBiYWNrIHRoaXMgc3VtbWVyIHRvIHRyeSBhZ2Fpbiwgc2VlDQo+ID4gaHR0cHM6Ly9sb3Jl
Lmtlcm5lbC5vcmcvbGludXgtYXJtLWtlcm5lbC8yMDI2MDYxMDExMjgyMS4zMDMwMDk5LTEtamFz
bw0KPiA+IG4ubGlAY29ydGluYS1hY2Nlc3MuY29tLw0KPiANCj4gVGhhbmtzLCBJIHdhcyBub3Qg
YXdhcmUgb2YgZWl0aGVyLiBDb21wYXJpbmcgdGhlIHR3bywgaXQgaXMgdGhlIHNhbWUNCj4gSVA6
IHRoZSBvZmZzZXRzIG9mIENGRywgUlhfU0FNUExFLCBUWF9EQVQsIFJYX0RBVCwgSU5GTywgSUUg
YW5kIElOVCBhbmQgdGhlDQo+IGJpdCBsYXlvdXQgb2YgQ0ZHLCBJTkZPIGFuZCB0aGUgaW50ZXJy
dXB0IHJlZ2lzdGVycyBhcmUgaWRlbnRpY2FsLiBUaGUgQ29ydGluYQ0KPiBBY2Nlc3MgdmVyc2lv
biBhZGRpdGlvbmFsbHkgaGFzIGEgZmxvdyBjb250cm9sIHJlZ2lzdGVyIGF0IDB4MDQsIFJUX1RV
TkUgYXQNCj4gMHgwYywgU1RBVFVTIGF0IDB4MmMgYW5kIHRocmVlIG1vcmUgaW50ZXJydXB0IGNh
dXNlcyAoYnJlYWssIFJYIHVuZGVycnVuLCBUWA0KPiBvdmVycnVuKS4NCj4gDQo+ID4+IEFueXdh
eXMsIGNsZWFybHkgdGhpcyBkcml2ZXIgaXMgbm90IGp1c3QgZm9yIENTNzV4eCBzbyBuYW1lIGl0
DQo+ID4+IGNvcnRpbmEtdWFydC5jIHNpbXBseSwgYW5kIHVwZGF0ZSBzeW1ib2xzIGFjY29yZGlu
Z2x5LiBLY29uZmlnIHNob3VsZA0KPiA+PiBiZSBTRVJJQUxfQ09SVElOQSBldGMuDQo+ID4NCj4g
PiBJIHRoaW5rIHdlIGNsZWFybHkgd2FudCBhIGRyaXZlciB0aGF0IHdvcmtzIGZvciBib3RoIHRo
ZSBDb3J0aW5hDQo+ID4gU3lzdGVtcyBDUzc1eHggYW5kIHRoZSBDb3J0aW5hIEFjY2VzcyBDQTgy
eHgsIGhvcGVmdWxseSB0aGF0IHdvdWxkDQo+ID4gYWxzbyBzdXBwb3J0IHRoZSBvbmVzIGluYmV0
d2VlbiAoQ1M4MHh4LCBDQTgxeHgpLg0KPiANCj4gQWdyZWVkLiBGb3IgdjIgSSB3aWxsIHJlbmFt
ZSBpdCB0byBkcml2ZXJzL3R0eS9zZXJpYWwvY29ydGluYS11YXJ0LmMgd2l0aA0KPiBTRVJJQUxf
Q09SVElOQSBhbmQgU0VSSUFMX0NPUlRJTkFfQ09OU09MRSwgYW5kIG5hbWUgdGhlIGJpbmRpbmcg
c28NCj4gdGhhdCBpdCBjYW4gdGFrZSB0aGUgb3RoZXIgcGFydHMuIEkgd291bGQga2VlcCBTb0Mg
c3BlY2lmaWMgY29tcGF0aWJsZXMNCj4gKCJjb3J0aW5hLGNzNzU0Mi11YXJ0IiwgbGF0ZXIgZS5n
Lg0KPiAiY29ydGluYS1hY2Nlc3MsY2E4Mjg5LXVhcnQiKSwgc28gdGhhdCB0aGUgZmxvdyBjb250
cm9sIGFuZCB0aGUgZXh0cmEgaW50ZXJydXB0DQo+IGNhdXNlcyBjYW4gYmUgZW5hYmxlZCBwZXIg
Y29tcGF0aWJsZS4NCj4gDQo+IEkgY2FuIG9ubHkgdGVzdCBvbiB0aGUgQ1M3NTQyLiBKYXNvbiwg
d291bGQgeW91IGJlIGZpbmUgd2l0aCBhZGRpbmcgdGhlIENBODJ4eA0KPiBvbiB0b3Agb2YgdGhp
cyBkcml2ZXIgaW5zdGVhZCBvZiBhIHNlcGFyYXRlIG9uZT8gSSBhbSBoYXBweSB0byBhZGQgdGhl
DQo+IGNvbXBhdGlibGUgYW5kIHRoZSBiaXRzIHlvdSBuZWVkIGlmIHlvdSBjYW4gdGVzdCB0aGVt
Lg0KPiANCj4gVGhhbmtzLA0KPiBGaWwNCg0KWWVzLCB0aGV5IGFyZSBhY3R1YWxseSBzYW1lIEhX
IGxvZ2ljLiBCdXQgdGhlIGJyYW5kIG5hbWUgb2YgQ1N4eHh4IGlzIG93bmVkIGJ5IE1hcnZlbGwg
aW5zdGVhZCBvZiBDb3J0aW5hLUFjY2VzcyBub3cuDQpXaWxsIHRoZXJlIGFueSBsZWdhbCBpc3N1
ZSBpZiB1bmlmeSB0aGVtIGFzIG9uZSBkcml2ZXI/DQoNCg0KSmFzb24NCg==

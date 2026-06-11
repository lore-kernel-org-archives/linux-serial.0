Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11022109.outbound.protection.outlook.com [52.101.126.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87A87351C13;
	Thu, 11 Jun 2026 05:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.109
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781155598; cv=fail; b=QFQxL6HxRaAvMCBJAvCvBbImMjWz1N3QObZT1AOVQTbkEEj1TntKwdL8rqh45Wi7CIt1Zj0pQtfdAxAMrEnR5T1uMS/rCHTuh6xtcyRlu3oF7WC2TMXqdBJByl4t/A2kvQYVxhNwLlm+9vByTF5OoW0YRqKBZFcCUCZ0RDTIoH0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781155598; c=relaxed/simple;
	bh=BMuxjkN/XpiPUG+GvAxyvHIMaDmtqt3b3WPIio8oRAE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YwkYV/x5QyFadkj8+nP6GHRxlaGShdGRtFxYMRWLd5eNsTHA65qr7Xfen5eQWg6D6lqHIUOAL/iOoZS9Qbakzh83wvCCdET6tIb3DMj7vV+BUWQ/G4ygZp/dq/O+gBZHaYd8hp8hMXg4K0LnqnRrisFvCeNl1ykxJq89O9rnpSo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cortina-access.com; spf=pass smtp.mailfrom=cortina-access.com; dkim=pass (1024-bit key) header.d=CORTINA-ACCESS.COM header.i=@CORTINA-ACCESS.COM header.b=Xxv1W3K7; arc=fail smtp.client-ip=52.101.126.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cortina-access.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cortina-access.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=CORTINA-ACCESS.COM header.i=@CORTINA-ACCESS.COM header.b="Xxv1W3K7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fnw5fgTY8bYAmNr77p+QeLUdEYd/cf8SVQHVUmdjiR2ATeG26XBjaMmIdgjNGVX9gDUbreVd+vxAp0bv8WHdHzm5s2V39k2TvFmv3MGGNifzdLiESoMTLCO5v5Gu1n3hoxMopSL+c8XkjDs8eItzbEKJoA8RYZMs9krT4KHx5bMWPKE+BEREJkmDi2Q6y9qoWGMIZlD/p4TxhV01+WXAU3psom1u4srZGglA3BlYJVrwLfVNBu82htskNbeAjQ4EtFAmKne5Kbwo4yJLbJCg0OR2Q+qmAqeyvSDHBD0IPW8fI4uMLCBKIJrdjXud76fT3NrQk298D7z2pUjn7SLpQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BMuxjkN/XpiPUG+GvAxyvHIMaDmtqt3b3WPIio8oRAE=;
 b=W/oTmrGW1FZbZsVQ/oW6ymyJ9ZyGoDS7Fv3/wzdXrjTqAlUmj3Fb/1epmyULXtMndCGRguDkHGoTtIHSS08m53VZMXujdWZw6Yhf4syx4ZhBCuxiMo9PtqCe7Yy3bq1FY5UBiQI3lkoC9QXHC67dLCY5vlNrOMkQMSkv+B8VIGTHbbIpT7zgir9NTx2+RXUjL20ALetrS+/v93nrRRQ48Jgp0WN0Yz0Hvi+6jpAFYXHLvoyMnFUFy5nfVEqQ0AzH/QpBiYUGrixLCJLRKjDRpVZw+U2uMdKqXU7W+eAm6szyei4DkEKc+DtCWZK7otoyfk8zV+SVpH5OsarIQKavaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cortina-access.com; dmarc=pass action=none
 header.from=cortina-access.com; dkim=pass header.d=cortina-access.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=CORTINA-ACCESS.COM;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BMuxjkN/XpiPUG+GvAxyvHIMaDmtqt3b3WPIio8oRAE=;
 b=Xxv1W3K704UCxdQ9zMyXGg/ZFt8LUa7R0cjcZyvyJFZP4VOyFz9bI9RSiyjexsoMifCmjiUu1Kh5qwgIkgVRaVBBXr+xizqflTX4+3DaDO8Siqx0yDHyDNUTfKwvrYaEWXEcnoH45Vk7yuuuVDT9hcQxweJyLb9gDrxb59MQtlw=
Received: from JH0PR01MB5777.apcprd01.prod.exchangelabs.com
 (2603:1096:990:4a::12) by SEZPR01MB7392.apcprd01.prod.exchangelabs.com
 (2603:1096:101:29e::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.12; Thu, 11 Jun
 2026 05:26:27 +0000
Received: from JH0PR01MB5777.apcprd01.prod.exchangelabs.com
 ([fe80::f3ef:4248:51c3:9cfe]) by JH0PR01MB5777.apcprd01.prod.exchangelabs.com
 ([fe80::f3ef:4248:51c3:9cfe%6]) with mapi id 15.21.0113.011; Thu, 11 Jun 2026
 05:26:27 +0000
From: Jason Li <jason.li@cortina-access.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, Jason Li
	<jason.lee651024@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
CC: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Catalin Marinas
	<catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Arnd Bergmann
	<arnd@arndb.de>, "linux-serial@vger.kernel.org"
	<linux-serial@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/3] dt-bindings: serial: Add binding for Cortina-Access
 UART
Thread-Topic: [PATCH 1/3] dt-bindings: serial: Add binding for Cortina-Access
 UART
Thread-Index: AQHc+MxdMLFAvnkELU+m7lL7kPAUnLY3rUAAgAD2xUA=
Date: Thu, 11 Jun 2026 05:26:27 +0000
Message-ID:
 <JH0PR01MB57770E9368C75849B6AD5DF6A21B2@JH0PR01MB5777.apcprd01.prod.exchangelabs.com>
References: <20260610112821.3030099-1-jason.li@cortina-access.com>
 <20260610112821.3030099-3-jason.li@cortina-access.com>
 <021d5cb7-51bf-4221-8b58-0e8a777cb97c@kernel.org>
In-Reply-To: <021d5cb7-51bf-4221-8b58-0e8a777cb97c@kernel.org>
Accept-Language: en-US, zh-TW, en-AS
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cortina-access.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: JH0PR01MB5777:EE_|SEZPR01MB7392:EE_
x-ms-office365-filtering-correlation-id: bf891d4a-4883-4b51-ef0c-08dec779fc71
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|23010399003|376014|7416014|1800799024|11063799006|4143699003|56012099006|38070700021|18002099003|22082099003;
x-microsoft-antispam-message-info:
 k40R2XxWvOBHnRYi8+lxTjOdyOQYyUi9V2ZwunIWtRJG6Sd6DyZO6PIxxnUfNm7nCmvgJZtX3YDBzCVPhKWMBRa6CDRUdNXKENSrxCn2cZKxvcpqTyc4jQ71oVGHjsHfZr/pbjKLwzThfkFdPyI6Cf1wq2asKnRqrzbeJ+RtlDBOIqXPqPZbbbuOAYo9Osxq5o+oqc/4KUwuxsVWg9s2hYSBhpPvkv9+I9PLEQxCA3JwSjSiRAweF41toDRl8XgPh/LzKNTahAGsPMs53E+xgAm3UkELVJUzsLsAr6t2cUUV3NGqwqhouJM5QnX1jK6g7QB/YsfLAOwwA+DvrKSvvxaj8x6S6Iht7izrLsmlLYCXoAmTwodZNDHFFQ9Ajdwi/zTHxBglWHYSV0O489BunMb74OIwl4Gaynx+E5enjw8F5xreHnVMLbXbEsU/9Bg6+73MHzk/ORxZw1D09yShtxfgI3wfKX6GHSDKPMb5v9O1IWWONFZPjJxKf6tC1ZmGBcSneuNPjK6DgNQoy2O8oq2hTSHOkOx7wkaohW0XHMgUMQYVKCOFCu2gd7RVrs06mNHDwnY8rT+rHHTFxyhsv9JsFuqZtk1tglC4tawjx/r3pxb2GsQKMjWcv6NBlKRyTAfrT4vQ3kxNJbCNIAAl4xhQ6C3Pfm9lL0sbTkaQB1Wxixcg0CKSFZnifxVvw1zQX5Y43tWnTEGIY0hID7+LALSw2fGnm5Y0PqJAEl25osRryggdsUSic8BJ4XOrkxyV
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR01MB5777.apcprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(7416014)(1800799024)(11063799006)(4143699003)(56012099006)(38070700021)(18002099003)(22082099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NVprdTF4OFJKbVEzN25GVWNsc3ZFVG9IQUtoaE5saUhwZ3RlamhjWGh6c1di?=
 =?utf-8?B?MWwvSEFGL1FsZjJZUEZKN3IrbnI2REl4RDdieDMwbWU1UTEyTkZhQStsNmVH?=
 =?utf-8?B?ajVsOE50aGU5MnVuMERtakpicXQvcVZLQlo0Ylo1a0pKMEtSbmExNXp3S0xi?=
 =?utf-8?B?YUpPOVQ3Ym5RdFBJT1VUOGw2SU1hb0lKQkdNSklxRitkYjdQRzVSQWZWeC9m?=
 =?utf-8?B?dHlockEwT3ArNlFyMWk5NkliNTNqa1dGMWNWWEFXaHlvUFhRbEwxRWR2RUJJ?=
 =?utf-8?B?L3UzbllBVTEzZ09QZW1ZQ2ZSbHlYVHFvTjNLdG5IeEg2c0doMnVlek5jejZj?=
 =?utf-8?B?VXdlanBSOGgxU3pzd0luOUdjalI4SzNoNWFTUzQ1NUlUZ0lrc1RpblBPODhG?=
 =?utf-8?B?cGRPTVVHRm1HUklsenU0dFRYQzMyV2JyN3VnNDZpSnpmYjEyazQzbHIzTWo0?=
 =?utf-8?B?Z3dvaDQ4aWUyc2NyMEg1YUNTUWF4UHNiWjhmajFYWUZMK1p1eDF2bndMOEhR?=
 =?utf-8?B?VDltdUJIMFZ1WGs3TWR2aGNyb3hNck5mRk5iMUhWUnkyZmZCdEdiWTIyU3gx?=
 =?utf-8?B?VTdmK1U2dXZMTUdmMUpLc0lFaE9nanQxNW1nemJyU25mT2FxVWZTOTNXak50?=
 =?utf-8?B?TmtxRjFCYXdySWZsS2FnaDZXMEJpY053d2xYV3lma3h1VFhYTGJCUEJFdkho?=
 =?utf-8?B?eW4zU1FueFU0aG5wQll3MFVxVnN1aGtSanlNMW9xV1cwYmxUWTFmd2ZRSXZ2?=
 =?utf-8?B?WlhDRmptTmJTcnNLQUhXRU1nSHBjNjNTdHRFVWxKSFdVcTFNVHdic3I2UzNF?=
 =?utf-8?B?R1ZSUk5oZE0xaERudUpKMUlIeVZOS1N0aG4xb0sybU1aMzJoMXNMMDVKWUdD?=
 =?utf-8?B?cmwrZFJwT0RNS0s0SmlrbFZUc2lZY0VmdCtFYjlkNVJ1dzI5ejhFQjQxVUty?=
 =?utf-8?B?V29hTWpWek9NZDA2TXVWSFU4bzNtWmdiUTg1enBSVEtmeCtzRzg3RzVQL0pN?=
 =?utf-8?B?dTNyM0xlZllwNU9BcTRFRVJwUjh5UEdGMlRzdzBXYW0vOG1lb01rb0ZhUjhr?=
 =?utf-8?B?VGhWdTg5WDIyRTY0NmFNZjE3QStEWjFoNE9ZdlZEM3RTeHRjZDZhenB1QUZ6?=
 =?utf-8?B?TjdEOFZYZW9IcXFXZ3Ywc2paMmJHRm8rSGNDQjl6RlBuelhNNEVCWlZ3TnJD?=
 =?utf-8?B?WVhZRGN5dVVNcWdWRkl4dTZzSHhCZDE4ZC9oK0x0OGlDdGpjNUcwbzltUDR2?=
 =?utf-8?B?LzVhNXBicnMxNVU4dGpnUmlYQ1RzVVhzVy8raERSNlNQQWxPZ0VJelhFdWpI?=
 =?utf-8?B?VTZkMGNnSjBoczFvWlNIOWd1aWcvU0lpb3prbi9UZHhFL2NXYW5ib3FQQjRk?=
 =?utf-8?B?QkVhQ2lYYWxadllBV1pqQ0U2MmhvUWwvKzkvTHFWNDduWVJzZEhCdklKdURW?=
 =?utf-8?B?NzRUd0daSVFvK0JpSFFaaFcrcmdBRzhxQW5OQ3BDaFpTRWpJRDRaLy91RGpo?=
 =?utf-8?B?ZDBNM2hNeTJLb2lTZ3dzZFVpMDIzcFJWYXowNWJGS0lsckkrclJSZUlDbVFD?=
 =?utf-8?B?ckFveGpWNThCcUdsY29RUFdPK1V6TUw1RnozeEFmZStRa2REc2JZdU9BT2M3?=
 =?utf-8?B?TExKSmFTTmx6a2RDUEN3b0VTNkoyQTg2c3l4VzhHQ29sWW16ZE5POFlYZW9O?=
 =?utf-8?B?eU10WVFxQy80a1l3d0o2NXA2aSs2SmRjN0N4U2NDZkVZY1NnL2VDdDRxNzVt?=
 =?utf-8?B?Z2pDbjVBSTBuWXlYdlFjWWUrZllVN092MFJ1VUNyaVkvV0JZbU55WXpwME9Q?=
 =?utf-8?B?cjJIeVk4SWVDVm9kVDJLMDUzOWlwWW5KT2M5RGVMdVkzNVpwU3QvTFJxa095?=
 =?utf-8?B?ZVR5bWdFL0JOR1QybXZRaUI0WXRyN2sxZmpKU0FWK20yYlhyOHpNN1l4Z3lo?=
 =?utf-8?B?WFVyTHZZeFR3QkFnNzJNb1ZOblBiZStsNjZHTzU5d3RIbmthWldocUJ5dk9p?=
 =?utf-8?B?dVl0VVNocGRoNXpRS2Uydk80Z2ZTWkhIdHA4WGxQVmJIZ0lONGdzNkpxbzhv?=
 =?utf-8?B?d2l0bmtvSUIzYWNkTUF0QWJXNDlFUXRzVUZBa3dBUUp2SlMxdUQwLzY4ZGxw?=
 =?utf-8?B?QmN0aURGRlNPNE1lUlZsVDIvRXU4WS9Jd2VlRldFejZ0d0Rha2Y2VmQvKzhG?=
 =?utf-8?B?bFFqeGJVeXpWc1BWeUxuMnRXZlV2TDdWQW11OWNFbFgyWi90eTNscko3Wm5Q?=
 =?utf-8?B?MVR2ZUxzZjc3V08xQ1lpVGZlQTBYK0lDOVE3QllpQ0pJaEx3eFNGZmRTYTZR?=
 =?utf-8?B?RjdLd0NQNmp6dnRET1pmWDAwU1pxc0M5V1FHL29DcmRoYlFpcC9MQT09?=
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
X-MS-Exchange-CrossTenant-AuthSource: JH0PR01MB5777.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf891d4a-4883-4b51-ef0c-08dec779fc71
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jun 2026 05:26:27.2609
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0694623c-6669-497c-89c3-3a32a9934313
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8XLi3a/xKFOuz95f4SyY73A0zoW75YlGQHyhMCTBDeeZySujXRFb+xGMAq7syMz3w5uY+aojsoMlPLbHve3K3ytL4Vu7QiqHEZj8dHsJk+Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR01MB7392

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBLcnp5c3p0b2YgS296bG93c2tp
IDxrcnprQGtlcm5lbC5vcmc+DQo+IFNlbnQ6IFdlZG5lc2RheSwgSnVuZSAxMCwgMjAyNiA3OjUx
IFBNDQo+IFRvOiBKYXNvbiBMaSA8amFzb24ubGVlNjUxMDI0QGdtYWlsLmNvbT47IEphc29uIExp
DQo+IDxqYXNvbi5saUBjb3J0aW5hLWFjY2Vzcy5jb20+OyBHcmVnIEtyb2FoLUhhcnRtYW4NCj4g
PGdyZWdraEBsaW51eGZvdW5kYXRpb24ub3JnPjsgSmlyaSBTbGFieSA8amlyaXNsYWJ5QGtlcm5l
bC5vcmc+DQo+IENjOiBSb2IgSGVycmluZyA8cm9iaEBrZXJuZWwub3JnPjsgS3J6eXN6dG9mIEtv
emxvd3NraSA8a3J6aytkdEBrZXJuZWwub3JnPjsNCj4gQ29ub3IgRG9vbGV5IDxjb25vcitkdEBr
ZXJuZWwub3JnPjsgQ2F0YWxpbiBNYXJpbmFzDQo+IDxjYXRhbGluLm1hcmluYXNAYXJtLmNvbT47
IFdpbGwgRGVhY29uIDx3aWxsQGtlcm5lbC5vcmc+OyBBcm5kIEJlcmdtYW5uDQo+IDxhcm5kQGFy
bmRiLmRlPjsgbGludXgtc2VyaWFsQHZnZXIua2VybmVsLm9yZzsNCj4gbGludXgtYXJtLWtlcm5l
bEBsaXN0cy5pbmZyYWRlYWQub3JnOyBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsNCj4gbGlu
dXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENIIDEvM10gZHQt
YmluZGluZ3M6IHNlcmlhbDogQWRkIGJpbmRpbmcgZm9yIENvcnRpbmEtQWNjZXNzDQo+IFVBUlQN
Cj4gDQo+IEV4dGVybmFsIG1haWwgOg0KPiBUaGlzIGVtYWlsIG9yaWdpbmF0ZWQgZnJvbSBvdXRz
aWRlIHRoZSBvcmdhbml6YXRpb24uIERvIG5vdCByZXBseSwgY2xpY2sgbGlua3MsIG9yDQo+IG9w
ZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSByZWNvZ25pemUgdGhlIHNlbmRlciBhbmQga25vdyB0
aGUgY29udGVudCBpcw0KPiBzYWZlLg0KPiANCj4gT24gMTAvMDYvMjAyNiAxMzoyOCwgSmFzb24g
TGkgd3JvdGU6DQo+ID4gKw0KPiA+ICthbGxPZjoNCj4gPiArICAtICRyZWY6IHNlcmlhbC55YW1s
Iw0KPiA+ICsNCj4gPiArcHJvcGVydGllczoNCj4gPiArICBjb21wYXRpYmxlOg0KPiA+ICsgICAg
Y29uc3Q6IGNvcnRpbmEtYWNjZXNzLHNlcmlhbA0KPiANCj4gQXJlbid0IHdyaXRpbmcgYmluZGlu
Z3MgdmVyeSBjbGVhciBhYm91dCB0aGF0PyBQbGVhc2UsIHRha2UgeW91ciB0aW1lIHRvIHJlYWQN
Cj4gdGhyb3VnaCB0aGUgZG9jcywgc28gd2Ugd2lsbCBub3QgbmVlZCB0byByZXBlYXQgYmFzaWMg
Z3VpZGFuY2UuIEl0IGlzDQo+IGRvY3VtZW50ZWQgdGhlcmUgb24gcHVycG9zZS4NCj4gDQpBcHBy
ZWNpYXRlIGZvciB5b3VyIHRpbWUgb24gcmV2aWV3aW5nLg0KDQo+IA0KPiBCZXN0IHJlZ2FyZHMs
DQo+IEtyenlzenRvZg0KDQpUaGFua3MsDQpKYXNvbg0K

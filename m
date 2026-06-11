Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11022139.outbound.protection.outlook.com [52.101.126.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E45D1357CF9;
	Thu, 11 Jun 2026 05:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.139
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781155548; cv=fail; b=uksVOkU9/+LWQXqj9ZkRlIFQ8bRFO9BQwPBCqaJUZ7mr+3GTUXmWDodXNspJ26PQ0akfDVML41sO3MRJp8J3XQmKb8Qz9FFluteYxPCUt3ctPYiFXRzOkD3FgBo0KxxlVn0nOjbqfyY9QsIlslwz3cqPTFx+sNEj5Sx8TMfyHpA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781155548; c=relaxed/simple;
	bh=2i0ddcjvMFAcmnR4w/RSjw3Vvcnf7tfVtuEWuT6C03Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fa1yIkPEfLDwlLwOtCMyotFcM5dfKRDzca+O2GOcTl8fgJQMqhAnNcYVa923VITWntNsnxL3zoa2l+yJ+tTs6if+4zAOqbkzfGdEQkq5UOaHh4MoCuI11a8+XBfDEQEoz31doNOxmkxMKTGLRjJLkQo8oSyXe3mWJYhOxTG1yXA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cortina-access.com; spf=pass smtp.mailfrom=cortina-access.com; dkim=pass (1024-bit key) header.d=CORTINA-ACCESS.COM header.i=@CORTINA-ACCESS.COM header.b=gMorQRwD; arc=fail smtp.client-ip=52.101.126.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cortina-access.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cortina-access.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=CORTINA-ACCESS.COM header.i=@CORTINA-ACCESS.COM header.b="gMorQRwD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f9Ol47nsi2oGlcHIJ7sFEqtEstAa6Vnw0HA3CJrK6/Yt94LZ0Lpk+AKSw+pfHd4LzaZSdjROrksRQwIdXBSWVbxgmCAWwOg7ZpWX+wFcpRIYFyB2yaIuP4PFukINio+IHJml/QhA0eXR2pEIt1Kbw6MLWbtVtMuKFU0aWE3sWRZ7evA3xEYhgZ4loLftKPZgF5QI+7gA+XYEZKQBXY1VIeeDQXywX+ba7OCszt9bdTT2Ucab/kt13gm4MiC0wFq2MAvwrCQjc7ilUbY0ucbn9WM+IUNtraM6XXkBJYgsPTXS9X/1vsavua7UekfzBLxVeqcBCOrzaPrp+7RORaVpkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2i0ddcjvMFAcmnR4w/RSjw3Vvcnf7tfVtuEWuT6C03Y=;
 b=e3WJPV7rSnn3xYDGimF7U+XlQBUEtUu4+jqqo1OxOztnOI3eWBiUah3LYp/l8Eyz4Fj96TK4af+6oNIAVYjE4HjPJwdLOfqyjob+nLEXoVlqsu8HMaTospqPjyZZf4nRs18TzLdxoQYkWC1eEya0oZnn0pXYifK2i5yfQFi1st2Y2GW/yaMBLoZP2ii6h+xb0zv2aY/ML+WBitKwLs+gXdGwwqlmbAuvkNzYmWTt6aA6MDZQ9u1C4P5k5GZMaQYPRCgtJS97L9LP9xLx9q4XncJz3EvyZPsR4bAq8EE7K70qiifws8tM8XttZaA6n+IhC7oHMw8w1cnxAIxci1qsRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cortina-access.com; dmarc=pass action=none
 header.from=cortina-access.com; dkim=pass header.d=cortina-access.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=CORTINA-ACCESS.COM;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2i0ddcjvMFAcmnR4w/RSjw3Vvcnf7tfVtuEWuT6C03Y=;
 b=gMorQRwDVcaN2zXXLxsshU39xUrn0QK1hEQoDRBdnAya659NwzD7RL2jaMWMvctL66xmlxdg0AiFzx+eJt4UqHFlvFBJ9cUSK9kegAUAcRjG8D7Lnb5W6G40AZSwOaTXlP6dBjagPPboyYh40+nHxWD9Zbjsrc1oM8EdAMSo3mg=
Received: from JH0PR01MB5777.apcprd01.prod.exchangelabs.com
 (2603:1096:990:4a::12) by SEZPR01MB7392.apcprd01.prod.exchangelabs.com
 (2603:1096:101:29e::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.12; Thu, 11 Jun
 2026 05:25:37 +0000
Received: from JH0PR01MB5777.apcprd01.prod.exchangelabs.com
 ([fe80::f3ef:4248:51c3:9cfe]) by JH0PR01MB5777.apcprd01.prod.exchangelabs.com
 ([fe80::f3ef:4248:51c3:9cfe%6]) with mapi id 15.21.0113.011; Thu, 11 Jun 2026
 05:25:37 +0000
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
Thread-Index: AQHc+MxdMLFAvnkELU+m7lL7kPAUnLY3rBOAgADy93A=
Date: Thu, 11 Jun 2026 05:25:37 +0000
Message-ID:
 <JH0PR01MB5777E76BA93A767ABA139447A21B2@JH0PR01MB5777.apcprd01.prod.exchangelabs.com>
References: <20260610112821.3030099-1-jason.li@cortina-access.com>
 <20260610112821.3030099-3-jason.li@cortina-access.com>
 <068a7ba8-5b1e-46e3-9388-ba288163eb10@kernel.org>
In-Reply-To: <068a7ba8-5b1e-46e3-9388-ba288163eb10@kernel.org>
Accept-Language: en-US, zh-TW, en-AS
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cortina-access.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: JH0PR01MB5777:EE_|SEZPR01MB7392:EE_
x-ms-office365-filtering-correlation-id: 58a173dc-9b04-4ee5-2a42-08dec779dea2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|23010399003|376014|7416014|1800799024|11063799006|4143699003|56012099006|3023799007|38070700021|18002099003|22082099003;
x-microsoft-antispam-message-info:
 rjZEb1X13mdEE0k/pqyOPm2MiM9Sre2dFN6xlYyhMxwJrVXkiKDiV5Km29urGbQQZN5F39D2nYWMvREltt5IqZd3a+oMILiqIT9zW6WxbhaaSFv2fQ+XGrEpnyId31M0RnpvbtmEhpnJzNgXIRhA2kSdJZhTqFU1IFNfBu52rXXPazs7rZGVUb3wA5zIiINLqvsHhYKl9cFL7cGaG8dGv5Av0QKUVWPPFWbrxrlElgky4ON6nUtollCDeJG8isP9gyMF727PrwsL5Qc99YTdIGy7XOYqoX4LO1pDI15FiwlCxgllgLTHRgA1TNzWVFCmEnDKiQnxL/9O+xYOPSvJXZRFUILQUMQh59y06QHT0SdHkazAa1N9Lyr1s+9vWKEsU1h0cx6S7QqvyopwC0QoSHuWrZEG6Sq5b8ugF7scI/xCCSJCOix2UEd5jw97/WqETOyHrQiJN534r5Nc/C9Fua/qrwB6icmeW+AvYIOBgZSRl1noHPTbbm1BpJ9K/Kbt/U/DwOyoCQTIj38xnBdmLccTUUwHvxt44yXflQ6lf6Pbbneqb1PmuhkzG0p3Ji+xd7TpPSKhMUl7wyynQ6JImziLb0dJK4Twmk935NbExSNgcRCdCukazwjl/kPlCeGiaMhk0d1yMp+OUKwl366/Fgq09V3k1paP/fujSL5VCY4HgjfWaPwoVwLgN+f8HiSIuP2EY+q1U4Q7/ilyfeLWfQ==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR01MB5777.apcprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(7416014)(1800799024)(11063799006)(4143699003)(56012099006)(3023799007)(38070700021)(18002099003)(22082099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VTZYWXJaZ3hkb0grTTg5TkQrMmV0YTBTd09YRTNMMURUZ3FHbm8zSTVmZUIx?=
 =?utf-8?B?Qk85UFdnWTNRRUdGYXFqWkk1RWJkK2tzQWJ1ZEEzNjFxQ1FNdnh3bVl5ckhK?=
 =?utf-8?B?RGJpVk9qZ3RGL2NVVElmbmV5MXYrZlNTSjRoTVNPVHk1K3VOZ1E5anJKMmZi?=
 =?utf-8?B?WmRmNTJaS0ZPVGtST25QaVg4R0RpQmlaaGlzdUFuWFJVRXNvWDA4Vm5hU0sx?=
 =?utf-8?B?eFpuMzh2QUZoWkduTHZTbDJvaDhPVTZPVUxUc1hwVzVFK3krTjdKeWpmU3dI?=
 =?utf-8?B?K015ZnUxMU1TUkFrTEV3Zm1Hbmwyc3FIZG9GN3h0ZEdxOWV1dXQ2aWY0WFU0?=
 =?utf-8?B?NWpGRUNFbWNxakVFWjh2V2IwWWlWMWZWVTZSV2lDZCsxdkRpNk9OZU4xZWxl?=
 =?utf-8?B?WENNRGNhL3FKdTUxdWxrWkVYMUk5UWU3ZmV2VmowVlVwMTRQVlVnemYwenBP?=
 =?utf-8?B?Q0RibVpNd2o2RW1pbDc5bEpWZ1lIS0FncEhhdUFzUEluM0szS2lCRFJGL2ls?=
 =?utf-8?B?RTJGOEhWa3lHTFVnUHRUM25jTmUvdWFOV0NEQ3FlSFBLUG43cEg1eEUwRG1i?=
 =?utf-8?B?M0ZhcTlGWWNkY1VDR1JhNHBLSE52NDRLZ0NCdllDTnNNK2hkWVNwL2hjSDdq?=
 =?utf-8?B?TXdrT2FEMDFZOFlBa3JLYzhvT0FkRk0yRmpqdW5QRzJla094UExiYTh2TGlp?=
 =?utf-8?B?bG03aGNmYm1sV0VVMmZIOXdEUENLbk15Um5PYnFGK0V2UVdBdzhQREdKM3c1?=
 =?utf-8?B?NTBrbyt1dk50bHpCM3B0Zzk5QjA3Wm9rUTBJdnFsQ0FjL0txRkM1UTBHUmxu?=
 =?utf-8?B?M29KZlRGeTAydlpBbXUvcGs5eEdpWUtSMTcxbUF1eElOZEFkR1IyOFJNR3BV?=
 =?utf-8?B?NTRaVUlGV3diMzI4eHRoVDBNU1lWdUZmdWtNQkRLaHVOUEExWDU2dnQ2d3Fy?=
 =?utf-8?B?RUxXSStQcFlORmYxWW4xNnJyZnRXUHgwZTdHbFdETXNQZEd0eTZ4VXBuVUx2?=
 =?utf-8?B?Q29PdHVNeE9EYk9rWEE2N0Z1ZnAvU0JhMWNMUURKVy83cUpzT1JORWdLNnRY?=
 =?utf-8?B?WXJxanlIdFN4UndjbFNkNG1weHUyMjc5QmF5L0IrNTMxbkJoQk1TT2Fwbys2?=
 =?utf-8?B?YW90b2pvUjFSUVFxeVAvTmpHbU9ma1BHeW8rTy84NFp6S2l0NEVjWlZmS25t?=
 =?utf-8?B?L24vWjFvd0dYc3FXYkhHejczUEVwcDV1RTNqZU45TEpvb3kvdEdCVTIzUDhr?=
 =?utf-8?B?MjlueGFQRDBUQmpLWGxKNEc0NVNmZmJBMjl5L2xVQTZNN2N1NjBCVUl1eFYv?=
 =?utf-8?B?REQvVHlhZW1OclF0NGJ5WUNHTXhXQzlieDR5VXBOcFoycVVtTWVJenlvclo0?=
 =?utf-8?B?N2l1VGFtbituYUhpWk9QUTVncTZiYWJDdnE5K1E2dkg0V1M5Z01zYnYxU0Vi?=
 =?utf-8?B?S0R5UjdPKzdqRHVyYndLeDVKaHpEMjJmRHJEQ0RhK1lZa2Yya2pOVTAzc0hJ?=
 =?utf-8?B?a04vNENBb0l5dFl2Rmc1bStPN0NreWNHUG50blc0TEtUNVRhSFFqUjdDM1lL?=
 =?utf-8?B?WDFTSVREbXZRazIza1JCQ29oc1Q5aFZPTCtsVWpDN0ZUOGRBSE9kMVhKOTZy?=
 =?utf-8?B?RDJQQnA0cU9hZWdxamwrZHlQbWNBN2tkc0w5TVhKUFliSjB0Skc2ZjBkMFZI?=
 =?utf-8?B?TVo0ZTNzUUxINVBadjJrNHQ5K2dwQmVMdzQxZ1YzWmR6ZTZOUE1IK0p1b1Ju?=
 =?utf-8?B?QUF6YzBaN3A5aXdEUy9KdzhmdTU4WkJaRDc4blk4MjU1a1FLMG9reTNHVWVM?=
 =?utf-8?B?ZVU4ME5aWDR0eVgza2NvZHZGay9oL1VkOUhCUTYxT3YzdEdtbERwNXdRNFRm?=
 =?utf-8?B?bVRPVmtzbWVVaVZmODFaYlFsVXV4czNwYmhXTnJ5dks3MEV1K3VQV21uSmxR?=
 =?utf-8?B?WlpFUlJQZEdKYkxYTFNCM1NNemxTY21LWVQyTFhyZkN4M1gyZHQyUERYazl0?=
 =?utf-8?B?dnNKMkEwZXNNbXVkY2pGL2V0emtFRkVRRlozREdybmhOT3huWGlzYWJHWktM?=
 =?utf-8?B?eEdld2tDQktoME9WUGxVRk9tOUJVTU0wMXYxOHBZNStsRlZscWFXVkp0NGps?=
 =?utf-8?B?NGJMQlhPU2xoWGdmN0dBdTcrNm5mR09iOUJJcjhtMXhLWkNCcVZrZTFXMVBQ?=
 =?utf-8?B?WC9jMnFKcjFUR1E4c3Btb0hDelNNYllBRXU5Tll4VjZDdmhqSHlXMm1vcHUr?=
 =?utf-8?B?UzJzTVh2QUlUNlJmM0cvVjhWbGc5RUU3RW9hN0s2ZWh6eTFNUmEzZXRZVFg3?=
 =?utf-8?B?azJlQmlQaDRyLzhVSzU3M1RWdzJKMDZPYXBSQ1RKWnVSWnRqck5vZz09?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 58a173dc-9b04-4ee5-2a42-08dec779dea2
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jun 2026 05:25:37.2887
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0694623c-6669-497c-89c3-3a32a9934313
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JKS3bIkkONb2eadXdR0HAtPg0H+Xt0DoRJ0NpPHFl5kQNsCvM7TwgDgtger/UsoK7aoia7+I8347kCdbsy6GurzPdB7OLk1uNlxp8cKcBpU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR01MB7392

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBLcnp5c3p0b2YgS296bG93c2tp
IDxrcnprQGtlcm5lbC5vcmc+DQo+IFNlbnQ6IFdlZG5lc2RheSwgSnVuZSAxMCwgMjAyNiA3OjQ3
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
TGkgd3JvdGU6DQo+ID4gQWRkIERUIGJpbmRpbmcgc2NoZW1hIGZvciB0aGUgQ29ydGluYS1BY2Nl
c3MgVUFSVCBjb250cm9sbGVyLg0KPiA+IFRoaXMgSVAgaXMgaW50ZWdyYXRlZCBpbnRvIG1vc3Qg
Q0FYWFhYIFNvQyBmYW1pbHkgbWVtYmVycy4NCj4gPg0KPiA+IEFsc28gYWRkIHRoZSB2ZW5kb3Ig
cHJlZml4IGZvciBDb3J0aW5hIEFjY2VzcywgSW5jLiBhbmQgdGhlIHRvcC1sZXZlbA0KPiA+IEFS
TSBib2FyZCBiaW5kaW5nIGRvY3VtZW50IGZvciB0aGUgQ0E4Mjg5IChWZW51cykgU29DLg0KPiA+
DQo+ID4gU2lnbmVkLW9mZi1ieTogSmFzb24gTGkgPGphc29uLmxpQGNvcnRpbmEtYWNjZXNzLmNv
bT4NCj4gPiBBc3Npc3RlZC1ieTogQ2xhdWRlOmNsYXVkZS1vcHVzLTQtOA0KPiA+IC0tLQ0KPiA+
ICAuLi4vYmluZGluZ3MvYXJtL2NvcnRpbmEtYWNjZXNzLnlhbWwgICAgICAgICAgfCAyOSArKysr
KysrKysrKysNCj4gPiAgLi4uL3NlcmlhbC9jb3J0aW5hLWFjY2VzcyxzZXJpYWwueWFtbCAgICAg
ICAgIHwgNDYgKysrKysrKysrKysrKysrKysrKw0KPiA+ICAuLi4vZGV2aWNldHJlZS9iaW5kaW5n
cy92ZW5kb3ItcHJlZml4ZXMueWFtbCAgfCAgMiArDQo+ID4gIE1BSU5UQUlORVJTICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICB8ICA3ICsrKw0KPiANCj4gVGhpcyBpcyBzb21laG93
IGNvbXBsZXRlIG1lc3MuIHNlcmlhbCBhbmQgYXJtIHRvZ2V0aGVyPw0KPiANCj4gUGxlYXNlIGNh
cmVmdWxseSByZWFkIHN1Ym1pdHRpbmcgcGF0Y2hlcyAoYm90aCBkb2N1bWVudHMhKSBhbmQgZG9u
J3Qgc2VuZA0KPiBBSS1hc3Npc3RlZCBzbG9wLg0KPiANCj4gWW91IG11c3Qgbm90IGNvbWJpbmUg
aW5kZXBlbmRlbnQgd29ya3MgdG9nZXRoZXIuDQo+IA0KPiANClRoYW5rIHlvdSwgSSdsbCBzZXBh
cmF0ZSBwYXRjaCBmb3IgZGlmZmVyZW50IHlhbWwNCg0KPiA+ICA0IGZpbGVzIGNoYW5nZWQsIDg0
IGluc2VydGlvbnMoKykNCj4gPiAgY3JlYXRlIG1vZGUgMTAwNjQ0DQo+ID4gRG9jdW1lbnRhdGlv
bi9kZXZpY2V0cmVlL2JpbmRpbmdzL2FybS9jb3J0aW5hLWFjY2Vzcy55YW1sDQo+ID4gIGNyZWF0
ZSBtb2RlIDEwMDY0NA0KPiA+IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9zZXJp
YWwvY29ydGluYS1hY2Nlc3Msc2VyaWFsLnlhbWwNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9Eb2N1
bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvYXJtL2NvcnRpbmEtYWNjZXNzLnlhbWwNCj4g
PiBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9hcm0vY29ydGluYS1hY2Nlc3Mu
eWFtbA0KPiA+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0DQo+ID4gaW5kZXggMDAwMDAwMDAwMDAwLi5l
YzAzMjBlZDBjMGINCj4gPiAtLS0gL2Rldi9udWxsDQo+ID4gKysrIGIvRG9jdW1lbnRhdGlvbi9k
ZXZpY2V0cmVlL2JpbmRpbmdzL2FybS9jb3J0aW5hLWFjY2Vzcy55YW1sDQo+ID4gQEAgLTAsMCAr
MSwyOSBAQA0KPiA+ICsjIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wLW9ubHkgT1Ig
QlNELTItQ2xhdXNlICVZQU1MIDEuMg0KPiA+ICstLS0NCj4gPiArJGlkOiBodHRwOi8vZGV2aWNl
dHJlZS5vcmcvc2NoZW1hcy9hcm0vY29ydGluYS1hY2Nlc3MueWFtbCMNCj4gPiArJHNjaGVtYTog
aHR0cDovL2RldmljZXRyZWUub3JnL21ldGEtc2NoZW1hcy9jb3JlLnlhbWwjDQo+ID4gKw0KPiA+
ICt0aXRsZTogQ29ydGluYS1BY2Nlc3MgU29DIGJvYXJkcw0KPiA+ICsNCj4gPiArbWFpbnRhaW5l
cnM6DQo+ID4gKyAgLSBKYXNvbiBMaSA8amFzb24ubGlAY29ydGluYS1hY2Nlc3MuY29tPg0KPiA+
ICsNCj4gPiArZGVzY3JpcHRpb246DQo+ID4gKyAgQm9hcmRzIGJhc2VkIG9uIENvcnRpbmEtQWNj
ZXNzIEFSTXY4IFNvQ3MgdGFyZ2V0aW5nIG5ldHdvcmtpbmcgYW5kDQo+ID4gKyAgYWNjZXNzIGFw
cGxpY2F0aW9ucy4NCj4gPiArDQo+ID4gK3Byb3BlcnRpZXM6DQo+ID4gKyAgJG5vZGVuYW1lOg0K
PiA+ICsgICAgY29uc3Q6IC8NCj4gPiArICBjb21wYXRpYmxlOg0KPiA+ICsgICAgb25lT2Y6DQo+
ID4gKyAgICAgIC0gZGVzY3JpcHRpb246IENvcnRpbmEtQWNjZXNzIENBODI4OSAoVmVudXMpIGVu
Z2luZWVyaW5nIGJvYXJkDQo+ID4gKyAgICAgICAgY29uc3Q6IGNvcnRpbmEtYWNjZXNzLGNhODI4
OS1lbmdib2FyZA0KPiA+ICsNCj4gPiArICAgICAgLSBkZXNjcmlwdGlvbjogQ29ydGluYS1BY2Nl
c3MgQ0E4Mjg5IChWZW51cykgcmVmZXJlbmNlIGJvYXJkDQo+ID4gKyAgICAgICAgY29uc3Q6IGNv
cnRpbmEtYWNjZXNzLGNhODI4OS1yZWZib2FyZA0KPiANCj4gDQo+IFdoZXJlIGlzIHRoZSBTb0M/
IFRoaXMgbG9va3MgbGlrZSB2ZXJ5IHBvb3IgY29udHJpYnV0aW9uLiBJZiB5b3Ugb3BlbmVkIGFu
eQ0KPiBleGlzdGluZyByZWNlbnQgYm9hcmQgYmluZGluZyB5b3Ugd291bGQgc2VlIGl0IGlzIGRv
bmUgZGlmZmVyZW50bHkuDQo+IA0KVGhhbmtzLCBJJ2xsIHJlZmVyIG1vcmUgZXhpc3QgZXhhbXBs
ZXMgdG8gZml4Lg0KDQo+IEJlc3QgcmVnYXJkcywNCj4gS3J6eXN6dG9mDQoNClRoYW5rcywNCkph
c29uDQo=

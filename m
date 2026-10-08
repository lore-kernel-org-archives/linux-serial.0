Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11020112.outbound.protection.outlook.com [52.101.85.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA9E13B19D0;
	Thu,  8 Oct 2026 17:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791481124; cv=fail; b=FeOV3E7VYYiwfWP7KfbQwsSerZvvjF+UAI/LxKmZljMMd6nckgvqPqSvnb12js8oarl22pImA6bW4DJ+bHA2o4VMf4pId0qtvNih4cyPuOxM2vMQu86/GjVCbDaU+hP9hp41KBGFdBNmowxK3ZS5g2SdxLgn9q0nMlEoA6ElzL0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791481124; c=relaxed/simple;
	bh=Xpryu/z9D36pFzLsxY3oqEIN9dRW/2/ikCJjLjEQD7E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=REITMIKxG9zryBdY45PN99QHDmy2mDqQxUqnbv1HPCYq1jCjwagwp7tJqAZU5eEs2qOA6IKUCTRLzgwBoPrF9/S09vhcnWM3ZeXiCqgBVP3uznw2CxBuJHhK2xaZ8bWrbfSEZBrvKAlM2w1c3g6YmzCh/tPFkfuTNzvtOceIkLM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phil.gs; spf=pass smtp.mailfrom=phil.gs; dkim=pass (1024-bit key) header.d=NETORGFT5377951.onmicrosoft.com header.i=@NETORGFT5377951.onmicrosoft.com header.b=FYavwkK6; arc=fail smtp.client-ip=52.101.85.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phil.gs
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phil.gs
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NETORGFT5377951.onmicrosoft.com header.i=@NETORGFT5377951.onmicrosoft.com header.b="FYavwkK6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pzmPRSOHQpjrQPQYoZsRAp9vdGYoTYHi+2Q5LLGSkfMJf00iABGJxYl/JoivYdBa0gbeRfeohpG/TgM9sGO4IHt3ACkKQ26DdPzbwYr4Oo61TwtWN9m2WD+T+dJ9XgoZyAcb0fDYvmtqzZcHRiSCbEtcXOcApnZeQ7H/ETE0z/TN9CEubBPEqXlmkwSm+jNUAo+p9j9sNeekLPqPwTR+Q1eFiWzNwpACFXQK0hLe03YB44+jZaC5i9Hy77Yb6JY/5CTdj8A2bEkyGxUTWn64THd9oBgKok8KXrBNX5v+O6MSFnNlbHyq6rym64Siein2jI3YbtzmU5ezkVITpvSSJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xpryu/z9D36pFzLsxY3oqEIN9dRW/2/ikCJjLjEQD7E=;
 b=SawskiDBhA26Rkc5tVubj3PDwqwgtjnTFeZLXWUe9dE4XFFaI4NoQefKE8GhG12YROzoNuICBIAcRyFtO4i+c7MyA2AjV6XLHmsxA9UVdyaYjVWPbmKnAtgTv8V3NLhL4AA1xlEbcleDBmGUp5YF80Fnul8ZukyN764FAYr1TREYxBQz8AeYjorK1Ed3mR74C9XVpBlOzZHYvLsU5camC/0Azo84mwVJ0wvwxoMrpgMsZux4b8uDiK3YxiqVrZzEYxtVlNI4Gm5j6jT1OlqaygIEscG1amK0DHvTHdcPALrb+gBh0EngF+cl1AekTtGoTmXg2i0t/lS3eJKxPCOk5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phil.gs; dmarc=pass action=none header.from=phil.gs; dkim=pass
 header.d=phil.gs; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NETORGFT5377951.onmicrosoft.com;
 s=selector1-NETORGFT5377951-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xpryu/z9D36pFzLsxY3oqEIN9dRW/2/ikCJjLjEQD7E=;
 b=FYavwkK6zvXTshs4LcOHZWYX1Cackbz+kvcy3IKkK+eXUMa6qjWCxrXzNjmxTx5VbGkdjhz5Mq7xaz7e24MMXadcLNDsPLW7b7ZNcXqgjc+K0TifFvlNu0bmuOuAPwESe0KnA//WW1VBy1bvtSjiIQFS7KMuoX/e1N3Rc3IZN24=
Received: from BY5PR04MB6472.namprd04.prod.outlook.com (2603:10b6:a03:1eb::10)
 by SJ0PR04MB8391.namprd04.prod.outlook.com (2603:10b6:a03:3e1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Thu, 8 Oct
 2026 17:38:42 +0000
Received: from BY5PR04MB6472.namprd04.prod.outlook.com
 ([fe80::3a9:9dbc:2aeb:8827]) by BY5PR04MB6472.namprd04.prod.outlook.com
 ([fe80::3a9:9dbc:2aeb:8827%6]) with mapi id 15.21.0472.016; Thu, 8 Oct 2026
 17:38:42 +0000
From: Phil Rosenthal <phil@phil.gs>
To: "sashiko-reviews@lists.linux.dev" <sashiko-reviews@lists.linux.dev>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>
CC: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] serial: 8250_pci: Add support for ASPEED BMC VUARTs over
 PCIe
Thread-Topic: [PATCH] serial: 8250_pci: Add support for ASPEED BMC VUARTs over
 PCIe
Thread-Index: AQHdVyjD7y+hjU8szkKNfIrsjPkQ17bzpj+AgABDGoA=
Date: Thu, 8 Oct 2026 17:38:41 +0000
Message-ID: <845E41E5-2C65-4579-90CF-4D566FFABED8@phil.gs>
References: <20261008-aspeed-vuart-v1-1-d2be17c99cd7@phil.gs>
 <sashiko-outbox-164226@kernel.org>
In-Reply-To: <sashiko-outbox-164226@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phil.gs;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR04MB6472:EE_|SJ0PR04MB8391:EE_
x-ms-office365-filtering-correlation-id: 556c0369-9ea3-45db-7679-08df2562fe92
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|376014|1800799024|19092799006|366016|6133799003|18002099003|22082099003|10067099003|7055299009|38070700021|5023799004|4143699003|56012099006;
x-microsoft-antispam-message-info:
 H1aajzAumJ5izm1hJ6hD+4Fs+uVbFUv+H2j1fdnYoMYepV83/IBTyaUckYSScJ7GHgTmg/UpQnCXntuTcUt5kY66d6bDpi3XJ+OY10biqdr/7zcWKLWoxFdrzOHUdPSib5jB9+55omFkEd/Jr7rN6KeLJ+mYkcsC4lzkNqyuY6op93TTnKriqbBzg5WsKC1M42nPjhtRxOCDGyMHZgT1096ECk48173+x/jUTaiLx1kxH/ar44fGvXB1PU6kzECDU6Z8oPBX6WRhjcnxjWJW5qJuXL05JBwaOvPVBJ87UmKPwzQjCqCAI1ffekVfS+HJmCL+1MaLNy0NS8OHoD5/Ce8urmobm+IMWZ+kcWYEKxuc2hpDZq7GHG2FmKMsjuIAzBARSeFwec7SoXdtyUWGftGR2VGdpIsf87BJhCNF9UkBkZFGs9h/jinnvizpeiqHuJRPX6AKw3Nv5lQh15qnOQP0q4eAUzGfH1l+KkL1p7bFqrMq7anA6Hv1wRt/1FmPINuiAdi4xBDmbcykPOOuTdlNQv0mJmZOsZr6hlJm35RNEUZVkvcQWy/r6+6GFl/u8FIOjnQVNVNCCrDm+wMDg1SYNeeCSYAlFYqC8ib3o0rglro5xexXYTIgOOXp/BJj/iB0BAK1hyR2hvPDAZ9IOz+vtM9/f2kOOiBTorYHq+cZRtsYHorYkaSEe7yomADcKWi/VdM4/fyc+mFCtN9vBnPoaN7zMmyMEPOKxBSSQFWOyYGcmuNRWvJU7MlI2igY
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR04MB6472.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(19092799006)(366016)(6133799003)(18002099003)(22082099003)(10067099003)(7055299009)(38070700021)(5023799004)(4143699003)(56012099006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?b0ZUaEcrQlpSSFBReHJSK1FET29jbjBZZzdXLzNEY1FUc1RCbGc5SmQ5UDRV?=
 =?utf-8?B?cEF4b0xnUmJ2Nmdlb3phMGNma1JUTkpnTTlBTENmbU02eWY2MC9IM29pSEZX?=
 =?utf-8?B?aXdjSDl6UWdVc2xPemlQZUd1T2JSNFA2TDNieHZOTlJoUDA5R2RxVVA0Y1Nj?=
 =?utf-8?B?Rk5ibmZwRGs1bWhsNFJVbVdiMjNUYVlJeUFsTHMvUndCNm9UYlNEdXFFWkJ5?=
 =?utf-8?B?UGozcVFibngzNHBuUWE5Zm1INCtOaHhRM1RuZFl2SUxsTWk3NG9rOGc1QjdW?=
 =?utf-8?B?U1doVUwyTldPY2ZNYnl2TlJNd3o3aFdEZmYyczlicFNOWGQxTDZLTFpkQzlw?=
 =?utf-8?B?NjhJci9ZTzZCbHlvRFl4YWxreGFDM3orQkpmYWxXQ3BFcjBHdEpKU3JpUmdS?=
 =?utf-8?B?ckw4aUZMdHdXbUE4VmhvQW0xYlZ6dHhsSkZZZEVxTXpVV0xML0R2dXFrN1ZW?=
 =?utf-8?B?VlM4ZjQxK0FZWlRLMU5QUzgwQVU5SnNoSkJEMWtUdFBBbUFhWG1ySzVKTGFI?=
 =?utf-8?B?L0p2blE0VFBxMWw1T3ZMdlJUbVI1cTM5MmkrS2VZWnRROWdKNUt3aVdnelpk?=
 =?utf-8?B?MkVDK0NHSTVnOXltV3o0emFhR2FtR0Fqd1c3L3doalcrQXk1YTJGa0lsN0RH?=
 =?utf-8?B?M2N4VG44MVJ0VTFQWXNsRHBHSllMbnp0cG5BcVNxK1hPRDBtdHpjdndjUFhl?=
 =?utf-8?B?NEtLcUoxcFZqdnlNckx5d24zUm1XdVZwNlVhencxeEpnV2QxY3A3S3k5M2Nz?=
 =?utf-8?B?YzJNV21Id1dWSFhURkQxMjVJeE4rM1VQTWdYT1J3d0xzQWhtS0ZybElXVVJD?=
 =?utf-8?B?eEVRcWtiVS83NkUrS2RoTUR3SHlVYWRqM2ovdE8xMzBOZE5kZ3JKeW4xRk5s?=
 =?utf-8?B?cWFCWXV1amFjSHJoZkdWRjg0S0t6MWxMMDFESGRJNkRiUmlxcTh0T3lkay9w?=
 =?utf-8?B?cWxta1ExMlc1WkZHVnhnWEd2cDM2MjFXbWY4NHNLeFZuS1VXWTRpYXBndGJK?=
 =?utf-8?B?eVc2cW9uMHpQa1hZY3BBZk9PT28xREhEdVI1cGorQkp6TzFtSng4OWhDSFh1?=
 =?utf-8?B?aVNYdjkyTWVmMWRQL2JxbzB3eiszc2k1SzBwMWpxVWlRL0RlSGNmWFlBN1NO?=
 =?utf-8?B?VlNqaWEvRW9tazAyQWtqeDF5QnYzS3hraWRVM3hSOGZBVXpleXhmbWJudmQy?=
 =?utf-8?B?U2Q4T2lEdWN5L3pOeldHRXdqcDZVWlRCVlkrNmpmMmU1OXQwOGhxaTh0b0hO?=
 =?utf-8?B?K2JPOGtBK0kyeVpHRGdOaVp1QXVrck52ckloU2FhaDVlenQ2QWhiWlBxbXY3?=
 =?utf-8?B?V2dISlB0RjZkd05lOEJ5Zkx3bnBFMWNXQXFlL1dlV2dLSDNPWVp1YUFEVldL?=
 =?utf-8?B?eGg0blUrZHZjNXg5KzBLcXNqYzVtRk5iTjZnaGtraFZ6TTJpREt3eDJNMkdU?=
 =?utf-8?B?bk95RjJFeStGSEtOUit2aTZibjdpdk5WNThkcGZMZDJZSXY0REtPTFZ2Zks5?=
 =?utf-8?B?QlJZUUcvOHpoWmU5bzNONVRHN21OemExdi9kcXd0bDV3YWVVRWh1SXZIMGd1?=
 =?utf-8?B?YU1udXZ5VkpCa2dESWM5bk5Hc3QrdEY4R0RqcHpNZEh4YTJKTWNRZkVsV0RG?=
 =?utf-8?B?SU1ZY0taazBiNlBqOTJQQ1VVNWZIdXRCcFNhOGwrMzJpWTNvaGlkM1lYUzE2?=
 =?utf-8?B?ZHVqWEc1Q0NoSExmZkk0bFZQSFB6bXBDVkFKckxsWk81L1FuWi9jQkZmNTBv?=
 =?utf-8?B?Sm40MXJHblI1aXg0MDA4aVlOWmNPOXNpTGllcDJtU3crVnZRZzNKVFIwY2xw?=
 =?utf-8?B?VlM0MVR4R1lyVlExeExPbVBqbUtXd0M4UjJ6QmdudFJPRVAyZnU1dHhNWUZH?=
 =?utf-8?B?L1FXVnhUSWVlM0xYTWRYdjRJc1o0SjUyQnh4dTN5eTM5aWdqSUhabk5DZlB0?=
 =?utf-8?B?Z0RWTUpLcmZsSUtMcmY2RmdQcFo4bCt1R1B4M0NUV3Z0SGdiZWZkNzBybG5D?=
 =?utf-8?B?YlFmbUc1M1huL2duS2xaRUJUaDRlcDNzZEVad05iWHIydld6MS9GNHhIcGVF?=
 =?utf-8?B?VnNJVXFoWVNtZnZkV2R5Q3A0ZEFSdzhLS0l4N1BHZjg2aXJ5VXAvOWUwTXJs?=
 =?utf-8?B?dklCMFBxdlBZL1IxTlJmYzBhLzlrQzNQYWgwZHk3VXFGMWFSeDJPV21SM3Zi?=
 =?utf-8?B?NnB3bjlwYVE3TDQ1bjVOYUo5bFlGaTRYUlhNajY5dU5QdUtXZDZHK0JkVHBm?=
 =?utf-8?B?R0tqZEU0dE1vbzJ4Zm1BYzJUMFJLZFJqTUptVlQrRytzNFJLeXUzMkdNOW1Z?=
 =?utf-8?Q?m6RDL/ZB/6uYhnyfzv?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4D3A1B21A0B7EB4F93836AA1A0339179@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: phil.gs
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR04MB6472.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 556c0369-9ea3-45db-7679-08df2562fe92
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2026 17:38:41.7675
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 47d4f979-ea6f-4fcb-aea9-39371d64bc6b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HLKyGldWJaW8uCEcwyCtRzaDlUTg+SkwcJlbX2prI1ZhIWtL0WttxXXFf7eCCC8W
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB8391

DQoNCj4gT24gT2N0IDgsIDIwMjYsIGF0IDk6MzjigK9BTSwgc2FzaGlrby1ib3RAa2VybmVsLm9y
ZyB3cm90ZToNCj4gDQo+PiANCj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3R0eS9zZXJpYWwvODI1
MC84MjUwX3BjaS5jIGIvZHJpdmVycy90dHkvc2VyaWFsLzgyNTAvODI1MF9wY2kuYw0KPj4gaW5k
ZXggNmU1M2Q2ZDcyYThlMi4uOGMyNDNjNGZkNThhOSAxMDA2NDQNCj4+IC0tLSBhL2RyaXZlcnMv
dHR5L3NlcmlhbC84MjUwLzgyNTBfcGNpLmMNCj4+ICsrKyBiL2RyaXZlcnMvdHR5L3NlcmlhbC84
MjUwLzgyNTBfcGNpLmMNCj4gDQo+IFsgLi4uIF0NCj4gDQo+PiArLyoNCj4+ICsgKiBBIGxpdmUg
MTY1NTAgY2FuIHJlYWQgTFNSIGFzIDB4ZmYsIGJ1dCBuZXZlciBJSVIsIHdob3NlIGJpdHMgNC01
IGFyZQ0KPj4gKyAqIHJlc2VydmVkLiBPbmx5IHJlYWQgSUlSIHdoZW4gTFNSIGxvb2tzIGFic2Vu
dDogcmVhZGluZyBJSVIgY2xlYXJzIGENCj4+ICsgKiBwZW5kaW5nIFRIUkksIGFuZCB0aGlzIGFs
c28gcnVucyBvbiByZXN1bWUgd2hpbGUgdGhlIHBvcnQgbWF5IGJlIGluIHVzZS4NCj4+ICsgKi8N
Cj4+ICtzdGF0aWMgYm9vbCBwY2lfYXNwZWVkX3Z1YXJ0X3ByZXNlbnQodm9pZCBfX2lvbWVtICpi
YXNlLCB1bnNpZ25lZCBpbnQgb2Zmc2V0KQ0KPj4gK3sNCj4+ICsgdm9pZCBfX2lvbWVtICpyZWdz
ID0gYmFzZSArIG9mZnNldDsNCj4+ICsNCj4+ICsgcmV0dXJuIHJlYWRsKHJlZ3MgKyAoVUFSVF9M
U1IgPDwgUENJX0FTUEVFRF9WVUFSVF9SRUdTSElGVCkpICE9IH4wVSB8fA0KPj4gKyAgICAgICAg
cmVhZGwocmVncyArIChVQVJUX0lJUiA8PCBQQ0lfQVNQRUVEX1ZVQVJUX1JFR1NISUZUKSkgIT0g
fjBVOw0KPj4gK30NCj4gDQo+IFtTZXZlcml0eTogTWVkaXVtXQ0KPiBEb2VzIHRoaXMgbG9ja2xl
c3MgcmVhZCBvZiBVQVJUX0xTUiBkZXN0cnVjdGl2ZWx5IGNsZWFyIHJlY2VpdmVyIGVycm9yIGJp
dHM/DQo+IA0KPiBXaGlsZSB0aGUgY29tbWVudCBjb3JyZWN0bHkgbm90ZXMgdGhhdCByZWFkaW5n
IFVBUlRfSUlSIGNsZWFycyBhIHBlbmRpbmcgVEhSSSwNCj4gcmVhZGluZyB0aGUgTGluZSBTdGF0
dXMgUmVnaXN0ZXIgKFVBUlRfTFNSKSBvbiBhIDE2NTUwLWNvbXBhdGlibGUgVUFSVCB3aWxsDQo+
IGluc3RhbnRseSBjbGVhciB0aGUgcmVjZWl2ZXIgZXJyb3IgZmxhZ3MgKE92ZXJydW4sIFBhcml0
eSwgRnJhbWluZywgQnJlYWspLg0KPiANCj4+ICsNCj4+ICtzdGF0aWMgaW50IHBjaV9hc3BlZWRf
dnVhcnRfaW5pdChzdHJ1Y3QgcGNpX2RldiAqZGV2KQ0KPj4gK3sNCj4+ICsgdm9pZCBfX2lvbWVt
ICpiYXNlOw0KPj4gKyBpbnQgaSwgbiA9IDA7DQo+PiArDQo+PiArIGlmICghKHBjaV9yZXNvdXJj
ZV9mbGFncyhkZXYsIFBDSV9BU1BFRURfVlVBUlRfQkFSKSAmIElPUkVTT1VSQ0VfTUVNKSB8fA0K
Pj4gKyAgICAgcGNpX3Jlc291cmNlX2xlbihkZXYsIFBDSV9BU1BFRURfVlVBUlRfQkFSKSA8IFNa
XzRLKQ0KPj4gKyByZXR1cm4gLUVOT0RFVjsNCj4+ICsNCj4+ICsgYmFzZSA9IHBjaV9pb21hcF9y
YW5nZShkZXYsIFBDSV9BU1BFRURfVlVBUlRfQkFSLCAwLCBTWl80Syk7DQo+PiArIGlmICghYmFz
ZSkNCj4+ICsgcmV0dXJuIC1FTk9NRU07DQo+PiArDQo+PiArIGZvciAoaSA9IDA7IGkgPCBBUlJB
WV9TSVpFKHBjaV9hc3BlZWRfdnVhcnRfaW8pOyBpKyspDQo+PiArIGlmIChwY2lfYXNwZWVkX3Z1
YXJ0X3ByZXNlbnQoYmFzZSwgcGNpX2FzcGVlZF92dWFydF9vZmZzZXQoaSkpKQ0KPj4gKyBuKys7
DQo+IA0KPiBbU2V2ZXJpdHk6IE1lZGl1bV0NCj4gQmVjYXVzZSBwY2lfYXNwZWVkX3Z1YXJ0X2lu
aXQoKSBpcyBtYXBwZWQgdG8gcXVpcmstPmluaXQsIHdvbid0IGl0IGJlIGludm9rZWQNCj4gYnkg
cGNpc2VyaWFsX3Jlc3VtZV9wb3J0cygpIGR1cmluZyBzeXN0ZW0gcmVzdW1lPw0KPiANCj4gSWYg
dGhlIHBvcnQgcmVjZWl2ZXMgbWFsZm9ybWVkIGRhdGEgb3IgZXhwZXJpZW5jZXMgRklGTyBvdmVy
cnVucyB3aGlsZSB0aGUNCj4gc3lzdGVtIGlzIHJlc3VtaW5nLCB3aWxsIHRoaXMgaXRlcmF0aW9u
IGNsZWFyIHRob3NlIGVycm9yIGZsYWdzIGxvY2tsZXNzbHkNCj4gYmVmb3JlIHRoZSBkcml2ZXIn
cyBpbnRlcnJ1cHQgaGFuZGxlciBvciBwb2xsaW5nIHJvdXRpbmUgY2FuIHByb2Nlc3MgdGhlbT8N
Cg0KICBTYXNoaWtvIHBvaW50ZWQgb3V0IHRoYXQgdGhlIHByZXNlbmNlIHRlc3QgcmVhZHMgTFNS
LCB3aGljaCBjbGVhcnMgdGhlDQogIHJlY2VpdmVyIGVycm9yIGJpdHMsIGFuZCB0aGF0IHBjaV9h
c3BlZWRfdnVhcnRfaW5pdCgpIGFsc28gcnVucyBmcm9tDQogIHBjaXNlcmlhbF9yZXN1bWVfcG9y
dHMoKSB3aGlsZSB0aGUgcG9ydCBtYXkgYmUgaW4gdXNlLiAgVGhhdCBpcyByaWdodCwNCiAgYW5k
IHRoZSBJSVIgcmVhZCBoYXMgYSBzaW1pbGFyIHNpZGUgZWZmZWN0Lg0KDQogICAgIHYyIHRlc3Rz
IG9ubHkgTUNSIGluc3RlYWQ6IHJlYWRpbmcgaXQgaGFzIG5vIHNpZGUgZWZmZWN0cywgYW5kIGl0
cyBiaXRzDQogIDYtNyBhcmUgcmVzZXJ2ZWQgYXMgemVybywgc28gYSBwcmVzZW50IFZVQVJUIG5l
dmVyIHJlYWRzIGl0IGFzIGFsbA0KICBvbmVzLiAgSSBoYXZlIHRlc3RlZCB0aGF0IG9uIHRoZSBz
YW1lIGJvYXJkIGFuZCB3aWxsIHNlbmQgaXQgYWZ0ZXIgYW55DQogIG90aGVyIHJldmlldyBjb21t
ZW50cywgb3Igbm93IGlmIHlvdSBwcmVmZXIuDQoNCkJlc3QgUmVnYXJkcywNCi1QaGlsIFJvc2Vu
dGhhbA==

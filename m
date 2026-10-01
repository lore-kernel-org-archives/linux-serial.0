Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11013058.outbound.protection.outlook.com [52.101.127.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D7C1422E37;
	Thu,  1 Oct 2026 05:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790831707; cv=fail; b=OJkwRuMeEYtTgn5TwNVflC8OtFhQqUAsaE/Fr+vaURW8aVSMZzdbYU0P8PBnAgaI/f9jGx5UL6ubYyMx2M5ix+XcNse9nvRkfKXcIKpzEDk3vaMiDIQSfE5tavy+LOUilmKUX64xzUzrcpynGXQF1iFywLlVNXIJkPZubwXyKxM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790831707; c=relaxed/simple;
	bh=Hg5ntrUOcUereLEpBNg2T6r9p+VHUHcQfPmfbP/SbZg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=M6MvleziHARI+apCHMgIg8AMFprZuu3YPtFUt0h399EWQn2P4L/EX80fu92/RqgyI4NytSEXQlOC9224Kq8ScKInSjbkt95ia1r7TsrFcsSm2FzVjIV29dc1bX8m3Nb2g/S4SmvGAFY780E9L1DeUuxu4cz0W7Rhup9UJ+JsSEA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cortina-access.com; spf=pass smtp.mailfrom=cortina-access.com; dkim=pass (1024-bit key) header.d=CORTINA-ACCESS.COM header.i=@CORTINA-ACCESS.COM header.b=SnRwwlvl; arc=fail smtp.client-ip=52.101.127.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cortina-access.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cortina-access.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=CORTINA-ACCESS.COM header.i=@CORTINA-ACCESS.COM header.b="SnRwwlvl"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZKhgvZi3ezt3OylK+EF7sOlbvpUsQ5L/1RxWlJzlneyFZu5OhPBW0Ed4ux4RENP2ezrJUi5VXVmN4H1/qQJ1/9ROjWQr6N/G0zD4DsDT31HUyKj9wk8awkPcxd65uk9VzOXww2td62ME6aMm79/kKCcSf++8QJCUj6QovNvlT7Lxk8voqELU2BrAUOB9ndJJKQpcYzhfm23jSR2TH2+YulHTEPB0Xw0i6oAkXa59VAVKjvvFY4hL8CmEq4R/+dX2Qx2LrDgF6VzRKzclPdG0eNmyLBfaP0i/6NCWwqYg5mP+qKeofDl/4R+f/dI81qzNb4B7FQPre3NZGrfdMfytkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hg5ntrUOcUereLEpBNg2T6r9p+VHUHcQfPmfbP/SbZg=;
 b=gSIt4pU98VHsVvj7PTw+BrflNPr2CIqD35axKGhFS1B86Nx+h+FIYrupyu49wsuFXZaj39gxTCi4kTkxB7I0jT+7UwzUCAgPsA4414L1ZZ3DYy4BKiSCoy0UZCDuJrZ6L+QrEC1dyrDhUU1XARBb9Hg/DBHp16tM2txS1jNSGp6FlA23hD/gccULKFtWtq3sMK8KAHGeJ1uq5Pb5IplV+QGvHLvZI6ug/w2zNbMw4HQ3zXh9Mf66YJYVqRk9g2SIBbqzs+dVSZSIhFjxEsauspQLkuGnhQKW4cSuwr125r00fFqxsAoatJBjOz3xz1lUR/QTDgSQ4tdhVJG4F/BipA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cortina-access.com; dmarc=pass action=none
 header.from=cortina-access.com; dkim=pass header.d=cortina-access.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=CORTINA-ACCESS.COM;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hg5ntrUOcUereLEpBNg2T6r9p+VHUHcQfPmfbP/SbZg=;
 b=SnRwwlvlZUgSmzZYn4ad7NzE4vSBtvMLYXd5s5QCPMVDD+cGU8xr63D6RSPSQsXaSCzA4Ezxy7FLBVPxVXBf5njUtUJng5JV2NfciNNc+nybhcmdXvPG36qqXQIRbamw6Yj7VX7IWJJkD5e98W5n4bkZ9rTlJlOt+BcuGiYPrdY=
Received: from SEZPR01MB4208.apcprd01.prod.exchangelabs.com
 (2603:1096:101:4e::6) by SEZPR01MB6107.apcprd01.prod.exchangelabs.com
 (2603:1096:101:21f::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Thu, 1 Oct
 2026 05:14:59 +0000
Received: from SEZPR01MB4208.apcprd01.prod.exchangelabs.com
 ([fe80::7087:4bde:9129:725c]) by SEZPR01MB4208.apcprd01.prod.exchangelabs.com
 ([fe80::7087:4bde:9129:725c%4]) with mapi id 15.21.0451.022; Thu, 1 Oct 2026
 05:14:59 +0000
From: Jason Li <jason.li@cortina-access.com>
To: Fil Dunsky <filipp.dunsky@gmail.com>
CC: Arnd Bergmann <arnd@arndb.de>, Linus Walleij <linusw@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby
	<jirislaby@kernel.org>, Russell King <linux@armlinux.org.uk>, Alexandre
 Belloni <alexandre.belloni@bootlin.com>, Drew Fustini <fustini@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-serial@vger.kernel.org"
	<linux-serial@vger.kernel.org>
Subject: RE: [PATCH RFC 07/10] tty: serial: Add Cortina Systems CS75xx UART
 driver
Thread-Topic: [PATCH RFC 07/10] tty: serial: Add Cortina Systems CS75xx UART
 driver
Thread-Index: AQHdUMwOK5V3y77FgkSOeOEe0ntIqrbm+wWAgAD5pVCAABL4gIAAHcEQ
Date: Thu, 1 Oct 2026 05:14:59 +0000
Message-ID:
 <SEZPR01MB4208B8B4A5A7F48F7FFE0C9FA28A2@SEZPR01MB4208.apcprd01.prod.exchangelabs.com>
References: <20260930-b4-cs75xx-v1-0-4617c4463529@gmail.com>
 <20260930-b4-cs75xx-v1-7-4617c4463529@gmail.com>
 <CAD++jLkzcf7gJB82XT3-xb4jLujtWSNz1kT2r1-4N54rRfRNMA@mail.gmail.com>
 <1d81c2ef-7a5b-4306-83d2-ff96b0eb6a06@app.fastmail.com>
 <179076749140.3134070.3869742286743401078@gmail.com>
 <SEZPR01MB42087271C56AD1C7E926AF35A28A2@SEZPR01MB4208.apcprd01.prod.exchangelabs.com>
 <179082517588.138645.14615134489246049313@gmail.com>
In-Reply-To: <179082517588.138645.14615134489246049313@gmail.com>
Accept-Language: en-US, zh-TW, en-AS
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cortina-access.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR01MB4208:EE_|SEZPR01MB6107:EE_
x-ms-office365-filtering-correlation-id: da6d6637-1403-417b-802d-08df1f7af09f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|23010399003|1800799024|22082099003|18002099003|38070700021|4143699003|10067099003|11063799006|5023799004|56012099006;
x-microsoft-antispam-message-info:
 +Kh+xnHfVY8YqaIdCOQyKeDJhb/oko10ycahMSPExUsHWErBJaBPMOcyOaNU3V/oDmhuoDXhfxVA5eTKV13P2TQ3OWGG22dP2wxc26YD9dCUgsZ1Lbz9XwOl8hP+MzguyjX4IYzeu0pfNI/Kyg0IWsZxUlaLsAOJTQMXV5L5ydJPmTh3N4u6OAWFMLhB9tCFLj6fglPtY/HEtdRrSpYoDMhOjEQ4VPQDtfPrzfUIcGOOKqkb6Ba1UuqmoAjG+xOahhBoGFJnat2UG0nezevxLX5RpdujAhIPBWRwAy4YdkNQdyxXLfIBQmqXwdHF60oyvx+zemAc/sC69EDuhxEBn8pHB6yMiDwkS/n87w1S3u+ViKJFk6yQIYqebHuT8UL4g4Oy2FoZdVhqsAf4ytsM4bByIJtxwG0iDUzCZCfHrSJJwl7CZ1/1YG4GN7ACjM/GOESOwiNJohswheumZiy4+3MX3jQ5S4Q06EFNZVtx//wxDcGVepCkq7OlcbVSmxa65KdvTI4gB+OdOAMUovm8lyE8oxWsWZTp+cbqgv8UlkwwcVVSROKR6CqcRpboclEyrcfcRGTS5bgqZPJ9KK5cDdOhWVK9vZn25Btb6tQuVCqzcKRfwt6EuzaenN12QiZJKzjKE/Ja0OmJFrsnAR5nW7VeKwB2yclZjhitJQOkBkT6wlUh1sizJFnHSwFYRqTNc+5DW0rG2lhFQuflmnLtwYvPwt4ONkFkW9JRYKvNKf0=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR01MB4208.apcprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(23010399003)(1800799024)(22082099003)(18002099003)(38070700021)(4143699003)(10067099003)(11063799006)(5023799004)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QkRtaEU1ZW83RTFOOHJSNUVVLzlVbXBBVU0vQXNMM2d3RGFja0p2MGVDV3Zq?=
 =?utf-8?B?TXdHTVJWUmkySVJNSU5hUC9GaGpCZ29mbktQMUFpbFhoTDZWYS8zalpPSFhL?=
 =?utf-8?B?K0tWZ0JlUXVUek9mTEthdk1lK0tPcVFEWEd0bXRMTWNnK0tVczdqSU9CTXlq?=
 =?utf-8?B?dDg3M2xUeVBHbk54Wk9Jd1g5K1MyOUNJQlI0MkRqWG1UYVhYZjJVWTBDaCtx?=
 =?utf-8?B?WjRIVzZTSmVzVDBNOWFEaUVhWGptV2J2M29SQTRDS2g2V3BTeUtwNEhCVXY1?=
 =?utf-8?B?Qnd3NEdXNVpheklFU1dyS2hvaE5vcHYyWktJNmcwdFU5V3BvaHF3eFNnbkxF?=
 =?utf-8?B?M01XRDNGRFljWkJjVTZwU2pLMWhYbS9JV3ZpMXRYc3FyOUlPdkQ4dWlxYU0w?=
 =?utf-8?B?VWhHUXY1cDdKV3FYdXltai9IUzRVOHc1NkdNcS9JVk1CZWpHOWltOVhjT1Q1?=
 =?utf-8?B?R00xVFlyUlhtc3hNbGQ4a25yWWhPdGtZTTdHekltMWVPaHhmWERnL2VsaXFy?=
 =?utf-8?B?WmFJT1kzMW9Hc1hkMDJ1cnZZWXZYWFY5OUJJSGFnbGNHdDFXc1J2ZURhcFhO?=
 =?utf-8?B?UzZjWklaUFpUbjVlODRXaHhBd3FvZkN1QkVneFpxRXJYRjNqMkNrRFV6dnhG?=
 =?utf-8?B?L0JqRXA4K3ZRUXdQanRXUmRubGtTRWhqNVJXRjhvN0h0RlppYnMyak1EOXEr?=
 =?utf-8?B?SVFkYUtNc1VIRGVCdGRwRW1JWjhlNDlOUnNvVnlkdmlyQkpoWU54d0Y0b3Jt?=
 =?utf-8?B?ZkozN3c5WWljdGtiTWNIa0plMFhNZ1FWcXdKanN2YjhGM2dsaDN5aXpuU3Nx?=
 =?utf-8?B?Rk45TGhUeDJ2SDdXejBVU1lpOWV5REpudFlEVGF3KzRhZkhGN29HZVd0YnJK?=
 =?utf-8?B?NTgzNll6VlNyMVJ0aVZBUWYwQjNJS3RzejZsaUFNQ1VGYjZOYUlWMlJROXpU?=
 =?utf-8?B?elFia09yK2VVdE1sTHIwVDVIb3hQeFRWRXFlcHBaemdyNmlHNkdyeXUzUmpv?=
 =?utf-8?B?NUY3d3ZxcWlqeEVhRUY2d1haUnFjU3BtNlREK0ROS0puTTZtWldxZk1kWTR6?=
 =?utf-8?B?RUVOSmZrbitTekJHWUVoNFppWjltWG42SGJ6aG5kNVMyMC9RWDZnTExydnVa?=
 =?utf-8?B?UndXcG5WTkZUR0ZwbmIwM05Wamg3WEJYeDdISWdLVXRZRlg2TjNjSm9wS1Vp?=
 =?utf-8?B?K0pHaVlRR2FLcE1YaVhoOHovQjcwMGx0YWZYR2cxaGtHamQ3L0NVRzRqQVVp?=
 =?utf-8?B?aTRmTEhsSTRHUEZZSHhPV1VDa3hFNzQ2b1BBRlNwVkxZVWlNU3FoR1NmRm0y?=
 =?utf-8?B?U1hza3diSkh3RitYcVRTeElUMXF3UzFzUThCUWxHZldJOFl6OUtmYVdPK2Ri?=
 =?utf-8?B?NlNISERuUy9pZ3RxVTNrV3FrRVcwMjA2aVVFc0FxZjFuOHBHOVZ2L1dzR0dP?=
 =?utf-8?B?MHlMbnkyYlRNbjNoVnpoNldTODVTZUZabVp0L1h3c3Q5dmRSQ01oajc0SDVn?=
 =?utf-8?B?MUFKMWIvamROKzRpS0VtMUdranFUeWIrTk9mRWMyYStSdGN6MTJKcThCazRC?=
 =?utf-8?B?bUI0ODFDSGUvY09GWmxLV0xtZ21Hc1Nuak44Y2ZPMnBrNTFwY3ZZZXRPRlg3?=
 =?utf-8?B?QWN1dzJrdDE4Z25INTZ6MThKSmgvNWhtVURuSHh3ZjVFNHdLUjhGMGRhcFNn?=
 =?utf-8?B?bTJQSkV2NEJLUW9aaDhKRy90cWdnMVllNUpTcWJRejl5NmNydml1VUR0TkpL?=
 =?utf-8?B?SVU0a1ZVaHZHYzFGUmlEUC9weGVTa29mV1M3S2JKRXBObkxUcjRkc3lMTk8z?=
 =?utf-8?B?T3lidEJXc0dpcW1LNkhTK1VveXo3M05pNlRyaW1qV0VQdERYUEtla3luZThT?=
 =?utf-8?B?c3lZYWNIOXJqcHZoL1dOQzVXWEg1V3RmUjBaU0hrRi8wNk1lUThRZllQckI0?=
 =?utf-8?B?aVA1RjZMd1VBTUlMZ3ZOcGxQbGd3bFR2WG9udEM0YzFtZ3RWSytMMWpuVEJS?=
 =?utf-8?B?dDhhT0szMzRNNDJtUkdBT1Z1blNyMy9IbzdtMitXV2d6SjUrU0IrNDJ1RXYv?=
 =?utf-8?B?TXo5b2hVMUpxclpySkZzdWc3K1VqWFc3VVlkelF4RXZ4ckJpcExNNTdwKzM5?=
 =?utf-8?B?OFpiUkw1a0hEM2lvMTdXcjk1UldxeHFLVmY1TTFIUjFHNGF3V3QvYlhQRmg3?=
 =?utf-8?B?dUtSQndBd1Foc3JBa1RjbVRrZmxOMURVNUQxTCtFdmVPL3RJN2xzdUJGZnhz?=
 =?utf-8?B?Q3BYb1hIMUVEa3cyTU1pbkp1YlZNSDVBRlV6SjJFV3pCU3B4WXFKeGFRczhK?=
 =?utf-8?B?eHYwdDl3OXAvR0NKWjhIVk8yK2ZPYmRMMFRhY0M5VlByS0dJdXYvdz09?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: da6d6637-1403-417b-802d-08df1f7af09f
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2026 05:14:59.3329
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0694623c-6669-497c-89c3-3a32a9934313
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JB5TKzKza8c56UQKzf6U5SLjUsgRTRe/4TgnHjB292hv8C4sMjNpPbO0MsicDiAGsVbeNlMU/4wAjMyitSebNLDTCHUJWl/TWsY75W8yVxw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR01MB6107

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBGaWwgRHVuc2t5IDxmaWxpcHAu
ZHVuc2t5QGdtYWlsLmNvbT4NCj4gU2VudDogVGh1cnNkYXksIE9jdG9iZXIgMSwgMjAyNiAxMToy
NiBBTQ0KPiBUbzogSmFzb24gTGkgPGphc29uLmxpQGNvcnRpbmEtYWNjZXNzLmNvbT4NCj4gQ2M6
IEFybmQgQmVyZ21hbm4gPGFybmRAYXJuZGIuZGU+OyBMaW51cyBXYWxsZWlqIDxsaW51c3dAa2Vy
bmVsLm9yZz47DQo+IEtyenlzenRvZiBLb3psb3dza2kgPGtyemtAa2VybmVsLm9yZz47IFJvYiBI
ZXJyaW5nIDxyb2JoQGtlcm5lbC5vcmc+Ow0KPiBLcnp5c3p0b2YgS296bG93c2tpIDxrcnprK2R0
QGtlcm5lbC5vcmc+OyBDb25vciBEb29sZXkNCj4gPGNvbm9yK2R0QGtlcm5lbC5vcmc+OyBHcmVn
IEtyb2FoLUhhcnRtYW4gPGdyZWdraEBsaW51eGZvdW5kYXRpb24ub3JnPjsNCj4gSmlyaSBTbGFi
eSA8amlyaXNsYWJ5QGtlcm5lbC5vcmc+OyBSdXNzZWxsIEtpbmcgPGxpbnV4QGFybWxpbnV4Lm9y
Zy51az47DQo+IEFsZXhhbmRyZSBCZWxsb25pIDxhbGV4YW5kcmUuYmVsbG9uaUBib290bGluLmNv
bT47IERyZXcgRnVzdGluaQ0KPiA8ZnVzdGluaUBrZXJuZWwub3JnPjsgTG9yZW56byBQaWVyYWxp
c2kgPGxwaWVyYWxpc2lAa2VybmVsLm9yZz47DQo+IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5m
cmFkZWFkLm9yZzsgZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7DQo+IGxpbnV4LWtlcm5lbEB2
Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LXNlcmlhbEB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDog
UkU6IFtQQVRDSCBSRkMgMDcvMTBdIHR0eTogc2VyaWFsOiBBZGQgQ29ydGluYSBTeXN0ZW1zIENT
NzV4eCBVQVJUDQo+IGRyaXZlcg0KPiANCj4gRXh0ZXJuYWwgbWFpbCA6DQo+IFRoaXMgZW1haWwg
b3JpZ2luYXRlZCBmcm9tIG91dHNpZGUgdGhlIG9yZ2FuaXphdGlvbi4gRG8gbm90IHJlcGx5LCBj
bGljayBsaW5rcywgb3INCj4gb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91IHJlY29nbml6ZSB0
aGUgc2VuZGVyIGFuZCBrbm93IHRoZSBjb250ZW50IGlzDQo+IHNhZmUuDQo+IA0KPiBPbiBUaHUs
IE9jdCAwMSwgMjAyNiBhdCAwMzoxNzoyOEFNICswMDAwLCBKYXNvbiBMaSB3cm90ZToNCj4gPiBZ
ZXMsIHRoZXkgYXJlIGFjdHVhbGx5IHNhbWUgSFcgbG9naWMuIEJ1dCB0aGUgYnJhbmQgbmFtZSBv
ZiBDU3h4eHggaXMNCj4gPiBvd25lZCBieSBNYXJ2ZWxsIGluc3RlYWQgb2YgQ29ydGluYS1BY2Nl
c3Mgbm93Lg0KPiA+IFdpbGwgdGhlcmUgYW55IGxlZ2FsIGlzc3VlIGlmIHVuaWZ5IHRoZW0gYXMg
b25lIGRyaXZlcj8NCj4gDQo+IFRoYW5rcyBmb3IgY29uZmlybWluZyB0aGF0IGl0IGlzIHRoZSBz
YW1lIGxvZ2ljLg0KPiANCj4gSSBhbSBub3QgYSBsYXd5ZXIsIGJ1dCBJIGRvIG5vdCBzZWUgYSBw
cm9ibGVtIGhlcmUuIFRoZSBwYXJ0IG51bWJlcnMgb25seQ0KPiBzaG93IHVwIGFzIGNvbXBhdGli
bGUgc3RyaW5ncywgS2NvbmZpZyBoZWxwIHRleHQgYW5kIGNvbW1lbnRzIHRoYXQgc2F5IHdoaWNo
DQo+IGhhcmR3YXJlIHRoZSBjb2RlIHJ1bnMgb24sIGFuZCB0aGUga2VybmVsIGRvZXMgdGhhdCBm
b3IgY2hpcHMgb2YgY29tcGFuaWVzDQo+IHRoYXQgd2VyZSBib3VnaHQgb3Igc3BsaXQgdXAgYWxs
IHRoZSB0aW1lLiBUaGUgZHJpdmVyIGl0c2VsZiBpcyBHUEwgY29kZTsgeW91cg0KPiBhZGRpdGlv
bnMgd291bGQgYmUgdW5kZXIgdGhlIEdQTCBhcyB3ZWxsLCB3aXRoIHlvdXIgb3duIGNvcHlyaWdo
dCBsaW5lLg0KPiBOb3RoaW5nIGluIGl0IHVzZXMgYSB0cmFkZW1hcmsgdG8gbmFtZSB0aGUgcHJv
ZHVjdC4NCj4gDQo+IFRoZSBwbGFuIGZvciB2MiBpcyBhIG5ldXRyYWwgbmFtZTogZHJpdmVycy90
dHkvc2VyaWFsL2NvcnRpbmEtdWFydC5jLA0KPiBTRVJJQUxfQ09SVElOQSwgcG9ydCB0eXBlICJD
T1JUSU5BIiwgYW5kIGEgYmluZGluZyB3aXRoIG9uZSBjb21wYXRpYmxlIHBlcg0KPiBTb0MgKCJj
b3J0aW5hLGNzNzU0Mi11YXJ0IiBmb3IgbWluZSwgYSAiY29ydGluYS1hY2Nlc3MsLi4uIiBvbmUg
Zm9yIHlvdXJzKS4gSWYNCj4gQ29ydGluYSBBY2Nlc3Mgd291bGQgcmF0aGVyIGhhdmUgdGhlIENB
IHBhcnRzIGRlc2NyaWJlZCBkaWZmZXJlbnRseSBpbiB0aGUgaGVscA0KPiB0ZXh0IG9yIHRoZSBi
aW5kaW5nIHRpdGxlLCB0ZWxsIG1lIHdoYXQgd29yZGluZyB5b3UgcHJlZmVyIGFuZCBJIHdpbGwg
dXNlIGl0Lg0KPiANCj4gVGhhbmtzLA0KPiBGaWwNClRoYW5rcyBmb3IgY2xhcmlmeWluZy4NCldl
IGFncmVlIHdpdGggdGhlIGFwcHJvYWNoIG9mIHVzaW5nIGEgc2luZ2xlIFVBUlQgZHJpdmVyIHNp
bmNlIHRoZSBDUzc1eHggYW5kIENBIHNlcmllcyBzaGFyZSB0aGUgc2FtZSBVQVJUIGhhcmR3YXJl
IGltcGxlbWVudGF0aW9uLg0KRm9yIHRoZSBEZXZpY2UgVHJlZSBjb21wYXRpYmxlIHN0cmluZ3Ms
IHdlIHdvdWxkIHByZWZlciB1c2luZyB0aGUgImNvcnRpbmEtYWNjZXNzIiB2ZW5kb3IgcHJlZml4
IGZvciB0aGUgQ0EgU29DcyAoZS5nLiAiY29ydGluYS1hY2Nlc3MsPHNvYz4tdWFydCIpLg0KV2Ug
ZG8gbm90IGhhdmUgY29uY2VybnMgd2l0aCB1c2luZyBhIG5ldXRyYWwgZHJpdmVyIG5hbWUgc3Vj
aCBhcyBjb3J0aW5hLXVhcnQuIEhvd2V2ZXIsIGZvciBEVCBiaW5kaW5ncyBhbmQgcmVsYXRlZCBk
b2N1bWVudGF0aW9uIGRlc2NyaWJpbmcgdGhlIENBIGRldmljZXMsIHdlIHdvdWxkIHByZWZlciB0
aGUgd29yZGluZyAiQ29ydGluYSBBY2Nlc3MiIHRvIGRpc3Rpbmd1aXNoIHRoZW0gZnJvbSB0aGUg
bGVnYWN5IENvcnRpbmEvTWFydmVsbCBicmFuZGVkIGRldmljZXMuDQoNClRoYW5rcywNCkphc29u
DQo=

Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11024023.outbound.protection.outlook.com [52.101.61.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CBFA143C59
	for <linux-serial@vger.kernel.org>; Mon,  8 Apr 2024 20:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712608078; cv=fail; b=b/IsY6/On0fux4DTxH0zrsGtkPXKGDdapdVCk6BXqgOS2ZkrPPtMTi/uhVQpH3Xw/U0QDk3tnj4m4haaNfSt0/5IpiBWmCAXF0G52FKVEnhFW/nCo6ymDLu0dYqix0ZhKALqbojcg2OOXhvQrQtYGkTW0D8vKCyGbMZ8KtNZmw8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712608078; c=relaxed/simple;
	bh=7CRmS68RPX0NcSmdCEeuyyrai4YE6Nfx7wHTsI+b0Cc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=X5n+qtQkrNiNJQTtt/16hNrQ3t12fSy/mkTdor0KcxVdAUX5b1++XwCmd6+D3/piDIjW9aKUXR0kont13MoOZSZdeSZmiiO3pArRNoUOywhbWlA/qfH9uC5lIa9rVl8OXfDCgLJfCcHV1OJZGz3t6Z92jpOxKOFkhHOuYydJosc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sealevel.com; spf=pass smtp.mailfrom=sealevel.com; dkim=pass (2048-bit key) header.d=sealevel.com header.i=@sealevel.com header.b=IxdvDqVx; arc=fail smtp.client-ip=52.101.61.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sealevel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sealevel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sealevel.com header.i=@sealevel.com header.b="IxdvDqVx"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fXFQwOYoX/iNyZroIWGB/5Z+WrQP7fQ0woCDkUpmgUKA+FszPNpDl1sTKocsYZ+gOE1J90/QiGb4PQMzddNLxc3Qxa+3Wx9vTJmT/2/eKCGJPzxPL3rlR30LrXWaCZpGclTu/hZTPUNqMc3pC4lRH3UZ0Rf4UBxrRWS3FG9qAOrt4haxToHfpMC6MTmhPEDgZPNgN/lfAFbDfBBjGp4T51bo3508kj3snD3CM/Hkt6ZpbUglUQU/zHR+OwvAUJmjHKpBVrexnc8eJxkrSTqYDt5LXRoAWRxZyeBGqW8mQtqPyZjnA9LOMLaas+TGyDqIKjkGmlOylbH1YBwdIuqZHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7CRmS68RPX0NcSmdCEeuyyrai4YE6Nfx7wHTsI+b0Cc=;
 b=CMDiWlyK5+1CJv0/LeI8TBgx2Hbzq41GskKUbQ8DTjUuJG7UbNebxsdc4AY7LNBT+CUOwXazffCgSbWrps/MyXNMFvvyfeb3Mu6gkd2yweeF/5by0oGOCr21uL3nH8G0THLQEu4pN2NaCEW4kEHuFNQIgoHwObG/aEAEnxOD5vMi4X60TRE20F44iLxgBenaDdQi2j7IhsLz0fcikJX2jdderL0/EYDJdHDpFxeDNRO48r+xy7qDSNh5FWGvYGoa5bw/z5sN8/0pySzIGTROKzjpKJSMEKbag65+1Bgfan0KaPZMFSiJ75YJW764ceLuhK5VFR/5SAkraExs3w4Zkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sealevel.com; dmarc=pass action=none header.from=sealevel.com;
 dkim=pass header.d=sealevel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sealevel.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7CRmS68RPX0NcSmdCEeuyyrai4YE6Nfx7wHTsI+b0Cc=;
 b=IxdvDqVxtoh+Mi2+sM/NJ9WRDT0G9OHdosDLcrVcVJCnOfgxJkzo7RCsqQ/7TNsYQnQIDqTMZQQPY+AjxXxjMZfbahERgSjmzQMoPsI7zmO8frxiAxq0+34iNQYRZmCdF04C8jnbpoAUHGhQtAH8NTxIShLUgEeYm+0bR1+zPhbOR9gq2tI0ucZts1BkrO19bENJ6i+X3HquZW1pohRhQhgVd7+bajbNthrLi6D1EH8W+YmYxVhdgQALCINY7JJyljbfK717bMUudompDY0LoUOGO8H/ORAna79Q37Faouk77J8VqUU9ccE++W8nSRL/WBGONvvltCR5DH1UeO828A==
Received: from CO1PR05MB8426.namprd05.prod.outlook.com (2603:10b6:303:e5::11)
 by PH0PR05MB7734.namprd05.prod.outlook.com (2603:10b6:510:2d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Mon, 8 Apr
 2024 20:27:52 +0000
Received: from CO1PR05MB8426.namprd05.prod.outlook.com
 ([fe80::6231:d3c9:8cd3:4169]) by CO1PR05MB8426.namprd05.prod.outlook.com
 ([fe80::6231:d3c9:8cd3:4169%7]) with mapi id 15.20.7409.049; Mon, 8 Apr 2024
 20:27:52 +0000
From: Matthew Howell <matthew.howell@sealevel.com>
To: "ilpo.jarvinen@linux.intel.com" <ilpo.jarvinen@linux.intel.com>
CC: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
	"5dd9f8b0c1dc154c73fb883cb948768ae68d1ccb.camel@sealevel.com"
	<5dd9f8b0c1dc154c73fb883cb948768ae68d1ccb.camel@sealevel.com>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, Jeff Baldwin
	<jeff.baldwin@sealevel.com>, Darren Beeson <darren.beeson@sealevel.com>, Ryan
 Wenglarz <ryan.wenglarz@sealevel.com>
Subject: Re: [PATCH V2] serial: exar: Preserve FCTR[5] bit in
 pci_xr17v35x_setup()
Thread-Topic: [PATCH V2] serial: exar: Preserve FCTR[5] bit in
 pci_xr17v35x_setup()
Thread-Index: AQHaZQtGjPOmrNLBp0ShUL1okzQC67FeooGAgAA8pwCAAD02gA==
Date: Mon, 8 Apr 2024 20:27:52 +0000
Message-ID: <cbe7931db7a6841369505b83ee3c747c981c16f2.camel@sealevel.com>
References: <5dd9f8b0c1dc154c73fb883cb948768ae68d1ccb.camel@sealevel.com>
	 <a9519d301f542c921260b11b4576cd68cc929b52.camel@sealevel.com>
	 <937e10172eaf46cbb6e355666e15ba33344f2c51.camel@sealevel.com>
	 <74b591e8-c8b1-7a9b-e2ea-c375f3d712c2@linux.intel.com>
In-Reply-To: <74b591e8-c8b1-7a9b-e2ea-c375f3d712c2@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR05MB8426:EE_|PH0PR05MB7734:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 6Pq96WCbENDmJKQMES3jHtVEbPLPeAckLECDlZYGD47miF9oToz6rTN20QRLIxwPcoAoPt1p9zzlc/uAcy3JV3ETXruDf24l01R2Bq29zA+c05uNRVIIkcq6OYINqAmrpnoylsj44Zhxyf1/LVdTqiJQ14Y5GigWXVDlqa7M+ONVOCxoO3XKfK8VfawCY3+cKXUuvLJgNhp9q2Ujq+xZZhonWPU06jn+VuE79+i/dT71Sz/hj3dBCSRrPrwe5nkm+oIw/hlQfHq/HidId3FaKmrgGiJ7e12FSJ5PyWOk+DrjaNHuxj+uvtNDjyOI8Ei6UWVtM+g8rLifripFQO1LkExEVGr/XyT/c/KmoX/JD5mWHuau/nESwwjxpfeTcIwre11ifKK2ThY7dEZaDFayrm8dFLENI9pFZmiffpQ6qYRJOfKO8isi6iUNUwUFCn5S8Vvz6VQIMkiTcECtgYHMbRYRB6jpYwRkJSIMRZoLESJxcGQF5zy2oGNOcPLRSj0RFuvVUaVgo4HgrLJdmtRPjlKfEPC3lggShe5DMkmPUCvzqmb6MCRKu7D1/hBrVI+aETR6xKYg/U5a4xbWQROi9nfhI3oVbyJwel317jtmqk0iXYXB0DEyCJWntLjRdQ93UBNYB/kVkpJOfUfGuxDWV7+yP6pn2efsWcq/FJPoE9k=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR05MB8426.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?d0RmQitacFBBZkc0OFM3T3BZOW9Cb0t3WWgwVk9VUENObTlXc3E0b09iVUVS?=
 =?utf-8?B?ZFM4Q3pLSS9sUTlvdEx2MkUxMWhIQmtwL3Y4STdHWnFkY3UyOFMwaDJCUHE2?=
 =?utf-8?B?M3NMOWxGV1lXTWdld0Vickd1SEY4UER1NkFvNEgzS295VTNXNzYrcG5qTVV5?=
 =?utf-8?B?elZJSVM4SzBTa3JzZkZZSk1CZ01QMDYyWldEMW5ISjJ6MUR3VisyUEpsRFIv?=
 =?utf-8?B?Z21oakZzWGJYQjN0dzZrV0VRT2dqUitSaXRsYWJwbDA3Z0wyVC9aRkdvRGh2?=
 =?utf-8?B?bG1WVVRWZFVOMy9wNC96b3ZFQ0w2aHZ6VHlTMnEvdllSbmZRVjRBV0xDTmFY?=
 =?utf-8?B?ZEJ0RHZ4N2hpM3NMdzJGcFZwRUs2M2NNRi8yWlZSYWZsQTBHdDMxb3A0UDRZ?=
 =?utf-8?B?RCtkbTRwZTh6akFJUjRVVDcraHYwWU10ZjdBVVBQWkV3UmwyWjZxNW9qdmRS?=
 =?utf-8?B?ZFQxMXZwaFAwUUZKNmpLbW9iRTF4T0lCZkc2WXlBRG93YXhFZ2JlYkthSG5u?=
 =?utf-8?B?c0tNdG5LTXQ2YWsrWTN2VzFVT1hpRi9SMWx0ZkZjTmYrZVNrQ2ozM1d5dkps?=
 =?utf-8?B?bzRJWGI1b0tWQ1d0TElEVW1lMXlNdmN2LzJOUW9QWVUxbHQySDlLRHJ0SlJj?=
 =?utf-8?B?eENCTW84TlF6bmxScitnYUQvNTZCMkZHb29RMU5DNTg4cy9UUzliM0ZkS0Rk?=
 =?utf-8?B?aU0rWitRMWtlL0VIS2psMG9JMTNpSTJKa0hhUWtiQ0lhWlB0TTNtQm1Yb2Ix?=
 =?utf-8?B?aU1sQjJUdTBTQzhXdHBDeUNKczREMW11SVM0ZzZyVXhzUGltYStienNVdVE0?=
 =?utf-8?B?TmZvYkt3N0dVYVZrK1ZQUmFvcmdJQ1hrL1BKd1Nob1h5Mk9wSU1mbGU0UXJH?=
 =?utf-8?B?V2s4MFd4dTlkUzBmZk54TFZGUjE1M2J1b05ZWHcxR0tXWTlUbVF6ZHZXRFRG?=
 =?utf-8?B?ejcxUmhjdSt1TFROUTIxdWFiSEpSZUZPRElkSXFxZ1YzeTVoS0tJTDRrN3BW?=
 =?utf-8?B?QTNJRE9HZFRnT0tkM2h1S3RJNFJQdmxNRng1U3BLcTZLN1pJWlNxU0ZMNWtF?=
 =?utf-8?B?QTZVSXF1SlN2QkZrTFl6eFptYWtUSTEzbEpwZlVuZTRvV2hWN0dLMTlBL3RL?=
 =?utf-8?B?em0xKytUTkF1eHBodjlwRk5QQTZzSElDbVlUaUxHR09oRU56a2NVTzlST29R?=
 =?utf-8?B?MGYyNUN1UmpkMEJheHZhbllOU3ZZT0FXcWRqQ095RXNQbHYwcmVyQ0xpWmlF?=
 =?utf-8?B?VklpTXpvWjlTRlQvaFdpTnNLTFQ5eVZvSWFGbVlZOTBkU3BxTDhPSkN3ZWt2?=
 =?utf-8?B?ekg1Tm9reGh6NUZoVzFZaWdCOXdrY0tYUEpxT1JiRG9Xb05sT052cHhqK1ZR?=
 =?utf-8?B?a2xRSmlvemprSGRHRFFKR21GRmRpeXdFUHJYU0U2L2lUNW1TdVN2akpyeHJI?=
 =?utf-8?B?YnFSVTlWUnNnMGdxbjJDZVZiTkNIMUhYUWVLUE1YcVRleDlJTkhJa1piZEdq?=
 =?utf-8?B?czZkOWFrbngzVmlLSjNlQ0xJRlVpZ3N2QkRPVW1yUm9QNU5LOTlHemQ4cGRZ?=
 =?utf-8?B?TmtIQy8zbmFpSmJUM1NubVpic1kvNEllZUtaeTRxUFNQUGVGZnNHWVlONDJR?=
 =?utf-8?B?akYxdkFTSThmT2o5MzdGeW9QTEI1QTlJY0RTamlYVnp5dTBLS0l1LzdlZWQv?=
 =?utf-8?B?YW9lRjByTXJVQy9MMjFBNEIxOEoraW1mSGhjbk1jRHA3V29udUdnemJsL0h4?=
 =?utf-8?B?VDFaN1ZjUUVsRVhHUHpHUHp0dURqWjhYWGxqc09jUzNqY2VRM3p5cXVOTXMy?=
 =?utf-8?B?TlJzR3dZWjdpZmxxTlo2ekN0RXhHb1UzSEc5OGRUcTlCbnI2eFRndjZsRXVI?=
 =?utf-8?B?TXEyRHRLcUh4TVE4YkVXN1AvQzFIZFF1cm8rMEtEVFBDTjJwMXZNekdOWStj?=
 =?utf-8?B?RHVJcVNZTEV4dnUzaytFZFpRQklseFBOTWxpZXplOVZIRDdRRWlPc0FOMVFx?=
 =?utf-8?B?QTFIYzRDWW5JaEJxMlBOcXFzUGFEeTBZUUhEdmV3UVNxdXhSOW9ObjVnODNo?=
 =?utf-8?B?eTljbGxscU9iVkQ2V2hTOVZFYVA4bGZxUm5qcEl5ZnovYzA5U3RiWCtMejJn?=
 =?utf-8?B?Wm9CcllGdWltRjdaU0cvK0ZPSVhHbHU2SVNTd1ZRUlNES3R4V3lockFHQm1s?=
 =?utf-8?B?ZUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7B0EB49DE9EA3F4F835C62730F88A445@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: sealevel.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR05MB8426.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cbe7e33-09f7-4a20-56b7-08dc580a5dc6
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2024 20:27:52.5341
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e34c5615-b4e3-481c-abc8-602581f2e735
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bDtz12SLiyMna0jBiDe7AMWW50vVcr0reusB7FjwJVzpP6pMgVhRooudJhcIOdCWVnAD7gSKDBz+imC4tkGcpB6fGiNFLzW72rmxBRz0PDk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR05MB7734

T24gTW9uLCAyMDI0LTA0LTA4IGF0IDE5OjQ4ICswMzAwLCBJbHBvIErDpHJ2aW5lbiB3cm90ZToN
Cj4gW1NvbWUgcGVvcGxlIHdobyByZWNlaXZlZCB0aGlzIG1lc3NhZ2UgZG9uJ3Qgb2Z0ZW4gZ2V0
IGVtYWlsIGZyb20gaWxwby5qYXJ2aW5lbkBsaW51eC5pbnRlbC5jb20uIExlYXJuIHdoeSB0aGlz
IGlzIGltcG9ydGFudCBhdCBodHRwczovL2FrYS5tcy9MZWFybkFib3V0U2VuZGVySWRlbnRpZmlj
YXRpb24gXQ0KPiANCj4g4pqgQ2F1dGlvbjogRXh0ZXJuYWwgZW1haWwuIEV4ZXJjaXNlIGV4dHJl
bWUgY2F1dGlvbiB3aXRoIGxpbmtzIG9yIGF0dGFjaG1lbnRzLuKaoA0KPiANCj4gDQo+IE9uIE1v
biwgOCBBcHIgMjAyNCwgTWF0dGhldyBIb3dlbGwgd3JvdGU6DQo+IA0KPiA+IE9uIFdlZCwgMjAy
NC0wMi0yMSBhdCAxNjoxNiAtMDUwMCwgTWF0dGhldyBIb3dlbGwgd3JvdGU6DQo+ID4gPiBBbGxv
d3MgdGhlIHVzZSBvZiB0aGUgRU40ODUgaGFyZHdhcmUgcGluIGJ5IHByZXNlcnZpbmcgdGhlIHZh
bHVlIG9mDQo+ID4gPiBGQ1RSWzVdIGluIHBjaV94cjE3djM1eF9zZXR1cCgpLg0KPiA+ID4gDQo+
ID4gPiBQZXIgdGhlIFhSMTdWMzVYIGRhdGFzaGVldCwgdGhlIEVONDg1IGhhcmR3YXJlIHBpbiB3
b3JrcyBieSBzZXR0aW5nDQo+ID4gPiBGQ1RSWzVdIHdoZW4gdGhlIHBpbiBpcyBhY3RpdmUuIHBj
aV94cjE3djM1eF9zZXR1cCgpIHByZXZlbnRlZCB0aGUgdXNlDQo+ID4gPiBvZiBFTjQ4NSBiZWNh
dXNlIGl0IG92ZXJ3cm90ZSB0aGUgRkNUUiByZWdpc3Rlci4NCj4gPiA+IA0KPiA+ID4gU2lnbmVk
LW9mZi1ieTogTWF0dGhldyBIb3dlbGwgPG1hdHRoZXcuaG93ZWxsQHNlYWxldmVsLmNvbT4NCj4g
PiA+IC0tLQ0KPiA+ID4gVjEgLT4gVjINCj4gPiA+IEZpeGVkIHdvcmR3cmFwIGluIGRpZmYNCj4g
PiA+IA0KPiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdHR5L3NlcmlhbC84MjUwLzgyNTBfZXhh
ci5jIGIvZHJpdmVycy90dHkvc2VyaWFsLzgyNTAvODI1MF9leGFyLmMNCj4gPiA+IGluZGV4IDIz
MzY2Zjg2OC4uOTc3MTE2MDZmIDEwMDY0NA0KPiA+ID4gLS0tIGEvZHJpdmVycy90dHkvc2VyaWFs
LzgyNTAvODI1MF9leGFyLmMNCj4gPiA+ICsrKyBiL2RyaXZlcnMvdHR5L3NlcmlhbC84MjUwLzgy
NTBfZXhhci5jDQo+ID4gPiBAQCAtNTk2LDYgKzU5Niw3IEBAIHBjaV94cjE3djM1eF9zZXR1cChz
dHJ1Y3QgZXhhcjgyNTAgKnByaXYsIHN0cnVjdCBwY2lfZGV2ICpwY2lkZXYsDQo+ID4gPiAgICAg
dW5zaWduZWQgaW50IGJhdWQgPSA3ODEyNTAwOw0KPiA+ID4gICAgIHU4IF9faW9tZW0gKnA7DQo+
ID4gPiAgICAgaW50IHJldDsNCj4gPiA+ICsgICB1OCBlbjQ4NW1hc2s7DQo+ID4gPiANCj4gPiA+
ICAgICBwb3J0LT5wb3J0LnVhcnRjbGsgPSBiYXVkICogMTY7DQo+ID4gPiAgICAgcG9ydC0+cG9y
dC5yczQ4NV9jb25maWcgPSBwbGF0Zm9ybS0+cnM0ODVfY29uZmlnOw0KPiA+ID4gQEAgLTYxOCw3
ICs2MTksOCBAQCBwY2lfeHIxN3YzNXhfc2V0dXAoc3RydWN0IGV4YXI4MjUwICpwcml2LCBzdHJ1
Y3QgcGNpX2RldiAqcGNpZGV2LA0KPiA+ID4gICAgIHAgPSBwb3J0LT5wb3J0Lm1lbWJhc2U7DQo+
ID4gPiANCj4gPiA+ICAgICB3cml0ZWIoMHgwMCwgcCArIFVBUlRfRVhBUl84WE1PREUpOw0KPiA+
ID4gLSAgIHdyaXRlYihVQVJUX0ZDVFJfRVhBUl9UUkdELCBwICsgVUFSVF9FWEFSX0ZDVFIpOw0K
PiA+ID4gKyAgIGVuNDg1bWFzayA9IHJlYWRiKHAgKyBVQVJUX0VYQVJfRkNUUikgJiBVQVJUX0ZD
VFJfRVhBUl80ODU7DQo+ID4gPiArICAgd3JpdGViKFVBUlRfRkNUUl9FWEFSX1RSR0QgfCBlbjQ4
NW1hc2ssIHAgKyBVQVJUX0VYQVJfRkNUUik7DQo+ID4gPiAgICAgd3JpdGViKDEyOCwgcCArIFVB
UlRfRVhBUl9UWFRSRyk7DQo+ID4gPiAgICAgd3JpdGViKDEyOCwgcCArIFVBUlRfRVhBUl9SWFRS
Ryk7DQo+IA0KPiBXaHkgeW91IG5lZWQgdG8gcmVhZCByczQ4NSBzdGF0ZSBmcm9tIHRoZSByZWdp
c3Rlcj8gSXQgc2hvdWxkIGJlIGF2YWlsYWJsZQ0KPiBpbiAtPnJzNDg1LmZsYWdzICYgU0VSX1JT
NDg1X0VOQUJMRUQuDQo+IA0KDQpQbGVhc2UgY29ycmVjdCBtZSBpZiBJIGFtIHdyb25nLCBidXQg
bXkgdW5kZXJzdGFuZGluZyBpcyB0aGF0DQpTRVJfUlM0ODVfRU5BQkxFRCBpcyBzZXQgZnJvbSB1
c2Vyc3BhY2UgdXNpbmcgdGhlIFRJT0NSUzQ4NSBJT0NUTC4gDQoNCkhvd2V2ZXIsIHRoaXMgaXMg
bm90IHRoZSBvbmx5IHdheSB0aGF0IHRoZSBGQ1RSIHJlZ2lzdGVyIGNhbiBiZSBjaGFuZ2VkLg0K
SW4gcGFydGljdWxhciwgcGVyIFhSMTdWMzVYIGRhdGFzaGVldCwgdGhlIEVONDg1IHBpbiBpcyBz
YW1wbGVkIG9uDQpwb3dlci1vbiBhbmQgdHJhbnNmZXJzIHRoZSBsb2dpYyBzdGF0ZSB0byBGQ1RS
WzVdLiBPdXIgY2FyZCB0YWtlcw0KYWR2YW50YWdlIG9mIHRoaXMgdG8gYWxsb3cgdXNlcnMgdG8g
Y29uZmlndXJlIFJTNDg1IGluIHNjZW5hcmlvcyB3aGVyZQ0KdGhleSBjYW5ub3QsIG9yIGRvIG5v
dCB3YW50IHRvLCBtb2RpZnkgdGhlaXIgc29mdHdhcmUgdG8gc2V0DQpTRVJfUlM0ODVfRU5BQkxF
RC4NCg0KSG93ZXZlciwgdGhpcyBmdW5jdGlvbmFsaXR5IG9mIHRoZSBVQVJUIGRvZXMgbm90IGN1
cnJlbnRseSB3b3JrIHdpdGgNCnRoaXMgZHJpdmVyIGJlY2F1c2UgdGhlIGVudGlyZSBGQ1RSIHJl
Z2lzdGVyIGlzIGJlaW5nIG92ZXJ3cml0dGVuLA0KdGhlcmVieSBlcmFzaW5nIHdoYXRldmVyIHZh
bHVlIHdhcyB3cml0dGVuIHRvIEZDVFJbNV0gb24gVUFSVCBwb3dlci11cC4NCg0KVGhlIGRyaXZl
ciBjYW5ub3Qga25vdyB3aGV0aGVyIEZDVFJbNV0gd2FzIHNldCBvbiBwb3dlci11cCB3aXRob3V0
DQpyZWFkaW5nIHRoZSBGQ1RSLCB0aGVyZWZvcmUgaXQgbXVzdCBiZSByZWFkLg0KDQo+IHBjaV9m
YXN0Y29tMzM1X3NldHVwKCkgc2VlbXMgdG8gaGF2ZSB0aGUgc2FtZSBwcm9ibGVtPyBUaGF0IHNt
YWxsIHBhcnQNCj4gc2VlbXMgdG8gYmUgY29tbW9uIGNvZGUgYW55d2F5IHdoaWNoIHNob3VsZCBi
ZSBtb3ZlZCBpbnRvIGhlbHBlciwgb25seSB0aGUNCj4gdHJpZ2dlciB0aHJlc2hvbGQgc2VlbXMg
dG8gZGlmZmVyIHdoaWNoIGNhbiBiZSBnaXZlbiBpbiBhIHBhcmFtZXRlci4NCj4gDQoNClRlY2hu
aWNhbGx5LCB5ZXMgbWl0IGhhcyB0aGUgc2FtZSBwcm9ibGVtLCBidXQgSSBhbSBub3Qgc3VyZSBp
dCBpcyBhbg0KYWN0dWFsIGlzc3VlIGFuZCBhbSBoZXNpdGFudCBtYWtlIHRoZSBzdWdnZXN0ZWQg
Y2hhbmdlcyBmb3IgdGhlDQpmb2xsb3dpbmcgcmVhc29uczoNCg0KDQoxKSBUaGUgZmFzdGNvbSBj
YXJkIG1heSBkZXBlbmQgb24gdGhlIGJlaGF2aW91ciB3b3JraW5nIGFzLWlzLg0KMikgSSBvbmx5
IGhhdmUgU2VhbGV2ZWwgJiByZWZlcmVuY2UgRXhhciBoYXJkd2FyZSB0byB0ZXN0LCBub3QgRmFz
dGNvbSwNCnNvIEkgaGF2ZSBubyB3YXkgdG8gdGVzdCBpZiB0aGUgY2hhbmdlcyBuZWdhdGl2ZWx5
IGltcGFjdCBmYXN0Y29tDQozKSBGaW5hbGx5LCB3aGlsZSBJIGFtIG5vdCBmYW1pbGFyIHdpdGgg
dGhlIGZhc3Rjb20gMzM1LCBpdCBkb2Vzbid0IGhhdmUNCmFueSBkaXAtc3dpdGNoZXMgb3IganVt
cGVycywgd2hpY2ggbGVhZHMgbWUgdG8gYmVsaWV2ZSBpdCBkb2Vzbid0IGhhdmUgYQ0Kd2F5IGZv
ciB1c2VycyB0byB1dGlsaXplIHRoZSBFTjQ4NSBwaW4uIElmIHRoaXMgaXMgdGhlIGNhc2UsIHRo
ZW4gdGhlcmUNCmlzIG5vIGVuZC11c2VyIGJlbmVmaXQgdG8gJ2ZpeGluZycgdGhpcyBpbiBwY2lf
ZmFzdGNvbTMzNV9zZXR1cCgpLg0KDQpJZiBzb21lb25lIHdpdGggYSBmYXN0Y29tIDMzNSBjYXJk
IGlzIHdpbGxpbmcgdG8gdGVzdCB0aGVuIEkgY2FuIHRha2UgYQ0Kc3RhYiBhdCB0aGUgc3VnZ2Vz
dGVkIGNoYW5nZSwgYnV0IGF0IHRoZSBtb21lbnQgSSBzZWUgYXQgbGVhc3Qgc29tZQ0KJ3Jpc2sn
IGluIG1ha2luZyB0aGlzIGNoYW5nZSwgYnV0IG5vICdyZXdhcmQnIGZvciBkb2luZyBzby4NCg0K
LS0NCk1hdHRoZXcgSC4NCg0KPiAtLQ0KPiAgaS4NCj4gDQo+ID4gSnVzdCB3YW50ZWQgdG8gZm9s
bG93LXVwIG9uIHRoaXMgdG8gc2VlIGlmIGFueW9uZSBoYXMgaGFkIGEgdGltZSB0bw0KPiA+IHJl
dmlldyB0aGUgYWJvdmUgc3VibWlzc2lvbj8gUGxlYXNlIGxldCBtZSBrbm93IGlmIHRoZXJlIGFy
ZSBhbnkgaXNzdWVzDQo+ID4gLyBhbnl0aGluZyBJIG5lZWQgdG8gZG8uDQo+IA0KDQo=

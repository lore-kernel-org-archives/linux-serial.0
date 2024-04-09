Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11022010.outbound.protection.outlook.com [52.101.51.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37455384
	for <linux-serial@vger.kernel.org>; Tue,  9 Apr 2024 12:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.51.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712666008; cv=fail; b=qF/H/utOHQqB74sZwN7AmZegbr3nrrFc3URDzUyS6Rpv4loNNPXpdx+HeqFd11adgm//3vRk+0yGWiYGi2Jg8uMFkAjakPGfwWctMDePc/beADNxl8sM+yTQon/Su6VJpycMvgY2wFInd4ReyDeuUOhMfNeMl8MG6YFXAdXd7pw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712666008; c=relaxed/simple;
	bh=/PBUGBAgLIfM0JATJT7MO48blMggdKSeVd3ZFSe+BfM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ByoIRrHbI4JawTcVddhxmvZ7lmIznh1O0vay44s1XSkBOnSNR5Usl39gpZ4zpLjLO6lh/HGIAgZJ8C2rpzRkeAO3PUDAJ3FaV7ZSebfkyYFBUVxWWmwT54KEVxJxQViXuwRvUGzX5MwTPytYwaprJ9XywuOL7SiftVy2V/uA79g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sealevel.com; spf=pass smtp.mailfrom=sealevel.com; dkim=pass (2048-bit key) header.d=sealevel.com header.i=@sealevel.com header.b=OCrR+TeU; arc=fail smtp.client-ip=52.101.51.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sealevel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sealevel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sealevel.com header.i=@sealevel.com header.b="OCrR+TeU"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X7zWcUWsCsMgHCfaVNfJuvFvXLto4MWJiLgSKNJziEKahk1cFRD7iGrr5B5lbOXs8YVSrlw+U2sHyn8slSY+YfRFCBc/Sx1bVUXbG2/eJQLJ7/bsdqRYajUTdyNCcz6fueZke24uASgtS6Y27p3Oi2K9JmL9pPdSvOJJ9QSru7e+SMp8ui+m1NDQUTq/ts5TMkWM3rviRGN0+V1LcKTGqDLQUbYobJw4X+2ymWW2zLRODsz6bDbgiTKvYb/7nbCs79xQIfy7GUCQcGQLSEsvJwKEXJBFmxqo5LGNYPU/HZFc1MLjIeHc5KRD8ujEKB47dXtJM2mTQtq8dyFb876Ugw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/PBUGBAgLIfM0JATJT7MO48blMggdKSeVd3ZFSe+BfM=;
 b=UqVsPOz5vHoP5U20mSdddE00ParIBCQrYSzVz+r3AcMA82ctnmtIDBY+giCwhjVh8KLMEkOWAwqJVA0Gjb67CXLQzNr2ZqdR9qIac0U56h5UgQC+e8v1ak3iHe9OFHutpc7FjblrCSVsRf6boQT1C9IEhRY6xTOQ9ftli0zIEHQKYCZ8wBqhz/EyvjVld2Q+pYKwzWZO8pw2H4PZbUBl7hQFau/7XcFOyXwbt0cDj7IqnMv/sTxU/0Xd77lZ3v1nrQvjMAtmsIcE82UxV09EEZRwmxWV7CukEzevl2Gz1zEGkXVEekgN7H7sYBKZhlQutUAhmBvskj+TXLI3UF++xQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sealevel.com; dmarc=pass action=none header.from=sealevel.com;
 dkim=pass header.d=sealevel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sealevel.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/PBUGBAgLIfM0JATJT7MO48blMggdKSeVd3ZFSe+BfM=;
 b=OCrR+TeUyAjGCG+IGnmBRz48LRMrQTHHj5GoEAiR/TqW2tgvTQ8vjoIRF0rwrEvs4bR434D6+SSSKt/ujGRxd1bWfSpG55sdoyNciSnggcSj33LkHcKE4vDXGS2xRbs7/MuzBBWxm4m0hMW9As0eTNHHfow/SiUCUumkVtXefpwfJASwGczLug/cU+YOL2R60nMHaYBOgWS3fHMVWQ2s/1IbkkqlqYNnsw5mztzrd2KkPIRLfoNFr4kSG4cEsBighVb/uS6Eyp+NjQ3UJJviK1lhou1N0DvpQcVeAKYfV6/JR8fdFDPR4wJV5C1X8BlthSz//Tlfwki1aqcRGTYHoQ==
Received: from CO1PR05MB8426.namprd05.prod.outlook.com (2603:10b6:303:e5::11)
 by BY3PR05MB8052.namprd05.prod.outlook.com (2603:10b6:a03:36f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Tue, 9 Apr
 2024 12:33:22 +0000
Received: from CO1PR05MB8426.namprd05.prod.outlook.com
 ([fe80::6231:d3c9:8cd3:4169]) by CO1PR05MB8426.namprd05.prod.outlook.com
 ([fe80::6231:d3c9:8cd3:4169%7]) with mapi id 15.20.7409.049; Tue, 9 Apr 2024
 12:33:22 +0000
From: Matthew Howell <matthew.howell@sealevel.com>
To: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
	"5dd9f8b0c1dc154c73fb883cb948768ae68d1ccb.camel@sealevel.com"
	<5dd9f8b0c1dc154c73fb883cb948768ae68d1ccb.camel@sealevel.com>, Darren Beeson
	<darren.beeson@sealevel.com>, Jeff Baldwin <jeff.baldwin@sealevel.com>, Ryan
 Wenglarz <ryan.wenglarz@sealevel.com>
Subject: Re: [PATCH V2] serial: exar: Preserve FCTR[5] bit in
 pci_xr17v35x_setup()
Thread-Topic: [PATCH V2] serial: exar: Preserve FCTR[5] bit in
 pci_xr17v35x_setup()
Thread-Index: AQHaZQtGjPOmrNLBp0ShUL1okzQC67FeooGAgAAdLYCAAWpwAA==
Date: Tue, 9 Apr 2024 12:33:21 +0000
Message-ID: <fdd4810a4276b67db9da41cb9dd0c436b02d6b68.camel@sealevel.com>
References: <5dd9f8b0c1dc154c73fb883cb948768ae68d1ccb.camel@sealevel.com>
	 <a9519d301f542c921260b11b4576cd68cc929b52.camel@sealevel.com>
	 <937e10172eaf46cbb6e355666e15ba33344f2c51.camel@sealevel.com>
	 <2024040856-repaint-botanist-3503@gregkh>
In-Reply-To: <2024040856-repaint-botanist-3503@gregkh>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR05MB8426:EE_|BY3PR05MB8052:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 9bHaDvnfyhAh951RRSRiu/mSgLuWAmIWYtOa/Y+HP18yZucSlEblAKuytVOolfPCMLbvA+hcD6xBln5OnE4Kajxo1o51kAoWj6QuwSLCbeauR0QUR7FGo4JE7+mA/ZvSILRM9DcYv2Wu7u9oFdU4K8AuAd9E1xiNRJCcpDxfJhoWSfpyZkKO3O2TrSVbkY2Yp6dQNl9k4SfisK4Izen6A3u2P+B1oHPyzUa3zxrYCfJ9bXyeUcz/ERuugRth7/iCWkrBips0fqsGv6aJjgOLWJU/ISRt4fasdSMcOnFiiVtehJX/V0koLsrX2/nvnGsX9/qxUWcZKfUBtgYZwscsF1ARnawppECXjzIPi6kjQJDKPFEF2GTk+zImtPE0M7a4lOMCHdYiEdZ+6a0JaofbIebbEC+WVpmO97exEu8M9U4LNpoVZYJ+/UCnCp0PKP+GJ5ApPTPIdy2aK1BWokymF+8nU8X8pYLAU8D6NfAtR6fMJw3wnvjEVC+sFUG6uSVGj3WQ/eUEA7lcsvn/vE7G7S0DDmwiloIosAdaMPRxZcFtFl49jhRwWay235Yv6Asj9lZw6zJP2FHo4Iz3O3ob7aIaWiALXQd4iBEOQwXl6qsVvIjyWmrf8dkOCW89OQ0NSkisUDxFxCg810k3HR/qUHQx3+0Mx4MVFjey7M+iWpw=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR05MB8426.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VnMxUnZxNy8rVHFlUGtnNTlyY1h0NERUbmhmWlp1alZlblhmSW5wRExRNXN6?=
 =?utf-8?B?c1F5SEtqdXRFZHQ3R2x2M01MYUVhY21NQVloeE04WG9GZjBBMTlJdmZJR1Y0?=
 =?utf-8?B?L3lFTm5jZTJ6LzlIbUZweEJydDBYejRUcEpZdVZVR0tqTnh6RVpLTEtRUmR2?=
 =?utf-8?B?Mm5YdDZmTm4zaS9CNlJVZTJOaDFBcnA0RVdJUUs0eE9kVFoweUNDWEhNWnFG?=
 =?utf-8?B?Q3ByRXVGcUtJbTlLWEtBVDE1NS85ZEk5eS9yQ29ZNEdqTUlPZ2IrUDJFdE1B?=
 =?utf-8?B?S1FFL1dpejhCYUlwZDhOTkNOSWk3Qis0SUthTlJuUGtnZXdWeEdqTXFvdlE1?=
 =?utf-8?B?aDZHM3AyaFJURHMrMGo0L3lEck1UaHhuL0pUUjU3UG9ndm5iSSttdWdJQWMy?=
 =?utf-8?B?ZWRtZFdxeEg2UkpML0xPbGoyd1NpNkxJUzV6VmhDR0w3Nkg1Sll5NVYrbDJQ?=
 =?utf-8?B?aHgvaFduZHd3dS9xSjBIZWFSbmFRZklKTWhKdzJqYUtxTnN1S1dlekRtb3By?=
 =?utf-8?B?SXpDVjNqeUhFMEN4aXc1SUxRbDNXbGxLTTFQbHdSSnBwcDhQN3E2MGlVbyt2?=
 =?utf-8?B?YkozNVJpVFVQUFJYOFlyOGFGWlZQY0NtOWZuUmJoSzZrclhQZkVxeUhLMlZR?=
 =?utf-8?B?M041OTRQa3NLOVpUMVp0a0FhN0k5SUpORlgvVkdYSnhHakxwbU9xaGgvUDRV?=
 =?utf-8?B?cFFWdkVqOGlmcDNHeEZkR0srS1RtalZoOWw0RW1NdVlqYk02cWRvTTdxVkRJ?=
 =?utf-8?B?YnpBZmw5NTNOeFZ0L0FaMDRCSVQyYW5paGtMR0pSWkFmS2Y4ZE5lVGJpS0Iw?=
 =?utf-8?B?RGdmTEdiVmkzejFTM2VGYW15QWp3WEhkYVl3UnNIcTJ3YzVtMHdwRndBbmd2?=
 =?utf-8?B?RnFLNVE2WUhBYzhSZmtTZlFKdXVqdkFPRlFrS25rSC9IbU9vSk9aSTBUK3VR?=
 =?utf-8?B?V3lDaU5NWXdxOHhraC8zUzBSRTI5ZGF4RWcyRTkwRzlSYzUvYXQwTUt2eiti?=
 =?utf-8?B?YVh3VEM3M09NVk5OK3lzNnlXVTJOd2lOdUUxaUVWZ2RSeWxnSUxkYkxwN2Vw?=
 =?utf-8?B?Yk9CYU9PMmJ0NndVOUJDa2s2K2FQYS8wVE5xWTJPelBvTjJHNkRHell1VkJz?=
 =?utf-8?B?byswZ0ZDdWNtMmYxSlhkRVJ3UHRDeWVEYmNoenFVVXljTjVxenVnM3JmbHBB?=
 =?utf-8?B?ZEROSG0zUHJNaW1pa3V1TFBOTWJwbzVXZjV5NlZDQTc0WXRrTmMreHdQbFZt?=
 =?utf-8?B?VjMwNTluY0pDWXdMNDZxYWJlbjZZMkFIVUdvR1VxNk9yMjhucWd0ejZQclZq?=
 =?utf-8?B?Q1diV1pKbUQ4MzhJM3ovMWNGOVZZQVFWMGZnalJyZ2ZQM2pJT3ZpT1lyeWsy?=
 =?utf-8?B?R1FjMUlFODNobFdRWExvM082TXRSa2gwYlhaS0huNW41N1F6eU9VTTFVaTdk?=
 =?utf-8?B?b3FvYXBOejBNd01ZanF0Y1NPajlwMlpFeE00TmJ6OCsyenArSkRjUXJNVGE2?=
 =?utf-8?B?RmxJREZSUmtISVgrM0M5WXAvVVRxeEpYakovRlkzc3dRdFBUNVJjclZUMTQ4?=
 =?utf-8?B?cDdFTFI4N3hFVzQ1OGFoNnBvOFgwVkt2VEg2eGZheCt3d1YyYzg5N3liTG5G?=
 =?utf-8?B?MUF6UXZwVW5xcWZpQTh1NnRJWWE2cDM3WWtvMTBIL2pubUZJc3d4VGpIRENN?=
 =?utf-8?B?NTYwcGZOK1lJa0ZlU2xnYndGZUx6ZTdpZW43cVlOL0ZGeElkOVRWNTFmUFRq?=
 =?utf-8?B?NjIwdlcvd0FYYW9DZ1AzNldQd1JMbHJtVVdhQXpDWjdMc1M3UW4rYzJBZXJa?=
 =?utf-8?B?RlVIWVFKWGloSzVWeXhhMUc0OGoxWURNMExHUTQ0cWtEVy94aUtXejluK3VM?=
 =?utf-8?B?djlBd25BZkhMRzRPbWt5TFFVeGRTd3VwbStXT211TFdUaXVhZTBUV0dBTEN2?=
 =?utf-8?B?ZzJZdURZN1ZLWTB6NVBERnhLUVBlUzh0OXBDc0s0QkVzekptRWQzd0RWM3JB?=
 =?utf-8?B?eHJrRHVHWDNOTEswQmhCcThzTkozcGJYc1ROMjM1SmYrcUdHK3RHamUzbW1S?=
 =?utf-8?B?TlNYa0hvVkxBQ2psRGxBYVI0b0VDak5rS2dkV1NKRXFJaExwdU1DS21VdXBz?=
 =?utf-8?B?VS96dmwwR3hjM25qZTNKLzFQRUlEUkZMUnpoMHZaeUZ4Z2JiVU51WGp1Y2pE?=
 =?utf-8?B?VHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6CB5CF23F8BEE247B408B930475118CC@namprd05.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: eb567743-a649-4cfc-c5b0-08dc58913e73
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2024 12:33:22.0523
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e34c5615-b4e3-481c-abc8-602581f2e735
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VISCmn6227p+JiPhpPre5V7l6fk1p2bnv9ztHa/ZPzjlLqVkTo3Lic0P4ag36NlkWHkbnB9ndeN/QKjwzoYZIt/GB+99aKMOadtiSS3k1o8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY3PR05MB8052

T24gTW9uLCAyMDI0LTA0LTA4IGF0IDE2OjU2ICswMjAwLCBncmVna2hAbGludXhmb3VuZGF0aW9u
Lm9yZyB3cm90ZToNCj4gT24gTW9uLCBBcHIgMDgsIDIwMjQgYXQgMDE6MTE6NDJQTSArMDAwMCwg
TWF0dGhldyBIb3dlbGwgd3JvdGU6DQo+ID4gT24gV2VkLCAyMDI0LTAyLTIxIGF0IDE2OjE2IC0w
NTAwLCBNYXR0aGV3IEhvd2VsbCB3cm90ZToNCj4gPiA+IEFsbG93cyB0aGUgdXNlIG9mIHRoZSBF
TjQ4NSBoYXJkd2FyZSBwaW4gYnkgcHJlc2VydmluZyB0aGUgdmFsdWUgb2YNCj4gPiA+IEZDVFJb
NV0gaW4gcGNpX3hyMTd2MzV4X3NldHVwKCkuDQo+ID4gPiANCj4gPiA+IFBlciB0aGUgWFIxN1Yz
NVggZGF0YXNoZWV0LCB0aGUgRU40ODUgaGFyZHdhcmUgcGluIHdvcmtzIGJ5IHNldHRpbmcNCj4g
PiA+IEZDVFJbNV0gd2hlbiB0aGUgcGluIGlzIGFjdGl2ZS4gcGNpX3hyMTd2MzV4X3NldHVwKCkg
cHJldmVudGVkIHRoZSB1c2UNCj4gPiA+IG9mIEVONDg1IGJlY2F1c2UgaXQgb3Zlcndyb3RlIHRo
ZSBGQ1RSIHJlZ2lzdGVyLg0KPiA+ID4gDQo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBNYXR0aGV3IEhv
d2VsbCA8bWF0dGhldy5ob3dlbGxAc2VhbGV2ZWwuY29tPg0KPiA+ID4gLS0tDQo+ID4gPiBWMSAt
PiBWMg0KPiA+ID4gRml4ZWQgd29yZHdyYXAgaW4gZGlmZg0KPiA+ID4gDQo+ID4gPiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy90dHkvc2VyaWFsLzgyNTAvODI1MF9leGFyLmMgYi9kcml2ZXJzL3R0eS9z
ZXJpYWwvODI1MC84MjUwX2V4YXIuYw0KPiA+ID4gaW5kZXggMjMzNjZmODY4Li45NzcxMTYwNmYg
MTAwNjQ0DQo+ID4gPiAtLS0gYS9kcml2ZXJzL3R0eS9zZXJpYWwvODI1MC84MjUwX2V4YXIuYw0K
PiA+ID4gKysrIGIvZHJpdmVycy90dHkvc2VyaWFsLzgyNTAvODI1MF9leGFyLmMNCj4gPiA+IEBA
IC01OTYsNiArNTk2LDcgQEAgcGNpX3hyMTd2MzV4X3NldHVwKHN0cnVjdCBleGFyODI1MCAqcHJp
diwgc3RydWN0IHBjaV9kZXYgKnBjaWRldiwNCj4gPiA+ICAgICB1bnNpZ25lZCBpbnQgYmF1ZCA9
IDc4MTI1MDA7DQo+ID4gPiAgICAgdTggX19pb21lbSAqcDsNCj4gPiA+ICAgICBpbnQgcmV0Ow0K
PiA+ID4gKyAgIHU4IGVuNDg1bWFzazsNCj4gPiA+IA0KPiA+ID4gICAgIHBvcnQtPnBvcnQudWFy
dGNsayA9IGJhdWQgKiAxNjsNCj4gPiA+ICAgICBwb3J0LT5wb3J0LnJzNDg1X2NvbmZpZyA9IHBs
YXRmb3JtLT5yczQ4NV9jb25maWc7DQo+ID4gPiBAQCAtNjE4LDcgKzYxOSw4IEBAIHBjaV94cjE3
djM1eF9zZXR1cChzdHJ1Y3QgZXhhcjgyNTAgKnByaXYsIHN0cnVjdCBwY2lfZGV2ICpwY2lkZXYs
DQo+ID4gPiAgICAgcCA9IHBvcnQtPnBvcnQubWVtYmFzZTsNCj4gPiA+IA0KPiA+ID4gICAgIHdy
aXRlYigweDAwLCBwICsgVUFSVF9FWEFSXzhYTU9ERSk7DQo+ID4gPiAtICAgd3JpdGViKFVBUlRf
RkNUUl9FWEFSX1RSR0QsIHAgKyBVQVJUX0VYQVJfRkNUUik7DQo+ID4gPiArICAgZW40ODVtYXNr
ID0gcmVhZGIocCArIFVBUlRfRVhBUl9GQ1RSKSAmIFVBUlRfRkNUUl9FWEFSXzQ4NTsNCj4gPiA+
ICsgICB3cml0ZWIoVUFSVF9GQ1RSX0VYQVJfVFJHRCB8IGVuNDg1bWFzaywgcCArIFVBUlRfRVhB
Ul9GQ1RSKTsNCj4gPiA+ICAgICB3cml0ZWIoMTI4LCBwICsgVUFSVF9FWEFSX1RYVFJHKTsNCj4g
PiA+ICAgICB3cml0ZWIoMTI4LCBwICsgVUFSVF9FWEFSX1JYVFJHKTsNCj4gPiA+IA0KPiA+ID4g
DQo+ID4gDQo+ID4gSGksDQo+ID4gDQo+ID4gSnVzdCB3YW50ZWQgdG8gZm9sbG93LXVwIG9uIHRo
aXMgdG8gc2VlIGlmIGFueW9uZSBoYXMgaGFkIGEgdGltZSB0bw0KPiA+IHJldmlldyB0aGUgYWJv
dmUgc3VibWlzc2lvbj8gUGxlYXNlIGxldCBtZSBrbm93IGlmIHRoZXJlIGFyZSBhbnkgaXNzdWVz
DQo+ID4gLyBhbnl0aGluZyBJIG5lZWQgdG8gZG8uDQo+IA0KPiBUaGVyZSB3YXMgcmV2aWV3IGNv
bW1lbnRzLCBkaWQgeW91IG5vdCBzZWUgdGhlbToNCj4gICAgICAgICBodHRwczovL2xvcmUua2Vy
bmVsLm9yZy9hbGwvWmRhQUk0dVoxQnl4MmNXc0BzdXJmYWNlYm9vay5sb2NhbGRvbWFpbi8NCg0K
Tm8sIEkgY2FuJ3QgZmluZCB0aGF0IGFueXdoZXJlIGluIG15IG1haWxib3gsIGp1bmsgZm9sZGVy
IG9yIG90aGVyd2lzZS4NCkkgd2lsbCBhZGRyZXNzIEFuZHkncyBjb21tZW50cyBpbiBoaXMgdGhy
ZWFkIHRob3VnaCBub3cgdGhhdCBJIGFtIGF3YXJlDQpvZiBpdC4NCg0KLS0NCk1hdHRoZXcgSC4N
Cg==

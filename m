Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05EE1C48BDF
	for <linux-serial@archiver.kernel.org>; Tue, 15 Jun 2021 16:06:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D99C561465
	for <linux-serial@archiver.kernel.org>; Tue, 15 Jun 2021 16:06:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbhFOQIl (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 15 Jun 2021 12:08:41 -0400
Received: from mail-eopbgr1310041.outbound.protection.outlook.com ([40.107.131.41]:4016
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229488AbhFOQIl (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 15 Jun 2021 12:08:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SC5LvnHU0fNe4iOXoNo5RTJ61VfE1b3cLsyg6WLUISo9+OJhQgJF/UVWksotJPrw566mv3OrHIdxUVJoCxVUMr0BgtYpHRQzAhu1KCqyOYantredAWmhitkS268q7R/jDdnhmEkr+baMIF0KWRtIsQXqQt6rr+fJVoOuCm1ezPzWgsqls9X/tv1xsZZ9TM/rviKLgsxO2CidM91I7FQOBFrWTOZWnbcLH2ehAI30WT3r9Et5OWOsXvnoyKuUm/jCpSUf8gBVor7IJHNlXwj3JNAUrqTlD+hu9dMK+ZyOz6s/QK0ZYKe6R7IQfycKu6Vy/wOp8dPPsmdZ1FUxN96+Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MF2Q1EHEV3K1hv41G6D+2cpIoYpFnpHNHF6diDU/Pfs=;
 b=Mj/xaq8l5LsHhgRD+zvC0XOppf0itVQIVZAfa0NDeQaAd5K+vpqe8B4mZJtcdfhrXZKeRLlRYiu/4y2tcMv9imNmLXsyH4Q678b/KtxhkZq2Y6xN+sLExbFSK6ycYFH4OYO69gIJBdidV8ffdI/SGsoERz0Y35qvfb0c9Y0pfqCVxXgiSYhdJIMa+RlTkEq8aZgQJAPu17ZeeFUJD3yYO0CqJqngQsf2jrgslBlErXNs7M5QLlyr5XVRwi0cAUf1sFlgOCZ/sLwgAwytistXNQfeNGuRTzIDZiXGSCXt2zSsMPAV3J60vyJU04XZk1ZncgsaYF+8XXj4YU9ZM2LbMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cortina-access.com; dmarc=pass action=none
 header.from=cortina-access.com; dkim=pass header.d=cortina-access.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CortinaAccess.onmicrosoft.com; s=selector2-CortinaAccess-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MF2Q1EHEV3K1hv41G6D+2cpIoYpFnpHNHF6diDU/Pfs=;
 b=HZ8wVhMstMwJkmHXNhf6EotKE9YkVSQ0ygXhLwDitDlozpq/cZ6XJeT2/elX5W0wCyucCQbiljOIk3hK5zNWgbJ1omim1mAdp5i1Z2iIUhdhFfRdYRQPXsz8vAcdk6tq5/N1DI083pSIu1sN+BScTLkHfLhtQTt9H+2wnM1W0io=
Received: from PS2PR01MB2504.apcprd01.prod.exchangelabs.com
 (2603:1096:300:3e::11) by PSAPR01MB3830.apcprd01.prod.exchangelabs.com
 (2603:1096:301:17::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21; Tue, 15 Jun
 2021 16:06:34 +0000
Received: from PS2PR01MB2504.apcprd01.prod.exchangelabs.com
 ([fe80::e9b5:6b16:ec29:6101]) by PS2PR01MB2504.apcprd01.prod.exchangelabs.com
 ([fe80::e9b5:6b16:ec29:6101%2]) with mapi id 15.20.4195.032; Tue, 15 Jun 2021
 16:06:33 +0000
From:   Alex Nemirovsky <Alex.Nemirovsky@cortina-access.com>
To:     Rob Herring <robh+dt@kernel.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jason Li <jason.li@cortina-access.com>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 2/3] dt-bindings: serial: Convert Cortina-Access UART
 to json-schema
Thread-Topic: [PATCH v4 2/3] dt-bindings: serial: Convert Cortina-Access UART
 to json-schema
Thread-Index: AQHXRQOEXSJdPocm00OQib3aojINxasVL/wAgAAc6oCAAApRAIAAByaAgAASOYCAAAYzAA==
Date:   Tue, 15 Jun 2021 16:06:33 +0000
Message-ID: <9937DB34-7757-4A54-BCC6-AF5514FD7F1D@cortina-access.com>
References: <20210509184519.15816-1-alex.nemirovsky@cortina-access.com>
 <20210509184519.15816-2-alex.nemirovsky@cortina-access.com>
 <YMiUpK/+PjsoCU1W@kroah.com>
 <CFD14D63-4537-4A91-861C-71B74E2CFAE6@cortina-access.com>
 <YMi1jOL6y+eUK3Df@kroah.com>
 <B71C5D02-EDBE-4AAD-AF1B-2FD467BE075A@cortina-access.com>
 <CAL_JsqKDf9W-1KHUoFFCoLareLKf0CAVMU6CXR22xW3hWM_8yg@mail.gmail.com>
In-Reply-To: <CAL_JsqKDf9W-1KHUoFFCoLareLKf0CAVMU6CXR22xW3hWM_8yg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none
 header.from=cortina-access.com;
x-originating-ip: [70.58.207.205]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9c546007-7437-40b0-5531-08d930178bef
x-ms-traffictypediagnostic: PSAPR01MB3830:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PSAPR01MB38308509A0E72527213CAB5ECB309@PSAPR01MB3830.apcprd01.prod.exchangelabs.com>
x-ld-processed: 0694623c-6669-497c-89c3-3a32a9934313,ExtAddr
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: X0BV1Uayga0Qbfjadu0HECMu43fowop8ZWNlIU2UG5+QxrlSz0zwVBIBU8z6y93+gIiugNMmahA+AjiN4j7fLfax75xc/OuR7F94fLksOhjXiWi0Le6WKxlLlFH19pIJc1gcnMsPe6Zg12yTfn7SBu67L6e/NrDW8SA0qh4gTHoQkeC1hPCQxZH+Sp/j+nckzWzUJB78S6zwkrCYMkHLeegs8vCWfALdoERbvLFSgdXQ0haDokchpu0l0vY0ugQUTidQ24K15nl4zJFZ0nSHlbz47/5OZBZ8jUv6trTmUy6hDJrjPwPNqktngAsQVFd1yJTw0bTnBeq0qhxFwUWT6tyy3EFKY1Fj0i8aqS8MdFdkK4rRUa7m3VGfG5f+6Cd8IQPyE4BBqj4oHiHgG7voik5PNj/VD5E3p/HNbo4+JdCTQVd7eDWQEVQXoBUlQdSU77f8KenlyiMEWfFFL3w88xNmVQ2ctDqz4H/iicoXekIACraI9Q8bPjpU2gDHKfPC77VL2deFJMmyupP9b5hoy9Xefrv50vwKyMYFlXbRg1bpeSnEZi/w4pLcMT1C5/HDQAVtRb+3Krjh+792T1QID6cdKmHYUySmddPpJh13N8M=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PS2PR01MB2504.apcprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(2906002)(6512007)(86362001)(54906003)(71200400001)(64756008)(83380400001)(76116006)(91956017)(36756003)(6486002)(122000001)(38100700002)(5660300002)(8676002)(498600001)(66476007)(66446008)(53546011)(26005)(8936002)(4326008)(66946007)(6506007)(186003)(2616005)(33656002)(66556008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U21lVEdhWGNOaEk2ckRTOG5tZG40KzNFR05RQW92djBRY3huazlGZGo1eVZP?=
 =?utf-8?B?YjdnYk1jMUdNZ2l6b204S2o2SUVYcTh6NnVJZldWVzhHRTNocGZ6TE5jSjZK?=
 =?utf-8?B?d1pvcWNCTzdxTHBEdytQVkU1TUZyN29xUW92SDlnRU9Hd3VDU3grZnpDUjQy?=
 =?utf-8?B?aXNpL2JKRDlPV2F0ZmVMT01wODQySXVrZzVUOVhObk52UUo3a3RWZmxHWDFy?=
 =?utf-8?B?UnlDeUNiOHZvcjJtTkdLNGI1ZG4vYzJISEFkQVdpMTdSRXRHNWI5ZGVLTkd2?=
 =?utf-8?B?clg1SFJRTEJlaHdQczNsNmtLSGNaMVV5US9yRmJoVllSd1Y3OGJVT1JFYmtm?=
 =?utf-8?B?VkRMSjkzMmdEZ0NucGptTHNtVGZnbmgvdlFxaFFRY2Q0dFdxT0RJeGlUMjV3?=
 =?utf-8?B?UjhaOUN0RXZvblBObTZ1RU9NSnlCQ2xKVm5wSUdpSllCN1RFWlVVTkJXN0Z5?=
 =?utf-8?B?T2ZPNHNJeVVHbVZ1RWhqRXl5ZEY4VWR5R1Azcjh1QkFpSVZpajF3ZWFNR2VX?=
 =?utf-8?B?QmhFSFR1OEJhUTQ5VHdpYk1tcUllcDBnNmM2WlBxTUVySkFGNXErQld0ckxa?=
 =?utf-8?B?VGxTc0oyUnFwYitXK0x4VE9Hc3JRUC9kS2F3b2hKaFk1UGZnV1RZeE5YVWFX?=
 =?utf-8?B?bjB5M2JpTDA0MklDZ05nYjFVei9RcTRkTngwRWIrNUowOVpMUXdrZkNvc2wy?=
 =?utf-8?B?WkR2UFVRc1F3SHVnODN4QWZDOTMyMlBSMEgyWEc1NWVicWJ0cFhYOXZkSVdl?=
 =?utf-8?B?NTFDOXdDWXdnRk9GZVI1S1RHT2UzbHJXNUVsUW13bFJqYXBSR1VzcUVDbUIz?=
 =?utf-8?B?Z0YvcXZOYjM3cGVrVXdaWExTRHJ3cUdpazRac0NUR0VsUVVuQnBzcno0bWZr?=
 =?utf-8?B?YkxOU3pXTjBJclZJRk5STW1tV2krbk1Xek1mZFFtMkZScG02WTRPRWh0MHdQ?=
 =?utf-8?B?aDBBOEhEVnZsWEdneTVNK3krb0loa1A1Mm01cUJ1NFpHblNDemlCQ2U3REpU?=
 =?utf-8?B?NVFpVkhsWlI3cXdITWx0cDRLNFJnNEtQMWFPS2gvVDR1RDU0b2VSaUt6c3RV?=
 =?utf-8?B?VHNPbVJGK1B1ZEpJMXNjMmFYaXlGNXJxQXF3RUpKVktMamtRL0NOZjk3b3Zr?=
 =?utf-8?B?bnNZaUdMRVViNjFhbmphY0lxYmRha29Kb2IvY0p0UUxSTmpmb0pERDQ1M3A5?=
 =?utf-8?B?UEJoV1pCaEFkeUE4ZktYbGVlUWdZenpOc0U3eEZXalE2OG5FVDdObWxtcHpB?=
 =?utf-8?B?M1VIdXVPQjRQR2pCMGhsUmlEVDNieUYzdTNWQmpGWkRGNXYrVXBOR0Ewc3U3?=
 =?utf-8?B?bnZxcitRUlU2aFBEa3VsU1lLazRyUzBZWUdQK1ZWQkU0bUY3VTFVZHFxbjBo?=
 =?utf-8?B?Nk1uT3RQbS9xL3FnY2JRVEJwaTFQUys3WlFlS2g2aUllSWFCMlFORjlYOUZL?=
 =?utf-8?B?MkN3RHBIaFhtV2VGQU9qYkZZSXBTNzlwZFNkelVQbU1wM0lSYXhuM2Vuejhv?=
 =?utf-8?B?bzNiTXZ4YW50Wk9wcjllL3FFRDFYTnR2WjNla0lMTUVqMlJWQS9EQlBYMUx5?=
 =?utf-8?B?ZHZ0c0wrNEJuaFBlUWkzc3kzK1NhYWl3M2dZYkFnbkxURUpBTDdQYUczc0Jz?=
 =?utf-8?B?bFRTMGNtc095YVA0VHBtaDczN2VXMEl0SlhHaVY4cDRCSjJwaTExVUdXSFRF?=
 =?utf-8?B?dDRLdDd3ckc1clhYR3JNUjVxbUQ1bzR3UWNKakRadDNYeGMrN01FVnUvMmpv?=
 =?utf-8?Q?ruOttpTKRV5wDPH4c7HKdJm1MCsreZk0Z3GbSl0?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8748F7F31947814F92475236C65B076C@apcprd01.prod.exchangelabs.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: CORTINA-ACCESS.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PS2PR01MB2504.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c546007-7437-40b0-5531-08d930178bef
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jun 2021 16:06:33.4867
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0694623c-6669-497c-89c3-3a32a9934313
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JcALVvtFtQ4E76b8rwLFKpEt4AGF2R3dr2Bq4bdIYbJEP7w3MwbmE+v0QUBR/CMl1dKjxRivhbd0ysQuJx0ySOdxhcQdV/5kdk3CX4QzpyBiOXBKVQZ0D7rSuVXOXj8R
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PSAPR01MB3830
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

DQoNCj4gT24gSnVuIDE1LCAyMDIxLCBhdCA4OjQ0IEFNLCBSb2IgSGVycmluZyA8cm9iaCtkdEBr
ZXJuZWwub3JnPiB3cm90ZToNCj4gDQo+IE9uIFR1ZSwgSnVuIDE1LCAyMDIxIGF0IDg6MzkgQU0g
QWxleCBOZW1pcm92c2t5DQo+IDxBbGV4Lk5lbWlyb3Zza3lAY29ydGluYS1hY2Nlc3MuY29tPiB3
cm90ZToNCj4+IA0KPj4gDQo+PiANCj4+PiBPbiBKdW4gMTUsIDIwMjEsIGF0IDc6MTMgQU0sIEdy
ZWcgS3JvYWgtSGFydG1hbiA8Z3JlZ2toQGxpbnV4Zm91bmRhdGlvbi5vcmc+IHdyb3RlOg0KPj4+
IA0KPj4+IE9uIFR1ZSwgSnVuIDE1LCAyMDIxIGF0IDAxOjM2OjM5UE0gKzAwMDAsIEFsZXggTmVt
aXJvdnNreSB3cm90ZToNCj4+Pj4gTUFJTlRBSU5FUlMgbW9kaWZpY2F0aW9uIHdhcyBtYWRlIGlu
IHRoZSBpbml0aWFsIHZlcnNpb24gMS4gIFdlIG1hZGUgbm8gY2hhbmdlcyB0byBpdCBzaW5jZSB0
aGVuLA0KPj4+PiB0aHVzIG5vdCBzdXJlIHdoYXQgd2UgY291bGQgYXQgdG8gIENoYW5nZWxvZyB3
aGljaCB3b3VsZCBhZGQgdmFsdWUgb3IgY2xhcml0eSBmb3Igb3RoZXJzDQo+Pj4+IGZyb20gdGhl
IHYxLg0KPj4+PiANCj4+Pj4+IE9uIEp1biAxNSwgMjAyMSwgYXQgNDo1MyBBTSwgR3JlZyBLcm9h
aC1IYXJ0bWFuIDxncmVna2hAbGludXhmb3VuZGF0aW9uLm9yZz4gd3JvdGU6DQo+Pj4+PiANCj4+
Pj4+IE9uIFN1biwgTWF5IDA5LCAyMDIxIGF0IDExOjQ1OjE3QU0gLTA3MDAsIEFsZXggTmVtaXJv
dnNreSB3cm90ZToNCj4+Pj4+PiBGcm9tOiBKYXNvbiBMaSA8amFzb24ubGlAY29ydGluYS1hY2Nl
c3MuY29tPg0KPj4+Pj4+IA0KPj4+Pj4+IENvbnZlcnQgdGhlIENvcnRpbmEtQWNjZXNzIFVBUlQg
YmluZGluZyB0byBEVCBzY2hlbWEgZm9ybWF0Lg0KPj4+Pj4+IA0KPj4+Pj4+IFNpZ25lZC1vZmYt
Ynk6IEphc29uIExpIDxqYXNvbi5saUBjb3J0aW5hLWFjY2Vzcy5jb20+DQo+Pj4+Pj4gLS0tDQo+
Pj4+Pj4gLi4uL3NlcmlhbC9jb3J0aW5hLWFjY2VzcyxzZXJpYWwueWFtbCAgICAgICAgIHwgNDYg
KysrKysrKysrKysrKysrKysrKw0KPj4+Pj4+IC4uLi9kZXZpY2V0cmVlL2JpbmRpbmdzL3ZlbmRv
ci1wcmVmaXhlcy55YW1sICB8ICAyICsNCj4+Pj4+PiBNQUlOVEFJTkVSUyAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgfCAgNiArKysNCj4+Pj4+IA0KPj4+Pj4gWW91IGFyZSBhbHNv
IGFkZGluZyBhIE1BSU5UQUlORVJTIGVudHJ5IGhlcmUsIHdoaWNoIGlzIG5vdCBsaXN0ZWQgaW4g
dGhlDQo+Pj4+PiBjaGFuZ2Vsb2cgdGV4dCwgc28gSSBjb3VsZG4ndCB0YWtlIGl0IGFueXdheSA6
KA0KPj4+IA0KPj4+IEFkZCB0aGUgbWFpbnRhaW5lcnMgZW50cnkgaW4gdGhlIGZpcnN0IHBhdGNo
LCB3aXRoIHRoZSBkcml2ZXIgcGxlYXNlLg0KPj4gDQo+PiBUaGUgY2hhbmdlIHRvIE1BSU5UQUlO
RVJTIGhlcmUgYWRkIGEgbmV3IGZpbGUgaW50byB0aGUgRFQgZG9jdW1lbnRhdGlvbi4NCj4+IFNo
b3VsZCBpdCBub3QgYmUgZ3JvdXBlZCBpbnRvIHRoZSBkdC1iaW5kaW5nIHBvcnRpb24gYW5kIHJl
dmlld2VkIGJ5IHRoZSBEVCB0aW1lIGZvciB3aGljaCB0aGlzIHBhdGNoDQo+PiBpcyBDQ+KAmWVk
IHRvPyBXaHkgd291bGQgbW92aW5nIHRoZSBEVCBkb2N1bWVudGF0aW9uIGZpbGUgdGhhdCBpcyBp
bnRyb2R1Y2VkIGJlIGludG8gdGhlIGZpcnN0IHBhdGNoLCB3aGljaCBpcyB0aGUNCj4+IHNlcmlh
bCBkcml2ZXIgaXRzZWxmIGJlIHRoZSBjb3JyZWN0IGFwcHJvYWNoPw0KPiANCj4gVGhlIGJpbmRp
bmcgZG9lc24ndCBhY3R1YWxseSBuZWVkIGEgTUFJTlRBSU5FUlMgZW50cnkgKHRob3VnaCBoYXZp
bmcNCj4gb25lIGlzIGZpbmUpLiBnZXRfbWFpbnRhaW5lcnMucGwgd2lsbCBhbHNvIHB1bGwgZW1h
aWxzIGZyb20gdGhlDQo+IGJpbmRpbmcgc2NoZW1hLg0KPiANCj4gUm9iDQoNCkhpIFJvYiwNCkl0
IHNvdW5kcyBsaWtlIHlvdSBhcmUgZmluZCB3aXRoIHBhdGNoIDIvMyBmcm9tIGEgRFQgcG9pbnQg
b2Ygdmlldy4gIENvdWxkIHdlIHJldmlldyB0aGUgcmVzdCBmcm9tIHRoZSBEVCBwb2ludCBvZiB2
aWV3DQp0byBnZXQgZWl0aGVyIGZlZWRiYWNrIGZvciBjaGFuZ2VzIG9yIEFDSyB0aGVzZSwgc28g
d2UgY2FuIHVuYmxvY2sgdGhpcyBzZXJpZXM/ICANClRoYW5rcw0KQWxleA0KDQo=

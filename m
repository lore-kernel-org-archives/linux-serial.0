Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B9CDC48BDF
	for <linux-serial@archiver.kernel.org>; Tue, 15 Jun 2021 14:39:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EEC1A61494
	for <linux-serial@archiver.kernel.org>; Tue, 15 Jun 2021 14:39:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230463AbhFOOlY (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 15 Jun 2021 10:41:24 -0400
Received: from mail-eopbgr1310070.outbound.protection.outlook.com ([40.107.131.70]:10071
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230187AbhFOOlV (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 15 Jun 2021 10:41:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ipcr9jUeqj2UXoGOxN1reiTgFKwd2WMlCb1RLc++ntca2QSv54ieta/5E91rxsNtgXwNUn+gAhkyEI0eePSDaNt86+PAJ9vLhAnKR8UDDbKo205nOrbd9KQe6zsqhwtgMrWS5jj6Z+frYJMeU8jL0vEuXVIQ6k02yeaVsSsZAHyPMpJwUAUROAo38v7GDDWcdtcoZWyQBHmlQGL30F6azo+OER95L+mTurVS4cg0lRgWUJ8tHFjNv8BZJApEzDVVdAu4jmeD+F8ug2xRWqUwmU8AxYO2CkYWEYeUcAsf1C2oOJS8EYECFFNv6ga8FDiVObVL1AX0nOPkFGOoYULHwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PWvSlx4rnHrgxdKM/o47OjBfsA0vUPuueifJ1KxlUgc=;
 b=Yp05A0hGXjpdqWER5QGpLk1JKXfgNyTvRxcOjgND2gRjsXUTcnxFUxfacMk/Ux4QCKBr/5gqQDQXHaM+dq/psFknEnTt1VTZs2QkXBxXWRzfcxRRHoQDphDhbT8zPKQOkzbSUaIP+uOC7JHne1H95siS40xYZJerq/gQZDeR7FjWgXph4KoGlWi3S+GSOGp8IA5GPlgVURdX4lJy89DYs3YsMGJEANyCI45/PXUfShxXxHBOa5HWmcOdAA4wWQbAaB1xUAEv76pQW9kWYpmiGg4QNFWe68JkeIIOqstneC3LTXDxjKkyhUg6erJxkGstaNkhS5XXwFygD4zQZnMnAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cortina-access.com; dmarc=pass action=none
 header.from=cortina-access.com; dkim=pass header.d=cortina-access.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CortinaAccess.onmicrosoft.com; s=selector2-CortinaAccess-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PWvSlx4rnHrgxdKM/o47OjBfsA0vUPuueifJ1KxlUgc=;
 b=ELKExIwcb0gCtnxX+7lAKWIIcLfyE2OZ7QsMrbj11r7hxG9de+LS0ReH8JPvShiteeFn7LX0ENSRa2Wonq040lmA857jRb5ymNc5131B3+L8hE7NL/3fihBinzdVaHcm4tkbvvHd303xboCREQS5vE6rp0NqZeX1AG0s/3Tt0yU=
Received: from PS2PR01MB2504.apcprd01.prod.exchangelabs.com
 (2603:1096:300:3e::11) by PSBPR01MB3542.apcprd01.prod.exchangelabs.com
 (2603:1096:301:c::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.22; Tue, 15 Jun
 2021 14:39:08 +0000
Received: from PS2PR01MB2504.apcprd01.prod.exchangelabs.com
 ([fe80::e9b5:6b16:ec29:6101]) by PS2PR01MB2504.apcprd01.prod.exchangelabs.com
 ([fe80::e9b5:6b16:ec29:6101%2]) with mapi id 15.20.4195.032; Tue, 15 Jun 2021
 14:39:08 +0000
From:   Alex Nemirovsky <Alex.Nemirovsky@cortina-access.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Jason Li <jason.li@cortina-access.com>,
        Rob Herring <robh+dt@kernel.org>,
        Rob Herring <robh@kernel.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 2/3] dt-bindings: serial: Convert Cortina-Access UART
 to json-schema
Thread-Topic: [PATCH v4 2/3] dt-bindings: serial: Convert Cortina-Access UART
 to json-schema
Thread-Index: AQHXRQOEXSJdPocm00OQib3aojINxasVL/wAgAAc6oCAAApRAIAAByaA
Date:   Tue, 15 Jun 2021 14:39:08 +0000
Message-ID: <B71C5D02-EDBE-4AAD-AF1B-2FD467BE075A@cortina-access.com>
References: <20210509184519.15816-1-alex.nemirovsky@cortina-access.com>
 <20210509184519.15816-2-alex.nemirovsky@cortina-access.com>
 <YMiUpK/+PjsoCU1W@kroah.com>
 <CFD14D63-4537-4A91-861C-71B74E2CFAE6@cortina-access.com>
 <YMi1jOL6y+eUK3Df@kroah.com>
In-Reply-To: <YMi1jOL6y+eUK3Df@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=cortina-access.com;
x-originating-ip: [70.58.207.205]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 261baa30-2db4-4865-6b3b-08d9300b5567
x-ms-traffictypediagnostic: PSBPR01MB3542:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PSBPR01MB35427898D0FD3D11BE7AA8FECB309@PSBPR01MB3542.apcprd01.prod.exchangelabs.com>
x-ld-processed: 0694623c-6669-497c-89c3-3a32a9934313,ExtAddr
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: C3bfSO5hRpIw3Gy8ItYSsAYkO749b41lP6Hnx3jaa5erGQGtJv859Tsepzsudx54XG/OOTwQrnm0vnbtXTu7Zkh2UO4zs34C1gX0u/ioHp61WEovtfq5+sDGM83ceVA58OibQldBvhTUJ+aARp/06cayRNdHtnqiFpKHrQHOh+Mk0id6Y2I/OAzZ/oO09kvJD637Lwol7QjMEHVFVv4E6BgxPQ6uGxWOax2NsEOP8D/hBtOGDdaGBtuM1BZmQ4PBYpEh2ZWSC9XX0b0glqdbzElz0IhayYfpTjQ+0/NdfFcuoCdrKR2cxmyNjxG1hDTJbfHEYKEIuXXudGDxUqEd3fY8UtH4/D4qZYRsfhryOVTujlwK/vpFNInFjIrEkxtl2G0aUGXiom64DEQ8wa8YLk6pP/1rdDCSad6Brc57+c9moThsxnUjmlU+XmrJPw7GxLV+clI1V+ocp/6bqArptIY+7CNCqgl0JY7Q2Y+H5OHiSPApd4LmmVM5ID+MWXAcZ8PkSYBiEBk2Hc2Z9mJBxqMV0X69p2q8Tf4VwlLl56JAJ8VajoY9tLv/g4Q7XwEYTdmJ6VGroLivCC0oK+ItNBhWRuviNb8/Rfm3Ft13ygc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PS2PR01MB2504.apcprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(26005)(4326008)(6512007)(2906002)(6486002)(6916009)(33656002)(498600001)(36756003)(2616005)(86362001)(186003)(83380400001)(64756008)(66556008)(66476007)(71200400001)(66446008)(53546011)(122000001)(6506007)(8676002)(54906003)(66946007)(5660300002)(91956017)(76116006)(38100700002)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U1dJYXVJWExGODlab1owWUVHOSs5OW0ybldYN2lvejM1RFZDMk51TGJnak4w?=
 =?utf-8?B?c0tGVm1VSVA1SU0wUVB0T2haNW95b1JHYlpDMXR0cE1nT1RZOFhrN0ErTEJt?=
 =?utf-8?B?RE5ZM3kvcjFEMDh6Vk52L2N2VVE3cHRSb3NpSmxDRHV5QUNFeDI4bkU4NzZO?=
 =?utf-8?B?UnJlb2JONko2RmtZOEQ1bmJBUEhiRkVkaHZJM2J4VGxkMjVFaDB5QzNLYUlX?=
 =?utf-8?B?Q2VuSmJSWFV5VC8rZzBIK2JrWjI2cHVEZldXdHFlNUp1WXZnRncxZlhCUURs?=
 =?utf-8?B?V1hxVDBJUHZKNTVhZk00N3ZLYkc5ZWY5YXd4WEpHcWF0ajVmVHNxMG16V0ZI?=
 =?utf-8?B?NE9KbUxBQlIxNHI5N1ZVaVp6M1oxQUFnUDZWQ0xVRFBENUtMQWhwazRDc3Ir?=
 =?utf-8?B?UlZhVTAxZkhpdUdrbDAyZnNDU3dhYmM2UG9uNGJXUlBIOHNkL21mT0ZDVWlV?=
 =?utf-8?B?cnp3cE43UUlXODhtOTJEYVZkWU0xOVVBR2VMZUJDSU14enF2aDJOY3VqaFBX?=
 =?utf-8?B?OUl5QmpWSW05ejV4a1hDdHdBWUZlN2FGMkJyN1ZOMUNMd2pSUTZ1a25BcE1P?=
 =?utf-8?B?L29VNk0xUzNrUEFXWit1OHpKS0J2dUtqQnVEM1BpRHY2Y2VzZFRYVkJLb0d0?=
 =?utf-8?B?TFhFV3N4ZUY1NXhSV0ZaYkswZ1d4Z1dRM2FHQXY4bDlnM3JibWpjK1NCb2hG?=
 =?utf-8?B?TkczeUdROVh0d0lzUThoenZLZ2pLU2pRdFc1RHhUV0JzNGM5eW9ES1dDc2VS?=
 =?utf-8?B?L0QwQW1NbERRcmhIMDU5NU9VQmVPbHBBN1dnMHlXc3R1akFqNE1vb09ISlda?=
 =?utf-8?B?UENqZ3orS2ROcUdlaUo0ZERpZTFhc2EySHBvcEFhOFlYRVlLV1Jab05sWUNY?=
 =?utf-8?B?SXJJT3Q2WUVJdGFnMVhEMnF2U3hPSjFIVFMvRkxsUGFLMDBYb0gveENzbWsy?=
 =?utf-8?B?YkFlcnU2a3ZOYXVYOGN5VFkycXozS0V0NXNsRUxCSmIwSzhYbDNlRUxJR3Zp?=
 =?utf-8?B?dW1mOU02R2loclVuQ3c0eVpPL282aXBrOVZ1MW43L3Q2M21TNzg3VmxIQnF4?=
 =?utf-8?B?Ly9wR2orY0dJVXN6SGtSSzluK0tHMnR4eGJTNGQxb0R5RDI4Y2tOVEkwY1A0?=
 =?utf-8?B?Y1RHUXpNYmFTM2hNRWJXczFlRGt0SGNaSldlM1JuRGllQTZzQVF3TUwzdUI1?=
 =?utf-8?B?UlRRTGF3YjNMc2RjNS85TFNBWFE1TVdtV0pVNTMwek8rM3NYSHNMQlR1QnlB?=
 =?utf-8?B?UG9lR1Y2c2l2YlNJbXEvbFJYdDJBU2VlaFc3azRaMEF3U2tHRE4veXJxeE5F?=
 =?utf-8?B?d2pMem44dTBsSFVLU0QxQWcxb2dXMElGYmJKOGlPOGhNVy9IY3dtS01VanFF?=
 =?utf-8?B?WktyRlpmZjRRVHlmWmNVKzhKcE0wTEU2M2QxTCtZdEFkbW90Ym1YNWJGdXE4?=
 =?utf-8?B?ZVB3d1dDVWNuREVjM0wxZlZjamwySVNzUHFYa1BsV3RkeGxjR3A5QkdLOTVR?=
 =?utf-8?B?VStna2wwenVscnFOdXFBRmtYK0R0L2dCWlZGSklRQVM1TUtMbHBwM1NsT0JF?=
 =?utf-8?B?cmNPUG5MckNxK0tPWTduVVc1Ung0cFVublBLY0pKWlB6MWlyeDJ1OG4rTEFZ?=
 =?utf-8?B?ZmFtc0djakYra3liOW95L1hPaVJVTGMxU0lTTFZCRkx0WTBrT1FCNnc0cUNM?=
 =?utf-8?B?a0hWeXorT0U1WTlhRUs4V0ROekY5TWVJcmY5a05wamlQbUdiWWVxQlZ5Y21B?=
 =?utf-8?Q?BSjUNOCUR/KKqWix7G+d08Lptom/B/xAwF5uEl9?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1517E064A6EDFC4EA32F42C63C8070EB@apcprd01.prod.exchangelabs.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: CORTINA-ACCESS.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PS2PR01MB2504.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 261baa30-2db4-4865-6b3b-08d9300b5567
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jun 2021 14:39:08.4111
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0694623c-6669-497c-89c3-3a32a9934313
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 242xywmcKpeVvlkaNtG20XvSRWWazUybL0oHGLk3hO4kFAcNU2QgKAviP2YsFPmkudxUvf2kNUTypdYSEVaMLhSowVLh8mmTxLr+ZxEHM50P4N0NK79FIrZ4W1YAPAuK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PSBPR01MB3542
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

DQoNCj4gT24gSnVuIDE1LCAyMDIxLCBhdCA3OjEzIEFNLCBHcmVnIEtyb2FoLUhhcnRtYW4gPGdy
ZWdraEBsaW51eGZvdW5kYXRpb24ub3JnPiB3cm90ZToNCj4gDQo+IE9uIFR1ZSwgSnVuIDE1LCAy
MDIxIGF0IDAxOjM2OjM5UE0gKzAwMDAsIEFsZXggTmVtaXJvdnNreSB3cm90ZToNCj4+IE1BSU5U
QUlORVJTIG1vZGlmaWNhdGlvbiB3YXMgbWFkZSBpbiB0aGUgaW5pdGlhbCB2ZXJzaW9uIDEuICBX
ZSBtYWRlIG5vIGNoYW5nZXMgdG8gaXQgc2luY2UgdGhlbiwNCj4+IHRodXMgbm90IHN1cmUgd2hh
dCB3ZSBjb3VsZCBhdCB0byAgQ2hhbmdlbG9nIHdoaWNoIHdvdWxkIGFkZCB2YWx1ZSBvciBjbGFy
aXR5IGZvciBvdGhlcnMNCj4+IGZyb20gdGhlIHYxLg0KPj4gDQo+Pj4gT24gSnVuIDE1LCAyMDIx
LCBhdCA0OjUzIEFNLCBHcmVnIEtyb2FoLUhhcnRtYW4gPGdyZWdraEBsaW51eGZvdW5kYXRpb24u
b3JnPiB3cm90ZToNCj4+PiANCj4+PiBPbiBTdW4sIE1heSAwOSwgMjAyMSBhdCAxMTo0NToxN0FN
IC0wNzAwLCBBbGV4IE5lbWlyb3Zza3kgd3JvdGU6DQo+Pj4+IEZyb206IEphc29uIExpIDxqYXNv
bi5saUBjb3J0aW5hLWFjY2Vzcy5jb20+DQo+Pj4+IA0KPj4+PiBDb252ZXJ0IHRoZSBDb3J0aW5h
LUFjY2VzcyBVQVJUIGJpbmRpbmcgdG8gRFQgc2NoZW1hIGZvcm1hdC4NCj4+Pj4gDQo+Pj4+IFNp
Z25lZC1vZmYtYnk6IEphc29uIExpIDxqYXNvbi5saUBjb3J0aW5hLWFjY2Vzcy5jb20+DQo+Pj4+
IC0tLQ0KPj4+PiAuLi4vc2VyaWFsL2NvcnRpbmEtYWNjZXNzLHNlcmlhbC55YW1sICAgICAgICAg
fCA0NiArKysrKysrKysrKysrKysrKysrDQo+Pj4+IC4uLi9kZXZpY2V0cmVlL2JpbmRpbmdzL3Zl
bmRvci1wcmVmaXhlcy55YW1sICB8ICAyICsNCj4+Pj4gTUFJTlRBSU5FUlMgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIHwgIDYgKysrDQo+Pj4gDQo+Pj4gWW91IGFyZSBhbHNvIGFk
ZGluZyBhIE1BSU5UQUlORVJTIGVudHJ5IGhlcmUsIHdoaWNoIGlzIG5vdCBsaXN0ZWQgaW4gdGhl
DQo+Pj4gY2hhbmdlbG9nIHRleHQsIHNvIEkgY291bGRuJ3QgdGFrZSBpdCBhbnl3YXkgOigNCj4g
DQo+IEFkZCB0aGUgbWFpbnRhaW5lcnMgZW50cnkgaW4gdGhlIGZpcnN0IHBhdGNoLCB3aXRoIHRo
ZSBkcml2ZXIgcGxlYXNlLg0KDQpUaGUgY2hhbmdlIHRvIE1BSU5UQUlORVJTIGhlcmUgYWRkIGEg
bmV3IGZpbGUgaW50byB0aGUgRFQgZG9jdW1lbnRhdGlvbi4gDQpTaG91bGQgaXQgbm90IGJlIGdy
b3VwZWQgaW50byB0aGUgZHQtYmluZGluZyBwb3J0aW9uIGFuZCByZXZpZXdlZCBieSB0aGUgRFQg
dGltZSBmb3Igd2hpY2ggdGhpcyBwYXRjaA0KaXMgQ0PigJllZCB0bz8gV2h5IHdvdWxkIG1vdmlu
ZyB0aGUgRFQgZG9jdW1lbnRhdGlvbiBmaWxlIHRoYXQgaXMgaW50cm9kdWNlZCBiZSBpbnRvIHRo
ZSBmaXJzdCBwYXRjaCwgd2hpY2ggaXMgdGhlIA0Kc2VyaWFsIGRyaXZlciBpdHNlbGYgYmUgdGhl
IGNvcnJlY3QgYXBwcm9hY2g/DQoNCg==

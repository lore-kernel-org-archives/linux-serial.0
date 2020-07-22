Return-Path: <SRS0=VfF8=BB=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C661C433E1
	for <linux-serial@archiver.kernel.org>; Wed, 22 Jul 2020 07:04:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1EC6B2080D
	for <linux-serial@archiver.kernel.org>; Wed, 22 Jul 2020 07:04:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b="fdX4oR9I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728063AbgGVHEF (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 22 Jul 2020 03:04:05 -0400
Received: from mail-eopbgr1300084.outbound.protection.outlook.com ([40.107.130.84]:51936
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727096AbgGVHEF (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 22 Jul 2020 03:04:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c/LLSNoKAL1IjHYVpk+O/IxvJgghNLL5BKLHtcru6K+BG4+KAaEj7Q9NfxFXhq+Y7YJ/2x3EechMXA7rQyqMtO0HPOtvWPN74JhzrpjEQgJ1mh4fS35KrZv5RKwm87hv3p9Mlju+lBUtQkJwTAuD8emcVV7HC3t6NTipvQ4S3StRlUL4OGYnFe86xeeZTS8hddKfRmGgbFOxvJS/CM5TSgHihb+eOb6HEv/x986UR3+Tt4mLVukZHHQWfgf9QKwhFwnt/qgwENL9FYY8vgawMF2lGpdGE6xQMyVYWkrcl1mbiUD7V82lITt+nCxenCMe2KsPaBWqjrHRLqGkhWbH/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DylMaV/q1A8fkNR1+R85fNsA3X8O33djb2Qo8EmkvWw=;
 b=J8hRwfRYjxVFYPkmvzEfRecHYYmP4EEIUryAorvV6JT+k00bj2R1IsOjdG9iwRx+dtMqxbB3qJj2h9iNo5feTkkg+cXB6TOzWRT9hsc7IY0UpF79b8rD+3VrAuaG9fz2x11JPDoQbNPA7lbE29B8rWZZz82P5hCYt5ERtBG7ZGkEUwjrAX59/RLYVBIGowXoXiYSB2DoIYO2ZvACHiVzzKTNNW0UHA0LhmekWr6JmGW604AVq5K83ZQIYTW8tX7rHmi/sqp8a9TtGkVMSCDtSdQs33umL55L8nmtJp3MG6NDJNqH+/LX70UTAcAOHIbntOdjzV3w5/zf/PlaYXYQ5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=moxa.com; dmarc=pass action=none header.from=moxa.com;
 dkim=pass header.d=moxa.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=moxa.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DylMaV/q1A8fkNR1+R85fNsA3X8O33djb2Qo8EmkvWw=;
 b=fdX4oR9IdYH6JYg4uiZqPjiTHXhT5Q5rlcjIauHtjel7voJIs8ymlpDuc1+q8pe7X6kjqCXSn2xoQBLFgpSxr77+srft5lLdFQDVsvNKFSd0GDtHzfPcno94q/lIo8F30jtEHbRvchAp1w3lKRLemsOTH5Q0mEpu65IPs1tXpcI=
Received: from HK2PR01MB3281.apcprd01.prod.exchangelabs.com
 (2603:1096:202:22::12) by HK0PR01MB2289.apcprd01.prod.exchangelabs.com
 (2603:1096:203:75::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.23; Wed, 22 Jul
 2020 07:04:00 +0000
Received: from HK2PR01MB3281.apcprd01.prod.exchangelabs.com
 ([fe80::dce:9650:6c58:8b77]) by HK2PR01MB3281.apcprd01.prod.exchangelabs.com
 ([fe80::dce:9650:6c58:8b77%4]) with mapi id 15.20.3195.026; Wed, 22 Jul 2020
 07:04:00 +0000
From:   =?utf-8?B?Sm9obnNvbiBDSCBDaGVuICjpmbPmmK3li7Mp?= 
        <JohnsonCH.Chen@moxa.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Jiri Slaby <jirislaby@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        =?utf-8?B?VmljdG9yIFl1ICjmuLjli53nvqkp?= <victor.yu@moxa.com>,
        =?utf-8?B?RGFubnkgTGluICjmnpfmlL/mmJMp?= <danny.lin@moxa.com>
Subject: RE: [PATCH] tty: Add MOXA NPort Real TTY Driver
Thread-Topic: [PATCH] tty: Add MOXA NPort Real TTY Driver
Thread-Index: AQHWWaW+EbrUHbhx60a/vOExcWbf46kGr5aAgAMXG4CAAAnogIAJZUiA
Date:   Wed, 22 Jul 2020 07:04:00 +0000
Message-ID: <HK2PR01MB32817A21FEDDC410F2822640FA790@HK2PR01MB3281.apcprd01.prod.exchangelabs.com>
References: <HK2PR01MB328134FB2EF5F9D1E381BDA3FA610@HK2PR01MB3281.apcprd01.prod.exchangelabs.com>
 <20200714073609.GA688099@kroah.com>
 <HK2PR01MB32815CE2F455B909EA32F406FA7F0@HK2PR01MB3281.apcprd01.prod.exchangelabs.com>
 <20200716072305.GA970724@kroah.com>
In-Reply-To: <20200716072305.GA970724@kroah.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=moxa.com;
x-originating-ip: [123.51.145.16]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5775fa33-eb98-4a5a-7a85-08d82e0d6915
x-ms-traffictypediagnostic: HK0PR01MB2289:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <HK0PR01MB2289C6A9C47516DE3C4FBA1FFA790@HK0PR01MB2289.apcprd01.prod.exchangelabs.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: A57pM3mJWSTbuxjRYhMEqSNH9zXKVv02i59sr9VTYt7M19r9h9VEqankHcDQ+K7mM7CglStYv25v+AHiun6KukXKwLgsKVGomVw2GBDHAzgKk56lVrEEK3eYM6JZGy/AsT0nGv1NV8s+3KhQr20E0w7liqw6j6W9x9sBZadxDpkQR6bUPvZDLgCKa1aMEz++UGfX6D5WCZP+3xh8feHQt19na40H/1umfMIeagR5Pkoq7dbKJDVZtdtqgPFz7ryp29xrtHISk+0UozwWfhHOhaltcpVMt+Shr0ThNwRW21aqb/sNIcHUm41GIhxDFjKXHSjZhvNNOmkzqV5uKvZKbw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK2PR01MB3281.apcprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(39850400004)(136003)(346002)(376002)(396003)(83380400001)(6506007)(478600001)(71200400001)(107886003)(9686003)(7696005)(54906003)(86362001)(6916009)(26005)(85182001)(8676002)(55016002)(316002)(4326008)(186003)(52536014)(64756008)(33656002)(66446008)(66556008)(66946007)(8936002)(66476007)(76116006)(2906002)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: SUX5PDHnc55mCUX4gMn3dRkj0g2jYh1+BoUKCvfJ2EVYAtwCrn6T9D0uE7Vd6hvs8ls//zGrwEnphBYklODKMnIxZl+dzXlOA0/rWoGOpspW1QQqWodJHO/e76R1n1XY89Vq0ZVkEpUv3qn4nAbmJKBrPDhuuQvABG7kPSea2fI6EOtTICE7CtNb75r3i7gbLVy97h05wM7mZ0QH3I1K6caPcwkjqDjhmoW6tTabLEhLSEPZIJDkdVNhDphZDxvctSu5EcSB0Jg3j8kq3xQYo1CaaicDIhSTcsesZCiDgR3Mtf7/6KCFRRal2yrbL3J+FXPfPY58Jaatv1jfMG+jEUMPowXrThsbRpY1Dl90GtphNhIAwhKjjzch3vZ7FZyCdWytAYGOtRODy34YMOqgf2DppYhyUslp5O+rhxJOb88E4Yj3Qi51IJwcgbYgYcJ50YCUoxUEHFVOB5fcJvF6dDidhux47VRMUiXHzD80YgE=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: moxa.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HK2PR01MB3281.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5775fa33-eb98-4a5a-7a85-08d82e0d6915
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2020 07:04:00.3714
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5571c7d4-286b-47f6-9dd5-0aa688773c8e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: S8pQrvJU3+aoUzE6akMBYHeeyMBZBNg+snnQAMQXcAWEfYWTTKkRDjduoAa8zMsP6Ed2mlkvwfHVBF6tnyrLFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0PR01MB2289
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

SGkgR3JlZywNCg0KVGhhbmtzIGZvciB5b3VyIHJlc3BvbnNlIQ0KDQo+ID4gPiA+ICsJdW5zaWdu
ZWQgbG9uZyBmbGFnOw0KPiA+ID4gPiArCXVuc2lnbmVkIGNoYXIgY21kX2J1ZmZlcls4NF07DQo+
ID4gPiA+ICsJdW5zaWduZWQgY2hhciByc3BfYnVmZmVyWzg0XTsNCj4gPiA+DQo+ID4gPiBZb3Ug
c2VlbSB0byBoYXZlIHR3byAic3RhdGljIiBidWZmZXJzIGhlcmUsIGZvciB5b3VyIGRldmljZSwg
dGhhdCANCj4gPiA+IHlvdSBzZW1pLXJhbmRvbWx5IHdyaXRlIHRvIGFsbCBvdmVyIHRoZSBwbGFj
ZSwgYnV0IEkgY2FuJ3QgZmluZCANCj4gPiA+IGFueSBsb2NraW5nIG9yIGNvb3JkaW5hdGlvbiBi
ZXR3ZWVuIHRoaW5ncyB0aGF0IHByZXZlbnRzIG11bHRpcGxlIA0KPiA+ID4gY29tbWFuZHMgZnJv
bSBub3QganVzdCBvdmVyd3JpdHRpbmcgZWFjaCBvdGhlci4NCj4gPiA+DQo+ID4gRm9yIGNtZF9i
dWZmZXJbXSwgd2UgdXNlIG5wcmVhbF93YWl0X2FuZF9zZXRfY29tbWFuZCgpIHRvIG1ha2Ugc3Vy
ZSANCj4gPiBjbWRfYnVmZmVyW10gaXMgc2FmZSB0byBiZSB3cml0dGVuIGJ5IGNoZWNraW5nICJj
bWRfYnVmZmVyWzBdID09IDAiLg0KPiANCj4gQW5kIHdoYXQgbG9ja3MgYXJlIHByb3RlY3Rpbmcg
eW91IHRoZXJlPw0KPiANCj4gPiBGb3IgcnNwX2J1ZmZlcltdLCB3ZSB1c2UgbnByZWFsX3dhaXRf
Y29tbWFuZF9jb21wbGV0ZWQoKSB0byBtYWtlIA0KPiA+IHN1cmUgcnNwX2J1ZmZlcltdIGlzIGRl
c2lyZWQgYnkgY2hlY2tpbmcgcnNwX2J1ZmZlclswXSBhbmQgcnNwX2J1ZmZlclsxXS4NCj4gPiBD
b21tYW5kX3NldCBhbmQgY29tbWFuZCBzaG91bGQgYmUgY2hlY2tlZC4gQmVzaWRlcywgcnNwX2J1
ZmZlcltdIGlzIA0KPiA+IGdvdCBmcm9tIHVzZXIgc3BhY2UgYnkgIk5QUkVBTF9ORVRfQ01EX1JF
U1BPTlNFIiBpbiANCj4gPiBucHJlYWxfbmV0X2lvY3RsKCkuDQo+IA0KPiBBZ2Fpbiwgd2hhdCBs
b2NraW5nIGlzIHJlYWxseSBoYW5kbGluZyB0aGlzPw0KPiANCg0KSXQncyBiZXR0ZXIgdG8gcHJv
dGVjdCBjbWRfYnVmZmVyWzg0XSBhbmQgcnNwX2J1ZmZlcls4NF0gYnkgbG9ja2luZyBjb21wbGV0
ZWx5LiBUaGV5IGFyZSBzYWZlIGJlY2F1c2UgTlBvcnQgZHJpdmVyIHNob3VsZCBiZSB3b3JrZWQg
d2l0aCBOUG9ydCBkYWVtb24gYmVmb3JlLCBhbmQgTlBvcnQgZGFlbW9uIGlzIGRlc2lnbmVkIHRv
IGJlIHNpbXBsZS4NCg0KPiA+ID4gQWxzbywgaG93IGRvZXMgdGhlIGRhdGEgZ2V0IHNlbnQgdG8g
dGhlIGhhcmR3YXJlIGF0IGFsbD8gIEkgc2VlIA0KPiA+ID4gY21kX2J1ZmZlcltdIGJlaW5nIHdy
aXR0ZW4gdG8sIGJ1dCB3aGF0IHJlYWRzIGZyb20gaXQgYW5kIGhvdyBkb2VzIA0KPiA+ID4gdGhl
IGhhcmR3YXJlIGdldCB0aGUgZGF0YT8NCj4gPg0KPiA+IEFjdHVhbGx5IHdlIG5lZWQgdG8gYm90
aCBOUG9ydCBkcml2ZXIgKHRoaXMgZHJpdmVyKSBhbmQgTnByZWFsIA0KPiA+IGRhZW1vbg0KPiA+
ICh1c2Vyc3BhY2UpIHRvIGxldCBIVyB3b3JrLiBOcHJlYWwgZGFlbW9uIGNhbiBjb21tdW5pY2F0
ZSB3aXRoIEhXIGJ5IA0KPiA+IHNvY2tldCwgYW5kIE5wcmVhbCBkZWFtb24gY29tbXVuaWNhdGVz
IHdpdGggTnBvcnQgZHJpdmVyIGJ5IA0KPiA+ICJucHJlYWxfbmV0X2ZvcHMiLiBXaGVuIGNvbW1h
bmRzIGFyZSByZWFkeSBmb3IgZHJpdmVyIHBhcnQsIGl0IHdpbGwgDQo+ID4gd2FrZSB1cCBwb2xs
IGV2ZW50IHRvIGxldCBOcG9ydCBkYWVtb24ga25vdy4NCj4gDQo+IFRoYXQgaXMgbm90IG9idmlv
dXMgYXQgYWxsLCBhbmQgbmVlZHMgdG8gYmUgcmVhbGx5IHJlYWxseSByZWFsbHkgZG9jdW1lbnRl
ZCBoZXJlLg0KPiBXaHkgbm90IHB1dCB0aGUgdXNlcnNwYWNlIGNodW5rIGluIHRoZSB0cmVlIHRv
bz8gIEF0IHRoZSBsZWFzdCwgeW91IA0KPiBuZWVkIHRvIHBvaW50IGF0IGl0Lg0KPiANCj4gQW5k
IHdoeSBpcyBhIHVzZXJzcGFjZSBwYXJ0IG5lZWRlZD8gIFdlIGhhdmUgdHR5LW92ZXItZXRoZXJu
ZXQgZHJpdmVycyANCj4gdGhhdCBkbyBub3QgcmVxdWlyZSBzdWNoIGEgdGhpbmcgaW4gdGhlIHRy
ZWUgc29tZXdoZXJlLi4uDQo+DQoNCkJlY2F1c2Ugd2UgbmVlZCBoYXJkd2FyZSBzZXJpYWwgdG8g
RXRoZXJuZXQgY29udmVydGVyIChOUG9ydCBkZXZpY2Ugc2VydmVyKSB0byBtYW5hZ2Ugc29tZSBz
ZXJpYWwgZGV2aWNlcywgc28gd2Ugc3RpbGwgbmVlZCB0byB1c2UgTU9YQSBOcG9ydCdzIGNvbW1h
bmRzIGFuZCByZXNwb25zZXMgYmV0d2VlbiBob3N0IGNvbXB1dGVyIGFuZCBjb252ZXJ0ZXIuIFdl
IHdpbGwgaGF2ZSBhbiBpbnRlcm5hbCBkaXNjdXNzaW9uIGFib3V0IHJlbGVhc2Ugb2YgTnBvcnQg
ZGFlbW9uIGFuZCByZWxhdGVkIGRvY3VtZW50LCBvciB1c2luZyBmcmVlIHR0eSB0byBFdGhlcm5l
dCBkYWVtb24gc3VjaCBhcyAoc2VyMm5ldC8gc29jYXQvIHJlbXR0eSkgYW5kIGltcHJvdmVkIG5w
b3J0IGRyaXZlciBsYXRlci4gVGhhbmtzIGEgbG90IQ0KDQpCZXN0IHJlZ2FyZHMsDQpKb2huc29u
DQo=

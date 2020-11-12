Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDE50C2D0A3
	for <linux-serial@archiver.kernel.org>; Thu, 12 Nov 2020 09:10:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 50F8D206FB
	for <linux-serial@archiver.kernel.org>; Thu, 12 Nov 2020 09:10:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="A0QeJGqg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727173AbgKLJKx (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 12 Nov 2020 04:10:53 -0500
Received: from mail-eopbgr50066.outbound.protection.outlook.com ([40.107.5.66]:46311
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725995AbgKLJKw (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 12 Nov 2020 04:10:52 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eEsG85a7ytuXFltknFnv+WZno6VZkpkRISlilVE/Z76DkgsJ3usq/pCiEw1Uf0nWO4Nyes5vRDZmvGyYA/nIk9fUMyrN9q+qBESs9hkVDz3yJs2P0QmMotc3r68eP0xF3k5CqmclOda5oGZLWSYB+JI+zDTb0C6tY6nEmwBnQN0014zjyABL7szvq6GhhrbDClzqZpOgP6FtBvk9yCpsmXDGtoDnBanIa/cJ8DFw6mq2E3dqcX7yLKO+Tiuc3HlGcH9H/ps/ABhF7QLQJVEzs3jJG7jvumuI5ayVg8jlfeqfNgp+LyBBg4eDvrFrIizAkeyF+ptKBfax5pKaQVjR/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uV1PVGUF15T/ERmAyyqRnR0vqmeVAQ7Cia7Yez3z2p0=;
 b=jGygCcgx0SF1+qFaYuuRccPPdLaAAl/l/GnABGGL7cjm9SM9bqeu+CXtzOIHwC9jK+U+W121d+P11r20dvgZgw6D5XlVxnrFc8mxk2LXGr+XamFYBkZKkL0wrOJjfolBRLVkC49b6g86fKtBJTspgeJp2O43nnM3Cn5jU7hdJCZ8FwVEEhdS33WYoW7jQm9ZymyxD5j0OlVziOo2GYOEVHPe2brmTiS34eCVYU6OZuqLmjE3j+nk+K8BDkD9P21og4jRC+ORexzj68ps9RPyFGQmtPs6mE8661C+b8yUlKyuFM6sKMPkG2wM/t+CK406yVEeBL08l9Gg7xYhzQa/lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uV1PVGUF15T/ERmAyyqRnR0vqmeVAQ7Cia7Yez3z2p0=;
 b=A0QeJGqguRzPyvhZJ/p1ZuaKAm8TPvKVLzuH2Itxxcdvl6zWxbwI38e44HRqpSyOnKpPHauI/Dshp7PWDQo79XNsUgNbmqBhdUyQGlKwxbDD6/mHqA7vxIoSrY7+hjC2kP5UJGDqGlpkZlfZnvBAhXf1rTg5FeYT4AXnhW9GuHc=
Received: from AM8PR04MB7315.eurprd04.prod.outlook.com (2603:10a6:20b:1d4::7)
 by AM0PR0402MB3588.eurprd04.prod.outlook.com (2603:10a6:208:23::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21; Thu, 12 Nov
 2020 09:10:48 +0000
Received: from AM8PR04MB7315.eurprd04.prod.outlook.com
 ([fe80::11e6:d413:2d3d:d271]) by AM8PR04MB7315.eurprd04.prod.outlook.com
 ([fe80::11e6:d413:2d3d:d271%6]) with mapi id 15.20.3541.025; Thu, 12 Nov 2020
 09:10:47 +0000
From:   Andy Duan <fugang.duan@nxp.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "lukas@wunner.de" <lukas@wunner.de>
Subject: RE: [EXT] Re: [PATCH v2 tty/serial 1/1] tty: serial: imx: keep
 console clocks always on
Thread-Topic: [EXT] Re: [PATCH v2 tty/serial 1/1] tty: serial: imx: keep
 console clocks always on
Thread-Index: AQHWt9bylW4UR7FuNkyJgUuq+IJxXqnELzAAgAAIMkA=
Date:   Thu, 12 Nov 2020 09:10:47 +0000
Message-ID: <AM8PR04MB73159E4424DE1DFB0182E4E8FFE70@AM8PR04MB7315.eurprd04.prod.outlook.com>
References: <20201111025136.29818-1-fugang.duan@nxp.com>
 <X6z07OYQW9yUUFPE@kroah.com>
In-Reply-To: <X6z07OYQW9yUUFPE@kroah.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=nxp.com;
x-originating-ip: [119.31.174.67]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 55894b97-56d6-4823-1a74-08d886ead816
x-ms-traffictypediagnostic: AM0PR0402MB3588:
x-microsoft-antispam-prvs: <AM0PR0402MB3588E846BD79F6AA38C24C9FFFE70@AM0PR0402MB3588.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ejhWPFHMVoMMiUcQjg090DOur96jINWQ5M9Vmv3qlG2Gm80Auv2LNOgwaJwjb+eWmBick2hbzG7YmMwwxvh1weUBX9tcDGDfkDcX/jPHW05NBZF0mv0nwz0/DPH8vReTNKZZICFc0wP6sKbAC/IIqQ5B6Tg5h0jzuABO0wlHzpv0mWFeY3ITs21xY4A8m+7kU6YZLpGdSJPGqvsQZrg/YRGS2ysDY+fpPqscfczXHH+xH7/+kqitjq3610E8Cnj4tTPSaO0Pbu/txgitCs8oFvnnAuAkPV3EeCEG4O9h9hl8RPabb+OyKhIhdGP7ATXX
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7315.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(396003)(136003)(366004)(39850400004)(66556008)(66446008)(83380400001)(66476007)(66946007)(64756008)(76116006)(55016002)(71200400001)(9686003)(33656002)(478600001)(6916009)(4326008)(7696005)(186003)(26005)(6506007)(8936002)(2906002)(8676002)(54906003)(5660300002)(52536014)(86362001)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: YMjeCm6T9yQEs45lggtzTUSW5zy6inJYK1CVqj5Xd5CaAxNMkANBVKyHKK7wR92+Fxn4pqaTYXZUPTlAYyPvLsPqYXatBRLZsg7QeAOT3PEG1hxJ8/Cd587yQYm7jHGN+OQDwANsB7yuE3Ag4Ueky9+2WPe15TFgsqVoQjLol1n9BvxTFYEGjK9ZZ3XbFlGDrUdM6k+/hqhF5eechrLQdwYT5np8Lq2S9lM2TmFFoww6WSziycqlKj8yxx1i/78MV4d3rwl5aoy0Ci+Zzeeb5TrefmzlSyhVC6vuG5jQzDEHQulcRTyZQKYLTDH3FHcp1TjselSya2ulyUnzu6AbGdOUindBb3fuyShKK+tbgAhcB7wEUIR3fdVrFbVwpB3mUBG2Tos2E5Pa2Q89FBHCZqoXxjAqWlblkze7J2CIgcOv3ioLZ3jhBEufgN9hfgAQpZ6n4xbvT5mJ1JsVf7hy6GPZHrcJGbcmhxxvHqKqunjwpmRb4l8KwGYdyMomeQyH+544BHzweErKew0j4ECF5hF+G6CDYFKipVi6PezHcPJC52tkN5/cTz9Jhags54EdIwHqvB97VpjqizvQl3GCg6de4J2Vlqt8AIb8qgwHsszgMioCN3ln5KCGJxQADgAwiI/eQlnBYr6MsUHKxzZUKQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7315.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55894b97-56d6-4823-1a74-08d886ead816
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2020 09:10:47.8004
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KxMey2HRw41oQEmIbmHAJvjLitLxCwMi36VKWS2CRwwN7Qgz5wlh1/AX7oIu2UOn6mdK/KIRO2D5Y0t8wPhm7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR0402MB3588
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

RnJvbTogR3JlZyBLSCA8Z3JlZ2toQGxpbnV4Zm91bmRhdGlvbi5vcmc+IFNlbnQ6IFRodXJzZGF5
LCBOb3ZlbWJlciAxMiwgMjAyMCA0OjQwIFBNDQo+IE9uIFdlZCwgTm92IDExLCAyMDIwIGF0IDEw
OjUxOjM2QU0gKzA4MDAsIEZ1Z2FuZyBEdWFuIHdyb3RlOg0KPiA+IEZvciBiZWxvdyBjb2RlLCB0
aGVyZSBoYXMgY2hhbmNlIHRvIGNhdXNlIGRlYWRsb2NrIGluIFNNUCBzeXN0ZW06DQo+ID4gVGhy
ZWFkIDE6DQo+ID4gY2xrX2VuYWJsZV9sb2NrKCk7DQo+ID4gcHJfaW5mbygiZGVidWcgbWVzc2Fn
ZSIpOw0KPiA+IGNsa19lbmFibGVfdW5sb2NrKCk7DQo+ID4NCj4gPiBUaHJlYWQgMjoNCj4gPiBp
bXhfdWFydF9jb25zb2xlX3dyaXRlKCkNCj4gPiAgICAgICBjbGtfZW5hYmxlKCkNCj4gPiAgICAg
ICAgICAgICAgIGNsa19lbmFibGVfbG9jaygpOw0KPiA+DQo+ID4gVGhyZWFkIDE6DQo+ID4gQWN1
aXJlZCBjbGsgZW5hYmxlX2xvY2sgLT4gcHJpbnRrIC0+IGNvbnNvbGVfdHJ5bG9ja19zcGlubmlu
ZyBUaHJlYWQNCj4gPiAyOg0KPiA+IGNvbnNvbGVfdW5sb2NrKCkgLT4gaW14X3VhcnRfY29uc29s
ZV93cml0ZSAtPiBjbGtfZGlzYWJsZSAtPiBBY3F1aXRlDQo+ID4gY2xrIGVuYWJsZV9sb2NrDQo+
ID4NCj4gPiBTbyB0aGUgcGF0Y2ggaXMgdG8ga2VlcCBjb25zb2xlIHBvcnQgY2xvY2tzIGFsd2F5
cyBvbiBsaWtlIG90aGVyDQo+ID4gY29uc29sZSBkcml2ZXJzLg0KPiA+DQo+ID4gRml4ZXM6IDFj
ZjkzZTBkNTQ4OCAoInNlcmlhbDogaW14OiByZW1vdmUgdGhlIHVhcnRfY29uc29sZSgpIGNoZWNr
IikNCj4gPiBTaWduZWQtb2ZmLWJ5OiBGdWdhbmcgRHVhbiA8ZnVnYW5nLmR1YW5AbnhwLmNvbT4N
Cj4gPiAtLS0NCj4gPiB2MjogQWRkIGZpeGVzIHRhZyBpbiBjb21taXQgbWVzc2FnZS4NCj4gPiAt
LS0NCj4gPiAgZHJpdmVycy90dHkvc2VyaWFsL2lteC5jIHwgMTkgKysrLS0tLS0tLS0tLS0tLS0t
LQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCAxNiBkZWxldGlvbnMoLSkN
Cj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3R0eS9zZXJpYWwvaW14LmMgYi9kcml2ZXJz
L3R0eS9zZXJpYWwvaW14LmMgaW5kZXgNCj4gPiAxNzMxZDk3Mjg4NjUuLjRkNmMwMDlkZGMzMSAx
MDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL3R0eS9zZXJpYWwvaW14LmMNCj4gPiArKysgYi9kcml2
ZXJzL3R0eS9zZXJpYWwvaW14LmMNCj4gPiBAQCAtMjAwNCwxNSArMjAwNCw2IEBAIGlteF91YXJ0
X2NvbnNvbGVfd3JpdGUoc3RydWN0IGNvbnNvbGUgKmNvLCBjb25zdA0KPiBjaGFyICpzLCB1bnNp
Z25lZCBpbnQgY291bnQpDQo+ID4gICAgICAgaW50IGxvY2tlZCA9IDE7DQo+ID4gICAgICAgaW50
IHJldHZhbDsNCj4gPg0KPiA+IC0gICAgIHJldHZhbCA9IGNsa19lbmFibGUoc3BvcnQtPmNsa19w
ZXIpOw0KPiA+IC0gICAgIGlmIChyZXR2YWwpDQo+ID4gLSAgICAgICAgICAgICByZXR1cm47DQo+
ID4gLSAgICAgcmV0dmFsID0gY2xrX2VuYWJsZShzcG9ydC0+Y2xrX2lwZyk7DQo+ID4gLSAgICAg
aWYgKHJldHZhbCkgew0KPiA+IC0gICAgICAgICAgICAgY2xrX2Rpc2FibGUoc3BvcnQtPmNsa19w
ZXIpOw0KPiA+IC0gICAgICAgICAgICAgcmV0dXJuOw0KPiA+IC0gICAgIH0NCj4gPiAtDQo+ID4g
ICAgICAgaWYgKHNwb3J0LT5wb3J0LnN5c3JxKQ0KPiA+ICAgICAgICAgICAgICAgbG9ja2VkID0g
MDsNCj4gPiAgICAgICBlbHNlIGlmIChvb3BzX2luX3Byb2dyZXNzKQ0KPiA+IEBAIC0yMDQ3LDkg
KzIwMzgsNiBAQCBpbXhfdWFydF9jb25zb2xlX3dyaXRlKHN0cnVjdCBjb25zb2xlICpjbywgY29u
c3QNCj4gPiBjaGFyICpzLCB1bnNpZ25lZCBpbnQgY291bnQpDQo+ID4NCj4gPiAgICAgICBpZiAo
bG9ja2VkKQ0KPiA+ICAgICAgICAgICAgICAgc3Bpbl91bmxvY2tfaXJxcmVzdG9yZSgmc3BvcnQt
PnBvcnQubG9jaywgZmxhZ3MpOw0KPiA+IC0NCj4gPiAtICAgICBjbGtfZGlzYWJsZShzcG9ydC0+
Y2xrX2lwZyk7DQo+ID4gLSAgICAgY2xrX2Rpc2FibGUoc3BvcnQtPmNsa19wZXIpOw0KPiA+ICB9
DQo+ID4NCj4gPiAgLyoNCj4gPiBAQCAtMjE1MCwxNSArMjEzOCwxNCBAQCBpbXhfdWFydF9jb25z
b2xlX3NldHVwKHN0cnVjdCBjb25zb2xlICpjbywNCj4gPiBjaGFyICpvcHRpb25zKQ0KPiA+DQo+
ID4gICAgICAgcmV0dmFsID0gdWFydF9zZXRfb3B0aW9ucygmc3BvcnQtPnBvcnQsIGNvLCBiYXVk
LCBwYXJpdHksIGJpdHMsDQo+ID4gZmxvdyk7DQo+ID4NCj4gPiAtICAgICBjbGtfZGlzYWJsZShz
cG9ydC0+Y2xrX2lwZyk7DQo+ID4gICAgICAgaWYgKHJldHZhbCkgew0KPiA+IC0gICAgICAgICAg
ICAgY2xrX3VucHJlcGFyZShzcG9ydC0+Y2xrX2lwZyk7DQo+ID4gKyAgICAgICAgICAgICBjbGtf
ZGlzYWJsZV91bnByZXBhcmUoc3BvcnQtPmNsa19pcGcpOw0KPiA+ICAgICAgICAgICAgICAgZ290
byBlcnJvcl9jb25zb2xlOw0KPiA+ICAgICAgIH0NCj4gPg0KPiA+IC0gICAgIHJldHZhbCA9IGNs
a19wcmVwYXJlKHNwb3J0LT5jbGtfcGVyKTsNCj4gPiArICAgICByZXR2YWwgPSBjbGtfcHJlcGFy
ZV9lbmFibGUoc3BvcnQtPmNsa19wZXIpOw0KPiA+ICAgICAgIGlmIChyZXR2YWwpDQo+ID4gLSAg
ICAgICAgICAgICBjbGtfdW5wcmVwYXJlKHNwb3J0LT5jbGtfaXBnKTsNCj4gPiArICAgICAgICAg
ICAgIGNsa19kaXNhYmxlX3VucHJlcGFyZShzcG9ydC0+Y2xrX2lwZyk7DQo+ID4NCj4gPiAgZXJy
b3JfY29uc29sZToNCj4gPiAgICAgICByZXR1cm4gcmV0dmFsOw0KPiA+IC0tDQo+ID4gMi4xNy4x
DQo+ID4NCj4gDQo+IERpZCB5b3UgdGVzdCBidWlsZCB0aGlzIGNoYW5nZSBhbmQgdG90YWxseSBp
Z25vcmUgdGhlIGJ1aWxkIHdhcm5pbmcgeW91IG5vdyBnZXQ6DQo+IA0KPiBkcml2ZXJzL3R0eS9z
ZXJpYWwvaW14LmM6IEluIGZ1bmN0aW9uIOKAmGlteF91YXJ0X2NvbnNvbGVfd3JpdGXigJk6DQo+
IGRyaXZlcnMvdHR5L3NlcmlhbC9pbXguYzoyMDExOjY6IHdhcm5pbmc6IHVudXNlZCB2YXJpYWJs
ZSDigJhyZXR2YWzigJkNCj4gWy1XdW51c2VkLXZhcmlhYmxlXQ0KPiAgMjAxMSB8ICBpbnQgcmV0
dmFsOw0KPiAgICAgICB8ICAgICAgXn5+fn5+DQo+IA0KPiBOb3QgZ29vZC4uLg0KPiANCj4gSSds
bCBnbyBmaXggaXQuDQo+IA0KPiBncmVnIGstaA0KDQpUaGFua3MsIEdyZWcsIEkgaWdub3JlIHRo
ZSBidWlsZCB3YXJuaW5nLg0KDQpBbmR5DQo=

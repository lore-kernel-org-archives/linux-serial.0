Return-Path: <SRS0=K8LB=D6=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A7CAC4363A
	for <linux-serial@archiver.kernel.org>; Fri, 23 Oct 2020 01:48:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B7DEB20E65
	for <linux-serial@archiver.kernel.org>; Fri, 23 Oct 2020 01:48:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ZT8lHcSP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S374392AbgJWBsy (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 22 Oct 2020 21:48:54 -0400
Received: from mail-eopbgr40055.outbound.protection.outlook.com ([40.107.4.55]:56708
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S374346AbgJWBsy (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 22 Oct 2020 21:48:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h1rtuHO9flIYTTqQdsy4/DDaF6dIiY4EE0Vb6r/uobtyTdRNqMVdjwRO42qs5cXoe+Mju7DG7WtM5IXJ5AQjWQhQlOkftupVIIbrXmEoD4TR/QCYwfFrjmbY6e/PuswN/20cdgKHwUDLotcet4GopjvqwD0Pez3d/HzytfZk9QI14FZ4RoD4nWdTq8VE8nxjo9AKEU6vEygbu+0UdMgmNIcXvHqkxHakyPds9k/YFHciGBY98klRomy4n1IoQC6tvFSIHevkpBm67P5ywMGuo8DKdmW1WVEuIBVKLt5ACizC7jb44hltBhFu/zAV1Gde8fM/BKe1ixJ/ml+4ZG07nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qo13FzgvNcBE78KTC749vPDwwIj5nsXfqamT99d3Lpk=;
 b=IusqdR+hgATaf2v8IxUnpzAPp35WCopPvfYZJxpB95u5oRf8x3qTShJTRtkJt+o//SvW3Hp4Vp8zRyhZVDjdw7xg/RtmV+x6/rEUi7N7PhjEY0rkLYsB7CZ8avujrXNVn9kfChvIs+WS+4uQM/KenjHQ06ltuWryFlUwOQj1JUjRk4GKrf4/0Z2+Yh6R+NCtTEqPLYvnUOHw0hVxMNN4u2LLt31sEWXm7Bhm/cm6cOUZXZV4UUvKeKD1wjPAxKAm6OawG4m9/z7iLiZE7138LTLOR1EoLBhplE62zT74lzgoVo1GEJwCxnMXV0Brj/yTImd2h2AJcJ2uFZ/KmAzliw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qo13FzgvNcBE78KTC749vPDwwIj5nsXfqamT99d3Lpk=;
 b=ZT8lHcSPhQqM0lqYtk6RbTMqYCH1clX0Oy2N4JLATw/VYV8NTRL9vgLwwJcy7UEv8dYqxGbGyggIHezHPHMi20wP3FUVf5JcM8zctHrbLtEvkynX0fr7x6csJceaRdErrSJs6Lsbico0zgfPrg3VvjGTDwLWI5Hx3Gn2jY9CI3A=
Received: from AM8PR04MB7315.eurprd04.prod.outlook.com (2603:10a6:20b:1d4::7)
 by AM0PR04MB5105.eurprd04.prod.outlook.com (2603:10a6:208:c6::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.21; Fri, 23 Oct
 2020 01:48:48 +0000
Received: from AM8PR04MB7315.eurprd04.prod.outlook.com
 ([fe80::11e6:d413:2d3d:d271]) by AM8PR04MB7315.eurprd04.prod.outlook.com
 ([fe80::11e6:d413:2d3d:d271%6]) with mapi id 15.20.3477.028; Fri, 23 Oct 2020
 01:48:48 +0000
From:   Andy Duan <fugang.duan@nxp.com>
To:     Vladimir Oltean <vladimir.oltean@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michael Walle <michael@walle.cc>, Peng Fan <peng.fan@nxp.com>
Subject: RE: [PATCH v2 tty] tty: serial: fsl_lpuart: LS1021A has a FIFO size
 of 16 words, like LS1028A
Thread-Topic: [PATCH v2 tty] tty: serial: fsl_lpuart: LS1021A has a FIFO size
 of 16 words, like LS1028A
Thread-Index: AQHWqNytgHBKhW5qV0y17FCyXjw+Iamka0ZQ
Date:   Fri, 23 Oct 2020 01:48:47 +0000
Message-ID: <AM8PR04MB7315545206E9F66BACBAE391FF1A0@AM8PR04MB7315.eurprd04.prod.outlook.com>
References: <20201023013429.3551026-1-vladimir.oltean@nxp.com>
In-Reply-To: <20201023013429.3551026-1-vladimir.oltean@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.67]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4afc7f65-7bf0-4506-e8d1-08d876f5c8d5
x-ms-traffictypediagnostic: AM0PR04MB5105:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB5105F55718064E024877EB56FF1A0@AM0PR04MB5105.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:525;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /CWlNAXOJYhTfFdVkFQv6OxaYujEe353ZwlztYy/HYZqdUdGaopFuNFD0Nz47tj4DvSBUCL+yQzFsdsmfokeMNghMjeKIk504XP5AO1I6p+L+ugjFPsnoCSC57dZ2fx4Aw2S2NDyFBlY7YsWB1DwwrdjC4Sr2uFEvaFBsvlipQX4Px3ySZZkAE9J/0P5loe1YT8iKIgHR2iGb51NgBe8pQ9V5q7NBKUjVwxtoDOe4f6SIySu1uWz8tb8DrXZSGdmsYSP1z8YnSJafA+vK4Fb8SZPh5ca+qrD9dAzRxdX8332w27HjIeB0NKsP+B/ED4fvtL4ROIUfTHQmt05PbIqrg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7315.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(396003)(136003)(376002)(366004)(39860400002)(66946007)(66446008)(66476007)(64756008)(316002)(76116006)(6506007)(9686003)(26005)(86362001)(5660300002)(66556008)(110136005)(8936002)(83380400001)(2906002)(55016002)(52536014)(6636002)(186003)(33656002)(8676002)(7696005)(478600001)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: xRxItUWjdWY+2DnD1RHjyFpxMDE1vjGJhRMeSguofti/AE2Nq0vd5NGoq9Iksp849aHUeg6/mM07eGM4Slda4qbnC4lMdIlJlBUcCrYnHAV+AOOfRoc29HRhw+P1qVOJ4zZgZ5gMQvI2PdH3W/h+GYVUxhMDu96md9efyTtBfhC4P1f1eE3rKcxjj+dfM2ZvmZV/ZM0bSPoCLiDsks8uCQKA7aWSoDjrr94Hi5xJG480aL46j+NWEar7zZC3NSFa22Mq76zHqIc1xjICRyf7vmiZYngoiYwinakWGTkOH6G6KWWAlmf/hBx/B6gXV7pwrYaFWQHKctBvj3+Im/Bwf5pQjtoWTaVHjijME+poaEQcA627483asZB7DXTSRduf5iCz8GQ0s9HWyCwI9G8NRA9I/ivzqnOSIrZcnGeaaKwMHAuGbMFlZj0NRqRWSfiLyHz0I9+fHhRFdidfRUUDeB27EVcMIi0wY9cM176QIGo8XPV6OAaLWuNkG5wgXrk11WYRvt8GSu40Tj74EUzCHNjcLIVHSjchZt4KhLRM/tnmN/8LaWAR8QsadngP8PJKY2X3R048agVG1sCfg6B9UHBOBAMqv/jsVXS49NR1R0ZH7L4kd06nEDxmYThXg+DujM5thoyD8WLHZ2UdvsELAA==
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7315.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4afc7f65-7bf0-4506-e8d1-08d876f5c8d5
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2020 01:48:48.0680
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rMJWJNDGDsnf9M8WMKucCviZP8AxZuw9SbUGI8jvILSQf8ZXpyCmKvZjYcp6TpRnS73FQ2Mhj9P51ldoMRDdEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5105
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

RnJvbTogVmxhZGltaXIgT2x0ZWFuIDx2bGFkaW1pci5vbHRlYW5AbnhwLmNvbT4gU2VudDogRnJp
ZGF5LCBPY3RvYmVyIDIzLCAyMDIwIDk6MzQgQU0NCj4gUHJpb3IgdG8gdGhlIGNvbW1pdCB0aGF0
IHRoaXMgb25lIGZpeGVzLCB0aGUgRklGTyBzaXplIHdhcyBkZXJpdmVkIGZyb20gdGhlDQo+IHJl
YWQtb25seSByZWdpc3RlciBMUFVBUlR4X0ZJRk9bVFhGSUZPU0laRV0gdXNpbmcgdGhlIGZvbGxv
d2luZw0KPiBmb3JtdWxhOg0KPiANCj4gVFggRklGTyBzaXplID0gMiBeIChMUFVBUlR4X0ZJRk9b
VFhGSUZPU0laRV0gLSAxKQ0KPiANCj4gVGhlIGRvY3VtZW50YXRpb24gZm9yIExTMTAyMUEgaXMg
YSBtZXNzLiBVbmRlciBjaGFwdGVyIDI2LjEuMyBMUzEwMjFBDQo+IExQVUFSVCBtb2R1bGUgc3Bl
Y2lhbCBjb25zaWRlcmF0aW9uLCBpdCBtZW50aW9ucyBUWEZJRk9fU1ogYW5kIFJYRklGT19TWg0K
PiBiZWluZyBlcXVhbCB0byA0LCBhbmQgaW4gdGhlIHJlZ2lzdGVyIGRlc2NyaXB0aW9uIGZvciBM
UFVBUlR4X0ZJRk8sIGl0IHNob3dzIHRoZQ0KPiBvdXQtb2YtcmVzZXQgdmFsdWUgb2YgVFhGSUZP
U0laRSBhbmQgUlhGSUZPU0laRSBmaWVsZHMgYXMgIjAxMSIsIGV2ZW4gdGhvdWdoDQo+IHRoZXNl
IHJlZ2lzdGVycyByZWFkIGFzICIxMDEiIGluIHJlYWxpdHkuDQo+IA0KPiBBbmQgd2hlbiBMUFVB
UlQgb24gTFMxMDIxQSB3YXMgd29ya2luZywgdGhlICIxMDEiIHZhbHVlIGRpZCBjb3JyZXNwb25k
IHRvDQo+ICIxNiBkYXRhd29yZHMiLCBieSBhcHBseWluZyB0aGUgZm9ybXVsYSBhYm92ZSwgZXZl
biB0aG91Z2ggdGhlDQo+IGRvY3VtZW50YXRpb24gaXMgd3JvbmcgYWdhaW4gKCEhISEpIGFuZCBz
YXlzIHRoYXQgIjEwMSIgbWVhbnMgNjQgZGF0YXdvcmRzDQo+IChoaW50OiBpdCBkb2Vzbid0KS4N
Cj4gDQo+IFNvIHRoZSAibmV3IiBmb3JtdWxhIGNyZWF0ZWQgYnkgY29tbWl0IGY3N2ViYjI0MWNl
MCBoYXMgYWxsIHRoZSBwcmVtaXNlcyBvZg0KPiBiZWluZyB3cm9uZyBmb3IgTFMxMDIxQSwgYmVj
YXVzZSBpdCByZWxpZWQgb25seSBvbiBmYWxzZSBkYXRhIGFuZCBubyBhY3R1YWwNCj4gZXhwZXJp
bWVudGF0aW9uLg0KPiANCj4gSW50ZXJlc3RpbmdseSwgaW4gY29tbWl0IGMyZjQ0OGNmZjIyYSAo
InR0eTogc2VyaWFsOiBmc2xfbHB1YXJ0OiBhZGQgTFMxMDI4QQ0KPiBzdXBwb3J0IiksIE1pY2hh
ZWwgV2FsbGUgYXBwbGllZCBhIHdvcmthcm91bmQgdG8gdGhpcyBieSBtYW51YWxseSBzZXR0aW5n
IHRoZQ0KPiBGSUZPIHdpZHRocyBmb3IgTFMxMDI4QS4gSXQgbG9va3MgbGlrZSB0aGUgc2FtZSB2
YWx1ZXMgYXJlIHVzZWQgYnkgTFMxMDIxQSBhcw0KPiB3ZWxsLCBpbiBmYWN0Lg0KPiANCj4gV2hl
biB0aGUgZHJpdmVyIHRoaW5rcyB0aGF0IGl0IGhhcyBhIGRlZXBlciBGSUZPIHRoYW4gaXQgcmVh
bGx5IGhhcywgZ2V0dHkgKHVzZXINCj4gc3BhY2UpIG91dHB1dCBnZXRzIHRydW5jYXRlZC4NCj4g
DQo+IE1hbnkgdGhhbmtzIHRvIE1pY2hhZWwgZm9yIHBvaW50aW5nIG91dCB3aGVyZSB0byBsb29r
Lg0KPiANCj4gRml4ZXM6IGY3N2ViYjI0MWNlMCAoInR0eTogc2VyaWFsOiBmc2xfbHB1YXJ0OiBj
b3JyZWN0IHRoZSBGSUZPIGRlcHRoIHNpemUiKQ0KPiBTdWdnZXN0ZWQtYnk6IE1pY2hhZWwgV2Fs
bGUgPG1pY2hhZWxAd2FsbGUuY2M+DQo+IFNpZ25lZC1vZmYtYnk6IFZsYWRpbWlyIE9sdGVhbiA8
dmxhZGltaXIub2x0ZWFuQG54cC5jb20+DQo+IC0tLQ0KPiBDaGFuZ2VzIGluIHYyOg0KPiBSZXdv
cmRlZCBjb21taXQgbWVzc2FnZS4NCg0KRm9yIHRoZSB2MiB3aXRoIGNvbW1pdCBtZXNzYWdlIGNo
YW5nZTogDQpSZXZpZXdlZC1ieaO6RnVnYW5nIER1YW4gPGZ1Z2FuZy5kdWFuQG54cC5jb20+DQo+
IA0KPiAgZHJpdmVycy90dHkvc2VyaWFsL2ZzbF9scHVhcnQuYyB8IDEzICsrKysrKystLS0tLS0N
Cj4gIDEgZmlsZSBjaGFuZ2VkLCA3IGluc2VydGlvbnMoKyksIDYgZGVsZXRpb25zKC0pDQo+IA0K
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy90dHkvc2VyaWFsL2ZzbF9scHVhcnQuYyBiL2RyaXZlcnMv
dHR5L3NlcmlhbC9mc2xfbHB1YXJ0LmMgaW5kZXgNCj4gZmY0Yjg4YzYzN2QwLi5iZDA0N2UxZjli
ZWEgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvdHR5L3NlcmlhbC9mc2xfbHB1YXJ0LmMNCj4gKysr
IGIvZHJpdmVycy90dHkvc2VyaWFsL2ZzbF9scHVhcnQuYw0KPiBAQCAtMzE0LDkgKzMxNCwxMCBA
QCBNT0RVTEVfREVWSUNFX1RBQkxFKG9mLCBscHVhcnRfZHRfaWRzKTsNCj4gIC8qIEZvcndhcmQg
ZGVjbGFyZSB0aGlzIGZvciB0aGUgZG1hIGNhbGxiYWNrcyovICBzdGF0aWMgdm9pZA0KPiBscHVh
cnRfZG1hX3R4X2NvbXBsZXRlKHZvaWQgKmFyZyk7DQo+IA0KPiAtc3RhdGljIGlubGluZSBib29s
IGlzX2xzMTAyOGFfbHB1YXJ0KHN0cnVjdCBscHVhcnRfcG9ydCAqc3BvcnQpDQo+ICtzdGF0aWMg
aW5saW5lIGJvb2wgaXNfbGF5ZXJzY2FwZV9scHVhcnQoc3RydWN0IGxwdWFydF9wb3J0ICpzcG9y
dCkNCj4gIHsNCj4gLQlyZXR1cm4gc3BvcnQtPmRldnR5cGUgPT0gTFMxMDI4QV9MUFVBUlQ7DQo+
ICsJcmV0dXJuIChzcG9ydC0+ZGV2dHlwZSA9PSBMUzEwMjFBX0xQVUFSVCB8fA0KPiArCQlzcG9y
dC0+ZGV2dHlwZSA9PSBMUzEwMjhBX0xQVUFSVCk7DQo+ICB9DQo+IA0KPiAgc3RhdGljIGlubGlu
ZSBib29sIGlzX2lteDhxeHBfbHB1YXJ0KHN0cnVjdCBscHVhcnRfcG9ydCAqc3BvcnQpIEBAIC0x
NzAxLDExDQo+ICsxNzAyLDExIEBAIHN0YXRpYyBpbnQgbHB1YXJ0MzJfc3RhcnR1cChzdHJ1Y3Qg
dWFydF9wb3J0ICpwb3J0KQ0KPiAgCQkJCQkgICAgVUFSVEZJRk9fRklGT1NJWkVfTUFTSyk7DQo+
IA0KPiAgCS8qDQo+IC0JICogVGhlIExTMTAyOEEgaGFzIGEgZml4ZWQgbGVuZ3RoIG9mIDE2IHdv
cmRzLiBBbHRob3VnaCBpdCBzdXBwb3J0cyB0aGUNCj4gLQkgKiBSWC9UWFNJWkUgZmllbGRzIHRo
ZWlyIGVuY29kaW5nIGlzIGRpZmZlcmVudC4gRWcgdGhlIHJlZmVyZW5jZSBtYW51YWwNCj4gLQkg
KiBzdGF0ZXMgMGIxMDEgaXMgMTYgd29yZHMuDQo+ICsJICogVGhlIExTMTAyMUEgYW5kIExTMTAy
OEEgaGF2ZSBhIGZpeGVkIEZJRk8gZGVwdGggb2YgMTYgd29yZHMuDQo+ICsJICogQWx0aG91Z2gg
dGhleSBzdXBwb3J0IHRoZSBSWC9UWFNJWkUgZmllbGRzLCB0aGVpciBlbmNvZGluZyBpcw0KPiAr
CSAqIGRpZmZlcmVudC4gRWcgdGhlIHJlZmVyZW5jZSBtYW51YWwgc3RhdGVzIDBiMTAxIGlzIDE2
IHdvcmRzLg0KPiAgCSAqLw0KPiAtCWlmIChpc19sczEwMjhhX2xwdWFydChzcG9ydCkpIHsNCj4g
KwlpZiAoaXNfbGF5ZXJzY2FwZV9scHVhcnQoc3BvcnQpKSB7DQo+ICAJCXNwb3J0LT5yeGZpZm9f
c2l6ZSA9IDE2Ow0KPiAgCQlzcG9ydC0+dHhmaWZvX3NpemUgPSAxNjsNCj4gIAkJc3BvcnQtPnBv
cnQuZmlmb3NpemUgPSBzcG9ydC0+dHhmaWZvX3NpemU7DQo+IC0tDQo+IDIuMjUuMQ0KDQo=

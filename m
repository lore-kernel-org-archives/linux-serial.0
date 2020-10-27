Return-Path: <SRS0=rQUO=EC=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F566C4363A
	for <linux-serial@archiver.kernel.org>; Tue, 27 Oct 2020 08:55:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C58A22258
	for <linux-serial@archiver.kernel.org>; Tue, 27 Oct 2020 08:55:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2509561AbgJ0IzQ (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 27 Oct 2020 04:55:16 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:2483 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730933AbgJ0IzQ (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 27 Oct 2020 04:55:16 -0400
Received: from DGGEMM406-HUB.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4CL5BZ1pL0zQkyQ;
        Tue, 27 Oct 2020 16:55:18 +0800 (CST)
Received: from dggema758-chm.china.huawei.com (10.1.198.200) by
 DGGEMM406-HUB.china.huawei.com (10.3.20.214) with Microsoft SMTP Server (TLS)
 id 14.3.487.0; Tue, 27 Oct 2020 16:54:59 +0800
Received: from dggema755-chm.china.huawei.com (10.1.198.197) by
 dggema758-chm.china.huawei.com (10.1.198.200) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Tue, 27 Oct 2020 16:54:58 +0800
Received: from dggema755-chm.china.huawei.com ([10.1.198.197]) by
 dggema755-chm.china.huawei.com ([10.1.198.197]) with mapi id 15.01.1913.007;
 Tue, 27 Oct 2020 16:54:58 +0800
From:   zhangqilong <zhangqilong3@huawei.com>
To:     =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= 
        <u.kleine-koenig@pengutronix.de>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "linux-imx@nxp.com" <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
Subject: =?utf-8?B?562U5aSNOiBbUEFUQ0ggLW5leHRdIHR0eTogc2VyaWFsOiBpbXg6IHJlbW92?=
 =?utf-8?Q?e_unnecessary_breaks?=
Thread-Topic: [PATCH -next] tty: serial: imx: remove unnecessary breaks
Thread-Index: AQHWq7YF/DlVG1G/CUaBiTKLyZ35CqmrI0NA
Date:   Tue, 27 Oct 2020 08:54:58 +0000
Message-ID: <e061702ccd9642c681d7d15c2e7fce7f@huawei.com>
References: <20201026125142.21105-1-zhangqilong3@huawei.com>
 <20201026163459.bnoxhmncnnf7cwca@pengutronix.de>
In-Reply-To: <20201026163459.bnoxhmncnnf7cwca@pengutronix.de>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.174.179.28]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

SGVsbG8NCg0KPiBPbiBNb24sIE9jdCAyNiwgMjAyMCBhdCAwODo1MTo0MlBNICswODAwLCBaaGFu
ZyBRaWxvbmcgd3JvdGU6DQo+ID4gVGhlICdicmVhaycgaXMgbm90IHBvc3NvYmxlIHRvIGJlIHJl
YWNoZWQNCj4gcy9wb3Nzb2JsZS9wb3NzaWJsZS8NCj4gDQo+ID4gYmVjYXVzZSBvZiBwcmV2aW91
cyAncmV0dXJuJywgZGlzY2FyZCBpdC4NCj4gDQo+IEdpdmVuIHRoYXQgdGhpcyBzdWNoIGEgcGF0
Y2ggd2FzIGFscmVhZHkgc2VudCBhIHdlZWsgYWdvWzFdLCBJIHdvbmRlciBpZiB0aGVyZQ0KPiBp
cyBhIHRvb2wgdGhhdCBjb21wbGFpbnMgaGVyZT8gSWYgc28sIG1lbnRpb25pbmcgaXQgaW4gdGhl
IGNvbW1pdCBsb2cgd291bGQgYmUNCj4gZ29vZC4NCj4gDQo+IE90aGVyIHRoYW4gdGhhdCBJIHN0
aWxsIHRoaW5rIHRoYXQgdGhlcmUgc2hvdWxkIGJlIGF0IGxlYXN0IGFuIGVtcHR5IGxpbmUgaW5z
dGVhZA0KPiBvZiB0aGUgYnJlYWssIGFzIEkgYWxyZWFkeSB3cm90ZSBpbiByZXBseSB0byB0aGUg
Zmlyc3QgcGF0Y2guIEFuZCBoYXZpbmcgc2FpZCB0aGF0IEkNCj4gYWxzbyBkb24ndCB0aGluayB0
aGlzIGlzIHdvcnRoICJmaXhpbmciLCBzZWVpbmcgdGhlIGJyZWFrIGluIGEgc3dpdGNoIHN0YXRl
bWVudCBpcw0KPiBnb29kIGZvciBodW1hbiByZWFkZXJzLg0KPiANCj4gQmVzdCByZWdhcmRzDQo+
IFV3ZQ0KDQpJIGhhdmUgc2VlbiB0aGF0IHBhdGNoLCB0aGFuayB5b3UgZm9yIG5pY2UgcmVtaW5k
aW5nLiBJdCdzIG5vdCBhIHRvb2wgdGlwLiBJIGZpbmQgaXQNCndoZW4gcmVhZGluZyB0aGF0IGNv
ZGUuIFNvIHNlbmRpbmcgdGhlIHBhdGNoIHRvIG9wdGltaXplIGl0LiBJdCBhbHNvIGxvb2tzIGdv
b2QNCnRvIGtlZXAgJ2JyZWFrJy4NClRoYW5rcywgYmVzdCB3aXNoIHRvIHlvdSENClpoYW5nIFFp
bG9uZw0KDQo+IA0KPiBbMV0gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvci8yMDIwMTAxOTE3NTkx
NS4zNzE4LTEtdHJpeEByZWRoYXQuY29tDQo+IC0tDQo+IFBlbmd1dHJvbml4IGUuSy4gICAgICAg
ICAgICAgICAgICAgICAgICAgICB8IFV3ZSBLbGVpbmUtS8O2bmlnDQo+IHwNCj4gSW5kdXN0cmlh
bCBMaW51eCBTb2x1dGlvbnMgICAgICAgICAgICAgICAgIHwgaHR0cHM6Ly93d3cucGVuZ3V0cm9u
aXguZGUvIHwNCg==

Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C14F5C433E0
	for <linux-serial@archiver.kernel.org>; Fri, 19 Mar 2021 06:37:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8EBC664F6D
	for <linux-serial@archiver.kernel.org>; Fri, 19 Mar 2021 06:37:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234027AbhCSGhL (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 19 Mar 2021 02:37:11 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:3372 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233970AbhCSGgo (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 19 Mar 2021 02:36:44 -0400
Received: from DGGEMM404-HUB.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4F1vHp3mMXz5db6;
        Fri, 19 Mar 2021 14:34:14 +0800 (CST)
Received: from dggemi712-chm.china.huawei.com (10.3.20.111) by
 DGGEMM404-HUB.china.huawei.com (10.3.20.212) with Microsoft SMTP Server (TLS)
 id 14.3.498.0; Fri, 19 Mar 2021 14:36:39 +0800
Received: from dggemi761-chm.china.huawei.com (10.1.198.147) by
 dggemi712-chm.china.huawei.com (10.3.20.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2106.2; Fri, 19 Mar 2021 14:36:39 +0800
Received: from dggemi761-chm.china.huawei.com ([10.9.49.202]) by
 dggemi761-chm.china.huawei.com ([10.9.49.202]) with mapi id 15.01.2106.013;
 Fri, 19 Mar 2021 14:36:39 +0800
From:   "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Johan Hovold <johan@kernel.org>,
        Finn Thain <fthain@telegraphics.com.au>
CC:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Linux Samsung SOC <linux-samsung-soc@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hector Martin <marcan@marcan.st>,
        "Arnd Bergmann" <arnd@kernel.org>
Subject: RE: [PATCH] tty: serial: samsung_tty: remove spinlock flags in
 interrupt handlers
Thread-Topic: [PATCH] tty: serial: samsung_tty: remove spinlock flags in
 interrupt handlers
Thread-Index: AQHXGcbz+WrshjNySUOLBee938cMg6qFzJyAgAAKqICABQXQgA==
Date:   Fri, 19 Mar 2021 06:36:39 +0000
Message-ID: <4771468d968a44789518bc547acf5f93@hisilicon.com>
References: <20210315181212.113217-1-krzysztof.kozlowski@canonical.com>
 <YFB0OcBg3Vj555eA@hovoldconsulting.com>
 <CAHp75VfcbC63t_eZeBOA0NY28BtGBD0YyLR6nSNuKAnKhXTSzA@mail.gmail.com>
In-Reply-To: <CAHp75VfcbC63t_eZeBOA0NY28BtGBD0YyLR6nSNuKAnKhXTSzA@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.203.211]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQW5keSBTaGV2Y2hlbmtv
IFttYWlsdG86YW5keS5zaGV2Y2hlbmtvQGdtYWlsLmNvbV0NCj4gU2VudDogVHVlc2RheSwgTWFy
Y2ggMTYsIDIwMjEgMTA6NDEgUE0NCj4gVG86IEpvaGFuIEhvdm9sZCA8am9oYW5Aa2VybmVsLm9y
Zz47IEZpbm4gVGhhaW4gPGZ0aGFpbkB0ZWxlZ3JhcGhpY3MuY29tLmF1PjsNCj4gU29uZyBCYW8g
SHVhIChCYXJyeSBTb25nKSA8c29uZy5iYW8uaHVhQGhpc2lsaWNvbi5jb20+DQo+IENjOiBLcnp5
c3p0b2YgS296bG93c2tpIDxrcnp5c3p0b2Yua296bG93c2tpQGNhbm9uaWNhbC5jb20+OyBHcmVn
DQo+IEtyb2FoLUhhcnRtYW4gPGdyZWdraEBsaW51eGZvdW5kYXRpb24ub3JnPjsgSmlyaSBTbGFi
eSA8amlyaXNsYWJ5QGtlcm5lbC5vcmc+Ow0KPiBsaW51eC1hcm0gTWFpbGluZyBMaXN0IDxsaW51
eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc+OyBMaW51eCBTYW1zdW5nDQo+IFNPQyA8
bGludXgtc2Ftc3VuZy1zb2NAdmdlci5rZXJuZWwub3JnPjsgb3BlbiBsaXN0OlNFUklBTCBEUklW
RVJTDQo+IDxsaW51eC1zZXJpYWxAdmdlci5rZXJuZWwub3JnPjsgTGludXggS2VybmVsIE1haWxp
bmcgTGlzdA0KPiA8bGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZz47IEhlY3RvciBNYXJ0aW4g
PG1hcmNhbkBtYXJjYW4uc3Q+OyBBcm5kDQo+IEJlcmdtYW5uIDxhcm5kQGtlcm5lbC5vcmc+DQo+
IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIHR0eTogc2VyaWFsOiBzYW1zdW5nX3R0eTogcmVtb3ZlIHNw
aW5sb2NrIGZsYWdzIGluDQo+IGludGVycnVwdCBoYW5kbGVycw0KPiANCj4gT24gVHVlLCBNYXIg
MTYsIDIwMjEgYXQgMTE6MDIgQU0gSm9oYW4gSG92b2xkIDxqb2hhbkBrZXJuZWwub3JnPiB3cm90
ZToNCj4gPg0KPiA+IE9uIE1vbiwgTWFyIDE1LCAyMDIxIGF0IDA3OjEyOjEyUE0gKzAxMDAsIEty
enlzenRvZiBLb3psb3dza2kgd3JvdGU6DQo+ID4gPiBTaW5jZSBpbnRlcnJ1cHQgaGFuZGxlciBp
cyBjYWxsZWQgd2l0aCBkaXNhYmxlZCBsb2NhbCBpbnRlcnJ1cHRzLCB0aGVyZQ0KPiA+ID4gaXMg
bm8gbmVlZCB0byB1c2UgdGhlIHNwaW5sb2NrIHByaW1pdGl2ZXMgZGlzYWJsaW5nIGludGVycnVw
dHMgYXMgd2VsbC4NCj4gPg0KPiA+IFRoaXMgaXNuJ3QgZ2VuZXJhbGx5IHRydWUgZHVlIHRvICJ0
aHJlYWRpcnFzIiBhbmQgdGhhdCBjYW4gbGVhZCB0bw0KPiA+IGRlYWRsb2NrcyBpZiB0aGUgY29u
c29sZSBjb2RlIGlzIGNhbGxlZCBmcm9tIGhhcmQgaXJxIGNvbnRleHQuDQo+ID4NCj4gPiBOb3cs
IHRoaXMgaXMgKm5vdCogdGhlIGNhc2UgZm9yIHRoaXMgcGFydGljdWxhciBkcml2ZXIgc2luY2Ug
aXQgZG9lc24ndA0KPiA+IGV2ZW4gYm90aGVyIHRvIHRha2UgdGhlIHBvcnQgbG9jayBpbiBjb25z
b2xlX3dyaXRlKCkuIFRoYXQgc2hvdWxkDQo+ID4gcHJvYmFibHkgYmUgZml4ZWQgaW5zdGVhZC4N
Cj4gPg0KPiA+IFNlZSBodHRwczovL2xvcmUua2VybmVsLm9yZy9yL1g3a3ZpaVJ3dXh2UHhDOE9A
bG9jYWxob3N0Lg0KPiANCj4gRmlubiwgQmFycnksIHNvbWV0aGluZyB0byBjaGVjayBJIHRoaW5r
Pw0KDQpNeSB1bmRlcnN0YW5kaW5nIGlzIHRoYXQgc3Bpbl9sb2NrX2lycXNhdmUgY2FuJ3QgcHJv
dGVjdCB0aGUgY29udGV4dA0KdGhlIGNvbnNvbGVfd3JpdGUoKSBpcyBjYWxsZWQgaW4gaGFyZGly
cSBmb3IgdGhyZWFkZWRfaXJxIGNhc2UgbWFpbmx5DQpmb3IgcHJlZW1wdC1ydCBzY2VuYXJpb3Mg
YXMgc3Bpbl9sb2NrX2lycXNhdmUgZG9lc24ndCBkaXNhYmxlIGlycSBpbg0KdGhhdCBjYXNlIGF0
IGFsbC4NClNlZToNCmh0dHBzOi8vd3d3Lmtlcm5lbC5vcmcvZG9jL2h0bWwvbGF0ZXN0L2xvY2tp
bmcvbG9ja3R5cGVzLmh0bWwNCnNwaW5sb2NrX3QgYW5kIFBSRUVNUFRfUlQNCk9uIGEgUFJFRU1Q
VF9SVCBrZXJuZWwgc3BpbmxvY2tfdCBpcyBtYXBwZWQgdG8gYSBzZXBhcmF0ZSBpbXBsZW1lbnRh
dGlvbg0KYmFzZWQgb24gcnRfbXV0ZXggd2hpY2ggY2hhbmdlcyB0aGUgc2VtYW50aWNzOg0KUHJl
ZW1wdGlvbiBpcyBub3QgZGlzYWJsZWQuDQpUaGUgaGFyZCBpbnRlcnJ1cHQgcmVsYXRlZCBzdWZm
aXhlcyBmb3Igc3Bpbl9sb2NrIC8gc3Bpbl91bmxvY2sgb3BlcmF0aW9ucw0KKF9pcnEsIF9pcnFz
YXZlIC8gX2lycXJlc3RvcmUpIGRvIG5vdCBhZmZlY3QgdGhlIENQVeKAmXMgaW50ZXJydXB0IGRp
c2FibGVkDQpzdGF0ZS4NCg0KU28gaWYgY29uc29sZV93cml0ZSgpIGNhbiBpbnRlcnJ1cHQgb3Vy
IGNvZGUgaW4gaGFyZGlycSwgd2Ugc2hvdWxkDQptb3ZlIHRvIHJhd19zcGluX2xvY2tfaXJxc2F2
ZSBmb3IgdGhpcyBkcml2ZXIuDQoNCkkgdGhpbmsgaXQgaXMgYWxtb3N0IGFsd2F5cyB3cm9uZyB0
byBjYWxsIHNwaW5fbG9ja19pcnFzYXZlIGluIGhhcmRpcnEuDQoNCj4gDQo+IC0tDQo+IFdpdGgg
QmVzdCBSZWdhcmRzLA0KPiBBbmR5IFNoZXZjaGVua28NCg0KVGhhbmtzDQpCYXJyeQ0K

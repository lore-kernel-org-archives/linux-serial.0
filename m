Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3BA1C6377D
	for <linux-serial@archiver.kernel.org>; Thu, 22 Jul 2021 09:04:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B8736108B
	for <linux-serial@archiver.kernel.org>; Thu, 22 Jul 2021 09:04:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230491AbhGVIX7 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 22 Jul 2021 04:23:59 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:52273 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S230330AbhGVIX6 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 22 Jul 2021 04:23:58 -0400
X-UUID: 91421b5c386f4357bc4539c6146e6a42-20210722
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=SUfFUHHeAiy7xHB0h/Imsj6WwwpQ9EOfIzx4JdwN/vE=;
        b=GsEi1ZINroU+gGMj6dryC39Rbo1RNYLRaqwQwRa0LNApMnhChyl7SeZGuskAbdw1md+HIFRXAHYanlY5Lprlu3hD2eQ5mKZUON8T3H5UvoCi3exy+VRuMLr+3ix9XAc4pNR/a7qfGhdi4bfO6UVuCGykz9NsH2ttTnRLp7qocx4=;
X-UUID: 91421b5c386f4357bc4539c6146e6a42-20210722
Received: from mtkcas35.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <zhiyong.tao@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1242842288; Thu, 22 Jul 2021 17:04:29 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS31N2.mediatek.inc
 (172.27.4.87) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 22 Jul
 2021 17:04:26 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 22 Jul 2021 17:04:25 +0800
Message-ID: <1626944665.29611.22.camel@mhfsdcap03>
Subject: Re: [PATCH] uart: mediatek: fix memory corruption issue
From:   zhiyong tao <zhiyong.tao@mediatek.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     "timur@kernel.org" <timur@kernel.org>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "alcooperx@gmail.com" <alcooperx@gmail.com>,
        "tklauser@distanz.ch" <tklauser@distanz.ch>,
        "sean.wang@kernel.org" <sean.wang@kernel.org>,
        "srv_heupstream@mediatek.com" <srv_heupstream@mediatek.com>,
        "hui.liu@mediatek.com" <hui.liu@mediatek.com>,
        "yuchen.huang@mediatek.com" <yuchen.huang@mediatek.com>,
        "huihui.wang@mediatek.com" <huihui.wang@mediatek.com>,
        "eddie.huang@mediatek.com" <eddie.huang@mediatek.com>,
        "sean.wang@mediatek.com" <sean.wang@mediatek.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
Date:   Thu, 22 Jul 2021 17:04:25 +0800
In-Reply-To: <CAHp75VeZL53VN0w3O160vMurmRT9ZJzJek6=4X6osqjJDuxD3g@mail.gmail.com>
References: <20210710090103.2643-1-zhiyong.tao@mediatek.com>
         <20210710090103.2643-2-zhiyong.tao@mediatek.com>
         <CAHp75VeZL53VN0w3O160vMurmRT9ZJzJek6=4X6osqjJDuxD3g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 807C9821DB6278E61EADEB2C44AB602CE8CBB4FB77B86B8C8DCE9240BB9B9AA02000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

T24gV2VkLCAyMDIxLTA3LTE0IGF0IDAxOjIwICswMzAwLCBBbmR5IFNoZXZjaGVua28gd3JvdGU6
DQo+IA0KPiANCj4gT24gU2F0dXJkYXksIEp1bHkgMTAsIDIwMjEsIFpoaXlvbmcgVGFvIDx6aGl5
b25nLnRhb0BtZWRpYXRlay5jb20+DQo+IHdyb3RlOg0KPiANCj4gDQo+IFBsZWFzZSwgdXNlIOKA
nHNlcmlhbDogODI2MF9tdGs64oCdIHByZWZpeC4NCg0KPT0+IEhpIEFuZHksDQoNClRoYW5rcyBm
b3IgeW91ciBzdWdnZXN0aW9uLg0Kd2Ugd2lsbCBjaGFuZ2UgaXQgaW4gdGhlIG5leHQgdmVyc2lv
bi4NCj4gDQo+ICAgICAgICAgVGhpcyBwYXRjaCBpcyB1c2VkIHRvIGZpeCBtZW1vcnkgDQo+ICAg
ICAgICAgDQo+IA0KPiANCj4gVGhpcyBpcyBjb21wbGV0ZWx5IGNvbmZ1c2luZyBzdGFydCBvZiB0
aGUgc2VudGVuY2UuIFRoZSBmb3JtIG9mIOKAnGJlDQo+IHVzZWQgdG/igJ0gc3Ryb25nbHkgc3Vn
Z2VzdHMgdHdvIHRoaW5nczogMSkgaXQgd2FzIGEgcGF0Y2ggdG8gZml4DQo+IHNvbWV0aGluZzsg
MikgaXQgaXMgbm90IHVzZWQgYW55bW9yZSBhbmQgbmV2ZXIgY29uc2lkZXJlZCB0byBiZSB1c2Vk
DQo+IGFnYWluLA0KPiANCj4gDQo+IEJlc2lkZXMgdGhhdCBTdWJtaXR0aW5nIFBhdGNoZXMgZG9j
dW1lbnQgaGlnaGx5IHJlY29tbWVuZHMgdG8gYXZvaWQNCj4gc2VudGVuY2VzIHRoYXQgc3RhcnRz
IHdpdGgg4oCcdGhpcyBwYXRjaOKAnS4NCj4gIA0KDQo9PT5XZSB3aWxsIGNoYW5nZSB0aGUgY29t
bWl0IG1lc3NhZ2UgYXMgIkZpeCB1YXJ0IGNvcnJ1cHRpb24gaXNzdWUgd2hlbg0KcnggcG93ZXIg
b2ZmICJpbiB0aGUgbmV4dCB2ZXJzaW9uLg0KDQpUaGFua3MuDQo+ICAgICAgICAgDQo+ICAgICAg
ICAgY29ycnVwdGlvbiBpc3N1ZSB3aGVuIHJ4IHBvd2VyIG9mZi4NCj4gICAgICAgICAxLiBhZGQg
c3BpbiBsb2NrIGluIG10azgyNTBfZG1hX3J4X2NvbXBsZXRlIGZ1bmN0aW9uIGluIEFQRE1BDQo+
ICAgICAgICAgbW9kZS4NCj4gICAgICAgICAyLiBhZGQgcHJvY2Vzc2luZyBtZWNoYW5pc20gd2hp
Y2ggY291bnQgdmFsdWUgaXMgMA0KPiAgICAgICAgIA0KPiAgICAgICAgIFNpZ25lZC1vZmYtYnk6
IFpoaXlvbmcgVGFvIDx6aGl5b25nLnRhb0BtZWRpYXRlay5jb20+DQo+ICAgICAgICAgLS0tDQo+
ICAgICAgICAgIGRyaXZlcnMvdHR5L3NlcmlhbC84MjUwLzgyNTBfbXRrLmMgfCAxNSArKysrKysr
KysrKy0tLS0NCj4gICAgICAgICAgMSBmaWxlIGNoYW5nZWQsIDExIGluc2VydGlvbnMoKyksIDQg
ZGVsZXRpb25zKC0pDQo+ICAgICAgICAgDQo+ICAgICAgICAgZGlmZiAtLWdpdCBhL2RyaXZlcnMv
dHR5L3NlcmlhbC84MjUwLzgyNTBfbXRrLmMNCj4gICAgICAgICBiL2RyaXZlcnMvdHR5L3Nlcmlh
bC84MjUwLzgyNTBfbXRrLmMNCj4gICAgICAgICBpbmRleCBmN2QzMDIzZjg2MGYuLjA5ZjdkMjE2
NjMxNSAxMDA2NDQNCj4gICAgICAgICAtLS0gYS9kcml2ZXJzL3R0eS9zZXJpYWwvODI1MC84MjUw
X210ay5jDQo+ICAgICAgICAgKysrIGIvZHJpdmVycy90dHkvc2VyaWFsLzgyNTAvODI1MF9tdGsu
Yw0KPiAgICAgICAgIEBAIC05MSwxMiArOTEsMTUgQEAgc3RhdGljIHZvaWQgbXRrODI1MF9kbWFf
cnhfY29tcGxldGUodm9pZA0KPiAgICAgICAgICpwYXJhbSkNCj4gICAgICAgICAgICAgICAgIHN0
cnVjdCBtdGs4MjUwX2RhdGEgKmRhdGEgPSB1cC0+cG9ydC5wcml2YXRlX2RhdGE7DQo+ICAgICAg
ICAgICAgICAgICBzdHJ1Y3QgdHR5X3BvcnQgKnR0eV9wb3J0ID0gJnVwLT5wb3J0LnN0YXRlLT5w
b3J0Ow0KPiAgICAgICAgICAgICAgICAgc3RydWN0IGRtYV90eF9zdGF0ZSBzdGF0ZTsNCj4gICAg
ICAgICAtICAgICAgIGludCBjb3BpZWQsIHRvdGFsLCBjbnQ7DQo+ICAgICAgICAgKyAgICAgICB1
bnNpZ25lZCBpbnQgY29waWVkLCB0b3RhbCwgY250Ow0KPiAgICAgICAgICAgICAgICAgdW5zaWdu
ZWQgY2hhciAqcHRyOw0KPiAgICAgICAgICsgICAgICAgdW5zaWduZWQgbG9uZyBmbGFnczsNCj4g
ICAgICAgICANCj4gICAgICAgICAgICAgICAgIGlmIChkYXRhLT5yeF9zdGF0dXMgPT0gRE1BX1JY
X1NIVVRET1dOKQ0KPiAgICAgICAgICAgICAgICAgICAgICAgICByZXR1cm47DQo+ICAgICAgICAg
DQo+ICAgICAgICAgKyAgICAgICBzcGluX2xvY2tfaXJxc2F2ZSgmdXAtPnBvcnQubG9jaywgZmxh
Z3MpOw0KPiAgICAgICAgICsNCj4gICAgICAgICAgICAgICAgIGRtYWVuZ2luZV90eF9zdGF0dXMo
ZG1hLT5yeGNoYW4sIGRtYS0+cnhfY29va2llLA0KPiAgICAgICAgICZzdGF0ZSk7DQo+ICAgICAg
ICAgICAgICAgICB0b3RhbCA9IGRtYS0+cnhfc2l6ZSAtIHN0YXRlLnJlc2lkdWU7DQo+ICAgICAg
ICAgICAgICAgICBjbnQgPSB0b3RhbDsNCj4gICAgICAgICBAQCAtMTA0LDkgKzEwNywxMSBAQCBz
dGF0aWMgdm9pZCBtdGs4MjUwX2RtYV9yeF9jb21wbGV0ZSh2b2lkDQo+ICAgICAgICAgKnBhcmFt
KQ0KPiAgICAgICAgICAgICAgICAgaWYgKChkYXRhLT5yeF9wb3MgKyBjbnQpID4gZG1hLT5yeF9z
aXplKQ0KPiAgICAgICAgICAgICAgICAgICAgICAgICBjbnQgPSBkbWEtPnJ4X3NpemUgLSBkYXRh
LT5yeF9wb3M7DQo+ICAgICAgICAgDQo+ICAgICAgICAgLSAgICAgICBwdHIgPSAodW5zaWduZWQg
Y2hhciAqKShkYXRhLT5yeF9wb3MgKyBkbWEtPnJ4X2J1Zik7DQo+ICAgICAgICAgLSAgICAgICBj
b3BpZWQgPSB0dHlfaW5zZXJ0X2ZsaXBfc3RyaW5nKHR0eV9wb3J0LCBwdHIsIGNudCk7DQo+ICAg
ICAgICAgLSAgICAgICBkYXRhLT5yeF9wb3MgKz0gY250Ow0KPiAgICAgICAgICsgICAgICAgaWYg
KGNudCAhPSAwKSB7DQo+ICAgICAgICAgKyAgICAgICAgICAgICAgIHB0ciA9ICh1bnNpZ25lZCBj
aGFyICopKGRhdGEtPnJ4X3BvcyArDQo+ICAgICAgICAgZG1hLT5yeF9idWYpOw0KPiAgICAgICAg
ICsgICAgICAgICAgICAgICBjb3BpZWQgPSB0dHlfaW5zZXJ0X2ZsaXBfc3RyaW5nKHR0eV9wb3J0
LCBwdHIsDQo+ICAgICAgICAgY250KTsNCj4gICAgICAgICArICAgICAgICAgICAgICAgZGF0YS0+
cnhfcG9zICs9IGNudDsNCj4gICAgICAgICArICAgICAgIH0NCj4gICAgICAgICANCj4gICAgICAg
ICAgICAgICAgIGlmICh0b3RhbCA+IGNudCkgew0KPiAgICAgICAgICAgICAgICAgICAgICAgICBw
dHIgPSAodW5zaWduZWQgY2hhciAqKShkbWEtPnJ4X2J1Zik7DQo+ICAgICAgICAgQEAgLTEyMCw2
ICsxMjUsOCBAQCBzdGF0aWMgdm9pZCBtdGs4MjUwX2RtYV9yeF9jb21wbGV0ZSh2b2lkDQo+ICAg
ICAgICAgKnBhcmFtKQ0KPiAgICAgICAgICAgICAgICAgdHR5X2ZsaXBfYnVmZmVyX3B1c2godHR5
X3BvcnQpOw0KPiAgICAgICAgIA0KPiAgICAgICAgICAgICAgICAgbXRrODI1MF9yeF9kbWEodXAp
Ow0KPiAgICAgICAgICsNCj4gICAgICAgICArICAgICAgIHNwaW5fdW5sb2NrX2lycXJlc3RvcmUo
JnVwLT5wb3J0LmxvY2ssIGZsYWdzKTsNCj4gICAgICAgICAgfQ0KPiAgICAgICAgIA0KPiAgICAg
ICAgICBzdGF0aWMgdm9pZCBtdGs4MjUwX3J4X2RtYShzdHJ1Y3QgdWFydF84MjUwX3BvcnQgKnVw
KQ0KPiANCj4gDQo=


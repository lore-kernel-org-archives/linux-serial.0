Return-Path: <SRS0=S7Zs=76=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30C56C433DF
	for <linux-serial@archiver.kernel.org>; Wed, 17 Jun 2020 03:58:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED3992080D
	for <linux-serial@archiver.kernel.org>; Wed, 17 Jun 2020 03:58:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="pABTy1T7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726568AbgFQD6a (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 16 Jun 2020 23:58:30 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:15607 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726321AbgFQD6a (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 16 Jun 2020 23:58:30 -0400
X-UUID: 9563a1485b674d7a911fd7c9099772aa-20200617
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=J8u4UWY2G4d5/E7DWKw+p+qbm1PghnIow5Vag4ifkTE=;
        b=pABTy1T7Xcoou7TOVVET4AwChQc0Yj+mqREDzs2EHOoR3jYdXvGFPNkAs9XeFyHBfo68UXTN2OVL6eBoSeu7NFN7aK4/lU/HPHKwH4XIMWlTentiBsnj/VedVQHPjpeIGV5skLauQ7tHn/pHmnE8BRAzs77W84oZf9o7E9lrSx8=;
X-UUID: 9563a1485b674d7a911fd7c9099772aa-20200617
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 960733527; Wed, 17 Jun 2020 11:58:23 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs02n1.mediatek.inc (172.21.101.77) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 17 Jun 2020 11:58:21 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 17 Jun 2020 11:58:21 +0800
From:   <sean.wang@mediatek.com>
To:     <andy.shevchenko@gmail.com>
CC:     <andriy.shevchenko@linux.intel.com>, <gregkh@linuxfoundation.org>,
        <steven.liu@mediatek.com>, <arnd@arndb.de>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <Ryder.Lee@mediatek.com>,
        <sean.wang@mediatek.com>, <tthayer@opensource.altera.com>,
        <linux-serial@vger.kernel.org>, <jslaby@suse.com>,
        <matthias.bgg@gmail.com>, <sr@denx.de>,
        <mika.westerberg@linux.intel.com>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v3] tty: serial: don't do termios for BTIF
Date:   Wed, 17 Jun 2020 11:58:20 +0800
Message-ID: <1592366300-29503-1-git-send-email-sean.wang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <CAHp75VdSvE9RPq3V8LTVX7OjaYs1PThVi2f1roh3p5EY_k0ANA@mail.gmail.com>
References: <CAHp75VdSvE9RPq3V8LTVX7OjaYs1PThVi2f1roh3p5EY_k0ANA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

RnJvbTogU2VhbiBXYW5nIDxzZWFuLndhbmdAbWVkaWF0ZWsuY29tPg0KDQo+Pg0KPj4gRnJvbTog
U2VhbiBXYW5nIDxzZWFuLndhbmdAbWVkaWF0ZWsuY29tPg0KPj4NCj4+IEJsdWV0b290aCBJbnRl
cmZhY2UgKEJUSUYpIGlzIGRlc2lnbmVkIGRlZGljYXRlZGx5IGZvciBNZWRpYVRlayBTT0MNCj4+
IHdpdGggQlQgaW4gb3JkZXIgdG8gYmUgaW5zdGVhZCBvZiB0aGUgVUFSVCBpbnRlcmZhY2UgYmV0
d2VlbiBCVCBtb2R1bGUNCj4+IGFuZCBIb3N0IENQVSwgYW5kIG5vdCBleHBvcnRlZCB0byB1c2Vy
IHNwYWNlIHRvIGFjY2Vzcy4NCj4+DQo+PiBBcyB0aGUgVUFSVCBkZXNpZ24sIEJUSUYgd2lsbCBi
ZSBhbiBBUEIgc2xhdmUgYW5kIGNhbiB0cmFuc21pdCBvcg0KPj4gcmVjZWl2ZSBkYXRhIGJ5IE1D
VSBhY2Nlc3MsIGJ1dCBkb2Vzbid0IHByb3ZpZGUgdGVybWlvcyBmdW5jdGlvbiBsaWtlDQo+PiBi
YXVkcmF0ZSBhbmQgZmxvdyBjb250cm9sIHNldHVwLg0KPj4NCj4+IEV2ZW4gTENSIG9uIG9mZnNl
dCAweEMgdGhhdCBpcyBqdXN0IGEgRkFLRUxDUiBhLiBJZiBGQUtFTENSWzddIGlzDQo+PiBlcXVh
bGVkIHRvIDEsIFJCUigweDAwKSwgVEhSKDB4MDApLCBJRVIoMHgwNCkNCj4+ICAgIHdpbGwgbm90
IGJlIHJlYWRhYmxlL3dyaXRhYmxlLg0KPj4NCj4+IGIuIElmIEZBS0VMQ1IgaXMgZXF1YWxlZCB0
byAweEJGLCBSQlIoMHgwMCksIFRIUigweDAwKSwgSUVSKDB4MDQpLA0KPj4gICAgSUlSKDB4MDgp
LCBhbmQgTFNSKDB4MTQpIHdpbGwgbm90IGJlIHJlYWRhYmxlL3dyaXRhYmxlLg0KPj4NCj4+IFNv
IGFkZGluZyBhIG5ldyBjYXBhYmlsaXR5ICdVQVJUX0NBUF9OVElPJyBmb3IgdGhlIHVudXN1YWwg
dW5zdXBwb3J0ZWQNCj4+IGNhc2UuDQo+Pg0KPj4gRml4ZXM6IDFjMTZhZTY1ZTI1MCAoInNlcmlh
bDogODI1MDogb2Y6IEFkZCBuZXcgcG9ydCB0eXBlIGZvciBNZWRpYVRlaw0KPj4gQlRJRiBjb250
cm9sbGVyIG9uIE1UNzYyMi8yMyBTb0MiKQ0KPj4gQ2M6IFN0ZXZlbiBMaXUgPHN0ZXZlbi5saXVA
bWVkaWF0ZWsuY29tPg0KPg0KPj4gU3VnZ2VzdGVkLWJ5OiBBbmR5IFNoZXZjaGVua28gPGFuZHJp
eS5zaGV2Y2hlbmtvQGxpbnV4LmludGVsLmNvbT4NCj4NCj5JIGRpZG4ndCBzdWdnZXN0IHRoaXMg
Y2hhbmdlLiBJIG9ubHkgY29tbWVudGVkIG9uIHRoZSBuYW1lIG9mIHRoZSBtYWNyby4NCg0KbXkg
ZmF1bHQuIGkgd2lsbCByZW1vdmUgdGhlIHRhZyBmcm9tIG5leHQgdmVyc2lvbi4NCg0KPg0KPj4g
U2lnbmVkLW9mZi1ieTogU2VhbiBXYW5nIDxzZWFuLndhbmdAbWVkaWF0ZWsuY29tPg0KPj4gU2ln
bmVkLW9mZi1ieTogUnlkZXIgTGVlIDxyeWRlci5sZWVAbWVkaWF0ZWsuY29tPg0KPj4NCj4+IC0t
DQo=


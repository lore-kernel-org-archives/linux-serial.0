Return-Path: <SRS0=y+wj=BI=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E555FC433E0
	for <linux-serial@archiver.kernel.org>; Wed, 29 Jul 2020 08:03:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C232E2084D
	for <linux-serial@archiver.kernel.org>; Wed, 29 Jul 2020 08:03:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="NS8yLb9s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727788AbgG2IDA (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 29 Jul 2020 04:03:00 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:8782 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726797AbgG2IDA (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 29 Jul 2020 04:03:00 -0400
X-UUID: fc4db75c07b146e58e1087cc745a45f9-20200729
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=teICIrkV7sOQV3jPEavLyrRW/vZEh5lh1RgTjnP7gJE=;
        b=NS8yLb9s0Hs5bWKTdVCbzC3ZjyxNZ66JXyMBObdxZPpo0RyJhJ9FRp1tIWcNDf2n+mnhmkRlWZUpseFAjKCMb5E6M9BOLpL/gozawbdXirXlTG55ABNPZFcJqLXTI+Thql5hw4EURws1/qFqIFakwOzxG3vd9UDpA2mdNqD5rsU=;
X-UUID: fc4db75c07b146e58e1087cc745a45f9-20200729
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1080694864; Wed, 29 Jul 2020 16:02:57 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 29 Jul 2020 16:02:54 +0800
Received: from [172.21.77.4] (172.21.77.4) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 29 Jul 2020 16:02:55 +0800
Message-ID: <1596009775.12468.6.camel@mtksdaap41>
Subject: Re: [PATCH v3 1/3] arm64: dts: Add Mediatek SoC MT8192 and
 evaluation board dts and Makefile
From:   CK Hu <ck.hu@mediatek.com>
To:     Seiya Wang <seiya.wang@mediatek.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "Daniel Lezcano" <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        <devicetree@vger.kernel.org>, <srv_heupstream@mediatek.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-serial@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Date:   Wed, 29 Jul 2020 16:02:55 +0800
In-Reply-To: <20200729013100.19539-2-seiya.wang@mediatek.com>
References: <20200729013100.19539-1-seiya.wang@mediatek.com>
         <20200729013100.19539-2-seiya.wang@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 5B75A061824025819F6C2CAD15E5F4863A2B7D6837702194A55A34624A6820D12000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

SGksIFNlaXlhOg0KDQpPbiBXZWQsIDIwMjAtMDctMjkgYXQgMDk6MzAgKzA4MDAsIFNlaXlhIFdh
bmcgd3JvdGU6DQo+IEFkZCBiYXNpYyBjaGlwIHN1cHBvcnQgZm9yIE1lZGlhdGVrIE1UODE5Mg0K
PiANCj4gU2lnbmVkLW9mZi1ieTogU2VpeWEgV2FuZyA8c2VpeWEud2FuZ0BtZWRpYXRlay5jb20+
DQo+IC0tLQ0KPiAgYXJjaC9hcm02NC9ib290L2R0cy9tZWRpYXRlay9NYWtlZmlsZSAgICAgICB8
ICAgMSArDQo+ICBhcmNoL2FybTY0L2Jvb3QvZHRzL21lZGlhdGVrL210ODE5Mi1ldmIuZHRzIHwg
IDI5ICsrDQo+ICBhcmNoL2FybTY0L2Jvb3QvZHRzL21lZGlhdGVrL210ODE5Mi5kdHNpICAgIHwg
NjcxICsrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4gIDMgZmlsZXMgY2hhbmdlZCwgNzAx
IGluc2VydGlvbnMoKykNCj4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBhcmNoL2FybTY0L2Jvb3QvZHRz
L21lZGlhdGVrL210ODE5Mi1ldmIuZHRzDQo+ICBjcmVhdGUgbW9kZSAxMDA2NDQgYXJjaC9hcm02
NC9ib290L2R0cy9tZWRpYXRlay9tdDgxOTIuZHRzaQ0KPiANCg0KW3NuaXBdDQoNCj4gKw0KPiAr
CQl3YXRjaGRvZzogd2F0Y2hkb2dAMTAwMDcwMDAgew0KPiArCQkJY29tcGF0aWJsZSA9ICJtZWRp
YXRlayxtdDY1ODktd2R0IjsNCg0KQWNjb3JkaW5nIHRvIFsxXSBhbmQgWzJdLCBjb21wYXRpYmxl
IHN0cmluZyBmb3IgbXQ4MTkyIHdhdGNoIGRvZyBzaG91bGQNCmJlICJtZWRpYXRlayxtdDY4NzMt
d2R0IiwibWVkaWF0ZWssbXQ4MTkyLXdkdCIuDQoNCg0KWzFdDQpodHRwczovL2Nocm9taXVtLXJl
dmlldy5nb29nbGVzb3VyY2UuY29tL2MvY2hyb21pdW1vcy90aGlyZF9wYXJ0eS9rZXJuZWwvKy8y
Mjg3MDkwLzEyDQpbMl0NCmh0dHBzOi8vY2hyb21pdW0tcmV2aWV3Lmdvb2dsZXNvdXJjZS5jb20v
Yy9jaHJvbWl1bW9zL3RoaXJkX3BhcnR5L2tlcm5lbC8rLzIxMzE1OTgvMTgNCg0KPiArCQkJcmVn
ID0gPDAgMHgxMDAwNzAwMCAwIDB4MTAwPjsNCj4gKwkJCSNyZXNldC1jZWxscyA9IDwxPjsNCj4g
KwkJfTsNCj4gKw0KDQpbc25pcF0NCg0KPiArDQo+ICsJCW1tc3lzOiBtbXN5c0AxNDAwMDAwMCB7
DQo+ICsJCQljb21wYXRpYmxlID0gIm1lZGlhdGVrLG10ODE5Mi1tbXN5cyIsICJzeXNjb24iOw0K
DQpZb3Ugc2hvdWxkIGRlZmluZSAibWVkaWF0ZWssbXQ4MTkyLW1tc3lzIiBmaXJzdCwgdGhlbiB5
b3UgY291bGQgdXNlIGl0DQppbiB0aGlzIHBhdGNoLg0KDQpSZWdhcmRzLA0KQ0sNCg0KPiArCQkJ
cmVnID0gPDAgMHgxNDAwMDAwMCAwIDB4MTAwMD47DQo+ICsJCQkjY2xvY2stY2VsbHMgPSA8MT47
DQo+ICsJCX07DQo+ICsNCg0K


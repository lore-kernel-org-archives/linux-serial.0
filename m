Return-Path: <SRS0=y+wj=BI=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE5D7C433DF
	for <linux-serial@archiver.kernel.org>; Wed, 29 Jul 2020 08:10:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9FD72070B
	for <linux-serial@archiver.kernel.org>; Wed, 29 Jul 2020 08:10:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="loBW/c/M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726707AbgG2IK2 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 29 Jul 2020 04:10:28 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:39155 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726476AbgG2IK1 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 29 Jul 2020 04:10:27 -0400
X-UUID: 80cd8d0062d14291b6ab20d84c6dcfff-20200729
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=bR10KbXtzajag+49gYfd5nFZ5Eo9nw+6eYZQAA/1I/c=;
        b=loBW/c/M6WOL8dxdgrA+B6w/h6kUziukhtD7os2FiGPEF1Q8jDK8lCQJ/osHxilBSnBrD7Fv79D2v7i5OBT196lRTBlyL/tQwKC1FQzcfgURyuaCM5GqFOBYbowixpNySzFmqkPMXRqAOCRQvC35mlA5NykEpLF+YCaFPuoUVBo=;
X-UUID: 80cd8d0062d14291b6ab20d84c6dcfff-20200729
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1580035275; Wed, 29 Jul 2020 16:10:22 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 29 Jul 2020 16:10:20 +0800
Received: from [172.21.77.4] (172.21.77.4) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 29 Jul 2020 16:10:20 +0800
Message-ID: <1596010221.23124.2.camel@mtksdaap41>
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
Date:   Wed, 29 Jul 2020 16:10:21 +0800
In-Reply-To: <1596009775.12468.6.camel@mtksdaap41>
References: <20200729013100.19539-1-seiya.wang@mediatek.com>
         <20200729013100.19539-2-seiya.wang@mediatek.com>
         <1596009775.12468.6.camel@mtksdaap41>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

SGksIFNlaXlhOg0KDQpPbiBXZWQsIDIwMjAtMDctMjkgYXQgMTY6MDIgKzA4MDAsIENLIEh1IHdy
b3RlOg0KPiBIaSwgU2VpeWE6DQo+IA0KPiBPbiBXZWQsIDIwMjAtMDctMjkgYXQgMDk6MzAgKzA4
MDAsIFNlaXlhIFdhbmcgd3JvdGU6DQo+ID4gQWRkIGJhc2ljIGNoaXAgc3VwcG9ydCBmb3IgTWVk
aWF0ZWsgTVQ4MTkyDQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTogU2VpeWEgV2FuZyA8c2VpeWEu
d2FuZ0BtZWRpYXRlay5jb20+DQo+ID4gLS0tDQo+ID4gIGFyY2gvYXJtNjQvYm9vdC9kdHMvbWVk
aWF0ZWsvTWFrZWZpbGUgICAgICAgfCAgIDEgKw0KPiA+ICBhcmNoL2FybTY0L2Jvb3QvZHRzL21l
ZGlhdGVrL210ODE5Mi1ldmIuZHRzIHwgIDI5ICsrDQo+ID4gIGFyY2gvYXJtNjQvYm9vdC9kdHMv
bWVkaWF0ZWsvbXQ4MTkyLmR0c2kgICAgfCA2NzEgKysrKysrKysrKysrKysrKysrKysrKysrKysr
Kw0KPiA+ICAzIGZpbGVzIGNoYW5nZWQsIDcwMSBpbnNlcnRpb25zKCspDQo+ID4gIGNyZWF0ZSBt
b2RlIDEwMDY0NCBhcmNoL2FybTY0L2Jvb3QvZHRzL21lZGlhdGVrL210ODE5Mi1ldmIuZHRzDQo+
ID4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBhcmNoL2FybTY0L2Jvb3QvZHRzL21lZGlhdGVrL210ODE5
Mi5kdHNpDQo+ID4gDQo+IA0KPiBbc25pcF0NCj4gDQo+ID4gKw0KPiA+ICsJCXdhdGNoZG9nOiB3
YXRjaGRvZ0AxMDAwNzAwMCB7DQo+ID4gKwkJCWNvbXBhdGlibGUgPSAibWVkaWF0ZWssbXQ2NTg5
LXdkdCI7DQo+IA0KPiBBY2NvcmRpbmcgdG8gWzFdIGFuZCBbMl0sIGNvbXBhdGlibGUgc3RyaW5n
IGZvciBtdDgxOTIgd2F0Y2ggZG9nIHNob3VsZA0KPiBiZSAibWVkaWF0ZWssbXQ2ODczLXdkdCIs
Im1lZGlhdGVrLG10ODE5Mi13ZHQiLg0KPiANCj4gDQo+IFsxXQ0KPiBodHRwczovL2Nocm9taXVt
LXJldmlldy5nb29nbGVzb3VyY2UuY29tL2MvY2hyb21pdW1vcy90aGlyZF9wYXJ0eS9rZXJuZWwv
Ky8yMjg3MDkwLzEyDQo+IFsyXQ0KPiBodHRwczovL2Nocm9taXVtLXJldmlldy5nb29nbGVzb3Vy
Y2UuY29tL2MvY2hyb21pdW1vcy90aGlyZF9wYXJ0eS9rZXJuZWwvKy8yMTMxNTk4LzE4DQo+IA0K
PiA+ICsJCQlyZWcgPSA8MCAweDEwMDA3MDAwIDAgMHgxMDA+Ow0KPiA+ICsJCQkjcmVzZXQtY2Vs
bHMgPSA8MT47DQo+ID4gKwkJfTsNCj4gPiArDQo+IA0KPiBbc25pcF0NCj4gDQo+ID4gKw0KPiA+
ICsJCW1tc3lzOiBtbXN5c0AxNDAwMDAwMCB7DQo+ID4gKwkJCWNvbXBhdGlibGUgPSAibWVkaWF0
ZWssbXQ4MTkyLW1tc3lzIiwgInN5c2NvbiI7DQo+IA0KPiBZb3Ugc2hvdWxkIGRlZmluZSAibWVk
aWF0ZWssbXQ4MTkyLW1tc3lzIiBmaXJzdCwgdGhlbiB5b3UgY291bGQgdXNlIGl0DQo+IGluIHRo
aXMgcGF0Y2gNCg0KU29ycnksIHRoaXMgc2VyaWVzIGRlcGVuZCBvbiBbMV0sIGJ1dCBtbXN5cyBp
cyBhIHN5c2Nvbiwgc28gdGhpcyBzaG91bGQNCmJlDQoNCm1tc3lzOiBzeXNjb25AMTQwMDAwMDAg
ew0KDQpbMV0NCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL3BpcGVybWFpbC9saW51eC1tZWRp
YXRlay8yMDIwLUp1bHkvMDE0NDUxLmh0bWwNCg0KUmVnYXJkcywNCkNLDQo+IC4NCj4gDQo+IFJl
Z2FyZHMsDQo+IENLDQo+IA0KPiA+ICsJCQlyZWcgPSA8MCAweDE0MDAwMDAwIDAgMHgxMDAwPjsN
Cj4gPiArCQkJI2Nsb2NrLWNlbGxzID0gPDE+Ow0KPiA+ICsJCX07DQo+ID4gKw0KPiANCg0K


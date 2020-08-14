Return-Path: <SRS0=xWBg=BY=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87A1AC433DF
	for <linux-serial@archiver.kernel.org>; Fri, 14 Aug 2020 06:05:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6747420774
	for <linux-serial@archiver.kernel.org>; Fri, 14 Aug 2020 06:05:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="EpPtzf1/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726570AbgHNGFO (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 14 Aug 2020 02:05:14 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:6490 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726151AbgHNGFO (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 14 Aug 2020 02:05:14 -0400
X-UUID: c2426f0e5bd0429e87435e36841a485c-20200814
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=59u+JK0JHUadSuGfbkt82SozCQVQXwbTzzJ5U+21lKY=;
        b=EpPtzf1/K4O8uhlmeSgnyBnAiP4JkGvhHQMAYFps8g/N8F+PTvyKdFetylow5WXAezi0GuAtoxW656e0W+IaaA59RZW1FsdttXBdWzXmVxkMmE7YRhRjvKmWrsPaBhlKkcQqc39lwzfyHudBqKjJVQZrsbFDNiTrUgu+vXO/RQU=;
X-UUID: c2426f0e5bd0429e87435e36841a485c-20200814
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw01.mediatek.com
        (envelope-from <seiya.wang@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1459197204; Fri, 14 Aug 2020 14:05:09 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 14 Aug 2020 14:05:06 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 14 Aug 2020 14:05:06 +0800
From:   Seiya Wang <seiya.wang@mediatek.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
CC:     <linux-serial@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <srv_heupstream@mediatek.com>
Subject: [PATCH v4 0/4] Add basic node support for Mediatek MT8192 SoC 
Date:   Fri, 14 Aug 2020 14:04:51 +0800
Message-ID: <20200814060454.32200-1-seiya.wang@mediatek.com>
X-Mailer: git-send-email 2.14.1
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

TVQ4MTkyIGlzIGEgU29DIGJhc2VkIG9uIDY0Yml0IEFSTXY4IGFyY2hpdGVjdHVyZS4NCkl0IGNv
bnRhaW5zIDQgQ0E1NSBhbmQgNCBDQTc2IGNvcmVzLg0KTVQ4MTkyIHNoYXJlIG1hbnkgSFcgSVAg
d2l0aCBNVDY1eHggc2VyaWVzLg0KVGhpcyBwYXRjaHNldCB3YXMgdGVzdGVkIG9uIE1UODE5MiBl
dmFsdWF0aW9uIGJvYXJkIGFuZCB1c2UgY29ycmVjdCBjbG9jayB0byBzaGUNCmxsLg0KDQpCYXNl
ZCBvbiB2NS44LXJjMQ0KDQpDaGFuZ2UgaW4gdjQ6DQoxLiBSZW1vdmUgc2Nwc3lzLCBzcG1pIGFu
ZCBhcHUgbm9kZXMNCjIuIEFkZCBpMmMgbm9kZXMNCjMuIFVwZGF0ZSB3YXRjaGRvZyBiaW5kaW5n
DQo0LiBVcGRhdGUgZGVwZW5kZW5jeSBsaXN0DQoNCkNoYW5nZSBpbiB2MzoNCkZpeCB0eXBvIGlu
IGJpbmRpbmcgZG9jdW1lbnQgb2YgdGltZXINCg0KQ2hhbmdlIGluIHYyOg0KMS4gUmVtb3ZlIG10
ODE5Mi1wb3dlci5oIGZyb20gbXQ4MTkyLmR0c2kgd2hpY2ggaXMgbm90IHVzZWQgeWV0DQoyLiBB
ZGQgdGltZXIgYmluZGluZyBkb2N1bWVudCBhbmQgZGV2aWNlIHRyZWUgbm9kZSBpbiBtdDgxOTIu
ZHRzaQ0KMy4gUmVtb3ZlIHdhdGNoZG9nIGRyaXZlciBtb2RpZmljYXRpb24NCg0KU2VpeWEgV2Fu
ZyAoMyk6DQogIGFybTY0OiBkdHM6IEFkZCBNZWRpYXRlayBTb0MgTVQ4MTkyIGFuZCBldmFsdWF0
aW9uIGJvYXJkIGR0cyBhbmQNCiAgICBNYWtlZmlsZQ0KICBkdC1iaW5kaW5nczogc2VyaWFsOiBB
ZGQgY29tcGF0aWJsZSBmb3IgTWVkaWF0ZWsgTVQ4MTkyDQogIGR0LWJpbmRpbmdzOiB0aW1lcjog
QWRkIGNvbXBhdGlibGUgZm9yIE1lZGlhdGVrIE1UODE5Mg0KLS0tDQpUaGlzIHBhdGNoIGRlcGVu
ZHMgb24NCltQQVRDSCB2MiAxLzNdIGR0LWJpbmRpbmdzOiBwaW5jdHJsOiBtdDgxOTI6IGFkZCBw
aW5jdHJsIGZpbGUNCltQQVRDSCB2MiAyLzNdIGR0LWJpbmRpbmdzOiBwaW5jdHJsOiBtdDgxOTI6
IGFkZCBiaW5kaW5nIGRvY3VtZW50DQpbUEFUQ0ggdjIgMy80XSBkdC1iaW5kaW5nczogbWVkaWF0
ZWs6IGFkZCBjb21wYXRpYmxlIGZvciBNVDY4NzMvODE5MiBwd3JhcA0KW1BBVENIIHYyIDEvMl0g
ZHQtYmluZGluZ3M6IHNwaTogdXBkYXRlIGJpbmRpbmdzIGZvciBNVDgxOTIgU29DDQpbUEFUQ0gg
Mi80XSBjbGs6IG1lZGlhdGVrOiBBZGQgZHQtYmluZGluZ3MgZm9yIE1UODE5MiBjbG9ja3MNCltQ
QVRDSCB2MiAxLzVdIGR0LWJpbmRpbmdzOiBBUk06IE1lZGlhdGVrOiBEb2N1bWVudCBiaW5kaW5n
cyBmb3IgTVQ4MTkyDQpbdjQsMy81XSBkdC1iaW5kaW5nOiBtZWRpYXRlazogbXQ4MTkyOiB1cGRh
dGUgbXRrLXdkdCBkb2N1bWVudA0KDQpQbGVhc2UgYWxzbyBhY2NlcHQgdGhpcyBwYXRjaCB0b2dl
dGhlciB3aXRoIFsxXVsyXVszXVs0XVs1XVs2XQ0KdG8gYXZvaWQgYnVpbGQgYW5kIGR0IGJpbmRp
bmcgY2hlY2sgZXJyb3IuDQoNClsxXSBodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9waXBlcm1h
aWwvbGludXgtbWVkaWF0ZWsvMjAyMC1BdWd1c3QvMDE1MDAyLmh0bWwNClsyXSBodHRwOi8vbGlz
dHMuaW5mcmFkZWFkLm9yZy9waXBlcm1haWwvbGludXgtbWVkaWF0ZWsvMjAyMC1BdWd1c3QvMDE1
MDA1Lmh0bWwNClszXSBodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9waXBlcm1haWwvbGludXgt
bWVkaWF0ZWsvMjAyMC1KdWx5LzAxNDU0Ni5odG1sDQpbNF0gaHR0cDovL2xpc3RzLmluZnJhZGVh
ZC5vcmcvcGlwZXJtYWlsL2xpbnV4LW1lZGlhdGVrLzIwMjAtSnVseS8wMTQ0MDYuaHRtbA0KWzVd
IGh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL3BpcGVybWFpbC9saW51eC1tZWRpYXRlay8yMDIw
LUp1bHkvMDE0NDUwLmh0bWwNCls2XSBodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9waXBlcm1h
aWwvbGludXgtbWVkaWF0ZWsvMjAyMC1KdWx5LzAxNDg5OC5odG1sDQpbN10gaHR0cDovL2xpc3Rz
LmluZnJhZGVhZC5vcmcvcGlwZXJtYWlsL2xpbnV4LW1lZGlhdGVrLzIwMjAtQXVndXN0LzAxNTA0
Ni5odG1sDQotLS0NCiAuLi4vZGV2aWNldHJlZS9iaW5kaW5ncy9zZXJpYWwvbXRrLXVhcnQudHh0
ICAgICAgICB8ICAgMSArDQogLi4uL2RldmljZXRyZWUvYmluZGluZ3Mvd2F0Y2hkb2cvbXRrLXdk
dC50eHQgICAgICAgfCAgIDIgKw0KIGFyY2gvYXJtNjQvYm9vdC9kdHMvbWVkaWF0ZWsvTWFrZWZp
bGUgICAgICAgICAgICAgIHwgICAxICsNCiBhcmNoL2FybTY0L2Jvb3QvZHRzL21lZGlhdGVrL210
ODE5Mi1ldmIuZHRzICAgICAgICB8ICAyOSArDQogYXJjaC9hcm02NC9ib290L2R0cy9tZWRpYXRl
ay9tdDgxOTIuZHRzaSAgICAgICAgICAgfCA2NjMgKysrKysrKysrKysrKysrKysrKysrDQogZHJp
dmVycy93YXRjaGRvZy9tdGtfd2R0LmMgICAgICAgICAgICAgICAgICAgICAgICAgfCAgIDUgKw0K
IDYgZmlsZXMgY2hhbmdlZCwgNzAxIGluc2VydGlvbnMoKykNCiBjcmVhdGUgbW9kZSAxMDA2NDQg
YXJjaC9hcm02NC9ib290L2R0cy9tZWRpYXRlay9tdDgxOTItZXZiLmR0cw0KIGNyZWF0ZSBtb2Rl
IDEwMDY0NCBhcmNoL2FybTY0L2Jvb3QvZHRzL21lZGlhdGVrL210ODE5Mi5kdHNpDQoNCi0tDQoy
LjE0LjE=


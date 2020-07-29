Return-Path: <SRS0=y+wj=BI=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4851C433DF
	for <linux-serial@archiver.kernel.org>; Wed, 29 Jul 2020 01:31:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6DD622078E
	for <linux-serial@archiver.kernel.org>; Wed, 29 Jul 2020 01:31:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="dx5aLlvV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730117AbgG2BbW (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 28 Jul 2020 21:31:22 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:54258 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729918AbgG2BbV (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 28 Jul 2020 21:31:21 -0400
X-UUID: c79d844e8a934fc197d75254acafe880-20200729
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=/9UU7kgDikfzGReMi+cNjBDucNreiMt14wXF0POFEPc=;
        b=dx5aLlvVKSR4U6Vitr9BRul4UseAsLFfRDrayvo6SlAvJqZXA9k7C1tVETYky1NfDBPWuYGYXTAH2yjEba4PaMJbbDGOJ0uBV1ANRlc6s/6IOwfDU3HYes2MQVO30SCGyh48UT6oL6LiQ2k+wU4NW6IejQ7iNwXk9k4sgrWSP3g=;
X-UUID: c79d844e8a934fc197d75254acafe880-20200729
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <seiya.wang@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 997106648; Wed, 29 Jul 2020 09:31:19 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 29 Jul 2020 09:31:17 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 29 Jul 2020 09:31:17 +0800
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
Subject: [PATCH v3 0/3] Add basic node support for Mediatek MT8192 SoC 
Date:   Wed, 29 Jul 2020 09:30:57 +0800
Message-ID: <20200729013100.19539-1-seiya.wang@mediatek.com>
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
ZCBvbiB2NS44LXJjMQ0KDQpDaGFuZ2UgaW4gdjM6DQpGaXggdHlwbyBpbiBiaW5kaW5nIGRvY3Vt
ZW50IG9mIHRpbWVyDQoNCkNoYW5nZSBpbiB2MjoNCjEuIFJlbW92ZSBtdDgxOTItcG93ZXIuaCBm
cm9tIG10ODE5Mi5kdHNpIHdoaWNoIGlzIG5vdCB1c2VkIHlldA0KMi4gQWRkIHRpbWVyIGJpbmRp
bmcgZG9jdW1lbnQgYW5kIGRldmljZSB0cmVlIG5vZGUgaW4gbXQ4MTkyLmR0c2kNCjMuIFJlbW92
ZSB3YXRjaGRvZyBkcml2ZXIgbW9kaWZpY2F0aW9uDQoNClNlaXlhIFdhbmcgKDMpOg0KICBhcm02
NDogZHRzOiBBZGQgTWVkaWF0ZWsgU29DIE1UODE5MiBhbmQgZXZhbHVhdGlvbiBib2FyZCBkdHMg
YW5kDQogICAgTWFrZWZpbGUNCiAgZHQtYmluZGluZ3M6IHNlcmlhbDogQWRkIGNvbXBhdGlibGUg
Zm9yIE1lZGlhdGVrIE1UODE5Mg0KICBkdC1iaW5kaW5nczogdGltZXI6IEFkZCBjb21wYXRpYmxl
IGZvciBNZWRpYXRlayBNVDgxOTINCi0tLQ0KVGhpcyBwYXRjaCBkZXBlbmRzIG9uDQpbUEFUQ0gg
MS8zXSBkdC1iaW5kaW5nczogcGluY3RybDogbXQ4MTkyOiBhZGQgcGluY3RybCBmaWxlDQpbUEFU
Q0ggMi8zXSBkdC1iaW5kaW5nczogcGluY3RybDogbXQ4MTkyOiBhZGQgYmluZGluZyBkb2N1bWVu
dA0KW1BBVENIIHYyIDMvNF0gZHQtYmluZGluZ3M6IG1lZGlhdGVrOiBhZGQgY29tcGF0aWJsZSBm
b3IgTVQ2ODczLzgxOTIgcHdyYXANCltQQVRDSCB2MiAxLzJdIGR0LWJpbmRpbmdzOiBzcGk6IHVw
ZGF0ZSBiaW5kaW5ncyBmb3IgTVQ4MTkyIFNvQw0KW1BBVENIIDIvNF0gY2xrOiBtZWRpYXRlazog
QWRkIGR0LWJpbmRpbmdzIGZvciBNVDgxOTIgY2xvY2tzDQpbUEFUQ0ggMS80XSBkdC1iaW5kaW5n
czogQVJNOiBNZWRpYXRlazogRG9jdW1lbnQgYmluZGluZ3MgZm9yIE1UODE5Mg0KDQpQbGVhc2Ug
YWxzbyBhY2NlcHQgdGhpcyBwYXRjaCB0b2dldGhlciB3aXRoIFsxXVsyXVszXVs0XVs1XVs2XQ0K
dG8gYXZvaWQgYnVpbGQgYW5kIGR0IGJpbmRpbmcgY2hlY2sgZXJyb3IuDQoNClsxXSBodHRwOi8v
bGlzdHMuaW5mcmFkZWFkLm9yZy9waXBlcm1haWwvbGludXgtbWVkaWF0ZWsvMjAyMC1KdWx5LzAx
NDA0Mi5odG1sDQpbMl0gaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvcGlwZXJtYWlsL2xpbnV4
LW1lZGlhdGVrLzIwMjAtSnVseS8wMTQwNDMuaHRtbA0KWzNdIGh0dHA6Ly9saXN0cy5pbmZyYWRl
YWQub3JnL3BpcGVybWFpbC9saW51eC1tZWRpYXRlay8yMDIwLUp1bHkvMDE0NTQ2Lmh0bWwNCls0
XSBodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9waXBlcm1haWwvbGludXgtbWVkaWF0ZWsvMjAy
MC1KdWx5LzAxNDQwNi5odG1sDQpbNV0gaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvcGlwZXJt
YWlsL2xpbnV4LW1lZGlhdGVrLzIwMjAtSnVseS8wMTQ0NTAuaHRtbA0KWzZdIGh0dHA6Ly9saXN0
cy5pbmZyYWRlYWQub3JnL3BpcGVybWFpbC9saW51eC1tZWRpYXRlay8yMDIwLUp1bHkvMDE0NDUx
Lmh0bWwNCi0tLQ0KIC4uLi9kZXZpY2V0cmVlL2JpbmRpbmdzL3NlcmlhbC9tdGstdWFydC50eHQg
ICAgICAgIHwgICAxICsNCiAuLi4vYmluZGluZ3MvdGltZXIvbWVkaWF0ZWssbXRrLXRpbWVyLnR4
dCAgICAgICAgICB8ICAgMSArDQogYXJjaC9hcm02NC9ib290L2R0cy9tZWRpYXRlay9NYWtlZmls
ZSAgICAgICAgICAgICAgfCAgIDEgKw0KIGFyY2gvYXJtNjQvYm9vdC9kdHMvbWVkaWF0ZWsvbXQ4
MTkyLWV2Yi5kdHMgICAgICAgIHwgIDI5ICsNCiBhcmNoL2FybTY0L2Jvb3QvZHRzL21lZGlhdGVr
L210ODE5Mi5kdHNpICAgICAgICAgICB8IDY3MSArKysrKysrKysrKysrKysrKysrKysNCiA1IGZp
bGVzIGNoYW5nZWQsIDcwMyBpbnNlcnRpb25zKCspDQogY3JlYXRlIG1vZGUgMTAwNjQ0IGFyY2gv
YXJtNjQvYm9vdC9kdHMvbWVkaWF0ZWsvbXQ4MTkyLWV2Yi5kdHMNCiBjcmVhdGUgbW9kZSAxMDA2
NDQgYXJjaC9hcm02NC9ib290L2R0cy9tZWRpYXRlay9tdDgxOTIuZHRzaQ0KDQotLQ0KMi4xNC4x
DQo=


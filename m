Return-Path: <SRS0=Ntbd=BH=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0799AC433EA
	for <linux-serial@archiver.kernel.org>; Tue, 28 Jul 2020 13:42:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DBA332074F
	for <linux-serial@archiver.kernel.org>; Tue, 28 Jul 2020 13:42:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="kWMkaN1R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730175AbgG1NmQ (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 28 Jul 2020 09:42:16 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:8138 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730069AbgG1NmP (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 28 Jul 2020 09:42:15 -0400
X-UUID: ae3bb83e4618489dae9c64226dfb1f47-20200728
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=bjEJpsQTJche0VDVAIsDUpUZ2H8kXX1SWDr+bc6c22E=;
        b=kWMkaN1RdigKxERCuNili1vIlQuxfhJ8R4SdRN1o0ac/Xpv2NEqMiTE8YZCcwyj+ekGlMKXCjXtgkPfGzAexrHm09t5PpHwAg3vUj4Z2hYcEbSW2kmb0VKLtHLgghyfNz+ZBpICONWlTjQS5ha18hfaS8+tweiMTQyLfhDaiGEk=;
X-UUID: ae3bb83e4618489dae9c64226dfb1f47-20200728
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <seiya.wang@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 42973550; Tue, 28 Jul 2020 21:42:10 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 28 Jul 2020 21:42:06 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 28 Jul 2020 21:42:06 +0800
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
Subject: [PATCH v2 0/3] Add basic node support for Mediatek MT8192 SoC 
Date:   Tue, 28 Jul 2020 21:41:46 +0800
Message-ID: <20200728134149.19758-1-seiya.wang@mediatek.com>
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
ZCBvbiB2NS44LXJjMQ0KDQpDaGFuZ2UgaW4gdjI6DQoxLiBSZW1vdmUgbXQ4MTkyLXBvd2VyLmgg
ZnJvbSBtdDgxOTIuZHRzaSB3aGljaCBpcyBub3QgdXNlZCB5ZXQNCjIuIEFkZCB0aW1lciBiaW5k
aW5nIGRvY3VtZW50IGFuZCBkZXZpY2UgdHJlZSBub2RlIGluIG10ODE5Mi5kdHNpDQozLiBSZW1v
dmUgd2F0Y2hkb2cgZHJpdmVyIG1vZGlmaWNhdGlvbg0KDQpTZWl5YSBXYW5nICgzKToNCiAgYXJt
NjQ6IGR0czogQWRkIE1lZGlhdGVrIFNvQyBNVDgxOTIgYW5kIGV2YWx1YXRpb24gYm9hcmQgZHRz
IGFuZA0KICAgIE1ha2VmaWxlDQogIGR0LWJpbmRpbmdzOiBzZXJpYWw6IEFkZCBjb21wYXRpYmxl
IGZvciBNZWRpYXRlayBNVDgxOTINCiAgZHQtYmluZGluZ3M6IHRpbWVyOiBBZGQgY29tcGF0aWJs
ZSBmb3IgTWVkaWF0ZWsgTVQ4MTkyDQotLS0NClRoaXMgcGF0Y2ggZGVwZW5kcyBvbg0KW1BBVENI
IDEvM10gZHQtYmluZGluZ3M6IHBpbmN0cmw6IG10ODE5MjogYWRkIHBpbmN0cmwgZmlsZQ0KW1BB
VENIIDIvM10gZHQtYmluZGluZ3M6IHBpbmN0cmw6IG10ODE5MjogYWRkIGJpbmRpbmcgZG9jdW1l
bnQNCltQQVRDSCB2MiAzLzRdIGR0LWJpbmRpbmdzOiBtZWRpYXRlazogYWRkIGNvbXBhdGlibGUg
Zm9yIE1UNjg3My84MTkyIHB3cmFwDQpbUEFUQ0ggdjIgMS8yXSBkdC1iaW5kaW5nczogc3BpOiB1
cGRhdGUgYmluZGluZ3MgZm9yIE1UODE5MiBTb0MNCltQQVRDSCAyLzRdIGNsazogbWVkaWF0ZWs6
IEFkZCBkdC1iaW5kaW5ncyBmb3IgTVQ4MTkyIGNsb2Nrcw0KW1BBVENIIDEvNF0gZHQtYmluZGlu
Z3M6IEFSTTogTWVkaWF0ZWs6IERvY3VtZW50IGJpbmRpbmdzIGZvciBNVDgxOTINCg0KUGxlYXNl
IGFsc28gYWNjZXB0IHRoaXMgcGF0Y2ggdG9nZXRoZXIgd2l0aCBbMV1bMl1bM11bNF1bNV1bNl0N
CnRvIGF2b2lkIGJ1aWxkIGFuZCBkdCBiaW5kaW5nIGNoZWNrIGVycm9yLg0KDQpbMV0gaHR0cDov
L2xpc3RzLmluZnJhZGVhZC5vcmcvcGlwZXJtYWlsL2xpbnV4LW1lZGlhdGVrLzIwMjAtSnVseS8w
MTQwNDIuaHRtbA0KWzJdIGh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL3BpcGVybWFpbC9saW51
eC1tZWRpYXRlay8yMDIwLUp1bHkvMDE0MDQzLmh0bWwNClszXSBodHRwOi8vbGlzdHMuaW5mcmFk
ZWFkLm9yZy9waXBlcm1haWwvbGludXgtbWVkaWF0ZWsvMjAyMC1KdWx5LzAxNDU0Ni5odG1sDQpb
NF0gaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvcGlwZXJtYWlsL2xpbnV4LW1lZGlhdGVrLzIw
MjAtSnVseS8wMTQ0MDYuaHRtbA0KWzVdIGh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL3BpcGVy
bWFpbC9saW51eC1tZWRpYXRlay8yMDIwLUp1bHkvMDE0NDUwLmh0bWwNCls2XSBodHRwOi8vbGlz
dHMuaW5mcmFkZWFkLm9yZy9waXBlcm1haWwvbGludXgtbWVkaWF0ZWsvMjAyMC1KdWx5LzAxNDQ1
MS5odG1sDQotLS0NCiAuLi4vZGV2aWNldHJlZS9iaW5kaW5ncy9zZXJpYWwvbXRrLXVhcnQudHh0
ICAgICAgICB8ICAgMSArDQogLi4uL2JpbmRpbmdzL3RpbWVyL21lZGlhdGVrLG10ay10aW1lci50
eHQgICAgICAgICAgfCAgIDEgKw0KIGFyY2gvYXJtNjQvYm9vdC9kdHMvbWVkaWF0ZWsvTWFrZWZp
bGUgICAgICAgICAgICAgIHwgICAxICsNCiBhcmNoL2FybTY0L2Jvb3QvZHRzL21lZGlhdGVrL210
ODE5Mi1ldmIuZHRzICAgICAgICB8ICAyOSArDQogYXJjaC9hcm02NC9ib290L2R0cy9tZWRpYXRl
ay9tdDgxOTIuZHRzaSAgICAgICAgICAgfCA2NzEgKysrKysrKysrKysrKysrKysrKysrDQogNSBm
aWxlcyBjaGFuZ2VkLCA3MDMgaW5zZXJ0aW9ucygrKQ0KIGNyZWF0ZSBtb2RlIDEwMDY0NCBhcmNo
L2FybTY0L2Jvb3QvZHRzL21lZGlhdGVrL210ODE5Mi1ldmIuZHRzDQogY3JlYXRlIG1vZGUgMTAw
NjQ0IGFyY2gvYXJtNjQvYm9vdC9kdHMvbWVkaWF0ZWsvbXQ4MTkyLmR0c2kNCg0KLS0NCjIuMTQu
MQ0KDQo=


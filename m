Return-Path: <SRS0=y+wj=BI=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B400C433E8
	for <linux-serial@archiver.kernel.org>; Wed, 29 Jul 2020 01:31:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5EEBB2078E
	for <linux-serial@archiver.kernel.org>; Wed, 29 Jul 2020 01:31:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="qOo1JPUl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730462AbgG2Bbg (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 28 Jul 2020 21:31:36 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:30009 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729918AbgG2Bbg (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 28 Jul 2020 21:31:36 -0400
X-UUID: 1c06fdcc60cf40a5a4e78055950f36cd-20200729
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=jWKLQWc5BKXvsqie3oUfmWGaQGm2Es3847LVVs0DT64=;
        b=qOo1JPUlBQxEHOw1OvyMoNlrz2zAvufDesZxhNLnWFPHXTK0+rcN3o9F7Zz2utfdR9+X7Hri4sHdw3MP6JIbLAHhRmExqIu4K5FDJ7yNRybQa1btl1h8+0phCsCqIUxWApA5oqbYbPYw53LciOm+kSOD0HKlJ69iMIclKFS/j5M=;
X-UUID: 1c06fdcc60cf40a5a4e78055950f36cd-20200729
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <seiya.wang@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1215441968; Wed, 29 Jul 2020 09:31:32 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs06n2.mediatek.inc (172.21.101.130) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 29 Jul 2020 09:31:31 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 29 Jul 2020 09:31:31 +0800
From:   Seiya Wang <seiya.wang@mediatek.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
CC:     <linux-serial@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <srv_heupstream@mediatek.com>,
        Seiya Wang <seiya.wang@mediatek.com>
Subject: [PATCH v3 3/3] dt-bindings: timer: Add compatible for Mediatek MT8192
Date:   Wed, 29 Jul 2020 09:31:00 +0800
Message-ID: <20200729013100.19539-4-seiya.wang@mediatek.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20200729013100.19539-1-seiya.wang@mediatek.com>
References: <20200729013100.19539-1-seiya.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: FE79BA7B28F3EE66442C9FEA8249509AE3874054714F2E46A0D2F3D39FBC43FD2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

VGhpcyBjb21taXQgYWRkcyBkdC1iaW5kaW5nIGRvY3VtZW50YXRpb24gb2YgdGltZXIgZm9yIE1l
ZGlhdGVrIE1UODE5MiBTb0MNClBsYXRmb3JtLg0KDQpTaWduZWQtb2ZmLWJ5OiBTZWl5YSBXYW5n
IDxzZWl5YS53YW5nQG1lZGlhdGVrLmNvbT4NCi0tLQ0KIERvY3VtZW50YXRpb24vZGV2aWNldHJl
ZS9iaW5kaW5ncy90aW1lci9tZWRpYXRlayxtdGstdGltZXIudHh0IHwgMSArDQogMSBmaWxlIGNo
YW5nZWQsIDEgaW5zZXJ0aW9uKCspDQoNCmRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2Rldmlj
ZXRyZWUvYmluZGluZ3MvdGltZXIvbWVkaWF0ZWssbXRrLXRpbWVyLnR4dCBiL0RvY3VtZW50YXRp
b24vZGV2aWNldHJlZS9iaW5kaW5ncy90aW1lci9tZWRpYXRlayxtdGstdGltZXIudHh0DQppbmRl
eCAwZDI1NjQ4NmY4ODYuLjY5MGE5YzA5NjZhYyAxMDA2NDQNCi0tLSBhL0RvY3VtZW50YXRpb24v
ZGV2aWNldHJlZS9iaW5kaW5ncy90aW1lci9tZWRpYXRlayxtdGstdGltZXIudHh0DQorKysgYi9E
b2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvdGltZXIvbWVkaWF0ZWssbXRrLXRpbWVy
LnR4dA0KQEAgLTIyLDYgKzIyLDcgQEAgUmVxdWlyZWQgcHJvcGVydGllczoNCiANCiAJRm9yIHRo
b3NlIFNvQ3MgdGhhdCB1c2UgU1lTVA0KIAkqICJtZWRpYXRlayxtdDgxODMtdGltZXIiIGZvciBN
VDgxODMgY29tcGF0aWJsZSB0aW1lcnMgKFNZU1QpDQorCSogIm1lZGlhdGVrLG10ODE5Mi10aW1l
ciIgZm9yIE1UODE5MiBjb21wYXRpYmxlIHRpbWVycyAoU1lTVCkNCiAJKiAibWVkaWF0ZWssbXQ3
NjI5LXRpbWVyIiBmb3IgTVQ3NjI5IGNvbXBhdGlibGUgdGltZXJzIChTWVNUKQ0KIAkqICJtZWRp
YXRlayxtdDY3NjUtdGltZXIiIGZvciBNVDY3NjUgYW5kIGFsbCBhYm92ZSBjb21wYXRpYmxlIHRp
bWVycyAoU1lTVCkNCiANCi0tIA0KMi4xNC4xDQo=


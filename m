Return-Path: <SRS0=Ntbd=BH=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 599A1C433FB
	for <linux-serial@archiver.kernel.org>; Tue, 28 Jul 2020 13:42:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 315542075D
	for <linux-serial@archiver.kernel.org>; Tue, 28 Jul 2020 13:42:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="nFtG8ZZZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730214AbgG1Nmh (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 28 Jul 2020 09:42:37 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:50127 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730209AbgG1Nmh (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 28 Jul 2020 09:42:37 -0400
X-UUID: 75c3b7081e6245a0a087248a09201a9f-20200728
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=tWvLiz/fAUH2FTeWAPBixcOQZuwwGaB5etKJl3FKCQ0=;
        b=nFtG8ZZZ7liUGSijVXOT/ghhwKLXcdpIkEn1YbHsRnC8L3LOiPHTYd0u0K52mmXQGerbfUJoKIzFkozaLASsq2V3yhPKVM+epBXVsMydW+mJ0BuNERQgbKMOFEjuChs/mukgHi1RtvGx88vxVoN59wBddU3DlIm99rLtnhSV3A0=;
X-UUID: 75c3b7081e6245a0a087248a09201a9f-20200728
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <seiya.wang@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 73644101; Tue, 28 Jul 2020 21:42:33 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs06n1.mediatek.inc (172.21.101.129) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 28 Jul 2020 21:42:32 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 28 Jul 2020 21:42:29 +0800
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
Subject: [PATCH v2 3/3] dt-bindings: timer: Add compatible for Mediatek MT8192
Date:   Tue, 28 Jul 2020 21:41:49 +0800
Message-ID: <20200728134149.19758-4-seiya.wang@mediatek.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20200728134149.19758-1-seiya.wang@mediatek.com>
References: <20200728134149.19758-1-seiya.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

VGhpcyBjb21taXQgYWRkcyBkdC1iaW5kaW5nIGRvY3VtZW50YXRpb24gb2YgdGltZXIgZm9yIE1l
ZGlhdGVrIE1UODE5MiBTb0MNClBsYXRmb3JtLg0KDQpDaGFuZ2UtSWQ6IElmOTMyZTQ0ZjExNmE0
YThhYmQ2YzI0MDA5ODc2ODUxNzdlYjFkMWY4DQpTaWduZWQtb2ZmLWJ5OiBTZWl5YSBXYW5nIDxz
ZWl5YS53YW5nQG1lZGlhdGVrLmNvbT4NCi0tLQ0KIERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9i
aW5kaW5ncy90aW1lci9tZWRpYXRlayxtdGstdGltZXIudHh0IHwgMSArDQogMSBmaWxlIGNoYW5n
ZWQsIDEgaW5zZXJ0aW9uKCspDQoNCmRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2RldmljZXRy
ZWUvYmluZGluZ3MvdGltZXIvbWVkaWF0ZWssbXRrLXRpbWVyLnR4dCBiL0RvY3VtZW50YXRpb24v
ZGV2aWNldHJlZS9iaW5kaW5ncy90aW1lci9tZWRpYXRlayxtdGstdGltZXIudHh0DQppbmRleCAw
ZDI1NjQ4NmY4ODYuLjlkZjg5ODA2ZWM2ZCAxMDA2NDQNCi0tLSBhL0RvY3VtZW50YXRpb24vZGV2
aWNldHJlZS9iaW5kaW5ncy90aW1lci9tZWRpYXRlayxtdGstdGltZXIudHh0DQorKysgYi9Eb2N1
bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvdGltZXIvbWVkaWF0ZWssbXRrLXRpbWVyLnR4
dA0KQEAgLTIyLDYgKzIyLDcgQEAgUmVxdWlyZWQgcHJvcGVydGllczoNCiANCiAJRm9yIHRob3Nl
IFNvQ3MgdGhhdCB1c2UgU1lTVA0KIAkqICJtZWRpYXRlayxtdDgxODMtdGltZXIiIGZvciBNVDgx
ODMgY29tcGF0aWJsZSB0aW1lcnMgKFNZU1QpDQorCSogIm1lZGlhdGVrLG10ODE5Mi10aW1lciIg
Zm9yIE1UODE4MyBjb21wYXRpYmxlIHRpbWVycyAoU1lTVCkNCiAJKiAibWVkaWF0ZWssbXQ3NjI5
LXRpbWVyIiBmb3IgTVQ3NjI5IGNvbXBhdGlibGUgdGltZXJzIChTWVNUKQ0KIAkqICJtZWRpYXRl
ayxtdDY3NjUtdGltZXIiIGZvciBNVDY3NjUgYW5kIGFsbCBhYm92ZSBjb21wYXRpYmxlIHRpbWVy
cyAoU1lTVCkNCiANCi0tIA0KMi4xNC4xDQo=


Return-Path: <SRS0=xWBg=BY=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF9AEC433E1
	for <linux-serial@archiver.kernel.org>; Fri, 14 Aug 2020 06:05:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3E3920708
	for <linux-serial@archiver.kernel.org>; Fri, 14 Aug 2020 06:05:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="FVfTK/1T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726647AbgHNGFd (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 14 Aug 2020 02:05:33 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:55969 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726110AbgHNGF2 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 14 Aug 2020 02:05:28 -0400
X-UUID: ca976268da794d67bdcf8f306473007c-20200814
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=0XoGyuqMVNHrbbEMVkbN3uy8qbQMTXKiMupXqryMcII=;
        b=FVfTK/1T67yByNgf+Iom0mRKiWhbIuSpyRt/nqfwZkGMZ3VtyhYVISba6FES4jLSXdchBE3j/XgOzV+p73X3tzq/QxaZ6Lii0/y8NCGaMHDdJnNVTKxH+CpAJf+sdCnxJQ++33vtNQyCZtDVJv/vp6SfEerZEDyhIicAw+e9lj0=;
X-UUID: ca976268da794d67bdcf8f306473007c-20200814
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <seiya.wang@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 187813513; Fri, 14 Aug 2020 14:05:26 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 14 Aug 2020 14:05:24 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 14 Aug 2020 14:05:24 +0800
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
Subject: [PATCH v4 2/3] dt-bindings: serial: Add compatible for Mediatek MT8192
Date:   Fri, 14 Aug 2020 14:04:53 +0800
Message-ID: <20200814060454.32200-3-seiya.wang@mediatek.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20200814060454.32200-1-seiya.wang@mediatek.com>
References: <20200814060454.32200-1-seiya.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

VGhpcyBjb21taXQgYWRkcyBkdC1iaW5kaW5nIGRvY3VtZW50YXRpb24gb2YgdWFydCBmb3IgTWVk
aWF0ZWsgTVQ4MTkyIFNvQw0KUGxhdGZvcm0uDQoNCkFja2VkLWJ5OiBSb2IgSGVycmluZyA8cm9i
aEBrZXJuZWwub3JnPg0KU2lnbmVkLW9mZi1ieTogU2VpeWEgV2FuZyA8c2VpeWEud2FuZ0BtZWRp
YXRlay5jb20+DQotLS0NCiBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mvc2VyaWFs
L210ay11YXJ0LnR4dCB8IDEgKw0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQ0KDQpk
aWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3NlcmlhbC9tdGst
dWFydC50eHQgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mvc2VyaWFsL210ay11
YXJ0LnR4dA0KaW5kZXggM2EzYjU3MDc5ZjBkLi42NDdiNWFlZTg2ZjMgMTAwNjQ0DQotLS0gYS9E
b2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mvc2VyaWFsL210ay11YXJ0LnR4dA0KKysr
IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3NlcmlhbC9tdGstdWFydC50eHQN
CkBAIC0xOSw2ICsxOSw3IEBAIFJlcXVpcmVkIHByb3BlcnRpZXM6DQogICAqICJtZWRpYXRlayxt
dDgxMzUtdWFydCIgZm9yIE1UODEzNSBjb21wYXRpYmxlIFVBUlRTDQogICAqICJtZWRpYXRlayxt
dDgxNzMtdWFydCIgZm9yIE1UODE3MyBjb21wYXRpYmxlIFVBUlRTDQogICAqICJtZWRpYXRlayxt
dDgxODMtdWFydCIsICJtZWRpYXRlayxtdDY1NzctdWFydCIgZm9yIE1UODE4MyBjb21wYXRpYmxl
IFVBUlRTDQorICAqICJtZWRpYXRlayxtdDgxOTItdWFydCIsICJtZWRpYXRlayxtdDY1NzctdWFy
dCIgZm9yIE1UODE5MiBjb21wYXRpYmxlIFVBUlRTDQogICAqICJtZWRpYXRlayxtdDg1MTYtdWFy
dCIgZm9yIE1UODUxNiBjb21wYXRpYmxlIFVBUlRTDQogICAqICJtZWRpYXRlayxtdDY1NzctdWFy
dCIgZm9yIE1UNjU3NyBhbmQgYWxsIG9mIHRoZSBhYm92ZQ0KIA0KLS0gDQoyLjE0LjENCg==


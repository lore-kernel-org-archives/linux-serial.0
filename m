Return-Path: <SRS0=S7Zs=76=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DF5EC433E0
	for <linux-serial@archiver.kernel.org>; Wed, 17 Jun 2020 03:51:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 36D372080D
	for <linux-serial@archiver.kernel.org>; Wed, 17 Jun 2020 03:51:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="NUE3uXzZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726668AbgFQDvK (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 16 Jun 2020 23:51:10 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:48545 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726568AbgFQDvK (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 16 Jun 2020 23:51:10 -0400
X-UUID: 5972c0b17664407abc4a2c1710ec9fb4-20200617
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=E0n2lDonFBEI59Ci1XWwVT6HIPc/UsUckcKN/vDwwaE=;
        b=NUE3uXzZCZjfQVdSh7lskhgR/2NE0EqrkTEtdkVyZl4g8eHFf1vejckADPY0aXiqG+9aoTQVB/pok3V2BElIgnnYTzTTGKB6opDKV01c+UUMIF65j4co5DoARzG4Nr4DsjU1VS8WBfV32dedHfbdNTmwTCrJvGVKh75uxMXvW98=;
X-UUID: 5972c0b17664407abc4a2c1710ec9fb4-20200617
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1837636369; Wed, 17 Jun 2020 11:51:02 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs02n1.mediatek.inc (172.21.101.77) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 17 Jun 2020 11:51:00 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 17 Jun 2020 11:51:00 +0800
From:   <sean.wang@mediatek.com>
To:     <gregkh@linuxfoundation.org>
CC:     <andriy.shevchenko@linux.intel.com>, <steven.liu@mediatek.com>,
        <arnd@arndb.de>, <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <Ryder.Lee@mediatek.com>,
        <sean.wang@mediatek.com>, <tthayer@opensource.altera.com>,
        <linux-serial@vger.kernel.org>, <jslaby@suse.com>,
        <matthias.bgg@gmail.com>, <sr@denx.de>,
        <mika.westerberg@linux.intel.com>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v3] tty: serial: don't do termios for BTIF
Date:   Wed, 17 Jun 2020 11:50:59 +0800
Message-ID: <1592365859-26714-1-git-send-email-sean.wang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <20200422180900.GA3454664@kroah.com>
References: <20200422180900.GA3454664@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

RnJvbTogU2VhbiBXYW5nIDxzZWFuLndhbmdAbWVkaWF0ZWsuY29tPg0KDQo+T24gVGh1LCBBcHIg
MjMsIDIwMjAgYXQgMDI6MDI6MDhBTSArMDgwMCwgc2Vhbi53YW5nQG1lZGlhdGVrLmNvbSB3cm90
ZToNCj4+IEZyb206IFNlYW4gV2FuZyA8c2Vhbi53YW5nQG1lZGlhdGVrLmNvbT4NCj4+DQo+PiBC
bHVldG9vdGggSW50ZXJmYWNlIChCVElGKSBpcyBkZXNpZ25lZCBkZWRpY2F0ZWRseSBmb3IgTWVk
aWFUZWsgU09DDQo+PiB3aXRoIEJUIGluIG9yZGVyIHRvIGJlIGluc3RlYWQgb2YgdGhlIFVBUlQg
aW50ZXJmYWNlIGJldHdlZW4gQlQgbW9kdWxlDQo+PiBhbmQgSG9zdCBDUFUsIGFuZCBub3QgZXhw
b3J0ZWQgdG8gdXNlciBzcGFjZSB0byBhY2Nlc3MuDQo+Pg0KPj4gQXMgdGhlIFVBUlQgZGVzaWdu
LCBCVElGIHdpbGwgYmUgYW4gQVBCIHNsYXZlIGFuZCBjYW4gdHJhbnNtaXQgb3INCj4+IHJlY2Vp
dmUgZGF0YSBieSBNQ1UgYWNjZXNzLCBidXQgZG9lc24ndCBwcm92aWRlIHRlcm1pb3MgZnVuY3Rp
b24gbGlrZQ0KPj4gYmF1ZHJhdGUgYW5kIGZsb3cgY29udHJvbCBzZXR1cC4NCj4NCj5XaHkgZG9l
cyBpdCBtYXR0ZXI/ICBJZiB0aGUgY29ubmVjdGlvbiBpc24ndCBleHBvcnRlZCB0byB1c2Vyc3Bh
Y2UsIHdobyB3b3VsZCBydW4gdGhvc2UgdGVybWlvcyBmdW5jdGlvbnMgb24gdGhlIHBvcnQ/DQoN
ClRoZSBibHVldG9vdGggZHJpdmVyIHdvdWxkIHVzZSBCVElGIGRldmljZSBhcyBhIHNlcmRldi4N
Cg0KVGhlIHRlcm1pb3MgZnVuY3Rpb24gd291bGQgYmUgY2FsbGVkIGluIGtlcm5lbHNwYWNlIGZy
b20gdHR5cG9ydF9vcGVuIGFuZCB0aGVuDQp0byB0dHlfc2V0X3Rlcm1pb3MgZGVmaW5lZCBpbiBk
cml2ZXJzL3R0eS9zZXJkZXYvc2VyZGV2LXR0eXBvcnQuYy4NCg0KPg0KPnRoYW5rcywNCj4NCj5n
cmVnIGstaA0K


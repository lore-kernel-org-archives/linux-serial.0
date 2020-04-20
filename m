Return-Path: <SRS0=2nXW=6E=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E17FCC54FCB
	for <linux-serial@archiver.kernel.org>; Mon, 20 Apr 2020 02:06:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9419D20936
	for <linux-serial@archiver.kernel.org>; Mon, 20 Apr 2020 02:06:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="fGzmuMR+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725991AbgDTCGp (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Sun, 19 Apr 2020 22:06:45 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:38006 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725953AbgDTCGo (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sun, 19 Apr 2020 22:06:44 -0400
X-UUID: 15895ba748b741d689787e4e72c2df8f-20200420
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=apeKneLMG1hzTxdpFAt2JSCjXRLNOpzDMxDOJ9dHZ7A=;
        b=fGzmuMR+Truu3qv76tuPigaZ0pQwCJJio7FFkL8raPMLc4uwxHIp2LKujvWWwrievZV3O1OIGKfxwLgpq4XHzr7qrhyviSbljEadWOeGmat4Ub375ODEMSOdabJ9SLnn5YrDhVb0khviCIc4mdtKDe9+E1EGC4IfsiJKRoYjkx4=;
X-UUID: 15895ba748b741d689787e4e72c2df8f-20200420
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 785955110; Mon, 20 Apr 2020 10:06:40 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs02n1.mediatek.inc (172.21.101.77) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 20 Apr 2020 10:06:34 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 20 Apr 2020 10:06:39 +0800
From:   <sean.wang@mediatek.com>
To:     <gregkh@linuxfoundation.org>, <jslaby@suse.com>,
        <andriy.shevchenko@linux.intel.com>, <robert.jarzmik@free.fr>,
        <arnd@arndb.de>, <p.zabel@pengutronix.de>, <joel@jms.id.au>,
        <david@lechnology.com>, <jan.kiszka@siemens.com>,
        <heikki.krogerus@linux.intel.com>, <hpeter@gmail.com>,
        <vigneshr@ti.com>, <matthias.bgg@gmail.com>,
        <tthayer@opensource.altera.com>
CC:     <linux-mediatek@lists.infradead.org>,
        <linux-serial@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Sean Wang <sean.wang@mediatek.com>,
        Steven Liu <steven.liu@mediatek.com>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH v2] tty: serial: don't do termios for BTIF
Date:   Mon, 20 Apr 2020 10:06:38 +0800
Message-ID: <8c47aea3aa3cce4d7484b840ddb117cd16bcf1cc.1587347988.git.sean.wang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

RnJvbTogU2VhbiBXYW5nIDxzZWFuLndhbmdAbWVkaWF0ZWsuY29tPg0KDQpCbHVldG9vdGggSW50
ZXJmYWNlIChCVElGKSBpcyBkZXNpZ25lZCBkZWRpY2F0ZWRseSBmb3IgTWVkaWFUZWsgU09DIHdp
dGgNCkJUIGluIG9yZGVyIHRvIGJlIGluc3RlYWQgb2YgdGhlIFVBUlQgaW50ZXJmYWNlIGJldHdl
ZW4gQlQgbW9kdWxlIGFuZCBIb3N0DQpDUFUsIGFuZCBub3QgZXhwb3J0ZWQgdG8gdXNlciBzcGFj
ZSB0byBhY2Nlc3MuDQoNCkFzIHRoZSBVQVJUIGRlc2lnbiwgQlRJRiB3aWxsIGJlIGFuIEFQQiBz
bGF2ZSBhbmQgY2FuIHRyYW5zbWl0IG9yIHJlY2VpdmUNCmRhdGEgYnkgTUNVIGFjY2VzcywgYnV0
IGRvZXNuJ3QgcHJvdmlkZSB0ZXJtaW9zIGZ1bmN0aW9uIGxpa2UgYmF1ZHJhdGUgYW5kDQpmbG93
IGNvbnRyb2wgc2V0dXAuDQoNCkV2ZW4gTENSIG9uIG9mZnNldCAweEMgdGhhdCBpcyBqdXN0IGEg
RkFLRUxDUg0KYS4gSWYgRkFLRUxDUls3XSBpcyBlcXVhbGVkIHRvIDEsIFJCUigweDAwKSwgVEhS
KDB4MDApLCBJRVIoMHgwNCkNCiAgIHdpbGwgbm90IGJlIHJlYWRhYmxlL3dyaXRhYmxlLg0KDQpi
LiBJZiBGQUtFTENSIGlzIGVxdWFsZWQgdG8gMHhCRiwgUkJSKDB4MDApLCBUSFIoMHgwMCksIElF
UigweDA0KSwNCiAgIElJUigweDA4KSwgYW5kIExTUigweDE0KSB3aWxsIG5vdCBiZSByZWFkYWJs
ZS93cml0YWJsZS4NCg0KU28gYWRkaW5nIGEgbmV3IGNhcGFiaWxpdHkgJ1VBUlRfQ0FQX05NT0Qn
IGZvciB0aGUgdW51c3VhbCB1bnN1cHBvcnRlZA0KY2FzZS4NCg0KRml4ZXM6IDFjMTZhZTY1ZTI1
MCAoInNlcmlhbDogODI1MDogb2Y6IEFkZCBuZXcgcG9ydCB0eXBlIGZvciBNZWRpYVRlayBCVElG
IGNvbnRyb2xsZXIgb24gTVQ3NjIyLzIzIFNvQyIpDQpDYzogU3RldmVuIExpdSA8c3RldmVuLmxp
dUBtZWRpYXRlay5jb20+DQpTaWduZWQtb2ZmLWJ5OiBTZWFuIFdhbmcgPHNlYW4ud2FuZ0BtZWRp
YXRlay5jb20+DQpTaWduZWQtb2ZmLWJ5OiBSeWRlciBMZWUgPHJ5ZGVyLmxlZUBtZWRpYXRlay5j
b20+DQoNCi0tDQp2MS0+djI6DQpubyBjaGFuZ2Ugb24gdGVybWlvcy0+Y19jZmxhZyBhbmQgcmVm
aW5lIGNvbW1pdCBtZXNzYWdlDQotLS0NCiBkcml2ZXJzL3R0eS9zZXJpYWwvODI1MC84MjUwLmgg
ICAgICB8IDEgKw0KIGRyaXZlcnMvdHR5L3NlcmlhbC84MjUwLzgyNTBfcG9ydC5jIHwgNSArKysr
LQ0KIDIgZmlsZXMgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQoNCmRp
ZmYgLS1naXQgYS9kcml2ZXJzL3R0eS9zZXJpYWwvODI1MC84MjUwLmggYi9kcml2ZXJzL3R0eS9z
ZXJpYWwvODI1MC84MjUwLmgNCmluZGV4IDMzYWQ5ZDZkZTUzMi4uMjUwMzM3ZTRlN2M4IDEwMDY0
NA0KLS0tIGEvZHJpdmVycy90dHkvc2VyaWFsLzgyNTAvODI1MC5oDQorKysgYi9kcml2ZXJzL3R0
eS9zZXJpYWwvODI1MC84MjUwLmgNCkBAIC04Miw2ICs4Miw3IEBAIHN0cnVjdCBzZXJpYWw4MjUw
X2NvbmZpZyB7DQogI2RlZmluZSBVQVJUX0NBUF9NSU5JCSgxIDw8IDE3KQkvKiBNaW5pIFVBUlQg
b24gQkNNMjgzWCBmYW1pbHkgbGFja3M6DQogCQkJCQkgKiBTVE9QIFBBUklUWSBFUEFSIFNQQVIg
V0xFTjUgV0xFTjYNCiAJCQkJCSAqLw0KKyNkZWZpbmUgVUFSVF9DQVBfTk1PRAkoMSA8PCAxOCkJ
LyogVUFSVCBkb2Vzbid0IGRvIHRlcm1pb3MgKi8NCiANCiAjZGVmaW5lIFVBUlRfQlVHX1FVT1QJ
KDEgPDwgMCkJLyogVUFSVCBoYXMgYnVnZ3kgcXVvdCBMU0IgKi8NCiAjZGVmaW5lIFVBUlRfQlVH
X1RYRU4JKDEgPDwgMSkJLyogVUFSVCBoYXMgYnVnZ3kgVFggSUlSIHN0YXR1cyAqLw0KZGlmZiAt
LWdpdCBhL2RyaXZlcnMvdHR5L3NlcmlhbC84MjUwLzgyNTBfcG9ydC5jIGIvZHJpdmVycy90dHkv
c2VyaWFsLzgyNTAvODI1MF9wb3J0LmMNCmluZGV4IDAzMjVmMmU1M2I3NC4uZGEwYTg3MTFlZTNk
IDEwMDY0NA0KLS0tIGEvZHJpdmVycy90dHkvc2VyaWFsLzgyNTAvODI1MF9wb3J0LmMNCisrKyBi
L2RyaXZlcnMvdHR5L3NlcmlhbC84MjUwLzgyNTBfcG9ydC5jDQpAQCAtMjg2LDcgKzI4Niw3IEBA
IHN0YXRpYyBjb25zdCBzdHJ1Y3Qgc2VyaWFsODI1MF9jb25maWcgdWFydF9jb25maWdbXSA9IHsN
CiAJCS50eF9sb2Fkc3oJPSAxNiwNCiAJCS5mY3IJCT0gVUFSVF9GQ1JfRU5BQkxFX0ZJRk8gfA0K
IAkJCQkgIFVBUlRfRkNSX0NMRUFSX1JDVlIgfCBVQVJUX0ZDUl9DTEVBUl9YTUlULA0KLQkJLmZs
YWdzCQk9IFVBUlRfQ0FQX0ZJRk8sDQorCQkuZmxhZ3MJCT0gVUFSVF9DQVBfRklGTyB8IFVBUlRf
Q0FQX05NT0QsDQogCX0sDQogCVtQT1JUX05QQ01dID0gew0KIAkJLm5hbWUJCT0gIk51dm90b24g
MTY1NTAiLA0KQEAgLTI1NDQsNiArMjU0NCw5IEBAIHNlcmlhbDgyNTBfZG9fc2V0X3Rlcm1pb3Mo
c3RydWN0IHVhcnRfcG9ydCAqcG9ydCwgc3RydWN0IGt0ZXJtaW9zICp0ZXJtaW9zLA0KIAl1bnNp
Z25lZCBsb25nIGZsYWdzOw0KIAl1bnNpZ25lZCBpbnQgYmF1ZCwgcXVvdCwgZnJhYyA9IDA7DQog
DQorCWlmICh1cC0+Y2FwYWJpbGl0aWVzICYgVUFSVF9DQVBfTk1PRCkNCisJCXJldHVybjsNCisN
CiAJaWYgKHVwLT5jYXBhYmlsaXRpZXMgJiBVQVJUX0NBUF9NSU5JKSB7DQogCQl0ZXJtaW9zLT5j
X2NmbGFnICY9IH4oQ1NUT1BCIHwgUEFSRU5CIHwgUEFST0REIHwgQ01TUEFSKTsNCiAJCWlmICgo
dGVybWlvcy0+Y19jZmxhZyAmIENTSVpFKSA9PSBDUzUgfHwNCi0tIA0KMi4yNS4xDQo=


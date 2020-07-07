Return-Path: <SRS0=ofBx=AS=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1CF7C433DF
	for <linux-serial@archiver.kernel.org>; Tue,  7 Jul 2020 23:11:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7DE01206BE
	for <linux-serial@archiver.kernel.org>; Tue,  7 Jul 2020 23:11:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="o3NV80BN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728400AbgGGXLz (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 7 Jul 2020 19:11:55 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:32565 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727777AbgGGXLy (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 7 Jul 2020 19:11:54 -0400
X-UUID: 6363544267ef4f80b9d9ec5b870c4a26-20200708
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=ACgdKKQvvl0IN9nE7D17jMhl6fwZEjwiF6CEjA4GWAU=;
        b=o3NV80BNsX4PmP6KgyiMYWE09jSPqxpKHDYAiV42GAs1eUcfH/QuMlmSdcI58gY/3bjvPeQpd3o+HsoQRCzQ50Laqf9jZxjpLnX/H11qW7ZUBw/QQ4Swx4RvRFG33XnQWG6w06AONjqYK87jvQRxqvE0aXQyBhU0di4beslthvg=;
X-UUID: 6363544267ef4f80b9d9ec5b870c4a26-20200708
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw01.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 729408332; Wed, 08 Jul 2020 07:11:49 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs02n2.mediatek.inc (172.21.101.101) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 8 Jul 2020 07:11:29 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 8 Jul 2020 07:11:19 +0800
From:   <sean.wang@mediatek.com>
To:     <gregkh@linuxfoundation.org>, <jslaby@suse.com>,
        <andriy.shevchenko@linux.intel.com>,
        <mika.westerberg@linux.intel.com>, <sr@denx.de>, <arnd@arndb.de>,
        <matthias.bgg@gmail.com>, <tthayer@opensource.altera.com>
CC:     <linux-mediatek@lists.infradead.org>,
        <linux-serial@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Sean Wang <sean.wang@mediatek.com>,
        Steven Liu <steven.liu@mediatek.com>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH v5] tty: serial: don't do termios for BTIF
Date:   Wed, 8 Jul 2020 07:11:22 +0800
Message-ID: <7c67171728cdcc4ccc10adfaea1a14bfbcf8375a.1594163304.git.sean.wang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 4F28F1CAC5E7592B35293C87473BAF934B244B4F5546B2CBC7BAF98B527E8F2A2000:8
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
ZS93cml0YWJsZS4NCg0KU28gYWRkaW5nIGEgbmV3IGNhcGFiaWxpdHkgJ1VBUlRfQ0FQX05USU8n
IGZvciB0aGUgdW51c3VhbCB1bnN1cHBvcnRlZA0KY2FzZS4NCg0KVGhlIGJsdWV0b290aCBkcml2
ZXIgd291bGQgdXNlIEJUSUYgZGV2aWNlIGFzIGEgc2VyZGV2LiBTbyB0aGUgdGVybWlvcw0Kc3Rp
bGwgZnVuY3Rpb24gd291bGQgYmUgY2FsbGVkIGluIGtlcm5lbHNwYWNlIGZyb20gdHR5cG9ydF9v
cGVuIGluDQpkcml2ZXJzL3R0eS9zZXJkZXYvc2VyZGV2LXR0eXBydC5jLg0KDQpGaXhlczogMWMx
NmFlNjVlMjUwICgic2VyaWFsOiA4MjUwOiBvZjogQWRkIG5ldyBwb3J0IHR5cGUgZm9yIE1lZGlh
VGVrIEJUSUYgY29udHJvbGxlciBvbiBNVDc2MjIvMjMgU29DIikNCkNjOiBTdGV2ZW4gTGl1IDxz
dGV2ZW4ubGl1QG1lZGlhdGVrLmNvbT4NClNpZ25lZC1vZmYtYnk6IFNlYW4gV2FuZyA8c2Vhbi53
YW5nQG1lZGlhdGVrLmNvbT4NClNpZ25lZC1vZmYtYnk6IFJ5ZGVyIExlZSA8cnlkZXIubGVlQG1l
ZGlhdGVrLmNvbT4NCg0KLS0NCnYxLT52MjoNCm5vIGNoYW5nZSBvbiB0ZXJtaW9zLT5jX2NmbGFn
IGFuZCByZWZpbmUgY29tbWl0IG1lc3NhZ2UNCg0KdjItPnYzOg0KY2hhbmdlIHRoZSBuYW1pbmcg
ZnJvbSBOTU9EIHRvIE5USU8gYXMgVElPIGlzIGEgd2VsbCBlc3RhYmxpc2hlZCBwcmVmaXgNCmZv
ciB0ZXJtaW9zIElPQ1RMcy4NCg0KdjMtPnY0Og0KMS4gcmVtb3ZlIGFwcHJvcHJpYXRlIHRhZw0K
Mi4gYWRkIHRoZSBleHBsYW5hdGlvbiB3aHkgdGhlIHRlcm1pb3MgaXMgcmVxdWlyZWQgZXZlbiB3
aGVuIHRoZSBjb25uZWN0aW9uDQogICBpc24ndCBleHBvcnRlZCB0byB1c2Vyc3BhY2UuDQoNCnY0
LT52NToNClVzZSB1cC0+cG9ydC5xdWlya3MgVVBRX0lHTk9SRV9URVJNSU9TIGluc3RlYWQuDQot
LS0NCiBkcml2ZXJzL3R0eS9zZXJpYWwvODI1MC84MjUwX2NvcmUuYyB8IDMgKysrDQogZHJpdmVy
cy90dHkvc2VyaWFsLzgyNTAvODI1MF9wb3J0LmMgfCAzICsrKw0KIGluY2x1ZGUvbGludXgvc2Vy
aWFsX2NvcmUuaCAgICAgICAgIHwgMSArDQogMyBmaWxlcyBjaGFuZ2VkLCA3IGluc2VydGlvbnMo
KykNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvdHR5L3NlcmlhbC84MjUwLzgyNTBfY29yZS5jIGIv
ZHJpdmVycy90dHkvc2VyaWFsLzgyNTAvODI1MF9jb3JlLmMNCmluZGV4IGZjMTE4ZjY0OTg4Ny4u
YjAwMDYwYzYxNWMyIDEwMDY0NA0KLS0tIGEvZHJpdmVycy90dHkvc2VyaWFsLzgyNTAvODI1MF9j
b3JlLmMNCisrKyBiL2RyaXZlcnMvdHR5L3NlcmlhbC84MjUwLzgyNTBfY29yZS5jDQpAQCAtNDkw
LDYgKzQ5MCw5IEBAIHN0YXRpYyB2b2lkIHVuaXY4MjUwX3JzYV9zdXBwb3J0KHN0cnVjdCB1YXJ0
X29wcyAqb3BzKQ0KIHN0YXRpYyBpbmxpbmUgdm9pZCBzZXJpYWw4MjUwX2FwcGx5X3F1aXJrcyhz
dHJ1Y3QgdWFydF84MjUwX3BvcnQgKnVwKQ0KIHsNCiAJdXAtPnBvcnQucXVpcmtzIHw9IHNraXBf
dHhlbl90ZXN0ID8gVVBRX05PX1RYRU5fVEVTVCA6IDA7DQorDQorCWlmICh1cC0+cG9ydC50eXBl
ID09IFBPUlRfTVRLX0JUSUYpDQorCQl1cC0+cG9ydC5xdWlya3MgfD0gVVBRX0lHTk9SRV9URVJN
SU9TOw0KIH0NCiANCiBzdGF0aWMgdm9pZCBfX2luaXQgc2VyaWFsODI1MF9pc2FfaW5pdF9wb3J0
cyh2b2lkKQ0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvdHR5L3NlcmlhbC84MjUwLzgyNTBfcG9ydC5j
IGIvZHJpdmVycy90dHkvc2VyaWFsLzgyNTAvODI1MF9wb3J0LmMNCmluZGV4IDE2MzJmN2QyNWFj
Yy4uYmUzODA2NDlmZWZiIDEwMDY0NA0KLS0tIGEvZHJpdmVycy90dHkvc2VyaWFsLzgyNTAvODI1
MF9wb3J0LmMNCisrKyBiL2RyaXZlcnMvdHR5L3NlcmlhbC84MjUwLzgyNTBfcG9ydC5jDQpAQCAt
MjY0MCw2ICsyNjQwLDkgQEAgc2VyaWFsODI1MF9kb19zZXRfdGVybWlvcyhzdHJ1Y3QgdWFydF9w
b3J0ICpwb3J0LCBzdHJ1Y3Qga3Rlcm1pb3MgKnRlcm1pb3MsDQogCXVuc2lnbmVkIGxvbmcgZmxh
Z3M7DQogCXVuc2lnbmVkIGludCBiYXVkLCBxdW90LCBmcmFjID0gMDsNCiANCisJaWYgKHBvcnQt
PnF1aXJrcyAmIFVQUV9JR05PUkVfVEVSTUlPUykNCisJCXJldHVybjsNCisNCiAJaWYgKHVwLT5j
YXBhYmlsaXRpZXMgJiBVQVJUX0NBUF9NSU5JKSB7DQogCQl0ZXJtaW9zLT5jX2NmbGFnICY9IH4o
Q1NUT1BCIHwgUEFSRU5CIHwgUEFST0REIHwgQ01TUEFSKTsNCiAJCWlmICgodGVybWlvcy0+Y19j
ZmxhZyAmIENTSVpFKSA9PSBDUzUgfHwNCmRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L3Nlcmlh
bF9jb3JlLmggYi9pbmNsdWRlL2xpbnV4L3NlcmlhbF9jb3JlLmgNCmluZGV4IDlmZDU1MGU3OTQ2
YS4uYzQ2YWFlMzc0ZTBlIDEwMDY0NA0KLS0tIGEvaW5jbHVkZS9saW51eC9zZXJpYWxfY29yZS5o
DQorKysgYi9pbmNsdWRlL2xpbnV4L3NlcmlhbF9jb3JlLmgNCkBAIC0xNTUsNiArMTU1LDcgQEAg
c3RydWN0IHVhcnRfcG9ydCB7DQogDQogCS8qIHF1aXJrcyBtdXN0IGJlIHVwZGF0ZWQgd2hpbGUg
aG9sZGluZyBwb3J0IG11dGV4ICovDQogI2RlZmluZSBVUFFfTk9fVFhFTl9URVNUCUJJVCgwKQ0K
KyNkZWZpbmUgVVBRX0lHTk9SRV9URVJNSU9TCUJJVCgxKQ0KIA0KIAl1bnNpZ25lZCBpbnQJCXJl
YWRfc3RhdHVzX21hc2s7CS8qIGRyaXZlciBzcGVjaWZpYyAqLw0KIAl1bnNpZ25lZCBpbnQJCWln
bm9yZV9zdGF0dXNfbWFzazsJLyogZHJpdmVyIHNwZWNpZmljICovDQotLSANCjIuMjUuMQ0K


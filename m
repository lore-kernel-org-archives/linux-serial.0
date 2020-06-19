Return-Path: <SRS0=VMdU=AA=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44A87C433E1
	for <linux-serial@archiver.kernel.org>; Fri, 19 Jun 2020 19:59:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 246D020DD4
	for <linux-serial@archiver.kernel.org>; Fri, 19 Jun 2020 19:59:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="BNLhfgA+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387977AbgFST72 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 19 Jun 2020 15:59:28 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:28670 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726940AbgFST71 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 19 Jun 2020 15:59:27 -0400
X-UUID: daa762d178254e3cb1cb5e180b4705b4-20200620
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=mQyV9oA90nw/l5PmfxypuRikaoz6DxZG8g7s7v+PD9k=;
        b=BNLhfgA+H0RSegHq7gnNU1th0W2/Kr0jPoi51NdIPX9rKM/EQDa7e213hodBwSWe7wkEa34Um+Nb9R2kykyQT2oNV1LBOPSP1MCpw1o0U6EyxaOQHYrmf1+4B8IUq8nEHBQOf2P4+CxMKo3+DBAvfr6dSoB8YN3g/9224SUkrUE=;
X-UUID: daa762d178254e3cb1cb5e180b4705b4-20200620
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 821304996; Sat, 20 Jun 2020 03:59:21 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs06n2.mediatek.inc (172.21.101.130) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sat, 20 Jun 2020 03:59:15 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 20 Jun 2020 03:59:11 +0800
From:   <sean.wang@mediatek.com>
To:     <robh+dt@kernel.org>, <gregkh@linuxfoundation.org>,
        <jslaby@suse.com>, <andriy.shevchenko@linux.intel.com>,
        <robert.jarzmik@free.fr>, <arnd@arndb.de>,
        <p.zabel@pengutronix.de>, <joel@jms.id.au>, <david@lechnology.com>,
        <jan.kiszka@siemens.com>, <heikki.krogerus@linux.intel.com>,
        <hpeter@gmail.com>, <vigneshr@ti.com>, <matthias.bgg@gmail.com>,
        <tthayer@opensource.altera.com>
CC:     <devicetree@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        <linux-serial@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Sean Wang <sean.wang@mediatek.com>,
        Steven Liu <steven.liu@mediatek.com>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH v4] tty: serial: don't do termios for BTIF
Date:   Sat, 20 Jun 2020 03:59:14 +0800
Message-ID: <78efa2b1e2599deff4d838b05b4054ec5ac2976a.1592595601.git.sean.wang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: F0184A2B374C0FECDB916DDE74159AA926AA2C638F0BA363607752D2529A60792000:8
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
aGVuIHRoZSBjb25uZWN0aW9uDQogICBpc24ndCBleHBvcnRlZCB0byB1c2Vyc3BhY2UuDQotLS0N
CiBkcml2ZXJzL3R0eS9zZXJpYWwvODI1MC84MjUwLmggICAgICB8IDEgKw0KIGRyaXZlcnMvdHR5
L3NlcmlhbC84MjUwLzgyNTBfcG9ydC5jIHwgNSArKysrLQ0KIDIgZmlsZXMgY2hhbmdlZCwgNSBp
bnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL3R0eS9z
ZXJpYWwvODI1MC84MjUwLmggYi9kcml2ZXJzL3R0eS9zZXJpYWwvODI1MC84MjUwLmgNCmluZGV4
IDUyYmIyMTIwNWJiNi4uMGQ5ZDNiZmU0OGFmIDEwMDY0NA0KLS0tIGEvZHJpdmVycy90dHkvc2Vy
aWFsLzgyNTAvODI1MC5oDQorKysgYi9kcml2ZXJzL3R0eS9zZXJpYWwvODI1MC84MjUwLmgNCkBA
IC04Miw2ICs4Miw3IEBAIHN0cnVjdCBzZXJpYWw4MjUwX2NvbmZpZyB7DQogI2RlZmluZSBVQVJU
X0NBUF9NSU5JCSgxIDw8IDE3KQkvKiBNaW5pIFVBUlQgb24gQkNNMjgzWCBmYW1pbHkgbGFja3M6
DQogCQkJCQkgKiBTVE9QIFBBUklUWSBFUEFSIFNQQVIgV0xFTjUgV0xFTjYNCiAJCQkJCSAqLw0K
KyNkZWZpbmUgVUFSVF9DQVBfTlRJTwkoMSA8PCAxOCkJLyogVUFSVCBkb2Vzbid0IGRvIHRlcm1p
b3MgKi8NCiANCiAjZGVmaW5lIFVBUlRfQlVHX1FVT1QJKDEgPDwgMCkJLyogVUFSVCBoYXMgYnVn
Z3kgcXVvdCBMU0IgKi8NCiAjZGVmaW5lIFVBUlRfQlVHX1RYRU4JKDEgPDwgMSkJLyogVUFSVCBo
YXMgYnVnZ3kgVFggSUlSIHN0YXR1cyAqLw0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvdHR5L3Nlcmlh
bC84MjUwLzgyNTBfcG9ydC5jIGIvZHJpdmVycy90dHkvc2VyaWFsLzgyNTAvODI1MF9wb3J0LmMN
CmluZGV4IDE2MzJmN2QyNWFjYy4uYWY1NGRiODc3ZWZlIDEwMDY0NA0KLS0tIGEvZHJpdmVycy90
dHkvc2VyaWFsLzgyNTAvODI1MF9wb3J0LmMNCisrKyBiL2RyaXZlcnMvdHR5L3NlcmlhbC84MjUw
LzgyNTBfcG9ydC5jDQpAQCAtMjg2LDcgKzI4Niw3IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3Qgc2Vy
aWFsODI1MF9jb25maWcgdWFydF9jb25maWdbXSA9IHsNCiAJCS50eF9sb2Fkc3oJPSAxNiwNCiAJ
CS5mY3IJCT0gVUFSVF9GQ1JfRU5BQkxFX0ZJRk8gfA0KIAkJCQkgIFVBUlRfRkNSX0NMRUFSX1JD
VlIgfCBVQVJUX0ZDUl9DTEVBUl9YTUlULA0KLQkJLmZsYWdzCQk9IFVBUlRfQ0FQX0ZJRk8sDQor
CQkuZmxhZ3MJCT0gVUFSVF9DQVBfRklGTyB8IFVBUlRfQ0FQX05USU8sDQogCX0sDQogCVtQT1JU
X05QQ01dID0gew0KIAkJLm5hbWUJCT0gIk51dm90b24gMTY1NTAiLA0KQEAgLTI2NDAsNiArMjY0
MCw5IEBAIHNlcmlhbDgyNTBfZG9fc2V0X3Rlcm1pb3Moc3RydWN0IHVhcnRfcG9ydCAqcG9ydCwg
c3RydWN0IGt0ZXJtaW9zICp0ZXJtaW9zLA0KIAl1bnNpZ25lZCBsb25nIGZsYWdzOw0KIAl1bnNp
Z25lZCBpbnQgYmF1ZCwgcXVvdCwgZnJhYyA9IDA7DQogDQorCWlmICh1cC0+Y2FwYWJpbGl0aWVz
ICYgVUFSVF9DQVBfTlRJTykNCisJCXJldHVybjsNCisNCiAJaWYgKHVwLT5jYXBhYmlsaXRpZXMg
JiBVQVJUX0NBUF9NSU5JKSB7DQogCQl0ZXJtaW9zLT5jX2NmbGFnICY9IH4oQ1NUT1BCIHwgUEFS
RU5CIHwgUEFST0REIHwgQ01TUEFSKTsNCiAJCWlmICgodGVybWlvcy0+Y19jZmxhZyAmIENTSVpF
KSA9PSBDUzUgfHwNCi0tIA0KMi4yNS4xDQo=


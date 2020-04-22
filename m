Return-Path: <SRS0=lyyL=6G=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A67DC5518B
	for <linux-serial@archiver.kernel.org>; Wed, 22 Apr 2020 18:02:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C50122098B
	for <linux-serial@archiver.kernel.org>; Wed, 22 Apr 2020 18:02:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="dEkvVyei"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726856AbgDVSCV (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 22 Apr 2020 14:02:21 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:5294 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726476AbgDVSCU (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 22 Apr 2020 14:02:20 -0400
X-UUID: ffaa157022074406a23ae358582cbbb0-20200423
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=Wd/MOGLi3v8IcIouicrcERfGp8lHo02kJWYXWlv+S1A=;
        b=dEkvVyeidV4pAvuX74tJ5sxMxMUhqa/vNIPLbHk3HKgyaqsGFelkmcyzogkGqgs5DwOCa67/MULKBy0Yud3tcsxqupahgtlGjnl3kyUvqoUvTnBBF0hbA4ZpqiapDhNWHRXHdL/cjqKT+GGxk1zdXAfRLFAPZaxZ50kivUappgw=;
X-UUID: ffaa157022074406a23ae358582cbbb0-20200423
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1603115986; Thu, 23 Apr 2020 02:02:16 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs02n1.mediatek.inc (172.21.101.77) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 23 Apr 2020 02:02:06 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 23 Apr 2020 02:02:05 +0800
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
Subject: [PATCH v3] tty: serial: don't do termios for BTIF
Date:   Thu, 23 Apr 2020 02:02:08 +0800
Message-ID: <cc41ea10be9ab96568f0371784e3b9f8d9f434b9.1587577548.git.sean.wang@mediatek.com>
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
ZS93cml0YWJsZS4NCg0KU28gYWRkaW5nIGEgbmV3IGNhcGFiaWxpdHkgJ1VBUlRfQ0FQX05USU8n
IGZvciB0aGUgdW51c3VhbCB1bnN1cHBvcnRlZA0KY2FzZS4NCg0KRml4ZXM6IDFjMTZhZTY1ZTI1
MCAoInNlcmlhbDogODI1MDogb2Y6IEFkZCBuZXcgcG9ydCB0eXBlIGZvciBNZWRpYVRlayBCVElG
IGNvbnRyb2xsZXIgb24gTVQ3NjIyLzIzIFNvQyIpDQpDYzogU3RldmVuIExpdSA8c3RldmVuLmxp
dUBtZWRpYXRlay5jb20+DQpTdWdnZXN0ZWQtYnk6IEFuZHkgU2hldmNoZW5rbyA8YW5kcml5LnNo
ZXZjaGVua29AbGludXguaW50ZWwuY29tPg0KU2lnbmVkLW9mZi1ieTogU2VhbiBXYW5nIDxzZWFu
LndhbmdAbWVkaWF0ZWsuY29tPg0KU2lnbmVkLW9mZi1ieTogUnlkZXIgTGVlIDxyeWRlci5sZWVA
bWVkaWF0ZWsuY29tPg0KDQotLQ0KdjEtPnYyOg0Kbm8gY2hhbmdlIG9uIHRlcm1pb3MtPmNfY2Zs
YWcgYW5kIHJlZmluZSBjb21taXQgbWVzc2FnZQ0KDQp2Mi0+djM6DQpjaGFuZ2UgdGhlIG5hbWlu
ZyBmcm9tIE5NT0QgdG8gTlRJTyBhcyBUSU8gaXMgYSB3ZWxsIGVzdGFibGlzaGVkIHByZWZpeA0K
Zm9yIHRlcm1pb3MgSU9DVExzLg0KLS0tDQogZHJpdmVycy90dHkvc2VyaWFsLzgyNTAvODI1MC5o
ICAgICAgfCAxICsNCiBkcml2ZXJzL3R0eS9zZXJpYWwvODI1MC84MjUwX3BvcnQuYyB8IDUgKysr
Ky0NCiAyIGZpbGVzIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KDQpk
aWZmIC0tZ2l0IGEvZHJpdmVycy90dHkvc2VyaWFsLzgyNTAvODI1MC5oIGIvZHJpdmVycy90dHkv
c2VyaWFsLzgyNTAvODI1MC5oDQppbmRleCAzM2FkOWQ2ZGU1MzIuLjIzNGQ4ZGI0NzBjMCAxMDA2
NDQNCi0tLSBhL2RyaXZlcnMvdHR5L3NlcmlhbC84MjUwLzgyNTAuaA0KKysrIGIvZHJpdmVycy90
dHkvc2VyaWFsLzgyNTAvODI1MC5oDQpAQCAtODIsNiArODIsNyBAQCBzdHJ1Y3Qgc2VyaWFsODI1
MF9jb25maWcgew0KICNkZWZpbmUgVUFSVF9DQVBfTUlOSQkoMSA8PCAxNykJLyogTWluaSBVQVJU
IG9uIEJDTTI4M1ggZmFtaWx5IGxhY2tzOg0KIAkJCQkJICogU1RPUCBQQVJJVFkgRVBBUiBTUEFS
IFdMRU41IFdMRU42DQogCQkJCQkgKi8NCisjZGVmaW5lIFVBUlRfQ0FQX05USU8JKDEgPDwgMTgp
CS8qIFVBUlQgZG9lc24ndCBkbyB0ZXJtaW9zICovDQogDQogI2RlZmluZSBVQVJUX0JVR19RVU9U
CSgxIDw8IDApCS8qIFVBUlQgaGFzIGJ1Z2d5IHF1b3QgTFNCICovDQogI2RlZmluZSBVQVJUX0JV
R19UWEVOCSgxIDw8IDEpCS8qIFVBUlQgaGFzIGJ1Z2d5IFRYIElJUiBzdGF0dXMgKi8NCmRpZmYg
LS1naXQgYS9kcml2ZXJzL3R0eS9zZXJpYWwvODI1MC84MjUwX3BvcnQuYyBiL2RyaXZlcnMvdHR5
L3NlcmlhbC84MjUwLzgyNTBfcG9ydC5jDQppbmRleCAwMzI1ZjJlNTNiNzQuLmFiYzk3NGI0MTEz
ZiAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvdHR5L3NlcmlhbC84MjUwLzgyNTBfcG9ydC5jDQorKysg
Yi9kcml2ZXJzL3R0eS9zZXJpYWwvODI1MC84MjUwX3BvcnQuYw0KQEAgLTI4Niw3ICsyODYsNyBA
QCBzdGF0aWMgY29uc3Qgc3RydWN0IHNlcmlhbDgyNTBfY29uZmlnIHVhcnRfY29uZmlnW10gPSB7
DQogCQkudHhfbG9hZHN6CT0gMTYsDQogCQkuZmNyCQk9IFVBUlRfRkNSX0VOQUJMRV9GSUZPIHwN
CiAJCQkJICBVQVJUX0ZDUl9DTEVBUl9SQ1ZSIHwgVUFSVF9GQ1JfQ0xFQVJfWE1JVCwNCi0JCS5m
bGFncwkJPSBVQVJUX0NBUF9GSUZPLA0KKwkJLmZsYWdzCQk9IFVBUlRfQ0FQX0ZJRk8gfCBVQVJU
X0NBUF9OVElPLA0KIAl9LA0KIAlbUE9SVF9OUENNXSA9IHsNCiAJCS5uYW1lCQk9ICJOdXZvdG9u
IDE2NTUwIiwNCkBAIC0yNTQ0LDYgKzI1NDQsOSBAQCBzZXJpYWw4MjUwX2RvX3NldF90ZXJtaW9z
KHN0cnVjdCB1YXJ0X3BvcnQgKnBvcnQsIHN0cnVjdCBrdGVybWlvcyAqdGVybWlvcywNCiAJdW5z
aWduZWQgbG9uZyBmbGFnczsNCiAJdW5zaWduZWQgaW50IGJhdWQsIHF1b3QsIGZyYWMgPSAwOw0K
IA0KKwlpZiAodXAtPmNhcGFiaWxpdGllcyAmIFVBUlRfQ0FQX05USU8pDQorCQlyZXR1cm47DQor
DQogCWlmICh1cC0+Y2FwYWJpbGl0aWVzICYgVUFSVF9DQVBfTUlOSSkgew0KIAkJdGVybWlvcy0+
Y19jZmxhZyAmPSB+KENTVE9QQiB8IFBBUkVOQiB8IFBBUk9ERCB8IENNU1BBUik7DQogCQlpZiAo
KHRlcm1pb3MtPmNfY2ZsYWcgJiBDU0laRSkgPT0gQ1M1IHx8DQotLSANCjIuMjUuMQ0K


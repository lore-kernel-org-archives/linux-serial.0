Return-Path: <SRS0=ccOi=4O=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD719C4BA0B
	for <linux-serial@archiver.kernel.org>; Wed, 26 Feb 2020 08:54:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7512A20714
	for <linux-serial@archiver.kernel.org>; Wed, 26 Feb 2020 08:54:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="c40go33f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726132AbgBZIyE (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 26 Feb 2020 03:54:04 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:3943 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725872AbgBZIyD (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 26 Feb 2020 03:54:03 -0500
X-UUID: aa1ea91aa72b4f579898336d1bfe5998-20200226
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=6C9TgGDdkO5F5jXOiRjOlhQAyTOnDDs9QSKwWISWmG8=;
        b=c40go33fgEGK6WYjvd7AFM6CSmdG2pv7RFZOoKENJ9pd/G+RjsWm2XsWNdZuF0eX39KQ4t2mweXoD61fci2yYY7BgCgKMW6uYpEVKw4IvPlkKR+GMZWI/xzAVrGhkSJ2co/aTzKuuN0gKQCKiFTMB+NJt1HsQrZYXx69QyvNj8o=;
X-UUID: aa1ea91aa72b4f579898336d1bfe5998-20200226
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <changqi.hu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 251042541; Wed, 26 Feb 2020 16:53:59 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 26 Feb 2020 16:53:08 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 26 Feb 2020 16:53:45 +0800
From:   Changqi Hu <changqi.hu@mediatek.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     Vinod Koul <vkoul@kernel.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Frank Wunderlich <frank-w@public-files.de>,
        Claire Chang <tientzu@chromium.org>,
        <linux-serial@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, <linux-kernel@vger.kernel.org>,
        Yingjoe Chen <yingjoe.chen@mediatek.com>,
        Eddie Huang <eddie.huang@mediatek.com>,
        Changqi Hu <changqi.hu@mediatek.com>
Subject: [PATCH v4] serial: 8250-mtk: modify mtk uart power and clock management
Date:   Wed, 26 Feb 2020 16:53:45 +0800
Message-ID: <1582707225-26815-1-git-send-email-changqi.hu@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

TVRLIHVhcnQgZGVzaWduIG5vIG5lZWQgdG8gY29udHJvbCB1YXJ0IGNsb2NrLA0Kc28gd2UganVz
dCBjb250cm9sIGJ1cyBjbG9jayBpbiBydW50aW1lIGZ1bmN0aW9uLg0KQWRkIHVhcnQgY2xvY2sg
dXNlZCBjb3VudCB0byBhdm9pZCByZXBlYXRlZGx5IHN3aXRjaGluZyB0aGUgY2xvY2suDQoNClNp
Z25lZC1vZmYtYnk6IENoYW5ncWkgSHUgPGNoYW5ncWkuaHVAbWVkaWF0ZWsuY29tPg0KLS0tDQoN
CkNoYW5nZXMgaW4gdjQ6DQogTW9kaWZ5IGNvbW1pdC1tZXNzYWdlDQoNCkNoYW5nZXMgaW4gdjM6
DQogTWVyZ2UgcGF0Y2ggdjEgYW5kIHYyIHRvZ2V0aGVyLg0KIA0KQ2hhbmdlcyBpbiB2MjoNCiBF
bmFibGUgdWFydCBidXMgY2xvY2sgd2hlbiBwcm9iZSBhbmQgcmVzdW1lIGJhc2Ugb24gdjEgcGF0
Y2gsDQogYnV0IG1pc3MgdjEgcGF0Y2ggaXRzZWxmLg0KDQogZHJpdmVycy90dHkvc2VyaWFsLzgy
NTAvODI1MF9tdGsuYyB8IDUwICsrKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0t
DQogMSBmaWxlIGNoYW5nZWQsIDMyIGluc2VydGlvbnMoKyksIDE4IGRlbGV0aW9ucygtKQ0KDQpk
aWZmIC0tZ2l0IGEvZHJpdmVycy90dHkvc2VyaWFsLzgyNTAvODI1MF9tdGsuYyBiL2RyaXZlcnMv
dHR5L3NlcmlhbC84MjUwLzgyNTBfbXRrLmMNCmluZGV4IDRkMDY3ZjUuLmY4MzkzODAgMTAwNjQ0
DQotLS0gYS9kcml2ZXJzL3R0eS9zZXJpYWwvODI1MC84MjUwX210ay5jDQorKysgYi9kcml2ZXJz
L3R0eS9zZXJpYWwvODI1MC84MjUwX210ay5jDQpAQCAtMzIsNiArMzIsNyBAQA0KICNkZWZpbmUg
TVRLX1VBUlRfUlhUUklfQUQJMHgxNAkvKiBSWCBUcmlnZ2VyIGFkZHJlc3MgKi8NCiAjZGVmaW5l
IE1US19VQVJUX0ZSQUNESVZfTAkweDE1CS8qIEZyYWN0aW9uYWwgZGl2aWRlciBMU0IgYWRkcmVz
cyAqLw0KICNkZWZpbmUgTVRLX1VBUlRfRlJBQ0RJVl9NCTB4MTYJLyogRnJhY3Rpb25hbCBkaXZp
ZGVyIE1TQiBhZGRyZXNzICovDQorI2RlZmluZSBNVEtfVUFSVF9ERUJVRzAJMHgxOA0KICNkZWZp
bmUgTVRLX1VBUlRfSUVSX1hPRkZJCTB4MjAJLyogRW5hYmxlIFhPRkYgY2hhcmFjdGVyIGludGVy
cnVwdCAqLw0KICNkZWZpbmUgTVRLX1VBUlRfSUVSX1JUU0kJMHg0MAkvKiBFbmFibGUgUlRTIE1v
ZGVtIHN0YXR1cyBpbnRlcnJ1cHQgKi8NCiAjZGVmaW5lIE1US19VQVJUX0lFUl9DVFNJCTB4ODAJ
LyogRW5hYmxlIENUUyBNb2RlbSBzdGF0dXMgaW50ZXJydXB0ICovDQpAQCAtMzg4LDkgKzM4OSwx
OCBAQCBtdGs4MjUwX3NldF90ZXJtaW9zKHN0cnVjdCB1YXJ0X3BvcnQgKnBvcnQsIHN0cnVjdCBr
dGVybWlvcyAqdGVybWlvcywNCiBzdGF0aWMgaW50IF9fbWF5YmVfdW51c2VkIG10azgyNTBfcnVu
dGltZV9zdXNwZW5kKHN0cnVjdCBkZXZpY2UgKmRldikNCiB7DQogCXN0cnVjdCBtdGs4MjUwX2Rh
dGEgKmRhdGEgPSBkZXZfZ2V0X2RydmRhdGEoZGV2KTsNCisJc3RydWN0IHVhcnRfODI1MF9wb3J0
ICp1cCA9IHNlcmlhbDgyNTBfZ2V0X3BvcnQoZGF0YS0+bGluZSk7DQogDQotCWNsa19kaXNhYmxl
X3VucHJlcGFyZShkYXRhLT51YXJ0X2Nsayk7DQotCWNsa19kaXNhYmxlX3VucHJlcGFyZShkYXRh
LT5idXNfY2xrKTsNCisJLyogd2FpdCB1bnRpbCBVQVJUIGluIGlkbGUgc3RhdHVzICovDQorCXdo
aWxlDQorCQkoc2VyaWFsX2luKHVwLCBNVEtfVUFSVF9ERUJVRzApKTsNCisNCisJaWYgKGRhdGEt
PmNsa19jb3VudCA9PSAwVSkgew0KKwkJZGV2X2RiZyhkZXYsICIlcyBjbG9jayBjb3VudCBpcyAw
XG4iLCBfX2Z1bmNfXyk7DQorCX0gZWxzZSB7DQorCQljbGtfZGlzYWJsZV91bnByZXBhcmUoZGF0
YS0+YnVzX2Nsayk7DQorCQlkYXRhLT5jbGtfY291bnQtLTsNCisJfQ0KIA0KIAlyZXR1cm4gMDsN
CiB9DQpAQCAtNDAwLDE2ICs0MTAsMTYgQEAgc3RhdGljIGludCBfX21heWJlX3VudXNlZCBtdGs4
MjUwX3J1bnRpbWVfcmVzdW1lKHN0cnVjdCBkZXZpY2UgKmRldikNCiAJc3RydWN0IG10azgyNTBf
ZGF0YSAqZGF0YSA9IGRldl9nZXRfZHJ2ZGF0YShkZXYpOw0KIAlpbnQgZXJyOw0KIA0KLQllcnIg
PSBjbGtfcHJlcGFyZV9lbmFibGUoZGF0YS0+dWFydF9jbGspOw0KLQlpZiAoZXJyKSB7DQotCQlk
ZXZfd2FybihkZXYsICJDYW4ndCBlbmFibGUgY2xvY2tcbiIpOw0KLQkJcmV0dXJuIGVycjsNCi0J
fQ0KLQ0KLQllcnIgPSBjbGtfcHJlcGFyZV9lbmFibGUoZGF0YS0+YnVzX2Nsayk7DQotCWlmIChl
cnIpIHsNCi0JCWRldl93YXJuKGRldiwgIkNhbid0IGVuYWJsZSBidXMgY2xvY2tcbiIpOw0KLQkJ
cmV0dXJuIGVycjsNCisJaWYgKGRhdGEtPmNsa19jb3VudCA+IDBVKSB7DQorCQlkZXZfZGJnKGRl
diwgIiVzIGNsb2NrIGNvdW50IGlzICVkXG4iLCBfX2Z1bmNfXywNCisJCQlkYXRhLT5jbGtfY291
bnQpOw0KKwl9IGVsc2Ugew0KKwkJZXJyID0gY2xrX3ByZXBhcmVfZW5hYmxlKGRhdGEtPmJ1c19j
bGspOw0KKwkJaWYgKGVycikgew0KKwkJCWRldl93YXJuKGRldiwgIkNhbid0IGVuYWJsZSBidXMg
Y2xvY2tcbiIpOw0KKwkJCXJldHVybiBlcnI7DQorCQl9DQorCQlkYXRhLT5jbGtfY291bnQrKzsN
CiAJfQ0KIA0KIAlyZXR1cm4gMDsNCkBAIC00MTksMTIgKzQyOSwxNCBAQCBzdGF0aWMgdm9pZA0K
IG10azgyNTBfZG9fcG0oc3RydWN0IHVhcnRfcG9ydCAqcG9ydCwgdW5zaWduZWQgaW50IHN0YXRl
LCB1bnNpZ25lZCBpbnQgb2xkKQ0KIHsNCiAJaWYgKCFzdGF0ZSkNCi0JCXBtX3J1bnRpbWVfZ2V0
X3N5bmMocG9ydC0+ZGV2KTsNCisJCWlmICghbXRrODI1MF9ydW50aW1lX3Jlc3VtZShwb3J0LT5k
ZXYpKQ0KKwkJCXBtX3J1bnRpbWVfZ2V0X3N5bmMocG9ydC0+ZGV2KTsNCiANCiAJc2VyaWFsODI1
MF9kb19wbShwb3J0LCBzdGF0ZSwgb2xkKTsNCiANCiAJaWYgKHN0YXRlKQ0KLQkJcG1fcnVudGlt
ZV9wdXRfc3luY19zdXNwZW5kKHBvcnQtPmRldik7DQorCQlpZiAoIXBtX3J1bnRpbWVfcHV0X3N5
bmNfc3VzcGVuZChwb3J0LT5kZXYpKQ0KKwkJCW10azgyNTBfcnVudGltZV9zdXNwZW5kKHBvcnQt
PmRldik7DQogfQ0KIA0KICNpZmRlZiBDT05GSUdfU0VSSUFMXzgyNTBfRE1BDQpAQCAtNTAxLDYg
KzUxMyw4IEBAIHN0YXRpYyBpbnQgbXRrODI1MF9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNl
ICpwZGV2KQ0KIAlpZiAoIWRhdGEpDQogCQlyZXR1cm4gLUVOT01FTTsNCiANCisJZGF0YS0+Y2xr
X2NvdW50ID0gMDsNCisNCiAJaWYgKHBkZXYtPmRldi5vZl9ub2RlKSB7DQogCQllcnIgPSBtdGs4
MjUwX3Byb2JlX29mKHBkZXYsICZ1YXJ0LnBvcnQsIGRhdGEpOw0KIAkJaWYgKGVycikNCkBAIC01
MzMsNiArNTQ3LDcgQEAgc3RhdGljIGludCBtdGs4MjUwX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9k
ZXZpY2UgKnBkZXYpDQogDQogCXBsYXRmb3JtX3NldF9kcnZkYXRhKHBkZXYsIGRhdGEpOw0KIA0K
KwlwbV9ydW50aW1lX2VuYWJsZSgmcGRldi0+ZGV2KTsNCiAJZXJyID0gbXRrODI1MF9ydW50aW1l
X3Jlc3VtZSgmcGRldi0+ZGV2KTsNCiAJaWYgKGVycikNCiAJCXJldHVybiBlcnI7DQpAQCAtNTQx
LDkgKzU1Niw2IEBAIHN0YXRpYyBpbnQgbXRrODI1MF9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2
aWNlICpwZGV2KQ0KIAlpZiAoZGF0YS0+bGluZSA8IDApDQogCQlyZXR1cm4gZGF0YS0+bGluZTsN
CiANCi0JcG1fcnVudGltZV9zZXRfYWN0aXZlKCZwZGV2LT5kZXYpOw0KLQlwbV9ydW50aW1lX2Vu
YWJsZSgmcGRldi0+ZGV2KTsNCi0NCiAJZGF0YS0+cnhfd2FrZXVwX2lycSA9IHBsYXRmb3JtX2dl
dF9pcnFfb3B0aW9uYWwocGRldiwgMSk7DQogDQogCXJldHVybiAwOw0KQEAgLTU1NiwxMSArNTY4
LDEzIEBAIHN0YXRpYyBpbnQgbXRrODI1MF9yZW1vdmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAq
cGRldikNCiAJcG1fcnVudGltZV9nZXRfc3luYygmcGRldi0+ZGV2KTsNCiANCiAJc2VyaWFsODI1
MF91bnJlZ2lzdGVyX3BvcnQoZGF0YS0+bGluZSk7DQotCW10azgyNTBfcnVudGltZV9zdXNwZW5k
KCZwZGV2LT5kZXYpOw0KIA0KIAlwbV9ydW50aW1lX2Rpc2FibGUoJnBkZXYtPmRldik7DQogCXBt
X3J1bnRpbWVfcHV0X25vaWRsZSgmcGRldi0+ZGV2KTsNCiANCisJaWYgKCFwbV9ydW50aW1lX3N0
YXR1c19zdXNwZW5kZWQoJnBkZXYtPmRldikpDQorCQltdGs4MjUwX3J1bnRpbWVfc3VzcGVuZCgm
cGRldi0+ZGV2KTsNCisNCiAJcmV0dXJuIDA7DQogfQ0KIA0KLS0gDQoyLjYuNA0K


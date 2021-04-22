Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99418C433ED
	for <linux-serial@archiver.kernel.org>; Thu, 22 Apr 2021 09:36:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D1FE613D8
	for <linux-serial@archiver.kernel.org>; Thu, 22 Apr 2021 09:36:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235714AbhDVJg5 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 22 Apr 2021 05:36:57 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:15318 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S235634AbhDVJg4 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 22 Apr 2021 05:36:56 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13M9VlZS023317;
        Thu, 22 Apr 2021 11:36:17 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=selector1;
 bh=o33RAt1XHVdixMFZfZhj+UliAZ6I/t29YVBT4vCe2dQ=;
 b=X4Xm2AFhZXneMgKZyWttWIwCpckrzrqSh9w4nGBLDJ0SSQohXXNyKigyFYY8GOBUzKY4
 f5k22cS0u+XXWGVOxrYuruA+FQvAYL0UgnO6YDAmP+aEQ7lmxSRN76VqYzhyIyJUW0me
 xOwKmKk9zRDdD8H1lwq7GamFgK/NttzoeyrhCvDkwNTB3RXfjreGVU2lpf7HkhZFgEnm
 iqNrlFugs74QZEJViD+5P4D7SFlA3Vhc2bd2TLqnMQm0voguyGKOC47ywvuKmQr7bsMw
 SwbNnJySm2tZQKtVNf3bH1wPoz0s59YugJD/WrDK91EXezA1hsCBLSPh5YDaNV1W9KXd kQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 382fxqfspj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 22 Apr 2021 11:36:17 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id E17AA10002A;
        Thu, 22 Apr 2021 11:36:16 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id D3CC525F40A;
        Thu, 22 Apr 2021 11:36:16 +0200 (CEST)
Received: from SFHDAG2NODE3.st.com (10.75.127.6) by SFHDAG2NODE2.st.com
 (10.75.127.5) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 22 Apr
 2021 11:36:16 +0200
Received: from SFHDAG2NODE3.st.com ([fe80::31b3:13bf:2dbe:f64c]) by
 SFHDAG2NODE3.st.com ([fe80::31b3:13bf:2dbe:f64c%20]) with mapi id
 15.00.1497.012; Thu, 22 Apr 2021 11:36:16 +0200
From:   Valentin CARON - foss <valentin.caron@foss.st.com>
To:     Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Jiri Slaby <jirislaby@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre TORGUE - foss <alexandre.torgue@foss.st.com>,
        "dillon.minfei@gmail.com" <dillon.minfei@gmail.com>,
        Erwan LE-RAY - foss <erwan.leray@foss.st.com>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/3] serial: stm32: defer sysrq processing
Thread-Topic: [PATCH 3/3] serial: stm32: defer sysrq processing
Thread-Index: AQHXMspsia+oZQy/vk+qX8FsYH6tuqrALsYA
Date:   Thu, 22 Apr 2021 09:36:16 +0000
Message-ID: <496a5b3e-84e3-99a7-0b4f-c8b27cda34f4@foss.st.com>
References: <20210416140557.25177-1-johan@kernel.org>
 <20210416140557.25177-4-johan@kernel.org>
In-Reply-To: <20210416140557.25177-4-johan@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.50]
Content-Type: text/plain; charset="utf-8"
Content-ID: <A64FDF6D9952EC43B67E66EB9669367A@st.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-22_01:2021-04-21,2021-04-21 signatures=0
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

SGksDQoNCk9uIDQvMTYvMjEgNDowNSBQTSwgSm9oYW4gSG92b2xkIHdyb3RlOg0KPiBVc2UgdGhl
IHVhcnRfdW5sb2NrX2FuZF9jaGVja19zeXNycSgpIGhlbHBlciB0byBkZWZlciBzeXNycSBwcm9j
ZXNzaW5nDQo+IHVudGlsIHJlY2VpdmUgcHJvY2Vzc2luZyBpcyBkb25lIGFuZCB0aGUgcG9ydCBs
b2NrIGhhcyBiZWVuIHJlbGVhc2VkLg0KPg0KPiBUaGlzIGFsbG93cyBjbGVhbmluZyB1cCB0aGUg
Y29uc29sZV93cml0ZSgpIGltcGxlbWVudGF0aW9uIGJ5IG5vdCBoYXZpbmcNCj4gdG8gd29yayBh
cm91bmQgdGhlIHJlY3Vyc2l2ZSBzeXNycSBjYXNlIChieSBkcm9wcGluZyBsb2NraW5nIGNvbXBs
ZXRlbHkpDQo+IGFuZCBhbHNvIG1ha2VzIHRoZSBjb25zb2xlIGNvZGUgd29yayB3aXRoIFBSRUVN
UFRfUlQgYnkgbm8gbG9uZ2VyDQo+IHJlbHlpbmcgb24gbG9jYWxfaXJxX3NhdmUoKS4NCj4NCj4g
U2lnbmVkLW9mZi1ieTogSm9oYW4gSG92b2xkIDxqb2hhbkBrZXJuZWwub3JnPg0KDQpSZXZpZXdl
ZC1ieTogVmFsZW50aW4gQ2Fyb248dmFsZW50aW4uY2Fyb25AZm9zcy5zdC5jb20+DQoNCj4gLS0t
DQo+ICAgZHJpdmVycy90dHkvc2VyaWFsL3N0bTMyLXVzYXJ0LmMgfCAxNiArKysrKystLS0tLS0t
LS0tDQo+ICAgMSBmaWxlIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKSwgMTAgZGVsZXRpb25zKC0p
DQo+DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3R0eS9zZXJpYWwvc3RtMzItdXNhcnQuYyBiL2Ry
aXZlcnMvdHR5L3NlcmlhbC9zdG0zMi11c2FydC5jDQo+IGluZGV4IDM1MjRlZDJjMGM3My4uMjRh
MWRmZTcwNThiIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3R0eS9zZXJpYWwvc3RtMzItdXNhcnQu
Yw0KPiArKysgYi9kcml2ZXJzL3R0eS9zZXJpYWwvc3RtMzItdXNhcnQuYw0KPiBAQCAtMjcwLDEy
ICsyNzAsMTIgQEAgc3RhdGljIHZvaWQgc3RtMzJfdXNhcnRfcmVjZWl2ZV9jaGFycyhzdHJ1Y3Qg
dWFydF9wb3J0ICpwb3J0LCBib29sIHRocmVhZGVkKQ0KPiAgIAkJCX0NCj4gICAJCX0NCj4gICAN
Cj4gLQkJaWYgKHVhcnRfaGFuZGxlX3N5c3JxX2NoYXIocG9ydCwgYykpDQo+ICsJCWlmICh1YXJ0
X3ByZXBhcmVfc3lzcnFfY2hhcihwb3J0LCBjKSkNCj4gICAJCQljb250aW51ZTsNCj4gICAJCXVh
cnRfaW5zZXJ0X2NoYXIocG9ydCwgc3IsIFVTQVJUX1NSX09SRSwgYywgZmxhZyk7DQo+ICAgCX0N
Cj4gICANCj4gLQlzcGluX3VubG9jaygmcG9ydC0+bG9jayk7DQo+ICsJdWFydF91bmxvY2tfYW5k
X2NoZWNrX3N5c3JxKHBvcnQpOw0KPiAgIA0KPiAgIAl0dHlfZmxpcF9idWZmZXJfcHVzaCh0cG9y
dCk7DQo+ICAgfQ0KPiBAQCAtMTQzMCwxMyArMTQzMCwxMCBAQCBzdGF0aWMgdm9pZCBzdG0zMl91
c2FydF9jb25zb2xlX3dyaXRlKHN0cnVjdCBjb25zb2xlICpjbywgY29uc3QgY2hhciAqcywNCj4g
ICAJdTMyIG9sZF9jcjEsIG5ld19jcjE7DQo+ICAgCWludCBsb2NrZWQgPSAxOw0KPiAgIA0KPiAt
CWxvY2FsX2lycV9zYXZlKGZsYWdzKTsNCj4gLQlpZiAocG9ydC0+c3lzcnEpDQo+IC0JCWxvY2tl
ZCA9IDA7DQo+IC0JZWxzZSBpZiAob29wc19pbl9wcm9ncmVzcykNCj4gLQkJbG9ja2VkID0gc3Bp
bl90cnlsb2NrKCZwb3J0LT5sb2NrKTsNCj4gKwlpZiAob29wc19pbl9wcm9ncmVzcykNCj4gKwkJ
bG9ja2VkID0gc3Bpbl90cnlsb2NrX2lycXNhdmUoJnBvcnQtPmxvY2ssIGZsYWdzKTsNCj4gICAJ
ZWxzZQ0KPiAtCQlzcGluX2xvY2soJnBvcnQtPmxvY2spOw0KPiArCQlzcGluX2xvY2tfaXJxc2F2
ZSgmcG9ydC0+bG9jaywgZmxhZ3MpOw0KPiAgIA0KPiAgIAkvKiBTYXZlIGFuZCBkaXNhYmxlIGlu
dGVycnVwdHMsIGVuYWJsZSB0aGUgdHJhbnNtaXR0ZXIgKi8NCj4gICAJb2xkX2NyMSA9IHJlYWRs
X3JlbGF4ZWQocG9ydC0+bWVtYmFzZSArIG9mcy0+Y3IxKTsNCj4gQEAgLTE0NTAsOCArMTQ0Nyw3
IEBAIHN0YXRpYyB2b2lkIHN0bTMyX3VzYXJ0X2NvbnNvbGVfd3JpdGUoc3RydWN0IGNvbnNvbGUg
KmNvLCBjb25zdCBjaGFyICpzLA0KPiAgIAl3cml0ZWxfcmVsYXhlZChvbGRfY3IxLCBwb3J0LT5t
ZW1iYXNlICsgb2ZzLT5jcjEpOw0KPiAgIA0KPiAgIAlpZiAobG9ja2VkKQ0KPiAtCQlzcGluX3Vu
bG9jaygmcG9ydC0+bG9jayk7DQo+IC0JbG9jYWxfaXJxX3Jlc3RvcmUoZmxhZ3MpOw0KPiArCQlz
cGluX3VubG9ja19pcnFyZXN0b3JlKCZwb3J0LT5sb2NrLCBmbGFncyk7DQo+ICAgfQ0KPiAgIA0K
PiAgIHN0YXRpYyBpbnQgc3RtMzJfdXNhcnRfY29uc29sZV9zZXR1cChzdHJ1Y3QgY29uc29sZSAq
Y28sIGNoYXIgKm9wdGlvbnMp

Return-Path: <SRS0=FKjJ=45=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.4 required=3.0 tests=CHARSET_FARAWAY_HEADER,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E4C6C10DCE
	for <linux-serial@archiver.kernel.org>; Thu, 12 Mar 2020 09:22:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43A14206F1
	for <linux-serial@archiver.kernel.org>; Thu, 12 Mar 2020 09:22:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726194AbgCLJWJ (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 12 Mar 2020 05:22:09 -0400
Received: from mx1.unisoc.com ([222.66.158.135]:65318 "EHLO SHSQR01.unisoc.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726099AbgCLJWJ (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 12 Mar 2020 05:22:09 -0400
X-Greylist: delayed 1737 seconds by postgrey-1.27 at vger.kernel.org; Thu, 12 Mar 2020 05:22:02 EDT
Received: from SHSQR01.spreadtrum.com (localhost [127.0.0.2] (may be forged))
        by SHSQR01.unisoc.com with ESMTP id 02C8r4Ce093205
        for <linux-serial@vger.kernel.org>; Thu, 12 Mar 2020 16:53:04 +0800 (CST)
        (envelope-from lanqing.liu@unisoc.com)
Received: from ig2.spreadtrum.com (shmbx01.spreadtrum.com [10.0.1.203])
        by SHSQR01.spreadtrum.com with ESMTPS id 02C8qRkJ092461
        (version=TLSv1 cipher=AES256-SHA bits=256 verify=NO);
        Thu, 12 Mar 2020 16:52:27 +0800 (CST)
        (envelope-from lanqing.liu@unisoc.com)
Received: from SHMBX04.spreadtrum.com (10.0.1.214) by SHMBX01.spreadtrum.com
 (10.0.1.203) with Microsoft SMTP Server (TLS) id 15.0.847.32; Thu, 12 Mar
 2020 16:52:27 +0800
Received: from SHMBX04.spreadtrum.com ([fe80::8532:ef18:9217:26f5]) by
 shmbx04.spreadtrum.com ([fe80::8532:ef18:9217:26f5%13]) with mapi id
 15.00.0847.030; Thu, 12 Mar 2020 16:52:27 +0800
From:   =?gb2312?B?wfXhsMflIChMYW5xaW5nIExpdSk=?= <lanqing.liu@unisoc.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
CC:     "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
Subject: =?gb2312?B?tPC4tDogW2J1ZyByZXBvcnRdIHNlcmlhbDogc3ByZDogQWRkIERNQSBtb2Rl?=
 =?gb2312?Q?_support?=
Thread-Topic: [bug report] serial: sprd: Add DMA mode support
Thread-Index: AQHV+ESKFrrpFehFkkWFw8Z1gJOBfKhEpT7A
Date:   Thu, 12 Mar 2020 08:52:26 +0000
Message-ID: <b533994dcd064df6941911b41e1bf430@shmbx04.spreadtrum.com>
References: <20200312080117.GA3881@mwanda>
In-Reply-To: <20200312080117.GA3881@mwanda>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.0.1.248]
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MAIL: SHSQR01.spreadtrum.com 02C8qRkJ092461
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

SGkgZGFuIGNhcnBlbnRlcg0KDQpUaGFuayB5b3UgZm9yIHlvdXIgcmV2aWV3IGNvZGUuDQpJIHdp
bGwgY29tbWl0IGEgbmV3IHBhdGNoIHRvIGZpeCB0aGlzIHdhcm5pbmcuDQoNCkJSDQpsaXVsYW5x
aW5nDQoNCg0KLS0tLS3Tyrz+1K28/i0tLS0tDQq3orz+yMs6IERhbiBDYXJwZW50ZXIgW21haWx0
bzpkYW4uY2FycGVudGVyQG9yYWNsZS5jb21dDQq3osvNyrG85DogMjAyMMTqM9TCMTLI1SAxNjow
MQ0KytW8/sjLOiDB9eGwx+UgKExhbnFpbmcgTGl1KQ0Ks63LzTogbGludXgtc2VyaWFsQHZnZXIu
a2VybmVsLm9yZw0K1vfM4jogW2J1ZyByZXBvcnRdIHNlcmlhbDogc3ByZDogQWRkIERNQSBtb2Rl
IHN1cHBvcnQNCg0KSGVsbG8gTGFucWluZyBMaXUsDQoNClRoZSBwYXRjaCBmNDQ4N2RiNThlYjc6
ICJzZXJpYWw6IHNwcmQ6IEFkZCBETUEgbW9kZSBzdXBwb3J0IiBmcm9tIE1hciA0LCAyMDE5LCBs
ZWFkcyB0byB0aGUgZm9sbG93aW5nIHN0YXRpYyBjaGVja2VyIHdhcm5pbmc6DQoNCmRyaXZlcnMv
dHR5L3NlcmlhbC9zcHJkX3NlcmlhbC5jOjExNDEgc3ByZF9yZW1vdmUoKQ0KZXJyb3I6IHdlIHBy
ZXZpb3VzbHkgYXNzdW1lZCAnc3VwJyBjb3VsZCBiZSBudWxsIChzZWUgbGluZSAxMTMyKQ0KDQpk
cml2ZXJzL3R0eS9zZXJpYWwvc3ByZF9zZXJpYWwuYw0KICAxMTI4ICBzdGF0aWMgaW50IHNwcmRf
cmVtb3ZlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKmRldikNCiAgMTEyOSAgew0KICAxMTMwICAg
ICAgICAgIHN0cnVjdCBzcHJkX3VhcnRfcG9ydCAqc3VwID0gcGxhdGZvcm1fZ2V0X2RydmRhdGEo
ZGV2KTsNCiAgMTEzMQ0KICAxMTMyICAgICAgICAgIGlmIChzdXApIHsNCiAgICAgICAgICAgICAg
ICAgICAgXl5eDQpDaGVjaw0KDQogIDExMzMgICAgICAgICAgICAgICAgICB1YXJ0X3JlbW92ZV9v
bmVfcG9ydCgmc3ByZF91YXJ0X2RyaXZlciwgJnN1cC0+cG9ydCk7DQogIDExMzQgICAgICAgICAg
ICAgICAgICBzcHJkX3BvcnRbc3VwLT5wb3J0LmxpbmVdID0gTlVMTDsNCiAgMTEzNSAgICAgICAg
ICAgICAgICAgIHNwcmRfcG9ydHNfbnVtLS07DQogIDExMzYgICAgICAgICAgfQ0KICAxMTM3DQog
IDExMzggICAgICAgICAgaWYgKCFzcHJkX3BvcnRzX251bSkNCiAgMTEzOSAgICAgICAgICAgICAg
ICAgIHVhcnRfdW5yZWdpc3Rlcl9kcml2ZXIoJnNwcmRfdWFydF9kcml2ZXIpOw0KICAxMTQwDQog
IDExNDEgICAgICAgICAgc3ByZF9yeF9mcmVlX2J1ZihzdXApOw0KICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgXl5eDQpVbmNoZWNrZWQgZGVyZWZlcmVuY2UgaW5zaWRlIGZ1bmN0aW9u
DQoNCiAgMTE0Mg0KICAxMTQzICAgICAgICAgIHJldHVybiAwOw0KICAxMTQ0ICB9DQoNCnJlZ2Fy
ZHMsDQpkYW4gY2FycGVudGVyDQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXw0KIFRo
aXMgZW1haWwgKGluY2x1ZGluZyBpdHMgYXR0YWNobWVudHMpIGlzIGludGVuZGVkIG9ubHkgZm9y
IHRoZSBwZXJzb24gb3IgZW50aXR5IHRvIHdoaWNoIGl0IGlzIGFkZHJlc3NlZCBhbmQgbWF5IGNv
bnRhaW4gaW5mb3JtYXRpb24gdGhhdCBpcyBwcml2aWxlZ2VkLCBjb25maWRlbnRpYWwgb3Igb3Ro
ZXJ3aXNlIHByb3RlY3RlZCBmcm9tIGRpc2Nsb3N1cmUuIFVuYXV0aG9yaXplZCB1c2UsIGRpc3Nl
bWluYXRpb24sIGRpc3RyaWJ1dGlvbiBvciBjb3B5aW5nIG9mIHRoaXMgZW1haWwgb3IgdGhlIGlu
Zm9ybWF0aW9uIGhlcmVpbiBvciB0YWtpbmcgYW55IGFjdGlvbiBpbiByZWxpYW5jZSBvbiB0aGUg
Y29udGVudHMgb2YgdGhpcyBlbWFpbCBvciB0aGUgaW5mb3JtYXRpb24gaGVyZWluLCBieSBhbnlv
bmUgb3RoZXIgdGhhbiB0aGUgaW50ZW5kZWQgcmVjaXBpZW50LCBvciBhbiBlbXBsb3llZSBvciBh
Z2VudCByZXNwb25zaWJsZSBmb3IgZGVsaXZlcmluZyB0aGUgbWVzc2FnZSB0byB0aGUgaW50ZW5k
ZWQgcmVjaXBpZW50LCBpcyBzdHJpY3RseSBwcm9oaWJpdGVkLiBJZiB5b3UgYXJlIG5vdCB0aGUg
aW50ZW5kZWQgcmVjaXBpZW50LCBwbGVhc2UgZG8gbm90IHJlYWQsIGNvcHksIHVzZSBvciBkaXNj
bG9zZSBhbnkgcGFydCBvZiB0aGlzIGUtbWFpbCB0byBvdGhlcnMuIFBsZWFzZSBub3RpZnkgdGhl
IHNlbmRlciBpbW1lZGlhdGVseSBhbmQgcGVybWFuZW50bHkgZGVsZXRlIHRoaXMgZS1tYWlsIGFu
ZCBhbnkgYXR0YWNobWVudHMgaWYgeW91IHJlY2VpdmVkIGl0IGluIGVycm9yLiBJbnRlcm5ldCBj
b21tdW5pY2F0aW9ucyBjYW5ub3QgYmUgZ3VhcmFudGVlZCB0byBiZSB0aW1lbHksIHNlY3VyZSwg
ZXJyb3ItZnJlZSBvciB2aXJ1cy1mcmVlLiBUaGUgc2VuZGVyIGRvZXMgbm90IGFjY2VwdCBsaWFi
aWxpdHkgZm9yIGFueSBlcnJvcnMgb3Igb21pc3Npb25zLg0Ksb7Tyrz+vLDG5Li9vP6+39PQsaPD
3NDU1sqjrMrct6jCybGju6Syu7XD0LnCtqOsvfa3osvNuPixvtPKvP7L+da4zNi2qMrVvP7Iy6Gj
0c+9+7fHvq3K2sioyrnTw6Gi0Pu0q6Git6KyvLvyuLTWxrG+08q8/rvyxuTE2sjdoaPI9LfHuMPM
2LaoytW8/sjLo6zH687w1MS2waGiuLTWxqGiIMq508O78sX7wraxvtPKvP61xMjOus7E2sjdoaPI
9M7zytWxvtPKvP6jrMfrtNPPtc2z1tDTwL7D0NTJvrP9sb7Tyrz+vLDL+dPQuL28/qOssqLS1LvY
uLTTyrz+tcS3vcq9vLS/zLjm1qq3orz+yMuho87et6ixo9aku6XBqs34zajQxbywyrGhorCyyKuh
os7ezvO78rfAtr6ho7eivP7Iy7bUyM66zrTtwqm++bK7s9C1o9TwyM6how0K

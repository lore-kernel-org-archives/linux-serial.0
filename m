From: Yao Yuan <yao.yuan@freescale.com>
Subject: RE: [PATCH v3 2/2] serial: fsl_lpuart: add DMA support
Date: Thu, 16 Jan 2014 08:19:18 +0000
Message-ID: <4a519c52821b4ceb841cbefcf2a0432b@BL2PR03MB338.namprd03.prod.outlook.com>
References: <1389763265-27300-2-git-send-email-yao.yuan@freescale.com>
 <1389763265-27300-3-git-send-email-yao.yuan@freescale.com>
 <201401151025.34628.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from [207.46.163.240] ([207.46.163.240]:33404 "EHLO
	na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750836AbaAPITc (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Thu, 16 Jan 2014 03:19:32 -0500
In-Reply-To: <201401151025.34628.arnd@arndb.de>
Content-Language: en-US
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "shawn.guo@linaro.org" <shawn.guo@linaro.org>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>

SGksIEFybmQNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+ICAjZGVmaW5lIERS
SVZFUl9OQU1FCSJmc2wtbHB1YXJ0Ig0KPiA+ICAjZGVmaW5lIERFVl9OQU1FCSJ0dHlMUCINCj4g
PiAgI2RlZmluZSBVQVJUX05SCQk2DQo+ID4gQEAgLTEyMSw2ICsxMzIsMjYgQEAgc3RydWN0IGxw
dWFydF9wb3J0IHsNCj4gPiAgCXN0cnVjdCBjbGsJCSpjbGs7DQo+ID4gIAl1bnNpZ25lZCBpbnQJ
CXR4Zmlmb19zaXplOw0KPiA+ICAJdW5zaWduZWQgaW50CQlyeGZpZm9fc2l6ZTsNCj4gPiArDQo+
ID4gKyNpZmRlZiBDT05GSUdfU0VSSUFMX0ZTTF9MUFVBUlRfRE1BDQo+ID4gKwlib29sCQkJbHB1
YXJ0X2RtYV91c2U7DQo+ID4gKwlzdHJ1Y3QgZG1hX2NoYW4JCSpkbWFfdHhfY2hhbjsNCj4gPiAr
CXN0cnVjdCBkbWFfY2hhbgkJKmRtYV9yeF9jaGFuOw0KPiA+ICsJc3RydWN0IGRtYV9hc3luY190
eF9kZXNjcmlwdG9yICAqZG1hX3R4X2Rlc2M7DQo+ID4gKwlzdHJ1Y3QgZG1hX2FzeW5jX3R4X2Rl
c2NyaXB0b3IgICpkbWFfcnhfZGVzYzsNCj4gPiArCWRtYV9hZGRyX3QJCWRtYV90eF9idWZfYnVz
Ow0KPiA+ICsJZG1hX2FkZHJfdAkJZG1hX3J4X2J1Zl9idXM7DQo+ID4gKwlkbWFfY29va2llX3QJ
CWRtYV90eF9jb29raWU7DQo+ID4gKwlkbWFfY29va2llX3QJCWRtYV9yeF9jb29raWU7DQo+ID4g
Kwl1bnNpZ25lZCBjaGFyCQkqZG1hX3R4X2J1Zl92aXJ0Ow0KPiA+ICsJdW5zaWduZWQgY2hhcgkJ
KmRtYV9yeF9idWZfdmlydDsNCj4gPiArCXVuc2lnbmVkIGludAkJZG1hX3R4X2J5dGVzOw0KPiA+
ICsJdW5zaWduZWQgaW50CQlkbWFfcnhfYnl0ZXM7DQo+ID4gKwlpbnQJCQlkbWFfdHhfaW5fcHJv
Z3Jlc3M7DQo+ID4gKwlpbnQJCQlkbWFfcnhfaW5fcHJvZ3Jlc3M7DQo+ID4gKwl1bnNpZ25lZCBp
bnQJCWRtYV9yeF90aW1lb3V0Ow0KPiA+ICsJc3RydWN0IHRpbWVyX2xpc3QJbHB1YXJ0X3RpbWVy
Ow0KPiA+ICsjZW5kaWYNCj4gPiAgfTsNCj4gDQo+IFRoaXMgcGFydCB3aWxsIHJlc3VsdCBpbiBh
IHNsaWdodCBpbmNyZWFzZSBpbiBkYXRhIHNpemUgZXZlbiBpZiBkbWENCj4gc3VwcG9ydCBpcyB0
dXJuZWQgb2ZmIGF0IGNvbXBpbGUgdGltZS4NCj4gDQoNClllcywgc29tZW9uZSBhbHNvIHdhbnQg
bWUgZGVmaW5lIGEgaW5kZXBlbmRlbnQgc3RydWN0IGZvciBkbWEgYW5kIGFsbG9jYXRlIHRoZSBt
ZW1vcnkgd2hlbiBkbWEgYmUgdXNlLg0KQnV0IEkgdGhpbmsgdGhpcyB3YXkgd2lsbCBhZGQgYSBt
b3JlIG1lbW9yeSBhY2Nlc3MgdGltZSwgbGlrZSBhLT5iLT5jIGFuZCBhLT5jLiBBbmQgdGhlIHZh
cmlhYmxlIA0KYWJvdXQgZG1hIGlzIGp1c3QgYSBmZXcgYnl0ZXMgYnV0IHVzZWQgZnJlcXVlbnRs
eS4gU28gSSB0aGluayBJJ2QgYmV0dGVyIGRlZmluZSB0aGUgdmFyaWFibGUgYWJvdXQgZG1hIGlu
IGxwdWFydF9wb3J0IHN0cnVjdC4NCg0K

From: Lu Jingchang-B35083 <B35083@freescale.com>
Subject: RE: [PATCH v6] tty: serial: add Freescale lpuart driver support
Date: Fri, 7 Jun 2013 01:48:46 +0000
Message-ID: <B56CDBE15CE27145A4B77D2D24263E851CFC25@039-SN1MPN1-003.039d.mgd.msft.net>
References: <1370309270-21019-1-git-send-email-b35083@freescale.com>
	<20130606200519.GA1644@kroah.com>
 <CAOMZO5D+NLMc=10=iF6bd=3aav9ePZBQEJY7WKJpkp+fA=Cp1w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from tx2ehsobe002.messaging.microsoft.com ([65.55.88.12]:2632 "EHLO
	tx2outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752202Ab3FGBtQ (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 6 Jun 2013 21:49:16 -0400
In-Reply-To: <CAOMZO5D+NLMc=10=iF6bd=3aav9ePZBQEJY7WKJpkp+fA=Cp1w@mail.gmail.com>
Content-Language: en-US
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Fabio Estevam <festevam@gmail.com>, Greg KH <gregkh@linuxfoundation.org>
Cc: "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "shawn.guo@linaro.org" <shawn.guo@linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>

Pj4gVGhpcyBicmVha3MgdGhlIGJ1aWxkIG9uIHg4NiBzeXN0ZW1zIHdpdGg6DQo+PiAgIENDIFtN
XSAgZHJpdmVycy90dHkvc2VyaWFsL2ZzbF9scHVhcnQubw0KPj4gZHJpdmVycy90dHkvc2VyaWFs
L2ZzbF9scHVhcnQuYzogSW4gZnVuY3Rpb24g4oCYbHB1YXJ0X3Byb2Jl4oCZOg0KPj4gZHJpdmVy
cy90dHkvc2VyaWFsL2ZzbF9scHVhcnQuYzo3NTE6MjogZXJyb3I6IGltcGxpY2l0IGRlY2xhcmF0
aW9uIG9mDQo+PiBmdW5jdGlvbiDigJhvZl9hbGlhc19nZXRfaWTigJkgWy1XZXJyb3I9aW1wbGlj
aXQtZnVuY3Rpb24tZGVjbGFyYXRpb25dDQo+Pg0KPj4gc28gSSBjYW4ndCB0YWtlIHRoaXMgOigN
Cj4NCj5PbiBpbXggc2VyaWFsIGRyaXZlciB0aGlzIGJ1aWxkIGVycm9yIGlzIGF2b2lkZWQgYnkg
cHJvdGVjdGluZyB0aGUNCj5zZXJpYWxfaW14X3Byb2JlX2R0KCkgd2l0aCAiI2lmZGVmIENPTkZJ
R19PRiIgYW5kIHlvdSBjb3VsZCBzbyB0aGUgc2FtZSBvbg0KPnRoZSBmc2xfbHBhdXJ0IGRyaXZl
ciB0byBhdm9pZCB0aGUgYnVpbGQgaXNzdWUgdGhhdCBHcmVnIHJlcG9ydGVkLg0KDQpbTHUgSmlu
Z2NoYW5nLUIzNTA4M10gDQogIGlteCBzZXJpYWwgZHJpdmVyIHN1cHBvcnRzIGR0IGFuZCBub24t
ZHQgdWFydCBkZXZpY2UsICIjaWZkZWYgQ09ORklHX09GIiBzZWVtcw0KdG8gZGlzdGluZ3Vpc2gg
dGhlc2UsIGJ1dCBmc2xfbHB1YXJ0IG9ubHkgc3VwcG9ydCBkdCBkZXZpY2UuIA0KICBvZl9hbGlh
c19nZXRfaWQgaXMgZGVmaW5lZCBpbiA8bGludXgvb2YuaD4sIGl0J3MgcmVmZXJlbmNlZCBieSA8
bGludXgvb2ZfZGV2aWNlLmg+DQpidXQgd2l0aCAiI2lmZGVmIENPTkZJR19PRl9ERVZJQ0UiIHJl
c3RyaWN0aW9uLiBTbyBpbmRpcmVjdGx5IHJlZmVyZW5jaW5nICJvZi5oIiBieQ0KIm9mX2Rldmlj
ZS5oIiB3aXRob3V0IENPTkZJR19PRl9ERVZJQ0Ugb3B0aW9uIHdpbGwgY2F1c2UgYnVpbGQgZXJy
b3IuIEFkZCBkaXJlY3QNCnJlZmVyZW5jZSB0byAiPGxpbnV4L29mLmg+IiBpbiBkcml2ZXIgY2Fu
IHJlc29sdmUgdGhpcyBlcnJvci4NClRoYW5rcyENCg0KDQoNCg==


From: Noam Camus <noamc@ezchip.com>
Subject: RE: [PATCH 1/4] serial: 8250_dw: Add support for big-endian MMIO
 accesses
Date: Thu, 23 Jul 2015 06:15:14 +0000
Message-ID: <DB4PR02MB272E79444E7C044767FEF22D6820@DB4PR02MB272.eurprd02.prod.outlook.com>
References: <1437557699-25722-1-git-send-email-noamc@ezchip.com>
 <1437557699-25722-2-git-send-email-noamc@ezchip.com>
 <55AF8A34.2060900@hurleysoftware.com> <55AF8F72.6070000@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <55AF8F72.6070000@hurleysoftware.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Hurley <peter@hurleysoftware.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "Alexey.Brodkin@synopsys.com" <Alexey.Brodkin@synopsys.com>, "vgupta@synopsys.com" <vgupta@synopsys.com>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "jslaby@suse.com" <jslaby@suse.com>
List-Id: linux-serial@vger.kernel.org

RnJvbTogUGV0ZXIgSHVybGV5IFttYWlsdG86cGV0ZXJAaHVybGV5c29mdHdhcmUuY29tXSANClNl
bnQ6IFdlZG5lc2RheSwgSnVseSAyMiwgMjAxNSAzOjQxIFBNDQoNCj4+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL3R0eS9zZXJpYWwvODI1MC84MjUwX2R3LmMgDQo+PiBiL2RyaXZlcnMvdHR5L3Nlcmlh
bC84MjUwLzgyNTBfZHcuYw0KPj4gaW5kZXggZDQ4YjUwNi4uZmUwYjQ4NyAxMDA2NDQNCj4+IC0t
LSBhL2RyaXZlcnMvdHR5L3NlcmlhbC84MjUwLzgyNTBfZHcuYw0KPj4gKysrIGIvZHJpdmVycy90
dHkvc2VyaWFsLzgyNTAvODI1MF9kdy5jDQo+PiBAQCAtMTczLDE1ICsxNzMsMTMgQEAgc3RhdGlj
IHZvaWQgZHc4MjUwX3NlcmlhbF9vdXRxKHN0cnVjdCB1YXJ0X3BvcnQgDQo+PiAqcCwgaW50IG9m
ZnNldCwgaW50IHZhbHVlKSAgfSAgI2VuZGlmIC8qIENPTkZJR182NEJJVCAqLw0KPj4gIA0KPj4g
LXN0YXRpYyB2b2lkIGR3ODI1MF9zZXJpYWxfb3V0MzIoc3RydWN0IHVhcnRfcG9ydCAqcCwgaW50
IG9mZnNldCwgaW50IA0KPj4gdmFsdWUpDQo+PiArc3RhdGljIHZvaWQgZHc4MjUwX2NoZWNrX2Nv
bnRyb2woc3RydWN0IHVhcnRfcG9ydCAqcCwgaW50IG9mZnNldCwgDQo+PiAraW50IHZhbHVlKQ0K
DQo+IEFsc28sIEkgdGhpbmsgdGhpcyBmbiBuYW1lIHNob3VsZCBiZSBkdzgyNTBfY2hlY2tfTENS
KCkgdG8gZGlzdGluZ3Vpc2ggaXQgZnJvbSBtb2RlbSBjb250cm9sLg0KDQpObyBwcm9ibGVtIHdp
bGwgcmVuYW1lIGluIG15IHYyDQo=

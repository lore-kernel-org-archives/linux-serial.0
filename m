From: Noam Camus <noamc@ezchip.com>
Subject: RE: [v3 3/3] serial: 8250_dw: Add UPF_SKIP_TEST to flags depend on
 device tree
Date: Wed, 12 Aug 2015 15:51:05 +0000
Message-ID: <DB4PR02MB2722D091C4A40FC95B48070D67E0@DB4PR02MB272.eurprd02.prod.outlook.com>
References: <1437886478-29273-1-git-send-email-noamc@ezchip.com>
 <1439378312-6463-1-git-send-email-noamc@ezchip.com>
 <1439378312-6463-2-git-send-email-noamc@ezchip.com>
 <1439378312-6463-3-git-send-email-noamc@ezchip.com>
 <1439378312-6463-4-git-send-email-noamc@ezchip.com>
 <55CB4740.7070703@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <55CB4740.7070703@hurleysoftware.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Hurley <peter@hurleysoftware.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "jslaby@suse.com" <jslaby@suse.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "pawel.moll@arm.com" <pawel.moll@arm.com>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "ijc+devicetree@hellion.org.uk" <ijc+devicetree@hellion.org.uk>, "@codeaurora.orggalak@codeaurora.org" <IMCEAINVALID-+40codeaurora+2Eorggalak+40codeaurora+2Eorg@eurprd02.prod.outlook.com>, "fransklaver@gmail.com" <fransklaver@gmail.com>, "Alexey.Brodkin@synopsys.com" <Alexey.Brodkin@synopsys.com>, "vgupta@synopsys.com" <vgupta@synopsys.com>
List-Id: linux-serial@vger.kernel.org

PiBGcm9tOiBQZXRlciBIdXJsZXkgW21haWx0bzpwZXRlckBodXJsZXlzb2Z0d2FyZS5jb21dIA0K
PiBTZW50OiBXZWRuZXNkYXksIEF1Z3VzdCAxMiwgMjAxNSA0OjE3IFBNDQoNCj4gSSB0aGluayBH
cmVnJ3MgcXVlc3Rpb24gYWJvdXQgdGhlIHNpbXVsYXRvciBzdGlsbCBhcHBsaWVzOiB3aHkgdXBz
dHJlYW0gdGhpcz8NCj4gVGhlIHNpbXVsYXRvciBpcyBub3QgZXZlbiBpZGVudGlmaWVkIHNvIGhv
dyBpcyBzb21lb25lIHN1cHBvc2VkIHRvIGtub3cgdGhpcyB3b3JrYXJvdW5kIGFwcGxpZXM/DQoN
Cj4gVGhlIGZhY3QgdGhlcmUgYXJlIG5vIGluLXRyZWUgRFQgdXNlcnMgb2YgdGhpcyB3b3JrYXJv
dW5kIGFyZ3VlcyBhZ2FpbnN0IGl0cyBhY2NlcHRhbmNlLg0KDQpJIGFtIHVzaW5nIFVBUlQgcGVy
aXBoZXJhbCBmb3IgU3lub3BzeXMgc2ltdWxhdG9yIHNhbWUgYXMgb25lIHVzZWQgYnkgYXJjaC9h
cmMvcGxhdC1zaW0NCkkga25vdyB0aGlzIHBsYXRmb3JtIGRvIG5vdCB1c2UgQ09ORklHX1NFUklB
TF84MjUwX0RXIGR1ZSB0byBzb21lIHByb2JsZW0gSSBzdXNwZWN0IGl0IGlzIHJlbGF0ZSB0byB0
aGUgbG9vcCB0ZXN0Lg0KDQpNYXliZSBWaW5lZXQgR3VwdGEgb3IgQWxleGV5IEJyb2RraW4gZnJv
bSBTeW5vcHN5cyB3aGljaCBhcmUgQ0MgaGVyZSBjYW4gY29tbWVudC4NCg0KU28gSXQganVzdCBo
YXBwZW4gZm9yIG1lIHRvIGJlIGEgcGlvbmVlciB3aXRoIHRoaXMuDQoNCk1vcmUgdGhhbiB0aGF0
ICJuby1sb29wYmFjay10ZXN0IiBpcyBhbiBvcHRpb24gYWxyZWFkeSBleGlzdCBmb3IgY29yZSA4
MjUwLCBhbmQgc2luY2UgRFcgaXMgb25seSBhbiBleHRlbnNpb24gZm9yIHRoaXMgZHJpdmVyIGl0
IHNob3VsZCBhbHNvIGJlbmVmaXQgZnJvbSB0aGlzIG9wdGlvbi4NCg0KSWYgYWxsIHRoaXMgaXMg
eWV0IG5vdCBlbm91Z2gsIHNob3VsZCBJIHJlLXNlbmQgdGhpcyAicGF0Y2ggc2V0IiBhZ2FpbiB3
aXRob3V0IHRoaXMgc3BlY2lmaWMgcGF0Y2g/DQoNClJlZ2FyZHMsDQpOb2FtIENhbXVzDQo=

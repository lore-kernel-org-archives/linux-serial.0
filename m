From: Andy Duan <fugang.duan@nxp.com>
Subject: RE: [PATCH] serial: imx: restore handshaking irq for imx1
Date: Fri, 21 Sep 2018 01:18:25 +0000
Message-ID: <VI1PR0402MB36009DCBD9F9F823EE216FF6FF120@VI1PR0402MB3600.eurprd04.prod.outlook.com>
References: <20180920071957.xnwni4lqb5kgncfc@pengutronix.de>
 <20180920121117.19041-1-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180920121117.19041-1-u.kleine-koenig@pengutronix.de>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= <u.kleine-koenig@pengutronix.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>
Cc: YueHaibing <yuehaibing@huawei.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "kernel@pengutronix.de" <kernel@pengutronix.de>, "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Leonard Crestez <leonard.crestez@nxp.com>
List-Id: linux-serial@vger.kernel.org

RnJvbTogVXdlIEtsZWluZS1Lw7ZuaWcgPHUua2xlaW5lLWtvZW5pZ0BwZW5ndXRyb25peC5kZT4g
U2VudDogMjAxOOW5tDnmnIgyMOaXpSAyMDoxMQ0KPiBCYWNrIGluIDIwMTUgd2hlbiBpcmRhIHdh
cyBkcm9wcGVkIGZyb20gdGhlIGRyaXZlciBpbXgxIHdhcyBicm9rZW4uDQo+IFRoaXMgY2hhbmdl
IHJlaW50cm9kdWNlcyB0aGUgc3VwcG9ydCBmb3IgdGhlIHRoaXJkIGludGVycnVwdCBvZiB0aGUg
VUFSVC4NCj4gDQo+IEZpeGVzOiBhZmU5Y2JiMWE2YWQgKCJzZXJpYWw6IGlteDogZHJvcCBzdXBw
b3J0IGZvciBJUkRBIikNCj4gU2lnbmVkLW9mZi1ieTogVXdlIEtsZWluZS1Lw7ZuaWcgPHUua2xl
aW5lLWtvZW5pZ0BwZW5ndXRyb25peC5kZT4NCj4gLS0tDQo+ICBkcml2ZXJzL3R0eS9zZXJpYWwv
aW14LmMgfCA4ICsrKysrKysrDQo+ICAxIGZpbGUgY2hhbmdlZCwgOCBpbnNlcnRpb25zKCspDQo+
IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy90dHkvc2VyaWFsL2lteC5jIGIvZHJpdmVycy90dHkv
c2VyaWFsL2lteC5jIGluZGV4DQo+IDRlODUzNTcwZWE4MC4uNTU0YTY5ZGIxYmNhIDEwMDY0NA0K
PiAtLS0gYS9kcml2ZXJzL3R0eS9zZXJpYWwvaW14LmMNCj4gKysrIGIvZHJpdmVycy90dHkvc2Vy
aWFsL2lteC5jDQo+IEBAIC0yMzUwLDYgKzIzNTAsMTQgQEAgc3RhdGljIGludCBpbXhfdWFydF9w
cm9iZShzdHJ1Y3QNCj4gcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiAgCQkJCXJldCk7DQo+ICAJ
CQlyZXR1cm4gcmV0Ow0KPiAgCQl9DQo+ICsNCj4gKwkJcmV0ID0gZGV2bV9yZXF1ZXN0X2lycSgm
cGRldi0+ZGV2LCBydHNpcnEsIGlteF91YXJ0X3J0c2ludCwgMCwNCj4gKwkJCQkgICAgICAgZGV2
X25hbWUoJnBkZXYtPmRldiksIHNwb3J0KTsNCj4gKwkJaWYgKHJldCkgew0KPiArCQkJZGV2X2Vy
cigmcGRldi0+ZGV2LCAiZmFpbGVkIHRvIHJlcXVlc3QgcnRzIGlycTogJWRcbiIsDQo+ICsJCQkJ
cmV0KTsNCj4gKwkJCXJldHVybiByZXQ7DQo+ICsJCX0NCj4gIAl9IGVsc2Ugew0KPiAgCQlyZXQg
PSBkZXZtX3JlcXVlc3RfaXJxKCZwZGV2LT5kZXYsIHJ4aXJxLCBpbXhfdWFydF9pbnQsIDAsDQo+
ICAJCQkJICAgICAgIGRldl9uYW1lKCZwZGV2LT5kZXYpLCBzcG9ydCk7DQo+IC0tDQo+IDIuMTgu
MA0KDQpSZXZpZXdlZC1ieTogRnVnYW5nIER1YW4gPGZ1Z2FuZy5kdWFuQG54cC5jb20+DQoNCg==

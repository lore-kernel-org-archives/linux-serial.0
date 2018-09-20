From: Andy Duan <fugang.duan@nxp.com>
Subject: RE: [PATCH -next] serial: imx: remove set but not used variable
 'rtsirq'
Date: Thu, 20 Sep 2018 09:41:18 +0000
Message-ID: <VI1PR0402MB3600A7368D538E3B6D044C5FFF130@VI1PR0402MB3600.eurprd04.prod.outlook.com>
References: <1537408725-196364-1-git-send-email-yuehaibing@huawei.com>
         <3b23675a-f537-868f-2432-b7f8a0c8c466@suse.cz>
 <96170d620618804d49ad19323d3cdee853070c72.camel@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <96170d620618804d49ad19323d3cdee853070c72.camel@nxp.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "yuehaibing@huawei.com" <yuehaibing@huawei.com>, "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>, "jslaby@suse.cz" <jslaby@suse.cz>
Cc: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "A.s. Dong" <aisheng.dong@nxp.com>, Abel Vesa <abel.vesa@nxp.com>, Anson Huang <anson.huang@nxp.com>, Bough Chen <haibo.chen@nxp.com>, Cosmin Samoila <cosmin.samoila@nxp.com>, Daniel Baluta <daniel.baluta@nxp.com>, Han Xu <han.xu@nxp.com>, Jacky Bai <ping.bai@nxp.com>, Jun Li <jun.li@nxp.com>, Leo Zhang <leo.zhang@nxp.com>, Leonard Crestez <leonard.crestez@nxp.com>, Peng Fan <peng.fan@nxp.com>, Peter Chen <peter.chen@nxp.com>, Ranjani Vaidyanathan <ranjani.vaidyanathan@nxp.com>, Robert Chiras <robert.chiras@nxp.com>, Robin Gong <yibin.gong@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>, Viorel Suman <viorel.suman@nxp.com>, Zening
List-Id: linux-serial@vger.kernel.org

RnJvbTogTGVvbmFyZCBDcmVzdGV6IFNlbnQ6IDIwMTjlubQ55pyIMjDml6UgMTY6NTENCj4gT24g
VGh1LCAyMDE4LTA5LTIwIGF0IDA4OjQ1ICswMjAwLCBKaXJpIFNsYWJ5IHdyb3RlOg0KPiA+IE9u
IDA5LzIwLzIwMTgsIDAzOjU4IEFNLCBZdWVIYWliaW5nIHdyb3RlOg0KPiA+ID4gRml4ZXMgZ2Nj
ICctV3VudXNlZC1idXQtc2V0LXZhcmlhYmxlJyB3YXJuaW5nOg0KPiA+ID4NCj4gPiA+IGRyaXZl
cnMvdHR5L3NlcmlhbC9pbXguYzogSW4gZnVuY3Rpb24gJ2lteF91YXJ0X3Byb2JlJzoNCj4gPiA+
IGRyaXZlcnMvdHR5L3NlcmlhbC9pbXguYzoyMTk4OjIwOiB3YXJuaW5nOg0KPiA+ID4gIHZhcmlh
YmxlICdydHNpcnEnIHNldCBidXQgbm90IHVzZWQgWy1XdW51c2VkLWJ1dC1zZXQtdmFyaWFibGVd
DQo+ID4gPg0KPiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdHR5L3NlcmlhbC9pbXguYyBiL2Ry
aXZlcnMvdHR5L3NlcmlhbC9pbXguYyBAQA0KPiA+ID4gLTIyMjAsNyArMjIyMCw2IEBAIHN0YXRp
YyBpbnQgaW14X3VhcnRfcHJvYmUoc3RydWN0DQo+IHBsYXRmb3JtX2RldmljZQ0KPiA+ID4gKnBk
ZXYpDQo+ID4gPg0KPiA+ID4gIAlyeGlycSA9IHBsYXRmb3JtX2dldF9pcnEocGRldiwgMCk7DQo+
ID4gPiAgCXR4aXJxID0gcGxhdGZvcm1fZ2V0X2lycShwZGV2LCAxKTsNCj4gPiA+IC0JcnRzaXJx
ID0gcGxhdGZvcm1fZ2V0X2lycShwZGV2LCAyKTsNCj4gPg0KPiA+IEkgYW0gbm90IHN1cmUgdGhp
cyBpcyBjb3JyZWN0LiBwbGF0Zm9ybV9nZXRfaXJxIGhhcyBzaWRlIGVmZmVjdHMgKGxpa2UNCj4g
PiBlbmFibGluZyB0aGUgSVJRKS4gQXJlIHlvdSBzdXJlIHRoaXMgd29uJ3QgY2hhbmdlIHRoZSBi
ZWhhdmlvdXIgKHRoaXMNCj4gPiBpcyBxdWVzdGlvbiBtb3N0bHkgdG8gSU1YIGZlbGxvd3MpPw0K
PiANCj4gQXMgZmFyIGFzIEkgY2FuIHRlbGwgdGhlcmUgd2FzIGEgcmVxdWVzdF9pcnEgY2FsbCBm
b3IgcnRzaXJxIHdoaWNoIHdhcw0KPiByZW1vdmVkIGJ5IG1pc3Rha2UgaW4gY29tbWl0IGFmZTlj
YmIxYTZhZCAoInNlcmlhbDogaW14OiBkcm9wIHN1cHBvcnQNCj4gZm9yIElSREEiKToNCj4gDQo+
IC0gICAgICAgICAgICAgICAvKiBkbyBub3QgdXNlIFJUUyBJUlEgb24gSXJEQSAqLw0KPiAtICAg
ICAgICAgICAgICAgaWYgKCFVU0VfSVJEQShzcG9ydCkpIHsNCj4gLSAgICAgICAgICAgICAgICAg
ICAgICAgcmV0ID0gZGV2bV9yZXF1ZXN0X2lycSgmcGRldi0+ZGV2LCBydHNpcnEsDQo+IC0gICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgaW14X3J0c2ludCwgMCwN
Cj4gLQ0KPiBkZXZfbmFtZSgmcGRldi0+ZGV2KSwgc3BvcnQpOw0KPiAtICAgICAgICAgICAgICAg
ICAgICAgICBpZiAocmV0KQ0KPiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHJldHVy
biByZXQ7DQo+IC0gICAgICAgICAgICAgICB9DQo+IA0KPiBUaGlzIHNob3VsZCBoYXZlIGp1c3Qg
cmVtb3ZlZCB0aGUgSVJEQSBjaGVjayBhbmQgcmVxdWVzdCBydHNpcnENCj4gdW5jb25kaXRpb25h
bGx5LiBOb2JvZHkgbm90aWNlZCB0aGlzIGJ5IHRlc3RpbmcgUlRTIG9uIGlteDEsIHRoaXMgaXMg
YW4gb2xkDQo+IGNoaXAgYW5kIGxhdGVyIHZhcmlhbnRzIGhhdmUgYSBzaW5nbGUgY29tYmluZWQg
aXJxLg0KPiANCj4gVGhlIGNvcnJlY3QgZml4IGZvciB0aGUgd2FybmluZyB3b3VsZCBiZSB0byBy
ZXN0b3JlIHRoYXQgcmVxdWVzdF9pcnEuDQo+IA0KPiAtLQ0KPiBSZWdhcmRzLA0KPiBMZW9uYXJk
DQoNClllcywgeW91ciBleHBsYWluIGlzIHZlcnkgY29ycmVjdCEgVGhhbmtzIGZvciB5b3VyIGNv
bW1lbnQuDQpXZSBzaG91bGQgcmVzdG9yZSBydHNpcnEgcmVxdWVzdCB0aGF0IGZvciBpLk1YMS4N
Cg0KUmVnYXJkcywNCkFuZHkgRHVhbg0K

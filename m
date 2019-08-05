From: Schrempf Frieder <frieder.schrempf@kontron.de>
Subject: Re: [PATCH v3 2/4] serial: mctrl_gpio: Add a NULL check to
 mctrl_gpio_to_gpiod()
Date: Mon, 5 Aug 2019 09:01:39 +0000
Message-ID: <f866213b-fd3b-8602-6c11-56cb65a1ea05@kontron.de>
References: <20190802100349.8659-1-frieder.schrempf@kontron.de>
 <20190802100349.8659-2-frieder.schrempf@kontron.de>
 <20190802121231.wk6yg5mkyivs3rni@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190802121231.wk6yg5mkyivs3rni@pengutronix.de>
Content-Language: en-US
Content-ID: <AF108CA9207A10409A058A7C2410B1EC@snt-world.com>
Sender: linux-kernel-owner@vger.kernel.org
To: =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= <u.kleine-koenig@pengutronix.de>
Cc: "shawnguo@kernel.org" <shawnguo@kernel.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "kernel@pengutronix.de" <kernel@pengutronix.de>, "festevam@gmail.com" <festevam@gmail.com>, "linux-imx@nxp.com" <linux-imx@nxp.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "geert+renesas@glider.be" <geert+renesas@glider.be>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Jiri Slaby <jslaby@suse.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-serial@vger.kernel.org

T24gMDIuMDguMTkgMTQ6MTIsIFV3ZSBLbGVpbmUtS8O2bmlnIHdyb3RlOg0KPiBPbiBGcmksIEF1
ZyAwMiwgMjAxOSBhdCAxMDowNDoxMEFNICswMDAwLCBTY2hyZW1wZiBGcmllZGVyIHdyb3RlOg0K
Pj4gRnJvbTogRnJpZWRlciBTY2hyZW1wZiA8ZnJpZWRlci5zY2hyZW1wZkBrb250cm9uLmRlPg0K
Pj4NCj4+IEFzIGl0IGlzIGFsbG93ZWQgdG8gdXNlIHRoZSBtY3RybF9ncGlvXyogZnVuY3Rpb25z
IGJlZm9yZQ0KPj4gaW5pdGlhbGl6YXRpb24gKGFzIHRoZSA4MjUwIGRyaXZlciBkb2VzIGFjY29y
ZGluZyB0byA0MzRiZTBhZTdhYTcpLA0KPiANCj4gQWN0dWFsbHkgSSB3YXMgc3VycHJpc2VkIHNv
bWUgdGltZSBhZ28gdGhhdCA4MjUwIHVzZWQgc2VyaWFsX21jdHJsDQo+IHdpdGhvdXQgZmlyc3Qg
aW5pdGlhbGl6aW5nIGl0IGFuZCBleHBlY3RpbmcgaXQgdG8gd29yay4gSSBkaWRuJ3QgbG9vayBp
bg0KPiBkZXRhaWwsIGJ1dCBJIHdvdWxkbid0IGdvIHNvIGZhciB0byBjYWxsIHRoaXMgImFsbG93
ZWQiLiBUaGUgY29tbWl0DQo+IGl0c2VsZiBjYWxscyBpdCAid29ya2Fyb3VuZCIgd2hpY2ggc2Vl
bXMgYSBiZXR0ZXIgbWF0Y2guDQoNCk9rLCBidXQgaWYgdGhpcyBpcyBjb25zaWRlcmVkIHRvIGJl
IGEgd29ya2Fyb3VuZCBhbmQgYXMgdGhlIDgyNTAgZHJpdmVyIA0KZG9lcyBub3QgdXNlIG1jdHJs
X2dwaW9fdG9fZ3Bpb2QoKSwgd2Ugc2hvdWxkIG1heWJlIGp1c3QgZHJvcCB0aGlzIHBhdGNoIA0K
aW5zdGVhZCBvZiBlbmNvdXJhZ2luZyBvdGhlcnMgdG8gdXNlIG1jdHJsX2dwaW8gYmVmb3JlIGlu
aXRpYWxpemF0aW9uLg0KDQpJJ20gcmVhbGx5IG5vdCBzdXJlIHdoYXQncyBiZXN0LCBzbyBkZXBl
bmRpbmcgb24gd2hhdCB5b3Ugd2lsbCBwcm9wb3NlLCANCkknbGwgc2VuZCBhIG5ldyB2ZXJzaW9u
IG9mIHRoaXMgcGF0Y2ggd2l0aCBhZGp1c3RlZCBjb21taXQgbWVzc2FnZSBvciBub3QuDQoNCkJ5
IHRoZSB3YXksIFV3ZSBhbmQgRmFiaW86IFRoYW5rcyBmb3IgeW91ciByZXZpZXdzIQ0KDQo+IA0K
Pj4gaXQgc2VlbXMgYXBwcm9wcmlhdGUgdG8gaGF2ZSBhIE5VTEwgY2hlY2sgaW4gYWxsIG9mIHRo
ZSBmdW5jdGlvbnMuDQo+PiBPdGhlcndpc2UgdGhlIG1jdHJsX2dwaW9fdG9fZ3Bpb2QoKSBmdW5j
dGlvbiBpcyBwcm9uZSB0byBiZSB1c2VkDQo+PiBpbiBhIGNvbnRleHQgdGhhdCBjYW4gbGVhZCB0
byBhIE5VTEwgcG9pbnRlciBkZXJlZmVyZW5jZS4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBGcmll
ZGVyIFNjaHJlbXBmIDxmcmllZGVyLnNjaHJlbXBmQGtvbnRyb24uZGU+DQo+IA0KPiBCZXN0IHJl
Z2FyZHMNCj4gVXdlDQo+IA==

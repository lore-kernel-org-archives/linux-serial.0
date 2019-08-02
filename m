From: Schrempf Frieder <frieder.schrempf@kontron.de>
Subject: Re: [PATCH v2 2/3] serial: sh-sci: Remove check for specific
 mctrl_gpio_init() return value
Date: Fri, 2 Aug 2019 07:59:44 +0000
Message-ID: <75b5875d-fa88-3995-6776-ac9a67a3de3c@kontron.de>
References: <20190801184505.17239-1-frieder.schrempf@kontron.de>
 <20190801184505.17239-2-frieder.schrempf@kontron.de>
 <20190801203902.xie5dexnsoqxxlat@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190801203902.xie5dexnsoqxxlat@pengutronix.de>
Content-Language: en-US
Content-ID: <8DB2351A1567814DB91DE6E1D595A641@snt-world.com>
Sender: linux-kernel-owner@vger.kernel.org
To: =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= <u.kleine-koenig@pengutronix.de>
Cc: "shawnguo@kernel.org" <shawnguo@kernel.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "kernel@pengutronix.de" <kernel@pengutronix.de>, "festevam@gmail.com" <festevam@gmail.com>, "linux-imx@nxp.com" <linux-imx@nxp.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "geert+renesas@glider.be" <geert+renesas@glider.be>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Jiri Slaby <jslaby@suse.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-serial@vger.kernel.org

T24gMDEuMDguMTkgMjI6MzksIFV3ZSBLbGVpbmUtS8O2bmlnIHdyb3RlOg0KPiBPbiBUaHUsIEF1
ZyAwMSwgMjAxOSBhdCAwNjo0NToyNFBNICswMDAwLCBTY2hyZW1wZiBGcmllZGVyIHdyb3RlOg0K
Pj4gRnJvbTogRnJpZWRlciBTY2hyZW1wZiA8ZnJpZWRlci5zY2hyZW1wZkBrb250cm9uLmRlPg0K
Pj4NCj4+IE5vdyB0aGF0IHRoZSBtY3RybF9ncGlvIGNvZGUgcmV0dXJucyBOVUxMIGluc3RlYWQg
b2YgRVJSX1BUUigtRU5PU1lTKQ0KPj4gaW4gY2FzZXMgd2hlbiBDT05GSUdfR1BJT0xJQiBpcyBk
aXNhYmxlZCwgd2UgY2FuIHNhZmVseSByZW1vdmUgdGhpcw0KPj4gY2hlY2suDQo+IA0KPiBJIHdv
dWxkIG1lbnRpb24gLUVOT1NZUyBpbiB0aGUgU3ViamVjdCBsaW5lLiBTb21ldGhpbmcgbGlrZToN
Cj4gDQo+IAlzZXJpYWw6IHNoLXNjaTogZG9uJ3QgY2hlY2sgZm9yIG1jdHJsX2dwaW9faW5pdCBy
ZXR1cm5pbmcgLUVOT1NZUw0KPiANCj4gCU5vdyB0aGF0IHRoZSBtY3RybF9ncGlvIGNvZGUgcmV0
dXJucyBOVUxMIGluc3RlYWQgb2YNCj4gCUVSUl9QVFIoLUVOT1NZUykgaWYgQ09ORklHX0dQSU9M
SUIgaXMgZGlzYWJsZWQsIHdlIGNhbiBzYWZlbHkNCj4gCXJlbW92ZSB0aGlzIGNoZWNrLg0KDQpJ
bmRlZWQsIEkgZmFpbGVkIHRvIGNvbWUgdXAgd2l0aCBhIGJldHRlciBzdWJqZWN0IGxpbmUuIEkg
d2lsbCBhZG9wdCANCnlvdXIgcHJvcG9zYWwuDQoNCj4gVGhhbmtzDQo+IFV3ZQ0KPiA=

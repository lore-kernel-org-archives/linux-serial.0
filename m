From: Schrempf Frieder <frieder.schrempf@kontron.de>
Subject: Re: [PATCH v3 2/4] serial: mctrl_gpio: Add a NULL check to
 mctrl_gpio_to_gpiod()
Date: Tue, 6 Aug 2019 08:02:04 +0000
Message-ID: <3672939d-183d-f844-c44c-c70a77931c72@kontron.de>
References: <20190802100349.8659-1-frieder.schrempf@kontron.de>
 <20190802100349.8659-2-frieder.schrempf@kontron.de>
 <20190802121231.wk6yg5mkyivs3rni@pengutronix.de>
 <f866213b-fd3b-8602-6c11-56cb65a1ea05@kontron.de>
 <20190806074534.5w773nltywxyiljz@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190806074534.5w773nltywxyiljz@pengutronix.de>
Content-Language: en-US
Content-ID: <44F6FF28ECA0604BAC78178DAA15EB46@snt-world.com>
Sender: linux-kernel-owner@vger.kernel.org
To: =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= <u.kleine-koenig@pengutronix.de>
Cc: "shawnguo@kernel.org" <shawnguo@kernel.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "kernel@pengutronix.de" <kernel@pengutronix.de>, "festevam@gmail.com" <festevam@gmail.com>, "linux-imx@nxp.com" <linux-imx@nxp.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "geert+renesas@glider.be" <geert+renesas@glider.be>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Jiri Slaby <jslaby@suse.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-serial@vger.kernel.org

T24gMDYuMDguMTkgMDk6NDUsIFV3ZSBLbGVpbmUtS8O2bmlnIHdyb3RlOg0KPiBIZWxsbyBGcmll
ZGVyLA0KPiANCj4gT24gTW9uLCBBdWcgMDUsIDIwMTkgYXQgMDk6MDE6MzlBTSArMDAwMCwgU2No
cmVtcGYgRnJpZWRlciB3cm90ZToNCj4+IE9uIDAyLjA4LjE5IDE0OjEyLCBVd2UgS2xlaW5lLUvD
tm5pZyB3cm90ZToNCj4+PiBPbiBGcmksIEF1ZyAwMiwgMjAxOSBhdCAxMDowNDoxMEFNICswMDAw
LCBTY2hyZW1wZiBGcmllZGVyIHdyb3RlOg0KPj4+PiBGcm9tOiBGcmllZGVyIFNjaHJlbXBmIDxm
cmllZGVyLnNjaHJlbXBmQGtvbnRyb24uZGU+DQo+Pj4+DQo+Pj4+IEFzIGl0IGlzIGFsbG93ZWQg
dG8gdXNlIHRoZSBtY3RybF9ncGlvXyogZnVuY3Rpb25zIGJlZm9yZQ0KPj4+PiBpbml0aWFsaXph
dGlvbiAoYXMgdGhlIDgyNTAgZHJpdmVyIGRvZXMgYWNjb3JkaW5nIHRvIDQzNGJlMGFlN2FhNyks
DQo+Pj4NCj4+PiBBY3R1YWxseSBJIHdhcyBzdXJwcmlzZWQgc29tZSB0aW1lIGFnbyB0aGF0IDgy
NTAgdXNlZCBzZXJpYWxfbWN0cmwNCj4+PiB3aXRob3V0IGZpcnN0IGluaXRpYWxpemluZyBpdCBh
bmQgZXhwZWN0aW5nIGl0IHRvIHdvcmsuIEkgZGlkbid0IGxvb2sgaW4NCj4+PiBkZXRhaWwsIGJ1
dCBJIHdvdWxkbid0IGdvIHNvIGZhciB0byBjYWxsIHRoaXMgImFsbG93ZWQiLiBUaGUgY29tbWl0
DQo+Pj4gaXRzZWxmIGNhbGxzIGl0ICJ3b3JrYXJvdW5kIiB3aGljaCBzZWVtcyBhIGJldHRlciBt
YXRjaC4NCj4+DQo+PiBPaywgYnV0IGlmIHRoaXMgaXMgY29uc2lkZXJlZCB0byBiZSBhIHdvcmth
cm91bmQgYW5kIGFzIHRoZSA4MjUwIGRyaXZlcg0KPj4gZG9lcyBub3QgdXNlIG1jdHJsX2dwaW9f
dG9fZ3Bpb2QoKSwgd2Ugc2hvdWxkIG1heWJlIGp1c3QgZHJvcCB0aGlzIHBhdGNoDQo+PiBpbnN0
ZWFkIG9mIGVuY291cmFnaW5nIG90aGVycyB0byB1c2UgbWN0cmxfZ3BpbyBiZWZvcmUgaW5pdGlh
bGl6YXRpb24uDQo+Pg0KPj4gSSdtIHJlYWxseSBub3Qgc3VyZSB3aGF0J3MgYmVzdCwgc28gZGVw
ZW5kaW5nIG9uIHdoYXQgeW91IHdpbGwgcHJvcG9zZSwNCj4+IEknbGwgc2VuZCBhIG5ldyB2ZXJz
aW9uIG9mIHRoaXMgcGF0Y2ggd2l0aCBhZGp1c3RlZCBjb21taXQgbWVzc2FnZSBvciBub3QuDQo+
IA0KPiBJIHdvdWxkbid0IGVuY291cmFnZSB1c2FnZSBvZiBtY3RybC1ncGlvIGJlZm9yZSBpdCdz
IGluaXRpYWxpemVkLiBTbyBJDQo+IHN1Z2dlc3QgdG8gZHJvcCB0aGlzIHBhdGNoLg0KDQpPaywg
dGhhbmtzLg==

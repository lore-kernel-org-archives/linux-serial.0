From: Schrempf Frieder <frieder.schrempf@kontron.de>
Subject: Re: [PATCH] serial: imx: Avoid probe failure in case of missing
 gpiolib
Date: Thu, 1 Aug 2019 09:28:33 +0000
Message-ID: <0674d68b-99fa-3408-1dd1-22dc84144b43@kontron.de>
References: <20190801081524.22577-1-frieder.schrempf@kontron.de>
 <20190801084827.m42ci3amo37hmesi@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190801084827.m42ci3amo37hmesi@pengutronix.de>
Content-Language: en-US
Content-ID: <6902432E5480BF48B377D0BC2FB45B09@snt-world.com>
Sender: linux-kernel-owner@vger.kernel.org
To: =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= <u.kleine-koenig@pengutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Jiri Slaby <jslaby@suse.com>
List-Id: linux-serial@vger.kernel.org

SGkgVXdlLA0KDQpPbiAwMS4wOC4xOSAxMDo0OCwgVXdlIEtsZWluZS1Lw7ZuaWcgd3JvdGU6DQo+
IE9uIFRodSwgQXVnIDAxLCAyMDE5IGF0IDA4OjE4OjA1QU0gKzAwMDAsIFNjaHJlbXBmIEZyaWVk
ZXIgd3JvdGU6DQo+PiBGcm9tOiBGcmllZGVyIFNjaHJlbXBmIDxmcmllZGVyLnNjaHJlbXBmQGtv
bnRyb24uZGU+DQo+Pg0KPj4gSWYgQ09ORklHX0dQSU9MSUIgaXMgbm90IGVuYWJsZWQsIG1jdHJs
X2dwaW9faW5pdCgpIHdpbGwgcmV0dXJuDQo+PiAtRU5PU1lTIGFuZCBjYXVzZSB0aGUgcHJvYmlu
ZyBvZiB0aGUgaW14IFVBUlQgdG8gZmFpbC4gQXMgdGhlDQo+PiBHUElPcyBhcmUgb3B0aW9uYWws
IHdlIHNob3VsZCBjb250aW51ZSBwcm9iaW5nIGluIHRoaXMgY2FzZS4NCj4gDQo+IElzIHRoaXMg
cmVhbGx5IHN0aWxsIHRoZSBjYXNlPyBPbiB3aGljaCB2ZXJzaW9uIGRpZCB5b3UgaGl0IHRoaXMN
Cj4gcHJvYmxlbT8NCg0KWWVzLCBJIHRoaW5rIGl0IGlzLiBJIHVzZWQgdjUuMi41LCB0aGF0IGFs
cmVhZHkgaGFzIGQ5OTQ4MjY3M2Y5NS4NCg0KPiANCj4gSSB3b3VsZCBleHBlY3QgdGhhdCBpcyBn
b25lIHdpdGgNCj4gZDk5NDgyNjczZjk1MDgxN2IzMGNhZjNmY2RmYjMxMTc5YjA1MGNlMSBpZiBu
b3QgZWFybGllci4NCg0KSSB0aGluayB0aGlzIGlzIGEgZGlmZmVyZW50IHByb2JsZW0uIElmIENP
TkZJR19HUElPTElCIGlzIGRpc2FibGVkLCANCm1jdHJsX2dwaW9faW5pdCgpIHJldHVybnMgLUVO
T1NZUyB1bmNvbmRpdGlvbmFsbHkgaGVyZTogWzFdLiBUaGUgDQpleGlzdGluZyBwYXRjaCAoZDk5
NDgyNjczZjk1KSBzZWVtcyB0byBoYW5kbGUgdGhlIGNhc2Ugd2hlbiANCkNPTkZJR19HUElPTElC
IGlzIGVuYWJsZWQsIGJ1dCBubyBvciBub3QgYWxsIEdQSU9zIGFyZSBnaXZlbiBpbiB0aGUgZHRi
Lg0KDQpUaGUgc2gtc2NpLmMgZHJpdmVyIGhhcyBhIHNpbWlsYXIgY2hlY2sgdG8gc2tpcCB0aGlz
IGNhc2U6IFsyXS4NCg0KUmVnYXJkcywNCkZyaWVkZXINCg0KWzFdIA0KaHR0cHM6Ly9naXQua2Vy
bmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvdG9ydmFsZHMvbGludXguZ2l0L3RyZWUv
ZHJpdmVycy90dHkvc2VyaWFsL3NlcmlhbF9tY3RybF9ncGlvLmgjbjEyMQ0KWzJdIA0KaHR0cHM6
Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvdG9ydmFsZHMvbGludXgu
Z2l0L3RyZWUvZHJpdmVycy90dHkvc2VyaWFsL3NoLXNjaS5jI24zMjkw

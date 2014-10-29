From: "fugang.duan@freescale.com" <fugang.duan@freescale.com>
Subject: RE: [PATCH 1/4] serial: imx: Fix the reporting of interrupts
Date: Wed, 29 Oct 2014 02:02:46 +0000
Message-ID: <cbc012f217cf48efb92022bb274a62c7@BLUPR03MB373.namprd03.prod.outlook.com>
References: <1414428580-29534-1-git-send-email-fabio.estevam@freescale.com>
	<8e4a991e46474daa8bc40b96e8042ef2@BLUPR03MB373.namprd03.prod.outlook.com>
	<CAOMZO5CvM6V9LCUEuDshVzRQoELcQPQVC40dm0Pzw7DQYiJbFQ@mail.gmail.com>
	<77b6c2f96de043f79840fed8fcfe254d@BLUPR03MB373.namprd03.prod.outlook.com>
 <CAOMZO5B=C0LVKoGuA8=xzNTpp8X8p5PdZy0h_1nCOq-Wt-C7Ww@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-bl2on0148.outbound.protection.outlook.com ([65.55.169.148]:49123
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751575AbaJ2CRr (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Tue, 28 Oct 2014 22:17:47 -0400
In-Reply-To: <CAOMZO5B=C0LVKoGuA8=xzNTpp8X8p5PdZy0h_1nCOq-Wt-C7Ww@mail.gmail.com>
Content-Language: en-US
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Fabio Estevam <festevam@gmail.com>
Cc: "Fabio.Estevam@freescale.com" <Fabio.Estevam@freescale.com>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "shawn.guo@linaro.org" <shawn.guo@linaro.org>, "kernel@pengutronix.de" <kernel@pengutronix.de>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>

RnJvbTogRmFiaW8gRXN0ZXZhbSA8ZmVzdGV2YW1AZ21haWwuY29tPiBTZW50OiBXZWRuZXNkYXks
IE9jdG9iZXIgMjksIDIwMTQgOTo1OCBBTQ0KPlRvOiBEdWFuIEZ1Z2FuZy1CMzg2MTENCj5DYzog
RXN0ZXZhbSBGYWJpby1SNDk0OTY7IGdyZWdraEBsaW51eGZvdW5kYXRpb24ub3JnOyBzaGF3bi5n
dW9AbGluYXJvLm9yZzsNCj5rZXJuZWxAcGVuZ3V0cm9uaXguZGU7IGxpbnV4LXNlcmlhbEB2Z2Vy
Lmtlcm5lbC5vcmcNCj5TdWJqZWN0OiBSZTogW1BBVENIIDEvNF0gc2VyaWFsOiBpbXg6IEZpeCB0
aGUgcmVwb3J0aW5nIG9mIGludGVycnVwdHMNCj4NCj5PbiBUdWUsIE9jdCAyOCwgMjAxNCBhdCAx
MTozMyBQTSwgZnVnYW5nLmR1YW5AZnJlZXNjYWxlLmNvbQ0KPjxmdWdhbmcuZHVhbkBmcmVlc2Nh
bGUuY29tPiB3cm90ZToNCj4NCj4+IE9rLCBpZiB3YWtlIHVwIGZ1bmN0aW9uIHN0aWxsIHdvcmss
IHRoZSBwYXRjaCBpcyBmaW5lIGZvciBtZS4NCj4+IEJ1dCBJIHN1Z2dlc3QgeW91IGRvIG9uZSB0
ZXN0IGxpa2UgdGhpczoNCj4+IDEuIGVjaG8gZW5hYmxlZCA+IC9zeXMvY2xhc3MvdHR5L3R0eW14
YzAvcG93ZXIvd2FrZXVwDQo+PiAyLiBlY2hvIG1lbSA+IC9zeXMvcG93ZXIvc3RhdGUNCj4+IDMu
IC4ucXVpY2tseSBjbGljayBjb25zb2xlIGtleSBpbiBjb250aW51b3VzbHkuDQo+PiAoTWFrZSBz
dXJlIHRoZSBkZWxheSBiZXR3ZWVuIHN0ZXAyIGFuZCBzdGVwMyBpcyBsaXR0bGUpDQo+DQo+VGVz
dGVkIHRoaXMgYW5kIGl0IHdvcmtlZCBmaW5lIG9uIGEgbXg2cXNhYnJlc2QuDQoNClRoYW5rcywg
RmFiaW8uDQooSSBqdXN0IHN1Ym1pdCBvbmUgc2ltaWxhciBwYXRjaCBpbiBvdXIgMy4xMCBrZXJu
ZWwsIGJ1dCB0ZXN0IHRlYW0gZm91bmQgdGhpcyBpc3N1ZSwgc28gSSByZXZlcnQgaXQuKQ0KDQoN
ClJlZ2FyZHMsDQpBbmR5DQo=

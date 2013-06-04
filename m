From: Lu Jingchang-B35083 <B35083@freescale.com>
Subject: RE: [PATCH v6] tty: serial: add Freescale lpuart driver support
Date: Tue, 4 Jun 2013 03:37:50 +0000
Message-ID: <B56CDBE15CE27145A4B77D2D24263E851CF028@039-SN1MPN1-003.039d.mgd.msft.net>
References: <1370309270-21019-1-git-send-email-b35083@freescale.com>
	<CAOMZO5BNbbbX0wycis_3nyg-B76kJYrQu-e+D1SpGLs10Zp3yw@mail.gmail.com>
	<B56CDBE15CE27145A4B77D2D24263E851CEFD9@039-SN1MPN1-003.039d.mgd.msft.net>
	<CAOMZO5DzVhh4REj5S=cVVVrGzxmTxY9s_h_6ZQ-G8wOxi+KG=A@mail.gmail.com>
 <CAOMZO5Bo58Qa0Rmz+oKt0ZOUjYDDskBsPykCVc79j4mybcG8rA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from co1ehsobe003.messaging.microsoft.com ([216.32.180.186]:51657
	"EHLO co1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755384Ab3FDDiS (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 3 Jun 2013 23:38:18 -0400
In-Reply-To: <CAOMZO5Bo58Qa0Rmz+oKt0ZOUjYDDskBsPykCVc79j4mybcG8rA@mail.gmail.com>
Content-Language: en-US
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Fabio Estevam <festevam@gmail.com>
Cc: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "shawn.guo@linaro.org" <shawn.guo@linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEZhYmlvIEVzdGV2YW0gW21h
aWx0bzpmZXN0ZXZhbUBnbWFpbC5jb21dDQo+U2VudDogVHVlc2RheSwgSnVuZSAwNCwgMjAxMyAx
MTowOSBBTQ0KPlRvOiBMdSBKaW5nY2hhbmctQjM1MDgzDQo+Q2M6IGxpbnV4LXNlcmlhbEB2Z2Vy
Lmtlcm5lbC5vcmc7IGdyZWdraEBsaW51eGZvdW5kYXRpb24ub3JnOw0KPnMuaGF1ZXJAcGVuZ3V0
cm9uaXguZGU7IHNoYXduLmd1b0BsaW5hcm8ub3JnOyBsaW51eC1hcm0tDQo+a2VybmVsQGxpc3Rz
LmluZnJhZGVhZC5vcmcNCj5TdWJqZWN0OiBSZTogW1BBVENIIHY2XSB0dHk6IHNlcmlhbDogYWRk
IEZyZWVzY2FsZSBscHVhcnQgZHJpdmVyIHN1cHBvcnQNCj4NCj5PbiBUdWUsIEp1biA0LCAyMDEz
IGF0IDEyOjA4IEFNLCBGYWJpbyBFc3RldmFtIDxmZXN0ZXZhbUBnbWFpbC5jb20+IHdyb3RlOg0K
Pj4gT24gVHVlLCBKdW4gNCwgMjAxMyBhdCAxMjowMiBBTSwgTHUgSmluZ2NoYW5nLUIzNTA4Mw0K
Pj4gPEIzNTA4M0BmcmVlc2NhbGUuY29tPiB3cm90ZToNCj4+DQo+Pj4gW0x1IEppbmdjaGFuZy1C
MzUwODNdDQo+Pj4gICBTRVJJQUxfRlNMX0xQVUFSVF9DT05TT0xFIGRlcGVuZHMgb24gU0VSSUFM
X0ZTTF9MUFVBUlQ9eSBpbiB0aGUgcGF0Y2gNCj5hcyBiZWxvdywgd2hlbiBTRVJJQUxfRlNMX0xQ
VUFSVCBpcyBjb25maWd1cmVkIGFzIG1vZHVsZSwgaXQgY2FuJ3QgYmUNCj5jb25maWd1cmVkIGFz
IGNvbnNvbGUuIFRoYW5rcyENCj4+DQo+PiBXaHkgdG8gcHJldmVudCB1c2luZyB0aGUgY29uc29s
ZSBvZiB0aGUgZHJpdmVyIGlzIGJ1aWx0IGFzIG1vZHVsZT8NCj4NCj5JIG1lYW50ICJpZiB0aGUg
ZHJpdmVyIGlzIGJ1aWx0IGFzIG1vZHVsZSINCltMdSBKaW5nY2hhbmctQjM1MDgzXSANCkluIHNl
cmlhbCBkcml2ZXIgaW14LmMsIHdoZW4gQ09ORklHX1NFUklBTF9JTVhfQ09OU09MRT1tLCBkb2Vz
IHRoZSBjb2RlIGJldHdlZW4gI2lmZGVmIENPTkZJR19TRVJJQUxfSU1YX0NPTlNPTEUgLi4uICNl
bHNlIGJlIGNvbXBpbGVkPw0KVGhhbmtzISANCg0K


From: Lu Jingchang-B35083 <B35083@freescale.com>
Subject: RE: [PATCH v6] tty: serial: add Freescale lpuart driver support
Date: Tue, 4 Jun 2013 03:02:25 +0000
Message-ID: <B56CDBE15CE27145A4B77D2D24263E851CEFD9@039-SN1MPN1-003.039d.mgd.msft.net>
References: <1370309270-21019-1-git-send-email-b35083@freescale.com>
 <CAOMZO5BNbbbX0wycis_3nyg-B76kJYrQu-e+D1SpGLs10Zp3yw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from co9ehsobe004.messaging.microsoft.com ([207.46.163.27]:11000
	"EHLO co9outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757088Ab3FDDDz (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 3 Jun 2013 23:03:55 -0400
In-Reply-To: <CAOMZO5BNbbbX0wycis_3nyg-B76kJYrQu-e+D1SpGLs10Zp3yw@mail.gmail.com>
Content-Language: en-US
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Fabio Estevam <festevam@gmail.com>
Cc: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "shawn.guo@linaro.org" <shawn.guo@linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEZhYmlvIEVzdGV2YW0gW21h
aWx0bzpmZXN0ZXZhbUBnbWFpbC5jb21dDQo+U2VudDogVHVlc2RheSwgSnVuZSAwNCwgMjAxMyAx
MDo1NSBBTQ0KPlRvOiBMdSBKaW5nY2hhbmctQjM1MDgzDQo+Q2M6IGxpbnV4LXNlcmlhbEB2Z2Vy
Lmtlcm5lbC5vcmc7IGdyZWdraEBsaW51eGZvdW5kYXRpb24ub3JnOw0KPnMuaGF1ZXJAcGVuZ3V0
cm9uaXguZGU7IHNoYXduLmd1b0BsaW5hcm8ub3JnOyBsaW51eC1hcm0tDQo+a2VybmVsQGxpc3Rz
LmluZnJhZGVhZC5vcmcNCj5TdWJqZWN0OiBSZTogW1BBVENIIHY2XSB0dHk6IHNlcmlhbDogYWRk
IEZyZWVzY2FsZSBscHVhcnQgZHJpdmVyIHN1cHBvcnQNCj4NCj5PbiBNb24sIEp1biAzLCAyMDEz
IGF0IDEwOjI3IFBNLCBKaW5nY2hhbmcgTHUgPGIzNTA4M0BmcmVlc2NhbGUuY29tPiB3cm90ZToN
Cj4NCj4+ICtjb25maWcgU0VSSUFMX0ZTTF9MUFVBUlQNCj4+ICsgICAgICAgdHJpc3RhdGUgIkZy
ZWVzY2FsZSBscHVhcnQgc2VyaWFsIHBvcnQgc3VwcG9ydCINCj4+ICsgICAgICAgc2VsZWN0IFNF
UklBTF9DT1JFDQo+PiArICAgICAgIGhlbHANCj4+ICsgICAgICAgICBTdXBwb3J0IGZvciB0aGUg
b24tY2hpcCBscHVhcnQgb24gc29tZSBGcmVlc2NhbGUgU09Dcy4NCj4+ICsNCj4+ICtjb25maWcg
U0VSSUFMX0ZTTF9MUFVBUlRfQ09OU09MRQ0KPj4gKyAgICAgICBib29sICJDb25zb2xlIG9uIEZy
ZWVzY2FsZSBscHVhcnQgc2VyaWFsIHBvcnQiDQo+DQo+SXQgaXMgYmV0dGVyIHlvIHVzZSB0cmlz
dGF0ZSBoZXJlIGFzIHdlbGwuDQo+DQo+SSBoYXZlIGp1c3Qgc2VudCB0aGUgc2FtZSBmaXggZm9y
IGlteCBzZXJpYWwuDQo+DQo+S2VlcGluZyBpdCBib29sIG1heSBsZWFkIHRvIGJ1aWxkIGVycm9y
IHdoZW4gU0VSSUFMX0ZTTF9MUFVBUlQ9bSBhbmQNCj5TRVJJQUxfRlNMX0xQVUFSVF9DT05TT0xF
PXkNCltMdSBKaW5nY2hhbmctQjM1MDgzXSANCiAgU0VSSUFMX0ZTTF9MUFVBUlRfQ09OU09MRSBk
ZXBlbmRzIG9uIFNFUklBTF9GU0xfTFBVQVJUPXkgaW4gdGhlIHBhdGNoIGFzIGJlbG93LCB3aGVu
IFNFUklBTF9GU0xfTFBVQVJUIGlzIGNvbmZpZ3VyZWQgYXMgbW9kdWxlLCBpdCBjYW4ndCBiZSBj
b25maWd1cmVkIGFzIGNvbnNvbGUuIFRoYW5rcyENCg0KK2NvbmZpZyBTRVJJQUxfRlNMX0xQVUFS
VF9DT05TT0xFDQorICAgICAgIGJvb2wgIkNvbnNvbGUgb24gRnJlZXNjYWxlIGxwdWFydCBzZXJp
YWwgcG9ydCINCisgICAgICAgZGVwZW5kcyBvbiBTRVJJQUxfRlNMX0xQVUFSVD15DQoNCg==


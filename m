From: Noam Camus <noamc@ezchip.com>
Subject: RE: [PATCH 4/4] serial: 8250_dw: use serial_in() and not readl()
Date: Thu, 23 Jul 2015 10:40:36 +0000
Message-ID: <DB4PR02MB272E255AAD6D46A0CB6F459D6820@DB4PR02MB272.eurprd02.prod.outlook.com>
References: <1437557699-25722-1-git-send-email-noamc@ezchip.com>
 <1437557699-25722-2-git-send-email-noamc@ezchip.com>
 <1437557699-25722-3-git-send-email-noamc@ezchip.com>
 <1437557699-25722-4-git-send-email-noamc@ezchip.com>
 <1437557699-25722-5-git-send-email-noamc@ezchip.com>
 <55AF91E8.3020903@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <55AF91E8.3020903@hurleysoftware.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Hurley <peter@hurleysoftware.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "Alexey.Brodkin@synopsys.com" <Alexey.Brodkin@synopsys.com>, "vgupta@synopsys.com" <vgupta@synopsys.com>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "jslaby@suse.com" <jslaby@suse.com>
List-Id: linux-serial@vger.kernel.org

RnJvbTogUGV0ZXIgSHVybGV5IFttYWlsdG86cGV0ZXJAaHVybGV5c29mdHdhcmUuY29tXSANClNl
bnQ6IFdlZG5lc2RheSwgSnVseSAyMiwgMjAxNSAzOjUyIFBNDQoNCj4gU3ViamVjdDogUmU6IFtQ
QVRDSCA0LzRdIHNlcmlhbDogODI1MF9kdzogdXNlIHNlcmlhbF9pbigpIGFuZCBub3QgcmVhZGwo
KQ0KDQo+IEZyb206IE5vYW0gQ2FtdXMgPG5vYW1jQGV6Y2hpcC5jb20+DQo+IA0KPiBUaGlzIGlz
IG5vdyBtYXRjaGVzIGRldmljZSBlbmRpYW5uZXNzLg0KDQo+IEknbSBub3Qgc2VlaW5nIHdoZXJl
IHNlcmlhbF9pbigpIGlzIHVzZWQgaGVyZSwgYXMgY2xhaW1lZCBieSB0aGUgJHN1YmplY3QuDQoN
ClRoYW5rcywgSSB3aWxsICJyZXdvcmQiIG15IGNvbW1pdCBpbiB2Mg0K

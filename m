From: "Schenk, Gavin" <G.Schenk@eckelmann.de>
Subject: AW: [PATCH] serial: imx: disable DMA for RS-485 on i.MX6 SMP
Date: Mon, 24 Jul 2017 11:49:28 +0000
Message-ID: <D415CD2EC4182C4EAB90A76B7D9F16DC022B0A8C5E@EX-DAG02.eckelmann.group>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <stable-owner@vger.kernel.org>
Content-Language: de-DE
Sender: stable-owner@vger.kernel.org
To: Fabio Estevam <festevam@gmail.com>
Cc: Clemens Gruber <clemens.gruber@pqgruber.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "stable@vger.kernel.org" <stable@vger.kernel.org>, "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>, Fabio Estevam <fabio.estevam@nxp.com>, Ian Jamison <ian.dev@arkver.com>
List-Id: linux-serial@vger.kernel.org

SGksDQoNCnNvcnJ5IGZvciB0aGUgZGVsYXkhDQoNCj4gPiBVd2UgS2xlaW5lLUvDtm5pZyBoYWQg
dGhlIGlkZWEgdG8gZGlzYWJsZSBETUEgb24gdGhlIGkuTVg2ZGwgYmFzZWQNCj4gcGxhdGZvcm0g
dmlhIGR0cyBhbmQgdGhpcyBpcyBvdXIgY3VycmVudCB3b3JrYXJvdW5kLg0KPiANCj4gUGxlYXNl
IHRlc3QgSWFuJ3MgcGF0Y2g6DQo+IGh0dHA6Ly9tYXJjLmluZm8vP2w9bGludXgtc2VyaWFsJm09
MTUwMDA1ODY1MjEzNTMxJnc9Mg0KPiANCj4gSXQgc2hvdWxkIGZpeCB0aGlzIERNQSBwcm9ibGVt
IHdpdGggUlM0ODUuDQoNCldpdGggdGhpcyBwYXRjaCBhcHBsaWVkIG15IHRlc3Qgd29ya3MgZmlu
ZSBvbiBpLk1YNmRsIGluIFJTNDg1LW1vZGUgYW5kIERNQSBlbmFibGVkLg0KIA0KUmVnYXJkcw0K
R2F2aW4gU2NoZW5rDQoNCg0KCkVja2VsbWFubiBBRwpWb3JzdGFuZDogRGlwbC4tSW5nLiBQZXRl
ciBGcmFua2VuYmFjaCAoU3ByZWNoZXIpIERpcGwuLVdpLi1JbmcuIFBoaWxpcHAgRWNrZWxtYW5u
CkRyLi1JbmcuIE1hcmNvIE3DvG5jaGhvZiBEci4tSW5nLiBGcmFuayBVaGxlbWFubgpWb3JzaXR6
ZW5kZXIgZGVzIEF1ZnNpY2h0c3JhdHM6IEh1YmVydHVzIEcuIEtyb3NzYQpTdHYuIFZvcnNpdHpl
bmRlciBkZXMgQXVmc2ljaHRzcmF0czogRHIuLUluZy4gR2VyZCBFY2tlbG1hbm4KU2l0eiBkZXIg
R2VzZWxsc2NoYWZ0OiBCZXJsaW5lciBTdHIuIDE2MSwgNjUyMDUgV2llc2JhZGVuLCBBbXRzZ2Vy
aWNodCBXaWVzYmFkZW4gSFJCIDEyNjM2Cmh0dHA6Ly93d3cuZWNrZWxtYW5uLmRlIAoK

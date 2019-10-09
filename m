From: Anson Huang <anson.huang@nxp.com>
Subject: RE: [PATCH] tty: serial: imx: Only get second/third IRQ when there is
 more than one IRQ
Date: Wed, 9 Oct 2019 09:36:36 +0000
Message-ID: <DB3PR0402MB3916361F60FA8ACBB434E7ADF5950@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1570601911-9162-1-git-send-email-Anson.Huang@nxp.com>
 <20191009065315.wgdvmkv6skteyul4@pengutronix.de>
 <CAHp75VcWXT+j5cfVzxPL+3YdgR+3uhFSb0qEDRr4YL+WenVKUQ@mail.gmail.com>
 <20191009092954.srlx5wjaqueps7nz@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191009092954.srlx5wjaqueps7nz@pengutronix.de>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= <u.kleine-koenig@pengutronix.de>, Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Stephen Boyd <swboyd@chromium.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Sascha Hauer <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>, linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, dl-linux-imx <linux-imx@nxp.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
List-Id: linux-serial@vger.kernel.org

DQoNCj4gT24gV2VkLCBPY3QgMDksIDIwMTkgYXQgMTE6MTI6MjBBTSArMDMwMCwgQW5keSBTaGV2
Y2hlbmtvIHdyb3RlOg0KPiA+IE9uIFdlZCwgT2N0IDksIDIwMTkgYXQgOTo1MyBBTSBVd2UgS2xl
aW5lLUvDtm5pZw0KPiA+IDx1LmtsZWluZS1rb2VuaWdAcGVuZ3V0cm9uaXguZGU+IHdyb3RlOg0K
PiA+DQo+ID4gPiBUaGUgcGF0Y2ggaXMgZmluZSBnaXZlbiB0aGUgY2hhbmdlZCBiZWhhdmlvdXIg
b2YgcGxhdGZvcm1fZ2V0X2lycS4gSQ0KPiA+ID4gd29uZGVyIGlmIGl0IGlzIHNlbnNpYmxlIHRv
IGludHJvZHVjZSBhIHZhcmlhbnQgb2YgcGxhdGZvcm1fZ2V0X2lycQ0KPiA+ID4gKHNheQ0KPiA+
ID4gcGxhdGZvcm1fZ2V0X2lycV9ub3dhcm4pIHRoYXQgYmVoYXZlcyBsaWtlIF9fcGxhdGZvcm1f
Z2V0X2lycSBkb2VzDQo+ID4gPiB0b2RheS4gVGhlbiB0aGUgaW14IGRyaXZlciB3b3VsZCBqdXN0
IGNhbGwgcGxhdGZvcm1fZ2V0X2lycV9ub3dhcm4NCj4gPiA+IHdpdGhvdXQgaGF2aW5nIHRvIGNo
ZWNrIHRoZSBudW1iZXIgb2YgYXZhaWxhYmxlIGlycXMgZmlyc3QuDQo+ID4NCj4gPiBJdCdzIGJl
aW5nIGRpc2N1c3NlZCBpbiBwYXJhbGxlbCB0aHJlYWQgYWJvdXQNCj4gPiBwbGF0Zm9ybV9nZXRf
aXJxX29wdGlvbmFsKCkgd2hpY2ggd29uJ3QgaXNzdWUgYSB3YXJuaW5nLg0KPiANCj4gVGhpcyBp
cyBldmVuIGFscmVhZHkgaW4gNS40LXJjMSBhcw0KPiA4OTczZWE0NzkwMWM4MWExOTEyYmQwNWYx
NTc3YmVkOWI1YjUyNTA2Lg0KDQpHcmVhdCwgSSB3aWxsIHNlbmQgb3V0IGEgVjIgdXNpbmcgcGxh
dGZvcm1fZ2V0X2lycV9vcHRpb25hbCgpIGZvciBzZWNvbmQvdGhpcmQgSVJRLg0KDQpUaGFua3Ms
DQpBbnNvbg0K

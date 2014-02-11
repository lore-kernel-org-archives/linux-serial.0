From: Yao Yuan <yao.yuan@freescale.com>
Subject: RE: [PATCH v4 0/3] serial: fsl_lpuart: add DMA support
Date: Tue, 11 Feb 2014 05:34:49 +0000
Message-ID: <c2b2798647d44d3c950ce17f23551555@DM2PR03MB349.namprd03.prod.outlook.com>
References: <1390363773-24108-1-git-send-email-yao.yuan@freescale.com>
 <20140127075025.GC4765@S2101-09.ap.freescale.net>
 <c1c2915231eb4595b89327e589bc521d@BL2PR03MB338.namprd03.prod.outlook.com>
 <20140211025932.GB31484@S2101-09.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-bn1lp0150.outbound.protection.outlook.com ([207.46.163.150]:14512
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750721AbaBKFex (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Tue, 11 Feb 2014 00:34:53 -0500
In-Reply-To: <20140211025932.GB31484@S2101-09.ap.freescale.net>
Content-Language: en-US
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, "arnd@arndb.de" <arnd@arndb.de>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBTaGF3biBHdW8gW21haWx0bzpz
aGF3bi5ndW9AbGluYXJvLm9yZ10NCj4gU2VudDogVHVlc2RheSwgRmVicnVhcnkgMTEsIDIwMTQg
MTE6MDAgQU0NCj4gVG86IFl1YW4gWWFvLUI0NjY4Mw0KPiBDYzogZ3JlZ2toQGxpbnV4Zm91bmRh
dGlvbi5vcmc7IGxpbnV4QGFybS5saW51eC5vcmcudWs7IGFybmRAYXJuZGIuZGU7DQo+IG1hcmsu
cnV0bGFuZEBhcm0uY29tOyBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7IGxp
bnV4LQ0KPiBzZXJpYWxAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjQg
MC8zXSBzZXJpYWw6IGZzbF9scHVhcnQ6IGFkZCBETUEgc3VwcG9ydA0KPiANCj4gT24gVHVlLCBG
ZWIgMTEsIDIwMTQgYXQgMDE6NTA6MTRBTSArMDAwMCwgWWFvIFl1YW4gd3JvdGU6DQo+ID4gSGks
IFNoYXduDQo+ID4NCj4gPiBIZXJlIEkganVzdCB3YW50IHRoZSBETUEgYmUgYSBzZWxlY3RhYmxl
IHByb3BlcnR5IGZvciBlYWNoIGJvYXJkLg0KPiA+IElzIGl0IHN1aXRhYmxlPw0KPiANCj4gTm8s
IGl0J3Mgbm90LiAgSnVzdCBsaWtlIElSUSBsaW5lLCBETUEgY2hhbm5lbCBpcyBhIFNvQyBsZXZl
bCByZXNvdXJjZS4NCj4gSXQgc2hvdWxkIGp1c3QgYmUgdGhlcmUgb25jZSB0aGUgU29DIGlzIG91
dCB0aGVyZS4gIE5vdGhpbmcgdG8gZG8gd2l0aA0KPiBib2FyZCBsZXZlbCBjb25maWd1cmF0aW9u
Lg0KPiANCj4gU2hhd24NCg0KSGVyZSBJIGFsc28gaGF2ZSBhIGNvbmZ1c2lvbi4NCklSUSBpcyBt
dXN0LiBCdXQgRE1BIGlzbid0IHZlcnkgbmVjZXNzYXJ5Lg0KSG93IHRvIGRlYWwgd2l0aCBpZiBv
bmUgYm9hcmQgaXMgbmVlZCBETUEgYnV0IGFub3RoZXIgaXMgbm90IG5lZWQ/DQpZb3UgbWVhbiBp
ZiBETUEgaXMgYmUgc3VwcG9ydCBvbmNlIGFsbCBvZiB0aGVtIG11c3QgdXNlIGRtYSBhcyBmaXJz
dD8NCg0KLS0NCkJlc3QgUmVnYXJkcywNCll1YW5ZYW8NCj4gDQo+ID4NCj4gPiA+IC0tLS0tT3Jp
Z2luYWwgTWVzc2FnZS0tLS0tDQo+ID4gPiBGcm9tOiBTaGF3biBHdW8gW21haWx0bzpzaGF3bi5n
dW9AbGluYXJvLm9yZ10NCj4gPiA+IFNlbnQ6IE1vbmRheSwgSmFudWFyeSAyNywgMjAxNCAzOjUw
IFBNDQo+ID4gPiBUbzogWXVhbiBZYW8tQjQ2NjgzDQo+ID4gPiBDYzogZ3JlZ2toQGxpbnV4Zm91
bmRhdGlvbi5vcmc7IGxpbnV4QGFybS5saW51eC5vcmcudWs7DQo+ID4gPiBhcm5kQGFybmRiLmRl
OyBtYXJrLnJ1dGxhbmRAYXJtLmNvbTsNCj4gPiA+IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5m
cmFkZWFkLm9yZzsgbGludXgtIHNlcmlhbEB2Z2VyLmtlcm5lbC5vcmcNCj4gPiA+IFN1YmplY3Q6
IFJlOiBbUEFUQ0ggdjQgMC8zXSBzZXJpYWw6IGZzbF9scHVhcnQ6IGFkZCBETUEgc3VwcG9ydA0K
PiA+ID4NCj4gPiA+IE9uIFdlZCwgSmFuIDIyLCAyMDE0IGF0IDEyOjA5OjMwUE0gKzA4MDAsIFl1
YW4gWWFvIHdyb3RlOg0KPiA+ID4gPiBDaGFuZ2VkIGluIHY0Og0KPiA+ID4gPiAtIE1vdmUgZG1h
IHByb3BlcnRpZXMgZnJvbSBkdHNpIHRvIGR0cy4NCj4gPiA+DQo+ID4gPiBXaHkgdGhpcyBjaGFu
Z2U/ICBETUEgaXMgYSBTb0MgbGV2ZWwgcmVzb3VyY2UgcmF0aGVyIHRoYW4gYm9hcmQgb25lLg0K
PiA+ID4NCj4gPiA+IFNoYXduDQo+ID4NCg0K

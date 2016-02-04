From: Ofer Heifetz <oferh@marvell.com>
Subject: RE: [PATCH v2 03/12] serial: mvebu-uart: initial support for
 Armada-3700 serial port
Date: Thu, 4 Feb 2016 03:22:04 +0000
Message-ID: <d18a261fae544e27b12a56bebf4a7006@IL-EXCH01.marvell.com>
References: <1454524889-9207-1-git-send-email-gregory.clement@free-electrons.com>
	<1454524889-9207-4-git-send-email-gregory.clement@free-electrons.com>
	<CAPv3WKdh8D8GYMabALQQW-Z7L+=XhkZw2cXdYpcQ8tF0Rjckag@mail.gmail.com>
	<20160203230224.5ea52f65@free-electrons.com>
 <CAPv3WKe6=705iEtsuo0cUtugofiFa_Zt9xydRsgOV+mZ18H-3Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-ide-owner@vger.kernel.org>
In-Reply-To: <CAPv3WKe6=705iEtsuo0cUtugofiFa_Zt9xydRsgOV+mZ18H-3Q@mail.gmail.com>
Content-Language: en-US
Sender: linux-ide-owner@vger.kernel.org
To: Marcin Wojtas <mw@semihalf.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Gregory CLEMENT <gregory.clement@free-electrons.com>, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, "arm@kernel.org" <arm@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Jonathan Corbet <corbet@lwn.net>, Mark Rutland <mark.rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Omri Itach <omrii@marvell.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Nadav Haklai <nadavh@marvell.com>, Hans de Goede <hdegoede@redhat.com>, Lior Amsalem <alior@marvell.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Jiri Slaby <jslaby@suse.com>, Tejun Heo <tj@kernel.org>, Wilson Ding <dingwei@marvel>
List-Id: linux-serial@vger.kernel.org

SGkgTWFyY2luLA0KDQpJIHRoaW5rIGl0IGlzIGEgcGFydGlhbCBmaXggc2luY2Ugb25jZSBRQSBz
dGFydGVkIHRvIHVzZSB0aGlzIHBhdGNoIGFuZCBmb3VuZCB0aGF0IC9wcm9jL2ludGVycnVwdHMg
cHJpbnRzIHNlcmlhbCBpbnRlcnJ1cHQgc3RyaW5nIG11bHRpcGxlIHRpbWVzIHdoaWNoIGlzIGNs
b2JiZXJpbmcgdGhlIHByaW50Lg0KDQovT2Zlcg0KDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0t
LS0tDQpGcm9tOiBNYXJjaW4gV29qdGFzIFttYWlsdG86bXdAc2VtaWhhbGYuY29tXSANClNlbnQ6
IFRodXJzZGF5LCBGZWJydWFyeSAwNCwgMjAxNiAxMjoyMyBBTQ0KVG86IFRob21hcyBQZXRhenpv
bmk7IE9mZXIgSGVpZmV0eg0KQ2M6IEdyZWdvcnkgQ0xFTUVOVDsgSmFzb24gQ29vcGVyOyBBbmRy
ZXcgTHVubjsgU2ViYXN0aWFuIEhlc3NlbGJhcnRoOyBhcm1Aa2VybmVsLm9yZzsgQ2F0YWxpbiBN
YXJpbmFzOyBXaWxsIERlYWNvbjsgSm9uYXRoYW4gQ29yYmV0OyBNYXJrIFJ1dGxhbmQ7IGRldmlj
ZXRyZWVAdmdlci5rZXJuZWwub3JnOyBsaW51eC1pZGVAdmdlci5rZXJuZWwub3JnOyBHcmVnIEty
b2FoLUhhcnRtYW47IE9tcmkgSXRhY2g7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IE5h
ZGF2IEhha2xhaTsgSGFucyBkZSBHb2VkZTsgTGlvciBBbXNhbGVtOyBsaW51eC1zZXJpYWxAdmdl
ci5rZXJuZWwub3JnOyBKaXJpIFNsYWJ5OyBUZWp1biBIZW87IFdpbHNvbiBEaW5nOyBsaW51eC1h
cm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcNClN1YmplY3Q6IFJlOiBbUEFUQ0ggdjIgMDMv
MTJdIHNlcmlhbDogbXZlYnUtdWFydDogaW5pdGlhbCBzdXBwb3J0IGZvciBBcm1hZGEtMzcwMCBz
ZXJpYWwgcG9ydA0KDQpJJ20gc29ycnksIGluZGVlZCwgSSB3YXMgdGhlIG9uZSB0byBvdmVybG9v
ayAtIHRoZXJlIHdhcyBhIGxvdCBnb2luZyBvbiBpbiBhIHRocmVhZCBhbmQgSSBtaXNzZWQgaXQu
DQoNCk9mZXIsIGFzIHlvdSBmb3VuZCBvdXQgdGhhdCBJUlFGX1NIQVJFRCBoZWxwIGJvb3Rpbmcg
dWJ1bnR1IC0gZG8geW91IHRoaW5rIGl0J3MgYSBoYWNrIG9yIGZpeD8NCg0KQmVzdCByZWdhcmRz
LA0KTWFyY2luDQoNCjIwMTYtMDItMDMgMjM6MDIgR01UKzAxOjAwIFRob21hcyBQZXRhenpvbmkN
Cjx0aG9tYXMucGV0YXp6b25pQGZyZWUtZWxlY3Ryb25zLmNvbT46DQo+IERlYXIgTWFyY2luIFdv
anRhcywNCj4NCj4gT24gV2VkLCAzIEZlYiAyMDE2IDIyOjQxOjE1ICswMTAwLCBNYXJjaW4gV29q
dGFzIHdyb3RlOg0KPj4gSGkgR3JlZ29yeSwNCj4+DQo+PiA+ICsgICAgICAgcG9ydC0+aXJxICAg
ICAgICA9IGlycS0+c3RhcnQ7DQo+PiA+ICsgICAgICAgcG9ydC0+aXJxZmxhZ3MgICA9IDA7DQo+
Pg0KPj4gU2FtZSByZXF1ZXN0IGFzIGZvciB2MSwgd2hpY2ggeW91IG11c3QgaGF2ZSBvdmVybG9v
a2VkOg0KPj4gcG9ydC0+aXJxZmxhZ3MgPSBJUlFGX1NIQVJFRDsNCj4NCj4gR3JlZ29yeSBkaWRu
J3Qgb3Zlcmxvb2sgdGhpcyBjb21tZW50IHlvdSBtYWRlIG9uIHYxLCBoZSBldmVuIHJlcGxpZWQg
DQo+IHRvIGl0LiBQbGVhc2UgY2hlY2sgR3JlZ29yeSdzIHJlcGx5IHRvIHlvdXIgcmV2aWV3Lg0K
Pg0KPiBCZXN0IHJlZ2FyZHMsDQo+DQo+IFRob21hcw0KPiAtLQ0KPiBUaG9tYXMgUGV0YXp6b25p
LCBDVE8sIEZyZWUgRWxlY3Ryb25zDQo+IEVtYmVkZGVkIExpbnV4LCBLZXJuZWwgYW5kIEFuZHJv
aWQgZW5naW5lZXJpbmcgDQo+IGh0dHA6Ly9mcmVlLWVsZWN0cm9ucy5jb20NCg==

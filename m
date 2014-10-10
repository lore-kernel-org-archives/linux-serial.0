From: Jingchang Lu <jingchang.lu@freescale.com>
Subject: RE: [PATCH] serial: of-serial: fix up PM ops on no_console_suspend
Date: Fri, 10 Oct 2014 06:16:24 +0000
Message-ID: <01583b7f252b4f81a5655009f6f73aba@BL2PR03MB467.namprd03.prod.outlook.com>
References: <1412845852-26157-1-git-send-email-jingchang.lu@freescale.com>
 <543768F3.6090703@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-bl2on0114.outbound.protection.outlook.com ([65.55.169.114]:1489
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750982AbaJJGQ1 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Fri, 10 Oct 2014 02:16:27 -0400
In-Reply-To: <543768F3.6090703@wwwdotorg.org>
Content-Language: en-US
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Stephen Warren <swarren@wwwdotorg.org>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Cc: "arnd@arndb.de" <arnd@arndb.de>, Joseph Lo <josephl@nvidia.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Pi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogU3RlcGhlbiBXYXJyZW4gW21haWx0
bzpzd2FycmVuQHd3d2RvdG9yZy5vcmddDQo+U2VudDogRnJpZGF5LCBPY3RvYmVyIDEwLCAyMDE0
IDE6MDUgUE0NCj5UbzogTHUgSmluZ2NoYW5nLUIzNTA4MzsgZ3JlZ2toQGxpbnV4Zm91bmRhdGlv
bi5vcmcNCj5DYzogYXJuZEBhcm5kYi5kZTsgSm9zZXBoIExvOyBsaW51eC1rZXJuZWxAdmdlci5r
ZXJuZWwub3JnOyBsaW51eC0NCj5zZXJpYWxAdmdlci5rZXJuZWwub3JnOyBsaW51eC1hcm0ta2Vy
bmVsQGxpc3RzLmluZnJhZGVhZC5vcmcNCj5TdWJqZWN0OiBSZTogW1BBVENIXSBzZXJpYWw6IG9m
LXNlcmlhbDogZml4IHVwIFBNIG9wcyBvbg0KPm5vX2NvbnNvbGVfc3VzcGVuZA0KPg0KPk9uIDEw
LzA5LzIwMTQgMDI6MTAgQU0sIEppbmdjaGFuZyBMdSB3cm90ZToNCj4+IE1hbmRhdG9yaWx5IGRp
c2FibGluZyB0aGUgdWFydCBjbG9jayB3aWxsIGNhdXNlIHJlZ2lzdGVyIGFjY2VzcyBodW5nDQo+
PiBvbiAibm9fY29uc29sZV9zdXNwZW5kIi4gVGhpcyBwYXRjaCBhZGQgY29uZGl0aW9uIGNoZWNr
IG9uIGl0IGFuZCBvbmx5DQo+PiBkaXNhYmxlIHRoZSBjbG9jayB3aXRoIGNvbnNvbGVfc3VzcGVu
ZF9lbmFibGVkIHRydWUuDQo+DQo+SXQgd291bGQgYmUgdXNlZnVsIGlmIHRoZSBlbWFpbC9wYXRj
aCBzdWJqZWN0IGxpbmUgc2FpZCAiVjIiLCBhbmQgdGhlcmUNCj53YXMgYSBjaGFuZ2Vsb2cgYmVs
b3cuDQpUaGlzIGlzIG5vdCBhIHYyLCBwYXRjaCAic2VyaWFsOiBvZi1zZXJpYWw6IGFkZCBQTSBz
dXNwZW5kL3Jlc3VtZSBzdXBwb3J0DQooY29tbWl0IDJkZWE1M2JmNTc3ODNmMjQzYzg5MmU5OWMx
MGM2OTIxZTk1NmFhN2UpIiBoYXMgYmVlbiBtZXJnZWQgaW50bw0KbGludXgtbmV4dCB0cmVlLCB0
aGlzIGlzIGEgZml4dXAgb24gdGhhdCBQTSBvcHMuDQpUaGFua3MuDQoNCkJlc3QgUmVnYXJkcywN
CkppbmdjaGFuZyANCg==

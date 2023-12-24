Received: from mx3.securetransport.de (mx3.securetransport.de [116.203.31.6])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF6863FF5
	for <linux-serial@vger.kernel.org>; Sun, 24 Dec 2023 12:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dh-electronics.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dh-electronics.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dh-electronics.com header.i=@dh-electronics.com header.b="Th+ssTYy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dh-electronics.com;
	s=dhelectronicscom; t=1703422405;
	bh=Y1CPg8CNk2gRI6NiCH8syYJYW4DBqe188X/z7V1gURA=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=Th+ssTYyhbmTAWxKw2PGZih4arkjwL24N9wAfKXMBB3NZzE7DvfETizwBKEpxLc2J
	 NDiBNzlKyWRO7AvUIhahMWLevF2A0azafdhagfBVtyUOEVKBt+js6RI5efyvyI02o2
	 yjBFTQa4g0cUNP9MVTge+sbFaQft/CUdqIMGa+DJ1lm9r05SZ/CbTvl2YOIDSaHHzJ
	 zwcutEW86Cgkwj7Wu23QtLqsmDD6PNLWGtM1A2GzMpztABqwoVWD3YN3H9ENw5wLKh
	 mM870iMLr7swVAOxkwB/TEM9Wl0ViIcFIbIjYpn2lnC/FNW2yNmVYOkLktOmnKrl6z
	 qqnR2i2dndZOA==
X-secureTransport-forwarded: yes
From: Christoph Niedermaier <cniedermaier@dh-electronics.com>
Complaints-To: abuse@cubewerk.de
To: Lukas Wunner <lukas@wunner.de>
CC: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, Shawn Guo
	<shawnguo@kernel.org>, Marek Vasut <marex@denx.de>, Fabio Estevam
	<festevam@denx.de>, Sascha Hauer <s.hauer@pengutronix.de>, "Pengutronix
 Kernel Team" <kernel@pengutronix.de>, NXP Linux Team <linux-imx@nxp.com>,
	"Sergey Organov" <sorganov@gmail.com>, =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?=
	<u.kleine-koenig@pengutronix.de>, Rob Herring <robh@kernel.org>,
	=?utf-8?B?SWxwbyBKw6RydmluZW4=?= <ilpo.jarvinen@linux.intel.com>, Tom Rix
	<trix@redhat.com>, Thomas Gleixner <tglx@linutronix.de>
Subject: RE: [PATCH] serial: imx: Ensure that imx_uart_rs485_config() is
 called with enabled clock
Thread-Topic: [PATCH] serial: imx: Ensure that imx_uart_rs485_config() is
 called with enabled clock
Thread-Index: AQHaNSPuNwSULUnUgEmcck35MrIsuLC4T5YAgAAVwdA=
Date: Sun, 24 Dec 2023 12:53:14 +0000
Message-ID: <149f4e1020954e2e91fe1cde0e4afebc@dh-electronics.com>
References: <20231222221101.2380-1-cniedermaier@dh-electronics.com>
 <20231224123254.GA15377@wunner.de>
In-Reply-To: <20231224123254.GA15377@wunner.de>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

RnJvbTogTHVrYXMgV3VubmVyIFttYWlsdG86bHVrYXNAd3VubmVyLmRlXQ0KU2VudDogU3VuZGF5
LCBEZWNlbWJlciAyNCwgMjAyMyAxOjMzIFBNDQo+IE9uIEZyaSwgRGVjIDIyLCAyMDIzIGF0IDEx
OjExOjAxUE0gKzAxMDAsIENocmlzdG9waCBOaWVkZXJtYWllciB3cm90ZToNCj4+IFRoZXJlIGFy
ZSByZWdpc3RlciBhY2Nlc3NlcyBpbiB0aGUgZnVuY3Rpb24gaW14X3VhcnRfcnM0ODVfY29uZmln
KCkuIFRoZQ0KPj4gY2xvY2sgbXVzdCBiZSBlbmFibGVkIGZvciB0aGVzZSBhY2Nlc3Nlcy4gVGhp
cyB3YXMgZW5zdXJlZCBieSBjYWxsaW5nIGl0DQo+PiB2aWEgdGhlIGZ1bmN0aW9uIHVhcnRfcnM0
ODVfY29uZmlnKCkgaW4gdGhlIHByb2JlKCkgZnVuY3Rpb24gd2l0aGluIHRoZQ0KPj4gcmFuZ2Ug
d2hlcmUgdGhlIGNsb2NrIGlzIGVuYWJsZWQuIFdpdGggdGhlIGNvbW1pdCA3YzdmOWJjOTg2ZTYg
KCJzZXJpYWw6DQo+PiBEZWFzc2VydCBUcmFuc21pdCBFbmFibGUgb24gcHJvYmUgaW4gZHJpdmVy
LXNwZWNpZmljIHdheSIpIGl0IHdhcyByZW1vdmVkDQo+PiBmcm9tIHRoZSBwcm9iZSgpIGZ1bmN0
aW9uIGFuZCBpcyBub3cgb25seSBjYWxsZWQgdGhyb3VnaCB0aGUgZnVuY3Rpb24NCj4+IHVhcnRf
YWRkX29uZV9wb3J0KCkgd2hpY2ggaXMgbG9jYXRlZCBhdCB0aGUgZW5kIG9mIHRoZSBwcm9iZSgp
IGZ1bmN0aW9uLg0KPj4gQnV0IHRoZSBjbG9jayBpcyBhbHJlYWR5IHN3aXRjaGVkIG9mZiBpbiB0
aGlzIGFyZWEuIFRvIGVuc3VyZSB0aGF0IHRoZQ0KPj4gY2xvY2sgaXMgZW5hYmxlZCBkdXJpbmcg
cmVnaXN0ZXIgYWNjZXNzLCBtb3ZlIHRoZSBkaXNhYmxpbmcgb2YgdGhlIGNsb2NrDQo+PiB0byB0
aGUgdmVyeSBlbmQgb2YgdGhlIHByb2JlKCkgZnVuY3Rpb24uDQo+IA0KPiBUaGFua3MgZm9yIGNh
dGNoaW5nIHRoaXMgYW5kIHNvcnJ5IGZvciB0aGUgYnJlYWthZ2UuDQo+IA0KPiANCj4+IEBAIC0y
NDY3LDcgKzI0NjUsMTEgQEAgc3RhdGljIGludCBpbXhfdWFydF9wcm9iZShzdHJ1Y3QgcGxhdGZv
cm1fZGV2aWNlICpwZGV2KQ0KPj4NCj4+ICAgICAgIHBsYXRmb3JtX3NldF9kcnZkYXRhKHBkZXYs
IHNwb3J0KTsNCj4+DQo+PiAtICAgICByZXR1cm4gdWFydF9hZGRfb25lX3BvcnQoJmlteF91YXJ0
X3VhcnRfZHJpdmVyLCAmc3BvcnQtPnBvcnQpOw0KPj4gKyAgICAgcmV0ID0gdWFydF9hZGRfb25l
X3BvcnQoJmlteF91YXJ0X3VhcnRfZHJpdmVyLCAmc3BvcnQtPnBvcnQpOw0KPj4gKw0KPj4gKyAg
ICAgY2xrX2Rpc2FibGVfdW5wcmVwYXJlKHNwb3J0LT5jbGtfaXBnKTsNCj4+ICsNCj4+ICsgICAg
IHJldHVybiByZXQ7DQo+PiAgfQ0KPiANCj4gVGhlcmUgYXJlIGEgYnVuY2ggb2YgcmV0dXJuIHN0
YXRlbWVudHMgaW4gdGhlICJpZiAodHhpcnEgPiAwKSAuLi4gZWxzZSINCj4gY2xhdXNlIGEgbGl0
dGxlIGZ1cnRoZXIgdXAuICBZb3UgbmVlZCB0byBhZGQgYSBnb3RvIGxhYmVsIGluIGZyb250IG9m
DQo+IHRoZSAiY2xrX2Rpc2FibGVfdW5wcmVwYXJlKCkiIGFuZCBjaGFuZ2UgdGhlIHJldHVybiBz
dGF0ZW1lbnRzIHRvIGdvdG9zDQo+IHRvIGF2b2lkIGxlYWtpbmcgZW5hYmxlZCBjbG9ja3MgaW4g
dGhvc2UgZXJyb3IgcGF0aHMuDQoNCllvdSBhcmUgcmlnaHQuIEkgb3Zlcmxvb2tlZCB0aGF0Lg0K
SSB3aWxsIGZpeCB0aGF0IGluIHZlcnNpb24gMi4NCiANCg0KVGhhbmtzIGFuZCBSZWdhcmRzDQpD
aHJpc3RvcGgNCg==

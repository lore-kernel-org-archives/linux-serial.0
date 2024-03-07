Received: from mx3.securetransport.de (mx3.securetransport.de [116.203.31.6])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 061772AD17
	for <linux-serial@vger.kernel.org>; Thu,  7 Mar 2024 12:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.31.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709815783; cv=none; b=OR7LYll1LVzCQ+uUNoWQMG5XMO0fT7KEuVb2IEdnLx7uctfpKCbv0TZbNVdzJuTony4nerl5L7r9gUIXIzLqArOM31IdZ0dY5XBta1AY46KAOaOmLJVI5yRZVAPprBmu2G6srJLSPvfbX5HEqu70oN26ljyzp0DGKaI2dsRUsVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709815783; c=relaxed/simple;
	bh=dz5T9arzwKCedpnQDib+5FWpGK3EkGGvb9sqeR7AYug=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WFVRJQgz/15bqADPYP6WeRAyvO/deCVzeDB5bVErME7GfCexg3RG89L8Xd8OTWAvsSiIOy7ZqNeSmECH9fQiuaftHRW9sTeiDTGFHFJ4s37UscryQH6VUncqvMy8ZlHBUuq6xJY7cJasQruE3803T6wW298r+6X92oUxexyfO0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dh-electronics.com; spf=pass smtp.mailfrom=dh-electronics.com; dkim=pass (2048-bit key) header.d=dh-electronics.com header.i=@dh-electronics.com header.b=IPMHLbBp; arc=none smtp.client-ip=116.203.31.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dh-electronics.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dh-electronics.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dh-electronics.com header.i=@dh-electronics.com header.b="IPMHLbBp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dh-electronics.com;
	s=dhelectronicscom; t=1709815086;
	bh=dz5T9arzwKCedpnQDib+5FWpGK3EkGGvb9sqeR7AYug=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=IPMHLbBpIjBFyoFfgVgcZ+wXwlLV4v8+j3Ihq8AJ3PjvWHpg+VhndoimigL0vc9S0
	 jQFLPYlHtzgzdUkAu/Gm0ohj7HlqhXLh8oo5rw1k+BwNM+w810tbcIzNMGRSGM4Mib
	 jUju/NFRD8An4CQUSpJBoNy9OnLsoPxj6/Xhp93tPE2djGv9ebLRYWXhwUXjek4iDj
	 PG5/1UZYTv1X6NgGd1VJ1yimBVFMPh5gL0l302TNV9xNPrkrlk42jcVNhro1RJjhUu
	 hYa7LwNxGIKk7rFwJ8A0uz59DsuTr7oqGx/Jb5aAWFLtDfKTYep+tY25dblh5vezr3
	 zg5zh2tZnFg6w==
X-secureTransport-forwarded: yes
From: Christoph Niedermaier <cniedermaier@dh-electronics.com>
Complaints-To: abuse@cubewerk.de
To: "Tobias Jakobi (Compleo)" <tobias.jakobi.compleo@gmail.com>
CC: "Rickard.Andersson@axis.com" <Rickard.Andersson@axis.com>,
	"festevam@denx.de" <festevam@denx.de>, "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>, "ilpo.jarvinen@linux.intel.com"
	<ilpo.jarvinen@linux.intel.com>, "jirislaby@kernel.org"
	<jirislaby@kernel.org>, "kernel@pengutronix.de" <kernel@pengutronix.de>,
	"linux-imx@nxp.com" <linux-imx@nxp.com>, "linux-serial@vger.kernel.org"
	<linux-serial@vger.kernel.org>, "lukas@wunner.de" <lukas@wunner.de>,
	"marex@denx.de" <marex@denx.de>, "rickard314.andersson@gmail.com"
	<rickard314.andersson@gmail.com>, "robh@kernel.org" <robh@kernel.org>,
	"s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "shawnguo@kernel.org"
	<shawnguo@kernel.org>, "sorganov@gmail.com" <sorganov@gmail.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "trix@redhat.com"
	<trix@redhat.com>, "u.kleine-koenig@pengutronix.de"
	<u.kleine-koenig@pengutronix.de>
Subject: RE: [RFC][PATCH] serial: imx: Fix RS485 behaviour on disabled
 RX_DURING_TX
Thread-Topic: [RFC][PATCH] serial: imx: Fix RS485 behaviour on disabled
 RX_DURING_TX
Thread-Index: AQHaY+MB2vblg263n0WgWxIvwFWSn7ETDcBAgBkY/ACAACXbQA==
Date: Thu, 7 Mar 2024 12:38:03 +0000
Message-ID: <2d92d69369054578baacccf23ae2eff1@dh-electronics.com>
References: <2e866164c89c495aac905753978e8747@dh-electronics.com>
 <3a2987d4-ca89-4f4b-9f01-ee19a01c1b6b@gmail.com>
In-Reply-To: <3a2987d4-ca89-4f4b-9f01-ee19a01c1b6b@gmail.com>
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

RnJvbTogVG9iaWFzIEpha29iaSAoQ29tcGxlbykgPHRvYmlhcy5qYWtvYmkuY29tcGxlb0BnbWFp
bC5jb20+DQpTZW50OiBUaHVyc2RheSwgTWFyY2ggNywgMjAyNCAxMjowNyBQTQ0KPiANCj4gSGVs
bG8sDQo+IA0KPiBJIGFsc28gbm90aWNlZCBsYXN0IHllYXIgdGhhdCBSUzQ4NSB3YXMgcHJvYmxl
bWF0aWMgb24gaS5NWCBoYXJkd2FyZS4gV2UNCj4gdXNlIGEgaS5NWDcgU29DIGxvY2F0ZWQgb24g
YSBTb00gYnkgbWFudWZhY3R1cmVyIFRvcmFkZXguIFRoZSBTb00gaXRzZWxmDQo+IGlzIHBsdWdn
ZWQgaW50byBhIHByb3ByaWV0YXJ5IGJvYXJkIHRoYXQgZmVhdHVyZXMgYSBSZW5lc2FzIElTTDh4
eHgNCj4gUlM0ODUgdHJhbnNjZWl2ZXIuIFdlIHRhbGsgTW9kQnVzIFJUVSBvdmVyIHRoZSBSUzQ4
NSBsaW5rLiBUaGUgU29DIGlzDQo+IHRoZSBNb2RCdXMgbWFzdGVyLCB0aGUgc2xhdmUgaXMgYSBp
bnN1bGF0aW9uIG1vbml0b3JpbmcgZGV2aWNlLg0KPiANCj4gU2luY2Ugd2Ugc291cmNlIHRoZSBp
Lk1YIHRocm91Z2ggVG9yYWRleCwgSSBvcGVuZWQgYSB0aHJlYWQgb24gdGhlaXINCj4gY29tbXVu
aXR5IGZvcnVtIGxhc3QgeWVhcjoNCj4gaHR0cHM6Ly9jb21tdW5pdHkudG9yYWRleC5jb20vdC9m
aXhpbmctbmF0aXZlLXJzNDg1LWRlLXRvZ2dsaW5nLW9uLXVhcnQ2LzIwNTczDQo+IA0KPiBJIGFs
c28gcmVhbGl6ZWQgdmVyeSBxdWlja2x5IHRoYXQgdGhlIG5ld2x5IGludHJvZHVjZWQgbG9vcGJh
Y2sgbG9naWMNCj4gd2FzIHRoZSBjdWxwcml0LiBNeSBzb2x1dGlvbiBjdXJyZW50bHkgY29uc2lz
dHMgb2YgYSBuZXcgRFQgcHJvcGVydHkNCj4gdGhhdCBlZmZlY3RpdmVseSBkaXNhYmxlcyB0aGUg
dG9nZ2xpbmcgb2YgdGhlIGxvb3BiYWNrIG1vZGU6DQo+IGh0dHBzOi8vZ2l0bGFiLmZyZWVkZXNr
dG9wLm9yZy90b2JpYXNqYWtvYmkuY29tcGxlby9saW51eC10b3JhZGV4Ly0NCj4gL2NvbW1pdC85
ODM5N2M5NDM2ZjQ4YTE0OWUyZGEwYjI5NjlhMmQxZDJkODhjNjExDQo+IA0KPiBBbnl3YXksIEkg
aGF2ZSB0ZXN0ZWQgQ2hyaXN0b3BoJ3MgcGF0Y2ggYW5kIGNhbiBjb25maXJtIHRoYXQgdGhlIHBh
dGNoDQo+IChhbHNvKSBmaXhlcyB0aGUgcHJvYmxlbXMgd2UgYXJlIHNlZWluZy4gVGVzdCB3YXMg
ZG9uZSBieSBhcHBseWluZyB0aGUNCj4gcGF0Y2ggdG8gNi4xLjgwLiBJIGhhdmVuJ3QgdGVzdGVk
IFJpY2thcmQncyBwYXRjaCBzbyBmYXIuDQo+IA0KPiBXb3VsZCBiZSBuaWNlIGlmIHRoaXMgY291
bGQgbGF0ZXIgYmUgYmFja3BvcnRlZCB0byB0aGUgNi4xLngga2VybmVsDQo+ICh0aGlzIGlzIHRo
ZSBrZXJuZWwgd2UgY3VycmVudGx5IHVzZSBvbiBvdXIgaGFyZHdhcmUpLg0KDQpSaWNrYXJkJ3Mg
cGF0Y2ggaW4gdmVyc2lvbiAzIHNvbHZlZCB0aGUgc2FtZSBwcm9ibGVtLCBzbyBpdCBzaG91bGQg
YWxzbw0KZml4IHRoZSBwcm9ibGVtIG9uIHlvdXIgc2lkZS4gSXQgaGFzIGFscmVhZHkgYmVlbiBh
Y2NlcHRlZCBhbmQgaXMgYWxyZWFkeQ0KYXZhaWxhYmxlIGluIHRoZSBuZXh0IEtlcm5lbC4gSXQg
aGFzIGEgRml4ZXMgdGFnIG9uIGl0LCBzbyBpdCBzaG91bGQgbm9ybWFsbHkNCmJlIGJhY2twb3J0
ZWQgdG8gdGhlIDYuMS54IEtlcm5lbCBzb29uLg0KDQpSZWdhcmRzDQpDaHJpc3RvMXBoDQo=

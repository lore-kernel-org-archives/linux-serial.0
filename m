Received: from mx4.securetransport.de (mx4.securetransport.de [178.254.6.145])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 261F63C460
	for <linux-serial@vger.kernel.org>; Fri, 19 Jan 2024 11:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.254.6.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705664397; cv=none; b=POV0AO4t69vpJbwoaBb4pBxKXMxgvvqIm1etW/odI6/BRLX4AMojk3Q3812FJytctUVlviWQGV4/F++ZR+eYRGqNcTUZpxovN7jQEEm5p8ktDduv+cf+HWjx69NydXwHHg5ljyA7pTyhYXr2R/uYBawGhV4RWB+fCz+R1ekJhHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705664397; c=relaxed/simple;
	bh=Lo87nM6WmmJQdASBYl2V6Qa8dqL9TZETmjOGooZcW8Q=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aRQQrZZ/sG35OAgCB+LOXTD98A8kHU9LoXeKyuLsQmJfxEPtJ2+MmgR40T0safM9belIt6/1kHiRbo97iUfwKGAlxzeJ50zX1Bm79FU5anmwmfaeytUNqDDlg9RZFLjhjmkDsThy/yW9ucGsdQMGlRVt4Y1T2NgtD4vdbJxU4yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dh-electronics.com; spf=pass smtp.mailfrom=dh-electronics.com; dkim=pass (2048-bit key) header.d=dh-electronics.com header.i=@dh-electronics.com header.b=sO/NtG6o; arc=none smtp.client-ip=178.254.6.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dh-electronics.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dh-electronics.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dh-electronics.com header.i=@dh-electronics.com header.b="sO/NtG6o"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dh-electronics.com;
	s=dhelectronicscom; t=1705664347;
	bh=Lo87nM6WmmJQdASBYl2V6Qa8dqL9TZETmjOGooZcW8Q=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=sO/NtG6ounR/LqoqQ1/PML4szw1quwGJGwrlUtRjPGSvoJP+5jKkz6XCzXzCEaAGA
	 V1DopzgQXueimm54t5LTGYmcj04GWX/cEYQK3pE0MfwzBv4DgJIWRVdi/FyekbHOvY
	 QhWAbKvXtEIifibFiva4orr0wxc8ji7o/88Q1fbETjZ8nargbVmwQcZvsAHzLpxHsi
	 1BO4uUZdtj3ecHesglc1ZyglzQgRlKjsgk4/3ARwpfnFKVdcqUszamYrid5CFEG/wI
	 HVViNF02o4hJueAxjCfA9rMN9mN3k+SU2w8f/dZasO5PQvd1BOMpHDYbHrjUVQSHlx
	 lQt1t5NW1oo7Q==
X-secureTransport-forwarded: yes
From: Christoph Niedermaier <cniedermaier@dh-electronics.com>
Complaints-To: abuse@cubewerk.de
To: Jiri Slaby <jirislaby@kernel.org>, "linux-serial@vger.kernel.org"
	<linux-serial@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Crescent CY Hsieh
	<crescentcy.hsieh@moxa.com>, Lukas Wunner <lukas@wunner.de>, Lino Sanfilippo
	<l.sanfilippo@kunbus.com>, Hugo Villeneuve <hugo@hugovil.com>
Subject: RE: [PATCH V2] tty: serial: Fix bit order in RS485 flag definitions
Thread-Topic: [PATCH V2] tty: serial: Fix bit order in RS485 flag definitions
Thread-Index: AQHaSiWLX8eQRenJ8EiISLk4GeD6GLDgnn2AgABkuRA=
Date: Fri, 19 Jan 2024 11:39:05 +0000
Message-ID: <7d071d183a4d4b67bf9733152a79b69f@dh-electronics.com>
References: <20240118154624.5340-1-cniedermaier@dh-electronics.com>
 <9cce131b-6f1e-4cb7-9149-5ac8bd3c01da@kernel.org>
In-Reply-To: <9cce131b-6f1e-4cb7-9149-5ac8bd3c01da@kernel.org>
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

RnJvbTogSmlyaSBTbGFieSBbbWFpbHRvOmppcmlzbGFieUBrZXJuZWwub3JnXQ0KU2VudDogRnJp
ZGF5LCBKYW51YXJ5IDE5LCAyMDI0IDc6MzYgQU0NCj4gT24gMTguIDAxLiAyNCwgMTY6NDYsIENo
cmlzdG9waCBOaWVkZXJtYWllciB3cm90ZToNCj4+IFNpbmNlIHRoZSBjb21taXQgOTNmMzM1MGM0
NmZhICgiUlM0ODU6IGZpeCBpbmNvbnNpc3RlbmNpZXMgaW4gdGhlDQo+PiBtZWFuaW5nIG9mIHNv
bWUgdmFyaWFibGVzIiksIHRoZSBkZWZpbml0aW9uIGZvciBiaXQgMyBoYXMgYmVlbiByZW1vdmVk
Lg0KPj4gQnV0IHdpdGggdGhlIHN3aXRjaCB0byBiaXQgc2hpZnQgbWFjcm9zIGluIGNvbW1pdCA3
NmFjOGUyOTg1NWIgKCJ0dHk6DQo+PiBzZXJpYWw6IENsZWFudXAgdGhlIGJpdCBzaGlmdCB3aXRo
IG1hY3JvIiksIHRoaXMgZ2FwIHdhc24ndCBwcmVzZXJ2ZWQuDQo+PiBUbyBhdm9pZCBhIGJyZWFr
IGluIHVzZXIva2VybmVsIGFwaSBvZiB0aGUgc3lzdGVtIHNraXAgYml0IDMgYWdhaW4gYW5kDQo+
PiBhZGQgYSBwbGFjZWhvbGRlciBjb21tZW50Lg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IENocmlz
dG9waCBOaWVkZXJtYWllciA8Y25pZWRlcm1haWVyQGRoLWVsZWN0cm9uaWNzLmNvbT4NCj4+IEZp
eGVzOiA3NmFjOGUyOTg1NWIgKCJ0dHk6IHNlcmlhbDogQ2xlYW51cCB0aGUgYml0IHNoaWZ0IHdp
dGggbWFjcm8iKQ0KPj4gRml4ZXM6IDYwNTZmMjBmMjdlOSAoInR0eTogc2VyaWFsOiBBZGQgUlM0
MjIgZmxhZyB0byBzdHJ1Y3Qgc2VyaWFsX3JzNDg1IikNCj4+IC0tLQ0KPiANCj4gVGhpcyB0cmlw
bGUgZGFzaCBpcyBzdXBlcmZsdW91cyBhbmQgd2lsbCBsaWtlbHkgYnJlYWsgZ2l0IGFtLg0KDQpP
Sy4NCiANCj4+IENjOiBHcmVnIEtyb2FoLUhhcnRtYW4gPGdyZWdraEBsaW51eGZvdW5kYXRpb24u
b3JnPg0KPj4gQ2M6IENyZXNjZW50IENZIEhzaWVoIDxjcmVzY2VudGN5LmhzaWVoQG1veGEuY29t
Pg0KPj4gQ2M6IEppcmkgU2xhYnkgPGppcmlzbGFieUBrZXJuZWwub3JnPg0KPj4gQ2M6IEx1a2Fz
IFd1bm5lciA8bHVrYXNAd3VubmVyLmRlPg0KPj4gQ2M6IExpbm8gU2FuZmlsaXBwbyA8bC5zYW5m
aWxpcHBvQGt1bmJ1cy5jb20+DQo+PiBDYzogSHVnbyBWaWxsZW5ldXZlIDxodWdvQGh1Z292aWwu
Y29tPg0KPj4gVG86IGxpbnV4LXNlcmlhbEB2Z2VyLmtlcm5lbC5vcmcNCj4+IFRvOiBsaW51eC1h
cm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcNCj4gDQo+ICJUbyIgaXMgbm90IHN1cHBvcnRl
ZCBoZXJlLCBJTU8uDQoNCk9LLg0KDQo+IFdoZW4geW91IGZpeCB0aGF0Og0KPiBSZXZpZXdlZC1i
eTogSmlyaSBTbGFieSA8amlyaXNsYWJ5QGtlcm5lbC5vcmc+DQoNCkkgd2lsbCBjcmVhdGUgYSB2
ZXJzaW9uIDMuDQoNClsuLi5dDQoNClJlZ2FyZHMNCkNocmlzdG9waA0K

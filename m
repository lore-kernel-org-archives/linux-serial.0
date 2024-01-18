Received: from mx4.securetransport.de (mx4.securetransport.de [178.254.6.145])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D18E528DA0
	for <linux-serial@vger.kernel.org>; Thu, 18 Jan 2024 15:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.254.6.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705592610; cv=none; b=AreZaBx8ZLZtwwxYvYiE6r6XY6WfRQsQb2Lh8jRroiciRcOJjb/i2ReZ7sRVON+s1/umCyXHrLMVQBt7HMmYiZjDPlfWCtfelVv3WjFEfPcjNHkmVfr8oe1zCSc/2gxmGclM6kIhaQ4+ORUcM34Fq+eZJudQzx5Qty1zoRMkdS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705592610; c=relaxed/simple;
	bh=gvYAY6pmLImg/jmaH+JmkmYfG3Jb3vB98VAGPVricOM=;
	h=DKIM-Signature:X-secureTransport-forwarded:From:Complaints-To:To:
	 CC:Subject:Thread-Topic:Thread-Index:Date:Message-ID:References:
	 In-Reply-To:Accept-Language:Content-Language:X-MS-Has-Attach:
	 X-MS-TNEF-Correlator:Content-Type:Content-Transfer-Encoding:
	 MIME-Version; b=rG4SI0SKJ82ZWI0TNjpS0GjkfYtOq76jUIix4FaXEd635GlfHsIgUx4Jw+NrpTkYhsPzUalT00kydyq0KnsA/+xK/Yv8/SgGIcmyoYwDehiJF2I3EPXbIXWbnZvA4WfFmiZwjYBsD62cUVbRUHM6DnOcb4HpNFFv2/PAol+RWsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dh-electronics.com; spf=pass smtp.mailfrom=dh-electronics.com; dkim=pass (2048-bit key) header.d=dh-electronics.com header.i=@dh-electronics.com header.b=qXR9BMcl; arc=none smtp.client-ip=178.254.6.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dh-electronics.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dh-electronics.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dh-electronics.com header.i=@dh-electronics.com header.b="qXR9BMcl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dh-electronics.com;
	s=dhelectronicscom; t=1705592552;
	bh=gvYAY6pmLImg/jmaH+JmkmYfG3Jb3vB98VAGPVricOM=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=qXR9BMclBxtfEw8EMtDPgGHWDtIiSNyWW4HUBstZuxu+pvsotObvrfRLQ+QbhbI82
	 GUNHTbg6/ck48g2BG4yowQLhzGCXCs0DFmx/k3lYdI/ETxfb/zH5ZMxjEaxOWTDrhv
	 ekFE29Fcy3tb+52VWXp8yhh6PjFG0Q/a87HekEE95XtvYp0Y1ntomNvmED1hCmSzXE
	 vSo3GEMYMJO6bERwPt+X8skKbTFlnhmnwz9YgTtd5tqkbVzyRpXL5avz2A7gXOZ8XI
	 Gl6T4wsVJXW2VQXzw/FyCKcnIV1xC8HIsCn3MJGvkdRailOOyaFscW/+VgGNNlBoj/
	 KrLKSUoJc1/DA==
X-secureTransport-forwarded: yes
From: Christoph Niedermaier <cniedermaier@dh-electronics.com>
Complaints-To: abuse@cubewerk.de
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, Crescent CY Hsieh
	<crescentcy.hsieh@moxa.com>, Jiri Slaby <jirislaby@kernel.org>, Lukas Wunner
	<lukas@wunner.de>, Lino Sanfilippo <l.sanfilippo@kunbus.com>
Subject: RE: [PATCH] tty: serial: Fix bit order in RS485 flag definitions
Thread-Topic: [PATCH] tty: serial: Fix bit order in RS485 flag definitions
Thread-Index: AQHaSgwRrhJOv1ZSDE6d0xFG0slKQ7DfjZ+AgAAnyrA=
Date: Thu, 18 Jan 2024 15:42:30 +0000
Message-ID: <a07498454df74a1bb265f9a55cc8ae50@dh-electronics.com>
References: <20240118124350.3772-1-cniedermaier@dh-electronics.com>
 <2024011827-bagful-connector-9b36@gregkh>
In-Reply-To: <2024011827-bagful-connector-9b36@gregkh>
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

PiBGcm9tOiBHcmVnIEtyb2FoLUhhcnRtYW4gPGdyZWdraEBsaW51eGZvdW5kYXRpb24ub3JnPg0K
PiBTZW50OiBUaHVyc2RheSwgSmFudWFyeSAxOCwgMjAyNCAzOjE5IFBNDQo+IE9uIFRodSwgSmFu
IDE4LCAyMDI0IGF0IDAxOjQzOjUwUE0gKzAxMDAsIENocmlzdG9waCBOaWVkZXJtYWllciB3cm90
ZToNCj4+IFNpbmNlIHRoZSBjb21taXQgOTNmMzM1MGM0NmZhICgiUlM0ODU6IGZpeCBpbmNvbnNp
c3RlbmNpZXMgaW4gdGhlDQo+PiBtZWFuaW5nIG9mIHNvbWUgdmFyaWFibGVzIiksIHRoZSBkZWZp
bml0aW9uIGZvciBiaXQgMyBoYXMgYmVlbiByZW1vdmVkLg0KPj4gQnV0IHdpdGggdGhlIHN3aXRj
aCB0byBiaXQgc2hpZnQgbWFyY29zIGluIGNvbW1pdCA3NmFjOGUyOTg1NWIgKCJ0dHk6DQo+PiBz
ZXJpYWw6IENsZWFudXAgdGhlIGJpdCBzaGlmdCB3aXRoIG1hY3JvIiksIHRoaXMgZ2FwIHdhc24n
dCBwcmVzZXJ2ZWQuDQo+PiBUbyBhdm9pZCBhIGJyZWFrIGluIHVzZXIva2VybmVsIGFwaSBvZiB0
aGUgc3lzdGVtIHNraXAgYml0IDMgYWdhaW4gYW5kDQo+PiBhZGQgYSBwbGFjZWhvbGRlciBjb21t
ZW50Lg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IENocmlzdG9waCBOaWVkZXJtYWllciA8Y25pZWRl
cm1haWVyQGRoLWVsZWN0cm9uaWNzLmNvbT4NCj4+IC0tLQ0KPj4gQ2M6IEdyZWcgS3JvYWgtSGFy
dG1hbiA8Z3JlZ2toQGxpbnV4Zm91bmRhdGlvbi5vcmc+DQo+PiBDYzogQ3Jlc2NlbnQgQ1kgSHNp
ZWggPGNyZXNjZW50Y3kuaHNpZWhAbW94YS5jb20+DQo+PiBDYzogSmlyaSBTbGFieSA8amlyaXNs
YWJ5QGtlcm5lbC5vcmc+DQo+PiBDYzogTHVrYXMgV3VubmVyIDxsdWthc0B3dW5uZXIuZGU+DQo+
PiBDYzogTGlubyBTYW5maWxpcHBvIDxsLnNhbmZpbGlwcG9Aa3VuYnVzLmNvbT4NCj4+IFRvOiBs
aW51eC1zZXJpYWxAdmdlci5rZXJuZWwub3JnDQo+PiBUbzogbGludXgtYXJtLWtlcm5lbEBsaXN0
cy5pbmZyYWRlYWQub3JnDQo+PiAtLS0NCj4gDQo+IFNob3VsZG4ndCB0aGlzIGhhdmUgYSBGaXhl
czogdGFnIGluIGl0Pw0KDQpJIHdpbGwgZml4IHRoYXQgaW4gVmVyc2lvbiAyLg0KDQoNClJlZ2Fy
ZHMNCkNocmlzdG9waA0K

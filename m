Received: from mx4.securetransport.de (mx4.securetransport.de [178.254.6.145])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F14DF28DC6
	for <linux-serial@vger.kernel.org>; Thu, 18 Jan 2024 15:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.254.6.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705592672; cv=none; b=bDekmbsq+OsKLBkjn9VgBEnDDRvfmozj999tYSNJzzwb3vqjaSweJORPKA51L817YNxQsoAz6dCA87ceIt4aJuDBQvesFRFz64LWrOxex++UbVjeqYyio5DWm050zaazikenCYsy1I8tUHJOAxhsO+6kD2Dni/Pz+rBsnTttY2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705592672; c=relaxed/simple;
	bh=4T0iPnZl9qFNqrrquCbhqsT8dEyQ+iuVRC8k50Nsksw=;
	h=DKIM-Signature:X-secureTransport-forwarded:From:Complaints-To:To:
	 CC:Subject:Thread-Topic:Thread-Index:Date:Message-ID:References:
	 In-Reply-To:Accept-Language:Content-Language:X-MS-Has-Attach:
	 X-MS-TNEF-Correlator:Content-Type:Content-Transfer-Encoding:
	 MIME-Version; b=Th5wsHELVIowgWkympp5cW6p6XY4dfR70yFDbCJoqcLrGI9dmOMOZwMW0GCaaIPUp0/hCF+teOCExUTfBoI1lms2zSyyIR3j8iUpyefge22mbZu9PZr6ub9cKHB+vkMKZ5MODK+ACrGcvrTXbMjg1lbqVykccjcMkcYm1vAxyvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dh-electronics.com; spf=pass smtp.mailfrom=dh-electronics.com; dkim=pass (2048-bit key) header.d=dh-electronics.com header.i=@dh-electronics.com header.b=kHbqwhfF; arc=none smtp.client-ip=178.254.6.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dh-electronics.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dh-electronics.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dh-electronics.com header.i=@dh-electronics.com header.b="kHbqwhfF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dh-electronics.com;
	s=dhelectronicscom; t=1705592629;
	bh=4T0iPnZl9qFNqrrquCbhqsT8dEyQ+iuVRC8k50Nsksw=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=kHbqwhfFh84g5Zo4hYhRpTw3qwpyAA5hKP4y7glR5ei9ZLyWfQ2OPa/+dcEIFCtLw
	 qdFhWcyZc7flQWg3ooLofv2FVNImsGL9ToVOFzkQAi7tTGDEQh+j/KpPcWrrAiFFf8
	 FYuWIWaTxRgQfyB4jwxcAxUXxZyOELv7H9/xEyhb6ecRHcYQNJfgPqm1xfqTeqATrs
	 Vf5jgIQ6t50ljRTt2M06Ay39GykUSnVFNGF7elFm1DfnOaIvW5TMr8KRIla1Y/pw0y
	 b6Vz8z5Ws1N3fwrljTPfizh56+t6FrZ13rqBoerrCaRiKUozTkW/ITGmsxhIgsyqEB
	 vvMNclDTxso/Q==
X-secureTransport-forwarded: yes
From: Christoph Niedermaier <cniedermaier@dh-electronics.com>
Complaints-To: abuse@cubewerk.de
To: Hugo Villeneuve <hugo@hugovil.com>
CC: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Crescent CY Hsieh <crescentcy.hsieh@moxa.com>,
	Jiri Slaby <jirislaby@kernel.org>, Lukas Wunner <lukas@wunner.de>, "Lino
 Sanfilippo" <l.sanfilippo@kunbus.com>
Subject: RE: [PATCH] tty: serial: Fix bit order in RS485 flag definitions
Thread-Topic: [PATCH] tty: serial: Fix bit order in RS485 flag definitions
Thread-Index: AQHaSgwRrhJOv1ZSDE6d0xFG0slKQ7DfmWKAgAAcdmA=
Date: Thu, 18 Jan 2024 15:43:48 +0000
Message-ID: <b238396dab2447e7830b19879e5e48f5@dh-electronics.com>
References: <20240118124350.3772-1-cniedermaier@dh-electronics.com>
 <20240118100049.0e17d2d8808df7905ff45d71@hugovil.com>
In-Reply-To: <20240118100049.0e17d2d8808df7905ff45d71@hugovil.com>
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

RnJvbTogSHVnbyBWaWxsZW5ldXZlIDxodWdvQGh1Z292aWwuY29tPg0KU2VudDogVGh1cnNkYXks
IEphbnVhcnkgMTgsIDIwMjQgNDowMSBQTQ0KPiBPbiBUaHUsIDE4IEphbiAyMDI0IDEzOjQzOjUw
ICswMTAwDQo+IENocmlzdG9waCBOaWVkZXJtYWllciA8Y25pZWRlcm1haWVyQGRoLWVsZWN0cm9u
aWNzLmNvbT4gd3JvdGU6DQo+IA0KPj4gU2luY2UgdGhlIGNvbW1pdCA5M2YzMzUwYzQ2ZmEgKCJS
UzQ4NTogZml4IGluY29uc2lzdGVuY2llcyBpbiB0aGUNCj4+IG1lYW5pbmcgb2Ygc29tZSB2YXJp
YWJsZXMiKSwgdGhlIGRlZmluaXRpb24gZm9yIGJpdCAzIGhhcyBiZWVuIHJlbW92ZWQuDQo+PiBC
dXQgd2l0aCB0aGUgc3dpdGNoIHRvIGJpdCBzaGlmdCBtYXJjb3MgaW4gY29tbWl0IDc2YWM4ZTI5
ODU1YiAoInR0eToNCj4gDQo+IG1hcmNvcyAtPiBtYWNyb3MNCj4gDQoNCkkgd2lsbCBmaXggdGhh
dCBpbiBWZXJzaW9uIDIuDQoNClsuLi5dDQoNClJlZ2FyZHMNCkNocmlzdG9waA0K

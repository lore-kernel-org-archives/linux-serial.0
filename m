Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.227.15.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795108365;
	b=pItA3XeKT24JEc75GvMLfUaMXrAkmf2Y1/EcsTB0kxcsDIkmC87V5lhfE30uXvr1pQmU
	 nKQYie3cDFC67Y9emmYYqX+r3iw2nhHDOQ6nos/Rw8wqanzQXkPfoP32Ld0R2JfBPINtC
	 HOYndPI7JRGiHo5KzuA0LJbbwN0EAepxq7aUMAq5tb/K+amMACJnqVYigb8NBExlHQ007
	 keJZgkawks61MMuujFFPVDVqFJbKxQT/Mo0XMImkuQEPwr8C8BMZy4Wu0IdcOIoHQD8Om
	 8mFYq0EGlkLfCu0SviswTDr9PDWG12gvr6zQjGgAEC7KRCqr7pXTs8BFjzTgVSB3AnQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795108365;
	h=DMARC-Filter:DKIM2-Signature:Message-Instance:DKIM-Signature:
	 X-UI-Sender-Class:Received:Message-ID:Date:MIME-Version:User-Agent:To:
	 Content-Language:Cc:From:Subject:Content-Type:
	 Content-Transfer-Encoding:X-Provags-ID:X-Spam-Flag:UI-OutboundReport;
	bh=KQSvxSZwD7QKTmwzrz8ovV+WLXdtw9mx9440l00tzRU=;
	b=xB8C9RJ+Be6Bfs7dQTfu/TRF828NEC591RWx+C1D7eYyi1/PjWuPxC8uHb3h352z/BFq
	 vkOckbRuANQl07GtLMm0XmVG6YBDcB2x78hIfyZcZuaHH8OgWsXuYNJiCKTKKR8jFJM2p
	 fARIj2idAueYNCv0ADVnQGKes2DzEisX3+bZ+CCsIcNGwgz6DFXRvIliUi6JDPtWJnF9B
	 ZKICwZs3ZdLonxyfrqSok75JXOMmWYypsSVA1L3P5O62LnyJxvJTcHSstptBoYuMW40Tt
	 GLbnZhc7sVmR7Y2T6u4Dqoeg58r5Q0yD3O7oEumtEUHTppI+90H0DpWiaXCsFjPu0oQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=web.de;
	spf=pass smtp.mailfrom=web.de;
	dkim=pass header.d=web.de header.i=markus.elfring@web.de header.a=rsa-sha256 header.s=s29768273 header.b=TY7HjTHT;
	arc=none smtp.remote-ip=212.227.15.4
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5243606CA84
	for <linux-serial@vger.kernel.org>; Thu, 19 Nov 2026 17:12:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B5243606CA84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.a=rsa-sha256 header.s=s29768273 header.b=TY7HjTHT
DKIM2-Signature:  i=1; m=1; t=1795108362;
 mf=PE1hcmt1cy5FbGZyaW5nQHdlYi5kZT4=;
 rt=PGxpbnV4LXNlcmlhbEB2Z2VyLmtlcm5lbC5vcmc+;
 d=web.de;
 s=s29768273:rsa-sha256:e5zehFUVIJDsuZZ5MobtyyK/UndS
   pbG2PmUeOhiJJFHgMbLOP3WPgsbgg/wat68okx6JvgGgJlqRTuqnz43UbM5f86e1ATfFouu1d2c
   FJrvClsXUue5akqphyc5HS4Lv+Zjikx6AjJrKg8vvpxReasjny3A8wzzYC+41WhjHeo6i2pqd2x
   gHQxxq2WxP6kzo2q4PJELZbiq+g0FpBw4iDKa60TELQ2FHzsKViK5+ck3A2teh5SOMajr50TACz
   cqaMd6DsMcebxdYOCOcCXO4Z8cwPaOS6jj9/0iGXIuSM3h/h4z87XlSQ1HTFxATd4m5nCKJVVq3
   jbR2DTeiEm2XZA==;
Message-Instance:  m=1;
 h=sha256:
   GOyM6r9kj3R23jhKiJjNavCCAsv6CrAc7hQ0jghV4oc=:
   P+FzLDwCYgiM4bAEgz3zP0/NqCdzwpMvPMAxgZgcV1c=,
  sha512:
   jcjnrPyWrjn/1q13D4j3WtHJfX7kjBhOtvPc4g+8IiecW8nRl3vjmjE+AyMiD9V5F2wtGoEj0Lop4lDr6IOUAQ==:
   +yzteLdkbfuqL/mxWrDRFNViCH9/jolJ1KTC95BoUrVPsZLjuU+1onwK1ztypa7r2dh7ztyKOFrP70d6ZMr5vg==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1795108355; x=1795713155; i=markus.elfring@web.de;
	bh=KQSvxSZwD7QKTmwzrz8ovV+WLXdtw9mx9440l00tzRU=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=TY7HjTHT+5OfBELyKIy3PrfKXYADd78On/dVrSMYzp4V5R/AeN//x183SdDNzvm7
	 zha0B5JayT6M0XbfYpFRo1JDiCyW630zB/cZnAUrqc/rkwxCUkUVh670BjaM3pmpO
	 qCz8hwcqPEYHokqhTGMzHYOOvxXS3m9poOU8mfcBj2WHsE8hi6U3thayocYdpmbwM
	 aR6SGwfNwXJIfgB6937iipbV8WxC/c/WvtS7x2F8dtfghSaCEZjjRdR2bbmbkwWXY
	 BohxtNeDfHKJdVfwbuWjph0/nogcVQL7RLIOxmfMrrS4M8IC6fUXQeHPBQ9oLNuXC
	 8TmnZrr2JdFyHsD2xw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mfc4q-1woRLf1bOy-00jTFo; Thu, 19
 Nov 2026 18:12:35 +0100
Message-ID: <1333a82f-d074-487b-b3ad-c1a3496b312b@web.de>
Date: Thu, 19 Nov 2026 18:12:33 +0100
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-serial@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Hugo Villeneuve <hvilleneuve@dimonoff.com>, Jiri Slaby
 <jirislaby@kernel.org>, Joachim Knorr <joachim.knorr@ziehl-abegg.de>,
 Luca Fresi <luca.fresi@bithiatec.com>,
 Martin Fuzzey <martin.fuzzey@flowbird.group>,
 Paul Mbewe <paultyson.mbewe@ziehl-abegg.de>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Content-Language: en-GB, de-DE
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
From: Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] serial: sc16is7xx: Use devm_clk_get_optional_enabled() in
 sc16is7xx_probe()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ZpI5x4TaVHpMh4SKPNe46g8nbL7VZQxroV2irFjj7XQ/nerxP7d
 1Z/C1Jp3RxUln6SRgesLhJfAgExBUCifipVHmgB4dTNP2KdhDAGAgdwTTk4asDQ/aPbnDxX
 UPL69K1P+ogGyXaB9JanZ5gwKKzDn9zTb3t6aK6OfHY1casoqNzqAtqBhebIa1Z9LQzHity
 e31U+U7/rsDYQPKo1PV9g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:NkeiehiDkCE=;GUOyj4luCHqXIryISxuITrYSvZH
 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
 f0ANLKFmudGaxYXO941A==

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Thu, 19 Nov 2026 18:04:56 +0100

Reuse existing functionality from devm_clk_get_optional_enabled()
instead of keeping duplicate source code.

The source code was transformed by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/tty/serial/sc16is7xx.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx=
.c
index dbf38825a78c..3af8ea93b34a 100644
=2D-- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -1605,14 +1605,10 @@ int sc16is7xx_probe(struct device *dev, const stru=
ct sc16is7xx_devtype *devtype,
 		dev_dbg(dev,
 			"No interrupt pin definition, falling back to polling mode\n");
=20
-	s->clk =3D devm_clk_get_optional(dev, NULL);
+	s->clk =3D devm_clk_get_optional_enabled(dev, NULL);
 	if (IS_ERR(s->clk))
 		return PTR_ERR(s->clk);
=20
-	ret =3D clk_prepare_enable(s->clk);
-	if (ret)
-		return ret;
-
 	freq =3D clk_get_rate(s->clk);
 	if (freq =3D=3D 0) {
 		if (uartclk)
=2D-=20
2.56.1


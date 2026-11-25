Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795601336;
	b=JjbaFGUNCyLfwTDb76Q8vGlpzdbdmFJtcHh94dMzUrYzFvgh4IM9oeftqiCqFzxHzI9J
	 /oFe52VrsBttQU9t4zzEMHa7HyYQ3Tz1wevy05bfc3scSEGkWgkL/zSqefx4dc/LwDOq3
	 01/BJjmmAy3PkhV4X9C89MXuuQlT2qjnupCJzJ1t5HLns5Sm2IhzSG3D9DYIjlYY7gN50
	 8zslybz2T/p7EM2sVctNsQl5w5ma9Me117nDwp2NpyFFXFdqo/w0WkGzHjE88C8/9QHPH
	 +sQdbf9+w1K0Xr0bFEdEwlnfDRUAXyUKxXWNY2ibPdhuoAuu2CXW+q2mYWY36wvB38Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795601336;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:X-Developer-Signature:X-Developer-Key:
	 Content-Transfer-Encoding;
	bh=uOIhdgYYl3Tswsoq8ZOrPa2VyaA03HUIcJpJs6oMo8g=;
	b=TZWxdx/B7aQvETujVRsTLREdXtJyFiP0Vgs5RQ/PBiXj5uh1vTZFdeAE9P8LJigofz/y
	 XwoPHeRsUgDhfJp/pTcbCO9E6VUZA9JpYIeD6dMRpvfXig1PGo7GSWftxiBv5c0AT8F01
	 ZOWhMx8GXIL/KcFc4z48QxmmjmpCLMVcDhYm8OiSQRBZzC/orVLt1Lv8Za8XVyjSivhv0
	 M09oHEQr3j7Pc3QasT7dWiBr8Ey8zPOJHfcdrfWo5qta9ixcoo7zIhAZ3F4kV5a/cjsgi
	 Lu1nIYDUdhYCMyCdXiTZ1HnpcCll1gDQAswffovZpv7aPeWpPIbmB6PM9/h1U2byPeg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=baylibre.com;
	spf=pass smtp.mailfrom=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=F3bLAZRJ;
	arc=none smtp.remote-ip=209.85.128.44
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7D01606A68F
	for <linux-serial@vger.kernel.org>; Wed, 25 Nov 2026 10:08:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E7D01606A68F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=F3bLAZRJ
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4a9a8d6cea8so71436775e9.1
        for <linux-serial@vger.kernel.org>; Wed, 25 Nov 2026 02:08:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1795601334; x=1796206134; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=uOIhdgYYl3Tswsoq8ZOrPa2VyaA03HUIcJpJs6oMo8g=;
        b=F3bLAZRJ4L0TCUYJIneqzF0cPorSuQA+8Zgnfq/1mJ6/j7zp7odAcJ8aPinlS5rYwO
         7Yqm+bZe/d1g5fX1qy1i7UfUFJ/oH/3kUvXB1clrWDRB0chNDR+s/zeVARbOXlNHtNnI
         bgzU85QtJj2RINYNU7yiNFXwhwltPJat7S7DbsWvKjoS1xxTkm1e+zcc4pWwHzq8XrDc
         I9AtLQ6V80j8pd9COi2d42500vUtRNNq8BfCJRwsdSzQORh/AZx8RYwceVGAkTFpx0j4
         vSUDqQhyqgIY6TEKasWZK+x81u+F+OpNvs2WYcjUKe0mh1U9T5mLlheZeDBZOmIw4AQR
         vxUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795601334; x=1796206134;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uOIhdgYYl3Tswsoq8ZOrPa2VyaA03HUIcJpJs6oMo8g=;
        b=PDMIupAFxflLC2cfdwav5eUzXi/OD9MLLI0QdV7w4L8l9DOhzILcAgty3tCKrulE86
         A5xmKVjKMbicgGWCgqs7sjxdafSz+UXPAGp0oJ5da0PaZMx6ucV93TBGZ+YPB6/TIWZ1
         brF4qf3qLJ1f6SLmV9dkYL1ITBPVJT249f+RYH8LpuZcSFH/FBugBIKanX+Wds5I6gg8
         LpEr5dK/EOO8+pOKRLMCuFwJuiC8F3BDKc87OngQS5Fw0r2J7LZNwRZxcIXURlr3hUMq
         59PIHsHDR81UQBiv+cXKZlkFzon5IWJfW6Zd35CPMjxSNPv88XOcEsTNaoiYuyanVxwR
         4Zeg==
X-Forwarded-Encrypted: i=1; AL+hErGtEAMPpGc1pl/8zmQ02XtclGS1rr9xEAhQUph7OYAoVqFFjXxxPtFLcpUjMEBTty0633CaTWhku3QR14w=@vger.kernel.org
X-Gm-Message-State: APuU4Z9hEtR65bzeKIQMwl7NNkGWbp9pT14DiJ5EaEufO5l7cpld7L/D
	BKEk+YoRXuGTjmsa+haYwPKNS3Uk7/O/N9mJZer3IZDNSGd5ydndsiaNT3GRz8ZhGPE=
X-Gm-Gg: AZFdTZc1t22lX6oZeDfLdDNWJ+2MW1JoOAhYQKlETO4GsRMvqWpwGso3N++TOxRTsMm
	oYpavGc8Ip6yRKx4kIMqQs9Wnjl+FbP/+m2hCG5s6z+6KhqMT5DNAwOCFDNIVWut3NL292RhKMF
	UXBP0BjE1/g6/GsZSuWX/BFDBr2VnvjEp8H0KAKhgH0gn7d+pEQRy6NZkOS4HDapnon3ilmYsAD
	tlMnUsW6DCmv9fgcAl6hl04YO//YZpK626QDE+mw/j3ZNUttuv7GCH/mq669JNJKCyeZKd2BXcK
	oYeVzzvRJEHDsx4Dr3meGGeauJzCFGAjIzHuLs1G9LwHGTQilMS2RtHTwU5OTxBOSToqKlGGKyc
	kQZ0zBmBmU/sdhUyK9jfZYFildAFjrPceOF2HFwbXzSn8omn331V5hiEF1I+hPssf2zuBCYR+OB
	Zn61734Q/lRADu0TyVTxe08EPsXmSHGDUZ5C4RcCNuhGCDLHvE58o9qF229IdwVbIcYVhBR3VhX
	Ro7znXyEnydvnsFh8Sohc38Yktji+mR9eVN1criUi8mLfC54HnPedCGlqdqkFZJ8MUXaZmCpozC
	KPYdTgmTr99NnIuVf6ifgsd6ucLX96uWgdj1qtHx+D8ULR96N2c6kyKgEF7J5/Yl2N0rrLRrHps
	Y6GYqnFaXxN+zcogT8g==
X-Received: by 2002:a05:600c:828e:b0:4a2:526b:d40f with SMTP id 5b1f17b1804b1-4bb88785898mr361254695e9.0.1795601334234;
        Wed, 25 Nov 2026 02:08:54 -0800 (PST)
Received: from localhost (p200300f65f19a9043ef7230869dfba63.dip0.t-ipconnect.de. [2003:f6:5f19:a904:3ef7:2308:69df:ba63])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4bb90660cb4sm449510685e9.2.2026.11.25.02.08.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 02:08:53 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Paul Mbewe <paultyson.mbewe@ziehl-abegg.de>,
	Joachim Knorr <joachim.knorr@ziehl-abegg.de>,
	Martin Fuzzey <martin.fuzzey@flowbird.group>,
	Luca Fresi <luca.fresi@bithiatec.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: [PATCH v1 2/2] serial: sc16is7xx: Drop unneeded __maybe_unused
Date: Wed, 25 Nov 2026 11:08:39 +0100
Message-ID:  <e9ebc84efca3b347bde38e6134669259edddfbbe.1795601260.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1795601260.git.u.kleine-koenig@baylibre.com>
References: <cover.1795601260.git.u.kleine-koenig@baylibre.com>
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1047; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=lKakDurq/8xHM9QheyahU7Oa2ewwMH3MggWzJCs00ig=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBrBrOqd7mwghVMjsKsQSlaYCOO35snT/l77P/18 KlGb1DM6R2JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCawazqgAKCRCPgPtYfRL+ TnK9B/wMCJ+ZYxIrKe5UOXeYw1oQKPOzLASMOQVqngrK68Jw6qxLkLnPay+52pjQdIWHL6TfW8X BSIrO1yI2aITE1exUclSzpwMlx+H4SYOZJMLX5CrG9F15SNtSW6RrG5wUIGmOUbaEsecYUAbBMa UNr6zrsNWBNMvWOmBG9blHKZf00cHRScRoDReHO8BnWxZXTLm0Z76ZMr1X8qT6/1hkQtHELvSjL gXPNpHnhOeebzU5OMw6g1EqPDAgPjSB+tHpesq8HPoyilY/eu3e2oB1xrGhYRE0R5CenGooj5yv BHKqoYlKNKOHYPJejYS2m+yB8OXh7fG5dEZTc8lUFNir3E1l
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

With `MODULE_DEVICE_TABLE(of, sc16is7xx_dt_ids);` the array is used
unconditionally since commit commit 5ab23c7923a1 ("modpost: Create
modalias for builtin modules"). So the __maybe_unused marker has no
relevant effect here and can be dropped.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/tty/serial/sc16is7xx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
index dbf38825a78c..afedb89018af 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -1745,7 +1745,7 @@ void sc16is7xx_remove(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(sc16is7xx_remove);
 
-const struct of_device_id __maybe_unused sc16is7xx_dt_ids[] = {
+const struct of_device_id sc16is7xx_dt_ids[] = {
 	{ .compatible = "nxp,sc16is740",	.data = &sc16is74x_devtype, },
 	{ .compatible = "nxp,sc16is741",	.data = &sc16is74x_devtype, },
 	{ .compatible = "nxp,sc16is750",	.data = &sc16is750_devtype, },
-- 
2.47.3


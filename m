Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792875154;
	b=Wgjh9ICEEmMHiSluc1Sb556UW4L7Wu+e+dErVGtmjhzbteSm4aXh5GwvjVFO2Utvz4fq
	 S+Vxuj8y08Uw/O9ozAJL2IU7U3JbUUE+Ln+QsAo31GACk+Rbm3izNa+Ilp7NvtW5cMwyt
	 7nSQ+cucu5ymqV2SEcGW1mwGnYBg4kc7nvvdn/H8UbEsaB+ZXpISOv74iRHpSTIlMmEn+
	 Ayzh2h63o/Ew54uxRnsMoA9mt2mHRarmcpYdiPFHT0uOtnKRjsthueZMwontTFnGvXe4/
	 mUvQpbIT097/Uq5fH5aDJ9zkAFyBfFZHQXDoNAU3zNweLkSro3OLkn2XI4g1iJCuiQA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792875154;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=vTCI+nDxJukp6A5kK1BpAWHpCDcT464wzBcHkx0Jj0Y=;
	b=OM1esUTzvdl39bas4H6PkUxUHekLNwfqmKCrDvdttrXs6aZiLqHQizqICoyamDV3RuMU
	 fBYLIK9IScRBGXhJ0uEWWZDxEFoljmWHYaAqpRKAHCVNJ0VMX+O/Pd3FlEajks2IKWcL3
	 5AGG1miZSGeQMUjGJD0JtvUbb6CEm8XJoDnYDi603rVwyUANKmkxlbIogaSFMeFSMr0qc
	 cLgse1w/q28tSillJmK1CtPK9nl/xHCrisuoeynFuqVd0VokrSBf6+Z9wn0Lw/M64WQYw
	 F6LRWLNG7GzWgkRmSxNTyePMKQnHT2RNdoZ0WGsLfBYUUEn74qdkXi2uaNCKe6FPt9A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=gAq6wKcf;
	arc=none smtp.remote-ip=209.85.210.50
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B43D606A31B
	for <linux-serial@vger.kernel.org>; Sat, 24 Oct 2026 20:52:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1B43D606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=gAq6wKcf
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-833e671ee9fso1689263a34.0
        for <linux-serial@vger.kernel.org>; Sat, 24 Oct 2026 13:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792875153; x=1793479953; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vTCI+nDxJukp6A5kK1BpAWHpCDcT464wzBcHkx0Jj0Y=;
        b=gAq6wKcf3z/+3nF9vgZuI0PqoqdEyOylIwnAX/7TL2NuIhm1dos+YsijsyGpIR+Zfl
         oaHoWyHngYRqKx8+92Y8THeHJIRF9+2/UQx52Y4xpEXwx6gUirkfWfhWf9qpkqKzvWYf
         oFIeESHM2ShL+qEx1gI0JVmqWuIC/e3g7Pffv8/mt4OvJX/kaRC2dWoNttUFpFK8lKy3
         GESnwvYZ5RYvMmlgRVv+oEt2KZ3lUEpfBUyMv7RD54C6qWTNN+3eC88TKgvPyemqM8AR
         jAHNdgHQTC5N6dI62UMPOInnvjWR2Pe2lYFm268H3J5vipy/bsQ+ph4oDHLgg5/2Q4mz
         CJMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792875153; x=1793479953;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vTCI+nDxJukp6A5kK1BpAWHpCDcT464wzBcHkx0Jj0Y=;
        b=CLql8l7xZOYlVzbxdE6BPNYT5NDWyMRG75NCgqt54c2MQYZxOY2vz5aFPVOxniZ0kn
         0fhTQDAqXL2iWHYwAoYmVniOS7Ky5jjJIQiHKoO/Km3nR96aOcjanrd3M/RrqHaSOOYH
         Bat55B4eB2MsWxJjV3A1nEsKzI25l/dT6DiFrfMD9LRNbojAXyYkYCaYaTe7zid4C396
         4rO8BHdSufQzv82Zthn4ynEpnoVGembNdQ3j9L1uweNyZfzViXhEX8RzGQgxSfqrmyEG
         R7zEa1LSM3gHckjPZtr+Q0rBzkCLTsGXD/HjihTqxe8yjrKGXxRuI7xf0lKihhEwnkrU
         A5zg==
X-Forwarded-Encrypted: i=1; AKwUvBwmppTDo4DdiUuYwVw/ajFpQoE/bLtjLlAUWS8LKpGeAU8HZQouOVxYcmJQfdRVNMY1Aq8eARMivzPJBWc=@vger.kernel.org
X-Gm-Message-State: AFq9FYLU74+fiyzHH3qtlWwWmGwlL/tY6i2lU0JWwd2rh2TmIyGD2BRj
	CjC/+85Sy41gjXz6EGVeV3ZdHEzzZxNUfD7R6BjtYMG7D1t4sUui5Wex
X-Gm-Gg: AYBFou1PwjwxeXd6lKEEiiSPUd8TkqPt3OuBNI5HMJLGZuoE63xmijlU5Fm6L96uIwB
	kP7ZXFSSVX9e9TlveAt/liKrmXTeQLS6Xg6oq7pn5UouknsdJtwbnXPdJNgUW8iMlC4CPuXApBG
	Aarb3mEXxZGh/SQzpXesceeslg1WTG9so34FIYcjikpMK1XrEaLYixpNobFHKlnoGEb0y0xZURu
	YlKPMp8U958E+hQM0jv35k8CBgBWPmBFRjBu6ZWw47kOKarHjpokCJ4TRbiheGNXH77G0armVMt
	CJ6DNZ/6Goq54RQpps7e1UfqK+eaiVPFVJqMgfG1UYEZC7IHsiOUAqk4h7B+q7RoylelsqV5PZE
	2NLUleBHdhgVDliJVqhmRXEY5Q7aIuEUtKyExUIRbTOnGaZG4/1wzdx/gZmY8NpwkKmeGBUkB+y
	fCSWokKW8A2WEKW7zfrcL3eWa/Bx1q/hDbtVqZe9+Jpb3uiIqFxRycuLshE6R/xG3uhX/xtxjKQ
	P5cYT7nAZ1KRYZ1oZhWvI4ZYvKesVJFy1879DfIYrXEvVQQBG80e+Ihn80npzbak0tO8NP1E0OL
	S4kFYbFRs8VbuqwB1Ripty31nrI3c7FnLwNIzroKY0VrUbwqkTVkth+rVGr9n8mQEsFIL3ZIXSM
	yiYWomVXp7ybOnxZiP67jDxSt6tCngFWnHSVK7sjRYdTElyZrbQKuHPePJeICYYeiKX6F73rWD/
	6pPw==
X-Received: by 2002:a05:6808:c1c8:b0:549:a550:8acf with SMTP id 5614622812f47-55c003426f1mr2007470b6e.50.1792875153162;
        Sat, 24 Oct 2026 13:52:33 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-55c0429c932sm1986785b6e.7.2026.10.24.13.52.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 13:52:32 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Sat, 24 Oct 2026 14:52:26 -0600
Subject: [PATCH v6 1/5] serial: 8250_omap: separate locked TX DMA
 completion processing
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261024-submit-serial-8250-dma-cancel-v1-v6-1-6f366591f566@gmail.com>
References: <20261024-submit-serial-8250-dma-cancel-v1-v6-0-6f366591f566@gmail.com>
In-Reply-To: <20261024-submit-serial-8250-dma-cancel-v1-v6-0-6f366591f566@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Raul E Rangel <rrangel@chromium.org>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Tony Lindgren <tony@atomide.com>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Richard Genoud <richard.genoud@bootlin.com>, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 Jacky Huang <ychuang3@nuvoton.com>, Shan-Chun Hung <schung@nuvoton.com>, 
 =?utf-8?q?Pali_Roh=C3=A1r?= <pali@kernel.org>, Frank Li <Frank.Li@nxp.com>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, "Maciej W. Rozycki" <macro@orcam.me.uk>, 
 Timur Tabi <timur@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev, 
 linuxppc-dev@lists.ozlabs.org, James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.15.2

Separate the port-locked completion processing from the DMA callback
wrapper. Keep the shutdown check and locking in the callback, and retain
the existing FIFO accounting, delayed register restore and THRI handling
in the helper.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/tty/serial/8250/8250_omap.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
index 4805b644ccb1..b6f108d34854 100644
--- a/drivers/tty/serial/8250/8250_omap.c
+++ b/drivers/tty/serial/8250/8250_omap.c
@@ -1080,18 +1080,13 @@ static int omap_8250_rx_dma(struct uart_8250_port *p)
 
 static int omap_8250_tx_dma(struct uart_8250_port *p);
 
-static void omap_8250_dma_tx_complete(void *param)
+static void omap_8250_tx_dma_complete(struct uart_8250_port *p)
 {
-	struct uart_8250_port	*p = param;
 	struct uart_8250_dma	*dma = p->dma;
 	struct tty_port		*tport = &p->port.state->port;
 	bool			en_thri = false;
 	struct omap8250_priv	*priv = p->port.private_data;
 
-	guard(uart_port_lock_irqsave)(&p->port);
-	if (dma->shutting_down)
-		return;
-
 	dma_sync_single_for_cpu(dmaengine_get_dma_device(dma->txchan), dma->tx_addr,
 				UART_XMIT_SIZE, DMA_TO_DEVICE);
 
@@ -1123,6 +1118,18 @@ static void omap_8250_dma_tx_complete(void *param)
 	}
 }
 
+static void omap_8250_dma_tx_complete(void *param)
+{
+	struct uart_8250_port *p = param;
+	struct uart_8250_dma *dma = p->dma;
+
+	guard(uart_port_lock_irqsave)(&p->port);
+
+	if (dma->shutting_down)
+		return;
+	omap_8250_tx_dma_complete(p);
+}
+
 static int omap_8250_tx_dma(struct uart_8250_port *p)
 {
 	struct uart_8250_dma		*dma = p->dma;

-- 
2.53.0


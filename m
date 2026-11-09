Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794196273;
	b=Z83mqGRr5DclyOZnJYzb1PSaRqOLVAl5SNUm0bdsaUsA/btW1rA8Nc+YtZc/XjC8gUPc
	 bdmnf/XYRWXwQsll6QXDP9ocUdddG/GUKzkRQx3jNU80zsxD2YgGFF63icQH68wE97x6c
	 4oCvdxjQ8upf/JXY1IZB3c4+3To/q/sLB34gueFlfiQo04j1MgQ6L8A6P4moeuFefujGJ
	 Enk6CT3XUUCLfzGq3VT0eS6LqF05t2MywoEBoeAAIf6qndi99aryFOORBuGDI8a54wKwP
	 J53xZKrtZZb0naj4xHztgpEySo3cFNxdR2J1tDP00dDRgA/3IC1kB0YijTgcyLqAzSA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794196273;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=+f3wqnZmmj2eYXbJU0o1qM9Y+NCisSMFy31udWGduqg=;
	b=CYkOBHsxHLXX7s+tZvWCL4wFjZ2hLRvRu5xTbs20TYw5+Rfxg94FzpZIJdWpU8h501YC
	 TUr5G4BKIjHSkLYr+ZKbUMIQhbPi9LmAK4bnsAw7ocnnonLfFsVRewrqPbCA1MW18wtdM
	 gk5hDPhX9K6E1prA9H4ksAglOo/vINvs6QJGKhIy62iz4w/8kK/gy5D1UI90ztxVIFOaF
	 Yhc+6YQ9iG1J9xGsV8nTqtp87dLmQOe1Mpu5V3PWVo8DAMUsl9MNGSIKiKwLggFBK04aT
	 trLhS9UD3vrYyQZtbwqazXGwha0K1AMETuLCgP8lt+k3K4yqtv5PeBnR3j453gsC5Ig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UpxxsSzW;
	arc=none smtp.remote-ip=209.85.210.43
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44F53606A331
	for <linux-serial@vger.kernel.org>; Mon,  9 Nov 2026 03:51:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 44F53606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UpxxsSzW
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-7f84a55e31aso210159a34.2
        for <linux-serial@vger.kernel.org>; Sun, 08 Nov 2026 19:51:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794196272; x=1794801072; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+f3wqnZmmj2eYXbJU0o1qM9Y+NCisSMFy31udWGduqg=;
        b=UpxxsSzWafklH/6FRqKQHO/85uVUc6r67PyXXXQDNGjxEqG+RTN2EsbHNQCkh0Wdg9
         54iNmDfOeGdEo36e2bVTDGQvsFuKGMgAug+l6qmm6f8uh9ykHaBFrTaaOf1RteMkwlEX
         8g5QqVlKUCfg/08zdcDDaylSDJxKpWWYFCSSfSOxrnAtRh39tNDVyEZA/NsWM4Z3pg3D
         O8bRtHZqINuD0+5GbeUrf5lhDXh7/gQGOiLCYbkHk+PWQFN3CpkEu44dIF+mwy6ljJR1
         ZvWsbNOySj9uibyqUFj0O+CwH6d0NrEZkSW4FyH6oULoFH1eUbNgSlr5gQjPR2DlfI57
         +aPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794196272; x=1794801072;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+f3wqnZmmj2eYXbJU0o1qM9Y+NCisSMFy31udWGduqg=;
        b=XRqa0x329fJDtce8X2PNgy1Z4Lny0RGh2yqH3YTvEQk8CG+h0XzgI7ydLIJdw/nJEQ
         2p5ED5lIk7xAogX+TBC86mhdC3SA7Q908mha5oLCLHd1FG244uvq2REdA9gbr6QtJmL8
         uVqPRDzAMhW8N0/2pJnZvmCKixmbiOvmjROw2OqVChheVVc1rGIM0elHon8WW5GMMass
         KT7dyNj2WToUS8ZudYBpzXFBFpaRNX3DLOw0I6YJQBwvzLzXiODwLePS/mWlhdBxspbh
         Egc8F9jt4Bd4OxyKIdb7VBkPoNDUoDe8GqKV7tEVXMcC0FrpBsZv1aROHfOjbYmW1sMT
         3C2w==
X-Forwarded-Encrypted: i=1; AL+hErH6TgVo8VJYEtgbW0reY3q1WBepx8fPQU4LFhIkYwfqVyZJnBgFD5NGv9Fg05A8ozlw6ZO7hiZCZJjrszA=@vger.kernel.org
X-Gm-Message-State: APuU4Z8zXA8/zLP+LCRVN9i/ttdXL1S7mwWKAcxnOW5OEucD9agmH7tq
	/FfXjZFE2FPSAnWTaxlhHKE4LdTcVacqGr2AYtiF5wR2bMk2V1Cqly0i
X-Gm-Gg: AYBFou10C8luyC1opzEKU8YX1oergTzS5Il1DT70Nw3yt2eRtqE5qb27sN2KSOpyBj/
	ukPEmapCrgsUAWtaCx96wBkrTs8Nynh9PThaTEedAn3DEiN/CY4un8i0dZ1PRj8fvYEX3aG9iR6
	ik+V13FmXQ7qjLfzQPgKInbuHoJR9n21sgj6fZa3jQfawDjQx4kHtVPMosuyMGOfoAD46rvm8k0
	uWaPNHahssQ7t+Wz1nYUkOFQEFt9pkIUSvd1rhGpN/rcRDZkoWpvEUM107VzrLBbSFhXKZGsU/k
	zNeHxPqGjej6I6PmnChiAPLM+v4HipG0eMAbR58VJey3KVh6YRM/MX25/u6y/wWoX+lCQ9S1rjy
	BBqSrtf3LhijXomQvfw6ReD2y9FP7eXDV/woyNl2+bG4ZlU4CQ+f+xIbOrFfiho2x18+zK3g/Lo
	okoLWpTSDoD641HXzALMdVmzwycEQ43XlI8GqesJkAPaRWu5/0OgMl9HGkU85DEJ9ut6I4VFyIL
	yBxFUhfggKOrNfxjYjpeFqdIyS6oy+qXbw2QknrC40tHejnro+1RrJJ6LOKFOJ0zxzieP4IN+Sg
	mg5yDJWvZAtVlP7NFpB52eGZZ1YoM0RPNKp8ahp+uoJxyywdPUAKEvKfQYSih8wKj2PsTcqktyi
	TAdynsH/ALfOM4LviCjzRzIp+ctE4h4S2t74wRo6WvLihGyCwQLvyN8mKzLVhfKAENYr9NnzJqv
	9PygSd4lP2i2HT199JuOMP155Dy4yib1mKDtd+abqKatYkjciteL8G
X-Received: by 2002:a05:6830:2b22:b0:85f:49ec:c96b with SMTP id 46e09a7af769-85f507ef5eemr2216062a34.16.1794196272163;
        Sun, 08 Nov 2026 19:51:12 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-85f4fad32cdsm2800428a34.6.2026.11.08.19.51.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 19:51:11 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Sun, 08 Nov 2026 20:50:10 -0700
Subject: [PATCH v10 1/8] serial: 8250_omap: separate locked TX DMA
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
Message-Id: <20261108-submit-serial-8250-dma-cancel-v1-v10-1-e6227ddb95b1@gmail.com>
References: <20261108-submit-serial-8250-dma-cancel-v1-v10-0-e6227ddb95b1@gmail.com>
In-Reply-To: <20261108-submit-serial-8250-dma-cancel-v1-v10-0-e6227ddb95b1@gmail.com>
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
 Timur Tabi <timur@kernel.org>, Peter Ujfalusi <peter.ujfalusi@ti.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev, 
 linuxppc-dev@lists.ozlabs.org, James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.15.2

Separate the port-locked completion processing from the DMA callback
wrapper. Keep the shutdown check and locking in the callback, and retain
the existing FIFO accounting, delayed register restore and THRI handling
in the helper.

Reviewed-by: Raul E Rangel <rrangel@chromium.org>
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


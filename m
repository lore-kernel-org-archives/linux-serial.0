Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792824052;
	b=QVfkPPDpzP/sHEINbdYjFQLnUPgLoe8/1DY3yLyJBb6z96r8pxmMoNuG+mcftM/gbMW2
	 3zm3Ghm7YXW6deuM1CUCa8KkSIEDN0a5eDy4ybh+Yq2tG86kpxU+G7O89Z35ZdpMT5jCO
	 K2lgauQXJPWvdUpJyPwlxC2+3rnWurCLhA9h5woizULvdKq053e7sH3MXRcUbbWBftGxR
	 O8CYcInngmFd69/v/b6z/uC9IjTVuz5dTYHEkyiux+xloV9RLAkQk5LpzzSjQ83pV09ja
	 GEHP5S3bxUmwve48zB+JzkkBf4oKrFkI4JZMzwe+e94Y5uwPPyXa5fc0p0fikA6qyKw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792824052;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=vTCI+nDxJukp6A5kK1BpAWHpCDcT464wzBcHkx0Jj0Y=;
	b=kvq5LSXnB8VwCzhyNr9ZATjsIWwCR57jvwQVedOUqsg+SQZO8zFF3CqnWpShQayNdSTk
	 UO6s5EUh1q4k1a8xe0hqbTO2URuqsx6F2YNjk2AmpwNlStWPIK+/6mJtN0zh2ku2orCE8
	 qDy4BocvVP8WldLsM7qa9Yr3z9vIkGTJX67PU+0uZY1iTwtXsn8Gab5p1BlJJYLnY74nv
	 0RJ/sU/ifbsyUFPossMK0uIBWR2BDOztOLrvm6+kr3wh8l0w6sc2IKxGHzGJ88Xii0yy+
	 a6O4zZHFRYJfnLtTX4NWlVlrieHxsIzHLNp5FH0D0wfC/tP33RoKXd2vLBea2XUsJGA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=d30j8H1v;
	arc=none smtp.remote-ip=209.85.210.42
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40E58606A328
	for <linux-serial@vger.kernel.org>; Sat, 24 Oct 2026 06:40:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 40E58606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=d30j8H1v
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-82380b0f55dso638240a34.1
        for <linux-serial@vger.kernel.org>; Fri, 23 Oct 2026 23:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792824051; x=1793428851; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vTCI+nDxJukp6A5kK1BpAWHpCDcT464wzBcHkx0Jj0Y=;
        b=d30j8H1vjZ55HFIhncWSScYUvpCWn74ZPocxwU34Jc13PiIB34jmSMmDWqbru6ozSZ
         YC6cNohO9xmUQ7hkS16ubYaIXA7G0jHHeV3ucvVr5lmdQU1liDgkt6dhB+0wc4OJ/MWx
         45MphtLCnZMLwOxV68kW/t8IW8vSREabK7RayR46Ioj6owJsJdccWKf1AyX35ZbVIKHD
         VJJbV36UagDBkWtophmbj74WhX0r6gJze7wvMgA2RmUgwfbv1HkmX0MjGfc8rRJLs/ct
         DFmLzSR1U2TK3UDKKzNiaBt7DnEhVmhUYOQCM5ZHNu+Ueb55IxaUQyP3lWjDBFLyAP2E
         77Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792824051; x=1793428851;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vTCI+nDxJukp6A5kK1BpAWHpCDcT464wzBcHkx0Jj0Y=;
        b=wPdhEgI/Myna3Cmba7de1xwmA8NAZ1HC0O4kHl0EMaQ7XfRZQTw8iVqa8evuKtsPG6
         uyJ0geY2aIti/HWwL57zv+/sJenCTFg69XqckeVIj3KG3DeOY/z987W67+8jvmUt4RX2
         bdJzIUsY5tkDbBw4TsmlBhPtxIw7su6Y3jWuA1BjtSU2I9I2QXHWdVIzOeViYorzL8yE
         /YFjiB/AGaRTPsK4WpRcKVpP01RJHXFmufeEHpRAMYCTLG6HJTQx1vM+Yw9xhY2wRvGG
         alczLCv7M+iqKASsOAfUfEUGBLQjiXN85bXnJBkac/eeSi9xbd40911gglx0qWle6RaH
         /jyA==
X-Forwarded-Encrypted: i=1; AKwUvBxasv438lF8MY9tkBiudkE90TnEMzeAQ4+SAL/wKbsJlEH4SCkkWR7YcH0qxZ/MEH5IeHXO3QWElxswnvU=@vger.kernel.org
X-Gm-Message-State: AFq9FYItGLOn8Qa2OAwyjSks+donnpIP4/Q3igkEWv/fjJNaW26Ibanh
	K7OSorlG5poIooh+JaQdCnPxz7HIRG4Bzpj3DRc6y0Q+9BQIQqrdq8rC
X-Gm-Gg: AYBFou2XmBosPnc/rbH8DRQOb0tRzX6mPcSmzySPOyNtr4G/hLQ//cUhpDYMveIwrId
	tNkwhIAKFBq2MO9Io1NHtuH+/1HR+n+8JYxTV+EU0KgYiAtsDoFnFFDJXrqCNX9nvaK1CWxNu2B
	ImKH0+RUW4FwqoGx8pSDCp8DAIz6RlgkgkuCnb5BZa/cre8V2ipG6+NXhSozlTNUDazw7S4JePA
	sLsfuDEsui0AmNwVVa1/wMw0yIxKMXNmQzjCM/6BVPkblUSwKFROM7IPUUJqq8k4ggU4oEdbD20
	S0R1VVP0JwqxovQ/3ck8g6aT0oaJpoQHaHil6Lts5dAkFnvHn/3+Op3fi8BclKQtlnYmvwpFLvK
	7nj8kE3Rd4FAe2wgYH9eDvI896C8sP0aRUSrqhnZTT39S+QdoZXw9zS3XEGbKGtteL+Uv4Jmrf8
	FPoYWcNviswlLImA+7yjz0/53/qnwrnpQTlSWwt8EyQZZnA5+4I5vYYzuBS42+AM+4cqfa4Ag9z
	o+AXoRpyjGeNbUZCsetIXpXrKut0vPBF702xmvklDWWFM7MxF1GyNHLGh4GCa/K4ABgPuoZYHlr
	GgiUx9inFx1zUtuv+SYX1wWUMvxL0F279No1B2UqrwfiDFzGXcCbBXvTAojcI9JNgbiUhUTU9Zy
	+sLjI0tardg4YDMER84SFDkGE89Jv1tK9PhxAZWPSRYt6GYx2g9wlken9tdJBNP2Ho+duZL6yHc
	XZJUWasKQg1w8cOw5xdsKklnQ=
X-Received: by 2002:a05:6808:4fe3:b0:4f0:1f76:8ca0 with SMTP id 5614622812f47-55c003e9dbbmr788058b6e.56.1792824051160;
        Fri, 23 Oct 2026 23:40:51 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-55c0429c56asm864633b6e.9.2026.10.23.23.40.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 23:40:50 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Sat, 24 Oct 2026 00:40:40 -0600
Subject: [PATCH v5 1/5] serial: 8250_omap: separate locked TX DMA
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
Message-Id: <20261024-submit-serial-8250-dma-cancel-v1-v5-1-9e52968928d2@gmail.com>
References: <20261024-submit-serial-8250-dma-cancel-v1-v5-0-9e52968928d2@gmail.com>
In-Reply-To: <20261024-submit-serial-8250-dma-cancel-v1-v5-0-9e52968928d2@gmail.com>
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


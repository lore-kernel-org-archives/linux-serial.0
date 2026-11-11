Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794435396;
	b=VfLc3euXAXbxLS4IpmfKP5+y89GqNF7rXeZj6niiuLmxxlx2oM7MsXxNIJvkQmRbpYyG
	 CxXfhYSpQdaWDuzOB1uoblqqXQnKi52iQLq5WJMXrNHmV8RWx8/tEtIKcH7TxBLfogJR/
	 oE0plLa06jsH0AwGPI5XEqln4/usF/qcbdiJy+79takW0gmiZBju8POG+1wQ7Uc/1QnTR
	 Fi+ygDkzpBMkftrhpxM+WJ/TbXebCHdhj9tp/VPRgcuN0XBzGH8q8ltdd7dTCMlB4Nvro
	 8OAM53Tj6YMi61IU/Uxe1ekOzzOPjuqo/Vfmf+d8oN3WwsQWFCynPMLBZ92cfkCOdlQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794435396;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=+f3wqnZmmj2eYXbJU0o1qM9Y+NCisSMFy31udWGduqg=;
	b=lomyJ4/yJHAuuwYeu4yRG30A60wSi1lX99CcHmRW0+8w7xmaXX3U5EcRjsOpUgddqwtz
	 jvaUSOemufAsRnl9JokomkReT1BiQ+exZfOnj7bCA/Ho9XiOM7lqgVM83AU8+IZiE+IZz
	 u6OrnV8Ey/dbMbwksR2mEmZNVdb8/oryt6qvfxdHSFpv33lKI+gLhT2bGzbmsCTeL9Qp0
	 irdfHIWGE+XU/DH5jZ1Wj1rmqZOPJkc5WBkYTCp13RXb9d0wOKJ5xCtmmE+v4iAkNkP06
	 BSze0z+UuYH8huoIZS+OhMpK4EGuS7r4Rgk46uxxls3ZgqgdyZs9PRz6DgoIwJtfbOg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=q3RUoUnm;
	arc=none smtp.remote-ip=209.85.210.45
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13559606A31C
	for <linux-serial@vger.kernel.org>; Wed, 11 Nov 2026 22:16:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 13559606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=q3RUoUnm
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-8241a56cd70so2322437a34.3
        for <linux-serial@vger.kernel.org>; Wed, 11 Nov 2026 14:16:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794435395; x=1795040195; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+f3wqnZmmj2eYXbJU0o1qM9Y+NCisSMFy31udWGduqg=;
        b=q3RUoUnmUrOcrmBlLrewDC4eNtcCHLFQeOdF1PXkvbqR6RDdauMUAcWfloph6cSa/7
         W3Ug/pUsGedMZk9sDD6ThjqVwaVSsLqKiN8WojUj5gpIq62LdBxD76tMyZkDi0B24NjH
         0tA+vrPNs/i7rlP5B1irl/hXMUOj9r5LPFFLPWDdsm1SRgWbI70GkPED4BPkRI9pDLt5
         QlO7lBAOCK1r/p1G82S5aon771wcaJOTBK/GOZsffLpA2zzLZzXE0pYIxbfNeYWoJ2ad
         hBVMITvTi5eGjYruugMGIUmQNWkZNIvZl+nxuxE4UNkZ/Mk4MHN1rIsmDcKZWoFkhD0w
         adjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794435395; x=1795040195;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+f3wqnZmmj2eYXbJU0o1qM9Y+NCisSMFy31udWGduqg=;
        b=de8oh/5SrCuG8slKgpQhXpPJ42Oo2kSwGth9CrFT2n0JBMyXIn+WNAHB8rUhxwOuTX
         2HZsQtTb5WZgUt0MF+18QIIYhUaVoV1TEmDQ+deDK8QICxvBkGigutccG5HA8ap9P0tR
         tu2COpIV2TX/jjUWtgzDyItLgVwxfGyli8xr0y6w8e9xH0CxPHZmNjSj2yG5+sTmTHvq
         te6vviv64Nn+gXXlIfVsn6rzEWTinBsiuE+rWA0/B6gVFOS1QgP/hqlNFrdL9XDrxg2Q
         J99rBCxf84Sn8eq/uN3qcsTAaXkOIrZUIhwyfOkgqDa5p/oWvmLAyGi3wdwOZXsn7BFy
         ofjA==
X-Forwarded-Encrypted: i=1; AL+hErHDX4yNdFerSFU+dMgI5VN+JWmizxXxfA/AkOOlvzCSJVUJDUaxTejfrTi97HegUpeH/m1wPEJS9u//WlE=@vger.kernel.org
X-Gm-Message-State: APuU4Z8Ua8jV7fKb6Kz9ZP1UGjlIeR6kRmCjyTq9WGop+3LLtGAPOe80
	r74ryQUIFnwUn9KiSY+G1I/NK12iAHxzBmbS4CirOQxs1A113l8cB8Pa
X-Gm-Gg: AYBFou1cvtUhpRqtkE1ulzyTxFbxi07TivG7JtMEO/qOi/1QfWbgsjmUTw9F4eRcrvS
	XP+ZkCGUJ/3v7MHYbTiMu/T8JCiuyqgdZmqz5jnoFE5+ZbBb/kvVROtMoX/sQS2tGKDoswhPa/j
	6NLeL4w9QJc7Z11w6S0njacfCQNcpM1nkKdYKZ/rUv+PQQwbtzJChuvLT2R9iZcF7oTWeHodoVB
	3ELOQOwNBT20pcXYNfccKR5ZNMrCPgSMCrd9mbx5gMEhw08Mdi9gaeYH9bkjzLlMjoZLL8Rg/ME
	9EP5h8CgTHOwOy3AJfLZgDzg8BY5WnYkfqC41fPMHHoXSsInQmhAos99b9E7qj7/q+Qp+KgMGuk
	MajZCkzNMr06W6Jeu9XFq5ExI0MvAg1/byXvJOgnJ+qqjswLnDVPKt1jXQWv8HO+iasebdne0Vm
	Kn7cwfRLO7xgh3eATh5E4j1Pe9BYsrRl4m/AN7DVsBx5W2jYs2NDB9X++l2qDukIo5qHPb1kORx
	BJ0LEWJNtJlEU6ar8DmR+rDHCFTyPqaZ3yD6mEkEQgOBkoEsagx49+67LeukHaNrIq5TeRpzl2j
	bfi6x7wi06547TnnEnMlHfCNZKJvzMEF4k6cpv5JZsj0PYk9IkQEcwdcZBHOPD5JgUr25GDHYoH
	gTJ1hQrhh9Zalkrp1vX7Po0d5nRM12Yh3jpLUsmCrS5Q66OXziN7jI+5a+vfMxOgnd7RrE0YTUA
	0DGnsxZIp2ZuhSFYUS0vYf4sZXfIONtE9HQeqmD7qceME3w6opl9EtakxwNUYHrDP/pAMxSqd6
X-Received: by 2002:a05:6808:e8d:b0:4f1:7c39:8a7c with SMTP id 5614622812f47-56b982286b5mr3254065b6e.62.1794435394806;
        Wed, 11 Nov 2026 14:16:34 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-56902ae38ecsm5917498b6e.1.2026.11.11.14.16.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 14:16:34 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Wed, 11 Nov 2026 15:16:26 -0700
Subject: [PATCH v12 1/8] serial: 8250_omap: separate locked TX DMA
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
Message-Id: <20261111-submit-serial-8250-dma-cancel-v1-v12-1-9e3456bc2555@gmail.com>
References: <20261111-submit-serial-8250-dma-cancel-v1-v12-0-9e3456bc2555@gmail.com>
In-Reply-To: <20261111-submit-serial-8250-dma-cancel-v1-v12-0-9e3456bc2555@gmail.com>
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


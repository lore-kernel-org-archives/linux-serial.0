Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794563610;
	b=iwk6LZ9emNwjrnG1nEc4Xe6YXipswoL1s+IdUFtor3nLQwv3SytAQCquRJVGmOco9AtR
	 8ve12IfUo9JIAHjaXO0EDqDwc8gf63EcrUCWOuVhqixokz0gJhHMjHZyjDTut0f8Rf0VD
	 rdLrc1P02u2tEbFD97GE5oFKyzmMxxQTosLTblZM4rz/TKADW7qQ6JjKkli3rntwxmS/2
	 grUvM8cS5OzB12S3rfC0JxUnIYPPXN72pxQPHzhaPR/bsSg/NY9Ae8+xvQVls72vMxU6y
	 kS5W8KisUrv+iq3SyYQ9ff5q6xxZnuNaRKtNWbkURD2PmY7s1yYTaNNsh4iupZ6gnWA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794563610;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=RLeox9UCna+JAgQJPZ2ik+qyzedm8mitCUwWv3Rb40k=;
	b=lNHT9Ex3YHkhAR4EpfWz122FER2zKVblVsiFCIVwAzI8wcJb8zoeG2C0X7bxJexp8XEo
	 L4yfDOzgxzitAsf1kkjSqDyappUCYGdTTJahkZwdBijVzRSPHDKhqXYkHG3Uz2lokkVt9
	 dpcjmvXpGDamJyJJlUL5YA8eSF8+M5iaBaz89W4QIvieFSoDvoXUTn6L1n3RIQJJYEFOg
	 su9glyHkjbUWKoaJOeVQCwGBwN4bskU08HePESR6D1bvBd+aFeKWkYF94ICe3YysLSdD/
	 hqJkiRptIZtJebKlto6uacIxa8BDE6rCZ3S5Khdl1ld4anNoIjKxSwZLAqpRBVtNLMw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YvqDVe0B;
	arc=none smtp.remote-ip=209.85.167.180
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4317E606A898
	for <linux-serial@vger.kernel.org>; Fri, 13 Nov 2026 09:53:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4317E606A898
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YvqDVe0B
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-53a448f86e0so1043965b6e.1
        for <linux-serial@vger.kernel.org>; Fri, 13 Nov 2026 01:53:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794563608; x=1795168408; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RLeox9UCna+JAgQJPZ2ik+qyzedm8mitCUwWv3Rb40k=;
        b=YvqDVe0BepA/KN2PTPLa3GPPWWe8UWajFMtgcKg9zinvkflwyFAAOKaoYWMv1e3esM
         J4GaziCjCjx/RjAwbBZjMhiZjMpFsys/8fYU4HtK48N7sPYoOhM2ylQ7hdWxMJwY0e2a
         1V6yb0dbq4JoFvxTb1l/naAY0uV/hfIYYpULsUzYjDbPo9izwaomIABtRCRBy1TFpdDu
         bVoXadFnaegEgit2pN5WWKM/4NJsNIKhyOqKwEj1KFxZ/L98laucQz5YTTmFsTI+7lmA
         BqLNZ2vD/UWPCWZaNRw8Th+E9t01SyDhTAaD3Gs9nIoaoO+wiswOZ4eogXaQRla2DzzS
         GK5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794563608; x=1795168408;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RLeox9UCna+JAgQJPZ2ik+qyzedm8mitCUwWv3Rb40k=;
        b=iTn6ta1RRzAKH486h+T2WLr+ah7CJWC6cwJHP6n7Ah7NCKeCamGGAct7CcJDl9aaH4
         GlcnpPoVuaFIPwII/HooLgtDxNEedkZoNTwM86Ioph5at9G+1Ug8bbDpVgt0XQqJPGxG
         3It8wmlkdTpT+2IwLJl63fL1lQCDYsu4+FYxPhyJ1xqTs3vPN75ZcO585q9ubIGRkAHY
         n7jzYylx8iBFmAxHAuoO4pSaq73Mgof0oftiVGmFV/EFz+LG/B0R4UUF1wf+Ak2b8iwU
         3dhACRuKrKZVgEkvvwAe2ayX8FPUDJi8js80fhph9nll8/Js0L1dSVkcY8sHr+7DMi1W
         95zw==
X-Forwarded-Encrypted: i=1; AL+hErHU6D2mJ/axsQ3Gd48mIs+3JGf/tXJOJO9QhwXZLMOE4EGm/Z6O+85tCW+B1gg2r/0EEq7+wRLOkCDKDrs=@vger.kernel.org
X-Gm-Message-State: APuU4Z9bPh7e1/tChHFPTCOXg50qEhkSxRi7OU7gJPCEcOApCJgqA9gs
	lC500xH+6TWSqJPdMTO6bz5HDnxSxE2oWpx4PGcec+vHMW12JnR01ULl
X-Gm-Gg: AYBFou1uf5TXtxFPGBVlZZSTeUlJAXoZ1Pn66GgnBBL0yYhq2Jz4NNWyMQiYvo9fO6R
	Jf3/qB/YHb6ef1M7NIKCC6xigePJ71BdmF9LnuHydjY7YXS1uMrbzlArMrhYH5jZz9xLUk+Efcx
	9sXUYwvu2rmQeDkVlF2xav6ZZ/cuVBUiANKNrr6WhhyoypgqZIRL1O+x1mjc2QpWxgpAHdxdbyH
	0/8pGidkyblLAl8hJJ9smjQco7PJVTmL3ULUnffUQom+UuiPE81tbFoNnQdGQLWJAJmWZhYkGRB
	Z5LNYjRnuEDvCafMpBRsY/OghmbIXXH3bXl9mkxSUnm+thO9ft0C0MbfNAT5UM8g9mWMPkuwVBC
	BmmOgjauMMwt8rkziXwJTFoodMiWWCazpEcm1oB+TVy/TTAn3SFVlhyPrK0/3tm8wR8qB/LsGCU
	YSJEFFoiosP5Olx6KWWksxoKkLe3htnOnlX4DMsOF3kH/KYCLD4PkbceRuCzwQTtrJkyGClgMRC
	eQdGuqhYvF40U425FOvjTMnhiRi/AejpmR4IcCyDC7POLn9SFY0C/pYiAlZZnQ429sd+kDRWDV/
	SgM8pmVcuu3wjZEmR7ghpgzN7QxhXA475JCjZEf9f+m5kiUjxe4fCnDCH/vKx3eWybDxfWQ1har
	emb6IsKKA/h/tXZ99e6WvrWUAlscLUadk4zod3f4bfivKOiwjWPLWSBRPGRj9a7DbmsDhgyfJ8n
	iaktjl4wss6u+lhErg3ghJoit5SBwyWKlTa7sT+GbnoIuN4TOFcX4=
X-Received: by 2002:a05:6808:2220:b0:4b3:7549:d3c0 with SMTP id 5614622812f47-56e648e778dmr1355898b6e.18.1794563608017;
        Fri, 13 Nov 2026 01:53:28 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-56e7094aafcsm1609523b6e.12.2026.11.13.01.53.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 01:53:27 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Fri, 13 Nov 2026 02:53:16 -0700
Subject: [PATCH v13 3/8] serial: 8250_omap: serialize RX DMA completion and
 flushing
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
Message-Id: <20261113-submit-serial-8250-dma-cancel-v1-v13-3-b857f2617ece@gmail.com>
References: <20261113-submit-serial-8250-dma-cancel-v1-v13-0-b857f2617ece@gmail.com>
In-Reply-To: <20261113-submit-serial-8250-dma-cancel-v1-v13-0-b857f2617ece@gmail.com>
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

Moving RX DMA locking out of __dma_rx_do_complete() left the DMA
completion callback calling it without rx_dma_lock. Shutdown and runtime
suspend flush RX under rx_dma_lock but without the port lock, allowing
these paths to overlap the callback's buffer accounting and flip-buffer
insertion. RX submission and UART interrupt handling also require the
port lock.

Take rx_dma_lock inside the port lock in the completion callback. Hold
the port lock around the shutdown and runtime-suspend flushes, matching
the existing interrupt-path lock order. Assert both locks in the common
completion helper and the port lock at the flush entry point.

Fixes: 789898416749 ("serial: 8250: 8250_omap: Move locking out from __dma_rx_do_complete()")
Reviewed-by: Raul E Rangel <rrangel@chromium.org>
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/tty/serial/8250/8250_omap.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
index b6f108d34854..5e114dd8f9bf 100644
--- a/drivers/tty/serial/8250/8250_omap.c
+++ b/drivers/tty/serial/8250/8250_omap.c
@@ -771,8 +771,10 @@ static void omap_8250_shutdown(struct uart_port *port)
 	guard(serial8250_rpm)(up);
 
 	flush_work(&priv->qos_work);
-	if (up->dma)
+	if (up->dma) {
+		guard(uart_port_lock_irq)(port);
 		omap_8250_rx_dma_flush(up);
+	}
 
 	serial_out(up, UART_OMAP_WER, 0);
 	if (priv->habit & UART_HAS_EFR2)
@@ -898,7 +900,7 @@ static int omap8250_rs485_config(struct uart_port *port,
 #ifdef CONFIG_SERIAL_8250_DMA
 static int omap_8250_rx_dma(struct uart_8250_port *p);
 
-/* Must be called while priv->rx_dma_lock is held */
+/* Context: port lock and priv->rx_dma_lock held. */
 static void __dma_rx_do_complete(struct uart_8250_port *p)
 {
 	struct uart_8250_dma    *dma = p->dma;
@@ -911,6 +913,9 @@ static void __dma_rx_do_complete(struct uart_8250_port *p)
 	int			ret;
 	u32			reg;
 
+	lockdep_assert_held_once(&p->port.lock);
+	lockdep_assert_held_once(&priv->rx_dma_lock);
+
 	if (!dma->rx_running)
 		goto out;
 
@@ -977,7 +982,8 @@ static void __dma_rx_complete(void *param)
 	if (dmaengine_tx_status(dma->rxchan, dma->rx_cookie, &state) != DMA_COMPLETE)
 		return;
 
-	__dma_rx_do_complete(p);
+	scoped_guard(spinlock, &priv->rx_dma_lock)
+		__dma_rx_do_complete(p);
 	if (priv->throttled)
 		return;
 
@@ -995,6 +1001,8 @@ static void omap_8250_rx_dma_flush(struct uart_8250_port *p)
 	unsigned long		flags;
 	int ret;
 
+	lockdep_assert_held_once(&p->port.lock);
+
 	spin_lock_irqsave(&priv->rx_dma_lock, flags);
 
 	if (!dma->rx_running) {
@@ -1811,8 +1819,10 @@ static int omap8250_runtime_suspend(struct device *dev)
 		}
 	}
 
-	if (up && up->dma && up->dma->rxchan)
+	if (up && up->dma && up->dma->rxchan) {
+		guard(uart_port_lock_irqsave)(&up->port);
 		omap_8250_rx_dma_flush(up);
+	}
 
 	priv->latency = PM_QOS_CPU_LATENCY_DEFAULT_VALUE;
 	schedule_work(&priv->qos_work);

-- 
2.53.0


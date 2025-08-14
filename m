Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01B9F27701C;
	Thu, 14 Aug 2025 07:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755156318; cv=none; b=mP5TiUkaryXXWG9Ke8dB+x1j6miBnxn9V5OuW627a5/DimIKdDPz3PX3i4TZscXzbaW+s9EShq5Bw/EYdEwMmdfptDgb9M+774kgVNomRTKcO5V2UkCNJbErtGAplVZ0CwuQWnvJQ4iYJ35Bq5x5v0Mnh/XwdW/0VtZuAoepV9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755156318; c=relaxed/simple;
	bh=qMJKQ8KFbQ1Yr99KHpbe0q7I6w90iEVuwbGYK6zXnV8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pycySnqeUFqfImY2TLy5oGIYu1O+JNg86z33BzSonnxbj/17SXugeVIuoYrypjNHTR15Z62fQ9NsYnP2wrZlskpNAxGKcR3l+wNViJyeg80OlWu2xPZCWZ2A6VNr50pcfn34oa13fjvMm3ib5zCqKXMlo/ndTCaNBNgXu5cCEAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WdCp06fb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WdCp06fb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5CC9C4CEEF;
	Thu, 14 Aug 2025 07:25:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755156317;
	bh=qMJKQ8KFbQ1Yr99KHpbe0q7I6w90iEVuwbGYK6zXnV8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WdCp06fbgXYMbkmAuX1Du/0jC184GYoZQKQejQFShe8POxZBfSPiMLhWO6/473kLJ
	 UE2HeUkX/gIS2ns0EzwcXzmEaUIOdOajhd0CZcfur98siSkFEKtaZDEd/0oCRazKKe
	 Fdw5nfwzTuk0q9USuhi+jb8qojbsdhvlYGFJQ3FMVz1Cf57hoH+XodAH8rpp4nQD+M
	 by5lr9Z31esc4H6TMZZBBuGFeI4of/W6oi0rfj5ViorGtfYjaBjRJGawrHArKg/vvj
	 gsv6uaV986s0GjeYcUHSQ6hvTnX+l4+lfY69Y2jr3i5vnSi2yzIPqPXvDa0akBVK8/
	 ImpQAjSvaMcDQ==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 12/16] serial: 8250_omap: use guard()s
Date: Thu, 14 Aug 2025 09:24:52 +0200
Message-ID: <20250814072456.182853-13-jirislaby@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250814072456.182853-1-jirislaby@kernel.org>
References: <20250814072456.182853-1-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Having all the new guards, use them in the 8250_omap code. This improves
readability, makes error handling easier, and marks locked portions of
code explicit.

For this to work, UART_CAP_RPM has to be set to up->capabilities a bit
earlier.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/tty/serial/8250/8250_omap.c | 108 ++++++++++------------------
 1 file changed, 37 insertions(+), 71 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
index ba03955fdc6e..bb23afdd63f2 100644
--- a/drivers/tty/serial/8250/8250_omap.c
+++ b/drivers/tty/serial/8250/8250_omap.c
@@ -393,8 +393,8 @@ static void omap_8250_set_termios_atomic(struct uart_port *port, struct ktermios
 	 * Ok, we're now changing the port state. Do it with
 	 * interrupts disabled.
 	 */
-	pm_runtime_get_sync(port->dev);
-	uart_port_lock_irq(port);
+	guard(serial8250_rpm)(up);
+	guard(uart_port_lock_irq)(port);
 
 	/*
 	 * Update the per-port timeout.
@@ -502,10 +502,6 @@ static void omap_8250_set_termios_atomic(struct uart_port *port, struct ktermios
 		}
 	}
 	omap8250_restore_regs(up);
-
-	uart_port_unlock_irq(&up->port);
-	pm_runtime_mark_last_busy(port->dev);
-	pm_runtime_put_autosuspend(port->dev);
 }
 
 /*
@@ -546,10 +542,9 @@ static void omap_8250_pm(struct uart_port *port, unsigned int state,
 	struct uart_8250_port *up = up_to_u8250p(port);
 	u8 efr;
 
-	pm_runtime_get_sync(port->dev);
-
+	guard(serial8250_rpm)(up);
 	/* Synchronize UART_IER access against the console. */
-	uart_port_lock_irq(port);
+	guard(uart_port_lock_irq)(port);
 
 	serial_out(up, UART_LCR, UART_LCR_CONF_MODE_B);
 	efr = serial_in(up, UART_EFR);
@@ -560,11 +555,6 @@ static void omap_8250_pm(struct uart_port *port, unsigned int state,
 	serial_out(up, UART_LCR, UART_LCR_CONF_MODE_B);
 	serial_out(up, UART_EFR, efr);
 	serial_out(up, UART_LCR, 0);
-
-	uart_port_unlock_irq(port);
-
-	pm_runtime_mark_last_busy(port->dev);
-	pm_runtime_put_autosuspend(port->dev);
 }
 
 static void omap_serial_fill_features_erratas(struct uart_8250_port *up,
@@ -736,7 +726,11 @@ static int omap_8250_startup(struct uart_port *port)
 			return ret;
 	}
 
-	pm_runtime_get_sync(port->dev);
+#ifdef CONFIG_PM
+	up->capabilities |= UART_CAP_RPM;
+#endif
+
+	guard(serial8250_rpm)(up);
 
 	serial_out(up, UART_FCR, UART_FCR_CLEAR_RCVR | UART_FCR_CLEAR_XMIT);
 
@@ -759,14 +753,10 @@ static int omap_8250_startup(struct uart_port *port)
 	}
 
 	/* Synchronize UART_IER access against the console. */
-	uart_port_lock_irq(port);
-	up->ier = UART_IER_RLSI | UART_IER_RDI;
-	serial_out(up, UART_IER, up->ier);
-	uart_port_unlock_irq(port);
-
-#ifdef CONFIG_PM
-	up->capabilities |= UART_CAP_RPM;
-#endif
+	scoped_guard(uart_port_lock_irq, port) {
+		up->ier = UART_IER_RLSI | UART_IER_RDI;
+		serial_out(up, UART_IER, up->ier);
+	}
 
 	/* Enable module level wake up */
 	priv->wer = OMAP_UART_WER_MOD_WKUP;
@@ -775,15 +765,12 @@ static int omap_8250_startup(struct uart_port *port)
 	serial_out(up, UART_OMAP_WER, priv->wer);
 
 	if (up->dma && !(priv->habit & UART_HAS_EFR2)) {
-		uart_port_lock_irq(port);
+		guard(uart_port_lock_irq)(port);
 		up->dma->rx_dma(up);
-		uart_port_unlock_irq(port);
 	}
 
 	enable_irq(port->irq);
 
-	pm_runtime_mark_last_busy(port->dev);
-	pm_runtime_put_autosuspend(port->dev);
 	return 0;
 }
 
@@ -792,7 +779,7 @@ static void omap_8250_shutdown(struct uart_port *port)
 	struct uart_8250_port *up = up_to_u8250p(port);
 	struct omap8250_priv *priv = port->private_data;
 
-	pm_runtime_get_sync(port->dev);
+	guard(serial8250_rpm)(up);
 
 	flush_work(&priv->qos_work);
 	if (up->dma)
@@ -803,10 +790,11 @@ static void omap_8250_shutdown(struct uart_port *port)
 		serial_out(up, UART_OMAP_EFR2, 0x0);
 
 	/* Synchronize UART_IER access against the console. */
-	uart_port_lock_irq(port);
-	up->ier = 0;
-	serial_out(up, UART_IER, 0);
-	uart_port_unlock_irq(port);
+	scoped_guard(uart_port_lock_irq, port) {
+		up->ier = 0;
+		serial_out(up, UART_IER, 0);
+	}
+
 	disable_irq_nosync(port->irq);
 	dev_pm_clear_wake_irq(port->dev);
 
@@ -819,46 +807,33 @@ static void omap_8250_shutdown(struct uart_port *port)
 	if (up->lcr & UART_LCR_SBC)
 		serial_out(up, UART_LCR, up->lcr & ~UART_LCR_SBC);
 	serial_out(up, UART_FCR, UART_FCR_CLEAR_RCVR | UART_FCR_CLEAR_XMIT);
-
-	pm_runtime_mark_last_busy(port->dev);
-	pm_runtime_put_autosuspend(port->dev);
 }
 
 static void omap_8250_throttle(struct uart_port *port)
 {
 	struct omap8250_priv *priv = port->private_data;
-	unsigned long flags;
 
-	pm_runtime_get_sync(port->dev);
+	guard(serial8250_rpm)(up_to_u8250p(port));
+	guard(uart_port_lock_irqsave)(port);
 
-	uart_port_lock_irqsave(port, &flags);
 	port->ops->stop_rx(port);
 	priv->throttled = true;
-	uart_port_unlock_irqrestore(port, flags);
-
-	pm_runtime_mark_last_busy(port->dev);
-	pm_runtime_put_autosuspend(port->dev);
 }
 
 static void omap_8250_unthrottle(struct uart_port *port)
 {
 	struct omap8250_priv *priv = port->private_data;
 	struct uart_8250_port *up = up_to_u8250p(port);
-	unsigned long flags;
-
-	pm_runtime_get_sync(port->dev);
 
+	guard(serial8250_rpm)(up);
 	/* Synchronize UART_IER access against the console. */
-	uart_port_lock_irqsave(port, &flags);
+	guard(uart_port_lock_irqsave)(port);
+
 	priv->throttled = false;
 	if (up->dma)
 		up->dma->rx_dma(up);
 	up->ier |= UART_IER_RLSI | UART_IER_RDI;
 	serial_out(up, UART_IER, up->ier);
-	uart_port_unlock_irqrestore(port, flags);
-
-	pm_runtime_mark_last_busy(port->dev);
-	pm_runtime_put_autosuspend(port->dev);
 }
 
 static int omap8250_rs485_config(struct uart_port *port,
@@ -996,30 +971,26 @@ static void __dma_rx_complete(void *param)
 	struct omap8250_priv *priv = p->port.private_data;
 	struct uart_8250_dma *dma = p->dma;
 	struct dma_tx_state     state;
-	unsigned long flags;
 
 	/* Synchronize UART_IER access against the console. */
-	uart_port_lock_irqsave(&p->port, &flags);
+	guard(uart_port_lock_irqsave)(&p->port);
 
 	/*
 	 * If the tx status is not DMA_COMPLETE, then this is a delayed
 	 * completion callback. A previous RX timeout flush would have
 	 * already pushed the data, so exit.
 	 */
-	if (dmaengine_tx_status(dma->rxchan, dma->rx_cookie, &state) !=
-			DMA_COMPLETE) {
-		uart_port_unlock_irqrestore(&p->port, flags);
+	if (dmaengine_tx_status(dma->rxchan, dma->rx_cookie, &state) != DMA_COMPLETE)
 		return;
-	}
+
 	__dma_rx_do_complete(p);
-	if (!priv->throttled) {
-		p->ier |= UART_IER_RLSI | UART_IER_RDI;
-		serial_out(p, UART_IER, p->ier);
-		if (!(priv->habit & UART_HAS_EFR2))
-			omap_8250_rx_dma(p);
-	}
+	if (priv->throttled)
+		return;
 
-	uart_port_unlock_irqrestore(&p->port, flags);
+	p->ier |= UART_IER_RLSI | UART_IER_RDI;
+	serial_out(p, UART_IER, p->ier);
+	if (!(priv->habit & UART_HAS_EFR2))
+		omap_8250_rx_dma(p);
 }
 
 static void omap_8250_rx_dma_flush(struct uart_8250_port *p)
@@ -1117,14 +1088,13 @@ static void omap_8250_dma_tx_complete(void *param)
 	struct uart_8250_port	*p = param;
 	struct uart_8250_dma	*dma = p->dma;
 	struct tty_port		*tport = &p->port.state->port;
-	unsigned long		flags;
 	bool			en_thri = false;
 	struct omap8250_priv	*priv = p->port.private_data;
 
 	dma_sync_single_for_cpu(dma->txchan->device->dev, dma->tx_addr,
 				UART_XMIT_SIZE, DMA_TO_DEVICE);
 
-	uart_port_lock_irqsave(&p->port, &flags);
+	guard(uart_port_lock_irqsave)(&p->port);
 
 	dma->tx_running = 0;
 
@@ -1152,8 +1122,6 @@ static void omap_8250_dma_tx_complete(void *param)
 		dma->tx_err = 1;
 		serial8250_set_THRI(p);
 	}
-
-	uart_port_unlock_irqrestore(&p->port, flags);
 }
 
 static int omap_8250_tx_dma(struct uart_8250_port *p)
@@ -1804,15 +1772,13 @@ static int omap8250_runtime_resume(struct device *dev)
 		up = serial8250_get_port(priv->line);
 
 	if (up && omap8250_lost_context(up)) {
-		uart_port_lock_irq(&up->port);
+		guard(uart_port_lock_irq)(&up->port);
 		omap8250_restore_regs(up);
-		uart_port_unlock_irq(&up->port);
 	}
 
 	if (up && up->dma && up->dma->rxchan && !(priv->habit & UART_HAS_EFR2)) {
-		uart_port_lock_irq(&up->port);
+		guard(uart_port_lock_irq)(&up->port);
 		omap_8250_rx_dma(up);
-		uart_port_unlock_irq(&up->port);
 	}
 
 	atomic_set(&priv->active, 1);
-- 
2.50.1


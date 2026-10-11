Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C64E36B914;
	Sun, 11 Oct 2026 20:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791750205; cv=none; b=Yx7XeFZ0otKHqbtZ38rTvRXZD2t34/iWBBXmsmBuIMfqCCWvY3SvIGfOmxPJGBnHSVA/1Lay+I/8oVUYeCRwbpdGAfeo6D1Zldr3kPoat6vkiYQJMNt4Gvl5f4F/nmGiTFF7jsBDYAJANkog1muyMmzO8U3mnvqMI5aA/ysqzgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791750205; c=relaxed/simple;
	bh=IXbpbYsM4yTI7/V1XpKbjW34JLq3mwOafArU9eb6RxA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ki5CQGo3GSSyeZRILb5u8ta5rjvsNyy9D9beI0mvUq7uwPfqvo218F85kVn5I+ExHolkCdIiBG/M2kliFaXfZpVss57aHPpWpDIkCOSVSe7iXaGehgizvqqh7s19Cnx+MJfbLoAbJT223RLMhN7k3/eFo6kgoIZ7wOc/vQZq1ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=bFklZ2HR; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="bFklZ2HR"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2E0F9A1578;
	Sun, 11 Oct 2026 22:23:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1791750199; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=L8wO+ZXSMap56iObpai0+Exwf/sjcWuAHtMZXUoD+TI=;
	b=bFklZ2HRoMu3yVIRQlWh1Q+YP0xqvYxAozUlPdp+UsTJAfjd0cZtIx354O5vBueej0npem
	BBkMq8hvyAiCSND8I8XvpOGQ/S58pjTzw3pfnwRf69dpIoJg5H9FdzKrztYVMUQqo6aA95
	g9oHR23AmCV4mu2P+8kmQKKFVjbTrnJGRUXhG4kyHTQO9JaxomrQ31DNK+jNr6RJePlHv/
	q4x6SOV0jdsKNAOIX5tfT5BFWtY2zcIP1gZPSefOD5HuVhhYqmYLyr0tBKdqriwnKW3Ua5
	XHmcG4P/o4jaH2a6Luqtp6m177x9yL4iaO1sDDhF0jpMDxYFizpYf0C82bPFKg==
From: Nicolai Buchwitz <nb@tipi-net.de>
Date: Sun, 11 Oct 2026 22:23:07 +0200
Subject: [PATCH] serial: amba-pl011: drive the bus during break in RS485
 mode
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261011-devel-pl011-rs485-break-v1-1-62ff402378c6@tipi-net.de>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMyw6CMBCF4Vchs3aStuIFX4W4aMtRRwmSGSUmh
 He36O58i/PPZFCB0amaSTGJyXMo8JuK8i0OV7B0xRRc2HvnPXeY0PPYr1utPu44KeKDE/I2NYc
 m1sFReY+Ki3x+5fb8t73THfm15mhZvv0GbGR7AAAA
X-Change-ID: 20261011-devel-pl011-rs485-break-bec3b979a420
To: Russell King <linux@armlinux.org.uk>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>
Cc: Lino Sanfilippo <LinoSanfilippo@gmx.de>, linux-kernel@vger.kernel.org, 
 linux-serial@vger.kernel.org, Nicolai Buchwitz <nb@tipi-net.de>
X-Mailer: b4 0.16.0
X-Last-TLS-Session-Version: TLSv1.3

In RS485 mode the transceiver is enabled only while data is sent. A
break set with TIOCSBRK therefore never reaches the bus, and protocols
that start each frame with a break, like DMX512, do not work.

Handle an active break like a transmission. Enable the transceiver
before setting the break, after delay_rts_before_send if one is
configured. When the break ends, stop transmitting unless the TX path
is still sending data.

Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>
---
Noticed while implementing a DMX master on a CM5 with its PL011.
Tested on that board, driving a DMX512 fixture with RS485 mode left
enabled.

The 8250 em485 code probably has the same issue. I have no hardware to
test it, but I'm happy to send a patch if someone is willing to.
---
 drivers/tty/serial/amba-pl011.c | 69 +++++++++++++++++++++++++++++++++++++++--
 1 file changed, 67 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index fcfa9f00aec6..7bef1be5e9b4 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -327,6 +327,7 @@ struct uart_amba_port {
 	char			type[12];
 	ktime_t			rs485_tx_drain_interval; /* nano */
 	enum pl011_rs485_tx_state	rs485_tx_state;
+	bool			rs485_break;
 	struct hrtimer		trigger_start_tx;
 	struct hrtimer		trigger_stop_tx;
 	bool			console_line_ended;
@@ -1279,6 +1280,11 @@ static inline bool pl011_dma_rx_running(struct uart_amba_port *uap)
 	return uap->using_rx_dma && uap->dmarx.running;
 }
 
+static inline bool pl011_dma_tx_queued(struct uart_amba_port *uap)
+{
+	return uap->dmatx.queued;
+}
+
 #else
 /* Blank functions if the DMA engine is not available */
 static inline void pl011_dma_remove(struct uart_amba_port *uap)
@@ -1330,6 +1336,11 @@ static inline bool pl011_dma_rx_running(struct uart_amba_port *uap)
 	return false;
 }
 
+static inline bool pl011_dma_tx_queued(struct uart_amba_port *uap)
+{
+	return false;
+}
+
 #define pl011_dma_flush_buffer	NULL
 #endif
 
@@ -1357,6 +1368,10 @@ static void pl011_rs485_tx_stop(struct uart_amba_port *uap)
 {
 	struct uart_port *port = &uap->port;
 
+	/* pl011_break_ctl() stops the transmission when the break ends */
+	if (uap->rs485_break)
+		return;
+
 	if (uap->rs485_tx_state == SEND)
 		uap->rs485_tx_state = WAIT_AFTER_SEND;
 
@@ -1477,8 +1492,12 @@ static enum hrtimer_restart pl011_trigger_start_tx(struct hrtimer *t)
 	unsigned long flags;
 
 	uart_port_lock_irqsave(&uap->port, &flags);
-	if (uap->rs485_tx_state == WAIT_AFTER_RTS)
-		pl011_start_tx(&uap->port);
+	if (uap->rs485_tx_state == WAIT_AFTER_RTS) {
+		uap->rs485_tx_state = SEND;
+		/* A break can arm the timer while TX is stopped */
+		if (!uart_tx_stopped(&uap->port))
+			pl011_start_tx(&uap->port);
+	}
 	uart_port_unlock_irqrestore(&uap->port, flags);
 
 	return HRTIMER_NORESTART;
@@ -1770,16 +1789,60 @@ static void pl011_break_ctl(struct uart_port *port, int break_state)
 {
 	struct uart_amba_port *uap =
 	    container_of(port, struct uart_amba_port, port);
+	struct tty_port *tport = &port->state->port;
+	bool rs485 = port->rs485.flags & SER_RS485_ENABLED;
 	unsigned long flags;
 	unsigned int lcr_h;
 
 	uart_port_lock_irqsave(&uap->port, &flags);
+
+	/*
+	 * In RS485 mode the transceiver only drives the bus while
+	 * transmitting. Treat a break as a transmission.
+	 */
+	if (rs485 && break_state == -1 && !uap->rs485_break) {
+		uap->rs485_break = true;
+
+		/* Pending data already enabled the transceiver */
+		if (uap->rs485_tx_state != SEND &&
+		    uap->rs485_tx_state != WAIT_AFTER_RTS)
+			pl011_rs485_tx_start(uap);
+
+		/*
+		 * Wait out delay_rts_before_send before starting the break.
+		 * The state stays WAIT_AFTER_RTS, so the TX path behaves as
+		 * without a break. Start it here if trigger_start_tx is late.
+		 */
+		if (uap->rs485_tx_state == WAIT_AFTER_RTS) {
+			uart_port_unlock_irqrestore(&uap->port, flags);
+			msleep(port->rs485.delay_rts_before_send);
+			uart_port_lock_irqsave(&uap->port, &flags);
+
+			if (uap->rs485_tx_state == WAIT_AFTER_RTS) {
+				hrtimer_try_to_cancel(&uap->trigger_start_tx);
+				uap->rs485_tx_state = SEND;
+				if (!uart_tx_stopped(port))
+					pl011_start_tx(port);
+			}
+		}
+	}
+
 	lcr_h = pl011_read(uap, REG_LCRH_TX);
 	if (break_state == -1)
 		lcr_h |= UART01x_LCRH_BRK;
 	else
 		lcr_h &= ~UART01x_LCRH_BRK;
 	pl011_write(lcr_h, uap, REG_LCRH_TX);
+
+	if (break_state == 0 && uap->rs485_break) {
+		uap->rs485_break = false;
+		/* An active TX path stops the transmission when it is done */
+		if (rs485 && (uart_tx_stopped(port) ||
+			      (!pl011_dma_tx_queued(uap) &&
+			       kfifo_is_empty(&tport->xmit_fifo))))
+			pl011_rs485_tx_stop(uap);
+	}
+
 	uart_port_unlock_irqrestore(&uap->port, flags);
 }
 
@@ -2100,6 +2163,7 @@ static void pl011_shutdown(struct uart_port *port)
 	hrtimer_cancel(&uap->trigger_stop_tx);
 
 	uart_port_lock_irq(port);
+	uap->rs485_break = false;
 	if (uap->rs485_tx_state != OFF)
 		pl011_rs485_tx_stop_now(uap);
 	uart_port_unlock_irq(port);
@@ -2396,6 +2460,7 @@ static int pl011_rs485_config(struct uart_port *port, struct ktermios *termios,
 	struct uart_amba_port *uap =
 		container_of(port, struct uart_amba_port, port);
 
+	uap->rs485_break = false;
 	if (port->rs485.flags & SER_RS485_ENABLED)
 		pl011_rs485_tx_stop(uap);
 

---
base-commit: 36844ea19656fb41278799ef3d5cd52120d89149
change-id: 20261011-devel-pl011-rs485-break-bec3b979a420

Best regards,
--  
Nicolai Buchwitz <nb@tipi-net.de>


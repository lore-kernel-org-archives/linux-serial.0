Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D127551B16C;
	Tue, 13 Oct 2026 13:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791898142; cv=none; b=Ur2k1eGWlNpn4bUP52tRAP/OAnD7FX3mimiWxQ2389XZhKaCXX8LZCGvR4agnfZRtgeLXM0AGUQU6mkU0uGChUnd9UbzxND9n3jWaViNbhI+ROK/+caDPA0wkfSo3cux4zygHVM7yxeVQs0ZiUIC/0mu23N1jF7HitG5scBy9D0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791898142; c=relaxed/simple;
	bh=FfCWZb607HhoaxWj3R36ql+EKeZXJIt+Lnk5QOIkKX0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=jtved8dZVCAMcz1F5T4TQaFVk7E01IN2imG43+EoX1nq/jV3rjRcvAiJF0dwRrErUYJh08zbWdalhlK6TiCnQUZ/ROrcGREDiIQrakVcUSH92KETTYm6YdQoCIzEdUVVTx3q9/oq92nliaVVeLlioJnKmvaGkDg9gWJoYrafQ4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=zYHKSH8N; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="zYHKSH8N"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 111A4A154E;
	Tue, 13 Oct 2026 15:28:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1791898133; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=DIWd3LiQvMdAY9yZkyntkGDgSewTOlV9Lge6F8Ivfvw=;
	b=zYHKSH8NRjY7uHNa+8sxLyc5BVvty+w8Eoim6h32aJjUNyAcZ4ky9Li2xhoV8bbFgZHDiB
	rmNJi9bHe7/GMia7DDE45VKgK4OQZGRaO1siNjm9YVq+atk+CLeZt5Lm/TLZeLVPwsaN7E
	sRvd8//fasCTKMLQDXZFJ/IA9nO/zER76o7Zv3o8xNOCtjcw1RFB+jd9VlPq3OS0drYu8J
	jRfiRkT5MjbOzHqq2xLe3iu9Q71XwNPWqd1fAc3tQMABKlq4dyCBKkA4lOng96nuzXUowE
	Pq4cbK35g0PdJd21qzC6+NWi0reY9rwxsUdhkLSWYtXlfb6XlBIhzdd4Ct1cRA==
From: Nicolai Buchwitz <nb@tipi-net.de>
Date: Tue, 13 Oct 2026 15:28:44 +0200
Subject: [PATCH v2] serial: amba-pl011: drive the bus during break in RS485
 mode
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261013-devel-pl011-rs485-break-v2-1-31c9f80d3e3d@tipi-net.de>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4WNTQ6CMBCFr0Jm7Zi2IH8r72FY0DLIKAHS1kZDu
 LsUD+Dufcl771vBkWVyUCcrWArseJ52UKcEzNBOd0LudgYlVC6FlNhRoBGXMWbrsvKC2lL7RE0
 m1VVRtZkSsK8XSz2/j+db82P30g8yPt7FxsDOz/ZzqIOMvf+WIFFirvo+EyotSpNfPS+ME/lzR
 9Bs2/YFSAfxeNIAAAA=
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
Changes in v2:
- Rebase onto tty-testing, which has the RS485 TXE and
  delay_rts_before_send fixes now
- Link to v1: https://patch.msgid.link/20261011-devel-pl011-rs485-break-v1-1-62ff402378c6@tipi-net.de

To: Russell King <linux@armlinux.org.uk>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Jiri Slaby <jirislaby@kernel.org>
Cc: Lino Sanfilippo <LinoSanfilippo@gmx.de>
Cc: linux-kernel@vger.kernel.org
Cc: linux-serial@vger.kernel.org
---
 drivers/tty/serial/amba-pl011.c | 65 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 64 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index 3edd83ec73de..79776a882ae3 100644
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
 
@@ -1479,7 +1494,9 @@ static enum hrtimer_restart pl011_trigger_start_tx(struct hrtimer *t)
 	uart_port_lock_irqsave(&uap->port, &flags);
 	if (uap->rs485_tx_state == WAIT_AFTER_RTS) {
 		uap->rs485_tx_state = SEND;
-		pl011_start_tx(&uap->port);
+		/* A break can arm the timer while TX is stopped */
+		if (!uart_tx_stopped(&uap->port))
+			pl011_start_tx(&uap->port);
 	}
 	uart_port_unlock_irqrestore(&uap->port, flags);
 
@@ -1772,16 +1789,60 @@ static void pl011_break_ctl(struct uart_port *port, int break_state)
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
 
@@ -2102,6 +2163,7 @@ static void pl011_shutdown(struct uart_port *port)
 	hrtimer_cancel(&uap->trigger_stop_tx);
 
 	uart_port_lock_irq(port);
+	uap->rs485_break = false;
 	if (uap->rs485_tx_state != OFF)
 		pl011_rs485_tx_stop_now(uap);
 	uart_port_unlock_irq(port);
@@ -2398,6 +2460,7 @@ static int pl011_rs485_config(struct uart_port *port, struct ktermios *termios,
 	struct uart_amba_port *uap =
 		container_of(port, struct uart_amba_port, port);
 
+	uap->rs485_break = false;
 	if ((port->rs485.flags & SER_RS485_ENABLED) &&
 	    !(rs485->flags & SER_RS485_ENABLED)) {
 		bool tx_pending = uap->rs485_tx_state == WAIT_AFTER_RTS;

---
base-commit: 979e9ad7178dcbd131dafdbb2f9a8c5bb0b7a26f
change-id: 20261011-devel-pl011-rs485-break-bec3b979a420

Best regards,
--  
Nicolai Buchwitz <nb@tipi-net.de>


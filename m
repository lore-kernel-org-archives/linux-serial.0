Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C295E17B428
	for <linux-serial@vger.kernel.org>; Tue, 25 Jun 2024 18:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719340949; cv=none; b=mVZjWblReI+i+F6849R6G/yEjsjkgIimfqPL9bE1HpdoAoi3AH3v+wAvHctcltKjYx74dvSaC7qkUXLcRxiJ3Q1LrzgA7kI0e7sb2JcR3KSYeMSZPN8UyuSZd5wuZjtzCSxevYcsrM/qrB9j7Oo8KhzqOtejHdG0oFoFWacnel4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719340949; c=relaxed/simple;
	bh=bFf47hFEVUuKOmXsiB4H2YqzJawoxVMdG5DGlAtPhD4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KkL/aw7Uof7Y2bCrEEPqBqLB8wXQ+TZ8gReB4EZFmihDkKRaAKDaIJgaCugyp+5CJ0lbQ/6bYrzj9HzYP2VFncSXXtM5df6dNy3SNDd+u7aLdBVg2LmdTa3KO7XJ7lfBEMyBf5RFnrTLyO+aTABZmmFsY4sjPDsE6CKmv2NnNr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk; spf=pass smtp.mailfrom=rasmusvillemoes.dk; dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b=bN3vJuoE; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rasmusvillemoes.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="bN3vJuoE"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-52ce6c93103so2928896e87.3
        for <linux-serial@vger.kernel.org>; Tue, 25 Jun 2024 11:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google; t=1719340946; x=1719945746; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fTRHmcetGLaYy17XrKZXgDqE5GMBbK+wOczjMxAfiWo=;
        b=bN3vJuoENHZov+rE9nFpJ6n6P4T2gJ9iYrl6nfrosotzqqNG6XisYxCrbnmSf5O4Br
         sSZc/HshQjU5yVEBr/JlK9DJ13D2u2kSt64XfjQBGzflPcNY6YSnyBSVAicuW+QokAjA
         Rlz7tR/O/FmEWJIR3mdFm9Jut7fPqftrtJg7Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719340946; x=1719945746;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fTRHmcetGLaYy17XrKZXgDqE5GMBbK+wOczjMxAfiWo=;
        b=Kymg+CR5lZM8Kl/qlIzsBjduWfD9EkiXdFAyV7/uIkTIhEzrw3WVK3Ey/RIksoQk/1
         IWdY4XWuU4LOVq5RgqrkQp5ThO7Aw7izuEn7p6/gtkmM8Ly82k34M+ev5EqIGzRQGl1g
         T0JXVEMLuLPknOnnuNdg+x/aAAm8qu76NUUJjnNVaSWSgPKld3jr3+vkcIr/WGm1RYGx
         NpvNBTCzlHmiycJAcC0md4OXJq6r1c8Q+yz3Janek4JW1XdqR1DLduuj4mnaB0SgXvRl
         q5AKot1EQI6/XnnmyjLfCrYL01CF1jbsn9rFlE80sKtyHmDn17Y6OsrmzTKdNSFLk50f
         bqCA==
X-Forwarded-Encrypted: i=1; AJvYcCWihQAuXTf+KhxkDBD8XdYDgaD9y5egxmTa/G7wn+9Wy0puZjGkb+/N8LfESHX5kkxM3p9Th1l92dgUij404beQpvOgIbjM+gM2g15Z
X-Gm-Message-State: AOJu0YzdyYyj4SLi1tCp6FxyZuUgdyrYRzZG4SwYurbKjNulZSm6Aud5
	bspQFshI2+O1oqGf+IF/yOoI6iPxACuAbB7NvlsvIZBNn+Jnr4tN1rHpP/lXJlc=
X-Google-Smtp-Source: AGHT+IHzd9Y3KJ+ekIIDdL14O7HCRFyG0RNRJ50heb9Bv7+zAcEg6cULMA2lGBbpiJbMQj4at+FLzg==
X-Received: by 2002:ac2:4c41:0:b0:52c:e1cd:39bd with SMTP id 2adb3069b0e04-52ce1cd3a79mr8123147e87.13.1719340944752;
        Tue, 25 Jun 2024 11:42:24 -0700 (PDT)
Received: from localhost (77.33.185.10.dhcp.fibianet.dk. [77.33.185.10])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7261795c58sm154993866b.118.2024.06.25.11.42.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 11:42:23 -0700 (PDT)
From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2] serial: imx: ensure RTS signal is not left active after shutdown
Date: Tue, 25 Jun 2024 20:42:05 +0200
Message-ID: <20240625184206.508837-1-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If a process is killed while writing to a /dev/ttymxc* device in RS485
mode, we observe that the RTS signal is left high, thus making it
impossible for other devices to transmit anything.

Moreover, the ->tx_state variable is left in state SEND, which means
that when one next opens the device and configures baud rate etc., the
initialization code in imx_uart_set_termios dutifully ensures the RTS
pin is pulled down, but since ->tx_state is already SEND, the logic in
imx_uart_start_tx() does not in fact pull the pin high before
transmitting, so nothing actually gets on the wire on the other side
of the transceiver. Only when that transmission is allowed to complete
is the state machine then back in a consistent state.

This is completely reproducible by doing something as simple as

  seq 10000 > /dev/ttymxc0

and hitting ctrl-C, and watching with a logic analyzer.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
v2: Use dev_warn() instead of dev_WARN_ONCE().

v1: https://lore.kernel.org/lkml/20240524121246.1896651-1-linux@rasmusvillemoes.dk/

A screen dump from a logic analyzer can be seen at:

  https://ibb.co/xCcP7Jy

This is on an imx8mp board, with /dev/ttymxc0 and /dev/ttymxc2 both
configured for rs485 and connected to each other. I'm writing to
/dev/ttymxc2. This demonstrates both bugs; that RTS is left high when
a write is interrupted, and that a subsequent write actually fails to
have RTS high while TX'ing.

I'm not sure what commit to name as a Fixes:. This certainly happens
on 6.6 and onwards, but I assume the problem exists since the tx_state
machine was introduced in cb1a60923609 (serial: imx: implement rts
delaying for rs485), and possibly even before that.


 drivers/tty/serial/imx.c | 51 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 2eb22594960f..85c240e8c24e 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -1551,6 +1551,7 @@ static void imx_uart_shutdown(struct uart_port *port)
 	struct imx_port *sport = (struct imx_port *)port;
 	unsigned long flags;
 	u32 ucr1, ucr2, ucr4, uts;
+	int loops;
 
 	if (sport->dma_is_enabled) {
 		dmaengine_terminate_sync(sport->dma_chan_tx);
@@ -1613,6 +1614,56 @@ static void imx_uart_shutdown(struct uart_port *port)
 	ucr4 &= ~UCR4_TCEN;
 	imx_uart_writel(sport, ucr4, UCR4);
 
+	/*
+	 * We have to ensure the tx state machine ends up in OFF. This
+	 * is especially important for rs485 where we must not leave
+	 * the RTS signal high, blocking the bus indefinitely.
+	 *
+	 * All interrupts are now disabled, so imx_uart_stop_tx() will
+	 * no longer be called from imx_uart_transmit_buffer(). It may
+	 * still be called via the hrtimers, and if those are in play,
+	 * we have to honour the delays.
+	 */
+	if (sport->tx_state == WAIT_AFTER_RTS || sport->tx_state == SEND)
+		imx_uart_stop_tx(port);
+
+	/*
+	 * In many cases (rs232 mode, or if tx_state was
+	 * WAIT_AFTER_RTS, or if tx_state was SEND and there is no
+	 * delay_rts_after_send), this will have moved directly to
+	 * OFF. In rs485 mode, tx_state might already have been
+	 * WAIT_AFTER_SEND and the hrtimer thus already started, or
+	 * the above imx_uart_stop_tx() call could have started it. In
+	 * those cases, we have to wait for the hrtimer to fire and
+	 * complete the transition to OFF.
+	 */
+	loops = port->rs485.flags & SER_RS485_ENABLED ?
+		port->rs485.delay_rts_after_send : 0;
+	while (sport->tx_state != OFF && loops--) {
+		uart_port_unlock_irqrestore(&sport->port, flags);
+		msleep(1);
+		uart_port_lock_irqsave(&sport->port, &flags);
+	}
+
+	if (sport->tx_state != OFF) {
+		dev_warn(sport->port.dev, "unexpected tx_state %d\n",
+			 sport->tx_state);
+		/*
+		 * This machine may be busted, but ensure the RTS
+		 * signal is inactive in order not to block other
+		 * devices.
+		 */
+		if (port->rs485.flags & SER_RS485_ENABLED) {
+			ucr2 = imx_uart_readl(sport, UCR2);
+			if (port->rs485.flags & SER_RS485_RTS_AFTER_SEND)
+				imx_uart_rts_active(sport, &ucr2);
+			else
+				imx_uart_rts_inactive(sport, &ucr2);
+			imx_uart_writel(sport, ucr2, UCR2);
+		}
+		sport->tx_state = OFF;
+	}
+
 	uart_port_unlock_irqrestore(&sport->port, flags);
 
 	clk_disable_unprepare(sport->clk_per);
-- 
2.45.2


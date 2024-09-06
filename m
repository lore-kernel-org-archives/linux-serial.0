Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D2671DA32;
	Fri,  6 Sep 2024 02:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725589164; cv=none; b=TOcdbQD9ZAW4v06P3Fcxb/nKKIF+osFKpJ8KZ/8/Way2vx+DU96Yto6g4vTKe0pUW7ztobeAI+3a4Hom3jSbHvaP64fwZJWpuTFagTroZJV3sqdabxn+ahE7ZTErifGwv7YG6jBpkQckoqrEHV637VzPzjNYQlgHUJBQfSjO5u8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725589164; c=relaxed/simple;
	bh=JhvGWELi5wvqSTr0Gd910OxL4OoPljviiUYpMFLt5og=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cKtUPP+8nrDzPgKP7XrgXwdv6xZzKQ8hh0W8CpjWSJ8gRvY2F7Bemx8/PFMZpMAKl2BScZEy9qQv6HIWPGDo69cGbo1yDxXLOjLMdEnRBcmC9cG7Uw6LRm3qU5sM5mfpiSc11hmWtL42kZwr474Xu3wNvXHnQ7GrMsLn5aaZYqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N9HLXZ1s; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N9HLXZ1s"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2d87a0bfaa7so1119772a91.2;
        Thu, 05 Sep 2024 19:19:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725589162; x=1726193962; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dIW9b0DbiNOfgETQSZVCY5M0dVLOvu9t5blHuaZ3mxw=;
        b=N9HLXZ1spGJoGEpps5auP5vt+ghE2l7ldqX7rAlt9tZQGVhfPRcjbjg0WfzYqzaiPe
         SDJ6if5oEgY0E/CiOgk0lJH1KiaY9xgRi3NzoSYkV8y5VJ65ERCAK5evDR5zQnc1JQ5I
         ywIaMSfZ0GzDUT0ViItXtOVX/1mtfQvubpj9HDHaEPTQQdJoSEBczqGmRiJPGDbRdVPf
         J73wZWW6Jpgr1FC5KzgpJC+0AJCmaZmNf0ucqcIYrYu55RPOA+DfGfPMZhW61ts1bjkl
         2dm/L7G0pUyLGE7D09DCwAJEJHDmQWeO/x7Xg8eV25YpX/p/x7LeCzwrP4r4M781qt9i
         n6WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725589162; x=1726193962;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dIW9b0DbiNOfgETQSZVCY5M0dVLOvu9t5blHuaZ3mxw=;
        b=Pi825/V0FdLu5QljOzLy0Zgk7IpFrcHotZmaxOKM2L7DXvT9dxhIZZEJBlKhx4/K3/
         LNKafJmv/PDUsXd4PFWpXI5vtulx0XRCCMe6UZ4HF+1c3vUdTw6uKSXGq0Vqv7zNQY0D
         M+7sf2zSsKe0jf/LPZU1p+E8HQhAT2qIY0LoYc4mJqaqTWJMf/+pqDYWkloJA/N5y/4a
         ohrTO8rLzJlaLpTWVD1YqaSCIZqwMpwT20kAuOxIfP4bzihz+5bD0Vu6kcBUA1Qul9O3
         d+ycjJM5v/c8OhVXIYJ+Ofqi3RgvOu6Itlj4JxyJzD7KIe20nevkI0/WTOIh8iCSrPIZ
         M+jw==
X-Forwarded-Encrypted: i=1; AJvYcCUmiOqgqIjxWH6LipHk8n7x+j8tP6z5+f/u5SpGF20vNmfb/GGiu3NcxLSTO4IH2Pkmi0s3OXpzWwy4BA1y@vger.kernel.org, AJvYcCUxoCLWd/LYWxBebCbhEg1iBDAYcGlRM+bwFZVSqRGxVqFhHeZBpcWgAY0ABdIJidr+B0yWt6XIBSIGvpI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yycyg24pOE2p3RV1xojis82MSBo2BIAzBnQaUe68zuhw0v1dYHU
	LVHbGHlEBNLewGi8SwwIvGhB+d3iJBGwj8jo7kAW2yoiGNeccet6
X-Google-Smtp-Source: AGHT+IF11BObZmFZ8H/MLIMIJdM/xn6Tn01KO3MpE/ePD6LblTS2fnwlypbI8IaypHv+HDhos0FGkg==
X-Received: by 2002:a17:90b:394d:b0:2d8:8920:771c with SMTP id 98e67ed59e1d1-2dad50c2cc2mr1490538a91.32.1725589161700;
        Thu, 05 Sep 2024 19:19:21 -0700 (PDT)
Received: from lcwang-Precision-3630-Tower.. (211-23-39-77.hinet-ip.hinet.net. [211.23.39.77])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2dadc0e3141sm265184a91.54.2024.09.05.19.19.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 19:19:21 -0700 (PDT)
From: LiangCheng Wang <zaq14760@gmail.com>
To: shawnguo@kernel.org
Cc: s.hauer@pengutronix.de,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	kernel@pengutronix.de,
	festevam@gmail.com,
	u.kleine-koenig@pengutronix.de,
	cniedermaier@dh-electronics.com,
	l.sanfilippo@kunbus.com,
	linux@rasmusvillemoes.dk,
	stefan.eichenberger@toradex.com,
	tglx@linutronix.de,
	rickaran@axis.com,
	zaq14760@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH 1/1] drivers: tty: imx: fix flags of rs485 not work properly
Date: Fri,  6 Sep 2024 10:19:05 +0800
Message-Id: <20240906021905.197891-1-zaq14760@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The rs485.flags are lost in functions such as imx_uart_stop_tx(),
causing the function of RS485 to be invalid when using the
serial port as the RS485 port. Use a variable to store the state to
avoid this issue.

Signed-off-by: LiangCheng Wang <zaq14760@gmail.com>
---
 drivers/tty/serial/imx.c | 35 ++++++++++++++++++-----------------
 1 file changed, 18 insertions(+), 17 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 67d4a72eda77..346bbd21536b 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -209,7 +209,7 @@ struct imx_port {
 	const struct imx_uart_data *devdata;
 
 	struct mctrl_gpios *gpios;
-
+	int flags;
 	/* counter to stop 0xff flood */
 	int idle_counter;
 
@@ -434,7 +434,7 @@ static void imx_uart_stop_tx(struct uart_port *port)
 	imx_uart_writel(sport, ucr4, UCR4);
 
 	/* in rs485 mode disable transmitter */
-	if (port->rs485.flags & SER_RS485_ENABLED) {
+	if (sport->flags & SER_RS485_ENABLED) {
 		if (sport->tx_state == SEND) {
 			sport->tx_state = WAIT_AFTER_SEND;
 
@@ -454,7 +454,7 @@ static void imx_uart_stop_tx(struct uart_port *port)
 			hrtimer_try_to_cancel(&sport->trigger_start_tx);
 
 			ucr2 = imx_uart_readl(sport, UCR2);
-			if (port->rs485.flags & SER_RS485_RTS_AFTER_SEND)
+			if (sport->flags & SER_RS485_RTS_AFTER_SEND)
 				imx_uart_rts_active(sport, &ucr2);
 			else
 				imx_uart_rts_inactive(sport, &ucr2);
@@ -490,8 +490,8 @@ static void imx_uart_stop_rx_with_loopback_ctrl(struct uart_port *port, bool loo
 	imx_uart_writel(sport, ucr4, UCR4);
 
 	/* See SER_RS485_ENABLED/UTS_LOOP comment in imx_uart_probe() */
-	if (port->rs485.flags & SER_RS485_ENABLED &&
-	    port->rs485.flags & SER_RS485_RTS_ON_SEND &&
+	if (sport->flags & SER_RS485_ENABLED &&
+	    sport->flags & SER_RS485_RTS_ON_SEND &&
 	    sport->have_rtscts && !sport->have_rtsgpio && loopback) {
 		uts = imx_uart_readl(sport, imx_uart_uts_reg(sport));
 		uts |= UTS_LOOP;
@@ -604,7 +604,7 @@ static void imx_uart_dma_tx_callback(void *data)
 	if (!kfifo_is_empty(&tport->xmit_fifo) &&
 			!uart_tx_stopped(&sport->port))
 		imx_uart_dma_tx(sport);
-	else if (sport->port.rs485.flags & SER_RS485_ENABLED) {
+	else if (sport->flags & SER_RS485_ENABLED) {
 		u32 ucr4 = imx_uart_readl(sport, UCR4);
 		ucr4 |= UCR4_TCEN;
 		imx_uart_writel(sport, ucr4, UCR4);
@@ -681,10 +681,10 @@ static void imx_uart_start_tx(struct uart_port *port)
 	 * imx_uart_stop_tx(), but tx_state is still SEND.
 	 */
 
-	if (port->rs485.flags & SER_RS485_ENABLED) {
+	if (sport->flags & SER_RS485_ENABLED) {
 		if (sport->tx_state == OFF) {
 			u32 ucr2 = imx_uart_readl(sport, UCR2);
-			if (port->rs485.flags & SER_RS485_RTS_ON_SEND)
+			if (sport->flags & SER_RS485_RTS_ON_SEND)
 				imx_uart_rts_active(sport, &ucr2);
 			else
 				imx_uart_rts_inactive(sport, &ucr2);
@@ -695,7 +695,7 @@ static void imx_uart_start_tx(struct uart_port *port)
 			 * with loopback enabled because that will make our
 			 * transmitted data being just looped to RX.
 			 */
-			if (!(port->rs485.flags & SER_RS485_RX_DURING_TX) &&
+			if (!(sport->flags & SER_RS485_RX_DURING_TX) &&
 			    !port->rs485_rx_during_tx_gpio)
 				imx_uart_stop_rx_with_loopback_ctrl(port, false);
 
@@ -1078,7 +1078,7 @@ static void imx_uart_set_mctrl(struct uart_port *port, unsigned int mctrl)
 	struct imx_port *sport = to_imx_port(port);
 	u32 ucr3, uts;
 
-	if (!(port->rs485.flags & SER_RS485_ENABLED)) {
+	if (!(sport->flags & SER_RS485_ENABLED)) {
 		u32 ucr2;
 
 		/*
@@ -1604,8 +1604,8 @@ static void imx_uart_shutdown(struct uart_port *port)
 	ucr1 &= ~(UCR1_TRDYEN | UCR1_RRDYEN | UCR1_RTSDEN | UCR1_RXDMAEN |
 		  UCR1_ATDMAEN | UCR1_SNDBRK);
 	/* See SER_RS485_ENABLED/UTS_LOOP comment in imx_uart_probe() */
-	if (port->rs485.flags & SER_RS485_ENABLED &&
-	    port->rs485.flags & SER_RS485_RTS_ON_SEND &&
+	if (sport->flags & SER_RS485_ENABLED &&
+	    sport->flags & SER_RS485_RTS_ON_SEND &&
 	    sport->have_rtscts && !sport->have_rtsgpio) {
 		uts = imx_uart_readl(sport, imx_uart_uts_reg(sport));
 		uts |= UTS_LOOP;
@@ -1643,7 +1643,7 @@ static void imx_uart_shutdown(struct uart_port *port)
 	 * those cases, we have to wait for the hrtimer to fire and
 	 * complete the transition to OFF.
 	 */
-	loops = port->rs485.flags & SER_RS485_ENABLED ?
+	loops = sport->flags & SER_RS485_ENABLED ?
 		port->rs485.delay_rts_after_send : 0;
 	while (sport->tx_state != OFF && loops--) {
 		uart_port_unlock_irqrestore(&sport->port, flags);
@@ -1659,9 +1659,9 @@ static void imx_uart_shutdown(struct uart_port *port)
 		 * signal is inactive in order not to block other
 		 * devices.
 		 */
-		if (port->rs485.flags & SER_RS485_ENABLED) {
+		if (sport->flags & SER_RS485_ENABLED) {
 			ucr2 = imx_uart_readl(sport, UCR2);
-			if (port->rs485.flags & SER_RS485_RTS_AFTER_SEND)
+			if (sport->flags & SER_RS485_RTS_AFTER_SEND)
 				imx_uart_rts_active(sport, &ucr2);
 			else
 				imx_uart_rts_inactive(sport, &ucr2);
@@ -1749,13 +1749,13 @@ imx_uart_set_termios(struct uart_port *port, struct ktermios *termios,
 	if (!sport->have_rtscts)
 		termios->c_cflag &= ~CRTSCTS;
 
-	if (port->rs485.flags & SER_RS485_ENABLED) {
+	if (sport->flags & SER_RS485_ENABLED) {
 		/*
 		 * RTS is mandatory for rs485 operation, so keep
 		 * it under manual control and keep transmitter
 		 * disabled.
 		 */
-		if (port->rs485.flags & SER_RS485_RTS_AFTER_SEND)
+		if (sport->flags & SER_RS485_RTS_AFTER_SEND)
 			imx_uart_rts_active(sport, &ucr2);
 		else
 			imx_uart_rts_inactive(sport, &ucr2);
@@ -2394,6 +2394,7 @@ static int imx_uart_probe(struct platform_device *pdev)
 	}
 
 	ret = uart_get_rs485_mode(&sport->port);
+	sport->flags = sport->port.rs485.flags;
 	if (ret)
 		goto err_clk;
 
-- 
2.34.1


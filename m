Return-Path: <SRS0=jHyV=6T=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FEC0C47254
	for <linux-serial@archiver.kernel.org>; Tue,  5 May 2020 14:47:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF151206B9
	for <linux-serial@archiver.kernel.org>; Tue,  5 May 2020 14:47:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729123AbgEEOr0 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 5 May 2020 10:47:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729065AbgEEOr0 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 5 May 2020 10:47:26 -0400
X-Greylist: delayed 130 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 05 May 2020 07:47:25 PDT
Received: from mailout2.hostsharing.net (mailout2.hostsharing.net [IPv6:2a01:37:3000::53df:4ee9:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF35BC061A0F
        for <linux-serial@vger.kernel.org>; Tue,  5 May 2020 07:47:25 -0700 (PDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by mailout2.hostsharing.net (Postfix) with ESMTPS id 6740C10189C51;
        Tue,  5 May 2020 16:47:24 +0200 (CEST)
Received: from localhost (unknown [87.130.102.138])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by h08.hostsharing.net (Postfix) with ESMTPSA id 0E5B0610EE1A;
        Tue,  5 May 2020 16:47:23 +0200 (CEST)
X-Mailbox-Line: From ce5fd71e1511fbd0eef798fc1998e522d7b7938b Mon Sep 17 00:00:00 2001
Message-Id: <ce5fd71e1511fbd0eef798fc1998e522d7b7938b.1588505407.git.lukas@wunner.de>
In-Reply-To: <cover.1588505407.git.lukas@wunner.de>
References: <cover.1588505407.git.lukas@wunner.de>
From:   Lukas Wunner <lukas@wunner.de>
Date:   Tue, 5 May 2020 16:42:02 +0200
Subject: [PATCH 2/4] serial: Allow uart_get_rs485_mode() to return errno
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Cc:     "Matwey V. Kornilov" <matwey@sai.msu.ru>,
        Giulio Benetti <giulio.benetti@micronovasrl.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Christoph Muellner <christoph.muellner@theobroma-systems.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Codrin Ciubotariu <Codrin.Ciubotariu@microchip.com>,
        Razvan Stefanescu <razvan.stefanescu@microchip.com>,
        Radu Pirea <radu.pirea@microchip.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Bich HEMON <bich.hemon@st.com>,
        Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>,
        linux-serial@vger.kernel.org
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

We're about to amend uart_get_rs485_mode() to support a GPIO pin for
rs485 bus termination.  Retrieving the GPIO descriptor may fail, so
allow uart_get_rs485_mode() to return an errno and change all callers
to check for failure.

The GPIO descriptor is going to be stored in struct uart_port.  Pass
that struct to uart_get_rs485_mode() in lieu of a struct device and
struct serial_rs485, both of which are directly accessible from struct
uart_port.

A few drivers call uart_get_rs485_mode() before setting the struct
device pointer in struct uart_port.  Shuffle those calls around where
necessary.

[Heiko Stuebner did the ar933x_uart.c portion, hence his Signed-off-by.]

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
 drivers/tty/serial/8250/8250_core.c | 4 +++-
 drivers/tty/serial/ar933x_uart.c    | 6 ++++--
 drivers/tty/serial/atmel_serial.c   | 6 ++++--
 drivers/tty/serial/fsl_lpuart.c     | 5 ++++-
 drivers/tty/serial/imx.c            | 6 +++++-
 drivers/tty/serial/omap-serial.c    | 4 +++-
 drivers/tty/serial/serial_core.c    | 6 +++++-
 drivers/tty/serial/stm32-usart.c    | 8 ++++----
 include/linux/serial_core.h         | 2 +-
 9 files changed, 33 insertions(+), 14 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
index 14abade589da..43121973ce02 100644
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -1026,7 +1026,9 @@ int serial8250_register_8250_port(struct uart_8250_port *up)
 
 		if (up->port.dev) {
 			uart->port.dev = up->port.dev;
-			uart_get_rs485_mode(uart->port.dev, &uart->port.rs485);
+			ret = uart_get_rs485_mode(&uart->port);
+			if (ret)
+				goto err;
 		}
 
 		if (up->port.flags & UPF_FIXED_TYPE)
diff --git a/drivers/tty/serial/ar933x_uart.c b/drivers/tty/serial/ar933x_uart.c
index 7e7f1398019f..0c80a79d7442 100644
--- a/drivers/tty/serial/ar933x_uart.c
+++ b/drivers/tty/serial/ar933x_uart.c
@@ -766,8 +766,6 @@ static int ar933x_uart_probe(struct platform_device *pdev)
 		goto err_disable_clk;
 	}
 
-	uart_get_rs485_mode(&pdev->dev, &port->rs485);
-
 	port->mapbase = mem_res->start;
 	port->line = id;
 	port->irq = irq_res->start;
@@ -786,6 +784,10 @@ static int ar933x_uart_probe(struct platform_device *pdev)
 	baud = ar933x_uart_get_baud(port->uartclk, 0, AR933X_UART_MAX_STEP);
 	up->max_baud = min_t(unsigned int, baud, AR933X_UART_MAX_BAUD);
 
+	ret = uart_get_rs485_mode(port);
+	if (ret)
+		goto err_disable_clk;
+
 	up->gpios = mctrl_gpio_init(port, 0);
 	if (IS_ERR(up->gpios) && PTR_ERR(up->gpios) != -ENOSYS)
 		return PTR_ERR(up->gpios);
diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
index 8d7080efad9b..e43471b33710 100644
--- a/drivers/tty/serial/atmel_serial.c
+++ b/drivers/tty/serial/atmel_serial.c
@@ -2491,8 +2491,6 @@ static int atmel_init_port(struct atmel_uart_port *atmel_port,
 	atmel_init_property(atmel_port, pdev);
 	atmel_set_ops(port);
 
-	uart_get_rs485_mode(&mpdev->dev, &port->rs485);
-
 	port->iotype		= UPIO_MEM;
 	port->flags		= UPF_BOOT_AUTOCONF | UPF_IOREMAP;
 	port->ops		= &atmel_pops;
@@ -2506,6 +2504,10 @@ static int atmel_init_port(struct atmel_uart_port *atmel_port,
 
 	memset(&atmel_port->rx_ring, 0, sizeof(atmel_port->rx_ring));
 
+	ret = uart_get_rs485_mode(port);
+	if (ret)
+		return ret;
+
 	/* for console, the clock could already be configured */
 	if (!atmel_port->clk) {
 		atmel_port->clk = clk_get(&mpdev->dev, "usart");
diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index 6a9909e56449..029324c77cd7 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -2619,7 +2619,9 @@ static int lpuart_probe(struct platform_device *pdev)
 	if (ret)
 		goto failed_attach_port;
 
-	uart_get_rs485_mode(&pdev->dev, &sport->port.rs485);
+	ret = uart_get_rs485_mode(&sport->port);
+	if (ret)
+		goto failed_get_rs485;
 
 	if (sport->port.rs485.flags & SER_RS485_RX_DURING_TX)
 		dev_err(&pdev->dev, "driver doesn't support RX during TX\n");
@@ -2632,6 +2634,7 @@ static int lpuart_probe(struct platform_device *pdev)
 
 	return 0;
 
+failed_get_rs485:
 failed_attach_port:
 failed_irq_request:
 	lpuart_disable_clks(sport);
diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index f4d68109bc8b..91f3910d6c44 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -2302,7 +2302,11 @@ static int imx_uart_probe(struct platform_device *pdev)
 	sport->ucr4 = readl(sport->port.membase + UCR4);
 	sport->ufcr = readl(sport->port.membase + UFCR);
 
-	uart_get_rs485_mode(&pdev->dev, &sport->port.rs485);
+	ret = uart_get_rs485_mode(&sport->port);
+	if (ret) {
+		clk_disable_unprepare(sport->clk_ipg);
+		return ret;
+	}
 
 	if (sport->port.rs485.flags & SER_RS485_ENABLED &&
 	    (!sport->have_rtscts && !sport->have_rtsgpio))
diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
index c71c1a2266dc..8573fc9cb0cd 100644
--- a/drivers/tty/serial/omap-serial.c
+++ b/drivers/tty/serial/omap-serial.c
@@ -1608,7 +1608,9 @@ static int serial_omap_probe_rs485(struct uart_omap_port *up,
 	if (!np)
 		return 0;
 
-	uart_get_rs485_mode(up->dev, rs485conf);
+	ret = uart_get_rs485_mode(&up->port);
+	if (ret)
+		return ret;
 
 	if (of_property_read_bool(np, "rs485-rts-active-high")) {
 		rs485conf->flags |= SER_RS485_RTS_ON_SEND;
diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 66a5e2faf57e..43b6682877d5 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -3295,8 +3295,10 @@ EXPORT_SYMBOL(uart_remove_one_port);
  * This function implements the device tree binding described in
  * Documentation/devicetree/bindings/serial/rs485.txt.
  */
-void uart_get_rs485_mode(struct device *dev, struct serial_rs485 *rs485conf)
+int uart_get_rs485_mode(struct uart_port *port)
 {
+	struct serial_rs485 *rs485conf = &port->rs485;
+	struct device *dev = port->dev;
 	u32 rs485_delay[2];
 	int ret;
 
@@ -3328,6 +3330,8 @@ void uart_get_rs485_mode(struct device *dev, struct serial_rs485 *rs485conf)
 		rs485conf->flags &= ~SER_RS485_RTS_ON_SEND;
 		rs485conf->flags |= SER_RS485_RTS_AFTER_SEND;
 	}
+
+	return 0;
 }
 EXPORT_SYMBOL_GPL(uart_get_rs485_mode);
 
diff --git a/drivers/tty/serial/stm32-usart.c b/drivers/tty/serial/stm32-usart.c
index 5e93e8d40f59..e3db54398159 100644
--- a/drivers/tty/serial/stm32-usart.c
+++ b/drivers/tty/serial/stm32-usart.c
@@ -158,9 +158,7 @@ static int stm32_init_rs485(struct uart_port *port,
 	if (!pdev->dev.of_node)
 		return -ENODEV;
 
-	uart_get_rs485_mode(&pdev->dev, rs485conf);
-
-	return 0;
+	return uart_get_rs485_mode(port);
 }
 
 static int stm32_pending_rx(struct uart_port *port, u32 *sr, int *last_res,
@@ -931,7 +929,9 @@ static int stm32_init_port(struct stm32_port *stm32port,
 
 	port->rs485_config = stm32_config_rs485;
 
-	stm32_init_rs485(port, pdev);
+	ret = stm32_init_rs485(port, pdev);
+	if (ret)
+		return ret;
 
 	if (stm32port->info->cfg.has_wakeup) {
 		stm32port->wakeirq = platform_get_irq(pdev, 1);
diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index 92f5eba86052..b649a2b894e7 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -472,5 +472,5 @@ extern int uart_handle_break(struct uart_port *port);
 					 (cflag) & CRTSCTS || \
 					 !((cflag) & CLOCAL))
 
-void uart_get_rs485_mode(struct device *dev, struct serial_rs485 *rs485conf);
+int uart_get_rs485_mode(struct uart_port *port);
 #endif /* LINUX_SERIAL_CORE_H */
-- 
2.26.2


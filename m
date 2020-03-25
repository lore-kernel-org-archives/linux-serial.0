Return-Path: <SRS0=EpC2=5K=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6842CC43331
	for <linux-serial@archiver.kernel.org>; Wed, 25 Mar 2020 23:14:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FA5220714
	for <linux-serial@archiver.kernel.org>; Wed, 25 Mar 2020 23:14:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727399AbgCYXOv (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 25 Mar 2020 19:14:51 -0400
Received: from gloria.sntech.de ([185.11.138.130]:40180 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727395AbgCYXOn (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 25 Mar 2020 19:14:43 -0400
Received: from ip5f5a5d2f.dynamic.kabel-deutschland.de ([95.90.93.47] helo=phil.sntech)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1jHFEH-0007ug-CY; Thu, 26 Mar 2020 00:14:33 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     gregkh@linuxfoundation.org
Cc:     jslaby@suse.com, andriy.shevchenko@linux.intel.com,
        matwey.kornilov@gmail.com, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, heiko@sntech.de, lukas@wunner.de,
        christoph.muellner@theobroma-systems.com,
        giulio.benetti@micronovasrl.com
Subject: [PATCH DON'T APPLY v2 1/7] serial: Allow uart_get_rs485_mode() to return errno
Date:   Thu, 26 Mar 2020 00:14:16 +0100
Message-Id: <20200325231422.1502366-2-heiko@sntech.de>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200325231422.1502366-1-heiko@sntech.de>
References: <20200325231422.1502366-1-heiko@sntech.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Lukas Wunner <lukas@wunner.de>

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

Signed-off-by: Lukas Wunner <lukas@wunner.de>
[add ar933x_uart as well]
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
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
index 45d9117cab68..cbf370e22344 100644
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -1026,7 +1026,9 @@ int serial8250_register_8250_port(struct uart_8250_port *up)
 
 		if (up->port.dev) {
 			uart->port.dev = up->port.dev;
-			uart_get_rs485_mode(uart->port.dev, &uart->port.rs485);
+			ret = uart_get_rs485_mode(&uart->port);
+			if (ret)
+				goto out_unlock;
 		}
 
 		if (up->port.flags & UPF_FIXED_TYPE)
diff --git a/drivers/tty/serial/ar933x_uart.c b/drivers/tty/serial/ar933x_uart.c
index 7e7f1398019f..5bace041b94c 100644
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
@@ -780,6 +778,10 @@ static int ar933x_uart_probe(struct platform_device *pdev)
 	port->ops = &ar933x_uart_ops;
 	port->rs485_config = ar933x_config_rs485;
 
+	ret = uart_get_rs485_mode(port);
+	if (ret)
+		goto err_disable_clk;
+
 	baud = ar933x_uart_get_baud(port->uartclk, AR933X_UART_MAX_SCALE, 1);
 	up->min_baud = max_t(unsigned int, baud, AR933X_UART_MIN_BAUD);
 
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
index 9c6a018b1390..4a1b507b4af1 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -2611,7 +2611,9 @@ static int lpuart_probe(struct platform_device *pdev)
 	if (ret)
 		goto failed_attach_port;
 
-	uart_get_rs485_mode(&pdev->dev, &sport->port.rs485);
+	ret = uart_get_rs485_mode(&sport->port);
+	if (ret)
+		goto failed_get_rs485;
 
 	if (sport->port.rs485.flags & SER_RS485_RX_DURING_TX)
 		dev_err(&pdev->dev, "driver doesn't support RX during TX\n");
@@ -2624,6 +2626,7 @@ static int lpuart_probe(struct platform_device *pdev)
 
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
index 48017cec7f2f..532fbc68e801 100644
--- a/drivers/tty/serial/omap-serial.c
+++ b/drivers/tty/serial/omap-serial.c
@@ -1609,7 +1609,9 @@ static int serial_omap_probe_rs485(struct uart_omap_port *up,
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
2.24.1


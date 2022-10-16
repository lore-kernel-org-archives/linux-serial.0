Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E9A8C4332F
	for <linux-serial@archiver.kernel.org>; Sun, 16 Oct 2022 08:02:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229579AbiJPICH (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sun, 16 Oct 2022 04:02:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbiJPICG (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sun, 16 Oct 2022 04:02:06 -0400
Received: from mailout1.hostsharing.net (mailout1.hostsharing.net [83.223.95.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BE213C8D5
        for <linux-serial@vger.kernel.org>; Sun, 16 Oct 2022 01:02:03 -0700 (PDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL TLS DV RSA Mixed SHA256 2020 CA-1" (verified OK))
        by mailout1.hostsharing.net (Postfix) with ESMTPS id 1287E1012FE0F;
        Sun, 16 Oct 2022 10:01:59 +0200 (CEST)
Received: from localhost (unknown [89.246.108.87])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by h08.hostsharing.net (Postfix) with ESMTPSA id D626C603E021;
        Sun, 16 Oct 2022 10:01:58 +0200 (CEST)
X-Mailbox-Line: From e9f25f5c9200a35d3162973c2b45d6b892cc9bf2 Mon Sep 17 00:00:00 2001
Message-Id: <e9f25f5c9200a35d3162973c2b45d6b892cc9bf2.1665906869.git.lukas@wunner.de>
From:   Lukas Wunner <lukas@wunner.de>
Date:   Sun, 16 Oct 2022 10:02:00 +0200
Subject: [PATCH v2] serial: 8250: 8250_omap: Support native RS485
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        Vignesh Raghavendra <vigneshr@ti.com>, Bin Liu <b-liu@ti.com>
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        "Su Bao Cheng" <baocheng.su@siemens.com>,
        Nishanth Menon <nm@ti.com>,
        Lino Sanfilippo <LinoSanfilippo@gmx.de>,
        Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>,
        linux-serial@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Recent TI Sitara SoCs such as AM64/AM65 have gained the ability to
automatically assert RTS when data is transmitted, obviating the need
to emulate this functionality in software.

The feature is controlled through new DIR_EN and DIR_POL bits in the
Mode Definition Register 3.  For details see page 8783 and 8890 of the
AM65 TRM:  https://www.ti.com/lit/ug/spruid7e/spruid7e.pdf

Signed-off-by: Lukas Wunner <lukas@wunner.de>
Cc: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Cc: Su Bao Cheng <baocheng.su@siemens.com>
Cc: Vignesh Raghavendra <vigneshr@ti.com>
Cc: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Bin Liu <b-liu@ti.com>
---
 Changes v1 -> v2:

 * Fall back to RS485 software emulation if RTS GPIO is used or
   user-requested delays exceed fixed hardware delays (Bin Liu,
   Vignesh Raghavendra)

 * Set fixed hardware delay upon RTS assertion to 1 clock cycle
   instead of 0 previously

 * Add code comment to clarify that rs485_supported is the same
   for software emulation and native RS485 (Ilpo Järvinen)

 drivers/tty/serial/8250/8250_omap.c | 85 ++++++++++++++++++++++++++++-
 1 file changed, 82 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
index 68f5a167377f..0648e858a7cd 100644
--- a/drivers/tty/serial/8250/8250_omap.c
+++ b/drivers/tty/serial/8250/8250_omap.c
@@ -44,6 +44,7 @@
 #define	UART_HAS_EFR2			BIT(4)
 #define UART_HAS_RHR_IT_DIS		BIT(5)
 #define UART_RX_TIMEOUT_QUIRK		BIT(6)
+#define UART_HAS_NATIVE_RS485		BIT(7)
 
 #define OMAP_UART_FCR_RX_TRIG		6
 #define OMAP_UART_FCR_TX_TRIG		4
@@ -101,6 +102,11 @@
 #define UART_OMAP_IER2			0x1B
 #define UART_OMAP_IER2_RHR_IT_DIS	BIT(2)
 
+/* Mode Definition Register 3 */
+#define UART_OMAP_MDR3			0x20
+#define UART_OMAP_MDR3_DIR_POL		BIT(3)
+#define UART_OMAP_MDR3_DIR_EN		BIT(4)
+
 /* Enhanced features register 2 */
 #define UART_OMAP_EFR2			0x23
 #define UART_OMAP_EFR2_TIMEOUT_BEHAVE	BIT(6)
@@ -112,6 +118,7 @@ struct omap8250_priv {
 	int line;
 	u8 habit;
 	u8 mdr1;
+	u8 mdr3;
 	u8 efr;
 	u8 scr;
 	u8 wer;
@@ -345,7 +352,10 @@ static void omap8250_restore_regs(struct uart_8250_port *up)
 
 	up->port.ops->set_mctrl(&up->port, up->port.mctrl);
 
-	if (up->port.rs485.flags & SER_RS485_ENABLED)
+	serial_out(up, UART_OMAP_MDR3, priv->mdr3);
+
+	if (up->port.rs485.flags & SER_RS485_ENABLED &&
+	    up->port.rs485_config == serial8250_em485_config)
 		serial8250_em485_stop_tx(up);
 }
 
@@ -793,6 +803,74 @@ static void omap_8250_unthrottle(struct uart_port *port)
 	pm_runtime_put_autosuspend(port->dev);
 }
 
+static int omap8250_rs485_config(struct uart_port *port,
+				 struct ktermios *termios,
+				 struct serial_rs485 *rs485)
+{
+	struct omap8250_priv *priv = port->private_data;
+	struct uart_8250_port *up = up_to_u8250p(port);
+	u32 fixed_delay_rts_before_send = 0;
+	u32 fixed_delay_rts_after_send = 0;
+	unsigned int baud;
+
+	/*
+	 * There is a fixed delay of 3 bit clock cycles after the TX shift
+	 * register is going empty to allow time for the stop bit to transition
+	 * through the transceiver before direction is changed to receive.
+	 *
+	 * Additionally there appears to be a 1 bit clock delay between writing
+	 * to the THR register and transmission of the start bit, per page 8783
+	 * of the AM65 TRM:  https://www.ti.com/lit/ug/spruid7e/spruid7e.pdf
+	 */
+	if (priv->quot) {
+		if (priv->mdr1 & UART_OMAP_MDR1_16X_MODE)
+			baud = port->uartclk / (16 * priv->quot);
+		else
+			baud = port->uartclk / (13 * priv->quot);
+
+		fixed_delay_rts_after_send  = 3 * MSEC_PER_SEC / baud;
+		fixed_delay_rts_before_send = 1 * MSEC_PER_SEC / baud;
+	}
+
+	/*
+	 * Fall back to RS485 software emulation if the UART is missing
+	 * hardware support, if the device tree specifies an mctrl_gpio
+	 * (indicates that RTS is unavailable due to a pinmux conflict)
+	 * or if the requested delays exceed the fixed hardware delays.
+	 */
+	if (!(priv->habit & UART_HAS_NATIVE_RS485) ||
+	    mctrl_gpio_to_gpiod(up->gpios, UART_GPIO_RTS) ||
+	    rs485->delay_rts_after_send  > fixed_delay_rts_after_send ||
+	    rs485->delay_rts_before_send > fixed_delay_rts_before_send) {
+		priv->mdr3 &= ~UART_OMAP_MDR3_DIR_EN;
+		serial_out(up, UART_OMAP_MDR3, priv->mdr3);
+
+		port->rs485_config = serial8250_em485_config;
+		return serial8250_em485_config(port, termios, rs485);
+	}
+
+	rs485->delay_rts_after_send  = fixed_delay_rts_after_send;
+	rs485->delay_rts_before_send = fixed_delay_rts_before_send;
+
+	if (rs485->flags & SER_RS485_ENABLED)
+		priv->mdr3 |= UART_OMAP_MDR3_DIR_EN;
+	else
+		priv->mdr3 &= ~UART_OMAP_MDR3_DIR_EN;
+
+	/*
+	 * Retain same polarity semantics as RS485 software emulation,
+	 * i.e. SER_RS485_RTS_ON_SEND means driving RTS low on send.
+	 */
+	if (rs485->flags & SER_RS485_RTS_ON_SEND)
+		priv->mdr3 &= ~UART_OMAP_MDR3_DIR_POL;
+	else
+		priv->mdr3 |= UART_OMAP_MDR3_DIR_POL;
+
+	serial_out(up, UART_OMAP_MDR3, priv->mdr3);
+
+	return 0;
+}
+
 #ifdef CONFIG_SERIAL_8250_DMA
 static int omap_8250_rx_dma(struct uart_8250_port *p);
 
@@ -1242,7 +1320,7 @@ static struct omap8250_dma_params am33xx_dma = {
 static struct omap8250_platdata am654_platdata = {
 	.dma_params	= &am654_dma,
 	.habit		= UART_HAS_EFR2 | UART_HAS_RHR_IT_DIS |
-			  UART_RX_TIMEOUT_QUIRK,
+			  UART_RX_TIMEOUT_QUIRK | UART_HAS_NATIVE_RS485,
 };
 
 static struct omap8250_platdata am33xx_platdata = {
@@ -1335,7 +1413,8 @@ static int omap8250_probe(struct platform_device *pdev)
 	up.port.shutdown = omap_8250_shutdown;
 	up.port.throttle = omap_8250_throttle;
 	up.port.unthrottle = omap_8250_unthrottle;
-	up.port.rs485_config = serial8250_em485_config;
+	up.port.rs485_config = omap8250_rs485_config;
+	/* same rs485_supported for software emulation and native RS485 */
 	up.port.rs485_supported = serial8250_em485_supported;
 	up.rs485_start_tx = serial8250_em485_start_tx;
 	up.rs485_stop_tx = serial8250_em485_stop_tx;
-- 
2.36.1


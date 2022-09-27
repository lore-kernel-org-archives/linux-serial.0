Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45222C54EE9
	for <linux-serial@archiver.kernel.org>; Tue, 27 Sep 2022 12:10:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229453AbiI0MKo (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 27 Sep 2022 08:10:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230364AbiI0MKm (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 27 Sep 2022 08:10:42 -0400
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [IPv6:2a01:4f8:150:2161:1:b009:f23e:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31A4652E45
        for <linux-serial@vger.kernel.org>; Tue, 27 Sep 2022 05:10:38 -0700 (PDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL TLS DV RSA Mixed SHA256 2020 CA-1" (verified OK))
        by bmailout3.hostsharing.net (Postfix) with ESMTPS id 4F440100D942B;
        Tue, 27 Sep 2022 14:10:36 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 1D08D224CF; Tue, 27 Sep 2022 14:10:36 +0200 (CEST)
Message-Id: <b9f5e4b01f10bb692fc78df668f686dd33d8c036.1664279959.git.lukas@wunner.de>
From:   Lukas Wunner <lukas@wunner.de>
Date:   Tue, 27 Sep 2022 14:10:01 +0200
Subject: [PATCH] serial: 8250: 8250_omap: Support native RS485
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        "Su Bao Cheng" <baocheng.su@siemens.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Nishanth Menon <nm@ti.com>,
        Lino Sanfilippo <LinoSanfilippo@gmx.de>,
        Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Recent TI Sitara SoCs such as AM64/AM65 have gained the ability to
automatically assert RTS when data is transmitted, obviating the need
to emulate this functionality in software.

The feature is controlled through new DIR_EN and DIR_POL bits in the
Mode Definition Register 3.  For details see page 8783 and 8890 of the
AM65 TRM:  https://www.ti.com/lit/ug/spruid7e/spruid7e.pdf

Tested-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Signed-off-by: Lukas Wunner <lukas@wunner.de>
Cc: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Su Bao Cheng <baocheng.su@siemens.com>
Cc: Vignesh Raghavendra <vigneshr@ti.com>
Cc: Nishanth Menon <nm@ti.com>
---
Matthias tested this patch on the AM64 board TQMa6442L + MBaX4XxL:
He says both sending and receiving continue to work.
He's verified via /dev/mem that DIR_EN and DIR_POL bits are set
on an RS485-enabled UART and are not set on other UARTs.
Also RTS polarity is correct and not changed by the patch.

 drivers/tty/serial/8250/8250_omap.c | 67 ++++++++++++++++++++++++++++++++++---
 1 file changed, 62 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
index 68f5a16..e734efe8 100644
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
@@ -345,7 +352,9 @@ static void omap8250_restore_regs(struct uart_8250_port *up)
 
 	up->port.ops->set_mctrl(&up->port, up->port.mctrl);
 
-	if (up->port.rs485.flags & SER_RS485_ENABLED)
+	if (priv->habit & UART_HAS_NATIVE_RS485)
+		serial_out(up, UART_OMAP_MDR3, priv->mdr3);
+	else if (up->port.rs485.flags & SER_RS485_ENABLED)
 		serial8250_em485_stop_tx(up);
 }
 
@@ -793,6 +802,49 @@ static void omap_8250_unthrottle(struct uart_port *port)
 	pm_runtime_put_autosuspend(port->dev);
 }
 
+static int omap8250_rs485_config(struct uart_port *port,
+				 struct ktermios *termios,
+				 struct serial_rs485 *rs485)
+{
+	struct uart_8250_port *up = up_to_u8250p(port);
+	struct omap8250_priv *priv = port->private_data;
+	unsigned int baud;
+
+	/*
+	 * There is a fixed delay of 3 bit clock cycles after the TX shift
+	 * register is going empty to allow time for the stop bit to transition
+	 * through the transceiver before direction is changed to receive.
+	 */
+	if (priv->quot) {
+		if (priv->mdr1 & UART_OMAP_MDR1_16X_MODE)
+			baud = port->uartclk / (16 * priv->quot);
+		else
+			baud = port->uartclk / (13 * priv->quot);
+		rs485->delay_rts_after_send = 3 * MSEC_PER_SEC / baud;
+	} else {
+		rs485->delay_rts_after_send = 0;
+	}
+	rs485->delay_rts_before_send = 0;
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
 
@@ -1242,7 +1294,7 @@ static int omap8250_no_handle_irq(struct uart_port *port)
 static struct omap8250_platdata am654_platdata = {
 	.dma_params	= &am654_dma,
 	.habit		= UART_HAS_EFR2 | UART_HAS_RHR_IT_DIS |
-			  UART_RX_TIMEOUT_QUIRK,
+			  UART_RX_TIMEOUT_QUIRK | UART_HAS_NATIVE_RS485,
 };
 
 static struct omap8250_platdata am33xx_platdata = {
@@ -1335,10 +1387,7 @@ static int omap8250_probe(struct platform_device *pdev)
 	up.port.shutdown = omap_8250_shutdown;
 	up.port.throttle = omap_8250_throttle;
 	up.port.unthrottle = omap_8250_unthrottle;
-	up.port.rs485_config = serial8250_em485_config;
 	up.port.rs485_supported = serial8250_em485_supported;
-	up.rs485_start_tx = serial8250_em485_start_tx;
-	up.rs485_stop_tx = serial8250_em485_stop_tx;
 	up.port.has_sysrq = IS_ENABLED(CONFIG_SERIAL_8250_CONSOLE);
 
 	ret = of_alias_get_id(np, "serial");
@@ -1377,6 +1426,14 @@ static int omap8250_probe(struct platform_device *pdev)
 			 DEFAULT_CLK_SPEED);
 	}
 
+	if (priv->habit & UART_HAS_NATIVE_RS485) {
+		up.port.rs485_config = omap8250_rs485_config;
+	} else {
+		up.port.rs485_config = serial8250_em485_config;
+		up.rs485_start_tx = serial8250_em485_start_tx;
+		up.rs485_stop_tx = serial8250_em485_stop_tx;
+	}
+
 	priv->latency = PM_QOS_CPU_LATENCY_DEFAULT_VALUE;
 	priv->calc_latency = PM_QOS_CPU_LATENCY_DEFAULT_VALUE;
 	cpu_latency_qos_add_request(&priv->pm_qos_request, priv->latency);
-- 
2.36.1


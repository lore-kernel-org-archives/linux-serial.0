Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 991F4C433F5
	for <linux-serial@archiver.kernel.org>; Mon, 22 Nov 2021 17:21:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231737AbhKVRYU (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 22 Nov 2021 12:24:20 -0500
Received: from bmailout2.hostsharing.net ([83.223.78.240]:50187 "EHLO
        bmailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232953AbhKVRYU (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 22 Nov 2021 12:24:20 -0500
X-Greylist: delayed 600 seconds by postgrey-1.27 at vger.kernel.org; Mon, 22 Nov 2021 12:24:19 EST
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "RapidSSL TLS DV RSA Mixed SHA256 2020 CA-1" (verified OK))
        by bmailout2.hostsharing.net (Postfix) with ESMTPS id D7541280248CD;
        Mon, 22 Nov 2021 18:11:10 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id CA5F630CAF5; Mon, 22 Nov 2021 18:11:10 +0100 (CET)
Date:   Mon, 22 Nov 2021 18:11:10 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     Su Bao Cheng <baocheng_su@163.com>
Cc:     Jan Kiszka <jan.kiszka@siemens.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Su Bao Cheng <baocheng.su@siemens.com>,
        linux-serial@vger.kernel.org, chao.zeng@siemens.com
Subject: Re: [PATCH] Revert "serial: 8250: Don't touch RTS modem control
 while in rs485 mode"
Message-ID: <20211122171110.GA4048@wunner.de>
References: <20211027111644.1996921-1-baocheng.su@siemens.com>
 <20211027113938.GA9373@wunner.de>
 <e1a9b9bf-45a4-6e71-09f4-1ae730284778@163.com>
 <20211120171810.GA26621@wunner.de>
 <62d4b8ac-b9a4-3f3a-a5e3-7a3c21ed16f0@siemens.com>
 <20211121174324.GA17258@wunner.de>
 <10469f11-aefc-3b45-b7e1-516c918e4dc2@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10469f11-aefc-3b45-b7e1-516c918e4dc2@163.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, Nov 22, 2021 at 05:01:07PM +0800, Su Bao Cheng wrote:
> The new patch works on our setup.

Thanks for testing.

Actually AM65 supports RS-485 in hardware, so the software emulation
which is currently used isn't necessary.

Below is a tentative, compile-tested only patch to add support for that.
Would you mind giving it a spin and see if it works?  Unfortunately I
can't test it myself.  I do have an AM64 EVM on my desk, but it lacks
an on-board RS-485 transceiver.  (Only the AM65 EVM has one.)

If the RTS pin is controlled by hardware, the delays on assertion and
deassertion of RTS are fixed (cannot be configured).  Also I'm not sure
whether full-duplex (RS-422) works correctly and whether you'll see
your own echo when sending in RS-485 mode.

Thanks!

Lukas

-- >8 --
Subject: [PATCH] serial: 8250: 8250_omap: Support native rs485

Recent TI Sitara SoCs such as AM64/AM65 have gained the ability to
automatically assert RTS when data is transmitted, obviating the need
to emulate this functionality in software.

The feature is controlled through new DIR_EN and DIR_POL bits in the
Mode Definition Register 3.  For details see page 8783 and 8890 of the
AM65 TRM:  https://www.ti.com/lit/ug/spruid7e/spruid7e.pdf

Signed-off-by: Lukas Wunner <lukas@wunner.de>
Cc: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Su Bao Cheng <baocheng.su@siemens.com>
Cc: Vignesh Raghavendra <vigneshr@ti.com>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Nishanth Menon <nm@ti.com>
---
 drivers/tty/serial/8250/8250_omap.c | 73 +++++++++++++++++++++++++++--
 1 file changed, 69 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
index 0fea7bde25ea..46e6c8cb2841 100644
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
@@ -807,6 +813,60 @@ static void omap_8250_unthrottle(struct uart_port *port)
 	pm_runtime_put_autosuspend(port->dev);
 }
 
+static int omap8250_rs485_config(struct uart_port *port,
+				 struct serial_rs485 *rs485)
+{
+	struct uart_8250_port *up = up_to_u8250p(port);
+	struct omap8250_priv *priv = port->private_data;
+	unsigned int baud;
+	u32 reg;
+
+	/* pick sane settings if the user hasn't */
+	if (!!(rs485->flags & SER_RS485_RTS_ON_SEND) ==
+		!!(rs485->flags & SER_RS485_RTS_AFTER_SEND)) {
+		rs485->flags |= SER_RS485_RTS_ON_SEND;
+		rs485->flags &= ~SER_RS485_RTS_AFTER_SEND;
+	}
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
+	memset(rs485->padding, 0, sizeof(rs485->padding));
+	port->rs485 = *rs485;
+
+	gpiod_set_value(port->rs485_term_gpio,
+			rs485->flags & SER_RS485_TERMINATE_BUS);
+
+	reg = serial_in(up, UART_OMAP_MDR3);
+
+	if (rs485->flags & SER_RS485_ENABLED)
+		reg |= UART_OMAP_MDR3_DIR_EN;
+	else
+		reg &= ~UART_OMAP_MDR3_DIR_EN;
+
+	if (rs485->flags & SER_RS485_RTS_ON_SEND)
+		reg |= UART_OMAP_MDR3_DIR_POL;
+	else
+		reg &= ~UART_OMAP_MDR3_DIR_POL;
+
+	serial_out(up, UART_OMAP_MDR3, reg);
+
+	return 0;
+}
+
 #ifdef CONFIG_SERIAL_8250_DMA
 static int omap_8250_rx_dma(struct uart_8250_port *p);
 
@@ -1259,7 +1319,7 @@ static struct omap8250_dma_params am33xx_dma = {
 static struct omap8250_platdata am654_platdata = {
 	.dma_params	= &am654_dma,
 	.habit		= UART_HAS_EFR2 | UART_HAS_RHR_IT_DIS |
-			  UART_RX_TIMEOUT_QUIRK,
+			  UART_RX_TIMEOUT_QUIRK | UART_HAS_NATIVE_RS485,
 };
 
 static struct omap8250_platdata am33xx_platdata = {
@@ -1352,9 +1412,6 @@ static int omap8250_probe(struct platform_device *pdev)
 	up.port.shutdown = omap_8250_shutdown;
 	up.port.throttle = omap_8250_throttle;
 	up.port.unthrottle = omap_8250_unthrottle;
-	up.port.rs485_config = serial8250_em485_config;
-	up.rs485_start_tx = serial8250_em485_start_tx;
-	up.rs485_stop_tx = serial8250_em485_stop_tx;
 	up.port.has_sysrq = IS_ENABLED(CONFIG_SERIAL_8250_CONSOLE);
 
 	ret = of_alias_get_id(np, "serial");
@@ -1393,6 +1450,14 @@ static int omap8250_probe(struct platform_device *pdev)
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
2.33.0


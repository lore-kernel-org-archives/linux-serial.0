Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85442C433FE
	for <linux-serial@archiver.kernel.org>; Thu, 29 Sep 2022 14:44:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235111AbiI2OoZ (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 29 Sep 2022 10:44:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233904AbiI2OoX (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 29 Sep 2022 10:44:23 -0400
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 009867A766
        for <linux-serial@vger.kernel.org>; Thu, 29 Sep 2022 07:44:19 -0700 (PDT)
Received: from tr.lan (ip-86-49-12-201.bb.vodafone.cz [86.49.12.201])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 2E7D384964;
        Thu, 29 Sep 2022 16:44:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1664462657;
        bh=lZsVWdlDp87zr6YxO2r4mdR91XLTEDgddJ2RcHb0Od0=;
        h=From:To:Cc:Subject:Date:From;
        b=YJq6OoeeScGaiSZkJoLqDu561k5KGYxnTeWJtlKx9mBb9tRPsjIRBLfSrK2ift3vo
         +WiNSHOU4KtgfmAgV4dWHCgj62IHGyEpFO67lspee8Mz6lbAFxVw9U+qV0k/2hs1D1
         AG6k3DUO8sUs8wetdnlbm2MSKRGWNwH/7VdsS77H8svgxrG3IxUd9/gsFldT7sqHnr
         r6QwcllaQNmIyYXm8oAU1ESuqHC1P1ZGVq5AwI7dCPzjmW0KUBSddrWqS8hm6JucCu
         UZmwvowgU1w/Tzw9mMla/EwJXinz5p7dY4gKBdln/fLjB56tuBLiKTIRnEorkLgYmh
         QDJrbO+Uc8nQQ==
From:   Marek Vasut <marex@denx.de>
To:     linux-serial@vger.kernel.org
Cc:     Marek Vasut <marex@denx.de>,
        Christoph Niedermaier <cniedermaier@dh-electronics.com>,
        Fabio Estevam <festevam@denx.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Peng Fan <peng.fan@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, kernel@dh-electronics.com,
        kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2] tty: serial: imx: Handle RS485 DE signal active high
Date:   Thu, 29 Sep 2022 16:44:00 +0200
Message-Id: <20220929144400.13571-1-marex@denx.de>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.6 at phobos.denx.de
X-Virus-Status: Clean
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The default polarity of RS485 DE signal is active high. This driver does
not handle such case properly. Currently, when a pin is multiplexed as a
UART CTS_B on boot, this pin is pulled HIGH by the i.MX UART CTS circuit,
which activates DE signal on the RS485 transceiver and thus behave as if
the RS485 was transmitting data, so the system blocks the RS485 bus when
it starts and until user application takes over. This behavior is not OK.
The problem consists of two separate parts.

First, the i.MX UART IP requires UCR1 UARTEN and UCR2 RXEN to be set for
UCR2 CTSC and CTS bits to have any effect. The UCR2 CTSC bit permits the
driver to set CTS (RTS_B or RS485 DE signal) to either level sychronous
to the internal UART IP clock. Compared to other options, like GPIO CTS
control, this has the benefit of being synchronous to the UART IP clock
and thus without glitches or bus delays. The reason for the CTS design
is likely because when the Receiver is disabled, the UART IP can never
indicate that it is ready to receive data by assering CTS signal, so
the CTS is always pulled HIGH by default.

When the port is closed by user space, imx_uart_stop_rx() clears UCR2
RXEN bit, and imx_uart_shutdown() clears UCR1 UARTEN bit. This disables
UART Receiver and UART itself, and forces CTS signal HIGH, which leads
to the RS485 bus being blocked because RS485 DE is incorrectly active.

The proposed solution for this problem is to keep the Receiver running
even after the port is closed, but in loopback mode. This disconnects
the RX FIFO input from the RXD external signal, and since UCR2 TXEN is
cleared, the UART Transmitter is disabled, so nothing can feed data in
the RX FIFO. Because the Receiver is still enabled, the UCR2 CTSC and
CTS bits still have effect and the CTS (RS485 DE) control is retained.

Note that in case of RS485 DE signal active low, there is no problem and
no special handling is necessary. The CTS signal defaults to HIGH, thus
the RS485 is by default set to Receive and the bus is not blocked.

Note that while there is the possibility to control CTS using GPIO with
either CTS polarity, this has the downside of not being synchronous to
the UART IP clock and thus glitchy and susceptible to slow DE switching.

Second, on boot, before the UART driver probe callback is called, the
driver core triggers pinctrl_init_done() and configures the IOMUXC to
default state. At this point, UCR1 UARTEN and UCR2 RXEN are both still
cleared, but UART CTS_B (RS485 DE) is configured as CTS function, thus
the RTS signal is pulled HIGH by the UART IP CTS circuit.

One part of the solution here is to enable UCR1 UARTEN and UCR2 RXEN and
UTS loopback in this driver probe callback, thus unblocking the CTSC and
CTS control early on. But this is still too late, since the pin control
is already configured and CTS has been pulled HIGH for a short period
of time.

When Linux kernel boots and this driver is bound, the pin control is set
to special "init" state if the state is available, and driver can switch
the "default" state afterward when ready. This state can be used to set
the CTS line as a GPIO in DT temporarily, and a GPIO hog can force such
GPIO to LOW, thus keeping the RS485 DE line LOW early on boot. Once the
driver takes over and UCR1 UARTEN and UCR2 RXEN and UTS loopback are all
enabled, the driver can switch to "default" pin control state and control
the CTS line as function instead. DT binding example is below:

"
&gpio6 {
  rts-init-hog {
    gpio-hog;
    gpios = <5 0>;
    output-low;
    line-name = "rs485-de";
  };
};

&uart5 { /* DHCOM UART2 */
  pinctrl-0 = <&pinctrl_uart5>;
  pinctrl-1 = <&pinctrl_uart5_init>;
  pinctrl-names = "default", "init";
  ...
};
pinctrl_uart5_init: uart5-init-grp {
  fsl,pins = <
...
    MX6QDL_PAD_CSI0_DAT19__GPIO6_IO05       0x30b1
  >;
};

pinctrl_uart5: uart5-grp {
  fsl,pins = <
...
    MX6QDL_PAD_CSI0_DAT19__UART5_CTS_B      0x30b1
  >;
};
"

Tested-by: Christoph Niedermaier <cniedermaier@dh-electronics.com>
Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: Christoph Niedermaier <cniedermaier@dh-electronics.com>
Cc: Fabio Estevam <festevam@denx.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>
Cc: NXP Linux Team <linux-imx@nxp.com>
Cc: Peng Fan <peng.fan@nxp.com>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Cc: kernel@dh-electronics.com
Cc: kernel@pengutronix.de
Cc: linux-arm-kernel@lists.infradead.org
To: linux-serial@vger.kernel.org
---
V2: - Add code comments per input from Uwe
    - Add TB from Christoph
---
 drivers/tty/serial/imx.c | 64 ++++++++++++++++++++++++++++++++++++----
 1 file changed, 58 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 05b432dc7a85c..18f5da561f4a1 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -489,7 +489,7 @@ static void imx_uart_stop_tx(struct uart_port *port)
 static void imx_uart_stop_rx(struct uart_port *port)
 {
 	struct imx_port *sport = (struct imx_port *)port;
-	u32 ucr1, ucr2, ucr4;
+	u32 ucr1, ucr2, ucr4, uts;
 
 	ucr1 = imx_uart_readl(sport, UCR1);
 	ucr2 = imx_uart_readl(sport, UCR2);
@@ -505,7 +505,18 @@ static void imx_uart_stop_rx(struct uart_port *port)
 	imx_uart_writel(sport, ucr1, UCR1);
 	imx_uart_writel(sport, ucr4, UCR4);
 
-	ucr2 &= ~UCR2_RXEN;
+	/* See SER_RS485_ENABLED/UTS_LOOP comment in imx_uart_probe() */
+	if (port->rs485.flags & SER_RS485_ENABLED &&
+	    port->rs485.flags & SER_RS485_RTS_ON_SEND &&
+	    sport->have_rtscts && !sport->have_rtsgpio) {
+		uts = imx_uart_readl(sport, imx_uart_uts_reg(sport));
+		uts |= UTS_LOOP;
+		imx_uart_writel(sport, uts, imx_uart_uts_reg(sport));
+		ucr2 |= UCR2_RXEN;
+	} else {
+		ucr2 &= ~UCR2_RXEN;
+	}
+
 	imx_uart_writel(sport, ucr2, UCR2);
 }
 
@@ -1393,7 +1404,7 @@ static int imx_uart_startup(struct uart_port *port)
 	int retval, i;
 	unsigned long flags;
 	int dma_is_inited = 0;
-	u32 ucr1, ucr2, ucr3, ucr4;
+	u32 ucr1, ucr2, ucr3, ucr4, uts;
 
 	retval = clk_prepare_enable(sport->clk_per);
 	if (retval)
@@ -1498,6 +1509,11 @@ static int imx_uart_startup(struct uart_port *port)
 		imx_uart_writel(sport, ucr2, UCR2);
 	}
 
+	/* See SER_RS485_ENABLED/UTS_LOOP comment in imx_uart_probe() */
+	uts = imx_uart_readl(sport, imx_uart_uts_reg(sport));
+	uts &= ~UTS_LOOP;
+	imx_uart_writel(sport, uts, imx_uart_uts_reg(sport));
+
 	spin_unlock_irqrestore(&sport->port.lock, flags);
 
 	return 0;
@@ -1507,7 +1523,7 @@ static void imx_uart_shutdown(struct uart_port *port)
 {
 	struct imx_port *sport = (struct imx_port *)port;
 	unsigned long flags;
-	u32 ucr1, ucr2, ucr4;
+	u32 ucr1, ucr2, ucr4, uts;
 
 	if (sport->dma_is_enabled) {
 		dmaengine_terminate_sync(sport->dma_chan_tx);
@@ -1551,7 +1567,18 @@ static void imx_uart_shutdown(struct uart_port *port)
 	spin_lock_irqsave(&sport->port.lock, flags);
 
 	ucr1 = imx_uart_readl(sport, UCR1);
-	ucr1 &= ~(UCR1_TRDYEN | UCR1_RRDYEN | UCR1_RTSDEN | UCR1_UARTEN | UCR1_RXDMAEN | UCR1_ATDMAEN);
+	ucr1 &= ~(UCR1_TRDYEN | UCR1_RRDYEN | UCR1_RTSDEN | UCR1_RXDMAEN | UCR1_ATDMAEN);
+	/* See SER_RS485_ENABLED/UTS_LOOP comment in imx_uart_probe() */
+	if (port->rs485.flags & SER_RS485_ENABLED &&
+	    port->rs485.flags & SER_RS485_RTS_ON_SEND &&
+	    sport->have_rtscts && !sport->have_rtsgpio) {
+		uts = imx_uart_readl(sport, imx_uart_uts_reg(sport));
+		uts |= UTS_LOOP;
+		imx_uart_writel(sport, uts, imx_uart_uts_reg(sport));
+		ucr1 |= UCR1_UARTEN;
+	} else {
+		ucr1 &= ~UCR1_UARTEN;
+	}
 	imx_uart_writel(sport, ucr1, UCR1);
 
 	ucr4 = imx_uart_readl(sport, UCR4);
@@ -2213,7 +2240,7 @@ static int imx_uart_probe(struct platform_device *pdev)
 	void __iomem *base;
 	u32 dma_buf_conf[2];
 	int ret = 0;
-	u32 ucr1;
+	u32 ucr1, ucr2, uts;
 	struct resource *res;
 	int txirq, rxirq, rtsirq;
 
@@ -2350,6 +2377,31 @@ static int imx_uart_probe(struct platform_device *pdev)
 	ucr1 &= ~(UCR1_ADEN | UCR1_TRDYEN | UCR1_IDEN | UCR1_RRDYEN | UCR1_RTSDEN);
 	imx_uart_writel(sport, ucr1, UCR1);
 
+	/*
+	 * In case RS485 is enabled without GPIO RTS control, the UART IP
+	 * is used to control CTS signal. Keep both the UART and Receiver
+	 * enabled, otherwise the UART IP pulls CTS signal always HIGH no
+	 * matter how the UCR2 CTSC and CTS bits are set. To prevent any
+	 * data from being fed into the RX FIFO, enable loopback mode in
+	 * UTS register, which disconnects the RX path from external RXD
+	 * pin and connects it to the Transceiver, which is disabled, so
+	 * no data can be fed to the RX FIFO that way.
+	 */
+	if (sport->port.rs485.flags & SER_RS485_ENABLED &&
+	    sport->have_rtscts && !sport->have_rtsgpio) {
+		uts = imx_uart_readl(sport, imx_uart_uts_reg(sport));
+		uts |= UTS_LOOP;
+		imx_uart_writel(sport, uts, imx_uart_uts_reg(sport));
+
+		ucr1 = imx_uart_readl(sport, UCR1);
+		ucr1 |= UCR1_UARTEN;
+		imx_uart_writel(sport, ucr1, UCR1);
+
+		ucr2 = imx_uart_readl(sport, UCR2);
+		ucr2 |= UCR2_RXEN;
+		imx_uart_writel(sport, ucr2, UCR2);
+	}
+
 	if (!imx_uart_is_imx1(sport) && sport->dte_mode) {
 		/*
 		 * The DCEDTE bit changes the direction of DSR, DCD, DTR and RI
-- 
2.35.1


From: Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>
Subject: [PATCH 3/3] tty: serial: fsl_lpuart: Add support for RS-485
Date: Fri, 29 May 2015 13:35:54 +0530
Message-ID: <1432886754-30115-4-git-send-email-bhuvanchandra.dv@toradex.com>
References: <1432886754-30115-1-git-send-email-bhuvanchandra.dv@toradex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1432886754-30115-1-git-send-email-bhuvanchandra.dv@toradex.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: gregkh@linuxfoundation.org
Cc: devicetree@vger.kernel.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, stefan@agner.ch, bhuvanchandra.dv@gmail.com, kernel@pengutronix.de, shawn.guo@linaro.org, jslaby@suse.cz, linux-arm-kernel@lists.infradead.org, Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>
List-Id: linux-serial@vger.kernel.org

Enable Vybrid's build-in support for RS-485 auto RTS for
controlling line direction of RS-485 transceiver driver.

Signed-off-by: Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>
---
 drivers/tty/serial/fsl_lpuart.c | 60 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index 357f623..c553b14 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -820,6 +820,50 @@ static unsigned int lpuart32_tx_empty(struct uart_port *port)
 		TIOCSER_TEMT : 0;
 }
 
+static int lpuart_config_rs485(struct uart_port *port,
+			struct serial_rs485 *rs485)
+{
+	struct lpuart_port *sport = container_of(port,
+			struct lpuart_port, port);
+	u8 modem = readb(sport->port.membase + UARTMODEM) &
+		~(UARTMODEM_TXRTSPOL | UARTMODEM_TXRTSE);
+	writeb(modem, sport->port.membase + UARTMODEM);
+
+	if (rs485->flags & SER_RS485_ENABLED) {
+		/* Enable auto RS-485 RTS mode */
+		modem |= UARTMODEM_TXRTSE;
+
+		/*
+		* RTS needs to be logic HIGH either during transer _or_ after
+		* transfer, other variants are not supported by the hardware.
+		*/
+		if (!(rs485->flags & (SER_RS485_RTS_ON_SEND |
+				SER_RS485_RTS_AFTER_SEND)))
+			rs485->flags |= SER_RS485_RTS_ON_SEND;
+
+		if (rs485->flags & SER_RS485_RTS_ON_SEND &&
+				rs485->flags & SER_RS485_RTS_AFTER_SEND)
+			rs485->flags &= ~SER_RS485_RTS_AFTER_SEND;
+
+		/*
+		* The hardware defaults to RTS logic HIGH while transfer.
+		* Switch polarity in case RTS shall be logic HIGH
+		* after transfer.
+		* Note: UART is assumed to be active high.
+		*/
+		if (rs485->flags & SER_RS485_RTS_ON_SEND)
+			modem &= ~UARTMODEM_TXRTSPOL;
+		else if (rs485->flags & SER_RS485_RTS_AFTER_SEND)
+			modem |= UARTMODEM_TXRTSPOL;
+	}
+
+	/* Store the new configuration */
+	sport->port.rs485 = *rs485;
+
+	writeb(modem, sport->port.membase + UARTMODEM);
+	return 0;
+}
+
 static unsigned int lpuart_get_mctrl(struct uart_port *port)
 {
 	return TIOCM_CAR | TIOCM_CTS | TIOCM_DSR;
@@ -1204,6 +1248,12 @@ lpuart_set_termios(struct uart_port *port, struct ktermios *termios,
 		cr1 |= UARTCR1_M;
 	}
 
+	/* When auto RS-485 RTS mode is enabled,
+	 * hardware flow control need to be disabled.
+	 */
+	if (sport->port.rs485.flags & SER_RS485_ENABLED)
+		termios->c_cflag &= ~CRTSCTS;
+
 	if (termios->c_cflag & CRTSCTS) {
 		modem |= (UARTMODEM_RXRTSE | UARTMODEM_TXCTSE);
 	} else {
@@ -1762,6 +1812,8 @@ static int lpuart_probe(struct platform_device *pdev)
 		sport->port.ops = &lpuart_pops;
 	sport->port.flags = UPF_BOOT_AUTOCONF;
 
+	sport->port.rs485_config = lpuart_config_rs485;
+
 	sport->clk = devm_clk_get(&pdev->dev, "ipg");
 	if (IS_ERR(sport->clk)) {
 		ret = PTR_ERR(sport->clk);
@@ -1802,6 +1854,14 @@ static int lpuart_probe(struct platform_device *pdev)
 		dev_info(sport->port.dev, "DMA rx channel request failed, "
 				"operating without rx DMA\n");
 
+	if (of_property_read_bool(np, "linux,rs485-enabled-at-boot-time")) {
+		sport->port.rs485.flags |= SER_RS485_ENABLED;
+		sport->port.rs485.flags |= SER_RS485_RTS_ON_SEND;
+		writeb(UARTMODEM_TXRTSE, sport->port.membase + UARTMODEM);
+	} else {
+		sport->port.rs485.flags &= ~SER_RS485_ENABLED;
+	}
+
 	return 0;
 }
 
-- 
2.1.0

From: Stefan Agner <stefan@agner.ch>
Subject: [PATCH] serial: imx: warn user when using unsupported configuration
Date: Wed, 18 Apr 2018 15:32:17 +0200
Message-ID: <20180418133217.14568-1-stefan@agner.ch>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, u.kleine-koenig@pengutronix.de
Cc: lukas@wunner.de, jslaby@suse.com, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Stefan Agner <stefan@agner.ch>
List-Id: linux-serial@vger.kernel.org

When using half-duplex mode (which disables receiver during txing)
the RTS signal cannot be driven low during transmission. This seems
to be a limitation of the i.MX UART IP: The RTS (CTS_B) signal is
controlled by the receiver. When the receiver is disabled, the
signal stays in UART logic idle state which is high...

If SER_RS485_RTS_ON_SEND is used, RTS needs to be high active during
transmission. Since this is the default state of the RTS (CTS_B)
signal when the receiver is off, half-duplex mode in this
configuration works fine.

However, a low-active RTS signal (flag SER_RS485_RTS_ON_SEND not set)
cannot be generated when the receiver is turned off.

Print an error if the user selects this unsupported configuration
(both SER_RS485_RTS_ON_SEND and SER_RS485_RX_DURING_TX unset) and
configure the closest working configuration (set the
SER_RS485_RX_DURING_TX flag).

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 drivers/tty/serial/imx.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 91f3a1a5cb7f..1ba7e98ddc76 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -1833,6 +1833,10 @@ static int imx_uart_rs485_config(struct uart_port *port,
 		rs485conf->flags &= ~SER_RS485_ENABLED;
 
 	if (rs485conf->flags & SER_RS485_ENABLED) {
+		/* Enable receiver if low-active RTS signal is requested */
+		if (rs485conf->flags & SER_RS485_RTS_AFTER_SEND)
+			rs485conf->flags |= SER_RS485_RX_DURING_TX;
+
 		/* disable transmitter */
 		ucr2 = imx_uart_readl(sport, UCR2);
 		if (rs485conf->flags & SER_RS485_RTS_AFTER_SEND)
@@ -2265,6 +2269,17 @@ static int imx_uart_probe(struct platform_device *pdev)
 	    (!sport->have_rtscts && !sport->have_rtsgpio))
 		dev_err(&pdev->dev, "no RTS control, disabling rs485\n");
 
+	/*
+	 * The RTS (CTS_B) signal cannot be set low during transmission
+	 * in case the receiver is off (limitation of the i.MX UART IP).
+	 */
+	if (sport->port.rs485.flags & SER_RS485_ENABLED && sport->have_rtscts &&
+	    (!(sport->port.rs485.flags & SER_RS485_RTS_ON_SEND) &&
+	     !(sport->port.rs485.flags & SER_RS485_RX_DURING_TX)))
+		dev_err(&pdev->dev,
+			"low-active RTS not possible when receiver is off, "
+			"enabling receiver\n");
+
 	imx_uart_rs485_config(&sport->port, &sport->port.rs485);
 
 	/* Disable interrupts before requesting them */
-- 
2.17.0

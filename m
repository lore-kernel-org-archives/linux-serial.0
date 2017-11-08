From: Lukas Wunner <lukas-JFq808J9C/izQB+pC5nmwQ@public.gmane.org>
Subject: [PATCH 4/5] serial: fsl_lpuart: Support common rs485 binding for RTS
 polarity
Date: Wed, 8 Nov 2017 11:32:34 +0100
Message-ID: <f9aafa4cf0622114799fddddafa0073a2789b6e7.1510134353.git.lukas@wunner.de>
References: <cover.1510134353.git.lukas@wunner.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1510134353.git.lukas-JFq808J9C/izQB+pC5nmwQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
Cc: Jiri Slaby <jslaby-IBi9RG/b67k@public.gmane.org>, Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Uwe Kleine-Koenig <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Mark Jackson <mpfj-2FZW7xY0fHgqdlJmJB21zg@public.gmane.org>, Michal Oleszczyk <oleszczyk.m-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-serial@vger.kernel.org

Invoke the ->rs485_config callback on probe to set UARTMODEM_TXRTSPOL
appropriately based on the UART's device properties.

This implicitly sets UARTMODEM_TXRTSE if rs485 was enabled in the device
properties, so drop the identical code from lpuart_probe().

It also fixes a bug:  If an unsupported rs485 property was specified
(rs485-rx-during-tx or rs485-rts-delay), the driver returns -ENOSYS
without performing any cleanup, in particular without calling
uart_remove_one_port() or clk_disable_unprepare(), thus leaking the
uart_port. But with the invocation of ->rs485_config, the unsupported
properties are now cleared in struct serial_rs485 and thus ignored.
It therefore seems sufficient to just log an error instead of bailing
out.

Cc: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Uwe Kleine-König <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Signed-off-by: Lukas Wunner <lukas-JFq808J9C/izQB+pC5nmwQ@public.gmane.org>
---
 drivers/tty/serial/fsl_lpuart.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index 009eb3f18a81..fbb8c3ce470b 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -2213,21 +2213,14 @@ static int lpuart_probe(struct platform_device *pdev)
 
 	uart_get_rs485_mode(&pdev->dev, &sport->port.rs485);
 
-	if (sport->port.rs485.flags & SER_RS485_RX_DURING_TX) {
+	if (sport->port.rs485.flags & SER_RS485_RX_DURING_TX)
 		dev_err(&pdev->dev, "driver doesn't support RX during TX\n");
-		return -ENOSYS;
-	}
 
 	if (sport->port.rs485.delay_rts_before_send ||
-	    sport->port.rs485.delay_rts_after_send) {
+	    sport->port.rs485.delay_rts_after_send)
 		dev_err(&pdev->dev, "driver doesn't support RTS delays\n");
-		return -ENOSYS;
-	}
 
-	if (sport->port.rs485.flags & SER_RS485_ENABLED) {
-		sport->port.rs485.flags |= SER_RS485_RTS_ON_SEND;
-		writeb(UARTMODEM_TXRTSE, sport->port.membase + UARTMODEM);
-	}
+	lpuart_config_rs485(&sport->port, &sport->port.rs485);
 
 	sport->dma_tx_chan = dma_request_slave_channel(sport->port.dev, "tx");
 	if (!sport->dma_tx_chan)
-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

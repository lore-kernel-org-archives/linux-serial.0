From: Andrey Smirnov <andrew.smirnov@gmail.com>
Subject: [PATCH] tty: serial: fsl_lpuart: Fix lpuart_flush_buffer()
Date: Fri,  4 Oct 2019 14:55:37 -0700
Message-ID: <20191004215537.5308-1-andrew.smirnov@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>, Stefan Agner <stefan@agner.ch>, Andrew Lunn <andrew@lunn.ch>, Vivien Didelot <vivien.didelot@gmail.com>, Chris Healy <cphealy@gmail.com>, Cory Tusar <cory.tusar@zii.aero>, Lucas Stach <l.stach@pengutronix.de>, Jiri Slaby <jslaby@suse.com>, linux-imx@nxp.com, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Fix incorrect read-modify-write sequence in lpuart_flush_buffer() that
was reading from UARTPFIFO and writing to UARTCFIFO instead of
operating solely on the latter.

Fixes: 9bc19af9dacb ("tty: serial: fsl_lpuart: Flush HW FIFOs in .flush_buffer")
Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Stefan Agner <stefan@agner.ch>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Vivien Didelot <vivien.didelot@gmail.com>
Cc: Chris Healy <cphealy@gmail.com>
Cc: Cory Tusar <cory.tusar@zii.aero>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>
Cc: linux-imx@nxp.com
Cc: linux-serial@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---

Greg:

This bug causes occasional boot hang on 5.4-rc1 on Vybrid, so it might
be good to push that for 5.4-rc2.

Thanks,
Andrey Sirnov

 drivers/tty/serial/fsl_lpuart.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index 3e17bb8a0b16..537896c4d887 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -548,7 +548,7 @@ static void lpuart_flush_buffer(struct uart_port *port)
 		val |= UARTFIFO_TXFLUSH | UARTFIFO_RXFLUSH;
 		lpuart32_write(&sport->port, val, UARTFIFO);
 	} else {
-		val = readb(sport->port.membase + UARTPFIFO);
+		val = readb(sport->port.membase + UARTCFIFO);
 		val |= UARTCFIFO_TXFLUSH | UARTCFIFO_RXFLUSH;
 		writeb(val, sport->port.membase + UARTCFIFO);
 	}
-- 
2.21.0

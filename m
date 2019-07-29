From: Andrey Smirnov <andrew.smirnov@gmail.com>
Subject: [PATCH 22/24] tty: serial: fsl_lpuart: Introduce lpuart*_setup_watermark_enable()
Date: Mon, 29 Jul 2019 12:52:24 -0700
Message-ID: <20190729195226.8862-23-andrew.smirnov@gmail.com>
References: <20190729195226.8862-1-andrew.smirnov@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190729195226.8862-1-andrew.smirnov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>, Stefan Agner <stefan@agner.ch>, Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>, Chris Healy <cphealy@gmail.com>, Cory Tusar <cory.tusar@zii.aero>, Lucas Stach <l.stach@pengutronix.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-imx@nxp.com, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Most users of lpuart*_setup_watermark() enable identical set of flags
right after the call, so combine those two action into a subroutine
and make use of it.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Stefan Agner <stefan@agner.ch>
Cc: Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>
Cc: Chris Healy <cphealy@gmail.com>
Cc: Cory Tusar <cory.tusar@zii.aero>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>
Cc: linux-imx@nxp.com
Cc: linux-serial@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/tty/serial/fsl_lpuart.c | 50 ++++++++++++++++++---------------
 1 file changed, 28 insertions(+), 22 deletions(-)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index 112fb1e19a1c..9643d4524e59 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -1402,6 +1402,17 @@ static void lpuart_setup_watermark(struct lpuart_port *sport)
 	writeb(cr2_saved, sport->port.membase + UARTCR2);
 }
 
+static void lpuart_setup_watermark_enable(struct lpuart_port *sport)
+{
+	unsigned char cr2;
+
+	lpuart_setup_watermark(sport);
+
+	cr2 = readb(sport->port.membase + UARTCR2);
+	cr2 |= UARTCR2_RIE | UARTCR2_TIE | UARTCR2_RE | UARTCR2_TE;
+	writeb(cr2, sport->port.membase + UARTCR2);
+}
+
 static void lpuart32_setup_watermark(struct lpuart_port *sport)
 {
 	unsigned long val, ctrl;
@@ -1427,6 +1438,17 @@ static void lpuart32_setup_watermark(struct lpuart_port *sport)
 	lpuart32_write(&sport->port, ctrl_saved, UARTCTRL);
 }
 
+static void lpuart32_setup_watermark_enable(struct lpuart_port *sport)
+{
+	u32 temp;
+
+	lpuart32_setup_watermark(sport);
+
+	temp = lpuart32_read(&sport->port, UARTCTRL);
+	temp |= UARTCTRL_RE | UARTCTRL_TE | UARTCTRL_ILIE;
+	lpuart32_write(&sport->port, temp, UARTCTRL);
+}
+
 static void rx_dma_timer_init(struct lpuart_port *sport)
 {
 	timer_setup(&sport->lpuart_timer, lpuart_timer_func, 0);
@@ -1488,11 +1510,7 @@ static int lpuart_startup(struct uart_port *port)
 
 	spin_lock_irqsave(&sport->port.lock, flags);
 
-	lpuart_setup_watermark(sport);
-
-	temp = readb(sport->port.membase + UARTCR2);
-	temp |= UARTCR2_RIE | UARTCR2_TIE | UARTCR2_RE | UARTCR2_TE;
-	writeb(temp, sport->port.membase + UARTCR2);
+	lpuart_setup_watermark_enable(sport);
 
 	lpuart_rx_dma_startup(sport);
 	lpuart_tx_dma_startup(port);
@@ -1539,11 +1557,7 @@ static int lpuart32_startup(struct uart_port *port)
 
 	spin_lock_irqsave(&sport->port.lock, flags);
 
-	lpuart32_setup_watermark(sport);
-
-	temp = lpuart32_read(&sport->port, UARTCTRL);
-	temp |= UARTCTRL_RE | UARTCTRL_TE | UARTCTRL_ILIE;
-	lpuart32_write(&sport->port, temp, UARTCTRL);
+	lpuart32_setup_watermark_enable(sport);
 
 	lpuart_rx_dma_startup(sport);
 	lpuart_tx_dma_startup(port);
@@ -2561,22 +2575,14 @@ static int lpuart_resume(struct device *dev)
 {
 	struct lpuart_port *sport = dev_get_drvdata(dev);
 	bool irq_wake = irqd_is_wakeup_set(irq_get_irq_data(sport->port.irq));
-	unsigned long temp;
 
 	if (sport->port.suspended && !irq_wake)
 		lpuart_enable_clks(sport);
 
-	if (lpuart_is_32(sport)) {
-		lpuart32_setup_watermark(sport);
-		temp = lpuart32_read(&sport->port, UARTCTRL);
-		temp |= UARTCTRL_RE | UARTCTRL_TE | UARTCTRL_ILIE;
-		lpuart32_write(&sport->port, temp, UARTCTRL);
-	} else {
-		lpuart_setup_watermark(sport);
-		temp = readb(sport->port.membase + UARTCR2);
-		temp |= UARTCR2_RIE | UARTCR2_TIE | UARTCR2_RE | UARTCR2_TE;
-		writeb(temp, sport->port.membase + UARTCR2);
-	}
+	if (lpuart_is_32(sport))
+		lpuart32_setup_watermark_enable(sport);
+	else
+		lpuart_setup_watermark_enable(sport);
 
 	if (sport->lpuart_dma_rx_use) {
 		if (irq_wake) {
-- 
2.21.0

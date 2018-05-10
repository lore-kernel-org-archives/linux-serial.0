From: Phil Edworthy <phil.edworthy@renesas.com>
Subject: [PATCH] serial: 8250_dw: Fix runtime PM handling
Date: Thu, 10 May 2018 15:13:56 +0100
Message-ID: <1525961636-6359-1-git-send-email-phil.edworthy@renesas.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>, Joshua Scott <joshua.scott@alliedtelesis.co.nz>, Philipp Zabel <p.zabel@pengutronix.de>, Stefan Potyra <Stefan.Potyra@elektrobit.com>, Ed Blake <ed.blake@sondrel.com>, Michel Pollet <michel.pollet@bp.renesas.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Phil Edworthy <phil.edworthy@renesas.com>
List-Id: linux-serial@vger.kernel.org

When using kgdb, you get an abort when accessing the UART registers.
This is because the driver has already entered runtime PM and so turned
off the bus clock needed to access the registers.

To fix this, set the capability indicating Runtime PM is active while idle.

Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
---
 drivers/tty/serial/8250/8250_dw.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index 0529b5c..aff04f1 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -576,6 +576,10 @@ static int dw8250_probe(struct platform_device *pdev)
 	if (!data->skip_autocfg)
 		dw8250_setup_port(p);
 
+#ifdef CONFIG_PM
+	uart.capabilities |= UART_CAP_RPM;
+#endif
+
 	/* If we have a valid fifosize, try hooking up DMA */
 	if (p->fifosize) {
 		data->dma.rxconf.src_maxburst = p->fifosize / 4;
-- 
2.7.4

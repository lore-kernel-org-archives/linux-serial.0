From: Maxime Bizon <mbizon@freebox.fr>
Subject: [PATCH 2/2] bcm63xx_uart: allow more than one uart to be registered.
Date: Sat, 30 Jan 2010 18:42:57 +0100
Message-ID: <1264873377-28479-3-git-send-email-mbizon@freebox.fr>
References: <1264873377-28479-1-git-send-email-mbizon@freebox.fr>
Return-path: <linux-mips-bounce@linux-mips.org>
In-Reply-To: <1264873377-28479-1-git-send-email-mbizon@freebox.fr>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
To: Greg Kroah-Hartman <gregkh@suse.de>, linux-serial@vger.kernel.org
Cc: Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org, Maxime Bizon <mbizon@freebox.fr>
List-Id: linux-serial@vger.kernel.org

The bcm6358 CPU has two uarts, make it possible to use the second one.

Signed-off-by: Maxime Bizon <mbizon@freebox.fr>
---
 drivers/serial/bcm63xx_uart.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/serial/bcm63xx_uart.c b/drivers/serial/bcm63xx_uart.c
index f78ede8..6ab959a 100644
--- a/drivers/serial/bcm63xx_uart.c
+++ b/drivers/serial/bcm63xx_uart.c
@@ -35,7 +35,7 @@
 #include <bcm63xx_regs.h>
 #include <bcm63xx_io.h>
 
-#define BCM63XX_NR_UARTS	1
+#define BCM63XX_NR_UARTS	2
 
 static struct uart_port ports[BCM63XX_NR_UARTS];
 
@@ -784,7 +784,7 @@ static struct uart_driver bcm_uart_driver = {
 	.dev_name	= "ttyS",
 	.major		= TTY_MAJOR,
 	.minor		= 64,
-	.nr		= 1,
+	.nr		= 2,
 	.cons		= BCM63XX_CONSOLE,
 };
 
@@ -826,6 +826,7 @@ static int __devinit bcm_uart_probe(struct platform_device *pdev)
 	port->dev = &pdev->dev;
 	port->fifosize = 16;
 	port->uartclk = clk_get_rate(clk) / 2;
+	port->line = pdev->id;
 	clk_put(clk);
 
 	ret = uart_add_one_port(&bcm_uart_driver, port);
-- 
1.6.3.3

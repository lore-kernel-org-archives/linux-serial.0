From: Timur Tabi <timur@codeaurora.org>
Subject: [PATCH] [v2] serial: amba-pl011: use cpu_relax when polling registers
Date: Fri, 15 Jan 2016 14:32:20 -0600
Message-ID: <1452889940-19594-1-git-send-email-timur@codeaurora.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Greg Kroah-Hartman <greg@kroah.com>, Russell King <rmk+kernel@arm.linux.org.uk>, Andrew.Jackson@arm.com, andre.przywara@arm.com, jun.nie@linaro.org, peter@hurleysoftware.com, Linus Walleij <linus.walleij@linaro.org>, jslaby@suse.com, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Busy loops that poll on a register should call cpu_relax().  On some
architectures, it can lower CPU power consumption or yield to a
hyperthreaded twin processor.  It also serves as a compiler barrier,
so it can replace barrier() calls.

Signed-off-by: Timur Tabi <timur@codeaurora.org>
---

v2: rebased to latest code

 drivers/tty/serial/amba-pl011.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index c0da0cc..69b5acd 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -1167,7 +1167,7 @@ static void pl011_dma_shutdown(struct uart_amba_port *uap)
 
 	/* Disable RX and TX DMA */
 	while (pl011_read(uap, REG_FR) & UART01x_FR_BUSY)
-		barrier();
+		cpu_relax();
 
 	spin_lock_irq(&uap->port.lock);
 	uap->dmacr &= ~(UART011_DMAONERR | UART011_RXDMAE | UART011_TXDMAE);
@@ -1611,7 +1611,7 @@ static void pl011_put_poll_char(struct uart_port *port,
 	    container_of(port, struct uart_amba_port, port);
 
 	while (pl011_read(uap, REG_FR) & UART01x_FR_TXFF)
-		barrier();
+		cpu_relax();
 
 	pl011_write(ch, uap, REG_DR);
 }
@@ -2150,7 +2150,7 @@ static void pl011_console_putchar(struct uart_port *port, int ch)
 	    container_of(port, struct uart_amba_port, port);
 
 	while (pl011_read(uap, REG_FR) & UART01x_FR_TXFF)
-		barrier();
+		cpu_relax();
 	pl011_write(ch, uap, REG_DR);
 }
 
@@ -2158,7 +2158,7 @@ static void
 pl011_console_write(struct console *co, const char *s, unsigned int count)
 {
 	struct uart_amba_port *uap = amba_ports[co->index];
-	unsigned int status, old_cr = 0, new_cr;
+	unsigned int old_cr = 0, new_cr;
 	unsigned long flags;
 	int locked = 1;
 
@@ -2188,9 +2188,8 @@ pl011_console_write(struct console *co, const char *s, unsigned int count)
 	 *	Finally, wait for transmitter to become empty
 	 *	and restore the TCR
 	 */
-	do {
-		status = pl011_read(uap, REG_FR);
-	} while (status & UART01x_FR_BUSY);
+	while (pl011_read(uap, REG_FR) & UART01x_FR_BUSY)
+		cpu_relax();
 	if (!uap->vendor->always_enabled)
 		pl011_write(old_cr, uap, REG_CR);
 
@@ -2302,13 +2301,13 @@ static struct console amba_console = {
 static void pl011_putc(struct uart_port *port, int c)
 {
 	while (readl(port->membase + UART01x_FR) & UART01x_FR_TXFF)
-		;
+		cpu_relax();
 	if (port->iotype == UPIO_MEM32)
 		writel(c, port->membase + UART01x_DR);
 	else
 		writeb(c, port->membase + UART01x_DR);
 	while (readl(port->membase + UART01x_FR) & UART01x_FR_BUSY)
-		;
+		cpu_relax();
 }
 
 static void pl011_early_write(struct console *con, const char *s, unsigned n)
-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project.

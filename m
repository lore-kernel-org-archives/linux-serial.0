From: Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH] tty: amba-pl011: uart_amba_port is not available with
 earlycon function
Date: Sat, 17 Sep 2016 14:14:38 +0800
Message-ID: <1474092878-30034-1-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Peter Hurley <peter@hurleysoftware.com>, Jason Liu <jason.liu@linaro.org>, Andre Przywara <andre.przywara@arm.com>, Timur Tabi <timur@codeaurora.org>, xie.baoyou@zte.com.cn, Russell King - ARM Linux <linux@armlinux.org.uk>, linux-serial@vger.kernel.org, Sudeep Holla <sudeep.holla@arm.com>, Jun Nie <jun.nie@linaro.org>, Shawn Guo <shawn.guo@linaro.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

Commit 0e125a5facf8 ("tty: amba-pl011: define flag register bits for ZTE
device") changes earlycon function pl011_putc() to use a pointer to
uart_amba_port.  This causes a regression when earlycon is enabled,
because uart_amba_port is not available yet at earlycon time.  Let's
revert the change on pl011_putc() to fix the regression.

The earlycon support for ZTE device can probably be added later by
declaring a new earlycon setup function with a vendor specific
compatible.

Reported-by: Sudeep Holla <sudeep.holla@arm.com>
Fixes: 0e125a5facf8 ("tty: amba-pl011: define flag register bits for ZTE device")
Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 drivers/tty/serial/amba-pl011.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index 0b78b04e895e..2d9ffab16ffe 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -2330,16 +2330,13 @@ static struct console amba_console = {
 
 static void pl011_putc(struct uart_port *port, int c)
 {
-	struct uart_amba_port *uap =
-		container_of(port, struct uart_amba_port, port);
-
 	while (readl(port->membase + UART01x_FR) & UART01x_FR_TXFF)
 		cpu_relax();
 	if (port->iotype == UPIO_MEM32)
 		writel(c, port->membase + UART01x_DR);
 	else
 		writeb(c, port->membase + UART01x_DR);
-	while (readl(port->membase + UART01x_FR) & uap->vendor->fr_busy)
+	while (readl(port->membase + UART01x_FR) & UART01x_FR_BUSY)
 		cpu_relax();
 }
 
-- 
1.9.1

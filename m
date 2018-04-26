From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH] tty/serial: atmel: use port->name as name in request_irq()
Date: Thu, 26 Apr 2018 17:06:26 +0200
Message-ID: <20180426150625.q5tqcb7fzchvkb5d@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-serial@vger.kernel.org
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>, Peter Hurley <peter@hurleysoftware.com>, Richard Genoud <richard.genoud@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, tglx@linutronix.de, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

I was puzzled while looking at /proc/interrupts and random things showed
up between reboots. This occurred more often but I realised it later. The
"correct" output should be:
|38:      11861  atmel-aic5   2 Level     ttyS0

but I saw sometimes
|38:       6426  atmel-aic5   2 Level     tty1

and I accounted it wrongly as correct. This is use after free and the
former example randomly got the "old" pointer which pointed to the same
content. With SLAB_FREELIST_RANDOM and HARDENED I even got
|38:       7067  atmel-aic5   2 Level     E=Started User Manager for UID 0

or other nonsense.
As it turns out the tty, pointer that is accessed in atmel_startup(), is
freed() before atmel_shutdown(). It seems to happen quite often that the
tty for ttyS0 is allocated and freed while ->shutdown is not invoked. I
don't do anything special - just a systemd boot :)

It seems not to happen in v4.1.51 but it happens in v4.9 and v4.17-rc2
so if it broke accidentally it was not recently.

Use port->name as the IRQ name for request_irq(). This exists as long as
the driver is loaded so no use-after-free here.

Cc: stable@vger.kernel.org
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/tty/serial/atmel_serial.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
index e287fe8f10fc..d3189816740e 100644
--- a/drivers/tty/serial/atmel_serial.c
+++ b/drivers/tty/serial/atmel_serial.c
@@ -1757,7 +1757,6 @@ static int atmel_startup(struct uart_port *port)
 {
 	struct platform_device *pdev = to_platform_device(port->dev);
 	struct atmel_uart_port *atmel_port = to_atmel_uart_port(port);
-	struct tty_struct *tty = port->state->port.tty;
 	int retval;
 
 	/*
@@ -1772,8 +1771,7 @@ static int atmel_startup(struct uart_port *port)
 	 * Allocate the IRQ
 	 */
 	retval = request_irq(port->irq, atmel_interrupt,
-			IRQF_SHARED | IRQF_COND_SUSPEND,
-			tty ? tty->name : "atmel_serial", port);
+			     IRQF_SHARED | IRQF_COND_SUSPEND, port->name, port);
 	if (retval) {
 		dev_err(port->dev, "atmel_startup - Can't get irq\n");
 		return retval;
-- 
2.17.0

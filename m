From: Vignesh R <vigneshr@ti.com>
Subject: [PATCH] serial: 8250: 8250_core: Use dev_name() during request_irq()
Date: Wed, 8 Mar 2017 17:49:43 +0530
Message-ID: <20170308121943.29340-1-vigneshr@ti.com>
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
Cc: linux-arm-kernel@lists.infradead.org, Vignesh R <vigneshr@ti.com>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.com>
List-Id: linux-serial@vger.kernel.org

Passing "serial" as name during request_irq() results in all serial port
irqs have same name. This does not help much to easily identify which
irq belongs to which serial port instance. Therefore pass dev_name()
during request_irq() so that better identifiable name is listed for
serial ports in cat /proc/interrupts output.

Output of cat /proc/interrupts
Before this patch:
 26:        689          0     GICv2 309 Edge      serial
After this patch:
 26:        696          0     GICv2 309 Edge      2530c00.serial

Signed-off-by: Vignesh R <vigneshr@ti.com>
---
 drivers/tty/serial/8250/8250_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
index 76e03a7de9cc..f83b69f30987 100644
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -218,7 +218,7 @@ static int serial_link_irq_chain(struct uart_8250_port *up)
 		spin_unlock_irq(&i->lock);
 		irq_flags |= up->port.irqflags;
 		ret = request_irq(up->port.irq, serial8250_interrupt,
-				  irq_flags, "serial", i);
+				  irq_flags, dev_name(up->port.dev), i);
 		if (ret < 0)
 			serial_do_unlink(i, up);
 	}
-- 
2.11.0

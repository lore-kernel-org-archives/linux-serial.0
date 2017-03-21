From: Vignesh R <vigneshr@ti.com>
Subject: [PATCH 2/2] serial: 8250: 8250_core: Fix irq name for 8250 serial irq
Date: Tue, 21 Mar 2017 19:06:36 +0530
Message-ID: <20170321133636.8814-3-vigneshr@ti.com>
References: <20170321133636.8814-1-vigneshr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170321133636.8814-1-vigneshr@ti.com>
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
Cc: Jisheng Zhang <jszhang@marvell.com>, Vignesh R <vigneshr@ti.com>, linux-kernel@vger.kernel.org, Andy Shevchenko <andy.shevchenko@gmail.com>, linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

Using dev_name() as irq name during request_irq() might be misleading in
case of serial over PCI. Therefore identify serial port irqs using
uart_port's name field. This will help mapping irqs to appropriate
ttySN(where N is the serial port index) instances.

Signed-off-by: Vignesh R <vigneshr@ti.com>
---
 drivers/tty/serial/8250/8250_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
index f83b69f30987..48a07e2f617f 100644
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -218,7 +218,7 @@ static int serial_link_irq_chain(struct uart_8250_port *up)
 		spin_unlock_irq(&i->lock);
 		irq_flags |= up->port.irqflags;
 		ret = request_irq(up->port.irq, serial8250_interrupt,
-				  irq_flags, dev_name(up->port.dev), i);
+				  irq_flags, up->port.name, i);
 		if (ret < 0)
 			serial_do_unlink(i, up);
 	}
-- 
2.11.0

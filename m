From: Vignesh R <vigneshr@ti.com>
Subject: [PATCH v2 1/2] tty: serial_core: Add name field to uart_port struct
Date: Fri, 24 Mar 2017 10:57:59 +0530
Message-ID: <20170324052800.11526-2-vigneshr@ti.com>
References: <20170324052800.11526-1-vigneshr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170324052800.11526-1-vigneshr@ti.com>
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

Introduce a field to store name of uart_port that can be used to easily
identify UART port instances on a system that has more than one UART
instance. The name is of the form ttyXN(eg. ttyS0, ttyAMA0,..) where N
is number that particular UART instance.
This field will be useful when printing debug info for a particular port
or in register IRQs with unique IRQ name. Port name is populated during
uart_add_one_port().

Signed-off-by: Vignesh R <vigneshr@ti.com>
---

v2: 
use kasprintf() instead of snprintf()
Fix up commit message.

 drivers/tty/serial/serial_core.c | 7 +++++++
 include/linux/serial_core.h      | 1 +
 2 files changed, 8 insertions(+)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 0fb3f7cce62a..f5572e28d16a 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -2744,6 +2744,12 @@ int uart_add_one_port(struct uart_driver *drv, struct uart_port *uport)
 	state->pm_state = UART_PM_STATE_UNDEFINED;
 	uport->cons = drv->cons;
 	uport->minor = drv->tty_driver->minor_start + uport->line;
+	uport->name = kasprintf(GFP_KERNEL, "%s%d", drv->dev_name,
+				drv->tty_driver->name_base + uport->line);
+	if (!uport->name) {
+		ret = -ENOMEM;
+		goto out;
+	}
 
 	/*
 	 * If this port is a console, then the spinlock is already
@@ -2861,6 +2867,7 @@ int uart_remove_one_port(struct uart_driver *drv, struct uart_port *uport)
 	if (uport->type != PORT_UNKNOWN && uport->ops->release_port)
 		uport->ops->release_port(uport);
 	kfree(uport->tty_groups);
+	kfree(uport->name);
 
 	/*
 	 * Indicate that there isn't a port here anymore.
diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index 58484fb35cc8..60530678c633 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -247,6 +247,7 @@ struct uart_port {
 	unsigned char		suspended;
 	unsigned char		irq_wake;
 	unsigned char		unused[2];
+	char			*name;			/* port name */
 	struct attribute_group	*attr_group;		/* port specific attributes */
 	const struct attribute_group **tty_groups;	/* all attributes (serial core use only) */
 	struct serial_rs485     rs485;
-- 
2.11.0

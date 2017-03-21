From: Vignesh R <vigneshr@ti.com>
Subject: [PATCH 1/2] tty: serial_core: Add name field to uart_port struct
Date: Tue, 21 Mar 2017 19:06:35 +0530
Message-ID: <20170321133636.8814-2-vigneshr@ti.com>
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

Introduce a field to store name of uart_port that can be used to easily
identify uart port instances on a system that has more than one uart
instance. The name is of the form ttyXN(eg. ttyS0, ttyAMA0,..) where N
is number that particular uart instance.
This field will be useful when printing debug info for a particular port
or in register irqs with unique irq name. Port name is populated during
uart_add_one_port().

Signed-off-by: Vignesh R <vigneshr@ti.com>
---
 drivers/tty/serial/serial_core.c | 2 ++
 include/linux/serial_core.h      | 1 +
 2 files changed, 3 insertions(+)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 0fb3f7cce62a..8b0fff74b190 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -2744,6 +2744,8 @@ int uart_add_one_port(struct uart_driver *drv, struct uart_port *uport)
 	state->pm_state = UART_PM_STATE_UNDEFINED;
 	uport->cons = drv->cons;
 	uport->minor = drv->tty_driver->minor_start + uport->line;
+	snprintf(uport->name, sizeof(uport->name), "%s%d", drv->dev_name,
+		 drv->tty_driver->name_base + uport->line);
 
 	/*
 	 * If this port is a console, then the spinlock is already
diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index 58484fb35cc8..821f97ce3ae2 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -247,6 +247,7 @@ struct uart_port {
 	unsigned char		suspended;
 	unsigned char		irq_wake;
 	unsigned char		unused[2];
+	char			name[20];		/* port name */
 	struct attribute_group	*attr_group;		/* port specific attributes */
 	const struct attribute_group **tty_groups;	/* all attributes (serial core use only) */
 	struct serial_rs485     rs485;
-- 
2.11.0

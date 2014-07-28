From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH] tty: serial: serial_core.c: printk replacement
Date: Mon, 28 Jul 2014 20:28:01 +0530
Message-ID: <1406559481-14084-1-git-send-email-sudipm.mukherjee@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, jslaby@suse.cz
Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

printk replaced with corresponding pr_* 
fixed two broken user-visible strings used by the printk


Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
---
 drivers/tty/serial/serial_core.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 8bb19da..eb6e663 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -891,10 +891,11 @@ static int uart_set_info(struct tty_struct *tty, struct tty_port *port,
 			 */
 			if (uport->flags & UPF_SPD_MASK) {
 				char buf[64];
-				printk(KERN_NOTICE
-				       "%s sets custom speed on %s. This "
-				       "is deprecated.\n", current->comm,
-				       tty_name(port->tty, buf));
+
+				pr_notice(
+					"%s sets custom speed on %s. This is deprecated.\n",
+					current->comm,
+					tty_name(port->tty, buf));
 			}
 			uart_change_speed(tty, state, NULL);
 		}
@@ -1974,8 +1975,7 @@ int uart_suspend_port(struct uart_driver *drv, struct uart_port *uport)
 		for (tries = 3; !ops->tx_empty(uport) && tries; tries--)
 			msleep(10);
 		if (!tries)
-			printk(KERN_ERR "%s%s%s%d: Unable to drain "
-					"transmitter\n",
+			pr_err("%s%s%s%d: Unable to drain transmitter\n",
 			       uport->dev ? dev_name(uport->dev) : "",
 			       uport->dev ? ": " : "",
 			       drv->dev_name,
@@ -2108,7 +2108,7 @@ uart_report_port(struct uart_driver *drv, struct uart_port *port)
 		break;
 	}
 
-	printk(KERN_INFO "%s%s%s%d at %s (irq = %d, base_baud = %d) is a %s\n",
+	pr_info("%s%s%s%d at %s (irq = %d, base_baud = %d) is a %s\n",
 	       port->dev ? dev_name(port->dev) : "",
 	       port->dev ? ": " : "",
 	       drv->dev_name,
@@ -2637,7 +2637,7 @@ int uart_add_one_port(struct uart_driver *drv, struct uart_port *uport)
 	if (likely(!IS_ERR(tty_dev))) {
 		device_set_wakeup_capable(tty_dev, 1);
 	} else {
-		printk(KERN_ERR "Cannot register tty device on line %d\n",
+		pr_err("Cannot register tty device on line %d\n",
 		       uport->line);
 	}
 
@@ -2672,7 +2672,7 @@ int uart_remove_one_port(struct uart_driver *drv, struct uart_port *uport)
 	BUG_ON(in_interrupt());
 
 	if (state->uart_port != uport)
-		printk(KERN_ALERT "Removing wrong port: %p != %p\n",
+		pr_alert("Removing wrong port: %p != %p\n",
 			state->uart_port, uport);
 
 	mutex_lock(&port_mutex);
-- 
1.8.1.2

build tested on x86_64 and arm (mini2440 board)

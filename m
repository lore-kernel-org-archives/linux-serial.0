From: Rickard Andersson <rickard.andersson@stericsson.com>
Subject: [PATCH v2] TTY: serial, add pm function
Date: Wed, 12 Dec 2012 13:40:51 +0100
Message-ID: <1355316051-2425-1-git-send-email-rickard.andersson@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from eu1sys200aog117.obsmtp.com ([207.126.144.143]:44869 "EHLO
	eu1sys200aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752094Ab2LLMlI (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 12 Dec 2012 07:41:08 -0500
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org, gregkh@linuxfoundation.org, linus.walleij@stericsson.com
Cc: alan@linux.intel.com, daniel.lezcano@linaro.org, rickard.andersson@stericsson.com

Add power management function to tty driver interface
and add implementation for serial core.

Signed-off-by: Rickard Andersson <rickard.andersson@stericsson.com>
---
ChangeLog v1->v2
- add mutex handling
---
 drivers/tty/serial/serial_core.c | 13 +++++++++++++
 include/linux/tty_driver.h       |  8 ++++++++
 2 files changed, 21 insertions(+)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index b2fc8d7..ec501f5 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -1114,6 +1114,18 @@ static int uart_get_icount(struct tty_struct *tty,
 	return 0;
 }
 
+static int uart_pm(struct tty_struct *tty, enum tty_pm_state state)
+{
+	struct uart_state *ustate = tty->driver_data;
+	struct tty_port *port = &ustate->port;
+
+	mutex_lock(&port->mutex);
+	uart_change_pm(ustate, state);
+	mutex_unlock(&port->mutex);
+
+	return 0;
+}
+
 /*
  * Called via sys_ioctl.  We can use spin_lock_irq() here.
  */
@@ -2217,6 +2229,7 @@ static const struct tty_operations uart_ops = {
 	.tiocmget	= uart_tiocmget,
 	.tiocmset	= uart_tiocmset,
 	.get_icount	= uart_get_icount,
+	.pm		= uart_pm,
 #ifdef CONFIG_CONSOLE_POLL
 	.poll_init	= uart_poll_init,
 	.poll_get_char	= uart_poll_get_char,
diff --git a/include/linux/tty_driver.h b/include/linux/tty_driver.h
index d150a6f..ba34b7f 100644
--- a/include/linux/tty_driver.h
+++ b/include/linux/tty_driver.h
@@ -229,6 +229,12 @@
  *	Called when the device receives a TIOCGICOUNT ioctl. Passed a kernel
  *	structure to complete. This method is optional and will only be called
  *	if provided (otherwise EINVAL will be returned).
+ *
+ * int (*pm)(struct tty_struct * tty, enum tty_pm_state state);
+ *
+ *      Perform any power management related activities on the specified
+ *      tty. State indicates the new state.
+ *
  */
 
 #include <linux/export.h>
@@ -249,6 +255,7 @@ struct serial_icounter_struct;
  */
 enum tty_pm_state {
 	TTY_PM_STATE_ON = 0,
+	TTY_PM_STATE_SLEEP,
 	TTY_PM_STATE_OFF = 3, /* number taken from ACPI */
 	TTY_PM_STATE_UNDEFINED,
 };
@@ -290,6 +297,7 @@ struct tty_operations {
 	int (*set_termiox)(struct tty_struct *tty, struct termiox *tnew);
 	int (*get_icount)(struct tty_struct *tty,
 				struct serial_icounter_struct *icount);
+	int (*pm)(struct tty_struct *tty, enum tty_pm_state state);
 #ifdef CONFIG_CONSOLE_POLL
 	int (*poll_init)(struct tty_driver *driver, int line, char *options);
 	int (*poll_get_char)(struct tty_driver *driver, int line);
-- 
1.8.0


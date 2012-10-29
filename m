From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH 2/3] uart: tidy the uart_get_info API
Date: Mon, 29 Oct 2012 15:20:25 +0000
Message-ID: <20121029152008.9451.42147.stgit@localhost.localdomain>
References: <20121029151901.9451.41783.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:58105 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757995Ab2J2PTH (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 29 Oct 2012 11:19:07 -0400
In-Reply-To: <20121029151901.9451.41783.stgit@localhost.localdomain>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org, greg@kroah.com

From: Alan Cox <alan@linux.intel.com>

We pass both port and state because the original caller had both to hand.
With all the attribute callers this won't be true so do the conversion in
the function itself.

The current callers all do lock/query/unlock. This won't be true for future
set based cases but there are plenty of get ones that will exist so split
the code with a helper for the future cases.

Signed-off-by: Alan Cox <alan@linux.intel.com>
---

 drivers/tty/serial/serial_core.c |   29 +++++++++++++++--------------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 477e079..0c4304e 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -634,10 +634,10 @@ static void uart_unthrottle(struct tty_struct *tty)
 		uart_set_mctrl(port, TIOCM_RTS);
 }
 
-static void uart_get_info(struct tty_port *port,
-                        struct uart_state *state,
+static void do_uart_get_info(struct tty_port *port,
 			struct serial_struct *retinfo)
 {
+	struct uart_state *state = container_of(port, struct uart_state, port);
 	struct uart_port *uport = state->uart_port;
 
 	memset(retinfo, 0, sizeof(*retinfo));
@@ -662,17 +662,21 @@ static void uart_get_info(struct tty_port *port,
 	retinfo->iomem_base      = (void *)(unsigned long)uport->mapbase;
 }
 
-static int uart_get_info_user(struct uart_state *state,
-			 struct serial_struct __user *retinfo)
+static void uart_get_info(struct tty_port *port,
+			struct serial_struct *retinfo)
 {
-	struct tty_port *port = &state->port;
-	struct serial_struct tmp;
-
 	/* Ensure the state we copy is consistent and no hardware changes
 	   occur as we go */
 	mutex_lock(&port->mutex);
-	uart_get_info(port, state, &tmp);
+	do_uart_get_info(port, retinfo);
 	mutex_unlock(&port->mutex);
+}
+
+static int uart_get_info_user(struct tty_port *port,
+			 struct serial_struct __user *retinfo)
+{
+	struct serial_struct tmp;
+	uart_get_info(port, &tmp);
 
 	if (copy_to_user(retinfo, &tmp, sizeof(*retinfo)))
 		return -EFAULT;
@@ -1131,7 +1135,7 @@ uart_ioctl(struct tty_struct *tty, unsigned int cmd,
 	 */
 	switch (cmd) {
 	case TIOCGSERIAL:
-		ret = uart_get_info_user(state, uarg);
+		ret = uart_get_info_user(port, uarg);
 		break;
 
 	case TIOCSSERIAL:
@@ -2331,12 +2335,8 @@ static ssize_t uart_get_attr_uartclk(struct device *dev,
 {
 	struct serial_struct tmp;
 	struct tty_port *port = dev_get_drvdata(dev);
-	struct uart_state *state = container_of(port, struct uart_state, port);
-
-	mutex_lock(&port->mutex);
-	uart_get_info(port, state, &tmp);
-	mutex_unlock(&port->mutex);
 
+	uart_get_info(port, &tmp);
 	return snprintf(buf, PAGE_SIZE, "%d\n", tmp.baud_base * 16);
 }
 
@@ -2356,6 +2356,7 @@ static const struct attribute_group *tty_dev_attr_groups[] = {
 	NULL
 	};
 
+
 /**
  *	uart_add_one_port - attach a driver-defined port structure
  *	@drv: pointer to the uart low level driver structure for this port


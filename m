From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH 1/3] uart: update the sysfs handler to use uart_get_info
Date: Mon, 29 Oct 2012 15:19:57 +0000
Message-ID: <20121029151901.9451.41783.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:58100 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759269Ab2J2PSm (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 29 Oct 2012 11:18:42 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org, greg@kroah.com

From: Alan Cox <alan@linux.intel.com>

The two patches needed are now in the tree. The first added the sysfs
interface and directly accesses the uartclk. The second provides a
proper interface for getting the values.

Wire them together.

This formes a basis for both get and set methods for any of the other uart
properties and we can now fill them out further.

Signed-off-by: Alan Cox <alan@linux.intel.com>
---

 drivers/tty/serial/serial_core.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 0fcfd98..477e079 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -2329,15 +2329,15 @@ struct tty_driver *uart_console_device(struct console *co, int *index)
 static ssize_t uart_get_attr_uartclk(struct device *dev,
 	struct device_attribute *attr, char *buf)
 {
-	int ret;
+	struct serial_struct tmp;
 	struct tty_port *port = dev_get_drvdata(dev);
 	struct uart_state *state = container_of(port, struct uart_state, port);
 
-	mutex_lock(&state->port.mutex);
-	ret = snprintf(buf, PAGE_SIZE, "%d\n", state->uart_port->uartclk);
-	mutex_unlock(&state->port.mutex);
+	mutex_lock(&port->mutex);
+	uart_get_info(port, state, &tmp);
+	mutex_unlock(&port->mutex);
 
-	return ret;
+	return snprintf(buf, PAGE_SIZE, "%d\n", tmp.baud_base * 16);
 }
 
 static DEVICE_ATTR(uartclk, S_IRUSR | S_IRGRP, uart_get_attr_uartclk, NULL);


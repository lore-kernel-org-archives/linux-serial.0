From: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Subject: [PATCH v2 10/11] serial_core: Remove call to driver-specific TIO[GS]RS485]
Date: Thu,  6 Nov 2014 09:22:59 +0100
Message-ID: <1415262180-2694-11-git-send-email-ricardo.ribalda@gmail.com>
References: <1415262180-2694-1-git-send-email-ricardo.ribalda@gmail.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-lb0-f177.google.com ([209.85.217.177]:36142 "EHLO
	mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751070AbaKFIXR (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 6 Nov 2014 03:23:17 -0500
Received: by mail-lb0-f177.google.com with SMTP id z12so462988lbi.8
        for <linux-serial@vger.kernel.org>; Thu, 06 Nov 2014 00:23:16 -0800 (PST)
In-Reply-To: <1415262180-2694-1-git-send-email-ricardo.ribalda@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>

Once there is no more handlers for TIOC[GS]RS485 there is no need to
call the driver specific ioctl when the generic implementation is
missing.

Reviewed-by: Alan Cox <alan@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>
Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
---
 drivers/tty/serial/serial_core.c | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 21462a6..652cce7 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -1155,9 +1155,6 @@ static int uart_get_icount(struct tty_struct *tty,
 static int uart_get_rs485_config(struct uart_port *port,
 			 struct serial_rs485 __user *rs485)
 {
-	if (!port->rs485_config)
-		return -ENOIOCTLCMD;
-
 	if (copy_to_user(rs485, &port->rs485, sizeof(port->rs485)))
 		return -EFAULT;
 	return 0;
@@ -1255,7 +1252,12 @@ uart_ioctl(struct tty_struct *tty, unsigned int cmd,
 	 * All these rely on hardware being present and need to be
 	 * protected against the tty being hung up.
 	 */
+
 	switch (cmd) {
+	case TIOCSERGETLSR: /* Get line status register */
+		ret = uart_get_lsr_info(tty, state, uarg);
+		break;
+
 	case TIOCGRS485:
 		ret = uart_get_rs485_config(state->uart_port, uarg);
 		break;
@@ -1263,15 +1265,6 @@ uart_ioctl(struct tty_struct *tty, unsigned int cmd,
 	case TIOCSRS485:
 		ret = uart_set_rs485_config(state->uart_port, uarg);
 		break;
-	}
-	if (ret != -ENOIOCTLCMD)
-		goto out;
-
-	switch (cmd) {
-	case TIOCSERGETLSR: /* Get line status register */
-		ret = uart_get_lsr_info(tty, state, uarg);
-		break;
-
 	default: {
 		struct uart_port *uport = state->uart_port;
 		if (uport->ops->ioctl)
-- 
2.1.1


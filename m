From: Alan Cox <alan@linux.intel.com>
Subject: [PATCH 10/11] specialix; Kill the BKL
Date: Wed, 19 May 2010 13:03:25 +0100
Message-ID: <20100519120324.16717.99272.stgit@localhost.localdomain>
References: <20100519120111.16717.71992.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:51114 "EHLO
	bob.linux.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751772Ab0ESMpx (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 19 May 2010 08:45:53 -0400
In-Reply-To: <20100519120111.16717.71992.stgit@localhost.localdomain>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: greg@kroah.com, linux-serial@vger.kernel.org

Use the port mutex instead

Signed-off-by: Alan Cox <alan@linux.intel.com>
---

 drivers/char/specialix.c |   11 +++++------
 1 files changed, 5 insertions(+), 6 deletions(-)


diff --git a/drivers/char/specialix.c b/drivers/char/specialix.c
index 2c24fcd..7be456f 100644
--- a/drivers/char/specialix.c
+++ b/drivers/char/specialix.c
@@ -1863,8 +1863,7 @@ static int sx_set_serial_info(struct specialix_port *port,
 		return -EFAULT;
 	}
 
-	lock_kernel();
-
+	mutex_lock(&port->port.mutex);
 	change_speed = ((port->port.flags & ASYNC_SPD_MASK) !=
 			(tmp.flags & ASYNC_SPD_MASK));
 	change_speed |= (tmp.custom_divisor != port->custom_divisor);
@@ -1875,7 +1874,7 @@ static int sx_set_serial_info(struct specialix_port *port,
 		    ((tmp.flags & ~ASYNC_USR_MASK) !=
 		     (port->port.flags & ~ASYNC_USR_MASK))) {
 			func_exit();
-			unlock_kernel();
+			mutex_unlock(&port->port.mutex);
 			return -EPERM;
 		}
 		port->port.flags = ((port->port.flags & ~ASYNC_USR_MASK) |
@@ -1892,7 +1891,7 @@ static int sx_set_serial_info(struct specialix_port *port,
 		sx_change_speed(bp, port);
 
 	func_exit();
-	unlock_kernel();
+	mutex_unlock(&port->port.mutex);
 	return 0;
 }
 
@@ -1906,7 +1905,7 @@ static int sx_get_serial_info(struct specialix_port *port,
 	func_enter();
 
 	memset(&tmp, 0, sizeof(tmp));
-	lock_kernel();
+	mutex_lock(&port->port.mutex);
 	tmp.type = PORT_CIRRUS;
 	tmp.line = port - sx_port;
 	tmp.port = bp->base;
@@ -1917,7 +1916,7 @@ static int sx_get_serial_info(struct specialix_port *port,
 	tmp.closing_wait = port->port.closing_wait * HZ/100;
 	tmp.custom_divisor =  port->custom_divisor;
 	tmp.xmit_fifo_size = CD186x_NFIFO;
-	unlock_kernel();
+	mutex_unlock(&port->port.mutex);
 	if (copy_to_user(retinfo, &tmp, sizeof(tmp))) {
 		func_exit();
 		return -EFAULT;


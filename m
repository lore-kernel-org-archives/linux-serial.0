From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH] serial: core: Release memory obtained by kasprintf
Date: Wed, 20 Sep 2017 12:33:39 +0530
Message-ID: <76c7fe65986400fc7630acbbc1211d73a9a8d0f7.1505890042.git.arvind.yadav.cs@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, jslaby@suse.com
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Free memory region, if uart_add_one_port is not successful.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/tty/serial/serial_core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 3a14ccc..989adbb 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -2784,7 +2784,7 @@ int uart_add_one_port(struct uart_driver *drv, struct uart_port *uport)
 				    GFP_KERNEL);
 	if (!uport->tty_groups) {
 		ret = -ENOMEM;
-		goto out;
+		goto out1;
 	}
 	uport->tty_groups[0] = &tty_dev_attr_group;
 	if (uport->attr_group)
@@ -2808,6 +2808,8 @@ int uart_add_one_port(struct uart_driver *drv, struct uart_port *uport)
 	 */
 	uport->flags &= ~UPF_DEAD;
 
+ out1:
+	kfree(uport->name);
  out:
 	mutex_unlock(&port->mutex);
 	mutex_unlock(&port_mutex);
-- 
1.9.1

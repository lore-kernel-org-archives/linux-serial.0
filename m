From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: [PATCH] serial: sh-sci: Fix could not remove dev_attr_rx_fifo_timeout
Date: Tue, 30 Oct 2018 15:13:35 +0900
Message-ID: <1540880015-11877-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, jslaby@suse.com, linux-serial@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, stable@vger.kernel.org, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
List-Id: linux-serial@vger.kernel.org

This patch fixes an issue that the sci_remove() could not remove
dev_attr_rx_fifo_timeout because uart_remove_one_port() set
the port->port.type to PORT_UNKNOWN.

Reported-by: Hiromitsu Yamasaki <hiromitsu.yamasaki.ym@renesas.com>
Fixes: 5d23188a473d ("serial: sh-sci: make RX FIFO parameters tunable via sysfs")
Cc: <stable@vger.kernel.org> # v4.11+
Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 drivers/tty/serial/sh-sci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index ab3f6e91..3649b83 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -3102,6 +3102,7 @@ static inline int sci_probe_earlyprintk(struct platform_device *pdev)
 static int sci_remove(struct platform_device *dev)
 {
 	struct sci_port *port = platform_get_drvdata(dev);
+	unsigned int type = port->port.type;	/* uart_remove_... clears it */
 
 	sci_ports_in_use &= ~BIT(port->port.line);
 	uart_remove_one_port(&sci_uart_driver, &port->port);
@@ -3112,8 +3113,7 @@ static int sci_remove(struct platform_device *dev)
 		sysfs_remove_file(&dev->dev.kobj,
 				  &dev_attr_rx_fifo_trigger.attr);
 	}
-	if (port->port.type == PORT_SCIFA || port->port.type == PORT_SCIFB ||
-	    port->port.type == PORT_HSCIF) {
+	if (type == PORT_SCIFA || type == PORT_SCIFB || type == PORT_HSCIF) {
 		sysfs_remove_file(&dev->dev.kobj,
 				  &dev_attr_rx_fifo_timeout.attr);
 	}
-- 
1.9.1

From: Michal Simek <michal.simek@xilinx.com>
Subject: [RFC PATCH 3/4] serial: uartps: Move cnds_uart_get_port to probe
Date: Fri, 21 Jul 2017 11:32:26 +0200
Message-ID: <d636a88da35ed3ba333d1e6523cf140ec1e57a0a.1500629544.git.michal.simek@xilinx.com>
References: <cover.1500629544.git.michal.simek@xilinx.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1500629544.git.michal.simek@xilinx.com>
In-Reply-To: <cover.1500629544.git.michal.simek@xilinx.com>
References: <cover.1500629544.git.michal.simek@xilinx.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, monstr@monstr.eu, Alan Cox <gnomes@lxorguk.ukuu.org.uk>
Cc: =?UTF-8?q?S=C3=B6ren=20Brinkmann?= <soren.brinkmann@xilinx.com>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

c&p this function to probe as preparation for removing
cdns_uart_port[] static array.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 drivers/tty/serial/xilinx_uartps.c | 61 +++++++++++++-------------------------
 1 file changed, 21 insertions(+), 40 deletions(-)

diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index e6470a3111ce..4fb74baeae35 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -1104,43 +1104,6 @@ static void cdns_uart_pm(struct uart_port *port, unsigned int state,
 
 static struct uart_port cdns_uart_port[CDNS_UART_NR_PORTS];
 
-/**
- * cdns_uart_get_port - Configure the port from platform device resource info
- * @id: Port id
- *
- * Return: a pointer to a uart_port or NULL for failure
- */
-static struct uart_port *cdns_uart_get_port(int id)
-{
-	struct uart_port *port;
-
-	/* Try the given port id if failed use default method */
-	if (cdns_uart_port[id].mapbase != 0) {
-		/* Find the next unused port */
-		for (id = 0; id < CDNS_UART_NR_PORTS; id++)
-			if (cdns_uart_port[id].mapbase == 0)
-				break;
-	}
-
-	if (id >= CDNS_UART_NR_PORTS)
-		return NULL;
-
-	port = &cdns_uart_port[id];
-
-	/* At this point, we've got an empty uart_port struct, initialize it */
-	spin_lock_init(&port->lock);
-	port->membase	= NULL;
-	port->irq	= 0;
-	port->type	= PORT_UNKNOWN;
-	port->iotype	= UPIO_MEM32;
-	port->flags	= UPF_BOOT_AUTOCONF;
-	port->ops	= &cdns_uart_ops;
-	port->fifosize	= CDNS_UART_FIFO_SIZE;
-	port->line	= id;
-	port->dev	= NULL;
-	return port;
-}
-
 #ifdef CONFIG_SERIAL_XILINX_PS_UART_CONSOLE
 /**
  * cdns_uart_console_wait_tx - Wait for the TX to be full
@@ -1545,15 +1508,33 @@ static int cdns_uart_probe(struct platform_device *pdev)
 	if (id < 0)
 		id = 0;
 
-	/* Initialize the port structure */
-	port = cdns_uart_get_port(id);
+	/* Try the given port id if failed use default method */
+	if (cdns_uart_port[id].mapbase != 0) {
+		/* Find the next unused port */
+		for (id = 0; id < CDNS_UART_NR_PORTS; id++)
+			if (cdns_uart_port[id].mapbase == 0)
+				break;
+	}
 
-	if (!port) {
+	port = &cdns_uart_port[id];
+	if (!port || id >= CDNS_UART_NR_PORTS) {
 		dev_err(&pdev->dev, "Cannot get uart_port structure\n");
 		rc = -ENODEV;
 		goto err_out_notif_unreg;
 	}
 
+	/* At this point, we've got an empty uart_port struct, initialize it */
+	spin_lock_init(&port->lock);
+	port->membase	= NULL;
+	port->irq	= 0;
+	port->type	= PORT_UNKNOWN;
+	port->iotype	= UPIO_MEM32;
+	port->flags	= UPF_BOOT_AUTOCONF;
+	port->ops	= &cdns_uart_ops;
+	port->fifosize	= CDNS_UART_FIFO_SIZE;
+	port->line	= id;
+	port->dev	= NULL;
+
 	/*
 	 * Register the port.
 	 * This function also registers this device with the tty layer
-- 
1.9.1

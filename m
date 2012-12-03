From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: [PATCHv2 1/5] serial: 8250: Allow drivers to deliver capabilities
Date: Mon,  3 Dec 2012 13:17:55 +0200
Message-ID: <1354533479-27306-2-git-send-email-heikki.krogerus@linux.intel.com>
References: <1354533479-27306-1-git-send-email-heikki.krogerus@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1354533479-27306-1-git-send-email-heikki.krogerus@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Alan Cox <alan@linux.intel.com>, Jamie Iles <jamie@jamieiles.com>, linux-serial@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

Modern UARTs are able to provide information about their
capabilities such as FIFO size. This allows the drivers to
deliver this information to 8250.c when they are registering
ports.

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 drivers/tty/serial/8250/8250.c |   22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/serial/8250/8250.c b/drivers/tty/serial/8250/8250.c
index d085e3a..da3f828 100644
--- a/drivers/tty/serial/8250/8250.c
+++ b/drivers/tty/serial/8250/8250.c
@@ -1980,9 +1980,12 @@ static int serial8250_startup(struct uart_port *port)
 	if (port->type == PORT_8250_CIR)
 		return -ENODEV;
 
-	port->fifosize = uart_config[up->port.type].fifo_size;
-	up->tx_loadsz = uart_config[up->port.type].tx_loadsz;
-	up->capabilities = uart_config[up->port.type].flags;
+	if (!port->fifosize)
+		port->fifosize = uart_config[port->type].fifo_size;
+	if (!up->tx_loadsz)
+		up->tx_loadsz = uart_config[port->type].tx_loadsz;
+	if (!up->capabilities)
+		up->capabilities = uart_config[port->type].flags;
 	up->mcr = 0;
 
 	if (port->iotype != up->cur_iotype)
@@ -2815,9 +2818,12 @@ static void
 serial8250_init_fixed_type_port(struct uart_8250_port *up, unsigned int type)
 {
 	up->port.type = type;
-	up->port.fifosize = uart_config[type].fifo_size;
-	up->capabilities = uart_config[type].flags;
-	up->tx_loadsz = uart_config[type].tx_loadsz;
+	if (!up->port.fifosize)
+		up->port.fifosize = uart_config[type].fifo_size;
+	if (!up->tx_loadsz)
+		up->tx_loadsz = uart_config[type].tx_loadsz;
+	if (!up->capabilities)
+		up->capabilities = uart_config[type].flags;
 }
 
 static void __init
@@ -3251,6 +3257,10 @@ int serial8250_register_8250_port(struct uart_8250_port *up)
 		uart->bugs		= up->bugs;
 		uart->port.mapbase      = up->port.mapbase;
 		uart->port.private_data = up->port.private_data;
+		uart->port.fifosize	= up->port.fifosize;
+		uart->tx_loadsz		= up->tx_loadsz;
+		uart->capabilities	= up->capabilities;
+
 		if (up->port.dev)
 			uart->port.dev = up->port.dev;
 
-- 
1.7.10.4

From: David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH] 8250: Don't clobber spinlocks in 8250.
Date: Wed, 15 Oct 2008 09:51:18 -0700
Message-ID: <48F61F86.5020108@caviumnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail3.caviumnetworks.com ([12.108.191.235]:48525 "EHLO
	mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752118AbYJOQvd (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 15 Oct 2008 12:51:33 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-mips@linux-mips.org, "Paoletti, Tomaso" <Tomaso.Paoletti@caviumnetworks.com>

Don't clobber spinlocks in 8250.

In serial8250_isa_init_ports(), the port's lock is initialized.  We
should not overwrite it.  Only copy in the fields we need.

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
Signed-off-by: Tomaso Paoletti <tpaoletti@caviumnetworks.com>
---
 drivers/serial/8250.c |   16 ++++++++++++++--
 1 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/serial/8250.c b/drivers/serial/8250.c
index d3ca7d3..da65fea 100644
--- a/drivers/serial/8250.c
+++ b/drivers/serial/8250.c
@@ -2699,12 +2699,24 @@ static struct uart_driver serial8250_reg = {
  */
 int __init early_serial_setup(struct uart_port *port)
 {
+	struct uart_port *p;
+
 	if (port->line >= ARRAY_SIZE(serial8250_ports))
 		return -ENODEV;
 
 	serial8250_isa_init_ports();
-	serial8250_ports[port->line].port	= *port;
-	serial8250_ports[port->line].port.ops	= &serial8250_pops;
+	p = &serial8250_ports[port->line].port;
+	p->iobase       = port->iobase;
+	p->membase      = port->membase;
+	p->irq          = port->irq;
+	p->uartclk      = port->uartclk;
+	p->fifosize     = port->fifosize;
+	p->regshift     = port->regshift;
+	p->iotype       = port->iotype;
+	p->flags        = port->flags;
+	p->mapbase      = port->mapbase;
+	p->private_data = port->private_data;
+	p->ops		= &serial8250_pops;
 	return 0;
 }
 

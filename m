From: David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH] serial: Initialize spinlocks in 8250 and don't clobber them.
Date: Tue, 14 Oct 2008 14:37:24 -0700
Message-ID: <48F51114.2010105@caviumnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail3.caviumnetworks.com ([12.108.191.235]:63165 "EHLO
	mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751007AbYJNVhg (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 14 Oct 2008 17:37:36 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: linux-mips@linux-mips.org, "Paoletti, Tomaso" <Tomaso.Paoletti@caviumnetworks.com>

Initialize spinlocks in 8250 and don't clobber them.

Spinlock debugging fails in 8250.c because the lock fields in
irq_lists are not initialized.  Initialize them.

In serial8250_isa_init_ports(), the port's lock is initialized.  We
should not overwrite it.  Only copy in the fields we need.

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
Signed-off-by: Tomaso Paoletti <tpaoletti@caviumnetworks.com>
---
 drivers/serial/8250.c |   19 +++++++++++++++++--
 1 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/serial/8250.c b/drivers/serial/8250.c
index d4104a3..0688799 100644
--- a/drivers/serial/8250.c
+++ b/drivers/serial/8250.c
@@ -2494,6 +2494,9 @@ static void __init serial8250_isa_init_ports(void)
 		return;
 	first = 0;
 
+	for (i = 0; i < ARRAY_SIZE(irq_lists); i++)
+		spin_lock_init(&irq_lists[i].lock);
+
 	for (i = 0; i < nr_uarts; i++) {
 		struct uart_8250_port *up = &serial8250_ports[i];
 
@@ -2699,12 +2702,24 @@ static struct uart_driver serial8250_reg = {
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
 

From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: [PATCHv3 3/5] serial: 8250_dw: Map IO memory
Date: Tue,  4 Dec 2012 17:21:52 +0200
Message-ID: <1354634512-19299-1-git-send-email-heikki.krogerus@linux.intel.com>
References: <20121204081713.GA8071@xps8300>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:51052 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751090Ab2LDPUb (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Tue, 4 Dec 2012 10:20:31 -0500
In-Reply-To: <20121204081713.GA8071@xps8300>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Alan Cox <alan@linux.intel.com>, Jamie Iles <jamie@jamieiles.com>, linux-serial@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

This needs to be done in order to later access the
Designware specific registers.

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 drivers/tty/serial/8250/8250_dw.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index ff83ea5..e174901 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -111,10 +111,13 @@ static int dw8250_probe(struct platform_device *pdev)
 	uart.port.irq = irq->start;
 	uart.port.handle_irq = dw8250_handle_irq;
 	uart.port.type = PORT_8250;
-	uart.port.flags = UPF_SHARE_IRQ | UPF_BOOT_AUTOCONF | UPF_IOREMAP |
-		UPF_FIXED_PORT;
+	uart.port.flags = UPF_SHARE_IRQ | UPF_BOOT_AUTOCONF | UPF_FIXED_PORT;
 	uart.port.dev = &pdev->dev;
 
+	uart.port.membase = ioremap(regs->start, resource_size(regs));
+	if (!uart.port.membase)
+		return -ENOMEM;
+
 	uart.port.iotype = UPIO_MEM;
 	uart.port.serial_in = dw8250_serial_in;
 	uart.port.serial_out = dw8250_serial_out;
-- 
1.7.10.4


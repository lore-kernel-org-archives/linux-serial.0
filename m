From: Aristeu Sergio Rozanski Filho <aris@cathedrallabs.org>
Subject: Re: [PATCH] make 8250_pnp use pnp_manual_config_dev()
Date: Tue, 10 May 2005 10:07:15 -0300
Message-ID: <20050510130715.GF3907@cathedrallabs.org>
References: <20050510121521.GB4676@cathedrallabs.org> <20050510135128.C3358@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="DBIVS5p969aUjpLe"
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from panda.sul.com.br ([200.219.150.4]:12813 "EHLO panda.sul.com.br")
	by vger.kernel.org with ESMTP id S261642AbVEJNbr (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 10 May 2005 09:31:47 -0400
Content-Disposition: inline
In-Reply-To: <20050510135128.C3358@flint.arm.linux.org.uk>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Russell King <rmk@arm.linux.org.uk>
Cc: linux-serial@vger.kernel.org, ambx1@neo.rr.com


--DBIVS5p969aUjpLe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

> > Hi,
> > 	this patch makes 8250_pnp use pnp_manual_config_dev() so
> > 	pnp_reserve_{io,irq} option will be valid for serial ports too.
> > 	Please consider applying
> 
> Please copy this to Adam Belay.  There are some problems with PNP
> serial ports because they can clash with with standard addresses
> for x86 ports.
> 
> We don't particularly want to reconfigure the standard x86 ports
> to some other addresses just because we've already detected them
> and claimed their resources external to PNP.
OK, adding Adam Belay to CC and attaching the patch again.

--
Aristeu


--DBIVS5p969aUjpLe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="8250_pnp-use_pnp_manual_config_dev.patch"

o Use pnp_manual_config_dev()

Signed-off-by: Aristeu Sergio Rozanski Filho <aris@cathedrallabs.org>

Index: 2.6/drivers/serial/8250_pnp.c
===================================================================
--- 2.6.orig/drivers/serial/8250_pnp.c	2005-05-09 17:33:05.000000000 -0300
+++ 2.6/drivers/serial/8250_pnp.c	2005-05-09 17:33:59.000000000 -0300
@@ -397,6 +397,7 @@
 serial_pnp_probe(struct pnp_dev * dev, const struct pnp_device_id *dev_id)
 {
 	struct uart_port port;
+	struct pnp_resource_table table;
 	int ret, line, flags = dev_id->driver_data;
 
 	if (flags & UNKNOWN_DEV) {
@@ -418,6 +419,13 @@
 	port.uartclk = 1843200;
 	port.dev = &dev->dev;
 
+	pnp_init_resource_table(&table);
+	pnp_resource_change(&table.port_resource[0], port.iobase, 8);
+	pnp_resource_change(&table.irq_resource[0], port.irq, 1);
+
+	if (pnp_manual_config_dev(dev, &table, 0))
+		return -ENODEV;
+
 	line = serial8250_register_port(&port);
 
 	if (line >= 0)

--DBIVS5p969aUjpLe--

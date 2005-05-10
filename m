From: Aristeu Sergio Rozanski Filho <aris@cathedrallabs.org>
Subject: [PATCH] make 8250_pnp use pnp_manual_config_dev()
Date: Tue, 10 May 2005 09:15:21 -0300
Message-ID: <20050510121521.GB4676@cathedrallabs.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Pd0ReVV5GZGQvF3a"
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from perninha.conectiva.com.br ([200.140.247.100]:56757 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S261624AbVEJMPw (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Tue, 10 May 2005 08:15:52 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by perninha.conectiva.com.br (Postfix) with ESMTP id D3F513738C
	for <linux-serial@vger.kernel.org>; Tue, 10 May 2005 09:15:51 -0300 (BRT)
Received: from perninha.conectiva.com.br ([127.0.0.1])
 by localhost (perninha.conectiva.com.br [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 16583-09 for <linux-serial@vger.kernel.org>;
 Tue, 10 May 2005 09:15:51 -0300 (BRT)
Received: from burns.conectiva (burns.conectiva [10.0.0.4])
	by perninha.conectiva.com.br (Postfix) with SMTP id 3B3D037381
	for <linux-serial@vger.kernel.org>; Tue, 10 May 2005 09:15:51 -0300 (BRT)
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: rmk+serial@arm.linux.org.uk


--Pd0ReVV5GZGQvF3a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,
	this patch makes 8250_pnp use pnp_manual_config_dev() so
	pnp_reserve_{io,irq} option will be valid for serial ports too.
	Please consider applying

-- 
Aristeu


--Pd0ReVV5GZGQvF3a
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

--Pd0ReVV5GZGQvF3a--

From: Aristeu Sergio Rozanski Filho <aris@cathedrallabs.org>
Subject: [PATCH] add ignore_ports option
Date: Tue, 10 May 2005 09:11:51 -0300
Message-ID: <20050510121151.GA4676@cathedrallabs.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="6c2NcOVqGQ03X4Wi"
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from perninha.conectiva.com.br ([200.140.247.100]:36020 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S261623AbVEJMM0 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Tue, 10 May 2005 08:12:26 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by perninha.conectiva.com.br (Postfix) with ESMTP id 6E49937198
	for <linux-serial@vger.kernel.org>; Tue, 10 May 2005 09:12:22 -0300 (BRT)
Received: from perninha.conectiva.com.br ([127.0.0.1])
 by localhost (perninha.conectiva.com.br [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 16251-09 for <linux-serial@vger.kernel.org>;
 Tue, 10 May 2005 09:12:21 -0300 (BRT)
Received: from burns.conectiva (burns.conectiva [10.0.0.4])
	by perninha.conectiva.com.br (Postfix) with SMTP id C4E753718B
	for <linux-serial@vger.kernel.org>; Tue, 10 May 2005 09:12:21 -0300 (BRT)
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: rmk+serial@arm.linux.org.uk


--6c2NcOVqGQ03X4Wi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,
	this patch adds an option to 8250 driver to avoid probing for a
	serial port in specified addresses.
	Please consider applying

-- 
Aristeu


--6c2NcOVqGQ03X4Wi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="8250-add_ignore_io_ports_option.patch"

o Add ignore_ports option to avoid probing for a port in specified addresses

Signed-off-by: Aristeu Sergio Rozanski Filho <aris@cathedrallabs.org>

Index: 2.6/drivers/serial/8250.c
===================================================================
--- 2.6.orig/drivers/serial/8250.c	2005-05-09 13:14:33.000000000 -0300
+++ 2.6/drivers/serial/8250.c	2005-05-09 17:24:41.000000000 -0300
@@ -121,6 +121,9 @@
 
 #define UART_NR	(ARRAY_SIZE(old_serial_port) + CONFIG_SERIAL_8250_NR_UARTS)
 
+static unsigned long ignore_ports[UART_NR];
+static unsigned int ignore_ports_count;
+
 #ifdef CONFIG_SERIAL_8250_RSA
 
 #define PORT_RSA_MAX 4
@@ -2060,13 +2063,19 @@
 static void __init
 serial8250_register_ports(struct uart_driver *drv, struct device *dev)
 {
-	int i;
+	int i, j;
 
 	serial8250_isa_init_ports();
 
 	for (i = 0; i < UART_NR; i++) {
 		struct uart_8250_port *up = &serial8250_ports[i];
 
+		for (j = 0; j < ignore_ports_count; j++)
+			if (ignore_ports[j] == up->port.iobase)
+				break;
+		if (j < ignore_ports_count)
+			continue;
+
 		up->port.dev = dev;
 		uart_add_one_port(drv, &up->port);
 	}
@@ -2554,6 +2563,10 @@
 MODULE_PARM_DESC(share_irqs, "Share IRQs with other non-8250/16x50 devices"
 	" (unsafe)");
 
+module_param_array(ignore_ports, ulong, &ignore_ports_count, 0444);
+MODULE_PARM_DESC(ignore_ports, "I/O ports that should be ignored "
+		 "on probe");
+
 #ifdef CONFIG_SERIAL_8250_RSA
 module_param_array(probe_rsa, ulong, &probe_rsa_count, 0444);
 MODULE_PARM_DESC(probe_rsa, "Probe I/O ports for RSA");

--6c2NcOVqGQ03X4Wi--

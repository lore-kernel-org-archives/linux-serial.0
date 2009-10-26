From: Shmulik Ladkani <shmulik@jungo.com>
Subject: [PATCH] serial: copy UART properties of UPF_FIXED_TYPE ports provisioned
 using early_serial_setup
Date: Mon, 26 Oct 2009 12:50:07 +0200
Message-ID: <4AE57EDF.3040607@jungo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from pptp-il.jungo.com ([194.90.113.98]:36404 "EHLO
	wall-ext.jungo.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755594AbZJZLMB (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 26 Oct 2009 07:12:01 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Augment the UPF_FIXED_TYPE logic, which currently applies to UART ports 
provisioned using platform_device_register.

The suggested patch applies same logic into 'serial8250_register_ports', 
making UART ports provisioned using early_serial_setup inherit their 
properties from the uart_config entry.

The patch applies to linux-2.6.32-rc5

Signed-off-by: Shmulik Ladkani <shmulik@jungo.com>
---
diff -upr linux-2.6.32-rc5.clean/drivers/serial/8250.c 
linux-2.6.32-rc5/drivers/serial/8250.c
--- linux-2.6.32-rc5.clean/drivers/serial/8250.c	2009-10-16 
02:41:50.000000000 +0200
+++ linux-2.6.32-rc5/drivers/serial/8250.c	2009-10-26 11:36:09.000000000 
+0200
@@ -2704,6 +2704,14 @@ serial8250_register_ports(struct uart_dr
  		struct uart_8250_port *up = &serial8250_ports[i];

  		up->port.dev = dev;
+
+		if (up->port.flags & UPF_FIXED_TYPE) {
+			up->port.fifosize =
+				uart_config[up->port.type].fifo_size;
+			up->capabilities = uart_config[up->port.type].flags;
+			up->tx_loadsz = uart_config[up->port.type].tx_loadsz;
+		}
+
  		uart_add_one_port(drv, &up->port);
  	}
  }
-- 
Shmulik Ladkani        Jungo Ltd.

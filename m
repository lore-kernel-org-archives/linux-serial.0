From: Jose Alonso <alonso@estadao.com.br>
Subject: [PATCH] pcmcia/serial release of memory I/O twice
Date: Wed, 03 Mar 2004 11:59:42 -0300
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <1078325981.3296.16.camel@laptop>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from webmail0.estadao.com.br ([200.182.48.161]:4038 "EHLO
	webmail0.estadao.com.br") by vger.kernel.org with ESMTP
	id S262464AbUCCO7t (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 3 Mar 2004 09:59:49 -0500
Received: from unknown (HELO [172.17.21.203]) ([200.211.26.114])
          (envelope-sender <alonso@estadao.com.br>)
          by webmail0.estadao.com.br (qmail-ldap-1.03) with SMTP
          for <linux-serial@vger.kernel.org>; 3 Mar 2004 14:59:32 -0000
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: rmk+serial@arm.linux.org.uk

I am using a pcmcia modem (linux-2.6.3) and when I unplug the
card the kernel warms:
"kernel: Trying to free nonexistent resource <000003e8-000003ef>"

The I/O address is allocated by pcmcia_request_io and released by
serial8250_release_port and pcmcia_release_io.

The allocation of I/O address is done in:
module serial_cs:
  simple_config:
    pcmcia_request_io  ---> allocate I/O address
    setup_serial ... serial8250_request_port --> doesn't allocate I/O
                     because flag UPF_RESOURCES is not set.

The release of I/O address is done in:
module serial_cs:
  serial_remove:
    unregister_serial ... serial8250_release_port ---> release I/O
    pcmcia_release_io ---> release again the I/O

I suggest the patch bellow:
"serial8250_release_port undo only what serial8250_request_port does"

--- linux-2.6.3/drivers/serial/8250.c.ORIG	2004-02-18 00:57:14.000000000
-0300
+++ linux-2.6.3/drivers/serial/8250.c	2004-03-03 11:26:27.757353637 -
0300
@@ -1670,6 +1670,8 @@
 	struct uart_8250_port *up = (struct uart_8250_port *)port;
 	unsigned long start, offset = 0, size = 0;
 
+	if (!(up->port.flags & UPF_RESOURCES))
+		return;
 	if (up->port.type == PORT_RSA) {
 		offset = UART_RSA_BASE << up->port.regshift;
 		size = 8;
-- 
     alonso


From: Gyorgy Jeney <nog.lkml@gmail.com>
Subject: [patch] serial: compare mapbase and not membase in find_port
Date: Sun, 1 Jan 2006 16:12:31 +0100
Message-ID: <221e0ff70601010712u6a0d395dq@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932235AbWAAPMc@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: rmk+serial@arm.linux.org.uk
Cc: linux-serial@vger.kernel.org, Bjorn Helgaas <bjorn.helgaas@hp.com>, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

From: Gyorgy Jeney

If the 8250_early driver uses bt_ioremap, find_port() is unable to find the
correct device since the address returned by ioremap is different to that
returned by bt_ioremap for the same address.  Since no more than one device
occupies the same physical address, compareing the physical addresses should
be safe.

Signed-off-by: Gyorgy Jeney <nog.lkml@gmail.com>

nog.

--- drivers/serial/8250.c	2005-10-28 02:02:08.000000000 +0200
+++ ../../linux-2.6.14/drivers/serial/8250.c	2006-01-01 10:27:39.000000000 +0100
@@ -2229,7 +2229,7 @@ static int __init find_port(struct uart_
 		port = &serial8250_ports[line].port;
 		if (p->iotype == port->iotype &&
 		    p->iobase == port->iobase &&
-		    p->membase == port->membase)
+		    p->mapbase == port->mapbase)
 			return line;
 	}
 	return -ENODEV;

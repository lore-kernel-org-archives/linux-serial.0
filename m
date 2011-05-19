From: Michael Reed <mreed@linux.vnet.ibm.com>
Subject: [PATCH 2/2] 8250_pci Add EEH support to the 8250 driver for IBM/Digi PCIe 2-port Adapter
Date: Thu, 19 May 2011 14:03:43 -0500
Message-ID: <1305831823-25400-2-git-send-email-mreed@linux.vnet.ibm.com>
References: <mreed@linux.vnet.ibm.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from e36.co.us.ibm.com ([32.97.110.154]:40829 "EHLO
	e36.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933797Ab1ESTEQ (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 19 May 2011 15:04:16 -0400
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com [9.17.195.227])
	by e36.co.us.ibm.com (8.14.4/8.13.1) with ESMTP id p4JIwSJX001365
	for <linux-serial@vger.kernel.org>; Thu, 19 May 2011 12:58:28 -0600
Received: from d03av06.boulder.ibm.com (d03av06.boulder.ibm.com [9.17.195.245])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id p4JJ44Kp142228
	for <linux-serial@vger.kernel.org>; Thu, 19 May 2011 13:04:06 -0600
Received: from d03av06.boulder.ibm.com (loopback [127.0.0.1])
	by d03av06.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id p4JJ97tF025067
	for <linux-serial@vger.kernel.org>; Thu, 19 May 2011 13:09:07 -0600
In-Reply-To: <mreed@linux.vnet.ibm.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Michael Reed <mreed@linux.vnet.ibm.com>, Greg Kroah-Hartman <gregkh@suse.de>, Breno Leitao <leitao@linux.vnet.ibm.com>, Scott Kilau <scottk@digi.com>

When working on the 8250_pci driver on PPC, the rmmod command was resulting in a crash when removing the module.  The serial8250_do_pm() is called after the memory are deallocated, meaning that serial8250_set_sleep->serial_outp() will try to write to a
position that is invalid, crashing the system. The purpose of  this patch is to correct that issue.
This patch was created against  2.6.38.6

Patch-created-by:  Breno Leitao <leitao@linux.vnet.ibm.com>
Cc: Greg Kroah-Hartman <gregkh@suse.de>
Cc: Breno Leitao <leitao@linux.vnet.ibm.com>
Cc: Scott Kilau <scottk@digi.com>
Signed-off-by:   Michael Reed <mreed@linux.vnet.ibm.com>
---
 drivers/tty/serial/8250.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/drivers/tty/serial/8250.c b/drivers/tty/serial/8250.c
index b3b881b..7617cde 100644
--- a/drivers/tty/serial/8250.c
+++ b/drivers/tty/serial/8250.c
@@ -145,6 +145,8 @@ struct uart_8250_port {
 	unsigned char		mcr_mask;	/* mask of user bits */
 	unsigned char		mcr_force;	/* mask of forced bits */
 	unsigned char		cur_iotype;	/* Running I/O type */
+#define SERIAL8250_DYING 1
+	unsigned char		status;
 
 	/*
 	 * Some bits in registers are cleared on a read, so they must
@@ -2494,7 +2496,8 @@ void serial8250_do_pm(struct uart_port *port, unsigned int state,
 	struct uart_8250_port *p =
 		container_of(port, struct uart_8250_port, port);
 
-	serial8250_set_sleep(p, state != 0);
+	if (!(p->status & SERIAL8250_DYING))
+		serial8250_set_sleep(p, state != 0);
 }
 EXPORT_SYMBOL(serial8250_do_pm);
 
@@ -2588,6 +2591,7 @@ static void serial8250_release_std_resource(struct uart_8250_port *up)
 		release_region(up->port.iobase, size);
 		break;
 	}
+	up->status |= SERIAL8250_DYING;
 }
 
 static int serial8250_request_rsa_resource(struct uart_8250_port *up)
-- 
1.7.1


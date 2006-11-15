From: Peter Korsgaard <jacmet@sunsite.dk>
Subject: [PATCH] Fix serial-uartlite after global pt_regs
Date: Wed, 15 Nov 2006 21:10:45 +0100
Message-ID: <87psbobhdm.fsf@slug.be.48ers.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from outmx004.isp.belgacom.be ([195.238.4.101]:58346 "EHLO
	outmx004.isp.belgacom.be") by vger.kernel.org with ESMTP
	id S1030919AbWKOULU (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 15 Nov 2006 15:11:20 -0500
Received: from outmx004.isp.belgacom.be (localhost [127.0.0.1])
        by outmx004.isp.belgacom.be (8.12.11.20060308/8.12.11/Skynet-OUT-2.22) with ESMTP id kAFKBB0P007957
        for <linux-serial@vger.kernel.org>; Wed, 15 Nov 2006 21:11:12 +0100
        (envelope-from <jacmet@sunsite.dk>)
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: akpm@osdl.org
Cc: linux-serial@vger.kernel.org

Hi Andrew,

This little patch updates the serial uartlite driver in -mm for the
global pt_regs in 2.6.19-rc2+.

Signed-off-by: Peter Korsgaard <jacmet@sunsite.dk>

--- linux-mm.orig/drivers/serial/uartlite.c
+++ linux-mm/drivers/serial/uartlite.c
@@ -126,7 +126,7 @@
 	return 1;
 }
 
-static irqreturn_t ulite_isr(int irq, void *dev_id, struct pt_regs *regs)
+static irqreturn_t ulite_isr(int irq, void *dev_id)
 {
 	struct uart_port *port = (struct uart_port *)dev_id;
 	int busy;

-- 
Bye, Peter Korsgaard

From: Corey Minyard <minyard@acm.org>
Subject: Serial 8250: clear the lsr_break_flag at open
Date: Mon, 30 Apr 2007 17:08:59 -0500
Message-ID: <20070430220858.GA28890@localdomain>
Reply-To: minyard@acm.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mta15.mail.adelphia.net ([68.168.78.77]:60362 "EHLO
	mta15.adelphia.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1946849AbXD3WJB (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 30 Apr 2007 18:09:01 -0400
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Linux Kernel <linux-kernel@vger.kernel.org>, Russell King <rmk+lkml@arm.linux.org.uk>
Cc: linux-serial@vger.kernel.org

Sorry for the double send, but I messed up on the subject.  I'll
get used to mutt one of these days.

I think I've spotted a bug in the 8250 code, but I'm not really
sure.  I'm having a hard time understanding why the lsr_break_flag
is necessary.

Subject: Serial 8250: clear the lsr_break_flag at open

The lsr_break_flag in the 8250 driver is not cleared when the port is
opened.  This means that on a serial console, if a break has occurred
while the port is closed, the first call to receive_chars() will
result in a break being delivered at that point.  Clear the flag at
open to fix the problem.

Signed-off-by: Corey Minyard <minyard@acm.org>

Index: linux-2.6.21/drivers/serial/8250.c
===================================================================
--- linux-2.6.21.orig/drivers/serial/8250.c
+++ linux-2.6.21/drivers/serial/8250.c
@@ -1638,6 +1638,7 @@ static int serial8250_startup(struct uar
 
 	up->capabilities = uart_config[up->port.type].flags;
 	up->mcr = 0;
+	up->lsr_break_flag = 0;
 
 	if (up->port.type == PORT_16C950) {
 		/* Wake up and initialize UART */


From: Dan Nicolaescu <dann@ics.uci.edu>
Subject: is_real_interrupt in 8250.c
Date: Wed, 29 Nov 2006 09:44:59 -0800
Message-ID: <200611291744.kATHixEN006240@oogie-boogie.ics.uci.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from oogie-boogie.ics.uci.edu ([128.195.1.41]:63369 "EHLO
	oogie-boogie.ics.uci.edu") by vger.kernel.org with ESMTP
	id S935955AbWK2RsF (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 29 Nov 2006 12:48:05 -0500
Received: from mothra.ics.uci.edu (mothra.ics.uci.edu [128.195.6.93])
	by oogie-boogie.ics.uci.edu (8.13.6/8.13.6) with ESMTP id kATHixEN006240
	for <linux-serial@vger.kernel.org>; Wed, 29 Nov 2006 09:44:59 -0800 (PST)
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org


Hi,

In 8250.c is_real_interrupt is defined like this: 

/*
 * We default to IRQ0 for the "no irq" hack.   Some
 * machine types want others as well - they're free
 * to redefine this in their header file.
 */
#define is_real_interrupt(irq)  ((irq) != 0)

on my platform the UART IRQ is 0, so is_real_interrupt returns
false.

In order to allow machines to override is_real_interrupt, and for the
code to match the comment shouldn't this patch be applied? 


--- 8250.c.orig 2006-11-29 09:33:47.000000000 -0800
+++ 8250.c      2006-11-29 09:42:51.000000000 -0800
@@ -75,7 +75,9 @@
  * machine types want others as well - they're free
  * to redefine this in their header file.
  */
+#ifndef is_real_interrupt
 #define is_real_interrupt(irq) ((irq) != 0)
+#endif
 
 /*
  * This converts from our new CONFIG_ symbols to the symbols

Thanks
        --dan

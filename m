From: Eugene Bordenkircher <eugebo@gmail.com>
Subject: Ordering problem in serial_core.c
Date: Thu, 22 Oct 2009 09:19:41 -0700 (PDT)
Message-ID: <cc845bea-0a4c-4958-b317-6b95120031a3@w37g2000prg.googlegroups.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-yw0-f168.google.com ([209.85.211.168]:59376 "EHLO
	mail-yw0-f168.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753151AbZJVRgH (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 22 Oct 2009 13:36:07 -0400
Received: by ywh40 with SMTP id 40so5975372ywh.33
        for <linux-serial@vger.kernel.org>; Thu, 22 Oct 2009 10:36:11 -0700 (PDT)
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
Cc: linux-serial@vger.kernel.org

There is an ordering problem with closing a UART in the serial core.
If the line discipline is throttling the port when close is called, it
tries to unthrottle the port which, in the case of soft flow, tries to
send the XON character.  This doesn't work well since at this point
the uart has been shutdown.

The simple reordering shown below will seems to fix the problem, but
please comment if there are other side effects I am not seeing.

Eugene T. Bordenkircher

--- linux_kernel/drivers/serial/serial_core.c.orig	2009-08-13
14:58:04.000000000 -0700
+++ linux_kernel/drivers/serial/serial_core.c	2009-08-13
15:29:02.000000000 -0700
@@ -1317,11 +1317,11 @@
 		uart_wait_until_sent(tty, port->timeout);
 	}

+	tty_ldisc_flush(tty);
+
 	uart_shutdown(state);
 	uart_flush_buffer(tty);

-	tty_ldisc_flush(tty);
-
 	tty->closing = 0;
 	state->info.port.tty = NULL;

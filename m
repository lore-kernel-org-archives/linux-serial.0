From: Tim Schmielau <tim@physik3.uni-rostock.de>
Subject: [patch] fix compares of jiffies
Date: Sun, 22 Sep 2002 13:45:52 +0200
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <200209221145.g8MBjqM23364@gans.physik3.uni-rostock.de>
Return-path: <linux-serial-owner@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org
To: support@moxa.com.tw
Cc: linux-serial@vger.kernel.org, tim@physik3.uni-rostock.de

Dear Linux kernel code maintainer,

on rechecking the current stable kernel code, I found some places where jiffies
were compared in a way that seems to break when they wrap. For these,
I made up patches to use the macros "time_before()" or "time_after()"
that are supposed to handle wraparound correctly.

For a small part of the patches, I believe you to be the relevant kernel code
maintainer. Appended to this email you will find some lines explaining
why I decided to mail or cc: you on this (an extract of the copyright notice
or the MAINTAINERS file), followed by the patch itself. If I mailed you
in error, please drop me a short note.

I kindly ask you to approve the correctness of the patch, and pass it on to
the relevant people for inclusion into the mainline kernel.

Thanks,
Tim Schmielau (tim@physik3.uni-rostock.de)



/*****************************************************************************/
/*
 *           moxa.c  -- MOXA Intellio family multiport serial driver.
 *
 *      Copyright (C) 1999-2000  Moxa Technologies (support@moxa.com.tw).


 *    Fixes for C104H/PCI by Tim Hockin <thockin@sun.com>


--- linux-2.4.20-pre6/drivers/char/moxa.c	Thu Oct 25 22:53:47 2001
+++ linux-2.4.20-pre6-jfix/drivers/char/moxa.c	Wed Sep 11 12:38:26 2002
@@ -2836,7 +2836,7 @@
 
 	st = jiffies;
 	et = st + tick;
-	while (jiffies < et);
+	while (time_before(jiffies, et));
 }
 
 static void moxafunc(unsigned long ofsAddr, int cmd, ushort arg)

--- linux-2.4.20-pre6/drivers/char/mxser.c	Wed Sep 11 13:36:44 2002
+++ linux-2.4.20-pre6-jfix/drivers/char/mxser.c	Wed Sep 11 12:32:13 2002
@@ -883,7 +883,7 @@
 		while (!(inb(info->base + UART_LSR) & UART_LSR_TEMT)) {
 			set_current_state(TASK_INTERRUPTIBLE);
 			schedule_timeout(5);
-			if (jiffies > timeout)
+			if (time_after(jiffies, timeout))
 				break;
 		}
 	}


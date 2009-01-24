From: Michael Tokarev <mjt@tls.msk.ru>
Subject: [trivial patch] fix missing space in printk drivers/serial/8250.c
Date: Sat, 24 Jan 2009 23:39:27 +0300
Message-ID: <497B7C7F.80104@msgid.tls.msk.ru>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------030304000202010000080403"
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from isrv.corpit.ru ([81.13.33.159]:60186 "EHLO isrv.corpit.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755428AbZAXUuZ (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Sat, 24 Jan 2009 15:50:25 -0500
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org, Linux-kernel <linux-kernel@vger.kernel.org>

This is a multi-part message in MIME format.
--------------030304000202010000080403
Content-Type: text/plain; charset=KOI8-R
Content-Transfer-Encoding: 7bit

Again, I don't know where to push this trivia thing.
8250 marked as Orphan in MAINTAINERS, so I'm sending
to linux-serial@ AND to linux-kernel@

Because.. when I see such mess in dmesg, it annoys me ;)

 Serial: 8250/16550 driver10 ports, IRQ sharing enabled

Signed-Off-By: Michael Tokarev <mjt@tls.msk.ru>

Thanks!

/mjt

--------------030304000202010000080403
Content-Type: text/x-patch;
 name="8250-space.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="8250-space.diff"

--- linux-2.6.28/drivers/serial/8250.c.orig	2008-12-25 02:26:37.000000000 +0300
+++ linux-2.6.28/drivers/serial/8250.c	2009-01-24 23:34:32.891807709 +0300
@@ -3020,3 +3020,3 @@ static int __init serial8250_init(void)
 
-	printk(KERN_INFO "Serial: 8250/16550 driver"
+	printk(KERN_INFO "Serial: 8250/16550 driver "
 		"%d ports, IRQ sharing %sabled\n", nr_uarts,

--------------030304000202010000080403--

From: kees <kees@schoen.mine.nu>
Subject: [PATCH] drivers/serial/8250.c patch3
Date: Thu, 28 Jun 2007 10:41:33 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0706281040120.907@schoen3.schoen.mine.nu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7BIT
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from smtp15.wxs.nl ([195.121.247.6]:64602 "EHLO smtp15.wxs.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762028AbXF1Ilb (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Thu, 28 Jun 2007 04:41:31 -0400
Received: from schoen3.schoen.mine.nu
 (ip5457f49a.direct-adsl.nl [84.87.244.154])
 by smtp15.wxs.nl (iPlanet Messaging Server 5.2 HotFix 2.15 (built Nov 14
 2006)) with ESMTP id <0JKC00FOD85503@smtp15.wxs.nl> for
 linux-serial@vger.kernel.org; Thu, 28 Jun 2007 10:41:30 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])	by schoen3.schoen.mine.nu
 (Postfix on SuSE Linux 7.2 (i386)) with ESMTP id 9BA5D35A54	for
 <linux-serial@vger.kernel.org>; Thu, 28 Jun 2007 10:41:33 +0200 (CEST)
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

Hi All,

I found that setserial in serial_core.c  does not update all port 
variables. It _does_ update the type variable properly but fails to update 
the fixfosize that the driver uses. This causes the driver to fail after 
setserial to another device i.e. 8250 or 16450.
This patch solves that for the devices which are served by 8250.c. There 
is a deeper problem though, setserial does not properly update all port 
variables. Maybe the prot drivers should have their own
.setserial   entry in the table and handle the details themselves.


--- drivers/serial/8250.c.orig	2007-06-11 20:37:06.000000000 +0200
+++ drivers/serial/8250.c	2007-06-19 14:50:49.000000000 +0200
@@ -1791,8 +1791,6 @@ static int serial8250_startup(struct uar
  		up->bugs &= ~UART_BUG_TXEN;
  	}

-	spin_unlock_irqrestore(&up->port.lock, flags);
-
  	/*
  	 * Finally, enable interrupts.  Note: Modem status interrupts
  	 * are set via set_termios(), which will be occurring imminently
@@ -1801,6 +1799,8 @@ static int serial8250_startup(struct uar
  	up->ier = UART_IER_RLSI | UART_IER_RDI;
  	serial_outp(up, UART_IER, up->ier);

+	spin_unlock_irqrestore(&up->port.lock, flags);
+
  	if (up->port.flags & UPF_FOURPORT) {
  		unsigned int icp;
  		/*
@@ -1830,10 +1830,10 @@ static void serial8250_shutdown(struct u
  	/*
  	 * Disable interrupts from this port
  	 */
+	spin_lock_irqsave(&up->port.lock, flags);
  	up->ier = 0;
  	serial_outp(up, UART_IER, 0);

-	spin_lock_irqsave(&up->port.lock, flags);
  	if (up->port.flags & UPF_FOURPORT) {
  		/* reset interrupts on the AST Fourport board */
  		inb((up->port.iobase & 0xfe0) | 0x1f);


regards

Kees

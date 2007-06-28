From: kees <kees@schoen.mine.nu>
Subject: [PATCH] driver_serial_patch1
Date: Thu, 28 Jun 2007 10:37:59 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0706281033550.907@schoen3.schoen.mine.nu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7BIT
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from smtp13.wxs.nl ([195.121.247.4]:34417 "EHLO smtp13.wxs.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760139AbXF1Ih4 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Thu, 28 Jun 2007 04:37:56 -0400
Received: from schoen3.schoen.mine.nu
 (ip5457f49a.direct-adsl.nl [84.87.244.154])
 by smtp13.wxs.nl (iPlanet Messaging Server 5.2 HotFix 2.15 (built Nov 14
 2006)) with ESMTP id <0JKC004QK7Z7PL@smtp13.wxs.nl> for
 linux-serial@vger.kernel.org; Thu, 28 Jun 2007 10:37:55 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])	by schoen3.schoen.mine.nu
 (Postfix on SuSE Linux 7.2 (i386)) with ESMTP id 0EF7935A54	for
 <linux-serial@vger.kernel.org>; Thu, 28 Jun 2007 10:37:59 +0200 (CEST)
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

Hi All,

Here the first of a few small patches for drivers/serial/8250.c
This patch makes the testing for an empty device more robust. Some chips 
hold
the UART_TEMT bit sometime _after_ data has been written in uart_thr.
Now ioctl(    ,TIOCSERGETLSR,  )  returns the right status.


--- drivers/serial/8250.c.orig	2007-06-11 20:37:06.000000000 +0200
+++ drivers/serial/8250.c	2007-06-19 14:38:19.000000000 +0200
@@ -108,6 +108,7 @@ static const struct old_serial_port old_
  };

  #define UART_NR	CONFIG_SERIAL_8250_NR_UARTS
+#define BOTH_EMPTY (UART_LSR_TEMT | UART_LSR_THRE)

  #ifdef CONFIG_SERIAL_8250_RSA

@@ -1160,7 +1161,7 @@ static void serial8250_start_tx(struct u
  			unsigned char lsr, iir;
  			lsr = serial_in(up, UART_LSR);
  			iir = serial_in(up, UART_IIR);
-			if (lsr & UART_LSR_TEMT && iir & UART_IIR_NO_INT)
+			if (((lsr & BOTH_EMPTY) == BOTH_EMPTY) && iir & UART_IIR_NO_INT)
  				transmit_chars(up);
  		}
  	}
@@ -1539,7 +1540,7 @@ static unsigned int serial8250_tx_empty(
  	unsigned int ret;

  	spin_lock_irqsave(&up->port.lock, flags);
-	ret = serial_in(up, UART_LSR) & UART_LSR_TEMT ? TIOCSER_TEMT : 0;
+	ret = ((serial_in(up, UART_LSR) & BOTH_EMPTY) == BOTH_EMPTY) ? TIOCSER_TEMT : 0;
  	spin_unlock_irqrestore(&up->port.lock, flags);

  	return ret;
@@ -1600,7 +1601,6 @@ static void serial8250_break_ctl(struct
  	spin_unlock_irqrestore(&up->port.lock, flags);
  }

-#define BOTH_EMPTY (UART_LSR_TEMT | UART_LSR_THRE)

  /*
   *	Wait for transmitter & holding register to empty
@@ -1781,7 +1781,7 @@ static int serial8250_startup(struct uar
  	iir = serial_in(up, UART_IIR);
  	serial_outp(up, UART_IER, 0);

-	if (lsr & UART_LSR_TEMT && iir & UART_IIR_NO_INT) {
+	if (((lsr & BOTH_EMPTY) == BOTH_EMPTY) && iir & UART_IIR_NO_INT) {
  		if (!(up->bugs & UART_BUG_TXEN)) {
  			up->bugs |= UART_BUG_TXEN;
  			pr_debug("ttyS%d - enabling bad tx status workarounds\n",




regards

Kees

From: Dick Hollenbeck <dick@softplc.com>
Subject: [PATCH] serial8250_tx_empty not telling the truth
Date: Sat, 26 Sep 2009 15:21:43 -0500
Message-ID: <4ABE77D7.3090609@softplc.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------010105040408060806060101"
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from kcmailp01.birch.net ([216.212.0.96]:51060 "EHLO mx01.birch.net"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750795AbZIZUVk (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Sat, 26 Sep 2009 16:21:40 -0400
Received: from unknown (HELO [192.100.100.10]) ([65.16.135.194])
          (envelope-sender <dick@softplc.com>)
          by mx01.birch.net (qmail-ldap-1.03) with SMTP
          for <linux-serial@vger.kernel.org>; 26 Sep 2009 20:21:43 -0000
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

This is a multi-part message in MIME format.
--------------010105040408060806060101
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

When controlling an industrial radio modem it can be necessary to
manipulate the handshake lines in order to control the radio modem's 
transmitter.
The transmitter should not be turned off before all characters have been 
transmitted.
serial8250_tx_empty() was reporting that all characters were transmitted 
before
they actually were.

Signed-off-by: Dick Hollenbeck <dick@softplc.com>


--------------010105040408060806060101
Content-Type: text/x-diff;
 name="8250.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="8250.diff"

--- drivers/serial/8250.c.orig	2009-09-26 14:06:55.000000000 -0500
+++ drivers/serial/8250.c	2009-09-26 14:12:37.000000000 -0500
@@ -81,6 +81,9 @@ static int serial_index(struct uart_port
 
 #define PASS_LIMIT	256
 
+#define BOTH_EMPTY 	(UART_LSR_TEMT | UART_LSR_THRE)
+
+
 /*
  * We default to IRQ0 for the "no irq" hack.   Some
  * machine types want others as well - they're free
@@ -1792,7 +1795,7 @@ static unsigned int serial8250_tx_empty(
 	up->lsr_saved_flags |= lsr & LSR_SAVE_FLAGS;
 	spin_unlock_irqrestore(&up->port.lock, flags);
 
-	return lsr & UART_LSR_TEMT ? TIOCSER_TEMT : 0;
+	return (lsr & BOTH_EMPTY) == BOTH_EMPTY ? TIOCSER_TEMT : 0;
 }
 
 static unsigned int serial8250_get_mctrl(struct uart_port *port)
@@ -1850,8 +1853,6 @@ static void serial8250_break_ctl(struct 
 	spin_unlock_irqrestore(&up->port.lock, flags);
 }
 
-#define BOTH_EMPTY (UART_LSR_TEMT | UART_LSR_THRE)
-
 /*
  *	Wait for transmitter & holding register to empty
  */

--------------010105040408060806060101--

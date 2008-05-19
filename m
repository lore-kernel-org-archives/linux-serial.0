From: Aristeu Rozanski <arozansk@redhat.com>
Subject: [PATCH] 8250: fix break handling for Intel 82571
Date: Mon, 19 May 2008 10:21:10 -0400
Message-ID: <20080519142110.GB21168@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:52725 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755609AbYESOWe (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Mon, 19 May 2008 10:22:34 -0400
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id m4JEMYJT026782
	for <linux-serial@vger.kernel.org>; Mon, 19 May 2008 10:22:34 -0400
Received: from mail.boston.redhat.com (mail.boston.redhat.com [10.16.255.12])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id m4JEMXJ2029370
	for <linux-serial@vger.kernel.org>; Mon, 19 May 2008 10:22:33 -0400
Received: from napanee.usersys.redhat.com (dhcp-100-18-204.bos.redhat.com [10.16.18.204])
	by mail.boston.redhat.com (8.13.1/8.13.1) with ESMTP id m4JEMX1t000861
	for <linux-serial@vger.kernel.org>; Mon, 19 May 2008 10:22:33 -0400
Received: from napanee.usersys.redhat.com (napanee.usersys.redhat.com [127.0.0.1])
	by napanee.usersys.redhat.com (8.13.8/8.13.8) with ESMTP id m4JELAjY030918
	for <linux-serial@vger.kernel.org>; Mon, 19 May 2008 10:21:10 -0400
Received: (from aris@localhost)
	by napanee.usersys.redhat.com (8.13.8/8.13.8/Submit) id m4JELA5x030917
	for linux-serial@vger.kernel.org; Mon, 19 May 2008 10:21:10 -0400
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

Intel 82571 has a "Serial Over LAN" feature that doesn't properly implements
the receiving of break characters. When a break is received, it doesn't set
UART_LSR_DR and unless another character is received, the break won't be
received by the application.

Signed-off-by: Aristeu Rozanski <arozansk@redhat.com>

---
 drivers/serial/8250.c |   17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

--- linus-2.6.orig/drivers/serial/8250.c	2008-05-15 13:32:48.000000000 -0400
+++ linus-2.6/drivers/serial/8250.c	2008-05-15 13:48:59.000000000 -0400
@@ -1296,7 +1296,18 @@ receive_chars(struct uart_8250_port *up,
 	char flag;
 
 	do {
-		ch = serial_inp(up, UART_RX);
+		if (likely(lsr & UART_LSR_DR))
+			ch = serial_inp(up, UART_RX);
+		else
+			/*
+			 * Intel 82571 has a Serial Over Lan device that will
+			 * set UART_LSR_BI without setting UART_LSR_DR when
+			 * it receives a break. To avoid reading from the
+			 * receive buffer without UART_LSR_DR bit set, we
+			 * just force the read character to be 0
+			 */
+			ch = 0;
+
 		flag = TTY_NORMAL;
 		up->port.icount.rx++;
 
@@ -1345,7 +1356,7 @@ receive_chars(struct uart_8250_port *up,
 
 ignore_char:
 		lsr = serial_inp(up, UART_LSR);
-	} while ((lsr & UART_LSR_DR) && (max_count-- > 0));
+	} while ((lsr & (UART_LSR_DR | UART_LSR_BI)) && (max_count-- > 0));
 	spin_unlock(&up->port.lock);
 	tty_flip_buffer_push(tty);
 	spin_lock(&up->port.lock);
@@ -1428,7 +1439,7 @@ serial8250_handle_port(struct uart_8250_
 
 	DEBUG_INTR("status = %x...", status);
 
-	if (status & UART_LSR_DR)
+	if (status & (UART_LSR_DR | UART_LSR_BI))
 		receive_chars(up, &status);
 	check_modem_status(up);
 	if (status & UART_LSR_THRE)

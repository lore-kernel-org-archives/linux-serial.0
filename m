From: kees <kees@schoen.mine.nu>
Subject: [PATCH] drivers/serial/8250.c patch4
Date: Thu, 28 Jun 2007 10:42:57 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0706281041430.907@schoen3.schoen.mine.nu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7BIT
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from psmtp12.wxs.nl ([195.121.247.24]:37331 "EHLO psmtp12.wxs.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761737AbXF1Imy (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Thu, 28 Jun 2007 04:42:54 -0400
Received: from schoen3.schoen.mine.nu
 (ip5457f49a.direct-adsl.nl [84.87.244.154])
 by psmtp12.wxs.nl (iPlanet Messaging Server 5.2 HotFix 2.15 (built Nov 14
 2006)) with ESMTP id <0JKC00GL187HDX@psmtp12.wxs.nl> for
 linux-serial@vger.kernel.org; Thu, 28 Jun 2007 10:42:53 +0200 (MEST)
Received: from localhost (localhost [127.0.0.1])	by schoen3.schoen.mine.nu
 (Postfix on SuSE Linux 7.2 (i386)) with ESMTP id 8466B35A54	for
 <linux-serial@vger.kernel.org>; Thu, 28 Jun 2007 10:42:57 +0200 (CEST)
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

Hi All,

This is a more disputable item. I believe that it is better to protect 
with spinlocks any fiddling in intterupt registers/variables. This patch 
makes it more robust (in my view).

--- drivers/serial/8250.c.orig	2007-06-11 20:37:06.000000000 +0200
+++ drivers/serial/8250.c	2007-06-19 14:54:02.000000000 +0200
@@ -1937,7 +1937,8 @@ serial8250_set_termios(struct uart_port
  	if (up->bugs & UART_BUG_QUOT && (quot & 0xff) == 0)
  		quot ++;

-	if (up->capabilities & UART_CAP_FIFO && up->port.fifosize > 1) {
+	if (up->capabilities & UART_CAP_FIFO && 
+		uart_config[up->port.type].fifosize > 1) {
  		if (baud < 2400)
  			fcr = UART_FCR_ENABLE_FIFO | UART_FCR_TRIGGER_1;
  		else
@@ -1952,7 +1953,8 @@ serial8250_set_termios(struct uart_port
  	 * have sufficient FIFO entries for the latency of the remote
  	 * UART to respond.  IOW, at least 32 bytes of FIFO.
  	 */
-	if (up->capabilities & UART_CAP_AFE && up->port.fifosize >= 32) {
+	if (up->capabilities & UART_CAP_AFE && 
+		uart_config[up->port.type].fifosize >= 32) {
  		up->mcr &= ~UART_MCR_AFE;
  		if (termios->c_cflag & CRTSCTS)
  			up->mcr |= UART_MCR_AFE;

regards

Kees

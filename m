From: kees <kees@schoen.mine.nu>
Subject: [PATCH] drivers/serial/8250.c patch2
Date: Thu, 28 Jun 2007 10:40:01 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0706281038200.907@schoen3.schoen.mine.nu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7BIT
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from smtp17.wxs.nl ([195.121.247.8]:64358 "EHLO smtp17.wxs.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762599AbXF1Ij7 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Thu, 28 Jun 2007 04:39:59 -0400
Received: from schoen3.schoen.mine.nu
 (ip5457f49a.direct-adsl.nl [84.87.244.154])
 by smtp17.wxs.nl (iPlanet Messaging Server 5.2 HotFix 2.15 (built Nov 14
 2006)) with ESMTP id <0JKC00BWT82MKJ@smtp17.wxs.nl> for
 linux-serial@vger.kernel.org; Thu, 28 Jun 2007 10:39:58 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])	by schoen3.schoen.mine.nu
 (Postfix on SuSE Linux 7.2 (i386)) with ESMTP id ACEC635A54	for
 <linux-serial@vger.kernel.org>; Thu, 28 Jun 2007 10:40:01 +0200 (CEST)
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

Hi All,

I found that setserial in serial_core.c  does not update all port 
variables. It _does_ update the type variable properly but fails to update 
tx_loadsz. This causes the driver to fail after setserial to another 
device i.e. 8250 or 16450.
This patch solves that for the devices which are served by 8250.c. There 
is a deeper problem though, setserial does not properly update all port 
variables. Maybe the prot drivers should have their own
.setserial   entry in the table and handle the details themselves.


--- drivers/serial/8250.c.orig	2007-06-11 20:37:06.000000000 +0200
+++ drivers/serial/8250.c	2007-06-19 14:47:47.000000000 +0200
@@ -1288,7 +1288,7 @@ static void transmit_chars(struct uart_8
  		return;
  	}

-	count = up->tx_loadsz;
+	count = uart_config[up->port.type].tx_loadsz;
  	do {
  		serial_out(up, UART_TX, xmit->buf[xmit->tail]);
  		xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);


regards

Kees


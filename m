From: Ian Abbott <abbotti@mev.co.uk>
Subject: [PATCH][2.6.10-rc2-bk9] 8250 fix for unconfigured FIFO size
Date: Fri, 26 Nov 2004 21:30:49 +0000
Message-ID: <41A7A089.1080003@mev.co.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------010606060800090408090000"
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.229.2]:8620 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S263959AbUKZVuZ (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 26 Nov 2004 16:50:25 -0500
Received: from root by main.gmane.org with local (Exim 3.35 #1 (Debian))
	id 1CXnys-0000rz-00
	for <linux-serial@vger.kernel.org>; Fri, 26 Nov 2004 22:50:18 +0100
Received: from mail.mev.co.uk ([62.49.15.74])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-serial@vger.kernel.org>; Fri, 26 Nov 2004 22:50:18 +0100
Received: from abbotti by mail.mev.co.uk with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-serial@vger.kernel.org>; Fri, 26 Nov 2004 22:50:18 +0100
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Russell King <rmk+serial@vger.kernel.org>

This is a multi-part message in MIME format.
--------------010606060800090408090000
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

[Reposting due to Cc: address mix-up the first time!]

Hi,

In the 8250 driver, for a serial port manually configured by setserial
(not using autoconfig), the FIFO size and the TX load size do not get
set.  The attached patch fixes that.  During UART startup, it sanitizes
the FIFO size and the TX load size.

This might also fix Alexandre Courbot's problem (which I suspect is due
to the old FIFO size being remembered):

  > Subject: Bug with 2.6 serial driver when in UART 8250 mode
  > Date: Thu, 19 Aug 2004 18:53:49 +0200

Signed-off-by: Ian Abbott <abbotti@mev.co.uk>


--------------010606060800090408090000
Content-Type: text/x-patch;
 name="8250_fifosize.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="8250_fifosize.patch"

diff -urN linux-2.6.10-rc2-bk9/drivers/serial/8250.c linux-2.6.10-rc2-bk9-ia/drivers/serial/8250.c
--- linux-2.6.10-rc2-bk9/drivers/serial/8250.c	2004-11-26 17:26:45.571917552 +0000
+++ linux-2.6.10-rc2-bk9-ia/drivers/serial/8250.c	2004-11-26 19:59:50.614578824 +0000
@@ -1359,6 +1359,14 @@
 	up->capabilities = uart_config[up->port.type].flags;
 	up->mcr = 0;
 
+	if (up->port.fifosize <= 0 ||
+	    up->port.fifosize > uart_config[up->port.type].fifo_size)
+		up->port.fifosize = uart_config[up->port.type].fifo_size;
+	if (up->tx_loadsz == 0)
+		up->tx_loadsz = uart_config[up->port.type].tx_loadsz;
+	if (up->tx_loadsz > up->port.fifosize)
+		up->tx_loadsz = up->port.fifosize;
+
 	if (up->port.type == PORT_16C950) {
 		/* Wake up and initialize UART */
 		up->acr = 0;


--------------010606060800090408090000--


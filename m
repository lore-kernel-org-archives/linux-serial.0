From: Yegor Yefremov <yegor_sub1@visionsystems.de>
Subject: [PATCH] serial: add UART_CAP_EFR and UART_CAP_SLEEP flags to 16C950
 UARTs definition
Date: Wed, 16 Jun 2010 16:29:55 +0200
Message-ID: <4C18DFE3.2030109@visionsystems.de>
Reply-To: yegor_sub1@visionsystems.de
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from ns.visionsystems.de ([62.145.30.242]:35883 "EHLO
	mail.visionsystems.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753802Ab0FPOad (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 16 Jun 2010 10:30:33 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Greg KH <greg@kroah.com>

Adding UART_CAP_EFR and UART_CAP_SLEEP flags will enable sleep mode
and automatic CTS flow control for 16C950 UARTs. It will also avoid 
capabilities detection warning like this:

"ttyS0: detected caps 00000700 should be 00000100"

Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>

Index: b/drivers/serial/8250.c
===================================================================
--- a/drivers/serial/8250.c	2010-05-27 09:38:40.000000000 +0200
+++ b/drivers/serial/8250.c	2010-06-16 16:20:59.000000000 +0200
@@ -241,7 +241,7 @@
 		.fifo_size	= 128,
 		.tx_loadsz	= 128,
 		.fcr		= UART_FCR_ENABLE_FIFO | UART_FCR_R_TRIG_10,
-		.flags		= UART_CAP_FIFO,
+		.flags		= UART_CAP_FIFO | UART_CAP_EFR | UART_CAP_SLEEP,
 	},
 	[PORT_16654] = {
 		.name		= "ST16654",


From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: [PATCH] 8250 resourse management fixes
Date: Sat, 09 Sep 2006 22:23:56 +0400
Message-ID: <450306BC.8050408@ru.mvista.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------020004020301010005000402"
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.155]:30459 "EHLO
	imap.sh.mvista.com") by vger.kernel.org with ESMTP id S1751359AbWIISVn
	(ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Sat, 9 Sep 2006 14:21:43 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: rmk+serial@arm.linux.org.uk
Cc: tie-fei.zang@freescale.com, linux-serial@vger.kernel.org

This is a multi-part message in MIME format.
--------------020004020301010005000402
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

I think register ranges obviously need to be claimed/released for all UARTs
including those with UPIO_MEM32 and UPIO_TSI iotype.

Also, serial8250_request_rsa_resources() returns false positives with
UPIO_MEM32, UPIO_AU, and UPIO_TSI iotype -- I don't think this makes any sense.

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>



--------------020004020301010005000402
Content-Type: text/plain;
 name="8250-resource-management-fixes.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="8250-resource-management-fixes.patch"

Index: linux-mips/drivers/serial/8250.c
===================================================================
--- linux-mips.orig/drivers/serial/8250.c
+++ linux-mips/drivers/serial/8250.c
@@ -1949,6 +1949,8 @@ static int serial8250_request_std_resour
 	case UPIO_AU:
 		size = 0x100000;
 		/* fall thru */
+	case UPIO_TSI:
+	case UPIO_MEM32:
 	case UPIO_MEM:
 		if (!up->port.mapbase)
 			break;
@@ -1984,6 +1986,8 @@ static void serial8250_release_std_resou
 	case UPIO_AU:
 		size = 0x100000;
 		/* fall thru */
+	case UPIO_TSI:
+	case UPIO_MEM32:
 	case UPIO_MEM:
 		if (!up->port.mapbase)
 			break;
@@ -2007,17 +2011,15 @@ static int serial8250_request_rsa_resour
 {
 	unsigned long start = UART_RSA_BASE << up->port.regshift;
 	unsigned int size = 8 << up->port.regshift;
-	int ret = 0;
+	int ret = -EINVAL;
 
 	switch (up->port.iotype) {
-	case UPIO_MEM:
-		ret = -EINVAL;
-		break;
-
 	case UPIO_HUB6:
 	case UPIO_PORT:
 		start += up->port.iobase;
-		if (!request_region(start, size, "serial-rsa"))
+		if (request_region(start, size, "serial-rsa"))
+			ret = 0;
+		else
 			ret = -EBUSY;
 		break;
 	}
@@ -2031,9 +2033,6 @@ static void serial8250_release_rsa_resou
 	unsigned int size = 8 << up->port.regshift;
 
 	switch (up->port.iotype) {
-	case UPIO_MEM:
-		break;
-
 	case UPIO_HUB6:
 	case UPIO_PORT:
 		release_region(up->port.iobase + offset, size);


--------------020004020301010005000402--

From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: [PATCH] AMD Alchemy UART: claim memory range
Date: Sat, 29 Apr 2006 21:24:14 +0400
Message-ID: <4453A13E.7040009@ru.mvista.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------000602020103010208080709"
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from rtsoft2.corbina.net ([85.21.88.2]:35981 "HELO
	mail.dev.rtsoft.ru") by vger.kernel.org with SMTP id S1750765AbWD2RZW
	(ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Sat, 29 Apr 2006 13:25:22 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>
Cc: rmk+serial@arm.linux.org.uk, linux-serial@vger.kernel.org

This is a multi-part message in MIME format.
--------------000602020103010208080709
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Resending since there was no reaction since the initial mail (4/4/2006)...

I've noticed that the 8250/Au1x00 driver (drivers/serial/8250_au1x00.c)
doesn't claim UART memory ranges and uses wrong (KSEG1-based) UART addresses
instead of the physical ones.

WBR, Sergei

Sighed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>


--------------000602020103010208080709
Content-Type: text/plain;
 name="Au1xx0-claim-UART-range.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="Au1xx0-claim-UART-range.patch"

diff --git a/drivers/serial/8250.c b/drivers/serial/8250.c
index 674b15c..d641ac4 100644
--- a/drivers/serial/8250.c
+++ b/drivers/serial/8250.c
@@ -1906,6 +1906,9 @@ static int serial8250_request_std_resour
 	int ret = 0;
 
 	switch (up->port.iotype) {
+	case UPIO_AU:
+		size = 0x100000;
+		/* fall thru */
 	case UPIO_MEM:
 		if (!up->port.mapbase)
 			break;
@@ -1938,6 +1941,9 @@ static void serial8250_release_std_resou
 	unsigned int size = 8 << up->port.regshift;
 
 	switch (up->port.iotype) {
+	case UPIO_AU:
+		size = 0x100000;
+		/* fall thru */
 	case UPIO_MEM:
 		if (!up->port.mapbase)
 			break;
diff --git a/drivers/serial/8250_au1x00.c b/drivers/serial/8250_au1x00.c
index 3d1bfd0..58015fd 100644
--- a/drivers/serial/8250_au1x00.c
+++ b/drivers/serial/8250_au1x00.c
@@ -30,13 +30,12 @@
 	{						\
 		.iobase		= _base,		\
 		.membase	= (void __iomem *)_base,\
-		.mapbase	= _base,		\
+		.mapbase	= CPHYSADDR(_base),	\
 		.irq		= _irq,			\
 		.uartclk	= 0,	/* filled */	\
 		.regshift	= 2,			\
 		.iotype		= UPIO_AU,		\
-		.flags		= UPF_SKIP_TEST | 	\
-				  UPF_IOREMAP,		\
+		.flags		= UPF_SKIP_TEST 	\
 	}
 
 static struct plat_serial8250_port au1x00_data[] = {





--------------000602020103010208080709--

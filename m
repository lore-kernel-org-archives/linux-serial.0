From: Jingoo Han <jg1.han@samsung.com>
Subject: [PATCH 03/10] serial: mrst_max3110: fix casting warning
Date: Thu, 08 Aug 2013 17:32:52 +0900
Message-ID: <005e01ce9411$df82a8c0$9e87fa40$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:38268 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756564Ab3HHIcx (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 8 Aug 2013 04:32:53 -0400
Received: from epcpsbgr1.samsung.com
 (u141.gpu120.samsung.co.kr [203.254.230.141])
 by mailout4.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MR700KVLEESEEC0@mailout4.samsung.com> for
 linux-serial@vger.kernel.org; Thu, 08 Aug 2013 17:32:52 +0900 (KST)
Content-language: ko
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: 'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>
Cc: 'Jiri Slaby' <jslaby@suse.cz>, linux-serial@vger.kernel.org, Jingoo Han <jg1.han@samsung.com>

max->port.membase is (unsigned char __iomem *); thus,
casting (unsigned char __iomem *) is necessary to fix
the following warning. Also, serial_m3110_ops() is staticized.

drivers/tty/serial/mrst_max3110.c:716:17: warning: symbol 'serial_m3110_ops' was not declared. Should it be static?
drivers/tty/serial/mrst_max3110.c:847:27: warning: incorrect type in assignment (different address spaces)
drivers/tty/serial/mrst_max3110.c:847:27:    expected unsigned char [noderef] <asn:2>*membase
drivers/tty/serial/mrst_max3110.c:847:27:    got void *<noident>

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/tty/serial/mrst_max3110.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/mrst_max3110.c b/drivers/tty/serial/mrst_max3110.c
index 9b6ef20..a67e708 100644
--- a/drivers/tty/serial/mrst_max3110.c
+++ b/drivers/tty/serial/mrst_max3110.c
@@ -713,7 +713,7 @@ static void serial_m3110_enable_ms(struct uart_port *port)
 {
 }
 
-struct uart_ops serial_m3110_ops = {
+static struct uart_ops serial_m3110_ops = {
 	.tx_empty	= serial_m3110_tx_empty,
 	.set_mctrl	= serial_m3110_set_mctrl,
 	.get_mctrl	= serial_m3110_get_mctrl,
@@ -844,7 +844,7 @@ static int serial_m3110_probe(struct spi_device *spi)
 	pmax = max;
 
 	/* Give membase a psudo value to pass serial_core's check */
-	max->port.membase = (void *)0xff110000;
+	max->port.membase = (unsigned char __iomem *)0xff110000;
 	uart_add_one_port(&serial_m3110_reg, &max->port);
 
 	return 0;
-- 
1.7.10.4



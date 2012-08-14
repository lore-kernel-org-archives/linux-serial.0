From: David Daney <ddaney.cavm@gmail.com>
Subject: [PATCH] MIPS: OCTEON: Fix breakage due to 8250 changes.
Date: Tue, 14 Aug 2012 09:42:39 -0700
Message-ID: <1344962559-6823-1-git-send-email-ddaney.cavm@gmail.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-vc0-f174.google.com ([209.85.220.174]:55479 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752481Ab2HNQnH (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 14 Aug 2012 12:43:07 -0400
Received: by vcbfk26 with SMTP id fk26so536130vcb.19
        for <linux-serial@vger.kernel.org>; Tue, 14 Aug 2012 09:43:07 -0700 (PDT)
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-mips@linux-mips.org, ralf@linux-mips.org, linux-serial@vger.kernel.org
Cc: David Daney <david.daney@cavium.com>, Alan Cox <alan@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>

From: David Daney <david.daney@cavium.com>

The changes in linux-next removing serial8250_register_port() cause
OCTEON to fail to compile.

Lets make OCTEON use the new serial8250_register_8250_port() instead.

Signed-off-by: David Daney <david.daney@cavium.com>
Cc: Alan Cox <alan@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---

Perhaps we can get an Acked-by from Ralf, and then merge this along
with the 8250 patches that caused the breakage?  What do you think?

 arch/mips/cavium-octeon/serial.c |   30 +++++++++++++++---------------
 1 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/arch/mips/cavium-octeon/serial.c b/arch/mips/cavium-octeon/serial.c
index 138b221..569f41b 100644
--- a/arch/mips/cavium-octeon/serial.c
+++ b/arch/mips/cavium-octeon/serial.c
@@ -47,40 +47,40 @@ static int __devinit octeon_serial_probe(struct platform_device *pdev)
 {
 	int irq, res;
 	struct resource *res_mem;
-	struct uart_port port;
+	struct uart_8250_port up;
 
 	/* All adaptors have an irq.  */
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0)
 		return irq;
 
-	memset(&port, 0, sizeof(port));
+	memset(&up, 0, sizeof(up));
 
-	port.flags = ASYNC_SKIP_TEST | UPF_SHARE_IRQ | UPF_FIXED_TYPE;
-	port.type = PORT_OCTEON;
-	port.iotype = UPIO_MEM;
-	port.regshift = 3;
-	port.dev = &pdev->dev;
+	up.port.flags = ASYNC_SKIP_TEST | UPF_SHARE_IRQ | UPF_FIXED_TYPE;
+	up.port.type = PORT_OCTEON;
+	up.port.iotype = UPIO_MEM;
+	up.port.regshift = 3;
+	up.port.dev = &pdev->dev;
 
 	if (octeon_is_simulation())
 		/* Make simulator output fast*/
-		port.uartclk = 115200 * 16;
+		up.port.uartclk = 115200 * 16;
 	else
-		port.uartclk = octeon_get_io_clock_rate();
+		up.port.uartclk = octeon_get_io_clock_rate();
 
-	port.serial_in = octeon_serial_in;
-	port.serial_out = octeon_serial_out;
-	port.irq = irq;
+	up.port.serial_in = octeon_serial_in;
+	up.port.serial_out = octeon_serial_out;
+	up.port.irq = irq;
 
 	res_mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (res_mem == NULL) {
 		dev_err(&pdev->dev, "found no memory resource\n");
 		return -ENXIO;
 	}
-	port.mapbase = res_mem->start;
-	port.membase = ioremap(res_mem->start, resource_size(res_mem));
+	up.port.mapbase = res_mem->start;
+	up.port.membase = ioremap(res_mem->start, resource_size(res_mem));
 
-	res = serial8250_register_port(&port);
+	res = serial8250_register_8250_port(&up);
 
 	return res >= 0 ? 0 : res;
 }
-- 
1.7.2.3


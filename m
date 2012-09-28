From: Alexey Brodkin <Alexey.Brodkin@synopsys.com>
Subject: [PATCH v2] serial/8250/8250_early: Prevent rounding error in uartclk to baud ratio
Date: Fri, 28 Sep 2012 19:00:46 +0400
Message-ID: <1348844446-28165-1-git-send-email-abrodkin@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from us01smtp2.synopsys.com ([198.182.44.80]:37853 "EHLO
	kiruna.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758437Ab2I1PKd (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 28 Sep 2012 11:10:33 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: gregkh@linuxfoundation.org, alan@linux.intel.com
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Vineet.Gupta1@synopsys.com, Alexey.Brodkin@synopsys.com

Modify divisor to select the nearest baud rate divider rather than the
lowest. It minimizes baud rate errors especially on low UART clock
frequencies.

For example, if uartclk is 33000000 and baud is 115200 the ratio is
about 17.9 The current code selects 17 (5% error) but should select 18
(0.5% error).

This 5% error in baud rate leads to garbage on receiving end, while 0.5%
doesn't.

Signed-off-by: Alexey Brodkin <abrodkin@synopsys.com>
---
 drivers/tty/serial/8250/8250_early.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_early.c b/drivers/tty/serial/8250/8250_early.c
index eaafb98..843a150 100644
--- a/drivers/tty/serial/8250/8250_early.c
+++ b/drivers/tty/serial/8250/8250_early.c
@@ -140,7 +140,7 @@ static void __init init_port(struct early_serial8250_device *device)
 	serial_out(port, UART_FCR, 0);		/* no fifo */
 	serial_out(port, UART_MCR, 0x3);	/* DTR + RTS */
 
-	divisor = port->uartclk / (16 * device->baud);
+	divisor = DIV_ROUND_CLOSEST(port->uartclk, 16 * device->baud);
 	c = serial_in(port, UART_LCR);
 	serial_out(port, UART_LCR, c | UART_LCR_DLAB);
 	serial_out(port, UART_DLL, divisor & 0xff);
-- 
1.7.9.5


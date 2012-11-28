From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: [PATCH 2/5] serial: 8250_dw: Don't use UPF_FIXED_TYPE
Date: Wed, 28 Nov 2012 14:48:41 +0200
Message-ID: <1354106924-11013-3-git-send-email-heikki.krogerus@linux.intel.com>
References: <1354106924-11013-1-git-send-email-heikki.krogerus@linux.intel.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:47427 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754804Ab2K1Mrc (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 28 Nov 2012 07:47:32 -0500
In-Reply-To: <1354106924-11013-1-git-send-email-heikki.krogerus@linux.intel.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Alan Cox <alan@linux.intel.com>, Jamie Iles <jamie@jamieiles.com>, linux-serial@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

Allow 8250.c to determine the port type for us. This allows
the driver take advantage of FIFO on Designware UARTs that
have it.

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 drivers/tty/serial/8250/8250_dw.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index c3b2ec0..8d45be5 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -112,7 +112,7 @@ static int __devinit dw8250_probe(struct platform_device *pdev)
 	uart.port.handle_irq = dw8250_handle_irq;
 	uart.port.type = PORT_8250;
 	uart.port.flags = UPF_SHARE_IRQ | UPF_BOOT_AUTOCONF | UPF_IOREMAP |
-		UPF_FIXED_PORT | UPF_FIXED_TYPE;
+		UPF_FIXED_PORT;
 	uart.port.dev = &pdev->dev;
 
 	uart.port.iotype = UPIO_MEM;
-- 
1.7.10.4


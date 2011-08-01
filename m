From: Sonic Zhang <sonic.adi@gmail.com>
Subject: [PATCH 2/2] serial:blackfin: Put TX IRQ in individual platform resource. Fix typo.
Date: Mon, 1 Aug 2011 18:13:12 +0800
Message-ID: <1312193592-6672-1-git-send-email-sonic.adi@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from tx2ehsobe002.messaging.microsoft.com ([65.55.88.12]:45041 "EHLO
	TX2EHSOBE003.bigfish.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752847Ab1HAKTO (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 1 Aug 2011 06:19:14 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Cox <alan@linux.intel.com>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, uclinux-dist-devel@blackfin.uclinux.org, Sonic Zhang <sonic.zhang@analog.com>

From: Sonic Zhang <sonic.zhang@analog.com>

Fix typo in last patch.

Signed-off-by: Sonic Zhang <sonic.zhang@analog.com>
---
 drivers/tty/serial/bfin_uart.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/tty/serial/bfin_uart.c b/drivers/tty/serial/bfin_uart.c
index b907a2a..881c6e7 100644
--- a/drivers/tty/serial/bfin_uart.c
+++ b/drivers/tty/serial/bfin_uart.c
@@ -674,7 +674,7 @@ static int bfin_serial_startup(struct uart_port *port)
 	}
 
 	if (request_irq
-	    (uart->port.tx_irq, bfin_serial_tx_int, IRQF_DISABLED,
+	    (uart->tx_irq, bfin_serial_tx_int, IRQF_DISABLED,
 	     "BFIN_UART_TX", uart)) {
 		printk(KERN_NOTICE "Unable to attach BlackFin UART TX interrupt\n");
 		free_irq(uart->rx_irq, uart);
-- 
1.7.0.4



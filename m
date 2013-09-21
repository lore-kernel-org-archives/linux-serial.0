From: Barry Song <21cnbao@gmail.com>
Subject: [PATCH] serial: sirf: don't submit dma desc after timeout irqs occur
Date: Sat, 21 Sep 2013 09:02:10 +0800
Message-ID: <1379725330-5579-1-git-send-email-Baohua.Song@csr.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-pa0-f44.google.com ([209.85.220.44]:55634 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751702Ab3IUBCc (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 20 Sep 2013 21:02:32 -0400
Received: by mail-pa0-f44.google.com with SMTP id lf10so68971pab.3
        for <linux-serial@vger.kernel.org>; Fri, 20 Sep 2013 18:02:31 -0700 (PDT)
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org, workgroup.linux@csr.com, Qipan Li <Qipan.Li@csr.com>, Barry Song <Baohua.Song@csr.com>

From: Qipan Li <Qipan.Li@csr.com>

In rx timeout ISR and tasklet, we don't issue new dma desc as rx_done ISR
will do that.

Signed-off-by: Qipan Li <Qipan.Li@csr.com>
Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 drivers/tty/serial/sirfsoc_uart.c |   11 +++++++++--
 1 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/sirfsoc_uart.c b/drivers/tty/serial/sirfsoc_uart.c
index 61c1ad0..f186a8f 100644
--- a/drivers/tty/serial/sirfsoc_uart.c
+++ b/drivers/tty/serial/sirfsoc_uart.c
@@ -529,7 +529,7 @@ static void sirfsoc_rx_tmo_process_tl(unsigned long param)
 	while (sirfport->rx_completed != sirfport->rx_issued) {
 		sirfsoc_uart_insert_rx_buf_to_tty(sirfport,
 					SIRFSOC_RX_DMA_BUF_SIZE);
-		sirfsoc_rx_submit_one_dma_desc(port, sirfport->rx_completed++);
+		sirfport->rx_completed++;
 		sirfport->rx_completed %= SIRFSOC_RX_LOOP_BUF_CNT;
 	}
 	count = CIRC_CNT(sirfport->rx_dma_items[sirfport->rx_issued].xmit.head,
@@ -706,12 +706,19 @@ static void sirfsoc_uart_rx_dma_complete_tl(unsigned long param)
 {
 	struct sirfsoc_uart_port *sirfport = (struct sirfsoc_uart_port *)param;
 	struct uart_port *port = &sirfport->port;
+	struct sirfsoc_register *ureg = &sirfport->uart_reg->uart_reg;
+	struct sirfsoc_int_en *uint_en = &sirfport->uart_reg->uart_int_en;
 	unsigned long flags;
 	spin_lock_irqsave(&sirfport->rx_lock, flags);
 	while (sirfport->rx_completed != sirfport->rx_issued) {
 		sirfsoc_uart_insert_rx_buf_to_tty(sirfport,
 					SIRFSOC_RX_DMA_BUF_SIZE);
-		sirfsoc_rx_submit_one_dma_desc(port, sirfport->rx_completed++);
+		if (rd_regl(port, ureg->sirfsoc_int_en_reg) &
+				uint_en->sirfsoc_rx_timeout_en)
+			sirfsoc_rx_submit_one_dma_desc(port,
+					sirfport->rx_completed++);
+		else
+			sirfport->rx_completed++;
 		sirfport->rx_completed %= SIRFSOC_RX_LOOP_BUF_CNT;
 	}
 	spin_unlock_irqrestore(&sirfport->rx_lock, flags);
-- 
1.7.5.4


From: Barry Song <21cnbao@gmail.com>
Subject: [PATCH 3/3] serial: sirf: correct condition for fetching dma buffer into tty
Date: Fri,  3 Jan 2014 15:44:08 +0800
Message-ID: <1388735048-16093-3-git-send-email-21cnbao@gmail.com>
References: <1388735048-16093-1-git-send-email-21cnbao@gmail.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-pd0-f174.google.com ([209.85.192.174]:56418 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750853AbaACHo4 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 3 Jan 2014 02:44:56 -0500
Received: by mail-pd0-f174.google.com with SMTP id x10so14882774pdj.5
        for <linux-serial@vger.kernel.org>; Thu, 02 Jan 2014 23:44:56 -0800 (PST)
In-Reply-To: <1388735048-16093-1-git-send-email-21cnbao@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org, workgroup.linux@csr.com, Qipan Li <Qipan.Li@csr.com>, Barry Song <Baohua.Song@csr.com>

From: Qipan Li <Qipan.Li@csr.com>

In rx dma-callback it calls tasklet_schedule, if the tasklet
be scheduled after all the dma-callback in the rx dma channel,
current check condition in the tasklet will not do fetch dma
buffer into tty because tx_issued is equal with tx_completed,
so as timeout tasklet does.

so we check whether we should fetch the whole dma buffer into
tty according to the status of transactions in rx dma channel.

Signed-off-by: Qipan Li <Qipan.Li@csr.com>
Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 drivers/tty/serial/sirfsoc_uart.c |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/sirfsoc_uart.c b/drivers/tty/serial/sirfsoc_uart.c
index a6c38ab..49a2ffd 100644
--- a/drivers/tty/serial/sirfsoc_uart.c
+++ b/drivers/tty/serial/sirfsoc_uart.c
@@ -524,9 +524,11 @@ static void sirfsoc_rx_tmo_process_tl(unsigned long param)
 	struct sirfsoc_int_status *uint_st = &sirfport->uart_reg->uart_int_st;
 	unsigned int count;
 	unsigned long flags;
+	struct dma_tx_state tx_state;
 
 	spin_lock_irqsave(&sirfport->rx_lock, flags);
-	while (sirfport->rx_completed != sirfport->rx_issued) {
+	while (DMA_COMPLETE == dmaengine_tx_status(sirfport->rx_dma_chan,
+		sirfport->rx_dma_items[sirfport->rx_completed].cookie, &tx_state)) {
 		sirfsoc_uart_insert_rx_buf_to_tty(sirfport,
 					SIRFSOC_RX_DMA_BUF_SIZE);
 		sirfport->rx_completed++;
@@ -709,8 +711,10 @@ static void sirfsoc_uart_rx_dma_complete_tl(unsigned long param)
 	struct sirfsoc_register *ureg = &sirfport->uart_reg->uart_reg;
 	struct sirfsoc_int_en *uint_en = &sirfport->uart_reg->uart_int_en;
 	unsigned long flags;
+	struct dma_tx_state tx_state;
 	spin_lock_irqsave(&sirfport->rx_lock, flags);
-	while (sirfport->rx_completed != sirfport->rx_issued) {
+	while (DMA_COMPLETE == dmaengine_tx_status(sirfport->rx_dma_chan,
+			sirfport->rx_dma_items[sirfport->rx_completed].cookie, &tx_state)) {
 		sirfsoc_uart_insert_rx_buf_to_tty(sirfport,
 					SIRFSOC_RX_DMA_BUF_SIZE);
 		if (rd_regl(port, ureg->sirfsoc_int_en_reg) &
-- 
1.7.5.4


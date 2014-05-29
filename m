From: Daniel Thompson <daniel.thompson@linaro.org>
Subject: [PATCH v6] serial: sirf: Fix compilation failure
Date: Thu, 29 May 2014 11:03:34 +0100
Message-ID: <1401357814-15772-1-git-send-email-daniel.thompson@linaro.org>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-wg0-f41.google.com ([74.125.82.41]:44843 "EHLO
	mail-wg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756608AbaE2KDp (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 29 May 2014 06:03:45 -0400
Received: by mail-wg0-f41.google.com with SMTP id z12so125834wgg.24
        for <linux-serial@vger.kernel.org>; Thu, 29 May 2014 03:03:44 -0700 (PDT)
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Daniel Thompson <daniel.thompson@linaro.org>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, patches@linaro.org, linaro-kernel@lists.linaro.org, Jiri Slaby <jslaby@suse.cz>, Barry Song <baohua@kernel.org>, Qipan Li <Qipan.Li@csr.com>, linux-serial@vger.kernel.org

After 07d410e0) serial: sirf: fix spinlock deadlock issue it is no longer
possiblet to compile this driver. The rename of one of the spinlocks is
faulty. After looking at the original patch I believe this is the correct
fix.

Compile tested using ARM's multi_v7_defconfig

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>
Cc: Barry Song <baohua@kernel.org>
Cc: Qipan Li <Qipan.Li@csr.com>
Cc: linux-serial@vger.kernel.org
Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
---
 drivers/tty/serial/sirfsoc_uart.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/sirfsoc_uart.c b/drivers/tty/serial/sirfsoc_uart.c
index 236f892..1f2be48 100644
--- a/drivers/tty/serial/sirfsoc_uart.c
+++ b/drivers/tty/serial/sirfsoc_uart.c
@@ -704,7 +704,7 @@ static void sirfsoc_uart_rx_dma_complete_tl(unsigned long param)
 	struct sirfsoc_int_en *uint_en = &sirfport->uart_reg->uart_int_en;
 	unsigned long flags;
 	struct dma_tx_state tx_state;
-	spin_lock_irqsave(&port->rx_lock, flags);
+	spin_lock_irqsave(&port->lock, flags);
 	while (DMA_COMPLETE == dmaengine_tx_status(sirfport->rx_dma_chan,
 			sirfport->rx_dma_items[sirfport->rx_completed].cookie, &tx_state)) {
 		sirfsoc_uart_insert_rx_buf_to_tty(sirfport,
-- 
1.9.0


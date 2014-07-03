From: Barry Song <21cnbao@gmail.com>
Subject: [PATCH] serial: sirf: transfer more bytes once to decrease interrupts
Date: Thu,  3 Jul 2014 21:26:59 +0800
Message-ID: <1404394019-24475-1-git-send-email-21cnbao@gmail.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-pd0-f172.google.com ([209.85.192.172]:48810 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932445AbaGCN1L (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 3 Jul 2014 09:27:11 -0400
Received: by mail-pd0-f172.google.com with SMTP id w10so222287pde.17
        for <linux-serial@vger.kernel.org>; Thu, 03 Jul 2014 06:27:11 -0700 (PDT)
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: gregkh@linuxfoundation.org, linux-serial@vger.kernel.org
Cc: workgroup.linux@csr.com, Qipan Li <Qipan.Li@csr.com>, Barry Song <Baohua.Song@csr.com>

From: Qipan Li <Qipan.Li@csr.com>

the current codes send 1 bytes, then after getting TX done interrupt,
send subsequent bytes. it causes redundant interrupts.
for example, if we have 3 bytes in TX buffer, the TX flow is:
1. send 1 byte
2. get TX down interrupt
3. send the left 2 bytes
4. get TX down interrupt

this patch moves to send more bytes and decrease interrupts, the new
flow is:
1. send 3 bytes
2. get TX down interrupt

Signed-off-by: Qipan Li <Qipan.Li@csr.com>
Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 drivers/tty/serial/sirfsoc_uart.c | 3 ++-
 drivers/tty/serial/sirfsoc_uart.h | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/sirfsoc_uart.c b/drivers/tty/serial/sirfsoc_uart.c
index 9b4d71c..4102192 100644
--- a/drivers/tty/serial/sirfsoc_uart.c
+++ b/drivers/tty/serial/sirfsoc_uart.c
@@ -290,7 +290,8 @@ static void sirfsoc_uart_start_tx(struct uart_port *port)
 	if (sirfport->tx_dma_chan)
 		sirfsoc_uart_tx_with_dma(sirfport);
 	else {
-		sirfsoc_uart_pio_tx_chars(sirfport, 1);
+		sirfsoc_uart_pio_tx_chars(sirfport,
+			SIRFSOC_UART_IO_TX_REASONABLE_CNT);
 		wr_regl(port, ureg->sirfsoc_tx_fifo_op, SIRFUART_FIFO_START);
 		if (!sirfport->is_marco)
 			wr_regl(port, ureg->sirfsoc_int_en_reg,
diff --git a/drivers/tty/serial/sirfsoc_uart.h b/drivers/tty/serial/sirfsoc_uart.h
index 69a62eb..6a7ebf7 100644
--- a/drivers/tty/serial/sirfsoc_uart.h
+++ b/drivers/tty/serial/sirfsoc_uart.h
@@ -449,4 +449,4 @@ struct sirfsoc_uart_port {
 
 /* I/O Mode */
 #define SIRFSOC_UART_IO_RX_MAX_CNT		256
-#define SIRFSOC_UART_IO_TX_REASONABLE_CNT	6
+#define SIRFSOC_UART_IO_TX_REASONABLE_CNT	256
-- 
1.9.3


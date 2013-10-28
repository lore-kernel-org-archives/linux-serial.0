From: Jingoo Han <jg1.han@samsung.com>
Subject: [PATCH] serial: mfd: Staticize local symbols
Date: Mon, 28 Oct 2013 09:48:52 +0900
Message-ID: <002201ced377$794f1d40$6bed57c0$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:44416 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754507Ab3J1Asz (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sun, 27 Oct 2013 20:48:55 -0400
Received: from epcpsbgr5.samsung.com
 (u145.gpu120.samsung.co.kr [203.254.230.145])
 by mailout3.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MVC00IUMSXH9770@mailout3.samsung.com> for
 linux-serial@vger.kernel.org; Mon, 28 Oct 2013 09:48:53 +0900 (KST)
Content-language: ko
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: 'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org, 'Jingoo Han' <jg1.han@samsung.com>

These local symbols are used only in this file.
Fix the following sparse warnings:

drivers/tty/serial/mfd.c:296:6: warning: symbol 'hsu_dma_tx' was not declared. Should it be static?
drivers/tty/serial/mfd.c:343:6: warning: symbol 'hsu_dma_start_rx_chan' was not declared. Should it be static?
drivers/tty/serial/mfd.c:389:6: warning: symbol 'hsu_dma_rx' was not declared. Should it be static?
drivers/tty/serial/mfd.c:1186:17: warning: symbol 'serial_hsu_pops' was not declared. Should it be static?

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/tty/serial/mfd.c |   10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/mfd.c b/drivers/tty/serial/mfd.c
index 503dcc7..52c930f 100644
--- a/drivers/tty/serial/mfd.c
+++ b/drivers/tty/serial/mfd.c
@@ -293,7 +293,7 @@ static void serial_hsu_enable_ms(struct uart_port *port)
 	serial_out(up, UART_IER, up->ier);
 }
 
-void hsu_dma_tx(struct uart_hsu_port *up)
+static void hsu_dma_tx(struct uart_hsu_port *up)
 {
 	struct circ_buf *xmit = &up->port.state->xmit;
 	struct hsu_dma_buffer *dbuf = &up->txbuf;
@@ -340,7 +340,8 @@ void hsu_dma_tx(struct uart_hsu_port *up)
 }
 
 /* The buffer is already cache coherent */
-void hsu_dma_start_rx_chan(struct hsu_dma_chan *rxc, struct hsu_dma_buffer *dbuf)
+static void hsu_dma_start_rx_chan(struct hsu_dma_chan *rxc,
+					struct hsu_dma_buffer *dbuf)
 {
 	dbuf->ofs = 0;
 
@@ -386,7 +387,8 @@ static void serial_hsu_stop_tx(struct uart_port *port)
 
 /* This is always called in spinlock protected mode, so
  * modify timeout timer is safe here */
-void hsu_dma_rx(struct uart_hsu_port *up, u32 int_sts, unsigned long *flags)
+static void hsu_dma_rx(struct uart_hsu_port *up, u32 int_sts,
+			unsigned long *flags)
 {
 	struct hsu_dma_buffer *dbuf = &up->rxbuf;
 	struct hsu_dma_chan *chan = up->rxc;
@@ -1183,7 +1185,7 @@ static struct console serial_hsu_console = {
 #define SERIAL_HSU_CONSOLE	NULL
 #endif
 
-struct uart_ops serial_hsu_pops = {
+static struct uart_ops serial_hsu_pops = {
 	.tx_empty	= serial_hsu_tx_empty,
 	.set_mctrl	= serial_hsu_set_mctrl,
 	.get_mctrl	= serial_hsu_get_mctrl,
-- 
1.7.10.4



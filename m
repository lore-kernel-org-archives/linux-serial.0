From: Barry Song <21cnbao@gmail.com>
Subject: [PATCH 1/3] serial: sirf: fix system hung on console log output
Date: Tue, 26 May 2015 09:35:58 +0000
Message-ID: <1432632960-19748-1-git-send-email-21cnbao@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: gregkh@linuxfoundation.org, linux-serial@vger.kernel.org
Cc: Qipan Li <Qipan.Li@csr.com>, workgroup.linux@csr.com, linux-arm-kernel@lists.infradead.org, Barry Song <Baohua.Song@csr.com>
List-Id: linux-serial@vger.kernel.org

From: Qipan Li <Qipan.Li@csr.com>

A corner case exists in the current driver. if an app opens the console
device, and before writing to console device, and there are huge kernel
ogs to print out, system will hang on
sirfsoc_uart_console_putchar:
while (rd_regl(port, ureg->sirfsoc_tx_fifo_status) &
	ufifo_st->ff_full(port->line))
	cpu_relax();
as in sirfsoc_uart_startup(), the driver assigns tx_fifo_op to 0 will stop
TX FIFO, this loop will be endless.

Signed-off-by: Qipan Li <Qipan.Li@csr.com>
Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 drivers/tty/serial/sirfsoc_uart.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/sirfsoc_uart.c b/drivers/tty/serial/sirfsoc_uart.c
index 8d75962..6b1c92c 100644
--- a/drivers/tty/serial/sirfsoc_uart.c
+++ b/drivers/tty/serial/sirfsoc_uart.c
@@ -272,6 +272,7 @@ static void sirfsoc_uart_start_tx(struct uart_port *port)
 		if (sirfport->uart_reg->uart_type == SIRF_USP_UART)
 			wr_regl(port, ureg->sirfsoc_tx_rx_en, rd_regl(port,
 				ureg->sirfsoc_tx_rx_en) | SIRFUART_TX_EN);
+		wr_regl(port, ureg->sirfsoc_tx_fifo_op, SIRFUART_FIFO_STOP);
 		sirfsoc_uart_pio_tx_chars(sirfport, port->fifosize);
 		wr_regl(port, ureg->sirfsoc_tx_fifo_op, SIRFUART_FIFO_START);
 		if (!sirfport->is_atlas7)
@@ -1117,7 +1118,6 @@ static int sirfsoc_uart_startup(struct uart_port *port)
 			SIRFSOC_USP_ENDIAN_CTRL_LSBF |
 			SIRFSOC_USP_EN);
 	wr_regl(port, ureg->sirfsoc_tx_fifo_op, SIRFUART_FIFO_RESET);
-	wr_regl(port, ureg->sirfsoc_tx_fifo_op, 0);
 	wr_regl(port, ureg->sirfsoc_rx_fifo_op, SIRFUART_FIFO_RESET);
 	wr_regl(port, ureg->sirfsoc_rx_fifo_op, 0);
 	wr_regl(port, ureg->sirfsoc_tx_fifo_ctrl, SIRFUART_FIFO_THD(port));
-- 
2.3.5

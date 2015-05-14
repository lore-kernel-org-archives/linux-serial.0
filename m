From: Barry Song <21cnbao@gmail.com>
Subject: [PATCH 4/6] serial: sirf: add uart receive's some error counter and
 mark
Date: Thu, 14 May 2015 06:45:24 +0000
Message-ID: <1431585926-10746-4-git-send-email-21cnbao@gmail.com>
References: <1431585926-10746-1-git-send-email-21cnbao@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1431585926-10746-1-git-send-email-21cnbao@gmail.com>
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

add overrun error's flag mark and parity's counter, we can show the
statistic from procfs node.

BTW, let the indentation of stick bits configuration look better.

Signed-off-by: Qipan Li <Qipan.Li@csr.com>
Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 drivers/tty/serial/sirfsoc_uart.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/sirfsoc_uart.c b/drivers/tty/serial/sirfsoc_uart.c
index ffeb766..a500721 100644
--- a/drivers/tty/serial/sirfsoc_uart.c
+++ b/drivers/tty/serial/sirfsoc_uart.c
@@ -606,14 +606,18 @@ static irqreturn_t sirfsoc_uart_isr(int irq, void *dev_id)
 			if (uart_handle_break(port))
 				goto recv_char;
 		}
-		if (intr_status & uint_st->sirfsoc_rx_oflow)
+		if (intr_status & uint_st->sirfsoc_rx_oflow) {
 			port->icount.overrun++;
+			flag = TTY_OVERRUN;
+		}
 		if (intr_status & uint_st->sirfsoc_frm_err) {
 			port->icount.frame++;
 			flag = TTY_FRAME;
 		}
-		if (intr_status & uint_st->sirfsoc_parity_err)
+		if (intr_status & uint_st->sirfsoc_parity_err) {
+			port->icount.parity++;
 			flag = TTY_PARITY;
+		}
 		wr_regl(port, ureg->sirfsoc_rx_fifo_op, SIRFUART_FIFO_RESET);
 		wr_regl(port, ureg->sirfsoc_rx_fifo_op, 0);
 		wr_regl(port, ureg->sirfsoc_rx_fifo_op, SIRFUART_FIFO_START);
@@ -932,10 +936,11 @@ static void sirfsoc_uart_set_termios(struct uart_port *port,
 					config_reg |= SIRFUART_STICK_BIT_MARK;
 				else
 					config_reg |= SIRFUART_STICK_BIT_SPACE;
-			} else if (termios->c_cflag & PARODD) {
-				config_reg |= SIRFUART_STICK_BIT_ODD;
 			} else {
-				config_reg |= SIRFUART_STICK_BIT_EVEN;
+				if (termios->c_cflag & PARODD)
+					config_reg |= SIRFUART_STICK_BIT_ODD;
+				else
+					config_reg |= SIRFUART_STICK_BIT_EVEN;
 			}
 		}
 	} else {
-- 
2.3.5

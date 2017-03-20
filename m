From: Richard Genoud <richard.genoud@gmail.com>
Subject: [PATCH] tty/serial: atmel: fix race condition (TX+DMA)
Date: Mon, 20 Mar 2017 11:52:41 +0100
Message-ID: <20170320105241.25648-1-richard.genoud@gmail.com>
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
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Richard Genoud <richard.genoud@gmail.com>, "stable # 3 . 12+" <stable@vger.kernel.org>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

If uart_flush_buffer() is called between atmel_tx_dma() and
atmel_complete_tx_dma(), the circular buffer has been cleared, but not
atmel_port->tx_len.
That leads to a circular buffer overflow (dumping (UART_XMIT_SIZE -
atmel_port->tx_len) bytes).

Tested-by: Nicolas Ferre <nicolas.ferre@microchip.com>
Signed-off-by: Richard Genoud <richard.genoud@gmail.com>
Cc: stable <stable@vger.kernel.org> # 3.12+
---
NB: this will apply on kernels 4.3+, for kernels before 4.3, the code
will be:
sg_dma_len(&atmel_port->sg_tx) = 0;

 drivers/tty/serial/atmel_serial.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
index d9c05e05d896..5c23fb4e552b 100644
--- a/drivers/tty/serial/atmel_serial.c
+++ b/drivers/tty/serial/atmel_serial.c
@@ -1954,6 +1954,11 @@ static void atmel_flush_buffer(struct uart_port *port)
 		atmel_uart_writel(port, ATMEL_PDC_TCR, 0);
 		atmel_port->pdc_tx.ofs = 0;
 	}
+	/*
+	 * in uart_flush_buffer(), the xmit circular buffer has just
+	 * been cleared, so we have to reset tx_len accordingly.
+	 */
+	atmel_port->tx_len = 0;
 }
 
 /*

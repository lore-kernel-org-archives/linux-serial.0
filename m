From: Richard Genoud <richard.genoud@gmail.com>
Subject: [PATCH] tty/serial: atmel_serial: BUG: stop DMA from transmitting in
 stop_tx
Date: Tue, 13 Dec 2016 17:27:56 +0100
Message-ID: <20161213162756.16139-1-richard.genoud@gmail.com>
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
To: Nicolas Ferre <nicolas.ferre@atmel.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Cyrille Pitchen <cyrille.pitchen@atmel.com>
Cc: linux-arm-kernel@lists.infradead.org, Richard Genoud <richard.genoud@gmail.com>, "beware,
 this won't apply before 4.3" <stable@vger.kernel.org>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

If we don't disable the transmitter in atmel_stop_tx, the DMA buffer
continues to send data until it is emptied.
This cause problems with the flow control (CTS is asserted and data are
still sent).

So, disabling the transmitter in atmel_stop_tx is a sane thing to do.

Tested on at91sam9g35-cm(DMA)
Tested for regressions on sama5d2-xplained(Fifo) and at91sam9g20ek(PDC)

Cc: <stable@vger.kernel.org> (beware, this won't apply before 4.3)
Signed-off-by: Richard Genoud <richard.genoud@gmail.com>
---
 drivers/tty/serial/atmel_serial.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

NB: this is not for the 4.10 merge window, I'm just sending it now to
have some comments if someone is againts it.

diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
index 168b10cad47b..f9d42de5ab2d 100644
--- a/drivers/tty/serial/atmel_serial.c
+++ b/drivers/tty/serial/atmel_serial.c
@@ -481,6 +481,14 @@ static void atmel_stop_tx(struct uart_port *port)
 		/* disable PDC transmit */
 		atmel_uart_writel(port, ATMEL_PDC_PTCR, ATMEL_PDC_TXTDIS);
 	}
+
+	/*
+	 * Disable the transmitter.
+	 * This is mandatory when DMA is used, otherwise the DMA buffer
+	 * is fully transmitted.
+	 */
+	atmel_uart_writel(port, ATMEL_US_CR, ATMEL_US_TXDIS);
+
 	/* Disable interrupts */
 	atmel_uart_writel(port, ATMEL_US_IDR, atmel_port->tx_done_mask);
 
@@ -513,6 +521,9 @@ static void atmel_start_tx(struct uart_port *port)
 
 	/* Enable interrupts */
 	atmel_uart_writel(port, ATMEL_US_IER, atmel_port->tx_done_mask);
+
+	/* re-enable the transmitter */
+	atmel_uart_writel(port, ATMEL_US_CR, ATMEL_US_TXEN);
 }
 
 /*

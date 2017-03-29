From: Olliver Schinagl <oliver@schinagl.nl>
Subject: [PATCH] serial: tegra: Map the iir register to default defines
Date: Wed, 29 Mar 2017 20:48:06 +0200
Message-ID: <20170329184806.6577-1-oliver@schinagl.nl>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Laxman Dewangan <ldewangan@nvidia.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>, Alexandre Courbot <gnurou@gmail.com>
Cc: linux-serial@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, Olliver Schinagl <oliver@schinagl.nl>
List-Id: linux-serial@vger.kernel.org

The tegra serial IP seems to be following the common layout and the
interrupt ID's match up nicely. Replace the magic values to match the
common serial_reg defines, with the addition of the Tegra unique End of
Data interrupt.

Signed-off-by: Olliver Schinagl <oliver@schinagl.nl>
---
Note I do not own any tegra hardware and just noticed it while working on my
somewhat related previous patch,
"serial: Do not treat the IIR register as a bitfield"

As such, this patch can only be applied after the aforementioned patch or the
iir variable will not have its mask applied yet.

 drivers/tty/serial/serial-tegra.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/tty/serial/serial-tegra.c b/drivers/tty/serial/serial-tegra.c
index 4a084161d1d2..f765999dcbfe 100644
--- a/drivers/tty/serial/serial-tegra.c
+++ b/drivers/tty/serial/serial-tegra.c
@@ -83,6 +83,8 @@
 #define TEGRA_TX_PIO				1
 #define TEGRA_TX_DMA				2
 
+#define TEGRA_UART_IIR_EOD			0x8
+
 /**
  * tegra_uart_chip_data: SOC specific data.
  *
@@ -707,20 +709,20 @@ static irqreturn_t tegra_uart_isr(int irq, void *data)
 			return IRQ_HANDLED;
 		}
 
-		switch ((iir >> 1) & 0x7) {
-		case 0: /* Modem signal change interrupt */
+		switch (iir) {
+		case UART_IIR_MSI: /* Modem signal change interrupt */
 			tegra_uart_handle_modem_signal_change(u);
 			break;
 
-		case 1: /* Transmit interrupt only triggered when using PIO */
+		case UART_IIR_THRI: /* Transmit interrupt only triggered when using PIO */
 			tup->ier_shadow &= ~UART_IER_THRI;
 			tegra_uart_write(tup, tup->ier_shadow, UART_IER);
 			tegra_uart_handle_tx_pio(tup);
 			break;
 
-		case 4: /* End of data */
-		case 6: /* Rx timeout */
-		case 2: /* Receive */
+		case TEGRA_UART_IIR_EOD: /* End of data */
+		case UART_IIR_RX_TIMEOUT: /* Rx timeout */
+		case UART_IIR_RDI: /* Receive */
 			if (!is_rx_int) {
 				is_rx_int = true;
 				/* Disable Rx interrupts */
@@ -734,13 +736,12 @@ static irqreturn_t tegra_uart_isr(int irq, void *data)
 			}
 			break;
 
-		case 3: /* Receive error */
+		case UART_IIR_RLSI: /* Receive error */
 			tegra_uart_decode_rx_error(tup,
 					tegra_uart_read(tup, UART_LSR));
 			break;
 
-		case 5: /* break nothing to handle */
-		case 7: /* break nothing to handle */
+		default:
 			break;
 		}
 	}
-- 
2.11.0

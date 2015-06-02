From: Cyrille Pitchen <cyrille.pitchen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH linux-next 3/4] tty/serial: at91: add support to FIFOs
Date: Tue, 2 Jun 2015 16:18:23 +0200
Message-ID: <9eeb773b9cf77d5731f19c36b881e67650c7ab98.1433253787.git.cyrille.pitchen@atmel.com>
References: <cover.1433253787.git.cyrille.pitchen@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1433253787.git.cyrille.pitchen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, wenyou.yang-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org, ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org, leilei.zhao-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org, josh.wu-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org, alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, Cyrille Pitchen <cyrille.pitchen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

Depending on the hardware, TX and RX FIFOs may be available. The RX
FIFO can avoid receive overruns, especially when DMA transfers are
not used to read data from the Receive Holding Register. For heavy
system load, The CPU is likely not be able to fetch data fast enough
from the RHR.

In addition, the RX FIFO can supersede the DMA/PDC to control the RTS
line when the Hardware Handshaking mode is enabled. Two thresholds
are to be set for that purpose:
- When the number of data in the RX FIFO crosses and becomes lower
  than or equal to the low threshold, the RTS line is set to low
  level: the remote peer is requested to send data.
- When the number of data in the RX FIFO crosses and becomes greater
  than or equal to the high threshold, the RTS line is set to high
  level: the remote peer should stop sending new data.
- low threshold < high threshold
Once these two thresholds are set properly, this new feature is
enabled by setting the FIFO RTS Control bit of the FIFO Mode Register.

FIFOs also introduce a new multiple data mode: the USART works either
in multiple data mode or in single data (legacy) mode.

If MODE9 bit is set into the Mode Register or if USMODE is set to
either LIN_MASTER, LIN_SLAVE or LON_MODE, FIFOs operate in single
data mode. Otherwise, they operate in multiple data mode.

In this new multiple data mode, accesses to the Receive Holding
Register or Transmit Holding Register slightly change.

Since this driver implements neither the 9bit data feature (MODE9 bit
set into the Mode Register) nor LIN modes, the USART works in
multiple data mode whenever FIFOs are available and enabled. We also
assume that data are 8bit wide.

In single data mode, 32bit access CAN be used to read a single data
from RHR or write a single data into THR.
However in multiple data mode, a 32bit access to RHR now allows us to
read four consecutive data from RX FIFO. Also a 32bit access to THR
now allows to write four consecutive data into TX FIFO. So we MUST
use 8bit access whenever only one data have to be read/written at a
time.

Signed-off-by: Cyrille Pitchen <cyrille.pitchen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
---
 drivers/tty/serial/atmel_serial.c | 77 +++++++++++++++++++++++++++++++++++++++
 include/linux/atmel_serial.h      | 36 ++++++++++++++++++
 2 files changed, 113 insertions(+)

diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
index 112e74b..8a32f7c 100644
--- a/drivers/tty/serial/atmel_serial.c
+++ b/drivers/tty/serial/atmel_serial.c
@@ -119,6 +119,16 @@ static void atmel_stop_rx(struct uart_port *port);
 #define UART_PUT_TCR(port, v)  __raw_writel(v, (port)->membase + ATMEL_PDC_TCR)
 #define UART_GET_TCR(port)     __raw_readl((port)->membase + ATMEL_PDC_TCR)
 
+/* FIFO registers */
+#define UART_PUT_FMR(port, v)  __raw_writel(v, (port)->membase + ATMEL_US_FMR)
+#define UART_GET_FMR(port)     __raw_readl((port)->membase + ATMEL_US_FMR)
+#define UART_GET_FESR(port)    __raw_readl((port)->membase + ATMEL_US_FESR)
+#define UART_PUT_FIER(port, v) __raw_writel(v, (port)->membase + ATMEL_US_FIER)
+#define UART_PUT_FIDR(port, v) __raw_writel(v, (port)->membase + ATMEL_US_FIDR)
+#define UART_GET_FIMR(port)    __raw_readl((port)->membase + ATMEL_US_FIMR)
+#define UART_GET_FLR(port)     __raw_readl((port)->membase + ATMEL_US_FLR)
+
+
 struct atmel_dma_buffer {
 	unsigned char	*buf;
 	dma_addr_t	dma_addr;
@@ -172,6 +182,9 @@ struct atmel_uart_port {
 	struct mctrl_gpios	*gpios;
 	int			gpio_irq[UART_GPIO_MAX];
 	unsigned int		tx_done_mask;
+	u32			fifo_size;
+	u32			rts_high;
+	u32			rts_low;
 	bool			ms_irq_enabled;
 	bool			is_usart;	/* usart or uart */
 	struct timer_list	uart_timer;	/* uart timer */
@@ -1797,6 +1810,29 @@ static int atmel_startup(struct uart_port *port)
 			atmel_set_ops(port);
 	}
 
+	/*
+	 * Enable FIFO when available
+	 */
+	if (atmel_port->fifo_size) {
+		unsigned int txrdym = ATMEL_US_ONE_DATA;
+		unsigned int rxrdym = ATMEL_US_ONE_DATA;
+		unsigned int fmr;
+
+		UART_PUT_CR(port,
+			    ATMEL_US_FIFOEN |
+			    ATMEL_US_RXFCLR |
+			    ATMEL_US_TXFLCLR);
+
+		fmr = ATMEL_US_TXRDYM(txrdym) | ATMEL_US_RXRDYM(rxrdym);
+		if (atmel_port->rts_high &&
+		    atmel_port->rts_low)
+			fmr |=	ATMEL_US_FRTSC |
+				ATMEL_US_RXFTHRES(atmel_port->rts_high) |
+				ATMEL_US_RXFTHRES2(atmel_port->rts_low);
+
+		UART_PUT_FMR(port, fmr);
+	}
+
 	/* Save current CSR for comparison in atmel_tasklet_func() */
 	atmel_port->irq_status_prev = atmel_get_lines_status(port);
 	atmel_port->irq_status = atmel_port->irq_status_prev;
@@ -2599,6 +2635,46 @@ static int atmel_init_gpios(struct atmel_uart_port *p, struct device *dev)
 	return 0;
 }
 
+static void atmel_serial_probe_fifos(struct atmel_uart_port *port,
+				     struct platform_device *pdev)
+{
+	port->fifo_size = 0;
+	port->rts_low = 0;
+	port->rts_high = 0;
+
+	if (of_property_read_u32(pdev->dev.of_node,
+				 "atmel,fifo-size",
+				 &port->fifo_size) ||
+	    !port->fifo_size)
+		return;
+
+	if (of_property_read_u32(pdev->dev.of_node,
+				 "atmel,rts-low-threshold",
+				 &port->rts_low))
+		port->rts_low = port->fifo_size >> 2;
+
+	if (of_property_read_u32(pdev->dev.of_node,
+				 "atmel,rts-high-threshold",
+				 &port->rts_high))
+		port->rts_high = port->fifo_size >> 1;
+
+	dev_info(&pdev->dev, "Using FIFO (%u data)\n",
+		 port->fifo_size);
+
+	if (!port->rts_high ||
+	    !port->rts_low ||
+	    port->rts_high <= port->rts_low) {
+		port->rts_low = port->rts_high = 0;
+		dev_warn(&pdev->dev, "Invalid FIFO thresholds\n");
+		return;
+	}
+
+	dev_info(&pdev->dev, "RTS High Threshold : %2u data\n",
+		 port->rts_high);
+	dev_info(&pdev->dev, "RTS Low Threshold  : %2u data\n",
+		 port->rts_low);
+}
+
 static int atmel_serial_probe(struct platform_device *pdev)
 {
 	struct atmel_uart_port *port;
@@ -2635,6 +2711,7 @@ static int atmel_serial_probe(struct platform_device *pdev)
 	port = &atmel_ports[ret];
 	port->backup_imr = 0;
 	port->uart.line = ret;
+	atmel_serial_probe_fifos(port, pdev);
 
 	spin_lock_init(&port->lock_suspended);
 
diff --git a/include/linux/atmel_serial.h b/include/linux/atmel_serial.h
index c384c21..ee696d7 100644
--- a/include/linux/atmel_serial.h
+++ b/include/linux/atmel_serial.h
@@ -35,6 +35,11 @@
 #define	ATMEL_US_DTRDIS		BIT(17)	/* Data Terminal Ready Disable */
 #define	ATMEL_US_RTSEN		BIT(18)	/* Request To Send Enable */
 #define	ATMEL_US_RTSDIS		BIT(19)	/* Request To Send Disable */
+#define	ATMEL_US_TXFCLR		BIT(24)	/* Transmit FIFO Clear */
+#define	ATMEL_US_RXFCLR		BIT(25)	/* Receive FIFO Clear */
+#define	ATMEL_US_TXFLCLR	BIT(26)	/* Transmit FIFO Lock Clear */
+#define	ATMEL_US_FIFOEN		BIT(30)	/* FIFO enable */
+#define	ATMEL_US_FIFODIS	BIT(31)	/* FIFO disable */
 
 #define ATMEL_US_MR		0x04	/* Mode Register */
 #define	ATMEL_US_USMODE		GENMASK(3, 0)	/* Mode of the USART */
@@ -124,6 +129,37 @@
 #define ATMEL_US_NER		0x44	/* Number of Errors Register */
 #define ATMEL_US_IF		0x4c	/* IrDA Filter Register */
 
+#define ATMEL_US_CMPR		0x90	/* Comparaison Register */
+#define ATMEL_US_FMR		0xa0	/* FIFO Mode Register */
+#define	ATMEL_US_TXRDYM(data)	(((data) & 0x3) << 0)	/* TX Ready Mode */
+#define	ATMEL_US_RXRDYM(data)	(((data) & 0x3) << 4)	/* RX Ready Mode */
+#define		ATMEL_US_ONE_DATA	0x0
+#define		ATMEL_US_TWO_DATA	0x1
+#define		ATMEL_US_FOUR_DATA	0x2
+#define	ATMEL_US_FRTSC		BIT(7)	/* FIFO RTS pin Control */
+#define	ATMEL_US_TXFTHRES(thr)	(((thr) & 0x3f) << 8)	/* TX FIFO Threshold */
+#define	ATMEL_US_RXFTHRES(thr)	(((thr) & 0x3f) << 16)	/* RX FIFO Threshold */
+#define	ATMEL_US_RXFTHRES2(thr)	(((thr) & 0x3f) << 24)	/* RX FIFO Threshold2 */
+
+#define ATMEL_US_FLR		0xa4	/* FIFO Level Register */
+#define	ATMEL_US_TXFL(reg)	(((reg) >> 0) & 0x3f)	/* TX FIFO Level */
+#define	ATMEL_US_RXFL(reg)	(((reg) >> 16) & 0x3f)	/* RX FIFO Level */
+
+#define ATMEL_US_FIER		0xa8	/* FIFO Interrupt Enable Register */
+#define ATMEL_US_FIDR		0xac	/* FIFO Interrupt Disable Register */
+#define ATMEL_US_FIMR		0xb0	/* FIFO Interrupt Mask Register */
+#define ATMEL_US_FESR		0xb4	/* FIFO Event Status Register */
+#define	ATMEL_US_TXFEF		BIT(0)	/* Transmit FIFO Empty Flag */
+#define	ATMEL_US_TXFFF		BIT(1)	/* Transmit FIFO Full Flag */
+#define	ATMEL_US_TXFTHF		BIT(2)	/* Transmit FIFO Threshold Flag */
+#define	ATMEL_US_RXFEF		BIT(3)	/* Receive FIFO Empty Flag */
+#define	ATMEL_US_RXFFF		BIT(4)	/* Receive FIFO Full Flag */
+#define	ATMEL_US_RXFTHF		BIT(5)	/* Receive FIFO Threshold Flag */
+#define	ATMEL_US_TXFPTEF	BIT(6)	/* Transmit FIFO Pointer Error Flag */
+#define	ATMEL_US_RXFPTEF	BIT(7)	/* Receive FIFO Pointer Error Flag */
+#define	ATMEL_US_TXFLOCK	BIT(8)	/* Transmit FIFO Lock (FESR only) */
+#define	ATMEL_US_RXFTHF2	BIT(9)	/* Receive FIFO Threshold Flag 2 */
+
 #define ATMEL_US_NAME		0xf0	/* Ip Name */
 #define ATMEL_US_VERSION	0xfc	/* Ip Version */
 
-- 
1.8.2.2

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

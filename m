From: Cyrille Pitchen <cyrille.pitchen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v3 2/4] tty/serial: at91: fix some macro definitions to fit coding style
Date: Tue, 30 Jun 2015 16:05:15 +0200
Message-ID: <9f0f19d2fe05ea95572b467ec49ecd11389e3be9.1435672649.git.cyrille.pitchen@atmel.com>
References: <cover.1435672649.git.cyrille.pitchen@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1435672649.git.cyrille.pitchen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, wenyou.yang-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org, ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org, leilei.zhao-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org, josh.wu-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org, alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, Cyrille Pitchen <cyrille.pitchen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

This patch updates macro definitions in atmel_serial.h to fit the
80 column rule.

Please note that some deprecated comments such as "[AT91SAM9261 only]"
are removed as the corresponding bits also exist in some later chips.

The patch also fix macro definitions in atmel_serial.c to replace
(port,v) by (port, v).

Signed-off-by: Cyrille Pitchen <cyrille.pitchen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Acked-by: Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Acked-by: Nicolas Ferre <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
---
 drivers/tty/serial/atmel_serial.c |  52 +++++-----
 include/linux/atmel_serial.h      | 204 +++++++++++++++++++-------------------
 2 files changed, 128 insertions(+), 128 deletions(-)

diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
index 2a8f528153e7..112e74b61f1f 100644
--- a/drivers/tty/serial/atmel_serial.c
+++ b/drivers/tty/serial/atmel_serial.c
@@ -89,35 +89,35 @@ static void atmel_stop_rx(struct uart_port *port);
 #define ATMEL_ISR_PASS_LIMIT	256
 
 /* UART registers. CR is write-only, hence no GET macro */
-#define UART_PUT_CR(port,v)	__raw_writel(v, (port)->membase + ATMEL_US_CR)
-#define UART_GET_MR(port)	__raw_readl((port)->membase + ATMEL_US_MR)
-#define UART_PUT_MR(port,v)	__raw_writel(v, (port)->membase + ATMEL_US_MR)
-#define UART_PUT_IER(port,v)	__raw_writel(v, (port)->membase + ATMEL_US_IER)
-#define UART_PUT_IDR(port,v)	__raw_writel(v, (port)->membase + ATMEL_US_IDR)
-#define UART_GET_IMR(port)	__raw_readl((port)->membase + ATMEL_US_IMR)
-#define UART_GET_CSR(port)	__raw_readl((port)->membase + ATMEL_US_CSR)
-#define UART_GET_CHAR(port)	__raw_readl((port)->membase + ATMEL_US_RHR)
-#define UART_PUT_CHAR(port,v)	__raw_writel(v, (port)->membase + ATMEL_US_THR)
-#define UART_GET_BRGR(port)	__raw_readl((port)->membase + ATMEL_US_BRGR)
-#define UART_PUT_BRGR(port,v)	__raw_writel(v, (port)->membase + ATMEL_US_BRGR)
-#define UART_PUT_RTOR(port,v)	__raw_writel(v, (port)->membase + ATMEL_US_RTOR)
-#define UART_PUT_TTGR(port, v)	__raw_writel(v, (port)->membase + ATMEL_US_TTGR)
-#define UART_GET_IP_NAME(port)	__raw_readl((port)->membase + ATMEL_US_NAME)
-#define UART_GET_IP_VERSION(port) __raw_readl((port)->membase + ATMEL_US_VERSION)
+#define UART_PUT_CR(port, v)   __raw_writel(v, (port)->membase + ATMEL_US_CR)
+#define UART_GET_MR(port)      __raw_readl((port)->membase + ATMEL_US_MR)
+#define UART_PUT_MR(port, v)   __raw_writel(v, (port)->membase + ATMEL_US_MR)
+#define UART_PUT_IER(port, v)  __raw_writel(v, (port)->membase + ATMEL_US_IER)
+#define UART_PUT_IDR(port, v)  __raw_writel(v, (port)->membase + ATMEL_US_IDR)
+#define UART_GET_IMR(port)     __raw_readl((port)->membase + ATMEL_US_IMR)
+#define UART_GET_CSR(port)     __raw_readl((port)->membase + ATMEL_US_CSR)
+#define UART_GET_CHAR(port)    __raw_readl((port)->membase + ATMEL_US_RHR)
+#define UART_PUT_CHAR(port, v) __raw_writel(v, (port)->membase + ATMEL_US_THR)
+#define UART_GET_BRGR(port)    __raw_readl((port)->membase + ATMEL_US_BRGR)
+#define UART_PUT_BRGR(port, v) __raw_writel(v, (port)->membase + ATMEL_US_BRGR)
+#define UART_PUT_RTOR(port, v) __raw_writel(v, (port)->membase + ATMEL_US_RTOR)
+#define UART_PUT_TTGR(port, v) __raw_writel(v, (port)->membase + ATMEL_US_TTGR)
+#define UART_GET_IP_NAME(port) __raw_readl((port)->membase + ATMEL_US_NAME)
+#define UART_GET_IP_VERS(port) __raw_readl((port)->membase + ATMEL_US_VERSION)
 
  /* PDC registers */
-#define UART_PUT_PTCR(port,v)	__raw_writel(v, (port)->membase + ATMEL_PDC_PTCR)
-#define UART_GET_PTSR(port)	__raw_readl((port)->membase + ATMEL_PDC_PTSR)
+#define UART_PUT_PTCR(port, v) __raw_writel(v, (port)->membase + ATMEL_PDC_PTCR)
+#define UART_GET_PTSR(port)    __raw_readl((port)->membase + ATMEL_PDC_PTSR)
 
-#define UART_PUT_RPR(port,v)	__raw_writel(v, (port)->membase + ATMEL_PDC_RPR)
-#define UART_GET_RPR(port)	__raw_readl((port)->membase + ATMEL_PDC_RPR)
-#define UART_PUT_RCR(port,v)	__raw_writel(v, (port)->membase + ATMEL_PDC_RCR)
-#define UART_PUT_RNPR(port,v)	__raw_writel(v, (port)->membase + ATMEL_PDC_RNPR)
-#define UART_PUT_RNCR(port,v)	__raw_writel(v, (port)->membase + ATMEL_PDC_RNCR)
+#define UART_PUT_RPR(port, v)  __raw_writel(v, (port)->membase + ATMEL_PDC_RPR)
+#define UART_GET_RPR(port)     __raw_readl((port)->membase + ATMEL_PDC_RPR)
+#define UART_PUT_RCR(port, v)  __raw_writel(v, (port)->membase + ATMEL_PDC_RCR)
+#define UART_PUT_RNPR(port, v) __raw_writel(v, (port)->membase + ATMEL_PDC_RNPR)
+#define UART_PUT_RNCR(port, v) __raw_writel(v, (port)->membase + ATMEL_PDC_RNCR)
 
-#define UART_PUT_TPR(port,v)	__raw_writel(v, (port)->membase + ATMEL_PDC_TPR)
-#define UART_PUT_TCR(port,v)	__raw_writel(v, (port)->membase + ATMEL_PDC_TCR)
-#define UART_GET_TCR(port)	__raw_readl((port)->membase + ATMEL_PDC_TCR)
+#define UART_PUT_TPR(port, v)  __raw_writel(v, (port)->membase + ATMEL_PDC_TPR)
+#define UART_PUT_TCR(port, v)  __raw_writel(v, (port)->membase + ATMEL_PDC_TCR)
+#define UART_GET_TCR(port)     __raw_readl((port)->membase + ATMEL_PDC_TCR)
 
 struct atmel_dma_buffer {
 	unsigned char	*buf;
@@ -1684,7 +1684,7 @@ static void atmel_get_ip_name(struct uart_port *port)
 		atmel_port->is_usart = false;
 	} else {
 		/* fallback for older SoCs: use version field */
-		version = UART_GET_IP_VERSION(port);
+		version = UART_GET_IP_VERS(port);
 		switch (version) {
 		case 0x302:
 		case 0x10213:
diff --git a/include/linux/atmel_serial.h b/include/linux/atmel_serial.h
index 00beddf6be20..c384c21d65f0 100644
--- a/include/linux/atmel_serial.h
+++ b/include/linux/atmel_serial.h
@@ -16,115 +16,115 @@
 #ifndef ATMEL_SERIAL_H
 #define ATMEL_SERIAL_H
 
-#define ATMEL_US_CR		0x00			/* Control Register */
-#define		ATMEL_US_RSTRX		(1 <<  2)		/* Reset Receiver */
-#define		ATMEL_US_RSTTX		(1 <<  3)		/* Reset Transmitter */
-#define		ATMEL_US_RXEN		(1 <<  4)		/* Receiver Enable */
-#define		ATMEL_US_RXDIS		(1 <<  5)		/* Receiver Disable */
-#define		ATMEL_US_TXEN		(1 <<  6)		/* Transmitter Enable */
-#define		ATMEL_US_TXDIS		(1 <<  7)		/* Transmitter Disable */
-#define		ATMEL_US_RSTSTA		(1 <<  8)		/* Reset Status Bits */
-#define		ATMEL_US_STTBRK		(1 <<  9)		/* Start Break */
-#define		ATMEL_US_STPBRK		(1 << 10)		/* Stop Break */
-#define		ATMEL_US_STTTO		(1 << 11)		/* Start Time-out */
-#define		ATMEL_US_SENDA		(1 << 12)		/* Send Address */
-#define		ATMEL_US_RSTIT		(1 << 13)		/* Reset Iterations */
-#define		ATMEL_US_RSTNACK	(1 << 14)		/* Reset Non Acknowledge */
-#define		ATMEL_US_RETTO		(1 << 15)		/* Rearm Time-out */
-#define		ATMEL_US_DTREN		(1 << 16)		/* Data Terminal Ready Enable [AT91RM9200 only] */
-#define		ATMEL_US_DTRDIS		(1 << 17)		/* Data Terminal Ready Disable [AT91RM9200 only] */
-#define		ATMEL_US_RTSEN		(1 << 18)		/* Request To Send Enable */
-#define		ATMEL_US_RTSDIS		(1 << 19)		/* Request To Send Disable */
+#define ATMEL_US_CR		0x00	/* Control Register */
+#define	ATMEL_US_RSTRX		BIT(2)	/* Reset Receiver */
+#define	ATMEL_US_RSTTX		BIT(3)	/* Reset Transmitter */
+#define	ATMEL_US_RXEN		BIT(4)	/* Receiver Enable */
+#define	ATMEL_US_RXDIS		BIT(5)	/* Receiver Disable */
+#define	ATMEL_US_TXEN		BIT(6)	/* Transmitter Enable */
+#define	ATMEL_US_TXDIS		BIT(7)	/* Transmitter Disable */
+#define	ATMEL_US_RSTSTA		BIT(8)	/* Reset Status Bits */
+#define	ATMEL_US_STTBRK		BIT(9)	/* Start Break */
+#define	ATMEL_US_STPBRK		BIT(10)	/* Stop Break */
+#define	ATMEL_US_STTTO		BIT(11)	/* Start Time-out */
+#define	ATMEL_US_SENDA		BIT(12)	/* Send Address */
+#define	ATMEL_US_RSTIT		BIT(13)	/* Reset Iterations */
+#define	ATMEL_US_RSTNACK	BIT(14)	/* Reset Non Acknowledge */
+#define	ATMEL_US_RETTO		BIT(15)	/* Rearm Time-out */
+#define	ATMEL_US_DTREN		BIT(16)	/* Data Terminal Ready Enable */
+#define	ATMEL_US_DTRDIS		BIT(17)	/* Data Terminal Ready Disable */
+#define	ATMEL_US_RTSEN		BIT(18)	/* Request To Send Enable */
+#define	ATMEL_US_RTSDIS		BIT(19)	/* Request To Send Disable */
 
-#define ATMEL_US_MR		0x04			/* Mode Register */
-#define		ATMEL_US_USMODE		(0xf <<  0)		/* Mode of the USART */
-#define			ATMEL_US_USMODE_NORMAL		0
-#define			ATMEL_US_USMODE_RS485		1
-#define			ATMEL_US_USMODE_HWHS		2
-#define			ATMEL_US_USMODE_MODEM		3
-#define			ATMEL_US_USMODE_ISO7816_T0	4
-#define			ATMEL_US_USMODE_ISO7816_T1	6
-#define			ATMEL_US_USMODE_IRDA		8
-#define		ATMEL_US_USCLKS		(3   <<  4)		/* Clock Selection */
-#define			ATMEL_US_USCLKS_MCK		(0 <<  4)
-#define			ATMEL_US_USCLKS_MCK_DIV8	(1 <<  4)
-#define			ATMEL_US_USCLKS_SCK		(3 <<  4)
-#define		ATMEL_US_CHRL		(3   <<  6)		/* Character Length */
-#define			ATMEL_US_CHRL_5			(0 <<  6)
-#define			ATMEL_US_CHRL_6			(1 <<  6)
-#define			ATMEL_US_CHRL_7			(2 <<  6)
-#define			ATMEL_US_CHRL_8			(3 <<  6)
-#define		ATMEL_US_SYNC		(1 <<  8)		/* Synchronous Mode Select */
-#define		ATMEL_US_PAR		(7 <<  9)		/* Parity Type */
-#define			ATMEL_US_PAR_EVEN		(0 <<  9)
-#define			ATMEL_US_PAR_ODD		(1 <<  9)
-#define			ATMEL_US_PAR_SPACE		(2 <<  9)
-#define			ATMEL_US_PAR_MARK		(3 <<  9)
-#define			ATMEL_US_PAR_NONE		(4 <<  9)
-#define			ATMEL_US_PAR_MULTI_DROP		(6 <<  9)
-#define		ATMEL_US_NBSTOP		(3 << 12)		/* Number of Stop Bits */
-#define			ATMEL_US_NBSTOP_1		(0 << 12)
-#define			ATMEL_US_NBSTOP_1_5		(1 << 12)
-#define			ATMEL_US_NBSTOP_2		(2 << 12)
-#define		ATMEL_US_CHMODE		(3 << 14)		/* Channel Mode */
-#define			ATMEL_US_CHMODE_NORMAL		(0 << 14)
-#define			ATMEL_US_CHMODE_ECHO		(1 << 14)
-#define			ATMEL_US_CHMODE_LOC_LOOP	(2 << 14)
-#define			ATMEL_US_CHMODE_REM_LOOP	(3 << 14)
-#define		ATMEL_US_MSBF		(1 << 16)		/* Bit Order */
-#define		ATMEL_US_MODE9		(1 << 17)		/* 9-bit Character Length */
-#define		ATMEL_US_CLKO		(1 << 18)		/* Clock Output Select */
-#define		ATMEL_US_OVER		(1 << 19)		/* Oversampling Mode */
-#define		ATMEL_US_INACK		(1 << 20)		/* Inhibit Non Acknowledge */
-#define		ATMEL_US_DSNACK		(1 << 21)		/* Disable Successive NACK */
-#define		ATMEL_US_MAX_ITER	(7 << 24)		/* Max Iterations */
-#define		ATMEL_US_FILTER		(1 << 28)		/* Infrared Receive Line Filter */
+#define ATMEL_US_MR		0x04	/* Mode Register */
+#define	ATMEL_US_USMODE		GENMASK(3, 0)	/* Mode of the USART */
+#define		ATMEL_US_USMODE_NORMAL		0
+#define		ATMEL_US_USMODE_RS485		1
+#define		ATMEL_US_USMODE_HWHS		2
+#define		ATMEL_US_USMODE_MODEM		3
+#define		ATMEL_US_USMODE_ISO7816_T0	4
+#define		ATMEL_US_USMODE_ISO7816_T1	6
+#define		ATMEL_US_USMODE_IRDA		8
+#define	ATMEL_US_USCLKS		GENMASK(5, 4)	/* Clock Selection */
+#define		ATMEL_US_USCLKS_MCK		(0 <<  4)
+#define		ATMEL_US_USCLKS_MCK_DIV8	(1 <<  4)
+#define		ATMEL_US_USCLKS_SCK		(3 <<  4)
+#define	ATMEL_US_CHRL		GENMASK(7, 6)	/* Character Length */
+#define		ATMEL_US_CHRL_5			(0 <<  6)
+#define		ATMEL_US_CHRL_6			(1 <<  6)
+#define		ATMEL_US_CHRL_7			(2 <<  6)
+#define		ATMEL_US_CHRL_8			(3 <<  6)
+#define	ATMEL_US_SYNC		BIT(8)		/* Synchronous Mode Select */
+#define	ATMEL_US_PAR		GENMASK(11, 9)	/* Parity Type */
+#define		ATMEL_US_PAR_EVEN		(0 <<  9)
+#define		ATMEL_US_PAR_ODD		(1 <<  9)
+#define		ATMEL_US_PAR_SPACE		(2 <<  9)
+#define		ATMEL_US_PAR_MARK		(3 <<  9)
+#define		ATMEL_US_PAR_NONE		(4 <<  9)
+#define		ATMEL_US_PAR_MULTI_DROP		(6 <<  9)
+#define	ATMEL_US_NBSTOP		GENMASK(13, 12)	/* Number of Stop Bits */
+#define		ATMEL_US_NBSTOP_1		(0 << 12)
+#define		ATMEL_US_NBSTOP_1_5		(1 << 12)
+#define		ATMEL_US_NBSTOP_2		(2 << 12)
+#define	ATMEL_US_CHMODE		GENMASK(15, 14)	/* Channel Mode */
+#define		ATMEL_US_CHMODE_NORMAL		(0 << 14)
+#define		ATMEL_US_CHMODE_ECHO		(1 << 14)
+#define		ATMEL_US_CHMODE_LOC_LOOP	(2 << 14)
+#define		ATMEL_US_CHMODE_REM_LOOP	(3 << 14)
+#define	ATMEL_US_MSBF		BIT(16)	/* Bit Order */
+#define	ATMEL_US_MODE9		BIT(17)	/* 9-bit Character Length */
+#define	ATMEL_US_CLKO		BIT(18)	/* Clock Output Select */
+#define	ATMEL_US_OVER		BIT(19)	/* Oversampling Mode */
+#define	ATMEL_US_INACK		BIT(20)	/* Inhibit Non Acknowledge */
+#define	ATMEL_US_DSNACK		BIT(21)	/* Disable Successive NACK */
+#define	ATMEL_US_MAX_ITER	GENMASK(26, 24)	/* Max Iterations */
+#define	ATMEL_US_FILTER		BIT(28)	/* Infrared Receive Line Filter */
 
-#define ATMEL_US_IER		0x08			/* Interrupt Enable Register */
-#define		ATMEL_US_RXRDY		(1 <<  0)		/* Receiver Ready */
-#define		ATMEL_US_TXRDY		(1 <<  1)		/* Transmitter Ready */
-#define		ATMEL_US_RXBRK		(1 <<  2)		/* Break Received / End of Break */
-#define		ATMEL_US_ENDRX		(1 <<  3)		/* End of Receiver Transfer */
-#define		ATMEL_US_ENDTX		(1 <<  4)		/* End of Transmitter Transfer */
-#define		ATMEL_US_OVRE		(1 <<  5)		/* Overrun Error */
-#define		ATMEL_US_FRAME		(1 <<  6)		/* Framing Error */
-#define		ATMEL_US_PARE		(1 <<  7)		/* Parity Error */
-#define		ATMEL_US_TIMEOUT	(1 <<  8)		/* Receiver Time-out */
-#define		ATMEL_US_TXEMPTY	(1 <<  9)		/* Transmitter Empty */
-#define		ATMEL_US_ITERATION	(1 << 10)		/* Max number of Repetitions Reached */
-#define		ATMEL_US_TXBUFE		(1 << 11)		/* Transmission Buffer Empty */
-#define		ATMEL_US_RXBUFF		(1 << 12)		/* Reception Buffer Full */
-#define		ATMEL_US_NACK		(1 << 13)		/* Non Acknowledge */
-#define		ATMEL_US_RIIC		(1 << 16)		/* Ring Indicator Input Change [AT91RM9200 only] */
-#define		ATMEL_US_DSRIC		(1 << 17)		/* Data Set Ready Input Change [AT91RM9200 only] */
-#define		ATMEL_US_DCDIC		(1 << 18)		/* Data Carrier Detect Input Change [AT91RM9200 only] */
-#define		ATMEL_US_CTSIC		(1 << 19)		/* Clear to Send Input Change */
-#define		ATMEL_US_RI		(1 << 20)		/* RI */
-#define		ATMEL_US_DSR		(1 << 21)		/* DSR */
-#define		ATMEL_US_DCD		(1 << 22)		/* DCD */
-#define		ATMEL_US_CTS		(1 << 23)		/* CTS */
+#define ATMEL_US_IER		0x08	/* Interrupt Enable Register */
+#define	ATMEL_US_RXRDY		BIT(0)	/* Receiver Ready */
+#define	ATMEL_US_TXRDY		BIT(1)	/* Transmitter Ready */
+#define	ATMEL_US_RXBRK		BIT(2)	/* Break Received / End of Break */
+#define	ATMEL_US_ENDRX		BIT(3)	/* End of Receiver Transfer */
+#define	ATMEL_US_ENDTX		BIT(4)	/* End of Transmitter Transfer */
+#define	ATMEL_US_OVRE		BIT(5)	/* Overrun Error */
+#define	ATMEL_US_FRAME		BIT(6)	/* Framing Error */
+#define	ATMEL_US_PARE		BIT(7)	/* Parity Error */
+#define	ATMEL_US_TIMEOUT	BIT(8)	/* Receiver Time-out */
+#define	ATMEL_US_TXEMPTY	BIT(9)	/* Transmitter Empty */
+#define	ATMEL_US_ITERATION	BIT(10)	/* Max number of Repetitions Reached */
+#define	ATMEL_US_TXBUFE		BIT(11)	/* Transmission Buffer Empty */
+#define	ATMEL_US_RXBUFF		BIT(12)	/* Reception Buffer Full */
+#define	ATMEL_US_NACK		BIT(13)	/* Non Acknowledge */
+#define	ATMEL_US_RIIC		BIT(16)	/* Ring Indicator Input Change */
+#define	ATMEL_US_DSRIC		BIT(17)	/* Data Set Ready Input Change */
+#define	ATMEL_US_DCDIC		BIT(18)	/* Data Carrier Detect Input Change */
+#define	ATMEL_US_CTSIC		BIT(19)	/* Clear to Send Input Change */
+#define	ATMEL_US_RI		BIT(20)	/* RI */
+#define	ATMEL_US_DSR		BIT(21)	/* DSR */
+#define	ATMEL_US_DCD		BIT(22)	/* DCD */
+#define	ATMEL_US_CTS		BIT(23)	/* CTS */
 
-#define ATMEL_US_IDR		0x0c			/* Interrupt Disable Register */
-#define ATMEL_US_IMR		0x10			/* Interrupt Mask Register */
-#define ATMEL_US_CSR		0x14			/* Channel Status Register */
-#define ATMEL_US_RHR		0x18			/* Receiver Holding Register */
-#define ATMEL_US_THR		0x1c			/* Transmitter Holding Register */
-#define		ATMEL_US_SYNH		(1 << 15)		/* Transmit/Receive Sync [AT91SAM9261 only] */
+#define ATMEL_US_IDR		0x0c	/* Interrupt Disable Register */
+#define ATMEL_US_IMR		0x10	/* Interrupt Mask Register */
+#define ATMEL_US_CSR		0x14	/* Channel Status Register */
+#define ATMEL_US_RHR		0x18	/* Receiver Holding Register */
+#define ATMEL_US_THR		0x1c	/* Transmitter Holding Register */
+#define	ATMEL_US_SYNH		BIT(15)	/* Transmit/Receive Sync */
 
-#define ATMEL_US_BRGR		0x20			/* Baud Rate Generator Register */
-#define		ATMEL_US_CD		(0xffff << 0)		/* Clock Divider */
+#define ATMEL_US_BRGR		0x20	/* Baud Rate Generator Register */
+#define	ATMEL_US_CD		GENMASK(15, 0)	/* Clock Divider */
 
-#define ATMEL_US_RTOR		0x24			/* Receiver Time-out Register */
-#define		ATMEL_US_TO		(0xffff << 0)		/* Time-out Value */
+#define ATMEL_US_RTOR		0x24	/* Receiver Time-out Register */
+#define	ATMEL_US_TO		GENMASK(15, 0)	/* Time-out Value */
 
-#define ATMEL_US_TTGR		0x28			/* Transmitter Timeguard Register */
-#define		ATMEL_US_TG		(0xff << 0)		/* Timeguard Value */
+#define ATMEL_US_TTGR		0x28	/* Transmitter Timeguard Register */
+#define	ATMEL_US_TG		GENMASK(7, 0)	/* Timeguard Value */
 
-#define ATMEL_US_FIDI		0x40			/* FI DI Ratio Register */
-#define ATMEL_US_NER		0x44			/* Number of Errors Register */
-#define ATMEL_US_IF		0x4c			/* IrDA Filter Register */
+#define ATMEL_US_FIDI		0x40	/* FI DI Ratio Register */
+#define ATMEL_US_NER		0x44	/* Number of Errors Register */
+#define ATMEL_US_IF		0x4c	/* IrDA Filter Register */
 
-#define ATMEL_US_NAME		0xf0			/* Ip Name */
-#define ATMEL_US_VERSION	0xfc			/* Ip Version */
+#define ATMEL_US_NAME		0xf0	/* Ip Name */
+#define ATMEL_US_VERSION	0xfc	/* Ip Version */
 
 #endif
-- 
1.8.2.2

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

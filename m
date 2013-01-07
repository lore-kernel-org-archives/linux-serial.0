From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 1/5] serial: imx: Fix checkpatch errors related to spacing
Date: Mon,  7 Jan 2013 10:25:02 +0530
Message-ID: <1357534506-30206-2-git-send-email-sachin.kamat@linaro.org>
References: <1357534506-30206-1-git-send-email-sachin.kamat@linaro.org>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:43483 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750913Ab3AGFDU (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 7 Jan 2013 00:03:20 -0500
Received: by mail-pa0-f52.google.com with SMTP id fb1so10508982pad.39
        for <linux-serial@vger.kernel.org>; Sun, 06 Jan 2013 21:03:19 -0800 (PST)
In-Reply-To: <1357534506-30206-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: gregkh@linuxfoundation.org, alan@linux.intel.com, jslaby@suse.cz, shawn.guo@linaro.org, s.hauer@pengutronix.de, sachin.kamat@linaro.org, patches@linaro.org

Fixed checkpatch errors and warnings related to incorrect spacing.

Cc: Shawn Guo <shawn.guo@linaro.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/tty/serial/imx.c |  222 +++++++++++++++++++++++-----------------------
 1 files changed, 111 insertions(+), 111 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 5981912..d6bce6c 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -73,102 +73,102 @@
 #define IMX21_UTS 0xb4 /* UART Test Register on all other i.mx*/
 
 /* UART Control Register Bit Fields.*/
-#define  URXD_CHARRDY    (1<<15)
-#define  URXD_ERR        (1<<14)
-#define  URXD_OVRRUN     (1<<13)
-#define  URXD_FRMERR     (1<<12)
-#define  URXD_BRK        (1<<11)
-#define  URXD_PRERR      (1<<10)
-#define  UCR1_ADEN       (1<<15) /* Auto detect interrupt */
-#define  UCR1_ADBR       (1<<14) /* Auto detect baud rate */
-#define  UCR1_TRDYEN     (1<<13) /* Transmitter ready interrupt enable */
-#define  UCR1_IDEN       (1<<12) /* Idle condition interrupt */
-#define  UCR1_RRDYEN     (1<<9)	 /* Recv ready interrupt enable */
-#define  UCR1_RDMAEN     (1<<8)	 /* Recv ready DMA enable */
-#define  UCR1_IREN       (1<<7)	 /* Infrared interface enable */
-#define  UCR1_TXMPTYEN   (1<<6)	 /* Transimitter empty interrupt enable */
-#define  UCR1_RTSDEN     (1<<5)	 /* RTS delta interrupt enable */
-#define  UCR1_SNDBRK     (1<<4)	 /* Send break */
-#define  UCR1_TDMAEN     (1<<3)	 /* Transmitter ready DMA enable */
-#define  IMX1_UCR1_UARTCLKEN  (1<<2)  /* UART clock enabled, i.mx1 only */
-#define  UCR1_DOZE       (1<<1)	 /* Doze */
-#define  UCR1_UARTEN     (1<<0)	 /* UART enabled */
-#define  UCR2_ESCI     	 (1<<15) /* Escape seq interrupt enable */
-#define  UCR2_IRTS  	 (1<<14) /* Ignore RTS pin */
-#define  UCR2_CTSC  	 (1<<13) /* CTS pin control */
-#define  UCR2_CTS        (1<<12) /* Clear to send */
-#define  UCR2_ESCEN      (1<<11) /* Escape enable */
-#define  UCR2_PREN       (1<<8)  /* Parity enable */
-#define  UCR2_PROE       (1<<7)  /* Parity odd/even */
-#define  UCR2_STPB       (1<<6)	 /* Stop */
-#define  UCR2_WS         (1<<5)	 /* Word size */
-#define  UCR2_RTSEN      (1<<4)	 /* Request to send interrupt enable */
-#define  UCR2_ATEN       (1<<3)  /* Aging Timer Enable */
-#define  UCR2_TXEN       (1<<2)	 /* Transmitter enabled */
-#define  UCR2_RXEN       (1<<1)	 /* Receiver enabled */
-#define  UCR2_SRST 	 (1<<0)	 /* SW reset */
-#define  UCR3_DTREN 	 (1<<13) /* DTR interrupt enable */
-#define  UCR3_PARERREN   (1<<12) /* Parity enable */
-#define  UCR3_FRAERREN   (1<<11) /* Frame error interrupt enable */
-#define  UCR3_DSR        (1<<10) /* Data set ready */
-#define  UCR3_DCD        (1<<9)  /* Data carrier detect */
-#define  UCR3_RI         (1<<8)  /* Ring indicator */
-#define  UCR3_TIMEOUTEN  (1<<7)  /* Timeout interrupt enable */
-#define  UCR3_RXDSEN	 (1<<6)  /* Receive status interrupt enable */
-#define  UCR3_AIRINTEN   (1<<5)  /* Async IR wake interrupt enable */
-#define  UCR3_AWAKEN	 (1<<4)  /* Async wake interrupt enable */
-#define  IMX21_UCR3_RXDMUXSEL	 (1<<2)  /* RXD Muxed Input Select */
-#define  UCR3_INVT  	 (1<<1)  /* Inverted Infrared transmission */
-#define  UCR3_BPEN  	 (1<<0)  /* Preset registers enable */
-#define  UCR4_CTSTL_SHF  10      /* CTS trigger level shift */
-#define  UCR4_CTSTL_MASK 0x3F    /* CTS trigger is 6 bits wide */
-#define  UCR4_INVR  	 (1<<9)  /* Inverted infrared reception */
-#define  UCR4_ENIRI 	 (1<<8)  /* Serial infrared interrupt enable */
-#define  UCR4_WKEN  	 (1<<7)  /* Wake interrupt enable */
-#define  UCR4_REF16 	 (1<<6)  /* Ref freq 16 MHz */
-#define  UCR4_IRSC  	 (1<<5)  /* IR special case */
-#define  UCR4_TCEN  	 (1<<3)  /* Transmit complete interrupt enable */
-#define  UCR4_BKEN  	 (1<<2)  /* Break condition interrupt enable */
-#define  UCR4_OREN  	 (1<<1)  /* Receiver overrun interrupt enable */
-#define  UCR4_DREN  	 (1<<0)  /* Recv data ready interrupt enable */
-#define  UFCR_RXTL_SHF   0       /* Receiver trigger level shift */
-#define  UFCR_DCEDTE	 (1<<6)  /* DCE/DTE mode select */
-#define  UFCR_RFDIV      (7<<7)  /* Reference freq divider mask */
-#define  UFCR_RFDIV_REG(x)	(((x) < 7 ? 6 - (x) : 6) << 7)
-#define  UFCR_TXTL_SHF   10      /* Transmitter trigger level shift */
-#define  USR1_PARITYERR  (1<<15) /* Parity error interrupt flag */
-#define  USR1_RTSS  	 (1<<14) /* RTS pin status */
-#define  USR1_TRDY  	 (1<<13) /* Transmitter ready interrupt/dma flag */
-#define  USR1_RTSD  	 (1<<12) /* RTS delta */
-#define  USR1_ESCF  	 (1<<11) /* Escape seq interrupt flag */
-#define  USR1_FRAMERR    (1<<10) /* Frame error interrupt flag */
-#define  USR1_RRDY       (1<<9)	 /* Receiver ready interrupt/dma flag */
-#define  USR1_TIMEOUT    (1<<7)	 /* Receive timeout interrupt status */
-#define  USR1_RXDS  	 (1<<6)	 /* Receiver idle interrupt flag */
-#define  USR1_AIRINT	 (1<<5)	 /* Async IR wake interrupt flag */
-#define  USR1_AWAKE 	 (1<<4)	 /* Aysnc wake interrupt flag */
-#define  USR2_ADET  	 (1<<15) /* Auto baud rate detect complete */
-#define  USR2_TXFE  	 (1<<14) /* Transmit buffer FIFO empty */
-#define  USR2_DTRF  	 (1<<13) /* DTR edge interrupt flag */
-#define  USR2_IDLE  	 (1<<12) /* Idle condition */
-#define  USR2_IRINT 	 (1<<8)	 /* Serial infrared interrupt flag */
-#define  USR2_WAKE  	 (1<<7)	 /* Wake */
-#define  USR2_RTSF  	 (1<<4)	 /* RTS edge interrupt flag */
-#define  USR2_TXDC  	 (1<<3)	 /* Transmitter complete */
-#define  USR2_BRCD  	 (1<<2)	 /* Break condition */
-#define  USR2_ORE        (1<<1)	 /* Overrun error */
-#define  USR2_RDR        (1<<0)	 /* Recv data ready */
-#define  UTS_FRCPERR	 (1<<13) /* Force parity error */
-#define  UTS_LOOP        (1<<12) /* Loop tx and rx */
-#define  UTS_TXEMPTY	 (1<<6)	 /* TxFIFO empty */
-#define  UTS_RXEMPTY	 (1<<5)	 /* RxFIFO empty */
-#define  UTS_TXFULL 	 (1<<4)	 /* TxFIFO full */
-#define  UTS_RXFULL 	 (1<<3)	 /* RxFIFO full */
-#define  UTS_SOFTRST	 (1<<0)	 /* Software reset */
+#define URXD_CHARRDY	(1<<15)
+#define URXD_ERR	(1<<14)
+#define URXD_OVRRUN	(1<<13)
+#define URXD_FRMERR	(1<<12)
+#define URXD_BRK	(1<<11)
+#define URXD_PRERR	(1<<10)
+#define UCR1_ADEN	(1<<15) /* Auto detect interrupt */
+#define UCR1_ADBR	(1<<14) /* Auto detect baud rate */
+#define UCR1_TRDYEN	(1<<13) /* Transmitter ready interrupt enable */
+#define UCR1_IDEN	(1<<12) /* Idle condition interrupt */
+#define UCR1_RRDYEN	(1<<9)	/* Recv ready interrupt enable */
+#define UCR1_RDMAEN	(1<<8)	/* Recv ready DMA enable */
+#define UCR1_IREN	(1<<7)	/* Infrared interface enable */
+#define UCR1_TXMPTYEN	(1<<6)	/* Transimitter empty interrupt enable */
+#define UCR1_RTSDEN	(1<<5)	/* RTS delta interrupt enable */
+#define UCR1_SNDBRK	(1<<4)	/* Send break */
+#define UCR1_TDMAEN	(1<<3)	/* Transmitter ready DMA enable */
+#define IMX1_UCR1_UARTCLKEN (1<<2) /* UART clock enabled, i.mx1 only */
+#define UCR1_DOZE	(1<<1)	/* Doze */
+#define UCR1_UARTEN	(1<<0)	/* UART enabled */
+#define UCR2_ESCI	(1<<15)	/* Escape seq interrupt enable */
+#define UCR2_IRTS	(1<<14)	/* Ignore RTS pin */
+#define UCR2_CTSC	(1<<13)	/* CTS pin control */
+#define UCR2_CTS	(1<<12)	/* Clear to send */
+#define UCR2_ESCEN	(1<<11)	/* Escape enable */
+#define UCR2_PREN	(1<<8)	/* Parity enable */
+#define UCR2_PROE	(1<<7)	/* Parity odd/even */
+#define UCR2_STPB	(1<<6)	/* Stop */
+#define UCR2_WS		(1<<5)	/* Word size */
+#define UCR2_RTSEN	(1<<4)	/* Request to send interrupt enable */
+#define UCR2_ATEN	(1<<3)	/* Aging Timer Enable */
+#define UCR2_TXEN	(1<<2)	/* Transmitter enabled */
+#define UCR2_RXEN	(1<<1)	/* Receiver enabled */
+#define UCR2_SRST	(1<<0)	/* SW reset */
+#define UCR3_DTREN	(1<<13) /* DTR interrupt enable */
+#define UCR3_PARERREN	(1<<12) /* Parity enable */
+#define UCR3_FRAERREN	(1<<11) /* Frame error interrupt enable */
+#define UCR3_DSR	(1<<10) /* Data set ready */
+#define UCR3_DCD	(1<<9)	/* Data carrier detect */
+#define UCR3_RI		(1<<8)	/* Ring indicator */
+#define UCR3_TIMEOUTEN	(1<<7)	/* Timeout interrupt enable */
+#define UCR3_RXDSEN	(1<<6)	/* Receive status interrupt enable */
+#define UCR3_AIRINTEN	(1<<5)	/* Async IR wake interrupt enable */
+#define UCR3_AWAKEN	(1<<4)	/* Async wake interrupt enable */
+#define IMX21_UCR3_RXDMUXSEL	(1<<2)	/* RXD Muxed Input Select */
+#define UCR3_INVT	(1<<1)	/* Inverted Infrared transmission */
+#define UCR3_BPEN	(1<<0)	/* Preset registers enable */
+#define UCR4_CTSTL_SHF	10	/* CTS trigger level shift */
+#define UCR4_CTSTL_MASK	0x3F	/* CTS trigger is 6 bits wide */
+#define UCR4_INVR	(1<<9)	/* Inverted infrared reception */
+#define UCR4_ENIRI	(1<<8)	/* Serial infrared interrupt enable */
+#define UCR4_WKEN	(1<<7)	/* Wake interrupt enable */
+#define UCR4_REF16	(1<<6)	/* Ref freq 16 MHz */
+#define UCR4_IRSC	(1<<5)	/* IR special case */
+#define UCR4_TCEN	(1<<3)	/* Transmit complete interrupt enable */
+#define UCR4_BKEN	(1<<2)	/* Break condition interrupt enable */
+#define UCR4_OREN	(1<<1)	/* Receiver overrun interrupt enable */
+#define UCR4_DREN	(1<<0)	/* Recv data ready interrupt enable */
+#define UFCR_RXTL_SHF	0	/* Receiver trigger level shift */
+#define UFCR_DCEDTE	(1<<6)	/* DCE/DTE mode select */
+#define UFCR_RFDIV	(7<<7)	/* Reference freq divider mask */
+#define UFCR_RFDIV_REG(x)	(((x) < 7 ? 6 - (x) : 6) << 7)
+#define UFCR_TXTL_SHF	10	/* Transmitter trigger level shift */
+#define USR1_PARITYERR	(1<<15) /* Parity error interrupt flag */
+#define USR1_RTSS	(1<<14) /* RTS pin status */
+#define USR1_TRDY	(1<<13) /* Transmitter ready interrupt/dma flag */
+#define USR1_RTSD	(1<<12) /* RTS delta */
+#define USR1_ESCF	(1<<11) /* Escape seq interrupt flag */
+#define USR1_FRAMERR	(1<<10) /* Frame error interrupt flag */
+#define USR1_RRDY	(1<<9)	 /* Receiver ready interrupt/dma flag */
+#define USR1_TIMEOUT	(1<<7)	 /* Receive timeout interrupt status */
+#define USR1_RXDS	 (1<<6)	 /* Receiver idle interrupt flag */
+#define USR1_AIRINT	 (1<<5)	 /* Async IR wake interrupt flag */
+#define USR1_AWAKE	 (1<<4)	 /* Aysnc wake interrupt flag */
+#define USR2_ADET	 (1<<15) /* Auto baud rate detect complete */
+#define USR2_TXFE	 (1<<14) /* Transmit buffer FIFO empty */
+#define USR2_DTRF	 (1<<13) /* DTR edge interrupt flag */
+#define USR2_IDLE	 (1<<12) /* Idle condition */
+#define USR2_IRINT	 (1<<8)	 /* Serial infrared interrupt flag */
+#define USR2_WAKE	 (1<<7)	 /* Wake */
+#define USR2_RTSF	 (1<<4)	 /* RTS edge interrupt flag */
+#define USR2_TXDC	 (1<<3)	 /* Transmitter complete */
+#define USR2_BRCD	 (1<<2)	 /* Break condition */
+#define USR2_ORE	(1<<1)	 /* Overrun error */
+#define USR2_RDR	(1<<0)	 /* Recv data ready */
+#define UTS_FRCPERR	(1<<13) /* Force parity error */
+#define UTS_LOOP	(1<<12)	 /* Loop tx and rx */
+#define UTS_TXEMPTY	 (1<<6)	 /* TxFIFO empty */
+#define UTS_RXEMPTY	 (1<<5)	 /* RxFIFO empty */
+#define UTS_TXFULL	 (1<<4)	 /* TxFIFO full */
+#define UTS_RXFULL	 (1<<3)	 /* RxFIFO full */
+#define UTS_SOFTRST	 (1<<0)	 /* Software reset */
 
 /* We've been assigned a range on the "Low-density serial ports" major */
-#define SERIAL_IMX_MAJOR        207
-#define MINOR_START	        16
+#define SERIAL_IMX_MAJOR	207
+#define MINOR_START		16
 #define DEV_NAME		"ttymxc"
 
 /*
@@ -199,7 +199,7 @@ struct imx_port {
 	struct uart_port	port;
 	struct timer_list	timer;
 	unsigned int		old_status;
-	int			txirq,rxirq,rtsirq;
+	int			txirq, rxirq, rtsirq;
 	unsigned int		have_rtscts:1;
 	unsigned int		use_irda:1;
 	unsigned int		irda_inv_rx:1;
@@ -397,7 +397,7 @@ static void imx_stop_rx(struct uart_port *port)
 	unsigned long temp;
 
 	temp = readl(sport->port.membase + UCR2);
-	writel(temp &~ UCR2_RXEN, sport->port.membase + UCR2);
+	writel(temp & ~UCR2_RXEN, sport->port.membase + UCR2);
 }
 
 /*
@@ -490,7 +490,7 @@ static irqreturn_t imx_txint(int irq, void *dev_id)
 	struct circ_buf *xmit = &sport->port.state->xmit;
 	unsigned long flags;
 
-	spin_lock_irqsave(&sport->port.lock,flags);
+	spin_lock_irqsave(&sport->port.lock, flags);
 	if (sport->port.x_char)
 	{
 		/* Send next char */
@@ -509,18 +509,18 @@ static irqreturn_t imx_txint(int irq, void *dev_id)
 		uart_write_wakeup(&sport->port);
 
 out:
-	spin_unlock_irqrestore(&sport->port.lock,flags);
+	spin_unlock_irqrestore(&sport->port.lock, flags);
 	return IRQ_HANDLED;
 }
 
 static irqreturn_t imx_rxint(int irq, void *dev_id)
 {
 	struct imx_port *sport = dev_id;
-	unsigned int rx,flg,ignored = 0;
+	unsigned int rx, flg, ignored = 0;
 	struct tty_struct *tty = sport->port.state->port.tty;
 	unsigned long flags, temp;
 
-	spin_lock_irqsave(&sport->port.lock,flags);
+	spin_lock_irqsave(&sport->port.lock, flags);
 
 	while (readl(sport->port.membase + USR2) & USR2_RDR) {
 		flg = TTY_NORMAL;
@@ -574,7 +574,7 @@ static irqreturn_t imx_rxint(int irq, void *dev_id)
 	}
 
 out:
-	spin_unlock_irqrestore(&sport->port.lock,flags);
+	spin_unlock_irqrestore(&sport->port.lock, flags);
 	tty_flip_buffer_push(tty);
 	return IRQ_HANDLED;
 }
@@ -654,7 +654,7 @@ static void imx_break_ctl(struct uart_port *port, int break_state)
 
 	temp = readl(sport->port.membase + UCR1) & ~UCR1_SNDBRK;
 
-	if ( break_state != 0 )
+	if (break_state != 0)
 		temp |= UCR1_SNDBRK;
 
 	writel(temp, sport->port.membase + UCR1);
@@ -696,8 +696,8 @@ static int imx_startup(struct uart_port *port)
 		temp |= UCR4_IRSC;
 
 	/* set the trigger level for CTS */
-	temp &= ~(UCR4_CTSTL_MASK<<  UCR4_CTSTL_SHF);
-	temp |= CTSTL<<  UCR4_CTSTL_SHF;
+	temp &= ~(UCR4_CTSTL_MASK << UCR4_CTSTL_SHF);
+	temp |= CTSTL << UCR4_CTSTL_SHF;
 
 	writel(temp & ~UCR4_DREN, sport->port.membase + UCR4);
 
@@ -799,7 +799,7 @@ static int imx_startup(struct uart_port *port)
 	 * Enable modem status interrupts
 	 */
 	imx_enable_ms(&sport->port);
-	spin_unlock_irqrestore(&sport->port.lock,flags);
+	spin_unlock_irqrestore(&sport->port.lock, flags);
 
 	if (USE_IRDA(sport)) {
 		struct imxuart_platform_data *pdata;
@@ -909,7 +909,7 @@ imx_set_termios(struct uart_port *port, struct ktermios *termios,
 		ucr2 = UCR2_SRST | UCR2_IRTS;
 
 	if (termios->c_cflag & CRTSCTS) {
-		if( sport->have_rtscts ) {
+		if (sport->have_rtscts) {
 			ucr2 &= ~UCR2_IRTS;
 			ucr2 |= UCR2_CTSC;
 		} else {
@@ -969,12 +969,12 @@ imx_set_termios(struct uart_port *port, struct ktermios *termios,
 	writel(old_ucr1 & ~(UCR1_TXMPTYEN | UCR1_RRDYEN | UCR1_RTSDEN),
 			sport->port.membase + UCR1);
 
-	while ( !(readl(sport->port.membase + USR2) & USR2_TXDC))
+	while (!(readl(sport->port.membase + USR2) & USR2_TXDC))
 		barrier();
 
 	/* then, disable everything */
 	old_txrxen = readl(sport->port.membase + UCR2);
-	writel(old_txrxen & ~( UCR2_TXEN | UCR2_RXEN),
+	writel(old_txrxen & ~(UCR2_TXEN | UCR2_RXEN),
 			sport->port.membase + UCR2);
 	old_txrxen &= (UCR2_TXEN | UCR2_RXEN);
 
@@ -1255,7 +1255,7 @@ imx_console_get_options(struct imx_port *sport, int *baud,
 
 	if (readl(sport->port.membase + UCR1) & UCR1_UARTEN) {
 		/* ok, the port was enabled */
-		unsigned int ucr2, ubir,ubmr, uartclk;
+		unsigned int ucr2, ubir, ubmr, uartclk;
 		unsigned int baud_raw;
 		unsigned int ucfr_rfdiv;
 
@@ -1301,7 +1301,7 @@ imx_console_get_options(struct imx_port *sport, int *baud,
 			*baud = (baud_raw + 50) / 100 * 100;
 		}
 
-		if(*baud != baud_raw)
+		if (*baud != baud_raw)
 			printk(KERN_INFO "Serial: Console IMX rounded baud rate from %d to %d\n",
 				baud_raw, *baud);
 	}
@@ -1324,7 +1324,7 @@ imx_console_setup(struct console *co, char *options)
 	if (co->index == -1 || co->index >= ARRAY_SIZE(imx_ports))
 		co->index = 0;
 	sport = imx_ports[co->index];
-	if(sport == NULL)
+	if (sport == NULL)
 		return -ENODEV;
 
 	if (options)
-- 
1.7.4.1


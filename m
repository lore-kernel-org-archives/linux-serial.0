Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A577C433FE
	for <linux-serial@archiver.kernel.org>; Wed, 20 Oct 2021 15:04:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 02250611EF
	for <linux-serial@archiver.kernel.org>; Wed, 20 Oct 2021 15:04:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230383AbhJTPGS (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 20 Oct 2021 11:06:18 -0400
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:51980 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229570AbhJTPGQ (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 20 Oct 2021 11:06:16 -0400
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19KCL9Or029510;
        Wed, 20 Oct 2021 17:03:52 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=selector1;
 bh=bdjQpZMV8wDqZCWiD/042s2f3FqqytEaRW9O+lQPz/E=;
 b=4RGShy/t/rSbhZhVBEy5o/5UP+cqI/x+JXsDLpauECzSTGZ3RwlWaNTZCn1ICLXWe565
 Z7ePQdVSuyN+oX6uO2JK+JvT9awKtdZAzjqHIgQzKZVciAK4aTG6thMmyD00LMWIKrPW
 jrPp7ZiegURJFSUCu+vr9Ea3DhfpiHEgOwV4GiRCLEkp/mJn8mExHSJWtBwKatjWCuPL
 UkjVoxpRi3YN30TWld7PJvaOsqzoz6Yl04hg2zNaoeVFVq89ZfDdxMfTBOkw77gzd2w8
 m84t6zeRlNVJZi5C8pkiKzzn+jjFfYCrsSQ2x6DUGxCJb4H59DuD7pHt8RMUD0d1hSAs jg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 3btesktvr9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Oct 2021 17:03:52 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id D485810002A;
        Wed, 20 Oct 2021 17:03:51 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id CBCD122A6E8;
        Wed, 20 Oct 2021 17:03:51 +0200 (CEST)
Received: from localhost (10.75.127.47) by SFHDAG2NODE2.st.com (10.75.127.5)
 with Microsoft SMTP Server (TLS) id 15.0.1497.18; Wed, 20 Oct 2021 17:03:51
 +0200
From:   Erwan Le Ray <erwan.leray@foss.st.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
CC:     <linux-serial@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Erwan Le Ray <erwan.leray@foss.st.com>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        Valentin Caron <valentin.caron@foss.st.com>,
        Amelie Delaunay <amelie.delaunay@foss.st.com>
Subject: [PATCH 2/3] serial: stm32: rework RX over DMA
Date:   Wed, 20 Oct 2021 17:03:31 +0200
Message-ID: <20211020150332.10214-3-erwan.leray@foss.st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211020150332.10214-1-erwan.leray@foss.st.com>
References: <20211020150332.10214-1-erwan.leray@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG2NODE2.st.com (10.75.127.5) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-20_05,2021-10-20_02,2020-04-07_01
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

This patch reworks RX support over DMA to improve reliability:
- change dma buffer cyclic configuration by using 2 periods. DMA buffer
data are handled by a flip-flop between the 2 periods in order to avoid
risk of data loss/corruption
- change the size of dma buffer to 4096 to limit overruns
- add rx errors management (breaks, parity, framing and overrun).
  When an error occurs on the uart line, the dma request line is masked at
  HW level. The SW must 1st clear DMAR (dma request line enable), to
  handle the error, then re-enable DMAR to recover. So, any correct data
  is taken from the DMA buffer, before handling the error itself. Then
  errors are handled from RDR/ISR/FIFO (e.g. in PIO mode). Last, DMA
  reception is resumed.
- add a condition on DMA request line in DMA RX routines in order to
switch to PIO mode when no DMA request line is disabled, even if the DMA
channel is still enabled.
  When the UART is wakeup source and is configured to use DMA for RX, any
  incoming data that wakes up the system isn't correctly received.
  At data reception, the irq_handler handles the WUF irq, and then the
  data reception over DMA.
  As the DMA transfer has been terminated at suspend, and will be restored
  by resume callback (which has no yet been called by system), the data
  can't be received.
  The wake-up data has to be handled in PIO mode while suspend callback
  has not been called.

Signed-off-by: Valentin Caron <valentin.caron@foss.st.com>
Signed-off-by: Erwan Le Ray <erwan.leray@foss.st.com>

diff --git a/drivers/tty/serial/stm32-usart.c b/drivers/tty/serial/stm32-usart.c
index 848e063db2ae..cfdda35499e6 100644
--- a/drivers/tty/serial/stm32-usart.c
+++ b/drivers/tty/serial/stm32-usart.c
@@ -165,66 +165,60 @@ static int stm32_usart_init_rs485(struct uart_port *port,
 	return uart_get_rs485_mode(port);
 }
 
-static int stm32_usart_pending_rx(struct uart_port *port, u32 *sr,
-				  int *last_res, bool threaded)
+static bool stm32_usart_rx_dma_enabled(struct uart_port *port)
 {
 	struct stm32_port *stm32_port = to_stm32_port(port);
 	const struct stm32_usart_offsets *ofs = &stm32_port->info->ofs;
-	enum dma_status status;
-	struct dma_tx_state state;
 
-	*sr = readl_relaxed(port->membase + ofs->isr);
+	if (!stm32_port->rx_ch)
+		return false;
 
-	if (threaded && stm32_port->rx_ch) {
-		status = dmaengine_tx_status(stm32_port->rx_ch,
-					     stm32_port->rx_ch->cookie,
-					     &state);
-		if (status == DMA_IN_PROGRESS && (*last_res != state.residue))
-			return 1;
-		else
-			return 0;
-	} else if (*sr & USART_SR_RXNE) {
-		return 1;
+	return !!(readl_relaxed(port->membase + ofs->cr3) & USART_CR3_DMAR);
+}
+
+/* Return true when data is pending (in pio mode), and false when no data is pending. */
+static bool stm32_usart_pending_rx_pio(struct uart_port *port, u32 *sr)
+{
+	struct stm32_port *stm32_port = to_stm32_port(port);
+	const struct stm32_usart_offsets *ofs = &stm32_port->info->ofs;
+
+	*sr = readl_relaxed(port->membase + ofs->isr);
+	/* Get pending characters in RDR or FIFO */
+	if (*sr & USART_SR_RXNE) {
+		/* Get all pending characters from the RDR or the FIFO when using interrupts */
+		if (!stm32_usart_rx_dma_enabled(port))
+			return true;
+
+		/* Handle only RX data errors when using DMA */
+		if (*sr & USART_SR_ERR_MASK)
+			return true;
 	}
-	return 0;
+
+	return false;
 }
 
-static unsigned long stm32_usart_get_char(struct uart_port *port, u32 *sr,
-					  int *last_res)
+static unsigned long stm32_usart_get_char_pio(struct uart_port *port)
 {
 	struct stm32_port *stm32_port = to_stm32_port(port);
 	const struct stm32_usart_offsets *ofs = &stm32_port->info->ofs;
 	unsigned long c;
 
-	if (stm32_port->rx_ch) {
-		c = stm32_port->rx_buf[RX_BUF_L - (*last_res)--];
-		if ((*last_res) == 0)
-			*last_res = RX_BUF_L;
-	} else {
-		c = readl_relaxed(port->membase + ofs->rdr);
-		/* apply RDR data mask */
-		c &= stm32_port->rdr_mask;
-	}
+	c = readl_relaxed(port->membase + ofs->rdr);
+	/* Apply RDR data mask */
+	c &= stm32_port->rdr_mask;
 
 	return c;
 }
 
-static void stm32_usart_receive_chars(struct uart_port *port, bool irqflag)
+static void stm32_usart_receive_chars_pio(struct uart_port *port)
 {
-	struct tty_port *tport = &port->state->port;
 	struct stm32_port *stm32_port = to_stm32_port(port);
 	const struct stm32_usart_offsets *ofs = &stm32_port->info->ofs;
-	unsigned long c, flags;
+	unsigned long c;
 	u32 sr;
 	char flag;
 
-	if (irqflag)
-		spin_lock_irqsave(&port->lock, flags);
-	else
-		spin_lock(&port->lock);
-
-	while (stm32_usart_pending_rx(port, &sr, &stm32_port->last_res,
-				      irqflag)) {
+	while (stm32_usart_pending_rx_pio(port, &sr)) {
 		sr |= USART_SR_DUMMY_RX;
 		flag = TTY_NORMAL;
 
@@ -243,7 +237,7 @@ static void stm32_usart_receive_chars(struct uart_port *port, bool irqflag)
 			writel_relaxed(sr & USART_SR_ERR_MASK,
 				       port->membase + ofs->icr);
 
-		c = stm32_usart_get_char(port, &sr, &stm32_port->last_res);
+		c = stm32_usart_get_char_pio(port);
 		port->icount.rx++;
 		if (sr & USART_SR_ERR_MASK) {
 			if (sr & USART_SR_ORE) {
@@ -277,6 +271,94 @@ static void stm32_usart_receive_chars(struct uart_port *port, bool irqflag)
 			continue;
 		uart_insert_char(port, sr, USART_SR_ORE, c, flag);
 	}
+}
+
+static void stm32_usart_push_buffer_dma(struct uart_port *port, unsigned int dma_size)
+{
+	struct stm32_port *stm32_port = to_stm32_port(port);
+	struct tty_port *ttyport = &stm32_port->port.state->port;
+	unsigned char *dma_start;
+	int dma_count, i;
+
+	dma_start = stm32_port->rx_buf + (RX_BUF_L - stm32_port->last_res);
+
+	/*
+	 * Apply rdr_mask on buffer in order to mask parity bit.
+	 * This loop is useless in cs8 mode because DMA copies only
+	 * 8 bits and already ignores parity bit.
+	 */
+	if (!(stm32_port->rdr_mask == (BIT(8) - 1)))
+		for (i = 0; i < dma_size; i++)
+			*(dma_start + i) &= stm32_port->rdr_mask;
+
+	dma_count = tty_insert_flip_string(ttyport, dma_start, dma_size);
+	port->icount.rx += dma_count;
+	if (dma_count != dma_size)
+		port->icount.buf_overrun++;
+	stm32_port->last_res -= dma_count;
+	if (stm32_port->last_res == 0)
+		stm32_port->last_res = RX_BUF_L;
+}
+
+static void stm32_usart_receive_chars_dma(struct uart_port *port)
+{
+	struct stm32_port *stm32_port = to_stm32_port(port);
+	unsigned int dma_size;
+
+	/* DMA buffer is configured in cyclic mode and handles the rollback of the buffer. */
+	if (stm32_port->rx_dma_state.residue > stm32_port->last_res) {
+		/* Conditional first part: from last_res to end of DMA buffer */
+		dma_size = stm32_port->last_res;
+		stm32_usart_push_buffer_dma(port, dma_size);
+	}
+
+	dma_size = stm32_port->last_res - stm32_port->rx_dma_state.residue;
+	stm32_usart_push_buffer_dma(port, dma_size);
+}
+
+static void stm32_usart_receive_chars(struct uart_port *port, bool irqflag)
+{
+	struct tty_port *tport = &port->state->port;
+	struct stm32_port *stm32_port = to_stm32_port(port);
+	const struct stm32_usart_offsets *ofs = &stm32_port->info->ofs;
+	enum dma_status rx_dma_status;
+	unsigned long flags;
+	u32 sr;
+
+	if (irqflag)
+		spin_lock_irqsave(&port->lock, flags);
+	else
+		spin_lock(&port->lock);
+
+	if (stm32_usart_rx_dma_enabled(port)) {
+		rx_dma_status = dmaengine_tx_status(stm32_port->rx_ch,
+						    stm32_port->rx_ch->cookie,
+						    &stm32_port->rx_dma_state);
+		if (rx_dma_status == DMA_IN_PROGRESS) {
+			/* Empty DMA buffer */
+			stm32_usart_receive_chars_dma(port);
+			sr = readl_relaxed(port->membase + ofs->isr);
+			if (sr & USART_SR_ERR_MASK) {
+				/* Disable DMA request line */
+				stm32_usart_clr_bits(port, ofs->cr3, USART_CR3_DMAR);
+
+				/* Switch to PIO mode to handle the errors */
+				stm32_usart_receive_chars_pio(port);
+
+				/* Switch back to DMA mode */
+				stm32_usart_set_bits(port, ofs->cr3, USART_CR3_DMAR);
+			}
+		} else {
+			/* Disable RX DMA */
+			dmaengine_terminate_async(stm32_port->rx_ch);
+			stm32_usart_clr_bits(port, ofs->cr3, USART_CR3_DMAR);
+			/* Fall back to interrupt mode */
+			dev_dbg(port->dev, "DMA error, fallback to irq mode\n");
+			stm32_usart_receive_chars_pio(port);
+		}
+	} else {
+		stm32_usart_receive_chars_pio(port);
+	}
 
 	if (irqflag)
 		uart_unlock_and_check_sysrq_irqrestore(port, irqflag);
@@ -318,6 +400,13 @@ static void stm32_usart_tx_interrupt_enable(struct uart_port *port)
 		stm32_usart_set_bits(port, ofs->cr1, USART_CR1_TXEIE);
 }
 
+static void stm32_usart_rx_dma_complete(void *arg)
+{
+	struct uart_port *port = arg;
+
+	stm32_usart_receive_chars(port, true);
+}
+
 static void stm32_usart_tx_interrupt_disable(struct uart_port *port)
 {
 	struct stm32_port *stm32_port = to_stm32_port(port);
@@ -484,7 +573,12 @@ static irqreturn_t stm32_usart_interrupt(int irq, void *ptr)
 			pm_wakeup_event(tport->tty->dev, 0);
 	}
 
-	if ((sr & USART_SR_RXNE) && !(stm32_port->rx_ch))
+	/*
+	 * rx errors in dma mode has to be handled ASAP to avoid overrun as the DMA request
+	 * line has been masked by HW and rx data are stacking in FIFO.
+	 */
+	if (((sr & USART_SR_RXNE) && !stm32_usart_rx_dma_enabled(port)) ||
+	    ((sr & USART_SR_ERR_MASK) && stm32_usart_rx_dma_enabled(port)))
 		stm32_usart_receive_chars(port, false);
 
 	if ((sr & USART_SR_TXE) && !(stm32_port->tx_ch)) {
@@ -493,7 +587,7 @@ static irqreturn_t stm32_usart_interrupt(int irq, void *ptr)
 		spin_unlock(&port->lock);
 	}
 
-	if (stm32_port->rx_ch)
+	if (stm32_usart_rx_dma_enabled(port))
 		return IRQ_WAKE_THREAD;
 	else
 		return IRQ_HANDLED;
@@ -815,9 +909,11 @@ static void stm32_usart_set_termios(struct uart_port *port,
 		stm32_port->cr1_irq = USART_CR1_RTOIE;
 		writel_relaxed(bits, port->membase + ofs->rtor);
 		cr2 |= USART_CR2_RTOEN;
-		/* Not using dma, enable fifo threshold irq */
-		if (!stm32_port->rx_ch)
-			stm32_port->cr3_irq =  USART_CR3_RXFTIE;
+		/*
+		 * Enable fifo threshold irq in two cases, either when there is no DMA, or when
+		 * wake up over usart, from low power until the DMA gets re-enabled by resume.
+		 */
+		stm32_port->cr3_irq =  USART_CR3_RXFTIE;
 	}
 
 	cr1 |= stm32_port->cr1_irq;
@@ -880,8 +976,16 @@ static void stm32_usart_set_termios(struct uart_port *port,
 	if ((termios->c_cflag & CREAD) == 0)
 		port->ignore_status_mask |= USART_SR_DUMMY_RX;
 
-	if (stm32_port->rx_ch)
+	if (stm32_port->rx_ch) {
+		/*
+		 * Setup DMA to collect only valid data and enable error irqs.
+		 * This also enables break reception when using DMA.
+		 */
+		cr1 |= USART_CR1_PEIE;
+		cr3 |= USART_CR3_EIE;
 		cr3 |= USART_CR3_DMAR;
+		cr3 |= USART_CR3_DDRE;
+	}
 
 	if (rs485conf->flags & SER_RS485_ENABLED) {
 		stm32_usart_config_reg_rs485(&cr1, &cr3,
@@ -1210,9 +1314,9 @@ static int stm32_usart_of_dma_rx_probe(struct stm32_port *stm32port,
 		return -ENODEV;
 	}
 
-	/* No callback as dma buffer is drained on usart interrupt */
-	desc->callback = NULL;
-	desc->callback_param = NULL;
+	/* Set DMA callback */
+	desc->callback = stm32_usart_rx_dma_complete;
+	desc->callback_param = port;
 
 	/* Push current DMA transaction in the pending queue */
 	ret = dma_submit_error(dmaengine_submit(desc));
@@ -1377,6 +1481,7 @@ static int stm32_usart_serial_remove(struct platform_device *pdev)
 	struct stm32_port *stm32_port = to_stm32_port(port);
 	const struct stm32_usart_offsets *ofs = &stm32_port->info->ofs;
 	int err;
+	u32 cr3;
 
 	pm_runtime_get_sync(&pdev->dev);
 	err = uart_remove_one_port(&stm32_usart_driver, port);
@@ -1387,7 +1492,12 @@ static int stm32_usart_serial_remove(struct platform_device *pdev)
 	pm_runtime_set_suspended(&pdev->dev);
 	pm_runtime_put_noidle(&pdev->dev);
 
-	stm32_usart_clr_bits(port, ofs->cr3, USART_CR3_DMAR);
+	stm32_usart_clr_bits(port, ofs->cr1, USART_CR1_PEIE);
+	cr3 = readl_relaxed(port->membase + ofs->cr3);
+	cr3 &= ~USART_CR3_EIE;
+	cr3 &= ~USART_CR3_DMAR;
+	cr3 &= ~USART_CR3_DDRE;
+	writel_relaxed(cr3, port->membase + ofs->cr3);
 
 	if (stm32_port->tx_ch) {
 		dmaengine_terminate_async(stm32_port->tx_ch);
diff --git a/drivers/tty/serial/stm32-usart.h b/drivers/tty/serial/stm32-usart.h
index 07ac291328cd..53bcd032fce7 100644
--- a/drivers/tty/serial/stm32-usart.h
+++ b/drivers/tty/serial/stm32-usart.h
@@ -109,7 +109,7 @@ struct stm32_usart_info stm32h7_info = {
 /* USART_SR (F4) / USART_ISR (F7) */
 #define USART_SR_PE		BIT(0)
 #define USART_SR_FE		BIT(1)
-#define USART_SR_NF		BIT(2)
+#define USART_SR_NE		BIT(2)		/* F7 (NF for F4) */
 #define USART_SR_ORE		BIT(3)
 #define USART_SR_IDLE		BIT(4)
 #define USART_SR_RXNE		BIT(5)
@@ -126,7 +126,8 @@ struct stm32_usart_info stm32h7_info = {
 #define USART_SR_SBKF		BIT(18)		/* F7 */
 #define USART_SR_WUF		BIT(20)		/* H7 */
 #define USART_SR_TEACK		BIT(21)		/* F7 */
-#define USART_SR_ERR_MASK	(USART_SR_ORE | USART_SR_FE | USART_SR_PE)
+#define USART_SR_ERR_MASK	(USART_SR_ORE | USART_SR_NE | USART_SR_FE |\
+				 USART_SR_PE)
 /* Dummy bits */
 #define USART_SR_DUMMY_RX	BIT(16)
 
@@ -246,9 +247,9 @@ struct stm32_usart_info stm32h7_info = {
 #define STM32_SERIAL_NAME "ttySTM"
 #define STM32_MAX_PORTS 8
 
-#define RX_BUF_L 200		 /* dma rx buffer length     */
-#define RX_BUF_P RX_BUF_L	 /* dma rx buffer period     */
-#define TX_BUF_L 200		 /* dma tx buffer length     */
+#define RX_BUF_L 4096		 /* dma rx buffer length     */
+#define RX_BUF_P (RX_BUF_L / 2)	 /* dma rx buffer period     */
+#define TX_BUF_L RX_BUF_L	 /* dma tx buffer length     */
 
 struct stm32_port {
 	struct uart_port port;
@@ -272,6 +273,7 @@ struct stm32_port {
 	bool wakeup_src;
 	int rdr_mask;		/* receive data register mask */
 	struct mctrl_gpios *gpios; /* modem control gpios */
+	struct dma_tx_state rx_dma_state;
 };
 
 static struct stm32_port stm32_ports[STM32_MAX_PORTS];
-- 
2.17.1


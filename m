Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B1FFC433F5
	for <linux-serial@archiver.kernel.org>; Mon, 25 Oct 2021 13:42:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 40C7560E05
	for <linux-serial@archiver.kernel.org>; Mon, 25 Oct 2021 13:42:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232487AbhJYNpQ (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 25 Oct 2021 09:45:16 -0400
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:45776 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232740AbhJYNpN (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 25 Oct 2021 09:45:13 -0400
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19PCL7sI012711;
        Mon, 25 Oct 2021 15:42:37 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=selector1;
 bh=7U0Zv2sNxlzWwOzOAADIvrklLXlL08SzxW07I/R4P/U=;
 b=mE+dhylOoG1/Nr05EWhqsMDC7D7tU2EPVYfSnghyecSpqLd7n77crSmKeAUueENze8Kd
 zwBCZ5c2tfLjimJf4jaDPRmfZaOw6nPDcwu5u+CnhVUcIMCTm0L2CdvJJKV2bRMPO8h5
 e2eCxCoc/WD7ldPiBSBf61X8v+w6MUGnFVbSwFgRAxZ/TmkDATmTYJ12wdltQtNhKYcC
 F7bQf4DebumINB/eL1uIHTa0fpJb3//DrCvqPJcvEVSBeJWZteahd1x8Es8Rg6lHF8g9
 C2d4CG7/0Uog+HukLfbIyDSJLXnXOku39xD2C1Kw8t6jDPh/OCLwK5YJn6Ygg7uHxO4q rw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 3bwqpsjafd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 25 Oct 2021 15:42:37 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 92F3E10002A;
        Mon, 25 Oct 2021 15:42:36 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 8A9CA2309DF;
        Mon, 25 Oct 2021 15:42:36 +0200 (CEST)
Received: from localhost (10.75.127.46) by SFHDAG2NODE2.st.com (10.75.127.5)
 with Microsoft SMTP Server (TLS) id 15.0.1497.18; Mon, 25 Oct 2021 15:42:36
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
Subject: [PATCH 3/3] serial: stm32: push DMA RX data before suspending
Date:   Mon, 25 Oct 2021 15:42:29 +0200
Message-ID: <20211025134229.8456-4-erwan.leray@foss.st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211025134229.8456-1-erwan.leray@foss.st.com>
References: <20211025134229.8456-1-erwan.leray@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.46]
X-ClientProxiedBy: SFHDAG2NODE2.st.com (10.75.127.5) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-25_05,2021-10-25_02,2020-04-07_01
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Data may be stored in DMA RX buffer, when suspending. The data needs
to be pushed to the upper layer. We can't rely on the timeout IRQ (RTOR)
that can't be triggered into low power state. So safely clear DMA request
(DMAR), force the DMA reception routines to push RX buffer content, before
disabling RX DMA. This way, handover to pio mode is safe.
Only call tty_flip_buffer_push() when there is RX data to handle.

Move the locking outside of stm32_usart_receive_chars() to prevent a race
condition, when disabling DMA request upon suspend / pm_runtime_suspend.
Data may be received under IRQ and pushed before
stm32_usart_receive_chars() has pushed older data from DMA rx_buf upon
suspend.
The sequence in suspend routine needs proper locking to avoid this.

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Signed-off-by: Erwan Le Ray <erwan.leray@foss.st.com>

diff --git a/drivers/tty/serial/stm32-usart.c b/drivers/tty/serial/stm32-usart.c
index 4b5b0748790c..3244e7f6818c 100644
--- a/drivers/tty/serial/stm32-usart.c
+++ b/drivers/tty/serial/stm32-usart.c
@@ -210,11 +210,12 @@ static unsigned long stm32_usart_get_char_pio(struct uart_port *port)
 	return c;
 }
 
-static void stm32_usart_receive_chars_pio(struct uart_port *port)
+static unsigned int stm32_usart_receive_chars_pio(struct uart_port *port)
 {
 	struct stm32_port *stm32_port = to_stm32_port(port);
 	const struct stm32_usart_offsets *ofs = &stm32_port->info->ofs;
 	unsigned long c;
+	unsigned int size = 0;
 	u32 sr;
 	char flag;
 
@@ -239,6 +240,7 @@ static void stm32_usart_receive_chars_pio(struct uart_port *port)
 
 		c = stm32_usart_get_char_pio(port);
 		port->icount.rx++;
+		size++;
 		if (sr & USART_SR_ERR_MASK) {
 			if (sr & USART_SR_ORE) {
 				port->icount.overrun++;
@@ -271,6 +273,8 @@ static void stm32_usart_receive_chars_pio(struct uart_port *port)
 			continue;
 		uart_insert_char(port, sr, USART_SR_ORE, c, flag);
 	}
+
+	return size;
 }
 
 static void stm32_usart_push_buffer_dma(struct uart_port *port, unsigned int dma_size)
@@ -300,50 +304,48 @@ static void stm32_usart_push_buffer_dma(struct uart_port *port, unsigned int dma
 		stm32_port->last_res = RX_BUF_L;
 }
 
-static void stm32_usart_receive_chars_dma(struct uart_port *port)
+static unsigned int stm32_usart_receive_chars_dma(struct uart_port *port)
 {
 	struct stm32_port *stm32_port = to_stm32_port(port);
-	unsigned int dma_size;
+	unsigned int dma_size, size = 0;
 
 	/* DMA buffer is configured in cyclic mode and handles the rollback of the buffer. */
 	if (stm32_port->rx_dma_state.residue > stm32_port->last_res) {
 		/* Conditional first part: from last_res to end of DMA buffer */
 		dma_size = stm32_port->last_res;
 		stm32_usart_push_buffer_dma(port, dma_size);
+		size = dma_size;
 	}
 
 	dma_size = stm32_port->last_res - stm32_port->rx_dma_state.residue;
 	stm32_usart_push_buffer_dma(port, dma_size);
+	size += dma_size;
+
+	return size;
 }
 
-static void stm32_usart_receive_chars(struct uart_port *port, bool irqflag)
+static unsigned int stm32_usart_receive_chars(struct uart_port *port, bool force_dma_flush)
 {
-	struct tty_port *tport = &port->state->port;
 	struct stm32_port *stm32_port = to_stm32_port(port);
 	const struct stm32_usart_offsets *ofs = &stm32_port->info->ofs;
 	enum dma_status rx_dma_status;
-	unsigned long flags;
 	u32 sr;
+	unsigned int size = 0;
 
-	if (irqflag)
-		spin_lock_irqsave(&port->lock, flags);
-	else
-		spin_lock(&port->lock);
-
-	if (stm32_usart_rx_dma_enabled(port)) {
+	if (stm32_usart_rx_dma_enabled(port) || force_dma_flush) {
 		rx_dma_status = dmaengine_tx_status(stm32_port->rx_ch,
 						    stm32_port->rx_ch->cookie,
 						    &stm32_port->rx_dma_state);
 		if (rx_dma_status == DMA_IN_PROGRESS) {
 			/* Empty DMA buffer */
-			stm32_usart_receive_chars_dma(port);
+			size = stm32_usart_receive_chars_dma(port);
 			sr = readl_relaxed(port->membase + ofs->isr);
 			if (sr & USART_SR_ERR_MASK) {
 				/* Disable DMA request line */
 				stm32_usart_clr_bits(port, ofs->cr3, USART_CR3_DMAR);
 
 				/* Switch to PIO mode to handle the errors */
-				stm32_usart_receive_chars_pio(port);
+				size += stm32_usart_receive_chars_pio(port);
 
 				/* Switch back to DMA mode */
 				stm32_usart_set_bits(port, ofs->cr3, USART_CR3_DMAR);
@@ -354,18 +356,13 @@ static void stm32_usart_receive_chars(struct uart_port *port, bool irqflag)
 			stm32_usart_clr_bits(port, ofs->cr3, USART_CR3_DMAR);
 			/* Fall back to interrupt mode */
 			dev_dbg(port->dev, "DMA error, fallback to irq mode\n");
-			stm32_usart_receive_chars_pio(port);
+			size = stm32_usart_receive_chars_pio(port);
 		}
 	} else {
-		stm32_usart_receive_chars_pio(port);
+		size = stm32_usart_receive_chars_pio(port);
 	}
 
-	if (irqflag)
-		uart_unlock_and_check_sysrq_irqrestore(port, irqflag);
-	else
-		uart_unlock_and_check_sysrq(port);
-
-	tty_flip_buffer_push(tport);
+	return size;
 }
 
 static void stm32_usart_tx_dma_complete(void *arg)
@@ -403,8 +400,15 @@ static void stm32_usart_tx_interrupt_enable(struct uart_port *port)
 static void stm32_usart_rx_dma_complete(void *arg)
 {
 	struct uart_port *port = arg;
+	struct tty_port *tport = &port->state->port;
+	unsigned int size;
+	unsigned long flags;
 
-	stm32_usart_receive_chars(port, true);
+	spin_lock_irqsave(&port->lock, flags);
+	size = stm32_usart_receive_chars(port, false);
+	uart_unlock_and_check_sysrq_irqrestore(port, flags);
+	if (size)
+		tty_flip_buffer_push(tport);
 }
 
 static void stm32_usart_tx_interrupt_disable(struct uart_port *port)
@@ -557,6 +561,7 @@ static irqreturn_t stm32_usart_interrupt(int irq, void *ptr)
 	struct stm32_port *stm32_port = to_stm32_port(port);
 	const struct stm32_usart_offsets *ofs = &stm32_port->info->ofs;
 	u32 sr;
+	unsigned int size;
 
 	sr = readl_relaxed(port->membase + ofs->isr);
 
@@ -580,7 +585,11 @@ static irqreturn_t stm32_usart_interrupt(int irq, void *ptr)
 	if (!stm32_port->throttled) {
 		if (((sr & USART_SR_RXNE) && !stm32_usart_rx_dma_enabled(port)) ||
 		    ((sr & USART_SR_ERR_MASK) && stm32_usart_rx_dma_enabled(port))) {
-			stm32_usart_receive_chars(port, false);
+			spin_lock(&port->lock);
+			size = stm32_usart_receive_chars(port, false);
+			uart_unlock_and_check_sysrq(port);
+			if (size)
+				tty_flip_buffer_push(tport);
 		}
 	}
 
@@ -599,11 +608,19 @@ static irqreturn_t stm32_usart_interrupt(int irq, void *ptr)
 static irqreturn_t stm32_usart_threaded_interrupt(int irq, void *ptr)
 {
 	struct uart_port *port = ptr;
+	struct tty_port *tport = &port->state->port;
 	struct stm32_port *stm32_port = to_stm32_port(port);
+	unsigned int size;
+	unsigned long flags;
 
 	/* Receiver timeout irq for DMA RX */
-	if (!stm32_port->throttled)
-		stm32_usart_receive_chars(port, false);
+	if (!stm32_port->throttled) {
+		spin_lock_irqsave(&port->lock, flags);
+		size = stm32_usart_receive_chars(port, false);
+		uart_unlock_and_check_sysrq_irqrestore(port, flags);
+		if (size)
+			tty_flip_buffer_push(tport);
+	}
 
 	return IRQ_HANDLED;
 }
@@ -1678,6 +1695,8 @@ static int __maybe_unused stm32_usart_serial_en_wakeup(struct uart_port *port,
 	const struct stm32_usart_offsets *ofs = &stm32_port->info->ofs;
 	struct tty_port *tport = &port->state->port;
 	int ret;
+	unsigned int size;
+	unsigned long flags;
 
 	if (!stm32_port->wakeup_src || !tty_port_initialized(tport))
 		return 0;
@@ -1696,8 +1715,15 @@ static int __maybe_unused stm32_usart_serial_en_wakeup(struct uart_port *port,
 		 * low-power mode.
 		 */
 		if (stm32_port->rx_ch) {
+			spin_lock_irqsave(&port->lock, flags);
+			/* Avoid race with RX IRQ when DMAR is cleared */
 			stm32_usart_clr_bits(port, ofs->cr3, USART_CR3_DMAR);
-			dmaengine_terminate_sync(stm32_port->rx_ch);
+			/* Poll data from DMA RX buffer if any */
+			size = stm32_usart_receive_chars(port, true);
+			dmaengine_terminate_async(stm32_port->rx_ch);
+			uart_unlock_and_check_sysrq_irqrestore(port, flags);
+			if (size)
+				tty_flip_buffer_push(tport);
 		}
 
 		/* Poll data from RX FIFO if any */
-- 
2.17.1


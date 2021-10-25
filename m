Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D16A4C433F5
	for <linux-serial@archiver.kernel.org>; Mon, 25 Oct 2021 13:42:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B921D60E05
	for <linux-serial@archiver.kernel.org>; Mon, 25 Oct 2021 13:42:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232745AbhJYNpN (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 25 Oct 2021 09:45:13 -0400
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:43258 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232487AbhJYNpM (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 25 Oct 2021 09:45:12 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19P8D6SK003402;
        Mon, 25 Oct 2021 15:42:35 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=selector1;
 bh=hR+h0mj9eAIHJV+3ilRJChIbgb6EPcNV71c8l1Q/vvM=;
 b=yDL3uWZJXZl0T5Zw23sTZJNBLrYKn2jeSEHxxqCqoYTZDdfsUJ2oDtgVnI3Zb5pe+4sQ
 jkThkutudBiFG+JfxvSlIcYGE9Zt13K7sYGMpUopc7uI/2iaHculeJn2gO5QYtMxp5ZT
 0DyJnX5wx1FG29neF7BxVZSbwXyKlZl6mL78vc2Wfkj/gCDRqmXa4Bk86cIyHnnyT/jt
 pftVa8UytSjfBOtrbIiCQZSoJXN4U4uSpJ1uhaGGN/UOkmH/JuwBaR+LVQw6pwUi5+QU
 HDoBiu5yqEicz6yJWIJLaJT1YChISv7ikw5wQ0QZCzvJcHUYiiUF79P9hvpAb/fIph+2 yA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 3bwrvj1t9h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 25 Oct 2021 15:42:35 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 31024100034;
        Mon, 25 Oct 2021 15:42:35 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 2903F2309DF;
        Mon, 25 Oct 2021 15:42:35 +0200 (CEST)
Received: from localhost (10.75.127.44) by SFHDAG2NODE2.st.com (10.75.127.5)
 with Microsoft SMTP Server (TLS) id 15.0.1497.18; Mon, 25 Oct 2021 15:42:34
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
Subject: [PATCH 1/3] serial: stm32: rework RX dma initialization and release
Date:   Mon, 25 Oct 2021 15:42:27 +0200
Message-ID: <20211025134229.8456-2-erwan.leray@foss.st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211025134229.8456-1-erwan.leray@foss.st.com>
References: <20211025134229.8456-1-erwan.leray@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG2NODE2.st.com (10.75.127.5) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-25_05,2021-10-25_02,2020-04-07_01
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The RX DMA channel is kept active forever (from the probe). That prevents
going to low power mode when it is used. This change moves the
DMA configuration and enabling procedures to startup routine to allow
transition to low power mode.
The DMA disabling procedure is implemented in stop_rx routine as this
ops has to stop characters reception, and DMA transation in shutdown.
Clean useless dma_async_tx_descriptor initialization to NULL value.

Signed-off-by: Valentin Caron <valentin.caron@foss.st.com>
Signed-off-by: Erwan Le Ray <erwan.leray@foss.st.com>

diff --git a/drivers/tty/serial/stm32-usart.c b/drivers/tty/serial/stm32-usart.c
index 7fd192e1e15d..ee3495c0abbb 100644
--- a/drivers/tty/serial/stm32-usart.c
+++ b/drivers/tty/serial/stm32-usart.c
@@ -761,6 +761,10 @@ static void stm32_usart_stop_rx(struct uart_port *port)
 	struct stm32_port *stm32_port = to_stm32_port(port);
 	const struct stm32_usart_offsets *ofs = &stm32_port->info->ofs;
 
+	/* Disable DMA request line. */
+	if (stm32_port->rx_ch)
+		stm32_usart_clr_bits(port, ofs->cr3, USART_CR3_DMAR);
+
 	stm32_usart_clr_bits(port, ofs->cr1, stm32_port->cr1_irq);
 	if (stm32_port->cr3_irq)
 		stm32_usart_clr_bits(port, ofs->cr3, stm32_port->cr3_irq);
@@ -777,6 +781,7 @@ static int stm32_usart_startup(struct uart_port *port)
 	const struct stm32_usart_offsets *ofs = &stm32_port->info->ofs;
 	const struct stm32_usart_config *cfg = &stm32_port->info->cfg;
 	const char *name = to_platform_device(port->dev)->name;
+	struct dma_async_tx_descriptor *desc;
 	u32 val;
 	int ret;
 
@@ -797,6 +802,33 @@ static int stm32_usart_startup(struct uart_port *port)
 	if (ofs->rqr != UNDEF_REG)
 		writel_relaxed(USART_RQR_RXFRQ, port->membase + ofs->rqr);
 
+	if (stm32_port->rx_ch) {
+		stm32_port->last_res = RX_BUF_L;
+		/* Prepare a DMA cyclic transaction */
+		desc = dmaengine_prep_dma_cyclic(stm32_port->rx_ch,
+						 stm32_port->rx_dma_buf,
+						 RX_BUF_L, RX_BUF_P,
+						 DMA_DEV_TO_MEM,
+						 DMA_PREP_INTERRUPT);
+		if (!desc) {
+			dev_err(port->dev, "rx dma prep cyclic failed\n");
+			ret = -ENODEV;
+			goto err;
+		}
+
+		desc->callback = stm32_usart_rx_dma_complete;
+		desc->callback_param = port;
+
+		/* Push current DMA transaction in the pending queue */
+		ret = dma_submit_error(dmaengine_submit(desc));
+		if (ret) {
+			dmaengine_terminate_sync(stm32_port->rx_ch);
+			goto err;
+		}
+
+		/* Issue pending DMA requests */
+		dma_async_issue_pending(stm32_port->rx_ch);
+	}
 	/*
 	 * DMA request line not re-enabled at resume when port is throttled.
 	 * It will be re-enabled by unthrottle ops.
@@ -809,6 +841,11 @@ static int stm32_usart_startup(struct uart_port *port)
 	stm32_usart_set_bits(port, ofs->cr1, val);
 
 	return 0;
+
+err:
+	free_irq(port->irq, port);
+
+	return ret;
 }
 
 static void stm32_usart_shutdown(struct uart_port *port)
@@ -836,6 +873,10 @@ static void stm32_usart_shutdown(struct uart_port *port)
 	if (ret)
 		dev_err(port->dev, "Transmission is not complete\n");
 
+	/* Disable RX DMA. */
+	if (stm32_port->rx_ch)
+		dmaengine_terminate_async(stm32_port->rx_ch);
+
 	/* flush RX & TX FIFO */
 	if (ofs->rqr != UNDEF_REG)
 		writel_relaxed(USART_RQR_TXFRQ | USART_RQR_RXFRQ,
@@ -1304,7 +1345,6 @@ static int stm32_usart_of_dma_rx_probe(struct stm32_port *stm32port,
 	struct uart_port *port = &stm32port->port;
 	struct device *dev = &pdev->dev;
 	struct dma_slave_config config;
-	struct dma_async_tx_descriptor *desc = NULL;
 	int ret;
 
 	/*
@@ -1332,32 +1372,6 @@ static int stm32_usart_of_dma_rx_probe(struct stm32_port *stm32port,
 		return ret;
 	}
 
-	/* Prepare a DMA cyclic transaction */
-	desc = dmaengine_prep_dma_cyclic(stm32port->rx_ch,
-					 stm32port->rx_dma_buf,
-					 RX_BUF_L, RX_BUF_P, DMA_DEV_TO_MEM,
-					 DMA_PREP_INTERRUPT);
-	if (!desc) {
-		dev_err(dev, "rx dma prep cyclic failed\n");
-		stm32_usart_of_dma_rx_remove(stm32port, pdev);
-		return -ENODEV;
-	}
-
-	/* Set DMA callback */
-	desc->callback = stm32_usart_rx_dma_complete;
-	desc->callback_param = port;
-
-	/* Push current DMA transaction in the pending queue */
-	ret = dma_submit_error(dmaengine_submit(desc));
-	if (ret) {
-		dmaengine_terminate_sync(stm32port->rx_ch);
-		stm32_usart_of_dma_rx_remove(stm32port, pdev);
-		return ret;
-	}
-
-	/* Issue pending DMA requests */
-	dma_async_issue_pending(stm32port->rx_ch);
-
 	return 0;
 }
 
@@ -1535,7 +1549,6 @@ static int stm32_usart_serial_remove(struct platform_device *pdev)
 	}
 
 	if (stm32_port->rx_ch) {
-		dmaengine_terminate_async(stm32_port->rx_ch);
 		stm32_usart_of_dma_rx_remove(stm32_port, pdev);
 		dma_release_channel(stm32_port->rx_ch);
 	}
-- 
2.17.1


Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AAABC4332F
	for <linux-serial@archiver.kernel.org>; Mon, 25 Oct 2021 13:42:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 81C5A60EDF
	for <linux-serial@archiver.kernel.org>; Mon, 25 Oct 2021 13:42:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232785AbhJYNpN (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 25 Oct 2021 09:45:13 -0400
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:43264 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232692AbhJYNpM (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 25 Oct 2021 09:45:12 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19P8CwEa003297;
        Mon, 25 Oct 2021 15:42:36 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=selector1;
 bh=W0oRgchsCYcZpiV/Ypg4RY1iam19qKNxv3BV3g4lEeQ=;
 b=Jt8nAda2jTrXfhLQUtgIlVCFHCD40C/H7KynBrxtqOftqI6Q5X+UvzmLlNYR/E46jJR+
 YGtVG3ne0CuL/uiCwxfQItlgbGtF8d8qQ4dAYXpqhO5WuKx71cSV+y3+vjJ6QEBR06oL
 DAhIGMnX32kDiqHj+0qk/7ER1BOMtH8FAvQ+Ef+JGmclF6spV3jzaza4qYSYHqgN5VTl
 kWJT2HnJrT2Lj0Q4DSBzBgchEHxDQS2NtwZfyeQ1ldgS4hcyXu9HPm3ngGvkGmp6+MEa
 cfIet8unQfDxxQsXt2n8K8IqGSuTB0414KzR5LlmtxTo62GcWzN1xaYxVDL/3P996GlE DQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 3bwrvj1t9k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 25 Oct 2021 15:42:36 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 06976100038;
        Mon, 25 Oct 2021 15:42:36 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id F09282309DF;
        Mon, 25 Oct 2021 15:42:35 +0200 (CEST)
Received: from localhost (10.75.127.45) by SFHDAG2NODE2.st.com (10.75.127.5)
 with Microsoft SMTP Server (TLS) id 15.0.1497.18; Mon, 25 Oct 2021 15:42:35
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
Subject: [PATCH 2/3] serial: stm32: terminate / restart DMA transfer at suspend / resume
Date:   Mon, 25 Oct 2021 15:42:28 +0200
Message-ID: <20211025134229.8456-3-erwan.leray@foss.st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211025134229.8456-1-erwan.leray@foss.st.com>
References: <20211025134229.8456-1-erwan.leray@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG1NODE3.st.com (10.75.127.3) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-25_05,2021-10-25_02,2020-04-07_01
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

DMA prevents the system to suspend when an UART RX wake-up source is
using DMA. DMA can't suspend while DMA channels are still active.

Terminate DMA transfer at suspend, and restart a new DMA transfer at
resume. Create stm32_usart_start_rx_dma_cyclic function to factorize
dma RX initialization. Move RX DMA code related to wakeup into
stm32_usart_serial_en_wakeup() routine to ease further improvements
on wakeup from low power modes.

Don't enable/disable wakeup on uninitialized port.

There may be data residue in the RX FIFO while suspending. Flush it at
suspend time. Receiver timeout interrupt won't trigger later in low power
mode, so call stm32_usart_receive_chars() in case there's data to handle.

Signed-off-by: Valentin Caron <valentin.caron@foss.st.com>
Signed-off-by: Erwan Le Ray <erwan.leray@foss.st.com>

diff --git a/drivers/tty/serial/stm32-usart.c b/drivers/tty/serial/stm32-usart.c
index ee3495c0abbb..4b5b0748790c 100644
--- a/drivers/tty/serial/stm32-usart.c
+++ b/drivers/tty/serial/stm32-usart.c
@@ -775,13 +775,54 @@ static void stm32_usart_break_ctl(struct uart_port *port, int break_state)
 {
 }
 
+static int stm32_usart_start_rx_dma_cyclic(struct uart_port *port)
+{
+	struct stm32_port *stm32_port = to_stm32_port(port);
+	const struct stm32_usart_offsets *ofs = &stm32_port->info->ofs;
+	struct dma_async_tx_descriptor *desc;
+	int ret;
+
+	stm32_port->last_res = RX_BUF_L;
+	/* Prepare a DMA cyclic transaction */
+	desc = dmaengine_prep_dma_cyclic(stm32_port->rx_ch,
+					 stm32_port->rx_dma_buf,
+					 RX_BUF_L, RX_BUF_P,
+					 DMA_DEV_TO_MEM,
+					 DMA_PREP_INTERRUPT);
+	if (!desc) {
+		dev_err(port->dev, "rx dma prep cyclic failed\n");
+		return -ENODEV;
+	}
+
+	desc->callback = stm32_usart_rx_dma_complete;
+	desc->callback_param = port;
+
+	/* Push current DMA transaction in the pending queue */
+	ret = dma_submit_error(dmaengine_submit(desc));
+	if (ret) {
+		dmaengine_terminate_sync(stm32_port->rx_ch);
+		return ret;
+	}
+
+	/* Issue pending DMA requests */
+	dma_async_issue_pending(stm32_port->rx_ch);
+
+	/*
+	 * DMA request line not re-enabled at resume when port is throttled.
+	 * It will be re-enabled by unthrottle ops.
+	 */
+	if (!stm32_port->throttled)
+		stm32_usart_set_bits(port, ofs->cr3, USART_CR3_DMAR);
+
+	return 0;
+}
+
 static int stm32_usart_startup(struct uart_port *port)
 {
 	struct stm32_port *stm32_port = to_stm32_port(port);
 	const struct stm32_usart_offsets *ofs = &stm32_port->info->ofs;
 	const struct stm32_usart_config *cfg = &stm32_port->info->cfg;
 	const char *name = to_platform_device(port->dev)->name;
-	struct dma_async_tx_descriptor *desc;
 	u32 val;
 	int ret;
 
@@ -803,49 +844,18 @@ static int stm32_usart_startup(struct uart_port *port)
 		writel_relaxed(USART_RQR_RXFRQ, port->membase + ofs->rqr);
 
 	if (stm32_port->rx_ch) {
-		stm32_port->last_res = RX_BUF_L;
-		/* Prepare a DMA cyclic transaction */
-		desc = dmaengine_prep_dma_cyclic(stm32_port->rx_ch,
-						 stm32_port->rx_dma_buf,
-						 RX_BUF_L, RX_BUF_P,
-						 DMA_DEV_TO_MEM,
-						 DMA_PREP_INTERRUPT);
-		if (!desc) {
-			dev_err(port->dev, "rx dma prep cyclic failed\n");
-			ret = -ENODEV;
-			goto err;
-		}
-
-		desc->callback = stm32_usart_rx_dma_complete;
-		desc->callback_param = port;
-
-		/* Push current DMA transaction in the pending queue */
-		ret = dma_submit_error(dmaengine_submit(desc));
+		ret = stm32_usart_start_rx_dma_cyclic(port);
 		if (ret) {
-			dmaengine_terminate_sync(stm32_port->rx_ch);
-			goto err;
+			free_irq(port->irq, port);
+			return ret;
 		}
-
-		/* Issue pending DMA requests */
-		dma_async_issue_pending(stm32_port->rx_ch);
 	}
-	/*
-	 * DMA request line not re-enabled at resume when port is throttled.
-	 * It will be re-enabled by unthrottle ops.
-	 */
-	if (!stm32_port->throttled)
-		stm32_usart_set_bits(port, ofs->cr3, USART_CR3_DMAR);
 
 	/* RX enabling */
 	val = stm32_port->cr1_irq | USART_CR1_RE | BIT(cfg->uart_enable_bit);
 	stm32_usart_set_bits(port, ofs->cr1, val);
 
 	return 0;
-
-err:
-	free_irq(port->irq, port);
-
-	return ret;
 }
 
 static void stm32_usart_shutdown(struct uart_port *port)
@@ -1661,14 +1671,16 @@ static struct uart_driver stm32_usart_driver = {
 	.cons		= STM32_SERIAL_CONSOLE,
 };
 
-static void __maybe_unused stm32_usart_serial_en_wakeup(struct uart_port *port,
-							bool enable)
+static int __maybe_unused stm32_usart_serial_en_wakeup(struct uart_port *port,
+						       bool enable)
 {
 	struct stm32_port *stm32_port = to_stm32_port(port);
 	const struct stm32_usart_offsets *ofs = &stm32_port->info->ofs;
+	struct tty_port *tport = &port->state->port;
+	int ret;
 
-	if (!stm32_port->wakeup_src)
-		return;
+	if (!stm32_port->wakeup_src || !tty_port_initialized(tport))
+		return 0;
 
 	/*
 	 * Enable low-power wake-up and wake-up irq if argument is set to
@@ -1677,20 +1689,45 @@ static void __maybe_unused stm32_usart_serial_en_wakeup(struct uart_port *port,
 	if (enable) {
 		stm32_usart_set_bits(port, ofs->cr1, USART_CR1_UESM);
 		stm32_usart_set_bits(port, ofs->cr3, USART_CR3_WUFIE);
+
+		/*
+		 * When DMA is used for reception, it must be disabled before
+		 * entering low-power mode and re-enabled when exiting from
+		 * low-power mode.
+		 */
+		if (stm32_port->rx_ch) {
+			stm32_usart_clr_bits(port, ofs->cr3, USART_CR3_DMAR);
+			dmaengine_terminate_sync(stm32_port->rx_ch);
+		}
+
+		/* Poll data from RX FIFO if any */
+		stm32_usart_receive_chars(port, false);
 	} else {
+		if (stm32_port->rx_ch) {
+			ret = stm32_usart_start_rx_dma_cyclic(port);
+			if (ret)
+				return ret;
+		}
+
 		stm32_usart_clr_bits(port, ofs->cr1, USART_CR1_UESM);
 		stm32_usart_clr_bits(port, ofs->cr3, USART_CR3_WUFIE);
 	}
+
+	return 0;
 }
 
 static int __maybe_unused stm32_usart_serial_suspend(struct device *dev)
 {
 	struct uart_port *port = dev_get_drvdata(dev);
+	int ret;
 
 	uart_suspend_port(&stm32_usart_driver, port);
 
-	if (device_may_wakeup(dev) || device_wakeup_path(dev))
-		stm32_usart_serial_en_wakeup(port, true);
+	if (device_may_wakeup(dev) || device_wakeup_path(dev)) {
+		ret = stm32_usart_serial_en_wakeup(port, true);
+		if (ret)
+			return ret;
+	}
 
 	/*
 	 * When "no_console_suspend" is enabled, keep the pinctrl default state
@@ -1711,11 +1748,15 @@ static int __maybe_unused stm32_usart_serial_suspend(struct device *dev)
 static int __maybe_unused stm32_usart_serial_resume(struct device *dev)
 {
 	struct uart_port *port = dev_get_drvdata(dev);
+	int ret;
 
 	pinctrl_pm_select_default_state(dev);
 
-	if (device_may_wakeup(dev) || device_wakeup_path(dev))
-		stm32_usart_serial_en_wakeup(port, false);
+	if (device_may_wakeup(dev) || device_wakeup_path(dev)) {
+		ret = stm32_usart_serial_en_wakeup(port, false);
+		if (ret)
+			return ret;
+	}
 
 	return uart_resume_port(&stm32_usart_driver, port);
 }
-- 
2.17.1


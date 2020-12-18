Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 387E4C3526C
	for <linux-serial@archiver.kernel.org>; Fri, 18 Dec 2020 19:02:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F386E23B86
	for <linux-serial@archiver.kernel.org>; Fri, 18 Dec 2020 19:02:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726487AbgLRTBu (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 18 Dec 2020 14:01:50 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:3070 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726375AbgLRTB2 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 18 Dec 2020 14:01:28 -0500
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0BIIviuG021973;
        Fri, 18 Dec 2020 20:00:30 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=selector1;
 bh=CHpNSWEz7IxlEunBAvqrckY+hacS/RfitpwbipXC5us=;
 b=Qz5ePYox8Qh4MX2xgPGNjEgzM1c0mBn3+zgg7y4WQ3sd9qr+wIESfoReJbHKRIz9G0Zj
 z/8kHpkcoci5xX9mCWOyBhEg5G2QP2qwhMzecfSHJUm07EzJ883+uqHZl6ipIdaRg80I
 gBIkC7ZktYvArViZIcu1tP9tyRbE3CYSnb5TTCh8AGV2O6javJ9S69jkF3j7A1pRx7Wc
 Zz5aam9DiYWFXXRO+1y4Z1gC/i0uh5cR7Di9khEwQVIKhtGQ8wiohxi3adbiXFfygryF
 QQ7fFSwtpw7GCi8tlUwPj3jP6uXKqQCiLHhxcTNzN5+OMhsL1wbajxv4D78aLQTrWmu0 pg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 35cq03gdya-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Dec 2020 20:00:30 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 46312100034;
        Fri, 18 Dec 2020 20:00:29 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 38E0D225E48;
        Fri, 18 Dec 2020 20:00:29 +0100 (CET)
Received: from localhost (10.75.127.51) by SFHDAG2NODE3.st.com (10.75.127.6)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 18 Dec 2020 20:00:28
 +0100
From:   Erwan Le Ray <erwan.leray@foss.st.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, Rob Herring <robh+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
CC:     <linux-serial@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Erwan Le Ray <erwan.leray@foss.st.com>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        Valentin Caron <valentin.caron@foss.st.com>
Subject: [PATCH 2/8] serial: stm32: fix code cleaning warnings and checks
Date:   Fri, 18 Dec 2020 20:00:13 +0100
Message-ID: <20201218190020.1572-3-erwan.leray@foss.st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201218190020.1572-1-erwan.leray@foss.st.com>
References: <20201218190020.1572-1-erwan.leray@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.51]
X-ClientProxiedBy: SFHDAG3NODE2.st.com (10.75.127.8) To SFHDAG2NODE3.st.com
 (10.75.127.6)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-18_12:2020-12-18,2020-12-18 signatures=0
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Fixes checkpatch --strict warnings and checks:
- checkpatch --strict "Unnecessary parentheses"
- checkpatch --strict "Blank lines aren't necessary before a close brace
- checkpatch --strict "Alignment should match open parenthesis"
- checkpatch --strict "Please don't use multiple blank lines"
- checkpatch --strict "Comparison to NULL could be written ..."
- visual check code ordering warning

Signed-off-by: Erwan Le Ray <erwan.leray@foss.st.com>

diff --git a/drivers/tty/serial/stm32-usart.c b/drivers/tty/serial/stm32-usart.c
index 6248304a001f..a0ef86d71317 100644
--- a/drivers/tty/serial/stm32-usart.c
+++ b/drivers/tty/serial/stm32-usart.c
@@ -176,8 +176,7 @@ static int stm32_pending_rx(struct uart_port *port, u32 *sr, int *last_res,
 		status = dmaengine_tx_status(stm32_port->rx_ch,
 					     stm32_port->rx_ch->cookie,
 					     &state);
-		if ((status == DMA_IN_PROGRESS) &&
-		    (*last_res != state.residue))
+		if (status == DMA_IN_PROGRESS && (*last_res != state.residue))
 			return 1;
 		else
 			return 0;
@@ -464,7 +463,7 @@ static irqreturn_t stm32_interrupt(int irq, void *ptr)
 		writel_relaxed(USART_ICR_RTOCF,
 			       port->membase + ofs->icr);
 
-	if ((sr & USART_SR_WUF) && (ofs->icr != UNDEF_REG))
+	if ((sr & USART_SR_WUF) && ofs->icr != UNDEF_REG)
 		writel_relaxed(USART_ICR_WUCF,
 			       port->membase + ofs->icr);
 
@@ -620,7 +619,6 @@ static void stm32_stop_rx(struct uart_port *port)
 	stm32_clr_bits(port, ofs->cr1, stm32_port->cr1_irq);
 	if (stm32_port->cr3_irq)
 		stm32_clr_bits(port, ofs->cr3, stm32_port->cr3_irq);
-
 }
 
 /* Handle breaks - ignored by us */
@@ -724,7 +722,7 @@ static unsigned int stm32_get_databits(struct ktermios *termios)
 }
 
 static void stm32_set_termios(struct uart_port *port, struct ktermios *termios,
-			    struct ktermios *old)
+			      struct ktermios *old)
 {
 	struct stm32_port *stm32_port = to_stm32_port(port);
 	struct stm32_usart_offsets *ofs = &stm32_port->info->ofs;
@@ -923,7 +921,7 @@ stm32_verify_port(struct uart_port *port, struct serial_struct *ser)
 }
 
 static void stm32_pm(struct uart_port *port, unsigned int state,
-		unsigned int oldstate)
+		     unsigned int oldstate)
 {
 	struct stm32_port *stm32port = container_of(port,
 			struct stm32_port, port);
@@ -973,18 +971,17 @@ static int stm32_init_port(struct stm32_port *stm32port,
 	struct resource *res;
 	int ret;
 
+	ret = platform_get_irq(pdev, 0);
+	if (ret <= 0)
+		return ret ? : -ENODEV;
+
 	port->iotype	= UPIO_MEM;
 	port->flags	= UPF_BOOT_AUTOCONF;
 	port->ops	= &stm32_uart_ops;
 	port->dev	= &pdev->dev;
 	port->fifosize	= stm32port->info->cfg.fifosize;
 	port->has_sysrq = IS_ENABLED(CONFIG_SERIAL_STM32_CONSOLE);
-
-	ret = platform_get_irq(pdev, 0);
-	if (ret <= 0)
-		return ret ? : -ENODEV;
 	port->irq = ret;
-
 	port->rs485_config = stm32_config_rs485;
 
 	ret = stm32_init_rs485(port, pdev);
@@ -1101,8 +1098,8 @@ static int stm32_of_dma_rx_probe(struct stm32_port *stm32port,
 		return -ENODEV;
 	}
 	stm32port->rx_buf = dma_alloc_coherent(&pdev->dev, RX_BUF_L,
-						 &stm32port->rx_dma_buf,
-						 GFP_KERNEL);
+					       &stm32port->rx_dma_buf,
+					       GFP_KERNEL);
 	if (!stm32port->rx_buf) {
 		ret = -ENOMEM;
 		goto alloc_err;
@@ -1177,8 +1174,8 @@ static int stm32_of_dma_tx_probe(struct stm32_port *stm32port,
 		return -ENODEV;
 	}
 	stm32port->tx_buf = dma_alloc_coherent(&pdev->dev, TX_BUF_L,
-						 &stm32port->tx_dma_buf,
-						 GFP_KERNEL);
+					       &stm32port->tx_dma_buf,
+					       GFP_KERNEL);
 	if (!stm32port->tx_buf) {
 		ret = -ENOMEM;
 		goto alloc_err;
@@ -1322,7 +1319,6 @@ static int stm32_serial_remove(struct platform_device *pdev)
 	return err;
 }
 
-
 #ifdef CONFIG_SERIAL_STM32_CONSOLE
 static void stm32_console_putchar(struct uart_port *port, int ch)
 {
@@ -1335,7 +1331,8 @@ static void stm32_console_putchar(struct uart_port *port, int ch)
 	writel_relaxed(ch, port->membase + ofs->tdr);
 }
 
-static void stm32_console_write(struct console *co, const char *s, unsigned cnt)
+static void stm32_console_write(struct console *co, const char *s,
+				unsigned int cnt)
 {
 	struct uart_port *port = &stm32_ports[co->index].port;
 	struct stm32_port *stm32_port = to_stm32_port(port);
@@ -1388,7 +1385,7 @@ static int stm32_console_setup(struct console *co, char *options)
 	 * this to be called during the uart port registration when the
 	 * driver gets probed and the port should be mapped at that point.
 	 */
-	if (stm32port->port.mapbase == 0 || stm32port->port.membase == NULL)
+	if (stm32port->port.mapbase == 0 || !stm32port->port.membase)
 		return -ENXIO;
 
 	if (options)
-- 
2.17.1


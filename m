Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76A2DC433ED
	for <linux-serial@archiver.kernel.org>; Tue,  6 Apr 2021 07:22:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3CF7F6101D
	for <linux-serial@archiver.kernel.org>; Tue,  6 Apr 2021 07:22:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239029AbhDFHW2 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 6 Apr 2021 03:22:28 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:24380 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S237823AbhDFHW1 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 6 Apr 2021 03:22:27 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1367H9g8013057;
        Tue, 6 Apr 2021 09:21:28 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=selector1;
 bh=F5cY1wCX5QADaPc2+6E44j3IcFjspCBtThZI4DS/1F4=;
 b=CnNItbGFYxPMh33jxdzFSVtznxJm4F3ppsekjHAbIvnuUBgrtyuOsuVcpA4GnvmZYTx1
 eQ383BHzZMGRaFArKxomkbmPTlXA9BGFqwCR3I582yZejloExFTBcQgD1Amyld077h5S
 cv7CrXDnLxDtjoYrOs7JrrrwqGBswk/RprCZufHlICeuAif7XVb/OrpsTCFwVza1zOWj
 URvl8G8VxbhzlKq7VhAnXXBcZ1Ql1PYL4rzrz5WcxSrADytd8icxsO1p4uh7uv/EKp/y
 H0CVxb3Rj7LcQIMY9/t7VMZGwuvVUAig9l/kwl7MvkYffWQBAoZzefnUfnIP6NkNm8pS RA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 37ra7gacan-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 06 Apr 2021 09:21:28 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 18C12100039;
        Tue,  6 Apr 2021 09:21:28 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 0A02E21E666;
        Tue,  6 Apr 2021 09:21:28 +0200 (CEST)
Received: from localhost (10.75.127.48) by SFHDAG2NODE3.st.com (10.75.127.6)
 with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 6 Apr 2021 09:21:27
 +0200
From:   Erwan Le Ray <erwan.leray@foss.st.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, Rob Herring <robh+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
CC:     <linux-serial@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        "Erwan Le Ray" <erwan.leray@foss.st.com>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        Valentin Caron <valentin.caron@foss.st.com>,
        Erwan Le Ray <erwan.leray@st.com>
Subject: [PATCH 2/2] serial: stm32: add fifo threshold configuration
Date:   Tue, 6 Apr 2021 09:21:22 +0200
Message-ID: <20210406072122.27384-3-erwan.leray@foss.st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210406072122.27384-1-erwan.leray@foss.st.com>
References: <20210406072122.27384-1-erwan.leray@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.48]
X-ClientProxiedBy: SFHDAG3NODE2.st.com (10.75.127.8) To SFHDAG2NODE3.st.com
 (10.75.127.6)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-04-06_01:2021-04-01,2021-04-06 signatures=0
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Fabrice Gasnier <fabrice.gasnier@foss.st.com>

Add the support for two optional DT properties, to configure RX and TX
FIFO thresholds::
- st,rx-fifo-threshold-bytes
- st,tx-fifo-threshold-bytes
This replaces hard-coded 8 bytes threshold. Keep 8 as the default value if
not specified, for backward compatibility.

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Signed-off-by: Erwan Le Ray <erwan.leray@st.com>

diff --git a/drivers/tty/serial/stm32-usart.c b/drivers/tty/serial/stm32-usart.c
index 4d277804c63e..1be5b69ee567 100644
--- a/drivers/tty/serial/stm32-usart.c
+++ b/drivers/tty/serial/stm32-usart.c
@@ -312,7 +312,7 @@ static void stm32_usart_tx_interrupt_enable(struct uart_port *port)
 	 * Enables TX FIFO threashold irq when FIFO is enabled,
 	 * or TX empty irq when FIFO is disabled
 	 */
-	if (stm32_port->fifoen)
+	if (stm32_port->fifoen && stm32_port->txftcfg >= 0)
 		stm32_usart_set_bits(port, ofs->cr3, USART_CR3_TXFTIE);
 	else
 		stm32_usart_set_bits(port, ofs->cr1, USART_CR1_TXEIE);
@@ -323,7 +323,7 @@ static void stm32_usart_tx_interrupt_disable(struct uart_port *port)
 	struct stm32_port *stm32_port = to_stm32_port(port);
 	const struct stm32_usart_offsets *ofs = &stm32_port->info->ofs;
 
-	if (stm32_port->fifoen)
+	if (stm32_port->fifoen && stm32_port->txftcfg >= 0)
 		stm32_usart_clr_bits(port, ofs->cr3, USART_CR3_TXFTIE);
 	else
 		stm32_usart_clr_bits(port, ofs->cr1, USART_CR1_TXEIE);
@@ -801,9 +801,10 @@ static void stm32_usart_set_termios(struct uart_port *port,
 	cr3 = readl_relaxed(port->membase + ofs->cr3);
 	cr3 &= USART_CR3_TXFTIE | USART_CR3_RXFTIE;
 	if (stm32_port->fifoen) {
-		cr3 &= ~(USART_CR3_TXFTCFG_MASK | USART_CR3_RXFTCFG_MASK);
-		cr3 |= USART_CR3_TXFTCFG_HALF << USART_CR3_TXFTCFG_SHIFT;
-		cr3 |= USART_CR3_RXFTCFG_HALF << USART_CR3_RXFTCFG_SHIFT;
+		if (stm32_port->txftcfg >= 0)
+			cr3 |= stm32_port->txftcfg << USART_CR3_TXFTCFG_SHIFT;
+		if (stm32_port->rxftcfg >= 0)
+			cr3 |= stm32_port->rxftcfg << USART_CR3_RXFTCFG_SHIFT;
 	}
 
 	if (cflag & CSTOPB)
@@ -833,7 +834,8 @@ static void stm32_usart_set_termios(struct uart_port *port,
 			, bits);
 
 	if (ofs->rtor != UNDEF_REG && (stm32_port->rx_ch ||
-				       stm32_port->fifoen)) {
+				       (stm32_port->fifoen &&
+					stm32_port->rxftcfg >= 0))) {
 		if (cflag & CSTOPB)
 			bits = bits + 3; /* 1 start bit + 2 stop bits */
 		else
@@ -1021,6 +1023,39 @@ static const struct uart_ops stm32_uart_ops = {
 	.verify_port	= stm32_usart_verify_port,
 };
 
+/*
+ * STM32H7 RX & TX FIFO threshold configuration (CR3 RXFTCFG / TXFTCFG)
+ * Note: 1 isn't a valid value in RXFTCFG / TXFTCFG. In this case,
+ * RXNEIE / TXEIE can be used instead of threshold irqs: RXFTIE / TXFTIE.
+ * So, RXFTCFG / TXFTCFG bitfields values are encoded as array index + 1.
+ */
+static const u32 stm32h7_usart_fifo_thresh_cfg[] = { 1, 2, 4, 8, 12, 14, 16 };
+
+static void stm32_usart_get_ftcfg(struct platform_device *pdev, const char *p,
+				  int *ftcfg)
+{
+	u32 bytes, i;
+
+	/* DT option to get RX & TX FIFO threshold (default to 8 bytes) */
+	if (of_property_read_u32(pdev->dev.of_node, p, &bytes))
+		bytes = 8;
+
+	for (i = 0; i < ARRAY_SIZE(stm32h7_usart_fifo_thresh_cfg); i++)
+		if (stm32h7_usart_fifo_thresh_cfg[i] >= bytes)
+			break;
+	if (i >= ARRAY_SIZE(stm32h7_usart_fifo_thresh_cfg))
+		i = ARRAY_SIZE(stm32h7_usart_fifo_thresh_cfg) - 1;
+
+	dev_dbg(&pdev->dev, "%s set to %d bytes\n", p,
+		stm32h7_usart_fifo_thresh_cfg[i]);
+
+	/* Provide FIFO threshold ftcfg (1 is invalid: threshold irq unused) */
+	if (i)
+		*ftcfg = i - 1;
+	else
+		*ftcfg = -EINVAL;
+}
+
 static void stm32_usart_deinit_port(struct stm32_port *stm32port)
 {
 	clk_disable_unprepare(stm32port->clk);
@@ -1057,6 +1092,12 @@ static int stm32_usart_init_port(struct stm32_port *stm32port,
 		of_property_read_bool(pdev->dev.of_node, "rx-tx-swap");
 
 	stm32port->fifoen = stm32port->info->cfg.has_fifo;
+	if (stm32port->fifoen) {
+		stm32_usart_get_ftcfg(pdev, "st,rx-fifo-threshold-bytes",
+				      &stm32port->rxftcfg);
+		stm32_usart_get_ftcfg(pdev, "st,tx-fifo-threshold-bytes",
+				      &stm32port->txftcfg);
+	}
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	port->membase = devm_ioremap_resource(&pdev->dev, res);
diff --git a/drivers/tty/serial/stm32-usart.h b/drivers/tty/serial/stm32-usart.h
index 77d1ac082e89..07ac291328cd 100644
--- a/drivers/tty/serial/stm32-usart.h
+++ b/drivers/tty/serial/stm32-usart.h
@@ -216,12 +216,6 @@ struct stm32_usart_info stm32h7_info = {
 #define USART_CR3_TXFTCFG_MASK	GENMASK(31, 29)	/* H7 */
 #define USART_CR3_TXFTCFG_SHIFT	29		/* H7 */
 
-/* TX FIFO threashold set to half of its depth */
-#define USART_CR3_TXFTCFG_HALF	0x2
-
-/* RX FIFO threashold set to half of its depth */
-#define USART_CR3_RXFTCFG_HALF	0x2
-
 /* USART_GTPR */
 #define USART_GTPR_PSC_MASK	GENMASK(7, 0)
 #define USART_GTPR_GT_MASK	GENMASK(15, 8)
@@ -273,6 +267,8 @@ struct stm32_port {
 	bool hw_flow_control;
 	bool swap;		 /* swap RX & TX pins */
 	bool fifoen;
+	int rxftcfg;		/* RX FIFO threshold CFG      */
+	int txftcfg;		/* TX FIFO threshold CFG      */
 	bool wakeup_src;
 	int rdr_mask;		/* receive data register mask */
 	struct mctrl_gpios *gpios; /* modem control gpios */
-- 
2.17.1


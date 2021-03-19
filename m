Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69450C433DB
	for <linux-serial@archiver.kernel.org>; Fri, 19 Mar 2021 18:45:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2858661976
	for <linux-serial@archiver.kernel.org>; Fri, 19 Mar 2021 18:45:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230186AbhCSSo5 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 19 Mar 2021 14:44:57 -0400
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:9756 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230259AbhCSSoW (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 19 Mar 2021 14:44:22 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12JIgpn2010351;
        Fri, 19 Mar 2021 19:43:27 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=selector1;
 bh=jmWA8otALcGjJwMAr/3jxxE9Yj0qkPNm345kDhBJnTk=;
 b=43PULLinB4ULKJKCFzHH3Iedx+s4ImKzSIkFpJKEcsujAogFYlmg2TK9jV68koUQ2Pbl
 SLHpXtwx9ZufYHvfo1FwOtnCQIOKdGot6oOXo++CT/l5+0gIDbmmMunh06C97qJEjYM8
 8CbLTIS2xnH7mga5Q3TEVbulVTzZRS6x1biyvZa2IH2JFjF5ItcRLB6bB4/sR+clX7bV
 g7TuggNKmyViwFe0YQgOcfbZ8W+ZJ/nsvZENd6K7Zj0JH3PNgTeA3uisiVX4gEBVVDCZ
 KPJ7KbLj00wdgyPVuBGb2nXBg1jM5xW4b1+URpMjOYpPUHbfXtgkmS+FjxGI9JBr13e4 yA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 378pr6d1g5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 Mar 2021 19:43:27 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id CA1E110002A;
        Fri, 19 Mar 2021 19:43:26 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id B620E2721FC;
        Fri, 19 Mar 2021 19:43:26 +0100 (CET)
Received: from localhost (10.75.127.49) by SFHDAG2NODE3.st.com (10.75.127.6)
 with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 19 Mar 2021 19:43:26
 +0100
From:   Erwan Le Ray <erwan.leray@foss.st.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
CC:     <linux-serial@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Erwan Le Ray <erwan.leray@foss.st.com>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        Valentin Caron <valentin.caron@foss.st.com>,
        Patrice Chotard <patrice.chotard@foss.st.com>
Subject: [PATCH 4/5] serial: stm32: update wakeup IRQ management
Date:   Fri, 19 Mar 2021 19:42:52 +0100
Message-ID: <20210319184253.5841-5-erwan.leray@foss.st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210319184253.5841-1-erwan.leray@foss.st.com>
References: <20210319184253.5841-1-erwan.leray@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.49]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SFHDAG2NODE3.st.com
 (10.75.127.6)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-19_10:2021-03-19,2021-03-19 signatures=0
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Alexandre Torgue <alexandre.torgue@foss.st.com>

The wakeup specific IRQ management is no more needed to wake up the stm32
plaform. A relationship has been established between the EXTI and
the EVENT IRQ, just need to declare the EXTI interrupt instead of the
UART event IRQ.

Signed-off-by: Alexandre Torgue <alexandre.torgue@foss.st.com>
Signed-off-by: Erwan Le Ray <erwan.leray@foss.st.com>

diff --git a/drivers/tty/serial/stm32-usart.c b/drivers/tty/serial/stm32-usart.c
index cc054f07bd83..cba4f4ddf164 100644
--- a/drivers/tty/serial/stm32-usart.c
+++ b/drivers/tty/serial/stm32-usart.c
@@ -924,7 +924,7 @@ static void stm32_usart_set_termios(struct uart_port *port,
 	}
 
 	/* Configure wake up from low power on start bit detection */
-	if (stm32_port->wakeirq > 0) {
+	if (stm32_port->wakeup_src) {
 		cr3 &= ~USART_CR3_WUS_MASK;
 		cr3 |= USART_CR3_WUS_START_BIT;
 	}
@@ -1044,11 +1044,8 @@ static int stm32_usart_init_port(struct stm32_port *stm32port,
 	if (ret)
 		return ret;
 
-	if (stm32port->info->cfg.has_wakeup) {
-		stm32port->wakeirq = platform_get_irq_optional(pdev, 1);
-		if (stm32port->wakeirq <= 0 && stm32port->wakeirq != -ENXIO)
-			return stm32port->wakeirq ? : -ENODEV;
-	}
+	stm32port->wakeup_src = stm32port->info->cfg.has_wakeup &&
+		of_property_read_bool(pdev->dev.of_node, "wakeup-source");
 
 	stm32port->fifoen = stm32port->info->cfg.has_fifo;
 
@@ -1283,17 +1280,11 @@ static int stm32_usart_serial_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	if (stm32port->wakeirq > 0) {
-		ret = device_init_wakeup(&pdev->dev, true);
-		if (ret)
-			goto err_uninit;
-
-		ret = dev_pm_set_dedicated_wake_irq(&pdev->dev,
-						    stm32port->wakeirq);
+	if (stm32port->wakeup_src) {
+		device_set_wakeup_capable(&pdev->dev, true);
+		ret = dev_pm_set_wake_irq(&pdev->dev, stm32port->port.irq);
 		if (ret)
 			goto err_nowup;
-
-		device_set_wakeup_enable(&pdev->dev, false);
 	}
 
 	ret = stm32_usart_of_dma_rx_probe(stm32port, pdev);
@@ -1343,14 +1334,13 @@ static int stm32_usart_serial_probe(struct platform_device *pdev)
 				  TX_BUF_L, stm32port->tx_buf,
 				  stm32port->tx_dma_buf);
 
-	if (stm32port->wakeirq > 0)
+	if (stm32port->wakeup_src)
 		dev_pm_clear_wake_irq(&pdev->dev);
 
 err_nowup:
-	if (stm32port->wakeirq > 0)
-		device_init_wakeup(&pdev->dev, false);
+	if (stm32port->wakeup_src)
+		device_set_wakeup_capable(&pdev->dev, false);
 
-err_uninit:
 	stm32_usart_deinit_port(stm32port);
 
 	return ret;
@@ -1396,7 +1386,7 @@ static int stm32_usart_serial_remove(struct platform_device *pdev)
 				  TX_BUF_L, stm32_port->tx_buf,
 				  stm32_port->tx_dma_buf);
 
-	if (stm32_port->wakeirq > 0) {
+	if (stm32_port->wakeup_src) {
 		dev_pm_clear_wake_irq(&pdev->dev);
 		device_init_wakeup(&pdev->dev, false);
 	}
@@ -1512,7 +1502,7 @@ static void __maybe_unused stm32_usart_serial_en_wakeup(struct uart_port *port,
 	struct stm32_port *stm32_port = to_stm32_port(port);
 	const struct stm32_usart_offsets *ofs = &stm32_port->info->ofs;
 
-	if (stm32_port->wakeirq <= 0)
+	if (!stm32_port->wakeup_src)
 		return;
 
 	/*
diff --git a/drivers/tty/serial/stm32-usart.h b/drivers/tty/serial/stm32-usart.h
index 94b568aa46bb..a86773f1a4c4 100644
--- a/drivers/tty/serial/stm32-usart.h
+++ b/drivers/tty/serial/stm32-usart.h
@@ -269,7 +269,7 @@ struct stm32_port {
 	bool tx_dma_busy;	 /* dma tx busy               */
 	bool hw_flow_control;
 	bool fifoen;
-	int wakeirq;
+	bool wakeup_src;
 	int rdr_mask;		/* receive data register mask */
 	struct mctrl_gpios *gpios; /* modem control gpios */
 };
-- 
2.17.1


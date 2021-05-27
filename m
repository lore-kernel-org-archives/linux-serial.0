Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 439E2C47089
	for <linux-serial@archiver.kernel.org>; Thu, 27 May 2021 09:16:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 223A3613D8
	for <linux-serial@archiver.kernel.org>; Thu, 27 May 2021 09:16:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235742AbhE0JRj (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 27 May 2021 05:17:39 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:21434 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S235650AbhE0JRi (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 27 May 2021 05:17:38 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14R975JJ017729;
        Thu, 27 May 2021 11:15:51 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=selector1;
 bh=RLsBjaKEeMaGJ14BOi7Wc4C6ZBqyISDjWi/Vi9Zit8Y=;
 b=3JYA5Nli9mL0mjLJMz0qs6+VnApIKu60yMX1tw4nF9y48VIpD4Z+jRiUtnr9K4f0i8qg
 +O0Ter91zxG5S6Q12DpJPSXwFkihTyUItuCwEMlwf1C3yKig1drsAOXIJ/ZIZEoYQpO/
 CviYJhNPaF8FgQTSDiUURtuR+I8wwyUansoC6bIOF4aekbWJRL3pEOUob8eupo2jst3h
 11Yw7c3aKToqRvQ4spuSRRwYelY+SKSLdLRCO4iNsF7B5DGRcaDh/uXoHqNQa05JUP2f
 Cm+Z9Ej+FA7z4W67UIif5q0Rr+lRcxmXSK9y1PRiBjQJoOcXxSaPryjlVfBobIuzhLuv fw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 38t7k38enk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 May 2021 11:15:51 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 951CB10002A;
        Thu, 27 May 2021 11:15:50 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 85A4A2171D7;
        Thu, 27 May 2021 11:15:50 +0200 (CEST)
Received: from localhost (10.75.127.45) by SFHDAG2NODE3.st.com (10.75.127.6)
 with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 27 May 2021 11:15:49
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
        Amelie Delaunay <amelie.delaunay@foss.st.com>,
        Etienne Carriere <etienne.carriere@foss.st.com>
Subject: [PATCH 2/2] serial: stm32: defer probe for dma devices
Date:   Thu, 27 May 2021 11:15:37 +0200
Message-ID: <20210527091537.8997-3-erwan.leray@foss.st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210527091537.8997-1-erwan.leray@foss.st.com>
References: <20210527091537.8997-1-erwan.leray@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG2NODE2.st.com (10.75.127.5) To SFHDAG2NODE3.st.com
 (10.75.127.6)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-27_04:2021-05-26,2021-05-27 signatures=0
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Defer device probe operation when a DMA channel request probe deferral.

With this change both DMA channels are acquired before DMA channels are
configured. Once no probe deferral is expected, DMAs are
configured and any failure in their configuration will make the driver
to fallback to interrupt mode as prior this change.

Signed-off-by: Erwan Le Ray <erwan.leray@foss.st.com>
Signed-off-by: Etienne Carriere <etienne.carriere@foss.st.com>

diff --git a/drivers/tty/serial/stm32-usart.c b/drivers/tty/serial/stm32-usart.c
index 2ac3b30477a7..7fa54ec11a84 100644
--- a/drivers/tty/serial/stm32-usart.c
+++ b/drivers/tty/serial/stm32-usart.c
@@ -1184,6 +1184,14 @@ static const struct of_device_id stm32_match[] = {
 MODULE_DEVICE_TABLE(of, stm32_match);
 #endif
 
+static void stm32_usart_of_dma_rx_remove(struct stm32_port *stm32port,
+					 struct platform_device *pdev)
+{
+	if (stm32port->rx_buf)
+		dma_free_coherent(&pdev->dev, RX_BUF_L, stm32port->rx_buf,
+				  stm32port->rx_dma_buf);
+}
+
 static int stm32_usart_of_dma_rx_probe(struct stm32_port *stm32port,
 				       struct platform_device *pdev)
 {
@@ -1201,19 +1209,11 @@ static int stm32_usart_of_dma_rx_probe(struct stm32_port *stm32port,
 	if (uart_console(port))
 		return -ENODEV;
 
-	/* Request DMA RX channel */
-	stm32port->rx_ch = dma_request_slave_channel(dev, "rx");
-	if (!stm32port->rx_ch) {
-		dev_info(dev, "rx dma alloc failed\n");
-		return -ENODEV;
-	}
 	stm32port->rx_buf = dma_alloc_coherent(&pdev->dev, RX_BUF_L,
 					       &stm32port->rx_dma_buf,
 					       GFP_KERNEL);
-	if (!stm32port->rx_buf) {
-		ret = -ENOMEM;
-		goto alloc_err;
-	}
+	if (!stm32port->rx_buf)
+		return -ENOMEM;
 
 	/* Configure DMA channel */
 	memset(&config, 0, sizeof(config));
@@ -1223,8 +1223,8 @@ static int stm32_usart_of_dma_rx_probe(struct stm32_port *stm32port,
 	ret = dmaengine_slave_config(stm32port->rx_ch, &config);
 	if (ret < 0) {
 		dev_err(dev, "rx dma channel config failed\n");
-		ret = -ENODEV;
-		goto config_err;
+		stm32_usart_of_dma_rx_remove(stm32port, pdev);
+		return ret;
 	}
 
 	/* Prepare a DMA cyclic transaction */
@@ -1234,8 +1234,8 @@ static int stm32_usart_of_dma_rx_probe(struct stm32_port *stm32port,
 					 DMA_PREP_INTERRUPT);
 	if (!desc) {
 		dev_err(dev, "rx dma prep cyclic failed\n");
-		ret = -ENODEV;
-		goto config_err;
+		stm32_usart_of_dma_rx_remove(stm32port, pdev);
+		return -ENODEV;
 	}
 
 	/* No callback as dma buffer is drained on usart interrupt */
@@ -1246,24 +1246,22 @@ static int stm32_usart_of_dma_rx_probe(struct stm32_port *stm32port,
 	ret = dma_submit_error(dmaengine_submit(desc));
 	if (ret) {
 		dmaengine_terminate_sync(stm32port->rx_ch);
-		goto config_err;
+		stm32_usart_of_dma_rx_remove(stm32port, pdev);
+		return ret;
 	}
 
 	/* Issue pending DMA requests */
 	dma_async_issue_pending(stm32port->rx_ch);
 
 	return 0;
+}
 
-config_err:
-	dma_free_coherent(&pdev->dev,
-			  RX_BUF_L, stm32port->rx_buf,
-			  stm32port->rx_dma_buf);
-
-alloc_err:
-	dma_release_channel(stm32port->rx_ch);
-	stm32port->rx_ch = NULL;
-
-	return ret;
+static void stm32_usart_of_dma_tx_remove(struct stm32_port *stm32port,
+					 struct platform_device *pdev)
+{
+	if (stm32port->tx_buf)
+		dma_free_coherent(&pdev->dev, TX_BUF_L, stm32port->tx_buf,
+				  stm32port->tx_dma_buf);
 }
 
 static int stm32_usart_of_dma_tx_probe(struct stm32_port *stm32port,
@@ -1277,19 +1275,11 @@ static int stm32_usart_of_dma_tx_probe(struct stm32_port *stm32port,
 
 	stm32port->tx_dma_busy = false;
 
-	/* Request DMA TX channel */
-	stm32port->tx_ch = dma_request_slave_channel(dev, "tx");
-	if (!stm32port->tx_ch) {
-		dev_info(dev, "tx dma alloc failed\n");
-		return -ENODEV;
-	}
 	stm32port->tx_buf = dma_alloc_coherent(&pdev->dev, TX_BUF_L,
 					       &stm32port->tx_dma_buf,
 					       GFP_KERNEL);
-	if (!stm32port->tx_buf) {
-		ret = -ENOMEM;
-		goto alloc_err;
-	}
+	if (!stm32port->tx_buf)
+		return -ENOMEM;
 
 	/* Configure DMA channel */
 	memset(&config, 0, sizeof(config));
@@ -1299,22 +1289,11 @@ static int stm32_usart_of_dma_tx_probe(struct stm32_port *stm32port,
 	ret = dmaengine_slave_config(stm32port->tx_ch, &config);
 	if (ret < 0) {
 		dev_err(dev, "tx dma channel config failed\n");
-		ret = -ENODEV;
-		goto config_err;
+		stm32_usart_of_dma_tx_remove(stm32port, pdev);
+		return ret;
 	}
 
 	return 0;
-
-config_err:
-	dma_free_coherent(&pdev->dev,
-			  TX_BUF_L, stm32port->tx_buf,
-			  stm32port->tx_dma_buf);
-
-alloc_err:
-	dma_release_channel(stm32port->tx_ch);
-	stm32port->tx_ch = NULL;
-
-	return ret;
 }
 
 static int stm32_usart_serial_probe(struct platform_device *pdev)
@@ -1338,16 +1317,43 @@ static int stm32_usart_serial_probe(struct platform_device *pdev)
 		device_set_wakeup_capable(&pdev->dev, true);
 		ret = dev_pm_set_wake_irq(&pdev->dev, stm32port->port.irq);
 		if (ret)
-			goto err_nowup;
+			goto err_deinit_port;
 	}
 
-	ret = stm32_usart_of_dma_rx_probe(stm32port, pdev);
-	if (ret)
-		dev_info(&pdev->dev, "interrupt mode used for rx (no dma)\n");
+	stm32port->rx_ch = dma_request_chan(&pdev->dev, "rx");
+	if (PTR_ERR(stm32port->rx_ch) == -EPROBE_DEFER) {
+		ret = -EPROBE_DEFER;
+		goto err_wakeirq;
+	}
+	/* Fall back in interrupt mode for any non-deferral error */
+	if (IS_ERR(stm32port->rx_ch))
+		stm32port->rx_ch = NULL;
+
+	stm32port->tx_ch = dma_request_chan(&pdev->dev, "tx");
+	if (PTR_ERR(stm32port->tx_ch) == -EPROBE_DEFER) {
+		ret = -EPROBE_DEFER;
+		goto err_dma_rx;
+	}
+	/* Fall back in interrupt mode for any non-deferral error */
+	if (IS_ERR(stm32port->tx_ch))
+		stm32port->tx_ch = NULL;
 
-	ret = stm32_usart_of_dma_tx_probe(stm32port, pdev);
-	if (ret)
-		dev_info(&pdev->dev, "interrupt mode used for tx (no dma)\n");
+	if (stm32port->rx_ch && stm32_usart_of_dma_rx_probe(stm32port, pdev)) {
+		/* Fall back in interrupt mode */
+		dma_release_channel(stm32port->rx_ch);
+		stm32port->rx_ch = NULL;
+	}
+
+	if (stm32port->tx_ch && stm32_usart_of_dma_tx_probe(stm32port, pdev)) {
+		/* Fall back in interrupt mode */
+		dma_release_channel(stm32port->tx_ch);
+		stm32port->tx_ch = NULL;
+	}
+
+	if (!stm32port->rx_ch)
+		dev_info(&pdev->dev, "interrupt mode for rx (no dma)\n");
+	if (!stm32port->tx_ch)
+		dev_info(&pdev->dev, "interrupt mode for tx (no dma)\n");
 
 	platform_set_drvdata(pdev, &stm32port->port);
 
@@ -1368,30 +1374,23 @@ static int stm32_usart_serial_probe(struct platform_device *pdev)
 	pm_runtime_set_suspended(&pdev->dev);
 	pm_runtime_put_noidle(&pdev->dev);
 
-	if (stm32port->rx_ch) {
-		dmaengine_terminate_async(stm32port->rx_ch);
-		dma_release_channel(stm32port->rx_ch);
-	}
-
-	if (stm32port->rx_dma_buf)
-		dma_free_coherent(&pdev->dev,
-				  RX_BUF_L, stm32port->rx_buf,
-				  stm32port->rx_dma_buf);
-
 	if (stm32port->tx_ch) {
-		dmaengine_terminate_async(stm32port->tx_ch);
+		stm32_usart_of_dma_tx_remove(stm32port, pdev);
 		dma_release_channel(stm32port->tx_ch);
 	}
 
-	if (stm32port->tx_dma_buf)
-		dma_free_coherent(&pdev->dev,
-				  TX_BUF_L, stm32port->tx_buf,
-				  stm32port->tx_dma_buf);
+	if (stm32port->rx_ch)
+		stm32_usart_of_dma_rx_remove(stm32port, pdev);
 
+err_dma_rx:
+	if (stm32port->rx_ch)
+		dma_release_channel(stm32port->rx_ch);
+
+err_wakeirq:
 	if (stm32port->wakeup_src)
 		dev_pm_clear_wake_irq(&pdev->dev);
 
-err_nowup:
+err_deinit_port:
 	if (stm32port->wakeup_src)
 		device_set_wakeup_capable(&pdev->dev, false);
 
@@ -1418,28 +1417,20 @@ static int stm32_usart_serial_remove(struct platform_device *pdev)
 
 	stm32_usart_clr_bits(port, ofs->cr3, USART_CR3_DMAR);
 
+	if (stm32_port->tx_ch) {
+		dmaengine_terminate_async(stm32_port->tx_ch);
+		stm32_usart_of_dma_tx_remove(stm32_port, pdev);
+		dma_release_channel(stm32_port->tx_ch);
+	}
+
 	if (stm32_port->rx_ch) {
 		dmaengine_terminate_async(stm32_port->rx_ch);
+		stm32_usart_of_dma_rx_remove(stm32_port, pdev);
 		dma_release_channel(stm32_port->rx_ch);
 	}
 
-	if (stm32_port->rx_dma_buf)
-		dma_free_coherent(&pdev->dev,
-				  RX_BUF_L, stm32_port->rx_buf,
-				  stm32_port->rx_dma_buf);
-
 	stm32_usart_clr_bits(port, ofs->cr3, USART_CR3_DMAT);
 
-	if (stm32_port->tx_ch) {
-		dmaengine_terminate_async(stm32_port->tx_ch);
-		dma_release_channel(stm32_port->tx_ch);
-	}
-
-	if (stm32_port->tx_dma_buf)
-		dma_free_coherent(&pdev->dev,
-				  TX_BUF_L, stm32_port->tx_buf,
-				  stm32_port->tx_dma_buf);
-
 	if (stm32_port->wakeup_src) {
 		dev_pm_clear_wake_irq(&pdev->dev);
 		device_init_wakeup(&pdev->dev, false);
-- 
2.17.1


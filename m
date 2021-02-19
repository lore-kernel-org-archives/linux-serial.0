Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE37EC433DB
	for <linux-serial@archiver.kernel.org>; Fri, 19 Feb 2021 17:49:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A807C64E86
	for <linux-serial@archiver.kernel.org>; Fri, 19 Feb 2021 17:49:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230148AbhBSRsy (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 19 Feb 2021 12:48:54 -0500
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:37744 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229890AbhBSRsh (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 19 Feb 2021 12:48:37 -0500
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11JHkOhr017974;
        Fri, 19 Feb 2021 18:47:42 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=selector1;
 bh=6Ef7W9TusIZJWlgnGpNCZ+7sxAn2pUFDzXEDOW2apeM=;
 b=LmOkixou+sxNoPl9S1VMbH8hd1+LfVBEj2JMR+YlYcyzri8PNal2AEFBvSDN1jODgskd
 J11QV9/1ohOrir+7ETlKviW056GOb/kM0HSzufD6bzlhoYaOonmLLnGufjpNCzKOUIER
 BclqsBCp4OpERL9/AnqONZs7eG6q6Uu1con5sHjruGTsaUE6cD/8LQJ9EbyuThrcxLkQ
 DBS42ou94poPULuxu+QFUjW6aYm3bOckQ3l4lFTmtX4xiUYOyxjwEiq0phhJR7AK0oTK
 5mk1w/RPGCVfXZaKY5Zn1OIi8woOse0No/HKakfw1kULyg0v374cuuJZA55HHi6olh3n xg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 36p707550k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 Feb 2021 18:47:42 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id A0C5C100034;
        Fri, 19 Feb 2021 18:47:41 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 9174525F3FC;
        Fri, 19 Feb 2021 18:47:41 +0100 (CET)
Received: from localhost (10.75.127.44) by SFHDAG2NODE3.st.com (10.75.127.6)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 19 Feb 2021 18:47:41
 +0100
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
        Valentin Caron <valentin.caron@foss.st.com>
Subject: [PATCH 01/13] serial: stm32: fix probe and remove order for dma
Date:   Fri, 19 Feb 2021 18:47:24 +0100
Message-ID: <20210219174736.1022-2-erwan.leray@foss.st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210219174736.1022-1-erwan.leray@foss.st.com>
References: <20210219174736.1022-1-erwan.leray@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG1NODE3.st.com (10.75.127.3) To SFHDAG2NODE3.st.com
 (10.75.127.6)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-19_08:2021-02-18,2021-02-19 signatures=0
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The probe and remove orders are wrong as the uart_port is registered
before saving device data in the probe, and unregistered after DMA
resource deallocation in the remove. uart_port registering should be
done at the end of probe and unregistering should be done at the begin of
remove to avoid resource allocation issues.

Fix probe and remove orders. This enforce resource allocation occur at
proper time.
Terminate both DMA rx and tx transfers before removing device.

Move pm_runtime after uart_remove_one_port() call in remove() to keep the
probe error path.

Fixes: 3489187204eb ("serial: stm32: adding dma support")
Signed-off-by: Erwan Le Ray <erwan.leray@foss.st.com>

diff --git a/drivers/tty/serial/stm32-usart.c b/drivers/tty/serial/stm32-usart.c
index dde6d526362d..c67029ebcac8 100644
--- a/drivers/tty/serial/stm32-usart.c
+++ b/drivers/tty/serial/stm32-usart.c
@@ -1255,10 +1255,6 @@ static int stm32_usart_serial_probe(struct platform_device *pdev)
 		device_set_wakeup_enable(&pdev->dev, false);
 	}
 
-	ret = uart_add_one_port(&stm32_usart_driver, &stm32port->port);
-	if (ret)
-		goto err_wirq;
-
 	ret = stm32_usart_of_dma_rx_probe(stm32port, pdev);
 	if (ret)
 		dev_info(&pdev->dev, "interrupt mode used for rx (no dma)\n");
@@ -1272,11 +1268,40 @@ static int stm32_usart_serial_probe(struct platform_device *pdev)
 	pm_runtime_get_noresume(&pdev->dev);
 	pm_runtime_set_active(&pdev->dev);
 	pm_runtime_enable(&pdev->dev);
+
+	ret = uart_add_one_port(&stm32_usart_driver, &stm32port->port);
+	if (ret)
+		goto err_port;
+
 	pm_runtime_put_sync(&pdev->dev);
 
 	return 0;
 
-err_wirq:
+err_port:
+	pm_runtime_disable(&pdev->dev);
+	pm_runtime_set_suspended(&pdev->dev);
+	pm_runtime_put_noidle(&pdev->dev);
+
+	if (stm32port->rx_ch) {
+		dmaengine_terminate_async(stm32port->rx_ch);
+		dma_release_channel(stm32port->rx_ch);
+	}
+
+	if (stm32port->rx_dma_buf)
+		dma_free_coherent(&pdev->dev,
+				  RX_BUF_L, stm32port->rx_buf,
+				  stm32port->rx_dma_buf);
+
+	if (stm32port->tx_ch) {
+		dmaengine_terminate_async(stm32port->tx_ch);
+		dma_release_channel(stm32port->tx_ch);
+	}
+
+	if (stm32port->tx_dma_buf)
+		dma_free_coherent(&pdev->dev,
+				  TX_BUF_L, stm32port->tx_buf,
+				  stm32port->tx_dma_buf);
+
 	if (stm32port->wakeirq > 0)
 		dev_pm_clear_wake_irq(&pdev->dev);
 
@@ -1298,11 +1323,20 @@ static int stm32_usart_serial_remove(struct platform_device *pdev)
 	int err;
 
 	pm_runtime_get_sync(&pdev->dev);
+	err = uart_remove_one_port(&stm32_usart_driver, port);
+	if (err)
+		return(err);
+
+	pm_runtime_disable(&pdev->dev);
+	pm_runtime_set_suspended(&pdev->dev);
+	pm_runtime_put_noidle(&pdev->dev);
 
 	stm32_usart_clr_bits(port, ofs->cr3, USART_CR3_DMAR);
 
-	if (stm32_port->rx_ch)
+	if (stm32_port->rx_ch) {
+		dmaengine_terminate_async(stm32_port->rx_ch);
 		dma_release_channel(stm32_port->rx_ch);
+	}
 
 	if (stm32_port->rx_dma_buf)
 		dma_free_coherent(&pdev->dev,
@@ -1311,8 +1345,10 @@ static int stm32_usart_serial_remove(struct platform_device *pdev)
 
 	stm32_usart_clr_bits(port, ofs->cr3, USART_CR3_DMAT);
 
-	if (stm32_port->tx_ch)
+	if (stm32_port->tx_ch) {
+		dmaengine_terminate_async(stm32_port->tx_ch);
 		dma_release_channel(stm32_port->tx_ch);
+	}
 
 	if (stm32_port->tx_dma_buf)
 		dma_free_coherent(&pdev->dev,
@@ -1326,12 +1362,7 @@ static int stm32_usart_serial_remove(struct platform_device *pdev)
 
 	stm32_usart_deinit_port(stm32_port);
 
-	err = uart_remove_one_port(&stm32_usart_driver, port);
-
-	pm_runtime_disable(&pdev->dev);
-	pm_runtime_put_noidle(&pdev->dev);
-
-	return err;
+	return 0;
 }
 
 #ifdef CONFIG_SERIAL_STM32_CONSOLE
-- 
2.17.1


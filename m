Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA671C433E6
	for <linux-serial@archiver.kernel.org>; Thu,  4 Mar 2021 16:25:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E64364F4F
	for <linux-serial@archiver.kernel.org>; Thu,  4 Mar 2021 16:25:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237073AbhCDQYU (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 4 Mar 2021 11:24:20 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:28368 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S237007AbhCDQYF (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 4 Mar 2021 11:24:05 -0500
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 124GC6jm025838;
        Thu, 4 Mar 2021 17:23:14 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=selector1;
 bh=CVaUk2i+IA1zYlqaeT+nwukxS7pOgiz851S+ttsify8=;
 b=QGXSkxIc8O1JYggLhi7dushEBH7oXpbMqXTfSsqD7whskybM0zTNZcD2ttnC/faB17un
 M7152KmA6RmNwy6OMZWk3dcWu75A1rR92ppa25JrYQVPOW3Bl9TkZymqTJ3yyhwrKImG
 ZWKJmY6jfNPjiW3z9fzyvh88NMh5aCOEnF7mMEBqRNey11lSYyribt3Oxl3q/64AliLy
 ZR0pyDWXFjCKnpGk2v9yaIGCzt+HjK5yUEI8dcGT3UsqtWDIkVd8xijJ30acF/MwTzm2
 FGIuH92ifnMyFzfA8Erz/PaHqXffrUBP6W0p5FE5DnAvZbe8x9vohkwuTo1eKzM4Zu0A UQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 36yfdygh36-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 04 Mar 2021 17:23:14 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id AB008100034;
        Thu,  4 Mar 2021 17:23:12 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 98D4E20741D;
        Thu,  4 Mar 2021 17:23:12 +0100 (CET)
Received: from localhost (10.75.127.51) by SFHDAG2NODE3.st.com (10.75.127.6)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 4 Mar 2021 17:23:12
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
Subject: [PATCH v2 01/13] serial: stm32: fix probe and remove order for dma
Date:   Thu, 4 Mar 2021 17:22:56 +0100
Message-ID: <20210304162308.8984-2-erwan.leray@foss.st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210304162308.8984-1-erwan.leray@foss.st.com>
References: <20210304162308.8984-1-erwan.leray@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.51]
X-ClientProxiedBy: SFHDAG2NODE1.st.com (10.75.127.4) To SFHDAG2NODE3.st.com
 (10.75.127.6)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-04_05:2021-03-03,2021-03-04 signatures=0
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
index b3675cf25a69..3d58824ac2af 100644
--- a/drivers/tty/serial/stm32-usart.c
+++ b/drivers/tty/serial/stm32-usart.c
@@ -1252,10 +1252,6 @@ static int stm32_usart_serial_probe(struct platform_device *pdev)
 		device_set_wakeup_enable(&pdev->dev, false);
 	}
 
-	ret = uart_add_one_port(&stm32_usart_driver, &stm32port->port);
-	if (ret)
-		goto err_wirq;
-
 	ret = stm32_usart_of_dma_rx_probe(stm32port, pdev);
 	if (ret)
 		dev_info(&pdev->dev, "interrupt mode used for rx (no dma)\n");
@@ -1269,11 +1265,40 @@ static int stm32_usart_serial_probe(struct platform_device *pdev)
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
 
@@ -1295,11 +1320,20 @@ static int stm32_usart_serial_remove(struct platform_device *pdev)
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
@@ -1308,8 +1342,10 @@ static int stm32_usart_serial_remove(struct platform_device *pdev)
 
 	stm32_usart_clr_bits(port, ofs->cr3, USART_CR3_DMAT);
 
-	if (stm32_port->tx_ch)
+	if (stm32_port->tx_ch) {
+		dmaengine_terminate_async(stm32_port->tx_ch);
 		dma_release_channel(stm32_port->tx_ch);
+	}
 
 	if (stm32_port->tx_dma_buf)
 		dma_free_coherent(&pdev->dev,
@@ -1323,12 +1359,7 @@ static int stm32_usart_serial_remove(struct platform_device *pdev)
 
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


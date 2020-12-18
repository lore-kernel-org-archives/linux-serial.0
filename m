Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7D49C2BBD5
	for <linux-serial@archiver.kernel.org>; Fri, 18 Dec 2020 19:02:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B24223B83
	for <linux-serial@archiver.kernel.org>; Fri, 18 Dec 2020 19:02:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726491AbgLRTB2 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 18 Dec 2020 14:01:28 -0500
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:49740 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726149AbgLRTB1 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 18 Dec 2020 14:01:27 -0500
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0BIIumlG011714;
        Fri, 18 Dec 2020 20:00:29 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=selector1;
 bh=gIZmSQvht2ZB5w+rQ8RvzG0lqz+JQaLSQmiALoML+oU=;
 b=M2gYJCj+7y3HyUa2Dz+UKHEiKejyT1mbh4tofUcEZzl+5LUbfEopI28JnMKzkhxhR98D
 VAbII1nN5r4xw0MarrhP6U6b0KrJDnWFcPclEuGCxDXDSqHtAbmAs8t4+hLjfja9/WAd
 RNW0cJGEh16P+Z/SKzDLw67wLoVqyTLKuJxHTJdkPuf3uQW1pdAWf+bn5DTKCOFyVkTw
 KZpAgaaOBPKh/71qEYvLTIK9+L78FTluQ20Z8VjLVU1BnAfF2EBO2apih0xe2rGoJo8V
 7/ZAqRNj/HoCYsPgP+iLv3AfPsYZGs6DJr0HfOFP727hOLMH85rW2CgbRvO87dvTxxUf Mw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 35cpt9ux3u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Dec 2020 20:00:29 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id AF8D710002A;
        Fri, 18 Dec 2020 20:00:28 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id A21CE231C3D;
        Fri, 18 Dec 2020 20:00:28 +0100 (CET)
Received: from localhost (10.75.127.49) by SFHDAG2NODE3.st.com (10.75.127.6)
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
Subject: [PATCH 1/8] serial: stm32: fix -Wall W=1 compilation warnings
Date:   Fri, 18 Dec 2020 20:00:12 +0100
Message-ID: <20201218190020.1572-2-erwan.leray@foss.st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201218190020.1572-1-erwan.leray@foss.st.com>
References: <20201218190020.1572-1-erwan.leray@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.75.127.49]
X-ClientProxiedBy: SFHDAG2NODE1.st.com (10.75.127.4) To SFHDAG2NODE3.st.com
 (10.75.127.6)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-18_12:2020-12-18,2020-12-18 signatures=0
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Fix compilations warning detected by -Wall W=1 compilation option:
- warning: variable ‘cookie’ set but not used

Fixes: 3489187204eb ("serial: stm32: adding dma support")
Signed-off-by: Erwan Le Ray <erwan.leray@foss.st.com>

diff --git a/drivers/tty/serial/stm32-usart.c b/drivers/tty/serial/stm32-usart.c
index ee6c7762d355..6248304a001f 100644
--- a/drivers/tty/serial/stm32-usart.c
+++ b/drivers/tty/serial/stm32-usart.c
@@ -350,7 +350,6 @@ static void stm32_transmit_chars_dma(struct uart_port *port)
 	struct stm32_usart_offsets *ofs = &stm32port->info->ofs;
 	struct circ_buf *xmit = &port->state->xmit;
 	struct dma_async_tx_descriptor *desc = NULL;
-	dma_cookie_t cookie;
 	unsigned int count, i;
 
 	if (stm32port->tx_dma_busy)
@@ -384,17 +383,18 @@ static void stm32_transmit_chars_dma(struct uart_port *port)
 					   DMA_MEM_TO_DEV,
 					   DMA_PREP_INTERRUPT);
 
-	if (!desc) {
-		for (i = count; i > 0; i--)
-			stm32_transmit_chars_pio(port);
-		return;
-	}
+	if (!desc)
+		goto fallback_err;
 
 	desc->callback = stm32_tx_dma_complete;
 	desc->callback_param = port;
 
 	/* Push current DMA TX transaction in the pending queue */
-	cookie = dmaengine_submit(desc);
+	if (dma_submit_error(dmaengine_submit(desc))) {
+		/* dma no yet started, safe to free resources */
+		dmaengine_terminate_async(stm32port->tx_ch);
+		goto fallback_err;
+	}
 
 	/* Issue pending DMA TX requests */
 	dma_async_issue_pending(stm32port->tx_ch);
@@ -403,6 +403,11 @@ static void stm32_transmit_chars_dma(struct uart_port *port)
 
 	xmit->tail = (xmit->tail + count) & (UART_XMIT_SIZE - 1);
 	port->icount.tx += count;
+	return;
+
+fallback_err:
+	for (i = count; i > 0; i--)
+		stm32_transmit_chars_pio(port);
 }
 
 static void stm32_transmit_chars(struct uart_port *port)
@@ -1087,7 +1092,6 @@ static int stm32_of_dma_rx_probe(struct stm32_port *stm32port,
 	struct device *dev = &pdev->dev;
 	struct dma_slave_config config;
 	struct dma_async_tx_descriptor *desc = NULL;
-	dma_cookie_t cookie;
 	int ret;
 
 	/* Request DMA RX channel */
@@ -1132,7 +1136,11 @@ static int stm32_of_dma_rx_probe(struct stm32_port *stm32port,
 	desc->callback_param = NULL;
 
 	/* Push current DMA transaction in the pending queue */
-	cookie = dmaengine_submit(desc);
+	ret = dma_submit_error(dmaengine_submit(desc));
+	if (ret) {
+		dmaengine_terminate_sync(stm32port->rx_ch);
+		goto config_err;
+	}
 
 	/* Issue pending DMA requests */
 	dma_async_issue_pending(stm32port->rx_ch);
-- 
2.17.1


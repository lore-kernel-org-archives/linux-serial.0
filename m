Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82C47C4708A
	for <linux-serial@archiver.kernel.org>; Thu, 27 May 2021 09:16:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 65431613D8
	for <linux-serial@archiver.kernel.org>; Thu, 27 May 2021 09:16:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235699AbhE0JRj (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 27 May 2021 05:17:39 -0400
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:33645 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235587AbhE0JRi (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 27 May 2021 05:17:38 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14R98ME6014149;
        Thu, 27 May 2021 11:15:49 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=selector1;
 bh=8KfBD589jiacVRJs1A1AeKT3+WaMrvQQn9TaXmgCjfk=;
 b=dw4dQ9m03f8/ZScd875mRFNdZeANffDoC4hbbbeokgXyM+FiPG7x3xwj7x4bFCfsgmYq
 97IK8ncBzRrE4qAZbKY/kownTvEoutyo3NJ3TX0ZxUiYMHt8LRxCJgEsax8LUHkQR0SJ
 OVc3PddVGnXdBikPajM4mgjSqN3H24c/lEGIKYOB1keWkBCYIC1ymiMm3i7hocxq1Gt6
 LWEQ3IRNkzfabkDfJWtf7cfXfKbBIDwEGKhCS4BTWl04blBbO5O29kLW2DPH3bk2DwW6
 p2MQMTKGc9rTQOEOVeudV2GGRXq+hmfh0Kok7HA1jj3o5VF3LicYvqqwOlUH/nzNm+mA Pg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 38t0x92g16-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 May 2021 11:15:49 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 9A6E8100034;
        Thu, 27 May 2021 11:15:48 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 8D1722171D7;
        Thu, 27 May 2021 11:15:48 +0200 (CEST)
Received: from localhost (10.75.127.44) by SFHDAG2NODE3.st.com (10.75.127.6)
 with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 27 May 2021 11:15:48
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
Subject: [PATCH 1/2] serial: stm32: reset dma buffers during probe
Date:   Thu, 27 May 2021 11:15:36 +0200
Message-ID: <20210527091537.8997-2-erwan.leray@foss.st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210527091537.8997-1-erwan.leray@foss.st.com>
References: <20210527091537.8997-1-erwan.leray@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG2NODE2.st.com (10.75.127.5) To SFHDAG2NODE3.st.com
 (10.75.127.6)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-27_04:2021-05-26,2021-05-27 signatures=0
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Reset Rx and Tx dma buffers during probe to avoid freeing
invalid buffer in no dma mode.

Signed-off-by: Erwan Le Ray <erwan.leray@foss.st.com>

diff --git a/drivers/tty/serial/stm32-usart.c b/drivers/tty/serial/stm32-usart.c
index c2ae7b392b86..2ac3b30477a7 100644
--- a/drivers/tty/serial/stm32-usart.c
+++ b/drivers/tty/serial/stm32-usart.c
@@ -1168,6 +1168,8 @@ static struct stm32_port *stm32_usart_of_get_port(struct platform_device *pdev)
 	stm32_ports[id].cr1_irq = USART_CR1_RXNEIE;
 	stm32_ports[id].cr3_irq = 0;
 	stm32_ports[id].last_res = RX_BUF_L;
+	stm32_ports[id].rx_dma_buf = 0;
+	stm32_ports[id].tx_dma_buf = 0;
 	return &stm32_ports[id];
 }
 
-- 
2.17.1


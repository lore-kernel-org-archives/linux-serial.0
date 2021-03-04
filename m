Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01D1AC4361B
	for <linux-serial@archiver.kernel.org>; Thu,  4 Mar 2021 16:25:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DADC164F51
	for <linux-serial@archiver.kernel.org>; Thu,  4 Mar 2021 16:25:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237222AbhCDQY0 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 4 Mar 2021 11:24:26 -0500
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:39566 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237037AbhCDQYK (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 4 Mar 2021 11:24:10 -0500
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 124GB9YJ003292;
        Thu, 4 Mar 2021 17:23:22 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=selector1;
 bh=WrtOmysTqy2QzPtzKw9QyQG2otxiyRbpfVahFna0HqQ=;
 b=XGcR6e7MYDdHi5Vx+jyTwXUZKki2VBOTrfMp88HYfpI221q4NYZT3lRIUNSFI+8wnZpX
 pUK/lePhaRsirFY8K4tUk1MB5RqTdFJvLIB+KBsab6O48h+W1tWkVlX7GAVORqVNRFPW
 ERbdy+Rf0IUxWzlFvcbTgyzdqllFx+b0WZfpPwtW/LnzduaBKxEZeoRcQeeeaJPtoPQr
 FcuBPpGIUZXRy8qjzOvMUDWHPTtxuKd8uoMBdJke54BRuU/5CxCj/W1xtqPMQTLml9sF
 +QeIpnvMVd21Fv8uaAfAJkLZeI9yqkbPrWPPxSNpk4Q5PSn7719yaUuKTKF5NwOz/A8J fw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 370xej5ays-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 04 Mar 2021 17:23:21 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 93D6710002A;
        Thu,  4 Mar 2021 17:23:21 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 8674420741B;
        Thu,  4 Mar 2021 17:23:21 +0100 (CET)
Received: from localhost (10.75.127.50) by SFHDAG2NODE3.st.com (10.75.127.6)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 4 Mar 2021 17:23:21
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
Subject: [PATCH v2 13/13] serial: stm32: add support for "flush_buffer" ops
Date:   Thu, 4 Mar 2021 17:23:08 +0100
Message-ID: <20210304162308.8984-14-erwan.leray@foss.st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210304162308.8984-1-erwan.leray@foss.st.com>
References: <20210304162308.8984-1-erwan.leray@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.50]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SFHDAG2NODE3.st.com
 (10.75.127.6)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-04_05:2021-03-03,2021-03-04 signatures=0
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Add the support for "flush_buffer" ops in order to flush any write buffers,
reset any DMA state and stop any ongoing DMA transfers when the
port->state->xmit circular buffer is cleared.

Signed-off-by: Erwan Le Ray <erwan.leray@foss.st.com>

diff --git a/drivers/tty/serial/stm32-usart.c b/drivers/tty/serial/stm32-usart.c
index 99dfa884cbef..9db6708e3d9f 100644
--- a/drivers/tty/serial/stm32-usart.c
+++ b/drivers/tty/serial/stm32-usart.c
@@ -597,6 +597,19 @@ static void stm32_usart_start_tx(struct uart_port *port)
 	stm32_usart_transmit_chars(port);
 }
 
+/* Flush the transmit buffer. */
+static void stm32_usart_flush_buffer(struct uart_port *port)
+{
+	struct stm32_port *stm32_port = to_stm32_port(port);
+	const struct stm32_usart_offsets *ofs = &stm32_port->info->ofs;
+
+	if (stm32_port->tx_ch) {
+		dmaengine_terminate_async(stm32_port->tx_ch);
+		stm32_usart_clr_bits(port, ofs->cr3, USART_CR3_DMAT);
+		stm32_port->tx_dma_busy = false;
+	}
+}
+
 /* Throttle the remote when input buffer is about to overflow. */
 static void stm32_usart_throttle(struct uart_port *port)
 {
@@ -992,6 +1005,7 @@ static const struct uart_ops stm32_uart_ops = {
 	.break_ctl	= stm32_usart_break_ctl,
 	.startup	= stm32_usart_startup,
 	.shutdown	= stm32_usart_shutdown,
+	.flush_buffer	= stm32_usart_flush_buffer,
 	.set_termios	= stm32_usart_set_termios,
 	.pm		= stm32_usart_pm,
 	.type		= stm32_usart_type,
-- 
2.17.1


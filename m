Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E0DDC433E0
	for <linux-serial@archiver.kernel.org>; Fri, 19 Feb 2021 17:48:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2962E64EB3
	for <linux-serial@archiver.kernel.org>; Fri, 19 Feb 2021 17:48:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230125AbhBSRst (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 19 Feb 2021 12:48:49 -0500
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:37746 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229913AbhBSRsf (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 19 Feb 2021 12:48:35 -0500
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11JHkOhs017974;
        Fri, 19 Feb 2021 18:47:44 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=selector1;
 bh=40JNfwcKJM4W8b7rMc25tq2v2aMGmR9uqOSCN2OFziU=;
 b=tU5zjTFW4w4/4YGQKN0y+RWKi2gEEbK5E1qZsy5jcZG31VLj+0zzT3iecJT67rBmHuJV
 our5pRsWQTwxjrNueQ2x2jznEDShRixgGA0LoVkjf6IeCSO/lSdyxFbUZwRLZ6adZ+hX
 YjVTQezTc1CLUfFeCtR1gzbqO0Et56gilMEHf+m/pH5hUhqwRcUTFgpoQJXrQoeLWbQ8
 +t5tfjY1GO36xHQHBfpqODfbkXnENTaiNc+2UAt0sNLVF7UvSjEdnRJ6Cd42tacBbNnB
 UrsbZ8u5Dzo2YNKRJhCKs9BtFBV+HFWrKF0KGiGZ1e4XH1GFdVoCbFpVJ1QZS9NiJ3tQ SA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 36p707550m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 Feb 2021 18:47:44 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 5ECAD100034;
        Fri, 19 Feb 2021 18:47:44 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 522ED25F3FC;
        Fri, 19 Feb 2021 18:47:44 +0100 (CET)
Received: from localhost (10.75.127.44) by SFHDAG2NODE3.st.com (10.75.127.6)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 19 Feb 2021 18:47:43
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
Subject: [PATCH 04/13] serial: stm32: fix TX and RX FIFO thresholds
Date:   Fri, 19 Feb 2021 18:47:27 +0100
Message-ID: <20210219174736.1022-5-erwan.leray@foss.st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210219174736.1022-1-erwan.leray@foss.st.com>
References: <20210219174736.1022-1-erwan.leray@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG2NODE2.st.com (10.75.127.5) To SFHDAG2NODE3.st.com
 (10.75.127.6)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-19_08:2021-02-18,2021-02-19 signatures=0
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

TX and RX FIFO thresholds may be cleared after suspend/resume, depending
on the low power mode.

Those configurations (done in startup) are not effective for UART console,
as:
- the reference manual indicates that FIFOEN bit can only be written when
  the USART is disabled (UE=0)
- a set_termios (where UE is set) is requested firstly for console
  enabling, before the startup.

Fixes: 84872dc448fe ("serial: stm32: add RX and TX FIFO flush")
Signed-off-by: Erwan Le Ray <erwan.leray@foss.st.com>

diff --git a/drivers/tty/serial/stm32-usart.c b/drivers/tty/serial/stm32-usart.c
index 7710de947aa3..d409a23806b1 100644
--- a/drivers/tty/serial/stm32-usart.c
+++ b/drivers/tty/serial/stm32-usart.c
@@ -649,19 +649,8 @@ static int stm32_usart_startup(struct uart_port *port)
 	if (ofs->rqr != UNDEF_REG)
 		stm32_usart_set_bits(port, ofs->rqr, USART_RQR_RXFRQ);
 
-	/* Tx and RX FIFO configuration */
-	if (stm32_port->fifoen) {
-		val = readl_relaxed(port->membase + ofs->cr3);
-		val &= ~(USART_CR3_TXFTCFG_MASK | USART_CR3_RXFTCFG_MASK);
-		val |= USART_CR3_TXFTCFG_HALF << USART_CR3_TXFTCFG_SHIFT;
-		val |= USART_CR3_RXFTCFG_HALF << USART_CR3_RXFTCFG_SHIFT;
-		writel_relaxed(val, port->membase + ofs->cr3);
-	}
-
-	/* RX FIFO enabling */
+	/* RX enabling */
 	val = stm32_port->cr1_irq | USART_CR1_RE | BIT(cfg->uart_enable_bit);
-	if (stm32_port->fifoen)
-		val |= USART_CR1_FIFOEN;
 	stm32_usart_set_bits(port, ofs->cr1, val);
 
 	return 0;
@@ -770,9 +759,15 @@ static void stm32_usart_set_termios(struct uart_port *port,
 	if (stm32_port->fifoen)
 		cr1 |= USART_CR1_FIFOEN;
 	cr2 = 0;
+
+	/* Tx and RX FIFO configuration */
 	cr3 = readl_relaxed(port->membase + ofs->cr3);
-	cr3 &= USART_CR3_TXFTIE | USART_CR3_RXFTCFG_MASK | USART_CR3_RXFTIE
-		| USART_CR3_TXFTCFG_MASK;
+	cr3 &= USART_CR3_TXFTIE | USART_CR3_RXFTIE;
+	if (stm32_port->fifoen) {
+		cr3 &= ~(USART_CR3_TXFTCFG_MASK | USART_CR3_RXFTCFG_MASK);
+		cr3 |= USART_CR3_TXFTCFG_HALF << USART_CR3_TXFTCFG_SHIFT;
+		cr3 |= USART_CR3_RXFTCFG_HALF << USART_CR3_RXFTCFG_SHIFT;
+	}
 
 	if (cflag & CSTOPB)
 		cr2 |= USART_CR2_STOP_2B;
-- 
2.17.1


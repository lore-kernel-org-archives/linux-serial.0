Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39133C433E9
	for <linux-serial@archiver.kernel.org>; Fri, 19 Feb 2021 17:48:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1373764EB4
	for <linux-serial@archiver.kernel.org>; Fri, 19 Feb 2021 17:48:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbhBSRsq (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 19 Feb 2021 12:48:46 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:60632 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229555AbhBSRsf (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 19 Feb 2021 12:48:35 -0500
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11JHliJf024590;
        Fri, 19 Feb 2021 18:47:44 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=selector1;
 bh=cKsHCbGnlE8gYH9Th0cYP6ZsejdHp3VxMkPx7vQC+FY=;
 b=donWUqN01v5eGBB5U3uqC/yauasAUGlJviy5ACpIL1KKgj5lcDacBHNkcCJ3upao5H04
 KSCM6s9ntlpIt8qof+uqHk4XQvb2ht8PbS6TpRGTHF/P3PYcseEF4c15OI3+kbDL8Lo8
 f3n0+97GjRlQrFK2IEVovlXvs189Owhir+21wPRaYB+HYU/KGhv1ik6hsuCWp49dRC+A
 VU8Q4byxar9UhcutLAexWlTVpLFXLMJbJgvLWARJ8XQatoj5RbAsGsR0KbYHcMtnSDDK
 yYthL6Njwfqlk6a8kcTY2ud+WIvy0gJ/6uiYamtAVC6LQ94lzgwCNAaXyWsrRjE1+WH/ lw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 36p6hq7p2q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 Feb 2021 18:47:44 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 85CD9100038;
        Fri, 19 Feb 2021 18:47:42 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 7984425F3FC;
        Fri, 19 Feb 2021 18:47:42 +0100 (CET)
Received: from localhost (10.75.127.45) by SFHDAG2NODE3.st.com (10.75.127.6)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 19 Feb 2021 18:47:42
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
Subject: [PATCH 02/13] serial: stm32: fix startup by enabling usart for reception
Date:   Fri, 19 Feb 2021 18:47:25 +0100
Message-ID: <20210219174736.1022-3-erwan.leray@foss.st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210219174736.1022-1-erwan.leray@foss.st.com>
References: <20210219174736.1022-1-erwan.leray@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG3NODE3.st.com (10.75.127.9) To SFHDAG2NODE3.st.com
 (10.75.127.6)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-19_08:2021-02-18,2021-02-19 signatures=0
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

RX is configured, but usart is not enabled in startup function.
Kernel documentation specifies that startup should enable the port for
reception.
Fix the startup by enabling usart for reception.

Fixes: 84872dc448fe ("serial: stm32: add RX and TX FIFO flush")
Signed-off-by: Erwan Le Ray <erwan.leray@foss.st.com>

diff --git a/drivers/tty/serial/stm32-usart.c b/drivers/tty/serial/stm32-usart.c
index c67029ebcac8..33a479062948 100644
--- a/drivers/tty/serial/stm32-usart.c
+++ b/drivers/tty/serial/stm32-usart.c
@@ -634,6 +634,7 @@ static int stm32_usart_startup(struct uart_port *port)
 {
 	struct stm32_port *stm32_port = to_stm32_port(port);
 	struct stm32_usart_offsets *ofs = &stm32_port->info->ofs;
+	struct stm32_usart_config *cfg = &stm32_port->info->cfg;
 	const char *name = to_platform_device(port->dev)->name;
 	u32 val;
 	int ret;
@@ -658,7 +659,7 @@ static int stm32_usart_startup(struct uart_port *port)
 	}
 
 	/* RX FIFO enabling */
-	val = stm32_port->cr1_irq | USART_CR1_RE;
+	val = stm32_port->cr1_irq | USART_CR1_RE | BIT(cfg->uart_enable_bit);
 	if (stm32_port->fifoen)
 		val |= USART_CR1_FIFOEN;
 	stm32_usart_set_bits(port, ofs->cr1, val);
-- 
2.17.1


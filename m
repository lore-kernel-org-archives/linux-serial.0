Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3699C2D0E4
	for <linux-serial@archiver.kernel.org>; Fri, 18 Dec 2020 19:02:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A265823B86
	for <linux-serial@archiver.kernel.org>; Fri, 18 Dec 2020 19:02:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733023AbgLRTBq (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 18 Dec 2020 14:01:46 -0500
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:43715 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726487AbgLRTB2 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 18 Dec 2020 14:01:28 -0500
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0BIIv1Ge013340;
        Fri, 18 Dec 2020 20:00:31 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=selector1;
 bh=2ac0OtE21/ui4wlzt7Dk2cdhdVHiNUCF8D7wYErCU0g=;
 b=3rKZTa32DfFuXBAhhVyQ6HI/7rVojJXWfFSR/OC5kKK4yzrkXOC6zNeoefFd8UUC7HJ4
 QAV5VUmr6ByOgpGTjj0ojVdX9QQWE7c6OpUQ6mBdIUsjGAUEmNsFAlXXQbMftb5cVpfp
 E66HJYKyiZKgO7sWklyr/PzW3hNC6z2yc3BzvUauGtOcLk3DWw+G6JB7TXaYsaV4LeBm
 MvGx3/PEytXhQjD97CmDuLUmjPg2j190hGUDK0ejEpG1TFsv1pb1OcbxOwEm+VoMMnLK
 76CwKaNzMwCGFZWzwLYAs5B+BrvEs09n20q1KZGydPBLDrA1NoeBET3w/hCtO6zsrT5u fw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 35cptdqw8x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Dec 2020 20:00:31 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 8AA03100034;
        Fri, 18 Dec 2020 20:00:31 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 7D07E228601;
        Fri, 18 Dec 2020 20:00:31 +0100 (CET)
Received: from localhost (10.75.127.48) by SFHDAG2NODE3.st.com (10.75.127.6)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 18 Dec 2020 20:00:31
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
Subject: [PATCH 6/8] serial: stm32: update conflicting RTS/CTS config comment
Date:   Fri, 18 Dec 2020 20:00:17 +0100
Message-ID: <20201218190020.1572-7-erwan.leray@foss.st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201218190020.1572-1-erwan.leray@foss.st.com>
References: <20201218190020.1572-1-erwan.leray@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.48]
X-ClientProxiedBy: SFHDAG1NODE2.st.com (10.75.127.2) To SFHDAG2NODE3.st.com
 (10.75.127.6)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-18_12:2020-12-18,2020-12-18 signatures=0
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The comment for conflicting RTS/CTS config refers to "st, hw-flow-ctrl",
but this property is deprecated since the generic RTS/CTS property has
been introduced by the patch 'serial: stm32: Use generic DT binding for
announcing RTS/CTS lines'.
Update the comment to refer to both generic and deprecated RTS/CTS
properties.

Signed-off-by: Erwan Le Ray <erwan.leray@foss.st.com>

diff --git a/drivers/tty/serial/stm32-usart.c b/drivers/tty/serial/stm32-usart.c
index 938d2c4aeaed..0d6c7f3375f0 100644
--- a/drivers/tty/serial/stm32-usart.c
+++ b/drivers/tty/serial/stm32-usart.c
@@ -1031,7 +1031,10 @@ static int stm32_usart_init_port(struct stm32_port *stm32port,
 		goto err_clk;
 	}
 
-	/* Both CTS/RTS gpios and "st,hw-flow-ctrl" should not be specified */
+	/*
+	 * Both CTS/RTS gpios and "st,hw-flow-ctrl" (deprecated) or "uart-has-rtscts"
+	 * properties should not be specified.
+	 */
 	if (stm32port->hw_flow_control) {
 		if (mctrl_gpio_to_gpiod(stm32port->gpios, UART_GPIO_CTS) ||
 		    mctrl_gpio_to_gpiod(stm32port->gpios, UART_GPIO_RTS)) {
-- 
2.17.1


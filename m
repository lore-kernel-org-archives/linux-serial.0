Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 176C2C43331
	for <linux-serial@archiver.kernel.org>; Wed,  6 Jan 2021 16:24:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D68A723131
	for <linux-serial@archiver.kernel.org>; Wed,  6 Jan 2021 16:24:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727708AbhAFQYB (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 6 Jan 2021 11:24:01 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:1211 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727701AbhAFQYA (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 6 Jan 2021 11:24:00 -0500
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 106GHwHk032690;
        Wed, 6 Jan 2021 17:23:08 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=selector1;
 bh=2ac0OtE21/ui4wlzt7Dk2cdhdVHiNUCF8D7wYErCU0g=;
 b=4BXTUOQtM9igI91+mk4r5kRFcilGBZ9Z6KrXmSJv3Xje4HDl+uLhm6Rrpf3jFnYzceM+
 vNQKesM3W0jg2BedDLH5L6UJtaImfLTRY23ix+TNAJn8wglf8ltuvT6UyX12Os5HTEFl
 iaaltRMLTdY2n8XEDXFU6i2cd+pIGZYh8JLXoV+ggi6cWPMGKdfTE7VVRy4I6PDjFZAQ
 7512gPeqBQUegbEvBX0E1Ng4w12dj1LZACEom7vo6SJqfySYW1ZWt+1Nux3bdfe4lyYQ
 h4XdCa0O+pfV3HOTWkNhBQnJ+7SWFzvoa6ScHeR2NrNCdBhMlDpIh5oeWDnIcTXpThU8 8Q== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 35teuv8n05-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 06 Jan 2021 17:23:08 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id DD325100038;
        Wed,  6 Jan 2021 17:23:07 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id D1DD02AD2C6;
        Wed,  6 Jan 2021 17:23:07 +0100 (CET)
Received: from localhost (10.75.127.50) by SFHDAG2NODE3.st.com (10.75.127.6)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 6 Jan 2021 17:23:07
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
Subject: [PATCH v2 6/8] serial: stm32: update conflicting RTS/CTS config comment
Date:   Wed, 6 Jan 2021 17:22:01 +0100
Message-ID: <20210106162203.28854-7-erwan.leray@foss.st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210106162203.28854-1-erwan.leray@foss.st.com>
References: <20210106162203.28854-1-erwan.leray@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.50]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SFHDAG2NODE3.st.com
 (10.75.127.6)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-06_09:2021-01-06,2021-01-06 signatures=0
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


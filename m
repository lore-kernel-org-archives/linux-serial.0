Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0CD5C433E9
	for <linux-serial@archiver.kernel.org>; Fri, 19 Mar 2021 18:45:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8881A6198E
	for <linux-serial@archiver.kernel.org>; Fri, 19 Mar 2021 18:45:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230335AbhCSSo7 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 19 Mar 2021 14:44:59 -0400
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:59611 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230281AbhCSSoW (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 19 Mar 2021 14:44:22 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12JIgGIg010252;
        Fri, 19 Mar 2021 19:43:25 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=selector1;
 bh=JQWsKQyNZ6s87bPutiODteWCPQdbcCDdbSCdVVUPUOs=;
 b=ykHAe7q/GDMFBRhhgNB1BrwPoMTWf0BRKrlC7RPg8nO4P7Z34/Wkw0ZDI8P5qG1nfoBx
 wmGc6nmkgdhRW/hlncKXk3gtv6oGGRK902n64fjhJgVi3Zhpuwz+XtjEKdNq39XMYgVh
 BxUCJ5s6ESY0wnFf5Q57avJh9mvgdPp63mfaX16UhDPIDs6XJAYYrBoTHo89SK0I/0mo
 zKz8CjJ4ndDCuVexrDIrf4CwhD3CkkpCTm6Hv4th8PJeR1HY8fUq7/SLM/+id2kiYKsR
 B9nrbmeIKSV3HEr9RlybNNa1LECKq29p1KT8iKA5Irp1SsFSXWMcWWPrhPPio/9IQzTL zQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 378pr6d1g2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 Mar 2021 19:43:24 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 7285A100038;
        Fri, 19 Mar 2021 19:43:24 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 5B3B32721FF;
        Fri, 19 Mar 2021 19:43:24 +0100 (CET)
Received: from localhost (10.75.127.51) by SFHDAG2NODE3.st.com (10.75.127.6)
 with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 19 Mar 2021 19:43:23
 +0100
From:   Erwan Le Ray <erwan.leray@foss.st.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
CC:     <linux-serial@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Erwan Le Ray <erwan.leray@foss.st.com>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        Valentin Caron <valentin.caron@foss.st.com>,
        Patrice Chotard <patrice.chotard@foss.st.com>
Subject: [PATCH 1/5] serial: stm32: rework wakeup management
Date:   Fri, 19 Mar 2021 19:42:49 +0100
Message-ID: <20210319184253.5841-2-erwan.leray@foss.st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210319184253.5841-1-erwan.leray@foss.st.com>
References: <20210319184253.5841-1-erwan.leray@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.51]
X-ClientProxiedBy: SFHDAG2NODE1.st.com (10.75.127.4) To SFHDAG2NODE3.st.com
 (10.75.127.6)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-19_10:2021-03-19,2021-03-19 signatures=0
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Rework wakeup management by activating uart as wakeup source when usart
device OR its tty virtual device parent is wakeup source.

This patch aim to avoid potential misalignment between serial and tty
wakeup flags.

Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
Signed-off-by: Alexandre Torgue <alexandre.torgue@foss.st.com>
Signed-off-by: Erwan Le Ray <erwan.leray@foss.st.com>

diff --git a/drivers/tty/serial/stm32-usart.c b/drivers/tty/serial/stm32-usart.c
index 9db6708e3d9f..11656b6b7c0f 100644
--- a/drivers/tty/serial/stm32-usart.c
+++ b/drivers/tty/serial/stm32-usart.c
@@ -1534,7 +1534,7 @@ static int __maybe_unused stm32_usart_serial_suspend(struct device *dev)
 
 	uart_suspend_port(&stm32_usart_driver, port);
 
-	if (device_may_wakeup(dev))
+	if (device_may_wakeup(dev) || device_wakeup_path(dev))
 		stm32_usart_serial_en_wakeup(port, true);
 	else
 		stm32_usart_serial_en_wakeup(port, false);
@@ -1546,7 +1546,7 @@ static int __maybe_unused stm32_usart_serial_suspend(struct device *dev)
 	 * capabilities.
 	 */
 	if (console_suspend_enabled || !uart_console(port)) {
-		if (device_may_wakeup(dev))
+		if (device_may_wakeup(dev) || device_wakeup_path(dev))
 			pinctrl_pm_select_idle_state(dev);
 		else
 			pinctrl_pm_select_sleep_state(dev);
@@ -1561,7 +1561,7 @@ static int __maybe_unused stm32_usart_serial_resume(struct device *dev)
 
 	pinctrl_pm_select_default_state(dev);
 
-	if (device_may_wakeup(dev))
+	if (device_may_wakeup(dev) || device_wakeup_path(dev))
 		stm32_usart_serial_en_wakeup(port, false);
 
 	return uart_resume_port(&stm32_usart_driver, port);
-- 
2.17.1


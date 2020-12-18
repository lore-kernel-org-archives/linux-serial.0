Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50A21C3527A
	for <linux-serial@archiver.kernel.org>; Fri, 18 Dec 2020 19:01:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 153EC23B84
	for <linux-serial@archiver.kernel.org>; Fri, 18 Dec 2020 19:01:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732931AbgLRTB3 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 18 Dec 2020 14:01:29 -0500
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:49754 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726374AbgLRTB3 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 18 Dec 2020 14:01:29 -0500
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0BIIur0I011741;
        Fri, 18 Dec 2020 20:00:32 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=selector1;
 bh=NOnMZTvRCPz4nCDUvAVvkeo7nZTTuO+I1JzMInY3HtE=;
 b=JJHQ53eBMUY2RcqxUlfwmy0bbPpBtTBkVI+QMIDklJQxgRTfeuNEYFCzIA+fFoyDUQaK
 IEhUEX1X/ZCK5iWW9NQsjM7qD1VXJxtaIupT9VvD1GDjKaEf6WFyI6BFnDUYABzpTzKw
 V6nWNOUXYk/vmbU7NaATC+Zx8ivI5X3w89SBM9RerMo1HYkwUAOsCGpwMUQ5TryaVRed
 gnO0KMnahN+duT85Snw+G5L1DfJMMxpKVsjZCdyUOmjuqpXTNloxqKsmqWfyvDKSciyo
 pMANyNZAPTHAsZXKJunQr+cG6pwH06Tq4TBdDXoa/DAqXJRoHIJ0ddRiTYI24ZxjB9ei HA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 35cpt9ux45-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Dec 2020 20:00:32 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 1B640100038;
        Fri, 18 Dec 2020 20:00:32 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 0EBA1228601;
        Fri, 18 Dec 2020 20:00:32 +0100 (CET)
Received: from localhost (10.75.127.51) by SFHDAG2NODE3.st.com (10.75.127.6)
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
        Valentin Caron <valentin.caron@foss.st.com>,
        Etienne Carriere <etienne.carriere@foss.st.com>
Subject: [PATCH 7/8] serial: stm32: clean probe and remove port deinit
Date:   Fri, 18 Dec 2020 20:00:18 +0100
Message-ID: <20201218190020.1572-8-erwan.leray@foss.st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201218190020.1572-1-erwan.leray@foss.st.com>
References: <20201218190020.1572-1-erwan.leray@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.51]
X-ClientProxiedBy: SFHDAG2NODE1.st.com (10.75.127.4) To SFHDAG2NODE3.st.com
 (10.75.127.6)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-18_12:2020-12-18,2020-12-18 signatures=0
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Clean probe and remove port deinit by moving clk_disable_unprepare in a
new dedicated deinit_port function.

Signed-off-by: Erwan Le Ray <erwan.leray@foss.st.com>
Signed-off-by: Etienne Carriere <etienne.carriere@foss.st.com>

diff --git a/drivers/tty/serial/stm32-usart.c b/drivers/tty/serial/stm32-usart.c
index 0d6c7f3375f0..9d73f6976586 100644
--- a/drivers/tty/serial/stm32-usart.c
+++ b/drivers/tty/serial/stm32-usart.c
@@ -970,6 +970,11 @@ static const struct uart_ops stm32_uart_ops = {
 	.verify_port	= stm32_usart_verify_port,
 };
 
+static void stm32_usart_deinit_port(struct stm32_port *stm32port)
+{
+	clk_disable_unprepare(stm32port->clk);
+}
+
 static int stm32_usart_init_port(struct stm32_port *stm32port,
 				 struct platform_device *pdev)
 {
@@ -1279,7 +1284,7 @@ static int stm32_usart_serial_probe(struct platform_device *pdev)
 		device_init_wakeup(&pdev->dev, false);
 
 err_uninit:
-	clk_disable_unprepare(stm32port->clk);
+	stm32_usart_deinit_port(stm32port);
 
 	return ret;
 }
@@ -1318,7 +1323,7 @@ static int stm32_usart_serial_remove(struct platform_device *pdev)
 		device_init_wakeup(&pdev->dev, false);
 	}
 
-	clk_disable_unprepare(stm32_port->clk);
+	stm32_usart_deinit_port(stm32_port);
 
 	err = uart_remove_one_port(&stm32_usart_driver, port);
 
-- 
2.17.1


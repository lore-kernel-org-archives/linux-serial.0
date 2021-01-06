Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65129C433DB
	for <linux-serial@archiver.kernel.org>; Wed,  6 Jan 2021 16:25:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 36FBE2312E
	for <linux-serial@archiver.kernel.org>; Wed,  6 Jan 2021 16:25:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727176AbhAFQZC (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 6 Jan 2021 11:25:02 -0500
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:32812 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726251AbhAFQZC (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 6 Jan 2021 11:25:02 -0500
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 106GH6AZ010869;
        Wed, 6 Jan 2021 17:24:13 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=selector1;
 bh=n+cExBFo80dtEPZ2+yAMwXdepDZXx0+zmtl1xFWwJnM=;
 b=aHhR4lkXe9JZEAA/0JlKnNlJCp2BLrto/tgE+TAZ7iPtpHtTWly9y175IK4E9R7q9bkS
 5lbyAXR1iIHsIHWrYBjuyyVgQ5uGtN+jDiTPSByrm86pIn2kbzOk2JsNptUxlcQ7NQ19
 7vKN8+dkXTYjZknSuHi5Hg7ZcOnLOqeP3HW+P3h4KsC5X9hH4p2T14Z86QlioXUmHdqT
 V7t1gFmtBxgVlF6Lfk4Ss3N9edJ6IpL1U+4RujrdVz+xWsmnlDKytMzEInqnLJ5aH3Xk
 +drhesenuYHU4ut6a7dUxLfSk+fpmYRcIAdlDhnP2l7ZFoXoqR+f22hs6i+e9PTjM51N GA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 35th25us11-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 06 Jan 2021 17:24:13 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id AC4A110002A;
        Wed,  6 Jan 2021 17:24:12 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 9F0652417A8;
        Wed,  6 Jan 2021 17:24:12 +0100 (CET)
Received: from localhost (10.75.127.48) by SFHDAG2NODE3.st.com (10.75.127.6)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 6 Jan 2021 17:24:12
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
Subject: [PATCH v2 8/8] serial: stm32: update transmission complete error message in shutdown
Date:   Wed, 6 Jan 2021 17:22:03 +0100
Message-ID: <20210106162203.28854-9-erwan.leray@foss.st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210106162203.28854-1-erwan.leray@foss.st.com>
References: <20210106162203.28854-1-erwan.leray@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.48]
X-ClientProxiedBy: SFHDAG1NODE2.st.com (10.75.127.2) To SFHDAG2NODE3.st.com
 (10.75.127.6)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-06_09:2021-01-06,2021-01-06 signatures=0
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The transmission complete error message provides the status of the
ISR_USART_TC bit. This bit, when set, indicates that the transmission
has not been completed.
The bit status indication is not a very understandable information.
The error message sent on console should indicate that the transmission is
not complete, instead of providing USART_TC bit status.
Update the error message and add a comment for better understanding.

Signed-off-by: Erwan Le Ray <erwan.leray@foss.st.com>

diff --git a/drivers/tty/serial/stm32-usart.c b/drivers/tty/serial/stm32-usart.c
index 9d73f6976586..6a9a5ef5f5ba 100644
--- a/drivers/tty/serial/stm32-usart.c
+++ b/drivers/tty/serial/stm32-usart.c
@@ -687,8 +687,9 @@ static void stm32_usart_shutdown(struct uart_port *port)
 					 isr, (isr & USART_SR_TC),
 					 10, 100000);
 
+	/* Send the TC error message only when ISR_TC is not set */
 	if (ret)
-		dev_err(port->dev, "transmission complete not set\n");
+		dev_err(port->dev, "Transmission is not complete\n");
 
 	stm32_usart_clr_bits(port, ofs->cr1, val);
 
-- 
2.17.1


Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11FEBC433EF
	for <linux-serial@archiver.kernel.org>; Tue, 19 Apr 2022 08:54:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350184AbiDSI44 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 19 Apr 2022 04:56:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350181AbiDSI4z (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 19 Apr 2022 04:56:55 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D86DE22BC1;
        Tue, 19 Apr 2022 01:54:12 -0700 (PDT)
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23J7mPMJ031599;
        Tue, 19 Apr 2022 10:53:50 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=selector1;
 bh=2TdqCQA3HZJgjbQgS4ng8USah1H+t/xStkf042B0x94=;
 b=kZcqNamzq6IR++gU1x2mp3vOcRGEv6Dz1jLwtnFhO6IauwBm3SwU/PZo2wIbvHSrbo8V
 DSmquKRilSLdtoieiXx0hrVSdh/GkhuyO//S/v1tsamcY2H4K0vBL4V/XE7vQDVDqIuy
 FUaHe3aIzuaBBEXoJmwg2VgHOoZtMoPBWB1yg4Ti8ZWeuD+YvpHJjfSK7TE90UxmfNkP
 FGHJwEMb6ALx3trwuGvI26fFMh04SAYa7QTdH6vxWadySrpmuRBrDOlgR65t3L5vSmo0
 CSfbLv3pXZiDocm91oxyp6hCTYrtwpm5+euj+tcohti6Lj++28RDxOxq/ZXqlY9eaVNh Sw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3fh09refje-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 19 Apr 2022 10:53:50 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 43AD8100034;
        Tue, 19 Apr 2022 10:53:47 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 3C1992053D5;
        Tue, 19 Apr 2022 10:53:47 +0200 (CEST)
Received: from localhost (10.75.127.48) by SFHDAG2NODE2.st.com (10.75.127.5)
 with Microsoft SMTP Server (TLS) id 15.0.1497.26; Tue, 19 Apr 2022 10:53:46
 +0200
From:   Valentin Caron <valentin.caron@foss.st.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Valentin Caron <valentin.caron@foss.st.com>,
        <linux-serial@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH V3 1/3] serial: stm32: remove infinite loop possibility in putchar function
Date:   Tue, 19 Apr 2022 10:53:28 +0200
Message-ID: <20220419085330.1178925-2-valentin.caron@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220419085330.1178925-1-valentin.caron@foss.st.com>
References: <20220419085330.1178925-1-valentin.caron@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.75.127.48]
X-ClientProxiedBy: SFHDAG2NODE1.st.com (10.75.127.4) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-19_03,2022-04-15_01,2022-02-23_01
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Rework stm32_usart_console_putchar() function in order to anticipate
the case where the character can never be sent.

Signed-off-by: Valentin Caron <valentin.caron@foss.st.com>
---
 drivers/tty/serial/stm32-usart.c | 12 +++++++++---
 drivers/tty/serial/stm32-usart.h |  2 ++
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/stm32-usart.c b/drivers/tty/serial/stm32-usart.c
index f886976daef6..9910a18779af 100644
--- a/drivers/tty/serial/stm32-usart.c
+++ b/drivers/tty/serial/stm32-usart.c
@@ -1640,10 +1640,16 @@ static void stm32_usart_console_putchar(struct uart_port *port, unsigned char ch
 {
 	struct stm32_port *stm32_port = to_stm32_port(port);
 	const struct stm32_usart_offsets *ofs = &stm32_port->info->ofs;
+	u32 isr;
+	int ret;
 
-	while (!(readl_relaxed(port->membase + ofs->isr) & USART_SR_TXE))
-		cpu_relax();
-
+	ret = readl_relaxed_poll_timeout_atomic(port->membase + ofs->isr, isr,
+						(isr & USART_SR_TXE), 100,
+						STM32_USART_TIMEOUT_USEC);
+	if (ret != 0) {
+		dev_err(port->dev, "Error while sending data in UART TX : %d\n", ret);
+		return;
+	}
 	writel_relaxed(ch, port->membase + ofs->tdr);
 }
 
diff --git a/drivers/tty/serial/stm32-usart.h b/drivers/tty/serial/stm32-usart.h
index feab952aec16..d734c4a5fd24 100644
--- a/drivers/tty/serial/stm32-usart.h
+++ b/drivers/tty/serial/stm32-usart.h
@@ -251,6 +251,8 @@ struct stm32_usart_info stm32h7_info = {
 #define RX_BUF_P (RX_BUF_L / 2)	 /* dma rx buffer period     */
 #define TX_BUF_L RX_BUF_L	 /* dma tx buffer length     */
 
+#define STM32_USART_TIMEOUT_USEC USEC_PER_SEC /* 1s timeout in µs */
+
 struct stm32_port {
 	struct uart_port port;
 	struct clk *clk;
-- 
2.25.1


Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0AB8C4360C
	for <linux-serial@archiver.kernel.org>; Thu,  4 Mar 2021 16:25:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C53E364F4D
	for <linux-serial@archiver.kernel.org>; Thu,  4 Mar 2021 16:25:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237180AbhCDQYY (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 4 Mar 2021 11:24:24 -0500
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:25704 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237024AbhCDQYJ (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 4 Mar 2021 11:24:09 -0500
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 124GC66Q021017;
        Thu, 4 Mar 2021 17:23:16 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=selector1;
 bh=+ZgqbViCMtQFWW0otyQRlC9BLZeUmAniGAv1NlQmOpw=;
 b=fnF3agxyVPqggneAglsHgvG3SEVED18PO8QXgMVOMslq453F/EAqydkKmMXx9vnvYPBE
 xpo/usai2rXuwKbPwpzeueq5USVSGs5PtE5QiUFvbIz6H3+EgjPs3TY4BVepO9IJt4vD
 irkhEdCe0SuS7a9UkEBEwSFK+GIZZSXADnh0UvnaaCE3XBdZfQ1e8Ff9u6AUSA48KIO6
 D6ZCtRcDcEVdIURSkFU4Fyk44M3gx15WtveVhI3QycNjP4Dywy/NKQISuMnSBRkqPCs0
 A21JARmLF/S0Hi9jdDZWQkOGNNVXR1Dhr5YZUXjOYk6toGkk1gHmA1j6OPVbJI7axlMO XA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 36yfc48j8r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 04 Mar 2021 17:23:16 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id A54A4100034;
        Thu,  4 Mar 2021 17:23:15 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 98DCD20741B;
        Thu,  4 Mar 2021 17:23:15 +0100 (CET)
Received: from localhost (10.75.127.51) by SFHDAG2NODE3.st.com (10.75.127.6)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 4 Mar 2021 17:23:15
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
Subject: [PATCH v2 05/13] serial: stm32: fix a deadlock condition with wakeup event
Date:   Thu, 4 Mar 2021 17:23:00 +0100
Message-ID: <20210304162308.8984-6-erwan.leray@foss.st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210304162308.8984-1-erwan.leray@foss.st.com>
References: <20210304162308.8984-1-erwan.leray@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.51]
X-ClientProxiedBy: SFHDAG3NODE2.st.com (10.75.127.8) To SFHDAG2NODE3.st.com
 (10.75.127.6)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-04_05:2021-03-03,2021-03-04 signatures=0
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Deadlock issue is seen when enabling CONFIG_PROVE_LOCKING=Y, and uart
console as wakeup source. Deadlock occurs when resuming from low power
mode if system is waked up via usart console.
The deadlock is triggered 100% when also disabling console suspend prior
to go to suspend.

Simplified call stack, deadlock condition:
- stm32_console_write <-- spin_lock already held
- print_circular_bug
- pm_wakeup_dev_event <-- triggers lockdep as seen above
- stm32_receive_chars
- stm32_interrupt <-- wakeup via uart console, takes the lock

So, revisit spin_lock in stm32-usart driver:
- there is no need to hold the lock to access ICR (atomic clear of status
  flags)
- only hold the lock inside stm32_receive_chars() routine (no need to
  call pm_wakeup_dev_event with lock held)
- keep stm32_transmit_chars() routine called with lock held

Fixes: 48a6092fb41f ("serial: stm32-usart: Add STM32 USART Driver")
Signed-off-by: Erwan Le Ray <erwan.leray@foss.st.com>
Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>

diff --git a/drivers/tty/serial/stm32-usart.c b/drivers/tty/serial/stm32-usart.c
index 223cec70c57c..370141445780 100644
--- a/drivers/tty/serial/stm32-usart.c
+++ b/drivers/tty/serial/stm32-usart.c
@@ -214,13 +214,18 @@ static void stm32_usart_receive_chars(struct uart_port *port, bool threaded)
 	struct tty_port *tport = &port->state->port;
 	struct stm32_port *stm32_port = to_stm32_port(port);
 	const struct stm32_usart_offsets *ofs = &stm32_port->info->ofs;
-	unsigned long c;
+	unsigned long c, flags;
 	u32 sr;
 	char flag;
 
 	if (irqd_is_wakeup_set(irq_get_irq_data(port->irq)))
 		pm_wakeup_event(tport->tty->dev, 0);
 
+	if (threaded)
+		spin_lock_irqsave(&port->lock, flags);
+	else
+		spin_lock(&port->lock);
+
 	while (stm32_usart_pending_rx(port, &sr, &stm32_port->last_res,
 				      threaded)) {
 		sr |= USART_SR_DUMMY_RX;
@@ -276,9 +281,12 @@ static void stm32_usart_receive_chars(struct uart_port *port, bool threaded)
 		uart_insert_char(port, sr, USART_SR_ORE, c, flag);
 	}
 
-	spin_unlock(&port->lock);
+	if (threaded)
+		spin_unlock_irqrestore(&port->lock, flags);
+	else
+		spin_unlock(&port->lock);
+
 	tty_flip_buffer_push(tport);
-	spin_lock(&port->lock);
 }
 
 static void stm32_usart_tx_dma_complete(void *arg)
@@ -459,8 +467,6 @@ static irqreturn_t stm32_usart_interrupt(int irq, void *ptr)
 	const struct stm32_usart_offsets *ofs = &stm32_port->info->ofs;
 	u32 sr;
 
-	spin_lock(&port->lock);
-
 	sr = readl_relaxed(port->membase + ofs->isr);
 
 	if ((sr & USART_SR_RTOF) && ofs->icr != UNDEF_REG)
@@ -474,10 +480,11 @@ static irqreturn_t stm32_usart_interrupt(int irq, void *ptr)
 	if ((sr & USART_SR_RXNE) && !(stm32_port->rx_ch))
 		stm32_usart_receive_chars(port, false);
 
-	if ((sr & USART_SR_TXE) && !(stm32_port->tx_ch))
+	if ((sr & USART_SR_TXE) && !(stm32_port->tx_ch)) {
+		spin_lock(&port->lock);
 		stm32_usart_transmit_chars(port);
-
-	spin_unlock(&port->lock);
+		spin_unlock(&port->lock);
+	}
 
 	if (stm32_port->rx_ch)
 		return IRQ_WAKE_THREAD;
@@ -490,13 +497,9 @@ static irqreturn_t stm32_usart_threaded_interrupt(int irq, void *ptr)
 	struct uart_port *port = ptr;
 	struct stm32_port *stm32_port = to_stm32_port(port);
 
-	spin_lock(&port->lock);
-
 	if (stm32_port->rx_ch)
 		stm32_usart_receive_chars(port, true);
 
-	spin_unlock(&port->lock);
-
 	return IRQ_HANDLED;
 }
 
-- 
2.17.1


Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 018C6C4332F
	for <linux-serial@archiver.kernel.org>; Fri, 16 Dec 2022 11:53:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230284AbiLPLx5 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 16 Dec 2022 06:53:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229905AbiLPLx4 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 16 Dec 2022 06:53:56 -0500
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71D7B2F670
        for <linux-serial@vger.kernel.org>; Fri, 16 Dec 2022 03:53:51 -0800 (PST)
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id A0EAE839D5;
        Fri, 16 Dec 2022 12:53:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1671191630;
        bh=2mCUSi2l1mAANnGndtPDX69+rLa/kGsnNIcZ7tM4MG8=;
        h=From:To:Cc:Subject:Date:From;
        b=Y6vHA4ZJnEo5dvItgrNDU4BWSpmBoegqQU9yJFjLlmsbfdysVhxed2Lho/S91KNeX
         kEp3tTvhWRutZ3eKsYLvVCZ9BawEK+Q14K+qFw0vIuaU985F7Vh5S5BCSMk0vNYWHi
         qjtEIOwkbwa2OFQJqhkGCmRO+kMT1sMQsYxnaXXD+DrTWdKEh5q8Vo6HGMlbZ5xXzH
         h4coIdNHSdURHjGhZ6SITRqhCL5ux158x+uoDuztZI4c2MDAwcmw0xTQM9TEu0keue
         DQNYBqObkd90GI0QHqbgprcImuj9H6oXNia6Ve6RUJcZsSik8Fvmj21Yi67hLUZGtL
         DFtpewhF6Zk+Q==
From:   Marek Vasut <marex@denx.de>
To:     linux-serial@vger.kernel.org
Cc:     Marek Vasut <marex@denx.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Erwan Le Ray <erwan.leray@foss.st.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Valentin Caron <valentin.caron@foss.st.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: [PATCH v3] serial: stm32: Merge hard IRQ and threaded IRQ handling into single IRQ handler
Date:   Fri, 16 Dec 2022 12:53:38 +0100
Message-Id: <20221216115338.7150-1-marex@denx.de>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.6 at phobos.denx.de
X-Virus-Status: Clean
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Requesting an interrupt with IRQF_ONESHOT will run the primary handler
in the hard-IRQ context even in the force-threaded mode. The
force-threaded mode is used by PREEMPT_RT in order to avoid acquiring
sleeping locks (spinlock_t) in hard-IRQ context. This combination
makes it impossible and leads to "sleeping while atomic" warnings.

Use one interrupt handler for both handlers (primary and secondary)
and drop the IRQF_ONESHOT flag which is not needed.

Fixes: e359b4411c283 ("serial: stm32: fix threaded interrupt handling")
Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: Erwan Le Ray <erwan.leray@foss.st.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Valentin Caron <valentin.caron@foss.st.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-stm32@st-md-mailman.stormreply.com
To: linux-serial@vger.kernel.org
---
V2: - Update patch subject, was:
      serial: stm32: Move hard IRQ handling to threaded interrupt context
    - Use request_irq() instead, rename the IRQ handler function
V3: - Update the commit message per suggestion from Sebastian
    - Add RB from Sebastian
    - Add Fixes tag
---
 drivers/tty/serial/stm32-usart.c | 29 +++++++----------------------
 1 file changed, 7 insertions(+), 22 deletions(-)

diff --git a/drivers/tty/serial/stm32-usart.c b/drivers/tty/serial/stm32-usart.c
index dfdbcf092facc..bbbab8dc2bfa9 100644
--- a/drivers/tty/serial/stm32-usart.c
+++ b/drivers/tty/serial/stm32-usart.c
@@ -752,8 +752,9 @@ static irqreturn_t stm32_usart_interrupt(int irq, void *ptr)
 	struct tty_port *tport = &port->state->port;
 	struct stm32_port *stm32_port = to_stm32_port(port);
 	const struct stm32_usart_offsets *ofs = &stm32_port->info->ofs;
-	u32 sr;
+	unsigned long flags;
 	unsigned int size;
+	u32 sr;
 
 	sr = readl_relaxed(port->membase + ofs->isr);
 
@@ -793,27 +794,13 @@ static irqreturn_t stm32_usart_interrupt(int irq, void *ptr)
 	}
 
 	if ((sr & USART_SR_TXE) && !(stm32_port->tx_ch)) {
-		spin_lock(&port->lock);
+		spin_lock_irqsave(&port->lock, flags);
 		stm32_usart_transmit_chars(port);
-		spin_unlock(&port->lock);
+		spin_unlock_irqrestore(&port->lock, flags);
 	}
 
-	if (stm32_usart_rx_dma_enabled(port))
-		return IRQ_WAKE_THREAD;
-	else
-		return IRQ_HANDLED;
-}
-
-static irqreturn_t stm32_usart_threaded_interrupt(int irq, void *ptr)
-{
-	struct uart_port *port = ptr;
-	struct tty_port *tport = &port->state->port;
-	struct stm32_port *stm32_port = to_stm32_port(port);
-	unsigned int size;
-	unsigned long flags;
-
 	/* Receiver timeout irq for DMA RX */
-	if (!stm32_port->throttled) {
+	if (stm32_usart_rx_dma_enabled(port) && !stm32_port->throttled) {
 		spin_lock_irqsave(&port->lock, flags);
 		size = stm32_usart_receive_chars(port, false);
 		uart_unlock_and_check_sysrq_irqrestore(port, flags);
@@ -1016,10 +1003,8 @@ static int stm32_usart_startup(struct uart_port *port)
 	u32 val;
 	int ret;
 
-	ret = request_threaded_irq(port->irq, stm32_usart_interrupt,
-				   stm32_usart_threaded_interrupt,
-				   IRQF_ONESHOT | IRQF_NO_SUSPEND,
-				   name, port);
+	ret = request_irq(port->irq, stm32_usart_interrupt,
+			  IRQF_NO_SUSPEND, name, port);
 	if (ret)
 		return ret;
 
-- 
2.35.1


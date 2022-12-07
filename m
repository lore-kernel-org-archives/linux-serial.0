Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35172C352A1
	for <linux-serial@archiver.kernel.org>; Wed,  7 Dec 2022 01:30:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229678AbiLGBaX (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 6 Dec 2022 20:30:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbiLGBaW (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 6 Dec 2022 20:30:22 -0500
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53BE251C3B
        for <linux-serial@vger.kernel.org>; Tue,  6 Dec 2022 17:30:20 -0800 (PST)
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 0506784D1B;
        Wed,  7 Dec 2022 02:30:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1670376618;
        bh=tohH7pypOcixeecmj/QIDjZpzcdcYtyplcrz2GHeoCw=;
        h=From:To:Cc:Subject:Date:From;
        b=awBEEh5FhfAEj7duplOYmgzthDJ8CuXyFbcQ+kAYkKo/P+RJzpuKlYf80sORbnZ1n
         uPB/HB3s4H9hLuDiHChcUi+pG+xEZvYC8tLXxiIdIofIF6NqZ8XZxsaRaLPHuopw9/
         2Z4wXEUt7jlHmb1hbptzOLS8H9H/29jhIiIM8az1pkFb84UnOvOSHfFxkdswhBkGqX
         uLK0fNgRGuUdqzpH5eMXkk7nW4TSZLjc+c0B7VvwDOjia+Bzi/BeESLlF3CkeYRgmS
         MFvDAP1+CJbvDsJFbC8V9SrCP08aCtUQrSZvpODDSdpPyWuHMK3kdG4LGKGutzcNWT
         De0gXhEMwV0LA==
From:   Marek Vasut <marex@denx.de>
To:     linux-serial@vger.kernel.org
Cc:     Marek Vasut <marex@denx.de>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Erwan Le Ray <erwan.leray@foss.st.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jean Philippe Romain <jean-philippe.romain@foss.st.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Valentin Caron <valentin.caron@foss.st.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: [PATCH] [RFC] serial: stm32: Move stm32_usart_transmit_chars() to interrupt thread
Date:   Wed,  7 Dec 2022 02:30:12 +0100
Message-Id: <20221207013012.395585-1-marex@denx.de>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.6 at phobos.denx.de
X-Virus-Status: Clean
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Avoid locking in hard interrupt context, move the stm32_usart_transmit_chars()
into the threaded IRQ handler. This fixes the following splat with preempt-rt:

 BUG: scheduling while atomic: (mount)/1289/0x00010001
 Modules linked in:
 Preemption disabled at:
 [<c0119127>] irq_enter_rcu+0xb/0x42
 CPU: 0 PID: 1289 Comm: (mount) Not tainted 6.1.0-rc7-rt5-stable-standard-00006-gd70aeccb9f0f #17
 Hardware name: STM32 (Device Tree Support)
  unwind_backtrace from show_stack+0xb/0xc
  show_stack from dump_stack_lvl+0x2b/0x34
  dump_stack_lvl from __schedule_bug+0x53/0x80
  __schedule_bug from __schedule+0x47/0x404
  __schedule from schedule_rtlock+0x15/0x34
  schedule_rtlock from rtlock_slowlock_locked+0x1d7/0x57e
  rtlock_slowlock_locked from rt_spin_lock+0x29/0x3c
  rt_spin_lock from stm32_usart_interrupt+0xa9/0x110
  stm32_usart_interrupt from __handle_irq_event_percpu+0x73/0x14e
  __handle_irq_event_percpu from handle_irq_event_percpu+0x9/0x22
  handle_irq_event_percpu from handle_irq_event+0x53/0x76
  handle_irq_event from handle_fasteoi_irq+0x65/0xa8
  handle_fasteoi_irq from handle_irq_desc+0xf/0x18
  handle_irq_desc from gic_handle_irq+0x45/0x54
  gic_handle_irq from generic_handle_arch_irq+0x19/0x2c
  generic_handle_arch_irq from call_with_stack+0xd/0x10

Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: Erwan Le Ray <erwan.leray@foss.st.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jean Philippe Romain <jean-philippe.romain@foss.st.com>
Cc: Jiri Slaby <jirislaby@kernel.org>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Valentin Caron <valentin.caron@foss.st.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-stm32@st-md-mailman.stormreply.com
To: linux-serial@vger.kernel.org
---
 drivers/tty/serial/stm32-usart.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/serial/stm32-usart.c b/drivers/tty/serial/stm32-usart.c
index a1490033aa164..56357a7962edc 100644
--- a/drivers/tty/serial/stm32-usart.c
+++ b/drivers/tty/serial/stm32-usart.c
@@ -791,11 +791,8 @@ static irqreturn_t stm32_usart_interrupt(int irq, void *ptr)
 		}
 	}
 
-	if ((sr & USART_SR_TXE) && !(stm32_port->tx_ch)) {
-		spin_lock(&port->lock);
-		stm32_usart_transmit_chars(port);
-		spin_unlock(&port->lock);
-	}
+	if ((sr & USART_SR_TXE) && !(stm32_port->tx_ch))
+		return IRQ_WAKE_THREAD;
 
 	if (stm32_usart_rx_dma_enabled(port))
 		return IRQ_WAKE_THREAD;
@@ -808,8 +805,18 @@ static irqreturn_t stm32_usart_threaded_interrupt(int irq, void *ptr)
 	struct uart_port *port = ptr;
 	struct tty_port *tport = &port->state->port;
 	struct stm32_port *stm32_port = to_stm32_port(port);
-	unsigned int size;
+	const struct stm32_usart_offsets *ofs = &stm32_port->info->ofs;
 	unsigned long flags;
+	unsigned int size;
+	u32 sr;
+
+	sr = readl_relaxed(port->membase + ofs->isr);
+
+	if ((sr & USART_SR_TXE) && !(stm32_port->tx_ch)) {
+		spin_lock_irqsave(&port->lock, flags);
+		stm32_usart_transmit_chars(port);
+		spin_unlock_irqrestore(&port->lock, flags);
+	}
 
 	/* Receiver timeout irq for DMA RX */
 	if (!stm32_port->throttled) {
-- 
2.35.1


Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 326A7C433ED
	for <linux-serial@archiver.kernel.org>; Fri, 16 Apr 2021 10:10:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 12594610FB
	for <linux-serial@archiver.kernel.org>; Fri, 16 Apr 2021 10:10:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239096AbhDPKLS (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 16 Apr 2021 06:11:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235372AbhDPKLR (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 16 Apr 2021 06:11:17 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1D74C061574;
        Fri, 16 Apr 2021 03:10:51 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id e8-20020a17090a7288b029014e51f5a6baso9076185pjg.2;
        Fri, 16 Apr 2021 03:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=A/7hIeNkh74sMxQ2VoT+6Wb/XxhlYBDSbBqmEWtFsMs=;
        b=c79qb3AjMlo1Z8G/mAYAiOnq/4a7c+i4Jom/W81ehb6DnIfKOzIBQiUIq9mKKAMARo
         PBgsd5rq5IVVGzuy+V+5HUabNdELc1rtuVP90E+ITMmpLsPr068Gm2BwTtIawqmQmTjU
         3kGxB3pPrbDah9+K2vEpCT2zbIa6t37VjzbTyDflz0xamHlE3yIH4p56JjyKWMt6+ZHQ
         Sj038Cnp4xo42nLHZmmlscTOzj7i4VXMk/FMmGDRy5R6rcrkSzwN6EEJDya0bQTq0GjG
         jhKRIa2iimZW61QRHZ5y/TVUt3OugdR/nI/2MkOGBVk3AxNaedM3opJpguEh1Hbmwudg
         beog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=A/7hIeNkh74sMxQ2VoT+6Wb/XxhlYBDSbBqmEWtFsMs=;
        b=rx/lR0uMcxWtIvHgqNq9NZaBjL++KAByHTzkmeMB0KDXohw0fIh/JD0AdIS7uxdwqY
         2Ccv1v/W317qxOa1SSiYwiHeABooeXHnxVZm1QbmaFVA3whNao/F/GB6tqXKC3hc4CWg
         XO2zn+/s/skkQPOZQDgU5jRAassD/eSNPJhVrq94hI7e04SRreQ3MpHBLyynJ0aM4SnL
         XJOPYOq8DNuWb1qm8MbUMdrjvMhpWI3GYycNazjhzC7ckGlDozxtIiThO60qqpZBNHvK
         As3kN++jiI8bWcO0/iqE3EMgZejS3zcte3YgA7VMEkV9sy+bh2+WqgseNaHHp/nIUJHu
         b5+A==
X-Gm-Message-State: AOAM531L3L67A9Nw6Bt90IMhHPSnr1zREMXdPu75Zx6kVX/3Y301+t9K
        wbTSJgjVq4hdgAOyERs+22Y=
X-Google-Smtp-Source: ABdhPJyL6O0IvkWzDC0x4hnKmxrsWJIdNewo78CdAaYdxeGULaN/XIlJR3v96Xo95TfHQscGqhU7Qw==
X-Received: by 2002:a17:90b:4a46:: with SMTP id lb6mr9025629pjb.45.1618567851417;
        Fri, 16 Apr 2021 03:10:51 -0700 (PDT)
Received: from fmin-OptiPlex-7060.nreal.work ([137.59.103.165])
        by smtp.gmail.com with ESMTPSA id t67sm4601440pfb.210.2021.04.16.03.10.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Apr 2021 03:10:46 -0700 (PDT)
From:   dillon.minfei@gmail.com
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
        lkp@intel.com, johan@kernel.org, gerald.baeza@foss.st.com,
        erwan.leray@foss.st.com
Cc:     linux-serial@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kbuild-all@lists.01.org, clang-built-linux@googlegroups.com,
        dillon min <dillon.minfei@gmail.com>
Subject: [PATCH v3] serial: stm32: optimize spin lock usage
Date:   Fri, 16 Apr 2021 18:10:41 +0800
Message-Id: <1618567841-18546-1-git-send-email-dillon.minfei@gmail.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: dillon min <dillon.minfei@gmail.com>

This patch aims to fix two potential bug:
- no lock to protect uart register in this case

  stm32_usart_threaded_interrupt()
     spin_lock(&port->lock);
     ...
     stm32_usart_receive_chars()
       uart_handle_sysrq_char();
       sysrq_function();
       printk();
         stm32_usart_console_write();
           locked = 0; //since port->sysrq is not zero,
                         no lock to protect forward register
                         access.

- if add spin_trylock_irqsave() to protect uart register for sysrq = 1 case,
  that might got recursive locking under UP.
  So, use uart_prepare_sysrq_char(), uart_unlock_and_check_sysrq()
  move sysrq handler position to irq/thread_d handler, just record
  sysrq_ch in stm32_usart_receive_chars() by uart_prepare_sysrq_char()
  delay the sysrq process to next interrupt handler.

  new flow:

  stm32_usart_threaded_interrupt()/stm32_usart_interrupt()
  spin_lock_irqsave(&port->lock);
  ...
  uart_unlock_and_check_sysrq();
     spin_unlock_irqrestore();
     handle_sysrq(sysrq_ch);
  stm32_usart_threaded_interrupt()//stm32_usart_interrupt() return

Cc: Johan Hovold <johan@kernel.org>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc: Gerald Baeza <gerald.baeza@foss.st.com>
Cc: Erwan Le Ray <erwan.leray@foss.st.com>
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: dillon min <dillon.minfei@gmail.com>
---
v3: add uart_prepare_sysrq_char(), uart_unlock_and_check_sysrq() to move
    sysrq handler inside interrupt routinei to avoid recursive locking,
    according to Johan Hovold suggestion, thanks.

 drivers/tty/serial/stm32-usart.c | 24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/drivers/tty/serial/stm32-usart.c b/drivers/tty/serial/stm32-usart.c
index b3675cf25a69..981f50ec784e 100644
--- a/drivers/tty/serial/stm32-usart.c
+++ b/drivers/tty/serial/stm32-usart.c
@@ -271,7 +271,7 @@ static void stm32_usart_receive_chars(struct uart_port *port, bool threaded)
 			}
 		}
 
-		if (uart_handle_sysrq_char(port, c))
+		if (uart_prepare_sysrq_char(port, c))
 			continue;
 		uart_insert_char(port, sr, USART_SR_ORE, c, flag);
 	}
@@ -457,9 +457,10 @@ static irqreturn_t stm32_usart_interrupt(int irq, void *ptr)
 	struct uart_port *port = ptr;
 	struct stm32_port *stm32_port = to_stm32_port(port);
 	const struct stm32_usart_offsets *ofs = &stm32_port->info->ofs;
+	unsigned long flags;
 	u32 sr;
 
-	spin_lock(&port->lock);
+	spin_lock_irqsave(&port->lock, flags);
 
 	sr = readl_relaxed(port->membase + ofs->isr);
 
@@ -477,7 +478,7 @@ static irqreturn_t stm32_usart_interrupt(int irq, void *ptr)
 	if ((sr & USART_SR_TXE) && !(stm32_port->tx_ch))
 		stm32_usart_transmit_chars(port);
 
-	spin_unlock(&port->lock);
+	uart_unlock_and_check_sysrq(port, flags);
 
 	if (stm32_port->rx_ch)
 		return IRQ_WAKE_THREAD;
@@ -489,13 +490,14 @@ static irqreturn_t stm32_usart_threaded_interrupt(int irq, void *ptr)
 {
 	struct uart_port *port = ptr;
 	struct stm32_port *stm32_port = to_stm32_port(port);
+	unsigned long flags;
 
-	spin_lock(&port->lock);
+	spin_lock_irqsave(&port->lock, flags);
 
 	if (stm32_port->rx_ch)
 		stm32_usart_receive_chars(port, true);
 
-	spin_unlock(&port->lock);
+	uart_unlock_and_check_sysrq(port, flags);
 
 	return IRQ_HANDLED;
 }
@@ -1354,13 +1356,10 @@ static void stm32_usart_console_write(struct console *co, const char *s,
 	u32 old_cr1, new_cr1;
 	int locked = 1;
 
-	local_irq_save(flags);
-	if (port->sysrq)
-		locked = 0;
-	else if (oops_in_progress)
-		locked = spin_trylock(&port->lock);
+	if (oops_in_progress)
+		locked = spin_trylock_irqsave(&port->lock, flags);
 	else
-		spin_lock(&port->lock);
+		spin_lock_irqsave(&port->lock, flags);
 
 	/* Save and disable interrupts, enable the transmitter */
 	old_cr1 = readl_relaxed(port->membase + ofs->cr1);
@@ -1374,8 +1373,7 @@ static void stm32_usart_console_write(struct console *co, const char *s,
 	writel_relaxed(old_cr1, port->membase + ofs->cr1);
 
 	if (locked)
-		spin_unlock(&port->lock);
-	local_irq_restore(flags);
+		spin_unlock_irqrestore(&port->lock, flags);
 }
 
 static int stm32_usart_console_setup(struct console *co, char *options)
-- 
2.7.4


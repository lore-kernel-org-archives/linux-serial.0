Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C08EC433ED
	for <linux-serial@archiver.kernel.org>; Mon, 12 Apr 2021 04:34:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0779B611C9
	for <linux-serial@archiver.kernel.org>; Mon, 12 Apr 2021 04:34:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229461AbhDLEep (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 12 Apr 2021 00:34:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbhDLEep (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 12 Apr 2021 00:34:45 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8127C061574;
        Sun, 11 Apr 2021 21:34:27 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id k8so8412825pgf.4;
        Sun, 11 Apr 2021 21:34:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=K4FzIBSzTsQ26tiQe4PAL44Y27//vbAmCEDS6LTwbEM=;
        b=DgBvVHftT42xTT0vc6hT9qUxbNBbvXuy/qYZYanVEzW5vP2DYbBKl5L2SB/sWFGveQ
         KdGhyuY+fVTMgL/mi6ZA1z6XEFH5rpiOSPJCwmCPJvCCaazANz7hfPN9j4jjYTLtStMP
         lK37lB6hjgeIyFvcS8vuqDpj0gCMks6fdZcS/E6kGqxdUOsrkRIcVxIJj+UzJVyQwr34
         dHGI9bohVJwepdoQIKA7m3vLiCuzSqtihSDBau9BueMbZC/p+U8yUUI/wWVh2NrJx1Mv
         1t8eYmIcpt1ZgJRa/ncPIqNPBWqYrwvrzZVpO5HwZT4hyOueX3EYiaajuVdyYSkb5sIj
         ZMdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=K4FzIBSzTsQ26tiQe4PAL44Y27//vbAmCEDS6LTwbEM=;
        b=EOE+8By/AdTlqb1b7k/7LelSIFEEih2KNunS34YUB343ITvAFyoWuGAyHQgbtxsP6h
         NO066qppqqJ3K1xDGRr+2It+P9UlA2z0jQSIcWO6woKhwxjwY9MFo3jvAk5iiswqfeme
         IPLifehIhxtius1IKr5v57LIVPr3CIJ8IKLFz0nJEuWkT+gWWeRDxGfUy1KgEZEQ+XfA
         JW5T0U4t0gTRbLGudLfbKpJmSTk854FceZMtTYg6Oi/KxTjPtHJJNZllXiIJTQNUUsXn
         NJ3wXI3gxXvog4F0gY/Z9J0bBTHfbT77dQUxPJZ9GyBPftI4SngkgenHiwuE/6jdx5NZ
         MsMA==
X-Gm-Message-State: AOAM530BQq8VCOESFPJx1kCwNti+tcvo9TKhgUAwcvSE2aDvIwF99Tbp
        A1z9mjDEGVQ9gUUgo0er0kqBx0y2Rvs6BqFm
X-Google-Smtp-Source: ABdhPJyC9TZOi5ElW12Bo8Vkj6uRwcHCKeSZXzF3Rubx1D6zPTP1D29tM+y7o5O0TK3VlvylLTYESQ==
X-Received: by 2002:a63:dd14:: with SMTP id t20mr24986189pgg.258.1618202067450;
        Sun, 11 Apr 2021 21:34:27 -0700 (PDT)
Received: from fmin-OptiPlex-7060.nreal.work ([137.59.103.165])
        by smtp.gmail.com with ESMTPSA id o13sm9777411pgv.40.2021.04.11.21.34.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 11 Apr 2021 21:34:26 -0700 (PDT)
From:   dillon.minfei@gmail.com
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com
Cc:     linux-serial@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        dillon min <dillon.minfei@gmail.com>
Subject: [PATCH] serial: stm32: optimize spin lock usage
Date:   Mon, 12 Apr 2021 12:34:21 +0800
Message-Id: <1618202061-8243-1-git-send-email-dillon.minfei@gmail.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: dillon min <dillon.minfei@gmail.com>

To avoid potential deadlock in spin_lock usage, change to use
spin_lock_irqsave(), spin_unlock_irqrestore() in process(thread_fn) context.
spin_lock(), spin_unlock() under handler context.

remove unused local_irq_save/restore call.

Signed-off-by: dillon min <dillon.minfei@gmail.com>
---
Was verified on stm32f469-disco board. need more test on stm32mp platform.

 drivers/tty/serial/stm32-usart.c | 27 +++++++++++++++++----------
 1 file changed, 17 insertions(+), 10 deletions(-)

diff --git a/drivers/tty/serial/stm32-usart.c b/drivers/tty/serial/stm32-usart.c
index b3675cf25a69..c4c859b34367 100644
--- a/drivers/tty/serial/stm32-usart.c
+++ b/drivers/tty/serial/stm32-usart.c
@@ -214,7 +214,7 @@ static void stm32_usart_receive_chars(struct uart_port *port, bool threaded)
 	struct tty_port *tport = &port->state->port;
 	struct stm32_port *stm32_port = to_stm32_port(port);
 	const struct stm32_usart_offsets *ofs = &stm32_port->info->ofs;
-	unsigned long c;
+	unsigned long c, flags;
 	u32 sr;
 	char flag;
 
@@ -276,9 +276,17 @@ static void stm32_usart_receive_chars(struct uart_port *port, bool threaded)
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
+
+	if (threaded)
+		spin_lock_irqsave(&port->lock, flags);
+	else
+		spin_lock(&port->lock);
 }
 
 static void stm32_usart_tx_dma_complete(void *arg)
@@ -489,13 +497,14 @@ static irqreturn_t stm32_usart_threaded_interrupt(int irq, void *ptr)
 {
 	struct uart_port *port = ptr;
 	struct stm32_port *stm32_port = to_stm32_port(port);
+	unsigned long flags;
 
-	spin_lock(&port->lock);
+	spin_lock_irqsave(&port->lock, flags);
 
 	if (stm32_port->rx_ch)
 		stm32_usart_receive_chars(port, true);
 
-	spin_unlock(&port->lock);
+	spin_unlock_irqrestore(&port->lock, flags);
 
 	return IRQ_HANDLED;
 }
@@ -1354,13 +1363,12 @@ static void stm32_usart_console_write(struct console *co, const char *s,
 	u32 old_cr1, new_cr1;
 	int locked = 1;
 
-	local_irq_save(flags);
 	if (port->sysrq)
 		locked = 0;
 	else if (oops_in_progress)
-		locked = spin_trylock(&port->lock);
+		locked = spin_trylock_irqsave(&port->lock, flags);
 	else
-		spin_lock(&port->lock);
+		spin_lock_irqsave(&port->lock, flags);
 
 	/* Save and disable interrupts, enable the transmitter */
 	old_cr1 = readl_relaxed(port->membase + ofs->cr1);
@@ -1374,8 +1382,7 @@ static void stm32_usart_console_write(struct console *co, const char *s,
 	writel_relaxed(old_cr1, port->membase + ofs->cr1);
 
 	if (locked)
-		spin_unlock(&port->lock);
-	local_irq_restore(flags);
+		spin_unlock_irqrestore(&port->lock, flags);
 }
 
 static int stm32_usart_console_setup(struct console *co, char *options)
-- 
2.7.4


Return-Path: <SRS0=EuFA=BA=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0967AC433E6
	for <linux-serial@archiver.kernel.org>; Tue, 21 Jul 2020 12:11:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D20DB206E9
	for <linux-serial@archiver.kernel.org>; Tue, 21 Jul 2020 12:11:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="C+YljNqf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729782AbgGUMLG (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 21 Jul 2020 08:11:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729718AbgGUMLF (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 21 Jul 2020 08:11:05 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1AD5C0619D9
        for <linux-serial@vger.kernel.org>; Tue, 21 Jul 2020 05:11:05 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id z5so11860217pgb.6
        for <linux-serial@vger.kernel.org>; Tue, 21 Jul 2020 05:11:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=OGQRgVBuDs2YGom8JxN4Q6Y+XwAeTFKd4PRQsmAWmzk=;
        b=C+YljNqfo+m3jtYr5ucEEoBYZHGPJbJaYid6dRHAr3tg1SE4+PBla45YLdd3dzeAHV
         90eRRECKtqlWsTY5czSJlAD1vbdg7ui2zXs9SHToZ6XnExMoNPkSDk+ML6y5WMAiy/ZD
         mDdVglWsqvth6SRd/6q3aFFQsxwYNgryrerakMMD+NV6wrDxUFLEeKNiqogb/3o2KXkd
         u6VZ1ra+OywG31748fw9BXQkhU0S+LSiBUwohiti/NQQReJsbeDTqHTcaP2NTmtdYEnC
         DTBsy6kLBZAlelpCT8CxjgLWv9tbmZYh7QoBm1TGYKc7xtGEbI5j8iw64L4vOMCRB4rF
         oCTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=OGQRgVBuDs2YGom8JxN4Q6Y+XwAeTFKd4PRQsmAWmzk=;
        b=ZwMT1ZGhKYeQjmaRejAeyqx655dsT5dxzJFp4tEDcX5yLdhgpCz8SSfgriLQ5cORNs
         d8fZdusJjAsuAxFIdsKSl4cH9Z5iqVF5Wo0CB6gowYuMS0dzI4OnG0SUVhdvLt/udUoP
         bywnqpHGCtcpBYHd68SvVIvb++K5n9qGCXYMa5T269WeYxRaZdnN6TCcpAkX4EYuiVoX
         L75QUaPTeQv4GCgA5EH/NE8/sMLJfME04DpAFVRkyE12ZbYF9KpmPnK6BpMyXq0sXPbB
         cUVD1s/pAGkttaHxfzL5pN7fPVqIJiSgvulrPiIwwFVuBgN5HkKpNAgTSl2HEwBzoJsr
         6bOg==
X-Gm-Message-State: AOAM533WI80uZM6L3BjN/398XD1818pYh1UzrPVeQ2mVUF8TKUV6BIJD
        lFLS/yypePVuljSt10TyPQRAMg==
X-Google-Smtp-Source: ABdhPJwbPLE5qE6oDrg12B+GPfjB19fSVE5EYiyAwJo6+g7xrMU3f6F7QpxgLLkrhSFzZ1GWjG8yLw==
X-Received: by 2002:a63:f254:: with SMTP id d20mr15590929pgk.119.1595333465291;
        Tue, 21 Jul 2020 05:11:05 -0700 (PDT)
Received: from localhost.localdomain ([117.210.211.74])
        by smtp.gmail.com with ESMTPSA id w9sm20601992pfq.178.2020.07.21.05.11.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Jul 2020 05:11:04 -0700 (PDT)
From:   Sumit Garg <sumit.garg@linaro.org>
To:     gregkh@linuxfoundation.org, daniel.thompson@linaro.org,
        dianders@chromium.org, linux-serial@vger.kernel.org,
        kgdb-bugreport@lists.sourceforge.net
Cc:     jslaby@suse.com, linux@armlinux.org.uk, jason.wessel@windriver.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Sumit Garg <sumit.garg@linaro.org>
Subject: [RFC 3/5] serial: amba-pl011: Re-order APIs definition
Date:   Tue, 21 Jul 2020 17:40:11 +0530
Message-Id: <1595333413-30052-4-git-send-email-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1595333413-30052-1-git-send-email-sumit.garg@linaro.org>
References: <1595333413-30052-1-git-send-email-sumit.garg@linaro.org>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

A future patch will need to call pl011_hwinit() and
pl011_enable_interrupts() before they are currently defined. Move
them closer to the front of the file. There is no change in the
implementation of either function.

Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
---
 drivers/tty/serial/amba-pl011.c | 148 ++++++++++++++++++++--------------------
 1 file changed, 74 insertions(+), 74 deletions(-)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index 8efd7c2..0983c5e 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -1581,6 +1581,80 @@ static void pl011_break_ctl(struct uart_port *port, int break_state)
 	spin_unlock_irqrestore(&uap->port.lock, flags);
 }
 
+static int pl011_hwinit(struct uart_port *port)
+{
+	struct uart_amba_port *uap =
+	    container_of(port, struct uart_amba_port, port);
+	int retval;
+
+	/* Optionaly enable pins to be muxed in and configured */
+	pinctrl_pm_select_default_state(port->dev);
+
+	/*
+	 * Try to enable the clock producer.
+	 */
+	retval = clk_prepare_enable(uap->clk);
+	if (retval)
+		return retval;
+
+	uap->port.uartclk = clk_get_rate(uap->clk);
+
+	/* Clear pending error and receive interrupts */
+	pl011_write(UART011_OEIS | UART011_BEIS | UART011_PEIS |
+		    UART011_FEIS | UART011_RTIS | UART011_RXIS,
+		    uap, REG_ICR);
+
+	/*
+	 * Save interrupts enable mask, and enable RX interrupts in case if
+	 * the interrupt is used for NMI entry.
+	 */
+	uap->im = pl011_read(uap, REG_IMSC);
+	pl011_write(UART011_RTIM | UART011_RXIM, uap, REG_IMSC);
+
+	if (dev_get_platdata(uap->port.dev)) {
+		struct amba_pl011_data *plat;
+
+		plat = dev_get_platdata(uap->port.dev);
+		if (plat->init)
+			plat->init();
+	}
+	return 0;
+}
+
+/*
+ * Enable interrupts, only timeouts when using DMA
+ * if initial RX DMA job failed, start in interrupt mode
+ * as well.
+ */
+static void pl011_enable_interrupts(struct uart_amba_port *uap)
+{
+	unsigned int i;
+
+	spin_lock_irq(&uap->port.lock);
+
+	/* Clear out any spuriously appearing RX interrupts */
+	pl011_write(UART011_RTIS | UART011_RXIS, uap, REG_ICR);
+
+	/*
+	 * RXIS is asserted only when the RX FIFO transitions from below
+	 * to above the trigger threshold.  If the RX FIFO is already
+	 * full to the threshold this can't happen and RXIS will now be
+	 * stuck off.  Drain the RX FIFO explicitly to fix this:
+	 */
+	for (i = 0; i < uap->fifosize * 2; ++i) {
+		if (pl011_read(uap, REG_FR) & UART01x_FR_RXFE)
+			break;
+
+		pl011_read(uap, REG_DR);
+	}
+
+	uap->im = UART011_RTIM;
+	if (!pl011_dma_rx_running(uap))
+		uap->im |= UART011_RXIM;
+	pl011_write(uap->im, uap, REG_IMSC);
+	spin_unlock_irq(&uap->port.lock);
+}
+
 #ifdef CONFIG_CONSOLE_POLL
 
 static void pl011_quiesce_irqs(struct uart_port *port)
@@ -1639,46 +1713,6 @@ static void pl011_put_poll_char(struct uart_port *port,
 
 #endif /* CONFIG_CONSOLE_POLL */
 
-static int pl011_hwinit(struct uart_port *port)
-{
-	struct uart_amba_port *uap =
-	    container_of(port, struct uart_amba_port, port);
-	int retval;
-
-	/* Optionaly enable pins to be muxed in and configured */
-	pinctrl_pm_select_default_state(port->dev);
-
-	/*
-	 * Try to enable the clock producer.
-	 */
-	retval = clk_prepare_enable(uap->clk);
-	if (retval)
-		return retval;
-
-	uap->port.uartclk = clk_get_rate(uap->clk);
-
-	/* Clear pending error and receive interrupts */
-	pl011_write(UART011_OEIS | UART011_BEIS | UART011_PEIS |
-		    UART011_FEIS | UART011_RTIS | UART011_RXIS,
-		    uap, REG_ICR);
-
-	/*
-	 * Save interrupts enable mask, and enable RX interrupts in case if
-	 * the interrupt is used for NMI entry.
-	 */
-	uap->im = pl011_read(uap, REG_IMSC);
-	pl011_write(UART011_RTIM | UART011_RXIM, uap, REG_IMSC);
-
-	if (dev_get_platdata(uap->port.dev)) {
-		struct amba_pl011_data *plat;
-
-		plat = dev_get_platdata(uap->port.dev);
-		if (plat->init)
-			plat->init();
-	}
-	return 0;
-}
-
 static bool pl011_split_lcrh(const struct uart_amba_port *uap)
 {
 	return pl011_reg_to_offset(uap, REG_LCRH_RX) !=
@@ -1707,40 +1741,6 @@ static int pl011_allocate_irq(struct uart_amba_port *uap)
 	return request_irq(uap->port.irq, pl011_int, IRQF_SHARED, "uart-pl011", uap);
 }
 
-/*
- * Enable interrupts, only timeouts when using DMA
- * if initial RX DMA job failed, start in interrupt mode
- * as well.
- */
-static void pl011_enable_interrupts(struct uart_amba_port *uap)
-{
-	unsigned int i;
-
-	spin_lock_irq(&uap->port.lock);
-
-	/* Clear out any spuriously appearing RX interrupts */
-	pl011_write(UART011_RTIS | UART011_RXIS, uap, REG_ICR);
-
-	/*
-	 * RXIS is asserted only when the RX FIFO transitions from below
-	 * to above the trigger threshold.  If the RX FIFO is already
-	 * full to the threshold this can't happen and RXIS will now be
-	 * stuck off.  Drain the RX FIFO explicitly to fix this:
-	 */
-	for (i = 0; i < uap->fifosize * 2; ++i) {
-		if (pl011_read(uap, REG_FR) & UART01x_FR_RXFE)
-			break;
-
-		pl011_read(uap, REG_DR);
-	}
-
-	uap->im = UART011_RTIM;
-	if (!pl011_dma_rx_running(uap))
-		uap->im |= UART011_RXIM;
-	pl011_write(uap->im, uap, REG_IMSC);
-	spin_unlock_irq(&uap->port.lock);
-}
-
 static int pl011_startup(struct uart_port *port)
 {
 	struct uart_amba_port *uap =
-- 
2.7.4


Return-Path: <SRS0=EuFA=BA=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C54F9C433E0
	for <linux-serial@archiver.kernel.org>; Tue, 21 Jul 2020 12:11:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D98A2080D
	for <linux-serial@archiver.kernel.org>; Tue, 21 Jul 2020 12:11:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qCxiWVCI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728711AbgGUMLM (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 21 Jul 2020 08:11:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727106AbgGUMLL (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 21 Jul 2020 08:11:11 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA5FFC061794
        for <linux-serial@vger.kernel.org>; Tue, 21 Jul 2020 05:11:11 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id d4so11853596pgk.4
        for <linux-serial@vger.kernel.org>; Tue, 21 Jul 2020 05:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2zOkNlooR1zcsl5ai3d/r17122nHEKv/dFvwHU/KZrA=;
        b=qCxiWVCIYBZyxLsMeE0w7kCkNJoBZ7QRMGqB8iz9+cZylR3Kxiuii46cbejMIY5/Np
         ZPzpH/PyZvdzSoaoO7jzVg7fQcXnSQx4/lfSr/0aek5vJ/moI57rKq5+4cqL+06Q6siA
         ziJkw20K+BOosurBJ8w5GtJj6skjC3rNixycBb+zVpuP1yXWrvoEsRM3SArliy201rSc
         Kmlz87fkvx+pqm6TXR7sILSVPWtN5AMhcvfyLkpHxVnnib/39NDu7LBfAoHjxHNspceS
         kmhG+kH5t7cmNe14hfKOHg7LeuJT4Q0m0CwyhqWLQqnc3T6DfETzD4UG11CpF2kCND1/
         Dc5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2zOkNlooR1zcsl5ai3d/r17122nHEKv/dFvwHU/KZrA=;
        b=GcUtGJYVBEVMQcnEu3p5Ybxqam3bBQmFufm4vMIAZuj5XIXVrIEDQRzsGRVyO6nInH
         7fvj1zxYBu7apOrBeKI7dpZfGxi0+8SfoAiKd1HJcFB0FUi0H6XFONk57WfHomT65sU0
         YKoyPeoOciclH1hnBLqOS7cbSQ2Ux1Ba91O5EY0uZUkAjV7IZbOiu/rNKRBcmB31fOVS
         5egb/iUcB+5faBiMygUpzFcAbY3vVFuYAzS/eSPDCypZfAY3kyvYxv4uX8dBSkTqXOKl
         9Kmk1D5PbCd460NIAxa2G6PLfw8Wiv0C2ZPxVK5AZnfldf5pXr53DWXOT89n2DaNufx2
         /Zjw==
X-Gm-Message-State: AOAM530/otMsuKiHx8zGy6/segSJy+S2z+Zbdh2Q/bvWSuoekpXYP0cZ
        qyWw0mK4NzxFPvtbW0C5BAOXxWo32qM=
X-Google-Smtp-Source: ABdhPJwKUmsn6lRMXYTYzTogmHp0PD64aIq6+1XW2ha8ClQcPj9F4Yp1/qWxe7LuhU7j6OSsyTNzkg==
X-Received: by 2002:a05:6a00:2292:: with SMTP id f18mr24239679pfe.192.1595333471193;
        Tue, 21 Jul 2020 05:11:11 -0700 (PDT)
Received: from localhost.localdomain ([117.210.211.74])
        by smtp.gmail.com with ESMTPSA id w9sm20601992pfq.178.2020.07.21.05.11.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Jul 2020 05:11:10 -0700 (PDT)
From:   Sumit Garg <sumit.garg@linaro.org>
To:     gregkh@linuxfoundation.org, daniel.thompson@linaro.org,
        dianders@chromium.org, linux-serial@vger.kernel.org,
        kgdb-bugreport@lists.sourceforge.net
Cc:     jslaby@suse.com, linux@armlinux.org.uk, jason.wessel@windriver.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Sumit Garg <sumit.garg@linaro.org>
Subject: [RFC 4/5] serial: amba-pl011: Enable NMI aware uart port
Date:   Tue, 21 Jul 2020 17:40:12 +0530
Message-Id: <1595333413-30052-5-git-send-email-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1595333413-30052-1-git-send-email-sumit.garg@linaro.org>
References: <1595333413-30052-1-git-send-email-sumit.garg@linaro.org>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Allow serial device interrupt to be requested as an NMI during
initialization in polling mode. If the irqchip doesn't support serial
device interrupt as an NMI then fallback to it being as a normal IRQ.

Currently this NMI aware uart port only supports NMI driven programmed
IO operation whereas DMA operation isn't supported.

And while operating in NMI mode, RX always remains active irrespective
of whether corresponding TTY port is active or not. So we directly bail
out of startup, shutdown and rx_stop APIs if NMI mode is active.

Also, get rid of modification to interrupts enable mask in pl011_hwinit()
as now we have a proper way to enable interrupts for NMI entry using
pl011_enable_interrupts().

Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
---
 drivers/tty/serial/amba-pl011.c | 124 ++++++++++++++++++++++++++++++++++++----
 1 file changed, 113 insertions(+), 11 deletions(-)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index 0983c5e..5df1c07 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -41,6 +41,8 @@
 #include <linux/sizes.h>
 #include <linux/io.h>
 #include <linux/acpi.h>
+#include <linux/irq.h>
+#include <linux/irqdesc.h>
 
 #include "amba-pl011.h"
 
@@ -347,6 +349,10 @@ static int pl011_fifo_to_tty(struct uart_amba_port *uap)
 		if (uart_handle_sysrq_char(&uap->port, ch & 255))
 			continue;
 
+		if (uart_nmi_handle_char(&uap->port, ch, UART011_DR_OE, ch,
+					 flag))
+			continue;
+
 		uart_insert_char(&uap->port, ch, UART011_DR_OE, ch, flag);
 	}
 
@@ -1316,6 +1322,9 @@ static void pl011_stop_rx(struct uart_port *port)
 	struct uart_amba_port *uap =
 	    container_of(port, struct uart_amba_port, port);
 
+	if (uart_nmi_active(port))
+		return;
+
 	uap->im &= ~(UART011_RXIM|UART011_RTIM|UART011_FEIM|
 		     UART011_PEIM|UART011_BEIM|UART011_OEIM);
 	pl011_write(uap->im, uap, REG_IMSC);
@@ -1604,13 +1613,6 @@ static int pl011_hwinit(struct uart_port *port)
 		    UART011_FEIS | UART011_RTIS | UART011_RXIS,
 		    uap, REG_ICR);
 
-	/*
-	 * Save interrupts enable mask, and enable RX interrupts in case if
-	 * the interrupt is used for NMI entry.
-	 */
-	uap->im = pl011_read(uap, REG_IMSC);
-	pl011_write(UART011_RTIM | UART011_RXIM, uap, REG_IMSC);
-
 	if (dev_get_platdata(uap->port.dev)) {
 		struct amba_pl011_data *plat;
 
@@ -1711,6 +1713,96 @@ static void pl011_put_poll_char(struct uart_port *port,
 	pl011_write(ch, uap, REG_DR);
 }
 
+static irqreturn_t pl011_nmi_int(int irq, void *dev_id)
+{
+	struct uart_amba_port *uap = dev_id;
+	unsigned int status, pass_counter = AMBA_ISR_PASS_LIMIT;
+	int handled = 0;
+
+	status = pl011_read(uap, REG_MIS);
+	if (status) {
+		do {
+			check_apply_cts_event_workaround(uap);
+
+			pl011_write(status, uap, REG_ICR);
+
+			if (status & (UART011_RTIS|UART011_RXIS)) {
+				pl011_fifo_to_tty(uap);
+				irq_work_queue(&uap->port.nmi_state.rx_work);
+			}
+
+			if (status & UART011_TXIS)
+				irq_work_queue(&uap->port.nmi_state.tx_work);
+
+			if (pass_counter-- == 0)
+				break;
+
+			status = pl011_read(uap, REG_MIS);
+		} while (status != 0);
+		handled = 1;
+	}
+
+	return IRQ_RETVAL(handled);
+}
+
+static int pl011_allocate_nmi(struct uart_amba_port *uap)
+{
+	int ret;
+
+	irq_set_status_flags(uap->port.irq, IRQ_NOAUTOEN);
+	ret = request_nmi(uap->port.irq, pl011_nmi_int, IRQF_PERCPU,
+			  "uart-pl011", uap);
+	if (ret) {
+		irq_clear_status_flags(uap->port.irq, IRQ_NOAUTOEN);
+		return ret;
+	}
+
+	enable_irq(uap->port.irq);
+
+	return ret;
+}
+
+static void pl011_tx_irq_callback(struct uart_port *port)
+{
+	struct uart_amba_port *uap =
+	    container_of(port, struct uart_amba_port, port);
+
+	spin_lock(&port->lock);
+	pl011_tx_chars(uap, true);
+	spin_unlock(&port->lock);
+}
+
+static int pl011_poll_init(struct uart_port *port)
+{
+	struct uart_amba_port *uap =
+	    container_of(port, struct uart_amba_port, port);
+	int retval;
+
+	retval = pl011_hwinit(port);
+	if (retval)
+		goto clk_dis;
+
+	/* In case NMI isn't supported, fallback to normal interrupt mode */
+	retval = pl011_allocate_nmi(uap);
+	if (retval)
+		return 0;
+
+	retval = uart_nmi_state_init(port);
+	if (retval)
+		goto clk_dis;
+
+	port->nmi_state.tx_irq_callback = pl011_tx_irq_callback;
+	uart_set_nmi_active(port, true);
+
+	pl011_enable_interrupts(uap);
+
+	return 0;
+
+ clk_dis:
+	clk_disable_unprepare(uap->clk);
+	return retval;
+}
+
 #endif /* CONFIG_CONSOLE_POLL */
 
 static bool pl011_split_lcrh(const struct uart_amba_port *uap)
@@ -1736,8 +1828,6 @@ static void pl011_write_lcr_h(struct uart_amba_port *uap, unsigned int lcr_h)
 
 static int pl011_allocate_irq(struct uart_amba_port *uap)
 {
-	pl011_write(uap->im, uap, REG_IMSC);
-
 	return request_irq(uap->port.irq, pl011_int, IRQF_SHARED, "uart-pl011", uap);
 }
 
@@ -1748,6 +1838,9 @@ static int pl011_startup(struct uart_port *port)
 	unsigned int cr;
 	int retval;
 
+	if (uart_nmi_active(port))
+		return 0;
+
 	retval = pl011_hwinit(port);
 	if (retval)
 		goto clk_dis;
@@ -1790,6 +1883,9 @@ static int sbsa_uart_startup(struct uart_port *port)
 		container_of(port, struct uart_amba_port, port);
 	int retval;
 
+	if (uart_nmi_active(port))
+		return 0;
+
 	retval = pl011_hwinit(port);
 	if (retval)
 		return retval;
@@ -1859,6 +1955,9 @@ static void pl011_shutdown(struct uart_port *port)
 	struct uart_amba_port *uap =
 		container_of(port, struct uart_amba_port, port);
 
+	if (uart_nmi_active(port))
+		return;
+
 	pl011_disable_interrupts(uap);
 
 	pl011_dma_shutdown(uap);
@@ -1891,6 +1990,9 @@ static void sbsa_uart_shutdown(struct uart_port *port)
 	struct uart_amba_port *uap =
 		container_of(port, struct uart_amba_port, port);
 
+	if (uart_nmi_active(port))
+		return;
+
 	pl011_disable_interrupts(uap);
 
 	free_irq(uap->port.irq, uap);
@@ -2142,7 +2244,7 @@ static const struct uart_ops amba_pl011_pops = {
 	.config_port	= pl011_config_port,
 	.verify_port	= pl011_verify_port,
 #ifdef CONFIG_CONSOLE_POLL
-	.poll_init     = pl011_hwinit,
+	.poll_init     = pl011_poll_init,
 	.poll_get_char = pl011_get_poll_char,
 	.poll_put_char = pl011_put_poll_char,
 #endif
@@ -2173,7 +2275,7 @@ static const struct uart_ops sbsa_uart_pops = {
 	.config_port	= pl011_config_port,
 	.verify_port	= pl011_verify_port,
 #ifdef CONFIG_CONSOLE_POLL
-	.poll_init     = pl011_hwinit,
+	.poll_init     = pl011_poll_init,
 	.poll_get_char = pl011_get_poll_char,
 	.poll_put_char = pl011_put_poll_char,
 #endif
-- 
2.7.4


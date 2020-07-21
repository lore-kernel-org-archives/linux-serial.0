Return-Path: <SRS0=EuFA=BA=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 748C6C433DF
	for <linux-serial@archiver.kernel.org>; Tue, 21 Jul 2020 12:11:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 482612080D
	for <linux-serial@archiver.kernel.org>; Tue, 21 Jul 2020 12:11:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BuARnLyS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729009AbgGUMLB (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 21 Jul 2020 08:11:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728714AbgGUMLA (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 21 Jul 2020 08:11:00 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DC8EC0619D9
        for <linux-serial@vger.kernel.org>; Tue, 21 Jul 2020 05:11:00 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id b9so10182707plx.6
        for <linux-serial@vger.kernel.org>; Tue, 21 Jul 2020 05:11:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jQ4rDDgYanuVEiD5VSyVtoHbMEWpqen32aI8GMWnA+0=;
        b=BuARnLySFYXHobk+DJzYYbZapFac75rnp2cAzZUyk+Gi1xEuU1EKVS1Y1ft+eSIwcL
         vUQ65Nj4hj0gbP6KuHvpVQ1/mKEqee4c+RYlKvvGEkqecq5lPOYvBC/pKxqWrs/xvNuX
         ConaNJol+yJAMDTJi84K9crZw28bIZdQhev3sLhB3gqdVEqEs55lxbxIv8OArsnDnGfV
         CCpC7mpvvk9RD+YSf+d/FvJn9J02mMZZ+jD96+Ckm7JLj1B7A4Q+80Q9XsJ0Ztb2vljT
         r9PD1tKl8MrmBZAm8XG6xSQLyTNYFft4pqHRY1+16emo3h9Q8zs9U0cfGItOz/xXjY0v
         cfHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jQ4rDDgYanuVEiD5VSyVtoHbMEWpqen32aI8GMWnA+0=;
        b=mitnixc+mUfp7el/nXU6y0LqrboIdrBVnBDURW5lNJssGxCcuZcdzZJPXxoyAxe3Wm
         5g0SCAK3/LUjnqEnpNVNUFVVQRIKVAPJ6JCPSdZ+SxU+xWzkx9W1Dsq6/9/30F5eZEGD
         cmz9TVbAob4QtBRT/W98H2Usnb4t2ZEY1oQQiPO1O6XxW9YTh27bsz02GyEop/8SF+7O
         WM6nxWuqnyaEUW9XR6AHzS2omIGMvi1chrQxCEAONsKkIHxdivRzhtnjh9QiWRZBjkCr
         hN3RLQ1gkiEr0rgdkZAFu8HsxIF8pJ14EDuNAOsrftOOa0ZCadYtIrlc9zAwEl97pUX8
         osow==
X-Gm-Message-State: AOAM532IGrxYb3JmLO7PTSGPtEFlb0vs/j2wuTVDDi14VYlRwXdoA1tV
        Z0CMMbhWk+/2rH0kHqCZn5Wqdg==
X-Google-Smtp-Source: ABdhPJwuz8QK1fPNOpZalpAeTbf4LEUS9VjUfrRfr1RCUAvdtOBgLm3oRTOaw/15VbGU7Sm1GM7DZg==
X-Received: by 2002:a17:902:a9c8:: with SMTP id b8mr22299780plr.2.1595333459711;
        Tue, 21 Jul 2020 05:10:59 -0700 (PDT)
Received: from localhost.localdomain ([117.210.211.74])
        by smtp.gmail.com with ESMTPSA id w9sm20601992pfq.178.2020.07.21.05.10.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Jul 2020 05:10:58 -0700 (PDT)
From:   Sumit Garg <sumit.garg@linaro.org>
To:     gregkh@linuxfoundation.org, daniel.thompson@linaro.org,
        dianders@chromium.org, linux-serial@vger.kernel.org,
        kgdb-bugreport@lists.sourceforge.net
Cc:     jslaby@suse.com, linux@armlinux.org.uk, jason.wessel@windriver.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Sumit Garg <sumit.garg@linaro.org>
Subject: [RFC 2/5] serial: core: Add framework to allow NMI aware serial drivers
Date:   Tue, 21 Jul 2020 17:40:10 +0530
Message-Id: <1595333413-30052-3-git-send-email-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1595333413-30052-1-git-send-email-sumit.garg@linaro.org>
References: <1595333413-30052-1-git-send-email-sumit.garg@linaro.org>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Add NMI framework APIs in serial core which can be leveraged by serial
drivers to have NMI driven serial transfers. These APIs are kept under
CONFIG_CONSOLE_POLL as currently kgdb initializing uart in polling mode
is the only known user to enable NMI driven serial port.

The general idea is to intercept RX characters in NMI context, if those
are specific to magic sysrq then allow corresponding handler to run in
NMI context. Otherwise defer all other RX and TX operations to IRQ work
queue in order to run those in normal interrupt context.

Also, since magic sysrq entry APIs will need to be invoked from NMI
context, so make those APIs NMI safe via deferring NMI unsafe work to
IRQ work queue.

Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
---
 drivers/tty/serial/serial_core.c | 120 ++++++++++++++++++++++++++++++++++++++-
 include/linux/serial_core.h      |  67 ++++++++++++++++++++++
 2 files changed, 185 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 57840cf..6342e90 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -3181,8 +3181,14 @@ static bool uart_try_toggle_sysrq(struct uart_port *port, unsigned int ch)
 		return true;
 	}
 
+#ifdef CONFIG_CONSOLE_POLL
+	if (in_nmi())
+		irq_work_queue(&port->nmi_state.sysrq_toggle_work);
+	else
+		schedule_work(&sysrq_enable_work);
+#else
 	schedule_work(&sysrq_enable_work);
-
+#endif
 	port->sysrq = 0;
 	return true;
 }
@@ -3273,12 +3279,122 @@ int uart_handle_break(struct uart_port *port)
 		port->sysrq = 0;
 	}
 
-	if (port->flags & UPF_SAK)
+	if (port->flags & UPF_SAK) {
+#ifdef CONFIG_CONSOLE_POLL
+		if (in_nmi())
+			irq_work_queue(&port->nmi_state.sysrq_sak_work);
+		else
+			do_SAK(state->port.tty);
+#else
 		do_SAK(state->port.tty);
+#endif
+	}
 	return 0;
 }
 EXPORT_SYMBOL_GPL(uart_handle_break);
 
+#ifdef CONFIG_CONSOLE_POLL
+int uart_nmi_handle_char(struct uart_port *port, unsigned int status,
+			 unsigned int overrun, unsigned int ch,
+			 unsigned int flag)
+{
+	struct uart_nmi_rx_data rx_data;
+
+	if (!in_nmi())
+		return 0;
+
+	rx_data.status = status;
+	rx_data.overrun = overrun;
+	rx_data.ch = ch;
+	rx_data.flag = flag;
+
+	if (!kfifo_in(&port->nmi_state.rx_fifo, &rx_data, 1))
+		++port->icount.buf_overrun;
+
+	return 1;
+}
+EXPORT_SYMBOL_GPL(uart_nmi_handle_char);
+
+static void uart_nmi_rx_work(struct irq_work *rx_work)
+{
+	struct uart_nmi_state *nmi_state =
+	    container_of(rx_work, struct uart_nmi_state, rx_work);
+	struct uart_port *port =
+	    container_of(nmi_state, struct uart_port, nmi_state);
+	struct uart_nmi_rx_data rx_data;
+
+	/*
+	 * In polling mode, serial device is initialized much prior to
+	 * TTY port becoming active. This scenario is especially useful
+	 * from debugging perspective such that magic sysrq or debugger
+	 * entry would still be possible even when TTY port isn't
+	 * active (consider a boot hang case or if a user hasn't opened
+	 * the serial port). So we discard any other RX data apart from
+	 * magic sysrq commands in case TTY port isn't active.
+	 */
+	if (!port->state || !tty_port_active(&port->state->port)) {
+		kfifo_reset(&nmi_state->rx_fifo);
+		return;
+	}
+
+	spin_lock(&port->lock);
+	while (kfifo_out(&nmi_state->rx_fifo, &rx_data, 1))
+		uart_insert_char(port, rx_data.status, rx_data.overrun,
+				 rx_data.ch, rx_data.flag);
+	spin_unlock(&port->lock);
+
+	tty_flip_buffer_push(&port->state->port);
+}
+
+static void uart_nmi_tx_work(struct irq_work *tx_work)
+{
+	struct uart_nmi_state *nmi_state =
+	    container_of(tx_work, struct uart_nmi_state, tx_work);
+	struct uart_port *port =
+	    container_of(nmi_state, struct uart_port, nmi_state);
+
+	spin_lock(&port->lock);
+	if (nmi_state->tx_irq_callback)
+		nmi_state->tx_irq_callback(port);
+	spin_unlock(&port->lock);
+}
+
+static void uart_nmi_sak_work(struct irq_work *work)
+{
+	struct uart_nmi_state *nmi_state =
+	    container_of(work, struct uart_nmi_state, sysrq_sak_work);
+	struct uart_port *port =
+	    container_of(nmi_state, struct uart_port, nmi_state);
+
+	do_SAK(port->state->port.tty);
+}
+
+#ifdef CONFIG_MAGIC_SYSRQ_SERIAL
+static void uart_nmi_toggle_work(struct irq_work *work)
+{
+	schedule_work(&sysrq_enable_work);
+}
+#endif
+
+int uart_nmi_state_init(struct uart_port *port)
+{
+	int ret;
+
+	ret = kfifo_alloc(&port->nmi_state.rx_fifo, 256, GFP_KERNEL);
+	if (ret)
+		return ret;
+
+	init_irq_work(&port->nmi_state.rx_work, uart_nmi_rx_work);
+	init_irq_work(&port->nmi_state.tx_work, uart_nmi_tx_work);
+	init_irq_work(&port->nmi_state.sysrq_sak_work, uart_nmi_sak_work);
+#ifdef CONFIG_MAGIC_SYSRQ_SERIAL
+	init_irq_work(&port->nmi_state.sysrq_toggle_work, uart_nmi_toggle_work);
+#endif
+	return ret;
+}
+EXPORT_SYMBOL_GPL(uart_nmi_state_init);
+#endif
+
 EXPORT_SYMBOL(uart_write_wakeup);
 EXPORT_SYMBOL(uart_register_driver);
 EXPORT_SYMBOL(uart_unregister_driver);
diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index 9fd550e..84487a9 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -18,6 +18,8 @@
 #include <linux/tty.h>
 #include <linux/mutex.h>
 #include <linux/sysrq.h>
+#include <linux/irq_work.h>
+#include <linux/kfifo.h>
 #include <uapi/linux/serial_core.h>
 
 #ifdef CONFIG_SERIAL_CORE_CONSOLE
@@ -103,6 +105,28 @@ struct uart_icount {
 typedef unsigned int __bitwise upf_t;
 typedef unsigned int __bitwise upstat_t;
 
+#ifdef CONFIG_CONSOLE_POLL
+struct uart_nmi_rx_data {
+	unsigned int		status;
+	unsigned int		overrun;
+	unsigned int		ch;
+	unsigned int		flag;
+};
+
+struct uart_nmi_state {
+	bool			active;
+
+	struct irq_work		tx_work;
+	void			(*tx_irq_callback)(struct uart_port *port);
+
+	struct irq_work		rx_work;
+	DECLARE_KFIFO_PTR(rx_fifo, struct uart_nmi_rx_data);
+
+	struct irq_work		sysrq_sak_work;
+	struct irq_work		sysrq_toggle_work;
+};
+#endif
+
 struct uart_port {
 	spinlock_t		lock;			/* port lock */
 	unsigned long		iobase;			/* in/out[bwl] */
@@ -255,6 +279,9 @@ struct uart_port {
 	struct gpio_desc	*rs485_term_gpio;	/* enable RS485 bus termination */
 	struct serial_iso7816   iso7816;
 	void			*private_data;		/* generic platform data pointer */
+#ifdef CONFIG_CONSOLE_POLL
+	struct uart_nmi_state	nmi_state;
+#endif
 };
 
 static inline int serial_port_in(struct uart_port *up, int offset)
@@ -475,4 +502,44 @@ extern int uart_handle_break(struct uart_port *port);
 					 !((cflag) & CLOCAL))
 
 int uart_get_rs485_mode(struct uart_port *port);
+
+/*
+ * The following are helper functions for the NMI aware serial drivers.
+ * Currently NMI support is only enabled under polling mode.
+ */
+
+#ifdef CONFIG_CONSOLE_POLL
+int uart_nmi_state_init(struct uart_port *port);
+int uart_nmi_handle_char(struct uart_port *port, unsigned int status,
+			 unsigned int overrun, unsigned int ch,
+			 unsigned int flag);
+
+static inline bool uart_nmi_active(struct uart_port *port)
+{
+	return port->nmi_state.active;
+}
+
+static inline void uart_set_nmi_active(struct uart_port *port, bool val)
+{
+	port->nmi_state.active = val;
+}
+#else
+static inline int uart_nmi_handle_char(struct uart_port *port,
+				       unsigned int status,
+				       unsigned int overrun,
+				       unsigned int ch, unsigned int flag)
+{
+	return 0;
+}
+
+static inline bool uart_nmi_active(struct uart_port *port)
+{
+	return false;
+}
+
+static inline void uart_set_nmi_active(struct uart_port *port, bool val)
+{
+}
+#endif
+
 #endif /* LINUX_SERIAL_CORE_H */
-- 
2.7.4


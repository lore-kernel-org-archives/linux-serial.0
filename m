Return-Path: <SRS0=qx80=7P=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00E21C433E1
	for <linux-serial@archiver.kernel.org>; Tue,  2 Jun 2020 14:01:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5CA620757
	for <linux-serial@archiver.kernel.org>; Tue,  2 Jun 2020 14:01:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591106499;
	bh=/UDXEAQI78qmGown6iHDfCeDmkD5lOutn1ColX7oPgQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZmthnU0k/MFgy+nHnzIRlBLov5vvIRkwMe0XMEvzgrJMPVgDWYIXt8ktAfJdWDQSN
	 W8QV8tLjDg/SL+WkhSigXpnA6mjbAYlg0M6E/GmrHBB0EyThRXUdXOXE7MmfiEfuW2
	 +Gqd/7V4820giCJ90MVqSerMKrMmqoOw4O4xvg4U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728326AbgFBOBi (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 2 Jun 2020 10:01:38 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:40065 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725958AbgFBOBa (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 2 Jun 2020 10:01:30 -0400
Received: by mail-lf1-f68.google.com with SMTP id h188so6241105lfd.7;
        Tue, 02 Jun 2020 07:01:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dZSNDpPuRNJluTc4KVlFFN+k90sxbG75BhZ6jhi6sJM=;
        b=PyAUpvFgx/hj2R7cp2lMW+tpngaXT5mBrNfvmQpwl46A4vllJhwZ/8oSOKBSbcx8Dh
         qBPkhYRSQZpkkQSYLnRr1KkQ2JR78IdoXIHJdU41pQsq51VmDLhp2oTWRlM+5DO+ge4r
         PsP3z0/cKeKVgqjwwBlA7yFSht9YiUZBmm6PaBpvEymPmcML1J7B9LYD6rHR3+b0Xu4h
         /XSZIVWmIl5u9RHC2qUiM81Vd5oehdex2UCXJlq0ElcqminjFKQ4kRiDKsD3WEGuk8Ds
         l75su1jPpflciDqdgfQZA47YD94AEmMkjtZDtFlEAVivH67qe87NloFrTbibhj37bGv9
         fz5A==
X-Gm-Message-State: AOAM533K3iTcJxwKRV+AwdzMj5VBN2JNk1T9U2zWbrRgsdzb6OMdtjJq
        jkfeF1JWB+WqcHHW4s1d6+8=
X-Google-Smtp-Source: ABdhPJxgLHjq4d6e2gc2lxbcFZOIHUvTVSW64LlQK1RdAZ4tGXI7/e7AcbVI04iuUtHIww1U/fdCAA==
X-Received: by 2002:a19:c212:: with SMTP id l18mr13853445lfc.68.1591106487546;
        Tue, 02 Jun 2020 07:01:27 -0700 (PDT)
Received: from xi.terra (c-beaee455.07-184-6d6c6d4.bbcust.telenor.se. [85.228.174.190])
        by smtp.gmail.com with ESMTPSA id t12sm552600ljj.139.2020.06.02.07.01.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2020 07:01:26 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.93.0.4)
        (envelope-from <johan@xi.terra>)
        id 1jg7Ti-0000y4-Tg; Tue, 02 Jun 2020 16:01:18 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jslaby@suse.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan@kernel.org>
Subject: [PATCH 3/4] serial: core: fix sysrq overhead regression
Date:   Tue,  2 Jun 2020 16:00:57 +0200
Message-Id: <20200602140058.3656-4-johan@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200602140058.3656-1-johan@kernel.org>
References: <20200602140058.3656-1-johan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Commit 8e20fc391711 ("serial_core: Move sysrq functions from header
file") converted the inline sysrq helpers to exported functions which
are now called for every received character and break signal also on
systems without CONFIG_MAGIC_SYSRQ_SERIAL instead of being optimised
away by the compiler.

Inlining these helpers again also avoids the function call overhead when
CONFIG_MAGIC_SYSRQ_SERIAL is enabled.

Fixes: 8e20fc391711 ("serial_core: Move sysrq functions from header file")
Cc: Dmitry Safonov <0x7f454c46@gmail.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/tty/serial/serial_core.c | 80 +-----------------------------
 include/linux/serial_core.h      | 85 ++++++++++++++++++++++++++++++--
 2 files changed, 84 insertions(+), 81 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index f6cf9cc4ce69..a714402dcf4e 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -41,8 +41,6 @@ static struct lock_class_key port_lock_key;
 
 #define HIGH_BITS_OFFSET	((sizeof(long)-sizeof(int))*8)
 
-#define SYSRQ_TIMEOUT	(HZ * 5)
-
 static void uart_change_speed(struct tty_struct *tty, struct uart_state *state,
 					struct ktermios *old_termios);
 static void uart_wait_until_sent(struct tty_struct *tty, int timeout);
@@ -3163,7 +3161,7 @@ static DECLARE_WORK(sysrq_enable_work, uart_sysrq_on);
  *	Returns false if @ch is out of enabling sequence and should be
  *	handled some other way, true if @ch was consumed.
  */
-static bool uart_try_toggle_sysrq(struct uart_port *port, unsigned int ch)
+bool uart_try_toggle_sysrq(struct uart_port *port, unsigned int ch)
 {
 	int sysrq_toggle_seq_len = strlen(sysrq_toggle_seq);
 
@@ -3186,83 +3184,9 @@ static bool uart_try_toggle_sysrq(struct uart_port *port, unsigned int ch)
 	port->sysrq = 0;
 	return true;
 }
-#else
-static inline bool uart_try_toggle_sysrq(struct uart_port *port, unsigned int ch)
-{
-	return false;
-}
+EXPORT_SYMBOL_GPL(uart_try_toggle_sysrq);
 #endif
 
-int uart_handle_sysrq_char(struct uart_port *port, unsigned int ch)
-{
-	if (!IS_ENABLED(CONFIG_MAGIC_SYSRQ_SERIAL))
-		return 0;
-
-	if (!port->has_sysrq || !port->sysrq)
-		return 0;
-
-	if (ch && time_before(jiffies, port->sysrq)) {
-		if (sysrq_mask()) {
-			handle_sysrq(ch);
-			port->sysrq = 0;
-			return 1;
-		}
-		if (uart_try_toggle_sysrq(port, ch))
-			return 1;
-	}
-	port->sysrq = 0;
-
-	return 0;
-}
-EXPORT_SYMBOL_GPL(uart_handle_sysrq_char);
-
-int uart_prepare_sysrq_char(struct uart_port *port, unsigned int ch)
-{
-	if (!IS_ENABLED(CONFIG_MAGIC_SYSRQ_SERIAL))
-		return 0;
-
-	if (!port->has_sysrq || !port->sysrq)
-		return 0;
-
-	if (ch && time_before(jiffies, port->sysrq)) {
-		if (sysrq_mask()) {
-			port->sysrq_ch = ch;
-			port->sysrq = 0;
-			return 1;
-		}
-		if (uart_try_toggle_sysrq(port, ch))
-			return 1;
-	}
-	port->sysrq = 0;
-
-	return 0;
-}
-EXPORT_SYMBOL_GPL(uart_prepare_sysrq_char);
-
-/*
- * We do the SysRQ and SAK checking like this...
- */
-int uart_handle_break(struct uart_port *port)
-{
-	struct uart_state *state = port->state;
-
-	if (port->handle_break)
-		port->handle_break(port);
-
-	if (port->has_sysrq && uart_console(port)) {
-		if (!port->sysrq) {
-			port->sysrq = jiffies + SYSRQ_TIMEOUT;
-			return 1;
-		}
-		port->sysrq = 0;
-	}
-
-	if (port->flags & UPF_SAK)
-		do_SAK(state->port.tty);
-	return 0;
-}
-EXPORT_SYMBOL_GPL(uart_handle_break);
-
 EXPORT_SYMBOL(uart_write_wakeup);
 EXPORT_SYMBOL(uart_register_driver);
 EXPORT_SYMBOL(uart_unregister_driver);
diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index 858c5dd926ad..a8a213b71553 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -460,8 +460,49 @@ extern void uart_handle_cts_change(struct uart_port *uport,
 extern void uart_insert_char(struct uart_port *port, unsigned int status,
 		 unsigned int overrun, unsigned int ch, unsigned int flag);
 
-extern int uart_handle_sysrq_char(struct uart_port *port, unsigned int ch);
-extern int uart_prepare_sysrq_char(struct uart_port *port, unsigned int ch);
+#ifdef CONFIG_MAGIC_SYSRQ_SERIAL
+
+#define SYSRQ_TIMEOUT	(HZ * 5)
+
+bool uart_try_toggle_sysrq(struct uart_port *port, unsigned int ch);
+
+static inline int uart_handle_sysrq_char(struct uart_port *port, unsigned int ch)
+{
+	if (!port->has_sysrq || !port->sysrq)
+		return 0;
+
+	if (ch && time_before(jiffies, port->sysrq)) {
+		if (sysrq_mask()) {
+			handle_sysrq(ch);
+			port->sysrq = 0;
+			return 1;
+		}
+		if (uart_try_toggle_sysrq(port, ch))
+			return 1;
+	}
+	port->sysrq = 0;
+
+	return 0;
+}
+
+static inline int uart_prepare_sysrq_char(struct uart_port *port, unsigned int ch)
+{
+	if (!port->has_sysrq || !port->sysrq)
+		return 0;
+
+	if (ch && time_before(jiffies, port->sysrq)) {
+		if (sysrq_mask()) {
+			port->sysrq_ch = ch;
+			port->sysrq = 0;
+			return 1;
+		}
+		if (uart_try_toggle_sysrq(port, ch))
+			return 1;
+	}
+	port->sysrq = 0;
+
+	return 0;
+}
 
 static inline void uart_unlock_and_check_sysrq(struct uart_port *port, unsigned long irqflags)
 {
@@ -480,8 +521,46 @@ static inline void uart_unlock_and_check_sysrq(struct uart_port *port, unsigned
 	if (sysrq_ch)
 		handle_sysrq(sysrq_ch);
 }
+#else	/* CONFIG_MAGIC_SYSRQ_SERIAL */
+static inline int uart_handle_sysrq_char(struct uart_port *port, unsigned int ch)
+{
+	return 0;
+}
 
-extern int uart_handle_break(struct uart_port *port);
+static inline int uart_prepare_sysrq_char(struct uart_port *port, unsigned int ch)
+{
+	return 0;
+}
+
+static inline void uart_unlock_and_check_sysrq(struct uart_port *port, unsigned long irqflags)
+{
+	spin_unlock_irqrestore(&port->lock, irqflags);
+}
+#endif	/* CONFIG_MAGIC_SYSRQ_SERIAL */
+
+/*
+ * We do the SysRQ and SAK checking like this...
+ */
+static inline int uart_handle_break(struct uart_port *port)
+{
+	struct uart_state *state = port->state;
+
+	if (port->handle_break)
+		port->handle_break(port);
+
+#ifdef CONFIG_MAGIC_SYSRQ_SERIAL
+	if (port->has_sysrq && uart_console(port)) {
+		if (!port->sysrq) {
+			port->sysrq = jiffies + SYSRQ_TIMEOUT;
+			return 1;
+		}
+		port->sysrq = 0;
+	}
+#endif
+	if (port->flags & UPF_SAK)
+		do_SAK(state->port.tty);
+	return 0;
+}
 
 /*
  *	UART_ENABLE_MS - determine if port should enable modem status irqs
-- 
2.26.2


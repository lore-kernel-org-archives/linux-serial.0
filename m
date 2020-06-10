Return-Path: <SRS0=uqjK=7X=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26A60C433E0
	for <linux-serial@archiver.kernel.org>; Wed, 10 Jun 2020 15:23:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F17342078C
	for <linux-serial@archiver.kernel.org>; Wed, 10 Jun 2020 15:23:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591802600;
	bh=sy/StJ6wEolnPlpsfjtldi4KOI+mvEZiR1f0siZWGRw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qiuWtyrmSID0m33DdUTdWaiv86mA9/9FzteBRbuVyKkoRF8vXjek7hkxLewm6r7pI
	 knTqJnSJaK5QRZbaoZT7fnvyZTu0PZrazEATHDIRcpA6s7GafL35TY2zhrW2FuaqWx
	 3uqYKxkymfTfpBkNO9omUZ68J4ThwExfERXVqn0Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728530AbgFJPXS (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 10 Jun 2020 11:23:18 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:41649 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728411AbgFJPXH (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 10 Jun 2020 11:23:07 -0400
Received: by mail-lj1-f195.google.com with SMTP id 9so2979730ljc.8;
        Wed, 10 Jun 2020 08:23:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Wtd75GwgZtA7lRhNm55iQdZt5/TgmSLAdSmpq5XS+H8=;
        b=HDFuyDBgJOILZ4VZ2FqaqmyGyH7AACq/61a220kOC12nCkZc2wGdpBKZv7cGwvsF+i
         LXrWNCf9/tHsSOOXKgbUsWAwI9XpBdjgUtzpcbXAjqbi2CaBZP/zokYwyaFMmMAdl4MO
         Qrfy82fZHpx+azECqfgg6ECFaUYioxPMpjFrgHOQznI7M8V+tdSuz3yPPu1GbVpDDT7v
         nAxx6OonLWtZguqLoGZN3797t1QkokX67qzBBR60qmUGN2x4JG7S3hvJ+rZVK5vXmNeg
         eEHX+jcrSA1oBtDA2HHc4MsMjGc9ZE4su6pE/QjfLYD96a0TwOG7XaYav5CEjXrzEhWE
         gEkw==
X-Gm-Message-State: AOAM532rVoTT7uRfHf/Ty1FQJr3LqHiduifJH7njvIucuiuBS/bFjglE
        6TdA25L9km8G3hEXkL/WzrM=
X-Google-Smtp-Source: ABdhPJyEt5rwFNpNCJ10FZQA/t7mEmE5onvA5wFbHIl4wru7GFslBEV2yVPFHShQp1OeW1SEoxCv8g==
X-Received: by 2002:a2e:920a:: with SMTP id k10mr1952915ljg.413.1591802583036;
        Wed, 10 Jun 2020 08:23:03 -0700 (PDT)
Received: from xi.terra (c-beaee455.07-184-6d6c6d4.bbcust.telenor.se. [85.228.174.190])
        by smtp.gmail.com with ESMTPSA id v22sm18126ljg.12.2020.06.10.08.23.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2020 08:23:01 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.93.0.4)
        (envelope-from <johan@xi.terra>)
        id 1jj2Z8-0004Px-CK; Wed, 10 Jun 2020 17:22:58 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jslaby@suse.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan@kernel.org>
Subject: [PATCH v2 2/3] serial: core: fix sysrq overhead regression
Date:   Wed, 10 Jun 2020 17:22:31 +0200
Message-Id: <20200610152232.16925-3-johan@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200610152232.16925-1-johan@kernel.org>
References: <20200610152232.16925-1-johan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Commit 8e20fc391711 ("serial_core: Move sysrq functions from header
file") converted the inline sysrq helpers to exported functions which
are now called for every received character, interrupt and break signal
also on systems without CONFIG_MAGIC_SYSRQ_SERIAL instead of being
optimised away by the compiler.

Inlining these helpers again also avoids the function call overhead when
CONFIG_MAGIC_SYSRQ_SERIAL is enabled (e.g. when the port is not used as
a console).

Fixes: 8e20fc391711 ("serial_core: Move sysrq functions from header file")
Cc: Dmitry Safonov <0x7f454c46@gmail.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/tty/serial/serial_core.c |  99 +----------------------------
 include/linux/serial_core.h      | 103 +++++++++++++++++++++++++++++--
 2 files changed, 100 insertions(+), 102 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 296b9f6fa9cd..3706f31b0c37 100644
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
 
@@ -3186,102 +3184,9 @@ static bool uart_try_toggle_sysrq(struct uart_port *port, unsigned int ch)
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
-void uart_unlock_and_check_sysrq(struct uart_port *port, unsigned long irqflags)
-{
-	int sysrq_ch;
-
-	if (!port->has_sysrq) {
-		spin_unlock_irqrestore(&port->lock, irqflags);
-		return;
-	}
-
-	sysrq_ch = port->sysrq_ch;
-	port->sysrq_ch = 0;
-
-	spin_unlock_irqrestore(&port->lock, irqflags);
-
-	if (sysrq_ch)
-		handle_sysrq(sysrq_ch);
-}
-EXPORT_SYMBOL_GPL(uart_unlock_and_check_sysrq);
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
index ef4921ddbe97..03fa7b967103 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -462,11 +462,104 @@ extern void uart_handle_cts_change(struct uart_port *uport,
 extern void uart_insert_char(struct uart_port *port, unsigned int status,
 		 unsigned int overrun, unsigned int ch, unsigned int flag);
 
-extern int uart_handle_sysrq_char(struct uart_port *port, unsigned int ch);
-extern int uart_prepare_sysrq_char(struct uart_port *port, unsigned int ch);
-extern void uart_unlock_and_check_sysrq(struct uart_port *port,
-					unsigned long irqflags);
-extern int uart_handle_break(struct uart_port *port);
+#ifdef CONFIG_MAGIC_SYSRQ_SERIAL
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
+
+static inline void uart_unlock_and_check_sysrq(struct uart_port *port, unsigned long irqflags)
+{
+	int sysrq_ch;
+
+	if (!port->has_sysrq) {
+		spin_unlock_irqrestore(&port->lock, irqflags);
+		return;
+	}
+
+	sysrq_ch = port->sysrq_ch;
+	port->sysrq_ch = 0;
+
+	spin_unlock_irqrestore(&port->lock, irqflags);
+
+	if (sysrq_ch)
+		handle_sysrq(sysrq_ch);
+}
+#else	/* CONFIG_MAGIC_SYSRQ_SERIAL */
+static inline int uart_handle_sysrq_char(struct uart_port *port, unsigned int ch)
+{
+	return 0;
+}
+static inline int uart_prepare_sysrq_char(struct uart_port *port, unsigned int ch)
+{
+	return 0;
+}
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


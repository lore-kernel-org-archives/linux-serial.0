Return-Path: <SRS0=YLjw=4T=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F1ECC3F2D7
	for <linux-serial@archiver.kernel.org>; Mon,  2 Mar 2020 17:52:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5E722173E
	for <linux-serial@archiver.kernel.org>; Mon,  2 Mar 2020 17:51:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="EqCK7elF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727202AbgCBRv7 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 2 Mar 2020 12:51:59 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41690 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727341AbgCBRvq (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 2 Mar 2020 12:51:46 -0500
Received: by mail-wr1-f67.google.com with SMTP id v4so841626wrs.8
        for <linux-serial@vger.kernel.org>; Mon, 02 Mar 2020 09:51:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0WuDNqRnkyISdiAgs4xnNPd5q/jznPt8vGzOtCd6GYk=;
        b=EqCK7elFybqQABh5utTaGdkJDVZIiw68QrblpyOsl7K5fLM/IuE22CH46gnlkV1r8I
         +mPJTEeyiRYxmAyU4zVn/WbGQUzOcW4SY66uRk+ooKk6nTPtvkgcChzccYzM8S+s6gus
         qd6XhxFJLJjzvGgn+9ic1fA924bzARtHobqlnnoO5H3UqT9VKSM0hDjfNibhkFneI/dR
         ngmd3s7EPP8NoBKV/++21nXdW7MgPfv06gEhuAgSKHi8FUbgeEsSlApqKRfoMDLLHtvP
         2j0svlHpnqCOTxwI8arKfihGMeHf87CoxdzggqmkDeJwqUoPHtaCXECppJ0BmOPZdgb1
         Bugg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0WuDNqRnkyISdiAgs4xnNPd5q/jznPt8vGzOtCd6GYk=;
        b=qRpbb1J0gvoi8cnpyshdzWKg4djk1DPECDgfZuF5bJrHxBdPc8zwvHq4iD9QmHHI2O
         uL4hBPoUVn7s9J9LODMDivE/0exX/yR90eGaCiM1qtSEjc5PFX0USGJgZWoAHBDZc8yt
         TfQPTetG77wg1hMcRu5akOQHTld5wlc92npR0NruV9naCwHRPShMIWwA9P1ibFl0pa43
         lJarkkaAwc27wX6Ia2QBNdU7/49dVVbXntGR8wkmdj9nG1/UNLnY6UPN0SPrIOUE0+0W
         e8P7zwjqzBq4xTJK2M3IGlQngbGZGWAjbQF/zdUidO3HiNpyfbQ/aTnSkB5VtedqYO17
         J9gA==
X-Gm-Message-State: ANhLgQ1wO/4PeSWfG3uU5mD2CKuyTGEVanZG5D1s1Zbh19Kja7qr7w1W
        cYcKD5Y4UdloEXqPXu04GLIRbg==
X-Google-Smtp-Source: ADFU+vu/W6Nlw7oowUmt5iTvinPfRo+xF6FAklOVJ9JYGbmMSwm64FJ8fZvx8MPTRGu7s32kBFun8w==
X-Received: by 2002:a5d:4408:: with SMTP id z8mr676342wrq.321.1583171504513;
        Mon, 02 Mar 2020 09:51:44 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id b10sm163234wmh.48.2020.03.02.09.51.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2020 09:51:43 -0800 (PST)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Dmitry Safonov <dima@arista.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Jiri Slaby <jslaby@suse.com>, Joe Perches <joe@perches.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Vasiliy Khoruzhick <vasilykh@arista.com>,
        linux-serial@vger.kernel.org
Subject: [PATCHv3 2/2] serial/sysrq: Add MAGIC_SYSRQ_SERIAL_SEQUENCE
Date:   Mon,  2 Mar 2020 17:51:35 +0000
Message-Id: <20200302175135.269397-3-dima@arista.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200302175135.269397-1-dima@arista.com>
References: <20200302175135.269397-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Many embedded boards have a disconnected TTL level serial which can
generate some garbage that can lead to spurious false sysrq detects.

Currently, sysrq can be either completely disabled for serial console
or always disabled (with CONFIG_MAGIC_SYSRQ_SERIAL), since
commit 732dbf3a6104 ("serial: do not accept sysrq characters via serial port")

At Arista, we have such boards that can generate BREAK and random
garbage. While disabling sysrq for serial console would solve
the problem with spurious false sysrq triggers, it's also desirable
to have a way to enable sysrq back.

As a measure of balance between on and off options, add
MAGIC_SYSRQ_SERIAL_SEQUENCE which is a string sequence that can enable
sysrq if it follows BREAK on a serial line. The longer the string - the
less likely it may be in the garbage.

Having the way to enable sysrq was beneficial to debug lockups with
a manual investigation in field and on the other side preventing false
sysrq detections.

Based-on-patch-by: Vasiliy Khoruzhick <vasilykh@arista.com>
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 drivers/tty/serial/serial_core.c | 75 +++++++++++++++++++++++++++++---
 include/linux/serial_core.h      |  1 +
 lib/Kconfig.debug                |  8 ++++
 3 files changed, 77 insertions(+), 7 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 76e506ee335c..83151da74a15 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -20,6 +20,7 @@
 #include <linux/device.h>
 #include <linux/serial.h> /* for serial_state and serial_icounter_struct */
 #include <linux/serial_core.h>
+#include <linux/sysrq.h>
 #include <linux/delay.h>
 #include <linux/mutex.h>
 #include <linux/security.h>
@@ -40,6 +41,8 @@ static struct lock_class_key port_lock_key;
 
 #define HIGH_BITS_OFFSET	((sizeof(long)-sizeof(int))*8)
 
+#define SYSRQ_TIMEOUT	(HZ * 5)
+
 static void uart_change_speed(struct tty_struct *tty, struct uart_state *state,
 					struct ktermios *old_termios);
 static void uart_wait_until_sent(struct tty_struct *tty, int timeout);
@@ -3082,6 +3085,56 @@ void uart_insert_char(struct uart_port *port, unsigned int status,
 }
 EXPORT_SYMBOL_GPL(uart_insert_char);
 
+#ifdef CONFIG_MAGIC_SYSRQ_SERIAL
+static const char sysrq_toggle_seq[] = CONFIG_MAGIC_SYSRQ_SERIAL_SEQUENCE;
+
+static void uart_sysrq_on(struct work_struct *w)
+{
+	sysrq_toggle_support(1);
+	pr_info("SysRq is enabled by magic sequence on serial\n");
+}
+static DECLARE_WORK(sysrq_enable_work, uart_sysrq_on);
+
+/**
+ *	uart_try_toggle_sysrq - Enables SysRq from serial line
+ *	@port: uart_port structure where char(s) after BREAK met
+ *	@ch: new character in the sequence after received BREAK
+ *
+ *	Enables magic SysRq when the required sequence is met on port
+ *	(see CONFIG_MAGIC_SYSRQ_SERIAL_SEQUENCE).
+ *
+ *	Returns false if @ch is out of enabling sequence and should be
+ *	handled some other way, true if @ch was consumed.
+ */
+static bool uart_try_toggle_sysrq(struct uart_port *port, unsigned int ch)
+{
+	if (ARRAY_SIZE(sysrq_toggle_seq) <= 1)
+		return false;
+
+	BUILD_BUG_ON(ARRAY_SIZE(sysrq_toggle_seq) >= U8_MAX);
+	if (sysrq_toggle_seq[port->sysrq_seq] != ch) {
+		port->sysrq_seq = 0;
+		return false;
+	}
+
+	/* Without the last \0 */
+	if (++port->sysrq_seq < (ARRAY_SIZE(sysrq_toggle_seq) - 1)) {
+		port->sysrq = jiffies + SYSRQ_TIMEOUT;
+		return true;
+	}
+
+	schedule_work(&sysrq_enable_work);
+
+	port->sysrq = 0;
+	return true;
+}
+#else
+static inline bool uart_try_toggle_sysrq(struct uart_port *port, unsigned int ch)
+{
+	return false;
+}
+#endif
+
 int uart_handle_sysrq_char(struct uart_port *port, unsigned int ch)
 {
 	if (!IS_ENABLED(CONFIG_MAGIC_SYSRQ_SERIAL))
@@ -3091,9 +3144,13 @@ int uart_handle_sysrq_char(struct uart_port *port, unsigned int ch)
 		return 0;
 
 	if (ch && time_before(jiffies, port->sysrq)) {
-		handle_sysrq(ch);
-		port->sysrq = 0;
-		return 1;
+		if (sysrq_mask()) {
+			handle_sysrq(ch);
+			port->sysrq = 0;
+			return 1;
+		}
+		if (uart_try_toggle_sysrq(port, ch))
+			return 1;
 	}
 	port->sysrq = 0;
 
@@ -3110,9 +3167,13 @@ int uart_prepare_sysrq_char(struct uart_port *port, unsigned int ch)
 		return 0;
 
 	if (ch && time_before(jiffies, port->sysrq)) {
-		port->sysrq_ch = ch;
-		port->sysrq = 0;
-		return 1;
+		if (sysrq_mask()) {
+			port->sysrq_ch = ch;
+			port->sysrq = 0;
+			return 1;
+		}
+		if (uart_try_toggle_sysrq(port, ch))
+			return 1;
 	}
 	port->sysrq = 0;
 
@@ -3152,7 +3213,7 @@ int uart_handle_break(struct uart_port *port)
 	if (port->has_sysrq) {
 		if (port->cons && port->cons->index == port->line) {
 			if (!port->sysrq) {
-				port->sysrq = jiffies + HZ*5;
+				port->sysrq = jiffies + SYSRQ_TIMEOUT;
 				return 1;
 			}
 			port->sysrq = 0;
diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index 52404ef1694e..1f4443db5474 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -243,6 +243,7 @@ struct uart_port {
 	unsigned long		sysrq;			/* sysrq timeout */
 	unsigned int		sysrq_ch;		/* char for sysrq */
 	unsigned char		has_sysrq;
+	unsigned char		sysrq_seq;		/* index in sysrq_toggle_seq */
 
 	unsigned char		hub6;			/* this should be in the 8250 driver */
 	unsigned char		suspended;
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 69def4a9df00..38a8f3c99579 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -431,6 +431,14 @@ config MAGIC_SYSRQ_SERIAL
 	  This option allows you to decide whether you want to enable the
 	  magic SysRq key.
 
+config MAGIC_SYSRQ_SERIAL_SEQUENCE
+	string "Char sequence that enables magic SysRq over serial"
+	depends on MAGIC_SYSRQ_SERIAL
+	default ""
+	help
+	  Specifies a sequence of characters that can follow BREAK to enable
+	  SysRq on a serial console.
+
 config DEBUG_FS
 	bool "Debug Filesystem"
 	help
-- 
2.25.0


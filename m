Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0574C43460
	for <linux-serial@archiver.kernel.org>; Wed,  5 May 2021 09:20:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB42F613F5
	for <linux-serial@archiver.kernel.org>; Wed,  5 May 2021 09:20:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232554AbhEEJVI (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 5 May 2021 05:21:08 -0400
Received: from mx2.suse.de ([195.135.220.15]:42098 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232521AbhEEJUl (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 5 May 2021 05:20:41 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id CC7D7B2BB;
        Wed,  5 May 2021 09:19:42 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 34/35] tty: make tty_get_byte_size available
Date:   Wed,  5 May 2021 11:19:27 +0200
Message-Id: <20210505091928.22010-35-jslaby@suse.cz>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210505091928.22010-1-jslaby@suse.cz>
References: <20210505091928.22010-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Many tty drivers contain code to compute bits count depending on termios
cflags. So extract this code from serial core to a separate tty helper
function called tty_get_byte_size.

In the next patch, call to this new function will replace many copies of
this code.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/serial/serial_core.c | 30 +++--------------------
 drivers/tty/tty_ioctl.c          | 41 ++++++++++++++++++++++++++++++++
 include/linux/tty.h              |  2 ++
 3 files changed, 46 insertions(+), 27 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index d29329eb52f4..b3fc2b02a705 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -334,39 +334,15 @@ void
 uart_update_timeout(struct uart_port *port, unsigned int cflag,
 		    unsigned int baud)
 {
-	unsigned int bits;
+	unsigned int size;
 
-	/* byte size and parity */
-	switch (cflag & CSIZE) {
-	case CS5:
-		bits = 7;
-		break;
-	case CS6:
-		bits = 8;
-		break;
-	case CS7:
-		bits = 9;
-		break;
-	default:
-		bits = 10;
-		break; /* CS8 */
-	}
-
-	if (cflag & CSTOPB)
-		bits++;
-	if (cflag & PARENB)
-		bits++;
-
-	/*
-	 * The total number of bits to be transmitted in the fifo.
-	 */
-	bits = bits * port->fifosize;
+	size = tty_get_byte_size(cflag, true) * port->fifosize;
 
 	/*
 	 * Figure the timeout to send the above number of bits.
 	 * Add .02 seconds of slop
 	 */
-	port->timeout = (HZ * bits) / baud + HZ/50;
+	port->timeout = (HZ * size) / baud + HZ/50;
 }
 
 EXPORT_SYMBOL(uart_update_timeout);
diff --git a/drivers/tty/tty_ioctl.c b/drivers/tty/tty_ioctl.c
index aa9ecc8be990..72d036917b14 100644
--- a/drivers/tty/tty_ioctl.c
+++ b/drivers/tty/tty_ioctl.c
@@ -300,6 +300,47 @@ int tty_termios_hw_change(const struct ktermios *a, const struct ktermios *b)
 }
 EXPORT_SYMBOL(tty_termios_hw_change);
 
+/**
+ *	tty_get_byte_size	-	get size of a byte
+ *	@cflag: termios cflag value
+ *	@account_flags: account for start and stop bits, second stop bit (if
+ *			set), and parity (if set)
+ *
+ *	Get the size of a byte in bits depending on @cflag. Depending on
+ *	@account_flags parameter, the result also accounts start and stop bits,
+ *	the second stop bit, and parity bit.
+ */
+unsigned char tty_get_byte_size(unsigned int cflag, bool account_flags)
+{
+	unsigned char bits = account_flags ? 2 : 0;
+
+	/* byte size and parity */
+	switch (cflag & CSIZE) {
+	case CS5:
+		bits += 5;
+		break;
+	case CS6:
+		bits += 6;
+		break;
+	case CS7:
+		bits += 7;
+		break;
+	case CS8:
+	default:
+		bits += 8;
+		break;
+	}
+
+	if (account_flags && (cflag & CSTOPB))
+		bits++;
+
+	if (account_flags && (cflag & PARENB))
+		bits++;
+
+	return bits;
+}
+EXPORT_SYMBOL_GPL(tty_get_byte_size);
+
 /**
  *	tty_set_termios		-	update termios values
  *	@tty: tty to update
diff --git a/include/linux/tty.h b/include/linux/tty.h
index 5cf6b2e7331b..a14b4588368c 100644
--- a/include/linux/tty.h
+++ b/include/linux/tty.h
@@ -496,6 +496,8 @@ static inline speed_t tty_get_baud_rate(struct tty_struct *tty)
 	return tty_termios_baud_rate(&tty->termios);
 }
 
+unsigned char tty_get_byte_size(unsigned int cflag, bool account_flags);
+
 extern void tty_termios_copy_hw(struct ktermios *new, struct ktermios *old);
 extern int tty_termios_hw_change(const struct ktermios *a, const struct ktermios *b);
 extern int tty_set_termios(struct tty_struct *tty, struct ktermios *kt);
-- 
2.31.1


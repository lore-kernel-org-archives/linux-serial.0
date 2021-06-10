Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC152C47094
	for <linux-serial@archiver.kernel.org>; Thu, 10 Jun 2021 09:02:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9DEFE61040
	for <linux-serial@archiver.kernel.org>; Thu, 10 Jun 2021 09:02:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230151AbhFJJEp (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 10 Jun 2021 05:04:45 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:54592 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230152AbhFJJEp (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 10 Jun 2021 05:04:45 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 8369821A32;
        Thu, 10 Jun 2021 09:02:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1623315768; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JIlSlhKtbzlXvZQYQcOTkErs4DA45C8U5DktVPXAF6M=;
        b=qAJbJqaMcYSNa3HmvciIDvxGFjpyJQWmzcTSxQzsSQHUNarXkuDQ6xQ2YAOHGDpiI03+fr
        1gEOfOfbXxWcpggJmelBx3yBwx+aDusKj2PAbM7Nlshz+SHpck6IHKa8BxSCvN1AE/262B
        2EI6jZYaRSY2UVWvgUKph8ToAULdzfU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1623315768;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JIlSlhKtbzlXvZQYQcOTkErs4DA45C8U5DktVPXAF6M=;
        b=E2TP+1uoQKcoZldetoP91Q2XKCTlq3KxYzFjuhA3no6DDz273hj4WDgoZH1cqaWiyOLm0F
        JgTKMds+3LwVxJDQ==
Received: from localhost.localdomain (unknown [10.100.208.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 393BAA3B8B;
        Thu, 10 Jun 2021 09:02:48 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Joe Perches <joe@perches.com>, Johan Hovold <johan@kernel.org>
Subject: [PATCH v3 1/4] tty: make tty_get_{char,frame}_size available
Date:   Thu, 10 Jun 2021 11:02:44 +0200
Message-Id: <20210610090247.2593-1-jslaby@suse.cz>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210505091928.22010-1-jslaby@suse.cz>
References: <20210505091928.22010-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Many tty drivers contain code to compute bits count depending on termios
cflags. So extract this code from serial core to two separate tty helper
functions:
* tty_get_char_size -- only size of a character, without flags,
* tty_get_frame_size -- complete size of a frame including flags.

In the next patch, calls to these new functions replace many copies of
this code.

Note that we accept only cflag as a parameter. That's because some
callers like pch_uart_startup or sunsab_console_setup don't have at hand
termios which we could pass around.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Joe Perches <joe@perches.com>
Cc: Johan Hovold <johan@kernel.org>
---
[v2] simplified the code flow as suggested by Joe and Andy
[v3] redesign to have 2 functions as suggested by Johan.

 drivers/tty/serial/serial_core.c | 30 +++------------------
 drivers/tty/tty_ioctl.c          | 45 ++++++++++++++++++++++++++++++++
 include/linux/tty.h              |  3 +++
 3 files changed, 51 insertions(+), 27 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 642e24d6c475..69092deba11f 100644
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
+	size = tty_get_frame_size(cflag) * port->fifosize;
 
 	/*
 	 * Figure the timeout to send the above number of bits.
 	 * Add .02 seconds of slop
 	 */
-	port->timeout = (HZ * bits) / baud + HZ/50;
+	port->timeout = (HZ * size) / baud + HZ/50;
 }
 
 EXPORT_SYMBOL(uart_update_timeout);
diff --git a/drivers/tty/tty_ioctl.c b/drivers/tty/tty_ioctl.c
index 75885d502749..507a25d692bb 100644
--- a/drivers/tty/tty_ioctl.c
+++ b/drivers/tty/tty_ioctl.c
@@ -279,6 +279,51 @@ int tty_termios_hw_change(const struct ktermios *a, const struct ktermios *b)
 }
 EXPORT_SYMBOL(tty_termios_hw_change);
 
+/**
+ *	tty_get_char_size	-	get size of a character
+ *	@cflag: termios cflag value
+ *
+ *	Get the size (in bits) of a character depending on @cflag's %CSIZE
+ *	setting.
+ */
+unsigned char tty_get_char_size(unsigned int cflag)
+{
+	switch (cflag & CSIZE) {
+	case CS5:
+		return 5;
+	case CS6:
+		return 6;
+	case CS7:
+		return 7;
+	case CS8:
+	default:
+		return 8;
+	}
+}
+EXPORT_SYMBOL_GPL(tty_get_char_size);
+
+/**
+ *	tty_get_frame_size	-	get size of a frame
+ *	@cflag: termios cflag value
+ *
+ *	Get the size (in bits) of a frame depending on @cflag's %CSIZE, %CSTOPB,
+ *	and %PARENB setting. The result is a sum of character size, start and
+ *	stop bits -- one bit each -- second stop bit (if set), and parity bit
+ *	(if set).
+ */
+unsigned char tty_get_frame_size(unsigned int cflag)
+{
+	unsigned char bits = 2 + tty_get_char_size(cflag);
+
+	if (cflag & CSTOPB)
+		bits++;
+	if (cflag & PARENB)
+		bits++;
+
+	return bits;
+}
+EXPORT_SYMBOL_GPL(tty_get_frame_size);
+
 /**
  *	tty_set_termios		-	update termios values
  *	@tty: tty to update
diff --git a/include/linux/tty.h b/include/linux/tty.h
index 4c0c7ca1d9a4..19dc1097e09c 100644
--- a/include/linux/tty.h
+++ b/include/linux/tty.h
@@ -495,6 +495,9 @@ static inline speed_t tty_get_baud_rate(struct tty_struct *tty)
 	return tty_termios_baud_rate(&tty->termios);
 }
 
+unsigned char tty_get_char_size(unsigned int cflag);
+unsigned char tty_get_frame_size(unsigned int cflag);
+
 extern void tty_termios_copy_hw(struct ktermios *new, struct ktermios *old);
 extern int tty_termios_hw_change(const struct ktermios *a, const struct ktermios *b);
 extern int tty_set_termios(struct tty_struct *tty, struct ktermios *kt);
-- 
2.32.0


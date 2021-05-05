Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A111C43616
	for <linux-serial@archiver.kernel.org>; Wed,  5 May 2021 09:20:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4DDE1613F6
	for <linux-serial@archiver.kernel.org>; Wed,  5 May 2021 09:20:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232813AbhEEJVD (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 5 May 2021 05:21:03 -0400
Received: from mx2.suse.de ([195.135.220.15]:42078 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232511AbhEEJUk (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 5 May 2021 05:20:40 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 22282B288;
        Wed,  5 May 2021 09:19:42 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>, Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Karsten Keil <isdn@linux-pingi.de>
Subject: [PATCH 31/35] tty: remove empty tty_operations::set_termios
Date:   Wed,  5 May 2021 11:19:24 +0200
Message-Id: <20210505091928.22010-32-jslaby@suse.cz>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210505091928.22010-1-jslaby@suse.cz>
References: <20210505091928.22010-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

tty_operations::set_termios is optional. If it doesn't exist, nothing is
called. So remove almost¹ empty set_termios implementations.

¹ capi had an useless pr_debug in it.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Cc: Jeff Dike <jdike@addtoit.com>
Cc: Richard Weinberger <richard@nod.at>
Cc: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc: Karsten Keil <isdn@linux-pingi.de>
---
 arch/um/drivers/line.c          | 5 -----
 arch/um/drivers/line.h          | 1 -
 arch/um/drivers/ssl.c           | 1 -
 arch/um/drivers/stdio_console.c | 1 -
 drivers/isdn/capi/capi.c        | 6 ------
 5 files changed, 14 deletions(-)

diff --git a/arch/um/drivers/line.c b/arch/um/drivers/line.c
index 159434851417..fbc623d2cc07 100644
--- a/arch/um/drivers/line.c
+++ b/arch/um/drivers/line.c
@@ -211,11 +211,6 @@ int line_write(struct tty_struct *tty, const unsigned char *buf, int len)
 	return ret;
 }
 
-void line_set_termios(struct tty_struct *tty, struct ktermios * old)
-{
-	/* nothing */
-}
-
 void line_throttle(struct tty_struct *tty)
 {
 	struct line *line = tty->driver_data;
diff --git a/arch/um/drivers/line.h b/arch/um/drivers/line.h
index 3325e2bc64e4..bdb16b96e76f 100644
--- a/arch/um/drivers/line.h
+++ b/arch/um/drivers/line.h
@@ -66,7 +66,6 @@ extern int line_setup(char **conf, unsigned nlines, char **def,
 		      char *init, char *name);
 extern int line_write(struct tty_struct *tty, const unsigned char *buf,
 		      int len);
-extern void line_set_termios(struct tty_struct *tty, struct ktermios * old);
 extern unsigned int line_chars_in_buffer(struct tty_struct *tty);
 extern void line_flush_buffer(struct tty_struct *tty);
 extern void line_flush_chars(struct tty_struct *tty);
diff --git a/arch/um/drivers/ssl.c b/arch/um/drivers/ssl.c
index 6476b28d7c5e..41eae2e8fb65 100644
--- a/arch/um/drivers/ssl.c
+++ b/arch/um/drivers/ssl.c
@@ -99,7 +99,6 @@ static const struct tty_operations ssl_ops = {
 	.chars_in_buffer 	= line_chars_in_buffer,
 	.flush_buffer 		= line_flush_buffer,
 	.flush_chars 		= line_flush_chars,
-	.set_termios 		= line_set_termios,
 	.throttle 		= line_throttle,
 	.unthrottle 		= line_unthrottle,
 	.install		= ssl_install,
diff --git a/arch/um/drivers/stdio_console.c b/arch/um/drivers/stdio_console.c
index 37b127941e6f..e8b762f4d8c2 100644
--- a/arch/um/drivers/stdio_console.c
+++ b/arch/um/drivers/stdio_console.c
@@ -106,7 +106,6 @@ static const struct tty_operations console_ops = {
 	.chars_in_buffer 	= line_chars_in_buffer,
 	.flush_buffer 		= line_flush_buffer,
 	.flush_chars 		= line_flush_chars,
-	.set_termios 		= line_set_termios,
 	.throttle 		= line_throttle,
 	.unthrottle 		= line_unthrottle,
 	.hangup			= line_hangup,
diff --git a/drivers/isdn/capi/capi.c b/drivers/isdn/capi/capi.c
index 6d99b93bb09e..693b0bc31395 100644
--- a/drivers/isdn/capi/capi.c
+++ b/drivers/isdn/capi/capi.c
@@ -1197,11 +1197,6 @@ static unsigned int capinc_tty_chars_in_buffer(struct tty_struct *tty)
 	return mp->outbytes;
 }
 
-static void capinc_tty_set_termios(struct tty_struct *tty, struct ktermios *old)
-{
-	pr_debug("capinc_tty_set_termios\n");
-}
-
 static void capinc_tty_throttle(struct tty_struct *tty)
 {
 	struct capiminor *mp = tty->driver_data;
@@ -1267,7 +1262,6 @@ static const struct tty_operations capinc_ops = {
 	.flush_chars = capinc_tty_flush_chars,
 	.write_room = capinc_tty_write_room,
 	.chars_in_buffer = capinc_tty_chars_in_buffer,
-	.set_termios = capinc_tty_set_termios,
 	.throttle = capinc_tty_throttle,
 	.unthrottle = capinc_tty_unthrottle,
 	.stop = capinc_tty_stop,
-- 
2.31.1


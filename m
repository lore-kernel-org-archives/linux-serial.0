Return-Path: <SRS0=TTKI=74=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72727C433DF
	for <linux-serial@archiver.kernel.org>; Mon, 15 Jun 2020 07:49:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A23E2067B
	for <linux-serial@archiver.kernel.org>; Mon, 15 Jun 2020 07:49:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728180AbgFOHtB (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 15 Jun 2020 03:49:01 -0400
Received: from mx2.suse.de ([195.135.220.15]:39800 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726111AbgFOHtA (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 15 Jun 2020 03:49:00 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id DA730AB76;
        Mon, 15 Jun 2020 07:49:01 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>, Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>
Subject: [PATCH] um: line, remove put_char
Date:   Mon, 15 Jun 2020 09:48:56 +0200
Message-Id: <20200615074856.18949-1-jslaby@suse.cz>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

um's put_char only calls write. And the tty layer/disciplines do the
same if put_char is NULL.

So we can safely remove this put_char wrapper.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Cc: Jeff Dike <jdike@addtoit.com>
Cc: Richard Weinberger <richard@nod.at>
Cc: Anton Ivanov <anton.ivanov@cambridgegreys.com>
---
 arch/um/drivers/line.c          | 5 -----
 arch/um/drivers/line.h          | 1 -
 arch/um/drivers/ssl.c           | 1 -
 arch/um/drivers/stdio_console.c | 1 -
 4 files changed, 8 deletions(-)

diff --git a/arch/um/drivers/line.c b/arch/um/drivers/line.c
index 4f2a4ac8a82b..14ad9f495fe6 100644
--- a/arch/um/drivers/line.c
+++ b/arch/um/drivers/line.c
@@ -184,11 +184,6 @@ void line_flush_chars(struct tty_struct *tty)
 	line_flush_buffer(tty);
 }
 
-int line_put_char(struct tty_struct *tty, unsigned char ch)
-{
-	return line_write(tty, &ch, sizeof(ch));
-}
-
 int line_write(struct tty_struct *tty, const unsigned char *buf, int len)
 {
 	struct line *line = tty->driver_data;
diff --git a/arch/um/drivers/line.h b/arch/um/drivers/line.h
index a151ff5155ef..01d21e76144f 100644
--- a/arch/um/drivers/line.h
+++ b/arch/um/drivers/line.h
@@ -66,7 +66,6 @@ extern int line_setup(char **conf, unsigned nlines, char **def,
 		      char *init, char *name);
 extern int line_write(struct tty_struct *tty, const unsigned char *buf,
 		      int len);
-extern int line_put_char(struct tty_struct *tty, unsigned char ch);
 extern void line_set_termios(struct tty_struct *tty, struct ktermios * old);
 extern int line_chars_in_buffer(struct tty_struct *tty);
 extern void line_flush_buffer(struct tty_struct *tty);
diff --git a/arch/um/drivers/ssl.c b/arch/um/drivers/ssl.c
index 26c5716fac0f..6476b28d7c5e 100644
--- a/arch/um/drivers/ssl.c
+++ b/arch/um/drivers/ssl.c
@@ -95,7 +95,6 @@ static const struct tty_operations ssl_ops = {
 	.open 	 		= line_open,
 	.close 	 		= line_close,
 	.write 	 		= line_write,
-	.put_char 		= line_put_char,
 	.write_room		= line_write_room,
 	.chars_in_buffer 	= line_chars_in_buffer,
 	.flush_buffer 		= line_flush_buffer,
diff --git a/arch/um/drivers/stdio_console.c b/arch/um/drivers/stdio_console.c
index 0021d7ffb528..37b127941e6f 100644
--- a/arch/um/drivers/stdio_console.c
+++ b/arch/um/drivers/stdio_console.c
@@ -102,7 +102,6 @@ static const struct tty_operations console_ops = {
 	.install		= con_install,
 	.close 	 		= line_close,
 	.write 	 		= line_write,
-	.put_char 		= line_put_char,
 	.write_room		= line_write_room,
 	.chars_in_buffer 	= line_chars_in_buffer,
 	.flush_buffer 		= line_flush_buffer,
-- 
2.27.0


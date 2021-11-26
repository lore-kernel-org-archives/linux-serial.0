Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70595C4332F
	for <linux-serial@archiver.kernel.org>; Fri, 26 Nov 2021 08:20:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359662AbhKZIXb (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 26 Nov 2021 03:23:31 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:50588 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359342AbhKZIV1 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 26 Nov 2021 03:21:27 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 55B7321B46;
        Fri, 26 Nov 2021 08:16:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1637914575; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xWIUifQzmUVkKLOyDHBRWxkbnjGtJbDbv63GA+nOpYc=;
        b=WHmCySgsgyfOSeim54KnQ2P57hErVonMXW/AoYv7eABXgtYd0dEf1RLSa8gQqQ6wECAtO4
        8KUZlgeXVUGiuvElLD4CeQSQwEZEADHtTXuLZVIC0wYmL11CV15K72r0m5CwOmvNgx1fKh
        6/THrNaRlD1+6p+FiQ4gHL0+B8gT00A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1637914575;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xWIUifQzmUVkKLOyDHBRWxkbnjGtJbDbv63GA+nOpYc=;
        b=vyky0hkaKMPJ7W8AlFOXf4JOf/gxoOGIJXAtXnaM2jzM9e/jOMMKu1G4zdIsDxHoy3O11D
        IBGss8Y01+EJJQCg==
Received: from localhost.localdomain (unknown [10.100.208.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 28858A3B81;
        Fri, 26 Nov 2021 08:16:15 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 15/23] tty: fix kernel-doc in n_tty.c
Date:   Fri, 26 Nov 2021 09:16:03 +0100
Message-Id: <20211126081611.11001-16-jslaby@suse.cz>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20211126081611.11001-1-jslaby@suse.cz>
References: <20211126081611.11001-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

* process_echoes doc was a misnomer
* isig and n_tty_receive_char docs were misplaced
* n_tty_read parameters were incorrect (from pre-cookie times)

So fix all the warnings at once:
624: warning: expecting prototype for process_echoes(). Prototype was for __process_echoes() instead
1110: warning: expecting prototype for isig(). Prototype was for __isig() instead
1264: warning: expecting prototype for n_tty_receive_char(). Prototype was for n_tty_receive_char_special() instead
2067: warning: Excess function parameter 'buf' description in 'n_tty_read'
624: warning: expecting prototype for process_echoes(). Prototype was for __process_echoes() instead
1110: warning: expecting prototype for isig(). Prototype was for __isig() instead
1264: warning: expecting prototype for n_tty_receive_char(). Prototype was for n_tty_receive_char_special() instead
2067: warning: Function parameter or member 'kbuf' not described in 'n_tty_read'
2067: warning: Function parameter or member 'cookie' not described in 'n_tty_read'
2067: warning: Function parameter or member 'offset' not described in 'n_tty_read'
2067: warning: Excess function parameter 'buf' description in 'n_tty_read'

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/n_tty.c | 53 +++++++++++++++++++++++----------------------
 1 file changed, 27 insertions(+), 26 deletions(-)

diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
index 2d64d93805af..538bd968a23d 100644
--- a/drivers/tty/n_tty.c
+++ b/drivers/tty/n_tty.c
@@ -596,7 +596,7 @@ static ssize_t process_output_block(struct tty_struct *tty,
 }
 
 /**
- *	process_echoes	-	write pending echo characters
+ *	__process_echoes	-	write pending echo characters
  *	@tty: terminal device
  *
  *	Write previously buffered echo (and other ldisc-generated)
@@ -619,7 +619,6 @@ static ssize_t process_output_block(struct tty_struct *tty,
  *
  *	Locking: callers must hold output_lock
  */
-
 static size_t __process_echoes(struct tty_struct *tty)
 {
 	struct n_tty_data *ldata = tty->disc_data;
@@ -1091,6 +1090,16 @@ static void eraser(unsigned char c, struct tty_struct *tty)
 		finish_erasing(ldata);
 }
 
+
+static void __isig(int sig, struct tty_struct *tty)
+{
+	struct pid *tty_pgrp = tty_get_pgrp(tty);
+	if (tty_pgrp) {
+		kill_pgrp(tty_pgrp, sig, 1);
+		put_pid(tty_pgrp);
+	}
+}
+
 /**
  *	isig		-	handle the ISIG optio
  *	@sig: signal
@@ -1105,16 +1114,6 @@ static void eraser(unsigned char c, struct tty_struct *tty)
  *
  *	Locking: ctrl.lock
  */
-
-static void __isig(int sig, struct tty_struct *tty)
-{
-	struct pid *tty_pgrp = tty_get_pgrp(tty);
-	if (tty_pgrp) {
-		kill_pgrp(tty_pgrp, sig, 1);
-		put_pid(tty_pgrp);
-	}
-}
-
 static void isig(int sig, struct tty_struct *tty)
 {
 	struct n_tty_data *ldata = tty->disc_data;
@@ -1247,19 +1246,6 @@ n_tty_receive_signal_char(struct tty_struct *tty, int signal, unsigned char c)
 		process_echoes(tty);
 }
 
-/**
- *	n_tty_receive_char	-	perform processing
- *	@tty: terminal device
- *	@c: character
- *
- *	Process an individual character of input received from the driver.
- *	This is serialized with respect to itself by the rules for the
- *	driver above.
- *
- *	n_tty_receive_buf()/producer path:
- *		caller holds non-exclusive termios_rwsem
- *		publishes canon_head if canonical mode is active
- */
 static void n_tty_receive_char_special(struct tty_struct *tty, unsigned char c)
 {
 	struct n_tty_data *ldata = tty->disc_data;
@@ -1394,6 +1380,19 @@ static void n_tty_receive_char_special(struct tty_struct *tty, unsigned char c)
 	put_tty_queue(c, ldata);
 }
 
+/**
+ *	n_tty_receive_char	-	perform processing
+ *	@tty: terminal device
+ *	@c: character
+ *
+ *	Process an individual character of input received from the driver.
+ *	This is serialized with respect to itself by the rules for the
+ *	driver above.
+ *
+ *	n_tty_receive_buf()/producer path:
+ *		caller holds non-exclusive termios_rwsem
+ *		publishes canon_head if canonical mode is active
+ */
 static void n_tty_receive_char(struct tty_struct *tty, unsigned char c)
 {
 	struct n_tty_data *ldata = tty->disc_data;
@@ -2046,8 +2045,10 @@ static int job_control(struct tty_struct *tty, struct file *file)
  *	n_tty_read		-	read function for tty
  *	@tty: tty device
  *	@file: file object
- *	@buf: userspace buffer pointer
+ *	@kbuf: kernelspace buffer pointer
  *	@nr: size of I/O
+ *	@cookie: if non-%NULL, this is a continuation read
+ *	@offset: where to continue reading from (unused in n_tty)
  *
  *	Perform reads for the line discipline. We are guaranteed that the
  *	line discipline will not be closed under us but we may get multiple
-- 
2.34.0


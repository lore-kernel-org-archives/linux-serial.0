Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4063DC433E0
	for <linux-serial@archiver.kernel.org>; Thu, 21 Jan 2021 09:42:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7B3023975
	for <linux-serial@archiver.kernel.org>; Thu, 21 Jan 2021 09:42:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728723AbhAUJlp (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 21 Jan 2021 04:41:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:36848 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728358AbhAUJBa (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 21 Jan 2021 04:01:30 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id B7CF7239D1;
        Thu, 21 Jan 2021 09:00:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1611219650;
        bh=d7B6Q+MrQYXKsRPWSNaOGucuXxTtWybTduIueMuOFao=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sXuZMgQTk0q/baEoxRVgtXlfTVmrQsjAhWdqBeptSnq616YEorX/Zz5qCNoxYQQcz
         PvYE6FYeSVqOABhXWjAbrz9InxhCjesk/9yp9rQv1f5n5YyvIoVq+hRqNUho4BwNNp
         N8iKSAiDO+Glh+Ch9FJK4uGWyI9PGGa4BH6ictgI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     jirislaby@kernel.org, linux-serial@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, hch@lst.de, viro@zeniv.linux.org.uk,
        linux-kernel@vger.kernel.org, ohw.giles@gmail.com,
        r.karszniewicz@phytec.de,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 6/6] tty: teach the n_tty ICANON case about the new "cookie continuations" too
Date:   Thu, 21 Jan 2021 10:00:20 +0100
Message-Id: <20210121090020.3147058-6-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210121090020.3147058-1-gregkh@linuxfoundation.org>
References: <20210121090020.3147058-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Linus Torvalds <torvalds@linux-foundation.org>

The ICANON case is a bit messy, since it has to look for the line
ending, and has special code to then suppress line ending characters if
they match the __DISABLED_CHAR.  So it actually looks up the line ending
even past the point where it knows it won't copy it to the result
buffer.

That said, apart from all those odd legacy N_TTY ICANON cases, the
actual "should we continue copying" logic isn't really all that
complicated or different from the non-canon case.  In fact, the lack of
"wait for at least N characters" arguably makes the repeat case slightly
simpler.  It really just boils down to "there's more of the line to be
copied".

So add the necessarily trivial logic, and now the N_TTY case will give
long result lines even when in canon mode.

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---
 drivers/tty/n_tty.c | 26 +++++++++++++++++++-------
 1 file changed, 19 insertions(+), 7 deletions(-)

diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
index b89308d52ade..9e546d0cc55c 100644
--- a/drivers/tty/n_tty.c
+++ b/drivers/tty/n_tty.c
@@ -2009,21 +2009,22 @@ static bool copy_from_read_buf(struct tty_struct *tty,
  *		read_tail published
  */
 
-static void canon_copy_from_read_buf(struct tty_struct *tty,
+static bool canon_copy_from_read_buf(struct tty_struct *tty,
 				     unsigned char **kbp,
 				     size_t *nr)
 {
 	struct n_tty_data *ldata = tty->disc_data;
 	size_t n, size, more, c;
 	size_t eol;
-	size_t tail;
+	size_t tail, canon_head;
 	int found = 0;
 
 	/* N.B. avoid overrun if nr == 0 */
 	if (!*nr)
-		return;
+		return false;
 
-	n = min(*nr + 1, smp_load_acquire(&ldata->canon_head) - ldata->read_tail);
+	canon_head = smp_load_acquire(&ldata->canon_head);
+	n = min(*nr + 1, canon_head - ldata->read_tail);
 
 	tail = ldata->read_tail & (N_TTY_BUF_SIZE - 1);
 	size = min_t(size_t, tail + n, N_TTY_BUF_SIZE);
@@ -2067,7 +2068,11 @@ static void canon_copy_from_read_buf(struct tty_struct *tty,
 		else
 			ldata->push = 0;
 		tty_audit_push();
+		return false;
 	}
+
+	/* No EOL found - do a continuation retry if there is more data */
+	return ldata->read_tail != canon_head;
 }
 
 extern ssize_t redirected_tty_write(struct file *, const char __user *,
@@ -2141,8 +2146,13 @@ static ssize_t n_tty_read(struct tty_struct *tty, struct file *file,
 	 * termios_rwsem, and can just continue to copy data.
 	 */
 	if (*cookie) {
-		if (copy_from_read_buf(tty, &kb, &nr))
-			return kb - kbuf;
+		if (ldata->icanon && !L_EXTPROC(tty)) {
+			if (canon_copy_from_read_buf(tty, &kb, &nr))
+				return kb - kbuf;
+		} else {
+			if (copy_from_read_buf(tty, &kb, &nr))
+				return kb - kbuf;
+		}
 
 		/* No more data - release locks and stop retries */
 		n_tty_kick_worker(tty);
@@ -2239,7 +2249,8 @@ static ssize_t n_tty_read(struct tty_struct *tty, struct file *file,
 		}
 
 		if (ldata->icanon && !L_EXTPROC(tty)) {
-			canon_copy_from_read_buf(tty, &kb, &nr);
+			if (canon_copy_from_read_buf(tty, &kb, &nr))
+				goto more_to_be_read;
 		} else {
 			/* Deal with packet mode. */
 			if (packet && kb == kbuf) {
@@ -2257,6 +2268,7 @@ static ssize_t n_tty_read(struct tty_struct *tty, struct file *file,
 			 * will release them when done.
 			 */
 			if (copy_from_read_buf(tty, &kb, &nr) && kb - kbuf >= minimum) {
+more_to_be_read:
 				remove_wait_queue(&tty->read_wait, &wait);
 				*cookie = cookie;
 				return kb - kbuf;
-- 
2.30.0


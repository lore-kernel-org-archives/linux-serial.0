Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EA6FC433DB
	for <linux-serial@archiver.kernel.org>; Thu, 21 Jan 2021 09:02:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD13F23602
	for <linux-serial@archiver.kernel.org>; Thu, 21 Jan 2021 09:02:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728128AbhAUJCB (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 21 Jan 2021 04:02:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:36746 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728192AbhAUJBZ (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 21 Jan 2021 04:01:25 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 69F77239D3;
        Thu, 21 Jan 2021 09:00:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1611219645;
        bh=dDUjS4EvPptksdmDNHTIiYldi+hap7CTKjBhDBkBOBI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uHwKLx8EAIcecMW0pB/c8M6GSsD+ML3kjEBjGKPC2yTzspsaFvJt0mAmykDB7na5U
         HYhsqY5coFslO7tqi+kbZmFxUGlktmaZt54inMatU3zeqPGGy1e4jB7jizTx5R0NbL
         QPyWtNHdpk+nwg6TzzwxpqInQSqEwqsf0FbBS/hE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     jirislaby@kernel.org, linux-serial@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, hch@lst.de, viro@zeniv.linux.org.uk,
        linux-kernel@vger.kernel.org, ohw.giles@gmail.com,
        r.karszniewicz@phytec.de,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4/6] tty: clean up legacy leftovers from n_tty line discipline
Date:   Thu, 21 Jan 2021 10:00:18 +0100
Message-Id: <20210121090020.3147058-4-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210121090020.3147058-1-gregkh@linuxfoundation.org>
References: <20210121090020.3147058-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Linus Torvalds <torvalds@linux-foundation.org>

Back when the line disciplines did their own direct user accesses, they
had to deal with the data copy possibly failing in the middle.

Now that the user copy is done by the tty_io.c code, that failure case
no longer exists.

Remove the left-over error handling code that cannot trigger.

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---
 drivers/tty/n_tty.c | 29 +++++++++--------------------
 1 file changed, 9 insertions(+), 20 deletions(-)

diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
index 4a34a9f43b29..3a1a79462d16 100644
--- a/drivers/tty/n_tty.c
+++ b/drivers/tty/n_tty.c
@@ -1955,19 +1955,17 @@ static inline int input_available_p(struct tty_struct *tty, int poll)
  *		read_tail published
  */
 
-static int copy_from_read_buf(struct tty_struct *tty,
+static void copy_from_read_buf(struct tty_struct *tty,
 				      unsigned char **kbp,
 				      size_t *nr)
 
 {
 	struct n_tty_data *ldata = tty->disc_data;
-	int retval;
 	size_t n;
 	bool is_eof;
 	size_t head = smp_load_acquire(&ldata->commit_head);
 	size_t tail = ldata->read_tail & (N_TTY_BUF_SIZE - 1);
 
-	retval = 0;
 	n = min(head - ldata->read_tail, N_TTY_BUF_SIZE - tail);
 	n = min(*nr, n);
 	if (n) {
@@ -1984,7 +1982,6 @@ static int copy_from_read_buf(struct tty_struct *tty,
 		*kbp += n;
 		*nr -= n;
 	}
-	return retval;
 }
 
 /**
@@ -2010,9 +2007,9 @@ static int copy_from_read_buf(struct tty_struct *tty,
  *		read_tail published
  */
 
-static int canon_copy_from_read_buf(struct tty_struct *tty,
-				    unsigned char **kbp,
-				    size_t *nr)
+static void canon_copy_from_read_buf(struct tty_struct *tty,
+				     unsigned char **kbp,
+				     size_t *nr)
 {
 	struct n_tty_data *ldata = tty->disc_data;
 	size_t n, size, more, c;
@@ -2022,7 +2019,7 @@ static int canon_copy_from_read_buf(struct tty_struct *tty,
 
 	/* N.B. avoid overrun if nr == 0 */
 	if (!*nr)
-		return 0;
+		return;
 
 	n = min(*nr + 1, smp_load_acquire(&ldata->canon_head) - ldata->read_tail);
 
@@ -2069,7 +2066,6 @@ static int canon_copy_from_read_buf(struct tty_struct *tty,
 			ldata->push = 0;
 		tty_audit_push();
 	}
-	return 0;
 }
 
 extern ssize_t redirected_tty_write(struct file *, const char __user *,
@@ -2222,24 +2218,17 @@ static ssize_t n_tty_read(struct tty_struct *tty, struct file *file,
 		}
 
 		if (ldata->icanon && !L_EXTPROC(tty)) {
-			retval = canon_copy_from_read_buf(tty, &kb, &nr);
-			if (retval)
-				break;
+			canon_copy_from_read_buf(tty, &kb, &nr);
 		} else {
-			int uncopied;
-
 			/* Deal with packet mode. */
 			if (packet && kb == kbuf) {
 				*kb++ = TIOCPKT_DATA;
 				nr--;
 			}
 
-			uncopied = copy_from_read_buf(tty, &kb, &nr);
-			uncopied += copy_from_read_buf(tty, &kb, &nr);
-			if (uncopied) {
-				retval = -EFAULT;
-				break;
-			}
+			/* See comment above copy_from_read_buf() why twice */
+			copy_from_read_buf(tty, &kb, &nr);
+			copy_from_read_buf(tty, &kb, &nr);
 		}
 
 		n_tty_check_unthrottle(tty);
-- 
2.30.0


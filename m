Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFD62C433E0
	for <linux-serial@archiver.kernel.org>; Thu, 21 Jan 2021 09:42:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 94A952399A
	for <linux-serial@archiver.kernel.org>; Thu, 21 Jan 2021 09:42:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728728AbhAUJlo (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 21 Jan 2021 04:41:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:36800 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728357AbhAUJBa (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 21 Jan 2021 04:01:30 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E709D239D4;
        Thu, 21 Jan 2021 09:00:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1611219647;
        bh=ZQ3Z7a02ovbA4sCg+DtDcdngxJVq2M1jXjk+wzP7ddQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nF8g6t7ggJhh01a2RfdVM/F9LEL5SUEU/++0TZwMsHCANcj7cQl4qTuqGvNF9eHwu
         coeLMyzy69QxaPqETu4b4JOU3vCxNjcN4nUZuBFb6UIOX0jDkuluKoSz/3/wsu1aXX
         DPmeEQJScTP2eKWW8fJrYBXdH3z0qd6h48luTVIw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     jirislaby@kernel.org, linux-serial@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, hch@lst.de, viro@zeniv.linux.org.uk,
        linux-kernel@vger.kernel.org, ohw.giles@gmail.com,
        r.karszniewicz@phytec.de,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 5/6] tty: teach n_tty line discipline about the new "cookie continuations"
Date:   Thu, 21 Jan 2021 10:00:19 +0100
Message-Id: <20210121090020.3147058-5-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210121090020.3147058-1-gregkh@linuxfoundation.org>
References: <20210121090020.3147058-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Linus Torvalds <torvalds@linux-foundation.org>

With the conversion to do the tty ldisc read operations in small chunks,
the n_tty line discipline became noticeably slower for throughput
oriented loads, because rather than read things in up to 2kB chunks, it
would return at most 64 bytes per read() system call.

The cost is mainly all in the "do system calls over and over", not
really in the new "copy to an extra kernel buffer".

This can be fixed by teaching the n_tty line discipline about the
"cookie continuation" model, which the chunking code supports because
things like hdlc need to be able to handle packets up to 64kB in size.

Doing that doesn't just get us back to the old performace, but to much
better performance: my stupid "copy 10MB of data over a pty" test
program is now almost twice as fast as it used to be (going down from
0.1s to 0.054s).

This is entirely because it now creates maximal chunks (which happens to
be "one byte less than one page" due to how we do the circular tty
buffers).

NOTE! This case only handles the simpler non-icanon case, which is the
one where people may care about throughput.  I'm going to do the icanon
case later too, because while performance isn't a major issue for that,
there may be programs that think they'll always get a full line and
don't like the 64-byte chunking for that reason.

Such programs are arguably buggy (signals etc can cause random partial
results from tty reads anyway), and good programs will handle such
partial reads, but expecting everybody to write "good programs" has
never been a winning policy for the kernel..

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---
 drivers/tty/n_tty.c | 52 ++++++++++++++++++++++++++++++++++++---------
 1 file changed, 42 insertions(+), 10 deletions(-)

diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
index 3a1a79462d16..b89308d52ade 100644
--- a/drivers/tty/n_tty.c
+++ b/drivers/tty/n_tty.c
@@ -1943,19 +1943,17 @@ static inline int input_available_p(struct tty_struct *tty, int poll)
  *	Helper function to speed up n_tty_read.  It is only called when
  *	ICANON is off; it copies characters straight from the tty queue.
  *
- *	It can be profitably called twice; once to drain the space from
- *	the tail pointer to the (physical) end of the buffer, and once
- *	to drain the space from the (physical) beginning of the buffer
- *	to head pointer.
- *
  *	Called under the ldata->atomic_read_lock sem
  *
+ *	Returns true if it successfully copied data, but there is still
+ *	more data to be had.
+ *
  *	n_tty_read()/consumer path:
  *		caller holds non-exclusive termios_rwsem
  *		read_tail published
  */
 
-static void copy_from_read_buf(struct tty_struct *tty,
+static bool copy_from_read_buf(struct tty_struct *tty,
 				      unsigned char **kbp,
 				      size_t *nr)
 
@@ -1978,10 +1976,14 @@ static void copy_from_read_buf(struct tty_struct *tty,
 		/* Turn single EOF into zero-length read */
 		if (L_EXTPROC(tty) && ldata->icanon && is_eof &&
 		    (head == ldata->read_tail))
-			n = 0;
+			return false;
 		*kbp += n;
 		*nr -= n;
+
+		/* If we have more to copy, let the caller know */
+		return head != ldata->read_tail;
 	}
+	return false;
 }
 
 /**
@@ -2132,6 +2134,25 @@ static ssize_t n_tty_read(struct tty_struct *tty, struct file *file,
 	int packet;
 	size_t tail;
 
+	/*
+	 * Is this a continuation of a read started earler?
+	 *
+	 * If so, we still hold the atomic_read_lock and the
+	 * termios_rwsem, and can just continue to copy data.
+	 */
+	if (*cookie) {
+		if (copy_from_read_buf(tty, &kb, &nr))
+			return kb - kbuf;
+
+		/* No more data - release locks and stop retries */
+		n_tty_kick_worker(tty);
+		n_tty_check_unthrottle(tty);
+		up_read(&tty->termios_rwsem);
+		mutex_unlock(&ldata->atomic_read_lock);
+		*cookie = NULL;
+		return kb - kbuf;
+	}
+
 	c = job_control(tty, file);
 	if (c < 0)
 		return c;
@@ -2226,9 +2247,20 @@ static ssize_t n_tty_read(struct tty_struct *tty, struct file *file,
 				nr--;
 			}
 
-			/* See comment above copy_from_read_buf() why twice */
-			copy_from_read_buf(tty, &kb, &nr);
-			copy_from_read_buf(tty, &kb, &nr);
+			/*
+			 * Copy data, and if there is more to be had
+			 * and we have nothing more to wait for, then
+			 * let's mark us for retries.
+			 *
+			 * NOTE! We return here with both the termios_sem
+			 * and atomic_read_lock still held, the retries
+			 * will release them when done.
+			 */
+			if (copy_from_read_buf(tty, &kb, &nr) && kb - kbuf >= minimum) {
+				remove_wait_queue(&tty->read_wait, &wait);
+				*cookie = cookie;
+				return kb - kbuf;
+			}
 		}
 
 		n_tty_check_unthrottle(tty);
-- 
2.30.0


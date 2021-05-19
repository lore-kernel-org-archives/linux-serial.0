Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FC38C433B4
	for <linux-serial@archiver.kernel.org>; Wed, 19 May 2021 07:21:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75B8B6135C
	for <linux-serial@archiver.kernel.org>; Wed, 19 May 2021 07:21:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239624AbhESHXP (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 19 May 2021 03:23:15 -0400
Received: from mx2.suse.de ([195.135.220.15]:39364 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237886AbhESHXP (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 19 May 2021 03:23:15 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 010FFAF06;
        Wed, 19 May 2021 07:21:55 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 3/4] tty: fix kernel-doc for tty_{read,write}
Date:   Wed, 19 May 2021 09:21:52 +0200
Message-Id: <20210519072153.3859-3-jslaby@suse.cz>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210519072153.3859-1-jslaby@suse.cz>
References: <20210519072153.3859-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

After commits a9cbbb80e3e7 (tty: avoid using vfs_iocb_iter_write() for
redirected console writes) and dd78b0c483e3 (tty: implement read_iter),
the tty_read and tty_write kernel-doc comments don't match the code:
 tty_io.c:931: warning: Function parameter or member 'iocb' not described in 'tty_read'
 tty_io.c:931: warning: Function parameter or member 'to' not described in 'tty_read'
 tty_io.c:931: warning: Excess function parameter 'file' description in 'tty_read'
 tty_io.c:931: warning: Excess function parameter 'buf' description in 'tty_read'
 tty_io.c:931: warning: Excess function parameter 'count' description in 'tty_read'
 tty_io.c:931: warning: Excess function parameter 'ppos' description in 'tty_read'
 tty_io.c:1115: warning: Function parameter or member 'iocb' not described in 'file_tty_write'
 tty_io.c:1115: warning: Function parameter or member 'from' not described in 'file_tty_write'
 tty_io.c:1115: warning: expecting prototype for tty_write(). Prototype was for file_tty_write() instead

Fix them to correspond the reality, i.e. the switch from read/write to
read_iter/write_iter.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
---
 drivers/tty/tty_io.c | 37 ++++++++++++++++---------------------
 1 file changed, 16 insertions(+), 21 deletions(-)

diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index 8f9e89715a68..ad64232cecae 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -911,10 +911,8 @@ static int iterate_tty_read(struct tty_ldisc *ld, struct tty_struct *tty,
 
 /**
  *	tty_read	-	read method for tty device files
- *	@file: pointer to tty file
- *	@buf: user buffer
- *	@count: size of user buffer
- *	@ppos: unused
+ *	@iocb: kernel I/O control block
+ *	@to: destination for the data read
  *
  *	Perform the read system call function on this terminal device. Checks
  *	for hung up devices before calling the line discipline method.
@@ -1092,23 +1090,6 @@ void tty_write_message(struct tty_struct *tty, char *msg)
 	}
 }
 
-
-/**
- *	tty_write		-	write method for tty device file
- *	@file: tty file pointer
- *	@buf: user data to write
- *	@count: bytes to write
- *	@ppos: unused
- *
- *	Write data to a tty device via the line discipline.
- *
- *	Locking:
- *		Locks the line discipline as required
- *		Writes to the tty driver are serialized by the atomic_write_lock
- *	and are then processed in chunks to the device. The line discipline
- *	write method will not be invoked in parallel for each device.
- */
-
 static ssize_t file_tty_write(struct file *file, struct kiocb *iocb, struct iov_iter *from)
 {
 	struct tty_struct *tty = file_tty(file);
@@ -1133,6 +1114,20 @@ static ssize_t file_tty_write(struct file *file, struct kiocb *iocb, struct iov_
 	return ret;
 }
 
+/**
+ *	tty_write		-	write method for tty device file
+ *	@iocb: kernel I/O control block
+ *	@from: iov_iter with data to write
+ *
+ *	Write data to a tty device via the line discipline.
+ *
+ *	Locking:
+ *		Locks the line discipline as required
+ *		Writes to the tty driver are serialized by the atomic_write_lock
+ *		and are then processed in chunks to the device. The line
+ *		discipline write method will not be invoked in parallel for
+ *		each device.
+ */
 static ssize_t tty_write(struct kiocb *iocb, struct iov_iter *from)
 {
 	return file_tty_write(iocb->ki_filp, iocb, from);
-- 
2.31.1


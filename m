Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAC28C433F5
	for <linux-serial@archiver.kernel.org>; Fri, 26 Nov 2021 08:20:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353115AbhKZIX2 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 26 Nov 2021 03:23:28 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:50584 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359299AbhKZIV1 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 26 Nov 2021 03:21:27 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 16A5D21B44;
        Fri, 26 Nov 2021 08:16:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1637914574; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LHdoX2TFrzdW7aX+01KailxH5O+D1089XfQaEToUYYI=;
        b=XP673NoRwvwwaQYSwKnXQvzISpWX7y3+FKp7o68KzclON+NBT3LW7vjLQesIjQjliCv2cz
        4fv70k/XRj4EYX+a0U01dDxKTmC8MYsVJ1XFXSn4LKXHKnW0o8+qSrtX+scw7eC4uLkQmf
        erJsfiufc5j+erueYfiHZpLYSqMzzqI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1637914574;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LHdoX2TFrzdW7aX+01KailxH5O+D1089XfQaEToUYYI=;
        b=BgTId9+grcGsOMp8sytc0+4L+Gaps86DY0limKRXOefPMb8GXRBQ5coDX/CpK7O5tzrgQc
        yT+UuiPfaFxZ4qDg==
Received: from localhost.localdomain (unknown [10.100.208.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id DE92EA3B81;
        Fri, 26 Nov 2021 08:16:13 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 09/23] tty: reformat tty_struct::flags into kernel-doc
Date:   Fri, 26 Nov 2021 09:15:57 +0100
Message-Id: <20211126081611.11001-10-jslaby@suse.cz>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20211126081611.11001-1-jslaby@suse.cz>
References: <20211126081611.11001-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Move the partial tty_struct::flags documentation from tty_ldisc to the
tty.h header and combine it with the one-liners present there. Convert
all those to kernel-doc. This way, we can simply reference the
documentation in Documentation while the text is still along the
definitions.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 Documentation/driver-api/serial/tty.rst | 24 +-------
 include/linux/tty.h                     | 74 ++++++++++++++++++++-----
 2 files changed, 62 insertions(+), 36 deletions(-)

diff --git a/Documentation/driver-api/serial/tty.rst b/Documentation/driver-api/serial/tty.rst
index 333a5923f6e1..65f971e3aada 100644
--- a/Documentation/driver-api/serial/tty.rst
+++ b/Documentation/driver-api/serial/tty.rst
@@ -47,28 +47,8 @@ These are documented as a part of struct tty_operations.
 Flags
 ^^^^^
 
-Line discipline methods have access to tty->flags field containing the
-following interesting flags:
-
-======================= =======================================================
-TTY_THROTTLED		Driver input is throttled. The ldisc should call
-			tty->driver->unthrottle() in order to resume
-			reception when it is ready to process more data.
-
-TTY_DO_WRITE_WAKEUP	If set, causes the driver to call the ldisc's
-			write_wakeup() method in order to resume
-			transmission when it can accept more data
-			to transmit.
-
-TTY_IO_ERROR		If set, causes all subsequent userspace read/write
-			calls on the tty to fail, returning -EIO.
-
-TTY_OTHER_CLOSED	Device is a pty and the other side has closed.
-
-TTY_NO_WRITE_SPLIT	Prevent driver from splitting up writes into
-			smaller chunks.
-======================= =======================================================
-
+Line discipline methods have access to :c:member:`tty_struct.flags` field. See
+:doc:`tty_struct`.
 
 Locking
 ^^^^^^^
diff --git a/include/linux/tty.h b/include/linux/tty.h
index da49ad9be281..7b0a5d478ef6 100644
--- a/include/linux/tty.h
+++ b/include/linux/tty.h
@@ -263,26 +263,72 @@ struct tty_file_private {
 /* tty magic number */
 #define TTY_MAGIC		0x5401
 
-/*
- * These bits are used in the flags field of the tty structure.
+/**
+ * DOC: TTY Struct Flags
+ *
+ * These bits are used in the :c:member:`tty_struct.flags` field.
  *
  * So that interrupts won't be able to mess up the queues,
  * copy_to_cooked must be atomic with respect to itself, as must
  * tty->write.  Thus, you must use the inline functions set_bit() and
  * clear_bit() to make things atomic.
+ *
+ * TTY_THROTTLED
+ *	Driver input is throttled. The ldisc should call
+ *	:c:member:`tty_driver.unthrottle()` in order to resume reception when
+ *	it is ready to process more data (at threshold min).
+ *
+ * TTY_IO_ERROR
+ *	If set, causes all subsequent userspace read/write calls on the tty to
+ *	fail, returning -%EIO. (May be no ldisc too.)
+ *
+ * TTY_OTHER_CLOSED
+ *	Device is a pty and the other side has closed.
+ *
+ * TTY_EXCLUSIVE
+ *	Exclusive open mode (a single opener).
+ *
+ * TTY_DO_WRITE_WAKEUP
+ *	If set, causes the driver to call the
+ *	:c:member:`tty_ldisc_ops.write_wakeup()` method in order to resume
+ *	transmission when it can accept more data to transmit.
+ *
+ * TTY_LDISC_OPEN
+ *	Indicates that a line discipline is open. For debugging purposes only.
+ *
+ * TTY_PTY_LOCK
+ *	A flag private to pty code to implement %TIOCSPTLCK/%TIOCGPTLCK logic.
+ *
+ * TTY_NO_WRITE_SPLIT
+ *	Prevent driver from splitting up writes into smaller chunks (preserve
+ *	write boundaries to driver).
+ *
+ * TTY_HUPPED
+ *	The TTY was hung up. This is set post :c:member:`tty_driver.hangup()`.
+ *
+ * TTY_HUPPING
+ *	The TTY is in the process of hanging up to abort potential readers.
+ *
+ * TTY_LDISC_CHANGING
+ *	Line discipline for this TTY is being changed. I/O should not block
+ *	when this is set. Use tty_io_nonblock() to check.
+ *
+ * TTY_LDISC_HALTED
+ *	Line discipline for this TTY was stopped. No work should be queued to
+ *	this ldisc.
  */
-#define TTY_THROTTLED 		0	/* Call unthrottle() at threshold min */
-#define TTY_IO_ERROR 		1	/* Cause an I/O error (may be no ldisc too) */
-#define TTY_OTHER_CLOSED 	2	/* Other side (if any) has closed */
-#define TTY_EXCLUSIVE 		3	/* Exclusive open mode */
-#define TTY_DO_WRITE_WAKEUP 	5	/* Call write_wakeup after queuing new */
-#define TTY_LDISC_OPEN	 	11	/* Line discipline is open */
-#define TTY_PTY_LOCK 		16	/* pty private */
-#define TTY_NO_WRITE_SPLIT 	17	/* Preserve write boundaries to driver */
-#define TTY_HUPPED 		18	/* Post driver->hangup() */
-#define TTY_HUPPING		19	/* Hangup in progress */
-#define TTY_LDISC_CHANGING	20	/* Change pending - non-block IO */
-#define TTY_LDISC_HALTED	22	/* Line discipline is halted */
+#define TTY_THROTTLED		0
+#define TTY_IO_ERROR		1
+#define TTY_OTHER_CLOSED	2
+#define TTY_EXCLUSIVE		3
+#define TTY_DO_WRITE_WAKEUP	5
+#define TTY_LDISC_OPEN		11
+#define TTY_PTY_LOCK		16
+#define TTY_NO_WRITE_SPLIT	17
+#define TTY_HUPPED		18
+#define TTY_HUPPING		19
+#define TTY_LDISC_CHANGING	20
+#define TTY_LDISC_HALTED	22
 
 static inline bool tty_io_nonblock(struct tty_struct *tty, struct file *file)
 {
-- 
2.34.0


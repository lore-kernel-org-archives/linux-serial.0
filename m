Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABAA3C433EF
	for <linux-serial@archiver.kernel.org>; Fri, 26 Nov 2021 08:18:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359430AbhKZIVe (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 26 Nov 2021 03:21:34 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:32876 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359415AbhKZIT1 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 26 Nov 2021 03:19:27 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id DA1E11FDFF;
        Fri, 26 Nov 2021 08:16:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1637914573; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FiQjgjkkGYl6awNKTe7HNzbKtucdDB4jofuWnHZvWK0=;
        b=Ar9DAzlHMxpqtxddMht3x7n5C6V4QDzGw7zRPz1MV8PH5eBK4XPS1aYFyyHMMFwEaz7SWq
        em3/whQiLhwwSKRyhuXD56g/42CSzZm5EK7aFzvJH83WAn2xh64qp4J2XN0+mT9fZ+vMOw
        kg9DhslNn2KgC85IgAfeh2hwTyF3hlQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1637914573;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FiQjgjkkGYl6awNKTe7HNzbKtucdDB4jofuWnHZvWK0=;
        b=wp/Q8qkKKyOPlfDhl7akfpK12VC7Qifc8OLUpZqQlkTeX6QumfugYB85gqzv6GVK8cxJiC
        oeKCIoWKlGilnVBA==
Received: from localhost.localdomain (unknown [10.100.208.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id B048EA3B83;
        Fri, 26 Nov 2021 08:16:13 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 08/23] tty: combine tty_ldisc_ops docs into kernel-doc
Date:   Fri, 26 Nov 2021 09:15:56 +0100
Message-Id: <20211126081611.11001-9-jslaby@suse.cz>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20211126081611.11001-1-jslaby@suse.cz>
References: <20211126081611.11001-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

In Documentation/driver-api/serial/tty.rst, there are duplicated texts
about some struct tty_ldisc_ops' hooks. Combine them into existing
kernel-doc comments of struct tty_ldisc_ops and drop them from the
Documentation/.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 Documentation/driver-api/serial/tty.rst | 95 +------------------------
 include/linux/tty_ldisc.h               | 67 ++++++++++-------
 2 files changed, 45 insertions(+), 117 deletions(-)

diff --git a/Documentation/driver-api/serial/tty.rst b/Documentation/driver-api/serial/tty.rst
index f7ef10c6f458..333a5923f6e1 100644
--- a/Documentation/driver-api/serial/tty.rst
+++ b/Documentation/driver-api/serial/tty.rst
@@ -35,99 +35,8 @@ about to enter and exit although this detail matters not).
 Line Discipline Methods
 -----------------------
 
-TTY side interfaces
-^^^^^^^^^^^^^^^^^^^
-
-======================= =======================================================
-open()			Called when the line discipline is attached to
-			the terminal. No other call into the line
-			discipline for this tty will occur until it
-			completes successfully. Should initialize any
-			state needed by the ldisc, and set receive_room
-			in the tty_struct to the maximum amount of data
-			the line discipline is willing to accept from the
-			driver with a single call to receive_buf().
-			Returning an error will prevent the ldisc from
-			being attached. Can sleep.
-
-close()			This is called on a terminal when the line
-			discipline is being unplugged. At the point of
-			execution no further users will enter the
-			ldisc code for this tty. Can sleep.
-
-hangup()		Called when the tty line is hung up.
-			The line discipline should cease I/O to the tty.
-			No further calls into the ldisc code will occur.
-			Can sleep.
-
-read()			(optional) A process requests reading data from
-			the line. Multiple read calls may occur in parallel
-			and the ldisc must deal with serialization issues.
-			If not defined, the process will receive an EIO
-			error. May sleep.
-
-write()			(optional) A process requests writing data to the
-			line. Multiple write calls are serialized by the
-			tty layer for the ldisc. If not defined, the
-			process will receive an EIO error. May sleep.
-
-flush_buffer()		(optional) May be called at any point between
-			open and close, and instructs the line discipline
-			to empty its input buffer.
-
-set_termios()		(optional) Called on termios structure changes.
-			The caller passes the old termios data and the
-			current data is in the tty. Called under the
-			termios semaphore so allowed to sleep. Serialized
-			against itself only.
-
-poll()			(optional) Check the status for the poll/select
-			calls. Multiple poll calls may occur in parallel.
-			May sleep.
-
-ioctl()			(optional) Called when an ioctl is handed to the
-			tty layer that might be for the ldisc. Multiple
-			ioctl calls may occur in parallel. May sleep.
-
-compat_ioctl()		(optional) Called when a 32 bit ioctl is handed
-			to the tty layer that might be for the ldisc.
-			Multiple ioctl calls may occur in parallel.
-			May sleep.
-======================= =======================================================
-
-Driver Side Interfaces
-^^^^^^^^^^^^^^^^^^^^^^
-
-======================= =======================================================
-receive_buf()		(optional) Called by the low-level driver to hand
-			a buffer of received bytes to the ldisc for
-			processing. The number of bytes is guaranteed not
-			to exceed the current value of tty->receive_room.
-			All bytes must be processed.
-
-receive_buf2()		(optional) Called by the low-level driver to hand
-			a buffer of received bytes to the ldisc for
-			processing. Returns the number of bytes processed.
-
-			If both receive_buf() and receive_buf2() are
-			defined, receive_buf2() should be preferred.
-
-write_wakeup()		May be called at any point between open and close.
-			The TTY_DO_WRITE_WAKEUP flag indicates if a call
-			is needed but always races versus calls. Thus the
-			ldisc must be careful about setting order and to
-			handle unexpected calls. Must not sleep.
-
-			The driver is forbidden from calling this directly
-			from the ->write call from the ldisc as the ldisc
-			is permitted to call the driver write method from
-			this function. In such a situation defer it.
-
-dcd_change()		Report to the tty line the current DCD pin status
-			changes and the relative timestamp. The timestamp
-			cannot be NULL.
-======================= =======================================================
-
+.. kernel-doc:: include/linux/tty_ldisc.h
+   :identifiers: tty_ldisc_ops
 
 Driver Access
 ^^^^^^^^^^^^^
diff --git a/include/linux/tty_ldisc.h b/include/linux/tty_ldisc.h
index e0da0ba02de9..e85002b56752 100644
--- a/include/linux/tty_ldisc.h
+++ b/include/linux/tty_ldisc.h
@@ -61,33 +61,45 @@ int ldsem_down_write_nested(struct ld_semaphore *sem, int subclass,
  * @name: name of this ldisc rendered in /proc/tty/ldiscs
  * @num: ``N_*`` number (%N_TTY, %N_HDLC, ...) reserved to this ldisc
  *
- * @open: ``int ()(struct tty_struct *tty)``
+ * @open: [TTY] ``int ()(struct tty_struct *tty)``
  *
  *	This function is called when the line discipline is associated with the
- *	@tty. The line discipline can use this as an opportunity to initialize
- *	any state needed by the ldisc routines.
+ *	@tty. No other call into the line discipline for this tty will occur
+ *	until it completes successfully. It should initialize any state needed
+ *	by the ldisc, and set @tty->receive_room to the maximum amount of data
+ *	the line discipline is willing to accept from the driver with a single
+ *	call to @receive_buf(). Returning an error will prevent the ldisc from
+ *	being attached.
  *
- * @close: ``void ()(struct tty_struct *tty)``
+ *	Can sleep.
+ *
+ * @close: [TTY] ``void ()(struct tty_struct *tty)``
  *
  *	This function is called when the line discipline is being shutdown,
  *	either because the @tty is being closed or because the @tty is being
- *	changed to use a new line discipline
+ *	changed to use a new line discipline. At the point of execution no
+ *	further users will enter the ldisc code for this tty.
+ *
+ *	Can sleep.
  *
- * @flush_buffer: ``void ()(struct tty_struct *tty)``
+ * @flush_buffer: [TTY] ``void ()(struct tty_struct *tty)``
  *
  *	This function instructs the line discipline to clear its buffers of any
  *	input characters it may have queued to be delivered to the user mode
- *	process.
+ *	process. It may be called at any point between open and close.
  *
- * @read: ``ssize_t ()(struct tty_struct *tty, struct file *file,
+ * @read: [TTY] ``ssize_t ()(struct tty_struct *tty, struct file *file,
  *		unsigned char *buf, size_t nr)``
  *
  *	This function is called when the user requests to read from the @tty.
  *	The line discipline will return whatever characters it has buffered up
  *	for the user. If this function is not defined, the user will receive
- *	an %EIO error.
+ *	an %EIO error. Multiple read calls may occur in parallel and the ldisc
+ *	must deal with serialization issues.
+ *
+ *	Can sleep.
  *
- * @write: ``ssize_t ()(struct tty_struct *tty, struct file *file,
+ * @write: [TTY] ``ssize_t ()(struct tty_struct *tty, struct file *file,
  *		const unsigned char *buf, size_t nr)``
  *
  *	This function is called when the user requests to write to the @tty.
@@ -96,7 +108,9 @@ int ldsem_down_write_nested(struct ld_semaphore *sem, int subclass,
  *	characters first. If this function is not defined, the user will
  *	receive an %EIO error.
  *
- * @ioctl: ``int ()(struct tty_struct *tty, unsigned int cmd,
+ *	Can sleep.
+ *
+ * @ioctl: [TTY] ``int ()(struct tty_struct *tty, unsigned int cmd,
  *		unsigned long arg)``
  *
  *	This function is called when the user requests an ioctl which is not
@@ -106,7 +120,7 @@ int ldsem_down_write_nested(struct ld_semaphore *sem, int subclass,
  *	discpline. So a low-level driver can "grab" an ioctl request before
  *	the line discpline has a chance to see it.
  *
- * @compat_ioctl: ``int ()(struct tty_struct *tty, unsigned int cmd,
+ * @compat_ioctl: [TTY] ``int ()(struct tty_struct *tty, unsigned int cmd,
  *		unsigned long arg)``
  *
  *	Process ioctl calls from 32-bit process on 64-bit system.
@@ -116,27 +130,29 @@ int ldsem_down_write_nested(struct ld_semaphore *sem, int subclass,
  *	a pointer to wordsize-sensitive structure belongs here, but most of
  *	ldiscs will happily leave it %NULL.
  *
- * @set_termios: ``void ()(struct tty_struct *tty, struct ktermios *old)``
+ * @set_termios: [TTY] ``void ()(struct tty_struct *tty, struct ktermios *old)``
  *
  *	This function notifies the line discpline that a change has been made
  *	to the termios structure.
  *
- * @poll: ``int ()(struct tty_struct *tty, struct file *file,
+ * @poll: [TTY] ``int ()(struct tty_struct *tty, struct file *file,
  *		  struct poll_table_struct *wait)``
  *
  *	This function is called when a user attempts to select/poll on a @tty
  *	device. It is solely the responsibility of the line discipline to
  *	handle poll requests.
  *
- * @hangup: ``void ()(struct tty_struct *tty)``
+ * @hangup: [TTY] ``void ()(struct tty_struct *tty)``
  *
  *	Called on a hangup. Tells the discipline that it should cease I/O to
- *	the tty driver. Can sleep. The driver should seek to perform this
- *	action quickly but should wait until any pending driver I/O is
- *	completed.
+ *	the tty driver. The driver should seek to perform this action quickly
+ *	but should wait until any pending driver I/O is completed. No further
+ *	calls into the ldisc code will occur.
+ *
+ *	Can sleep.
  *
- * @receive_buf: ``void ()(struct tty_struct *tty, const unsigned char *cp,
- *		       const char *fp, int count)``
+ * @receive_buf: [DRV] ``void ()(struct tty_struct *tty,
+ *		       const unsigned char *cp, const char *fp, int count)``
  *
  *	This function is called by the low-level tty driver to send characters
  *	received by the hardware to the line discpline for processing. @cp is
@@ -145,7 +161,7 @@ int ldsem_down_write_nested(struct ld_semaphore *sem, int subclass,
  *	character was received with a parity error, etc. @fp may be %NULL to
  *	indicate all data received is %TTY_NORMAL.
  *
- * @write_wakeup: ``void ()(struct tty_struct *tty)``
+ * @write_wakeup: [DRV] ``void ()(struct tty_struct *tty)``
  *
  *	This function is called by the low-level tty driver to signal that line
  *	discpline should try to send more characters to the low-level driver
@@ -154,13 +170,13 @@ int ldsem_down_write_nested(struct ld_semaphore *sem, int subclass,
  *	send, please arise a tasklet or workqueue to do the real data transfer.
  *	Do not send data in this hook, it may lead to a deadlock.
  *
- * @dcd_change: ``void ()(struct tty_struct *tty, unsigned int status)``
+ * @dcd_change: [DRV] ``void ()(struct tty_struct *tty, unsigned int status)``
  *
  *	Tells the discipline that the DCD pin has changed its status. Used
  *	exclusively by the %N_PPS (Pulse-Per-Second) line discipline.
  *
- * @receive_buf2: ``int ()(struct tty_struct *tty, const unsigned char *cp,
- *			const char *fp, int count)``
+ * @receive_buf2: [DRV] ``int ()(struct tty_struct *tty,
+ *			const unsigned char *cp, const char *fp, int count)``
  *
  *	This function is called by the low-level tty driver to send characters
  *	received by the hardware to the line discpline for processing. @cp is a
@@ -176,6 +192,9 @@ int ldsem_down_write_nested(struct ld_semaphore *sem, int subclass,
  * implementation and the tty routines. The above routines can be defined.
  * Unless noted otherwise, they are optional, and can be filled in with a %NULL
  * pointer.
+ *
+ * Hooks marked [TTY] are invoked from the TTY core, the [DRV] ones from the
+ * tty_driver side.
  */
 struct tty_ldisc_ops {
 	char	*name;
-- 
2.34.0


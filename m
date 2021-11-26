Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 935DAC4332F
	for <linux-serial@archiver.kernel.org>; Fri, 26 Nov 2021 08:18:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359356AbhKZIV1 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 26 Nov 2021 03:21:27 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:32850 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359405AbhKZIT0 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 26 Nov 2021 03:19:26 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 64DC91FDFC;
        Fri, 26 Nov 2021 08:16:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1637914572; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Be2kuENAcavmlOAOK3SaCCqy1zjgpweT8BXH+ebtWCQ=;
        b=eNZiUu7bOv+apncL/QxJijs0b61sPtvQ9RB9qYFQGP12HNDyBK+/25Wmv21p2cNIQkeQHO
        CIDKCgv1oIv2OkPIZQFzzH66+m782uDTdjxIxPtd1n/9voAje3W/wiHX+1ROAt6gVAqid0
        OQzlmON/ol4O+/Il2KfeZ/tB2078OEc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1637914572;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Be2kuENAcavmlOAOK3SaCCqy1zjgpweT8BXH+ebtWCQ=;
        b=I2xEmEp90mSmXap0YoyVZcJ7io3mLLeeqkCrM/Y794yH3RHCDG7vaZ6KNcfuyvFXWp6LVT
        nOPw/l+ssxTHJQBQ==
Received: from localhost.localdomain (unknown [10.100.208.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 3EBA2A3B83;
        Fri, 26 Nov 2021 08:16:12 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 01/23] tty: finish kernel-doc of tty_struct members
Date:   Fri, 26 Nov 2021 09:15:49 +0100
Message-Id: <20211126081611.11001-2-jslaby@suse.cz>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20211126081611.11001-1-jslaby@suse.cz>
References: <20211126081611.11001-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

There are already pieces of kernel-doc documentation for struct
tty_struct in tty.h. Finish the documentation for the members which were
undocumented yet.

It also includes tuning the already existing pieces like flow and ctrl,
especially adding highlights to them.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 include/linux/tty.h | 79 ++++++++++++++++++++++++++++++++++++---------
 1 file changed, 64 insertions(+), 15 deletions(-)

diff --git a/include/linux/tty.h b/include/linux/tty.h
index 5dbd7c5afac7..da49ad9be281 100644
--- a/include/linux/tty.h
+++ b/include/linux/tty.h
@@ -122,33 +122,84 @@ struct tty_operations;
 /**
  * struct tty_struct - state associated with a tty while open
  *
- * @flow.lock: lock for flow members
- * @flow.stopped: tty stopped/started by tty_stop/tty_start
- * @flow.tco_stopped: tty stopped/started by TCOOFF/TCOON ioctls (it has
- *		      precedense over @flow.stopped)
+ * @magic: magic value set early in @alloc_tty_struct to %TTY_MAGIC, for
+ *	   debugging purposes
+ * @kref: reference counting by tty_kref_get() and tty_kref_put(), reaching zero
+ *	  frees the structure
+ * @dev: class device or %NULL (e.g. ptys, serdev)
+ * @driver: &struct tty_driver operating this tty
+ * @ops: &struct tty_operations of @driver for this tty (open, close, etc.)
+ * @index: index of this tty (e.g. to construct @name like tty12)
+ * @ldisc_sem: protects line discipline changes (@ldisc) -- lock tty not pty
+ * @ldisc: the current line discipline for this tty (n_tty by default)
+ * @atomic_write_lock: protects against concurrent writers, i.e. locks
+ *		       @write_cnt, @write_buf and similar
+ * @legacy_mutex: leftover from history (BKL -> BTM -> @legacy_mutex),
+ *		  protecting several operations on this tty
+ * @throttle_mutex: protects against concurrent tty_throttle_safe() and
+ *		    tty_unthrottle_safe() (but not tty_unthrottle())
+ * @termios_rwsem: protects @termios and @termios_locked
+ * @winsize_mutex: protects @winsize
+ * @termios: termios for the current tty, copied from/to @driver.termios
+ * @termios_locked: locked termios (by %TIOCGLCKTRMIOS and %TIOCSLCKTRMIOS
+ *		    ioctls)
+ * @name: name of the tty constructed by tty_line_name() (e.g. ttyS3)
+ * @flags: bitwise OR of %TTY_THROTTLED, %TTY_IO_ERROR, ...
+ * @count: count of open processes, reaching zero cancels all the work for
+ *	   this tty and drops a @kref too (but does not free this tty)
+ * @winsize: size of the terminal "window" (cf. @winsize_mutex)
+ * @flow: flow settings grouped together, see also @flow.unused
+ * @flow.lock: lock for @flow members
+ * @flow.stopped: tty stopped/started by stop_tty()/start_tty()
+ * @flow.tco_stopped: tty stopped/started by %TCOOFF/%TCOON ioctls (it has
+ *		      precedence over @flow.stopped)
  * @flow.unused: alignment for Alpha, so that no members other than @flow.* are
  *		 modified by the same 64b word store. The @flow's __aligned is
  *		 there for the very same reason.
- * @ctrl.lock: lock for ctrl members
+ * @ctrl: control settings grouped together, see also @ctrl.unused
+ * @ctrl.lock: lock for @ctrl members
  * @ctrl.pgrp: process group of this tty (setpgrp(2))
  * @ctrl.session: session of this tty (setsid(2)). Writes are protected by both
- *		  @ctrl.lock and legacy mutex, readers must use at least one of
+ *		  @ctrl.lock and @legacy_mutex, readers must use at least one of
  *		  them.
- * @ctrl.pktstatus: packet mode status (bitwise OR of TIOCPKT_* constants)
+ * @ctrl.pktstatus: packet mode status (bitwise OR of %TIOCPKT_ constants)
  * @ctrl.packet: packet mode enabled
+ * @ctrl.unused: alignment for Alpha, see @flow.unused for explanation
+ * @hw_stopped: not controlled by the tty layer, under @driver's control for CTS
+ *		handling
+ * @receive_room: bytes permitted to feed to @ldisc without any being lost
+ * @flow_change: controls behavior of throttling, see tty_throttle_safe() and
+ *		 tty_unthrottle_safe()
+ * @link: link to another pty (master -> slave and vice versa)
+ * @fasync: state for %O_ASYNC (for %SIGIO); managed by fasync_helper()
+ * @write_wait: concurrent writers are waiting in this queue until they are
+ *		allowed to write
+ * @read_wait: readers wait for data in this queue
+ * @hangup_work: normally a work to perform a hangup (do_tty_hangup()); while
+ *		 freeing the tty, (re)used to release_one_tty()
+ * @disc_data: pointer to @ldisc's private data (e.g. to &struct n_tty_data)
+ * @driver_data: pointer to @driver's private data (e.g. &struct uart_state)
+ * @files_lock:	protects @tty_files list
+ * @tty_files: list of (re)openers of this tty (i.e. linked &struct
+ *	       tty_file_private)
+ * @closing: when set during close, n_tty processes only START & STOP chars
+ * @write_buf: temporary buffer used during tty_write() to copy user data to
+ * @write_cnt: count of bytes written in tty_write() to @write_buf
+ * @SAK_work: if the tty has a pending do_SAK, it is queued here
+ * @port: persistent storage for this device (i.e. &struct tty_port)
  *
  * All of the state associated with a tty while the tty is open. Persistent
- * storage for tty devices is referenced here as @port in struct tty_port.
+ * storage for tty devices is referenced here as @port and is documented in
+ * &struct tty_port.
  */
 struct tty_struct {
 	int	magic;
 	struct kref kref;
-	struct device *dev;	/* class device or NULL (e.g. ptys, serdev) */
+	struct device *dev;
 	struct tty_driver *driver;
 	const struct tty_operations *ops;
 	int index;
 
-	/* Protects ldisc changes: Lock tty not pty */
 	struct ld_semaphore ldisc_sem;
 	struct tty_ldisc *ldisc;
 
@@ -157,12 +208,11 @@ struct tty_struct {
 	struct mutex throttle_mutex;
 	struct rw_semaphore termios_rwsem;
 	struct mutex winsize_mutex;
-	/* Termios values are protected by the termios rwsem */
 	struct ktermios termios, termios_locked;
 	char name[64];
 	unsigned long flags;
 	int count;
-	struct winsize winsize;		/* winsize_mutex */
+	struct winsize winsize;
 
 	struct {
 		spinlock_t lock;
@@ -181,7 +231,7 @@ struct tty_struct {
 	} __aligned(sizeof(unsigned long)) ctrl;
 
 	int hw_stopped;
-	unsigned int receive_room;	/* Bytes free for queue */
+	unsigned int receive_room;
 	int flow_change;
 
 	struct tty_struct *link;
@@ -191,7 +241,7 @@ struct tty_struct {
 	struct work_struct hangup_work;
 	void *disc_data;
 	void *driver_data;
-	spinlock_t files_lock;		/* protects tty_files list */
+	spinlock_t files_lock;
 	struct list_head tty_files;
 
 #define N_TTY_BUF_SIZE 4096
@@ -199,7 +249,6 @@ struct tty_struct {
 	int closing;
 	unsigned char *write_buf;
 	int write_cnt;
-	/* If the tty has a pending do_SAK, queue it here - akpm */
 	struct work_struct SAK_work;
 	struct tty_port *port;
 } __randomize_layout;
-- 
2.34.0


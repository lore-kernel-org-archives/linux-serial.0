Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F717C433F5
	for <linux-serial@archiver.kernel.org>; Fri, 26 Nov 2021 08:18:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359384AbhKZIV2 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 26 Nov 2021 03:21:28 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:32860 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359410AbhKZIT0 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 26 Nov 2021 03:19:26 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 9AC691FDFD;
        Fri, 26 Nov 2021 08:16:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1637914572; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hfzXNecqaQbUWp2AVb6xFy7wV/rQmdRHAbpjLENhmRk=;
        b=Ls1pOeAEeXseykKcaLonbgfzJ4AMXb0R2w5Wy1aCX3Q5nF1ZbQRJbskPKKUoen5f2RmGYJ
        FvSgTa7O2v2GHlr9nYR9zmqcn4vbV+PA0+YWBNsCKk4Mmi3LOrA6fUl/kzeaHxoPoypSKN
        QfHlP35bBKxWHonhDbjI8vm00KigoKc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1637914572;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hfzXNecqaQbUWp2AVb6xFy7wV/rQmdRHAbpjLENhmRk=;
        b=5HwToCQN2py3SU32NHoz58zGUEEL9yidpKRYsXSP1XS6/jI7NOUd/sf9bcnI15Cz1HPHjX
        7z0hKzhwdbEAHOBg==
Received: from localhost.localdomain (unknown [10.100.208.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 6B3EAA3B84;
        Fri, 26 Nov 2021 08:16:12 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 02/23] tty: add kernel-doc for tty_port
Date:   Fri, 26 Nov 2021 09:15:50 +0100
Message-Id: <20211126081611.11001-3-jslaby@suse.cz>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20211126081611.11001-1-jslaby@suse.cz>
References: <20211126081611.11001-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

tty_port used to have only short comments along its members. Convert
them into proper kernel-doc comments in front of the structure. And add
some more explanation to them where needed.

The whole structure purpose and handling is documented at the end too --
some pieces of preexisting text moved to this place.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 include/linux/tty_port.h | 104 ++++++++++++++++++++++++++-------------
 1 file changed, 70 insertions(+), 34 deletions(-)

diff --git a/include/linux/tty_port.h b/include/linux/tty_port.h
index 6e86e9e118b6..9091e1c8de4c 100644
--- a/include/linux/tty_port.h
+++ b/include/linux/tty_port.h
@@ -7,17 +7,6 @@
 #include <linux/tty_buffer.h>
 #include <linux/wait.h>
 
-/*
- * Port level information. Each device keeps its own port level information
- * so provide a common structure for those ports wanting to use common support
- * routines.
- *
- * The tty port has a different lifetime to the tty so must be kept apart.
- * In addition be careful as tty -> port mappings are valid for the life
- * of the tty object but in many cases port -> tty mappings are valid only
- * until a hangup so don't use the wrong path.
- */
-
 struct attribute_group;
 struct tty_driver;
 struct tty_port;
@@ -48,30 +37,77 @@ struct tty_port_client_operations {
 
 extern const struct tty_port_client_operations tty_port_default_client_ops;
 
+/**
+ * struct tty_port -- port level information
+ *
+ * @buf: buffer for this port, locked internally
+ * @tty: back pointer to &struct tty_struct, valid only if the tty is open. Use
+ *	 tty_port_tty_get() to obtain it (and tty_kref_put() to release).
+ * @itty: internal back pointer to &struct tty_struct. Avoid this. It should be
+ *	  eliminated in the long term.
+ * @ops: tty port operations (like activate, shutdown), see &struct
+ *	 tty_port_operations
+ * @client_ops: tty port client operations (like receive_buf, write_wakeup).
+ *		By default, tty_port_default_client_ops is used.
+ * @lock: lock protecting @tty
+ * @blocked_open: # of procs waiting for open in tty_port_block_til_ready()
+ * @count: usage count
+ * @open_wait: open waiters queue (waiting e.g. for a carrier)
+ * @delta_msr_wait: modem status change queue (waiting for MSR changes)
+ * @flags: user TTY flags (%ASYNC_)
+ * @iflags: internal flags (%TTY_PORT_)
+ * @console: when set, the port is a console
+ * @mutex: locking, for open, shutdown and other port operations
+ * @buf_mutex: @xmit_buf alloc lock
+ * @xmit_buf: optional xmit buffer used by some drivers
+ * @close_delay: delay in jiffies to wait when closing the port
+ * @closing_wait: delay in jiffies for output to be sent before closing
+ * @drain_delay: set to zero if no pure time based drain is needed else set to
+ *		 size of fifo
+ * @kref: references counter. Reaching zero calls @ops->destruct() if non-%NULL
+ *	  or frees the port otherwise.
+ * @client_data: pointer to private data, for @client_ops
+ *
+ * Each device keeps its own port level information. &struct tty_port was
+ * introduced as a common structure for such information. As every TTY device
+ * shall have a backing tty_port structure, every driver can use these members.
+ *
+ * The tty port has a different lifetime to the tty so must be kept apart.
+ * In addition be careful as tty -> port mappings are valid for the life
+ * of the tty object but in many cases port -> tty mappings are valid only
+ * until a hangup so don't use the wrong path.
+ *
+ * Tty port shall be initialized by tty_port_init() and shut down either by
+ * tty_port_destroy() (refcounting not used), or tty_port_put() (refcounting).
+ *
+ * There is a lot of helpers around &struct tty_port too. To name the most
+ * significant ones: tty_port_open(), tty_port_close() (or
+ * tty_port_close_start() and tty_port_close_end() separately if need be), and
+ * tty_port_hangup(). These call @ops->activate() and @ops->shutdown() as
+ * needed.
+ */
 struct tty_port {
-	struct tty_bufhead	buf;		/* Locked internally */
-	struct tty_struct	*tty;		/* Back pointer */
-	struct tty_struct	*itty;		/* internal back ptr */
-	const struct tty_port_operations *ops;	/* Port operations */
-	const struct tty_port_client_operations *client_ops; /* Port client operations */
-	spinlock_t		lock;		/* Lock protecting tty field */
-	int			blocked_open;	/* Waiting to open */
-	int			count;		/* Usage count */
-	wait_queue_head_t	open_wait;	/* Open waiters */
-	wait_queue_head_t	delta_msr_wait;	/* Modem status change */
-	unsigned long		flags;		/* User TTY flags ASYNC_ */
-	unsigned long		iflags;		/* Internal flags TTY_PORT_ */
-	unsigned char		console:1;	/* port is a console */
-	struct mutex		mutex;		/* Locking */
-	struct mutex		buf_mutex;	/* Buffer alloc lock */
-	unsigned char		*xmit_buf;	/* Optional buffer */
-	unsigned int		close_delay;	/* Close port delay */
-	unsigned int		closing_wait;	/* Delay for output */
-	int			drain_delay;	/* Set to zero if no pure time
-						   based drain is needed else
-						   set to size of fifo */
-	struct kref		kref;		/* Ref counter */
-	void 			*client_data;
+	struct tty_bufhead	buf;
+	struct tty_struct	*tty;
+	struct tty_struct	*itty;
+	const struct tty_port_operations *ops;
+	const struct tty_port_client_operations *client_ops;
+	spinlock_t		lock;
+	int			blocked_open;
+	int			count;
+	wait_queue_head_t	open_wait;
+	wait_queue_head_t	delta_msr_wait;
+	unsigned long		flags;
+	unsigned long		iflags;
+	unsigned char		console:1;
+	struct mutex		mutex;
+	struct mutex		buf_mutex;
+	unsigned char		*xmit_buf;
+	unsigned int		close_delay;
+	unsigned int		closing_wait;
+	int			drain_delay;
+	struct kref		kref;
+	void			*client_data;
 };
 
 /* tty_port::iflags bits -- use atomic bit ops */
-- 
2.34.0


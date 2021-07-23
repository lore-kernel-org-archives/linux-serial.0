Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EDA3C432BE
	for <linux-serial@archiver.kernel.org>; Fri, 23 Jul 2021 10:31:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 56E4E60E91
	for <linux-serial@archiver.kernel.org>; Fri, 23 Jul 2021 10:31:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232077AbhGWJvV (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 23 Jul 2021 05:51:21 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:32868 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231829AbhGWJvQ (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 23 Jul 2021 05:51:16 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id C46961FF87;
        Fri, 23 Jul 2021 10:31:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1627036308; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ge0biQ1MKPPMoDYn1Mde5j/LYejUuWXy+aWXDj2oHoQ=;
        b=E4TRJqMZDqd6Sdv5HplwzsPiCzbccUawZtEYJLd/1D+tcIWmCi4Y2la+9uZDp+M+tnODJX
        5axG5Ns6GBp+IsQ/FOmr7IqEYrbw/GF14DCXWK4O4dnUnbbRAJ7hK0lYuF+443BYaQT+RQ
        +vLBvo+C19OqGKvuECZcXnMHq6cblgE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1627036308;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ge0biQ1MKPPMoDYn1Mde5j/LYejUuWXy+aWXDj2oHoQ=;
        b=sJoTudEG8j9RhfRkons9J/Fo/34R/FfJ1qKXd7pg+8crM+tmfZgb9FQ5qg6za0RTAGIifE
        z9b9gRT3Guxyo7Ag==
Received: from localhost.localdomain (unknown [10.100.201.122])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id A79ECA3B9D;
        Fri, 23 Jul 2021 10:31:48 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 7/8] tty: move tty_port to new tty_port.h
Date:   Fri, 23 Jul 2021 12:31:46 +0200
Message-Id: <20210723103147.18250-8-jslaby@suse.cz>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210723103147.18250-1-jslaby@suse.cz>
References: <20210723103147.18250-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

tty.h is long enough already. And I am slowly adding kernel-doc
documentation, so it grows to unmaintainable long mess. To avoid this,
split tty.h further into tty_port.h and move there tty_port-related
declarations and function prototypes (those implemented in tty_port.c).

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 include/linux/tty.h      | 196 +-----------------------------------
 include/linux/tty_port.h | 208 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 209 insertions(+), 195 deletions(-)
 create mode 100644 include/linux/tty_port.h

diff --git a/include/linux/tty.h b/include/linux/tty.h
index b5f353797cec..168e57e40bbb 100644
--- a/include/linux/tty.h
+++ b/include/linux/tty.h
@@ -9,6 +9,7 @@
 #include <linux/tty_buffer.h>
 #include <linux/tty_driver.h>
 #include <linux/tty_ldisc.h>
+#include <linux/tty_port.h>
 #include <linux/mutex.h>
 #include <linux/tty_flags.h>
 #include <uapi/linux/tty.h>
@@ -116,85 +117,6 @@
 
 struct device;
 struct signal_struct;
-
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
-struct tty_port;
-
-struct tty_port_operations {
-	/* Return 1 if the carrier is raised */
-	int (*carrier_raised)(struct tty_port *port);
-	/* Control the DTR line */
-	void (*dtr_rts)(struct tty_port *port, int raise);
-	/* Called when the last close completes or a hangup finishes
-	   IFF the port was initialized. Do not use to free resources. Called
-	   under the port mutex to serialize against activate/shutdowns */
-	void (*shutdown)(struct tty_port *port);
-	/* Called under the port mutex from tty_port_open, serialized using
-	   the port mutex */
-        /* FIXME: long term getting the tty argument *out* of this would be
-           good for consoles */
-	int (*activate)(struct tty_port *port, struct tty_struct *tty);
-	/* Called on the final put of a port */
-	void (*destruct)(struct tty_port *port);
-};
-
-struct tty_port_client_operations {
-	int (*receive_buf)(struct tty_port *port, const unsigned char *, const unsigned char *, size_t);
-	void (*write_wakeup)(struct tty_port *port);
-};
-
-extern const struct tty_port_client_operations tty_port_default_client_ops;
-
-struct tty_port {
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
-};
-
-/* tty_port::iflags bits -- use atomic bit ops */
-#define TTY_PORT_INITIALIZED	0	/* device is initialized */
-#define TTY_PORT_SUSPENDED	1	/* device is suspended */
-#define TTY_PORT_ACTIVE		2	/* device is open */
-
-/*
- * uart drivers: use the uart_port::status field and the UPSTAT_* defines
- * for s/w-based flow control steering and carrier detection status
- */
-#define TTY_PORT_CTS_FLOW	3	/* h/w flow control enabled */
-#define TTY_PORT_CHECK_CD	4	/* carrier detect enabled */
-#define TTY_PORT_KOPENED	5	/* device exclusively opened by
-					   kernel */
-
 struct tty_operations;
 
 /**
@@ -459,122 +381,6 @@ extern int tty_standard_install(struct tty_driver *driver,
 
 extern struct mutex tty_mutex;
 
-extern void tty_port_init(struct tty_port *port);
-extern void tty_port_link_device(struct tty_port *port,
-		struct tty_driver *driver, unsigned index);
-extern struct device *tty_port_register_device(struct tty_port *port,
-		struct tty_driver *driver, unsigned index,
-		struct device *device);
-extern struct device *tty_port_register_device_attr(struct tty_port *port,
-		struct tty_driver *driver, unsigned index,
-		struct device *device, void *drvdata,
-		const struct attribute_group **attr_grp);
-extern struct device *tty_port_register_device_serdev(struct tty_port *port,
-		struct tty_driver *driver, unsigned index,
-		struct device *device);
-extern struct device *tty_port_register_device_attr_serdev(struct tty_port *port,
-		struct tty_driver *driver, unsigned index,
-		struct device *device, void *drvdata,
-		const struct attribute_group **attr_grp);
-extern void tty_port_unregister_device(struct tty_port *port,
-		struct tty_driver *driver, unsigned index);
-extern int tty_port_alloc_xmit_buf(struct tty_port *port);
-extern void tty_port_free_xmit_buf(struct tty_port *port);
-extern void tty_port_destroy(struct tty_port *port);
-extern void tty_port_put(struct tty_port *port);
-
-static inline struct tty_port *tty_port_get(struct tty_port *port)
-{
-	if (port && kref_get_unless_zero(&port->kref))
-		return port;
-	return NULL;
-}
-
-/* If the cts flow control is enabled, return true. */
-static inline bool tty_port_cts_enabled(const struct tty_port *port)
-{
-	return test_bit(TTY_PORT_CTS_FLOW, &port->iflags);
-}
-
-static inline void tty_port_set_cts_flow(struct tty_port *port, bool val)
-{
-	assign_bit(TTY_PORT_CTS_FLOW, &port->iflags, val);
-}
-
-static inline bool tty_port_active(const struct tty_port *port)
-{
-	return test_bit(TTY_PORT_ACTIVE, &port->iflags);
-}
-
-static inline void tty_port_set_active(struct tty_port *port, bool val)
-{
-	assign_bit(TTY_PORT_ACTIVE, &port->iflags, val);
-}
-
-static inline bool tty_port_check_carrier(const struct tty_port *port)
-{
-	return test_bit(TTY_PORT_CHECK_CD, &port->iflags);
-}
-
-static inline void tty_port_set_check_carrier(struct tty_port *port, bool val)
-{
-	assign_bit(TTY_PORT_CHECK_CD, &port->iflags, val);
-}
-
-static inline bool tty_port_suspended(const struct tty_port *port)
-{
-	return test_bit(TTY_PORT_SUSPENDED, &port->iflags);
-}
-
-static inline void tty_port_set_suspended(struct tty_port *port, bool val)
-{
-	assign_bit(TTY_PORT_SUSPENDED, &port->iflags, val);
-}
-
-static inline bool tty_port_initialized(const struct tty_port *port)
-{
-	return test_bit(TTY_PORT_INITIALIZED, &port->iflags);
-}
-
-static inline void tty_port_set_initialized(struct tty_port *port, bool val)
-{
-	assign_bit(TTY_PORT_INITIALIZED, &port->iflags, val);
-}
-
-static inline bool tty_port_kopened(const struct tty_port *port)
-{
-	return test_bit(TTY_PORT_KOPENED, &port->iflags);
-}
-
-static inline void tty_port_set_kopened(struct tty_port *port, bool val)
-{
-	assign_bit(TTY_PORT_KOPENED, &port->iflags, val);
-}
-
-extern struct tty_struct *tty_port_tty_get(struct tty_port *port);
-extern void tty_port_tty_set(struct tty_port *port, struct tty_struct *tty);
-extern int tty_port_carrier_raised(struct tty_port *port);
-extern void tty_port_raise_dtr_rts(struct tty_port *port);
-extern void tty_port_lower_dtr_rts(struct tty_port *port);
-extern void tty_port_hangup(struct tty_port *port);
-extern void tty_port_tty_hangup(struct tty_port *port, bool check_clocal);
-extern void tty_port_tty_wakeup(struct tty_port *port);
-extern int tty_port_block_til_ready(struct tty_port *port,
-				struct tty_struct *tty, struct file *filp);
-extern int tty_port_close_start(struct tty_port *port,
-				struct tty_struct *tty, struct file *filp);
-extern void tty_port_close_end(struct tty_port *port, struct tty_struct *tty);
-extern void tty_port_close(struct tty_port *port,
-				struct tty_struct *tty, struct file *filp);
-extern int tty_port_install(struct tty_port *port, struct tty_driver *driver,
-				struct tty_struct *tty);
-extern int tty_port_open(struct tty_port *port,
-				struct tty_struct *tty, struct file *filp);
-static inline int tty_port_users(struct tty_port *port)
-{
-	return port->count + port->blocked_open;
-}
-
 /* n_tty.c */
 extern void n_tty_inherit_ops(struct tty_ldisc_ops *ops);
 #ifdef CONFIG_TTY
diff --git a/include/linux/tty_port.h b/include/linux/tty_port.h
new file mode 100644
index 000000000000..6e86e9e118b6
--- /dev/null
+++ b/include/linux/tty_port.h
@@ -0,0 +1,208 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_TTY_PORT_H
+#define _LINUX_TTY_PORT_H
+
+#include <linux/kref.h>
+#include <linux/mutex.h>
+#include <linux/tty_buffer.h>
+#include <linux/wait.h>
+
+/*
+ * Port level information. Each device keeps its own port level information
+ * so provide a common structure for those ports wanting to use common support
+ * routines.
+ *
+ * The tty port has a different lifetime to the tty so must be kept apart.
+ * In addition be careful as tty -> port mappings are valid for the life
+ * of the tty object but in many cases port -> tty mappings are valid only
+ * until a hangup so don't use the wrong path.
+ */
+
+struct attribute_group;
+struct tty_driver;
+struct tty_port;
+struct tty_struct;
+
+struct tty_port_operations {
+	/* Return 1 if the carrier is raised */
+	int (*carrier_raised)(struct tty_port *port);
+	/* Control the DTR line */
+	void (*dtr_rts)(struct tty_port *port, int raise);
+	/* Called when the last close completes or a hangup finishes
+	   IFF the port was initialized. Do not use to free resources. Called
+	   under the port mutex to serialize against activate/shutdowns */
+	void (*shutdown)(struct tty_port *port);
+	/* Called under the port mutex from tty_port_open, serialized using
+	   the port mutex */
+        /* FIXME: long term getting the tty argument *out* of this would be
+           good for consoles */
+	int (*activate)(struct tty_port *port, struct tty_struct *tty);
+	/* Called on the final put of a port */
+	void (*destruct)(struct tty_port *port);
+};
+
+struct tty_port_client_operations {
+	int (*receive_buf)(struct tty_port *port, const unsigned char *, const unsigned char *, size_t);
+	void (*write_wakeup)(struct tty_port *port);
+};
+
+extern const struct tty_port_client_operations tty_port_default_client_ops;
+
+struct tty_port {
+	struct tty_bufhead	buf;		/* Locked internally */
+	struct tty_struct	*tty;		/* Back pointer */
+	struct tty_struct	*itty;		/* internal back ptr */
+	const struct tty_port_operations *ops;	/* Port operations */
+	const struct tty_port_client_operations *client_ops; /* Port client operations */
+	spinlock_t		lock;		/* Lock protecting tty field */
+	int			blocked_open;	/* Waiting to open */
+	int			count;		/* Usage count */
+	wait_queue_head_t	open_wait;	/* Open waiters */
+	wait_queue_head_t	delta_msr_wait;	/* Modem status change */
+	unsigned long		flags;		/* User TTY flags ASYNC_ */
+	unsigned long		iflags;		/* Internal flags TTY_PORT_ */
+	unsigned char		console:1;	/* port is a console */
+	struct mutex		mutex;		/* Locking */
+	struct mutex		buf_mutex;	/* Buffer alloc lock */
+	unsigned char		*xmit_buf;	/* Optional buffer */
+	unsigned int		close_delay;	/* Close port delay */
+	unsigned int		closing_wait;	/* Delay for output */
+	int			drain_delay;	/* Set to zero if no pure time
+						   based drain is needed else
+						   set to size of fifo */
+	struct kref		kref;		/* Ref counter */
+	void 			*client_data;
+};
+
+/* tty_port::iflags bits -- use atomic bit ops */
+#define TTY_PORT_INITIALIZED	0	/* device is initialized */
+#define TTY_PORT_SUSPENDED	1	/* device is suspended */
+#define TTY_PORT_ACTIVE		2	/* device is open */
+
+/*
+ * uart drivers: use the uart_port::status field and the UPSTAT_* defines
+ * for s/w-based flow control steering and carrier detection status
+ */
+#define TTY_PORT_CTS_FLOW	3	/* h/w flow control enabled */
+#define TTY_PORT_CHECK_CD	4	/* carrier detect enabled */
+#define TTY_PORT_KOPENED	5	/* device exclusively opened by
+					   kernel */
+
+void tty_port_init(struct tty_port *port);
+void tty_port_link_device(struct tty_port *port, struct tty_driver *driver,
+		unsigned index);
+struct device *tty_port_register_device(struct tty_port *port,
+		struct tty_driver *driver, unsigned index,
+		struct device *device);
+struct device *tty_port_register_device_attr(struct tty_port *port,
+		struct tty_driver *driver, unsigned index,
+		struct device *device, void *drvdata,
+		const struct attribute_group **attr_grp);
+struct device *tty_port_register_device_serdev(struct tty_port *port,
+		struct tty_driver *driver, unsigned index,
+		struct device *device);
+struct device *tty_port_register_device_attr_serdev(struct tty_port *port,
+		struct tty_driver *driver, unsigned index,
+		struct device *device, void *drvdata,
+		const struct attribute_group **attr_grp);
+void tty_port_unregister_device(struct tty_port *port,
+		struct tty_driver *driver, unsigned index);
+int tty_port_alloc_xmit_buf(struct tty_port *port);
+void tty_port_free_xmit_buf(struct tty_port *port);
+void tty_port_destroy(struct tty_port *port);
+void tty_port_put(struct tty_port *port);
+
+static inline struct tty_port *tty_port_get(struct tty_port *port)
+{
+	if (port && kref_get_unless_zero(&port->kref))
+		return port;
+	return NULL;
+}
+
+/* If the cts flow control is enabled, return true. */
+static inline bool tty_port_cts_enabled(const struct tty_port *port)
+{
+	return test_bit(TTY_PORT_CTS_FLOW, &port->iflags);
+}
+
+static inline void tty_port_set_cts_flow(struct tty_port *port, bool val)
+{
+	assign_bit(TTY_PORT_CTS_FLOW, &port->iflags, val);
+}
+
+static inline bool tty_port_active(const struct tty_port *port)
+{
+	return test_bit(TTY_PORT_ACTIVE, &port->iflags);
+}
+
+static inline void tty_port_set_active(struct tty_port *port, bool val)
+{
+	assign_bit(TTY_PORT_ACTIVE, &port->iflags, val);
+}
+
+static inline bool tty_port_check_carrier(const struct tty_port *port)
+{
+	return test_bit(TTY_PORT_CHECK_CD, &port->iflags);
+}
+
+static inline void tty_port_set_check_carrier(struct tty_port *port, bool val)
+{
+	assign_bit(TTY_PORT_CHECK_CD, &port->iflags, val);
+}
+
+static inline bool tty_port_suspended(const struct tty_port *port)
+{
+	return test_bit(TTY_PORT_SUSPENDED, &port->iflags);
+}
+
+static inline void tty_port_set_suspended(struct tty_port *port, bool val)
+{
+	assign_bit(TTY_PORT_SUSPENDED, &port->iflags, val);
+}
+
+static inline bool tty_port_initialized(const struct tty_port *port)
+{
+	return test_bit(TTY_PORT_INITIALIZED, &port->iflags);
+}
+
+static inline void tty_port_set_initialized(struct tty_port *port, bool val)
+{
+	assign_bit(TTY_PORT_INITIALIZED, &port->iflags, val);
+}
+
+static inline bool tty_port_kopened(const struct tty_port *port)
+{
+	return test_bit(TTY_PORT_KOPENED, &port->iflags);
+}
+
+static inline void tty_port_set_kopened(struct tty_port *port, bool val)
+{
+	assign_bit(TTY_PORT_KOPENED, &port->iflags, val);
+}
+
+struct tty_struct *tty_port_tty_get(struct tty_port *port);
+void tty_port_tty_set(struct tty_port *port, struct tty_struct *tty);
+int tty_port_carrier_raised(struct tty_port *port);
+void tty_port_raise_dtr_rts(struct tty_port *port);
+void tty_port_lower_dtr_rts(struct tty_port *port);
+void tty_port_hangup(struct tty_port *port);
+void tty_port_tty_hangup(struct tty_port *port, bool check_clocal);
+void tty_port_tty_wakeup(struct tty_port *port);
+int tty_port_block_til_ready(struct tty_port *port, struct tty_struct *tty,
+		struct file *filp);
+int tty_port_close_start(struct tty_port *port, struct tty_struct *tty,
+		struct file *filp);
+void tty_port_close_end(struct tty_port *port, struct tty_struct *tty);
+void tty_port_close(struct tty_port *port, struct tty_struct *tty,
+		struct file *filp);
+int tty_port_install(struct tty_port *port, struct tty_driver *driver,
+		struct tty_struct *tty);
+int tty_port_open(struct tty_port *port, struct tty_struct *tty,
+		struct file *filp);
+
+static inline int tty_port_users(struct tty_port *port)
+{
+	return port->count + port->blocked_open;
+}
+
+#endif
-- 
2.32.0


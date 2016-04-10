From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH 1/8] tty: Define ASYNC_ replacement bits
Date: Sat,  9 Apr 2016 17:53:20 -0700
Message-ID: <1460249607-8014-2-git-send-email-peter@hurleysoftware.com>
References: <1460249607-8014-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1460249607-8014-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Grant Edwards <grant.b.edwards@gmail.com>, Peter Hurley <peter@hurleysoftware.com>
List-Id: linux-serial@vger.kernel.org

Prepare for relocating kernel private state bits out of tty_port::flags
field; tty_port::flags field is not atomic and can become corrupted
by concurrent updates. It also suffers from the complication of sharing
in a userspace-visible field which must be masked.

Define new tty_port::iflags field and new, substitute bit definitions
for the former ASYNC_* flags.

Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 include/linux/tty.h            | 16 +++++++++++++++-
 include/uapi/linux/tty_flags.h |  9 ++++++++-
 2 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/include/linux/tty.h b/include/linux/tty.h
index 89f9c91..4e0dbda0 100644
--- a/include/linux/tty.h
+++ b/include/linux/tty.h
@@ -228,7 +228,8 @@ struct tty_port {
 	int			count;		/* Usage count */
 	wait_queue_head_t	open_wait;	/* Open waiters */
 	wait_queue_head_t	delta_msr_wait;	/* Modem status change */
-	unsigned long		flags;		/* TTY flags ASY_*/
+	unsigned long		flags;		/* User TTY flags ASYNC_ */
+	unsigned long		iflags;		/* Internal flags TTY_PORT_ */
 	unsigned char		console:1,	/* port is a console */
 				low_latency:1;	/* optional: tune for latency */
 	struct mutex		mutex;		/* Locking */
@@ -242,6 +243,19 @@ struct tty_port {
 	struct kref		kref;		/* Ref counter */
 };
 
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
+
+
 /*
  * Where all of the state associated with a tty is kept while the tty
  * is open.  Since the termios state should be kept even if the tty
diff --git a/include/uapi/linux/tty_flags.h b/include/uapi/linux/tty_flags.h
index 072e41e..8e1a436 100644
--- a/include/uapi/linux/tty_flags.h
+++ b/include/uapi/linux/tty_flags.h
@@ -32,7 +32,12 @@
 #define ASYNCB_MAGIC_MULTIPLIER	16 /* Use special CLK or divisor */
 #define ASYNCB_LAST_USER	16
 
-/* Internal flags used only by kernel */
+/*
+ * Internal flags used only by kernel (read-only)
+ *
+ * WARNING: These flags are no longer used and have been superceded by the
+ *	    TTY_PORT_ flags in the iflags field (and not userspace-visible)
+ */
 #define ASYNCB_INITIALIZED	31 /* Serial port was initialized */
 #define ASYNCB_SUSPENDED	30 /* Serial port is suspended */
 #define ASYNCB_NORMAL_ACTIVE	29 /* Normal device is active */
@@ -44,6 +49,7 @@
 #define ASYNCB_CONS_FLOW	23 /* flow control for console  */
 #define ASYNCB_FIRST_KERNEL	22
 
+/* Masks */
 #define ASYNC_HUP_NOTIFY	(1U << ASYNCB_HUP_NOTIFY)
 #define ASYNC_SUSPENDED		(1U << ASYNCB_SUSPENDED)
 #define ASYNC_FOURPORT		(1U << ASYNCB_FOURPORT)
@@ -72,6 +78,7 @@
 #define ASYNC_SPD_WARP		(ASYNC_SPD_HI|ASYNC_SPD_SHI)
 #define ASYNC_SPD_MASK		(ASYNC_SPD_HI|ASYNC_SPD_VHI|ASYNC_SPD_SHI)
 
+/* These flags are no longer used (and were always masked from userspace) */
 #define ASYNC_INITIALIZED	(1U << ASYNCB_INITIALIZED)
 #define ASYNC_NORMAL_ACTIVE	(1U << ASYNCB_NORMAL_ACTIVE)
 #define ASYNC_BOOT_AUTOCONF	(1U << ASYNCB_BOOT_AUTOCONF)
-- 
2.8.1

From: Peter Hurley <peter@hurleysoftware.com>
Subject: RFC: out-of-tree tty driver breakage (changing ASYNC_ bits)
Date: Sun, 10 Jan 2016 13:42:44 -0800
Message-ID: <5692D054.7050203@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Linux kernel <linux-kernel@vger.kernel.org>
Cc: Greg KH <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
List-Id: linux-serial@vger.kernel.org

The tty/serial core uses 5 bits in the tty_port.flags field to
manage state. They are:

ASYNCB_INITIALIZED
ASYNCB_SUSPENDED
ASYNCB_NORMAL_ACTIVE
- and -
ASYNCB_CTS_FLOW
ASYNCB_CHECK_CD

Unfortunately, updates to this field (tty_port.flags) are often
non-atomic. Additionally, the field is visible to/modifiable by
userspace (the first 3 bits above are not modifiable by userspace
though). Lastly, the multi-bit ASYNC_SPD_ bitfield is in this
tty_port.flags field as well.

What needs to happen is the tty/serial core needs to update its
state transitions atomically. I want to re-define the above 5 flags
into a separate field in the tty_port structure and designate new
symbols for these bits. The base patch that does this is inlined
below.

This will break out-of-tree drivers but I don't really see a
realistic alternative. Also, I think the new symbol prefix ASY_ isn't
great and I'd like to get some suggestions.

Regards,
Peter Hurley

--- >% ---
Subject: [PATCH] tty: Define ASYNC_ replacement bits

Prepare for relocating kernel private state bits out of tty_port::flags
field; tty_port::flags field is not atomic and can become corrupted
by concurrent updates. It also suffers from the complication of sharing
in a userspace-visible field which must be masked.

Define new tty_port::iflags field and new, substitute bit definitions
for the former ASYNC_* flags.
---
 include/linux/tty.h            | 16 +++++++++++++++-
 include/uapi/linux/tty_flags.h |  9 ++++++++-
 2 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/include/linux/tty.h b/include/linux/tty.h
index 3b09f23..4170eed 100644
--- a/include/linux/tty.h
+++ b/include/linux/tty.h
@@ -228,7 +228,8 @@ struct tty_port {
 	int			count;		/* Usage count */
 	wait_queue_head_t	open_wait;	/* Open waiters */
 	wait_queue_head_t	delta_msr_wait;	/* Modem status change */
-	unsigned long		flags;		/* TTY flags ASY_*/
+	unsigned long		flags;		/* User TTY flags ASYNC_ */
+	unsigned long		iflags;		/* Kernel internal flags ASY_ */
 	unsigned char		console:1,	/* port is a console */
 				low_latency:1;	/* optional: tune for latency */
 	struct mutex		mutex;		/* Locking */
@@ -242,6 +243,19 @@ struct tty_port {
 	struct kref		kref;		/* Ref counter */
 };
 
+/* tty_port::iflags bits -- use atomic bit ops */
+#define ASY_ON			0	/* device is initialized */
+#define ASY_SUSPENDED		1	/* device is suspended */
+#define ASY_ACTIVE		2	/* device is open */
+
+/*
+ * uart drivers: use the uart_port::status field and the UPSTAT_* defines
+ * for s/w-based flow control steering and carrier detection status
+ */
+#define ASY_CTS_FLOW		3	/* h/w flow control enabled */
+#define ASY_CHECK_CD		4	/* carrier detect enabled */
+
+
 /*
  * Where all of the state associated with a tty is kept while the tty
  * is open.  Since the termios state should be kept even if the tty
diff --git a/include/uapi/linux/tty_flags.h b/include/uapi/linux/tty_flags.h
index 072e41e..b004201 100644
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
+ *	    private ASY_* flags in the iflags field (and not userspace-visible)
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
2.7.0

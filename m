From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH 8/8] tty: core: Undefine ASYNC_* flags superceded by TTY_PORT* flags
Date: Sat,  9 Apr 2016 17:53:27 -0700
Message-ID: <1460249607-8014-9-git-send-email-peter@hurleysoftware.com>
References: <1460249607-8014-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1460249607-8014-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Grant Edwards <grant.b.edwards@gmail.com>, Peter Hurley <peter@hurleysoftware.com>
List-Id: linux-serial@vger.kernel.org

Purposefully break out-of-tree driver compiles using kernel
ASYNC_* bits which have been superceded by TTY_PORT* flags and
their respective helper functions.

Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 include/uapi/linux/tty_flags.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/uapi/linux/tty_flags.h b/include/uapi/linux/tty_flags.h
index 8e1a436..66e4d8b 100644
--- a/include/uapi/linux/tty_flags.h
+++ b/include/uapi/linux/tty_flags.h
@@ -38,6 +38,7 @@
  * WARNING: These flags are no longer used and have been superceded by the
  *	    TTY_PORT_ flags in the iflags field (and not userspace-visible)
  */
+#ifndef _KERNEL_
 #define ASYNCB_INITIALIZED	31 /* Serial port was initialized */
 #define ASYNCB_SUSPENDED	30 /* Serial port is suspended */
 #define ASYNCB_NORMAL_ACTIVE	29 /* Normal device is active */
@@ -48,6 +49,7 @@
 #define ASYNCB_SHARE_IRQ	24 /* for multifunction cards, no longer used */
 #define ASYNCB_CONS_FLOW	23 /* flow control for console  */
 #define ASYNCB_FIRST_KERNEL	22
+#endif
 
 /* Masks */
 #define ASYNC_HUP_NOTIFY	(1U << ASYNCB_HUP_NOTIFY)
@@ -78,6 +80,7 @@
 #define ASYNC_SPD_WARP		(ASYNC_SPD_HI|ASYNC_SPD_SHI)
 #define ASYNC_SPD_MASK		(ASYNC_SPD_HI|ASYNC_SPD_VHI|ASYNC_SPD_SHI)
 
+#ifndef _KERNEL_
 /* These flags are no longer used (and were always masked from userspace) */
 #define ASYNC_INITIALIZED	(1U << ASYNCB_INITIALIZED)
 #define ASYNC_NORMAL_ACTIVE	(1U << ASYNCB_NORMAL_ACTIVE)
@@ -88,5 +91,6 @@
 #define ASYNC_SHARE_IRQ		(1U << ASYNCB_SHARE_IRQ)
 #define ASYNC_CONS_FLOW		(1U << ASYNCB_CONS_FLOW)
 #define ASYNC_INTERNAL_FLAGS	(~((1U << ASYNCB_FIRST_KERNEL) - 1))
+#endif
 
 #endif
-- 
2.8.1

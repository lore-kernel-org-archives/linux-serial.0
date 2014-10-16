From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH -next 05/10] tty: Document defunct ASYNC_* bits in uapi header
Date: Thu, 16 Oct 2014 16:54:22 -0400
Message-ID: <1413492867-20679-6-git-send-email-peter@hurleysoftware.com>
References: <1413492867-20679-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1413492867-20679-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, Peter Hurley <peter@hurleysoftware.com>
List-Id: linux-serial@vger.kernel.org

Note the serial_struct flags for which the kernel ignores and performs
no action. The flags cannot be removed since they form part of the
userspace interface via the TIOCSSERIAL/TIOCGSERIAL ioctls.

Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 include/uapi/linux/tty_flags.h | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/include/uapi/linux/tty_flags.h b/include/uapi/linux/tty_flags.h
index 7b516f7..4e021e3 100644
--- a/include/uapi/linux/tty_flags.h
+++ b/include/uapi/linux/tty_flags.h
@@ -8,6 +8,7 @@
  * Define ASYNCB_* for convenient use with {test,set,clear}_bit.
  *
  * Bits [0..ASYNCB_LAST_USER] are userspace defined/visible/changeable
+ * [x] in the bit comments indicates the flag is defunct and no longer used.
  */
 #define ASYNCB_HUP_NOTIFY	 0 /* Notify getty on hangups and closes
 				    * on the callout port */
@@ -19,15 +20,15 @@
 #define ASYNCB_SKIP_TEST	 6 /* Skip UART test during autoconfiguration */
 #define ASYNCB_AUTO_IRQ		 7 /* Do automatic IRQ during
 				    * autoconfiguration */
-#define ASYNCB_SESSION_LOCKOUT	 8 /* Lock out cua opens based on session */
-#define ASYNCB_PGRP_LOCKOUT	 9 /* Lock out cua opens based on pgrp */
-#define ASYNCB_CALLOUT_NOHUP	10 /* Don't do hangups for cua device */
+#define ASYNCB_SESSION_LOCKOUT	 8 /* [x] Lock out cua opens based on session */
+#define ASYNCB_PGRP_LOCKOUT	 9 /* [x] Lock out cua opens based on pgrp */
+#define ASYNCB_CALLOUT_NOHUP	10 /* [x] Don't do hangups for cua device */
 #define ASYNCB_HARDPPS_CD	11 /* Call hardpps when CD goes high  */
 #define ASYNCB_SPD_SHI		12 /* Use 230400 instead of 38400 bps */
 #define ASYNCB_LOW_LATENCY	13 /* Request low latency behaviour */
 #define ASYNCB_BUGGY_UART	14 /* This is a buggy UART, skip some safety
 				    * checks.  Note: can be dangerous! */
-#define ASYNCB_AUTOPROBE	15 /* Port was autoprobed by PCI or PNP code */
+#define ASYNCB_AUTOPROBE	15 /* [x] Port was autoprobed by PCI/PNP code */
 #define ASYNCB_MAGIC_MULTIPLIER	16 /* Use special CLK or divisor */
 #define ASYNCB_LAST_USER	16
 
-- 
2.1.1

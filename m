From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH -next 4/9] tty: Remove defunct serial_console_init() declaration
Date: Wed,  5 Nov 2014 12:26:27 -0500
Message-ID: <1415208392-16189-5-git-send-email-peter@hurleysoftware.com>
References: <1415208392-16189-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1415208392-16189-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Peter Hurley <peter@hurleysoftware.com>
List-Id: linux-serial@vger.kernel.org

serial_console_init() is not defined by the tty core; remove
declaration.

Note that the powerpc arch boot code contains a serial_console_init()
declaration in arch/powerpc/boot/ops.h which is restricted to
the powerpc arch boot.

Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 include/linux/tty.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/include/linux/tty.h b/include/linux/tty.h
index 97cfb31..c52a689 100644
--- a/include/linux/tty.h
+++ b/include/linux/tty.h
@@ -617,10 +617,6 @@ extern int n_tty_ioctl_helper(struct tty_struct *tty, struct file *file,
 extern long n_tty_compat_ioctl_helper(struct tty_struct *tty, struct file *file,
 		       unsigned int cmd, unsigned long arg);
 
-/* serial.c */
-
-extern void serial_console_init(void);
-
 /* vt.c */
 
 extern int vt_ioctl(struct tty_struct *tty,
-- 
2.1.3

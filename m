From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH -next 3/9] tty: Remove defunct pcxe_open() declaration
Date: Wed,  5 Nov 2014 12:26:26 -0500
Message-ID: <1415208392-16189-4-git-send-email-peter@hurleysoftware.com>
References: <1415208392-16189-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1415208392-16189-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Peter Hurley <peter@hurleysoftware.com>
List-Id: linux-serial@vger.kernel.org

pcxe_open() has no definition in mainline; remove declaration.

Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 include/linux/tty.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/include/linux/tty.h b/include/linux/tty.h
index f6835ea..97cfb31 100644
--- a/include/linux/tty.h
+++ b/include/linux/tty.h
@@ -621,10 +621,6 @@ extern long n_tty_compat_ioctl_helper(struct tty_struct *tty, struct file *file,
 
 extern void serial_console_init(void);
 
-/* pcxx.c */
-
-extern int pcxe_open(struct tty_struct *tty, struct file *filp);
-
 /* vt.c */
 
 extern int vt_ioctl(struct tty_struct *tty,
-- 
2.1.3

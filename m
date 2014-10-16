From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH -next 19/27] tty: Remove tty_unhangup() declaration
Date: Thu, 16 Oct 2014 16:25:17 -0400
Message-ID: <1413491125-20134-20-git-send-email-peter@hurleysoftware.com>
References: <1413491125-20134-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1413491125-20134-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, Peter Hurley <peter@hurleysoftware.com>
List-Id: linux-serial@vger.kernel.org

The tty_unhangup() function is not defined.

Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 include/linux/tty.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/tty.h b/include/linux/tty.h
index a07b4b4..d470a86 100644
--- a/include/linux/tty.h
+++ b/include/linux/tty.h
@@ -435,7 +435,6 @@ extern int is_ignored(int sig);
 extern int tty_signal(int sig, struct tty_struct *tty);
 extern void tty_hangup(struct tty_struct *tty);
 extern void tty_vhangup(struct tty_struct *tty);
-extern void tty_unhangup(struct file *filp);
 extern int tty_hung_up_p(struct file *filp);
 extern void do_SAK(struct tty_struct *tty);
 extern void __do_SAK(struct tty_struct *tty);
-- 
2.1.1

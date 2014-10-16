From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH -next 21/27] pty: Don't drop pty master tty lock to hangup slave
Date: Thu, 16 Oct 2014 16:25:19 -0400
Message-ID: <1413491125-20134-22-git-send-email-peter@hurleysoftware.com>
References: <1413491125-20134-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mailout32.mail01.mtsvc.net ([216.70.64.70]:47669 "EHLO
	n23.mail01.mtsvc.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751942AbaJPVCW (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 16 Oct 2014 17:02:22 -0400
In-Reply-To: <1413491125-20134-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, Peter Hurley <peter@hurleysoftware.com>

Introduce tty_vhangup_slave(), which takes tty_lock_slave() instead
of tty_lock(), and thus is callable while holding the pty master
tty lock.

Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 drivers/tty/pty.c    |  4 +---
 drivers/tty/tty_io.c | 20 ++++++++++++++++++++
 include/linux/tty.h  |  1 +
 3 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/pty.c b/drivers/tty/pty.c
index bdb8fd1..09fb513 100644
--- a/drivers/tty/pty.c
+++ b/drivers/tty/pty.c
@@ -66,9 +66,7 @@ static void pty_close(struct tty_struct *tty, struct file *filp)
 			mutex_unlock(&devpts_mutex);
 		}
 #endif
-		tty_unlock(tty);
-		tty_vhangup(tty->link);
-		tty_lock(tty);
+		tty_vhangup_slave(tty->link);
 	}
 }
 
diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index 48c1def..25e85b0 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -809,6 +809,26 @@ void tty_vhangup(struct tty_struct *tty)
 
 EXPORT_SYMBOL(tty_vhangup);
 
+/**
+ *	tty_vhangup_slave	-	process vhangup for pty slave
+ *	@tty: pty slave to hangup
+ *
+ *	Identical to tty_vhangup(), except can specifically be used
+ *	to synchronously hangup a pty slave while holding pty master
+ *	tty lock.
+ */
+
+static void __tty_vhangup_slave(struct tty_struct *tty, int exit_session)
+{
+	tty_lock_slave(tty);
+	__tty_hangup_common(tty, 0);
+	tty_unlock_slave(tty);
+}
+
+void tty_vhangup_slave(struct tty_struct *tty)
+{
+	__tty_hangup(tty, 0, __tty_vhangup_slave);
+}
 
 /**
  *	tty_vhangup_self	-	process vhangup for own ctty
diff --git a/include/linux/tty.h b/include/linux/tty.h
index d470a86..8a90253 100644
--- a/include/linux/tty.h
+++ b/include/linux/tty.h
@@ -435,6 +435,7 @@ extern int is_ignored(int sig);
 extern int tty_signal(int sig, struct tty_struct *tty);
 extern void tty_hangup(struct tty_struct *tty);
 extern void tty_vhangup(struct tty_struct *tty);
+extern void tty_vhangup_slave(struct tty_struct *tty);
 extern int tty_hung_up_p(struct file *filp);
 extern void do_SAK(struct tty_struct *tty);
 extern void __do_SAK(struct tty_struct *tty);
-- 
2.1.1


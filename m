From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH -next v2 21/26] pty: Don't drop pty master tty lock to hangup slave
Date: Wed,  5 Nov 2014 12:13:04 -0500
Message-ID: <1415207589-15967-22-git-send-email-peter@hurleysoftware.com>
References: <1413491125-20134-1-git-send-email-peter@hurleysoftware.com>
 <1415207589-15967-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1415207589-15967-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Peter Hurley <peter@hurleysoftware.com>
List-Id: linux-serial@vger.kernel.org

With the revised tty lock order and lockdep annotation, claiming
the pty slave lock is now safe while still holding the pty master lock.

Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 drivers/tty/pty.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/tty/pty.c b/drivers/tty/pty.c
index 11db7dc..bee9776 100644
--- a/drivers/tty/pty.c
+++ b/drivers/tty/pty.c
@@ -66,9 +66,7 @@ static void pty_close(struct tty_struct *tty, struct file *filp)
 			mutex_unlock(&devpts_mutex);
 		}
 #endif
-		tty_unlock(tty);
 		tty_vhangup(tty->link);
-		tty_lock(tty);
 	}
 }
 
-- 
2.1.3

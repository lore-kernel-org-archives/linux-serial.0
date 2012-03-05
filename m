From: Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 07/68] TTY: remove tty driver re-set from tty_reopen
Date: Mon,  5 Mar 2012 14:51:54 +0100
Message-ID: <1330955575-26641-8-git-send-email-jslaby@suse.cz>
References: <1330955575-26641-1-git-send-email-jslaby@suse.cz>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1330955575-26641-1-git-send-email-jslaby@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: alan@linux.intel.com, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, jirislaby@gmail.com
List-Id: linux-serial@vger.kernel.org

This is from tty_reopen:
    struct tty_driver *driver = tty->driver;
    ...
    tty->driver = driver;
and it doesn't make sense at all. The driver is intended to be set in
initialize_tty_struct from tty_init_dev (initial open). So this set in
tty_reopen is not needed.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/tty_io.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index d0d3d1f..dd8a938 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -1348,7 +1348,6 @@ static int tty_reopen(struct tty_struct *tty)
 		tty->link->count++;
 	}
 	tty->count++;
-	tty->driver = driver; /* N.B. why do this every time?? */
 
 	mutex_lock(&tty->ldisc_mutex);
 	WARN_ON(!test_bit(TTY_LDISC, &tty->flags));
-- 
1.7.9.2

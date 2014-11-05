From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH -next v2 12/26] tty: Document check_tty_count() requires tty_lock held
Date: Wed,  5 Nov 2014 12:12:55 -0500
Message-ID: <1415207589-15967-13-git-send-email-peter@hurleysoftware.com>
References: <1413491125-20134-1-git-send-email-peter@hurleysoftware.com>
 <1415207589-15967-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1415207589-15967-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Peter Hurley <peter@hurleysoftware.com>
List-Id: linux-serial@vger.kernel.org

Holding the tty_lock() is necessary to prevent concurrent changes
to the tty count that may cause it to differ from the open file
list count. The tty_lock() is already held at all call sites.

NB: Note that the check for the pty master tty count is safe because
the slave's tty_lock() is held while decrementing the pty master
tty count.

Reviewed-by: Alan Cox <alan@linux.intel.com>
Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 drivers/tty/tty_io.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index 276d939..41eeee0 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -275,6 +275,7 @@ int tty_paranoia_check(struct tty_struct *tty, struct inode *inode,
 	return 0;
 }
 
+/* Caller must hold tty_lock */
 static int check_tty_count(struct tty_struct *tty, const char *routine)
 {
 #ifdef CHECK_TTY_COUNT
-- 
2.1.3

From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH -next v2 05/26] tty: Check tty->count instead of TTY_CLOSING in tty_reopen()
Date: Wed,  5 Nov 2014 12:12:48 -0500
Message-ID: <1415207589-15967-6-git-send-email-peter@hurleysoftware.com>
References: <1413491125-20134-1-git-send-email-peter@hurleysoftware.com>
 <1415207589-15967-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1415207589-15967-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Peter Hurley <peter@hurleysoftware.com>
List-Id: linux-serial@vger.kernel.org

Although perhaps not obvious, the TTY_CLOSING bit is set when the
tty count has been decremented to 0 (which occurs while holding
tty_lock). The only other case when tty count is 0 during a re-open
is when a legacy BSD pty master has been opened in parallel but
after the pty slave, which is unsupported and returns an error.

Thus !tty->count contains the complete set of degenerate conditions
under which a tty open fails.

Reviewed-by: Alan Cox <alan@linux.intel.com>
Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 drivers/tty/tty_io.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index 6dc3fa0..97445c2 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -1452,7 +1452,7 @@ static int tty_reopen(struct tty_struct *tty)
 {
 	struct tty_driver *driver = tty->driver;
 
-	if (test_bit(TTY_CLOSING, &tty->flags))
+	if (!tty->count)
 		return -EIO;
 
 	if (driver->type == TTY_DRIVER_TYPE_PTY &&
-- 
2.1.3

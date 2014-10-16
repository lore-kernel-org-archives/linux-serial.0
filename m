From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH -next 05/27] tty: Check tty->count instead of TTY_CLOSING in tty_reopen()
Date: Thu, 16 Oct 2014 16:25:03 -0400
Message-ID: <1413491125-20134-6-git-send-email-peter@hurleysoftware.com>
References: <1413491125-20134-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1413491125-20134-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, Peter Hurley <peter@hurleysoftware.com>
List-Id: linux-serial@vger.kernel.org

Although perhaps not obvious, the TTY_CLOSING bit is set when the
tty count has been decremented to 0 (which occurs while holding
tty_lock). The only other case when tty count is 0 during a re-open
is when a legacy BSD pty master has been opened in parallel but
after the pty slave, which is unsupported and returns an error.

Thus !tty->count contains the complete set of degenerate conditions
under which a tty open fails.

Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 drivers/tty/tty_io.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index 5b6253f..52bcdd3 100644
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
2.1.1

From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH 20/20] tty: Remove extra wakeup from pty write() path
Date: Mon, 15 Apr 2013 11:32:51 -0400
Message-ID: <1366039971-8770-21-git-send-email-peter@hurleysoftware.com>
References: <1366039787-8719-1-git-send-email-peter@hurleysoftware.com>
 <1366039971-8770-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1366039971-8770-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Peter Hurley <peter@hurleysoftware.com>
List-Id: linux-serial@vger.kernel.org

Acquiring the write_wait queue spin lock now accounts for the largest
slice of cpu time on the tty write path. Two factors contribute to
this situation; a overly-pessimistic line discipline write loop which
_always_ sets up a wait loop even if i/o will immediately succeed, and
on ptys, a wakeup storm from reads and writes.

Writer wakeup does not need to be performed by the pty driver.
Firstly, since the actual i/o is performed within the write, the
line discipline write loop will continue while space remains in
the flip buffers. Secondly, when space becomes avail in the
line discipline receive buffer (and thus also in the flip buffers),
the pty unthrottle re-wakes the writer (non-flow-controlled line
disciplines unconditionally unthrottle the driver when data is
received). Thus, existing in-kernel i/o is guaranteed to advance.
Finally, writer wakeup occurs at the conclusion of the line discipline
write (in tty_write_unlock()). This guarantees that any user-space write
waiters are woken to continue additional i/o.

Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 drivers/tty/pty.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/tty/pty.c b/drivers/tty/pty.c
index ca1472b..9c2f1bc 100644
--- a/drivers/tty/pty.c
+++ b/drivers/tty/pty.c
@@ -121,10 +121,8 @@ static int pty_write(struct tty_struct *tty, const unsigned char *buf, int c)
 		/* Stuff the data into the input queue of the other end */
 		c = tty_insert_flip_string(to->port, buf, c);
 		/* And shovel */
-		if (c) {
+		if (c)
 			tty_flip_buffer_push(to->port);
-			tty_wakeup(tty);
-		}
 	}
 	return c;
 }
-- 
1.8.1.2

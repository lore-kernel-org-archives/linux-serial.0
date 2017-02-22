From: Wang YanQing <udknight@gmail.com>
Subject: [PATCH v3] tty: pty: Fix ldisc flush after userspace become aware of
 the data already
Date: Wed, 22 Feb 2017 19:37:08 +0800
Message-ID: <20170222113708.GA12125@udknight>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: jslaby@suse.com, peter@hurleysoftware.com, torvalds@linux-foundation.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

While using emacs, cat or others' commands in konsole with recent
kernels, I have met many times that CTRL-C freeze konsole. After
konsole freeze I can't type anything, then I have to open a new one,
it is very annoying.

See bug report:
https://bugs.kde.org/show_bug.cgi?id=175283

The platform in that bug report is Solaris, but now the pty in linux
has the same problem or the same behavior as Solaris :)

It has high possibility to trigger the problem follow steps below:
Note: In my test, BigFile is a text file whose size is bigger than 1G
1:open konsole
1:cat BigFile
2:CTRL-C

After some digging, I find out the reason is that commit 1d1d14da12e7
("pty: Fix buffer flush deadlock") changes the behavior of pty_flush_buffer.

Thread A                                 Thread B
--------                                 --------
1:n_tty_poll return POLLIN
                                         2:CTRL-C trigger pty_flush_buffer
                                             tty_buffer_flush
                                               n_tty_flush_buffer
3:attempt to check count of chars:
  ioctl(fd, TIOCINQ, &available)
  available is equal to 0

4:read(fd, buffer, avaiable)
  return 0

5:konsole close fd

Yes, I know we could use the same patch included in the BUG report as
a workaround for linux platform too. But I think the data in ldisc is
belong to application of another side, we shouldn't clear it when we
want to flush write buffer of this side in pty_flush_buffer. So I think
it is better to disable ldisc flush in pty_flush_buffer, because its new
hehavior bring no benefit except that it mess up the behavior between
POLLIN, and TIOCINQ or FIONREAD.

Also I find no flush_buffer function in others' tty driver has the
same behavior as current pty_flush_buffer.

Fixes: 1d1d14da12e7 ("pty: Fix buffer flush deadlock")
CC: stable@vger.kernel.org # v4.0+
Signed-off-by: Wang YanQing <udknight@gmail.com>
---
 changes:
 v2-v3:
 1: Rewrite the oneline description, subject, again.
 2: Reword changelog.

 Please let me know if your reply is NACK :)

 drivers/tty/pty.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/tty/pty.c b/drivers/tty/pty.c
index 51e0d32..5a8b944 100644
--- a/drivers/tty/pty.c
+++ b/drivers/tty/pty.c
@@ -216,16 +216,11 @@ static int pty_signal(struct tty_struct *tty, int sig)
 static void pty_flush_buffer(struct tty_struct *tty)
 {
 	struct tty_struct *to = tty->link;
-	struct tty_ldisc *ld;
 
 	if (!to)
 		return;
 
-	ld = tty_ldisc_ref(to);
-	tty_buffer_flush(to, ld);
-	if (ld)
-		tty_ldisc_deref(ld);
-
+	tty_buffer_flush(to, NULL);
 	if (to->packet) {
 		spin_lock_irq(&tty->ctrl_lock);
 		tty->ctrl_status |= TIOCPKT_FLUSHWRITE;
-- 
1.8.5.6.2.g3d8a54e.dirty

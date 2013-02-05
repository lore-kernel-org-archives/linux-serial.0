From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH v3 18/23] tty: Remove stale comment re: tty_ldisc_flush_works()
Date: Tue,  5 Feb 2013 15:20:33 -0500
Message-ID: <1360095638-6624-19-git-send-email-peter@hurleysoftware.com>
References: <1355509370-5883-1-git-send-email-peter@hurleysoftware.com>
 <1360095638-6624-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1360095638-6624-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Cox <alan@linux.intel.com>, Jiri Slaby <jslaby@suse.cz>, Sasha Levin <levinsasha928@gmail.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Ilya Zykov <ilya@ilyx.ru>, Dave Jones <davej@redhat.com>, Peter Hurley <peter@hurleysoftware.com>
List-Id: linux-serial@vger.kernel.org

Waiting for a pending hangup to complete is not a necessary
post-operation of using tty_ldisc_halt() and not sufficient to
guarantee a hangup is not in-progress. As far as the ldisc layer
is concerned, waiting for a pending hangup is necessary only
prior to changing the ldisc while handling the TIOCSETD ioctl (and
only because the tty lock must be released as a precondition
of halting the ldisc).

Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 drivers/tty/tty_ldisc.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/tty/tty_ldisc.c b/drivers/tty/tty_ldisc.c
index 9599b05..f3cbfb3 100644
--- a/drivers/tty/tty_ldisc.c
+++ b/drivers/tty/tty_ldisc.c
@@ -538,10 +538,6 @@ static int tty_ldisc_wait_idle(struct tty_struct *tty, long timeout)
  *
  *	Callers other than tty_ldisc_release() must hold ->ldisc_mutex and
  *	cannot be holding tty_lock() (aka legacy_mutex).
- *
- *	You need to do a 'flush_scheduled_work()' (outside the ldisc_mutex)
- *	in order to make sure any currently executing ldisc work is also
- *	flushed.
  */
 
 static int tty_ldisc_halt(struct tty_struct *tty, struct tty_struct *o_tty,
-- 
1.8.1.2

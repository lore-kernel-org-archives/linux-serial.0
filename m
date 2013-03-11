From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH v5 16/44] tty: Fix 'deferred reopen' ldisc comment
Date: Mon, 11 Mar 2013 16:44:36 -0400
Message-ID: <1363034704-28036-17-git-send-email-peter@hurleysoftware.com>
References: <1361390599-15195-1-git-send-email-peter@hurleysoftware.com>
 <1363034704-28036-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1363034704-28036-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>
Cc: Sasha Levin <levinsasha928@gmail.com>, Dave Jones <davej@redhat.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Shawn Guo <shawn.guo@linaro.org>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Peter Hurley <peter@hurleysoftware.com>
List-Id: linux-serial@vger.kernel.org

This comment is a victim of code migration from
"tty: Fix the ldisc hangup race"; re-parent it.

Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 drivers/tty/tty_ldisc.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/tty_ldisc.c b/drivers/tty/tty_ldisc.c
index 7f7e1a3..0030d55 100644
--- a/drivers/tty/tty_ldisc.c
+++ b/drivers/tty/tty_ldisc.c
@@ -854,11 +854,12 @@ void tty_ldisc_hangup(struct tty_struct *tty)
 	 */
 	mutex_lock(&tty->ldisc_mutex);
 
-	/* At this point we have a closed ldisc and we want to
-	   reopen it. We could defer this to the next open but
-	   it means auditing a lot of other paths so this is
-	   a FIXME */
 	if (tty_ldisc_hangup_halt(tty)) {
+
+		/* At this point we have a halted ldisc; we want to close it and
+		   reopen a new ldisc. We could defer the reopen to the next
+		   open but it means auditing a lot of other paths so this is
+		   a FIXME */
 		if (reset == 0) {
 
 			if (!tty_ldisc_reinit(tty, tty->termios.c_line))
-- 
1.8.1.2

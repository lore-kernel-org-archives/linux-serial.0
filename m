From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH -next 3/9] pty: Use spin_lock_irq() for pty_set_termios()
Date: Thu, 16 Oct 2014 15:33:24 -0400
Message-ID: <1413488010-16885-4-git-send-email-peter@hurleysoftware.com>
References: <1413488010-16885-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1413488010-16885-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, Peter Hurley <peter@hurleysoftware.com>
List-Id: linux-serial@vger.kernel.org

The tty driver's set_termios() method is called with interrupts
enabled; there is no need to save and restore the local interrupt state.

Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 drivers/tty/pty.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/pty.c b/drivers/tty/pty.c
index 7f612c5..3943747 100644
--- a/drivers/tty/pty.c
+++ b/drivers/tty/pty.c
@@ -259,8 +259,6 @@ out:
 static void pty_set_termios(struct tty_struct *tty,
 					struct ktermios *old_termios)
 {
-	unsigned long flags;
-
 	/* See if packet mode change of state. */
 	if (tty->link && tty->link->packet) {
 		int extproc = (old_termios->c_lflag & EXTPROC) |
@@ -272,7 +270,7 @@ static void pty_set_termios(struct tty_struct *tty,
 				STOP_CHAR(tty) == '\023' &&
 				START_CHAR(tty) == '\021');
 		if ((old_flow != new_flow) || extproc) {
-			spin_lock_irqsave(&tty->ctrl_lock, flags);
+			spin_lock_irq(&tty->ctrl_lock);
 			if (old_flow != new_flow) {
 				tty->ctrl_status &= ~(TIOCPKT_DOSTOP | TIOCPKT_NOSTOP);
 				if (new_flow)
@@ -282,7 +280,7 @@ static void pty_set_termios(struct tty_struct *tty,
 			}
 			if (extproc)
 				tty->ctrl_status |= TIOCPKT_IOCTL;
-			spin_unlock_irqrestore(&tty->ctrl_lock, flags);
+			spin_unlock_irq(&tty->ctrl_lock);
 			wake_up_interruptible(&tty->link->read_wait);
 		}
 	}
-- 
2.1.1

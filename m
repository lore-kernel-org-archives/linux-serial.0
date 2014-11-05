From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH -next 1/5] tty: Allow safe access to termios for set_ldisc() handlers
Date: Wed,  5 Nov 2014 13:11:41 -0500
Message-ID: <1415211105-16668-2-git-send-email-peter@hurleysoftware.com>
References: <1415211105-16668-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1415211105-16668-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Nicolas Ferre <nicolas.ferre@atmel.com>, Peter Hurley <peter@hurleysoftware.com>
List-Id: linux-serial@vger.kernel.org

Allow a tty driver to safely access termios settings while handling
the set_ldisc() notification. UART drivers use the set_ldisc()
notification to check if the N_PPS line discipline is being enabled;
if so, modem status interrupts may also need to be enabled. Conversely,
modem status interrupts may need to be disabled if switching away
from the N_PPS line discipline.

Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 drivers/tty/tty_ldisc.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/tty_ldisc.c b/drivers/tty/tty_ldisc.c
index b66a81d..3737f55 100644
--- a/drivers/tty/tty_ldisc.c
+++ b/drivers/tty/tty_ldisc.c
@@ -572,8 +572,11 @@ int tty_set_ldisc(struct tty_struct *tty, int ldisc)
 		tty_ldisc_restore(tty, old_ldisc);
 	}
 
-	if (tty->ldisc->ops->num != old_ldisc->ops->num && tty->ops->set_ldisc)
+	if (tty->ldisc->ops->num != old_ldisc->ops->num && tty->ops->set_ldisc) {
+		down_read(&tty->termios_rwsem);
 		tty->ops->set_ldisc(tty);
+		up_read(&tty->termios_rwsem);
+	}
 
 	/* At this point we hold a reference to the new ldisc and a
 	   reference to the old ldisc, or we hold two references to
-- 
2.1.3

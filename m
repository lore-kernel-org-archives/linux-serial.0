From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH v5 19/44] tty: Don't protect atomic operation with mutex
Date: Mon, 11 Mar 2013 16:44:39 -0400
Message-ID: <1363034704-28036-20-git-send-email-peter@hurleysoftware.com>
References: <1361390599-15195-1-git-send-email-peter@hurleysoftware.com>
 <1363034704-28036-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1363034704-28036-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>
Cc: Sasha Levin <levinsasha928@gmail.com>, Dave Jones <davej@redhat.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Shawn Guo <shawn.guo@linaro.org>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Peter Hurley <peter@hurleysoftware.com>
List-Id: linux-serial@vger.kernel.org

test_bit() is already atomic; drop mutex lock/unlock.

Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 drivers/tty/tty_io.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index 2ac516d..bf33440 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -1345,9 +1345,7 @@ static int tty_reopen(struct tty_struct *tty)
 	}
 	tty->count++;
 
-	mutex_lock(&tty->ldisc_mutex);
 	WARN_ON(!test_bit(TTY_LDISC, &tty->flags));
-	mutex_unlock(&tty->ldisc_mutex);
 
 	return 0;
 }
-- 
1.8.1.2

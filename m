From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH v4 19/32] tty: Don't protect atomic operation with mutex
Date: Wed, 20 Feb 2013 15:03:06 -0500
Message-ID: <1361390599-15195-20-git-send-email-peter@hurleysoftware.com>
References: <1361390599-15195-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mailout02.c08.mtsvc.net ([205.186.168.190]:54762 "EHLO
	mailout02.c08.mtsvc.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964809Ab3BTUPd (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 20 Feb 2013 15:15:33 -0500
In-Reply-To: <1361390599-15195-1-git-send-email-peter@hurleysoftware.com>
In-Reply-To: <1360095638-6624-1-git-send-email-peter@hurleysoftware.com>
References: <1360095638-6624-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>
Cc: Sasha Levin <levinsasha928@gmail.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Ilya Zykov <ilya@ilyx.ru>, Dave Jones <davej@redhat.com>, Michael Ellerman <michael@ellerman.id.au>, Shawn Guo <shawn.guo@linaro.org>, Peter Hurley <peter@hurleysoftware.com>

test_bit() is already atomic; drop mutex lock/unlock.

Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 drivers/tty/tty_io.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index cfcd849..2261c21 100644
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


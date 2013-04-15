From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH tty-next] tty: Fix unsafe bit ops in tty_throttle_safe/unthrottle_safe
Date: Mon, 15 Apr 2013 11:06:06 -0400
Message-ID: <1366038366-8332-1-git-send-email-peter@hurleysoftware.com>
References: <1362576053-1295-2-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mailout02.c08.mtsvc.net ([205.186.168.190]:43661 "EHLO
	mailout02.c08.mtsvc.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751335Ab3DOPGd (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 15 Apr 2013 11:06:33 -0400
In-Reply-To: <1362576053-1295-2-git-send-email-peter@hurleysoftware.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>, Vincent Pillet <vincentx.pillet@intel.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Peter Hurley <peter@hurleysoftware.com>

tty->flags needs to be atomically modified.

Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 drivers/tty/tty_ioctl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/tty_ioctl.c b/drivers/tty/tty_ioctl.c
index 2febed5..ce67f2c 100644
--- a/drivers/tty/tty_ioctl.c
+++ b/drivers/tty/tty_ioctl.c
@@ -156,7 +156,7 @@ int tty_throttle_safe(struct tty_struct *tty)
 		if (tty->flow_change != TTY_THROTTLE_SAFE)
 			ret = 1;
 		else {
-			__set_bit(TTY_THROTTLED, &tty->flags);
+			set_bit(TTY_THROTTLED, &tty->flags);
 			if (tty->ops->throttle)
 				tty->ops->throttle(tty);
 		}
@@ -187,7 +187,7 @@ int tty_unthrottle_safe(struct tty_struct *tty)
 		if (tty->flow_change != TTY_UNTHROTTLE_SAFE)
 			ret = 1;
 		else {
-			__clear_bit(TTY_THROTTLED, &tty->flags);
+			clear_bit(TTY_THROTTLED, &tty->flags);
 			if (tty->ops->unthrottle)
 				tty->ops->unthrottle(tty);
 		}
-- 
1.8.1.2


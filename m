From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH v5 10/44] tty: Wait for SAK work before waiting for hangup work
Date: Mon, 11 Mar 2013 16:44:30 -0400
Message-ID: <1363034704-28036-11-git-send-email-peter@hurleysoftware.com>
References: <1361390599-15195-1-git-send-email-peter@hurleysoftware.com>
 <1363034704-28036-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mailout01.c08.mtsvc.net ([205.186.168.189]:33323 "EHLO
	mailout01.c08.mtsvc.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753530Ab3CKVPJ (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 11 Mar 2013 17:15:09 -0400
In-Reply-To: <1363034704-28036-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>
Cc: Sasha Levin <levinsasha928@gmail.com>, Dave Jones <davej@redhat.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Shawn Guo <shawn.guo@linaro.org>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Peter Hurley <peter@hurleysoftware.com>

SAK work may schedule hangup work (if TTY_SOFT_SAK is defined), thus
SAK work must be flushed before hangup work.

Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 drivers/tty/tty_ldisc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/tty_ldisc.c b/drivers/tty/tty_ldisc.c
index 7712091..37671fcc 100644
--- a/drivers/tty/tty_ldisc.c
+++ b/drivers/tty/tty_ldisc.c
@@ -506,8 +506,8 @@ static void tty_ldisc_restore(struct tty_struct *tty, struct tty_ldisc *old)
  */
 static void tty_ldisc_flush_works(struct tty_struct *tty)
 {
-	flush_work(&tty->hangup_work);
 	flush_work(&tty->SAK_work);
+	flush_work(&tty->hangup_work);
 	flush_work(&tty->port->buf.work);
 }
 
-- 
1.8.1.2


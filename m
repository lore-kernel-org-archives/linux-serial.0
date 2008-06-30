From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] send_break: Return fix
Date: Mon, 30 Jun 2008 17:40:08 +0100
Message-ID: <20080630174008.502ef0b6@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:55802 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753369AbYF3Q5t (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 30 Jun 2008 12:57:49 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: torvalds@osdl.org, greg@kroah.com, linux-serial@vger.kernel.org

Not sure how this came to get inverted but it appears to have been my
mess up.

Signed-off-by: Alan Cox <alan@redhat.com>

tty: Fix inverted logic in send_break

From: Alan Cox <alan@redhat.com>


---

 drivers/char/tty_io.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)


diff --git a/drivers/char/tty_io.c b/drivers/char/tty_io.c
index e94bee0..7501310 100644
--- a/drivers/char/tty_io.c
+++ b/drivers/char/tty_io.c
@@ -3322,7 +3322,7 @@ static int send_break(struct tty_struct *tty, unsigned int duration)
 		msleep_interruptible(duration);
 	tty->ops->break_ctl(tty, 0);
 	tty_write_unlock(tty);
-	if (!signal_pending(current))
+	if (signal_pending(current))
 		return -EINTR;
 	return 0;
 }

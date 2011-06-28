From: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 07/12] TTY: ntty, add one more sanity check
Date: Tue, 28 Jun 2011 09:03:44 -0700
Message-ID: <1309277029-1532-7-git-send-email-gregkh@suse.de>
References: <20110628153856.GB32710@kroah.com>
 <1309277029-1532-1-git-send-email-gregkh@suse.de>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:44936 "EHLO
	out4.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758940Ab1F1QEB (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 28 Jun 2011 12:04:01 -0400
In-Reply-To: <1309277029-1532-1-git-send-email-gregkh@suse.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Jiri Slaby <jslaby@suse.cz>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Greg Kroah-Hartman <gregkh@suse.de>

From: Jiri Slaby <jslaby@suse.cz>

With the previous patch, we fixed another bug where read_buf was freed
while we still was in n_tty_read. We currently check whether read_buf
is NULL at the start of the function. Add one more check after we wake
up from waiting for input.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/tty/n_tty.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
index 0ad3288..c3954fb 100644
--- a/drivers/tty/n_tty.c
+++ b/drivers/tty/n_tty.c
@@ -1815,6 +1815,7 @@ do_it_again:
 			/* FIXME: does n_tty_set_room need locking ? */
 			n_tty_set_room(tty);
 			timeout = schedule_timeout(timeout);
+			BUG_ON(!tty->read_buf);
 			continue;
 		}
 		__set_current_state(TASK_RUNNING);
-- 
1.7.5.4


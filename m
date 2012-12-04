From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH -next 1/9] tty: WARN if buffer work racing with tty free
Date: Tue,  4 Dec 2012 02:07:37 -0500
Message-ID: <1354604865-10278-2-git-send-email-peter@hurleysoftware.com>
References: <1354604865-10278-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mailout39.mail01.mtsvc.net ([216.70.64.83]:52745 "EHLO
	n12.mail01.mtsvc.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751212Ab2LDHIr (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 4 Dec 2012 02:08:47 -0500
In-Reply-To: <1354604865-10278-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Cox <alan@linux.intel.com>, Jiri Slaby <jslaby@suse.cz>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Peter Hurley <peter@hurleysoftware.com>


Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 drivers/tty/tty_io.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index 78c3000..3d2b6d7 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -1511,6 +1511,8 @@ static void queue_release_one_tty(struct kref *kref)
 {
 	struct tty_struct *tty = container_of(kref, struct tty_struct, kref);
 
+	WARN_ON(work_pending(&tty->port->buf.work));
+
 	/* The hangup queue is now free so we can reuse it rather than
 	   waste a chunk of memory for each port */
 	INIT_WORK(&tty->hangup_work, release_one_tty);
-- 
1.8.0


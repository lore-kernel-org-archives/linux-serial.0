From: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 68/79] TTY: drop driver reference in tty_open fail path
Date: Wed, 26 Oct 2011 14:13:13 +0200
Message-ID: <1319631204-23262-68-git-send-email-gregkh@suse.de>
References: <20111026114236.GA22180@kroah.com>
 <1319631204-23262-1-git-send-email-gregkh@suse.de>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:32860 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932957Ab1JZMOB (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 26 Oct 2011 08:14:01 -0400
In-Reply-To: <1319631204-23262-1-git-send-email-gregkh@suse.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Jiri Slaby <jslaby@suse.cz>, stable <stable@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Greg Kroah-Hartman <gregkh@suse.de>

From: Jiri Slaby <jslaby@suse.cz>

When tty_driver_lookup_tty fails in tty_open, we forget to drop a
reference to the tty driver. This was added by commit 4a2b5fddd5 (Move
tty lookup/reopen to caller).

Fix that by adding tty_driver_kref_put to the fail path.

I will refactor the code later. This is for the ease of backporting to
stable.

Introduced-in: v2.6.28-rc2
Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Cc: stable <stable@vger.kernel.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Acked-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/tty/tty_io.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index 4ca4bcd..6913da8 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -1873,6 +1873,7 @@ got_driver:
 		if (IS_ERR(tty)) {
 			tty_unlock();
 			mutex_unlock(&tty_mutex);
+			tty_driver_kref_put(driver);
 			return PTR_ERR(tty);
 		}
 	}
-- 
1.7.7


From: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 66/76] nozomi: don't use flush_scheduled_work()
Date: Wed, 16 Mar 2011 14:12:36 -0700
Message-ID: <1300309966-5745-66-git-send-email-gregkh@suse.de>
References: <20110316205746.GA2938@kroah.com>
 <1300309966-5745-1-git-send-email-gregkh@suse.de>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from kroah.org ([198.145.64.141]:32879 "EHLO coco.kroah.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754582Ab1CPVPO (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 16 Mar 2011 17:15:14 -0400
In-Reply-To: <1300309966-5745-1-git-send-email-gregkh@suse.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>, Jiri Slaby <jslaby@suse.cz>, Alan Cox <alan@linux.intel.com>, Greg Kroah-Hartman <gregkh@suse.de>

From: Tejun Heo <tj@kernel.org>

flush_scheduled_work() in tty_exit() doesn't seem to target any
specific work.  If it was to flush work items used in tty generic
layer, they're already flushed properly during tty release.

flush_scheduled_work() is going away.  Remove the seemingly redundant
usage.

Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: Jiri Slaby <jslaby@suse.cz>
Cc: Alan Cox <alan@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/tty/nozomi.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/nozomi.c b/drivers/tty/nozomi.c
index 513ba12..f4f1116 100644
--- a/drivers/tty/nozomi.c
+++ b/drivers/tty/nozomi.c
@@ -1514,8 +1514,6 @@ static void __devexit tty_exit(struct nozomi *dc)
 
 	DBG1(" ");
 
-	flush_scheduled_work();
-
 	for (i = 0; i < MAX_PORT; ++i) {
 		struct tty_struct *tty = tty_port_tty_get(&dc->port[i].port);
 		if (tty && list_empty(&tty->hangup_work.entry))
-- 
1.7.4.1


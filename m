From: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 06/76] tty_ldisc: don't use flush_scheduled_work()
Date: Wed, 16 Mar 2011 14:11:36 -0700
Message-ID: <1300309966-5745-6-git-send-email-gregkh@suse.de>
References: <20110316205746.GA2938@kroah.com>
 <1300309966-5745-1-git-send-email-gregkh@suse.de>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from kroah.org ([198.145.64.141]:60993 "EHLO coco.kroah.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754641Ab1CPVMz (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 16 Mar 2011 17:12:55 -0400
In-Reply-To: <1300309966-5745-1-git-send-email-gregkh@suse.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>, Greg Kroah-Hartman <gregkh@suse.de>

From: Tejun Heo <tj@kernel.org>

flush_scheduled_work() is scheduled to be deprecated.  Explicitly sync
flush the used work items instead.  Note that before this change,
flush_scheduled_work() wouldn't have properly flushed tty->buf.work if
it were on timer.

Signed-off-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/tty/tty_ldisc.c |   17 +++++++++++++++--
 1 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/tty_ldisc.c b/drivers/tty/tty_ldisc.c
index 4214d58..c42f402 100644
--- a/drivers/tty/tty_ldisc.c
+++ b/drivers/tty/tty_ldisc.c
@@ -535,6 +535,19 @@ static int tty_ldisc_halt(struct tty_struct *tty)
 }
 
 /**
+ *	tty_ldisc_flush_works	-	flush all works of a tty
+ *	@tty: tty device to flush works for
+ *
+ *	Sync flush all works belonging to @tty.
+ */
+static void tty_ldisc_flush_works(struct tty_struct *tty)
+{
+	flush_work_sync(&tty->hangup_work);
+	flush_work_sync(&tty->SAK_work);
+	flush_delayed_work_sync(&tty->buf.work);
+}
+
+/**
  *	tty_ldisc_wait_idle	-	wait for the ldisc to become idle
  *	@tty: tty to wait for
  *
@@ -653,7 +666,7 @@ int tty_set_ldisc(struct tty_struct *tty, int ldisc)
 
 	mutex_unlock(&tty->ldisc_mutex);
 
-	flush_scheduled_work();
+	tty_ldisc_flush_works(tty);
 
 	retval = tty_ldisc_wait_idle(tty);
 
@@ -905,7 +918,7 @@ void tty_ldisc_release(struct tty_struct *tty, struct tty_struct *o_tty)
 
 	tty_unlock();
 	tty_ldisc_halt(tty);
-	flush_scheduled_work();
+	tty_ldisc_flush_works(tty);
 	tty_lock();
 
 	mutex_lock(&tty->ldisc_mutex);
-- 
1.7.4.1


From: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 32/48] TTY: tty_io, annotate locking functions
Date: Mon, 23 May 2011 12:10:38 -0700
Message-ID: <1306177854-18172-32-git-send-email-gregkh@suse.de>
References: <20110523190539.GA17519@kroah.com>
 <1306177854-18172-1-git-send-email-gregkh@suse.de>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:42082 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932658Ab1EWTLi (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Mon, 23 May 2011 15:11:38 -0400
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.221.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.suse.de (Postfix) with ESMTP id 496E093987
	for <linux-serial@vger.kernel.org>; Mon, 23 May 2011 21:11:37 +0200 (CEST)
In-Reply-To: <1306177854-18172-1-git-send-email-gregkh@suse.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Jiri Slaby <jslaby@suse.cz>, Greg Kroah-Hartman <gregkh@suse.de>

From: Jiri Slaby <jslaby@suse.cz>

tty_write_lock and tty_write_unlock contain imbalanced locking. But
this is intentional, so mark them appropriately by
__acquires/__releases.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/tty/tty_io.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index 3f4ad98..6556f74 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -962,12 +962,14 @@ static ssize_t tty_read(struct file *file, char __user *buf, size_t count,
 }
 
 void tty_write_unlock(struct tty_struct *tty)
+	__releases(&tty->atomic_write_lock)
 {
 	mutex_unlock(&tty->atomic_write_lock);
 	wake_up_interruptible_poll(&tty->write_wait, POLLOUT);
 }
 
 int tty_write_lock(struct tty_struct *tty, int ndelay)
+	__acquires(&tty->atomic_write_lock)
 {
 	if (!mutex_trylock(&tty->atomic_write_lock)) {
 		if (ndelay)
-- 
1.7.4.2


From: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 32/79] TTY: define tty_wait_until_sent_from_close
Date: Wed, 26 Oct 2011 14:12:37 +0200
Message-ID: <1319631204-23262-32-git-send-email-gregkh@suse.de>
References: <20111026114236.GA22180@kroah.com>
 <1319631204-23262-1-git-send-email-gregkh@suse.de>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:60993 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932892Ab1JZMNm (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 26 Oct 2011 08:13:42 -0400
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.221.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id 47C608FB03
	for <linux-serial@vger.kernel.org>; Wed, 26 Oct 2011 14:13:41 +0200 (CEST)
In-Reply-To: <1319631204-23262-1-git-send-email-gregkh@suse.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Jiri Slaby <jslaby@suse.cz>, Greg Kroah-Hartman <gregkh@suse.de>

From: Jiri Slaby <jslaby@suse.cz>

We need this helper to fix system stalls. The issue is that the rest
of the system TTYs wait for us to finish waiting. This wasn't an issue
with BKL. BKL used to unlock implicitly.

This is based on the Arnd suggestion.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Acked-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 include/linux/tty.h |   18 ++++++++++++++++++
 1 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/include/linux/tty.h b/include/linux/tty.h
index 6d5eceb..0ad6888 100644
--- a/include/linux/tty.h
+++ b/include/linux/tty.h
@@ -602,6 +602,24 @@ extern void __lockfunc tty_lock(void) __acquires(tty_lock);
 extern void __lockfunc tty_unlock(void) __releases(tty_lock);
 
 /*
+ * this shall be called only from where BTM is held (like close)
+ *
+ * We need this to ensure nobody waits for us to finish while we are waiting.
+ * Without this we were encountering system stalls.
+ *
+ * This should be indeed removed with BTM removal later.
+ *
+ * Locking: BTM required. Nobody is allowed to hold port->mutex.
+ */
+static inline void tty_wait_until_sent_from_close(struct tty_struct *tty,
+		long timeout)
+{
+	tty_unlock(); /* tty->ops->close holds the BTM, drop it while waiting */
+	tty_wait_until_sent(tty, timeout);
+	tty_lock();
+}
+
+/*
  * wait_event_interruptible_tty -- wait for a condition with the tty lock held
  *
  * The condition we are waiting for might take a long time to
-- 
1.7.7


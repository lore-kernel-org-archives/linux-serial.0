From: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 63/79] hvc_console: display printk messages on console.
Date: Wed, 26 Oct 2011 14:13:08 +0200
Message-ID: <1319631204-23262-63-git-send-email-gregkh@suse.de>
References: <20111026114236.GA22180@kroah.com>
 <1319631204-23262-1-git-send-email-gregkh@suse.de>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:32843 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932917Ab1JZMN5 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 26 Oct 2011 08:13:57 -0400
In-Reply-To: <1319631204-23262-1-git-send-email-gregkh@suse.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Miche Baker-Harvey <miche@google.com>, Greg Kroah-Hartman <gregkh@suse.de>

From: Miche Baker-Harvey <miche@google.com>

printk only works for "registered consoles."  Currently, the hvc_console
code calls register_console() from hvc_instantiate(), but that's only
used in the early console case.  In hvc_alloc(), register_console() was
not called.

Add a call to register_console() in hvc_alloc(), set up the index in
the hvc_console, and set up the necessary vtermnos[] and cons_op[]
entries so that printk functions work.

Signed-off-by: Miche Baker-Harvey <miche@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/tty/hvc/hvc_console.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/drivers/tty/hvc/hvc_console.c b/drivers/tty/hvc/hvc_console.c
index b6b2d18..7430bc3 100644
--- a/drivers/tty/hvc/hvc_console.c
+++ b/drivers/tty/hvc/hvc_console.c
@@ -852,7 +852,7 @@ struct hvc_struct *hvc_alloc(uint32_t vtermno, int data,
 	 * find index to use:
 	 * see if this vterm id matches one registered for console.
 	 */
-	for (i=0; i < MAX_NR_HVC_CONSOLES; i++)
+	for (i = 0; i < MAX_NR_HVC_CONSOLES; i++)
 		if (vtermnos[i] == hp->vtermno &&
 		    cons_ops[i] == hp->ops)
 			break;
@@ -862,9 +862,13 @@ struct hvc_struct *hvc_alloc(uint32_t vtermno, int data,
 		i = ++last_hvc;
 
 	hp->index = i;
+	hvc_console.index = i;
+	vtermnos[i] = vtermno;
+	cons_ops[i] = ops;
 
 	list_add_tail(&(hp->next), &hvc_structs);
 	spin_unlock(&hvc_structs_lock);
+	register_console(&hvc_console);
 
 	return hp;
 }
@@ -875,6 +879,7 @@ int hvc_remove(struct hvc_struct *hp)
 	unsigned long flags;
 	struct tty_struct *tty;
 
+	unregister_console(&hvc_console);
 	spin_lock_irqsave(&hp->lock, flags);
 	tty = tty_kref_get(hp->tty);
 
-- 
1.7.7


From: Alan Cox <alan@linux.intel.com>
Subject: [PATCH 09/11] epca: Kill the big kernel lock
Date: Wed, 19 May 2010 13:03:18 +0100
Message-ID: <20100519120315.16717.13936.stgit@localhost.localdomain>
References: <20100519120111.16717.71992.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:51110 "EHLO
	bob.linux.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758041Ab0ESMpq (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 19 May 2010 08:45:46 -0400
In-Reply-To: <20100519120111.16717.71992.stgit@localhost.localdomain>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: greg@kroah.com, linux-serial@vger.kernel.org

The lock is no longer needed for wait until sent paths so this can go

Signed-off-by: Alan Cox <alan@linux.intel.com>
---

 drivers/char/epca.c |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)


diff --git a/drivers/char/epca.c b/drivers/char/epca.c
index 6f5ffe1..d9df46a 100644
--- a/drivers/char/epca.c
+++ b/drivers/char/epca.c
@@ -36,7 +36,7 @@
 #include <linux/ctype.h>
 #include <linux/tty.h>
 #include <linux/tty_flip.h>
-#include <linux/smp_lock.h>
+#include <linux/slab.h>
 #include <linux/ioport.h>
 #include <linux/interrupt.h>
 #include <linux/uaccess.h>
@@ -2105,7 +2105,6 @@ static int pc_ioctl(struct tty_struct *tty, struct file *file,
 		break;
 	case DIGI_SETAW:
 	case DIGI_SETAF:
-		lock_kernel();
 		if (cmd == DIGI_SETAW) {
 			/* Setup an event to indicate when the transmit
 			   buffer empties */
@@ -2118,7 +2117,6 @@ static int pc_ioctl(struct tty_struct *tty, struct file *file,
 			if (tty->ldisc->ops->flush_buffer)
 				tty->ldisc->ops->flush_buffer(tty);
 		}
-		unlock_kernel();
 		/* Fall Thru */
 	case DIGI_SETA:
 		if (copy_from_user(&ch->digiext, argp, sizeof(digi_t)))


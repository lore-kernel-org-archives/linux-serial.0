From: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 38/76] tty: fix build error in vt_ioctl.c if CONFIG_COMPAT is enabled
Date: Wed, 16 Mar 2011 14:12:08 -0700
Message-ID: <1300309966-5745-38-git-send-email-gregkh@suse.de>
References: <20110316205746.GA2938@kroah.com>
 <1300309966-5745-1-git-send-email-gregkh@suse.de>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from kroah.org ([198.145.64.141]:33001 "EHLO coco.kroah.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754855Ab1CPVOG (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 16 Mar 2011 17:14:06 -0400
In-Reply-To: <1300309966-5745-1-git-send-email-gregkh@suse.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@suse.de>, Alan Cox <alan@linux.intel.com>

This was caused by the previous patch to remove the file pointer
from the tty ioctl handler.

Cc: Alan Cox <alan@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 include/linux/tty.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/include/linux/tty.h b/include/linux/tty.h
index 483df15..ef1e012 100644
--- a/include/linux/tty.h
+++ b/include/linux/tty.h
@@ -587,7 +587,7 @@ extern int pcxe_open(struct tty_struct *tty, struct file *filp);
 extern int vt_ioctl(struct tty_struct *tty,
 		    unsigned int cmd, unsigned long arg);
 
-extern long vt_compat_ioctl(struct tty_struct *tty, struct file * file,
+extern long vt_compat_ioctl(struct tty_struct *tty,
 		     unsigned int cmd, unsigned long arg);
 
 /* tty_mutex.c */
-- 
1.7.4.1


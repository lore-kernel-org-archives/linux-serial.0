From: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 68/76] pcmcia: synclink_cs: fix prototype for mgslpc_ioctl()
Date: Wed, 16 Mar 2011 14:12:38 -0700
Message-ID: <1300309966-5745-68-git-send-email-gregkh@suse.de>
References: <20110316205746.GA2938@kroah.com>
 <1300309966-5745-1-git-send-email-gregkh@suse.de>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from kroah.org ([198.145.64.141]:32990 "EHLO coco.kroah.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754904Ab1CPVPd (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 16 Mar 2011 17:15:33 -0400
In-Reply-To: <1300309966-5745-1-git-send-email-gregkh@suse.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Axel Lin <axel.lin@gmail.com>, Alan Cox <alan@linux.intel.com>, Greg Kroah-Hartman <gregkh@suse.de>

From: Axel Lin <axel.lin@gmail.com>

The ioctl file pointer was removed in commit 6caa76
"tty: now phase out the ioctl file pointer for good".

Thus fix the prototype for mgslpc_ioctl() and eliminate below warning:
  CC [M]  drivers/char/pcmcia/synclink_cs.o
drivers/char/pcmcia/synclink_cs.c:2787: warning: initialization from incompatible pointer type

Signed-off-by: Axel Lin <axel.lin@gmail.com>
Cc: Alan Cox <alan@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/char/pcmcia/synclink_cs.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/drivers/char/pcmcia/synclink_cs.c b/drivers/char/pcmcia/synclink_cs.c
index 02127ca..beca80b 100644
--- a/drivers/char/pcmcia/synclink_cs.c
+++ b/drivers/char/pcmcia/synclink_cs.c
@@ -2222,13 +2222,12 @@ static int mgslpc_get_icount(struct tty_struct *tty,
  * Arguments:
  *
  * 	tty	pointer to tty instance data
- * 	file	pointer to associated file object for device
  * 	cmd	IOCTL command code
  * 	arg	command argument/context
  *
  * Return Value:	0 if success, otherwise error code
  */
-static int mgslpc_ioctl(struct tty_struct *tty, struct file * file,
+static int mgslpc_ioctl(struct tty_struct *tty,
 			unsigned int cmd, unsigned long arg)
 {
 	MGSLPC_INFO * info = (MGSLPC_INFO *)tty->driver_data;
-- 
1.7.4.1


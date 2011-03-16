From: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 43/76] tty: simserial: now phase out the ioctl file pointer for good
Date: Wed, 16 Mar 2011 14:12:13 -0700
Message-ID: <1300309966-5745-43-git-send-email-gregkh@suse.de>
References: <20110316205746.GA2938@kroah.com>
 <1300309966-5745-1-git-send-email-gregkh@suse.de>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from kroah.org ([198.145.64.141]:32953 "EHLO coco.kroah.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754381Ab1CPVOU (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 16 Mar 2011 17:14:20 -0400
In-Reply-To: <1300309966-5745-1-git-send-email-gregkh@suse.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: "Luck, Tony" <tony.luck@intel.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Greg Kroah-Hartman <gregkh@suse.de>

From: Luck, Tony <tony.luck@intel.com>

Alan missed the ia64 simulator serial driver (because it was hidden
in arch/... rather than located under drivers/... where one might
expect to find a driver).  Drop the "file *" argument from rs_ioctl()
in arch/ia64/hp/sim/simserial.c

Signed-off-by: Tony Luck <tony.luck@intel.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 arch/ia64/hp/sim/simserial.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/arch/ia64/hp/sim/simserial.c b/arch/ia64/hp/sim/simserial.c
index 13633da..bff0824 100644
--- a/arch/ia64/hp/sim/simserial.c
+++ b/arch/ia64/hp/sim/simserial.c
@@ -390,8 +390,7 @@ static void rs_unthrottle(struct tty_struct * tty)
 }
 
 
-static int rs_ioctl(struct tty_struct *tty, struct file * file,
-		    unsigned int cmd, unsigned long arg)
+static int rs_ioctl(struct tty_struct *tty, unsigned int cmd, unsigned long arg)
 {
 	if ((cmd != TIOCGSERIAL) && (cmd != TIOCSSERIAL) &&
 	    (cmd != TIOCSERCONFIG) && (cmd != TIOCSERGSTRUCT) &&
-- 
1.7.4.1


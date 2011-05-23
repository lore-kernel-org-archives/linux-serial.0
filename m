From: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 36/48] parport: Use request_muxed_region for IT87 probe and lock
Date: Mon, 23 May 2011 12:10:42 -0700
Message-ID: <1306177854-18172-36-git-send-email-gregkh@suse.de>
References: <20110523190539.GA17519@kroah.com>
 <1306177854-18172-1-git-send-email-gregkh@suse.de>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:47354 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932658Ab1EWTLw (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Mon, 23 May 2011 15:11:52 -0400
In-Reply-To: <1306177854-18172-1-git-send-email-gregkh@suse.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Alan Cox <alan@linux.intel.com>, Greg Kroah-Hartman <gregkh@suse.de>

From: Alan Cox <alan@linux.intel.com>

This is needed as part of making the various IT87 drivers actually co-exist
politely with each other, and with other superio devices that may be muxed
on 0x2E/0x2F.

It can be applied before or after the other patches by Nat Gurumoorthy without
problem.

Signed-off-by: Alan Cox <alan@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/parport/parport_pc.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/parport/parport_pc.c b/drivers/parport/parport_pc.c
index a3755ff..d3c0665 100644
--- a/drivers/parport/parport_pc.c
+++ b/drivers/parport/parport_pc.c
@@ -1621,7 +1621,7 @@ static void __devinit detect_and_report_it87(void)
 	u8 origval, r;
 	if (verbose_probing)
 		printk(KERN_DEBUG "IT8705 Super-IO detection, now testing port 2E ...\n");
-	if (!request_region(0x2e, 2, __func__))
+	if (!request_muxed_region(0x2e, 2, __func__))
 		return;
 	origval = inb(0x2e);		/* Save original value */
 	outb(0x87, 0x2e);
-- 
1.7.4.2


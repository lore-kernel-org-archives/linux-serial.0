From: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 62/76] tty: forgot to remove ipwireless from drivers/char/pcmcia/Makefile
Date: Wed, 16 Mar 2011 14:12:32 -0700
Message-ID: <1300309966-5745-62-git-send-email-gregkh@suse.de>
References: <20110316205746.GA2938@kroah.com>
 <1300309966-5745-1-git-send-email-gregkh@suse.de>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from kroah.org ([198.145.64.141]:33056 "EHLO coco.kroah.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754126Ab1CPVPH (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 16 Mar 2011 17:15:07 -0400
In-Reply-To: <1300309966-5745-1-git-send-email-gregkh@suse.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@suse.de>

This caused a build error.  Many thanks to Stephen Rothwell for pointing
this mistake out.

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/char/pcmcia/Makefile |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/drivers/char/pcmcia/Makefile b/drivers/char/pcmcia/Makefile
index be8f287..0aae209 100644
--- a/drivers/char/pcmcia/Makefile
+++ b/drivers/char/pcmcia/Makefile
@@ -4,8 +4,6 @@
 # Makefile for the Linux PCMCIA char device drivers.
 #
 
-obj-y += ipwireless/
-
 obj-$(CONFIG_SYNCLINK_CS) += synclink_cs.o
 obj-$(CONFIG_CARDMAN_4000) += cm4000_cs.o
 obj-$(CONFIG_CARDMAN_4040) += cm4040_cs.o
-- 
1.7.4.1


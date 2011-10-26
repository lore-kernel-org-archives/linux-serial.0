From: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 36/79] n_gsm: update TODO list
Date: Wed, 26 Oct 2011 14:12:41 +0200
Message-ID: <1319631204-23262-36-git-send-email-gregkh@suse.de>
References: <20111026114236.GA22180@kroah.com>
 <1319631204-23262-1-git-send-email-gregkh@suse.de>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:61000 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932875Ab1JZMNo (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 26 Oct 2011 08:13:44 -0400
In-Reply-To: <1319631204-23262-1-git-send-email-gregkh@suse.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Alan Cox <alan@linux.intel.com>, Greg Kroah-Hartman <gregkh@suse.de>

From: Alan Cox <alan@linux.intel.com>

This is now out of date so fix it

Signed-off-by: Alan Cox <alan@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/tty/n_gsm.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index 8a50e4e..ed42908 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -21,7 +21,6 @@
  *	Mostly done:	ioctls for setting modes/timing
  *	Partly done:	hooks so you can pull off frames to non tty devs
  *	Restart DLCI 0 when it closes ?
- *	Test basic encoding
  *	Improve the tx engine
  *	Resolve tx side locking by adding a queue_head and routing
  *		all control traffic via it
-- 
1.7.7


From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH 1/2] n_gsm: update TODO list
Date: Fri, 26 Aug 2011 11:27:35 +0100
Message-ID: <20110826102731.17092.52217.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:60893 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750917Ab1HZLUz (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 26 Aug 2011 07:20:55 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: greg@kroah.com, linux-serial@vger.kernel.org

From: Alan Cox <alan@linux.intel.com>

This is now out of date so fix it

Signed-off-by: Alan Cox <alan@linux.intel.com>
---

 drivers/tty/n_gsm.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index 695351c..8f03ea7 100644
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


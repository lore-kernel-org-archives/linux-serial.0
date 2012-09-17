From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] ipwireless: check ppp register worked
Date: Mon, 17 Sep 2012 12:01:40 +0100
Message-ID: <20120917110136.30441.77491.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:32940 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754596Ab2IQKnM (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 17 Sep 2012 06:43:12 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: greg@kroah.com, linux-serial@vger.kernel.org

From: Alan Cox <alan@linux.intel.com>

Otherwise we start trying to use a bogus channel - ungood.

Signed-off-by: Alan Cox <alan@linux.intel.com>
---

 drivers/tty/ipwireless/network.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/ipwireless/network.c b/drivers/tty/ipwireless/network.c
index 90ea902..57102e6 100644
--- a/drivers/tty/ipwireless/network.c
+++ b/drivers/tty/ipwireless/network.c
@@ -274,7 +274,12 @@ static void do_go_online(struct work_struct *work_go_online)
 		network->xaccm[0] = ~0U;
 		network->xaccm[3] = 0x60000000U;
 		network->raccm = ~0U;
-		ppp_register_channel(channel);
+		if (ppp_register_channel(channel) < 0) {
+			printk(KERN_ERR IPWIRELESS_PCCARD_NAME
+					": unable to register PPP channel\n");
+			kfree(channel);
+			return;
+		}
 		spin_lock_irqsave(&network->lock, flags);
 		network->ppp_channel = channel;
 	}


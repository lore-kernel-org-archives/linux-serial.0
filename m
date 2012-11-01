From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH 1/2] moxa: dcd handling of CLOCAL is backwards
Date: Thu, 01 Nov 2012 16:43:49 +0000
Message-ID: <20121101164336.31727.23069.stgit@bob.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:34908 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932447Ab2KAQlz (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 1 Nov 2012 12:41:55 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: greg@kroah.com, linux-serial@vger.kernel.org

From: Alan Cox <alan@linux.intel.com>

We should do hangup on dcd loss if CLOCAL is false not true.

Signed-off-by: Alan Cox <alan@linux.intel.com>
Resolves-bug: https://bugzilla.kernel.org/show_bug.cgi?id=49911
---

 drivers/tty/moxa.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)


diff --git a/drivers/tty/moxa.c b/drivers/tty/moxa.c
index 56e616b..9b57aae 100644
--- a/drivers/tty/moxa.c
+++ b/drivers/tty/moxa.c
@@ -1370,7 +1370,7 @@ static void moxa_new_dcdstate(struct moxa_port *p, u8 dcd)
         	p->DCDState = dcd;
         	spin_unlock_irqrestore(&p->port.lock, flags);
 		tty = tty_port_tty_get(&p->port);
-		if (tty && C_CLOCAL(tty) && !dcd)
+		if (tty && !C_CLOCAL(tty) && !dcd)
 			tty_hangup(tty);
 		tty_kref_put(tty);
 	}


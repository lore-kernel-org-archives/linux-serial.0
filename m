From: Alan Cox <alan@linux.intel.com>
Subject: [PATCH] nozomi: quick fix for the close/close bug
Date: Mon, 04 Jan 2010 16:26:50 +0000
Message-ID: <20100104162650.17194.17161.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:54918 "EHLO
	bob.linux.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753139Ab0ADQuC (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 4 Jan 2010 11:50:02 -0500
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: greg@kroah.com, linux-serial@vger.kernel.org

Nozomi goes wrong if you get the sequence

	open
	open
	close

	[stuff]
	close

which turns out to occur on some ppp type setups.

This is a quick patch up for the problem. It's not really fixing Nozomi
which completely fails to implement tty open/close semantics and all the
other needed stuff. Doing it right is a rather more invasive patch set and
not one that will backport.



Signed-off-by: Alan Cox <alan@linux.intel.com>
---

 drivers/char/nozomi.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)


diff --git a/drivers/char/nozomi.c b/drivers/char/nozomi.c
index 7d73cd4..2ad7d37 100644
--- a/drivers/char/nozomi.c
+++ b/drivers/char/nozomi.c
@@ -1651,10 +1651,10 @@ static void ntty_close(struct tty_struct *tty, struct file *file)
 
 	dc->open_ttys--;
 	port->count--;
-	tty_port_tty_set(port, NULL);
 
 	if (port->count == 0) {
 		DBG1("close: %d", nport->token_dl);
+		tty_port_tty_set(port, NULL);
 		spin_lock_irqsave(&dc->spin_mutex, flags);
 		dc->last_ier &= ~(nport->token_dl);
 		writew(dc->last_ier, dc->reg_ier);


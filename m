From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] stallion: Remove unneeded lock_kernel
Date: Tue, 3 Jul 2007 15:22:01 +0100
Message-ID: <20070703152201.5a8dc86d@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:57137 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757471AbXGCOQW (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 3 Jul 2007 10:16:22 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: akpm@osdl.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --exclude-from /usr/src/exclude --recursive linux.vanilla-2.6.22-rc6-mm1/drivers/char/stallion.c linux-2.6.22-rc6-mm1/drivers/char/stallion.c
--- linux.vanilla-2.6.22-rc6-mm1/drivers/char/stallion.c	2007-07-02 20:50:11.000000000 +0100
+++ linux-2.6.22-rc6-mm1/drivers/char/stallion.c	2007-07-02 21:06:25.000000000 +0100
@@ -1788,7 +1788,6 @@
 	if (tty == NULL)
 		return;
 
-	lock_kernel();
 	if (test_bit(ASYI_TXLOW, &portp->istate))
 		tty_wakeup(tty);
 
@@ -1802,7 +1801,6 @@
 			if (portp->flags & ASYNC_CHECK_CD)
 				tty_hangup(tty);	/* FIXME: module removal race here - AKPM */
 	}
-	unlock_kernel();
 }
 
 /*****************************************************************************/

From: Dale Farnsworth <dale@farnsworth.org>
Subject: [PATCH] serial: mpsc: release port lock on call to
	tty_flip_buffer_push
Date: Mon, 21 Jul 2008 17:03:31 -0700
Message-ID: <20080722000331.GA9886@farnsworth.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from xyzzy.farnsworth.org ([65.39.95.219]:44727 "EHLO
	xyzzy.farnsworth.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753580AbYGVAcO (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 21 Jul 2008 20:32:14 -0400
Received: from dale by xyzzy.farnsworth.org with local (Exim 4.69)
	(envelope-from <dale@farnsworth.org>)
	id 1KL5Ln-0002Zj-Tu
	for linux-serial@vger.kernel.org; Mon, 21 Jul 2008 17:03:36 -0700
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

We need to release the port lock when we call tty_flip_buffer_push()
to avoid a deadlock when the serial-core routines try to acquire
the same lock.  This deadlock has been observed on CONFIG_PREEMPT_RT
configurations.

Signed-off-by: Dale Farnsworth <dale@farnsworth.org>
Cc: <mgreer@mvista.com>
---
 drivers/serial/mpsc.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/serial/mpsc.c b/drivers/serial/mpsc.c
index c9f53e7..158d748 100644
--- a/drivers/serial/mpsc.c
+++ b/drivers/serial/mpsc.c
@@ -1065,7 +1065,9 @@ next_frame:
 	if ((readl(pi->sdma_base + SDMA_SDCM) & SDMA_SDCM_ERD) == 0)
 		mpsc_start_rx(pi);
 
+	spin_unlock(&pi->port.lock);
 	tty_flip_buffer_push(tty);
+	spin_lock(&pi->port.lock);
 	return rc;
 }
 
-- 
1.5.6


From: Tobias Klauser <tklauser@nuerscht.ch>
Subject: [PATCH] serial/icom: Remove custom msescs_to_jiffies() macro
Date: Mon, 28 Mar 2005 19:23:47 +0200
Message-ID: <20050328171945.GA3568@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from server3.hostpoint.ch ([217.26.52.13]:52237 "EHLO
	server3.hostpoint.ch") by vger.kernel.org with ESMTP
	id S261958AbVC1RXw (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Mon, 28 Mar 2005 12:23:52 -0500
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: kernel-janitors@lists.osdl.org
Cc: linux-serial@vger.kernel.org

Remove the MSECS_TO_JIFFIES() macro because msescs_to_jiffies() from
jiffies.h should be used. The macro isn't referenced anywhere anyway.

Signed-off-by: Tobias Klauser <tklauser@nuerscht.ch>

diff -urpN linux-2.6.11.orig/drivers/serial/icom.h linux-2.6.11/drivers/serial/icom.h
--- linux-2.6.11.orig/drivers/serial/icom.h	2005-03-02 12:50:31.000000000 +0100
+++ linux-2.6.11/drivers/serial/icom.h	2005-03-23 13:52:24.485557392 +0100
@@ -286,5 +286,3 @@ struct lookup_int_table {
 	u32	__iomem *global_int_mask;
 	unsigned long	processor_id;
 };
-
-#define MSECS_TO_JIFFIES(ms) (((ms)*HZ+999)/1000)

From: KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>
Subject: [PATCH] serial/8250: fix uninitialized warnings
Date: Wed, 5 Nov 2008 02:26:00 +0900 (JST)
Message-ID: <20081105022353.7CB0.KOSAKI.MOTOHIRO@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-2022-JP"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:50670 "EHLO
	fgwmail7.fujitsu.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754604AbYKDR0F (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 4 Nov 2008 12:26:05 -0500
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Cc: kosaki.motohiro@jp.fujitsu.com


fix following warnings.

drivers/serial/8250.c: In function ‘serial8250_shutdown’:
drivers/serial/8250.c:1612: warnings: ‘i’ may be used uninitialized in this function


Signed-off-by: KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>
CC: linux-serial@vger.kernel.org
---
 drivers/serial/8250.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: b/drivers/serial/8250.c
===================================================================
--- a/drivers/serial/8250.c	2008-11-05 01:10:11.000000000 +0900
+++ b/drivers/serial/8250.c	2008-11-05 01:38:39.000000000 +0900
@@ -1609,7 +1609,7 @@ static int serial_link_irq_chain(struct 
 
 static void serial_unlink_irq_chain(struct uart_8250_port *up)
 {
-	struct irq_info *i;
+	struct irq_info *i = NULL;
 	struct hlist_node *n;
 	struct hlist_head *h;
 



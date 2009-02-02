From: Wenji Huang <wenji.huang@oracle.com>
Subject: [PATCH] Fix the warning of uninitialized value in driver/serial/8250.c
Date: Mon, 02 Feb 2009 17:10:06 +0800
Message-ID: <4986B86E.3030604@oracle.com>
Reply-To: wenji.huang@oracle.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from acsinet12.oracle.com ([141.146.126.234]:54002 "EHLO
	acsinet12.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751219AbZBBJNy (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 2 Feb 2009 04:13:54 -0500
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: lkml <linux-kernel@vger.kernel.org>

This patch is to remove the the warning of uninitialized i in 
driver/serial/8250.c

Signed-off-by: Wenji Huang <wenji.huang@oracle.com>

diff -Nurh drivers/serial/8250.c.Orig drivers/serial/8250.c
--- drivers/serial/8250.c.Orig  2009-02-02 14:02:47.000000000 -0500
+++ drivers/serial/8250.c       2009-02-02 14:03:30.000000000 -0500
@@ -1678,7 +1678,7 @@

  static void serial_unlink_irq_chain(struct uart_8250_port *up)
  {
-       struct irq_info *i;
+       struct irq_info *i = NULL;
         struct hlist_node *n;
         struct hlist_head *h;



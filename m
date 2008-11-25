From: Sheng Yang <sheng@linux.intel.com>
Subject: [PATCH] 8250: Eliminate compile warning of 8250.c
Date: Tue, 25 Nov 2008 11:58:23 +0800
Message-ID: <1227585503-3833-1-git-send-email-sheng@linux.intel.com>
References: <1227585320-3711-1-git-send-email-sheng@linux.intel.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:23685 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751964AbYKYECM (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Mon, 24 Nov 2008 23:02:12 -0500
In-Reply-To: <1227585320-3711-1-git-send-email-sheng@linux.intel.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-serial@vger.kernel.org, Sheng Yang <sheng@linux.intel.com>

(Something wrong with encoding of the first mail...)

The patch based on linux-2.6 upstream and elimiate this compile warning
info:

drivers/serial/8250.c: In function 'serial8250_shutdown':
drivers/serial/8250.c:1612: warning: 'i' may be used uninitialized in this
function

Signed-off-by: Sheng Yang <sheng@linux.intel.com>
---
 drivers/serial/8250.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/serial/8250.c b/drivers/serial/8250.c
index 303272a..c78eee6 100644
--- a/drivers/serial/8250.c
+++ b/drivers/serial/8250.c
@@ -1609,7 +1609,7 @@ static int serial_link_irq_chain(struct uart_8250_port *up)
 
 static void serial_unlink_irq_chain(struct uart_8250_port *up)
 {
-	struct irq_info *i;
+	struct irq_info *i = NULL;
 	struct hlist_node *n;
 	struct hlist_head *h;
 
-- 
1.5.4.5


From: Chunhe Lan <Chunhe.Lan@freescale.com>
Subject: [PATCH] serial: 8250: Fix a compiler warning
Date: Wed, 12 Nov 2014 17:49:01 +0800
Message-ID: <1415785741-13009-1-git-send-email-Chunhe.Lan@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-bn1bn0108.outbound.protection.outlook.com ([157.56.110.108]:61569
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752076AbaKLJne (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 12 Nov 2014 04:43:34 -0500
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Chunhe Lan <Chunhe.Lan@freescale.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Spotted by a compile warning:

drivers/tty/serial/8250/8250_core.c: In function
  'serial8250_shutdown':
drivers/tty/serial/8250/8250_core.c:1747:18: warning:
  'i' may be used uninitialized in this function [-Wuninitialized]
drivers/tty/serial/8250/8250_core.c:1725:19: note:
  'i' was declared here

Just because it annoys user.

Signed-off-by: Chunhe Lan <Chunhe.Lan@freescale.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/serial/8250/8250_core.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
index 312a83f..894a357 100644
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -1722,7 +1722,7 @@ static int serial_link_irq_chain(struct uart_8250_port *up)
 
 static void serial_unlink_irq_chain(struct uart_8250_port *up)
 {
-	struct irq_info *i;
+	struct irq_info *i = NULL;
 	struct hlist_node *n;
 	struct hlist_head *h;
 
-- 
1.7.6.5


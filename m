From: Yoshihiro YUNOMAE <yoshihiro.yunomae.ez@hitachi.com>
Subject: [PATCH] serial/core: Fix too big allocation for attribute member
Date: Wed, 23 Jul 2014 06:06:22 +0000
Message-ID: <20140723060622.2647.96316.stgit@yuno-kbuild.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail9.hitachi.co.jp ([133.145.228.44]:40052 "EHLO
	mail9.hitachi.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751381AbaGWGG0 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 23 Jul 2014 02:06:26 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Dan Carpenter <dan.carpenter@oracle.com>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, yrl.pp-manager.tt@hitachi.com

Current code allocates too much data for tty_groups member of uart_port struct,
so fix it.

Signed-off-by: Yoshihiro YUNOMAE <yoshihiro.yunomae.ez@hitachi.com>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/tty/serial/serial_core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 4af764c..8ded213 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -2617,7 +2617,7 @@ int uart_add_one_port(struct uart_driver *drv, struct uart_port *uport)
 	if (uport->attr_group)
 		num_groups++;
 
-	uport->tty_groups = kcalloc(num_groups, sizeof(**uport->tty_groups),
+	uport->tty_groups = kcalloc(num_groups, sizeof(*uport->tty_groups),
 				    GFP_KERNEL);
 	if (!uport->tty_groups) {
 		ret = -ENOMEM;


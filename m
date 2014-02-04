From: Jingoo Han <jg1.han@samsung.com>
Subject: [PATCH 1/2] serial: sh-sci: Fix cast warning
Date: Tue, 04 Feb 2014 15:55:41 +0900
Message-ID: <000501cf2176$1e733d00$5b59b700$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:19478 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752778AbaBDGzo (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 4 Feb 2014 01:55:44 -0500
Received: from epcpsbgr5.samsung.com
 (u145.gpu120.samsung.co.kr [203.254.230.145])
 by mailout3.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0N0G00GJOLWUBU00@mailout3.samsung.com> for
 linux-serial@vger.kernel.org; Tue, 04 Feb 2014 15:55:42 +0900 (KST)
Content-language: ko
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: 'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org, 'Laurent Pinchart' <laurent.pinchart+renesas@ideasonboard.com>, 'Simon Horman' <horms+renesas@verge.net.au>, 'Jingoo Han' <jg1.han@samsung.com>

Fix the following compile warning about cast to pointer from
integer of different size.

drivers/tty/serial/sh-sci.c:2021:19: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/tty/serial/sh-sci.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index be33d2b..61729d4 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -2018,7 +2018,7 @@ static int sci_remap_port(struct uart_port *port)
 		 * need to do any remapping, just cast the cookie
 		 * directly.
 		 */
-		port->membase = (void __iomem *)port->mapbase;
+		port->membase = (void __iomem *)(unsigned long)port->mapbase;
 	}
 
 	return 0;
-- 
1.7.10.4



From: Jingoo Han <jg1.han@samsung.com>
Subject: [PATCH 07/10] serial: msm_serial: fix comparison of different types
Date: Thu, 08 Aug 2013 17:38:20 +0900
Message-ID: <006201ce9412$a2f3c550$e8db4ff0$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:39346 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756787Ab3HHIiW (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 8 Aug 2013 04:38:22 -0400
Received: from epcpsbgr4.samsung.com
 (u144.gpu120.samsung.co.kr [203.254.230.144])
 by mailout4.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MR700D5GENOKEH0@mailout4.samsung.com> for
 linux-serial@vger.kernel.org; Thu, 08 Aug 2013 17:38:20 +0900 (KST)
Content-language: ko
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: 'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>
Cc: 'Jiri Slaby' <jslaby@suse.cz>, linux-serial@vger.kernel.org, 'David Brown' <davidb@codeaurora.org>, 'Daniel Walker' <dwalker@fifo99.com>, 'Bryan Huntsman' <bryanh@codeaurora.org>, Jingoo Han <jg1.han@samsung.com>

Fix the following sparse warning:

drivers/tty/serial/msm_serial.c:237:37: error: incompatible types in comparison expression (different type sizes)

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/tty/serial/msm_serial.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/msm_serial.c b/drivers/tty/serial/msm_serial.c
index 252d514..8f58540 100644
--- a/drivers/tty/serial/msm_serial.c
+++ b/drivers/tty/serial/msm_serial.c
@@ -234,7 +234,8 @@ static void handle_tx(struct uart_port *port)
 			break;
 
 		if (msm_port->is_uartdm)
-			num_chars = min(tx_count - tf_pointer, sizeof(buf));
+			num_chars = min(tx_count - tf_pointer,
+					(unsigned int)sizeof(buf));
 		else
 			num_chars = 1;
 
-- 
1.7.10.4



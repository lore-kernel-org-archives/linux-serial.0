From: Alexander Stein <alexander.stein@systec-electronic.com>
Subject: [PATCH resend] pch_uart: add missing comment about OKI ML7223
Date: Mon,  4 Jul 2011 15:35:51 +0200
Message-ID: <1309786551-5879-1-git-send-email-alexander.stein@systec-electronic.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from 61-96-236-77.server-home.net ([77.236.96.61]:49173 "EHLO
	webbox1416.server-home.net" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1751118Ab1GDNfy (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 4 Jul 2011 09:35:54 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Cox <alan@linux.intel.com>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, trivial@kernel.org, Alexander Stein <alexander.stein@systec-electronic.com>

Signed-off-by: Alexander Stein <alexander.stein@systec-electronic.com>
Reviewed-by: Jesper Juhl <jj@chaosbits.net>
---
 drivers/tty/serial/pch_uart.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/tty/serial/pch_uart.c b/drivers/tty/serial/pch_uart.c
index d3ba85b..91da2a9 100644
--- a/drivers/tty/serial/pch_uart.c
+++ b/drivers/tty/serial/pch_uart.c
@@ -44,6 +44,7 @@ enum {
 /* Set the max number of UART port
  * Intel EG20T PCH: 4 port
  * OKI SEMICONDUCTOR ML7213 IOH: 3 port
+ * OKI SEMICONDUCTOR ML7223 IOH: 2 port
 */
 #define PCH_UART_NR	4
 
-- 
1.7.3.4


From: Jingoo Han <jg1.han@samsung.com>
Subject: [PATCH 2/2] serial: pch_uart: Fix build warning when CONFIG_DEBUG_FS=n
Date: Tue, 04 Feb 2014 15:58:09 +0900
Message-ID: <000601cf2176$766f7ff0$634e7fd0$%han@samsung.com>
References: <000501cf2176$1e733d00$5b59b700$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:26506 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751767AbaBDG6S (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 4 Feb 2014 01:58:18 -0500
Received: from epcpsbgr4.samsung.com
 (u144.gpu120.samsung.co.kr [203.254.230.144])
 by mailout2.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0N0G00CHEM0XDLD0@mailout2.samsung.com> for
 linux-serial@vger.kernel.org; Tue, 04 Feb 2014 15:58:09 +0900 (KST)
In-reply-to: <000501cf2176$1e733d00$5b59b700$%han@samsung.com>
Content-language: ko
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: 'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org, 'Johan Hovold' <jhovold@gmail.com>, 'Darren Hart' <dvhart@linux.intel.com>, 'Jingoo Han' <jg1.han@samsung.com>

Add CONFIG_DEBUG_FS to 'char name' in order to fix the following
build warning, because 'char name' is used only when CONFIG_DEBUG_FS
is enabled.

drivers/tty/serial/pch_uart.c:1765:7: warning: unused variable 'name' [-Wunused-variable]

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/tty/serial/pch_uart.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/tty/serial/pch_uart.c b/drivers/tty/serial/pch_uart.c
index 8fa1134..0931b3f 100644
--- a/drivers/tty/serial/pch_uart.c
+++ b/drivers/tty/serial/pch_uart.c
@@ -1762,7 +1762,9 @@ static struct eg20t_port *pch_uart_init_port(struct pci_dev *pdev,
 	int fifosize;
 	int port_type;
 	struct pch_uart_driver_data *board;
+#ifdef CONFIG_DEBUG_FS
 	char name[32];	/* for debugfs file name */
+#endif
 
 	board = &drv_dat[id->driver_data];
 	port_type = board->port_type;
-- 
1.7.10.4



From: Jingoo Han <jg1.han@samsung.com>
Subject: [PATCH] serial: ifx6x60: add missing variable initialization
Date: Wed, 27 Feb 2013 14:03:16 +0900
Message-ID: <008e01ce14a7$c1406580$43c13080$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:46520 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751190Ab3B0FDT (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 27 Feb 2013 00:03:19 -0500
Received: from epcpsbgr2.samsung.com
 (u142.gpu120.samsung.co.kr [203.254.230.142])
 by mailout1.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MIV00EPQ4OEOJ80@mailout1.samsung.com> for
 linux-serial@vger.kernel.org; Wed, 27 Feb 2013 14:03:17 +0900 (KST)
Content-language: ko
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: 'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>
Cc: 'Jiri Slaby' <jslaby@suse.cz>, linux-serial@vger.kernel.org, 'Chen Jun' <jun.d.chen@intel.com>, 'Jingoo Han' <jg1.han@samsung.com>

Fixed build warning as below:

drivers/tty/serial/ifx6x60.c:753:8: warning: 'more' may be used uninitialized in this function [-Wuninitialized]

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/tty/serial/ifx6x60.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/tty/serial/ifx6x60.c b/drivers/tty/serial/ifx6x60.c
index 68d7ce9..3d78baf 100644
--- a/drivers/tty/serial/ifx6x60.c
+++ b/drivers/tty/serial/ifx6x60.c
@@ -687,7 +687,7 @@ static void ifx_spi_complete(void *ctx)
 	struct tty_ldisc *ldisc = NULL;
 	int length;
 	int actual_length;
-	unsigned char more;
+	unsigned char more = 0;
 	unsigned char cts;
 	int local_write_pending = 0;
 	int queue_length;
-- 
1.7.2.5



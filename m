From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH] serial: atmel: add missing dmaengine header
Date: Thu, 16 Oct 2014 13:09:57 +0530
Message-ID: <1413445197-22304-1-git-send-email-vinod.koul@intel.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:32375 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751829AbaJPIQL (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Thu, 16 Oct 2014 04:16:11 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>, Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org, dmaengine@vger.kernel.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Vinod Koul <vinod.koul@intel.com>

The atmel serial driver uses dmaengine APIs but never included the dmaengine
header as it was getting inculded thru one of driver headers.

commit 3d588f83e4d6a5230d9094b97d38621cbaa9a972 - "dmaengine: dw: split
dma-dw.h to platform and private parts" broke this as it moved headers
around.  Fix this by doing the right thing to include the dmaengine header

Reported-by: kbuild test robot <fengguang.wu@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
Greg, since this is path which broke this is sitting in my next, would it be
okay to carry this thru dmaengine tree as get it merged in current window.
Planning to send pull request in day or so to Linus

 drivers/tty/serial/atmel_serial.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
index d7d4584..edde3ec 100644
--- a/drivers/tty/serial/atmel_serial.c
+++ b/drivers/tty/serial/atmel_serial.c
@@ -37,6 +37,7 @@
 #include <linux/of_device.h>
 #include <linux/of_gpio.h>
 #include <linux/dma-mapping.h>
+#include <linux/dmaengine.h>
 #include <linux/atmel_pdc.h>
 #include <linux/atmel_serial.h>
 #include <linux/uaccess.h>
-- 
1.7.0.4


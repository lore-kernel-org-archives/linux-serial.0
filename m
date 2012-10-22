From: Jun Chen <jun.d.chen@intel.com>
Subject: [PATCH] serial: ifx6x60: add_timer is not safe in the mrdy_assert
 function
Date: Mon, 22 Oct 2012 10:23:07 -0400
Message-ID: <1350915787.4332.27.camel@chenjun-workstation>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:20994 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752784Ab2JVGUr (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Mon, 22 Oct 2012 02:20:47 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: alan@linux.intel.com
Cc: linux-serial@vger.kernel.org, russ.gorby@intel.com, chuansheng.liu@intel.com, chao.bi@intel.com


This patch make use of mod_timer instead of add_timer in the mrdy_assert function.
Because the srdy interrupter can go high when we are running function mrdy_assert and mrdy_assert
can be called by multi-entry. In our medfield platform, spi stress test can encounter this
error logs triggered by the BUG_ON of add_timer function.This patch had been tested on
our medfield platform.

the scenario:
      CPU0							CPU1
mrdy_assert
set_bit(IFX_SPI_STATE_TIMER_PENDING)
								ifx_spi_handle_srdy
								...
								clear_bit(IFX_SPI_STATE_TIMER_PENDING)
								...
								mrdy_assert
								set_bit(IFX_SPI_STATE_TIMER_PENDING)
								...
								add_timer
...
add_timer

cc:liu chuansheng <chuansheng.liu@intel.com>
cc:Bi Chao <chao.bi@intel.com>
Signed-off-by: Chen Jun <jun.d.chen@intel.com>
---
 drivers/tty/serial/ifx6x60.c |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/ifx6x60.c b/drivers/tty/serial/ifx6x60.c
index 769396a..e56ed33 100644
--- a/drivers/tty/serial/ifx6x60.c
+++ b/drivers/tty/serial/ifx6x60.c
@@ -190,9 +190,7 @@ static void mrdy_assert(struct ifx_spi_device *ifx_dev)
 	if (!val) {
 		if (!test_and_set_bit(IFX_SPI_STATE_TIMER_PENDING,
 				      &ifx_dev->flags)) {
-			ifx_dev->spi_timer.expires =
-				jiffies + IFX_SPI_TIMEOUT_SEC*HZ;
-			add_timer(&ifx_dev->spi_timer);
+			mod_timer(&ifx_dev->spi_timer,jiffies + IFX_SPI_TIMEOUT_SEC*HZ);
 
 		}
 	}
-- 
1.7.4.1




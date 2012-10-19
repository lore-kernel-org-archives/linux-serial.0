From: Jun Chen <jun.d.chen@intel.com>
Subject: [PATCH] serial: ifx6x60: del_timer_sync must not be called in
 interrupt context.
Date: Fri, 19 Oct 2012 09:51:30 -0400
Message-ID: <1350654690.4332.12.camel@chenjun-workstation>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:16020 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756876Ab2JSFtN (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Fri, 19 Oct 2012 01:49:13 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: alan@linux.intel.com
Cc: linux-serial@vger.kernel.org, russ.gorby@intel.com, chuansheng.liu@intel.com, chao.bi@intel.com


This patch make use of del_timer instead of del_timer_sync in the
interrupt context.
The spi_timer function don't use any resources that may release after
running del_timer,
so using the del_timer is also safe and enough in this context.

Signed-off-by: Chen Jun <jun.d.chen@intel.com>
---
 drivers/tty/serial/ifx6x60.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/tty/serial/ifx6x60.c b/drivers/tty/serial/ifx6x60.c
index 5b9bc19..769396a 100644
--- a/drivers/tty/serial/ifx6x60.c
+++ b/drivers/tty/serial/ifx6x60.c
@@ -826,7 +826,7 @@ error_ret:
 static void ifx_spi_handle_srdy(struct ifx_spi_device *ifx_dev)
 {
 	if (test_bit(IFX_SPI_STATE_TIMER_PENDING, &ifx_dev->flags)) {
-		del_timer_sync(&ifx_dev->spi_timer);
+		del_timer(&ifx_dev->spi_timer);
 		clear_bit(IFX_SPI_STATE_TIMER_PENDING, &ifx_dev->flags);
 	}
 
-- 
1.7.4.1




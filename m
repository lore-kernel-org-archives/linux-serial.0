From: channing <chao.bi@intel.com>
Subject: [PATCH] serial:ifx6x60:Delete SPI timer when shut down port
Date: Thu, 10 Jan 2013 13:06:42 +0800
Message-ID: <1357794402.8296.9.camel@bichao>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:11440 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758064Ab3AJEtL (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 9 Jan 2013 23:49:11 -0500
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: alan@linux.intel.com
Cc: greg@kroah.com, richardx.r.gorby@intel.com, jun.d.chen@intel.com, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org


When shut down SPI port, it's possible that MRDY has been asserted and a SPI
timer was activated waiting for SRDY assert, in the case, it needs to delete
this timer.

Signed-off-by: Chen Jun <jun.d.chen@intel.com>
Signed-off-by: channing <chao.bi@intel.com>
---
 drivers/tty/serial/ifx6x60.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/tty/serial/ifx6x60.c b/drivers/tty/serial/ifx6x60.c
index 675d94a..7eed323 100644
--- a/drivers/tty/serial/ifx6x60.c
+++ b/drivers/tty/serial/ifx6x60.c
@@ -637,6 +637,7 @@ static void ifx_port_shutdown(struct tty_port *port)
 
 	clear_bit(IFX_SPI_STATE_IO_AVAILABLE, &ifx_dev->flags);
 	mrdy_set_low(ifx_dev);
+	del_timer(&ifx_dev->spi_timer);
 	clear_bit(IFX_SPI_STATE_TIMER_PENDING, &ifx_dev->flags);
 	tasklet_kill(&ifx_dev->io_work_tasklet);
 }
-- 
1.7.1




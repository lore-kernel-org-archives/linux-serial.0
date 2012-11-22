From: chao bi <chao.bi@intel.com>
Subject: [PATCH] serial:ifx6x60:Delete SPI timer when shut down port
Date: Thu, 22 Nov 2012 16:43:07 +0800
Message-ID: <1353573787.22077.8.camel@bichao>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: alan@linux.intel.com
Cc: richardx.r.gorby@intel.com, jun.d.chen@intel.com, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org


When shut down SPI port, it's possible that MRDY has been asserted and a SPI
timer was activated waiting for SRDY assert, in the case, it needs to delete
this timer.

Signed-off-by: Chen Jun <jun.d.chen@intel.com>
Signed-off-by: channing <chao.bi@intel.com>
---
 drivers/tty/serial/ifx6x60.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/drivers/tty/serial/ifx6x60.c b/drivers/tty/serial/ifx6x60.c
index 5b9bc19..467020b 100644
--- a/drivers/tty/serial/ifx6x60.c
+++ b/drivers/tty/serial/ifx6x60.c
@@ -552,7 +552,10 @@ static void ifx_port_shutdown(struct tty_port *port)
 		container_of(port, struct ifx_spi_device, tty_port);
 
 	mrdy_set_low(ifx_dev);
-	clear_bit(IFX_SPI_STATE_TIMER_PENDING, &ifx_dev->flags);
+	if (test_and_clear_bit(IFX_SPI_STATE_TIMER_PENDING,
+		&ifx_dev->flags)) {
+		del_timer(&ifx_dev->spi_timer);
+	}
 	tasklet_kill(&ifx_dev->io_work_tasklet);
 }
 
-- 
1.7.1

From: Allen Pais <allen.lkml@gmail.com>
Subject: [PATCH 10/10] drivers: tty: ifx6x60: use setup_timer() helper.
Date: Fri, 22 Sep 2017 13:56:52 +0530
Message-ID: <1506068812-8496-11-git-send-email-allen.lkml@gmail.com>
References: <1506068812-8496-1-git-send-email-allen.lkml@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1506068812-8496-1-git-send-email-allen.lkml@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org, jslaby@suse.com, Allen Pais <allen.lkml@gmail.com>
List-Id: linux-serial@vger.kernel.org

        Use setup_timer function instead of initializing timer with the
        function and data fields.

Signed-off-by: Allen Pais <allen.lkml@gmail.com>
---
 drivers/tty/serial/ifx6x60.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/ifx6x60.c b/drivers/tty/serial/ifx6x60.c
index f190a84..596b738 100644
--- a/drivers/tty/serial/ifx6x60.c
+++ b/drivers/tty/serial/ifx6x60.c
@@ -1029,9 +1029,8 @@ static int ifx_spi_spi_probe(struct spi_device *spi)
 	spin_lock_init(&ifx_dev->write_lock);
 	spin_lock_init(&ifx_dev->power_lock);
 	ifx_dev->power_status = 0;
-	init_timer(&ifx_dev->spi_timer);
-	ifx_dev->spi_timer.function = ifx_spi_timeout;
-	ifx_dev->spi_timer.data = (unsigned long)ifx_dev;
+	setup_timer(&ifx_dev->spi_timer, ifx_spi_timeout,
+		    (unsigned long)ifx_dev);
 	ifx_dev->modem = pl_data->modem_type;
 	ifx_dev->use_dma = pl_data->use_dma;
 	ifx_dev->max_hz = pl_data->max_hz;
-- 
2.7.4

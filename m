From: Allen Pais <allen.lkml@gmail.com>
Subject: [PATCH 04/10] drivers: tty: max3100: use setup_timer() helper.
Date: Fri, 22 Sep 2017 13:56:46 +0530
Message-ID: <1506068812-8496-5-git-send-email-allen.lkml@gmail.com>
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
 drivers/tty/serial/max3100.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/max3100.c b/drivers/tty/serial/max3100.c
index ace8264..b6b3453 100644
--- a/drivers/tty/serial/max3100.c
+++ b/drivers/tty/serial/max3100.c
@@ -787,9 +787,8 @@ static int max3100_probe(struct spi_device *spi)
 		max3100s[i]->poll_time = 1;
 	max3100s[i]->max3100_hw_suspend = pdata->max3100_hw_suspend;
 	max3100s[i]->minor = i;
-	init_timer(&max3100s[i]->timer);
-	max3100s[i]->timer.function = max3100_timeout;
-	max3100s[i]->timer.data = (unsigned long) max3100s[i];
+	setup_timer(&max3100s[i]->timer, max3100_timeout,
+		    (unsigned long)max3100s[i]);
 
 	dev_dbg(&spi->dev, "%s: adding port %d\n", __func__, i);
 	max3100s[i]->port.irq = max3100s[i]->irq;
-- 
2.7.4

From: Allen Pais <allen.lkml@gmail.com>
Subject: [PATCH 03/10] drivers: tty: vcc: use setup_timer() helper.
Date: Fri, 22 Sep 2017 13:56:45 +0530
Message-ID: <1506068812-8496-4-git-send-email-allen.lkml@gmail.com>
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
 drivers/tty/vcc.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/tty/vcc.c b/drivers/tty/vcc.c
index ef01d24..954b190 100644
--- a/drivers/tty/vcc.c
+++ b/drivers/tty/vcc.c
@@ -645,13 +645,8 @@ static int vcc_probe(struct vio_dev *vdev, const struct vio_device_id *id)
 	if (rv)
 		goto free_domain;
 
-	init_timer(&port->rx_timer);
-	port->rx_timer.function = vcc_rx_timer;
-	port->rx_timer.data = port->index;
-
-	init_timer(&port->tx_timer);
-	port->tx_timer.function = vcc_tx_timer;
-	port->tx_timer.data = port->index;
+	setup_timer(&port->rx_timer, vcc_rx_timer, port->index);
+	setup_timer(&port->tx_timer, vcc_tx_timer, port->index);
 
 	dev_set_drvdata(&vdev->dev, port);
 
-- 
2.7.4

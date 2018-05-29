From: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Subject: [PATCH 14/19] mfd: rave-sp: MODULE_DEVICE_TABLE(serdev)
Date: Tue, 29 May 2018 15:10:09 +0200
Message-ID: <20180529131014.18641-15-ricardo.ribalda@gmail.com>
References: <20180529131014.18641-1-ricardo.ribalda@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180529131014.18641-1-ricardo.ribalda@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Cc: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>, Lee Jones <lee.jones@linaro.org>, Rob Herring <robh@kernel.org>, Johan Hovold <johan@kernel.org>
List-Id: linux-serial@vger.kernel.org

Export serdev table to the module header, allowing module autoload via
udev/modprobe.

Cc: Lee Jones <lee.jones@linaro.org>
Cc: Rob Herring <robh@kernel.org>
Cc: Johan Hovold <johan@kernel.org>
Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
---
 drivers/mfd/rave-sp.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/mfd/rave-sp.c b/drivers/mfd/rave-sp.c
index 5c858e784a89..807c237e061b 100644
--- a/drivers/mfd/rave-sp.c
+++ b/drivers/mfd/rave-sp.c
@@ -694,12 +694,19 @@ static int rave_sp_probe(struct serdev_device *serdev)
 
 MODULE_DEVICE_TABLE(of, rave_sp_dt_ids);
 
+static struct serdev_device_id rave_sp_serdev_id[] = {
+	{ "rave-sp", },
+	{},
+};
+MODULE_DEVICE_TABLE(serdev, rave_sp_serdev_id);
+
 static struct serdev_device_driver rave_sp_drv = {
 	.probe			= rave_sp_probe,
 	.driver = {
 		.name		= "rave-sp",
 		.of_match_table	= rave_sp_dt_ids,
 	},
+	.id_table = rave_sp_serdev_id,
 };
 module_serdev_device_driver(rave_sp_drv);
 
-- 
2.17.0

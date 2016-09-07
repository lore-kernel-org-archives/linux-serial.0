From: Liu Xiang <liuxiang_1999@126.com>
Subject: [PATCH] serial: max310x: Set IRQF_TRIGGER_FALLING flag when dev.of_node is not NULL
Date: Wed,  7 Sep 2016 22:05:01 +0800
Message-ID: <1473257101-3423-1-git-send-email-liuxiang_1999@126.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org, jslaby@suse.com, Liu Xiang <liuxiang_1999@126.com>, Liu Xiang <liu.xiang6@zte.com.cn>
List-Id: linux-serial@vger.kernel.org

When dev.of_node is not NULL, we also need to set IRQF_TRIGGER_FALLING
flag, otherwise it may cause uncertain interrupts.

Signed-off-by: Liu Xiang <liu.xiang6@zte.com.cn>
---
 drivers/tty/serial/max310x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
index 9360801..8a3e926 100644
--- a/drivers/tty/serial/max310x.c
+++ b/drivers/tty/serial/max310x.c
@@ -1329,9 +1329,9 @@ static int max310x_spi_probe(struct spi_device *spi)
 		const struct spi_device_id *id_entry = spi_get_device_id(spi);
 
 		devtype = (struct max310x_devtype *)id_entry->driver_data;
-		flags = IRQF_TRIGGER_FALLING;
 	}
 
+	flags = IRQF_TRIGGER_FALLING;
 	regcfg.max_register = devtype->nr * 0x20 - 1;
 	regmap = devm_regmap_init_spi(spi, &regcfg);
 
-- 
1.9.1

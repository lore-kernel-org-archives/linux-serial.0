From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH v5 09/11] platform: Accept const properties
Date: Fri,  2 Jun 2017 09:28:52 +0200
Message-ID: <aa4b987d4ede9f20fa71c49da65e8b429ddfb58c.1496388533.git.jan.kiszka@siemens.com>
References: <cover.1496388533.git.jan.kiszka@siemens.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1496388533.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1496388533.git.jan.kiszka@siemens.com>
References: <cover.1496388533.git.jan.kiszka@siemens.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-serial@vger.kernel.org, linux-gpio@vger.kernel.org, Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>, Andy Shevchenko <andy.shevchenko@gmail.com>, Sascha Weisenberger <sascha.weisenberger@siemens.com>
List-Id: linux-serial@vger.kernel.org

Aligns us with device_add_properties, the function we call.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 drivers/base/platform.c         | 2 +-
 include/linux/platform_device.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index a102152301c8..71ea6f4d33c2 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -344,7 +344,7 @@ EXPORT_SYMBOL_GPL(platform_device_add_data);
  * platform device is released.
  */
 int platform_device_add_properties(struct platform_device *pdev,
-				   struct property_entry *properties)
+				   const struct property_entry *properties)
 {
 	return device_add_properties(&pdev->dev, properties);
 }
diff --git a/include/linux/platform_device.h b/include/linux/platform_device.h
index 98c2a7c7108e..49f634d96118 100644
--- a/include/linux/platform_device.h
+++ b/include/linux/platform_device.h
@@ -172,7 +172,7 @@ extern int platform_device_add_resources(struct platform_device *pdev,
 extern int platform_device_add_data(struct platform_device *pdev,
 				    const void *data, size_t size);
 extern int platform_device_add_properties(struct platform_device *pdev,
-					  struct property_entry *properties);
+				const struct property_entry *properties);
 extern int platform_device_add(struct platform_device *pdev);
 extern void platform_device_del(struct platform_device *pdev);
 extern void platform_device_put(struct platform_device *pdev);
-- 
2.12.3

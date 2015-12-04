From: Wang Hongcheng <annie.wang@amd.com>
Subject: [PATCH 3/9] ACPI: add struct acpi_amba_quirk for AMD pl330 specific device config
Date: Fri, 4 Dec 2015 11:24:20 +0800
Message-ID: <1449199466-6081-4-git-send-email-annie.wang@amd.com>
References: <1449199466-6081-1-git-send-email-annie.wang@amd.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1449199466-6081-1-git-send-email-annie.wang@amd.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vinod Koul <vinod.koul@intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, dmaengine@vger.kernel.org, iommu@lists.linux-foundation.org, Borislav Petkov <bp@alien8.de>, Huang Rui <ray.huang@amd.com>, Wan Zongshun <vincent.wan@amd.com>, Ken Xue <ken.xue@amd.com>, Tony Li <tony.li@amd.com>, Wang Hongcheng <annie.wang@amd.com>
List-Id: linux-serial@vger.kernel.org

AMD pl330 is a UART DMA device, it shares one ACPI item with UART. So
a platform device and an acpi device will be created according to
AMD0020 ACPI dev. And its mem base address must have an offset. As a
result, MULTI_ATTACHED_QUIRK and MULTI_ATTACHED_QUIRK are used.

Signed-off-by: Wang Hongcheng <annie.wang@amd.com>
---
 drivers/acpi/acpi_amba.c | 31 +++++++++++++++++++++++----
 drivers/acpi/acpi_apd.c  | 56 +++++++++++++++++++++++++++++++++++++-----------
 include/linux/acpi.h     | 13 +++++++++--
 3 files changed, 81 insertions(+), 19 deletions(-)

diff --git a/drivers/acpi/acpi_amba.c b/drivers/acpi/acpi_amba.c
index 4f0366a..8a5269c 100644
--- a/drivers/acpi/acpi_amba.c
+++ b/drivers/acpi/acpi_amba.c
@@ -31,6 +31,8 @@ ACPI_MODULE_NAME("amba");
  * @periphid: AMBA device periphid.
  * @fixed_rate: Clock frequency.
  * @pdata: Platform data specific to the device.
+ * @quirk: Specific device config, including device multiattach.
+ * and mem base offset.
  *
  * Check if the given @adev can be represented as an AMBA device and, if
  * that's the case, create and register an AMBA device, populate its
@@ -42,7 +44,8 @@ ACPI_MODULE_NAME("amba");
 struct amba_device *acpi_create_amba_device(struct acpi_device *adev,
 					    unsigned int periphid,
 					    unsigned long fixed_rate,
-					    void *pdata)
+					    void *pdata,
+					    struct acpi_amba_quirk *quirk)
 {
 	struct amba_device *amba_dev = NULL;
 	struct device *parent;
@@ -54,12 +57,14 @@ struct amba_device *acpi_create_amba_device(struct acpi_device *adev,
 	unsigned int i;
 	unsigned int irq[AMBA_NR_IRQS];
 	struct clk *clk = ERR_PTR(-ENODEV);
+	char amba_devname[100];
 
 	/*
 	 * If the ACPI node already has a physical device attached,
-	 * skip it.
+	 * skip it. Except some special devices such as AMD0020 which
+	 * needs attach physical devices two times.
 	 */
-	if (adev->physical_node_count)
+	if (adev->physical_node_count && !(quirk->quirk & MULTI_ATTACHED_QUIRK))
 		return NULL;
 
 	INIT_LIST_HEAD(&resource_list);
@@ -85,7 +90,24 @@ struct amba_device *acpi_create_amba_device(struct acpi_device *adev,
 			memcpy(resource, rentry->res, sizeof(struct resource));
 	}
 
-	amba_dev = amba_device_alloc(dev_name(&adev->dev),
+	/*
+	 * The memory address of AMD pl330 has an offset of ACPI
+	 * mem resource.
+	 */
+	if (quirk->quirk & BASE_OFFSET_QUIRK)
+		resource->start += quirk->base_offset;
+
+	/*
+	 * If the ACPI device already has a node attached. It must be
+	 * renamed.
+	 */
+	if (quirk->quirk & MULTI_ATTACHED_QUIRK)
+		sprintf(amba_devname, "%s%s", dev_name(&adev->dev), "DMA");
+	else
+		memcpy(amba_devname, dev_name(&adev->dev),
+		       strlen(dev_name(&adev->dev)));
+
+	amba_dev = amba_device_alloc(amba_devname,
 				     resource->start,
 				     resource_size(resource));
 
@@ -136,6 +158,7 @@ struct amba_device *acpi_create_amba_device(struct acpi_device *adev,
 	if (ret)
 		goto amba_register_err;
 
+	amba_dev->dev.init_name = NULL;
 	ret = amba_device_add(amba_dev, resource);
 	if (ret)
 		goto amba_register_err;
diff --git a/drivers/acpi/acpi_apd.c b/drivers/acpi/acpi_apd.c
index a450e7a..eb3316a 100644
--- a/drivers/acpi/acpi_apd.c
+++ b/drivers/acpi/acpi_apd.c
@@ -3,7 +3,8 @@
  *
  * Copyright (c) 2014,2015 AMD Corporation.
  * Authors: Ken Xue <Ken.Xue@amd.com>
- *	Wu, Jeff <Jeff.Wu@amd.com>
+ *          Jeff Wu <15618388108@163.com>
+ *	    Wang Hongcheng <Annie.Wang@amd.com>
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
@@ -17,6 +18,10 @@
 #include <linux/acpi.h>
 #include <linux/err.h>
 #include <linux/pm.h>
+#include <linux/amba/bus.h>
+#include <linux/kernel.h>
+#include <linux/sizes.h>
+#include <linux/interrupt.h>
 
 #include "internal.h"
 
@@ -31,14 +36,15 @@ struct apd_private_data;
 #define ACPI_APD_PM	BIT(1)
 
 /**
- * struct apd_device_desc - a descriptor for apd device
- * @flags: device flags like %ACPI_APD_SYSFS, %ACPI_APD_PM
+ * struct apd_device_desc - a descriptor for apd device.
+ * @flags: device flags like %ACPI_APD_SYSFS, %ACPI_APD_PM;
  * @fixed_clk_rate: fixed rate input clock source for acpi device;
- *			0 means no fixed rate input clock source
- * @setup: a hook routine to set device resource during create platform device
+ *0 means no fixed rate input clock source;
+ * @clk_con_id: name of input clock source;
+ * @setup: a hook routine to set device resource during create platform device.
  *
- * Device description defined as acpi_device_id.driver_data
- */
+ * Device description defined as acpi_device_id.driver_data.
+*/
 struct apd_device_desc {
 	unsigned int flags;
 	unsigned int fixed_clk_rate;
@@ -71,6 +77,15 @@ static int acpi_apd_setup(struct apd_private_data *pdata)
 	return 0;
 }
 
+static void setup_quirks(struct platform_device *pdev,
+			 struct acpi_amba_quirk *quirk)
+{
+	if (!strncmp(pdev->name, "AMD0020", 7)) {
+		quirk->quirk |= MULTI_ATTACHED_QUIRK | BASE_OFFSET_QUIRK;
+		quirk->base_offset = SZ_4K;
+	}
+}
+
 static struct apd_device_desc cz_i2c_desc = {
 	.setup = acpi_apd_setup,
 	.fixed_clk_rate = 133000000,
@@ -88,15 +103,17 @@ static struct apd_device_desc cz_uart_desc = {
 #endif /* CONFIG_X86_AMD_PLATFORM_DEVICE */
 
 /**
-* Create platform device during acpi scan attach handle.
-* Return value > 0 on success of creating device.
-*/
+ * Create platform device during acpi scan attach handle.
+ * Return value > 0 on success of creating device.
+ */
 static int acpi_apd_create_device(struct acpi_device *adev,
-				   const struct acpi_device_id *id)
+				  const struct acpi_device_id *id)
 {
 	const struct apd_device_desc *dev_desc = (void *)id->driver_data;
 	struct apd_private_data *pdata;
 	struct platform_device *pdev;
+	struct amba_device *amba_dev;
+	struct acpi_amba_quirk amba_quirks;
 	int ret;
 
 	if (!dev_desc) {
@@ -118,9 +135,22 @@ static int acpi_apd_create_device(struct acpi_device *adev,
 	}
 
 	adev->driver_data = pdata;
+
 	pdev = acpi_create_platform_device(adev);
-	if (!IS_ERR_OR_NULL(pdev))
-		return 1;
+	if (IS_ERR_OR_NULL(pdev))
+		goto err_out;
+
+	if (!strncmp(pdev->name, "AMD0020", 7)) {
+		memset(&amba_quirks, 0, sizeof(amba_quirks));
+		setup_quirks(pdev, &amba_quirks);
+
+		amba_dev = acpi_create_amba_device(pdata->adev, 0x00041330,
+						   48000000,
+						   NULL,
+						   &amba_quirks);
+		if (IS_ERR_OR_NULL(amba_dev))
+			goto err_out;
+	}
 
 	ret = PTR_ERR(pdev);
 	adev->driver_data = NULL;
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 04827d8..50961a5 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -468,19 +468,28 @@ void acpi_walk_dep_device_list(acpi_handle handle);
 
 struct platform_device *acpi_create_platform_device(struct acpi_device *);
 
+struct acpi_amba_quirk {
+	u32 quirk;
+#define MULTI_ATTACHED_QUIRK  BIT(0)
+#define BASE_OFFSET_QUIRK     BIT(1)
+	u32 base_offset;
+};
+
 #ifdef CONFIG_ARM_AMBA
 
 struct amba_device *acpi_create_amba_device(struct acpi_device *adev,
 					    unsigned int periphid,
 					    unsigned long fixed_rate,
-					    void *pdata);
+					    void *pdata,
+					    struct acpi_amba_quirk *quirk);
 
 #else /* !CONFIG_ARM_AMBA */
 
 static inline struct amba_device *acpi_create_amba_device(struct acpi_device *adev,
 							  unsigned int periphid,
 							  unsigned long fixed_rate,
-							  void *pdata)
+							  void *pdata,
+							  struct acpi_amba_quirk *quirk)
 {
 	return NULL;
 }
-- 
1.9.1

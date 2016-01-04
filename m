From: Wang Hongcheng <annie.wang@amd.com>
Subject: [PATCH 4/6] dmaengine: pl330: add new items for pl330 private data
Date: Mon, 4 Jan 2016 13:31:39 +0800
Message-ID: <1451885501-2710-5-git-send-email-annie.wang@amd.com>
References: <1451885501-2710-1-git-send-email-annie.wang@amd.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1451885501-2710-1-git-send-email-annie.wang@amd.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>, Vinod Koul <vinod.koul@intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, dmaengine@vger.kernel.org, Borislav Petkov <bp@alien8.de>, Huang Rui <ray.huang@amd.com>, Wan Zongshun <vincent.wan@amd.com>, Ken Xue <ken.xue@amd.com>, Robin Murphy <robin.murphy@arm.com>, Graeme Gregory <gg@slimlogic.co.uk>, Tony Li <tony.li@amd.com>, Xiangliang Yu <Xiangliang.Yu@amd.com>, Wang Hongcheng <annie.wang@amd.com>
List-Id: linux-serial@vger.kernel.org

mcbuf_sz means bytes to allocate for MicroCode buffer.
flags is for irq sharing, default is non-shared, in AMD
Carrizo, pl330 shares IRQ with its corresponding UART device.

Signed-off-by: Wang Hongcheng <annie.wang@amd.com>
---
 drivers/acpi/acpi_apd.c    | 17 +++++++++++++++++
 drivers/dma/pl330.c        |  9 ++++++++-
 include/linux/amba/pl330.h |  2 ++
 3 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/acpi_apd.c b/drivers/acpi/acpi_apd.c
index 9520daf..4d71a65 100644
--- a/drivers/acpi/acpi_apd.c
+++ b/drivers/acpi/acpi_apd.c
@@ -20,6 +20,9 @@
 #include <linux/pm.h>
 #include <linux/amba/bus.h>
 #include <linux/dma-mapping.h>
+#include <linux/dmaengine.h>
+#include <linux/interrupt.h>
+#include <linux/amba/pl330.h>
 
 #include "internal.h"
 
@@ -33,6 +36,14 @@ struct apd_private_data;
 #define ACPI_APD_SYSFS	BIT(0)
 #define ACPI_APD_PM	BIT(1)
 
+static u8 peri_id[2] = { 0, 1 };
+
+static struct dma_pl330_platdata amd_pl330 = {
+	.nr_valid_peri = 2,
+	.peri_id = peri_id,
+	.mcbuf_sz = 0,
+	.flags = IRQF_SHARED,
+};
 /**
  * struct apd_device_desc - a descriptor for apd device
  * @flags: device flags like %ACPI_APD_SYSFS, %ACPI_APD_PM
@@ -150,6 +161,12 @@ static int acpi_apd_setup_quirks(struct apd_private_data *pdata)
 		goto amba_register_err;
 
 	kfree(resource);
+
+	dma_cap_set(DMA_MEMCPY, amd_pl330.cap_mask);
+	dma_cap_set(DMA_SLAVE, amd_pl330.cap_mask);
+	dma_cap_set(DMA_CYCLIC, amd_pl330.cap_mask);
+	dma_cap_set(DMA_PRIVATE, amd_pl330.cap_mask);
+
 	return 0;
 
 amba_register_err:
diff --git a/drivers/dma/pl330.c b/drivers/dma/pl330.c
index 17ee758..5e5fb46 100644
--- a/drivers/dma/pl330.c
+++ b/drivers/dma/pl330.c
@@ -26,6 +26,8 @@
 #include <linux/scatterlist.h>
 #include <linux/of.h>
 #include <linux/of_dma.h>
+#include <linux/acpi.h>
+#include <linux/acpi_dma.h>
 #include <linux/err.h>
 #include <linux/pm_runtime.h>
 
@@ -488,6 +490,9 @@ struct pl330_dmac {
 	/* Peripheral channels connected to this DMAC */
 	unsigned int num_peripherals;
 	struct dma_pl330_chan *peripherals; /* keep at end */
+
+	/*IRQ register flags */
+	unsigned int flags;
 };
 
 struct dma_pl330_desc {
@@ -2800,6 +2805,8 @@ pl330_probe(struct amba_device *adev, const struct amba_id *id)
 
 	pl330->mcbufsz = pdat ? pdat->mcbuf_sz : 0;
 
+	pl330->flags = pdat ? pdat->flags : IRQF_TRIGGER_NONE;
+
 	res = &adev->res;
 	pl330->base = devm_ioremap_resource(&adev->dev, res);
 	if (IS_ERR(pl330->base))
@@ -2811,7 +2818,7 @@ pl330_probe(struct amba_device *adev, const struct amba_id *id)
 		irq = adev->irq[i];
 		if (irq) {
 			ret = devm_request_irq(&adev->dev, irq,
-					       pl330_irq_handler, 0,
+					       pl330_irq_handler, pl330->flags,
 					       dev_name(&adev->dev), pl330);
 			if (ret)
 				return ret;
diff --git a/include/linux/amba/pl330.h b/include/linux/amba/pl330.h
index fe93758..cdc80f0 100644
--- a/include/linux/amba/pl330.h
+++ b/include/linux/amba/pl330.h
@@ -29,6 +29,8 @@ struct dma_pl330_platdata {
 	dma_cap_mask_t cap_mask;
 	/* Bytes to allocate for MC buffer */
 	unsigned mcbuf_sz;
+	/*flags for irq sharing, default is non-shared*/
+	unsigned flags;
 };
 
 extern bool pl330_filter(struct dma_chan *chan, void *param);
-- 
1.9.1


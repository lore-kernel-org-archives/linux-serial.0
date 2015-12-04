From: Wang Hongcheng <annie.wang@amd.com>
Subject: [PATCH 4/9] dmaengine: pl330: add new items for pl330 private data
Date: Fri, 4 Dec 2015 11:24:21 +0800
Message-ID: <1449199466-6081-5-git-send-email-annie.wang@amd.com>
References: <1449199466-6081-1-git-send-email-annie.wang@amd.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1449199466-6081-1-git-send-email-annie.wang@amd.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Vinod Koul <vinod.koul@intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, dmaengine@vger.kernel.org, iommu@lists.linux-foundation.org, Borislav Petkov <bp@alien8.de>, Huang Rui <ray.huang@amd.com>, Wan Zongshun <vincent.wan@amd.com>, Ken Xue <ken.xue@amd.com>, Tony Li <tony.li@amd.com>, Wang Hongcheng <annie.wang@amd.com>
List-Id: linux-serial@vger.kernel.org

has_no_cap_mask means this device has no preset cap mask.
mcbuf_sz means bytes to allocate for MC buffer.
flags is for irq sharing, default is non-shared, in AMD
Carrizo, pl330 shares IRQ with its corresponding UART device.

Signed-off-by: Wang Hongcheng <annie.wang@amd.com>
---
 drivers/acpi/acpi_apd.c    | 13 ++++++++++++-
 drivers/dma/pl330.c        | 19 +++++++++++++------
 include/linux/amba/pl330.h |  3 +++
 3 files changed, 28 insertions(+), 7 deletions(-)

diff --git a/drivers/acpi/acpi_apd.c b/drivers/acpi/acpi_apd.c
index eb3316a..7a582f5 100644
--- a/drivers/acpi/acpi_apd.c
+++ b/drivers/acpi/acpi_apd.c
@@ -21,6 +21,7 @@
 #include <linux/amba/bus.h>
 #include <linux/kernel.h>
 #include <linux/sizes.h>
+#include <linux/amba/pl330.h>
 #include <linux/interrupt.h>
 
 #include "internal.h"
@@ -35,6 +36,16 @@ struct apd_private_data;
 #define ACPI_APD_SYSFS	BIT(0)
 #define ACPI_APD_PM	BIT(1)
 
+static u8 peri_id[2] = { 0, 1 };
+
+static struct dma_pl330_platdata amd_pl330 = {
+	.nr_valid_peri = 2,
+	.peri_id = peri_id,
+	.has_no_cap_mask = true,
+	.mcbuf_sz = 0,
+	.flags = IRQF_SHARED,
+};
+
 /**
  * struct apd_device_desc - a descriptor for apd device.
  * @flags: device flags like %ACPI_APD_SYSFS, %ACPI_APD_PM;
@@ -146,7 +157,7 @@ static int acpi_apd_create_device(struct acpi_device *adev,
 
 		amba_dev = acpi_create_amba_device(pdata->adev, 0x00041330,
 						   48000000,
-						   NULL,
+						   &amd_pl330,
 						   &amba_quirks);
 		if (IS_ERR_OR_NULL(amba_dev))
 			goto err_out;
diff --git a/drivers/dma/pl330.c b/drivers/dma/pl330.c
index 17ee758..8300969 100644
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
@@ -2870,7 +2877,7 @@ pl330_probe(struct amba_device *adev, const struct amba_id *id)
 		list_add_tail(&pch->chan.device_node, &pd->channels);
 	}
 
-	if (pdat) {
+	if (pdat && !pdat->has_no_cap_mask) {
 		pd->cap_mask = pdat->cap_mask;
 	} else {
 		dma_cap_set(DMA_MEMCPY, pd->cap_mask);
@@ -2923,11 +2930,11 @@ pl330_probe(struct amba_device *adev, const struct amba_id *id)
 
 
 	dev_info(&adev->dev,
-		"Loaded driver for PL330 DMAC-%x\n", adev->periphid);
+		 "Loaded driver for PL330 DMAC-%x\n", adev->periphid);
 	dev_info(&adev->dev,
-		"\tDBUFF-%ux%ubytes Num_Chans-%u Num_Peri-%u Num_Events-%u\n",
-		pcfg->data_buf_dep, pcfg->data_bus_width / 8, pcfg->num_chan,
-		pcfg->num_peri, pcfg->num_events);
+		 "\tDBUFF-%ux%ubytes Num_Chans-%u Num_Peri-%u Num_Events-%u\n",
+		 pcfg->data_buf_dep, pcfg->data_bus_width / 8, pcfg->num_chan,
+		 pcfg->num_peri, pcfg->num_events);
 
 	pm_runtime_irq_safe(&adev->dev);
 	pm_runtime_use_autosuspend(&adev->dev);
diff --git a/include/linux/amba/pl330.h b/include/linux/amba/pl330.h
index fe93758..605d00f 100644
--- a/include/linux/amba/pl330.h
+++ b/include/linux/amba/pl330.h
@@ -26,9 +26,12 @@ struct dma_pl330_platdata {
 	/* Array of valid peripherals */
 	u8 *peri_id;
 	/* Operational capabilities */
+	bool has_no_cap_mask;
 	dma_cap_mask_t cap_mask;
 	/* Bytes to allocate for MC buffer */
 	unsigned mcbuf_sz;
+	/*flags for irq sharing, default is non-shared*/
+	unsigned flags;
 };
 
 extern bool pl330_filter(struct dma_chan *chan, void *param);
-- 
1.9.1


From: Wang Hongcheng <annie.wang@amd.com>
Subject: [PATCH 5/6] dmaengine: pl330: provide ACPI dmaengine interface
Date: Mon, 4 Jan 2016 13:31:40 +0800
Message-ID: <1451885501-2710-6-git-send-email-annie.wang@amd.com>
References: <1451885501-2710-1-git-send-email-annie.wang@amd.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1451885501-2710-1-git-send-email-annie.wang@amd.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>, Vinod Koul <vinod.koul@intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, dmaengine@vger.kernel.org, Borislav Petkov <bp@alien8.de>, Huang Rui <ray.huang@amd.com>, Wan Zongshun <vincent.wan@amd.com>, Ken Xue <ken.xue@amd.com>, Robin Murphy <robin.murphy@arm.com>, Graeme Gregory <gg@slimlogic.co.uk>, Tony Li <tony.li@amd.com>, Xiangliang Yu <Xiangliang.Yu@amd.com>, Wang Hongcheng <annie.wang@amd.com>
List-Id: linux-serial@vger.kernel.org

register acpi_dma controller, so ACPI devices can request pl330 DMA
channel. Request line info is get from private data.

Signed-off-by: Wang Hongcheng <annie.wang@amd.com>
---
 drivers/acpi/acpi_apd.c    | 34 +++++++++++++++++++++++++---------
 drivers/dma/pl330.c        | 27 +++++++++++++++++++++++++++
 include/linux/amba/pl330.h |  4 ++++
 3 files changed, 56 insertions(+), 9 deletions(-)

diff --git a/drivers/acpi/acpi_apd.c b/drivers/acpi/acpi_apd.c
index 4d71a65..1f16cca 100644
--- a/drivers/acpi/acpi_apd.c
+++ b/drivers/acpi/acpi_apd.c
@@ -38,11 +38,23 @@ struct apd_private_data;
 
 static u8 peri_id[2] = { 0, 1 };
 
-static struct dma_pl330_platdata amd_pl330 = {
-	.nr_valid_peri = 2,
-	.peri_id = peri_id,
-	.mcbuf_sz = 0,
-	.flags = IRQF_SHARED,
+static struct dma_pl330_platdata amd_pl330[] = {
+	{
+		.nr_valid_peri = 2,
+		.peri_id = peri_id,
+		.mcbuf_sz = 0,
+		.flags = IRQF_SHARED,
+		.base_request_line = 1,
+		.num = 0,
+	},
+	{
+		.nr_valid_peri = 2,
+		.peri_id = peri_id,
+		.mcbuf_sz = 0,
+		.flags = IRQF_SHARED,
+		.base_request_line = 2,
+		.num = 0,
+	}
 };
 /**
  * struct apd_device_desc - a descriptor for apd device
@@ -101,6 +113,7 @@ static int acpi_apd_setup_quirks(struct apd_private_data *pdata)
 	unsigned int irq[AMBA_NR_IRQS];
 	struct clk *clk = ERR_PTR(-ENODEV);
 	char amba_devname[100];
+	int devnum;
 
 	resource = kzalloc(sizeof(*resource), GFP_KERNEL);
 	if (!resource)
@@ -131,8 +144,11 @@ static int acpi_apd_setup_quirks(struct apd_private_data *pdata)
 	if (!amba_dev)
 		goto amba_alloc_err;
 
+	devnum = amba_devname[strlen(dev_name(&pdev->dev)) - 1] - '0';
+
 	amba_dev->dev.coherent_dma_mask
 		= acpi_dma_supported(ACPI_COMPANION(&pdev->dev)) ? DMA_BIT_MASK(64) : 0;
+	amba_dev->dev.platform_data = &amd_pl330[devnum];
 	amba_dev->dev.fwnode = acpi_fwnode_handle(ACPI_COMPANION(&pdev->dev));
 
 	amba_dev->dev.parent = &pdev->dev;
@@ -162,10 +178,10 @@ static int acpi_apd_setup_quirks(struct apd_private_data *pdata)
 
 	kfree(resource);
 
-	dma_cap_set(DMA_MEMCPY, amd_pl330.cap_mask);
-	dma_cap_set(DMA_SLAVE, amd_pl330.cap_mask);
-	dma_cap_set(DMA_CYCLIC, amd_pl330.cap_mask);
-	dma_cap_set(DMA_PRIVATE, amd_pl330.cap_mask);
+	dma_cap_set(DMA_MEMCPY, amd_pl330[devnum].cap_mask);
+	dma_cap_set(DMA_SLAVE, amd_pl330[devnum].cap_mask);
+	dma_cap_set(DMA_CYCLIC, amd_pl330[devnum].cap_mask);
+	dma_cap_set(DMA_PRIVATE, amd_pl330[devnum].cap_mask);
 
 	return 0;
 
diff --git a/drivers/dma/pl330.c b/drivers/dma/pl330.c
index 5e5fb46..e0e0b6e 100644
--- a/drivers/dma/pl330.c
+++ b/drivers/dma/pl330.c
@@ -2079,6 +2079,22 @@ static struct dma_chan *of_dma_pl330_xlate(struct of_phandle_args *dma_spec,
 	return dma_get_slave_channel(&pl330->peripherals[chan_id].chan);
 }
 
+static struct dma_chan *acpi_dma_pl330_xlate(struct acpi_dma_spec *dma_spec,
+					     struct acpi_dma *adma)
+{
+	struct pl330_dmac *pl330 = adma->data;
+	struct dma_pl330_platdata *pdat;
+	unsigned int chan_id;
+
+	pdat = dev_get_platdata(adma->dev);
+
+	chan_id = dma_spec->chan_id;
+	if (chan_id >= pl330->num_peripherals)
+		return NULL;
+
+	return dma_get_slave_channel(&pl330->peripherals[chan_id].chan);
+}
+
 static int pl330_alloc_chan_resources(struct dma_chan *chan)
 {
 	struct dma_pl330_chan *pch = to_pchan(chan);
@@ -2918,6 +2934,17 @@ pl330_probe(struct amba_device *adev, const struct amba_id *id)
 		}
 	}
 
+	if (has_acpi_companion(&adev->dev)) {
+		ret = acpi_dma_controller_register(&adev->dev,
+						   acpi_dma_pl330_xlate,
+						   pdat->base_request_line,
+						   pdat->num, pl330);
+		if (ret) {
+			dev_err(&adev->dev,
+				"unable to register DMA to the generic ACPI DMA helpers\n");
+		}
+	}
+
 	adev->dev.dma_parms = &pl330->dma_parms;
 
 	/*
diff --git a/include/linux/amba/pl330.h b/include/linux/amba/pl330.h
index cdc80f0..1190f69 100644
--- a/include/linux/amba/pl330.h
+++ b/include/linux/amba/pl330.h
@@ -31,6 +31,10 @@ struct dma_pl330_platdata {
 	unsigned mcbuf_sz;
 	/*flags for irq sharing, default is non-shared*/
 	unsigned flags;
+	/*device base request line*/
+	unsigned short base_request_line;
+	/*device request line range*/
+	unsigned short num;
 };
 
 extern bool pl330_filter(struct dma_chan *chan, void *param);
-- 
1.9.1

From: Wang Hongcheng <annie.wang@amd.com>
Subject: [PATCH 5/9] dmaengine: pl330: provide ACPI dmaengine interface
Date: Fri, 4 Dec 2015 11:24:22 +0800
Message-ID: <1449199466-6081-6-git-send-email-annie.wang@amd.com>
References: <1449199466-6081-1-git-send-email-annie.wang@amd.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1449199466-6081-1-git-send-email-annie.wang@amd.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vinod Koul <vinod.koul@intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, dmaengine@vger.kernel.org, iommu@lists.linux-foundation.org, Borislav Petkov <bp@alien8.de>, Huang Rui <ray.huang@amd.com>, Wan Zongshun <vincent.wan@amd.com>, Ken Xue <ken.xue@amd.com>, Tony Li <tony.li@amd.com>, Wang Hongcheng <annie.wang@amd.com>
List-Id: linux-serial@vger.kernel.org

register acpi_dma controller, so ACPI devices can request pl330 DMA
channel.
A filter is added in private data for Carrizo specific hardware
design

Signed-off-by: Wang Hongcheng <annie.wang@amd.com>
---
 drivers/acpi/acpi_apd.c    | 12 ++++++++++++
 drivers/dma/pl330.c        | 38 ++++++++++++++++++++++++++++++++++++++
 include/linux/amba/pl330.h |  1 +
 3 files changed, 51 insertions(+)

diff --git a/drivers/acpi/acpi_apd.c b/drivers/acpi/acpi_apd.c
index 7a582f5..906a20f 100644
--- a/drivers/acpi/acpi_apd.c
+++ b/drivers/acpi/acpi_apd.c
@@ -38,12 +38,15 @@ struct apd_private_data;
 
 static u8 peri_id[2] = { 0, 1 };
 
+static int apd_acpi_xlate_filter(int slave_id, struct device *dev);
+
 static struct dma_pl330_platdata amd_pl330 = {
 	.nr_valid_peri = 2,
 	.peri_id = peri_id,
 	.has_no_cap_mask = true,
 	.mcbuf_sz = 0,
 	.flags = IRQF_SHARED,
+	.acpi_xlate_filter = apd_acpi_xlate_filter,
 };
 
 /**
@@ -68,6 +71,15 @@ struct apd_private_data {
 	const struct apd_device_desc *dev_desc;
 };
 
+int apd_acpi_xlate_filter(int slave_id, struct device *dev)
+{
+	if (((slave_id == 1) && (!strcmp(dev_name(dev), "AMD0020:00DMA")))
+	    || ((slave_id == 2) && (!strcmp(dev_name(dev), "AMD0020:01DMA"))))
+		return 0;
+
+	return 1;
+}
+
 #ifdef CONFIG_X86_AMD_PLATFORM_DEVICE
 #define APD_ADDR(desc)	((unsigned long)&desc)
 
diff --git a/drivers/dma/pl330.c b/drivers/dma/pl330.c
index 8300969..9d7af0d 100644
--- a/drivers/dma/pl330.c
+++ b/drivers/dma/pl330.c
@@ -2079,6 +2079,35 @@ static struct dma_chan *of_dma_pl330_xlate(struct of_phandle_args *dma_spec,
 	return dma_get_slave_channel(&pl330->peripherals[chan_id].chan);
 }
 
+static struct dma_chan *acpi_dma_pl330_xlate(struct acpi_dma_spec *dma_spec,
+					     struct acpi_dma *adma)
+{
+	struct pl330_dmac *pl330 = adma->data;
+	struct dma_pl330_platdata *pdat;
+	unsigned int chan_id;
+	int ret;
+
+	if (!dma_spec)
+		return NULL;
+
+	if (!adma)
+		return NULL;
+
+	pdat = dev_get_platdata(adma->dev);
+
+	chan_id = dma_spec->chan_id;
+	if (chan_id >= pl330->num_peripherals)
+		return NULL;
+
+	if (pdat->acpi_xlate_filter) {
+		ret = pdat->acpi_xlate_filter(dma_spec->slave_id, adma->dev);
+		if (ret)
+			return NULL;
+	}
+
+	return dma_get_slave_channel(&pl330->peripherals[chan_id].chan);
+}
+
 static int pl330_alloc_chan_resources(struct dma_chan *chan)
 {
 	struct dma_pl330_chan *pch = to_pchan(chan);
@@ -2918,6 +2947,15 @@ pl330_probe(struct amba_device *adev, const struct amba_id *id)
 		}
 	}
 
+	if (ACPI_HANDLE(&adev->dev)) {
+		ret = acpi_dma_controller_register(&adev->dev,
+						   acpi_dma_pl330_xlate, pl330);
+		if (ret) {
+			dev_err(&adev->dev,
+				"unable to register DMA to the generic ACPI DMA helpers\n");
+		}
+	}
+
 	adev->dev.dma_parms = &pl330->dma_parms;
 
 	/*
diff --git a/include/linux/amba/pl330.h b/include/linux/amba/pl330.h
index 605d00f..85bebbb 100644
--- a/include/linux/amba/pl330.h
+++ b/include/linux/amba/pl330.h
@@ -32,6 +32,7 @@ struct dma_pl330_platdata {
 	unsigned mcbuf_sz;
 	/*flags for irq sharing, default is non-shared*/
 	unsigned flags;
+	int (*acpi_xlate_filter)(int slave_id, struct device *dev);
 };
 
 extern bool pl330_filter(struct dma_chan *chan, void *param);
-- 
1.9.1

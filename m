From: Wang Hongcheng <annie.wang@amd.com>
Subject: [PATCH 3/6] ACPI: add 2 parameters to function acpi dma controller register
Date: Mon, 4 Jan 2016 13:31:38 +0800
Message-ID: <1451885501-2710-4-git-send-email-annie.wang@amd.com>
References: <1451885501-2710-1-git-send-email-annie.wang@amd.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1451885501-2710-1-git-send-email-annie.wang@amd.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>, Vinod Koul <vinod.koul@intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, dmaengine@vger.kernel.org, Borislav Petkov <bp@alien8.de>, Huang Rui <ray.huang@amd.com>, Wan Zongshun <vincent.wan@amd.com>, Ken Xue <ken.xue@amd.com>, Robin Murphy <robin.murphy@arm.com>, Graeme Gregory <gg@slimlogic.co.uk>, Tony Li <tony.li@amd.com>, Xiangliang Yu <Xiangliang.Yu@amd.com>, Wang Hongcheng <annie.wang@amd.com>
List-Id: linux-serial@vger.kernel.org

As CSRT table will not always work, 2 arguments, base_request_line
and num are added to acpi dma controller register
as another way to get device request line.

Signed-off-by: Wang Hongcheng <annie.wang@amd.com>
---
 drivers/dma/acpi-dma.c    | 25 ++++++++++++++++++++-----
 drivers/dma/dw/platform.c |  2 +-
 include/linux/acpi_dma.h  |  6 ++++++
 3 files changed, 27 insertions(+), 6 deletions(-)

diff --git a/drivers/dma/acpi-dma.c b/drivers/dma/acpi-dma.c
index 16d0daa..e2c27c3 100644
--- a/drivers/dma/acpi-dma.c
+++ b/drivers/dma/acpi-dma.c
@@ -105,7 +105,7 @@ static int acpi_dma_parse_resource_group(const struct acpi_csrt_group *grp,
  * We are using this table to get the request line range of the specific DMA
  * controller to be used later.
  */
-static void acpi_dma_parse_csrt(struct acpi_device *adev, struct acpi_dma *adma)
+static int acpi_dma_parse_csrt(struct acpi_device *adev, struct acpi_dma *adma)
 {
 	struct acpi_csrt_group *grp, *end;
 	struct acpi_table_csrt *csrt;
@@ -117,7 +117,7 @@ static void acpi_dma_parse_csrt(struct acpi_device *adev, struct acpi_dma *adma)
 	if (ACPI_FAILURE(status)) {
 		if (status != AE_NOT_FOUND)
 			dev_warn(&adev->dev, "failed to get the CSRT table\n");
-		return;
+		return -ENOENT;
 	}
 
 	grp = (struct acpi_csrt_group *)(csrt + 1);
@@ -128,11 +128,12 @@ static void acpi_dma_parse_csrt(struct acpi_device *adev, struct acpi_dma *adma)
 		if (ret < 0) {
 			dev_warn(&adev->dev,
 				 "error in parsing resource group\n");
-			return;
+			return -EINVAL;
 		}
 
 		grp = (struct acpi_csrt_group *)((void *)grp + grp->length);
 	}
+	return 0;
 }
 
 /**
@@ -140,6 +141,8 @@ static void acpi_dma_parse_csrt(struct acpi_device *adev, struct acpi_dma *adma)
  * @dev:		struct device of DMA controller
  * @acpi_dma_xlate:	translation function which converts a dma specifier
  *			into a dma_chan structure
+ * @base_request_line:  device request line base
+ * @num:                device request line range
  * @data		pointer to controller specific data to be used by
  *			translation function
  *
@@ -152,10 +155,13 @@ static void acpi_dma_parse_csrt(struct acpi_device *adev, struct acpi_dma *adma)
 int acpi_dma_controller_register(struct device *dev,
 		struct dma_chan *(*acpi_dma_xlate)
 		(struct acpi_dma_spec *, struct acpi_dma *),
+		unsigned short base_request_line,
+		unsigned short num,
 		void *data)
 {
 	struct acpi_device *adev;
 	struct acpi_dma	*adma;
+	int ret;
 
 	if (!dev || !acpi_dma_xlate)
 		return -EINVAL;
@@ -173,7 +179,12 @@ int acpi_dma_controller_register(struct device *dev,
 	adma->acpi_dma_xlate = acpi_dma_xlate;
 	adma->data = data;
 
-	acpi_dma_parse_csrt(adev, adma);
+	ret = acpi_dma_parse_csrt(adev, adma);
+
+	if (ret < 0) {
+		adma->base_request_line = base_request_line;
+		adma->end_request_line = base_request_line + num;
+	}
 
 	/* Now queue acpi_dma controller structure in list */
 	mutex_lock(&acpi_dma_lock);
@@ -236,6 +247,8 @@ static void devm_acpi_dma_release(struct device *dev, void *res)
 int devm_acpi_dma_controller_register(struct device *dev,
 		struct dma_chan *(*acpi_dma_xlate)
 		(struct acpi_dma_spec *, struct acpi_dma *),
+		unsigned short base_request_line,
+		unsigned short num,
 		void *data)
 {
 	void *res;
@@ -245,7 +258,9 @@ int devm_acpi_dma_controller_register(struct device *dev,
 	if (!res)
 		return -ENOMEM;
 
-	ret = acpi_dma_controller_register(dev, acpi_dma_xlate, data);
+	ret = acpi_dma_controller_register(dev, acpi_dma_xlate,
+					   base_request_line,
+					   num, data);
 	if (ret) {
 		devres_free(res);
 		return ret;
diff --git a/drivers/dma/dw/platform.c b/drivers/dma/dw/platform.c
index 68a4815..54b898d 100644
--- a/drivers/dma/dw/platform.c
+++ b/drivers/dma/dw/platform.c
@@ -88,7 +88,7 @@ static void dw_dma_acpi_controller_register(struct dw_dma *dw)
 	info->filter_fn = dw_dma_acpi_filter;
 
 	ret = devm_acpi_dma_controller_register(dev, acpi_dma_simple_xlate,
-						info);
+						0, 0, info);
 	if (ret)
 		dev_err(dev, "could not register acpi_dma_controller\n");
 }
diff --git a/include/linux/acpi_dma.h b/include/linux/acpi_dma.h
index 329436d..d90febe 100644
--- a/include/linux/acpi_dma.h
+++ b/include/linux/acpi_dma.h
@@ -62,11 +62,15 @@ struct acpi_dma_filter_info {
 int acpi_dma_controller_register(struct device *dev,
 		struct dma_chan *(*acpi_dma_xlate)
 		(struct acpi_dma_spec *, struct acpi_dma *),
+		unsigned short base_request_line,
+		unsigned short num,
 		void *data);
 int acpi_dma_controller_free(struct device *dev);
 int devm_acpi_dma_controller_register(struct device *dev,
 		struct dma_chan *(*acpi_dma_xlate)
 		(struct acpi_dma_spec *, struct acpi_dma *),
+		unsigned short base_request_line,
+		unsigned short num,
 		void *data);
 void devm_acpi_dma_controller_free(struct device *dev);
 
@@ -82,6 +86,8 @@ struct dma_chan *acpi_dma_simple_xlate(struct acpi_dma_spec *dma_spec,
 static inline int acpi_dma_controller_register(struct device *dev,
 		struct dma_chan *(*acpi_dma_xlate)
 		(struct acpi_dma_spec *, struct acpi_dma *),
+		unsigned short base_request_line,
+		unsigned short num,
 		void *data)
 {
 	return -ENODEV;
-- 
1.9.1

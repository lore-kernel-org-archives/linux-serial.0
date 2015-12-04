From: Wang Hongcheng <annie.wang@amd.com>
Subject: [PATCH 6/9] dmaengine:pl330: set segment_boundary_mask = 0cffffffff
Date: Fri, 4 Dec 2015 11:24:23 +0800
Message-ID: <1449199466-6081-7-git-send-email-annie.wang@amd.com>
References: <1449199466-6081-1-git-send-email-annie.wang@amd.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1449199466-6081-1-git-send-email-annie.wang@amd.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vinod Koul <vinod.koul@intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, dmaengine@vger.kernel.org, iommu@lists.linux-foundation.org, Borislav Petkov <bp@alien8.de>, Huang Rui <ray.huang@amd.com>, Wan Zongshun <vincent.wan@amd.com>, Ken Xue <ken.xue@amd.com>, Tony Li <tony.li@amd.com>, Wang Hongcheng <annie.wang@amd.com>, Wan Zongshun <Vincent.Wan@amd.com>
List-Id: linux-serial@vger.kernel.org

Because amd iommu and software iommu need this mask.For example,
if we use software iommu without this mask, we will
get 'Out of SW-IOMMU space' error, when calling swiotlb_map_page
function.

Signed-off-by: Wan Zongshun <Vincent.Wan@amd.com>
Signed-off-by: Wang Hongcheng <annie.wang@amd.com>
---
 drivers/dma/pl330.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/dma/pl330.c b/drivers/dma/pl330.c
index 9d7af0d..fb46fdf 100644
--- a/drivers/dma/pl330.c
+++ b/drivers/dma/pl330.c
@@ -2966,6 +2966,10 @@ pl330_probe(struct amba_device *adev, const struct amba_id *id)
 	if (ret)
 		dev_err(&adev->dev, "unable to set the seg size\n");
 
+	dev_info(&adev->dev, "set the seg boundary\n");
+	ret = dma_set_seg_boundary(&adev->dev, 0xffffffff);
+	if (ret)
+		dev_err(&adev->dev, "unable to set the seg boundary\n");
 
 	dev_info(&adev->dev,
 		 "Loaded driver for PL330 DMAC-%x\n", adev->periphid);
-- 
1.9.1

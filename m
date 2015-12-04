From: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH 6/9] dmaengine:pl330: set segment_boundary_mask =
 0cffffffff
Date: Fri, 4 Dec 2015 14:59:11 +0000
Message-ID: <5661AA3F.6080101@arm.com>
References: <1449199466-6081-1-git-send-email-annie.wang@amd.com>
 <1449199466-6081-7-git-send-email-annie.wang@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1449199466-6081-7-git-send-email-annie.wang@amd.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Wang Hongcheng <annie.wang@amd.com>, Vinod Koul <vinod.koul@intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Tony Li <tony.li@amd.com>, Wan Zongshun <Vincent.Wan@amd.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, iommu@lists.linux-foundation.org, Huang Rui <ray.huang@amd.com>, Borislav Petkov <bp@alien8.de>, linux-serial@vger.kernel.org, dmaengine@vger.kernel.org, Ken Xue <ken.xue@amd.com>
List-Id: linux-serial@vger.kernel.org

On 04/12/15 03:24, Wang Hongcheng wrote:
> Because amd iommu and software iommu need this mask.For example,
> if we use software iommu without this mask, we will
> get 'Out of SW-IOMMU space' error, when calling swiotlb_map_page
> function.

The commit title doesn't match the code, but either way this patch 
should now be unnecessary: 002edb6f6f2a ("dma-mapping: tidy up dma_parms 
default handling") resolves the problem at its source, and is already in 
4.4-rc1.

(Incidentally, it was specifically the same PL330/SWIOTLB combination 
that led to that patch in the first place)

Robin.

> Signed-off-by: Wan Zongshun <Vincent.Wan@amd.com>
> Signed-off-by: Wang Hongcheng <annie.wang@amd.com>
> ---
>   drivers/dma/pl330.c | 4 ++++
>   1 file changed, 4 insertions(+)
>
> diff --git a/drivers/dma/pl330.c b/drivers/dma/pl330.c
> index 9d7af0d..fb46fdf 100644
> --- a/drivers/dma/pl330.c
> +++ b/drivers/dma/pl330.c
> @@ -2966,6 +2966,10 @@ pl330_probe(struct amba_device *adev, const struct amba_id *id)
>   	if (ret)
>   		dev_err(&adev->dev, "unable to set the seg size\n");
>
> +	dev_info(&adev->dev, "set the seg boundary\n");
> +	ret = dma_set_seg_boundary(&adev->dev, 0xffffffff);
> +	if (ret)
> +		dev_err(&adev->dev, "unable to set the seg boundary\n");
>
>   	dev_info(&adev->dev,
>   		 "Loaded driver for PL330 DMAC-%x\n", adev->periphid);
>


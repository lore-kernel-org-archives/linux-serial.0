From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 4/9] dmaengine: pl330: add new items for pl330 private
 data
Date: Thu, 10 Dec 2015 09:39:09 +0530
Message-ID: <20151210040909.GM1854@localhost>
References: <1449199466-6081-1-git-send-email-annie.wang@amd.com>
 <1449199466-6081-5-git-send-email-annie.wang@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1449199466-6081-5-git-send-email-annie.wang@amd.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Wang Hongcheng <annie.wang@amd.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, dmaengine@vger.kernel.org, iommu@lists.linux-foundation.org, Borislav Petkov <bp@alien8.de>, Huang Rui <ray.huang@amd.com>, Wan Zongshun <vincent.wan@amd.com>, Ken Xue <ken.xue@amd.com>, Tony Li <tony.li@amd.com>
List-Id: linux-serial@vger.kernel.org

On Fri, Dec 04, 2015 at 11:24:21AM +0800, Wang Hongcheng wrote:
> has_no_cap_mask means this device has no preset cap mask.
> mcbuf_sz means bytes to allocate for MC buffer.

MC ?

> flags is for irq sharing, default is non-shared, in AMD
> Carrizo, pl330 shares IRQ with its corresponding UART device.
> 
> Signed-off-by: Wang Hongcheng <annie.wang@amd.com>
> ---
>  drivers/acpi/acpi_apd.c    | 13 ++++++++++++-
>  drivers/dma/pl330.c        | 19 +++++++++++++------
>  include/linux/amba/pl330.h |  3 +++
>  3 files changed, 28 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/acpi/acpi_apd.c b/drivers/acpi/acpi_apd.c
> index eb3316a..7a582f5 100644
> --- a/drivers/acpi/acpi_apd.c
> +++ b/drivers/acpi/acpi_apd.c
> @@ -21,6 +21,7 @@
>  #include <linux/amba/bus.h>
>  #include <linux/kernel.h>
>  #include <linux/sizes.h>
> +#include <linux/amba/pl330.h>
>  #include <linux/interrupt.h>
>  
>  #include "internal.h"
> @@ -35,6 +36,16 @@ struct apd_private_data;
>  #define ACPI_APD_SYSFS	BIT(0)
>  #define ACPI_APD_PM	BIT(1)
>  
> +static u8 peri_id[2] = { 0, 1 };
> +
> +static struct dma_pl330_platdata amd_pl330 = {
> +	.nr_valid_peri = 2,
> +	.peri_id = peri_id,
> +	.has_no_cap_mask = true,
> +	.mcbuf_sz = 0,
> +	.flags = IRQF_SHARED,
> +};

Why not DT or ACPI for this?

-- 
~Vinod

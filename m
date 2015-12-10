From: "Wang, Annie" <Annie.Wang@amd.com>
Subject: RE: [PATCH 4/9] dmaengine: pl330: add new items for pl330 private
 data
Date: Thu, 10 Dec 2015 06:38:09 +0000
Message-ID: <BLUPR12MB0433B81BB0AEB2D84505B55881E90@BLUPR12MB0433.namprd12.prod.outlook.com>
References: <1449199466-6081-1-git-send-email-annie.wang@amd.com>
 <1449199466-6081-5-git-send-email-annie.wang@amd.com>
 <20151210040909.GM1854@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20151210040909.GM1854@localhost>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, Borislav Petkov <bp@alien8.de>, "Huang, Ray" <Ray.Huang@amd.com>, "Wan, Vincent" <Vincent.Wan@amd.com>, "Xue, Ken" <Ken.Xue@amd.com>, "Li, Tony" <Tony.Li@amd.com>
List-Id: linux-serial@vger.kernel.org

>-----Original Message-----
>From: Vinod Koul [mailto:vinod.koul@intel.com]
>Sent: Thursday, December 10, 2015 12:09 PM
>To: Wang, Annie
>Cc: Mika Westerberg; Joerg Roedel; Greg Kroah-Hartman; Rafael J. Wysocki;
>linux-acpi@vger.kernel.org; linux-kernel@vger.kernel.org; linux-
>serial@vger.kernel.org; dmaengine@vger.kernel.org; iommu@lists.linux-
>foundation.org; Borislav Petkov; Huang, Ray; Wan, Vincent; Xue, Ken; Li, Tony
>Subject: Re: [PATCH 4/9] dmaengine: pl330: add new items for pl330 private data
>
>On Fri, Dec 04, 2015 at 11:24:21AM +0800, Wang Hongcheng wrote:
>> has_no_cap_mask means this device has no preset cap mask.
>> mcbuf_sz means bytes to allocate for MC buffer.
>
>MC ?
Size of MicroCode buffers for each channel. I will update the comment.

>> flags is for irq sharing, default is non-shared, in AMD Carrizo, pl330
>> shares IRQ with its corresponding UART device.
>>
>> Signed-off-by: Wang Hongcheng <annie.wang@amd.com>
>> ---
>>  drivers/acpi/acpi_apd.c    | 13 ++++++++++++-
>>  drivers/dma/pl330.c        | 19 +++++++++++++------
>>  include/linux/amba/pl330.h |  3 +++
>>  3 files changed, 28 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/acpi/acpi_apd.c b/drivers/acpi/acpi_apd.c index
>> eb3316a..7a582f5 100644
>> --- a/drivers/acpi/acpi_apd.c
>> +++ b/drivers/acpi/acpi_apd.c
>> @@ -21,6 +21,7 @@
>>  #include <linux/amba/bus.h>
>>  #include <linux/kernel.h>
>>  #include <linux/sizes.h>
>> +#include <linux/amba/pl330.h>
>>  #include <linux/interrupt.h>
>>
>>  #include "internal.h"
>> @@ -35,6 +36,16 @@ struct apd_private_data;
>>  #define ACPI_APD_SYSFS	BIT(0)
>>  #define ACPI_APD_PM	BIT(1)
>>
>> +static u8 peri_id[2] = { 0, 1 };
>> +
>> +static struct dma_pl330_platdata amd_pl330 = {
>> +	.nr_valid_peri = 2,
>> +	.peri_id = peri_id,
>> +	.has_no_cap_mask = true,
>> +	.mcbuf_sz = 0,
>> +	.flags = IRQF_SHARED,
>> +};
>
>Why not DT or ACPI for this?
>
>--
>~Vinod

We choose to use private data, as pl330 already has  struct dma_pl330_platdata. 
Physically DMA share ACPI device with UART, however, BIOS believes DMA and UART is one device.
We can't  get irq share info from ACPI. And we don't use DT. 

Regards,
Annie





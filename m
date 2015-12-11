From: "Wang, Annie" <Annie.Wang@amd.com>
Subject: RE: [PATCH 3/9] ACPI: add struct acpi_amba_quirk for AMD pl330
 specific device config
Date: Fri, 11 Dec 2015 06:57:51 +0000
Message-ID: <BLUPR12MB04339648B98F07977B6FA61F81EA0@BLUPR12MB0433.namprd12.prod.outlook.com>
References: <1449199466-6081-1-git-send-email-annie.wang@amd.com>
 <1449199466-6081-4-git-send-email-annie.wang@amd.com>
 <20151204131619.GC11655@xora-haswell.xora.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20151204131619.GC11655@xora-haswell.xora.org.uk>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
To: Graeme Gregory <gg@slimlogic.co.uk>
Cc: Vinod Koul <vinod.koul@intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, Borislav Petkov <bp@alien8.de>, "Huang, Ray" <Ray.Huang@amd.com>, "Wan, Vincent" <Vincent.Wan@amd.com>, "Xue, Ken" <Ken.Xue@amd.com>, "Li, Tony" <Tony.Li@amd.com>
List-Id: linux-serial@vger.kernel.org

>-----Original Message-----
>From: Graeme Gregory [mailto:gg@slimlogic.co.uk]
>Sent: Friday, December 04, 2015 9:16 PM
>To: Wang, Annie
>Cc: Vinod Koul; Mika Westerberg; Joerg Roedel; Greg Kroah-Hartman; Rafael J.
>Wysocki; linux-acpi@vger.kernel.org; linux-kernel@vger.kernel.org; linux-
>serial@vger.kernel.org; dmaengine@vger.kernel.org; iommu@lists.linux-
>foundation.org; Borislav Petkov; Huang, Ray; Wan, Vincent; Xue, Ken; Li, Tony
>Subject: Re: [PATCH 3/9] ACPI: add struct acpi_amba_quirk for AMD pl330
>specific device config
>
>On Fri, Dec 04, 2015 at 11:24:20AM +0800, Wang Hongcheng wrote:
>> AMD pl330 is a UART DMA device, it shares one ACPI item with UART. So
>> a platform device and an acpi device will be created according to
>> AMD0020 ACPI dev. And its mem base address must have an offset. As a
>> result, MULTI_ATTACHED_QUIRK and MULTI_ATTACHED_QUIRK are used.
>>
>> Signed-off-by: Wang Hongcheng <annie.wang@amd.com>
>> ---
>>  drivers/acpi/acpi_amba.c | 31 +++++++++++++++++++++++----
>> drivers/acpi/acpi_apd.c  | 56 +++++++++++++++++++++++++++++++++++++------
>-----
>>  include/linux/acpi.h     | 13 +++++++++--
>>  3 files changed, 81 insertions(+), 19 deletions(-)
>>
>> diff --git a/drivers/acpi/acpi_amba.c b/drivers/acpi/acpi_amba.c index
>> 4f0366a..8a5269c 100644
>> --- a/drivers/acpi/acpi_amba.c
>> +++ b/drivers/acpi/acpi_amba.c
>> @@ -31,6 +31,8 @@ ACPI_MODULE_NAME("amba");
>>   * @periphid: AMBA device periphid.
>>   * @fixed_rate: Clock frequency.
>>   * @pdata: Platform data specific to the device.
>> + * @quirk: Specific device config, including device multiattach.
>> + * and mem base offset.
>>   *
>>   * Check if the given @adev can be represented as an AMBA device and, if
>>   * that's the case, create and register an AMBA device, populate its
>> @@ -42,7 +44,8 @@ ACPI_MODULE_NAME("amba");  struct amba_device
>> *acpi_create_amba_device(struct acpi_device *adev,
>>  					    unsigned int periphid,
>>  					    unsigned long fixed_rate,
>> -					    void *pdata)
>> +					    void *pdata,
>> +					    struct acpi_amba_quirk *quirk)
>>  {
>>  	struct amba_device *amba_dev = NULL;
>>  	struct device *parent;
>> @@ -54,12 +57,14 @@ struct amba_device *acpi_create_amba_device(struct
>acpi_device *adev,
>>  	unsigned int i;
>>  	unsigned int irq[AMBA_NR_IRQS];
>>  	struct clk *clk = ERR_PTR(-ENODEV);
>> +	char amba_devname[100];
>>
>>  	/*
>>  	 * If the ACPI node already has a physical device attached,
>> -	 * skip it.
>> +	 * skip it. Except some special devices such as AMD0020 which
>> +	 * needs attach physical devices two times.
>>  	 */
>> -	if (adev->physical_node_count)
>> +	if (adev->physical_node_count && !(quirk->quirk &
>> +MULTI_ATTACHED_QUIRK))
>>  		return NULL;
>>
>>  	INIT_LIST_HEAD(&resource_list);
>> @@ -85,7 +90,24 @@ struct amba_device *acpi_create_amba_device(struct
>acpi_device *adev,
>>  			memcpy(resource, rentry->res, sizeof(struct resource));
>>  	}
>>
>> -	amba_dev = amba_device_alloc(dev_name(&adev->dev),
>> +	/*
>> +	 * The memory address of AMD pl330 has an offset of ACPI
>> +	 * mem resource.
>> +	 */
>> +	if (quirk->quirk & BASE_OFFSET_QUIRK)
>> +		resource->start += quirk->base_offset;
>> +
>> +	/*
>> +	 * If the ACPI device already has a node attached. It must be
>> +	 * renamed.
>> +	 */
>> +	if (quirk->quirk & MULTI_ATTACHED_QUIRK)
>> +		sprintf(amba_devname, "%s%s", dev_name(&adev->dev),
>"DMA");
>> +	else
>> +		memcpy(amba_devname, dev_name(&adev->dev),
>> +		       strlen(dev_name(&adev->dev)));
>> +
>> +	amba_dev = amba_device_alloc(amba_devname,
>>  				     resource->start,
>>  				     resource_size(resource));
>>
>
>Isn't this basially an MFD in a rather odd fashion?
>
>I would have though having a device which just splits the resources then creates 2
>children would be a whole lot simpler?
>
>Graeme

It seems more complex, if I  trans an ACPI device to pdev, then attach 2 platform child nodes,
and create an amba device refer to one of the childs. Too many trans. 

Thanks,
Hongcheng(Annie)

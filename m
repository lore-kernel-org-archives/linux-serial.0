From: "Wang, Annie" <Annie.Wang@amd.com>
Subject: RE: [PATCH 3/6] ACPI: add 2 parameters to function acpi dma
 controller register
Date: Wed, 6 Jan 2016 06:46:37 +0000
Message-ID: <BLUPR12MB0433A702DB5903D6A20232B781F40@BLUPR12MB0433.namprd12.prod.outlook.com>
References: <1451885501-2710-1-git-send-email-annie.wang@amd.com>
 <1451885501-2710-4-git-send-email-annie.wang@amd.com>
 <20160104144534.GB1770@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20160104144534.GB1770@lahna.fi.intel.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>, Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Vinod Koul <vinod.koul@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>, Borislav Petkov <bp@alien8.de>, "Huang, Ray" <Ray.Huang@amd.com>, "Wan, Vincent" <Vincent.Wan@amd.com>, "Xue, Ken" <Ken.Xue@amd.com>, Robin Murphy <robin.murphy@arm.com>, Graeme Gregory <gg@slimlogic.co.uk>, "Li, Tony" <Tony.Li@amd.com>, "Yu, Xiangliang" <Xiangliang.Yu@amd.com>
List-Id: linux-serial@vger.kernel.org

Hi Mika,

>-----Original Message-----
>From: Mika Westerberg [mailto:mika.westerberg@linux.intel.com]
>Sent: Monday, January 04, 2016 10:46 PM
>To: Wang, Annie
>Cc: Andy Shevchenko; Vinod Koul; Greg Kroah-Hartman; Rafael J. Wysocki; linux-
>acpi@vger.kernel.org; linux-kernel@vger.kernel.org; linux-serial@vger.kernel.org;
>dmaengine@vger.kernel.org; Borislav Petkov; Huang, Ray; Wan, Vincent; Xue,
>Ken; Robin Murphy; Graeme Gregory; Li, Tony; Yu, Xiangliang
>Subject: Re: [PATCH 3/6] ACPI: add 2 parameters to function acpi dma controller
>register
>
>On Mon, Jan 04, 2016 at 01:31:38PM +0800, Wang Hongcheng wrote:
>> As CSRT table will not always work, 2 arguments, base_request_line and
>> num are added to acpi dma controller register as another way to get
>> device request line.
>>
>> Signed-off-by: Wang Hongcheng <annie.wang@amd.com>
>> ---
>>  drivers/dma/acpi-dma.c    | 25 ++++++++++++++++++++-----
>>  drivers/dma/dw/platform.c |  2 +-
>>  include/linux/acpi_dma.h  |  6 ++++++
>>  3 files changed, 27 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/dma/acpi-dma.c b/drivers/dma/acpi-dma.c index
>> 16d0daa..e2c27c3 100644
>> --- a/drivers/dma/acpi-dma.c
>> +++ b/drivers/dma/acpi-dma.c
>> @@ -105,7 +105,7 @@ static int acpi_dma_parse_resource_group(const struct
>acpi_csrt_group *grp,
>>   * We are using this table to get the request line range of the specific DMA
>>   * controller to be used later.
>>   */
>> -static void acpi_dma_parse_csrt(struct acpi_device *adev, struct
>> acpi_dma *adma)
>> +static int acpi_dma_parse_csrt(struct acpi_device *adev, struct
>> +acpi_dma *adma)
>>  {
>>  	struct acpi_csrt_group *grp, *end;
>>  	struct acpi_table_csrt *csrt;
>> @@ -117,7 +117,7 @@ static void acpi_dma_parse_csrt(struct acpi_device
>*adev, struct acpi_dma *adma)
>>  	if (ACPI_FAILURE(status)) {
>>  		if (status != AE_NOT_FOUND)
>>  			dev_warn(&adev->dev, "failed to get the CSRT table\n");
>> -		return;
>> +		return -ENOENT;
>>  	}
>>
>>  	grp = (struct acpi_csrt_group *)(csrt + 1); @@ -128,11 +128,12 @@
>> static void acpi_dma_parse_csrt(struct acpi_device *adev, struct acpi_dma
>*adma)
>>  		if (ret < 0) {
>>  			dev_warn(&adev->dev,
>>  				 "error in parsing resource group\n");
>> -			return;
>> +			return -EINVAL;
>>  		}
>>
>>  		grp = (struct acpi_csrt_group *)((void *)grp + grp->length);
>>  	}
>> +	return 0;
>>  }
>>
>>  /**
>> @@ -140,6 +141,8 @@ static void acpi_dma_parse_csrt(struct acpi_device
>*adev, struct acpi_dma *adma)
>>   * @dev:		struct device of DMA controller
>>   * @acpi_dma_xlate:	translation function which converts a dma specifier
>>   *			into a dma_chan structure
>> + * @base_request_line:  device request line base
>> + * @num:                device request line range
>>   * @data		pointer to controller specific data to be used by
>>   *			translation function
>>   *
>> @@ -152,10 +155,13 @@ static void acpi_dma_parse_csrt(struct
>> acpi_device *adev, struct acpi_dma *adma)  int
>acpi_dma_controller_register(struct device *dev,
>>  		struct dma_chan *(*acpi_dma_xlate)
>>  		(struct acpi_dma_spec *, struct acpi_dma *),
>> +		unsigned short base_request_line,
>> +		unsigned short num,
>>  		void *data)
>
>Can you instead provide custom acpi_dma_xlate when you register the DMA
>controller? That function can then use whatever translation scheme is suitable for
>your platform to get the correct channel.

Acpi_dma_xlate  mainly converts an  acpi_dma  structure into a dma_chan structure.
Without proper request line, wrong acpi_dma structure may be get. 

And as Andy says in http://article.gmane.org/gmane.linux.kernel.iommu/11675 
How about add a hook into acpi_dma_controller_register?

Regards,
Hongcheng (Annie)

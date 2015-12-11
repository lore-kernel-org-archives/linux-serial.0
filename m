From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH 4/9] dmaengine: pl330: add new items for pl330 private data
Date: Fri, 11 Dec 2015 15:56:38 +0200
Message-ID: <CAHp75Vf1pt5YvkxmwKGvJjjuJ9xF1y4M1XYEx_yGfUHpeA7iUA@mail.gmail.com>
References: <1449199466-6081-1-git-send-email-annie.wang@amd.com>
	<1449199466-6081-5-git-send-email-annie.wang@amd.com>
	<20151210040909.GM1854@localhost>
	<BLUPR12MB0433B81BB0AEB2D84505B55881E90@BLUPR12MB0433.namprd12.prod.outlook.com>
	<20151211092909.GW1854@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20151211092909.GW1854@localhost>
Sender: linux-acpi-owner@vger.kernel.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: "Wang, Annie" <Annie.Wang@amd.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, Borislav Petkov <bp@alien8.de>, "Huang, Ray" <Ray.Huang@amd.com>, "Wan, Vincent" <Vincent.Wan@amd.com>, "Xue, Ken" <Ken.Xue@amd.com>, "Li, Tony" <Tony.Li@amd.com>
List-Id: linux-serial@vger.kernel.org

On Fri, Dec 11, 2015 at 11:29 AM, Vinod Koul <vinod.koul@intel.com> wrote:
> On Thu, Dec 10, 2015 at 06:38:09AM +0000, Wang, Annie wrote:
>> >
>> >Why not DT or ACPI for this?
>> >
>> We choose to use private data, as pl330 already has  struct dma_pl330_platdata.
>> Physically DMA share ACPI device with UART, however, BIOS believes DMA and UART is one device.
>> We can't  get irq share info from ACPI. And we don't use DT.
>>
> That should be then a MFD device

And for me seems like acpi_amba and drivers shall utilize unified
device property API.

-- 
With Best Regards,
Andy Shevchenko

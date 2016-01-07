From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH 3/6] ACPI: add 2 parameters to function acpi dma
 controller register
Date: Thu, 7 Jan 2016 12:08:50 +0200
Message-ID: <CAHp75Vd6mWOy4qZk0uqHeurA5Mk4xX1qSSTa-fbWobCSpUo6zw@mail.gmail.com>
References: <1451885501-2710-1-git-send-email-annie.wang@amd.com>
	<1451885501-2710-4-git-send-email-annie.wang@amd.com>
	<20160104144534.GB1770@lahna.fi.intel.com>
	<BLUPR12MB0433A702DB5903D6A20232B781F40@BLUPR12MB0433.namprd12.prod.outlook.com>
	<20160107095238.GY1770@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160107095238.GY1770@lahna.fi.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: "Wang, Annie" <Annie.Wang@amd.com>, Vinod Koul <vinod.koul@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>, Borislav Petkov <bp@alien8.de>, "Huang, Ray" <Ray.Huang@amd.com>, "Wan, Vincent" <Vincent.Wan@amd.com>, "Xue, Ken" <Ken.Xue@amd.com>, Robin Murphy <robin.murphy@arm.com>, Graeme Gregory <gg@slimlogic.co.uk>, "Li, Tony" <Tony.Li@amd.com>, "Yu, Xiangliang" <Xiangliang.Yu@amd.com>
List-Id: linux-serial@vger.kernel.org

On Thu, Jan 7, 2016 at 11:52 AM, Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
> On Wed, Jan 06, 2016 at 06:46:37AM +0000, Wang, Annie wrote:
>> Acpi_dma_xlate  mainly converts an  acpi_dma  structure into a dma_chan structure.
>> Without proper request line, wrong acpi_dma structure may be get.
>>
>> And as Andy says in http://article.gmane.org/gmane.linux.kernel.iommu/11675
>> How about add a hook into acpi_dma_controller_register?
>
> Hmm, you can pass custom data in acpi_dma_controller_register() which
> will be assigned to adma->data. If you put your request line
> information there, I think your custom acpi_dma_xlate() should be able
> to use that information to find proper channel, no?

I like Mika's idea, so, please, go this way if there is no impediment.

-- 
With Best Regards,
Andy Shevchenko

From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH 8/9] Documentation: Add ivrs_acpihid kernel parameter
 description
Date: Fri, 4 Dec 2015 15:38:03 +0100
Message-ID: <20151204143803.GH21177@pd.tnic>
References: <1449199466-6081-1-git-send-email-annie.wang@amd.com>
 <1449199466-6081-9-git-send-email-annie.wang@amd.com>
 <20151204122149.GD21177@pd.tnic>
 <DM3PR1201MB10232DEAF03CAAE29D21FC1AE60C0@DM3PR1201MB1023.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <DM3PR1201MB10232DEAF03CAAE29D21FC1AE60C0@DM3PR1201MB1023.namprd12.prod.outlook.com>
Sender: linux-acpi-owner@vger.kernel.org
To: "Wan, Vincent" <Vincent.Wan@amd.com>
Cc: "Wang, Annie" <Annie.Wang@amd.com>, Vinod Koul <vinod.koul@intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "Huang, Ray" <Ray.Huang@amd.com>, "Xue, Ken" <Ken.Xue@amd.com>, "Li, Tony" <Tony.Li@amd.com>
List-Id: linux-serial@vger.kernel.org

On Fri, Dec 04, 2015 at 01:19:35PM +0000, Wan, Vincent wrote:
> > > +	ivrs_acpihid	[HW,X86_64]
> > > +			Provide an override to the ACPI-HID:UID<->DEVICE-ID
> > > +			mapping provided in the IVRS ACPI table. For
> > > +			example, to map UART-HID:UID AMD0020:0 to
> > > +			PCI device 00:14.5 write the parameter as:
> > > +				ivrs_acpihid[00:14.5]=AMD0020:0
> > 
> > What is that parameter needed for? Can't you deduce the mapping from the
> > hardware?
> 
> It is very like ivrs_ioapic/ ivrs_hpet, which can override the dedicated BDF id mapped to HID:UID that was reported from BIOS's IVHD entry.
> If BIOS did not report a right BDF, we can resort to this parameter to correct it.

Please add a verbose, human-readable explanation to the text so that
people know what it is for. The text above is hard to parse even for
insiders.

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.

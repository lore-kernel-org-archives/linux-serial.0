From: Huang Rui <ray.huang@amd.com>
Subject: Re: [PATCH 1/9] ACPI: Add support for AMBA bus type
Date: Fri, 4 Dec 2015 18:20:13 +0800
Message-ID: <20151204102012.GA6789@hr-amur2>
References: <1449199466-6081-1-git-send-email-annie.wang@amd.com>
 <1449199466-6081-2-git-send-email-annie.wang@amd.com>
 <20151204085023.GE1593@lahna.fi.intel.com>
 <20151204091738.GA6572@hr-amur2>
 <56616021.3050704@huawei.com>
 <CAGCh1+mteHUM-MPjxhgu_sXbBQdz1fLAfAHYOo9rp-cxyt8dkw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAGCh1+mteHUM-MPjxhgu_sXbBQdz1fLAfAHYOo9rp-cxyt8dkw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: G Gregory <graeme.gregory@linaro.org>
Cc: Hanjun Guo <guohanjun@huawei.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Wang Hongcheng <annie.wang@amd.com>, Vinod Koul <vinod.koul@intel.com>, Joerg Roedel <joro@8bytes.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-serial@vger.kernel.org, dmaengine@vger.kernel.org, iommu@lists.linux-foundation.org, Borislav Petkov <bp@alien8.de>, Wan Zongshun <vincent.wan@amd.com>, Ken Xue <ken.xue@amd.com>, Tony Li <tony.li@amd.com>
List-Id: linux-serial@vger.kernel.org

On Fri, Dec 04, 2015 at 09:59:28AM +0000, G Gregory wrote:
> On 4 December 2015 at 09:42, Hanjun Guo <guohanjun@huawei.com> wrote:
> > On 2015/12/4 17:17, Huang Rui wrote:
> >> On Fri, Dec 04, 2015 at 10:50:23AM +0200, Mika Westerberg wrote:
> >>> On Fri, Dec 04, 2015 at 11:24:18AM +0800, Wang Hongcheng wrote:
> >>>> From: Huang Rui <ray.huang@amd.com>
> >>>>
> >>>> Inspired by acpi platform bus type, to make driver "porting" more
> >>>> straightforward, this patch introduces ACPI support to the AMBA bus
> >>>> type. Instead of writing ACPI "glue" drivers for the exiting AMBA
> >>>> drivers.
> >>> Hmm, isn't there already similar patch series bringing AMBA ACPI
> >>> support?
> >>>
> >>> https://lkml.org/lkml/2015/9/30/394
> >> Err, I see the patch for the first time...
> >>
> >> But looks like it isn't accepted till now. Will he continue to work on
> >> it?
> >
> > Sure, Graeme is working on the updated version now :)
> >
> Yes, as Hanjun said I am planning a v2. I've just been caught up in
> other business this week and probably next week.
> 

OK, thanks to clarify it. Could you please take care of AMD use case
that we need a configurable fix_rate clk, periphid, and platform data?

Thanks,
Rui

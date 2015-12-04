From: G Gregory <graeme.gregory@linaro.org>
Subject: Re: [PATCH 1/9] ACPI: Add support for AMBA bus type
Date: Fri, 4 Dec 2015 09:59:28 +0000
Message-ID: <CAGCh1+mteHUM-MPjxhgu_sXbBQdz1fLAfAHYOo9rp-cxyt8dkw@mail.gmail.com>
References: <1449199466-6081-1-git-send-email-annie.wang@amd.com>
	<1449199466-6081-2-git-send-email-annie.wang@amd.com>
	<20151204085023.GE1593@lahna.fi.intel.com>
	<20151204091738.GA6572@hr-amur2>
	<56616021.3050704@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <56616021.3050704@huawei.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Hanjun Guo <guohanjun@huawei.com>
Cc: Huang Rui <ray.huang@amd.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Wang Hongcheng <annie.wang@amd.com>, Vinod Koul <vinod.koul@intel.com>, Joerg Roedel <joro@8bytes.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-serial@vger.kernel.org, dmaengine@vger.kernel.org, iommu@lists.linux-foundation.org, Borislav Petkov <bp@alien8.de>, Wan Zongshun <vincent.wan@amd.com>, Ken Xue <ken.xue@amd.com>, Tony Li <tony.li@amd.com>
List-Id: linux-serial@vger.kernel.org

On 4 December 2015 at 09:42, Hanjun Guo <guohanjun@huawei.com> wrote:
> On 2015/12/4 17:17, Huang Rui wrote:
>> On Fri, Dec 04, 2015 at 10:50:23AM +0200, Mika Westerberg wrote:
>>> On Fri, Dec 04, 2015 at 11:24:18AM +0800, Wang Hongcheng wrote:
>>>> From: Huang Rui <ray.huang@amd.com>
>>>>
>>>> Inspired by acpi platform bus type, to make driver "porting" more
>>>> straightforward, this patch introduces ACPI support to the AMBA bus
>>>> type. Instead of writing ACPI "glue" drivers for the exiting AMBA
>>>> drivers.
>>> Hmm, isn't there already similar patch series bringing AMBA ACPI
>>> support?
>>>
>>> https://lkml.org/lkml/2015/9/30/394
>> Err, I see the patch for the first time...
>>
>> But looks like it isn't accepted till now. Will he continue to work on
>> it?
>
> Sure, Graeme is working on the updated version now :)
>
Yes, as Hanjun said I am planning a v2. I've just been caught up in
other business this week and probably next week.

Graeme

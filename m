From: Hanjun Guo <guohanjun@huawei.com>
Subject: Re: [PATCH 1/9] ACPI: Add support for AMBA bus type
Date: Fri, 4 Dec 2015 17:42:57 +0800
Message-ID: <56616021.3050704@huawei.com>
References: <1449199466-6081-1-git-send-email-annie.wang@amd.com> <1449199466-6081-2-git-send-email-annie.wang@amd.com> <20151204085023.GE1593@lahna.fi.intel.com> <20151204091738.GA6572@hr-amur2>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20151204091738.GA6572@hr-amur2>
Sender: linux-acpi-owner@vger.kernel.org
To: Huang Rui <ray.huang@amd.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Graeme Gregory <graeme.gregory@linaro.org>
Cc: Wang Hongcheng <annie.wang@amd.com>, Vinod Koul <vinod.koul@intel.com>, Joerg Roedel <joro@8bytes.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, dmaengine@vger.kernel.org, iommu@lists.linux-foundation.org, Borislav Petkov <bp@alien8.de>, Wan Zongshun <vincent.wan@amd.com>, Ken Xue <ken.xue@amd.com>, Tony Li <tony.li@amd.com>
List-Id: linux-serial@vger.kernel.org

On 2015/12/4 17:17, Huang Rui wrote:
> On Fri, Dec 04, 2015 at 10:50:23AM +0200, Mika Westerberg wrote:
>> On Fri, Dec 04, 2015 at 11:24:18AM +0800, Wang Hongcheng wrote:
>>> From: Huang Rui <ray.huang@amd.com>
>>>
>>> Inspired by acpi platform bus type, to make driver "porting" more
>>> straightforward, this patch introduces ACPI support to the AMBA bus
>>> type. Instead of writing ACPI "glue" drivers for the exiting AMBA
>>> drivers.
>> Hmm, isn't there already similar patch series bringing AMBA ACPI
>> support?
>>
>> https://lkml.org/lkml/2015/9/30/394
> Err, I see the patch for the first time...
>
> But looks like it isn't accepted till now. Will he continue to work on
> it?

Sure, Graeme is working on the updated version now :)

Thanks
Hanjun


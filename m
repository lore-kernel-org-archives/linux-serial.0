From: John Garry <john.garry@huawei.com>
Subject: Re: [RFC PATCH 0/2] serial: 8250_dw: IO space + polling mode support
Date: Thu, 12 Apr 2018 17:31:13 +0100
Message-ID: <aad35699-393a-80dc-d088-f749cfa284c8@huawei.com>
References: <1519324923-196857-1-git-send-email-john.garry@huawei.com>
 <1519381801.10722.103.camel@linux.intel.com>
 <3c4c5f58-a661-13c8-cc1c-8d43828982cb@huawei.com>
 <1519407117.10722.124.camel@linux.intel.com>
 <88214a3e-82cc-c931-804c-7dc90fb8721f@huawei.com>
 <1519638828.10722.153.camel@linux.intel.com>
 <7221877b-a84a-63a1-ef86-1991f358df72@huawei.com>
 <1519644517.10722.179.camel@linux.intel.com>
 <b5904a5a-66d8-4385-cc5b-a52529e9d28f@huawei.com>
 <1519647669.10722.184.camel@linux.intel.com>
 <1519648063.10722.185.camel@linux.intel.com>
 <22270a6a-44fb-d2ad-d6d3-3d301bdde26e@huawei.com>
 <1519657365.10722.187.camel@linux.intel.com>
 <98039a90-cbf2-6d76-bdb5-56c8e83f6470@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <98039a90-cbf2-6d76-bdb5-56c8e83f6470@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: gregkh@linuxfoundation.org, jslaby@suse.com, p.zabel@pengutronix.de, heiko@sntech.de, ed.blake@sondrel.com, jhogan@kernel.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, linuxarm@huawei.com
List-Id: linux-serial@vger.kernel.org

On 26/02/2018 15:07, John Garry wrote:
> On 26/02/2018 15:02, Andy Shevchenko wrote:
>> On Mon, 2018-02-26 at 13:15 +0000, John Garry wrote:
>>> On 26/02/2018 12:27, Andy Shevchenko wrote:
>>>> On Mon, 2018-02-26 at 14:21 +0200, Andy Shevchenko wrote:
>>>>> On Mon, 2018-02-26 at 11:56 +0000, John Garry wrote:
>>>>
>>>>
>>>>>>    Device (LPC0.CON0) {
>>>>>>      Name (_HID, "HISI1031")
>>>>>>      // Name (_CID, "PNP0501") // cannot support PNP
>>>>
>>>>
>>>> One more question. What is the problem with this CID? Do you have a
>>>> race
>>>> condition in enumeration?
>>>>
>>>
>>> Hi Andy,
>>>
>>> Not sure if race condition exactly. I tried enabling this CID and a
>>> pnp
>>> device is created in pnpacpi_add_device_handler(), while we have
>>> already
>>> marked the corresponding acpi_device to skip enumeration in ACPI scan
>>> handler (by flagging it as a serial bus slave).
>>
>> Is that code already in upstream?
>
> No, not yet.
>
>>
>> If no, please, Cc next version to me and possible Mika.
>
> Of course. I should be sending it later today.
>

Hi Andy,

A while ago we discussed on this thread the possibility of adding 
generic 8250 IO space platform driver support for ACPI FW.

In this discussion I mentioned that we require specifically platform 
device support, and not PNP device support, as this is how we enumerate 
the devices in the host controller driver. I think you're familiar with 
this driver - here is the thread posting for reference: 
https://lkml.org/lkml/2018/3/6/230

I would say that there were 2 main takeaway points:
a. for 8250-compatible UART, we should use a PNP driver for ACPI FW
b. you prefered us to change the host driver to use an ACPI handler approach

For b., I was not keen as we already did try the handler in the ACPI 
core code, but this was not so welcome. Reasoning here: 
https://lkml.org/lkml/2018/2/14/532

I did also say that I would prefer not to change approach after a very 
long upstream effort, with no clear end in sight.

However do you have an idea on creating a PNP device in a.? That is, 
enumerate (create) a 8250 PNP device.

If you look at the least driver here:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/bus/hisi_lpc.c

We could have this working with a change in the ACPI probe code, like in 
this code snippet:

list_for_each_entry(child, &adev->children, node) {
	struct resource_entry *rentry;
	LIST_HEAD(resource_list);
         int rc;

         if (!acpi_is_pnp_device(child))
             continue;

         acpi_dev_get_resources(child, &resource_list, NULL, NULL);

         list_for_each_entry(rentry, &resource_list, node) {
             struct resource *res = rentry->res;

             if (res->flags | IORESOURCE_IO)
                 hisi_lpc_acpi_xlat_io_res(child, adev, res); /* bad */
         }
         rc = pnpacpi_add_device(child);
         if (rc)
             return rc;
}

Obviously this is not sound as we should not modify the child 
acpi_device resources.

Alternatively, as another approach, I could copy the relevant code 
pnpacpi_add_device() verbatim into this above code, and xlat the 
resource of the PNP device, but it's not good to copy the code like.

Any other ideas?

All the best,
John

>>
> All the best,
> John

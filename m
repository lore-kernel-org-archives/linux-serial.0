From: Alexander Graf <agraf-l3A5Bk7waGM@public.gmane.org>
Subject: Re: [PATCH V6 4/5] LPC: Support the device-tree LPC host on
 Hip06/Hip07
Date: Wed, 15 Feb 2017 12:53:30 +0100
Message-ID: <acc432d9-f021-4eba-b48b-a8d0b4de1f78@suse.de>
References: <1485241525-201782-1-git-send-email-yuanzhichang@hisilicon.com>
 <1485241525-201782-5-git-send-email-yuanzhichang@hisilicon.com>
 <a5a24e73-013d-87b5-f65f-324417f4cc60@suse.de>
 <58A1C50F.7090108@hisilicon.com>
 <43b981bc-72c0-c6e7-d6f6-9ba9c63d9bdb@suse.de>
 <58A43D02.9040502@hisilicon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <58A43D02.9040502-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "zhichang.yuan" <yuanzhichang-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>, catalin.marinas-5wv7dgnIgG8@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, rafael-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, brian.starkey-5wv7dgnIgG8@public.gmane.org, olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org, benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linuxarm-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, minyard-HInyCGIudOg@public.gmane.org, liviu.dudau-5wv7dgnIgG8@public.gmane.org, zourongrong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, john.garry-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, gabriele.paoloni-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, zhichang.yuan02-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, kantyzc-9Onoh4P/yGk@public.gmane.org, xuwei5-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org, "Daode Huang(allen)" <huangdaode-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>
List-Id: linux-serial@vger.kernel.org



On 15/02/2017 12:35, zhichang.yuan wrote:
> Hi, Alex,
>
>
> On 2017/2/14 21:29, Alexander Graf wrote:
>>
>>
>> On 13/02/2017 15:39, zhichang.yuan wrote:
>>> Hi, Alex,
>>>
>>> Thanks for your review!
>>>
>>> John had replied most of your comments, I only mentioned those which haven't made clear.
>>>
>>>
>>> On 2017/1/31 4:08, Alexander Graf wrote:
>>>>
>>>>
>>>> On 24/01/2017 08:05, zhichang.yuan wrote:
>>>>> The low-pin-count(LPC) interface of Hip06/Hip07 accesses the peripherals in
>>>>> I/O port addresses. This patch implements the LPC host controller driver which
>>>>> perform the I/O operations on the underlying hardware.
>>>>> We don't want to touch those existing peripherals' driver, such as ipmi-bt. So
>>>>> this driver applies the indirect-IO introduced in the previous patch after
>>>>> registering an indirect-IO node to the indirect-IO devices list which will be
>>>>> searched in the I/O accessors.
>>>>> As the I/O translations for LPC children depend on the host I/O registration,
>>>>> we should ensure the host I/O registration is finished before all the LPC
>>>>> children scanning. That is why an arch_init() hook was added in this patch.
>>>>>
>>>>> Signed-off-by: zhichang.yuan <yuanzhichang-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>
>>>>> Signed-off-by: Gabriele Paoloni <gabriele.paoloni-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
>>>>> ---
> snip
>>>>> +
>>>>> +struct lpc_cycle_para {
>>>>> +    unsigned int opflags;
>>>>> +    unsigned int csize; /* the data length of each operation */
>>>>> +};
>>>>> +
>>>>> +struct hisilpc_dev {
>>>>> +    spinlock_t cycle_lock;
>>>>> +    void __iomem  *membase;
>>>>> +    struct extio_node *extio;
>>>>> +};
>>>>> +
>>>>> +/* bounds of the LPC bus address range */
>>>>> +#define LPC_MIN_BUS_RANGE    0x0
>>>>> +
>>>>> +/*
>>>>> + * The maximal IO size for each leagcy bus.
>>>>
>>>> legacy?
>>>>
>>>> I don't really understand why this bus is legacy though. It looks like a simple MMIO-to-LPC bridge to me.
>>>
>>> yes. The LPC bus is MMIO-to-LPC bridge.
>>> My comment is not clear.
>>>
>>> How about "The maximal IO size of LPC bus"?
>>
>> That sounds better, but doesn't really tell me what it's about yet ;).
>>
>>>
>>>>
>>>>> + * The port size of legacy I/O devices is normally less than 0x400.
>>>>> + * Defining the I/O range size as 0x400 here should be sufficient for
>>>>> + * all peripherals under one bus.
>>>>> + */
>>>>
>>>> This comment doesn't make a lot of sense. What is the limit? Is there a hardware limit?
>>>>
>>>> We don't dynamically allocate devices on the lpc bus, so why imply a limit at all?
>>>
>>> The limit here is to define an IO window for LPC.
>>> It is not acceptable to describe the IO window with 'ranges' property in LPC host node, so we choose a fixable upper IO limit
>>> for the static LPC IO space. Without this, LPC can't register its IO space through extio helpers.
>>>
>>> Why 0x400 is chosen? For our LPC, 0x400 cover all the peripherals under the LPC.
>>
>> This is information that should come from firmware then. Whether by coincidence addresses 0x0 - 0x400 include all devices is an implementation detail that the driver shouldn't have to know about.
>
>
>>
>> That said, as mentioned elsewhere, we don't need to define single windows at all. Instead, can't we just do it like PCI BARs and declare all PIO regions we get from firmware as readily allocated? Then we only need to explicitly assign ports 0x80, 0x81, 0x99, etc to the LPC bridge and leave the rest for grabs (by PCI hotplug for example)
>>
>
> I worry I don't completely catch your idea.
> From my understanding, each PCI host can parse its resource windows from firmware(such as ACPI, dts). But for our LPC, firmware configurations only tell kernel what is the IO resource of the peripherals under LPC. But to register the io range in the similar way of pci_register_io_range(), at least, we need to know the IO range size.
> So, how to know this?
> There is no similar BAR design in LPC, do we traverse all the peripherals to calculate that?

Yes, that's probably the most flexible approach. In fact, I would just 
traverse all peripherals (or have peripherals call register functions 
for PIO regions) and then dynamically allocate the PIO space for only 
those regions. I don't see why you should only have 1 window for your 
LPC bridge.

Alternatively you could just have firmware indicate the region size, 
similar to how it's done for PCI. Whatever you do, don't hard code it in 
the driver :).

>
>
>>>
>>>
>>>
>>>
>>>>
>>>>> +#define LPC_BUS_IO_SIZE        0x400
>>>>> +
>>>>> +/* The maximum continuous operations */
>>>>> +#define LPC_MAX_OPCNT    16
>>>>> +/* only support IO data unit length is four at maximum */
>>>>> +#define LPC_MAX_DULEN    4
> snip
>>>>> + */
>>>>> +static int
>>>>> +hisilpc_target_in(struct hisilpc_dev *lpcdev, struct lpc_cycle_para *para,
>>>>> +          unsigned long ptaddr, unsigned char *buf,
>>>>> +          unsigned long opcnt)
>>>>> +{
>>>>> +    unsigned long cnt_per_trans;
>>>>> +    unsigned int cmd_word;
>>>>> +    unsigned int waitcnt;
>>>>> +    int ret;
>>>>> +
>>>>> +    if (!buf || !opcnt || !para || !para->csize || !lpcdev)
>>>>> +        return -EINVAL;
>>>>> +
>>>>> +    if (opcnt  > LPC_MAX_OPCNT)
>>>>> +        return -EINVAL;
>>>>> +
>>>>> +    cmd_word = LPC_CMD_TYPE_IO | LPC_CMD_READ;
>>>>> +    waitcnt = LPC_PEROP_WAITCNT;
>>>>> +    if (!(para->opflags & FG_INCRADDR_LPC)) {
>>>>> +        cmd_word |= LPC_CMD_SAMEADDR;
>>>>> +        waitcnt = LPC_MAX_WAITCNT;
>>>>> +    }
>>>>> +
>>>>> +    ret = 0;
>>>>> +    cnt_per_trans = (para->csize == 1) ? opcnt : para->csize;
>>>>> +    for (; opcnt && !ret; cnt_per_trans = para->csize) {
>>>>> +        unsigned long flags;
>>>>> +
>>>>> +        /* whole operation must be atomic */
>>>>> +        spin_lock_irqsave(&lpcdev->cycle_lock, flags);
>>>>
>>>> Ouch. This is going to kill your RT jitter. Is there no better way?
>>>
>>> I think there is no other choices. We have to ensure the I/O cycles triggered in serial mode....
>>
>> As nobody else accesses the LPC device in the meantime thanks to the lock, you don't need to disable interrupts, right?
>
> O. Do you mean that we can replace spin_lock_irqsave with spin_lock?

That would be a good step into the right direction I think, yes.

> As we can connect UART to LPC, I worry the LPC can be accessed in the interrupt context.

In that case IRQs are already disabled for the non-preempt-rt case and 
in preempt-rt, interrupt context should mostly live in threads which are 
preemptible again.


Alex
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

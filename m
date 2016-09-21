From: zhichang <zhichang.yuan02@gmail.com>
Subject: Re: [PATCH V3 1/4] ARM64 LPC: Indirect ISA port IO introduced
Date: Wed, 21 Sep 2016 17:26:06 +0800
Message-ID: <c6fe6d43-5e8b-ee88-a328-83d998b51c5a@gmail.com>
References: <1473855354-150093-1-git-send-email-yuanzhichang@hisilicon.com>
 <8337589.pzGt0MZ9xn@wuerfel> <57D95BBC.9030405@hisilicon.com>
 <5264074.nuyDhEuOR4@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5264074.nuyDhEuOR4@wuerfel>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, "zhichang.yuan" <yuanzhichang@hisilicon.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linuxarm@huawei.com, devicetree@vger.kernel.org, lorenzo.pieralisi@arm.com, benh@kernel.crashing.org, minyard@acm.org, linux-pci@vger.kernel.org, gabriele.paoloni@huawei.com, john.garry@huawei.com, will.deacon@arm.com, xuwei5@hisilicon.com, linux-serial@vger.kernel.org, gregkh@linuxfoundation.org, zourongrong@gmail.com, liviu.dudau@arm.com, kantyzc@163.com
List-Id: linux-serial@vger.kernel.org

Hi, Arnd,


On 2016年09月14日 22:23, Arnd Bergmann wrote:
> On Wednesday, September 14, 2016 10:16:28 PM CEST zhichang.yuan wrote:
>>>
>>> No need to guard includes with an #ifdef.
>> If remove #ifdef here, extio.h should not contain any function external declarations whose definitions are in
>> extio.c compiled only when CONFIG_ARM64_INDIRECT_PIO is yes.
>  
> There is no problem with making declarations visible for functions that
> are not part of the kernel, we do that all the time.
> 
>>>> +#define BUILDS_RW(bwl, type)                                                \
>>>> +static inline void reads##bwl(const volatile void __iomem *addr,    \
>>>> +                            void *buffer, unsigned int count)       \
>>>> +{                                                                   \
>>>> +    if (count) {                                                    \
>>>> +            type *buf = buffer;                                     \
>>>> +                                                                    \
>>>> +            do {                                                    \
>>>> +                    type x = __raw_read##bwl(addr);                 \
>>>> +                    *buf++ = x;                                     \
>>>> +            } while (--count);                                      \
>>>> +    }                                                               \
>>>> +}                                                                   \
>>>> +                                                                    \
>>>> +static inline void writes##bwl(volatile void __iomem *addr,         \
>>>> +                            const void *buffer, unsigned int count) \
>>>> +{                                                                   \
>>>> +    if (count) {                                                    \
>>>> +            const type *buf = buffer;                               \
>>>> +                                                                    \
>>>> +            do {                                                    \
>>>> +                    __raw_write##bwl(*buf++, addr);                 \
>>>> +            } while (--count);                                      \
>>>> +    }                                                               \
>>>> +}
>>>> +
>>>> +BUILDS_RW(b, u8)
>>>
>>> Why is this in here?
>> the readsb/writesb are defined in asm-generic/io.h which is included later, but the redefined insb/outsb need
>> to call them. Without these readsb/writesb definition before insb/outsb redefined, compile error occur.
>>
>> It seems that copy all the definitions of "asm-generic/io.h" is not a good idea, so I move the definitions of
>> those function needed here....
>>
>> Ok. I think your idea below defining in(s)/out(s) in a c file can solve this issue.
>>
>> #ifdef CONFIG_ARM64_INDIRECT_PIO
>> #define inb inb
>> extern u8 inb(unsigned long addr);
>>
>> #define outb outb
>> extern void outb(u8 value, unsigned long addr);
>>
>> #define insb insb
>> extern void insb(unsigned long addr, void *buffer, unsigned int count);
>>
>> #define outsb outsb
>> extern void outsb(unsigned long addr, const void *buffer, unsigned int count);
>> #endif
>>
>> and definitions of all these functions are in extio.c :
>>
>> u8 inb(unsigned long addr)
>> {
>>         if (!arm64_extio_ops || arm64_extio_ops->start > addr ||
>>                         arm64_extio_ops->end < addr)
>>                 return readb(PCI_IOBASE + addr);
>>         else
>>                 return arm64_extio_ops->pfin ?
>>                         arm64_extio_ops->pfin(arm64_extio_ops->devpara,
>>                                 addr + arm64_extio_ops->ptoffset, NULL,
>>                                 sizeof(u8), 1) : -1;
>> }
>> .....
> 
> Yes, sounds good.
> 
>>>> @@ -149,6 +185,60 @@ static inline u64 __raw_readq(const volatile void __iomem *addr)
>>>>  #define IO_SPACE_LIMIT              (PCI_IO_SIZE - 1)
>>>>  #define PCI_IOBASE          ((void __iomem *)PCI_IO_START)
>>>>  
>>>> +
>>>> +/*
>>>> + * redefine the in(s)b/out(s)b for indirect-IO.
>>>> + */
>>>> +#define inb inb
>>>> +static inline u8 inb(unsigned long addr)
>>>> +{
>>>> +#ifdef CONFIG_ARM64_INDIRECT_PIO
>>>> +    if (arm64_extio_ops && arm64_extio_ops->start <= addr &&
>>>> +                    addr <= arm64_extio_ops->end)
>>>> +            return extio_inb(addr);
>>>> +#endif
>>>> +    return readb(PCI_IOBASE + addr);
>>>> +}
>>>> +
>>>
>>> Looks ok, but you only seem to do this for the 8-bit
>>> accessors, when it should be done for 16-bit and 32-bit
>>> ones as well for consistency.
>> Hip06 LPC only support 8-bit I/O operations on the designated port.
> 
> That is an interesting limitation. Maybe still call the extio operations
> and have them do WARN_ON_ONCE() instead?
> 
> If you get a driver that calls inw/outw on the range that is owned
> by the LPC bus, you otherwise get an unhandled page fault in kernel
> space, which is not as nice.

As for this issue, I provided a wrong reply in the last email.
After double-checking with SoC guys, the inw(l)/outw(l) are OK with multiple 8-bit transfers to consecutive
I/O addresses.

Sorry for the wrong information!
Will support inw(l)/outw(l) in V4.

Best,
Zhichang


> 
>>>> diff --git a/drivers/bus/extio.c b/drivers/bus/extio.c
>>>> new file mode 100644
>>>> index 0000000..1e7a9c5
>>>> --- /dev/null
>>>> +++ b/drivers/bus/extio.c
>>>> @@ -0,0 +1,66 @@
>>>
>>> This is in a globally visible directory
>>>
>>>> +
>>>> +struct extio_ops *arm64_extio_ops;
>>>
>>> But the identifier uses an architecture specific prefix. Either
>>> move the whole file into arch/arm64, or make the naming so that
>>> it can be used for everything.
>>
>> I perfer to move the whole file into arch/arm64, extio.h will be moved to arch/arm64/include/asm;
> 
> Ok, that simplifies it a lot, you can just do everything in asm/io.h then.
> 
> 	Arnd
> 

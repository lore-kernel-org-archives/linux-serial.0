From: "zhichang.yuan" <yuanzhichang-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>
Subject: Re: [PATCH V3 1/4] ARM64 LPC: Indirect ISA port IO introduced
Date: Wed, 14 Sep 2016 22:16:28 +0800
Message-ID: <57D95BBC.9030405@hisilicon.com>
References: <1473855354-150093-1-git-send-email-yuanzhichang@hisilicon.com>
 <1473855354-150093-2-git-send-email-yuanzhichang@hisilicon.com>
 <8337589.pzGt0MZ9xn@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <8337589.pzGt0MZ9xn@wuerfel>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linuxarm-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org, benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org, minyard-HInyCGIudOg@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, gabriele.paoloni-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, john.garry-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, xuwei5-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, zourongrong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, liviu.dudau-5wv7dgnIgG8@public.gmane.org, kantyzc-9Onoh4P/yGk@public.gmane.org, zhichang.yuan02-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: linux-serial@vger.kernel.org

Hi, Arnd

On 2016/9/14 20:24, Arnd Bergmann wrote:
> On Wednesday, September 14, 2016 8:15:51 PM CEST Zhichang Yuan wrote:
>> From: "zhichang.yuan" <yuanzhichang-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>
>>
>> For arm64, there is no I/O space as other architectural platforms, such as
>> X86. Most I/O accesses are achieved based on MMIO. But for some arm64 SoCs,
>> such as Hip06, when accessing some legacy ISA devices connected to LPC, those
>> known port addresses are used to control the corresponding target devices, for
>> example, 0x2f8 is for UART, 0xe4 is for ipmi-bt. It is different from the
>> normal MMIO mode in using.
>>
>> To drive these devices, this patch introduces a method named indirect-IO.
>> In this method the in/out pair in arch/arm64/include/asm/io.h will be
>> redefined. When upper layer drivers call in/out with those known legacy port
>> addresses to access the peripherals, the hooking functions corrresponding to
>> those target peripherals will be called. Through this way, those upper layer
>> drivers which depend on in/out can run on Hip06 without any changes.
>>
>> Signed-off-by: zhichang.yuan <yuanzhichang-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>
> 
> Looks ok overall, but I have a couple of comments for details.
> 
>> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
>> index bc3f00f..9579479 100644
>> --- a/arch/arm64/Kconfig
>> +++ b/arch/arm64/Kconfig
>> @@ -161,6 +161,12 @@ config ARCH_MMAP_RND_COMPAT_BITS_MIN
>>  config ARCH_MMAP_RND_COMPAT_BITS_MAX
>>         default 16
>>  
>> +config ARM64_INDIRECT_PIO
>> +	def_bool n
> 
> 'def_bool n' is the same as the shorter and more common 'bool'.
Yes. Will modify as bool "access peripherals with legacy I/O port"

> 
>> diff --git a/arch/arm64/include/asm/io.h b/arch/arm64/include/asm/io.h
>> index 9b6e408..d3acf1f 100644
>> --- a/arch/arm64/include/asm/io.h
>> +++ b/arch/arm64/include/asm/io.h
>> @@ -34,6 +34,10 @@
>>  
>>  #include <xen/xen.h>
>>  
>> +#ifdef CONFIG_ARM64_INDIRECT_PIO
>> +#include <linux/extio.h>
>> +#endif
> 
> No need to guard includes with an #ifdef.
If remove #ifdef here, extio.h should not contain any function external declarations whose definitions are in
extio.c compiled only when CONFIG_ARM64_INDIRECT_PIO is yes.


How about removing everything about the configure item "ARM64_INDIRECT_PIO"?
This will make the indirect-IO mechanism global on ARM64.
I worry about this mechanism is not so common, so using "ARM64_INDIRECT_PIO" make this feature optional.

> 
>> +#define BUILDS_RW(bwl, type)						\
>> +static inline void reads##bwl(const volatile void __iomem *addr,	\
>> +				void *buffer, unsigned int count)	\
>> +{									\
>> +	if (count) {							\
>> +		type *buf = buffer;					\
>> +									\
>> +		do {							\
>> +			type x = __raw_read##bwl(addr);			\
>> +			*buf++ = x;					\
>> +		} while (--count);					\
>> +	}								\
>> +}									\
>> +									\
>> +static inline void writes##bwl(volatile void __iomem *addr,		\
>> +				const void *buffer, unsigned int count)	\
>> +{									\
>> +	if (count) {							\
>> +		const type *buf = buffer;				\
>> +									\
>> +		do {							\
>> +			__raw_write##bwl(*buf++, addr);			\
>> +		} while (--count);					\
>> +	}								\
>> +}
>> +
>> +BUILDS_RW(b, u8)
> 
> Why is this in here?
the readsb/writesb are defined in asm-generic/io.h which is included later, but the redefined insb/outsb need
to call them. Without these readsb/writesb definition before insb/outsb redefined, compile error occur.

It seems that copy all the definitions of "asm-generic/io.h" is not a good idea, so I move the definitions of
those function needed here....

Ok. I think your idea below defining in(s)/out(s) in a c file can solve this issue.

#ifdef CONFIG_ARM64_INDIRECT_PIO
#define inb inb
extern u8 inb(unsigned long addr);

#define outb outb
extern void outb(u8 value, unsigned long addr);

#define insb insb
extern void insb(unsigned long addr, void *buffer, unsigned int count);

#define outsb outsb
extern void outsb(unsigned long addr, const void *buffer, unsigned int count);
#endif

and definitions of all these functions are in extio.c :

u8 inb(unsigned long addr)
{
	if (!arm64_extio_ops || arm64_extio_ops->start > addr ||
			arm64_extio_ops->end < addr)
		return readb(PCI_IOBASE + addr);
	else
		return arm64_extio_ops->pfin ?
			arm64_extio_ops->pfin(arm64_extio_ops->devpara,
				addr + arm64_extio_ops->ptoffset, NULL,
				sizeof(u8), 1) : -1;
}
.....


> 
>> @@ -149,6 +185,60 @@ static inline u64 __raw_readq(const volatile void __iomem *addr)
>>  #define IO_SPACE_LIMIT		(PCI_IO_SIZE - 1)
>>  #define PCI_IOBASE		((void __iomem *)PCI_IO_START)
>>  
>> +
>> +/*
>> + * redefine the in(s)b/out(s)b for indirect-IO.
>> + */
>> +#define inb inb
>> +static inline u8 inb(unsigned long addr)
>> +{
>> +#ifdef CONFIG_ARM64_INDIRECT_PIO
>> +	if (arm64_extio_ops && arm64_extio_ops->start <= addr &&
>> +			addr <= arm64_extio_ops->end)
>> +		return extio_inb(addr);
>> +#endif
>> +	return readb(PCI_IOBASE + addr);
>> +}
>> +
> 
> Looks ok, but you only seem to do this for the 8-bit
> accessors, when it should be done for 16-bit and 32-bit
> ones as well for consistency.
Hip06 LPC only support 8-bit I/O operations on the designated port.

> 
>> diff --git a/drivers/bus/extio.c b/drivers/bus/extio.c
>> new file mode 100644
>> index 0000000..1e7a9c5
>> --- /dev/null
>> +++ b/drivers/bus/extio.c
>> @@ -0,0 +1,66 @@
> 
> This is in a globally visible directory
> 
>> +
>> +struct extio_ops *arm64_extio_ops;
> 
> But the identifier uses an architecture specific prefix. Either
> move the whole file into arch/arm64, or make the naming so that
> it can be used for everything.

I perfer to move the whole file into arch/arm64, extio.h will be moved to arch/arm64/include/asm;

> 
>> +u8 __weak extio_inb(unsigned long addr)
>> +{
>> +	return arm64_extio_ops->pfin ?
>> +		arm64_extio_ops->pfin(arm64_extio_ops->devpara,
>> +			addr + arm64_extio_ops->ptoffset, NULL,
>> +			sizeof(u8), 1) : -1;
>> +}
> 
> No need for the __weak attribute, just make sure that the
> code is always built-in when needed.
> 
> Also, it doesn't seem necessary to have an extern function if
> all it does is call the one callback that you have already 
> checked earlier. Either put it all into the inline
> definition in asm/io.h, or put it all into the extern
> version like this.
> 
> #ifdef CONFIG_ARM64_INDIRECT_PIO /* otherwise use default from asm-generic */
> #define inb inb
> extern u8 inb(unsigned long addr);
> #endif
> 
Yes. This is good!
Although the in(s)/out(s) are not inline anymore.

I had applied this way above.

> u8 inb(unsigned long addr)
> {
> 	if (arm64_extio_ops && arm64_extio_ops->start <= addr &&
> 			addr <= arm64_extio_ops->end)
> 		arm64_extio_ops->pfin(arm64_extio_ops->devpara,addr + arm64_extio_ops->ptoffset, NULL,sizeof(u8), 1) : -1;
> 	return extio_inb(addr);
> }
> 
>> +#define inb inb
>> +static inline u8 inb(unsigned long addr)
>> +{
>> +#ifdef CONFIG_ARM64_INDIRECT_PIO
>> +	if (arm64_extio_ops && arm64_extio_ops->start <= addr &&
>> +			addr <= arm64_extio_ops->end)
>> +		return extio_inb(addr);
>> +#endif
>> +	return readb(PCI_IOBASE + addr);
>> +}
> 
>> diff --git a/include/linux/extio.h b/include/linux/extio.h
>> new file mode 100644
>> index 0000000..08d1fca
>> --- /dev/null
>> +++ b/include/linux/extio.h
>> @@ -0,0 +1,49 @@
>> +/*
>> + * Copyright (C) 2016 Hisilicon Limited, All Rights Reserved.
>> + * Author: Zhichang Yuan <yuanzhichang-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>
>> + * Author: Zou Rongrong <@huawei.com>
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 as
>> + * published by the Free Software Foundation.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + * GNU General Public License for more details.
>> + *
>> + * You should have received a copy of the GNU General Public License
>> + * along with this program.  If not, see <http://www.gnu.org/licenses/>.
>> + */
>> +
>> +#ifndef __LINUX_EXTIO_H
>> +#define __LINUX_EXTIO_H
>> +
>> +
>> +typedef u64 (*inhook)(void *devobj, unsigned long ptaddr, void *inbuf,
>> +				size_t dlen, unsigned int count);
>> +typedef void (*outhook)(void *devobj, unsigned long ptaddr,
>> +				const void *outbuf, size_t dlen,
>> +				unsigned int count);
> 
> I would drop the typedef and just declare the types directly in the
> only place that references them.
> 
Ok. Will apply it.

Thanks!
Zhichang

> 	Arnd
> 
> .
> 

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

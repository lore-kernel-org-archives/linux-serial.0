From: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH V5 1/3] ARM64 LPC: Indirect ISA port IO introduced
Date: Tue, 8 Nov 2016 12:03:23 +0000
Message-ID: <20161108120323.GC15297@leverpostej>
References: <1478576829-112707-1-git-send-email-yuanzhichang@hisilicon.com>
 <1478576829-112707-2-git-send-email-yuanzhichang@hisilicon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1478576829-112707-2-git-send-email-yuanzhichang-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "zhichang.yuan" <yuanzhichang-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>
Cc: catalin.marinas-5wv7dgnIgG8@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linuxarm-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, minyard-HInyCGIudOg@public.gmane.org, benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org, liviu.dudau-5wv7dgnIgG8@public.gmane.org, zourongrong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, john.garry-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, gabriele.paoloni-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, zhichang.yuan02-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, kantyzc-9Onoh4P/yGk@public.gmane.org, xuwei5-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org, marc.zyngier-5wv7dgnIgG8@public.gmane.org
List-Id: linux-serial@vger.kernel.org

On Tue, Nov 08, 2016 at 11:47:07AM +0800, zhichang.yuan wrote:
> For arm64, there is no I/O space as other architectural platforms, such as
> X86. Most I/O accesses are achieved based on MMIO. But for some arm64 SoCs,
> such as Hip06, when accessing some legacy ISA devices connected to LPC, those
> known port addresses are used to control the corresponding target devices, for
> example, 0x2f8 is for UART, 0xe4 is for ipmi-bt. It is different from the
> normal MMIO mode in using.

This has nothing to do with arm64. Hardware with this kind of indirect
bus access could be integrated with a variety of CPU architectures. It
simply hasn't been, yet.

> To drive these devices, this patch introduces a method named indirect-IO.
> In this method the in/out pair in arch/arm64/include/asm/io.h will be
> redefined. When upper layer drivers call in/out with those known legacy port
> addresses to access the peripherals, the hooking functions corrresponding to
> those target peripherals will be called. Through this way, those upper layer
> drivers which depend on in/out can run on Hip06 without any changes.

As above, this has nothing to do with arm64, and as such, should live in
generic code, exactly as we would do if we had higher-level ISA
accessor ops.

Regardless, given the multi-instance case, I don't think this is
sufficient in general (and I think we need higher-level ISA accessors
to handle the indirection).

[...]

> diff --git a/arch/arm64/include/asm/extio.h b/arch/arm64/include/asm/extio.h
> new file mode 100644
> index 0000000..6ae0787
> --- /dev/null
> +++ b/arch/arm64/include/asm/extio.h

> +#ifndef __LINUX_EXTIO_H
> +#define __LINUX_EXTIO_H

This doesn't match the file naming, __ASM_EXTIO_H would be consistent
with other arm64 headers.

> +
> +struct extio_ops {
> +	unsigned long start;/* inclusive, sys io addr */
> +	unsigned long end;/* inclusive, sys io addr */

Please put whitespace before inline comments.

[...]

> +type in##bw(unsigned long addr)						\
> +{									\
> +	if (!arm64_extio_ops || arm64_extio_ops->start > addr ||	\
> +			arm64_extio_ops->end < addr)			\
> +		return read##bw(PCI_IOBASE + addr);			\
> +	return arm64_extio_ops->pfin ?					\
> +		arm64_extio_ops->pfin(arm64_extio_ops->devpara,		\
> +			addr, sizeof(type)) : -1;			\
> +}									\
> +									\
> +void out##bw(type value, unsigned long addr)				\
> +{									\
> +	if (!arm64_extio_ops || arm64_extio_ops->start > addr ||	\
> +			arm64_extio_ops->end < addr)			\
> +		write##bw(value, PCI_IOBASE + addr);			\
> +	else								\
> +		if (arm64_extio_ops->pfout)				\
> +			arm64_extio_ops->pfout(arm64_extio_ops->devpara,\
> +				addr, value, sizeof(type));		\
> +}									\
> +									\
> +void ins##bw(unsigned long addr, void *buffer, unsigned int count)	\
> +{									\
> +	if (!arm64_extio_ops || arm64_extio_ops->start > addr ||	\
> +			arm64_extio_ops->end < addr)			\
> +		reads##bw(PCI_IOBASE + addr, buffer, count);		\
> +	else								\
> +		if (arm64_extio_ops->pfins)				\
> +			arm64_extio_ops->pfins(arm64_extio_ops->devpara,\
> +				addr, buffer, sizeof(type), count);	\
> +}									\
> +									\
> +void outs##bw(unsigned long addr, const void *buffer, unsigned int count)	\
> +{									\
> +	if (!arm64_extio_ops || arm64_extio_ops->start > addr ||	\
> +			arm64_extio_ops->end < addr)			\
> +		writes##bw(PCI_IOBASE + addr, buffer, count);		\
> +	else								\
> +		if (arm64_extio_ops->pfouts)				\
> +			arm64_extio_ops->pfouts(arm64_extio_ops->devpara,\
> +				addr, buffer, sizeof(type), count);	\
> +}
> +

So all PCI I/O will be slowed down by irrelevant checks when this is
enabled?

[...]

> +static inline void arm64_set_extops(struct extio_ops *ops)
> +{
> +	if (ops)
> +		WRITE_ONCE(arm64_extio_ops, ops);
> +}

Why WRITE_ONCE()?

Is this not protected/propagated by some synchronisation mechanism?

WRITE_ONCE() is not sufficient to ensure that this is consistently
observed by readers, and regardless, I don't see READ_ONCE() anywhere in
this patch.

This looks very suspicious.

Thanks,
Mark.
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

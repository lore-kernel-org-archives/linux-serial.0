From: Mason <slash.tmp@free.fr>
Subject: Re: [RESEND][PATCH] ARM: debug: add support for Palmchip 16550-like
 UART
Date: Wed, 4 Nov 2015 16:39:36 +0100
Message-ID: <563A26B8.9080405@free.fr>
References: <1445950678-16097-1-git-send-email-mans@mansr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1445950678-16097-1-git-send-email-mans@mansr.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Mans Rullgard <mans@mansr.com>, Russell King <linux@arm.linux.org.uk>
Cc: linux-serial <linux-serial@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>
List-Id: linux-serial@vger.kernel.org

On 27/10/2015 13:57, Mans Rullgard wrote:

> Some SoCs have a Palmchip UART with a non-standard register layout.
> This allows the debug console to work with these.
> 
> Signed-off-by: Mans Rullgard <mans@mansr.com>
> ---
>  arch/arm/Kconfig.debug        |  8 ++++++++
>  arch/arm/include/debug/8250.S | 12 ++++++++++++
>  2 files changed, 20 insertions(+)
> 
> diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
> index 0cfd7f9..9039fff 100644
> --- a/arch/arm/Kconfig.debug
> +++ b/arch/arm/Kconfig.debug
> @@ -1597,6 +1597,14 @@ config DEBUG_UART_8250_WORD
>  		DEBUG_BCM_KONA_UART || DEBUG_RK32_UART2 || \
>  		DEBUG_BRCMSTB_UART
>  
> +config DEBUG_UART_8250_PALMCHIP
> +	bool "8250 UART is Palmchip variant"
> +	depends on DEBUG_LL_UART_8250 || DEBUG_UART_8250

I am 100% clueless about the UART sequence in Linux.

There's earlyprintk, the boot console (polled?), the "full-blown"
console (with IRQs)...

If I want earlyprintk, I have to enable DEBUG_LL (?) so I'll have
DEBUG_LL_UART_8250, right? There's no way to pick DEBUG_UART_8250
in menuconfig, is there?

So I picked the following options:

CONFIG_DEBUG_LL=y
# CONFIG_DEBUG_ICEDCC is not set
# CONFIG_DEBUG_SEMIHOSTING is not set
CONFIG_DEBUG_LL_UART_8250=y
# CONFIG_DEBUG_LL_UART_PL01X is not set
CONFIG_DEBUG_LL_INCLUDE="debug/8250.S"
# CONFIG_DEBUG_UART_8250 is not set
# CONFIG_DEBUG_UART_BCM63XX is not set
CONFIG_DEBUG_UART_PHYS=0x10700
CONFIG_DEBUG_UART_VIRT=0xf0010700
CONFIG_DEBUG_UART_8250_SHIFT=2
CONFIG_DEBUG_UART_8250_WORD=y
CONFIG_DEBUG_UART_8250_PALMCHIP=y
# CONFIG_DEBUG_UART_8250_FLOW_CONTROL is not set
CONFIG_DEBUG_UNCOMPRESS=y
CONFIG_UNCOMPRESS_INCLUDE="debug/uncompress.h"
CONFIG_EARLY_PRINTK=y

I suppose I have to provide DEBUG_UART_PHYS because it needs
the address before it can parse the DT? But how am I supposed
to know the virtual address? Isn't that from iomap(UART_PHYS)?

'make' wouldn't let me proceed unless I gave something...

Then I have to add earlyprintk to my boot command line, right?
Do I need to specify more than that?
According to the documentation,

	earlyprintk=	[X86,SH,BLACKFIN,ARM,M68k]
			earlyprintk=vga
			earlyprintk=efi
			earlyprintk=xen
			earlyprintk=serial[,ttySn[,baudrate]]
			earlyprintk=serial[,0x...[,baudrate]]
			earlyprintk=ttySn[,baudrate]
			earlyprintk=dbgp[debugController#]
			earlyprintk=pciserial,bus:device.function[,baudrate]

> +	help
> +	  Palmchip provides a UART implementation compatible with 16550
> +	  except for having a different register layout.  Say Y here if
> +	  the debug UART is of this type.
> +
>  config DEBUG_UART_8250_FLOW_CONTROL
>  	bool "Enable flow control for 8250 UART"
>  	depends on DEBUG_LL_UART_8250 || DEBUG_UART_8250
> diff --git a/arch/arm/include/debug/8250.S b/arch/arm/include/debug/8250.S
> index 7f7446f..2332f40 100644
> --- a/arch/arm/include/debug/8250.S
> +++ b/arch/arm/include/debug/8250.S
> @@ -9,6 +9,18 @@
>   */
>  #include <linux/serial_reg.h>
>  
> +#ifdef CONFIG_DEBUG_UART_8250_PALMCHIP
> +
> +#undef UART_TX
> +#undef UART_LSR
> +#undef UART_MSR
> +
> +#define UART_TX 1
> +#define UART_LSR 7
> +#define UART_MSR 8
> +
> +#endif
> +
>  		.macro	addruart, rp, rv, tmp
>  		ldr	\rp, =CONFIG_DEBUG_UART_PHYS
>  		ldr	\rv, =CONFIG_DEBUG_UART_VIRT
> 

Regards.

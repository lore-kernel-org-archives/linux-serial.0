From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH 2/5] hsu, earlyprintk: add early printk for hsu_port2
 console
Date: Mon, 6 Sep 2010 16:17:46 +0200
Message-ID: <20100906141746.GB29291@elte.hu>
References: <20100906123843.1328.3930.stgit@localhost.localdomain>
 <20100906123908.1328.3598.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mx2.mail.elte.hu ([157.181.151.9]:60566 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751146Ab0IFOR6 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Mon, 6 Sep 2010 10:17:58 -0400
Content-Disposition: inline
In-Reply-To: <20100906123908.1328.3598.stgit@localhost.localdomain>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Cox <alan@linux.intel.com>
Cc: linux-serial@vger.kernel.org, greg@kroah.com, the arch/x86 maintainers <x86@kernel.org>


* Alan Cox <alan@linux.intel.com> wrote:

> From: Feng Tang <feng.tang@intel.com>
> 
> To enable early printk of HSU console, simply set "earlyprint=hsu" in
> kernel command line.
> 
> Currently we put the code in the mrst_earlyprintk.c and it need enable
> CONFIG_X86_MRST_EARLY_PRINTK config option
> 
> Signed-off-by: Feng Tang <feng.tang@intel.com>
> Signed-off-by: Alan Cox <alan@linux.intel.com>
> ---
> 
>  arch/x86/include/asm/mrst.h        |    1 
>  arch/x86/kernel/early_printk.c     |    3 +
>  arch/x86/kernel/mrst_earlyprintk.c |  128 ++++++++++++++++++++++++++++++++++++
>  3 files changed, 132 insertions(+), 0 deletions(-)

Please Cc: x86 patches to the x86 maintainers.

> diff --git a/arch/x86/include/asm/mrst.h b/arch/x86/include/asm/mrst.h
> index 704d2fd..b6531da 100644
> --- a/arch/x86/include/asm/mrst.h
> +++ b/arch/x86/include/asm/mrst.h
> @@ -46,5 +46,6 @@ extern enum mrst_timer_options mrst_timer_options;
>  #define SFI_MRTC_MAX	8
>  
>  extern struct console early_mrst_console;
> +extern struct console early_hsu_console;
>  extern void mrst_early_printk(const char *fmt, ...);
>  #endif /* _ASM_X86_MRST_H */
> diff --git a/arch/x86/kernel/early_printk.c b/arch/x86/kernel/early_printk.c
> index 435a070..fd095e7 100644
> --- a/arch/x86/kernel/early_printk.c
> +++ b/arch/x86/kernel/early_printk.c
> @@ -243,6 +243,9 @@ static int __init setup_early_printk(char *buf)
>  #ifdef CONFIG_X86_MRST_EARLY_PRINTK
>  		if (!strncmp(buf, "mrst", 4))
>  			early_console_register(&early_mrst_console, keep);
> +
> +		if (!strncmp(buf, "hsu", 3))
> +			early_console_register(&early_hsu_console, keep);
>  #endif
>  		buf++;
>  	}
> diff --git a/arch/x86/kernel/mrst_earlyprintk.c b/arch/x86/kernel/mrst_earlyprintk.c
> index 4aff765..1fb1305 100644
> --- a/arch/x86/kernel/mrst_earlyprintk.c
> +++ b/arch/x86/kernel/mrst_earlyprintk.c
> @@ -9,9 +9,12 @@
>   * of the License.
>   */
>  
> +#include <linux/serial_reg.h>
> +#include <linux/serial_mfd.h>
>  #include <linux/kmsg_dump.h>
>  #include <linux/console.h>
>  #include <linux/kernel.h>
> +#include <linux/delay.h>
>  #include <linux/init.h>
>  #include <linux/io.h>
>  
> @@ -281,3 +284,128 @@ void mrst_early_printk(const char *fmt, ...)
>  
>  	early_mrst_console.write(&early_mrst_console, buf, n);
>  }
> +
> +
> +/* Will use HSU port2 for early console */
> +
> +/*
> + * Note:
> + * 1. still need GPIO workaround for UART2
> + *
> + */
> +static spinlock_t hsu_lock;

Please use DEFINE_SPINLOCK().

> +static int hsu_inited;

'initialized' is the proper English word i think.

> +static void __iomem *phsu;
> +#define HSU_PORT2_PADDR		0xffa28180

Newline undersupply.

(Please use newlines to separate blocks of different types of 
definitions.)

> +#define MFD_GPIO_HSU_REG	0xff12c064

> +
> +static void early_hsu_init(void)
> +{
> +	u8 lcr;
> +
> +	if (phsu && hsu_inited)
> +		return;

Surely one of those will suffice as a "have we initialized" flag?

Also, under what circumstances can we call early_hsu_init() twice?

> +
> +	spin_lock_init(&hsu_lock);

Can be removed if it's DEFINE_SPINLOCK() declared.

> +
> +	/* GPIO workaround */
> +	set_fixmap_nocache(FIX_EARLYCON_MEM_BASE, MFD_GPIO_HSU_REG);
> +	phsu = (void *)(__fix_to_virt(FIX_EARLYCON_MEM_BASE) +
> +			(MFD_GPIO_HSU_REG & (PAGE_SIZE - 1)));
> +
> +	*((u32 *)phsu) = 0x55465;

What does 0x55465 stand for?

> +
> +	set_fixmap_nocache(FIX_EARLYCON_MEM_BASE, HSU_PORT2_PADDR);
> +	phsu = (void *)(__fix_to_virt(FIX_EARLYCON_MEM_BASE) +
> +			(HSU_PORT2_PADDR & (PAGE_SIZE - 1)));
> +
> +	writeb(0x0, phsu + UART_FCR);
> +
> +	/* set to default 115200 */
> +	lcr = readb(phsu + UART_LCR);
> +	writeb((0x80 | lcr), phsu + UART_LCR);
> +	writeb(0x18, phsu + UART_DLL);
> +	writeb(lcr,  phsu + UART_LCR);
> +	writel(0x3600, phsu + UART_MUL*4);
> +
> +	writeb(0x8, phsu + UART_MCR);
> +	writeb(0x7, phsu + UART_FCR);
> +	writeb(0x3, phsu + UART_LCR);
> +
> +	/* clear IRQ status */
> +	readb(phsu + UART_LSR);
> +	readb(phsu + UART_RX);
> +	readb(phsu + UART_IIR);
> +	readb(phsu + UART_MSR);
> +
> +
> +

Newline oversupply.

> +	writeb(0x7, phsu + UART_FCR);
> +
> +	hsu_inited = 1;
> +}
> +
> +#define BOTH_EMPTY (UART_LSR_TEMT | UART_LSR_THRE)
> +static void early_hsu_putc(char ch)

Newline undersupply.

> +{
> +	unsigned int timeout = 10000; /* 10ms*/
> +	u8 status;
> +
> +	while (timeout--) {
> +		status = readb(phsu + UART_LSR);
> +		if (status & BOTH_EMPTY)
> +			break;
> +
> +		udelay(1);
> +	}
> +
> +	if (timeout == 0xffffffff)
> +		return;

Using the -1 literal will dtrt too, and will be slightly clearer to the 
potentially overworked reader of such patches.

> +
> +	writeb(ch, phsu + UART_TX);
> +}
> +
> +static void early_hsu_write(struct console *con,
> +			const char *str, unsigned n)

Unnecessary linebreak. Ignore checkpatch when it suggests crap.

> +{
> +	int  i;

Space character oversupply.

> +	unsigned long flags;
> +
> +	/*
> +	printk("%s(): enter\n\n", __func__);
> +	*/

Can go away i suspect.

> +
> +	if (unlikely(!hsu_inited))
> +		early_hsu_init();

We check the 'hsu_inited' flag in early_hsu_init() too. One of the 
checks is superfluous.

> +
> +	spin_lock_irqsave(&hsu_lock, flags);

In early_printk code we generally try to avoid the use of spinlocks.

It is a 'console of last resort', and we try to keep it as simple as 
possible. The current early_printk.c code does not have a single 
spinlock, and still it's robust and usable in a wide range of 
circumstances, is NMI safe, etc.

With allowing early_hsu_putc() to execute in parallel, we at most can 
lose a character, because the UART's BOTH_EMPTY state might be stale. 
But it's not a real issue in practice: default earlyprintk is turned off 
way before SMP initializes.

> +	for (i = 0; i < n && *str; i++) {
> +		if (*str == '\n')
> +			early_hsu_putc('\r');
> +		early_hsu_putc(*str);
> +
> +		str++;
> +	}
> +	spin_unlock_irqrestore(&hsu_lock, flags);
> +}
> +
> +
> +struct console early_hsu_console = {
> +	.name =		"earlyhsu",
> +	.write =	early_hsu_write,
> +	.flags =	CON_PRINTBUFFER,
> +	.index =	-1,
> +};
> +
> +void hsu_early_printk(const char *fmt, ...)
> +{
> +	char buf[512];
> +	int n;
> +	va_list ap;
> +
> +	va_start(ap, fmt);
> +	n = vscnprintf(buf, 512, fmt, ap);
> +	va_end(ap);
> +
> +	early_hsu_console.write(&early_mrst_console, buf, n);
> +}

Instead of this hack that duplicates much of early_printk() please add 
something like:

  extern void __earlyprintk(struct console *con, ...)

and then hsa_early_printk() becomes:

  #define hsu_early_printk(x...) __early_printk(&earlymrst_console, x...)

... or so - and other subsystems may make use of it as well, to 
implement their own special unconditional-printout routines.

Thanks,

	Ingo

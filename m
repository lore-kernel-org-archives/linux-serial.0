From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 2/2] Changes to existing files for 0PF FPGA board.
Date: Thu, 18 Jun 2015 21:36:21 +0200
Message-ID: <CAMuHMdV_hNng9MDotN3jidRdG+WEUwjDwYcmTTohLPtfMEoAKg@mail.gmail.com>
References: <1434647946.861556@landley.net>
	<1434647946.861922@landley.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1434647946.861922@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Landley <rob@landley.net>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, Andrew Morton <akpm@linux-foundation.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Kevin Hilman <khilman@linaro.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Vivek Goyal <vgoyal@redhat.com>, "Steven Rostedt (Red Hat)" <rostedt@goodmis.org>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Riku Voipio <riku.voipio@linaro.org>, Jiri Kosina <jkosina@suse.cz>, Paul Bolle <pebolle@tiscali.nl>, Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Davidlohr Bueso <davidlohr@hp.com>, Richard Weinberger <richard@nod.at>, Zhigang Lu <zlu@tilera.com>, Vineet Gupta <vgupta@synopsys.com>, Richard Kuo <rkuo@codeaurora.org>, Max Filippov <jcmvbkbc@gmail.com>, Pranith Kumar <bobby.prani@gmail.com>, Linux-sh list <linux-sh@vger.kernel.org>, linux-kernel@vger.ker
List-Id: linux-serial@vger.kernel.org

Hi Rob,

On Thu, Jun 18, 2015 at 7:19 PM, Rob Landley <rob@landley.net> wrote:
> Changes to existing files to add 0pf j2 board support.

Thanks for your patch!

Like Greg already said, splitting it up in logical parts and providing useful
patch descriptions would be highly appreciated.

> diff --git a/arch/sh/Makefile b/arch/sh/Makefile
> index bf5b3f5..e609157 100644
> --- a/arch/sh/Makefile
> +++ b/arch/sh/Makefile

> @@ -31,6 +33,7 @@ isa-y                                 := $(isa-y)-up
>  endif
>
>  cflags-$(CONFIG_CPU_SH2)               := $(call cc-option,-m2,)
> +cflags-$(CONFIG_CPU_SH2J)              := $(call cc-option,-m2,)

This is superfluous, as CPU_SH2J selects CPU_SH2.

> diff --git a/arch/sh/kernel/irq.c b/arch/sh/kernel/irq.c
> index eb10ff8..7de9bcb 100644
> --- a/arch/sh/kernel/irq.c
> +++ b/arch/sh/kernel/irq.c
> @@ -20,6 +20,8 @@
>  #include <asm/thread_info.h>
>  #include <cpu/mmu_context.h>
>
> +#include <asm/board-0pf.h>

Board-specific inclusion in generic sh source file?

> +
>  atomic_t irq_err_count;
>
>  /*
> @@ -175,11 +177,24 @@ void do_softirq_own_stack(void)
>         );
>  }
>  #else
> +#define noinline __attribute__((noinline))
> +static noinline void handle_irq_UART0(unsigned int irq) { generic_handle_irq(irq); }
> +static noinline void handle_irq_UART1(unsigned int irq) { generic_handle_irq(irq); }
> +static noinline void handle_irq_GPS(unsigned int irq) { generic_handle_irq(irq); }
> +static noinline void handle_irq_EMAC(unsigned int irq) { generic_handle_irq(irq); }
>  static inline void handle_one_irq(unsigned int irq)
>  {
> -       generic_handle_irq(irq);
> +       switch(irq) {
> +       case Irq_UART0: handle_irq_UART0(irq); break;
> +       case Irq_UART1: handle_irq_UART1(irq); break;
> +       case Irq_GPS:   handle_irq_GPS(irq); break;
> +       case Irq_EMAC:  handle_irq_EMAC(irq); break;
> +       default:
> +               generic_handle_irq(irq);
> +               break;
> +       }

What's the purpose of this change?

>  }
> -#endif
> +#endif // CONFIG_IRQSTACKS

Please no C++-style comments (scripts/checkpatch.pl?)

> diff --git a/arch/sh/mm/cache-sh2.c b/arch/sh/mm/cache-sh2.c
> index a74259f..438eadb 100644
> --- a/arch/sh/mm/cache-sh2.c
> +++ b/arch/sh/mm/cache-sh2.c

> @@ -16,6 +17,30 @@
>  #include <asm/cacheflush.h>
>  #include <asm/io.h>
>
> +#if defined(CONFIG_CPU_SUBTYPE_0PF)
> +
> +// Just flush the whole thing each time

Likewise

> +static void j2_flush_icache_range(void *fwoosh)
> +{
> +       __raw_writel(CCR_CACHE_RESET, CCR);
> +}
> +
> +// This should never happen, but...

Likewise.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

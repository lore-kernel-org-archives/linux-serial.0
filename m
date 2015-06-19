From: Rob Landley <rob@landley.net>
Subject: Re: [PATCH 2/2] Changes to existing files for 0PF FPGA board.
Date: Fri, 19 Jun 2015 17:11:35 -0500
Message-ID: <55849397.1060000@landley.net>
References: <1434647946.861556@landley.net>	<1434647946.861922@landley.net> <CAMuHMdV_hNng9MDotN3jidRdG+WEUwjDwYcmTTohLPtfMEoAKg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <CAMuHMdV_hNng9MDotN3jidRdG+WEUwjDwYcmTTohLPtfMEoAKg@mail.gmail.com>
Sender: linux-sh-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Jiri Slaby <jslaby@suse.cz>, Andrew Morton <akpm@linux-foundation.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Kevin Hilman <khilman@linaro.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Vivek Goyal <vgoyal@redhat.com>, "Steven Rostedt (Red Hat)" <rostedt@goodmis.org>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Riku Voipio <riku.voipio@linaro.org>, Jiri Kosina <jkosina@suse.cz>, Paul Bolle <pebolle@tiscali.nl>, Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Davidlohr Bueso <davidlohr@hp.com>, Richard Weinberger <richard@nod.at>, Zhigang Lu <zlu@tilera.com>, Vineet Gupta <vgupta@synopsys.com>, Richard Kuo <rkuo@codeaurora.org>, Max Filippov <jcmvbkbc@gmail.com>, Pranith Kumar <bobby.prani@gmail.com>, Linux-sh list <linux-sh@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>linux-s
List-Id: linux-serial@vger.kernel.org

[Trimmed greg at what I'm interpreting as his request.]

On 06/18/2015 02:36 PM, Geert Uytterhoeven wrote:
> Hi Rob,
> 
> On Thu, Jun 18, 2015 at 7:19 PM, Rob Landley <rob@landley.net> wrote:
>> Changes to existing files to add 0pf j2 board support.
> 
> Thanks for your patch!
> 
> Like Greg already said, splitting it up in logical parts and providing useful
> patch descriptions would be highly appreciated.

I actually don't know how to split it up further. The initial port was
done by a series of contractors (in Russia, I think), and then I
inherited it to try to get something releasable. This is the smallest
chunk I could get to actually boot.

I suppose I could send you the serial driver by itself, and _then_ the
board, but it wouldn't compile if nothing uses it. (Similarly you can't
boot the board without a serial console...)

>> diff --git a/arch/sh/Makefile b/arch/sh/Makefile
>> index bf5b3f5..e609157 100644
>> --- a/arch/sh/Makefile
>> +++ b/arch/sh/Makefile
> 
>> @@ -31,6 +33,7 @@ isa-y                                 := $(isa-y)-up
>>  endif
>>
>>  cflags-$(CONFIG_CPU_SH2)               := $(call cc-option,-m2,)
>> +cflags-$(CONFIG_CPU_SH2J)              := $(call cc-option,-m2,)
> 
> This is superfluous, as CPU_SH2J selects CPU_SH2.

Ooh, thanks.

>> diff --git a/arch/sh/kernel/irq.c b/arch/sh/kernel/irq.c
>> index eb10ff8..7de9bcb 100644
>> --- a/arch/sh/kernel/irq.c
>> +++ b/arch/sh/kernel/irq.c
>> @@ -20,6 +20,8 @@
>>  #include <asm/thread_info.h>
>>  #include <cpu/mmu_context.h>
>>
>> +#include <asm/board-0pf.h>
> 
> Board-specific inclusion in generic sh source file?

Gah, I thought I'd whacked all of those. (Staring at it too long to see
some of this stuff anymore...)

>> +
>>  atomic_t irq_err_count;
>>
>>  /*
>> @@ -175,11 +177,24 @@ void do_softirq_own_stack(void)
>>         );
>>  }
>>  #else
>> +#define noinline __attribute__((noinline))
>> +static noinline void handle_irq_UART0(unsigned int irq) { generic_handle_irq(irq); }
>> +static noinline void handle_irq_UART1(unsigned int irq) { generic_handle_irq(irq); }
>> +static noinline void handle_irq_GPS(unsigned int irq) { generic_handle_irq(irq); }
>> +static noinline void handle_irq_EMAC(unsigned int irq) { generic_handle_irq(irq); }
>>  static inline void handle_one_irq(unsigned int irq)
>>  {
>> -       generic_handle_irq(irq);
>> +       switch(irq) {
>> +       case Irq_UART0: handle_irq_UART0(irq); break;
>> +       case Irq_UART1: handle_irq_UART1(irq); break;
>> +       case Irq_GPS:   handle_irq_GPS(irq); break;
>> +       case Irq_EMAC:  handle_irq_EMAC(irq); break;
>> +       default:
>> +               generic_handle_irq(irq);
>> +               break;
>> +       }
> 
> What's the purpose of this change?

Honestly, your guess is as good as mine. (Sorry, I'll move it to a
board-specific file. I mentioned needing to redo the interrupt logic
_entirely_, it should totally be using SPARSE_IRQ. And in fact most of
the above is for drivers I trimmed out of this submission anyway.)

>>  }
>> -#endif
>> +#endif // CONFIG_IRQSTACKS
> 
> Please no C++-style comments (scripts/checkpatch.pl?)

I expect it to try to reach through the screen and throttle me, but sure...

(Now the reason _I_ thought you'd reject it had more to do with not
having converted it to device tree yet, and things on that level. But I
wanted to get it out there so people outside $DAYJOB can test the
hardware. We did a linuxcon japan presentation which lwn.net covered,
and we're getting pokes about "where can I download this", so...)

Rob
--
To unsubscribe from this list: send the line "unsubscribe linux-sh" in

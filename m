From: Paul Osmialowski <pawelo-rhuoMcPwk82rDJvtcaxF/A@public.gmane.org>
Subject: Re: [PATCH 3/9] arm: add call to CPU idle quirks handler
Date: Fri, 26 Jun 2015 07:30:49 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1506260715300.499@localhost.localdomain>
References: <1435094387-20146-1-git-send-email-pawelo@king.net.pl> <1435094387-20146-4-git-send-email-pawelo@king.net.pl> <2235698.8UjxLOMCMb@wuerfel> <alpine.LFD.2.11.1506251237000.2617@knanqh.ubzr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <alpine.LFD.2.11.1506251237000.2617-fMhRO7WWcppj+hNMo8g0rg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Nicolas Pitre <nicolas.pitre-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Paul Osmialowski <pawelo-rhuoMcPwk82rDJvtcaxF/A@public.gmane.org>, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Anson Huang <b20788-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Ard Biesheuvel <ard.biesheuvel-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Bhupesh Sharma <bhupesh.sharma-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Frank Li <Frank.Li-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Jingchang Lu <jingchang.lu-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Jiri Slaby <jslaby-AlSwsSmVLrQ@public.gmane.org>, Kees Cook <keescook-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Magnus Damm <damm+renesas-yzvPICuk2ACczHhG9Qg4qA@public.gmane.org>, Michael Turquette <mturquette-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Nathan
List-Id: linux-serial@vger.kernel.org

Hi Nicolas,

Thanks for your proposal, however, I have some trouble with it.

That would look lovely:

#include <linux/linkage.h>
#include <asm/assembler.h>

/*
  *      cpu_kinetis_do_idle()
  *
  *      Idle the processor (wait for interrupt).
  *
  *      IRQs are already disabled.
  */
ENTRY(cpu_kinetis_do_idle)
         wfi
         movw    r3, #:lower16:0xe0082000
         movt    r3, #:upper16:0xe0082000
         ldr     r0, [r3, #0]
         orr     r2, r0, #0x85000000
         str     r2, [r3, #0]
         ret     lr
ENDPROC(cpu_kinetis_do_idle)

But... what about the rest of this hypothetical proc_kinetis.S file?

It would be a lot of code duplication with proc-v7m.S I think.

I could define CPU_KINETIS as such:

config CPU_KINETIS
 	bool
 	select CPU_V7M

But there's no such thing like customize_processor_functions that would be 
called after proc-v7m.S define_processor_functions specified things like 
idle routine.

Finally, while I was searching for suitable arm_pm_idle-based solution, I 
found idle.c in mach-gemini that encouraged me to write my own idle.c for 
Kinetis:

/*
  * arch/arm/mach-kinetis/idle.c
  */

#include <linux/init.h>
#include <linux/io.h>
#include <asm/system_misc.h>
#include <asm/proc-fns.h>

static void kinetis_idle(void)
{
         asm volatile ("wfi");

         /*
          * This is a dirty hack that invalidates the I/D bus cache
          * on Kinetis K70. This must be done after idle.
          */
         writel(readl(IOMEM(0xe0082000)) | 0x85000000, IOMEM(0xe0082000));
}

static int __init kinetis_idle_init(void)
{
         arm_pm_idle = kinetis_idle;
         return 0;
}

arch_initcall(kinetis_idle_init);

Et voila:

(gdb) c
Continuing.
^C
Program received signal SIGTRAP, Trace/breakpoint trap.
kinetis_idle () at ../arch/arm/mach-kinetis/idle.c:18
18		writel(readl(IOMEM(0xe0082000)) | 0x85000000, 
IOMEM(0xe0082000));
(gdb) bt
#0  kinetis_idle () at ../arch/arm/mach-kinetis/idle.c:18
#1  0x0800a91e in arch_cpu_idle () at ../arch/arm/kernel/process.c:70
#2  0x08025402 in cpuidle_idle_call (state=<value optimized out>)
     at ../kernel/sched/idle.c:157
#3  cpu_idle_loop (state=<value optimized out>) at 
../kernel/sched/idle.c:253
#4  cpu_startup_entry (state=<value optimized out>) at 
../kernel/sched/idle.c:301
#5  0x081bf816 in start_kernel () at ../init/main.c:683
#6  0x08008024 in stext () at ../arch/arm/kernel/head-nommu.S:85
(gdb)

On Thu, 25 Jun 2015, Nicolas Pitre wrote:

> On Tue, 23 Jun 2015, Arnd Bergmann wrote:
>
>> On Tuesday 23 June 2015 23:19:41 Paul Osmialowski wrote:
>>> Some SoCs need additional actions to be performed after arch idle,
>>> e.g. Kinetis requires invalidation of the I/D bus cache.
>>>
>>> Such handler could be held in provided <mach/idle.h> header file.
>>>
>>> Signed-off-by: Paul Osmialowski <pawelo-rhuoMcPwk82rDJvtcaxF/A@public.gmane.org>
>>> ---
>>>  arch/arm/Kconfig          | 7 +++++++
>>>  arch/arm/kernel/process.c | 7 +++++++
>>>  2 files changed, 14 insertions(+)
>>>
>>> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
>>> index 8e3a833..8ef8f8f 100644
>>> --- a/arch/arm/Kconfig
>>> +++ b/arch/arm/Kconfig
>>> @@ -98,6 +98,13 @@ config ARM_HAS_SG_CHAIN
>>>  config NEED_SG_DMA_LENGTH
>>>  	bool
>>>
>>> +config NEED_MACH_IDLE_H
>>> +	bool
>>> +
>>> +config ARM_CPU_IDLE_QUIRKS
>>> +	bool
>>> +	select NEED_MACH_IDLE_H
>>> +
>>
>> We're not adding header files like this, please come up
>> with another solution. How about a cpuidle driver, or
>> possibly just overriding arm_pm_idle()?
>
> If the WFI instruction always requires I and D flushing, then it might
> be a better idea to provide a replacement for the corresponding
> cpu_*_do_idle function.  Plenty of examples exist for other cpu_*
> functions.
>
>
> Nicolas
>
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

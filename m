From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: console vs earlycon ?
Date: Wed, 21 Oct 2015 09:53:47 -0400
Message-ID: <562798EB.7060202@hurleysoftware.com>
References: <CAK7LNARem16fTim8Ds_y8ezMusz_aRtv6c59KoxyC0rLV-RBWw@mail.gmail.com>
 <14202684.GgqlkWAZA0@wuerfel>
 <CAK7LNATniscPQ_vLMg91PWbMVSdoXtJYGL9nicsn49=ULQ-oAw@mail.gmail.com>
 <5490682.zH2vAEO2id@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5490682.zH2vAEO2id@wuerfel>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Stefan Agner <stefan@agner.ch>, linux-serial@vger.kernel.org, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: linux-serial@vger.kernel.org

On 10/21/2015 06:36 AM, Arnd Bergmann wrote:
> On Wednesday 21 October 2015 18:30:05 Masahiro Yamada wrote:
>>>
>>>> I am trying to implement OF_EARLYCON_DECLARE() for that.
>>>>
>>>> I was just wondering if console_initcall() should work as well.
>>>>
>>>>
>>>> As I said, I noticed the console_initcall() in 8250_core.c
>>>> only works on very limited platforms.
>>>
>>> It works with all those that use of_serial.c, right?
>>
>> I doubt it.
>>
>>
>> I have a board with a pure 8250-compat device working.
>> (  compatible = "ns16550a")
>> It uses of_serial.c, of course.
>>
>>
>> As far as I tested, it would never enable the console at console_init().
> 
> Ok, that sounds like a bug. Peter and others have changed that code
> a lot in the last year. I wonder if this has never worked then or
> if it has regressed.

No, not a bug. console_init() is only for legacy platforms, not for
probed drivers.

>> The console is enabled when the UART driver is probed.
>> (or earlycon if "earlycon" is specified in the kernel-parameter.)
> 
> Got it. Let me know if you think this interpretation is correct:
> 
> * univ8250_console_match() looks for the earlycon argument format like
>   "console=uart[8250],io|mmio|mmio32,<addr>[,<options>]", and that
>   would work, but we don't want to have to pass all that data when
>   the information should already be there.

This only works at console_init() time for legacy platforms that
have already initialized the 8250 port table.


> * univ8250_console_setup() looks for ports that have been added by
>   one of several other methods (including earlycon) already

8250 earlycon doesn't add ports.

>   , but we don't do that on ARM without earlycon being enabled.


> * arch/powerpc/kernel/legacy_serial.c does everything we need, but
>   does not live in architecture independent code and does a few
>   things that we probably don't need or want there. It relies
>   on scanning the device tree for known UART device nodes before
>   the platform devices are added.
> 
> * for console_initcall() to do the right thing, we want both the
>   ttyS devices to get added early for console=ttyS1 to work, as well
>   as having the preferred console work based on the stdout-property.
> 
> * we parse the /chosen/stdout-path property in drivers/of/base and
>   store the device node pointer in the global 'of_stdout' variable,
>   but do not use it until the uart is added by the tty driver
>   and calls of_console_check() to add the default console device.

I'm assuming the issue with trying to get console_init() working
is because the dummy color console causes the earlycon to be disabled?

I fixed that once before for stdout-path but there were some regressions
on PPC platforms; maybe I can revisit that.

Regards,
Peter Hurley

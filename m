From: Sebastian Frias <sf84@laposte.net>
Subject: Re: [RFC PATCH] always probe UART HW when options are not specified
Date: Mon, 21 Dec 2015 17:50:45 +0100
Message-ID: <56782DE5.7090708@laposte.net>
References: <5672D18E.8000301@laposte.net> <5672E2CF.6080705@hurleysoftware.com> <5672E76A.3010506@laposte.net> <5672F588.8070503@hurleysoftware.com> <5672FD35.5070609@laposte.net> <56731689.70702@hurleysoftware.com> <56740FC3.50302@laposte.net> <5674204C.1000907@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5674204C.1000907@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Hurley <peter@hurleysoftware.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, mason <slash.tmp@free.fr>, =?UTF-8?B?TcOlbnMgUnVsbGfDpXJk?= <mans@mansr.com>
List-Id: linux-serial@vger.kernel.org

Hi Peter,

On 12/18/2015 04:03 PM, Peter Hurley wrote:
>>
>> I totally understand, we have the same constraints with our SDK's APIs but with major versions we drop old APIs that have been superseded.
>> I would have thought that the switch to DT would have been a good opportunity to clean all that up, since it requires a change in the bootloader, right?
>
> How would that have worked with field upgrades of the kernel but
> not bootloader?

It wouldn't, that was my point.
You would have decided a limit of support.
I'm sure that from time to time, some support is dropped, leading to 
some HW having its support "removed" from mainline and maybe supported 
on some backports branch.
Right?

>
>
>> Anyway, do you know of a comprehensive list of options, console=ttyS0, earlycon=uart, console=uart, stdout-path=, etc. that are tested?
>
> Although the kernel command line parameters are documented in
> Documentation/kernel-parameters.txt and the DT options are documented in
> Documentation/devicetree/..., you're right; Documentation/serial-console.txt
> has bit-rotted.
>
> Some patches for that would be great.
>
> In fact, most of the console-related documentation needs a re-org.

I understand, I would like to help, but right now I'm not sure I 
understood all of these options nor their history.
Do you have any suggestions?

>
>
>> I would figure that if there's no list, then it is not easy to create the testcases, and thus some end up not being tested (see further below).
>
> It gets tested, because when I break something, I hear it.

:)
That's true if all test cases are exercised by people that would take 
the time to report back to you, and if they are always testing the 
latest code (or at least where commits go).

In general, when a company ships a product, they will attempt to keep 
all changes to the minimum.
The are several reasons for that, product certifications (they'd need to 
be redone under some circumstances) and middleware developed by third 
companies or contractors provided as binary (which would ask for money 
to rebuild/port), seem the most common, and that forces companies to 
support really old kernels, which may not receive any more patches from 
the community and that they need to keep fixing it internally. That 
brings us back to the question whether or not you would get feedback, 
and in those circumstances I think you probably wouldn't.

All that to say that I would not be so sure about the "community" 
reporting issues, for sure they do, but with limitations.
I understand that the "open source" philosophy is that there's many 
people looking at the code and will find issues, report them or fix them.
But in my experience, if something is not tested continuously, it will 
inexorably be broken at some point.
Another argument in favor of testcases is that they also serve as 
documentation.

Don't get me wrong, I'm just trying to show how, under some 
circumstances, the "many eyes" hypothesis is not verified, and that 
testing does not comes for free.
Although I'm sure I'm just repeating something that has already been said.

>> Ok, so that does not work.
>> Actually, the kernel crashes (by the way, the is a potential crash on probe_baud if quot is zero, I had dealt with that on my patch)
>> Indeed, "console=uart" will crash at a call to uart_parse_earlycon() on drivers/tty/serial/8250/8250_core.c:univ8250_console_match() due to options=NULL.
>> I see that a similar call to uart_parse_earlycon() in drivers/tty/serial/earlycon.c does check for options!=NULL.
>
> You need to use the format documented in Documentation/kernel-parameters.text:
>
> 	console=	[KNL] Output console device and options.
>
> 		uart[8250],io,<addr>[,options]
> 		uart[8250],mmio,<addr>[,options]
> 		uart[8250],mmio16,<addr>[,options]
> 		uart[8250],mmio32,<addr>[,options]
> 		uart[8250],0x<addr>[,options]
> 			Start an early, polled-mode console on the 8250/16550
> 			UART at the specified I/O port or MMIO address,
> 			switching to the matching ttyS device later.
> 			MMIO inter-register address stride is either 8-bit
> 			(mmio), 16-bit (mmio16), or 32-bit (mmio32).
> 			If none of [io|mmio|mmio16|mmio32], <addr> is assumed
> 			to be equivalent to 'mmio'. 'options' are specified in
> 			the same format described for ttyS above; if unspecified,
> 			the h/w is not re-initialized.
>
> The iotype and the uart address are not options.

Do you mean they are mandatory?
How do they relate to the keys present on the DT? Because the device is 
already described in the DT:

		uart: serial@10700 {
			compatible = "ralink,rt2880-uart";
			reg = <0x10700 0x30>;
			interrupts = <1 IRQ_TYPE_LEVEL_HIGH>;
			clock-frequency = <7372800>;
			reg-shift = <2>;
		};

Are we supposed to duplicate such information (ie: addr) in the 
commandline as well?

>> console_init()
>>     register_console()
>>        univ8250_console_match()
>
> Console matching failed here: probably because the driver's not yet initialized.
> Only ISA type ports/early_serial_setup() ports can load a console here
> because driver probing hasn't yet happened. This is very early here.

Is the crash expected then?

If the 'options' are really mandatory, then the crash could be avoided by:

	if (!options)
		return -ENODEV;

however, as I stated earlier, that would prevent the console from 
working even if the port is properly described in the DT :(

Let's say there's a non-standard (ie: incompatible with 8250) UART 
driver which is described in DT and whose driver would allow for it to 
be used as console, what would the kernel command line for it be? 
"console=uart" or "console=ttyS0"?
Alternatively, what's the most generic way (kernel command line) to 
instruct the console to work on some device that is described by the DT?

>
>> ...
>> kernel_init()
>>     ...
>>        of_platform_serial_driver_init()
>>        ...
>>           of_platform_serial_probe()
>>              serial8250_register_8250_port()
>>                 uart_add_one_port()
>>                    register_console()
>>                       univ8250_console_match()
>
> This is where your console will take over from earlycon.
>

See my previous comment.

>
>>
>> Since options=NULL both times, I think the console is never brought up properly.
>>
>> I thus used a less obvious (at first) solution:
>>
>>      if (!options)
>>          return univ8250_console_setup(co, options);
>>
>> however, since univ8250_console_setup() does not forces a probe, and options=NULL, it overwrites the UART config with '9600n8r'.
>>
>> So, I still think we need to change serial8250_console_setup() and the "rfc patch" I had proposed is still ok for this.
>
> Again, what about the existing installations that have a kernel command line
> like "console=ttyS0" and expect 9600n81 line settings?

If that were the case, then the statement "if unspecified, the h/w is 
not re-initialized" would be misleading, right?

>> Ok, thanks for the explanation.
>> Out of curiosity:
>> Do you know what is the difference between "earlycon" and "console"?
>
> earlycon= starts a boot console only
> console= will start a boot console if it finds an earlycon match and then
>           start a regular console that "takes over" from the boot console
>

For example, I logged the boot of our 4.1.13+ kernel with command line 
"console=uart mem=256M earlyprintk debug ignore_loglevel" and I saw that 
arch/arm/kernel/setup.c:setup_arch() would call parse_early_param() 
resulting in:

A) drivers/tty/serial/8250/8250_early.c:early_serial8250_setup() 
rejecting the initialisation (most likely due to incomplete options)

until

B) drivers/tty/serial/8250/8250_early.c:setup_early_printk() registering 
a console hooked up to printch() (written in assembly and available very 
early), essentially using the arch-dependent UART facility.

Would A) be what you call "if it finds an earlycon match"?


>
>> I mean, why would one need "earlycon" if there's already "earlyprintk"?
>
> You need to think about this from other developers' points-of-view.
>
> Suppose there was no earlycon, and you needed to initialize your
> 8250-work-alike-but-not-clone? Are you going to add RT2880 register layout
> to all the various arches for earlyprintk support? Trust me, those arches are
> going to be unhappy about that. Multiply that by all the serial consoles
> and that's an insurmountable problem.
>
> Whereas adding earlycon support for every arch at once is trivial.

I understand, thanks.

So, before earlycon there was a "gap" between earlyprintk and console?
Does the notion of "early" between earlycon and console just affects 
when the logs starts being sent to the UART? Or is earlycon somehow 
limited, justifying the need for another more complex driver (console) 
to be brought up after a while?

>
>
>> Why does it matter if support is in arch-dependent or arch-independent code?, as long as it works, it shouldn't matter, right?
>> Why couldn't driver developers use the "earlyprintk" facilities?
>
> Sure, if earlyprintk works for you, by all means, please use it.
>
> But it strikes me that it actually doesn't work for you because earlyprintk
> doesn't do console hand-off, which is what you want.
>

What is confusing is that now we have DT which is supposed to deal with 
describing the HW, and while I understand it is somewhat new and thus 
before it we needed to pass options in the command line, now that we 
have DT, there should be a way to tell it to use the HW description from DT.

Am I missing something obvious?

>> Sorry for all the questions, I'm just curious about all these facilities.
>> I mean, maintaining all of them requires work and is error prone (as the crash above shows), so I'd like to understand why are you guys keeping them all.
>
> No need to apologize for questions.
>

Thanks for your understanding.


>> Ok, what about posting that as a separate patch in case somebody else needs it, would that be ok with you?
>
> Definitely; patches are always welcome.
>
> Plus Greg may disagree and want to take up the patch anyway.
>

Ok, I will do so later on.

Thanks, regards,

Sebastian

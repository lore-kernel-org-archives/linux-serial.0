From: Sebastian Frias <sf84@laposte.net>
Subject: Re: [RFC PATCH] always probe UART HW when options are not specified
Date: Fri, 18 Dec 2015 14:53:07 +0100
Message-ID: <56740FC3.50302@laposte.net>
References: <5672D18E.8000301@laposte.net> <5672E2CF.6080705@hurleysoftware.com> <5672E76A.3010506@laposte.net> <5672F588.8070503@hurleysoftware.com> <5672FD35.5070609@laposte.net> <56731689.70702@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <56731689.70702@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Hurley <peter@hurleysoftware.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, mason <slash.tmp@free.fr>, =?UTF-8?B?TcOlbnMgUnVsbGfDpXJk?= <mans@mansr.com>
List-Id: linux-serial@vger.kernel.org

Hi Peter,

On 12/17/2015 09:09 PM, Peter Hurley wrote:
>> It's confusing though, given there are multiple ways to express the same thing.
>> I also found parts of the doc confusing in that regard as well.
>> ie: there's also a "stdout-path" DT key.
>
> Yep. Thing is, once it goes into the command line and someone uses it,
> it's permanent.
>
> That's why it's important to get the semantics right the first time
> (which only looks easy from hindsight).
>

I totally understand, we have the same constraints with our SDK's APIs 
but with major versions we drop old APIs that have been superseded.
I would have thought that the switch to DT would have been a good 
opportunity to clean all that up, since it requires a change in the 
bootloader, right?

Anyway, do you know of a comprehensive list of options, console=ttyS0, 
earlycon=uart, console=uart, stdout-path=, etc. that are tested?
I would figure that if there's no list, then it is not easy to create 
the testcases, and thus some end up not being tested (see further below).

>
>>> So
>>>
>>>     "console=ttyS0" w/o options    always initializes the h/w to 9600n81
>>
>> Ok, I see. So that's not the option we need then.
>>
>>>     "earlycon=uart" w/o options    starts a bootconsole w/o initializing the h/w
>>>     "console=uart" w/o options     starts a bootconsole w/o initializing the h/w,
>>>                                    then replaces that bootconsole with a regular
>>>                                    console (whatever ttySn matched that port)
>>>                                    In this case, the port is probed to discover
>>>                                    the h/w settings. Those also become the initial
>>>                                    settings for the /dev/ttySn device.
>>
>> Ok, sounds like that last one is the one we need, I will check that, thanks.

Ok, so that does not work.
Actually, the kernel crashes (by the way, the is a potential crash on 
probe_baud if quot is zero, I had dealt with that on my patch)
Indeed, "console=uart" will crash at a call to uart_parse_earlycon() on 
drivers/tty/serial/8250/8250_core.c:univ8250_console_match() due to 
options=NULL.
I see that a similar call to uart_parse_earlycon() in 
drivers/tty/serial/earlycon.c does check for options!=NULL.

If we add a simple:
	
	if (!options)
		return -ENODEV;

then the kernel does not crashes but it appears that the console is not 
properly brought up, and once that we reach:

[    0.353378] bootconsole [earlycon0] disabled

we loose it (ie: there are no more logs)

I think the whole process is too involved and I'm not sure I understand 
it all.
univ8250_console_match() seems to be called twice, here's the calltrace:

console_init()
    register_console()
       univ8250_console_match()
...
kernel_init()
    ...
       of_platform_serial_driver_init()
       ...
          of_platform_serial_probe()
             serial8250_register_8250_port()
                uart_add_one_port()
                   register_console()
                      univ8250_console_match()

Since options=NULL both times, I think the console is never brought up 
properly.

I thus used a less obvious (at first) solution:

	if (!options)
		return univ8250_console_setup(co, options);

however, since univ8250_console_setup() does not forces a probe, and 
options=NULL, it overwrites the UART config with '9600n8r'.

So, I still think we need to change serial8250_console_setup() and the 
"rfc patch" I had proposed is still ok for this.
I can remove the probing of the parity, bits, etc. but it looks like it 
would end up in a half cooked patch, in the sense that sentences like:

      "console=uart" w/o options     starts a bootconsole w/o 
initializing the h/w,

would come with some undocumented limitations.

Let me know what you think.

>>
>>>
>>> earlyprintk is implemented by arch-specific code, whereas earlycon is implemented
>>> by the serial driver code.
>>>
>>> Since earlyprintk is implemented in the arch code, it can be tweaked for
>>> earlier use than early param parsing. There were some patches earlier this
>>> year for x86 to initialize earlyprintk very early; not sure if they were
>>> ever upstreamed. On ARM, earlyprintk is debug_ll.
>>
>> So there are 3 levels of console?
>> earlyprintk: before early param
>> earlycon: early param?
>> console: after early param?
>>
>> What's the use case for earlycon if earlyprink is operational by then?
>
> They serve different masters.
>
> Earlyprintk can be crucial for debugging arch-dependent code. For example,
> earlycon expects page tables to be setup, whereas earlyprintk on many
> arches does not. Earlyprintk is not tied to the driver source at all.
>
> Earlycon is arch-independent and lives with the serial drivers. This makes
> it more suitable to support different flavors of serial h/w. Earlycon is
> now the boot console for driver developers and post-early init.

Ok, thanks for the explanation.
Out of curiosity:
Do you know what is the difference between "earlycon" and "console"?
I mean, why would one need "earlycon" if there's already "earlyprintk"?
Why does it matter if support is in arch-dependent or arch-independent 
code?, as long as it works, it shouldn't matter, right?
Why couldn't driver developers use the "earlyprintk" facilities?

Sorry for all the questions, I'm just curious about all these facilities.
I mean, maintaining all of them requires work and is error prone (as the 
crash above shows), so I'd like to understand why are you guys keeping 
them all.

>
> I've noticed an increasing tendency for shipping product to also use
> earlyprintk/earlycon; I think this is a terrible idea. Boot consoles should
> be for debugging only.
>
>
>
>>> Feel free to submit regular patches; reading the divisor via the 8250 port
>>> driver is definitely a good idea.
>>>
>>> Not to sure about probing for other than baud though; do you really want
>>> 7 data bits and even parity?  Or are you just trying to get enable h/w
>>> flow?
>>>
>>
>> Actually, I was doing that for completeness, I can remove that part
>> of the code if it is wrong or unnecessary, although I'd thought that
>> one always wanted correct code.
>
> Well, it's just one more thing to have to maintain, so if you don't actually
> need those features, I'd rather not add that.

Ok, what about posting that as a separate patch in case somebody else 
needs it, would that be ok with you?

Thanks, regards,


Sebastian

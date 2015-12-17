From: Sebastian Frias <sf84@laposte.net>
Subject: Re: [RFC PATCH] always probe UART HW when options are not specified
Date: Thu, 17 Dec 2015 19:21:41 +0100
Message-ID: <5672FD35.5070609@laposte.net>
References: <5672D18E.8000301@laposte.net> <5672E2CF.6080705@hurleysoftware.com> <5672E76A.3010506@laposte.net> <5672F588.8070503@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5672F588.8070503@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Hurley <peter@hurleysoftware.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, mason <slash.tmp@free.fr>, =?UTF-8?B?TcOlbnMgUnVsbGfDpXJk?= <mans@mansr.com>
List-Id: linux-serial@vger.kernel.org

Hi Peter,

On 12/17/2015 06:48 PM, Peter Hurley wrote:
> Hi Sebastian,
>
> On 12/17/2015 08:48 AM, Sebastian Frias wrote:
>> On 12/17/2015 05:29 PM, Peter Hurley wrote:
>>> On 12/17/2015 07:15 AM, Sebastian Frias wrote:
>>>> ---
>>>>
>>>> I think there are a few minor bugs on the 8250 UART code.
>>>>
>>>> Below you can find a patch with a proposed solution.
>>>>
>>>> In a nutshell:
>>>> - probe_baud from 87515772c33ee8a0cc08d984a7d2401eeff074cd was
>>>> converted into probe_port so that it reads all the parameters that
>>>> uart_set_options require (namely baud, parity, bits, flow).
>>>> - reading/writing to UART_DLL/UART_DLM directly are converted to
>>>> using the read_dl/write_dl callbacks.
>>>> - the port is always probed if there are no options (*).
>>>
>>> Because I don't want to probe the port at all.
>>>
>>> But must when using the
>>>      earlycon=ttyS0,....
>
> Sorry, ignore this. I meant "console=uart"
>
>>> command-line (because the original hack expects that behavior).
>>
>> Ok, we are using:
>>
>> "console=ttyS0 earlyprintk"
>>
>> and the 8250 (with CONFIG_SERIAL_8250_RT288X=y) driver.
>>
>> The hardware is setup prior to Linux boot.
>> We don't want Linux to change the UART settings, just to pick up whatever settings the UART has and take over UART.
>>
>> How do you suggest we do that? Right now, since it does not probe, it just messes up the UART config setup before booting Linux.
>>
>> While on the subject, do you think you could explain the difference (or similarity) between:
>> - "console=ttyS0"
>> - "console=uart"
>> - "earlycon=uart"
>> and how they relate to "earlyprintk" (if at all)?
>>
>> Maybe some of those options are soon to be deprecated and we'd like to stick with the standard and future-proof way.
>
> All of the above choices are future-proof because kernel command
> line options are considered userspace.
>

It's confusing though, given there are multiple ways to express the same 
thing.
I also found parts of the doc confusing in that regard as well.
ie: there's also a "stdout-path" DT key.

> So
>
>    "console=ttyS0" w/o options    always initializes the h/w to 9600n81

Ok, I see. So that's not the option we need then.

>    "earlycon=uart" w/o options    starts a bootconsole w/o initializing the h/w
>    "console=uart" w/o options     starts a bootconsole w/o initializing the h/w,
>                                   then replaces that bootconsole with a regular
>                                   console (whatever ttySn matched that port)
>                                   In this case, the port is probed to discover
>                                   the h/w settings. Those also become the initial
>                                   settings for the /dev/ttySn device.

Ok, sounds like that last one is the one we need, I will check that, thanks.

>
> earlyprintk is implemented by arch-specific code, whereas earlycon is implemented
> by the serial driver code.
>
> Since earlyprintk is implemented in the arch code, it can be tweaked for
> earlier use than early param parsing. There were some patches earlier this
> year for x86 to initialize earlyprintk very early; not sure if they were
> ever upstreamed. On ARM, earlyprintk is debug_ll.

So there are 3 levels of console?
earlyprintk: before early param
earlycon: early param?
console: after early param?

What's the use case for earlycon if earlyprink is operational by then?

>
> Feel free to submit regular patches; reading the divisor via the 8250 port
> driver is definitely a good idea.
>
> Not to sure about probing for other than baud though; do you really want
> 7 data bits and even parity?  Or are you just trying to get enable h/w
> flow?
>

Actually, I was doing that for completeness, I can remove that part of 
the code if it is wrong or unnecessary, although I'd thought that one 
always wanted correct code.
In our case, just forcing the probe was enough because only the baud 
rate could change, but if other parameters were to differ, set_termios 
would overwrite them with the "n8r" defaults.

Thanks, regards,

Sebastian

From: Sebastian Frias <sf84@laposte.net>
Subject: Re: [RFC PATCH] always probe UART HW when options are not specified
Date: Tue, 12 Jan 2016 15:14:31 +0100
Message-ID: <56950A47.1070708@laposte.net>
References: <5672D18E.8000301@laposte.net> <5672E2CF.6080705@hurleysoftware.com> <5672E76A.3010506@laposte.net> <5672F588.8070503@hurleysoftware.com> <5672FD35.5070609@laposte.net> <56731689.70702@hurleysoftware.com> <56740FC3.50302@laposte.net> <5674204C.1000907@hurleysoftware.com> <56782DE5.7090708@laposte.net> <56798EC7.1030804@laposte.net> <5693C52B.90003@laposte.net> <5693D41E.8050601@hurleysoftware.com> <5693ECBA.50003@laposte.net> <5693FD3C.5080601@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5693FD3C.5080601@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Hurley <peter@hurleysoftware.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, mason <slash.tmp@free.fr>, =?UTF-8?B?TcOlbnMgUnVsbGfDpXJk?= <mans@mansr.com>
List-Id: linux-serial@vger.kernel.org

Hi Peter,

On 01/11/2016 08:06 PM, Peter Hurley wrote:
> On 01/11/2016 09:56 AM, Sebastian Frias wrote:
>> Hi Peter,
>>
>> On 01/11/2016 05:11 PM, Peter Hurley wrote:
>>> On 01/11/2016 07:07 AM, Sebastian Frias wrote:
>>>> On 12/22/2015 06:56 PM, Sebastian Frias wrote:
>>>>>
>>>>>        OF_EARLYCON_DECLARE(rt2880, "ralink,rt2880-uart",
>>>>> early_serial8250_setup);
>>>
>>> There is no support for this uart in 8250 earlycon; the registers
>>> need remapped.
>>
>> Ok, two questions then:
>> 1) If the UART is not supported on 8250 earlycon, what is the
>> suggested/advised solution? Using just "earlyprintk"?
>
> I don't have enough information to suggest what you "should" use
> here.
>
> Is this going to be a shipping product?
> Is it single-core?
> etc.
>
> And what is your purpose for outputting early boot information
> before loading the serial driver which does provide console output?
>

No, it is not for production, just for debug, but we would like to 
understand if there is a standard way of doing so, so that whenever 
somebody ask us for "early print", we can provide with the good way.
I know we can always provide with hacks, I'm just wondering if there's a 
"standard way".

>
>> 2) What would it take to make the "rt2880" work with the 8250
>> earlycon? I mean, it is already pretty much supported in there, what
>> would be missing? (I don't see why it blocks on earlycon_map) And
>> would it be worth doing?
>
> The rt2880 does not have the same register locations as a 8250.
> The 8250 port driver remaps all register accesses with a LUT.
>
> Adding support would be trivial.

Ok, I will see if I can find some commit that does something similar to 
get some inspiration.

>
>>>>> at the end of the file, trying to mimic commit
>>>>> d05f15707bb7659d2b863fafa1a918f286d74a63
>>>>>
>>>>> I'm still trying to figure out the right bootargs, so that's why both
>>>>> "earlycon" and "console" are there. Suggestions welcome.
>>>
>>> Just 'earlycon' triggers the attempted registration of earlycon matching the
>>> compatible string of the stdout-path node.
>>>
>>> The empty 'console' in bootargs is doing nothing.
>>
>> Ok, thanks.
>>
>> So, just to recap.
>> We would like to understand what is the right way of doing this:
>>
>> - we are using 8250 (rt288x variant) UART: CONFIG_SERIAL_8250_RT288X=y
>> - the UART hardware is setup prior to Linux boot
>> - we don't want Linux to change the UART settings, just to pick up
>> whatever settings the UART has and take over the UART.
>> There were two replies to that, one by Greg Kroah-Hartman
>> (http://www.spinics.net/lists/linux-serial/msg20278.html) and one by
>> you, where you suggested we use "console=uart", but as I reported
>> (http://www.spinics.net/lists/linux-serial/msg20307.html) it does not
>> work, you replied that iotype and mmio are not optional but mandatory
>> (http://www.spinics.net/lists/linux-serial/msg20310.html), and I
>> wondered if it was really necessary to duplicate data that is already
>> on the DT among other questions
>
> At the time, I didn't know you were describing your h/w with DT.

Oh, sorry for the inconvenience then.

>
> If you use the console command line (console= or earlycon=) to start
> an earlycon, then the uart address and iotype are mandatory.
> For this usage, earlycon matching is attempted with every EARLYCON_DECLARE().
>
> If you use plain "earlycon" on the command line, that will attempt to
> register the uart described by stdout-path in DT. For this usage,
> earlycon matching is attempted with the compatible string of every
> OF_EARLYCON_DECLARE().

I see, and since rt288x variant is not fully supported (no 
OF_EARLYCON_DECLARE) "earlycon" fails.

>
>> (http://www.spinics.net/lists/linux-serial/msg20383.html), like how
>> are DT described drivers supposed to interact with the
>> "console="/"earlycon=" commandlines
>
> They don't; those are orthogonal.

Ok.

>
>> , or, the contradiction between
>> "console=ttyS0" means '9600n81' and "if unspecified [the uart
>> options], the h/w is not re-initialized">
>
> I thought I was clear on that: "console=ttyS0" initializes the h/w
> to 9600n81 *because there are already existing users that must not break*.
>
> "console=uart,..." probes the h/w
> *because there are already existing users that must not break *

Thanks, I had misunderstood.

>
>> So, for us, it is still not clear what is the recommended way of
>> achieving our goal above, and it seems it is not clear what does
>> "console=ttyS0" is supposed to do, hardcode ('9600n81') or probe
>> ('the h/w is not re-initialized')
>
> The DT way will be simplest at this point because you won't
> have to write console handover matching for "console=rt288x,..."
>
> With DT (ie, stdout-path) earlycon, when a serial driver loads,
> an attempt is made to cross-reference any existing console with
> the node that is loading and will do a console takeover from
> a running earlycon for a matching uart node.
>
> There is a bug with DT earlycon though.
> If you have a dummy console that loads, the DT earlycon is
> disabled at that point because boot consoles are disabled when
> "real" consoles load.

I'm sorry for my ignorance, but what is a "dummy console"? Under what 
circumstances would it load and this bug be seen?

Regards,

Sebastian

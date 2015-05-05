From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: earlycon: no match?
Date: Tue, 05 May 2015 14:15:37 -0400
Message-ID: <554908C9.7060300@hurleysoftware.com>
References: <20150503211054.GR15254@pengutronix.de> <55477BC1.6000805@hurleysoftware.com> <20150504194229.GR15254@pengutronix.de> <5547D4DB.8060300@hurleysoftware.com> <20150504205241.GT15254@pengutronix.de> <5547E447.9020604@hurleysoftware.com> <20150504215832.GW15254@pengutronix.de> <5547F350.7030405@hurleysoftware.com> <20150505045139.GY15254@pengutronix.de> <55489DF3.3070703@hurleysoftware.com> <20150505163217.GK14416@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150505163217.GK14416@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Robert Schwebel <r.schwebel@pengutronix.de>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@pengutronix.de
List-Id: linux-serial@vger.kernel.org

On 05/05/2015 12:32 PM, Robert Schwebel wrote:
> On Tue, May 05, 2015 at 06:39:47AM -0400, Peter Hurley wrote:
>>>> Further, I would ask how _you_ would programmatically distinguish
>>>> misspellings amongst the following console strings?
>>>>
>>>> 	console=pl012,...
>>>> 	console=_pl011,...
>>>> 	console=pl,...
>>>> 	console=ttyAMA0,...
>>>
>>> Only the last line gives me output, but with the warning. All others are
>>> misspellings but output nothing. The last one gives me a misspelling
>>> warning, but it is the one that makes the output work.
>>>
>>> Obviously this was not tested on an ARM device with a serial console,
>>> because it doesn't work there.
>>
>> The primary test platform was a ARM device with a serial console.
>> And yes, it does work there.
> 
> Which ARM device was that, and which serial driver?

AM3358 Beaglebone Black Rev. C, omap_8250 driver.

Requires patchset "Earlycon cleanup" which is not yet upstream,
but you can find it on LKML or linux-serial.

That patchset depends on "libfdt: Add fdt_path_offset_namelen", which
is in upstream dtc tree but has not been imported into mainline tree yet.

https://lkml.org/lkml/2015/4/28/387


> How did the kernel command line look like?

Kernel command line
   earlycon=omap8250,0x44e09000,115200n8 console=ttyS0,115200n8 root=/dev/mmcblk0p2 \
	ro fixrtc rootfstype=ext4 rootwait

I've also tested
   console=omap8250,0x44e09000,115200n8 ....

with a private version of the 8250_omap driver which implements
earlycon->console handoff.

I've also tested various DT and command line mixes of same, with and
with the <options> parameter.


> Maybe that helps me to understand how this is supposed to be used, which
> is currently totally unclear.
> 
>>> Case A: console=ttyAMA0
>>>
>>>   Result: - system boots with output on intended serial console
>>>           - warning about having the earlycon misspelled
>>>           - earlycon not operational, although driver supports it
>>>
>>> Case B: console=pl011
>>>
>>>   Result: - no output at all, because system doesn't output to its
>>>             intented serial console.
>>>
>>> Case C: ...?
>>>
>>>   Are there other things I'm supposed to do in order to do it right?
>>>
>>> So both cases A+B are not fully working as intented, right?
>>>
>>> I'd like to fix it, but in order to do so, I want to learn how it is
>>> actually *intended* to work.
>>
>> What do you want to "fix"?
>>
>> Please stop using the indefinite pronoun, "it". I have no idea to what
>> you are referring, because I already supplied you with a patch to "fix"
>> the loglevel of the message.
> 
> I have explained that above, under "Case A" and "Case B"...?

Go back and read what you wrote under "Case A" and "Case B". Both
descriptions simply report what happened. Neither description identifies
what you are trying to accomplish.

> Sorry, I simply don't get it.
>
> My task:
> 
>   I want to setup a vexpress system with a pl011 serial port in a
>   way that the console + early console is configured to be on
>   /dev/ttyAMA0.

Ok. This is the _first_ time you have written what you are trying
to accomplish.


Step #1: grab fixmap support for ARM patch from LKML

    "[RFC PATCH] ARM: add fixmap based earlycon support" by Ard Biesheuvel
      - or -
    "[PATCH] ARM: early fixmap support for earlycon" by Stefan Agner

Neither patch is upstream yet; I'm not really sure what's going on
with ARM patches right now.


Step #2: configure earlycon from kernel command line

    earlycon=pl011,<addr of uart0> console=ttyAMA0,115200n8



(Optional) Step #3 - implement pl011 -> ttyAMA0 console mapping

    I already wrote how to do this in my first email in this thread.

If you've done step #3, then you can change your kernel command line to
simply read:

    console=pl011,<addr of uart0>

which will start an earlycon and then handoff to /dev/ttyAMA0 automatically
(if you've implemented step #3).

Regards,
Peter Hurley

From: Sebastian Frias <sf84@laposte.net>
Subject: Re: [RFC PATCH] always probe UART HW when options are not specified
Date: Wed, 13 Jan 2016 12:14:04 +0100
Message-ID: <5696317C.4020709@laposte.net>
References: <5672D18E.8000301@laposte.net> <5672E2CF.6080705@hurleysoftware.com> <5672E76A.3010506@laposte.net> <5672F588.8070503@hurleysoftware.com> <5672FD35.5070609@laposte.net> <56731689.70702@hurleysoftware.com> <56740FC3.50302@laposte.net> <5674204C.1000907@hurleysoftware.com> <56782DE5.7090708@laposte.net> <56798EC7.1030804@laposte.net> <5693C52B.90003@laposte.net> <5693D41E.8050601@hurleysoftware.com> <5693ECBA.50003@laposte.net> <5693FD3C.5080601@hurleysoftware.com> <5694C94B.3090405@free.fr> <56950C21.3010805@laposte.net> <5695584E.3040902@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5695584E.3040902@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Hurley <peter@hurleysoftware.com>
Cc: Mason <slash.tmp@free.fr>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Mans Rullgard <mans@mansr.com>
List-Id: linux-serial@vger.kernel.org

Hi Peter,

On 01/12/2016 08:47 PM, Peter Hurley wrote:
> On 01/12/2016 06:22 AM, Sebastian Frias wrote:
>>
>> For the record, I'm using a SoC emulator, and thus do not have a bootloader per se and there are a bunch of other things that I cannot count on.
>> The emulator has the UART pre-setup, so I just need Linux to take over without changing the parameters.
>> Ideally, I would like to have the same image of Linux+DT to start in any instance of the emulator or real chips, regardless of the clock ratios, that's why I sort of need Linux to not change the UART speed, which is quite tricky because there are no clock generators in the emulator.
>
> Got it, thanks for the info.
> Please test the series I just cc'd you on plus the patch I sent
> you yesterday.
>
> That should get you an earlycon up and running on that simulator;
> let me know if it doesn't and we'll go from there.

Ok, thanks.
I will try as soon as we finish rebasing our changes on top of 
"mainline" (or HEAD, or is it "-next"? I don't know how you guys call 
the most recent code base for Linux)

Actually, I tried yesterday on a 4.1.13 but 
"[drivers/tty/serial/earlycon.c:62] earlycon_map()" was still the last 
message I got, just as with the OF_EARLYCON_DECLARE hack I had 
previously talk about, and so I would like to test on the same 
conditions than you, mainline.

>
>> NOTE: on my tree I'm using the patch I previously submitted here, so Linux is probing the UART so it works for all my cases, but I would like to go back to a standard tree.
>
> I expect that patch to go into -next sometime during the 4.5-rc cycle.

Sounds good!
Thanks,

Sebastian

>
>
> Regards,
> Peter Hurley
>
>>> Note: calling the UART driver "Au1x00/RT288x" is a bit of a misnomer,
>>> as these are names of SoCs using that distinct register layout.
>>> The actual IP is probably the 16550-compatible Palmchip BK-3103.
>>> https://sites.google.com/a/palmchiptech.com/palmchiptech/product-services/hardware-services/ip-cores/bk-3103
>>> (Not sure that this website is legitimate, though.)
>>>
>>> When I need earlyprintk support, I use this patch from Mans:
>>> http://thread.gmane.org/gmane.linux.kernel/2081016
>>>
>>> Regards.
>>>
>

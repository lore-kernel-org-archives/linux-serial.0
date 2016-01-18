From: Sebastian Frias <sf84@laposte.net>
Subject: Re: [RFC PATCH] always probe UART HW when options are not specified
Date: Mon, 18 Jan 2016 12:52:51 +0100
Message-ID: <569CD213.9020009@laposte.net>
References: <5672D18E.8000301@laposte.net> <5672E2CF.6080705@hurleysoftware.com> <5672E76A.3010506@laposte.net> <5672F588.8070503@hurleysoftware.com> <5672FD35.5070609@laposte.net> <56731689.70702@hurleysoftware.com> <56740FC3.50302@laposte.net> <5674204C.1000907@hurleysoftware.com> <56782DE5.7090708@laposte.net> <56798EC7.1030804@laposte.net> <5693C52B.90003@laposte.net> <5693D41E.8050601@hurleysoftware.com> <5693ECBA.50003@laposte.net> <5693FD3C.5080601@hurleysoftware.com> <5694C94B.3090405@free.fr> <56950C21.3010805@laposte.net> <5695584E.3040902@hurleysoftware.com> <5696317C.4020709@laposte.net> <56967C7F.4060705@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <56967C7F.4060705@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Hurley <peter@hurleysoftware.com>
Cc: Mason <slash.tmp@free.fr>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Mans Rullgard <mans@mansr.com>
List-Id: linux-serial@vger.kernel.org

Hi Peter,

On 01/13/2016 05:34 PM, Peter Hurley wrote:
> On 01/13/2016 03:14 AM, Sebastian Frias wrote:
>> Hi Peter,
>>
>> On 01/12/2016 08:47 PM, Peter Hurley wrote:
>>> On 01/12/2016 06:22 AM, Sebastian Frias wrote:
>>>>
>>>> For the record, I'm using a SoC emulator, and thus do not have a bootloader per se and there are a bunch of other things that I cannot count on.
>>>> The emulator has the UART pre-setup, so I just need Linux to take over without changing the parameters.
>>>> Ideally, I would like to have the same image of Linux+DT to start in any instance of the emulator or real chips, regardless of the clock ratios, that's why I sort of need Linux to not change the UART speed, which is quite tricky because there are no clock generators in the emulator.
>>>
>>> Got it, thanks for the info.
>>> Please test the series I just cc'd you on plus the patch I sent
>>> you yesterday.
>>>
>>> That should get you an earlycon up and running on that simulator;
>>> let me know if it doesn't and we'll go from there.
>>
>> Ok, thanks.
>> I will try as soon as we finish rebasing our changes on top of
>> "mainline" (or HEAD, or is it "-next"? I don't know how you guys call
>> the most recent code base for Linux)
>
> The basic tree organization is
>
>     Linus's tree  <---- linux-next[date]  <----- maintainers' trees
>     (mainline)          (next)                   (eg., Greg's tty tree)
>
> The patches I sent you (along with any required modifications during the
> review cycle) are based on the tty-next branch in Greg's tty tree here
> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git
>
> As of this email, Greg's tree is based on Linus's 4.4-rc6 which should
> be stable enough for you to test these patches on.

Thanks for your explanation :-)

>
>> Actually, I tried yesterday on a 4.1.13 but
>> "[drivers/tty/serial/earlycon.c:62] earlycon_map()" was still the
>> last message I got, just as with the OF_EARLYCON_DECLARE hack I had
>> previously talk about, and so I would like to test on the same
>> conditions than you, mainline.
>
> So just to confirm, you applied "8250: Add Au1x00/RT288x earlycon support"
> to 4.1.13 and the earlycon didn't come up when you used the kernel
> command line option like so:
>
> 	earlycon=rt288x,mmio32,0x10700
>
> Is that correct?
>

Sort of, I applied your patch "8250: Add Au1x00/RT288x earlycon 
support", and then tried with something like:

	aliases {
		serial0 = &uart;
	};

	chosen {
		bootargs = "earlycon console mem=256M earlyprintk debug ignore_loglevel";
		stdout-path = "serial0:115200n8";
	};

	uart: serial@10700 {
		compatible = "ralink,rt2880-uart";
		reg = <0x10700 0x30>;
		interrupts = <1 IRQ_TYPE_LEVEL_HIGH>;
		clock-frequency = <7372800>;
		reg-shift = <2>;
	};

I can see that the code is correctly picking up the rt288x from the DT 
(I put logs):

...
[drivers/of/fdt.c:834] early_init_dt_scan_chosen_serial(): 
'ralink,rt2880-uart'
[drivers/tty/serial/earlycon.c:239] of_setup_earlycon(): addr=00010700 
setup@c024c14c
[drivers/tty/serial/earlycon.c:62] earlycon_map(): paddr 0x00010700 size 
4096

(last log visible on UART)

where 0xc024c14c resolves to 'early_rt288x_setup' from your patch (in 
the disassembly)

This happens when parsing the first token of the bootargs, "earlycon".

I will let you know how it goes the tests on 4.4.

Best regards,

Sebastian

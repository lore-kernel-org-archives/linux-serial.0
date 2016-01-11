From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [RFC PATCH] always probe UART HW when options are not specified
Date: Mon, 11 Jan 2016 08:11:10 -0800
Message-ID: <5693D41E.8050601@hurleysoftware.com>
References: <5672D18E.8000301@laposte.net>
 <5672E2CF.6080705@hurleysoftware.com> <5672E76A.3010506@laposte.net>
 <5672F588.8070503@hurleysoftware.com> <5672FD35.5070609@laposte.net>
 <56731689.70702@hurleysoftware.com> <56740FC3.50302@laposte.net>
 <5674204C.1000907@hurleysoftware.com> <56782DE5.7090708@laposte.net>
 <56798EC7.1030804@laposte.net> <5693C52B.90003@laposte.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5693C52B.90003@laposte.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Frias <sf84@laposte.net>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, mason <slash.tmp@free.fr>, =?UTF-8?B?TcOlbnMgUnVsbGfDpXJk?= <mans@mansr.com>
List-Id: linux-serial@vger.kernel.org

On 01/11/2016 07:07 AM, Sebastian Frias wrote:
> On 12/22/2015 06:56 PM, Sebastian Frias wrote:
>> On 12/21/2015 05:50 PM, Sebastian Frias wrote:
>>>> You need to use the format documented in
>>>> Documentation/kernel-parameters.text:
>>>>
>>>>     console=    [KNL] Output console device and options.
>>>>
>>>>         uart[8250],io,<addr>[,options]
>>>>         uart[8250],mmio,<addr>[,options]
>>>>         uart[8250],mmio16,<addr>[,options]
>>>>         uart[8250],mmio32,<addr>[,options]
>>>>         uart[8250],0x<addr>[,options]
>>>>             Start an early, polled-mode console on the 8250/16550
>>>>             UART at the specified I/O port or MMIO address,
>>>>             switching to the matching ttyS device later.
>>>>             MMIO inter-register address stride is either 8-bit
>>>>             (mmio), 16-bit (mmio16), or 32-bit (mmio32).
>>>>             If none of [io|mmio|mmio16|mmio32], <addr> is assumed
>>>>             to be equivalent to 'mmio'. 'options' are specified in
>>>>             the same format described for ttyS above; if unspecified,
>>>>             the h/w is not re-initialized.
>>>>
>>>> The iotype and the uart address are not options.
>>>
>>> Do you mean they are mandatory?
>>> How do they relate to the keys present on the DT? Because the device is
>>> already described in the DT:
>>>
>>>          uart: serial@10700 {
>>>              compatible = "ralink,rt2880-uart";
>>>              reg = <0x10700 0x30>;
>>>              interrupts = <1 IRQ_TYPE_LEVEL_HIGH>;
>>>              clock-frequency = <7372800>;
>>>              reg-shift = <2>;
>>>          };
>>>
>>> Are we supposed to duplicate such information (ie: addr) in the
>>> commandline as well?
>>>
>>
>> By the way, I tried using the following command line
>> 'console=uart,mmio32,0x10700,115200n8r mem=256M earlyprintk debug
>> ignore_loglevel' but I think I'm still missing something regarding this,
>> because it does not work, here's a log of Linux 4.1.13+:
>>
>>
>> 1: [arch/arm/kernel/setup.c:932] setup_arch(): r1 = 0xf34, r2 =
>> 0x803b3b50, cmdline ''
>> 1: [arch/arm/kernel/devtree.c:195] arch_get_next_mach(): infoBegin
>> 0xc024faac, mdesc 0xc024faac
>> 1: [arch/arm/kernel/devtree.c:195] arch_get_next_mach(): infoBegin
>> 0xc024faac, mdesc 0xc024fb14
>> 1: [drivers/of/fdt.c:106] of_fdt_is_compatible(): sigma,tango4 vs
>> sigma,vantage-1172
>> 1: [arch/arm/kernel/devtree.c:195] arch_get_next_mach(): infoBegin
>> 0xc024faac, mdesc 0xc024fb7c
>> 1: [drivers/of/fdt.c:749] of_flat_dt_match_machine(): Machine model:
>> Sigma Designs SMP8758 Vantage-1172 Rev E1
>> 1: [arch/arm/kernel/devtree.c:256] setup_machine_fdt(): about to call
>> early_init_dt_scan_nodes
>> 1: [drivers/of/fdt.c:1057] early_init_dt_scan_nodes(): bootcmdline ''
>> 1: [drivers/of/fdt.c:1062] early_init_dt_scan_nodes(): bootcmdline after
>> of_scan_flat_dt 'console=uart,mmio32,0x10700,115200n8r mem=256M
>> earlyprintk debug ignore_loglevel'
>> 1: [arch/arm/kernel/setup.c:946] setup_arch(): using DT at r2
>> 1: [arch/arm/kernel/setup.c:949] setup_arch(): machine name Sigma Tango DT
>> 1: [arch/arm/kernel/setup.c:967] setup_arch(): before parse_early_param
>> 1: [init/main.c:468] parse_early_param(): bootcmdline
>> 'console=uart,mmio32,0x10700,115200n8r mem=256M earlyprintk debug
>> ignore_loglevel'
>> 1: [init/main.c:473] parse_early_param(): mark
>> 1: [init/main.c:428] do_early_param(): enter with: 'console'
>> 'uart,mmio32,0x10700,115200n8r'
>> 1: [init/main.c:446] do_early_param(): 'earlycon', setup_func 0xc024b868
>> 1: [drivers/tty/serial/earlycon.c:214] param_setup_earlycon():
>> 'uart,mmio32,0x10700,115200n8r'
>> 1: [drivers/tty/serial/earlycon.c:181] setup_earlycon():
>> 'uart,mmio32,0x10700,115200n8r'
>> 1: [drivers/tty/serial/earlycon.c:132] register_earlycon():
>> 'mmio32,0x10700,115200n8r' 'uart'
>> 1: [drivers/tty/serial/earlycon.c:86] parse_options():
>> 'mmio32,0x10700,115200n8r'
>> 1: [drivers/tty/serial/earlycon.c:91] parse_options(): addr 0x00010700,
>> options '115200n8r'
>> 1: [drivers/tty/serial/earlycon.c:117] parse_options(): Early serial
>> console at MMIO32 0x10700 (options '115200n8r')
>> 1: [drivers/tty/serial/earlycon.c:138] register_earlycon(): '(null)'
>> 1: [drivers/tty/serial/earlycon.c:62] earlycon_map(): paddr 0x00010700
>> size 64
>>
>> As you can see, now that the options are more complete, the match for
>> "earlycon" succeeds, but it does not work, the last log is in
>> earlycon_map() function.
>> When using just "console=uart", the "earlycon" match will fail but a
>> match for "earlyprink" will succeed. That one will hook printch() from
>> the arch-dependent code to a somewhat simpler 'earlycon'
>> (arch/arm/kernel/early_printk.c).
>>
>> I think the code is the same on mainline.
>>
>> Also, regarding my previous question about using a HW described in DT
>> for earlycon, I noticed there's a of_setup_earlycon() in
>> drivers/tty/serial/earlycon.c but that is hooked to
>> drivers/of/fdt.c:setup_of_earlycon() which is not called. I do have
>> CONFIG_SERIAL_EARLYCON=y.
>>
>> I also have a similar issue (ie: get blocked right after the call to
>> earlycon_map function, log is obviously different from above) if attempt
>> to use of_setup_earlycon.
>> My DT has roughly:
>>
>>      aliases {
>>          serial0 = &uart;
>>      };
>>
>>      chosen {
>>             bootargs = "earlycon console mem=256M earlyprintk debug
>> ignore_loglevel";
>>             stdout-path = "serial0:115200n8";
>>      };
>>
>>      uart: serial@10700 {
>>          compatible = "ralink,rt2880-uart";
>>          reg = <0x10700 0x30>;
>>          interrupts = <1 IRQ_TYPE_LEVEL_HIGH>;
>>          clock-frequency = <7372800>;
>>          reg-shift = <2>;
>>      };
>>
>>
>> and then I hack drivers/tty/serial/8250/8250_early.c by adding:
>>
>>      OF_EARLYCON_DECLARE(rt2880, "ralink,rt2880-uart",
>> early_serial8250_setup);

There is no support for this uart in 8250 earlycon; the registers
need remapped.

>> at the end of the file, trying to mimic commit
>> d05f15707bb7659d2b863fafa1a918f286d74a63
>>
>> I'm still trying to figure out the right bootargs, so that's why both
>> "earlycon" and "console" are there. Suggestions welcome.

Just 'earlycon' triggers the attempted registration of earlycon matching the
compatible string of the stdout-path node.

The empty 'console' in bootargs is doing nothing.


> Does anybody has comments or suggestions regarding this thread and the issue above?

Regards,
Peter Hurley

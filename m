From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [PATCH] serial: 8250_uniphier: add earlycon support
Date: Thu, 5 Nov 2015 11:48:00 -0500
Message-ID: <563B8840.9060109@hurleysoftware.com>
References: <1445503154-14340-1-git-send-email-yamada.masahiro@socionext.com>
 <5630E7DC.3050506@hurleysoftware.com>
 <CAK7LNATGWRwitQVNsiFiiojE3JLYdO6DPY74LSbJ3jw4mg6HdQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAK7LNATGWRwitQVNsiFiiojE3JLYdO6DPY74LSbJ3jw4mg6HdQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Jiri Slaby <jslaby@suse.com>
List-Id: linux-serial@vger.kernel.org

Hi Masahiro,

Apologies for the delay in reply; I didn't see the lower part of your email.


On 10/28/2015 09:49 PM, Masahiro Yamada wrote:
>>> +#if IS_ENABLED(CONFIG_SERIAL_8250_CONSOLE)
>>
>> #ifdef CONFIG_SERIAL_8250_CONSOLE
> 
> I am OK with this change because this CONFIG is boolean.
> 
> 
> I still believe
> 
> #if IS_ENABLED(CONFIG_FOO)
> 
> is a nice shorthand for
> 
> #if defined(CONFIG_FOO) || defined(CONFIG_FOO_MODULE)
> 
> when CONFIG_FOO is tristate.

I agree.


>>> +static int __init uniphier_early_console_setup(struct earlycon_device *device,
>>> +                                            const char *options)
>>> +{
>>> +     if (!device->port.membase)
>>> +             return -ENODEV;
>>> +
>>> +     /* This hardware always expects MMIO32 register interface. */
>>> +     device->port.iotype = UPIO_MEM32;
>>> +     device->port.regshift = 2;
>>> +
>>> +     /*
>>> +      * Do not touch the divisor register in early_serial8250_setup();
>>> +      * we assume it has been initialized by a boot loader.
>>> +      */
>>> +     device->baud = 0;
>>> +
>>> +     return early_serial8250_setup(device, options);
>>> +}
>>> +OF_EARLYCON_DECLARE(uniphier_uart, "socionext,uniphier-uart",
>>> +                 uniphier_early_console_setup);
>>
>> Please change the earlycon name to just "uniphier" or "uniphier8250"; eg.,
>>
>> OF_EARLYCON_DECLARE(uniphier, "socionext,uniphier-uart",
>>                     uniphier_early_console_setup);
>>
>>
>> My earlycon series merges OF_EARLYCON_DECLARE() => EARLYCON_DECLARE()
>> and "uniphier" is simpler on the command line.
>>
> 
> I am also OK with this change, too.
> 
> But I still see  some *_serial and *_uart are used
> in EARLYCON_DECLARE.
> 
> yamada@beagle:~/workspace/linux/drivers/tty$ git grep -e
> 'EARLYCON_DECLARE(.*_uart'
> serial/8250/8250_ingenic.c:EARLYCON_DECLARE(jz4740_uart,
> ingenic_early_console_setup);
> serial/8250/8250_ingenic.c:OF_EARLYCON_DECLARE(jz4740_uart,
> "ingenic,jz4740-uart",
> serial/8250/8250_ingenic.c:EARLYCON_DECLARE(jz4775_uart,
> ingenic_early_console_setup);
> serial/8250/8250_ingenic.c:OF_EARLYCON_DECLARE(jz4775_uart,
> "ingenic,jz4775-uart",
> serial/8250/8250_ingenic.c:EARLYCON_DECLARE(jz4780_uart,
> ingenic_early_console_setup);
> serial/8250/8250_ingenic.c:OF_EARLYCON_DECLARE(jz4780_uart,
> "ingenic,jz4780-uart",
> serial/arc_uart.c:EARLYCON_DECLARE(arc_uart, arc_early_console_setup);
> serial/arc_uart.c:OF_EARLYCON_DECLARE(arc_uart, "snps,arc-uart",
> arc_early_console_setup);
> serial/bcm63xx_uart.c:OF_EARLYCON_DECLARE(bcm63xx_uart,
> "brcm,bcm6345-uart", bcm_early_console_setup);
> yamada@beagle:~/workspace/linux/drivers/tty$ git grep -e
> 'EARLYCON_DECLARE(.*_serial'
> serial/8250/8250_early.c:EARLYCON_DECLARE(uart8250, early_serial8250_setup);
> serial/8250/8250_early.c:EARLYCON_DECLARE(uart, early_serial8250_setup);
> serial/msm_serial.c:EARLYCON_DECLARE(msm_serial,
> msm_serial_early_console_setup);
> serial/msm_serial.c:OF_EARLYCON_DECLARE(msm_serial, "qcom,msm-uart",
> serial/msm_serial.c:EARLYCON_DECLARE(msm_serial_dm,
> msm_serial_early_console_setup_dm);
> serial/msm_serial.c:OF_EARLYCON_DECLARE(msm_serial_dm, "qcom,msm-uartdm",
> serial/sprd_serial.c:EARLYCON_DECLARE(sprd_serial, sprd_early_console_setup);
> serial/sprd_serial.c:OF_EARLYCON_DECLARE(sprd_serial, "sprd,sc9836-uart",

This brings up an important point: the names for EARLYCON_DECLARE() should not
be changed after being in at least one kernel release, since this would cause
existing command line setups to fail.

Regards,
Peter Hurley
 

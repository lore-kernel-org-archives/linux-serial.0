From: Andre Przywara <andre.przywara@arm.com>
Subject: Re: [RFC PATCH 1/1] drivers: introduce ARM SBSA generic UART driver
Date: Sat, 30 Aug 2014 00:10:39 +0100
Message-ID: <5401086F.1050601@arm.com>
References: <1409328803-1953-1-git-send-email-andre.przywara@arm.com> <1409328803-1953-2-git-send-email-andre.przywara@arm.com> <8453809.d9xRztN9Sq@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:60557 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750909AbaH2XNO (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 29 Aug 2014 19:13:14 -0400
In-Reply-To: <8453809.d9xRztN9Sq@wuerfel>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Cc: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, Russell King <linux@arm.linux.org.uk>, "linux@vger.kernel.org" <linux@vger.kernel.org>

On 08/29/2014 07:59 PM, Arnd Bergmann wrote:

Arnd,

thanks for looking at the patch.

> On Friday 29 August 2014 17:13:23 Andre Przywara wrote:
>> The ARM Server Base System Architecture (SBSA) describes a generic
>> UART which all compliant level 1 systems should implement. This is
>> actually a PL011 subset, so a full PL011 implementation will satisfy
>> this requirement.
>> However if a system does not have a PL011, a very stripped down
>> implementation complying to the SBSA defined specification will
>> suffice. The Linux PL011 driver is not guaranteed to drive this
>> limited device (and indeed the fast model implentation hangs the
>> kernel if driven by the PL011 driver).
>> So introduce a new driver just implementing the part specified by the
>> SBSA (which lacks DMA, the modem control signals and many of the
>> registers including baud rate control). This driver has been derived
>> by the actual PL011 one, removing all unnecessary code.
>>
>> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> 
> 
> Hi Andre,
> 
> Thanks for getting this driver ready. There is one high-level comment
> I have: As mentioned in the discussion in
> https://lkml.org/lkml/2014/7/28/386 , I think this should really be
> a tty driver using tty_port, not a serial driver using uart_port.
> 
> What is the reason you chose to do a uart_port driver?

Mainly because the SBSA is more of an UART than I originally
anticipated. It's intention may be more for debugging only, but it's
implementation is that of a real UART.
So the goldfish driver for instance seems to be tailored for a virtual
device, where TX/RX actually does not cost much. Also it supports
transmitting large chunks of data at once, an UART cannot do that. I
didn't find an obvious or easy way of implementing IRQ based
transmission. So if someone throws 10 KB at the driver, it will hog the
CPU for a second :-(

Also there is this console line ending issue. The UART layer takes care
about changing LF into CR/LF, but in a pure TTY driver this needs to be
done explicitly. Hooking this into the code was a real nightmare.

Also the error conditions the UART supports (frame error, break) are
hard to model in a pure TTY driver.

So after having coded it based on goldfish I decided to go for a real
UART driver instead, and the result is much better.

> 
> A few more details below:
> 
>> +}
>> +EARLYCON_DECLARE(pl011, sbsa_uart_early_console_setup);
>> +OF_EARLYCON_DECLARE(pl011, "arm,sbsa-uart", sbsa_uart_early_console_setup);
> 
> Stray 'pl011' left from copying the code?

Actually left in deliberately (to reuse existing kernel command lines),
but I know see that this was silly.
The earlycon routines of PL011 are actually the same as for the SBSA
UART, so both can use one implementation. And registering them twice
under the same name triggers a warning during boot.
I have to check how this can be shared if only one driver is compiled in.

>> +static struct uart_driver sbsa_uart_reg = {
>> +	.owner			= THIS_MODULE,
>> +	.driver_name		= "sbsa_uart",
>> +	.dev_name		= "ttyAMA",
>> +	.nr			= UART_NR,
>> +	.cons			= SBSA_UART_CONSOLE,
>> +};
> 
> I don't think we should overload the ttyAMA name.

That triggered a lot of discussion here. Actually most people don't want
to introduce yet another serial prefix. Also since the both devices are
so similar and this driver can drive a full PL011 also, I decided to
reuse it.
This still has issues if both drivers are active, but I consider this
saner for the user this way.

> 
>> +#ifdef CONFIG_OF
>> +
>> +static int dt_probe_serial_alias(int index, struct device *dev)
>> +{
>> +	struct device_node *np;
>> +	static bool seen_dev_with_alias;
>> +	static bool seen_dev_without_alias;
>> +	int ret = index;
>> +
>> +	if (!IS_ENABLED(CONFIG_OF))
>> +		return ret;
> 
> The #ifdef should go away since you already have the if
> (!IS_ENABLED(CONFIG_OF)) logic here.

Right, this is redundant, but I'd rather remove the IS_ENABLED() line,
since I provide a non-DT implementation of that routine below.

Cheers,
Andre.




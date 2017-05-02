From: Joel Stanley <joel@jms.id.au>
Subject: Re: [PATCH v3 2/2] drivers/serial: Add driver for Aspeed virtual UART
Date: Tue, 2 May 2017 17:15:36 +0930
Message-ID: <CACPK8XfCLxRkdAdmtgNLrTMwXzk8cRsfV2e16SCY6O6e73JNyg@mail.gmail.com>
References: <20170410040400.5509-1-joel@jms.id.au> <20170410040400.5509-3-joel@jms.id.au>
 <CAHp75Vd=oONhzF34Pe8WwYKBWWxcsaQtgJy66aFD68iNKTxEfg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAHp75Vd=oONhzF34Pe8WwYKBWWxcsaQtgJy66aFD68iNKTxEfg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>, Jeremy Kerr <jk@ozlabs.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, devicetree <devicetree@vger.kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, OpenBMC Maillist <openbmc@lists.ozlabs.org>
List-Id: linux-serial@vger.kernel.org

On Tue, Apr 11, 2017 at 9:45 PM, Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Mon, Apr 10, 2017 at 7:04 AM, Joel Stanley <joel@jms.id.au> wrote:
>> From: Jeremy Kerr <jk@ozlabs.org>
>>
>> This change adds a driver for the 16550-based Aspeed virtual UART
>> device. We use a similar process to the of_serial driver for device
>> probe, but expose some VUART-specific functions through sysfs too.
>>
>> The VUART is two UART 'front ends' connected by their FIFO (no actual
>> serial line in between). One is on the BMC side (management controller)
>> and one is on the host CPU side.
>>
>> This driver is for the BMC side. The sysfs files allow the BMC
>> userspace, which owns the system configuration policy, to specify at
>> what IO port and interrupt number the host side will appear to the host
>> on the Host <-> BMC LPC bus. It could be different on a different system
>> (though most of them use 3f8/4).
>>
>> OpenPOWER host firmware doesn't like it when the host-side of the
>> VUART's FIFO is not drained. This driver only disables host TX discard
>> mode when the port is in use. We set the VUART enabled bit when we bind
>> to the device, and clear it on unbind.
>>
>> We don't want to do this on open/release, as the host may be using this
>> bit to configure serial output modes, which is independent of whether
>> the devices has been opened by BMC userspace.
>
>> +static void aspeed_vuart_set_enabled(struct aspeed_vuart *vuart, bool enabled)
>> +{
>> +       u8 reg;
>> +
>> +       reg = readb(vuart->regs + ASPEED_VUART_GCRA);
>
>> +       reg &= ~ASPEED_VUART_GCRA_VUART_EN;
>> +       if (enabled)
>> +               reg |= ASPEED_VUART_GCRA_VUART_EN;
>
> Usually the pattern is
> if (something)
>  set x bit;
> else
>  clear x bit;
>
> It would make it one operation in any case and a bit more understandable.

I have made these ordering changes you requested.

>
>> +       port.port.irq = irq_of_parse_and_map(np, 0);
>
> The benefit of use platform_get_irq() is to get rid of some OF specific headers.

It's an of driver, and this function does exactly what we require. I
have left it in for v4.

Cheers,

Joel

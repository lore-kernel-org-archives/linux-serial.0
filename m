From: Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: [PATCH 4/4] tty: serial: 8250_mtk: Add support for bus clock
Date: Fri, 8 May 2015 10:59:25 +0200
Message-ID: <CABuKBe+_rphjcYziuNp8eUnM8=aP27v7NCivkg66pC0bBNE5VA@mail.gmail.com>
References: <1430117397-13517-1-git-send-email-s.hauer@pengutronix.de>
	<1430117397-13517-5-git-send-email-s.hauer@pengutronix.de>
	<CABuKBeLwXZPYLka53sDghMyN_dX0wWUh8XV4vMSanWBhXJjFew@mail.gmail.com>
	<20150505155030.GA6325@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150505155030.GA6325@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Greg KH <gregkh@linuxfoundation.org>, linux-mediatek@lists.infradead.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-serial@vger.kernel.org, Alan Cox <alan@linux.intel.com>
List-Id: linux-serial@vger.kernel.org

2015-05-05 17:50 GMT+02:00 Sascha Hauer <s.hauer@pengutronix.de>:
> On Tue, May 05, 2015 at 05:41:16PM +0200, Matthias Brugger wrote:
>> 2015-04-27 8:49 GMT+02:00 Sascha Hauer <s.hauer@pengutronix.de>:
>> > The mtk 8250 needs two clocks, one for providing the baudrate and
>> > one that needs to be enabled for register accesses. The latter has
>> > not been supported, this patch adds support for it. It is optional
>> > for now since not all SoCs provide a bus clock.
>> >
>> > Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
>> > ---
>> >  .../devicetree/bindings/serial/mtk-uart.txt        | 12 ++++++++--
>> >  drivers/tty/serial/8250/8250_mtk.c                 | 28 ++++++++++++++++++----
>> >  2 files changed, 34 insertions(+), 6 deletions(-)
>> >
>> > diff --git a/Documentation/devicetree/bindings/serial/mtk-uart.txt b/Documentation/devicetree/bindings/serial/mtk-uart.txt
>> > index 4415226..8d63f1d 100644
>> > --- a/Documentation/devicetree/bindings/serial/mtk-uart.txt
>> > +++ b/Documentation/devicetree/bindings/serial/mtk-uart.txt
>> > @@ -14,7 +14,14 @@ Required properties:
>> >
>> >  - interrupts: A single interrupt specifier.
>> >
>> > -- clocks: Clock driving the hardware.
>> > +- clocks : Must contain an entry for each entry in clock-names.
>> > +  See ../clocks/clock-bindings.txt for details.
>> > +- clock-names:
>> > +  - "baud": The clock the baudrate is derived from
>> > +  - "bus": The bus clock for register accesses (optional)
>> > +
>> > +For compatibility with older device trees an unnamed clock is used for the
>> > +baud clock if the baudclk does not exist. Do not use this for new designs.
>> >
>> >  Example:
>> >
>> > @@ -22,5 +29,6 @@ Example:
>> >                 compatible = "mediatek,mt6589-uart", "mediatek,mt6577-uart";
>> >                 reg = <0x11006000 0x400>;
>> >                 interrupts = <GIC_SPI 51 IRQ_TYPE_LEVEL_LOW>;
>> > -               clocks = <&uart_clk>;
>> > +               clocks = <&uart_clk>, <&bus_clk>;
>> > +               clock-names = "baud", "bus";
>> >         };
>> > diff --git a/drivers/tty/serial/8250/8250_mtk.c b/drivers/tty/serial/8250/8250_mtk.c
>> > index 2f28bd0..8eb3876 100644
>> > --- a/drivers/tty/serial/8250/8250_mtk.c
>> > +++ b/drivers/tty/serial/8250/8250_mtk.c
>> > @@ -34,6 +34,7 @@
>> >  struct mtk8250_data {
>> >         int                     line;
>> >         struct clk              *uart_clk;
>> > +       struct clk              *bus_clk;
>> >  };
>>
>> Not sure if it would be better to rename the uart_clk to baud_clk
>> which reflects the new naming scheme.
>
> Can do.

If you do so you can add:
Acked-by: Matthias Brugger <matthias.bgg@gmail.com>

Thanks,
Matthias
-- 
motzblog.wordpress.com

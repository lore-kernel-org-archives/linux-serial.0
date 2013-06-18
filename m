From: Tomasz Figa <t.figa@samsung.com>
Subject: Re: [PATCH v3 06/10] clk: exynos5420: register clocks using common
 clock framework
Date: Tue, 18 Jun 2013 16:26:56 +0200
Message-ID: <9285029.CIld1HyBWB@amdc1227>
References: <1371466836-4111-1-git-send-email-chander.kashyap@linaro.org>
 <CANuQgHHoUyE5e+MnnpzWLxcFNcD11FjYwx76pucw7peV4qmFkQ@mail.gmail.com>
 <201306181601.16795.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <201306181601.16795.arnd@arndb.de>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Chander Kashyap <chander.kashyap@linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Mark Rutland <mark.rutland@arm.com>, "kgene.kim@samsung.com" <kgene.kim@samsung.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, Thomas Abraham <thomas.abraham@linaro.org>, "thomas.ab@samsung.com" <thomas.ab@samsung.com>, "s.nawrocki@samsung.com" <s.nawrocki@samsung.com>
List-Id: linux-serial@vger.kernel.org

Hi Arnd,

On Tuesday 18 of June 2013 16:01:16 Arnd Bergmann wrote:
> On Tuesday 18 June 2013, Chander Kashyap wrote:
> > >> +       [Core Clocks]
> > >> +
> > >> +  Clock                      ID
> > >> +  ----------------------------
> > >> +
> > >> +  fin_pll            1
> > >> +
> > >> +  [Clock Gate for Special Clocks]
> > >> +
> > >> +  Clock                      ID
> > >> +  ----------------------------
> > >> +  sclk_uart0         128
> > >> +  sclk_uart1         129
> > >> +  sclk_uart2         130
> > >> 
> > >> +
> > >> +   [Peripheral Clock Gates]
> > >> +
> > >> +  Clock                      ID
> > >> +  ----------------------------
> > >> +
> > >> +  aclk66_peric               256
> > >> +  uart0                      257
> > >> +  uart1                      258
> > > 
> > > It looks like these are actually separate things. Wouldn't it be more
> > > sensible to have separate device nodes for each of the lists and use a
> > > local index?> 
> > I have listed the parent clock first, then the child clocks, to
> > maintain  readability.
> > 
> > > What numbers are used in the data sheet?
> > 
> > I didn't get your point?
> 
> I would have expected three clock device nodes, one for fin_pll (presumably
> a fixed-rate clock?), one for "special clocks" and one for "peripheral
> clock gates", and a number space starting at '1' for each of them, rather
> than having a shared node and numbers starting at '1', '128' and '256',
> which looks a bit clumsy.
> 
> Did you take the ID number definitions from a data sheet, or did you make up
> the numbers yourself for the purpose of defining a binding?

This is a binding that has been defined for Samsung Common Clock Framework 
drivers. Exynos4 and Exynos5250 use the same convention. The numbers are 
defined in a way that should allow adding further clocks of particular types in 
future as need for such shows up.

Physically there is one clock controller (CMU) which has a lot of dividers, 
muxes and gates and so it is represented as a single device node.

Best regards,
Tomasz

> 	Arnd
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc"
> in the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

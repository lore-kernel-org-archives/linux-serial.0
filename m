From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v3 06/10] clk: exynos5420: register clocks using common clock framework
Date: Tue, 18 Jun 2013 16:01:16 +0200
Message-ID: <201306181601.16795.arnd@arndb.de>
References: <1371466836-4111-1-git-send-email-chander.kashyap@linaro.org> <3875156.5RFgBjMoqF@wuerfel> <CANuQgHHoUyE5e+MnnpzWLxcFNcD11FjYwx76pucw7peV4qmFkQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <CANuQgHHoUyE5e+MnnpzWLxcFNcD11FjYwx76pucw7peV4qmFkQ@mail.gmail.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Chander Kashyap <chander.kashyap@linaro.org>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Mark Rutland <mark.rutland@arm.com>, "kgene.kim@samsung.com" <kgene.kim@samsung.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "t.figa@samsung.com" <t.figa@samsung.com>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, Thomas Abraham <thomas.abraham@linaro.org>, "thomas.ab@samsung.com" <thomas.ab@samsung.com>, "s.nawrocki@samsung.com" <s.nawrocki@samsung.com>
List-Id: linux-serial@vger.kernel.org

On Tuesday 18 June 2013, Chander Kashyap wrote:
> >> +       [Core Clocks]
> >> +
> >> +  Clock                      ID
> >> +  ----------------------------
> >> +
> >> +  fin_pll            1
> >> +
> >> +  [Clock Gate for Special Clocks]
> >> +
> >> +  Clock                      ID
> >> +  ----------------------------
> >> +  sclk_uart0         128
> >> +  sclk_uart1         129
> >> +  sclk_uart2         130
> >
> >> +
> >> +   [Peripheral Clock Gates]
> >> +
> >> +  Clock                      ID
> >> +  ----------------------------
> >> +
> >> +  aclk66_peric               256
> >> +  uart0                      257
> >> +  uart1                      258
> >
> > It looks like these are actually separate things. Wouldn't it be more sensible
> > to have separate device nodes for each of the lists and use a local index?
> I have listed the parent clock first, then the child clocks, to
> maintain  readability.
> >
> > What numbers are used in the data sheet?
> I didn't get your point?

I would have expected three clock device nodes, one for fin_pll (presumably a
fixed-rate clock?), one for "special clocks" and one for "peripheral clock
gates", and a number space starting at '1' for each of them, rather than
having a shared node and numbers starting at '1', '128' and '256', which looks
a bit clumsy.

Did you take the ID number definitions from a data sheet, or did you make up
the numbers yourself for the purpose of defining a binding?

	Arnd

From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH] clk: gemini: Fix reset regression
Date: Wed, 12 Jul 2017 16:08:32 -0700
Message-ID: <20170712230832.GF22780@codeaurora.org>
References: <20170711122601.17745-1-linus.walleij@linaro.org>
 <1499874682.6374.57.camel@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-clk-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1499874682.6374.57.camel@pengutronix.de>
Sender: linux-clk-owner@vger.kernel.org
To: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Linus Walleij <linus.walleij@linaro.org>, Michael Turquette <mturquette@baylibre.com>, linux-clk@vger.kernel.org, Janos Laube <janos.dev@gmail.com>, Paulius Zaleckas <paulius.zaleckas@gmail.com>, linux-arm-kernel@lists.infradead.org, Hans Ulli Kroll <ulli.kroll@googlemail.com>, Florian Fainelli <f.fainelli@gmail.com>, Joel Stanley <joel@jms.id.au>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On 07/12, Philipp Zabel wrote:
> Hi Linus,
> 
> On Tue, 2017-07-11 at 14:26 +0200, Linus Walleij wrote:
> > commit e2860e1f62f2 ("serial: 8250_of: Add reset support")
> > introduced reset support for the 8250_of driver.
> > 
> > However it unconditionally uses the assert/deassert pair to
> > deassert reset on the device at probe and assert it at
> > remove. This does not work with systems that have a
> > self-deasserting reset controller, such as Gemini, that
> > recently added a reset controller.
> > 
> > As a result, the console will not probe on the Gemini with
> > this message:
> > 
> > Serial: 8250/16550 driver, 1 ports, IRQ sharing disabled
> > of_serial: probe of 42000000.serial failed with error -524
> > 
> > This (-ENOTSUPP) is the error code returned by the
> > deassert() operation on self-deasserting reset controllers.
> > 
> > To work around this, implement dummy .assert() and
> > .deassert() operations in the Gemini combined clock and
> > reset controller. This fixes the issue on this system.
> >
> > Cc: Joel Stanley <joel@jms.id.au>
> > Cc: Philipp Zabel <p.zabel@pengutronix.de>
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: linux-serial@vger.kernel.org
> > Fixes: e2860e1f62f2 ("serial: 8250_of: Add reset support")
> > Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> > ---
> > This is the solution suggested by Philipp, I think.
> 
> It is what I suggested, yes, but now that I see it before me, I don't
> think this is the proper solution either. Reason below:
> 
> > ---
> >  drivers/clk/clk-gemini.c | 14 ++++++++++++++
> >  1 file changed, 14 insertions(+)
> > 
> > diff --git a/drivers/clk/clk-gemini.c b/drivers/clk/clk-gemini.c
> > index c391a49aaaff..b4cf2f699a21 100644
> > --- a/drivers/clk/clk-gemini.c
> > +++ b/drivers/clk/clk-gemini.c
> > @@ -237,6 +237,18 @@ static int gemini_reset(struct reset_controller_dev *rcdev,
> >  			    BIT(GEMINI_RESET_CPU1) | BIT(id));
> >  }
> >  
> > +static int gemini_reset_assert(struct reset_controller_dev *rcdev,
> > +			       unsigned long id)
> > +{
> > +	return 0;
> 
> This is valid behaviour for shared reset controls, as sharing users
> don't mind whether the reset line is actually asserted after this call,
> they just allow it.
> 
> For an exclusive reset control this should return an error though, as
> the caller would expect the reset line to be asserted after this call.
> Unfortunately the core does not provide information whether the reset
> control is shared or exclusive to the reset drivers, and it could be
> argued that the drivers shouldn't have to care. I suppose I'll have to
> handle this in the core, after all. What do you think of the attached
> patch?
> 
> Otherwise, as a regression fix, I think this would be ok. There isn't
> going to be any driver on the Gemini platform that requests an exclusive
> reset control and then calls reset_control_assert, expecting the reset
> line to stay asserted.
> 
> Acked-by: Philipp Zabel <p.zabel@pengutronix.de>
> 

I'll queue this up for clk-fixes once -rc1 is out.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project

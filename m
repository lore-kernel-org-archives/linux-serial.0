From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] clk: gemini: Fix reset regression
Date: Tue, 18 Jul 2017 11:49:44 +0200
Message-ID: <CACRpkda3ZW4rQTwg8Y63uzzupCZAtTP6jv1ppsTXHuDDy0y8og@mail.gmail.com>
References: <20170711122601.17745-1-linus.walleij@linaro.org> <1499874682.6374.57.camel@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <1499874682.6374.57.camel@pengutronix.de>
Sender: linux-clk-owner@vger.kernel.org
To: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, linux-clk <linux-clk@vger.kernel.org>, Janos Laube <janos.dev@gmail.com>, Paulius Zaleckas <paulius.zaleckas@gmail.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Hans Ulli Kroll <ulli.kroll@googlemail.com>, Florian Fainelli <f.fainelli@gmail.com>, Joel Stanley <joel@jms.id.au>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Wed, Jul 12, 2017 at 5:51 PM, Philipp Zabel <p.zabel@pengutronix.de> wrote:

> From fab3a9a697e9797ba1c24874d7c43c09dd812e77 Mon Sep 17 00:00:00 2001
> From: Philipp Zabel <p.zabel@pengutronix.de>
> Date: Wed, 12 Jul 2017 17:29:28 +0200
> Subject: [PATCH] reset: make (de)assert report succeess for self-deasserting
>  reset drivers
>
> By now there are drivers using shared reset controls and (de)assert
> calls on platforms with self-deasserting reset lines and thus reset
> drivers that do not implement .assert() and .deassert().
> As long as the initial state of the reset line is deasserted, there
> is no reason for a reset_control_assert call to return an error for
> shared reset controls, or for a reset_control_deassert call to return
> an error for either shared or exclusive reset controls: after a call
> to reset_control_deassert the reset line is guaranteed to be deasserted,
> and after a call to reset_control_assert it is valid for the reset
> line to stay deasserted for shared reset controls.
>
> Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>

This patch makes all kind of sense, and I follow your
reasoning.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

In the back of my head I was thinking that the deassert/assert
pair matches a certain SoC driver design pattern I have seen
around:

When a driver use an IP block it enables the clock and takes
the block out of reset.

When it stops using it, it asserts reset and disables the clock.

This is not entirely self-evident, for example why is reset asserted
across say insmod/rmmod/insmod. Just disabling the clock would
be OK, I guess, in most cases. It is just one of those "dances"
that developers do, as if to clear the desk or something.

But I guess there must be cases where doing things in another way
creates problems or power leaks.

I would surely like to understand, from a silicon perspective, why
drivers are so often written like this. I could think of things like
little automata and gates inside the silicon that need to be reset
to minimize off-power consumption but I have no clue if it is
really so.

Yours,
Linus Walleij

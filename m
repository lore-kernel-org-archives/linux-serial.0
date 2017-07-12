From: Philipp Zabel <p.zabel@pengutronix.de>
Subject: Re: [PATCH] clk: gemini: Fix reset regression
Date: Wed, 12 Jul 2017 17:51:22 +0200
Message-ID: <1499874682.6374.57.camel@pengutronix.de>
References: <20170711122601.17745-1-linus.walleij@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <20170711122601.17745-1-linus.walleij@linaro.org>
Sender: linux-clk-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, linux-clk@vger.kernel.org, Janos Laube <janos.dev@gmail.com>, Paulius Zaleckas <paulius.zaleckas@gmail.com>, linux-arm-kernel@lists.infradead.org, Hans Ulli Kroll <ulli.kroll@googlemail.com>, Florian Fainelli <f.fainelli@gmail.com>, Joel Stanley <joel@jms.id.au>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Hi Linus,

On Tue, 2017-07-11 at 14:26 +0200, Linus Walleij wrote:
> commit e2860e1f62f2 ("serial: 8250_of: Add reset support")
> introduced reset support for the 8250_of driver.
> 
> However it unconditionally uses the assert/deassert pair to
> deassert reset on the device at probe and assert it at
> remove. This does not work with systems that have a
> self-deasserting reset controller, such as Gemini, that
> recently added a reset controller.
> 
> As a result, the console will not probe on the Gemini with
> this message:
> 
> Serial: 8250/16550 driver, 1 ports, IRQ sharing disabled
> of_serial: probe of 42000000.serial failed with error -524
> 
> This (-ENOTSUPP) is the error code returned by the
> deassert() operation on self-deasserting reset controllers.
> 
> To work around this, implement dummy .assert() and
> .deassert() operations in the Gemini combined clock and
> reset controller. This fixes the issue on this system.
>
> Cc: Joel Stanley <joel@jms.id.au>
> Cc: Philipp Zabel <p.zabel@pengutronix.de>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: linux-serial@vger.kernel.org
> Fixes: e2860e1f62f2 ("serial: 8250_of: Add reset support")
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> This is the solution suggested by Philipp, I think.

It is what I suggested, yes, but now that I see it before me, I don't
think this is the proper solution either. Reason below:

> ---
>  drivers/clk/clk-gemini.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/drivers/clk/clk-gemini.c b/drivers/clk/clk-gemini.c
> index c391a49aaaff..b4cf2f699a21 100644
> --- a/drivers/clk/clk-gemini.c
> +++ b/drivers/clk/clk-gemini.c
> @@ -237,6 +237,18 @@ static int gemini_reset(struct reset_controller_dev *rcdev,
>  			    BIT(GEMINI_RESET_CPU1) | BIT(id));
>  }
>  
> +static int gemini_reset_assert(struct reset_controller_dev *rcdev,
> +			       unsigned long id)
> +{
> +	return 0;

This is valid behaviour for shared reset controls, as sharing users
don't mind whether the reset line is actually asserted after this call,
they just allow it.

For an exclusive reset control this should return an error though, as
the caller would expect the reset line to be asserted after this call.
Unfortunately the core does not provide information whether the reset
control is shared or exclusive to the reset drivers, and it could be
argued that the drivers shouldn't have to care. I suppose I'll have to
handle this in the core, after all. What do you think of the attached
patch?

Otherwise, as a regression fix, I think this would be ok. There isn't
going to be any driver on the Gemini platform that requests an exclusive
reset control and then calls reset_control_assert, expecting the reset
line to stay asserted.

Acked-by: Philipp Zabel <p.zabel@pengutronix.de>

> +}
> +
> +static int gemini_reset_deassert(struct reset_controller_dev *rcdev,
> +				 unsigned long id)
> +{
> +	return 0;

This is valid behaviour for a self-deasserting controller with the reset
lines initially deasserted for both shared and exclusive reset controls:
after this call the reset line is guaranteed to be deasserted.

regards
Philipp

----------8<----------
>From fab3a9a697e9797ba1c24874d7c43c09dd812e77 Mon Sep 17 00:00:00 2001
From: Philipp Zabel <p.zabel@pengutronix.de>
Date: Wed, 12 Jul 2017 17:29:28 +0200
Subject: [PATCH] reset: make (de)assert report succeess for self-deasserting
 reset drivers

By now there are drivers using shared reset controls and (de)assert
calls on platforms with self-deasserting reset lines and thus reset
drivers that do not implement .assert() and .deassert().
As long as the initial state of the reset line is deasserted, there
is no reason for a reset_control_assert call to return an error for
shared reset controls, or for a reset_control_deassert call to return
an error for either shared or exclusive reset controls: after a call
to reset_control_deassert the reset line is guaranteed to be deasserted,
and after a call to reset_control_assert it is valid for the reset
line to stay deasserted for shared reset controls.

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 drivers/reset/core.c | 31 +++++++++++++++++++++++++------
 1 file changed, 25 insertions(+), 6 deletions(-)

diff --git a/drivers/reset/core.c b/drivers/reset/core.c
index cd739d2fa1603..6c182c173f9b4 100644
--- a/drivers/reset/core.c
+++ b/drivers/reset/core.c
@@ -201,9 +201,6 @@ int reset_control_assert(struct reset_control *rstc)
 	if (WARN_ON(IS_ERR(rstc)))
 		return -EINVAL;
 
-	if (!rstc->rcdev->ops->assert)
-		return -ENOTSUPP;
-
 	if (rstc->shared) {
 		if (WARN_ON(atomic_read(&rstc->triggered_count) != 0))
 			return -EINVAL;
@@ -213,6 +210,21 @@ int reset_control_assert(struct reset_control *rstc)
 
 		if (atomic_dec_return(&rstc->deassert_count) != 0)
 			return 0;
+
+		/*
+		 * Shared reset controls allow the reset line to be in any state
+		 * after this call, so doing nothing is a valid option.
+		 */
+		if (!rstc->rcdev->ops->assert)
+			return 0;
+	} else {
+		/*
+		 * If the reset controller does not implement .assert(), there
+		 * is no way to guarantee that the reset line is asserted after
+		 * this call.
+		 */
+		if (!rstc->rcdev->ops->assert)
+			return -ENOTSUPP;
 	}
 
 	return rstc->rcdev->ops->assert(rstc->rcdev, rstc->id);
@@ -239,9 +251,6 @@ int reset_control_deassert(struct reset_control *rstc)
 	if (WARN_ON(IS_ERR(rstc)))
 		return -EINVAL;
 
-	if (!rstc->rcdev->ops->deassert)
-		return -ENOTSUPP;
-
 	if (rstc->shared) {
 		if (WARN_ON(atomic_read(&rstc->triggered_count) != 0))
 			return -EINVAL;
@@ -250,6 +259,16 @@ int reset_control_deassert(struct reset_control *rstc)
 			return 0;
 	}
 
+	/*
+	 * If the reset controller does not implement .deassert(), we assume
+	 * that it handles self-deasserting reset lines via .reset(). In that
+	 * case, the reset lines are deasserted by default. If that is not the
+	 * case, the reset controller driver should implement .deassert() and
+	 * return -ENOTSUPP.
+	 */
+	if (!rstc->rcdev->ops->deassert)
+		return 0;
+
 	return rstc->rcdev->ops->deassert(rstc->rcdev, rstc->id);
 }
 EXPORT_SYMBOL_GPL(reset_control_deassert);
-- 
2.11.0
---------->8----------


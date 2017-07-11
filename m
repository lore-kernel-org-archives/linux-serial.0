From: Philipp Zabel <p.zabel@pengutronix.de>
Subject: Re: [PATCH] serial: 8250_of: Fix regression in reset support
Date: Tue, 11 Jul 2017 10:29:11 +0200
Message-ID: <1499761751.3073.33.camel@pengutronix.de>
References: <20170710152451.5773-1-linus.walleij@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170710152451.5773-1-linus.walleij@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Joel Stanley <joel@jms.id.au>
List-Id: linux-serial@vger.kernel.org

Hi Linus,

On Mon, 2017-07-10 at 17:24 +0200, Linus Walleij wrote:
> commit e2860e1f62f2 ("serial: 8250_of: Add reset support")
> introduced reset support for the 8250_of driver.
> 
> However it unconditionally uses the assert/deassert pair to
> deassert reset on the device at probe and assert it at
> remove. This does not work with systems that have a
> self-deasserting reset controller, such as Gemini, that
> recently added a reset controller.

Self-deasserting resets are fundamentally incompatible with
assert/deassert in the current shared reset model (as there is no
framework for deferring or or vetoing reset assertions while one of the
devices sharing the reset line could be negatively affected).

The way it is implemented right now, after reset() is triggered once,
assert/deassert will return -EINVAL for the lifetime of the reset
control instance. Also, reset() returns -EINVAL between another users'
deassert() and assert() calls.

> As a result, the console will not probe on the Gemini with
> this message:
> 
> Serial: 8250/16550 driver, 1 ports, IRQ sharing disabled
> of_serial: probe of 42000000.serial failed with error -524
> 
> This (-ENOTSUPP) is the error code returned by the
> deassert() operation on self-deasserting reset controllers.

One easy workaround would be to implement deassert() to be a no-op (or
to divert the call to reset()) in your reset controller driver. A more
intrusive variant would be to do the same in the core, as you suggest
below.

> Add some code and comments that will:
> 
> - In probe() avoid to bail out if -ENOTSUPP is returned
>   from the reset_deassert() call.

I think it would be better not to put this burden on the drivers.

> - If reset_assert() bails out with -ENOTSUPP on remove(),
>   try the self-deasserting method as a fallback.

I don't understand the purpose of this, see below.

> Cc: Joel Stanley <joel@jms.id.au>
> Cc: Philipp Zabel <p.zabel@pengutronix.de>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Fixes: e2860e1f62f2 ("serial: 8250_of: Add reset support")
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> Philipp: please comment on this or ACK if it is the right
> approach. It sort of sets a precedent for handling
> different reset controllers from the consumer side.
> 
> Another possibility is to modify the reset core such
> that .deassert() bails out silently if the controller only
> has .reset(), and .assert() just calls .reset() if the
> controller does not have .assert().
>
> Actually I think the latter is more intuitive but it is
> also more intrusive.

I have been thinking about this. Due to the diversity of reset
controller implementations, I'm hesitant to do this in the core.

For starters, why would reset() be called during assert() and not during
deassert()? Can we be sure that this is the right thing for all reset
controllers?
The deassert() call guarantees that the reset line is deasserted after
the call (and as long as deassert_count > 0). What if somebody ends up
building a self-deasserting reset controller that has the reset line
initially asserted?
Also it is implied that after the call to deassert() the device is in a
working state, obviously. This might only be the case after the first
reset() for some devices.

> ---
>  drivers/tty/serial/8250/8250_of.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_of.c b/drivers/tty/serial/8250/8250_of.c
> index 0cf95fddccfc..927ee8561c8d 100644
> --- a/drivers/tty/serial/8250/8250_of.c
> +++ b/drivers/tty/serial/8250/8250_of.c
> @@ -138,7 +138,12 @@ static int of_platform_serial_setup(struct platform_device *ofdev,
>  	if (IS_ERR(info->rst))
>  		goto out;
>  	ret = reset_control_deassert(info->rst);
> -	if (ret)
> +	/*
> +	 * If the deassert operation is not supported, this could be because
> +	 * the reset controller is self-deasserting and onlt supports the
> +	 * .reset() operation, so this is not a probe error.
> +	 */
> +	if (ret && (ret != -ENOTSUPP))

I don't like to have to do this in the drivers.

The driver just requests the reset line to be deasserted after the call,
if there is one. If the reset controller driver can guarantee that,
deassert() should not return an error.

>  		goto out;
>  
>  	port->type = type;
> @@ -235,10 +240,14 @@ static int of_platform_serial_probe(struct platform_device *ofdev)
>  static int of_platform_serial_remove(struct platform_device *ofdev)
>  {
>  	struct of_serial_info *info = platform_get_drvdata(ofdev);
> +	int ret;
>  
>  	serial8250_unregister_port(info->line);
>  
> -	reset_control_assert(info->rst);
> +	ret = reset_control_assert(info->rst);
> +	/* If the assert operation is not supported, use pure reset() */
> +	if (ret == -ENOTSUPP)
> +		reset_control_reset(info->rst);
>  	if (info->clk)
>  		clk_disable_unprepare(info->clk);
>  	kfree(info);

What is the purpose of triggering the assert during remove?

I would expect the self-deasserting reset to be triggered during probe,
before the device is used, if it is necessary at all.

regards
Philipp

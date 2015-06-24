From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 6/9] arm: twr-k70f120m: clock source drivers for Kinetis
 SoC
Date: Wed, 24 Jun 2015 09:53:30 +0200 (CEST)
Message-ID: <alpine.DEB.2.11.1506240947330.4037@nanos>
References: <1435094387-20146-1-git-send-email-pawelo@king.net.pl> <1435094387-20146-7-git-send-email-pawelo@king.net.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <1435094387-20146-7-git-send-email-pawelo@king.net.pl>
Sender: linux-gpio-owner@vger.kernel.org
To: Paul Osmialowski <pawelo@king.net.pl>
Cc: Andrew Morton <akpm@linux-foundation.org>, Anson Huang <b20788@freescale.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Bhupesh Sharma <bhupesh.sharma@freescale.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Frank Li <Frank.Li@freescale.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Guenter Roeck <linux@roeck-us.net>, Haojian Zhuang <haojian.zhuang@gmail.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Jingchang Lu <jingchang.lu@freescale.com>, Jiri Slaby <jslaby@suse.cz>, Kees Cook <keescook@chromium.org>, Kumar Gala <galak@codeaurora.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Linus Walleij <linus.walleij@linaro.org>, Magnus Damm <damm+renesas@opensource.se>, Michael Turquette <mturquette@baylibre.com>, Nathan Lynch <nathan_lynch@mentor.com>, Nicolas
List-Id: linux-serial@vger.kernel.org

On Tue, 23 Jun 2015, Paul Osmialowski wrote:
> +/*
> + * Clock event device set mode function
> + */
> +static void kinetis_clockevent_tmr_set_mode(
> +	enum clock_event_mode mode, struct clock_event_device *clk)
> +{
> +	struct kinetis_clock_event_ddata *pit =
> +		container_of(clk, struct kinetis_clock_event_ddata, evtdev);
> +
> +	switch (mode) {
> +	case CLOCK_EVT_MODE_PERIODIC:
> +		kinetis_pit_enable(pit->base, 1);
> +		break;
> +	case CLOCK_EVT_MODE_ONESHOT:
> +	case CLOCK_EVT_MODE_UNUSED:
> +	case CLOCK_EVT_MODE_SHUTDOWN:
> +	default:
> +		kinetis_pit_enable(pit->base, 0);
> +	}
> +}

Please move to the new set_state_* interfaces. set_mode() is deprecated.

> +static int kinetis_clockevent_tmr_set_next_event(
> +	unsigned long delta, struct clock_event_device *c)
> +{
> +	struct kinetis_clock_event_ddata *pit =
> +		container_of(c, struct kinetis_clock_event_ddata, evtdev);
> +	unsigned long flags;
> +
> +	raw_local_irq_save(flags);

Pointless exercise. This is called with interrupts disabled.

> +	kinetis_pit_init(pit->base, delta);
> +	kinetis_pit_enable(pit->base, 1);
> +	raw_local_irq_restore(flags);


> +static struct irqaction kinetis_clockevent_irqaction[KINETIS_PIT_CHANNELS] = {
> +	{
> +		.name = "Kinetis Kernel Time Tick (pit0)",

Please use oneword descriptive names not half sentences.

> +		.flags = IRQF_TIMER | IRQF_IRQPOLL,
> +		.dev_id = &kinetis_clockevent_tmrs[0],
> +		.handler = kinetis_clockevent_tmr_irq_handler,
> +	}, {
> +		.name = "Kinetis Kernel Time Tick (pit1)",
> +		.flags = IRQF_TIMER | IRQF_IRQPOLL,
> +		.dev_id = &kinetis_clockevent_tmrs[1],
> +		.handler = kinetis_clockevent_tmr_irq_handler,
> +	}, {
> +		.name = "Kinetis Kernel Time Tick (pit2)",
> +		.flags = IRQF_TIMER | IRQF_IRQPOLL,
> +		.dev_id = &kinetis_clockevent_tmrs[2],
> +		.handler = kinetis_clockevent_tmr_irq_handler,
> +	}, {
> +		.name = "Kinetis Kernel Time Tick (pit3)",
> +		.flags = IRQF_TIMER | IRQF_IRQPOLL,
> +		.dev_id = &kinetis_clockevent_tmrs[3],
> +		.handler = kinetis_clockevent_tmr_irq_handler,
> +	},

Aside of that. Please use standard request_irq() there is no reason to
use setup_irq here.

> +
> +	setup_irq(irq, &(kinetis_clockevent_irqaction[chan]));

  request_irq(irq, handler, flags, "name", &kinetis_clockevent_tmrs[chan]);

....

Thanks,

	tglx

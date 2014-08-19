From: Carlo Caione <carlo@caione.org>
Subject: Re: [PATCH 3/7] ARM: meson6: clocksource: add Meson6 timer support
Date: Tue, 19 Aug 2014 18:01:53 +0200
Message-ID: <20140819160153.GA869@carlo-MacBookPro>
References: <1408272594-10814-1-git-send-email-carlo@caione.org>
 <1408272594-10814-4-git-send-email-carlo@caione.org>
 <20140818162726.GE3302@leverpostej>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:50829 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751890AbaHSQB7 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 19 Aug 2014 12:01:59 -0400
Content-Disposition: inline
In-Reply-To: <20140818162726.GE3302@leverpostej>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Mark Rutland <mark.rutland@arm.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "ijc+devicetree@hellion.org.uk" <ijc+devicetree@hellion.org.uk>, "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>, "tglx@linutronix.de" <tglx@linutronix.de>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "jslaby@suse.cz" <jslaby@suse.cz>, "grant.likely@linaro.org" <grant.likely@linaro.org>, "b.galvani@gmail.com" <b.galvani@gmail.com>

On lun, ago 18, 2014 at 05:27:26 +0100, Mark Rutland wrote:
> On Sun, Aug 17, 2014 at 11:49:50AM +0100, Carlo Caione wrote:
> > +enum {
> > +	A = 0,
> > +	B,
> > +	C,
> > +	D,
> > +};
> 
> That's a very terse set of enum names. I would recomment something a
> little longer.
> 
> Any reason for missing E?

TIMER_E is a slightly different timer so I preferred to leave it apart.

> > +#define TIMER_ISA_MUX		0
> > +#define TIMER_ISA_E_VAL		0x14
> > +#define TIMER_ISA_t_VAL(t)	((t + 1) << 2)
> > +
> > +#define TIMER_t_INPUT_BIT(t)	(2 * t)
> > +#define TIMER_E_INPUT_BIT	8
> > +#define TIMER_t_INPUT_MASK(t)	(3UL << TIMER_t_INPUT_BIT(t))
> > +#define TIMER_E_INPUT_MASK	(7UL << TIMER_E_INPUT_BIT)
> > +#define TIMER_t_ENABLE_BIT(t)	(16 + t)
> > +#define TIMER_E_ENABLE_BIT	20
> > +#define TIMER_t_PERIODIC_BIT(t)	(12 + t)
> 
> While I don't think it matters for any of these, it's usually good
> practice to add parentheses around arguments, e.g.
> 
> #define FOO(x)		((x) * 2)
> 
> So you can avoid bad expansions in cases like:
> 
> FOO(reg + 4)

Agree. I'll change it.

> > +
> > +#define TIMER_UNIT_1us		0
> > +#define TIMER_E_UNIT_1us	1
> > +
> > +static void __iomem *timer_base;
> > +
> > +static cycle_t cycle_read_timer_e(struct clocksource *cs)
> > +{
> > +	return (cycle_t)readl(timer_base + TIMER_ISA_E_VAL);
> > +}
> > +
> > +static struct clocksource clocksource_timer_e = {
> > +	.name	= "meson6_timerE",
> 
> Do we really care which specific timer we're using within the block?
> 
> Why not just "meson6_clocksource"?

Just a reminder of which timer we are using. I'll fix it.

> > +	.rating	= 300,
> > +	.read	= cycle_read_timer_e,
> > +	.mask	= CLOCKSOURCE_MASK(32),
> > +	.flags  = CLOCK_SOURCE_IS_CONTINUOUS,
> > +};
> 
> [...]
> 
> > +static irqreturn_t meson6_timer_interrupt(int irq, void *dev_id)
> > +{
> > +	struct clock_event_device *evt = (struct clock_event_device *)dev_id;
> > +
> > +	evt->event_handler(evt);
> > +
> > +	return IRQ_HANDLED;
> > +}
> > +
> > +static struct irqaction meson6_timer_irq = {
> > +	.name		= "meson6_timerA",
> 
> Similarly to the clocksource naming, this might be better as
> "meson6_timer", without the 'A'.

Yep.

Thanks for the review,

-- 
Carlo Caione

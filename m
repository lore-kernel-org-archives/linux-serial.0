From: Srinivas KANDAGATLA <srinivas.kandagatla-qxv4g6HH51o@public.gmane.org>
Subject: Re: [RFC 2/8] ARM:global_timer: Add ARM global timer support.
Date: Tue, 14 May 2013 09:46:38 +0100
Message-ID: <5191F9EE.6070008@st.com>
References: <1368022187-1633-1-git-send-email-srinivas.kandagatla@st.com>
 <1368022260-2197-1-git-send-email-srinivas.kandagatla@st.com>
 <CACRpkdZCP=w=4Q3bnuMQxm=Oe-uZke+Cc5NgddM5vsQbgr9E-Q@mail.gmail.com>
Reply-To: srinivas.kandagatla-qxv4g6HH51o@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <CACRpkdZCP=w=4Q3bnuMQxm=Oe-uZke+Cc5NgddM5vsQbgr9E-Q-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: "linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Jiri Slaby <jslaby-AlSwsSmVLrQ@public.gmane.org>, Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Nicolas Pitre <nico-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Stuart Menefy <stuart.menefy-qxv4g6HH51o@public.gmane.org>, John Stultz <john.stultz-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Dong Aisheng <dong.aisheng-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, linux-kernel@v
List-Id: linux-serial@vger.kernel.org

Thankyou for the comments.

On 13/05/13 20:05, Linus Walleij wrote:
> On Wed, May 8, 2013 at 4:11 PM, Srinivas KANDAGATLA
> <srinivas.kandagatla-qxv4g6HH51o@public.gmane.org> wrote:
> 
> Thomas Gleixner and John Stultz should always be included on timer code review.
> 
> This is one reason I really like to move the clocksource/clockevent/etc code out
> of arch/arm, so that people can get their To: line right from MAINTAINERS.
> (Whether it goes to drivers/clocksource or not is another issue.)
> 
>> diff --git a/arch/arm/include/asm/global_timer.h b/arch/arm/include/asm/global_timer.h
> 
> Using CLKSRC_OF_INIT() this header goes away entirely I guess.
> 
>> diff --git a/arch/arm/kernel/global_timer.c b/arch/arm/kernel/global_timer.c
> 
>> +#define GT_COUNTER0    0x00
>> +#define GT_COUNTER1    0x04
> 
> So two counters, nice.
> 
>> +union gt_counter {
>> +       cycle_t cycles;
>> +       struct {
>> +               uint32_t lower;
>> +               uint32_t upper;
> 
> Just u32 is fine.

It makes sense to remove this struct totally and use u64 as suggested.

> 
>> +       };
>> +};
>> +
>> +static union gt_counter gt_counter_read(void)
>> +{
>> +       union gt_counter res;
>> +       uint32_t upper;
> 
> u32
> 
>> +
>> +       upper = readl(gt_base + GT_COUNTER1);
>> +       do {
>> +               res.upper = upper;
>> +               res.lower = readl(gt_base + GT_COUNTER0);
>> +               upper = readl(gt_base + GT_COUNTER1);
>> +       } while (upper != res.upper);
>> +
>> +       return res;
>> +}
> 
> I guess this is some cleverness to avoid wrap-around...
> A comment stating what's going on wouldn't hurt.

This cleverness is defined in the datasheet
http://infocenter.arm.com/help/index.jsp?topic=/com.arm.doc.ddi0407i/CIHGECHJ.html


I will add a comment here.

> 
> But why on earth do you need this complicated union
> to hold the result? Have two local u32 variables and return
> a u64 from this function.
> 
> Since this will be performance critical, isn't readl_relaxed() suffient
> here, or what's the rationale for just using readl()?

Yes, it makes sense to go for readl_relaxed here as it is device-memory
type.

> 
>> +static void gt_compare_set(unsigned long delta, int periodic)
>> +{
>> +       union gt_counter counter = gt_counter_read();
> 
> So here you get something easy to read like
> 
> u64 counter = gt_counter_read();
> 
>> +       unsigned long ctrl = readl(gt_base + GT_CONTROL);
>> +
>> +       BUG_ON(!(ctrl & GT_CONTROL_TIMER_ENABLE));
>> +       BUG_ON(ctrl & (GT_CONTROL_COMP_ENABLE |
>> +                      GT_CONTROL_IRQ_ENABLE |
>> +                      GT_CONTROL_AUTO_INC));
> 
> Do you really have to check this *whenever the counter is set*?
> 
> Will it not suffice to do this once during initialization?
> 
> It looks like some leftover debug code. It also looks kind of clock
> dangerous, can you explain exactly why this check is here?

I will get this debug out of here.

> 
>> +
>> +       counter.cycles += delta;
>> +       writel(counter.lower, gt_base + GT_COMP0);
>> +       writel(counter.upper, gt_base + GT_COMP1);
> 
> This is another instance of the union struct making things
> complicated. With a u64 just:
> 
> counter += delta;
> writel(lower_32_bits(counter), gt_base + GT_COMP0);
> writel(upper_32_bits(counter), gt_base + GT_COMP1);
> 
> As you can see <linux/kernel.h> has really nice helpers in place
> to deal with 64 bit arithmetics.
Same as first comment.

> 
>> +
>> +       ctrl |= GT_CONTROL_COMP_ENABLE | GT_CONTROL_IRQ_ENABLE;
>> +
>> +       if (periodic) {
>> +               writel(delta, gt_base + GT_AUTO_INC);
>> +               ctrl |= GT_CONTROL_AUTO_INC;
>> +       }
>> +
>> +       writel(ctrl, gt_base + GT_CONTROL);
>> +}
>> +
>> +static void gt_clockevent_set_mode(enum clock_event_mode mode,
>> +                                  struct clock_event_device *clk)
>> +{
>> +       switch (mode) {
>> +       case CLOCK_EVT_MODE_PERIODIC:
>> +               gt_compare_set(gt_clk_rate/HZ, 1);
> 
> Use
> gt_compare_set(DIV_ROUND_CLOSEST(gt_clk_rate, HZ), 1);
> to get integer arithmetics right.

Will move to use DIV_ROUND_CLOSEST.
> 
>> +               break;
>> +       case CLOCK_EVT_MODE_ONESHOT:
>> +               /* period set, and timer enabled in 'next_event' hook */
>> +               BUG_ON(readl(gt_base + GT_CONTROL) &
>> +                      (GT_CONTROL_COMP_ENABLE |
>> +                       GT_CONTROL_IRQ_ENABLE |
>> +                       GT_CONTROL_AUTO_INC));
> 
> Here is another one of these checks. Why aren't you just
> zeroing these flags if you don't want them, especially since
> you're writing the register at the end of the function? Now it
> looks like instead of setting up the timer the way you want it
> you bug out if it isn't already set up as you want it (hint,
> the name of this function).
> 
>> +               /* Fall through */
>> +       case CLOCK_EVT_MODE_UNUSED:
>> +       case CLOCK_EVT_MODE_SHUTDOWN:
>> +       default:
>> +               writel(GT_CONTROL_TIMER_ENABLE, gt_base + GT_CONTROL);
> 
> Why are you enabling the timer in unused and shutdown mode?
> 
> This doesn't make sense.

It is because we are using the global-timer block for both clocksource
and clockevents and we do not want the clocksource to disappear when
clockevent is unused/shutdown.

> 
>> +               break;
>> +       }
>> +}
>> +
>> +static int gt_clockevent_set_next_event(unsigned long evt,
>> +                                       struct clock_event_device *unused)
>> +{
>> +       gt_compare_set(evt, 0);
>> +       return 0;
>> +}
>> +
>> +static irqreturn_t gt_clockevent_interrupt(int irq, void *dev_id)
>> +{
>> +       struct clock_event_device *evt = *(struct clock_event_device **)dev_id;
>> +
>> +       writel(GT_INT_STATUS_EVENT_FLAG, gt_base + GT_INT_STATUS);
> 
> You're clearing the flag before checking if it was set. What happens
> if this was a spurious interrupt that should be disregarded?

Makes sense, I will add a check here.

> 
>> +       evt->event_handler(evt);
>> +
>> +       return IRQ_HANDLED;
>> +}
>> +
>> +static int __cpuinit gt_clockevents_init(struct clock_event_device *clk)
>> +{
>> +       struct clock_event_device **this_cpu_clk;
>> +       int cpu = smp_processor_id();
>> +
>> +       clk->name = "Global Timer CE";
> 
> Name it after the hardware feature. "ARM global timer clock event"
> there is no need to abbreviate randomly.

Yes, will change all such instances.

> 
>> +       clk->features = CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT;
>> +       clk->set_mode = gt_clockevent_set_mode;
>> +       clk->set_next_event = gt_clockevent_set_next_event;
>> +       this_cpu_clk = __this_cpu_ptr(gt_evt);
>> +       *this_cpu_clk = clk;
>> +       clk->irq = gt_ppi;
>> +       clockevents_config_and_register(clk, gt_clk_rate,
>> +                                       0xf, 0xffffffff);
> 
> Why can't this clock event handle anything lower than 0xf?
> Does that come from the datasheet or have you just copied some
> code?
There is no such limitation on the minimum clock ticks, I think it was
copied.

Will fix it in next version.

> 
> Further, since this clock event hardware *most definately* supports
> using a delta upper bound *beyond* 32 bits, I think the clock event
> core code should be altered to allow for registereing such clock
> events, but TGLX may have some idea here. This will work but will
> not expose the full potential of this 64-bit counter hardware.
> 
>> +       per_cpu(percpu_init_called, cpu) = true;
>> +       enable_percpu_irq(clk->irq, IRQ_TYPE_NONE);
>> +       return 0;
>> +}
>> +
>> +static void gt_clockevents_stop(struct clock_event_device *clk)
>> +{
>> +       gt_clockevent_set_mode(CLOCK_EVT_MODE_UNUSED, clk);
>> +       disable_percpu_irq(clk->irq);
>> +}
>> +
>> +static int __cpuinit gt_clockevents_setup(struct clock_event_device *clk)
>> +{
>> +       int cpu = smp_processor_id();
>> +
>> +       /* Use existing clock_event for boot cpu */
>> +       if (per_cpu(percpu_init_called, cpu))
>> +               return 0;
>> +
>> +       writel(0, gt_base + GT_CONTROL);
>> +       writel(0, gt_base + GT_COUNTER0);
>> +       writel(0, gt_base + GT_COUNTER1);
>> +       writel(GT_CONTROL_TIMER_ENABLE, gt_base + GT_CONTROL);
>> +
>> +       return gt_clockevents_init(clk);
>> +}
>> +
>> +static cycle_t gt_clocksource_read(struct clocksource *cs)
>> +{
>> +       union gt_counter res = gt_counter_read();
>> +       return res.cycles;
>> +}
>> +
>> +static struct clocksource gt_clocksource = {
>> +       .name   = "Global Timer CS",
> 
> "ARM global timer clock source"
> 
>> +       .rating = 300,
>> +       .read   = gt_clocksource_read,
>> +       .mask   = CLOCKSOURCE_MASK(64),
>> +       .flags  = CLOCK_SOURCE_IS_CONTINUOUS,
>> +};
>> +
>> +static void __init gt_clocksource_init(void)
>> +{
>> +       writel(0, gt_base + GT_CONTROL);
>> +       writel(0, gt_base + GT_COUNTER0);
>> +       writel(0, gt_base + GT_COUNTER1);
>> +       writel(GT_CONTROL_TIMER_ENABLE, gt_base + GT_CONTROL);
>> +
>> +       gt_clocksource.shift = 20;
> 
> So how did you come up with that?
Hmm..
You are right, this should not be a constant here, I will use
clocksource_register_hz instead.

-srini

> 
>> +       gt_clocksource.mult =
>> +               clocksource_hz2mult(gt_clk_rate, gt_clocksource.shift);
>> +       clocksource_register(&gt_clocksource);
> 
> Why don't you just replace all of this hazzle with:
> 
> clocksource_register_hz(&gt_clocksource, gt_clk_rate);
> 
> That will calculate mult and shift for you? (Leave these
> unassigned.)
> 
> Since the hpet timer does this it's pretty well tested...
> 
> No more comments right now...
> 
> Yours,
> Linus Walleij
> 
> 

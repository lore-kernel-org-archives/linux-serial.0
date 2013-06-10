From: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 02/11] clocksource:global_timer: Add ARM global timer
 support.
Date: Mon, 10 Jun 2013 15:13:34 +0200
Message-ID: <CACRpkdbQCRKBzRF4HzNsXHwXCLJJcFZ9T36GPmmYsnX1OfgGRg@mail.gmail.com>
References: <1370855828-5318-1-git-send-email-srinivas.kandagatla@st.com>
 <1370856087-6452-1-git-send-email-srinivas.kandagatla@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <1370856087-6452-1-git-send-email-srinivas.kandagatla-qxv4g6HH51o@public.gmane.org>
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
To: Srinivas KANDAGATLA <srinivas.kandagatla-qxv4g6HH51o@public.gmane.org>, Mike Turquette <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Mauro Carvalho Chehab <mchehab-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Stephen Gallimore <stephen.gallimore-qxv4g6HH51o@public.gmane.org>, "linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Stuart Menefy <stuart.menefy-qxv4g6HH51o@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, John Stultz <john.stultz-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, David S.
List-Id: linux-serial@vger.kernel.org

On Mon, Jun 10, 2013 at 11:21 AM, Srinivas KANDAGATLA
<srinivas.kandagatla-qxv4g6HH51o@public.gmane.org> wrote:

> From: Stuart Menefy <stuart.menefy-qxv4g6HH51o@public.gmane.org>
>
> This is a simple driver for the global timer module found in the Cortex
> A9-MP cores from revision r1p0 onwards. This should be able to perform
> the functions of the system timer and the local timer in an SMP system.
>
> The global timer has the following features:
>     The global timer is a 64-bit incrementing counter with an
> auto-incrementing feature. It continues incrementing after sending
> interrupts. The global timer is memory mapped in the private memory
> region.
>     The global timer is accessible to all Cortex-A9 processors in the
> cluster. Each Cortex-A9 processor has a private 64-bit comparator that
> is used to assert a private interrupt when the global timer has reached
> the comparator value. All the Cortex-A9 processors in a design use the
> banked ID, ID27, for this interrupt. ID27 is sent to the Interrupt
> Controller as a Private Peripheral Interrupt. The global timer is
> clocked by PERIPHCLK.
>
> Signed-off-by: Stuart Menefy <stuart.menefy-qxv4g6HH51o@public.gmane.org>
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla-qxv4g6HH51o@public.gmane.org>
> CC: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
> CC: Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> CC: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> CC: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
> CC: Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>

This is starting to look very good!

(...)
> +static int __cpuinit gt_clockevents_init(struct clock_event_device *clk)
> +{
> +       struct clock_event_device **this_cpu_clk;
> +       int cpu = smp_processor_id();
> +
> +       clk->name = "ARM global timer clock event";
> +       clk->features = CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT;
> +       clk->set_mode = gt_clockevent_set_mode;
> +       clk->set_next_event = gt_clockevent_set_next_event;
> +       this_cpu_clk = __this_cpu_ptr(gt_evt);
> +       *this_cpu_clk = clk;
> +       clk->cpumask = cpumask_of(cpu);
> +       clk->irq = gt_ppi;
> +       clockevents_config_and_register(clk, gt_clk_rate,
> +                                       0, 0xffffffff);

What do you mean with being able to set event on
0?

This should most probably be:


clockevents_config_and_register(clk, gt_clk_rate,
                                      1, 0xffffffff);

(...)
> +static struct clk *gt_get_clock(void)
> +{
> +       struct clk *clk;
> +       int err;
> +
> +       clk = clk_get_sys("gt", NULL);
> +       if (IS_ERR(clk)) {
> +               pr_err("global-timer: clock not found: %ld\n", PTR_ERR(clk));
> +               return clk;
> +       }
(...)
> +       clk = of_clk_get(np, 0);
> +       if (!IS_ERR(clk))
> +               clk_register_clkdev(clk, NULL, "gt");

Well that was clever.

Isn't it better to pass a struct device_node *np around and have that as
NULL in the non-DT boot path?

(Maybe somebody in the community asked you to do this, then I
will live with it.)

Yours,
Linus Walleij

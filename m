From: Chander Kashyap <chander.kashyap@linaro.org>
Subject: Re: [PATCH 11/13] clocksource: exynos_mct: extend local timer support
 for four cores
Date: Tue, 11 Jun 2013 18:56:16 +0530
Message-ID: <CANuQgHFYFOKaReN7KvU=xT=QP28d_Ox4pDC0K_mV5jy3HifDkQ@mail.gmail.com>
References: <1370516488-25860-1-git-send-email-chander.kashyap@linaro.org>
	<1370516488-25860-11-git-send-email-chander.kashyap@linaro.org>
	<20130606165040.GB23311@e106331-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-ob0-f169.google.com ([209.85.214.169]:37337 "EHLO
	mail-ob0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751252Ab3FKN0Q (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 11 Jun 2013 09:26:16 -0400
Received: by mail-ob0-f169.google.com with SMTP id up14so11840989obb.0
        for <linux-serial@vger.kernel.org>; Tue, 11 Jun 2013 06:26:16 -0700 (PDT)
In-Reply-To: <20130606165040.GB23311@e106331-lin.cambridge.arm.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Mark Rutland <mark.rutland@arm.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "kgene.kim@samsung.com" <kgene.kim@samsung.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "t.figa@samsung.com" <t.figa@samsung.com>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, "thomas.ab@samsung.com" <thomas.ab@samsung.com>, "s.nawrocki@samsung.com" <s.nawrocki@samsung.com>

On 6 June 2013 22:20, Mark Rutland <mark.rutland@arm.com> wrote:
> Hi,
>
> I have a few comments.
>
> On Thu, Jun 06, 2013 at 12:01:25PM +0100, Chander Kashyap wrote:
>> Extend the local timer interrupt support for handling four local timers.
>
> Is this the maximum number of CPUs the MCT could theoretically support?
>
>>
>> Signed-off-by: Chander Kashyap <chander.kashyap@linaro.org>
>> ---
>>  drivers/clocksource/exynos_mct.c |   33 ++++++++++++++++++++++++++++++---
>>  1 file changed, 30 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/clocksource/exynos_mct.c b/drivers/clocksource/exynos_mct.c
>> index 662fcc0..6af17d4 100644
>> --- a/drivers/clocksource/exynos_mct.c
>> +++ b/drivers/clocksource/exynos_mct.c
>> @@ -412,6 +412,18 @@ static struct irqaction mct_tick1_event_irq = {
>>       .handler        = exynos4_mct_tick_isr,
>>  };
>>
>> +static struct irqaction mct_tick2_event_irq = {
>> +     .name           = "mct_tick2_irq",
>> +     .flags          = IRQF_TIMER | IRQF_NOBALANCING,
>> +     .handler        = exynos4_mct_tick_isr,
>> +};
>> +
>> +static struct irqaction mct_tick3_event_irq = {
>> +     .name           = "mct_tick3_irq",
>> +     .flags          = IRQF_TIMER | IRQF_NOBALANCING,
>> +     .handler        = exynos4_mct_tick_isr,
>> +};
>> +
>
> Is there any reason you can't use {request,free}_irq?
>
>>  static int __cpuinit exynos4_local_timer_setup(struct clock_event_device *evt)
>>  {
>>       struct mct_clock_event_device *mevt;
>> @@ -439,11 +451,21 @@ static int __cpuinit exynos4_local_timer_setup(struct clock_event_device *evt)
>>                       mct_tick0_event_irq.dev_id = mevt;
>>                       evt->irq = mct_irqs[MCT_L0_IRQ];
>>                       setup_irq(evt->irq, &mct_tick0_event_irq);
>> -             } else {
>> +             } else if (cpu == 1) {
>>                       mct_tick1_event_irq.dev_id = mevt;
>>                       evt->irq = mct_irqs[MCT_L1_IRQ];
>>                       setup_irq(evt->irq, &mct_tick1_event_irq);
>>                       irq_set_affinity(evt->irq, cpumask_of(1));
>> +             } else if (cpu == 2) {
>> +                     mct_tick2_event_irq.dev_id = mevt;
>> +                     evt->irq = mct_irqs[MCT_L2_IRQ];
>> +                     setup_irq(evt->irq, &mct_tick2_event_irq);
>> +                     irq_set_affinity(evt->irq, cpumask_of(2));
>> +             } else if (cpu == 3) {
>> +                     mct_tick3_event_irq.dev_id = mevt;
>> +                     evt->irq = mct_irqs[MCT_L3_IRQ];
>> +                     setup_irq(evt->irq, &mct_tick3_event_irq);
>> +                     irq_set_affinity(evt->irq, cpumask_of(3));
>
> This doesn't seem good to me. You're duplicating the logic for each CPU. Can
> you not figure out which values you need based on the smp_processor_id (or even
> better, the *evt) without requiring a separate branch for each CPU?
>
>>               }
>>       } else {
>>               enable_percpu_irq(mct_irqs[MCT_L0_IRQ], 0);
>> @@ -456,11 +478,16 @@ static void exynos4_local_timer_stop(struct clock_event_device *evt)
>>  {
>>       unsigned int cpu = smp_processor_id();
>>       evt->set_mode(CLOCK_EVT_MODE_UNUSED, evt);
>> -     if (mct_int_type == MCT_INT_SPI)
>> +     if (mct_int_type == MCT_INT_SPI) {
>>               if (cpu == 0)
>>                       remove_irq(evt->irq, &mct_tick0_event_irq);
>> -             else
>> +             else if (cpu == 1)
>>                       remove_irq(evt->irq, &mct_tick1_event_irq);
>> +             else if (cpu == 2)
>> +                     remove_irq(evt->irq, &mct_tick2_event_irq);
>> +             else if (cpu == 3)
>> +                     remove_irq(evt->irq, &mct_tick3_event_irq);
>> +     }
>
> Again, I don't think each CPU should be special-cased. If you used
> {request,free}_irq this would be simpler.
 I will convert the calls to {request,free}_irq. All problem will be
taken care by that.
Thanks for the review.
>
> Thanks,
> Mark.



--
with warm regards,
Chander Kashyap

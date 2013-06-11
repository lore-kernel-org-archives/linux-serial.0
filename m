From: Chander Kashyap <chander.kashyap@linaro.org>
Subject: Re: [PATCH 02/13] ARM: Exynos: fix secondary cpu power control
 register address calculation
Date: Tue, 11 Jun 2013 19:16:09 +0530
Message-ID: <CANuQgHG5Ch=vshF6KSBxby7E-FMupLK4HQXyfG+GXNOL36ZbXg@mail.gmail.com>
References: <1370516488-25860-1-git-send-email-chander.kashyap@linaro.org>
	<1370516488-25860-2-git-send-email-chander.kashyap@linaro.org>
	<3410121.IQM8pcjbaY@flatron>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-oa0-f48.google.com ([209.85.219.48]:64620 "EHLO
	mail-oa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754583Ab3FKNqK (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 11 Jun 2013 09:46:10 -0400
Received: by mail-oa0-f48.google.com with SMTP id f4so3631431oah.7
        for <linux-serial@vger.kernel.org>; Tue, 11 Jun 2013 06:46:09 -0700 (PDT)
In-Reply-To: <3410121.IQM8pcjbaY@flatron>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Tomasz Figa <tomasz.figa@gmail.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "kgene.kim@samsung.com" <kgene.kim@samsung.com>, "t.figa@samsung.com" <t.figa@samsung.com>, "s.nawrocki@samsung.com" <s.nawrocki@samsung.com>, "thomas.ab@samsung.com" <thomas.ab@samsung.com>

On 8 June 2013 16:35, Tomasz Figa <tomasz.figa@gmail.com> wrote:
> Hi Chander,
>
> On Thursday 06 of June 2013 16:31:16 Chander Kashyap wrote:
>> The CPU power control register address calculation for secondary CPUs is
>> generalized by calculating the register address using secondary cpu
>> logical number.
>>
>> Signed-off-by: Chander Kashyap <chander.kashyap@linaro.org>
>> ---
>>  arch/arm/mach-exynos/include/mach/regs-pmu.h |    6 ++++++
>>  arch/arm/mach-exynos/platsmp.c               |   10 +++++-----
>>  2 files changed, 11 insertions(+), 5 deletions(-)
>>
>> diff --git a/arch/arm/mach-exynos/include/mach/regs-pmu.h
>> b/arch/arm/mach-exynos/include/mach/regs-pmu.h index 3f30aa1..b77f72c
>> 100644
>> --- a/arch/arm/mach-exynos/include/mach/regs-pmu.h
>> +++ b/arch/arm/mach-exynos/include/mach/regs-pmu.h
>> @@ -125,11 +125,17 @@
>>  #define S5P_GPS_ALIVE_LOWPWR                 S5P_PMUREG(0x13A0)
>>
>>  #define S5P_ARM_CORE0_CONFIGURATION          S5P_PMUREG(0x2000)
>> +#define S5P_ARM_CORE0_STATUS                 S5P_PMUREG(0x2004)
>>  #define S5P_ARM_CORE0_OPTION                 S5P_PMUREG(0x2008)
>>  #define S5P_ARM_CORE1_CONFIGURATION          S5P_PMUREG(0x2080)
>>  #define S5P_ARM_CORE1_STATUS                 S5P_PMUREG(0x2084)
>>  #define S5P_ARM_CORE1_OPTION                 S5P_PMUREG(0x2088)
>
> I would simply drop all those CORE1 definitions. This would have the nice
> side effect of showing all the occurencies of this issue in other files as
> well.
>
>>
>> +#define S5P_ARM_CORE_CONFIGURATION(_nr)              \
>> +                     (S5P_ARM_CORE0_CONFIGURATION + (_nr) * 0x80)
>> +#define S5P_ARM_CORE_STATUS(_nr)                     \
>> +                     (S5P_ARM_CORE0_STATUS + (_nr) * 0x80)
>> +
>>  #define S5P_ARM_COMMON_OPTION                        S5P_PMUREG(0x2408)
>>  #define S5P_TOP_PWR_OPTION                   S5P_PMUREG(0x2C48)
>>  #define S5P_CAM_OPTION                               S5P_PMUREG(0x3C08)
>> diff --git a/arch/arm/mach-exynos/platsmp.c
>> b/arch/arm/mach-exynos/platsmp.c index d9c6d0a..1a4e4e5 100644
>> --- a/arch/arm/mach-exynos/platsmp.c
>> +++ b/arch/arm/mach-exynos/platsmp.c
>> @@ -109,14 +109,14 @@ static int __cpuinit
>> exynos_boot_secondary(unsigned int cpu, struct task_struct */
>>       write_pen_release(phys_cpu);
>>
>> -     if (!(__raw_readl(S5P_ARM_CORE1_STATUS) & S5P_CORE_LOCAL_PWR_EN))
> {
>> +     if (!(__raw_readl(S5P_ARM_CORE_STATUS(cpu)) &
>
> Shouldn't phys_cpu be used here, not cpu?
phys_cpu is physical cpu-id.When MPIDR will be taken into consideration,
the phys_cpu will leead to wrong offset. Hence in my opinion logical
cpu number should be used.
>
>> S5P_CORE_LOCAL_PWR_EN))
>> { __raw_writel(S5P_CORE_LOCAL_PWR_EN,
>> -                          S5P_ARM_CORE1_CONFIGURATION);
>> +                          S5P_ARM_CORE_CONFIGURATION(cpu));
>
> Ditto.
>
>>
>>               timeout = 10;
>>
>> -             /* wait max 10 ms until cpu1 is on */
>> -             while ((__raw_readl(S5P_ARM_CORE1_STATUS)
>> +             /* wait max 10 ms until secondary cpu is on */
>> +             while ((__raw_readl(S5P_ARM_CORE_STATUS(cpu))
>
> Ditto.
>
>>                       & S5P_CORE_LOCAL_PWR_EN) != S5P_CORE_LOCAL_PWR_EN)
> {
>>                       if (timeout-- == 0)
>>                               break;
>> @@ -125,7 +125,7 @@ static int __cpuinit exynos_boot_secondary(unsigned
>> int cpu, struct task_struct }
>>
>>               if (timeout == 0) {
>> -                     printk(KERN_ERR "cpu1 power enable failed");
>> +                     pr_err("secondary cpu power enable failed\n");
>
> This is not really related to this patch, but I'm not strongly against
> including this fixup in this patch.
>
>>                       spin_unlock(&boot_lock);
>>                       return -ETIMEDOUT;
>>               }
>
> By the way, I was just about to send similar patch that we have in our
> internal tree and you were faster :) . Mine also fixes the same problem in
> mach-exynos/hotplug.c where CORE1 registers are used.
>
> Now the question is: Are you going to address all those things or we could
> just drop this patch from the series and apply mine instead, which has all
> the things already done?

Good, I will drop this patch from the series. You can send it along
your patches.

thanks.
>
> Best regards,
> Tomasz
>



--
with warm regards,
Chander Kashyap

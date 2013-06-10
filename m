From: Chander Kashyap <chander.kashyap@linaro.org>
Subject: Re: [PATCH 04/13] ARM: dts: list the CPU nodes for Exynos5250
Date: Mon, 10 Jun 2013 14:48:40 +0530
Message-ID: <CANuQgHEZEuE_vh9z1sbwpcrEO91BADaqGzos-nEFzeqh_CkGZA@mail.gmail.com>
References: <1370516488-25860-1-git-send-email-chander.kashyap@linaro.org>
	<1370516488-25860-4-git-send-email-chander.kashyap@linaro.org>
	<16514785.Efj3frXj0r@flatron>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-oa0-f51.google.com ([209.85.219.51]:44886 "EHLO
	mail-oa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751910Ab3FJJSl (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 10 Jun 2013 05:18:41 -0400
Received: by mail-oa0-f51.google.com with SMTP id i4so1478541oah.24
        for <linux-serial@vger.kernel.org>; Mon, 10 Jun 2013 02:18:41 -0700 (PDT)
In-Reply-To: <16514785.Efj3frXj0r@flatron>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Tomasz Figa <tomasz.figa@gmail.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "kgene.kim@samsung.com" <kgene.kim@samsung.com>, "t.figa@samsung.com" <t.figa@samsung.com>, "s.nawrocki@samsung.com" <s.nawrocki@samsung.com>, "thomas.ab@samsung.com" <thomas.ab@samsung.com>

On 8 June 2013 16:46, Tomasz Figa <tomasz.figa@gmail.com> wrote:
> On Thursday 06 of June 2013 16:31:18 Chander Kashyap wrote:
>> Instead of having to specify the number for CPUs in Exynos5250 in
>> platsmp.c file, let the number of CPUs be determined by having this
>> information listed in Exynos5250 device tree file.
>>
>> Signed-off-by: Chander Kashyap <chander.kashyap@linaro.org>
>> ---
>>  arch/arm/boot/dts/exynos5250.dtsi |   14 ++++++++++++++
>>  arch/arm/mach-exynos/platsmp.c    |   10 +++++++---
>>  2 files changed, 21 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/arm/boot/dts/exynos5250.dtsi
>> b/arch/arm/boot/dts/exynos5250.dtsi index e571d3b..7f6b1c7 100644
>> --- a/arch/arm/boot/dts/exynos5250.dtsi
>> +++ b/arch/arm/boot/dts/exynos5250.dtsi
>> @@ -50,6 +50,20 @@
>>               pinctrl3 = &pinctrl_3;
>>       };
>>
>> +     cpus {
>> +             #address-cells = <1>;
>> +             #size-cells = <0>;
>> +
>> +             cpu@0 {
>> +                     compatible = "arm,cortex-a15";
>> +                     reg = <0>;
>> +             };
>> +             cpu@1 {
>> +                     compatible = "arm,cortex-a15";
>> +                     reg = <1>;
>> +             };
>> +     };
>> +
>>       pd_gsc: gsc-power-domain@0x10044000 {
>>               compatible = "samsung,exynos4210-pd";
>>               reg = <0x10044000 0x20>;
>> diff --git a/arch/arm/mach-exynos/platsmp.c
>> b/arch/arm/mach-exynos/platsmp.c index 1a4e4e5..85ea4ca 100644
>> --- a/arch/arm/mach-exynos/platsmp.c
>> +++ b/arch/arm/mach-exynos/platsmp.c
>> @@ -180,10 +180,14 @@ static void __init exynos_smp_init_cpus(void)
>>       void __iomem *scu_base = scu_base_addr();
>>       unsigned int i, ncores;
>>
>> -     if (soc_is_exynos5250())
>> -             ncores = 2;
>> -     else
>> +     if (read_cpuid_part_number() == ARM_CPU_PART_CORTEX_A9)
>>               ncores = scu_base ? scu_get_core_count(scu_base) : 1;
>> +     else
>> +             /*
>> +              * CPU Nodes are passed thru DT and set_cpu_possible
>> +              * is set by "arm_dt_init_cpu_maps".
>> +              */
>> +             return;
>>
>>       /* sanity check */
>>       if (ncores > nr_cpu_ids) {
>
> Looks good. Same thing should be done for remaining Exynos SoCs as well.
Thanks for reviewing.
>
> Reviewed-by: Tomasz Figa <t.figa@samsung.com>
>
> Best regards,
> Tomasz
>



--
with warm regards,
Chander Kashyap

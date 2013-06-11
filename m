From: Chander Kashyap <chander.kashyap@linaro.org>
Subject: Re: [PATCH 03/13] ARM: dts: fork out common Exynos5 nodes
Date: Tue, 11 Jun 2013 19:19:04 +0530
Message-ID: <CANuQgHGQN2tmbbkuxp=S7712LX_=iYRwFXU_nYpJcbq54CJq+Q@mail.gmail.com>
References: <1370516488-25860-1-git-send-email-chander.kashyap@linaro.org>
	<1370516488-25860-3-git-send-email-chander.kashyap@linaro.org>
	<3263993.4t2W5LRuVW@flatron>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <3263993.4t2W5LRuVW@flatron>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Tomasz Figa <tomasz.figa@gmail.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "kgene.kim@samsung.com" <kgene.kim@samsung.com>, "t.figa@samsung.com" <t.figa@samsung.com>, "s.nawrocki@samsung.com" <s.nawrocki@samsung.com>, "thomas.ab@samsung.com" <thomas.ab@samsung.com>, Stephen Warren <swarren@wwwdotorg.org>, grant.likely@linaro.org, Rob Herring <rob.herring@calxeda.com>, devicetree-discuss@lists.ozlabs.org
List-Id: linux-serial@vger.kernel.org

On 8 June 2013 16:42, Tomasz Figa <tomasz.figa@gmail.com> wrote:
> Hi Chander,
>
> On Thursday 06 of June 2013 16:31:17 Chander Kashyap wrote:
>> In preparation of adding support for Exynos5420, which has many
>> peripherals similar to Exynos5250, a new common Exynos5 device tree
>> source file is created out of the existing Exynos5250 device tree
>> source file. Only the common nodes required for basic boot up on
>> Exynos5420 based boards are moved into this new file and the rest of
>> the common nodes would be moved subsequently.
>>
>> Signed-off-by: Chander Kashyap <chander.kashyap@linaro.org>
>> ---
>>  arch/arm/boot/dts/exynos5.dtsi    |  121
>> +++++++++++++++++++++++++++++++++++++ arch/arm/boot/dts/exynos5250.dtsi
>> |   74 +---------------------- 2 files changed, 122 insertions(+), 73
>> deletions(-)
>>  create mode 100644 arch/arm/boot/dts/exynos5.dtsi
>>
>> diff --git a/arch/arm/boot/dts/exynos5.dtsi
>> b/arch/arm/boot/dts/exynos5.dtsi new file mode 100644
>> index 0000000..ab56608
>> --- /dev/null
>> +++ b/arch/arm/boot/dts/exynos5.dtsi
>> @@ -0,0 +1,121 @@
>> +/*
>> + * Samsung's Exynos5 SoC series common device tree source
>> + *
>> + * Copyright (c) 2012-2013 Samsung Electronics Co., Ltd.
>> + *           http://www.samsung.com
>> + *
>> + * Samsung's Exynos5 SoC series device nodes are listed in this file.
>> Particular + * SoCs from Exynos5 series can include this file and
>> provide values for SoCs + * specfic bindings.
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 as +
>> * published by the Free Software Foundation.
>> + */
>> +
>> +/include/ "skeleton.dtsi"
>> +
>> +/ {
>> +     interrupt-parent = <&gic>;
>> +
>> +     chipid@10000000 {
>> +             compatible = "samsung,exynos4210-chipid";
>> +             reg = <0x10000000 0x100>;
>> +     };
>> +
>> +     gic:interrupt-controller@10481000 {
>> +             compatible = "arm,cortex-a15-gic", "arm,cortex-a9-gic";
>> +             #interrupt-cells = <3>;
>> +             interrupt-controller;
>> +             reg =   <0x10481000 0x1000>,
>> +                     <0x10482000 0x1000>,
>> +                     <0x10484000 0x2000>,
>> +                     <0x10486000 0x2000>;
>> +             interrupts = <1 9 0xf04>;
>> +     };
>> +
>> +     combiner:interrupt-controller@10440000 {
>> +             compatible = "samsung,exynos4210-combiner";
>> +             #interrupt-cells = <2>;
>> +             interrupt-controller;
>> +             samsung,combiner-nr = <32>;
>> +             reg = <0x10440000 0x1000>;
>> +             interrupts =    <0 0 0>, <0 1 0>, <0 2 0>, <0 3 0>,
>> +                             <0 4 0>, <0 5 0>, <0 6 0>, <0 7 0>,
>> +                             <0 8 0>, <0 9 0>, <0 10 0>, <0 11 0>,
>> +                             <0 12 0>, <0 13 0>, <0 14 0>, <0 15 0>,
>> +                             <0 16 0>, <0 17 0>, <0 18 0>, <0 19 0>,
>> +                             <0 20 0>, <0 21 0>, <0 22 0>, <0 23 0>,
>> +                             <0 24 0>, <0 25 0>, <0 26 0>, <0 27 0>,
>> +                             <0 28 0>, <0 29 0>, <0 30 0>, <0 31 0>;
>> +     };
>> +
>> +     watchdog {
>> +             compatible = "samsung,s3c2410-wdt";
>> +             reg = <0x101D0000 0x100>;
>> +             interrupts = <0 42 0>;
>> +             clock-names = "watchdog";
>> +             status = "disabled";
>> +     };
>> +
>> +     rtc {
>> +             compatible = "samsung,s3c6410-rtc";
>> +             reg = <0x101E0000 0x100>;
>> +             interrupts = <0 43 0>, <0 44 0>;
>> +             clock-names = "rtc";
>> +             status = "disabled";
>> +     };
>> +
>> +     serial@12C00000 {
>> +             compatible = "samsung,exynos4210-uart";
>> +             reg = <0x12C00000 0x100>;
>> +             interrupts = <0 51 0>;
>> +             clock-names = "uart", "clk_uart_baud0";
>> +     };
>> +
>> +     serial@12C10000 {
>> +             compatible = "samsung,exynos4210-uart";
>> +             reg = <0x12C10000 0x100>;
>> +             interrupts = <0 52 0>;
>> +             clock-names = "uart", "clk_uart_baud0";
>> +     };
>> +
>> +     serial@12C20000 {
>> +             compatible = "samsung,exynos4210-uart";
>> +             reg = <0x12C20000 0x100>;
>> +             interrupts = <0 53 0>;
>> +             clock-names = "uart", "clk_uart_baud0";
>> +     };
>> +
>> +     serial@12C30000 {
>> +             compatible = "samsung,exynos4210-uart";
>> +             reg = <0x12C30000 0x100>;
>> +             interrupts = <0 54 0>;
>> +             clock-names = "uart", "clk_uart_baud0";
>> +     };
>> +
>> +     dwmmc_0: dwmmc0@12200000 {
>> +             compatible = "samsung,exynos5250-dw-mshc";
>> +             interrupts = <0 75 0>;
>> +             #address-cells = <1>;
>> +             #size-cells = <0>;
>> +             clock-names = "biu", "ciu";
>> +     };
>> +
>> +     dwmmc_1: dwmmc1@12210000 {
>> +             compatible = "samsung,exynos5250-dw-mshc";
>> +             interrupts = <0 76 0>;
>> +             #address-cells = <1>;
>> +             #size-cells = <0>;
>> +             clock-names = "biu", "ciu";
>> +     };
>> +
>> +     dwmmc_2: dwmmc2@12220000 {
>> +             compatible = "samsung,exynos5250-dw-mshc";
>> +             interrupts = <0 77 0>;
>> +             #address-cells = <1>;
>> +             #size-cells = <0>;
>> +             clock-names = "biu", "ciu";
>> +             status = "disabled";
>> +     };
>
> If you are at adding new file, maybe it would be a good idea to sort the
> nodes somehow, e.g. by @address or name. I'm not sure if there is some
> rule, but it would improve maintainability of the file.
I will place in sorted order and resend.
>
> CCing people that might know more than me on this matter and also
> devicetree-discuss mailing list (which should be CCed for _every_ patch
> which does something related to DeviceTree - please remember about this).
>
>> +};
>> diff --git a/arch/arm/boot/dts/exynos5250.dtsi
>> b/arch/arm/boot/dts/exynos5250.dtsi index 4bd9e9c..e571d3b 100644
>> --- a/arch/arm/boot/dts/exynos5250.dtsi
>> +++ b/arch/arm/boot/dts/exynos5250.dtsi
>> @@ -17,12 +17,11 @@
>>   * published by the Free Software Foundation.
>>  */
>>
>> -/include/ "skeleton.dtsi"
>> +/include/ "exynos5.dtsi"
>>  /include/ "exynos5250-pinctrl.dtsi"
>>
>>  / {
>>       compatible = "samsung,exynos5250";
>> -     interrupt-parent = <&gic>;
>>
>>       aliases {
>>               spi0 = &spi_0;
>> @@ -51,11 +50,6 @@
>>               pinctrl3 = &pinctrl_3;
>>       };
>>
>> -     chipid@10000000 {
>> -             compatible = "samsung,exynos4210-chipid";
>> -             reg = <0x10000000 0x100>;
>> -     };
>> -
>>       pd_gsc: gsc-power-domain@0x10044000 {
>>               compatible = "samsung,exynos4210-pd";
>>               reg = <0x10044000 0x20>;
>> @@ -72,17 +66,6 @@
>>               #clock-cells = <1>;
>>       };
>>
>> -     gic:interrupt-controller@10481000 {
>> -             compatible = "arm,cortex-a15-gic", "arm,cortex-a9-gic";
>> -             #interrupt-cells = <3>;
>> -             interrupt-controller;
>> -             reg = <0x10481000 0x1000>,
>> -                   <0x10482000 0x1000>,
>> -                   <0x10484000 0x2000>,
>> -                   <0x10486000 0x2000>;
>> -             interrupts = <1 9 0xf04>;
>> -     };
>> -
>>       timer {
>>               compatible = "arm,armv7-timer";
>>               interrupts = <1 13 0xf08>,
>> @@ -91,22 +74,6 @@
>>                            <1 10 0xf08>;
>>       };
>>
>> -     combiner:interrupt-controller@10440000 {
>> -             compatible = "samsung,exynos4210-combiner";
>> -             #interrupt-cells = <2>;
>> -             interrupt-controller;
>> -             samsung,combiner-nr = <32>;
>> -             reg = <0x10440000 0x1000>;
>> -             interrupts = <0 0 0>, <0 1 0>, <0 2 0>, <0 3 0>,
>> -                          <0 4 0>, <0 5 0>, <0 6 0>, <0 7 0>,
>> -                          <0 8 0>, <0 9 0>, <0 10 0>, <0 11 0>,
>> -                          <0 12 0>, <0 13 0>, <0 14 0>, <0 15 0>,
>> -                          <0 16 0>, <0 17 0>, <0 18 0>, <0 19 0>,
>> -                          <0 20 0>, <0 21 0>, <0 22 0>, <0 23 0>,
>> -                          <0 24 0>, <0 25 0>, <0 26 0>, <0 27 0>,
>> -                          <0 28 0>, <0 29 0>, <0 30 0>, <0 31 0>;
>> -     };
>> -
>>       mct@101C0000 {
>>               compatible = "samsung,exynos4210-mct";
>>               reg = <0x101C0000 0x800>;
>> @@ -168,11 +135,7 @@
>>       };
>>
>>       watchdog {
>> -             compatible = "samsung,s3c2410-wdt";
>> -             reg = <0x101D0000 0x100>;
>> -             interrupts = <0 42 0>;
>>               clocks = <&clock 336>;
>> -             clock-names = "watchdog";
>
> I would keep the clock-names property here, because it increases
> readability and is complementary to the clocks property.
Yes, thanks for pointing out. Will place clock names and number at same place.
>
>>       };
>>
>>       codec@11000000 {
>> @@ -183,12 +146,8 @@
>>       };
>>
>>       rtc {
>> -             compatible = "samsung,s3c6410-rtc";
>> -             reg = <0x101E0000 0x100>;
>> -             interrupts = <0 43 0>, <0 44 0>;
>>               clocks = <&clock 337>;
>>               clock-names = "rtc";
>
> Yes, just like here :) .
>
>> -             status = "disabled";
>>       };
>>
>>       tmu@10060000 {
>> @@ -200,35 +159,19 @@
>>       };
>>
>>       serial@12C00000 {
>> -             compatible = "samsung,exynos4210-uart";
>> -             reg = <0x12C00000 0x100>;
>> -             interrupts = <0 51 0>;
>>               clocks = <&clock 289>, <&clock 146>;
>> -             clock-names = "uart", "clk_uart_baud0";
>
> Ditto.
>
>>       };
>>
>>       serial@12C10000 {
>> -             compatible = "samsung,exynos4210-uart";
>> -             reg = <0x12C10000 0x100>;
>> -             interrupts = <0 52 0>;
>>               clocks = <&clock 290>, <&clock 147>;
>> -             clock-names = "uart", "clk_uart_baud0";
>
> Ditto.
>
>>       };
>>
>>       serial@12C20000 {
>> -             compatible = "samsung,exynos4210-uart";
>> -             reg = <0x12C20000 0x100>;
>> -             interrupts = <0 53 0>;
>>               clocks = <&clock 291>, <&clock 148>;
>> -             clock-names = "uart", "clk_uart_baud0";
>
> Ditto.
>
>>       };
>>
>>       serial@12C30000 {
>> -             compatible = "samsung,exynos4210-uart";
>> -             reg = <0x12C30000 0x100>;
>> -             interrupts = <0 54 0>;
>>               clocks = <&clock 292>, <&clock 149>;
>> -             clock-names = "uart", "clk_uart_baud0";
>
> Ditto.
>
>>       };
>>
>>       sata@122F0000 {
>> @@ -405,33 +348,18 @@
>>       };
>>
>>       dwmmc_0: dwmmc0@12200000 {
>> -             compatible = "samsung,exynos5250-dw-mshc";
>>               reg = <0x12200000 0x1000>;
>> -             interrupts = <0 75 0>;
>> -             #address-cells = <1>;
>> -             #size-cells = <0>;
>>               clocks = <&clock 280>, <&clock 139>;
>> -             clock-names = "biu", "ciu";
>
> Ditto.
>
>>       };
>>
>>       dwmmc_1: dwmmc1@12210000 {
>> -             compatible = "samsung,exynos5250-dw-mshc";
>>               reg = <0x12210000 0x1000>;
>> -             interrupts = <0 76 0>;
>> -             #address-cells = <1>;
>> -             #size-cells = <0>;
>>               clocks = <&clock 281>, <&clock 140>;
>> -             clock-names = "biu", "ciu";
>
> Ditto.
>
>>       };
>>
>>       dwmmc_2: dwmmc2@12220000 {
>> -             compatible = "samsung,exynos5250-dw-mshc";
>>               reg = <0x12220000 0x1000>;
>> -             interrupts = <0 77 0>;
>> -             #address-cells = <1>;
>> -             #size-cells = <0>;
>>               clocks = <&clock 282>, <&clock 141>;
>> -             clock-names = "biu", "ciu";
>
> Ditto.
>
> Best regards,
> Tomasz
>
>>       };
>>
>>       dwmmc_3: dwmmc3@12230000 {


Thanks for the review.
--
with warm regards,
Chander Kashyap

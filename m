Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EF4CC433E1
	for <linux-serial@archiver.kernel.org>; Wed, 31 Mar 2021 07:19:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E6F7F619DB
	for <linux-serial@archiver.kernel.org>; Wed, 31 Mar 2021 07:19:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234005AbhCaHTX (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 31 Mar 2021 03:19:23 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:14672 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S233989AbhCaHTE (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 31 Mar 2021 03:19:04 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12V7IOHP031670;
        Wed, 31 Mar 2021 09:18:32 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=pNf2wWh6gQcaMGvUKfhMPfh26Csn2zIXze+3ZNvukdk=;
 b=CGfSirNaBSHh4JC6aKdA1/EZDzGIeHuLiKESHGCIa/awUP/dmkEXbj6+pJWin3Xs8RCu
 1U5GjJUXMWXsocLVx/VRZYK51mnB7rn17d9UnfB9byyeNQ0x0s3fyV8Ee3bevGAoM6G4
 4OYN4LF+42Pv5urh1kmnWMTzh7XabnQgIto6kpluFm3CFTaXJ/2l2Lp6q0EVD1P6nIlS
 YIKxTzrvGYj+JSsN7/cqGhwHv/dsaE/gyJWyUGgBo2pgXSNWJj8Ve+wPsGao62T97Bst
 TWjhhmnWdwUnnVbxxGe2shTMrsRnUrZ0xf72TPhX/UnevSqBtn+zmJlUvi51T0Lvl1tk SQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 37mab5au0y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 31 Mar 2021 09:18:32 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 24BD510002A;
        Wed, 31 Mar 2021 09:18:26 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 03456221F8D;
        Wed, 31 Mar 2021 09:18:26 +0200 (CEST)
Received: from lmecxl0912.lme.st.com (10.75.127.45) by SFHDAG2NODE3.st.com
 (10.75.127.6) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 31 Mar
 2021 09:18:25 +0200
Subject: Re: [PATCH v8 4/6] ARM: dts: stm32: add support for art-pi board
 based on stm32h750xbh6
To:     dillon min <dillon.minfei@gmail.com>
CC:     Rob Herring <robh@kernel.org>,
        Valentin CARON - foss <valentin.caron@foss.st.com>,
        <rong.a.chen@intel.com>, Ahmad Fatoum <a.fatoum@pengutronix.de>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        <linux@armlinux.org.uk>, <afzal.mohd.ma@gmail.com>,
        <gregkh@linuxfoundation.org>,
        Erwan LE-RAY - foss <erwan.leray@foss.st.com>,
        Erwan LE RAY <erwan.leray@st.com>,
        <linux-serial@vger.kernel.org>, <lkp@intel.com>,
        Patrice CHOTARD <patrice.chotard@foss.st.com>
References: <1617094704-10040-1-git-send-email-dillon.minfei@gmail.com>
 <1617094704-10040-5-git-send-email-dillon.minfei@gmail.com>
 <4df8e7b8-826c-b1d4-0431-4f777e26c383@foss.st.com>
 <CAL9mu0LKpbraWPX-rgCJcxxX_JfaggTKc+o4P7Uq12Lqo2tMZw@mail.gmail.com>
From:   Alexandre TORGUE <alexandre.torgue@foss.st.com>
Message-ID: <46b6becb-d77e-5385-a5ed-73de253a0ee5@foss.st.com>
Date:   Wed, 31 Mar 2021 09:18:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAL9mu0LKpbraWPX-rgCJcxxX_JfaggTKc+o4P7Uq12Lqo2tMZw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG1NODE3.st.com (10.75.127.3) To SFHDAG2NODE3.st.com
 (10.75.127.6)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-31_01:2021-03-30,2021-03-31 signatures=0
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi Dillon

On 3/31/21 12:43 AM, dillon min wrote:
> Hi Alexandre,
> 
> Thanks for the quick response.
> 
> On Wed, Mar 31, 2021 at 12:50 AM Alexandre TORGUE
> <alexandre.torgue@foss.st.com> wrote:
>>
>>
>>
>> On 3/30/21 10:58 AM, dillon.minfei@gmail.com wrote:
>>> From: dillon min <dillon.minfei@gmail.com>
>>>
>>> This patchset has following changes:
>>>
>>> - introduce stm32h750.dtsi to support stm32h750 value line
>>> - add stm32h750i-art-pi.dtb (arch/arm/boot/dts/Makefile)
>>> - add stm32h750-art-pi.dts to support art-pi board
>>>
>>> art-pi board component:
>>> - 8MiB qspi flash
>>> - 16MiB spi flash
>>> - 32MiB sdram
>>> - ap6212 wifi&bt&fm
>>>
>>> the detail board information can be found at:
>>> https://art-pi.gitee.io/website/
>>>
>>> Signed-off-by: dillon min <dillon.minfei@gmail.com>
>>> ---
>>> v8:
>>> - move file stm32h743.dtsi submit position to [PATCH V8 3/6]
>>>
>>>    arch/arm/boot/dts/Makefile              |   1 +
>>>    arch/arm/boot/dts/stm32h750.dtsi        |   6 +
>>>    arch/arm/boot/dts/stm32h750i-art-pi.dts | 229 ++++++++++++++++++++++++++++++++
>>>    3 files changed, 236 insertions(+)
>>>    create mode 100644 arch/arm/boot/dts/stm32h750.dtsi
>>>    create mode 100644 arch/arm/boot/dts/stm32h750i-art-pi.dts
>>>
>>> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
>>> index 8e5d4ab4e75e..a19c5ab9df84 100644
>>> --- a/arch/arm/boot/dts/Makefile
>>> +++ b/arch/arm/boot/dts/Makefile
>>> @@ -1071,6 +1071,7 @@ dtb-$(CONFIG_ARCH_STM32) += \
>>>        stm32746g-eval.dtb \
>>>        stm32h743i-eval.dtb \
>>>        stm32h743i-disco.dtb \
>>> +     stm32h750i-art-pi.dtb \
>>>        stm32mp153c-dhcom-drc02.dtb \
>>>        stm32mp157a-avenger96.dtb \
>>>        stm32mp157a-dhcor-avenger96.dtb \
>>> diff --git a/arch/arm/boot/dts/stm32h750.dtsi b/arch/arm/boot/dts/stm32h750.dtsi
>>> new file mode 100644
>>> index 000000000000..41e3b1e3a874
>>> --- /dev/null
>>> +++ b/arch/arm/boot/dts/stm32h750.dtsi
>>> @@ -0,0 +1,6 @@
>>> +/* SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause) */
>>> +/* Copyright (C) STMicroelectronics 2021 - All Rights Reserved */
>>> +
>>> +#include "stm32h743.dtsi"
>>> +
>>
>> I know it's a bit odd, but you could directly include stm32h743.dtsi in
>> your board as there are no SoC differences.
> 
> There are some mirror difference between stm32h743 and stm32h750:
> 
> Number of A/D Converters (typ):  stm32h743(none),   stm32h750(3)
> Crypto:      stm32h743(none),    stm32h750(HASH-AES, DES/TDES, HMAC, MD5, SHA)
> 
> you can find detail diff at link:
> https://www.st.com/en/microcontrollers-microprocessors/stm32h7-series.html#products
> (select stm32h743xi, stm32h750xb to compare)
> 
> I have two options for this changes.
> - rename stm32h743.dtsi to stm32h7.dtsi, add crypto part to
> stm32h7.dtsi in the future.
> - make the reference like this (just like stm32f429 <-- stm32f469,
> stm32mp151 <-- stm32mp153 <-- stm32mp157 did)
>    stm32h743.dtsi <-- stm32h75x.dtsi (stm32h750, stm32h753, stm32h757
> all with HW crypto/hash inside)
>    we can add crypto to stm32h75x.dtsi, i will just rename
> stm32h750.dtsi to stm32h75x.dtsi
> 
> I'd like to use option-2, which one do you like?
  I think what you did is correct (include stm32h743.dtsi inside 
stm32h750.dtsi). It makes sens if you add crypto and ADC nodes inside 
stm32h743.dtsi

Cheers
Alex

> thanks.
> regards.
> 
> 
> 
> Dillon,
>>
>>
>>> diff --git a/arch/arm/boot/dts/stm32h750i-art-pi.dts b/arch/arm/boot/dts/stm32h750i-art-pi.dts
>>> new file mode 100644
>>> index 000000000000..9bb73bb61901
>>> --- /dev/null
>>> +++ b/arch/arm/boot/dts/stm32h750i-art-pi.dts
>>> @@ -0,0 +1,229 @@
>>> +/*
>>> + * Copyright 2021 - Dillon Min <dillon.minfei@gmail.com>
>>> + *
>>> + * This file is dual-licensed: you can use it either under the terms
>>> + * of the GPL or the X11 license, at your option. Note that this dual
>>> + * licensing only applies to this file, and not this project as a
>>> + * whole.
>>> + *
>>> + *  a) This file is free software; you can redistribute it and/or
>>> + *     modify it under the terms of the GNU General Public License as
>>> + *     published by the Free Software Foundation; either version 2 of the
>>> + *     License, or (at your option) any later version.
>>> + *
>>> + *     This file is distributed in the hope that it will be useful,
>>> + *     but WITHOUT ANY WARRANTY; without even the implied warranty of
>>> + *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>>> + *     GNU General Public License for more details.
>>> + *
>>> + * Or, alternatively,
>>> + *
>>> + *  b) Permission is hereby granted, free of charge, to any person
>>> + *     obtaining a copy of this software and associated documentation
>>> + *     files (the "Software"), to deal in the Software without
>>> + *     restriction, including without limitation the rights to use,
>>> + *     copy, modify, merge, publish, distribute, sublicense, and/or
>>> + *     sell copies of the Software, and to permit persons to whom the
>>> + *     Software is furnished to do so, subject to the following
>>> + *     conditions:
>>> + *
>>> + *     The above copyright notice and this permission notice shall be
>>> + *     included in all copies or substantial portions of the Software.
>>> + *
>>> + *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
>>> + *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
>>> + *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
>>> + *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
>>> + *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
>>> + *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
>>> + *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
>>> + *     OTHER DEALINGS IN THE SOFTWARE.
>>> + *
>>> + * For art-pi board resources, you can refer to link:
>>> + *   https://art-pi.gitee.io/website/
>>> + */
>>> +
>>> +/dts-v1/;
>>> +#include "stm32h750.dtsi"
>>> +#include "stm32h7-pinctrl.dtsi"
>>> +#include <dt-bindings/interrupt-controller/irq.h>
>>> +#include <dt-bindings/gpio/gpio.h>
>>> +
>>> +/ {
>>> +     model = "RT-Thread STM32H750i-ART-PI board";
>>> +     compatible = "st,stm32h750i-art-pi", "st,stm32h750";
>>> +
>>> +     chosen {
>>> +             bootargs = "root=/dev/ram";
>>> +             stdout-path = "serial0:2000000n8";
>>> +     };
>>> +
>>> +     memory@c0000000 {
>>> +             device_type = "memory";
>>> +             reg = <0xc0000000 0x2000000>;
>>> +     };
>>> +
>>> +     reserved-memory {
>>> +             #address-cells = <1>;
>>> +             #size-cells = <1>;
>>> +             ranges;
>>> +
>>> +             linux,cma {
>>> +                     compatible = "shared-dma-pool";
>>> +                     no-map;
>>> +                     size = <0x100000>;
>>> +                     linux,dma-default;
>>> +             };
>>> +     };
>>> +
>>> +     aliases {
>>> +             serial0 = &uart4;
>>> +             serial1 = &usart3;
>>> +     };
>>> +
>>> +     leds {
>>> +             compatible = "gpio-leds";
>>> +             led-red {
>>> +                     gpios = <&gpioi 8 0>;
>>> +             };
>>> +             led-green {
>>> +                     gpios = <&gpioc 15 0>;
>>> +                     linux,default-trigger = "heartbeat";
>>> +             };
>>> +     };
>>> +
>>> +     v3v3: regulator-v3v3 {
>>> +             compatible = "regulator-fixed";
>>> +             regulator-name = "v3v3";
>>> +             regulator-min-microvolt = <3300000>;
>>> +             regulator-max-microvolt = <3300000>;
>>> +             regulator-always-on;
>>> +     };
>>> +
>>> +     wlan_pwr: regulator-wlan {
>>> +             compatible = "regulator-fixed";
>>> +
>>> +             regulator-name = "wl-reg";
>>> +             regulator-min-microvolt = <3300000>;
>>> +             regulator-max-microvolt = <3300000>;
>>> +
>>> +             gpios = <&gpioc 13 GPIO_ACTIVE_HIGH>;
>>> +             enable-active-high;
>>> +     };
>>> +};
>>> +
>>> +&clk_hse {
>>> +     clock-frequency = <25000000>;
>>> +};
>>> +
>>> +&dma1 {
>>> +     status = "okay";
>>> +};
>>> +
>>> +&dma2 {
>>> +     status = "okay";
>>> +};
>>> +
>>> +&mac {
>>> +     status = "disabled";
>>> +     pinctrl-0       = <&ethernet_rmii>;
>>> +     pinctrl-names   = "default";
>>> +     phy-mode        = "rmii";
>>> +     phy-handle      = <&phy0>;
>>> +
>>> +     mdio0 {
>>> +             #address-cells = <1>;
>>> +             #size-cells = <0>;
>>> +             compatible = "snps,dwmac-mdio";
>>> +             phy0: ethernet-phy@0 {
>>> +                     reg = <0>;
>>> +             };
>>> +     };
>>> +};
>>> +
>>> +&sdmmc1 {
>>> +     pinctrl-names = "default", "opendrain", "sleep";
>>> +     pinctrl-0 = <&sdmmc1_b4_pins_a>;
>>> +     pinctrl-1 = <&sdmmc1_b4_od_pins_a>;
>>> +     pinctrl-2 = <&sdmmc1_b4_sleep_pins_a>;
>>> +     broken-cd;
>>> +     st,neg-edge;
>>> +     bus-width = <4>;
>>> +     vmmc-supply = <&v3v3>;
>>> +     status = "okay";
>>> +};
>>> +
>>> +&sdmmc2 {
>>> +     pinctrl-names = "default", "opendrain", "sleep";
>>> +     pinctrl-0 = <&sdmmc2_b4_pins_a>;
>>> +     pinctrl-1 = <&sdmmc2_b4_od_pins_a>;
>>> +     pinctrl-2 = <&sdmmc2_b4_sleep_pins_a>;
>>> +     broken-cd;
>>> +     non-removable;
>>> +     st,neg-edge;
>>> +     bus-width = <4>;
>>> +     vmmc-supply = <&wlan_pwr>;
>>> +     status = "okay";
>>> +
>>> +     #address-cells = <1>;
>>> +     #size-cells = <0>;
>>> +     brcmf: bcrmf@1 {
>>> +             reg = <1>;
>>> +             compatible = "brcm,bcm4329-fmac";
>>> +     };
>>> +};
>>> +
>>> +&spi1 {
>>> +     status = "okay";
>>> +     pinctrl-0 = <&spi1_pins>;
>>> +     pinctrl-names = "default";
>>> +     cs-gpios = <&gpioa 4 GPIO_ACTIVE_LOW>;
>>> +     dmas = <&dmamux1 37 0x400 0x05>,
>>> +            <&dmamux1 38 0x400 0x05>;
>>> +     dma-names = "rx", "tx";
>>> +
>>> +     flash@0 {
>>> +             #address-cells = <1>;
>>> +             #size-cells = <1>;
>>> +             compatible = "winbond,w25q128", "jedec,spi-nor";
>>> +             reg = <0>;
>>> +             spi-max-frequency = <80000000>;
>>> +
>>> +             partition@0 {
>>> +                     label = "root filesystem";
>>> +                     reg = <0 0x1000000>;
>>> +             };
>>> +     };
>>> +};
>>> +
>>> +&usart2 {
>>> +     pinctrl-0 = <&usart2_pins>;
>>> +     pinctrl-names = "default";
>>> +     status = "disabled";
>>> +};
>>> +
>>> +&usart3 {
>>> +     pinctrl-names = "default";
>>> +     pinctrl-0 = <&usart3_pins>;
>>> +     dmas = <&dmamux1 45 0x400 0x05>,
>>> +            <&dmamux1 46 0x400 0x05>;
>>> +     dma-names = "rx", "tx";
>>> +     st,hw-flow-ctrl;
>>> +     status = "okay";
>>> +
>>> +     bluetooth {
>>> +             compatible = "brcm,bcm43438-bt";
>>> +             host-wakeup-gpios = <&gpioc 0 GPIO_ACTIVE_HIGH>;
>>> +             device-wakeup-gpios = <&gpioi 10 GPIO_ACTIVE_HIGH>;
>>> +             shutdown-gpios = <&gpioi 11 GPIO_ACTIVE_HIGH>;
>>> +             max-speed = <115200>;
>>> +     };
>>> +};
>>> +
>>> +&uart4 {
>>> +     pinctrl-0 = <&uart4_pins>;
>>> +     pinctrl-names = "default";
>>> +     status = "okay";
>>> +};
>>> +
>>> +
>>>

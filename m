Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F31AC433C1
	for <linux-serial@archiver.kernel.org>; Tue, 30 Mar 2021 07:24:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D537D61989
	for <linux-serial@archiver.kernel.org>; Tue, 30 Mar 2021 07:24:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231246AbhC3HYX (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 30 Mar 2021 03:24:23 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:54424 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231430AbhC3HX4 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 30 Mar 2021 03:23:56 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12U7N8ml006087;
        Tue, 30 Mar 2021 09:23:41 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=4RpYS3bQohPu4twEz5+BT6akpE8YbokLzNgugBmqrfE=;
 b=ZLlbRfqohwbnJZjdih+W/EyYaBiUpdaHUXt+VqvD4jyEeRUKqtDobWDPs5r0vW7wnmsC
 Wxbk9zg308fjcvfqmodVAykz/tUyvRbOFWRb3vu8iqElla71Z3cwUV+bADRKi5K2asuu
 c4PxdhwGg+O7e4jlialZprndRTVIluiFycxyhqP0J2DRaCgyyNAkrvCXXgGJEKhOBzvf
 j6Fq59ZJ/yZB8GeTagKvmJHflWJdLLpjK+gXbKJxr2sIXwtNW3fCeMi7URCrDcJyZgxP
 BJNJZ4eryE6mbqxxEpX70g3Av5ukHCkrtUVd5hbrDd9/b57TkmhBVJqpisU/TQOUWPLn Gg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 37krj722hc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 Mar 2021 09:23:41 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 5841510002A;
        Tue, 30 Mar 2021 09:23:41 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 4097B225FED;
        Tue, 30 Mar 2021 09:23:41 +0200 (CEST)
Received: from lmecxl0912.lme.st.com (10.75.127.45) by SFHDAG2NODE3.st.com
 (10.75.127.6) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 30 Mar
 2021 09:23:39 +0200
Subject: Re: [PATCH v7 4/6] ARM: dts: stm32: add support for art-pi board
 based on stm32h750xbh6
To:     <dillon.minfei@gmail.com>, <robh@kernel.org>,
        <valentin.caron@foss.st.com>, <rong.a.chen@intel.com>,
        <a.fatoum@pengutronix.de>, <mcoquelin.stm32@gmail.com>,
        <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux@armlinux.org.uk>,
        <afzal.mohd.ma@gmail.com>, <gregkh@linuxfoundation.org>,
        <erwan.leray@foss.st.com>, <erwan.leray@st.com>,
        <linux-serial@vger.kernel.org>, <lkp@intel.com>,
        <patrice.chotard@foss.st.com>
References: <1617071338-9436-1-git-send-email-dillon.minfei@gmail.com>
 <1617071338-9436-5-git-send-email-dillon.minfei@gmail.com>
From:   Alexandre TORGUE <alexandre.torgue@foss.st.com>
Message-ID: <ada987c9-6631-18be-78c8-2246c60d5a4e@foss.st.com>
Date:   Tue, 30 Mar 2021 09:23:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1617071338-9436-5-git-send-email-dillon.minfei@gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG3NODE1.st.com (10.75.127.7) To SFHDAG2NODE3.st.com
 (10.75.127.6)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-30_02:2021-03-26,2021-03-30 signatures=0
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi Dillon

On 3/30/21 4:28 AM, dillon.minfei@gmail.com wrote:
> From: dillon min <dillon.minfei@gmail.com>
> 
> This patchset has following changes:
> 
> - introduce stm32h750.dtsi to support stm32h750 value line
> - add stm32h750i-art-pi.dtb (arch/arm/boot/dts/Makefile)
> - add dts binding usart3 for bt, uart4 for console
>    usart3/uart4 pinctrl in stm32h7-pinctrl.dtsi
>    usart3/uart4 register in stm32h743.dtsi
> - add dts binding sdmmc2 for wifi
>    sdmmc2 pinctrl in stm32h7-pinctrl.dtsi
>    sdmmc2 register in stm32h743.dtsi
> - add spi1 pinctrl in stm32h7-pinctrl.dtsi for spi flash
> - add stm32h750-art-pi.dts to support art-pi board
> - add pinctrl: pin-controller@58020000 {} to fix dtbs_check warrnings
> 
> art-pi board component:
> - 8MiB qspi flash
> - 16MiB spi flash
> - 32MiB sdram
> - ap6212 wifi&bt&fm
> 
> the detail board information can be found at:
> https://art-pi.gitee.io/website/
> 
> Signed-off-by: dillon min <dillon.minfei@gmail.com>
> ---
> v7:
> - remove stm32h750-pinctrl.dtsi as it's has same ball out and AF mux with
>    stm32h743, so just reuse stm32h743's pinctrl.
> - stm32h750i-art-pi.dts changes to include "stm32h743-pinctrl.dtsi"
> 
>   arch/arm/boot/dts/Makefile              |   1 +
>   arch/arm/boot/dts/stm32h743.dtsi        | 164 ++++++++++++++++++++++-
>   arch/arm/boot/dts/stm32h750.dtsi        |   6 +
>   arch/arm/boot/dts/stm32h750i-art-pi.dts | 229 ++++++++++++++++++++++++++++++++
>   4 files changed, 398 insertions(+), 2 deletions(-)
>   create mode 100644 arch/arm/boot/dts/stm32h750.dtsi
>   create mode 100644 arch/arm/boot/dts/stm32h750i-art-pi.dts
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 8e5d4ab4e75e..a19c5ab9df84 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -1071,6 +1071,7 @@ dtb-$(CONFIG_ARCH_STM32) += \
>   	stm32746g-eval.dtb \
>   	stm32h743i-eval.dtb \
>   	stm32h743i-disco.dtb \
> +	stm32h750i-art-pi.dtb \
>   	stm32mp153c-dhcom-drc02.dtb \
>   	stm32mp157a-avenger96.dtb \
>   	stm32mp157a-dhcor-avenger96.dtb \
> diff --git a/arch/arm/boot/dts/stm32h743.dtsi b/arch/arm/boot/dts/stm32h743.dtsi
> index 4ebffb0a45a3..a17e98648e2a 100644
> --- a/arch/arm/boot/dts/stm32h743.dtsi
> +++ b/arch/arm/boot/dts/stm32h743.dtsi
> @@ -135,6 +135,22 @@
>   			clocks = <&rcc USART2_CK>;
>   		};
>   
> +		usart3: serial@40004800 {
> +			compatible = "st,stm32h7-uart";
> +			reg = <0x40004800 0x400>;
> +			interrupts = <39>;
> +			status = "disabled";
> +			clocks = <&rcc USART3_CK>;
> +		};
> +
> +		uart4: serial@40004c00 {
> +			compatible = "st,stm32h7-uart";
> +			reg = <0x40004c00 0x400>;
> +			interrupts = <52>;
> +			status = "disabled";
> +			clocks = <&rcc UART4_CK>;
> +		};
> +
>   		i2c1: i2c@40005400 {
>   			compatible = "st,stm32f7-i2c";
>   			#address-cells = <1>;
> @@ -159,7 +175,7 @@
>   			status = "disabled";
>   		};
>   
> -		i2c3: i2c@40005C00 {
> +		i2c3: i2c@40005c00 {
>   			compatible = "st,stm32f7-i2c";
>   			#address-cells = <1>;
>   			#size-cells = <0>;
> @@ -368,6 +384,20 @@
>   			max-frequency = <120000000>;
>   		};
>   
> +		sdmmc2: mmc@48022400 {
> +			compatible = "arm,pl18x", "arm,primecell";
> +			arm,primecell-periphid = <0x10153180>;
> +			reg = <0x48022400 0x400>;
> +			interrupts = <124>;
> +			interrupt-names	= "cmd_irq";
> +			clocks = <&rcc SDMMC2_CK>;
> +			clock-names = "apb_pclk";
> +			resets = <&rcc STM32H7_AHB2_RESET(SDMMC2)>;
> +			cap-sd-highspeed;
> +			cap-mmc-highspeed;
> +			max-frequency = <120000000>;
> +		};
> +
>   		exti: interrupt-controller@58000000 {
>   			compatible = "st,stm32h7-exti";
>   			interrupt-controller;
> @@ -392,7 +422,7 @@
>   			status = "disabled";
>   		};
>   
> -		i2c4: i2c@58001C00 {
> +		i2c4: i2c@58001c00 {
>   			compatible = "st,stm32f7-i2c";
>   			#address-cells = <1>;
>   			#size-cells = <0>;
> @@ -555,6 +585,136 @@
>   			snps,pbl = <8>;
>   			status = "disabled";
>   		};
> +
> +		pinctrl: pin-controller@58020000 {

As said in my previous answer, can you do it in patch[3] please.

> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			ranges = <0 0x58020000 0x3000>;
> +			interrupt-parent = <&exti>;
> +			st,syscfg = <&syscfg 0x8>;
> +			pins-are-numbered;
> +
> +			gpioa: gpio@58020000 {
> +				gpio-controller;
> +				#gpio-cells = <2>;
> +				reg = <0x0 0x400>;
> +				clocks = <&rcc GPIOA_CK>;
> +				st,bank-name = "GPIOA";
> +				interrupt-controller;
> +				#interrupt-cells = <2>;
> +				status = "disabled";
> +			};
> +
> +			gpiob: gpio@58020400 {
> +				gpio-controller;
> +				#gpio-cells = <2>;
> +				reg = <0x400 0x400>;
> +				clocks = <&rcc GPIOB_CK>;
> +				st,bank-name = "GPIOB";
> +				interrupt-controller;
> +				#interrupt-cells = <2>;
> +				status = "disabled";
> +			};
> +
> +			gpioc: gpio@58020800 {
> +				gpio-controller;
> +				#gpio-cells = <2>;
> +				reg = <0x800 0x400>;
> +				clocks = <&rcc GPIOC_CK>;
> +				st,bank-name = "GPIOC";
> +				interrupt-controller;
> +				#interrupt-cells = <2>;
> +				status = "disabled";
> +			};
> +
> +			gpiod: gpio@58020c00 {
> +				gpio-controller;
> +				#gpio-cells = <2>;
> +				reg = <0xc00 0x400>;
> +				clocks = <&rcc GPIOD_CK>;
> +				st,bank-name = "GPIOD";
> +				interrupt-controller;
> +				#interrupt-cells = <2>;
> +				status = "disabled";
> +			};
> +
> +			gpioe: gpio@58021000 {
> +				gpio-controller;
> +				#gpio-cells = <2>;
> +				reg = <0x1000 0x400>;
> +				clocks = <&rcc GPIOE_CK>;
> +				st,bank-name = "GPIOE";
> +				interrupt-controller;
> +				#interrupt-cells = <2>;
> +				status = "disabled";
> +			};
> +
> +			gpiof: gpio@58021400 {
> +				gpio-controller;
> +				#gpio-cells = <2>;
> +				reg = <0x1400 0x400>;
> +				clocks = <&rcc GPIOF_CK>;
> +				st,bank-name = "GPIOF";
> +				interrupt-controller;
> +				#interrupt-cells = <2>;
> +				status = "disabled";
> +			};
> +
> +			gpiog: gpio@58021800 {
> +				gpio-controller;
> +				#gpio-cells = <2>;
> +				reg = <0x1800 0x400>;
> +				clocks = <&rcc GPIOG_CK>;
> +				st,bank-name = "GPIOG";
> +				interrupt-controller;
> +				#interrupt-cells = <2>;
> +				status = "disabled";
> +			};
> +
> +			gpioh: gpio@58021c00 {
> +				gpio-controller;
> +				#gpio-cells = <2>;
> +				reg = <0x1c00 0x400>;
> +				clocks = <&rcc GPIOH_CK>;
> +				st,bank-name = "GPIOH";
> +				interrupt-controller;
> +				#interrupt-cells = <2>;
> +				status = "disabled";
> +			};
> +
> +			gpioi: gpio@58022000 {
> +				gpio-controller;
> +				#gpio-cells = <2>;
> +				reg = <0x2000 0x400>;
> +				clocks = <&rcc GPIOI_CK>;
> +				st,bank-name = "GPIOI";
> +				interrupt-controller;
> +				#interrupt-cells = <2>;
> +				status = "disabled";
> +			};
> +
> +			gpioj: gpio@58022400 {
> +				gpio-controller;
> +				#gpio-cells = <2>;
> +				reg = <0x2400 0x400>;
> +				clocks = <&rcc GPIOJ_CK>;
> +				st,bank-name = "GPIOJ";
> +				interrupt-controller;
> +				#interrupt-cells = <2>;
> +				status = "disabled";
> +			};
> +
> +			gpiok: gpio@58022800 {
> +				gpio-controller;
> +				#gpio-cells = <2>;
> +				reg = <0x2800 0x400>;
> +				clocks = <&rcc GPIOK_CK>;
> +				st,bank-name = "GPIOK";
> +				interrupt-controller;
> +				#interrupt-cells = <2>;
> +				status = "disabled";
> +			};
> +		};
>   	};
>   };
>   
> diff --git a/arch/arm/boot/dts/stm32h750.dtsi b/arch/arm/boot/dts/stm32h750.dtsi
> new file mode 100644
> index 000000000000..41e3b1e3a874
> --- /dev/null
> +++ b/arch/arm/boot/dts/stm32h750.dtsi
> @@ -0,0 +1,6 @@
> +/* SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause) */
> +/* Copyright (C) STMicroelectronics 2021 - All Rights Reserved */
> +
> +#include "stm32h743.dtsi"
> +

No need to create an empty file. Please drop it.

> +
> diff --git a/arch/arm/boot/dts/stm32h750i-art-pi.dts b/arch/arm/boot/dts/stm32h750i-art-pi.dts
> new file mode 100644
> index 000000000000..1d64f26f4d61
> --- /dev/null
> +++ b/arch/arm/boot/dts/stm32h750i-art-pi.dts
> @@ -0,0 +1,229 @@
> +/*
> + * Copyright 2021 - Dillon Min <dillon.minfei@gmail.com>
> + *
> + * This file is dual-licensed: you can use it either under the terms
> + * of the GPL or the X11 license, at your option. Note that this dual
> + * licensing only applies to this file, and not this project as a
> + * whole.
> + *
> + *  a) This file is free software; you can redistribute it and/or
> + *     modify it under the terms of the GNU General Public License as
> + *     published by the Free Software Foundation; either version 2 of the
> + *     License, or (at your option) any later version.
> + *
> + *     This file is distributed in the hope that it will be useful,
> + *     but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + *     GNU General Public License for more details.
> + *
> + * Or, alternatively,
> + *
> + *  b) Permission is hereby granted, free of charge, to any person
> + *     obtaining a copy of this software and associated documentation
> + *     files (the "Software"), to deal in the Software without
> + *     restriction, including without limitation the rights to use,
> + *     copy, modify, merge, publish, distribute, sublicense, and/or
> + *     sell copies of the Software, and to permit persons to whom the
> + *     Software is furnished to do so, subject to the following
> + *     conditions:
> + *
> + *     The above copyright notice and this permission notice shall be
> + *     included in all copies or substantial portions of the Software.
> + *
> + *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
> + *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
> + *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
> + *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
> + *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
> + *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
> + *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> + *     OTHER DEALINGS IN THE SOFTWARE.
> + *
> + * For art-pi board resources, you can refer to link:
> + * 	https://art-pi.gitee.io/website/
> + */
> +
> +/dts-v1/;
> +#include "stm32h750.dtsi"
> +#include "stm32h743-pinctrl.dtsi"
> +#include <dt-bindings/interrupt-controller/irq.h>
> +#include <dt-bindings/gpio/gpio.h>
> +
> +/ {
> +	model = "RT-Thread STM32H750i-ART-PI board";
> +	compatible = "st,stm32h750i-art-pi", "st,stm32h750";
> +
> +	chosen {
> +		bootargs = "root=/dev/ram";
> +		stdout-path = "serial0:2000000n8";
> +	};
> +
> +	memory@c0000000 {
> +		device_type = "memory";
> +		reg = <0xc0000000 0x2000000>;
> +	};
> +
> +	reserved-memory {
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges;
> +
> +		linux,cma {
> +			compatible = "shared-dma-pool";
> +			no-map;
> +			size = <0x100000>;
> +			linux,dma-default;
> +		};
> +	};
> +
> +	aliases {
> +		serial0 = &uart4;
> +		serial1 = &usart3;
> +	};
> +
> +	leds {
> +		compatible = "gpio-leds";
> +		led-red {
> +			gpios = <&gpioi 8 0>;
> +		};
> +		led-green {
> +			gpios = <&gpioc 15 0>;
> +			linux,default-trigger = "heartbeat";
> +		};
> +	};
> +
> +	v3v3: regulator-v3v3 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "v3v3";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		regulator-always-on;
> +	};
> +
> +	wlan_pwr: regulator-wlan {
> +		compatible = "regulator-fixed";
> +
> +		regulator-name = "wl-reg";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +
> +		gpios = <&gpioc 13 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +	};
> +};
> +
> +&clk_hse {
> +	clock-frequency = <25000000>;
> +};
> +
> +&dma1 {
> +	status = "okay";
> +};
> +
> +&dma2 {
> +	status = "okay";
> +};
> +
> +&mac {
> +	status = "disabled";
> +	pinctrl-0	= <&ethernet_rmii>;
> +	pinctrl-names	= "default";
> +	phy-mode	= "rmii";
> +	phy-handle	= <&phy0>;
> +
> +	mdio0 {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		compatible = "snps,dwmac-mdio";
> +		phy0: ethernet-phy@0 {
> +			reg = <0>;
> +		};
> +	};
> +};
> +
> +&sdmmc1 {
> +	pinctrl-names = "default", "opendrain", "sleep";
> +	pinctrl-0 = <&sdmmc1_b4_pins_a>;
> +	pinctrl-1 = <&sdmmc1_b4_od_pins_a>;
> +	pinctrl-2 = <&sdmmc1_b4_sleep_pins_a>;
> +	broken-cd;
> +	st,neg-edge;
> +	bus-width = <4>;
> +	vmmc-supply = <&v3v3>;
> +	status = "okay";
> +};
> +
> +&sdmmc2 {
> +	pinctrl-names = "default", "opendrain", "sleep";
> +	pinctrl-0 = <&sdmmc2_b4_pins_a>;
> +	pinctrl-1 = <&sdmmc2_b4_od_pins_a>;
> +	pinctrl-2 = <&sdmmc2_b4_sleep_pins_a>;
> +	broken-cd;
> +	non-removable;
> +	st,neg-edge;
> +	bus-width = <4>;
> +	vmmc-supply = <&wlan_pwr>;
> +	status = "okay";
> +
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +	brcmf: bcrmf@1 {
> +		reg = <1>;
> +		compatible = "brcm,bcm4329-fmac";
> +	};
> +};
> +
> +&spi1 {
> +	status = "okay";
> +	pinctrl-0 = <&spi1_pins>;
> +	pinctrl-names = "default";
> +	cs-gpios = <&gpioa 4 GPIO_ACTIVE_LOW>;
> +	dmas = <&dmamux1 37 0x400 0x05>,
> +	       <&dmamux1 38 0x400 0x05>;
> +	dma-names = "rx", "tx";
> +
> +	flash@0 {
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		compatible = "winbond,w25q128", "jedec,spi-nor";
> +		reg = <0>;
> +		spi-max-frequency = <80000000>;
> +
> +		partition@0 {
> +			label = "root filesystem";
> +			reg = <0 0x1000000>;
> +		};
> +	};
> +};
> +
> +&usart2 {
> +	pinctrl-0 = <&usart2_pins>;
> +	pinctrl-names = "default";
> +	status = "disabled";
> +};
> +
> +&usart3 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&usart3_pins>;
> +	dmas = <&dmamux1 45 0x400 0x05>,
> +	       <&dmamux1 46 0x400 0x05>;
> +	dma-names = "rx", "tx";
> +	st,hw-flow-ctrl;
> +	status = "okay";
> +
> +	bluetooth {
> +		compatible = "brcm,bcm43438-bt";
> +		host-wakeup-gpios = <&gpioc 0 GPIO_ACTIVE_HIGH>;
> +		device-wakeup-gpios = <&gpioi 10 GPIO_ACTIVE_HIGH>;
> +		shutdown-gpios = <&gpioi 11 GPIO_ACTIVE_HIGH>;
> +		max-speed = <115200>;
> +	};
> +};
> +
> +&uart4 {
> +	pinctrl-0 = <&uart4_pins>;
> +	pinctrl-names = "default";
> +	status = "okay";
> +};
> +
> +
> 

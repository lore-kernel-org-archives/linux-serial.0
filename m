Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBBA5C433C1
	for <linux-serial@archiver.kernel.org>; Tue, 30 Mar 2021 16:45:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B2A46619CD
	for <linux-serial@archiver.kernel.org>; Tue, 30 Mar 2021 16:45:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232048AbhC3Qol (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 30 Mar 2021 12:44:41 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:14880 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231636AbhC3Qoa (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 30 Mar 2021 12:44:30 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12UGgxi5007735;
        Tue, 30 Mar 2021 18:44:04 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=kAcvdtNkeUI92k8x09e6A5+wB3yfnGGlGhdn1gdfR+s=;
 b=yZGXz0sszsryrDiTCb9YOsXitoCj4h9O4Axn4seoIy05Usv0+c0bdAouTxrSRivEeJCQ
 OA+E9wSpcisFoxSUeteqc1sCwN9vg/zVVwIW7XMBCdd8EggaPMgddwy+CpU/IlcBi/eb
 u0Mri42rkad+j463O/UG5maAS+DM7L8L41K0CcU9p8qiE+zvvqiQZXwOnsYLBM1i2Neb
 oX9dv15/4nlNlWKbZDo2V+4t4hKx4j8fb0i/8DU8CPiiV6cqMwh5h244KgKWoyQApKMs
 H6WdyT5r8tZj4Ln0ztIkYJRgUv7wlnW4iIER6L23rD5ZinaSJTCxWn7pGeRLOTUHvvVb kA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 37ksfh54k9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 Mar 2021 18:44:04 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id F194510002A;
        Tue, 30 Mar 2021 18:44:02 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id B5BD7221773;
        Tue, 30 Mar 2021 18:44:02 +0200 (CEST)
Received: from lmecxl0912.lme.st.com (10.75.127.46) by SFHDAG2NODE3.st.com
 (10.75.127.6) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 30 Mar
 2021 18:44:01 +0200
Subject: Re: [PATCH v8 3/6] ARM: dts: stm32: introduce stm32h7-pinctrl.dtsi to
 support stm32h750
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
References: <1617094704-10040-1-git-send-email-dillon.minfei@gmail.com>
 <1617094704-10040-4-git-send-email-dillon.minfei@gmail.com>
From:   Alexandre TORGUE <alexandre.torgue@foss.st.com>
Message-ID: <d08d3195-5379-ff1e-fefd-f38297e18108@foss.st.com>
Date:   Tue, 30 Mar 2021 18:44:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1617094704-10040-4-git-send-email-dillon.minfei@gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.46]
X-ClientProxiedBy: SFHDAG3NODE3.st.com (10.75.127.9) To SFHDAG2NODE3.st.com
 (10.75.127.6)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-30_08:2021-03-30,2021-03-30 signatures=0
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org



On 3/30/21 10:58 AM, dillon.minfei@gmail.com wrote:
> From: dillon min <dillon.minfei@gmail.com>
> 
> This patch is intend to add support stm32h750 value line,
> just add stm32h7-pinctrl.dtsi for extending, with following changes:
> 
> - rename stm32h743-pinctrl.dtsi to stm32h7-pinctrl.dtsi
> - update stm32h743i-{dico/eval}.dtsi to include stm32h7-pinctrl.dtsi
> - add dts binding usart3, uart4
>    usart3/uart4 pinctrl in stm32h7-pinctrl.dtsi
>    usart3/uart4 register in stm32h743.dtsi
> - add dts binding sdmmc2
>    sdmmc2 pinctrl in stm32h7-pinctrl.dtsi
>    sdmmc2 register in stm32h743.dtsi
> - add spi1_pins pinctrl in stm32h7-pinctrl.dtsi
> - move 'pin-controller' from stm32h7-pinctrl.dtsi to stm32h743.dtsi, to
>    fix make dtbs_check warrnings
>    arch/arm/boot/dts/stm32h750i-art-pi.dt.yaml: soc: 'i2c@40005C00',
>    'i2c@58001C00' do not match any of the regexes:
>    '@(0|[1-9a-f][0-9a-f]*)$', '^[^@]+$', 'pinctrl-[0-9]+'
> 
> Signed-off-by: dillon min <dillon.minfei@gmail.com>
> ---
> v8:
> - drop '[PATCH v7 3/6] ARM: dts: stm32: introduce stm32h7-pinctrl.dtsi to
>    support stm32h750' - stm32h743-pinctrl.dtsi file
> - move compatible string "st,stm32h743-pinctrl" from stm32h7-pinctrl.dtsi
>    to stm32h743.dtsi
> - update stm32h743i-{dico/eval}.dtsi to include stm32h7-pinctrl.dtsi
> - move file stm32h743.dtsi submit position to [PATCH V8 3/6]
> 
>   arch/arm/boot/dts/stm32h7-pinctrl.dtsi   | 341 +++++++++++++++++++++++++++++++
>   arch/arm/boot/dts/stm32h743-pinctrl.dtsi | 306 ---------------------------
>   arch/arm/boot/dts/stm32h743.dtsi         | 165 ++++++++++++++-
>   arch/arm/boot/dts/stm32h743i-disco.dts   |   2 +-
>   arch/arm/boot/dts/stm32h743i-eval.dts    |   2 +-
>   5 files changed, 506 insertions(+), 310 deletions(-)
>   create mode 100644 arch/arm/boot/dts/stm32h7-pinctrl.dtsi
>   delete mode 100644 arch/arm/boot/dts/stm32h743-pinctrl.dtsi
> 
> diff --git a/arch/arm/boot/dts/stm32h7-pinctrl.dtsi b/arch/arm/boot/dts/stm32h7-pinctrl.dtsi
> new file mode 100644
> index 000000000000..a5c295eca081
> --- /dev/null
> +++ b/arch/arm/boot/dts/stm32h7-pinctrl.dtsi
> @@ -0,0 +1,341 @@
> +/*
> + * Copyright 2017 - Alexandre Torgue <alexandre.torgue@st.com>
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
> + */
> +
> +#include <dt-bindings/pinctrl/stm32-pinfunc.h>
> +
> +&pinctrl {
> +
> +	gpioa: gpio@58020000 {
> +		status = "okay";
> +		ngpios = <16>;
> +		gpio-ranges = <&pinctrl 0 0 16>;
> +	};
> +

You could move those entries directly into stm32h743.dtsi no ?

> +	gpiob: gpio@58020400 {
> +		status = "okay";
> +		ngpios = <16>;
> +		gpio-ranges = <&pinctrl 0 16 16>;
> +	};
> +
> +	gpioc: gpio@58020800 {
> +		status = "okay";
> +		ngpios = <16>;
> +		gpio-ranges = <&pinctrl 0 32 16>;
> +	};
> +
> +	gpiod: gpio@58020c00 {
> +		status = "okay";
> +		ngpios = <16>;
> +		gpio-ranges = <&pinctrl 0 48 16>;
> +	};
> +
> +	gpioe: gpio@58021000 {
> +		status = "okay";
> +		ngpios = <16>;
> +		gpio-ranges = <&pinctrl 0 64 16>;
> +	};
> +
> +	gpiof: gpio@58021400 {
> +		status = "okay";
> +		ngpios = <16>;
> +		gpio-ranges = <&pinctrl 0 80 16>;
> +	};
> +
> +	gpiog: gpio@58021800 {
> +		status = "okay";
> +		ngpios = <16>;
> +		gpio-ranges = <&pinctrl 0 96 16>;
> +	};
> +
> +	gpioh: gpio@58021c00 {
> +		status = "okay";
> +		ngpios = <16>;
> +		gpio-ranges = <&pinctrl 0 112 16>;
> +	};
> +
> +	gpioi: gpio@58022000 {
> +		status = "okay";
> +		ngpios = <16>;
> +		gpio-ranges = <&pinctrl 0 128 16>;
> +	};
> +
> +	gpioj: gpio@58022400 {
> +		status = "okay";
> +		ngpios = <16>;
> +		gpio-ranges = <&pinctrl 0 144 16>;
> +	};
> +
> +	gpiok: gpio@58022800 {
> +		status = "okay";
> +		ngpios = <8>;
> +		gpio-ranges = <&pinctrl 0 160 8>;
> +	};
> +
> +	i2c1_pins_a: i2c1-0 {
> +		pins {
> +			pinmux = <STM32_PINMUX('B', 6, AF4)>, /* I2C1_SCL */
> +				 <STM32_PINMUX('B', 7, AF4)>; /* I2C1_SDA */
> +			bias-disable;
> +			drive-open-drain;
> +			slew-rate = <0>;
> +		};
> +	};
> +
> +	ethernet_rmii: rmii-0 {
> +		pins {
> +			pinmux = <STM32_PINMUX('G', 11, AF11)>,
> +				 <STM32_PINMUX('G', 13, AF11)>,
> +				 <STM32_PINMUX('G', 12, AF11)>,
> +				 <STM32_PINMUX('C', 4, AF11)>,
> +				 <STM32_PINMUX('C', 5, AF11)>,
> +				 <STM32_PINMUX('A', 7, AF11)>,
> +				 <STM32_PINMUX('C', 1, AF11)>,
> +				 <STM32_PINMUX('A', 2, AF11)>,
> +				 <STM32_PINMUX('A', 1, AF11)>;
> +			slew-rate = <2>;
> +		};
> +	};
> +
> +	sdmmc1_b4_pins_a: sdmmc1-b4-0 {
> +		pins {
> +			pinmux = <STM32_PINMUX('C', 8, AF12)>, /* SDMMC1_D0 */
> +				 <STM32_PINMUX('C', 9, AF12)>, /* SDMMC1_D1 */
> +				 <STM32_PINMUX('C', 10, AF12)>, /* SDMMC1_D2 */
> +				 <STM32_PINMUX('C', 11, AF12)>, /* SDMMC1_D3 */
> +				 <STM32_PINMUX('C', 12, AF12)>, /* SDMMC1_CK */
> +				 <STM32_PINMUX('D', 2, AF12)>; /* SDMMC1_CMD */
> +			slew-rate = <3>;
> +			drive-push-pull;
> +			bias-disable;
> +		};
> +	};
> +
> +	sdmmc1_b4_od_pins_a: sdmmc1-b4-od-0 {
> +		pins1 {
> +			pinmux = <STM32_PINMUX('C', 8, AF12)>, /* SDMMC1_D0 */
> +				 <STM32_PINMUX('C', 9, AF12)>, /* SDMMC1_D1 */
> +				 <STM32_PINMUX('C', 10, AF12)>, /* SDMMC1_D2 */
> +				 <STM32_PINMUX('C', 11, AF12)>, /* SDMMC1_D3 */
> +				 <STM32_PINMUX('C', 12, AF12)>; /* SDMMC1_CK */
> +			slew-rate = <3>;
> +			drive-push-pull;
> +			bias-disable;
> +		};
> +		pins2{
> +			pinmux = <STM32_PINMUX('D', 2, AF12)>; /* SDMMC1_CMD */
> +			slew-rate = <3>;
> +			drive-open-drain;
> +			bias-disable;
> +		};
> +	};
> +
> +	sdmmc1_b4_sleep_pins_a: sdmmc1-b4-sleep-0 {
> +		pins {
> +			pinmux = <STM32_PINMUX('C', 8, ANALOG)>, /* SDMMC1_D0 */
> +				 <STM32_PINMUX('C', 9, ANALOG)>, /* SDMMC1_D1 */
> +				 <STM32_PINMUX('C', 10, ANALOG)>, /* SDMMC1_D2 */
> +				 <STM32_PINMUX('C', 11, ANALOG)>, /* SDMMC1_D3 */
> +				 <STM32_PINMUX('C', 12, ANALOG)>, /* SDMMC1_CK */
> +				 <STM32_PINMUX('D', 2, ANALOG)>; /* SDMMC1_CMD */
> +		};
> +	};
> +
> +	sdmmc2_b4_pins_a: sdmmc2-b4-0 {
> +		pins {
> +			pinmux = <STM32_PINMUX('B', 14, AF9)>, /* SDMMC1_D0 */
> +				 <STM32_PINMUX('B', 15, AF9)>, /* SDMMC1_D1 */
> +				 <STM32_PINMUX('B', 3, AF9)>, /* SDMMC1_D2 */
> +				 <STM32_PINMUX('B', 4, AF9)>, /* SDMMC1_D3 */
> +				 <STM32_PINMUX('D', 6, AF11)>, /* SDMMC1_CK */
> +				 <STM32_PINMUX('D', 7, AF11)>; /* SDMMC1_CMD */
> +			slew-rate = <3>;
> +			drive-push-pull;
> +			bias-disable;
> +		};
> +	};
> +
> +	sdmmc2_b4_od_pins_a: sdmmc2-b4-od-0 {
> +		pins1 {
> +			pinmux = <STM32_PINMUX('B', 14, AF9)>, /* SDMMC2_D0 */
> +				 <STM32_PINMUX('B', 15, AF9)>, /* SDMMC1_D1 */
> +				 <STM32_PINMUX('B', 3, AF9)>, /* SDMMC1_D2 */
> +				 <STM32_PINMUX('B', 4, AF9)>, /* SDMMC1_D3 */
> +				 <STM32_PINMUX('D', 6, AF11)>; /* SDMMC1_CK */
> +			slew-rate = <3>;
> +			drive-push-pull;
> +			bias-disable;
> +		};
> +		pins2{
> +			pinmux = <STM32_PINMUX('D', 7, AF11)>; /* SDMMC1_CMD */
> +			slew-rate = <3>;
> +			drive-open-drain;
> +			bias-disable;
> +		};
> +	};
> +
> +	sdmmc2_b4_sleep_pins_a: sdmmc2-b4-sleep-0 {
> +		pins {
> +			pinmux = <STM32_PINMUX('B', 14, ANALOG)>, /* SDMMC1_D0 */
> +				 <STM32_PINMUX('B', 15, ANALOG)>, /* SDMMC1_D1 */
> +				 <STM32_PINMUX('B', 3, ANALOG)>, /* SDMMC1_D2 */
> +				 <STM32_PINMUX('B', 4, ANALOG)>, /* SDMMC1_D3 */
> +				 <STM32_PINMUX('D', 6, ANALOG)>, /* SDMMC1_CK */
> +				 <STM32_PINMUX('D', 7, ANALOG)>; /* SDMMC1_CMD */
> +		};
> +	};
> +
> +	sdmmc1_dir_pins_a: sdmmc1-dir-0 {
> +		pins1 {
> +			pinmux = <STM32_PINMUX('C', 6, AF8)>, /* SDMMC1_D0DIR */
> +				 <STM32_PINMUX('C', 7, AF8)>, /* SDMMC1_D123DIR */
> +				 <STM32_PINMUX('B', 9, AF7)>; /* SDMMC1_CDIR */
> +			slew-rate = <3>;
> +			drive-push-pull;
> +			bias-pull-up;
> +		};
> +		pins2{
> +			pinmux = <STM32_PINMUX('B', 8, AF7)>; /* SDMMC1_CKIN */
> +			bias-pull-up;
> +		};
> +	};
> +
> +	sdmmc1_dir_sleep_pins_a: sdmmc1-dir-sleep-0 {
> +		pins {
> +			pinmux = <STM32_PINMUX('C', 6, ANALOG)>, /* SDMMC1_D0DIR */
> +				 <STM32_PINMUX('C', 7, ANALOG)>, /* SDMMC1_D123DIR */
> +				 <STM32_PINMUX('B', 9, ANALOG)>, /* SDMMC1_CDIR */
> +				 <STM32_PINMUX('B', 8, ANALOG)>; /* SDMMC1_CKIN */
> +		};
> +	};
> +
> +	usart1_pins: usart1-0 {
> +		pins1 {
> +			pinmux = <STM32_PINMUX('B', 14, AF4)>; /* USART1_TX */
> +			bias-disable;
> +			drive-push-pull;
> +			slew-rate = <0>;
> +		};
> +		pins2 {
> +			pinmux = <STM32_PINMUX('B', 15, AF4)>; /* USART1_RX */
> +			bias-disable;
> +		};
> +	};
> +
> +	usart2_pins: usart2-0 {
> +		pins1 {
> +			pinmux = <STM32_PINMUX('D', 5, AF7)>; /* USART2_TX */
> +			bias-disable;
> +			drive-push-pull;
> +			slew-rate = <0>;
> +		};
> +		pins2 {
> +			pinmux = <STM32_PINMUX('D', 6, AF7)>; /* USART2_RX */
> +			bias-disable;
> +		};
> +	};
> +
> +	usart3_pins: usart3-0 {
> +		pins1 {
> +			pinmux = <STM32_PINMUX('B', 10, AF7)>, /* USART3_TX */
> +				 <STM32_PINMUX('D', 12, AF7)>; /* USART3_RTS_DE */
> +			bias-disable;
> +			drive-push-pull;
> +			slew-rate = <0>;
> +		};
> +		pins2 {
> +			pinmux = <STM32_PINMUX('B', 11, AF7)>, /* USART3_RX */
> +				 <STM32_PINMUX('D', 11, AF7)>; /* USART3_CTS_NSS */
> +			bias-disable;
> +		};
> +	};
> +
> +	uart4_pins: uart4-0 {
> +		pins1 {
> +			pinmux = <STM32_PINMUX('A', 0, AF8)>; /* UART4_TX */
> +			bias-disable;
> +			drive-push-pull;
> +			slew-rate = <0>;
> +		};
> +		pins2 {
> +			pinmux = <STM32_PINMUX('I', 9, AF8)>; /* UART4_RX */
> +			bias-disable;
> +		};
> +	};
> +
> +	usbotg_hs_pins_a: usbotg-hs-0 {
> +		pins {
> +			pinmux = <STM32_PINMUX('H', 4, AF10)>,	/* ULPI_NXT */
> +					 <STM32_PINMUX('I', 11, AF10)>, /* ULPI_DIR> */
> +					 <STM32_PINMUX('C', 0, AF10)>,	/* ULPI_STP> */
> +					 <STM32_PINMUX('A', 5, AF10)>,	/* ULPI_CK> */
> +					 <STM32_PINMUX('A', 3, AF10)>,	/* ULPI_D0> */
> +					 <STM32_PINMUX('B', 0, AF10)>,	/* ULPI_D1> */
> +					 <STM32_PINMUX('B', 1, AF10)>,	/* ULPI_D2> */
> +					 <STM32_PINMUX('B', 10, AF10)>, /* ULPI_D3> */
> +					 <STM32_PINMUX('B', 11, AF10)>, /* ULPI_D4> */
> +					 <STM32_PINMUX('B', 12, AF10)>, /* ULPI_D5> */
> +					 <STM32_PINMUX('B', 13, AF10)>, /* ULPI_D6> */
> +					 <STM32_PINMUX('B', 5, AF10)>;	/* ULPI_D7> */
> +			bias-disable;
> +			drive-push-pull;
> +			slew-rate = <2>;
> +		};
> +	};
> +
> +	spi1_pins: spi1-0 {
> +		pins1 {
> +			pinmux = <STM32_PINMUX('A', 5, AF5)>,
> +				/* SPI1_CLK */
> +				 <STM32_PINMUX('B', 5, AF5)>;
> +				/* SPI1_MOSI */
> +			bias-disable;
> +			drive-push-pull;
> +			slew-rate = <2>;
> +		};
> +		pins2 {
> +			pinmux = <STM32_PINMUX('G', 9, AF5)>;
> +				/* SPI1_MISO */
> +			bias-disable;
> +		};
> +	};
> +};
> +
> diff --git a/arch/arm/boot/dts/stm32h743-pinctrl.dtsi b/arch/arm/boot/dts/stm32h743-pinctrl.dtsi
> deleted file mode 100644
> index fa5dcb6a5fdd..000000000000
> --- a/arch/arm/boot/dts/stm32h743-pinctrl.dtsi
> +++ /dev/null
> @@ -1,306 +0,0 @@
> -/*
> - * Copyright 2017 - Alexandre Torgue <alexandre.torgue@st.com>
> - *
> - * This file is dual-licensed: you can use it either under the terms
> - * of the GPL or the X11 license, at your option. Note that this dual
> - * licensing only applies to this file, and not this project as a
> - * whole.
> - *
> - *  a) This file is free software; you can redistribute it and/or
> - *     modify it under the terms of the GNU General Public License as
> - *     published by the Free Software Foundation; either version 2 of the
> - *     License, or (at your option) any later version.
> - *
> - *     This file is distributed in the hope that it will be useful,
> - *     but WITHOUT ANY WARRANTY; without even the implied warranty of
> - *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - *     GNU General Public License for more details.
> - *
> - * Or, alternatively,
> - *
> - *  b) Permission is hereby granted, free of charge, to any person
> - *     obtaining a copy of this software and associated documentation
> - *     files (the "Software"), to deal in the Software without
> - *     restriction, including without limitation the rights to use,
> - *     copy, modify, merge, publish, distribute, sublicense, and/or
> - *     sell copies of the Software, and to permit persons to whom the
> - *     Software is furnished to do so, subject to the following
> - *     conditions:
> - *
> - *     The above copyright notice and this permission notice shall be
> - *     included in all copies or substantial portions of the Software.
> - *
> - *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
> - *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
> - *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
> - *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
> - *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
> - *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
> - *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> - *     OTHER DEALINGS IN THE SOFTWARE.
> - */
> -
> -#include <dt-bindings/pinctrl/stm32-pinfunc.h>
> -
> -/ {
> -	soc {
> -		pin-controller {
> -			#address-cells = <1>;
> -			#size-cells = <1>;
> -			compatible = "st,stm32h743-pinctrl";
> -			ranges = <0 0x58020000 0x3000>;
> -			interrupt-parent = <&exti>;
> -			st,syscfg = <&syscfg 0x8>;
> -			pins-are-numbered;
> -
> -			gpioa: gpio@58020000 {
> -				gpio-controller;
> -				#gpio-cells = <2>;
> -				reg = <0x0 0x400>;
> -				clocks = <&rcc GPIOA_CK>;
> -				st,bank-name = "GPIOA";
> -				interrupt-controller;
> -				#interrupt-cells = <2>;
> -			};
> -
> -			gpiob: gpio@58020400 {
> -				gpio-controller;
> -				#gpio-cells = <2>;
> -				reg = <0x400 0x400>;
> -				clocks = <&rcc GPIOB_CK>;
> -				st,bank-name = "GPIOB";
> -				interrupt-controller;
> -				#interrupt-cells = <2>;
> -			};
> -
> -			gpioc: gpio@58020800 {
> -				gpio-controller;
> -				#gpio-cells = <2>;
> -				reg = <0x800 0x400>;
> -				clocks = <&rcc GPIOC_CK>;
> -				st,bank-name = "GPIOC";
> -				interrupt-controller;
> -				#interrupt-cells = <2>;
> -			};
> -
> -			gpiod: gpio@58020c00 {
> -				gpio-controller;
> -				#gpio-cells = <2>;
> -				reg = <0xc00 0x400>;
> -				clocks = <&rcc GPIOD_CK>;
> -				st,bank-name = "GPIOD";
> -				interrupt-controller;
> -				#interrupt-cells = <2>;
> -			};
> -
> -			gpioe: gpio@58021000 {
> -				gpio-controller;
> -				#gpio-cells = <2>;
> -				reg = <0x1000 0x400>;
> -				clocks = <&rcc GPIOE_CK>;
> -				st,bank-name = "GPIOE";
> -				interrupt-controller;
> -				#interrupt-cells = <2>;
> -			};
> -
> -			gpiof: gpio@58021400 {
> -				gpio-controller;
> -				#gpio-cells = <2>;
> -				reg = <0x1400 0x400>;
> -				clocks = <&rcc GPIOF_CK>;
> -				st,bank-name = "GPIOF";
> -				interrupt-controller;
> -				#interrupt-cells = <2>;
> -			};
> -
> -			gpiog: gpio@58021800 {
> -				gpio-controller;
> -				#gpio-cells = <2>;
> -				reg = <0x1800 0x400>;
> -				clocks = <&rcc GPIOG_CK>;
> -				st,bank-name = "GPIOG";
> -				interrupt-controller;
> -				#interrupt-cells = <2>;
> -			};
> -
> -			gpioh: gpio@58021c00 {
> -				gpio-controller;
> -				#gpio-cells = <2>;
> -				reg = <0x1c00 0x400>;
> -				clocks = <&rcc GPIOH_CK>;
> -				st,bank-name = "GPIOH";
> -				interrupt-controller;
> -				#interrupt-cells = <2>;
> -			};
> -
> -			gpioi: gpio@58022000 {
> -				gpio-controller;
> -				#gpio-cells = <2>;
> -				reg = <0x2000 0x400>;
> -				clocks = <&rcc GPIOI_CK>;
> -				st,bank-name = "GPIOI";
> -				interrupt-controller;
> -				#interrupt-cells = <2>;
> -			};
> -
> -			gpioj: gpio@58022400 {
> -				gpio-controller;
> -				#gpio-cells = <2>;
> -				reg = <0x2400 0x400>;
> -				clocks = <&rcc GPIOJ_CK>;
> -				st,bank-name = "GPIOJ";
> -				interrupt-controller;
> -				#interrupt-cells = <2>;
> -			};
> -
> -			gpiok: gpio@58022800 {
> -				gpio-controller;
> -				#gpio-cells = <2>;
> -				reg = <0x2800 0x400>;
> -				clocks = <&rcc GPIOK_CK>;
> -				st,bank-name = "GPIOK";
> -				interrupt-controller;
> -				#interrupt-cells = <2>;
> -			};
> -
> -			i2c1_pins_a: i2c1-0 {
> -				pins {
> -					pinmux = <STM32_PINMUX('B', 6, AF4)>, /* I2C1_SCL */
> -						 <STM32_PINMUX('B', 7, AF4)>; /* I2C1_SDA */
> -					bias-disable;
> -					drive-open-drain;
> -					slew-rate = <0>;
> -				};
> -			};
> -
> -			ethernet_rmii: rmii-0 {
> -				pins {
> -					pinmux = <STM32_PINMUX('G', 11, AF11)>,
> -						 <STM32_PINMUX('G', 13, AF11)>,
> -						 <STM32_PINMUX('G', 12, AF11)>,
> -						 <STM32_PINMUX('C', 4, AF11)>,
> -						 <STM32_PINMUX('C', 5, AF11)>,
> -						 <STM32_PINMUX('A', 7, AF11)>,
> -						 <STM32_PINMUX('C', 1, AF11)>,
> -						 <STM32_PINMUX('A', 2, AF11)>,
> -						 <STM32_PINMUX('A', 1, AF11)>;
> -					slew-rate = <2>;
> -				};
> -			};
> -
> -			sdmmc1_b4_pins_a: sdmmc1-b4-0 {
> -				pins {
> -					pinmux = <STM32_PINMUX('C', 8, AF12)>, /* SDMMC1_D0 */
> -						 <STM32_PINMUX('C', 9, AF12)>, /* SDMMC1_D1 */
> -						 <STM32_PINMUX('C', 10, AF12)>, /* SDMMC1_D2 */
> -						 <STM32_PINMUX('C', 11, AF12)>, /* SDMMC1_D3 */
> -						 <STM32_PINMUX('C', 12, AF12)>, /* SDMMC1_CK */
> -						 <STM32_PINMUX('D', 2, AF12)>; /* SDMMC1_CMD */
> -					slew-rate = <3>;
> -					drive-push-pull;
> -					bias-disable;
> -				};
> -			};
> -
> -			sdmmc1_b4_od_pins_a: sdmmc1-b4-od-0 {
> -				pins1 {
> -					pinmux = <STM32_PINMUX('C', 8, AF12)>, /* SDMMC1_D0 */
> -						 <STM32_PINMUX('C', 9, AF12)>, /* SDMMC1_D1 */
> -						 <STM32_PINMUX('C', 10, AF12)>, /* SDMMC1_D2 */
> -						 <STM32_PINMUX('C', 11, AF12)>, /* SDMMC1_D3 */
> -						 <STM32_PINMUX('C', 12, AF12)>; /* SDMMC1_CK */
> -					slew-rate = <3>;
> -					drive-push-pull;
> -					bias-disable;
> -				};
> -				pins2{
> -					pinmux = <STM32_PINMUX('D', 2, AF12)>; /* SDMMC1_CMD */
> -					slew-rate = <3>;
> -					drive-open-drain;
> -					bias-disable;
> -				};
> -			};
> -
> -			sdmmc1_b4_sleep_pins_a: sdmmc1-b4-sleep-0 {
> -				pins {
> -					pinmux = <STM32_PINMUX('C', 8, ANALOG)>, /* SDMMC1_D0 */
> -						 <STM32_PINMUX('C', 9, ANALOG)>, /* SDMMC1_D1 */
> -						 <STM32_PINMUX('C', 10, ANALOG)>, /* SDMMC1_D2 */
> -						 <STM32_PINMUX('C', 11, ANALOG)>, /* SDMMC1_D3 */
> -						 <STM32_PINMUX('C', 12, ANALOG)>, /* SDMMC1_CK */
> -						 <STM32_PINMUX('D', 2, ANALOG)>; /* SDMMC1_CMD */
> -				};
> -			};
> -
> -			sdmmc1_dir_pins_a: sdmmc1-dir-0 {
> -				pins1 {
> -					pinmux = <STM32_PINMUX('C', 6, AF8)>, /* SDMMC1_D0DIR */
> -						 <STM32_PINMUX('C', 7, AF8)>, /* SDMMC1_D123DIR */
> -						 <STM32_PINMUX('B', 9, AF7)>; /* SDMMC1_CDIR */
> -					slew-rate = <3>;
> -					drive-push-pull;
> -					bias-pull-up;
> -				};
> -				pins2{
> -					pinmux = <STM32_PINMUX('B', 8, AF7)>; /* SDMMC1_CKIN */
> -					bias-pull-up;
> -				};
> -			};
> -
> -			sdmmc1_dir_sleep_pins_a: sdmmc1-dir-sleep-0 {
> -				pins {
> -					pinmux = <STM32_PINMUX('C', 6, ANALOG)>, /* SDMMC1_D0DIR */
> -						 <STM32_PINMUX('C', 7, ANALOG)>, /* SDMMC1_D123DIR */
> -						 <STM32_PINMUX('B', 9, ANALOG)>, /* SDMMC1_CDIR */
> -						 <STM32_PINMUX('B', 8, ANALOG)>; /* SDMMC1_CKIN */
> -				};
> -			};
> -
> -			usart1_pins: usart1-0 {
> -				pins1 {
> -					pinmux = <STM32_PINMUX('B', 14, AF4)>; /* USART1_TX */
> -					bias-disable;
> -					drive-push-pull;
> -					slew-rate = <0>;
> -				};
> -				pins2 {
> -					pinmux = <STM32_PINMUX('B', 15, AF4)>; /* USART1_RX */
> -					bias-disable;
> -				};
> -			};
> -
> -			usart2_pins: usart2-0 {
> -				pins1 {
> -					pinmux = <STM32_PINMUX('D', 5, AF7)>; /* USART2_TX */
> -					bias-disable;
> -					drive-push-pull;
> -					slew-rate = <0>;
> -				};
> -				pins2 {
> -					pinmux = <STM32_PINMUX('D', 6, AF7)>; /* USART2_RX */
> -					bias-disable;
> -				};
> -			};
> -
> -			usbotg_hs_pins_a: usbotg-hs-0 {
> -				pins {
> -					pinmux = <STM32_PINMUX('H', 4, AF10)>,	/* ULPI_NXT */
> -							 <STM32_PINMUX('I', 11, AF10)>, /* ULPI_DIR> */
> -							 <STM32_PINMUX('C', 0, AF10)>,	/* ULPI_STP> */
> -							 <STM32_PINMUX('A', 5, AF10)>,	/* ULPI_CK> */
> -							 <STM32_PINMUX('A', 3, AF10)>,	/* ULPI_D0> */
> -							 <STM32_PINMUX('B', 0, AF10)>,	/* ULPI_D1> */
> -							 <STM32_PINMUX('B', 1, AF10)>,	/* ULPI_D2> */
> -							 <STM32_PINMUX('B', 10, AF10)>, /* ULPI_D3> */
> -							 <STM32_PINMUX('B', 11, AF10)>, /* ULPI_D4> */
> -							 <STM32_PINMUX('B', 12, AF10)>, /* ULPI_D5> */
> -							 <STM32_PINMUX('B', 13, AF10)>, /* ULPI_D6> */
> -							 <STM32_PINMUX('B', 5, AF10)>;	/* ULPI_D7> */
> -					bias-disable;
> -					drive-push-pull;
> -					slew-rate = <2>;
> -				};
> -			};
> -		};
> -	};
> -};
> diff --git a/arch/arm/boot/dts/stm32h743.dtsi b/arch/arm/boot/dts/stm32h743.dtsi
> index 4ebffb0a45a3..b58cae967b2a 100644
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
> @@ -555,6 +585,137 @@
>   			snps,pbl = <8>;
>   			status = "disabled";
>   		};
> +
> +		pinctrl: pin-controller@58020000 {
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			compatible = "st,stm32h743-pinctrl";
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
> diff --git a/arch/arm/boot/dts/stm32h743i-disco.dts b/arch/arm/boot/dts/stm32h743i-disco.dts
> index e446d311c520..59e01ce10318 100644
> --- a/arch/arm/boot/dts/stm32h743i-disco.dts
> +++ b/arch/arm/boot/dts/stm32h743i-disco.dts
> @@ -42,7 +42,7 @@
>   
>   /dts-v1/;
>   #include "stm32h743.dtsi"
> -#include "stm32h743-pinctrl.dtsi"
> +#include "stm32h7-pinctrl.dtsi"
>   
>   / {
>   	model = "STMicroelectronics STM32H743i-Discovery board";
> diff --git a/arch/arm/boot/dts/stm32h743i-eval.dts b/arch/arm/boot/dts/stm32h743i-eval.dts
> index 8f398178f5e5..38cc7faf6884 100644
> --- a/arch/arm/boot/dts/stm32h743i-eval.dts
> +++ b/arch/arm/boot/dts/stm32h743i-eval.dts
> @@ -42,7 +42,7 @@
>   
>   /dts-v1/;
>   #include "stm32h743.dtsi"
> -#include "stm32h743-pinctrl.dtsi"
> +#include "stm32h7-pinctrl.dtsi"
>   
>   / {
>   	model = "STMicroelectronics STM32H743i-EVAL board";
> 

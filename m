Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3748C433DB
	for <linux-serial@archiver.kernel.org>; Tue, 30 Mar 2021 07:48:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA29E61990
	for <linux-serial@archiver.kernel.org>; Tue, 30 Mar 2021 07:48:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231341AbhC3Hr6 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 30 Mar 2021 03:47:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231330AbhC3Hr4 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 30 Mar 2021 03:47:56 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BCC0C061762;
        Tue, 30 Mar 2021 00:47:56 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id z136so15444905iof.10;
        Tue, 30 Mar 2021 00:47:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TNRnQsV+MHwo99WlUyDqfLIpGaar0itJ3xWD378KNPA=;
        b=aKzFtxknNR6L9m+ndpoPUPw5eI457y6EtJQmAOyCoMBKT9UgZa92IIGwfEG7voTb0A
         ysGzJ1YTTIajAR+iU0RrwSm40BwjD/TqdiqYmcW08XFhMh0jAAl7enYtFdOoXyVr4SA3
         uDeHP1Vlm4/YaezdBtN1jYOHNXy4keG/jeSkGNHnBBcpGrXn3AOTK7czV6AszLhUhHdU
         YkidmRPL8lhyrRl0i9GqdmUF6y9eUeZ33S4febp1YxQ2HTpYEV3KT2aQgKKzK/XR3WeG
         ELDlY9lUE7K06q5vIu7l46yCIbe8CZzmjJLie1RUM2Bk7x2FBqptHQo6035Mj2qMkLn4
         Djmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TNRnQsV+MHwo99WlUyDqfLIpGaar0itJ3xWD378KNPA=;
        b=qPi8HgbxvtsGEM78P4QQ0VtUNO8VR7TQgf6nMl+1V9Wd5MMEEiOvasNDYA6Ahv6UHm
         04mEYfeiJH6cH+HobG8wcHfPRCPtxSewrNQmQUDeRAmVH1bimavZLyLy11sZFQt7Bvuu
         pFhGh5FjwqMrkLOwqu7mslRzZLRO+AFJXdr8mCL/YXzjq0JhljTAlhmX7/w91ErLvUNe
         T9jvVsQy/8jMpzB4GODqFEwRgC2qDheckQgZhyiRMLVmt9k1reetMMTTZ7NKBSYv037N
         KMsFZFgIzb6LnMuHJSX1Tat68GEpRTaVY1sa7ZLXTVjyNx3HxDfHuHF+GvgUlsSQCpic
         mVEw==
X-Gm-Message-State: AOAM530QIofbP6HIdO6k083cC+6tr3G5Bo9SqYaiKmDIrzjwu+xrxrcW
        K6Rk1ZnFAJXOTzR7XBSoQ+De37c48Q4sshB7odA=
X-Google-Smtp-Source: ABdhPJwE7gMJRoxjlbPOYeuH7YDI2uub/y9IkRu+TH8hsn07T4a0fPk0OedbmMhXemKwTIJ1VoweMwduCA2nzznnjGo=
X-Received: by 2002:a6b:4f09:: with SMTP id d9mr23469890iob.60.1617090475772;
 Tue, 30 Mar 2021 00:47:55 -0700 (PDT)
MIME-Version: 1.0
References: <1617071338-9436-1-git-send-email-dillon.minfei@gmail.com>
 <1617071338-9436-4-git-send-email-dillon.minfei@gmail.com> <1c01b4d9-49e0-77e4-ba37-bcfea0438225@foss.st.com>
In-Reply-To: <1c01b4d9-49e0-77e4-ba37-bcfea0438225@foss.st.com>
From:   dillon min <dillon.minfei@gmail.com>
Date:   Tue, 30 Mar 2021 15:47:19 +0800
Message-ID: <CAL9mu0LSYuFmZ-Ju9Xd-CcXx9kfHjNEDpgGTuB1p09e028eXmA@mail.gmail.com>
Subject: Re: [PATCH v7 3/6] ARM: dts: stm32: introduce stm32h7-pinctrl.dtsi to
 support stm32h750
To:     Alexandre TORGUE <alexandre.torgue@foss.st.com>
Cc:     Rob Herring <robh@kernel.org>,
        Valentin CARON - foss <valentin.caron@foss.st.com>,
        rong.a.chen@intel.com, Ahmad Fatoum <a.fatoum@pengutronix.de>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-stm32@st-md-mailman.stormreply.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux@armlinux.org.uk, afzal.mohd.ma@gmail.com,
        gregkh@linuxfoundation.org,
        Erwan LE-RAY - foss <erwan.leray@foss.st.com>,
        Erwan LE RAY <erwan.leray@st.com>,
        linux-serial@vger.kernel.org, lkp@intel.com,
        Patrice CHOTARD <patrice.chotard@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi Alexandre,

Thanks for the quick response.

On Tue, Mar 30, 2021 at 3:22 PM Alexandre TORGUE
<alexandre.torgue@foss.st.com> wrote:
>
> Hi Dillon
>
> On 3/30/21 4:28 AM, dillon.minfei@gmail.com wrote:
> > From: dillon min <dillon.minfei@gmail.com>
> >
> > This patch is intend to add support stm32h750 value line,
> > just add stm32h7-pinctrl.dtsi for extending, with following changes:
> >
> > - rename stm32h743-pinctrl.dtsi to stm32h7-pinctrl.dtsi
> > - move compatible string "st,stm32h743-pinctrl" from stm32h7-pinctrl.dtsi
> >    to stm32h743-pinctrl.dtsi
> > - move 'pin-controller' from stm32h7-pinctrl.dtsi to stm32h743.dtsi, to
> >    fix make dtbs_check warrnings
> >    arch/arm/boot/dts/stm32h750i-art-pi.dt.yaml: soc: 'i2c@40005C00',
> >    'i2c@58001C00' do not match any of the regexes:
> >    '@(0|[1-9a-f][0-9a-f]*)$', '^[^@]+$', 'pinctrl-[0-9]+'
> >
>
> You are not so far but sorry I still have a remark:
>
> The pin-controller move in stm32h743.dtsi should be done in this patch.
> For the moment you don't need to create a dedicate file to only define
> the compatible string in stm32h743-pinctrl.dtsi. Just add it in
> stm32h743.dtsi. I'm ok to rename stm32h743-pinctrl.dtsi by
> stm32h7-pinctrl, and at the end remove stm32h743-pinctrl.dtsi, so don't
> forget to change the include file for stm32h743 disco and eval dts file.
>
> Regards
> Alex
>
Okay, i will do it right away. thanks.
>
> > Signed-off-by: dillon min <dillon.minfei@gmail.com>
> > ---
> > v7: no changes
> >
> >   arch/arm/boot/dts/stm32h7-pinctrl.dtsi   | 341 +++++++++++++++++++++++++++++++
> >   arch/arm/boot/dts/stm32h743-pinctrl.dtsi | 307 +---------------------------
> >   2 files changed, 347 insertions(+), 301 deletions(-)
> >   create mode 100644 arch/arm/boot/dts/stm32h7-pinctrl.dtsi
> >
> > diff --git a/arch/arm/boot/dts/stm32h7-pinctrl.dtsi b/arch/arm/boot/dts/stm32h7-pinctrl.dtsi
> > new file mode 100644
> > index 000000000000..a5c295eca081
> > --- /dev/null
> > +++ b/arch/arm/boot/dts/stm32h7-pinctrl.dtsi
> > @@ -0,0 +1,341 @@
> > +/*
> > + * Copyright 2017 - Alexandre Torgue <alexandre.torgue@st.com>
> > + *
> > + * This file is dual-licensed: you can use it either under the terms
> > + * of the GPL or the X11 license, at your option. Note that this dual
> > + * licensing only applies to this file, and not this project as a
> > + * whole.
> > + *
> > + *  a) This file is free software; you can redistribute it and/or
> > + *     modify it under the terms of the GNU General Public License as
> > + *     published by the Free Software Foundation; either version 2 of the
> > + *     License, or (at your option) any later version.
> > + *
> > + *     This file is distributed in the hope that it will be useful,
> > + *     but WITHOUT ANY WARRANTY; without even the implied warranty of
> > + *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > + *     GNU General Public License for more details.
> > + *
> > + * Or, alternatively,
> > + *
> > + *  b) Permission is hereby granted, free of charge, to any person
> > + *     obtaining a copy of this software and associated documentation
> > + *     files (the "Software"), to deal in the Software without
> > + *     restriction, including without limitation the rights to use,
> > + *     copy, modify, merge, publish, distribute, sublicense, and/or
> > + *     sell copies of the Software, and to permit persons to whom the
> > + *     Software is furnished to do so, subject to the following
> > + *     conditions:
> > + *
> > + *     The above copyright notice and this permission notice shall be
> > + *     included in all copies or substantial portions of the Software.
> > + *
> > + *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
> > + *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
> > + *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
> > + *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
> > + *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
> > + *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
> > + *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> > + *     OTHER DEALINGS IN THE SOFTWARE.
> > + */
> > +
> > +#include <dt-bindings/pinctrl/stm32-pinfunc.h>
> > +
> > +&pinctrl {
> > +
> > +     gpioa: gpio@58020000 {
> > +             status = "okay";
> > +             ngpios = <16>;
> > +             gpio-ranges = <&pinctrl 0 0 16>;
> > +     };
> > +
> > +     gpiob: gpio@58020400 {
> > +             status = "okay";
> > +             ngpios = <16>;
> > +             gpio-ranges = <&pinctrl 0 16 16>;
> > +     };
> > +
> > +     gpioc: gpio@58020800 {
> > +             status = "okay";
> > +             ngpios = <16>;
> > +             gpio-ranges = <&pinctrl 0 32 16>;
> > +     };
> > +
> > +     gpiod: gpio@58020c00 {
> > +             status = "okay";
> > +             ngpios = <16>;
> > +             gpio-ranges = <&pinctrl 0 48 16>;
> > +     };
> > +
> > +     gpioe: gpio@58021000 {
> > +             status = "okay";
> > +             ngpios = <16>;
> > +             gpio-ranges = <&pinctrl 0 64 16>;
> > +     };
> > +
> > +     gpiof: gpio@58021400 {
> > +             status = "okay";
> > +             ngpios = <16>;
> > +             gpio-ranges = <&pinctrl 0 80 16>;
> > +     };
> > +
> > +     gpiog: gpio@58021800 {
> > +             status = "okay";
> > +             ngpios = <16>;
> > +             gpio-ranges = <&pinctrl 0 96 16>;
> > +     };
> > +
> > +     gpioh: gpio@58021c00 {
> > +             status = "okay";
> > +             ngpios = <16>;
> > +             gpio-ranges = <&pinctrl 0 112 16>;
> > +     };
> > +
> > +     gpioi: gpio@58022000 {
> > +             status = "okay";
> > +             ngpios = <16>;
> > +             gpio-ranges = <&pinctrl 0 128 16>;
> > +     };
> > +
> > +     gpioj: gpio@58022400 {
> > +             status = "okay";
> > +             ngpios = <16>;
> > +             gpio-ranges = <&pinctrl 0 144 16>;
> > +     };
> > +
> > +     gpiok: gpio@58022800 {
> > +             status = "okay";
> > +             ngpios = <8>;
> > +             gpio-ranges = <&pinctrl 0 160 8>;
> > +     };
> > +
> > +     i2c1_pins_a: i2c1-0 {
> > +             pins {
> > +                     pinmux = <STM32_PINMUX('B', 6, AF4)>, /* I2C1_SCL */
> > +                              <STM32_PINMUX('B', 7, AF4)>; /* I2C1_SDA */
> > +                     bias-disable;
> > +                     drive-open-drain;
> > +                     slew-rate = <0>;
> > +             };
> > +     };
> > +
> > +     ethernet_rmii: rmii-0 {
> > +             pins {
> > +                     pinmux = <STM32_PINMUX('G', 11, AF11)>,
> > +                              <STM32_PINMUX('G', 13, AF11)>,
> > +                              <STM32_PINMUX('G', 12, AF11)>,
> > +                              <STM32_PINMUX('C', 4, AF11)>,
> > +                              <STM32_PINMUX('C', 5, AF11)>,
> > +                              <STM32_PINMUX('A', 7, AF11)>,
> > +                              <STM32_PINMUX('C', 1, AF11)>,
> > +                              <STM32_PINMUX('A', 2, AF11)>,
> > +                              <STM32_PINMUX('A', 1, AF11)>;
> > +                     slew-rate = <2>;
> > +             };
> > +     };
> > +
> > +     sdmmc1_b4_pins_a: sdmmc1-b4-0 {
> > +             pins {
> > +                     pinmux = <STM32_PINMUX('C', 8, AF12)>, /* SDMMC1_D0 */
> > +                              <STM32_PINMUX('C', 9, AF12)>, /* SDMMC1_D1 */
> > +                              <STM32_PINMUX('C', 10, AF12)>, /* SDMMC1_D2 */
> > +                              <STM32_PINMUX('C', 11, AF12)>, /* SDMMC1_D3 */
> > +                              <STM32_PINMUX('C', 12, AF12)>, /* SDMMC1_CK */
> > +                              <STM32_PINMUX('D', 2, AF12)>; /* SDMMC1_CMD */
> > +                     slew-rate = <3>;
> > +                     drive-push-pull;
> > +                     bias-disable;
> > +             };
> > +     };
> > +
> > +     sdmmc1_b4_od_pins_a: sdmmc1-b4-od-0 {
> > +             pins1 {
> > +                     pinmux = <STM32_PINMUX('C', 8, AF12)>, /* SDMMC1_D0 */
> > +                              <STM32_PINMUX('C', 9, AF12)>, /* SDMMC1_D1 */
> > +                              <STM32_PINMUX('C', 10, AF12)>, /* SDMMC1_D2 */
> > +                              <STM32_PINMUX('C', 11, AF12)>, /* SDMMC1_D3 */
> > +                              <STM32_PINMUX('C', 12, AF12)>; /* SDMMC1_CK */
> > +                     slew-rate = <3>;
> > +                     drive-push-pull;
> > +                     bias-disable;
> > +             };
> > +             pins2{
> > +                     pinmux = <STM32_PINMUX('D', 2, AF12)>; /* SDMMC1_CMD */
> > +                     slew-rate = <3>;
> > +                     drive-open-drain;
> > +                     bias-disable;
> > +             };
> > +     };
> > +
> > +     sdmmc1_b4_sleep_pins_a: sdmmc1-b4-sleep-0 {
> > +             pins {
> > +                     pinmux = <STM32_PINMUX('C', 8, ANALOG)>, /* SDMMC1_D0 */
> > +                              <STM32_PINMUX('C', 9, ANALOG)>, /* SDMMC1_D1 */
> > +                              <STM32_PINMUX('C', 10, ANALOG)>, /* SDMMC1_D2 */
> > +                              <STM32_PINMUX('C', 11, ANALOG)>, /* SDMMC1_D3 */
> > +                              <STM32_PINMUX('C', 12, ANALOG)>, /* SDMMC1_CK */
> > +                              <STM32_PINMUX('D', 2, ANALOG)>; /* SDMMC1_CMD */
> > +             };
> > +     };
> > +
> > +     sdmmc2_b4_pins_a: sdmmc2-b4-0 {
> > +             pins {
> > +                     pinmux = <STM32_PINMUX('B', 14, AF9)>, /* SDMMC1_D0 */
> > +                              <STM32_PINMUX('B', 15, AF9)>, /* SDMMC1_D1 */
> > +                              <STM32_PINMUX('B', 3, AF9)>, /* SDMMC1_D2 */
> > +                              <STM32_PINMUX('B', 4, AF9)>, /* SDMMC1_D3 */
> > +                              <STM32_PINMUX('D', 6, AF11)>, /* SDMMC1_CK */
> > +                              <STM32_PINMUX('D', 7, AF11)>; /* SDMMC1_CMD */
> > +                     slew-rate = <3>;
> > +                     drive-push-pull;
> > +                     bias-disable;
> > +             };
> > +     };
> > +
> > +     sdmmc2_b4_od_pins_a: sdmmc2-b4-od-0 {
> > +             pins1 {
> > +                     pinmux = <STM32_PINMUX('B', 14, AF9)>, /* SDMMC2_D0 */
> > +                              <STM32_PINMUX('B', 15, AF9)>, /* SDMMC1_D1 */
> > +                              <STM32_PINMUX('B', 3, AF9)>, /* SDMMC1_D2 */
> > +                              <STM32_PINMUX('B', 4, AF9)>, /* SDMMC1_D3 */
> > +                              <STM32_PINMUX('D', 6, AF11)>; /* SDMMC1_CK */
> > +                     slew-rate = <3>;
> > +                     drive-push-pull;
> > +                     bias-disable;
> > +             };
> > +             pins2{
> > +                     pinmux = <STM32_PINMUX('D', 7, AF11)>; /* SDMMC1_CMD */
> > +                     slew-rate = <3>;
> > +                     drive-open-drain;
> > +                     bias-disable;
> > +             };
> > +     };
> > +
> > +     sdmmc2_b4_sleep_pins_a: sdmmc2-b4-sleep-0 {
> > +             pins {
> > +                     pinmux = <STM32_PINMUX('B', 14, ANALOG)>, /* SDMMC1_D0 */
> > +                              <STM32_PINMUX('B', 15, ANALOG)>, /* SDMMC1_D1 */
> > +                              <STM32_PINMUX('B', 3, ANALOG)>, /* SDMMC1_D2 */
> > +                              <STM32_PINMUX('B', 4, ANALOG)>, /* SDMMC1_D3 */
> > +                              <STM32_PINMUX('D', 6, ANALOG)>, /* SDMMC1_CK */
> > +                              <STM32_PINMUX('D', 7, ANALOG)>; /* SDMMC1_CMD */
> > +             };
> > +     };
> > +
> > +     sdmmc1_dir_pins_a: sdmmc1-dir-0 {
> > +             pins1 {
> > +                     pinmux = <STM32_PINMUX('C', 6, AF8)>, /* SDMMC1_D0DIR */
> > +                              <STM32_PINMUX('C', 7, AF8)>, /* SDMMC1_D123DIR */
> > +                              <STM32_PINMUX('B', 9, AF7)>; /* SDMMC1_CDIR */
> > +                     slew-rate = <3>;
> > +                     drive-push-pull;
> > +                     bias-pull-up;
> > +             };
> > +             pins2{
> > +                     pinmux = <STM32_PINMUX('B', 8, AF7)>; /* SDMMC1_CKIN */
> > +                     bias-pull-up;
> > +             };
> > +     };
> > +
> > +     sdmmc1_dir_sleep_pins_a: sdmmc1-dir-sleep-0 {
> > +             pins {
> > +                     pinmux = <STM32_PINMUX('C', 6, ANALOG)>, /* SDMMC1_D0DIR */
> > +                              <STM32_PINMUX('C', 7, ANALOG)>, /* SDMMC1_D123DIR */
> > +                              <STM32_PINMUX('B', 9, ANALOG)>, /* SDMMC1_CDIR */
> > +                              <STM32_PINMUX('B', 8, ANALOG)>; /* SDMMC1_CKIN */
> > +             };
> > +     };
> > +
> > +     usart1_pins: usart1-0 {
> > +             pins1 {
> > +                     pinmux = <STM32_PINMUX('B', 14, AF4)>; /* USART1_TX */
> > +                     bias-disable;
> > +                     drive-push-pull;
> > +                     slew-rate = <0>;
> > +             };
> > +             pins2 {
> > +                     pinmux = <STM32_PINMUX('B', 15, AF4)>; /* USART1_RX */
> > +                     bias-disable;
> > +             };
> > +     };
> > +
> > +     usart2_pins: usart2-0 {
> > +             pins1 {
> > +                     pinmux = <STM32_PINMUX('D', 5, AF7)>; /* USART2_TX */
> > +                     bias-disable;
> > +                     drive-push-pull;
> > +                     slew-rate = <0>;
> > +             };
> > +             pins2 {
> > +                     pinmux = <STM32_PINMUX('D', 6, AF7)>; /* USART2_RX */
> > +                     bias-disable;
> > +             };
> > +     };
> > +
> > +     usart3_pins: usart3-0 {
> > +             pins1 {
> > +                     pinmux = <STM32_PINMUX('B', 10, AF7)>, /* USART3_TX */
> > +                              <STM32_PINMUX('D', 12, AF7)>; /* USART3_RTS_DE */
> > +                     bias-disable;
> > +                     drive-push-pull;
> > +                     slew-rate = <0>;
> > +             };
> > +             pins2 {
> > +                     pinmux = <STM32_PINMUX('B', 11, AF7)>, /* USART3_RX */
> > +                              <STM32_PINMUX('D', 11, AF7)>; /* USART3_CTS_NSS */
> > +                     bias-disable;
> > +             };
> > +     };
> > +
> > +     uart4_pins: uart4-0 {
> > +             pins1 {
> > +                     pinmux = <STM32_PINMUX('A', 0, AF8)>; /* UART4_TX */
> > +                     bias-disable;
> > +                     drive-push-pull;
> > +                     slew-rate = <0>;
> > +             };
> > +             pins2 {
> > +                     pinmux = <STM32_PINMUX('I', 9, AF8)>; /* UART4_RX */
> > +                     bias-disable;
> > +             };
> > +     };
> > +
> > +     usbotg_hs_pins_a: usbotg-hs-0 {
> > +             pins {
> > +                     pinmux = <STM32_PINMUX('H', 4, AF10)>,  /* ULPI_NXT */
> > +                                      <STM32_PINMUX('I', 11, AF10)>, /* ULPI_DIR> */
> > +                                      <STM32_PINMUX('C', 0, AF10)>,  /* ULPI_STP> */
> > +                                      <STM32_PINMUX('A', 5, AF10)>,  /* ULPI_CK> */
> > +                                      <STM32_PINMUX('A', 3, AF10)>,  /* ULPI_D0> */
> > +                                      <STM32_PINMUX('B', 0, AF10)>,  /* ULPI_D1> */
> > +                                      <STM32_PINMUX('B', 1, AF10)>,  /* ULPI_D2> */
> > +                                      <STM32_PINMUX('B', 10, AF10)>, /* ULPI_D3> */
> > +                                      <STM32_PINMUX('B', 11, AF10)>, /* ULPI_D4> */
> > +                                      <STM32_PINMUX('B', 12, AF10)>, /* ULPI_D5> */
> > +                                      <STM32_PINMUX('B', 13, AF10)>, /* ULPI_D6> */
> > +                                      <STM32_PINMUX('B', 5, AF10)>;  /* ULPI_D7> */
> > +                     bias-disable;
> > +                     drive-push-pull;
> > +                     slew-rate = <2>;
> > +             };
> > +     };
> > +
> > +     spi1_pins: spi1-0 {
> > +             pins1 {
> > +                     pinmux = <STM32_PINMUX('A', 5, AF5)>,
> > +                             /* SPI1_CLK */
> > +                              <STM32_PINMUX('B', 5, AF5)>;
> > +                             /* SPI1_MOSI */
> > +                     bias-disable;
> > +                     drive-push-pull;
> > +                     slew-rate = <2>;
> > +             };
> > +             pins2 {
> > +                     pinmux = <STM32_PINMUX('G', 9, AF5)>;
> > +                             /* SPI1_MISO */
> > +                     bias-disable;
> > +             };
> > +     };
> > +};
> > +
> > diff --git a/arch/arm/boot/dts/stm32h743-pinctrl.dtsi b/arch/arm/boot/dts/stm32h743-pinctrl.dtsi
> > index fa5dcb6a5fdd..6b1e115307b9 100644
> > --- a/arch/arm/boot/dts/stm32h743-pinctrl.dtsi
> > +++ b/arch/arm/boot/dts/stm32h743-pinctrl.dtsi
> > @@ -1,306 +1,11 @@
> > +// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
> >   /*
> > - * Copyright 2017 - Alexandre Torgue <alexandre.torgue@st.com>
> > - *
> > - * This file is dual-licensed: you can use it either under the terms
> > - * of the GPL or the X11 license, at your option. Note that this dual
> > - * licensing only applies to this file, and not this project as a
> > - * whole.
> > - *
> > - *  a) This file is free software; you can redistribute it and/or
> > - *     modify it under the terms of the GNU General Public License as
> > - *     published by the Free Software Foundation; either version 2 of the
> > - *     License, or (at your option) any later version.
> > - *
> > - *     This file is distributed in the hope that it will be useful,
> > - *     but WITHOUT ANY WARRANTY; without even the implied warranty of
> > - *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > - *     GNU General Public License for more details.
> > - *
> > - * Or, alternatively,
> > - *
> > - *  b) Permission is hereby granted, free of charge, to any person
> > - *     obtaining a copy of this software and associated documentation
> > - *     files (the "Software"), to deal in the Software without
> > - *     restriction, including without limitation the rights to use,
> > - *     copy, modify, merge, publish, distribute, sublicense, and/or
> > - *     sell copies of the Software, and to permit persons to whom the
> > - *     Software is furnished to do so, subject to the following
> > - *     conditions:
> > - *
> > - *     The above copyright notice and this permission notice shall be
> > - *     included in all copies or substantial portions of the Software.
> > - *
> > - *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
> > - *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
> > - *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
> > - *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
> > - *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
> > - *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
> > - *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> > - *     OTHER DEALINGS IN THE SOFTWARE.
> > + * Copyright (C) STMicroelectronics 2017 - All Rights Reserved
> > + * Author: Alexandre Torgue  <alexandre.torgue@st.com> for STMicroelectronics.
> >    */
> >
> > -#include <dt-bindings/pinctrl/stm32-pinfunc.h>
> > +#include "stm32h7-pinctrl.dtsi"
> >
> > -/ {
> > -     soc {
> > -             pin-controller {
> > -                     #address-cells = <1>;
> > -                     #size-cells = <1>;
> > -                     compatible = "st,stm32h743-pinctrl";
> > -                     ranges = <0 0x58020000 0x3000>;
> > -                     interrupt-parent = <&exti>;
> > -                     st,syscfg = <&syscfg 0x8>;
> > -                     pins-are-numbered;
> > -
> > -                     gpioa: gpio@58020000 {
> > -                             gpio-controller;
> > -                             #gpio-cells = <2>;
> > -                             reg = <0x0 0x400>;
> > -                             clocks = <&rcc GPIOA_CK>;
> > -                             st,bank-name = "GPIOA";
> > -                             interrupt-controller;
> > -                             #interrupt-cells = <2>;
> > -                     };
> > -
> > -                     gpiob: gpio@58020400 {
> > -                             gpio-controller;
> > -                             #gpio-cells = <2>;
> > -                             reg = <0x400 0x400>;
> > -                             clocks = <&rcc GPIOB_CK>;
> > -                             st,bank-name = "GPIOB";
> > -                             interrupt-controller;
> > -                             #interrupt-cells = <2>;
> > -                     };
> > -
> > -                     gpioc: gpio@58020800 {
> > -                             gpio-controller;
> > -                             #gpio-cells = <2>;
> > -                             reg = <0x800 0x400>;
> > -                             clocks = <&rcc GPIOC_CK>;
> > -                             st,bank-name = "GPIOC";
> > -                             interrupt-controller;
> > -                             #interrupt-cells = <2>;
> > -                     };
> > -
> > -                     gpiod: gpio@58020c00 {
> > -                             gpio-controller;
> > -                             #gpio-cells = <2>;
> > -                             reg = <0xc00 0x400>;
> > -                             clocks = <&rcc GPIOD_CK>;
> > -                             st,bank-name = "GPIOD";
> > -                             interrupt-controller;
> > -                             #interrupt-cells = <2>;
> > -                     };
> > -
> > -                     gpioe: gpio@58021000 {
> > -                             gpio-controller;
> > -                             #gpio-cells = <2>;
> > -                             reg = <0x1000 0x400>;
> > -                             clocks = <&rcc GPIOE_CK>;
> > -                             st,bank-name = "GPIOE";
> > -                             interrupt-controller;
> > -                             #interrupt-cells = <2>;
> > -                     };
> > -
> > -                     gpiof: gpio@58021400 {
> > -                             gpio-controller;
> > -                             #gpio-cells = <2>;
> > -                             reg = <0x1400 0x400>;
> > -                             clocks = <&rcc GPIOF_CK>;
> > -                             st,bank-name = "GPIOF";
> > -                             interrupt-controller;
> > -                             #interrupt-cells = <2>;
> > -                     };
> > -
> > -                     gpiog: gpio@58021800 {
> > -                             gpio-controller;
> > -                             #gpio-cells = <2>;
> > -                             reg = <0x1800 0x400>;
> > -                             clocks = <&rcc GPIOG_CK>;
> > -                             st,bank-name = "GPIOG";
> > -                             interrupt-controller;
> > -                             #interrupt-cells = <2>;
> > -                     };
> > -
> > -                     gpioh: gpio@58021c00 {
> > -                             gpio-controller;
> > -                             #gpio-cells = <2>;
> > -                             reg = <0x1c00 0x400>;
> > -                             clocks = <&rcc GPIOH_CK>;
> > -                             st,bank-name = "GPIOH";
> > -                             interrupt-controller;
> > -                             #interrupt-cells = <2>;
> > -                     };
> > -
> > -                     gpioi: gpio@58022000 {
> > -                             gpio-controller;
> > -                             #gpio-cells = <2>;
> > -                             reg = <0x2000 0x400>;
> > -                             clocks = <&rcc GPIOI_CK>;
> > -                             st,bank-name = "GPIOI";
> > -                             interrupt-controller;
> > -                             #interrupt-cells = <2>;
> > -                     };
> > -
> > -                     gpioj: gpio@58022400 {
> > -                             gpio-controller;
> > -                             #gpio-cells = <2>;
> > -                             reg = <0x2400 0x400>;
> > -                             clocks = <&rcc GPIOJ_CK>;
> > -                             st,bank-name = "GPIOJ";
> > -                             interrupt-controller;
> > -                             #interrupt-cells = <2>;
> > -                     };
> > -
> > -                     gpiok: gpio@58022800 {
> > -                             gpio-controller;
> > -                             #gpio-cells = <2>;
> > -                             reg = <0x2800 0x400>;
> > -                             clocks = <&rcc GPIOK_CK>;
> > -                             st,bank-name = "GPIOK";
> > -                             interrupt-controller;
> > -                             #interrupt-cells = <2>;
> > -                     };
> > -
> > -                     i2c1_pins_a: i2c1-0 {
> > -                             pins {
> > -                                     pinmux = <STM32_PINMUX('B', 6, AF4)>, /* I2C1_SCL */
> > -                                              <STM32_PINMUX('B', 7, AF4)>; /* I2C1_SDA */
> > -                                     bias-disable;
> > -                                     drive-open-drain;
> > -                                     slew-rate = <0>;
> > -                             };
> > -                     };
> > -
> > -                     ethernet_rmii: rmii-0 {
> > -                             pins {
> > -                                     pinmux = <STM32_PINMUX('G', 11, AF11)>,
> > -                                              <STM32_PINMUX('G', 13, AF11)>,
> > -                                              <STM32_PINMUX('G', 12, AF11)>,
> > -                                              <STM32_PINMUX('C', 4, AF11)>,
> > -                                              <STM32_PINMUX('C', 5, AF11)>,
> > -                                              <STM32_PINMUX('A', 7, AF11)>,
> > -                                              <STM32_PINMUX('C', 1, AF11)>,
> > -                                              <STM32_PINMUX('A', 2, AF11)>,
> > -                                              <STM32_PINMUX('A', 1, AF11)>;
> > -                                     slew-rate = <2>;
> > -                             };
> > -                     };
> > -
> > -                     sdmmc1_b4_pins_a: sdmmc1-b4-0 {
> > -                             pins {
> > -                                     pinmux = <STM32_PINMUX('C', 8, AF12)>, /* SDMMC1_D0 */
> > -                                              <STM32_PINMUX('C', 9, AF12)>, /* SDMMC1_D1 */
> > -                                              <STM32_PINMUX('C', 10, AF12)>, /* SDMMC1_D2 */
> > -                                              <STM32_PINMUX('C', 11, AF12)>, /* SDMMC1_D3 */
> > -                                              <STM32_PINMUX('C', 12, AF12)>, /* SDMMC1_CK */
> > -                                              <STM32_PINMUX('D', 2, AF12)>; /* SDMMC1_CMD */
> > -                                     slew-rate = <3>;
> > -                                     drive-push-pull;
> > -                                     bias-disable;
> > -                             };
> > -                     };
> > -
> > -                     sdmmc1_b4_od_pins_a: sdmmc1-b4-od-0 {
> > -                             pins1 {
> > -                                     pinmux = <STM32_PINMUX('C', 8, AF12)>, /* SDMMC1_D0 */
> > -                                              <STM32_PINMUX('C', 9, AF12)>, /* SDMMC1_D1 */
> > -                                              <STM32_PINMUX('C', 10, AF12)>, /* SDMMC1_D2 */
> > -                                              <STM32_PINMUX('C', 11, AF12)>, /* SDMMC1_D3 */
> > -                                              <STM32_PINMUX('C', 12, AF12)>; /* SDMMC1_CK */
> > -                                     slew-rate = <3>;
> > -                                     drive-push-pull;
> > -                                     bias-disable;
> > -                             };
> > -                             pins2{
> > -                                     pinmux = <STM32_PINMUX('D', 2, AF12)>; /* SDMMC1_CMD */
> > -                                     slew-rate = <3>;
> > -                                     drive-open-drain;
> > -                                     bias-disable;
> > -                             };
> > -                     };
> > -
> > -                     sdmmc1_b4_sleep_pins_a: sdmmc1-b4-sleep-0 {
> > -                             pins {
> > -                                     pinmux = <STM32_PINMUX('C', 8, ANALOG)>, /* SDMMC1_D0 */
> > -                                              <STM32_PINMUX('C', 9, ANALOG)>, /* SDMMC1_D1 */
> > -                                              <STM32_PINMUX('C', 10, ANALOG)>, /* SDMMC1_D2 */
> > -                                              <STM32_PINMUX('C', 11, ANALOG)>, /* SDMMC1_D3 */
> > -                                              <STM32_PINMUX('C', 12, ANALOG)>, /* SDMMC1_CK */
> > -                                              <STM32_PINMUX('D', 2, ANALOG)>; /* SDMMC1_CMD */
> > -                             };
> > -                     };
> > -
> > -                     sdmmc1_dir_pins_a: sdmmc1-dir-0 {
> > -                             pins1 {
> > -                                     pinmux = <STM32_PINMUX('C', 6, AF8)>, /* SDMMC1_D0DIR */
> > -                                              <STM32_PINMUX('C', 7, AF8)>, /* SDMMC1_D123DIR */
> > -                                              <STM32_PINMUX('B', 9, AF7)>; /* SDMMC1_CDIR */
> > -                                     slew-rate = <3>;
> > -                                     drive-push-pull;
> > -                                     bias-pull-up;
> > -                             };
> > -                             pins2{
> > -                                     pinmux = <STM32_PINMUX('B', 8, AF7)>; /* SDMMC1_CKIN */
> > -                                     bias-pull-up;
> > -                             };
> > -                     };
> > -
> > -                     sdmmc1_dir_sleep_pins_a: sdmmc1-dir-sleep-0 {
> > -                             pins {
> > -                                     pinmux = <STM32_PINMUX('C', 6, ANALOG)>, /* SDMMC1_D0DIR */
> > -                                              <STM32_PINMUX('C', 7, ANALOG)>, /* SDMMC1_D123DIR */
> > -                                              <STM32_PINMUX('B', 9, ANALOG)>, /* SDMMC1_CDIR */
> > -                                              <STM32_PINMUX('B', 8, ANALOG)>; /* SDMMC1_CKIN */
> > -                             };
> > -                     };
> > -
> > -                     usart1_pins: usart1-0 {
> > -                             pins1 {
> > -                                     pinmux = <STM32_PINMUX('B', 14, AF4)>; /* USART1_TX */
> > -                                     bias-disable;
> > -                                     drive-push-pull;
> > -                                     slew-rate = <0>;
> > -                             };
> > -                             pins2 {
> > -                                     pinmux = <STM32_PINMUX('B', 15, AF4)>; /* USART1_RX */
> > -                                     bias-disable;
> > -                             };
> > -                     };
> > -
> > -                     usart2_pins: usart2-0 {
> > -                             pins1 {
> > -                                     pinmux = <STM32_PINMUX('D', 5, AF7)>; /* USART2_TX */
> > -                                     bias-disable;
> > -                                     drive-push-pull;
> > -                                     slew-rate = <0>;
> > -                             };
> > -                             pins2 {
> > -                                     pinmux = <STM32_PINMUX('D', 6, AF7)>; /* USART2_RX */
> > -                                     bias-disable;
> > -                             };
> > -                     };
> > -
> > -                     usbotg_hs_pins_a: usbotg-hs-0 {
> > -                             pins {
> > -                                     pinmux = <STM32_PINMUX('H', 4, AF10)>,  /* ULPI_NXT */
> > -                                                      <STM32_PINMUX('I', 11, AF10)>, /* ULPI_DIR> */
> > -                                                      <STM32_PINMUX('C', 0, AF10)>,  /* ULPI_STP> */
> > -                                                      <STM32_PINMUX('A', 5, AF10)>,  /* ULPI_CK> */
> > -                                                      <STM32_PINMUX('A', 3, AF10)>,  /* ULPI_D0> */
> > -                                                      <STM32_PINMUX('B', 0, AF10)>,  /* ULPI_D1> */
> > -                                                      <STM32_PINMUX('B', 1, AF10)>,  /* ULPI_D2> */
> > -                                                      <STM32_PINMUX('B', 10, AF10)>, /* ULPI_D3> */
> > -                                                      <STM32_PINMUX('B', 11, AF10)>, /* ULPI_D4> */
> > -                                                      <STM32_PINMUX('B', 12, AF10)>, /* ULPI_D5> */
> > -                                                      <STM32_PINMUX('B', 13, AF10)>, /* ULPI_D6> */
> > -                                                      <STM32_PINMUX('B', 5, AF10)>;  /* ULPI_D7> */
> > -                                     bias-disable;
> > -                                     drive-push-pull;
> > -                                     slew-rate = <2>;
> > -                             };
> > -                     };
> > -             };
> > -     };
> > +&pinctrl{
> > +     compatible = "st,stm32h743-pinctrl";
> >   };
> >

Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8A8CC433EF
	for <linux-serial@archiver.kernel.org>; Fri, 14 Jan 2022 03:08:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239008AbiANDIp (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 13 Jan 2022 22:08:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236150AbiANDIp (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 13 Jan 2022 22:08:45 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB7EAC061574
        for <linux-serial@vger.kernel.org>; Thu, 13 Jan 2022 19:08:44 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id 128so1599005pfe.12
        for <linux-serial@vger.kernel.org>; Thu, 13 Jan 2022 19:08:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gateworks-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=21Rw/TTKwpInxIwzyQk5JmQh4CTbMileT6RYjsfwpF4=;
        b=K2UWRSU2iKhI7/ZP4sL2phNj9duWgF0YMbd2sNzc+easPqGFTOLmu/2C3WglKUwAIW
         esbK13ANNxAfrxDsusTXlBiOehOCK3ruhqWitTusuPpmKanoSalbfMeVcvy7dSFP7dmY
         NMbA8uaH249HGj7sq9RzIVmgyD4m3TQOuPzT+T2TCH1MRIKp5unhKVCxeBJJhgNmtc6X
         ujoDTs1S9TLBfQ4/B7ASGTfDXJnSYCG5SBXp+E4m9hpB1y05b+uqQASf2+JWIXgOJuMd
         VWMBBH/t0Jjv87Bmhlb/+CeFwM75iJpRDvIXgDEYV9p9q/SuM4RobAneJV8jcBThUWBT
         vHIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=21Rw/TTKwpInxIwzyQk5JmQh4CTbMileT6RYjsfwpF4=;
        b=Bo3jsiYlxym9o28if7CBOu3dwp4dmRuwEgOqHcyZYmZR7te8fIEtTG1tfAjotNK/jC
         5g6+X53U90OLePqqcmZ9CehNLNGY3xAtRSBPsTdEWQu1gVhcei0YO8Y1UBEFuj2imYJw
         l00JCyE3RHOlh3jElBtSYJl1lSCM3nkUOo11uYGIH0o6hZIJJDx2L3Lqat6OCAzLEvut
         gLfmw3zsp783iLcAO618A5AH27FWhQQ3obdiVLd9gSnw6lDLBmHPKA8Hh7nLuunFRviY
         Osdi9pzk/TBXZCGyPCHw05n1FyBrH2ztXujAhjBJJd2CZWEum9vPu6IvXwadA06gZJ79
         lRqQ==
X-Gm-Message-State: AOAM533UeHQi0KloztOdPJDJXPTSLRhmyf7CmB6y+YhBLhS6kJ1vZHCY
        4iqJiTB/jMGoFVg/otr/vgX8t1BhGpArx94psMNX74pkWl4=
X-Google-Smtp-Source: ABdhPJxmimoROGeokGcLHFWKNxrcb/8C5ojyF09MUhE3F4tpZCi2opyRYxvblnEY5/KJx2bZ3jyRv6/KmwRdJ6SBGHk=
X-Received: by 2002:a62:ed06:0:b0:4bb:1152:2fbd with SMTP id
 u6-20020a62ed06000000b004bb11522fbdmr7070721pfh.34.1642129723330; Thu, 13 Jan
 2022 19:08:43 -0800 (PST)
MIME-Version: 1.0
References: <CAJ+vNU0CrD8091W5zH7ve9v3ZVAGXR6=6DGebd5LhHz4mzt4+w@mail.gmail.com>
In-Reply-To: <CAJ+vNU0CrD8091W5zH7ve9v3ZVAGXR6=6DGebd5LhHz4mzt4+w@mail.gmail.com>
From:   Tim Harvey <tharvey@gateworks.com>
Date:   Thu, 13 Jan 2022 19:08:29 -0800
Message-ID: <CAJ+vNU1tJ5W5RCUsPehgH7CS=v=7mttHgNOu-UdWGVpzf2LcBQ@mail.gmail.com>
Subject: Re: Modem control lines for RTSCTS hardware flow control via rts-gpio
 and cts-gpio with IMX
To:     linux-serial@vger.kernel.org
Cc:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Huang Shijie <b32955@freescale.com>,
        Dirk Behme <dirk.behme@googlemail.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Richard Genoud <richard.genoud@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, Jan 6, 2022 at 3:55 PM Tim Harvey <tharvey@gateworks.com> wrote:
>
> Greetings,
>
> I have long used modem control lines via GPIO with the IMX driver for
> RS485 via rts-gpios in the scenario where an RS485 transceiver
> transmit enable is connected to a GPIO representing RTS.
>
> Therefore I 'thought' that one could use rts-gpios and cts-gpios for
> hardware flow control on an IMX UART but it appears I may be wrong as
> when I define those along with 'uart-has-rtscts' UART communication
> ceases between the IMX and a device using hardware flow control.
>
> As an example take the following which describes a UART with RTSCTS
> flow control connected to a broadcom Bluetooth HCI radio:
>
> The following works:
> &uart4 {
>         pinctrl-names = "default";
>         pinctrl-0 = <&pinctrl_uart4>,<&pinctrl_bten>;
>         uart-has-rtscts;
>         status = "okay";
>
>         bluetooth {
>                 compatible = "brcm,bcm4330-bt";
>                 shutdown-gpios = <&gpio1 2 GPIO_ACTIVE_HIGH>;
>         };
> };
>
> &iomuxc {
>         pinctrl_bten: btengrp {
>                 fsl,pins = <
>                         MX6QDL_PAD_GPIO_2__GPIO1_IO02           0x1b0b1
>                 >;
>         };
>
>         pinctrl_uart4: uart4grp {
>                 fsl,pins = <
>                         MX6QDL_PAD_CSI0_DAT12__UART4_TX_DATA    0x1b0b1
>                         MX6QDL_PAD_CSI0_DAT13__UART4_RX_DATA    0x1b0b1
>                         MX6QDL_PAD_CSI0_DAT16__UART4_RTS_B      0x1b0b1
>                         MX6QDL_PAD_CSI0_DAT17__UART4_CTS_B      0x1b0b1
>                 >;
>         };
> };
>
> The following where I've replaced the RTS/CTS with gpio does not work:
> &uart4 {
>         pinctrl-names = "default";
>         pinctrl-0 = <&pinctrl_uart4>,<&pinctrl_bten>;
>         rts-gpios = <&gpio6 2 GPIO_ACTIVE_LOW>;
>         cts-gpios = <&gpio6 3 GPIO_ACTIVE_LOW>;
>         uart-has-rtscts;
>         status = "okay";
>
>         bluetooth {
>                 compatible = "brcm,bcm4330-bt";
>                 shutdown-gpios = <&gpio1 2 GPIO_ACTIVE_HIGH>;
>         };
> };
>
> &iomuxc {
>         pinctrl_bten: btengrp {
>                 fsl,pins = <
>                         MX6QDL_PAD_GPIO_2__GPIO1_IO02           0x1b0b1
>                 >;
>         };
>
>         pinctrl_uart4: uart4grp {
>                 fsl,pins = <
>                         MX6QDL_PAD_CSI0_DAT12__UART4_TX_DATA    0x1b0b1
>                         MX6QDL_PAD_CSI0_DAT13__UART4_RX_DATA    0x1b0b1
>                         MX6QDL_PAD_CSI0_DAT16__GPIO6_IO02       0x1b0b1
>                         MX6QDL_PAD_CSI0_DAT17__GPIO6_IO03       0x1b0b1
>                 >;
>         };
> };
>
> In the above example of course I could simply use the version that
> works but the reason I want to use rts-gpios and cts-gpios is that I
> have cases where I don't have access to the RTS/CTS pinmux options and
> thus can only use gpio's.
>
> I'm hoping perhaps I just have something misconfigured or that perhaps
> something simple is missing from drivers/tty/serial/imx.c in order to
> use gpio's as hardware flow control. I've tried flipping the rts/cts
> gpios and polarity in case I had something simply backwards but that
> still did not work.
>
> Any ideas or suggestions?
>
> Best regards,
>
> Tim

Adding some previous main committers to imx uart driver and mctrl feature to cc.

From looking over drivers/tty/serial/imx.c, serial_core.c, and
serial_mctrl_gpio.c I see that rts-gpios is the 'output' from the IMX
so I need to flip my gpios as:
         cts-gpios = <&gpio6 2 GPIO_ACTIVE_LOW>; // input to IMX from
BT_UART_RTS_L output on brcm chip
         rts-gpios = <&gpio6 3 GPIO_ACTIVE_LOW>; // output from IMX to
BT_UART_CTS_L input on brcm chip

I see the following happening when the brcm bluetooth uart driver initializes:
mctrl_gpio_init registers irq handler for cts gpio (gpio6 2)
mctrl_gpio_init configures output for rts gpio (gpio6 3)
uart_change_speed is called and sets CRTSCTS enabled and calls stop_tx
(imx_uart_stop_tx)
mctrl_gpio_irq_handle is called and it sees CTS=1 then calls
uart_handle_cts_change which calls start_tx

So I believe the CTS input is handled correctly but I see nothing that
asserts the RTS  output. The imx.c driver has imx_uart_rts_active and
imx_uart_rts_inactive which call mctrl_gpio_set to manipulate the RTS
output yet this is only done when the UART is configured for RS485
mode to handle the case where RTS is used as an output to enable the
RS485 transmit enable.

So I believe in order to support using gpios for rts/cts in the imx
uart driver I must find the right place to call imx_uart_rts_active
and imx_uart_rts_inactive when the FIFO is not full and full
respectively. I'm not that familiar with the Linux uart driver
framework - am I on the right track and if so any ideas where this is
best done?

Best Regards,

Tim

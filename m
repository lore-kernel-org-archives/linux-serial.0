Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B06A2C433F5
	for <linux-serial@archiver.kernel.org>; Thu,  6 Jan 2022 23:55:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245710AbiAFXzk (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 6 Jan 2022 18:55:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245701AbiAFXzk (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 6 Jan 2022 18:55:40 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40837C061245
        for <linux-serial@vger.kernel.org>; Thu,  6 Jan 2022 15:55:40 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id 59-20020a17090a09c100b001b34a13745eso2948383pjo.5
        for <linux-serial@vger.kernel.org>; Thu, 06 Jan 2022 15:55:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gateworks-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=9hPmrpE4K4lCQTa9NYmbI43A/EVAXv3AnB5Mu86t75g=;
        b=t2XNtwk4D/p21VwuhWM5P09DX8dF6pZOQ065sVR/9nz7r+mncFsWy7Os6OvRaj8dBU
         0G8wVbdmX/Q3K5Es+zyHHV9iUx1cuw5+xPKKvusIl/E1LPvQyZP/6EQb/rNo/zg8k0rF
         tiLPMBLhQu3gstX5ZB84ZX8UuEDd6W4g9upXX+2WCZi8qWMjOCnAWZ+8LB6glVCSE5yo
         4tHso5m6qugil9kYHCnCj92Nhj3tF7SS60aymuT1Nit0fq7JZsxqhQjLU9JoTMKH907L
         WB3rB3UhWzRjSA/owUStAHeez1BV/dxAUo7FD7yoTn7/dv7w1XHr6++K9PUbVrn1ETCz
         cILQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=9hPmrpE4K4lCQTa9NYmbI43A/EVAXv3AnB5Mu86t75g=;
        b=5TwWlluPE07q5nbjYcezKKJJYf/93erh5D1U1OEd2tsDfxioFgaag0IN1SsToV8Jnb
         vS9KDtu8oH4WFdZf61DOw01kQd/5F7zRgoWwOdlfZlgc9CgV1nZAbVRr9sPsVj5SKQki
         n6B/OUXKkdsygFK5RAa2aTEhrt9UzLcKnXqqKjIiUPGmgO1xuWDaCnS8ImxnoKv+esYU
         IT+zXbtydlM270HIr4pltsiIKycMXf0Jrw5AXjNQdOLsEooKxvVGIJe8sgh/Ql+8AsHW
         VtjkOjAhUr0BRAJVc6HBmRGU7CSlXlJlvYKIDC+KfhDNzP55gTsF/NCexGcglOOJgKp0
         ggRQ==
X-Gm-Message-State: AOAM532CEx978mOMCfrwhrnccsSOcm3ICV8jQmnoZJuV3ilWVtSIvveh
        zTyzMKVrV0e1NDDDgP+Z4CDNLHqRwnZcZZOo4wZdMFdvipeV+g==
X-Google-Smtp-Source: ABdhPJzVKhfsQ4eA6E/BWokXWSl1c3zE4ZbxyXkf9qHXovxTRyPAwuWeOBSl4lSxkl6+4ypH/gM7herNz58reHY3N18=
X-Received: by 2002:a17:902:c214:b0:148:a798:7aa with SMTP id
 20-20020a170902c21400b00148a79807aamr62364708pll.90.1641513338831; Thu, 06
 Jan 2022 15:55:38 -0800 (PST)
MIME-Version: 1.0
From:   Tim Harvey <tharvey@gateworks.com>
Date:   Thu, 6 Jan 2022 15:55:27 -0800
Message-ID: <CAJ+vNU0CrD8091W5zH7ve9v3ZVAGXR6=6DGebd5LhHz4mzt4+w@mail.gmail.com>
Subject: Modem control lines for RTSCTS hardware flow control via rts-gpio and
 cts-gpio with IMX
To:     linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Greetings,

I have long used modem control lines via GPIO with the IMX driver for
RS485 via rts-gpios in the scenario where an RS485 transceiver
transmit enable is connected to a GPIO representing RTS.

Therefore I 'thought' that one could use rts-gpios and cts-gpios for
hardware flow control on an IMX UART but it appears I may be wrong as
when I define those along with 'uart-has-rtscts' UART communication
ceases between the IMX and a device using hardware flow control.

As an example take the following which describes a UART with RTSCTS
flow control connected to a broadcom Bluetooth HCI radio:

The following works:
&uart4 {
        pinctrl-names = "default";
        pinctrl-0 = <&pinctrl_uart4>,<&pinctrl_bten>;
        uart-has-rtscts;
        status = "okay";

        bluetooth {
                compatible = "brcm,bcm4330-bt";
                shutdown-gpios = <&gpio1 2 GPIO_ACTIVE_HIGH>;
        };
};

&iomuxc {
        pinctrl_bten: btengrp {
                fsl,pins = <
                        MX6QDL_PAD_GPIO_2__GPIO1_IO02           0x1b0b1
                >;
        };

        pinctrl_uart4: uart4grp {
                fsl,pins = <
                        MX6QDL_PAD_CSI0_DAT12__UART4_TX_DATA    0x1b0b1
                        MX6QDL_PAD_CSI0_DAT13__UART4_RX_DATA    0x1b0b1
                        MX6QDL_PAD_CSI0_DAT16__UART4_RTS_B      0x1b0b1
                        MX6QDL_PAD_CSI0_DAT17__UART4_CTS_B      0x1b0b1
                >;
        };
};

The following where I've replaced the RTS/CTS with gpio does not work:
&uart4 {
        pinctrl-names = "default";
        pinctrl-0 = <&pinctrl_uart4>,<&pinctrl_bten>;
        rts-gpios = <&gpio6 2 GPIO_ACTIVE_LOW>;
        cts-gpios = <&gpio6 3 GPIO_ACTIVE_LOW>;
        uart-has-rtscts;
        status = "okay";

        bluetooth {
                compatible = "brcm,bcm4330-bt";
                shutdown-gpios = <&gpio1 2 GPIO_ACTIVE_HIGH>;
        };
};

&iomuxc {
        pinctrl_bten: btengrp {
                fsl,pins = <
                        MX6QDL_PAD_GPIO_2__GPIO1_IO02           0x1b0b1
                >;
        };

        pinctrl_uart4: uart4grp {
                fsl,pins = <
                        MX6QDL_PAD_CSI0_DAT12__UART4_TX_DATA    0x1b0b1
                        MX6QDL_PAD_CSI0_DAT13__UART4_RX_DATA    0x1b0b1
                        MX6QDL_PAD_CSI0_DAT16__GPIO6_IO02       0x1b0b1
                        MX6QDL_PAD_CSI0_DAT17__GPIO6_IO03       0x1b0b1
                >;
        };
};

In the above example of course I could simply use the version that
works but the reason I want to use rts-gpios and cts-gpios is that I
have cases where I don't have access to the RTS/CTS pinmux options and
thus can only use gpio's.

I'm hoping perhaps I just have something misconfigured or that perhaps
something simple is missing from drivers/tty/serial/imx.c in order to
use gpio's as hardware flow control. I've tried flipping the rts/cts
gpios and polarity in case I had something simply backwards but that
still did not work.

Any ideas or suggestions?

Best regards,

Tim

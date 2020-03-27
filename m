Return-Path: <SRS0=8UUK=5M=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CABFC2D0EE
	for <linux-serial@archiver.kernel.org>; Fri, 27 Mar 2020 10:04:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71235206F8
	for <linux-serial@archiver.kernel.org>; Fri, 27 Mar 2020 10:04:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fm1BGbXw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726096AbgC0KET (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 27 Mar 2020 06:04:19 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:45117 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726115AbgC0KEN (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 27 Mar 2020 06:04:13 -0400
Received: by mail-lj1-f193.google.com with SMTP id t17so9545953ljc.12
        for <linux-serial@vger.kernel.org>; Fri, 27 Mar 2020 03:04:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qtl1Eialsdl3z7ZP76hLFrTUnrm/Xwed3O3Is0v5u2s=;
        b=fm1BGbXw3YbyFJAFmqHvsEnrwOu7+/+ujtJ86z5Orejx852KLJeCDtQq+soYhGzfCj
         2rAfF7PxQg2H2Sgjn2JBjFbILfIVHBT7QxDFDZh2R3HOuTeyVGc0fKnVbnrXO43QCj8x
         cXlH+JS+Jobqck2T5KLCJ/QxbIlZUnxiWcd/WFLXFPVgiIHA/VQnYBo2xwwlOuCaoBNf
         PV01d4t1H3eQqxbYRIT2/sc/hXgoikPd8X3chF1TEDLMvJhtp9ZecGoNxVyrMZXDYddu
         VUti7wxKuFzjCVhJlxMkwTw2df/O1qZUfem6Ydt42/5xj5qm4D1YHiUkYri/dNaN3Cn1
         sdLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qtl1Eialsdl3z7ZP76hLFrTUnrm/Xwed3O3Is0v5u2s=;
        b=i9MnFS8mPdAQyV31bSJWhq3jOVoo/JJw6e2dxRW+h2W0Zr4NJ0/Fh7fXuiXv9PjC4P
         DmSG/ydrhpXDLat1EC+6g3q918rxuwzqM+EuuM+cFZCswvJh73DGXGreASr616EKiXFU
         sVEB03OaEU6ByfvC8+uOlZ1zBYdvWW7e0Z++7F2RNf/76f595e/n8auV2hXrWcRAvWTy
         NUkB2zkC3w5oPVApkqkoJvSBUxbEJ4srCnozDguP3zJQ5r27iEjV751U3Whe+AMshJjR
         Zwp1ubQwOQyK/wHB5L8rg8g2g9L3QxdCZHqhc9NpBG19+ia9Guppuo3+s2R9oSePorUz
         Zm9w==
X-Gm-Message-State: AGi0Pua8d64ym3g5zo1ZhfAQyng4UYeq/0BRp0w28ZMCS2bAtd/JVAkl
        GKkL3qtn0lq9x4xuzXJLDab7ruTQJK7pjVHihSz5ZA==
X-Google-Smtp-Source: ADFU+vsLFzRSaI0mp4F0YlxEk/ZWtLbeZk2X0x8rIBWVbKHsUZE12xxYtPOS4x7TLee1muHrdP/vfqhKQcCaKg9I0tI=
X-Received: by 2002:a2e:9605:: with SMTP id v5mr7696484ljh.258.1585303451336;
 Fri, 27 Mar 2020 03:04:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200317093922.20785-1-lkundrak@v3.sk> <20200317093922.20785-22-lkundrak@v3.sk>
In-Reply-To: <20200317093922.20785-22-lkundrak@v3.sk>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 27 Mar 2020 11:04:00 +0100
Message-ID: <CACRpkdaEnODObC7emg2M7Ayn_JkeLuc3HpV4VhJcwaZ+=sDLcg@mail.gmail.com>
Subject: Re: [PATCH 21/28] dt-bindings: gpio: Convert mrvl-gpio to json-schema
To:     Lubomir Rintel <lkundrak@v3.sk>,
        Robert Jarzmik <robert.jarzmik@free.fr>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Brown <broonie@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-i2c <linux-i2c@vger.kernel.org>,
        linux-media@vger.kernel.org, linux-mmc <linux-mmc@vger.kernel.org>,
        linux-rtc@vger.kernel.org,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        linux-usb <linux-usb@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi Lubomir!

Excellent work! Just nitpicks:

On Tue, Mar 17, 2020 at 10:40 AM Lubomir Rintel <lkundrak@v3.sk> wrote:

> +++ b/Documentation/devicetree/bindings/gpio/mrvl-gpio.yaml
> @@ -0,0 +1,173 @@
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/gpio/mrvl-gpio.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Marvell PXA GPIO controller

This binding is lacking a license. Please use the dual GPL+BSD license
tag.

> +maintainers:
> +  - devicetree@vger.kernel.org

I don't know if Robert Jarzmik is in on maintaining this, would you accept
it Robert?

Yours,
Linus Walleij

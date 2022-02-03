Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4805FC4332F
	for <linux-serial@archiver.kernel.org>; Thu,  3 Feb 2022 07:42:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230204AbiBCHmI (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 3 Feb 2022 02:42:08 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:50826
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243212AbiBCHmG (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 3 Feb 2022 02:42:06 -0500
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com [209.85.221.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 1F4A34003B
        for <linux-serial@vger.kernel.org>; Thu,  3 Feb 2022 07:42:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1643874120;
        bh=69oC9K6bP5zXfYZ3RPqGsmz6Po3E4WX3hDMRIgEHu/M=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=FUHbiE8FBVpmwabkyaXMwQfMKG94mvp5jbMCtFxaiVWBuddx40kZyytrgm3iECdUd
         QVzpdIR/8MStRHZpRddjvCvrjf+SaaSaLbExBKnXD+k4oFb6lOTeOqbCd+6+RCUrGP
         5diUkVbyzgSCZmDXxVaIb1r0NTQ4ksHyg7BvmXR98SD4CYrBjbB+9KOF9a7rbcjL3p
         CpCTzgYSm/899/dwHn/FfcyvH5oU8gXPPYXnmMs/7qLsuE37xUutuhr+meKSrCyON8
         6/CHhBJjdX1q7sKKoN80/22a+T8r1QIkN3HqyF9jWgUuwO6U9UOmfEq810bRJQRZS9
         CQajyu5g4nXfQ==
Received: by mail-wr1-f70.google.com with SMTP id a6-20020adfbc46000000b001d7370ace6eso349010wrh.9
        for <linux-serial@vger.kernel.org>; Wed, 02 Feb 2022 23:42:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=69oC9K6bP5zXfYZ3RPqGsmz6Po3E4WX3hDMRIgEHu/M=;
        b=TAt0TE+sSqspI46Kgd7p15M0Jo8u9dN9UP3Hev0zqfLZZWWTDYHpU8VxNkKXrPm/yx
         aKi/osfGpmAD+PQvbTfENzNGkCDD+UooFv3+QGrR4ciBtEYrucmwLyRd2gIwiiF+1tj9
         gThLPOEtWBEuDacZnYUpF4U9uBGP4mnQhG6yJG7NN+nfhZOucDFcHA4jV0asUdeIAxKg
         tG9sWxIg1BuhksYSkheoADoMtUzUSMIocKfYWYLWKeJvk+uStPPbYKCOw8g38UxkLFR6
         o72PJQKfPi44k6fgv5MWp1mg8JfvUfmQ9HfZVLEvjZEsoW16qaDtI0Bf71m5Nj5DuXIR
         BVbA==
X-Gm-Message-State: AOAM533AqEKFM9calflTb9vVjfHG1aC830tujqTz1EDcz0HvJVRjdhga
        HVcgFlkNiDKveXvUwkdpfQl1F18qW/VTBxTRZA85APiNTie25JyOCoqk1+/8C/OSEjQ0TbMf/93
        36DD8WV8jphYenWjz0mJWl1NBJR1XXyV4Wbe4Op7LBA==
X-Received: by 2002:a05:6000:10cf:: with SMTP id b15mr28156901wrx.70.1643874119530;
        Wed, 02 Feb 2022 23:41:59 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwInkGYx0bCKYBNdkDDYX+ptQNyAD6vMUiS8CqzI/xYfseOfTNCURA5lpsX4JtSbcPIAvyzjw==
X-Received: by 2002:a05:6000:10cf:: with SMTP id b15mr28156886wrx.70.1643874119363;
        Wed, 02 Feb 2022 23:41:59 -0800 (PST)
Received: from [192.168.0.80] (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id t18sm19832712wri.34.2022.02.02.23.41.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Feb 2022 23:41:58 -0800 (PST)
Message-ID: <1d549a00-b9f5-d60f-2d5b-798e92139f86@canonical.com>
Date:   Thu, 3 Feb 2022 08:41:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] HPE BMC GXP SUPPORT
Content-Language: en-US
To:     nick.hawkins@hpe.com, verdun@hpe.com
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Corey Minyard <minyard@acm.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Lee Jones <lee.jones@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Brown <broonie@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        soc@kernel.org, Shawn Guo <shawnguo@kernel.org>,
        Stanislav Jakubek <stano.jakubek@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Hao Fang <fanghao11@huawei.com>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Wang Kefeng <wangkefeng.wang@huawei.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-i2c@vger.kernel.org,
        openipmi-developer@lists.sourceforge.net,
        linux-mtd@lists.infradead.org, netdev@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <nick.hawkins@hpe.com>
 <20220202165315.18282-1-nick.hawkins@hpe.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220202165315.18282-1-nick.hawkins@hpe.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 02/02/2022 17:52, nick.hawkins@hpe.com wrote:
> From: Nick Hawkins <nick.hawkins@hpe.com>
> 
> GXP is the name of the HPE SoC.
> This SoC is used to implement BMC features of HPE servers
> (all ProLiant, Synergy, and many Apollo, and Superdome machines)
> It does support many features including:
> 	ARMv7 architecture, and it is based on a Cortex A9 core
> 	Use an AXI bus to which
> 		a memory controller is attached, as well as
>                  multiple SPI interfaces to connect boot flash,
>                  and ROM flash, a 10/100/1000 Mac engine which
>                  supports SGMII (2 ports) and RMII
> 		Multiple I2C engines to drive connectivity with a host infrastructure
> 		A video engine which support VGA and DP, as well as
>                  an hardware video encoder
> 		Multiple PCIe ports
> 		A PECI interface, and LPC eSPI
> 		Multiple UART for debug purpose, and Virtual UART for host connectivity
> 		A GPIO engine
> This Patch Includes:
> 	Documentation for device tree bindings
> 	Device Tree Bindings
> 	GXP Timer Support
> 	GXP Architecture Support
> 

1. Please version your patchses and document the changes under ---.

2. With your v1 I responded what has to be separate patch. This was
totally ignored here, so no. You have to follow this.

3. Please run checkpatch and be sure there are no warnings.

4. Bindings in dtschema, not in text.

Best regards,
Krzysztof

Best regards,
Krzysztof

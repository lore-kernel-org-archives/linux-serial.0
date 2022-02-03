Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1204C433EF
	for <linux-serial@archiver.kernel.org>; Thu,  3 Feb 2022 14:56:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351609AbiBCO4Q (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 3 Feb 2022 09:56:16 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:33980
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1351580AbiBCO4L (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 3 Feb 2022 09:56:11 -0500
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com [209.85.221.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 94A3440326
        for <linux-serial@vger.kernel.org>; Thu,  3 Feb 2022 14:56:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1643900170;
        bh=JKwlxtatWZQCVG4GF4BszucWwjVQTt2PxoebrxL5ciY=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=rltei9Ru4gIglU2x++cOWijrRp0EQ9w2zzu32ru9wgBMSOMjo0aYMynG/q01y8/z7
         dDPyAAEr6WzlUdOyhgAFuqJ0Jbhmj/B82Ea6Hakwl5qEPfNWHvZQJIr5zIkafdEkML
         UF/rriwpdKkRdxsKkYwi7oOJxI3fcAiXbTmlssiAfD4pgcrK4WAEMYZXGwnDvOuHwe
         Bm4bh1rDD4mNKeXSFkG0U6xIWXYmcyaLQ0nSWbDI67BcjMr+//cMqd08ypDI+MmmBf
         JXb59Qr1qiSpgqFlT1ku6XXKfqwmify11dcZZFO/JNgDjsp67hHzc7pv3/ul8uRWAY
         8bLhpFdfQkX0Q==
Received: by mail-wr1-f72.google.com with SMTP id h2-20020adfa4c2000000b001e26b5f1ec5so728663wrb.13
        for <linux-serial@vger.kernel.org>; Thu, 03 Feb 2022 06:56:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=JKwlxtatWZQCVG4GF4BszucWwjVQTt2PxoebrxL5ciY=;
        b=aIMr8exei2AAseucj5hfrI8U2cTWBfRmHbf5sM3Oc0ykrMGarJnGsf8E2fLXB7Tho9
         /JkcR9eM/1RWefWY0Mn++rYiUdfOYvWfE+iNWYxUOg3bzN+z4qpXyFeBGY7HXWbaDTch
         Gd0aXsv6MHd1tgSyY47BhWo19wqge8gqYfqqOET4LV/+DRgwcT3zamT/6rvx5gJlM8fA
         oiZHGvR0HpHrQbyVJlNP1M140FUVigaIsZAoqSpXPPyGce/YvH8grc8JdSaidb5QtWVQ
         J07kie1ogjm4Gbh+QnwenK8bCT1Z5L6rJwtVj7VURm4Bu0rDhnDd35HpwpGJLHt4Zixt
         eu9w==
X-Gm-Message-State: AOAM5316VAPVeR8l8z+wNUMS1tttBXKSvCa6dNmWun1BBFsUakaUh8/q
        sqT4XabbDUE3x+4FpiLyqaxnHtW5AeiNVNoHixA0+q+O7i+qpGIxOdEPZjP5SoUd+H00BgrgSwa
        b+iX/k37g/SbFuAvrz6v606KPCoLcZ1dF2vzxC/DeAw==
X-Received: by 2002:a17:907:c14:: with SMTP id ga20mr1992524ejc.243.1643900159600;
        Thu, 03 Feb 2022 06:55:59 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxET41+skPJ0t2ws3cpvdAuE3SIGtoLLzPApxhNtKVWxdECIqy/nqXcAWE2tMCANk5h/+crhA==
X-Received: by 2002:a17:907:c14:: with SMTP id ga20mr1992450ejc.243.1643900159293;
        Thu, 03 Feb 2022 06:55:59 -0800 (PST)
Received: from [192.168.0.81] (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id z19sm7573934eja.18.2022.02.03.06.55.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Feb 2022 06:55:58 -0800 (PST)
Message-ID: <e79133f2-f872-3ed6-4038-526e94e84909@canonical.com>
Date:   Thu, 3 Feb 2022 15:55:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] HPE BMC GXP SUPPORT
Content-Language: en-US
To:     Rob Herring <robh+dt@kernel.org>, nick.hawkins@hpe.com
Cc:     verdun@hpe.com, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
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
        SoC Team <soc@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
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
        dri-devel <dri-devel@lists.freedesktop.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux I2C <linux-i2c@vger.kernel.org>,
        openipmi-developer@lists.sourceforge.net,
        MTD Maling List <linux-mtd@lists.infradead.org>,
        netdev <netdev@vger.kernel.org>,
        Linux PWM List <linux-pwm@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        Linux USB List <linux-usb@vger.kernel.org>,
        LINUX-WATCHDOG <linux-watchdog@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
References: <nick.hawkins@hpe.com>
 <20220202165315.18282-1-nick.hawkins@hpe.com>
 <CAL_Jsq+K2t5WYE056so1iZgZr7CBKvDEjAwnJVTyUFQcK-VFSA@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <CAL_Jsq+K2t5WYE056so1iZgZr7CBKvDEjAwnJVTyUFQcK-VFSA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 03/02/2022 15:29, Rob Herring wrote:
> On Wed, Feb 2, 2022 at 10:55 AM <nick.hawkins@hpe.com> wrote:
>>
>> From: Nick Hawkins <nick.hawkins@hpe.com>
>>

(...)

>> +
>> +       vuart_a: vuart_a@80fd0200 {
> 
> serial@...

Maybe it does not look like, but this is actually a v2. Nick was asked
to change the naming for the nodes already in v1. Unfortunately it did
not happen, so we have vuart, spifi, vic and more.

It is a waste of reviewers' time to ask them to perform the same review
twice or to ignore their comments.

> 
>> +               compatible = "hpe,gxp-vuart";
>> +               reg = <0x80fd0200 0x100>;
>> +               interrupts = <2>;
>> +               interrupt-parent = <&vic1>;
>> +               clock-frequency = <1846153>;
>> +               reg-shift = <0>;
>> +               status = "okay";
>> +               serial-line = <3>;
>> +               vuart_cfg = <&vuart_a_cfg>;
>> +       };

(...)

>> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
>> index 294093d45a23..913f722a6b8d 100644
>> --- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
>> +++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
>> @@ -514,7 +514,9 @@ patternProperties:
>>    "^hoperun,.*":
>>      description: Jiangsu HopeRun Software Co., Ltd.
>>    "^hp,.*":
>> -    description: Hewlett Packard
>> +    description: Hewlett Packard Inc.
> 
> Why are you changing this one?

I guess this is squashing of my patch:
https://lore.kernel.org/all/20220127075229.10299-1-krzysztof.kozlowski@canonical.com/

which is fine to me, but vendor changve should be a separate commit with
its own explanation. Now it looks indeed weird.

> 
>> +  "^hpe,.*":
> 
> You used HPE elsewhere... Lowercase is preferred.




Best regards,
Krzysztof

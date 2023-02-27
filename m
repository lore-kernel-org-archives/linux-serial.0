Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5CF7C64ED6
	for <linux-serial@archiver.kernel.org>; Mon, 27 Feb 2023 09:32:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229959AbjB0JcZ (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 27 Feb 2023 04:32:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbjB0JcY (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 27 Feb 2023 04:32:24 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F29B5AD27
        for <linux-serial@vger.kernel.org>; Mon, 27 Feb 2023 01:31:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677490287;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RZ7tgd2yMldNRnjyOaSsgByklv9W+sBvCfRkPHDmb94=;
        b=gR45BAQoRRR7BQ4XcFbcUHwQ3FeiufoFMFx4RiGFo1SXaHCr3dj6a9Simf/n0Ms0zvOujC
        Ubw7JpRvbCCPJ4S1rQZg4ovL1ED1AQZwmKZ5flSWigKOX1yJmANZHHrwRxOSsD/sRUDnYV
        gl4YnA3YFImC5i35LzHZY8QMmS9gBHQ=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-453-bDq7UkJoO9ijJ2H_lES8Zg-1; Mon, 27 Feb 2023 04:31:25 -0500
X-MC-Unique: bDq7UkJoO9ijJ2H_lES8Zg-1
Received: by mail-ed1-f69.google.com with SMTP id cz22-20020a0564021cb600b004a245f58006so7758246edb.12
        for <linux-serial@vger.kernel.org>; Mon, 27 Feb 2023 01:31:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RZ7tgd2yMldNRnjyOaSsgByklv9W+sBvCfRkPHDmb94=;
        b=A3MGFpnFAc3aTmm+uoPkcJfX9ln4upBslTWHV8ITZfnlwdSMMVwsCH93qX535i5R2H
         qHhWuGKsn6Ha4mfrcHrvWkLCBnp6YPYbdHIJ/ok+TK0kvrvq4qOFNcitBQSmulnXlF3X
         2awO2xH10z2ObQsg3AP14rcklOUpVAMey1DBdJefXN+9+USX56q09Mm4DAsw1drtTHG6
         ebT1NHqCqLDwlcgUCXvTM8Of/3zqhAdxpsIO8NhkS3rHmL+k4bM1jOoHmEf0y0XAO9xg
         I2aaovs5N5mMgM5vSbgrEY/LjdnBAFFwIeUlu+3eABtd3KZ2lxjNTrX88hlBVFx7PM/3
         KbIw==
X-Gm-Message-State: AO0yUKVniQXJQRxbOe6KoB6o4U/nt1U6h1O+4UsyIxuo45Z9MZ6MNrmj
        YH1ekvygJhXvNhTjl9mcgeL2t4x3sKAka25fAYMv3FKtrl6E8apYstjcmqyCq+xcC3sq6F/dMdm
        mjxL7Rn86GTe8Frsl2CtfMmCi
X-Received: by 2002:a17:906:4d8c:b0:8ae:f73e:233f with SMTP id s12-20020a1709064d8c00b008aef73e233fmr36187965eju.32.1677490284511;
        Mon, 27 Feb 2023 01:31:24 -0800 (PST)
X-Google-Smtp-Source: AK7set+NbVSpt4yOAnECcpAr2/cCoG6u5mlrIrkJajmml4ubXI2EjR7IrG3eLzjCQWCzYYep+F5FNw==
X-Received: by 2002:a17:906:4d8c:b0:8ae:f73e:233f with SMTP id s12-20020a1709064d8c00b008aef73e233fmr36187918eju.32.1677490284210;
        Mon, 27 Feb 2023 01:31:24 -0800 (PST)
Received: from [10.40.98.142] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id qq10-20020a17090720ca00b008e09deb6610sm2942505ejb.200.2023.02.27.01.31.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Feb 2023 01:31:23 -0800 (PST)
Message-ID: <7dd27ec5-0619-128d-8407-6711a05ef271@redhat.com>
Date:   Mon, 27 Feb 2023 10:31:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 0/8] drivers: select REGMAP instead of depending on it
To:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc:     Andrew Jeffery <andrew@aj.id.au>, Corey Minyard <minyard@acm.org>,
        openipmi-developer@lists.sourceforge.net,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Riku Voipio <riku.voipio@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, Michael Walle <michael@walle.cc>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-gpio@vger.kernel.org, Dan Murphy <dmurphy@ti.com>,
        Pavel Machek <pavel@ucw.cz>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Lee Jones <lee@kernel.org>, linux-leds@vger.kernel.org,
        Darren Hart <dvhart@infradead.org>,
        Michael Shych <michaelsh@nvidia.com>,
        Mark Gross <markgross@kernel.org>,
        Vadim Pasternak <vadimp@nvidia.com>,
        platform-driver-x86@vger.kernel.org,
        Yegnesh S Iyer <yegnesh.s.iyer@intel.com>,
        Bin Gao <bin.gao@intel.com>, Zhang Rui <rui.zhang@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>, linux-pm@vger.kernel.org,
        Oskar Senft <osk@google.com>, linux-serial@vger.kernel.org
References: <20230226053953.4681-1-rdunlap@infradead.org>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20230226053953.4681-1-rdunlap@infradead.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi Randy,

On 2/26/23 06:39, Randy Dunlap wrote:
> REGMAP is a hidden (not user visible) symbol. Users cannot set it
> directly thru "make *config", so drivers should select it instead of
> depending on it if they need it.
> 
> Consistently using "select" or "depends on" can also help reduce
> Kconfig circular dependency issues.
> 
> REGMAP is selected 94 times and is depended on 11 times in
> current linux-next. Eliminate the uses of "depends on" by
> converting them to "select".

Thank you for your work on this. Mixing of depends on vs select
is a real problem with many Kconfig symbols.

>  [PATCH 1/8] ipmi: ASPEED_BT_IPMI_BMC: select REGMAP_MMIO instead of depending on it
>  [PATCH 2/8] clk: HI655X: select REGMAP instead of depending on it
>  [PATCH 3/8] gpio: GPIO_REGMAP: select REGMAP instead of depending on it
>  [PATCH 4/8] leds: TI_LMU_COMMON: select REGMAP instead of depending on it
>  [PATCH 5/8] platform: mellanox: select REGMAP instead of depending on it
>  [PATCH 6/8] platform: x86: MLX_PLATFORM: select REGMAP instead of depending on it
>  [PATCH 7/8] thermal: intel: BXT_PMIC: select REGMAP instead of depending on it
>  [PATCH 8/8] serial: 8250: ASPEED_VUART: select REGMAP instead of depending on it

For patch 5/8 and 6/8, do you want me to merge them through the pdx86
(platform-drivers-x86) tree, or do you plan to merge this whole series
in one go through some other tree?

If you plan to merge the whole series through some other tree,
here is my acked by for doing so for 5/8 and 6/8:

Acked-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans




> 
> diffstat:
>  drivers/char/ipmi/Kconfig         |    3 ++-
>  drivers/clk/Kconfig               |    2 +-
>  drivers/gpio/Kconfig              |    2 +-
>  drivers/leds/Kconfig              |    2 +-
>  drivers/platform/mellanox/Kconfig |    9 ++++-----
>  drivers/platform/x86/Kconfig      |    3 ++-
>  drivers/thermal/intel/Kconfig     |    3 ++-
>  drivers/tty/serial/8250/Kconfig   |    3 ++-
>  8 files changed, 15 insertions(+), 12 deletions(-)
> 
> Cc: Andrew Jeffery <andrew@aj.id.au>
> Cc: Corey Minyard <minyard@acm.org>
> Cc: openipmi-developer@lists.sourceforge.net
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Riku Voipio <riku.voipio@linaro.org>
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: Michael Turquette <mturquette@baylibre.com>
> Cc: linux-clk@vger.kernel.org
> Cc: Michael Walle <michael@walle.cc>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Bartosz Golaszewski <brgl@bgdev.pl>
> Cc: linux-gpio@vger.kernel.org
> Cc: Dan Murphy <dmurphy@ti.com>
> Cc: Pavel Machek <pavel@ucw.cz>
> Cc: Jacek Anaszewski <jacek.anaszewski@gmail.com>
> Cc: Lee Jones <lee@kernel.org>
> Cc: linux-leds@vger.kernel.org
> Cc: Darren Hart <dvhart@infradead.org>
> Cc: Hans de Goede <hdegoede@redhat.com>
> Cc: Michael Shych <michaelsh@nvidia.com>
> Cc: Mark Gross <markgross@kernel.org>
> Cc: Vadim Pasternak <vadimp@nvidia.com>
> Cc: platform-driver-x86@vger.kernel.org
> Cc: Yegnesh S Iyer <yegnesh.s.iyer@intel.com>
> Cc: Bin Gao <bin.gao@intel.com>
> Cc: Zhang Rui <rui.zhang@intel.com>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: Amit Kucheria <amitk@kernel.org>
> Cc: linux-pm@vger.kernel.org
> Cc: Oskar Senft <osk@google.com>
> Cc: linux-serial@vger.kernel.org
> 


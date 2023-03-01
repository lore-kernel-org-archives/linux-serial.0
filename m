Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9351AC64ED6
	for <linux-serial@archiver.kernel.org>; Wed,  1 Mar 2023 12:47:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbjCAMrw (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 1 Mar 2023 07:47:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbjCAMrw (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 1 Mar 2023 07:47:52 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68035302BE
        for <linux-serial@vger.kernel.org>; Wed,  1 Mar 2023 04:47:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677674831;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PrHWi0O3bp5TW073HxIoo2GqwQh60ydUW1vLbyoS8FU=;
        b=TCDHMqCmqHOxRM5QtpqYDPa+29+jQWl3x4nbuRHyIqBT/jY9yYGiViECo1cLHP6WbPZiuP
        f5vkgiw/54KEixCIcXlpsnmcPfS4ZAqnX0J3uFW4LuUwnwLk49EM8jC+Hm/O/5n4AY6FRX
        XZQ1pyQFsGoEjAFzngV2rjHCqL9QVBw=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-536-dSLAgas1P1KkuyiiaOEkiA-1; Wed, 01 Mar 2023 07:47:10 -0500
X-MC-Unique: dSLAgas1P1KkuyiiaOEkiA-1
Received: by mail-ed1-f72.google.com with SMTP id fj7-20020a0564022b8700b004bbcdf3751bso3456762edb.1
        for <linux-serial@vger.kernel.org>; Wed, 01 Mar 2023 04:47:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PrHWi0O3bp5TW073HxIoo2GqwQh60ydUW1vLbyoS8FU=;
        b=ssbR9ZXe/tvpOC2HVtasebkHVxVucEOlWN8xtp9Un98yuLWpObv70dEwQjxEdGIZN5
         XCGLHAZIrpvLbFYmeM2JsEm23W0cM/6Y9x2ZLr5imq1H6jbobotWwERkkvl/lzzSI0sp
         Jt+NhldVsS1pab7iK9XxinotDHbosLRyZ14S2uvpvDJRYomoXqzIFeDspnSMe5YGa5/x
         Eb5Eck5lBinRha9qJ95o1k7DoOEGehhrfPUocoo3F8xfJ5+LxP9QK4L1E2kUZzEBtHcz
         8gQQ5IP5AYfA54iF2WnbIYRcSLR5oBXBOjcg4R8nbDQ4dB3g7ZzwNNwzdndYHsBSCjX4
         BHiA==
X-Gm-Message-State: AO0yUKXP4HDXKDiUnLpaY3xSl3iCmMnr42bv25wdPk1sm+Im6VStZ60C
        rjX7WEoapCAEidx2QRTfG7IjsuFl6KahX0FU3HR9/DBXTvyNEa+BJ1Ktd1GqZZdnY52SYFLbgdn
        0qgULofhFhdh7cDhnOdaAjfNH
X-Received: by 2002:aa7:d6c4:0:b0:4af:59c0:744a with SMTP id x4-20020aa7d6c4000000b004af59c0744amr7757574edr.24.1677674829574;
        Wed, 01 Mar 2023 04:47:09 -0800 (PST)
X-Google-Smtp-Source: AK7set/gegt3wNPFIA5UaAFSkM0H/Cu2JETEa5VzADkRpzuOeLZLY8c4YHH4dVV9FidRJQJWbeU9sQ==
X-Received: by 2002:aa7:d6c4:0:b0:4af:59c0:744a with SMTP id x4-20020aa7d6c4000000b004af59c0744amr7757547edr.24.1677674829268;
        Wed, 01 Mar 2023 04:47:09 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id b18-20020a50b412000000b004bda465da32sm374934edh.1.2023.03.01.04.47.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Mar 2023 04:47:08 -0800 (PST)
Message-ID: <5bb49015-0a9c-5b9d-b22c-38011439c984@redhat.com>
Date:   Wed, 1 Mar 2023 13:47:07 +0100
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
 <7dd27ec5-0619-128d-8407-6711a05ef271@redhat.com>
 <6a95a337-2972-427f-635d-5ef4e91a82fa@infradead.org>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <6a95a337-2972-427f-635d-5ef4e91a82fa@infradead.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US, nl
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi,

On 2/27/23 17:07, Randy Dunlap wrote:
> 
> 
> On 2/27/23 01:31, Hans de Goede wrote:
>> Hi Randy,
>>
>> On 2/26/23 06:39, Randy Dunlap wrote:
>>> REGMAP is a hidden (not user visible) symbol. Users cannot set it
>>> directly thru "make *config", so drivers should select it instead of
>>> depending on it if they need it.
>>>
>>> Consistently using "select" or "depends on" can also help reduce
>>> Kconfig circular dependency issues.
>>>
>>> REGMAP is selected 94 times and is depended on 11 times in
>>> current linux-next. Eliminate the uses of "depends on" by
>>> converting them to "select".
>>
>> Thank you for your work on this. Mixing of depends on vs select
>> is a real problem with many Kconfig symbols.
>>
>>>  [PATCH 1/8] ipmi: ASPEED_BT_IPMI_BMC: select REGMAP_MMIO instead of depending on it
>>>  [PATCH 2/8] clk: HI655X: select REGMAP instead of depending on it
>>>  [PATCH 3/8] gpio: GPIO_REGMAP: select REGMAP instead of depending on it
>>>  [PATCH 4/8] leds: TI_LMU_COMMON: select REGMAP instead of depending on it
>>>  [PATCH 5/8] platform: mellanox: select REGMAP instead of depending on it
>>>  [PATCH 6/8] platform: x86: MLX_PLATFORM: select REGMAP instead of depending on it
>>>  [PATCH 7/8] thermal: intel: BXT_PMIC: select REGMAP instead of depending on it
>>>  [PATCH 8/8] serial: 8250: ASPEED_VUART: select REGMAP instead of depending on it
>>
>> For patch 5/8 and 6/8, do you want me to merge them through the pdx86
>> (platform-drivers-x86) tree, or do you plan to merge this whole series
>> in one go through some other tree?
> 
> Hi Hans,
> Please merge them thru the pdx86 tree.

Ok, I've applied patch 5/8 + 6/8 to my review-hans branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans

I'll rebase that branch once 6.3-rc1 is out and then push the rebased
patch to the fixes branch and include it in my next 6.3 fixes pull-req
to Linus.

Regards,

Hans





>>>
>>> diffstat:
>>>  drivers/char/ipmi/Kconfig         |    3 ++-
>>>  drivers/clk/Kconfig               |    2 +-
>>>  drivers/gpio/Kconfig              |    2 +-
>>>  drivers/leds/Kconfig              |    2 +-
>>>  drivers/platform/mellanox/Kconfig |    9 ++++-----
>>>  drivers/platform/x86/Kconfig      |    3 ++-
>>>  drivers/thermal/intel/Kconfig     |    3 ++-
>>>  drivers/tty/serial/8250/Kconfig   |    3 ++-
>>>  8 files changed, 15 insertions(+), 12 deletions(-)
>>>
>>> Cc: Andrew Jeffery <andrew@aj.id.au>
>>> Cc: Corey Minyard <minyard@acm.org>
>>> Cc: openipmi-developer@lists.sourceforge.net
>>> Cc: Arnd Bergmann <arnd@arndb.de>
>>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>>> Cc: Riku Voipio <riku.voipio@linaro.org>
>>> Cc: Stephen Boyd <sboyd@kernel.org>
>>> Cc: Michael Turquette <mturquette@baylibre.com>
>>> Cc: linux-clk@vger.kernel.org
>>> Cc: Michael Walle <michael@walle.cc>
>>> Cc: Linus Walleij <linus.walleij@linaro.org>
>>> Cc: Bartosz Golaszewski <brgl@bgdev.pl>
>>> Cc: linux-gpio@vger.kernel.org
>>> Cc: Dan Murphy <dmurphy@ti.com>
>>> Cc: Pavel Machek <pavel@ucw.cz>
>>> Cc: Jacek Anaszewski <jacek.anaszewski@gmail.com>
>>> Cc: Lee Jones <lee@kernel.org>
>>> Cc: linux-leds@vger.kernel.org
>>> Cc: Darren Hart <dvhart@infradead.org>
>>> Cc: Hans de Goede <hdegoede@redhat.com>
>>> Cc: Michael Shych <michaelsh@nvidia.com>
>>> Cc: Mark Gross <markgross@kernel.org>
>>> Cc: Vadim Pasternak <vadimp@nvidia.com>
>>> Cc: platform-driver-x86@vger.kernel.org
>>> Cc: Yegnesh S Iyer <yegnesh.s.iyer@intel.com>
>>> Cc: Bin Gao <bin.gao@intel.com>
>>> Cc: Zhang Rui <rui.zhang@intel.com>
>>> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
>>> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
>>> Cc: Amit Kucheria <amitk@kernel.org>
>>> Cc: linux-pm@vger.kernel.org
>>> Cc: Oskar Senft <osk@google.com>
>>> Cc: linux-serial@vger.kernel.org
>>>
>>
> 


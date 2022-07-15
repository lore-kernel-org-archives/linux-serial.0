Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED0D8C433EF
	for <linux-serial@archiver.kernel.org>; Fri, 15 Jul 2022 02:41:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240885AbiGOClG (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 14 Jul 2022 22:41:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229984AbiGOClF (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 14 Jul 2022 22:41:05 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4C1C75391
        for <linux-serial@vger.kernel.org>; Thu, 14 Jul 2022 19:41:04 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id s27so3210916pga.13
        for <linux-serial@vger.kernel.org>; Thu, 14 Jul 2022 19:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=j0LkY7V697d3ZVo5WxziZUxKlyEGG8e7be+I9q1UHZc=;
        b=HfNLipGrzytDB935p8bmqPON5CCDTAZMyAiAxewGU+bb/fGa4ILTdeVF+rsA4E81LY
         EA6isllOd40wVpZ6xg1LL2AajDouAQ33p+qW7Q/SvFeC4F1lghs54MRqNaZJCUEXCBYq
         UxtT/gqB7umL6Xt45HXp9mgQVZ1RnwCbB6mgmRnncSJAnapzo5xyLzkVCAXjbZkq8eJh
         LgkuOBU2P0vbzdH66t0uxhDFM2YbmWZjOl/mtrkcJp4QH7Y7xs2klWo16ZL2TiS5SS4T
         ymjvoAo0UjNRMW+A4929mxUHchP/jUvtFFPq1Xh3iH3mtcF5wHmMIehpW7SSxNWC02jg
         LsFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=j0LkY7V697d3ZVo5WxziZUxKlyEGG8e7be+I9q1UHZc=;
        b=vuPWftet/Ng1eGzb4CsnhwRJObHTqfNTu9IJpXgw4BwJpfG3msYgknJh03KtfmN4Wf
         34KTczulb3pzASnorU+xBlWH70rxRUlmWVayZ9gD4sgzbfV6vQ3W6gXIHTcO4DXSFwiM
         phbaA6E3cWlrywUO4/ZoBS0Fzk5jjm/G3bnoRFSwNwO60BVgglP83XanOm4WB4k1YleD
         y/+6xwMfyix10s2mHc4K5s4nUvDsRmlINXwrq324jZEMrydMY3HhnsIyHss9Wdf0Zg0n
         xBahoy17J1/+Lkz0/DhHIhyisXGjCBzYrV9eV46o5Z6VkXlaLD4eFaQLRh+flO69xFdi
         msSQ==
X-Gm-Message-State: AJIora+OF40k/RhX73RAnpG562a/NhAG4NnCEHeTi3lM4yxCaE9IAKME
        2XmUNOLh6WIp3XCuwVB+F2s=
X-Google-Smtp-Source: AGRyM1tO2r9TY0BZlwAeQKSbwkOO9lVL+SsDXgiA7s/1gDBB1Hm5KsYfHtWLb0kGfqWH37Va1WZoBg==
X-Received: by 2002:aa7:94b3:0:b0:52a:198a:e3cb with SMTP id a19-20020aa794b3000000b0052a198ae3cbmr11363086pfl.60.1657852864219;
        Thu, 14 Jul 2022 19:41:04 -0700 (PDT)
Received: from [192.168.1.3] (ip72-194-116-95.oc.oc.cox.net. [72.194.116.95])
        by smtp.gmail.com with ESMTPSA id v188-20020a622fc5000000b0052ab0a73752sm2409633pfv.198.2022.07.14.19.41.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Jul 2022 19:41:03 -0700 (PDT)
Message-ID: <5c4ddf6d-3f6c-b64e-5503-0f8cad4a9364@gmail.com>
Date:   Thu, 14 Jul 2022 19:41:02 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0.2
Subject: Re: [PATCH -next v3] serial: 8250_bcm2835aux: Add missing
 clk_disable_unprepare()
Content-Language: en-US
To:     Guo Mengqi <guomengqi3@huawei.com>, gregkh@linuxfoundation.org
Cc:     jirislaby@kernel.org, ilpo.jarvinen@linux.intel.com,
        athierry@redhat.com, linux-serial@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, xuqiang36@huawei.com
References: <7c4eaa8e-2812-b805-c81b-9964a5cb6b52@huawei.com>
 <20220715023312.37808-1-guomengqi3@huawei.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20220715023312.37808-1-guomengqi3@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org



On 7/14/2022 7:33 PM, Guo Mengqi wrote:
> The error path when get clock frequency fails in bcm2835aux_serial
> driver does not correctly disable the clock.
> 
> This flaw was found using a static analysis tool "Hulk Robot", which
> reported the following warning when analyzing linux-next/master:
> 
>      drivers/tty/serial/8250/8250_bcm2835aux.c:
>      warning: clk_disable_unprepare_missing.cocci
> 
> The cocci script checks for the existence of clk_disable_unprepare()
> paired with clk_prepare_enable().
> 
> Add the missing clk_disable_unprepare() to the error path.
> 
> Fixes: fcc446c8aa63 ("serial: 8250_bcm2835aux: Add ACPI support")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Guo Mengqi <guomengqi3@huawei.com>

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian

Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89958C4332F
	for <linux-serial@archiver.kernel.org>; Wed,  9 Nov 2022 18:38:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbiKISiY (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 9 Nov 2022 13:38:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbiKISiX (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 9 Nov 2022 13:38:23 -0500
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A384D42
        for <linux-serial@vger.kernel.org>; Wed,  9 Nov 2022 10:38:22 -0800 (PST)
Received: by mail-qt1-x834.google.com with SMTP id a27so10851648qtw.10
        for <linux-serial@vger.kernel.org>; Wed, 09 Nov 2022 10:38:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pUzdzgOMIz4xlQPPVaHYr83ZUWID1ld+9RYoGNyvuj4=;
        b=N7EcyrfqMnT7nC91AZ/DLR1pgI/LrYQjvX/3WzoWz8Z49zOfDfr//VepDRRaEoRPAW
         /h+02/ZDCEwvUq4YTbDKuHolMQfIiKlPc+R5ckaWJ4UXg3xItdhBbJpZrAkSygUlXtTt
         3z7ImQHoODKCHBJo/JPPTs/E5OJgtbyc3TiGPJRDBCkFVfikFhU5NBx1pKJKYSrA+3+7
         YFn7HAKV04TJJ0pA/ibpqN3NhsV8EB6yRS/3kxJxL9ul2rXFRfZg60MXy6ei5mTJdddA
         Pl/kzxy8hSM3hUM5O7QPKArXobVhDQiOH37jh7UI3Kx83E9bYTG3FG0RlYjlL43IXg2/
         HAUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pUzdzgOMIz4xlQPPVaHYr83ZUWID1ld+9RYoGNyvuj4=;
        b=E8eeRG2+cQ00GxH8+Ch+HDRc3YB/yLUJ9bWtgaRbtwZABQYmokE912937AF2m4Fusc
         E0gyhxRLfAK4v4nvi23gPZg7P0WQRYvG0J5FP05nu6lNMb3ARXzDL+cX/iMwMGAk9LDW
         4Ces6cnKSNr2kGM5TtpyHAjq48kpAiNCdPI9aBIhclFN35Vx0mi6PuSlWGXXN/18BqOR
         ycy/DtFpocOVDBPLfptlG6EfjJfH2P0/9rZm3sUqI4Zub0o36XcLBh20d+Wi8ulD0j8Q
         I/AwlQkcU/AHq6+K1W3UVvN5nywHvs32hZRlmZO4ATqi77foomiPQ2lNLeWt3UqvH8zb
         CZEQ==
X-Gm-Message-State: ACrzQf3/Lc6xLcXgzQlUmwP6r12na2DMGvnNEPhkIe0AFpVy5dEvGADS
        Uhgx655WGb3LJypaR5+xqUQ=
X-Google-Smtp-Source: AMsMyM5l8wPCGikt7ZzWQ5fjPZ5zngvhfZuq+7DJ8a86pPDIvvpmqwHmk2JC91kLbWSFKYwFfWfhJw==
X-Received: by 2002:a05:622a:248c:b0:3a5:15f9:57a5 with SMTP id cn12-20020a05622a248c00b003a515f957a5mr46543912qtb.48.1668019101076;
        Wed, 09 Nov 2022 10:38:21 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id q3-20020a05620a2a4300b006eed47a1a1esm11438990qkp.134.2022.11.09.10.38.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Nov 2022 10:38:20 -0800 (PST)
Message-ID: <a48dffd6-821d-f818-1bdf-f1b841fa189a@gmail.com>
Date:   Wed, 9 Nov 2022 10:38:16 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH] serial: 8250_bcm7271: Fix error handling in
 brcmuart_init()
Content-Language: en-US
To:     Yuan Can <yuancan@huawei.com>, alcooperx@gmail.com,
        bcm-kernel-feedback-list@broadcom.com, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, linux-serial@vger.kernel.org
References: <20221109072110.117291-1-yuancan@huawei.com>
 <20221109072110.117291-2-yuancan@huawei.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20221109072110.117291-2-yuancan@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 11/8/22 23:21, 'Yuan Can' via BCM-KERNEL-FEEDBACK-LIST,PDL wrote:
> A problem about 8250_bcm7271 create debugfs failed is triggered with the
> following log given:
> 
>   [  324.516635] debugfs: Directory 'bcm7271-uart' with parent '/' already present!
> 
> The reason is that brcmuart_init() returns platform_driver_register()
> directly without checking its return value, if platform_driver_register()
> failed, it returns without destroy the newly created debugfs, resulting
> the debugfs of 8250_bcm7271 can never be created later.
> 
>   brcmuart_init()
>     debugfs_create_dir() # create debugfs directory
>     platform_driver_register()
>       driver_register()
>         bus_add_driver()
>           priv = kzalloc(...) # OOM happened
>     # return without destroy debugfs directory
> 
> Fix by removing debugfs when platform_driver_register() returns error.
> 
> Fixes: 41a469482de2 ("serial: 8250: Add new 8250-core based Broadcom STB driver")
> Signed-off-by: Yuan Can <yuancan@huawei.com>

Acked-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian


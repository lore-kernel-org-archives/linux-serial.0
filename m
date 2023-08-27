Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C11CC83F01
	for <linux-serial@archiver.kernel.org>; Sun, 27 Aug 2023 09:49:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230344AbjH0Jsu (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sun, 27 Aug 2023 05:48:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230255AbjH0Jsm (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sun, 27 Aug 2023 05:48:42 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A5E010A
        for <linux-serial@vger.kernel.org>; Sun, 27 Aug 2023 02:48:40 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-313e742a787so1409182f8f.1
        for <linux-serial@vger.kernel.org>; Sun, 27 Aug 2023 02:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693129719; x=1693734519;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SJNNVgrRVQL7c5pbhPjz9Gf5Pj28bPWzD3qJ9aTL+/s=;
        b=JzIlOcyLne6Uoo2jYZndhS99aWgxnSff5fBa6kvwc/CnQz5B6DeXLELiqhd7D+tOqf
         AR/ZoyMGc5CYHTUPKwWm69Z6A/IdGW3xJcWXRVHvtxp5HrfWTdraak9BiK/YmsuX7gUY
         b7z2q6qQh60Nsk/W8SzTGKa9CR4Aqdri714oDGMNyxNyvF4puSUawnmWrOfbUdR04hGn
         si0bJ64ZEKavhgn+l3VV/V8qDkLcpeHGl5wLJXT3emNQKd9Zv74Ynzp6Emh5C2UhAHhC
         drz9BQJ6je4pZenQGLharWJVEonrjSYxmKuPCSywhNtutE/U+tnxQtG4VJCSBS+g7jV4
         UyNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693129719; x=1693734519;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SJNNVgrRVQL7c5pbhPjz9Gf5Pj28bPWzD3qJ9aTL+/s=;
        b=Gtg0Zq4QCgWMTRlFiVRaOi06xNu+tUXAnOAVrf7418rHrqKsexkWCjCaXJYKsGjn94
         oTy9PkFBKc+SFuwgTs1t2TU2vGBrHZ2fVMgKgRVioOvAvRJn4CsmrNYb/IuDjZJ+d3Vd
         zDl4xB2jKsAGABylkR9AS+1NJQfe6mOF08nJzKIZkzvzSstxc4V0rMdfHg5Hzyw3dsg/
         WZQmgYQ6A568lGLWfhtn1Ilf7IiAIijU7hc4Ov47tapwcCOh6kphJeCkBYBfuxs6OXkP
         RFg0ACwEugVIgTPKpuOn1iS2cnVW1CUqdvdBSy+Zkocq9pGmYTndWrQL0CZFICMDzAnQ
         9IdQ==
X-Gm-Message-State: AOJu0YxyXVhFS09mPkECiZqKSeeaScPdOn9HBiqhBx6IDi4u80i2ZGTL
        V7FdjqoRj4r6QOwsRWaVUGS9Lw==
X-Google-Smtp-Source: AGHT+IFyYSVmg96H/v92sjJ+IDfGQO6CLmaJ2hV7K5fhbi7+XHiRFVoEDfb2YLomtTbo92BK2A9i8g==
X-Received: by 2002:a5d:4ac2:0:b0:319:70c8:6e90 with SMTP id y2-20020a5d4ac2000000b0031970c86e90mr16793479wrs.24.1693129718694;
        Sun, 27 Aug 2023 02:48:38 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:8865:2133:756f:b886? ([2a01:e0a:982:cbb0:8865:2133:756f:b886])
        by smtp.gmail.com with ESMTPSA id b7-20020a05600c11c700b003fbb25da65bsm7343975wmi.30.2023.08.27.02.48.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Aug 2023 02:48:38 -0700 (PDT)
Message-ID: <7bf9e716-0ff2-56d5-07ab-db027901454e@linaro.org>
Date:   Sun, 27 Aug 2023 11:48:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH v2] Revert "tty: serial: meson: Add a earlycon for the T7
 SoC"
Content-Language: en-GB
To:     Lucas Tanure <tanure@linux.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>
Cc:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org
References: <20230827082944.5100-1-tanure@linux.com>
From:   Neil Armstrong <neil.armstrong@linaro.org>
In-Reply-To: <20230827082944.5100-1-tanure@linux.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi Lucas,

Le 27/08/2023 à 10:29, Lucas Tanure a écrit :
> This reverts commit 6a4197f9763325043abf7690a21124a9facbf52e.
> New SoC will use ttyS0 instead of ttyAML, so T7 SoC doesn't need a OF_EARLYCON_DECLARE.
> 
> Signed-off-by: Lucas Tanure <tanure@linux.com>
> ---
> Since V1:
> - add Signed-off-by:
> 
>   drivers/tty/serial/meson_uart.c | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/tty/serial/meson_uart.c b/drivers/tty/serial/meson_uart.c
> index c4f61d82fb727..790d910dafa5d 100644
> --- a/drivers/tty/serial/meson_uart.c
> +++ b/drivers/tty/serial/meson_uart.c
> @@ -648,8 +648,6 @@ meson_serial_early_console_setup(struct earlycon_device *device, const char *opt
>   
>   OF_EARLYCON_DECLARE(meson, "amlogic,meson-ao-uart",
>   		    meson_serial_early_console_setup);
> -OF_EARLYCON_DECLARE(meson, "amlogic,t7-uart",
> -		    meson_serial_early_console_setup);
>   
>   #define MESON_SERIAL_CONSOLE_PTR(_devname) (&meson_serial_console_##_devname)
>   #else

How do you use earlycon with this removed ?

Neil

Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA9ACC433B4
	for <linux-serial@archiver.kernel.org>; Mon, 26 Apr 2021 14:12:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A82306127A
	for <linux-serial@archiver.kernel.org>; Mon, 26 Apr 2021 14:12:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233693AbhDZON1 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 26 Apr 2021 10:13:27 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:52998 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230250AbhDZON1 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 26 Apr 2021 10:13:27 -0400
Received: from mail-ed1-f69.google.com ([209.85.208.69])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lb1yf-0007Jz-46
        for linux-serial@vger.kernel.org; Mon, 26 Apr 2021 14:12:45 +0000
Received: by mail-ed1-f69.google.com with SMTP id i2-20020a0564020542b02903875c5e7a00so3699719edx.6
        for <linux-serial@vger.kernel.org>; Mon, 26 Apr 2021 07:12:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CQkRFQ6Y0bHYJBnErjBTEh/3f5vNzlcUccgnU7weOHE=;
        b=QF3R+OKWD+gs2eGryh4HqE8uyOEe0CFK3IGGnKO0l5f8SBd0RnchCCPSk2iZhmpP1O
         EglyhlP0zIxc1uAAXYFQWyN6tglbDmV28/feq95CdGg7XdTX+p3uDem/U1yQk7Ok/pSl
         VUa1XzFMc4L0ZcS8RDLVlRN9Gw9Y79a9TkICGlBWMPjFiofaw2AORcfuMVhwK9c+fuV9
         3rNYDkD0n1LZzDS78Xsn/PkMGcpHq/RIK36z1/74FU9OOsHQ0JgVHNkSWFguw0ExcFqL
         XWRQfk4Fhz+R9LMT3llQ4a2v3P/hyh66P9XWu9HHsz4Hol18xfCBv6IG1DtyZVYImKV/
         OdhA==
X-Gm-Message-State: AOAM532xxQwjIc20IjR+iks3CDE0CHghXxaZtL6HJMyIQzXMY79F2v/s
        64LfGqgOXI6xHaPTuph7FXGTNCvlDoc0j1bONB8osuajggOkeTGG+C3SkKvejDaC6lHG+9uDVER
        SboLBU4nMYTdugKe0rQibk19rk6vCzyYnxZqH3bsw8g==
X-Received: by 2002:a05:6402:453:: with SMTP id p19mr21229251edw.88.1619446364481;
        Mon, 26 Apr 2021 07:12:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy0G/5IlEi3Qqw47a4bcxAUt3AKWr7PBSa5H/Wt9JXmfed8LWOMXdmYvG7vsv9ZXG1sgic6ag==
X-Received: by 2002:a05:6402:453:: with SMTP id p19mr21229236edw.88.1619446364384;
        Mon, 26 Apr 2021 07:12:44 -0700 (PDT)
Received: from [192.168.1.115] (xdsl-188-155-180-75.adslplus.ch. [188.155.180.75])
        by smtp.gmail.com with ESMTPSA id mt26sm5810273ejc.32.2021.04.26.07.12.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Apr 2021 07:12:43 -0700 (PDT)
Subject: Re: [PATCH v2] tty: serial: samsung_tty: remove set but not used
 variables
To:     Tian Tao <tiantao6@hisilicon.com>, gregkh@linuxfoundation.org,
        jirislaby@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org
References: <1619443135-21399-1-git-send-email-tiantao6@hisilicon.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <ff816f12-c9fc-94bd-52a7-1d1b1c9a49de@canonical.com>
Date:   Mon, 26 Apr 2021 16:12:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <1619443135-21399-1-git-send-email-tiantao6@hisilicon.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 26/04/2021 15:18, Tian Tao wrote:
> The value of 'ret' is not used which reported by svace, so jutst return

s/jutst/just/


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>

> instead of break.
> 
> Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
> ---
> v2: s3c24xx_serial_probe function exit than convert ret to some default
> value when the attribute "reg-io-width" is not 1 or 4.
> ---
>  drivers/tty/serial/samsung_tty.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)



Best regards,
Krzysztof

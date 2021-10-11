Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59319C4332F
	for <linux-serial@archiver.kernel.org>; Mon, 11 Oct 2021 06:48:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 445D060F14
	for <linux-serial@archiver.kernel.org>; Mon, 11 Oct 2021 06:48:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234383AbhJKGuw (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 11 Oct 2021 02:50:52 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:42498
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234353AbhJKGuw (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 11 Oct 2021 02:50:52 -0400
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com [209.85.208.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 1C4B33FFF7
        for <linux-serial@vger.kernel.org>; Mon, 11 Oct 2021 06:48:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1633934932;
        bh=CPA7uzjIObwjcajWBp0XF7TZaxKa4ak20yBxoc8Joug=;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
         In-Reply-To:Content-Type;
        b=MkykPJDj/DYG4OTj/BwQU1gFnE6thWWV85pkqFG/bov02wiHiZctqzrvE3Rzb0j90
         fqNyLd91xCOeki8lXeyIcC91YZ5Wmx2erb+hVtys3LEYay3Te1mwMkELrexJ0iMxUK
         NrvTLfUCNqsazgDMygdIjkluosJ7anxJjmmPiWXlq2MVHFC40KmTh6XKbF+jFa1ZkN
         8Oy7OQb/p44boeMwZZB4KR0oZL422RzzQPliXjbdyZaBduPnQinbTd8WEdOD1+z1Fp
         nzpm3cdxiYiN/UjiaNnBEQUiHpL0gf8MyyBde0ecZ2SynhGFi3XMh5p0Neifeoz61n
         IePnmCIKlBM7g==
Received: by mail-ed1-f72.google.com with SMTP id d3-20020a056402516300b003db863a248eso2941780ede.16
        for <linux-serial@vger.kernel.org>; Sun, 10 Oct 2021 23:48:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CPA7uzjIObwjcajWBp0XF7TZaxKa4ak20yBxoc8Joug=;
        b=ykot7ktuBPSap39fBecu6nMi34k6HS311etnSCee4Iqgh0RR4987bTCDl4hn3PlOl6
         ht8BlpRpg7q4dzaMJRXvvsXu1VET0jcBBqh+x1RYumJUEAEB7DP4mNR5eTKAqqnDDhEF
         HZlu3+c/cCy/CHrWtIOmA/msxcxXOkWLzhjZltjgUMzHSoh96pcMCtWxVTALeIueSLS8
         stC4tLulhV0tbJWxxuez64oWXlgX8J1oJ+YpoaCzUPE0tN732HqWKEmRDjp42dLvxuhI
         VJ77hXir4TOl5Vj/Thne4dIlO+/ITAmLv1U+GjYlIPgLM7SNoPDUkESLu8a52We3Oi/V
         iyhw==
X-Gm-Message-State: AOAM5301QOa8YzTLvOdS6GK7CcpaNLkBF/6eStgVN7uTlFTKhRm/9uOH
        dIkf0aYcac13oskIvCQHIVEkbLrLlfUkuSOTCXoXffNGeQPvleYfCpYeMKDycOYB6HATsNsM3yn
        ubmTiYao4UJI2EMD/bLpRHgkq34A7EqEIHWvij6aSYw==
X-Received: by 2002:a17:906:b803:: with SMTP id dv3mr23882247ejb.289.1633934931379;
        Sun, 10 Oct 2021 23:48:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwuxCqjNMs6Kw57A47X/e54HeKbkQEUbux8m9ZH97PAe0Joxy5ueBHUew3edGYZnzAXBEw19Q==
X-Received: by 2002:a17:906:b803:: with SMTP id dv3mr23882218ejb.289.1633934931167;
        Sun, 10 Oct 2021 23:48:51 -0700 (PDT)
Received: from [192.168.0.20] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id ox9sm2943850ejb.66.2021.10.10.23.48.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 Oct 2021 23:48:50 -0700 (PDT)
Subject: Re: [PATCH 6/7] tty: serial: samsung_tty: Support runtime PM
To:     Hector Martin <marcan@marcan.st>,
        linux-arm-kernel@lists.infradead.org
Cc:     Marc Zyngier <maz@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-serial@vger.kernel.org
References: <20211005155923.173399-1-marcan@marcan.st>
 <20211005155923.173399-7-marcan@marcan.st>
 <77ae3bb1-6da5-3ec6-de33-5e5f661b6145@canonical.com>
 <46109820-904b-4e87-5134-7d045dbbe57e@marcan.st>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <b4aa2023-238a-7929-fd1b-3a2aa0b49b6c@canonical.com>
Date:   Mon, 11 Oct 2021 08:48:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <46109820-904b-4e87-5134-7d045dbbe57e@marcan.st>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 11/10/2021 07:32, Hector Martin wrote:
>>> +
>>>   		s3c24xx_serial_cpufreq_deregister(to_ourport(port));
>>>   		uart_remove_one_port(&s3c24xx_uart_drv, port);
>>> +
>>> +		pm_runtime_disable(&dev->dev);
>>
>> Why disabling it only if port!=NULL? Can remove() be called if
>> platform_set_drvdata() was not?
> 
> Good question, I'm not entirely sure why these code paths have a check 
> for NULL there. They were already there, do you happen to know why? To 
> me it sounds like remove would only be called if probe succeeds, at 
> which point drvdata should always be set.
> 

Exactly, anyway it is not part of your patch, so no problem.


Best regards,
Krzysztof

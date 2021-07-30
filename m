Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09200C4320A
	for <linux-serial@archiver.kernel.org>; Fri, 30 Jul 2021 15:25:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E5A0060F94
	for <linux-serial@archiver.kernel.org>; Fri, 30 Jul 2021 15:25:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239750AbhG3PZ4 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 30 Jul 2021 11:25:56 -0400
Received: from smtp-relay-canonical-0.canonical.com ([185.125.188.120]:47460
        "EHLO smtp-relay-canonical-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239617AbhG3PZz (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 30 Jul 2021 11:25:55 -0400
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com [209.85.218.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPS id 4121D3F23F
        for <linux-serial@vger.kernel.org>; Fri, 30 Jul 2021 15:25:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1627658750;
        bh=TEvW673M4tlEqNAgqaz/ijFkYi/5QPh9cKHdp/b4gIY=;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
         In-Reply-To:Content-Type;
        b=baZEUwngcHyAHS4V7Yqt7xT42QJ8ttOg1JZS9OtxIQODGSAvwowuVmWJpBzsorYEj
         la/oYC4QiLgwvFHTdIrE0P8qSmMLb22JAoOGzjcX+HXSUbywt/NhOz8ioVGoyt2LfV
         jHrLOC7aAE4DIOrqndPexGgTz9RuBqmRWF/zKgTXYLZRN0ZELD7yIBzTDiQtMsX662
         U0+IQQo/KO7z0PtXCRFEuDJyzxk73DbM88kbQ42EoM8npG3xWdCa+5FLuw0n8N4rDh
         1BJ9zfhl5WXd/YIN5YVvmr0UNuyRFp/tM+FwGAlOuEEK35aJ9eMrx87x4vZkTzWE6B
         /BMLjaRtf90kg==
Received: by mail-ej1-f70.google.com with SMTP id x5-20020a1709064bc5b02905305454f5d1so3201120ejv.10
        for <linux-serial@vger.kernel.org>; Fri, 30 Jul 2021 08:25:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TEvW673M4tlEqNAgqaz/ijFkYi/5QPh9cKHdp/b4gIY=;
        b=rdF84W2pa30JoRWD0biFesndwrJwy7MXZfawOTMqNIHGmrOcSAFT+KDum0iUiZtzpU
         9hxF5jRpIoy0Pgh31GneAdhdO5GVWFx5/GmeoGS7h9AJZYZxqQmHMEM/9rteqfpd615h
         bEXEbkXzcujtResi5VtmyOY0ggtYl52QkzgoMQFSWAv3FWxpU7HN0lyGOafYvBaAG3nM
         kdouatRC5MPbK2xsxCjNbyA/l/iZJHWqAWbP/8wQYZJgJZhwyjW4ARQFqTgiQw/N4ESz
         /duUzNylCoPU9uCDjrFcv/qFYlXTQDzdABDvmMTbnAIdb/KZslQtaowTqlrrqRCiFwrX
         +RsA==
X-Gm-Message-State: AOAM531vL7b9XZLG3rolYbBdb/rrnWuXP4Hi6JvvFTZn+KP83xO6VuoU
        g5w46yJwtKr6rwzSrFoWmG7H/tuo3vJDxlYX6QxzjHivqYUu9pCTSxqbfaIJhvfarR2d/63cL0n
        Lk9tN+9Zm8MReb1clFDGfnI1SlJuKtqpt6qSZSq1q6Q==
X-Received: by 2002:a17:906:2d51:: with SMTP id e17mr3031154eji.500.1627658749656;
        Fri, 30 Jul 2021 08:25:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzGrmbK76jzm7R0wU9rDjzOLSuvi09IncVRLsAPOuK8inPZj/nU5vtfrdytg3IgHkG0o3Lyzw==
X-Received: by 2002:a17:906:2d51:: with SMTP id e17mr3031123eji.500.1627658749527;
        Fri, 30 Jul 2021 08:25:49 -0700 (PDT)
Received: from [192.168.8.102] ([86.32.47.9])
        by smtp.gmail.com with ESMTPSA id p16sm826354eds.73.2021.07.30.08.25.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Jul 2021 08:25:49 -0700 (PDT)
Subject: Re: [PATCH 08/12] MAINTAINERS: Cover Samsung clock YAML bindings
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Sam Protsenko <semen.protsenko@linaro.org>
Cc:     Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Charles Keepax <ckeepax@opensource.wolfsonmicro.com>,
        Ryu Euiyoul <ryu.real@samsung.com>,
        Tom Gall <tom.gall@linaro.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        John Stultz <john.stultz@linaro.org>,
        Amit Pundir <amit.pundir@linaro.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Samsung SOC <linux-samsung-soc@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>
References: <20210730144922.29111-1-semen.protsenko@linaro.org>
 <20210730144922.29111-9-semen.protsenko@linaro.org>
 <CAHp75VcugLnV6D8xhkMHuW-X6LCtHDDnghD2G+vqwYmRvFP9Nw@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <8202e9f9-06f4-f1ba-4f30-e1a0c8340450@canonical.com>
Date:   Fri, 30 Jul 2021 17:25:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAHp75VcugLnV6D8xhkMHuW-X6LCtHDDnghD2G+vqwYmRvFP9Nw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 30/07/2021 17:06, Andy Shevchenko wrote:
> On Fri, Jul 30, 2021 at 5:50 PM Sam Protsenko
> <semen.protsenko@linaro.org> wrote:
>>
>> New device tree bindings are usually added in YAML format. Fix "SAMSUNG
>> SOC CLOCK DRIVERS" entry to cover both txt and yaml docs for Exynos
>> clock drivers.
> 
> Fixes tag?

No need because the pattern is correct at the moment. The patch does not
make sense on its own and should be squashed with the next one.


Best regards,
Krzysztof

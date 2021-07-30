Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BA0FC432BE
	for <linux-serial@archiver.kernel.org>; Fri, 30 Jul 2021 15:18:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F37360EFE
	for <linux-serial@archiver.kernel.org>; Fri, 30 Jul 2021 15:18:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239618AbhG3PSx (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 30 Jul 2021 11:18:53 -0400
Received: from smtp-relay-canonical-1.canonical.com ([185.125.188.121]:35166
        "EHLO smtp-relay-canonical-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239509AbhG3PSw (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 30 Jul 2021 11:18:52 -0400
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com [209.85.208.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPS id C83BD3F251
        for <linux-serial@vger.kernel.org>; Fri, 30 Jul 2021 15:18:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1627658326;
        bh=uQz9tULPCu5UgY3Ykcp4Ot2UDuSXdhe8Cf5AChsFwuk=;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
         In-Reply-To:Content-Type;
        b=bGggyeAsHZoe99MUNqYYPyGTi8QMtb0yCvsD9bAAZ/Fr8LMUYIx8QrjuvDrjqQwKF
         4Z4l7Mdo3XEHJyud6uhVFXIKZoBe4oZ0eY9kwIRg1PyNyvb54QqQrsor9Q9YOJM2OP
         YTS43aHA1sNay/hbtdPUId5HbnW6tqQ32ZhRgzUAaW/k15tpMjpgSA5llqYEIwWtmM
         ReaiX4TxzMw2HcWmPMM0XzB0Yf1HnK4JOISkWdv0cRRr2cA0QlErgnhYlJ5B+g+5zT
         foFIqteMe8eQC/6hlTJYXzhIKM/gL59j8YprrSK08FKNADfv2MfU3JbptKNjDWGPcp
         NMbFtzkS2RhzA==
Received: by mail-ed1-f72.google.com with SMTP id x1-20020a05640218c1b02903bc7f97f858so3166985edy.2
        for <linux-serial@vger.kernel.org>; Fri, 30 Jul 2021 08:18:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uQz9tULPCu5UgY3Ykcp4Ot2UDuSXdhe8Cf5AChsFwuk=;
        b=mLEpCkD8ZqUP4taTXQuD3+3MFMKeCL6dc3QO+ZaWmmOL4mcOY8As8R5iIQQbgve7cw
         n/vbibPtNd49/C2Ssguq+Y5cYHtPitBEwXQqPqYGFSMYVpTSvntgagyS9iqHH4FxOzly
         nDdlEZA3B0iuSe32ZwBkIboku3Y2Pnep5PFs6mv+hztlsIdnQLgpwneSau7FQ658MXmZ
         9AccYtIsFFpcpYIyDv43pRGKE8B8K3eApElVVQlWOAwCFt1TROuo2cIvhc0zpPUK7MVv
         SOEw6bEC0kAfGlx2M56ugAfEQN0qn7103U8ZZeBTmsFneYq8ppvmgFufOCGQfIEUZQyT
         iIbw==
X-Gm-Message-State: AOAM530uQhxh9MUUOVG7cPEWPOEwqmzdVgzg4z8ET//Sm025yAmANDlp
        pbWZusf9sQwoWO+Ii9nCPmSBOTHrhb4wW+UytMhqQELE4vCtuL4iV0pYbPRT+NN/7kAxrUCST1L
        PRyWOSS11OOo2DqA48laYiFX+NZ081qCzy8NhwF1Frg==
X-Received: by 2002:a05:6402:3192:: with SMTP id di18mr3654251edb.186.1627658326387;
        Fri, 30 Jul 2021 08:18:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxSu7DW5+j3BhrkN5cwojsD8uD94ncil0rrItmiexSqoVvOVwhkjvCksZc4ftgx6K7DzkIA9A==
X-Received: by 2002:a05:6402:3192:: with SMTP id di18mr3654233edb.186.1627658326270;
        Fri, 30 Jul 2021 08:18:46 -0700 (PDT)
Received: from [192.168.8.102] ([86.32.47.9])
        by smtp.gmail.com with ESMTPSA id f15sm824270edd.54.2021.07.30.08.18.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Jul 2021 08:18:45 -0700 (PDT)
Subject: Re: [PATCH 00/12] Add minimal support for Exynos850 SoC
To:     Sam Protsenko <semen.protsenko@linaro.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Tomasz Figa <tomasz.figa@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Charles Keepax <ckeepax@opensource.wolfsonmicro.com>,
        Ryu Euiyoul <ryu.real@samsung.com>,
        Tom Gall <tom.gall@linaro.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        John Stultz <john.stultz@linaro.org>,
        Amit Pundir <amit.pundir@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-serial@vger.kernel.org
References: <20210730144922.29111-1-semen.protsenko@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <5e35b0a7-13aa-3c62-ca49-14af2fcb2a08@canonical.com>
Date:   Fri, 30 Jul 2021 17:18:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210730144922.29111-1-semen.protsenko@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 30/07/2021 16:49, Sam Protsenko wrote:
> This patch series adds initial platform support for Samsung Exynos850
> SoC [1]. With this patchset it's possible to run the kernel with BusyBox
> rootfs as a RAM disk. More advanced platform support (like MMC driver
> additions) will be added later. The idea is to keep the first submission
> minimal to ease the review, and then build up on top of that.
> 
> [1] https://www.samsung.com/semiconductor/minisite/exynos/products/mobileprocessor/exynos-850/
> 

Great work!

What's the SoC revision number (should be accessible via
/sys/bus/soc/devices/soc0/)? Recent wrap in numbering of Exynos chips
might bring confusion...


Best regards,
Krzysztof

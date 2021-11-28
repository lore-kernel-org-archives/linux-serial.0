Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 027F3C433EF
	for <linux-serial@archiver.kernel.org>; Sun, 28 Nov 2021 17:06:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358619AbhK1RJS (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Sun, 28 Nov 2021 12:09:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358704AbhK1RHS (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sun, 28 Nov 2021 12:07:18 -0500
Received: from mail-vk1-xa29.google.com (mail-vk1-xa29.google.com [IPv6:2607:f8b0:4864:20::a29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C7A1C0613F6
        for <linux-serial@vger.kernel.org>; Sun, 28 Nov 2021 09:03:17 -0800 (PST)
Received: by mail-vk1-xa29.google.com with SMTP id h1so2171377vkh.0
        for <linux-serial@vger.kernel.org>; Sun, 28 Nov 2021 09:03:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BY3oht+y8HrGDIiA0mto2rflEOHEoMX+CLpzHXZf2nA=;
        b=isEtZ0KqXs7KwQiyrUe6920AusXIYyZ3lAycqrX8wlYMxZzrktdUryhup02VI1Fc9m
         6RbwZfK5VEwmxi4UjWRmZWbt303aROEHrxkJJaNuODRMse9Ohe1/XfcUA2kKvpqE/UhR
         RbvvxfS7z6qb3X5YjlkfRE/T60Xju+cO7p9YyQj6EXdMEqvWjpSSGjY7+8CraHpfL2aA
         ffanPd/1CCgvM5Qlb7yHtQ4jsRvgFbvogD1YtoQrtwx8TwfczmVqEphgtQg/Mw4op13n
         xhf2K4LG1zddQ8cTqaUD7GGqrYRoeY6Irx5UZc4QfFAbdWaoCrgQ8/GT2dQ3C6PBrKqL
         g4bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BY3oht+y8HrGDIiA0mto2rflEOHEoMX+CLpzHXZf2nA=;
        b=UqJhGpz+BvSxfLEIgl0K9zbSR6T5D/havdAkqt4wjT32wL772EcyZBrGL6YEOeynFP
         lyfkpma2VMU4IaK3wfo329+aCowekY/ST5zuqucTTqfLqL7aFe7tjORWYVMAHHBGF47r
         vY+8pmiycCNRML9Kixw0HLo3qzFJeI4NJMp+gXD3vBs9a2orE2QjttaPxj6KNYWTINt1
         o5toYBJOzeFgZvuFPwpGNZYQLB0hIAC9hsfalxThE/1dIoAS4aZuHrmX3NED1vyY6izL
         bxty1kEsND0TQwNfrC111/cJSIn628HeBWnPC+kLumMlA6p2BG09zEnE6uHD/Be9MAiv
         HtxQ==
X-Gm-Message-State: AOAM531TP+5RuU1jZg8LIM5BWL+SRBqIJgVUKB5ZpL+oK0m9qUzi/yMU
        clCOmOV3MbwAK1EGChQ3n12WDRfnffJNS100pqbImQ==
X-Google-Smtp-Source: ABdhPJzWijuBwUQuP+Vndk1T+sepX2T8/WmWaWQfnWsOR0CMc9FuYs9zuujxjQxRb2Guzz9nNOvUpGArHq0GRwbXUxw=
X-Received: by 2002:a1f:2849:: with SMTP id o70mr25716022vko.35.1638118996213;
 Sun, 28 Nov 2021 09:03:16 -0800 (PST)
MIME-Version: 1.0
References: <20211127223253.19098-1-semen.protsenko@linaro.org>
 <20211127223253.19098-5-semen.protsenko@linaro.org> <YaOR+TbcR1V4ovf/@kroah.com>
 <CAPLW+4mG8AMPCXGWYwURVJhCw0Cv=mYYzNAZf0i7akVcqc384w@mail.gmail.com>
In-Reply-To: <CAPLW+4mG8AMPCXGWYwURVJhCw0Cv=mYYzNAZf0i7akVcqc384w@mail.gmail.com>
From:   Sam Protsenko <semen.protsenko@linaro.org>
Date:   Sun, 28 Nov 2021 19:03:05 +0200
Message-ID: <CAPLW+4k9OAdcg8XcTbazV_470mFw3x61_UakoR-qNHo5C8et_g@mail.gmail.com>
Subject: Re: [PATCH 4/8] tty: serial: samsung: Remove USI initialization
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Jaewon Kim <jaewon02.kim@samsung.com>,
        Chanho Park <chanho61.park@samsung.com>,
        David Virag <virag.david003@gmail.com>,
        Youngmin Nam <youngmin.nam@samsung.com>,
        devicetree@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-i2c@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Sun, 28 Nov 2021 at 18:26, Sam Protsenko <semen.protsenko@linaro.org> wrote:
>
> On Sun, 28 Nov 2021 at 16:28, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Sun, Nov 28, 2021 at 12:32:49AM +0200, Sam Protsenko wrote:
> > > USI control is now extracted to dedicated USIv2 driver. Remove USI
> > > related code from serial driver to avoid conflicts and code duplication.
> >
> > What conflicts?
> >
>
> There might be possible conflicts when accessing the same USI register
> from both serial driver and USIv2 driver. Also there will be conflicts
> when trying to access the same I/O address space in those both
> drivers.
>
> > What duplication?  All you did here was delete code.
> >
>
> It's all explained in [PATCH 0/8], but long story short, I've added
> USIv2 driver (in this series) which handles the code that's removed
> from serial driver in this patch.
>

In other words, this code is now present here: [1]. But of course
USIv2 driver must be applied first, and then this patch (removing the
same code from serial driver). That's why it's in the same series and
it's placed after USIv2 driver ([PATCH 3/8]).

[1] https://patchwork.kernel.org/project/linux-samsung-soc/patch/20211127223253.19098-4-semen.protsenko@linaro.org/

> > confused,
> >
> > greg k-h

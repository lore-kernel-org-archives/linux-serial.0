Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3371DC433DB
	for <linux-serial@archiver.kernel.org>; Fri, 29 Jan 2021 18:43:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C8E0A64E09
	for <linux-serial@archiver.kernel.org>; Fri, 29 Jan 2021 18:43:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232012AbhA2Snt (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 29 Jan 2021 13:43:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232680AbhA2Sns (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 29 Jan 2021 13:43:48 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A658C061573;
        Fri, 29 Jan 2021 10:43:08 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id w14so6790090pfi.2;
        Fri, 29 Jan 2021 10:43:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CYD6mbYO1+surCTTE1+/tGErQl3OuBdsJdOYb3YwHzA=;
        b=F1UX1QfSnYHngyCWpN6+88q4llq8zYFWQCIZEkbkN3ERhPGXmWZGDykXPBYCWLS21j
         QkV2eYdtZd9VWvEOJ5O8Ber9I8ba60WQQsxFJkzZDPuk0DBM2pLgq+KHlcbtG77QSmg3
         31vbFpjWNtgToWLlOfZHn9/Era5WZ0c0ASx7+CS+bBMYHvVIje1wJ/0lPx2MJ1AZgitl
         10ipCdT+B7urJDznuIV2bjX4Y8BDXeZ6i/xbiPam/1Nh8tKDjIKtP8V3/oziHCly38p4
         DpaKy3p2yXuC/jkZPB9oAkXk9WT0iAz1sdJ2rbi99W/zSkeX3esgDV+lUli+hE1iFGdg
         ss0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CYD6mbYO1+surCTTE1+/tGErQl3OuBdsJdOYb3YwHzA=;
        b=rfeQ+P7utMv/3ZeIMY8dR54TDBkhRgnGbMPMSxdG4PLhDHuhXqeYoW4eSMfKTLdHWV
         uXrg9hR5H2KlRUlA5S3G120ePUtjpfW6h9b/7vTIk2kUbEYsNFPZEObz1uDBhL9Ye13q
         /9u/QSf2FjjNB3yJX2ke7i8dphk//fO3At9b400FyIwcWvQUfF+SmsSh4edaNYN/vQJA
         u90ygSNCLM7KWZ9KiJetFNJdt2/+ZnmO4f2Y9jyvU21idprVVpPbQrxF/yB5sVqQgKXf
         H6Yd5VSdWWxBy7wwJpN2HkreSXBArC7XfIBHQ4SPgjay/QsqDQYrTx2M0uzBKZ9Ctrfc
         8wPQ==
X-Gm-Message-State: AOAM530M56jvntjLrIYGH5dY9+N2xLxoi/6P8tmJZxLqHIXmkZnFhO3i
        NNM6/+HtZxwKl1Hsk1VH9NTIHcFp63PhvLNCeTaXE1yyQOzcvQ==
X-Google-Smtp-Source: ABdhPJy8xK7O6VwaQ4JOWmVwJ8Kv/KqUwopSiyvtMFo8w0RHdkeGDg9pz2DU+rzK48YUL/8ogYtGoKYtACBexCxtXKM=
X-Received: by 2002:a05:6a00:854:b029:1b7:6233:c5f with SMTP id
 q20-20020a056a000854b02901b762330c5fmr5655362pfk.73.1611945788022; Fri, 29
 Jan 2021 10:43:08 -0800 (PST)
MIME-Version: 1.0
References: <20210128233629.4164-1-etremblay@distech-controls.com>
 <20210128233629.4164-4-etremblay@distech-controls.com> <YBPwlmxNfrxSLK0B@smile.fi.intel.com>
 <22d98a58-724c-a563-d55c-7c18b5271ec7@distech-controls.com>
In-Reply-To: <22d98a58-724c-a563-d55c-7c18b5271ec7@distech-controls.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 29 Jan 2021 20:42:51 +0200
Message-ID: <CAHp75VdN80xTCxH19OLq1D3PqgfbV+TEs=aTHP62ScsG+aZ72g@mail.gmail.com>
Subject: Re: [PATCH 3/3] serial: 8250: remove UART_CAP_TEMT on PORT_16550A_FSL64
To:     Eric Tremblay <etremblay@distech-controls.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        "Matwey V. Kornilov" <matwey.kornilov@gmail.com>,
        Giulio Benetti <giulio.benetti@micronovasrl.com>,
        Lukas Wunner <lukas@wunner.de>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        christoph.muellner@theobroma-systems.com,
        =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, Jan 29, 2021 at 8:07 PM Eric Tremblay
<etremblay@distech-controls.com> wrote:
> On 2021-01-29 6:25 a.m., Andy Shevchenko wrote:

...

> Considering the use of the reversed capability UART_CAP_NOTEMT should I set
> the flag directly in uart_config like:
>
> [PORT_16550A_FSL64] = {
>                 .name           = "16550A_FSL64",
>                 .fifo_size      = 64,
>                 .tx_loadsz      = 63,
>                 .fcr            = UART_FCR_ENABLE_FIFO | UART_FCR_R_TRIG_10 |
>                                   UART_FCR7_64BYTE,
>                 .flags          = UART_CAP_FIFO | UART_CAP_NOTEMT,
>         },

This looks much better!

-- 
With Best Regards,
Andy Shevchenko

Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0CBCC433B4
	for <linux-serial@archiver.kernel.org>; Sat, 24 Apr 2021 10:26:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 87C396141C
	for <linux-serial@archiver.kernel.org>; Sat, 24 Apr 2021 10:26:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234596AbhDXK0x (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sat, 24 Apr 2021 06:26:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232245AbhDXK0w (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sat, 24 Apr 2021 06:26:52 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EF67C061574;
        Sat, 24 Apr 2021 03:26:12 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id u14-20020a17090a1f0eb029014e38011b09so2595555pja.5;
        Sat, 24 Apr 2021 03:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SoDHrgRGkFpQlgxALyzox+K4epDPQbVPFi34jIumvso=;
        b=sA84dSUBnCTpO7vlrr2sLXTgKAG5meIpE73i78a/0LZq3frZR4urN8jCVQCBOouBRD
         /4QgKin25ftYV3lfyFITO97OcQEStddUP3tq9R16+aivNT7bOftqhlcorqBMdO5yr56y
         yLp1LNVv/D2OnCCCUBhJiquhjEXza0NRikIK+plvlJXiS8LbGQNqJ73DdU+UuJstzU01
         Fi6lDl/BZ7pebytL6Dl5KdRWHLMSkzBSfWsrG6E1WTw/MwORDstsqmNZq4JBNEKABjLL
         wxZLrM5i/4ePNkNoWBzbRKRbZApgv3OrCe1XzlF8hhc4BwHCv++pObYZePu11laIH15a
         UKFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SoDHrgRGkFpQlgxALyzox+K4epDPQbVPFi34jIumvso=;
        b=Rt9JBZj3osMA+jgBPidRMHl3XB9y71dSNNP92RTNPIKQRVAyKAaNOyujrS7nW/bql8
         lKV8hMc2agmeZJJu3/K70w3xFlSSwgXvMgvMqrNrH5vVqj081D2tHckMk9zsfKqAoHKm
         V68HShzgap+ys3C6vA4wblKi0h1ScqL+essIEcIOVQwiRIl9frxfO4h4Xvy5LsWyNPgi
         meIivAfcdhu1VKBxRW9GlgruwnqCrg5Dn74GFnV3Brw1LnzQ92azW2OE4bUvZfMp6k5n
         5BX3fxJPgNIxVPVYszTfwSqNXZ62fxrGEyooAAaiJ4qnE1lmDRixKfCodu9+904AbiUz
         zu+g==
X-Gm-Message-State: AOAM530UpGyW22+LRumu3TKH1RYifN4iexLVXy6O+8emjsc0QS1JTSLw
        Upu4QLcUAp+tNRZWnWklD/2MbShx9gH4oQRRYy8=
X-Google-Smtp-Source: ABdhPJwI9VHJ8OiYRBjHFcqryfYmM02LRY2R1t4GlTqiynxdONNpz32w//bSV368+iTcC+JRHcVXrB5W5f+710a6wxU=
X-Received: by 2002:a17:902:264:b029:eb:3d3a:a09c with SMTP id
 91-20020a1709020264b02900eb3d3aa09cmr8148960plc.0.1619259971203; Sat, 24 Apr
 2021 03:26:11 -0700 (PDT)
MIME-Version: 1.0
References: <295686a0-240d-71d1-a6a0-f3752cf24477@gmail.com>
In-Reply-To: <295686a0-240d-71d1-a6a0-f3752cf24477@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 24 Apr 2021 13:25:54 +0300
Message-ID: <CAHp75VcLoTsjyQyVAo6cd+HMd+z_irM8ofcenRm0P6CzYGOQNw@mail.gmail.com>
Subject: Re: Support for AMDI0022 UART
To:     Maximilian Luz <luzmaximilian@gmail.com>
Cc:     "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Wang Hongcheng <annie.wang@amd.com>, Ken Xue <Ken.Xue@amd.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, Apr 23, 2021 at 10:58 PM Maximilian Luz <luzmaximilian@gmail.com> wrote:
>
> Hi all,
>
> I received a report from a Surface Laptop 4 which has a UART that is
> identified as AMDI0022 in ACPI [1] and that does not seem to be
> supported by the kernel yet.
>
>  From what I can tell via ACPI, this is similar to the AMDI0020 [2] UART
> that's already supported by the kernel (well, both are devices with two
> MMIO regions and an interrupt as far as I can tell...). So it's possible
> that all that's needed is adding it to the respective device ID lists
> [3, 4]. Unfortunately, I a) don't have a device to test this myself, b)
> haven't found any more details on that online, and c) don't want to tell
> others to test this without knowing a bit more about that (potentially
> writing random stuff to some unknown MMIO region that I don't know
> anything about doesn't sound as safe to me as I'd like).

To me they look completely the same. Depending on the device which is
connected to the UART, I would suggest just to add an ID and see if it
makes it work.

> Does anyone here have some pointers on what it'd take to support this,
> or any contacts at AMD that could provide more insight?

-- 
With Best Regards,
Andy Shevchenko

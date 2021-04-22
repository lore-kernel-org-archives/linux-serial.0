Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD19AC433ED
	for <linux-serial@archiver.kernel.org>; Thu, 22 Apr 2021 00:18:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 913126144A
	for <linux-serial@archiver.kernel.org>; Thu, 22 Apr 2021 00:18:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343898AbhDVATL (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 21 Apr 2021 20:19:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343876AbhDVATE (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 21 Apr 2021 20:19:04 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5A00C06174A
        for <linux-serial@vger.kernel.org>; Wed, 21 Apr 2021 17:18:30 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id a1so49783668ljp.2
        for <linux-serial@vger.kernel.org>; Wed, 21 Apr 2021 17:18:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wVjE4Rp7VbkBfwKoOIcXx5LahzamFYaTl2Muffc8scc=;
        b=DNDAhLHUGVCH/8NA+TG61DmAG6eUbyRcvShlc8LZrNVHDIG4iZdNBmQUmzUax8buNA
         LOfbhBgcXE5hfQix5GIdpas/STF8HXqkJ9K6Mkh4pqKSDbyN4PEyID8fqSh6RkLXJQxH
         tKhGVAU2sxmjCYk/2GWwnDKMLGKYMCTyIzemZwrpkNM3mX3dXD0c6rpxSp4xVeigmcSh
         4eh8xLeU0GEcnqHDgkxpbADU/ctkivLxJi4oTOYIxA3erNBw7RYzNX8mu4GY6PMUJGbO
         wne9p9UJKjQ6WI71kGzwVAECid/fXXR/sCvv69IYGnHT1WIc3OERIadq5R2uli2LHLUz
         oMsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wVjE4Rp7VbkBfwKoOIcXx5LahzamFYaTl2Muffc8scc=;
        b=tvuJAyEIafEWxaaaQpOkcX3Q33e9YTm/idPXfWNmu5epOEbaTz8XkZeC3pfQEth5/B
         tN6Ai5C2Atyf/KVM/v7UedRHD5OSATQgixCWYThlE6S2wTW/rzJC3N2gl/uIFMXmM/aL
         87OEfe+ItmwAIwgwS65jqnnncwH73RvLdr4ImicZvwaV50FQOkrT0k+rC80GYtx6yzGh
         ekCxOzAwERXolQHIDuwu82FNELC2beP26S8V5lWq7zQ7K0lzSQt8s7PzfnumvcTdonTB
         Gpw5X/SMYqb3K0vKcAyzvzpSIoqNiiAiExUhVNoXvnRCgZPylO4wX61Gsd1A/5J6HzPz
         Xsbw==
X-Gm-Message-State: AOAM533hCsxQFsfEy9GDR6WfnIGZ2sUabfYLHj1StAPpVuIQCCberrSN
        H+ml5Zk5r3t272RyRBsKE37t2bfzVQtb7/RaQLRSXIWX6kY=
X-Google-Smtp-Source: ABdhPJzK3Tp+Pmg+BxzoMyA+1UcoaKsXeWmiM5jrKtzU6sEJ38Gq2Gl1S4yYYHKDFwxbGB2UWvMnBTfky6FA0LXAaNU=
X-Received: by 2002:a2e:9cb:: with SMTP id 194mr562114ljj.438.1619050709119;
 Wed, 21 Apr 2021 17:18:29 -0700 (PDT)
MIME-Version: 1.0
References: <20210421095509.3024-1-johan@kernel.org> <20210421095509.3024-6-johan@kernel.org>
In-Reply-To: <20210421095509.3024-6-johan@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 22 Apr 2021 02:18:18 +0200
Message-ID: <CACRpkdYivk6r91qiMzGv-zoSuhKS-_YzNHKHUSCWwZSHayT9=Q@mail.gmail.com>
Subject: Re: [PATCH 05/26] serial: amba-pl011: drop low-latency workaround
To:     Johan Hovold <johan@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Russell King <linux@armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, Apr 21, 2021 at 11:55 AM Johan Hovold <johan@kernel.org> wrote:

> Commit ead76f329f77 ("ARM: 6763/1: pl011: add optional RX DMA to PL011
> v2") added RX DMA support and also reproduced the workaround for the
> infamous low_latency behaviour of tty_flip_buffer_push() by dropping and
> reacquiring the port lock during receive processing.
>
> Since commit a9c3f68f3cd8 ("tty: Fix low_latency BUG"),
> tty_flip_buffer_push() always schedules a work item to push data to the
> line discipline and there's no need to keep any low_latency hacks around.
>
> Note that the port lock is also dropped in the PIO path
> (see pl011_rx_chars), but it is not clear whether this is still needed
> by the DMA code added by the aforementioned commit.
>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Russell King <linux@armlinux.org.uk>
> Signed-off-by: Johan Hovold <johan@kernel.org>

Looks like the right thing to do to me! Thanks for digging this out.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

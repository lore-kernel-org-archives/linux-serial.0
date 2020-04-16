Return-Path: <SRS0=wizI=6A=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1712C2D0EF
	for <linux-serial@archiver.kernel.org>; Thu, 16 Apr 2020 08:12:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9DA3E206E9
	for <linux-serial@archiver.kernel.org>; Thu, 16 Apr 2020 08:12:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441202AbgDPIMl (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 16 Apr 2020 04:12:41 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:41885 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2441173AbgDPIM2 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 16 Apr 2020 04:12:28 -0400
Received: by mail-oi1-f193.google.com with SMTP id k9so15905952oia.8
        for <linux-serial@vger.kernel.org>; Thu, 16 Apr 2020 01:12:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qlwy5aWFQ879NAIrHhpmadNN5aOkvkm2HgtfVxwSTgw=;
        b=KsBNGmlLS22yollwkRgBzMmgQ9PyiB7Cws3HNI6UpXmrZ0tx/XqYrrwGE/QinoOXuM
         Zg33pWAPQ4CzepShphfWsjdkdEg7B0kRR0yTlEy58pA32uhqs6We/ilSPctF+pHv4k5Q
         ucIxgXdUnfFyT6AQY06GZYkCeMSyuDtB+Br14SoqXvZUW99/Y0wwr9Pkb8uwNdi6NF7L
         2sJMOCeNLwRiC5z3TJlQaBlXZwUB9INBWXrWJbgnVb8YSZdzQzQ9H09h6YjJqvVhV2M8
         nYBj/2aM25aPUJgZ5g6+hGagKwYsD/fIS6NS21pZbNRQR9aG+pqEnHrNk6khSS80i8un
         F/Iw==
X-Gm-Message-State: AGi0PuZxI9ViOuzLCKqXX/6d2Sx1LGPQsxbmV3Gz5+LIdP1ImBOlh4fH
        OUpE1B5KGoCF2SQr0elj8hL5XH6a5uRmasBGilw=
X-Google-Smtp-Source: APiQypJCKGe/79cdzasnQ5Qt2LHzQehL3IgzgeGi2eDPlB/pY3qSwHuZ17Ud9lH7YxXO8J3wxuw7C5qHaMmIPYp93bc=
X-Received: by 2002:a05:6808:8cf:: with SMTP id k15mr2217403oij.54.1587024747536;
 Thu, 16 Apr 2020 01:12:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200415180250.221762-1-linus.walleij@linaro.org>
In-Reply-To: <20200415180250.221762-1-linus.walleij@linaro.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 16 Apr 2020 10:12:15 +0200
Message-ID: <CAMuHMdWPMBFX2NtZW+pdsn+g28q9WLP9y+jsRWLR_vOCh5h+vQ@mail.gmail.com>
Subject: Re: [PATCH] serial: sh-sci: Drop unused include
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "George G . Davis" <george_davis@mentor.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, Apr 15, 2020 at 8:04 PM Linus Walleij <linus.walleij@linaro.org> wrote:
> The sh-sci.h file includes the legacy <linux/gpio.h> header
> but the driver is actually migrated to use the mctrl_gpio
> library so this is not needed.
>
> Cc: George G. Davis <george_davis@mentor.com>
> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

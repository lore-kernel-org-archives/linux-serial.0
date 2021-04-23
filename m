Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFF35C433ED
	for <linux-serial@archiver.kernel.org>; Fri, 23 Apr 2021 19:25:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C75CD6145A
	for <linux-serial@archiver.kernel.org>; Fri, 23 Apr 2021 19:25:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231684AbhDWT0Y (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 23 Apr 2021 15:26:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbhDWT0Y (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 23 Apr 2021 15:26:24 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E67EDC061574;
        Fri, 23 Apr 2021 12:25:46 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id l21so6680222iob.1;
        Fri, 23 Apr 2021 12:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=V74EFI5YNJRXk9wbQGsunfhXeUPcRx2BctxhLBEUfgo=;
        b=R4tHKzWSlnVchgZMTxQt8mh2HlOm4QZ0qaFpPPNs+HYbAwxDV8w8OldLTQP9YfglmI
         +U+/Qw/2nTL7wkgRiXayU/OpgxmO+kyMos+6h3pj1Y5LSG/pj35IvClud97PXWHoA8kr
         a1Cjry+dJxq+ue6+EOuLUrls0IdfsxZ7Uj+m8eCE5lS4o3KDMlQ31wo+D7Twx/dZolcm
         Le92efrv3bfj/p7fa6ADzjn8C1uTBW7pyM07sLZIrQUi2h12VTYXwJndqhM5QzADdtzL
         1Iu6hmiob01pfYTipBiEhfpCIh0StokbFJVDPjbucWwLl9g4W6USFvof2dZxcjFElgTU
         1tgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V74EFI5YNJRXk9wbQGsunfhXeUPcRx2BctxhLBEUfgo=;
        b=j/g76nWoiKNQxdv7T69lMR1Dlab3OMT0Dj7G/0LA5p52fxYjQeBtq3ZRK5Vsdi0BIz
         Rs58TC180yW3T+Ij6QaqD0b7P3/owcfW0naFsPMkcAZ098TLoyTCUNsNfK1SwpYayd1z
         CYx9cCo2bKmmiJhOaIUhAUYBu270E+2y90YANSOhxLbMte9USea8NwwKUgDpmzsVPP9H
         qajYOXiBLzu1/yHYw5GfmDGTFut7aKWAmTWYxOk3IqiG6QPGnHZBoiF+x5eL7LAIZ5Em
         7qoDgEU50rzL0LArmr6TWrlAi+bbrLjTpufnQAnXhhRb2NI9MN1Zhg3tM9aMKnthK2hV
         c8wQ==
X-Gm-Message-State: AOAM531s/HwwcQMy5OSD+2zbeWl/q9+mxzoW1p/P6X/sIdlgVFZcgvqm
        g0JslaQ4mWRvd92ZeNDFt3tv7Za3eLHF/T6pCfwPV1Sn
X-Google-Smtp-Source: ABdhPJyDh2LIYibl4XZHDQP3iL2hiUueGExWaOu8x9Ee2ludbcNor4m4tdmVcjvGC4xOt2k/sO3qTRR0NlLb+wPdlhA=
X-Received: by 2002:a6b:f808:: with SMTP id o8mr4582100ioh.140.1619205946260;
 Fri, 23 Apr 2021 12:25:46 -0700 (PDT)
MIME-Version: 1.0
References: <20210423191920.42940-1-alcooperx@gmail.com>
In-Reply-To: <20210423191920.42940-1-alcooperx@gmail.com>
From:   Alan Cooper <alcooperx@gmail.com>
Date:   Fri, 23 Apr 2021 15:25:35 -0400
Message-ID: <CAOGqxeVokFqOQMpTrpyg1GPRk6YCw=GF0-ShBtiKz_3_0RU2XQ@mail.gmail.com>
Subject: Re: [PATCH] serial: 8250: of: Check for CONFIG_SERIAL_8250_BCM7271
To:     ": Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Cc:     Jim Quinlan <jim2101024@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Please ignore this patch, it was already submitted by Florian about an hour ago.

Thanks
Al

On Fri, Apr 23, 2021 at 3:20 PM Al Cooper <alcooperx@gmail.com> wrote:
>
> From: Jim Quinlan <jim2101024@gmail.com>
>
> This commit has of_platform_serial_probe() check specifically for the
> "brcm,bcm7271-uart" and whether its companion driver is enabled. If it
> is the case, and the clock provider is not ready, we want to make sure
> that when the 8250_bcm7271.c driver returns EPROBE_DEFER, we are not
> getting the UART registered via 8250_of.c.
>
> Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> Signed-off-by: Al Cooper <alcooperx@gmail.com>
> ---
>  drivers/tty/serial/8250/8250_of.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/tty/serial/8250/8250_of.c b/drivers/tty/serial/8250/8250_of.c
> index 65e9045dafe6..aa458f3c6644 100644
> --- a/drivers/tty/serial/8250/8250_of.c
> +++ b/drivers/tty/serial/8250/8250_of.c
> @@ -192,6 +192,10 @@ static int of_platform_serial_probe(struct platform_device *ofdev)
>         u32 tx_threshold;
>         int ret;
>
> +       if (IS_ENABLED(CONFIG_SERIAL_8250_BCM7271) &&
> +           of_device_is_compatible(ofdev->dev.of_node, "brcm,bcm7271-uart"))
> +               return -ENODEV;
> +
>         port_type = (unsigned long)of_device_get_match_data(&ofdev->dev);
>         if (port_type == PORT_UNKNOWN)
>                 return -EINVAL;
> --
> 2.17.1
>

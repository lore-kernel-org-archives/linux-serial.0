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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80964C433B4
	for <linux-serial@archiver.kernel.org>; Fri, 23 Apr 2021 18:54:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 54B3B61465
	for <linux-serial@archiver.kernel.org>; Fri, 23 Apr 2021 18:54:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243779AbhDWSzM (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 23 Apr 2021 14:55:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243800AbhDWSzB (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 23 Apr 2021 14:55:01 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 822A5C06138B;
        Fri, 23 Apr 2021 11:54:22 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id c17so13043pfn.6;
        Fri, 23 Apr 2021 11:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8hZ/YURGA6c4xnfKMd6ZNtNWZJLdBkAKnF1HThyHArs=;
        b=eI/oD+VKIxoD7QlEqeGY8VxCMTskLC2suW7symThQS9AFT+39vDNaHN8w2f+IV014d
         tISDPFXDeQwLPjwobei/d8sRZs8Is6JrBJLcgDhO5P1uLSZkemmZ//DLiii+i7ZDFJZi
         ZZYjBFnyJK4TFwQPt47I3l/FaubT4gsUNuzjdoNyg/OQ/VkRqZs0vsY4FtcHuoa2A6ou
         z3O2FwdVXX9IRDoRwhiQXHjG/rYl3riPQmC7nsiNvkJgykZiaHH4Hp8qL9VXsgtgUXB7
         /Ymx6bZ2+/IFzaXyS2osRAo0wOkGdn6jzaBsnVojtnLYHq1J5gp6IKI7CDMlfDdTGdM+
         wxvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8hZ/YURGA6c4xnfKMd6ZNtNWZJLdBkAKnF1HThyHArs=;
        b=MZDNiIQ5waeLJ0H9sg/1QVpT6cPh6jMtMSsFPWjZiWxG52BPy74gmWsYB196bmvDnT
         oiEtCCVnU7weNosKuNueIsxLTuqrDZZJIkmNnnhuvCmuRthorgFfJxrXVqiZfnEtTSA/
         Ed0SFas6gUHpx2AiNR89OtqADr7FblZY4AijkV/EktMH9WPaYniB798z2N8KBlGWj/zP
         KLiYB7ha3b0I9ek6sLKWfDKjfKzlQdboqXXm9BlR/kk47hJpZwBFndSQM8YgI4qizd8e
         Brk3sN9RH/HXLZa+pqmjA02TYz3/xzfhMLz5bXOjLC4uGs/94hOwfnJGeVurFkfiBiB4
         vJ5g==
X-Gm-Message-State: AOAM530WsuvtaKv3NQLnt6ZuzyAHVX+Zm98Z+x2AHsNx5llkM4f/g7Xw
        vsU555fa/mIczadfuC7Eh0HRzVzLPGAZHpKcahU=
X-Google-Smtp-Source: ABdhPJyPPDE09p69Ib2tzmotrga4fFd1yT7dJ2mrtas4c0GpBhLiGjxl296NOmMGOWh1wHcVYpPGpt4KV6pVhGe/KFA=
X-Received: by 2002:a62:5c6:0:b029:24d:e97f:1b1d with SMTP id
 189-20020a6205c60000b029024de97f1b1dmr5279838pff.40.1619204061919; Fri, 23
 Apr 2021 11:54:21 -0700 (PDT)
MIME-Version: 1.0
References: <20210423183206.3917725-1-f.fainelli@gmail.com>
In-Reply-To: <20210423183206.3917725-1-f.fainelli@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 23 Apr 2021 21:54:05 +0300
Message-ID: <CAHp75VfkSZyKo5JqBL0MuMzyPis59ebJKW5c7c-53K9h4d5bCA@mail.gmail.com>
Subject: Re: [PATCH tty-next] serial: 8250: of: Check for CONFIG_SERIAL_8250_BCM7271
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Al Cooper <alcooperx@gmail.com>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        Jim Quinlan <jim2101024@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, Apr 23, 2021 at 9:34 PM Florian Fainelli <f.fainelli@gmail.com> wrote:
>
> From: Jim Quinlan <jim2101024@gmail.com>
>
> Our SoC's have always had a NS16650A UART core and older SoC's would
> have a compatible string of: 'compatible = ""ns16550a"' and use the
> 8250_of driver. Our newer SoC's have added enhancements to the base
> core to add support for DMA and accurate high speed baud rates and use
> this newer 8250_bcm7271 driver. The Device Tree node for our enhanced
> UARTs has a compatible string of: 'compatible = "brcm,bcm7271-uart",
> "ns16550a"''. With both drivers running and the link order setup so
> that the 8250_bcm7217 driver is initialized before the 8250_of driver,
> we should bind the 8250_bcm7271 driver to the enhanced UART, or for
> upstream kernels that don't have the 8250_bcm7271 driver, we bind to
> the 8250_of driver.
>
> The problem is that when both the 8250_of and 8250_bcm7271 drivers
> were running, occasionally the 8250_of driver would be bound to the
> enhanced UART instead of the 8250_bcm7271 driver. This was happening
> because we use SCMI based clocks which come up late in initialization
> and cause probe DEFER's when the two drivers get their clocks.
>
> Occasionally the SCMI clock would become ready between the 8250_bcm7271
> probe and the 8250_of probe and the 8250_of driver would be bound. To
> fix this we decided to config only our 8250_bcm7271 driver and added
> "ns16665a0" to the compatible string so the driver would work on our
> older system.
>
> This commit has of_platform_serial_probe() check specifically for the
> "brcm,bcm7271-uart" and whether its companion driver is enabled. If it
> is the case, and the clock provider is not ready, we want to make sure
> that when the 8250_bcm7271.c driver returns EPROBE_DEFER, we are not
> getting the UART registered via 8250_of.c.

Thanks!

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
> Signed-off-by: Al Cooper <alcooperx@gmail.com>
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  drivers/tty/serial/8250/8250_of.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/tty/serial/8250/8250_of.c b/drivers/tty/serial/8250/8250_of.c
> index 0b077b45d6a9..bce28729dd7b 100644
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
> 2.25.1
>


-- 
With Best Regards,
Andy Shevchenko

Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86005C433EF
	for <linux-serial@archiver.kernel.org>; Sun,  5 Sep 2021 16:14:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6548360E8B
	for <linux-serial@archiver.kernel.org>; Sun,  5 Sep 2021 16:14:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237465AbhIEQPg (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sun, 5 Sep 2021 12:15:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbhIEQPg (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sun, 5 Sep 2021 12:15:36 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7007C061575;
        Sun,  5 Sep 2021 09:14:32 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id jg16so8263649ejc.1;
        Sun, 05 Sep 2021 09:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Z1qfnInw6eBkH7VjzzpSAckO42XtWnywfSjVuFVYJ3Q=;
        b=PU14FLyzP6DjD1Xg8mWVpaBO2svY6s7u4j3xgfY/lmmGPcXclmQGtbrjSBwOBgChCi
         8U7E3QMqeWunvrr7r0hXeVFaiyvvN47s0sSC9Bu6Slhfyi1XHFeLvQxzz9QCQeGODFu6
         GzBkWImo3OYYrP/A9bu779vxlYlBVhb6LbO0u+wedSDSFzNxtyLlLEhLCXbIJVNaGojQ
         UKpGG/kQC2Qj4bMWlecREXAMhXXp0zR6yQo1zym6vn89i9m7VS3HOiPnjngTLTjryZNG
         O93maFPHunXPw9vRhlTcF+NoE6qAziXBHYdhI+PlI2WYjNz5KZAU3DVjAxZ/Yc/0h34/
         EntA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z1qfnInw6eBkH7VjzzpSAckO42XtWnywfSjVuFVYJ3Q=;
        b=koiZJxTbwRhvgzA4mSPlMHBYO1wQGTKOFpGZEg4fHsnnr3J7zOHjfAag/SzI8ao9SK
         nJFqXW+8wN4lKZ0F4MVOtpTMYdhjz4RVg+6p2HgCTVYW+liSsX5ifK2jd2qxDUfBYvTK
         36xxtmoxFX+SU/RWI0d1ldPR4Si440TiMB+JH7jPytT36IJOetIfaPn9exb9t4hRKnpY
         Go8/XmF/Q/3FYAJTn4Gt0USgtsq0mGgwRMwzYZYK/0U6LU8bWr4zDcmMF6oekI5gbkj8
         xsg9lb3gIDXl9S2kgfc6N4fWPcc6cXMt2HfeSBrVrunrzDswKL5S4MODiWLb83cUH9A1
         g9ww==
X-Gm-Message-State: AOAM53053aaGwnqdnBUpJIF7qdShuoPEaNeoN7yBqsxRKejnAj/hc3O2
        kv0NYIzHD7tNi/oegsbPX4eoABt9v5SKq6uYZU4=
X-Google-Smtp-Source: ABdhPJxkm85otXbfQPQGcjOp49xOcY21ScTLcY2EjtERxtwvx5yiJsEhyTBr9ILLH7j1fsbSn+XqGv9mqB0uojt0ais=
X-Received: by 2002:a17:906:52c5:: with SMTP id w5mr9401187ejn.567.1630858471430;
 Sun, 05 Sep 2021 09:14:31 -0700 (PDT)
MIME-Version: 1.0
References: <20210905155728.11147-1-len.baker@gmx.com>
In-Reply-To: <20210905155728.11147-1-len.baker@gmx.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 5 Sep 2021 19:13:54 +0300
Message-ID: <CAHp75VcqTf3qef76nAE_TN32MdcvtYxZP2O8Oekap-_34mey0A@mail.gmail.com>
Subject: Re: [PATCH] serial: 8250_pci: Prefer struct_size over open coded arithmetic
To:     Len Baker <len.baker@gmx.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mario Kleiner <mario.kleiner.de@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Randy Wright <rwright@hpe.com>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        Tobias Diedrich <tobiasdiedrich@gmail.com>,
        YueHaibing <yuehaibing@huawei.com>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        linux-hardening@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Sun, Sep 5, 2021 at 6:58 PM Len Baker <len.baker@gmx.com> wrote:
>
> As noted in the "Deprecated Interfaces, Language Features, Attributes,
> and Conventions" documentation [1], size calculations (especially
> multiplication) should not be performed in memory allocator (or similar)
> function arguments due to the risk of them overflowing. This could lead
> to values wrapping around and a smaller allocation being made than the
> caller was expecting. Using those allocations could lead to linear
> overflows of heap memory and other misbehaviors.
>
> So, use the struct_size() helper to do the arithmetic instead of the
> argument "size + size * count" in the kzalloc() function.

Makes sense
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> [1] https://www.kernel.org/doc/html/v5.14/process/deprecated.html#open-coded-arithmetic-in-allocator-arguments
>
> Signed-off-by: Len Baker <len.baker@gmx.com>
> ---
>  drivers/tty/serial/8250/8250_pci.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
> index a808c283883e..b97ade35d4a3 100644
> --- a/drivers/tty/serial/8250/8250_pci.c
> +++ b/drivers/tty/serial/8250/8250_pci.c
> @@ -3981,9 +3981,7 @@ pciserial_init_ports(struct pci_dev *dev, const struct pciserial_board *board)
>                         nr_ports = rc;
>         }
>
> -       priv = kzalloc(sizeof(struct serial_private) +
> -                      sizeof(unsigned int) * nr_ports,
> -                      GFP_KERNEL);
> +       priv = kzalloc(struct_size(priv, line, nr_ports), GFP_KERNEL);
>         if (!priv) {
>                 priv = ERR_PTR(-ENOMEM);
>                 goto err_deinit;
> --
> 2.25.1
>


-- 
With Best Regards,
Andy Shevchenko

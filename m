Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A504EC07E9A
	for <linux-serial@archiver.kernel.org>; Wed, 14 Jul 2021 08:58:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 83F4961362
	for <linux-serial@archiver.kernel.org>; Wed, 14 Jul 2021 08:58:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238527AbhGNJBZ (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 14 Jul 2021 05:01:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238632AbhGNJBY (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 14 Jul 2021 05:01:24 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6D85C06175F
        for <linux-serial@vger.kernel.org>; Wed, 14 Jul 2021 01:58:33 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id o3-20020a17090a6783b0290173ce472b8aso3404942pjj.2
        for <linux-serial@vger.kernel.org>; Wed, 14 Jul 2021 01:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=avJB7u25wHYezgiJjuNf3ovSzS3ePz8IEAmpNo/+Tgo=;
        b=FbiewQGmh8Kkxhnpti/YG3iELqMeNJthWA4pyE/BXimjoGnu239ssAcsvDLV4qwT5U
         JixWoUliuVrSNQXBGoOWbVP+6fUFariEkvl2XBpZuJKbiULlJdK7IHQhgPpApNQT4W/e
         XEobBVc4anVlAhQsq51XkB6oe4U0/lTsMcnWUKby2/IkWjj7R1ppXKw2UpSWFQ8G54nR
         zxIRS/3/4GRd7PR9J6nwmXCVXcubN6yXEVgBfutiAZRHVv7Nwmj7e4+63/Opsz34neMK
         La6nmGbbwB0mGRRzZcBjllbp+P5NHjXbtIF8FqXIbjTmkxBanlYXZ941SDfcIlg/dimv
         xtRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=avJB7u25wHYezgiJjuNf3ovSzS3ePz8IEAmpNo/+Tgo=;
        b=e84l9qhqYrse+WOPVhkZfZTtFB/lp6emHz/8X0oS4O+ngL3CbAepGQkWGKBRLOZMJ4
         ueFrtQptTTwnGF1uJ0xNxQDxhvnKiekJbY61Dg7YsvrVF1ghegJr8xPYStS34i07fpoH
         /4R7PcdmvlCQBdrNaC//jYSJZ/ngMfLFdmFl+DvMCK1o/xzFLWEPOJom8ROr6hXdYY5h
         5R9uiGN3h55bm5Jm/puThx3qfl7k7rF8u8hVYc0asIPWJoYZp5hBIlFsOgYgNGTZI+Ty
         uh3VQ9BAYGY+MPP7ZvFfx7Xsc7qoLGRrq0njGaxcotCq7+na/PtypKkjAvPvjxE9W2Yk
         GWOg==
X-Gm-Message-State: AOAM530WGkQLo1S4QdcOi8MujJ5tnhLOEFtojp0SaC6FtqS7GxHV6o4X
        0ex4W+1bIQO8YDFoPNqwLzfdNlsLDpASPVCa4cl2C6OSEvA=
X-Google-Smtp-Source: ABdhPJwz7OSvN5oc+4Ki0jfzMJzpwPKkB59MgOcXxXzjHb6j14W+7NYQYyounh+81X4DFJ241apvqeOK9DgVpQ6nhB0=
X-Received: by 2002:a17:90a:17ad:: with SMTP id q42mr2800486pja.181.1626253113206;
 Wed, 14 Jul 2021 01:58:33 -0700 (PDT)
MIME-Version: 1.0
References: <20210705130010.1231798-1-chenhuacai@loongson.cn>
 <YOynYT29jF6JwgN/@surfacebook.localdomain> <45d828b0.bcb4.17aa2df0f81.Coremail.chenhuacai@loongson.cn>
In-Reply-To: <45d828b0.bcb4.17aa2df0f81.Coremail.chenhuacai@loongson.cn>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 14 Jul 2021 11:57:52 +0300
Message-ID: <CAHp75Vd6VgOzPrwZFaGFodzUbiaGp6FXVpuAnVCs6L=+9S50JQ@mail.gmail.com>
Subject: Re: Re: [PATCH V2] serial: 8250_pnp: Support configurable clock frequency
To:     =?UTF-8?B?6ZmI5Y2O5omN?= <chenhuacai@loongson.cn>
Cc:     andy@surfacebook.localdomain,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Jianmin Lv <lvjianmin@loongson.cn>, chenhuacai@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, Jul 14, 2021 at 5:36 AM =E9=99=88=E5=8D=8E=E6=89=8D <chenhuacai@loo=
ngson.cn> wrote:

...

> &gt; &gt;  #include <linux kernel.h=3D"">
> &gt; &gt;  #include <linux serial_core.h=3D"">
> &gt; &gt;  #include <linux bitops.h=3D"">
> &gt; &gt; +#include <linux property.h=3D"">
> &gt;
> &gt; Can you try to keep it ordered (to some extend), please?
> Existing headers is not in order,

That's why I added in the parentheses "to some extent".

> should I sort them completely?

Just put property.h before serial_core.h.

...

> &gt; &gt;       uart.port.flags |=3D UPF_SKIP_TEST | UPF_BOOT_AUTOCONF;
> &gt; &gt;       if (pnp_irq_flags(dev, 0) &amp; IORESOURCE_IRQ_SHAREABLE)
> &gt; &gt;               uart.port.flags |=3D UPF_SHARE_IRQ;
> &gt; &gt; -     uart.port.uartclk =3D 1843200;
> &gt; &gt; +     if (device_property_read_u32(&amp;dev-&gt;dev, "clock-fre=
quency", &amp;uart.port.uartclk))
> &gt; &gt; +             uart.port.uartclk =3D 1843200;
> &gt; &gt;       uart.port.dev =3D &amp;dev-&gt;dev;
> &gt;
> &gt; You can avoid conditional completely by calling
> &gt;
> &gt;    device_property_read_u32(&amp;dev-&gt;dev, "clock-frequency", &am=
p;uart.port.uartclk);
> I want to get the property by this function, and set to default value (18=
43200) if fails. If remove the condition, how to set the default? Thanks.

As I explained above.

x =3D $default_value;
device_property_read_u32(..., &x);

--=20
With Best Regards,
Andy Shevchenko

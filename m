Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C70B2C07E96
	for <linux-serial@archiver.kernel.org>; Thu, 15 Jul 2021 04:46:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B4AB66136E
	for <linux-serial@archiver.kernel.org>; Thu, 15 Jul 2021 04:46:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237909AbhGOEtd (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 15 Jul 2021 00:49:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231823AbhGOEtc (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 15 Jul 2021 00:49:32 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC2B9C06175F
        for <linux-serial@vger.kernel.org>; Wed, 14 Jul 2021 21:46:39 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id k11so4945934ioa.5
        for <linux-serial@vger.kernel.org>; Wed, 14 Jul 2021 21:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=pcbWLSCDVaFOjomSC5Da9Q/sHxChDXRtjJl0Uj1B2L0=;
        b=oMTc9gmWwovtpybsc7qDcfbYORARgGUib6uJX/fv8ydjhwjClaHY6Gp/WPpe8DTxAl
         fJHgz1uY6z5HZ0nSdfmQis1jhda50p3y8/rYay90/SXIZVjlUr+ZghDVxl8w/zV1Mofm
         ggAkz+1UHXEQEaNBJGXF0ieKfrHlxqYbRe6/cpBzgm+Td7tmpMMdhmjoqJ5lzkyR0bAD
         DMm42Sj0nEZuvW0+0ySxCmf/+uKhxaQ/HHY/9I62EHTGyC3cuKy4r0/iqY6WeqtZXpOH
         Pp4bZ5mxWCgcL/tqseY3u24WVeuR2uKqm0i6Ov/EtFNDA8dv01E6wF0vJNsCWJ3T1IQ8
         865Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=pcbWLSCDVaFOjomSC5Da9Q/sHxChDXRtjJl0Uj1B2L0=;
        b=eLg1mRvoWOjNEVVKXxM3kr2NbCDQqn+msSDtZ+UaMx2fCEGR+C9PTMzBam1ISoz5Vu
         VjXSEAtps7Bq7RjRy4QF9cGCGdL9TT2PaL+X7DMgwYo/VGfVguZgeH9PGdIilfihViU0
         O0+CNGBPNR92OExrJaBAddARBrh+ltf0NovrqWLxvjb5mW4YtYbCCXs3qqOId0LLEwMh
         9+qqetXQP50y0Fv/EXUVVipoIiVOJ/zdL57PLWABaFGgij7ckc/NdROy9fjkPf1owQO2
         LTD1EbhfA8KotrZXO97WheY14Vh+4QJLOkJ67FPmtHLM0neB7aO91NpM0xLWPRsh5WNl
         slfg==
X-Gm-Message-State: AOAM531k5KsDZGZwYuL4KqjiomNGDTXS7bZ0gTcOqJnTpu+NLzK2q7j7
        UaP4QLZbcagYnkpD7EokXC3B363SozAS56kqPmA=
X-Google-Smtp-Source: ABdhPJx7o8iXWJHQhLeFCSzm5SIJ3Zko9UpgoLToUjRFN/5lkVJglcjksMggdVuHKLIZwdXiDMzs2smsWU0ADHqrvhI=
X-Received: by 2002:a6b:fe06:: with SMTP id x6mr1607164ioh.38.1626324399317;
 Wed, 14 Jul 2021 21:46:39 -0700 (PDT)
MIME-Version: 1.0
References: <20210705130010.1231798-1-chenhuacai@loongson.cn>
 <YOynYT29jF6JwgN/@surfacebook.localdomain> <45d828b0.bcb4.17aa2df0f81.Coremail.chenhuacai@loongson.cn>
 <CAHp75Vd6VgOzPrwZFaGFodzUbiaGp6FXVpuAnVCs6L=+9S50JQ@mail.gmail.com>
In-Reply-To: <CAHp75Vd6VgOzPrwZFaGFodzUbiaGp6FXVpuAnVCs6L=+9S50JQ@mail.gmail.com>
From:   Huacai Chen <chenhuacai@gmail.com>
Date:   Thu, 15 Jul 2021 12:46:26 +0800
Message-ID: <CAAhV-H6+6BzZHpdvn1zFvVDCJW4rs1MWYhxZV6snJatSUvyg2Q@mail.gmail.com>
Subject: Re: Re: [PATCH V2] serial: 8250_pnp: Support configurable clock frequency
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     =?UTF-8?B?6ZmI5Y2O5omN?= <chenhuacai@loongson.cn>,
        andy@surfacebook.localdomain,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Jianmin Lv <lvjianmin@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi, Andy,

On Wed, Jul 14, 2021 at 4:58 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Wed, Jul 14, 2021 at 5:36 AM =E9=99=88=E5=8D=8E=E6=89=8D <chenhuacai@l=
oongson.cn> wrote:
>
> ...
>
> > &gt; &gt;  #include <linux kernel.h=3D"">
> > &gt; &gt;  #include <linux serial_core.h=3D"">
> > &gt; &gt;  #include <linux bitops.h=3D"">
> > &gt; &gt; +#include <linux property.h=3D"">
> > &gt;
> > &gt; Can you try to keep it ordered (to some extend), please?
> > Existing headers is not in order,
>
> That's why I added in the parentheses "to some extent".
>
> > should I sort them completely?
>
> Just put property.h before serial_core.h.
>
> ...
>
> > &gt; &gt;       uart.port.flags |=3D UPF_SKIP_TEST | UPF_BOOT_AUTOCONF;
> > &gt; &gt;       if (pnp_irq_flags(dev, 0) &amp; IORESOURCE_IRQ_SHAREABL=
E)
> > &gt; &gt;               uart.port.flags |=3D UPF_SHARE_IRQ;
> > &gt; &gt; -     uart.port.uartclk =3D 1843200;
> > &gt; &gt; +     if (device_property_read_u32(&amp;dev-&gt;dev, "clock-f=
requency", &amp;uart.port.uartclk))
> > &gt; &gt; +             uart.port.uartclk =3D 1843200;
> > &gt; &gt;       uart.port.dev =3D &amp;dev-&gt;dev;
> > &gt;
> > &gt; You can avoid conditional completely by calling
> > &gt;
> > &gt;    device_property_read_u32(&amp;dev-&gt;dev, "clock-frequency", &=
amp;uart.port.uartclk);
> > I want to get the property by this function, and set to default value (=
1843200) if fails. If remove the condition, how to set the default? Thanks.
>
> As I explained above.
>
> x =3D $default_value;
> device_property_read_u32(..., &x);
I know, thanks.

Huacai
>
> --
> With Best Regards,
> Andy Shevchenko

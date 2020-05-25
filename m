Return-Path: <SRS0=EYjC=7H=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67B12C433E0
	for <linux-serial@archiver.kernel.org>; Mon, 25 May 2020 18:53:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 42B482068D
	for <linux-serial@archiver.kernel.org>; Mon, 25 May 2020 18:53:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bemiXuae"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389642AbgEYSxH (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 25 May 2020 14:53:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389242AbgEYSxH (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 25 May 2020 14:53:07 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F923C061A0E;
        Mon, 25 May 2020 11:53:07 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id e10so15775132edq.0;
        Mon, 25 May 2020 11:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ncUxfDYRX16GOzzRv69z4prU2S2az3SJa3b1si08BEc=;
        b=bemiXuaeSfnsoFfUy2f06eTaYYLD9ai6qByVhKk4ZkCbtxNcZi7ToVguhrNrKxoSRl
         mB/azpw4ugHYkcT2A/U0+QUWEWnrUPQMcnCF6Qdit+lPKrpBj/HZzyUZx4OGXjGUhSgt
         11QWKLbWXxxGXUO0ZWoi5TEw/j7YS8+MvtqpzjZgLD9ab+cN1wg5yTr0yJ1RbNaFuy0B
         9UYkgUb9oK/5Imq1jBG56cr7z7HtKcXmlIc0/BrvZ5+6Vf6ww4n8OO7LA1vU/9owcJyA
         QkNs1SQYygbYPPfRBBq78aEJm6VhPkSzTEl9jsPXgONeWAPckXGvg5aUyQ5h6kkUJYRa
         RHoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ncUxfDYRX16GOzzRv69z4prU2S2az3SJa3b1si08BEc=;
        b=R1ph7i+nWBBLnXGmtbgnJyGZuyCdFs+2XA0TQfphSXi7q9JlT0TLFxME9a1IxBJuJ+
         t+IazpbEWXeRoqTHnQii0bZja9MPqmQF2jfJV5x1Ap1fubW7N0Hbaqwafg15rxcXGGCW
         cMo3/BfkS8RIzkAFKZKs4nmHdLQhl6QuK5DqZxpHDzJB7K3e8fnYIzBElAGlLnRGamx5
         1Rywc1DCrtTK1L7e/TjMNS4JsLoB41KjYPFukz5tF3/LGiWosbHuyDA7kkAyRdvu+POH
         HqjGaVskWP9dfb3rOSA8W/j6y6UFtrCIhLLmH+09T+a/FDSC4DH8i5YEptJkF0Ab0VnU
         glqw==
X-Gm-Message-State: AOAM530zMN5Y/RPTewVGB+gMrt2/xDcqDe0jZPcNaGYRJtjLfQ0z2UDY
        tbrTsDt8GIMYWKkmeEWcwjN07zXlPseTemW9b4gkoP1Z
X-Google-Smtp-Source: ABdhPJwAQUtDfz3YfULVTg/6MJtGI3S7xTdL4YP0sn2Lz9ypDvlA2Z0X5yku7FNm7oxjPBVxIxMqEBC14NQlmjn8tBU=
X-Received: by 2002:a50:bf03:: with SMTP id f3mr17152009edk.368.1590432785574;
 Mon, 25 May 2020 11:53:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200525130238.3614179-1-olteanv@gmail.com> <20200525172815.GA445190@localhost>
In-Reply-To: <20200525172815.GA445190@localhost>
From:   Vladimir Oltean <olteanv@gmail.com>
Date:   Mon, 25 May 2020 21:52:54 +0300
Message-ID: <CA+h21hqjcCpUuwZPONuP-qXn7pZv--avGVavQ_gT0n1guBNR_Q@mail.gmail.com>
Subject: Re: [PATCH] serial: 8250: probe all 16550A variants by default
To:     Josh Triplett <josh@joshtriplett.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org, jslaby@suse.com,
        andriy.shevchenko@linux.intel.com, lukas@wunner.de,
        heikki.krogerus@linux.intel.com, vigneshr@ti.com,
        lkml <linux-kernel@vger.kernel.org>, fido_max@inbox.ru,
        radu-andrei.bulie@nxp.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi Josh,

On Mon, 25 May 2020 at 20:28, Josh Triplett <josh@joshtriplett.org> wrote:
>
> On Mon, May 25, 2020 at 04:02:38PM +0300, Vladimir Oltean wrote:
> > On NXP T1040, the UART is typically detected as 16550A_FSL64. After said
> > patch, it gets detected as plain 16550A and the Linux console is
> > completely garbled and missing characters.
>
> Interesting that there's *new* powerpc hardware that needs these
> variants. I based the patch on the fact that, on x86 at least, hardware
> using these variants hasn't been made for a long time.
>
> In the hopes of preserving at least part of the benefit of the patch,
> could you please change it to `default y if !X86_64`?
>

Why don't you add CONFIG_SERIAL_8250_16550A_VARIANTS=n in x86_64_defconfig?

> >  drivers/tty/serial/8250/Kconfig | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/tty/serial/8250/Kconfig b/drivers/tty/serial/8250/Kconfig
> > index af0688156dd0..89c7ecb55619 100644
> > --- a/drivers/tty/serial/8250/Kconfig
> > +++ b/drivers/tty/serial/8250/Kconfig
> > @@ -63,6 +63,7 @@ config SERIAL_8250_PNP
> >  config SERIAL_8250_16550A_VARIANTS
> >       bool "Support for variants of the 16550A serial port"
> >       depends on SERIAL_8250
> > +     default y
> >       help
> >         The 8250 driver can probe for many variants of the venerable 16550A
> >         serial port. Doing so takes additional time at boot.
> > --
> > 2.25.1
> >

Thanks,
-Vladimir

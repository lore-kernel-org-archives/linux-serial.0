Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C15CC433B4
	for <linux-serial@archiver.kernel.org>; Thu, 22 Apr 2021 07:41:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C8BC6145C
	for <linux-serial@archiver.kernel.org>; Thu, 22 Apr 2021 07:41:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbhDVHld (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 22 Apr 2021 03:41:33 -0400
Received: from mail-vk1-f171.google.com ([209.85.221.171]:36585 "EHLO
        mail-vk1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230341AbhDVHlc (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 22 Apr 2021 03:41:32 -0400
Received: by mail-vk1-f171.google.com with SMTP id u200so7065117vku.3;
        Thu, 22 Apr 2021 00:40:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/TWauuJmn7fi7z7l55tpGt8f/5INsWS3V0dyZYNJLCo=;
        b=cxybwPVuHj9M0uMGC9WTXAr4ciyoOuvdGUax3VWXeVaRpNH7O7KM/ecAKHkOr+ugeb
         K58aU76tVvRdiHLHut1bb7hb6YbexaT4B9u512PNgDoQgnebmcm51ogOaeSr1UW7B9Np
         O7a/FpBIFkTQHOeZ5zx02fG5FVSTA1p+AK+GQXXWCgCetHDqB9aOIsRWbo7SslFK1HF/
         hcf3itnoWzQnRyurETUPhYPB/8cpPQcyfdfoxsqk1BSy6ghfYmZrRwuPBATsx+YxQJVf
         tcLLXlxx4XXFB7kbB5EFDi5QTLTVQM1jOD3iDEh5iZ8Aml3hEO0wpYMBVl6VyppdFohJ
         vkZw==
X-Gm-Message-State: AOAM530s3QVUh4p1ZtBtXC9XvsxDaMizNularjalEl+GRl9IEdivEoOE
        icvt1WJUF+TpRTGtXni6icgJ7aufguHr4rA261A=
X-Google-Smtp-Source: ABdhPJw38NNq77RiiP1MJPiesiP6Y3CUk3XusbdKRr2+r8VMqFBIMVxBH61ALMlfCczgtwHKJ/ylEJ7HCjKsuhYbn+4=
X-Received: by 2002:a1f:2504:: with SMTP id l4mr1405345vkl.5.1619077249224;
 Thu, 22 Apr 2021 00:40:49 -0700 (PDT)
MIME-Version: 1.0
References: <20210421143115.22797-1-johan@kernel.org> <202104220355.v8nwWx2T-lkp@intel.com>
 <CAMuHMdXKWDB89Hm-LQcpfTq=0yjm_xvQsQiD4QuEtW=yVymuRw@mail.gmail.com> <YIEnr9g8AmYFuLPh@hovoldconsulting.com>
In-Reply-To: <YIEnr9g8AmYFuLPh@hovoldconsulting.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 22 Apr 2021 09:40:38 +0200
Message-ID: <CAMuHMdV94SLyuyHUbrMue-0f_mTNn87WbWJu6an=aPFAjyHY8w@mail.gmail.com>
Subject: Re: [PATCH] serial: extend compile-test coverage
To:     Johan Hovold <johan@kernel.org>
Cc:     kernel test robot <lkp@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kbuild-all@lists.01.org,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi Johan,

On Thu, Apr 22, 2021 at 9:37 AM Johan Hovold <johan@kernel.org> wrote:
> On Thu, Apr 22, 2021 at 09:11:50AM +0200, Geert Uytterhoeven wrote:
> > On Thu, Apr 22, 2021 at 3:20 AM kernel test robot <lkp@intel.com> wrote:
> > > >> drivers/tty/serial/serial_txx9.c:987:12: warning: no previous prototype for function 'early_serial_txx9_setup' [-Wmissing-prototypes]
> > >    int __init early_serial_txx9_setup(struct uart_port *port)
> > >               ^
> > >    drivers/tty/serial/serial_txx9.c:987:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
> > >    int __init early_serial_txx9_setup(struct uart_port *port)
> > >    ^
> > >    static
> > >    1 warning generated.
> >
> > This function is called from arch/mips/txx9/generic/setup.c, and does
> > have a forward declaration in arch/mips/include/asm/txx9/generic.h.
> > Unfortunately the latter cannot be included from the driver, unless
> > the || COMPILE_TEST is dropped again.
>
> Thanks, Geert. I was just about to send a v2 without the txx9 hunk.

well, I guess apart from this (W=1!) warning, this driver still
compile-tests fine.
Do we consider hard-to-fix W=1 warnings to be legitimate blockers
for enabling compile-testing?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

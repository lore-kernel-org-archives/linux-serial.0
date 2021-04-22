Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72A1FC433B4
	for <linux-serial@archiver.kernel.org>; Thu, 22 Apr 2021 07:54:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 27E8861264
	for <linux-serial@archiver.kernel.org>; Thu, 22 Apr 2021 07:54:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230228AbhDVHzb (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 22 Apr 2021 03:55:31 -0400
Received: from mail-vs1-f54.google.com ([209.85.217.54]:36353 "EHLO
        mail-vs1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbhDVHza (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 22 Apr 2021 03:55:30 -0400
Received: by mail-vs1-f54.google.com with SMTP id k124so22494273vsk.3;
        Thu, 22 Apr 2021 00:54:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qpkaQhzeov50oc6KPA23GaI7TsaxSxtBoceUfcE/9Sk=;
        b=tywHBSVswq9QdPocJKMHHTzng98YZoJ6kD73BWfoE8ENclGBfiiSwZ/EpQodHA5wWu
         4fr48i8Wa+wzcBYCVcD+uHn78etjbcea4j9zM+lcoSJzVgk8Ob0lBz2wc3Ejc6zT3dxm
         yPBYGWxoAN5XcoCw/Pc7MpTl16MubMmEdWfPZztR/Jdc0L5GUuZJTZeVlLvKUMawiUwW
         kuJlCeNRPOCu0mdCBL5HNgs57YEbwGfHsj8/q0saAQUnM/+lbID1kJyMd8B8+PRe1+RN
         4dHYPEC2+04v5TXUSssdqfZfbtXGa7EzR2xePRFB/2YwjZwIeBPohc85siqXk37xiMle
         TtZg==
X-Gm-Message-State: AOAM531H2EJA3i9i71pt8iP80KedYORikDGeRJ/AavcYHfQUjPKP8IPy
        DnJNaCkMpDFf5yW+ENVmnjebNNqVlSNnZBf0AWE=
X-Google-Smtp-Source: ABdhPJwtFhxUw98Gc7OKUPl72+O0w1pCgzfb4sHhqy/yR9VoWa6zB6EU9CZP8E0Jy7h3yyInAnQSGlXsvFAfH9ejdYA=
X-Received: by 2002:a67:7c8c:: with SMTP id x134mr1512113vsc.40.1619078095714;
 Thu, 22 Apr 2021 00:54:55 -0700 (PDT)
MIME-Version: 1.0
References: <20210421143115.22797-1-johan@kernel.org> <202104220355.v8nwWx2T-lkp@intel.com>
 <CAMuHMdXKWDB89Hm-LQcpfTq=0yjm_xvQsQiD4QuEtW=yVymuRw@mail.gmail.com>
 <YIEnr9g8AmYFuLPh@hovoldconsulting.com> <CAMuHMdV94SLyuyHUbrMue-0f_mTNn87WbWJu6an=aPFAjyHY8w@mail.gmail.com>
 <YIErSfPrBbUtJ5bf@hovoldconsulting.com>
In-Reply-To: <YIErSfPrBbUtJ5bf@hovoldconsulting.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 22 Apr 2021 09:54:44 +0200
Message-ID: <CAMuHMdViQbA9yr=V81AxD7yij44Ks3Z1q-j2E6kPQBFOXWK5iQ@mail.gmail.com>
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

On Thu, Apr 22, 2021 at 9:52 AM Johan Hovold <johan@kernel.org> wrote:
> On Thu, Apr 22, 2021 at 09:40:38AM +0200, Geert Uytterhoeven wrote:
> > On Thu, Apr 22, 2021 at 9:37 AM Johan Hovold <johan@kernel.org> wrote:
> > > On Thu, Apr 22, 2021 at 09:11:50AM +0200, Geert Uytterhoeven wrote:
> > > > On Thu, Apr 22, 2021 at 3:20 AM kernel test robot <lkp@intel.com> wrote:
> > > > > >> drivers/tty/serial/serial_txx9.c:987:12: warning: no previous prototype for function 'early_serial_txx9_setup' [-Wmissing-prototypes]
> > > > >    int __init early_serial_txx9_setup(struct uart_port *port)
> > > > >               ^
> > > > >    drivers/tty/serial/serial_txx9.c:987:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
> > > > >    int __init early_serial_txx9_setup(struct uart_port *port)
> > > > >    ^
> > > > >    static
> > > > >    1 warning generated.
> > > >
> > > > This function is called from arch/mips/txx9/generic/setup.c, and does
> > > > have a forward declaration in arch/mips/include/asm/txx9/generic.h.
> > > > Unfortunately the latter cannot be included from the driver, unless
> > > > the || COMPILE_TEST is dropped again.
> > >
> > > Thanks, Geert. I was just about to send a v2 without the txx9 hunk.
> >
> > well, I guess apart from this (W=1!) warning, this driver still
> > compile-tests fine.
> > Do we consider hard-to-fix W=1 warnings to be legitimate blockers
> > for enabling compile-testing?
>
> Since the build bots have enabled them (and people have turned it into a
> crusade to suppress every W=1 warning by any means) I think it's
> reasonable to not introduce new ones knowingly.
>
> And I'm not too motivated right now to try to work around this one
> myself. The idea here was just to enable COMPILE_TEST for drivers that
> did not have any build-time dependencies.

OK.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

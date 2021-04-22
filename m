Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A226AC433ED
	for <linux-serial@archiver.kernel.org>; Thu, 22 Apr 2021 07:12:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6823E60200
	for <linux-serial@archiver.kernel.org>; Thu, 22 Apr 2021 07:12:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229962AbhDVHMg (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 22 Apr 2021 03:12:36 -0400
Received: from mail-ua1-f41.google.com ([209.85.222.41]:43863 "EHLO
        mail-ua1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbhDVHMg (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 22 Apr 2021 03:12:36 -0400
Received: by mail-ua1-f41.google.com with SMTP id a8so10787011uan.10;
        Thu, 22 Apr 2021 00:12:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MnlsbYYFiDldp+3bllzRvToouY6x7yofcE/PI7JdOxM=;
        b=X6pF5DEHZjrasgVQ0tuuW9+iH6oh7+S/L4Pn6t9UIptmpV1YGJlNNV4PVuYwRBc1jd
         jr+XFMtHPC+pKJQ3cMykni/THQ+hiXMy3850A3rTqsMcB9KASUnAZpxN+seBLB/6II2L
         pwbaKJAkeAcxOo3xTnYCzZ0LbPKdYzJCWTYSRGKqCncqiDTpi09h0t0Eukl0GxiJMU2c
         qoMcPqWlhd7OpUINj8RwWa/JRJtwPfQbr+JSk45RFV28nDIJGcPdLo1grROwbc+qIj7p
         iUYHPrh0YKd+B1VcFnhF76/9P3Hau/Rr38SASEJqwgSaqt9McAGBqbgeYEkPV6fIXzys
         WHDA==
X-Gm-Message-State: AOAM533pBA3AO4FyEWoduqUQfXiSEU2qhmlKb9SQstFxdvHybwPc1nSX
        RTSpJ3qqzwJD7o0zRgeAyRDFYmLv4wGWTHneVXYsYy7gaoE=
X-Google-Smtp-Source: ABdhPJzlZzpafkkH3lhkrdeG76hYFiRXOGcI1VYaAi8U4UNlmcyPuLSEVGePT1hAZ1A8OP8+r1ZKJwNbJjmKRPY3cGo=
X-Received: by 2002:ab0:6306:: with SMTP id a6mr1141667uap.2.1619075521369;
 Thu, 22 Apr 2021 00:12:01 -0700 (PDT)
MIME-Version: 1.0
References: <20210421143115.22797-1-johan@kernel.org> <202104220355.v8nwWx2T-lkp@intel.com>
In-Reply-To: <202104220355.v8nwWx2T-lkp@intel.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 22 Apr 2021 09:11:50 +0200
Message-ID: <CAMuHMdXKWDB89Hm-LQcpfTq=0yjm_xvQsQiD4QuEtW=yVymuRw@mail.gmail.com>
Subject: Re: [PATCH] serial: extend compile-test coverage
To:     kernel test robot <lkp@intel.com>
Cc:     Johan Hovold <johan@kernel.org>,
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

On Thu, Apr 22, 2021 at 3:20 AM kernel test robot <lkp@intel.com> wrote:
> I love your patch! Perhaps something to improve:
>
> [auto build test WARNING on tty/tty-testing]
> [also build test WARNING on usb/usb-testing v5.12-rc8 next-20210421]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch]
>
> url:    https://github.com/0day-ci/linux/commits/Johan-Hovold/serial-extend-compile-test-coverage/20210421-234950
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
> config: x86_64-randconfig-a014-20210421 (attached as .config)
> compiler: clang version 13.0.0 (https://github.com/llvm/llvm-project d87b9b81ccb95217181ce75515c6c68bbb408ca4)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # install x86_64 cross compiling tool for clang build
>         # apt-get install binutils-x86-64-linux-gnu
>         # https://github.com/0day-ci/linux/commit/c010530fa587261662c6abdb59ade994645dcfa8
>         git remote add linux-review https://github.com/0day-ci/linux
>         git fetch --no-tags linux-review Johan-Hovold/serial-extend-compile-test-coverage/20210421-234950
>         git checkout c010530fa587261662c6abdb59ade994645dcfa8
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 ARCH=x86_64
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>
> All warnings (new ones prefixed by >>):
>
> >> drivers/tty/serial/serial_txx9.c:987:12: warning: no previous prototype for function 'early_serial_txx9_setup' [-Wmissing-prototypes]
>    int __init early_serial_txx9_setup(struct uart_port *port)
>               ^
>    drivers/tty/serial/serial_txx9.c:987:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
>    int __init early_serial_txx9_setup(struct uart_port *port)
>    ^
>    static
>    1 warning generated.

This function is called from arch/mips/txx9/generic/setup.c, and does
have a forward declaration in arch/mips/include/asm/txx9/generic.h.
Unfortunately the latter cannot be included from the driver, unless
the || COMPILE_TEST is dropped again.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

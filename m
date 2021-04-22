Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65837C433ED
	for <linux-serial@archiver.kernel.org>; Thu, 22 Apr 2021 07:52:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 28E536121E
	for <linux-serial@archiver.kernel.org>; Thu, 22 Apr 2021 07:52:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229655AbhDVHxK (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 22 Apr 2021 03:53:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:40238 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230365AbhDVHxK (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 22 Apr 2021 03:53:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D504D61445;
        Thu, 22 Apr 2021 07:52:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619077955;
        bh=Io3ZzfuQqd3zpw6RtkrnJ+HSBrC6H1N1FqQjS//UMmU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=S9mp3w9aezP1Xe/u0kDjdGlX23W/gDDPwzBFR+LjjjW4ao92t5eC0TCXUhsaKH+7M
         zzkpMssl+MGWQPMmgvmFMFTfpWm+RU8u1+PRyh9nmDPlMg+e+rPSQ7sJss6sWr3VrO
         MVAC0ArKB37vfbmoAqz2SVAC+aZm2lbeGSU5vZW89vDmVZbG7u6PtpQnRqwkdQs3Gi
         SNXNWFlHF7x8VKYG1Vqny+QmQMSEUbRvtVTjPym9/gicovjfeQ3gxODLUwDEv+H1/0
         LvJ+NbdWlmy0OC57xhVRPZiMDRvW9b4lZTOSX6/JEtCEitUHlLrssNQ6ncEJF11+aY
         8csj31IMDUX2A==
Received: from johan by xi.lan with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1lZU8f-0007XQ-2M; Thu, 22 Apr 2021 09:52:41 +0200
Date:   Thu, 22 Apr 2021 09:52:41 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     kernel test robot <lkp@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kbuild-all@lists.01.org,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] serial: extend compile-test coverage
Message-ID: <YIErSfPrBbUtJ5bf@hovoldconsulting.com>
References: <20210421143115.22797-1-johan@kernel.org>
 <202104220355.v8nwWx2T-lkp@intel.com>
 <CAMuHMdXKWDB89Hm-LQcpfTq=0yjm_xvQsQiD4QuEtW=yVymuRw@mail.gmail.com>
 <YIEnr9g8AmYFuLPh@hovoldconsulting.com>
 <CAMuHMdV94SLyuyHUbrMue-0f_mTNn87WbWJu6an=aPFAjyHY8w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdV94SLyuyHUbrMue-0f_mTNn87WbWJu6an=aPFAjyHY8w@mail.gmail.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, Apr 22, 2021 at 09:40:38AM +0200, Geert Uytterhoeven wrote:
> Hi Johan,
> 
> On Thu, Apr 22, 2021 at 9:37 AM Johan Hovold <johan@kernel.org> wrote:
> > On Thu, Apr 22, 2021 at 09:11:50AM +0200, Geert Uytterhoeven wrote:
> > > On Thu, Apr 22, 2021 at 3:20 AM kernel test robot <lkp@intel.com> wrote:
> > > > >> drivers/tty/serial/serial_txx9.c:987:12: warning: no previous prototype for function 'early_serial_txx9_setup' [-Wmissing-prototypes]
> > > >    int __init early_serial_txx9_setup(struct uart_port *port)
> > > >               ^
> > > >    drivers/tty/serial/serial_txx9.c:987:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
> > > >    int __init early_serial_txx9_setup(struct uart_port *port)
> > > >    ^
> > > >    static
> > > >    1 warning generated.
> > >
> > > This function is called from arch/mips/txx9/generic/setup.c, and does
> > > have a forward declaration in arch/mips/include/asm/txx9/generic.h.
> > > Unfortunately the latter cannot be included from the driver, unless
> > > the || COMPILE_TEST is dropped again.
> >
> > Thanks, Geert. I was just about to send a v2 without the txx9 hunk.
> 
> well, I guess apart from this (W=1!) warning, this driver still
> compile-tests fine.
> Do we consider hard-to-fix W=1 warnings to be legitimate blockers
> for enabling compile-testing?

Since the build bots have enabled them (and people have turned it into a
crusade to suppress every W=1 warning by any means) I think it's
reasonable to not introduce new ones knowingly.

And I'm not too motivated right now to try to work around this one
myself. The idea here was just to enable COMPILE_TEST for drivers that
did not have any build-time dependencies.

Johan

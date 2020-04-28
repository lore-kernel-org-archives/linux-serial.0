Return-Path: <SRS0=KIft=6M=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 572AAC83000
	for <linux-serial@archiver.kernel.org>; Tue, 28 Apr 2020 21:40:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 22F1D20730
	for <linux-serial@archiver.kernel.org>; Tue, 28 Apr 2020 21:40:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Q164BEzQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726423AbgD1VkB (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 28 Apr 2020 17:40:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726256AbgD1VkB (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 28 Apr 2020 17:40:01 -0400
Received: from mail-ua1-x944.google.com (mail-ua1-x944.google.com [IPv6:2607:f8b0:4864:20::944])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1860EC03C1AC
        for <linux-serial@vger.kernel.org>; Tue, 28 Apr 2020 14:40:00 -0700 (PDT)
Received: by mail-ua1-x944.google.com with SMTP id u12so101434uau.10
        for <linux-serial@vger.kernel.org>; Tue, 28 Apr 2020 14:40:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=De9un6BJ2p4x3KGWjUlROhvJ0MQt7eKKFJEAHbkYVKo=;
        b=Q164BEzQpMCO+yXR5UTZKVBBSmsRxOmAyN/KrF3t7TxsTwMmrQgCsqsuZL+BeMJL03
         XecUGYvDtMil6cTU9seGNu+kDsVffn8AP7rW5uFNrhocyNYZybOPErY5sXsUxUhf0DiW
         9pUAv3ehkC7LHPm8Cfr3GXeTslc09VpGfVEKw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=De9un6BJ2p4x3KGWjUlROhvJ0MQt7eKKFJEAHbkYVKo=;
        b=sBN0TvkwGZB+8VSwSp6urnCbagEpnM5FfaNiYzdTXZ/3SmlkXZ+wVEgsaYZ4vTNMAG
         LIuphpkVrtvghpbMprcY8/+E8rXg1pocdCilQO+W1fUJdEXtfOERecA6WyYhuHs1ogcO
         T8j3nX4GocP0nQaop7WsjOLdigaRJ+o2MTJqoeqSk3Ey7yUgr5OjbcNEEt3vdCLMS+a0
         uiFMhdQtwovn0ChIh+b6p5ftN1aPhl93B7uhBWzCw+pQfWW7IYampQUmx7t6enDK6bJm
         4KWcWfZH0tCM7hT+pe/bmoNeLj+qYHat/iFK5zZrEkb7KJtQLsFJHmbhAFt7F09n6lqg
         U6rg==
X-Gm-Message-State: AGi0PuZJLaQaw+GbSSGKn4uGG9ur9euyhFT/044vDBnPBy6eSB/D+8qB
        mdBTbvAUr98gHSc87qqgrHSc3knGmJQ=
X-Google-Smtp-Source: APiQypKmVc1wZ8whrjoDHD+Ag9agEZ37qrwcxXaej3JSLfa+RO4Qf3zdLe+tj4REUdXu7xP0/bhyCw==
X-Received: by 2002:ab0:32d2:: with SMTP id f18mr21822103uao.141.1588109999037;
        Tue, 28 Apr 2020 14:39:59 -0700 (PDT)
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com. [209.85.222.51])
        by smtp.gmail.com with ESMTPSA id w2sm4622329vso.19.2020.04.28.14.39.58
        for <linux-serial@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Apr 2020 14:39:58 -0700 (PDT)
Received: by mail-ua1-f51.google.com with SMTP id i5so153820uaq.1
        for <linux-serial@vger.kernel.org>; Tue, 28 Apr 2020 14:39:58 -0700 (PDT)
X-Received: by 2002:a67:c40c:: with SMTP id c12mr23285523vsk.106.1588109589393;
 Tue, 28 Apr 2020 14:33:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200421211447.193860-1-dianders@chromium.org>
 <20200421141234.v2.7.I7d5eb42c6180c831d47aef1af44d0b8be3fac559@changeid> <20200427164619.kw4mihmoxmxzjk66@holly.lan>
In-Reply-To: <20200427164619.kw4mihmoxmxzjk66@holly.lan>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 28 Apr 2020 14:32:57 -0700
X-Gmail-Original-Message-ID: <CAD=FV=W9nZKOB8powEuSecnwkDA01YR0c2uNY87+nV8+5jZZug@mail.gmail.com>
Message-ID: <CAD=FV=W9nZKOB8powEuSecnwkDA01YR0c2uNY87+nV8+5jZZug@mail.gmail.com>
Subject: Re: [PATCH v2 7/9] Documentation: kgdboc: Document new
 earlycon_kgdboc parameter
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Jason Wessel <jason.wessel@windriver.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kgdb-bugreport@lists.sourceforge.net,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, bp@alien8.de,
        linux-serial@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Frank Rowand <frowand.list@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Jiri Slaby <jslaby@suse.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Borislav Petkov <bp@suse.de>, Juergen Gross <jgross@suse.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi,

On Mon, Apr 27, 2020 at 9:46 AM Daniel Thompson
<daniel.thompson@linaro.org> wrote:
>
> On Tue, Apr 21, 2020 at 02:14:45PM -0700, Douglas Anderson wrote:
> > The recent patch ("kgdboc: Add earlycon_kgdboc to support early kgdb
> > using boot consoles") adds a new kernel command line parameter.
> > Document it.
> >
> > Note that the patch adding the feature does some comparing/contrasting
> > of "earlycon_kgdboc" vs. the existing "ekgdboc".  See that patch for
> > more details, but briefly "ekgdboc" can be used _instead_ of "kgdboc"
> > and just makes "kgdboc" do its normal initialization early (only works
> > if your tty driver is already ready).  The new "earlycon_kgdboc" works
> > in combination with "kgdboc" and is backed by boot consoles.
> >
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > ---
> >
> > Changes in v2: None
> >
> >  .../admin-guide/kernel-parameters.txt         | 20 +++++++++++++++++++
> >  Documentation/dev-tools/kgdb.rst              | 14 +++++++++++++
> >  2 files changed, 34 insertions(+)
> >
> > diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> > index f2a93c8679e8..588625ec2993 100644
> > --- a/Documentation/admin-guide/kernel-parameters.txt
> > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > @@ -1132,6 +1132,22 @@
> >                       address must be provided, and the serial port must
> >                       already be setup and configured.
> >
> > +     earlycon_kgdboc=        [KGDB,HW]
> > +                     If the boot console provides the ability to read
> > +                     characters and can work in polling mode, you can use
> > +                     this parameter to tell kgdb to use it as a backend
> > +                     until the normal console is registered. Intended to
> > +                     be used together with the kgdboc parameter which
> > +                     specifies the normal console to transition to.
> > +
> > +                     The the name of the early console should be specified
> > +                     as the value of this parameter. Note that the name of
> > +                     the early console might be different than the tty
> > +                     name passed to kgdboc. If only one boot console with
> > +                     a read() function is enabled it's OK to leave the
> > +                     value blank and the first boot console that implements
> > +                     read() will be picked.
>
> There's no need for the "If only one boot console with a read()
> funcuiton is enabled" here,
>
> Seeing this in alphabetic order in this patch it also crosses my mind
> that kgdboc_earlycon might be a better name so that is sorts closer
> to the other kgdb options. This is a kgdboc feature that uses earlycon
> not an earlycon feature that uses kgdboc.

OK.  'git format-patch', sed, and 'git am' for the win.


> > +
> >       earlyprintk=    [X86,SH,ARM,M68k,S390]
> >                       earlyprintk=vga
> >                       earlyprintk=sclp
> > @@ -1190,6 +1206,10 @@
> >                       This is designed to be used in conjunction with
> >                       the boot argument: earlyprintk=vga
> >
> > +                     This parameter works in place of the kgdboc parameter
> > +                     but can only be used if the backing tty is available
> > +                     very early in the boot process.
> > +
>
> I wonder if pragmatic advice is more useful:
>
>   For early debugging via a serial port see earlycon_kgdboc instead.

Done.


> >       edd=            [EDD]
> >                       Format: {"off" | "on" | "skip[mbr]"}
> >
> > diff --git a/Documentation/dev-tools/kgdb.rst b/Documentation/dev-tools/kgdb.rst
> > index d38be58f872a..c0b321403d9a 100644
> > --- a/Documentation/dev-tools/kgdb.rst
> > +++ b/Documentation/dev-tools/kgdb.rst
> > @@ -274,6 +274,20 @@ don't like this are to hack gdb to send the :kbd:`SysRq-G` for you as well as
> >  on the initial connect, or to use a debugger proxy that allows an
> >  unmodified gdb to do the debugging.
> >
> > +Kernel parameter: ``earlycon_kgdboc``
> > +-------------------------------------
> > +
> > +If you specify the kernel parameter ``earlycon_kgdboc`` and your serial
> > +driver registers a boot console that supports polling (doesn't need
> > +interrupts and implements a nonblocking read() function) kgdb will attempt
> > +to work using the boot console until it can transition to the regular
> > +tty driver specified by the ``kgdboc`` parameter.
> > +
> > +Normally there is only one boot console (especially that implements the
> > +read() function) so just adding ``earlycon_kgdboc`` on its own is
> > +sufficient to make this work.  If you have more than one boot console you
> > +can add the boot console's name to differentiate.
> > +
>
> I think we need an example here. The example in the patch header for
> the previous patch was useful (at least for me).

Done.

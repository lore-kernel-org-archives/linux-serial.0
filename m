Return-Path: <SRS0=iED7=7C=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41F14C433E3
	for <linux-serial@archiver.kernel.org>; Wed, 20 May 2020 09:05:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E305207ED
	for <linux-serial@archiver.kernel.org>; Wed, 20 May 2020 09:05:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gsg+Cs7g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbgETJFb (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 20 May 2020 05:05:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726619AbgETJFa (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 20 May 2020 05:05:30 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2AABC061A0E;
        Wed, 20 May 2020 02:05:30 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id u5so1137513pgn.5;
        Wed, 20 May 2020 02:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=NRHzvHn1j06kdZmHKeAQCTbbxh0DL1ErcnMNWhv1xvs=;
        b=Gsg+Cs7gs+30dP9JnggONTcLAOA8wf6wkvlxhgkxRKeWPc4dCJuLIQvfMppzpJGK2H
         rVQNkkzIee+ex5QQ5Qw2cGTnktiGQWvsC4Jz2fljhX+WuIi66GjGp2OuQEQeR+FlaSPZ
         q+BbtMFA7VwYqH3HAa3aPa+8rnPNB2U9srEu/I2xieOW9EDOlj0tIURrC+khFZNB8iXS
         KcCTwx30Fxo0gWmwEJ6colhr1fDGM6hsZ+DhE+qoBLc0lrP9kCFFRuhGZV0OxYmDdWZl
         dBtdlFZ81XLEVHYJ9da5482zQpD/x4Uw2B3ICaiE/iTvFq3PEQXl8JLmn3qEtIMy19Q0
         foGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=NRHzvHn1j06kdZmHKeAQCTbbxh0DL1ErcnMNWhv1xvs=;
        b=fUXB3qlwI6j6VxC2jzeMW/zNAk3XkHC69XeeHFyOTGuRzLZ0smLzg2t3JgIArK44OV
         u2KJsyyHvJL2KwM6fVhgbWbHmnujDwI0Bfqgoj7+5z0iuqgYNyAfiFyi+fK4JXt41DZN
         laf+jrWYd75LRFtpAsba1DNr6Yt1d/l63uJS22Xvovzv5pIlW1GZK8JQgeT+wMUOOWFs
         gSSPWhbLV9ZjotbjxFbeJZZFffXiVT6CoEunMc1OJtIBsoLi3hOlzfv5JbCu0sc457wl
         ptV+5zkAhsG4yG0pa4yrCi7KJB/c1X4PT40xw3dq6tN7NVG3FFxNAQCcIzfrERMypaJZ
         kgqQ==
X-Gm-Message-State: AOAM530xTxO3KopSeu/gGPeWQAJ3qIMk/2P4yLvc59RR7m9WCIl+Ck4j
        9UV2G+e0vH2fZfUnIVCvPN4sbqw16YI3O2/U1Iw=
X-Google-Smtp-Source: ABdhPJxolDQZpZlKXESKruYZArLxtcIc7XMvXQgU1n42ugJ2tJki5LhCBCCTsnz9Yqutpw7a9rnVg+kwZMjn3W6rhC8=
X-Received: by 2002:a63:7b4b:: with SMTP id k11mr3147445pgn.411.1589965530404;
 Wed, 20 May 2020 02:05:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200520083821.9602-1-gengcixi@gmail.com> <20200520085111.GE2837844@kroah.com>
In-Reply-To: <20200520085111.GE2837844@kroah.com>
From:   Cixi Geng <gengcixi@gmail.com>
Date:   Wed, 20 May 2020 17:04:54 +0800
Message-ID: <CAF12kFsxiBC3sqvHbp1i5HLXxDnvM2ApFSKGpu-hjGW9LBhd0A@mail.gmail.com>
Subject: Re: [RFC][PATCH V2] GCOV: profile by modules
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     oberpar@linux.ibm.com, linux-serial@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        jslaby@suse.com, Orson Zhai <orsonzhai@gmail.com>,
        zhang.lyra@gmail.com, Cixi Geng <cixi.geng1@unisoc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Thank you for guidances, I will fix error and upload new patch

Greg KH <gregkh@linuxfoundation.org> =E4=BA=8E2020=E5=B9=B45=E6=9C=8820=E6=
=97=A5=E5=91=A8=E4=B8=89 =E4=B8=8B=E5=8D=884:51=E5=86=99=E9=81=93=EF=BC=9A
>
> On Wed, May 20, 2020 at 04:38:21PM +0800, gengcixi@gmail.com wrote:
> > From: Cixi Geng <cixi.geng1@unisoc.com>
> >
> > ---
> > Replace symbol GCOV_PROFILE_MODULES with GCOV_PROFILE_PREREQS
> > ---
> > The CONFIG_GCOV_PROFILE_ALL will compile kernel by profiling entire
> > kernel which will lead to kernel run slower.Use GCOV_PROFILE_PREREQS
> > to control part of the kernel modules to open gcov.
> >
> > Only add SERIAL_GCOV for an example.
> >
> > Signed-off-by: Cixi Geng <cixi.geng1@unisoc.com>
> > ---
> >  drivers/tty/serial/Kconfig  |  6 ++++++
> >  drivers/tty/serial/Makefile |  1 +
> >  kernel/gcov/Kconfig         | 14 ++++++++++++++
> >  3 files changed, 21 insertions(+)
> >
> > diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
> > index adf9e80e7dc9..964df1a2989c 100644
> > --- a/drivers/tty/serial/Kconfig
> > +++ b/drivers/tty/serial/Kconfig
> > @@ -1566,3 +1566,9 @@ endmenu
> >
> >  config SERIAL_MCTRL_GPIO
> >       tristate
> > +
> > +config SERIAL_GCOV
> > +       bool "open gcov for serial"
>
> What do you mean by "open"?  And Kconfig entries are usually Upper Case" =
:)
>
> > +       depends on GCOV_PROFILE_PREREQS
> > +       help
> > +         Say Y here to enable gcov in serial.
>
> I think we need more text here.
>
>
> > diff --git a/drivers/tty/serial/Makefile b/drivers/tty/serial/Makefile
> > index d056ee6cca33..7be1202286d2 100644
> > --- a/drivers/tty/serial/Makefile
> > +++ b/drivers/tty/serial/Makefile
> > @@ -2,6 +2,7 @@
> >  #
> >  # Makefile for the kernel serial device drivers.
> >  #
> > +GCOV_PROFILE :=3D $(CONFIG_SERIAL_GCOV)
> >
> >  obj-$(CONFIG_SERIAL_CORE) +=3D serial_core.o
> >
> > diff --git a/kernel/gcov/Kconfig b/kernel/gcov/Kconfig
> > index 3941a9c48f83..91cc8f3c7c43 100644
> > --- a/kernel/gcov/Kconfig
> > +++ b/kernel/gcov/Kconfig
> > @@ -51,6 +51,20 @@ config GCOV_PROFILE_ALL
> >       larger and run slower. Also be sure to exclude files from profili=
ng
> >       which are not linked to the kernel image to prevent linker errors=
.
> >
> > +config GCOV_PROFILE_PREREQS
> > +     bool "Profile Kernel subsytem"
> > +     depends on !COMPILE_TEST
> > +     depends on GCOV_KERNEL
> > +     default n
>
> default is always 'n', no need to list that
>
> > +     help
> > +     This options activates profiling for the specified kernel modules=
.
> > +
> > +     If unsure, say N.
> > +
> > +     When some modules need Gcov data, enable this config, then config=
ure
> > +     with gcov on the corresponding modules configs.The directories or=
 files
>
> '. '?
>
> > +     of these modules will be added profiling flags after kernel compi=
le.
>
> The lines under "help" need to be indented more, right?
>
> thanks,
>
> greg k-h

Return-Path: <SRS0=QtZL=CZ=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65AB7C43461
	for <linux-serial@archiver.kernel.org>; Wed, 16 Sep 2020 18:36:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 26F2B21974
	for <linux-serial@archiver.kernel.org>; Wed, 16 Sep 2020 18:36:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bSy/Ps+e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728014AbgIPSgQ (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 16 Sep 2020 14:36:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728033AbgIPS3N (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 16 Sep 2020 14:29:13 -0400
Received: from mail-yb1-xb41.google.com (mail-yb1-xb41.google.com [IPv6:2607:f8b0:4864:20::b41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE7E6C0A8897;
        Wed, 16 Sep 2020 05:56:21 -0700 (PDT)
Received: by mail-yb1-xb41.google.com with SMTP id x8so5341604ybm.3;
        Wed, 16 Sep 2020 05:56:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=cKaWYVxRkEWbSmE1Xcb5qQ3adbZiHgx8ByEmJ7c4d9U=;
        b=bSy/Ps+eNqepLdsenjmyCaBg7NarZr3Dup815f2Yq6ozCRRgdaEuRhnaFqTm9HZN0O
         cMAqlReM6jWcRcua+hSZ1Ow3boKULrs0YiTKq47/j+DQBLfm7GTDhbiBeDTU/QWS6VWR
         J/Ar3EmSIFbvlQ9pl70OINmZdhv/zzUNK0xGtLJI7Qi9FpP1mkx2UC8p8GMyme4/B7TJ
         6G71CM0K4gaXH/8fjGO6KpMKgTv+gdvm2CaJIKMKMGNWUtaJMnHw94v9iwZ38mwAM48D
         sLOwl4T+h/MShljR0B976FhgErfOxvCu9YzcyI6A2PBCi8tPvAIbyxdy+MJKDpVcw8SP
         PK4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=cKaWYVxRkEWbSmE1Xcb5qQ3adbZiHgx8ByEmJ7c4d9U=;
        b=HlmVgS7AmejUpIQCmWYcpSOLe8aFt88tR+ID0NjEVgqZTAjj4CoYWbvYJGEeghbduK
         GNOYCqgUr8cZYju7RVOdIzL8XiBYQ2VQXQriND+PuAEm4VwS2BYJFlqgB+fxp09Wzdsa
         f57OFDed2TmniBWR6PG3lDMndO1R5F3tVv+W0ad7+dvlF+V24AhjdWFT/pEzez2twiS+
         SCisstGSfshM89JRt81HIn8iTyRQ1AVlOSVnSTyW+qB3Jo/diIzCLkG/hrH4K71naf4o
         57jPzBwqHxIVkA2CkMtMt80EJAiWWox5DhddT4sfje9/uSK3yneA3CkH/f5apin/ORLa
         TWMQ==
X-Gm-Message-State: AOAM531/Dj4NcG2/vALovRWEi8bYFx9HIF5ALAHTx68iI45w32C1VlnZ
        FzK7m/v5NOpTRW5p1nPToudmPjZ2tUKf394KP2I=
X-Google-Smtp-Source: ABdhPJwBRXx0VqH0uQv90grTq3eaZr1B9Xi7bR6RDuBjvqVkr9+yLtEzxhLOXaKlOplgfTn+AgnlmopGUOzw2Try13c=
X-Received: by 2002:a25:b212:: with SMTP id i18mr34347976ybj.148.1600260981032;
 Wed, 16 Sep 2020 05:56:21 -0700 (PDT)
MIME-Version: 1.0
References: <20200727085132.29754-1-gengcixi@gmail.com> <CAF12kFuss4AQZSBX+A2G_fWjka3C4kpf4iDWU9QJY=AWigoxqg@mail.gmail.com>
In-Reply-To: <CAF12kFuss4AQZSBX+A2G_fWjka3C4kpf4iDWU9QJY=AWigoxqg@mail.gmail.com>
From:   Cixi Geng <gengcixi@gmail.com>
Date:   Wed, 16 Sep 2020 20:55:45 +0800
Message-ID: <CAF12kFtPQ0bUKrr4X8MjLCTfFYkRVk6BRaLb30W59GwtWQd6xA@mail.gmail.com>
Subject: Re: [PATCH V7] GCOV: Add config to check the preqequisites situation
To:     Greg KH <gregkh@linuxfoundation.org>, jslaby@suse.com,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        linux-serial@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     Orson Zhai <orsonzhai@gmail.com>, zhang.lyra@gmail.com,
        Cixi Geng <cixi.geng1@unisoc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi ALL=EF=BC=9A
Not recieve more advise for a long time ,
Can this submission be merged recently?

Cixi Geng <gengcixi@gmail.com> =E4=BA=8E2020=E5=B9=B48=E6=9C=8820=E6=97=A5=
=E5=91=A8=E5=9B=9B =E4=B8=8B=E5=8D=888:40=E5=86=99=E9=81=93=EF=BC=9A
>
> Hi All:
>
> Does this patch need more modification?
>
> <gengcixi@gmail.com> =E4=BA=8E2020=E5=B9=B47=E6=9C=8827=E6=97=A5=E5=91=A8=
=E4=B8=80 =E4=B8=8B=E5=8D=884:51=E5=86=99=E9=81=93=EF=BC=9A
> >
> > From: Cixi Geng <cixi.geng1@unisoc.com>
> >
> > Introduce new configuration option GCOV_PROFILE_PREREQS that can be
> > used to check whether the prerequisites for enabling gcov profiling
> > for specific files and directories are met.
> >
> > Only add SERIAL_GCOV for an example.
> >
> > Signed-off-by: Cixi Geng <cixi.geng1@unisoc.com>
> > ---
> >  drivers/tty/serial/Kconfig  |  7 +++++++
> >  drivers/tty/serial/Makefile |  1 +
> >  kernel/gcov/Kconfig         | 12 ++++++++++++
> >  3 files changed, 20 insertions(+)
> >
> > diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
> > index 780908d43557..55b128b6b31d 100644
> > --- a/drivers/tty/serial/Kconfig
> > +++ b/drivers/tty/serial/Kconfig
> > @@ -1576,3 +1576,10 @@ endmenu
> >
> >  config SERIAL_MCTRL_GPIO
> >         tristate
> > +
> > +config SERIAL_GCOV
> > +       bool "Enable profile gcov for serial directory"
> > +       depends on GCOV_PROFILE_PREREQS
> > +       help
> > +         The SERIAL_GCOV will add Gcov profiling flags when kernel com=
piles.
> > +         Say 'Y' here if you want the gcov data for the serial directo=
ry,
> > diff --git a/drivers/tty/serial/Makefile b/drivers/tty/serial/Makefile
> > index d056ee6cca33..17272733db95 100644
> > --- a/drivers/tty/serial/Makefile
> > +++ b/drivers/tty/serial/Makefile
> > @@ -3,6 +3,7 @@
> >  # Makefile for the kernel serial device drivers.
> >  #
> >
> > +GCOV_PROFILE :=3D $(CONFIG_SERIAL_GCOV)
> >  obj-$(CONFIG_SERIAL_CORE) +=3D serial_core.o
> >
> >  obj-$(CONFIG_SERIAL_EARLYCON) +=3D earlycon.o
> > diff --git a/kernel/gcov/Kconfig b/kernel/gcov/Kconfig
> > index 3110c77230c7..bb2e1fb85743 100644
> > --- a/kernel/gcov/Kconfig
> > +++ b/kernel/gcov/Kconfig
> > @@ -51,4 +51,16 @@ config GCOV_PROFILE_ALL
> >         larger and run slower. Also be sure to exclude files from profi=
ling
> >         which are not linked to the kernel image to prevent linker erro=
rs.
> >
> > +config GCOV_PROFILE_PREREQS
> > +       bool "Profile Kernel for prereqs"
> > +       depends on GCOV_KERNEL
> > +       depends on  !COMPILE_TEST
> > +       def_bool y if GCOV_KERNEL && !COMPILE_TEST
> > +       help
> > +         This options activates profiling for the specified kernel mod=
ules.
> > +
> > +         When some modules need Gcov data, enable this config, then co=
nfigure
> > +         with gcov on the corresponding modules,The directories or fil=
es of
> > +         these modules will be added profiling flags after kernel comp=
ile.
> > +
> >  endmenu
> > --
> > 2.17.1
> >

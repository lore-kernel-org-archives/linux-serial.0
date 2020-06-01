Return-Path: <SRS0=+B2M=7O=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C59F0C433DF
	for <linux-serial@archiver.kernel.org>; Mon,  1 Jun 2020 10:56:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F4BD20679
	for <linux-serial@archiver.kernel.org>; Mon,  1 Jun 2020 10:56:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hn+RZvKp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725972AbgFAK4m (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 1 Jun 2020 06:56:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725788AbgFAK4l (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 1 Jun 2020 06:56:41 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DD70C061A0E;
        Mon,  1 Jun 2020 03:56:40 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id n9so1006567plk.1;
        Mon, 01 Jun 2020 03:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=WvtTQ9EHafgZQreyIYmWntetDMEcUBIjpiRzw8PhfhI=;
        b=hn+RZvKpABbnnC6PcU+q6x+LcvCPjZjjscpctJdGLpafU5Rkb9xre5LUsdHM9v2qxA
         ejNWGO1R3zcQqpFAW6/GgYK+51z98T3GcSoxUxx6/P3PVsrgfZy9MpTC+Amp1zYFyxg6
         /Z2Z5RhWpy+1xX+0snzkayKRMsGvfn6m4MNMsgwIz1TECqICBMq1s6iwTSDrsGbmP3Ni
         vqj+cuslRIHKfP6syX6KT3c0to97e90s2IWIaqKa14RLkW4STKe4DXNzL5E9dxpf+zBu
         y3r6Tqpzhjf53jOvgTeCgJM0Hl1w4Cf4WYXFYGqpYIN0xgDrlwo7cKCQI/Z/jlN58ZJ5
         NmZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=WvtTQ9EHafgZQreyIYmWntetDMEcUBIjpiRzw8PhfhI=;
        b=Pf+xZMRTHaa4d6xH7KrwONvJgbw+0Z3fKLYu8GF1R5mlAtsIRbZFdk7c/r2Mzbgyhh
         gap6XJlmuWgMp0Phu+M8zIWkr5HncyN3AipUdgjErNBbE5L9aSqRn9qFEu+3TeWq4msc
         HoqSGAusSQ1IAvRPuj3AI7nO+HjXxxioVqTBGh1w8jtyiaB1d+XWtcokfSVGZcZJGiMf
         5af/RWDgkK+nQaOA0dEzpbGIE/5t6ULwYcSnFCWoUcUucuz4ZSk2sQqdAS4BVHZ0jfiU
         7foyncRrA9JO6OCuA0r6p5HS0oOqkawUEExC/m/QCY0ul/DcL80K6RpSc9XKVjLOhCFP
         fegA==
X-Gm-Message-State: AOAM533OU7qf346GiPCgH5LJ7T2gYeIfF/p2vsginSZFocW2c/Ddptjs
        OF8/RoijXAr7EaE52HhlFUDNYrEqAw4GSY2HdmE=
X-Google-Smtp-Source: ABdhPJxu4ndB0FsVY1ZLDhib/EQ7SOjv/zHeqrIMIV5B2+LFhdXC1lD8zyl8tkWijQn90wLdVwTc1Hn58Ognz5QpTUg=
X-Received: by 2002:a17:902:6b09:: with SMTP id o9mr20325820plk.100.1591009000110;
 Mon, 01 Jun 2020 03:56:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200525100054.17700-1-gengcixi@gmail.com> <917da283-5f1e-3fdb-13bb-4251312dc77a@linux.ibm.com>
In-Reply-To: <917da283-5f1e-3fdb-13bb-4251312dc77a@linux.ibm.com>
From:   Cixi Geng <gengcixi@gmail.com>
Date:   Mon, 1 Jun 2020 18:56:04 +0800
Message-ID: <CAF12kFvz-QEt7_xQ8ufXQdsNUBUCUw_i4gdXQ=D4h2OgNcmCOg@mail.gmail.com>
Subject: Re: [RFC PATCH v4] GCOV: profile by modules
To:     Peter Oberparleiter <oberpar@linux.ibm.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>, jslaby@suse.com,
        linux-serial@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>, zhang.lyra@gmail.com,
        Cixi Geng <cixi.geng1@unisoc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Peter Oberparleiter <oberpar@linux.ibm.com> =E4=BA=8E2020=E5=B9=B45=E6=9C=
=8828=E6=97=A5=E5=91=A8=E5=9B=9B =E4=B8=8B=E5=8D=8810:47=E5=86=99=E9=81=93=
=EF=BC=9A
>
> On 25.05.2020 12:00, gengcixi@gmail.com wrote:
> > From: Cixi Geng <cixi.geng1@unisoc.com>
> >
> > The CONFIG_GCOV_PROFILE_ALL will compile kernel by profiling entire
> > kernel which will lead to kernel run slower.Use GCOV_PROFILE_PREREQS
> > to control part of the kernel modules to open gcov.
>
> Maybe rephrase the commit message to make the intention more obvious:
>
> Introduce new configuration option GCOV_PROFILE_PREREQS that can be used
> to check whether the prerequisites for enabling gcov profiling for
> specific files and directories are met.
>
> >
> > Only add SERIAL_GCOV for an example.
> >
> > Signed-off-by: Cixi Geng <cixi.geng1@unisoc.com>
> > ---
> >  drivers/tty/serial/Kconfig  |  7 +++++++
> >  drivers/tty/serial/Makefile |  1 +
> >  kernel/gcov/Kconfig         | 14 ++++++++++++++
> >  3 files changed, 22 insertions(+)
> >
> > diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
> > index adf9e80e7dc9..6df002370f18 100644
> > --- a/drivers/tty/serial/Kconfig
> > +++ b/drivers/tty/serial/Kconfig
> > @@ -1566,3 +1566,10 @@ endmenu
> >
> >  config SERIAL_MCTRL_GPIO
> >       tristate
> > +
> > +config SERIAL_GCOV
> > +     bool "Enable profile gcov for serial directory"
> > +     depends on GCOV_PROFILE_PREREQS
> > +     help
> > +       The SERIAL_GCOV will add Gcov profiling flags when kernel compi=
les.
> > +       Say 'Y' here if you want the gcov data for the serial directory=
,
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
> > index 3941a9c48f83..ea8b514f5676 100644
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
> > +     depends on !GCOV_PROFILE_ALL
> > +     help
> > +       This options activates profiling for the specified kernel modul=
es.
> > +
> > +       When some modules need Gcov data, enable this config, then conf=
igure
> > +       with gcov on the corresponding modules,The directories or files=
 of
> > +       these modules will be added profiling flags after kernel compil=
e.
> > +
> > +       If unsure, say N.
>
> This is not quite what I had in mind. A user still needs to manually
> select GCOV_PROFILE, then GCOV_PROFILE_PREREQS, then SERIAL_GCOV.
>
> My though was that you could provide an automatic config option that is
> invisible in the configuration dialog, and that is automatically
> selected when all prereqs for enabling GCOV in a module directory are met=
.
>
> Something like the following:
>
> config GCOV_PROFILE_PREREQS
>         bool
>         default y if GCOV_KERNEL && !COMPILE_TEST
>         default n
>
> There's no need to add GCOV_KERNEL_ALL here since that is about a user
> choice ("I want all code compiled with profiling") vs. this new symbol
> which is about an ability ("all prereqs for enabling profiling in
> specific directories are met).
>
As far as I'm concerned, The GCOV_KERNEL_ALL will conflict with
GCOV_PROFILE_PREREQS=EF=BC=8Csince the GCOV_KERNEL_ALL will profing all
code which contain the new config.
>
> > +
> >  choice
> >       prompt "Specify GCOV format"
> >       depends on GCOV_KERNEL
> >
>
>
> --
> Peter Oberparleiter
> Linux on Z Development - IBM Germany

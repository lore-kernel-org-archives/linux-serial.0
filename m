Return-Path: <SRS0=CVbj=7E=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1EC9C433DF
	for <linux-serial@archiver.kernel.org>; Fri, 22 May 2020 10:47:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 982B0206B6
	for <linux-serial@archiver.kernel.org>; Fri, 22 May 2020 10:47:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LIqFUwuf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729367AbgEVKrN (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 22 May 2020 06:47:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728606AbgEVKrM (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 22 May 2020 06:47:12 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A72BC061A0E;
        Fri, 22 May 2020 03:47:10 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id z64so524643pfb.1;
        Fri, 22 May 2020 03:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=XXnsqh/cKcXQndweAUkF1OYpprzrv5lBJ65Lgz97qsQ=;
        b=LIqFUwufQuxElbKd2Cq7DXeYSGG3Tk5h1lvoj3qUZlV7X2yiLtzEWGrr/l+H6w/tsO
         N5m0Lo2xcoIbATYS1KjJTC193o2KuXtdi71EQazomJvhdmb+wHO62KvM+xEbBzb7e68f
         QiGbU5Cyrtj+PanYc+zIqCWLCnWqqKvwlQfkSUp8WuLkORewIRLJMLPuWBTjDsYRSbU7
         0ZPZKDZd7VviwjvdcYSafmdQZwLJcu1gZp8dRG5GvzzqV7xJaHcyRcUjwfqG6e6htmLt
         mU8YbBSkn6tyHCWnQJWeCHTysD6To8TIMQCgHvDU88tEbUkUO1ruwWNjCTgQBHGmrUJM
         SiGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=XXnsqh/cKcXQndweAUkF1OYpprzrv5lBJ65Lgz97qsQ=;
        b=Y6okGkVjwVWUF1ehFwHST3lZag40jNtlH25xyN7UbSDLOsLuxidAHmdw6seI7+68th
         4fXxCk8FRYPDVoYjcDY1ZQ9KNne7qAxoJHIHNHf7+Z0EeR+gj1B2ARRVxHKi8AuiU8P2
         ewuEvganjFZt0Sh7zVq/U89wVRS8IAo/jiYaprCUHCigoAwAScVpLeqX5D/oo5BzfGvQ
         bWXLQtm5Y7bjJCpxV5tKvci/TZFnDKVpTNpaX3KHNPpqFW8pzDkXdQ9o4g2Z35yRIyyP
         SC0+32xXOWEtUg4X24CuSQO9LWJi82tn1ULamrEHR14Bb1D3wT2+kRjjVRRVQZVXiK3O
         LpCA==
X-Gm-Message-State: AOAM533mkkk5jaZNl3B30DpDJ6CMxcl2LZjscaeuUSE/+/Rk46rcvr5I
        5Cr3OPl1lzbE7cmKz6QvPcYUZIj2uGrlCyjeMJo=
X-Google-Smtp-Source: ABdhPJyUpzptoEo/3/TZGPl0OeSY55HWNg/y2Lwg+E4PhToofNfYreo31jJZg+Yz4+OMUlpMbN4cQ0cTGbNrQBSMCyE=
X-Received: by 2002:a62:4dc3:: with SMTP id a186mr3180850pfb.269.1590144430124;
 Fri, 22 May 2020 03:47:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200522071917.17163-1-gengcixi@gmail.com> <20200522083715.GD1078778@kroah.com>
In-Reply-To: <20200522083715.GD1078778@kroah.com>
From:   Cixi Geng <gengcixi@gmail.com>
Date:   Fri, 22 May 2020 18:46:34 +0800
Message-ID: <CAF12kFsDHFNdY5ssiMpq0f3eH4ZOjXqStB=HRhuh0Nr08SqFPA@mail.gmail.com>
Subject: Re: [RFC][PATCH V3] GCOV: profile by modules
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     jslaby@suse.com, oberpar@linux.ibm.com,
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

Hi Greg:
DId you mean that the GCOV_PROFILE_PREREQS should add depends
on !GCOV_PROFILE_ALL ,then when GCOV_PROFILE_ALL is enabled,
the config GCOV_PROFILE_PREREQS will no longer works.

Greg KH <gregkh@linuxfoundation.org> =E4=BA=8E2020=E5=B9=B45=E6=9C=8822=E6=
=97=A5=E5=91=A8=E4=BA=94 =E4=B8=8B=E5=8D=884:37=E5=86=99=E9=81=93=EF=BC=9A
>
> On Fri, May 22, 2020 at 03:19:17PM +0800, gengcixi@gmail.com wrote:
> > From: Cixi Geng <cixi.geng1@unisoc.com>
> >
> > The CONFIG_GCOV_PROFILE_ALL will compile kernel by profiling entire
> > kernel which will lead to kernel run slower.Use GCOV_PROFILE_PREREQS
> > to control part of the kernel modules to open gcov.
> >
> > Only add SERIAL_GCOV for an example.
> >
> > Signed-off-by: Cixi Geng <cixi.geng1@unisoc.com>
> > ---
> >  drivers/tty/serial/Kconfig  |  7 +++++++
> >  drivers/tty/serial/Makefile |  1 +
> >  kernel/gcov/Kconfig         | 13 +++++++++++++
> >  3 files changed, 21 insertions(+)
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
> > index 3941a9c48f83..4d75fa158726 100644
> > --- a/kernel/gcov/Kconfig
> > +++ b/kernel/gcov/Kconfig
> > @@ -51,6 +51,19 @@ config GCOV_PROFILE_ALL
> >       larger and run slower. Also be sure to exclude files from profili=
ng
> >       which are not linked to the kernel image to prevent linker errors=
.
> >
> > +config GCOV_PROFILE_PREREQS
> > +     bool "Profile Kernel subsytem"
> > +     depends on !COMPILE_TEST
> > +     depends on GCOV_KERNEL
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
> > +
> >  choice
> >       prompt "Specify GCOV format"
> >       depends on GCOV_KERNEL
>
>
> I understand the goal here, but don't you need to have the main GCov
> option depend on your new Kconfig option here?  You have it switched
> around here, so what keeps all code from being built with gcov support
> at the moment?
>
> thanks,
>
> greg k-h

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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D474C433E0
	for <linux-serial@archiver.kernel.org>; Wed, 20 May 2020 09:21:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B1F3207D3
	for <linux-serial@archiver.kernel.org>; Wed, 20 May 2020 09:21:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ber4DJ+G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726545AbgETJVa (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 20 May 2020 05:21:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726436AbgETJV3 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 20 May 2020 05:21:29 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92081C061A0E;
        Wed, 20 May 2020 02:21:28 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id y18so1253616pfl.9;
        Wed, 20 May 2020 02:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=0GUxOU6n74ScYbG5A2YNTz41xrgSWYqjX8LE9GDBbNI=;
        b=Ber4DJ+GPXtSaFJuFFjMZEDyMm2QaSU0ZfW5dW4JV32/nenJ5xGOVemPR3t9R3KxVr
         bQGg6jz6noN7X/c0Qn2wtlpRDBQ7UblI54fisaE/KVTXvHd80T9yH3ufv8x463pm1fVB
         FKd4zsVIomF1qOFnmerre9JEzIFmw1pFJpXFnBLWHfOv9WJYlGT/vIjK5JHXPgpce3/H
         uAmJOFmZpDScsbpystkt60lSfQ3VT8jeKZbloeJKdgPloe/M87Q6rkspfi05xXTHgh/e
         m2qhF9aYJfBoPFoJxhj61JEwA/vCJkrbtbrRZbshT6PUIlQ1pVtzVNMTeTdni5Eo5kV8
         9XgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=0GUxOU6n74ScYbG5A2YNTz41xrgSWYqjX8LE9GDBbNI=;
        b=RGWxAgwtvH3y8qNDUPy9E5448klrC4l705UeP85s55YEIxCZxh0qjSj4Nknu4LogGK
         kRXhQ6jI1wwwtpLESJ0uaCnobYGaDAfxy5v0QeBZuMlWiyXzXNtQEzRJJZB2kHuzpDh/
         vTsozuV+E6B6TSVHww4Zlc/VH8FZdgBJyQ0ZCQSgSs5dPmNdW/CBDgIDXhi2igqp9zFO
         rvQpkXRcmMHAJYGzlLLjDiae/s30dmR5XKqUYwiLS1HLobOWr1VVglqMs/J9DUlFwWbW
         lWeTyGbRt7Rjs1/zhan7rlFykzZJ6Y4ZlbcxvZE2b5gGlz6lhPLlHIURXnaNI2HGBR7c
         4TjA==
X-Gm-Message-State: AOAM531mLy7lRdiJSwxI285A0NoOPTlDkPr96lfw+DAlBbgp+VNX+3OS
        PnsKp2Rolm0L9tT9WwvOf6Uby/9hNIlGcmaycYc=
X-Google-Smtp-Source: ABdhPJzVI45Ld5jKj5FnUvTqtBVrhxsiDnTKbvGn+eyhNnZGD6SGxMj1zN8gaBB1QHDYMnVZOAbiPOHT6K4hIJRXVUI=
X-Received: by 2002:aa7:9d8c:: with SMTP id f12mr3454814pfq.224.1589966487925;
 Wed, 20 May 2020 02:21:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200520083821.9602-1-gengcixi@gmail.com> <20200520085111.GE2837844@kroah.com>
 <CAF12kFsxiBC3sqvHbp1i5HLXxDnvM2ApFSKGpu-hjGW9LBhd0A@mail.gmail.com>
In-Reply-To: <CAF12kFsxiBC3sqvHbp1i5HLXxDnvM2ApFSKGpu-hjGW9LBhd0A@mail.gmail.com>
From:   Cixi Geng <gengcixi@gmail.com>
Date:   Wed, 20 May 2020 17:20:51 +0800
Message-ID: <CAF12kFtPrsmorzAT2d0e1j0RNx+kdYuY2UTuLx6iH1DP7QcMkQ@mail.gmail.com>
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

>> +config SERIAL_GCOV
>> +       bool "open gcov for serial"

>What do you mean by "open"?  And Kconfig entries are usually Upper Case" :=
)

>> +       depends on GCOV_PROFILE_PREREQS
>> +       help
>> +         Say Y here to enable gcov in serial.

>I think we need more text here.

Maybe I should use "Enable" instead of "open" for express more clearly.
and I will add more description of SERIAL_GCOV

Cixi Geng <gengcixi@gmail.com> =E4=BA=8E2020=E5=B9=B45=E6=9C=8820=E6=97=A5=
=E5=91=A8=E4=B8=89 =E4=B8=8B=E5=8D=885:04=E5=86=99=E9=81=93=EF=BC=9A
>
> Thank you for guidances, I will fix error and upload new patch
>
> Greg KH <gregkh@linuxfoundation.org> =E4=BA=8E2020=E5=B9=B45=E6=9C=8820=
=E6=97=A5=E5=91=A8=E4=B8=89 =E4=B8=8B=E5=8D=884:51=E5=86=99=E9=81=93=EF=BC=
=9A
> >
> > On Wed, May 20, 2020 at 04:38:21PM +0800, gengcixi@gmail.com wrote:
> > > From: Cixi Geng <cixi.geng1@unisoc.com>
> > >
> > > ---
> > > Replace symbol GCOV_PROFILE_MODULES with GCOV_PROFILE_PREREQS
> > > ---
> > > The CONFIG_GCOV_PROFILE_ALL will compile kernel by profiling entire
> > > kernel which will lead to kernel run slower.Use GCOV_PROFILE_PREREQS
> > > to control part of the kernel modules to open gcov.
> > >
> > > Only add SERIAL_GCOV for an example.
> > >
> > > Signed-off-by: Cixi Geng <cixi.geng1@unisoc.com>
> > > ---
> > >  drivers/tty/serial/Kconfig  |  6 ++++++
> > >  drivers/tty/serial/Makefile |  1 +
> > >  kernel/gcov/Kconfig         | 14 ++++++++++++++
> > >  3 files changed, 21 insertions(+)
> > >
> > > diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
> > > index adf9e80e7dc9..964df1a2989c 100644
> > > --- a/drivers/tty/serial/Kconfig
> > > +++ b/drivers/tty/serial/Kconfig
> > > @@ -1566,3 +1566,9 @@ endmenu
> > >
> > >  config SERIAL_MCTRL_GPIO
> > >       tristate
> > > +
> > > +config SERIAL_GCOV
> > > +       bool "open gcov for serial"
> >
> > What do you mean by "open"?  And Kconfig entries are usually Upper Case=
" :)
> >
> > > +       depends on GCOV_PROFILE_PREREQS
> > > +       help
> > > +         Say Y here to enable gcov in serial.
> >
> > I think we need more text here.
> >
> >
> > > diff --git a/drivers/tty/serial/Makefile b/drivers/tty/serial/Makefil=
e
> > > index d056ee6cca33..7be1202286d2 100644
> > > --- a/drivers/tty/serial/Makefile
> > > +++ b/drivers/tty/serial/Makefile
> > > @@ -2,6 +2,7 @@
> > >  #
> > >  # Makefile for the kernel serial device drivers.
> > >  #
> > > +GCOV_PROFILE :=3D $(CONFIG_SERIAL_GCOV)
> > >
> > >  obj-$(CONFIG_SERIAL_CORE) +=3D serial_core.o
> > >
> > > diff --git a/kernel/gcov/Kconfig b/kernel/gcov/Kconfig
> > > index 3941a9c48f83..91cc8f3c7c43 100644
> > > --- a/kernel/gcov/Kconfig
> > > +++ b/kernel/gcov/Kconfig
> > > @@ -51,6 +51,20 @@ config GCOV_PROFILE_ALL
> > >       larger and run slower. Also be sure to exclude files from profi=
ling
> > >       which are not linked to the kernel image to prevent linker erro=
rs.
> > >
> > > +config GCOV_PROFILE_PREREQS
> > > +     bool "Profile Kernel subsytem"
> > > +     depends on !COMPILE_TEST
> > > +     depends on GCOV_KERNEL
> > > +     default n
> >
> > default is always 'n', no need to list that
> >
> > > +     help
> > > +     This options activates profiling for the specified kernel modul=
es.
> > > +
> > > +     If unsure, say N.
> > > +
> > > +     When some modules need Gcov data, enable this config, then conf=
igure
> > > +     with gcov on the corresponding modules configs.The directories =
or files
> >
> > '. '?
> >
> > > +     of these modules will be added profiling flags after kernel com=
pile.
> >
> > The lines under "help" need to be indented more, right?
> >
> > thanks,
> >
> > greg k-h

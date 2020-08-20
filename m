Return-Path: <SRS0=0389=B6=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2BD8C433E1
	for <linux-serial@archiver.kernel.org>; Thu, 20 Aug 2020 12:42:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D47D208DB
	for <linux-serial@archiver.kernel.org>; Thu, 20 Aug 2020 12:42:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rxBik7ci"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729572AbgHTMmA (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 20 Aug 2020 08:42:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729178AbgHTMla (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 20 Aug 2020 08:41:30 -0400
Received: from mail-yb1-xb44.google.com (mail-yb1-xb44.google.com [IPv6:2607:f8b0:4864:20::b44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34073C061385;
        Thu, 20 Aug 2020 05:41:30 -0700 (PDT)
Received: by mail-yb1-xb44.google.com with SMTP id x2so1011432ybf.12;
        Thu, 20 Aug 2020 05:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=r/T4ii5RE8lOWBgOSNeDm0KDDPAGGqGP1nEcEARRMpE=;
        b=rxBik7ci0OkFWMBDL1sj8Mnk45VhZxb+Qk/x19bxy5zNG+Dsp5j7K/xk0hU0v2hTRB
         XxKcbNiNztLjEtEtgrf2Sp64BYH/mRB8QPxwJios1Icd4bp2cTzp8wIqPI2hhsw2Tp2H
         R0ELdz0FJ4tLoTvQw05/TZuRuzhb2d4ml+gdKGBKcBk8r/oMhfCSciKeFCu1ZA7F1QwY
         zcRPHWJtfIV38TRmEwrMg8SAqg0jYIfc5pTqYP3QJDKu5lMAk4Spew6sPh9W0z+WuoIz
         cD8bYf0zWOjY5i62eg0iWewKTM4updXz4eldhIfZ19Y/cOJepiXTjuFrOiL4qPzIJrpZ
         TPvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=r/T4ii5RE8lOWBgOSNeDm0KDDPAGGqGP1nEcEARRMpE=;
        b=AEOWjWVAmk+4H7MOIOJA1PeIRMTjdmdndnrAK+Fe6V0DjVaTe9mJe6nnMerBtn7eWW
         JODRBrkGvnS8yelgS1rEZzKhU+yzNVRwEj20+yCaV2oQtRxg0CQkMim2xWrhKVXSRA/T
         R/6i/eeNUh96clL6xghXtg3PiYioJ+8ZmV2NiWf4XLwxnM6ostWekTSXE0RjpHcGUk4S
         TioIEnQ1UYwrRxWTH8c4mrPfpdtkRL2VjtN43G1cmhXMRf6vLIoLi3Y7cncmi0T3XDZl
         ToGkkps1Y0f+HXcE5J7NRP9d7DAHtqIOd7/UyhSuoLZwGGO7oHGbBhdshvDHfOngW3qm
         nAlQ==
X-Gm-Message-State: AOAM532BLdac9oBRvwONvLcqgtmyPixbW0yvPKtOzQ0VTAz9zHjTd00Y
        G6fgayNKEWh6oLPwgjvtvlmsnFGJdPvFvPXu0eD8y/zoWR0=
X-Google-Smtp-Source: ABdhPJzSriSlxEpqPlDDFfe+M8N9Fb+5PaPOkV1/VeD3lyz6bFMrJtM51S9hsdqv3sT2v8Kvi2ZBC0Q/69TQ/B7QnDQ=
X-Received: by 2002:a25:7c01:: with SMTP id x1mr4482850ybc.357.1597927289428;
 Thu, 20 Aug 2020 05:41:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200727085132.29754-1-gengcixi@gmail.com>
In-Reply-To: <20200727085132.29754-1-gengcixi@gmail.com>
From:   Cixi Geng <gengcixi@gmail.com>
Date:   Thu, 20 Aug 2020 20:40:53 +0800
Message-ID: <CAF12kFuss4AQZSBX+A2G_fWjka3C4kpf4iDWU9QJY=AWigoxqg@mail.gmail.com>
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

Hi All:

Does this patch need more modification?

<gengcixi@gmail.com> =E4=BA=8E2020=E5=B9=B47=E6=9C=8827=E6=97=A5=E5=91=A8=
=E4=B8=80 =E4=B8=8B=E5=8D=884:51=E5=86=99=E9=81=93=EF=BC=9A
>
> From: Cixi Geng <cixi.geng1@unisoc.com>
>
> Introduce new configuration option GCOV_PROFILE_PREREQS that can be
> used to check whether the prerequisites for enabling gcov profiling
> for specific files and directories are met.
>
> Only add SERIAL_GCOV for an example.
>
> Signed-off-by: Cixi Geng <cixi.geng1@unisoc.com>
> ---
>  drivers/tty/serial/Kconfig  |  7 +++++++
>  drivers/tty/serial/Makefile |  1 +
>  kernel/gcov/Kconfig         | 12 ++++++++++++
>  3 files changed, 20 insertions(+)
>
> diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
> index 780908d43557..55b128b6b31d 100644
> --- a/drivers/tty/serial/Kconfig
> +++ b/drivers/tty/serial/Kconfig
> @@ -1576,3 +1576,10 @@ endmenu
>
>  config SERIAL_MCTRL_GPIO
>         tristate
> +
> +config SERIAL_GCOV
> +       bool "Enable profile gcov for serial directory"
> +       depends on GCOV_PROFILE_PREREQS
> +       help
> +         The SERIAL_GCOV will add Gcov profiling flags when kernel compi=
les.
> +         Say 'Y' here if you want the gcov data for the serial directory=
,
> diff --git a/drivers/tty/serial/Makefile b/drivers/tty/serial/Makefile
> index d056ee6cca33..17272733db95 100644
> --- a/drivers/tty/serial/Makefile
> +++ b/drivers/tty/serial/Makefile
> @@ -3,6 +3,7 @@
>  # Makefile for the kernel serial device drivers.
>  #
>
> +GCOV_PROFILE :=3D $(CONFIG_SERIAL_GCOV)
>  obj-$(CONFIG_SERIAL_CORE) +=3D serial_core.o
>
>  obj-$(CONFIG_SERIAL_EARLYCON) +=3D earlycon.o
> diff --git a/kernel/gcov/Kconfig b/kernel/gcov/Kconfig
> index 3110c77230c7..bb2e1fb85743 100644
> --- a/kernel/gcov/Kconfig
> +++ b/kernel/gcov/Kconfig
> @@ -51,4 +51,16 @@ config GCOV_PROFILE_ALL
>         larger and run slower. Also be sure to exclude files from profili=
ng
>         which are not linked to the kernel image to prevent linker errors=
.
>
> +config GCOV_PROFILE_PREREQS
> +       bool "Profile Kernel for prereqs"
> +       depends on GCOV_KERNEL
> +       depends on  !COMPILE_TEST
> +       def_bool y if GCOV_KERNEL && !COMPILE_TEST
> +       help
> +         This options activates profiling for the specified kernel modul=
es.
> +
> +         When some modules need Gcov data, enable this config, then conf=
igure
> +         with gcov on the corresponding modules,The directories or files=
 of
> +         these modules will be added profiling flags after kernel compil=
e.
> +
>  endmenu
> --
> 2.17.1
>

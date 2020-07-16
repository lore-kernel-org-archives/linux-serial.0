Return-Path: <SRS0=PhEQ=A3=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FAC8C433E2
	for <linux-serial@archiver.kernel.org>; Thu, 16 Jul 2020 12:39:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3BBF3207CD
	for <linux-serial@archiver.kernel.org>; Thu, 16 Jul 2020 12:39:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hM8MArVc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728054AbgGPMjC (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 16 Jul 2020 08:39:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728087AbgGPMjB (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 16 Jul 2020 08:39:01 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 905AAC061755;
        Thu, 16 Jul 2020 05:39:01 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id t15so4607616pjq.5;
        Thu, 16 Jul 2020 05:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=K1HWiQZgE61cy/vLmXw2XWqZLzJFdYeUlZUgURRvU5U=;
        b=hM8MArVcutmn6qHTeKVWDy7oE71DfDVoTU4O5q7N0THKl52g271rQZviqdZ3BmfX2H
         wBqoYDoDmNn324vso1g5wApALL7Jldq7EGkn5+NuVzUSPd68+gg9wJDZHRjN1owC2enb
         +zVvWZviVR2Mz9xJ/N2ZvDihSuoB5y8+If5VF7W+koKd3C0G3mMDbFYvOQuagCm4/Ppp
         wTGtApYTOmZ4bsrZZcXyL59EAtHZ+rM5s/aRpM9/cUJ2NaGLoo/siDBxW0K/fJrGmjuf
         CsF/y6XLeLoJW4I1RdWc99f3nheSOJKwdlk4AEm28L7a532FtDq6lsmzLhmFDIeYYkvd
         aMCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=K1HWiQZgE61cy/vLmXw2XWqZLzJFdYeUlZUgURRvU5U=;
        b=MjmYiXPn78saZh9fduGkVNauZVVdyFmhP2/OTLtFrEbZSbxcxve8j9huGCqMWQ2YsW
         1J3k8pm7xuTmc4HEEuh+WsO+POf7Aea19XInNmRGQdCm/AARNlJSm/hmUQZLnYnpFD58
         5YRIU2LfGJxiQVGDeZsLmWz7AzWdRrt/6q5Dj3v5Kg0EO2WgTR/8rygAIK5TCU0xg9TX
         mtOEYpHeYs12+iIYA+ofsiRHto4fQqUJwgm9uTuvCC6Lr9lFetJmEvhfGXfLWUyIFLMs
         sF9Us467YVU0fQMj+6A+EqCPwf7fvp+xz2/a0P0GIL9Rdh7mVGbFPqxG7ApXPKke5QIR
         JkWw==
X-Gm-Message-State: AOAM5310dpboEZuGeV+HGLC6mqFJjD0RcgG3I0UKkq/AWpzvHkcjWEN2
        BiFWxQByrq+Cz2SwDFlTJ++EMEgFA6YLkFEl1OQ=
X-Google-Smtp-Source: ABdhPJym4fUkA7PWQNVi5tG8ifNxe+uZqYMEc9TePz2JLjfYzUvpwTwBo1WSpcBLmCkunTVTGzgqldVCTP55rLJLojE=
X-Received: by 2002:a17:90a:ef17:: with SMTP id k23mr4253147pjz.45.1594903141101;
 Thu, 16 Jul 2020 05:39:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200618100852.13715-1-gengcixi@gmail.com> <2fae67c7637f4e978cb54c3b96090788@BJMBX01.spreadtrum.com>
In-Reply-To: <2fae67c7637f4e978cb54c3b96090788@BJMBX01.spreadtrum.com>
From:   Cixi Geng <gengcixi@gmail.com>
Date:   Thu, 16 Jul 2020 20:38:25 +0800
Message-ID: <CAF12kFseC4MMbEUk6CgW=Hpz_Hg-+fjwbLZKFdPu0K_EGtcPDw@mail.gmail.com>
Subject: Re: [PATCH V6] GCOV: Add config to check the preqequisites situation
To:     Greg KH <gregkh@linuxfoundation.org>, jslaby@suse.com,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        linux-serial@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     Cixi Geng1 <cixi.geng1@unisoc.com>,
        Orson Zhai <orsonzhai@gmail.com>, zhang.lyra@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi All:
Does this patch need more modification?



> =E5=8F=91=E4=BB=B6=E4=BA=BA: gengcixi@gmail.com <gengcixi@gmail.com>
> =E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4: 2020=E5=B9=B46=E6=9C=8818=E6=97=A5 =
18:08
> =E6=94=B6=E4=BB=B6=E4=BA=BA: gregkh@linuxfoundation.org; jslaby@suse.com;=
 oberpar@linux.ibm.com; linux-serial@vger.kernel.org; linux-kernel@vger.ker=
nel.org
> =E6=8A=84=E9=80=81: orsonzhai@gmail.com; zhang.lyra@gmail.com; =E8=80=BF=
=E6=85=88=E7=86=99 (Cixi Geng/10039)
> =E4=B8=BB=E9=A2=98: [PATCH V6] GCOV: Add config to check the preqequisite=
s situation
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
>  kernel/gcov/Kconfig         | 10 ++++++++++
>  3 files changed, 18 insertions(+)
>
> diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
> index adf9e80e7dc9..6df002370f18 100644
> --- a/drivers/tty/serial/Kconfig
> +++ b/drivers/tty/serial/Kconfig
> @@ -1566,3 +1566,10 @@ endmenu
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
> index 3941a9c48f83..f415c4aaf0ab 100644
> --- a/kernel/gcov/Kconfig
> +++ b/kernel/gcov/Kconfig
> @@ -51,6 +51,16 @@ config GCOV_PROFILE_ALL
>         larger and run slower. Also be sure to exclude files from profili=
ng
>         which are not linked to the kernel image to prevent linker errors=
.
>
> +config GCOV_PROFILE_PREREQS
> +       bool "Profile Kernel for prereqs"
> +       default y if GCOV_KERNEL && !COMPILE_TEST
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
>  choice
>         prompt "Specify GCOV format"
>         depends on GCOV_KERNEL
> --
> 2.17.1

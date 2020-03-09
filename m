Return-Path: <SRS0=G73M=42=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC0FAC10DCE
	for <linux-serial@archiver.kernel.org>; Mon,  9 Mar 2020 01:18:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2B2220675
	for <linux-serial@archiver.kernel.org>; Mon,  9 Mar 2020 01:18:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CyYwlzj4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726705AbgCIBSU (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Sun, 8 Mar 2020 21:18:20 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55867 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726346AbgCIBSU (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sun, 8 Mar 2020 21:18:20 -0400
Received: by mail-wm1-f67.google.com with SMTP id 6so8126869wmi.5;
        Sun, 08 Mar 2020 18:18:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=K0FbYoD5QyM3mQ46mDO2FdxxLRF6uzspSD/4xNSFbC8=;
        b=CyYwlzj49u8GrKRQL9BsLmZV7lQiGiWaWLAe5hyiFYdg7KXdy+EXm57nMYAI39jhDB
         3GMCtRWEnSrb98gjefecnVi9y53deQw29YBwwlY//Zj/1yo73Ig5lDEMcjJ59gpR+7q6
         YyGBokBL74/WPAfguEMpXq9K4m0bufJLCzHab5G9QOa2MQ+M6ck4QapHMzjH/FKFMP+R
         e1/T6bxw9ueONiNXHzba3GjdBKuvjMd40BswVaDHj81+7T545jxIzkjVLA8mnL0ZJQSL
         6ky7SM6OVaTa0raVtngW3nrY4VGfy6Xu9RLNh9dofVrJyfX7acXtV9UTQk+5sPYN9Kjz
         cKXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K0FbYoD5QyM3mQ46mDO2FdxxLRF6uzspSD/4xNSFbC8=;
        b=b92QNbyy98Nksu7p5Hk5+mqEMQOMLW10r5cDWWNOp6iMEYj/sx06Zr51DzuYzLpk3w
         7EVNebD+dhsQPZLqRVAVMTqTCF5zv5zXoTqakPz71I7ieWa8e6M0q1/zo1Q2dGVFmWsW
         EwTE/XMpJqmaXw0oWq++RQ5dnCp8tpmi7WPbxNTjKyIpiNcNu6Er43oLLATDXHn4tCmK
         OdT5MPS5rE7him0qJL7lWok0XeO/DxCEslhgEMBW+d2Z5eUNb+O5XWrUOex0WWOOjw5f
         dNnV4lCgrdjHeGI8D7EQFl87lYA1w+VrroE+U//rWnU051CsO5CEdXWcFVTL4jT8AKwm
         t1pw==
X-Gm-Message-State: ANhLgQ1XG+H5BcsqUWV6TOXfWCo2pJch2Mrcd+RWCX5pQOh5rDCtlMO/
        qYyvrqAP+6XSbhwsO7UF3qIndwuuPg3bdTkVFGE=
X-Google-Smtp-Source: ADFU+vuLBG2IpnusekSVeJ89FMgBsZsGS2eZEdux1+VUGVpelAXDEcNf+IfvdrK2Q7FbGUFAy6WplTbrLTVwmH0Mfcw=
X-Received: by 2002:a7b:c446:: with SMTP id l6mr16475019wmi.3.1583716696466;
 Sun, 08 Mar 2020 18:18:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200305103228.9686-1-zhang.lyra@gmail.com> <20200305103228.9686-2-zhang.lyra@gmail.com>
 <CAMuHMdU-gAhupHotQTHAZfopkGF_jQc-VrVxb24caw_BfzWd6g@mail.gmail.com>
In-Reply-To: <CAMuHMdU-gAhupHotQTHAZfopkGF_jQc-VrVxb24caw_BfzWd6g@mail.gmail.com>
From:   Chunyan Zhang <zhang.lyra@gmail.com>
Date:   Mon, 9 Mar 2020 09:17:40 +0800
Message-ID: <CAAfSe-sonfA=6x9uvQXaHniQaXR8hWZa4uOcWxoo+Z_XT9QNhw@mail.gmail.com>
Subject: Re: [PATCH 2/2] tty: serial: make SERIAL_SPRD not depend on ARCH_SPRD
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Jiri Slaby <jslaby@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi Geert,

On Fri, 6 Mar 2020 at 20:41, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Chunyan,
>
> On Thu, Mar 5, 2020 at 11:33 AM Chunyan Zhang <zhang.lyra@gmail.com> wrote:
> > From: Chunyan Zhang <chunyan.zhang@unisoc.com>
> >
> > Remove the dependency with ARCH_SPRD from sprd serial/console Kconfig-s,
> > since we want them can be built-in when ARCH_SPRD is set as 'm'.
>
> Why would you want a serial driver for a specific platform to be builtin,
> while all other platform support is modular?

Oh, that's not this patch means.

We just want serial driver can be builtin for any platform, so it
should not depend on a config which can be set as 'm' (i.e. ARCH_SPRD)
, otherwise if the config was set as 'm', the serial driver can't be
selected as 'y' then.

That's what I mean.

Cheers,
Chunyan

>
> > Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
> > ---
> >  drivers/tty/serial/Kconfig | 1 -
> >  1 file changed, 1 deletion(-)
> >
> > diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
> > index 52eaac21ff9f..2b9addc0afb5 100644
> > --- a/drivers/tty/serial/Kconfig
> > +++ b/drivers/tty/serial/Kconfig
> > @@ -1452,7 +1452,6 @@ config SERIAL_MEN_Z135
> >
> >  config SERIAL_SPRD
> >         tristate "Support for Spreadtrum serial"
> > -       depends on ARCH_SPRD
> >         select SERIAL_CORE
> >         help
> >           This enables the driver for the Spreadtrum's serial.
>
> Gr{oetje,eeting}s,
>
>                         Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
>
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds

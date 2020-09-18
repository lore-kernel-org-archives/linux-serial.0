Return-Path: <SRS0=liNn=C3=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7940DC43463
	for <linux-serial@archiver.kernel.org>; Fri, 18 Sep 2020 11:03:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E80521D24
	for <linux-serial@archiver.kernel.org>; Fri, 18 Sep 2020 11:03:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZOOnrumD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726390AbgIRLD3 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 18 Sep 2020 07:03:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726064AbgIRLD3 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 18 Sep 2020 07:03:29 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62A61C06174A;
        Fri, 18 Sep 2020 04:03:29 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id o20so3201368pfp.11;
        Fri, 18 Sep 2020 04:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Nao0/Wr0hBbBHzRTt2lYTcrL2lgJfdqCHe2qLp5Vfbs=;
        b=ZOOnrumDDELWvuqtf3pLDC3+QT7tIp4eL3dqXtZnnzHnZVCh1e16nMtyEz0fOAXXrx
         dRSq/FLxBdynsc26VSUZwuYH0q2/+YD2RlF3+VJg4vpFOn2nxTRdfbb3tX6zu03Ykf9O
         zNVCJ9eyZxdgbEn/ghY+bLLqd6lXTI5DgucL2mnGVdpqVOrkk+pBoKD1rKi+L/YJr65C
         OdAMPZqRDjWwMLOpH1yviYdHmm7PvSnO/mW0grqcF1BrcOvtZePU5GyRFPZo5SCXlLbu
         IS0iRHvE6Km+93YcACqjW59zzq0cA1LjQ50d4xh9TVJwDNNKGehJ/1TJiAgsYnELePwp
         E36A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Nao0/Wr0hBbBHzRTt2lYTcrL2lgJfdqCHe2qLp5Vfbs=;
        b=VEMLKcnwtujGVilX0OthzzbI3NJqdkG0XQ75qiLSBpcb2wI3wBjpO1vV4jXWEu3tsC
         8yKcu5RvRr3pKJD1JvIaoGL5Ot4mehjmSzkrkbPqHPS0MYE+qbiHlmM+ucskWa30yvEb
         jd0v6gfYgV36RwhRwi90Dv94J1KVFmcdUbSx2iABOhDZR4OZcpR91m9udSJW9qJhDUOe
         pVjJ2gyU5ZNsIv2OivQeOeqweAhjuAk9rhABN/VG7/LcXGiywPpyUeV/Nvvw0G99pIwy
         fQMoQxKw8+rMNJRyF4hScridg2FEJjh9hX0kFu9Mzgh20Vk0asO+O3Fl9wYEc+wKrBMe
         BDtg==
X-Gm-Message-State: AOAM531eXEQ2VmmieK+V2I8tMnBXO91WbtVLNqKWpcSCfVUcN++GDxFN
        gmhDFTQQXR9WeWvOBq6coIRUwHCgKezNc8KTAuw=
X-Google-Smtp-Source: ABdhPJwr0+DnowJF2rGQ525MkBbx6O/JnE/mrxsqe4Qz4K48A78m7Pd48JGufEzbgiQQwnMesZiWjKslBt1FZPPDQZQ=
X-Received: by 2002:aa7:9201:0:b029:13e:d13d:a10c with SMTP id
 1-20020aa792010000b029013ed13da10cmr30226423pfo.40.1600427008863; Fri, 18 Sep
 2020 04:03:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200915054825.3289105-1-hsinyi@chromium.org>
In-Reply-To: <20200915054825.3289105-1-hsinyi@chromium.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 18 Sep 2020 14:03:11 +0300
Message-ID: <CAHp75VetbOewxfr2weG_WJDQ7hNkmBBnL_A-JZV9iTXT2vd-_Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] tty: serial: print earlycon info after match->setup
To:     Hsin-Yi Wang <hsinyi@chromium.org>
Cc:     "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Changqi Hu <changqi.hu@mediatek.com>,
        Frank Wunderlich <frank-w@public-files.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Eddie Huang <eddie.huang@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Sep 15, 2020 at 8:50 AM Hsin-Yi Wang <hsinyi@chromium.org> wrote:
>
> 8250 devices may modify iotype in their own earlycon setup. For example:
> 8250_mtk and 8250_uniphier force iotype to be MMIO32. Print earlycon info
> after match->setup to reflect actual earlycon info.

Thanks for an update.
I prefer to see some flag that tells user that options were forced by
the kernel itself (something like err > 0 returned from ->setup()),
but I think it's matter of an additional fix. In principle user can
check the command line and / or DT/ACPI vs. dmesg, although it will
require an extra work.

> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> ---
> Change:
> v1->v2: rename function
> ---
>  drivers/tty/serial/earlycon.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/tty/serial/earlycon.c b/drivers/tty/serial/earlycon.c
> index 2ae9190b64bb9..b70877932d47d 100644
> --- a/drivers/tty/serial/earlycon.c
> +++ b/drivers/tty/serial/earlycon.c
> @@ -56,7 +56,6 @@ static void __init earlycon_init(struct earlycon_device *device,
>                                  const char *name)
>  {
>         struct console *earlycon = device->con;
> -       struct uart_port *port = &device->port;
>         const char *s;
>         size_t len;
>
> @@ -70,6 +69,12 @@ static void __init earlycon_init(struct earlycon_device *device,
>         len = s - name;
>         strlcpy(earlycon->name, name, min(len + 1, sizeof(earlycon->name)));
>         earlycon->data = &early_console_dev;
> +}
> +
> +static void __init earlycon_print_info(struct earlycon_device *device)
> +{
> +       struct console *earlycon = device->con;
> +       struct uart_port *port = &device->port;
>
>         if (port->iotype == UPIO_MEM || port->iotype == UPIO_MEM16 ||
>             port->iotype == UPIO_MEM32 || port->iotype == UPIO_MEM32BE)
> @@ -140,6 +145,7 @@ static int __init register_earlycon(char *buf, const struct earlycon_id *match)
>
>         earlycon_init(&early_console_dev, match->name);
>         err = match->setup(&early_console_dev, buf);
> +       earlycon_print_info(&early_console_dev);
>         if (err < 0)
>                 return err;
>         if (!early_console_dev.con->write)
> @@ -302,6 +308,7 @@ int __init of_setup_earlycon(const struct earlycon_id *match,
>         }
>         earlycon_init(&early_console_dev, match->name);
>         err = match->setup(&early_console_dev, options);
> +       earlycon_print_info(&early_console_dev);
>         if (err < 0)
>                 return err;
>         if (!early_console_dev.con->write)
> --
> 2.28.0.618.gf4bc123cb7-goog
>


-- 
With Best Regards,
Andy Shevchenko

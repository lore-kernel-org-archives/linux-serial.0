Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90CE6C433EF
	for <linux-serial@archiver.kernel.org>; Mon,  8 Nov 2021 08:37:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7437E60C4B
	for <linux-serial@archiver.kernel.org>; Mon,  8 Nov 2021 08:37:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238059AbhKHIkH (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 8 Nov 2021 03:40:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238052AbhKHIkE (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 8 Nov 2021 03:40:04 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5C3CC061570;
        Mon,  8 Nov 2021 00:37:20 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id m14so58587127edd.0;
        Mon, 08 Nov 2021 00:37:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=gw2FCiC4aWMJkxXuSfsSyIQD/E2YOZ+rOt07PIe4WUk=;
        b=lePT8RwnrYKsnAX0P3RcP2YZ15dkGBdbdcfdCJiIZIkqACbd8MNCnTsQo32jZcyh8I
         7qlPKUtpPDqkAdRRQVkCvo9p66rgHfqoSncXue538YVl9c6k5LPnCaVi4YKovB0EDfGP
         PuLyMNXXztyWOcaL/0R/HyJ7RbNG+u32K2WxF4I8w7zK+VdzzmW7lBkLpBtQqtHJJXrX
         JqEWrROMPNPesAqD38x8GkQlFA1Vn2n1yzB25xzNKwVdgBNwDjajt7IGviTKOsqRa1gI
         A8Q6oW7JrZOlWER1lG1iiK477DopN5XsWIItUaJStFl5vD7atAENM89NZHVHDGuMnmpR
         zsYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=gw2FCiC4aWMJkxXuSfsSyIQD/E2YOZ+rOt07PIe4WUk=;
        b=dh+AKkGnVHNUN51OWENFofyw0XluBDkg9hhm/zBRbBhSm8KLYAt3jKI8RdBZO4qXPH
         nACtc5gB5FM4TI+czDGVkKsE3K3qKaXXGfJBp/QpHUZSZ9WIqbYbnxEMzKiG5GqqnPlS
         8I8dvgAgaLkilN1rbUR1+1ZzShkQ1cyEz6c1BdxpjopUnQOQhlsVno/do8Xya+z1lYQT
         ZemgR+9T490YzYwC5fUh+wz5j8dsyv/CCFeYVVQ+ofuo3FHEzMhOUGF21J3bCzJnvMko
         bTUn0Hgz0ioj2nyTCHhZfj7+2DToMCconrUKJHMA3Q2IDdGNfEPjdmD931nrgT3Lrsje
         6UrQ==
X-Gm-Message-State: AOAM530cBwVflPbvrmyt0wvJ3ScN1bSLduw14EEYpLLAGuse0Z9c/ZSG
        7lKeduMrA9UNdGNPZr+7eaanrekUzdNcqp84KhSlLjjCLhw=
X-Google-Smtp-Source: ABdhPJwCI1MsuA2LeXHuWY3YG3X7/Z0b3UvAGxUkSnkpx8g8mQRMV4RvKy/XiSe63m0bY5b2vQsF9jOophKe2dGRnXs=
X-Received: by 2002:a17:906:bccc:: with SMTP id lw12mr28140316ejb.128.1636360639432;
 Mon, 08 Nov 2021 00:37:19 -0800 (PST)
MIME-Version: 1.0
References: <20211107031721.4734-1-ajaygargnsit@gmail.com>
In-Reply-To: <20211107031721.4734-1-ajaygargnsit@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 8 Nov 2021 10:36:33 +0200
Message-ID: <CAHp75VcacFAvsW6zmHe8fbnetcZq4xY_LZunZjBDG3ZdfS9NRQ@mail.gmail.com>
Subject: Re: [PATCH v4] tty: vt: keyboard: add default switch-case, to handle
 smatch-warnings in method vt_do_kdgkb_ioctl
To:     Ajay Garg <ajaygargnsit@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Emil Renner Berthing <kernel@esmil.dk>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Pavel Skripkin <paskripkin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Sun, Nov 7, 2021 at 4:10 PM Ajay Garg <ajaygargnsit@gmail.com> wrote:
>
> smatch-kchecker gives the following warnings when run on keyboard.c :
>
> vt_do_kdgkb_ioctl() error: uninitialized symbol 'kbs'.
> vt_do_kdgkb_ioctl() error: uninitialized symbol 'ret'.
>
> This usually happens when switch has no default case and static
> analyzers and even sometimes compilers can=E2=80=99t prove that all possi=
ble
> values are covered.
>
>

One blank line is enough.

> Thus, the default switch-case has been added, which sets the values
> for the two variables :
>
>         * kbs as NULL, which also nicely fits in with kfree.
>
>         * ret as -ENOIOCTLCMD (on same lines if there is no cmd
>                                match in "vt_do_kdskled" method).
>
>
> Many thanks to the following for review of previous versions :
>
>         * Pavel Skripkin <paskripkin@gmail.com>
>         * Andy Shevchenko <andy.shevchenko@gmail.com>
>
>

Ditto for each such case.

...

> +       default:
> +               kbs =3D NULL;

> +               ret =3D -ENOIOCTLCMD;

Why is this? How is it supposed to work?

> +               break;
>         }

--=20
With Best Regards,
Andy Shevchenko

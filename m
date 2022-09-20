Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55021C54EE9
	for <linux-serial@archiver.kernel.org>; Tue, 20 Sep 2022 16:02:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230313AbiITQCB (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 20 Sep 2022 12:02:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231666AbiITQBv (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 20 Sep 2022 12:01:51 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 446F76C11D
        for <linux-serial@vger.kernel.org>; Tue, 20 Sep 2022 09:01:48 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id b35so4619633edf.0
        for <linux-serial@vger.kernel.org>; Tue, 20 Sep 2022 09:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=cj5jDAOuRb643FcjEkM+RL+KZt0WpMxjAAW86S8m0FM=;
        b=RtWwLQ3NILLqWUMusnAEfpfVe4fRPoNbB+AXULUHr9z0ocjjarY1xwbSv30ctxSvRm
         UipqA/tpW7nmSgJxRB5j3HZ2u2cUTAzlV7p1ebzVSPIokCHnSR9rdbbmsfFNljspDRIx
         72uZqmUdgyEOxhXvfev7pkErERbgjrgEGq8W9mCpm29JfZV8dk07//BAMYdb2LUwgJF7
         1I7gebrrhGTobNsny6KH6I8+KkkBKWC9f4lOMmBdTOAKbuBg/u8d7F1tLsrBAqx0mGKq
         uWGzZHGGT7nO/2uX8hUya27Pve2ga8Sq/D/Jemx8OOp8p3YNPH476xh2WIeIKKB5kq11
         GWPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=cj5jDAOuRb643FcjEkM+RL+KZt0WpMxjAAW86S8m0FM=;
        b=mPuMurncdPeKK3a4+IOCqpc2dWNwkOl0P3VkmkbREqRqxncQXFmENCPDPKqoCClMta
         rlu33kc251z4DA6jAZllDU/F4M1MMDjS2evpLRDaIQLCvsvdcP+SWZcneueaWIejDF4f
         AgjU5ZOToExigVUm3lAiJhjyhinydlPh9gmyDwFKW217QxTv5ie5MvakEHY9as+40Uuu
         1zwA57h7Eo1L3BF+mtFdDGBeI5AJOHGeByvugsieuo567wJZzoZYWTk7Yc7pGArDeq6L
         4ozFc+7reIzSFPDkRge1ESZRiIPNNPGA/ooUlUkyB9HHSkgMZfOAJS9naFkpkvgkLQa/
         s2qQ==
X-Gm-Message-State: ACrzQf2k9EcBNWG0FWUcSp1BjkgwzivmJ+3nCipKg35+8czrxXov+lB5
        8GyPaYw7Q4POl2xfYQOwXiT9b4fatzPqP8n0+XB4PA==
X-Google-Smtp-Source: AMsMyM4dmMvnErNdT+EG50rOMSs4+6GMISDdeQKsh40zP/cThOB7W4z3fdNkTClhloLrKI8Q3nD4WYWYaxSIRuB8I74=
X-Received: by 2002:a05:6402:34cc:b0:451:62bf:c816 with SMTP id
 w12-20020a05640234cc00b0045162bfc816mr21023549edc.213.1663689706573; Tue, 20
 Sep 2022 09:01:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220919223915.5146-1-olof@lixom.net> <20220920061434.ettul5ae2bw6mxme@pengutronix.de>
In-Reply-To: <20220920061434.ettul5ae2bw6mxme@pengutronix.de>
From:   Olof Johansson <olof@lixom.net>
Date:   Tue, 20 Sep 2022 09:01:34 -0700
Message-ID: <CAOesGMhYLOZ8_hRmw7mY-2bTf65N-06g_YVm2fr-cnV=Y3widA@mail.gmail.com>
Subject: Re: [PATCH] serial: sifive: enable clocks for UART when probed
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, Sep 19, 2022 at 11:14 PM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
>
> Hello,
>
> On Mon, Sep 19, 2022 at 03:39:15PM -0700, Olof Johansson wrote:
> > When the PWM driver was changed to disable clocks if no PWMs are enable=
d,
> > it ended up also disabling the shared parent with the UART, since the
> > UART doesn't do any clock enablement on its own.
> >
> > To avoid these surprises, add clk_prepare_enable/clk_disable_unprepare
> > calls.
> >
> > Fixes: ace41d7564e655 ("pwm: sifive: Ensure the clk is enabled exactly =
once per running PWM")
> > Cc: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> > Cc: Emil Renner Berthing <emil.renner.berthing@canonical.com>
> > Cc: Palmer Dabbelt <palmer@dabbelt.com>
> > Cc: Paul Walmsley <paul.walmsley@sifive.com>
> > Signed-off-by: Olof Johansson <olof@lixom.net>
> > ---
> >  drivers/tty/serial/sifive.c | 14 ++++++++++----
> >  1 file changed, 10 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/tty/serial/sifive.c b/drivers/tty/serial/sifive.c
> > index 5c3a07546a58..751f98068806 100644
> > --- a/drivers/tty/serial/sifive.c
> > +++ b/drivers/tty/serial/sifive.c
> > @@ -950,23 +950,28 @@ static int sifive_serial_probe(struct platform_de=
vice *pdev)
> >               dev_err(&pdev->dev, "unable to find controller clock\n");
> >               return PTR_ERR(clk);
> >       }
> > +     clk_prepare_enable(clk);
>
> The return code of clk_prepare_enable() must be checked. Also there is a
> simpler patch to fix that problem. I didn't test but I expect just doing
>
> diff --git a/drivers/tty/serial/sifive.c b/drivers/tty/serial/sifive.c
> index 5c3a07546a58..4b1d4fe8458e 100644
> --- a/drivers/tty/serial/sifive.c
> +++ b/drivers/tty/serial/sifive.c
> @@ -945,7 +945,7 @@ static int sifive_serial_probe(struct platform_device=
 *pdev)
>                 return PTR_ERR(base);
>         }
>
> -       clk =3D devm_clk_get(&pdev->dev, NULL);
> +       clk =3D devm_clk_get_enabled(&pdev->dev, NULL);
>         if (IS_ERR(clk)) {
>                 dev_err(&pdev->dev, "unable to find controller clock\n");
>                 return PTR_ERR(clk);
>
> would be enough and also cares for disabling the clock on remove.

Yep, thanks for pointing that out. v2 sent out (after test).


-Olof

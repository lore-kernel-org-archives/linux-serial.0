Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EB7DCDB483
	for <linux-serial@archiver.kernel.org>; Thu, 12 Oct 2023 05:38:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233879AbjJLFiV (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 12 Oct 2023 01:38:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235294AbjJLFiU (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 12 Oct 2023 01:38:20 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E392BE
        for <linux-serial@vger.kernel.org>; Wed, 11 Oct 2023 22:38:18 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id 98e67ed59e1d1-278f0f565e2so470373a91.2
        for <linux-serial@vger.kernel.org>; Wed, 11 Oct 2023 22:38:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697089098; x=1697693898; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wwWnNHAbWyeAscY15FX+TU6dhJaouDy+zgSEChH3FwY=;
        b=hrhdeNL+xrFwt5JwZw2WTndkt3uiH1J30wKia9q7VffNmYl4iEhp32agj2z88CKH2q
         B1PZ0h0mz/aygSprMv+aUJ0etTN6MZzdmpThC7MSs/IKZIRX4d23Buf9OkWtORpbqLq2
         NrpkE8FLNrmAnDzTH47YWGRffztAQ1/vDPm+B+Ii5jNcKPSHIqu5SpGCqFKfXrjGXm+A
         CGxGxgReWs13EJ1d3vG8ALrwgdsKiqrcgnTf+H6qhS16qVdGuvS5jjwCOrrSIgxH+GAf
         pGPeXjxU2riHHxXosc5fneN9e/KBDDWBx5xWxbqlGawA8Ga2N+c1P+rgIANSduNugJQm
         mDLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697089098; x=1697693898;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wwWnNHAbWyeAscY15FX+TU6dhJaouDy+zgSEChH3FwY=;
        b=ivlJgE+hI488/xywtMrfUMQbwNmV5/cPcAcejGjJ7VweRZ/b+FO+CPyYtJ1A0EZn9V
         r5aI5FN2K5VAvTCxDA754sEjM5KXf7SNHTPyxNYeiPNu6KmqtenuSD4Pean+lxweK253
         eCGdT6nHapDbL2I+vtPmGTHHUg9XynPOM8n2VmjkIHCvtv0BXGBEhSnZeR5XeDRCDu4F
         MatxXa6OqODsK+fIc6RDbUXnqkIXJY3LrRGvv5vain5+fwGQe3A17bPLE3+w96QDybuK
         bphHdS0DeIRiTQK6fKKWh3PEorLxxuhqBmlEHt9xQ67DtXjo+nKXJsV9R0x8e3xsWUZE
         MEIA==
X-Gm-Message-State: AOJu0Yzp0cTK7ZFYuHCsJTueyxwXwxiML+g/mtauMLxxNUPi59DiNGZ9
        OtC5fLZQX3UCwZ2VvSjXNwXcFN3nXt1mPAwTbUcwiQ==
X-Google-Smtp-Source: AGHT+IGSsE9UdV0Qgkc/+49sBerKsPKwjip2GPaMvf0yjDHtLvarJUP6ASq6DTMnyLnKKYmGaxwKGOUUUcsGQWvpu/Q=
X-Received: by 2002:a17:90b:1c83:b0:274:616e:3fc4 with SMTP id
 oo3-20020a17090b1c8300b00274616e3fc4mr19950072pjb.34.1697089097916; Wed, 11
 Oct 2023 22:38:17 -0700 (PDT)
MIME-Version: 1.0
References: <20231011184823.443959-1-peter.griffin@linaro.org> <20231011184823.443959-17-peter.griffin@linaro.org>
In-Reply-To: <20231011184823.443959-17-peter.griffin@linaro.org>
From:   Sam Protsenko <semen.protsenko@linaro.org>
Date:   Thu, 12 Oct 2023 00:38:06 -0500
Message-ID: <CAPLW+4m1KLXJ67uDJ83V+zdSA0qU4cDh9Q+irpcixz1btMVv7Q@mail.gmail.com>
Subject: Re: [PATCH v3 16/20] tty: serial: samsung: Add gs101 compatible and
 SoC data
To:     Peter Griffin <peter.griffin@linaro.org>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        mturquette@baylibre.com, conor+dt@kernel.org, sboyd@kernel.org,
        tomasz.figa@gmail.com, s.nawrocki@samsung.com,
        linus.walleij@linaro.org, wim@linux-watchdog.org,
        linux@roeck-us.net, catalin.marinas@arm.com, will@kernel.org,
        arnd@arndb.de, olof@lixom.net, gregkh@linuxfoundation.org,
        cw00.choi@samsung.com, tudor.ambarus@linaro.org,
        andre.draszik@linaro.org, saravanak@google.com,
        willmcvicker@google.com, soc@kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-watchdog@vger.kernel.org,
        kernel-team@android.com, linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, Oct 11, 2023 at 1:49=E2=80=AFPM Peter Griffin <peter.griffin@linaro=
.org> wrote:
>
> Add serial driver data for Google Tensor gs101 SoC.
>
> Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
> ---

Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>

>  drivers/tty/serial/samsung_tty.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsun=
g_tty.c
> index 07fb8a9dac63..26bc52e681a4 100644
> --- a/drivers/tty/serial/samsung_tty.c
> +++ b/drivers/tty/serial/samsung_tty.c
> @@ -2597,14 +2597,22 @@ static const struct s3c24xx_serial_drv_data exyno=
s850_serial_drv_data =3D {
>         .fifosize =3D { 256, 64, 64, 64 },
>  };
>
> +static const struct s3c24xx_serial_drv_data gs101_serial_drv_data =3D {
> +       EXYNOS_COMMON_SERIAL_DRV_DATA(),
> +       /* rely on samsung,uart-fifosize DT property for fifosize */
> +       .fifosize =3D { 0 },
> +};
> +
>  #define EXYNOS4210_SERIAL_DRV_DATA (&exynos4210_serial_drv_data)
>  #define EXYNOS5433_SERIAL_DRV_DATA (&exynos5433_serial_drv_data)
>  #define EXYNOS850_SERIAL_DRV_DATA (&exynos850_serial_drv_data)
> +#define GS101_SERIAL_DRV_DATA (&gs101_serial_drv_data)
>
>  #else
>  #define EXYNOS4210_SERIAL_DRV_DATA NULL
>  #define EXYNOS5433_SERIAL_DRV_DATA NULL
>  #define EXYNOS850_SERIAL_DRV_DATA NULL
> +#define GS101_SERIAL_DRV_DATA NULL
>  #endif
>
>  #ifdef CONFIG_ARCH_APPLE
> @@ -2688,6 +2696,9 @@ static const struct platform_device_id s3c24xx_seri=
al_driver_ids[] =3D {
>         }, {
>                 .name           =3D "artpec8-uart",
>                 .driver_data    =3D (kernel_ulong_t)ARTPEC8_SERIAL_DRV_DA=
TA,
> +       }, {
> +               .name           =3D "gs101-uart",
> +               .driver_data    =3D (kernel_ulong_t)GS101_SERIAL_DRV_DATA=
,
>         },
>         { },
>  };
> @@ -2709,6 +2720,8 @@ static const struct of_device_id s3c24xx_uart_dt_ma=
tch[] =3D {
>                 .data =3D EXYNOS850_SERIAL_DRV_DATA },
>         { .compatible =3D "axis,artpec8-uart",
>                 .data =3D ARTPEC8_SERIAL_DRV_DATA },
> +       { .compatible =3D "google,gs101-uart",
> +               .data =3D  GS101_SERIAL_DRV_DATA },
>         {},
>  };
>  MODULE_DEVICE_TABLE(of, s3c24xx_uart_dt_match);
> --
> 2.42.0.655.g421f12c284-goog
>

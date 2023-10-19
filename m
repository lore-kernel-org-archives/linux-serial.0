Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 068A3CDB465
	for <linux-serial@archiver.kernel.org>; Thu, 19 Oct 2023 14:32:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235508AbjJSOcs (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 19 Oct 2023 10:32:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346179AbjJSOcj (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 19 Oct 2023 10:32:39 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E18341BF
        for <linux-serial@vger.kernel.org>; Thu, 19 Oct 2023 07:31:47 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1c9fa869a63so42986505ad.0
        for <linux-serial@vger.kernel.org>; Thu, 19 Oct 2023 07:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697725907; x=1698330707; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CIi5sl7kotf6K4zebahXrePOnqvZwmDyPuUbQKhEpnY=;
        b=DmWQkwvPkYojGMkbaeaACKz0u0I7ynfk+ssHQuK4vCwDDHODXHDkY9APjTyMKAaSd5
         ZlKwyztpwjFX5tIUG3Csdwof8ZiMWzvqeZSCrRZtdNy/JNrXWy47by5UVoqU94uEfNsl
         84k/jiDdQl9CSPLdYo/tm+uHzV8+aJ8KOkoxA1mhTfJLIp+FFK015Qu92nqoqwPQrunB
         hjsOCeS5VLDi2AFd6PE7wS/Q8MiZMwIGxX0oYPq9zBqQgS8QErOd4Y3zatBgIHIxbVHj
         ZpzFqr/lXXthwbOW7ytoNDhK3EYf77QYKmEN5F/y9ju/B0xSUyIBBL88ShgQ3rHP/BGT
         WwWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697725907; x=1698330707;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CIi5sl7kotf6K4zebahXrePOnqvZwmDyPuUbQKhEpnY=;
        b=hEFL1orKQBHiSLM+nmPuZrJatTTM/j0BwAWrdn1e+Pdy9OCt1cSEhZYWa/Lfo4sc8f
         Gf5i3raQ6kPh09JcZsSbM20k0AIOcSFbp4KWcxETGQ21k4sqCDHOYIztv3YYGUcIoF+e
         UDRPJLMZV5GFlZKn9QobzNSBP/mO7gcau+4L6IZrrVwuWmM+XLaXBtHsqlR34xcj+eON
         s33tnss8IQjOpJFgxlMG23tf3DPmMCkAn6z302CkB4z9fVra6NlHuwYvuqNHQ4OwfCPQ
         l7Hp6N5nHmrygaVgJW+KaoRFEetQfjk649RTj7nZDaEArIAIU/fk5MfDXqUKon3FTMEO
         z9gw==
X-Gm-Message-State: AOJu0YybDPxEGvY3lorhel1hibQpeA5cCpdDQ07MWnjdIhLsbm3lxHUp
        eiVDR9Gx9qithE+bDoS/tav7PDE54l5sxMa6Hj9MhQ==
X-Google-Smtp-Source: AGHT+IG/GJqdnqvx4V9L4BUA/fWFsRzxuErdFglDBcvKmdt4ZRtxaP1ns06xq1OdK3DtBHOoyVfRHYqF5bvkZSe5uxs=
X-Received: by 2002:a17:902:db0b:b0:1c8:a06e:fce9 with SMTP id
 m11-20020a170902db0b00b001c8a06efce9mr2922496plx.52.1697725907291; Thu, 19
 Oct 2023 07:31:47 -0700 (PDT)
MIME-Version: 1.0
References: <20231019100639.4026283-1-andre.draszik@linaro.org>
In-Reply-To: <20231019100639.4026283-1-andre.draszik@linaro.org>
From:   Sam Protsenko <semen.protsenko@linaro.org>
Date:   Thu, 19 Oct 2023 09:31:36 -0500
Message-ID: <CAPLW+4=oY1PjTTbsLq6QL5k37CZnqY1NprC1AxyAMkO4zBBDsQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] tty: serial: samsung: drop earlycon support for
 unsupported platforms
To:     =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Cc:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        alim.akhtar@samsung.com, linux-serial@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, Oct 19, 2023 at 5:06=E2=80=AFAM Andr=C3=A9 Draszik <andre.draszik@l=
inaro.org> wrote:
>
> Commit 1ea35b355722 ("ARM: s3c: remove s3c24xx specific hacks") removed
> support here for several old platforms, but kept support for earlycon
> for those same platforms.
>
> As earlycon support for otherwise unsupported platforms doesn't seem to
> be useful, just drop it as well.
>
> Suggested-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Andr=C3=A9 Draszik <andre.draszik@linaro.org>
> ---

Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>

>  drivers/tty/serial/samsung_tty.c | 16 +---------------
>  1 file changed, 1 insertion(+), 15 deletions(-)
>
> diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsun=
g_tty.c
> index 6b8d4b4402e9..a74ecc78f4e0 100644
> --- a/drivers/tty/serial/samsung_tty.c
> +++ b/drivers/tty/serial/samsung_tty.c
> @@ -2735,17 +2735,7 @@ static struct samsung_early_console_data s3c2410_e=
arly_console_data =3D {
>         .rxfifo_mask =3D S3C2410_UFSTAT_RXFULL | S3C2410_UFSTAT_RXMASK,
>  };
>
> -static int __init s3c2410_early_console_setup(struct earlycon_device *de=
vice,
> -                                             const char *opt)
> -{
> -       device->port.private_data =3D &s3c2410_early_console_data;
> -       return samsung_early_console_setup(device, opt);
> -}
> -
> -OF_EARLYCON_DECLARE(s3c2410, "samsung,s3c2410-uart",
> -                       s3c2410_early_console_setup);
> -
> -/* S3C2412, S3C2440, S3C64xx */
> +/* S3C64xx */
>  static struct samsung_early_console_data s3c2440_early_console_data =3D =
{
>         .txfull_mask =3D S3C2440_UFSTAT_TXFULL,
>         .rxfifo_mask =3D S3C2440_UFSTAT_RXFULL | S3C2440_UFSTAT_RXMASK,
> @@ -2758,10 +2748,6 @@ static int __init s3c2440_early_console_setup(stru=
ct earlycon_device *device,
>         return samsung_early_console_setup(device, opt);
>  }
>
> -OF_EARLYCON_DECLARE(s3c2412, "samsung,s3c2412-uart",
> -                       s3c2440_early_console_setup);
> -OF_EARLYCON_DECLARE(s3c2440, "samsung,s3c2440-uart",
> -                       s3c2440_early_console_setup);
>  OF_EARLYCON_DECLARE(s3c6400, "samsung,s3c6400-uart",
>                         s3c2440_early_console_setup);
>
> --
> 2.40.1
>
>

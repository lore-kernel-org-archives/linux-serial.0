Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84CDCC4332F
	for <linux-serial@archiver.kernel.org>; Mon, 13 Nov 2023 02:21:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231833AbjKMCVM (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sun, 12 Nov 2023 21:21:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbjKMCVM (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sun, 12 Nov 2023 21:21:12 -0500
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com [IPv6:2001:4860:4864:20::32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CE741980
        for <linux-serial@vger.kernel.org>; Sun, 12 Nov 2023 18:21:09 -0800 (PST)
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-1ef370c2e1aso2549234fac.2
        for <linux-serial@vger.kernel.org>; Sun, 12 Nov 2023 18:21:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699842068; x=1700446868; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Re27Y6Ewcgnd0UVTOodht+2DEZvd57O6j9pwb6qHvpg=;
        b=mdpsxSf5rVXQCdFO3Zsa6OaYH7bfjn91y3T02gvid6tWlliIDC3FLM2AkxlgIQ/Hzn
         VsXC6gzlrF84WuIRPC2HsnTLYBc+vvoypWGUhDi+B2xvBUhFoXKwgVQCvQUl3VuxlK3Q
         yD2S9g5c7g1jK4HyPuwSG0PFvTNmGbpUaJSGMj3ZGbTrQxXI49RL7UIJzYcTJye+zqFs
         S6XRpqux2Ws/7RHLG9qv2aK+zHSI26CeO5I562SXoPtIktgbTRt4bT2czwAnJA+f9Pm2
         Gt1t9rSXHKMeHgCdbQ+RD4/xXHruCEZ5FSA9uk7VP5Ut1VgQBpmO5xcSFe9vjAAZTg5A
         r1Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699842068; x=1700446868;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Re27Y6Ewcgnd0UVTOodht+2DEZvd57O6j9pwb6qHvpg=;
        b=WcT/d7IvP+5FcuYioUrdsU5iDSGYXSdstOz91M+FLolrHSUwpL6WaHVaCCheT3BJ5k
         5NQdm7xvIRmHEmW8EI/ZJ+j4Rh1tv09qf8QzOFwXboC4jQUxsULNZgJc1ATYS5YYK6gO
         ZQw2movFv8XkibJatgPeU8iRF9hX3tIDQhcnnHYGz4M6s1ExRduU0Mi2RdYWt24Nd4Pc
         iQPlD3N2CNvPTkII5sdJUjep2e2QQvsKjquzn848kmlPOaqGWPBG0eeECKI0d9/8u8Hg
         GC8pvDLrpQoWvGtwbxCaIUIH/cDUc6V5jgrbLLBOzxGl8M0mvYGwFIlL4eiH96hJ1VDz
         v/BA==
X-Gm-Message-State: AOJu0Yz6XqzGTFw1tRlj+5OpIih2jch7hGXrvipA8NmjuLjTrXmj12ob
        NeRZ3SLnDGg+1+nB9cZsvdvBWeHKigAUawzfovGW20hb
X-Google-Smtp-Source: AGHT+IF1ED6+k2pYpnl/IFdYGBcjggmXCpZXIKqS7tToGEKUg/Pt8yQxyhkyaTqbLR9LCpjHD+9P4gvBbV8rAqqO0kg=
X-Received: by 2002:a05:6870:4997:b0:1e9:fd9b:735 with SMTP id
 ho23-20020a056870499700b001e9fd9b0735mr7925454oab.56.1699842068120; Sun, 12
 Nov 2023 18:21:08 -0800 (PST)
MIME-Version: 1.0
References: <20231110152927.70601-1-u.kleine-koenig@pengutronix.de> <20231110152927.70601-41-u.kleine-koenig@pengutronix.de>
In-Reply-To: <20231110152927.70601-41-u.kleine-koenig@pengutronix.de>
From:   Chunyan Zhang <zhang.lyra@gmail.com>
Date:   Mon, 13 Nov 2023 10:20:31 +0800
Message-ID: <CAAfSe-t9pCSzjp816Ba-HY4K6gm0aTszP4BZYR6s_46P-D+fuw@mail.gmail.com>
Subject: Re: [PATCH 40/52] serial: sprd: Convert to platform remove callback
 returning void
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Richard GENOUD <richard.genoud@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yangtao Li <frank.li@vivo.com>, kernel@pengutronix.de,
        linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, 10 Nov 2023 at 23:30, Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
>
> The .remove() callback for a platform driver returns an int which makes
> many driver authors wrongly assume it's possible to do error handling by
> returning an error code. However the value returned is ignored (apart
> from emitting a warning) and this typically results in resource leaks.
>
> To improve here there is a quest to make the remove callback return
> void. In the first step of this quest all drivers are converted to
> .remove_new(), which already returns void. Eventually after all drivers
> are converted, .remove_new() will be renamed to .remove().
>
> Trivially convert this driver from always returning zero in the remove
> callback to the void returning variant.
>
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>

Acked-by: Chunyan Zhang <zhang.lyra@gmail.com>

Thanks,
Chunyan

> ---
>  drivers/tty/serial/sprd_serial.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/tty/serial/sprd_serial.c b/drivers/tty/serial/sprd_s=
erial.c
> index f257525f9299..15f14fa593da 100644
> --- a/drivers/tty/serial/sprd_serial.c
> +++ b/drivers/tty/serial/sprd_serial.c
> @@ -1076,7 +1076,7 @@ static struct uart_driver sprd_uart_driver =3D {
>         .cons =3D SPRD_CONSOLE,
>  };
>
> -static int sprd_remove(struct platform_device *dev)
> +static void sprd_remove(struct platform_device *dev)
>  {
>         struct sprd_uart_port *sup =3D platform_get_drvdata(dev);
>
> @@ -1089,8 +1089,6 @@ static int sprd_remove(struct platform_device *dev)
>
>         if (!sprd_ports_num)
>                 uart_unregister_driver(&sprd_uart_driver);
> -
> -       return 0;
>  }
>
>  static bool sprd_uart_is_console(struct uart_port *uport)
> @@ -1257,7 +1255,7 @@ MODULE_DEVICE_TABLE(of, serial_ids);
>
>  static struct platform_driver sprd_platform_driver =3D {
>         .probe          =3D sprd_probe,
> -       .remove         =3D sprd_remove,
> +       .remove_new     =3D sprd_remove,
>         .driver         =3D {
>                 .name   =3D "sprd_serial",
>                 .of_match_table =3D serial_ids,
> --
> 2.42.0
>

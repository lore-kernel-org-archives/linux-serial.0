Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48315C433F5
	for <linux-serial@archiver.kernel.org>; Mon, 16 May 2022 13:02:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242777AbiEPNB7 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 16 May 2022 09:01:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235154AbiEPNB5 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 16 May 2022 09:01:57 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 594DB39B8A
        for <linux-serial@vger.kernel.org>; Mon, 16 May 2022 06:01:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id CEB75CE167C
        for <linux-serial@vger.kernel.org>; Mon, 16 May 2022 13:01:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43A3FC3411A
        for <linux-serial@vger.kernel.org>; Mon, 16 May 2022 13:01:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652706113;
        bh=dt2q0BAubBNFIivPTcKqyS5+yjvrePptpIbMFFX4X4o=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=NoM3vXpaJNnJaPy86isXWOiYtGOavhw0R7j9a324NJdKhZ1CZNRJLDk+CJRb/tBz6
         CM9Yb5DNRqshehz3Yglj0bTWEbSZVnOwltzhQ33bEDtf7UTWNJ+b82eXDLyZfwUTWi
         ARunBFWQOxDSLZ6sC9eLeuG1TAztBqGkMlTOvzmlWJy9Ew6VAVd+RSkZv6I4h413LI
         zB2dUzqzYlajex56J8gaoeMnyOeuSBmdRoYnCJprSA+6YG/iTv+yPzhsHX7mpYoL4R
         J/XEhTN1Q0Ut8Au8g6O/vCUkQz9iD6z4uSj+f0uupwfn/7NvQQAVGz0RP4acLXeybk
         TNoZsy+Hz55PQ==
Received: by mail-wm1-f45.google.com with SMTP id c190-20020a1c35c7000000b0038e37907b5bso10889414wma.0
        for <linux-serial@vger.kernel.org>; Mon, 16 May 2022 06:01:53 -0700 (PDT)
X-Gm-Message-State: AOAM533NYJm/45m6LVE61zKOxEbLKkWwXXOBsHHOiYhtBWHb1obVGPOV
        RAAi01rdCDFCwjzH+dude2R9bXkYNI8ythN0u/E=
X-Google-Smtp-Source: ABdhPJxgRscm3U4PWITja0eAGPvhfZLXR7h/SdLHeitzxZF1wsquht7lO9Gdee/deeKZWNjRRyhbj60z0qsCxyts/HM=
X-Received: by 2002:a7b:c8c3:0:b0:394:547c:e5af with SMTP id
 f3-20020a7bc8c3000000b00394547ce5afmr27320317wml.202.1652706111351; Mon, 16
 May 2022 06:01:51 -0700 (PDT)
MIME-Version: 1.0
References: <035c738-8ea5-8b17-b1d7-84a7b3aeaa51@linux.intel.com>
In-Reply-To: <035c738-8ea5-8b17-b1d7-84a7b3aeaa51@linux.intel.com>
From:   Ricardo Ribalda Delgado <ribalda@kernel.org>
Date:   Mon, 16 May 2022 15:01:35 +0200
X-Gmail-Original-Message-ID: <CAPybu_0s86DENGRmcrhtsCttpmofGV=qsMeXFcs6=FS9dKVgew@mail.gmail.com>
Message-ID: <CAPybu_0s86DENGRmcrhtsCttpmofGV=qsMeXFcs6=FS9dKVgew@mail.gmail.com>
Subject: Re: [PATCH] serial: 8250_fintek: Check SER_RS485_RTS_* only with RS485
To:     =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        Lukas Wunner <lukas@wunner.de>,
        Jiri Slaby <jirislaby@kernel.org>,
        "Ji-Ze Hong (Peter Hong)" <hpeter@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, May 13, 2022 at 3:47 PM Ilpo J=C3=A4rvinen
<ilpo.jarvinen@linux.intel.com> wrote:
>
> SER_RS485_RTS_ON_SEND and SER_RS485_RTS_AFTER_SEND relate to behavior
> within RS485 operation. The driver checks if they have the same value
> which is not possible to realize with the hardware. The check is taken
> regardless of SER_RS485_ENABLED flag and -EINVAL is returned when the
> check fails, which creates problems.
>
> This check makes it unnecessarily complicated to turn RS485 mode off as
> simple zeroed serial_rs485 struct will trigger that equal values check.
> In addition, the driver itself memsets its rs485 structure to zero when
> RS485 is disabled but if userspace would try to make an TIOCSRS485
> ioctl() call with the very same struct, it would end up failing with
> -EINVAL which doesn't make much sense.
>
> Resolve the problem by moving the check inside SER_RS485_ENABLED block.
>
> Fixes: 7ecc77011c6f ("serial: 8250_fintek: Return -EINVAL on invalid conf=
iguration")
> Cc: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
> Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
Reviewed-by: Ricardo Ribalda <ribalda@chromium.org>
>
> ---
>  drivers/tty/serial/8250/8250_fintek.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/tty/serial/8250/8250_fintek.c b/drivers/tty/serial/8=
250/8250_fintek.c
> index 251f0018ae8c..dba5950b8d0e 100644
> --- a/drivers/tty/serial/8250/8250_fintek.c
> +++ b/drivers/tty/serial/8250/8250_fintek.c
> @@ -200,12 +200,12 @@ static int fintek_8250_rs485_config(struct uart_por=
t *port,
>         if (!pdata)
>                 return -EINVAL;
>
> -       /* Hardware do not support same RTS level on send and receive */
> -       if (!(rs485->flags & SER_RS485_RTS_ON_SEND) =3D=3D
> -                       !(rs485->flags & SER_RS485_RTS_AFTER_SEND))
> -               return -EINVAL;
>
>         if (rs485->flags & SER_RS485_ENABLED) {
> +               /* Hardware do not support same RTS level on send and rec=
eive */
> +               if (!(rs485->flags & SER_RS485_RTS_ON_SEND) =3D=3D
> +                   !(rs485->flags & SER_RS485_RTS_AFTER_SEND))
> +                       return -EINVAL;
>                 memset(rs485->padding, 0, sizeof(rs485->padding));
>                 config |=3D RS485_URA;
>         } else {
>
> --
> tg: (4419da5d5d4b..) fix/8250-fintek-rts-check (depends on: tty-next)

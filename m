Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85091C433EF
	for <linux-serial@archiver.kernel.org>; Tue, 14 Jun 2022 06:59:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230405AbiFNG7P (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 14 Jun 2022 02:59:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238418AbiFNG7N (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 14 Jun 2022 02:59:13 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6675C3B028
        for <linux-serial@vger.kernel.org>; Mon, 13 Jun 2022 23:59:11 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id x5so10247526edi.2
        for <linux-serial@vger.kernel.org>; Mon, 13 Jun 2022 23:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=+7WMD7g2wZYb5dSwiAnQZIEJ3VeyDCmAN8KFzddYOp4=;
        b=Qn+BB8Jz4dOSSuyrdIFx7KsYfWlcB8w5h84FMz8xUnGUKIl0tBzLcfDhfc+d6PDKPt
         RTlvUsK+T+XW28X34a1fP+V8SjNa7E8lxQdHCRx8hmrlEKGiC/utx/jrYPpLM46D3Z8D
         TzKlHvtIbtxTD5G3b9NWNMNC7EnmdNaBF2vxFKYrS13WsrVJmmoT80kvrASk7didPM/u
         pw6ygfC5WGtZUU83nXq78KqTpRjn9kLyBYr/UQjuIxzvGGdSZ5QSGwtcSp7mwj8/0Kim
         sG9vp6Uc18tm4iRsKkKEboJLKGl/KD5WXJsdFMRlsbcQPu8Un9YporcV1/6eqzVz0FR0
         O0zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+7WMD7g2wZYb5dSwiAnQZIEJ3VeyDCmAN8KFzddYOp4=;
        b=W7nOqZRql6TIFxmanUkIRPWpqp2Dfm7cQCzW/kQifXV7Xhv/et16VGwO7WA8I5tFK+
         lHk4XsfYynlJH84bnffQxjFXBtxFe0UR79yKzeBHamfDuXj9DV7cTXEmnTbVcgNsVqUc
         IOdzn7UGsMWZdomActgaOvJVcbe5ZJHp4PjkaRg2bpSsbBx2ULc/pbN4x6q6sIde1hk9
         wYWwLThryd4x+iOxgxK2QB4c0Lwl1W/ux8DCOgc06C+Kl7pEG/GpwHz5ODS3nFVxbnGo
         qx7laZfEbfAzovIhmqZMI0e0CjKp5EXJMQczOu807cxWsudYUB8Fd0aHOdxD9UkooIyZ
         cqYw==
X-Gm-Message-State: AOAM532PhMvovInAhFXNS1jYZATO7IO+EnNTP9ckJFt5kDpjUbodxgGg
        EBv1heU5RnYsX4ZX69XYjxqWLXwJCwZQJajFjjQ=
X-Google-Smtp-Source: ABdhPJyosQaddnqZu4pZ1jXy8rUawFTRJhK2QoJYXQYTf9rowbQkT68XZOL23Z85o8JvfmRgqjKO5rY6WtiPdWsewNc=
X-Received: by 2002:a05:6402:1453:b0:431:503f:a2ce with SMTP id
 d19-20020a056402145300b00431503fa2cemr4088117edx.234.1655189949713; Mon, 13
 Jun 2022 23:59:09 -0700 (PDT)
MIME-Version: 1.0
References: <45e1eac1-1818-1f8c-6168-cff6be6427af@linux.intel.com>
 <CAEXMXLRrysT_+RUZ4sg6DGT8Hzdv2jrzX2eZ2Z0mPu39y3-m7g@mail.gmail.com> <ea30fbc2-6535-9fdd-6691-9bb7baa56ec2@linux.intel.com>
In-Reply-To: <ea30fbc2-6535-9fdd-6691-9bb7baa56ec2@linux.intel.com>
From:   =?UTF-8?Q?Nuno_Gon=C3=A7alves?= <nunojpg@gmail.com>
Date:   Tue, 14 Jun 2022 07:58:58 +0100
Message-ID: <CAEXMXLTTefeVh3otDL1R0jV0dQh5+S4tfV_zKhZ985V-w1hFLw@mail.gmail.com>
Subject: Re: [PATCH] serial: pl011: UPSTAT_AUTORTS requires .throttle/unthrottle
To:     =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     Tomasz Mon <tomasz.mon@camlingroup.com>,
        Lukas Wunner <lukas@wunner.de>,
        linux-serial <linux-serial@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, Jun 8, 2022 at 11:04 AM Ilpo J=C3=A4rvinen
<ilpo.jarvinen@linux.intel.com> wrote:
> Hi Nuno,
>
> It seems I managed to put the .throttle and .unthrottle into the wrong
> ops within amba-pl011.c. I'm sorry about the extra trouble. This patch ha=
s
> a bit higher likelihood of doing something useful to the problem:
>
> From: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> [PATCH v3] serial: pl011: UPSTAT_AUTORTS requires .throttle/unthrottle
>
> The driver must provide throttle and unthrottle in uart_ops when it
> sets UPSTAT_AUTORTS. Add them using existing stop_rx &
> enable_interrupts functions.
>
> Reported-by: Nuno Gon=C3=A7alves <nunojpg@gmail.com>
> Fixes: 2a76fa283098 (serial: pl011: Adopt generic flag to store auto RTS =
status)
> Cc: Lukas Wunner <lukas@wunner.de>
> Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
>
> ---
>  drivers/tty/serial/amba-pl011.c | 23 +++++++++++++++++++++--
>  1 file changed, 21 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl=
011.c
> index 97ef41cb2721..16a21422ddce 100644
> --- a/drivers/tty/serial/amba-pl011.c
> +++ b/drivers/tty/serial/amba-pl011.c
> @@ -1367,6 +1367,15 @@ static void pl011_stop_rx(struct uart_port *port)
>         pl011_dma_rx_stop(uap);
>  }
>
> +static void pl011_throttle_rx(struct uart_port *port)
> +{
> +       unsigned long flags;
> +
> +       spin_lock_irqsave(&port->lock, flags);
> +       pl011_stop_rx(port);
> +       spin_unlock_irqrestore(&port->lock, flags);
> +}
> +
>  static void pl011_enable_ms(struct uart_port *port)
>  {
>         struct uart_amba_port *uap =3D
> @@ -1788,9 +1797,10 @@ static int pl011_allocate_irq(struct uart_amba_por=
t *uap)
>   */
>  static void pl011_enable_interrupts(struct uart_amba_port *uap)
>  {
> +       unsigned long flags;
>         unsigned int i;
>
> -       spin_lock_irq(&uap->port.lock);
> +       spin_lock_irqsave(&uap->port.lock, flags);
>
>         /* Clear out any spuriously appearing RX interrupts */
>         pl011_write(UART011_RTIS | UART011_RXIS, uap, REG_ICR);
> @@ -1812,7 +1822,14 @@ static void pl011_enable_interrupts(struct uart_am=
ba_port *uap)
>         if (!pl011_dma_rx_running(uap))
>                 uap->im |=3D UART011_RXIM;
>         pl011_write(uap->im, uap, REG_IMSC);
> -       spin_unlock_irq(&uap->port.lock);
> +       spin_unlock_irqrestore(&uap->port.lock, flags);
> +}
> +
> +static void pl011_unthrottle_rx(struct uart_port *port)
> +{
> +       struct uart_amba_port *uap =3D container_of(port, struct uart_amb=
a_port, port);
> +
> +       pl011_enable_interrupts(uap);
>  }
>
>  static int pl011_startup(struct uart_port *port)
> @@ -2225,6 +2242,8 @@ static const struct uart_ops amba_pl011_pops =3D {
>         .stop_tx        =3D pl011_stop_tx,
>         .start_tx       =3D pl011_start_tx,
>         .stop_rx        =3D pl011_stop_rx,
> +       .throttle       =3D pl011_throttle_rx,
> +       .unthrottle     =3D pl011_unthrottle_rx,
>         .enable_ms      =3D pl011_enable_ms,
>         .break_ctl      =3D pl011_break_ctl,
>         .startup        =3D pl011_startup,
>
> --
> tg: (f2906aa86338..) pl011/add-throttle (depends on: tty-next)

Works great, thanks.

Tested-by: Nuno Gon=C3=A7alves <nunojpg@gmail.com>

Thanks,
Nuno

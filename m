Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8FE0C433FE
	for <linux-serial@archiver.kernel.org>; Fri, 21 Oct 2022 11:48:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230264AbiJULs2 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 21 Oct 2022 07:48:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230190AbiJULs1 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 21 Oct 2022 07:48:27 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADDBE3B96A
        for <linux-serial@vger.kernel.org>; Fri, 21 Oct 2022 04:48:26 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id p6so2110289plr.7
        for <linux-serial@vger.kernel.org>; Fri, 21 Oct 2022 04:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gP2ytTs+LAre/BcxYYn7OcjeedfuE4P1v/EP76rYVYc=;
        b=WWwJKWiyw/cZZLt69AZe42IuxkHicl8eE4lNf+g/G/Oz8Asz/Tkx3rUS2F2ihuW2CE
         +eu+LmFWryKy7D9NybKfY/jUl8aaXlWe8DgJyo0MPG5v1hT7bsAgcOreYIiMHULOFge2
         mCrcw54kLSntdpIxCyUN48rGrEyA6o5Js2UbT2xxZnN8fnM3XMRn48Re0EdEl3zUt+ZH
         SVEruc7G0s8iuEPfcknYbRENySw9InUPeIkMmnUh2NuKk48dMdOP3PXqzZkkFYO4j4CA
         5Vqkta0XIT6MjlW7TzM16RBe5hyLF9JJbWvYkRR1ZXlUJPN5uhszE4uRI15/kBFoDCQd
         dNDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gP2ytTs+LAre/BcxYYn7OcjeedfuE4P1v/EP76rYVYc=;
        b=fbN8uVxdriR3Y+nIlz5Ez1Ijc0uI/93mWowWtbD/53eAnQMRSLkmDJQcXKNE7UPcAT
         Nf7Tt8KRjMkQLDC6ieq8p0EJ8W8S8DjvF2XXz1pSKqs+lj3Ze4c4yU8LHJBGqzqGqvmg
         F2iU/D0r5OyxnY4URsYLm5wycGrsJ6ElffkCUbI2LoMaC0xC8YANKpbDa6KBnskgLDee
         UKo6hqPaU1/rI+xpFbMMbH2ogHKUU9yL3DDyAREF+xzvtbnlDSspIy6a3WShBUOheNqn
         LpdmOB3+RsmNbwSJ1tKG1D9Yxzx1KOJ2jCQK1nu/2I6s0Q4tyI9Nn7si0IVV5N7wAXQA
         If8Q==
X-Gm-Message-State: ACrzQf1djDgIQhXGvu3+ZjN/fQfAuQa5hux/Zo5g4pEsOzWU1C9wdN5K
        vcXLxmit5TfnaEAh2Np36D9rUS+Zmhxba8CNuTuhqw==
X-Google-Smtp-Source: AMsMyM4Ln3GENJVVY9y9uUTjBv6QEb5fLuIGqTxCjw4QcCnqPFs6DE+BPvh41R7oPBc3h7Tjvx44bZy9NmwEwWcg40w=
X-Received: by 2002:a17:90a:64c3:b0:212:d67d:a034 with SMTP id
 i3-20020a17090a64c300b00212d67da034mr1218159pjm.55.1666352906221; Fri, 21 Oct
 2022 04:48:26 -0700 (PDT)
MIME-Version: 1.0
References: <20221019091151.6692-1-ilpo.jarvinen@linux.intel.com> <20221019091151.6692-29-ilpo.jarvinen@linux.intel.com>
In-Reply-To: <20221019091151.6692-29-ilpo.jarvinen@linux.intel.com>
From:   Sam Protsenko <semen.protsenko@linaro.org>
Date:   Fri, 21 Oct 2022 13:48:14 +0200
Message-ID: <CAPLW+4mFiuuSGq-ucqsif=qhzWz7p87Na_Q0U6VVopmfhh-=Wg@mail.gmail.com>
Subject: Re: [PATCH 28/44] serial: samsung_tty: Use uart_xmit_advance()
To:     =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     linux-serial@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, 19 Oct 2022 at 11:35, Ilpo J=C3=A4rvinen
<ilpo.jarvinen@linux.intel.com> wrote:
>
> Take advantage of the new uart_xmit_advance() helper.
>
> Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> ---

Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>

>  drivers/tty/serial/samsung_tty.c | 10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsun=
g_tty.c
> index 77d1363029f5..7e34361a1085 100644
> --- a/drivers/tty/serial/samsung_tty.c
> +++ b/drivers/tty/serial/samsung_tty.c
> @@ -288,7 +288,6 @@ static void s3c24xx_serial_stop_tx(struct uart_port *=
port)
>  {
>         struct s3c24xx_uart_port *ourport =3D to_ourport(port);
>         struct s3c24xx_uart_dma *dma =3D ourport->dma;
> -       struct circ_buf *xmit =3D &port->state->xmit;
>         struct dma_tx_state state;
>         int count;
>
> @@ -316,8 +315,7 @@ static void s3c24xx_serial_stop_tx(struct uart_port *=
port)
>                                         DMA_TO_DEVICE);
>                 async_tx_ack(dma->tx_desc);
>                 count =3D dma->tx_bytes_requested - state.residue;
> -               xmit->tail =3D (xmit->tail + count) & (UART_XMIT_SIZE - 1=
);
> -               port->icount.tx +=3D count;
> +               uart_xmit_advance(port, count);
>         }
>
>         ourport->tx_enabled =3D 0;
> @@ -351,8 +349,7 @@ static void s3c24xx_serial_tx_dma_complete(void *args=
)
>
>         spin_lock_irqsave(&port->lock, flags);
>
> -       xmit->tail =3D (xmit->tail + count) & (UART_XMIT_SIZE - 1);
> -       port->icount.tx +=3D count;
> +       uart_xmit_advance(port, count);
>         ourport->tx_in_progress =3D 0;
>
>         if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
> @@ -916,8 +913,7 @@ static void s3c24xx_serial_tx_chars(struct s3c24xx_ua=
rt_port *ourport)
>                         break;
>
>                 wr_reg(port, S3C2410_UTXH, xmit->buf[xmit->tail]);
> -               xmit->tail =3D (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
> -               port->icount.tx++;
> +               uart_xmit_advance(port, 1);
>                 count--;
>         }
>
> --
> 2.30.2
>

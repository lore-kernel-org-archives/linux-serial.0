Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 323CEC28D13
	for <linux-serial@archiver.kernel.org>; Fri, 19 Aug 2022 22:44:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242812AbiHSWod (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 19 Aug 2022 18:44:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbiHSWob (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 19 Aug 2022 18:44:31 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9F0B7FFB2
        for <linux-serial@vger.kernel.org>; Fri, 19 Aug 2022 15:44:30 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id x5so4375668qtv.9
        for <linux-serial@vger.kernel.org>; Fri, 19 Aug 2022 15:44:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=nRXf1WR+iJ/uQGmUejdFhyx7h3LBEatDAkCOYLDBqTk=;
        b=mF7xVcalRctcfvOTHMqdXesuJJiIw7///u9b3BhQiBwMJOpUmfKkWYgL9FDQl0WXvg
         a+ay/s5elsu9U9VvP5nCFF/69zU7MJW9HmDqA04itBVpeDR2twIBgvRMLSJNDkeqrc2k
         Rqe+q3RN4vSAA67lUDLPRu1Hx3q/ktjaeLBqPgDccHvjK+o00LCFbVbhyu/rbh9PfJCT
         Dc6zBqTefd5c5JBdSJtihvTvLA8FtiXPYZV0MZwtNSQAnHDLjM9hPrO76Y2ZZibbYNN3
         2Ja40NARqLbx5hViAKKXk/9ZxBRzW8mkRNCAE/OH1kP/YichgD9F71exa2M2uxaRrqLn
         eyzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=nRXf1WR+iJ/uQGmUejdFhyx7h3LBEatDAkCOYLDBqTk=;
        b=mcmaS246A67mx8ODIMyCKYCdMhV32vMrj8dsu8iBp7odvOXWftdRNc0IHmQfI43OvA
         rK0i7LwV4ppEmbT3MS51V97fLf+BEieC6KXABzyUcjNbA6uTx6Ol81VVBTGFrc5aNuRC
         Ba7lMKUMJQjsRB+8uglGt0zq1ieIB/eMqcCUM5iGG6MPGyjsmftumBa+D9ATAvuO6+FW
         oyNW9o8Ua47fwfEzq2uwuaq8Luy543M5khszTNjUJIpqF4EjmKN11pb5FHowZluXnDmz
         dq2oWsIJToywfgb5vKtKnzJbsMTa39HtdTcjmDZWd/nk1CsMH6EtRt1sGLupG4W0fYuC
         VH5w==
X-Gm-Message-State: ACgBeo2mon2R40a7FaZbGl2AIMBaXi3zN2yyh9E01HxXoCrArF6l0+3V
        Hj3S+oAEOqHPt4oiwKCb0pCkO5GC3+hZGkuLiX0=
X-Google-Smtp-Source: AA6agR6j5/IEn5cjNSUc0ZID3ft4A7N91m7K6DytmbBM/9TGN+V+vjQ5TFlkJx5D/uilAHLjEUhWX0VGid2LTGd92AA=
X-Received: by 2002:ac8:7dd0:0:b0:344:afc1:b11d with SMTP id
 c16-20020ac87dd0000000b00344afc1b11dmr127035qte.195.1660949069831; Fri, 19
 Aug 2022 15:44:29 -0700 (PDT)
MIME-Version: 1.0
References: <3b885e7f-1372-3aa9-febd-34566ba25e3d@linux.intel.com>
In-Reply-To: <3b885e7f-1372-3aa9-febd-34566ba25e3d@linux.intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 20 Aug 2022 01:43:53 +0300
Message-ID: <CAHp75VfU-wmmEcLcRKYGqRXS8pyPXFM9=f5FUvHUxp7iXJpODA@mail.gmail.com>
Subject: Re: [PATCH] serial: 8250: Clear dma tx_err unconditionally
To:     =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, Aug 19, 2022 at 2:04 PM Ilpo J=C3=A4rvinen
<ilpo.jarvinen@linux.intel.com> wrote:
>
> No need to check non-zeroness first and then clear. Just set to zero
> unconditionally.

Harmless micro-optimization,
Acked-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
>
> ---
>  drivers/tty/serial/8250/8250_dma.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/tty/serial/8250/8250_dma.c b/drivers/tty/serial/8250=
/8250_dma.c
> index a8dba4a0a8fb..d99020fd3427 100644
> --- a/drivers/tty/serial/8250/8250_dma.c
> +++ b/drivers/tty/serial/8250/8250_dma.c
> @@ -107,8 +107,7 @@ int serial8250_tx_dma(struct uart_8250_port *p)
>
>         dma_async_issue_pending(dma->txchan);
>         serial8250_clear_THRI(p);
> -       if (dma->tx_err)
> -               dma->tx_err =3D 0;
> +       dma->tx_err =3D 0;
>
>         return 0;
>  err:
>
> --
> tg: (568035b01cfb..) 8250dma/tx_err-clear-unconditionally (depends on: tt=
y-next)



--=20
With Best Regards,
Andy Shevchenko

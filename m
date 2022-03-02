Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C49F1C433FE
	for <linux-serial@archiver.kernel.org>; Wed,  2 Mar 2022 11:51:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241608AbiCBLwQ (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 2 Mar 2022 06:52:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231761AbiCBLwP (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 2 Mar 2022 06:52:15 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09A9BBA754
        for <linux-serial@vger.kernel.org>; Wed,  2 Mar 2022 03:51:32 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id r20so1941043ljj.1
        for <linux-serial@vger.kernel.org>; Wed, 02 Mar 2022 03:51:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tTrGdMDWQ+1A7dYzCk6TbFd6dqfxQ2KILpXjfdugkSA=;
        b=e8J1qC7gEUkDauQ/SvucUsIBb44MqH38JrytyAopOIpx9AlEfP0ZIlsZT4UE44sXCV
         gPvXVvWWXbU6C1vaZolRSh53mZI+HSRaty9LTP0+REFySM9IIXjxx4Zp7k0mpWfWj1fo
         bazHPIBwZeWB/3BSNUXMdGmtdu/P4G3LLSnvQ69NAeguvBI5b7AgsrRqgG6kIs2R0UUp
         kokz1DBXeEiQv+ybwQDV8MW8aFK/Rishq+NDZ2AO45/TTswPZBvTus7crDY+a5eMhUqr
         YyZWL5n14aLHmdbiqFb8u/Gyci7kP3xT9ItwqfLKNgMQHSz8TkGjr/697v0k4N+aIX6e
         /kOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tTrGdMDWQ+1A7dYzCk6TbFd6dqfxQ2KILpXjfdugkSA=;
        b=eQodNkBoBsJnkpMNaXWpA2zhmzbQB7/5HmtY/LG04EFaUgnDNF2QFUR+44Xy9xqsqO
         NPRi67dhrMBF4sT7c/3eBjEHvOWjkKDGsNX9wD73WUlCkVhZ6Ekr5Bx0nIKKhSZPmkpR
         R2PUu+XUq6jB/M/Kn8W+sn7D17LYVGBZrGWHrLSKlNaTap7Rvz50BGPx6G24bkitaWBt
         jjZHQ/iusXPDY5nJKjltYe9KckpYzkoGfVW27zy/1bDm6LGaYJ0Epjhhj+Pf2Xhq6NGX
         jOB2Q36bDjdV3QKHInY83B0009W0vcsTO7WK46vg/qv72udMFLkp43MuOXIawhnOjwaN
         LS5w==
X-Gm-Message-State: AOAM530oXVyE8aBLUEMeEupjH6jap45ShK23Lj/mBSGeUOEiCEYULqhF
        Q4Tq4WApC7lTTSaamnA/GSnneHzBPVg1rYn2TbGlCw==
X-Google-Smtp-Source: ABdhPJwS2G1eiZJOoHJsLwgtNNztW4acgzTs5l4t1s8KYseKrLtx13lw6/mpFULZC57xMYfs39EwDUa/WeERuxh3uF0=
X-Received: by 2002:a2e:b16a:0:b0:244:e31c:ea96 with SMTP id
 a10-20020a2eb16a000000b00244e31cea96mr20861501ljm.500.1646221890128; Wed, 02
 Mar 2022 03:51:30 -0800 (PST)
MIME-Version: 1.0
References: <20220302101925.210810-1-woodylin@google.com> <c13930a5-85ab-5a2c-54e5-15fc5bc87b17@canonical.com>
In-Reply-To: <c13930a5-85ab-5a2c-54e5-15fc5bc87b17@canonical.com>
From:   Woody Lin <woodylin@google.com>
Date:   Wed, 2 Mar 2022 19:51:18 +0800
Message-ID: <CAHn4DecKKzrxPrOWPhdQf88g+01vqO=9=qPM3hOEdVVAFhScfw@mail.gmail.com>
Subject: Re: [PATCH] serial: samsung: Add samsung_early_read to support early kgdboc
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Alim Akhtar <alim.akhtar@samsung.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, Mark Cheng <markcheng@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, Mar 2, 2022 at 7:14 PM Krzysztof Kozlowski
<krzysztof.kozlowski@canonical.com> wrote:
>
> On 02/03/2022 11:19, Woody Lin wrote:
> > The 'kgdboc_earlycon_init' looks for boot console that has both .read
> > and .write callbacks. Adds 'samsung_early_read' to samsung_tty.c's early
> > console to support kgdboc.
> >
> > Signed-off-by: Woody Lin <woodylin@google.com>
> > ---
> >  drivers/tty/serial/samsung_tty.c | 25 +++++++++++++++++++++++++
> >  1 file changed, 25 insertions(+)
> >
> > diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
> > index d002a4e48ed9..eeb30d016ff1 100644
> > --- a/drivers/tty/serial/samsung_tty.c
> > +++ b/drivers/tty/serial/samsung_tty.c
> > @@ -2949,6 +2949,7 @@ static void wr_reg_barrier(struct uart_port *port, u32 reg, u32 val)
> >
> >  struct samsung_early_console_data {
> >       u32 txfull_mask;
> > +     u32 rxfifo_mask;
> >  };
> >
> >  static void samsung_early_busyuart(struct uart_port *port)
> > @@ -2983,6 +2984,26 @@ static void samsung_early_write(struct console *con, const char *s,
> >       uart_console_write(&dev->port, s, n, samsung_early_putc);
> >  }
> >
> > +static int samsung_early_read(struct console *con, char *s, unsigned int n)
> > +{
> > +     struct earlycon_device *dev = con->data;
> > +     struct samsung_early_console_data *data = dev->port.private_data;
>
> This can be const.
>
> Rest looks ok.
>

Thanks, PATCH v2 is uploaded.

Regards,
Woody

>
> Best regards,
> Krzysztof

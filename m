Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 191AEC47088
	for <linux-serial@archiver.kernel.org>; Fri,  2 Dec 2022 17:24:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233548AbiLBRYn (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 2 Dec 2022 12:24:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234192AbiLBRYd (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 2 Dec 2022 12:24:33 -0500
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D2C3C2D31
        for <linux-serial@vger.kernel.org>; Fri,  2 Dec 2022 09:24:32 -0800 (PST)
Received: by mail-io1-xd29.google.com with SMTP id b2so3470486iof.12
        for <linux-serial@vger.kernel.org>; Fri, 02 Dec 2022 09:24:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ofFR/mVCsDKZj44lDEy/8k5d1m69ZQ2boKHQlr/3NdY=;
        b=NteYCFzY9P/RDwVHhhAOK1Uw483SNoVV17UFJtHDLJLYGlp3mGvBAvsBoUffOclc+M
         q5BSW5wje1nc5AdNtDN+njEC+3gXB/ZKqDonnXMFu5Nra059pO6/Cj3uI24f6cEXaAYp
         wvEqg8R+oeVO1abR93kTH6Kk/WRAgiCrjxOAI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ofFR/mVCsDKZj44lDEy/8k5d1m69ZQ2boKHQlr/3NdY=;
        b=rI1MWY8b8KCyH9Y0Q5gVNgAX/znNYb5ad+TbG5CS9R92BiVvOjm1NIDbmTnKwbrnsw
         pIiNmAEorUWnG2CMP/jFco9h0FlzenYrqOuI6oQzqYQ1m+eWdQMpXhuUqygX5ZqkPl2y
         I2ADFwZL8qZuGzxPQyWbqISes+scdpCMlAy71jJAscxx87mPESTIc3ob/NmmnThf0dO/
         LPoleIXInv8ZVqkEmdeCbd1+usx0uck9aa4L12xkXMVlfGuk4LhkuwiZohCh4gzdBYKO
         bD8ss4pkzxHFTYkhs+K+IX2fPKuuHPTTY2C3e4itvchwj5HqCAoWq9hjvJwaYq4Ks25X
         5Itg==
X-Gm-Message-State: ANoB5pnI1WMa2GFY0JCzC7gk6xADTA+oUwIg28uUl6fRkgHJ5jemMZL9
        pz/79S3KT2WeSw9mg+fbuTZnxZALSXQDkYP3esI=
X-Google-Smtp-Source: AA0mqf6aN6SDzv/1k2MmqHDkWDZGpc/F8RfMkDtxF1njsnz5isdX8Qm1eWkIUo/l9pOlLoB74MpOhQ==
X-Received: by 2002:a02:5147:0:b0:365:cd53:9fbb with SMTP id s68-20020a025147000000b00365cd539fbbmr27077520jaa.220.1670001871820;
        Fri, 02 Dec 2022 09:24:31 -0800 (PST)
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com. [209.85.166.47])
        by smtp.gmail.com with ESMTPSA id y17-20020a056e02119100b00300d3c0e33dsm2651686ili.4.2022.12.02.09.24.30
        for <linux-serial@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Dec 2022 09:24:30 -0800 (PST)
Received: by mail-io1-f47.google.com with SMTP id 135so3483239iou.7
        for <linux-serial@vger.kernel.org>; Fri, 02 Dec 2022 09:24:30 -0800 (PST)
X-Received: by 2002:a5e:c64a:0:b0:6cc:e295:7bde with SMTP id
 s10-20020a5ec64a000000b006cce2957bdemr24816919ioo.183.1670001870306; Fri, 02
 Dec 2022 09:24:30 -0800 (PST)
MIME-Version: 1.0
References: <20221123-serial-clk-v3-0-49c516980ae0@chromium.org> <20221123-serial-clk-v3-1-49c516980ae0@chromium.org>
In-Reply-To: <20221123-serial-clk-v3-1-49c516980ae0@chromium.org>
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Fri, 2 Dec 2022 18:24:19 +0100
X-Gmail-Original-Message-ID: <CANiDSCs-CdhdvZF1PsDWivWiTB-=66DK4XOrv5hzbgbC9Z=+Rg@mail.gmail.com>
Message-ID: <CANiDSCs-CdhdvZF1PsDWivWiTB-=66DK4XOrv5hzbgbC9Z=+Rg@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] earlycon: Let users set the clock frequency
To:     Jonathan Corbet <corbet@lwn.net>,
        Jiri Slaby <jirislaby@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi Jiri

is there something else that I am missing here?

Thanks!

On Thu, 24 Nov 2022 at 13:39, Ricardo Ribalda <ribalda@chromium.org> wrote:
>
> Some platforms, namely AMD Picasso, use non standard uart clocks (48M),
> witch makes it impossible to use with earlycon.
>
> Let the user select its own frequency.
>
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
>
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index a465d5242774..9efb6c3b0486 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -1182,10 +1182,10 @@
>                         specified, the serial port must already be setup and
>                         configured.
>
> -               uart[8250],io,<addr>[,options]
> -               uart[8250],mmio,<addr>[,options]
> -               uart[8250],mmio32,<addr>[,options]
> -               uart[8250],mmio32be,<addr>[,options]
> +               uart[8250],io,<addr>[,options[,uartclk]]
> +               uart[8250],mmio,<addr>[,options[,uartclk]]
> +               uart[8250],mmio32,<addr>[,options[,uartclk]]
> +               uart[8250],mmio32be,<addr>[,options[,uartclk]]
>                 uart[8250],0x<addr>[,options]
>                         Start an early, polled-mode console on the 8250/16550
>                         UART at the specified I/O port or MMIO address.
> @@ -1194,7 +1194,9 @@
>                         If none of [io|mmio|mmio32|mmio32be], <addr> is assumed
>                         to be equivalent to 'mmio'. 'options' are specified
>                         in the same format described for "console=ttyS<n>"; if
> -                       unspecified, the h/w is not initialized.
> +                       unspecified, the h/w is not initialized. 'uartclk' is
> +                       the uart clock frequency; if unspecified, it is set
> +                       to 'BASE_BAUD' * 16.
>
>                 pl011,<addr>
>                 pl011,mmio32,<addr>
> diff --git a/drivers/tty/serial/earlycon.c b/drivers/tty/serial/earlycon.c
> index a5f380584cda..3a0c88419b6c 100644
> --- a/drivers/tty/serial/earlycon.c
> +++ b/drivers/tty/serial/earlycon.c
> @@ -120,7 +120,13 @@ static int __init parse_options(struct earlycon_device *device, char *options)
>         }
>
>         if (options) {
> +               char *uartclk;
> +
>                 device->baud = simple_strtoul(options, NULL, 0);
> +               uartclk = strchr(options, ',');
> +               if (uartclk && kstrtouint(uartclk + 1, 0, &port->uartclk) < 0)
> +                       pr_warn("[%s] unsupported earlycon uart clkrate option\n",
> +                               options);
>                 length = min(strcspn(options, " ") + 1,
>                              (size_t)(sizeof(device->options)));
>                 strscpy(device->options, options, length);
> @@ -139,7 +145,8 @@ static int __init register_earlycon(char *buf, const struct earlycon_id *match)
>                 buf = NULL;
>
>         spin_lock_init(&port->lock);
> -       port->uartclk = BASE_BAUD * 16;
> +       if (!port->uartclk)
> +               port->uartclk = BASE_BAUD * 16;
>         if (port->mapbase)
>                 port->membase = earlycon_map(port->mapbase, 64);
>
>
> --
> b4 0.11.0-dev-d93f8



-- 
Ricardo Ribalda

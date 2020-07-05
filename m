Return-Path: <SRS0=pW61=AQ=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B011C433DF
	for <linux-serial@archiver.kernel.org>; Sun,  5 Jul 2020 10:07:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4238620771
	for <linux-serial@archiver.kernel.org>; Sun,  5 Jul 2020 10:07:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ilGMCJ4O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726698AbgGEKHg (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Sun, 5 Jul 2020 06:07:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726572AbgGEKHf (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sun, 5 Jul 2020 06:07:35 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F478C061794;
        Sun,  5 Jul 2020 03:07:35 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id x8so13325047plm.10;
        Sun, 05 Jul 2020 03:07:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AjWtuhASvQz4/9O5AuUktdFCzgZ5baafsc2h9IOgUhU=;
        b=ilGMCJ4OEbjAqkUkfO9wJUDww3eA+plnp5o6CMwT+drE0vBsX0K9Rn99ZQ5Wa8CF3u
         KqTaIrzlq2UVsdZGLnC/Vx9eKAf9dGz7psBYrKBqYbUYXkfSho27rE+uxZ7LZhqVLDSK
         ljreP2q07rvuI7PKvBjCycsvkaigPbWA+mqHJnBBj1N5MpgkyXyto907qlJXNb9+IMJe
         XMelf0POfRSQBtF+Kwe3CtwqbAQMbUiXXbvXdxRum0XolDjjiyoRsm9BWbJ20YIzq0mB
         m635ccLpwxwoPggmetxG9mbZ3aRQB7qjKJBn/lbG75rBEUAzLaiBLPoInog7UT8D3oLG
         qOMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AjWtuhASvQz4/9O5AuUktdFCzgZ5baafsc2h9IOgUhU=;
        b=c0M9TAbG0SNMl/5eBuz71uZNDphgovTxRG5ln2cuy99bqyVO/R99rGqfgomCOwhyqf
         uHf4+L/aRexZBG9TPUH3yjBFaHfgg1rIFVfUCDOfVc9eHSt79PoXDyYTOSLGN9p462Ip
         0eSYJ4Jf8VCBKPlEHEaXAqA9i2guiip6ep80dCeQ/Cs3vEsrlVjXIOek9bv/dW+Eg1t/
         ZOd+h68LD7GmmWP+I8r1pkDhlHAs+L4Xy2L5vjYxI4n8UfyEtcSNtMEKIhKfM6dMBU+e
         GypahD4zbg9EKqu3+GwDvKO+PPfExVAZzvh82rjPnkhcfN/jY+u8Sc5a2W2CgbeCkO8J
         wmtw==
X-Gm-Message-State: AOAM533hv8dV2xDgJCUcJuqpP+MVUFUJLqbKtmPj5K1FUdnKHHMptpWL
        J/F3KCKV3I4aVk112mwbMcFbzhE0s8OD1VzjXOM=
X-Google-Smtp-Source: ABdhPJw6Cm73j7dskOrTyfxjjqhqU6eXkTo6ceG9dOgr6boF/oD6TZ8fP6Rg1h35WWDdOgnV20P7nST13efQg+gDqQg=
X-Received: by 2002:a17:90b:3547:: with SMTP id lt7mr20691981pjb.181.1593943654465;
 Sun, 05 Jul 2020 03:07:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200705092736.1030598-1-maz@kernel.org>
In-Reply-To: <20200705092736.1030598-1-maz@kernel.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 5 Jul 2020 13:07:18 +0300
Message-ID: <CAHp75VfFNO=oqHX9EeNdVgcQUfu7RBr6SDTWi3XF4gSQNjqzUw@mail.gmail.com>
Subject: Re: [PATCH] tty: serial: meson_uart: Init port lock early
To:     Marc Zyngier <maz@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kevin Hilman <khilman@baylibre.com>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        linux-amlogic@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel-team@android.com,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Sun, Jul 5, 2020 at 12:32 PM Marc Zyngier <maz@kernel.org> wrote:
>
> The meson UART driver triggers a lockdep splat at boot time, due
> to the new expectation that the driver has to initialize the
> per-port spinlock itself.
>
> It remains unclear why a double initialization of the port
> spinlock is a desirable outcome, but in the meantime let's
> fix the splat.
>

Thanks!

Can you test patch from [1] if it helps and doesn't break anything in your case?

[1]: https://lore.kernel.org/linux-serial/20200217114016.49856-1-andriy.shevchenko@linux.intel.com/T/#m9255e2a7474b160e66c7060fca5323ca3df49cfd

> Fixes: a3cb39d258ef ("serial: core: Allow detach and attach serial device for console")
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> ---
>  drivers/tty/serial/meson_uart.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/tty/serial/meson_uart.c b/drivers/tty/serial/meson_uart.c
> index d2c08b760f83..386e39c90628 100644
> --- a/drivers/tty/serial/meson_uart.c
> +++ b/drivers/tty/serial/meson_uart.c
> @@ -759,6 +759,9 @@ static int meson_uart_probe(struct platform_device *pdev)
>         if (ret)
>                 return ret;
>
> +       /* Init the spinlock early in case this is the console */
> +       spin_lock_init(&port->lock);
> +
>         port->iotype = UPIO_MEM;
>         port->mapbase = res_mem->start;
>         port->mapsize = resource_size(res_mem);
> --
> 2.26.2
>


-- 
With Best Regards,
Andy Shevchenko

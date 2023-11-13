Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 842D5C4332F
	for <linux-serial@archiver.kernel.org>; Mon, 13 Nov 2023 10:16:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229463AbjKMKQK convert rfc822-to-8bit (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 13 Nov 2023 05:16:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjKMKQK (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 13 Nov 2023 05:16:10 -0500
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83B1CD79;
        Mon, 13 Nov 2023 02:16:05 -0800 (PST)
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-5842a7fdc61so2194679eaf.3;
        Mon, 13 Nov 2023 02:16:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699870564; x=1700475364;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uTO0ERk3BWfb6UISnsbuegKh0j43MXQ3l4j0lmIgta4=;
        b=JfGLhsNo5m8suJvgK+8n0BsIsiyUaFUsLjcAunR0AVy8ay9gdDT7LgYtcoF7QqfGMy
         Ar4ua7pR+w2iY4XltNotEOevA2YbFKbsBqnRUx9p0zqZjqn/VGYgGV2Z9U2XEK9PREMY
         vBNjks/2D46148SiaSKzUvpE/X4EjSjg/6wIYhFRPPJO5ogQKVxL5AgLieQoZ8UKyEKE
         dbzEStmGLvayqFHnS5XJLOkRHnSdf0hj1DXW+AeYjnYNvSS+3Ugp/T0x+CHeWTtr3ueP
         +iF08RhBCnerq3ai4sUoMIjApXnx1cuxC6QpzGI6/t5Gy+C+MbdCZ/4pMdohaZ6vlM9M
         tsQQ==
X-Gm-Message-State: AOJu0Yyh1hkmB8rhSwWkYelg4+JPfSNIKg8FlDgWCvEdAXUD9r1oVVJ4
        BBlA2E9oEBHs6I7aajvRxCrIT5SpGZwLkQ==
X-Google-Smtp-Source: AGHT+IGy4cVdjJ2mQP6WMbuJtvBHqDH9VWqBbeWjRiz/nWrUeGAptgpvQBJQm8420lPJQtPC++1Wfg==
X-Received: by 2002:a4a:d291:0:b0:581:f2de:25f8 with SMTP id h17-20020a4ad291000000b00581f2de25f8mr5711593oos.0.1699870564572;
        Mon, 13 Nov 2023 02:16:04 -0800 (PST)
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com. [209.85.167.179])
        by smtp.gmail.com with ESMTPSA id v8-20020a4a8c48000000b00581df2cb1e6sm933209ooj.32.2023.11.13.02.16.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Nov 2023 02:16:04 -0800 (PST)
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3b2f507c03cso2428811b6e.2;
        Mon, 13 Nov 2023 02:16:04 -0800 (PST)
X-Received: by 2002:a0d:d74d:0:b0:5a7:d86c:988 with SMTP id
 z74-20020a0dd74d000000b005a7d86c0988mr6382133ywd.28.1699870543575; Mon, 13
 Nov 2023 02:15:43 -0800 (PST)
MIME-Version: 1.0
References: <20231110152927.70601-1-u.kleine-koenig@pengutronix.de> <20231110152927.70601-4-u.kleine-koenig@pengutronix.de>
In-Reply-To: <20231110152927.70601-4-u.kleine-koenig@pengutronix.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 13 Nov 2023 11:15:31 +0100
X-Gmail-Original-Message-ID: <CAMuHMdU8nCWzTuBeSTPkR=heWqdAYrhAJ9ZgydzWNRqkTuT+xg@mail.gmail.com>
Message-ID: <CAMuHMdU8nCWzTuBeSTPkR=heWqdAYrhAJ9ZgydzWNRqkTuT+xg@mail.gmail.com>
Subject: Re: [PATCH 03/52] serial: 8250: Convert to platform remove callback
 returning void
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@codeconstruct.com.au>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Al Cooper <alcooperx@gmail.com>,
        =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        John Ogness <john.ogness@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tony Lindgren <tony@atomide.com>,
        Petr Mladek <pmladek@suse.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Johan Hovold <johan@kernel.org>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Andi Shyti <andi.shyti@linux.intel.com>,
        Thomas Richard <thomas.richard@bootlin.com>,
        Rob Herring <robh@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        =?UTF-8?Q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        kernel@pengutronix.de, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org,
        linux-rpi-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-tegra@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, Nov 10, 2023 at 4:31 PM Uwe Kleine-König
<u.kleine-koenig@pengutronix.de> wrote:
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
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

>  drivers/tty/serial/8250/8250_dw.c           | 6 ++----
>  drivers/tty/serial/8250/8250_em.c           | 5 ++---

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

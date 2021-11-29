Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15931C433EF
	for <linux-serial@archiver.kernel.org>; Mon, 29 Nov 2021 22:23:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229544AbhK2W0Q (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 29 Nov 2021 17:26:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233524AbhK2WXr (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 29 Nov 2021 17:23:47 -0500
Received: from mail-ua1-x92c.google.com (mail-ua1-x92c.google.com [IPv6:2607:f8b0:4864:20::92c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6F42C08ED6D
        for <linux-serial@vger.kernel.org>; Mon, 29 Nov 2021 12:38:59 -0800 (PST)
Received: by mail-ua1-x92c.google.com with SMTP id r15so36820500uao.3
        for <linux-serial@vger.kernel.org>; Mon, 29 Nov 2021 12:38:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UONcs7N6LGxVu2k8VNIBFR8w78/QJ3sPH/s1Z5GJbro=;
        b=noH8p60w0Jb98Gun1YSBguriftRk73erhwNTOPAf0Xyfpd3cQ8YQLdk0dHdFCR1L/V
         VrbMrAhXcw1OzPppMd1vEqZMILJq4Be4I+3XY4YrVFi+ez8sbi2I10v75Hzf1oAKt7Md
         Q+cvz1xKXfTgGvcmKkzceKwtuG2XPov5wncs00SjT30lSAPi0nz1rgj5LYqDrXjXbwrd
         7qJ2K/OlJwBdQB+TZLO+Uy7e1hft0Au/MPm+8zOCJqUVXLzTHyR5Ted8dz9vzXFYRmAv
         pFLYaHJJ3SzU0UlR3r5WXbyN0td2n1zWE0TOOJKSdPvYoBjSfIBXLpFKtsOyF1bjh5D1
         IQuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UONcs7N6LGxVu2k8VNIBFR8w78/QJ3sPH/s1Z5GJbro=;
        b=JXL4lakSA4ur8N9vclZg6ST6OGPK9/EAYbG2DBp7QFcp/E7b7iJCscbDINvTqdV8Im
         JR08MXcg6u+RGQ4aipKWfK2i/oVAv4CwGTMMOwhl65ca1iqxhz0+XuXisfbNx9PzGUeq
         mCTlCE3BlOWK/RgMhN+DqJo0PtR57wKeq3oaZBhrz0oXe1C/vzfZg3saCDiQYMFuoy8w
         WihVQb7W5vwQZf8s9t61PdtdOUNMCZjOdShthlceTwtrvof5ew9V8PJwHBhiJZOMEO/3
         R201Ku5EuZhMyPLPuPyWxzukgUMyghPB0IWbGzJMH4xDi2aTq1vCzzb+h2IPzYsjHLpE
         3b7g==
X-Gm-Message-State: AOAM531hinoQBfAd5yBE88Jpofl8XYpw6kj7ZG204Xi/nxkCdtK3s/5r
        LpT/QAEYtDx9ZMQrFYdUEujOTjsMmtsz6UdcKFR+UQ==
X-Google-Smtp-Source: ABdhPJzhebEttD8OzDSAnlep6FeEbByTFuexl48l99GbNggwLSd6/VU+oEF2UMCz1+jFsh7LSdV7Dujt31QbGYN5BvA=
X-Received: by 2002:a67:be0f:: with SMTP id x15mr36219046vsq.86.1638218338933;
 Mon, 29 Nov 2021 12:38:58 -0800 (PST)
MIME-Version: 1.0
References: <20211127223253.19098-1-semen.protsenko@linaro.org>
 <20211127223253.19098-6-semen.protsenko@linaro.org> <9a51b37b-d2c4-fb73-bd3f-447c94a66c82@canonical.com>
 <CAPLW+4=Xp0m3ycm5c1WSJGtr6vRxx1fsW0MOo65fXMfaB1sR+w@mail.gmail.com>
In-Reply-To: <CAPLW+4=Xp0m3ycm5c1WSJGtr6vRxx1fsW0MOo65fXMfaB1sR+w@mail.gmail.com>
From:   Sam Protsenko <semen.protsenko@linaro.org>
Date:   Mon, 29 Nov 2021 22:38:47 +0200
Message-ID: <CAPLW+4n+y2cARyeV53hBfUdbyy5ZtCCisDQ20ANF7mM0uh_V4g@mail.gmail.com>
Subject: Re: [PATCH 5/8] tty: serial: samsung: Enable console as module
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jaewon Kim <jaewon02.kim@samsung.com>,
        Chanho Park <chanho61.park@samsung.com>,
        David Virag <virag.david003@gmail.com>,
        Youngmin Nam <youngmin.nam@samsung.com>,
        devicetree@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-i2c@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, 29 Nov 2021 at 22:18, Sam Protsenko <semen.protsenko@linaro.org> wrote:
>
> On Mon, 29 Nov 2021 at 10:52, Krzysztof Kozlowski
> <krzysztof.kozlowski@canonical.com> wrote:
> >
> > On 27/11/2021 23:32, Sam Protsenko wrote:
> > > Enable serial driver to be built as a module. To do so, init the console
> > > support on driver/module load instead of using console_initcall().
> > >
> > > This is needed for proper support of USIv2 driver (which can be built as
> > > a module, which in turn makes SERIAL_SAMSUNG be a module too). It also
> > > might be useful for Android GKI modularization efforts.
> > >
> > > Inspired by commit 87a0b9f98ac5 ("tty: serial: meson: enable console as
> > > module").
> > >
> > > Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
> > > ---
> > >  drivers/tty/serial/Kconfig       |  2 +-
> > >  drivers/tty/serial/samsung_tty.c | 21 +++++++++++++++++++--
> > >  2 files changed, 20 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
> > > index fc543ac97c13..0e5ccb25bdb1 100644
> > > --- a/drivers/tty/serial/Kconfig
> > > +++ b/drivers/tty/serial/Kconfig
> > > @@ -263,7 +263,7 @@ config SERIAL_SAMSUNG_UARTS
> > >
> > >  config SERIAL_SAMSUNG_CONSOLE
> > >       bool "Support for console on Samsung SoC serial port"
> > > -     depends on SERIAL_SAMSUNG=y
> > > +     depends on SERIAL_SAMSUNG
> > >       select SERIAL_CORE_CONSOLE
> > >       select SERIAL_EARLYCON
> > >       help
> > > diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
> > > index f986a9253dc8..92a63e9392ed 100644
> > > --- a/drivers/tty/serial/samsung_tty.c
> > > +++ b/drivers/tty/serial/samsung_tty.c
> > > @@ -1720,10 +1720,10 @@ static int __init s3c24xx_serial_console_init(void)
> > >       register_console(&s3c24xx_serial_console);
> > >       return 0;
> > >  }
> > > -console_initcall(s3c24xx_serial_console_init);
> > >
> > >  #define S3C24XX_SERIAL_CONSOLE &s3c24xx_serial_console
> > >  #else
> > > +static inline int s3c24xx_serial_console_init(void) { return 0; }
> > >  #define S3C24XX_SERIAL_CONSOLE NULL
> > >  #endif
> > >
> > > @@ -2898,7 +2898,24 @@ static struct platform_driver samsung_serial_driver = {
> > >       },
> > >  };
> > >
> > > -module_platform_driver(samsung_serial_driver);
> > > +static int __init samsung_serial_init(void)
> > > +{
> > > +     int ret;
> > > +
> > > +     ret = s3c24xx_serial_console_init();
> > > +     if (ret)
> > > +             return ret;
> >
> > This will trigger warns on module re-loading, won't it? Either suppress
> > unbind or cleanup in module exit.
> >
>
> I guess that's already taken care of in  samsung_serial_remove(): it's
> doing uart_remove_one_port(), which in turn does unregister_console().
> So I don't think anything extra should be done on module exit. Or I'm
> missing something?
>
> That case (unload/load) actually doesn't work well in my case: serial
> console doesn't work after doing "modprobe -r samsung_tty; modprobe
> samsung_tty" (but it works fine e.g. in case of i2c_exynos5 driver).
> Not sure what is wrong, but I can see that my board keeps running
> (heartbeat LED is still blinking). Not even sure if that use case
> (unload/load) was ever functional before.
>
> Anyway, please let me know if you think something should be done about
> this particular patch. Right now I don't see anything missing.
>

...But I'll actually add proper error path handling in
samsung_serial_init(), i.e. unregister console if
platform_driver_register() fails. And I'll add the same console
unregister in samsung_serial_exit(), just in case.

> > > +
> > > +     return platform_driver_register(&samsung_serial_driver);
> > > +}
> > > +
> > > +static void __exit samsung_serial_exit(void)
> > > +{
> > > +     platform_driver_unregister(&samsung_serial_driver);
> > > +}
> > > +
> > > +module_init(samsung_serial_init);
> > > +module_exit(samsung_serial_exit);
> > >
> > >  #ifdef CONFIG_SERIAL_SAMSUNG_CONSOLE
> > >  /*
> > >
> >
> >
> > Best regards,
> > Krzysztof

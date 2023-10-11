Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92ECECDB479
	for <linux-serial@archiver.kernel.org>; Wed, 11 Oct 2023 18:38:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230201AbjJKSiE (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 11 Oct 2023 14:38:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234840AbjJKSD6 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 11 Oct 2023 14:03:58 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 884A99D
        for <linux-serial@vger.kernel.org>; Wed, 11 Oct 2023 11:03:56 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id af79cd13be357-7740aa4b545so6537385a.3
        for <linux-serial@vger.kernel.org>; Wed, 11 Oct 2023 11:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697047435; x=1697652235; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2+lwLhk0eIlh4K7WyRSQjzGji/fhcQWQbO8LhvSYCpU=;
        b=owlY9VP3yJws5dPieY1MCmI25kzOUzN6RWEIJrq+XDSu08zFW6cIo4FXj4usxImWrN
         VhVny9whMaq9GrmqVhSSOVlu/wf7jwD2i12tsHFYj1j3P5mA6CuWmH97mhIrKsDtl2tN
         JbGH0Lh+QT3NMccLO0bX8qAtpejq2XJ+2CEJ948JV0K90gkAvZUquBWRefnlOo06zgMD
         lWSlaTAJMLew025SC0vxjXXADNReflUPGIIfg5q34PAvFzznWkFQ2juhGgueLgfEHEo8
         OU4Zb4EWOgXYW76XVvrytXFve49emW8ZW4YWq1DMjG7VfTwRdyCTyQaJ/KS44mA6tEWm
         BYHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697047435; x=1697652235;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2+lwLhk0eIlh4K7WyRSQjzGji/fhcQWQbO8LhvSYCpU=;
        b=veKfd3uM/LABfEMjLkUNp0SwirJmrxSjVSkqzHzg53PgQt9z4eadJeqaA3LaBzQ7fC
         91DZMjNUFSMN4Kkxt6XgZOVcf031nOfw202S0quxxRgm/glmdaqNZbp+6R3Aq8+9pXUE
         E9AUPlZVn9tkG9vTx+jcRVAsr25YLlTUEHovZJ4PY94tX4p7DA9uccayobmyeHHL7dtC
         fWIFVr+XF7SVAHgbBhD6oVe5KkMMEIANYBDbBJjWKiiDXczJZh3VJpW1p8ignan16JbR
         FqxVeYthOyOJFI8hW/cD/r6dhTwE5YYYVq2lYFtV2FRAZoYPuq/ZgwKRKf3K661Xzwpe
         YLVw==
X-Gm-Message-State: AOJu0YyaxJawxThn3sAsW/grk7mlYekadRhjbLUQm4/jQEltkGrZ/0yz
        Y1z5z2yI+4rA895XE0BiO95GESKm133Y1WTzUuT0Vg==
X-Google-Smtp-Source: AGHT+IGt+0fVENikMfRGv423wq596E+D6hAqM0KbzwaZfRzrT8CBCTVaa4eh0NSbF1Brpy+RH3NFuekBbLkzj8qn004=
X-Received: by 2002:a0c:b213:0:b0:64f:3de6:d502 with SMTP id
 x19-20020a0cb213000000b0064f3de6d502mr21163979qvd.5.1697047435542; Wed, 11
 Oct 2023 11:03:55 -0700 (PDT)
MIME-Version: 1.0
References: <20231010224928.2296997-1-peter.griffin@linaro.org>
 <20231010224928.2296997-17-peter.griffin@linaro.org> <2023101109-crispy-escapable-0801@gregkh>
In-Reply-To: <2023101109-crispy-escapable-0801@gregkh>
From:   Peter Griffin <peter.griffin@linaro.org>
Date:   Wed, 11 Oct 2023 19:03:44 +0100
Message-ID: <CADrjBPouDPfcj9eCN0BN0Lfd1sOb=Q3jmkeD1aO2on5VHmROJg@mail.gmail.com>
Subject: Re: [PATCH v2 16/20] tty: serial: samsung: Add gs101 compatible and
 SoC data
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        mturquette@baylibre.com, conor+dt@kernel.org, sboyd@kernel.org,
        tomasz.figa@gmail.com, s.nawrocki@samsung.com,
        linus.walleij@linaro.org, wim@linux-watchdog.org,
        linux@roeck-us.net, catalin.marinas@arm.com, will@kernel.org,
        arnd@arndb.de, olof@lixom.net, cw00.choi@samsung.com,
        tudor.ambarus@linaro.org, andre.draszik@linaro.org,
        semen.protsenko@linaro.org, saravanak@google.com,
        willmcvicker@google.com, soc@kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-watchdog@vger.kernel.org,
        kernel-team@android.com, linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi Greg,

Thanks for the review.

On Wed, 11 Oct 2023 at 08:47, Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Tue, Oct 10, 2023 at 11:49:24PM +0100, Peter Griffin wrote:
> > Add serial driver data for Google Tensor gs101 SoC.
> >
> > Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
> > ---
> >  drivers/tty/serial/samsung_tty.c | 12 ++++++++++++
> >  1 file changed, 12 insertions(+)
> >
> > diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
> > index 07fb8a9dac63..79a1a184d5c1 100644
> > --- a/drivers/tty/serial/samsung_tty.c
> > +++ b/drivers/tty/serial/samsung_tty.c
> > @@ -2597,14 +2597,21 @@ static const struct s3c24xx_serial_drv_data exynos850_serial_drv_data = {
> >       .fifosize = { 256, 64, 64, 64 },
> >  };
> >
> > +static const struct s3c24xx_serial_drv_data gs101_serial_drv_data = {
> > +     EXYNOS_COMMON_SERIAL_DRV_DATA(),
> > +     .fifosize = { 256, 64, 64, 64 },
> > +};
>
> Why are you duplicating a structure that is already in the same file?
> What is the benifit here?

There is a mistake here, the struct shouldn't be the same as e850 it
should look like this

static const struct s3c24xx_serial_drv_data gs101_serial_drv_data = {
     EXYNOS_COMMON_SERIAL_DRV_DATA(),
     /* rely on samsung,uart-fifosize DT property for fifosize */
     .fifosize = { 0 },
};

This then allows the fifosize to be taken from the samsung,uart-fifosize
DT property for each of the 19 UARTs on this SoC.

>
> >  #define EXYNOS4210_SERIAL_DRV_DATA (&exynos4210_serial_drv_data)
> >  #define EXYNOS5433_SERIAL_DRV_DATA (&exynos5433_serial_drv_data)
> >  #define EXYNOS850_SERIAL_DRV_DATA (&exynos850_serial_drv_data)
> > +#define GS101_SERIAL_DRV_DATA (&gs101_serial_drv_data)
>
> What is "GS101"?

gs101 is the name of the SoC in Pixel 6, 6 pro, 6a phones. I've put
some more info
about the various names of the SoC in the bindings documentation. See
https://lore.kernel.org/linux-arm-kernel/20231010224928.2296997-9-peter.griffin@linaro.org/T/#mb45492e58de0bef566df8cdf6191ab8f96f0cf99

>
> >  #else
> >  #define EXYNOS4210_SERIAL_DRV_DATA NULL
> >  #define EXYNOS5433_SERIAL_DRV_DATA NULL
> >  #define EXYNOS850_SERIAL_DRV_DATA NULL
> > +#define GS101_SERIAL_DRV_DATA NULL
> >  #endif
> >
> >  #ifdef CONFIG_ARCH_APPLE
> > @@ -2688,6 +2695,9 @@ static const struct platform_device_id s3c24xx_serial_driver_ids[] = {
> >       }, {
> >               .name           = "artpec8-uart",
> >               .driver_data    = (kernel_ulong_t)ARTPEC8_SERIAL_DRV_DATA,
> > +     }, {
> > +             .name           = "gs101-uart",
> > +             .driver_data    = (kernel_ulong_t)GS101_SERIAL_DRV_DATA,
> >       },
> >       { },
> >  };
> > @@ -2709,6 +2719,8 @@ static const struct of_device_id s3c24xx_uart_dt_match[] = {
> >               .data = EXYNOS850_SERIAL_DRV_DATA },
> >       { .compatible = "axis,artpec8-uart",
> >               .data = ARTPEC8_SERIAL_DRV_DATA },
> > +     { .compatible = "google,gs101-uart",
> > +             .data =  GS101_SERIAL_DRV_DATA },
>
> Why aren't you just listing this hardware as the same one above?  There
> doesn't need to be a new entry if you just fix up the DT for the board
> to declare it as the proper type of device.  No need to keep adding new
> entries that do the exact same thing, we don't normally like that at all
> for other bus types, why is DT different?
>

I believe Krzysztof already answered this from a dt maintainer point of view.

regards,

Peter.

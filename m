Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA402C433FE
	for <linux-serial@archiver.kernel.org>; Mon, 29 Nov 2021 00:04:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359666AbhK2AIB (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Sun, 28 Nov 2021 19:08:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359723AbhK2AGB (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sun, 28 Nov 2021 19:06:01 -0500
Received: from mail-ua1-x92c.google.com (mail-ua1-x92c.google.com [IPv6:2607:f8b0:4864:20::92c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55FC5C0613E0
        for <linux-serial@vger.kernel.org>; Sun, 28 Nov 2021 16:02:12 -0800 (PST)
Received: by mail-ua1-x92c.google.com with SMTP id ay21so30323172uab.12
        for <linux-serial@vger.kernel.org>; Sun, 28 Nov 2021 16:02:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iX/liG3cogM7y6xTjLVTRJ7br8H2lhulk0j4IZZdOaQ=;
        b=uGe8zOrAcFrS6z7QKGo9xMOZg9CRr8M4izeUnePF88hPW3IOU4O47zaGY3ehLTJ7ad
         jjp/QfHp82CjKI63WwBE9dITiRQtKezFFSOrSjz5ClIRSE3QGYDg+XCo+0Ms4r+/kbSu
         glgbX/zxa/WBlsB16AuTRQs2FQqadz+FldsS42Q4F/qDUyBfI5bzByZwN+90bzGM+ITS
         cpdZU3TcFgVt6NApgJa2NVB6pVumAWqrHlkE/4ehl1V3jjQAGwTg+/O5YPrNoQZvB9Z4
         fPLH38w79wmmzGLT4vmMkeZLhvPNIc86Xdyp5fIhurOrDWbBRwgR7fHa0iRIDL1OJWaD
         lJOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iX/liG3cogM7y6xTjLVTRJ7br8H2lhulk0j4IZZdOaQ=;
        b=1cqEMjCjhFartKoVeXZuCyY7+RH3Q5Y/ISeWEjX2HwqnuHWGEk78kLzpI+q/ratAuF
         sNc44D9l1hePietcu5XmJZ9XHgP+5q92pIqyctzhW+WYr4k96C+BaL7kvhMR18mNIcbU
         eTzFdFh01OGYtqERVIY84Ftpt+omIlFtzC4Ehu1gUY3V7jWWXj/ntaKG6Y7YhYCVcgvF
         kwBhSTx7lZTEIWFvN5SuUU67R6c401GKSnr0F9x9jwTBUko52FdY04ehHA9Iq79E6HJD
         QqbrF7QtGP2LULNh9mkNhoAAOHSNw2JrE0IIIyrjQKOaOjeoiXR9UAzRtoY5TiRN5K3r
         MF0A==
X-Gm-Message-State: AOAM533kJ7dr+xSFv4xd+A1XZtE+0yoY1AqDk4qf9f4zC68QF8RSdfIT
        D7uuRaqhkZLvvM1s3iU7lBCpDvYLcnIdzv2HY4DsqA==
X-Google-Smtp-Source: ABdhPJyCQS9jji7xzd9RwMMKE908k3zhD5Kc+fdoA3RuOXkWpCn93jL0JO8s9A/cdRM25JVC4dSxIq/pH3Ao+owxJYo=
X-Received: by 2002:a67:7247:: with SMTP id n68mr27587295vsc.6.1638144131510;
 Sun, 28 Nov 2021 16:02:11 -0800 (PST)
MIME-Version: 1.0
References: <20211127223253.19098-1-semen.protsenko@linaro.org> <20211127223253.19098-8-semen.protsenko@linaro.org>
In-Reply-To: <20211127223253.19098-8-semen.protsenko@linaro.org>
From:   Sam Protsenko <semen.protsenko@linaro.org>
Date:   Mon, 29 Nov 2021 02:02:00 +0200
Message-ID: <CAPLW+4nf7Y6HQW-XmgB93Lyie=FwZMAG2rA+S5=KcKpEn_4mjA@mail.gmail.com>
Subject: Re: [PATCH 7/8] i2c: Make I2C_EXYNOS5=y impossible when EXYNOS_USI_V2=m
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jaewon Kim <jaewon02.kim@samsung.com>,
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

On Sun, 28 Nov 2021 at 00:33, Sam Protsenko <semen.protsenko@linaro.org> wrote:
>
> When HSI2C is encapsulated in USIv2 block (e.g. in Exynos850), USIv2
> driver must be loaded first, as it's preparing USI hardware for
> particular protocol use. Make it impossible for i2c-exynos5 driver to be
> built-in when USIv2 driver is built as a module, to prevent incorrect
> booting order for those drivers.
>
> Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
> ---

This patch is not needed, please ignore it.

>  drivers/i2c/busses/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
> index df89cb809330..e815a9dffb2c 100644
> --- a/drivers/i2c/busses/Kconfig
> +++ b/drivers/i2c/busses/Kconfig
> @@ -613,6 +613,7 @@ config I2C_EXYNOS5
>         tristate "Exynos high-speed I2C driver"
>         depends on OF
>         depends on ARCH_EXYNOS || COMPILE_TEST
> +       depends on EXYNOS_USI_V2 || !EXYNOS_USI_V2
>         default y if ARCH_EXYNOS
>         help
>           High-speed I2C controller on Samsung Exynos5 and newer Samsung SoCs:
> --
> 2.30.2
>

Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB746CD6E6D
	for <linux-serial@archiver.kernel.org>; Wed, 11 Oct 2023 13:27:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346890AbjJKN1a (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 11 Oct 2023 09:27:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346857AbjJKN1a (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 11 Oct 2023 09:27:30 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E60FB0
        for <linux-serial@vger.kernel.org>; Wed, 11 Oct 2023 06:27:24 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id 5614622812f47-3af6cd01323so4755921b6e.3
        for <linux-serial@vger.kernel.org>; Wed, 11 Oct 2023 06:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697030843; x=1697635643; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=J5R4Azbu7hiSMoO3CcwbpnXuSGW+r6gu8ebn/VNh4qs=;
        b=y4TvGnvGDb2GL5YwAXtIqETadEM0T0ZtQZSB3Ie9V6FTqBmQsAD+82RzKTzTG2WTDI
         i1HBjX+jYO5BsAhAGn6abbe94AF46cmmS0TUcuJcXFTeGT1XxW02F46JAIW8X7TAmvEN
         aP99x5G8LoOEGgI1xgP3IyPHAdnrpTjIXTO/kVPVuA0KemcHw/U4eoGKDmk6X1sIptoK
         VtXa85sFX8QMweUOudy3vErWex319Ta5Ozk/B34fS/GQE1bMZBBvFHTYRnKFuoHiU7Wu
         o18BZr3aWki0oadMV1pGx80W6z0AQh968wAZpneJZ6Qen09B7fXY+rL16gCRmnIySdQj
         9Ugw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697030843; x=1697635643;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J5R4Azbu7hiSMoO3CcwbpnXuSGW+r6gu8ebn/VNh4qs=;
        b=aGaB47uw1fQU5FebvEGqbRCyYDFuML3NEJXVuPIgvJqsn2W4dYpmqAqN98vGEwP2YD
         Vm3jLZyl6V+rxCAFy8eR2pWFAO3oAWNKMb5jX6ZgpvGVEAhhKImCkK35VOnT7UeFX+iK
         kAEGRsjXpUN/UG57K/C4YUh3tOnPozpETu+Np5FOW1dZmE2AtF3eMvGQT14XV3Ta8DCo
         JwsVhzvHSH+DSDuLWcKCnEOSkI/zZwZpO+YvB8yX0iIBtnG1E0dIDAk+jSWrXYn/Uo1T
         4C+IEmLLVh8d0G8lIzOcyl/6v8qGhEl3oUhEuoXcEXPPiNZ0qs+1YvXTDC9qZIQf1diq
         s1Fw==
X-Gm-Message-State: AOJu0YwNH86kT+XJUEG8ejckwNHz2UwwYj+CJkKPu+4S5lTEvW9L3+bV
        8NGYZ14K7WhNR8JE+rdQDNfYdkI8c8mUQ5JSbiAOMQ==
X-Google-Smtp-Source: AGHT+IEl4MC4gBK7y4h1vXjlEl4INwrOMHMEVICuGPvkoTpxt+/f+cbntbu2E912Znr1yoiGGG01H3kikZpiQvQrQG0=
X-Received: by 2002:aca:1719:0:b0:3a8:432a:ea13 with SMTP id
 j25-20020aca1719000000b003a8432aea13mr21803799oii.46.1697030843628; Wed, 11
 Oct 2023 06:27:23 -0700 (PDT)
MIME-Version: 1.0
References: <20231010224928.2296997-1-peter.griffin@linaro.org>
 <20231010224928.2296997-9-peter.griffin@linaro.org> <1b7dcc34-1c9c-44cb-ae14-f63aca2317ea@linaro.org>
In-Reply-To: <1b7dcc34-1c9c-44cb-ae14-f63aca2317ea@linaro.org>
From:   Peter Griffin <peter.griffin@linaro.org>
Date:   Wed, 11 Oct 2023 14:27:11 +0100
Message-ID: <CADrjBPqz=7L-cP5-muJbFWZ0DTH4LP-gqCxXRDGKebxpG1FYvQ@mail.gmail.com>
Subject: Re: [PATCH v2 08/20] dt-bindings: serial: samsung: Add
 google-gs101-uart compatible
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
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

Hi Krzysztof,

Thanks for your review.

On Wed, 11 Oct 2023 at 13:09, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 11/10/2023 00:49, Peter Griffin wrote:
> > Add dedicated google-gs101-uart compatible to the dt-schema for
> > representing uart of the Google Tensor gs101 SoC.
> >
> > Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
> > ---
> >  Documentation/devicetree/bindings/serial/samsung_uart.yaml | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/serial/samsung_uart.yaml b/Documentation/devicetree/bindings/serial/samsung_uart.yaml
> > index 8bd88d5cbb11..72471ebe5734 100644
> > --- a/Documentation/devicetree/bindings/serial/samsung_uart.yaml
> > +++ b/Documentation/devicetree/bindings/serial/samsung_uart.yaml
> > @@ -19,11 +19,13 @@ properties:
> >    compatible:
> >      oneOf:
> >        - items:
> > +          - const: google,gs101-uart
>
> You just broke existing users.
>
> It does not look like you tested the DTS against bindings. Please run
> `make dtbs_check W=1` (see
> Documentation/devicetree/bindings/writing-schema.rst or
> https://www.linaro.org/blog/tips-and-tricks-for-validating-devicetree-sources-with-the-devicetree-schema/
> for instructions).
>

Will fix in v3

fyi I've been running with

make -j$js ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu-
dt_binding_check DT_SCHEMA_FILES=google
make -j$js ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu-
dt_binding_check DT_SCHEMA_FILES=samsung
make -j$js ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu-  CHECK_DTBS=y
W=1 google/gs101-oriole.dtb

But clearly that wasn't enough to catch this.  `make dtbs_check W=1`
takes a long time
and gives so much output. I suppose adding a few of the other exynos
based boards should
still be fairly quick and hopefully catch things like this. For example adding

make -j$js ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- CHECK_DTBS=y
W=1 exynos/exynos850-e850-96.dtb
make -j$js ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- CHECK_DTBS=y
W=1 exynos/exynos5433-tm2.dtb
make -j$js ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- CHECK_DTBS=y
W=1 exynos/exynosautov9-sadk.dtb

regards,

Peter.

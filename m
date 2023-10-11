Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74233CD6E55
	for <linux-serial@archiver.kernel.org>; Wed, 11 Oct 2023 09:22:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230496AbjJKJWe (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 11 Oct 2023 05:22:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230351AbjJKJWd (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 11 Oct 2023 05:22:33 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 519379D
        for <linux-serial@vger.kernel.org>; Wed, 11 Oct 2023 02:22:31 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id 6a1803df08f44-65af7d102b3so42538446d6.1
        for <linux-serial@vger.kernel.org>; Wed, 11 Oct 2023 02:22:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697016150; x=1697620950; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NiamZOqOZZtzzPmQsOXA8/LTPZNpfaNzuK4lw0f8SzI=;
        b=gxy18m7Av/Q8aEU/b2eCmmflWWfvgMf3WN/2kq2fTaslkb4BHq0OAyqAu+q0uHbChH
         F1V3lv/A2vl6cmffGoxr35ZB1zCHormL1/vVwNsvSK70ferS8CE/1JzFO9zkOdsUcBtr
         VsclXiaRdqtkPCZA7KKuktYfW/9PD/56l/hXVPS8OppKAuc38BjdqQkdgMmnuGQJ1/13
         2bdM1Qzgr5yDv7sqUmLlhreYvci42QUm1bgk9lVsVTAogcXJd0hMYZIbndqds5FsAol3
         RxYWtvlqKIp+a3QYySGm+f9047QShXb/lzQoRwZJIuIDL6IHRLhuqv+tPBL1aEmf8VFK
         Q2Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697016150; x=1697620950;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NiamZOqOZZtzzPmQsOXA8/LTPZNpfaNzuK4lw0f8SzI=;
        b=pXHYV447FAr8IqjKX5TUi1lGKxSAYF2NXEAw+tC3ztG6RyrBYgFQad5KzrHYvJqGQV
         Dg1/5C6030GZlL69610rcHx4zo7CDa95l1+lEXtM6xq7UaDllmPZsMEXTvca/0Fm94ib
         tpnQZ9h4PBQOkZSvc9YZpN5zCmtrsr+QJd9mFf8ORxv0Ex6Rh71HXZsYcVOB5TxF4Hof
         G4nerCGDK1tiQG3NSLeXYF1UexaTgn2ejpAM9r+BX9Wh2Z1+rAg3vPCJMfLBDAGtryiK
         LdXzxI3aGkeCMwB4LJXweaPDYFCYM2/5oKrhUACev5DxVAbqetMMCEYjJHTmrD35W9NV
         cNGQ==
X-Gm-Message-State: AOJu0YxjljTCnotZ17xLDXOMW2fIxDTnd+BO8uUBG/WnR4swiK9tjpp+
        U0qfL3fepRgyTgRLs6kM9huy6C74K7dptcQjlhWS/Q==
X-Google-Smtp-Source: AGHT+IFerUNHewgiE5tLLCx5HV3nwVhXkhxt2EIfdccX23DiuelsSBZdOsEH+KJvuaEUMPXd2xPPokchSF+FbYADBnI=
X-Received: by 2002:a0c:e30d:0:b0:66d:343:3512 with SMTP id
 s13-20020a0ce30d000000b0066d03433512mr1954964qvl.63.1697016150324; Wed, 11
 Oct 2023 02:22:30 -0700 (PDT)
MIME-Version: 1.0
References: <20231010224928.2296997-1-peter.griffin@linaro.org>
 <20231010224928.2296997-9-peter.griffin@linaro.org> <2023101111-banknote-satin-1f77@gregkh>
In-Reply-To: <2023101111-banknote-satin-1f77@gregkh>
From:   Peter Griffin <peter.griffin@linaro.org>
Date:   Wed, 11 Oct 2023 10:22:19 +0100
Message-ID: <CADrjBPqGkAh9YauwDTTrjBqx1fYmXEE4FwqDoPEy1+=Stf24QA@mail.gmail.com>
Subject: Re: [PATCH v2 08/20] dt-bindings: serial: samsung: Add
 google-gs101-uart compatible
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

Thanks for your review feedback!

On Wed, 11 Oct 2023 at 08:48, Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Tue, Oct 10, 2023 at 11:49:16PM +0100, Peter Griffin wrote:
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
> >            - const: samsung,exynosautov9-uart
> >            - const: samsung,exynos850-uart
> >        - enum:
> >            - apple,s5l-uart
> >            - axis,artpec8-uart
> > +          - google,gs101-uart
>
> These shouldn't be needed, just declare the device as the same as what
> the chip really is (i.e. a samsung uart), that way no .yaml or kernel
> driver changes are needed at all.

What you describe is actually how I had it in the v1 submission, which is also
similar to what exynosautov9.dtsi is doing by re-using the
"samsung,exynos850-uart" compatible, and associated data in the driver.

However the review feedback in v1 from Krzysztof and Tudor was to add a
dedicated compatible for it. I guess I could have re-used the existing
EXYNOS850_SERIAL_DRV_DATA structure though rather than duplicating
that as well.

I'll let Krzysztof comment on why a dedicated compatible is required.

regards,

Peter

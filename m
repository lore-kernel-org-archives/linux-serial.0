Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0D5ECDB47E
	for <linux-serial@archiver.kernel.org>; Thu, 12 Oct 2023 08:56:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235318AbjJLI4f (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 12 Oct 2023 04:56:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232023AbjJLI4d (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 12 Oct 2023 04:56:33 -0400
Received: from mail-ua1-x933.google.com (mail-ua1-x933.google.com [IPv6:2607:f8b0:4864:20::933])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 807C091
        for <linux-serial@vger.kernel.org>; Thu, 12 Oct 2023 01:56:31 -0700 (PDT)
Received: by mail-ua1-x933.google.com with SMTP id a1e0cc1a2514c-7b102a6565eso342470241.0
        for <linux-serial@vger.kernel.org>; Thu, 12 Oct 2023 01:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697100990; x=1697705790; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pPBtRkAyR8/yvLpXM2v/s42WseLth6/jHTmdZIsTmP0=;
        b=h+nB6pHrr77EtQ4S5o4MRd7OTpOniGIk1qmH0SD7P1yihaFadtNX08ZAa3UC4n+z+w
         egb3mxjqXvdZVieow3GbzQ0T8dPal4vUmMeILL1RDrVf8ni43FoTUwCHvr2Z6uENnib9
         zv+O0fuspWiqBIEcJF/7nyw48/R1tj+B+ENxZhdQpyX2CxWToMaDGNAG12M9pdKErOci
         1Ke1h3Uj0y/TuNBElQ/h3w66J8/o2p70L8KrTkEyNhYJP6G8OuTzeMCXhxulXgOkfSrx
         D2jXyaoFNlq3EoYUKZmP2v+J12ptE0XY3qKRcpZu504cKvXK9yAXdUu71AOoWYIfBYkS
         sfHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697100990; x=1697705790;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pPBtRkAyR8/yvLpXM2v/s42WseLth6/jHTmdZIsTmP0=;
        b=F1/iXIORN9vul1r+PkTok0lU+xEpSdpHVuotula+aSeSO+ZgWaKCu/mjpp80JhSVJ8
         EegB2xvfy87CikCFxrcWiTxdEMfLouihYBxO06HT0jvS+RH8cEGBzjyznJ6gRgsJ0VsK
         TGA4vEJ6cBsLuv852uhtaU7Vw7DRbEn95l5gMUkWVFtgFDqWdTGGJaOQbWMChcxOGhqw
         TbY71TvVfAr28rEHI/Bj03nLAigz3Nu6PrAqDQAZwyR0K6t+HZRDHTv1wm8OvRRV/v/O
         bDfn4HIjfQO0gp3uUoXFGIfgr5wYqx5PsjE8l0Dx+nCyuYBcYUMg6kGDwA07YeBoWISV
         A5ig==
X-Gm-Message-State: AOJu0YxHFjKi5OqQ6wF/PyjCoCUmj6rp5DzLBQw8xaCQmcjcYL40BdiJ
        8889GDZsTrztJayWEm16PrUpo4FaC1fmO0ac//udaA==
X-Google-Smtp-Source: AGHT+IFo3Lm+2RcnGTHf/V2J1XBT43I24bimP6qoGhCOeQNixS13RWY5pVJxbWa7Xp+lhHh0Is6YyxIfDwTn7aNz6FQ=
X-Received: by 2002:a67:e2cb:0:b0:452:c3a4:1f8c with SMTP id
 i11-20020a67e2cb000000b00452c3a41f8cmr18858896vsm.2.1697100990608; Thu, 12
 Oct 2023 01:56:30 -0700 (PDT)
MIME-Version: 1.0
References: <20231011184823.443959-1-peter.griffin@linaro.org>
 <20231011184823.443959-3-peter.griffin@linaro.org> <ZScYOUi7qhvGmMIF@google.com>
 <e4523fc3-e1dd-4791-b950-98dfc6dce1f5@linaro.org>
In-Reply-To: <e4523fc3-e1dd-4791-b950-98dfc6dce1f5@linaro.org>
From:   Peter Griffin <peter.griffin@linaro.org>
Date:   Thu, 12 Oct 2023 09:56:19 +0100
Message-ID: <CADrjBPpntJMsxb6oGQ7zuX3f0dgE3oYFepL4OdxamBz=_or7kw@mail.gmail.com>
Subject: Re: [PATCH v3 02/20] dt-bindings: clock: Add Google gs101 clock
 management unit bindings
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     William McVicker <willmcvicker@google.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, mturquette@baylibre.com,
        conor+dt@kernel.org, sboyd@kernel.org, tomasz.figa@gmail.com,
        s.nawrocki@samsung.com, linus.walleij@linaro.org,
        wim@linux-watchdog.org, linux@roeck-us.net,
        catalin.marinas@arm.com, will@kernel.org, arnd@arndb.de,
        olof@lixom.net, gregkh@linuxfoundation.org, cw00.choi@samsung.com,
        tudor.ambarus@linaro.org, andre.draszik@linaro.org,
        semen.protsenko@linaro.org, saravanak@google.com, soc@kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-watchdog@vger.kernel.org,
        kernel-team@android.com, linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi Krzysztof,

On Thu, 12 Oct 2023 at 07:07, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 11/10/2023 23:48, William McVicker wrote:
> > On 10/11/2023, Peter Griffin wrote:
> >> Provide dt-schema documentation for Google gs101 SoC clock controller.
> >> Currently this adds support for cmu_top, cmu_misc and cmu_apm.
> >>
> >> Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
> >
> > Tested-by: Will McVicker <willmcvicker@google.com>
>
> And how do you perform testing of a binding?

I guess if William is using my script to build and flash the kernel it actually
runs the DTC checks as part of the build process.

See https://git.codelinaro.org/linaro/googlelt/pixelscripts/-/blob/clo/main/buildp21upstream.sh#L44

regards,

Peter.

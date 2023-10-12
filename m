Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17CB9CDB484
	for <linux-serial@archiver.kernel.org>; Thu, 12 Oct 2023 10:45:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235683AbjJLKpv (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 12 Oct 2023 06:45:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235672AbjJLKpv (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 12 Oct 2023 06:45:51 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F74DB8
        for <linux-serial@vger.kernel.org>; Thu, 12 Oct 2023 03:45:47 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-5a7a7e9357eso10067197b3.0
        for <linux-serial@vger.kernel.org>; Thu, 12 Oct 2023 03:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697107546; x=1697712346; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1Y1HcKX9gLg/2u91PTGxysXLbI09E4OA7x2vijjT4oo=;
        b=MkBV1PGU6ITEclP07GUvtvRscL427hCkMvhgCt/0j+IEpjJ8okKZ9Z0Psd4m0/7UMK
         VnBPmJwdZfONRlhmwsj5EsKqvVkWk1nTX2l1cQ1lzrpovlMRuQnDxyLsZYKty7fRlfqF
         ICXH1QklmNoCj4ebcFO4ja2U4vBPcgGlql2aBb/tO0vx5JFXfDspcKGb33Hs8NMEj4hr
         nTF0jRiSAmfBzHo1zTAXU8Iu9W3+eDekcj6r2quOWkFebN051DwbYtoODU+LdoISxwl0
         ZDt1WBgAhSch0/UJgFXGAws2k4Dbzs3JRwodxskWcEpkqJ82V/nLY3PyI9t3aYCnwdfY
         49Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697107546; x=1697712346;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1Y1HcKX9gLg/2u91PTGxysXLbI09E4OA7x2vijjT4oo=;
        b=UQ2ugFw6o5qnka/2ktw27JchVJAtPm7DnMA3P1Cc1649iD4mWAbfmg9ZCVgmYHp1LU
         8uwV99iqvIdisXl72a+kVcDQBNikaomlj+LGoBqbJe2r1ZrJvwcZinlDCpnhn1dnbola
         VxjfOH5kIixJWK+61GKeEuJ9kgA+wILjJJlzU3ka6UcBhtSWrqDZalt1B0hELqeE0fWC
         7YJqo4CyRw/Ro+NZosZ3cqjOLzsW+DqqZnQU1M6b7RxbtO4GdQqNcrKIZ4c9XCCJPsuJ
         omRI/zpRciE2Bea9g+3kAy1/nYZwRagW7IlIQsDtmVp9Kf5WHyOCZe9jzWs29hXomPFL
         sGQQ==
X-Gm-Message-State: AOJu0Yw/HZHgm/zjybNSYXv+2yntTPMYOe+ILTO53/UJtc28OHiQzZkV
        uJLsuY9kE/FLkdIiG5eIIiSQFKAHAqLDFnV1uYzgfQ==
X-Google-Smtp-Source: AGHT+IGB+FxE7ccc2MEU8WMKyKb6JfbaLjOX2/doWAHH3NmtLFyPGOAqUKNJex39lRrnodJof8jLL2wunY4kkN6We6s=
X-Received: by 2002:a0d:ee01:0:b0:59b:c6a4:15c7 with SMTP id
 x1-20020a0dee01000000b0059bc6a415c7mr21411976ywe.46.1697107546553; Thu, 12
 Oct 2023 03:45:46 -0700 (PDT)
MIME-Version: 1.0
References: <20231011184823.443959-1-peter.griffin@linaro.org>
 <20231011184823.443959-3-peter.griffin@linaro.org> <ZScYOUi7qhvGmMIF@google.com>
 <e4523fc3-e1dd-4791-b950-98dfc6dce1f5@linaro.org> <CADrjBPpntJMsxb6oGQ7zuX3f0dgE3oYFepL4OdxamBz=_or7kw@mail.gmail.com>
 <21742fbf-8484-42ab-aba1-379305091946@linaro.org>
In-Reply-To: <21742fbf-8484-42ab-aba1-379305091946@linaro.org>
From:   Peter Griffin <peter.griffin@linaro.org>
Date:   Thu, 12 Oct 2023 11:45:35 +0100
Message-ID: <CADrjBPpF3Ta67QzUqyXD1YSFV_kFWqujCxPAjKbvRNhgXeMmOg@mail.gmail.com>
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

On Thu, 12 Oct 2023 at 10:36, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 12/10/2023 10:56, Peter Griffin wrote:
> > Hi Krzysztof,
> >
> > On Thu, 12 Oct 2023 at 07:07, Krzysztof Kozlowski
> > <krzysztof.kozlowski@linaro.org> wrote:
> >>
> >> On 11/10/2023 23:48, William McVicker wrote:
> >>> On 10/11/2023, Peter Griffin wrote:
> >>>> Provide dt-schema documentation for Google gs101 SoC clock controller.
> >>>> Currently this adds support for cmu_top, cmu_misc and cmu_apm.
> >>>>
> >>>> Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
> >>>
> >>> Tested-by: Will McVicker <willmcvicker@google.com>
> >>
> >> And how do you perform testing of a binding?
> >
> > I guess if William is using my script to build and flash the kernel it actually
> > runs the DTC checks as part of the build process.
> >
> > See https://git.codelinaro.org/linaro/googlelt/pixelscripts/-/blob/clo/main/buildp21upstream.sh#L44
>
> So it is a build test? We do not consider building as a test procedure,
> otherwise I should add my and robots tested-by to many other patches.

Ok so I should only add the Tested-by on the .c patches?

> Shall I consider other Tested-by tags here also as build-tested only?

No. William indicated here
https://lore.kernel.org/linux-arm-kernel/ZScZu-QB2LmB4CSM@google.com/T/#mbd96a26b725d6c85eb4193de8cd70ff277bc728e
that he booted it on his Oriole device.

Peter.

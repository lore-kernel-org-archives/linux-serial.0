Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A46C9CDB47E
	for <linux-serial@archiver.kernel.org>; Wed, 11 Oct 2023 18:54:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233213AbjJKSyt (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 11 Oct 2023 14:54:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233087AbjJKSys (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 11 Oct 2023 14:54:48 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBB3AAF
        for <linux-serial@vger.kernel.org>; Wed, 11 Oct 2023 11:54:45 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id 41be03b00d2f7-578b4997decso118407a12.0
        for <linux-serial@vger.kernel.org>; Wed, 11 Oct 2023 11:54:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697050485; x=1697655285; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1yAITkA43oBRq5wNnpQLBgM5d0bUs6osx3goAerw1Zs=;
        b=rQ5Jrcwch8pt1L2WORz6CKZE7I+oPyNscJf1fRpjvlCE33Q2ktuDovKYdEVV8tDBSt
         VH7QOeQZfduPNGIYbNZPzfMoXTE/VyULkOiUM1xoyEeqr8qSQzoY83VNRrArNfvOR8fw
         TVZVNwrFkOuParsjeM/21+Ho01opcGNBRxJUq1Qt9s91ZnhIBCHvJ5NY5aZ1cNjzWXTY
         FTA1NP9aDnKKMYoDjc/O3B9dPCh3sN39EL9SIm/mf70Kj2vw7OUIWWTneZCiG6jLVkoM
         +btr339vF61praR2UNfAOTFC1DW0sozrMWL5EV46APu9G95r+rQ+37ieozkGwIBq7dUB
         2z+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697050485; x=1697655285;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1yAITkA43oBRq5wNnpQLBgM5d0bUs6osx3goAerw1Zs=;
        b=TpPrCYxDTfKMetjs6HiCWiksEJutlNyo3Fl/VVSICGh88PdQbKxriW2GIMV23ymTy+
         4hZXbrZ4mkEusW5wKyUU3DBJ2+Ff4zBeWz51altKxqluGD4e+p1RjzwPSgVjQQIRhPLK
         C0BSiQBL6exnFbt8o8l4rGsLdA2HgVi2MeKk7/PIdJcaeLgWAbpH95VAcjA7aOoQIxjG
         WX6xMyMwcRiQGe5SSIiXZB5E+NxBESjwXb+Iq95d1I2HRjS/xgeKkJ9n6+IsDlj7D+Wt
         tF0J+mgOe+mQlgk9Pg63DadX0ZAlEFDq1JqQ11SEcfUCEhnmrW29qKX5awuITj1PuZPb
         EByw==
X-Gm-Message-State: AOJu0Yz77cBjFCnGdFVDkFaZFSAtGgYrkwrg+hIKt/Wy5L/3DEGncbW6
        QxwU3ZRti51ohOjAUUXo7JOvbggK+DCl+6c/6/lE5A==
X-Google-Smtp-Source: AGHT+IF2ZH9G5DtfhwrC1grow9snCHgNZ9i9qEm+hDBJbApMW0zlGdoIB5EmMSZ9fCki9SJLAlPeNOp5FVB21fst9pw=
X-Received: by 2002:a17:90b:46c7:b0:277:4b68:b93c with SMTP id
 jx7-20020a17090b46c700b002774b68b93cmr20814772pjb.4.1697050485416; Wed, 11
 Oct 2023 11:54:45 -0700 (PDT)
MIME-Version: 1.0
References: <20231011184823.443959-1-peter.griffin@linaro.org> <20231011184823.443959-2-peter.griffin@linaro.org>
In-Reply-To: <20231011184823.443959-2-peter.griffin@linaro.org>
From:   Sam Protsenko <semen.protsenko@linaro.org>
Date:   Wed, 11 Oct 2023 13:54:34 -0500
Message-ID: <CAPLW+4nipk9sae2UP6Jp_XXtHQMKbNpjGC4F7RW8GTuF3EtRBQ@mail.gmail.com>
Subject: Re: [PATCH v3 01/20] dt-bindings: soc: samsung: exynos-pmu: Add gs101 compatible
To:     Peter Griffin <peter.griffin@linaro.org>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        mturquette@baylibre.com, conor+dt@kernel.org, sboyd@kernel.org,
        tomasz.figa@gmail.com, s.nawrocki@samsung.com,
        linus.walleij@linaro.org, wim@linux-watchdog.org,
        linux@roeck-us.net, catalin.marinas@arm.com, will@kernel.org,
        arnd@arndb.de, olof@lixom.net, gregkh@linuxfoundation.org,
        cw00.choi@samsung.com, tudor.ambarus@linaro.org,
        andre.draszik@linaro.org, saravanak@google.com,
        willmcvicker@google.com, soc@kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-watchdog@vger.kernel.org,
        kernel-team@android.com, linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, Oct 11, 2023 at 1:49=E2=80=AFPM Peter Griffin <peter.griffin@linaro=
.org> wrote:
>
> Add gs101-pmu compatible to the bindings documentation.
>
> Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
> ---

Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>

>  Documentation/devicetree/bindings/soc/samsung/exynos-pmu.yaml | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/soc/samsung/exynos-pmu.yam=
l b/Documentation/devicetree/bindings/soc/samsung/exynos-pmu.yaml
> index e1d716df5dfa..9e497c310532 100644
> --- a/Documentation/devicetree/bindings/soc/samsung/exynos-pmu.yaml
> +++ b/Documentation/devicetree/bindings/soc/samsung/exynos-pmu.yaml
> @@ -15,6 +15,7 @@ select:
>      compatible:
>        contains:
>          enum:
> +          - google,gs101-pmu
>            - samsung,exynos3250-pmu
>            - samsung,exynos4210-pmu
>            - samsung,exynos4212-pmu
> @@ -35,6 +36,7 @@ properties:
>      oneOf:
>        - items:
>            - enum:
> +              - google,gs101-pmu
>                - samsung,exynos3250-pmu
>                - samsung,exynos4210-pmu
>                - samsung,exynos4212-pmu
> --
> 2.42.0.655.g421f12c284-goog
>

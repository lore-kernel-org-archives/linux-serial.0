Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0997CCDB483
	for <linux-serial@archiver.kernel.org>; Wed, 11 Oct 2023 23:12:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233930AbjJKXMr (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 11 Oct 2023 19:12:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235197AbjJKXMr (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 11 Oct 2023 19:12:47 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 427BBA9
        for <linux-serial@vger.kernel.org>; Wed, 11 Oct 2023 16:12:45 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id 41be03b00d2f7-5a1d89ff4b9so280598a12.0
        for <linux-serial@vger.kernel.org>; Wed, 11 Oct 2023 16:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697065965; x=1697670765; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1SUsXcVKQn8A+B+wkybfUBsU0p3cLnFC4FwTHNb3kWg=;
        b=Ie/9FT9rO7sD5nm73t4qjjqYeGqISckKD1SqVALlJSd+tMoAwrPeQIYkNcl+cqjw4S
         rkXbZmKFA/F5eMKk15Qd4uovBWAmyBYWQvoMQxCs5vGCfSgAToK+tp0imQRHdioyDqHW
         wvNw9t9M5F+AJZbrWGHz7VtAlfBiuq3UtcMNR7EnyawbpChIJ0AnUKw1suMazUqnCl9M
         K7lCs4gZZOAUQ4ODVg8aqh10Ue9v4xCi25+Z4Gzj5xUd69N5eKXpeuhUchjKqhM6tjsm
         8r/NhG4YBHm0Jr6MZ+zBQVrLLnVHH9FX8VeLgPhViL3qxGw/ThdTyNCa/9UrSCyu92X2
         MZfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697065965; x=1697670765;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1SUsXcVKQn8A+B+wkybfUBsU0p3cLnFC4FwTHNb3kWg=;
        b=ca8Jio23Vsj4rgtYyeMgy/9+12ZxcEl2+vKPe8AYnoaDFLMBvHKMNjrhKQzJxp042D
         sH1o7bYXeK2M36/thWp5Uf7aFhKne+qKgh6C9b7qCc+ANbRp/DlfGbmVDz5h0SDjT8NN
         UwsP0n5gExZk5t8ewJFFOG2VRM2LjwQQTxHJ1GAyI0eZG5lkxYryS4ZudO7qhX/AIN70
         TlzRej/PQz8vK5a4WpsVsTVt2Oz6AjKNH7ELqRAjYUY5577B6jToWYiYjJLX95DK7VUb
         Ftx5tqVjYzrRlhNZermsBl+28DPlcsIH0cZFzhNtzKeFLLYNoT25D0NPZUsnDsE2ceI8
         cTHQ==
X-Gm-Message-State: AOJu0YxfRRiAgZzJRZu2sI9iwpIIHMzmrHcZ+kSMAIPcQiHUOTBUlXpA
        pg8ulz/6/uJZIQg/GOKITNu+fLArQ2b1oZP0c4jTFw==
X-Google-Smtp-Source: AGHT+IHaJTcIj35kPFbipbN/CrQTdHVJTofe7kJ9Oof6VmcGMyPjSqNPDoeQzoD/zw9b5RjGiSgpqynUtZsW+Lj2se8=
X-Received: by 2002:a05:6a21:3d88:b0:171:a3e8:8c05 with SMTP id
 bj8-20020a056a213d8800b00171a3e88c05mr5927440pzc.53.1697065964759; Wed, 11
 Oct 2023 16:12:44 -0700 (PDT)
MIME-Version: 1.0
References: <20231010224928.2296997-1-peter.griffin@linaro.org> <20231010224928.2296997-8-peter.griffin@linaro.org>
In-Reply-To: <20231010224928.2296997-8-peter.griffin@linaro.org>
From:   Sam Protsenko <semen.protsenko@linaro.org>
Date:   Wed, 11 Oct 2023 18:12:33 -0500
Message-ID: <CAPLW+4nO8kfUbQ6wJDjG_Ft0HAu_j3gAvcLLHU3BAHnALqaULA@mail.gmail.com>
Subject: Re: [PATCH v2 07/20] dt-bindings: pinctrl: samsung: add
 gs101-wakeup-eint compatible
To:     Peter Griffin <peter.griffin@linaro.org>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        mturquette@baylibre.com, conor+dt@kernel.org, sboyd@kernel.org,
        tomasz.figa@gmail.com, s.nawrocki@samsung.com,
        linus.walleij@linaro.org, wim@linux-watchdog.org,
        linux@roeck-us.net, catalin.marinas@arm.com, will@kernel.org,
        arnd@arndb.de, olof@lixom.net, cw00.choi@samsung.com,
        tudor.ambarus@linaro.org, andre.draszik@linaro.org,
        saravanak@google.com, willmcvicker@google.com, soc@kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-watchdog@vger.kernel.org,
        kernel-team@android.com, linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Oct 10, 2023 at 5:49=E2=80=AFPM Peter Griffin <peter.griffin@linaro=
.org> wrote:
>
> gs101 is similar to newer Exynos SoCs like Exynos850 and ExynosAutov9
> where more than one pin controller can do external wake-up interrupt.
> So add a dedicated compatible for it.
>
> Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
> ---
>  .../bindings/pinctrl/samsung,pinctrl-wakeup-interrupt.yaml      | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/pinctrl/samsung,pinctrl-wa=
keup-interrupt.yaml b/Documentation/devicetree/bindings/pinctrl/samsung,pin=
ctrl-wakeup-interrupt.yaml
> index 1de91a51234d..7cddce761c46 100644
> --- a/Documentation/devicetree/bindings/pinctrl/samsung,pinctrl-wakeup-in=
terrupt.yaml
> +++ b/Documentation/devicetree/bindings/pinctrl/samsung,pinctrl-wakeup-in=
terrupt.yaml
> @@ -29,6 +29,7 @@ description: |
>  properties:
>    compatible:
>      enum:
> +      - google,gs101-wakeup-eint
>        - samsung,s3c2410-wakeup-eint
>        - samsung,s3c2412-wakeup-eint
>        - samsung,s3c64xx-wakeup-eint
> @@ -99,6 +100,7 @@ allOf:
>              enum:
>                - samsung,exynos850-wakeup-eint
>                - samsung,exynosautov9-wakeup-eint
> +              - google,gs101-wakeup-eint

Maybe move it on top, to keep the list sorted alphabetically?

>      then:
>        properties:
>          interrupts: false
> --
> 2.42.0.609.gbb76f46606-goog
>

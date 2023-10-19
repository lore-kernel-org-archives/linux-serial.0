Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA929C46CA1
	for <linux-serial@archiver.kernel.org>; Thu, 19 Oct 2023 14:33:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346143AbjJSOdP (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 19 Oct 2023 10:33:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235489AbjJSOdF (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 19 Oct 2023 10:33:05 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF01510E3
        for <linux-serial@vger.kernel.org>; Thu, 19 Oct 2023 07:32:30 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1cab2c24ecdso8063945ad.0
        for <linux-serial@vger.kernel.org>; Thu, 19 Oct 2023 07:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697725950; x=1698330750; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+XNrx3US1TBoOT89cC/5dM/an9l4kgmeujKRHDCLupM=;
        b=IFYDZo5lAbF2e10ozpQXYA9YrKwGIuwspFDgA+0fUygPYHP5/v2JqhCVXAPVIGWlQC
         qgWDZ+6PvRDa2X/1GBKbyhbQHpyalEKtHfm+EPtsuheiljoGk1cG4b9FbHFwTECAjT68
         lu9CYAoA5A9u21MeQztev2qtCYokCoYTLt4gvOetS+byi0lnkKVYNxW/aOWr53uKOjnU
         XSzLN3Nh1b+DNkpen+QYkC+qWIYYjJkCYH4wfewUnE8XOZLieNMwtwmAzdUcmjp2ByZr
         17FJ+Ksl31izGAhRcN1+0yLsbCvzq7eguMETPKWT3j5aq5iRkawbahM5R8TEA1AFj8TS
         6ArQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697725950; x=1698330750;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+XNrx3US1TBoOT89cC/5dM/an9l4kgmeujKRHDCLupM=;
        b=jJRtZVc6bpuNgmAFUWp2BZYSJkvHmTe7cxMTwtIW2B6FK5aAXs3lfdvO9NxcmVeqNW
         HFhpZIUiYJpkRZ+l42620rpeGyf2OZ9nPDBF4kilw5NoX76R+QrYqwHwIKmqr2uZmf9t
         U4P91sLEu9DEMNNaroEeCxIffK1zghG+XXUaI4SPCiJFJUuK6O6xTT3a5ekJ1QxCJa11
         Okjq1/NAs5Fo9kmYcQ7NvHpEOjtAQrKSqEtY2n94lzeCRZ9hZ9ia9aL8AlvwJ0hSNp2L
         aWE4QoZXnEFmo9RAoex7psyyGXs2aGJymEu52kPX6b9rCYMX1U7AjqngQnnKlnbj/jn1
         m0QA==
X-Gm-Message-State: AOJu0YyptKHn3+CNns1wyCt9ez+P5x09L0KtOQ73aoAttfa4hQsim/9S
        BFxI5XdhDUWciDic3b7Ny8wtvfXR6np2FCKBY35jxA==
X-Google-Smtp-Source: AGHT+IF0maLNEBc0Dq3xbTv91IIXRq9WGF5Xiw5WZ5EZSw0JzAXHB7waQNn5r9NmgLXvWrREApajxxBXEDUsi9Q9LUc=
X-Received: by 2002:a17:903:238c:b0:1c9:d25c:17c6 with SMTP id
 v12-20020a170903238c00b001c9d25c17c6mr2158169plh.1.1697725950072; Thu, 19 Oct
 2023 07:32:30 -0700 (PDT)
MIME-Version: 1.0
References: <20231019100639.4026283-1-andre.draszik@linaro.org> <20231019100639.4026283-2-andre.draszik@linaro.org>
In-Reply-To: <20231019100639.4026283-2-andre.draszik@linaro.org>
From:   Sam Protsenko <semen.protsenko@linaro.org>
Date:   Thu, 19 Oct 2023 09:32:19 -0500
Message-ID: <CAPLW+4=DG2g1=fZB9do_xb+q2ZU+BcyTgH5i15rqWoi_WUcdVQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] dt-bindings: serial: drop unsupported samsung bindings
To:     =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Cc:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        alim.akhtar@samsung.com, linux-serial@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, Oct 19, 2023 at 5:06=E2=80=AFAM Andr=C3=A9 Draszik <andre.draszik@l=
inaro.org> wrote:
>
> Now that no implementation exists anymore for
> samsung,s3c24(1[02]|40)-uart, remove those bindings from here as well.
>
> Signed-off-by: Andr=C3=A9 Draszik <andre.draszik@linaro.org>
> ---

Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>

>  Documentation/devicetree/bindings/serial/samsung_uart.yaml | 4 ----
>  1 file changed, 4 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/serial/samsung_uart.yaml b=
/Documentation/devicetree/bindings/serial/samsung_uart.yaml
> index 8bd88d5cbb11..d45079ef7bd9 100644
> --- a/Documentation/devicetree/bindings/serial/samsung_uart.yaml
> +++ b/Documentation/devicetree/bindings/serial/samsung_uart.yaml
> @@ -24,9 +24,6 @@ properties:
>        - enum:
>            - apple,s5l-uart
>            - axis,artpec8-uart
> -          - samsung,s3c2410-uart
> -          - samsung,s3c2412-uart
> -          - samsung,s3c2440-uart
>            - samsung,s3c6400-uart
>            - samsung,s5pv210-uart
>            - samsung,exynos4210-uart
> @@ -96,7 +93,6 @@ allOf:
>          compatible:
>            contains:
>              enum:
> -              - samsung,s3c2410-uart
>                - samsung,s5pv210-uart
>      then:
>        properties:
> --
> 2.40.1
>
>

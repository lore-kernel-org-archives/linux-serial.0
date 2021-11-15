Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CAEFC433FE
	for <linux-serial@archiver.kernel.org>; Mon, 15 Nov 2021 14:55:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B3596321B
	for <linux-serial@archiver.kernel.org>; Mon, 15 Nov 2021 14:55:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231910AbhKOO6X (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 15 Nov 2021 09:58:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231991AbhKOO6K (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 15 Nov 2021 09:58:10 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75B74C06120B
        for <linux-serial@vger.kernel.org>; Mon, 15 Nov 2021 06:55:11 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id b1so38434099lfs.13
        for <linux-serial@vger.kernel.org>; Mon, 15 Nov 2021 06:55:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gHoS2QIQL9jiqdDjkTDeK4x6Tmu2ipOUCUNpKzNE59E=;
        b=e9U5TdTPp4xKy1kJcXwDzSC8tbSpVywEYH9Z+sUjf4G9L8eFHtx5l3hWhed7rd1Ajz
         ebxts1R/3Vp3BD3fmiIs8ijW3vwxCRNKKrpAMPOT4NK7HnryzYPTd9dWWqyCBM/3mHnA
         vTVpkSClOFZnaQA1Ggw0m1qKX5z9BFeyCSc4VjSaCn4xvJCaKykOcCzMkrUu/7sEAMyj
         DCGbe70UQxZRmBIWafqA3pLWLk2Lx7W2zU1CZkBTpErb5uREerVsGeElEyyT8+u6f//7
         cKqncI+6LUB4ho/pCz33S0HvvdKcK7yNiEWVK9N5MT9zepjoT0gjtQYQ+6o7aVhzRCiv
         8/zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gHoS2QIQL9jiqdDjkTDeK4x6Tmu2ipOUCUNpKzNE59E=;
        b=2+xYV3zzf7aE7wljuzMLrefsjEovFx3tg1i0KFPTXUVqw+f2iEJsIEbDlmfEWSHqTa
         WYeHt7uOc6voo53smPkUP9K7w1iagOjhzLSX1h/g91/4mKs1uBTYDNRfNngrWmN2b88B
         3VcUsDUQlUsDCcQHilLP+jIPjEnB91Brvlg4HxotN7dgiZcxLDqLTQfhYO17MT94pKY8
         AKoeWucSaQAwBSAZctrEvX4DduPp5TcPi7oPoYmOk40OMPtYs8oN5DMRn96grdnyHPEf
         mRHYVZE9lLVz0vq+rIvlxlOxJuH5eqku/AblrpQgCd4ivneZlmJ5iZwm5DZlRebF9mJQ
         k1Nw==
X-Gm-Message-State: AOAM532CVj597tL572YY+26Fi3MpxyEcklVDQT5R8AGbd22HuPmfDU1y
        V7J1d6VRmZZzjfPcnOGszKMpJkqUcUcNPe6XT8SY7g==
X-Google-Smtp-Source: ABdhPJyFimQg7KkOTLtcJuBiGvEEcKgbemK/wWoYIOj4AkODv0WaiGPYUVNn88xx+gbks93TFVmDWvukiTbSyXAzBIA=
X-Received: by 2002:a19:8c4d:: with SMTP id i13mr37079711lfj.254.1636988109753;
 Mon, 15 Nov 2021 06:55:09 -0800 (PST)
MIME-Version: 1.0
References: <20211112082930.3809351-1-peng.fan@oss.nxp.com> <20211112082930.3809351-3-peng.fan@oss.nxp.com>
In-Reply-To: <20211112082930.3809351-3-peng.fan@oss.nxp.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 15 Nov 2021 15:54:33 +0100
Message-ID: <CAPDyKFq=7aiRhKw5f3EqoTq3Npyjs+L1xJBxjjqtTwh03GuXow@mail.gmail.com>
Subject: Re: [PATCH V4 2/9] dt-bindings: mmc: imx-esdhc: Add imx8ulp
 compatible string
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     robh+dt@kernel.org, aisheng.dong@nxp.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, broonie@kernel.org, linux@roeck-us.net,
        wim@linux-watchdog.org, linux@rempel-privat.de,
        Kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        daniel.lezcano@linaro.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-watchdog@vger.kernel.org, Jacky Bai <ping.bai@nxp.com>,
        Rob Herring <robh@kernel.org>, Peng Fan <peng.fan@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, 12 Nov 2021 at 09:30, Peng Fan (OSS) <peng.fan@oss.nxp.com> wrote:
>
> From: Jacky Bai <ping.bai@nxp.com>
>
> The USDHC on i.MX8ULP is derived from i.MX8MM, it uses two
> compatible strings, so update the compatible string for i.MX8ULP.
>
> Reviewed-by: Dong Aisheng <aisheng.dong@nxp.com>
> Acked-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Jacky Bai <ping.bai@nxp.com>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  - v4 changes:
>    no
>
>  - v3 changes:
>    no
>
>  - v2 changes:
>    refine the commit message
>
>  Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
> index 19621a2f8beb..d5be9863009c 100644
> --- a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
> +++ b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
> @@ -44,6 +44,10 @@ properties:
>                - fsl,imx8qm-usdhc
>                - fsl,imx8qxp-usdhc
>            - const: fsl,imx7d-usdhc
> +      - items:
> +          - enum:
> +              - fsl,imx8ulp-usdhc
> +          - const: fsl,imx8mm-usdhc
>
>    reg:
>      maxItems: 1
> --
> 2.25.1
>

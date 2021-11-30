Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90D33C433F5
	for <linux-serial@archiver.kernel.org>; Tue, 30 Nov 2021 15:42:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242816AbhK3PqH (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 30 Nov 2021 10:46:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242995AbhK3Pp7 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 30 Nov 2021 10:45:59 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09995C061758
        for <linux-serial@vger.kernel.org>; Tue, 30 Nov 2021 07:42:27 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id bi37so54851382lfb.5
        for <linux-serial@vger.kernel.org>; Tue, 30 Nov 2021 07:42:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rbWKM9Xn2xFZwaHfEK9OEQJFZXBlU8alMZMLf++BEkY=;
        b=hNo72FJguIUw3J4//SCG1WE05GM6kn91yQQeLaGkFBRyHnRInP5JIaBXX7Jg7auqq0
         E0Fp4993Kl+eV8htXH+Vn830560XGTxmPMdXeWicmRSImFt7QHIhplsO4zdKCN4b8106
         gIAMgoE5S3IeJrlX1rqiJD4NZDbDtX6CWj7OzJHIIHtoed75dOjR5AS42OjJI1c1cGA5
         GdFIp6gVb8+ErETwzVIx67blxGjJEIcqgag+8aYwmxPIa6xs3tOHM/0CMOwvrXTpHiaO
         gSJRCsR6eaXF52pWr4AgfTVpzASpuYt890glq2JEYebV96xb+F7mJGhBEzw+Nm+jMFvg
         0vtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rbWKM9Xn2xFZwaHfEK9OEQJFZXBlU8alMZMLf++BEkY=;
        b=u+zK0W60Ue1xJYyuQzZzVPsLgrE+nIZV3yDFP1Y4aj2pTAq5Agj3RQ6ScN1pCDJMBf
         sag2dmi0pW/aMMNF1T7OT85uCb6VLxGk64De9LxkUSdN3RSBONm2W5h0DpnQI7Ld2sEt
         rPSF2nw8q3tlAbE/0nBkmOiBf4nGeAjvZKv3fSw0tcICEkNLZch3u1+EtUNtAyFzLtFt
         cXJiRRmKlPFlAraa1tY/XsncDkcjMJHgOqa7N3MIwpAz4YtHs+Cpw6fwkWivgAtgIPlT
         wqxuCUseGd5qtkhJHtgZD76iAJiryz7F/HpjUg5W7X+2joL50c0YC6dyOGMv3ntldqiI
         OAvQ==
X-Gm-Message-State: AOAM532v7rUeEeHgFiGqm+2IkRQUImcUtzrfj5ZXJRvGTbUlA1sxUvvI
        zTWoocFFJL80OifZhXvqTfUyca5TFtfHbL/XAeuUxA==
X-Google-Smtp-Source: ABdhPJxkVm8zHo+0JrioJtZwtgAfyQdYXd1nGp/UrLj5Wi3K+MS7vNAPj00qeL3DDQrtGJ7m/zhMDNmerhnM7oZ2vtg=
X-Received: by 2002:ac2:5a46:: with SMTP id r6mr4420lfn.358.1638286946279;
 Tue, 30 Nov 2021 07:42:26 -0800 (PST)
MIME-Version: 1.0
References: <20211125211443.1150135-1-Mr.Bossman075@gmail.com> <20211125211443.1150135-11-Mr.Bossman075@gmail.com>
In-Reply-To: <20211125211443.1150135-11-Mr.Bossman075@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 30 Nov 2021 16:41:49 +0100
Message-ID: <CAPDyKFqxso-_ed4KsFO9c1M_ss65KKAPf9wYiKKOU_oLCUvzcQ@mail.gmail.com>
Subject: Re: [PATCH v3 10/13] dt-bindings: mmc: fsl-imx-esdhc: add i.MXRT
 compatible string
To:     Jesse Taube <mr.bossman075@gmail.com>
Cc:     linux-imx@nxp.com, mturquette@baylibre.com, sboyd@kernel.org,
        robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        Kernel@pengutronix.de, festevam@gmail.com, aisheng.dong@nxp.com,
        stefan@agner.ch, linus.walleij@linaro.org,
        gregkh@linuxfoundation.org, arnd@arndb.de, olof@lixom.net,
        soc@kernel.org, linux@armlinux.org.uk, abel.vesa@nxp.com,
        adrian.hunter@intel.com, jirislaby@kernel.org,
        giulio.benetti@benettiengineering.com,
        nobuhiro1.iwamatsu@toshiba.co.jp, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, 25 Nov 2021 at 22:15, Jesse Taube <mr.bossman075@gmail.com> wrote:
>
> From: Jesse Taube <mr.bossman075@gmail.com>
>
> Add i.MXRT documentation for compatible string.
>
> Cc: Giulio Benetti <giulio.benetti@benettiengineering.com>
> Signed-off-by: Jesse Taube <Mr.Bossman075@gmail.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
> V1->V2:
> * Nothing done
> V2->V3:
> * Rename imxrt to imxrt1050
> ---
>  Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
> index d5be9863009c..3fd6deff07f2 100644
> --- a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
> +++ b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
> @@ -34,6 +34,7 @@ properties:
>            - fsl,imx6ull-usdhc
>            - fsl,imx7d-usdhc
>            - fsl,imx7ulp-usdhc
> +          - fsl,imxrt1050-usdhc
>            - nxp,s32g2-usdhc
>        - items:
>            - enum:
> --
> 2.34.0
>

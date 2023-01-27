Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B150C38142
	for <linux-serial@archiver.kernel.org>; Fri, 27 Jan 2023 13:24:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234140AbjA0NYF (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 27 Jan 2023 08:24:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232288AbjA0NYF (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 27 Jan 2023 08:24:05 -0500
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F03F7CCA7
        for <linux-serial@vger.kernel.org>; Fri, 27 Jan 2023 05:24:04 -0800 (PST)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-50112511ba7so66694247b3.3
        for <linux-serial@vger.kernel.org>; Fri, 27 Jan 2023 05:24:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LZZ3MuEVu6XkQPyGITmSKOdfGu07b5+34vXdaMUVpmM=;
        b=UAHrFOhuENO8p4X6jjmFs9KrdLnh1L5ioIcN1vRBhDE992xV4cddAO0IjROU44dIG/
         nalP7afFVUtdPnm8JH4xghgm1GM/q5GOZS2kC5Yd9GXI9Z7PktEengh3fovMoq+zsVVE
         t0IPxp6dqeh897/z5G46UH91FQqy4WJQU8D3SIuIya0S9WZHfZk2C5Y30r2S827bu9eD
         CJLrDr1gIIxiC13d3vWqjY/9ZHwEpUdCVVNQAD/k++s1nG+mBWETZdTm2h8dtkZQWFeu
         swJGEwBP9C1DSuiQ188wLhYmsd5xFXheW++Lnq9ZpWPRKwvE/hZ2po1OCXDHo+L7t9nf
         jzGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LZZ3MuEVu6XkQPyGITmSKOdfGu07b5+34vXdaMUVpmM=;
        b=C+qlTOKJHD3LKdkd4K9e/Qs06AhU6830BdNdsRxXRO5PCMGnJLxI7eVeA7dRM9uFhR
         nIk4jrkZlLewWSoq2ARX6AYr9rxhqwl5/oUzrLXyySxuxwhqvO77akzwY+yAz1vcszPr
         yxusga64ACNT5Gt72LPta8AIKVCYphLkY59cSyZk5za7THh1T403YznQgfmnOJ8dp50z
         TlBcvVeRC7yi6X+xnGlg0x7HUBFRarzIbSwTaztPxSMyaup7f0V5utT5t0/L1l4pTzoS
         +8yImnuVQJfqIS+q5wLZ2zkmE95ZVDpA5mYJWHGaul+KRF4B+i3xns8f6YfgJYzK6TiE
         UY4Q==
X-Gm-Message-State: AFqh2kq/jRurv4UUYXpZAcfvHA8hKdSAWnzOd0021rX2tqtniwPm4/BY
        OxCQjM2fwzsQaaUZDQNK+OdpeWUczQEYuRv3ABREQg==
X-Google-Smtp-Source: AMrXdXsM2Y+feqWmDnpZZfAnDgXVYRK43870GInPFgNTT7qpRIbR4qPNx7T9fr58byEQonupKGetuGN9HSWpF17Olo4=
X-Received: by 2002:a05:690c:39b:b0:4f3:8d0e:edce with SMTP id
 bh27-20020a05690c039b00b004f38d0eedcemr3538984ywb.185.1674825843435; Fri, 27
 Jan 2023 05:24:03 -0800 (PST)
MIME-Version: 1.0
References: <20230127093217.60818-1-krzysztof.kozlowski@linaro.org> <20230127093217.60818-2-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230127093217.60818-2-krzysztof.kozlowski@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 27 Jan 2023 14:23:51 +0100
Message-ID: <CACRpkdabA03VEFFVDVDiEVnLDZXGmW-kyCpD8iRVOcBzNBTfkw@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] dt-bindings: intel,ixp4xx-expansion-bus: split out
 peripheral properties
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linus Walleij <linusw@kernel.org>,
        Imre Kaloz <kaloz@openwrt.org>,
        Krzysztof Halasa <khalasa@piap.pl>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Marek Vasut <marex@denx.de>, Lubomir Rintel <lkundrak@v3.sk>,
        - <devicetree@vger.kernel.org>, Marc Zyngier <maz@kernel.org>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mtd@lists.infradead.org, linux-serial@vger.kernel.org,
        linux-watchdog@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, Jan 27, 2023 at 10:32 AM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:

> The properties of devices in IXP4xx expansion bus need to be also
> applied to actual devices' bindings.  Prepare for this by splitting them
> to separate intel,ixp4xx-expansion-peripheral-props binding, just like
> other memory-controller peripheral properties.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Whoa, this is a complex one!
But I assume you and Marek know what you're doing so:
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Maybe I can assign the following external bus interface to the Qcom
people, as it is yet another one of those:
Documentation/devicetree/bindings/bus/qcom,ebi2.txt

I've been uncertain about how I should convert that one over properly.

Yours,
Linus Walleij

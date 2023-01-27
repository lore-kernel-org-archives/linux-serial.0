Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87FDAC54EAA
	for <linux-serial@archiver.kernel.org>; Fri, 27 Jan 2023 13:25:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233856AbjA0NZG (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 27 Jan 2023 08:25:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231863AbjA0NZG (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 27 Jan 2023 08:25:06 -0500
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EE2C7D2A6
        for <linux-serial@vger.kernel.org>; Fri, 27 Jan 2023 05:25:04 -0800 (PST)
Received: by mail-yb1-xb2a.google.com with SMTP id t16so5967484ybk.2
        for <linux-serial@vger.kernel.org>; Fri, 27 Jan 2023 05:25:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YfmZdMJN/D3xI4YTB54xIsWSAze0zkG8RrFJPkBL4AQ=;
        b=d2yyXte/yKIliOx/+8dSFRH8+M3Ex72UVdCuqh3m2tyi3rrRYlzuFLuFuOaXo8UJua
         gElqKdzCZZxnNL7BluA63zU1vXbJTTdCGK01yYehPr6WfmZLwmosoPiS95G7b5lmagCS
         L/upqPf5qIY2pjLEDKrUW9EdvBvPWpcC2GegAPRzTI8cGzevNc5TRFXyVw8hHFy7XJzN
         TH3bv0sOG57U6+65n9Xq6fsYWtTWYlZhS/Bzf440xEraF0lC2iKIkZMz3ndkI1DvtaHw
         EQNdQGri5E5aTQGN016ehd0p8PTqoPCqtOXzj5K3ayVZ69ryCa5toREYxDUTePUi+iWo
         LVcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YfmZdMJN/D3xI4YTB54xIsWSAze0zkG8RrFJPkBL4AQ=;
        b=kTKmdb2sPN3KXmsFzfcqtSjnN7FSWT+XzWJg1Fjuh2viRCX4r0ybkA3hf2laFRJMV4
         Ijxxa0Uvbd4/UfBX8rjCXyU/LcP5Yqd0U7XgbIJN484d7HRGXtVom8Kfn3oNa2rB7HFm
         LCBxZCNkCjUxdfKKhwTXpd8yfnSskQIfCWU1VfENXLfyE7RXJWdXRq53apCdeJGNybjG
         7Ko94YTjFU8CZpeHguoR4RTvq1W9qe8QRJCP235yCSpk9ZiHbz//Rtfo8N3Dc03Lc30m
         J03agWoGNx4gvFbxDMSJXnj/QAuxG6bMrmFJWA23Rot3prCUfGV2AYo0LtIMGFLBlubZ
         ZH/A==
X-Gm-Message-State: AO0yUKUNU1dppNzJyuNKF7VPScnQpyrwh59H8k3nF8APWs27tom3+FRj
        DdkH7WIf+SCNMx8Tqspvx6/Aj3plP1sEjJ+UlMkSwA==
X-Google-Smtp-Source: AK7set/AyCr5YILgHa1njAbv5GENd6K1HRNPT5FGDcIp6NDqNoyOABScAptxZu4MVa9CTfeWH7nQwPnr2nr1FbGyMhU=
X-Received: by 2002:a25:d1d1:0:b0:80b:4d84:b25 with SMTP id
 i200-20020a25d1d1000000b0080b4d840b25mr1325238ybg.584.1674825903381; Fri, 27
 Jan 2023 05:25:03 -0800 (PST)
MIME-Version: 1.0
References: <20230127093217.60818-1-krzysztof.kozlowski@linaro.org> <20230127093217.60818-3-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230127093217.60818-3-krzysztof.kozlowski@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 27 Jan 2023 14:24:52 +0100
Message-ID: <CACRpkdZUD1rw5j=Kik9KMt0w=JzS_T06FOGnyUA9GWmWZyQjcA@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] dt-bindings: reference MC peripheral properties in
 relevant devices
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

> Several devices can be attached to memory controllers (or memory-mapped
> buses), thus they can come with additional controller-specific
> properties, e.g. devices wired under Intel IXP4XX bus: cfi-flash,
> intel,ixp4xx-compact-flash, NS8250 serial and MAX6369 watchdog.
>
> Referencing Memory Controller or IXP4XX bus peripheral properties fixes
> few dtbs_check warnings like:
>
>   intel-ixp42x-gateworks-gw2348.dtb: ide@1,0: Unevaluated properties are not allowed
>     ('intel,ixp4xx-eb-ahb-split-transfers', 'intel,ixp4xx-eb-byte-access', ... ' were unexpected)
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

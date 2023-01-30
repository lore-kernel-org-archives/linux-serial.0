Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3951CC54EAA
	for <linux-serial@archiver.kernel.org>; Mon, 30 Jan 2023 09:27:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235485AbjA3J1y (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 30 Jan 2023 04:27:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236275AbjA3J1X (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 30 Jan 2023 04:27:23 -0500
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::222])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4434030286;
        Mon, 30 Jan 2023 01:25:16 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id E901C40003;
        Mon, 30 Jan 2023 09:24:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1675070654;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0TuPdf8fRkY/wdrnRAp1povjvstbHbqdy2BCWI+oz9I=;
        b=hAojLtKxBrWI+/kZN9TP7+vqZsAJSx7PmUJJ5d0LXcczpjw+tcYhs9G0spZypKKRWHNx8c
        TfSbENIBek943d/t62CHIDuyM2yIoJt5odiuMgEmpmlA8pnwLgAFfGnWb0zSu+QRHJxXgc
        eGA9jX2JkKsuJOgfXIcp7J4kf0+WxSl3oBFem5mvaz9pvNKuZ7nl6nJt+cNJAnmDzRnRvg
        fYCf9DjERqzi2VnPq8b/oOFNro3tUIzFyoLaNgzFmlejCZ/uGCLCnBgNfeL7KHTTxy4+0Z
        DF5KFFPPbLkH8KOYVDCTDq03rQ/lZfRY9w7LZf/BHMqQynpd5t9RHwvAPmAhhw==
Date:   Mon, 30 Jan 2023 10:24:06 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linus Walleij <linusw@kernel.org>,
        Imre Kaloz <kaloz@openwrt.org>,
        Krzysztof Halasa <khalasa@piap.pl>,
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
Subject: Re: [PATCH v2 2/3] dt-bindings: reference MC peripheral properties
 in relevant devices
Message-ID: <20230130102406.20d2293e@xps-13>
In-Reply-To: <20230127093217.60818-3-krzysztof.kozlowski@linaro.org>
References: <20230127093217.60818-1-krzysztof.kozlowski@linaro.org>
        <20230127093217.60818-3-krzysztof.kozlowski@linaro.org>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi Krzysztof,

krzysztof.kozlowski@linaro.org wrote on Fri, 27 Jan 2023 10:32:16 +0100:

> Several devices can be attached to memory controllers (or memory-mapped
> buses), thus they can come with additional controller-specific
> properties, e.g. devices wired under Intel IXP4XX bus: cfi-flash,
> intel,ixp4xx-compact-flash, NS8250 serial and MAX6369 watchdog.
>=20
> Referencing Memory Controller or IXP4XX bus peripheral properties fixes
> few dtbs_check warnings like:
>=20
>   intel-ixp42x-gateworks-gw2348.dtb: ide@1,0: Unevaluated properties are =
not allowed
>     ('intel,ixp4xx-eb-ahb-split-transfers', 'intel,ixp4xx-eb-byte-access'=
, ... ' were unexpected)
>=20
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>

Thanks,
Miqu=C3=A8l

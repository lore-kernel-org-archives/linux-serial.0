Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF86CC7618A
	for <linux-serial@archiver.kernel.org>; Wed, 15 Mar 2023 21:59:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231482AbjCOV76 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 15 Mar 2023 17:59:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229941AbjCOV76 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 15 Mar 2023 17:59:58 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBA8AD53F;
        Wed, 15 Mar 2023 14:59:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 994A4B81F7B;
        Wed, 15 Mar 2023 21:59:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22C8DC433EF;
        Wed, 15 Mar 2023 21:59:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678917594;
        bh=CZ5/qZGOWTYOHm7Ab0ij+kWvNIhmv5rGavd0NfyLMlk=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=NGelrNzSz83nQNvVFj+CCY+DZfSmmghJNUix/l7bbSL5+q406ZqArJQoyLpOTzKSG
         ctD9ogE5lC18Ee0Tft14U61jgKB+9KaRGnaTWW1/8LVNH9kyiqgSKG/USgAIvrsE7K
         9Yi1gFD3/PV5SZVSbFgLgq3I5iFIFZKb/gtO56qAGghPophL+ng3oszQhWEPTU46Y+
         vJGEpEPsC/9ewjPHqR7ngOA8W4JA7/yHgz20OeoAkY8Dtg4KIQRi82PejJ/NxF0wZ7
         05uA6TphfD8uJltoUylSZmWdIVnCRgCXI/1ngjL5HA8Ei1m4dflGzYlwg0B6BuAt3z
         f2AdwUmuZQEZw==
Message-ID: <d181a7bffc22be4b690f95f594ecbf5c.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230315072902.9298-9-ychuang570808@gmail.com>
References: <20230315072902.9298-1-ychuang570808@gmail.com> <20230315072902.9298-9-ychuang570808@gmail.com>
Subject: Re: [PATCH 08/15] dt-bindings: clock: Document ma35d1 clock controller bindings
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        schung@nuvoton.com, Jacky Huang <ychuang3@nuvoton.com>
To:     Jacky Huang <ychuang570808@gmail.com>, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        lee@kernel.org, mturquette@baylibre.com, p.zabel@pengutronix.de,
        robh+dt@kernel.org
Date:   Wed, 15 Mar 2023 14:59:51 -0700
User-Agent: alot/0.10
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Quoting Jacky Huang (2023-03-15 00:28:55)
> diff --git a/Documentation/devicetree/bindings/clock/nuvoton,ma35d1-clk.y=
aml b/Documentation/devicetree/bindings/clock/nuvoton,ma35d1-clk.yaml
> new file mode 100644
> index 000000000000..5c2dea071b38
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/nuvoton,ma35d1-clk.yaml
> @@ -0,0 +1,83 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/clock/nuvoton,ma35d1-clk.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Nuvoton MA35D1 Clock Controller Module Binding

Binding is redundant.

> +
> +maintainers:
> +  - Chi-Fang Li <cfli0@nuvoton.com>
> +  - Jacky Huang <ychuang3@nuvoton.com>
> +
> +description: |
> +  The MA35D1 clock controller generates clocks for the whole chip,
> +  including system clocks and all peripheral clocks.
> +
> +  See also:
> +    include/dt-bindings/clock/ma35d1-clk.h
> +
> +properties:
> +  compatible:
> +    items:
> +      - const: nuvoton,ma35d1-clk
> +      - const: syscon

Does it really need to be a syscon?

> +
> +  reg:
> +    maxItems: 1
> +
> +  "#clock-cells":
> +    const: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  clock-names:
> +    const: clk_hxt
> +
> +  assigned-clocks:
> +    maxItems: 5
> +
> +  assigned-clock-rates:
> +    maxItems: 5

I hope the assigned clocks properties can be left out of this doc.

> +
> +  nuvoton,pll-mode:
> +    description:
> +      A list of PLL operation mode corresponding to CAPLL, DDRPLL, APLL,
> +      EPLL, and VPLL in sequential. The operation mode value 0 is for
> +      integer mode, 1 is for fractional mode, and 2 is for spread
> +      spectrum mode.
> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +    maxItems: 5
> +    items:
> +      minimum: 0
> +      maximum: 2

Why not use a string?

> +
> +  nuvoton,sys:
> +    description:
> +      Phandle to the system management controller.
> +    $ref: "/schemas/types.yaml#/definitions/phandle-array"
> +
> +required:
> +  - compatible
> +  - reg
> +  - "#clock-cells"
> +  - clocks
> +  - clock-names
> +  - nuvoton,sys
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/nuvoton,ma35d1-clk.h>

No need to include this header right?

> +
> +    clk: clock-controller@40460200 {

Drop the label?

> +        compatible =3D "nuvoton,ma35d1-clk", "syscon";
> +        reg =3D <0x40460200 0x100>;
> +        #clock-cells =3D <1>;
> +        clocks =3D <&clk_hxt>;
> +        clock-names =3D "clk_hxt";
> +        nuvoton,sys =3D <&sys>;
> +    };

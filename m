Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56B9AC46467
	for <linux-serial@archiver.kernel.org>; Sun, 27 Nov 2022 17:30:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229541AbiK0RaJ (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sun, 27 Nov 2022 12:30:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiK0RaI (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sun, 27 Nov 2022 12:30:08 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1874364E4;
        Sun, 27 Nov 2022 09:30:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C9CEEB80B27;
        Sun, 27 Nov 2022 17:30:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0810BC433C1;
        Sun, 27 Nov 2022 17:30:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669570204;
        bh=HmQF8mfTp92YXxlx5z8dXvAr+KpT38AMBrKC7yplp+g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Et+gGNvDUFOGo7vlvdBfdLRwWGnLPVq3NDrDiqbnh2tLuQeYphrPDbuC+9xv3n2vN
         mXZSpSId0MICo8fzVFZu7fhtmtj+p+xXFM+zRKnsq1+ExZFxdpBcZCFbdgFksL3/D8
         CpiTsRWKx6APlFaE7vJ16sBunA45PMONSo8dGOwcxs4YhxQj5ifTBMYGqeFbhEesEu
         EXhfHH41sOaS4iBvJHfJ/LLAlAybPz/3BDOWdsIQu26CGtfQazuOQfu5+fFxRgbvDP
         Rao+gtrFlTsCIUOMo7zRVPLAh/kRne33M10bynQOxVee0QBgBKD3PNyBx3NaTgGPqp
         WouETvMDf1Umg==
Date:   Sun, 27 Nov 2022 17:29:59 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Jisheng Zhang <jszhang@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH v2 5/9] dt-bindings: riscv: Add bouffalolab bl808 board
 compatibles
Message-ID: <Y4Oel9j+MY0iSJ0A@spud>
References: <20221127132448.4034-1-jszhang@kernel.org>
 <20221127132448.4034-6-jszhang@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221127132448.4034-6-jszhang@kernel.org>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Sun, Nov 27, 2022 at 09:24:44PM +0800, Jisheng Zhang wrote:
> Several SoMs and boards are available that feature the Bouffalolab
> bl808 SoC. Document the compatible strings.
> 
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> ---
>  .../bindings/riscv/bouffalolab.yaml           | 34 +++++++++++++++++++
>  1 file changed, 34 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/riscv/bouffalolab.yaml
> 
> diff --git a/Documentation/devicetree/bindings/riscv/bouffalolab.yaml b/Documentation/devicetree/bindings/riscv/bouffalolab.yaml
> new file mode 100644
> index 000000000000..91ca9dbdc798
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/riscv/bouffalolab.yaml
> @@ -0,0 +1,34 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/riscv/bouffalolab.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Bouffalo Lab Technology SoC-based boards
> +
> +maintainers:
> +  - Jisheng Zhang <jszhang@kernel.org>
> +
> +description:
> +  Bouffalo Lab Technology SoC-based boards
> +
> +properties:
> +  $nodename:
> +    const: '/'
> +  compatible:
> +    oneOf:
> +      - description: Sipeed M1s SoM:
                                      ^
Drop these :s in the descriptions to placate Rob's bot :)

> +        items:
> +          - const: sipeed,m1s
> +          - const: bouffalolab,bl808
> +
> +      - description: Carrier boards for the Sipeed M1s SoM:
> +        items:
> +          - enum:
> +              - sipeed,m1s-dock

Do we need the enum when there's only one? I assume you're future
proofing against adding more carriers?

Otherwise than those two bits:
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

> +          - const: sipeed,m1s
> +          - const: bouffalolab,bl808
> +
> +additionalProperties: true
> +
> +...
> -- 
> 2.38.1
> 

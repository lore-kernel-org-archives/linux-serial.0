Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5405C433EF
	for <linux-serial@archiver.kernel.org>; Wed, 20 Jul 2022 14:53:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240939AbiGTOxS (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 20 Jul 2022 10:53:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240938AbiGTOxR (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 20 Jul 2022 10:53:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03D63AE67;
        Wed, 20 Jul 2022 07:53:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 96A7461B1C;
        Wed, 20 Jul 2022 14:53:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01E10C3411E;
        Wed, 20 Jul 2022 14:53:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658328796;
        bh=tScgr9tRlcamDWJp71+BgOJ65erdpbh5MP7W0rey/5w=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Nu0idpSBhUbEKMKJ53NoycKIG9XW2cs/kQ2pjCNscP8QIptsSOxEWz5knz66H2iF6
         SnA5I4f+8Fs3WpOVo1AY7aYB1hnYf2UVr9KuSY8uecYj2w0666qOmWsRw6jstgg4ko
         PlE9TupWADd86v920RQDeITX+r7j0E54NkEcGPczU9ni1g9tQgm3I028/A8Uw2ZR26
         79GppCOC4m82hPptzj9+Vbb+7orJMdZnVfpHdacq+V/2fijMk2vUZBoO/toj8rS6S6
         pbbG6vFpPr8JUxEbNt/9IfdDC66wmynyLsM/kqYNoHnsPhOgEE4Vh4tyr3bpeC6h4J
         bh37Tux0cKmDA==
Received: by mail-vk1-f173.google.com with SMTP id o10so1923895vkl.3;
        Wed, 20 Jul 2022 07:53:15 -0700 (PDT)
X-Gm-Message-State: AJIora/S1bpBxOvn2b0vYI81N1b88gHwJhmsLWvkMVre87eGnI7EUq8j
        Jh7Lj1/UELw0MJSzcY4YMIS4cNEKRwv/nOdrXw==
X-Google-Smtp-Source: AGRyM1s8adI2JDtHYge+QXHHiB2ZX2bfJ9llTgMW8aVq77rINPpnTdzS+C7Byb5flb4zFPN3/iYQ8eV5zeJnMHuJFlY=
X-Received: by 2002:a1f:2049:0:b0:374:866b:6dd8 with SMTP id
 g70-20020a1f2049000000b00374866b6dd8mr13961998vkg.15.1658328794928; Wed, 20
 Jul 2022 07:53:14 -0700 (PDT)
MIME-Version: 1.0
References: <20220720142612.19779-1-shubhrajyoti.datta@xilinx.com> <20220720142612.19779-2-shubhrajyoti.datta@xilinx.com>
In-Reply-To: <20220720142612.19779-2-shubhrajyoti.datta@xilinx.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Wed, 20 Jul 2022 08:53:03 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJz9CwEDwQhcax9L0MkiGzm5zzqxf_Nmp878TtbLt7wzg@mail.gmail.com>
Message-ID: <CAL_JsqJz9CwEDwQhcax9L0MkiGzm5zzqxf_Nmp878TtbLt7wzg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: serial: pl011: Add 'arm,xlnx-uart'
To:     Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Cc:     "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        git <git@xilinx.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, Jul 20, 2022 at 8:26 AM Shubhrajyoti Datta
<shubhrajyoti.datta@xilinx.com> wrote:
>
> The Xilinx Versal board uses the arm,pl011 ip. However the

s/ip/IP/

> axi port that it is connected to has a limitation that it allows
> only 32-bit accesses. So to differentiate we add a compatible.

Why not just use the standard 'reg-io-width' property?

> Add support for Uart used in Xilinx Versal SOCs as a platform
> device.

What's a platform device? Don't include Linuxisms in your bindings.

>
> Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
> Signed-off-by: Raviteja Narayanam <raviteja.narayanam@xilinx.com>
> ---
>  Documentation/devicetree/bindings/serial/pl011.yaml | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/serial/pl011.yaml b/Documentation/devicetree/bindings/serial/pl011.yaml
> index d8aed84abcd3..bf094ab93086 100644
> --- a/Documentation/devicetree/bindings/serial/pl011.yaml
> +++ b/Documentation/devicetree/bindings/serial/pl011.yaml
> @@ -24,9 +24,13 @@ select:
>
>  properties:
>    compatible:
> -    items:
> -      - const: arm,pl011
> -      - const: arm,primecell
> +    oneOf:
> +      - items:
> +          - const: arm,pl011
> +          - const: arm,primecell
> +      - items:
> +          - const: arm,pl011
> +          - const: arm,xlnx-uart # xilinx uart as platform device

First, this is backwards. compatible is most specific to least
specific. In your case Arm is not the vendor and just 'xlnx-uart' is
not very specific. You said this is for Versal SoC, so something like
'xlnx,versal-pl011' would be more appropriate. But again, I think
reg-io-width is all you need here.

The IP is still a Primecell block, so it should have 'arm,primecell'
still as the definition of 'arm,primecell' is that it has the ID
registers. Yes, that means Linux will create an amba_device instead,
but you can't be designing your binding to work-around Linux.

Rob

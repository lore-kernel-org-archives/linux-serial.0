Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D8CEEB64D7
	for <linux-serial@archiver.kernel.org>; Fri, 30 Jun 2023 16:55:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232712AbjF3QzH (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 30 Jun 2023 12:55:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232552AbjF3Qyv (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 30 Jun 2023 12:54:51 -0400
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C41663AAF;
        Fri, 30 Jun 2023 09:54:50 -0700 (PDT)
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-785d738d3feso52404839f.0;
        Fri, 30 Jun 2023 09:54:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688144090; x=1690736090;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=67BtTKSOiXAgcv4R/WNau4SsEpRTYdbgJXMKnQTjgkE=;
        b=K8edvsgGwFNOR4NFvKWj7X+/Iu/uCCZ+aIamZZ15uJidudSDpcQsZzhyuQRA7WsbEZ
         to5TWZJU7wvBWaD4TnkYNQ2On3rp6s1weXP5/r4+ztAxzkigOEbLqtwxQgBxOXkPb09E
         lCV1xuWGI2oHag5n7KKQxEuC0G0exLegUjiQgWGsNnhPZhRBwpV2wJc0OtEYfFF62NLa
         xhw3dStMw1vuTWVLyqR8vCUihuqPcneJQrvjGx/Nd8UgSQQNKpgLWffc9gZBqV8jBdg5
         iT56YbUVjukyHWVH9klSZXV3nMVNzVfDh3fau27HdPVKV+Of45hUonVJNBnJO7TqE8Ca
         apvg==
X-Gm-Message-State: AC+VfDyjg2u9CoObEBu9SmgIBqePBh8o+eenAlkPYJJcbEqLwl5VaC9m
        UFwY9UPl6slMb5Knhf0CEA==
X-Google-Smtp-Source: ACHHUZ6PxSdouTClIjwVuHZZgkyGNMSckimL5zdxpkTn+TmRAYNRQEQPJ0Ede6xCJ2nPANMmzdCfag==
X-Received: by 2002:a6b:5b02:0:b0:780:c872:5df7 with SMTP id v2-20020a6b5b02000000b00780c8725df7mr5647499ioh.9.1688144089895;
        Fri, 30 Jun 2023 09:54:49 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id t9-20020a02ab89000000b0042b279bb086sm8271jan.66.2023.06.30.09.54.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jun 2023 09:54:49 -0700 (PDT)
Received: (nullmailer pid 1892968 invoked by uid 1000);
        Fri, 30 Jun 2023 16:54:47 -0000
Date:   Fri, 30 Jun 2023 10:54:47 -0600
From:   Rob Herring <robh@kernel.org>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jon Hunter <jonathanh@nvidia.com>, devicetree@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: serial: tegra-hsuart: Convert to json-schema
Message-ID: <20230630165447.GA1888122-robh@kernel.org>
References: <20230630135843.1092770-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230630135843.1092770-1-thierry.reding@gmail.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, Jun 30, 2023 at 03:58:43PM +0200, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> Convert the Tegra High-Speed UART bindings from the free-form text
> format to json-schema.
> 
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
>  .../bindings/serial/nvidia,tegra20-hsuart.txt |  73 -----------
>  .../serial/nvidia,tegra20-hsuart.yaml         | 124 ++++++++++++++++++
>  2 files changed, 124 insertions(+), 73 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/serial/nvidia,tegra20-hsuart.txt
>  create mode 100644 Documentation/devicetree/bindings/serial/nvidia,tegra20-hsuart.yaml
> 
> diff --git a/Documentation/devicetree/bindings/serial/nvidia,tegra20-hsuart.txt b/Documentation/devicetree/bindings/serial/nvidia,tegra20-hsuart.txt
> deleted file mode 100644
> index f709304036c2..000000000000
> --- a/Documentation/devicetree/bindings/serial/nvidia,tegra20-hsuart.txt
> +++ /dev/null
> @@ -1,73 +0,0 @@
> -NVIDIA Tegra20/Tegra30 high speed (DMA based) UART controller driver.
> -
> -Required properties:
> -- compatible : should be,
> -  "nvidia,tegra20-hsuart" for Tegra20,
> -  "nvidia,tegra30-hsuart" for Tegra30,
> -  "nvidia,tegra186-hsuart" for Tegra186,
> -  "nvidia,tegra194-hsuart" for Tegra194.
> -
> -- reg: Should contain UART controller registers location and length.
> -- interrupts: Should contain UART controller interrupts.
> -- clocks: Must contain one entry, for the module clock.
> -  See ../clocks/clock-bindings.txt for details.
> -- resets : Must contain an entry for each entry in reset-names.
> -  See ../reset/reset.txt for details.
> -- reset-names : Must include the following entries:
> -  - serial
> -- dmas : Must contain an entry for each entry in dma-names.
> -  See ../dma/dma.txt for details.
> -- dma-names : Must include the following entries:
> -  - rx
> -  - tx
> -
> -Optional properties:
> -- nvidia,enable-modem-interrupt: Enable modem interrupts. Should be enable
> -		only if all 8 lines of UART controller are pinmuxed.
> -- nvidia,adjust-baud-rates: List of entries providing percentage of baud rate
> -  adjustment within a range.
> -  Each entry contains sets of 3 values. Range low/high and adjusted rate.
> -  <range_low range_high adjusted_rate>
> -  When baud rate set on controller falls within the range mentioned in this
> -  field, baud rate will be adjusted by percentage mentioned here.
> -  Ex: <9600 115200 200>
> -  Increase baud rate by 2% when set baud rate falls within range 9600 to 115200
> -
> -Baud Rate tolerance:
> -  Standard UART devices are expected to have tolerance for baud rate error by
> -  -4 to +4 %. All Tegra devices till Tegra210 had this support. However,
> -  Tegra186 chip has a known hardware issue. UART Rx baud rate tolerance level
> -  is 0% to +4% in 1-stop config. Otherwise, the received data will have
> -  corruption/invalid framing errors. Parker errata suggests adjusting baud
> -  rate to be higher than the deviations observed in Tx.
> -
> -  Tx deviation of connected device can be captured over scope (or noted from
> -  its spec) for valid range and Tegra baud rate has to be set above actual
> -  Tx baud rate observed. To do this we use nvidia,adjust-baud-rates
> -
> -  As an example, consider there is deviation observed in Tx for baud rates as
> -  listed below.
> -  0 to 9600 has 1% deviation
> -  9600 to 115200 2% deviation
> -  This slight deviation is expcted and Tegra UART is expected to handle it. Due
> -  to the issue stated above, baud rate on Tegra UART should be set equal to or
> -  above deviation observed for avoiding frame errors.
> -  Property should be set like this
> -  nvidia,adjust-baud-rates = <0 9600 100>,
> -  			     <9600 115200 200>;
> -
> -Example:
> -
> -serial@70006000 {
> -	compatible = "nvidia,tegra30-hsuart", "nvidia,tegra20-hsuart";

I guess this wasn't valid? Would be good if the commit msg said that.

> -	reg = <0x70006000 0x40>;
> -	reg-shift = <2>;
> -	interrupts = <0 36 0x04>;
> -	nvidia,enable-modem-interrupt;
> -	clocks = <&tegra_car 6>;
> -	resets = <&tegra_car 6>;
> -	reset-names = "serial";
> -	dmas = <&apbdma 8>, <&apbdma 8>;
> -	dma-names = "rx", "tx";
> -	nvidia,adjust-baud-rates = <1000000 4000000 136>; /* 1.36% shift */
> -};
> diff --git a/Documentation/devicetree/bindings/serial/nvidia,tegra20-hsuart.yaml b/Documentation/devicetree/bindings/serial/nvidia,tegra20-hsuart.yaml
> new file mode 100644
> index 000000000000..247ee33f8a01
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/serial/nvidia,tegra20-hsuart.yaml
> @@ -0,0 +1,124 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/serial/nvidia,tegra20-hsuart.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: NVIDIA Tegra20/Tegra30 high speed (DMA based) UART controller driver
> +
> +maintainers:
> +  - Thierry Reding <thierry.reding@gmail.com>
> +  - Jon Hunter <jonathanh@nvidia.com>
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - const: nvidia,tegra20-hsuart
> +      - const: nvidia,tegra30-hsuart
> +      - items:
> +          - const: nvidia,tegra124-hsuart
> +          - const: nvidia,tegra30-hsuart
> +      - const: nvidia,tegra186-hsuart
> +      - const: nvidia,tegra194-hsuart

All the single entry entries can be an enum.

With those fixes:

Reviewed-by: Rob Herring <robh@kernel.org>

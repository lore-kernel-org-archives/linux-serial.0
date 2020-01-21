Return-Path: <SRS0=m7Km=3K=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBCA7C2D0CE
	for <linux-serial@archiver.kernel.org>; Tue, 21 Jan 2020 22:20:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDD85217F4
	for <linux-serial@archiver.kernel.org>; Tue, 21 Jan 2020 22:20:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579645210;
	bh=3uzcw75p8PScJ1WChjuOQmCS2ZpxerDxdL48GCpXnp0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=uCka/y18gWUDToR/8zdBH1OY1jiVwWTlt3J+DonkpxvrsGYHjCL6keB4/lOgcTjbp
	 57CplJKewEXqXVoqw/YegeLsqQQHiGnAeQrG5e5lw6K6C7vRFrtNoYBYbO0Lstbtc/
	 vzCkyURu0ofAUeI4WuYPfpCgZBCwyNy9JGiFcv/Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729031AbgAUWUK (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 21 Jan 2020 17:20:10 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:39590 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728760AbgAUWUK (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 21 Jan 2020 17:20:10 -0500
Received: by mail-oi1-f195.google.com with SMTP id z2so4206589oih.6;
        Tue, 21 Jan 2020 14:20:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JYjL5Dj4sHium7MXkG5wUfXThgHrFk9aKNPtUfH5UZc=;
        b=LuxAJOSCVwPh9i2HOnCZn3xqV3Yt7+t5+U5WeARTAVgEXTkTJGsdLJubR03kpvyKnK
         Op9kdntraDRJO1nEeC1Ae/XbWPqwXN5Bbm11MKsx600vlwLxFzgJ8zDGywzFxHApWMxJ
         6V8pGLqG7+aE6gVvlsOJO2zC/phOg3uvMkdp8bd4/aplnKl1A05QpuOI+hjQIO38BL+F
         n8B9cT1KH7TLo/rHoxoOFPjrdcJ1Fc4KMJF5sDnSHFlIRoNyqu3F6fSoSQB7Hqx5a+3D
         NNeunCl61djJoq3Cb17Q3S+Ph9aRxe7YkCp8oUHVLb9X7+FjAHlYsUNvPpfJ0VaNBa5n
         jWYw==
X-Gm-Message-State: APjAAAWLAVXMzruSKEKtGBIWlVh/8IknN23L8F82o6qJXfN44fKBV/Oj
        Jj3mJ6D5g5rCeNiQX8f4bw==
X-Google-Smtp-Source: APXvYqyA0cFBVl5WxqRWUAajmwQG24um1yPraaZ5cnlqeSKW61xBpYW8L1xuloSvzFgFL8RaFKDW6w==
X-Received: by 2002:aca:5588:: with SMTP id j130mr4595173oib.122.1579645208961;
        Tue, 21 Jan 2020 14:20:08 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id d7sm12406255oic.46.2020.01.21.14.20.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2020 14:20:08 -0800 (PST)
Received: (nullmailer pid 8896 invoked by uid 1000);
        Tue, 21 Jan 2020 22:20:07 -0000
Date:   Tue, 21 Jan 2020 16:20:07 -0600
From:   Rob Herring <robh@kernel.org>
To:     Benjamin Gaignard <benjamin.gaignard@st.com>
Cc:     gregkh@linuxfoundation.org, mark.rutland@arm.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@st.com,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, fabrice.gasnier@st.com,
        erwan.leray@st.com
Subject: Re: [PATCH 1/2] dt-bindings: serial: Convert rs485 bindings to
 json-schema
Message-ID: <20200121222007.GA1686@bogus>
References: <20200114123329.3792-1-benjamin.gaignard@st.com>
 <20200114123329.3792-2-benjamin.gaignard@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200114123329.3792-2-benjamin.gaignard@st.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Jan 14, 2020 at 01:33:28PM +0100, Benjamin Gaignard wrote:
> Convert rs485 binding to yaml style file.
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
> ---
>  Documentation/devicetree/bindings/serial/rs485.txt | 32 +--------------
>  .../devicetree/bindings/serial/rs485.yaml          | 45 ++++++++++++++++++++++
>  2 files changed, 46 insertions(+), 31 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/serial/rs485.yaml
> 
> diff --git a/Documentation/devicetree/bindings/serial/rs485.txt b/Documentation/devicetree/bindings/serial/rs485.txt
> index b92592dff6dd..a7fe93efc4a5 100644
> --- a/Documentation/devicetree/bindings/serial/rs485.txt
> +++ b/Documentation/devicetree/bindings/serial/rs485.txt
> @@ -1,31 +1 @@
> -* RS485 serial communications
> -
> -The RTS signal is capable of automatically controlling line direction for
> -the built-in half-duplex mode.
> -The properties described hereafter shall be given to a half-duplex capable
> -UART node.
> -
> -Optional properties:
> -- rs485-rts-delay: prop-encoded-array <a b> where:
> -  * a is the delay between rts signal and beginning of data sent in milliseconds.
> -      it corresponds to the delay before sending data.
> -  * b is the delay between end of data sent and rts signal in milliseconds
> -      it corresponds to the delay after sending data and actual release of the line.
> -  If this property is not specified, <0 0> is assumed.
> -- rs485-rts-active-low: drive RTS low when sending (default is high).
> -- linux,rs485-enabled-at-boot-time: empty property telling to enable the rs485
> -  feature at boot time. It can be disabled later with proper ioctl.
> -- rs485-rx-during-tx: empty property that enables the receiving of data even
> -  while sending data.
> -
> -RS485 example for Atmel USART:
> -	usart0: serial@fff8c000 {
> -		compatible = "atmel,at91sam9260-usart";
> -		reg = <0xfff8c000 0x4000>;
> -		interrupts = <7>;
> -		atmel,use-dma-rx;
> -		atmel,use-dma-tx;
> -		linux,rs485-enabled-at-boot-time;
> -		rs485-rts-delay = <0 200>;		// in milliseconds
> -	};
> -
> +See rs485.yaml
> diff --git a/Documentation/devicetree/bindings/serial/rs485.yaml b/Documentation/devicetree/bindings/serial/rs485.yaml
> new file mode 100644
> index 000000000000..65c6a98969a8
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/serial/rs485.yaml
> @@ -0,0 +1,45 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/serial/rs485.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: RS485 serial communications Bindings
> +
> +description: The RTS signal is capable of automatically controlling
> +             line direction for the built-in half-duplex mode.
> +             The properties described hereafter shall be given to a
> +             half-duplex capable UART node.
> +
> +maintainers:
> +  -  Rob Herring <robh@kernel.org>
> +
> +properties:
> +  rs485-rts-delay:
> +    description: prop-encoded-array <a b>
> +    allOf:
> +      - $ref: /schemas/types.yaml#/definitions/uint32-matrix
> +      - items:
> +          items:
> +            - description:
> +                Delay between rts signal and beginning of data sent in milliseconds.
> +                It corresponds to the delay before sending data.
> +              $ref: "/schemas/types.yaml#/definitions/uint32"

This is not correct. The types only apply to whole properties.

Is there a maximum? Seems like 1 sec would be more than anyone would 
ever want?

> +              default: 0
> +            - description:
> +                Delay between end of data sent and rts signal in milliseconds.
> +                It corresponds to the delay after sending data and actual release of the line.
> +              $ref: "/schemas/types.yaml#/definitions/uint32"
> +              default: 0
> +
> +  rs485-rts-active-low:
> +    description: drive RTS low when sending (default is high).
> +    $ref: /schemas/types.yaml#/definitions/flag
> +
> +  linux,rs485-enabled-at-boot-time:
> +    description: enables the rs485 feature at boot time. It can be disabled later with proper ioctl.
> +    $ref: /schemas/types.yaml#/definitions/flag
> +
> +  rs485-rx-during-tx:
> +   description: enables the receiving of data even while sending data.
> +   $ref: /schemas/types.yaml#/definitions/flag
> -- 
> 2.15.0
> 

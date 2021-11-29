Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E46DDC433F5
	for <linux-serial@archiver.kernel.org>; Mon, 29 Nov 2021 22:10:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232239AbhK2WNy (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 29 Nov 2021 17:13:54 -0500
Received: from mail-oo1-f50.google.com ([209.85.161.50]:36483 "EHLO
        mail-oo1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229779AbhK2WLy (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 29 Nov 2021 17:11:54 -0500
Received: by mail-oo1-f50.google.com with SMTP id g11-20020a4a754b000000b002c679a02b18so6104959oof.3;
        Mon, 29 Nov 2021 14:08:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zrZI1RxVftFt86udeFk7JFpDYtzfxae1gOe0KIZTJGQ=;
        b=YAmmu1Vl95XHJ/Pd6DZ3CZgNoiJG06LxOEXTPS0SUHmRxylzSls9lry/AIiyyOMahJ
         kUQHKqLQsX11534YXQZXHEc2jHvgyS+ZVy4nPmSMleGSHlDucBkEphs/I66jQpPq9Ov3
         jt/H5HwAtPt4vE7GmRZY9XeQxek4D7B3sTPridrNVW4yh8sSqMsZLQOJZ9vUjAPJuPqu
         CAM2xMpMCV+be84gBKEIB4ZivRa0hgJ7yepOsvmvLlf9/KQLDcSjTzT3lo9hAGVDpGsU
         J+NLS7Oau5wHPqfYsdJXwkpxOQB65TUMUSXh0HzKsAoAuUobZfTq+ilZT9Sl+J/PPd+Z
         AAfw==
X-Gm-Message-State: AOAM531Pfyiq3RAChEqpVOl2qphHpUV3AsgzpqEnJ/71/+QHk5GLdYpr
        BWZAsfnPsxJSwDm/YVWG2UdvakybXA==
X-Google-Smtp-Source: ABdhPJzBzGKiVSoZ7Y8cgfynXD74tpTljRY+rlC5loLefamus3owYDtj5zm3wxc0bxAsfCBil8+9gA==
X-Received: by 2002:a4a:dd93:: with SMTP id h19mr32771210oov.73.1638223715613;
        Mon, 29 Nov 2021 14:08:35 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id bb8sm3320633oib.9.2021.11.29.14.08.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Nov 2021 14:08:35 -0800 (PST)
Received: (nullmailer pid 697929 invoked by uid 1000);
        Mon, 29 Nov 2021 22:08:34 -0000
Date:   Mon, 29 Nov 2021 16:08:34 -0600
From:   Rob Herring <robh@kernel.org>
To:     Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Cc:     linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        gregkh@linuxfoundation.org,
        Raviteja Narayanam <raviteja.narayanam@xilinx.com>
Subject: Re: [PATCH 1/2] dt-bindings: serial: pl011: Add 'arm,xlnx-uart'
Message-ID: <YaVPYiGmDsqY+1at@robh.at.kernel.org>
References: <cover.1637061057.git.shubhrajyoti.datta@xilinx.com>
 <e1d6913bfe5ce023d7f6ea106d0359142063e694.1637061057.git.shubhrajyoti.datta@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e1d6913bfe5ce023d7f6ea106d0359142063e694.1637061057.git.shubhrajyoti.datta@xilinx.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Nov 16, 2021 at 04:47:45PM +0530, Shubhrajyoti Datta wrote:
> Add support for Uart used in Xilinx Versal SOCs as a platform
> device.

No. Why would we want to do that?

> 
> Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
> Signed-off-by: Raviteja Narayanam <raviteja.narayanam@xilinx.com>
> ---
>  Documentation/devicetree/bindings/serial/pl011.yaml | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/serial/pl011.yaml b/Documentation/devicetree/bindings/serial/pl011.yaml
> index 5ea00f8a283d..6c73923dd15e 100644
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

'arm,primecell' means the block has ID registers. Are you saying this 
implementation doesn't?

>  
>    reg:
>      maxItems: 1
> -- 
> 2.25.1
> 
> 

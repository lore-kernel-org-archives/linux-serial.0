Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D46FC43460
	for <linux-serial@archiver.kernel.org>; Tue, 20 Apr 2021 20:02:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E772A613C7
	for <linux-serial@archiver.kernel.org>; Tue, 20 Apr 2021 20:02:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233789AbhDTUDW (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 20 Apr 2021 16:03:22 -0400
Received: from mail-oi1-f173.google.com ([209.85.167.173]:35574 "EHLO
        mail-oi1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233682AbhDTUDW (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 20 Apr 2021 16:03:22 -0400
Received: by mail-oi1-f173.google.com with SMTP id e25so10210135oii.2;
        Tue, 20 Apr 2021 13:02:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KjD4lXtva/+btnljL9bkUIKj0w5NavTEnen058f6CYg=;
        b=FwFN0OQwKjwGjgtCZ2g0D/uu/VUsmDzV9vzUvFrWf9fZjjNrGjKEU3bhsOI6eBoFQP
         dsg6j2b1juxqNTMLOkFI2Je7/0A065Oo3jNaghEnAT0TDok9bkyo4MTopgQI5ug/qxHZ
         skV7oXxyWSdDZHqtxkCaK+s7SNyosGQI92sHeOgqDk+G7t7Hr1JWaWNJ/ERwsiuYFgVV
         Sz8Ms3iba0DYDZM8eJPcmOtyC7UViOkPF8GSEMLNImKzoAmU/6bnFKyOQgfOqg6xwF2+
         /FRqgelRpD4wCW/kxJ4jHDkznviZK2u/A6b3r+MXispB+YloiTd0fJgdRN8KWSdHm0iA
         nPkQ==
X-Gm-Message-State: AOAM531eEpJWNtcmwyiaCTzMryGFyZdekZkQ9/Njj0TC8Oj3iqazLAEc
        hkxncQF3mJBJuM5Ng21KJg==
X-Google-Smtp-Source: ABdhPJxsU17fvzON9fb6P8t7ei/fmSZiVxJF23/q6NmCKy9c1HHOB/zC0Uq2cgzpTjxZzey78BhuzA==
X-Received: by 2002:a05:6808:b3b:: with SMTP id t27mr4236059oij.131.1618948970562;
        Tue, 20 Apr 2021 13:02:50 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id s3sm14508ool.36.2021.04.20.13.02.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Apr 2021 13:02:47 -0700 (PDT)
Received: (nullmailer pid 3719999 invoked by uid 1000);
        Tue, 20 Apr 2021 20:02:46 -0000
Date:   Tue, 20 Apr 2021 15:02:46 -0500
From:   Rob Herring <robh@kernel.org>
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] dt-bindings: serial: Add label property for pl011
Message-ID: <20210420200246.GA3717650@robh.at.kernel.org>
References: <20210415073105.3687-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210415073105.3687-1-thunder.leizhen@huawei.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, Apr 15, 2021 at 03:31:05PM +0800, Zhen Lei wrote:
> When there is more than one pl011 serial port present, the label property
> allows a custom name to be used for briefly describe the usage or position
> of each serial port.
> 
> Without this "label" property, many dtbs_check warnings similar to the
> following are reported:
> arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dt.yaml: \
> serial@ffd74000: Additional properties are not allowed ('label' was unexpected)
>         From schema: Documentation/devicetree/bindings/serial/pl011.yaml

I think this should go into serial.yaml instead.

> 
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>  Documentation/devicetree/bindings/serial/pl011.yaml | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/serial/pl011.yaml b/Documentation/devicetree/bindings/serial/pl011.yaml
> index 1f8e9f2644b6b80..303c7746423f503 100644
> --- a/Documentation/devicetree/bindings/serial/pl011.yaml
> +++ b/Documentation/devicetree/bindings/serial/pl011.yaml
> @@ -34,6 +34,9 @@ properties:
>    reg:
>      maxItems: 1
>  
> +  label:
> +    maxItems: 1

label is always a single string and so 'maxItems' is always 1. Just 
need:

label: true

> +
>    interrupts:
>      maxItems: 1
>  
> -- 
> 2.26.0.106.g9fadedd
> 
> 

Return-Path: <SRS0=s89U=ID=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE358C433E0
	for <linux-serial@archiver.kernel.org>; Fri,  5 Mar 2021 20:44:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 70E8964FEA
	for <linux-serial@archiver.kernel.org>; Fri,  5 Mar 2021 20:44:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229730AbhCEUnu (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 5 Mar 2021 15:43:50 -0500
Received: from mail-oi1-f169.google.com ([209.85.167.169]:46347 "EHLO
        mail-oi1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbhCEUnh (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 5 Mar 2021 15:43:37 -0500
Received: by mail-oi1-f169.google.com with SMTP id f3so3897173oiw.13;
        Fri, 05 Mar 2021 12:43:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dlpQquezM9+f/msc9PNVrAFqjM4GJfQ63gLw6nECVRw=;
        b=Rr25HttsZemvVjsk+zHDn7WNbPlykY2VC0wwQZnDeydi8fqt7itJTjsfee1lhI+o5Y
         UfNnlAESQrm5hDKSRBKuw7kysH3vkYCK69NYym4msciVsahY5EpfWeN1FYuMtBYnNBpt
         aol5D4mHW5YMWo6e/9je3e93uhGZXpncYIvHk4qLQwzQpM6bypfPFBFzmskWOVD3YoYH
         Kpma+pMJXg8iMC9QLT48C3ePeCjzgacU5/gTo5jBgPWc/PcFNgzecXqBfzVnWHZUbSyt
         t0CKfohn/fdKpWDxVGgi22Qilx/cRx0sRcTwYdOql4ZGP4flaj5FNN/rkvh/x6U+cBDa
         i1TQ==
X-Gm-Message-State: AOAM531BiOOPnEKXTrRGLEvbbDf/OybkSoKiloCMMpENZ7X7NWGQYYF4
        nt6HPzSbPwkLxVCu6X04dXP4KnCbrg==
X-Google-Smtp-Source: ABdhPJz/Q5AZEAaKjgkx4FiIblQLWU6yRxy0zPCZFYk1XKDJZwTj8QIGfFJK/LBgkoFv3kxBoRwxOA==
X-Received: by 2002:aca:d4d1:: with SMTP id l200mr5375693oig.119.1614977017394;
        Fri, 05 Mar 2021 12:43:37 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id m34sm833688otc.25.2021.03.05.12.43.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Mar 2021 12:43:36 -0800 (PST)
Received: (nullmailer pid 612998 invoked by uid 1000);
        Fri, 05 Mar 2021 20:43:35 -0000
Date:   Fri, 5 Mar 2021 14:43:35 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: serial: samsung: add DMA properties
Message-ID: <20210305204335.GA612926@robh.at.kernel.org>
References: <20210212163905.70171-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210212163905.70171-1-krzk@kernel.org>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, 12 Feb 2021 17:39:04 +0100, Krzysztof Kozlowski wrote:
> The Samsung SoC UART nodes have usually DMA so dtschema has to reflect
> this to fix dtbs_check warnings like:
> 
>   arch/arm/boot/dts/exynos4210-smdkv310.dt.yaml: serial@13800000:
>     'dma-names', 'dmas' do not match any of the regexes: 'pinctrl-[0-9]+'
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  .../devicetree/bindings/serial/samsung_uart.yaml       | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

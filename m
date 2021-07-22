Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E459C6377C
	for <linux-serial@archiver.kernel.org>; Thu, 22 Jul 2021 03:07:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B76B61287
	for <linux-serial@archiver.kernel.org>; Thu, 22 Jul 2021 03:07:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230281AbhGVC0s (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 21 Jul 2021 22:26:48 -0400
Received: from mail-io1-f54.google.com ([209.85.166.54]:33283 "EHLO
        mail-io1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230026AbhGVC0r (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 21 Jul 2021 22:26:47 -0400
Received: by mail-io1-f54.google.com with SMTP id z11so4805504iow.0;
        Wed, 21 Jul 2021 20:07:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jLr0MYx1P2py+n9nqtuOmPHzhcgUuNPRHsZhrl9n/IY=;
        b=e0DnHUMd4ak5NKYNK2aCGQ30qKJrxSJWwKd/d1Hv/hyLdai9h7vuegG2u1bhYmB9e2
         5zxWA/2NKPKBESjBt0z4VSLyR/GeoUHqaQveTHv9RuVQGCCJ7ObjPg6dpfjpnS85fTDL
         rsw6jxiViUiHW54Q8SUYJCmP6vMGpjUOMyUnKMpBzU190N52SSBkj+x1g7/fYG55G8/q
         lgepj+DARUSrkBydWtAnTNxk6pbCwlHsr8FsjVqA/c0loj+2qUI4MjM4fgqsC2m4CZBV
         0w1F4U6Oe7dWhgucMiv87/0+u7UGQ1tEI/oBM2VmuqtXetUCo2WtvcDR2Pm2PzFYAMy8
         nbog==
X-Gm-Message-State: AOAM532BeFxGNFD/NapeTlLvvLfLPpFZjxsZDsCTy+lDDw/LWqOdeIEV
        txByjL4TbITTFI7CH9N3/A==
X-Google-Smtp-Source: ABdhPJx3naABRYycLDyZaLNc9jATj4nWWFoignmpdwVmsfry6IFxJoHtSVMSLWQM/zmhU9XFh+De3A==
X-Received: by 2002:a05:6602:2099:: with SMTP id a25mr11108361ioa.143.1626923242523;
        Wed, 21 Jul 2021 20:07:22 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id g22sm15255979ion.10.2021.07.21.20.07.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jul 2021 20:07:21 -0700 (PDT)
Received: (nullmailer pid 3225181 invoked by uid 1000);
        Thu, 22 Jul 2021 03:07:19 -0000
Date:   Wed, 21 Jul 2021 21:07:19 -0600
From:   Rob Herring <robh@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Marc Zyngier <maz@kernel.org>, linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: serial: 8250: Add Exar compatibles
Message-ID: <20210722030719.GA3225127@robh.at.kernel.org>
References: <20210716225319.1282704-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210716225319.1282704-1-linus.walleij@linaro.org>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Sat, 17 Jul 2021 00:53:19 +0200, Linus Walleij wrote:
> The Intel IXP425 Vulcan board has an Exar XR16L2551 8250-compatible.
> It works like an 8250 but it is always good to specify exactly which
> component we are using. This allows us to specify:
> 
> compatible = "exar,xr16l2551", "ns8250";
> 
> Put in some sibling Exar serial compatibles while we're at it.
> 
> Cc: Marc Zyngier <maz@kernel.org>
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  Documentation/devicetree/bindings/serial/8250.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>

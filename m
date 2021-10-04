Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A993C433F5
	for <linux-serial@archiver.kernel.org>; Mon,  4 Oct 2021 18:28:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B8116139E
	for <linux-serial@archiver.kernel.org>; Mon,  4 Oct 2021 18:28:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235154AbhJDSa1 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 4 Oct 2021 14:30:27 -0400
Received: from mail-oi1-f181.google.com ([209.85.167.181]:46079 "EHLO
        mail-oi1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238360AbhJDSa1 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 4 Oct 2021 14:30:27 -0400
Received: by mail-oi1-f181.google.com with SMTP id v10so22780304oic.12;
        Mon, 04 Oct 2021 11:28:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Gx+bJMYWjDm/EcyN95y7pWBSr8UxHnftYxDVqLErH4g=;
        b=qal+wx2sC6YS4x3xnXjjHArMbbRw271NtNXbW+DB3gl9ogWK/zGXfhTHjs2QH9tH4K
         XnoAFebxv9r38OU9iv7DWM/1MjX7CiSNZu3nRtiPy8Y9Ap7lnoaf1tvDUkSFEjGRe6F3
         KN1bAFZ5bF5/Sm4G+GjxwAoK6DGgb0s1uxseSZixUF/+HPqvj0ewuv02LE/1ARSyvJON
         gsRJgXViCsZFlZpQaLfdu1a9kiOrS9UxpCSoR3natVHc2k8KYNNDq4gPWBH1PMMLGMOK
         EwZanv6vE0RP2wj/kFhbZuxpuss+LYAk/jSyHoKNEYtllUAFuSeJF7x+tYg9asxcbxHe
         BfUw==
X-Gm-Message-State: AOAM530W0y06FK4rjw1O7D62BZYL7axT51vFSSPqBu+grYTtSdAluuYq
        PXYtPMDNS8oqP3Y6x+UMow==
X-Google-Smtp-Source: ABdhPJzSyQB52yS+HqXQJ3UhFIYr4Lbt99pioIxRCBU1yLHerKk1DvSupgYa/oFAI6RzvLdFMvZ00g==
X-Received: by 2002:aca:c6c7:: with SMTP id w190mr14688903oif.96.1633372117759;
        Mon, 04 Oct 2021 11:28:37 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id f17sm2959337ooc.1.2021.10.04.11.28.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Oct 2021 11:28:37 -0700 (PDT)
Received: (nullmailer pid 1612253 invoked by uid 1000);
        Mon, 04 Oct 2021 18:28:36 -0000
Date:   Mon, 4 Oct 2021 13:28:36 -0500
From:   Rob Herring <robh@kernel.org>
To:     Chunyan Zhang <zhang.lyra@gmail.com>
Cc:     Baolin Wang <baolin.wang7@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>, linux-serial@vger.kernel.org,
        devicetree@vger.kernel.org,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 1/3] dt-bindings: arm: Add bindings for Unisoc's UMS512
Message-ID: <YVtH1PRJNdwkQvGW@robh.at.kernel.org>
References: <20210928095229.233572-1-zhang.lyra@gmail.com>
 <20210928095229.233572-2-zhang.lyra@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210928095229.233572-2-zhang.lyra@gmail.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, 28 Sep 2021 17:52:27 +0800, Chunyan Zhang wrote:
> From: Chunyan Zhang <chunyan.zhang@unisoc.com>
> 
> Add bindings for Unisoc's ums512-1h10 board and ums512 SoC.
> 
> Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
> ---
>  Documentation/devicetree/bindings/arm/sprd/sprd.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>

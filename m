Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF539C433F5
	for <linux-serial@archiver.kernel.org>; Wed,  9 Feb 2022 04:08:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243753AbiBIEII (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 8 Feb 2022 23:08:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347764AbiBIEGV (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 8 Feb 2022 23:06:21 -0500
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 413ECC061579;
        Tue,  8 Feb 2022 20:06:19 -0800 (PST)
Received: by mail-oo1-f45.google.com with SMTP id f11-20020a4abb0b000000b002e9abf6bcbcso1193421oop.0;
        Tue, 08 Feb 2022 20:06:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sY39HXAYg9f/PCxHinro5aXMT9t5eK9gckc4VAS6ntE=;
        b=WHnxpiTs5imbHCGf3g8mS1Cbzg7GcaboCwaONvJLSV0EORS1eSZ2kQdi8vFhmr/3wo
         jUQEWL733S1XM7Ngl/Lih4wGNFtsRi7DHzH2MeEm3+v72aAh4TBl0SyyQZct7ehUaVvT
         Q+OvWVK7xfiC+RQgttLt/vz26RCY5//eekkIKS63IYvTp+tS7PHijyDbbe0aiXi+sbCy
         71Lphz5kVPRLkqHrfd2ScRBaFVNUgSUsnCDLkcC9d8tlxum2pFUuz02nXuqi11coIJcs
         rkQYTH/L2F7LuPFVqir6i4oxU1LouV8kZjU75QQXq0tb0wkR6uR1EG/GdUpd8oesEz47
         RVuQ==
X-Gm-Message-State: AOAM533J5egF0HySONhQRMSx0+rPEFch2bB2diC3E2jaga3r+/2bCGx4
        qnJjKynjmziHfosMj/Vaeg==
X-Google-Smtp-Source: ABdhPJw5NrC1vbHuuM6soDlYqbH+QM2jgOrkXqkYI+WzWshA0zBR7IPbRdxrJQxjPHgIoM5EvPhw4w==
X-Received: by 2002:a05:6870:1351:: with SMTP id 17mr156257oac.246.1644379578544;
        Tue, 08 Feb 2022 20:06:18 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id u3sm7286173oao.25.2022.02.08.20.06.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 20:06:17 -0800 (PST)
Received: (nullmailer pid 3635161 invoked by uid 1000);
        Wed, 09 Feb 2022 04:06:17 -0000
Date:   Tue, 8 Feb 2022 22:06:17 -0600
From:   Rob Herring <robh@kernel.org>
To:     Icenowy Zheng <icenowy@nucleisys.com>
Cc:     devicetree@vger.kernel.org, Palmer Dabbelt <palmer@dabbelt.com>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-serial@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-riscv@lists.infradead.org, Albert Ou <aou@eecs.berkeley.edu>
Subject: Re: [PATCH 07/12] dt-bindings: spi: add compatible string for Nuclei
 DemoSoC SPI
Message-ID: <YgM9uSVB2txOtsHZ@robh.at.kernel.org>
References: <20220127151647.2375449-1-icenowy@nucleisys.com>
 <20220127151647.2375449-8-icenowy@nucleisys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220127151647.2375449-8-icenowy@nucleisys.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, 27 Jan 2022 23:16:42 +0800, Icenowy Zheng wrote:
> Nuclei DemoSoC design integrates SPI controllers from SiFive.
> 
> Add a compatible string for these SPI controllers.
> 
> Signed-off-by: Icenowy Zheng <icenowy@nucleisys.com>
> ---
>  Documentation/devicetree/bindings/spi/spi-sifive.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>

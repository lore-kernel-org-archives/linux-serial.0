Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C111C432BE
	for <linux-serial@archiver.kernel.org>; Fri, 13 Aug 2021 17:55:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A1F3610E9
	for <linux-serial@archiver.kernel.org>; Fri, 13 Aug 2021 17:55:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231530AbhHMRzi (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 13 Aug 2021 13:55:38 -0400
Received: from mail-ot1-f47.google.com ([209.85.210.47]:46913 "EHLO
        mail-ot1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231823AbhHMRzR (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 13 Aug 2021 13:55:17 -0400
Received: by mail-ot1-f47.google.com with SMTP id v33-20020a0568300921b0290517cd06302dso184652ott.13;
        Fri, 13 Aug 2021 10:54:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vN1Ro8SFmGGRVeTjvNxQ/6Tj6lw0hqz/g1dXZ9CSndM=;
        b=sWd+QVAlyUKIrTn/1ONRCXlZgbmkzFmYdPY60kzc3sXIlaDY7se8gh9VWxxFRvA6pq
         a825umyOueYOHBVFkWFD3qPXiHhzHSn1tZl3Anye4HMBpUXGTc0cNGy1zPJRQAfy1LRq
         DgHFrA5BuWZ3lgsnXBYaweOwfhnB4URPHp23AcuvYiOckNd+SpvvJfi/3RVm18d0qVQ2
         9RydVnnb4hNvmSOM3O4f8OpopEKzdxd1phLeglmc81OzaI44tNyl5QVt0WM3QHqBrCPG
         9oQvl6A51g14MhdcwB2wIdm3OEgVHOuknsNyFHxWm50scQJ1iG2Q9ILJIXIMAQHFkM4K
         yuzw==
X-Gm-Message-State: AOAM5323n/K7MwUdYfsp9l9XvVH5l8qi/Qp4k3SUS2X8y80Jz7fFKpTj
        JRlpvwkRbnrbPFQ/owMClg==
X-Google-Smtp-Source: ABdhPJzhY2HLgGmX5bWhBfVNpTEOsDQXalq1Wmpn/2g6XvjlE+aRHdxHa+So6xPNK5oulc/3HccBSQ==
X-Received: by 2002:a9d:729a:: with SMTP id t26mr3085115otj.28.1628877242437;
        Fri, 13 Aug 2021 10:54:02 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id k13sm458822oik.40.2021.08.13.10.54.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Aug 2021 10:54:01 -0700 (PDT)
Received: (nullmailer pid 3757698 invoked by uid 1000);
        Fri, 13 Aug 2021 17:53:59 -0000
Date:   Fri, 13 Aug 2021 12:53:59 -0500
From:   Rob Herring <robh@kernel.org>
To:     Chester Lin <clin@suse.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Oleksij Rempel <linux@rempel-privat.de>,
        Stefan Riedmueller <s.riedmueller@phytec.de>,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        Li Yang <leoyang.li@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Matteo Lisi <matteo.lisi@engicam.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Tim Harvey <tharvey@gateworks.com>,
        Jagan Teki <jagan@amarulasolutions.com>, s32@nxp.com,
        catalin-dan.udma@nxp.com, bogdan.hamciuc@nxp.com,
        bogdan.folea@nxp.com, ciprianmarian.costea@nxp.com,
        radu-nicolae.pirea@nxp.com, ghennadi.procopciuc@nxp.com,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        "Ivan T . Ivanov" <iivanov@suse.de>, "Lee, Chun-Yi" <jlee@suse.com>
Subject: Re: [PATCH 1/8] dt-bindings: arm: fsl: add NXP S32G2 boards
Message-ID: <YRaxt1LCF+hWaMJU@robh.at.kernel.org>
References: <20210805065429.27485-1-clin@suse.com>
 <20210805065429.27485-2-clin@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210805065429.27485-2-clin@suse.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, Aug 05, 2021 at 02:54:22PM +0800, Chester Lin wrote:
> Add bindings for S32G2's evaluation board (S32G-VNP-EVB) and reference
> design 2 board ( S32G-VNP-RDB2).
> 
> Signed-off-by: Chester Lin <clin@suse.com>
> ---
>  Documentation/devicetree/bindings/arm/fsl.yaml | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
> index e2097011c4b0..3914aa09e503 100644
> --- a/Documentation/devicetree/bindings/arm/fsl.yaml
> +++ b/Documentation/devicetree/bindings/arm/fsl.yaml
> @@ -983,6 +983,13 @@ properties:
>            - const: solidrun,lx2160a-cex7
>            - const: fsl,lx2160a
>  
> +      - description: S32G2 based Boards
> +        items:
> +          - enum:
> +              - fsl,s32g274a-evb
> +              - fsl,s32g274a-rdb2
> +          - const: fsl,s32g2

Given this is an entirely different family from i.MX and new?, shouldn't 
it use 'nxp' instead of 'fsl'? Either way,

Acked-by: Rob Herring <robh@kernel.org>

Rob

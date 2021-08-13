Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56F69C4338F
	for <linux-serial@archiver.kernel.org>; Fri, 13 Aug 2021 17:49:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3388E610CC
	for <linux-serial@archiver.kernel.org>; Fri, 13 Aug 2021 17:49:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231823AbhHMRtv (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 13 Aug 2021 13:49:51 -0400
Received: from mail-oi1-f180.google.com ([209.85.167.180]:33551 "EHLO
        mail-oi1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229919AbhHMRtu (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 13 Aug 2021 13:49:50 -0400
Received: by mail-oi1-f180.google.com with SMTP id h11so17127475oie.0;
        Fri, 13 Aug 2021 10:49:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=WtjHQZz715RMWTTlcj47+tPX67303+dgwGOAMMRRmY4=;
        b=IuGvOARZBEcTYPI40mxR8x79MebI3+tgHteSN1QAun5/x8vCPAF/Vuq6yGJWrZwtvx
         VfnKNK0rWa+VAveSJ+Zx5Mq0sAJNAp9Rj2febjo//EqrgAdivmg9jKkcWVzbCK0ODaOV
         j+5g38x8zrz58PXdxYzn2hS5QWywFzGC+WsPe7ii79PAe/9gqX+QWO4ttFqxcmAzH+Vk
         jbEsrIVI6Nve2bNs+OjpgKIr4KGWgAZmz96vCSdEA3VsTbbpqSwQ/+FQfVAB2yDXUcm7
         BOvsfGTQsU5rA8FwYPha6YLt50pnPlsn/c7z69EididGa70tWyNHiFEfhD5CbaCGUxby
         hg1g==
X-Gm-Message-State: AOAM531T6r9wlpg7MhvbdYQJwkerStNs20SBDJVNJ+DXm783JbnMJfCM
        GKxmML3RZAfP1eB77ODg2Q==
X-Google-Smtp-Source: ABdhPJwwCjLSQAefXV3nYBOEwr+SjBPgFMn1570lNEykCto3BMPvBwiUzWq/n3GYDxqWxC/KbbBd+w==
X-Received: by 2002:aca:6109:: with SMTP id v9mr3054359oib.147.1628876943137;
        Fri, 13 Aug 2021 10:49:03 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id l7sm430630otk.79.2021.08.13.10.49.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Aug 2021 10:49:02 -0700 (PDT)
Received: (nullmailer pid 3749844 invoked by uid 1000);
        Fri, 13 Aug 2021 17:49:00 -0000
Date:   Fri, 13 Aug 2021 12:49:00 -0500
From:   Rob Herring <robh@kernel.org>
To:     Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>
Cc:     Chester Lin <clin@suse.com>, s32@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
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
        Jagan Teki <jagan@amarulasolutions.com>,
        catalin-dan.udma@nxp.com, bogdan.hamciuc@nxp.com,
        bogdan.folea@nxp.com, ciprianmarian.costea@nxp.com,
        radu-nicolae.pirea@nxp.com, ghennadi.procopciuc@nxp.com,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "Ivan T . Ivanov" <iivanov@suse.de>, "Lee, Chun-Yi" <jlee@suse.com>
Subject: Re: [PATCH 1/8] dt-bindings: arm: fsl: add NXP S32G2 boards
Message-ID: <YRawjOas2FixC5Kp@robh.at.kernel.org>
References: <20210805065429.27485-1-clin@suse.com>
 <20210805065429.27485-2-clin@suse.com>
 <bcb3ddd8-23c9-81c9-7d05-b475311068ec@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bcb3ddd8-23c9-81c9-7d05-b475311068ec@suse.de>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, Aug 12, 2021 at 05:46:16PM +0200, Andreas Färber wrote:
> Hello Rob and NXP,
> 
> On 05.08.21 08:54, Chester Lin wrote:
> > Add bindings for S32G2's evaluation board (S32G-VNP-EVB) and reference
> > design 2 board ( S32G-VNP-RDB2).
> > 
> > Signed-off-by: Chester Lin <clin@suse.com>
> > ---
> >  Documentation/devicetree/bindings/arm/fsl.yaml | 7 +++++++
> >  1 file changed, 7 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
> > index e2097011c4b0..3914aa09e503 100644
> > --- a/Documentation/devicetree/bindings/arm/fsl.yaml
> > +++ b/Documentation/devicetree/bindings/arm/fsl.yaml
> > @@ -983,6 +983,13 @@ properties:
> >            - const: solidrun,lx2160a-cex7
> >            - const: fsl,lx2160a
> >  
> > +      - description: S32G2 based Boards
> > +        items:
> > +          - enum:
> > +              - fsl,s32g274a-evb
> > +              - fsl,s32g274a-rdb2
> 
> @Rob: Should for new boards the description: syntax be used also for
> enums? Or just at SoC level, and for board enums still traditional #
> comments?

It's up to how the platform wants to do it.

Rob

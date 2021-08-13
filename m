Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 658C8C4338F
	for <linux-serial@archiver.kernel.org>; Fri, 13 Aug 2021 18:11:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 47241610CC
	for <linux-serial@archiver.kernel.org>; Fri, 13 Aug 2021 18:11:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232468AbhHMSLn (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 13 Aug 2021 14:11:43 -0400
Received: from mail-ot1-f54.google.com ([209.85.210.54]:40516 "EHLO
        mail-ot1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbhHMSLn (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 13 Aug 2021 14:11:43 -0400
Received: by mail-ot1-f54.google.com with SMTP id h63-20020a9d14450000b02904ce97efee36so13036558oth.7;
        Fri, 13 Aug 2021 11:11:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=LPzED54xeKgTV0uzpxN25ycvgJ7+FnU0XzwWfHIGp+M=;
        b=dDJgmPyy1TLYFPtdQcVksT1WJVApRCL7jHpWiOrCZbcZ2T7D8pR1p/bxM61F9VPxP1
         8v6OKbFJPQSpJ3VqLmgFn0Pf3uNjK/hMfkLeNVeuTvDXF5yuoXu2H+xwe/REosUJ8BMy
         F+AQLLvW73JDsgX0o5tZmwEK/xl4IdXL+7HOuvhagtUNaCi1VOelv+LwYWsAr4OErRcL
         bJz/r1At15AH4WAVrQl+vY8mqeYasKIsyuG2K8IS+6eEQQPVNzAAUzlca6S0+6GljXlZ
         rxBsicw6JkV/9vUNXA2y+nsNZtjdbFtFplYYjaSPlJ9cl1Ox3iE+/YAUjUd7fsmZWTcF
         UZrw==
X-Gm-Message-State: AOAM531ykPe7TbayIhATpUXQvgbdtkj9ap5vfk74T+2kCicMRXhdhR7g
        UOaWAb1fsU0deqnQ8yxdlQ==
X-Google-Smtp-Source: ABdhPJz8TQwhStwIV9j8ES8mQkAGtJtCOHamui/b/Nfn3PlJ7eO4OR+QBnqqGox4c2KtcK7WKRRqGA==
X-Received: by 2002:a9d:5e5:: with SMTP id 92mr3056054otd.193.1628878275680;
        Fri, 13 Aug 2021 11:11:15 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id g13sm218710oos.39.2021.08.13.11.11.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Aug 2021 11:11:15 -0700 (PDT)
Received: (nullmailer pid 3786586 invoked by uid 1000);
        Fri, 13 Aug 2021 18:11:13 -0000
Date:   Fri, 13 Aug 2021 13:11:13 -0500
From:   Rob Herring <robh@kernel.org>
To:     Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>
Cc:     Chester Lin <clin@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>, s32@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org,
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
Subject: Re: [PATCH 3/8] dt-bindings: serial: fsl-linflexuart: Add compatible
 for S32G2
Message-ID: <YRa1wUW0Dp4GhZYx@robh.at.kernel.org>
References: <20210805065429.27485-1-clin@suse.com>
 <20210805065429.27485-4-clin@suse.com>
 <96c02ee6-cd3a-59df-0b3b-1632bb355019@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <96c02ee6-cd3a-59df-0b3b-1632bb355019@suse.de>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, Aug 12, 2021 at 06:27:57PM +0200, Andreas Färber wrote:
> On 05.08.21 08:54, Chester Lin wrote:
> > Add a compatible string for the uart binding of NXP S32G2 platforms. Here
> > we use "s32v234-linflexuart" as fallback since the current linflexuart
> > driver still works on S32G2.
> > 
> > Signed-off-by: Chester Lin <clin@suse.com>
> > ---
> >  .../bindings/serial/fsl,s32-linflexuart.yaml  | 26 ++++++++++++++++---
> >  1 file changed, 22 insertions(+), 4 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/serial/fsl,s32-linflexuart.yaml b/Documentation/devicetree/bindings/serial/fsl,s32-linflexuart.yaml
> > index acfe34706ccb..e731f3f6cea4 100644
> > --- a/Documentation/devicetree/bindings/serial/fsl,s32-linflexuart.yaml
> > +++ b/Documentation/devicetree/bindings/serial/fsl,s32-linflexuart.yaml
> > @@ -21,10 +21,20 @@ allOf:
> >  
> >  properties:
> >    compatible:
> > -    description: The LINFlexD controller on S32V234 SoC, which can be
> > -      configured in UART mode.
> > -    items:
> > -      - const: fsl,s32v234-linflexuart
> > +    minItems: 1
> > +    maxItems: 2
> 
> Are these necessary for oneOf?
> 
> > +    oneOf:
> > +      - description: The LINFlexD controller on S32G2 SoC, which can be
> > +          configured in UART mode.
> > +        items:
> > +          - enum:
> > +              - fsl,s32g2-linflexuart
> > +          - const: fsl,s32v234-linflexuart
> 
> This reads inconsistent to me: Either this oneOf is for S32G2 only, then
> please turn the enum into a const. Or change the description to "on SoCs
> compatible with S32V234" if we expect the enum list to grow.
> 
> I believe the idea here was to avoid unnecessary driver compatible and
> earlycon compatible additions, while preparing for eventual quirks
> specific to S32G2.
> 
> @NXP: Should this be s32g2- like above or s32g274a- specifically? Do you
> agree this is a useful thing to prepare here, as opposed to using only
> s32v234- in the s32g2* DT?
> 
> I assume the ordering is done alphabetically as S32G < S32V;
> alternatively we might order S32V234 first and then the compatible ones.
> 
> > +
> > +      - description: The LINFlexD controller on S32V234 SoC, which can be
> > +          configured in UART mode.
> > +        items:
> > +          - const: fsl,s32v234-linflexuart
> 
> To minimize this S32G2 patch, would it be valid to do oneOf for the
> single S32V in the preceding patch already? Then we would avoid the text
> movement and re-indentation above and more easily see the lines newly
> getting added for S32G2.
> 
> >  
> >    reg:
> >      maxItems: 1
> > @@ -41,8 +51,16 @@ unevaluatedProperties: false
> >  
> >  examples:
> >    - |
> > +    /* S32V234 */
> 
> Could this be:
>   - description: S32V234
>     |
> ?

No, that would not be valid json-schema.

Rob

Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98FFBC4338F
	for <linux-serial@archiver.kernel.org>; Fri, 13 Aug 2021 18:04:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6CA0C610F7
	for <linux-serial@archiver.kernel.org>; Fri, 13 Aug 2021 18:04:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229829AbhHMSFO (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 13 Aug 2021 14:05:14 -0400
Received: from mail-oi1-f174.google.com ([209.85.167.174]:34337 "EHLO
        mail-oi1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbhHMSFO (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 13 Aug 2021 14:05:14 -0400
Received: by mail-oi1-f174.google.com with SMTP id t128so17105396oig.1;
        Fri, 13 Aug 2021 11:04:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=3jaTA2yjA5SS7lnLCvNvkVrtuwgO6LNiLl2iqDgDWV4=;
        b=uCGjIWE5LKuPlUf+YPEBXQHftPADeFPx0yEu1HeA4vRxUXFmQgqPLYSeQmeKGwpb22
         D15r/ud8p360FpvUPZ+UP2jN9PsalDwdwTcmrtzU/owSj7SIZeFesdkayUCqZ/PfZuOo
         zWcroDxrO9KczfRxiiNmLHA0hmdkt7KhScYVbLt+vTDxfJircs2fQegMQCi0MnTlGIuA
         e3VYQHRPotxYTGwdnX62MsEs9JZLfBtqvSV/2Jk27kFBLmLILfaGlP0Vq/kUEsOmJ43J
         kjgkhyNA6a6P5tB1Fp5fHKor2E6Z7qOrmtXuwdgpppFxD/sNXZYiF1GeAIZMol4nWUfH
         tAmw==
X-Gm-Message-State: AOAM533tHfemG1pmfIMbVw/uUgwX9EswbitozjkstnWZ90GOCZBDVABO
        GbB6zM2umbUktjSlVX1x5w==
X-Google-Smtp-Source: ABdhPJxKTTFelgMODfsY7TL+aSBbhOUZ0n08lwXexJDmW/G2zuPwOTWBOSRFwEMoGry544zrWZ+ucA==
X-Received: by 2002:a05:6808:20a:: with SMTP id l10mr3205935oie.20.1628877886916;
        Fri, 13 Aug 2021 11:04:46 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id j2sm494191oia.21.2021.08.13.11.04.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Aug 2021 11:04:46 -0700 (PDT)
Received: (nullmailer pid 3776476 invoked by uid 1000);
        Fri, 13 Aug 2021 18:04:43 -0000
Date:   Fri, 13 Aug 2021 13:04:43 -0500
From:   Rob Herring <robh@kernel.org>
To:     Chester Lin <clin@suse.com>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-serial@vger.kernel.org,
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
        "Ivan T . Ivanov" <iivanov@suse.de>, "Lee, Chun-Yi" <jlee@suse.com>
Subject: Re: [PATCH 2/8] dt-bindings: serial: fsl-linflexuart: convert to
 json-schema format
Message-ID: <YRa0O9YNpHTsgi39@robh.at.kernel.org>
References: <20210805065429.27485-1-clin@suse.com>
 <20210805065429.27485-3-clin@suse.com>
 <1ff13837-e6ca-c476-376d-b4f80450a259@suse.de>
 <YRZTSJPFLFFIR+gx@linux-8mug>
 <0b42dc7e-a7c1-fe41-e39a-89627d44cbe4@kernel.org>
 <YRZa1ZX0gJb/yDrw@linux-8mug>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YRZa1ZX0gJb/yDrw@linux-8mug>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, Aug 13, 2021 at 07:43:17PM +0800, Chester Lin wrote:
> On Fri, Aug 13, 2021 at 01:28:40PM +0200, Krzysztof Kozlowski wrote:
> > On 13/08/2021 13:11, Chester Lin wrote:
> > > Hi Andreas,
> > > 
> > > On Thu, Aug 12, 2021 at 06:04:44PM +0200, Andreas Färber wrote:
> > >> On 05.08.21 08:54, Chester Lin wrote:
> > >>> Convert the FSL LINFlexD UART binding to json-schema.
> > >>>
> > >>> Signed-off-by: Chester Lin <clin@suse.com>
> > >>> ---
> > >>>  .../bindings/serial/fsl,s32-linflexuart.txt   | 22 ---------
> > >>>  .../bindings/serial/fsl,s32-linflexuart.yaml  | 48 +++++++++++++++++++
> > >>>  2 files changed, 48 insertions(+), 22 deletions(-)
> > >>>  delete mode 100644 Documentation/devicetree/bindings/serial/fsl,s32-linflexuart.txt
> > >>>  create mode 100644 Documentation/devicetree/bindings/serial/fsl,s32-linflexuart.yaml
> > >>
> > >> Thanks for your effort, Chester.
> > >>
> > >>> diff --git a/Documentation/devicetree/bindings/serial/fsl,s32-linflexuart.txt b/Documentation/devicetree/bindings/serial/fsl,s32-linflexuart.txt
> > >>> deleted file mode 100644
> > >>> index f1bbe0826be5..000000000000
> > >>> --- a/Documentation/devicetree/bindings/serial/fsl,s32-linflexuart.txt
> > >>> +++ /dev/null
> > >>> @@ -1,22 +0,0 @@
> > >>> -* Freescale LINFlexD UART
> > >>> -
> > >>> -The LINFlexD controller implements several LIN protocol versions, as well as
> > >>> -support for full-duplex UART communication through 8-bit and 9-bit frames.
> > >>> -
> > >>> -See chapter 47 ("LINFlexD") in the reference manual[1].
> > >>> -
> > >>> -Required properties:
> > >>> -- compatible :
> > >>> -  - "fsl,s32v234-linflexuart" for LINFlexD configured in UART mode, which
> > >>> -    is compatible with the one integrated on S32V234 SoC
> > >>> -- reg : Address and length of the register set for the device
> > >>> -- interrupts : Should contain uart interrupt
> > >>> -
> > >>> -Example:
> > >>> -uart0: serial@40053000 {
> > >>> -	compatible = "fsl,s32v234-linflexuart";
> > >>> -	reg = <0x0 0x40053000 0x0 0x1000>;
> > >>> -	interrupts = <0 59 4>;
> > >>> -};
> > >>> -
> > >>> -[1] https://www.nxp.com/webapp/Download?colCode=S32V234RM
> > >>> diff --git a/Documentation/devicetree/bindings/serial/fsl,s32-linflexuart.yaml b/Documentation/devicetree/bindings/serial/fsl,s32-linflexuart.yaml
> > >>> new file mode 100644
> > >>> index 000000000000..acfe34706ccb
> > >>> --- /dev/null
> > >>> +++ b/Documentation/devicetree/bindings/serial/fsl,s32-linflexuart.yaml
> > >>> @@ -0,0 +1,48 @@
> > >>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > >>
> > >> Since this is dual-licensed and BSD-2-Clause would seem compatible with
> > >> GPLv3, this could probably be s/GPL-2.0-only/GPL-2.0-or-later/ ? Not a
> > >> blocker.
> > > 
> > > There's no license identifier in the original file so it's not a problem to
> > > choose "GPL-2.0-or-later".
> > 
> > That is not entirely correct. If there is no explicit license in the
> > file, it's kernel's default so GPL-2.0-only. You cannot relicense
> > derivative work without getting permission from authors and copyright
> > holders.
> > 
> > However if you did not copy the text/description from original bindings,
> > your work won't be derivative so you can relicense it.
> > 
> 
> Sorry for my misunderstanding and thanks for the reminder.

TBC, please try and get permission to relicense. The single author was 
from NXP so changing the license here just needs the okay from any NXP 
employee.

But use 'GPL-2.0-only' not 'GPL-2.0-or-later' please. As gregkh says,
are you okay with GPLv4, v5, etc.?

Rob

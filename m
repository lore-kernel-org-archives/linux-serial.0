Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3896BC433F5
	for <linux-serial@archiver.kernel.org>; Mon, 28 Mar 2022 13:26:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234265AbiC1N2f (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 28 Mar 2022 09:28:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236582AbiC1N2c (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 28 Mar 2022 09:28:32 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2126B5E17F;
        Mon, 28 Mar 2022 06:26:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 7C556CE13BA;
        Mon, 28 Mar 2022 13:26:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5D38C34111;
        Mon, 28 Mar 2022 13:26:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648474006;
        bh=AQvdABq5Hxq1MNktjBiqDB3yfDLoZjajlprb/I71spY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Jh44AB6PQwrKHG1yUqmMlZ8J//ua/zoX2E/ACH8+sKC3qMdghNqCsCqgjFeu3t/K1
         8FUM3794iaXlKu6jsrtnADFhH4EyktPQVZsi2ROhv3/5j+MpTF76oVppqdsmJ9Ya1D
         0fRke3GPSH+DSv1OIWZDxWxjXYVkcpkSm7nnifUL0KR4CJq6XY+c0PrGPydm7MTmPY
         zhilxaAcN5G5jaABuxRPfcIBtzoQulPxZYLU5wU6QD8bAHNIj4vUdj4Ot7c+Nlmw8A
         iJdKHm4nxLy/JT40LZhHx/3tHVgpLlmkpQywuqbQzszKI8SpVaGELrJ6J3+f+Asl8x
         gnbj16r40HeRg==
Received: by mail-ej1-f53.google.com with SMTP id pv16so28730866ejb.0;
        Mon, 28 Mar 2022 06:26:46 -0700 (PDT)
X-Gm-Message-State: AOAM530/gJ0cABwW33CjpV+/3o/Yw7J6kMu5r3D3dMs1Rr336qqga48A
        aBFwlkBuTWHpmS7kLKIWQa023CuLgWE4652NyQ==
X-Google-Smtp-Source: ABdhPJyGhH7lmYwMaaU/tzHGQoNYL3u81M6M0BdaLpzWBmjMU0br1//SVrBhdo/wvqx9JKvOvdgSdTq1sPDKtP1oAT0=
X-Received: by 2002:a17:906:5418:b0:6df:a07f:764b with SMTP id
 q24-20020a170906541800b006dfa07f764bmr26681735ejo.27.1648474005064; Mon, 28
 Mar 2022 06:26:45 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1637061057.git.shubhrajyoti.datta@xilinx.com>
 <e1d6913bfe5ce023d7f6ea106d0359142063e694.1637061057.git.shubhrajyoti.datta@xilinx.com>
 <YaVPYiGmDsqY+1at@robh.at.kernel.org> <DM6PR02MB663589B3489C53A34DC25A31AA719@DM6PR02MB6635.namprd02.prod.outlook.com>
 <MN2PR02MB6640017950EFB0FD21D2AD91AA339@MN2PR02MB6640.namprd02.prod.outlook.com>
 <DM6PR02MB66352597DBF172ACC5307274AA179@DM6PR02MB6635.namprd02.prod.outlook.com>
In-Reply-To: <DM6PR02MB66352597DBF172ACC5307274AA179@DM6PR02MB6635.namprd02.prod.outlook.com>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 28 Mar 2022 08:26:33 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLV3De0O2WDq=w_CQbvAiJVvQ-=V9XuC1tJyZNLyneDZw@mail.gmail.com>
Message-ID: <CAL_JsqLV3De0O2WDq=w_CQbvAiJVvQ-=V9XuC1tJyZNLyneDZw@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: serial: pl011: Add 'arm,xlnx-uart'
To:     Shubhrajyoti Datta <shubhraj@xilinx.com>
Cc:     "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Raviteja Narayanam <rna@xlnx.xilinx.com>,
        Srinivas Goud <sgoud@xilinx.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Mar 22, 2022 at 5:59 AM Shubhrajyoti Datta <shubhraj@xilinx.com> wrote:
>
> <snip>
> > > > > diff --git a/Documentation/devicetree/bindings/serial/pl011.yaml
> > > > > b/Documentation/devicetree/bindings/serial/pl011.yaml
> > > > > index 5ea00f8a283d..6c73923dd15e 100644
> > > > > --- a/Documentation/devicetree/bindings/serial/pl011.yaml
> > > > > +++ b/Documentation/devicetree/bindings/serial/pl011.yaml
> > > > > @@ -24,9 +24,13 @@ select:
> > > > >
> > > > >  properties:
> > > > >    compatible:
> > > > > -    items:
> > > > > -      - const: arm,pl011
> > > > > -      - const: arm,primecell
> > > > > +    oneOf:
> > > > > +      - items:
> > > > > +          - const: arm,pl011
> > > > > +          - const: arm,primecell
> > > > > +      - items:
> > > > > +          - const: arm,pl011
> > > > > +          - const: arm,xlnx-uart # xilinx uart as platform device
> > > >
> > > > 'arm,primecell' means the block has ID registers. Are you saying
> > > > this implementation doesn't?
> > >
> > > The ID registers do not have any Xilinx specific identifiers.
> > > However there are differences  like 32-bit access.
> >
> > Hope that the current approach is fine with you.
>
> Could you please guide  how to go about it.

No, I don't know what the differences are in your h/w. You have ID
registers, but changed the IP and didn't change the ID registers? How
has the IP changed?

Rob

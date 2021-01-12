Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-22.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74193C4332B
	for <linux-serial@archiver.kernel.org>; Tue, 12 Jan 2021 10:23:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 42FFC23107
	for <linux-serial@archiver.kernel.org>; Tue, 12 Jan 2021 10:23:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392781AbhALKX0 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 12 Jan 2021 05:23:26 -0500
Received: from bmail1.ministro.hu ([5.249.150.236]:42984 "EHLO
        bmail1.ministro.hu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730233AbhALKX0 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 12 Jan 2021 05:23:26 -0500
Received: from localhost (localhost [127.0.0.1])
        by bmail1.ministro.hu (Postfix) with ESMTP id 6025011FFA6;
        Tue, 12 Jan 2021 11:22:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ministro.hu;
        s=201804; t=1610446964;
        bh=6ZmQ4K4IK4r/5AhzLPeguGG1gL7UqmrMEnjNlnN7NDQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nk1ka4EAG4sgjzLsGcKbRwkh5mLBl7A3el1Db1+YTR3cLEyZJ8EC2D79cg2h87L1W
         qAy41W5/4r09PpUA4QS1+LtLuAlTyeb+8gLiOzal9zGj3If3wR/fnX0Of652oegVcd
         GP8hZRSm+8Rf9w7a8rMf7Kitu4cXQfXMGxToCqcVhOlqyTL0t39JrmbEFOY8pwoAWf
         HgS5gISj6c/ny03/Rt4SxijSaM3LuYwT+sW3ARIW8IogSkz/c+1gjScDmkwPG/3CXi
         Gv/zQIptQR8DpI2SoN/aBrKVDpfPEHTS7iXPcB4N9Wim9FjJCUtDhm8IqO/LEtpwMi
         vNCsssDg0PCyA==
X-Virus-Scanned: Debian amavisd-new at ministro.hu
Received: from bmail1.ministro.hu ([127.0.0.1])
        by localhost (bmail1.ministro.hu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id DtMLH2blwxaI; Tue, 12 Jan 2021 11:22:17 +0100 (CET)
Received: from dev (localhost [127.0.0.1])
        by bmail1.ministro.hu (Postfix) with ESMTPSA id 166AD11FFA3;
        Tue, 12 Jan 2021 11:22:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ministro.hu;
        s=201804; t=1610446937;
        bh=6ZmQ4K4IK4r/5AhzLPeguGG1gL7UqmrMEnjNlnN7NDQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Q9ZRbowxzbNmq9Clk37PT8/DS/WZK4S81KcWpRrk6PVTEkM6G5agaSSwKFzaXjm7T
         d/ghdCnNH3r4/KNDMYZdjaaDd1lSiLHn5td+nR+sPi6a7X2R2vb70+sOd8IJMClX57
         0NOGgAUJ7csIbOoaWW5IynD4sgAOl9kd8XdsaDeMBgCwsjjzREUc4CKYGFYAq3B+2g
         x0tDoKlWz/65oIq8If/KA/C5v0kntQkxiSgS7p3t9i5M3Ig4kYdvvVJFZjOliCgLdQ
         WqCjVvXYXP/ML2dmAMNavJKdkp/7kBhHXP4sx/hfm9pT4PMpDkyVLPYX3g5UT2rwLf
         NxM8nI5aajYCA==
Date:   Tue, 12 Jan 2021 10:22:15 +0000
From:   =?iso-8859-1?Q?J=F3zsef_Horv=E1th?= <info@ministro.hu>
To:     Rob Herring <robh@kernel.org>
Cc:     'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>,
        'Jiri Slaby' <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7,2/2] dt: bindings: add silabs,si4455 schema
Message-ID: <20210112102215.GA14292@dev>
References: <20210105103027.GA15137@dev>
 <20210111233048.GA3252430@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210111233048.GA3252430@robh.at.kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, Jan 11, 2021 at 05:30:48PM -0600, Rob Herring wrote:
> On Tue, Jan 05, 2021 at 10:30:29AM +0000, József Horváth wrote:
> > This is a device tree schema for serial port driver for
> >  Silicon Labs Si4455 Sub-GHz transciver.
> > 
> > Datasheet: https://www.silabs.com/documents/public/data-sheets/Si4455.pdf
> > 
> > Guide: https://github.com/dministro/linux-serial-si4455
> > 
> > Signed-off-by: Jozsef Horvath <info@ministro.hu>
> > ---
> > 
> > changes v1:
> >  - fixed: dt: bindings: rename sdn-gpios to shutdown-gpios
> > 
> > changes v3:
> >  - fixed: dt: bindings: silabs,si4455: more detailed description
> >  - added: dt: bindings: silabs,si4455: properties silabs,package-size,
> >    silabs,tx-channel, silabs,rx-channel, silabs,ez-config
> > 
> > changes v4:
> >  - fixed: dt: bindings: silabs,si4455: $id
> >    from http://devicetree.org/schemas/serial/silabs,si4455.yaml
> >    to http://devicetree.org/schemas/staging/serial/silabs,si4455.yaml
> > 
> > changes v5:
> >  - fixed: dt: bindings: silabs,si4455: $id
> >    from http://devicetree.org/schemas/staging/serial/silabs,si4455.yaml
> >    to http://devicetree.org/schemas/serial/silabs,si4455.yaml
> >  - fixed: dt: bindings: silabs,si4455: serial.yaml reference added
> > 
> > changes v7:
> >  - added: dt: bindings: silabs,si4455: silabs,tx-timeout property definition
> > ---
> >  .../bindings/serial/silabs,si4455.yaml        | 105 ++++++++++++++++++
> >  1 file changed, 105 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/serial/silabs,si4455.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/serial/silabs,si4455.yaml b/Documentation/devicetree/bindings/serial/silabs,si4455.yaml
> > new file mode 100644
> > index 000000000000..8ba4956064b4
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/serial/silabs,si4455.yaml
> > @@ -0,0 +1,105 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: "http://devicetree.org/schemas/serial/silabs,si4455.yaml#"
> > +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> > +
> > +title: Silicon Labs Si4455 device tree bindings
> > +
> > +  silabs,rx-channel:
> > +    description:
> > +      Radio receive channel selection.
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    maximum: 255
> > +    minimum: 0
> > +
> > +  silabs,tx-timeout:
> > +    description:
> > +      Radio transmit timeout(ms)
> 
> Use a unit suffix as defined in property-units.txt.
> 
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> 
> With that, you can drop the type.
>

Thank you for suggestion.
 
> > +    maximum: 1000
> > +    minimum: 1
> > +
> > +  firmware-name:
> > +    description:
> > +      Radio configuration data file name.
> > +    $ref: /schemas/types.yaml#/definitions/string
> > +    items:
> > +      pattern: ^[0-9a-z\._\-]{1,255}$
> > +
> > +    };
> > +...
> > -- 
> > 2.17.1
> > 

Üdvözlettel / Best regards:
József Horváth


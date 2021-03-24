Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DBB0C433E2
	for <linux-serial@archiver.kernel.org>; Wed, 24 Mar 2021 17:42:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EDC5761A29
	for <linux-serial@archiver.kernel.org>; Wed, 24 Mar 2021 17:42:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237166AbhCXRlg (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 24 Mar 2021 13:41:36 -0400
Received: from mail-il1-f172.google.com ([209.85.166.172]:39845 "EHLO
        mail-il1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237223AbhCXRlG (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 24 Mar 2021 13:41:06 -0400
Received: by mail-il1-f172.google.com with SMTP id y17so10485401ila.6;
        Wed, 24 Mar 2021 10:41:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qx4EDxzhGUtC2AJPebvPB3YgXI61L9lTaX2dRhdfrOs=;
        b=LoBoJ2wgH4HU6fdMLj4ssol+A9Oxukmvi5/88HJbv/pJGVkddNkQozTEvSYqK+WJI0
         Uga+A/3e0Tykw4/R3PNWHRJRu9dR7EEFEU4vN6trSTqzoexxjDvD6qac7rYbbTks/bZV
         PtJwJCTuHtf//+l2KoISLWuZzUHMLcgRQGrinugygqH5azhn/VGzWimke7MvZuUAKfMW
         RKqi0Nrb5PEupBVNNWhbJeJCjlkCZkxCzXETU3toVJhH4lwfjcxAvIavjJLZo9gKjOw5
         lV4oJM164F/yCytdfcVTmN3kYR9IIHorrK0D/S24tPBMCes4pj45MAyBCrOw7te8PRVC
         xqww==
X-Gm-Message-State: AOAM530M9E/2sBDgltwvTtmkq0MN4UPQ1kNv8vKD3pOOgIqg5AnmHijL
        rzrzAY2kjzD3MXRXGMysFw==
X-Google-Smtp-Source: ABdhPJzUTPtzniambejrX61FdLot/3D9UY/ew426v7dAuHtPZCvAW3cB1z4iI77ZW9vSrEyIO6tvcw==
X-Received: by 2002:a92:7d0d:: with SMTP id y13mr3637182ilc.269.1616607665895;
        Wed, 24 Mar 2021 10:41:05 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id h13sm1334941ila.82.2021.03.24.10.41.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Mar 2021 10:41:01 -0700 (PDT)
Received: (nullmailer pid 3309184 invoked by uid 1000);
        Wed, 24 Mar 2021 17:40:59 -0000
Date:   Wed, 24 Mar 2021 11:40:59 -0600
From:   Rob Herring <robh@kernel.org>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        gregkh@linuxfoundation.org, devicetree@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: serial: amlogic, meson-uart: add
 amlogic, uart-fifosize property
Message-ID: <20210324174059.GA3308031@robh.at.kernel.org>
References: <20210315083459.359773-1-narmstrong@baylibre.com>
 <20210315083459.359773-2-narmstrong@baylibre.com>
 <CAFBinCA1WhtWLEfJ-QyBbZpsY75r=su6uzyWamY6nHOQ+HYvAw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFBinCA1WhtWLEfJ-QyBbZpsY75r=su6uzyWamY6nHOQ+HYvAw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Mar 23, 2021 at 10:33:15PM +0100, Martin Blumenstingl wrote:
>  Hi Neil,
> 
> On Mon, Mar 15, 2021 at 9:37 AM Neil Armstrong <narmstrong@baylibre.com> wrote:
> >
> > On most of the Amlogic SoCs, the first UART controller in the "Everything-Else"
> > power domain has 128bytes of RX & TX FIFO, so add an optional property to describe
> do we still need wrapping of long lines in commit messages?
> if so I think the line above is too long
> 
> > a different FIFO size from the other ports (64bytes).
> >
> > Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> 
> one additional note below
> 
> > ---
> >  .../devicetree/bindings/serial/amlogic,meson-uart.yaml      | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/serial/amlogic,meson-uart.yaml b/Documentation/devicetree/bindings/serial/amlogic,meson-uart.yaml
> > index 75ebc9952a99..e0a742112783 100644
> > --- a/Documentation/devicetree/bindings/serial/amlogic,meson-uart.yaml
> > +++ b/Documentation/devicetree/bindings/serial/amlogic,meson-uart.yaml
> > @@ -55,6 +55,12 @@ properties:
> >        - const: pclk
> >        - const: baud
> >
> > +
> > +  amlogic,uart-fifosize:
> > +    description: The fifo size supported by the UART channel.
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    enum: [64, 128]
> I personally think this is generic enough to be described as fifo-size
> (as it's done in Documentation/devicetree/bindings/serial/8250.yaml)
> let's wait and hear what Rob thinks

Yes.

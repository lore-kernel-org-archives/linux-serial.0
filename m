Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1F0CC433C1
	for <linux-serial@archiver.kernel.org>; Fri, 26 Mar 2021 01:55:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B753361A46
	for <linux-serial@archiver.kernel.org>; Fri, 26 Mar 2021 01:55:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbhCZBys (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 25 Mar 2021 21:54:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229919AbhCZBy2 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 25 Mar 2021 21:54:28 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E79D9C06174A;
        Thu, 25 Mar 2021 18:54:27 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id e8so3897131iok.5;
        Thu, 25 Mar 2021 18:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vTUCdRdUm0KHkgtUEtfz6t9BK78GKOREEwvml9BKNmw=;
        b=DLLlfab6j71ACe4egQhHoCKHNSUXFaq2XV3tZr6pnstZXPGnFjwfjBLmQpptWWFUs9
         S3QFn1EaVLUOvQ2cEwoc0PBa3sjxIEdOpXayMUgCzwSsWIo3i9L6wLn+ZQrZ4eejxhLq
         hgdEtQ0sN26fB1+dGcbypJ0JdI2qv6+tjhHXJoJAf2+LacRDqmc2PcDH0egOQ6B+UvhB
         4513U7d4hoaWskrKTSuqyst6rTDKbezD7MMDGvDh1ezncek5xgvqZLnstkolo5DdedHx
         8Vft4sIGPE5b8ue/4JplTr8vCLCEJ9uAvodo6LdijBTFlEnSd8PK1aZoHmc9cN85QTJp
         95QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vTUCdRdUm0KHkgtUEtfz6t9BK78GKOREEwvml9BKNmw=;
        b=bodCslytTKw2Kr62/s/4fyjxEieT3zSvJvPLVM5uQsPGNhDhcjC9PnzA/3LLwXBxPg
         jyzSk1JTH+uXyiKD2wxQKmn9kDeBc8OGr/e9Uqq2GYWr8BILGXrnE5zAIKv+I+tzHo7E
         xkWz5Y7z2XdCtfqXPDqjyIqIhQRHChc5QCmbSYUnSLoiPA85i2JsJCuBNGLwP40Jj9y7
         OElEO4nFjHqkQd+qkV8kBRFCnZuJlsXHhXRYRo7mppO/NoMoabB9nIiqL+QK9587FNbo
         uYZZpiBMqm5yDWLLqvIrxayEFQwUW4z+G20rEaGHS6iBiZHIhEndZW7TdiNMJNG0UkJS
         /Vdg==
X-Gm-Message-State: AOAM53209vzO0SZoVSGAhcFEVhvsW5cQk8o4SABEg6SCSI+SBtJYlYrs
        /cbgoS5v9c5Wv9wXpB3RRbvRKNQv40zR2gjkmIM=
X-Google-Smtp-Source: ABdhPJzoHDPPf+f9jNe8NmkUB1RfzN9mrASTzSrBEBN47liOngOdxnFKWcUbuNkSnWm5DIcL9Mgv63QSpQL7pPdMqlY=
X-Received: by 2002:a05:6638:dc3:: with SMTP id m3mr9892355jaj.130.1616723667467;
 Thu, 25 Mar 2021 18:54:27 -0700 (PDT)
MIME-Version: 1.0
References: <1616653162-19954-1-git-send-email-dillon.minfei@gmail.com>
 <1616653162-19954-8-git-send-email-dillon.minfei@gmail.com> <068cb7ae-9afc-606d-2579-189e46516cd5@foss.st.com>
In-Reply-To: <068cb7ae-9afc-606d-2579-189e46516cd5@foss.st.com>
From:   dillon min <dillon.minfei@gmail.com>
Date:   Fri, 26 Mar 2021 09:53:51 +0800
Message-ID: <CAL9mu0JO=HyBmH2UR4HoYUWmdSDLhetVDrBSXoMoc6Edy1JCJw@mail.gmail.com>
Subject: Re: [PATCH v5 9/9] dt-bindings: serial: stm32: Use 'type: object'
 instead of false for 'additionalProperties'
To:     Valentin CARON - foss <valentin.caron@foss.st.com>
Cc:     "robh@kernel.org" <robh@kernel.org>,
        Alexandre TORGUE - foss <alexandre.torgue@foss.st.com>,
        "rong.a.chen@intel.com" <rong.a.chen@intel.com>,
        "a.fatoum@pengutronix.de" <a.fatoum@pengutronix.de>,
        "mcoquelin.stm32@gmail.com" <mcoquelin.stm32@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "vladimir.murzin@arm.com" <vladimir.murzin@arm.com>,
        "afzal.mohd.ma@gmail.com" <afzal.mohd.ma@gmail.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Erwan LE-RAY - foss <erwan.leray@foss.st.com>,
        Erwan LE RAY <erwan.leray@st.com>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "lkp@intel.com" <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi Valentin

On Thu, Mar 25, 2021 at 7:12 PM Valentin CARON - foss
<valentin.caron@foss.st.com> wrote:
>
> Hi Dillon,
>
> It's okay for me.
>
> Regards,
>
> Valentin
Thanks for your test, and quick reply.
>
> On 3/25/21 7:19 AM, dillon.minfei@gmail.com wrote:
> > From: dillon min <dillon.minfei@gmail.com>
> >
> > To use additional properties 'bluetooth' on serial, need replace false with
> > 'type: object' for 'additionalProperties' to make it as a node, else will
> > run into dtbs_check warnings.
> >
> > 'arch/arm/boot/dts/stm32h750i-art-pi.dt.yaml: serial@40004800:
> > 'bluetooth' does not match any of the regexes: 'pinctrl-[0-9]+'
> >
> > Fixes: af1c2d81695b ("dt-bindings: serial: Convert STM32 UART to json-schema")
> > Reported-by: kernel test robot <lkp@intel.com>
> > Tested-by: Valentin Caron <valentin.caron@foss.st.com>
> > Signed-off-by: dillon min <dillon.minfei@gmail.com>
> > ---
> >
> > v5: accroding to rob's suggestion, replace false with 'type: object'
> >      of 'additionalProperties'.
> >
> >   Documentation/devicetree/bindings/serial/st,stm32-uart.yaml | 3 ++-
> >   1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/Documentation/devicetree/bindings/serial/st,stm32-uart.yaml b/Documentation/devicetree/bindings/serial/st,stm32-uart.yaml
> > index 8631678283f9..865be05083c3 100644
> > --- a/Documentation/devicetree/bindings/serial/st,stm32-uart.yaml
> > +++ b/Documentation/devicetree/bindings/serial/st,stm32-uart.yaml
> > @@ -80,7 +80,8 @@ required:
> >     - interrupts
> >     - clocks
> >
> > -additionalProperties: false
> > +additionalProperties:
> > +  type: object
> >
> >   examples:
> >     - |

Return-Path: <SRS0=BKBA=DN=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15FABC41604
	for <linux-serial@archiver.kernel.org>; Tue,  6 Oct 2020 07:07:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B68D52075A
	for <linux-serial@archiver.kernel.org>; Tue,  6 Oct 2020 07:07:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726938AbgJFHHV (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 6 Oct 2020 03:07:21 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:37045 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726761AbgJFHHU (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 6 Oct 2020 03:07:20 -0400
Received: by mail-ot1-f66.google.com with SMTP id o8so11343407otl.4;
        Tue, 06 Oct 2020 00:07:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IEjOVbc5CBTebJ+NkL7ECpC20QOFPXAJ42Fc/c1O0SY=;
        b=NsBMiJCHkO5KL+Nxjj+1B5zTTlxsW5jiVmzATKmuU3jPCBH/9CiTP1nYvbP6CPiBMZ
         CXOQ+AilbQH4OY9/gn1JBgJx724Ra6pDzP09tKdv+BtRNfo6V0MiQoK1V9ZxBRmwX5CN
         TbnW3vb6x6nd+gouYaRKOtXP/FAbL/7FlZfnf8qyz0uljoBIWPib2isBdzHU3kVn3H4Y
         5uBZ1cG5yPN5sDLVu/dRs29oObCj7MlzpOU/m5z7XGkQGi/4z4oMQzYrg7+aaXhek2pV
         qTHV2fdyDTFCrJL/RftGKWkHF5ymB93gWujddHIhvYuYXelvIZ79smPUIp0DmAwMkMNs
         /TbQ==
X-Gm-Message-State: AOAM533E2eswGDbHmIprmCAHQAw6/PsQguc1zQug7UxTzcNUWLdDzh9w
        vCc+0c2XFT6uBn03WAlZog1dyJxqRj/e0PnVljA=
X-Google-Smtp-Source: ABdhPJyft7jjmM62xpHzFa1e5eDyNPLkIH/QmkvSYxRLkEx0Q7fnsMVR9bbUaRLw98zJcYaRRu5dXXCwl0ksw9d4EOk=
X-Received: by 2002:a05:6830:1008:: with SMTP id a8mr1905233otp.107.1601968038374;
 Tue, 06 Oct 2020 00:07:18 -0700 (PDT)
MIME-Version: 1.0
References: <20200923120817.1667149-0-mholenko@antmicro.com>
 <20200923120817.1667149-4-mholenko@antmicro.com> <CAMuHMdXZ4QA4HX8xZJVnnj5P3USpefNn+8OFGz+Yo9T=UpNM4g@mail.gmail.com>
 <CAPk366TrN0AUp8En6Lf4DHfyor22FyitwzK1K3tYBfei1RsYeA@mail.gmail.com>
In-Reply-To: <CAPk366TrN0AUp8En6Lf4DHfyor22FyitwzK1K3tYBfei1RsYeA@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 6 Oct 2020 09:07:07 +0200
Message-ID: <CAMuHMdUWehGyUAq07P3U4U+JNLQaJ=4vbPghOMar39k8fQDf5Q@mail.gmail.com>
Subject: Re: [PATCH v11 4/5] dt-bindings: serial: document LiteUART bindings
To:     Mateusz Holenko <mholenko@antmicro.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Stafford Horne <shorne@gmail.com>,
        Karol Gugala <kgugala@antmicro.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Filip Kokosinski <fkokosinski@antmicro.com>,
        Pawel Czarnecki <pczarnecki@internships.antmicro.com>,
        Joel Stanley <joel@jms.id.au>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Maxime Ripard <mripard@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Sam Ravnborg <sam@ravnborg.org>,
        Icenowy Zheng <icenowy@aosc.io>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Gabriel L. Somlo" <gsomlo@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi Mateusz,

On Tue, Oct 6, 2020 at 9:01 AM Mateusz Holenko <mholenko@antmicro.com> wrote:
> On Fri, Sep 25, 2020 at 3:16 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > On Wed, Sep 23, 2020 at 12:10 PM Mateusz Holenko <mholenko@antmicro.com> wrote:
> > > From: Filip Kokosinski <fkokosinski@antmicro.com>
> > >
> > > Add documentation for LiteUART devicetree bindings.
> > >
> > > Signed-off-by: Filip Kokosinski <fkokosinski@antmicro.com>
> > > Signed-off-by: Mateusz Holenko <mholenko@antmicro.com>
> > > Reviewed-by: Rob Herring <robh@kernel.org>

> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/serial/litex,liteuart.yaml

> > > +properties:
> > > +  compatible:
> > > +    const: litex,liteuart
> >
> > Have you already decided how to handle future LiteUART variants that add
> > new features (e.g. CTS/RTS, DMA)?
>
> We were thinking of adding KConfig options, like
>
> [ ] LiteUART serial port support
> < >     LiteUART DMA support
>
> and using ifdefs in the code.

That is the driver part, not the DT part.
If enabled, the driver still needs to know if the feature is present and
to be used, or not.

> The other option could be to extend LiteX itself so that the UART core
> provides information about its configuration via the capabilities register.
> That way the driver could configure itself automatically at runtime.
>
> This is, however, not decided yet.

A capabilities register sounds good to me.
That means everything is handled automatically by the driver
However, it does mean the DT schema checker cannot validate the
use of optional DT properties related to optional features, if any.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

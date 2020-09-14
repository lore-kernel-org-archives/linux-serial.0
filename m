Return-Path: <SRS0=LhIc=CX=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56F1EC43461
	for <linux-serial@archiver.kernel.org>; Mon, 14 Sep 2020 13:27:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F256206DB
	for <linux-serial@archiver.kernel.org>; Mon, 14 Sep 2020 13:27:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VDGB+o7n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726050AbgINN1a (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 14 Sep 2020 09:27:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726751AbgINNYj (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 14 Sep 2020 09:24:39 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04868C06174A;
        Mon, 14 Sep 2020 06:24:37 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id k14so1172024pgi.9;
        Mon, 14 Sep 2020 06:24:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=UxjCIDPFaDaw0Aevl12WvNq3PRFVzMo2HersEB4khs4=;
        b=VDGB+o7nTwxg8C96CJ13YdC6HV/Nxim8U6l8TQ6xqmyhI++qDovF1C6GhdrBQp7p5x
         EiVnEAN2Iw8yeTTAoZNwc+d4SXn7DVW7wZDQHo2/Eq1XHS64TbH2y+bWPJ/pHur49PWO
         avp2uJlrT1GvcYsi+k/5IYhURpEm5spdbXVloVuv5ltPMMdw6fBXnEv0zUDgsdcKm7Cc
         o2UkGkIFsVribS5rLZDBni0+cfeT1nxCtMhA28sN1r+LLCj+7G6LPshf0LaGRA9/VEL9
         WlW/uVxeZHMSODRs3WIA3XIwDmssry8kE7DAp1k3L2KLpMAVEzJ3ngbUsH8LH1LOkBux
         PcXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UxjCIDPFaDaw0Aevl12WvNq3PRFVzMo2HersEB4khs4=;
        b=clDW7OKlUIWV0B32d2mVF3SXqDSLw8INGjFi0/RLzKOPbB1oNJ2N9b2bz11zXfkzw9
         lBS6XuAt/7YAsQet82pKXmHeOI1XONOdsX2x4ZEauCKYIA1AcUU4S7t03kD7S7ghn2Bb
         96WxJ04Ug32GUe8iTLL8M4PXVPANjLRtqeSVfqt/GHL5v32hSnpPNoijgBM6xRFk5C5P
         ucaNCGUjft5YYagH0WytsJl+61OKiDZvoVb4TheORsok/5mDZ8JnddCCKUz9PFStngC5
         f7DTq2BsrFlh+toOEzGAYlqJCXDbwpYUdwNyd/YuoVrlMv4sr3yj44ZZEt02firUVKsI
         81Mg==
X-Gm-Message-State: AOAM531S7Zx4JutOPYX6O2B7TxI9BVfeuEHHMH99VcCIabLvaba3GzVK
        tnxADdIIc5VrdZzRPNDJrVc6rihcEWL+Vw==
X-Google-Smtp-Source: ABdhPJxXWWq/KN5aAZ1Us02gVvFHuH0VP9PqMtqGuzlCPK3bb4MqeudCDHBMQGWWRbtQUZLauA2U4g==
X-Received: by 2002:a65:6104:: with SMTP id z4mr4006631pgu.184.1600089876464;
        Mon, 14 Sep 2020 06:24:36 -0700 (PDT)
Received: from localhost (g168.115-65-169.ppp.wakwak.ne.jp. [115.65.169.168])
        by smtp.gmail.com with ESMTPSA id y4sm10760351pfr.46.2020.09.14.06.24.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2020 06:24:35 -0700 (PDT)
Date:   Mon, 14 Sep 2020 22:24:33 +0900
From:   Stafford Horne <shorne@gmail.com>
To:     Mateusz Holenko <mholenko@antmicro.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        devicetree <devicetree@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
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
Subject: Re: [PATCH v10 3/5] drivers/soc/litex: add LiteX SoC Controller
 driver
Message-ID: <20200914132433.GB2512402@lianli.shorne-pla.net>
References: <20200812143324.2394375-0-mholenko@antmicro.com>
 <20200812143324.2394375-3-mholenko@antmicro.com>
 <20200911005740.GN3562056@lianli.shorne-pla.net>
 <CAPk366Tvb9g960e3ZLv3+_H8FZJRRe0Jqa4q7tejE+svMcQvLA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPk366Tvb9g960e3ZLv3+_H8FZJRRe0Jqa4q7tejE+svMcQvLA@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, Sep 14, 2020 at 12:33:11PM +0200, Mateusz Holenko wrote:
> On Fri, Sep 11, 2020 at 2:57 AM Stafford Horne <shorne@gmail.com> wrote:
> >
> > On Wed, Aug 12, 2020 at 02:34:34PM +0200, Mateusz Holenko wrote:
> > > From: Pawel Czarnecki <pczarnecki@internships.antmicro.com>
> > >
> > > This commit adds driver for the FPGA-based LiteX SoC
> > > Controller from LiteX SoC builder.
> > >
> > > Co-developed-by: Mateusz Holenko <mholenko@antmicro.com>
> > > Signed-off-by: Mateusz Holenko <mholenko@antmicro.com>
> > > Signed-off-by: Pawel Czarnecki <pczarnecki@internships.antmicro.com>
> > > ---
> > > +     node = dev->of_node;
> > > +     if (!node)
> > > +             return -ENODEV;

We return here without BUG() if the setup fails.

> > > +
> > > +     soc_ctrl_dev = devm_kzalloc(dev, sizeof(*soc_ctrl_dev), GFP_KERNEL);
> > > +     if (!soc_ctrl_dev)
> > > +             return -ENOMEM;

We return here without BUG() if we are out of memory.

> > > +
> > > +     soc_ctrl_dev->base = devm_platform_ioremap_resource(pdev, 0);
> > > +     if (IS_ERR(soc_ctrl_dev->base))
> > > +             return PTR_ERR(soc_ctrl_dev->base);

Etc.

> > > +
> > > +     result = litex_check_csr_access(soc_ctrl_dev->base);
> > > +     if (result) {
> > > +             // LiteX CSRs access is broken which means that
> > > +             // none of LiteX drivers will most probably
> > > +             // operate correctly
> > The comment format here with // is not usually used in the kernel, but its not
> > forbidded.  Could you use the /* */ multiline style?
> 
> Sure, I'll change the commenting style here.
> 
> >
> > > +             BUG();
> > Instead of stopping the system with BUG, could we just do:
> >
> >         return litex_check_csr_access(soc_ctrl_dev->base);
> >
> > We already have failure for NODEV/NOMEM so might as well not call BUG() here
> > too.
> 
> It's true that litex_check_csr_accessors() already generates error
> codes that could be
> returned directly.
> The point of using BUG() macro here, however, is to stop booting the
> system so that it's visible
> (and impossible to miss for the user) that an unresolvable HW issue
> was encountered.
> 
> CSR-accessors - the litex_{g,s}et_reg() functions - are intended to be
> used by other LiteX drivers
> and it's very unlikely that those drivers would work properly after
> the fail of litex_check_csr_accessors().
> Since in such case the UART driver will be affected too (no boot logs
> and error messages visible to the user),
> I thought it'll be easier to spot and debug the problem if the system
> stopped in the BUG loop.
> Perhaps there are other, more linux-friendly, ways of achieving a
> similar goal - I'm open for suggestions.

I see your point, but I thought if failed with an exit status above, we could do
the same here.  But I guess failing here means that something is really wrong as
validation failed.

Some points:
 - If we return here, the system will still boot but there will be no UART
 - If we bail with BUG(), here the system stops, and there is no UART
 - Both cases the user can connect with a debugger and read "dmesg", to see what
   is wrong, but BUG() does not print an error message on all architectures.

We could also use:

 - WARN(1, "Failed to validate CSR registers, the system is probably broken.");

If you want to keep BUG() it may be fine.

I am not an expert on handling these type of bailout's so other input is
appreciated.

-Stafford

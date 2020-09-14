Return-Path: <SRS0=LhIc=CX=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC4FAC43461
	for <linux-serial@archiver.kernel.org>; Mon, 14 Sep 2020 10:33:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 94AF72076C
	for <linux-serial@archiver.kernel.org>; Mon, 14 Sep 2020 10:33:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=antmicro.com header.i=@antmicro.com header.b="fZ+crlcy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726468AbgINKd0 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 14 Sep 2020 06:33:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726409AbgINKdZ (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 14 Sep 2020 06:33:25 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35767C06178A
        for <linux-serial@vger.kernel.org>; Mon, 14 Sep 2020 03:33:25 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id x123so12268537pfc.7
        for <linux-serial@vger.kernel.org>; Mon, 14 Sep 2020 03:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=antmicro.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UrmuUltF9h1wduRxzXusgQVOENqaHZyFRHTcJom8cGE=;
        b=fZ+crlcyyGFSpUt6Evj12OiQCKtFgP1RXE/IdjznGEu25ETYptqXPS3qeYFhxKkofv
         SsjptqfuJBQIaFe0K+hCcxK9fbgdUoKM6jEZYQRCyjo4eb85NXY9gvzSrrgo/QeQZfzo
         dJsgPUEDbGIvYRHRdi35KxR6bEpkmR6/c6Pg8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UrmuUltF9h1wduRxzXusgQVOENqaHZyFRHTcJom8cGE=;
        b=gbPLo7LEMB0CkiJ+S5XdCQaSPvinVPpkQGJt08HJDg7ur4mZwk86ZSog2+kCoTeFiA
         XFAR3ot6BwlZPCyEXi4ds3+apRmF39Ov7F2Qb5pbSCRYhhbhnOSY8u0KZB+M2s9he+Kd
         ei6QyMoRLDfzdv3u8cYs+xfXP4OQYLYbCZAQdlfX6+7AYkYaabjgFAhsUrWTJ9oaKckL
         zPznuKzSc2B82DWBj/FhHfi5v9/nAkaQNOmg27OZLahP7d+rWjO4yuxTMUVt4qZnflgj
         Te3vyTAlB0wvIWc+CTTHl1oNCCLbi2Vr5xwRy7AtB6GOuasF8I8npdE+ymjkmkTTUYM1
         HC7w==
X-Gm-Message-State: AOAM532phsacbg+BRD2LSV3rxbwowlJ46/34JlUa6csDQFiTyW60+cxR
        So+xFz5Ve4AOjpMXT0KnuwNmH1sEg3jFKptKm0gHNQ==
X-Google-Smtp-Source: ABdhPJxyndpwi+ymDmZJ5igPTP5mS4RnYa9l/xUnIZ4zJ3ttCGxOve1JfG0eDClKex/fOhfnpnH+LJY2hgOq/jpHDAE=
X-Received: by 2002:a17:902:988f:b029:d0:4c09:c1 with SMTP id
 s15-20020a170902988fb02900d04c0900c1mr13651699plp.3.1600079604372; Mon, 14
 Sep 2020 03:33:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200812143324.2394375-0-mholenko@antmicro.com>
 <20200812143324.2394375-3-mholenko@antmicro.com> <20200911005740.GN3562056@lianli.shorne-pla.net>
In-Reply-To: <20200911005740.GN3562056@lianli.shorne-pla.net>
From:   Mateusz Holenko <mholenko@antmicro.com>
Date:   Mon, 14 Sep 2020 12:33:11 +0200
Message-ID: <CAPk366Tvb9g960e3ZLv3+_H8FZJRRe0Jqa4q7tejE+svMcQvLA@mail.gmail.com>
Subject: Re: [PATCH v10 3/5] drivers/soc/litex: add LiteX SoC Controller driver
To:     Stafford Horne <shorne@gmail.com>
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
Content-Type: text/plain; charset="UTF-8"
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, Sep 11, 2020 at 2:57 AM Stafford Horne <shorne@gmail.com> wrote:
>
> On Wed, Aug 12, 2020 at 02:34:34PM +0200, Mateusz Holenko wrote:
> > From: Pawel Czarnecki <pczarnecki@internships.antmicro.com>
> >
> > This commit adds driver for the FPGA-based LiteX SoC
> > Controller from LiteX SoC builder.
> >
> > Co-developed-by: Mateusz Holenko <mholenko@antmicro.com>
> > Signed-off-by: Mateusz Holenko <mholenko@antmicro.com>
> > Signed-off-by: Pawel Czarnecki <pczarnecki@internships.antmicro.com>
> > ---
> ...
> > +static int litex_check_csr_access(void __iomem *reg_addr)
> > +{
> > +     unsigned long reg;
> > +
> > +     reg = litex_get_reg(reg_addr + SCRATCH_REG_OFF, SCRATCH_REG_SIZE);
> > +
> > +     if (reg != SCRATCH_REG_VALUE) {
> > +             panic("Scratch register read error! Expected: 0x%x but got: 0x%lx",
> > +                     SCRATCH_REG_VALUE, reg);
> > +             return -EINVAL;
> > +     }
> > +
> > +     litex_set_reg(reg_addr + SCRATCH_REG_OFF,
> > +             SCRATCH_REG_SIZE, SCRATCH_TEST_VALUE);
> > +     reg = litex_get_reg(reg_addr + SCRATCH_REG_OFF, SCRATCH_REG_SIZE);
> > +
> > +     if (reg != SCRATCH_TEST_VALUE) {
> > +             panic("Scratch register write error! Expected: 0x%x but got: 0x%lx",
> > +                     SCRATCH_TEST_VALUE, reg);
> > +             return -EINVAL;
> > +     }
> > +
> > +     /* restore original value of the SCRATCH register */
> > +     litex_set_reg(reg_addr + SCRATCH_REG_OFF,
> > +             SCRATCH_REG_SIZE, SCRATCH_REG_VALUE);
> > +
> > +     /* Set flag for other drivers */
> What does this comment mean?

This is a leftover from the previous version of the patch
and shouldn't be there - sorry for that.
I'll remove it.

> > +     pr_info("LiteX SoC Controller driver initialized");
> > +
> > +     return 0;
> > +}
> > +
> > +struct litex_soc_ctrl_device {
> > +     void __iomem *base;
> > +};
> > +
> > +static const struct of_device_id litex_soc_ctrl_of_match[] = {
> > +     {.compatible = "litex,soc-controller"},
> > +     {},
> > +};
> > +
> > +MODULE_DEVICE_TABLE(of, litex_soc_ctrl_of_match);
> > +
> > +static int litex_soc_ctrl_probe(struct platform_device *pdev)
> > +{
> > +     int result;
> > +     struct device *dev;
> > +     struct device_node *node;
> > +     struct litex_soc_ctrl_device *soc_ctrl_dev;
> > +
> > +     dev = &pdev->dev;
> > +     node = dev->of_node;
> > +     if (!node)
> > +             return -ENODEV;
> > +
> > +     soc_ctrl_dev = devm_kzalloc(dev, sizeof(*soc_ctrl_dev), GFP_KERNEL);
> > +     if (!soc_ctrl_dev)
> > +             return -ENOMEM;
> > +
> > +     soc_ctrl_dev->base = devm_platform_ioremap_resource(pdev, 0);
> > +     if (IS_ERR(soc_ctrl_dev->base))
> > +             return PTR_ERR(soc_ctrl_dev->base);
> > +
> > +     result = litex_check_csr_access(soc_ctrl_dev->base);
> > +     if (result) {
> > +             // LiteX CSRs access is broken which means that
> > +             // none of LiteX drivers will most probably
> > +             // operate correctly
> The comment format here with // is not usually used in the kernel, but its not
> forbidded.  Could you use the /* */ multiline style?

Sure, I'll change the commenting style here.

>
> > +             BUG();
> Instead of stopping the system with BUG, could we just do:
>
>         return litex_check_csr_access(soc_ctrl_dev->base);
>
> We already have failure for NODEV/NOMEM so might as well not call BUG() here
> too.

It's true that litex_check_csr_accessors() already generates error
codes that could be
returned directly.
The point of using BUG() macro here, however, is to stop booting the
system so that it's visible
(and impossible to miss for the user) that an unresolvable HW issue
was encountered.

CSR-accessors - the litex_{g,s}et_reg() functions - are intended to be
used by other LiteX drivers
and it's very unlikely that those drivers would work properly after
the fail of litex_check_csr_accessors().
Since in such case the UART driver will be affected too (no boot logs
and error messages visible to the user),
I thought it'll be easier to spot and debug the problem if the system
stopped in the BUG loop.
Perhaps there are other, more linux-friendly, ways of achieving a
similar goal - I'm open for suggestions.

> > +     }
> > +
> > +     return 0;
> > +}
> > +
>
> Other than that it looks ok to me.
>
> -Stafford

Thanks for the review!

Best,
Mateusz


--
Mateusz Holenko
Antmicro Ltd | www.antmicro.com
Roosevelta 22, 60-829 Poznan, Poland

Return-Path: <SRS0=dMzY=CU=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C66EBC43461
	for <linux-serial@archiver.kernel.org>; Fri, 11 Sep 2020 00:57:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A175208FE
	for <linux-serial@archiver.kernel.org>; Fri, 11 Sep 2020 00:57:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EuJEVcE6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725300AbgIKA5s (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 10 Sep 2020 20:57:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725280AbgIKA5o (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 10 Sep 2020 20:57:44 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC3A9C061573;
        Thu, 10 Sep 2020 17:57:43 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id v196so6052663pfc.1;
        Thu, 10 Sep 2020 17:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=R2a6wOHfd/e4qscCXdPyKaHxfozG0BTqdWLiXXg6DPM=;
        b=EuJEVcE6ZOPnpaptOly5x/fD/oMcyh6TORm1kXU8CJTy+nJkB878hJuocvh7ZYDn8x
         9+AR5ZZPbxvQExn+YdhpT6sjsg1g3TZ9lIz2iS4/38Akd/OUjjvsP+hE2Pua60vuRCOk
         AAB17oc1qVHVhqvGooVAIbs3sS9CgqqdgWas/9CxhWvHNhsFCS4aP5WmRvX9jkm9dEiD
         DL+Qi41CO2oLTrMz3nfJWImQgiHarVG/CVrIWGou0Zg4pH/1dH4GyP5gggaATBR2hvpI
         YdJNfsNoixmRB95lJGAX/Wxwm1ZNWhZXI9LwENEEGzsQaGtFuOWHbgCwRv2nmKixAMrn
         HTzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=R2a6wOHfd/e4qscCXdPyKaHxfozG0BTqdWLiXXg6DPM=;
        b=iGHi6FK7qCquHXOpXkSuJDispaR8GneRahPcre4iFeBtwovx/0YkbWIgxiO++f98jK
         5pHlFhdxa/C5aRH6kBtKR+4V53ZoytHm6B5xVVwNmFwRI7/K41tpeS50nmMJxkShBsu6
         didlNk1N+kgCW+V2wSkifMiFaQzNr7X+g0dmB37AiVtQPFcdWiFLCNQgKagu9HRdUVgJ
         y+geUPiCX01QKZfkrTB+B/bRkOJvhV9TnhTrGS6WG59q+vAKViAHjFt1uhZNBiL+oT37
         fhmF7VnpCCUo0LPWU9dcN6zvYb9GCOy3GVo0Ia/tMi/iXA9ORMzQlsP7b7tovyK9UC0O
         /V6w==
X-Gm-Message-State: AOAM531NB/bEYUZZoO6w71NQ2el/iRnd97eSjB04pAyT7ZTh17zyadUy
        fz3Mzb5aLTvZ4NpXwIwP5sc=
X-Google-Smtp-Source: ABdhPJxoeogjg/rhYbDNCEPwRC1BADT/jUZ6h5wv2ZsP1Ytt29vG0JNjGP18fTr1F7fcVvCMKcYAjw==
X-Received: by 2002:a63:c043:: with SMTP id z3mr7011367pgi.204.1599785863375;
        Thu, 10 Sep 2020 17:57:43 -0700 (PDT)
Received: from localhost (g168.115-65-169.ppp.wakwak.ne.jp. [115.65.169.168])
        by smtp.gmail.com with ESMTPSA id d17sm188575pgn.56.2020.09.10.17.57.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2020 17:57:42 -0700 (PDT)
Date:   Fri, 11 Sep 2020 09:57:40 +0900
From:   Stafford Horne <shorne@gmail.com>
To:     Mateusz Holenko <mholenko@antmicro.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, devicetree@vger.kernel.org,
        linux-serial@vger.kernel.org, Karol Gugala <kgugala@antmicro.com>,
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
        linux-kernel@vger.kernel.org, "Gabriel L. Somlo" <gsomlo@gmail.com>
Subject: Re: [PATCH v10 3/5] drivers/soc/litex: add LiteX SoC Controller
 driver
Message-ID: <20200911005740.GN3562056@lianli.shorne-pla.net>
References: <20200812143324.2394375-0-mholenko@antmicro.com>
 <20200812143324.2394375-3-mholenko@antmicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200812143324.2394375-3-mholenko@antmicro.com>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, Aug 12, 2020 at 02:34:34PM +0200, Mateusz Holenko wrote:
> From: Pawel Czarnecki <pczarnecki@internships.antmicro.com>
> 
> This commit adds driver for the FPGA-based LiteX SoC
> Controller from LiteX SoC builder.
> 
> Co-developed-by: Mateusz Holenko <mholenko@antmicro.com>
> Signed-off-by: Mateusz Holenko <mholenko@antmicro.com>
> Signed-off-by: Pawel Czarnecki <pczarnecki@internships.antmicro.com>
> ---
...
> +static int litex_check_csr_access(void __iomem *reg_addr)
> +{
> +	unsigned long reg;
> +
> +	reg = litex_get_reg(reg_addr + SCRATCH_REG_OFF, SCRATCH_REG_SIZE);
> +
> +	if (reg != SCRATCH_REG_VALUE) {
> +		panic("Scratch register read error! Expected: 0x%x but got: 0x%lx",
> +			SCRATCH_REG_VALUE, reg);
> +		return -EINVAL;
> +	}
> +
> +	litex_set_reg(reg_addr + SCRATCH_REG_OFF,
> +		SCRATCH_REG_SIZE, SCRATCH_TEST_VALUE);
> +	reg = litex_get_reg(reg_addr + SCRATCH_REG_OFF, SCRATCH_REG_SIZE);
> +
> +	if (reg != SCRATCH_TEST_VALUE) {
> +		panic("Scratch register write error! Expected: 0x%x but got: 0x%lx",
> +			SCRATCH_TEST_VALUE, reg);
> +		return -EINVAL;
> +	}
> +
> +	/* restore original value of the SCRATCH register */
> +	litex_set_reg(reg_addr + SCRATCH_REG_OFF,
> +		SCRATCH_REG_SIZE, SCRATCH_REG_VALUE);
> +
> +	/* Set flag for other drivers */
What does this comment mean?

> +	pr_info("LiteX SoC Controller driver initialized");
> +
> +	return 0;
> +}
> +
> +struct litex_soc_ctrl_device {
> +	void __iomem *base;
> +};
> +
> +static const struct of_device_id litex_soc_ctrl_of_match[] = {
> +	{.compatible = "litex,soc-controller"},
> +	{},
> +};
> +
> +MODULE_DEVICE_TABLE(of, litex_soc_ctrl_of_match);
> +
> +static int litex_soc_ctrl_probe(struct platform_device *pdev)
> +{
> +	int result;
> +	struct device *dev;
> +	struct device_node *node;
> +	struct litex_soc_ctrl_device *soc_ctrl_dev;
> +
> +	dev = &pdev->dev;
> +	node = dev->of_node;
> +	if (!node)
> +		return -ENODEV;
> +
> +	soc_ctrl_dev = devm_kzalloc(dev, sizeof(*soc_ctrl_dev), GFP_KERNEL);
> +	if (!soc_ctrl_dev)
> +		return -ENOMEM;
> +
> +	soc_ctrl_dev->base = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(soc_ctrl_dev->base))
> +		return PTR_ERR(soc_ctrl_dev->base);
> +
> +	result = litex_check_csr_access(soc_ctrl_dev->base);
> +	if (result) {
> +		// LiteX CSRs access is broken which means that
> +		// none of LiteX drivers will most probably
> +		// operate correctly
The comment format here with // is not usually used in the kernel, but its not
forbidded.  Could you use the /* */ multiline style?

> +		BUG();
Instead of stopping the system with BUG, could we just do:

	return litex_check_csr_access(soc_ctrl_dev->base);

We already have failure for NODEV/NOMEM so might as well not call BUG() here
too.

> +	}
> +
> +	return 0;
> +}
> +

Other than that it looks ok to me.

-Stafford

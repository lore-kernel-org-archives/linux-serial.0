Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB2CEC4338F
	for <linux-serial@archiver.kernel.org>; Mon, 16 Aug 2021 10:34:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C588661BB4
	for <linux-serial@archiver.kernel.org>; Mon, 16 Aug 2021 10:34:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235598AbhHPKfX (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 16 Aug 2021 06:35:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234197AbhHPKfX (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 16 Aug 2021 06:35:23 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 821A8C061764;
        Mon, 16 Aug 2021 03:34:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=3kYyKZb56SV+F30VdAft4doK9G52E8e9jKzbYuBrKtc=; b=yKIHSAMzSDKH3qF6LtZ5eht1P
        Q+57joyNGoob9U3u1OjI0sKzh9DlRwSXs6UWzhSCFlTJWbAIlTfKsgdScG0nk72WR12y1mSpBHGyp
        fIpa5CA35N6FNJ0wHUi0NjLbL9vLnKqeBfth3kT62z0nftHoKRAAOvdPbY4ocXv9bduwY/jQkYPrm
        etHbBBu2C7M73R+7rJzuJgzns5LgY86O0C5IboMEG2KBAObRRh8u9FMdWgulpqnsDZdqe8qCNgx8n
        B05EG9XvP19SItZL29dl99IYv/Sspfr+CcQ1TtEeW8KCGmj8KWDiBKhFibc/57b9gfE2WMfoedpFB
        lS8SCLArA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:47370)
        by pandora.armlinux.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <linux@armlinux.org.uk>)
        id 1mFZxB-0007h7-2S; Mon, 16 Aug 2021 11:34:49 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1mFZxA-0007uQ-3m; Mon, 16 Aug 2021 11:34:48 +0100
Date:   Mon, 16 Aug 2021 11:34:48 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Bing Fan <hptsfb@gmail.com>, gregkh@linuxfoundation.org,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6] arm pl011 serial: support multi-irq request
Message-ID: <20210816103447.GJ22278@shell.armlinux.org.uk>
References: <1628825490-18937-1-git-send-email-hptsfb@gmail.com>
 <1d691b6b-dbc4-36b0-2e2a-beb95c4c9cb6@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1d691b6b-dbc4-36b0-2e2a-beb95c4c9cb6@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, Aug 13, 2021 at 03:37:16PM +0100, Robin Murphy wrote:
> > +static int pl011_allocate_multi_irqs(struct uart_amba_port *uap)
> > +{
> > +	int ret = 0;
> > +	int i;
> > +	unsigned int virq;
> > +	struct amba_device *amba_dev = container_of(uap->port.dev, struct amba_device, dev);
> > +
> > +	pl011_write(uap->im, uap, REG_IMSC);
> > +
> > +	for (i = 0; i < AMBA_NR_IRQS; i++) {
> 
> It's not clear where these extra IRQs are expected to come from given that
> the DT binding explicitly defines only one :/

The DT binding (and driver) was written assuming that people wouldn't
use the individual interrupts - but I guess someone decided it was a
good idea to have a bazillion interrupt signals going to your interrupt
controller from something as simple as a UART (which is permitted by
the PL011 TRM.) It's only taken about 20 years for this to happen, so
I think we should think we're lucky this hasn't come up before! :D

> > +		virq = amba_dev->irq[i];
> > +		if (virq == 0)
> > +			break;
> > +
> > +		ret = request_irq(virq, pl011_int, IRQF_SHARED, dev_name(&amba_dev->dev), uap);
> 
> Note that using dev_name() here technically breaks user ABI - scripts
> looking in /proc for an irq named "uart-pl011" will no longer find it.
> 
> Furthermore, the "dev" cookie passed to request_irq is supposed to be
> globally unique, which "uap" isn't once you start registering it multiple
> times.

There's no difference there.

First, the "private" used with request_irq() only has to be globally
unique for the interrupt number being requested. Secondly, there is
no way for two UARTs to share the same "uap" structure, and finally
there is a 1:1 model between "uap" and "dev". So, I don't see a problem
as far as whether we use "uap" or "dev" here.

> If firmware did describe all the individual PL011 IRQ outputs on a
> system where they are muxed to the same physical IRQ anyway, you'd end up
> registering ambiguous IRQ actions here. Of course in practice you might
> still get away with that, but it is technically wrong.

Yes. This would also make a total nonsense of using multiple interrupt
lines.

The whole point of using multiple interrupt lines from the UART is so
the interrupt demultiplexing can be handled at the interrupt controller
and their priorities can be decided there. If we adopt a software
structure where we effectively register our "merged" interrupt handler
for all these signals, then there is absolutely no benefit to using
multiple interrupt signals, since that will override any priority, and
we will still have the extra overhead of decoding which interrupt fired
at the UART level.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!

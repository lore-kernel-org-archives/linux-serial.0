Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A35FBC001B0
	for <linux-serial@archiver.kernel.org>; Mon,  7 Aug 2023 15:27:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230113AbjHGP1v (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 7 Aug 2023 11:27:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230157AbjHGP1s (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 7 Aug 2023 11:27:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D296172D;
        Mon,  7 Aug 2023 08:27:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EC47B61E07;
        Mon,  7 Aug 2023 15:27:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04010C433CC;
        Mon,  7 Aug 2023 15:27:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691422061;
        bh=XzO729TDckzqqDQaZRfJn11zZ6fjSuSSMf77v8CcTQ4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xxeGOFzOx6VCkamX30mxg9kMUmRYOD/bav34FkLfmyQg7Qo71hjg5HWVylADZx/Yx
         ZYY/IfDM0l7pqJCER8mwdScgbrJnT60Zsu/2EPvUaH3ZU8yaTBB/4c3lK6AxiJYz4q
         nvBs7u8OcAfmVhEGD1d8snpCM0JptO/vX3VlKRR8=
Date:   Mon, 7 Aug 2023 17:27:38 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Hugo Villeneuve <hugo@hugovil.com>
Cc:     Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] serial: max310x: add comments for membase address
 workaround
Message-ID: <2023080738-headcount-jigsaw-efb7@gregkh>
References: <20230803140551.970141-1-hugo@hugovil.com>
 <2023080417-surname-sizzling-591e@gregkh>
 <20230804101722.7e437a81b2639ccab408d6ba@hugovil.com>
 <20230807112441.c8aa3891cfd6da6b8c65cafc@hugovil.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230807112441.c8aa3891cfd6da6b8c65cafc@hugovil.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, Aug 07, 2023 at 11:24:41AM -0400, Hugo Villeneuve wrote:
> On Fri, 4 Aug 2023 10:17:22 -0400
> Hugo Villeneuve <hugo@hugovil.com> wrote:
> 
> > On Fri, 4 Aug 2023 15:07:50 +0200
> > Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> > 
> > > On Thu, Aug 03, 2023 at 10:05:51AM -0400, Hugo Villeneuve wrote:
> > > > From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> > > > 
> > > > Add comments about workaround used to configure membase address. This
> > > > follows suggestions made during review of a sc16is7xx driver patch to
> > > > add the same workaround.
> > > > 
> > > > Link: https://lore.kernel.org/lkml/2936e18f-44ea-faed-9fa0-2ddefe7c3194@linux.intel.com
> > > > Link: https://lore.kernel.org/lkml/20230801131655.80bd8f97f018dda6155d65f6@hugovil.com/
> > > > Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> > > > ---
> > > >  drivers/tty/serial/max310x.c | 5 +++++
> > > >  1 file changed, 5 insertions(+)
> > > > 
> > > > diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
> > > > index 416d553b73a7..5903dd033fd0 100644
> > > > --- a/drivers/tty/serial/max310x.c
> > > > +++ b/drivers/tty/serial/max310x.c
> > > > @@ -1369,6 +1369,11 @@ static int max310x_probe(struct device *dev, const struct max310x_devtype *devty
> > > >  		s->p[i].port.flags	= UPF_FIXED_TYPE | UPF_LOW_LATENCY;
> > > >  		s->p[i].port.iotype	= UPIO_PORT;
> > > >  		s->p[i].port.iobase	= i;
> > > > +		/*
> > > > +		 * Use all ones as membase to make sure uart_configure_port() in
> > > > +		 * serial_core.c does not abort for SPI/I2C devices where the
> > > > +		 * membase address is not applicable.
> > > > +		 */
> > > >  		s->p[i].port.membase	= (void __iomem *)~0;
> > > >  		s->p[i].port.uartclk	= uartclk;
> > > >  		s->p[i].port.rs485_config = max310x_rs485_config;
> > > > 
> > > > base-commit: 426263d5fb400ccde5444748693dc75bda18f01e
> > > > -- 
> > > > 2.30.2
> > > > 
> > > 
> > > Meta-comment, your email system is not correct and is not able to be
> > > verified as I get the following when attempting to apply your patch:
> > > 
> > > ---
> > >   ✗ [PATCH] serial: max310x: add comments for membase address workaround
> > >   ---
> > >   ✗ BADSIG: DKIM/hugovil.com
> > > 
> > > Please fix up for future submissions.
> > > 
> > > thanks,
> > > 
> > > greg k-h
> > 
> > Hi Greg,
> > I will look into it. Thank you.
> 
> Hi Greg,
> I double-checked my DKIM setup, but everything looks fine. If I send
> emails to gmail or outlook servers, they both report "DKIM
> signature=pass", and I also checked with an online DKIM validation
> service and it is also ok.
> 
> What tool are you using to check the DKIM signature?

The patatt tool as part of `b4`.  I just checked, your direct email to
me here passes, BUT the message you sent to the mailing list did not.
Check it out yourself, look at the message on lore.kernel.org for this
response and see if that passes the DKIM check or not.

thanks,

greg k-h

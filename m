Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE326ECAAD3
	for <linux-serial@archiver.kernel.org>; Wed, 14 Sep 2022 14:57:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbiINO50 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 14 Sep 2022 10:57:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbiINO5Z (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 14 Sep 2022 10:57:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52A9667142
        for <linux-serial@vger.kernel.org>; Wed, 14 Sep 2022 07:57:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E29E061E3A
        for <linux-serial@vger.kernel.org>; Wed, 14 Sep 2022 14:57:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B25F6C433D6;
        Wed, 14 Sep 2022 14:57:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1663167443;
        bh=AWyx+RKW4uIFLPgxQUoEY0iU/A++Q6X+kQuZMgWB3kg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=l55csl88IV1YiH9J0l4QB45iaqeHZnSqzcDullc7L+6aFZpH17hATJaImwvuLWQvc
         QBARFPNregOWc0zjvrIctHxrDVVvgOT8XoexUvMoJtAxrHqQpZ68Poi8QwTnQPDFg1
         3UgxZb/O0pItiLG43+pK3juJLl+hTlIO+KcTvWeQ=
Date:   Wed, 14 Sep 2022 16:57:47 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc:     Anders Blomdell <anders.blomdell@control.lth.se>,
        Pavel Machek <pavel@ucw.cz>, linux-serial@vger.kernel.org
Subject: Re: kernel 5.19.8: "Oxford Semiconductor Ltd OXPCIe952 Dual Native
 950 UART" gets wrong baudrate (PCI ID 1415:c158)
Message-ID: <YyHr6wD8F8KxyK5m@kroah.com>
References: <YyB4AtFJx++PeA6S@kroah.com>
 <7a99a59e-838d-c9da-6ead-167398642c07@control.lth.se>
 <YyCNOV9no9NPwv8m@kroah.com>
 <e9ca9267-dfee-c7b0-f1ec-4d2b76a05991@control.lth.se>
 <alpine.DEB.2.21.2209131638550.60554@angie.orcam.me.uk>
 <3f2d2863-96dd-05d2-4d88-55666fe37bf8@control.lth.se>
 <alpine.DEB.2.21.2209132254150.60554@angie.orcam.me.uk>
 <5921dfd6-384e-b663-f0f7-8471b9e88c29@control.lth.se>
 <alpine.DEB.2.21.2209141224370.60554@angie.orcam.me.uk>
 <alpine.DEB.2.21.2209141456460.60554@angie.orcam.me.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.2209141456460.60554@angie.orcam.me.uk>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, Sep 14, 2022 at 03:15:52PM +0100, Maciej W. Rozycki wrote:
> On Wed, 14 Sep 2022, Maciej W. Rozycki wrote:
> 
> > I'll examine your I/O conversation log in detail and will see if I can 
> > come up with a possible explanation.
> 
>  I think I know what is going on here.  Can you please confirm that you 
> have the CONFIG_SERIAL_8250_16550A_VARIANTS option disabled (default to 
> "off" for x86 only)?  That would explain things.
> 
>  Offhand I am not sure what to do here.  There are several options to 
> choose from I can think of right now:
> 
> 1. Disable new OxSemi Tornado clock code iff !SERIAL_8250_16550A_VARIANTS, 
>    bringing back buggy calculation for rates above 115200bps and coarse 
>    BOTHER granularity.
> 
> 2. Same as above, but additionally limit the baud rates to 115200bps to 
>    avoid buggy rates.

Maybe this one?  That feels odd that we do different things for this old
config option, that's not good.  So making this "just work" should be
the best idea if at all possible.

> 
> 3. Force SERIAL_8250_16550A_VARIANTS to "y" if SERIAL_8250_PCI != "n". 
> 
> 4. Remove SERIAL_8250_16550A_VARIANTS altogether and execute code it 
>    guards unconditionally (does it still matter nowadays?).
> 
> 5. Something else not yet determined.

We can't just remove it, as for x86 the default is disabled due to this
only being relevant for very old hardware.

thanks,

greg k-h

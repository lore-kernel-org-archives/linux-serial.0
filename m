Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 221AFC5519F
	for <linux-serial@archiver.kernel.org>; Wed, 25 Nov 2020 08:53:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1C37208CA
	for <linux-serial@archiver.kernel.org>; Wed, 25 Nov 2020 08:53:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="M8B3NZCP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726158AbgKYIxX (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 25 Nov 2020 03:53:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:33936 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725792AbgKYIxX (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 25 Nov 2020 03:53:23 -0500
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A5FD920637;
        Wed, 25 Nov 2020 08:53:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1606294402;
        bh=DUl4uQk9WyVoQt3BkJklLBswmz/Pv2eOmnwwLH8EQlw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=M8B3NZCPx2B/vqatY9UBe3KEdxCuELFnFFNtBbfdAZSEwsjNr2KYWvRg0aDUC1oVE
         DLlHQ9CcBAFYJ6GzGcLeVrjZUvdwuaA+cfDlk+OSYyeKuqsxlfdev3BX5jnAoloh/g
         H5yoYXo/m5QEXtTFXPSn4tteWGMG7UfbJQruG5HE=
Date:   Wed, 25 Nov 2020 09:54:29 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc:     Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org,
        Hauke Mehrtens <hauke@hauke-m.de>,
        bcm-kernel-feedback-list@broadcom.com,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Subject: Re: [PATCH] tty: serial: bcm63xx: allow building on ARM64
Message-ID: <X74bxfji0uTZV8y9@kroah.com>
References: <20201125081352.25409-1-zajec5@gmail.com>
 <X74Uanu26sx4Hait@kroah.com>
 <6b107933-9ab1-7c46-c383-ed39b71b4ecb@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6b107933-9ab1-7c46-c383-ed39b71b4ecb@gmail.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, Nov 25, 2020 at 09:38:50AM +0100, Rafał Miłecki wrote:
> On 25.11.2020 09:23, Greg Kroah-Hartman wrote:
> > On Wed, Nov 25, 2020 at 09:13:52AM +0100, Rafał Miłecki wrote:
> > > From: Rafał Miłecki <rafal@milecki.pl>
> > > 
> > > Hardware supported by bcm63xx is also used by BCM4908 SoCs family that
> > > is ARM64.
> > > 
> > > Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
> > > ---
> > >   drivers/tty/serial/Kconfig | 3 ++-
> > >   1 file changed, 2 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
> > > index 28f22e58639c..6907c5b17a0e 100644
> > > --- a/drivers/tty/serial/Kconfig
> > > +++ b/drivers/tty/serial/Kconfig
> > > @@ -1133,7 +1133,8 @@ config SERIAL_TIMBERDALE
> > >   config SERIAL_BCM63XX
> > >   	tristate "Broadcom BCM63xx/BCM33xx UART support"
> > >   	select SERIAL_CORE
> > > -	depends on MIPS || ARM || COMPILE_TEST
> > > +	depends on MIPS || ARM || ARM64 || COMPILE_TEST
> > 
> > Why do we have an arch dependancy at all now?
> 
> From my experience "depends" is often used to limit symbol visibility to
> applicable platforms only. I don't think Broadcom has any x86, risc, etc.
> platforms so it's useless there.
> 
> As for testing driver compilation on unused arch-s I thought that's what
> COMPILE_TEST is for.
> 
> Am I wrong there? I'm afraid we don't have clear Documentation on that.
> Please kindly point me to some info if I'm wrong.

If COMPILE_TEST is working for this driver, then trying to restrict it
to a specific arch is usually pointless and the arch dependency can be
removed, keeping patches like this from having to be made over time to
add it to new arches :)

> > > +	default ARCH_BCM4908
> > 
> > Really?  I thought we were getting rid of these "ARCH_platform_type" of
> > things.  That's what a defconfig file is for, right?
> 
> I had to miss something, last time I checked Linus called defconfigs a
> garbage and wanted to get rid of them:
> https://lwn.net/Articles/391372/
> 
> There are also no platform defconfigs in arch/arm64/ at all. Should I
> handle it with arch/arm64/Kconfig.platforms and "select SERIAL_BCM63XX"?

I thought we were trying to get rid of arm64 "platforms" as well.  My
point being, why is this needed at all?

thanks,

greg k-h

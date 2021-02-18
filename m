Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69629C433DB
	for <linux-serial@archiver.kernel.org>; Thu, 18 Feb 2021 08:11:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1EC8D64E68
	for <linux-serial@archiver.kernel.org>; Thu, 18 Feb 2021 08:11:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230306AbhBRILA (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 18 Feb 2021 03:11:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:42462 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231419AbhBRIIi (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 18 Feb 2021 03:08:38 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2E38764DE9;
        Thu, 18 Feb 2021 08:07:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1613635674;
        bh=dDLRi1y42gMPNm2n3QtzXA3mGmPiMWvagjUX2xeep/c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2TbbycayOCp9VzxAgrFDhyDrTphx0oPWrgu4TO1ITeAHjo8KhD+lQO1PIwjb4Esyr
         1Y4pJ7yh6woY8vi+4QD4B2p+Nyfmi5Tp4IbVrBmrzBhXvovJXxEfzLLOLivRsEXjmp
         2X8tkCs5Cwbv7eHaAHwRDIoMAZd4vdcH4C9srWjY=
Date:   Thu, 18 Feb 2021 09:07:52 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Cc:     Alexander Shiyan <shc_work@mail.ru>, linux-serial@vger.kernel.org,
        Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH] Revert "serial: max310x: rework RX interrupt handling"
Message-ID: <YC4gWOlwAkjBz+qf@kroah.com>
References: <20210217080608.31192-1-shc_work@mail.ru>
 <20210217235345.7326201b@windsurf.home>
 <20210218065553.864bbf0cc2b3d398504c5b95@mail.ru>
 <20210218075127.5023d878@windsurf.home>
 <YC4TJQew3QK4iPvP@kroah.com>
 <20210218082051.648b8122@windsurf.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210218082051.648b8122@windsurf.home>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, Feb 18, 2021 at 08:20:51AM +0100, Thomas Petazzoni wrote:
> Hello Greg,
> 
> On Thu, 18 Feb 2021 08:11:33 +0100
> Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> 
> > What aspects need configuring and why is this uart so unique from all
> > others that it can't use the normal configuration methods?
> 
> What makes is stand out from other UARTs is that it is over SPI. So
> accessing every single register of the UART is much more expensive than
> with UART controllers on MMIO.
> 
> As explained in commit fce3c5c1a2d9cd888f2987662ce17c0c651916b2, in its
> original state, the driver was configuring the UART to get an interrupt
> for every single byte being received, causing a huge CPU load (25% in
> my use case) for a very simple workload that consists in receiving 20
> bytes every 16ms.
> 
> What fce3c5c1a2d9cd888f2987662ce17c0c651916b2 does it to configure the
> UART controller to not interrupt at every byte being received, but only
> when the RX FIFO has reached a certain threshold *or* after some time
> without receiving data. Clearly, this is trading throughput against
> latency.
> 
> So what needs to be configured are two aspects:
> 
>  * How many bytes the UART will receive before triggering an interrupt
>    and delivering data to the TTY layer/userspace.

Odds are, this is already an ioctl for the tty layer given that this
seems like a common thing even for "normal" uarts.  Has anyone looked?

>  * How much time with no data received before the UART triggers and
>    interrupt, and received data is delivered to the TTY layer/userspace.

Again, that should already be an option we support, if not, I would be
surprised.  I don't have the time to dig through the
kernel/documentation at the moment, but if someone that cares about this
can, I would appreciate it :)

thanks,

greg k-h

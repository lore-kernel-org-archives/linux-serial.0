Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28624C48BDF
	for <linux-serial@archiver.kernel.org>; Tue, 15 Jun 2021 15:54:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1516861476
	for <linux-serial@archiver.kernel.org>; Tue, 15 Jun 2021 15:54:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232464AbhFOP5A (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 15 Jun 2021 11:57:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:47178 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232487AbhFOPyy (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 15 Jun 2021 11:54:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 91927616E8;
        Tue, 15 Jun 2021 15:52:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1623772328;
        bh=X4/fijOZ9/3izQDc5j7ytcyZyRdhEKKqy9AOwSlb6EU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jRN0TvT2KSWnReJoT7pjBtahAe020jdM+lSTmN2gk+ZclELca/kx6tgE7QTbC1oar
         5YqbrvUxbfowngIDAE6+0UZ46/3Fesq3sHK3s0ML8NZHKuOt9N8fIZhbT0Yq6WL6i8
         rzP2zDQeKbMhoP1Zos8p7sL3hXXqIzLaqJDeXXqA=
Date:   Tue, 15 Jun 2021 17:52:05 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc:     Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] serial: 8250: Fixes for Oxford Semiconductor 950
 UARTs
Message-ID: <YMjMpQtLeP3xceYR@kroah.com>
References: <alpine.DEB.2.21.2106071700090.1601@angie.orcam.me.uk>
 <YMiX7LAEtL0uQuVl@kroah.com>
 <alpine.DEB.2.21.2106151602120.61948@angie.orcam.me.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <alpine.DEB.2.21.2106151602120.61948@angie.orcam.me.uk>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Jun 15, 2021 at 04:19:03PM +0200, Maciej W. Rozycki wrote:
> On Tue, 15 Jun 2021, Greg Kroah-Hartman wrote:
> 
> > This patch series causes the following build warning to be added:
> > 
> > drivers/tty/serial/8250/8250_pci.c: In function ‘pci_oxsemi_tornado_setup’:
> > drivers/tty/serial/8250/8250_pci.c:1258:32: warning: unsigned conversion from ‘int’ to ‘unsigned char’ changes value from ‘-129’ to ‘127’ [-Woverflow]
> >  1258 |                 up->mcr_mask = ~UART_MCR_CLKSEL;
> >       |                                ^
> > 
> > 
> > Can you fix this up and resend?
> 
>  I've seen that, but that's not a problem with my change, but rather with 
> <linux/serial_reg.h> making this macro (and the remaining ones from this 
> group) expand to a signed constant (0x80 rather than 0x80u).

As your change causes it to show up, it must have something to do with
it :)

>  I can fix the header, but that would be a separate change, and mind too 
> that this is a user header, so it's not clear to me what the impact might 
> be on user apps making use of it.

You can not change the uapi header, why would you want to?

>  We could use a GCC pragma to suppress the warning temporarily across this 
> piece of code, but it's not clear to me either what our policy has been on 
> such approach.

What pragma?

>  Thoughts?

Why does your change cause this to show up?

>  NB casting UART_MCR_CLKSEL here to an unsigned type does not help as GCC
> still sees the original constant through the cast; I've already tried that 
> of course.
> 
>  Last but not least: do we need to have this warning enabled in the first 
> place?

No idea, but that's a different discussion, with a different group of
people :)

thanks,

greg k-h

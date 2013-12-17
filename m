From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] serial: pl011: also enable DMA Rx polling with no
 platform data
Date: Tue, 17 Dec 2013 09:34:14 -0800
Message-ID: <20131217173414.GB15633@kroah.com>
References: <1385631664-32607-1-git-send-email-linus.walleij@linaro.org>
 <Pine.LNX.4.64.1312091229550.30018@axis700.grange>
 <Pine.LNX.4.64.1312120923160.32185@axis700.grange>
 <CACRpkdZ2n64EnVaB81bo578jmMzmW+OMGjehVTO=7Pa1zBGAvA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:53536 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754318Ab3LQReO (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 17 Dec 2013 12:34:14 -0500
Content-Disposition: inline
In-Reply-To: <CACRpkdZ2n64EnVaB81bo578jmMzmW+OMGjehVTO=7Pa1zBGAvA@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Jongsung Kim <neidhard.kim@lge.com>, Chanho Min <chanho.min@lge.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Russell King <rmk+kernel@arm.linux.org.uk>, Phil Edworthy <phil@edworthys.org>

On Thu, Dec 12, 2013 at 02:24:37PM +0100, Linus Walleij wrote:
> On Thu, Dec 12, 2013 at 10:18 AM, Guennadi Liakhovetski
> <g.liakhovetski@gmx.de> wrote:
> 
> > An addendum to this patch, that might well lead to dropping it and,
> > possibly, doing the opposite - removing the DMA Rx polling completely.
> 
> I agree with your reasoning, but not with dropping the Rx code
> altogether. However we should also drop my patch so we restore
> the opt-in-only characteristic until we can rootcause this.
> 
> Greg can you please drop or revert
> commit 17438217a6f5e33d920ed3821a4b857311cc2872
> "serial: pl011: use DMA RX polling by default"
> from the TTY tree until this has been sorted out?

Now reverted.

thanks,

greg k-h

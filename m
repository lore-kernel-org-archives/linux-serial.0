From: Greg Kroah-Hartman <greg@kroah.com>
Subject: Re: Serial: Add support for new devices: Exar's XR17V35x family of
 multi-port PCIe UARTs
Date: Sun, 25 Nov 2012 18:22:22 -0800
Message-ID: <20121126022222.GA5046@kroah.com>
References: <CAJp1Oe4Xh6SDQc43hue5qanm7G5Lw9vMdv-+5nRQ_S+RPpRALQ@mail.gmail.com>
 <CAJp1Oe4vSwBgVe_bOV00ojvYy2fd7YWNfrEfJ+de_JSiyb7AHA@mail.gmail.com>
 <20121121233737.GA8964@kroah.com>
 <CAJp1Oe5yS2MOfCpMs3=_DnQ5Jo1mUwhO0rSBSd9oNynSBRCPtQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:40624 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753124Ab2KZCU7 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sun, 25 Nov 2012 21:20:59 -0500
Content-Disposition: inline
In-Reply-To: <CAJp1Oe5yS2MOfCpMs3=_DnQ5Jo1mUwhO0rSBSd9oNynSBRCPtQ@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Matt Schulte <matts@commtech-fastcom.com>
Cc: linux-serial@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>, Theodore Ts'o <tytso@mit.edu>

On Sun, Nov 25, 2012 at 06:54:11PM -0600, Matt Schulte wrote:
> On Wed, Nov 21, 2012 at 5:37 PM, Greg Kroah-Hartman <greg@kroah.com> wrote:
> > On Mon, Nov 19, 2012 at 09:12:04AM -0600, Matt Schulte wrote:
> >> Add support for new devices: Exar's XR17V35x family of multi-port PCIe UARTs.
> >>
> >> Built against tty-next 54d5f88f25c38e5500a17b16240cb3775af00876
> >
> > This patch was line-wrapped, and I had to hand-edit it to get it to
> > apply.  Next time, please fix your email client to not do that.
> >
> 
> Sorry about that, don't know why that last one line-wrapped and the rest didn't.

The others did to, I edited them by hand :)

greg k-h
